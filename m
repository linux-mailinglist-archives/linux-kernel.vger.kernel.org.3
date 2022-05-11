Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A194D523F49
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 23:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348020AbiEKVLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 17:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348047AbiEKVLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 17:11:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E29B5FF3A;
        Wed, 11 May 2022 14:11:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C100161BA0;
        Wed, 11 May 2022 21:11:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17E4AC340EE;
        Wed, 11 May 2022 21:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652303460;
        bh=O3d94XNcE8vut9SCbZRM8trovJFtWJ9oUgdeGDAn0gE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=s2LEzneqAT8nGJymba4QUHnkUfSxEprnr1aYS/9hYKfoq8YIC26gJzw5VeU8n5wGw
         VbCvX/qKtD02Ifzl4LVMcxWmO1gq4JoGx7omk+sYJ1TpY3uRvD6i23WKkVl+SvsgzD
         eSIF38Hn6v+GXf1wXqNquUzai/kcb7pDeKcb4hdU1Mwm1OPqsIjjwElnSO3LhheBX6
         Nbx433opzqOxl3FaEemHCBpMJFA+5MTfuNffeymLk+luzlUBC27YV7s9Qb6WDMjgoR
         cWC44UAHxmQuVM6hgVHBulaeM7LasZBlX9qQEUl9jsZ4y968ACw8ho8bOEAzq0NSDP
         Ae9Mo3yccdFuQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A216E5C05FC; Wed, 11 May 2022 14:10:59 -0700 (PDT)
Date:   Wed, 11 May 2022 14:10:59 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraj.iitr10@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v2 1/1] rcu/nocb: Add an option to ON/OFF an offloading
 from RT context
Message-ID: <20220511211059.GF1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220511085703.101596-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220511085703.101596-1-urezki@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 10:57:03AM +0200, Uladzislau Rezki (Sony) wrote:
> Introduce a RCU_NOCB_CPU_CB_BOOST kernel option. So a user can
> decide if an offloading has to be done in a high-prio context or
> not. Please note an option depends on RCU_NOCB_CPU and RCU_BOOST
> parameters. For CONFIG_PREEMPT_RT kernel both RCU_BOOST and the
> RCU_NOCB_CPU_CB_BOOST are active by default.
> 
> This patch splits the CONFIG_RCU_BOOST config into two peaces:
> a) boosting preempted RCU readers and the kthreads which are
>    directly responsible for driving expedited grace periods
>    forward;
> b) boosting offloading-kthreads in a way that their scheduling
>    class are changed from SCHED_NORMAL to SCHED_FIFO.
> 
> The main reason of such split is, for example on Android there
> are some workloads which require fast expedited grace period to
> be done whereas offloading in RT context can lead to starvation
> and hogging a CPU for a long time what is not acceptable for
> latency sensitive environment. For instance:
> 
> <snip>
> <...>-60 [006] d..1 2979.028717: rcu_batch_start: rcu_preempt CBs=34619 bl=270
> <snip>
> 
> invoking 34 619 callbacks will take time thus making other CFS
> tasks waiting in run-queue to be starved due to such behaviour.
> 
> v1 -> v2:
> - fix the comment about the rcuc/rcub/rcuop;
> - check the kthread_prio against zero value;
> - by default the RCU_NOCB_CPU_CB_BOOST is ON for PREEMPT_RT.
> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

Very good, thank you!  I have queued this for further review and testing,
with the usual wordsmithing (please check!).

By default, this would go not into the upcoming merge window, but to
the one after that.  Please let me know if you need it in the upcoming
merge window.

							Thanx, Paul

------------------------------------------------------------------------

commit f50467bdfec9c27ae574b8c7916b51abe3c46eae
Author: Uladzislau Rezki (Sony) <urezki@gmail.com>
Date:   Wed May 11 10:57:03 2022 +0200

    rcu/nocb: Add option to opt rcuo kthreads out of RT priority
    
    This commit introduces a RCU_NOCB_CPU_CB_BOOST Kconfig option that
    prevents rcuo kthreads from running at real-time priority, even in
    kernels built with RCU_BOOST.  This capability is important to devices
    needing low-latency (as in a few milliseconds) response from expedited
    RCU grace periods, but which are not running a classic real-time workload.
    On such devices, permitting the rcuo kthreads to run at real-time priority
    results in unacceptable latencies imposed on the application tasks,
    which run as SCHED_OTHER.
    
    See for example the following trace output:
    
    <snip>
    <...>-60 [006] d..1 2979.028717: rcu_batch_start: rcu_preempt CBs=34619 bl=270
    <snip>
    
    If that rcuop kthread were permitted to run at real-time SCHED_FIFO
    priority, it would monopolize its CPU for hundreds of milliseconds
    while invoking those 34619 RCU callback functions, which would cause an
    unacceptably long latency spike for many application stacks on Android
    platforms.
    
    However, some existing real-time workloads require that callback
    invocation run at SCHED_FIFO priority, for example, those running on
    systems with heavy SCHED_OTHER background loads.  (It is the real-time
    system's administrator's responsibility to make sure that important
    real-time tasks run at a higher priority than do RCU's kthreads.)
    
    Therefore, this new RCU_NOCB_CPU_CB_BOOST Kconfig option defaults to
    "y" on kernels built with PREEMPT_RT and defaults to "n" otherwise.
    The effect is to preserve current behavior for real-time systems, but for
    other systems to allow expedited RCU grace periods to run with real-time
    priority while continuing to invoke RCU callbacks as SCHED_OTHER.
    
    As you would expect, this RCU_NOCB_CPU_CB_BOOST Kconfig option has no
    effect except on CPUs with offloaded RCU callbacks.
    
    Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index 27aab870ae4cf..c05ca52cdf64d 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -275,6 +275,22 @@ config RCU_NOCB_CPU_DEFAULT_ALL
 	  Say Y here if you want offload all CPUs by default on boot.
 	  Say N here if you are unsure.
 
+config RCU_NOCB_CPU_CB_BOOST
+	bool "Offload RCU callback from real-time kthread"
+	depends on RCU_NOCB_CPU && RCU_BOOST
+	default y if PREEMPT_RT
+	help
+	  Use this option to invoke offloaded callbacks as SCHED_FIFO
+	  to avoid starvation by heavy SCHED_OTHER background load.
+	  Of course, running as SCHED_FIFO during callback floods will
+	  cause the rcuo[ps] kthreads to monopolize the CPU for hundreds
+	  of milliseconds or more.  Therefore, when enabling this option,
+	  it is your responsibility to ensure that latency-sensitive
+	  tasks either run with higher priority or run on some other CPU.
+
+	  Say Y here if you want to set RT priority for offloading kthreads.
+	  Say N here if you are building a !PREEMPT_RT kernel and are unsure.
+
 config TASKS_TRACE_RCU_READ_MB
 	bool "Tasks Trace RCU readers use memory barriers in user and idle"
 	depends on RCU_EXPERT && TASKS_TRACE_RCU
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index bcc5876c9753b..222d59299a2af 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -154,7 +154,11 @@ static void sync_sched_exp_online_cleanup(int cpu);
 static void check_cb_ovld_locked(struct rcu_data *rdp, struct rcu_node *rnp);
 static bool rcu_rdp_is_offloaded(struct rcu_data *rdp);
 
-/* rcuc/rcub/rcuop kthread realtime priority */
+/*
+ * rcuc/rcub/rcuop kthread realtime priority. The "rcuop"
+ * real-time priority(enabling/disabling) is controlled by
+ * the extra CONFIG_RCU_NOCB_CPU_CB_BOOST configuration.
+ */
 static int kthread_prio = IS_ENABLED(CONFIG_RCU_BOOST) ? 1 : 0;
 module_param(kthread_prio, int, 0444);
 
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 60cc92cc66552..fa8e4f82e60c0 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1315,8 +1315,9 @@ static void rcu_spawn_cpu_nocb_kthread(int cpu)
 	if (WARN_ONCE(IS_ERR(t), "%s: Could not start rcuo CB kthread, OOM is now expected behavior\n", __func__))
 		goto end;
 
-	if (kthread_prio)
+	if (IS_ENABLED(CONFIG_RCU_NOCB_CPU_CB_BOOST) && kthread_prio)
 		sched_setscheduler_nocheck(t, SCHED_FIFO, &sp);
+
 	WRITE_ONCE(rdp->nocb_cb_kthread, t);
 	WRITE_ONCE(rdp->nocb_gp_kthread, rdp_gp->nocb_gp_kthread);
 	return;
