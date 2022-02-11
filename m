Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5894E4B28D0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 16:12:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351263AbiBKPLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 10:11:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244193AbiBKPLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 10:11:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3178B304;
        Fri, 11 Feb 2022 07:11:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C14FE61FCB;
        Fri, 11 Feb 2022 15:11:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6886C340E9;
        Fri, 11 Feb 2022 15:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644592311;
        bh=EIsRBbaq7POOiCy2QZRNM9Xjh6MFslRMKvDdZi7xkpw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HFKjXOlqG6qsKWvzNMuaOJfaoeO1TKvOzAHnSjo2QQk3kGyDvUE4lE9O8uQo0uLfg
         xclXo3YtBlsJFSwNgBFpqBoxuFMJfgORnyoc1v1P4kZrOYAMF/LI4yw7YFoHGEahGv
         A3sS8o+K39cEZToO5YPRllIGnSJrtQCCsSTD2z8pVw9g6/9GnIEKQQuOM1l99TS2FR
         vpoIceQLUzDJWaRIVD3o82B4qTjtBfoq0kuNEJIYNmBxrmG0B9FxeWBGzPtDvnVc50
         MCv4HtiWF3gU7gscOddWi0VV8MhOH1jij3HR7BXEQT7YRDoezVT7z+W8dhYmCQlETX
         8EoR0IZqQ/tnQ==
Date:   Fri, 11 Feb 2022 16:11:48 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, rostedt@goodmis.org,
        David Woodhouse <dwmw@amazon.co.uk>
Subject: Re: [PATCH rcu 3/9] rcu: Add mutex for rcu boost kthread spawning
 and affinity setting
Message-ID: <20220211151148.GA588079@lothringen>
References: <20220204230751.GA4193671@paulmck-ThinkPad-P17-Gen-1>
 <20220204230805.4193767-3-paulmck@kernel.org>
 <20220211145757.GA587320@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220211145757.GA587320@lothringen>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 11, 2022 at 03:57:57PM +0100, Frederic Weisbecker wrote:
> On Fri, Feb 04, 2022 at 03:07:59PM -0800, Paul E. McKenney wrote:
> > From: David Woodhouse <dwmw@amazon.co.uk>
> > 
> > As we handle parallel CPU bringup, we will need to take care to avoid
> > spawning multiple boost threads, or race conditions when setting their
> > affinity. Spotted by Paul McKenney.
> > 
> > Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
> 
> Speaking of, we have:
> 
> rcu_init()
>    for_each_online_cpu(cpu) // should be boot CPU only at this stage ?
>        rcutree_prepare_cpu(cpu)
>            rcu_spawn_one_boost_kthread(cpu)
> 
> 
> early_initcall()
>     rcu_spawn_gp_kthread()
>         rcu_spawn_boost_kthreads()
> 	    rcu_for_each_leaf_node(rnp)
> 	        rcu_rnp_online_cpus(rnp) // as above, only boot CPU at this stage.
>                     rcu_spawn_one_boost_kthread(cpu)
> 
> cpu_up()
>     rcutree_prepare_cpu(cpu)
>         rcu_spawn_one_boost_kthread(cpu)
> 
> 
> My guess is that we could remove rcu_spawn_boost_kthreads() and simplify
> rcu_init(). Something like this (untested yet):
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 86eec6a0f1a1..da8ac2b6f8cc 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -4526,7 +4526,6 @@ static int __init rcu_spawn_gp_kthread(void)
>  	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
>  	wake_up_process(t);
>  	rcu_spawn_nocb_kthreads();
> -	rcu_spawn_boost_kthreads();
>  	rcu_spawn_core_kthreads();
>  	return 0;
>  }
> @@ -4813,7 +4812,7 @@ static void __init kfree_rcu_batch_init(void)
>  
>  void __init rcu_init(void)
>  {
> -	int cpu;
> +	int cpu = smp_processor_id();
>  
>  	rcu_early_boot_tests();
>  
> @@ -4833,11 +4832,10 @@ void __init rcu_init(void)
>  	 * or the scheduler are operational.
>  	 */
>  	pm_notifier(rcu_pm_notify, 0);
> -	for_each_online_cpu(cpu) {
> -		rcutree_prepare_cpu(cpu);
> -		rcu_cpu_starting(cpu);
> -		rcutree_online_cpu(cpu);
> -	}
> +
> +	rcutree_prepare_cpu(cpu);
> +	rcu_cpu_starting(cpu);
> +	rcutree_online_cpu(cpu);
>  
>  	/* Create workqueue for Tree SRCU and for expedited GPs. */
>  	rcu_gp_wq = alloc_workqueue("rcu_gp", WQ_MEM_RECLAIM, 0);
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index 6082dd23408f..90925a589774 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -1226,18 +1226,6 @@ static void rcu_boost_kthread_setaffinity(struct rcu_node *rnp, int outgoingcpu)
>  	free_cpumask_var(cm);
>  }
>  
> -/*
> - * Spawn boost kthreads -- called as soon as the scheduler is running.
> - */
> -static void __init rcu_spawn_boost_kthreads(void)
> -{
> -	struct rcu_node *rnp;
> -
> -	rcu_for_each_leaf_node(rnp)
> -		if (rcu_rnp_online_cpus(rnp))
> -			rcu_spawn_one_boost_kthread(rnp);
> -}
> -
>  #else /* #ifdef CONFIG_RCU_BOOST */
>  
>  static void rcu_initiate_boost(struct rcu_node *rnp, unsigned long flags)
> @@ -1263,10 +1251,6 @@ static void rcu_boost_kthread_setaffinity(struct rcu_node *rnp, int outgoingcpu)
>  {
>  }
>  
> -static void __init rcu_spawn_boost_kthreads(void)
> -{
> -}
> -
>  #endif /* #else #ifdef CONFIG_RCU_BOOST */
>  
>  /*

nocb kthread creation is similar but it depends on the gp kthread.
So we can't rely on rcu_init() -> rcu_prepare_cpu() and we must keep
the early_initcall() -> rcu_spawn_gp_kthread().

That would become (untested again):

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index da8ac2b6f8cc..9284625a9a50 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4525,7 +4525,7 @@ static int __init rcu_spawn_gp_kthread(void)
 	smp_store_release(&rcu_state.gp_kthread, t);  /* ^^^ */
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 	wake_up_process(t);
-	rcu_spawn_nocb_kthreads();
+	rcu_spawn_cpu_nocb_kthread(smp_processor_id());
 	rcu_spawn_core_kthreads();
 	return 0;
 }
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 636d0546a4e9..711f6eb7f7e1 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1277,22 +1277,6 @@ static void rcu_spawn_cpu_nocb_kthread(int cpu)
 	WRITE_ONCE(rdp->nocb_gp_kthread, rdp_gp->nocb_gp_kthread);
 }
 
-/*
- * Once the scheduler is running, spawn rcuo kthreads for all online
- * no-CBs CPUs.  This assumes that the early_initcall()s happen before
- * non-boot CPUs come online -- if this changes, we will need to add
- * some mutual exclusion.
- */
-static void __init rcu_spawn_nocb_kthreads(void)
-{
-	int cpu;
-
-	if (rcu_nocb_is_setup) {
-		for_each_online_cpu(cpu)
-			rcu_spawn_cpu_nocb_kthread(cpu);
-	}
-}
-
 /* How many CB CPU IDs per GP kthread?  Default of -1 for sqrt(nr_cpu_ids). */
 static int rcu_nocb_gp_stride = -1;
 module_param(rcu_nocb_gp_stride, int, 0444);
@@ -1549,10 +1533,6 @@ static void rcu_spawn_cpu_nocb_kthread(int cpu)
 {
 }
 
-static void __init rcu_spawn_nocb_kthreads(void)
-{
-}
-
 static void show_rcu_nocb_state(struct rcu_data *rdp)
 {
 }
