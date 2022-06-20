Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36651552723
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 00:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344610AbiFTWwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 18:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344329AbiFTWve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 18:51:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A10A01A80D;
        Mon, 20 Jun 2022 15:51:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 44AE6B811EC;
        Mon, 20 Jun 2022 22:51:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED933C341C7;
        Mon, 20 Jun 2022 22:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655765490;
        bh=uwVUEbn1BjyEoK1jDk5Unz9mOIc6Tdakf4qOEcADLk4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mONd/Seg/uHV2XAfrneucCGVpsJAWG3Fw0a0/TRF8eDZSB0O7MpJ6GJn+rbaopVEA
         yuMPH07Wdyhcfr/I+5Z8eJs8F2Dt60auYwI4jds+A8HvWBXXeQEjg9KGCePv1mNU/1
         MVcij0DFgk9b/9w3WDnRURKT5nEKSSHyGMPHe1qtpSO4aVD/SyXlIuqA+18/0Wy7r2
         pnGcVQEEtkJwjfaAfMj0ZFLzpvNJJIFu61QYUG6M91bSLJuu9BAerfF+TRd9hfy/JY
         fuwb0Z0zDYW0b/MtSYxWAYi/iXT0cE8KpxX5QK/WfbVoGn68t0zT+1ac+VkBlp5NQS
         xS8Ml37Oj40AA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 9B29E5C0ADC; Mon, 20 Jun 2022 15:51:29 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Brian Foster <bfoster@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>
Subject: [PATCH rcu 05/12] rcu: Make polled grace-period API account for expedited grace periods
Date:   Mon, 20 Jun 2022 15:51:21 -0700
Message-Id: <20220620225128.3842050-5-paulmck@kernel.org>
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

Currently, this code could splat:

	oldstate = get_state_synchronize_rcu();
	synchronize_rcu_expedited();
	WARN_ON_ONCE(!poll_state_synchronize_rcu(oldstate));

This situation is counter-intuitive and user-unfriendly.  After all, there
really was a perfectly valid full grace period right after the call to
get_state_synchronize_rcu(), so why shouldn't poll_state_synchronize_rcu()
know about it?

This commit therefore makes the polled grace-period API aware of expedited
grace periods in addition to the normal grace periods that it is already
aware of.  With this change, the above code is guaranteed not to splat.

Please note that the above code can still splat due to counter wrap on the
one hand and situations involving partially overlapping normal/expedited
grace periods on the other.  On 64-bit systems, the second is of course
much more likely than the first.  It is possible to modify this approach
to prevent overlapping grace periods from causing splats, but only at
the expense of greatly increasing the probability of counter wrap, as
in within milliseconds on 32-bit systems and within minutes on 64-bit
systems.

This commit is in preparation for polled expedited grace periods.

Link: https://lore.kernel.org/all/20220121142454.1994916-1-bfoster@redhat.com/
Link: https://docs.google.com/document/d/1RNKWW9jQyfjxw2E8dsXVTdvZYh0HnYeSHDKog9jhdN8/edit?usp=sharing
Cc: Brian Foster <bfoster@redhat.com>
Cc: Dave Chinner <david@fromorbit.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Ian Kent <raven@themaw.net>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c     |  9 +++++----
 kernel/rcu/tree.h     |  1 +
 kernel/rcu/tree_exp.h | 16 ++++++++++++++--
 3 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 637e8f9454573..251eb9a8cd925 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1812,6 +1812,7 @@ static void rcu_poll_gp_seq_end(unsigned long *snap)
 	if (*snap && *snap == rcu_state.gp_seq_polled) {
 		rcu_seq_end(&rcu_state.gp_seq_polled);
 		rcu_state.gp_seq_polled_snap = 0;
+		rcu_state.gp_seq_polled_exp_snap = 0;
 	} else {
 		*snap = 0;
 	}
@@ -3913,10 +3914,10 @@ void synchronize_rcu(void)
 			 "Illegal synchronize_rcu() in RCU read-side critical section");
 	if (rcu_blocking_is_gp()) {
 		// Note well that this code runs with !PREEMPT && !SMP.
-		// In addition, all code that advances grace periods runs
-		// at process level.  Therefore, this GP overlaps with other
-		// GPs only by being fully nested within them, which allows
-		// reuse of ->gp_seq_polled_snap.
+		// In addition, all code that advances grace periods runs at
+		// process level.  Therefore, this normal GP overlaps with
+		// other normal GPs only by being fully nested within them,
+		// which allows reuse of ->gp_seq_polled_snap.
 		rcu_poll_gp_seq_start_unlocked(&rcu_state.gp_seq_polled_snap);
 		rcu_poll_gp_seq_end_unlocked(&rcu_state.gp_seq_polled_snap);
 		if (rcu_init_invoked())
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 9c853033f159d..5634e76106c48 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -325,6 +325,7 @@ struct rcu_state {
 	unsigned long gp_wake_seq;		/* ->gp_seq at ^^^. */
 	unsigned long gp_seq_polled;		/* GP seq for polled API. */
 	unsigned long gp_seq_polled_snap;	/* ->gp_seq_polled at normal GP start. */
+	unsigned long gp_seq_polled_exp_snap;	/* ->gp_seq_polled at expedited GP start. */
 
 	/* End of fields guarded by root rcu_node's lock. */
 
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 0f70f62039a90..e0258066b881e 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -18,6 +18,7 @@ static int rcu_print_task_exp_stall(struct rcu_node *rnp);
 static void rcu_exp_gp_seq_start(void)
 {
 	rcu_seq_start(&rcu_state.expedited_sequence);
+	rcu_poll_gp_seq_start_unlocked(&rcu_state.gp_seq_polled_exp_snap);
 }
 
 /*
@@ -34,6 +35,7 @@ static __maybe_unused unsigned long rcu_exp_gp_seq_endval(void)
  */
 static void rcu_exp_gp_seq_end(void)
 {
+	rcu_poll_gp_seq_end_unlocked(&rcu_state.gp_seq_polled_exp_snap);
 	rcu_seq_end(&rcu_state.expedited_sequence);
 	smp_mb(); /* Ensure that consecutive grace periods serialize. */
 }
@@ -913,8 +915,18 @@ void synchronize_rcu_expedited(void)
 			 "Illegal synchronize_rcu_expedited() in RCU read-side critical section");
 
 	/* Is the state is such that the call is a grace period? */
-	if (rcu_blocking_is_gp())
-		return;
+	if (rcu_blocking_is_gp()) {
+		// Note well that this code runs with !PREEMPT && !SMP.
+		// In addition, all code that advances grace periods runs
+		// at process level.  Therefore, this expedited GP overlaps
+		// with other expedited GPs only by being fully nested within
+		// them, which allows reuse of ->gp_seq_polled_exp_snap.
+		rcu_poll_gp_seq_start_unlocked(&rcu_state.gp_seq_polled_exp_snap);
+		rcu_poll_gp_seq_end_unlocked(&rcu_state.gp_seq_polled_exp_snap);
+		if (rcu_init_invoked())
+			cond_resched();
+		return;  // Context allows vacuous grace periods.
+	}
 
 	/* If expedited grace periods are prohibited, fall back to normal. */
 	if (rcu_gp_is_normal()) {
-- 
2.31.1.189.g2e36527f23

