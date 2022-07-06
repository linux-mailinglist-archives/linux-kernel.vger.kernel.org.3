Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D06F95682EF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 11:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233208AbiGFJJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 05:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233167AbiGFJI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 05:08:57 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D32B326135;
        Wed,  6 Jul 2022 02:05:54 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CBE0F15A1;
        Wed,  6 Jul 2022 02:05:54 -0700 (PDT)
Received: from [10.57.9.19] (unknown [10.57.9.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A8B9B3F66F;
        Wed,  6 Jul 2022 02:05:51 -0700 (PDT)
Message-ID: <50fb0d2f-fca8-4e82-a778-544161029979@arm.com>
Date:   Wed, 6 Jul 2022 10:05:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/4] PM: EM: convert power field to micro-Watts precision
 and align drivers
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     amitk@kernel.org, rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, viresh.kumar@linaro.org,
        rafael@kernel.org, dietmar.eggemann@arm.com, nm@ti.com,
        sboyd@kernel.org, sudeep.holla@arm.com, cristian.marussi@arm.com,
        matthias.bgg@gmail.com, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20220622145802.13032-1-lukasz.luba@arm.com>
 <20220622145802.13032-2-lukasz.luba@arm.com>
 <3b0ce952-0674-d01d-3fc0-795d35743723@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <3b0ce952-0674-d01d-3fc0-795d35743723@linaro.org>
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



On 7/5/22 10:09, Daniel Lezcano wrote:
> On 22/06/2022 16:57, Lukasz Luba wrote:
>> The milli-Watts precision causes rounding errors while calculating
>> efficiency cost for each OPP. This is especially visible in the 'simple'
>> Energy Model (EM), where the power for each OPP is provided from OPP
>> framework. This can cause some OPPs to be marked inefficient, while
>> using micro-Watts precision that might not happen.
>>
>> Update all EM users which access 'power' field and assume the value is
>> in milli-Watts.
>>
>> Solve also an issue with potential overflow in calculation of energy
>> estimation on 32bit machine. It's needed now since the power value
>> (thus the 'cost' as well) are higher.
>>
>> Example calculation which shows the rounding error and impact:
>>
>> power = 'dyn-power-coeff' * volt_mV * volt_mV * freq_MHz
>>
>> power_a_uW = (100 * 600mW * 600mW * 500MHz) / 10^6 = 18000
>> power_a_mW = (100 * 600mW * 600mW * 500MHz) / 10^9 = 18
>>
>> power_b_uW = (100 * 605mW * 605mW * 600MHz) / 10^6 = 21961
>> power_b_mW = (100 * 605mW * 605mW * 600MHz) / 10^9 = 21
>>
>> max_freq = 2000MHz
>>
>> cost_a_mW = 18 * 2000MHz/500MHz = 72
>> cost_a_uW = 18000 * 2000MHz/500MHz = 72000
>>
>> cost_b_mW = 21 * 2000MHz/600MHz = 70 // <- artificially better
>> cost_b_uW = 21961 * 2000MHz/600MHz = 73203
>>
>> The 'cost_b_mW' (which is based on old milli-Watts) is misleadingly
>> better that the 'cost_b_uW' (this patch uses micro-Watts) and such
>> would have impact on the 'inefficient OPPs' information in the Cpufreq
>> framework. This patch set removes the rounding issue.
> 
> Thanks for this detailed description, it really helps to understand why 
> this change is needed.
> 
> Perhaps it would make sense to add a power_uw in the EM structure and 
> keeping the old one with the milli-watts in order to reduce the impact 
> of the change.
> 
> It is a suggestion if you find it more convenient. Otherwise I'm fine 
> with this approach too.

I see your point, it could go with 2 patches instead of one. If there
will be a need of v2 I will consider this split.

> 
> A few comments below.
> 
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>> ---
>>   drivers/cpufreq/mediatek-cpufreq-hw.c |  7 +--
>>   drivers/cpufreq/scmi-cpufreq.c        |  6 +++
>>   drivers/opp/of.c                      | 15 ++++---
>>   drivers/powercap/dtpm_cpu.c           |  5 +--
>>   drivers/thermal/cpufreq_cooling.c     | 13 +++++-
>>   drivers/thermal/devfreq_cooling.c     | 19 ++++++--
>>   include/linux/energy_model.h          | 63 ++++++++++++++++++++-------
>>   kernel/power/energy_model.c           | 31 ++++++++-----
>>   8 files changed, 114 insertions(+), 45 deletions(-)
>>
>> diff --git a/drivers/cpufreq/mediatek-cpufreq-hw.c 
>> b/drivers/cpufreq/mediatek-cpufreq-hw.c
>> index 813cccbfe934..f0e0a35c7f21 100644
>> --- a/drivers/cpufreq/mediatek-cpufreq-hw.c
>> +++ b/drivers/cpufreq/mediatek-cpufreq-hw.c
>> @@ -51,7 +51,7 @@ static const u16 cpufreq_mtk_offsets[REG_ARRAY_SIZE] 
>> = {
>>   };
> 
> [ ... ]
> 
>> diff --git a/drivers/thermal/cpufreq_cooling.c 
>> b/drivers/thermal/cpufreq_cooling.c
>> index b8151d95a806..dc19e7c80751 100644
>> --- a/drivers/thermal/cpufreq_cooling.c
>> +++ b/drivers/thermal/cpufreq_cooling.c
>> @@ -21,6 +21,7 @@
>>   #include <linux/pm_qos.h>
>>   #include <linux/slab.h>
>>   #include <linux/thermal.h>
>> +#include <linux/units.h>
>>   #include <trace/events/thermal.h>
>> @@ -101,6 +102,7 @@ static unsigned long get_level(struct 
>> cpufreq_cooling_device *cpufreq_cdev,
>>   static u32 cpu_freq_to_power(struct cpufreq_cooling_device 
>> *cpufreq_cdev,
>>                    u32 freq)
>>   {
>> +    unsigned long power_mw;
>>       int i;
>>       for (i = cpufreq_cdev->max_level - 1; i >= 0; i--) {
>> @@ -108,16 +110,23 @@ static u32 cpu_freq_to_power(struct 
>> cpufreq_cooling_device *cpufreq_cdev,
>>               break;
>>       }
>> -    return cpufreq_cdev->em->table[i + 1].power;
>> +    power_mw = cpufreq_cdev->em->table[i + 1].power;
>> +    power_mw /= MICROWATT_PER_MILLIWATT;
> 
> Won't this fail with an unresolved symbols on some archs ? I mean may be 
> do_div should be used instead ?

I've run that code in internal CI for all archs and didn't crash.
We already have a division in IPA or in devfreq_cooling where
the variables are 32bit and works fine.

> 
>> +
>> +    return power_mw;
>>   }
> 
> [ ... ]


The em_validate_cost() is in this cut section.


> 
>>   #ifdef CONFIG_64BIT
>> -#define em_scale_power(p) ((p) * 1000)
>> +#define em_estimate_energy(cost, sum_util, scale_cpu) \
>> +    (((cost) * (sum_util)) / (scale_cpu))
>>   #else
>> -#define em_scale_power(p) (p)
>> +#define em_estimate_energy(cost, sum_util, scale_cpu) \
>> +    (((cost) / (scale_cpu)) * (sum_util))
>>   #endif
>>   struct em_data_callback {
>> @@ -112,7 +143,7 @@ struct em_data_callback {
>>        * and frequency.
>>        *
>>        * In case of CPUs, the power is the one of a single CPU in the 
>> domain,
>> -     * expressed in milli-Watts or an abstract scale. It is expected to
>> +     * expressed in micro-Watts or an abstract scale. It is expected to
>>        * fit in the [0, EM_MAX_POWER] range.
>>        *
>>        * Return 0 on success.
>> @@ -148,7 +179,7 @@ struct em_perf_domain *em_cpu_get(int cpu);
>>   struct em_perf_domain *em_pd_get(struct device *dev);
>>   int em_dev_register_perf_domain(struct device *dev, unsigned int 
>> nr_states,
>>                   struct em_data_callback *cb, cpumask_t *span,
>> -                bool milliwatts);
>> +                bool microwatts);
>>   void em_dev_unregister_perf_domain(struct device *dev);
>>   /**
>> @@ -273,7 +304,7 @@ static inline unsigned long em_cpu_energy(struct 
>> em_perf_domain *pd,
>>        *   pd_nrg = ------------------------                       (4)
>>        *                  scale_cpu
>>        */
>> -    return ps->cost * sum_util / scale_cpu;
>> +    return em_estimate_energy(ps->cost, sum_util, scale_cpu);
>>   }
>>   /**
>> @@ -297,7 +328,7 @@ struct em_data_callback {};
>>   static inline
>>   int em_dev_register_perf_domain(struct device *dev, unsigned int 
>> nr_states,
>>                   struct em_data_callback *cb, cpumask_t *span,
>> -                bool milliwatts)
>> +                bool microwatts)
>>   {
>>       return -EINVAL;
>>   }
>> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
>> index 6c373f2960e7..910668ec8838 100644
>> --- a/kernel/power/energy_model.c
>> +++ b/kernel/power/energy_model.c
>> @@ -108,10 +108,11 @@ static void em_debug_remove_pd(struct device 
>> *dev) {}
>>   static int em_create_perf_table(struct device *dev, struct 
>> em_perf_domain *pd,
>>                   int nr_states, struct em_data_callback *cb,
>> -                unsigned long flags)
>> +                unsigned long flags, int num_devs)
>>   {
>>       unsigned long power, freq, prev_freq = 0, prev_cost = ULONG_MAX;
>>       struct em_perf_state *table;
>> +    unsigned long max_cost = 0;
>>       int i, ret;
>>       u64 fmax;
>> @@ -145,7 +146,7 @@ static int em_create_perf_table(struct device 
>> *dev, struct em_perf_domain *pd,
>>           /*
>>            * The power returned by active_state() is expected to be
>> -         * positive and to fit into 16 bits.
>> +         * positive and be in range.
>>            */
>>           if (!power || power > EM_MAX_POWER) {
>>               dev_err(dev, "EM: invalid power: %lu\n",
>> @@ -170,7 +171,7 @@ static int em_create_perf_table(struct device 
>> *dev, struct em_perf_domain *pd,
>>                   goto free_ps_table;
>>               }
>>           } else {
>> -            power_res = em_scale_power(table[i].power);
>> +            power_res = table[i].power;
>>               cost = div64_u64(fmax * power_res, table[i].frequency);
>>           }
>> @@ -183,6 +184,15 @@ static int em_create_perf_table(struct device 
>> *dev, struct em_perf_domain *pd,
>>           } else {
>>               prev_cost = table[i].cost;
>>           }
>> +
>> +        if (max_cost < table[i].cost)
>> +            max_cost = table[i].cost;
>> +    }
>> +
>> +    /* Check if it won't overflow during energy estimation. */
>> +    if (em_validate_cost(max_cost, num_devs)) {
> 
> I'm not finding the em_validate_cost() function

It's in the energy_model.h

> 
>> +        dev_err(dev, "EM: too big 'cost' value: %lu\n",    max_cost);
>> +        goto free_ps_table;
>>       }
>>       pd->table = table;
>> @@ -199,9 +209,9 @@ static int em_create_pd(struct device *dev, int 
>> nr_states,
>>               struct em_data_callback *cb, cpumask_t *cpus,
>>               unsigned long flags)
>>   {
>> +    int cpu, ret, num_devs = 1;
>>       struct em_perf_domain *pd;
>>       struct device *cpu_dev;
>> -    int cpu, ret;
>>       if (_is_cpu_device(dev)) {
>>           pd = kzalloc(sizeof(*pd) + cpumask_size(), GFP_KERNEL);
>> @@ -209,13 +219,14 @@ static int em_create_pd(struct device *dev, int 
>> nr_states,
>>               return -ENOMEM;
>>           cpumask_copy(em_span_cpus(pd), cpus);
>> +        num_devs = cpumask_weight(cpus);
> 
> Why is this change needed ? What is the connection with the uW unit 
> change ?

We support 32bit arch still with the 'unsigned long power' variable,
but we would store e.g. 1.2 Watts there as:
power = 1200000 // 0x124f80
not
power = 1200 // 0x4b0

This would use > 20bits as you can see. We then calculate:
cost_i = power_i * fmax / freq_i
which is used by EAS.

The value from the 'cost' is used for calculating energy in EAS:

unsigned long energy = (cost * sum_utilization) / cpu_arch_capacity
OR on 32bit machines:
unsigned long energy = (cost / cpu_arch_capacity) * sum_utilization

We cannot overflow in any use case. The 'num_devs' is part of this
mechanism. as you can see in this example for 32bit:
max_possible_cost_for_fmax = 64000000 //64Watts
energy = (64000000 / cpu_arch_capacity) * (num_cpus * 
max_cpu_utilization) =>
// assume: cpu_arch_capacity == max_cpu_utilization is true
unsigned long energy = 64000000 * num_cpus
Then question:
Q: how many cpus you can have to not overflow?
A: depends on your max_power and then 'cost'
In the above example:
num_cpus must be < 68

I can simplify this to just put a new define for 32bit
machines like num_cpus=16 for safety:

#ifdef CONFIG_64BIT
#define EM_MAX_NUM_CPUS UINT_MAX
#else
#define EM_MAX_NUM_CPUS 16 /*we don't expect more than that */

Then there is no need to modify that calculation function
em_create_perf_table()

The more I look at this the more I'm convinced to do that...

In the old code, the power value had limit to 16bits, the num_cpus
also had limit IIRC to 16bit, thus multiplication wasn't a problem.


