Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 082274D52C5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 21:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343843AbiCJUDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 15:03:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343828AbiCJUDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 15:03:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E20882183E
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 12:02:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 23F66B8276F
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 20:02:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B31B2C340E8;
        Thu, 10 Mar 2022 20:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646942545;
        bh=waXo1/YUfzzdeCHKYdjqhMUdUTZvcTJRkcqaTxnz6Kk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=SZG0/22BvJGotMnPdIozo5PNbsSZLyZ8CtaxNfXa1RHe+gtYAUCkD+OD9jspJ080r
         H+Sf9gI50Ax6Usr5u4GBzV1ANrfU9m3egzSqZndOwUlST4Mx7lS8gyJxhoQzLnYr1t
         rj99UyvPjuugsBnkeI60OFt/uHVav3Az2/9jlEgr8bc8y5jEu5B5pO17RtzDPnciQL
         7cWA4rX5Y+pIUU9FDFiUDSExK7QHu5eNnGsZJUi7azSttrIDdfWq4j8tX59zWrbdDt
         1nXWReDp0AQWf4byn7QgNfi9qwP5Z/u2ZJM2sIaaOzsl6t93kwWaDQ6lI2jhAG+ItD
         SmeIyO5Jz/4bQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 68A765C038D; Thu, 10 Mar 2022 12:02:25 -0800 (PST)
Date:   Thu, 10 Mar 2022 12:02:25 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Phil Auld <pauld@redhat.com>,
        Alex Belits <abelits@marvell.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yu Liao <liaoyu15@huawei.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Uladzislau Rezki <uladzislau.rezki@sony.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 12/19] rcu/context_tracking: Move dynticks_nmi_nesting to
 context tracking
Message-ID: <20220310200225.GY4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220302154810.42308-1-frederic@kernel.org>
 <20220302154810.42308-13-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220302154810.42308-13-frederic@kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2022 at 04:48:03PM +0100, Frederic Weisbecker wrote:
> The RCU eqs tracking is going to be performed by the context tracking
> subsystem. The related nesting counters thus need to be moved to the
> context tracking structure.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Acked-by: Paul E. McKenney <paulmck@kernel.org>

> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
> Cc: Uladzislau Rezki <uladzislau.rezki@sony.com>
> Cc: Joel Fernandes <joel@joelfernandes.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Nicolas Saenz Julienne <nsaenz@kernel.org>
> Cc: Marcelo Tosatti <mtosatti@redhat.com>
> Cc: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> Cc: Yu Liao<liaoyu15@huawei.com>
> Cc: Phil Auld <pauld@redhat.com>
> Cc: Paul Gortmaker<paul.gortmaker@windriver.com>
> Cc: Alex Belits <abelits@marvell.com>
> ---
>  include/linux/context_tracking_state.h |  4 +++
>  kernel/context_tracking.c              |  1 +
>  kernel/rcu/rcu.h                       |  4 ---
>  kernel/rcu/tree.c                      | 48 +++++++++++---------------
>  kernel/rcu/tree.h                      |  1 -
>  kernel/rcu/tree_stall.h                |  2 +-
>  6 files changed, 27 insertions(+), 33 deletions(-)
> 
> diff --git a/include/linux/context_tracking_state.h b/include/linux/context_tracking_state.h
> index bcb942945265..4efb97fe6518 100644
> --- a/include/linux/context_tracking_state.h
> +++ b/include/linux/context_tracking_state.h
> @@ -6,6 +6,9 @@
>  #include <linux/static_key.h>
>  #include <linux/context_tracking_irq.h>
>  
> +/* Offset to allow distinguishing irq vs. task-based idle entry/exit. */
> +#define DYNTICK_IRQ_NONIDLE	((LONG_MAX / 2) + 1)
> +
>  struct context_tracking {
>  #ifdef CONFIG_CONTEXT_TRACKING_USER
>  	/*
> @@ -25,6 +28,7 @@ struct context_tracking {
>  #endif
>  	atomic_t dynticks;		/* Even value for idle, else odd. */
>  	long dynticks_nesting;		/* Track process nesting level. */
> +	long dynticks_nmi_nesting;	/* Track irq/NMI nesting level. */
>  };
>  
>  #ifdef CONFIG_CONTEXT_TRACKING
> diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
> index 09a77884a4e3..155534c409fc 100644
> --- a/kernel/context_tracking.c
> +++ b/kernel/context_tracking.c
> @@ -234,6 +234,7 @@ void __init context_tracking_init(void)
>  #endif /* #ifdef CONFIG_CONTEXT_TRACKING_USER */
>  
>  DEFINE_PER_CPU(struct context_tracking, context_tracking) = {
> +		.dynticks_nmi_nesting = DYNTICK_IRQ_NONIDLE,
>  		.dynticks_nesting = 1,
>  		.dynticks = ATOMIC_INIT(1),
>  };
> diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> index eccbdbdaa02e..d3cd9e7d11fa 100644
> --- a/kernel/rcu/rcu.h
> +++ b/kernel/rcu/rcu.h
> @@ -12,10 +12,6 @@
>  
>  #include <trace/events/rcu.h>
>  
> -/* Offset to allow distinguishing irq vs. task-based idle entry/exit. */
> -#define DYNTICK_IRQ_NONIDLE	((LONG_MAX / 2) + 1)
> -
> -
>  /*
>   * Grace-period counter management.
>   */
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 8708d1a99565..c2528e65de0c 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -75,7 +75,6 @@
>  /* Data structures. */
>  
>  static DEFINE_PER_CPU_SHARED_ALIGNED(struct rcu_data, rcu_data) = {
> -	.dynticks_nmi_nesting = DYNTICK_IRQ_NONIDLE,
>  #ifdef CONFIG_RCU_NOCB_CPU
>  	.cblist.flags = SEGCBLIST_RCU_CORE,
>  #endif
> @@ -442,11 +441,11 @@ static int rcu_is_cpu_rrupt_from_idle(void)
>  	/* Check for counter underflows */
>  	RCU_LOCKDEP_WARN(__this_cpu_read(context_tracking.dynticks_nesting) < 0,
>  			 "RCU dynticks_nesting counter underflow!");
> -	RCU_LOCKDEP_WARN(__this_cpu_read(rcu_data.dynticks_nmi_nesting) <= 0,
> +	RCU_LOCKDEP_WARN(__this_cpu_read(context_tracking.dynticks_nmi_nesting) <= 0,
>  			 "RCU dynticks_nmi_nesting counter underflow/zero!");
>  
>  	/* Are we at first interrupt nesting level? */
> -	nesting = __this_cpu_read(rcu_data.dynticks_nmi_nesting);
> +	nesting = __this_cpu_read(context_tracking.dynticks_nmi_nesting);
>  	if (nesting > 1)
>  		return false;
>  
> @@ -617,11 +616,10 @@ EXPORT_SYMBOL_GPL(rcutorture_get_gp_data);
>   */
>  static noinstr void rcu_eqs_enter(bool user)
>  {
> -	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
>  	struct context_tracking *ct = this_cpu_ptr(&context_tracking);
>  
> -	WARN_ON_ONCE(rdp->dynticks_nmi_nesting != DYNTICK_IRQ_NONIDLE);
> -	WRITE_ONCE(rdp->dynticks_nmi_nesting, 0);
> +	WARN_ON_ONCE(ct->dynticks_nmi_nesting != DYNTICK_IRQ_NONIDLE);
> +	WRITE_ONCE(ct->dynticks_nmi_nesting, 0);
>  	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) &&
>  		     ct->dynticks_nesting == 0);
>  	if (ct->dynticks_nesting != 1) {
> @@ -739,7 +737,7 @@ noinstr void rcu_user_enter(void)
>   * rcu_nmi_exit - inform RCU of exit from NMI context
>   *
>   * If we are returning from the outermost NMI handler that interrupted an
> - * RCU-idle period, update ct->dynticks and rdp->dynticks_nmi_nesting
> + * RCU-idle period, update ct->dynticks and ct->dynticks_nmi_nesting
>   * to let the RCU grace-period handling know that the CPU is back to
>   * being RCU-idle.
>   *
> @@ -749,7 +747,6 @@ noinstr void rcu_user_enter(void)
>  noinstr void rcu_nmi_exit(void)
>  {
>  	struct context_tracking *ct = this_cpu_ptr(&context_tracking);
> -	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
>  
>  	instrumentation_begin();
>  	/*
> @@ -757,25 +754,25 @@ noinstr void rcu_nmi_exit(void)
>  	 * (We are exiting an NMI handler, so RCU better be paying attention
>  	 * to us!)
>  	 */
> -	WARN_ON_ONCE(rdp->dynticks_nmi_nesting <= 0);
> +	WARN_ON_ONCE(ct->dynticks_nmi_nesting <= 0);
>  	WARN_ON_ONCE(rcu_dynticks_curr_cpu_in_eqs());
>  
>  	/*
>  	 * If the nesting level is not 1, the CPU wasn't RCU-idle, so
>  	 * leave it in non-RCU-idle state.
>  	 */
> -	if (rdp->dynticks_nmi_nesting != 1) {
> -		trace_rcu_dyntick(TPS("--="), rdp->dynticks_nmi_nesting, rdp->dynticks_nmi_nesting - 2,
> +	if (ct->dynticks_nmi_nesting != 1) {
> +		trace_rcu_dyntick(TPS("--="), ct->dynticks_nmi_nesting, ct->dynticks_nmi_nesting - 2,
>  				  atomic_read(&ct->dynticks));
> -		WRITE_ONCE(rdp->dynticks_nmi_nesting, /* No store tearing. */
> -			   rdp->dynticks_nmi_nesting - 2);
> +		WRITE_ONCE(ct->dynticks_nmi_nesting, /* No store tearing. */
> +			   ct->dynticks_nmi_nesting - 2);
>  		instrumentation_end();
>  		return;
>  	}
>  
>  	/* This NMI interrupted an RCU-idle CPU, restore RCU-idleness. */
> -	trace_rcu_dyntick(TPS("Startirq"), rdp->dynticks_nmi_nesting, 0, atomic_read(&ct->dynticks));
> -	WRITE_ONCE(rdp->dynticks_nmi_nesting, 0); /* Avoid store tearing. */
> +	trace_rcu_dyntick(TPS("Startirq"), ct->dynticks_nmi_nesting, 0, atomic_read(&ct->dynticks));
> +	WRITE_ONCE(ct->dynticks_nmi_nesting, 0); /* Avoid store tearing. */
>  
>  	// instrumentation for the noinstr rcu_dynticks_eqs_enter()
>  	instrument_atomic_write(&ct->dynticks, sizeof(ct->dynticks));
> @@ -799,7 +796,7 @@ void rcu_irq_exit_check_preempt(void)
>  
>  	RCU_LOCKDEP_WARN(__this_cpu_read(context_tracking.dynticks_nesting) <= 0,
>  			 "RCU dynticks_nesting counter underflow/zero!");
> -	RCU_LOCKDEP_WARN(__this_cpu_read(rcu_data.dynticks_nmi_nesting) !=
> +	RCU_LOCKDEP_WARN(__this_cpu_read(context_tracking.dynticks_nmi_nesting) !=
>  			 DYNTICK_IRQ_NONIDLE,
>  			 "Bad RCU  dynticks_nmi_nesting counter\n");
>  	RCU_LOCKDEP_WARN(rcu_dynticks_curr_cpu_in_eqs(),
> @@ -818,11 +815,9 @@ void rcu_irq_exit_check_preempt(void)
>  static void noinstr rcu_eqs_exit(bool user)
>  {
>  	struct context_tracking *ct = this_cpu_ptr(&context_tracking);
> -	struct rcu_data *rdp;
>  	long oldval;
>  
>  	lockdep_assert_irqs_disabled();
> -	rdp = this_cpu_ptr(&rcu_data);
>  	oldval = ct->dynticks_nesting;
>  	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && oldval < 0);
>  	if (oldval) {
> @@ -842,8 +837,8 @@ static void noinstr rcu_eqs_exit(bool user)
>  	trace_rcu_dyntick(TPS("End"), ct->dynticks_nesting, 1, atomic_read(&ct->dynticks));
>  	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !user && !is_idle_task(current));
>  	WRITE_ONCE(ct->dynticks_nesting, 1);
> -	WARN_ON_ONCE(rdp->dynticks_nmi_nesting);
> -	WRITE_ONCE(rdp->dynticks_nmi_nesting, DYNTICK_IRQ_NONIDLE);
> +	WARN_ON_ONCE(ct->dynticks_nmi_nesting);
> +	WRITE_ONCE(ct->dynticks_nmi_nesting, DYNTICK_IRQ_NONIDLE);
>  	instrumentation_end();
>  }
>  
> @@ -946,7 +941,7 @@ void __rcu_irq_enter_check_tick(void)
>   * rcu_nmi_enter - inform RCU of entry to NMI context
>   *
>   * If the CPU was idle from RCU's viewpoint, update ct->dynticks and
> - * rdp->dynticks_nmi_nesting to let the RCU grace-period handling know
> + * ct->dynticks_nmi_nesting to let the RCU grace-period handling know
>   * that the CPU is active.  This implementation permits nested NMIs, as
>   * long as the nesting level does not overflow an int.  (You will probably
>   * run out of stack space first.)
> @@ -957,11 +952,10 @@ void __rcu_irq_enter_check_tick(void)
>  noinstr void rcu_nmi_enter(void)
>  {
>  	long incby = 2;
> -	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
>  	struct context_tracking *ct = this_cpu_ptr(&context_tracking);
>  
>  	/* Complain about underflow. */
> -	WARN_ON_ONCE(rdp->dynticks_nmi_nesting < 0);
> +	WARN_ON_ONCE(ct->dynticks_nmi_nesting < 0);
>  
>  	/*
>  	 * If idle from RCU viewpoint, atomically increment ->dynticks
> @@ -995,11 +989,11 @@ noinstr void rcu_nmi_enter(void)
>  	}
>  
>  	trace_rcu_dyntick(incby == 1 ? TPS("Endirq") : TPS("++="),
> -			  rdp->dynticks_nmi_nesting,
> -			  rdp->dynticks_nmi_nesting + incby, atomic_read(&ct->dynticks));
> +			  ct->dynticks_nmi_nesting,
> +			  ct->dynticks_nmi_nesting + incby, atomic_read(&ct->dynticks));
>  	instrumentation_end();
> -	WRITE_ONCE(rdp->dynticks_nmi_nesting, /* Prevent store tearing. */
> -		   rdp->dynticks_nmi_nesting + incby);
> +	WRITE_ONCE(ct->dynticks_nmi_nesting, /* Prevent store tearing. */
> +		   ct->dynticks_nmi_nesting + incby);
>  	barrier();
>  }
>  
> diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
> index 8050bab08f39..56d38568292b 100644
> --- a/kernel/rcu/tree.h
> +++ b/kernel/rcu/tree.h
> @@ -186,7 +186,6 @@ struct rcu_data {
>  
>  	/* 3) dynticks interface. */
>  	int dynticks_snap;		/* Per-GP tracking for dynticks. */
> -	long dynticks_nmi_nesting;	/* Track irq/NMI nesting level. */
>  	bool rcu_need_heavy_qs;		/* GP old, so heavy quiescent state! */
>  	bool rcu_urgent_qs;		/* GP old need light quiescent state. */
>  	bool rcu_forced_tick;		/* Forced tick to provide QS. */
> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> index 30a5e0a8ddb3..9bf5cc79d5eb 100644
> --- a/kernel/rcu/tree_stall.h
> +++ b/kernel/rcu/tree_stall.h
> @@ -460,7 +460,7 @@ static void print_cpu_stall_info(int cpu)
>  				"!."[!delta],
>  	       ticks_value, ticks_title,
>  	       rcu_dynticks_snap(cpu) & 0xfff,
> -	       ct->dynticks_nesting, rdp->dynticks_nmi_nesting,
> +	       ct->dynticks_nesting, ct->dynticks_nmi_nesting,
>  	       rdp->softirq_snap, kstat_softirqs_cpu(RCU_SOFTIRQ, cpu),
>  	       data_race(rcu_state.n_force_qs) - rcu_state.n_force_qs_gpstart,
>  	       falsepositive ? " (false positive?)" : "");
> -- 
> 2.25.1
> 
