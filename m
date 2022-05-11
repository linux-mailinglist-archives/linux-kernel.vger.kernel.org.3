Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2261D523031
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 12:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235122AbiEKKES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 06:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239697AbiEKKEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 06:04:02 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E45FA6162C;
        Wed, 11 May 2022 03:03:45 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BB7FE1042;
        Wed, 11 May 2022 03:03:45 -0700 (PDT)
Received: from [10.57.80.111] (unknown [10.57.80.111])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8B30B3F73D;
        Wed, 11 May 2022 03:03:43 -0700 (PDT)
Message-ID: <657d2bba-23af-fa74-3efe-cd7558b47ff7@arm.com>
Date:   Wed, 11 May 2022 11:03:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 1/2] perf: coresight_pmu: Add support for ARM CoreSight
 PMU driver
Content-Language: en-GB
To:     Besar Wicaksono <bwicaksono@nvidia.com>
Cc:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "thanu.rangarajan@arm.com" <thanu.rangarajan@arm.com>,
        "Michael.Williams@arm.com" <Michael.Williams@arm.com>,
        "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
        Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Vikram Sethi <vsethi@nvidia.com>
References: <20220509002810.12412-1-bwicaksono@nvidia.com>
 <20220509002810.12412-2-bwicaksono@nvidia.com>
 <756ac2c8-6530-03b0-53d3-ee7493509579@arm.com>
 <SJ0PR12MB5676443AE9A331A962276EB4A0C89@SJ0PR12MB5676.namprd12.prod.outlook.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <SJ0PR12MB5676443AE9A331A962276EB4A0C89@SJ0PR12MB5676.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-05-11 03:46, Besar Wicaksono wrote:
[...]
>>> +config ARM_CORESIGHT_PMU
>>> +     tristate "ARM Coresight PMU"
>>> +     depends on ARM64 && ACPI_APMT
>>
>> There shouldn't be any functional dependency on any CPU architecture here.
> 
> The spec is targeted towards ARM based system, shouldn't we explicitly limit it to ARM?

I wouldn't say so. The PMU spec does occasionally make reference to the 
Armv8-A and Armv8-M PMU architectures for comparison, but ultimately 
it's specifying an MMIO register interface for a system component. If 
3rd-party system IP vendors adopt it, who knows what kind of systems 
these PMUs might end up in? (And of course a DT binding will inevitably 
come along once the rest of the market catches up with the ACPI-focused 
early adopters)

In terms of functional dependency plus scope of practical usefulness, I 
think something like:

	depends on ACPI
	depends on ACPI_APMT || COMPILE_TEST

would probably fit the bill until DT support comes along.

[...]
>>> +/*
>>> + * Write to 64-bit register as a pair of 32-bit registers.
>>> + *
>>> + * @val     : 64-bit value to write.
>>> + * @base    : base address of page-0 or page-1 if dual-page ext. is enabled.
>>> + * @offset  : register offset.
>>> + *
>>> + */
>>> +static void write_reg64_lohi(u64 val, void __iomem *base, u32 offset)
>>> +{
>>> +     u32 val_lo, val_hi;
>>> +
>>> +     val_hi = upper_32_bits(val);
>>> +     val_lo = lower_32_bits(val);
>>> +
>>> +     write_reg32(val_lo, base, offset);
>>> +     write_reg32(val_hi, base, offset + 4);
>>> +}
>>
>> #include <linux/io-64-nonatomic-lo-hi.h>
> 
> Thanks for pointing this out. We will replace it with lo_hi_writeq.

The point is more that you can just use writeq() (and readq() where 
atomicity isn't important), and the header will make sure it works wherever.

The significance of not having 64-bit single-copy atomicity should be 
that if the processor issues a 64-bit access, the system may 
*automatically* split it into a pair of 32-bit accesses, e.g. at an 
AXI-to-APB bridge. If making a 64-bit access to a 64-bit register would 
actually fail, that's just broken.

[...]
>>> +static inline bool is_cycle_cntr_idx(const struct perf_event *event)
>>> +{
>>> +     struct coresight_pmu *coresight_pmu = to_coresight_pmu(event-
>>> pmu);
>>> +     int idx = event->hw.idx;
>>> +
>>> +     return (support_cc(coresight_pmu) && idx ==
>> CORESIGHT_PMU_IDX_CCNTR);
>>
>> If we don't support cycle counting, cycles count events should have been
>> rejected in event_init. If they're able to propagate further than that

[apologies for an editing mishap here, this should have continued "then 
something is fundamentally broken."]

> Not sure I understand, do you mean the check for cycle counter support is unnecessary ?
> This function is actually called by coresight_pmu_start, which is after event_init had passed.
> coresight_pmu_start is not aware if cycle counter is supported or not, so we need to keep checking it.

I mean that the support_cc(coresight_pmu) check should only ever need to 
happen *once* in event_init, so if standard cycles events are not 
supported then they are correctly rejected there and then. After that, 
if we see one in event_add and later, then we can simply infer that we 
*do* have a standard cycle counter and go ahead and allocate it.

>>> +}
>>> +
>>> +bool coresight_pmu_is_cc_event(const struct perf_event *event)
>>> +{
>>> +     struct coresight_pmu *coresight_pmu = to_coresight_pmu(event-
>>> pmu);
>>> +     u32 evtype = coresight_pmu->impl.ops->event_type(event);
>>> +
>>> +     return (support_cc(coresight_pmu) &&
>>
>> Ditto.
> 
> This function is called by event_init to validate the event and find available counters.

Right, but it also ends up getting called from other places like 
event_add as well. Like I say, if we're still checking whether an event 
is supported or not by that point, we're doing something wrong.

[...]>>> +/**
>>> + * This is the default event number for cycle count, if supported, since the
>>> + * ARM Coresight PMU specification does not define a standard event
>> code
>>> + * for cycle count.
>>> + */
>>> +#define CORESIGHT_PMU_EVT_CYCLES_DEFAULT (0x1ULL << 31)
>>
>> And what do we do when an implementation defines 0x80000000 as one of
>> its own event specifiers? The standard cycle count is independent of any
>> other events, so it needs to be encoded in a manner which is distinct
>> from *any* potentially-valid PMEVTYPER value.
> 
> We were thinking that in such case, the implementor would provide coresight_pmu_impl_ops.
> To avoid it, I guess we can use config[32] for the default cycle count event id.
> The filter value will need to be moved to config1[31:0].
> Does it sound reasonable ?

Sure, you can lay out the config fields however you fancy, but since the 
architecture leaves the standard cycles event independent from the 
32-bit IMP-DEF PMEVTYPER specifier, logically we need at least 33 bits 
in some form or other to encode all possible event types in our 
perf_event config.

Thanks,
Robin.
