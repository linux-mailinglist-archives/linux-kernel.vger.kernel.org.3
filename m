Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 281FA56C48F
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237981AbiGHXGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 19:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232561AbiGHXGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 19:06:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6DF237196;
        Fri,  8 Jul 2022 16:06:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5FF8E6228C;
        Fri,  8 Jul 2022 23:06:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A96ECC341C0;
        Fri,  8 Jul 2022 23:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657321560;
        bh=iq3+qkgxISrmsW77SppHM1TflQly/C6hvP98TkXXAuY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=OxeVJ4CRidknUVJo1ehgzJYni2Ruz63eRXSDIZmDHCstaEaw4rKB5yGQ7V+ASLRDf
         GmqmmxMzDeDIVxN1Q/u2Bw/Ms3BD+UXEQvNHJbE3v72bQGxK1eyTnDZV/7SHNKHM9U
         mJnsmUbESL7RJ2XRwGmKdEx+CgN8Q3BKEAnMApPymeQUmsTwNnbX11PNnQEPwfx2+A
         y3ZmVdnGlKyxRxSM9+lsnxZBs07tdEAx4LSfBPQKLBTrAm1LMA8MsuqW0ShiCeGkGQ
         bQ5cnHGqW2WyTQw50FJwHsyUb9kxpd32IGBhARN4wLvcPAI76uH/05XWI/Qm1aGAyB
         +Bf0/A66sCdFg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 43EB25C0835; Fri,  8 Jul 2022 16:06:00 -0700 (PDT)
Date:   Fri, 8 Jul 2022 16:06:00 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, rostedt@goodmis.org,
        vineeth@bitbyteword.org
Subject: Re: [PATCH v2 6/8] rcuscale: Add test for using call_rcu_lazy() to
 emulate kfree_rcu()
Message-ID: <20220708230600.GC1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220622225102.2112026-1-joel@joelfernandes.org>
 <20220622225102.2112026-8-joel@joelfernandes.org>
 <20220626041327.GN1790663@paulmck-ThinkPad-P17-Gen-1>
 <YsexpcG2iaplKPIs@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YsexpcG2iaplKPIs@google.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 08, 2022 at 04:25:09AM +0000, Joel Fernandes wrote:
> On Sat, Jun 25, 2022 at 09:13:27PM -0700, Paul E. McKenney wrote:
> > On Wed, Jun 22, 2022 at 10:51:00PM +0000, Joel Fernandes (Google) wrote:
> > > Reuse the kfree_rcu() test in order to be able to compare the memory reclaiming
> > > properties of call_rcu_lazy() with kfree_rcu().
> > > 
> > > With this test, we find similar memory footprint and time call_rcu_lazy()
> > > free'ing takes compared to kfree_rcu(). Also we confirm that call_rcu_lazy()
> > > can survive OOM during extremely frequent calls.
> > > 
> > > If we really push it, i.e. boot system with low memory and compare
> > > kfree_rcu() with call_rcu_lazy(), I find that call_rcu_lazy() is more
> > > resilient and is much harder to produce OOM as compared to kfree_rcu().
> > 
> > Another approach would be to make rcutorture's forward-progress testing
> > able to use call_rcu_lazy().  This would test lazy callback flooding.
> > 
> > Yet another approach would be to keep one CPU idle other than a
> > kthread doing call_rcu_lazy().  Of course "idle" includes redirecting
> > those pesky interrupts.
> > 
> > It is almost certainly necessary for rcutorture to exercise the
> > call_rcu_lazy() path regularly.
> 
> Currently I added a test like the following which adds a new torture type, my
> thought was to stress the new code to make sure nothing crashed or hung the
> kernel. That is working well except I don't exactly understand the total-gps
> print showing 0, which the other print shows 1188 GPs. I'll go dig into that
> tomorrow.. thanks!
> 
> The print shows
> TREE11 ------- 1474 GPs (12.2833/s) [rcu_lazy: g0 f0x0 total-gps=0]
> TREE11 no success message, 7 successful version messages

Nice!!!  It is very good to see you correctly using the rcu_torture_ops
facility correctly!

And this could be good for your own testing, and I am happy to pull it
in for that purpose (given it being fixed, having a good commit log,
and so on).  After all, TREE10 is quite similar -- not part of CFLIST,
but useful for certain types of focused testing.

However, it would be very good to get call_rcu_lazy() testing going
more generally, and in particular in TREE01 where offloading changes
dynamically.  A good way to do this is to add a .call_lazy() component
to the rcu_torture_ops structure, and check for it in a manner similar
to that done for the .deferred_free() component.  Including adding a
gp_normal_lazy module parameter.  This would allow habitual testing
on a few scenarios and focused lazy testing on all of them via the
--bootargs parameter.

On the total-gps=0, the usual suspicion would be that the lazy callbacks
never got invoked.  It looks like you were doing about a two-minute run,
so maybe a longer run?  Though weren't they supposed to kick in at 15
seconds or so?  Or did this value of zero come about because this run
used exactly 300 grace periods?

							Thanx, Paul

> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> index 7120165a9342..cc6b7392d801 100644
> --- a/kernel/rcu/rcutorture.c
> +++ b/kernel/rcu/rcutorture.c
> @@ -872,6 +872,64 @@ static struct rcu_torture_ops tasks_rude_ops = {
>  
>  #endif // #else #ifdef CONFIG_TASKS_RUDE_RCU
>  
> +#ifdef CONFIG_RCU_LAZY
> +
> +/*
> + * Definitions for lazy RCU torture testing.
> + */
> +unsigned long orig_jiffies_till_flush;
> +
> +static void rcu_sync_torture_init_lazy(void)
> +{
> +	rcu_sync_torture_init();
> +
> +	orig_jiffies_till_flush = rcu_lazy_get_jiffies_till_flush();
> +	rcu_lazy_set_jiffies_till_flush(50);
> +}
> +
> +static void rcu_lazy_cleanup(void)
> +{
> +	rcu_lazy_set_jiffies_till_flush(orig_jiffies_till_flush);
> +}
> +
> +static struct rcu_torture_ops rcu_lazy_ops = {
> +	.ttype			= RCU_LAZY_FLAVOR,
> +	.init			= rcu_sync_torture_init_lazy,
> +	.cleanup		= rcu_lazy_cleanup,
> +	.readlock		= rcu_torture_read_lock,
> +	.read_delay		= rcu_read_delay,
> +	.readunlock		= rcu_torture_read_unlock,
> +	.readlock_held		= torture_readlock_not_held,
> +	.get_gp_seq		= rcu_get_gp_seq,
> +	.gp_diff		= rcu_seq_diff,
> +	.deferred_free		= rcu_torture_deferred_free,
> +	.sync			= synchronize_rcu,
> +	.exp_sync		= synchronize_rcu_expedited,
> +	.get_gp_state		= get_state_synchronize_rcu,
> +	.start_gp_poll		= start_poll_synchronize_rcu,
> +	.poll_gp_state		= poll_state_synchronize_rcu,
> +	.cond_sync		= cond_synchronize_rcu,
> +	.call			= call_rcu_lazy,
> +	.cb_barrier		= rcu_barrier,
> +	.fqs			= rcu_force_quiescent_state,
> +	.stats			= NULL,
> +	.gp_kthread_dbg		= show_rcu_gp_kthreads,
> +	.check_boost_failed	= rcu_check_boost_fail,
> +	.stall_dur		= rcu_jiffies_till_stall_check,
> +	.irq_capable		= 1,
> +	.can_boost		= IS_ENABLED(CONFIG_RCU_BOOST),
> +	.extendables		= RCUTORTURE_MAX_EXTEND,
> +	.name			= "rcu_lazy"
> +};
> +
> +#define LAZY_OPS &rcu_lazy_ops,
> +
> +#else // #ifdef CONFIG_RCU_LAZY
> +
> +#define LAZY_OPS
> +
> +#endif // #else #ifdef CONFIG_RCU_LAZY
> +
>  
>  #ifdef CONFIG_TASKS_TRACE_RCU
>  
> @@ -3145,7 +3203,7 @@ rcu_torture_init(void)
>  	unsigned long gp_seq = 0;
>  	static struct rcu_torture_ops *torture_ops[] = {
>  		&rcu_ops, &rcu_busted_ops, &srcu_ops, &srcud_ops, &busted_srcud_ops,
> -		TASKS_OPS TASKS_RUDE_OPS TASKS_TRACING_OPS
> +		TASKS_OPS TASKS_RUDE_OPS TASKS_TRACING_OPS LAZY_OPS
>  		&trivial_ops,
>  	};
>  
> diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE11 b/tools/testing/selftests/rcutorture/configs/rcu/TREE11
> new file mode 100644
> index 000000000000..436013f3e015
> --- /dev/null
> +++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE11
> @@ -0,0 +1,18 @@
> +CONFIG_SMP=y
> +CONFIG_PREEMPT_NONE=n
> +CONFIG_PREEMPT_VOLUNTARY=n
> +CONFIG_PREEMPT=y
> +#CHECK#CONFIG_PREEMPT_RCU=y
> +CONFIG_HZ_PERIODIC=n
> +CONFIG_NO_HZ_IDLE=y
> +CONFIG_NO_HZ_FULL=n
> +CONFIG_RCU_TRACE=y
> +CONFIG_HOTPLUG_CPU=y
> +CONFIG_MAXSMP=y
> +CONFIG_CPUMASK_OFFSTACK=y
> +CONFIG_RCU_NOCB_CPU=y
> +CONFIG_DEBUG_LOCK_ALLOC=n
> +CONFIG_RCU_BOOST=n
> +CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
> +CONFIG_RCU_EXPERT=y
> +CONFIG_RCU_LAZY=y
> diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE11.boot b/tools/testing/selftests/rcutorture/configs/rcu/TREE11.boot
> new file mode 100644
> index 000000000000..9b6f720d4ccd
> --- /dev/null
> +++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE11.boot
> @@ -0,0 +1,8 @@
> +maxcpus=8 nr_cpus=43
> +rcutree.gp_preinit_delay=3
> +rcutree.gp_init_delay=3
> +rcutree.gp_cleanup_delay=3
> +rcu_nocbs=0-7
> +rcutorture.torture_type=rcu_lazy
> +rcutorture.nocbs_nthreads=8
> +rcutorture.fwd_progress=0
> -- 
> 2.37.0.rc0.161.g10f37bed90-goog
> 
