Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 602974D76FB
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 17:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235049AbiCMQwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 12:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbiCMQwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 12:52:30 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C4298F45;
        Sun, 13 Mar 2022 09:51:19 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=wenyang@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0V70i27E_1647190265;
Received: from localhost(mailfrom:wenyang@linux.alibaba.com fp:SMTPD_---0V70i27E_1647190265)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 14 Mar 2022 00:51:15 +0800
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
Subject: [PATCH v2 2/3] perf/x86: improve the event scheduling to avoid unnecessary x86_pmu_{stop|start}
Date:   Mon, 14 Mar 2022 00:50:46 +0800
Message-Id: <20220313165047.77391-2-simon.wy@alibaba-inc.com>
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

During long-term monitoring of CPI data on some cloud servers in some
clusters, data anomalies are occasionally found.

When perf events are frequently created and deleted, the PMU counters may
switch, and x86_pmu_{stop|start} is also called frequently.
When we stop, we update the value, then reprogram on another counter and
continue. It is generally OK, but when NMI watchdog occupies this fixed
counter *cycles*, the monitoring program may only use one general counter.
At this time, reprogramming may not be effective.

The fields msk_counters and msk_events are added to indicate currently
used counters and events so that the used ones can be skipped in both
__perf_sched_find_counter and perf_sched_next_event functions to avoid
unnecessary x86_pmu_{stop|start}.

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
 arch/x86/events/core.c | 103 ++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 90 insertions(+), 13 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index b14fb1b..b7f5925 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -796,33 +796,70 @@ struct perf_sched {
 	int			max_events;
 	int			max_gp;
 	int			saved_states;
+	u64			msk_counters;
+	u64			msk_events;
 	struct event_constraint	**constraints;
 	struct sched_state	state;
 	struct sched_state	saved[SCHED_STATES_MAX];
 };
 
+static int perf_sched_calc_weight(struct event_constraint **constraints,
+		int num, int wmin, int wmax, u64 msk_events)
+{
+	int min_weight;
+	int idx;
+
+	if (!msk_events) {
+		min_weight = wmin;
+		goto out;
+	}
+
+	min_weight = wmax;
+	for (idx = 0; idx < num; idx++) {
+		if (msk_events & BIT_ULL(idx))
+			continue;
+
+		min_weight = min(min_weight, constraints[idx]->weight);
+	}
+
+out:
+	return min_weight;
+}
+
+static int perf_sched_calc_event(struct event_constraint **constraints,
+		int num, int weight, u64 msk_events)
+{
+	int idx;
+
+	for (idx = 0; idx < num; idx++) {
+		if (msk_events & BIT_ULL(idx))
+			continue;
+
+		if (constraints[idx]->weight == weight)
+			break;
+	}
+
+	/* start with min weight */
+	return idx;
+}
+
 /*
  * Initialize iterator that runs through all events and counters.
  */
 static void perf_sched_init(struct perf_sched *sched, struct event_constraint **constraints,
-			    int num, int wmin, int wmax, int gpmax)
+			    int num, int wmin, int wmax, int gpmax, u64 mevt, u64 mcnt)
 {
-	int idx;
-
 	memset(sched, 0, sizeof(*sched));
 	sched->max_events	= num;
 	sched->max_weight	= wmax;
 	sched->max_gp		= gpmax;
 	sched->constraints	= constraints;
+	sched->msk_events   = mevt;
+	sched->msk_counters = mcnt;
 
-	for (idx = 0; idx < num; idx++) {
-		if (constraints[idx]->weight == wmin)
-			break;
-	}
-
-	sched->state.event	= idx;		/* start with min weight */
-	sched->state.weight	= wmin;
-	sched->state.unassigned	= num;
+	sched->state.weight = perf_sched_calc_weight(constraints, num, wmin, wmax, mcnt);
+	sched->state.event = perf_sched_calc_event(constraints, num, sched->state.weight, mevt);
+	sched->state.unassigned = num - hweight_long(sched->state.event);
 }
 
 static void perf_sched_save_state(struct perf_sched *sched)
@@ -874,6 +911,9 @@ static bool __perf_sched_find_counter(struct perf_sched *sched)
 		for_each_set_bit_from(idx, c->idxmsk, X86_PMC_IDX_MAX) {
 			u64 mask = BIT_ULL(idx);
 
+			if (sched->msk_counters & mask)
+				continue;
+
 			if (sched->state.used & mask)
 				continue;
 
@@ -890,6 +930,9 @@ static bool __perf_sched_find_counter(struct perf_sched *sched)
 		if (c->flags & PERF_X86_EVENT_PAIR)
 			mask |= mask << 1;
 
+		if (sched->msk_counters & mask)
+			continue;
+
 		if (sched->state.used & mask)
 			continue;
 
@@ -921,6 +964,12 @@ static bool perf_sched_find_counter(struct perf_sched *sched)
 	return true;
 }
 
+static void ignore_used_index(u64 mask, int *index)
+{
+	while (mask & BIT_ULL(*index))
+		++*index;
+}
+
 /*
  * Go through all unassigned events and find the next one to schedule.
  * Take events with the least weight first. Return true on success.
@@ -935,9 +984,12 @@ static bool perf_sched_next_event(struct perf_sched *sched)
 	do {
 		/* next event */
 		sched->state.event++;
+		ignore_used_index(sched->msk_events, &sched->state.event);
 		if (sched->state.event >= sched->max_events) {
 			/* next weight */
 			sched->state.event = 0;
+			ignore_used_index(sched->msk_events, &sched->state.event);
+
 			sched->state.weight++;
 			if (sched->state.weight > sched->max_weight)
 				return false;
@@ -950,12 +1002,28 @@ static bool perf_sched_next_event(struct perf_sched *sched)
 	return true;
 }
 
+static void perf_sched_obtain_used_registers(int *assign, int n, u64 *events, u64 *counters)
+{
+	int idx;
+
+	*events = 0;
+	*counters = 0;
+	for (idx = 0; idx < n; idx++) {
+		if (assign[idx] != -1) {
+			*events |= BIT_ULL(idx);
+			*counters |= BIT_ULL(assign[idx]);
+		}
+	}
+}
+
 static int __perf_assign_events(struct event_constraint **constraints, int n,
 			int wmin, int wmax, int gpmax, int *assign)
 {
+	u64 msk_events, msk_counters;
 	struct perf_sched sched;
 
-	perf_sched_init(&sched, constraints, n, wmin, wmax, gpmax);
+	perf_sched_obtain_used_registers(assign, n, &msk_events, &msk_counters);
+	perf_sched_init(&sched, constraints, n, wmin, wmax, gpmax, msk_events, msk_counters);
 
 	do {
 		if (!perf_sched_find_counter(&sched))
@@ -980,6 +1048,8 @@ int perf_assign_events(struct perf_event **event_list,
 	int unsched = 0;
 	int i;
 
+	memset(assign, -1, n);
+
 	/*
 	 * fastpath, try to reuse previous register
 	 */
@@ -1012,10 +1082,17 @@ int perf_assign_events(struct perf_event **event_list,
 	}
 
 	/* slow path */
-	if (i != n)
+	if (i != n) {
 		unsched = __perf_assign_events(constraints, n,
 				wmin, wmax, gpmax, assign);
 
+		if (unsched) {
+			memset(assign, -1, n);
+			unsched = __perf_assign_events(constraints, n,
+					wmin, wmax, gpmax, assign);
+		}
+	}
+
 	return unsched;
 }
 EXPORT_SYMBOL_GPL(perf_assign_events);
-- 
1.8.3.1

