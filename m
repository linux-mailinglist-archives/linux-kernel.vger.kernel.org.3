Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFE71465AC9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 01:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354326AbhLBAcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 19:32:43 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:59964 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233113AbhLBAci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 19:32:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0758DB82195;
        Thu,  2 Dec 2021 00:29:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A81AAC53FD0;
        Thu,  2 Dec 2021 00:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638404954;
        bh=zOZLRiDS8C5eBJKlLNIh5PHs/SkHMg9fQeqKEn3Qo1I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WgfkbOiXXwXScm2wm/VopmXM8X2xZLCu5meGLNk1KbrBC/pLnczgGhTfqSXatphmd
         uh830YivYbln7e39iSdQAH4ORQcFQO8B2E7bXcvc0LQYNhDyCZFrh+zXIsFRng1nEE
         ucB+cGEjyz28LobWcFm++1yUyTNIJxT5136vM1zHi/NhN0sbTZA3jg9JT2kwMZQdwj
         OcVTecm5x/V+py1sRrm9X0v7Sx0R0jAll6l6hybq6Q2V+tw+rgQvPY6URxMQv1agfy
         riQ/UU0yMe8kI8efbV7xMhzgiigiGjwkhvKyaplWaUMw1dE6OeNfDoZt7mhu+E4lpW
         EfOUym5fa4gRg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 643F05C117F; Wed,  1 Dec 2021 16:29:14 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 04/18] rcu/nocb: Invoke rcu_core() at the start of deoffloading
Date:   Wed,  1 Dec 2021 16:28:58 -0800
Message-Id: <20211202002912.3127710-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20211202002848.GA3127439@paulmck-ThinkPad-P17-Gen-1>
References: <20211202002848.GA3127439@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frederic Weisbecker <frederic@kernel.org>

On PREEMPT_RT, if rcu_core() is preempted by the de-offloading process,
some work, such as callbacks acceleration and invocation, may be left
unattended due to the volatile checks on the offloaded state.

In the worst case this work is postponed until the next rcu_pending()
check that can take a jiffy to reach, which can be a problem in case
of callbacks flooding.

Solve that with invoking rcu_core() early in the de-offloading process.
This way any work dismissed by an ongoing rcu_core() call fooled by
a preempting deoffloading process will be caught up by a nearby future
recall to rcu_core(), this time fully aware of the de-offloading state.

Tested-by: Valentin Schneider <valentin.schneider@arm.com>
Tested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Cc: Uladzislau Rezki <urezki@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcu_segcblist.h | 14 ++++++++++++++
 kernel/rcu/rcu_segcblist.c    |  6 ++----
 kernel/rcu/tree.c             | 17 +++++++++++++++++
 kernel/rcu/tree_nocb.h        |  9 +++++++++
 4 files changed, 42 insertions(+), 4 deletions(-)

diff --git a/include/linux/rcu_segcblist.h b/include/linux/rcu_segcblist.h
index 812961b1d0642..659d13a7ddaaa 100644
--- a/include/linux/rcu_segcblist.h
+++ b/include/linux/rcu_segcblist.h
@@ -136,6 +136,20 @@ struct rcu_cblist {
  *  |--------------------------------------------------------------------------|
  *  |                           SEGCBLIST_RCU_CORE   |                         |
  *  |                           SEGCBLIST_LOCKING    |                         |
+ *  |                           SEGCBLIST_OFFLOADED  |                         |
+ *  |                           SEGCBLIST_KTHREAD_CB |                         |
+ *  |                           SEGCBLIST_KTHREAD_GP                           |
+ *  |                                                                          |
+ *  |   CB/GP kthreads handle callbacks holding nocb_lock, local rcu_core()    |
+ *  |   handles callbacks concurrently. Bypass enqueue is enabled.             |
+ *  |   Invoke RCU core so we make sure not to preempt it in the middle with   |
+ *  |   leaving some urgent work unattended within a jiffy.                    |
+ *  ----------------------------------------------------------------------------
+ *                                      |
+ *                                      v
+ *  |--------------------------------------------------------------------------|
+ *  |                           SEGCBLIST_RCU_CORE   |                         |
+ *  |                           SEGCBLIST_LOCKING    |                         |
  *  |                           SEGCBLIST_KTHREAD_CB |                         |
  *  |                           SEGCBLIST_KTHREAD_GP                           |
  *  |                                                                          |
diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
index c07aab6e39ef2..81145c3ece25f 100644
--- a/kernel/rcu/rcu_segcblist.c
+++ b/kernel/rcu/rcu_segcblist.c
@@ -265,12 +265,10 @@ void rcu_segcblist_disable(struct rcu_segcblist *rsclp)
  */
 void rcu_segcblist_offload(struct rcu_segcblist *rsclp, bool offload)
 {
-	if (offload) {
+	if (offload)
 		rcu_segcblist_set_flags(rsclp, SEGCBLIST_LOCKING | SEGCBLIST_OFFLOADED);
-	} else {
-		rcu_segcblist_set_flags(rsclp, SEGCBLIST_RCU_CORE);
+	else
 		rcu_segcblist_clear_flags(rsclp, SEGCBLIST_OFFLOADED);
-	}
 }
 
 /*
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index e905d7e4ddb91..a329adfece86e 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2707,6 +2707,23 @@ static __latent_entropy void rcu_core(void)
 	unsigned long flags;
 	struct rcu_data *rdp = raw_cpu_ptr(&rcu_data);
 	struct rcu_node *rnp = rdp->mynode;
+	/*
+	 * On RT rcu_core() can be preempted when IRQs aren't disabled.
+	 * Therefore this function can race with concurrent NOCB (de-)offloading
+	 * on this CPU and the below condition must be considered volatile.
+	 * However if we race with:
+	 *
+	 * _ Offloading:   In the worst case we accelerate or process callbacks
+	 *                 concurrently with NOCB kthreads. We are guaranteed to
+	 *                 call rcu_nocb_lock() if that happens.
+	 *
+	 * _ Deoffloading: In the worst case we miss callbacks acceleration or
+	 *                 processing. This is fine because the early stage
+	 *                 of deoffloading invokes rcu_core() after setting
+	 *                 SEGCBLIST_RCU_CORE. So we guarantee that we'll process
+	 *                 what could have been dismissed without the need to wait
+	 *                 for the next rcu_pending() check in the next jiffy.
+	 */
 	const bool do_batch = !rcu_segcblist_completely_offloaded(&rdp->cblist);
 
 	if (cpu_is_offline(smp_processor_id()))
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index b3e07d0bfbbf8..2461fe8d0c23a 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -990,6 +990,15 @@ static long rcu_nocb_rdp_deoffload(void *arg)
 	 * will refuse to put anything into the bypass.
 	 */
 	WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies));
+	/*
+	 * Start with invoking rcu_core() early. This way if the current thread
+	 * happens to preempt an ongoing call to rcu_core() in the middle,
+	 * leaving some work dismissed because rcu_core() still thinks the rdp is
+	 * completely offloaded, we are guaranteed a nearby future instance of
+	 * rcu_core() to catch up.
+	 */
+	rcu_segcblist_set_flags(cblist, SEGCBLIST_RCU_CORE);
+	invoke_rcu_core();
 	ret = rdp_offload_toggle(rdp, false, flags);
 	swait_event_exclusive(rdp->nocb_state_wq,
 			      !rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_CB |
-- 
2.31.1.189.g2e36527f23

