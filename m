Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 037D45A68BD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 18:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbiH3Qtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 12:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbiH3Qta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 12:49:30 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC831CCE1C
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 09:49:16 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-33dce8cae71so183004777b3.8
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 09:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=odHu9oIdvGG5Uqss/fdCBkUP/s7a3MyMjrudizWvuiM=;
        b=YqaB/84L6355lUp5qA3G0U1TjM6sLP6qlWRS90aHbw+JCID++v+ocFenvaXukcRZiz
         btEjNZ3jE5bZwwC20MfuhJ0MLicERf+azMwjwY04ynDTGtmg5phjXV82ZKYQVsHxcAlK
         eXyy9LBy3yWhKs2plbSsBL3wXLcsUv7i7zHgS5qnLEMQFItk6ifWkXsjklnQCf5Qx77k
         3dRPNSdqnHVtyCgNPMw7SdAxw01UnEZT8wfnsySTEtVw3M+H+GJZv5gWJf15zhGmtbhh
         S2P0WuabjciP8msWLGYRjgApvAMAzHiE/qeoolHc0Gug1fMjX+s5Pexz7YKxgw7VCVw0
         LWCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=odHu9oIdvGG5Uqss/fdCBkUP/s7a3MyMjrudizWvuiM=;
        b=3OrJTr3PZbRPuAoYloCcq8CPAADv/oRxg1TPLtlJ+wOV8FgmTngFcBmSDAMlW/Xnqs
         DaFW3uw8g00ww+q3xhTfLlEtuOkATGM09VbOIe0F/4wdCLNm0teh6hN/2K0Q2mnksSm0
         2SNraf3rNQ2muxSqcDiVuFUeqMZHkWVfU7FbSMCvEtXYC4KL/LynkjkDpxiyebWdfNtf
         t3a34ZDhiM+TEj77tGTemqVRCdVxVLlI5hycrfUcFWrh+4c6cxY8nQMkqkjQW9hfh+rI
         E7B3UCrXemiDV94bkHBhdDDUgBXU0Cal5wJ3BF0JOcJAgcSceEtRO/teoOva9hMYggxH
         r0pg==
X-Gm-Message-State: ACgBeo2hK0CGNnQGrfOaauD9i3rUtKHe1eT4Fkk7AcjaEvdJkNMGvAe+
        CBqLqV0k7vzUiO2fuhvXIjW5S3DB9Y1W
X-Google-Smtp-Source: AA6agR7X9hKxwDIGVbB6qPRnX3EOKZxMUd5dAbThYH3DDmSTRtjl079C74XG6sfYzgdS/gfe7Y0MmIGx06Ik
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:902c:b0fa:dec9:8767])
 (user=irogers job=sendgmr) by 2002:a25:4110:0:b0:696:4e11:3b9 with SMTP id
 o16-20020a254110000000b006964e1103b9mr11849466yba.287.1661878156138; Tue, 30
 Aug 2022 09:49:16 -0700 (PDT)
Date:   Tue, 30 Aug 2022 09:48:41 -0700
In-Reply-To: <20220830164846.401143-1-irogers@google.com>
Message-Id: <20220830164846.401143-4-irogers@google.com>
Mime-Version: 1.0
References: <20220830164846.401143-1-irogers@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Subject: [PATCH v1 3/8] perf expr: Move the scanner_ctx into the parse_ctx
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
        kshipra.bopardikar@intel.com
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We currently maintain the two independently and copy from one to the
other. This is a burden when additional scanner context values are
necessary, so combine them.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/expr.c       |  2 +-
 tools/perf/util/expr.c        |  7 ++-----
 tools/perf/util/expr.h        | 10 +++++-----
 tools/perf/util/metricgroup.c |  4 ++--
 tools/perf/util/stat-shadow.c |  2 +-
 5 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
index 2efe9e3a63b8..7ca5e37de560 100644
--- a/tools/perf/tests/expr.c
+++ b/tools/perf/tests/expr.c
@@ -133,7 +133,7 @@ static int test__expr(struct test_suite *t __maybe_unused, int subtest __maybe_u
 						    (void **)&val_ptr));
 
 	expr__ctx_clear(ctx);
-	ctx->runtime = 3;
+	ctx->sctx.runtime = 3;
 	TEST_ASSERT_VAL("find ids",
 			expr__find_ids("EVENT1\\,param\\=?@ + EVENT2\\,param\\=?@",
 					NULL, ctx) == 0);
diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index c15a9852fa41..00bde682e743 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -310,7 +310,7 @@ struct expr_parse_ctx *expr__ctx_new(void)
 		free(ctx);
 		return NULL;
 	}
-	ctx->runtime = 0;
+	ctx->sctx.runtime = 0;
 
 	return ctx;
 }
@@ -344,16 +344,13 @@ static int
 __expr__parse(double *val, struct expr_parse_ctx *ctx, const char *expr,
 	      bool compute_ids)
 {
-	struct expr_scanner_ctx scanner_ctx = {
-		.runtime = ctx->runtime,
-	};
 	YY_BUFFER_STATE buffer;
 	void *scanner;
 	int ret;
 
 	pr_debug2("parsing metric: %s\n", expr);
 
-	ret = expr_lex_init_extra(&scanner_ctx, &scanner);
+	ret = expr_lex_init_extra(&ctx->sctx, &scanner);
 	if (ret)
 		return ret;
 
diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
index bd2116983bbb..de9b886ec49a 100644
--- a/tools/perf/util/expr.h
+++ b/tools/perf/util/expr.h
@@ -13,17 +13,17 @@
 
 struct metric_ref;
 
+struct expr_scanner_ctx {
+	int runtime;
+};
+
 struct expr_parse_ctx {
 	struct hashmap	*ids;
-	int runtime;
+	struct expr_scanner_ctx sctx;
 };
 
 struct expr_id_data;
 
-struct expr_scanner_ctx {
-	int runtime;
-};
-
 struct hashmap *ids__new(void);
 void ids__free(struct hashmap *ids);
 int ids__insert(struct hashmap *ids, const char *id);
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 18aae040d61d..b144c3e35264 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -215,7 +215,7 @@ static struct metric *metric__new(const struct pmu_event *pe,
 	}
 	m->metric_expr = pe->metric_expr;
 	m->metric_unit = pe->unit;
-	m->pctx->runtime = runtime;
+	m->pctx->sctx.runtime = runtime;
 	m->has_constraint = metric_no_group || metricgroup__has_constraint(pe);
 	m->metric_refs = NULL;
 	m->evlist = NULL;
@@ -1626,7 +1626,7 @@ static int parse_groups(struct evlist *perf_evlist, const char *str,
 		}
 		expr->metric_unit = m->metric_unit;
 		expr->metric_events = metric_events;
-		expr->runtime = m->pctx->runtime;
+		expr->runtime = m->pctx->sctx.runtime;
 		list_add(&expr->nd, &me->head);
 	}
 
diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 979c8cb918f7..1439acd109db 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -911,7 +911,7 @@ static void generic_metric(struct perf_stat_config *config,
 	if (!pctx)
 		return;
 
-	pctx->runtime = runtime;
+	pctx->sctx.runtime = runtime;
 	i = prepare_metric(metric_events, metric_refs, pctx, cpu_map_idx, st);
 	if (i < 0) {
 		expr__ctx_free(pctx);
-- 
2.37.2.672.g94769d06f0-goog

