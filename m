Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3A434E3DCB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 12:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbiCVLuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 07:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbiCVLuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 07:50:19 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A895DE70;
        Tue, 22 Mar 2022 04:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647949731; x=1679485731;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6QjCSLV5pHvUu+Co9Q8F1SIwOXRHIVGiCuCTzOhLowU=;
  b=IiS5eOcSAbKAwXnij0pxHeEzhEKlnJHgJ1kq9d0fQ1FNXHGTVyzeHi9S
   1BQWkYVpTXySqJgtqsLyxTKxmBrw5XuuN3O6xctY9PfSMQvgK7AtkWGw+
   xWg+5Njj9u16/KELflLX9IC78Pn9P+EXBfKtm/201UjaYx20Rc7QZE8Jh
   FAaB+JaGgWtqMsEo0qBu5mSR4svJUj6xtvvG5z9+4m05+Y48ddMIGzhzo
   TMHutrOtrFL5Vk0DJy29/MydBLuGSa2TCIOYUy5E52lkonPg0zNm726/O
   1HCSjc5A75Bg0DL4dKO6IhPxuczA4EteI/dDAzZV1k/sNgb8c83cprWNH
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10293"; a="239954907"
X-IronPort-AV: E=Sophos;i="5.90,201,1643702400"; 
   d="scan'208";a="239954907"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2022 04:48:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,201,1643702400"; 
   d="scan'208";a="583228928"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 22 Mar 2022 04:48:51 -0700
Received: from [10.209.120.44] (alwinma-MOBL2.amr.corp.intel.com [10.209.120.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id B9E53580A6C;
        Tue, 22 Mar 2022 04:48:49 -0700 (PDT)
Message-ID: <ffd440b7-fef9-a5ae-95b7-73c1f8a212ef@linux.intel.com>
Date:   Tue, 22 Mar 2022 07:48:48 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] perf parse-events: Move slots only with topdown
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
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
References: <20220321223344.1034479-1-irogers@google.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20220321223344.1034479-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/21/2022 6:33 PM, Ian Rogers wrote:
> If slots isn't with a topdown event then moving it is unnecessary. For
> example {instructions, slots} is re-ordered:
> 
> $ perf stat -e '{instructions,slots}' -a sleep 1
> 
>   Performance counter stats for 'system wide':
> 
>         936,600,825      slots
>         144,440,968      instructions
> 
>         1.006061423 seconds time elapsed
> 
> Which can break tools expecting the command line order to match the
> printed order. It is necessary to move the slots event first when it
> appears with topdown events. Add extra checking so that the slots event
> is only moved in the case of there being a topdown event like:
> 
> $ perf stat -e '{instructions,slots,topdown-fe-bound}' -a sleep 1
> 
>   Performance counter stats for 'system wide':
> 
>          2427568570      slots
>           300927614      instructions
>           551021649      topdown-fe-bound
> 
>         1.001771803 seconds time elapsed
> 
> Fixes: 94dbfd6781a0 ("perf parse-events: Architecture specific leader override")
> Reported-by: Kan Liang <kan.liang@linux.intel.com>
> Signed-off-by: Ian Rogers <irogers@google.com>

Thanks Ian. The patch works well.

Tested-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan
> ---
>   tools/perf/arch/x86/util/evlist.c | 18 ++++++++++++++----
>   1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/arch/x86/util/evlist.c b/tools/perf/arch/x86/util/evlist.c
> index 8d9b55959256..cfc208d71f00 100644
> --- a/tools/perf/arch/x86/util/evlist.c
> +++ b/tools/perf/arch/x86/util/evlist.c
> @@ -20,17 +20,27 @@ int arch_evlist__add_default_attrs(struct evlist *evlist)
>   
>   struct evsel *arch_evlist__leader(struct list_head *list)
>   {
> -	struct evsel *evsel, *first;
> +	struct evsel *evsel, *first, *slots = NULL;
> +	bool has_topdown = false;
>   
>   	first = list_first_entry(list, struct evsel, core.node);
>   
>   	if (!pmu_have_event("cpu", "slots"))
>   		return first;
>   
> +	/* If there is a slots event and a topdown event then the slots event comes first. */
>   	__evlist__for_each_entry(list, evsel) {
> -		if (evsel->pmu_name && !strcmp(evsel->pmu_name, "cpu") &&
> -			evsel->name && strcasestr(evsel->name, "slots"))
> -			return evsel;
> +		if (evsel->pmu_name && !strcmp(evsel->pmu_name, "cpu") && evsel->name) {
> +			if (strcasestr(evsel->name, "slots")) {
> +				slots = evsel;
> +				if (slots == first)
> +					return first;
> +			}
> +			if (!strncasecmp(evsel->name, "topdown", 7))
> +				has_topdown = true;
> +			if (slots && has_topdown)
> +				return slots;
> +		}
>   	}
>   	return first;
>   }
