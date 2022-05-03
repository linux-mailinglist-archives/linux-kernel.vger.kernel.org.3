Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12F06517F1C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 09:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232434AbiECHrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 03:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbiECHrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 03:47:11 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B2537BF4;
        Tue,  3 May 2022 00:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651563819; x=1683099819;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Mad1uBVm2XH6WaLsxjiK6woIkr1Z52tvNOx62IoUvuA=;
  b=YezqqDq8pmDvt3qt8kOUXeyrsk0nYs7eB2IyD+wS+egXaBg7Nso2RuDm
   AGsuGSZ6eI1cfHooGgzGV9LWnC2LDfdvXrhkB7Kikp4xAd4PESAIzUM9Z
   xWuKr3hrpykMH4rncIwr584GfnBaWM7XwpBpBK3ZYiPcD7GkAgADi6tMQ
   wu2ECY6jZPy3pI09j67vuzbat7ClOV4QF1Ju/xqgCShVUTCcjcDvTRkxb
   zCEWhHhebWEmruym6p2frMWsfkAZU2V+NYlht6zKkyOkOwPupRJe9/Wwk
   fkk4m3NnkDAmWtzgsEmfszuL5AjSSavDIGpJketfTdEDwxveV0L44v5MC
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10335"; a="247967183"
X-IronPort-AV: E=Sophos;i="5.91,194,1647327600"; 
   d="scan'208";a="247967183"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 00:43:39 -0700
X-IronPort-AV: E=Sophos;i="5.91,194,1647327600"; 
   d="scan'208";a="584098882"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.32.209])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 00:43:31 -0700
Message-ID: <b94f3863-c690-e0f7-5cde-18fbf24143e5@intel.com>
Date:   Tue, 3 May 2022 10:43:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.8.1
Subject: Re: [PATCH v5 4/6] perf cpumap: Handle dummy maps as empty in subset
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        German Gomez <german.gomez@arm.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>
References: <20220503041757.2365696-1-irogers@google.com>
 <20220503041757.2365696-5-irogers@google.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20220503041757.2365696-5-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/05/22 07:17, Ian Rogers wrote:
> perf_cpu_map__empty is true for empty and dummy maps. Make is_subset
> respect that.

As I wrote before, I am not keen on this because it prevents -1, as a
valid 3rd parameter to perf_event_open(), from being represented
in merged evsel cpu maps.

Why do you want this?

> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/lib/perf/cpumap.c   |  4 ++--
>  tools/perf/tests/cpumap.c | 10 +++++++++-
>  2 files changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
> index 384d5e076ee4..9c83675788c2 100644
> --- a/tools/lib/perf/cpumap.c
> +++ b/tools/lib/perf/cpumap.c
> @@ -322,9 +322,9 @@ struct perf_cpu perf_cpu_map__max(struct perf_cpu_map *map)
>  /** Is 'b' a subset of 'a'. */
>  bool perf_cpu_map__is_subset(const struct perf_cpu_map *a, const struct perf_cpu_map *b)
>  {
> -	if (a == b || !b)
> +	if (a == b || perf_cpu_map__empty(b))
>  		return true;
> -	if (!a || b->nr > a->nr)
> +	if (perf_cpu_map__empty(a) || b->nr > a->nr)
>  		return false;
>  
>  	for (int i = 0, j = 0; i < a->nr; i++) {
> diff --git a/tools/perf/tests/cpumap.c b/tools/perf/tests/cpumap.c
> index f94929ebb54b..d52b58395385 100644
> --- a/tools/perf/tests/cpumap.c
> +++ b/tools/perf/tests/cpumap.c
> @@ -128,13 +128,21 @@ static int test__cpu_map_merge(struct test_suite *test __maybe_unused, int subte
>  	struct perf_cpu_map *a = perf_cpu_map__new("4,2,1");
>  	struct perf_cpu_map *b = perf_cpu_map__new("4,5,7");
>  	struct perf_cpu_map *c = perf_cpu_map__merge(a, b);
> +	struct perf_cpu_map *d = perf_cpu_map__dummy_new();
> +	struct perf_cpu_map *e = perf_cpu_map__merge(b, d);
>  	char buf[100];
>  
>  	TEST_ASSERT_VAL("failed to merge map: bad nr", perf_cpu_map__nr(c) == 5);
>  	cpu_map__snprint(c, buf, sizeof(buf));
>  	TEST_ASSERT_VAL("failed to merge map: bad result", !strcmp(buf, "1-2,4-5,7"));
> -	perf_cpu_map__put(b);
> +
> +	TEST_ASSERT_VAL("failed to merge map: bad nr", perf_cpu_map__nr(e) == 3);
> +	cpu_map__snprint(e, buf, sizeof(buf));
> +	TEST_ASSERT_VAL("failed to merge map: bad result", !strcmp(buf, "4-5,7"));
> +
>  	perf_cpu_map__put(c);
> +	perf_cpu_map__put(d);
> +	perf_cpu_map__put(e);
>  	return 0;
>  }
>  

