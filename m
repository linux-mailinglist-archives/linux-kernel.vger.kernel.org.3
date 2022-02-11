Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0ECF4B288F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 15:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351186AbiBKO6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 09:58:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351173AbiBKO6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 09:58:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B13A6125;
        Fri, 11 Feb 2022 06:58:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E8B861FAF;
        Fri, 11 Feb 2022 14:58:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50F8DC340E9;
        Fri, 11 Feb 2022 14:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644591480;
        bh=wvwK2W4hbMr27rsRNMCpqnOBInU3E432y3W3J06Y8/Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MzeXyrZlK+D48w6VIrjQa8E5uXoncps96Bjr3iQXKYkhbVO5MvbYX0+WJRM6tehnv
         KaOhZkfNAiUv9p1UfMo77SjZPS4ADAgeFc51eOMlhL333+YSKSVl7rYQwqO+6Xg9wh
         SdjV1c0CUHD90Wj6PTdwFQGfMnHwQH3B4p2XrqTVXYu9UuVLu9/ed4vjO7BFNgvRsE
         ytYy62dNRpE+Yd30z7u3fQ5l3Xf4vfPqECqIjTrssKBrmSEcC3uNNfKvgUZUO90XrP
         9LKtXt+Ut7Ij3mYt5Nydf7tR5mDlD2U5tsOLQTiD4wsl6Aj9dMT4a3p9pcMap0URwQ
         iK0l32V8loN8w==
Date:   Fri, 11 Feb 2022 15:57:57 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, rostedt@goodmis.org,
        David Woodhouse <dwmw@amazon.co.uk>
Subject: Re: [PATCH rcu 3/9] rcu: Add mutex for rcu boost kthread spawning
 and affinity setting
Message-ID: <20220211145757.GA587320@lothringen>
References: <20220204230751.GA4193671@paulmck-ThinkPad-P17-Gen-1>
 <20220204230805.4193767-3-paulmck@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220204230805.4193767-3-paulmck@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2022 at 03:07:59PM -0800, Paul E. McKenney wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> As we handle parallel CPU bringup, we will need to take care to avoid
> spawning multiple boost threads, or race conditions when setting their
> affinity. Spotted by Paul McKenney.
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

Speaking of, we have:

rcu_init()
   for_each_online_cpu(cpu) // should be boot CPU only at this stage ?
       rcutree_prepare_cpu(cpu)
           rcu_spawn_one_boost_kthread(cpu)


early_initcall()
    rcu_spawn_gp_kthread()
        rcu_spawn_boost_kthreads()
	    rcu_for_each_leaf_node(rnp)
	        rcu_rnp_online_cpus(rnp) // as above, only boot CPU at this stage.
                    rcu_spawn_one_boost_kthread(cpu)

cpu_up()
    rcutree_prepare_cpu(cpu)
        rcu_spawn_one_boost_kthread(cpu)


My guess is that we could remove rcu_spawn_boost_kthreads() and simplify
rcu_init(). Something like this (untested yet):

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 86eec6a0f1a1..da8ac2b6f8cc 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4526,7 +4526,6 @@ static int __init rcu_spawn_gp_kthread(void)
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 	wake_up_process(t);
 	rcu_spawn_nocb_kthreads();
-	rcu_spawn_boost_kthreads();
 	rcu_spawn_core_kthreads();
 	return 0;
 }
@@ -4813,7 +4812,7 @@ static void __init kfree_rcu_batch_init(void)
 
 void __init rcu_init(void)
 {
-	int cpu;
+	int cpu = smp_processor_id();
 
 	rcu_early_boot_tests();
 
@@ -4833,11 +4832,10 @@ void __init rcu_init(void)
 	 * or the scheduler are operational.
 	 */
 	pm_notifier(rcu_pm_notify, 0);
-	for_each_online_cpu(cpu) {
-		rcutree_prepare_cpu(cpu);
-		rcu_cpu_starting(cpu);
-		rcutree_online_cpu(cpu);
-	}
+
+	rcutree_prepare_cpu(cpu);
+	rcu_cpu_starting(cpu);
+	rcutree_online_cpu(cpu);
 
 	/* Create workqueue for Tree SRCU and for expedited GPs. */
 	rcu_gp_wq = alloc_workqueue("rcu_gp", WQ_MEM_RECLAIM, 0);
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
