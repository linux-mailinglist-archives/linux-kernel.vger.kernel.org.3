Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBFEC4CB8C9
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 09:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbiCCI1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 03:27:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiCCI1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 03:27:22 -0500
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE66D64F0;
        Thu,  3 Mar 2022 00:26:36 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=wenyang@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0V66rEBX_1646295984;
Received: from localhost(mailfrom:wenyang@linux.alibaba.com fp:SMTPD_---0V66rEBX_1646295984)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 03 Mar 2022 16:26:33 +0800
From:   Wen Yang <simon.wy@alibaba-inc.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Wen Yang <simon.wy@alibaba-inc.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        Wen Yang <wenyang@linux.alibaba.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] perf/x86: extract code to assign perf events for both core and uncore
Date:   Thu,  3 Mar 2022 16:26:21 +0800
Message-Id: <20220303082622.32847-1-simon.wy@alibaba-inc.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.2 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following two patterns in x86 perf code are used in multiple places where
similar code is duplicated:
- fast path, try to reuse previous register
- slow path, assign a counter for each event

In order to reduce duplicate and prepare for following patch series that
also uses described patterns, extract the codes to perf_assign_events.

This commit doesn't change functionality.

Signed-off-by: Wen Yang <simon.wy@alibaba-inc.com>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org
Cc: Wen Yang <wenyang@linux.alibaba.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/events/core.c         | 141 ++++++++++++++++++---------------
 arch/x86/events/intel/uncore.c |  31 +-------
 arch/x86/events/perf_event.h   |   6 +-
 3 files changed, 82 insertions(+), 96 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index eef816fc216d..9846d422f06d 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -950,10 +950,7 @@ static bool perf_sched_next_event(struct perf_sched *sched)
 	return true;
 }
 
-/*
- * Assign a counter for each event.
- */
-int perf_assign_events(struct event_constraint **constraints, int n,
+int _perf_assign_events(struct event_constraint **constraints, int n,
 			int wmin, int wmax, int gpmax, int *assign)
 {
 	struct perf_sched sched;
@@ -969,16 +966,66 @@ int perf_assign_events(struct event_constraint **constraints, int n,
 
 	return sched.state.unassigned;
 }
+
+/*
+ * Assign a counter for each event.
+ */
+int perf_assign_events(struct perf_event **event_list,
+		struct event_constraint **constraints, int n,
+		int wmin, int wmax, int gpmax, int *assign)
+{
+	struct event_constraint *c;
+	struct hw_perf_event *hwc;
+	u64 used_mask = 0;
+	int unsched = 0;
+	int i;
+
+	/*
+	 * fastpath, try to reuse previous register
+	 */
+	for (i = 0; i < n; i++) {
+		u64 mask;
+
+		hwc = &event_list[i]->hw;
+		c = constraints[i];
+
+		/* never assigned */
+		if (hwc->idx == -1)
+			break;
+
+		/* constraint still honored */
+		if (!test_bit(hwc->idx, c->idxmsk))
+			break;
+
+		mask = BIT_ULL(hwc->idx);
+		if (is_counter_pair(hwc))
+			mask |= mask << 1;
+
+		/* not already used */
+		if (used_mask & mask)
+			break;
+
+		used_mask |= mask;
+
+		if (assign)
+			assign[i] = hwc->idx;
+	}
+
+	/* slow path */
+	if (i != n)
+		unsched = _perf_assign_events(constraints, n,
+				wmin, wmax, gpmax, assign);
+
+	return unsched;
+}
 EXPORT_SYMBOL_GPL(perf_assign_events);
 
 int x86_schedule_events(struct cpu_hw_events *cpuc, int n, int *assign)
 {
 	int num_counters = hybrid(cpuc->pmu, num_counters);
-	struct event_constraint *c;
-	struct perf_event *e;
 	int n0, i, wmin, wmax, unsched = 0;
-	struct hw_perf_event *hwc;
-	u64 used_mask = 0;
+	struct event_constraint *c;
+	int gpmax = num_counters;
 
 	/*
 	 * Compute the number of events already present; see x86_pmu_add(),
@@ -1017,66 +1064,30 @@ int x86_schedule_events(struct cpu_hw_events *cpuc, int n, int *assign)
 	}
 
 	/*
-	 * fastpath, try to reuse previous register
+	 * Do not allow scheduling of more than half the available
+	 * generic counters.
+	 *
+	 * This helps avoid counter starvation of sibling thread by
+	 * ensuring at most half the counters cannot be in exclusive
+	 * mode. There is no designated counters for the limits. Any
+	 * N/2 counters can be used. This helps with events with
+	 * specific counter constraints.
 	 */
-	for (i = 0; i < n; i++) {
-		u64 mask;
-
-		hwc = &cpuc->event_list[i]->hw;
-		c = cpuc->event_constraint[i];
-
-		/* never assigned */
-		if (hwc->idx == -1)
-			break;
-
-		/* constraint still honored */
-		if (!test_bit(hwc->idx, c->idxmsk))
-			break;
-
-		mask = BIT_ULL(hwc->idx);
-		if (is_counter_pair(hwc))
-			mask |= mask << 1;
-
-		/* not already used */
-		if (used_mask & mask)
-			break;
+	if (is_ht_workaround_enabled() && !cpuc->is_fake &&
+			READ_ONCE(cpuc->excl_cntrs->exclusive_present))
+		gpmax /= 2;
 
-		used_mask |= mask;
-
-		if (assign)
-			assign[i] = hwc->idx;
+	/*
+	 * Reduce the amount of available counters to allow fitting
+	 * the extra Merge events needed by large increment events.
+	 */
+	if (x86_pmu.flags & PMU_FL_PAIR) {
+		gpmax = num_counters - cpuc->n_pair;
+		WARN_ON(gpmax <= 0);
 	}
 
-	/* slow path */
-	if (i != n) {
-		int gpmax = num_counters;
-
-		/*
-		 * Do not allow scheduling of more than half the available
-		 * generic counters.
-		 *
-		 * This helps avoid counter starvation of sibling thread by
-		 * ensuring at most half the counters cannot be in exclusive
-		 * mode. There is no designated counters for the limits. Any
-		 * N/2 counters can be used. This helps with events with
-		 * specific counter constraints.
-		 */
-		if (is_ht_workaround_enabled() && !cpuc->is_fake &&
-		    READ_ONCE(cpuc->excl_cntrs->exclusive_present))
-			gpmax /= 2;
-
-		/*
-		 * Reduce the amount of available counters to allow fitting
-		 * the extra Merge events needed by large increment events.
-		 */
-		if (x86_pmu.flags & PMU_FL_PAIR) {
-			gpmax = num_counters - cpuc->n_pair;
-			WARN_ON(gpmax <= 0);
-		}
-
-		unsched = perf_assign_events(cpuc->event_constraint, n, wmin,
-					     wmax, gpmax, assign);
-	}
+	unsched = perf_assign_events(cpuc->event_list, cpuc->event_constraint,
+			n, wmin, wmax, gpmax, assign);
 
 	/*
 	 * In case of success (unsched = 0), mark events as committed,
@@ -1093,7 +1104,7 @@ int x86_schedule_events(struct cpu_hw_events *cpuc, int n, int *assign)
 			static_call_cond(x86_pmu_commit_scheduling)(cpuc, i, assign[i]);
 	} else {
 		for (i = n0; i < n; i++) {
-			e = cpuc->event_list[i];
+			struct perf_event *e = cpuc->event_list[i];
 
 			/*
 			 * release events that failed scheduling
diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index e497da9bf427..101358ae2814 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -442,12 +442,8 @@ static void uncore_put_event_constraint(struct intel_uncore_box *box,
 
 static int uncore_assign_events(struct intel_uncore_box *box, int assign[], int n)
 {
-	unsigned long used_mask[BITS_TO_LONGS(UNCORE_PMC_IDX_MAX)];
 	struct event_constraint *c;
 	int i, wmin, wmax, ret = 0;
-	struct hw_perf_event *hwc;
-
-	bitmap_zero(used_mask, UNCORE_PMC_IDX_MAX);
 
 	for (i = 0, wmin = UNCORE_PMC_IDX_MAX, wmax = 0; i < n; i++) {
 		c = uncore_get_event_constraint(box, box->event_list[i]);
@@ -456,31 +452,8 @@ static int uncore_assign_events(struct intel_uncore_box *box, int assign[], int
 		wmax = max(wmax, c->weight);
 	}
 
-	/* fastpath, try to reuse previous register */
-	for (i = 0; i < n; i++) {
-		hwc = &box->event_list[i]->hw;
-		c = box->event_constraint[i];
-
-		/* never assigned */
-		if (hwc->idx == -1)
-			break;
-
-		/* constraint still honored */
-		if (!test_bit(hwc->idx, c->idxmsk))
-			break;
-
-		/* not already used */
-		if (test_bit(hwc->idx, used_mask))
-			break;
-
-		__set_bit(hwc->idx, used_mask);
-		if (assign)
-			assign[i] = hwc->idx;
-	}
-	/* slow path */
-	if (i != n)
-		ret = perf_assign_events(box->event_constraint, n,
-					 wmin, wmax, n, assign);
+	ret = perf_assign_events(box->event_list,
+			box->event_constraint, n, wmin, wmax, n, assign);
 
 	if (!assign || ret) {
 		for (i = 0; i < n; i++)
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 150261d929b9..f1acd1ded001 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1130,8 +1130,10 @@ static inline void __x86_pmu_enable_event(struct hw_perf_event *hwc,
 
 void x86_pmu_enable_all(int added);
 
-int perf_assign_events(struct event_constraint **constraints, int n,
-			int wmin, int wmax, int gpmax, int *assign);
+int perf_assign_events(struct perf_event **event_list,
+		struct event_constraint **constraints, int n,
+		int wmin, int wmax, int gpmax, int *assign);
+
 int x86_schedule_events(struct cpu_hw_events *cpuc, int n, int *assign);
 
 void x86_pmu_stop(struct perf_event *event, int flags);
-- 
2.19.1.6.gb485710b

