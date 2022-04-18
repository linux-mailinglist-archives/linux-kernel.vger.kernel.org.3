Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8077506005
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 00:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234119AbiDRW7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 18:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233925AbiDRW71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 18:59:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D1A02D1E3;
        Mon, 18 Apr 2022 15:56:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AE43AB81141;
        Mon, 18 Apr 2022 22:56:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C8DEC385AB;
        Mon, 18 Apr 2022 22:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650322604;
        bh=uWd89iiBegiXH2yFXUEeLrHLbhhtzxwYgrGcGcPkkBM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hv9HajFku9vlwCBfNN9B78AoEU55p18W2PTxAzb28wvYJKYJo3ojz7eTUs3ANCUap
         PyOMul9trUbvABUDn1PHz81Yb/H+gWcxiqoFbTIccg2Ch7fEWgqssuZ7w1fKer5anB
         AOIg4DNHVU3i9YkiJT02q2Fyvy2FrTsnU7MOXjzqmghtUXcaGM8fobOYyZ8th/3obb
         AjnXOCvmIZOnymY/BFLMxYWRqhCNjQZCBTTy3V0yIZJpX5YjSTtARtirIRcOhw3MOu
         XXfCIvL1QqusEKH4hUke+ygqi/3yIRFrW7fue5udw2yNIzF6NYTUyFqnYCuzZ/8cdS
         Z4pUDxIR+XRDA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 113335C0A0D; Mon, 18 Apr 2022 15:56:44 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Uladzislau Rezki <uladzislau.rezki@sony.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 4/5] rcu: Initialize boost kthread only for boot node prior SMP initialization
Date:   Mon, 18 Apr 2022 15:56:41 -0700
Message-Id: <20220418225642.3945539-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220418225633.GA3945428@paulmck-ThinkPad-P17-Gen-1>
References: <20220418225633.GA3945428@paulmck-ThinkPad-P17-Gen-1>
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

From: Frederic Weisbecker <frederic@kernel.org>

The rcu_spawn_gp_kthread() function is called as an early initcall,
which means that SMP initialization hasn't happened yet and only the
boot CPU is online.  Therefore, create only the boost kthread for the
leaf node of the boot CPU.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc: Uladzislau Rezki <uladzislau.rezki@sony.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c        |  5 ++++-
 kernel/rcu/tree.h        |  1 -
 kernel/rcu/tree_plugin.h | 16 ----------------
 3 files changed, 4 insertions(+), 18 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index e6a9e5744e45..70b33c55d39a 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4480,6 +4480,7 @@ static int __init rcu_spawn_gp_kthread(void)
 	struct rcu_node *rnp;
 	struct sched_param sp;
 	struct task_struct *t;
+	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 
 	rcu_scheduler_fully_active = 1;
 	t = kthread_create(rcu_gp_kthread, NULL, "%s", rcu_state.name);
@@ -4498,7 +4499,9 @@ static int __init rcu_spawn_gp_kthread(void)
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 	wake_up_process(t);
 	rcu_spawn_nocb_kthreads();
-	rcu_spawn_boost_kthreads();
+	/* This is a pre-SMP initcall, we expect a single CPU */
+	WARN_ON(num_online_cpus() > 1);
+	rcu_spawn_one_boost_kthread(rdp->mynode);
 	rcu_spawn_core_kthreads();
 	return 0;
 }
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index f6a3d54585c9..b2a0f2613ab9 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -422,7 +422,6 @@ static void rcu_preempt_boost_start_gp(struct rcu_node *rnp);
 static bool rcu_is_callbacks_kthread(void);
 static void rcu_cpu_kthread_setup(unsigned int cpu);
 static void rcu_spawn_one_boost_kthread(struct rcu_node *rnp);
-static void __init rcu_spawn_boost_kthreads(void);
 static bool rcu_preempt_has_tasks(struct rcu_node *rnp);
 static bool rcu_preempt_need_deferred_qs(struct task_struct *t);
 static void rcu_preempt_deferred_qs(struct task_struct *t);
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 8360d86db1c0..b139635f33bd 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1226,18 +1226,6 @@ static void rcu_boost_kthread_setaffinity(struct rcu_node *rnp, int outgoingcpu)
 	free_cpumask_var(cm);
 }
 
-/*
- * Spawn boost kthreads -- called as soon as the scheduler is running.
- */
-static void __init rcu_spawn_boost_kthreads(void)
-{
-	struct rcu_node *rnp;
-
-	rcu_for_each_leaf_node(rnp)
-		if (rcu_rnp_online_cpus(rnp))
-			rcu_spawn_one_boost_kthread(rnp);
-}
-
 #else /* #ifdef CONFIG_RCU_BOOST */
 
 static void rcu_initiate_boost(struct rcu_node *rnp, unsigned long flags)
@@ -1263,10 +1251,6 @@ static void rcu_boost_kthread_setaffinity(struct rcu_node *rnp, int outgoingcpu)
 {
 }
 
-static void __init rcu_spawn_boost_kthreads(void)
-{
-}
-
 #endif /* #else #ifdef CONFIG_RCU_BOOST */
 
 /*
-- 
2.31.1.189.g2e36527f23

