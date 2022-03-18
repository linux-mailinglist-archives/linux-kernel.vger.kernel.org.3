Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C299A4DD6FF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 10:21:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234375AbiCRJWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 05:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234334AbiCRJWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 05:22:36 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A7F23191F;
        Fri, 18 Mar 2022 02:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647595278; x=1679131278;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=V8iUTczWrf6cuam5u0ehBgW23frIjstnAV6B3qNkosU=;
  b=C3ekU5ojDwb+dE8vMR3CZLXtHpFnWrWqQmEd2H/3lW0EAFpL7BTcxZpV
   XplM5CZfxHE1rGVyTK8evMaGwqHo6NJZ50rnMCA5C7CbIkOrxDc6Bc7z5
   mIuU5vNjOiJiVP9CnutnS1sC9VgzS7rX+f9yTB4F6Fe4sAdGfsEnCeHQU
   zuwwE66YqMMKD1vUD3MWKUP+2miaoXUyxh7AvFBIIcfyYmh3y1Lx9b6YW
   aLRXqOD5auPxFzNje4HhQtoWSvM7AWZDR03H8ZVkqxDBEGIyFvLpy7CYw
   Kfhl3ASbvbuxI/M2AxfWDYWMmCn3ccLoKiND3mGZ1Q3KPVF6v0z96yMR5
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="256826981"
X-IronPort-AV: E=Sophos;i="5.90,191,1643702400"; 
   d="scan'208";a="256826981"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 02:21:17 -0700
X-IronPort-AV: E=Sophos;i="5.90,191,1643702400"; 
   d="scan'208";a="558339759"
Received: from xingzhen-mobl.ccr.corp.intel.com (HELO [10.255.31.171]) ([10.255.31.171])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 02:21:13 -0700
Message-ID: <05c591ad-0f50-842e-b1b0-a93118f66240@linux.intel.com>
Date:   Fri, 18 Mar 2022 17:21:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 6/8] perf vendor events: Update events for SkylakeX
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
 <20220317182858.484474-6-irogers@google.com>
From:   Xing Zhengjun <zhengjun.xing@linux.intel.com>
In-Reply-To: <20220317182858.484474-6-irogers@google.com>
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
> The change:
> https://github.com/intel/event-converter-for-linux-perf/commit/fc680410402e394eed6a1ebd909c9f649d3ed3ef
> moved certain "other" type of events in to the cache topic. Update the
> perf json files for this change.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

Reviewed-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>

> ---
>   .../pmu-events/arch/x86/skylakex/cache.json   | 36 +++++++++++++++++++
>   .../pmu-events/arch/x86/skylakex/other.json   | 36 -------------------
>   2 files changed, 36 insertions(+), 36 deletions(-)
> 
> diff --git a/tools/perf/pmu-events/arch/x86/skylakex/cache.json b/tools/perf/pmu-events/arch/x86/skylakex/cache.json
> index 821d2f2a8f25..6639e18a7068 100644
> --- a/tools/perf/pmu-events/arch/x86/skylakex/cache.json
> +++ b/tools/perf/pmu-events/arch/x86/skylakex/cache.json
> @@ -1686,5 +1686,41 @@
>           "PublicDescription": "Counts the number of cache line split locks sent to the uncore.",
>           "SampleAfterValue": "100003",
>           "UMask": "0x10"
> +    },
> +    {
> +        "BriefDescription": "Number of PREFETCHNTA instructions executed.",
> +        "Counter": "0,1,2,3",
> +        "CounterHTOff": "0,1,2,3,4,5,6,7",
> +        "EventCode": "0x32",
> +        "EventName": "SW_PREFETCH_ACCESS.NTA",
> +        "SampleAfterValue": "2000003",
> +        "UMask": "0x1"
> +    },
> +    {
> +        "BriefDescription": "Number of PREFETCHW instructions executed.",
> +        "Counter": "0,1,2,3",
> +        "CounterHTOff": "0,1,2,3,4,5,6,7",
> +        "EventCode": "0x32",
> +        "EventName": "SW_PREFETCH_ACCESS.PREFETCHW",
> +        "SampleAfterValue": "2000003",
> +        "UMask": "0x8"
> +    },
> +    {
> +        "BriefDescription": "Number of PREFETCHT0 instructions executed.",
> +        "Counter": "0,1,2,3",
> +        "CounterHTOff": "0,1,2,3,4,5,6,7",
> +        "EventCode": "0x32",
> +        "EventName": "SW_PREFETCH_ACCESS.T0",
> +        "SampleAfterValue": "2000003",
> +        "UMask": "0x2"
> +    },
> +    {
> +        "BriefDescription": "Number of PREFETCHT1 or PREFETCHT2 instructions executed.",
> +        "Counter": "0,1,2,3",
> +        "CounterHTOff": "0,1,2,3,4,5,6,7",
> +        "EventCode": "0x32",
> +        "EventName": "SW_PREFETCH_ACCESS.T1_T2",
> +        "SampleAfterValue": "2000003",
> +        "UMask": "0x4"
>       }
>   ]
> \ No newline at end of file
> diff --git a/tools/perf/pmu-events/arch/x86/skylakex/other.json b/tools/perf/pmu-events/arch/x86/skylakex/other.json
> index 8b344259176f..779654e62d97 100644
> --- a/tools/perf/pmu-events/arch/x86/skylakex/other.json
> +++ b/tools/perf/pmu-events/arch/x86/skylakex/other.json
> @@ -76,41 +76,5 @@
>           "EventName": "MEMORY_DISAMBIGUATION.HISTORY_RESET",
>           "SampleAfterValue": "2000003",
>           "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Number of PREFETCHNTA instructions executed.",
> -        "Counter": "0,1,2,3",
> -        "CounterHTOff": "0,1,2,3,4,5,6,7",
> -        "EventCode": "0x32",
> -        "EventName": "SW_PREFETCH_ACCESS.NTA",
> -        "SampleAfterValue": "2000003",
> -        "UMask": "0x1"
> -    },
> -    {
> -        "BriefDescription": "Number of PREFETCHW instructions executed.",
> -        "Counter": "0,1,2,3",
> -        "CounterHTOff": "0,1,2,3,4,5,6,7",
> -        "EventCode": "0x32",
> -        "EventName": "SW_PREFETCH_ACCESS.PREFETCHW",
> -        "SampleAfterValue": "2000003",
> -        "UMask": "0x8"
> -    },
> -    {
> -        "BriefDescription": "Number of PREFETCHT0 instructions executed.",
> -        "Counter": "0,1,2,3",
> -        "CounterHTOff": "0,1,2,3,4,5,6,7",
> -        "EventCode": "0x32",
> -        "EventName": "SW_PREFETCH_ACCESS.T0",
> -        "SampleAfterValue": "2000003",
> -        "UMask": "0x2"
> -    },
> -    {
> -        "BriefDescription": "Number of PREFETCHT1 or PREFETCHT2 instructions executed.",
> -        "Counter": "0,1,2,3",
> -        "CounterHTOff": "0,1,2,3,4,5,6,7",
> -        "EventCode": "0x32",
> -        "EventName": "SW_PREFETCH_ACCESS.T1_T2",
> -        "SampleAfterValue": "2000003",
> -        "UMask": "0x4"
>       }
>   ]
> \ No newline at end of file

-- 
Zhengjun Xing
