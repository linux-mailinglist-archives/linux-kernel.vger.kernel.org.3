Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 085E251131E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 10:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359238AbiD0IDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 04:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359225AbiD0IDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 04:03:43 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14CC5B7DB
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 01:00:30 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id c23so930386plo.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 01:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=np0p6uL5yO/RE1uUWo1JFrB/FHVK+k0ntQBe3o4k1/c=;
        b=iQcaPovBIySDpR1ZuVnKJ6Z3+k3j4kXhdZ+kvPoNs+Dxz873fKtku5FiCb2vtXM0DU
         cMfxp+KrIFj932pcdcVKC70MBw5lFaBRgFERG67frvrzgOHBq/jyV5V3aT08tQFBZoyf
         QU11naUDaf7y394hBFqkQlWV6biz3pFDpZs1xaJvEJBqgeC6o0lCSh40+D3rD5tF0OtX
         +SXjdkNHlliGsKOirlpV+0/yh+OM6/s/wJGklWPu5oBX9X2mLcnX+FxcO11+RKwYTJuG
         xxpburDvhA4/GPJiEtnzMQVWtLFykrHF76eKh7d/qTjNMVeDTicPyVChF5CGycLb59Le
         WnbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=np0p6uL5yO/RE1uUWo1JFrB/FHVK+k0ntQBe3o4k1/c=;
        b=5G4VvnOELf/NVKLV2p2klblcAXnLdBqV4OuEI+XStBEgbsHEyMidnZlsQL2S0SluvW
         1X/Ez6AAIWk8L5wm0t4pGMVgyHneNrizWaPqdYCKQTXN1kjbbTybjQNq3JfRsvoGF2Sm
         E5Xde9VDLIZd1CQHqBAiPowO87d7lLJbiT3leX/dUo2izcpUvTb6RcPVmYXSiS/eh/+c
         L9FyaNkKFXYSHEl6uUG05XW2Nh15Kf4MuTdaPhaOqCr4oF0pmVIzHPih20FZtgYnD19k
         6+F60I3jI8w8kSWTg4DpZmcLqk9/ElWz8wAKDhMTdh4Hu+52/uChYctlErRX1UPKlLIJ
         YBxg==
X-Gm-Message-State: AOAM531J23SlIEoB4glGXdkt3w92z2vjd7IrJUtXwLpdhjeiYOYvr61h
        YhdEg2dyk7EtP4xdiczS/1AdQA==
X-Google-Smtp-Source: ABdhPJxHZXRKewHcEKyebH+SLPzxDg6ppkFD7wRwzc8R8bem5d6rXV0tJ32hqRwRGIfXOEzhN45n1w==
X-Received: by 2002:a17:90b:4c88:b0:1d9:7158:876b with SMTP id my8-20020a17090b4c8800b001d97158876bmr16753146pjb.54.1651046430245;
        Wed, 27 Apr 2022 01:00:30 -0700 (PDT)
Received: from localhost.localdomain ([240e:390:e6b:6b80:9d6d:7735:8291:b65d])
        by smtp.gmail.com with ESMTPSA id u2-20020a62d442000000b0050d404f837fsm9543380pfl.156.2022.04.27.01.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 01:00:29 -0700 (PDT)
From:   Hao Jia <jiahao.os@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, Hao Jia <jiahao.os@bytedance.com>
Subject: [PATCH v3 1/2] sched/core: Avoid obvious double update_rq_clock warning
Date:   Wed, 27 Apr 2022 16:00:13 +0800
Message-Id: <20220427080014.18483-2-jiahao.os@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220427080014.18483-1-jiahao.os@bytedance.com>
References: <20220427080014.18483-1-jiahao.os@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we use raw_spin_rq_lock() to acquire the rq lock and have to
update the rq clock while holding the lock, the kernel may issue
a WARN_DOUBLE_CLOCK warning.

Since we directly use raw_spin_rq_lock() to acquire rq lock instead of
rq_lock(), there is no corresponding change to rq->clock_update_flags.
In particular, we have obtained the rq lock of other cores,
the core rq->clock_update_flags may be RQCF_UPDATED at this time, and
then calling update_rq_clock() will trigger the WARN_DOUBLE_CLOCK warning.

So we need to clear RQCF_UPDATED of rq->clock_update_flags synchronously
to avoid the WARN_DOUBLE_CLOCK warning.

For the sched_rt_period_timer() and migrate_task_rq_dl() cases
we simply replace raw_spin_rq_lock()/raw_spin_rq_unlock() with
rq_lock()/rq_unlock().

For the {pull,push}_{rt,dl}_task() cases, we add the
double_rq_clock_clear_update() function to clear RQCF_UPDATED of
rq->clock_update_flags, and call double_rq_clock_clear_update()
before double_lock_balance()/double_rq_lock() returns to avoid the
WARN_DOUBLE_CLOCK warning.

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

Call Trace 4:
 update_rq_clock+0x128/0x1a0
 migrate_task_rq_dl+0xec/0x310
 set_task_cpu+0x84/0x1e4
 try_to_wake_up+0x1d8/0x5c0
 wake_up_process+0x1c/0x30
 hrtimer_wakeup+0x24/0x3c
 __hrtimer_run_queues+0x114/0x270
 hrtimer_interrupt+0xe8/0x244
 arch_timer_handler_phys+0x30/0x50
 handle_percpu_devid_irq+0x88/0x140
 generic_handle_domain_irq+0x40/0x60
 gic_handle_irq+0x48/0xe0
 call_on_irq_stack+0x2c/0x60
 do_interrupt_handler+0x80/0x84

Steps to reproduce:
1. Enable CONFIG_SCHED_DEBUG when compiling the kernel
2. echo 1 > /sys/kernel/debug/clear_warn_once
   echo "WARN_DOUBLE_CLOCK" > /sys/kernel/debug/sched/features
   echo "NO_RT_PUSH_IPI" > /sys/kernel/debug/sched/features
3. Run some rt/dl tasks that periodically work and sleep, e.g.
Create 2*n rt or dl (90% running) tasks via rt-app (on a system
with n CPUs), and Dietmar Eggemann reports Call Trace 4 when running
on PREEMPT_RT kernel.

Signed-off-by: Hao Jia <jiahao.os@bytedance.com>
---
 kernel/sched/core.c     |  6 +++---
 kernel/sched/deadline.c |  5 +++--
 kernel/sched/rt.c       |  5 +++--
 kernel/sched/sched.h    | 31 +++++++++++++++++++++++++++----
 4 files changed, 36 insertions(+), 11 deletions(-)

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
 
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index fb4255ae0b2c..a562bb271031 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1833,6 +1833,7 @@ select_task_rq_dl(struct task_struct *p, int cpu, int flags)
 static void migrate_task_rq_dl(struct task_struct *p, int new_cpu __maybe_unused)
 {
 	struct rq *rq;
+	struct rq_flags rf;
 
 	if (READ_ONCE(p->__state) != TASK_WAKING)
 		return;
@@ -1843,7 +1844,7 @@ static void migrate_task_rq_dl(struct task_struct *p, int new_cpu __maybe_unused
 	 * from try_to_wake_up(). Hence, p->pi_lock is locked, but
 	 * rq->lock is not... So, lock it
 	 */
-	raw_spin_rq_lock(rq);
+	rq_lock(rq, &rf);
 	if (p->dl.dl_non_contending) {
 		update_rq_clock(rq);
 		sub_running_bw(&p->dl, &rq->dl);
@@ -1859,7 +1860,7 @@ static void migrate_task_rq_dl(struct task_struct *p, int new_cpu __maybe_unused
 			put_task_struct(p);
 	}
 	sub_rq_bw(&p->dl, &rq->dl);
-	raw_spin_rq_unlock(rq);
+	rq_unlock(rq, &rf);
 }
 
 static void check_preempt_equal_dl(struct rq *rq, struct task_struct *p)
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
index 8dccb34eb190..975e7d990a0b 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2478,6 +2478,27 @@ unsigned long arch_scale_freq_capacity(int cpu)
 }
 #endif
 
+#ifdef CONFIG_SCHED_DEBUG
+/*
+ * In double_lock_balance()/double_rq_lock(), we use raw_spin_rq_lock() to acquire
+ * rq lock instead of rq_lock(). So at the end of these two functions we need to
+ * call double_rq_clock_clear_update() synchronously to clear RQCF_UPDATED of
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

