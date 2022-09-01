Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4AD55A91C9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 10:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233903AbiIAIMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 04:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233456AbiIAIMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 04:12:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0105712BF64;
        Thu,  1 Sep 2022 01:12:43 -0700 (PDT)
Date:   Thu, 01 Sep 2022 08:12:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1662019962;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KXCYfrWPHVVNI3QBPjP1gsWiz765VgdwDg9RL+n6P6o=;
        b=Zg/TXx9vHg/MyPYKMIGjShDZmjgXBJ1V7IYXBFWoD5gIYNtaln/KdzXBWenaAU0+K+xLnV
        TkLmjw7fynFMqOcX+nvj1CSDClR9cYV0Vvj/ZEDQLqMqg0VMOoRiKjCFB8Ol4QrDGROi4v
        RkxlTPglhc4FyUnp0ettHNCluSliV6Qz98cr1GRU6bJ8X80IyyyF2dEJEONDRq9I48sP6q
        PaF7u1QfqeJZgz1u23yUbqiZLiOwgiekZFdVyDHxYtv2lHDvRN5nhCkw79XzZ0W8XAb3vS
        NuYMlChE+BImxmLcbwuVl0k9sAsIeZ5xRt3P0+c4NecTn6fvBMnfrIaNReSCMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1662019962;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KXCYfrWPHVVNI3QBPjP1gsWiz765VgdwDg9RL+n6P6o=;
        b=1HezpRRJ85yFUCOZWeGakvuzL3JW+6eq9vEkn3NHW3+Pc1fL7XWTNyJKfotKu9L39kjihc
        lXqdGpd2aCIyY3Bg==
From:   "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/hw_breakpoint: Introduce bp_slots_histogram
Cc:     Marco Elver <elver@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ian Rogers <irogers@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220829124719.675715-13-elver@google.com>
References: <20220829124719.675715-13-elver@google.com>
MIME-Version: 1.0
Message-ID: <166201996127.401.10501433251354879073.tip-bot2@tip-bot2>
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

Commit-ID:     16db2839a5a59c242df77308cf57342ce0c3768e
Gitweb:        https://git.kernel.org/tip/16db2839a5a59c242df77308cf57342ce0c3768e
Author:        Marco Elver <elver@google.com>
AuthorDate:    Mon, 29 Aug 2022 14:47:17 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 30 Aug 2022 10:56:24 +02:00

perf/hw_breakpoint: Introduce bp_slots_histogram

Factor out the existing `atomic_t count[N]` into its own struct called
'bp_slots_histogram', to generalize and make its intent clearer in
preparation of reusing elsewhere. The basic idea of bucketing "total
uses of N slots" resembles a histogram, so calling it such seems most
intuitive.

No functional change.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Acked-by: Ian Rogers <irogers@google.com>
Link: https://lore.kernel.org/r/20220829124719.675715-13-elver@google.com
---
 kernel/events/hw_breakpoint.c | 96 ++++++++++++++++++++++------------
 1 file changed, 63 insertions(+), 33 deletions(-)

diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
index 229c6f4..03ebecf 100644
--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -36,19 +36,27 @@
 #include <linux/slab.h>
 
 /*
- * Constraints data
+ * Datastructure to track the total uses of N slots across tasks or CPUs;
+ * bp_slots_histogram::count[N] is the number of assigned N+1 breakpoint slots.
  */
-struct bp_cpuinfo {
-	/* Number of pinned cpu breakpoints in a cpu */
-	unsigned int	cpu_pinned;
-	/* tsk_pinned[n] is the number of tasks having n+1 breakpoints */
+struct bp_slots_histogram {
 #ifdef hw_breakpoint_slots
-	atomic_t	tsk_pinned[hw_breakpoint_slots(0)];
+	atomic_t count[hw_breakpoint_slots(0)];
 #else
-	atomic_t	*tsk_pinned;
+	atomic_t *count;
 #endif
 };
 
+/*
+ * Per-CPU constraints data.
+ */
+struct bp_cpuinfo {
+	/* Number of pinned CPU breakpoints in a CPU. */
+	unsigned int			cpu_pinned;
+	/* Histogram of pinned task breakpoints in a CPU. */
+	struct bp_slots_histogram	tsk_pinned;
+};
+
 static DEFINE_PER_CPU(struct bp_cpuinfo, bp_cpuinfo[TYPE_MAX]);
 
 static struct bp_cpuinfo *get_bp_info(int cpu, enum bp_type_idx type)
@@ -159,6 +167,18 @@ static inline int hw_breakpoint_slots_cached(int type)
 	return __nr_bp_slots[type];
 }
 
+static __init bool
+bp_slots_histogram_alloc(struct bp_slots_histogram *hist, enum bp_type_idx type)
+{
+	hist->count = kcalloc(hw_breakpoint_slots_cached(type), sizeof(*hist->count), GFP_KERNEL);
+	return hist->count;
+}
+
+static __init void bp_slots_histogram_free(struct bp_slots_histogram *hist)
+{
+	kfree(hist->count);
+}
+
 static __init int init_breakpoint_slots(void)
 {
 	int i, cpu, err_cpu;
@@ -170,8 +190,7 @@ static __init int init_breakpoint_slots(void)
 		for (i = 0; i < TYPE_MAX; i++) {
 			struct bp_cpuinfo *info = get_bp_info(cpu, i);
 
-			info->tsk_pinned = kcalloc(__nr_bp_slots[i], sizeof(atomic_t), GFP_KERNEL);
-			if (!info->tsk_pinned)
+			if (!bp_slots_histogram_alloc(&info->tsk_pinned, i))
 				goto err;
 		}
 	}
@@ -180,7 +199,7 @@ static __init int init_breakpoint_slots(void)
 err:
 	for_each_possible_cpu(err_cpu) {
 		for (i = 0; i < TYPE_MAX; i++)
-			kfree(get_bp_info(err_cpu, i)->tsk_pinned);
+			bp_slots_histogram_free(&get_bp_info(err_cpu, i)->tsk_pinned);
 		if (err_cpu == cpu)
 			break;
 	}
@@ -189,6 +208,34 @@ err:
 }
 #endif
 
+static inline void
+bp_slots_histogram_add(struct bp_slots_histogram *hist, int old, int val)
+{
+	const int old_idx = old - 1;
+	const int new_idx = old_idx + val;
+
+	if (old_idx >= 0)
+		WARN_ON(atomic_dec_return_relaxed(&hist->count[old_idx]) < 0);
+	if (new_idx >= 0)
+		WARN_ON(atomic_inc_return_relaxed(&hist->count[new_idx]) < 0);
+}
+
+static int
+bp_slots_histogram_max(struct bp_slots_histogram *hist, enum bp_type_idx type)
+{
+	for (int i = hw_breakpoint_slots_cached(type) - 1; i >= 0; i--) {
+		const int count = atomic_read(&hist->count[i]);
+
+		/* Catch unexpected writers; we want a stable snapshot. */
+		ASSERT_EXCLUSIVE_WRITER(hist->count[i]);
+		if (count > 0)
+			return i + 1;
+		WARN(count < 0, "inconsistent breakpoint slots histogram");
+	}
+
+	return 0;
+}
+
 #ifndef hw_breakpoint_weight
 static inline int hw_breakpoint_weight(struct perf_event *bp)
 {
@@ -205,13 +252,11 @@ static inline enum bp_type_idx find_slot_idx(u64 bp_type)
 }
 
 /*
- * Report the maximum number of pinned breakpoints a task
- * have in this cpu
+ * Return the maximum number of pinned breakpoints a task has in this CPU.
  */
 static unsigned int max_task_bp_pinned(int cpu, enum bp_type_idx type)
 {
-	atomic_t *tsk_pinned = get_bp_info(cpu, type)->tsk_pinned;
-	int i;
+	struct bp_slots_histogram *tsk_pinned = &get_bp_info(cpu, type)->tsk_pinned;
 
 	/*
 	 * At this point we want to have acquired the bp_cpuinfo_sem as a
@@ -219,14 +264,7 @@ static unsigned int max_task_bp_pinned(int cpu, enum bp_type_idx type)
 	 * toggle_bp_task_slot() to tsk_pinned, and we get a stable snapshot.
 	 */
 	lockdep_assert_held_write(&bp_cpuinfo_sem);
-
-	for (i = hw_breakpoint_slots_cached(type) - 1; i >= 0; i--) {
-		ASSERT_EXCLUSIVE_WRITER(tsk_pinned[i]); /* Catch unexpected writers. */
-		if (atomic_read(&tsk_pinned[i]) > 0)
-			return i + 1;
-	}
-
-	return 0;
+	return bp_slots_histogram_max(tsk_pinned, type);
 }
 
 /*
@@ -300,8 +338,7 @@ max_bp_pinned_slots(struct perf_event *bp, enum bp_type_idx type)
 static void toggle_bp_task_slot(struct perf_event *bp, int cpu,
 				enum bp_type_idx type, int weight)
 {
-	atomic_t *tsk_pinned = get_bp_info(cpu, type)->tsk_pinned;
-	int old_idx, new_idx;
+	struct bp_slots_histogram *tsk_pinned = &get_bp_info(cpu, type)->tsk_pinned;
 
 	/*
 	 * If bp->hw.target, tsk_pinned is only modified, but not used
@@ -311,14 +348,7 @@ static void toggle_bp_task_slot(struct perf_event *bp, int cpu,
 	 * bp_cpuinfo_sem as a writer to stabilize tsk_pinned's value.
 	 */
 	lockdep_assert_held_read(&bp_cpuinfo_sem);
-
-	old_idx = task_bp_pinned(cpu, bp, type) - 1;
-	new_idx = old_idx + weight;
-
-	if (old_idx >= 0)
-		atomic_dec(&tsk_pinned[old_idx]);
-	if (new_idx >= 0)
-		atomic_inc(&tsk_pinned[new_idx]);
+	bp_slots_histogram_add(tsk_pinned, task_bp_pinned(cpu, bp, type), weight);
 }
 
 /*
@@ -768,7 +798,7 @@ bool hw_breakpoint_is_used(void)
 				return true;
 
 			for (int slot = 0; slot < hw_breakpoint_slots_cached(type); ++slot) {
-				if (atomic_read(&info->tsk_pinned[slot]))
+				if (atomic_read(&info->tsk_pinned.count[slot]))
 					return true;
 			}
 		}
