Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7837F5A84BF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 19:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231968AbiHaRvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 13:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbiHaRuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 13:50:40 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 419894E875
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 10:50:38 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id c135-20020a624e8d000000b0053617082770so6389173pfb.8
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 10:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=hBJ0yO7Shj4BOGRLl4iwSJQIsSnhkgtQ+YJ6SsJa66s=;
        b=EUrxwLovkSwJ6TvkQKG8Klcqc7EZ7RVJLb38iq+CvHU+quWu0R9+NfCH0WIn1OAuXI
         QRKBYrqgM7LtbjAKMeZvYVvDy6Z6J6NC+DUpXkVeSXi/+lMIa2o9SH549yRhIUWuXV3X
         MQfiqxR7PSeFNuz10ifbhUSKXJpdvxhWjfp3aogg9kq/EpMa3irR/9l5vRDDzaOxP/P/
         XbnWvNZFTSMgt6WFc6SOQEh9AgmxisyNF/AzIVHfCiWJ6ffdNyeD90ZZKfM+g2rbzPI1
         FLkiDoJ1A9ru709SSUUm8CibNMQQ2NgSy1eIedsr/e8TMWU+ZUGpRH2HfNfD6NpuFj40
         uJKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=hBJ0yO7Shj4BOGRLl4iwSJQIsSnhkgtQ+YJ6SsJa66s=;
        b=rxB4iz4s1ZyxrdnNOiFYTcmruiiLp6/zw0Wk4VE2t3u1Enq5SeTCic+JoptzltgvDp
         fLciamrwf0ZoprjarKc8NrxkVlCWEfSGEUPIqOb10OHKyrN1tVHaRK9WoPKnHx6B2PLW
         woMWWXgLnOEf4wiEO64vNqLwFC/6Q1I5xKBaIeruMV4CpcN296QkaSXSbottA80WO+2r
         yAT/PZGwvha43z7uZewuZvDPvHH29yT7mfuF3sHyBHVT30Sg8PfZlWplJjBxplEkokBu
         1g0EyE/AjEFa9OeqfOVza7OMG7NGoFUJHO9AZgyV6Lcro2RPppTGvAoXNxhQZUTnVscr
         erFg==
X-Gm-Message-State: ACgBeo1vkkL8av1Pe3wWA/ncswKukmf8/76EHofMOSY+YB0NcjP+kDtd
        uM2hAfuS5OIo4j2BHfkkC/QxK8+i2+7W
X-Google-Smtp-Source: AA6agR6KUXTyj1DNwsbVD0rQVcRjyBpcT5UUV8Q3uxsgGqjxyGpUlPH3TVslv1iig/sms+GEgtrglNC5U5Tv
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c8e4:a3e5:9d09:d3d4])
 (user=irogers job=sendgmr) by 2002:a17:90a:e558:b0:1fb:c4b7:1a24 with SMTP id
 ei24-20020a17090ae55800b001fbc4b71a24mr254671pjb.1.1661968237443; Wed, 31 Aug
 2022 10:50:37 -0700 (PDT)
Date:   Wed, 31 Aug 2022 10:49:26 -0700
In-Reply-To: <20220831174926.579643-1-irogers@google.com>
Message-Id: <20220831174926.579643-8-irogers@google.com>
Mime-Version: 1.0
References: <20220831174926.579643-1-irogers@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Subject: [PATCH v2 7/7] perf test: Add basic core_wide expression test
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        John Garry <john.garry@huawei.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        perry.taylor@intel.com, caleb.biggers@intel.com,
        kshipra.bopardikar@intel.com, ahmad.yasin@intel.com
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
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

Add basic test for coverage, similar to #smt_on.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/expr.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
index db736ed49556..8bd719766814 100644
--- a/tools/perf/tests/expr.c
+++ b/tools/perf/tests/expr.c
@@ -158,6 +158,9 @@ static int test__expr(struct test_suite *t __maybe_unused, int subtest __maybe_u
 	{
 		struct cpu_topology *topology = cpu_topology__new();
 		bool smton = smt_on(topology);
+		bool corewide = core_wide(/*system_wide=*/false,
+					  /*user_requested_cpus=*/false,
+					  topology);
 
 		cpu_topology__delete(topology);
 		expr__ctx_clear(ctx);
@@ -168,6 +171,16 @@ static int test__expr(struct test_suite *t __maybe_unused, int subtest __maybe_u
 		TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids,
 							  smton ? "EVENT1" : "EVENT2",
 							  (void **)&val_ptr));
+
+		expr__ctx_clear(ctx);
+		TEST_ASSERT_VAL("find ids",
+				expr__find_ids("EVENT1 if #core_wide else EVENT2",
+					NULL, ctx) == 0);
+		TEST_ASSERT_VAL("find ids", hashmap__size(ctx->ids) == 1);
+		TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids,
+							  corewide ? "EVENT1" : "EVENT2",
+							  (void **)&val_ptr));
+
 	}
 	/* The expression is a constant 1.0 without needing to evaluate EVENT1. */
 	expr__ctx_clear(ctx);
-- 
2.37.2.672.g94769d06f0-goog

