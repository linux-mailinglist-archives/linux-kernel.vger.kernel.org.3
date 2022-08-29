Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1DA85A4CBB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 14:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbiH2M5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 08:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbiH2M4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 08:56:37 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D3015801
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 05:48:36 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id m21-20020adfa3d5000000b00226d1478469so897032wrb.21
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 05:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=tHogyOz5U0y7+H4DYPxiXG1ukMrOYP0VQiSgNpC/zOM=;
        b=rToQIqGvSV9gtHxU6/haFwVvhDbNuIXIAJ8mLeS71jKMZ8uIbmDa6I+Xx8uSHEYE2Q
         8TUo8uYJtrXeNC0kju/+pAa3u6BcejatiMjxerNjN7jXaAgPisxjmZkH9iC3/4zTdN76
         UfqrMKYs5pXmcItmuiIasOQ8UNASt288FZ/xBL2p/GC29D1+vcw2OBOIedIsdKH3yJgE
         Fud5R+reC/TBdAdfycV0lDis2b5V33c/1lglvQfxKDhti08R2zRYzOBWAqongTkbFUwB
         uUR7Kq3u7r7eXXozNcGskPFBrQXEyi/grPIc8n03qsJr2WVzx0H/ouS+FYb3au1Ss2xN
         Q0GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=tHogyOz5U0y7+H4DYPxiXG1ukMrOYP0VQiSgNpC/zOM=;
        b=hGGxAWbjk9z6QiV/TpYRmtduU9lWG8FTzcw8pm0Hz3w4Qj+n0JpI6SNWOz5SjIZyHC
         4rID1zZONhu3febvlvrsi/wqhUJdgfG6QSxAGLOYD4b1CVzPhlz7By9A0zu3yLOnlPpT
         x+FbicvVLunJAtqsWmi1SYq1Dn5A+iOKSznNyyuPAXvdxCPWQfRBckPBmWn6X/bhuwQC
         6IvOIealojCIoo6Yf9Rn/c4spcW/VHqVZsIXrmC0p0fiWZw1moN/tGT0t5xSV93HHl18
         E8LcFjf+sa0wmv54tGXtQzujml9r9tSowLw5NJCOt+QZo82GdiWMXDbwEVqOIBXL9hLH
         +LEQ==
X-Gm-Message-State: ACgBeo17boorZ5XVvEk3S6pMbi6bvJqmstV2RkBmD+0qf4Z6ZOmkoQmy
        KktVcA22ipW8joVNAS+l+oVPIB2nVg==
X-Google-Smtp-Source: AA6agR6mjLHHe6v8lJspMAXsC84vRaEP6nUqGZxInQUwQrF8DKnZLiGJY7VnOBMh0yWsleS0xeEpvdvhgQ==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:9c:201:196d:4fc7:fa9c:62e3])
 (user=elver job=sendgmr) by 2002:a5d:5048:0:b0:226:df3b:72f4 with SMTP id
 h8-20020a5d5048000000b00226df3b72f4mr1036162wrt.205.1661777314053; Mon, 29
 Aug 2022 05:48:34 -0700 (PDT)
Date:   Mon, 29 Aug 2022 14:47:18 +0200
In-Reply-To: <20220829124719.675715-1-elver@google.com>
Mime-Version: 1.0
References: <20220829124719.675715-1-elver@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220829124719.675715-14-elver@google.com>
Subject: [PATCH v4 13/14] perf/hw_breakpoint: Optimize max_bp_pinned_slots()
 for CPU-independent task targets
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
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-perf-users@vger.kernel.org,
        x86@kernel.org, linux-sh@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Running the perf benchmark with (note: more aggressive parameters vs.
preceding changes, but same 256 CPUs host):

 | $> perf bench -r 100 breakpoint thread -b 4 -p 128 -t 512
 | # Running 'breakpoint/thread' benchmark:
 | # Created/joined 100 threads with 4 breakpoints and 128 parallelism
 |      Total time: 1.989 [sec]
 |
 |       38.854160 usecs/op
 |     4973.332500 usecs/op/cpu

    20.43%  [kernel]       [k] queued_spin_lock_slowpath
    18.75%  [kernel]       [k] osq_lock
    16.98%  [kernel]       [k] rhashtable_jhash2
     8.34%  [kernel]       [k] task_bp_pinned
     4.23%  [kernel]       [k] smp_cfm_core_cond
     3.65%  [kernel]       [k] bcmp
     2.83%  [kernel]       [k] toggle_bp_slot
     1.87%  [kernel]       [k] find_next_bit
     1.49%  [kernel]       [k] __reserve_bp_slot

We can see that a majority of the time is now spent hashing task
pointers to index into task_bps_ht in task_bp_pinned().

Obtaining the max_bp_pinned_slots() for CPU-independent task targets
currently is O(#cpus), and calls task_bp_pinned() for each CPU, even if
the result of task_bp_pinned() is CPU-independent.

The loop in max_bp_pinned_slots() wants to compute the maximum slots
across all CPUs. If task_bp_pinned() is CPU-independent, we can do so by
obtaining the max slots across all CPUs and adding task_bp_pinned().

To do so in O(1), use a bp_slots_histogram for CPU-pinned slots.

After this optimization:

 | $> perf bench -r 100 breakpoint thread -b 4 -p 128 -t 512
 | # Running 'breakpoint/thread' benchmark:
 | # Created/joined 100 threads with 4 breakpoints and 128 parallelism
 |      Total time: 1.930 [sec]
 |
 |       37.697832 usecs/op
 |     4825.322500 usecs/op/cpu

    19.13%  [kernel]       [k] queued_spin_lock_slowpath
    18.21%  [kernel]       [k] rhashtable_jhash2
    15.46%  [kernel]       [k] osq_lock
     6.27%  [kernel]       [k] toggle_bp_slot
     5.91%  [kernel]       [k] task_bp_pinned
     5.05%  [kernel]       [k] smp_cfm_core_cond
     1.78%  [kernel]       [k] update_sg_lb_stats
     1.36%  [kernel]       [k] llist_reverse_order
     1.34%  [kernel]       [k] find_next_bit
     1.19%  [kernel]       [k] bcmp

Suggesting that time spent in task_bp_pinned() has been reduced.
However, we're still hashing too much, which will be addressed in the
subsequent change.

Signed-off-by: Marco Elver <elver@google.com>
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Acked-by: Ian Rogers <irogers@google.com>
---
v3:
* Update hw_breakpoint_is_used() to include global cpu_pinned.

v2:
* New patch.
---
 kernel/events/hw_breakpoint.c | 57 ++++++++++++++++++++++++++++++++---
 1 file changed, 53 insertions(+), 4 deletions(-)

diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
index 03ebecf048c0..a489f31fe147 100644
--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -64,6 +64,9 @@ static struct bp_cpuinfo *get_bp_info(int cpu, enum bp_type_idx type)
 	return per_cpu_ptr(bp_cpuinfo + type, cpu);
 }
 
+/* Number of pinned CPU breakpoints globally. */
+static struct bp_slots_histogram cpu_pinned[TYPE_MAX];
+
 /* Keep track of the breakpoints attached to tasks */
 static struct rhltable task_bps_ht;
 static const struct rhashtable_params task_bps_ht_params = {
@@ -194,6 +197,10 @@ static __init int init_breakpoint_slots(void)
 				goto err;
 		}
 	}
+	for (i = 0; i < TYPE_MAX; i++) {
+		if (!bp_slots_histogram_alloc(&cpu_pinned[i], i))
+			goto err;
+	}
 
 	return 0;
 err:
@@ -203,6 +210,8 @@ static __init int init_breakpoint_slots(void)
 		if (err_cpu == cpu)
 			break;
 	}
+	for (i = 0; i < TYPE_MAX; i++)
+		bp_slots_histogram_free(&cpu_pinned[i]);
 
 	return -ENOMEM;
 }
@@ -270,6 +279,9 @@ static unsigned int max_task_bp_pinned(int cpu, enum bp_type_idx type)
 /*
  * Count the number of breakpoints of the same type and same task.
  * The given event must be not on the list.
+ *
+ * If @cpu is -1, but the result of task_bp_pinned() is not CPU-independent,
+ * returns a negative value.
  */
 static int task_bp_pinned(int cpu, struct perf_event *bp, enum bp_type_idx type)
 {
@@ -288,9 +300,18 @@ static int task_bp_pinned(int cpu, struct perf_event *bp, enum bp_type_idx type)
 		goto out;
 
 	rhl_for_each_entry_rcu(iter, pos, head, hw.bp_list) {
-		if (find_slot_idx(iter->attr.bp_type) == type &&
-		    (iter->cpu < 0 || cpu == iter->cpu))
-			count += hw_breakpoint_weight(iter);
+		if (find_slot_idx(iter->attr.bp_type) != type)
+			continue;
+
+		if (iter->cpu >= 0) {
+			if (cpu == -1) {
+				count = -1;
+				goto out;
+			} else if (cpu != iter->cpu)
+				continue;
+		}
+
+		count += hw_breakpoint_weight(iter);
 	}
 
 out:
@@ -316,6 +337,19 @@ max_bp_pinned_slots(struct perf_event *bp, enum bp_type_idx type)
 	int pinned_slots = 0;
 	int cpu;
 
+	if (bp->hw.target && bp->cpu < 0) {
+		int max_pinned = task_bp_pinned(-1, bp, type);
+
+		if (max_pinned >= 0) {
+			/*
+			 * Fast path: task_bp_pinned() is CPU-independent and
+			 * returns the same value for any CPU.
+			 */
+			max_pinned += bp_slots_histogram_max(&cpu_pinned[type], type);
+			return max_pinned;
+		}
+	}
+
 	for_each_cpu(cpu, cpumask) {
 		struct bp_cpuinfo *info = get_bp_info(cpu, type);
 		int nr;
@@ -366,8 +400,11 @@ toggle_bp_slot(struct perf_event *bp, bool enable, enum bp_type_idx type,
 
 	/* Pinned counter cpu profiling */
 	if (!bp->hw.target) {
+		struct bp_cpuinfo *info = get_bp_info(bp->cpu, type);
+
 		lockdep_assert_held_write(&bp_cpuinfo_sem);
-		get_bp_info(bp->cpu, type)->cpu_pinned += weight;
+		bp_slots_histogram_add(&cpu_pinned[type], info->cpu_pinned, weight);
+		info->cpu_pinned += weight;
 		return 0;
 	}
 
@@ -804,6 +841,18 @@ bool hw_breakpoint_is_used(void)
 		}
 	}
 
+	for (int type = 0; type < TYPE_MAX; ++type) {
+		for (int slot = 0; slot < hw_breakpoint_slots_cached(type); ++slot) {
+			/*
+			 * Warn, because if there are CPU pinned counters,
+			 * should never get here; bp_cpuinfo::cpu_pinned should
+			 * be consistent with the global cpu_pinned histogram.
+			 */
+			if (WARN_ON(atomic_read(&cpu_pinned[type].count[slot])))
+				return true;
+		}
+	}
+
 	return false;
 }
 
-- 
2.37.2.672.g94769d06f0-goog

