Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C41234B2BB1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 18:24:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352076AbiBKRY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 12:24:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245653AbiBKRYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 12:24:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF8ECDB;
        Fri, 11 Feb 2022 09:24:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 16EC861BD2;
        Fri, 11 Feb 2022 17:24:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D803C340E9;
        Fri, 11 Feb 2022 17:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644600292;
        bh=sljsI0xTOIzuKtd7B7+GsEnYM7lL3thpAyNttIuX1OU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HNQu6IG5Zyb/cFoDLen30JIrZxQ6YiJb1GQkoZyEPkUqMoWooeP3cbt47vukAi1Yn
         BkcA5hhJqWVR5HdMUVc189EXvhOI5jEqXTYvf1EJ2EIiF+45tAjFUp5JqSA8CkSuei
         mzG7fwKXkQOXY5uwvHgEAxG6KP0rMRtC/8MO9aR3McOEnioqPqYKs+8RvvE0hgmb4k
         Kqv0IcnIK7/3zjoVfcollLmkCmQt+EEZWntEu4/vO8ndT4S4hF3IpJiWm+bRvMW7B/
         4pIunXdkiv2/GnwZzCcpTb8z1En1zHP4nWmS2LVXPPqSHd/Bx1Hk6yx/U2WtaTvgLc
         dFK4CIGAt7gjA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9EC26400FE; Fri, 11 Feb 2022 14:24:50 -0300 (-03)
Date:   Fri, 11 Feb 2022 14:24:50 -0300
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
Subject: Re: [PATCH v3 06/22] perf test: Use pointer for maps
Message-ID: <Ygab4lto6d57tRcv@kernel.org>
References: <20220211103415.2737789-1-irogers@google.com>
 <20220211103415.2737789-7-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220211103415.2737789-7-irogers@google.com>
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

Em Fri, Feb 11, 2022 at 02:33:59AM -0800, Ian Rogers escreveu:
> struct maps is reference counted, using a pointer is more idiomatic.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/maps.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/perf/tests/maps.c b/tools/perf/tests/maps.c
> index e308a3296cef..6f53f17f788e 100644
> --- a/tools/perf/tests/maps.c
> +++ b/tools/perf/tests/maps.c
> @@ -35,7 +35,7 @@ static int check_maps(struct map_def *merged, unsigned int size, struct maps *ma
>  
>  static int test__maps__merge_in(struct test_suite *t __maybe_unused, int subtest __maybe_unused)
>  {
> -	struct maps maps;
> +	struct maps *maps;
>  	unsigned int i;
>  	struct map_def bpf_progs[] = {
>  		{ "bpf_prog_1", 200, 300 },
> @@ -64,7 +64,7 @@ static int test__maps__merge_in(struct test_suite *t __maybe_unused, int subtest
>  	struct map *map_kcore1, *map_kcore2, *map_kcore3;
>  	int ret;
>  
> -	maps__init(&maps, NULL);
> +	maps = maps__new(NULL);


Any __news() method can fail, so we should check for that and bail out.
  
>  	for (i = 0; i < ARRAY_SIZE(bpf_progs); i++) {
>  		struct map *map;
> @@ -74,7 +74,7 @@ static int test__maps__merge_in(struct test_suite *t __maybe_unused, int subtest
>  
>  		map->start = bpf_progs[i].start;
>  		map->end   = bpf_progs[i].end;
> -		maps__insert(&maps, map);
> +		maps__insert(maps, map);
>  		map__put(map);
>  	}
>  
> @@ -99,25 +99,25 @@ static int test__maps__merge_in(struct test_suite *t __maybe_unused, int subtest
>  	map_kcore3->start = 880;
>  	map_kcore3->end   = 1100;
>  
> -	ret = maps__merge_in(&maps, map_kcore1);
> +	ret = maps__merge_in(maps, map_kcore1);
>  	TEST_ASSERT_VAL("failed to merge map", !ret);
>  
> -	ret = check_maps(merged12, ARRAY_SIZE(merged12), &maps);
> +	ret = check_maps(merged12, ARRAY_SIZE(merged12), maps);
>  	TEST_ASSERT_VAL("merge check failed", !ret);
>  
> -	ret = maps__merge_in(&maps, map_kcore2);
> +	ret = maps__merge_in(maps, map_kcore2);
>  	TEST_ASSERT_VAL("failed to merge map", !ret);
>  
> -	ret = check_maps(merged12, ARRAY_SIZE(merged12), &maps);
> +	ret = check_maps(merged12, ARRAY_SIZE(merged12), maps);
>  	TEST_ASSERT_VAL("merge check failed", !ret);
>  
> -	ret = maps__merge_in(&maps, map_kcore3);
> +	ret = maps__merge_in(maps, map_kcore3);
>  	TEST_ASSERT_VAL("failed to merge map", !ret);
>  
> -	ret = check_maps(merged3, ARRAY_SIZE(merged3), &maps);
> +	ret = check_maps(merged3, ARRAY_SIZE(merged3), maps);
>  	TEST_ASSERT_VAL("merge check failed", !ret);
>  
> -	maps__exit(&maps);
> +	maps__delete(maps);
>  	return TEST_OK;
>  }
>  
> -- 
> 2.35.1.265.g69c8d7142f-goog

-- 

- Arnaldo
