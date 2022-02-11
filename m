Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 552714B233E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 11:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349007AbiBKKfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 05:35:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348967AbiBKKej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 05:34:39 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D0A7EB0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 02:34:36 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id s73-20020a25aa4f000000b0061d764d3c13so18050029ybi.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 02:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=adzPZhHgiX/5Q+ijF4WJDVi8pUbKn1ZnOOn3EBB8IqQ=;
        b=sHWlYTgeRqtGFPCZFhv1M0WLxyKLAO3ES2qCCJpEF61OjOPok7uB9sW8RVSU0nP3xj
         WXm43G8cz0VWWynvwxeQzY4iL1N3vcTL7Zzq2JJyeoJK1lHio38oJCR2HfMeMMh/27Qv
         Z5TkIfqn4TS/62scOam0IFaFEs8P08TzVWLV/Tq9yjPZVpINZipSU0fJyLxF/bMlUGCO
         z0h8WnXikfX1xs0lz6IQAr0ZACywLjM29yvAt03R1OwLVxJnQLab7leWhgBlaxAecs9u
         r1Pp/lPSu1Ftqily0HkCivJ5C7aI2LLU4szn+WFv2Xykel6kIqZ6Vy7h0nVk6daWw4/v
         9QNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=adzPZhHgiX/5Q+ijF4WJDVi8pUbKn1ZnOOn3EBB8IqQ=;
        b=g1IgM1ghpm04G0Q6Ul2frSdu04KvOLBvBAQAQHHxMUkK2a4KqxBA2c86v70DuJPUXo
         sM2FLm7f41W1qOeaIPncD/ABiZnhhGNAuYFDWhbYOsuqOLKVMnatclmltEYmCoDd7AXF
         ygbAbG8hpS+55Dn9iIsTxV01IibBmxwAmPQxXc+MpumAQ2lecL413Ye+IF/TBCCulJLR
         IIm0fHFPq4i+thyWZAoQ9cEGTRewogrT6OfEeHkXPEbobZP9fXkF7paEY1wgJpVEwA1I
         8SriwcYamItsS3wjb4bpbbzXmyQTR86iDKmEo99H/iOjjCLOe1qXK8yu3eNYQVC8AeA2
         YQMw==
X-Gm-Message-State: AOAM533bAR/j1EDKfD2Fkg6+Qmo27cjY+ErvDgM/PCcx/FDksT6Ht3Vt
        aAcWSgnhZsk4pz8bJJNOYolE7sXJA+Lp
X-Google-Smtp-Source: ABdhPJzAXFkFowKEpkDkpRcUZFxoFSoW7xUtARt67NOfJ1oDepF0lnLRS13c7rx9XshldnFaOqMprYqsAn+i
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:2d98:3ad9:1d8a:fb9b])
 (user=irogers job=sendgmr) by 2002:a25:4cd:: with SMTP id 196mr657423ybe.439.1644575675304;
 Fri, 11 Feb 2022 02:34:35 -0800 (PST)
Date:   Fri, 11 Feb 2022 02:33:59 -0800
In-Reply-To: <20220211103415.2737789-1-irogers@google.com>
Message-Id: <20220211103415.2737789-7-irogers@google.com>
Mime-Version: 1.0
References: <20220211103415.2737789-1-irogers@google.com>
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
Subject: [PATCH v3 06/22] perf test: Use pointer for maps
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@collabora.com>,
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
        Dmitry Vyukov <dvyukov@google.com>, Hao Luo <haoluo@google.com>
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct maps is reference counted, using a pointer is more idiomatic.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/maps.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/perf/tests/maps.c b/tools/perf/tests/maps.c
index e308a3296cef..6f53f17f788e 100644
--- a/tools/perf/tests/maps.c
+++ b/tools/perf/tests/maps.c
@@ -35,7 +35,7 @@ static int check_maps(struct map_def *merged, unsigned int size, struct maps *ma
 
 static int test__maps__merge_in(struct test_suite *t __maybe_unused, int subtest __maybe_unused)
 {
-	struct maps maps;
+	struct maps *maps;
 	unsigned int i;
 	struct map_def bpf_progs[] = {
 		{ "bpf_prog_1", 200, 300 },
@@ -64,7 +64,7 @@ static int test__maps__merge_in(struct test_suite *t __maybe_unused, int subtest
 	struct map *map_kcore1, *map_kcore2, *map_kcore3;
 	int ret;
 
-	maps__init(&maps, NULL);
+	maps = maps__new(NULL);
 
 	for (i = 0; i < ARRAY_SIZE(bpf_progs); i++) {
 		struct map *map;
@@ -74,7 +74,7 @@ static int test__maps__merge_in(struct test_suite *t __maybe_unused, int subtest
 
 		map->start = bpf_progs[i].start;
 		map->end   = bpf_progs[i].end;
-		maps__insert(&maps, map);
+		maps__insert(maps, map);
 		map__put(map);
 	}
 
@@ -99,25 +99,25 @@ static int test__maps__merge_in(struct test_suite *t __maybe_unused, int subtest
 	map_kcore3->start = 880;
 	map_kcore3->end   = 1100;
 
-	ret = maps__merge_in(&maps, map_kcore1);
+	ret = maps__merge_in(maps, map_kcore1);
 	TEST_ASSERT_VAL("failed to merge map", !ret);
 
-	ret = check_maps(merged12, ARRAY_SIZE(merged12), &maps);
+	ret = check_maps(merged12, ARRAY_SIZE(merged12), maps);
 	TEST_ASSERT_VAL("merge check failed", !ret);
 
-	ret = maps__merge_in(&maps, map_kcore2);
+	ret = maps__merge_in(maps, map_kcore2);
 	TEST_ASSERT_VAL("failed to merge map", !ret);
 
-	ret = check_maps(merged12, ARRAY_SIZE(merged12), &maps);
+	ret = check_maps(merged12, ARRAY_SIZE(merged12), maps);
 	TEST_ASSERT_VAL("merge check failed", !ret);
 
-	ret = maps__merge_in(&maps, map_kcore3);
+	ret = maps__merge_in(maps, map_kcore3);
 	TEST_ASSERT_VAL("failed to merge map", !ret);
 
-	ret = check_maps(merged3, ARRAY_SIZE(merged3), &maps);
+	ret = check_maps(merged3, ARRAY_SIZE(merged3), maps);
 	TEST_ASSERT_VAL("merge check failed", !ret);
 
-	maps__exit(&maps);
+	maps__delete(maps);
 	return TEST_OK;
 }
 
-- 
2.35.1.265.g69c8d7142f-goog

