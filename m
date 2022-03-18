Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06B3A4DD701
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 10:22:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234390AbiCRJXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 05:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234377AbiCRJXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 05:23:46 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227F92C57B0;
        Fri, 18 Mar 2022 02:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647595347; x=1679131347;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0X29nA9sz3mIpWAQXLTR481A1mLnnsdD9nQz2Zd8BBI=;
  b=HbFYeALPjSh2FL0EYkGKKsd1o5yHXDhD1LiRaN4jqwj2H2s94miHwxZI
   joi/EvoABkr257iNOe9ktL7s1uMLVx1N/hKNQFxs7Z46p/ymDJuaS79ye
   hYMSTbmWVfBLHTIcsEaDtDJbVCyBimsh6qNU9xN436qLeMheZWZO5e5Ec
   3t/occ26fym12wpis2J9hKPunh+h2EnLIA8gI3QBh9vlzPQHKuLcGRo/6
   NDooqkXOVbevInNs7glJZecx3uaxsfbw3df195lMEe7fcaOkqZqImvIzX
   uAWxNqcwT3xvM064WE+8frIc3FPfWpkLMH9YiHxDkogqOP7paPVsQ302/
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="239262401"
X-IronPort-AV: E=Sophos;i="5.90,191,1643702400"; 
   d="scan'208";a="239262401"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 02:22:26 -0700
X-IronPort-AV: E=Sophos;i="5.90,191,1643702400"; 
   d="scan'208";a="558340183"
Received: from xingzhen-mobl.ccr.corp.intel.com (HELO [10.255.31.171]) ([10.255.31.171])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 02:22:22 -0700
Message-ID: <b519e63b-4b65-b683-7e01-6d9abc422eae@linux.intel.com>
Date:   Fri, 18 Mar 2022 17:22:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 7/8] perf vendor events: Update events for Tigerlake
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andi Kleen <ak@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        John Garry <john.garry@huawei.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>
References: <20220317182858.484474-1-irogers@google.com>
 <20220317182858.484474-7-irogers@google.com>
From:   Xing Zhengjun <zhengjun.xing@linux.intel.com>
In-Reply-To: <20220317182858.484474-7-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/18/2022 2:28 AM, Ian Rogers wrote:
> The change:
> https://github.com/intel/event-converter-for-linux-perf/commit/fc680410402e394eed6a1ebd909c9f649d3ed3ef
> moved certain "other" type of events in to the cache and pipeline topics.
> Update the perf json files for this change.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

Reviewed-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>

> ---
>   .../pmu-events/arch/x86/tigerlake/cache.json  |  86 ++++++++++++
>   .../pmu-events/arch/x86/tigerlake/other.json  | 129 ------------------
>   .../arch/x86/tigerlake/pipeline.json          |  43 ++++++
>   3 files changed, 129 insertions(+), 129 deletions(-)
> 
> diff --git a/tools/perf/pmu-events/arch/x86/tigerlake/cache.json b/tools/perf/pmu-events/arch/x86/tigerlake/cache.json
> index 543a3298f86f..0569b2c704ca 100644
> --- a/tools/perf/pmu-events/arch/x86/tigerlake/cache.json
> +++ b/tools/perf/pmu-events/arch/x86/tigerlake/cache.json
> @@ -493,6 +493,48 @@
>           "SampleAfterValue": "50021",
>           "UMask": "0x20"
>       },
> +    {
> +        "BriefDescription": "Counts demand data reads that hit a cacheline in the L3 where a snoop hit in another cores caches, data forwarding is required as the data is modified.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0xB7, 0xBB",
> +        "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x10003C0001",
> +        "Offcore": "1",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_WITH_FWD",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0xB7, 0xBB",
> +        "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_WITH_FWD",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x8003C0001",
> +        "Offcore": "1",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts demand reads for ownership (RFO) requests and software prefetches for exclusive ownership (PREFETCHW) that hit a cacheline in the L3 where a snoop hit in another cores caches, data forwarding is required as the data is modified.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0xB7, 0xBB",
> +        "EventName": "OCR.DEMAND_RFO.L3_HIT.SNOOP_HITM",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x10003C0002",
> +        "Offcore": "1",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    },
>       {
>           "BriefDescription": "Demand and prefetch data reads",
>           "CollectPEBSRecord": "2",
> @@ -627,5 +669,49 @@
>           "PublicDescription": "Counts the cycles for which the thread is active and the superQ cannot take any more entries.",
>           "SampleAfterValue": "100003",
>           "UMask": "0x4"
> +    },
> +    {
> +        "BriefDescription": "Number of PREFETCHNTA instructions executed.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x32",
> +        "EventName": "SW_PREFETCH_ACCESS.NTA",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts the number of PREFETCHNTA instructions executed.",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Number of PREFETCHW instructions executed.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x32",
> +        "EventName": "SW_PREFETCH_ACCESS.PREFETCHW",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts the number of PREFETCHW instructions executed.",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x8"
> +    },
> +    {
> +        "BriefDescription": "Number of PREFETCHT0 instructions executed.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x32",
> +        "EventName": "SW_PREFETCH_ACCESS.T0",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts the number of PREFETCHT0 instructions executed.",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x2"
> +    },
> +    {
> +        "BriefDescription": "Number of PREFETCHT1 or PREFETCHT2 instructions executed.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x32",
> +        "EventName": "SW_PREFETCH_ACCESS.T1_T2",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts the number of PREFETCHT1 or PREFETCHT2 instructions executed.",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x4"
>       }
>   ]
> \ No newline at end of file
> diff --git a/tools/perf/pmu-events/arch/x86/tigerlake/other.json b/tools/perf/pmu-events/arch/x86/tigerlake/other.json
> index b1143fe74246..304cd09fe159 100644
> --- a/tools/perf/pmu-events/arch/x86/tigerlake/other.json
> +++ b/tools/perf/pmu-events/arch/x86/tigerlake/other.json
> @@ -43,48 +43,6 @@
>           "SampleAfterValue": "200003",
>           "UMask": "0x20"
>       },
> -    {
> -        "BriefDescription": "Counts demand data reads that hit a cacheline in the L3 where a snoop hit in another cores caches, data forwarding is required as the data is modified.",
> -        "CollectPEBSRecord": "2",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0xB7, 0xBB",
> -        "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x10003C0001",
> -        "Offcore": "1",
> -        "PEBScounters": "0,1,2,3",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_WITH_FWD",
> -        "CollectPEBSRecord": "2",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0xB7, 0xBB",
> -        "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_WITH_FWD",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x8003C0001",
> -        "Offcore": "1",
> -        "PEBScounters": "0,1,2,3",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts demand reads for ownership (RFO) requests and software prefetches for exclusive ownership (PREFETCHW) that hit a cacheline in the L3 where a snoop hit in another cores caches, data forwarding is required as the data is modified.",
> -        "CollectPEBSRecord": "2",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0xB7, 0xBB",
> -        "EventName": "OCR.DEMAND_RFO.L3_HIT.SNOOP_HITM",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x10003C0002",
> -        "Offcore": "1",
> -        "PEBScounters": "0,1,2,3",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "UMask": "0x1"
> -    },
>       {
>           "BriefDescription": "Counts streaming stores that have any type of response.",
>           "CollectPEBSRecord": "2",
> @@ -98,92 +56,5 @@
>           "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
>           "SampleAfterValue": "100003",
>           "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Number of PREFETCHNTA instructions executed.",
> -        "CollectPEBSRecord": "2",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0x32",
> -        "EventName": "SW_PREFETCH_ACCESS.NTA",
> -        "PEBScounters": "0,1,2,3",
> -        "PublicDescription": "Counts the number of PREFETCHNTA instructions executed.",
> -        "SampleAfterValue": "100003",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Number of PREFETCHW instructions executed.",
> -        "CollectPEBSRecord": "2",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0x32",
> -        "EventName": "SW_PREFETCH_ACCESS.PREFETCHW",
> -        "PEBScounters": "0,1,2,3",
> -        "PublicDescription": "Counts the number of PREFETCHW instructions executed.",
> -        "SampleAfterValue": "100003",
> -        "UMask": "0x8"
> -    },
> -    {
> -        "BriefDescription": "Number of PREFETCHT0 instructions executed.",
> -        "CollectPEBSRecord": "2",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0x32",
> -        "EventName": "SW_PREFETCH_ACCESS.T0",
> -        "PEBScounters": "0,1,2,3",
> -        "PublicDescription": "Counts the number of PREFETCHT0 instructions executed.",
> -        "SampleAfterValue": "100003",
> -        "UMask": "0x2"
> -    },
> -    {
> -        "BriefDescription": "Number of PREFETCHT1 or PREFETCHT2 instructions executed.",
> -        "CollectPEBSRecord": "2",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0x32",
> -        "EventName": "SW_PREFETCH_ACCESS.T1_T2",
> -        "PEBScounters": "0,1,2,3",
> -        "PublicDescription": "Counts the number of PREFETCHT1 or PREFETCHT2 instructions executed.",
> -        "SampleAfterValue": "100003",
> -        "UMask": "0x4"
> -    },
> -    {
> -        "BriefDescription": "TMA slots where no uops were being issued due to lack of back-end resources.",
> -        "CollectPEBSRecord": "2",
> -        "Counter": "0,1,2,3,4,5,6,7",
> -        "EventCode": "0xa4",
> -        "EventName": "TOPDOWN.BACKEND_BOUND_SLOTS",
> -        "PEBScounters": "0,1,2,3,4,5,6,7",
> -        "PublicDescription": "Counts the number of Top-down Microarchitecture Analysis (TMA) method's  slots where no micro-operations were being issued from front-end to back-end of the machine due to lack of back-end resources.",
> -        "SampleAfterValue": "10000003",
> -        "UMask": "0x2"
> -    },
> -    {
> -        "BriefDescription": "TMA slots wasted due to incorrect speculation by branch mispredictions",
> -        "CollectPEBSRecord": "2",
> -        "Counter": "0,1,2,3,4,5,6,7",
> -        "EventCode": "0xa4",
> -        "EventName": "TOPDOWN.BR_MISPREDICT_SLOTS",
> -        "PEBScounters": "0,1,2,3,4,5,6,7",
> -        "PublicDescription": "Number of TMA slots that were wasted due to incorrect speculation by branch mispredictions. This event estimates number of operations that were issued but not retired from the specualtive path as well as the out-of-order engine recovery past a branch misprediction.",
> -        "SampleAfterValue": "10000003",
> -        "UMask": "0x8"
> -    },
> -    {
> -        "BriefDescription": "TMA slots available for an unhalted logical processor. Fixed counter - architectural event",
> -        "CollectPEBSRecord": "2",
> -        "Counter": "Fixed counter 3",
> -        "EventName": "TOPDOWN.SLOTS",
> -        "PEBScounters": "35",
> -        "PublicDescription": "Number of available slots for an unhalted logical processor. The event increments by machine-width of the narrowest pipeline as employed by the Top-down Microarchitecture Analysis method (TMA). The count is distributed among unhalted logical processors (hyper-threads) who share the same physical core. Software can use this event as the denominator for the top-level metrics of the TMA method. This architectural event is counted on a designated fixed counter (Fixed Counter 3).",
> -        "SampleAfterValue": "10000003",
> -        "UMask": "0x4"
> -    },
> -    {
> -        "BriefDescription": "TMA slots available for an unhalted logical processor. General counter - architectural event",
> -        "CollectPEBSRecord": "2",
> -        "Counter": "0,1,2,3,4,5,6,7",
> -        "EventCode": "0xa4",
> -        "EventName": "TOPDOWN.SLOTS_P",
> -        "PEBScounters": "0,1,2,3,4,5,6,7",
> -        "PublicDescription": "Counts the number of available slots for an unhalted logical processor. The event increments by machine-width of the narrowest pipeline as employed by the Top-down Microarchitecture Analysis method. The count is distributed among unhalted logical processors (hyper-threads) who share the same physical core.",
> -        "SampleAfterValue": "10000003",
> -        "UMask": "0x1"
>       }
>   ]
> \ No newline at end of file
> diff --git a/tools/perf/pmu-events/arch/x86/tigerlake/pipeline.json b/tools/perf/pmu-events/arch/x86/tigerlake/pipeline.json
> index 4dc3a16e3da4..d436775c80db 100644
> --- a/tools/perf/pmu-events/arch/x86/tigerlake/pipeline.json
> +++ b/tools/perf/pmu-events/arch/x86/tigerlake/pipeline.json
> @@ -711,6 +711,49 @@
>           "SampleAfterValue": "100003",
>           "UMask": "0x1"
>       },
> +    {
> +        "BriefDescription": "TMA slots where no uops were being issued due to lack of back-end resources.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "EventCode": "0xa4",
> +        "EventName": "TOPDOWN.BACKEND_BOUND_SLOTS",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "PublicDescription": "Counts the number of Top-down Microarchitecture Analysis (TMA) method's  slots where no micro-operations were being issued from front-end to back-end of the machine due to lack of back-end resources.",
> +        "SampleAfterValue": "10000003",
> +        "UMask": "0x2"
> +    },
> +    {
> +        "BriefDescription": "TMA slots wasted due to incorrect speculation by branch mispredictions",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "EventCode": "0xa4",
> +        "EventName": "TOPDOWN.BR_MISPREDICT_SLOTS",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "PublicDescription": "Number of TMA slots that were wasted due to incorrect speculation by branch mispredictions. This event estimates number of operations that were issued but not retired from the specualtive path as well as the out-of-order engine recovery past a branch misprediction.",
> +        "SampleAfterValue": "10000003",
> +        "UMask": "0x8"
> +    },
> +    {
> +        "BriefDescription": "TMA slots available for an unhalted logical processor. Fixed counter - architectural event",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "Fixed counter 3",
> +        "EventName": "TOPDOWN.SLOTS",
> +        "PEBScounters": "35",
> +        "PublicDescription": "Number of available slots for an unhalted logical processor. The event increments by machine-width of the narrowest pipeline as employed by the Top-down Microarchitecture Analysis method (TMA). The count is distributed among unhalted logical processors (hyper-threads) who share the same physical core. Software can use this event as the denominator for the top-level metrics of the TMA method. This architectural event is counted on a designated fixed counter (Fixed Counter 3).",
> +        "SampleAfterValue": "10000003",
> +        "UMask": "0x4"
> +    },
> +    {
> +        "BriefDescription": "TMA slots available for an unhalted logical processor. General counter - architectural event",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3,4,5,6,7",
> +        "EventCode": "0xa4",
> +        "EventName": "TOPDOWN.SLOTS_P",
> +        "PEBScounters": "0,1,2,3,4,5,6,7",
> +        "PublicDescription": "Counts the number of available slots for an unhalted logical processor. The event increments by machine-width of the narrowest pipeline as employed by the Top-down Microarchitecture Analysis method. The count is distributed among unhalted logical processors (hyper-threads) who share the same physical core.",
> +        "SampleAfterValue": "10000003",
> +        "UMask": "0x1"
> +    },
>       {
>           "BriefDescription": "Number of uops decoded out of instructions exclusively fetched by decoder 0",
>           "CollectPEBSRecord": "2",

-- 
Zhengjun Xing
