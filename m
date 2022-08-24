Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9022759FF2C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 18:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237970AbiHXQLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 12:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237923AbiHXQLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 12:11:11 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5BADA7676E;
        Wed, 24 Aug 2022 09:11:10 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4DB81106F;
        Wed, 24 Aug 2022 09:11:14 -0700 (PDT)
Received: from [192.168.122.164] (U203867.austin.arm.com [10.118.30.29])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E0F753FAF5;
        Wed, 24 Aug 2022 09:11:09 -0700 (PDT)
Message-ID: <2cfad670-9b3a-38c4-4d0f-45173da35d95@arm.com>
Date:   Wed, 24 Aug 2022 11:11:09 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v3 1/2] ACPI: CPPC: Disable FIE if registers in PCC
 regions
Content-Language: en-US
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     rafael@kernel.or, lenb@kernel.org, viresh.kumar@linaro.org,
        robert.moore@intel.com, punit.agrawal@bytedance.com,
        ionela.voinescu@arm.com, pierre.gondois@arm.com,
        linux-kernel@vger.kernel.org, devel@acpica.org,
        linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Souvik Chakravarty <souvik.chakravarty@arm.com>
References: <20220818211619.4193362-1-jeremy.linton@arm.com>
 <20220818211619.4193362-2-jeremy.linton@arm.com>
 <59f3ba6f-b657-2da2-cb2a-9736e1488908@arm.com>
From:   Jeremy Linton <jeremy.linton@arm.com>
In-Reply-To: <59f3ba6f-b657-2da2-cb2a-9736e1488908@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/24/22 09:41, Lukasz Luba wrote:
> Hi Jeremy,
> 
> +CC Dietmar, Morten and Souvik
> 
> On 8/18/22 22:16, Jeremy Linton wrote:
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
>>   drivers/acpi/cppc_acpi.c       | 41 ++++++++++++++++++++++++++++++++++
>>   drivers/cpufreq/cppc_cpufreq.c | 31 +++++++++++++++++++++----
>>   include/acpi/cppc_acpi.h       |  5 +++++
>>   3 files changed, 73 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>> index 1e15a9f25ae9..c840bf606b30 100644
>> --- a/drivers/acpi/cppc_acpi.c
>> +++ b/drivers/acpi/cppc_acpi.c
>> @@ -1240,6 +1240,47 @@ int cppc_get_perf_caps(int cpunum, struct 
>> cppc_perf_caps *perf_caps)
>>   }
>>   EXPORT_SYMBOL_GPL(cppc_get_perf_caps);
>> +/**
>> + * cppc_perf_ctrs_in_pcc - Check if any perf counters are in a PCC 
>> region.
>> + *
>> + * CPPC has flexibility about how counters describing CPU perf are 
>> delivered.
>> + * One of the choices is PCC regions, which can have a high access 
>> latency. This
>> + * routine allows callers of cppc_get_perf_ctrs() to know this ahead 
>> of time.
>> + *
>> + * Return: true if any of the counters are in PCC regions, false 
>> otherwise
>> + */
>> +bool cppc_perf_ctrs_in_pcc(void)
>> +{
>> +    int cpu;
>> +
>> +    for_each_present_cpu(cpu) {
>> +        struct cpc_register_resource *ref_perf_reg;
>> +        struct cpc_desc *cpc_desc;
>> +
>> +        cpc_desc = per_cpu(cpc_desc_ptr, cpu);
>> +
>> +        if (CPC_IN_PCC(&cpc_desc->cpc_regs[DELIVERED_CTR]) ||
>> +            CPC_IN_PCC(&cpc_desc->cpc_regs[REFERENCE_CTR]) ||
>> +            CPC_IN_PCC(&cpc_desc->cpc_regs[CTR_WRAP_TIME]))
>> +            return true;
>> +
>> +
>> +        ref_perf_reg = &cpc_desc->cpc_regs[REFERENCE_PERF];
>> +
>> +        /*
>> +         * If reference perf register is not supported then we should
>> +         * use the nominal perf value
>> +         */
>> +        if (!CPC_SUPPORTED(ref_perf_reg))
>> +            ref_perf_reg = &cpc_desc->cpc_regs[NOMINAL_PERF];
>> +
>> +        if (CPC_IN_PCC(ref_perf_reg))
>> +            return true;
>> +    }
> 
> Do we have a platform which returns false here?

I'm not aware of one, but I don't have access to every bit of HW either.


> 
>> +    return false;
>> +}
>> +EXPORT_SYMBOL_GPL(cppc_perf_ctrs_in_pcc);
>> +
>>   /**
>>    * cppc_get_perf_ctrs - Read a CPU's performance feedback counters.
>>    * @cpunum: CPU from which to read counters.
>> diff --git a/drivers/cpufreq/cppc_cpufreq.c 
>> b/drivers/cpufreq/cppc_cpufreq.c
>> index 24eaf0ec344d..32fcb0bf74a4 100644
>> --- a/drivers/cpufreq/cppc_cpufreq.c
>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>> @@ -63,7 +63,15 @@ static struct cppc_workaround_oem_info wa_info[] = {
>>   static struct cpufreq_driver cppc_cpufreq_driver;
>> +static enum {
>> +    FIE_UNSET = -1,
>> +    FIE_ENABLED,
>> +    FIE_DISABLED
>> +} fie_disabled = FIE_UNSET;
>> +
>>   #ifdef CONFIG_ACPI_CPPC_CPUFREQ_FIE
>> +module_param(fie_disabled, int, 0444);
>> +MODULE_PARM_DESC(fie_disabled, "Disable Frequency Invariance Engine 
>> (FIE)");
> 
> Why we need the modules support?
> I would drop this, since the fie_disabled would be set properly when
> needed. The code would be cleaner (more below).

Well the original version was simpler, but I tend to agree with Ionela 
who proposed this version in a previous review. The module param at this 
point is a debugging/testing statment since it allows the user to force 
FIE on or off independent of the PCC decision. Until we have a clear 
statment about how/when/where this feature is useful, having the ability 
to make the choice dynamically at runtime is quite useful and less 
intrusive than having multiple kernels/modules on the machine with the 
config option flipped, and requiring a reboot.

> 
>>   /* Frequency invariance support */
>>   struct cppc_freq_invariance {
>> @@ -158,7 +166,7 @@ static void cppc_cpufreq_cpu_fie_init(struct 
>> cpufreq_policy *policy)
>>       struct cppc_freq_invariance *cppc_fi;
>>       int cpu, ret;
>> -    if (cppc_cpufreq_driver.get == hisi_cppc_cpufreq_get_rate)
>> +    if (fie_disabled)
>>           return;
>>       for_each_cpu(cpu, policy->cpus) {
>> @@ -199,7 +207,7 @@ static void cppc_cpufreq_cpu_fie_exit(struct 
>> cpufreq_policy *policy)
>>       struct cppc_freq_invariance *cppc_fi;
>>       int cpu;
>> -    if (cppc_cpufreq_driver.get == hisi_cppc_cpufreq_get_rate)
>> +    if (fie_disabled)
>>           return;
>>       /* policy->cpus will be empty here, use related_cpus instead */
>> @@ -229,7 +237,21 @@ static void __init cppc_freq_invariance_init(void)
>>       };
>>       int ret;
>> -    if (cppc_cpufreq_driver.get == hisi_cppc_cpufreq_get_rate)
>> +    switch (fie_disabled) {
>> +    /* honor user request */
>> +    case FIE_DISABLED:
>> +    case FIE_ENABLED:
> 
> This module's over-write doesn't look 'clean'.
> Is it OK to allow a user to go with the poor performing
> system (likely on many platforms)? Or we assume that there are
> platforms which has a bit faster mailboxes and they already
> have the FIE issue impacting task's utilization measurements.

I think with this patch applied we aren't any worse than before, but 
that is based on the fact that I've not seen a machine that has actual 
CPPC hardware registers (rather than mailboxes).

So I think your suggesting that we will then have to revisit the code 
(to maybe avoid all the cppc_fie task/etc overhead) if a machine appears 
with hardware registers. And I tend to sorta agree, but that is what the 
second patch is for :) which will likely be what most distro's end up 
applying on generic kernels.

> 
> It looks like we are not sure about the solution. On one hand
> we implement those checks in the cppc_perf_ctrs_in_pcc()
> which could set the flag, but on the other hand we allow user
> to decide. IMO this creates diversity that we are not able to control.
> It creates another tunable knob in the kernel, which then is forgotten
> to check.

Your average user will never turn this knob, and if they do, its likely 
to solve a problem, or test for performace. The fact that we aren't 100% 
sure of where/when this feature is useful is the argument for making it 
a tunable.


> 
> I still haven't seen information that the old FIE was an issue on those
> servers and had impact on task utilization measurements. This should be
> a main requirement for this new feature. This would be after we proved
> that the utilization problem was due to the FIE and not something else 
> (like uArch variation or workload variation).
> 
> IMO let's revert the ACPI_CPPC_CPUFREQ_FIE. When we get data that
> FIE is an issue on those servers we can come back to this topic.

I don't really have an opinion about this, maybe someone else can 
comment :)

Although, with both of these patches applied we can kick the decision 
down the road and revisit it in a couple years, and maybe have a clearer 
view.




