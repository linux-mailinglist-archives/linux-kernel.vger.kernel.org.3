Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6EB45B07BA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 16:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbiIGO6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 10:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbiIGO6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 10:58:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B7FDFD9;
        Wed,  7 Sep 2022 07:58:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B9B3F618F2;
        Wed,  7 Sep 2022 14:58:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC9ABC433C1;
        Wed,  7 Sep 2022 14:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662562683;
        bh=ViJUR2o7ZIgJQbtkn3NFgvbNbMNMn+IMw6KDOhSMojc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=SsAY9P8PYnz5Y9qEWhLssf7zUyQ18Ozk+iAaO65/3a/plSCblo0W20uKzpYZe2RIb
         92mrcrheX6zX61eN5sofXaJOvIiFegtxsB4mFHIjgnVpmqLuxs7sE5gw8fnIKob/Jv
         CaMS0iPZBfSxbncIHlD5t0uduOCC5QiTC7VYKeXib0UGAf+BlCaUx6h6KpK1vJbgxm
         s5nxa6rA9IKtKT+U0JOQV2Wj3zQzT4os8BFgIuUtndgpmsKelEMUZcREIOM7sBIQ07
         BV6A9K0ZLTqNs3hp/2w9d5GnSiBKA1mYxnq7FYUo0eHLdDdbbneUT1T2ajHqZ5xDDf
         ITjQW/Oa6y6Tw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 1D5A25C0A6B; Wed,  7 Sep 2022 07:57:59 -0700 (PDT)
Date:   Wed, 7 Sep 2022 07:57:59 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, rostedt@goodmis.org,
        Zqiang <qiang1.zhang@intel.com>
Subject: Re: [PATCH rcu 03/10] rcu: Add QS check in rcu_exp_handler() for
 non-preemptible kernels
Message-ID: <20220907145759.GJ4315@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220831180759.GA2693289@paulmck-ThinkPad-P17-Gen-1>
 <20220831180805.2693546-3-paulmck@kernel.org>
 <20220907121010.GA196513@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220907121010.GA196513@lothringen>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 07, 2022 at 02:10:10PM +0200, Frederic Weisbecker wrote:
> On Wed, Aug 31, 2022 at 11:07:58AM -0700, Paul E. McKenney wrote:
> > From: Zqiang <qiang1.zhang@intel.com>
> > 
> > Kernels built with CONFIG_PREEMPTION=n and CONFIG_PREEMPT_COUNT=y maintain
> > preempt_count() state.  Because such kernels map __rcu_read_lock()
> > and __rcu_read_unlock() to preempt_disable() and preempt_enable(),
> > respectively, this allows the expedited grace period's !CONFIG_PREEMPT_RCU
> > version of the rcu_exp_handler() IPI handler function to use
> > preempt_count() to detect quiescent states.
> > 
> > This preempt_count() usage might seem to risk failures due to
> > use of implicit RCU readers in portions of the kernel under #ifndef
> > CONFIG_PREEMPTION, except that rcu_core() already disallows such implicit
> > RCU readers.  The moral of this story is that you must use explicit
> > read-side markings such as rcu_read_lock() or preempt_disable() even if
> > the code knows that this kernel does not support preemption.
> > 
> > This commit therefore adds a preempt_count()-based check for a quiescent
> > state in the !CONFIG_PREEMPT_RCU version of the rcu_exp_handler()
> > function for kernels built with CONFIG_PREEMPT_COUNT=y, reporting an
> > immediate quiescent state when the interrupted code had both preemption
> > and softirqs enabled.
> > 
> > This change results in about a 2% reduction in expedited grace-period
> > latency in kernels built with both CONFIG_PREEMPT_RCU=n and
> > CONFIG_PREEMPT_COUNT=y.
> > 
> > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > Link: https://lore.kernel.org/all/20220622103549.2840087-1-qiang1.zhang@intel.com/
> > ---
> >  kernel/rcu/tree_exp.h | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> > index be667583a5547..b07998159d1fa 100644
> > --- a/kernel/rcu/tree_exp.h
> > +++ b/kernel/rcu/tree_exp.h
> > @@ -828,11 +828,13 @@ static void rcu_exp_handler(void *unused)
> >  {
> >  	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
> >  	struct rcu_node *rnp = rdp->mynode;
> > +	bool preempt_bh_enabled = !(preempt_count() & (PREEMPT_MASK |
> > SOFTIRQ_MASK));
> 
> I don't know if nested hardirqs still exist. I only heard old rumours
> about broken drivers. Should we take care of them?

Last I checked, certain tracing scenarios from irq handlers looked
to RCU like nested irq handlers.  Given that, does your more robust
approach below work correctly?

						Thanx, Paul

> Also are we sure that all callers of flush_smp_call_function_queue()
> are QS?
> 
> Let's see we know that rcu_exp_handler() can either be executed from:
> 
> * hardirqs
> 
> Or from process context, expected to be RCU QS states at least in idle
> as the comment above flush_smp_call_function_queue() in idle says
> (but I'd rather check all the in-process callers before stating all
> of them are in QS)
> 
> * idle (in which case preemption is disabled unfortunately so the current
> test won't help)
> * stop_machine
>   _ When CPU is dead and out of RCU (rcutree_dead_cpu() called)
>     so that should be a QS.
>   _ When CPU is migrating (is it a QS then?)
> 
> If we check further that all non-IRQ callers of flush_smp_call_function_queue()
> are always quiescent states then we could deduce that !in_hardirq() means we are in
> a quiescent state, whether preemption is disabled or not.
> 
> In any case for the current patch, perhaps a more robust test against nested
> hardirqs would be:
> 
> unsigned long cnt = preempt_count();
> bool preempt_bh_enabled = (!cnt || cnt == HARDIRQ_OFFSET)
> 
> Thanks.
> 
> >  
> >  	if (!(READ_ONCE(rnp->expmask) & rdp->grpmask) ||
> >  	    __this_cpu_read(rcu_data.cpu_no_qs.b.exp))
> >  		return;
> > -	if (rcu_is_cpu_rrupt_from_idle()) {
> > +	if (rcu_is_cpu_rrupt_from_idle() ||
> > +	    (IS_ENABLED(CONFIG_PREEMPT_COUNT) && preempt_bh_enabled)) {
> >  		rcu_report_exp_rdp(this_cpu_ptr(&rcu_data));
> >  		return;
> >  	}
> > -- 
> > 2.31.1.189.g2e36527f23
> > 
