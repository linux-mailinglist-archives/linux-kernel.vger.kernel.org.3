Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75291577ED9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 11:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234189AbiGRJmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 05:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234210AbiGRJmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 05:42:08 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CF4E112AC7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 02:42:06 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1DB101042;
        Mon, 18 Jul 2022 02:42:07 -0700 (PDT)
Received: from [10.57.44.129] (unknown [10.57.44.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2EC013F70D;
        Mon, 18 Jul 2022 02:42:05 -0700 (PDT)
Message-ID: <e3aef6fd-973b-d7ef-6d6a-10f9e8ac3b04@arm.com>
Date:   Mon, 18 Jul 2022 10:42:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v3] drivers/perf: arm_spe: Fix consistency of
 SYS_PMSCR_EL1.CX
To:     James Clark <james.clark@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     german.gomez@arm.com, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        linux-kernel@vger.kernel.org
References: <20220714061302.2715102-1-anshuman.khandual@arm.com>
 <9b2982f1-023a-3499-7e87-f00b5a689ae9@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <9b2982f1-023a-3499-7e87-f00b5a689ae9@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James

On 18/07/2022 10:30, James Clark wrote:
> 
> 
> On 14/07/2022 07:13, Anshuman Khandual wrote:
>> The arm_spe_pmu driver will enable SYS_PMSCR_EL1.CX in order to add CONTEXT
>> packets into the traces, if the owner of the perf event runs with required
>> capabilities i.e CAP_PERFMON or CAP_SYS_ADMIN via perfmon_capable() helper.
>>
>> The value of this bit is computed in the arm_spe_event_to_pmscr() function
>> but the check for capabilities happens in the pmu event init callback i.e
>> arm_spe_pmu_event_init(). This suggests that the value of the CX bit should
>> remain consistent for the duration of the perf session.
>>
>> However, the function arm_spe_event_to_pmscr() may be called later during
>> the event start callback i.e arm_spe_pmu_start() when the "current" process
>> is not the owner of the perf session, hence the CX bit setting is currently
>> not consistent.
>>
>> One way to fix this, is by caching the required value of the CX bit during
>> the initialization of the PMU event, so that it remains consistent for the
>> duration of the session. It uses currently unused 'event->hw.flags' element
>> to cache perfmon_capable() value, which can be referred during event start
>> callback to compute SYS_PMSCR_EL1.CX. This ensures consistent availability
>> of context packets in the trace as per event owner capabilities.
>>
>> Drop BIT(SYS_PMSCR_EL1_CX_SHIFT) check in arm_spe_pmu_event_init(), because
>> now CX bit cannot be set in arm_spe_event_to_pmscr() with perfmon_capable()
>> disabled.
>>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Fixes: cea7d0d4a59b ("drivers/perf: Open access for CAP_PERFMON privileged process")
>> Reported-by: German Gomez <german.gomez@arm.com>
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>> Changes in V3:
>>
>> - Moved set_spe_event_has_cx() before arm_spe_event_to_pmscr()
>> - Reinstated perfmon_capable() back in arm_spe_pmu_event_init()
>> - Dropped BIT(SYS_PMSCR_EL1_CX_SHIFT) check in arm_spe_pmu_event_init()
>> - Updated the commit message
>>   
>> Changes in V2:
>>
>> https://lore.kernel.org/all/20220713085925.2627533-1-anshuman.khandual@arm.com/
>>
>> - Moved CONFIG_PID_IN_CONTEXTIDR config check inside the helper per Suzuki
>> - Changed the comment per Suzuki
>> - Renamed the helpers Per Suzuki
>> - Added "Fixes: " tag per German
>>
>> Changes in V1:
>>
>> https://lore.kernel.org/all/20220712051404.2546851-1-anshuman.khandual@arm.com/
>>
>>
>>   drivers/perf/arm_spe_pmu.c | 22 ++++++++++++++++++++--
>>   1 file changed, 20 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
>> index db670b265897..b65a7d9640e1 100644
>> --- a/drivers/perf/arm_spe_pmu.c
>> +++ b/drivers/perf/arm_spe_pmu.c
>> @@ -39,6 +39,24 @@
>>   #include <asm/mmu.h>
>>   #include <asm/sysreg.h>
>>   
>> +/*
>> + * Cache if the event is allowed to trace Context information.
>> + * This allows us to perform the check, i.e, perfmon_capable(),
>> + * in the context of the event owner, once, during the event_init().
>> + */
>> +#define SPE_PMU_HW_FLAGS_CX			BIT(0)
>> +
>> +static void set_spe_event_has_cx(struct perf_event *event)
>> +{
>> +	if (IS_ENABLED(CONFIG_PID_IN_CONTEXTIDR) && perfmon_capable())
>> +		event->hw.flags |= SPE_PMU_HW_FLAGS_CX;
>> +}
>> +
>> +static bool get_spe_event_has_cx(struct perf_event *event)
>> +{
>> +	return !!(event->hw.flags & SPE_PMU_HW_FLAGS_CX);
>> +}
>> +
>>   #define ARM_SPE_BUF_PAD_BYTE			0
>>   
>>   struct arm_spe_pmu_buf {
>> @@ -272,7 +290,7 @@ static u64 arm_spe_event_to_pmscr(struct perf_event *event)
>>   	if (!attr->exclude_kernel)
>>   		reg |= BIT(SYS_PMSCR_EL1_E1SPE_SHIFT);
>>   
>> -	if (IS_ENABLED(CONFIG_PID_IN_CONTEXTIDR) && perfmon_capable())
>> +	if (get_spe_event_has_cx(event))
>>   		reg |= BIT(SYS_PMSCR_EL1_CX_SHIFT);
>>   
>>   	return reg;
>> @@ -709,10 +727,10 @@ static int arm_spe_pmu_event_init(struct perf_event *event)
>>   	    !(spe_pmu->features & SPE_PMU_FEAT_FILT_LAT))
>>   		return -EOPNOTSUPP;
>>   
>> +	set_spe_event_has_cx(event);
>>   	reg = arm_spe_event_to_pmscr(event);
>>   	if (!perfmon_capable() &&
>>   	    (reg & (BIT(SYS_PMSCR_EL1_PA_SHIFT) |
>> -		    BIT(SYS_PMSCR_EL1_CX_SHIFT) |
> 
> The first part of the change looks ok, but I'm not sure about this removal here.
> 
> Doesn't this mean that if you ask for context data when opening the event
> without permission you don't get an error returned any more? It just silently
> ignores it.

How do you ask for context data with SPE ? If there was a way, we don't
need this caching. The CX bit is set unconditionally on 
perfmon_capable() and is not controlled by an attribute. Ideally it is
better to switch to an attribute. But given that it was never there,
I wonder if this would be a problem for the existing perf users ?


> 
> That changes the semantics of the perf event open call and I don't see why that's
> needed to fix the issue about only checking the permissions of the owning process.
> At least it seems like a separate unrelated change.
> 
> It's also worth noting that the value doesn't need to be cached, and another
> one line solution is just to check the permissions of the owning process. This
> avoids duplicating something that is already saved, will survive any future
> refactors of the permissions system, and doesn't use up space in hw_flags:
> 
>     if (IS_ENABLED(CONFIG_PID_IN_CONTEXTIDR) &&
>         (has_capability(event->owner, CAP_PERFMON) || has_capability(event->owner, CAP_SYS_ADMIN)))
>     {
> 	reg |= BIT(SYS_PMSCR_EL1_CX_SHIFT);
>     }

We don't use any bits in the hw_events for SPE. So using a bit for 
storing something doesn't seem to be a wasted effort. Any future
refactors to the permission system would need to take care of the
current users. So that argument is not valid in either case.

Cheers
Suzuki
