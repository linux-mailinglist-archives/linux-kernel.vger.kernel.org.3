Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14A9D484E3D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 07:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232552AbiAEGRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 01:17:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237699AbiAEGQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 01:16:02 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E784BC0698C7
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 22:15:42 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id d5-20020a25be45000000b0060fdc206836so11911024ybm.21
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 22:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4F7qH0ZBCFSqGz+2YAmykAzgrCxPY0T/2XHaaXFr9fE=;
        b=SVg/+WQjwhdh7qInvfMMntOwamVJUJB/zBJXdLyaARH1OBjq9RE0oiGVxToLzZX9dZ
         o4ny+G46mRoS0S3ofwO7ts9+haDyhfPr5jfjUjkMH64363YUhbDejvvg24q2/Rh+M8cP
         twKQh3SFiYsZB5yDShggv3nQ2oA/CH/LPwfKsUco8Ue+B5WRDxfir+QN/s/mVMKEG3kl
         CnmYDzQIK6GoQV3znbPExdmdbS+irtDQ6xB7p8JdXYz6PEuwikIGWDEQlx/iskTW5LRV
         aj+c3u8ALPN3MmghmXAT6PQvGIBPbs1f0n9ApjQrMp5qGxtUKWEY1cHG43PQYdQeQt/B
         Q4bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4F7qH0ZBCFSqGz+2YAmykAzgrCxPY0T/2XHaaXFr9fE=;
        b=bvi8C8xim6NhLsWMhcBqVGcXc1LmZRUoaEdehaBnxsZ+88jBkE6237rpLtpwFyTHFa
         abUUd25fKlt0mAgm2pG4S21LgRgjqSClbKh1WPzQF++S0iAmrkmf25HMJrxC94c7koWT
         srqXuOrdCDAyn8Du3hhDBz9pQHbsh3zgdEKRnKfb6sfqq7r2pxpS5lTe1RYxf+MNeprW
         yAqtnLXztw7AlMU3iqk/cX3yuX9JZxKmMNajJOlJAr/BJdNOig9CDGqTFdLLiOMN0gKE
         VXrGS2JNly9Cot8HqFNwqMTOdmAnZ9XbmTkbC4soGQ3Q1jNOuFHlHdZI4a4mJDj+5dqn
         HeMg==
X-Gm-Message-State: AOAM533idhAeTCLtht/WYiDYzB4An2aTdnGxt85Lw8Fwl5eoFoNmUGRh
        KpAwNWWI5GmJMc8EUTZpDG8gwP5z8P+Y
X-Google-Smtp-Source: ABdhPJwiy2kkObp0fWxM6PQQ10XW0Rwd6ONNag3pv31OvyiToCpFo7jEYTU6wZTddHPDLzGqUAuH+ZqZagrZ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:3af1:caef:2937:5d2b])
 (user=irogers job=sendgmr) by 2002:a25:4153:: with SMTP id
 o80mr57559331yba.147.1641363342170; Tue, 04 Jan 2022 22:15:42 -0800 (PST)
Date:   Tue,  4 Jan 2022 22:13:45 -0800
In-Reply-To: <20220105061351.120843-1-irogers@google.com>
Message-Id: <20220105061351.120843-43-irogers@google.com>
Mime-Version: 1.0
References: <20220105061351.120843-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v4 42/48] perf stat: Swap variable name cpu to index
From:   Ian Rogers <irogers@google.com>
To:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vineet Singh <vineet.singh@intel.com>,
        James Clark <james.clark@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, zhengjun.xing@intel.com
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The use of CPU is error prone, switch to cpu_map_idx.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/stat-shadow.c | 308 +++++++++++++++++-----------------
 tools/perf/util/stat.c        |  16 +-
 tools/perf/util/stat.h        |   4 +-
 3 files changed, 164 insertions(+), 164 deletions(-)

diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 5c7308efa768..10af7804e482 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -32,7 +32,7 @@ struct saved_value {
 	struct evsel *evsel;
 	enum stat_type type;
 	int ctx;
-	int cpu;
+	int cpu_map_idx;
 	struct cgroup *cgrp;
 	struct runtime_stat *stat;
 	struct stats stats;
@@ -47,8 +47,8 @@ static int saved_value_cmp(struct rb_node *rb_node, const void *entry)
 					     rb_node);
 	const struct saved_value *b = entry;
 
-	if (a->cpu != b->cpu)
-		return a->cpu - b->cpu;
+	if (a->cpu_map_idx != b->cpu_map_idx)
+		return a->cpu_map_idx - b->cpu_map_idx;
 
 	/*
 	 * Previously the rbtree was used to link generic metrics.
@@ -105,7 +105,7 @@ static void saved_value_delete(struct rblist *rblist __maybe_unused,
 }
 
 static struct saved_value *saved_value_lookup(struct evsel *evsel,
-					      int cpu,
+					      int cpu_map_idx,
 					      bool create,
 					      enum stat_type type,
 					      int ctx,
@@ -115,7 +115,7 @@ static struct saved_value *saved_value_lookup(struct evsel *evsel,
 	struct rblist *rblist;
 	struct rb_node *nd;
 	struct saved_value dm = {
-		.cpu = cpu,
+		.cpu_map_idx = cpu_map_idx,
 		.evsel = evsel,
 		.type = type,
 		.ctx = ctx,
@@ -213,10 +213,10 @@ struct runtime_stat_data {
 
 static void update_runtime_stat(struct runtime_stat *st,
 				enum stat_type type,
-				int cpu, u64 count,
+				int cpu_map_idx, u64 count,
 				struct runtime_stat_data *rsd)
 {
-	struct saved_value *v = saved_value_lookup(NULL, cpu, true, type,
+	struct saved_value *v = saved_value_lookup(NULL, cpu_map_idx, true, type,
 						   rsd->ctx, st, rsd->cgrp);
 
 	if (v)
@@ -229,7 +229,7 @@ static void update_runtime_stat(struct runtime_stat *st,
  * instruction rates, etc:
  */
 void perf_stat__update_shadow_stats(struct evsel *counter, u64 count,
-				    int cpu, struct runtime_stat *st)
+				    int cpu_map_idx, struct runtime_stat *st)
 {
 	u64 count_ns = count;
 	struct saved_value *v;
@@ -241,88 +241,88 @@ void perf_stat__update_shadow_stats(struct evsel *counter, u64 count,
 	count *= counter->scale;
 
 	if (evsel__is_clock(counter))
-		update_runtime_stat(st, STAT_NSECS, cpu, count_ns, &rsd);
+		update_runtime_stat(st, STAT_NSECS, cpu_map_idx, count_ns, &rsd);
 	else if (evsel__match(counter, HARDWARE, HW_CPU_CYCLES))
-		update_runtime_stat(st, STAT_CYCLES, cpu, count, &rsd);
+		update_runtime_stat(st, STAT_CYCLES, cpu_map_idx, count, &rsd);
 	else if (perf_stat_evsel__is(counter, CYCLES_IN_TX))
-		update_runtime_stat(st, STAT_CYCLES_IN_TX, cpu, count, &rsd);
+		update_runtime_stat(st, STAT_CYCLES_IN_TX, cpu_map_idx, count, &rsd);
 	else if (perf_stat_evsel__is(counter, TRANSACTION_START))
-		update_runtime_stat(st, STAT_TRANSACTION, cpu, count, &rsd);
+		update_runtime_stat(st, STAT_TRANSACTION, cpu_map_idx, count, &rsd);
 	else if (perf_stat_evsel__is(counter, ELISION_START))
-		update_runtime_stat(st, STAT_ELISION, cpu, count, &rsd);
+		update_runtime_stat(st, STAT_ELISION, cpu_map_idx, count, &rsd);
 	else if (perf_stat_evsel__is(counter, TOPDOWN_TOTAL_SLOTS))
 		update_runtime_stat(st, STAT_TOPDOWN_TOTAL_SLOTS,
-				    cpu, count, &rsd);
+				    cpu_map_idx, count, &rsd);
 	else if (perf_stat_evsel__is(counter, TOPDOWN_SLOTS_ISSUED))
 		update_runtime_stat(st, STAT_TOPDOWN_SLOTS_ISSUED,
-				    cpu, count, &rsd);
+				    cpu_map_idx, count, &rsd);
 	else if (perf_stat_evsel__is(counter, TOPDOWN_SLOTS_RETIRED))
 		update_runtime_stat(st, STAT_TOPDOWN_SLOTS_RETIRED,
-				    cpu, count, &rsd);
+				    cpu_map_idx, count, &rsd);
 	else if (perf_stat_evsel__is(counter, TOPDOWN_FETCH_BUBBLES))
 		update_runtime_stat(st, STAT_TOPDOWN_FETCH_BUBBLES,
-				    cpu, count, &rsd);
+				    cpu_map_idx, count, &rsd);
 	else if (perf_stat_evsel__is(counter, TOPDOWN_RECOVERY_BUBBLES))
 		update_runtime_stat(st, STAT_TOPDOWN_RECOVERY_BUBBLES,
-				    cpu, count, &rsd);
+				    cpu_map_idx, count, &rsd);
 	else if (perf_stat_evsel__is(counter, TOPDOWN_RETIRING))
 		update_runtime_stat(st, STAT_TOPDOWN_RETIRING,
-				    cpu, count, &rsd);
+				    cpu_map_idx, count, &rsd);
 	else if (perf_stat_evsel__is(counter, TOPDOWN_BAD_SPEC))
 		update_runtime_stat(st, STAT_TOPDOWN_BAD_SPEC,
-				    cpu, count, &rsd);
+				    cpu_map_idx, count, &rsd);
 	else if (perf_stat_evsel__is(counter, TOPDOWN_FE_BOUND))
 		update_runtime_stat(st, STAT_TOPDOWN_FE_BOUND,
-				    cpu, count, &rsd);
+				    cpu_map_idx, count, &rsd);
 	else if (perf_stat_evsel__is(counter, TOPDOWN_BE_BOUND))
 		update_runtime_stat(st, STAT_TOPDOWN_BE_BOUND,
-				    cpu, count, &rsd);
+				    cpu_map_idx, count, &rsd);
 	else if (perf_stat_evsel__is(counter, TOPDOWN_HEAVY_OPS))
 		update_runtime_stat(st, STAT_TOPDOWN_HEAVY_OPS,
-				    cpu, count, &rsd);
+				    cpu_map_idx, count, &rsd);
 	else if (perf_stat_evsel__is(counter, TOPDOWN_BR_MISPREDICT))
 		update_runtime_stat(st, STAT_TOPDOWN_BR_MISPREDICT,
-				    cpu, count, &rsd);
+				    cpu_map_idx, count, &rsd);
 	else if (perf_stat_evsel__is(counter, TOPDOWN_FETCH_LAT))
 		update_runtime_stat(st, STAT_TOPDOWN_FETCH_LAT,
-				    cpu, count, &rsd);
+				    cpu_map_idx, count, &rsd);
 	else if (perf_stat_evsel__is(counter, TOPDOWN_MEM_BOUND))
 		update_runtime_stat(st, STAT_TOPDOWN_MEM_BOUND,
-				    cpu, count, &rsd);
+				    cpu_map_idx, count, &rsd);
 	else if (evsel__match(counter, HARDWARE, HW_STALLED_CYCLES_FRONTEND))
 		update_runtime_stat(st, STAT_STALLED_CYCLES_FRONT,
-				    cpu, count, &rsd);
+				    cpu_map_idx, count, &rsd);
 	else if (evsel__match(counter, HARDWARE, HW_STALLED_CYCLES_BACKEND))
 		update_runtime_stat(st, STAT_STALLED_CYCLES_BACK,
-				    cpu, count, &rsd);
+				    cpu_map_idx, count, &rsd);
 	else if (evsel__match(counter, HARDWARE, HW_BRANCH_INSTRUCTIONS))
-		update_runtime_stat(st, STAT_BRANCHES, cpu, count, &rsd);
+		update_runtime_stat(st, STAT_BRANCHES, cpu_map_idx, count, &rsd);
 	else if (evsel__match(counter, HARDWARE, HW_CACHE_REFERENCES))
-		update_runtime_stat(st, STAT_CACHEREFS, cpu, count, &rsd);
+		update_runtime_stat(st, STAT_CACHEREFS, cpu_map_idx, count, &rsd);
 	else if (evsel__match(counter, HW_CACHE, HW_CACHE_L1D))
-		update_runtime_stat(st, STAT_L1_DCACHE, cpu, count, &rsd);
+		update_runtime_stat(st, STAT_L1_DCACHE, cpu_map_idx, count, &rsd);
 	else if (evsel__match(counter, HW_CACHE, HW_CACHE_L1I))
-		update_runtime_stat(st, STAT_L1_ICACHE, cpu, count, &rsd);
+		update_runtime_stat(st, STAT_L1_ICACHE, cpu_map_idx, count, &rsd);
 	else if (evsel__match(counter, HW_CACHE, HW_CACHE_LL))
-		update_runtime_stat(st, STAT_LL_CACHE, cpu, count, &rsd);
+		update_runtime_stat(st, STAT_LL_CACHE, cpu_map_idx, count, &rsd);
 	else if (evsel__match(counter, HW_CACHE, HW_CACHE_DTLB))
-		update_runtime_stat(st, STAT_DTLB_CACHE, cpu, count, &rsd);
+		update_runtime_stat(st, STAT_DTLB_CACHE, cpu_map_idx, count, &rsd);
 	else if (evsel__match(counter, HW_CACHE, HW_CACHE_ITLB))
-		update_runtime_stat(st, STAT_ITLB_CACHE, cpu, count, &rsd);
+		update_runtime_stat(st, STAT_ITLB_CACHE, cpu_map_idx, count, &rsd);
 	else if (perf_stat_evsel__is(counter, SMI_NUM))
-		update_runtime_stat(st, STAT_SMI_NUM, cpu, count, &rsd);
+		update_runtime_stat(st, STAT_SMI_NUM, cpu_map_idx, count, &rsd);
 	else if (perf_stat_evsel__is(counter, APERF))
-		update_runtime_stat(st, STAT_APERF, cpu, count, &rsd);
+		update_runtime_stat(st, STAT_APERF, cpu_map_idx, count, &rsd);
 
 	if (counter->collect_stat) {
-		v = saved_value_lookup(counter, cpu, true, STAT_NONE, 0, st,
+		v = saved_value_lookup(counter, cpu_map_idx, true, STAT_NONE, 0, st,
 				       rsd.cgrp);
 		update_stats(&v->stats, count);
 		if (counter->metric_leader)
 			v->metric_total += count;
 	} else if (counter->metric_leader) {
 		v = saved_value_lookup(counter->metric_leader,
-				       cpu, true, STAT_NONE, 0, st, rsd.cgrp);
+				       cpu_map_idx, true, STAT_NONE, 0, st, rsd.cgrp);
 		v->metric_total += count;
 		v->metric_other++;
 	}
@@ -464,12 +464,12 @@ void perf_stat__collect_metric_expr(struct evlist *evsel_list)
 }
 
 static double runtime_stat_avg(struct runtime_stat *st,
-			       enum stat_type type, int cpu,
+			       enum stat_type type, int cpu_map_idx,
 			       struct runtime_stat_data *rsd)
 {
 	struct saved_value *v;
 
-	v = saved_value_lookup(NULL, cpu, false, type, rsd->ctx, st, rsd->cgrp);
+	v = saved_value_lookup(NULL, cpu_map_idx, false, type, rsd->ctx, st, rsd->cgrp);
 	if (!v)
 		return 0.0;
 
@@ -477,12 +477,12 @@ static double runtime_stat_avg(struct runtime_stat *st,
 }
 
 static double runtime_stat_n(struct runtime_stat *st,
-			     enum stat_type type, int cpu,
+			     enum stat_type type, int cpu_map_idx,
 			     struct runtime_stat_data *rsd)
 {
 	struct saved_value *v;
 
-	v = saved_value_lookup(NULL, cpu, false, type, rsd->ctx, st, rsd->cgrp);
+	v = saved_value_lookup(NULL, cpu_map_idx, false, type, rsd->ctx, st, rsd->cgrp);
 	if (!v)
 		return 0.0;
 
@@ -490,7 +490,7 @@ static double runtime_stat_n(struct runtime_stat *st,
 }
 
 static void print_stalled_cycles_frontend(struct perf_stat_config *config,
-					  int cpu, double avg,
+					  int cpu_map_idx, double avg,
 					  struct perf_stat_output_ctx *out,
 					  struct runtime_stat *st,
 					  struct runtime_stat_data *rsd)
@@ -498,7 +498,7 @@ static void print_stalled_cycles_frontend(struct perf_stat_config *config,
 	double total, ratio = 0.0;
 	const char *color;
 
-	total = runtime_stat_avg(st, STAT_CYCLES, cpu, rsd);
+	total = runtime_stat_avg(st, STAT_CYCLES, cpu_map_idx, rsd);
 
 	if (total)
 		ratio = avg / total * 100.0;
@@ -513,7 +513,7 @@ static void print_stalled_cycles_frontend(struct perf_stat_config *config,
 }
 
 static void print_stalled_cycles_backend(struct perf_stat_config *config,
-					 int cpu, double avg,
+					 int cpu_map_idx, double avg,
 					 struct perf_stat_output_ctx *out,
 					 struct runtime_stat *st,
 					 struct runtime_stat_data *rsd)
@@ -521,7 +521,7 @@ static void print_stalled_cycles_backend(struct perf_stat_config *config,
 	double total, ratio = 0.0;
 	const char *color;
 
-	total = runtime_stat_avg(st, STAT_CYCLES, cpu, rsd);
+	total = runtime_stat_avg(st, STAT_CYCLES, cpu_map_idx, rsd);
 
 	if (total)
 		ratio = avg / total * 100.0;
@@ -532,7 +532,7 @@ static void print_stalled_cycles_backend(struct perf_stat_config *config,
 }
 
 static void print_branch_misses(struct perf_stat_config *config,
-				int cpu, double avg,
+				int cpu_map_idx, double avg,
 				struct perf_stat_output_ctx *out,
 				struct runtime_stat *st,
 				struct runtime_stat_data *rsd)
@@ -540,7 +540,7 @@ static void print_branch_misses(struct perf_stat_config *config,
 	double total, ratio = 0.0;
 	const char *color;
 
-	total = runtime_stat_avg(st, STAT_BRANCHES, cpu, rsd);
+	total = runtime_stat_avg(st, STAT_BRANCHES, cpu_map_idx, rsd);
 
 	if (total)
 		ratio = avg / total * 100.0;
@@ -551,7 +551,7 @@ static void print_branch_misses(struct perf_stat_config *config,
 }
 
 static void print_l1_dcache_misses(struct perf_stat_config *config,
-				   int cpu, double avg,
+				   int cpu_map_idx, double avg,
 				   struct perf_stat_output_ctx *out,
 				   struct runtime_stat *st,
 				   struct runtime_stat_data *rsd)
@@ -559,7 +559,7 @@ static void print_l1_dcache_misses(struct perf_stat_config *config,
 	double total, ratio = 0.0;
 	const char *color;
 
-	total = runtime_stat_avg(st, STAT_L1_DCACHE, cpu, rsd);
+	total = runtime_stat_avg(st, STAT_L1_DCACHE, cpu_map_idx, rsd);
 
 	if (total)
 		ratio = avg / total * 100.0;
@@ -570,7 +570,7 @@ static void print_l1_dcache_misses(struct perf_stat_config *config,
 }
 
 static void print_l1_icache_misses(struct perf_stat_config *config,
-				   int cpu, double avg,
+				   int cpu_map_idx, double avg,
 				   struct perf_stat_output_ctx *out,
 				   struct runtime_stat *st,
 				   struct runtime_stat_data *rsd)
@@ -578,7 +578,7 @@ static void print_l1_icache_misses(struct perf_stat_config *config,
 	double total, ratio = 0.0;
 	const char *color;
 
-	total = runtime_stat_avg(st, STAT_L1_ICACHE, cpu, rsd);
+	total = runtime_stat_avg(st, STAT_L1_ICACHE, cpu_map_idx, rsd);
 
 	if (total)
 		ratio = avg / total * 100.0;
@@ -588,7 +588,7 @@ static void print_l1_icache_misses(struct perf_stat_config *config,
 }
 
 static void print_dtlb_cache_misses(struct perf_stat_config *config,
-				    int cpu, double avg,
+				    int cpu_map_idx, double avg,
 				    struct perf_stat_output_ctx *out,
 				    struct runtime_stat *st,
 				    struct runtime_stat_data *rsd)
@@ -596,7 +596,7 @@ static void print_dtlb_cache_misses(struct perf_stat_config *config,
 	double total, ratio = 0.0;
 	const char *color;
 
-	total = runtime_stat_avg(st, STAT_DTLB_CACHE, cpu, rsd);
+	total = runtime_stat_avg(st, STAT_DTLB_CACHE, cpu_map_idx, rsd);
 
 	if (total)
 		ratio = avg / total * 100.0;
@@ -606,7 +606,7 @@ static void print_dtlb_cache_misses(struct perf_stat_config *config,
 }
 
 static void print_itlb_cache_misses(struct perf_stat_config *config,
-				    int cpu, double avg,
+				    int cpu_map_idx, double avg,
 				    struct perf_stat_output_ctx *out,
 				    struct runtime_stat *st,
 				    struct runtime_stat_data *rsd)
@@ -614,7 +614,7 @@ static void print_itlb_cache_misses(struct perf_stat_config *config,
 	double total, ratio = 0.0;
 	const char *color;
 
-	total = runtime_stat_avg(st, STAT_ITLB_CACHE, cpu, rsd);
+	total = runtime_stat_avg(st, STAT_ITLB_CACHE, cpu_map_idx, rsd);
 
 	if (total)
 		ratio = avg / total * 100.0;
@@ -624,7 +624,7 @@ static void print_itlb_cache_misses(struct perf_stat_config *config,
 }
 
 static void print_ll_cache_misses(struct perf_stat_config *config,
-				  int cpu, double avg,
+				  int cpu_map_idx, double avg,
 				  struct perf_stat_output_ctx *out,
 				  struct runtime_stat *st,
 				  struct runtime_stat_data *rsd)
@@ -632,7 +632,7 @@ static void print_ll_cache_misses(struct perf_stat_config *config,
 	double total, ratio = 0.0;
 	const char *color;
 
-	total = runtime_stat_avg(st, STAT_LL_CACHE, cpu, rsd);
+	total = runtime_stat_avg(st, STAT_LL_CACHE, cpu_map_idx, rsd);
 
 	if (total)
 		ratio = avg / total * 100.0;
@@ -690,61 +690,61 @@ static double sanitize_val(double x)
 	return x;
 }
 
-static double td_total_slots(int cpu, struct runtime_stat *st,
+static double td_total_slots(int cpu_map_idx, struct runtime_stat *st,
 			     struct runtime_stat_data *rsd)
 {
-	return runtime_stat_avg(st, STAT_TOPDOWN_TOTAL_SLOTS, cpu, rsd);
+	return runtime_stat_avg(st, STAT_TOPDOWN_TOTAL_SLOTS, cpu_map_idx, rsd);
 }
 
-static double td_bad_spec(int cpu, struct runtime_stat *st,
+static double td_bad_spec(int cpu_map_idx, struct runtime_stat *st,
 			  struct runtime_stat_data *rsd)
 {
 	double bad_spec = 0;
 	double total_slots;
 	double total;
 
-	total = runtime_stat_avg(st, STAT_TOPDOWN_SLOTS_ISSUED, cpu, rsd) -
-		runtime_stat_avg(st, STAT_TOPDOWN_SLOTS_RETIRED, cpu, rsd) +
-		runtime_stat_avg(st, STAT_TOPDOWN_RECOVERY_BUBBLES, cpu, rsd);
+	total = runtime_stat_avg(st, STAT_TOPDOWN_SLOTS_ISSUED, cpu_map_idx, rsd) -
+		runtime_stat_avg(st, STAT_TOPDOWN_SLOTS_RETIRED, cpu_map_idx, rsd) +
+		runtime_stat_avg(st, STAT_TOPDOWN_RECOVERY_BUBBLES, cpu_map_idx, rsd);
 
-	total_slots = td_total_slots(cpu, st, rsd);
+	total_slots = td_total_slots(cpu_map_idx, st, rsd);
 	if (total_slots)
 		bad_spec = total / total_slots;
 	return sanitize_val(bad_spec);
 }
 
-static double td_retiring(int cpu, struct runtime_stat *st,
+static double td_retiring(int cpu_map_idx, struct runtime_stat *st,
 			  struct runtime_stat_data *rsd)
 {
 	double retiring = 0;
-	double total_slots = td_total_slots(cpu, st, rsd);
+	double total_slots = td_total_slots(cpu_map_idx, st, rsd);
 	double ret_slots = runtime_stat_avg(st, STAT_TOPDOWN_SLOTS_RETIRED,
-					    cpu, rsd);
+					    cpu_map_idx, rsd);
 
 	if (total_slots)
 		retiring = ret_slots / total_slots;
 	return retiring;
 }
 
-static double td_fe_bound(int cpu, struct runtime_stat *st,
+static double td_fe_bound(int cpu_map_idx, struct runtime_stat *st,
 			  struct runtime_stat_data *rsd)
 {
 	double fe_bound = 0;
-	double total_slots = td_total_slots(cpu, st, rsd);
+	double total_slots = td_total_slots(cpu_map_idx, st, rsd);
 	double fetch_bub = runtime_stat_avg(st, STAT_TOPDOWN_FETCH_BUBBLES,
-					    cpu, rsd);
+					    cpu_map_idx, rsd);
 
 	if (total_slots)
 		fe_bound = fetch_bub / total_slots;
 	return fe_bound;
 }
 
-static double td_be_bound(int cpu, struct runtime_stat *st,
+static double td_be_bound(int cpu_map_idx, struct runtime_stat *st,
 			  struct runtime_stat_data *rsd)
 {
-	double sum = (td_fe_bound(cpu, st, rsd) +
-		      td_bad_spec(cpu, st, rsd) +
-		      td_retiring(cpu, st, rsd));
+	double sum = (td_fe_bound(cpu_map_idx, st, rsd) +
+		      td_bad_spec(cpu_map_idx, st, rsd) +
+		      td_retiring(cpu_map_idx, st, rsd));
 	if (sum == 0)
 		return 0;
 	return sanitize_val(1.0 - sum);
@@ -755,15 +755,15 @@ static double td_be_bound(int cpu, struct runtime_stat *st,
  * the ratios we need to recreate the sum.
  */
 
-static double td_metric_ratio(int cpu, enum stat_type type,
+static double td_metric_ratio(int cpu_map_idx, enum stat_type type,
 			      struct runtime_stat *stat,
 			      struct runtime_stat_data *rsd)
 {
-	double sum = runtime_stat_avg(stat, STAT_TOPDOWN_RETIRING, cpu, rsd) +
-		runtime_stat_avg(stat, STAT_TOPDOWN_FE_BOUND, cpu, rsd) +
-		runtime_stat_avg(stat, STAT_TOPDOWN_BE_BOUND, cpu, rsd) +
-		runtime_stat_avg(stat, STAT_TOPDOWN_BAD_SPEC, cpu, rsd);
-	double d = runtime_stat_avg(stat, type, cpu, rsd);
+	double sum = runtime_stat_avg(stat, STAT_TOPDOWN_RETIRING, cpu_map_idx, rsd) +
+		runtime_stat_avg(stat, STAT_TOPDOWN_FE_BOUND, cpu_map_idx, rsd) +
+		runtime_stat_avg(stat, STAT_TOPDOWN_BE_BOUND, cpu_map_idx, rsd) +
+		runtime_stat_avg(stat, STAT_TOPDOWN_BAD_SPEC, cpu_map_idx, rsd);
+	double d = runtime_stat_avg(stat, type, cpu_map_idx, rsd);
 
 	if (sum)
 		return d / sum;
@@ -775,23 +775,23 @@ static double td_metric_ratio(int cpu, enum stat_type type,
  * We allow two missing.
  */
 
-static bool full_td(int cpu, struct runtime_stat *stat,
+static bool full_td(int cpu_map_idx, struct runtime_stat *stat,
 		    struct runtime_stat_data *rsd)
 {
 	int c = 0;
 
-	if (runtime_stat_avg(stat, STAT_TOPDOWN_RETIRING, cpu, rsd) > 0)
+	if (runtime_stat_avg(stat, STAT_TOPDOWN_RETIRING, cpu_map_idx, rsd) > 0)
 		c++;
-	if (runtime_stat_avg(stat, STAT_TOPDOWN_BE_BOUND, cpu, rsd) > 0)
+	if (runtime_stat_avg(stat, STAT_TOPDOWN_BE_BOUND, cpu_map_idx, rsd) > 0)
 		c++;
-	if (runtime_stat_avg(stat, STAT_TOPDOWN_FE_BOUND, cpu, rsd) > 0)
+	if (runtime_stat_avg(stat, STAT_TOPDOWN_FE_BOUND, cpu_map_idx, rsd) > 0)
 		c++;
-	if (runtime_stat_avg(stat, STAT_TOPDOWN_BAD_SPEC, cpu, rsd) > 0)
+	if (runtime_stat_avg(stat, STAT_TOPDOWN_BAD_SPEC, cpu_map_idx, rsd) > 0)
 		c++;
 	return c >= 2;
 }
 
-static void print_smi_cost(struct perf_stat_config *config, int cpu,
+static void print_smi_cost(struct perf_stat_config *config, int cpu_map_idx,
 			   struct perf_stat_output_ctx *out,
 			   struct runtime_stat *st,
 			   struct runtime_stat_data *rsd)
@@ -799,9 +799,9 @@ static void print_smi_cost(struct perf_stat_config *config, int cpu,
 	double smi_num, aperf, cycles, cost = 0.0;
 	const char *color = NULL;
 
-	smi_num = runtime_stat_avg(st, STAT_SMI_NUM, cpu, rsd);
-	aperf = runtime_stat_avg(st, STAT_APERF, cpu, rsd);
-	cycles = runtime_stat_avg(st, STAT_CYCLES, cpu, rsd);
+	smi_num = runtime_stat_avg(st, STAT_SMI_NUM, cpu_map_idx, rsd);
+	aperf = runtime_stat_avg(st, STAT_APERF, cpu_map_idx, rsd);
+	cycles = runtime_stat_avg(st, STAT_CYCLES, cpu_map_idx, rsd);
 
 	if ((cycles == 0) || (aperf == 0))
 		return;
@@ -818,7 +818,7 @@ static void print_smi_cost(struct perf_stat_config *config, int cpu,
 static int prepare_metric(struct evsel **metric_events,
 			  struct metric_ref *metric_refs,
 			  struct expr_parse_ctx *pctx,
-			  int cpu,
+			  int cpu_map_idx,
 			  struct runtime_stat *st)
 {
 	double scale;
@@ -836,7 +836,7 @@ static int prepare_metric(struct evsel **metric_events,
 			scale = 1e-9;
 			source_count = 1;
 		} else {
-			v = saved_value_lookup(metric_events[i], cpu, false,
+			v = saved_value_lookup(metric_events[i], cpu_map_idx, false,
 					       STAT_NONE, 0, st,
 					       metric_events[i]->cgrp);
 			if (!v)
@@ -874,7 +874,7 @@ static void generic_metric(struct perf_stat_config *config,
 			   const char *metric_name,
 			   const char *metric_unit,
 			   int runtime,
-			   int cpu,
+			   int cpu_map_idx,
 			   struct perf_stat_output_ctx *out,
 			   struct runtime_stat *st)
 {
@@ -889,7 +889,7 @@ static void generic_metric(struct perf_stat_config *config,
 		return;
 
 	pctx->runtime = runtime;
-	i = prepare_metric(metric_events, metric_refs, pctx, cpu, st);
+	i = prepare_metric(metric_events, metric_refs, pctx, cpu_map_idx, st);
 	if (i < 0) {
 		expr__ctx_free(pctx);
 		return;
@@ -934,7 +934,7 @@ static void generic_metric(struct perf_stat_config *config,
 	expr__ctx_free(pctx);
 }
 
-double test_generic_metric(struct metric_expr *mexp, int cpu, struct runtime_stat *st)
+double test_generic_metric(struct metric_expr *mexp, int cpu_map_idx, struct runtime_stat *st)
 {
 	struct expr_parse_ctx *pctx;
 	double ratio = 0.0;
@@ -943,7 +943,7 @@ double test_generic_metric(struct metric_expr *mexp, int cpu, struct runtime_sta
 	if (!pctx)
 		return NAN;
 
-	if (prepare_metric(mexp->metric_events, mexp->metric_refs, pctx, cpu, st) < 0)
+	if (prepare_metric(mexp->metric_events, mexp->metric_refs, pctx, cpu_map_idx, st) < 0)
 		goto out;
 
 	if (expr__parse(&ratio, pctx, mexp->metric_expr))
@@ -956,7 +956,7 @@ double test_generic_metric(struct metric_expr *mexp, int cpu, struct runtime_sta
 
 void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 				   struct evsel *evsel,
-				   double avg, int cpu,
+				   double avg, int cpu_map_idx,
 				   struct perf_stat_output_ctx *out,
 				   struct rblist *metric_events,
 				   struct runtime_stat *st)
@@ -975,7 +975,7 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 	if (config->iostat_run) {
 		iostat_print_metric(config, evsel, out);
 	} else if (evsel__match(evsel, HARDWARE, HW_INSTRUCTIONS)) {
-		total = runtime_stat_avg(st, STAT_CYCLES, cpu, &rsd);
+		total = runtime_stat_avg(st, STAT_CYCLES, cpu_map_idx, &rsd);
 
 		if (total) {
 			ratio = avg / total;
@@ -985,11 +985,11 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 			print_metric(config, ctxp, NULL, NULL, "insn per cycle", 0);
 		}
 
-		total = runtime_stat_avg(st, STAT_STALLED_CYCLES_FRONT, cpu, &rsd);
+		total = runtime_stat_avg(st, STAT_STALLED_CYCLES_FRONT, cpu_map_idx, &rsd);
 
 		total = max(total, runtime_stat_avg(st,
 						    STAT_STALLED_CYCLES_BACK,
-						    cpu, &rsd));
+						    cpu_map_idx, &rsd));
 
 		if (total && avg) {
 			out->new_line(config, ctxp);
@@ -999,8 +999,8 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 					ratio);
 		}
 	} else if (evsel__match(evsel, HARDWARE, HW_BRANCH_MISSES)) {
-		if (runtime_stat_n(st, STAT_BRANCHES, cpu, &rsd) != 0)
-			print_branch_misses(config, cpu, avg, out, st, &rsd);
+		if (runtime_stat_n(st, STAT_BRANCHES, cpu_map_idx, &rsd) != 0)
+			print_branch_misses(config, cpu_map_idx, avg, out, st, &rsd);
 		else
 			print_metric(config, ctxp, NULL, NULL, "of all branches", 0);
 	} else if (
@@ -1009,8 +1009,8 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 					((PERF_COUNT_HW_CACHE_OP_READ) << 8) |
 					 ((PERF_COUNT_HW_CACHE_RESULT_MISS) << 16))) {
 
-		if (runtime_stat_n(st, STAT_L1_DCACHE, cpu, &rsd) != 0)
-			print_l1_dcache_misses(config, cpu, avg, out, st, &rsd);
+		if (runtime_stat_n(st, STAT_L1_DCACHE, cpu_map_idx, &rsd) != 0)
+			print_l1_dcache_misses(config, cpu_map_idx, avg, out, st, &rsd);
 		else
 			print_metric(config, ctxp, NULL, NULL, "of all L1-dcache accesses", 0);
 	} else if (
@@ -1019,8 +1019,8 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 					((PERF_COUNT_HW_CACHE_OP_READ) << 8) |
 					 ((PERF_COUNT_HW_CACHE_RESULT_MISS) << 16))) {
 
-		if (runtime_stat_n(st, STAT_L1_ICACHE, cpu, &rsd) != 0)
-			print_l1_icache_misses(config, cpu, avg, out, st, &rsd);
+		if (runtime_stat_n(st, STAT_L1_ICACHE, cpu_map_idx, &rsd) != 0)
+			print_l1_icache_misses(config, cpu_map_idx, avg, out, st, &rsd);
 		else
 			print_metric(config, ctxp, NULL, NULL, "of all L1-icache accesses", 0);
 	} else if (
@@ -1029,8 +1029,8 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 					((PERF_COUNT_HW_CACHE_OP_READ) << 8) |
 					 ((PERF_COUNT_HW_CACHE_RESULT_MISS) << 16))) {
 
-		if (runtime_stat_n(st, STAT_DTLB_CACHE, cpu, &rsd) != 0)
-			print_dtlb_cache_misses(config, cpu, avg, out, st, &rsd);
+		if (runtime_stat_n(st, STAT_DTLB_CACHE, cpu_map_idx, &rsd) != 0)
+			print_dtlb_cache_misses(config, cpu_map_idx, avg, out, st, &rsd);
 		else
 			print_metric(config, ctxp, NULL, NULL, "of all dTLB cache accesses", 0);
 	} else if (
@@ -1039,8 +1039,8 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 					((PERF_COUNT_HW_CACHE_OP_READ) << 8) |
 					 ((PERF_COUNT_HW_CACHE_RESULT_MISS) << 16))) {
 
-		if (runtime_stat_n(st, STAT_ITLB_CACHE, cpu, &rsd) != 0)
-			print_itlb_cache_misses(config, cpu, avg, out, st, &rsd);
+		if (runtime_stat_n(st, STAT_ITLB_CACHE, cpu_map_idx, &rsd) != 0)
+			print_itlb_cache_misses(config, cpu_map_idx, avg, out, st, &rsd);
 		else
 			print_metric(config, ctxp, NULL, NULL, "of all iTLB cache accesses", 0);
 	} else if (
@@ -1049,27 +1049,27 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 					((PERF_COUNT_HW_CACHE_OP_READ) << 8) |
 					 ((PERF_COUNT_HW_CACHE_RESULT_MISS) << 16))) {
 
-		if (runtime_stat_n(st, STAT_LL_CACHE, cpu, &rsd) != 0)
-			print_ll_cache_misses(config, cpu, avg, out, st, &rsd);
+		if (runtime_stat_n(st, STAT_LL_CACHE, cpu_map_idx, &rsd) != 0)
+			print_ll_cache_misses(config, cpu_map_idx, avg, out, st, &rsd);
 		else
 			print_metric(config, ctxp, NULL, NULL, "of all LL-cache accesses", 0);
 	} else if (evsel__match(evsel, HARDWARE, HW_CACHE_MISSES)) {
-		total = runtime_stat_avg(st, STAT_CACHEREFS, cpu, &rsd);
+		total = runtime_stat_avg(st, STAT_CACHEREFS, cpu_map_idx, &rsd);
 
 		if (total)
 			ratio = avg * 100 / total;
 
-		if (runtime_stat_n(st, STAT_CACHEREFS, cpu, &rsd) != 0)
+		if (runtime_stat_n(st, STAT_CACHEREFS, cpu_map_idx, &rsd) != 0)
 			print_metric(config, ctxp, NULL, "%8.3f %%",
 				     "of all cache refs", ratio);
 		else
 			print_metric(config, ctxp, NULL, NULL, "of all cache refs", 0);
 	} else if (evsel__match(evsel, HARDWARE, HW_STALLED_CYCLES_FRONTEND)) {
-		print_stalled_cycles_frontend(config, cpu, avg, out, st, &rsd);
+		print_stalled_cycles_frontend(config, cpu_map_idx, avg, out, st, &rsd);
 	} else if (evsel__match(evsel, HARDWARE, HW_STALLED_CYCLES_BACKEND)) {
-		print_stalled_cycles_backend(config, cpu, avg, out, st, &rsd);
+		print_stalled_cycles_backend(config, cpu_map_idx, avg, out, st, &rsd);
 	} else if (evsel__match(evsel, HARDWARE, HW_CPU_CYCLES)) {
-		total = runtime_stat_avg(st, STAT_NSECS, cpu, &rsd);
+		total = runtime_stat_avg(st, STAT_NSECS, cpu_map_idx, &rsd);
 
 		if (total) {
 			ratio = avg / total;
@@ -1078,7 +1078,7 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 			print_metric(config, ctxp, NULL, NULL, "Ghz", 0);
 		}
 	} else if (perf_stat_evsel__is(evsel, CYCLES_IN_TX)) {
-		total = runtime_stat_avg(st, STAT_CYCLES, cpu, &rsd);
+		total = runtime_stat_avg(st, STAT_CYCLES, cpu_map_idx, &rsd);
 
 		if (total)
 			print_metric(config, ctxp, NULL,
@@ -1088,8 +1088,8 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 			print_metric(config, ctxp, NULL, NULL, "transactional cycles",
 				     0);
 	} else if (perf_stat_evsel__is(evsel, CYCLES_IN_TX_CP)) {
-		total = runtime_stat_avg(st, STAT_CYCLES, cpu, &rsd);
-		total2 = runtime_stat_avg(st, STAT_CYCLES_IN_TX, cpu, &rsd);
+		total = runtime_stat_avg(st, STAT_CYCLES, cpu_map_idx, &rsd);
+		total2 = runtime_stat_avg(st, STAT_CYCLES_IN_TX, cpu_map_idx, &rsd);
 
 		if (total2 < avg)
 			total2 = avg;
@@ -1099,19 +1099,19 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 		else
 			print_metric(config, ctxp, NULL, NULL, "aborted cycles", 0);
 	} else if (perf_stat_evsel__is(evsel, TRANSACTION_START)) {
-		total = runtime_stat_avg(st, STAT_CYCLES_IN_TX, cpu, &rsd);
+		total = runtime_stat_avg(st, STAT_CYCLES_IN_TX, cpu_map_idx, &rsd);
 
 		if (avg)
 			ratio = total / avg;
 
-		if (runtime_stat_n(st, STAT_CYCLES_IN_TX, cpu, &rsd) != 0)
+		if (runtime_stat_n(st, STAT_CYCLES_IN_TX, cpu_map_idx, &rsd) != 0)
 			print_metric(config, ctxp, NULL, "%8.0f",
 				     "cycles / transaction", ratio);
 		else
 			print_metric(config, ctxp, NULL, NULL, "cycles / transaction",
 				      0);
 	} else if (perf_stat_evsel__is(evsel, ELISION_START)) {
-		total = runtime_stat_avg(st, STAT_CYCLES_IN_TX, cpu, &rsd);
+		total = runtime_stat_avg(st, STAT_CYCLES_IN_TX, cpu_map_idx, &rsd);
 
 		if (avg)
 			ratio = total / avg;
@@ -1124,28 +1124,28 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 		else
 			print_metric(config, ctxp, NULL, NULL, "CPUs utilized", 0);
 	} else if (perf_stat_evsel__is(evsel, TOPDOWN_FETCH_BUBBLES)) {
-		double fe_bound = td_fe_bound(cpu, st, &rsd);
+		double fe_bound = td_fe_bound(cpu_map_idx, st, &rsd);
 
 		if (fe_bound > 0.2)
 			color = PERF_COLOR_RED;
 		print_metric(config, ctxp, color, "%8.1f%%", "frontend bound",
 				fe_bound * 100.);
 	} else if (perf_stat_evsel__is(evsel, TOPDOWN_SLOTS_RETIRED)) {
-		double retiring = td_retiring(cpu, st, &rsd);
+		double retiring = td_retiring(cpu_map_idx, st, &rsd);
 
 		if (retiring > 0.7)
 			color = PERF_COLOR_GREEN;
 		print_metric(config, ctxp, color, "%8.1f%%", "retiring",
 				retiring * 100.);
 	} else if (perf_stat_evsel__is(evsel, TOPDOWN_RECOVERY_BUBBLES)) {
-		double bad_spec = td_bad_spec(cpu, st, &rsd);
+		double bad_spec = td_bad_spec(cpu_map_idx, st, &rsd);
 
 		if (bad_spec > 0.1)
 			color = PERF_COLOR_RED;
 		print_metric(config, ctxp, color, "%8.1f%%", "bad speculation",
 				bad_spec * 100.);
 	} else if (perf_stat_evsel__is(evsel, TOPDOWN_SLOTS_ISSUED)) {
-		double be_bound = td_be_bound(cpu, st, &rsd);
+		double be_bound = td_be_bound(cpu_map_idx, st, &rsd);
 		const char *name = "backend bound";
 		static int have_recovery_bubbles = -1;
 
@@ -1158,14 +1158,14 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 
 		if (be_bound > 0.2)
 			color = PERF_COLOR_RED;
-		if (td_total_slots(cpu, st, &rsd) > 0)
+		if (td_total_slots(cpu_map_idx, st, &rsd) > 0)
 			print_metric(config, ctxp, color, "%8.1f%%", name,
 					be_bound * 100.);
 		else
 			print_metric(config, ctxp, NULL, NULL, name, 0);
 	} else if (perf_stat_evsel__is(evsel, TOPDOWN_RETIRING) &&
-		   full_td(cpu, st, &rsd)) {
-		double retiring = td_metric_ratio(cpu,
+		   full_td(cpu_map_idx, st, &rsd)) {
+		double retiring = td_metric_ratio(cpu_map_idx,
 						  STAT_TOPDOWN_RETIRING, st,
 						  &rsd);
 		if (retiring > 0.7)
@@ -1173,8 +1173,8 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 		print_metric(config, ctxp, color, "%8.1f%%", "retiring",
 				retiring * 100.);
 	} else if (perf_stat_evsel__is(evsel, TOPDOWN_FE_BOUND) &&
-		   full_td(cpu, st, &rsd)) {
-		double fe_bound = td_metric_ratio(cpu,
+		   full_td(cpu_map_idx, st, &rsd)) {
+		double fe_bound = td_metric_ratio(cpu_map_idx,
 						  STAT_TOPDOWN_FE_BOUND, st,
 						  &rsd);
 		if (fe_bound > 0.2)
@@ -1182,8 +1182,8 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 		print_metric(config, ctxp, color, "%8.1f%%", "frontend bound",
 				fe_bound * 100.);
 	} else if (perf_stat_evsel__is(evsel, TOPDOWN_BE_BOUND) &&
-		   full_td(cpu, st, &rsd)) {
-		double be_bound = td_metric_ratio(cpu,
+		   full_td(cpu_map_idx, st, &rsd)) {
+		double be_bound = td_metric_ratio(cpu_map_idx,
 						  STAT_TOPDOWN_BE_BOUND, st,
 						  &rsd);
 		if (be_bound > 0.2)
@@ -1191,8 +1191,8 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 		print_metric(config, ctxp, color, "%8.1f%%", "backend bound",
 				be_bound * 100.);
 	} else if (perf_stat_evsel__is(evsel, TOPDOWN_BAD_SPEC) &&
-		   full_td(cpu, st, &rsd)) {
-		double bad_spec = td_metric_ratio(cpu,
+		   full_td(cpu_map_idx, st, &rsd)) {
+		double bad_spec = td_metric_ratio(cpu_map_idx,
 						  STAT_TOPDOWN_BAD_SPEC, st,
 						  &rsd);
 		if (bad_spec > 0.1)
@@ -1200,11 +1200,11 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 		print_metric(config, ctxp, color, "%8.1f%%", "bad speculation",
 				bad_spec * 100.);
 	} else if (perf_stat_evsel__is(evsel, TOPDOWN_HEAVY_OPS) &&
-			full_td(cpu, st, &rsd) && (config->topdown_level > 1)) {
-		double retiring = td_metric_ratio(cpu,
+			full_td(cpu_map_idx, st, &rsd) && (config->topdown_level > 1)) {
+		double retiring = td_metric_ratio(cpu_map_idx,
 						  STAT_TOPDOWN_RETIRING, st,
 						  &rsd);
-		double heavy_ops = td_metric_ratio(cpu,
+		double heavy_ops = td_metric_ratio(cpu_map_idx,
 						   STAT_TOPDOWN_HEAVY_OPS, st,
 						   &rsd);
 		double light_ops = retiring - heavy_ops;
@@ -1220,11 +1220,11 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 		print_metric(config, ctxp, color, "%8.1f%%", "light operations",
 				light_ops * 100.);
 	} else if (perf_stat_evsel__is(evsel, TOPDOWN_BR_MISPREDICT) &&
-			full_td(cpu, st, &rsd) && (config->topdown_level > 1)) {
-		double bad_spec = td_metric_ratio(cpu,
+			full_td(cpu_map_idx, st, &rsd) && (config->topdown_level > 1)) {
+		double bad_spec = td_metric_ratio(cpu_map_idx,
 						  STAT_TOPDOWN_BAD_SPEC, st,
 						  &rsd);
-		double br_mis = td_metric_ratio(cpu,
+		double br_mis = td_metric_ratio(cpu_map_idx,
 						STAT_TOPDOWN_BR_MISPREDICT, st,
 						&rsd);
 		double m_clears = bad_spec - br_mis;
@@ -1240,11 +1240,11 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 		print_metric(config, ctxp, color, "%8.1f%%", "machine clears",
 				m_clears * 100.);
 	} else if (perf_stat_evsel__is(evsel, TOPDOWN_FETCH_LAT) &&
-			full_td(cpu, st, &rsd) && (config->topdown_level > 1)) {
-		double fe_bound = td_metric_ratio(cpu,
+			full_td(cpu_map_idx, st, &rsd) && (config->topdown_level > 1)) {
+		double fe_bound = td_metric_ratio(cpu_map_idx,
 						  STAT_TOPDOWN_FE_BOUND, st,
 						  &rsd);
-		double fetch_lat = td_metric_ratio(cpu,
+		double fetch_lat = td_metric_ratio(cpu_map_idx,
 						   STAT_TOPDOWN_FETCH_LAT, st,
 						   &rsd);
 		double fetch_bw = fe_bound - fetch_lat;
@@ -1260,11 +1260,11 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 		print_metric(config, ctxp, color, "%8.1f%%", "fetch bandwidth",
 				fetch_bw * 100.);
 	} else if (perf_stat_evsel__is(evsel, TOPDOWN_MEM_BOUND) &&
-			full_td(cpu, st, &rsd) && (config->topdown_level > 1)) {
-		double be_bound = td_metric_ratio(cpu,
+			full_td(cpu_map_idx, st, &rsd) && (config->topdown_level > 1)) {
+		double be_bound = td_metric_ratio(cpu_map_idx,
 						  STAT_TOPDOWN_BE_BOUND, st,
 						  &rsd);
-		double mem_bound = td_metric_ratio(cpu,
+		double mem_bound = td_metric_ratio(cpu_map_idx,
 						   STAT_TOPDOWN_MEM_BOUND, st,
 						   &rsd);
 		double core_bound = be_bound - mem_bound;
@@ -1281,12 +1281,12 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 				core_bound * 100.);
 	} else if (evsel->metric_expr) {
 		generic_metric(config, evsel->metric_expr, evsel->metric_events, NULL,
-				evsel->name, evsel->metric_name, NULL, 1, cpu, out, st);
-	} else if (runtime_stat_n(st, STAT_NSECS, cpu, &rsd) != 0) {
+				evsel->name, evsel->metric_name, NULL, 1, cpu_map_idx, out, st);
+	} else if (runtime_stat_n(st, STAT_NSECS, cpu_map_idx, &rsd) != 0) {
 		char unit = ' ';
 		char unit_buf[10] = "/sec";
 
-		total = runtime_stat_avg(st, STAT_NSECS, cpu, &rsd);
+		total = runtime_stat_avg(st, STAT_NSECS, cpu_map_idx, &rsd);
 		if (total)
 			ratio = convert_unit_double(1000000000.0 * avg / total, &unit);
 
@@ -1294,7 +1294,7 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 			snprintf(unit_buf, sizeof(unit_buf), "%c/sec", unit);
 		print_metric(config, ctxp, NULL, "%8.3f", unit_buf, ratio);
 	} else if (perf_stat_evsel__is(evsel, SMI_NUM)) {
-		print_smi_cost(config, cpu, out, st, &rsd);
+		print_smi_cost(config, cpu_map_idx, out, st, &rsd);
 	} else {
 		num = 0;
 	}
@@ -1307,7 +1307,7 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 				out->new_line(config, ctxp);
 			generic_metric(config, mexp->metric_expr, mexp->metric_events,
 					mexp->metric_refs, evsel->name, mexp->metric_name,
-					mexp->metric_unit, mexp->runtime, cpu, out, st);
+					mexp->metric_unit, mexp->runtime, cpu_map_idx, out, st);
 		}
 	}
 	if (num == 0)
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 86ab427e87fc..7dbd7c4f3c33 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -356,14 +356,14 @@ static int check_per_pkg(struct evsel *counter, struct perf_counts_values *vals,
 
 static int
 process_counter_values(struct perf_stat_config *config, struct evsel *evsel,
-		       int cpu, int thread,
+		       int cpu_map_idx, int thread,
 		       struct perf_counts_values *count)
 {
 	struct perf_counts_values *aggr = &evsel->counts->aggr;
 	static struct perf_counts_values zero;
 	bool skip = false;
 
-	if (check_per_pkg(evsel, count, cpu, &skip)) {
+	if (check_per_pkg(evsel, count, cpu_map_idx, &skip)) {
 		pr_err("failed to read per-pkg counter\n");
 		return -1;
 	}
@@ -379,11 +379,11 @@ process_counter_values(struct perf_stat_config *config, struct evsel *evsel,
 	case AGGR_NODE:
 	case AGGR_NONE:
 		if (!evsel->snapshot)
-			evsel__compute_deltas(evsel, cpu, thread, count);
+			evsel__compute_deltas(evsel, cpu_map_idx, thread, count);
 		perf_counts_values__scale(count, config->scale, NULL);
 		if ((config->aggr_mode == AGGR_NONE) && (!evsel->percore)) {
 			perf_stat__update_shadow_stats(evsel, count->val,
-						       cpu, &rt_stat);
+						       cpu_map_idx, &rt_stat);
 		}
 
 		if (config->aggr_mode == AGGR_THREAD) {
@@ -412,15 +412,15 @@ static int process_counter_maps(struct perf_stat_config *config,
 {
 	int nthreads = perf_thread_map__nr(counter->core.threads);
 	int ncpus = evsel__nr_cpus(counter);
-	int cpu, thread;
+	int idx, thread;
 
 	if (counter->core.system_wide)
 		nthreads = 1;
 
 	for (thread = 0; thread < nthreads; thread++) {
-		for (cpu = 0; cpu < ncpus; cpu++) {
-			if (process_counter_values(config, counter, cpu, thread,
-						   perf_counts(counter->counts, cpu, thread)))
+		for (idx = 0; idx < ncpus; idx++) {
+			if (process_counter_values(config, counter, idx, thread,
+						   perf_counts(counter->counts, idx, thread)))
 				return -1;
 		}
 	}
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 5e25d53e891b..691c12fd8976 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -208,7 +208,7 @@ void perf_stat__init_shadow_stats(void);
 void perf_stat__reset_shadow_stats(void);
 void perf_stat__reset_shadow_per_stat(struct runtime_stat *st);
 void perf_stat__update_shadow_stats(struct evsel *counter, u64 count,
-				    int cpu, struct runtime_stat *st);
+				    int cpu_map_idx, struct runtime_stat *st);
 struct perf_stat_output_ctx {
 	void *ctx;
 	print_metric_t print_metric;
@@ -253,5 +253,5 @@ void evlist__print_counters(struct evlist *evlist, struct perf_stat_config *conf
 			    struct target *_target, struct timespec *ts, int argc, const char **argv);
 
 struct metric_expr;
-double test_generic_metric(struct metric_expr *mexp, int cpu, struct runtime_stat *st);
+double test_generic_metric(struct metric_expr *mexp, int cpu_map_idx, struct runtime_stat *st);
 #endif
-- 
2.34.1.448.ga2b2bfdf31-goog

