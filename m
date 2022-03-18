Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE42B4DD70D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 10:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234435AbiCRJ2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 05:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234431AbiCRJ17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 05:27:59 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33DDB2D8105;
        Fri, 18 Mar 2022 02:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647595598; x=1679131598;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=EjreB0LH9m/dEvuiqXMUOj1HPaoLvDbollUsMKQLNcE=;
  b=fwLNxggngDrQ89xtYD51hZWgbc4iPbU2/Zo9zMcdTeYYp3zL+X9BH54U
   wAJW390HNv62+kHRho+9PRGO20DeFT4PQFnfZ1ScLUJaiZXen8ITELX2R
   12DjwYA4aK5oI90gSxieCtEUvd3uvVhVeDvblTT7IcrCOHYQTi2tdGSeF
   5toQPdw4Z5928iWlmQw7y1N/KSJnS6P/NoWSJoTHgBEMmsUQdwVnRLdVs
   g6FqNUK6WIpoguWZPGUEoDztcayolTaycSiLRDW3BbV5C5J03sSBzhjRY
   u+8iy+BRSdri2ZWKzG6v6gEVmeQlPulEJ55nbzRk7YR2V4huAN9dK5ymh
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="257050034"
X-IronPort-AV: E=Sophos;i="5.90,191,1643702400"; 
   d="scan'208";a="257050034"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 02:26:37 -0700
X-IronPort-AV: E=Sophos;i="5.90,191,1643702400"; 
   d="scan'208";a="558341715"
Received: from xingzhen-mobl.ccr.corp.intel.com (HELO [10.255.31.171]) ([10.255.31.171])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 02:26:33 -0700
Message-ID: <0fa9e1fe-47d4-98aa-6767-76d058075481@linux.intel.com>
Date:   Fri, 18 Mar 2022 17:26:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 8/8] perf vendor events: Update events for TremontX
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
 <20220317182858.484474-8-irogers@google.com>
From:   Xing Zhengjun <zhengjun.xing@linux.intel.com>
In-Reply-To: <20220317182858.484474-8-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/18/2022 2:28 AM, Ian Rogers wrote:
> Move from v1.17 to v1.19.
> The change:
> https://github.com/intel/event-converter-for-linux-perf/commit/fc680410402e394eed6a1ebd909c9f649d3ed3ef
> moved certain "other" type of events in to the cache, memory and
> pipeline topics. Update the perf json files for this change.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

Reviewed-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>

> ---
>   .../pmu-events/arch/x86/tremontx/cache.json   |  839 +++++++++-
>   .../arch/x86/tremontx/floating-point.json     |   12 +
>   .../pmu-events/arch/x86/tremontx/memory.json  |   59 +-
>   .../pmu-events/arch/x86/tremontx/other.json   | 1362 ++---------------
>   .../arch/x86/tremontx/pipeline.json           |  320 ++++
>   .../arch/x86/tremontx/uncore-other.json       |    1 +
>   .../arch/x86/tremontx/virtual-memory.json     |   11 +
>   7 files changed, 1329 insertions(+), 1275 deletions(-)
> 
> diff --git a/tools/perf/pmu-events/arch/x86/tremontx/cache.json b/tools/perf/pmu-events/arch/x86/tremontx/cache.json
> index 615b516ea021..e142f294b42e 100644
> --- a/tools/perf/pmu-events/arch/x86/tremontx/cache.json
> +++ b/tools/perf/pmu-events/arch/x86/tremontx/cache.json
> @@ -33,6 +33,53 @@
>           "PublicDescription": "Counts the number of demand and prefetch transactions that the External Queue (XQ) rejects due to a full or near full condition which likely indicates back pressure from the IDI link.  The XQ may reject transactions from the L2Q (non-cacheable requests), BBL (L2 misses) and WOB (L2 write-back victims).",
>           "SampleAfterValue": "200003"
>       },
> +    {
> +        "BriefDescription": "Counts the total number of L2 Cache accesses. Counts on a per core basis.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x24",
> +        "EventName": "L2_REQUEST.ALL",
> +        "PDIR_COUNTER": "na",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts the total number of L2 Cache Accesses, includes hits, misses, rejects  front door requests for CRd/DRd/RFO/ItoM/L2 Prefetches only.  Counts on a per core basis.",
> +        "SampleAfterValue": "200003"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of L2 Cache accesses that resulted in a hit. Counts on a per core basis.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x24",
> +        "EventName": "L2_REQUEST.HIT",
> +        "PDIR_COUNTER": "na",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts the number of L2 Cache accesses that resulted in a hit from a front door request only (does not include rejects or recycles), Counts on a per core basis.",
> +        "SampleAfterValue": "200003",
> +        "UMask": "0x2"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of L2 Cache accesses that resulted in a miss. Counts on a per core basis.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x24",
> +        "EventName": "L2_REQUEST.MISS",
> +        "PDIR_COUNTER": "na",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts the number of L2 Cache accesses that resulted in a miss from a front door request only (does not include rejects or recycles). Counts on a per core basis.",
> +        "SampleAfterValue": "200003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of L2 Cache accesses that miss the L2 and get rejected. Counts on a per core basis.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x24",
> +        "EventName": "L2_REQUEST.REJECTS",
> +        "PDIR_COUNTER": "na",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts the number of L2 Cache accesses that miss the L2 and get BBL reject  short and long rejects (includes those counted in L2_reject_XQ.any). Counts on a per core basis.",
> +        "SampleAfterValue": "200003",
> +        "UMask": "0x4"
> +    },
>       {
>           "BriefDescription": "Counts the number of cacheable memory requests that miss in the LLC. Counts on a per core basis.",
>           "CollectPEBSRecord": "2",
> @@ -59,6 +106,7 @@
>       },
>       {
>           "BriefDescription": "Counts the number of cycles the core is stalled due to an instruction cache or TLB miss which hit in the L2, LLC, DRAM or MMIO (Non-DRAM).",
> +        "CollectPEBSRecord": "2",
>           "Counter": "0,1,2,3",
>           "EventCode": "0x34",
>           "EventName": "MEM_BOUND_STALLS.IFETCH",
> @@ -86,7 +134,7 @@
>           "EventName": "MEM_BOUND_STALLS.IFETCH_L2_HIT",
>           "PDIR_COUNTER": "na",
>           "PEBScounters": "0,1,2,3",
> -        "PublicDescription": "Counts the number of cycles a core is stalled due to an instruction cache or Translation Lookaside Buffer (TLB) access which hit in the L2 cache.",
> +        "PublicDescription": "Counts the number of cycles the core is stalled due to an instruction cache or Translation Lookaside Buffer (TLB) access which hit in the L2 cache.",
>           "SampleAfterValue": "200003",
>           "UMask": "0x8"
>       },
> @@ -98,7 +146,7 @@
>           "EventName": "MEM_BOUND_STALLS.IFETCH_LLC_HIT",
>           "PDIR_COUNTER": "na",
>           "PEBScounters": "0,1,2,3",
> -        "PublicDescription": "Counts the number of cycles a core is stalled due to an instruction cache or Translation Lookaside Buffer (TLB) access which hit in the Last Level Cache (LLC) or other core with HITE/F/M.",
> +        "PublicDescription": "Counts the number of cycles the core is stalled due to an instruction cache or Translation Lookaside Buffer (TLB) access which hit in the Last Level Cache (LLC) or other core with HITE/F/M.",
>           "SampleAfterValue": "200003",
>           "UMask": "0x10"
>       },
> @@ -131,7 +179,6 @@
>           "EventName": "MEM_BOUND_STALLS.LOAD_L2_HIT",
>           "PDIR_COUNTER": "na",
>           "PEBScounters": "0,1,2,3",
> -        "PublicDescription": "Counts the number of cycles a core is stalled due to a demand load which hit in the L2 cache.",
>           "SampleAfterValue": "200003",
>           "UMask": "0x1"
>       },
> @@ -143,7 +190,7 @@
>           "EventName": "MEM_BOUND_STALLS.LOAD_LLC_HIT",
>           "PDIR_COUNTER": "na",
>           "PEBScounters": "0,1,2,3",
> -        "PublicDescription": "Counts the number of cycles a core is stalled due to a demand load which hit in the Last Level Cache (LLC) or other core with HITE/F/M.",
> +        "PublicDescription": "Counts the number of cycles the core is stalled due to a demand load which hit in the Last Level Cache (LLC) or other core with HITE/F/M.",
>           "SampleAfterValue": "200003",
>           "UMask": "0x2"
>       },
> @@ -241,6 +288,18 @@
>           "SampleAfterValue": "200003",
>           "UMask": "0x4"
>       },
> +    {
> +        "BriefDescription": "Counts the number of memory uops retired.  A single uop that performs both a load AND a store will be counted as 1, not 2 (e.g. ADD [mem], CONST)",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "Data_LA": "1",
> +        "EventCode": "0xd0",
> +        "EventName": "MEM_UOPS_RETIRED.ALL",
> +        "PEBS": "1",
> +        "PEBScounters": "0,1,2,3",
> +        "SampleAfterValue": "200003",
> +        "UMask": "0x83"
> +    },
>       {
>           "BriefDescription": "Counts the number of load uops retired.",
>           "CollectPEBSRecord": "2",
> @@ -267,6 +326,18 @@
>           "SampleAfterValue": "200003",
>           "UMask": "0x82"
>       },
> +    {
> +        "BriefDescription": "Counts the number of load uops retired that performed one or more locks.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "Data_LA": "1",
> +        "EventCode": "0xd0",
> +        "EventName": "MEM_UOPS_RETIRED.LOCK_LOADS",
> +        "PEBS": "1",
> +        "PEBScounters": "0,1,2,3",
> +        "SampleAfterValue": "200003",
> +        "UMask": "0x21"
> +    },
>       {
>           "BriefDescription": "Counts the number of memory uops retired that were splits.",
>           "CollectPEBSRecord": "2",
> @@ -291,6 +362,766 @@
>           "SampleAfterValue": "200003",
>           "UMask": "0x41"
>       },
> +    {
> +        "BriefDescription": "Counts the number of retired split store uops.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "Data_LA": "1",
> +        "EventCode": "0xd0",
> +        "EventName": "MEM_UOPS_RETIRED.SPLIT_STORES",
> +        "PEBS": "1",
> +        "PEBScounters": "0,1,2,3",
> +        "SampleAfterValue": "200003",
> +        "UMask": "0x42"
> +    },
> +    {
> +        "BriefDescription": "Counts all code reads that were supplied by the L3 cache.",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0XB7",
> +        "EventName": "OCR.ALL_CODE_RD.L3_HIT",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x1F803C0044",
> +        "Offcore": "1",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts all code reads that were supplied by the L3 cache where a snoop was sent, the snoop hit, and modified data was forwarded.",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0XB7",
> +        "EventName": "OCR.ALL_CODE_RD.L3_HIT.SNOOP_HITM",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x10003C0044",
> +        "Offcore": "1",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts all code reads that were supplied by the L3 cache where a snoop was sent, the snoop hit, but no data was forwarded.",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0XB7",
> +        "EventName": "OCR.ALL_CODE_RD.L3_HIT.SNOOP_HIT_NO_FWD",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x4003C0044",
> +        "Offcore": "1",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts all code reads that were supplied by the L3 cache where a snoop was sent, the snoop hit, and non-modified data was forwarded.",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0XB7",
> +        "EventName": "OCR.ALL_CODE_RD.L3_HIT.SNOOP_HIT_WITH_FWD",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x8003C0044",
> +        "Offcore": "1",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts all code reads that were supplied by the L3 cache where a snoop was sent but the snoop missed.",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0XB7",
> +        "EventName": "OCR.ALL_CODE_RD.L3_HIT.SNOOP_MISS",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x2003C0044",
> +        "Offcore": "1",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts all code reads that were supplied by the L3 cache where no snoop was needed to satisfy the request.",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0XB7",
> +        "EventName": "OCR.ALL_CODE_RD.L3_HIT.SNOOP_NOT_NEEDED",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x1003C0044",
> +        "Offcore": "1",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts modified writebacks from L1 cache and L2 cache that were supplied by the L3 cache.",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0XB7",
> +        "EventName": "OCR.COREWB_M.L3_HIT",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x3001F803C0000",
> +        "Offcore": "1",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts demand instruction fetches and L1 instruction cache prefetches that were supplied by the L3 cache.",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0XB7",
> +        "EventName": "OCR.DEMAND_CODE_RD.L3_HIT",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x1F803C0004",
> +        "Offcore": "1",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts demand instruction fetches and L1 instruction cache prefetches that were supplied by the L3 cache where a snoop was sent, the snoop hit, and modified data was forwarded.",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0XB7",
> +        "EventName": "OCR.DEMAND_CODE_RD.L3_HIT.SNOOP_HITM",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x10003C0004",
> +        "Offcore": "1",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts demand instruction fetches and L1 instruction cache prefetches that were supplied by the L3 cache where a snoop was sent, the snoop hit, but no data was forwarded.",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0XB7",
> +        "EventName": "OCR.DEMAND_CODE_RD.L3_HIT.SNOOP_HIT_NO_FWD",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x4003C0004",
> +        "Offcore": "1",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts demand instruction fetches and L1 instruction cache prefetches that were supplied by the L3 cache where a snoop was sent, the snoop hit, and non-modified data was forwarded.",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0XB7",
> +        "EventName": "OCR.DEMAND_CODE_RD.L3_HIT.SNOOP_HIT_WITH_FWD",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x8003C0004",
> +        "Offcore": "1",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts demand instruction fetches and L1 instruction cache prefetches that were supplied by the L3 cache where a snoop was sent but the snoop missed.",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0XB7",
> +        "EventName": "OCR.DEMAND_CODE_RD.L3_HIT.SNOOP_MISS",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x2003C0004",
> +        "Offcore": "1",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts demand instruction fetches and L1 instruction cache prefetches that were supplied by the L3 cache where no snoop was needed to satisfy the request.",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0XB7",
> +        "EventName": "OCR.DEMAND_CODE_RD.L3_HIT.SNOOP_NOT_NEEDED",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x1003C0004",
> +        "Offcore": "1",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts cacheable demand data reads, L1 data cache hardware prefetches and software prefetches (except PREFETCHW) that were supplied by the L3 cache.",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0XB7",
> +        "EventName": "OCR.DEMAND_DATA_AND_L1PF_RD.L3_HIT",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x1F803C0001",
> +        "Offcore": "1",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts cacheable demand data reads, L1 data cache hardware prefetches and software prefetches (except PREFETCHW) that were supplied by the L3 cache where a snoop was sent, the snoop hit, and modified data was forwarded.",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0XB7",
> +        "EventName": "OCR.DEMAND_DATA_AND_L1PF_RD.L3_HIT.SNOOP_HITM",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x10003C0001",
> +        "Offcore": "1",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts cacheable demand data reads, L1 data cache hardware prefetches and software prefetches (except PREFETCHW) that were supplied by the L3 cache where a snoop was sent, the snoop hit, but no data was forwarded.",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0XB7",
> +        "EventName": "OCR.DEMAND_DATA_AND_L1PF_RD.L3_HIT.SNOOP_HIT_NO_FWD",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x4003C0001",
> +        "Offcore": "1",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts cacheable demand data reads, L1 data cache hardware prefetches and software prefetches (except PREFETCHW) that were supplied by the L3 cache where a snoop was sent, the snoop hit, and non-modified data was forwarded.",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0XB7",
> +        "EventName": "OCR.DEMAND_DATA_AND_L1PF_RD.L3_HIT.SNOOP_HIT_WITH_FWD",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x8003C0001",
> +        "Offcore": "1",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts cacheable demand data reads, L1 data cache hardware prefetches and software prefetches (except PREFETCHW) that were supplied by the L3 cache where a snoop was sent but the snoop missed.",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0XB7",
> +        "EventName": "OCR.DEMAND_DATA_AND_L1PF_RD.L3_HIT.SNOOP_MISS",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x2003C0001",
> +        "Offcore": "1",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts cacheable demand data reads, L1 data cache hardware prefetches and software prefetches (except PREFETCHW) that were supplied by the L3 cache where no snoop was needed to satisfy the request.",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0XB7",
> +        "EventName": "OCR.DEMAND_DATA_AND_L1PF_RD.L3_HIT.SNOOP_NOT_NEEDED",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x1003C0001",
> +        "Offcore": "1",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "This event is deprecated. Refer to new event OCR.DEMAND_DATA_AND_L1PF_RD.L3_HIT",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0XB7",
> +        "EventName": "OCR.DEMAND_DATA_RD.L3_HIT",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x1F803C0001",
> +        "Offcore": "1",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "This event is deprecated. Refer to new event OCR.DEMAND_DATA_AND_L1PF_RD.L3_HIT.SNOOP_HITM",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0XB7",
> +        "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x10003C0001",
> +        "Offcore": "1",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "This event is deprecated. Refer to new event OCR.DEMAND_DATA_AND_L1PF_RD.L3_HIT.SNOOP_HIT_NO_FWD",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0XB7",
> +        "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_NO_FWD",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x4003C0001",
> +        "Offcore": "1",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "This event is deprecated. Refer to new event OCR.DEMAND_DATA_AND_L1PF_RD.L3_HIT.SNOOP_HIT_WITH_FWD",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0XB7",
> +        "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_WITH_FWD",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x8003C0001",
> +        "Offcore": "1",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "This event is deprecated. Refer to new event OCR.DEMAND_DATA_AND_L1PF_RD.L3_HIT.SNOOP_MISS",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0XB7",
> +        "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_MISS",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x2003C0001",
> +        "Offcore": "1",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "This event is deprecated. Refer to new event OCR.DEMAND_DATA_AND_L1PF_RD.L3_HIT.SNOOP_NOT_NEEDED",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0XB7",
> +        "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_NOT_NEEDED",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x1003C0001",
> +        "Offcore": "1",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts demand reads for ownership (RFO) and software prefetches for exclusive ownership (PREFETCHW) that were supplied by the L3 cache.",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0XB7",
> +        "EventName": "OCR.DEMAND_RFO.L3_HIT",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x1F803C0002",
> +        "Offcore": "1",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts demand reads for ownership (RFO) and software prefetches for exclusive ownership (PREFETCHW) that were supplied by the L3 cache where a snoop was sent, the snoop hit, and modified data was forwarded.",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0XB7",
> +        "EventName": "OCR.DEMAND_RFO.L3_HIT.SNOOP_HITM",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x10003C0002",
> +        "Offcore": "1",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts demand reads for ownership (RFO) and software prefetches for exclusive ownership (PREFETCHW) that were supplied by the L3 cache where a snoop was sent, the snoop hit, but no data was forwarded.",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0XB7",
> +        "EventName": "OCR.DEMAND_RFO.L3_HIT.SNOOP_HIT_NO_FWD",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x4003C0002",
> +        "Offcore": "1",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts demand reads for ownership (RFO) and software prefetches for exclusive ownership (PREFETCHW) that were supplied by the L3 cache where a snoop was sent, the snoop hit, and non-modified data was forwarded.",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0XB7",
> +        "EventName": "OCR.DEMAND_RFO.L3_HIT.SNOOP_HIT_WITH_FWD",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x8003C0002",
> +        "Offcore": "1",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts demand reads for ownership (RFO) and software prefetches for exclusive ownership (PREFETCHW) that were supplied by the L3 cache where a snoop was sent but the snoop missed.",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0XB7",
> +        "EventName": "OCR.DEMAND_RFO.L3_HIT.SNOOP_MISS",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x2003C0002",
> +        "Offcore": "1",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts demand reads for ownership (RFO) and software prefetches for exclusive ownership (PREFETCHW) that were supplied by the L3 cache where no snoop was needed to satisfy the request.",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0XB7",
> +        "EventName": "OCR.DEMAND_RFO.L3_HIT.SNOOP_NOT_NEEDED",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x1003C0002",
> +        "Offcore": "1",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts streaming stores which modify a full 64 byte cacheline that were supplied by the L3 cache.",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0XB7",
> +        "EventName": "OCR.FULL_STREAMING_WR.L3_HIT",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x801F803C0000",
> +        "Offcore": "1",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts L1 data cache hardware prefetches and software prefetches (except PREFETCHW and PFRFO) that were supplied by the L3 cache where a snoop was sent, the snoop hit, and modified data was forwarded.",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0XB7",
> +        "EventName": "OCR.HWPF_L1D_AND_SWPF.L3_HIT.SNOOP_HITM",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x10003C0400",
> +        "Offcore": "1",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts L2 cache hardware prefetch code reads (written to the L2 cache only) that were supplied by the L3 cache.",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0XB7",
> +        "EventName": "OCR.HWPF_L2_CODE_RD.L3_HIT",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x1F803C0040",
> +        "Offcore": "1",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts L2 cache hardware prefetch code reads (written to the L2 cache only) that were supplied by the L3 cache where a snoop was sent, the snoop hit, and modified data was forwarded.",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0XB7",
> +        "EventName": "OCR.HWPF_L2_CODE_RD.L3_HIT.SNOOP_HITM",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x10003C0040",
> +        "Offcore": "1",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts L2 cache hardware prefetch code reads (written to the L2 cache only) that were supplied by the L3 cache where a snoop was sent, the snoop hit, but no data was forwarded.",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0XB7",
> +        "EventName": "OCR.HWPF_L2_CODE_RD.L3_HIT.SNOOP_HIT_NO_FWD",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x4003C0040",
> +        "Offcore": "1",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts L2 cache hardware prefetch code reads (written to the L2 cache only) that were supplied by the L3 cache where a snoop was sent, the snoop hit, and non-modified data was forwarded.",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0XB7",
> +        "EventName": "OCR.HWPF_L2_CODE_RD.L3_HIT.SNOOP_HIT_WITH_FWD",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x8003C0040",
> +        "Offcore": "1",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts L2 cache hardware prefetch code reads (written to the L2 cache only) that were supplied by the L3 cache where a snoop was sent but the snoop missed.",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0XB7",
> +        "EventName": "OCR.HWPF_L2_CODE_RD.L3_HIT.SNOOP_MISS",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x2003C0040",
> +        "Offcore": "1",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts L2 cache hardware prefetch code reads (written to the L2 cache only) that were supplied by the L3 cache where no snoop was needed to satisfy the request.",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0XB7",
> +        "EventName": "OCR.HWPF_L2_CODE_RD.L3_HIT.SNOOP_NOT_NEEDED",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x1003C0040",
> +        "Offcore": "1",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts L2 cache hardware prefetch data reads (written to the L2 cache only) that were supplied by the L3 cache.",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0XB7",
> +        "EventName": "OCR.HWPF_L2_DATA_RD.L3_HIT",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x1F803C0010",
> +        "Offcore": "1",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts L2 cache hardware prefetch data reads (written to the L2 cache only) that were supplied by the L3 cache where a snoop was sent, the snoop hit, and modified data was forwarded.",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0XB7",
> +        "EventName": "OCR.HWPF_L2_DATA_RD.L3_HIT.SNOOP_HITM",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x10003C0010",
> +        "Offcore": "1",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts L2 cache hardware prefetch data reads (written to the L2 cache only) that were supplied by the L3 cache where a snoop was sent, the snoop hit, but no data was forwarded.",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0XB7",
> +        "EventName": "OCR.HWPF_L2_DATA_RD.L3_HIT.SNOOP_HIT_NO_FWD",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x4003C0010",
> +        "Offcore": "1",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts L2 cache hardware prefetch data reads (written to the L2 cache only) that were supplied by the L3 cache where a snoop was sent, the snoop hit, and non-modified data was forwarded.",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0XB7",
> +        "EventName": "OCR.HWPF_L2_DATA_RD.L3_HIT.SNOOP_HIT_WITH_FWD",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x8003C0010",
> +        "Offcore": "1",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts L2 cache hardware prefetch data reads (written to the L2 cache only) that were supplied by the L3 cache where a snoop was sent but the snoop missed.",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0XB7",
> +        "EventName": "OCR.HWPF_L2_DATA_RD.L3_HIT.SNOOP_MISS",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x2003C0010",
> +        "Offcore": "1",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts L2 cache hardware prefetch data reads (written to the L2 cache only) that were supplied by the L3 cache where no snoop was needed to satisfy the request.",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0XB7",
> +        "EventName": "OCR.HWPF_L2_DATA_RD.L3_HIT.SNOOP_NOT_NEEDED",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x1003C0010",
> +        "Offcore": "1",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts L2 cache hardware prefetch RFOs (written to the L2 cache only) that were supplied by the L3 cache.",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0XB7",
> +        "EventName": "OCR.HWPF_L2_RFO.L3_HIT",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x1F803C0020",
> +        "Offcore": "1",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts L2 cache hardware prefetch RFOs (written to the L2 cache only) that were supplied by the L3 cache where a snoop was sent, the snoop hit, and modified data was forwarded.",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0XB7",
> +        "EventName": "OCR.HWPF_L2_RFO.L3_HIT.SNOOP_HITM",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x10003C0020",
> +        "Offcore": "1",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts L2 cache hardware prefetch RFOs (written to the L2 cache only) that were supplied by the L3 cache where a snoop was sent, the snoop hit, but no data was forwarded.",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0XB7",
> +        "EventName": "OCR.HWPF_L2_RFO.L3_HIT.SNOOP_HIT_NO_FWD",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x4003C0020",
> +        "Offcore": "1",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts L2 cache hardware prefetch RFOs (written to the L2 cache only) that were supplied by the L3 cache where a snoop was sent, the snoop hit, and non-modified data was forwarded.",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0XB7",
> +        "EventName": "OCR.HWPF_L2_RFO.L3_HIT.SNOOP_HIT_WITH_FWD",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x8003C0020",
> +        "Offcore": "1",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts L2 cache hardware prefetch RFOs (written to the L2 cache only) that were supplied by the L3 cache where a snoop was sent but the snoop missed.",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0XB7",
> +        "EventName": "OCR.HWPF_L2_RFO.L3_HIT.SNOOP_MISS",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x2003C0020",
> +        "Offcore": "1",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts L2 cache hardware prefetch RFOs (written to the L2 cache only) that were supplied by the L3 cache where no snoop was needed to satisfy the request.",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0XB7",
> +        "EventName": "OCR.HWPF_L2_RFO.L3_HIT.SNOOP_NOT_NEEDED",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x1003C0020",
> +        "Offcore": "1",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts modified writebacks from L1 cache that miss the L2 cache that were supplied by the L3 cache.",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0XB7",
> +        "EventName": "OCR.L1WB_M.L3_HIT",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x1001F803C0000",
> +        "Offcore": "1",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts modified writeBacks from L2 cache that miss the L3 cache that were supplied by the L3 cache.",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0XB7",
> +        "EventName": "OCR.L2WB_M.L3_HIT",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x2001F803C0000",
> +        "Offcore": "1",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts streaming stores which modify only part of a 64 byte cacheline that were supplied by the L3 cache.",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0XB7",
> +        "EventName": "OCR.PARTIAL_STREAMING_WR.L3_HIT",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x401F803C0000",
> +        "Offcore": "1",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts all data read, code read and RFO requests including demands and prefetches to the core caches (L1 or L2) that were supplied by the L3 cache.",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0XB7",
> +        "EventName": "OCR.READS_TO_CORE.L3_HIT",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x1F803C0477",
> +        "Offcore": "1",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts all data read, code read and RFO requests including demands and prefetches to the core caches (L1 or L2) that were supplied by the L3 cache where a snoop was sent, the snoop hit, and modified data was forwarded.",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0XB7",
> +        "EventName": "OCR.READS_TO_CORE.L3_HIT.SNOOP_HITM",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x10003C0477",
> +        "Offcore": "1",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts all data read, code read and RFO requests including demands and prefetches to the core caches (L1 or L2) that were supplied by the L3 cache where a snoop was sent, the snoop hit, but no data was forwarded.",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0XB7",
> +        "EventName": "OCR.READS_TO_CORE.L3_HIT.SNOOP_HIT_NO_FWD",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x4003C0477",
> +        "Offcore": "1",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts all data read, code read and RFO requests including demands and prefetches to the core caches (L1 or L2) that were supplied by the L3 cache where a snoop was sent, the snoop hit, and non-modified data was forwarded.",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0XB7",
> +        "EventName": "OCR.READS_TO_CORE.L3_HIT.SNOOP_HIT_WITH_FWD",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x8003C0477",
> +        "Offcore": "1",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts all data read, code read and RFO requests including demands and prefetches to the core caches (L1 or L2) that were supplied by the L3 cache where a snoop was sent but the snoop missed.",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0XB7",
> +        "EventName": "OCR.READS_TO_CORE.L3_HIT.SNOOP_MISS",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x2003C0477",
> +        "Offcore": "1",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts all data read, code read and RFO requests including demands and prefetches to the core caches (L1 or L2) that were supplied by the L3 cache where no snoop was needed to satisfy the request.",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0XB7",
> +        "EventName": "OCR.READS_TO_CORE.L3_HIT.SNOOP_NOT_NEEDED",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x1003C0477",
> +        "Offcore": "1",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts streaming stores that were supplied by the L3 cache.",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0XB7",
> +        "EventName": "OCR.STREAMING_WR.L3_HIT",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x1F803C0800",
> +        "Offcore": "1",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts uncached memory reads that were supplied by the L3 cache.",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0XB7",
> +        "EventName": "OCR.UC_RD.L3_HIT",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x101F803C0000",
> +        "Offcore": "1",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts uncached memory reads that were supplied by the L3 cache where a snoop was sent, the snoop hit, and modified data was forwarded.",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0XB7",
> +        "EventName": "OCR.UC_RD.L3_HIT.SNOOP_HITM",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x1010003C0000",
> +        "Offcore": "1",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts uncached memory reads that were supplied by the L3 cache where a snoop was sent, the snoop hit, but no data was forwarded.",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0XB7",
> +        "EventName": "OCR.UC_RD.L3_HIT.SNOOP_HIT_NO_FWD",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x1004003C0000",
> +        "Offcore": "1",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts uncached memory reads that were supplied by the L3 cache where a snoop was sent, the snoop hit, and non-modified data was forwarded.",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0XB7",
> +        "EventName": "OCR.UC_RD.L3_HIT.SNOOP_HIT_WITH_FWD",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x1008003C0000",
> +        "Offcore": "1",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts uncached memory reads that were supplied by the L3 cache where a snoop was sent but the snoop missed.",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0XB7",
> +        "EventName": "OCR.UC_RD.L3_HIT.SNOOP_MISS",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x1002003C0000",
> +        "Offcore": "1",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts uncached memory reads that were supplied by the L3 cache where no snoop was needed to satisfy the request.",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0XB7",
> +        "EventName": "OCR.UC_RD.L3_HIT.SNOOP_NOT_NEEDED",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x1001003C0000",
> +        "Offcore": "1",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts uncached memory writes that were supplied by the L3 cache.",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0XB7",
> +        "EventName": "OCR.UC_WR.L3_HIT",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x201F803C0000",
> +        "Offcore": "1",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    },
>       {
>           "BriefDescription": "Counts the number of issue slots every cycle that were not delivered by the frontend due to instruction cache misses.",
>           "CollectPEBSRecord": "2",
> diff --git a/tools/perf/pmu-events/arch/x86/tremontx/floating-point.json b/tools/perf/pmu-events/arch/x86/tremontx/floating-point.json
> index 2515b9aa6e66..c7780fa54689 100644
> --- a/tools/perf/pmu-events/arch/x86/tremontx/floating-point.json
> +++ b/tools/perf/pmu-events/arch/x86/tremontx/floating-point.json
> @@ -10,6 +10,18 @@
>           "SampleAfterValue": "200003",
>           "UMask": "0x2"
>       },
> +    {
> +        "BriefDescription": "Counts the number of floating point operations retired that required microcode assist.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0xc3",
> +        "EventName": "MACHINE_CLEARS.FP_ASSIST",
> +        "PDIR_COUNTER": "na",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts the number of floating point operations retired that required microcode assist, which is not a reflection of the number of FP operations, instructions or uops.",
> +        "SampleAfterValue": "20003",
> +        "UMask": "0x4"
> +    },
>       {
>           "BriefDescription": "Counts the number of floating point divide uops retired (x87 and SSE, including x87 sqrt).",
>           "CollectPEBSRecord": "2",
> diff --git a/tools/perf/pmu-events/arch/x86/tremontx/memory.json b/tools/perf/pmu-events/arch/x86/tremontx/memory.json
> index 4486f78035d8..76eaefafdc89 100644
> --- a/tools/perf/pmu-events/arch/x86/tremontx/memory.json
> +++ b/tools/perf/pmu-events/arch/x86/tremontx/memory.json
> @@ -10,6 +10,28 @@
>           "SampleAfterValue": "20003",
>           "UMask": "0x2"
>       },
> +    {
> +        "BriefDescription": "Counts the number of misaligned load uops that are 4K page splits.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x13",
> +        "EventName": "MISALIGN_MEM_REF.LOAD_PAGE_SPLIT",
> +        "PEBS": "1",
> +        "PEBScounters": "0,1,2,3",
> +        "SampleAfterValue": "200003",
> +        "UMask": "0x2"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of misaligned store uops that are 4K page splits.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x13",
> +        "EventName": "MISALIGN_MEM_REF.STORE_PAGE_SPLIT",
> +        "PEBS": "1",
> +        "PEBScounters": "0,1,2,3",
> +        "SampleAfterValue": "200003",
> +        "UMask": "0x4"
> +    },
>       {
>           "BriefDescription": "Counts all code reads that were not supplied by the L3 cache.",
>           "Counter": "0,1,2,3",
> @@ -18,7 +40,6 @@
>           "MSRIndex": "0x1a6,0x1a7",
>           "MSRValue": "0x2184000044",
>           "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
>           "SampleAfterValue": "100003",
>           "UMask": "0x1"
>       },
> @@ -30,7 +51,6 @@
>           "MSRIndex": "0x1a6,0x1a7",
>           "MSRValue": "0x2184000044",
>           "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
>           "SampleAfterValue": "100003",
>           "UMask": "0x1"
>       },
> @@ -42,7 +62,6 @@
>           "MSRIndex": "0x1a6,0x1a7",
>           "MSRValue": "0x3002184000000",
>           "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
>           "SampleAfterValue": "100003",
>           "UMask": "0x1"
>       },
> @@ -54,7 +73,6 @@
>           "MSRIndex": "0x1a6,0x1a7",
>           "MSRValue": "0x3002184000000",
>           "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
>           "SampleAfterValue": "100003",
>           "UMask": "0x1"
>       },
> @@ -66,7 +84,6 @@
>           "MSRIndex": "0x1a6,0x1a7",
>           "MSRValue": "0x2184000004",
>           "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
>           "SampleAfterValue": "100003",
>           "UMask": "0x1"
>       },
> @@ -78,7 +95,6 @@
>           "MSRIndex": "0x1a6,0x1a7",
>           "MSRValue": "0x2184000004",
>           "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
>           "SampleAfterValue": "100003",
>           "UMask": "0x1"
>       },
> @@ -90,7 +106,6 @@
>           "MSRIndex": "0x1a6,0x1a7",
>           "MSRValue": "0x2184000001",
>           "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
>           "SampleAfterValue": "100003",
>           "UMask": "0x1"
>       },
> @@ -102,7 +117,6 @@
>           "MSRIndex": "0x1a6,0x1a7",
>           "MSRValue": "0x2184000001",
>           "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
>           "SampleAfterValue": "100003",
>           "UMask": "0x1"
>       },
> @@ -114,7 +128,6 @@
>           "MSRIndex": "0x1a6,0x1a7",
>           "MSRValue": "0x2184000001",
>           "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
>           "SampleAfterValue": "100003",
>           "UMask": "0x1"
>       },
> @@ -126,7 +139,6 @@
>           "MSRIndex": "0x1a6,0x1a7",
>           "MSRValue": "0x2184000001",
>           "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
>           "SampleAfterValue": "100003",
>           "UMask": "0x1"
>       },
> @@ -138,7 +150,6 @@
>           "MSRIndex": "0x1a6,0x1a7",
>           "MSRValue": "0x2184000002",
>           "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
>           "SampleAfterValue": "100003",
>           "UMask": "0x1"
>       },
> @@ -150,7 +161,6 @@
>           "MSRIndex": "0x1a6,0x1a7",
>           "MSRValue": "0x2184000002",
>           "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
>           "SampleAfterValue": "100003",
>           "UMask": "0x1"
>       },
> @@ -162,7 +172,6 @@
>           "MSRIndex": "0x1a6,0x1a7",
>           "MSRValue": "0x802184000000",
>           "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
>           "SampleAfterValue": "100003",
>           "UMask": "0x1"
>       },
> @@ -174,7 +183,6 @@
>           "MSRIndex": "0x1a6,0x1a7",
>           "MSRValue": "0x802184000000",
>           "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
>           "SampleAfterValue": "100003",
>           "UMask": "0x1"
>       },
> @@ -186,7 +194,6 @@
>           "MSRIndex": "0x1a6,0x1a7",
>           "MSRValue": "0x2184000040",
>           "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
>           "SampleAfterValue": "100003",
>           "UMask": "0x1"
>       },
> @@ -198,7 +205,6 @@
>           "MSRIndex": "0x1a6,0x1a7",
>           "MSRValue": "0x2184000040",
>           "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
>           "SampleAfterValue": "100003",
>           "UMask": "0x1"
>       },
> @@ -210,7 +216,6 @@
>           "MSRIndex": "0x1a6,0x1a7",
>           "MSRValue": "0x2184000010",
>           "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
>           "SampleAfterValue": "100003",
>           "UMask": "0x1"
>       },
> @@ -222,7 +227,6 @@
>           "MSRIndex": "0x1a6,0x1a7",
>           "MSRValue": "0x2184000010",
>           "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
>           "SampleAfterValue": "100003",
>           "UMask": "0x1"
>       },
> @@ -234,7 +238,6 @@
>           "MSRIndex": "0x1a6,0x1a7",
>           "MSRValue": "0x2184000020",
>           "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
>           "SampleAfterValue": "100003",
>           "UMask": "0x1"
>       },
> @@ -246,7 +249,6 @@
>           "MSRIndex": "0x1a6,0x1a7",
>           "MSRValue": "0x2184000020",
>           "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
>           "SampleAfterValue": "100003",
>           "UMask": "0x1"
>       },
> @@ -258,7 +260,6 @@
>           "MSRIndex": "0x1a6,0x1a7",
>           "MSRValue": "0x1002184000000",
>           "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
>           "SampleAfterValue": "100003",
>           "UMask": "0x1"
>       },
> @@ -270,7 +271,6 @@
>           "MSRIndex": "0x1a6,0x1a7",
>           "MSRValue": "0x1002184000000",
>           "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
>           "SampleAfterValue": "100003",
>           "UMask": "0x1"
>       },
> @@ -282,7 +282,6 @@
>           "MSRIndex": "0x1a6,0x1a7",
>           "MSRValue": "0x2002184000000",
>           "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
>           "SampleAfterValue": "100003",
>           "UMask": "0x1"
>       },
> @@ -294,7 +293,6 @@
>           "MSRIndex": "0x1a6,0x1a7",
>           "MSRValue": "0x2002184000000",
>           "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
>           "SampleAfterValue": "100003",
>           "UMask": "0x1"
>       },
> @@ -306,7 +304,6 @@
>           "MSRIndex": "0x1a6,0x1a7",
>           "MSRValue": "0x2184008000",
>           "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
>           "SampleAfterValue": "100003",
>           "UMask": "0x1"
>       },
> @@ -318,7 +315,6 @@
>           "MSRIndex": "0x1a6,0x1a7",
>           "MSRValue": "0x2184008000",
>           "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
>           "SampleAfterValue": "100003",
>           "UMask": "0x1"
>       },
> @@ -330,7 +326,6 @@
>           "MSRIndex": "0x1a6,0x1a7",
>           "MSRValue": "0x402184000000",
>           "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
>           "SampleAfterValue": "100003",
>           "UMask": "0x1"
>       },
> @@ -342,7 +337,6 @@
>           "MSRIndex": "0x1a6,0x1a7",
>           "MSRValue": "0x402184000000",
>           "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
>           "SampleAfterValue": "100003",
>           "UMask": "0x1"
>       },
> @@ -354,7 +348,6 @@
>           "MSRIndex": "0x1a6,0x1a7",
>           "MSRValue": "0x2184000470",
>           "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
>           "SampleAfterValue": "100003",
>           "UMask": "0x1"
>       },
> @@ -366,7 +359,6 @@
>           "MSRIndex": "0x1a6,0x1a7",
>           "MSRValue": "0x2184000477",
>           "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
>           "SampleAfterValue": "100003",
>           "UMask": "0x1"
>       },
> @@ -378,7 +370,6 @@
>           "MSRIndex": "0x1a6,0x1a7",
>           "MSRValue": "0x2184000477",
>           "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
>           "SampleAfterValue": "100003",
>           "UMask": "0x1"
>       },
> @@ -390,7 +381,6 @@
>           "MSRIndex": "0x1a6,0x1a7",
>           "MSRValue": "0x2184000800",
>           "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
>           "SampleAfterValue": "100003",
>           "UMask": "0x1"
>       },
> @@ -402,7 +392,6 @@
>           "MSRIndex": "0x1a6,0x1a7",
>           "MSRValue": "0x2184000800",
>           "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
>           "SampleAfterValue": "100003",
>           "UMask": "0x1"
>       },
> @@ -414,7 +403,6 @@
>           "MSRIndex": "0x1a6,0x1a7",
>           "MSRValue": "0x102184000000",
>           "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
>           "SampleAfterValue": "100003",
>           "UMask": "0x1"
>       },
> @@ -426,7 +414,6 @@
>           "MSRIndex": "0x1a6,0x1a7",
>           "MSRValue": "0x102184000000",
>           "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
>           "SampleAfterValue": "100003",
>           "UMask": "0x1"
>       },
> @@ -438,7 +425,6 @@
>           "MSRIndex": "0x1a6,0x1a7",
>           "MSRValue": "0x202184000000",
>           "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
>           "SampleAfterValue": "100003",
>           "UMask": "0x1"
>       },
> @@ -450,7 +436,6 @@
>           "MSRIndex": "0x1a6,0x1a7",
>           "MSRValue": "0x202184000000",
>           "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
>           "SampleAfterValue": "100003",
>           "UMask": "0x1"
>       }
> diff --git a/tools/perf/pmu-events/arch/x86/tremontx/other.json b/tools/perf/pmu-events/arch/x86/tremontx/other.json
> index 522eb795574d..4f20f45a4898 100644
> --- a/tools/perf/pmu-events/arch/x86/tremontx/other.json
> +++ b/tools/perf/pmu-events/arch/x86/tremontx/other.json
> @@ -152,7 +152,6 @@
>           "MSRIndex": "0x1a6,0x1a7",
>           "MSRValue": "0x10044",
>           "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
>           "SampleAfterValue": "100003",
>           "UMask": "0x1"
>       },
> @@ -164,79 +163,6 @@
>           "MSRIndex": "0x1a6,0x1a7",
>           "MSRValue": "0x184000044",
>           "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts all code reads that were supplied by the L3 cache.",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0XB7",
> -        "EventName": "OCR.ALL_CODE_RD.L3_HIT",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x1F803C0044",
> -        "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts all code reads that were supplied by the L3 cache where a snoop was sent, the snoop hit, and modified data was forwarded.",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0XB7",
> -        "EventName": "OCR.ALL_CODE_RD.L3_HIT.SNOOP_HITM",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x10003C0044",
> -        "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts all code reads that were supplied by the L3 cache where a snoop was sent, the snoop hit, but no data was forwarded.",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0XB7",
> -        "EventName": "OCR.ALL_CODE_RD.L3_HIT.SNOOP_HIT_NO_FWD",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x4003C0044",
> -        "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts all code reads that were supplied by the L3 cache where a snoop was sent, the snoop hit, and non-modified data was forwarded.",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0XB7",
> -        "EventName": "OCR.ALL_CODE_RD.L3_HIT.SNOOP_HIT_WITH_FWD",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x8003C0044",
> -        "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts all code reads that were supplied by the L3 cache where a snoop was sent but the snoop missed.",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0XB7",
> -        "EventName": "OCR.ALL_CODE_RD.L3_HIT.SNOOP_MISS",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x2003C0044",
> -        "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts all code reads that were supplied by the L3 cache where no snoop was needed to satisfy the request.",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0XB7",
> -        "EventName": "OCR.ALL_CODE_RD.L3_HIT.SNOOP_NOT_NEEDED",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x1003C0044",
> -        "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
>           "SampleAfterValue": "100003",
>           "UMask": "0x1"
>       },
> @@ -248,7 +174,6 @@
>           "MSRIndex": "0x1a6,0x1a7",
>           "MSRValue": "0x184000044",
>           "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
>           "SampleAfterValue": "100003",
>           "UMask": "0x1"
>       },
> @@ -260,7 +185,6 @@
>           "MSRIndex": "0x1a6",
>           "MSRValue": "0x8000000000000044",
>           "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
>           "SampleAfterValue": "100003",
>           "UMask": "0x1"
>       },
> @@ -272,19 +196,6 @@
>           "MSRIndex": "0x1a6,0x1a7",
>           "MSRValue": "0x3000000010000",
>           "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts modified writebacks from L1 cache and L2 cache that were supplied by the L3 cache.",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0XB7",
> -        "EventName": "OCR.COREWB_M.L3_HIT",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x3001F803C0000",
> -        "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
>           "SampleAfterValue": "100003",
>           "UMask": "0x1"
>       },
> @@ -296,7 +207,6 @@
>           "MSRIndex": "0x1a6",
>           "MSRValue": "0x8003000000000000",
>           "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
>           "SampleAfterValue": "100003",
>           "UMask": "0x1"
>       },
> @@ -308,7 +218,6 @@
>           "MSRIndex": "0x1a6,0x1a7",
>           "MSRValue": "0x10004",
>           "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
>           "SampleAfterValue": "100003",
>           "UMask": "0x1"
>       },
> @@ -320,1473 +229,458 @@
>           "MSRIndex": "0x1a6,0x1a7",
>           "MSRValue": "0x184000004",
>           "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts demand instruction fetches and L1 instruction cache prefetches that were supplied by the L3 cache.",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0XB7",
> -        "EventName": "OCR.DEMAND_CODE_RD.L3_HIT",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x1F803C0004",
> -        "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
>           "SampleAfterValue": "100003",
>           "UMask": "0x1"
>       },
>       {
> -        "BriefDescription": "Counts demand instruction fetches and L1 instruction cache prefetches that were supplied by the L3 cache where a snoop was sent, the snoop hit, and modified data was forwarded.",
> +        "BriefDescription": "Counts demand instruction fetches and L1 instruction cache prefetches that were supplied by DRAM.",
>           "Counter": "0,1,2,3",
>           "EventCode": "0XB7",
> -        "EventName": "OCR.DEMAND_CODE_RD.L3_HIT.SNOOP_HITM",
> +        "EventName": "OCR.DEMAND_CODE_RD.LOCAL_DRAM",
>           "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x10003C0004",
> +        "MSRValue": "0x184000004",
>           "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
>           "SampleAfterValue": "100003",
>           "UMask": "0x1"
>       },
>       {
> -        "BriefDescription": "Counts demand instruction fetches and L1 instruction cache prefetches that were supplied by the L3 cache where a snoop was sent, the snoop hit, but no data was forwarded.",
> +        "BriefDescription": "Counts cacheable demand data reads, L1 data cache hardware prefetches and software prefetches (except PREFETCHW) that have any type of response.",
>           "Counter": "0,1,2,3",
>           "EventCode": "0XB7",
> -        "EventName": "OCR.DEMAND_CODE_RD.L3_HIT.SNOOP_HIT_NO_FWD",
> +        "EventName": "OCR.DEMAND_DATA_AND_L1PF_RD.ANY_RESPONSE",
>           "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x4003C0004",
> +        "MSRValue": "0x10001",
>           "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
>           "SampleAfterValue": "100003",
>           "UMask": "0x1"
>       },
>       {
> -        "BriefDescription": "Counts demand instruction fetches and L1 instruction cache prefetches that were supplied by the L3 cache where a snoop was sent, the snoop hit, and non-modified data was forwarded.",
> +        "BriefDescription": "Counts cacheable demand data reads, L1 data cache hardware prefetches and software prefetches (except PREFETCHW) that were supplied by DRAM.",
>           "Counter": "0,1,2,3",
>           "EventCode": "0XB7",
> -        "EventName": "OCR.DEMAND_CODE_RD.L3_HIT.SNOOP_HIT_WITH_FWD",
> +        "EventName": "OCR.DEMAND_DATA_AND_L1PF_RD.DRAM",
>           "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x8003C0004",
> +        "MSRValue": "0x184000001",
>           "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
>           "SampleAfterValue": "100003",
>           "UMask": "0x1"
>       },
>       {
> -        "BriefDescription": "Counts demand instruction fetches and L1 instruction cache prefetches that were supplied by the L3 cache where a snoop was sent but the snoop missed.",
> +        "BriefDescription": "Counts cacheable demand data reads, L1 data cache hardware prefetches and software prefetches (except PREFETCHW) that were supplied by DRAM.",
>           "Counter": "0,1,2,3",
>           "EventCode": "0XB7",
> -        "EventName": "OCR.DEMAND_CODE_RD.L3_HIT.SNOOP_MISS",
> +        "EventName": "OCR.DEMAND_DATA_AND_L1PF_RD.LOCAL_DRAM",
>           "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x2003C0004",
> +        "MSRValue": "0x184000001",
>           "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
>           "SampleAfterValue": "100003",
>           "UMask": "0x1"
>       },
>       {
> -        "BriefDescription": "Counts demand instruction fetches and L1 instruction cache prefetches that were supplied by the L3 cache where no snoop was needed to satisfy the request.",
> +        "BriefDescription": "Counts cacheable demand data reads, L1 data cache hardware prefetches and software prefetches (except PREFETCHW) that have an outstanding request. Returns the number of cycles until the response is received (i.e. XQ to XQ latency).",
>           "Counter": "0,1,2,3",
>           "EventCode": "0XB7",
> -        "EventName": "OCR.DEMAND_CODE_RD.L3_HIT.SNOOP_NOT_NEEDED",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x1003C0004",
> +        "EventName": "OCR.DEMAND_DATA_AND_L1PF_RD.OUTSTANDING",
> +        "MSRIndex": "0x1a6",
> +        "MSRValue": "0x8000000000000001",
>           "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
>           "SampleAfterValue": "100003",
>           "UMask": "0x1"
>       },
>       {
> -        "BriefDescription": "Counts demand instruction fetches and L1 instruction cache prefetches that were supplied by DRAM.",
> +        "BriefDescription": "This event is deprecated. Refer to new event OCR.DEMAND_DATA_AND_L1PF_RD.ANY_RESPONSE",
>           "Counter": "0,1,2,3",
>           "EventCode": "0XB7",
> -        "EventName": "OCR.DEMAND_CODE_RD.LOCAL_DRAM",
> +        "EventName": "OCR.DEMAND_DATA_RD.ANY_RESPONSE",
>           "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x184000004",
> +        "MSRValue": "0x10001",
>           "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
>           "SampleAfterValue": "100003",
>           "UMask": "0x1"
>       },
>       {
> -        "BriefDescription": "Counts cacheable demand data reads, L1 data cache hardware prefetches and software prefetches (except PREFETCHW) that have any type of response.",
> +        "BriefDescription": "This event is deprecated. Refer to new event OCR.DEMAND_DATA_AND_L1PF_RD.DRAM",
>           "Counter": "0,1,2,3",
>           "EventCode": "0XB7",
> -        "EventName": "OCR.DEMAND_DATA_AND_L1PF_RD.ANY_RESPONSE",
> +        "EventName": "OCR.DEMAND_DATA_RD.DRAM",
>           "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x10001",
> +        "MSRValue": "0x184000001",
>           "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
>           "SampleAfterValue": "100003",
>           "UMask": "0x1"
>       },
>       {
> -        "BriefDescription": "Counts cacheable demand data reads, L1 data cache hardware prefetches and software prefetches (except PREFETCHW) that were supplied by DRAM.",
> +        "BriefDescription": "This event is deprecated. Refer to new event OCR.DEMAND_DATA_AND_L1PF_RD.LOCAL_DRAM",
>           "Counter": "0,1,2,3",
>           "EventCode": "0XB7",
> -        "EventName": "OCR.DEMAND_DATA_AND_L1PF_RD.DRAM",
> +        "EventName": "OCR.DEMAND_DATA_RD.LOCAL_DRAM",
>           "MSRIndex": "0x1a6,0x1a7",
>           "MSRValue": "0x184000001",
>           "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
>           "SampleAfterValue": "100003",
>           "UMask": "0x1"
>       },
>       {
> -        "BriefDescription": "Counts cacheable demand data reads, L1 data cache hardware prefetches and software prefetches (except PREFETCHW) that were supplied by the L3 cache.",
> +        "BriefDescription": "This event is deprecated. Refer to new event OCR.DEMAND_DATA_AND_L1PF_RD.OUTSTANDING",
>           "Counter": "0,1,2,3",
>           "EventCode": "0XB7",
> -        "EventName": "OCR.DEMAND_DATA_AND_L1PF_RD.L3_HIT",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x1F803C0001",
> +        "EventName": "OCR.DEMAND_DATA_RD.OUTSTANDING",
> +        "MSRIndex": "0x1a6",
> +        "MSRValue": "0x8000000000000001",
>           "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
>           "SampleAfterValue": "100003",
>           "UMask": "0x1"
>       },
>       {
> -        "BriefDescription": "Counts cacheable demand data reads, L1 data cache hardware prefetches and software prefetches (except PREFETCHW) that were supplied by the L3 cache where a snoop was sent, the snoop hit, and modified data was forwarded.",
> +        "BriefDescription": "Counts demand reads for ownership (RFO) and software prefetches for exclusive ownership (PREFETCHW) that have any type of response.",
>           "Counter": "0,1,2,3",
>           "EventCode": "0XB7",
> -        "EventName": "OCR.DEMAND_DATA_AND_L1PF_RD.L3_HIT.SNOOP_HITM",
> +        "EventName": "OCR.DEMAND_RFO.ANY_RESPONSE",
>           "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x10003C0001",
> +        "MSRValue": "0x10002",
>           "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
>           "SampleAfterValue": "100003",
>           "UMask": "0x1"
>       },
>       {
> -        "BriefDescription": "Counts cacheable demand data reads, L1 data cache hardware prefetches and software prefetches (except PREFETCHW) that were supplied by the L3 cache where a snoop was sent, the snoop hit, but no data was forwarded.",
> +        "BriefDescription": "Counts demand reads for ownership (RFO) and software prefetches for exclusive ownership (PREFETCHW) that were supplied by DRAM.",
>           "Counter": "0,1,2,3",
>           "EventCode": "0XB7",
> -        "EventName": "OCR.DEMAND_DATA_AND_L1PF_RD.L3_HIT.SNOOP_HIT_NO_FWD",
> +        "EventName": "OCR.DEMAND_RFO.DRAM",
>           "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x4003C0001",
> +        "MSRValue": "0x184000002",
>           "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
>           "SampleAfterValue": "100003",
>           "UMask": "0x1"
>       },
>       {
> -        "BriefDescription": "Counts cacheable demand data reads, L1 data cache hardware prefetches and software prefetches (except PREFETCHW) that were supplied by the L3 cache where a snoop was sent, the snoop hit, and non-modified data was forwarded.",
> +        "BriefDescription": "Counts demand reads for ownership (RFO) and software prefetches for exclusive ownership (PREFETCHW) that were supplied by DRAM.",
>           "Counter": "0,1,2,3",
>           "EventCode": "0XB7",
> -        "EventName": "OCR.DEMAND_DATA_AND_L1PF_RD.L3_HIT.SNOOP_HIT_WITH_FWD",
> +        "EventName": "OCR.DEMAND_RFO.LOCAL_DRAM",
>           "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x8003C0001",
> +        "MSRValue": "0x184000002",
>           "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
>           "SampleAfterValue": "100003",
>           "UMask": "0x1"
>       },
>       {
> -        "BriefDescription": "Counts cacheable demand data reads, L1 data cache hardware prefetches and software prefetches (except PREFETCHW) that were supplied by the L3 cache where a snoop was sent but the snoop missed.",
> +        "BriefDescription": "Counts demand reads for ownership (RFO) and software prefetches for exclusive ownership (PREFETCHW) that have an outstanding request. Returns the number of cycles until the response is received (i.e. XQ to XQ latency).",
>           "Counter": "0,1,2,3",
>           "EventCode": "0XB7",
> -        "EventName": "OCR.DEMAND_DATA_AND_L1PF_RD.L3_HIT.SNOOP_MISS",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x2003C0001",
> +        "EventName": "OCR.DEMAND_RFO.OUTSTANDING",
> +        "MSRIndex": "0x1a6",
> +        "MSRValue": "0x8000000000000002",
>           "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
>           "SampleAfterValue": "100003",
>           "UMask": "0x1"
>       },
>       {
> -        "BriefDescription": "Counts cacheable demand data reads, L1 data cache hardware prefetches and software prefetches (except PREFETCHW) that were supplied by the L3 cache where no snoop was needed to satisfy the request.",
> +        "BriefDescription": "Counts streaming stores which modify a full 64 byte cacheline that have any type of response.",
>           "Counter": "0,1,2,3",
>           "EventCode": "0XB7",
> -        "EventName": "OCR.DEMAND_DATA_AND_L1PF_RD.L3_HIT.SNOOP_NOT_NEEDED",
> +        "EventName": "OCR.FULL_STREAMING_WR.ANY_RESPONSE",
>           "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x1003C0001",
> +        "MSRValue": "0x800000010000",
>           "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
>           "SampleAfterValue": "100003",
>           "UMask": "0x1"
>       },
>       {
> -        "BriefDescription": "Counts cacheable demand data reads, L1 data cache hardware prefetches and software prefetches (except PREFETCHW) that were supplied by DRAM.",
> +        "BriefDescription": "Counts L1 data cache hardware prefetches and software prefetches (except PREFETCHW and PFRFO) that have any type of response.",
>           "Counter": "0,1,2,3",
>           "EventCode": "0XB7",
> -        "EventName": "OCR.DEMAND_DATA_AND_L1PF_RD.LOCAL_DRAM",
> +        "EventName": "OCR.HWPF_L1D_AND_SWPF.ANY_RESPONSE",
>           "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x184000001",
> +        "MSRValue": "0x10400",
>           "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
>           "SampleAfterValue": "100003",
>           "UMask": "0x1"
>       },
>       {
> -        "BriefDescription": "Counts cacheable demand data reads, L1 data cache hardware prefetches and software prefetches (except PREFETCHW) that have an outstanding request. Returns the number of cycles until the response is received (i.e. XQ to XQ latency).",
> +        "BriefDescription": "Counts L2 cache hardware prefetch code reads (written to the L2 cache only) that have any type of response.",
>           "Counter": "0,1,2,3",
>           "EventCode": "0XB7",
> -        "EventName": "OCR.DEMAND_DATA_AND_L1PF_RD.OUTSTANDING",
> -        "MSRIndex": "0x1a6",
> -        "MSRValue": "0x8000000000000001",
> +        "EventName": "OCR.HWPF_L2_CODE_RD.ANY_RESPONSE",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x10040",
>           "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
>           "SampleAfterValue": "100003",
>           "UMask": "0x1"
>       },
>       {
> -        "BriefDescription": "This event is deprecated. Refer to new event OCR.DEMAND_DATA_AND_L1PF_RD.ANY_RESPONSE",
> +        "BriefDescription": "Counts L2 cache hardware prefetch code reads (written to the L2 cache only) that were supplied by DRAM.",
>           "Counter": "0,1,2,3",
>           "EventCode": "0XB7",
> -        "EventName": "OCR.DEMAND_DATA_RD.ANY_RESPONSE",
> +        "EventName": "OCR.HWPF_L2_CODE_RD.DRAM",
>           "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x10001",
> +        "MSRValue": "0x184000040",
>           "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
>           "SampleAfterValue": "100003",
>           "UMask": "0x1"
>       },
>       {
> -        "BriefDescription": "This event is deprecated. Refer to new event OCR.DEMAND_DATA_AND_L1PF_RD.DRAM",
> +        "BriefDescription": "Counts L2 cache hardware prefetch code reads (written to the L2 cache only) that were supplied by DRAM.",
>           "Counter": "0,1,2,3",
>           "EventCode": "0XB7",
> -        "EventName": "OCR.DEMAND_DATA_RD.DRAM",
> +        "EventName": "OCR.HWPF_L2_CODE_RD.LOCAL_DRAM",
>           "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x184000001",
> +        "MSRValue": "0x184000040",
>           "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
>           "SampleAfterValue": "100003",
>           "UMask": "0x1"
>       },
>       {
> -        "BriefDescription": "This event is deprecated. Refer to new event OCR.DEMAND_DATA_AND_L1PF_RD.L3_HIT",
> +        "BriefDescription": "Counts L2 cache hardware prefetch code reads (written to the L2 cache only) that have an outstanding request. Returns the number of cycles until the response is received (i.e. XQ to XQ latency).",
>           "Counter": "0,1,2,3",
>           "EventCode": "0XB7",
> -        "EventName": "OCR.DEMAND_DATA_RD.L3_HIT",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x1F803C0001",
> +        "EventName": "OCR.HWPF_L2_CODE_RD.OUTSTANDING",
> +        "MSRIndex": "0x1a6",
> +        "MSRValue": "0x8000000000000040",
>           "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
>           "SampleAfterValue": "100003",
>           "UMask": "0x1"
>       },
>       {
> -        "BriefDescription": "This event is deprecated. Refer to new event OCR.DEMAND_DATA_AND_L1PF_RD.L3_HIT.SNOOP_HITM",
> +        "BriefDescription": "Counts L2 cache hardware prefetch data reads (written to the L2 cache only) that have any type of response.",
>           "Counter": "0,1,2,3",
>           "EventCode": "0XB7",
> -        "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM",
> +        "EventName": "OCR.HWPF_L2_DATA_RD.ANY_RESPONSE",
>           "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x10003C0001",
> +        "MSRValue": "0x10010",
>           "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
>           "SampleAfterValue": "100003",
>           "UMask": "0x1"
>       },
>       {
> -        "BriefDescription": "This event is deprecated. Refer to new event OCR.DEMAND_DATA_AND_L1PF_RD.L3_HIT.SNOOP_HIT_NO_FWD",
> +        "BriefDescription": "Counts L2 cache hardware prefetch data reads (written to the L2 cache only) that were supplied by DRAM.",
>           "Counter": "0,1,2,3",
>           "EventCode": "0XB7",
> -        "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_NO_FWD",
> +        "EventName": "OCR.HWPF_L2_DATA_RD.DRAM",
>           "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x4003C0001",
> +        "MSRValue": "0x184000010",
>           "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
>           "SampleAfterValue": "100003",
>           "UMask": "0x1"
>       },
>       {
> -        "BriefDescription": "This event is deprecated. Refer to new event OCR.DEMAND_DATA_AND_L1PF_RD.L3_HIT.SNOOP_HIT_WITH_FWD",
> +        "BriefDescription": "Counts L2 cache hardware prefetch data reads (written to the L2 cache only) that were supplied by DRAM.",
>           "Counter": "0,1,2,3",
>           "EventCode": "0XB7",
> -        "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_WITH_FWD",
> +        "EventName": "OCR.HWPF_L2_DATA_RD.LOCAL_DRAM",
>           "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x8003C0001",
> +        "MSRValue": "0x184000010",
>           "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
>           "SampleAfterValue": "100003",
>           "UMask": "0x1"
>       },
>       {
> -        "BriefDescription": "This event is deprecated. Refer to new event OCR.DEMAND_DATA_AND_L1PF_RD.L3_HIT.SNOOP_MISS",
> +        "BriefDescription": "Counts L2 cache hardware prefetch RFOs (written to the L2 cache only) that have any type of response.",
>           "Counter": "0,1,2,3",
>           "EventCode": "0XB7",
> -        "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_MISS",
> +        "EventName": "OCR.HWPF_L2_RFO.ANY_RESPONSE",
>           "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x2003C0001",
> +        "MSRValue": "0x10020",
>           "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
>           "SampleAfterValue": "100003",
>           "UMask": "0x1"
>       },
>       {
> -        "BriefDescription": "This event is deprecated. Refer to new event OCR.DEMAND_DATA_AND_L1PF_RD.L3_HIT.SNOOP_NOT_NEEDED",
> +        "BriefDescription": "Counts L2 cache hardware prefetch RFOs (written to the L2 cache only) that were supplied by DRAM.",
>           "Counter": "0,1,2,3",
>           "EventCode": "0XB7",
> -        "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_NOT_NEEDED",
> +        "EventName": "OCR.HWPF_L2_RFO.DRAM",
>           "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x1003C0001",
> +        "MSRValue": "0x184000020",
>           "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
>           "SampleAfterValue": "100003",
>           "UMask": "0x1"
>       },
>       {
> -        "BriefDescription": "This event is deprecated. Refer to new event OCR.DEMAND_DATA_AND_L1PF_RD.LOCAL_DRAM",
> +        "BriefDescription": "Counts L2 cache hardware prefetch RFOs (written to the L2 cache only) that were supplied by DRAM.",
>           "Counter": "0,1,2,3",
>           "EventCode": "0XB7",
> -        "EventName": "OCR.DEMAND_DATA_RD.LOCAL_DRAM",
> +        "EventName": "OCR.HWPF_L2_RFO.LOCAL_DRAM",
>           "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x184000001",
> +        "MSRValue": "0x184000020",
>           "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
>           "SampleAfterValue": "100003",
>           "UMask": "0x1"
>       },
>       {
> -        "BriefDescription": "This event is deprecated. Refer to new event OCR.DEMAND_DATA_AND_L1PF_RD.OUTSTANDING",
> +        "BriefDescription": "Counts L2 cache hardware prefetch RFOs (written to the L2 cache only) that have an outstanding request. Returns the number of cycles until the response is received (i.e. XQ to XQ latency).",
>           "Counter": "0,1,2,3",
>           "EventCode": "0XB7",
> -        "EventName": "OCR.DEMAND_DATA_RD.OUTSTANDING",
> +        "EventName": "OCR.HWPF_L2_RFO.OUTSTANDING",
>           "MSRIndex": "0x1a6",
> -        "MSRValue": "0x8000000000000001",
> -        "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts demand reads for ownership (RFO) and software prefetches for exclusive ownership (PREFETCHW) that have any type of response.",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0XB7",
> -        "EventName": "OCR.DEMAND_RFO.ANY_RESPONSE",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x10002",
> +        "MSRValue": "0x8000000000000020",
>           "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
>           "SampleAfterValue": "100003",
>           "UMask": "0x1"
>       },
>       {
> -        "BriefDescription": "Counts demand reads for ownership (RFO) and software prefetches for exclusive ownership (PREFETCHW) that were supplied by DRAM.",
> +        "BriefDescription": "Counts modified writebacks from L1 cache that miss the L2 cache that have any type of response.",
>           "Counter": "0,1,2,3",
>           "EventCode": "0XB7",
> -        "EventName": "OCR.DEMAND_RFO.DRAM",
> +        "EventName": "OCR.L1WB_M.ANY_RESPONSE",
>           "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x184000002",
> +        "MSRValue": "0x1000000010000",
>           "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
>           "SampleAfterValue": "100003",
>           "UMask": "0x1"
>       },
>       {
> -        "BriefDescription": "Counts demand reads for ownership (RFO) and software prefetches for exclusive ownership (PREFETCHW) that were supplied by the L3 cache.",
> +        "BriefDescription": "Counts modified writeBacks from L2 cache that miss the L3 cache that have any type of response.",
>           "Counter": "0,1,2,3",
>           "EventCode": "0XB7",
> -        "EventName": "OCR.DEMAND_RFO.L3_HIT",
> +        "EventName": "OCR.L2WB_M.ANY_RESPONSE",
>           "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x1F803C0002",
> +        "MSRValue": "0x2000000010000",
>           "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
>           "SampleAfterValue": "100003",
>           "UMask": "0x1"
>       },
>       {
> -        "BriefDescription": "Counts demand reads for ownership (RFO) and software prefetches for exclusive ownership (PREFETCHW) that were supplied by the L3 cache where a snoop was sent, the snoop hit, and modified data was forwarded.",
> +        "BriefDescription": "Counts miscellaneous requests, such as I/O accesses, that have any type of response.",
>           "Counter": "0,1,2,3",
>           "EventCode": "0XB7",
> -        "EventName": "OCR.DEMAND_RFO.L3_HIT.SNOOP_HITM",
> +        "EventName": "OCR.OTHER.ANY_RESPONSE",
>           "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x10003C0002",
> +        "MSRValue": "0x18000",
>           "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
>           "SampleAfterValue": "100003",
>           "UMask": "0x1"
>       },
>       {
> -        "BriefDescription": "Counts demand reads for ownership (RFO) and software prefetches for exclusive ownership (PREFETCHW) that were supplied by the L3 cache where a snoop was sent, the snoop hit, but no data was forwarded.",
> +        "BriefDescription": "Counts streaming stores which modify only part of a 64 byte cacheline that have any type of response.",
>           "Counter": "0,1,2,3",
>           "EventCode": "0XB7",
> -        "EventName": "OCR.DEMAND_RFO.L3_HIT.SNOOP_HIT_NO_FWD",
> +        "EventName": "OCR.PARTIAL_STREAMING_WR.ANY_RESPONSE",
>           "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x4003C0002",
> +        "MSRValue": "0x400000010000",
>           "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
>           "SampleAfterValue": "100003",
>           "UMask": "0x1"
>       },
>       {
> -        "BriefDescription": "Counts demand reads for ownership (RFO) and software prefetches for exclusive ownership (PREFETCHW) that were supplied by the L3 cache where a snoop was sent, the snoop hit, and non-modified data was forwarded.",
> +        "BriefDescription": "Counts all hardware and software prefetches that have any type of response.",
>           "Counter": "0,1,2,3",
>           "EventCode": "0XB7",
> -        "EventName": "OCR.DEMAND_RFO.L3_HIT.SNOOP_HIT_WITH_FWD",
> +        "EventName": "OCR.PREFETCHES.ANY_RESPONSE",
>           "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x8003C0002",
> +        "MSRValue": "0x10470",
>           "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
>           "SampleAfterValue": "100003",
>           "UMask": "0x1"
>       },
>       {
> -        "BriefDescription": "Counts demand reads for ownership (RFO) and software prefetches for exclusive ownership (PREFETCHW) that were supplied by the L3 cache where a snoop was sent but the snoop missed.",
> +        "BriefDescription": "Counts all data read, code read and RFO requests including demands and prefetches to the core caches (L1 or L2) that have any type of response.",
>           "Counter": "0,1,2,3",
>           "EventCode": "0XB7",
> -        "EventName": "OCR.DEMAND_RFO.L3_HIT.SNOOP_MISS",
> +        "EventName": "OCR.READS_TO_CORE.ANY_RESPONSE",
>           "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x2003C0002",
> +        "MSRValue": "0x10477",
>           "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
>           "SampleAfterValue": "100003",
>           "UMask": "0x1"
>       },
>       {
> -        "BriefDescription": "Counts demand reads for ownership (RFO) and software prefetches for exclusive ownership (PREFETCHW) that were supplied by the L3 cache where no snoop was needed to satisfy the request.",
> +        "BriefDescription": "Counts all data read, code read and RFO requests including demands and prefetches to the core caches (L1 or L2) that were supplied by DRAM.",
>           "Counter": "0,1,2,3",
>           "EventCode": "0XB7",
> -        "EventName": "OCR.DEMAND_RFO.L3_HIT.SNOOP_NOT_NEEDED",
> +        "EventName": "OCR.READS_TO_CORE.DRAM",
>           "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x1003C0002",
> +        "MSRValue": "0x184000477",
>           "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
>           "SampleAfterValue": "100003",
>           "UMask": "0x1"
>       },
>       {
> -        "BriefDescription": "Counts demand reads for ownership (RFO) and software prefetches for exclusive ownership (PREFETCHW) that were supplied by DRAM.",
> +        "BriefDescription": "Counts all data read, code read and RFO requests including demands and prefetches to the core caches (L1 or L2) that were supplied by DRAM.",
>           "Counter": "0,1,2,3",
>           "EventCode": "0XB7",
> -        "EventName": "OCR.DEMAND_RFO.LOCAL_DRAM",
> +        "EventName": "OCR.READS_TO_CORE.LOCAL_DRAM",
>           "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x184000002",
> +        "MSRValue": "0x184000477",
>           "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
>           "SampleAfterValue": "100003",
>           "UMask": "0x1"
>       },
>       {
> -        "BriefDescription": "Counts demand reads for ownership (RFO) and software prefetches for exclusive ownership (PREFETCHW) that have an outstanding request. Returns the number of cycles until the response is received (i.e. XQ to XQ latency).",
> +        "BriefDescription": "Counts all data read, code read and RFO requests including demands and prefetches to the core caches (L1 or L2) that have an outstanding request. Returns the number of cycles until the response is received (i.e. XQ to XQ latency).",
>           "Counter": "0,1,2,3",
>           "EventCode": "0XB7",
> -        "EventName": "OCR.DEMAND_RFO.OUTSTANDING",
> +        "EventName": "OCR.READS_TO_CORE.OUTSTANDING",
>           "MSRIndex": "0x1a6",
> -        "MSRValue": "0x8000000000000002",
> +        "MSRValue": "0x8000000000000477",
>           "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
>           "SampleAfterValue": "100003",
>           "UMask": "0x1"
>       },
>       {
> -        "BriefDescription": "Counts streaming stores which modify a full 64 byte cacheline that have any type of response.",
> +        "BriefDescription": "Counts streaming stores that have any type of response.",
>           "Counter": "0,1,2,3",
>           "EventCode": "0XB7",
> -        "EventName": "OCR.FULL_STREAMING_WR.ANY_RESPONSE",
> +        "EventName": "OCR.STREAMING_WR.ANY_RESPONSE",
>           "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x800000010000",
> +        "MSRValue": "0x10800",
>           "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
>           "SampleAfterValue": "100003",
>           "UMask": "0x1"
>       },
>       {
> -        "BriefDescription": "Counts streaming stores which modify a full 64 byte cacheline that were supplied by the L3 cache.",
> +        "BriefDescription": "Counts uncached memory reads that have any type of response.",
>           "Counter": "0,1,2,3",
>           "EventCode": "0XB7",
> -        "EventName": "OCR.FULL_STREAMING_WR.L3_HIT",
> +        "EventName": "OCR.UC_RD.ANY_RESPONSE",
>           "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x801F803C0000",
> +        "MSRValue": "0x100000010000",
>           "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
>           "SampleAfterValue": "100003",
>           "UMask": "0x1"
>       },
>       {
> -        "BriefDescription": "Counts L2 cache hardware prefetch code reads (written to the L2 cache only) that have any type of response.",
> +        "BriefDescription": "Counts uncached memory reads that were supplied by DRAM.",
>           "Counter": "0,1,2,3",
>           "EventCode": "0XB7",
> -        "EventName": "OCR.HWPF_L2_CODE_RD.ANY_RESPONSE",
> +        "EventName": "OCR.UC_RD.DRAM",
>           "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x10040",
> +        "MSRValue": "0x100184000000",
>           "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
>           "SampleAfterValue": "100003",
>           "UMask": "0x1"
>       },
>       {
> -        "BriefDescription": "Counts L2 cache hardware prefetch code reads (written to the L2 cache only) that were supplied by DRAM.",
> +        "BriefDescription": "Counts uncached memory reads that were supplied by DRAM.",
>           "Counter": "0,1,2,3",
>           "EventCode": "0XB7",
> -        "EventName": "OCR.HWPF_L2_CODE_RD.DRAM",
> +        "EventName": "OCR.UC_RD.LOCAL_DRAM",
>           "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x184000040",
> +        "MSRValue": "0x100184000000",
>           "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
>           "SampleAfterValue": "100003",
>           "UMask": "0x1"
>       },
>       {
> -        "BriefDescription": "Counts L2 cache hardware prefetch code reads (written to the L2 cache only) that were supplied by the L3 cache.",
> +        "BriefDescription": "Counts uncached memory reads that have an outstanding request. Returns the number of cycles until the response is received (i.e. XQ to XQ latency).",
>           "Counter": "0,1,2,3",
>           "EventCode": "0XB7",
> -        "EventName": "OCR.HWPF_L2_CODE_RD.L3_HIT",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x1F803C0040",
> +        "EventName": "OCR.UC_RD.OUTSTANDING",
> +        "MSRIndex": "0x1a6",
> +        "MSRValue": "0x8000100000000000",
>           "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
>           "SampleAfterValue": "100003",
>           "UMask": "0x1"
>       },
>       {
> -        "BriefDescription": "Counts L2 cache hardware prefetch code reads (written to the L2 cache only) that were supplied by the L3 cache where a snoop was sent, the snoop hit, and modified data was forwarded.",
> +        "BriefDescription": "Counts uncached memory writes that have any type of response.",
>           "Counter": "0,1,2,3",
>           "EventCode": "0XB7",
> -        "EventName": "OCR.HWPF_L2_CODE_RD.L3_HIT.SNOOP_HITM",
> +        "EventName": "OCR.UC_WR.ANY_RESPONSE",
>           "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x10003C0040",
> +        "MSRValue": "0x200000010000",
>           "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
>           "SampleAfterValue": "100003",
>           "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts L2 cache hardware prefetch code reads (written to the L2 cache only) that were supplied by the L3 cache where a snoop was sent, the snoop hit, but no data was forwarded.",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0XB7",
> -        "EventName": "OCR.HWPF_L2_CODE_RD.L3_HIT.SNOOP_HIT_NO_FWD",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x4003C0040",
> -        "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts L2 cache hardware prefetch code reads (written to the L2 cache only) that were supplied by the L3 cache where a snoop was sent, the snoop hit, and non-modified data was forwarded.",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0XB7",
> -        "EventName": "OCR.HWPF_L2_CODE_RD.L3_HIT.SNOOP_HIT_WITH_FWD",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x8003C0040",
> -        "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts L2 cache hardware prefetch code reads (written to the L2 cache only) that were supplied by the L3 cache where a snoop was sent but the snoop missed.",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0XB7",
> -        "EventName": "OCR.HWPF_L2_CODE_RD.L3_HIT.SNOOP_MISS",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x2003C0040",
> -        "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts L2 cache hardware prefetch code reads (written to the L2 cache only) that were supplied by the L3 cache where no snoop was needed to satisfy the request.",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0XB7",
> -        "EventName": "OCR.HWPF_L2_CODE_RD.L3_HIT.SNOOP_NOT_NEEDED",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x1003C0040",
> -        "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts L2 cache hardware prefetch code reads (written to the L2 cache only) that were supplied by DRAM.",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0XB7",
> -        "EventName": "OCR.HWPF_L2_CODE_RD.LOCAL_DRAM",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x184000040",
> -        "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts L2 cache hardware prefetch code reads (written to the L2 cache only) that have an outstanding request. Returns the number of cycles until the response is received (i.e. XQ to XQ latency).",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0XB7",
> -        "EventName": "OCR.HWPF_L2_CODE_RD.OUTSTANDING",
> -        "MSRIndex": "0x1a6",
> -        "MSRValue": "0x8000000000000040",
> -        "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts L2 cache hardware prefetch data reads (written to the L2 cache only) that have any type of response.",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0XB7",
> -        "EventName": "OCR.HWPF_L2_DATA_RD.ANY_RESPONSE",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x10010",
> -        "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts L2 cache hardware prefetch data reads (written to the L2 cache only) that were supplied by DRAM.",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0XB7",
> -        "EventName": "OCR.HWPF_L2_DATA_RD.DRAM",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x184000010",
> -        "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts L2 cache hardware prefetch data reads (written to the L2 cache only) that were supplied by the L3 cache.",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0XB7",
> -        "EventName": "OCR.HWPF_L2_DATA_RD.L3_HIT",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x1F803C0010",
> -        "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts L2 cache hardware prefetch data reads (written to the L2 cache only) that were supplied by the L3 cache where a snoop was sent, the snoop hit, and modified data was forwarded.",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0XB7",
> -        "EventName": "OCR.HWPF_L2_DATA_RD.L3_HIT.SNOOP_HITM",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x10003C0010",
> -        "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts L2 cache hardware prefetch data reads (written to the L2 cache only) that were supplied by the L3 cache where a snoop was sent, the snoop hit, but no data was forwarded.",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0XB7",
> -        "EventName": "OCR.HWPF_L2_DATA_RD.L3_HIT.SNOOP_HIT_NO_FWD",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x4003C0010",
> -        "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts L2 cache hardware prefetch data reads (written to the L2 cache only) that were supplied by the L3 cache where a snoop was sent, the snoop hit, and non-modified data was forwarded.",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0XB7",
> -        "EventName": "OCR.HWPF_L2_DATA_RD.L3_HIT.SNOOP_HIT_WITH_FWD",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x8003C0010",
> -        "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts L2 cache hardware prefetch data reads (written to the L2 cache only) that were supplied by the L3 cache where a snoop was sent but the snoop missed.",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0XB7",
> -        "EventName": "OCR.HWPF_L2_DATA_RD.L3_HIT.SNOOP_MISS",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x2003C0010",
> -        "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts L2 cache hardware prefetch data reads (written to the L2 cache only) that were supplied by the L3 cache where no snoop was needed to satisfy the request.",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0XB7",
> -        "EventName": "OCR.HWPF_L2_DATA_RD.L3_HIT.SNOOP_NOT_NEEDED",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x1003C0010",
> -        "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts L2 cache hardware prefetch data reads (written to the L2 cache only) that were supplied by DRAM.",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0XB7",
> -        "EventName": "OCR.HWPF_L2_DATA_RD.LOCAL_DRAM",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x184000010",
> -        "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts L2 cache hardware prefetch RFOs (written to the L2 cache only) that have any type of response.",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0XB7",
> -        "EventName": "OCR.HWPF_L2_RFO.ANY_RESPONSE",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x10020",
> -        "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts L2 cache hardware prefetch RFOs (written to the L2 cache only) that were supplied by DRAM.",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0XB7",
> -        "EventName": "OCR.HWPF_L2_RFO.DRAM",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x184000020",
> -        "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts L2 cache hardware prefetch RFOs (written to the L2 cache only) that were supplied by the L3 cache.",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0XB7",
> -        "EventName": "OCR.HWPF_L2_RFO.L3_HIT",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x1F803C0020",
> -        "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts L2 cache hardware prefetch RFOs (written to the L2 cache only) that were supplied by the L3 cache where a snoop was sent, the snoop hit, and modified data was forwarded.",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0XB7",
> -        "EventName": "OCR.HWPF_L2_RFO.L3_HIT.SNOOP_HITM",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x10003C0020",
> -        "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts L2 cache hardware prefetch RFOs (written to the L2 cache only) that were supplied by the L3 cache where a snoop was sent, the snoop hit, but no data was forwarded.",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0XB7",
> -        "EventName": "OCR.HWPF_L2_RFO.L3_HIT.SNOOP_HIT_NO_FWD",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x4003C0020",
> -        "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts L2 cache hardware prefetch RFOs (written to the L2 cache only) that were supplied by the L3 cache where a snoop was sent, the snoop hit, and non-modified data was forwarded.",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0XB7",
> -        "EventName": "OCR.HWPF_L2_RFO.L3_HIT.SNOOP_HIT_WITH_FWD",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x8003C0020",
> -        "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts L2 cache hardware prefetch RFOs (written to the L2 cache only) that were supplied by the L3 cache where a snoop was sent but the snoop missed.",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0XB7",
> -        "EventName": "OCR.HWPF_L2_RFO.L3_HIT.SNOOP_MISS",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x2003C0020",
> -        "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts L2 cache hardware prefetch RFOs (written to the L2 cache only) that were supplied by the L3 cache where no snoop was needed to satisfy the request.",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0XB7",
> -        "EventName": "OCR.HWPF_L2_RFO.L3_HIT.SNOOP_NOT_NEEDED",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x1003C0020",
> -        "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts L2 cache hardware prefetch RFOs (written to the L2 cache only) that were supplied by DRAM.",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0XB7",
> -        "EventName": "OCR.HWPF_L2_RFO.LOCAL_DRAM",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x184000020",
> -        "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts L2 cache hardware prefetch RFOs (written to the L2 cache only) that have an outstanding request. Returns the number of cycles until the response is received (i.e. XQ to XQ latency).",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0XB7",
> -        "EventName": "OCR.HWPF_L2_RFO.OUTSTANDING",
> -        "MSRIndex": "0x1a6",
> -        "MSRValue": "0x8000000000000020",
> -        "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts modified writebacks from L1 cache that miss the L2 cache that have any type of response.",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0XB7",
> -        "EventName": "OCR.L1WB_M.ANY_RESPONSE",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x1000000010000",
> -        "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts modified writebacks from L1 cache that miss the L2 cache that were supplied by the L3 cache.",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0XB7",
> -        "EventName": "OCR.L1WB_M.L3_HIT",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x1001F803C0000",
> -        "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts modified writeBacks from L2 cache that miss the L3 cache that have any type of response.",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0XB7",
> -        "EventName": "OCR.L2WB_M.ANY_RESPONSE",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x2000000010000",
> -        "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts modified writeBacks from L2 cache that miss the L3 cache that were supplied by the L3 cache.",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0XB7",
> -        "EventName": "OCR.L2WB_M.L3_HIT",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x2001F803C0000",
> -        "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts miscellaneous requests, such as I/O accesses, that have any type of response.",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0XB7",
> -        "EventName": "OCR.OTHER.ANY_RESPONSE",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x18000",
> -        "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts streaming stores which modify only part of a 64 byte cacheline that have any type of response.",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0XB7",
> -        "EventName": "OCR.PARTIAL_STREAMING_WR.ANY_RESPONSE",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x400000010000",
> -        "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts streaming stores which modify only part of a 64 byte cacheline that were supplied by the L3 cache.",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0XB7",
> -        "EventName": "OCR.PARTIAL_STREAMING_WR.L3_HIT",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x401F803C0000",
> -        "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts all hardware and software prefetches that have any type of response.",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0XB7",
> -        "EventName": "OCR.PREFETCHES.ANY_RESPONSE",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x10470",
> -        "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts all data read, code read and RFO requests including demands and prefetches to the core caches (L1 or L2) that have any type of response.",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0XB7",
> -        "EventName": "OCR.READS_TO_CORE.ANY_RESPONSE",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x10477",
> -        "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts all data read, code read and RFO requests including demands and prefetches to the core caches (L1 or L2) that were supplied by DRAM.",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0XB7",
> -        "EventName": "OCR.READS_TO_CORE.DRAM",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x184000477",
> -        "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts all data read, code read and RFO requests including demands and prefetches to the core caches (L1 or L2) that were supplied by the L3 cache.",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0XB7",
> -        "EventName": "OCR.READS_TO_CORE.L3_HIT",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x1F803C0477",
> -        "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts all data read, code read and RFO requests including demands and prefetches to the core caches (L1 or L2) that were supplied by the L3 cache where a snoop was sent, the snoop hit, and modified data was forwarded.",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0XB7",
> -        "EventName": "OCR.READS_TO_CORE.L3_HIT.SNOOP_HITM",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x10003C0477",
> -        "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts all data read, code read and RFO requests including demands and prefetches to the core caches (L1 or L2) that were supplied by the L3 cache where a snoop was sent, the snoop hit, but no data was forwarded.",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0XB7",
> -        "EventName": "OCR.READS_TO_CORE.L3_HIT.SNOOP_HIT_NO_FWD",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x4003C0477",
> -        "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts all data read, code read and RFO requests including demands and prefetches to the core caches (L1 or L2) that were supplied by the L3 cache where a snoop was sent, the snoop hit, and non-modified data was forwarded.",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0XB7",
> -        "EventName": "OCR.READS_TO_CORE.L3_HIT.SNOOP_HIT_WITH_FWD",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x8003C0477",
> -        "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts all data read, code read and RFO requests including demands and prefetches to the core caches (L1 or L2) that were supplied by the L3 cache where a snoop was sent but the snoop missed.",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0XB7",
> -        "EventName": "OCR.READS_TO_CORE.L3_HIT.SNOOP_MISS",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x2003C0477",
> -        "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts all data read, code read and RFO requests including demands and prefetches to the core caches (L1 or L2) that were supplied by the L3 cache where no snoop was needed to satisfy the request.",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0XB7",
> -        "EventName": "OCR.READS_TO_CORE.L3_HIT.SNOOP_NOT_NEEDED",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x1003C0477",
> -        "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts all data read, code read and RFO requests including demands and prefetches to the core caches (L1 or L2) that were supplied by DRAM.",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0XB7",
> -        "EventName": "OCR.READS_TO_CORE.LOCAL_DRAM",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x184000477",
> -        "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts all data read, code read and RFO requests including demands and prefetches to the core caches (L1 or L2) that have an outstanding request. Returns the number of cycles until the response is received (i.e. XQ to XQ latency).",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0XB7",
> -        "EventName": "OCR.READS_TO_CORE.OUTSTANDING",
> -        "MSRIndex": "0x1a6",
> -        "MSRValue": "0x8000000000000477",
> -        "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts streaming stores that have any type of response.",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0XB7",
> -        "EventName": "OCR.STREAMING_WR.ANY_RESPONSE",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x10800",
> -        "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts streaming stores that were supplied by the L3 cache.",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0XB7",
> -        "EventName": "OCR.STREAMING_WR.L3_HIT",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x1F803C0800",
> -        "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts uncached memory reads that have any type of response.",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0XB7",
> -        "EventName": "OCR.UC_RD.ANY_RESPONSE",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x100000010000",
> -        "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts uncached memory reads that were supplied by DRAM.",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0XB7",
> -        "EventName": "OCR.UC_RD.DRAM",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x100184000000",
> -        "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts uncached memory reads that were supplied by the L3 cache.",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0XB7",
> -        "EventName": "OCR.UC_RD.L3_HIT",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x101F803C0000",
> -        "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts uncached memory reads that were supplied by the L3 cache where a snoop was sent, the snoop hit, and modified data was forwarded.",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0XB7",
> -        "EventName": "OCR.UC_RD.L3_HIT.SNOOP_HITM",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x1010003C0000",
> -        "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts uncached memory reads that were supplied by the L3 cache where a snoop was sent, the snoop hit, but no data was forwarded.",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0XB7",
> -        "EventName": "OCR.UC_RD.L3_HIT.SNOOP_HIT_NO_FWD",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x1004003C0000",
> -        "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts uncached memory reads that were supplied by the L3 cache where a snoop was sent, the snoop hit, and non-modified data was forwarded.",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0XB7",
> -        "EventName": "OCR.UC_RD.L3_HIT.SNOOP_HIT_WITH_FWD",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x1008003C0000",
> -        "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts uncached memory reads that were supplied by the L3 cache where a snoop was sent but the snoop missed.",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0XB7",
> -        "EventName": "OCR.UC_RD.L3_HIT.SNOOP_MISS",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x1002003C0000",
> -        "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts uncached memory reads that were supplied by the L3 cache where no snoop was needed to satisfy the request.",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0XB7",
> -        "EventName": "OCR.UC_RD.L3_HIT.SNOOP_NOT_NEEDED",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x1001003C0000",
> -        "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts uncached memory reads that were supplied by DRAM.",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0XB7",
> -        "EventName": "OCR.UC_RD.LOCAL_DRAM",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x100184000000",
> -        "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts uncached memory reads that have an outstanding request. Returns the number of cycles until the response is received (i.e. XQ to XQ latency).",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0XB7",
> -        "EventName": "OCR.UC_RD.OUTSTANDING",
> -        "MSRIndex": "0x1a6",
> -        "MSRValue": "0x8000100000000000",
> -        "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts uncached memory writes that have any type of response.",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0XB7",
> -        "EventName": "OCR.UC_WR.ANY_RESPONSE",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x200000010000",
> -        "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts uncached memory writes that were supplied by the L3 cache.",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0XB7",
> -        "EventName": "OCR.UC_WR.L3_HIT",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x201F803C0000",
> -        "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts the total number of issue slots that were not consumed by the backend because allocation is stalled due to a mispredicted jump or a machine clear.",
> -        "CollectPEBSRecord": "2",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0x73",
> -        "EventName": "TOPDOWN_BAD_SPECULATION.ALL",
> -        "PDIR_COUNTER": "na",
> -        "PEBScounters": "0,1,2,3",
> -        "PublicDescription": "Counts the total number of issue slots that were not consumed by the backend because allocation is stalled due to a mispredicted jump or a machine clear. Only issue slots wasted due to fast nukes such as memory ordering nukes are counted. Other nukes are not accounted for. Counts all issue slots blocked during this recovery window including relevant microcode flows and while uops are not yet available in the instruction queue (IQ) even if an FE_bound event occurs during this period. Also includes the issue slots that were consumed by the backend but were thrown away because they were younger than the mispredict or machine clear.",
> -        "SampleAfterValue": "1000003",
> -        "UMask": "0x6"
> -    },
> -    {
> -        "BriefDescription": "Counts the number of issue slots every cycle that were not consumed by the backend due to fast nukes such as memory ordering and memory disambiguation machine clears.",
> -        "CollectPEBSRecord": "2",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0x73",
> -        "EventName": "TOPDOWN_BAD_SPECULATION.FASTNUKE",
> -        "PDIR_COUNTER": "na",
> -        "PEBScounters": "0,1,2,3",
> -        "SampleAfterValue": "1000003",
> -        "UMask": "0x2"
> -    },
> -    {
> -        "BriefDescription": "Counts the total number of issue slots that were not consumed by the backend because allocation is stalled due to a machine clear (nuke) of any kind including memory ordering and memory disambiguation.",
> -        "CollectPEBSRecord": "2",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0x73",
> -        "EventName": "TOPDOWN_BAD_SPECULATION.MACHINE_CLEARS",
> -        "PDIR_COUNTER": "na",
> -        "PEBScounters": "0,1,2,3",
> -        "SampleAfterValue": "1000003",
> -        "UMask": "0x2"
> -    },
> -    {
> -        "BriefDescription": "Counts the number of issue slots every cycle that were not consumed by the backend due to branch mispredicts.",
> -        "CollectPEBSRecord": "2",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0x73",
> -        "EventName": "TOPDOWN_BAD_SPECULATION.MISPREDICT",
> -        "PDIR_COUNTER": "na",
> -        "PEBScounters": "0,1,2,3",
> -        "SampleAfterValue": "1000003",
> -        "UMask": "0x4"
> -    },
> -    {
> -        "BriefDescription": "This event is deprecated. Refer to new event TOPDOWN_BAD_SPECULATION.FASTNUKE",
> -        "CollectPEBSRecord": "2",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0x73",
> -        "EventName": "TOPDOWN_BAD_SPECULATION.MONUKE",
> -        "PDIR_COUNTER": "na",
> -        "PEBScounters": "0,1,2,3",
> -        "SampleAfterValue": "1000003",
> -        "UMask": "0x2"
> -    },
> -    {
> -        "BriefDescription": "Counts the total number of issue slots every cycle that were not consumed by the backend due to backend stalls.",
> -        "CollectPEBSRecord": "2",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0x74",
> -        "EventName": "TOPDOWN_BE_BOUND.ALL",
> -        "PDIR_COUNTER": "na",
> -        "PEBScounters": "0,1,2,3",
> -        "SampleAfterValue": "1000003"
> -    },
> -    {
> -        "BriefDescription": "Counts the number of issue slots every cycle that were not consumed by the backend due to certain allocation restrictions.",
> -        "CollectPEBSRecord": "2",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0x74",
> -        "EventName": "TOPDOWN_BE_BOUND.ALLOC_RESTRICTIONS",
> -        "PDIR_COUNTER": "na",
> -        "PEBScounters": "0,1,2,3",
> -        "SampleAfterValue": "1000003",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts the number of issue slots every cycle that were not consumed by the backend due to memory reservation stalls in which a scheduler is not able to accept uops.",
> -        "CollectPEBSRecord": "2",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0x74",
> -        "EventName": "TOPDOWN_BE_BOUND.MEM_SCHEDULER",
> -        "PDIR_COUNTER": "na",
> -        "PEBScounters": "0,1,2,3",
> -        "SampleAfterValue": "1000003",
> -        "UMask": "0x2"
> -    },
> -    {
> -        "BriefDescription": "Counts the number of issue slots every cycle that were not consumed by the backend due to IEC or FPC RAT stalls, which can be due to FIQ or IEC reservation stalls in which the integer, floating point or SIMD scheduler is not able to accept uops.",
> -        "CollectPEBSRecord": "2",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0x74",
> -        "EventName": "TOPDOWN_BE_BOUND.NON_MEM_SCHEDULER",
> -        "PDIR_COUNTER": "na",
> -        "PEBScounters": "0,1,2,3",
> -        "SampleAfterValue": "1000003",
> -        "UMask": "0x8"
> -    },
> -    {
> -        "BriefDescription": "Counts the number of issue slots every cycle that were not consumed by the backend due to the physical register file unable to accept an entry (marble stalls).",
> -        "CollectPEBSRecord": "2",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0x74",
> -        "EventName": "TOPDOWN_BE_BOUND.REGISTER",
> -        "PDIR_COUNTER": "na",
> -        "PEBScounters": "0,1,2,3",
> -        "SampleAfterValue": "1000003",
> -        "UMask": "0x20"
> -    },
> -    {
> -        "BriefDescription": "Counts the number of issue slots every cycle that were not consumed by the backend due to the reorder buffer being full (ROB stalls).",
> -        "CollectPEBSRecord": "2",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0x74",
> -        "EventName": "TOPDOWN_BE_BOUND.REORDER_BUFFER",
> -        "PDIR_COUNTER": "na",
> -        "PEBScounters": "0,1,2,3",
> -        "SampleAfterValue": "1000003",
> -        "UMask": "0x40"
> -    },
> -    {
> -        "BriefDescription": "Counts the number of issue slots every cycle that were not consumed by the backend due to scoreboards from the instruction queue (IQ), jump execution unit (JEU), or microcode sequencer (MS).",
> -        "CollectPEBSRecord": "2",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0x74",
> -        "EventName": "TOPDOWN_BE_BOUND.SERIALIZATION",
> -        "PDIR_COUNTER": "na",
> -        "PEBScounters": "0,1,2,3",
> -        "SampleAfterValue": "1000003",
> -        "UMask": "0x10"
> -    },
> -    {
> -        "BriefDescription": "This event is deprecated.",
> -        "CollectPEBSRecord": "2",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0x74",
> -        "EventName": "TOPDOWN_BE_BOUND.STORE_BUFFER",
> -        "PDIR_COUNTER": "na",
> -        "PEBScounters": "0,1,2,3",
> -        "SampleAfterValue": "1000003",
> -        "UMask": "0x4"
> -    },
> -    {
> -        "BriefDescription": "Counts the number of issue slots every cycle that were not consumed by the backend due to frontend stalls.",
> -        "CollectPEBSRecord": "2",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0x71",
> -        "EventName": "TOPDOWN_FE_BOUND.ALL",
> -        "PDIR_COUNTER": "na",
> -        "PEBScounters": "0,1,2,3",
> -        "SampleAfterValue": "1000003"
> -    },
> -    {
> -        "BriefDescription": "Counts the number of issue slots every cycle that were not delivered by the frontend due to BACLEARS.",
> -        "CollectPEBSRecord": "2",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0x71",
> -        "EventName": "TOPDOWN_FE_BOUND.BRANCH_DETECT",
> -        "PDIR_COUNTER": "na",
> -        "PEBScounters": "0,1,2,3",
> -        "PublicDescription": "Counts the number of issue slots every cycle that were not delivered by the frontend due to BACLEARS, which occurs when the Branch Target Buffer (BTB) prediction or lack thereof, was corrected by a later branch predictor in the frontend. Includes BACLEARS due to all branch types including conditional and unconditional jumps, returns, and indirect branches.",
> -        "SampleAfterValue": "1000003",
> -        "UMask": "0x2"
> -    },
> -    {
> -        "BriefDescription": "Counts the number of issue slots every cycle that were not delivered by the frontend due to BTCLEARS.",
> -        "CollectPEBSRecord": "2",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0x71",
> -        "EventName": "TOPDOWN_FE_BOUND.BRANCH_RESTEER",
> -        "PDIR_COUNTER": "na",
> -        "PEBScounters": "0,1,2,3",
> -        "PublicDescription": "Counts the number of issue slots every cycle that were not delivered by the frontend due to BTCLEARS, which occurs when the Branch Target Buffer (BTB) predicts a taken branch.",
> -        "SampleAfterValue": "1000003",
> -        "UMask": "0x40"
> -    },
> -    {
> -        "BriefDescription": "Counts the number of issue slots every cycle that were not delivered by the frontend due to the microcode sequencer (MS).",
> -        "CollectPEBSRecord": "2",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0x71",
> -        "EventName": "TOPDOWN_FE_BOUND.CISC",
> -        "PDIR_COUNTER": "na",
> -        "PEBScounters": "0,1,2,3",
> -        "SampleAfterValue": "1000003",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts the number of issue slots every cycle that were not delivered by the frontend due to decode stalls.",
> -        "CollectPEBSRecord": "2",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0x71",
> -        "EventName": "TOPDOWN_FE_BOUND.DECODE",
> -        "PDIR_COUNTER": "na",
> -        "PEBScounters": "0,1,2,3",
> -        "SampleAfterValue": "1000003",
> -        "UMask": "0x8"
> -    },
> -    {
> -        "BriefDescription": "Counts the number of issue slots every cycle that were not delivered by the frontend due to frontend bandwidth restrictions due to decode, predecode, cisc, and other limitations.",
> -        "CollectPEBSRecord": "2",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0x71",
> -        "EventName": "TOPDOWN_FE_BOUND.FRONTEND_BANDWIDTH",
> -        "PDIR_COUNTER": "na",
> -        "PEBScounters": "0,1,2,3",
> -        "SampleAfterValue": "1000003",
> -        "UMask": "0x8d"
> -    },
> -    {
> -        "BriefDescription": "Counts the number of issue slots every cycle that were not delivered by the frontend due to a latency related stalls including BACLEARs, BTCLEARs, ITLB misses, and ICache misses.",
> -        "CollectPEBSRecord": "2",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0x71",
> -        "EventName": "TOPDOWN_FE_BOUND.FRONTEND_LATENCY",
> -        "PDIR_COUNTER": "na",
> -        "PEBScounters": "0,1,2,3",
> -        "SampleAfterValue": "1000003",
> -        "UMask": "0x72"
> -    },
> -    {
> -        "BriefDescription": "Counts the number of issue slots every cycle that were not delivered by the frontend due to ITLB misses.",
> -        "CollectPEBSRecord": "2",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0x71",
> -        "EventName": "TOPDOWN_FE_BOUND.ITLB",
> -        "PDIR_COUNTER": "na",
> -        "PEBScounters": "0,1,2,3",
> -        "PublicDescription": "Counts the number of issue slots every cycle that were not delivered by the frontend due to Instruction Table Lookaside Buffer (ITLB) misses.",
> -        "SampleAfterValue": "1000003",
> -        "UMask": "0x10"
> -    },
> -    {
> -        "BriefDescription": "Counts the number of issue slots every cycle that were not delivered by the frontend due to other common frontend stalls not categorized.",
> -        "CollectPEBSRecord": "2",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0x71",
> -        "EventName": "TOPDOWN_FE_BOUND.OTHER",
> -        "PDIR_COUNTER": "na",
> -        "PEBScounters": "0,1,2,3",
> -        "SampleAfterValue": "1000003",
> -        "UMask": "0x80"
> -    },
> -    {
> -        "BriefDescription": "Counts the number of issue slots every cycle that were not delivered by the frontend due to wrong predecodes.",
> -        "CollectPEBSRecord": "2",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0x71",
> -        "EventName": "TOPDOWN_FE_BOUND.PREDECODE",
> -        "PDIR_COUNTER": "na",
> -        "PEBScounters": "0,1,2,3",
> -        "SampleAfterValue": "1000003",
> -        "UMask": "0x4"
> -    },
> -    {
> -        "BriefDescription": "Counts the total number of consumed retirement slots.",
> -        "CollectPEBSRecord": "2",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0xc2",
> -        "EventName": "TOPDOWN_RETIRING.ALL",
> -        "PEBS": "1",
> -        "PEBScounters": "0,1,2,3",
> -        "SampleAfterValue": "1000003"
>       }
>   ]
> \ No newline at end of file
> diff --git a/tools/perf/pmu-events/arch/x86/tremontx/pipeline.json b/tools/perf/pmu-events/arch/x86/tremontx/pipeline.json
> index 200255c62249..0a77e9f9a16a 100644
> --- a/tools/perf/pmu-events/arch/x86/tremontx/pipeline.json
> +++ b/tools/perf/pmu-events/arch/x86/tremontx/pipeline.json
> @@ -274,6 +274,17 @@
>           "SampleAfterValue": "1000003",
>           "UMask": "0x4"
>       },
> +    {
> +        "BriefDescription": "Counts the number of retired loads that are blocked for any of the following reasons:  DTLB miss, address alias, store forward or data unknown (includes memory disambiguation blocks and ESP consuming load blocks).",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x03",
> +        "EventName": "LD_BLOCKS.ALL",
> +        "PEBS": "1",
> +        "PEBScounters": "0,1,2,3",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x10"
> +    },
>       {
>           "BriefDescription": "Counts the number of retired loads that are blocked because its address exactly matches an older store whose data is not ready.",
>           "CollectPEBSRecord": "2",
> @@ -285,6 +296,17 @@
>           "SampleAfterValue": "1000003",
>           "UMask": "0x1"
>       },
> +    {
> +        "BriefDescription": "Counts the number of retired loads that are blocked because its address partially overlapped with an older store.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x03",
> +        "EventName": "LD_BLOCKS.STORE_FORWARD",
> +        "PEBS": "1",
> +        "PEBScounters": "0,1,2,3",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x2"
> +    },
>       {
>           "BriefDescription": "Counts the total number of machine clears for any reason including, but not limited to, memory ordering, memory disambiguation, SMC, and FP assist.",
>           "CollectPEBSRecord": "2",
> @@ -295,6 +317,17 @@
>           "PEBScounters": "0,1,2,3",
>           "SampleAfterValue": "20003"
>       },
> +    {
> +        "BriefDescription": "Counts the number of machine clears due to memory ordering in which an internal load passes an older store within the same CPU.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0xc3",
> +        "EventName": "MACHINE_CLEARS.DISAMBIGUATION",
> +        "PDIR_COUNTER": "na",
> +        "PEBScounters": "0,1,2,3",
> +        "SampleAfterValue": "20003",
> +        "UMask": "0x8"
> +    },
>       {
>           "BriefDescription": "Counts the number of machine clears due to a page fault.  Counts both I-Side and D-Side (Loads/Stores) page faults.  A page fault occurs when either the page is not present, or an access violation occurs.",
>           "CollectPEBSRecord": "2",
> @@ -317,6 +350,282 @@
>           "SampleAfterValue": "20003",
>           "UMask": "0x1"
>       },
> +    {
> +        "BriefDescription": "Counts the total number of issue slots that were not consumed by the backend because allocation is stalled due to a mispredicted jump or a machine clear.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x73",
> +        "EventName": "TOPDOWN_BAD_SPECULATION.ALL",
> +        "PDIR_COUNTER": "na",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts the total number of issue slots that were not consumed by the backend because allocation is stalled due to a mispredicted jump or a machine clear. Only issue slots wasted due to fast nukes such as memory ordering nukes are counted. Other nukes are not accounted for. Counts all issue slots blocked during this recovery window including relevant microcode flows and while uops are not yet available in the instruction queue (IQ) even if an FE_bound event occurs during this period. Also includes the issue slots that were consumed by the backend but were thrown away because they were younger than the mispredict or machine clear.",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x6"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of issue slots every cycle that were not consumed by the backend due to fast nukes such as memory ordering and memory disambiguation machine clears.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x73",
> +        "EventName": "TOPDOWN_BAD_SPECULATION.FASTNUKE",
> +        "PDIR_COUNTER": "na",
> +        "PEBScounters": "0,1,2,3",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x2"
> +    },
> +    {
> +        "BriefDescription": "Counts the total number of issue slots that were not consumed by the backend because allocation is stalled due to a machine clear (nuke) of any kind including memory ordering and memory disambiguation.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x73",
> +        "EventName": "TOPDOWN_BAD_SPECULATION.MACHINE_CLEARS",
> +        "PDIR_COUNTER": "na",
> +        "PEBScounters": "0,1,2,3",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x2"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of issue slots every cycle that were not consumed by the backend due to branch mispredicts.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x73",
> +        "EventName": "TOPDOWN_BAD_SPECULATION.MISPREDICT",
> +        "PDIR_COUNTER": "na",
> +        "PEBScounters": "0,1,2,3",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x4"
> +    },
> +    {
> +        "BriefDescription": "This event is deprecated. Refer to new event TOPDOWN_BAD_SPECULATION.FASTNUKE",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x73",
> +        "EventName": "TOPDOWN_BAD_SPECULATION.MONUKE",
> +        "PDIR_COUNTER": "na",
> +        "PEBScounters": "0,1,2,3",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x2"
> +    },
> +    {
> +        "BriefDescription": "Counts the total number of issue slots every cycle that were not consumed by the backend due to backend stalls.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x74",
> +        "EventName": "TOPDOWN_BE_BOUND.ALL",
> +        "PDIR_COUNTER": "na",
> +        "PEBScounters": "0,1,2,3",
> +        "SampleAfterValue": "1000003"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of issue slots every cycle that were not consumed by the backend due to certain allocation restrictions.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x74",
> +        "EventName": "TOPDOWN_BE_BOUND.ALLOC_RESTRICTIONS",
> +        "PDIR_COUNTER": "na",
> +        "PEBScounters": "0,1,2,3",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of issue slots every cycle that were not consumed by the backend due to memory reservation stalls in which a scheduler is not able to accept uops.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x74",
> +        "EventName": "TOPDOWN_BE_BOUND.MEM_SCHEDULER",
> +        "PDIR_COUNTER": "na",
> +        "PEBScounters": "0,1,2,3",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x2"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of issue slots every cycle that were not consumed by the backend due to IEC or FPC RAT stalls, which can be due to FIQ or IEC reservation stalls in which the integer, floating point or SIMD scheduler is not able to accept uops.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x74",
> +        "EventName": "TOPDOWN_BE_BOUND.NON_MEM_SCHEDULER",
> +        "PDIR_COUNTER": "na",
> +        "PEBScounters": "0,1,2,3",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x8"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of issue slots every cycle that were not consumed by the backend due to the physical register file unable to accept an entry (marble stalls).",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x74",
> +        "EventName": "TOPDOWN_BE_BOUND.REGISTER",
> +        "PDIR_COUNTER": "na",
> +        "PEBScounters": "0,1,2,3",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x20"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of issue slots every cycle that were not consumed by the backend due to the reorder buffer being full (ROB stalls).",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x74",
> +        "EventName": "TOPDOWN_BE_BOUND.REORDER_BUFFER",
> +        "PDIR_COUNTER": "na",
> +        "PEBScounters": "0,1,2,3",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x40"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of issue slots every cycle that were not consumed by the backend due to scoreboards from the instruction queue (IQ), jump execution unit (JEU), or microcode sequencer (MS).",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x74",
> +        "EventName": "TOPDOWN_BE_BOUND.SERIALIZATION",
> +        "PDIR_COUNTER": "na",
> +        "PEBScounters": "0,1,2,3",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x10"
> +    },
> +    {
> +        "BriefDescription": "This event is deprecated.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x74",
> +        "EventName": "TOPDOWN_BE_BOUND.STORE_BUFFER",
> +        "PDIR_COUNTER": "na",
> +        "PEBScounters": "0,1,2,3",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x4"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of issue slots every cycle that were not consumed by the backend due to frontend stalls.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x71",
> +        "EventName": "TOPDOWN_FE_BOUND.ALL",
> +        "PDIR_COUNTER": "na",
> +        "PEBScounters": "0,1,2,3",
> +        "SampleAfterValue": "1000003"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of issue slots every cycle that were not delivered by the frontend due to BACLEARS.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x71",
> +        "EventName": "TOPDOWN_FE_BOUND.BRANCH_DETECT",
> +        "PDIR_COUNTER": "na",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts the number of issue slots every cycle that were not delivered by the frontend due to BACLEARS, which occurs when the Branch Target Buffer (BTB) prediction or lack thereof, was corrected by a later branch predictor in the frontend. Includes BACLEARS due to all branch types including conditional and unconditional jumps, returns, and indirect branches.",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x2"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of issue slots every cycle that were not delivered by the frontend due to BTCLEARS.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x71",
> +        "EventName": "TOPDOWN_FE_BOUND.BRANCH_RESTEER",
> +        "PDIR_COUNTER": "na",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts the number of issue slots every cycle that were not delivered by the frontend due to BTCLEARS, which occurs when the Branch Target Buffer (BTB) predicts a taken branch.",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x40"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of issue slots every cycle that were not delivered by the frontend due to the microcode sequencer (MS).",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x71",
> +        "EventName": "TOPDOWN_FE_BOUND.CISC",
> +        "PDIR_COUNTER": "na",
> +        "PEBScounters": "0,1,2,3",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of issue slots every cycle that were not delivered by the frontend due to decode stalls.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x71",
> +        "EventName": "TOPDOWN_FE_BOUND.DECODE",
> +        "PDIR_COUNTER": "na",
> +        "PEBScounters": "0,1,2,3",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x8"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of issue slots every cycle that were not delivered by the frontend due to frontend bandwidth restrictions due to decode, predecode, cisc, and other limitations.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x71",
> +        "EventName": "TOPDOWN_FE_BOUND.FRONTEND_BANDWIDTH",
> +        "PDIR_COUNTER": "na",
> +        "PEBScounters": "0,1,2,3",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x8d"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of issue slots every cycle that were not delivered by the frontend due to a latency related stalls including BACLEARs, BTCLEARs, ITLB misses, and ICache misses.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x71",
> +        "EventName": "TOPDOWN_FE_BOUND.FRONTEND_LATENCY",
> +        "PDIR_COUNTER": "na",
> +        "PEBScounters": "0,1,2,3",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x72"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of issue slots every cycle that were not delivered by the frontend due to ITLB misses.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x71",
> +        "EventName": "TOPDOWN_FE_BOUND.ITLB",
> +        "PDIR_COUNTER": "na",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts the number of issue slots every cycle that were not delivered by the frontend due to Instruction Table Lookaside Buffer (ITLB) misses.",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x10"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of issue slots every cycle that were not delivered by the frontend due to other common frontend stalls not categorized.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x71",
> +        "EventName": "TOPDOWN_FE_BOUND.OTHER",
> +        "PDIR_COUNTER": "na",
> +        "PEBScounters": "0,1,2,3",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x80"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of issue slots every cycle that were not delivered by the frontend due to wrong predecodes.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x71",
> +        "EventName": "TOPDOWN_FE_BOUND.PREDECODE",
> +        "PDIR_COUNTER": "na",
> +        "PEBScounters": "0,1,2,3",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x4"
> +    },
> +    {
> +        "BriefDescription": "Counts the total number of consumed retirement slots.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0xc2",
> +        "EventName": "TOPDOWN_RETIRING.ALL",
> +        "PEBS": "1",
> +        "PEBScounters": "0,1,2,3",
> +        "SampleAfterValue": "1000003"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of uops issued by the front end every cycle.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x0e",
> +        "EventName": "UOPS_ISSUED.ANY",
> +        "PDIR_COUNTER": "na",
> +        "PEBScounters": "0,1,2,3",
> +        "PublicDescription": "Counts the number of uops issued by the front end every cycle. When 4-uops are requested and only 2-uops are delivered, the event counts 2.  Uops_issued correlates to the number of ROB entries.  If uop takes 2 ROB slots it counts as 2 uops_issued.",
> +        "SampleAfterValue": "200003"
> +    },
>       {
>           "BriefDescription": "Counts the total number of uops retired.",
>           "CollectPEBSRecord": "2",
> @@ -350,5 +659,16 @@
>           "PublicDescription": "Counts the number of uops that are from complex flows issued by the Microcode Sequencer (MS). This includes uops from flows due to complex instructions, faults, assists, and inserted flows.",
>           "SampleAfterValue": "2000003",
>           "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of x87 uops retired, includes those in MS flows.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0xc2",
> +        "EventName": "UOPS_RETIRED.X87",
> +        "PEBS": "1",
> +        "PEBScounters": "0,1,2,3",
> +        "SampleAfterValue": "2000003",
> +        "UMask": "0x2"
>       }
>   ]
> \ No newline at end of file
> diff --git a/tools/perf/pmu-events/arch/x86/tremontx/uncore-other.json b/tools/perf/pmu-events/arch/x86/tremontx/uncore-other.json
> index 4e1a1c6faa63..0f73582248f9 100644
> --- a/tools/perf/pmu-events/arch/x86/tremontx/uncore-other.json
> +++ b/tools/perf/pmu-events/arch/x86/tremontx/uncore-other.json
> @@ -945,6 +945,7 @@
>           "CounterType": "FREERUN",
>           "EventName": "UNC_IIO_CLOCKTICKS_FREERUN",
>           "PerPkg": "1",
> +        "PublicDescription": "Free running counter that increments for integrated IO (IIO) traffic controller clockticks",
>           "Unit": "IIO"
>       },
>       {
> diff --git a/tools/perf/pmu-events/arch/x86/tremontx/virtual-memory.json b/tools/perf/pmu-events/arch/x86/tremontx/virtual-memory.json
> index cb0784562bd1..ecbfc335a9b6 100644
> --- a/tools/perf/pmu-events/arch/x86/tremontx/virtual-memory.json
> +++ b/tools/perf/pmu-events/arch/x86/tremontx/virtual-memory.json
> @@ -315,6 +315,17 @@
>           "SampleAfterValue": "200003",
>           "UMask": "0x10"
>       },
> +    {
> +        "BriefDescription": "Counts the number of retired loads that are blocked due to a first level TLB miss.",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x03",
> +        "EventName": "LD_BLOCKS.DTLB_MISS",
> +        "PEBS": "1",
> +        "PEBScounters": "0,1,2,3",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x8"
> +    },
>       {
>           "BriefDescription": "Counts the number of memory retired ops that missed in the second level TLB.",
>           "CollectPEBSRecord": "2",

-- 
Zhengjun Xing
