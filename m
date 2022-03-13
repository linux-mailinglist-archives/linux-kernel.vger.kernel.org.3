Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB88A4D76FC
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 17:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235081AbiCMQwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 12:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235083AbiCMQwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 12:52:39 -0400
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD83798F69;
        Sun, 13 Mar 2022 09:51:29 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=wenyang@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0V70i28O_1647190276;
Received: from localhost(mailfrom:wenyang@linux.alibaba.com fp:SMTPD_---0V70i28O_1647190276)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 14 Mar 2022 00:51:25 +0800
From:   Wen Yang <simon.wy@alibaba-inc.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Wen Yang <simon.wy@alibaba-inc.com>,
        Stephane Eranian <eranian@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        Wen Yang <wenyang@linux.alibaba.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] perf/x86: reuse scarce pmu counters
Date:   Mon, 14 Mar 2022 00:50:47 +0800
Message-Id: <20220313165047.77391-3-simon.wy@alibaba-inc.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220313165047.77391-1-simon.wy@alibaba-inc.com>
References: <20220313165047.77391-1-simon.wy@alibaba-inc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The nmi watchdog may permanently consume a fixed counter (*cycles*),
so when other programs collect *cycles* again, they will occupy a GP.
Here is a slight optimization: save a generic counter for events that
are non-sampling type and using a fixed counter.

Signed-off-by: Wen Yang <simon.wy@alibaba-inc.com>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
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
 arch/x86/events/core.c | 45 +++++++++++++++++++++++++++++++--------------
 1 file changed, 31 insertions(+), 14 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index b7f5925..6ddddf1 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -799,6 +799,7 @@ struct perf_sched {
 	u64			msk_counters;
 	u64			msk_events;
 	struct event_constraint	**constraints;
+	struct perf_event	**events;
 	struct sched_state	state;
 	struct sched_state	saved[SCHED_STATES_MAX];
 };
@@ -846,7 +847,8 @@ static int perf_sched_calc_event(struct event_constraint **constraints,
 /*
  * Initialize iterator that runs through all events and counters.
  */
-static void perf_sched_init(struct perf_sched *sched, struct event_constraint **constraints,
+static void perf_sched_init(struct perf_sched *sched,
+			    struct perf_event **events, struct event_constraint **constraints,
 			    int num, int wmin, int wmax, int gpmax, u64 mevt, u64 mcnt)
 {
 	memset(sched, 0, sizeof(*sched));
@@ -854,12 +856,13 @@ static void perf_sched_init(struct perf_sched *sched, struct event_constraint **
 	sched->max_weight	= wmax;
 	sched->max_gp		= gpmax;
 	sched->constraints	= constraints;
+	sched->events		= events;
 	sched->msk_events   = mevt;
 	sched->msk_counters = mcnt;
 
 	sched->state.weight = perf_sched_calc_weight(constraints, num, wmin, wmax, mcnt);
 	sched->state.event = perf_sched_calc_event(constraints, num, sched->state.weight, mevt);
-	sched->state.unassigned = num - hweight_long(sched->state.event);
+	sched->state.unassigned = num - hweight_long(mevt);
 }
 
 static void perf_sched_save_state(struct perf_sched *sched)
@@ -896,6 +899,7 @@ static bool perf_sched_restore_state(struct perf_sched *sched)
 static bool __perf_sched_find_counter(struct perf_sched *sched)
 {
 	struct event_constraint *c;
+	struct perf_event *e;
 	int idx;
 
 	if (!sched->state.unassigned)
@@ -905,16 +909,17 @@ static bool __perf_sched_find_counter(struct perf_sched *sched)
 		return false;
 
 	c = sched->constraints[sched->state.event];
+	e = sched->events[sched->state.event];
 	/* Prefer fixed purpose counters */
 	if (c->idxmsk64 & (~0ULL << INTEL_PMC_IDX_FIXED)) {
 		idx = INTEL_PMC_IDX_FIXED;
 		for_each_set_bit_from(idx, c->idxmsk, X86_PMC_IDX_MAX) {
 			u64 mask = BIT_ULL(idx);
 
-			if (sched->msk_counters & mask)
+			if ((sched->msk_counters & mask) && is_sampling_event(e))
 				continue;
 
-			if (sched->state.used & mask)
+			if ((sched->state.used & mask) && is_sampling_event(e))
 				continue;
 
 			sched->state.used |= mask;
@@ -1016,14 +1021,15 @@ static void perf_sched_obtain_used_registers(int *assign, int n, u64 *events, u6
 	}
 }
 
-static int __perf_assign_events(struct event_constraint **constraints, int n,
+static int __perf_assign_events(struct perf_event **events,
+			struct event_constraint **constraints, int n,
 			int wmin, int wmax, int gpmax, int *assign)
 {
-	u64 msk_events, msk_counters;
+	u64 mevt, mcnt;
 	struct perf_sched sched;
 
-	perf_sched_obtain_used_registers(assign, n, &msk_events, &msk_counters);
-	perf_sched_init(&sched, constraints, n, wmin, wmax, gpmax, msk_events, msk_counters);
+	perf_sched_obtain_used_registers(assign, n, &mevt, &mcnt);
+	perf_sched_init(&sched, events, constraints, n, wmin, wmax, gpmax, mevt, mcnt);
 
 	do {
 		if (!perf_sched_find_counter(&sched))
@@ -1035,6 +1041,13 @@ static int __perf_assign_events(struct event_constraint **constraints, int n,
 	return sched.state.unassigned;
 }
 
+static bool is_pmc_reuseable(struct perf_event *e,
+		struct event_constraint *c)
+{
+	return c->idxmsk64 & (~0ULL << INTEL_PMC_IDX_FIXED) &&
+		!is_sampling_event(e);
+}
+
 /*
  * Assign a counter for each event.
  */
@@ -1043,12 +1056,13 @@ int perf_assign_events(struct perf_event **event_list,
 		int wmin, int wmax, int gpmax, int *assign)
 {
 	struct event_constraint *c;
+	struct perf_event *e;
 	struct hw_perf_event *hwc;
 	u64 used_mask = 0;
 	int unsched = 0;
 	int i;
 
-	memset(assign, -1, n);
+	memset(assign, -1, n * sizeof(int));
 
 	/*
 	 * fastpath, try to reuse previous register
@@ -1058,6 +1072,7 @@ int perf_assign_events(struct perf_event **event_list,
 
 		hwc = &event_list[i]->hw;
 		c = constraints[i];
+		e = event_list[i];
 
 		/* never assigned */
 		if (hwc->idx == -1)
@@ -1072,8 +1087,10 @@ int perf_assign_events(struct perf_event **event_list,
 			mask |= mask << 1;
 
 		/* not already used */
-		if (used_mask & mask)
-			break;
+		if (used_mask & mask) {
+			if (!is_pmc_reuseable(e, c))
+				break;
+		}
 
 		used_mask |= mask;
 
@@ -1083,12 +1100,12 @@ int perf_assign_events(struct perf_event **event_list,
 
 	/* slow path */
 	if (i != n) {
-		unsched = __perf_assign_events(constraints, n,
+		unsched = __perf_assign_events(event_list, constraints, n,
 				wmin, wmax, gpmax, assign);
 
 		if (unsched) {
-			memset(assign, -1, n);
-			unsched = __perf_assign_events(constraints, n,
+			memset(assign, -1, n * sizeof(int));
+			unsched = __perf_assign_events(event_list, constraints, n,
 					wmin, wmax, gpmax, assign);
 		}
 	}
-- 
1.8.3.1

