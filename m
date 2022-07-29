Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF8DF584CD5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 09:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235331AbiG2HpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 03:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235062AbiG2Hom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 03:44:42 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F42820D5
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 00:44:33 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-31f5668674cso36295857b3.8
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 00:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1Fnwkxe00fzii+/AdoCdigiKOH/6tox9V/XrXmPYCso=;
        b=KYiw9jpWBj6G9TItyX5toEX3s7SmRCn3h0SsaT9E5DY3Eeb7n+mbNqbpvCOqpDk5Mt
         DlxxHR8Oftf3ajn7jgtyfT1OYbIjtdkln/z2Ll8LF7AVkCsqsabrRzOV9yzh9frJo2Rt
         /OM5FyBERW9J9pz8+Hv0dAqRIvTatVBtfOOvGqIJnNeFzOyK54JZQOxLlhPgR1KxQSsx
         fnlf6A+lKKopZgQ9LTC9dBMrcXnV1ZGS/8DbX6IcQbdprU0hU85XOgJuxVYY3DXAL/qz
         Vr23ZMuq2pwROKS+bRSb4P+Q5BHCrCBtJOaAeaC2+mex2FPAtW+tfQQecSNzkvD78uiF
         +EKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1Fnwkxe00fzii+/AdoCdigiKOH/6tox9V/XrXmPYCso=;
        b=hW7KTkTIuvmTThrC1nVC2TtxgmZCUHkQkkLdxD3BUUryQL6FcG18J1P+ABB0kIev9q
         Y1PtI+pC9OpSfjORcrYBAfCHk4zMq59B/9E+WFDo2Yvmm3LxYdwhHwz/ajjU2A3mI4Ht
         PdHsjyhUFdo+1ihCEmdTm/bvYkmsIXYjvGkjUAmbIuI9XFJZRruJHaO+7F7AIe8kDJm0
         ptqoZfaG6oljHLBUYcT0wMz7wlVlyxX7yVpdmIdqWd9WmegcBzSfEjw0zw9UwTx7dzqz
         jlQ1C4lxIlxl5eqMsUwoYg+bU8bJYim+ZVZaHfrfkrlMB59T9plpu2hWS0mc9LpC0TmZ
         NH1g==
X-Gm-Message-State: ACgBeo2Ge7CTI6Q/BVmDa1Jj2FGgsQnE/A4NqJooYWYPe1cy4V49M8Hv
        Rhzov6T2bHYwzkzk+Xj2zbwBz+Vsd9wZ
X-Google-Smtp-Source: AA6agR4LYFC6eDgwM7HD1rQOkSGD5tFgKlNRIBx/0KWnLUZpogsWNMU6BPKOQadFEP95olksrb3ofYrq4Bey
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:524b:47b4:2aeb:1b49])
 (user=irogers job=sendgmr) by 2002:a05:6902:150c:b0:670:af5c:c431 with SMTP
 id q12-20020a056902150c00b00670af5cc431mr1659343ybu.37.1659080672858; Fri, 29
 Jul 2022 00:44:32 -0700 (PDT)
Date:   Fri, 29 Jul 2022 00:43:46 -0700
In-Reply-To: <20220729074351.138260-1-irogers@google.com>
Message-Id: <20220729074351.138260-13-irogers@google.com>
Mime-Version: 1.0
References: <20220729074351.138260-1-irogers@google.com>
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
Subject: [PATCH v3 12/17] perf pmu-events: Move test events/metrics to json
From:   Ian Rogers <irogers@google.com>
To:     John Garry <john.garry@huawei.com>, Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move arrays of pmu_events into the json code so that it may be
regenerated and modified by the jevents.py script.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/test/test_soc/cpu/metrics.json       | 64 +++++++++++++++++
 tools/perf/pmu-events/empty-pmu-events.c      | 64 +++++++++++++++++
 tools/perf/tests/expand-cgroup.c              | 17 +----
 tools/perf/tests/parse-metric.c               | 68 +------------------
 4 files changed, 132 insertions(+), 81 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/test/test_soc/cpu/metrics.json

diff --git a/tools/perf/pmu-events/arch/test/test_soc/cpu/metrics.json b/tools/perf/pmu-events/arch/test/test_soc/cpu/metrics.json
new file mode 100644
index 000000000000..42d9b5242fd7
--- /dev/null
+++ b/tools/perf/pmu-events/arch/test/test_soc/cpu/metrics.json
@@ -0,0 +1,64 @@
+[
+  {
+    "MetricExpr": "1 / IPC",
+    "MetricName": "CPI"
+  },
+  {
+    "MetricExpr": "inst_retired.any / cpu_clk_unhalted.thread",
+    "MetricName": "IPC",
+    "MetricGroup": "group1"
+  },
+  {
+    "MetricExpr": "idq_uops_not_delivered.core / (4 * (( ( cpu_clk_unhalted.thread / 2 ) * ( 1 + cpu_clk_unhalted.one_thread_active / cpu_clk_unhalted.ref_xclk ) )))",
+    "MetricName": "Frontend_Bound_SMT"
+  },
+  {
+    "MetricExpr": "l1d\\-loads\\-misses / inst_retired.any",
+    "MetricName": "dcache_miss_cpi"
+  },
+  {
+    "MetricExpr": "l1i\\-loads\\-misses / inst_retired.any",
+    "MetricName": "icache_miss_cycles"
+  },
+  {
+    "MetricExpr": "(dcache_miss_cpi + icache_miss_cycles)",
+    "MetricName": "cache_miss_cycles",
+    "MetricGroup": "group1"
+  },
+  {
+    "MetricExpr": "l2_rqsts.demand_data_rd_hit + l2_rqsts.pf_hit + l2_rqsts.rfo_hit",
+    "MetricName": "DCache_L2_All_Hits"
+  },
+  {
+    "MetricExpr": "max(l2_rqsts.all_demand_data_rd - l2_rqsts.demand_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqsts.rfo_miss",
+    "MetricName": "DCache_L2_All_Miss"
+  },
+  {
+    "MetricExpr": "dcache_l2_all_hits + dcache_l2_all_miss",
+    "MetricName": "DCache_L2_All"
+  },
+  {
+    "MetricExpr": "d_ratio(dcache_l2_all_hits, dcache_l2_all)",
+    "MetricName": "DCache_L2_Hits"
+  },
+  {
+    "MetricExpr": "d_ratio(dcache_l2_all_miss, dcache_l2_all)",
+    "MetricName": "DCache_L2_Misses"
+  },
+  {
+    "MetricExpr": "ipc + M2",
+    "MetricName": "M1"
+  },
+  {
+    "MetricExpr": "ipc + M1",
+    "MetricName": "M2"
+  },
+  {
+    "MetricExpr": "1/M3",
+    "MetricName": "M3"
+  },
+  {
+    "MetricExpr": "64 * l1d.replacement / 1000000000 / duration_time",
+    "MetricName": "L1D_Cache_Fill_BW"
+  }
+]
diff --git a/tools/perf/pmu-events/empty-pmu-events.c b/tools/perf/pmu-events/empty-pmu-events.c
index 8ef75aff996c..028f44efe48d 100644
--- a/tools/perf/pmu-events/empty-pmu-events.c
+++ b/tools/perf/pmu-events/empty-pmu-events.c
@@ -105,6 +105,70 @@ static const struct pmu_event pme_test_soc_cpu[] = {
 		.desc = "L2 BTB Correction",
 		.topic = "branch",
 	},
+	{
+		.metric_expr	= "1 / IPC",
+		.metric_name	= "CPI",
+	},
+	{
+		.metric_expr	= "inst_retired.any / cpu_clk_unhalted.thread",
+		.metric_name	= "IPC",
+		.metric_group	= "group1",
+	},
+	{
+		.metric_expr	= "idq_uops_not_delivered.core / (4 * (( ( cpu_clk_unhalted.thread / 2 ) * "
+		"( 1 + cpu_clk_unhalted.one_thread_active / cpu_clk_unhalted.ref_xclk ) )))",
+		.metric_name	= "Frontend_Bound_SMT",
+	},
+	{
+		.metric_expr	= "l1d\\-loads\\-misses / inst_retired.any",
+		.metric_name	= "dcache_miss_cpi",
+	},
+	{
+		.metric_expr	= "l1i\\-loads\\-misses / inst_retired.any",
+		.metric_name	= "icache_miss_cycles",
+	},
+	{
+		.metric_expr	= "(dcache_miss_cpi + icache_miss_cycles)",
+		.metric_name	= "cache_miss_cycles",
+		.metric_group	= "group1",
+	},
+	{
+		.metric_expr	= "l2_rqsts.demand_data_rd_hit + l2_rqsts.pf_hit + l2_rqsts.rfo_hit",
+		.metric_name	= "DCache_L2_All_Hits",
+	},
+	{
+		.metric_expr	= "max(l2_rqsts.all_demand_data_rd - l2_rqsts.demand_data_rd_hit, 0) + "
+		"l2_rqsts.pf_miss + l2_rqsts.rfo_miss",
+		.metric_name	= "DCache_L2_All_Miss",
+	},
+	{
+		.metric_expr	= "dcache_l2_all_hits + dcache_l2_all_miss",
+		.metric_name	= "DCache_L2_All",
+	},
+	{
+		.metric_expr	= "d_ratio(dcache_l2_all_hits, dcache_l2_all)",
+		.metric_name	= "DCache_L2_Hits",
+	},
+	{
+		.metric_expr	= "d_ratio(dcache_l2_all_miss, dcache_l2_all)",
+		.metric_name	= "DCache_L2_Misses",
+	},
+	{
+		.metric_expr	= "ipc + M2",
+		.metric_name	= "M1",
+	},
+	{
+		.metric_expr	= "ipc + M1",
+		.metric_name	= "M2",
+	},
+	{
+		.metric_expr	= "1/M3",
+		.metric_name	= "M3",
+	},
+	{
+		.metric_expr	= "64 * l1d.replacement / 1000000000 / duration_time",
+		.metric_name	= "L1D_Cache_Fill_BW",
+	},
 	{
 		.name = 0,
 		.event = 0,
diff --git a/tools/perf/tests/expand-cgroup.c b/tools/perf/tests/expand-cgroup.c
index 411fc578e5a4..e79ee8621a90 100644
--- a/tools/perf/tests/expand-cgroup.c
+++ b/tools/perf/tests/expand-cgroup.c
@@ -180,26 +180,13 @@ static int expand_metric_events(void)
 	struct evlist *evlist;
 	struct rblist metric_events;
 	const char metric_str[] = "CPI";
-
-	struct pmu_event pme_test[] = {
-		{
-			.metric_expr	= "instructions / cycles",
-			.metric_name	= "IPC",
-		},
-		{
-			.metric_expr	= "1 / IPC",
-			.metric_name	= "CPI",
-		},
-		{
-			.metric_expr	= NULL,
-			.metric_name	= NULL,
-		},
-	};
+	const struct pmu_event *pme_test;
 
 	evlist = evlist__new();
 	TEST_ASSERT_VAL("failed to get evlist", evlist);
 
 	rblist__init(&metric_events);
+	pme_test = find_core_events_table("testarch", "testcpu");
 	ret = metricgroup__parse_groups_test(evlist, pme_test, metric_str,
 					     false, false, &metric_events);
 	if (ret < 0) {
diff --git a/tools/perf/tests/parse-metric.c b/tools/perf/tests/parse-metric.c
index 7aebde7c37ec..30c7091857b8 100644
--- a/tools/perf/tests/parse-metric.c
+++ b/tools/perf/tests/parse-metric.c
@@ -13,72 +13,6 @@
 #include "stat.h"
 #include "pmu.h"
 
-static struct pmu_event pme_test[] = {
-{
-	.metric_expr	= "inst_retired.any / cpu_clk_unhalted.thread",
-	.metric_name	= "IPC",
-	.metric_group	= "group1",
-},
-{
-	.metric_expr	= "idq_uops_not_delivered.core / (4 * (( ( cpu_clk_unhalted.thread / 2 ) * "
-			  "( 1 + cpu_clk_unhalted.one_thread_active / cpu_clk_unhalted.ref_xclk ) )))",
-	.metric_name	= "Frontend_Bound_SMT",
-},
-{
-	.metric_expr	= "l1d\\-loads\\-misses / inst_retired.any",
-	.metric_name	= "dcache_miss_cpi",
-},
-{
-	.metric_expr	= "l1i\\-loads\\-misses / inst_retired.any",
-	.metric_name	= "icache_miss_cycles",
-},
-{
-	.metric_expr	= "(dcache_miss_cpi + icache_miss_cycles)",
-	.metric_name	= "cache_miss_cycles",
-	.metric_group	= "group1",
-},
-{
-	.metric_expr	= "l2_rqsts.demand_data_rd_hit + l2_rqsts.pf_hit + l2_rqsts.rfo_hit",
-	.metric_name	= "DCache_L2_All_Hits",
-},
-{
-	.metric_expr	= "max(l2_rqsts.all_demand_data_rd - l2_rqsts.demand_data_rd_hit, 0) + "
-			  "l2_rqsts.pf_miss + l2_rqsts.rfo_miss",
-	.metric_name	= "DCache_L2_All_Miss",
-},
-{
-	.metric_expr	= "dcache_l2_all_hits + dcache_l2_all_miss",
-	.metric_name	= "DCache_L2_All",
-},
-{
-	.metric_expr	= "d_ratio(dcache_l2_all_hits, dcache_l2_all)",
-	.metric_name	= "DCache_L2_Hits",
-},
-{
-	.metric_expr	= "d_ratio(dcache_l2_all_miss, dcache_l2_all)",
-	.metric_name	= "DCache_L2_Misses",
-},
-{
-	.metric_expr	= "ipc + m2",
-	.metric_name	= "M1",
-},
-{
-	.metric_expr	= "ipc + m1",
-	.metric_name	= "M2",
-},
-{
-	.metric_expr	= "1/m3",
-	.metric_name	= "M3",
-},
-{
-	.metric_expr	= "64 * l1d.replacement / 1000000000 / duration_time",
-	.metric_name	= "L1D_Cache_Fill_BW",
-},
-{
-	.name	= NULL,
-}
-};
-
 struct value {
 	const char	*event;
 	u64		 val;
@@ -138,6 +72,7 @@ static int __compute_metric(const char *name, struct value *vals,
 	struct rblist metric_events = {
 		.nr_entries = 0,
 	};
+	const struct pmu_event *pme_test;
 	struct perf_cpu_map *cpus;
 	struct runtime_stat st;
 	struct evlist *evlist;
@@ -161,6 +96,7 @@ static int __compute_metric(const char *name, struct value *vals,
 	runtime_stat__init(&st);
 
 	/* Parse the metric into metric_events list. */
+	pme_test = find_core_events_table("testarch", "testcpu");
 	err = metricgroup__parse_groups_test(evlist, pme_test, name,
 					     false, false,
 					     &metric_events);
-- 
2.37.1.455.g008518b4e5-goog

