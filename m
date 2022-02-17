Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58D1E4B9606
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 03:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbiBQCqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 21:46:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiBQCqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 21:46:07 -0500
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 074222A795F;
        Wed, 16 Feb 2022 18:45:51 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=wenyang@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0V4fbH8I_1645065942;
Received: from localhost(mailfrom:wenyang@linux.alibaba.com fp:SMTPD_---0V4fbH8I_1645065942)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 17 Feb 2022 10:45:48 +0800
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
Subject: [RFC PATCH] perf/x86: improve the event scheduling to avoid unnecessary pmu_stop/start
Date:   Thu, 17 Feb 2022 10:45:40 +0800
Message-Id: <20220217024540.33657-1-simon.wy@alibaba-inc.com>
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

This issue has been there for a long time, we could reproduce it as follows:

1, run a script that periodically collects perf data, eg:
while true
do
    perf stat -e cache-misses,cache-misses,cache-misses -C 1 sleep 2
    perf stat -e cache-misses -C 1 sleep 2
    sleep 1
done

2, run another one to capture the IPC, eg:
perf stat -e cycles:D,instructions:D  -C 1 -I 1000

Then we could observe that the counter used by cycles:D changes frequently:
crash> struct  cpu_hw_events.n_events,assign,event_list,events  ffff88bf7f44f420
  n_events = 3
  assign = {33, 1, 32, 0, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
  event_list = {0xffff88bf77b85000, 0xffff88b72db82000, 0xffff88b72db85800, 0xffff88ff6cfcb000, 0xffff88ff609f1800, 0xffff88ff609f1800, 0xffff88ff5f46a800, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}
  events = {0x0, 0xffff88b72db82000, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0xffff88b72db85800, 0xffff88bf77b85000, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}

crash> struct  cpu_hw_events.n_events,assign,event_list,events  ffff88bf7f44f420
  n_events = 6
  assign = {33, 3, 32, 0, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
  event_list = {0xffff88bf77b85000, 0xffff88b72db82000, 0xffff88b72db85800, 0xffff88bf46c34000, 0xffff88bf46c35000, 0xffff88bf46c30000, 0xffff88ff5f46a800, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}
  events = {0xffff88bf46c34000, 0xffff88bf46c35000, 0xffff88bf46c30000, 0xffff88b72db82000, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0xffff88b72db85800, 0xffff88bf77b85000, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}

The reason is that the NMI watchdog permanently consumes one FP
(*cycles*). Therefore, when the above shell script obtains *cycles*
again, only one GP can be used, and its weight is 5.
But other events (like *cache-misses*) have a weight of 4,
so the counter used by *cycles* will often be taken away, as in
the raw data above:
[1]
  n_events = 3
  assign = {33, 1, 32, ...}
-->
  n_events = 6
  assign = {33, 3, 32, 0, 1, 2, ...}

So it will cause unnecessary pmu_stop/start.

The current event scheduling algorithm is more than 10 years old:
https://lwn.net/Articles/357631/

We wish it could be optimized a bit.
In this patch, the fields cnt_mask and evt_mask are added to indicate
currently used counters and events so that the used ones can be skipped
in __perf_sched_find_counter and perf_sched_next_event functions to avoid
unnecessary pmu_stop/start.

[1]:
32: INTEL_PMC_IDX_FIXED_INSTRUCTIONS
33: INTEL_PMC_IDX_FIXED_CPU_CYCLES
34: INTEL_PMC_IDX_FIXED_REF_CYCLES
0,1,2,3: GP

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
 arch/x86/events/core.c         | 40 +++++++++++++++++++++++++++++++---------
 arch/x86/events/intel/uncore.c |  2 +-
 arch/x86/events/perf_event.h   |  3 ++-
 3 files changed, 34 insertions(+), 11 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index e686c5e..1a47e31 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -796,6 +796,8 @@ struct perf_sched {
 	int			max_events;
 	int			max_gp;
 	int			saved_states;
+	u64			cnt_mask;
+	u64			evt_mask;
 	struct event_constraint	**constraints;
 	struct sched_state	state;
 	struct sched_state	saved[SCHED_STATES_MAX];
@@ -805,7 +807,7 @@ struct perf_sched {
  * Initialize iterator that runs through all events and counters.
  */
 static void perf_sched_init(struct perf_sched *sched, struct event_constraint **constraints,
-			    int num, int wmin, int wmax, int gpmax)
+			    int num, int wmin, int wmax, int gpmax, u64 cnt_mask, u64 evt_mask)
 {
 	int idx;
 
@@ -814,6 +816,8 @@ static void perf_sched_init(struct perf_sched *sched, struct event_constraint **
 	sched->max_weight	= wmax;
 	sched->max_gp		= gpmax;
 	sched->constraints	= constraints;
+	sched->cnt_mask	= cnt_mask;
+	sched->evt_mask	= evt_mask;
 
 	for (idx = 0; idx < num; idx++) {
 		if (constraints[idx]->weight == wmin)
@@ -822,7 +826,10 @@ static void perf_sched_init(struct perf_sched *sched, struct event_constraint **
 
 	sched->state.event	= idx;		/* start with min weight */
 	sched->state.weight	= wmin;
-	sched->state.unassigned	= num;
+	sched->state.unassigned	= num - hweight_long(evt_mask);
+
+	while (sched->evt_mask & BIT_ULL(sched->state.event))
+		sched->state.event++;
 }
 
 static void perf_sched_save_state(struct perf_sched *sched)
@@ -874,6 +881,9 @@ static bool __perf_sched_find_counter(struct perf_sched *sched)
 		for_each_set_bit_from(idx, c->idxmsk, X86_PMC_IDX_MAX) {
 			u64 mask = BIT_ULL(idx);
 
+			if (sched->cnt_mask & mask)
+				continue;
+
 			if (sched->state.used & mask)
 				continue;
 
@@ -890,6 +900,9 @@ static bool __perf_sched_find_counter(struct perf_sched *sched)
 		if (c->flags & PERF_X86_EVENT_PAIR)
 			mask |= mask << 1;
 
+		if (sched->cnt_mask & mask)
+			continue;
+
 		if (sched->state.used & mask)
 			continue;
 
@@ -934,7 +947,10 @@ static bool perf_sched_next_event(struct perf_sched *sched)
 
 	do {
 		/* next event */
-		sched->state.event++;
+		do {
+			sched->state.event++;
+		} while (sched->evt_mask & BIT_ULL(sched->state.event));
+
 		if (sched->state.event >= sched->max_events) {
 			/* next weight */
 			sched->state.event = 0;
@@ -954,11 +970,11 @@ static bool perf_sched_next_event(struct perf_sched *sched)
  * Assign a counter for each event.
  */
 int perf_assign_events(struct event_constraint **constraints, int n,
-			int wmin, int wmax, int gpmax, int *assign)
+			int wmin, int wmax, int gpmax, u64 cnt_mask, u64 evt_mask, int *assign)
 {
 	struct perf_sched sched;
 
-	perf_sched_init(&sched, constraints, n, wmin, wmax, gpmax);
+	perf_sched_init(&sched, constraints, n, wmin, wmax, gpmax, cnt_mask, evt_mask);
 
 	do {
 		if (!perf_sched_find_counter(&sched))
@@ -978,7 +994,8 @@ int x86_schedule_events(struct cpu_hw_events *cpuc, int n, int *assign)
 	struct perf_event *e;
 	int n0, i, wmin, wmax, unsched = 0;
 	struct hw_perf_event *hwc;
-	u64 used_mask = 0;
+	u64 cnt_mask = 0;
+	u64 evt_mask = 0;
 
 	/*
 	 * Compute the number of events already present; see x86_pmu_add(),
@@ -1038,10 +1055,11 @@ int x86_schedule_events(struct cpu_hw_events *cpuc, int n, int *assign)
 			mask |= mask << 1;
 
 		/* not already used */
-		if (used_mask & mask)
+		if (cnt_mask & mask)
 			break;
 
-		used_mask |= mask;
+		cnt_mask |= mask;
+		evt_mask |= BIT_ULL(i);
 
 		if (assign)
 			assign[i] = hwc->idx;
@@ -1075,7 +1093,11 @@ int x86_schedule_events(struct cpu_hw_events *cpuc, int n, int *assign)
 		}
 
 		unsched = perf_assign_events(cpuc->event_constraint, n, wmin,
-					     wmax, gpmax, assign);
+					     wmax, gpmax, cnt_mask, evt_mask, assign);
+		if (unsched) {
+			unsched = perf_assign_events(cpuc->event_constraint, n, wmin,
+					wmax, gpmax, 0, 0, assign);
+		}
 	}
 
 	/*
diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index e497da9..8afff7a 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -480,7 +480,7 @@ static int uncore_assign_events(struct intel_uncore_box *box, int assign[], int
 	/* slow path */
 	if (i != n)
 		ret = perf_assign_events(box->event_constraint, n,
-					 wmin, wmax, n, assign);
+					 wmin, wmax, n, 0, 0, assign);
 
 	if (!assign || ret) {
 		for (i = 0; i < n; i++)
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 150261d..2ae1e98 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1131,7 +1131,8 @@ static inline void __x86_pmu_enable_event(struct hw_perf_event *hwc,
 void x86_pmu_enable_all(int added);
 
 int perf_assign_events(struct event_constraint **constraints, int n,
-			int wmin, int wmax, int gpmax, int *assign);
+			int wmin, int wmax, int gpmax, u64 cnt_mask, u64 evt_mask,
+			int *assign);
 int x86_schedule_events(struct cpu_hw_events *cpuc, int n, int *assign);
 
 void x86_pmu_stop(struct perf_event *event, int flags);
-- 
1.8.3.1

