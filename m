Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7009A4B2B34
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 18:03:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344805AbiBKRDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 12:03:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbiBKRDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 12:03:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B5972E8;
        Fri, 11 Feb 2022 09:03:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BAD9C618CF;
        Fri, 11 Feb 2022 17:02:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 049CAC340E9;
        Fri, 11 Feb 2022 17:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644598979;
        bh=zuPZS3PAjNq9s4x88G3qZsc/2FOVidLzSAiRwWGJ5WA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HOMHtkWugcIQQEnlIQ78Rqf7fXzGgkkzd8GNOM1iT6zfgV5U3s+tvGQsjF8AKbD8j
         S+ZeMFkwfwlmIoI8W1wNUGcLdB38MWx90k40JVPXVk+e4rOXXjvoCb70vdsgXSONl9
         L+EYZHRjLL24GdKu1UvWWPsQc63vVKdxPStuJJzANgXu6tagD1uFMXaXIUtuUaWqWD
         hs4ssctdVIze4HNXKw71+8vaP5hZArhid1EMCKkUgoJ2gF2vyztq4lDjuGDZHWCuos
         Vp9eYKgJXqmTjbBf4HZTICZLDGHdUZ+UfuLPqRSxPgU190JZ4oD3Pw1ZibjWkcD5WF
         6aZqfqHZWF/sw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5D9E0400FE; Fri, 11 Feb 2022 14:02:56 -0300 (-03)
Date:   Fri, 11 Feb 2022 14:02:56 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@collabora.com>,
        James Clark <james.clark@arm.com>,
        John Garry <john.garry@huawei.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Shunsuke Nakamura <nakamura.shun@fujitsu.com>,
        Song Liu <song@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Miaoqian Lin <linmq006@gmail.com>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eric Dumazet <edumazet@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Hao Luo <haoluo@google.com>, eranian@google.com
Subject: Re: [PATCH v3 01/22] perf cpumap: Migrate to libperf cpumap api
Message-ID: <YgaWwP5E8A7OjO5M@kernel.org>
References: <20220211103415.2737789-1-irogers@google.com>
 <20220211103415.2737789-2-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220211103415.2737789-2-irogers@google.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Feb 11, 2022 at 02:33:54AM -0800, Ian Rogers escreveu:
> Switch from directly accessing the perf_cpu_map to using the appropriate
> libperf API when possible. Using the API simplifies the job of
> refactoring use of perf_cpu_map.

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/cpumap.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/perf/tests/cpumap.c b/tools/perf/tests/cpumap.c
> index 84e87e31f119..f94929ebb54b 100644
> --- a/tools/perf/tests/cpumap.c
> +++ b/tools/perf/tests/cpumap.c
> @@ -35,10 +35,10 @@ static int process_event_mask(struct perf_tool *tool __maybe_unused,
>  	}
>  
>  	map = cpu_map__new_data(data);
> -	TEST_ASSERT_VAL("wrong nr",  map->nr == 20);
> +	TEST_ASSERT_VAL("wrong nr",  perf_cpu_map__nr(map) == 20);
>  
>  	for (i = 0; i < 20; i++) {
> -		TEST_ASSERT_VAL("wrong cpu", map->map[i].cpu == i);
> +		TEST_ASSERT_VAL("wrong cpu", perf_cpu_map__cpu(map, i).cpu == i);
>  	}
>  
>  	perf_cpu_map__put(map);
> @@ -66,9 +66,9 @@ static int process_event_cpus(struct perf_tool *tool __maybe_unused,
>  	TEST_ASSERT_VAL("wrong cpu",  cpus->cpu[1] == 256);
>  
>  	map = cpu_map__new_data(data);
> -	TEST_ASSERT_VAL("wrong nr",  map->nr == 2);
> -	TEST_ASSERT_VAL("wrong cpu", map->map[0].cpu == 1);
> -	TEST_ASSERT_VAL("wrong cpu", map->map[1].cpu == 256);
> +	TEST_ASSERT_VAL("wrong nr",  perf_cpu_map__nr(map) == 2);
> +	TEST_ASSERT_VAL("wrong cpu", perf_cpu_map__cpu(map, 0).cpu == 1);
> +	TEST_ASSERT_VAL("wrong cpu", perf_cpu_map__cpu(map, 1).cpu == 256);
>  	TEST_ASSERT_VAL("wrong refcnt", refcount_read(&map->refcnt) == 1);
>  	perf_cpu_map__put(map);
>  	return 0;
> @@ -130,7 +130,7 @@ static int test__cpu_map_merge(struct test_suite *test __maybe_unused, int subte
>  	struct perf_cpu_map *c = perf_cpu_map__merge(a, b);
>  	char buf[100];
>  
> -	TEST_ASSERT_VAL("failed to merge map: bad nr", c->nr == 5);
> +	TEST_ASSERT_VAL("failed to merge map: bad nr", perf_cpu_map__nr(c) == 5);
>  	cpu_map__snprint(c, buf, sizeof(buf));
>  	TEST_ASSERT_VAL("failed to merge map: bad result", !strcmp(buf, "1-2,4-5,7"));
>  	perf_cpu_map__put(b);
> -- 
> 2.35.1.265.g69c8d7142f-goog

-- 

- Arnaldo
