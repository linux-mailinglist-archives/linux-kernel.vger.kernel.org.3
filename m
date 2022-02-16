Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC90B4B8CB6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 16:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235644AbiBPPmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 10:42:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235604AbiBPPmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 10:42:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C04A9ADBB
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 07:42:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D7B6FB81F3B
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 15:42:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17A0AC340F0;
        Wed, 16 Feb 2022 15:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645026141;
        bh=n23OTEmoQAxAvjvctHPSBMXPOlhafd62smPY4TRLCzk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XS2AHM/nQ/S/GQ6B7D/yNxfw+AXXmx6dzLeeLZ7zfihG5/qgxG+jk4KA94mJ42Bol
         tsgnZp2jBtX+UUjEM4v031u4TmktLPon0n+UYb4EmDVlyHYS+0SpIIGN9O+W2mYpzv
         W/06XN3DBmvzDIdmKq1zDy4E+TCbuknDyiPOyArE1BaA/DlmIlFc/LxIkicGXAmLLo
         lTvl555esxdum6B+9ER8fUj9qbCTQ1WThn0MxlS0Wmoj9EIcn8DrSBQl/1UDzrG4+3
         FAJ82KylflDvvXkaFZ8NSwktDHkPiKjWMXExoqalAL8pr0G6AHkRO7V6RMHpmmRTVJ
         uJWar/++z+OfQ==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Uladzislau Rezki <uladzislau.rezki@sony.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 4/5] rcu: Initialize boost kthread only for boot node prior SMP initialization
Date:   Wed, 16 Feb 2022 16:42:07 +0100
Message-Id: <20220216154208.696069-5-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220216154208.696069-1-frederic@kernel.org>
References: <20220216154208.696069-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rcu_spawn_gp_kthread() is called as an early initcall, which means that
SMP initialization hasn't happened yet and the boot CPU is the only one
online. Therefore only the boost kthread for the leaf node of the boot
CPU needs to be created at this stage.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc: Uladzislau Rezki <uladzislau.rezki@sony.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/rcu/tree.c        |  5 ++++-
 kernel/rcu/tree.h        |  1 -
 kernel/rcu/tree_plugin.h | 16 ----------------
 3 files changed, 4 insertions(+), 18 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 83dec1db86cf..4a98417c2e28 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4508,6 +4508,7 @@ static int __init rcu_spawn_gp_kthread(void)
 	struct rcu_node *rnp;
 	struct sched_param sp;
 	struct task_struct *t;
+	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 
 	rcu_scheduler_fully_active = 1;
 	t = kthread_create(rcu_gp_kthread, NULL, "%s", rcu_state.name);
@@ -4526,7 +4527,9 @@ static int __init rcu_spawn_gp_kthread(void)
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
index 735fc410d76a..48c772fc353f 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -426,7 +426,6 @@ static void rcu_preempt_boost_start_gp(struct rcu_node *rnp);
 static bool rcu_is_callbacks_kthread(void);
 static void rcu_cpu_kthread_setup(unsigned int cpu);
 static void rcu_spawn_one_boost_kthread(struct rcu_node *rnp);
-static void __init rcu_spawn_boost_kthreads(void);
 static bool rcu_preempt_has_tasks(struct rcu_node *rnp);
 static bool rcu_preempt_need_deferred_qs(struct task_struct *t);
 static void rcu_preempt_deferred_qs(struct task_struct *t);
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 6082dd23408f..90925a589774 100644
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
2.25.1

