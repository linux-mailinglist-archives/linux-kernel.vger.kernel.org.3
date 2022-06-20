Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E091552729
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 00:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344606AbiFTWvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 18:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344189AbiFTWvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 18:51:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8DC1ADAC;
        Mon, 20 Jun 2022 15:51:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 23BCC6139D;
        Mon, 20 Jun 2022 22:51:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4535BC341CF;
        Mon, 20 Jun 2022 22:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655765490;
        bh=sHD8Jv1wPIjthYlFnVLCEKXYLSonurfknaURlKWDm4w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aGUVkqBEoN1R94ZbPWVkS3OPYo1v8GBDPGoiW6cZwr4fGC6zovJqRC2x0dS/jQk7Y
         QdXN0npCLs/0PjEpBAywv+tRCpDuXyVt8U55VuZogdBzQIyvwzuMNMtF456r5iyO78
         g5NqKCq59qWnlAPLrO6lJNm1WXehxBIxTHFaolK5lyeTPQlyq1fzerjBut0eH7ValX
         QIeEu6S8/QisGS3aEzqfZP1IXZ7Mff8W8VCpCORTjivFkn5N5LqANUB9+B0tkc2YS/
         E/LimHXoANuG3ZLW2t/jtskxkZVhLnzAX2Yvt3jxzeNa7bY9+DMfkUo4RTc/EdRZTE
         /xsIXx+TyrAfg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A12AF5C0CCE; Mon, 20 Jun 2022 15:51:29 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Brian Foster <bfoster@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>
Subject: [PATCH rcu 08/12] rcu: Add polled expedited grace-period primitives
Date:   Mon, 20 Jun 2022 15:51:24 -0700
Message-Id: <20220620225128.3842050-8-paulmck@kernel.org>
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

This commit adds expedited grace-period functionality to RCU's polled
grace-period API, adding start_poll_synchronize_rcu_expedited() and
cond_synchronize_rcu_expedited(), which are similar to the existing
start_poll_synchronize_rcu() and cond_synchronize_rcu() functions,
respectively.

Note that although start_poll_synchronize_rcu_expedited() can be invoked
very early, the resulting expedited grace periods are not guaranteed
to start until after workqueues are fully initialized.  On the other
hand, both synchronize_rcu() and synchronize_rcu_expedited() can also
be invoked very early, and the resulting grace periods will be taken
into account as they occur.

[ paulmck: Apply feedback from Neeraj Upadhyay. ]

Link: https://lore.kernel.org/all/20220121142454.1994916-1-bfoster@redhat.com/
Link: https://docs.google.com/document/d/1RNKWW9jQyfjxw2E8dsXVTdvZYh0HnYeSHDKog9jhdN8/edit?usp=sharing
Cc: Brian Foster <bfoster@redhat.com>
Cc: Dave Chinner <david@fromorbit.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Ian Kent <raven@themaw.net>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcutiny.h | 10 +++++
 include/linux/rcutree.h |  2 +
 kernel/rcu/tree.c       | 17 ++++++---
 kernel/rcu/tree.h       |  7 ++++
 kernel/rcu/tree_exp.h   | 85 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 116 insertions(+), 5 deletions(-)

diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
index 5fed476f977f6..ab7e20dfb07b0 100644
--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -23,6 +23,16 @@ static inline void cond_synchronize_rcu(unsigned long oldstate)
 	might_sleep();
 }
 
+static inline unsigned long start_poll_synchronize_rcu_expedited(void)
+{
+	return start_poll_synchronize_rcu();
+}
+
+static inline void cond_synchronize_rcu_expedited(unsigned long oldstate)
+{
+	cond_synchronize_rcu(oldstate);
+}
+
 extern void rcu_barrier(void);
 
 static inline void synchronize_rcu_expedited(void)
diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index 9c6cfb742504f..20dbaa9a38820 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -40,6 +40,8 @@ bool rcu_eqs_special_set(int cpu);
 void rcu_momentary_dyntick_idle(void);
 void kfree_rcu_scheduler_running(void);
 bool rcu_gp_might_be_stalled(void);
+unsigned long start_poll_synchronize_rcu_expedited(void);
+void cond_synchronize_rcu_expedited(unsigned long oldstate);
 unsigned long get_state_synchronize_rcu(void);
 unsigned long start_poll_synchronize_rcu(void);
 bool poll_state_synchronize_rcu(unsigned long oldstate);
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 251eb9a8cd925..8b6e5414fbaa7 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4021,20 +4021,20 @@ EXPORT_SYMBOL_GPL(poll_state_synchronize_rcu);
 /**
  * cond_synchronize_rcu - Conditionally wait for an RCU grace period
  *
- * @oldstate: value from get_state_synchronize_rcu() or start_poll_synchronize_rcu()
+ * @oldstate: value from get_state_synchronize_rcu(), start_poll_synchronize_rcu(), or start_poll_synchronize_rcu_expedited()
  *
  * If a full RCU grace period has elapsed since the earlier call to
  * get_state_synchronize_rcu() or start_poll_synchronize_rcu(), just return.
  * Otherwise, invoke synchronize_rcu() to wait for a full grace period.
  *
- * Yes, this function does not take counter wrap into account.  But
- * counter wrap is harmless.  If the counter wraps, we have waited for
+ * Yes, this function does not take counter wrap into account.
+ * But counter wrap is harmless.  If the counter wraps, we have waited for
  * more than 2 billion grace periods (and way more on a 64-bit system!),
- * so waiting for one additional grace period should be just fine.
+ * so waiting for a couple of additional grace periods should be just fine.
  *
  * This function provides the same memory-ordering guarantees that
  * would be provided by a synchronize_rcu() that was invoked at the call
- * to the function that provided @oldstate, and that returned at the end
+ * to the function that provided @oldstate and that returned at the end
  * of this function.
  */
 void cond_synchronize_rcu(unsigned long oldstate)
@@ -4787,6 +4787,9 @@ static void __init rcu_init_one(void)
 			init_waitqueue_head(&rnp->exp_wq[3]);
 			spin_lock_init(&rnp->exp_lock);
 			mutex_init(&rnp->boost_kthread_mutex);
+			raw_spin_lock_init(&rnp->exp_poll_lock);
+			rnp->exp_seq_poll_rq = RCU_GET_STATE_COMPLETED;
+			INIT_WORK(&rnp->exp_poll_wq, sync_rcu_do_polled_gp);
 		}
 	}
 
@@ -5012,6 +5015,10 @@ void __init rcu_init(void)
 		qovld_calc = DEFAULT_RCU_QOVLD_MULT * qhimark;
 	else
 		qovld_calc = qovld;
+
+	// Kick-start any polled grace periods that started early.
+	if (!(per_cpu_ptr(&rcu_data, cpu)->mynode->exp_seq_poll_rq & 0x1))
+		(void)start_poll_synchronize_rcu_expedited();
 }
 
 #include "tree_stall.h"
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 5634e76106c48..fb77deca5f5c6 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -133,6 +133,10 @@ struct rcu_node {
 	wait_queue_head_t exp_wq[4];
 	struct rcu_exp_work rew;
 	bool exp_need_flush;	/* Need to flush workitem? */
+	raw_spinlock_t exp_poll_lock;
+				/* Lock and data for polled expedited grace periods. */
+	unsigned long exp_seq_poll_rq;
+	struct work_struct exp_poll_wq;
 } ____cacheline_internodealigned_in_smp;
 
 /*
@@ -484,3 +488,6 @@ static void rcu_iw_handler(struct irq_work *iwp);
 static void check_cpu_stall(struct rcu_data *rdp);
 static void rcu_check_gp_start_stall(struct rcu_node *rnp, struct rcu_data *rdp,
 				     const unsigned long gpssdelay);
+
+/* Forward declarations for tree_exp.h. */
+static void sync_rcu_do_polled_gp(struct work_struct *wp);
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index e0258066b881e..571b0a700cced 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -962,3 +962,88 @@ void synchronize_rcu_expedited(void)
 		synchronize_rcu_expedited_destroy_work(&rew);
 }
 EXPORT_SYMBOL_GPL(synchronize_rcu_expedited);
+
+/*
+ * Ensure that start_poll_synchronize_rcu_expedited() has the expedited
+ * RCU grace periods that it needs.
+ */
+static void sync_rcu_do_polled_gp(struct work_struct *wp)
+{
+	unsigned long flags;
+	struct rcu_node *rnp = container_of(wp, struct rcu_node, exp_poll_wq);
+	unsigned long s;
+
+	raw_spin_lock_irqsave(&rnp->exp_poll_lock, flags);
+	s = rnp->exp_seq_poll_rq;
+	rnp->exp_seq_poll_rq = RCU_GET_STATE_COMPLETED;
+	raw_spin_unlock_irqrestore(&rnp->exp_poll_lock, flags);
+	if (s == RCU_GET_STATE_COMPLETED)
+		return;
+	while (!poll_state_synchronize_rcu(s))
+		synchronize_rcu_expedited();
+	raw_spin_lock_irqsave(&rnp->exp_poll_lock, flags);
+	s = rnp->exp_seq_poll_rq;
+	if (poll_state_synchronize_rcu(s))
+		rnp->exp_seq_poll_rq = RCU_GET_STATE_COMPLETED;
+	raw_spin_unlock_irqrestore(&rnp->exp_poll_lock, flags);
+}
+
+/**
+ * start_poll_synchronize_rcu_expedited - Snapshot current RCU state and start expedited grace period
+ *
+ * Returns a cookie to pass to a call to cond_synchronize_rcu(),
+ * cond_synchronize_rcu_expedited(), or poll_state_synchronize_rcu(),
+ * allowing them to determine whether or not any sort of grace period has
+ * elapsed in the meantime.  If the needed expedited grace period is not
+ * already slated to start, initiates that grace period.
+ */
+unsigned long start_poll_synchronize_rcu_expedited(void)
+{
+	unsigned long flags;
+	struct rcu_data *rdp;
+	struct rcu_node *rnp;
+	unsigned long s;
+
+	s = get_state_synchronize_rcu();
+	rdp = per_cpu_ptr(&rcu_data, raw_smp_processor_id());
+	rnp = rdp->mynode;
+	if (rcu_init_invoked())
+		raw_spin_lock_irqsave(&rnp->exp_poll_lock, flags);
+	if (!poll_state_synchronize_rcu(s)) {
+		rnp->exp_seq_poll_rq = s;
+		if (rcu_init_invoked())
+			queue_work(rcu_gp_wq, &rnp->exp_poll_wq);
+	}
+	if (rcu_init_invoked())
+		raw_spin_unlock_irqrestore(&rnp->exp_poll_lock, flags);
+
+	return s;
+}
+EXPORT_SYMBOL_GPL(start_poll_synchronize_rcu_expedited);
+
+/**
+ * cond_synchronize_rcu_expedited - Conditionally wait for an expedited RCU grace period
+ *
+ * @oldstate: value from get_state_synchronize_rcu(), start_poll_synchronize_rcu(), or start_poll_synchronize_rcu_expedited()
+ *
+ * If any type of full RCU grace period has elapsed since the earlier
+ * call to get_state_synchronize_rcu(), start_poll_synchronize_rcu(),
+ * or start_poll_synchronize_rcu_expedited(), just return.  Otherwise,
+ * invoke synchronize_rcu_expedited() to wait for a full grace period.
+ *
+ * Yes, this function does not take counter wrap into account.
+ * But counter wrap is harmless.  If the counter wraps, we have waited for
+ * more than 2 billion grace periods (and way more on a 64-bit system!),
+ * so waiting for a couple of additional grace periods should be just fine.
+ *
+ * This function provides the same memory-ordering guarantees that
+ * would be provided by a synchronize_rcu() that was invoked at the call
+ * to the function that provided @oldstate and that returned at the end
+ * of this function.
+ */
+void cond_synchronize_rcu_expedited(unsigned long oldstate)
+{
+	if (!poll_state_synchronize_rcu(oldstate))
+		synchronize_rcu_expedited();
+}
+EXPORT_SYMBOL_GPL(cond_synchronize_rcu_expedited);
-- 
2.31.1.189.g2e36527f23

