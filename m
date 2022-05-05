Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 559AC51C8B1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 21:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233366AbiEETNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 15:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236899AbiEETND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 15:13:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF2E4A3CC;
        Thu,  5 May 2022 12:09:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B831361DA5;
        Thu,  5 May 2022 19:09:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02E04C385A4;
        Thu,  5 May 2022 19:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651777762;
        bh=Uk2itM+41NwsyGYkqfOsrHQ+MB+xj36KVOfK4Ms5dT8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=nXdjxiKaiafN/TyUnZz8u3dV9XIk5tohTB/l4VZoAY95taxze15KtFhJGG8JjDVmf
         oi3NP+9l5Yb/HrKgCGX6jMTXIsg/H5qrvvytdIMSAyXwz5GQ+9gj7O/bWfinpZMLXQ
         Hctviq2fFMHIhqbf4MdOjQ2MTKvhYac2FFsPkT/TTn4sIMMFxUbAid4bR9AzKMY9r1
         p8jwxjm1+8JgC3xqBBXg2oc20TXsA9WQAwG3CEgwljjG1A+s2wpQNWVykroOWxrON+
         xIMWlMOSIYQ0bcyy1Oi4FTIk3krpKYQWw8YLxHC675hAIjYSLFWgCJ8c3dI7LNbiYf
         g/okAPjVmAuaA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 55AC05C2CB7; Thu,  5 May 2022 12:09:15 -0700 (PDT)
Date:   Thu, 5 May 2022 12:09:15 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraj.iitr10@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        bigeasy@linutronix.de
Subject: Re: [PATCH] rcu/nocb: Add an option to ON/OFF an offloading from RT
 context
Message-ID: <20220505190915.GW1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220505101641.28472-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505101641.28472-1-urezki@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 05, 2022 at 12:16:41PM +0200, Uladzislau Rezki (Sony) wrote:
> Introduce a RCU_NOCB_CPU_CB_BOOST kernel option. So a user can
> decide if an offloading has to be done in a high-prio context or
> not. Please note an option depends on RCU_NOCB_CPU and RCU_BOOST
> parameters and by default it is off.
> 
> This patch splits the boosting preempted RCU readers and those
> kthreads which directly responsible for driving expedited grace
> periods forward with enabling/disabling the offloading from/to
> SCHED_FIFO/SCHED_OTHER contexts.
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
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

All good points!

Some questions and comments below.

Adding Sebastian on CC for his perspective.

						Thanx, Paul

> ---
>  kernel/rcu/Kconfig     | 14 ++++++++++++++
>  kernel/rcu/tree.c      |  5 ++++-
>  kernel/rcu/tree_nocb.h |  3 ++-
>  3 files changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
> index 27aab870ae4c..074630b94902 100644
> --- a/kernel/rcu/Kconfig
> +++ b/kernel/rcu/Kconfig
> @@ -275,6 +275,20 @@ config RCU_NOCB_CPU_DEFAULT_ALL
>  	  Say Y here if you want offload all CPUs by default on boot.
>  	  Say N here if you are unsure.
>  
> +config RCU_NOCB_CPU_CB_BOOST
> +	bool "Perform offloading from real-time kthread"
> +	depends on RCU_NOCB_CPU && RCU_BOOST
> +	default n

I understand that you need this to default to "n" on your systems.
However, other groups already using callback offloading should not see
a sudden change.  I don't see an Android-specific defconfig file, but
perhaps something in drivers/android/Kconfig?

One easy way to make this work would be to invert the sense of this
Kconfig option ("RCU_NOCB_CB_NO_BOOST"?), continue having it default to
"n", but then select it somewhere in drivers/android/Kconfig.  But I
would not be surprised if there is a better way.

> +	help
> +	  Use this option to offload callbacks from the SCHED_FIFO context
> +	  to make the process faster. As a side effect of this approach is
> +	  a latency especially for the SCHED_OTHER tasks which will not be
> +	  able to preempt an offloading kthread. That latency depends on a
> +	  number of callbacks to be invoked.
> +
> +	  Say Y here if you want to set RT priority for offloading kthreads.
> +	  Say N here if you are unsure.
> +
>  config TASKS_TRACE_RCU_READ_MB
>  	bool "Tasks Trace RCU readers use memory barriers in user and idle"
>  	depends on RCU_EXPERT && TASKS_TRACE_RCU
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 9dc4c4e82db6..d769a15bc0e3 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -154,7 +154,10 @@ static void sync_sched_exp_online_cleanup(int cpu);
>  static void check_cb_ovld_locked(struct rcu_data *rdp, struct rcu_node *rnp);
>  static bool rcu_rdp_is_offloaded(struct rcu_data *rdp);
>  
> -/* rcuc/rcub/rcuop kthread realtime priority */
> +/*
> + * rcuc/rcub/rcuop kthread realtime priority. The former
> + * depends on if CONFIG_RCU_NOCB_CPU_CB_BOOST is set.

Aren't the rcuo[ps] kthreads controlled by the RCU_NOCB_CPU_CB_BOOST
Kconfig option?  (As opposed to the "former", which is "rcuc".)

> + */
>  static int kthread_prio = IS_ENABLED(CONFIG_RCU_BOOST) ? 1 : 0;
>  module_param(kthread_prio, int, 0444);
>  
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index 60cc92cc6655..a2823be9b1d0 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -1315,8 +1315,9 @@ static void rcu_spawn_cpu_nocb_kthread(int cpu)
>  	if (WARN_ONCE(IS_ERR(t), "%s: Could not start rcuo CB kthread, OOM is now expected behavior\n", __func__))
>  		goto end;
>  
> -	if (kthread_prio)
> +	if (IS_ENABLED(CONFIG_RCU_NOCB_CPU_CB_BOOST))

Don't we need both non-zero kthread_prio and the proper setting of the
new Kconfig option before we run it at SCHED_FIFO?

Yes, we could rely on sched_setscheduler_nocheck() erroring out in
that case, but that sounds like an accident waiting to happen.

>  		sched_setscheduler_nocheck(t, SCHED_FIFO, &sp);
> +
>  	WRITE_ONCE(rdp->nocb_cb_kthread, t);
>  	WRITE_ONCE(rdp->nocb_gp_kthread, rdp_gp->nocb_gp_kthread);
>  	return;
> -- 
> 2.30.2
> 
