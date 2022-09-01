Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4265A91CD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 10:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234018AbiIAINC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 04:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233595AbiIAIMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 04:12:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A680412BF5C;
        Thu,  1 Sep 2022 01:12:42 -0700 (PDT)
Date:   Thu, 01 Sep 2022 08:12:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1662019960;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SxJxNz1lQXPy2WrJVNDLf3/Fm15UeJg651+15oUsjK4=;
        b=f4bsteX2zvlHzGJJpWwWsf9iMBRakQy0vGeJ6WTNkp+VczHp3TjbXSnQWQTlcvY1himsBV
        yvpolV/K0GFDDJnTpnc37eiPBuUkAZwyWfCIHIrY7R+p0AkKLFzXIJV3cYdp+W5WR9wGqd
        lxHz60WmvwNa9BbG+OXnDnBOzwh2tWBqOXo6zbQ+Sx80Sl+bxJ7Nr+wTuc8gAaDA06STZI
        YbdozU9wJEqL2r4FGxAfivf5Slh+Q69+RtLaEX+jwuj7PXILRFo+6fwSsh1YiIh2IkXXBo
        MFaJJWjCyV6hC0F8iNrgqa+r5d7w+kwe7Hzz4AZucXLySjinPCDv/R73DpZNsQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1662019960;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SxJxNz1lQXPy2WrJVNDLf3/Fm15UeJg651+15oUsjK4=;
        b=1qZr+zpnq5excDqH5zMF+gVvtfiie2Dn5AdjEp5Rv/9uo91YwKOFHVVcWXAj4MMt9K1VEl
        7T7v9SJnXymdfWAg==
From:   "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/hw_breakpoint: Optimize toggle_bp_slot() for
 CPU-independent task targets
Cc:     Marco Elver <elver@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ian Rogers <irogers@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220829124719.675715-15-elver@google.com>
References: <20220829124719.675715-15-elver@google.com>
MIME-Version: 1.0
Message-ID: <166201995893.401.15548578752792395750.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     ecdfb8896f2ad733097e6309d64f94db4cd1020c
Gitweb:        https://git.kernel.org/tip/ecdfb8896f2ad733097e6309d64f94db4cd1020c
Author:        Marco Elver <elver@google.com>
AuthorDate:    Mon, 29 Aug 2022 14:47:19 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 30 Aug 2022 10:56:24 +02:00

perf/hw_breakpoint: Optimize toggle_bp_slot() for CPU-independent task targets

We can still see that a majority of the time is spent hashing task pointers:

    ...
    16.98%  [kernel]       [k] rhashtable_jhash2
    ...

Doing the bookkeeping in toggle_bp_slots() is currently O(#cpus),
calling task_bp_pinned() for each CPU, even if task_bp_pinned() is
CPU-independent. The reason for this is to update the per-CPU
'tsk_pinned' histogram.

To optimize the CPU-independent case to O(1), keep a separate
CPU-independent 'tsk_pinned_all' histogram.

The major source of complexity are transitions between "all
CPU-independent task breakpoints" and "mixed CPU-independent and
CPU-dependent task breakpoints". The code comments list all cases that
require handling.

After this optimization:

 | $> perf bench -r 100 breakpoint thread -b 4 -p 128 -t 512
 | # Running 'breakpoint/thread' benchmark:
 | # Created/joined 100 threads with 4 breakpoints and 128 parallelism
 |      Total time: 1.758 [sec]
 |
 |       34.336621 usecs/op
 |     4395.087500 usecs/op/cpu

    38.08%  [kernel]       [k] queued_spin_lock_slowpath
    10.81%  [kernel]       [k] smp_cfm_core_cond
     3.01%  [kernel]       [k] update_sg_lb_stats
     2.58%  [kernel]       [k] osq_lock
     2.57%  [kernel]       [k] llist_reverse_order
     1.45%  [kernel]       [k] find_next_bit
     1.21%  [kernel]       [k] flush_tlb_func_common
     1.01%  [kernel]       [k] arch_install_hw_breakpoint

Showing that the time spent hashing keys has become insignificant.

With the given benchmark parameters, that's an improvement of 12%
compared with the old O(#cpus) version.

And finally, using the less aggressive parameters from the preceding
changes, we now observe:

 | $> perf bench -r 30 breakpoint thread -b 4 -p 64 -t 64
 | # Running 'breakpoint/thread' benchmark:
 | # Created/joined 30 threads with 4 breakpoints and 64 parallelism
 |      Total time: 0.067 [sec]
 |
 |       35.292187 usecs/op
 |     2258.700000 usecs/op/cpu

Which is an improvement of 12% compared to without the histogram
optimizations (baseline is 40 usecs/op). This is now on par with the
theoretical ideal (constraints disabled), and only 12% slower than no
breakpoints at all.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Acked-by: Ian Rogers <irogers@google.com>
Link: https://lore.kernel.org/r/20220829124719.675715-15-elver@google.com
---
 kernel/events/hw_breakpoint.c | 155 ++++++++++++++++++++++++++-------
 1 file changed, 124 insertions(+), 31 deletions(-)

diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
index a489f31..7ef0e98 100644
--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -66,6 +66,8 @@ static struct bp_cpuinfo *get_bp_info(int cpu, enum bp_type_idx type)
 
 /* Number of pinned CPU breakpoints globally. */
 static struct bp_slots_histogram cpu_pinned[TYPE_MAX];
+/* Number of pinned CPU-independent task breakpoints. */
+static struct bp_slots_histogram tsk_pinned_all[TYPE_MAX];
 
 /* Keep track of the breakpoints attached to tasks */
 static struct rhltable task_bps_ht;
@@ -200,6 +202,8 @@ static __init int init_breakpoint_slots(void)
 	for (i = 0; i < TYPE_MAX; i++) {
 		if (!bp_slots_histogram_alloc(&cpu_pinned[i], i))
 			goto err;
+		if (!bp_slots_histogram_alloc(&tsk_pinned_all[i], i))
+			goto err;
 	}
 
 	return 0;
@@ -210,8 +214,10 @@ err:
 		if (err_cpu == cpu)
 			break;
 	}
-	for (i = 0; i < TYPE_MAX; i++)
+	for (i = 0; i < TYPE_MAX; i++) {
 		bp_slots_histogram_free(&cpu_pinned[i]);
+		bp_slots_histogram_free(&tsk_pinned_all[i]);
+	}
 
 	return -ENOMEM;
 }
@@ -245,6 +251,26 @@ bp_slots_histogram_max(struct bp_slots_histogram *hist, enum bp_type_idx type)
 	return 0;
 }
 
+static int
+bp_slots_histogram_max_merge(struct bp_slots_histogram *hist1, struct bp_slots_histogram *hist2,
+			     enum bp_type_idx type)
+{
+	for (int i = hw_breakpoint_slots_cached(type) - 1; i >= 0; i--) {
+		const int count1 = atomic_read(&hist1->count[i]);
+		const int count2 = atomic_read(&hist2->count[i]);
+
+		/* Catch unexpected writers; we want a stable snapshot. */
+		ASSERT_EXCLUSIVE_WRITER(hist1->count[i]);
+		ASSERT_EXCLUSIVE_WRITER(hist2->count[i]);
+		if (count1 + count2 > 0)
+			return i + 1;
+		WARN(count1 < 0, "inconsistent breakpoint slots histogram");
+		WARN(count2 < 0, "inconsistent breakpoint slots histogram");
+	}
+
+	return 0;
+}
+
 #ifndef hw_breakpoint_weight
 static inline int hw_breakpoint_weight(struct perf_event *bp)
 {
@@ -273,7 +299,7 @@ static unsigned int max_task_bp_pinned(int cpu, enum bp_type_idx type)
 	 * toggle_bp_task_slot() to tsk_pinned, and we get a stable snapshot.
 	 */
 	lockdep_assert_held_write(&bp_cpuinfo_sem);
-	return bp_slots_histogram_max(tsk_pinned, type);
+	return bp_slots_histogram_max_merge(tsk_pinned, &tsk_pinned_all[type], type);
 }
 
 /*
@@ -367,39 +393,21 @@ max_bp_pinned_slots(struct perf_event *bp, enum bp_type_idx type)
 }
 
 /*
- * Add a pinned breakpoint for the given task in our constraint table
- */
-static void toggle_bp_task_slot(struct perf_event *bp, int cpu,
-				enum bp_type_idx type, int weight)
-{
-	struct bp_slots_histogram *tsk_pinned = &get_bp_info(cpu, type)->tsk_pinned;
-
-	/*
-	 * If bp->hw.target, tsk_pinned is only modified, but not used
-	 * otherwise. We can permit concurrent updates as long as there are no
-	 * other uses: having acquired bp_cpuinfo_sem as a reader allows
-	 * concurrent updates here. Uses of tsk_pinned will require acquiring
-	 * bp_cpuinfo_sem as a writer to stabilize tsk_pinned's value.
-	 */
-	lockdep_assert_held_read(&bp_cpuinfo_sem);
-	bp_slots_histogram_add(tsk_pinned, task_bp_pinned(cpu, bp, type), weight);
-}
-
-/*
  * Add/remove the given breakpoint in our constraint table
  */
 static int
-toggle_bp_slot(struct perf_event *bp, bool enable, enum bp_type_idx type,
-	       int weight)
+toggle_bp_slot(struct perf_event *bp, bool enable, enum bp_type_idx type, int weight)
 {
-	const struct cpumask *cpumask = cpumask_of_bp(bp);
-	int cpu;
+	int cpu, next_tsk_pinned;
 
 	if (!enable)
 		weight = -weight;
 
-	/* Pinned counter cpu profiling */
 	if (!bp->hw.target) {
+		/*
+		 * Update the pinned CPU slots, in per-CPU bp_cpuinfo and in the
+		 * global histogram.
+		 */
 		struct bp_cpuinfo *info = get_bp_info(bp->cpu, type);
 
 		lockdep_assert_held_write(&bp_cpuinfo_sem);
@@ -408,9 +416,91 @@ toggle_bp_slot(struct perf_event *bp, bool enable, enum bp_type_idx type,
 		return 0;
 	}
 
-	/* Pinned counter task profiling */
-	for_each_cpu(cpu, cpumask)
-		toggle_bp_task_slot(bp, cpu, type, weight);
+	/*
+	 * If bp->hw.target, tsk_pinned is only modified, but not used
+	 * otherwise. We can permit concurrent updates as long as there are no
+	 * other uses: having acquired bp_cpuinfo_sem as a reader allows
+	 * concurrent updates here. Uses of tsk_pinned will require acquiring
+	 * bp_cpuinfo_sem as a writer to stabilize tsk_pinned's value.
+	 */
+	lockdep_assert_held_read(&bp_cpuinfo_sem);
+
+	/*
+	 * Update the pinned task slots, in per-CPU bp_cpuinfo and in the global
+	 * histogram. We need to take care of 4 cases:
+	 *
+	 *  1. This breakpoint targets all CPUs (cpu < 0), and there may only
+	 *     exist other task breakpoints targeting all CPUs. In this case we
+	 *     can simply update the global slots histogram.
+	 *
+	 *  2. This breakpoint targets a specific CPU (cpu >= 0), but there may
+	 *     only exist other task breakpoints targeting all CPUs.
+	 *
+	 *     a. On enable: remove the existing breakpoints from the global
+	 *        slots histogram and use the per-CPU histogram.
+	 *
+	 *     b. On disable: re-insert the existing breakpoints into the global
+	 *        slots histogram and remove from per-CPU histogram.
+	 *
+	 *  3. Some other existing task breakpoints target specific CPUs. Only
+	 *     update the per-CPU slots histogram.
+	 */
+
+	if (!enable) {
+		/*
+		 * Remove before updating histograms so we can determine if this
+		 * was the last task breakpoint for a specific CPU.
+		 */
+		int ret = rhltable_remove(&task_bps_ht, &bp->hw.bp_list, task_bps_ht_params);
+
+		if (ret)
+			return ret;
+	}
+	/*
+	 * Note: If !enable, next_tsk_pinned will not count the to-be-removed breakpoint.
+	 */
+	next_tsk_pinned = task_bp_pinned(-1, bp, type);
+
+	if (next_tsk_pinned >= 0) {
+		if (bp->cpu < 0) { /* Case 1: fast path */
+			if (!enable)
+				next_tsk_pinned += hw_breakpoint_weight(bp);
+			bp_slots_histogram_add(&tsk_pinned_all[type], next_tsk_pinned, weight);
+		} else if (enable) { /* Case 2.a: slow path */
+			/* Add existing to per-CPU histograms. */
+			for_each_possible_cpu(cpu) {
+				bp_slots_histogram_add(&get_bp_info(cpu, type)->tsk_pinned,
+						       0, next_tsk_pinned);
+			}
+			/* Add this first CPU-pinned task breakpoint. */
+			bp_slots_histogram_add(&get_bp_info(bp->cpu, type)->tsk_pinned,
+					       next_tsk_pinned, weight);
+			/* Rebalance global task pinned histogram. */
+			bp_slots_histogram_add(&tsk_pinned_all[type], next_tsk_pinned,
+					       -next_tsk_pinned);
+		} else { /* Case 2.b: slow path */
+			/* Remove this last CPU-pinned task breakpoint. */
+			bp_slots_histogram_add(&get_bp_info(bp->cpu, type)->tsk_pinned,
+					       next_tsk_pinned + hw_breakpoint_weight(bp), weight);
+			/* Remove all from per-CPU histograms. */
+			for_each_possible_cpu(cpu) {
+				bp_slots_histogram_add(&get_bp_info(cpu, type)->tsk_pinned,
+						       next_tsk_pinned, -next_tsk_pinned);
+			}
+			/* Rebalance global task pinned histogram. */
+			bp_slots_histogram_add(&tsk_pinned_all[type], 0, next_tsk_pinned);
+		}
+	} else { /* Case 3: slow path */
+		const struct cpumask *cpumask = cpumask_of_bp(bp);
+
+		for_each_cpu(cpu, cpumask) {
+			next_tsk_pinned = task_bp_pinned(cpu, bp, type);
+			if (!enable)
+				next_tsk_pinned += hw_breakpoint_weight(bp);
+			bp_slots_histogram_add(&get_bp_info(cpu, type)->tsk_pinned,
+					       next_tsk_pinned, weight);
+		}
+	}
 
 	/*
 	 * Readers want a stable snapshot of the per-task breakpoint list.
@@ -419,8 +509,8 @@ toggle_bp_slot(struct perf_event *bp, bool enable, enum bp_type_idx type,
 
 	if (enable)
 		return rhltable_insert(&task_bps_ht, &bp->hw.bp_list, task_bps_ht_params);
-	else
-		return rhltable_remove(&task_bps_ht, &bp->hw.bp_list, task_bps_ht_params);
+
+	return 0;
 }
 
 __weak int arch_reserve_bp_slot(struct perf_event *bp)
@@ -850,6 +940,9 @@ bool hw_breakpoint_is_used(void)
 			 */
 			if (WARN_ON(atomic_read(&cpu_pinned[type].count[slot])))
 				return true;
+
+			if (atomic_read(&tsk_pinned_all[type].count[slot]))
+				return true;
 		}
 	}
 
