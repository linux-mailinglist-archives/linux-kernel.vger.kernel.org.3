Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 652AA465B2F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 01:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354976AbhLBApJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 19:45:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354638AbhLBAmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 19:42:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A4E4C06175A;
        Wed,  1 Dec 2021 16:39:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E5129B821A6;
        Thu,  2 Dec 2021 00:39:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCADDC5831B;
        Thu,  2 Dec 2021 00:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638405540;
        bh=I3ALel5Fzv6uEO8Qc85Bkq6/BICHpW3vrp1Rzaurv/k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K1m/t1wZ/ebtjUWdFg0H/8SWkUefoB5i9MCMDKvMvXKDXSJCA3768DvvF3Yy5EaGi
         bq67dc/xiRzIwg4JcZqpLiBsUsxJnOK5GCGa5PDUL6pfKrVsBdGpfuFUph0AhhDHGC
         scm4BS9OgcFqmeHXJcuQVBzy1dnIsiYpEDvNpRDFdjkn4Jo31wnq7ObyBuIdcYiDJD
         6pxf+2eT85Z9UTdmvJ00XnlkQjzF4DdHUybTnIkaiPO2G9dAq5ejiLT8BPzCVKmMlh
         G6KhGBSeoldSMN6TXb3+wKGWW4E/w5NqmfU74Wwezci3f1xAIbeRAsBF4d46hpCa80
         6EZ10z70OOYKA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 580095C12B3; Wed,  1 Dec 2021 16:39:00 -0800 (PST)
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
Subject: [PATCH rcu 11/18] rcu-tasks: Use workqueues for multiple rcu_tasks_invoke_cbs() invocations
Date:   Wed,  1 Dec 2021 16:38:51 -0800
Message-Id: <20211202003858.3129628-11-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20211202003826.GA3129369@paulmck-ThinkPad-P17-Gen-1>
References: <20211202003826.GA3129369@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If there is a flood of callbacks, it is necessary to put multiple
CPUs to work invoking those callbacks.  This commit therefore uses a
workqueue-flooding approach to parallelize RCU Tasks callback execution.

Reported-by: Martin Lau <kafai@fb.com>
Cc: Neeraj Upadhyay <neeraj.iitr10@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 77 +++++++++++++++++++++++++++++++---------------
 1 file changed, 53 insertions(+), 24 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 3bc0edb6a7bb6..a75a4ca78a621 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -24,10 +24,14 @@ typedef void (*postgp_func_t)(struct rcu_tasks *rtp);
  * struct rcu_tasks_percpu - Per-CPU component of definition for a Tasks-RCU-like mechanism.
  * @cblist: Callback list.
  * @lock: Lock protecting per-CPU callback list.
+ * @rtp_work: Work queue for invoking callbacks.
  */
 struct rcu_tasks_percpu {
 	struct rcu_segcblist cblist;
 	raw_spinlock_t __private lock;
+	struct work_struct rtp_work;
+	int cpu;
+	struct rcu_tasks *rtpp;
 };
 
 /**
@@ -146,6 +150,8 @@ static const char * const rcu_tasks_gp_state_names[] = {
 //
 // Generic code.
 
+static void rcu_tasks_invoke_cbs_wq(struct work_struct *wp);
+
 /* Record grace-period phase and time. */
 static void set_tasks_gp_state(struct rcu_tasks *rtp, int newstate)
 {
@@ -185,6 +191,9 @@ static void cblist_init_generic(struct rcu_tasks *rtp)
 		raw_spin_lock_rcu_node(rtpcp); // irqs already disabled.
 		if (rcu_segcblist_empty(&rtpcp->cblist))
 			rcu_segcblist_init(&rtpcp->cblist);
+		INIT_WORK(&rtpcp->rtp_work, rcu_tasks_invoke_cbs_wq);
+		rtpcp->cpu = cpu;
+		rtpcp->rtpp = rtp;
 		raw_spin_unlock_rcu_node(rtpcp); // irqs remain disabled.
 	}
 	raw_spin_unlock_irqrestore(&rtp->cbs_gbl_lock, flags);
@@ -257,36 +266,56 @@ static int rcu_tasks_need_gpcb(struct rcu_tasks *rtp)
 }
 
 // Advance callbacks and invoke any that are ready.
-static void rcu_tasks_invoke_cbs(struct rcu_tasks *rtp)
+static void rcu_tasks_invoke_cbs(struct rcu_tasks *rtp, struct rcu_tasks_percpu *rtpcp)
 {
 	int cpu;
+	int cpunext;
 	unsigned long flags;
 	int len;
-	struct rcu_cblist rcl = RCU_CBLIST_INITIALIZER(rcl);
 	struct rcu_head *rhp;
-
-	for (cpu = 0; cpu < rtp->percpu_enqueue_lim; cpu++) {
-		struct rcu_tasks_percpu *rtpcp = per_cpu_ptr(rtp->rtpcpu, cpu);
-
-		if (rcu_segcblist_empty(&rtpcp->cblist))
-			continue;
-		raw_spin_lock_irqsave_rcu_node(rtpcp, flags);
-		smp_mb__after_spinlock(); // Order updates vs. GP.
-		rcu_segcblist_advance(&rtpcp->cblist, rcu_seq_current(&rtp->tasks_gp_seq));
-		rcu_segcblist_extract_done_cbs(&rtpcp->cblist, &rcl);
-		raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
-		len = rcl.len;
-		for (rhp = rcu_cblist_dequeue(&rcl); rhp; rhp = rcu_cblist_dequeue(&rcl)) {
-			local_bh_disable();
-			rhp->func(rhp);
-			local_bh_enable();
-			cond_resched();
+	struct rcu_cblist rcl = RCU_CBLIST_INITIALIZER(rcl);
+	struct rcu_tasks_percpu *rtpcp_next;
+
+	cpu = rtpcp->cpu;
+	cpunext = cpu * 2 + 1;
+	if (cpunext < rtp->percpu_enqueue_lim) {
+		rtpcp_next = per_cpu_ptr(rtp->rtpcpu, cpunext);
+		queue_work_on(cpunext, system_wq, &rtpcp_next->rtp_work);
+		cpunext++;
+		if (cpunext < rtp->percpu_enqueue_lim) {
+			rtpcp_next = per_cpu_ptr(rtp->rtpcpu, cpunext);
+			queue_work_on(cpunext, system_wq, &rtpcp_next->rtp_work);
 		}
-		raw_spin_lock_irqsave_rcu_node(rtpcp, flags);
-		rcu_segcblist_add_len(&rtpcp->cblist, -len);
-		(void)rcu_segcblist_accelerate(&rtpcp->cblist, rcu_seq_snap(&rtp->tasks_gp_seq));
-		raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
 	}
+
+	if (rcu_segcblist_empty(&rtpcp->cblist))
+		return;
+	raw_spin_lock_irqsave_rcu_node(rtpcp, flags);
+	smp_mb__after_spinlock(); // Order updates vs. GP.
+	rcu_segcblist_advance(&rtpcp->cblist, rcu_seq_current(&rtp->tasks_gp_seq));
+	rcu_segcblist_extract_done_cbs(&rtpcp->cblist, &rcl);
+	raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
+	len = rcl.len;
+	for (rhp = rcu_cblist_dequeue(&rcl); rhp; rhp = rcu_cblist_dequeue(&rcl)) {
+		local_bh_disable();
+		rhp->func(rhp);
+		local_bh_enable();
+		cond_resched();
+	}
+	raw_spin_lock_irqsave_rcu_node(rtpcp, flags);
+	rcu_segcblist_add_len(&rtpcp->cblist, -len);
+	(void)rcu_segcblist_accelerate(&rtpcp->cblist, rcu_seq_snap(&rtp->tasks_gp_seq));
+	raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
+}
+
+// Workqueue flood to advance callbacks and invoke any that are ready.
+static void rcu_tasks_invoke_cbs_wq(struct work_struct *wp)
+{
+	struct rcu_tasks *rtp;
+	struct rcu_tasks_percpu *rtpcp = container_of(wp, struct rcu_tasks_percpu, rtp_work);
+
+	rtp = rtpcp->rtpp;
+	rcu_tasks_invoke_cbs(rtp, rtpcp);
 }
 
 /* RCU-tasks kthread that detects grace periods and invokes callbacks. */
@@ -322,7 +351,7 @@ static int __noreturn rcu_tasks_kthread(void *arg)
 
 		/* Invoke callbacks. */
 		set_tasks_gp_state(rtp, RTGS_INVOKE_CBS);
-		rcu_tasks_invoke_cbs(rtp);
+		rcu_tasks_invoke_cbs(rtp, per_cpu_ptr(rtp->rtpcpu, 0));
 
 		/* Paranoid sleep to keep this from entering a tight loop */
 		schedule_timeout_idle(rtp->gp_sleep);
-- 
2.31.1.189.g2e36527f23

