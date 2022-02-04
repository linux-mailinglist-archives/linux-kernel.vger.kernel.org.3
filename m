Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67A644AA3FF
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 00:08:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377923AbiBDXIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 18:08:18 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:53364 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377899AbiBDXIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 18:08:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 58822B83963;
        Fri,  4 Feb 2022 23:08:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB0D4C36AE2;
        Fri,  4 Feb 2022 23:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644016087;
        bh=unSHV5pCcmnfZnpIr4QRTxITUK7+vXyWYLgKVbprAK4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q2nuwxUMINEcQUq4ReBOV8RjIQ80vmJviSaSEUvbIaTGN/AXFJbW48cDHofBjQUuP
         3A862b7eab49xMCt7FxriB2e7IzDvaprXTLfeAOislr0S39ARNV4r5B4W+1GYSjwWQ
         6gm1snjr6aJY/Mv7scINfGqTD6n9diIGPxMTAzFqeY6mmsGTzZK8D93QQlZ0vb97D1
         BP53RWIvvduh6OFE6+8VNyGf2YM3mSozr1emNK2ucxy7VRObULIuU0TjKdAepxmZAN
         509KmyELWzfvDVSg0h0zsVdm83PUCmtwLktTOTXizM90UkWDhSWewxd11YekSUjw4i
         BDSKvoAxgtabA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 9AC7B5C08B7; Fri,  4 Feb 2022 15:08:06 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, David Woodhouse <dwmw@amazon.co.uk>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 3/9] rcu: Add mutex for rcu boost kthread spawning and affinity setting
Date:   Fri,  4 Feb 2022 15:07:59 -0800
Message-Id: <20220204230805.4193767-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220204230751.GA4193671@paulmck-ThinkPad-P17-Gen-1>
References: <20220204230751.GA4193671@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Woodhouse <dwmw@amazon.co.uk>

As we handle parallel CPU bringup, we will need to take care to avoid
spawning multiple boost threads, or race conditions when setting their
affinity. Spotted by Paul McKenney.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c        |  1 +
 kernel/rcu/tree.h        |  3 +++
 kernel/rcu/tree_plugin.h | 10 ++++++++--
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index a4c25a6283b0b..d1d1a8c51223b 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4570,6 +4570,7 @@ static void __init rcu_init_one(void)
 			init_waitqueue_head(&rnp->exp_wq[2]);
 			init_waitqueue_head(&rnp->exp_wq[3]);
 			spin_lock_init(&rnp->exp_lock);
+			mutex_init(&rnp->boost_kthread_mutex);
 		}
 	}
 
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 486fc901bd085..3b8b60de07c38 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -110,6 +110,9 @@ struct rcu_node {
 				/*  side effect, not as a lock. */
 	unsigned long boost_time;
 				/* When to start boosting (jiffies). */
+	struct mutex boost_kthread_mutex;
+				/* Exclusion for thread spawning and affinity */
+				/*  manipulation. */
 	struct task_struct *boost_kthread_task;
 				/* kthread that takes care of priority */
 				/*  boosting for this rcu_node structure. */
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index c5b45c2f68a15..07845dcd33c5e 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1172,15 +1172,16 @@ static void rcu_spawn_one_boost_kthread(struct rcu_node *rnp)
 	struct sched_param sp;
 	struct task_struct *t;
 
+	mutex_lock(&rnp->boost_kthread_mutex);
 	if (rnp->boost_kthread_task || !rcu_scheduler_fully_active)
-		return;
+		goto out;
 
 	rcu_state.boost = 1;
 
 	t = kthread_create(rcu_boost_kthread, (void *)rnp,
 			   "rcub/%d", rnp_index);
 	if (WARN_ON_ONCE(IS_ERR(t)))
-		return;
+		goto out;
 
 	raw_spin_lock_irqsave_rcu_node(rnp, flags);
 	rnp->boost_kthread_task = t;
@@ -1188,6 +1189,9 @@ static void rcu_spawn_one_boost_kthread(struct rcu_node *rnp)
 	sp.sched_priority = kthread_prio;
 	sched_setscheduler_nocheck(t, SCHED_FIFO, &sp);
 	wake_up_process(t); /* get to TASK_INTERRUPTIBLE quickly. */
+
+ out:
+	mutex_unlock(&rnp->boost_kthread_mutex);
 }
 
 /*
@@ -1210,6 +1214,7 @@ static void rcu_boost_kthread_setaffinity(struct rcu_node *rnp, int outgoingcpu)
 		return;
 	if (!zalloc_cpumask_var(&cm, GFP_KERNEL))
 		return;
+	mutex_lock(&rnp->boost_kthread_mutex);
 	for_each_leaf_node_possible_cpu(rnp, cpu)
 		if ((mask & leaf_node_cpu_bit(rnp, cpu)) &&
 		    cpu != outgoingcpu)
@@ -1218,6 +1223,7 @@ static void rcu_boost_kthread_setaffinity(struct rcu_node *rnp, int outgoingcpu)
 	if (cpumask_weight(cm) == 0)
 		cpumask_copy(cm, housekeeping_cpumask(HK_FLAG_RCU));
 	set_cpus_allowed_ptr(t, cm);
+	mutex_unlock(&rnp->boost_kthread_mutex);
 	free_cpumask_var(cm);
 }
 
-- 
2.31.1.189.g2e36527f23

