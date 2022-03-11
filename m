Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C71A34D66CA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 17:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346301AbiCKQtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 11:49:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241098AbiCKQtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 11:49:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB917C3319
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 08:48:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C1CC0B829A3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 16:47:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84431C340E9;
        Fri, 11 Mar 2022 16:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647017278;
        bh=/c1AzyCiBAXo0fjWIj4SHt7ZEKfhLVc3HKZHZBuVRE4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=DysmJ2m64LtY2WBd95+msY2EnwEbOxGwPvf2ji962yvWC8CBWhQUQgNUlaPfSFAJt
         IXIuq/6qLRuItJJZJP5NYDA3HH9URkXNck35jDrvbA96tHWLIk7kn/L3kKsn2vBrNi
         EvqzE/NbAnIqsw5AjSHmdTL6t1tUYvRCm6vG33oNYb7SjdGlQloXno8/dlZczduGgD
         Fw7t3cvio8UXKUR7ZPwnyCDQUNO3AT9x3t3o0pbZnzQi5qnBOO9XdUgFR1ImLVgvAh
         W5mHLbyrYNzqasw5m/3KSduyGATVYIXgy/A8G329LqDDdBdyrWLmnPpiwyPnovOj76
         0rxfQBHpW1g1A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 207BA5C0140; Fri, 11 Mar 2022 08:47:58 -0800 (PST)
Date:   Fri, 11 Mar 2022 08:47:58 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Scenario TREE07 with CONFIG_PREEMPT_DYNAMIC=n?
Message-ID: <20220311164758.GA3574399@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220310215630.GA3490034@paulmck-ThinkPad-P17-Gen-1>
 <20220310224103.GA94994@lothringen>
 <20220310225219.GE4285@paulmck-ThinkPad-P17-Gen-1>
 <20220311130719.GC96127@lothringen>
 <20220311152148.GF4285@paulmck-ThinkPad-P17-Gen-1>
 <20220311154603.GC227945@lothringen>
 <20220311160619.GG4285@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220311160619.GG4285@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2022 at 08:06:19AM -0800, Paul E. McKenney wrote:
> On Fri, Mar 11, 2022 at 04:46:03PM +0100, Frederic Weisbecker wrote:
> > On Fri, Mar 11, 2022 at 07:21:48AM -0800, Paul E. McKenney wrote:
> > > On Fri, Mar 11, 2022 at 02:07:19PM +0100, Frederic Weisbecker wrote:
> > > > On Thu, Mar 10, 2022 at 02:52:19PM -0800, Paul E. McKenney wrote:
> > > > > On Thu, Mar 10, 2022 at 11:41:03PM +0100, Frederic Weisbecker wrote:
> > > > > > On Thu, Mar 10, 2022 at 01:56:30PM -0800, Paul E. McKenney wrote:
> > > > > > > Hello, Frederic,
> > > > > > > 
> > > > > > > I recently added CONFIG_PREEMPT_DYNAMIC=n to the TREE07 file, and since
> > > > > > > then am getting roughly one RCU CPU stall warning (or silent hang)
> > > > > > > per few tens of hours of rcutorture testing on dual-socket systems.
> > > > > > > The stall warnings feature starvation of RCU grace-period kthread.
> > > > > > > 
> > > > > > > Any advice on debugging this?
> > > > > > 
> > > > > > Oh, I'm testing that!
> > > > > 
> > > > > Even better, thank you!  ;-)
> > > > 
> > > > Here is what I'm testing below. If it happens to work though, it's still not
> > > > the most optimized way of dealing with the UP on SMP situation as we still start
> > > > an exp grace period when we could early return. But since we have a cookie
> > > > to pass to poll_state_synchronize_rcu_expedited()...
> > > > 
> > > > Oh but if we were to early check a positive rcu_blocking_is_gp() from
> > > > start_poll_synchronize_rcu_expedited(),
> > > > we could simply return the current value of rcu_state.expedited_sequence without
> > > > doing an rcu_exp_gp_seq_snap() and then pass that to
> > > > poll_state_synchronize_rcu_expedited() which should then immediately return.
> > > > 
> > > > Now even if we do that, we still need the below in case the CPUs went offline
> > > > in the middle of start_poll_synchronize_rcu_expedited() (again, assuming this
> > > > fixes the issue. I'm running the test).
> > > 
> > > Color me slow and stupid!!!
> > > 
> > > So the reason that this works for CONFIG_PREEMPT_DYNAMIC=y is that
> > > the rcu_blocking_is_gp() was never updated to account for this.
> > > 
> > > The first "if" in rcu_blocking_is_gp() needs to become something like
> > > this:
> > > 
> > > 	if (!preemption_boot_enabled())
> > > 
> > > Where:
> > > 
> > > 	bool preemption_boot_enabled(void)
> > > 	{
> > > 	#ifdef CONFIG_PREEMPT_DYNAMIC
> > > 		return preempt_dynamic_mode == preempt_dynamic_full;
> > > 	#else
> > > 		return IS_ENABLED(CONFIG_PREEMPTION);
> > > 	#endif
> > > 	}
> > > 
> > > Or am I missing something here?
> > 
> > Oh right there is that too!
> 
> I am testing with that fastpath completely commented out, just to make
> sure that we were seeing the same failure.
> 
> > I think we need to apply this patch:
> > https://lore.kernel.org/lkml/20211110202448.4054153-3-valentin.schneider@arm.com/
> > and then your above change. I can cook a series with the below.
> 
> Agreed, Valentin's approach is better than my preemption_boot_enabled().
> But when will CONFIG_PREEMPT_RT be boot-time selectable?  (/me runs!)
> 
> Looking forward to your series!

And there is one more issue with this code.  Someone invoking
get_state_synchronize_rcu_expedited() in one task might naively expect
that calls to synchronize_rcu_expedited() in some other task would cause
a later poll_state_synchronize_rcu_expedited() would return true.

Except that if CONFIG_PREEMPT_NONE=y and there is only one CPU, those
calls to synchronize_rcu_expedited() won't be helping at all.

I could imagine poll_state_synchronize_rcu_expedited() setting a
global flag if there is only one CPU, which could be checked by
__synchronize_rcu_expedited() and reset.

Is there a better way?

							Thanx, Paul

> > > > ---
> > > > >From 3c9f5df000b9659edbcf38cb87136fea1f8ac682 Mon Sep 17 00:00:00 2001
> > > > From: Frederic Weisbecker <frederic@kernel.org>
> > > > Date: Fri, 11 Mar 2022 13:30:02 +0100
> > > > Subject: [PATCH] rcu: Fix rcu exp polling
> > > > 
> > > > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > > > ---
> > > >  kernel/rcu/tree_exp.h | 52 ++++++++++++++++++++++++-------------------
> > > >  1 file changed, 29 insertions(+), 23 deletions(-)
> > > > 
> > > > diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> > > > index d5f30085b0cf..69c4dcc9159a 100644
> > > > --- a/kernel/rcu/tree_exp.h
> > > > +++ b/kernel/rcu/tree_exp.h
> > > > @@ -794,27 +794,7 @@ static int rcu_print_task_exp_stall(struct rcu_node *rnp)
> > > >  
> > > >  #endif /* #else #ifdef CONFIG_PREEMPT_RCU */
> > > >  
> > > > -/**
> > > > - * synchronize_rcu_expedited - Brute-force RCU grace period
> > > > - *
> > > > - * Wait for an RCU grace period, but expedite it.  The basic idea is to
> > > > - * IPI all non-idle non-nohz online CPUs.  The IPI handler checks whether
> > > > - * the CPU is in an RCU critical section, and if so, it sets a flag that
> > > > - * causes the outermost rcu_read_unlock() to report the quiescent state
> > > > - * for RCU-preempt or asks the scheduler for help for RCU-sched.  On the
> > > > - * other hand, if the CPU is not in an RCU read-side critical section,
> > > > - * the IPI handler reports the quiescent state immediately.
> > > > - *
> > > > - * Although this is a great improvement over previous expedited
> > > > - * implementations, it is still unfriendly to real-time workloads, so is
> > > > - * thus not recommended for any sort of common-case code.  In fact, if
> > > > - * you are using synchronize_rcu_expedited() in a loop, please restructure
> > > > - * your code to batch your updates, and then use a single synchronize_rcu()
> > > > - * instead.
> > > > - *
> > > > - * This has the same semantics as (but is more brutal than) synchronize_rcu().
> > > > - */
> > > > -void synchronize_rcu_expedited(void)
> > > 
> > > We should have a header comment here.  Given that I missed the need for
> > > this, for example.  ;-)
> > > 
> > > But feel free to send a formal patch without it, and I can add it.
> > > 
> > > Otherwise, it looks good.
> > 
> > Ok, preparing this.
> > 
> > Thanks!
