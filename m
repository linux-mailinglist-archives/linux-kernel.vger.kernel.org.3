Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B94E0517AD2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 01:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbiEBXgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 19:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233669AbiEBXcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 19:32:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D280B31505;
        Mon,  2 May 2022 16:28:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8888D6134F;
        Mon,  2 May 2022 23:28:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3EE2C385AC;
        Mon,  2 May 2022 23:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651534125;
        bh=mIO7C9zarP3iqHAzC9Leulj2zGN5Bu1p3L46M/Sg7VA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=a9FvSxrS1R281HlpF2JvH3E92RVOWdLoZauFZx1k9uCSfy1AHoPKRQrXulxS0mGlG
         DYiBXeb+jUmIiI3Ja00aS19EhNtRuxtZ3CNbyOnN16UHYdkemQZjalYx7WbxaUbOpy
         W4Lu6JfugMojeoDdS58gBxf96+wfAM8jtjHvd892xHjm5CUv6poOPjUyFb+dAG4FQK
         uT+nnG8W7BcT6uhQfEQghypxPbTOD9wfz/sXKtJyEXErQf7tKeSkLHbPpAJTjt+hz0
         PjLa83swIZQJrTuMEkAzU8PPzzGtrNnvjXbhoFHG6XKotWto8KX8Bi//sHI7SFICWQ
         ptNYXVNtQHpWA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id F2CC05C08DB; Mon,  2 May 2022 16:28:42 -0700 (PDT)
Date:   Mon, 2 May 2022 16:28:42 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     frederic@kernel.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v3] rcu: Add nocb_cb_kthread check to
 rcu_is_callbacks_kthread()
Message-ID: <20220502232842.GE1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220429124222.1288501-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429124222.1288501-1-qiang1.zhang@intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 08:42:22PM +0800, Zqiang wrote:
> At present, there are two situations which the rcu callback function
> be exectued in the kthreads, one is if the use_softirq is set to zero,
> the RCU_SOFTIRQ processing is carried out by the per-CPU rcuc kthreads,
> for non-offload rdp, the rdp's rcu callback function be exectued in rcuc
> kthreads. another one is if the rdp is set to offloaded, the rdp's rcu
> callback function be exectued in the rcuop kthreads.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> ---
>  v1->v2:
>  fix compilation error when CONFIG_RCU_NOCB_CPU is no define
>  v2->v3:
>  define a function that tests "nocb_cb_kthread == current"
>  in CONFIG_RCU_NOCB_CPU=y kernels and just returns "false" otherwise
>  
>  let rcu_is_callbacks_kthread() not depend on CONFIG_RCU_BOOST

Queued for v5.20, thank you!

I wordsmithed the commit log as shown below, so could you please
check it?

							Thanx, Paul

------------------------------------------------------------------------

commit a72d27598150936800e6aa313c507c6903f8ed9c
Author: Zqiang <qiang1.zhang@intel.com>
Date:   Fri Apr 29 20:42:22 2022 +0800

    rcu: Add nocb_cb_kthread check to rcu_is_callbacks_kthread()
    
    Callbacks are invoked in RCU kthreads when calbacks are offloaded
    (rcu_nocbs boot parameter) or when RCU's softirq handler has been
    offloaded to rcuc kthreads (use_softirq==0).  The current code allows
    for the rcu_nocbs case but not the use_softirq case.  This commit adds
    support for the use_softirq case.
    
    Reported-by: kernel test robot <lkp@intel.com>
    Signed-off-by: Zqiang <qiang1.zhang@intel.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 5c587e00811c3..9dc4c4e82db62 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2610,7 +2610,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
 		trace_rcu_batch_end(rcu_state.name, 0,
 				    !rcu_segcblist_empty(&rdp->cblist),
 				    need_resched(), is_idle_task(current),
-				    rcu_is_callbacks_kthread());
+				    rcu_is_callbacks_kthread(rdp));
 		return;
 	}
 
@@ -2688,7 +2688,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
 	rcu_nocb_lock_irqsave(rdp, flags);
 	rdp->n_cbs_invoked += count;
 	trace_rcu_batch_end(rcu_state.name, count, !!rcl.head, need_resched(),
-			    is_idle_task(current), rcu_is_callbacks_kthread());
+			    is_idle_task(current), rcu_is_callbacks_kthread(rdp));
 
 	/* Update counts and requeue any remaining callbacks. */
 	rcu_segcblist_insert_done_cbs(&rdp->cblist, &rcl);
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 996387962de3a..3cdc18997a381 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -433,7 +433,7 @@ static void rcu_flavor_sched_clock_irq(int user);
 static void dump_blkd_tasks(struct rcu_node *rnp, int ncheck);
 static void rcu_initiate_boost(struct rcu_node *rnp, unsigned long flags);
 static void rcu_preempt_boost_start_gp(struct rcu_node *rnp);
-static bool rcu_is_callbacks_kthread(void);
+static bool rcu_is_callbacks_kthread(struct rcu_data *rdp);
 static void rcu_cpu_kthread_setup(unsigned int cpu);
 static void rcu_spawn_one_boost_kthread(struct rcu_node *rnp);
 static bool rcu_preempt_has_tasks(struct rcu_node *rnp);
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 440d9e02a26e0..99cde4c947699 100644
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
