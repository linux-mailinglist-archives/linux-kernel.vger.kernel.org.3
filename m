Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF7C49F1EA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 04:38:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345805AbiA1DiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 22:38:20 -0500
Received: from foss.arm.com ([217.140.110.172]:44322 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241873AbiA1DiT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 22:38:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F0BAB113E;
        Thu, 27 Jan 2022 19:38:18 -0800 (PST)
Received: from [10.163.44.75] (unknown [10.163.44.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EB3733F793;
        Thu, 27 Jan 2022 19:38:14 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [RFC V1 03/11] arm64/perf: Update struct arm_pmu for BRBE
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org
References: <1642998653-21377-1-git-send-email-anshuman.khandual@arm.com>
 <1642998653-21377-4-git-send-email-anshuman.khandual@arm.com>
 <YfF+APV2vew5AloE@robh.at.kernel.org>
Message-ID: <c3804290-bdb1-d1eb-3526-9b0ce4c8e8b1@arm.com>
Date:   Fri, 28 Jan 2022 09:08:20 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YfF+APV2vew5AloE@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/26/22 10:29 PM, Rob Herring wrote:
> On Mon, Jan 24, 2022 at 10:00:45AM +0530, Anshuman Khandual wrote:
>> This updates struct arm_pmu to include all required helpers that will drive
> 
>>From submitting-patches.rst:
> 
> Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
> instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
> to do frotz", as if you are giving orders to the codebase to change
> its behaviour.

s/This updates struct arm_pmu to/Update struct arm_pmu to/ should address
this problem I guess. Although the difference here seems very subtle :)

> 
>> BRBE functionality for a given PMU implementation. These are the following.
> 
> Don't describe what the change is, one can read the diff for that. 

Sure, though was trying just to enumerate a potential driver's functional
responsibilities.

> Answer why it is needed.

Sure.

> 
> One thing to answer in the commit msg is why we need the hooks here.  
> Have we concluded that adding BRBE hooks to struct arm_pmu for what is 
> an armv8 specific feature is the right approach? I don't recall 
> reaching that conclusion.

Although it might be possible to have this implementation embedded in
the existing armv8 PMU implementation, I still believe that the BRBE
functionalities abstracted out at the arm_pmu level with a separate
config option is cleaner, easier to follow and to maintain as well.

Besides some helpers i.e brbe_supported(), brbe_probe() and brbe_reset()
might not fit seamlessly, when tried to be embedded via existing arm_pmu
helpers in the armv8 implementation.

Nonetheless if arm_pmu based additional BRBE helpers is absolutely a no
go for folks here in general, will explore arm64 based implementation.

> 
>>
>> - brbe_filter	: Convert perf event filters into BRBE HW filters
>> - brbe_probe	: Probe BRBE HW and capture its attributes
>> - brbe_enable	: Enable BRBE HW with a given config
>> - brbe_disable	: Disable BRBE HW
>> - brbe_read	: Read BRBE buffer for captured branch records
>> - brbe_reset	: Reset BRBE buffer
>> - brbe_supported: Whether BRBE is supported or not
> 
> The function names seem pretty self-explanatory, but the text is needed, 
> shouldn't it be in the struct declaration.

Sure, sounds good. Will move there.

> 
> I'm not really a fan of patches adding dead code. That's not any less to 
> review. Restructuring with 'no functional change' OTOH is helpful in 
> reviewing.

Restructuring without functional change clarifies the purpose better.
Besides this is more relevant in this context where the functions will
be provided by a separate (and also detached) driver implementation.

>> A BRBE driver implementation needs to provide these functionalities.
>>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-perf-users@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>  arch/arm64/kernel/perf_event.c | 36 ++++++++++++++++++++++++++++++++++
>>  include/linux/perf/arm_pmu.h   |  7 +++++++
>>  2 files changed, 43 insertions(+)
>>
>> diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
>> index cab678ed6618..f6a47036b0b4 100644
>> --- a/arch/arm64/kernel/perf_event.c
>> +++ b/arch/arm64/kernel/perf_event.c
>> @@ -1015,6 +1015,35 @@ static int armv8pmu_filter_match(struct perf_event *event)
>>  	return evtype != ARMV8_PMUV3_PERFCTR_CHAIN;
>>  }
>>  
>> +static void armv8pmu_brbe_filter(struct pmu_hw_events *hw_event, struct perf_event *event)
>> +{
>> +}
>> +
>> +static void armv8pmu_brbe_enable(struct pmu_hw_events *hw_event)
>> +{
>> +}
>> +
>> +static void armv8pmu_brbe_disable(struct pmu_hw_events *hw_event)
>> +{
>> +}
>> +
>> +static void armv8pmu_brbe_read(struct pmu_hw_events *hw_event, struct perf_event *event)
>> +{
>> +}
>> +
>> +static void armv8pmu_brbe_probe(struct pmu_hw_events *hw_event)
>> +{
>> +}
>> +
>> +static void armv8pmu_brbe_reset(struct pmu_hw_events *hw_event)
>> +{
>> +}
>> +
>> +static bool armv8pmu_brbe_supported(struct perf_event *event)
>> +{
>> +	return false;
>> +}
>> +
>>  static void armv8pmu_reset(void *info)
>>  {
>>  	struct arm_pmu *cpu_pmu = (struct arm_pmu *)info;
>> @@ -1247,6 +1276,13 @@ static int armv8_pmu_init(struct arm_pmu *cpu_pmu, char *name,
>>  
>>  	cpu_pmu->pmu.event_idx		= armv8pmu_user_event_idx;
>>  
>> +	cpu_pmu->brbe_filter		= armv8pmu_brbe_filter;
>> +	cpu_pmu->brbe_enable		= armv8pmu_brbe_enable;
>> +	cpu_pmu->brbe_disable		= armv8pmu_brbe_disable;
>> +	cpu_pmu->brbe_read		= armv8pmu_brbe_read;
>> +	cpu_pmu->brbe_probe		= armv8pmu_brbe_probe;
>> +	cpu_pmu->brbe_reset		= armv8pmu_brbe_reset;
>> +	cpu_pmu->brbe_supported		= armv8pmu_brbe_supported;
>>  	cpu_pmu->name			= name;
>>  	cpu_pmu->map_event		= map_event;
>>  	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_EVENTS] = events ?
>> diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
>> index 2512e2f9cd4e..c0dd0d6c5883 100644
>> --- a/include/linux/perf/arm_pmu.h
>> +++ b/include/linux/perf/arm_pmu.h
>> @@ -98,6 +98,13 @@ struct arm_pmu {
>>  	void		(*reset)(void *);
>>  	int		(*map_event)(struct perf_event *event);
>>  	int		(*filter_match)(struct perf_event *event);
>> +	void		(*brbe_filter)(struct pmu_hw_events *hw_events, struct perf_event *event);
>> +	void		(*brbe_probe)(struct pmu_hw_events *hw_events);
>> +	void		(*brbe_enable)(struct pmu_hw_events *hw_events);
>> +	void		(*brbe_disable)(struct pmu_hw_events *hw_events);
>> +	void		(*brbe_read)(struct pmu_hw_events *hw_events, struct perf_event *event);
>> +	void		(*brbe_reset)(struct pmu_hw_events *hw_events);
>> +	bool		(*brbe_supported)(struct perf_event *event);
>>  	int		num_events;
>>  	bool		secure_access; /* 32-bit ARM only */
>>  #define ARMV8_PMUV3_MAX_COMMON_EVENTS		0x40
>> -- 
>> 2.25.1
>>
>>
