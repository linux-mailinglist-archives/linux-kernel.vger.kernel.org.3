Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5D534D717D
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 00:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232949AbiCLXYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 18:24:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbiCLXYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 18:24:43 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C8877004D
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 15:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cPW9deNLTzJWDGiUMvxcRKPakWis975fOAZjzHmtJjs=; b=sHfzDbA6HYM1b0aKSrN9SL9J7x
        cdE0uPCWLjbTJFkblGUiL1z8H4Pj8KMem/FbEEQfU9wBbSBoqToZpqdNDQHB5nD8cgSb9x5Qgy+OB
        QjjH5XB9L1Ia1gk31c0hTjx5FVlpQiElSBtDEFvFh4V4a7JKGQ5YCK4mx1tJ/QOZoSiDA/264sUKh
        aYLrlWo0Vn7/cqoDvInfdQO2IO7IEqjF9+x8SySXXlI7seTUoArSQbPzWoPG6D17Udajsn6rQZgKL
        hwRaUZtM6JLn68YOQgdrI7L59pZrFFmo5bPUnPl4fc1YeAMHk0YsPX9GnuKiiok02q0EnzZCn4rVv
        DBguaadg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nTB4n-002m28-6U; Sat, 12 Mar 2022 23:23:09 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 53A30987D0D; Sun, 13 Mar 2022 00:23:07 +0100 (CET)
Date:   Sun, 13 Mar 2022 00:23:07 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Phil Auld <pauld@redhat.com>,
        Alex Belits <abelits@marvell.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yu Liao <liaoyu15@huawei.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Uladzislau Rezki <uladzislau.rezki@sony.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 11/19] rcu/context_tracking: Move dynticks_nesting to
 context tracking
Message-ID: <20220312232307.GJ28057@worktop.programming.kicks-ass.net>
References: <20220302154810.42308-1-frederic@kernel.org>
 <20220302154810.42308-12-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220302154810.42308-12-frederic@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2022 at 04:48:02PM +0100, Frederic Weisbecker wrote:

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

> @@ -798,7 +797,7 @@ void rcu_irq_exit_check_preempt(void)
>  {
>  	lockdep_assert_irqs_disabled();
>  
> -	RCU_LOCKDEP_WARN(__this_cpu_read(rcu_data.dynticks_nesting) <= 0,
> +	RCU_LOCKDEP_WARN(__this_cpu_read(context_tracking.dynticks_nesting) <= 0,
>  			 "RCU dynticks_nesting counter underflow/zero!");
>  	RCU_LOCKDEP_WARN(__this_cpu_read(rcu_data.dynticks_nmi_nesting) !=
>  			 DYNTICK_IRQ_NONIDLE,

Would it make sense to create __ct_wrappers() to access the
dynticks_{nmi_,}_nesting counters ?


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

And perhaps helpers here too? RCU grubbing in the context_tracking
internals seems a bit yuck.
