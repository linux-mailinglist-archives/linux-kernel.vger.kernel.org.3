Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79BFA465B19
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 01:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354717AbhLBAnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 19:43:15 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:37308 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354672AbhLBAm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 19:42:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D45E9B821A0;
        Thu,  2 Dec 2021 00:39:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1D1CC58323;
        Thu,  2 Dec 2021 00:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638405540;
        bh=BRHANxcsivGosPx0a9A/RcSuNJZDaN1XchfalbMwHgE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m8YF/fOzUUiUgaIHpowdLrl7SxyQj+zyqBBRJ2Uc74TVqkqSDdgsa03Vssw7W4Ve+
         afaBgN1o9CJF2Ujq+zkDYuY/HkcS/bpAt8twqlh29ONB6phHolcpIZq7v8L8u+pwPs
         34C6ElfvHmUs446NAG/T2mtzYn63nqigMzRdzoPQRtk+k6jSRp42DxgDYDFX4BwpAN
         UZpCVizXa0qWF/0aDa3QdZVba3/hRxD2z/Pnl01EbtLx/hdvahlmiKzbMUtmj0otvU
         zWSqsartL3IC40+/O0LIvr3qpdFvna8nKpjssNcOuYSZhLcvHmX2emzS7MaEmqOFrQ
         K8BBnr/YV59ZQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5611E5C12AF; Wed,  1 Dec 2021 16:39:00 -0800 (PST)
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
Subject: [PATCH rcu 10/18] rcu-tasks: Abstract invocations of callbacks
Date:   Wed,  1 Dec 2021 16:38:50 -0800
Message-Id: <20211202003858.3129628-10-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20211202003826.GA3129369@paulmck-ThinkPad-P17-Gen-1>
References: <20211202003826.GA3129369@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds a rcu_tasks_invoke_cbs() function that invokes all
ready callbacks on all of the per-CPU lists that are currently in use.

Reported-by: Martin Lau <kafai@fb.com>
Cc: Neeraj Upadhyay <neeraj.iitr10@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 58 ++++++++++++++++++++++++++++------------------
 1 file changed, 35 insertions(+), 23 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index bb37d4a4e48de..3bc0edb6a7bb6 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -256,14 +256,43 @@ static int rcu_tasks_need_gpcb(struct rcu_tasks *rtp)
 	return needgpcb;
 }
 
-/* RCU-tasks kthread that detects grace periods and invokes callbacks. */
-static int __noreturn rcu_tasks_kthread(void *arg)
+// Advance callbacks and invoke any that are ready.
+static void rcu_tasks_invoke_cbs(struct rcu_tasks *rtp)
 {
+	int cpu;
 	unsigned long flags;
 	int len;
-	int needgpcb;
 	struct rcu_cblist rcl = RCU_CBLIST_INITIALIZER(rcl);
 	struct rcu_head *rhp;
+
+	for (cpu = 0; cpu < rtp->percpu_enqueue_lim; cpu++) {
+		struct rcu_tasks_percpu *rtpcp = per_cpu_ptr(rtp->rtpcpu, cpu);
+
+		if (rcu_segcblist_empty(&rtpcp->cblist))
+			continue;
+		raw_spin_lock_irqsave_rcu_node(rtpcp, flags);
+		smp_mb__after_spinlock(); // Order updates vs. GP.
+		rcu_segcblist_advance(&rtpcp->cblist, rcu_seq_current(&rtp->tasks_gp_seq));
+		rcu_segcblist_extract_done_cbs(&rtpcp->cblist, &rcl);
+		raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
+		len = rcl.len;
+		for (rhp = rcu_cblist_dequeue(&rcl); rhp; rhp = rcu_cblist_dequeue(&rcl)) {
+			local_bh_disable();
+			rhp->func(rhp);
+			local_bh_enable();
+			cond_resched();
+		}
+		raw_spin_lock_irqsave_rcu_node(rtpcp, flags);
+		rcu_segcblist_add_len(&rtpcp->cblist, -len);
+		(void)rcu_segcblist_accelerate(&rtpcp->cblist, rcu_seq_snap(&rtp->tasks_gp_seq));
+		raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
+	}
+}
+
+/* RCU-tasks kthread that detects grace periods and invokes callbacks. */
+static int __noreturn rcu_tasks_kthread(void *arg)
+{
+	int needgpcb;
 	struct rcu_tasks *rtp = arg;
 
 	/* Run on housekeeping CPUs by default.  Sysadm can move if desired. */
@@ -277,8 +306,6 @@ static int __noreturn rcu_tasks_kthread(void *arg)
 	 * This loop is terminated by the system going down.  ;-)
 	 */
 	for (;;) {
-		struct rcu_tasks_percpu *rtpcp;
-
 		set_tasks_gp_state(rtp, RTGS_WAIT_CBS);
 
 		/* If there were none, wait a bit and start over. */
@@ -293,25 +320,10 @@ static int __noreturn rcu_tasks_kthread(void *arg)
 			rcu_seq_end(&rtp->tasks_gp_seq);
 		}
 
-		/* Invoke the callbacks. */
+		/* Invoke callbacks. */
 		set_tasks_gp_state(rtp, RTGS_INVOKE_CBS);
-		rtpcp = per_cpu_ptr(rtp->rtpcpu, 0);
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
-		}
-		raw_spin_lock_irqsave_rcu_node(rtpcp, flags);
-		rcu_segcblist_add_len(&rtpcp->cblist, -len);
-		(void)rcu_segcblist_accelerate(&rtpcp->cblist, rcu_seq_snap(&rtp->tasks_gp_seq));
-		raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
+		rcu_tasks_invoke_cbs(rtp);
+
 		/* Paranoid sleep to keep this from entering a tight loop */
 		schedule_timeout_idle(rtp->gp_sleep);
 	}
-- 
2.31.1.189.g2e36527f23

