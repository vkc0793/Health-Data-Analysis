
/* ----------------------------------------------------'OCD Patients Health Data Analysis'---------------------------------------------------------- */

SELECT * FROM `ocd_health_data`.`ocd_patient_dataset`;

-- 1) count & pct of females vs males that have OCD ?
with data as (
select gender, 
count('patient ID') as patient_count
from ocd_patient_dataset
group by 1
order by 2
)

select 
sum(case when Gender = 'Female' then patient_count else 0 end) as count_female,
sum( case when Gender = 'Male' then patient_count else 0 end ) as count_male,

round(sum(case when Gender = 'Female' then patient_count else 0 end) /
(sum(case when Gender = 'Female' then patient_count else 0 end) +sum( case when Gender = 'Male' then patient_count else 0 end)) * 100,2) as pct_female,

round(sum(case when Gender = 'Male' then patient_count else 0 end) /
(sum(case when Gender = 'Female' then patient_count else 0 end) +sum( case when Gender = 'Male' then patient_count else 0 end)) * 100,2) as pct_male
 from data;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------

-- 2) count of patients by ethnicity and their respective  average obsession score ?

select 
Ethnicity,
count('patient_ID') as patient_count,
avg(`Y-BOCS Score (Obsessions)`) as obs_score
from `ocd_health_data`.`ocd_patient_dataset`
group by 1
order by 2;

-- -----------------------------------------------------------------------------------------------------------------------------------------------------

-- 3) no.of peoples dignosed with OCD MoM?

alter table `ocd_health_data`.`ocd_patient_dataset`
modify `OCD Diagnosis Date` date; 

select
date_format(`OCD Diagnosis Date`, '%Y-%m-01 00:00:00') as month,
count('Patirnt_ID') as patient_cnt
from ocd_patient_dataset
group by 1
order by 2 desc;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------

-- 4) what is the most common obsession type and it's respective average obsession score ?

select
`Obsession Type`,
count('Patient ID') as patient_cnt,
avg(`Y-BOCS Score (Obsessions)`) as obs_score
from `ocd_health_data`.`ocd_patient_dataset`
group by 1
order by 2 desc;

-- -----------------------------------------------------------------------------------------------------------------------------------------------------
-- 5) what is the most common complusion type and its respective average complusion score ?

select
`Compulsion Type`,
count('Patient ID') as patient_cnt,
avg(`Y-BOCS Score (Compulsions)`) as obs_score
from `ocd_health_data`.`ocd_patient_dataset`
group by 1
order by 2 desc;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- 6) what is the average, maximun and minimum Y-BOCS Score (Obsessions) ?

select
avg(`Y-BOCS Score (Obsessions)`) as avg_obs_score,
max(`Y-BOCS Score (Obsessions)`) as max_obs_score,
min(`Y-BOCS Score (Obsessions)`) as min_obs_score
from `ocd_health_data`.`ocd_patient_dataset`
;

-- ---------------------------------------------------------------------------------------------------------------------------------------------------

-- 7) what is the average, maximum and minimum Y-BOCS Score (Compulsions) ?

select
avg(`Y-BOCS Score (Compulsions)`) as avg_obs_score,
max(`Y-BOCS Score (Compulsions)`) as max_obs_score,
min(`Y-BOCS Score (Compulsions)`) as min_obs_score
from `ocd_health_data`.`ocd_patient_dataset`
;

-- -----------------------------------------------------------------------------------------------------------------------------------------------------
 -- 8) The average Y-BOCS scores for obsessions and compulsions separately, comparing patients with and without a family history of OCD with no of patients ?

select `Family History of OCD`, count(`Patient ID`) as patients_cnt,
 avg(`Y-BOCS Score (Compulsions)`) as avg_comp_score,
 avg(`Y-BOCS Score (Obsessions)`) as avg_obs_score
 from ocd_patient_dataset
group by 1;


-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 9) The average Y-BOCS scores for obsessions and compulsions separately, comparing with age along with no.of patients ?

select 
* from ocd_patient_dataset;

select 
	CASE
        WHEN age BETWEEN 18 AND 30 THEN 'Young Adults'
        WHEN age BETWEEN 31 AND 45 THEN 'Adults'
        WHEN age BETWEEN 46 AND 60 THEN 'Middle-aged'
        WHEN age BETWEEN 61 AND 75 THEN 'Senior Adults'
        ELSE 'Other'
    END AS age_group,
count('Patient ID') as patient_count,
avg(`Y-BOCS Score (Compulsions)`) as avg_comp_score,
avg(`Y-BOCS Score (Obsessions)`) as avg_obs_score
from ocd_patient_dataset
group by 1;


-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 10) Commpare depression with Y-BOCS scores for obsessions and compulsions separately along with patient count?

select 
`Depression Diagnosis`, 
count(`Patient ID`) as patients_cnt,
avg(`Y-BOCS Score (Compulsions)`) as avg_comp_score,
avg(`Y-BOCS Score (Obsessions)`) as avg_obs_score
from ocd_patient_dataset
group by 1;

-- ---------------------------------------------------------------------------------------------------------------------------------------------------

-- 11) Commpare anxiety with Y-BOCS scores for obsessions and compulsions separately along with patient count?

select 
`Anxiety Diagnosis`, 
count(`Patient ID`) as patients_cnt,
avg(`Y-BOCS Score (Compulsions)`) as avg_comp_score,
avg(`Y-BOCS Score (Obsessions)`) as avg_obs_score
from ocd_patient_dataset
group by 1;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------

-- 12) show the medications for obsession type ?

select `Obsession Type`,
group_concat(distinct(Medications) separator ',') as medications
from ocd_patient_dataset
group by 1;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------

-- 13) show the medications for complusion type ?

select `Compulsion Type`,
group_concat(distinct(Medications) separator ',') as medications
from ocd_patient_dataset
group by 1;

-- ---------------------------------------------------------------------------------------------------------------------------------------------------

-- 14) write a query to show average duration of symptoms with respect to obsession type?

select
`Obsession Type`,
ceil(avg(`Duration of Symptoms (months)`)) as avg_duration_of_symp
from ocd_patient_dataset
group by 1; 

-- -----------------------------------------------------------------------------------------------------------------------------------------------------
-- 15) write a query to show average duration of symptoms with respect to obsession type?

select
`Compulsion Type`,
ceil(avg(`Duration of Symptoms (months)`)) as avg_duration_of_symp
from ocd_patient_dataset
group by 1; 

-- -------------------------------------------------------------------------------------------------------------------------------------------------------

-- 16) write a query to display no of patients having previous diagnosis?

select 
`Previous Diagnoses`,
count(`Patient ID`) as patient_cnt,
avg(`Y-BOCS Score (Compulsions)`) as avg_comp_score,
avg(`Y-BOCS Score (Obsessions)`) as avg_obs_score
from ocd_patient_dataset
group by 1;

