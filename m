Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1FB7498518
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 17:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243858AbiAXQo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 11:44:56 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:47776 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241172AbiAXQoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 11:44:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 31434B81141
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 16:44:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E37CBC340E5;
        Mon, 24 Jan 2022 16:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643042692;
        bh=Ee6qoxB0DbMTAt7oLlowYrIoCrngD8KdkpANz17AfDM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Tbjcy31caaZD/olEX3iJzWRl98P512ZdhlDN3Uv8sHzLYSk7/O5D+AQugYy8ARgVw
         Sh5T4RXOWXCA4ag7D5CuEJgVi4MGwXTOKZWeHJxEFNIpdDSxN9cEcyJoJsL25EQq0d
         9FKTrn97LajGfz9MG6ra2tbG4vA0vVIzAUK3SAqU6jZ2dZxx1a2s6jk13+46tviF0T
         Lrig1Nnt/msb71+xive66bziDlJsOaOdFUhE8gS64vSO7Fx6HqdXAauJWvgN74Mpac
         Vd6xadRQ48fvkTNqJHf8k4cquCo/FLapLO7qKTrQZmkXwPL1GGhxQ7EqfKiRrnUG75
         iVtOpdqsi+8OQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id ADB0B5C1286; Mon, 24 Jan 2022 08:44:52 -0800 (PST)
Date:   Mon, 24 Jan 2022 08:44:52 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     Tejun Heo <tj@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, jiangshanlai@gmail.com
Subject: Re: synchronize_rcu_expedited gets stuck in hotplug path
Message-ID: <20220124164452.GG4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <7359f994-8aaf-3cea-f5cf-c0d3929689d6@quicinc.com>
 <20220118200646.GJ947480@paulmck-ThinkPad-P17-Gen-1>
 <Yece9mH3nzwGxar6@slm.duckdns.org>
 <20220118214155.GK947480@paulmck-ThinkPad-P17-Gen-1>
 <4f2ada96-234f-31d8-664a-c84f5b461385@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f2ada96-234f-31d8-664a-c84f5b461385@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 07:32:01PM +0530, Mukesh Ojha wrote:
> 
> On 1/19/2022 3:11 AM, Paul E. McKenney wrote:
> > On Tue, Jan 18, 2022 at 10:11:34AM -1000, Tejun Heo wrote:
> > > Hello,
> > > 
> > > On Tue, Jan 18, 2022 at 12:06:46PM -0800, Paul E. McKenney wrote:
> > > > Interesting.  Adding Tejun and Lai on CC for their perspective.
> > > > 
> > > > As you say, the incoming CPU invoked synchronize_rcu_expedited() which
> > > > in turn invoked queue_work().  By default, workqueues will of course
> > > > queue that work on the current CPU.  But in this case, the CPU's bit
> > > > is not yet set in the cpu_active_mask.  Thus, a workqueue scheduled on
> > > > the incoming CPU won't be invoked until CPUHP_AP_ACTIVE, which won't
> > > > be reached until after the grace period ends, which cannot happen until
> > > > the workqueue handler is invoked.
> > > > 
> > > > I could imagine doing something as shown in the (untested) patch below,
> > > > but first does this help?
> > > > 
> > > > If it does help, would this sort of check be appropriate here or
> > > > should it instead go into workqueues?
> > > Maybe it can be solved by rearranging the hotplug sequence but it's fragile
> > > to schedule per-cpu work items from hotplug paths. Maybe the whole issue can
> > > be side-stepped by making synchronize_rcu_expedited() use unbound workqueue
> > > instead? Does it require to be per-cpu?
> > Good point!
> > 
> > And now that you mention it, RCU expedited grace periods already avoid
> > using workqueues during early boot.  The (again untested) patch below
> > extends that approach to incoming CPUs.
> > 
> > Thoughts?
> 
> Hi Paul,
> 
> We are not seeing the issue after this patch.
> Can we merge this patch ?

It is currently in -rcu and should also be in -next shortly.  Left to
myself, and assuming further testing and reviews all go well, I would
submit it during the upcoming v5.18 merge window.

Does that work for you?  Or do you need it in mainline sooner?

							Thanx, Paul

> -Mukesh
> 
> > 
> > 							Thanx, Paul
> > 
> > ------------------------------------------------------------------------
> > 
> > diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> > index 60197ea24ceb9..1a45667402260 100644
> > --- a/kernel/rcu/tree_exp.h
> > +++ b/kernel/rcu/tree_exp.h
> > @@ -816,7 +816,7 @@ static int rcu_print_task_exp_stall(struct rcu_node *rnp)
> >    */
> >   void synchronize_rcu_expedited(void)
> >   {
> > -	bool boottime = (rcu_scheduler_active == RCU_SCHEDULER_INIT);
> > +	bool no_wq;
> >   	struct rcu_exp_work rew;
> >   	struct rcu_node *rnp;
> >   	unsigned long s;
> > @@ -841,9 +841,15 @@ void synchronize_rcu_expedited(void)
> >   	if (exp_funnel_lock(s))
> >   		return;  /* Someone else did our work for us. */
> > +	/* Don't use workqueue during boot or from an incoming CPU. */
> > +	preempt_disable();
> > +	no_wq = rcu_scheduler_active == RCU_SCHEDULER_INIT ||
> > +		!cpumask_test_cpu(smp_processor_id(), cpu_active_mask);
> > +	preempt_enable();
> > +
> >   	/* Ensure that load happens before action based on it. */
> > -	if (unlikely(boottime)) {
> > -		/* Direct call during scheduler init and early_initcalls(). */
> > +	if (unlikely(no_wq)) {
> > +		/* Direct call for scheduler init, early_initcall()s, and incoming CPUs. */
> >   		rcu_exp_sel_wait_wake(s);
> >   	} else {
> >   		/* Marshall arguments & schedule the expedited grace period. */
> > @@ -861,7 +867,7 @@ void synchronize_rcu_expedited(void)
> >   	/* Let the next expedited grace period start. */
> >   	mutex_unlock(&rcu_state.exp_mutex);
> > -	if (likely(!boottime))
> > +	if (likely(!no_wq))
> >   		destroy_work_on_stack(&rew.rew_work);
> >   }
> >   EXPORT_SYMBOL_GPL(synchronize_rcu_expedited);
