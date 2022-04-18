Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE068504E3D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 11:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237412AbiDRJMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 05:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234812AbiDRJMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 05:12:20 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE4C7DF5B
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 02:09:40 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d15so11862082pll.10
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 02:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4zgIjpV1QpK8SGoNtpBB6Ij+QoqmC5OIdrLktq8hdyA=;
        b=TpUlhZbGYppVgX7JfA1+9T3+LcztkehRmnRv+QP5CTCwa+NMcwVWIa9Bq/d0HeTqMa
         UiP0WRii/rHJKd02deVu66UgbWYuM7RhU+t+gBUaUKBLM2Zi8xDGZAfDMHkkOHAMfBGD
         yBK8M/dU/a9K9imZpThHkQkqY6zp4m1MMNMTwVPKLmW9iSuK04YNAdmCpgqxXyXOrRsy
         fQRfp0kSPyVDbVG+PrY6tNpeoPKMlaeXpriA++bnzLJtbShvE5N/IirTwVDMsqSJaGK9
         WikQYXJumcA1D7Umc+IKUDZmMYJs1zCZKVn/4+fK/3nGnC0ymf683EehpvreG8g7cZyo
         GUiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4zgIjpV1QpK8SGoNtpBB6Ij+QoqmC5OIdrLktq8hdyA=;
        b=20aXFR0CbgObXLMifNjA2AQCs13PIoCJBZ4/hgeq8rY12ueHl/zgkZQ23XqPGCjgdb
         Os43lcf2L5QW5wUzGQ8pGaA7m0hQeQSE7hoQ9H3sv9gphDK2g8mAUgRc+PCVWoXbQD2A
         LVkWyTdY0IGHFHSrIX3g3LJMYMPM6MITN8zSGlwutvCxlOwnee+vGwmMV/fgjdA31KUc
         C91cxOQZ8eJTCzj63b2i3hP7uw7UFqoBXmEa5A7UH700BS84ArJRoBK9nCHZfNuRJENL
         TcQlGlwpaaNKbI1eLcoASGpA6UK830J7u3vARB0l8md9lK1fya+GCi3/v++V5qWrPhYn
         tTMA==
X-Gm-Message-State: AOAM53157XObPSQvbwZqlgnPCS2hVQF41m8wb+Hfer3TaxfIZi8+BlDF
        4Y8al42QpjUoUUYu/P0Lj3nEPg==
X-Google-Smtp-Source: ABdhPJyLyRKMrvmUlnZpvmV+au+kPFkSDdm9JIL4QkYzROzZ5Dy/anBbaJj0AQR/YRdrPiRjQqQn2Q==
X-Received: by 2002:a17:90a:db08:b0:1c9:7cf3:6363 with SMTP id g8-20020a17090adb0800b001c97cf36363mr12071035pjv.35.1650272980251;
        Mon, 18 Apr 2022 02:09:40 -0700 (PDT)
Received: from C02G87K0MD6R.bytedance.net ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id p3-20020a056a000b4300b0050a4e73bf89sm8332116pfo.66.2022.04.18.02.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 02:09:39 -0700 (PDT)
From:   Hao Jia <jiahao.os@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, Hao Jia <jiahao.os@bytedance.com>
Subject: [PATCH] sched/core: Avoid obvious double update_rq_clock warning
Date:   Mon, 18 Apr 2022 17:09:29 +0800
Message-Id: <20220418090929.54005-1-jiahao.os@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
3. Run some rt tasks that periodically change the priority and sleep, e.g.:

void *ThreadFun(void *arg)
{
	int cnt = *(int*)arg;
	struct sched_param param;

	while (1) {
		sqrt(MAGIC_NUM);
		cnt = cnt % 10 + 1;
		param.sched_priority = cnt;
		pthread_setschedparam(pthread_self(), SCHED_RR, &param);
		sqrt(MAGIC_NUM);
		sqrt(MAGIC_NUM);
		sleep(cnt);
	}
	return NULL;
}

Signed-off-by: Hao Jia <jiahao.os@bytedance.com>
---
 kernel/sched/deadline.c | 18 +++++++++++-------
 kernel/sched/rt.c       | 20 ++++++++++++++++++--
 2 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index fb4255ae0b2c..9207b978cc43 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2258,6 +2258,7 @@ static int push_dl_task(struct rq *rq)
 {
 	struct task_struct *next_task;
 	struct rq *later_rq;
+	struct rq_flags srf, drf;
 	int ret = 0;
 
 	if (!rq->dl.overloaded)
@@ -2317,16 +2318,14 @@ static int push_dl_task(struct rq *rq)
 		goto retry;
 	}
 
+	rq_pin_lock(rq, &srf);
+	rq_pin_lock(later_rq, &drf);
 	deactivate_task(rq, next_task, 0);
 	set_task_cpu(next_task, later_rq->cpu);
-
-	/*
-	 * Update the later_rq clock here, because the clock is used
-	 * by the cpufreq_update_util() inside __add_running_bw().
-	 */
-	update_rq_clock(later_rq);
-	activate_task(later_rq, next_task, ENQUEUE_NOCLOCK);
+	activate_task(later_rq, next_task, 0);
 	ret = 1;
+	rq_unpin_lock(rq, &srf);
+	rq_unpin_lock(later_rq, &drf);
 
 	resched_curr(later_rq);
 
@@ -2351,6 +2350,7 @@ static void pull_dl_task(struct rq *this_rq)
 	struct task_struct *p, *push_task;
 	bool resched = false;
 	struct rq *src_rq;
+	struct rq_flags this_rf, src_rf;
 	u64 dmin = LONG_MAX;
 
 	if (likely(!dl_overloaded(this_rq)))
@@ -2413,11 +2413,15 @@ static void pull_dl_task(struct rq *this_rq)
 			if (is_migration_disabled(p)) {
 				push_task = get_push_task(src_rq);
 			} else {
+				rq_pin_lock(this_rq, &this_rf);
+				rq_pin_lock(src_rq, &src_rf);
 				deactivate_task(src_rq, p, 0);
 				set_task_cpu(p, this_cpu);
 				activate_task(this_rq, p, 0);
 				dmin = p->dl.deadline;
 				resched = true;
+				rq_unpin_lock(this_rq, &this_rf);
+				rq_unpin_lock(src_rq, &src_rf);
 			}
 
 			/* Is there any other task even earlier? */
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index a32c46889af8..9305ad87fef0 100644
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
@@ -2001,6 +2002,7 @@ static int push_rt_task(struct rq *rq, bool pull)
 {
 	struct task_struct *next_task;
 	struct rq *lowest_rq;
+	struct rq_flags srf, drf;
 	int ret = 0;
 
 	if (!rq->rt.overloaded)
@@ -2102,9 +2104,18 @@ static int push_rt_task(struct rq *rq, bool pull)
 		goto retry;
 	}
 
+	/*
+	 * We may drop rq'lock in double_lock_balance,
+	 * so we still need to clean up the RQCF_UPDATED flag
+	 * to avoid the WARN_DOUBLE_CLOCK warning.
+	 */
+	rq_pin_lock(rq, &srf);
+	rq_pin_lock(lowest_rq, &drf);
 	deactivate_task(rq, next_task, 0);
 	set_task_cpu(next_task, lowest_rq->cpu);
 	activate_task(lowest_rq, next_task, 0);
+	rq_unpin_lock(rq, &srf);
+	rq_unpin_lock(lowest_rq, &drf);
 	resched_curr(lowest_rq);
 	ret = 1;
 
@@ -2299,6 +2310,7 @@ static void pull_rt_task(struct rq *this_rq)
 	bool resched = false;
 	struct task_struct *p, *push_task;
 	struct rq *src_rq;
+	struct rq_flags src_rf, this_rf;
 	int rt_overload_count = rt_overloaded(this_rq);
 
 	if (likely(!rt_overload_count))
@@ -2375,10 +2387,14 @@ static void pull_rt_task(struct rq *this_rq)
 			if (is_migration_disabled(p)) {
 				push_task = get_push_task(src_rq);
 			} else {
+				rq_pin_lock(this_rq, &this_rf);
+				rq_pin_lock(src_rq, &src_rf);
 				deactivate_task(src_rq, p, 0);
 				set_task_cpu(p, this_cpu);
 				activate_task(this_rq, p, 0);
 				resched = true;
+				rq_unpin_lock(this_rq, &this_rf);
+				rq_unpin_lock(src_rq, &src_rf);
 			}
 			/*
 			 * We continue with the search, just in
-- 
2.32.0

