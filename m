Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1EE4D5813
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 03:22:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345584AbiCKCWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 21:22:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233870AbiCKCWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 21:22:47 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B74F17AEE6;
        Thu, 10 Mar 2022 18:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646965305; x=1678501305;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LTujR5FyQBuFoQHf2J9i9JgvsRzy2zB/YE0ZRuPZAbw=;
  b=PALI/bOYmFU0HH3iwosM+3vbEMaQABAaHnztQH3dgxIjYvg6yzifOzv+
   b+xlZ5mKT5VZW+tpN0+040LeBil1Br2Ap2fT4lyWDwluxcbnsDLY/DGc9
   C/hW2/cRQhX5XR6Osr/fAYR6ytKCKsghOFwYe5x5yeVa80evpOY0X0KDN
   YCL1reyCIAXWa2i/jQEgVa9J5aqpS3MxHe7f12q0Lg2YfUaTpxG9D6e1J
   DxoobfyeriU/uDlGjTsdihz6NCUa0hpVpQvaLIXhQUHFI8bZ1SvMamcTP
   1in3h9WZMp9sJXa9i1fJ59wMCUo/EKRAdB7oelNyg7ElGLSTzREIAY23Y
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="253042918"
X-IronPort-AV: E=Sophos;i="5.90,172,1643702400"; 
   d="scan'208";a="253042918"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 18:21:44 -0800
X-IronPort-AV: E=Sophos;i="5.90,172,1643702400"; 
   d="scan'208";a="816332056"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.125])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 18:21:42 -0800
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, frederic@kernel.org, urezki@gmail.com,
        quic_neeraju@quicinc.com, josh@joshtriplett.org,
        bigeasy@linutronix.de
Cc:     juri.lelli@redhat.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] rcu: Only boost rcu reader tasks with lower priority than boost kthreads
Date:   Fri, 11 Mar 2022 10:22:26 +0800
Message-Id: <20220311022226.595905-1-qiang1.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When RCU_BOOST is enabled, the boost kthreads will boosting readers
who are blocking a given grace period, if the current reader tasks
have a higher priority than boost kthreads(the boost kthreads priority
not always 1, if the kthread_prio is set), boosting is useless, skip
current task and select next task to boosting, reduce the time for a
given grace period.

Suggested-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 v1->v2:
 Rename label 'end' to 'skip_boost'.
 Add 'boost_exp_tasks' pointer to point 'rnp->exp_tasks'
 do the similar thing as normal grace period.
 v2->v3:
 Remove redundant dl_task() judgment conditions.

 kernel/rcu/tree.h        |  2 ++
 kernel/rcu/tree_plugin.h | 30 ++++++++++++++++++++++--------
 2 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index b8d07bf92d29..862ca09b56c7 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -103,6 +103,8 @@ struct rcu_node {
 				/*  queued on this rcu_node structure that */
 				/*  are blocking the current grace period, */
 				/*  there can be no such task. */
+	struct list_head *boost_exp_tasks;
+
 	struct rt_mutex boost_mtx;
 				/* Used only for the priority-boosting */
 				/*  side effect, not as a lock. */
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index c3d212bc5338..fd37042ecdb2 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -535,6 +535,8 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
 			drop_boost_mutex = rt_mutex_owner(&rnp->boost_mtx.rtmutex) == t;
 			if (&t->rcu_node_entry == rnp->boost_tasks)
 				WRITE_ONCE(rnp->boost_tasks, np);
+			if (&t->rcu_node_entry == rnp->boost_exp_tasks)
+				WRITE_ONCE(rnp->boost_exp_tasks, np);
 		}
 
 		/*
@@ -1022,7 +1024,7 @@ static int rcu_boost(struct rcu_node *rnp)
 	struct task_struct *t;
 	struct list_head *tb;
 
-	if (READ_ONCE(rnp->exp_tasks) == NULL &&
+	if (READ_ONCE(rnp->boost_exp_tasks) == NULL &&
 	    READ_ONCE(rnp->boost_tasks) == NULL)
 		return 0;  /* Nothing left to boost. */
 
@@ -1032,7 +1034,7 @@ static int rcu_boost(struct rcu_node *rnp)
 	 * Recheck under the lock: all tasks in need of boosting
 	 * might exit their RCU read-side critical sections on their own.
 	 */
-	if (rnp->exp_tasks == NULL && rnp->boost_tasks == NULL) {
+	if (rnp->boost_exp_tasks == NULL && rnp->boost_tasks == NULL) {
 		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 		return 0;
 	}
@@ -1043,8 +1045,8 @@ static int rcu_boost(struct rcu_node *rnp)
 	 * expedited grace period must boost all blocked tasks, including
 	 * those blocking the pre-existing normal grace period.
 	 */
-	if (rnp->exp_tasks != NULL)
-		tb = rnp->exp_tasks;
+	if (rnp->boost_exp_tasks != NULL)
+		tb = rnp->boost_exp_tasks;
 	else
 		tb = rnp->boost_tasks;
 
@@ -1065,14 +1067,24 @@ static int rcu_boost(struct rcu_node *rnp)
 	 * section.
 	 */
 	t = container_of(tb, struct task_struct, rcu_node_entry);
+	if (t->prio <= current->prio) {
+		tb = rcu_next_node_entry(t, rnp);
+		if (rnp->boost_exp_tasks)
+			WRITE_ONCE(rnp->boost_exp_tasks, tb);
+		else
+			WRITE_ONCE(rnp->boost_tasks, tb);
+		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
+		goto skip_boost;
+	}
+
 	rt_mutex_init_proxy_locked(&rnp->boost_mtx.rtmutex, t);
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 	/* Lock only for side effect: boosts task t's priority. */
 	rt_mutex_lock(&rnp->boost_mtx);
 	rt_mutex_unlock(&rnp->boost_mtx);  /* Then keep lockdep happy. */
 	rnp->n_boosts++;
-
-	return READ_ONCE(rnp->exp_tasks) != NULL ||
+skip_boost:
+	return READ_ONCE(rnp->boost_exp_tasks) != NULL ||
 	       READ_ONCE(rnp->boost_tasks) != NULL;
 }
 
@@ -1090,7 +1102,7 @@ static int rcu_boost_kthread(void *arg)
 		WRITE_ONCE(rnp->boost_kthread_status, RCU_KTHREAD_WAITING);
 		trace_rcu_utilization(TPS("End boost kthread@rcu_wait"));
 		rcu_wait(READ_ONCE(rnp->boost_tasks) ||
-			 READ_ONCE(rnp->exp_tasks));
+			 READ_ONCE(rnp->boost_exp_tasks));
 		trace_rcu_utilization(TPS("Start boost kthread@rcu_wait"));
 		WRITE_ONCE(rnp->boost_kthread_status, RCU_KTHREAD_RUNNING);
 		more2boost = rcu_boost(rnp);
@@ -1129,13 +1141,15 @@ static void rcu_initiate_boost(struct rcu_node *rnp, unsigned long flags)
 		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 		return;
 	}
-	if (rnp->exp_tasks != NULL ||
+	if ((rnp->exp_tasks != NULL && rnp->boost_exp_tasks == NULL) ||
 	    (rnp->gp_tasks != NULL &&
 	     rnp->boost_tasks == NULL &&
 	     rnp->qsmask == 0 &&
 	     (!time_after(rnp->boost_time, jiffies) || rcu_state.cbovld))) {
 		if (rnp->exp_tasks == NULL)
 			WRITE_ONCE(rnp->boost_tasks, rnp->gp_tasks);
+		else
+			WRITE_ONCE(rnp->boost_exp_tasks, rnp->exp_tasks);
 		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 		rcu_wake_cond(rnp->boost_kthread_task,
 			      READ_ONCE(rnp->boost_kthread_status));
-- 
2.25.1

