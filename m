Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE06556F80
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 02:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359551AbiFWAeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 20:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359258AbiFWAeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 20:34:14 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 561F92ED62;
        Wed, 22 Jun 2022 17:34:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 83AFACE1941;
        Thu, 23 Jun 2022 00:34:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB3DFC34114;
        Thu, 23 Jun 2022 00:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655944449;
        bh=8pRjVt8kJKIexpKI7T4TAXNtH3iXAd8u4Sqbp4lZIAA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=kNaY+V/V3h5wlwDnsgT5dI115TmEepqk2emU6ZGYHCDJXFXYJAXkGjrsdoehxvf7Y
         +SAyeAYi0ODG/R8aycvtr3ulLex3oUQQyoj3y/VZgWvLEkcVolGll+iuv9mEm9RQi/
         7Ln1SDlqqp/IdQrfJCafG4VGYq7rxcuKqx81QoI8pN1R2ksg33BjEMCi4b5dxmAlru
         MPKaOBZ5LlfUTDRHS72jgJpnRamx80diC5B1SWSwi8Hb6rRNHH103aEnuWXE7vaLdV
         QLurGYkX19JpivLnvreR0taIOLcHXqGznnMsox6HmnRlWrfx7X9cE6+oQMjQy6f9yz
         us41CkJKpccYg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 6ED245C0399; Wed, 22 Jun 2022 17:34:09 -0700 (PDT)
Date:   Wed, 22 Jun 2022 17:34:09 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rcu: Add exp QS check in rcu_exp_handler() for
 no-preemptible expedited RCU
Message-ID: <20220623003409.GD1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220622103549.2840087-1-qiang1.zhang@intel.com>
 <YrNQpxjIiNpxwyQh@boqun-archlinux>
 <PH0PR11MB58809E7A0BF02907DAA826AADAB29@PH0PR11MB5880.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR11MB58809E7A0BF02907DAA826AADAB29@PH0PR11MB5880.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 11:34:15PM +0000, Zhang, Qiang1 wrote:
> 
> On Wed, Jun 22, 2022 at 06:35:49PM +0800, Zqiang wrote:
> > In CONFIG_PREEMPT=n and CONFIG_PREEMPT_COUNT=y kernel, after a exp
> > grace period begins, if detected current CPU enters idle in
> > rcu_exp_handler() IPI handler, will immediately report the exp QS of the
> > current cpu, at this time, maybe not being in an RCU read-side critical
> > section, but need wait until rcu-softirq or sched-clock irq or sched-switch
> > occurs on current CPU to check and report exp QS.
> > 
> 
> >I think the idea is OK, however, this "optimization" is based on the
> >implementation detail that rcu_read_lock() counts preempt_count when
> >CONFIG_PREEMPT_COUNT=y, right? It's a little bit dangerous because the
> >preempt_count when CONFIG_PREEMPT_COUNT=y and CONFIG_PREEMPT=n is mostly
> >for debugging purposes IIUC, and in other words, _it could be gone_.
> >
> 
> Yes, for CONFIG_PREEMPT_COUNT=y and CONFIG_PREEMPT=n kernel
> The rcu_read_lock/unlock are replaced by preempt_disbale/enable, and the 
> preempt-count is exists,  so can report exp QS when not being an  RCU 
> read-side critical(preempt_count & (PREEMPT_MASK | SOFTIRQ_MASK )return zero).
> in IPI handler. 
> 
> For CONFIG_PREEMPT_COUNT=n and CONFIG_PREEMPT=n kernel, 
> The rcu_read_lock/unlock is just barrier(). 
> 
> 
> So I add IS_ENABLED(CONFIG_PREEMPT_COUNT) check in code.
> 
> Of course, for CONFIG_PREEMPT_COUNT=n  kernel, in RCU softirq, the 
> preempt-count is also checked
> 
> /* Report any deferred quiescent states if preemption enabled. */
>  if (IS_ENABLED(CONFIG_PREEMPT_COUNT) && (!(preempt_count() & PREEMPT_MASK))) {
>                  rcu_preempt_deferred_qs(current);
> 
> but the RCU softirq may not be triggered in time and reported exp QS, for
> example a kernel loop exist on NO_HZ_FULL CPU
> 
> this change, It is to capture the exp QS state earlier and report it.
> 
> 
> >Also I'm not aware of any but there could be someone assuming that RCU
> >read-side critical sections can be formed without
> >rcu_read_{lock,unlock}() in CONFIG_PREEMPT=n kernel. For example, there
> >might be "creative" code like the following:
> >
> >	void do_something_only_in_nonpreempt(void)
> >	{
> >		int *p;
> >
> >		// This function only gets called in PREEMPT=n kernel,
> >		// which means everywhere is a RCU read-side critical
> >		// section, let's save some lines of code.
> >
> 		rcu_read_lock();
> >		p = rcu_dereference_check(gp, !IS_ENABLED(PREEMPT));
> >		... // of course no schedule() here.
> >		<access p>
>                              rcu_read_unlock();
> >	}
> >
> 
> Usually access to pointers of type rcu needs to be protected.

Indeed, lockdep would normally complain about this sort of thing.
But in kernels built with (say) CONFIG_PREEMPT_NONE=y but without
CONFIG_PREEMPT_COUNT=N, can lockdep really tell the difference?

> Any thoughts?

It would be good to have some performance data on this change to expedited
grace periods.  It is adding code, so it needs some real motivation.
So, does this change make a system-level difference in (say) expedited
RCU grace-period latency, and if so, under what conditions?

						Thanx, Paul

> >Again, I'm not aware of any existing code that does this but we need to
> >be sure.
> >
> >Regards,
> >Boqun
> >
> > This commit add a exp QS check in rcu_exp_handler(), when not being
> > in an RCU read-side critical section, report exp QS earlier.
> > 
> > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> > ---
> >  kernel/rcu/tree_exp.h | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> > index be667583a554..34f08267410f 100644
> > --- a/kernel/rcu/tree_exp.h
> > +++ b/kernel/rcu/tree_exp.h
> > @@ -828,11 +828,14 @@ static void rcu_exp_handler(void *unused)
> >  {
> >  	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
> >  	struct rcu_node *rnp = rdp->mynode;
> > +	bool preempt_bh_disabled =
> > +				!!(preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK));
> >  
> >  	if (!(READ_ONCE(rnp->expmask) & rdp->grpmask) ||
> >  	    __this_cpu_read(rcu_data.cpu_no_qs.b.exp))
> >  		return;
> > -	if (rcu_is_cpu_rrupt_from_idle()) {
> > +	if (rcu_is_cpu_rrupt_from_idle() ||
> > +			(IS_ENABLED(CONFIG_PREEMPT_COUNT) && !preempt_bh_disabled)) {
> >  		rcu_report_exp_rdp(this_cpu_ptr(&rcu_data));
> >  		return;
> >  	}
> > -- 
> > 2.25.1
> > 
