Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A109544A27
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 13:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243676AbiFILbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 07:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243635AbiFILbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 07:31:02 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3893A39C107
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 04:31:01 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id q200-20020a252ad1000000b006632baa38deso13550585ybq.15
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 04:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=vZHbZ1oi5OSjCMeU4/rneix3L5XarWjinLy785pgor0=;
        b=rJ6pp5xowS86Nd+/gorliRhFqUB5J+6mavLLuFiIdbWcQEhh6CT0t2PyhmpZ7XlHuV
         fJEKAnXZefd7pn33hZxyEaRytMDaJ8OfYiSvmXWHsOaxoj8OsWOqbyD3u8Hqg4tEuyux
         zsPtCAqnIgLyFyTYD2Fcn6nm+BwXQfHXoAuBsmLe34GoBAI4YIIqe45Sqp8NV28d0S+D
         bltiNySjqDhkJoauzSpEgnSsKrVSYQZ0l486YY3xoXoI+wtdC1H3VBf2GCJqNQZFzdYt
         v1IYGNzqEUhFbjtOBXkScAJ9ok5FhxPFKqh0SSpwI1MU6XFAngUa/85tiBwSpXZ6u1UF
         7JFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=vZHbZ1oi5OSjCMeU4/rneix3L5XarWjinLy785pgor0=;
        b=iDjCy4XoJqp4qbJ+G2UNo+In2YO1UBvKT/rvQaGSUfDTJyd2BQxTgcL2m3ZwidB0ph
         h/TWVBBa21C+BMjs6OCyIMeXL5ll8bp50nPkN4Gvxw7ZDDXZEaGpJWGNqemTO+/I4t9Y
         5dzjJDJfNDdAhIh9OjHnVKDehHFjj+7upgn3e+l/2HcSy9ZXJi7iCNUH0OGN3uAu8n7I
         QLu/SsQstvQ+DAXiHuJy0fBe38ehVtCrnd6BfpDEIR0BCVrOVMJm9bxe3hNuT1F5U4Gq
         VgbQYin6PTkxepd49L/SVBkl8nm6F/VbrFTnKABp0gHpQMLl2nClD722nj00xNZOz0uN
         X+3g==
X-Gm-Message-State: AOAM530aCX3tdmQTB2RpYhON0/Tt1jtQopO75G8lja8Qah5siIYxZuf9
        UpWiV7aDXbIeG+43/gU+c5CFCkEZMw==
X-Google-Smtp-Source: ABdhPJxnsh9anBT52y2AD1F6IjCtDlLW/bu8fyR/DC08IH7PUuKLO9593httKBZZ5/ksOups8ZfqirI4yw==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:9c:201:dcf:e5ba:10a5:1ea5])
 (user=elver job=sendgmr) by 2002:a25:dccd:0:b0:65c:bc72:75bf with SMTP id
 y196-20020a25dccd000000b0065cbc7275bfmr37441073ybe.315.1654774260428; Thu, 09
 Jun 2022 04:31:00 -0700 (PDT)
Date:   Thu,  9 Jun 2022 13:30:39 +0200
In-Reply-To: <20220609113046.780504-1-elver@google.com>
Message-Id: <20220609113046.780504-2-elver@google.com>
Mime-Version: 1.0
References: <20220609113046.780504-1-elver@google.com>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH 1/8] perf/hw_breakpoint: Optimize list of per-task breakpoints
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On a machine with 256 CPUs, running the recently added perf breakpoint
benchmark results in:

 | $> perf bench -r 30 breakpoint thread -b 4 -p 64 -t 64
 | # Running 'breakpoint/thread' benchmark:
 | # Created/joined 30 threads with 4 breakpoints and 64 parallelism
 |      Total time: 236.418 [sec]
 |
 |   123134.794271 usecs/op
 |  7880626.833333 usecs/op/cpu

The benchmark tests inherited breakpoint perf events across many
threads.

Looking at a perf profile, we can see that the majority of the time is
spent in various hw_breakpoint.c functions, which execute within the
'nr_bp_mutex' critical sections which then results in contention on that
mutex as well:

    37.27%  [kernel]       [k] osq_lock
    34.92%  [kernel]       [k] mutex_spin_on_owner
    12.15%  [kernel]       [k] toggle_bp_slot
    11.90%  [kernel]       [k] __reserve_bp_slot

The culprit here is task_bp_pinned(), which has a runtime complexity of
O(#tasks) due to storing all task breakpoints in the same list and
iterating through that list looking for a matching task. Clearly, this
does not scale to thousands of tasks.

While one option would be to make task_struct a breakpoint list node,
this would only further bloat task_struct for infrequently used data.

Instead, make use of the "rhashtable" variant "rhltable" which stores
multiple items with the same key in a list. This results in average
runtime complexity of O(1) for task_bp_pinned().

With the optimization, the benchmark shows:

 | $> perf bench -r 30 breakpoint thread -b 4 -p 64 -t 64
 | # Running 'breakpoint/thread' benchmark:
 | # Created/joined 30 threads with 4 breakpoints and 64 parallelism
 |      Total time: 0.208 [sec]
 |
 |      108.422396 usecs/op
 |     6939.033333 usecs/op/cpu

On this particular setup that's a speedup of ~1135x.

Signed-off-by: Marco Elver <elver@google.com>
---
 include/linux/perf_event.h    |  3 +-
 kernel/events/hw_breakpoint.c | 56 ++++++++++++++++++++++-------------
 2 files changed, 37 insertions(+), 22 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 01231f1d976c..e27360436dc6 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -36,6 +36,7 @@ struct perf_guest_info_callbacks {
 };
 
 #ifdef CONFIG_HAVE_HW_BREAKPOINT
+#include <linux/rhashtable-types.h>
 #include <asm/hw_breakpoint.h>
 #endif
 
@@ -178,7 +179,7 @@ struct hw_perf_event {
 			 * creation and event initalization.
 			 */
 			struct arch_hw_breakpoint	info;
-			struct list_head		bp_list;
+			struct rhlist_head		bp_list;
 		};
 #endif
 		struct { /* amd_iommu */
diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
index f32320ac02fd..25c94c6e918d 100644
--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -28,7 +28,7 @@
 #include <linux/sched.h>
 #include <linux/init.h>
 #include <linux/slab.h>
-#include <linux/list.h>
+#include <linux/rhashtable.h>
 #include <linux/cpu.h>
 #include <linux/smp.h>
 #include <linux/bug.h>
@@ -55,7 +55,13 @@ static struct bp_cpuinfo *get_bp_info(int cpu, enum bp_type_idx type)
 }
 
 /* Keep track of the breakpoints attached to tasks */
-static LIST_HEAD(bp_task_head);
+static struct rhltable task_bps_ht;
+static const struct rhashtable_params task_bps_ht_params = {
+	.head_offset = offsetof(struct hw_perf_event, bp_list),
+	.key_offset = offsetof(struct hw_perf_event, target),
+	.key_len = sizeof_field(struct hw_perf_event, target),
+	.automatic_shrinking = true,
+};
 
 static int constraints_initialized;
 
@@ -104,17 +110,23 @@ static unsigned int max_task_bp_pinned(int cpu, enum bp_type_idx type)
  */
 static int task_bp_pinned(int cpu, struct perf_event *bp, enum bp_type_idx type)
 {
-	struct task_struct *tsk = bp->hw.target;
+	struct rhlist_head *head, *pos;
 	struct perf_event *iter;
 	int count = 0;
 
-	list_for_each_entry(iter, &bp_task_head, hw.bp_list) {
-		if (iter->hw.target == tsk &&
-		    find_slot_idx(iter->attr.bp_type) == type &&
+	rcu_read_lock();
+	head = rhltable_lookup(&task_bps_ht, &bp->hw.target, task_bps_ht_params);
+	if (!head)
+		goto out;
+
+	rhl_for_each_entry_rcu(iter, pos, head, hw.bp_list) {
+		if (find_slot_idx(iter->attr.bp_type) == type &&
 		    (iter->cpu < 0 || cpu == iter->cpu))
 			count += hw_breakpoint_weight(iter);
 	}
 
+out:
+	rcu_read_unlock();
 	return count;
 }
 
@@ -187,7 +199,7 @@ static void toggle_bp_task_slot(struct perf_event *bp, int cpu,
 /*
  * Add/remove the given breakpoint in our constraint table
  */
-static void
+static int
 toggle_bp_slot(struct perf_event *bp, bool enable, enum bp_type_idx type,
 	       int weight)
 {
@@ -200,7 +212,7 @@ toggle_bp_slot(struct perf_event *bp, bool enable, enum bp_type_idx type,
 	/* Pinned counter cpu profiling */
 	if (!bp->hw.target) {
 		get_bp_info(bp->cpu, type)->cpu_pinned += weight;
-		return;
+		return 0;
 	}
 
 	/* Pinned counter task profiling */
@@ -208,9 +220,9 @@ toggle_bp_slot(struct perf_event *bp, bool enable, enum bp_type_idx type,
 		toggle_bp_task_slot(bp, cpu, type, weight);
 
 	if (enable)
-		list_add_tail(&bp->hw.bp_list, &bp_task_head);
+		return rhltable_insert(&task_bps_ht, &bp->hw.bp_list, task_bps_ht_params);
 	else
-		list_del(&bp->hw.bp_list);
+		return rhltable_remove(&task_bps_ht, &bp->hw.bp_list, task_bps_ht_params);
 }
 
 __weak int arch_reserve_bp_slot(struct perf_event *bp)
@@ -308,9 +320,7 @@ static int __reserve_bp_slot(struct perf_event *bp, u64 bp_type)
 	if (ret)
 		return ret;
 
-	toggle_bp_slot(bp, true, type, weight);
-
-	return 0;
+	return toggle_bp_slot(bp, true, type, weight);
 }
 
 int reserve_bp_slot(struct perf_event *bp)
@@ -335,7 +345,7 @@ static void __release_bp_slot(struct perf_event *bp, u64 bp_type)
 
 	type = find_slot_idx(bp_type);
 	weight = hw_breakpoint_weight(bp);
-	toggle_bp_slot(bp, false, type, weight);
+	WARN_ON(toggle_bp_slot(bp, false, type, weight));
 }
 
 void release_bp_slot(struct perf_event *bp)
@@ -679,7 +689,7 @@ static struct pmu perf_breakpoint = {
 int __init init_hw_breakpoint(void)
 {
 	int cpu, err_cpu;
-	int i;
+	int i, ret;
 
 	for (i = 0; i < TYPE_MAX; i++)
 		nr_slots[i] = hw_breakpoint_slots(i);
@@ -690,18 +700,24 @@ int __init init_hw_breakpoint(void)
 
 			info->tsk_pinned = kcalloc(nr_slots[i], sizeof(int),
 							GFP_KERNEL);
-			if (!info->tsk_pinned)
-				goto err_alloc;
+			if (!info->tsk_pinned) {
+				ret = -ENOMEM;
+				goto err;
+			}
 		}
 	}
 
+	ret = rhltable_init(&task_bps_ht, &task_bps_ht_params);
+	if (ret)
+		goto err;
+
 	constraints_initialized = 1;
 
 	perf_pmu_register(&perf_breakpoint, "breakpoint", PERF_TYPE_BREAKPOINT);
 
 	return register_die_notifier(&hw_breakpoint_exceptions_nb);
 
- err_alloc:
+err:
 	for_each_possible_cpu(err_cpu) {
 		for (i = 0; i < TYPE_MAX; i++)
 			kfree(get_bp_info(err_cpu, i)->tsk_pinned);
@@ -709,7 +725,5 @@ int __init init_hw_breakpoint(void)
 			break;
 	}
 
-	return -ENOMEM;
+	return ret;
 }
-
-
-- 
2.36.1.255.ge46751e96f-goog

