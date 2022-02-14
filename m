Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11E004B5B9E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 22:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbiBNU5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 15:57:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbiBNU4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 15:56:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD70113DAF;
        Mon, 14 Feb 2022 12:56:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B5C86116D;
        Mon, 14 Feb 2022 19:50:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53768C340E9;
        Mon, 14 Feb 2022 19:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644868242;
        bh=BvxiazElhAHgEm8+2WGMWR3C6ZbhqtLqke0JBRhBcik=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aEGVTY81UnRVU8bkM8waQP4laPDy37D3Gu8TElITdwX61EGmyK5ZXos2moGKr5Zd2
         8MP989zlHrw4km6Qd2cAIkl424Y7mypQq6/Jz4lro7XYz1tVNiF2LHsm/Qlz6eDPDV
         3aF55ngK8WxjFvb+1VefzXQCjlDwQtNb96TskP3EFoEWXcOyW6actoyWn7O8aoHusr
         BU3stTV6VNZ2Y/kFzJ0O5VzJLANKsKxQ9/SvwrQYfOhqFBRwvvuHpW7h/qHcbeOBMa
         EKZDkio8Fkmf0SxDgGW0obRhFKbjpbAs37b3J2YkEbC42FX+OMt5ljgg5j1O4ZV4k/
         VPYggZ5PnzqTw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 58C4F400FE; Mon, 14 Feb 2022 16:50:40 -0300 (-03)
Date:   Mon, 14 Feb 2022 16:50:40 -0300
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
Message-ID: <YgqykEiMq88HNyE2@kernel.org>
References: <20220211103415.2737789-1-irogers@google.com>
 <20220211103415.2737789-7-irogers@google.com>
 <YgqyE+vYyOf1HaRj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgqyE+vYyOf1HaRj@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Feb 14, 2022 at 04:48:35PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Fri, Feb 11, 2022 at 02:33:59AM -0800, Ian Rogers escreveu:
> > struct maps is reference counted, using a pointer is more idiomatic.
> > 
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/tests/maps.c | 20 ++++++++++----------
> >  1 file changed, 10 insertions(+), 10 deletions(-)
> > 
> > diff --git a/tools/perf/tests/maps.c b/tools/perf/tests/maps.c
> > index e308a3296cef..6f53f17f788e 100644
> > --- a/tools/perf/tests/maps.c
> > +++ b/tools/perf/tests/maps.c
> > @@ -35,7 +35,7 @@ static int check_maps(struct map_def *merged, unsigned int size, struct maps *ma
> >  
> >  static int test__maps__merge_in(struct test_suite *t __maybe_unused, int subtest __maybe_unused)
> >  {
> > -	struct maps maps;
> > +	struct maps *maps;
> >  	unsigned int i;
> >  	struct map_def bpf_progs[] = {
> >  		{ "bpf_prog_1", 200, 300 },
> > @@ -64,7 +64,7 @@ static int test__maps__merge_in(struct test_suite *t __maybe_unused, int subtest
> >  	struct map *map_kcore1, *map_kcore2, *map_kcore3;
> >  	int ret;
> >  
> > -	maps__init(&maps, NULL);
> > +	maps = maps__new(NULL);
> 
> Now that is dynamicly allocated we need to check for the constructor
> result, I'm fixing this up.

I.e. added this:

diff --git a/tools/perf/tests/maps.c b/tools/perf/tests/maps.c
index 6f53f17f788e7dd7..a69988a89d265211 100644
--- a/tools/perf/tests/maps.c
+++ b/tools/perf/tests/maps.c
@@ -35,7 +35,6 @@ static int check_maps(struct map_def *merged, unsigned int size, struct maps *ma
 
 static int test__maps__merge_in(struct test_suite *t __maybe_unused, int subtest __maybe_unused)
 {
-	struct maps *maps;
 	unsigned int i;
 	struct map_def bpf_progs[] = {
 		{ "bpf_prog_1", 200, 300 },
@@ -63,8 +62,9 @@ static int test__maps__merge_in(struct test_suite *t __maybe_unused, int subtest
 	};
 	struct map *map_kcore1, *map_kcore2, *map_kcore3;
 	int ret;
+	struct maps *maps = maps__new(NULL);
 
-	maps = maps__new(NULL);
+	TEST_ASSERT_VAL("failed to create maps", maps);
 
 	for (i = 0; i < ARRAY_SIZE(bpf_progs); i++) {
 		struct map *map;
