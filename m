Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13D6C465B25
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 01:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355087AbhLBApc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 19:45:32 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:37454 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354683AbhLBAmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 19:42:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 18B18B821AB;
        Thu,  2 Dec 2021 00:39:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2706AC5833F;
        Thu,  2 Dec 2021 00:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638405541;
        bh=aSUVez5pr95xwvB2cW6TJSk9s0oZI6dr5YoEdwcPgAk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TvyP7JhGm7FZe65Hv+Gq/Cv3OWAr2vpSVq43dy79+Ap2c3vRWqrzD77A5EZPksdq1
         19tM18+ZKS96GShBh0LVecxUGwDQNy4N6lQwDZvH1mOO7DMdNd50uDUIYHYiPmv26T
         /9+1E1mR6jCc3VHbRz2/c6mbIZdidfJib1vNNK0QE+x7/gKUY86u+0mXP3v8x9vpEN
         7eaT4gBtL6wYTyvj6VOTKkjANTd5SO8al2PpY1ITKvZ6v5ZFajsQbn+Y3fRZUuKkA5
         Xyeo7phV0aYFFVrj460UZfLbhKlGo54NlmvXbGyRJGGMSsgqCZN59ggO01bCnnNQ5L
         Jip0SwaXx7oQg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 62EE35C1357; Wed,  1 Dec 2021 16:39:00 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>, Martin Lau <kafai@fb.com>,
        Neeraj Upadhyay <neeraj.iitr10@gmail.com>
Subject: [PATCH rcu 17/18] rcu-tasks: Use separate ->percpu_dequeue_lim for callback dequeueing
Date:   Wed,  1 Dec 2021 16:38:57 -0800
Message-Id: <20211202003858.3129628-17-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20211202003826.GA3129369@paulmck-ThinkPad-P17-Gen-1>
References: <20211202003826.GA3129369@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Decreasing the number of callback queues is a bit tricky because it
is necessary to handle callbacks that were queued before the number of
queues decreased, but which were not ready to invoke until afterwards.
This commit takes a first step in this direction by maintaining a separate
->percpu_dequeue_lim to control callback dequeueing, in addition to the
existing ->percpu_enqueue_lim which now controls only enqueueing.

Reported-by: Martin Lau <kafai@fb.com>
Cc: Neeraj Upadhyay <neeraj.iitr10@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 1695da0f6985e..1fbffea6ae469 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -66,7 +66,8 @@ struct rcu_tasks_percpu {
  * @call_func: This flavor's call_rcu()-equivalent function.
  * @rtpcpu: This flavor's rcu_tasks_percpu structure.
  * @percpu_enqueue_shift: Shift down CPU ID this much when enqueuing callbacks.
- * @percpu_enqueue_lim: Number of per-CPU callback queues in use.
+ * @percpu_enqueue_lim: Number of per-CPU callback queues in use for enqueuing.
+ * @percpu_dequeue_lim: Number of per-CPU callback queues in use for dequeuing.
  * @barrier_q_mutex: Serialize barrier operations.
  * @barrier_q_count: Number of queues being waited on.
  * @barrier_q_completion: Barrier wait/wakeup mechanism.
@@ -96,6 +97,7 @@ struct rcu_tasks {
 	struct rcu_tasks_percpu __percpu *rtpcpu;
 	int percpu_enqueue_shift;
 	int percpu_enqueue_lim;
+	int percpu_dequeue_lim;
 	struct mutex barrier_q_mutex;
 	atomic_t barrier_q_count;
 	struct completion barrier_q_completion;
@@ -121,6 +123,7 @@ static struct rcu_tasks rt_name =							\
 	.name = n,									\
 	.percpu_enqueue_shift = ilog2(CONFIG_NR_CPUS),					\
 	.percpu_enqueue_lim = 1,							\
+	.percpu_dequeue_lim = 1,							\
 	.barrier_q_mutex = __MUTEX_INITIALIZER(rt_name.barrier_q_mutex),		\
 	.barrier_q_seq = (0UL - 50UL) << RCU_SEQ_CTR_SHIFT,				\
 	.kname = #rt_name,								\
@@ -223,6 +226,7 @@ static void cblist_init_generic(struct rcu_tasks *rtp)
 	if (lim > nr_cpu_ids)
 		lim = nr_cpu_ids;
 	WRITE_ONCE(rtp->percpu_enqueue_shift, ilog2(nr_cpu_ids / lim));
+	WRITE_ONCE(rtp->percpu_dequeue_lim, lim);
 	smp_store_release(&rtp->percpu_enqueue_lim, lim);
 	for_each_possible_cpu(cpu) {
 		struct rcu_tasks_percpu *rtpcp = per_cpu_ptr(rtp->rtpcpu, cpu);
@@ -290,6 +294,7 @@ static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
 		raw_spin_lock_irqsave(&rtp->cbs_gbl_lock, flags);
 		if (rtp->percpu_enqueue_lim != nr_cpu_ids) {
 			WRITE_ONCE(rtp->percpu_enqueue_shift, ilog2(nr_cpu_ids));
+			WRITE_ONCE(rtp->percpu_enqueue_lim, nr_cpu_ids);
 			smp_store_release(&rtp->percpu_enqueue_lim, nr_cpu_ids);
 			pr_info("Switching %s to per-CPU callback queuing.\n", rtp->name);
 		}
@@ -343,7 +348,7 @@ static void rcu_barrier_tasks_generic(struct rcu_tasks *rtp)
 	init_completion(&rtp->barrier_q_completion);
 	atomic_set(&rtp->barrier_q_count, 2);
 	for_each_possible_cpu(cpu) {
-		if (cpu >= smp_load_acquire(&rtp->percpu_enqueue_lim))
+		if (cpu >= smp_load_acquire(&rtp->percpu_dequeue_lim))
 			break;
 		rtpcp = per_cpu_ptr(rtp->rtpcpu, cpu);
 		rtpcp->barrier_q_head.func = rcu_barrier_tasks_generic_cb;
@@ -367,7 +372,7 @@ static int rcu_tasks_need_gpcb(struct rcu_tasks *rtp)
 	unsigned long flags;
 	int needgpcb = 0;
 
-	for (cpu = 0; cpu < smp_load_acquire(&rtp->percpu_enqueue_lim); cpu++) {
+	for (cpu = 0; cpu < smp_load_acquire(&rtp->percpu_dequeue_lim); cpu++) {
 		struct rcu_tasks_percpu *rtpcp = per_cpu_ptr(rtp->rtpcpu, cpu);
 
 		/* Advance and accelerate any new callbacks. */
@@ -399,11 +404,11 @@ static void rcu_tasks_invoke_cbs(struct rcu_tasks *rtp, struct rcu_tasks_percpu
 
 	cpu = rtpcp->cpu;
 	cpunext = cpu * 2 + 1;
-	if (cpunext < smp_load_acquire(&rtp->percpu_enqueue_lim)) {
+	if (cpunext < smp_load_acquire(&rtp->percpu_dequeue_lim)) {
 		rtpcp_next = per_cpu_ptr(rtp->rtpcpu, cpunext);
 		queue_work_on(cpunext, system_wq, &rtpcp_next->rtp_work);
 		cpunext++;
-		if (cpunext < smp_load_acquire(&rtp->percpu_enqueue_lim)) {
+		if (cpunext < smp_load_acquire(&rtp->percpu_dequeue_lim)) {
 			rtpcp_next = per_cpu_ptr(rtp->rtpcpu, cpunext);
 			queue_work_on(cpunext, system_wq, &rtpcp_next->rtp_work);
 		}
-- 
2.31.1.189.g2e36527f23

