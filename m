Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2358D552711
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 00:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245530AbiFTWpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 18:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244163AbiFTWpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 18:45:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B41E19F8E;
        Mon, 20 Jun 2022 15:45:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DBCCA61381;
        Mon, 20 Jun 2022 22:45:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 446A9C3411C;
        Mon, 20 Jun 2022 22:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655765105;
        bh=XDrxmKz0bTXwZ0WpBKmpBvBfH5ezkcFLIoxVI2Soqag=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LlL/btuFxDjEpX19ZQKfgM+uDaD57gGiZjBz3/2+SX/A7DnJpvlChtmTzrn5EbZet
         x2wuu+/8TYh38L63GcbRWVsqcF4aMz9mAsI9SZ12Q5XKBDlV9fbVFM7rqgWNDnXhB5
         9ue9ih1dMMPpT4SFcM3jLdLUla1MAJDQsi1lF0rSGhreX0FGUQXMIzK0B2TOHE0Xd1
         FroOnoKj9S01sWioYXusBx6eYfeYZRD7HpDz/WwVsERPYOcRlsCXbs0UDJn3n9qlgX
         1Y9uvKdrzWMKIr1uOugigSgKKibs8o9+Ru1qVnh+wtjSMqdsTJXpNX8o8c3Y7Ym8C6
         pKXlrGLx0+atg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id EF8955C0ADC; Mon, 20 Jun 2022 15:45:04 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, Zqiang <qiang1.zhang@intel.com>,
        kernel test robot <lkp@intel.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 5/7] rcu: Add nocb_cb_kthread check to rcu_is_callbacks_kthread()
Date:   Mon, 20 Jun 2022 15:45:01 -0700
Message-Id: <20220620224503.3841196-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220620224455.GA3840881@paulmck-ThinkPad-P17-Gen-1>
References: <20220620224455.GA3840881@paulmck-ThinkPad-P17-Gen-1>
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

From: Zqiang <qiang1.zhang@intel.com>

Callbacks are invoked in RCU kthreads when calbacks are offloaded
(rcu_nocbs boot parameter) or when RCU's softirq handler has been
offloaded to rcuc kthreads (use_softirq==0).  The current code allows
for the rcu_nocbs case but not the use_softirq case.  This commit adds
support for the use_softirq case.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Zqiang <qiang1.zhang@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c        |  4 ++--
 kernel/rcu/tree.h        |  2 +-
 kernel/rcu/tree_plugin.h | 33 +++++++++++++++++++--------------
 3 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index c25ba442044a6..74455671e6cf2 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2530,7 +2530,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
 		trace_rcu_batch_end(rcu_state.name, 0,
 				    !rcu_segcblist_empty(&rdp->cblist),
 				    need_resched(), is_idle_task(current),
-				    rcu_is_callbacks_kthread());
+				    rcu_is_callbacks_kthread(rdp));
 		return;
 	}
 
@@ -2608,7 +2608,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
 	rcu_nocb_lock_irqsave(rdp, flags);
 	rdp->n_cbs_invoked += count;
 	trace_rcu_batch_end(rcu_state.name, count, !!rcl.head, need_resched(),
-			    is_idle_task(current), rcu_is_callbacks_kthread());
+			    is_idle_task(current), rcu_is_callbacks_kthread(rdp));
 
 	/* Update counts and requeue any remaining callbacks. */
 	rcu_segcblist_insert_done_cbs(&rdp->cblist, &rcl);
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 4f8532c33558f..649ad4f0129b1 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -426,7 +426,7 @@ static void rcu_flavor_sched_clock_irq(int user);
 static void dump_blkd_tasks(struct rcu_node *rnp, int ncheck);
 static void rcu_initiate_boost(struct rcu_node *rnp, unsigned long flags);
 static void rcu_preempt_boost_start_gp(struct rcu_node *rnp);
-static bool rcu_is_callbacks_kthread(void);
+static bool rcu_is_callbacks_kthread(struct rcu_data *rdp);
 static void rcu_cpu_kthread_setup(unsigned int cpu);
 static void rcu_spawn_one_boost_kthread(struct rcu_node *rnp);
 static bool rcu_preempt_has_tasks(struct rcu_node *rnp);
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index c8ba0fe17267c..0483e1338c413 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1012,6 +1012,25 @@ static void rcu_cpu_kthread_setup(unsigned int cpu)
 	WRITE_ONCE(rdp->rcuc_activity, jiffies);
 }
 
+static bool rcu_is_callbacks_nocb_kthread(struct rcu_data *rdp)
+{
+#ifdef CONFIG_RCU_NOCB_CPU
+	return rdp->nocb_cb_kthread == current;
+#else
+	return false;
+#endif
+}
+
+/*
+ * Is the current CPU running the RCU-callbacks kthread?
+ * Caller must have preemption disabled.
+ */
+static bool rcu_is_callbacks_kthread(struct rcu_data *rdp)
+{
+	return rdp->rcu_cpu_kthread_task == current ||
+			rcu_is_callbacks_nocb_kthread(rdp);
+}
+
 #ifdef CONFIG_RCU_BOOST
 
 /*
@@ -1151,15 +1170,6 @@ static void rcu_initiate_boost(struct rcu_node *rnp, unsigned long flags)
 	}
 }
 
-/*
- * Is the current CPU running the RCU-callbacks kthread?
- * Caller must have preemption disabled.
- */
-static bool rcu_is_callbacks_kthread(void)
-{
-	return __this_cpu_read(rcu_data.rcu_cpu_kthread_task) == current;
-}
-
 #define RCU_BOOST_DELAY_JIFFIES DIV_ROUND_UP(CONFIG_RCU_BOOST_DELAY * HZ, 1000)
 
 /*
@@ -1242,11 +1252,6 @@ static void rcu_initiate_boost(struct rcu_node *rnp, unsigned long flags)
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 }
 
-static bool rcu_is_callbacks_kthread(void)
-{
-	return false;
-}
-
 static void rcu_preempt_boost_start_gp(struct rcu_node *rnp)
 {
 }
-- 
2.31.1.189.g2e36527f23

