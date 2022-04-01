Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 672774EF87D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 18:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345304AbiDAQ5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 12:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233692AbiDAQ5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 12:57:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE9C9F32B3;
        Fri,  1 Apr 2022 09:55:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 834CDB82468;
        Fri,  1 Apr 2022 16:55:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35661C340EC;
        Fri,  1 Apr 2022 16:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648832125;
        bh=48jXrzw1a+CUwNYdJ11VTIPu+z+bLZeiEL8pwinzCA0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=OEoFXO3NMbcynJRaDOTTxooyYoOathk93aEkp8jb0BdKB+GNLCeDCPMnKt0daMM/m
         zXDVUX01qvb0FJt1LeprWEehLrV7xZPnrNBGTYhh4Do//7gmG2C/Wns6Vt4cW4ZsGQ
         k+sh5qpHfUfCP7hCTE0+sJxmDYdhrnufQGhsiHmD7mk/CUtwoPbBtMaqV6WrOaNvbp
         B0V1d6Yy3tYqe+8rQymISG41alvjKON5PFOhWM5Xcd77yuiN64T/OoMwKQBVvu2bo4
         s7p/ixdbGviK4T8dfvN1axYNCIp8jLF4cJG2NKQfvpjVwsGe9crgvhuwRfXKHFPsex
         MIzMBL9bxAbHg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D71685C0A15; Fri,  1 Apr 2022 09:55:24 -0700 (PDT)
Date:   Fri, 1 Apr 2022 09:55:24 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>
Cc:     "frederic@kernel.org" <frederic@kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rcu: Put the irq work into hard interrupt context for
 execution
Message-ID: <20220401165524.GF4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220330060012.2470054-1-qiang1.zhang@intel.com>
 <20220330201620.GM4285@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR11MB58802C1246C6F4FB895BDDA9DA1F9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <20220331172943.GV4285@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR11MB5880709B39EC5BDAACBD340FDAE09@PH0PR11MB5880.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR11MB5880709B39EC5BDAACBD340FDAE09@PH0PR11MB5880.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 01, 2022 at 01:55:51AM +0000, Zhang, Qiang1 wrote:
> 
> On Wed, Mar 30, 2022 at 10:47:05PM +0000, Zhang, Qiang1 wrote:
> > On Wed, Mar 30, 2022 at 02:00:12PM +0800, Zqiang wrote:
> > > In PREEMPT_RT kernel, if irq work flags is not set, it will be 
> > > executed in per-CPU irq_work kthreads. set IRQ_WORK_HARD_IRQ flags 
> > > to irq work, put it in the context of hard interrupt execution, 
> > > accelerate scheduler to re-evaluate.
> > > 
> > > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> > > ---
> > >  kernel/rcu/tree.c        | 2 +-
> > >  kernel/rcu/tree_plugin.h | 2 +-
> > >  2 files changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c index
> > > e2ffbeceba69..a69587773a85 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -678,7 +678,7 @@ static void late_wakeup_func(struct irq_work
> > > *work)  }
> > >  
> > >  static DEFINE_PER_CPU(struct irq_work, late_wakeup_work) =
> > > -	IRQ_WORK_INIT(late_wakeup_func);
> > > +	IRQ_WORK_INIT_HARD(late_wakeup_func);
> > 
> > >This is used only by rcu_irq_work_resched(), which is invoked only by rcu_user_enter(), which is never invoked until userspace is enabled, by which time all of the various kthreads will have been spawned, correct?
> > >
> > >Either way, please show me the exact sequence of events that lead to a problem with the current IRQ_WORK_INIT().
> > >
> > >  /*
> > >   * If either:
> > > diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h 
> > > index 3037c2536e1f..cf7bd28af8ef 100644
> > > --- a/kernel/rcu/tree_plugin.h
> > > +++ b/kernel/rcu/tree_plugin.h
> > > @@ -661,7 +661,7 @@ static void rcu_read_unlock_special(struct task_struct *t)
> > >  			    expboost && !rdp->defer_qs_iw_pending && cpu_online(rdp->cpu)) {
> > >  				// Get scheduler to re-evaluate and call hooks.
> > >  				// If !IRQ_WORK, FQS scan will eventually IPI.
> > > -				init_irq_work(&rdp->defer_qs_iw, rcu_preempt_deferred_qs_handler);
> > > +				rdp->defer_qs_iw =
> > > +IRQ_WORK_INIT_HARD(rcu_preempt_deferred_qs_handler);
> > >  				rdp->defer_qs_iw_pending = true;
> > >  				irq_work_queue_on(&rdp->defer_qs_iw, rdp->cpu);
> > >  			}
> > >
> > >OK, in theory, rcu_read_unlock() could get to this point before all of the various kthreads were spawned.  In practice, the next time that the boot CPU went idle, the end of the quiescent state would be noticed.
> > 
> > Through my understanding, use irq_work in order to make the quiescent 
> > state be noticed earlier, Because the irq_work execute in interrupt, 
> > this irq_work can be executed in time, but In RT kernel The irq_work  is put into the kthread for execution, when it is executed, it is affected by the scheduling delay.
> > Is there anything I missed?
> 
> >Yes, in that I am not seeing any actual data showing that this fix really makes things better.  Please in mind that IRQ_WORK_INIT_HARD does have performance disadvantages of its own.  So although I agree with your words saying that IRQ_WORK_INIT_HARD -might- be helpful, those words are not sufficient.
> >
> >So, can you show a statistically significant benefit on a real system?
> >For example, by measuring the time required for a expedited grace period to complete?  That would argue for this change, though it would need to be conditional, so that systems that don't care that much about the latency of expedited RCU grace periods don't need to pay the IRQ_WORK_INIT_HARD performance penalties.  Or you would need to demonstrate that these performance penalties don't cause problems.  (But such a demonstration is not easy given the wide variety of systems that Linux supports.)
> >
> >Now, I could imagine that the current code could cause problems during boot on CONFIG_PREEMPT_RT kernels.  But, believe me, I can imagine all sorts of horrible problems.  But we should fix those that happen not just in my imagination, but also in the real world.  ;-)
> 
> Thanks, agree.  I'll test it according to your suggestion.

Very good!  I am looking forward to seeing what you come up with.

							Thanx, Paul

> >So if you can make such a problem happen in real life, then I would be happy to take a patch that fixed this on CONFIG_PREEMPT_RT but kept the current code otherwise.
> >
> >							Thanx, Paul
> 
> > Thanks
> > Zqiang	
> > 
> > >
> > >Or has this been failing in some other manner?  If so, please let me know the exact sequence of events.
> > >
> > >							Thanx, Paul
