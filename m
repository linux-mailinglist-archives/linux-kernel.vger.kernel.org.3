Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8D8D4D52C0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 21:01:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343814AbiCJUC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 15:02:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232725AbiCJUC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 15:02:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88AA718E3F6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 12:01:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27AA4615AA
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 20:01:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88587C340E8;
        Thu, 10 Mar 2022 20:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646942483;
        bh=O7dvnH0WYQ1/bdj7SNoPhu43O6prZYw/ysOCZ2haMsY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=KFYeGU3tql47uegBVKxw2cwXnYSfppuQU/CC309iTQWtzCdlWKB8S8lPcI2BEIbtb
         nrVzNaDcteI8Q/0pQsJX8s/5E0i5GHNX9FdfsG5BHycknupwhLCk+5MC45ytgmcvBR
         T5O33P+DLrne/SpaF3F8SHZZVsMBd1CwnuJ0PYFppLOMTjxfCW++/rMIVI+SuA5nns
         tWzOtMasNCAgkb5h6nsSnPcpFr6CWK/GqesVkYLitkAMmxXle0gyZffm9BGFS/sGEk
         xj7G6AtdXSqg74yn0CIX9WJud0++/A4ywFB7TtWbYXMxfibeETsz4rATWUX3ImJMYz
         I+wqG7FPiX21w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 39A965C038D; Thu, 10 Mar 2022 12:01:23 -0800 (PST)
Date:   Thu, 10 Mar 2022 12:01:23 -0800
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
Subject: Re: [PATCH 11/19] rcu/context_tracking: Move dynticks_nesting to
 context tracking
Message-ID: <20220310200123.GX4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220302154810.42308-1-frederic@kernel.org>
 <20220302154810.42308-12-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220302154810.42308-12-frederic@kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2022 at 04:48:02PM +0100, Frederic Weisbecker wrote:
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
>  include/linux/context_tracking_state.h |  1 +
>  kernel/context_tracking.c              |  1 +
>  kernel/rcu/tree.c                      | 31 +++++++++++++-------------
>  kernel/rcu/tree.h                      |  1 -
>  kernel/rcu/tree_stall.h                |  3 ++-
>  5 files changed, 20 insertions(+), 17 deletions(-)
> 
> diff --git a/include/linux/context_tracking_state.h b/include/linux/context_tracking_state.h
> index 5ad0e481c5a3..bcb942945265 100644
> --- a/include/linux/context_tracking_state.h
> +++ b/include/linux/context_tracking_state.h
> @@ -24,6 +24,7 @@ struct context_tracking {
>  	} state;
>  #endif
>  	atomic_t dynticks;		/* Even value for idle, else odd. */
> +	long dynticks_nesting;		/* Track process nesting level. */
>  };
>  
>  #ifdef CONFIG_CONTEXT_TRACKING
> diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
> index 77b61a7c9890..09a77884a4e3 100644
> --- a/kernel/context_tracking.c
> +++ b/kernel/context_tracking.c
> @@ -234,6 +234,7 @@ void __init context_tracking_init(void)
>  #endif /* #ifdef CONFIG_CONTEXT_TRACKING_USER */
>  
>  DEFINE_PER_CPU(struct context_tracking, context_tracking) = {
> +		.dynticks_nesting = 1,
>  		.dynticks = ATOMIC_INIT(1),
>  };
>  EXPORT_SYMBOL_GPL(context_tracking);
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 96eb8503f28e..8708d1a99565 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -75,7 +75,6 @@
>  /* Data structures. */
>  
>  static DEFINE_PER_CPU_SHARED_ALIGNED(struct rcu_data, rcu_data) = {
> -	.dynticks_nesting = 1,
>  	.dynticks_nmi_nesting = DYNTICK_IRQ_NONIDLE,
>  #ifdef CONFIG_RCU_NOCB_CPU
>  	.cblist.flags = SEGCBLIST_RCU_CORE,
> @@ -441,7 +440,7 @@ static int rcu_is_cpu_rrupt_from_idle(void)
>  	lockdep_assert_irqs_disabled();
>  
>  	/* Check for counter underflows */
> -	RCU_LOCKDEP_WARN(__this_cpu_read(rcu_data.dynticks_nesting) < 0,
> +	RCU_LOCKDEP_WARN(__this_cpu_read(context_tracking.dynticks_nesting) < 0,
>  			 "RCU dynticks_nesting counter underflow!");
>  	RCU_LOCKDEP_WARN(__this_cpu_read(rcu_data.dynticks_nmi_nesting) <= 0,
>  			 "RCU dynticks_nmi_nesting counter underflow/zero!");
> @@ -457,7 +456,7 @@ static int rcu_is_cpu_rrupt_from_idle(void)
>  	WARN_ON_ONCE(!nesting && !is_idle_task(current));
>  
>  	/* Does CPU appear to be idle from an RCU standpoint? */
> -	return __this_cpu_read(rcu_data.dynticks_nesting) == 0;
> +	return __this_cpu_read(context_tracking.dynticks_nesting) == 0;
>  }
>  
>  #define DEFAULT_RCU_BLIMIT (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD) ? 1000 : 10)
> @@ -624,16 +623,16 @@ static noinstr void rcu_eqs_enter(bool user)
>  	WARN_ON_ONCE(rdp->dynticks_nmi_nesting != DYNTICK_IRQ_NONIDLE);
>  	WRITE_ONCE(rdp->dynticks_nmi_nesting, 0);
>  	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) &&
> -		     rdp->dynticks_nesting == 0);
> -	if (rdp->dynticks_nesting != 1) {
> +		     ct->dynticks_nesting == 0);
> +	if (ct->dynticks_nesting != 1) {
>  		// RCU will still be watching, so just do accounting and leave.
> -		rdp->dynticks_nesting--;
> +		ct->dynticks_nesting--;
>  		return;
>  	}
>  
>  	lockdep_assert_irqs_disabled();
>  	instrumentation_begin();
> -	trace_rcu_dyntick(TPS("Start"), rdp->dynticks_nesting, 0, atomic_read(&ct->dynticks));
> +	trace_rcu_dyntick(TPS("Start"), ct->dynticks_nesting, 0, atomic_read(&ct->dynticks));
>  	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !user && !is_idle_task(current));
>  	rcu_preempt_deferred_qs(current);
>  
> @@ -641,7 +640,7 @@ static noinstr void rcu_eqs_enter(bool user)
>  	instrument_atomic_write(&ct->dynticks, sizeof(ct->dynticks));
>  
>  	instrumentation_end();
> -	WRITE_ONCE(rdp->dynticks_nesting, 0); /* Avoid irq-access tearing. */
> +	WRITE_ONCE(ct->dynticks_nesting, 0); /* Avoid irq-access tearing. */
>  	// RCU is watching here ...
>  	rcu_dynticks_eqs_enter();
>  	// ... but is no longer watching here.
> @@ -798,7 +797,7 @@ void rcu_irq_exit_check_preempt(void)
>  {
>  	lockdep_assert_irqs_disabled();
>  
> -	RCU_LOCKDEP_WARN(__this_cpu_read(rcu_data.dynticks_nesting) <= 0,
> +	RCU_LOCKDEP_WARN(__this_cpu_read(context_tracking.dynticks_nesting) <= 0,
>  			 "RCU dynticks_nesting counter underflow/zero!");
>  	RCU_LOCKDEP_WARN(__this_cpu_read(rcu_data.dynticks_nmi_nesting) !=
>  			 DYNTICK_IRQ_NONIDLE,
> @@ -824,11 +823,11 @@ static void noinstr rcu_eqs_exit(bool user)
>  
>  	lockdep_assert_irqs_disabled();
>  	rdp = this_cpu_ptr(&rcu_data);
> -	oldval = rdp->dynticks_nesting;
> +	oldval = ct->dynticks_nesting;
>  	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && oldval < 0);
>  	if (oldval) {
>  		// RCU was already watching, so just do accounting and leave.
> -		rdp->dynticks_nesting++;
> +		ct->dynticks_nesting++;
>  		return;
>  	}
>  	rcu_dynticks_task_exit();
> @@ -840,9 +839,9 @@ static void noinstr rcu_eqs_exit(bool user)
>  	// instrumentation for the noinstr rcu_dynticks_eqs_exit()
>  	instrument_atomic_write(&ct->dynticks, sizeof(ct->dynticks));
>  
> -	trace_rcu_dyntick(TPS("End"), rdp->dynticks_nesting, 1, atomic_read(&ct->dynticks));
> +	trace_rcu_dyntick(TPS("End"), ct->dynticks_nesting, 1, atomic_read(&ct->dynticks));
>  	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !user && !is_idle_task(current));
> -	WRITE_ONCE(rdp->dynticks_nesting, 1);
> +	WRITE_ONCE(ct->dynticks_nesting, 1);
>  	WARN_ON_ONCE(rdp->dynticks_nmi_nesting);
>  	WRITE_ONCE(rdp->dynticks_nmi_nesting, DYNTICK_IRQ_NONIDLE);
>  	instrumentation_end();
> @@ -4122,12 +4121,13 @@ static void rcu_init_new_rnp(struct rcu_node *rnp_leaf)
>  static void __init
>  rcu_boot_init_percpu_data(int cpu)
>  {
> +	struct context_tracking *ct = this_cpu_ptr(&context_tracking);
>  	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
>  
>  	/* Set up local state, ensuring consistent view of global state. */
>  	rdp->grpmask = leaf_node_cpu_bit(rdp->mynode, cpu);
>  	INIT_WORK(&rdp->strict_work, strict_work_handler);
> -	WARN_ON_ONCE(rdp->dynticks_nesting != 1);
> +	WARN_ON_ONCE(ct->dynticks_nesting != 1);
>  	WARN_ON_ONCE(rcu_dynticks_in_eqs(rcu_dynticks_snap(cpu)));
>  	rdp->barrier_seq_snap = rcu_state.barrier_sequence;
>  	rdp->rcu_ofl_gp_seq = rcu_state.gp_seq;
> @@ -4152,6 +4152,7 @@ rcu_boot_init_percpu_data(int cpu)
>  int rcutree_prepare_cpu(unsigned int cpu)
>  {
>  	unsigned long flags;
> +	struct context_tracking *ct = per_cpu_ptr(&context_tracking, cpu);
>  	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
>  	struct rcu_node *rnp = rcu_get_root();
>  
> @@ -4160,7 +4161,7 @@ int rcutree_prepare_cpu(unsigned int cpu)
>  	rdp->qlen_last_fqs_check = 0;
>  	rdp->n_force_qs_snap = READ_ONCE(rcu_state.n_force_qs);
>  	rdp->blimit = blimit;
> -	rdp->dynticks_nesting = 1;	/* CPU not up, no tearing. */
> +	ct->dynticks_nesting = 1;	/* CPU not up, no tearing. */
>  	raw_spin_unlock_rcu_node(rnp);		/* irqs remain disabled. */
>  
>  	/*
> diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
> index 15246a3f0734..8050bab08f39 100644
> --- a/kernel/rcu/tree.h
> +++ b/kernel/rcu/tree.h
> @@ -186,7 +186,6 @@ struct rcu_data {
>  
>  	/* 3) dynticks interface. */
>  	int dynticks_snap;		/* Per-GP tracking for dynticks. */
> -	long dynticks_nesting;		/* Track process nesting level. */
>  	long dynticks_nmi_nesting;	/* Track irq/NMI nesting level. */
>  	bool rcu_need_heavy_qs;		/* GP old, so heavy quiescent state! */
>  	bool rcu_urgent_qs;		/* GP old need light quiescent state. */
> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> index 202129b1c7e4..30a5e0a8ddb3 100644
> --- a/kernel/rcu/tree_stall.h
> +++ b/kernel/rcu/tree_stall.h
> @@ -429,6 +429,7 @@ static void print_cpu_stall_info(int cpu)
>  {
>  	unsigned long delta;
>  	bool falsepositive;
> +	struct context_tracking *ct = this_cpu_ptr(&context_tracking);
>  	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
>  	char *ticks_title;
>  	unsigned long ticks_value;
> @@ -459,7 +460,7 @@ static void print_cpu_stall_info(int cpu)
>  				"!."[!delta],
>  	       ticks_value, ticks_title,
>  	       rcu_dynticks_snap(cpu) & 0xfff,
> -	       rdp->dynticks_nesting, rdp->dynticks_nmi_nesting,
> +	       ct->dynticks_nesting, rdp->dynticks_nmi_nesting,
>  	       rdp->softirq_snap, kstat_softirqs_cpu(RCU_SOFTIRQ, cpu),
>  	       data_race(rcu_state.n_force_qs) - rcu_state.n_force_qs_gpstart,
>  	       falsepositive ? " (false positive?)" : "");
> -- 
> 2.25.1
> 
