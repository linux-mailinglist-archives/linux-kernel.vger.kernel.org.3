Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8903250B3C9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 11:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445855AbiDVJRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 05:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445880AbiDVJNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 05:13:06 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00647B847
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 02:10:13 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id s137so6878136pgs.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 02:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GjFkrXQ0Jf/Wo7tGCVQoupglponKlDpocPGzJ8nG08w=;
        b=DDbB6iljrKJeU3qyRiGqdLSHMyhTawsIWDhe0PWmZe8MVf39FywzhzvbW1USrCX6xA
         SEqCVJl4CGpepPI+/tTd6QMAg2Y2VFHQI7m7HMbfnHJEPT5FgDdeCGrgcm2wWSV/rXHm
         34N3s6OlJo3O4crhMHesKaXtASOU3OHzbZBuI9yvOeeB1r6yPDIZNi0P3gfbeV5YzGI8
         4N0t/K4BKo0sQWUZjuWoFkWIPFAYAiBztKepEbKlQp5TTGwUNC4yoFScWlDakr0GiUSx
         srPI9n2Mfj5DdYDcr7P3WrmCN0WRdQzaHO8jHv9+9SOiAetsiL0EdvNED3EW/oUkftU7
         Gcew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GjFkrXQ0Jf/Wo7tGCVQoupglponKlDpocPGzJ8nG08w=;
        b=i8u/WCQJzX3MQ7vqd/ESdQ6+Lt1ZV/5UKhzFNAPwao86G1mEDVjHb3ZIK41t6YP8Xd
         dzZHli2yk1ZJblbZl7kAjcWmRPISZIbuptCzqx+T+4zebwDz6n5gSxNoDy5UJtNieeLi
         48DXVf2Ewne5lDWo2V8yXToRLvR2RHv2z07asW/Od85mth6wIQpKM3fyOyZ2zTCY0tFn
         +KjGv4mcU/GPrcWB19v9C+krixwFtrb5H6vrkx+bNUrXNV+HA5ZCsG4uNKV+DVGkU4R4
         DOZC57tUcojfqwXfjWtUSdAhumqORhmVHoHya//xAgIHMQBePyx+SC3gPK5Bl6O9DFEF
         wlxA==
X-Gm-Message-State: AOAM531EGdddCrklZTQqzN88unaTcLqcC65WoRCkYTgnfRtVSdDS4y7Q
        ZafVVDeWc9D+vCGsLzBPDW5uHw==
X-Google-Smtp-Source: ABdhPJyV+/dzhnfs2RsTb0ksOXgH5/6MCWREjHpjTzGRVMUOdPqGNPSye2+TOSA8Bt16SoYKjRWxng==
X-Received: by 2002:a05:6a00:891:b0:4fe:1262:9b4e with SMTP id q17-20020a056a00089100b004fe12629b4emr3805428pfj.21.1650618613443;
        Fri, 22 Apr 2022 02:10:13 -0700 (PDT)
Received: from C02G87K0MD6R.bytedance.net ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id oe7-20020a17090b394700b001d8995368a9sm559239pjb.35.2022.04.22.02.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 02:10:13 -0700 (PDT)
From:   Hao Jia <jiahao.os@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, Hao Jia <jiahao.os@bytedance.com>
Subject: [PATCH v2 1/2] sched/core: Avoid obvious double update_rq_clock warning
Date:   Fri, 22 Apr 2022 17:09:43 +0800
Message-Id: <20220422090944.52618-2-jiahao.os@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220422090944.52618-1-jiahao.os@bytedance.com>
References: <20220422090944.52618-1-jiahao.os@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we use raw_spin_rq_lock to acquire the rq lock and have to
update the rq clock while holding the lock, the kernel may issue
a WARN_DOUBLE_CLOCK warning.

Since we directly use raw_spin_rq_lock to acquire rq lock instead of
rq_lock, there is no corresponding change to rq->clock_update_flags.
In particular, we have obtained the rq lock of other cores,
the core rq->clock_update_flags may be RQCF_UPDATED at this time, and
then calling update_rq_clock will trigger the WARN_DOUBLE_CLOCK warning.

So we need to clear RQCF_UPDATED of rq->clock_update_flags synchronously
to avoid the WARN_DOUBLE_CLOCK warning.

Some call trace reports:
Call Trace 1:
 <IRQ>
 sched_rt_period_timer+0x10f/0x3a0
 ? enqueue_top_rt_rq+0x110/0x110
 __hrtimer_run_queues+0x1a9/0x490
 hrtimer_interrupt+0x10b/0x240
 __sysvec_apic_timer_interrupt+0x8a/0x250
 sysvec_apic_timer_interrupt+0x9a/0xd0
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x12/0x20

Call Trace 2:
 <TASK>
 activate_task+0x8b/0x110
 push_rt_task.part.108+0x241/0x2c0
 push_rt_tasks+0x15/0x30
 finish_task_switch+0xaa/0x2e0
 ? __switch_to+0x134/0x420
 __schedule+0x343/0x8e0
 ? hrtimer_start_range_ns+0x101/0x340
 schedule+0x4e/0xb0
 do_nanosleep+0x8e/0x160
 hrtimer_nanosleep+0x89/0x120
 ? hrtimer_init_sleeper+0x90/0x90
 __x64_sys_nanosleep+0x96/0xd0
 do_syscall_64+0x34/0x90
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Call Trace 3:
 <TASK>
 deactivate_task+0x93/0xe0
 pull_rt_task+0x33e/0x400
 balance_rt+0x7e/0x90
 __schedule+0x62f/0x8e0
 do_task_dead+0x3f/0x50
 do_exit+0x7b8/0xbb0
 do_group_exit+0x2d/0x90
 get_signal+0x9df/0x9e0
 ? preempt_count_add+0x56/0xa0
 ? __remove_hrtimer+0x35/0x70
 arch_do_signal_or_restart+0x36/0x720
 ? nanosleep_copyout+0x39/0x50
 ? do_nanosleep+0x131/0x160
 ? audit_filter_inodes+0xf5/0x120
 exit_to_user_mode_prepare+0x10f/0x1e0
 syscall_exit_to_user_mode+0x17/0x30
 do_syscall_64+0x40/0x90
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Steps to reproduce:
1. Enable CONFIG_SCHED_DEBUG when compiling the kernel
2. echo 1 > /sys/kernel/debug/clear_warn_once
   echo "WARN_DOUBLE_CLOCK" > /sys/kernel/debug/sched_features
   echo "NO_RT_PUSH_IPI" > /sys/kernel/debug/sched_features
3. Run some rt tasks that periodically change the priority and sleep

Signed-off-by: Hao Jia <jiahao.os@bytedance.com>
Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 kernel/sched/core.c  |  6 +++---
 kernel/sched/rt.c    |  5 +++--
 kernel/sched/sched.h | 31 +++++++++++++++++++++++++++----
 3 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 51efaabac3e4..84538271b4eb 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -610,10 +610,10 @@ void double_rq_lock(struct rq *rq1, struct rq *rq2)
 		swap(rq1, rq2);
 
 	raw_spin_rq_lock(rq1);
-	if (__rq_lockp(rq1) == __rq_lockp(rq2))
-		return;
+	if (__rq_lockp(rq1) != __rq_lockp(rq2))
+		raw_spin_rq_lock_nested(rq2, SINGLE_DEPTH_NESTING);
 
-	raw_spin_rq_lock_nested(rq2, SINGLE_DEPTH_NESTING);
+	double_rq_clock_clear_update(rq1, rq2);
 }
 #endif
 
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index a32c46889af8..7891c0f0e1ff 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -871,6 +871,7 @@ static int do_sched_rt_period_timer(struct rt_bandwidth *rt_b, int overrun)
 		int enqueue = 0;
 		struct rt_rq *rt_rq = sched_rt_period_rt_rq(rt_b, i);
 		struct rq *rq = rq_of_rt_rq(rt_rq);
+		struct rq_flags rf;
 		int skip;
 
 		/*
@@ -885,7 +886,7 @@ static int do_sched_rt_period_timer(struct rt_bandwidth *rt_b, int overrun)
 		if (skip)
 			continue;
 
-		raw_spin_rq_lock(rq);
+		rq_lock(rq, &rf);
 		update_rq_clock(rq);
 
 		if (rt_rq->rt_time) {
@@ -923,7 +924,7 @@ static int do_sched_rt_period_timer(struct rt_bandwidth *rt_b, int overrun)
 
 		if (enqueue)
 			sched_rt_rq_enqueue(rt_rq);
-		raw_spin_rq_unlock(rq);
+		rq_unlock(rq, &rf);
 	}
 
 	if (!throttled && (!rt_bandwidth_enabled() || rt_b->rt_runtime == RUNTIME_INF))
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 8dccb34eb190..7f1a18b2aff2 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2478,6 +2478,27 @@ unsigned long arch_scale_freq_capacity(int cpu)
 }
 #endif
 
+#ifdef CONFIG_SCHED_DEBUG
+/*
+ * In double_lock_balance/double_rq_lock, we use raw_spin_rq_lock to acquire rq lock
+ * instead of rq_lock. So at the end of these two functions we need to call
+ * double_rq_clock_clear_update synchronously to clear RQCF_UPDATED of
+ * rq->clock_update_flags to avoid the WARN_DOUBLE_CLOCK warning.
+ */
+static inline void double_rq_clock_clear_update(struct rq *rq1, struct rq *rq2)
+{
+	rq1->clock_update_flags &= (RQCF_REQ_SKIP|RQCF_ACT_SKIP);
+	/*
+	 * If CONFIG_SMP is not defined, rq1 and rq2 are the same,
+	 * so we just clear RQCF_UPDATED one of them.
+	 */
+#ifdef CONFIG_SMP
+	rq2->clock_update_flags &= (RQCF_REQ_SKIP|RQCF_ACT_SKIP);
+#endif
+}
+#else
+static inline void double_rq_clock_clear_update(struct rq *rq1, struct rq *rq2) {}
+#endif
 
 #ifdef CONFIG_SMP
 
@@ -2543,14 +2564,15 @@ static inline int _double_lock_balance(struct rq *this_rq, struct rq *busiest)
 	__acquires(busiest->lock)
 	__acquires(this_rq->lock)
 {
-	if (__rq_lockp(this_rq) == __rq_lockp(busiest))
-		return 0;
-
-	if (likely(raw_spin_rq_trylock(busiest)))
+	if (__rq_lockp(this_rq) == __rq_lockp(busiest) ||
+		likely(raw_spin_rq_trylock(busiest))) {
+		double_rq_clock_clear_update(this_rq, busiest);
 		return 0;
+	}
 
 	if (rq_order_less(this_rq, busiest)) {
 		raw_spin_rq_lock_nested(busiest, SINGLE_DEPTH_NESTING);
+		double_rq_clock_clear_update(this_rq, busiest);
 		return 0;
 	}
 
@@ -2644,6 +2666,7 @@ static inline void double_rq_lock(struct rq *rq1, struct rq *rq2)
 	BUG_ON(rq1 != rq2);
 	raw_spin_rq_lock(rq1);
 	__acquire(rq2->lock);	/* Fake it out ;) */
+	double_rq_clock_clear_update(rq1, rq2);
 }
 
 /*
-- 
2.32.0

