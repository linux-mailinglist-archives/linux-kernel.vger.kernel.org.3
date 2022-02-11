Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2684B3038
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 23:15:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354009AbiBKWPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 17:15:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354001AbiBKWO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 17:14:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A77C6D48;
        Fri, 11 Feb 2022 14:14:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E20260F22;
        Fri, 11 Feb 2022 22:14:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 834BEC340E9;
        Fri, 11 Feb 2022 22:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644617695;
        bh=RvxEJnSshXIkRrKM9hF+AEh8EG8yRMYl+4hxkxqTPMg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=aydfq1ivDqpb74npcqC6W1tG2tIthPTaBmkGMEjZOJ1/OahkyRnnwrixX31QhzaHW
         /W4F+p3JhHFgv7IhVfaWpbfoU31xq7xdqwavIJDqnsp3gIzW4CWuhdpb2rmcLB/aFr
         /fws1nqsnmJi6E8LAulR3S+h/zWF5QK9+jtNzSrCKjPYRZoFJlbLMR7CVOwyEOqdGo
         QkloL20f0jpCxLuEtKPZrrXKkoceeAHtYn2kq8/DGsykqzO8OEXjsXV6AixCDQDoC8
         Y/FhWuiFN1LUcDa9OnLVACAGQxtnuJ3jwp/qedpCT4rE+GreqjbyOXYkg3aixvvBjz
         /2PcsGRM9dlHw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 452195C0A07; Fri, 11 Feb 2022 14:14:55 -0800 (PST)
Date:   Fri, 11 Feb 2022 14:14:55 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, rostedt@goodmis.org, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH rcu 3/3] rcu: Allow expedited RCU grace periods on
 incoming CPUs
Message-ID: <20220211221455.GM4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220204225409.GA4193020@paulmck-ThinkPad-P17-Gen-1>
 <20220204225507.4193113-3-paulmck@kernel.org>
 <de3a9710-fbf4-8005-a781-adc95ae4a090@quicinc.com>
 <20220209220601.GB4285@paulmck-ThinkPad-P17-Gen-1>
 <ede5ef2e-a804-3b9e-dfd1-d050baf48828@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ede5ef2e-a804-3b9e-dfd1-d050baf48828@quicinc.com>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 12, 2022 at 12:14:20AM +0530, Mukesh Ojha wrote:
> 
> On 2/10/2022 3:36 AM, Paul E. McKenney wrote:
> > On Wed, Feb 09, 2022 at 11:53:33PM +0530, Mukesh Ojha wrote:
> > > On 2/5/2022 4:25 AM, Paul E. McKenney wrote:
> > > > Although it is usually safe to invoke synchronize_rcu_expedited() from a
> > > > preemption-enabled CPU-hotplug notifier, if it is invoked from a notifier
> > > > between CPUHP_AP_RCUTREE_ONLINE and CPUHP_AP_ACTIVE, its attempts to
> > > > invoke a workqueue handler will hang due to RCU waiting on a CPU that
> > > > the scheduler is not paying attention to.  This commit therefore expands
> > > > use of the existing workqueue-independent synchronize_rcu_expedited()
> > > > from early boot to also include CPUs that are being hotplugged.
> > > > 
> > > > Link: https://lore.kernel.org/lkml/7359f994-8aaf-3cea-f5cf-c0d3929689d6@quicinc.com/
> > > > Reported-by: Mukesh Ojha <quic_mojha@quicinc.com>
> > > > Cc: Tejun Heo <tj@kernel.org>
> > > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > > ---
> > > >    kernel/rcu/tree_exp.h | 14 ++++++++++----
> > > >    1 file changed, 10 insertions(+), 4 deletions(-)
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
> > > Can we reach a condition after this change where no_wq = true and during
> > > rcu_stall report where exp_task = 0 list and exp_mask contain only this cpu
> > > ?
> > Hello, Mukesh, and thank you for looking this over!
> > 
> > At first glance, I do not believe that this can happen because the
> > expedited grace-period machinery avoids waiting on the current CPU.
> > (See sync_rcu_exp_select_node_cpus(), both the raw_smp_processor_id()
> > early in the function and the get_cpu() later in the function.)
> > 
> > But please let me know if I am missing something here.
> > 
> > But suppose that we could in fact reach this condition.  What bad thing
> > would happen?  Other than a resched_cpu() having been invoked several
> > times on a not-yet-online CPU, of course.  ;-)
> 
> 
> I thought more about this, what if  synchronize_rcu_expedited thread got
> schedule out and run on some other cpu
> and we clear out cpu on which it ran next from exp_mask.
> 
> Queuing the work on same cpu ensures that it will always be right cpu to
> clear out.
> Do you think this can happen ?

Indeed it might.

But if it did, the scheduler would invoke RCU's hook, which is named
rcu_note_context_switch(), and do so on the pre-switch CPU.  There are
two implementations for this function, one for CONFIG_PREEMPT=y
and another for CONFIG_PREEMPT=n.  Both look to me like they invoke
rcu_report_exp_rdp() when needed, one directly and the other via the
CONFIG_PREEMPT=n variant of rcu_qs().

Am I missing something?

						Thanx, Paul
