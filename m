Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BFB64DD6FB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 10:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234370AbiCRJUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 05:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234357AbiCRJUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 05:20:31 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEDA249CAA;
        Fri, 18 Mar 2022 02:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647595147; x=1679131147;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=f/Nxe2HpKj5azRQ4n5T71hqEGv6rZ+lgCpnIFJCkQwc=;
  b=Y0Cs/VFk17lNXEazRqUjxwzf2OW9M73WxAHU2nwkLKkIQhNdF1l9lWdk
   LCSbgOyyOUkkJi1ej1ho4l7GDuDD+nYf0a6dRIJcboG8+Bi/Czrh5xZtL
   VMeq58Vg1uteUnb8HeQnZP3uuwAqpBdzE3JhJQ8l2g0oT7OT97bm57ZL5
   OvBfRI1V3WAZPCpvR29UFN62AhwVo27YS5gZBor2sTxaaqhlL2b0CWhPg
   vQrQKDgWgYbwLoWOuHtRZjx9hMjRx5hheTHvdH1NfaAtyzxJ7W40ERsXt
   GmKtZUCVsNlgQk7YN8ppe+f02BWtQ347NB6WDYaXCEDmM14HnKs6zM/71
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="256826722"
X-IronPort-AV: E=Sophos;i="5.90,191,1643702400"; 
   d="scan'208";a="256826722"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 02:19:07 -0700
X-IronPort-AV: E=Sophos;i="5.90,191,1643702400"; 
   d="scan'208";a="558338927"
Received: from xingzhen-mobl.ccr.corp.intel.com (HELO [10.255.31.171]) ([10.255.31.171])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 02:19:02 -0700
Message-ID: <668591f8-68c0-943a-be3c-02c6bc5b5800@linux.intel.com>
Date:   Fri, 18 Mar 2022 17:19:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 4/8] perf vendor events: Update events for IcelakeX
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
 <20220317182858.484474-4-irogers@google.com>
From:   Xing Zhengjun <zhengjun.xing@linux.intel.com>
In-Reply-To: <20220317182858.484474-4-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/18/2022 2:28 AM, Ian Rogers wrote:
> Move from v1.11 to v1.12.
> The change:
> https://github.com/intel/event-converter-for-linux-perf/commit/fc680410402e394eed6a1ebd909c9f649d3ed3ef
> moved certain "other" type of events in to the cache, memory and
> pipeline topics. Update the perf json files for this change.
> 
> Tested:
> ```
> ...
>    6: Parse event definition strings                                  : Ok
> ...
>   91: perf all PMU test                                               : Ok
> ...
> ```
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

Reviewed-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>

> ---
>   .../pmu-events/arch/x86/icelakex/cache.json   | 252 +++++++++++++++
>   .../pmu-events/arch/x86/icelakex/memory.json  |  26 +-
>   .../pmu-events/arch/x86/icelakex/other.json   | 287 ++----------------
>   .../arch/x86/icelakex/pipeline.json           |  35 +++
>   4 files changed, 324 insertions(+), 276 deletions(-)
> 
> diff --git a/tools/perf/pmu-events/arch/x86/icelakex/cache.json b/tools/perf/pmu-events/arch/x86/icelakex/cache.json
> index 104409fd8647..3c4da0371df9 100644
> --- a/tools/perf/pmu-events/arch/x86/icelakex/cache.json
> +++ b/tools/perf/pmu-events/arch/x86/icelakex/cache.json
> @@ -657,6 +657,30 @@
>           "SampleAfterValue": "100003",
>           "UMask": "0x80"
>       },
> +    {
> +        "BriefDescription": "Counts demand instruction fetches and L1 instruction cache prefetches that hit in the L3 or were snooped from another core's caches on the same socket.",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0xB7, 0xBB",
> +        "EventName": "OCR.DEMAND_CODE_RD.L3_HIT",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x3F803C0004",
> +        "Offcore": "1",
> +        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts demand instruction fetches and L1 instruction cache prefetches that resulted in a snoop hit a modified line in another core's caches which forwarded the data.",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0xB7, 0xBB",
> +        "EventName": "OCR.DEMAND_CODE_RD.L3_HIT.SNOOP_HITM",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x10003C0004",
> +        "Offcore": "1",
> +        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    },
>       {
>           "BriefDescription": "Counts demand instruction fetches and L1 instruction cache prefetches that hit a modified line in a distant L3 Cache or were snooped from a distant core's L1/L2 caches on this socket when the system is in SNC (sub-NUMA cluster) mode.",
>           "Counter": "0,1,2,3",
> @@ -681,6 +705,54 @@
>           "SampleAfterValue": "100003",
>           "UMask": "0x1"
>       },
> +    {
> +        "BriefDescription": "Counts demand data reads that hit in the L3 or were snooped from another core's caches on the same socket.",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0xB7, 0xBB",
> +        "EventName": "OCR.DEMAND_DATA_RD.L3_HIT",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x3F803C0001",
> +        "Offcore": "1",
> +        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts demand data reads that resulted in a snoop hit a modified line in another core's caches which forwarded the data.",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0xB7, 0xBB",
> +        "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x10003C0001",
> +        "Offcore": "1",
> +        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts demand data reads that resulted in a snoop that hit in another core, which did not forward the data.",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0xB7, 0xBB",
> +        "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_NO_FWD",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x4003C0001",
> +        "Offcore": "1",
> +        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts demand data reads that resulted in a snoop hit in another core's caches which forwarded the unmodified data to the requesting core.",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0xB7, 0xBB",
> +        "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_WITH_FWD",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x8003C0001",
> +        "Offcore": "1",
> +        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    },
>       {
>           "BriefDescription": "Counts demand data reads that were supplied by a cache on a remote socket where a snoop hit a modified line in another core's caches which forwarded the data.",
>           "Counter": "0,1,2,3",
> @@ -729,6 +801,30 @@
>           "SampleAfterValue": "100003",
>           "UMask": "0x1"
>       },
> +    {
> +        "BriefDescription": "Counts demand reads for ownership (RFO) requests and software prefetches for exclusive ownership (PREFETCHW) that hit in the L3 or were snooped from another core's caches on the same socket.",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0xB7, 0xBB",
> +        "EventName": "OCR.DEMAND_RFO.L3_HIT",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x3F803C0002",
> +        "Offcore": "1",
> +        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts demand reads for ownership (RFO) requests and software prefetches for exclusive ownership (PREFETCHW) that resulted in a snoop hit a modified line in another core's caches which forwarded the data.",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0xB7, 0xBB",
> +        "EventName": "OCR.DEMAND_RFO.L3_HIT.SNOOP_HITM",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x10003C0002",
> +        "Offcore": "1",
> +        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    },
>       {
>           "BriefDescription": "Counts demand reads for ownership (RFO) requests and software prefetches for exclusive ownership (PREFETCHW) that hit a modified line in a distant L3 Cache or were snooped from a distant core's L1/L2 caches on this socket when the system is in SNC (sub-NUMA cluster) mode.",
>           "Counter": "0,1,2,3",
> @@ -753,6 +849,102 @@
>           "SampleAfterValue": "100003",
>           "UMask": "0x1"
>       },
> +    {
> +        "BriefDescription": "Counts L1 data cache prefetch requests and software prefetches (except PREFETCHW) that hit in the L3 or were snooped from another core's caches on the same socket.",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0xB7, 0xBB",
> +        "EventName": "OCR.HWPF_L1D_AND_SWPF.L3_HIT",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x3F803C0400",
> +        "Offcore": "1",
> +        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts hardware prefetches to the L3 only that hit in the L3 or were snooped from another core's caches on the same socket.",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0xB7, 0xBB",
> +        "EventName": "OCR.HWPF_L3.L3_HIT",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x80082380",
> +        "Offcore": "1",
> +        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts hardware and software prefetches to all cache levels that hit in the L3 or were snooped from another core's caches on the same socket.",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0xB7, 0xBB",
> +        "EventName": "OCR.PREFETCHES.L3_HIT",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x3F803C27F0",
> +        "Offcore": "1",
> +        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts all data read, code read and RFO requests including demands and prefetches to the core caches (L1 or L2) that hit in the L3 or were snooped from another core's caches on the same socket.",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0xB7, 0xBB",
> +        "EventName": "OCR.READS_TO_CORE.L3_HIT",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x3F003C0477",
> +        "Offcore": "1",
> +        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts all data read, code read and RFO requests including demands and prefetches to the core caches (L1 or L2) that resulted in a snoop hit a modified line in another core's caches which forwarded the data.",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0xB7, 0xBB",
> +        "EventName": "OCR.READS_TO_CORE.L3_HIT.SNOOP_HITM",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x10003C0477",
> +        "Offcore": "1",
> +        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts all data read, code read and RFO requests including demands and prefetches to the core caches (L1 or L2) that resulted in a snoop that hit in another core, which did not forward the data.",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0xB7, 0xBB",
> +        "EventName": "OCR.READS_TO_CORE.L3_HIT.SNOOP_HIT_NO_FWD",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x4003C0477",
> +        "Offcore": "1",
> +        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts all data read, code read and RFO requests including demands and prefetches to the core caches (L1 or L2) that resulted in a snoop hit in another core's caches which forwarded the unmodified data to the requesting core.",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0xB7, 0xBB",
> +        "EventName": "OCR.READS_TO_CORE.L3_HIT.SNOOP_HIT_WITH_FWD",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x8003C0477",
> +        "Offcore": "1",
> +        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts all data read, code read and RFO requests including demands and prefetches to the core caches (L1 or L2) that were supplied by a cache on a remote socket where a snoop was sent and data was returned (Modified or Not Modified).",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0xB7, 0xBB",
> +        "EventName": "OCR.READS_TO_CORE.REMOTE_CACHE.SNOOP_FWD",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x1830000477",
> +        "Offcore": "1",
> +        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    },
>       {
>           "BriefDescription": "Counts all data read, code read and RFO requests including demands and prefetches to the core caches (L1 or L2) that were supplied by a cache on a remote socket where a snoop hit a modified line in another core's caches which forwarded the data.",
>           "Counter": "0,1,2,3",
> @@ -801,6 +993,18 @@
>           "SampleAfterValue": "100003",
>           "UMask": "0x1"
>       },
> +    {
> +        "BriefDescription": "Counts streaming stores that hit in the L3 or were snooped from another core's caches on the same socket.",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0xB7, 0xBB",
> +        "EventName": "OCR.STREAMING_WR.L3_HIT",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x80080800",
> +        "Offcore": "1",
> +        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    },
>       {
>           "BriefDescription": "Demand and prefetch data reads",
>           "CollectPEBSRecord": "2",
> @@ -947,5 +1151,53 @@
>           "SampleAfterValue": "100003",
>           "Speculative": "1",
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
> +        "Speculative": "1",
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
> +        "Speculative": "1",
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
> +        "Speculative": "1",
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
> +        "Speculative": "1",
> +        "UMask": "0x4"
>       }
>   ]
> \ No newline at end of file
> diff --git a/tools/perf/pmu-events/arch/x86/icelakex/memory.json b/tools/perf/pmu-events/arch/x86/icelakex/memory.json
> index 9ebcd442e6d3..c10a1bbc66b1 100644
> --- a/tools/perf/pmu-events/arch/x86/icelakex/memory.json
> +++ b/tools/perf/pmu-events/arch/x86/icelakex/memory.json
> @@ -169,7 +169,7 @@
>           "EventCode": "0xB7, 0xBB",
>           "EventName": "OCR.DEMAND_CODE_RD.L3_MISS_LOCAL",
>           "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x3F8CC00004",
> +        "MSRValue": "0x3F84400004",
>           "Offcore": "1",
>           "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
>           "SampleAfterValue": "100003",
> @@ -193,7 +193,7 @@
>           "EventCode": "0xB7, 0xBB",
>           "EventName": "OCR.DEMAND_DATA_RD.L3_MISS_LOCAL",
>           "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x3F8CC00001",
> +        "MSRValue": "0x3F84400001",
>           "Offcore": "1",
>           "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
>           "SampleAfterValue": "100003",
> @@ -217,7 +217,7 @@
>           "EventCode": "0xB7, 0xBB",
>           "EventName": "OCR.DEMAND_RFO.L3_MISS_LOCAL",
>           "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x3F0CC00002",
> +        "MSRValue": "0x3F04400002",
>           "Offcore": "1",
>           "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
>           "SampleAfterValue": "100003",
> @@ -241,7 +241,7 @@
>           "EventCode": "0xB7, 0xBB",
>           "EventName": "OCR.HWPF_L1D_AND_SWPF.L3_MISS_LOCAL",
>           "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x3F8CC00400",
> +        "MSRValue": "0x3F84400400",
>           "Offcore": "1",
>           "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
>           "SampleAfterValue": "100003",
> @@ -301,7 +301,7 @@
>           "EventCode": "0xB7, 0xBB",
>           "EventName": "OCR.OTHER.L3_MISS_LOCAL",
>           "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x3F8CC08000",
> +        "MSRValue": "0x3F84408000",
>           "Offcore": "1",
>           "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
>           "SampleAfterValue": "100003",
> @@ -313,7 +313,7 @@
>           "EventCode": "0xB7, 0xBB",
>           "EventName": "OCR.PREFETCHES.L3_MISS_LOCAL",
>           "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x3F8CC027F0",
> +        "MSRValue": "0x3F844027F0",
>           "Offcore": "1",
>           "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
>           "SampleAfterValue": "100003",
> @@ -337,7 +337,19 @@
>           "EventCode": "0xB7, 0xBB",
>           "EventName": "OCR.READS_TO_CORE.L3_MISS_LOCAL",
>           "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x3F0CC00477",
> +        "MSRValue": "0x3F04400477",
> +        "Offcore": "1",
> +        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Counts all data read, code read and RFO requests including demands and prefetches to the core caches (L1 or L2) that missed the L3 Cache and were supplied by the local socket (DRAM or PMM), whether or not in Sub NUMA Cluster(SNC) Mode.  In SNC Mode counts PMM or DRAM accesses that are controlled by the close or distant SNC Cluster.",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0xB7, 0xBB",
> +        "EventName": "OCR.READS_TO_CORE.L3_MISS_LOCAL_SOCKET",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x70CC00477",
>           "Offcore": "1",
>           "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
>           "SampleAfterValue": "100003",
> diff --git a/tools/perf/pmu-events/arch/x86/icelakex/other.json b/tools/perf/pmu-events/arch/x86/icelakex/other.json
> index 43524f274307..1246b22769da 100644
> --- a/tools/perf/pmu-events/arch/x86/icelakex/other.json
> +++ b/tools/perf/pmu-events/arch/x86/icelakex/other.json
> @@ -156,31 +156,7 @@
>           "UMask": "0x1"
>       },
>       {
> -        "BriefDescription": "Counts demand instruction fetches and L1 instruction cache prefetches that hit in the L3 or were snooped from another core's caches on the same socket.",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0xB7, 0xBB",
> -        "EventName": "OCR.DEMAND_CODE_RD.L3_HIT",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x3F803C0004",
> -        "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts demand instruction fetches and L1 instruction cache prefetches that resulted in a snoop hit a modified line in another core's caches which forwarded the data.",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0xB7, 0xBB",
> -        "EventName": "OCR.DEMAND_CODE_RD.L3_HIT.SNOOP_HITM",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x10003C0004",
> -        "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts demand instruction fetches and L1 instruction cache prefetches that the DRAM attached to this socket supplied the request.",
> +        "BriefDescription": "Counts demand instruction fetches and L1 instruction cache prefetches that were supplied by DRAM attached to this socket, unless in Sub NUMA Cluster(SNC) Mode.  In SNC Mode counts only those DRAM accesses that are controlled by the close SNC Cluster.",
>           "Counter": "0,1,2,3",
>           "EventCode": "0xB7, 0xBB",
>           "EventName": "OCR.DEMAND_CODE_RD.LOCAL_DRAM",
> @@ -228,55 +204,7 @@
>           "UMask": "0x1"
>       },
>       {
> -        "BriefDescription": "Counts demand data reads that hit in the L3 or were snooped from another core's caches on the same socket.",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0xB7, 0xBB",
> -        "EventName": "OCR.DEMAND_DATA_RD.L3_HIT",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x3F803C0001",
> -        "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts demand data reads that resulted in a snoop hit a modified line in another core's caches which forwarded the data.",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0xB7, 0xBB",
> -        "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x10003C0001",
> -        "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts demand data reads that resulted in a snoop that hit in another core, which did not forward the data.",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0xB7, 0xBB",
> -        "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_NO_FWD",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x4003C0001",
> -        "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts demand data reads that resulted in a snoop hit in another core's caches which forwarded the unmodified data to the requesting core.",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0xB7, 0xBB",
> -        "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_WITH_FWD",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x8003C0001",
> -        "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts demand data reads that the DRAM attached to this socket supplied the request.",
> +        "BriefDescription": "Counts demand data reads that were supplied by DRAM attached to this socket, unless in Sub NUMA Cluster(SNC) Mode.  In SNC Mode counts only those DRAM accesses that are controlled by the close SNC Cluster.",
>           "Counter": "0,1,2,3",
>           "EventCode": "0xB7, 0xBB",
>           "EventName": "OCR.DEMAND_DATA_RD.LOCAL_DRAM",
> @@ -288,7 +216,7 @@
>           "UMask": "0x1"
>       },
>       {
> -        "BriefDescription": "Counts demand data reads that were supplied by PMM attached to this socket.",
> +        "BriefDescription": "Counts demand data reads that were supplied by PMM attached to this socket, unless in Sub NUMA Cluster(SNC) Mode.  In SNC Mode counts only those PMM accesses that are controlled by the close SNC Cluster.",
>           "Counter": "0,1,2,3",
>           "EventCode": "0xB7, 0xBB",
>           "EventName": "OCR.DEMAND_DATA_RD.LOCAL_PMM",
> @@ -384,31 +312,7 @@
>           "UMask": "0x1"
>       },
>       {
> -        "BriefDescription": "Counts demand reads for ownership (RFO) requests and software prefetches for exclusive ownership (PREFETCHW) that hit in the L3 or were snooped from another core's caches on the same socket.",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0xB7, 0xBB",
> -        "EventName": "OCR.DEMAND_RFO.L3_HIT",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x3F803C0002",
> -        "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts demand reads for ownership (RFO) requests and software prefetches for exclusive ownership (PREFETCHW) that resulted in a snoop hit a modified line in another core's caches which forwarded the data.",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0xB7, 0xBB",
> -        "EventName": "OCR.DEMAND_RFO.L3_HIT.SNOOP_HITM",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x10003C0002",
> -        "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts demand reads for ownership (RFO) requests and software prefetches for exclusive ownership (PREFETCHW) that the DRAM attached to this socket supplied the request.",
> +        "BriefDescription": "Counts demand reads for ownership (RFO) requests and software prefetches for exclusive ownership (PREFETCHW) that were supplied by DRAM attached to this socket, unless in Sub NUMA Cluster(SNC) Mode.  In SNC Mode counts only those DRAM accesses that are controlled by the close SNC Cluster.",
>           "Counter": "0,1,2,3",
>           "EventCode": "0xB7, 0xBB",
>           "EventName": "OCR.DEMAND_RFO.LOCAL_DRAM",
> @@ -420,7 +324,7 @@
>           "UMask": "0x1"
>       },
>       {
> -        "BriefDescription": "Counts demand reads for ownership (RFO) requests and software prefetches for exclusive ownership (PREFETCHW) that were supplied by PMM attached to this socket.",
> +        "BriefDescription": "Counts demand reads for ownership (RFO) requests and software prefetches for exclusive ownership (PREFETCHW) that were supplied by PMM attached to this socket, unless in Sub NUMA Cluster(SNC) Mode.  In SNC Mode counts only those PMM accesses that are controlled by the close SNC Cluster.",
>           "Counter": "0,1,2,3",
>           "EventCode": "0xB7, 0xBB",
>           "EventName": "OCR.DEMAND_RFO.LOCAL_PMM",
> @@ -492,19 +396,7 @@
>           "UMask": "0x1"
>       },
>       {
> -        "BriefDescription": "Counts L1 data cache prefetch requests and software prefetches (except PREFETCHW) that hit in the L3 or were snooped from another core's caches on the same socket.",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0xB7, 0xBB",
> -        "EventName": "OCR.HWPF_L1D_AND_SWPF.L3_HIT",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x3F803C0400",
> -        "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts L1 data cache prefetch requests and software prefetches (except PREFETCHW) that the DRAM attached to this socket supplied the request.",
> +        "BriefDescription": "Counts L1 data cache prefetch requests and software prefetches (except PREFETCHW) that were supplied by DRAM attached to this socket, unless in Sub NUMA Cluster(SNC) Mode.  In SNC Mode counts only those DRAM accesses that are controlled by the close SNC Cluster.",
>           "Counter": "0,1,2,3",
>           "EventCode": "0xB7, 0xBB",
>           "EventName": "OCR.HWPF_L1D_AND_SWPF.LOCAL_DRAM",
> @@ -527,18 +419,6 @@
>           "SampleAfterValue": "100003",
>           "UMask": "0x1"
>       },
> -    {
> -        "BriefDescription": "Counts hardware prefetches to the L3 only that hit in the L3 or were snooped from another core's caches on the same socket.",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0xB7, 0xBB",
> -        "EventName": "OCR.HWPF_L3.L3_HIT",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x80082380",
> -        "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "UMask": "0x1"
> -    },
>       {
>           "BriefDescription": "Counts hardware prefetches to the L3 only that were not supplied by the local socket's L1, L2, or L3 caches and the cacheline was homed in a remote socket.",
>           "Counter": "0,1,2,3",
> @@ -575,18 +455,6 @@
>           "SampleAfterValue": "100003",
>           "UMask": "0x1"
>       },
> -    {
> -        "BriefDescription": "Counts hardware and software prefetches to all cache levels that hit in the L3 or were snooped from another core's caches on the same socket.",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0xB7, 0xBB",
> -        "EventName": "OCR.PREFETCHES.L3_HIT",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x3F803C27F0",
> -        "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "UMask": "0x1"
> -    },
>       {
>           "BriefDescription": "Counts all data read, code read and RFO requests including demands and prefetches to the core caches (L1 or L2) that have any type of response.",
>           "Counter": "0,1,2,3",
> @@ -612,72 +480,48 @@
>           "UMask": "0x1"
>       },
>       {
> -        "BriefDescription": "Counts all data read, code read and RFO requests including demands and prefetches to the core caches (L1 or L2) that hit in the L3 or were snooped from another core's caches on the same socket.",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0xB7, 0xBB",
> -        "EventName": "OCR.READS_TO_CORE.L3_HIT",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x3F003C0477",
> -        "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts all data read, code read and RFO requests including demands and prefetches to the core caches (L1 or L2) that resulted in a snoop hit a modified line in another core's caches which forwarded the data.",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0xB7, 0xBB",
> -        "EventName": "OCR.READS_TO_CORE.L3_HIT.SNOOP_HITM",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x10003C0477",
> -        "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts all data read, code read and RFO requests including demands and prefetches to the core caches (L1 or L2) that resulted in a snoop that hit in another core, which did not forward the data.",
> +        "BriefDescription": "Counts all data read, code read and RFO requests including demands and prefetches to the core caches (L1 or L2) that were supplied by DRAM attached to this socket, unless in Sub NUMA Cluster(SNC) Mode.  In SNC Mode counts only those DRAM accesses that are controlled by the close SNC Cluster.",
>           "Counter": "0,1,2,3",
>           "EventCode": "0xB7, 0xBB",
> -        "EventName": "OCR.READS_TO_CORE.L3_HIT.SNOOP_HIT_NO_FWD",
> +        "EventName": "OCR.READS_TO_CORE.LOCAL_DRAM",
>           "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x4003C0477",
> +        "MSRValue": "0x104000477",
>           "Offcore": "1",
>           "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
>           "SampleAfterValue": "100003",
>           "UMask": "0x1"
>       },
>       {
> -        "BriefDescription": "Counts all data read, code read and RFO requests including demands and prefetches to the core caches (L1 or L2) that resulted in a snoop hit in another core's caches which forwarded the unmodified data to the requesting core.",
> +        "BriefDescription": "Counts all data read, code read and RFO requests including demands and prefetches to the core caches (L1 or L2) that were supplied by PMM attached to this socket, unless in Sub NUMA Cluster(SNC) Mode.  In SNC Mode counts only those PMM accesses that are controlled by the close SNC Cluster.",
>           "Counter": "0,1,2,3",
>           "EventCode": "0xB7, 0xBB",
> -        "EventName": "OCR.READS_TO_CORE.L3_HIT.SNOOP_HIT_WITH_FWD",
> +        "EventName": "OCR.READS_TO_CORE.LOCAL_PMM",
>           "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x8003C0477",
> +        "MSRValue": "0x100400477",
>           "Offcore": "1",
>           "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
>           "SampleAfterValue": "100003",
>           "UMask": "0x1"
>       },
>       {
> -        "BriefDescription": "Counts all data read, code read and RFO requests including demands and prefetches to the core caches (L1 or L2) that the DRAM attached to this socket supplied the request.",
> +        "BriefDescription": "Counts all data read, code read and RFO requests including demands and prefetches to the core caches (L1 or L2) that were supplied by DRAM attached to this socket, whether or not in Sub NUMA Cluster(SNC) Mode.  In SNC Mode counts DRAM accesses that are controlled by the close or distant SNC Cluster.",
>           "Counter": "0,1,2,3",
>           "EventCode": "0xB7, 0xBB",
> -        "EventName": "OCR.READS_TO_CORE.LOCAL_DRAM",
> +        "EventName": "OCR.READS_TO_CORE.LOCAL_SOCKET_DRAM",
>           "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x104000477",
> +        "MSRValue": "0x70C000477",
>           "Offcore": "1",
>           "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
>           "SampleAfterValue": "100003",
>           "UMask": "0x1"
>       },
>       {
> -        "BriefDescription": "Counts all data read, code read and RFO requests including demands and prefetches to the core caches (L1 or L2) that were supplied by PMM attached to this socket.",
> +        "BriefDescription": "Counts all data read, code read and RFO requests including demands and prefetches to the core caches (L1 or L2) that were supplied by PMM attached to this socket, whether or not in Sub NUMA Cluster(SNC) Mode.  In SNC Mode counts PMM accesses that are controlled by the close or distant SNC Cluster.",
>           "Counter": "0,1,2,3",
>           "EventCode": "0xB7, 0xBB",
> -        "EventName": "OCR.READS_TO_CORE.LOCAL_PMM",
> +        "EventName": "OCR.READS_TO_CORE.LOCAL_SOCKET_PMM",
>           "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x100400477",
> +        "MSRValue": "0x700C00477",
>           "Offcore": "1",
>           "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
>           "SampleAfterValue": "100003",
> @@ -754,100 +598,5 @@
>           "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
>           "SampleAfterValue": "100003",
>           "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Counts streaming stores that hit in the L3 or were snooped from another core's caches on the same socket.",
> -        "Counter": "0,1,2,3",
> -        "EventCode": "0xB7, 0xBB",
> -        "EventName": "OCR.STREAMING_WR.L3_HIT",
> -        "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x80080800",
> -        "Offcore": "1",
> -        "PublicDescription": "Offcore response can be programmed only with a specific pair of event select and counter MSR, and with specific event codes and predefine mask bit value in a dedicated MSR to specify attributes of the offcore transaction.",
> -        "SampleAfterValue": "100003",
> -        "UMask": "0x1"
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
> -        "Speculative": "1",
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
> -        "Speculative": "1",
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
> -        "Speculative": "1",
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
> -        "Speculative": "1",
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
> -        "Speculative": "1",
> -        "UMask": "0x2"
> -    },
> -    {
> -        "BriefDescription": "TMA slots available for an unhalted logical processor. Fixed counter - architectural event",
> -        "CollectPEBSRecord": "2",
> -        "Counter": "Fixed counter 3",
> -        "EventName": "TOPDOWN.SLOTS",
> -        "PEBScounters": "35",
> -        "PublicDescription": "Number of available slots for an unhalted logical processor. The event increments by machine-width of the narrowest pipeline as employed by the Top-down Microarchitecture Analysis method (TMA). The count is distributed among unhalted logical processors (hyper-threads) who share the same physical core. Software can use this event as the denominator for the top-level metrics of the TMA method. This architectural event is counted on a designated fixed counter (Fixed Counter 3).",
> -        "SampleAfterValue": "10000003",
> -        "Speculative": "1",
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
> -        "Speculative": "1",
> -        "UMask": "0x1"
>       }
>   ]
> \ No newline at end of file
> diff --git a/tools/perf/pmu-events/arch/x86/icelakex/pipeline.json b/tools/perf/pmu-events/arch/x86/icelakex/pipeline.json
> index 9a0b4907cb3a..068a3d46b443 100644
> --- a/tools/perf/pmu-events/arch/x86/icelakex/pipeline.json
> +++ b/tools/perf/pmu-events/arch/x86/icelakex/pipeline.json
> @@ -728,6 +728,41 @@
>           "Speculative": "1",
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
> +        "Speculative": "1",
> +        "UMask": "0x2"
> +    },
> +    {
> +        "BriefDescription": "TMA slots available for an unhalted logical processor. Fixed counter - architectural event",
> +        "CollectPEBSRecord": "2",
> +        "Counter": "Fixed counter 3",
> +        "EventName": "TOPDOWN.SLOTS",
> +        "PEBScounters": "35",
> +        "PublicDescription": "Number of available slots for an unhalted logical processor. The event increments by machine-width of the narrowest pipeline as employed by the Top-down Microarchitecture Analysis method (TMA). The count is distributed among unhalted logical processors (hyper-threads) who share the same physical core. Software can use this event as the denominator for the top-level metrics of the TMA method. This architectural event is counted on a designated fixed counter (Fixed Counter 3).",
> +        "SampleAfterValue": "10000003",
> +        "Speculative": "1",
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
> +        "Speculative": "1",
> +        "UMask": "0x1"
> +    },
>       {
>           "BriefDescription": "Number of uops decoded out of instructions exclusively fetched by decoder 0",
>           "CollectPEBSRecord": "2",

-- 
Zhengjun Xing
