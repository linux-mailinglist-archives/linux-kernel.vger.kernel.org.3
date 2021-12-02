Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCC2C465B24
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 01:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355069AbhLBAp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 19:45:29 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:37450 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354682AbhLBAmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 19:42:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 51117B8219F;
        Thu,  2 Dec 2021 00:39:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 299FAC63438;
        Thu,  2 Dec 2021 00:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638405541;
        bh=uSNyCb6Yt6ZbALrif93/SKn54UR8+ZTgu+9rZs3ctFY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GDQ1yIyLO5cBA6uKNeWJJ4s79l6Yty2ROLXVvfCrosIG0OcI45AFSHMbTKP49ZQ86
         gsdyrOMy80uT46rCKSF16ouJi9HH1A1ZAL/ukC3oUZv8Do9+c3IFNi1u0r6z8dw9vO
         6XKD38M+vm6YkvDryDqTpyeC7FWMVH7oAXzIMd8Ecb3a1af3qxVxdLMXHiGHRU2lFE
         PC8n37I/R1+C4utUmII6vLkmVojWXKk87Q8OAIblXBH9morjGdCjpPMJeZFA0x1jv+
         4d8ipSniWXM/k7uIAElKaD55PNOC/OITrYE0IzXdbX26Xox+xI/PPQj/DKAZYY/ewZ
         +vZVGFDdM19gA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 64D115C135A; Wed,  1 Dec 2021 16:39:00 -0800 (PST)
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
Subject: [PATCH rcu 18/18] rcu-tasks: Use fewer callbacks queues if callback flood ends
Date:   Wed,  1 Dec 2021 16:38:58 -0800
Message-Id: <20211202003858.3129628-18-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20211202003826.GA3129369@paulmck-ThinkPad-P17-Gen-1>
References: <20211202003826.GA3129369@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By default, when lock contention is encountered, the RCU Tasks flavors
of RCU switch to using per-CPU queueing.  However, if the callback
flood ends, per-CPU queueing continues to be used, which introduces
significant additional overhead, especially for callback invocation,
which fans out a series of workqueue handlers.

This commit therefore switches back to single-queue operation if at the
beginning of a grace period there are very few callbacks.  The definition
of "very few" is set by the rcupdate.rcu_task_collapse_lim module
parameter, which defaults to 10.  This switch happens in two phases,
with the first phase causing future callbacks to be enqueued on CPU 0's
queue, but with all queues continuing to be checked for grace periods
and callback invocation.  The second phase checks to see if an RCU grace
period has elapsed and if all remaining RCU-Tasks callbacks are queued
on CPU 0.  If so, only CPU 0 is checked for future grace periods and
callback operation.

Of course, the return of contention anywhere during this process will
result in returning to per-CPU callback queueing.

Reported-by: Martin Lau <kafai@fb.com>
Cc: Neeraj Upadhyay <neeraj.iitr10@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../admin-guide/kernel-parameters.txt         |  8 ++++
 kernel/rcu/tasks.h                            | 46 ++++++++++++++++++-
 2 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 089f4c5f8225b..d1b0542b85644 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4805,6 +4805,14 @@
 			period to instead use normal non-expedited
 			grace-period processing.
 
+	rcupdate.rcu_task_collapse_lim= [KNL]
+			Set the maximum number of callbacks present
+			at the beginning of a grace period that allows
+			the RCU Tasks flavors to collapse back to using
+			a single callback queue.  This switching only
+			occurs when rcupdate.rcu_task_enqueue_lim is
+			set to the default value of -1.
+
 	rcupdate.rcu_task_contend_lim= [KNL]
 			Set the minimum number of callback-queuing-time
 			lock-contention events per jiffy required to
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 1fbffea6ae469..02c673e64456e 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -68,6 +68,7 @@ struct rcu_tasks_percpu {
  * @percpu_enqueue_shift: Shift down CPU ID this much when enqueuing callbacks.
  * @percpu_enqueue_lim: Number of per-CPU callback queues in use for enqueuing.
  * @percpu_dequeue_lim: Number of per-CPU callback queues in use for dequeuing.
+ * @percpu_dequeue_gpseq: RCU grace-period number to propagate enqueue limit to dequeuers.
  * @barrier_q_mutex: Serialize barrier operations.
  * @barrier_q_count: Number of queues being waited on.
  * @barrier_q_completion: Barrier wait/wakeup mechanism.
@@ -98,6 +99,7 @@ struct rcu_tasks {
 	int percpu_enqueue_shift;
 	int percpu_enqueue_lim;
 	int percpu_dequeue_lim;
+	unsigned long percpu_dequeue_gpseq;
 	struct mutex barrier_q_mutex;
 	atomic_t barrier_q_count;
 	struct completion barrier_q_completion;
@@ -148,6 +150,8 @@ module_param(rcu_task_enqueue_lim, int, 0444);
 static bool rcu_task_cb_adjust;
 static int rcu_task_contend_lim __read_mostly = 100;
 module_param(rcu_task_contend_lim, int, 0444);
+static int rcu_task_collapse_lim __read_mostly = 10;
+module_param(rcu_task_collapse_lim, int, 0444);
 
 /* RCU tasks grace-period state for debugging. */
 #define RTGS_INIT		 0
@@ -269,6 +273,7 @@ static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
 	rhp->next = NULL;
 	rhp->func = func;
 	local_irq_save(flags);
+	rcu_read_lock();
 	rtpcp = per_cpu_ptr(rtp->rtpcpu,
 			    smp_processor_id() >> READ_ONCE(rtp->percpu_enqueue_shift));
 	if (!raw_spin_trylock_rcu_node(rtpcp)) { // irqs already disabled.
@@ -294,12 +299,13 @@ static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
 		raw_spin_lock_irqsave(&rtp->cbs_gbl_lock, flags);
 		if (rtp->percpu_enqueue_lim != nr_cpu_ids) {
 			WRITE_ONCE(rtp->percpu_enqueue_shift, ilog2(nr_cpu_ids));
-			WRITE_ONCE(rtp->percpu_enqueue_lim, nr_cpu_ids);
+			WRITE_ONCE(rtp->percpu_dequeue_lim, nr_cpu_ids);
 			smp_store_release(&rtp->percpu_enqueue_lim, nr_cpu_ids);
 			pr_info("Switching %s to per-CPU callback queuing.\n", rtp->name);
 		}
 		raw_spin_unlock_irqrestore(&rtp->cbs_gbl_lock, flags);
 	}
+	rcu_read_unlock();
 	/* We can't create the thread unless interrupts are enabled. */
 	if (needwake && READ_ONCE(rtp->kthread_ptr)) {
 		irq_work_queue(&rtpcp->rtp_irq_work);
@@ -370,6 +376,9 @@ static int rcu_tasks_need_gpcb(struct rcu_tasks *rtp)
 {
 	int cpu;
 	unsigned long flags;
+	long n;
+	long ncbs = 0;
+	long ncbsnz = 0;
 	int needgpcb = 0;
 
 	for (cpu = 0; cpu < smp_load_acquire(&rtp->percpu_dequeue_lim); cpu++) {
@@ -380,6 +389,13 @@ static int rcu_tasks_need_gpcb(struct rcu_tasks *rtp)
 			continue;
 		raw_spin_lock_irqsave_rcu_node(rtpcp, flags);
 		smp_mb__after_spinlock(); // Order updates vs. GP.
+		// Should we shrink down to a single callback queue?
+		if (!rcu_segcblist_empty(&rtpcp->cblist)) {
+			n = rcu_segcblist_n_cbs(&rtpcp->cblist);
+			ncbs += n;
+			if (cpu > 0)
+				ncbsnz += n;
+		}
 		rcu_segcblist_advance(&rtpcp->cblist, rcu_seq_current(&rtp->tasks_gp_seq));
 		(void)rcu_segcblist_accelerate(&rtpcp->cblist, rcu_seq_snap(&rtp->tasks_gp_seq));
 		if (rcu_segcblist_pend_cbs(&rtpcp->cblist))
@@ -388,6 +404,34 @@ static int rcu_tasks_need_gpcb(struct rcu_tasks *rtp)
 			needgpcb |= 0x1;
 		raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
 	}
+
+	// Shrink down to a single callback queue if appropriate.
+	// This is done in two stages: (1) If there are no more than
+	// rcu_task_collapse_lim callbacks on CPU 0 and none on any other
+	// CPU, limit enqueueing to CPU 0.  (2) After an RCU grace period,
+	// if there has not been an increase in callbacks, limit dequeuing
+	// to CPU 0.  Note the matching RCU read-side critical section in
+	// call_rcu_tasks_generic().
+	if (rcu_task_cb_adjust && ncbs <= rcu_task_collapse_lim) {
+		raw_spin_lock_irqsave(&rtp->cbs_gbl_lock, flags);
+		if (rtp->percpu_enqueue_lim > 1) {
+			WRITE_ONCE(rtp->percpu_enqueue_shift, ilog2(nr_cpu_ids));
+			smp_store_release(&rtp->percpu_enqueue_lim, 1);
+			rtp->percpu_dequeue_gpseq = get_state_synchronize_rcu();
+			pr_info("Starting switch %s to CPU-0 callback queuing.\n", rtp->name);
+		}
+		raw_spin_unlock_irqrestore(&rtp->cbs_gbl_lock, flags);
+	}
+	if (rcu_task_cb_adjust && !ncbsnz &&
+	    poll_state_synchronize_rcu(rtp->percpu_dequeue_gpseq)) {
+		raw_spin_lock_irqsave(&rtp->cbs_gbl_lock, flags);
+		if (rtp->percpu_enqueue_lim < rtp->percpu_dequeue_lim) {
+			WRITE_ONCE(rtp->percpu_dequeue_lim, 1);
+			pr_info("Completing switch %s to CPU-0 callback queuing.\n", rtp->name);
+		}
+		raw_spin_unlock_irqrestore(&rtp->cbs_gbl_lock, flags);
+	}
+
 	return needgpcb;
 }
 
-- 
2.31.1.189.g2e36527f23

