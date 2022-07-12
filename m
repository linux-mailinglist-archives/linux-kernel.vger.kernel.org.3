Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 077F857282E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 23:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbiGLVCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 17:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233470AbiGLVBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 17:01:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A81CEBD385;
        Tue, 12 Jul 2022 13:58:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 45810B81BDC;
        Tue, 12 Jul 2022 20:58:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A34EC3411C;
        Tue, 12 Jul 2022 20:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657659535;
        bh=95wTQGxdY3JAMeghe4pZTklJo1uL30E/1xAwZRg6/7o=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=mtZnShCXpF/w0QIX0/Lodv4DjBfOkKlLoQ6t51a9ZkKUW/yKhBxodUqzvKMny5dwZ
         5i/8t/EBQjyTYdl+Z/kQyD2Y/AUSX5I3GKdTfNVPQFGbxIUlXw1q3/blQAccAF5lMG
         KCoNQNRoLc6kiRAG88x1XjX8mk8MerLwLWp25SZs63PhgzEN/0fZkgMznKZYFkOGvx
         k6gbP9Fr4AbLjOt9ogXoPi90KwUujS/bPs/EupbQ0fcQPa4TltjUgi4I4Mltc9V/P6
         ZvEbsQqq8V1/10T9tqVl1zQrc+gr4WXjMeXvmrYhuRRmPiw92SBf54tSLrEDaNmXPi
         smxXzhbDaI8KQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A59DD5C08C7; Tue, 12 Jul 2022 13:58:54 -0700 (PDT)
Date:   Tue, 12 Jul 2022 13:58:54 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     rcu <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Rushikesh S Kadam <rushikesh.s.kadam@intel.com>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, vineeth@bitbyteword.org
Subject: Re: [PATCH v2 6/8] rcuscale: Add test for using call_rcu_lazy() to
 emulate kfree_rcu()
Message-ID: <20220712205854.GE1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220622225102.2112026-1-joel@joelfernandes.org>
 <20220622225102.2112026-8-joel@joelfernandes.org>
 <20220626041327.GN1790663@paulmck-ThinkPad-P17-Gen-1>
 <YsexpcG2iaplKPIs@google.com>
 <20220708230600.GC1790663@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YS8hrT78JG_2uQX38oaF5TEGz-M3EgJ2PWjx8g+cfmhBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YS8hrT78JG_2uQX38oaF5TEGz-M3EgJ2PWjx8g+cfmhBw@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 04:27:05PM -0400, Joel Fernandes wrote:
> Ah, with all the threads, I missed this one :(. Sorry about that.

I know that feeling...

> On Fri, Jul 8, 2022 at 7:06 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> 
> > > Currently I added a test like the following which adds a new torture type, my
> > > thought was to stress the new code to make sure nothing crashed or hung the
> > > kernel. That is working well except I don't exactly understand the total-gps
> > > print showing 0, which the other print shows 1188 GPs. I'll go dig into that
> > > tomorrow.. thanks!
> > >
> > > The print shows
> > > TREE11 ------- 1474 GPs (12.2833/s) [rcu_lazy: g0 f0x0 total-gps=0]
> > > TREE11 no success message, 7 successful version messages
> >
> > Nice!!!  It is very good to see you correctly using the rcu_torture_ops
> > facility correctly!
> >
> > And this could be good for your own testing, and I am happy to pull it
> > in for that purpose (given it being fixed, having a good commit log,
> > and so on).  After all, TREE10 is quite similar -- not part of CFLIST,
> > but useful for certain types of focused testing.
> >
> > However, it would be very good to get call_rcu_lazy() testing going
> > more generally, and in particular in TREE01 where offloading changes
> > dynamically.  A good way to do this is to add a .call_lazy() component
> > to the rcu_torture_ops structure, and check for it in a manner similar
> > to that done for the .deferred_free() component.  Including adding a
> > gp_normal_lazy module parameter.  This would allow habitual testing
> > on a few scenarios and focused lazy testing on all of them via the
> > --bootargs parameter.
> 
> Ok, if you don't mind I will make this particular enhancement to the
> torture test in a future patchset, since I kind of decided on doing v3
> with just fixes to what I have and more testing. Certainly happy to
> enhance these tests in a future version.

No need to gate v3 on those tests.

> > On the total-gps=0, the usual suspicion would be that the lazy callbacks
> > never got invoked.  It looks like you were doing about a two-minute run,
> > so maybe a longer run?  Though weren't they supposed to kick in at 15
> > seconds or so?  Or did this value of zero come about because this run
> > used exactly 300 grace periods?
> 
> It was zero because it required the RCU_FLAVOR torture type, where as
> my torture type was lazy. Adding RCU_LAZY_FLAVOR to the list fixed it
> :)

Heh!  Then it didn't actually do any testing.  Done that as well!

							Thanx, Paul

> Thanks!
> 
>  - Joel
> 
> 
> > > diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> > > index 7120165a9342..cc6b7392d801 100644
> > > --- a/kernel/rcu/rcutorture.c
> > > +++ b/kernel/rcu/rcutorture.c
> > > @@ -872,6 +872,64 @@ static struct rcu_torture_ops tasks_rude_ops = {
> > >
> > >  #endif // #else #ifdef CONFIG_TASKS_RUDE_RCU
> > >
> > > +#ifdef CONFIG_RCU_LAZY
> > > +
> > > +/*
> > > + * Definitions for lazy RCU torture testing.
> > > + */
> > > +unsigned long orig_jiffies_till_flush;
> > > +
> > > +static void rcu_sync_torture_init_lazy(void)
> > > +{
> > > +     rcu_sync_torture_init();
> > > +
> > > +     orig_jiffies_till_flush = rcu_lazy_get_jiffies_till_flush();
> > > +     rcu_lazy_set_jiffies_till_flush(50);
> > > +}
> > > +
> > > +static void rcu_lazy_cleanup(void)
> > > +{
> > > +     rcu_lazy_set_jiffies_till_flush(orig_jiffies_till_flush);
> > > +}
> > > +
> > > +static struct rcu_torture_ops rcu_lazy_ops = {
> > > +     .ttype                  = RCU_LAZY_FLAVOR,
> > > +     .init                   = rcu_sync_torture_init_lazy,
> > > +     .cleanup                = rcu_lazy_cleanup,
> > > +     .readlock               = rcu_torture_read_lock,
> > > +     .read_delay             = rcu_read_delay,
> > > +     .readunlock             = rcu_torture_read_unlock,
> > > +     .readlock_held          = torture_readlock_not_held,
> > > +     .get_gp_seq             = rcu_get_gp_seq,
> > > +     .gp_diff                = rcu_seq_diff,
> > > +     .deferred_free          = rcu_torture_deferred_free,
> > > +     .sync                   = synchronize_rcu,
> > > +     .exp_sync               = synchronize_rcu_expedited,
> > > +     .get_gp_state           = get_state_synchronize_rcu,
> > > +     .start_gp_poll          = start_poll_synchronize_rcu,
> > > +     .poll_gp_state          = poll_state_synchronize_rcu,
> > > +     .cond_sync              = cond_synchronize_rcu,
> > > +     .call                   = call_rcu_lazy,
> > > +     .cb_barrier             = rcu_barrier,
> > > +     .fqs                    = rcu_force_quiescent_state,
> > > +     .stats                  = NULL,
> > > +     .gp_kthread_dbg         = show_rcu_gp_kthreads,
> > > +     .check_boost_failed     = rcu_check_boost_fail,
> > > +     .stall_dur              = rcu_jiffies_till_stall_check,
> > > +     .irq_capable            = 1,
> > > +     .can_boost              = IS_ENABLED(CONFIG_RCU_BOOST),
> > > +     .extendables            = RCUTORTURE_MAX_EXTEND,
> > > +     .name                   = "rcu_lazy"
> > > +};
> > > +
> > > +#define LAZY_OPS &rcu_lazy_ops,
> > > +
> > > +#else // #ifdef CONFIG_RCU_LAZY
> > > +
> > > +#define LAZY_OPS
> > > +
> > > +#endif // #else #ifdef CONFIG_RCU_LAZY
> > > +
> > >
> > >  #ifdef CONFIG_TASKS_TRACE_RCU
> > >
> > > @@ -3145,7 +3203,7 @@ rcu_torture_init(void)
> > >       unsigned long gp_seq = 0;
> > >       static struct rcu_torture_ops *torture_ops[] = {
> > >               &rcu_ops, &rcu_busted_ops, &srcu_ops, &srcud_ops, &busted_srcud_ops,
> > > -             TASKS_OPS TASKS_RUDE_OPS TASKS_TRACING_OPS
> > > +             TASKS_OPS TASKS_RUDE_OPS TASKS_TRACING_OPS LAZY_OPS
> > >               &trivial_ops,
> > >       };
> > >
> > > diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE11 b/tools/testing/selftests/rcutorture/configs/rcu/TREE11
> > > new file mode 100644
> > > index 000000000000..436013f3e015
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE11
> > > @@ -0,0 +1,18 @@
> > > +CONFIG_SMP=y
> > > +CONFIG_PREEMPT_NONE=n
> > > +CONFIG_PREEMPT_VOLUNTARY=n
> > > +CONFIG_PREEMPT=y
> > > +#CHECK#CONFIG_PREEMPT_RCU=y
> > > +CONFIG_HZ_PERIODIC=n
> > > +CONFIG_NO_HZ_IDLE=y
> > > +CONFIG_NO_HZ_FULL=n
> > > +CONFIG_RCU_TRACE=y
> > > +CONFIG_HOTPLUG_CPU=y
> > > +CONFIG_MAXSMP=y
> > > +CONFIG_CPUMASK_OFFSTACK=y
> > > +CONFIG_RCU_NOCB_CPU=y
> > > +CONFIG_DEBUG_LOCK_ALLOC=n
> > > +CONFIG_RCU_BOOST=n
> > > +CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
> > > +CONFIG_RCU_EXPERT=y
> > > +CONFIG_RCU_LAZY=y
> > > diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE11.boot b/tools/testing/selftests/rcutorture/configs/rcu/TREE11.boot
> > > new file mode 100644
> > > index 000000000000..9b6f720d4ccd
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE11.boot
> > > @@ -0,0 +1,8 @@
> > > +maxcpus=8 nr_cpus=43
> > > +rcutree.gp_preinit_delay=3
> > > +rcutree.gp_init_delay=3
> > > +rcutree.gp_cleanup_delay=3
> > > +rcu_nocbs=0-7
> > > +rcutorture.torture_type=rcu_lazy
> > > +rcutorture.nocbs_nthreads=8
> > > +rcutorture.fwd_progress=0
> > > --
> > > 2.37.0.rc0.161.g10f37bed90-goog
> > >
