Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F402567792
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 21:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233500AbiGETOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 15:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232209AbiGETOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 15:14:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58788201AF;
        Tue,  5 Jul 2022 12:14:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E760B61B1C;
        Tue,  5 Jul 2022 19:14:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D2DDC341C7;
        Tue,  5 Jul 2022 19:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657048468;
        bh=Vge1dUKcYIloggR5bDdDwV4hJYwAfN52LAxbbI4V5dY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=BzhlfDmbxe9wK20eQxVeAbrDvd1IbP2kspvFj+qggskmfglIE5vZsdO1NqpH5tZW3
         SYMLPPo16NGWnZdNN8YbDt3pe6LDx/ED42PS3bA6KEalgz/BQ5Ya4pMqbl4sxYYVlm
         JOXhBK96kcz3j8F4kqPFE93vLDR3cdv0RAVOrl+lS/mbkKDohv2E+tdsRU7nxMjsOU
         5kcjxZyTcoLlrtAit7bgRFnbxu+/adpfgv/BK00RYSzBe/zh7qwfrHbWv9uZ428AUL
         msYA/0lpVoWWc09wGunNXEFQeu/sSVQ6tZ4WZw4wiXB2b6V7aNdPRHZhtpOBvUy6RB
         QlL7an+Y1LN+w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id F2DAE5C05ED; Tue,  5 Jul 2022 12:14:27 -0700 (PDT)
Date:   Tue, 5 Jul 2022 12:14:27 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rcu: Add exp QS check in rcu_exp_handler() for
 no-preemptible expedited RCU
Message-ID: <20220705191427.GE1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220622103549.2840087-1-qiang1.zhang@intel.com>
 <YrNQpxjIiNpxwyQh@boqun-archlinux>
 <PH0PR11MB58809E7A0BF02907DAA826AADAB29@PH0PR11MB5880.namprd11.prod.outlook.com>
 <20220623003409.GD1790663@paulmck-ThinkPad-P17-Gen-1>
 <YrPM3ub+BGukLi+l@boqun-archlinux>
 <PH0PR11MB58800BA38E0691E2FB3AF552DAB59@PH0PR11MB5880.namprd11.prod.outlook.com>
 <20220627214143.GP1790663@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR11MB5880C49AE26E587A029B43E3DAB89@PH0PR11MB5880.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR11MB5880C49AE26E587A029B43E3DAB89@PH0PR11MB5880.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 04:32:58AM +0000, Zhang, Qiang1 wrote:
> On Thu, Jun 23, 2022 at 03:23:19AM +0000, Zhang, Qiang1 wrote:
> > On Wed, Jun 22, 2022 at 05:34:09PM -0700, Paul E. McKenney wrote:
> > > On Wed, Jun 22, 2022 at 11:34:15PM +0000, Zhang, Qiang1 wrote:
> > > > 
> > > > On Wed, Jun 22, 2022 at 06:35:49PM +0800, Zqiang wrote:
> > > > > In CONFIG_PREEMPT=n and CONFIG_PREEMPT_COUNT=y kernel, after a exp
> > > > > grace period begins, if detected current CPU enters idle in
> > > > > rcu_exp_handler() IPI handler, will immediately report the exp QS of the
> > > > > current cpu, at this time, maybe not being in an RCU read-side critical
> > > > > section, but need wait until rcu-softirq or sched-clock irq or sched-switch
> > > > > occurs on current CPU to check and report exp QS.
> > > > > 
> > > > 
> > > > >I think the idea is OK, however, this "optimization" is based on the
> > > > >implementation detail that rcu_read_lock() counts preempt_count when
> > > > >CONFIG_PREEMPT_COUNT=y, right? It's a little bit dangerous because the
> > > > >preempt_count when CONFIG_PREEMPT_COUNT=y and CONFIG_PREEMPT=n is mostly
> > > > >for debugging purposes IIUC, and in other words, _it could be gone_.
> > > > >
> > > > 
> > > > Yes, for CONFIG_PREEMPT_COUNT=y and CONFIG_PREEMPT=n kernel
> > > > The rcu_read_lock/unlock are replaced by preempt_disbale/enable, and the 
> > > > preempt-count is exists,  so can report exp QS when not being an  RCU 
> > > > read-side critical(preempt_count & (PREEMPT_MASK | SOFTIRQ_MASK )return zero).
> > > > in IPI handler. 
> > > > 
> > > > For CONFIG_PREEMPT_COUNT=n and CONFIG_PREEMPT=n kernel, 
> > > > The rcu_read_lock/unlock is just barrier(). 
> > > > 
> > > > 
> > > > So I add IS_ENABLED(CONFIG_PREEMPT_COUNT) check in code.
> > > > 
> > > > Of course, for CONFIG_PREEMPT_COUNT=n  kernel, in RCU softirq, the 
> > > > preempt-count is also checked
> > > > 
> > > > /* Report any deferred quiescent states if preemption enabled. */
> > > >  if (IS_ENABLED(CONFIG_PREEMPT_COUNT) && (!(preempt_count() & PREEMPT_MASK))) {
> > > >                  rcu_preempt_deferred_qs(current);
> > > > 
> > > > but the RCU softirq may not be triggered in time and reported exp QS, for
> > > > example a kernel loop exist on NO_HZ_FULL CPU
> > > > 
> > > > this change, It is to capture the exp QS state earlier and report it.
> > > > 
> > > > 
> > > > >Also I'm not aware of any but there could be someone assuming that RCU
> > > > >read-side critical sections can be formed without
> > > > >rcu_read_{lock,unlock}() in CONFIG_PREEMPT=n kernel. For example, there
> > > > >might be "creative" code like the following:
> > > > >
> > > > >	void do_something_only_in_nonpreempt(void)
> > > > >	{
> > > > >		int *p;
> > > > >
> > > > >		// This function only gets called in PREEMPT=n kernel,
> > > > >		// which means everywhere is a RCU read-side critical
> > > > >		// section, let's save some lines of code.
> > > > >
> > > > 		rcu_read_lock();
> > > > >		p = rcu_dereference_check(gp, !IS_ENABLED(PREEMPT));
> > > > >		... // of course no schedule() here.
> > > > >		<access p>
> > > >                              rcu_read_unlock();
> > > > >	}
> > > > >
> > > > 
> > > > Usually access to pointers of type rcu needs to be protected.
> > 
> > Yes, _ususally_ they are, but what about the special cases? Because
> > in PREEMPT=n kernel, almost everywhere is a RCU read-side critical
> > section, some one might have been "creative" enough to omit these
> > rcu_read_lock() and rcu_read_unlock().
> > 
> > > 
> > > Indeed, lockdep would normally complain about this sort of thing.
> > > But in kernels built with (say) CONFIG_PREEMPT_NONE=y but without
> > > CONFIG_PREEMPT_COUNT=N, can lockdep really tell the difference?
> > > 
> > 
> > >Actually with the rcu_dereference_check() above, lockdep cannot detect
> > >even CONFIG_PREEMPT_COUNT=y, that rcu_dereference_check() basically says
> > >"I know I'm in a read-side critical section if it's a non-preempt
> > >kernel, so don't bother to check". ;-)
> > 
> > > > Any thoughts?
> > > 
> > > It would be good to have some performance data on this change to expedited
> > > grace periods.  It is adding code, so it needs some real motivation.
> > 
> > I used rcuscale to test it, and  count the average time of writer-duration
> > 
> > no applied patch(org.txt)
> > writer avg  time  29690.39     29670.78     29770.65       29423.25
> > 
> > applied patch(new.txt)
> > writer avg time 28989.99       29003.54      29281.39       28986.58
> > 
> > or Is there a better way to test?
> 
> >If I understand your measurments correctly, you are getting about a 2%
> >improvement in expedited grace-period latency in !PREEMPT kernels.
> >Do we have a situation for which that 2% improvement is important?
> 
> To be honest, it will also be affected by the work scheduling delay. Indeed, 
> my current test results are not very good, but it is beneficial to detect the
> QS state in advance and report it in time. of course, I will do more tests in
> the future
> 
> >We would be taking some risk due to the issues Boqun points out or we
> >would be adding some complexity to avoid those issues.  So this
> 
> As for the code similar to the above scenario proposed by Boqun, 
> it is true that lockdep will not complain, I do not deny that someone
> will write this way.
> 
> If there really is such a situation as Boqun mentioned, There is also 
> a risk in the following code segment in PREEMPT=n and PREEMPT_COUNT=y
> 
>         /* Report any deferred quiescent states if preemption enabled. */
>         if (IS_ENABLED(CONFIG_PREEMPT_COUNT) && (!(preempt_count() & PREEMPT_MASK)))
>                 rcu_preempt_deferred_qs(current);

Fair point.

I have applied the commit shown below.  Does that look correct?

							Thanx, Paul

------------------------------------------------------------------------

commit 9db96a8acda6837e5d4cd6a1cd7323709810e418
Author: Zqiang <qiang1.zhang@intel.com>
Date:   Tue Jul 5 12:09:51 2022 -0700

    rcu: Add QS check in rcu_exp_handler() for non-preemptible kernels
    
    Kernels built with CONFIG_PREEMPTION=n and CONFIG_PREEMPT_COUNT=y maintain
    preempt_count() state.  Because such kernels map __rcu_read_lock()
    and __rcu_read_unlock() to preempt_disable() and preempt_enable(),
    respectively, this allows the expedited grace period's !CONFIG_PREEMPT_RCU
    version of the rcu_exp_handler() IPI handler function to use
    preempt_count() to detect quiescent states.
    
    This preempt_count() usage might seem to risk failures due to
    use of implicit RCU readers in portions of the kernel under #ifndef
    CONFIG_PREEMPTION, except that rcu_core() already disallows such implicit
    RCU readers.  The moral of this story is that you must use explicit
    read-side markings such as rcu_read_lock() or preempt_disable() even if
    the code knows that this kernel does not support preemption.
    
    This commit therefore adds a preempt_count()-based check for a quiescent
    state in the !CONFIG_PREEMPT_RCU version of the rcu_exp_handler()
    function for kernels built with CONFIG_PREEMPT_COUNT=y, reporting an
    immediate quiescent state when the interrupted code had both preemption
    and softirqs enabled.
    
    This change results in about a 2% reduction in expedited grace-period
    latency in kernels built with both CONFIG_PREEMPT_RCU=n and
    CONFIG_PREEMPT_COUNT=y.
    
    Signed-off-by: Zqiang <qiang1.zhang@intel.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
    Link: https://lore.kernel.org/all/20220622103549.2840087-1-qiang1.zhang@intel.com/

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index be667583a5547..b07998159d1fa 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -828,11 +828,13 @@ static void rcu_exp_handler(void *unused)
 {
 	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 	struct rcu_node *rnp = rdp->mynode;
+	bool preempt_bh_enabled = !(preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK));
 
 	if (!(READ_ONCE(rnp->expmask) & rdp->grpmask) ||
 	    __this_cpu_read(rcu_data.cpu_no_qs.b.exp))
 		return;
-	if (rcu_is_cpu_rrupt_from_idle()) {
+	if (rcu_is_cpu_rrupt_from_idle() ||
+	    (IS_ENABLED(CONFIG_PREEMPT_COUNT) && preempt_bh_enabled)) {
 		rcu_report_exp_rdp(this_cpu_ptr(&rcu_data));
 		return;
 	}
