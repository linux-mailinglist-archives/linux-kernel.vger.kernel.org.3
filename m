Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40F47544A47
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 13:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233935AbiFILcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 07:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243176AbiFILbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 07:31:40 -0400
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE6A43A79FB
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 04:31:18 -0700 (PDT)
Received: by mail-ed1-x54a.google.com with SMTP id ee46-20020a056402292e00b0042dd4d6054dso16833221edb.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 04:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=WcGBHtbaqL7btwnwCehWzC9DdtYID6QXS6Q+AzJHJpo=;
        b=FUHqgrymmD/1yS6eajWNPNkLHwczgi647YPiMvdMd8wKh4/2sjqiaRXlAA620pm4Mv
         xL9r1xgoQJCeRUF1AfHW4m3wwQ8dBMPuJAP+MS3Gf5Y4Q60vW28etT5n4Qhzynpw2KlW
         SSVheyu7eK0bXuB94IqvRRPEZWUAGiG94P9UljvrtyMvC/mSSOEArG+bKmndPV4CGitO
         wDBW7o2Agqcv1HgI7082Kz0V0EtABzWdXhs7xBTwIj93xRyEar5DBQPibE84GDP4kT4l
         aCFjysDsm/A75pLI9BoCvtbcKb45WhhYACi7rL+A8fAmZPWBVhJtRTNOPQ0mx7QAsnKn
         2JAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=WcGBHtbaqL7btwnwCehWzC9DdtYID6QXS6Q+AzJHJpo=;
        b=S11YkB/SLLe3wxdOJqahmG66odIijCRWEyNdDm0Xy/pGrmZMrud6L245i9GcYofzRD
         ClKfRXuEasWdUK5STnOzHz+wOGA8thh/1MYzA37JJ6YVBV8ysDWrT9+dUurq2NsspY+i
         dFUds9dHc2fjs5Rmcnc9BSvUDOmhy4AGVIlv8R1WcYDcgX7tMK0NrWhRLLYpBWmW70dd
         0oKPdOKLm3XJKt2DguhX/AgiEiT4nHjS18jsulVIv6p8rMFZn1gOEhYv5BJVtspm0V+r
         1u3cJ32F+6FFoMslLrXm3SBXKbguB4LrjIUR2vIqM3fns/hXaGmc8NWgjGf6eunk9lF4
         vgng==
X-Gm-Message-State: AOAM53153UIF7oHOi39E1bxKRS459RHH4Hajk/WB3eaKR4kuV82C0oYk
        uej+M19O61iq7GtV8a4OrKZ9p/lCyg==
X-Google-Smtp-Source: ABdhPJxvw8djj03eIGJz3wC6dhNkuY0kMcjHQnolA0VMoUo95H0kQsdBeZko+WfPF714kuHSsxB//Ounew==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:9c:201:dcf:e5ba:10a5:1ea5])
 (user=elver job=sendgmr) by 2002:aa7:c306:0:b0:42d:d4cc:c606 with SMTP id
 l6-20020aa7c306000000b0042dd4ccc606mr44735253edq.341.1654774277090; Thu, 09
 Jun 2022 04:31:17 -0700 (PDT)
Date:   Thu,  9 Jun 2022 13:30:45 +0200
In-Reply-To: <20220609113046.780504-1-elver@google.com>
Message-Id: <20220609113046.780504-8-elver@google.com>
Mime-Version: 1.0
References: <20220609113046.780504-1-elver@google.com>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH 7/8] perf/hw_breakpoint: Optimize task_bp_pinned() if CPU-independent
From:   Marco Elver <elver@google.com>
To:     elver@google.com, Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-perf-users@vger.kernel.org, x86@kernel.org,
        linux-sh@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Running the perf benchmark with (note: more aggressive parameters vs.
preceding changes, but same host with 256 CPUs):

 | $> perf bench -r 100 breakpoint thread -b 4 -p 128 -t 512
 | # Running 'breakpoint/thread' benchmark:
 | # Created/joined 100 threads with 4 breakpoints and 128 parallelism
 |      Total time: 1.953 [sec]
 |
 |       38.146289 usecs/op
 |     4882.725000 usecs/op/cpu

    16.29%  [kernel]       [k] rhashtable_jhash2
    16.19%  [kernel]       [k] osq_lock
    14.22%  [kernel]       [k] queued_spin_lock_slowpath
     8.58%  [kernel]       [k] task_bp_pinned
     8.30%  [kernel]       [k] mutex_spin_on_owner
     4.03%  [kernel]       [k] smp_cfm_core_cond
     2.97%  [kernel]       [k] toggle_bp_slot
     2.94%  [kernel]       [k] bcmp

We can see that a majority of the time is now spent hashing task
pointers to index into task_bps_ht in task_bp_pinned().

However, if task_bp_pinned()'s computation is independent of any CPU,
i.e. always `iter->cpu < 0`, the result for each invocation will be
identical. With increasing CPU-count, this problem worsens.

Instead, identify if every call to task_bp_pinned() is CPU-independent,
and cache the result. Use the cached result instead of a call to
task_bp_pinned(), now __task_bp_pinned(), with task_bp_pinned() deciding
if the cached result can be used.

After this optimization:

    21.96%  [kernel]       [k] queued_spin_lock_slowpath
    16.39%  [kernel]       [k] osq_lock
     9.82%  [kernel]       [k] toggle_bp_slot
     9.81%  [kernel]       [k] find_next_bit
     4.93%  [kernel]       [k] mutex_spin_on_owner
     4.71%  [kernel]       [k] smp_cfm_core_cond
     4.30%  [kernel]       [k] __reserve_bp_slot
     2.65%  [kernel]       [k] cpumask_next

Showing that the time spent hashing keys has become insignificant.

With the given benchmark parameters, however, we see no statistically
significant improvement in performance on the test system with 256 CPUs.
This is very likely due to the benchmark parameters being too aggressive
and contention elsewhere becoming dominant.

Indeed, when using the less aggressive parameters from the preceding
changes, we now observe:

 | $> perf bench -r 30 breakpoint thread -b 4 -p 64 -t 64
 | # Running 'breakpoint/thread' benchmark:
 | # Created/joined 30 threads with 4 breakpoints and 64 parallelism
 |      Total time: 0.071 [sec]
 |
 |       37.134896 usecs/op
 |     2376.633333 usecs/op/cpu

Which is an improvement of 12% compared to without this optimization
(baseline is 42 usecs/op). This is now only 5% slower than the
theoretical ideal (constraints disabled), and 18% slower than no
breakpoints at all.

[ While we're here, swap task_bp_pinned()'s bp and cpu arguments to be
  more consistent with other functions (which have bp first, before the
  cpu argument). ]

Signed-off-by: Marco Elver <elver@google.com>
---
 kernel/events/hw_breakpoint.c | 71 +++++++++++++++++++++++++----------
 1 file changed, 52 insertions(+), 19 deletions(-)

diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
index 08c9ed0626e4..3b33a4075104 100644
--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -242,11 +242,22 @@ static unsigned int max_task_bp_pinned(int cpu, enum bp_type_idx type)
  * Count the number of breakpoints of the same type and same task.
  * The given event must be not on the list.
  */
-static int task_bp_pinned(int cpu, struct perf_event *bp, enum bp_type_idx type)
+struct task_bp_pinned {
+	/*
+	 * If @cpu_independent is true, we can avoid calling __task_bp_pinned()
+	 * for each CPU, since @count will be the same for each invocation.
+	 */
+	bool cpu_independent;
+	int count;
+	struct perf_event *bp;
+	enum bp_type_idx type;
+};
+static struct task_bp_pinned
+__task_bp_pinned(struct perf_event *bp, int cpu, enum bp_type_idx type)
 {
+	struct task_bp_pinned ret = {true, 0, bp, type};
 	struct rhlist_head *head, *pos;
 	struct perf_event *iter;
-	int count = 0;
 
 	/*
 	 * We need a stable snapshot of the per-task breakpoint list.
@@ -259,14 +270,33 @@ static int task_bp_pinned(int cpu, struct perf_event *bp, enum bp_type_idx type)
 		goto out;
 
 	rhl_for_each_entry_rcu(iter, pos, head, hw.bp_list) {
-		if (find_slot_idx(iter->attr.bp_type) == type &&
-		    (iter->cpu < 0 || cpu == iter->cpu))
-			count += hw_breakpoint_weight(iter);
+		if (find_slot_idx(iter->attr.bp_type) == type) {
+			if (iter->cpu >= 0) {
+				ret.cpu_independent = false;
+				if (cpu != iter->cpu)
+					continue;
+			}
+			ret.count += hw_breakpoint_weight(iter);
+		}
 	}
 
 out:
 	rcu_read_unlock();
-	return count;
+	return ret;
+}
+
+static int
+task_bp_pinned(struct perf_event *bp, int cpu, enum bp_type_idx type,
+	       struct task_bp_pinned *cached_tbp_pinned)
+{
+	if (cached_tbp_pinned->cpu_independent) {
+		assert_bp_constraints_lock_held(bp);
+		if (!WARN_ON(cached_tbp_pinned->bp != bp || cached_tbp_pinned->type != type))
+			return cached_tbp_pinned->count;
+	}
+
+	*cached_tbp_pinned = __task_bp_pinned(bp, cpu, type);
+	return cached_tbp_pinned->count;
 }
 
 static const struct cpumask *cpumask_of_bp(struct perf_event *bp)
@@ -281,8 +311,8 @@ static const struct cpumask *cpumask_of_bp(struct perf_event *bp)
  * a given cpu (cpu > -1) or in all of them (cpu = -1).
  */
 static void
-fetch_bp_busy_slots(struct bp_busy_slots *slots, struct perf_event *bp,
-		    enum bp_type_idx type)
+fetch_bp_busy_slots(struct bp_busy_slots *slots, struct perf_event *bp, enum bp_type_idx type,
+		    struct task_bp_pinned *cached_tbp_pinned)
 {
 	const struct cpumask *cpumask = cpumask_of_bp(bp);
 	int cpu;
@@ -295,7 +325,7 @@ fetch_bp_busy_slots(struct bp_busy_slots *slots, struct perf_event *bp,
 		if (!bp->hw.target)
 			nr += max_task_bp_pinned(cpu, type);
 		else
-			nr += task_bp_pinned(cpu, bp, type);
+			nr += task_bp_pinned(bp, cpu, type, cached_tbp_pinned);
 
 		if (nr > slots->pinned)
 			slots->pinned = nr;
@@ -314,10 +344,11 @@ fetch_this_slot(struct bp_busy_slots *slots, int weight)
 }
 
 /*
- * Add a pinned breakpoint for the given task in our constraint table
+ * Add a pinned breakpoint for the given task in our constraint table.
  */
-static void toggle_bp_task_slot(struct perf_event *bp, int cpu,
-				enum bp_type_idx type, int weight)
+static void
+toggle_bp_task_slot(struct perf_event *bp, int cpu, enum bp_type_idx type, int weight,
+		    struct task_bp_pinned *cached_tbp_pinned)
 {
 	atomic_t *tsk_pinned = get_bp_info(cpu, type)->tsk_pinned;
 	int old_idx, new_idx;
@@ -331,7 +362,7 @@ static void toggle_bp_task_slot(struct perf_event *bp, int cpu,
 	 */
 	lockdep_assert_held_read(&bp_cpuinfo_lock);
 
-	old_idx = task_bp_pinned(cpu, bp, type) - 1;
+	old_idx = task_bp_pinned(bp, cpu, type, cached_tbp_pinned) - 1;
 	new_idx = old_idx + weight;
 
 	if (old_idx >= 0)
@@ -341,11 +372,11 @@ static void toggle_bp_task_slot(struct perf_event *bp, int cpu,
 }
 
 /*
- * Add/remove the given breakpoint in our constraint table
+ * Add/remove the given breakpoint in our constraint table.
  */
 static int
 toggle_bp_slot(struct perf_event *bp, bool enable, enum bp_type_idx type,
-	       int weight)
+	       int weight, struct task_bp_pinned *cached_tbp_pinned)
 {
 	const struct cpumask *cpumask = cpumask_of_bp(bp);
 	int cpu;
@@ -362,7 +393,7 @@ toggle_bp_slot(struct perf_event *bp, bool enable, enum bp_type_idx type,
 
 	/* Pinned counter task profiling */
 	for_each_cpu(cpu, cpumask)
-		toggle_bp_task_slot(bp, cpu, type, weight);
+		toggle_bp_task_slot(bp, cpu, type, weight, cached_tbp_pinned);
 
 	/*
 	 * Readers want a stable snapshot of the per-task breakpoint list.
@@ -439,6 +470,7 @@ __weak void arch_unregister_hw_breakpoint(struct perf_event *bp)
  */
 static int __reserve_bp_slot(struct perf_event *bp, u64 bp_type)
 {
+	struct task_bp_pinned cached_tbp_pinned = {};
 	struct bp_busy_slots slots = {0};
 	enum bp_type_idx type;
 	int weight;
@@ -456,7 +488,7 @@ static int __reserve_bp_slot(struct perf_event *bp, u64 bp_type)
 	type = find_slot_idx(bp_type);
 	weight = hw_breakpoint_weight(bp);
 
-	fetch_bp_busy_slots(&slots, bp, type);
+	fetch_bp_busy_slots(&slots, bp, type, &cached_tbp_pinned);
 	/*
 	 * Simulate the addition of this breakpoint to the constraints
 	 * and see the result.
@@ -471,7 +503,7 @@ static int __reserve_bp_slot(struct perf_event *bp, u64 bp_type)
 	if (ret)
 		return ret;
 
-	return toggle_bp_slot(bp, true, type, weight);
+	return toggle_bp_slot(bp, true, type, weight, &cached_tbp_pinned);
 }
 
 int reserve_bp_slot(struct perf_event *bp)
@@ -485,6 +517,7 @@ int reserve_bp_slot(struct perf_event *bp)
 
 static void __release_bp_slot(struct perf_event *bp, u64 bp_type)
 {
+	struct task_bp_pinned cached_tbp_pinned = {};
 	enum bp_type_idx type;
 	int weight;
 
@@ -492,7 +525,7 @@ static void __release_bp_slot(struct perf_event *bp, u64 bp_type)
 
 	type = find_slot_idx(bp_type);
 	weight = hw_breakpoint_weight(bp);
-	WARN_ON(toggle_bp_slot(bp, false, type, weight));
+	WARN_ON(toggle_bp_slot(bp, false, type, weight, &cached_tbp_pinned));
 }
 
 void release_bp_slot(struct perf_event *bp)
-- 
2.36.1.255.ge46751e96f-goog

