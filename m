Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35A5A59ECA9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 21:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbiHWToo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 15:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233355AbiHWToV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 15:44:21 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6B4FFB274E;
        Tue, 23 Aug 2022 11:46:47 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E8636113E;
        Tue, 23 Aug 2022 11:46:50 -0700 (PDT)
Received: from [192.168.122.164] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CC8763F718;
        Tue, 23 Aug 2022 11:46:46 -0700 (PDT)
Message-ID: <cbbc3156-507c-9b88-06b9-c1e7bda50c32@arm.com>
Date:   Tue, 23 Aug 2022 13:46:45 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v3 1/2] ACPI: CPPC: Disable FIE if registers in PCC
 regions
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.or>,
        Len Brown <lenb@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Robert Moore <robert.moore@intel.com>,
        Punit Agrawal <punit.agrawal@bytedance.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Pierre Gondois <pierre.gondois@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Linux PM <linux-pm@vger.kernel.org>
References: <20220818211619.4193362-1-jeremy.linton@arm.com>
 <20220818211619.4193362-2-jeremy.linton@arm.com>
 <CAJZ5v0h7s0WnyBtwuQbTZXwq+jmYDF74gjc9-c-=Krt23KgF1w@mail.gmail.com>
From:   Jeremy Linton <jeremy.linton@arm.com>
In-Reply-To: <CAJZ5v0h7s0WnyBtwuQbTZXwq+jmYDF74gjc9-c-=Krt23KgF1w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/23/22 12:10, Rafael J. Wysocki wrote:
> On Thu, Aug 18, 2022 at 11:24 PM Jeremy Linton <jeremy.linton@arm.com> wrote:
>>
>> PCC regions utilize a mailbox to set/retrieve register values used by
>> the CPPC code. This is fine as long as the operations are
>> infrequent. With the FIE code enabled though the overhead can range
>> from 2-11% of system CPU overhead (ex: as measured by top) on Arm
>> based machines.
>>
>> So, before enabling FIE assure none of the registers used by
>> cppc_get_perf_ctrs() are in the PCC region. Furthermore lets also
>> enable a module parameter which can also disable it at boot or module
>> reload.
>>
>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>> ---
>>   drivers/acpi/cppc_acpi.c       | 41 ++++++++++++++++++++++++++++++++++
>>   drivers/cpufreq/cppc_cpufreq.c | 31 +++++++++++++++++++++----
>>   include/acpi/cppc_acpi.h       |  5 +++++
>>   3 files changed, 73 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>> index 1e15a9f25ae9..c840bf606b30 100644
>> --- a/drivers/acpi/cppc_acpi.c
>> +++ b/drivers/acpi/cppc_acpi.c
>> @@ -1240,6 +1240,47 @@ int cppc_get_perf_caps(int cpunum, struct cppc_perf_caps *perf_caps)
>>   }
>>   EXPORT_SYMBOL_GPL(cppc_get_perf_caps);
>>
>> +/**
>> + * cppc_perf_ctrs_in_pcc - Check if any perf counters are in a PCC region.
>> + *
>> + * CPPC has flexibility about how counters describing CPU perf are delivered.
> 
> "CPU performance counters are accessed"

Sure,

> 
> 
>> + * One of the choices is PCC regions, which can have a high access latency. This
>> + * routine allows callers of cppc_get_perf_ctrs() to know this ahead of time.
>> + *
>> + * Return: true if any of the counters are in PCC regions, false otherwise
>> + */
>> +bool cppc_perf_ctrs_in_pcc(void)
>> +{
>> +       int cpu;
>> +
>> +       for_each_present_cpu(cpu) {
>> +               struct cpc_register_resource *ref_perf_reg;
>> +               struct cpc_desc *cpc_desc;
>> +
>> +               cpc_desc = per_cpu(cpc_desc_ptr, cpu);
>> +
>> +               if (CPC_IN_PCC(&cpc_desc->cpc_regs[DELIVERED_CTR]) ||
>> +                   CPC_IN_PCC(&cpc_desc->cpc_regs[REFERENCE_CTR]) ||
>> +                   CPC_IN_PCC(&cpc_desc->cpc_regs[CTR_WRAP_TIME]))
>> +                       return true;
>> +
>> +
>> +               ref_perf_reg = &cpc_desc->cpc_regs[REFERENCE_PERF];
>> +
>> +               /*
>> +                * If reference perf register is not supported then we should
>> +                * use the nominal perf value
>> +                */
>> +               if (!CPC_SUPPORTED(ref_perf_reg))
>> +                       ref_perf_reg = &cpc_desc->cpc_regs[NOMINAL_PERF];
>> +
>> +               if (CPC_IN_PCC(ref_perf_reg))
>> +                       return true;
>> +       }
>> +       return false;
>> +}
>> +EXPORT_SYMBOL_GPL(cppc_perf_ctrs_in_pcc);
>> +
>>   /**
>>    * cppc_get_perf_ctrs - Read a CPU's performance feedback counters.
>>    * @cpunum: CPU from which to read counters.
>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>> index 24eaf0ec344d..32fcb0bf74a4 100644
>> --- a/drivers/cpufreq/cppc_cpufreq.c
>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>> @@ -63,7 +63,15 @@ static struct cppc_workaround_oem_info wa_info[] = {
>>
>>   static struct cpufreq_driver cppc_cpufreq_driver;
>>
>> +static enum {
>> +       FIE_UNSET = -1,
>> +       FIE_ENABLED,
>> +       FIE_DISABLED
>> +} fie_disabled = FIE_UNSET;
>> +
>>   #ifdef CONFIG_ACPI_CPPC_CPUFREQ_FIE
>> +module_param(fie_disabled, int, 0444);
>> +MODULE_PARM_DESC(fie_disabled, "Disable Frequency Invariance Engine (FIE)");
>>
>>   /* Frequency invariance support */
>>   struct cppc_freq_invariance {
>> @@ -158,7 +166,7 @@ static void cppc_cpufreq_cpu_fie_init(struct cpufreq_policy *policy)
>>          struct cppc_freq_invariance *cppc_fi;
>>          int cpu, ret;
>>
>> -       if (cppc_cpufreq_driver.get == hisi_cppc_cpufreq_get_rate)
>> +       if (fie_disabled)
>>                  return;
>>
>>          for_each_cpu(cpu, policy->cpus) {
>> @@ -199,7 +207,7 @@ static void cppc_cpufreq_cpu_fie_exit(struct cpufreq_policy *policy)
>>          struct cppc_freq_invariance *cppc_fi;
>>          int cpu;
>>
>> -       if (cppc_cpufreq_driver.get == hisi_cppc_cpufreq_get_rate)
>> +       if (fie_disabled)
>>                  return;
>>
>>          /* policy->cpus will be empty here, use related_cpus instead */
>> @@ -229,7 +237,21 @@ static void __init cppc_freq_invariance_init(void)
>>          };
>>          int ret;
>>
>> -       if (cppc_cpufreq_driver.get == hisi_cppc_cpufreq_get_rate)
>> +       switch (fie_disabled) {
>> +       /* honor user request */
>> +       case FIE_DISABLED:
>> +       case FIE_ENABLED:
>> +               break;
>> +       case FIE_UNSET:
>> +       default:
> 
> Would be more straightforward to do
> 
> if (fie_disabled == FIE_UNSET) {
> 
> here.

Right, but then it wouldn't catch the other billion+ values that are the 
result of not being able to export a limit (AFAIK) on the module 
parameter. I could use an if:

if !((fie_disabled == FIE_DISABLE) || (fie_disabled == FIE_ENABLED)) {

}


if that is preferable. I thought the case with the explict default: 
though made it clearer that it was treating all those other values as unset.

> 
>> +               fie_disabled = FIE_ENABLED;
>> +               if (cppc_perf_ctrs_in_pcc()) {
>> +                       pr_info("FIE not enabled on systems with registers in PCC\n");
>> +                       fie_disabled = FIE_DISABLED;
>> +               }
>> +               break;
>> +       }
>> +       if (fie_disabled)
>>                  return;
>>
>>          kworker_fie = kthread_create_worker(0, "cppc_fie");
>> @@ -247,7 +269,7 @@ static void __init cppc_freq_invariance_init(void)
>>
>>   static void cppc_freq_invariance_exit(void)
>>   {
>> -       if (cppc_cpufreq_driver.get == hisi_cppc_cpufreq_get_rate)
>> +       if (fie_disabled)
>>                  return;
>>
>>          kthread_destroy_worker(kworker_fie);
>> @@ -936,6 +958,7 @@ static void cppc_check_hisi_workaround(void)
>>                      wa_info[i].oem_revision == tbl->oem_revision) {
>>                          /* Overwrite the get() callback */
>>                          cppc_cpufreq_driver.get = hisi_cppc_cpufreq_get_rate;
>> +                       fie_disabled = FIE_DISABLED;
>>                          break;
>>                  }
>>          }
>> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
>> index f73d357ecdf5..c5614444031f 100644
>> --- a/include/acpi/cppc_acpi.h
>> +++ b/include/acpi/cppc_acpi.h
>> @@ -140,6 +140,7 @@ extern int cppc_get_perf_ctrs(int cpu, struct cppc_perf_fb_ctrs *perf_fb_ctrs);
>>   extern int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls);
>>   extern int cppc_set_enable(int cpu, bool enable);
>>   extern int cppc_get_perf_caps(int cpu, struct cppc_perf_caps *caps);
>> +extern bool cppc_perf_ctrs_in_pcc(void);
>>   extern bool acpi_cpc_valid(void);
>>   extern bool cppc_allow_fast_switch(void);
>>   extern int acpi_get_psd_map(unsigned int cpu, struct cppc_cpudata *cpu_data);
>> @@ -173,6 +174,10 @@ static inline int cppc_get_perf_caps(int cpu, struct cppc_perf_caps *caps)
>>   {
>>          return -ENOTSUPP;
>>   }
>> +static inline bool cppc_perf_ctrs_in_pcc(void)
>> +{
>> +       return false;
>> +}
>>   static inline bool acpi_cpc_valid(void)
>>   {
>>          return false;
>> --
> 
> Apart from the above it looks fine to me, but I would like to get an
> ACK from Viresh on the second patch.
> 
> Thanks!

Thanks for looking at this.


