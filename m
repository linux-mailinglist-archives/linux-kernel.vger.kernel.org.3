Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04F2F49BCF0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 21:22:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbiAYUWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 15:22:03 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:54530 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbiAYUVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 15:21:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A351B61732
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 20:21:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E7BBC340E0;
        Tue, 25 Jan 2022 20:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643142099;
        bh=FywkvxG5D1EowJubkY32RQoFAminRY/vfD+fc11MnDE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=bTq/shjtK744MQLncqtW+jj5+B7pJEkYY0MJXtiUTvB//GhFxDmUCkWWKm9zkdnlJ
         YyIii5EhmSJImHTdePq7Dr1/Eea7yozC5NVFQ1FacNGsGWTh+KrzEcRkoaPfCClEdQ
         oPS5hy3+ObxokvJv3GWSBoXY0h8raeihzyyekU9jtBR1D4xIHmyyEsZnSxTlrTtOzX
         4XWuU7L/75zh+54jmYcTGsr7sklKniifwCcyyPlcnglHDnBVjnb1M5D83Tf/NXchV/
         HZsf+uQ63a0c28kdFsXT/WsdhxDqeyLK7Ajbq21ngpPhBmHS74g6e0hLcxG4v2UXdm
         bDq7XqVJedQsA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id BF6C95C0641; Tue, 25 Jan 2022 12:21:38 -0800 (PST)
Date:   Tue, 25 Jan 2022 12:21:38 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     Tejun Heo <tj@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, jiangshanlai@gmail.com
Subject: Re: synchronize_rcu_expedited gets stuck in hotplug path
Message-ID: <20220125202138.GS4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <7359f994-8aaf-3cea-f5cf-c0d3929689d6@quicinc.com>
 <20220118200646.GJ947480@paulmck-ThinkPad-P17-Gen-1>
 <Yece9mH3nzwGxar6@slm.duckdns.org>
 <20220118214155.GK947480@paulmck-ThinkPad-P17-Gen-1>
 <4f2ada96-234f-31d8-664a-c84f5b461385@quicinc.com>
 <20220124164452.GG4285@paulmck-ThinkPad-P17-Gen-1>
 <05cdeb95-1e16-c1c1-30df-135a4d4ebfcc@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05cdeb95-1e16-c1c1-30df-135a4d4ebfcc@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 10:28:28PM +0530, Mukesh Ojha wrote:
> 
> On 1/24/2022 10:14 PM, Paul E. McKenney wrote:
> > On Mon, Jan 24, 2022 at 07:32:01PM +0530, Mukesh Ojha wrote:
> > > On 1/19/2022 3:11 AM, Paul E. McKenney wrote:
> > > > On Tue, Jan 18, 2022 at 10:11:34AM -1000, Tejun Heo wrote:
> > > > > Hello,
> > > > > 
> > > > > On Tue, Jan 18, 2022 at 12:06:46PM -0800, Paul E. McKenney wrote:
> > > > > > Interesting.  Adding Tejun and Lai on CC for their perspective.
> > > > > > 
> > > > > > As you say, the incoming CPU invoked synchronize_rcu_expedited() which
> > > > > > in turn invoked queue_work().  By default, workqueues will of course
> > > > > > queue that work on the current CPU.  But in this case, the CPU's bit
> > > > > > is not yet set in the cpu_active_mask.  Thus, a workqueue scheduled on
> > > > > > the incoming CPU won't be invoked until CPUHP_AP_ACTIVE, which won't
> > > > > > be reached until after the grace period ends, which cannot happen until
> > > > > > the workqueue handler is invoked.
> > > > > > 
> > > > > > I could imagine doing something as shown in the (untested) patch below,
> > > > > > but first does this help?
> > > > > > 
> > > > > > If it does help, would this sort of check be appropriate here or
> > > > > > should it instead go into workqueues?
> > > > > Maybe it can be solved by rearranging the hotplug sequence but it's fragile
> > > > > to schedule per-cpu work items from hotplug paths. Maybe the whole issue can
> > > > > be side-stepped by making synchronize_rcu_expedited() use unbound workqueue
> > > > > instead? Does it require to be per-cpu?
> > > > Good point!
> > > > 
> > > > And now that you mention it, RCU expedited grace periods already avoid
> > > > using workqueues during early boot.  The (again untested) patch below
> > > > extends that approach to incoming CPUs.
> > > > 
> > > > Thoughts?
> > > Hi Paul,
> > > 
> > > We are not seeing the issue after this patch.
> > > Can we merge this patch ?
> > It is currently in -rcu and should also be in -next shortly.  Left to
> > myself, and assuming further testing and reviews all go well, I would
> > submit it during the upcoming v5.18 merge window.
> > 
> > Does that work for you?  Or do you need it in mainline sooner?
> 
> Before reporting this issue, we saw only one instance of it.
> Also got this fix tested with same set of test cases, did not observe any
> issue as of yet.
> 
> I would be happy to get a mail once it clear all the testing and get merges
> to -next. I would cherry-pick it in android branch-5.10.

It is in -next as of next-20220125.

							Thanx, Paul

> -Mukesh
> 
> > 
> > 							Thanx, Paul
> > 
> > > -Mukesh
> > > 
> > > > 							Thanx, Paul
> > > > 
> > > > ------------------------------------------------------------------------
> > > > 
> > > > diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> > > > index 60197ea24ceb9..1a45667402260 100644
> > > > --- a/kernel/rcu/tree_exp.h
> > > > +++ b/kernel/rcu/tree_exp.h
> > > > @@ -816,7 +816,7 @@ static int rcu_print_task_exp_stall(struct rcu_node *rnp)
> > > >     */
> > > >    void synchronize_rcu_expedited(void)
> > > >    {
> > > > -	bool boottime = (rcu_scheduler_active == RCU_SCHEDULER_INIT);
> > > > +	bool no_wq;
> > > >    	struct rcu_exp_work rew;
> > > >    	struct rcu_node *rnp;
> > > >    	unsigned long s;
> > > > @@ -841,9 +841,15 @@ void synchronize_rcu_expedited(void)
> > > >    	if (exp_funnel_lock(s))
> > > >    		return;  /* Someone else did our work for us. */
> > > > +	/* Don't use workqueue during boot or from an incoming CPU. */
> > > > +	preempt_disable();
> > > > +	no_wq = rcu_scheduler_active == RCU_SCHEDULER_INIT ||
> > > > +		!cpumask_test_cpu(smp_processor_id(), cpu_active_mask);
> > > > +	preempt_enable();
> > > > +
> > > >    	/* Ensure that load happens before action based on it. */
> > > > -	if (unlikely(boottime)) {
> > > > -		/* Direct call during scheduler init and early_initcalls(). */
> > > > +	if (unlikely(no_wq)) {
> > > > +		/* Direct call for scheduler init, early_initcall()s, and incoming CPUs. */
> > > >    		rcu_exp_sel_wait_wake(s);
> > > >    	} else {
> > > >    		/* Marshall arguments & schedule the expedited grace period. */
> > > > @@ -861,7 +867,7 @@ void synchronize_rcu_expedited(void)
> > > >    	/* Let the next expedited grace period start. */
> > > >    	mutex_unlock(&rcu_state.exp_mutex);
> > > > -	if (likely(!boottime))
> > > > +	if (likely(!no_wq))
> > > >    		destroy_work_on_stack(&rew.rew_work);
> > > >    }
> > > >    EXPORT_SYMBOL_GPL(synchronize_rcu_expedited);
