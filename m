Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50BE45AEEED
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 17:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233494AbiIFPeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 11:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240355AbiIFPdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 11:33:43 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3ABA9C482A;
        Tue,  6 Sep 2022 07:44:19 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 26AC81AED;
        Tue,  6 Sep 2022 07:37:10 -0700 (PDT)
Received: from [10.57.15.197] (unknown [10.57.15.197])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CAEE03F7B4;
        Tue,  6 Sep 2022 07:37:00 -0700 (PDT)
Message-ID: <caaf43aa-6c36-b263-30ba-7a4d3edd4e20@arm.com>
Date:   Tue, 6 Sep 2022 15:36:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH] perf vendor events: Update events for Neoverse E1
Content-Language: en-GB
To:     John Garry <john.garry@huawei.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Nick Forrington <nick.forrington@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <20220905153020.1792-1-nick.forrington@arm.com>
 <YxdGFAYHeO/j5uJF@kernel.org>
 <496f98ce-a0c4-9587-853c-9ba05323523a@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <496f98ce-a0c4-9587-853c-9ba05323523a@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-09-06 14:22, John Garry wrote:
> On 06/09/2022 14:07, Arnaldo Carvalho de Melo wrote:
>> Em Mon, Sep 05, 2022 at 04:30:19PM +0100, Nick Forrington escreveu:
>>> Based on updated data from:
>>> https://github.com/ARM-software/data/blob/master/pmu/neoverse-e1.json
>>>
>>> which is based on PMU event descriptions from the Arm Neoverse E1
>>> Technical Reference Manual.
>>>
>>> This includes additional implementation defined fields not previously
>>> included, and removes unimplemented events related to Arm's Statistical
>>> Profiling Extension (SPE).
>>
>> Applied locally, would be good to have an Acked-by or Reviewed-by, John?
> 
> Regardless of comment, below:
> Reviewed-by: John Garry <john.garry@huawei.com>
> 
>>
>> - Arnaldo
>>> Signed-off-by: Nick Forrington <nick.forrington@arm.com>
>>> ---
>>>   .../arch/arm64/arm/neoverse-e1/cache.json     | 132 ++++++++++++++++++
>>>   .../arch/arm64/arm/neoverse-e1/dpu.json       |  32 +++++
>>>   .../arch/arm64/arm/neoverse-e1/ifu.json       | 122 ++++++++++++++++
>>>   .../arm64/arm/neoverse-e1/instruction.json    |   6 +
>>>   .../arch/arm64/arm/neoverse-e1/memory.json    |  12 ++
>>>   .../arch/arm64/arm/neoverse-e1/spe.json       |  14 --
>>>   6 files changed, 304 insertions(+), 14 deletions(-)
>>>   create mode 100644 
>>> tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/dpu.json
>>>   create mode 100644 
>>> tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/ifu.json
>>>   delete mode 100644 
>>> tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/spe.json
>>>
>>> diff --git 
>>> a/tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/cache.json 
>>> b/tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/cache.json
>>> index 3ad15e3a93a9..92406bc7b945 100644
>>> --- a/tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/cache.json
>>> +++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/cache.json
>>> @@ -103,5 +103,137 @@
>>>       },
>>>       {
>>>           "ArchStdEvent": "L3D_CACHE_REFILL_RD"
>>> +    },
>>> +    {
>>> +        "PublicDescription": "Merge in the store buffer",
>>> +        "EventCode": "0xC0",
>>> +        "EventName": "STB_STALL",
>>> +        "BriefDescription": "Merge in the store buffer"
> 
> 
> This looks the same as an a65 event. And more similar cases below, at a 
> glance.

According to Anandtech, E1 is to A65 what N1 is to A76, and if they say 
so then it must be true :)

Robin.

> Even though this is not a std or recommended event from the arch 
> reference manual, I don't see a reason why we can't put this as a 
> "armltd_common_impdef_events.json" and make a ArchStdEvent but maybe a 
> distinct name, like "STB_STALL_ARMLTD".
> 
> Nick, Can you please consider at factoring these out also?
> 
> Cheers,
> John
> 
> EOM
> 
>>> +    },
>>> +    {
>>> +        "PublicDescription": "Level 1 data cache refill started due 
>>> to prefetch. Counts any linefills from the prefetcher which cause an 
>>> allocation into the L1 D-cache",
>>> +        "EventCode": "0xC3",
>>> +        "EventName": "L1D_PREF_LINE_FILL",
>>> +        "BriefDescription": "Level 1 data cache refill started due 
>>> to prefetch. Counts any linefills from the prefetcher which cause an 
>>> allocation into the L1 D-cache"
>>> +    },
>>> +    {
>>> +        "PublicDescription": "Level 2 cache refill due to prefetch. 
>>> +ICI If the core is configured with a per-core L2 cache: This event 
>>> does not count. +ICI If the core is configured without a per-core L2 
>>> cache: This event counts the cluster cache event, as defined by 
>>> L3_PREF_LINE_FILL. +ICI If there is neither a per-core cache nor a 
>>> cluster cache configured, this event is not implemented",
>>> +        "EventCode": "0xC4",
>>> +        "EventName": "L2D_PREF_LINE_FILL",
>>> +        "BriefDescription": "Level 2 cache refill due to prefetch. 
>>> +ICI If the core is configured with a per-core L2 cache: This event 
>>> does not count. +ICI If the core is configured without a per-core L2 
>>> cache: This event counts the cluster cache event, as defined by 
>>> L3_PREF_LINE_FILL. +ICI If there is neither a per-core cache nor a 
>>> cluster cache configured, this event is not implemented"
>>> +    },
>>> +    {
>>> +        "PublicDescription": "Level 3 cache refill due to prefetch. 
>>> This event counts any linefills from the hardware prefetcher which 
>>> cause an allocation into the L3 cache. Note It might not be possible 
>>> to distinguish between both hardware and software prefetches and also 
>>> which prefetches cause an allocation. If so, only hardware prefetches 
>>> should be counted, regardless of whether they allocate. If either the 
>>> core is configured without a per-core L2 or the cluster is configured 
>>> without an L3 cache, this event is not implemented",
>>> +        "EventCode": "0xC5",
>>> +        "EventName": "L3_PREF_LINE_FILL",
>>> +        "BriefDescription": "Level 3 cache refill due to prefetch. 
>>> This event counts any linefills from the hardware prefetcher which 
>>> cause an allocation into the L3 cache. Note It might not be possible 
>>> to distinguish between both hardware and software prefetches and also 
>>> which prefetches cause an allocation. If so, only hardware prefetches 
>>> should be counted, regardless of whether they allocate. If either the 
>>> core is configured without a per-core L2 or the cluster is configured 
>>> without an L3 cache, this event is not implemented"
>>> +    },
>>> +    {
>>> +        "PublicDescription": "L1D entering write stream mode",
>>> +        "EventCode": "0xC6",
>>> +        "EventName": "L1D_WS_MODE_ENTER",
>>> +        "BriefDescription": "L1D entering write stream mode"
>>> +    },
>>> +    {
>>> +        "PublicDescription": "L1D is in write stream mode",
>>> +        "EventCode": "0xC7",
>>> +        "EventName": "L1D_WS_MODE",
>>> +        "BriefDescription": "L1D is in write stream mode"
>>> +    },
>>> +    {
>>> +        "PublicDescription": "Level 2 cache write streaming mode. 
>>> This event counts for each cycle where the core is in write-streaming 
>>> mode and not allocating writes into the L2 cache",
>>> +        "EventCode": "0xC8",
>>> +        "EventName": "L2D_WS_MODE",
>>> +        "BriefDescription": "Level 2 cache write streaming mode. 
>>> This event counts for each cycle where the core is in write-streaming 
>>> mode and not allocating writes into the L2 cache"
>>> +    },
>>> +    {
>>> +        "PublicDescription": "Level 3 cache write streaming mode. 
>>> This event counts for each cycle where the core is in write-streaming 
>>> mode and not allocating writes into the L3 cache",
>>> +        "EventCode": "0xC9",
>>> +        "EventName": "L3D_WS_MODE",
>>> +        "BriefDescription": "Level 3 cache write streaming mode. 
>>> This event counts for each cycle where the core is in write-streaming 
>>> mode and not allocating writes into the L3 cache"
>>> +    },
>>> +    {
>>> +        "PublicDescription": "Level 2 TLB last-level walk cache 
>>> access. This event does not count if the MMU is disabled",
>>> +        "EventCode": "0xCA",
>>> +        "EventName": "TLB_L2TLB_LLWALK_ACCESS",
>>> +        "BriefDescription": "Level 2 TLB last-level walk cache 
>>> access. This event does not count if the MMU is disabled"
>>> +    },
>>> +    {
>>> +        "PublicDescription": "Level 2 TLB last-level walk cache 
>>> refill. This event does not count if the MMU is disabled",
>>> +        "EventCode": "0xCB",
>>> +        "EventName": "TLB_L2TLB_LLWALK_REFILL",
>>> +        "BriefDescription": "Level 2 TLB last-level walk cache 
>>> refill. This event does not count if the MMU is disabled"
>>> +    },
>>> +    {
>>> +        "PublicDescription": "Level 2 TLB level-2 walk cache access. 
>>> This event counts accesses to the level-2 walk cache where the 
>>> last-level walk cache has missed. The event only counts when the 
>>> translation regime of the pagewalk uses level 2 descriptors. This 
>>> event does not count if the MMU is disabled",
>>> +        "EventCode": "0xCC",
>>> +        "EventName": "TLB_L2TLB_L2WALK_ACCESS",
>>> +        "BriefDescription": "Level 2 TLB level-2 walk cache access. 
>>> This event counts accesses to the level-2 walk cache where the 
>>> last-level walk cache has missed. The event only counts when the 
>>> translation regime of the pagewalk uses level 2 descriptors. This 
>>> event does not count if the MMU is disabled"
>>> +    },
>>> +    {
>>> +        "PublicDescription": "Level 2 TLB level-2 walk cache refill. 
>>> This event does not count if the MMU is disabled",
>>> +        "EventCode": "0xCD",
>>> +        "EventName": "TLB_L2TLB_L2WALK_REFILL",
>>> +        "BriefDescription": "Level 2 TLB level-2 walk cache refill. 
>>> This event does not count if the MMU is disabled"
>>> +    },
>>> +    {
>>> +        "PublicDescription": "Level 2 TLB IPA cache access. This 
>>> event counts on each access to the IPA cache. +ICI If a single 
>>> pagewalk needs to make multiple accesses to the IPA cache, each 
>>> access is counted. +ICI If stage 2 translation is disabled, this 
>>> event does not count",
>>> +        "EventCode": "0xCE",
>>> +        "EventName": "TLB_L2TLB_S2_ACCESS",
>>> +        "BriefDescription": "Level 2 TLB IPA cache access. This 
>>> event counts on each access to the IPA cache. +ICI If a single 
>>> pagewalk needs to make multiple accesses to the IPA cache, each 
>>> access is counted. +ICI If stage 2 translation is disabled, this 
>>> event does not count"
>>> +    },
>>> +    {
>>> +        "PublicDescription": "Level 2 TLB IPA cache refill. This 
>>> event counts on each refill of the IPA cache. +ICI If a single 
>>> pagewalk needs to make multiple accesses to the IPA cache, each 
>>> access which causes a refill is counted. +ICI If stage 2 translation 
>>> is disabled, this event does not count",
>>> +        "EventCode": "0xCF",
>>> +        "EventName": "TLB_L2TLB_S2_REFILL",
>>> +        "BriefDescription": "Level 2 TLB IPA cache refill. This 
>>> event counts on each refill of the IPA cache. +ICI If a single 
>>> pagewalk needs to make multiple accesses to the IPA cache, each 
>>> access which causes a refill is counted. +ICI If stage 2 translation 
>>> is disabled, this event does not count"
>>> +    },
>>> +    {
>>> +        "PublicDescription": "Unattributable Level 1 data cache 
>>> write-back. This event occurs when a requestor outside the PE makes a 
>>> coherency request that results in writeback",
>>> +        "EventCode": "0xF0",
>>> +        "EventName": "L2_L1D_CACHE_WB_UNATT",
>>> +        "BriefDescription": "Unattributable Level 1 data cache 
>>> write-back. This event occurs when a requestor outside the PE makes a 
>>> coherency request that results in writeback"
>>> +    },
>>> +    {
>>> +        "PublicDescription": "Unattributable Level 2 unified cache 
>>> access. This event occurs when a requestor outside the PE makes a 
>>> coherency request that results in level 2 unified cache access",
>>> +        "EventCode": "0xF1",
>>> +        "EventName": "L2_L2D_CACHE_UNATT",
>>> +        "BriefDescription": "Unattributable Level 2 unified cache 
>>> access. This event occurs when a requestor outside the PE makes a 
>>> coherency request that results in level 2 unified cache access"
>>> +    },
>>> +    {
>>> +        "PublicDescription": "Unattributable Level 2 unified cache 
>>> access, read. This event occurs when a requestor outside the PE makes 
>>> a coherency request that results in level 2 unified cache read access",
>>> +        "EventCode": "0xF2",
>>> +        "EventName": "L2_L2D_CACHE_RD_UNATT",
>>> +        "BriefDescription": "Unattributable Level 2 unified cache 
>>> access, read. This event occurs when a requestor outside the PE makes 
>>> a coherency request that results in level 2 unified cache read access"
>>> +    },
>>> +    {
>>> +        "PublicDescription": "Unattributable Level 3 unified cache 
>>> access. This event occurs when a requestor outside the PE makes a 
>>> coherency request that results in level 3 unified cache read access",
>>> +        "EventCode": "0xF3",
>>> +        "EventName": "L2_L3D_CACHE_UNATT",
>>> +        "BriefDescription": "Unattributable Level 3 unified cache 
>>> access. This event occurs when a requestor outside the PE makes a 
>>> coherency request that results in level 3 unified cache read access"
>>> +    },
>>> +    {
>>> +        "PublicDescription": "Unattributable Level 3 unified cache 
>>> access, read. This event occurs when a requestor outside the PE makes 
>>> a coherency request that results in level 3 unified cache read access",
>>> +        "EventCode": "0xF4",
>>> +        "EventName": "L2_L3D_CACHE_RD_UNATT",
>>> +        "BriefDescription": "Unattributable Level 3 unified cache 
>>> access, read. This event occurs when a requestor outside the PE makes 
>>> a coherency request that results in level 3 unified cache read access"
>>> +    },
>>> +    {
>>> +        "PublicDescription": "Unattributable Level 3 unified cache 
>>> allocation without refill. This event occurs when a requestor outside 
>>> the PE makes a coherency request that results in level 3 cache 
>>> allocate without refill",
>>> +        "EventCode": "0xF5",
>>> +        "EventName": "L2_L3D_CACHE_ALLOC_UNATT",
>>> +        "BriefDescription": "Unattributable Level 3 unified cache 
>>> allocation without refill. This event occurs when a requestor outside 
>>> the PE makes a coherency request that results in level 3 cache 
>>> allocate without refill"
>>> +    },
>>> +    {
>>> +        "PublicDescription": "Unattributable Level 3 unified cache 
>>> refill. This event occurs when a requestor outside the PE makes a 
>>> coherency request that results in level 3 cache refill",
>>> +        "EventCode": "0xF6",
>>> +        "EventName": "L2_L3D_CACHE_REFILL_UNATT",
>>> +        "BriefDescription": "Unattributable Level 3 unified cache 
>>> refill. This event occurs when a requestor outside the PE makes a 
>>> coherency request that results in level 3 cache refill"
>>> +    },
>>> +    {
>>> +        "PublicDescription": "Level 2 cache stash dropped. This 
>>> event counts on each stash request received from the interconnect or 
>>> ACP, that is targeting L2 and gets dropped due to lack of buffer 
>>> space to hold the request",
>>> +        "EventCode": "0xF7",
>>> +        "EventName": "L2D_CACHE_STASH_DROPPED",
>>> +        "BriefDescription": "Level 2 cache stash dropped. This event 
>>> counts on each stash request received from the interconnect or ACP, 
>>> that is targeting L2 and gets dropped due to lack of buffer space to 
>>> hold the request"
>>>       }
>>>   ]
>>> diff --git 
>>> a/tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/dpu.json 
>>> b/tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/dpu.json
>>> new file mode 100644
>>> index 000000000000..b8e402a91bdd
>>> --- /dev/null
>>> +++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/dpu.json
>>> @@ -0,0 +1,32 @@
>>> +[
>>> +    {
>>> +        "PublicDescription": "Instruction retired, indirect branch, 
>>> mispredicted",
>>> +        "EventCode": "0xE9",
>>> +        "EventName": "DPU_BR_IND_MIS",
>>> +        "BriefDescription": "Instruction retired, indirect branch, 
>>> mispredicted"
>>> +    },
>>> +    {
>>> +        "PublicDescription": "Instruction retired, conditional 
>>> branch, mispredicted",
>>> +        "EventCode": "0xEA",
>>> +        "EventName": "DPU_BR_COND_MIS",
>>> +        "BriefDescription": "Instruction retired, conditional 
>>> branch, mispredicted"
>>> +    },
>>> +    {
>>> +        "PublicDescription": "Memory error (any type) from IFU",
>>> +        "EventCode": "0xEB",
>>> +        "EventName": "DPU_MEM_ERR_IFU",
>>> +        "BriefDescription": "Memory error (any type) from IFU"
>>> +    },
>>> +    {
>>> +        "PublicDescription": "Memory error (any type) from DCU",
>>> +        "EventCode": "0xEC",
>>> +        "EventName": "DPU_MEM_ERR_DCU",
>>> +        "BriefDescription": "Memory error (any type) from DCU"
>>> +    },
>>> +    {
>>> +        "PublicDescription": "Memory error (any type) from TLB",
>>> +        "EventCode": "0xED",
>>> +        "EventName": "DPU_MEM_ERR_TLB",
>>> +        "BriefDescription": "Memory error (any type) from TLB"
>>> +    }
>>> +]
>>> diff --git 
>>> a/tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/ifu.json 
>>> b/tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/ifu.json
>>> new file mode 100644
>>> index 000000000000..13178c5dca14
>>> --- /dev/null
>>> +++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/ifu.json
>>> @@ -0,0 +1,122 @@
>>> +[
>>> +    {
>>> +        "PublicDescription": "I-Cache miss on an access from the 
>>> prefetch block",
>>> +        "EventCode": "0xD0",
>>> +        "EventName": "IFU_IC_MISS_WAIT",
>>> +        "BriefDescription": "I-Cache miss on an access from the 
>>> prefetch block"
>>> +    },
>>> +    {
>>> +        "PublicDescription": "Counts the cycles spent on a request 
>>> for Level 2 TLB lookup after a Level 1l ITLB miss",
>>> +        "EventCode": "0xD1",
>>> +        "EventName": "IFU_IUTLB_MISS_WAIT",
>>> +        "BriefDescription": "Counts the cycles spent on a request 
>>> for Level 2 TLB lookup after a Level 1l ITLB miss"
>>> +    },
>>> +    {
>>> +        "PublicDescription": "Micro-predictor conditional/direction 
>>> mispredict, with respect to. if3/if4 predictor",
>>> +        "EventCode": "0xD2",
>>> +        "EventName": "IFU_MICRO_COND_MISPRED",
>>> +        "BriefDescription": "Micro-predictor conditional/direction 
>>> mispredict, with respect to. if3/if4 predictor"
>>> +    },
>>> +    {
>>> +        "PublicDescription": "Micro-predictor address mispredict, 
>>> with respect to if3/if4 predictor",
>>> +        "EventCode": "0xD3",
>>> +        "EventName": "IFU_MICRO_CADDR_MISPRED",
>>> +        "BriefDescription": "Micro-predictor address mispredict, 
>>> with respect to if3/if4 predictor"
>>> +    },
>>> +    {
>>> +        "PublicDescription": "Micro-predictor hit with immediate 
>>> redirect",
>>> +        "EventCode": "0xD4",
>>> +        "EventName": "IFU_MICRO_HIT",
>>> +        "BriefDescription": "Micro-predictor hit with immediate 
>>> redirect"
>>> +    },
>>> +    {
>>> +        "PublicDescription": "Micro-predictor negative cache hit",
>>> +        "EventCode": "0xD6",
>>> +        "EventName": "IFU_MICRO_NEG_HIT",
>>> +        "BriefDescription": "Micro-predictor negative cache hit"
>>> +    },
>>> +    {
>>> +        "PublicDescription": "Micro-predictor correction",
>>> +        "EventCode": "0xD7",
>>> +        "EventName": "IFU_MICRO_CORRECTION",
>>> +        "BriefDescription": "Micro-predictor correction"
>>> +    },
>>> +    {
>>> +        "PublicDescription": "A 2nd instruction could have been 
>>> pushed but was not because it was nonsequential",
>>> +        "EventCode": "0xD8",
>>> +        "EventName": "IFU_MICRO_NO_INSTR1",
>>> +        "BriefDescription": "A 2nd instruction could have been 
>>> pushed but was not because it was nonsequential"
>>> +    },
>>> +    {
>>> +        "PublicDescription": "Micro-predictor miss",
>>> +        "EventCode": "0xD9",
>>> +        "EventName": "IFU_MICRO_NO_PRED",
>>> +        "BriefDescription": "Micro-predictor miss"
>>> +    },
>>> +    {
>>> +        "PublicDescription": "Thread flushed due to TLB miss",
>>> +        "EventCode": "0xDA",
>>> +        "EventName": "IFU_FLUSHED_TLB_MISS",
>>> +        "BriefDescription": "Thread flushed due to TLB miss"
>>> +    },
>>> +    {
>>> +        "PublicDescription": "Thread flushed due to reasons other 
>>> than TLB miss",
>>> +        "EventCode": "0xDB",
>>> +        "EventName": "IFU_FLUSHED_EXCL_TLB_MISS",
>>> +        "BriefDescription": "Thread flushed due to reasons other 
>>> than TLB miss"
>>> +    },
>>> +    {
>>> +        "PublicDescription": "This thread and the other thread both 
>>> ready for scheduling in if0",
>>> +        "EventCode": "0xDC",
>>> +        "EventName": "IFU_ALL_THRDS_RDY",
>>> +        "BriefDescription": "This thread and the other thread both 
>>> ready for scheduling in if0"
>>> +    },
>>> +    {
>>> +        "PublicDescription": "This thread was arbitrated when the 
>>> other thread was also ready for scheduling",
>>> +        "EventCode": "0xDD",
>>> +        "EventName": "IFU_WIN_ARB_OTHER_RDY",
>>> +        "BriefDescription": "This thread was arbitrated when the 
>>> other thread was also ready for scheduling"
>>> +    },
>>> +    {
>>> +        "PublicDescription": "This thread was arbitrated when the 
>>> other thread was also active, but not necessarily ready. For example, 
>>> waiting for I-Cache or TLB",
>>> +        "EventCode": "0xDE",
>>> +        "EventName": "IFU_WIN_ARB_OTHER_ACT",
>>> +        "BriefDescription": "This thread was arbitrated when the 
>>> other thread was also active, but not necessarily ready. For example, 
>>> waiting for I-Cache or TLB"
>>> +    },
>>> +    {
>>> +        "PublicDescription": "This thread was not arbitrated because 
>>> it was not ready for scheduling. For example, due to a cache miss or 
>>> TLB miss",
>>> +        "EventCode": "0xDF",
>>> +        "EventName": "IFU_NOT_RDY_FOR_ARB",
>>> +        "BriefDescription": "This thread was not arbitrated because 
>>> it was not ready for scheduling. For example, due to a cache miss or 
>>> TLB miss"
>>> +    },
>>> +    {
>>> +        "PublicDescription": "The thread moved from an active state 
>>> to an inactive state (long-term sleep state, causing deallocation of 
>>> some resources)",
>>> +        "EventCode": "0xE0",
>>> +        "EventName": "IFU_GOTO_IDLE",
>>> +        "BriefDescription": "The thread moved from an active state 
>>> to an inactive state (long-term sleep state, causing deallocation of 
>>> some resources)"
>>> +    },
>>> +    {
>>> +        "PublicDescription": "I-Cache lookup under miss from other 
>>> thread",
>>> +        "EventCode": "0xE1",
>>> +        "EventName": "IFU_IC_LOOKUP_UNDER_MISS",
>>> +        "BriefDescription": "I-Cache lookup under miss from other 
>>> thread"
>>> +    },
>>> +    {
>>> +        "PublicDescription": "I-Cache miss under miss from other 
>>> thread",
>>> +        "EventCode": "0xE2",
>>> +        "EventName": "IFU_IC_MISS_UNDER_MISS",
>>> +        "BriefDescription": "I-Cache miss under miss from other thread"
>>> +    },
>>> +    {
>>> +        "PublicDescription": "This thread pushed an instruction into 
>>> the IQ",
>>> +        "EventCode": "0xE3",
>>> +        "EventName": "IFU_INSTR_PUSHED",
>>> +        "BriefDescription": "This thread pushed an instruction into 
>>> the IQ"
>>> +    },
>>> +    {
>>> +        "PublicDescription": "I-Cache Speculative line fill",
>>> +        "EventCode": "0xE4",
>>> +        "EventName": "IFU_IC_LF_SP",
>>> +        "BriefDescription": "I-Cache Speculative line fill"
>>> +    }
>>> +]
>>> diff --git 
>>> a/tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/instruction.json 
>>> b/tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/instruction.json
>>> index 6c3b8f772e7f..2e0d60779dce 100644
>>> --- a/tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/instruction.json
>>> +++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/instruction.json
>>> @@ -61,5 +61,11 @@
>>>       },
>>>       {
>>>           "ArchStdEvent": "ISB_SPEC"
>>> +    },
>>> +    {
>>> +        "PublicDescription": "Instruction retired, conditional branch",
>>> +        "EventCode": "0xE8",
>>> +        "EventName": "DPU_BR_COND_RETIRED",
>>> +        "BriefDescription": "Instruction retired, conditional branch"
>>>       }
>>>   ]
>>> diff --git 
>>> a/tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/memory.json 
>>> b/tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/memory.json
>>> index 78ed6dfcedc1..18d527f7fad4 100644
>>> --- a/tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/memory.json
>>> +++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/memory.json
>>> @@ -19,5 +19,17 @@
>>>       },
>>>       {
>>>           "ArchStdEvent": "UNALIGNED_LDST_SPEC"
>>> +    },
>>> +    {
>>> +        "PublicDescription": "External memory request",
>>> +        "EventCode": "0xC1",
>>> +        "EventName": "BIU_EXT_MEM_REQ",
>>> +        "BriefDescription": "External memory request"
>>> +    },
>>> +    {
>>> +        "PublicDescription": "External memory request to 
>>> non-cacheable memory",
>>> +        "EventCode": "0xC2",
>>> +        "EventName": "BIU_EXT_MEM_REQ_NC",
>>> +        "BriefDescription": "External memory request to 
>>> non-cacheable memory"
>>>       }
>>>   ]
>>> diff --git 
>>> a/tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/spe.json 
>>> b/tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/spe.json
>>> deleted file mode 100644
>>> index 20f2165c85fe..000000000000
>>> --- a/tools/perf/pmu-events/arch/arm64/arm/neoverse-e1/spe.json
>>> +++ /dev/null
>>> @@ -1,14 +0,0 @@
>>> -[
>>> -    {
>>> -        "ArchStdEvent": "SAMPLE_POP"
>>> -    },
>>> -    {
>>> -        "ArchStdEvent": "SAMPLE_FEED"
>>> -    },
>>> -    {
>>> -        "ArchStdEvent": "SAMPLE_FILTRATE"
>>> -    },
>>> -    {
>>> -        "ArchStdEvent": "SAMPLE_COLLISION"
>>> -    }
>>> -]
>>> -- 
>>> 2.25.1
>>
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
