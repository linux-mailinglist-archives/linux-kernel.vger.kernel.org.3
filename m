Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F10F15A84B9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 19:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbiHaRu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 13:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232083AbiHaRt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 13:49:59 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93FC0B855
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 10:49:57 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-340862314d9so193440717b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 10:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=wtl4vnbRhxSt4fzqjQ6Yyk9PkVxZDiLFY2fpaAc2xnQ=;
        b=J6De3RCXPZEOmej3SLXKpHVWB7FO5hMxNSX1Vx1yk+O5hHKG//kmTkSnWsj1Uf5Ell
         4LwyLDiG21bWpiwFjGWdS4UlOyNnqEAVyr5BUorkIVM0FsckVz159KX1xXM3RFEJMmtn
         HvUqItji0UtSCkYHrKosvMUYJCIEcbhja0k2PphSFcMyRYTmVFc+L/OiL92leRzsQQ8k
         geKHes1DuxiCvYHX9X8DoClZtHqMpC8hPnISgZv+1NRARuYsuWzi2rfFPFTo1Pcxu8KH
         fcfQMdyK8UYPMgBr4WK66ERDajdZTNprwTCdr+7jOBkAbtgDxpkiP2bxBX8CoZg/Sj37
         wo0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=wtl4vnbRhxSt4fzqjQ6Yyk9PkVxZDiLFY2fpaAc2xnQ=;
        b=O+5qojYyCmk0xakt1BwoetHh9kWj7CSfUqvWpglUgCd/EcFxlBd3633EsFaPErKu8s
         CQfjtkpnwiOp+vRbDCJ9/hSd6aOlST1W/XLnM/Gi0gkk9tIv0bAIc1BaQtCkDr2z8BxV
         Ks1E8A76bXtTKlZC63MfZsMGKK5IzMwoYFLv73vhWlwvag5PS1ReEaP/9ztCxzOaHDhW
         Aln5vr506G1AUEtrFDPfrY1p7pEMR8xwrWkTwHdqb0DUzZLEczPVBMCgju8loXyMNj6l
         zCW110iDWf0MEuVFQKez6YPiuw92UFsUpph9ctr0/wtWmYur0LxZlkdNO0a3h1N3RaZO
         gQnQ==
X-Gm-Message-State: ACgBeo3RijjGAk8iDIpwZ4KqygptuHLwiKA6BfongVMQD3G+3kVB9l7E
        76aRGw9UUerX+d/ymiqg5RjZWcQjKFSB
X-Google-Smtp-Source: AA6agR5A8muvj1BDAfXKm4+hw5Etoyyqggm9NFRlMECR8Lz3xmrHKLWn+ZMaJqPumek/NZ18Emb6rugLNPwp
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c8e4:a3e5:9d09:d3d4])
 (user=irogers job=sendgmr) by 2002:a81:b601:0:b0:340:d1e7:b213 with SMTP id
 u1-20020a81b601000000b00340d1e7b213mr16197476ywh.392.1661968196525; Wed, 31
 Aug 2022 10:49:56 -0700 (PDT)
Date:   Wed, 31 Aug 2022 10:49:21 -0700
In-Reply-To: <20220831174926.579643-1-irogers@google.com>
Message-Id: <20220831174926.579643-3-irogers@google.com>
Mime-Version: 1.0
References: <20220831174926.579643-1-irogers@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Subject: [PATCH v2 2/7] perf expr: Move the scanner_ctx into the parse_ctx
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
index 0403a92d9dcc..07af3d438eb2 100644
--- a/tools/perf/util/expr.h
+++ b/tools/perf/util/expr.h
@@ -10,17 +10,17 @@
 
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
index 788ce5e46470..815af948abb9 100644
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

