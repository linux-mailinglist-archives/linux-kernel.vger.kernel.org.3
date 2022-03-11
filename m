Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D02F4D666E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 17:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350357AbiCKQgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 11:36:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347006AbiCKQge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 11:36:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB5671B8BCE
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 08:35:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 78447B8245E
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 16:35:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E15BBC340E9;
        Fri, 11 Mar 2022 16:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647016528;
        bh=ZDH5ghaxXoebtpfMFPomtRHGfRbVXQBs29Cov4o+Rjk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VNQDT5PMj7LTE1c8A6VgSp4kp4jaD8y2pjRemmsGm1+yE6LmsQs+RINWbneuRCRps
         DlIYm5DwLCIKYHwZjbNywV8WkaBCwG9TB3ZnPK/xa922Ha2eMqGi5G0H4wCM2rwtho
         /7JgyjU7BN0trICr5fi5euR2Rydt6xuP3L5j2XUNUj3j63f0mZJVHUFIeKNaCn16p6
         FccTk2gQsbK0ozjgL+fqCEgKlwDL3T+RzW9vDsZsZrp+B0KJ6s8t+DGYSAFWKlfnYs
         t914Fd0FfKL1P+7xCd61QL+6tnd63G2MIfT+EPXTJT+Vr74400jKMT3OuIIGlj1Pf6
         wOkbhv7xlqvgA==
Date:   Fri, 11 Mar 2022 17:35:25 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
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
Subject: Re: [PATCH 18/19] rcu/context_tracking: Merge dynticks counter and
 context tracking states
Message-ID: <20220311163525.GF227945@lothringen>
References: <20220302154810.42308-1-frederic@kernel.org>
 <20220302154810.42308-19-frederic@kernel.org>
 <20220310203222.GC4285@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220310203222.GC4285@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2022 at 12:32:22PM -0800, Paul E. McKenney wrote:
> On Wed, Mar 02, 2022 at 04:48:09PM +0100, Frederic Weisbecker wrote:
> > Updating the context tracking state and the RCU dynticks counter
> > atomically in a single operation is a first step towards improving CPU
> > isolation. This makes the context tracking state updates fully ordered
> > and therefore allow for later enhancements such as postponing some work
> > while a task is running isolated in userspace until it ever comes back
> > to the kernel.
> > 
> > The state field becomes divided in two parts:
> > 
> > 1) Lower bits for context tracking state:
> > 
> >    	CONTEXT_IDLE = 1,
> > 	CONTEXT_USER = 2,
> > 	CONTEXT_GUEST = 4,
> 
> And the CONTEXT_DISABLED value of -1 works because you can have only
> one of the above three bits set at a time?
> 
> Except that RCU needs this to unconditionally at least distinguish
> between kernel and idle, given the prevalence of CONFIG_NO_HZ_IDLE=y.
> So does the CONTEXT_DISABLED really happen anymore?
> 
> A few more questions interspersed below.

The value of CONTEXT_DISABLED is never stored in the ct->state. It is just
returned as is when CONTEXT_TRACKING is disabled. So this shouldn't conflict
with RCU.

> > @@ -452,15 +453,16 @@ void noinstr __ct_user_exit(enum ctx_state state)
> >  			 * Exit RCU idle mode while entering the kernel because it can
> >  			 * run a RCU read side critical section anytime.
> >  			 */
> > -			rcu_eqs_exit(true);
> > +			ct_kernel_enter(true, RCU_DYNTICKS_IDX - state);
> >  			if (state == CONTEXT_USER) {
> >  				instrumentation_begin();
> >  				vtime_user_exit(current);
> >  				trace_user_exit(0);
> >  				instrumentation_end();
> >  			}
> > +		} else {
> > +			atomic_sub(state, &ct->state);
> 
> OK, atomic_sub() got my attention.  What is going on here?  ;-)

Right :-)

So that's when context tracking user is running but RCU doesn't
track user. This is for example when NO_HZ_FULL=n but VIRT_CPU_ACCOUNTING_GEN=y.

I might remove that standalone VIRT_CPU_ACCOUNTING_GEN=y one day but for now
it's there.

Anyway so in this case we only want to track KERNEL <-> USER from context
tracking POV, but we don't need the DYNTICKS_RCU_IDX part, hence the spared
ordering.

But it still needs to be atomic because NMIs may increase DYNTICKS_RCU_IDX on
the same field.


> > @@ -548,7 +550,7 @@ EXPORT_SYMBOL_GPL(context_tracking);
> >  void ct_idle_enter(void)
> >  {
> >  	lockdep_assert_irqs_disabled();
> > -	rcu_eqs_enter(false);
> > +	ct_kernel_exit(false, RCU_DYNTICKS_IDX + CONTEXT_IDLE);
> >  }
> >  EXPORT_SYMBOL_GPL(ct_idle_enter);
> >  
> > @@ -566,7 +568,7 @@ void ct_idle_exit(void)
> >  	unsigned long flags;
> >  
> >  	local_irq_save(flags);
> > -	rcu_eqs_exit(false);
> > +	ct_kernel_enter(false, RCU_DYNTICKS_IDX - CONTEXT_IDLE);
> 
> Nice!  This works because all transitions must be either from or
> to kernel context, correct?

Exactly. There is no such thing as IDLE -> USER -> GUEST, etc...
There has to be KERNEL in the middle of each. Because we never
call rcu_idle_enter() -> rcu_user_enter() for example. The has to be
rcu_idle_exit() in the middle.

(famous last words).

> >  /* Return true if the specified CPU is currently idle from an RCU viewpoint.  */
> > @@ -321,8 +321,7 @@ bool rcu_dynticks_zero_in_eqs(int cpu, int *vp)
> >  	int snap;
> >  
> >  	// If not quiescent, force back to earlier extended quiescent state.
> > -	snap = ct_dynticks_cpu(cpu) & ~0x1;
> > -
> > +	snap = ct_dynticks_cpu(cpu) & ~RCU_DYNTICKS_IDX;
> 
> Do we also need to get rid of the low-order bits?  Or is that happening
> elsewhere?  Or is there some reason that they can stick around?

Yep, ct_dynticks_cpu() clears the low order CONTEXT_* bits.

> > diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> > index 9bf5cc79d5eb..1ac48c804006 100644
> > --- a/kernel/rcu/tree_stall.h
> > +++ b/kernel/rcu/tree_stall.h
> > @@ -459,7 +459,7 @@ static void print_cpu_stall_info(int cpu)
> >  			rdp->rcu_iw_pending ? (int)min(delta, 9UL) + '0' :
> >  				"!."[!delta],
> >  	       ticks_value, ticks_title,
> > -	       rcu_dynticks_snap(cpu) & 0xfff,
> > +	       (rcu_dynticks_snap(cpu) >> RCU_DYNTICKS_SHIFT) & 0xfff ,
> 
> Actually, the low-ordder several bits are useful when debugging, so
> could you please not shift them away?  Maybe also go to 0xffff to allow
> for more bits taken?

Yeah that makes sense, I'll change that.

Thanks a lot for the reviews!
