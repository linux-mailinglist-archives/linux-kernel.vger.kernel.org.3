Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DED62552722
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 00:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344789AbiFTWv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 18:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344292AbiFTWvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 18:51:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91AD41CFE9;
        Mon, 20 Jun 2022 15:51:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 321B3B81647;
        Mon, 20 Jun 2022 22:51:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E371CC341C4;
        Mon, 20 Jun 2022 22:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655765489;
        bh=ACOAnReZZ1KNWERT78Y+XXrv26YxUQErtxLadQJY+wM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FeRRs3cP0auAZtGdMUbDSe5Eq9cmc2Ej8L+ofGRLO8vTtP1bpbgBdlYX3T+YFeHir
         2LYcj1FPcAdAt9ofoteBPlc9FBQ0OBdMwIjxDMaQDaEpbMpH4RfzuPHioHwpfriZjZ
         BceMN7zW2mRum/J3jfRGJ9UUj+M56XHhnrId+mSmwmPiRN0XFYLL8miu6R6rRgPAO1
         POved6yzkd/rdJLjMBrBvCjOFUF8yUArGwVaQELLpgk3EzFxSER+IbV1AdHTLB8cOS
         An/iNWbV1DlOa0tyzsmJlbvwuK6IVrHeWDb7FPDUKDWUkehOLYaY7/+8kpjteO9js5
         8ZoCG6CnHDMcA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 98E955C0A33; Mon, 20 Jun 2022 15:51:29 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Brian Foster <bfoster@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>
Subject: [PATCH rcu 04/12] rcu: Switch polled grace-period APIs to ->gp_seq_polled
Date:   Mon, 20 Jun 2022 15:51:20 -0700
Message-Id: <20220620225128.3842050-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220620224943.GA3841634@paulmck-ThinkPad-P17-Gen-1>
References: <20220620224943.GA3841634@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit switches the existing polled grace-period APIs to use a
new ->gp_seq_polled counter in the rcu_state structure.  An additional
->gp_seq_polled_snap counter in that same structure allows the normal
grace period kthread to interact properly with the !SMP !PREEMPT fastpath
through synchronize_rcu().  The first of the two to note the end of a
given grace period will make knowledge of this transition available to
the polled API.

This commit is in preparation for polled expedited grace periods.

Link: https://lore.kernel.org/all/20220121142454.1994916-1-bfoster@redhat.com/
Link: https://docs.google.com/document/d/1RNKWW9jQyfjxw2E8dsXVTdvZYh0HnYeSHDKog9jhdN8/edit?usp=sharing
Cc: Brian Foster <bfoster@redhat.com>
Cc: Dave Chinner <david@fromorbit.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Ian Kent <raven@themaw.net>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 90 +++++++++++++++++++++++++++++++++++++++++++++--
 kernel/rcu/tree.h |  2 ++
 2 files changed, 89 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 46cfceea87847..637e8f9454573 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1775,6 +1775,78 @@ static void rcu_strict_gp_boundary(void *unused)
 	invoke_rcu_core();
 }
 
+// Has rcu_init() been invoked?  This is used (for example) to determine
+// whether spinlocks may be acquired safely.
+static bool rcu_init_invoked(void)
+{
+	return !!rcu_state.n_online_cpus;
+}
+
+// Make the polled API aware of the beginning of a grace period.
+static void rcu_poll_gp_seq_start(unsigned long *snap)
+{
+	struct rcu_node *rnp = rcu_get_root();
+
+	if (rcu_init_invoked())
+		raw_lockdep_assert_held_rcu_node(rnp);
+
+	// If RCU was idle, note beginning of GP.
+	if (!rcu_seq_state(rcu_state.gp_seq_polled))
+		rcu_seq_start(&rcu_state.gp_seq_polled);
+
+	// Either way, record current state.
+	*snap = rcu_state.gp_seq_polled;
+}
+
+// Make the polled API aware of the end of a grace period.
+static void rcu_poll_gp_seq_end(unsigned long *snap)
+{
+	struct rcu_node *rnp = rcu_get_root();
+
+	if (rcu_init_invoked())
+		raw_lockdep_assert_held_rcu_node(rnp);
+
+	// If the the previously noted GP is still in effect, record the
+	// end of that GP.  Either way, zero counter to avoid counter-wrap
+	// problems.
+	if (*snap && *snap == rcu_state.gp_seq_polled) {
+		rcu_seq_end(&rcu_state.gp_seq_polled);
+		rcu_state.gp_seq_polled_snap = 0;
+	} else {
+		*snap = 0;
+	}
+}
+
+// Make the polled API aware of the beginning of a grace period, but
+// where caller does not hold the root rcu_node structure's lock.
+static void rcu_poll_gp_seq_start_unlocked(unsigned long *snap)
+{
+	struct rcu_node *rnp = rcu_get_root();
+
+	if (rcu_init_invoked()) {
+		lockdep_assert_irqs_enabled();
+		raw_spin_lock_irq_rcu_node(rnp);
+	}
+	rcu_poll_gp_seq_start(snap);
+	if (rcu_init_invoked())
+		raw_spin_unlock_irq_rcu_node(rnp);
+}
+
+// Make the polled API aware of the end of a grace period, but where
+// caller does not hold the root rcu_node structure's lock.
+static void rcu_poll_gp_seq_end_unlocked(unsigned long *snap)
+{
+	struct rcu_node *rnp = rcu_get_root();
+
+	if (rcu_init_invoked()) {
+		lockdep_assert_irqs_enabled();
+		raw_spin_lock_irq_rcu_node(rnp);
+	}
+	rcu_poll_gp_seq_end(snap);
+	if (rcu_init_invoked())
+		raw_spin_unlock_irq_rcu_node(rnp);
+}
+
 /*
  * Initialize a new grace period.  Return false if no grace period required.
  */
@@ -1810,6 +1882,7 @@ static noinline_for_stack bool rcu_gp_init(void)
 	rcu_seq_start(&rcu_state.gp_seq);
 	ASSERT_EXCLUSIVE_WRITER(rcu_state.gp_seq);
 	trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq, TPS("start"));
+	rcu_poll_gp_seq_start(&rcu_state.gp_seq_polled_snap);
 	raw_spin_unlock_irq_rcu_node(rnp);
 
 	/*
@@ -2069,6 +2142,7 @@ static noinline void rcu_gp_cleanup(void)
 	 * safe for us to drop the lock in order to mark the grace
 	 * period as completed in all of the rcu_node structures.
 	 */
+	rcu_poll_gp_seq_end(&rcu_state.gp_seq_polled_snap);
 	raw_spin_unlock_irq_rcu_node(rnp);
 
 	/*
@@ -3837,8 +3911,18 @@ void synchronize_rcu(void)
 			 lock_is_held(&rcu_lock_map) ||
 			 lock_is_held(&rcu_sched_lock_map),
 			 "Illegal synchronize_rcu() in RCU read-side critical section");
-	if (rcu_blocking_is_gp())
+	if (rcu_blocking_is_gp()) {
+		// Note well that this code runs with !PREEMPT && !SMP.
+		// In addition, all code that advances grace periods runs
+		// at process level.  Therefore, this GP overlaps with other
+		// GPs only by being fully nested within them, which allows
+		// reuse of ->gp_seq_polled_snap.
+		rcu_poll_gp_seq_start_unlocked(&rcu_state.gp_seq_polled_snap);
+		rcu_poll_gp_seq_end_unlocked(&rcu_state.gp_seq_polled_snap);
+		if (rcu_init_invoked())
+			cond_resched_tasks_rcu_qs();
 		return;  // Context allows vacuous grace periods.
+	}
 	if (rcu_gp_is_expedited())
 		synchronize_rcu_expedited();
 	else
@@ -3860,7 +3944,7 @@ unsigned long get_state_synchronize_rcu(void)
 	 * before the load from ->gp_seq.
 	 */
 	smp_mb();  /* ^^^ */
-	return rcu_seq_snap(&rcu_state.gp_seq);
+	return rcu_seq_snap(&rcu_state.gp_seq_polled);
 }
 EXPORT_SYMBOL_GPL(get_state_synchronize_rcu);
 
@@ -3925,7 +4009,7 @@ EXPORT_SYMBOL_GPL(start_poll_synchronize_rcu);
 bool poll_state_synchronize_rcu(unsigned long oldstate)
 {
 	if (oldstate == RCU_GET_STATE_COMPLETED ||
-	    rcu_seq_done_exact(&rcu_state.gp_seq, oldstate)) {
+	    rcu_seq_done_exact(&rcu_state.gp_seq_polled, oldstate)) {
 		smp_mb(); /* Ensure GP ends before subsequent accesses. */
 		return true;
 	}
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 2ccf5845957df..9c853033f159d 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -323,6 +323,8 @@ struct rcu_state {
 	short gp_state;				/* GP kthread sleep state. */
 	unsigned long gp_wake_time;		/* Last GP kthread wake. */
 	unsigned long gp_wake_seq;		/* ->gp_seq at ^^^. */
+	unsigned long gp_seq_polled;		/* GP seq for polled API. */
+	unsigned long gp_seq_polled_snap;	/* ->gp_seq_polled at normal GP start. */
 
 	/* End of fields guarded by root rcu_node's lock. */
 
-- 
2.31.1.189.g2e36527f23

