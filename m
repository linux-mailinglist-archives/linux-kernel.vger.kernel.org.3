Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFEAE50BBAD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 17:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449439AbiDVP3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 11:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449433AbiDVP3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 11:29:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69E15C85A;
        Fri, 22 Apr 2022 08:26:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6199161F35;
        Fri, 22 Apr 2022 15:26:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4D4CC385AB;
        Fri, 22 Apr 2022 15:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650641207;
        bh=wpcimkpmyXuZWzMsgzk6WTpHEDwsi0hL31+pEsg3qqc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=C3zpGu8MjDMmcc54IAy+8QiCCGeFFQ2Xc7XDe8tj7NphlijuDwXdizBP0uTEgJfwK
         UHL3tLPnbyyaNTiMoKuOB+33EQ0P5IRNFVqztxGzHQ65Q3zi0GsiUswi0sNDmNLWaM
         wfwZy0iYxlgUXK0xjg/EwCoyFeEbItlhBqRLDgtdbb+yEnSAp6nXwBz0hVvVYzdgMb
         gi1l1+2SZCPpZNKlyO+Ybzy5M9yb0tw4iSrfabg4e8ewsGZQwrpQ25kHgJXw77S6ko
         8KfeEhKz1tCIpheg0l1AciYyE/MAsn3mXAZDQoSrYCUiuBVwDZSZVSXP+7L9dPxhpT
         w5/XJH4b1Syxg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5E9C35C0460; Fri, 22 Apr 2022 08:26:47 -0700 (PDT)
Date:   Fri, 22 Apr 2022 08:26:47 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     frederic@kernel.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, urezki@gmail.com
Subject: Re: [PATCH v2] rcu: Dump all rcuc kthreads status for CPUs that not
 report quiescent state
Message-ID: <20220422152647.GY4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220419053426.2820350-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220419053426.2820350-1-qiang1.zhang@intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 01:34:26PM +0800, Zqiang wrote:
> If the rcutree.use_softirq is configured, when RCU Stall event
> happened, dump status of all rcuc kthreads who due to starvation
> prevented grace period ends on CPUs that not report quiescent
> state.

Please accept my apologies for the delay, and please let me try
again.  ;-)

Your earlier patch added at most one line and one stack backtrace to
the RCU CPU stall warning text, which is OK.  Sort of, anyway.  I was
relying on the fact that the people who have (rightly) complained about
RCU CPU stall-warning verbosity never run with !use_softirq.  But it is
only a matter of time.  Yes, we could argue that they should use faster
console serial lines, faster management-console hardware, faster networks,
faster mass storage, and so on, but I would expect them to in turn ask
us if we were volunteering to pay for all that.

In contrast, this patch can add one line per stalled CPU on top of the
existing output.  Which is better than your earlier patch, which could
add a line plus a stack trace per stalled CPU.  But that can still be
a lot of added output, and that added output can cause problems.

So, could you please merge this rcuc-stalled information into the
existing per-CPU line printed by print_cpu_stall_info()?  Right now,
each such line looks something like this:

rcu: 0-....: (4 ticks this GP) idle=1e6/1/0x4000000000000002 softirq=12470/12470 fqs=2

One approach would be to add the number of jiffies that the rcuc
task was stalled to this line, maybe something like this:

rcu: 0-....: (4 ticks this GP) idle=1e6/1/0x4000000000000002 softirq=12470/12470 fqs=2 rcuc=15384

Of course, this "rcuc=" string should only ut only if the stall lasted
for longer than (say) one eighth of the stall timeout.

Any "(false positive?)" needs to remain at the end of the line:

rcu: 0-....: (4 ticks this GP) idle=1e6/1/0x4000000000000002 softirq=12470/12470 fqs=2 rcuc=15384 (false positive?)

Thoughts?

							Thanx, Paul

> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> ---
>  v1->v2:
>  rework rcuc_kthread_dump function
> 
>  kernel/rcu/tree_stall.h | 32 ++++++++++++++++++++++++++------
>  1 file changed, 26 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> index d7956c03edbd..fcf0b2e1a71c 100644
> --- a/kernel/rcu/tree_stall.h
> +++ b/kernel/rcu/tree_stall.h
> @@ -465,11 +465,13 @@ static void print_cpu_stall_info(int cpu)
>  	       falsepositive ? " (false positive?)" : "");
>  }
>  
> -static void rcuc_kthread_dump(struct rcu_data *rdp)
> +static void __rcuc_kthread_dump(int cpu)
>  {
> -	int cpu;
> -	unsigned long j;
> +	struct rcu_data *rdp;
>  	struct task_struct *rcuc;
> +	unsigned long j;
> +
> +	rdp = per_cpu_ptr(&rcu_data, cpu);
>  
>  	rcuc = rdp->rcu_cpu_kthread_task;
>  	if (!rcuc)
> @@ -488,6 +490,21 @@ static void rcuc_kthread_dump(struct rcu_data *rdp)
>  		dump_cpu_task(cpu);
>  }
>  
> +static void rcuc_kthread_dump(void)
> +{
> +	int cpu;
> +	struct rcu_node *rnp;
> +	unsigned long flags;
> +
> +	rcu_for_each_leaf_node(rnp) {
> +		raw_spin_lock_irqsave_rcu_node(rnp, flags);
> +		for_each_leaf_node_possible_cpu(rnp, cpu)
> +			if (rnp->qsmask & leaf_node_cpu_bit(rnp, cpu))
> +				__rcuc_kthread_dump(cpu);
> +		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
> +	}
> +}
> +
>  /* Complain about starvation of grace-period kthread.  */
>  static void rcu_check_gp_kthread_starvation(void)
>  {
> @@ -597,6 +614,9 @@ static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
>  	if (ndetected) {
>  		rcu_dump_cpu_stacks();
>  
> +		if (!use_softirq)
> +			rcuc_kthread_dump();
> +
>  		/* Complain about tasks blocking the grace period. */
>  		rcu_for_each_leaf_node(rnp)
>  			rcu_print_detail_task_stall_rnp(rnp);
> @@ -659,11 +679,11 @@ static void print_cpu_stall(unsigned long gps)
>  	rcu_check_gp_kthread_expired_fqs_timer();
>  	rcu_check_gp_kthread_starvation();
>  
> -	if (!use_softirq)
> -		rcuc_kthread_dump(rdp);
> -
>  	rcu_dump_cpu_stacks();
>  
> +	if (!use_softirq)
> +		rcuc_kthread_dump();
> +
>  	raw_spin_lock_irqsave_rcu_node(rnp, flags);
>  	/* Rewrite if needed in case of slow consoles. */
>  	if (ULONG_CMP_GE(jiffies, READ_ONCE(rcu_state.jiffies_stall)))
> -- 
> 2.25.1
> 
