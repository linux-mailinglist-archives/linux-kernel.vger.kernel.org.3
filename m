Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 155804D52DE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 21:08:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243695AbiCJUJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 15:09:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234539AbiCJUJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 15:09:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8BA58E62
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 12:08:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 353D1B8276F
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 20:08:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBFF9C340E8;
        Thu, 10 Mar 2022 20:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646942918;
        bh=Dp9D+WdhyJdXua8m5SR0GRKzQc9JSGEV2PID+r2HfWc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=tyMHK4xtIYy/XCptcGPrHDenHRUbFoitgcCtftNjPTevusomP/37xpiIZ/QHPkBRb
         jbUQc/muUd1DSh2TlRJfs3L2FTNr9+7mRQomWOItsetOKg3wlLFCcRntqUTBewzMWj
         u9T382y1f3Vh/y5C4rmIAJHUI1KKVQuLlmkJ1wv0Zv8EZigXN9xqLLcw1w/PssKOF+
         lsQF4/roO5kghKtS2fn8zEPJPV4m59aj6QWTqBWynWq5/oLCrEQGV3IDRZOByusiyH
         vlAS9YcC1fozKdpn9r6lu1S6BKKl5AEhc/n6DXlxx9H+g9s8halhpEao9MRLOwypyT
         X4HQWytLeDmtg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 7AFF55C038D; Thu, 10 Mar 2022 12:08:38 -0800 (PST)
Date:   Thu, 10 Mar 2022 12:08:38 -0800
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
Subject: Re: [PATCH 17/19] rcu/context-tracking: Use accessor for dynticks
 counter value
Message-ID: <20220310200838.GB4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220302154810.42308-1-frederic@kernel.org>
 <20220302154810.42308-18-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220302154810.42308-18-frederic@kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2022 at 04:48:08PM +0100, Frederic Weisbecker wrote:
> The dynticks counter value is going to join the context tracking state
> in a single field. Use an accessor for this value to make the transition
> easier for all readers.
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
>  include/linux/context_tracking_state.h | 17 +++++++++++++++++
>  kernel/context_tracking.c              | 10 +++++-----
>  kernel/rcu/tree.c                      | 13 ++++---------
>  3 files changed, 26 insertions(+), 14 deletions(-)
> 
> diff --git a/include/linux/context_tracking_state.h b/include/linux/context_tracking_state.h
> index 3da44987dc71..bca0d3e0bd3d 100644
> --- a/include/linux/context_tracking_state.h
> +++ b/include/linux/context_tracking_state.h
> @@ -40,6 +40,23 @@ static __always_inline int __ct_state(void)
>  {
>  	return atomic_read(this_cpu_ptr(&context_tracking.state));
>  }
> +
> +static __always_inline int ct_dynticks(void)
> +{
> +	return atomic_read(this_cpu_ptr(&context_tracking.dynticks));
> +}
> +
> +static __always_inline int ct_dynticks_cpu(int cpu)
> +{
> +	struct context_tracking *ct = per_cpu_ptr(&context_tracking, cpu);
> +	return atomic_read(&ct->dynticks);
> +}
> +
> +static __always_inline int ct_dynticks_cpu_acquire(int cpu)
> +{
> +	struct context_tracking *ct = per_cpu_ptr(&context_tracking, cpu);
> +	return atomic_read_acquire(&ct->state);
> +}
>  #endif
>  
>  #ifdef CONFIG_CONTEXT_TRACKING_USER
> diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
> index 69db43548768..fe9066fdfaab 100644
> --- a/kernel/context_tracking.c
> +++ b/kernel/context_tracking.c
> @@ -133,7 +133,7 @@ static noinstr void rcu_eqs_enter(bool user)
>  
>  	lockdep_assert_irqs_disabled();
>  	instrumentation_begin();
> -	trace_rcu_dyntick(TPS("Start"), ct->dynticks_nesting, 0, atomic_read(&ct->dynticks));
> +	trace_rcu_dyntick(TPS("Start"), ct->dynticks_nesting, 0, ct_dynticks());
>  	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !user && !is_idle_task(current));
>  	rcu_preempt_deferred_qs(current);
>  
> @@ -178,7 +178,7 @@ noinstr void ct_nmi_exit(void)
>  	 */
>  	if (ct->dynticks_nmi_nesting != 1) {
>  		trace_rcu_dyntick(TPS("--="), ct->dynticks_nmi_nesting, ct->dynticks_nmi_nesting - 2,
> -				  atomic_read(&ct->dynticks));
> +				  ct_dynticks());
>  		WRITE_ONCE(ct->dynticks_nmi_nesting, /* No store tearing. */
>  			   ct->dynticks_nmi_nesting - 2);
>  		instrumentation_end();
> @@ -186,7 +186,7 @@ noinstr void ct_nmi_exit(void)
>  	}
>  
>  	/* This NMI interrupted an RCU-idle CPU, restore RCU-idleness. */
> -	trace_rcu_dyntick(TPS("Startirq"), ct->dynticks_nmi_nesting, 0, atomic_read(&ct->dynticks));
> +	trace_rcu_dyntick(TPS("Startirq"), ct->dynticks_nmi_nesting, 0, ct_dynticks());
>  	WRITE_ONCE(ct->dynticks_nmi_nesting, 0); /* Avoid store tearing. */
>  
>  	// instrumentation for the noinstr rcu_dynticks_eqs_enter()
> @@ -231,7 +231,7 @@ static void noinstr rcu_eqs_exit(bool user)
>  	// instrumentation for the noinstr rcu_dynticks_eqs_exit()
>  	instrument_atomic_write(&ct->dynticks, sizeof(ct->dynticks));
>  
> -	trace_rcu_dyntick(TPS("End"), ct->dynticks_nesting, 1, atomic_read(&ct->dynticks));
> +	trace_rcu_dyntick(TPS("End"), ct->dynticks_nesting, 1, ct_dynticks());
>  	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !user && !is_idle_task(current));
>  	WRITE_ONCE(ct->dynticks_nesting, 1);
>  	WARN_ON_ONCE(ct->dynticks_nmi_nesting);
> @@ -292,7 +292,7 @@ noinstr void ct_nmi_enter(void)
>  
>  	trace_rcu_dyntick(incby == 1 ? TPS("Endirq") : TPS("++="),
>  			  ct->dynticks_nmi_nesting,
> -			  ct->dynticks_nmi_nesting + incby, atomic_read(&ct->dynticks));
> +			  ct->dynticks_nmi_nesting + incby, ct_dynticks());
>  	instrumentation_end();
>  	WRITE_ONCE(ct->dynticks_nmi_nesting, /* Prevent store tearing. */
>  		   ct->dynticks_nmi_nesting + incby);
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index e55a44ed19b6..90a22dd2189d 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -272,9 +272,7 @@ void rcu_softirq_qs(void)
>   */
>  static void rcu_dynticks_eqs_online(void)
>  {
> -	struct context_tracking *ct = this_cpu_ptr(&context_tracking);
> -
> -	if (atomic_read(&ct->dynticks) & 0x1)
> +	if (ct_dynticks() & 0x1)
>  		return;
>  	rcu_dynticks_inc(1);
>  }
> @@ -285,10 +283,8 @@ static void rcu_dynticks_eqs_online(void)
>   */
>  static int rcu_dynticks_snap(int cpu)
>  {
> -	struct context_tracking *ct = per_cpu_ptr(&context_tracking, cpu);
> -
>  	smp_mb();  // Fundamental RCU ordering guarantee.
> -	return atomic_read_acquire(&ct->dynticks);
> +	return ct_dynticks_cpu_acquire(cpu);
>  }
>  
>  /*
> @@ -322,11 +318,10 @@ static bool rcu_dynticks_in_eqs_since(struct rcu_data *rdp, int snap)
>   */
>  bool rcu_dynticks_zero_in_eqs(int cpu, int *vp)
>  {
> -	struct context_tracking *ct = per_cpu_ptr(&context_tracking, cpu);
>  	int snap;
>  
>  	// If not quiescent, force back to earlier extended quiescent state.
> -	snap = atomic_read(&ct->dynticks) & ~0x1;
> +	snap = ct_dynticks_cpu(cpu) & ~0x1;
>  
>  	smp_rmb(); // Order ->dynticks and *vp reads.
>  	if (READ_ONCE(*vp))
> @@ -334,7 +329,7 @@ bool rcu_dynticks_zero_in_eqs(int cpu, int *vp)
>  	smp_rmb(); // Order *vp read and ->dynticks re-read.
>  
>  	// If still in the same extended quiescent state, we are good!
> -	return snap == atomic_read(&ct->dynticks);
> +	return snap == ct_dynticks_cpu(cpu);
>  }
>  
>  /*
> -- 
> 2.25.1
> 
