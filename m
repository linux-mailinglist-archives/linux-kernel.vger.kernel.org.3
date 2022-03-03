Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EAF54CB8CA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 09:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbiCCI1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 03:27:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiCCI1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 03:27:32 -0500
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC6E2171EF6;
        Thu,  3 Mar 2022 00:26:46 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=wenyang@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0V66rEDP_1646295994;
Received: from localhost(mailfrom:wenyang@linux.alibaba.com fp:SMTPD_---0V66rEDP_1646295994)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 03 Mar 2022 16:26:43 +0800
From:   Wen Yang <simon.wy@alibaba-inc.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Wen Yang <simon.wy@alibaba-inc.com>,
        mark rutland <mark.rutland@arm.com>,
        jiri olsa <jolsa@redhat.com>,
        namhyung kim <namhyung@kernel.org>,
        borislav petkov <bp@alien8.de>, x86@kernel.org,
        Wen Yang <wenyang@linux.alibaba.com>,
        "h. peter anvin" <hpa@zytor.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] perf/x86: improve the event scheduling to avoid unnecessary pmu_stop/start
Date:   Thu,  3 Mar 2022 16:26:22 +0800
Message-Id: <20220303082622.32847-2-simon.wy@alibaba-inc.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220303082622.32847-1-simon.wy@alibaba-inc.com>
References: <20220303082622.32847-1-simon.wy@alibaba-inc.com>
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

this issue has been there for a long time, we could reproduce it as follows:

1, run a script that periodically collects perf data, eg:
while true
do
    perf stat -e cache-misses,cache-misses,cache-misses -c 1 sleep 2
    perf stat -e cache-misses -c 1 sleep 2
    sleep 1
done

2, run another one to capture the ipc, eg:
perf stat -e cycles:d,instructions:d  -c 1 -i 1000

then we could observe that the counter used by cycles:d changes frequently:
crash> struct  cpu_hw_events.n_events,assign,event_list,events 0xffff88bf7f44f420
  n_events = 3
  assign = {33, 1, 32, 0, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
  event_list = {0xffff88bf77b85000, 0xffff88b72db82000, 0xffff88b72db85800, 0xffff88ff6cfcb000, 0xffff88ff609f1800, 0xffff88ff609f1800, 0xffff88ff5f46a800, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}
  events = {0x0, 0xffff88b72db82000, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0xffff88b72db85800, 0xffff88bf77b85000, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}

crash> struct  cpu_hw_events.n_events,assign,event_list,events  0xffff88bf7f44f420
  n_events = 6
  assign = {33, 3, 32, 0, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
  event_list = {0xffff88bf77b85000, 0xffff88b72db82000, 0xffff88b72db85800, 0xffff88bf46c34000, 0xffff88bf46c35000, 0xffff88bf46c30000, 0xffff88ff5f46a800, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}
  events = {0xffff88bf46c34000, 0xffff88bf46c35000, 0xffff88bf46c30000, 0xffff88b72db82000, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0xffff88b72db85800, 0xffff88bf77b85000, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}

the reason is that the nmi watchdog permanently consumes one fp
(*cycles*). therefore, when the above shell script obtains *cycles*
again, only one gp can be used, and its weight is 5.
but other events (like *cache-misses*) have a weight of 4,
so the counter used by *cycles* will often be taken away, as in
the raw data above:
[1]
  n_events = 3
  assign = {33, 1, 32, ...}
-->
  n_events = 6
  assign = {33, 3, 32, 0, 1, 2, ...}

so it will cause unnecessary pmu_stop/start and also cause abnormal cpi.

Cloud servers usually continuously monitor the cpi data of some important
services. This issue affects performance and misleads monitoring.

The current event scheduling algorithm is more than 10 years old:
https://lwn.net/articles/357631/

we wish it could be optimized a bit.
The fields msk_counters and msk_events are added to indicate currently
used counters and events so that the used ones can be skipped
in __perf_sched_find_counter and perf_sched_next_event functions to avoid
unnecessary pmu_stop/start.

[1]:
32: intel_pmc_idx_fixed_instructions
33: intel_pmc_idx_fixed_cpu_cycles
34: intel_pmc_idx_fixed_ref_cycles
0,1,2,3: gp

signed-off-by: Wen Yang <simon.wy@alibaba-inc.com>
cc: peter zijlstra (intel) <peterz@infradead.org>
cc: ingo molnar <mingo@redhat.com>
cc: arnaldo carvalho de melo <acme@kernel.org>
cc: mark rutland <mark.rutland@arm.com>
cc: alexander shishkin <alexander.shishkin@linux.intel.com>
cc: jiri olsa <jolsa@redhat.com>
cc: namhyung kim <namhyung@kernel.org>
cc: thomas gleixner <tglx@linutronix.de>
cc: borislav petkov <bp@alien8.de>
cc: x86@kernel.org
cc: Wen Yang <wenyang@linux.alibaba.com>
cc: "h. peter anvin" <hpa@zytor.com>
cc: linux-perf-users@vger.kernel.org
cc: linux-kernel@vger.kernel.org
---
 arch/x86/events/core.c | 93 +++++++++++++++++++++++++++++++++---------
 1 file changed, 74 insertions(+), 19 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 9846d422f06d..88313d669756 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -796,33 +796,67 @@ struct perf_sched {
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
+		int num, int wmin, u64 msk_events)
+{
+	int tmp = wmin;
+	int idx;
+
+	if (!msk_events)
+		goto out;
+
+	for (idx = 0; idx < num; idx++) {
+		if (msk_events & BIT_ULL(idx))
+			continue;
+
+		tmp = min(tmp, constraints[idx]->weight);
+	}
+
+out:
+	return tmp;
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
+			    int num, int wmin, int wmax, int gpmax, u64 cntm, u64 evtm)
 {
-	int idx;
-
 	memset(sched, 0, sizeof(*sched));
 	sched->max_events	= num;
 	sched->max_weight	= wmax;
 	sched->max_gp		= gpmax;
 	sched->constraints	= constraints;
+	sched->msk_counters = cntm;
+	sched->msk_events   = evtm;
 
-	for (idx = 0; idx < num; idx++) {
-		if (constraints[idx]->weight == wmin)
-			break;
-	}
-
-	sched->state.event	= idx;		/* start with min weight */
-	sched->state.weight	= wmin;
-	sched->state.unassigned	= num;
+	sched->state.weight = perf_sched_calc_weight(constraints, num, wmin, cntm);
+	sched->state.event = perf_sched_calc_event(constraints, num, sched->state.weight, evtm);
+	sched->state.unassigned = num - hweight_long(evtm);
 }
 
 static void perf_sched_save_state(struct perf_sched *sched)
@@ -874,6 +908,9 @@ static bool __perf_sched_find_counter(struct perf_sched *sched)
 		for_each_set_bit_from(idx, c->idxmsk, X86_PMC_IDX_MAX) {
 			u64 mask = BIT_ULL(idx);
 
+			if (sched->msk_counters & mask)
+				continue;
+
 			if (sched->state.used & mask)
 				continue;
 
@@ -890,6 +927,9 @@ static bool __perf_sched_find_counter(struct perf_sched *sched)
 		if (c->flags & PERF_X86_EVENT_PAIR)
 			mask |= mask << 1;
 
+		if (sched->msk_counters & mask)
+			continue;
+
 		if (sched->state.used & mask)
 			continue;
 
@@ -921,6 +961,12 @@ static bool perf_sched_find_counter(struct perf_sched *sched)
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
@@ -935,9 +981,12 @@ static bool perf_sched_next_event(struct perf_sched *sched)
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
@@ -951,11 +1000,11 @@ static bool perf_sched_next_event(struct perf_sched *sched)
 }
 
 int _perf_assign_events(struct event_constraint **constraints, int n,
-			int wmin, int wmax, int gpmax, int *assign)
+			int wmin, int wmax, int gpmax, u64 cntm, u64 evtm, int *assign)
 {
 	struct perf_sched sched;
 
-	perf_sched_init(&sched, constraints, n, wmin, wmax, gpmax);
+	perf_sched_init(&sched, constraints, n, wmin, wmax, gpmax, cntm, evtm);
 
 	do {
 		if (!perf_sched_find_counter(&sched))
@@ -976,7 +1025,8 @@ int perf_assign_events(struct perf_event **event_list,
 {
 	struct event_constraint *c;
 	struct hw_perf_event *hwc;
-	u64 used_mask = 0;
+	u64 msk_counters = 0;
+	u64 msk_event = 0;
 	int unsched = 0;
 	int i;
 
@@ -1002,19 +1052,24 @@ int perf_assign_events(struct perf_event **event_list,
 			mask |= mask << 1;
 
 		/* not already used */
-		if (used_mask & mask)
+		if (msk_counters & mask)
 			break;
 
-		used_mask |= mask;
+		msk_counters |= mask;
+		msk_event |= BIT_ULL(i);
 
 		if (assign)
 			assign[i] = hwc->idx;
 	}
 
 	/* slow path */
-	if (i != n)
-		unsched = _perf_assign_events(constraints, n,
-				wmin, wmax, gpmax, assign);
+	if (i != n) {
+		unsched = _perf_assign_events(constraints, n, wmin, wmax, gpmax,
+				msk_counters, msk_event, assign);
+		if (unsched)
+			unsched = _perf_assign_events(constraints, n, wmin, wmax, gpmax,
+					0, 0, assign);
+	}
 
 	return unsched;
 }
-- 
2.19.1.6.gb485710b

