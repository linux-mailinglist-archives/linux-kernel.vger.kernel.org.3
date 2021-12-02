Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29EFE465B22
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 01:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355031AbhLBApR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 19:45:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354669AbhLBAmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 19:42:43 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B388FC06175B;
        Wed,  1 Dec 2021 16:39:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 02A44CE2134;
        Thu,  2 Dec 2021 00:39:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFFA7C58322;
        Thu,  2 Dec 2021 00:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638405540;
        bh=wFxhk+ioAyHFQIkcJ9i4zIh9hCEoLMMuqFEpy5nc77k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G4mh5Oui3Uba7WuAc+Xe7LexrAZoUh5WsN/e+1g6q9gsFwYInmBjT6NkiC8bzRLjt
         9p2pqT7a/ldW7KR3vvWEypH91pg/BORXAbFIYpCZb+DOpwcwLAFpu0Rv55As8teH0w
         TXl5RtyC6ZOEUPoZMEyRdunSJmkpaf6rK639UQO72RhPPlcmdus1x6nx2Y5oqywZCY
         2ikrt0KKVX/ZJVAuAfZajhH6LbLHRuvyKM2THy4okqGR7Seyn/aEbvMgJj5Qmyz73m
         wy58JDZnVaSSsYSbCn1eh/wELrkrDgv3dlmtE9YntT1z67aj7M+eNUL4hKWmlmb2VE
         UdhHFAKJ/BLog==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5448A5C12AB; Wed,  1 Dec 2021 16:39:00 -0800 (PST)
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
Subject: [PATCH rcu 09/18] rcu-tasks: Abstract checking of callback lists
Date:   Wed,  1 Dec 2021 16:38:49 -0800
Message-Id: <20211202003858.3129628-9-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20211202003826.GA3129369@paulmck-ThinkPad-P17-Gen-1>
References: <20211202003826.GA3129369@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds a rcu_tasks_need_gpcb() function that returns an
indication of whether another grace period is required, and if no grace
period is required, whether there are callbacks that need to be invoked.
The function scans all per-CPU lists currently in use.

Reported-by: Martin Lau <kafai@fb.com>
Cc: Neeraj Upadhyay <neeraj.iitr10@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 63 ++++++++++++++++++++++++++++------------------
 1 file changed, 39 insertions(+), 24 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 1c7cf8e8d65e7..bb37d4a4e48de 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -229,11 +229,39 @@ static void synchronize_rcu_tasks_generic(struct rcu_tasks *rtp)
 	wait_rcu_gp(rtp->call_func);
 }
 
+// Advance callbacks and indicate whether either a grace period or
+// callback invocation is needed.
+static int rcu_tasks_need_gpcb(struct rcu_tasks *rtp)
+{
+	int cpu;
+	unsigned long flags;
+	int needgpcb = 0;
+
+	for (cpu = 0; cpu < rtp->percpu_enqueue_lim; cpu++) {
+		struct rcu_tasks_percpu *rtpcp = per_cpu_ptr(rtp->rtpcpu, cpu);
+
+		/* Advance and accelerate any new callbacks. */
+		if (rcu_segcblist_empty(&rtpcp->cblist))
+			continue;
+		raw_spin_lock_irqsave_rcu_node(rtpcp, flags);
+		smp_mb__after_spinlock(); // Order updates vs. GP.
+		rcu_segcblist_advance(&rtpcp->cblist, rcu_seq_current(&rtp->tasks_gp_seq));
+		(void)rcu_segcblist_accelerate(&rtpcp->cblist, rcu_seq_snap(&rtp->tasks_gp_seq));
+		if (rcu_segcblist_pend_cbs(&rtpcp->cblist))
+			needgpcb |= 0x3;
+		if (!rcu_segcblist_empty(&rtpcp->cblist))
+			needgpcb |= 0x1;
+		raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
+	}
+	return needgpcb;
+}
+
 /* RCU-tasks kthread that detects grace periods and invokes callbacks. */
 static int __noreturn rcu_tasks_kthread(void *arg)
 {
 	unsigned long flags;
 	int len;
+	int needgpcb;
 	struct rcu_cblist rcl = RCU_CBLIST_INITIALIZER(rcl);
 	struct rcu_head *rhp;
 	struct rcu_tasks *rtp = arg;
@@ -249,38 +277,25 @@ static int __noreturn rcu_tasks_kthread(void *arg)
 	 * This loop is terminated by the system going down.  ;-)
 	 */
 	for (;;) {
-		struct rcu_tasks_percpu *rtpcp = per_cpu_ptr(rtp->rtpcpu, 0);  // for_each...
+		struct rcu_tasks_percpu *rtpcp;
 
 		set_tasks_gp_state(rtp, RTGS_WAIT_CBS);
 
-		/* Pick up any new callbacks. */
-		raw_spin_lock_irqsave_rcu_node(rtpcp, flags);
-		smp_mb__after_spinlock(); // Order updates vs. GP.
-		rcu_segcblist_advance(&rtpcp->cblist, rcu_seq_current(&rtp->tasks_gp_seq));
-		(void)rcu_segcblist_accelerate(&rtpcp->cblist, rcu_seq_snap(&rtp->tasks_gp_seq));
-		raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
-
 		/* If there were none, wait a bit and start over. */
-		if (!rcu_segcblist_pend_cbs(&rtpcp->cblist)) {
-			wait_event_interruptible(rtp->cbs_wq,
-						 rcu_segcblist_pend_cbs(&rtpcp->cblist));
-			if (!rcu_segcblist_pend_cbs(&rtpcp->cblist)) {
-				WARN_ON(signal_pending(current));
-				set_tasks_gp_state(rtp, RTGS_WAIT_WAIT_CBS);
-				schedule_timeout_idle(HZ/10);
-			}
-			continue;
+		wait_event_idle(rtp->cbs_wq, (needgpcb = rcu_tasks_need_gpcb(rtp)));
+
+		if (needgpcb & 0x2) {
+			// Wait for one grace period.
+			set_tasks_gp_state(rtp, RTGS_WAIT_GP);
+			rtp->gp_start = jiffies;
+			rcu_seq_start(&rtp->tasks_gp_seq);
+			rtp->gp_func(rtp);
+			rcu_seq_end(&rtp->tasks_gp_seq);
 		}
 
-		// Wait for one grace period.
-		set_tasks_gp_state(rtp, RTGS_WAIT_GP);
-		rtp->gp_start = jiffies;
-		rcu_seq_start(&rtp->tasks_gp_seq);
-		rtp->gp_func(rtp);
-		rcu_seq_end(&rtp->tasks_gp_seq);
-
 		/* Invoke the callbacks. */
 		set_tasks_gp_state(rtp, RTGS_INVOKE_CBS);
+		rtpcp = per_cpu_ptr(rtp->rtpcpu, 0);
 		raw_spin_lock_irqsave_rcu_node(rtpcp, flags);
 		smp_mb__after_spinlock(); // Order updates vs. GP.
 		rcu_segcblist_advance(&rtpcp->cblist, rcu_seq_current(&rtp->tasks_gp_seq));
-- 
2.31.1.189.g2e36527f23

