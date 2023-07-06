library(tidyverse)
library(dplyr)
library(plyr)
library(vroom)
library(janitor)

df1 <- vroom("test2_meta_2023_06_22.csv", delim = ",", na = c("-", "NA"))
head(df1)

df2 <- vroom("enrolled_meta_with_ID.csv", delim = ",", na = c("-", "NA"))
head(df2)

combdf <- rbind.fill(df1, df2)
head(combdf)
comb_no_NA <- combdf |> mutate_if(is.numeric, funs(ifelse(is.na(.), 0, .)))



####   read in a SciVal-produced csv file, removing blank header lines and an extraneous column (Tags), 
####.  rename variable, remove extra column at end, and separate last and first names into two variables

df3 <- vroom("papers_enrolled_raw.csv", skip = 13, col_select = -...3) |> 
  dplyr::rename(id = ...2) |> 
  select(!last_col()) |>
  separate_wider_delim(...1, delim = ",", names = c("author", "first"))

head(df3)
