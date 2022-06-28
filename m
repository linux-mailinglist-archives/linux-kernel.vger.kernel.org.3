Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53A5055E2C7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344669AbiF1KAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 06:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344660AbiF1J77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 05:59:59 -0400
Received: from mail-lf1-x149.google.com (mail-lf1-x149.google.com [IPv6:2a00:1450:4864:20::149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C70F2F671
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 02:59:33 -0700 (PDT)
Received: by mail-lf1-x149.google.com with SMTP id i3-20020a056512318300b0047f86b47910so5991385lfe.14
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 02:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=YoFBOjNJrDqt8mzIFXF65D7zaWvuhvYLEYNKHK+PaLc=;
        b=a9Qz/7hR75sQU9O6oZwdzmtBNRvu2wowsSw3yC8AvgcexKD0hQWYnfXob1A3xoOwi9
         Yi+cnFhEieKcMLvDMww1D20eAdWH1Wyk/XN8Rzeg+dwA2ErW9BqE1LFWET/6SIgBJyA/
         RhXBxGRh19Auys0GMO1QM33iLQEia3IjPVCVD6opO4snspydBgkfwJdEekoc7JkJEDQ0
         1OckSSoBXHAGNl1/JZ665dtYgPmMSOe5IINDdBT6rkv5RFzk84l/3ebNWC7otxmjDsFV
         Z5NUcKG05acFW8EN2I6SmSCuKXdshC0ytIpKZOF3VozL7+PvODwKc2FpSF1Y1QCG9MNs
         WTXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=YoFBOjNJrDqt8mzIFXF65D7zaWvuhvYLEYNKHK+PaLc=;
        b=Vs7DnQLC7DQF6cduHbbTlQtpPfPVTmw1tp4sfsuU2ZlY1CQ3Ntc5wssAJ0mGgWrDoB
         /Kty9VUKTuvWirwPXMfKtjRt3Jm3iJcjxopZaD5uhrzZQa/ozKy6FNlZbAVRDnKke128
         +oNXqCh5BFCr9reHxxeRtRaU7VyJ7uDUqImmHJlSQ9C2RrSKZBlsdGrQivjeADL+7sQr
         uujUFVOLgB8A2fJ78Tc+pK5n8t35cbA9ZEaVlH1ykJP2sE1LQ/ZEZqBagt/bFJX5aMJ6
         F21O8ydcxlVmiT1DtwLMOOSccFOOe+dCxrvGPsbunlw8B4lQE2LLoH0WPW7qqBoxa25l
         4G3g==
X-Gm-Message-State: AJIora+aFaq09vhg3x4+uVXN9bE4ZQJOLQaWelyyc09FcfEqF5H0LU6g
        2ToifmAR7ybpFVk8Il8LTxIYWPjnVw==
X-Google-Smtp-Source: AGRyM1spV49Opldetgxz0cutBdhp70Cu++LbcV8eigThbdlzZHbfBXCFjFKzXcX+JquMN0U3x+uZt5tWnw==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:9c:201:3496:744e:315a:b41b])
 (user=elver job=sendgmr) by 2002:a05:6512:32c5:b0:481:1822:c41f with SMTP id
 f5-20020a05651232c500b004811822c41fmr7349560lfg.373.1656410371551; Tue, 28
 Jun 2022 02:59:31 -0700 (PDT)
Date:   Tue, 28 Jun 2022 11:58:32 +0200
In-Reply-To: <20220628095833.2579903-1-elver@google.com>
Message-Id: <20220628095833.2579903-13-elver@google.com>
Mime-Version: 1.0
References: <20220628095833.2579903-1-elver@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v2 12/13] perf/hw_breakpoint: Optimize max_bp_pinned_slots()
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
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
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
---
v2:
* New patch.
---
 kernel/events/hw_breakpoint.c | 45 +++++++++++++++++++++++++++++++----
 1 file changed, 41 insertions(+), 4 deletions(-)

diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
index 18886f115abc..b5180a2ccfbf 100644
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
 
-- 
2.37.0.rc0.161.g10f37bed90-goog

