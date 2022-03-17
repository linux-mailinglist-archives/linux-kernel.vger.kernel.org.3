Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1134DCAC0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 17:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236028AbiCQQIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 12:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236373AbiCQQID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 12:08:03 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6A17D214075;
        Thu, 17 Mar 2022 09:06:46 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 107241424;
        Thu, 17 Mar 2022 09:06:46 -0700 (PDT)
Received: from [10.57.41.19] (unknown [10.57.41.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6DCFF3F7B4;
        Thu, 17 Mar 2022 09:06:41 -0700 (PDT)
Message-ID: <d8502879-104e-c1c9-d735-d9de5769da41@arm.com>
Date:   Thu, 17 Mar 2022 17:07:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v1 2/3] cpufreq: CPPC: Add per_cpu efficiency_class
Content-Language: en-US
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ionela.Voinescu@arm.com,
        Lukasz.Luba@arm.com, Morten.Rasmussen@arm.com,
        Dietmar.Eggemann@arm.com, mka@chromium.org,
        daniel.lezcano@linaro.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Fuad Tabba <tabba@google.com>, Rob Herring <robh@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
References: <20220317133419.3901736-1-Pierre.Gondois@arm.com>
 <20220317133419.3901736-3-Pierre.Gondois@arm.com>
 <f4356101d8c8d209054566261b300a91@kernel.org>
From:   Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <f4356101d8c8d209054566261b300a91@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/17/22 16:13, Marc Zyngier wrote:
> On 2022-03-17 13:34, Pierre Gondois wrote:
>> In ACPI, describing power efficiency of CPUs can be done through the
>> following arm specific field:
>> ACPI 6.4, s5.2.12.14 'GIC CPU Interface (GICC) Structure',
>> 'Processor Power Efficiency Class field':
>>    Describes the relative power efficiency of the associated pro-
>>    cessor. Lower efficiency class numbers are more efficient than
>>    higher ones (e.g. efficiency class 0 should be treated as more
>>    efficient than efficiency class 1). However, absolute values
>>    of this number have no meaning: 2 isn’t necessarily half as
>>    efficient as 1.
>>
>> The efficiency_class field is stored in the GicC structure of the
>> ACPI MADT table and it's currently supported in Linux for arm64 only.
>> Thus, this new functionality is introduced for arm64 only.
>>
>> To allow the cppc_cpufreq driver to know and preprocess the
>> efficiency_class values of all the CPUs, add a per_cpu efficiency_class
>> variable to store them. Also add a static efficiency_class_populated
>> to let the driver know efficiency_class values are usable and register
>> an artificial Energy Model (EM) based on normalized class values.
>>
>> At least 2 different efficiency classes must be present,
>> otherwise there is no use in creating an Energy Model.
>>
>> The efficiency_class values are squeezed in [0:#efficiency_class-1]
>> while conserving the order. For instance, efficiency classes of:
>>    [111, 212, 250]
>> will be mapped to:
>>    [0 (was 111), 1 (was 212), 2 (was 250)].
>>
>> Each policy being independently registered in the driver, populating
>> the per_cpu efficiency_class is done only once at the driver
>> initialization. This prevents from having each policy re-searching the
>> efficiency_class values of other CPUs.
>>
>> The patch also exports acpi_cpu_get_madt_gicc() to fetch the GicC
>> structure of the ACPI MADT table for each CPU.
>>
>> Signed-off-by: Pierre Gondois <Pierre.Gondois@arm.com>
>> ---
>>   arch/arm64/kernel/smp.c        |  1 +
>>   drivers/cpufreq/cppc_cpufreq.c | 55 ++++++++++++++++++++++++++++++++++
>>   2 files changed, 56 insertions(+)
>>
>> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
>> index 27df5c1e6baa..56637cbea5d6 100644
>> --- a/arch/arm64/kernel/smp.c
>> +++ b/arch/arm64/kernel/smp.c
>> @@ -512,6 +512,7 @@ struct acpi_madt_generic_interrupt
>> *acpi_cpu_get_madt_gicc(int cpu)
>>   {
>>   	return &cpu_madt_gicc[cpu];
>>   }
>> +EXPORT_SYMBOL(acpi_cpu_get_madt_gicc);
> 
> Why not EXPORT_SYMBOL_GPL()?

 From what I understand, this could be made EXPORT_SYMBOL_GPL().
The only reason was that the other symbol exportation in the
file wasn't restricted to GPL.

> 
>>
>>   /*
>>    * acpi_map_gic_cpu_interface - parse processor MADT entry
>> diff --git a/drivers/cpufreq/cppc_cpufreq.c
>> b/drivers/cpufreq/cppc_cpufreq.c
>> index 8f950fe72765..a6cd95c3b474 100644
>> --- a/drivers/cpufreq/cppc_cpufreq.c
>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>> @@ -422,12 +422,66 @@ static unsigned int
>> cppc_cpufreq_get_transition_delay_us(unsigned int cpu)
>>   	return cppc_get_transition_latency(cpu) / NSEC_PER_USEC;
>>   }
>>
>> +static bool efficiency_class_populated;
>> +static DEFINE_PER_CPU(unsigned int, efficiency_class);
>> +
>> +static int populate_efficiency_class(void)
>> +{
>> +	unsigned int min = UINT_MAX, max = 0, class;
>> +	struct acpi_madt_generic_interrupt *gicc;
>> +	int cpu;
>> +
>> +	for_each_possible_cpu(cpu) {
>> +		gicc = acpi_cpu_get_madt_gicc(cpu);
>> +		if (!gicc)
>> +			return -ENODEV;
> 
> How can that happen if you made it here using ACPI?

This is effectively an extra check. This could be removed.

> 
>> +
>> +		per_cpu(efficiency_class, cpu) = gicc->efficiency_class;
>> +		min = min_t(unsigned int, min, gicc->efficiency_class);
>> +		max = max_t(unsigned int, max, gicc->efficiency_class);
>> +	}
> 
> Why don't you use a temporary bitmap of 256 bits, tracking
> the classes that are actually being used?
> 
>> +
>> +	if (min == max) {
> 
> This would become (bitmap_weight(used_classes) <= 1). Then from
> the same construct you know how many different classes you have.
> You also have the min, max, and all the values in between.
> 
>> +		pr_debug("Efficiency classes are all equal (=%d). "
>> +			"No EM registered", max);
>> +		return -EINVAL;
>> +	}
>> +
>> +	/*
>> +	 * Squeeze efficiency class values on [0:#efficiency_class-1].
>> +	 * Values are per spec in [0:255].
>> +	 */
>> +	for (class = 0; class < 256; class++) {
>> +		unsigned int new_min, curr;
>> +
>> +		new_min = UINT_MAX;
>> +		for_each_possible_cpu(cpu) {
>> +			curr = per_cpu(efficiency_class, cpu);
>> +			if (curr == min)
>> +				per_cpu(efficiency_class, cpu) = class;
>> +			else if (curr > min)
>> +				new_min = min(new_min, curr);
>> +		}
>> +
>> +		if (new_min == UINT_MAX)
>> +			break;
>> +		min = new_min;
>> +	}
> 
> I find it really hard to reason about this because you are
> dynamically rewriting the values you keep reevaluating.
> 
> How about something like this, which I find more readable:
> 
> 	DECLARE_BITMAP(used_classes, 256) = {};
> 	int class, index, cpu;
> 
> 	for_each_possible_cpu(cpu) {
> 		unsigned int ec;
> 
> 		ec = acpi_cpu_get_madt_gicc(cpu)->efficiency_class & 0xff;
> 		bitmap_set(ec, &used_classes);
> 	}
> 
> 	if (bitmap_weight(&used_classes, 256) <= 1)
> 		return;
> 
> 	index = 0;
> 
> 	for_each_set_bit(class, &used_classes, 256) {
> 		for_each_possible_cpu(cpu) {
> 			if (acpi_cpu_get_madt_gicc(cpu)->efficiency_class == class)
> 				per_cpu(efficiency_class, cpu) = index;
> 		}
> 
> 		index++;
> 	}

This is effectively much more readable. Thanks for the code snippet.

Regards,
Pierre

> 
> 
> Thanks,
> 
>           M.
