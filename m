Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00FFC465A78
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 01:12:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354159AbhLBAPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 19:15:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353980AbhLBAOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 19:14:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9716C061574;
        Wed,  1 Dec 2021 16:10:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AF4F6B80DAC;
        Thu,  2 Dec 2021 00:10:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 476E6C53FAD;
        Thu,  2 Dec 2021 00:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638403842;
        bh=52XEynZloXWwVtzz1EFj1h+AtswKgvYUoRYI3uiXyuY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=okyI2d7QKoAtNu+EMFWn865umLaigxB+JuCoqS0yBhxe09rYooGJ94ZBymoMzxquC
         naZdqyDrHLRn4VmTC0tfu02zinRMWoxq8GHtg9B2S2eta6sNVphMx3/GBkQEuKniyP
         0tBbpizqPvecFaw1gv5fM+ik9Y4b3Q3LUjSKJ8pgCuYDktNz3cMxNq+Cm7OUPuUBpA
         VusHL+2w5JZMec59206FG1pWJkryZd17A5Ki3+QoErUjBUSBtY9kaaJ4KGYwPr531a
         86QrWF7NEcfkgg1C0YQJXGxQJMkCbLxUa/Gmmv2H6jKsk2AvDuvyCdfFTlEFfKYX8E
         SL1gtxH/yUfYA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id F269C5C1109; Wed,  1 Dec 2021 16:10:41 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 3/7] rcu: Remove rcu_data.exp_deferred_qs and convert to rcu_data.cpu no_qs.b.exp
Date:   Wed,  1 Dec 2021 16:10:36 -0800
Message-Id: <20211202001040.3126390-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20211202001016.GA3126278@paulmck-ThinkPad-P17-Gen-1>
References: <20211202001016.GA3126278@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frederic Weisbecker <frederic@kernel.org>

Having two fields for the same purpose with subtle differences on
different RCU flavours is confusing, especially when both fields always
exist on both RCU flavours.

Fortunately, it is now safe for preemptible RCU to rely on the rcu_data
structure's ->cpu_no_qs.b.exp field, just like non-preemptible RCU.
This commit therefore removes the ad-hoc ->exp_deferred_qs field.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.h        |  1 -
 kernel/rcu/tree_exp.h    |  5 ++---
 kernel/rcu/tree_plugin.h | 12 ++++++------
 3 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 305cf6aeb4086..ea46ed40f6bc1 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -157,7 +157,6 @@ struct rcu_data {
 	bool		core_needs_qs;	/* Core waits for quiescent state. */
 	bool		beenonline;	/* CPU online at least once. */
 	bool		gpwrap;		/* Possible ->gp_seq wrap. */
-	bool		exp_deferred_qs; /* This CPU awaiting a deferred QS? */
 	bool		cpu_started;	/* RCU watching this onlining CPU. */
 	struct rcu_node *mynode;	/* This CPU's leaf of hierarchy */
 	unsigned long grpmask;		/* Mask to apply to leaf qsmask. */
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 6c6eb32203852..fc2ee326a6f73 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -255,7 +255,6 @@ static void rcu_report_exp_cpu_mult(struct rcu_node *rnp,
  */
 static void rcu_report_exp_rdp(struct rcu_data *rdp)
 {
-	WRITE_ONCE(rdp->exp_deferred_qs, false);
 	WRITE_ONCE(rdp->cpu_no_qs.b.exp, false);
 	rcu_report_exp_cpu_mult(rdp->mynode, rdp->grpmask, true);
 }
@@ -656,7 +655,7 @@ static void rcu_exp_handler(void *unused)
 		    rcu_dynticks_curr_cpu_in_eqs()) {
 			rcu_report_exp_rdp(rdp);
 		} else {
-			rdp->exp_deferred_qs = true;
+			WRITE_ONCE(rdp->cpu_no_qs.b.exp, true);
 			set_tsk_need_resched(t);
 			set_preempt_need_resched();
 		}
@@ -678,7 +677,7 @@ static void rcu_exp_handler(void *unused)
 	if (depth > 0) {
 		raw_spin_lock_irqsave_rcu_node(rnp, flags);
 		if (rnp->expmask & rdp->grpmask) {
-			rdp->exp_deferred_qs = true;
+			WRITE_ONCE(rdp->cpu_no_qs.b.exp, true);
 			t->rcu_read_unlock_special.b.exp_hint = true;
 		}
 		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 1e4b4e7630735..972acb114ce3c 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -260,10 +260,10 @@ static void rcu_preempt_ctxt_queue(struct rcu_node *rnp, struct rcu_data *rdp)
 	 * no need to check for a subsequent expedited GP.  (Though we are
 	 * still in a quiescent state in any case.)
 	 */
-	if (blkd_state & RCU_EXP_BLKD && rdp->exp_deferred_qs)
+	if (blkd_state & RCU_EXP_BLKD && rdp->cpu_no_qs.b.exp)
 		rcu_report_exp_rdp(rdp);
 	else
-		WARN_ON_ONCE(rdp->exp_deferred_qs);
+		WARN_ON_ONCE(rdp->cpu_no_qs.b.exp);
 }
 
 /*
@@ -354,7 +354,7 @@ void rcu_note_context_switch(bool preempt)
 	 * means that we continue to block the current grace period.
 	 */
 	rcu_qs();
-	if (rdp->exp_deferred_qs)
+	if (rdp->cpu_no_qs.b.exp)
 		rcu_report_exp_rdp(rdp);
 	rcu_tasks_qs(current, preempt);
 	trace_rcu_utilization(TPS("End context switch"));
@@ -481,7 +481,7 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
 	 */
 	special = t->rcu_read_unlock_special;
 	rdp = this_cpu_ptr(&rcu_data);
-	if (!special.s && !rdp->exp_deferred_qs) {
+	if (!special.s && !rdp->cpu_no_qs.b.exp) {
 		local_irq_restore(flags);
 		return;
 	}
@@ -501,7 +501,7 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
 	 * tasks are handled when removing the task from the
 	 * blocked-tasks list below.
 	 */
-	if (rdp->exp_deferred_qs)
+	if (rdp->cpu_no_qs.b.exp)
 		rcu_report_exp_rdp(rdp);
 
 	/* Clean up if blocked during RCU read-side critical section. */
@@ -584,7 +584,7 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
  */
 static bool rcu_preempt_need_deferred_qs(struct task_struct *t)
 {
-	return (__this_cpu_read(rcu_data.exp_deferred_qs) ||
+	return (__this_cpu_read(rcu_data.cpu_no_qs.b.exp) ||
 		READ_ONCE(t->rcu_read_unlock_special.s)) &&
 	       rcu_preempt_depth() == 0;
 }
-- 
2.31.1.189.g2e36527f23

