Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65C8E5787AA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 18:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235808AbiGRQng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 12:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235687AbiGRQn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 12:43:27 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B5C2B1AC
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 09:43:25 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id v1-20020a259d81000000b0066ec7dff8feso9079616ybp.18
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 09:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=MeQFhDWhw6uJhVAf4SRwsMvd39/eawx4leroeGONoc8=;
        b=odOfFuywMBJ86ClpGLOJnyTs1vkUPpoBT8uT+btgbpCrf06texWEMIb+CtOWroV+0W
         jyVmCoiMbUMEmOEpds+6GymsbBdkAoIc7IzGTr/dQQRUSNppsMn47MIJFXEzYGV3KyAj
         l8eghn2P4ZbzTQKxBavlZnwAQtb1jf+09PnQ8HgLzETmk3+PwvrQGshHwopIbQJZh/Af
         1aV6H1eiwFxXulYwGJYQkcyO24NMMjsFQaTxgcCy70uCcQGLa1YFdb7TxEkRJeqiM/Pw
         xHq1F5Xd/KHxqxY5D+ywSeT/FVtNgJ39xHZjmMgsB8botISnbTGGfR8IwQJNMjIcB7wk
         veaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MeQFhDWhw6uJhVAf4SRwsMvd39/eawx4leroeGONoc8=;
        b=SLtE2Yf6ZaMTnowzkN74sAcf+0GX1hOk7E+RKQ2F9OgeK9QEG0NEwqqyrO5KXCllnc
         Tl6gtIwWgalOZmmPR68/yoh3MaOnMDhOOWKq9xlFf2ETjV0rh/I+eu7imAnCZ5E80pRB
         5bLnTGX8AuL8XAR6ti8/GlZqJWB60/RxE1Yw5FgGrz1HT67fLo88ylvoEUFvUcUBKXqQ
         TvgGTuL7umSAfsSBgLtKkOh4Hq/zD0DMD3sK2biL4+0R2mqUFc0yDiQQBYiGpdXJSz2L
         19MYxjdCmm/SX/ksOuZrixCfQg1mJQW5GSaNK0od1wqmtKcPPcNFhHQZde8mrLvnhIFc
         XL1Q==
X-Gm-Message-State: AJIora+4jUOco+5KPmd5+i1cbvtnTeXYbgpzlBxsS62gLX/O+IPRdz4l
        Ktdzzuz3txRjBPRUgKQkEQiWruMYYFPB
X-Google-Smtp-Source: AGRyM1sCFaSaN+OYXwJis87SDXFstBd+j8/M7CzZr1dKfE5Bl/b3JDSsZHKBzslDVbqZbE4BRCTv1jxJVvaJ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:922:90e9:167f:1ccd])
 (user=irogers job=sendgmr) by 2002:a25:d00b:0:b0:66e:e393:aa68 with SMTP id
 h11-20020a25d00b000000b0066ee393aa68mr27218620ybg.65.1658162604988; Mon, 18
 Jul 2022 09:43:24 -0700 (PDT)
Date:   Mon, 18 Jul 2022 09:43:12 -0700
In-Reply-To: <20220718164312.3994191-1-irogers@google.com>
Message-Id: <20220718164312.3994191-4-irogers@google.com>
Mime-Version: 1.0
References: <20220718164312.3994191-1-irogers@google.com>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
Subject: [PATCH v4 3/3] perf test: Add test for #system_tsc_freq in metrics
From:   Ian Rogers <irogers@google.com>
To:     perry.taylor@intel.com, caleb.biggers@intel.com,
        kshipra.bopardikar@intel.com,
        Kan Liang <kan.liang@linux.intel.com>,
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
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The value should be non-zero on Intel while zero on everything else.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/expr.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
index 5c0032fe93ae..2efe9e3a63b8 100644
--- a/tools/perf/tests/expr.c
+++ b/tools/perf/tests/expr.c
@@ -1,8 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "util/debug.h"
 #include "util/expr.h"
+#include "util/header.h"
 #include "util/smt.h"
 #include "tests.h"
+#include <math.h>
 #include <stdlib.h>
 #include <string.h>
 #include <linux/zalloc.h>
@@ -69,6 +71,11 @@ static int test__expr(struct test_suite *t __maybe_unused, int subtest __maybe_u
 	double val, num_cpus, num_cores, num_dies, num_packages;
 	int ret;
 	struct expr_parse_ctx *ctx;
+	bool is_intel = false;
+	char buf[128];
+
+	if (!get_cpuid(buf, sizeof(buf)))
+		is_intel = strstr(buf, "Intel") != NULL;
 
 	TEST_ASSERT_EQUAL("ids_union", test_ids_union(), 0);
 
@@ -175,6 +182,12 @@ static int test__expr(struct test_suite *t __maybe_unused, int subtest __maybe_u
 	if (num_dies) // Some platforms do not have CPU die support, for example s390
 		TEST_ASSERT_VAL("#num_dies >= #num_packages", num_dies >= num_packages);
 
+	TEST_ASSERT_VAL("#system_tsc_freq", expr__parse(&val, ctx, "#system_tsc_freq") == 0);
+	if (is_intel)
+		TEST_ASSERT_VAL("#system_tsc_freq > 0", val > 0);
+	else
+		TEST_ASSERT_VAL("#system_tsc_freq == 0", fpclassify(val) == FP_ZERO);
+
 	/*
 	 * Source count returns the number of events aggregating in a leader
 	 * event including the leader. Check parsing yields an id.
-- 
2.37.0.170.g444d1eabd0-goog

