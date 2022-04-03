Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E30884F0CD0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 00:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376588AbiDCWoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 18:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235976AbiDCWoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 18:44:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB4238793;
        Sun,  3 Apr 2022 15:42:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2291060F34;
        Sun,  3 Apr 2022 22:42:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52F9BC340ED;
        Sun,  3 Apr 2022 22:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649025723;
        bh=NNchkUU2qzPgBv8/S4N2bywSy5Vkl1Sj16/7rZHH9WU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=NbEbaTOdb26mhTzgjIotpWJF5f9dHUeYNJj9jsy7kJcXYZWm845Y3gisJ5kuF6o0l
         oaPdV0fFO20zfA9R7MPTEA9B3C9nNSZK/xA8EB058IK9Djc0htJNPWqY0LTD42weDY
         5ZHfVqcFmD8m5ktP+VoT17DIqhQFWE9QSvqmEPS0MMPIeNogWWWIAyRELLNN/+Uirh
         wDRYOee0zeT44t9IYpL6ByTALGr3dGLOxa/LdADeYyQbGie99w25nGKH9ZEbwRV8ff
         K6U6nms022IwW013YhzrxnMryrsO88sVCLX0BSF6oasJDVVM9NxxhEI8IXgJ6nX/Za
         iGCYXikxAQZEg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E182A5C0E58; Sun,  3 Apr 2022 15:42:02 -0700 (PDT)
Date:   Sun, 3 Apr 2022 15:42:02 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Tejun Heo <tj@kernel.org>, Tim Murray <timmurray@google.com>,
        Wei Wang <wvw@google.com>, Kyle Lin <kylelin@google.com>,
        Chunwei Lu <chunweilu@google.com>,
        Lulu Wang <luluw@google.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RCU: Move expedited grace period (GP) work to RT
 kthread_worker
Message-ID: <20220403224202.GQ4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220401225740.1984689-1-kaleshsingh@google.com>
 <20220402003021.GI4285@paulmck-ThinkPad-P17-Gen-1>
 <CAC_TJvceeXW6b__nmYfq_3XpE4H7mpU4HuTq7moQhC1ZrDG1Zg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAC_TJvceeXW6b__nmYfq_3XpE4H7mpU4HuTq7moQhC1ZrDG1Zg@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 03, 2022 at 03:20:12PM -0700, Kalesh Singh wrote:
> On Fri, Apr 1, 2022 at 5:30 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Fri, Apr 01, 2022 at 03:57:40PM -0700, Kalesh Singh wrote:
> > > It was noticed that enabling CONFIG_RCU_BOOST did not help RCU
> > > performance because the workqueues that runs expedited GP work are
> > > subject to scheduling delays. This patch moves the expedited GP
> > > work items to RT kthread_worker.
> > >
> > > The results were evaluated on arm64 Android devices (6GB ram) running
> > > 5.10 kernel, and caturing trace data during critical user journeys.
> > >
> > > The table below compares the time synchronize_rcu_expedited() is blocked:
> > >
> > >  ----------------------------------------------------------------------
> > > |                   |      Using WQ    | Using kthead_worker |  Diff   |
> > > -----------------------------------------------------------------------
> > > | Max duration (ns) |    372766967     |     2329671         | -99.38% |
> > > -----------------------------------------------------------------------
> > > | Avg duration (ns) |      2746353.16  |      151242.311     | -94.49% |
> > >  ----------------------------------------------------------------------
> >
> > Impressive reductions in latency!!!  151 microsecond average and two
> > millisecond maximum, not bad at all.  ;-)
> 
> Hi Paul. Thanks for the detailed review.
> 
> >
> > We will need number of samples and some sort of information on variation,
> > for example, a range of maximums and a standard deviation to go with
> > the average.  These might seem silly given that you have up to two orders
> > of magnitude effect sizes, but we should still set a good example.
> >
> > I have queued this on an experimental -rcu branch fastexp.2022.04.01a for
> > testing purposes, but I cannot send it upstream in this form.  However,
> > I believe that a few adjustments can make it into something that can be
> > upstreamed, maybe even as early as the next (v5.19) merge window.
> 
> Agreed, I'll provide the additional data with v2.

Sounds good!  Looking forward to seeing it!

> > As in I probably will need to revert it after running tests, but let's
> > see how it goes.
> >
> > Please see below for questions and comments.
> >
> > Also, as usual, I could not resist the urge to do a bit of wordsmithing,
> > most especially inserting commas into the big numbers.  Please see the
> > end of this email for the variant queued.
> >
> > Oh, and I do have Uladzislau's CONFIG_RCU_EXP_CPU_STALL_TIMEOUT commit
> > already queued, which will be helpful in finding overly long RCU read-side
> > critical sections.
> >
> > Good stuff!!!
> >
> >                                                         Thanx, Paul
> >
> > > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > > Cc: Tejun Heo <tj@kernel.org>
> > > Reported-by: Tim Murray <timmurray@google.com>
> > > Reported-by: Wei Wang <wvw@google.com>
> > > Tested-by: Kyle Lin <kylelin@google.com>
> > > Tested-by: Chunwei Lu <chunweilu@google.com>
> > > Tested-by: Lulu Wang <luluw@google.com>
> > > Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> > > ---
> > >  kernel/rcu/rcu.h      |  3 ++-
> > >  kernel/rcu/tree.c     | 41 +++++++++++++++++++++++++++++++++++++----
> > >  kernel/rcu/tree.h     |  3 ++-
> > >  kernel/rcu/tree_exp.h | 35 +++++++++++++++--------------------
> > >  4 files changed, 56 insertions(+), 26 deletions(-)
> > >
> > > diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> > > index 24b5f2c2de87..13d2b74bf19f 100644
> > > --- a/kernel/rcu/rcu.h
> > > +++ b/kernel/rcu/rcu.h
> > > @@ -534,7 +534,8 @@ int rcu_get_gp_kthreads_prio(void);
> > >  void rcu_fwd_progress_check(unsigned long j);
> > >  void rcu_force_quiescent_state(void);
> > >  extern struct workqueue_struct *rcu_gp_wq;
> > > -extern struct workqueue_struct *rcu_par_gp_wq;
> > > +extern struct kthread_worker *rcu_exp_gp_kworker;
> > > +extern struct kthread_worker *rcu_exp_par_gp_kworker;
> > >  #endif /* #else #ifdef CONFIG_TINY_RCU */
> > >
> > >  #ifdef CONFIG_RCU_NOCB_CPU
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index a4b8189455d5..bd5e672ffa5a 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -4471,6 +4471,33 @@ static int rcu_pm_notify(struct notifier_block *self,
> > >       return NOTIFY_OK;
> > >  }
> > >
> > > +struct kthread_worker *rcu_exp_gp_kworker;
> > > +struct kthread_worker *rcu_exp_par_gp_kworker;
> > > +
> > > +static void __init rcu_start_exp_gp_kworkers(void)
> > > +{
> > > +     const char *par_gp_kworker_name = "rcu_exp_par_gp_kthread_worker";
> > > +     const char *gp_kworker_name = "rcu_exp_gp_kthread_worker";
> > > +     struct sched_param param = { .sched_priority = kthread_prio };
> > > +
> > > +     rcu_exp_gp_kworker = kthread_create_worker(0, gp_kworker_name);
> > > +     if (IS_ERR_OR_NULL(rcu_exp_gp_kworker)) {
> > > +             pr_err("Failed to create %s!\n", gp_kworker_name);
> > > +             return;
> > > +     }
> > > +
> > > +     rcu_exp_par_gp_kworker = kthread_create_worker(0, par_gp_kworker_name);
> > > +     if (IS_ERR_OR_NULL(rcu_exp_par_gp_kworker)) {
> > > +             pr_err("Failed to create %s!\n", par_gp_kworker_name);
> > > +             kthread_destroy_worker(rcu_exp_gp_kworker);
> > > +             return;
> > > +     }
> > > +
> > > +     sched_setscheduler_nocheck(rcu_exp_gp_kworker->task, SCHED_FIFO, &param);
> > > +     sched_setscheduler_nocheck(rcu_exp_par_gp_kworker->task, SCHED_FIFO,
> > > +                                &param);
> >
> > What happens when kthread_prio is zero, as it is by default on systems
> > built with CONFIG_RCU_BOOST=n?
> >
> > My guess is that we need to use normal workqueues when CONFIG_RCU_BOOST=n.
> >
> > The real-time guys usually completely disable expedited grace periods
> > except during boot, so they might also want normal workqueues as well.
> > They build with CONFIG_PREEMPT_RT=y.
> 
> Ack. Will make this dependent on RCU_BOOST && !PREEMPT_RT, else we'll
> fallback to work queues.

Sounds good!

> > > +}
> > > +
> > >  /*
> > >   * Spawn the kthreads that handle RCU's grace periods.
> > >   */
> > > @@ -4500,6 +4527,10 @@ static int __init rcu_spawn_gp_kthread(void)
> > >       rcu_spawn_nocb_kthreads();
> > >       rcu_spawn_boost_kthreads();
> > >       rcu_spawn_core_kthreads();
> > > +
> > > +     /* Create kthread worker for expedited GPs */
> > > +     rcu_start_exp_gp_kworkers();
> > > +
> > >       return 0;
> > >  }
> > >  early_initcall(rcu_spawn_gp_kthread);
> > > @@ -4745,7 +4776,6 @@ static void __init rcu_dump_rcu_node_tree(void)
> > >  }
> > >
> > >  struct workqueue_struct *rcu_gp_wq;
> > > -struct workqueue_struct *rcu_par_gp_wq;
> > >
> > >  static void __init kfree_rcu_batch_init(void)
> > >  {
> > > @@ -4808,11 +4838,14 @@ void __init rcu_init(void)
> > >               rcutree_online_cpu(cpu);
> > >       }
> > >
> > > -     /* Create workqueue for Tree SRCU and for expedited GPs. */
> > > +     /*
> > > +      * Create workqueue for Tree SRCU.
> > > +      *
> > > +      * Expedited GPs use RT kthread_worker.
> > > +      * See: rcu_start_exp_gp_kworkers()
> > > +      */
> > >       rcu_gp_wq = alloc_workqueue("rcu_gp", WQ_MEM_RECLAIM, 0);
> > >       WARN_ON(!rcu_gp_wq);
> > > -     rcu_par_gp_wq = alloc_workqueue("rcu_par_gp", WQ_MEM_RECLAIM, 0);
> > > -     WARN_ON(!rcu_par_gp_wq);
> > >
> > >       /* Fill in default value for rcutree.qovld boot parameter. */
> > >       /* -After- the rcu_node ->lock fields are initialized! */
> > > diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
> > > index 926673ebe355..0193d67a706a 100644
> > > --- a/kernel/rcu/tree.h
> > > +++ b/kernel/rcu/tree.h
> > > @@ -10,6 +10,7 @@
> > >   */
> > >
> > >  #include <linux/cache.h>
> > > +#include <linux/kthread.h>
> > >  #include <linux/spinlock.h>
> > >  #include <linux/rtmutex.h>
> > >  #include <linux/threads.h>
> > > @@ -23,7 +24,7 @@
> > >  /* Communicate arguments to a workqueue handler. */
> > >  struct rcu_exp_work {
> > >       unsigned long rew_s;
> > > -     struct work_struct rew_work;
> > > +     struct kthread_work rew_work;
> > >  };
> > >
> > >  /* RCU's kthread states for tracing. */
> > > diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> > > index 60197ea24ceb..f5f3722c0a74 100644
> > > --- a/kernel/rcu/tree_exp.h
> > > +++ b/kernel/rcu/tree_exp.h
> > > @@ -334,7 +334,7 @@ static bool exp_funnel_lock(unsigned long s)
> > >   * Select the CPUs within the specified rcu_node that the upcoming
> > >   * expedited grace period needs to wait for.
> > >   */
> > > -static void sync_rcu_exp_select_node_cpus(struct work_struct *wp)
> > > +static void sync_rcu_exp_select_node_cpus(struct kthread_work *wp)
> > >  {
> > >       int cpu;
> > >       unsigned long flags;
> > > @@ -423,7 +423,6 @@ static void sync_rcu_exp_select_node_cpus(struct work_struct *wp)
> > >   */
> > >  static void sync_rcu_exp_select_cpus(void)
> > >  {
> > > -     int cpu;
> > >       struct rcu_node *rnp;
> > >
> > >       trace_rcu_exp_grace_period(rcu_state.name, rcu_exp_gp_seq_endval(), TPS("reset"));
> > > @@ -435,28 +434,27 @@ static void sync_rcu_exp_select_cpus(void)
> > >               rnp->exp_need_flush = false;
> > >               if (!READ_ONCE(rnp->expmask))
> > >                       continue; /* Avoid early boot non-existent wq. */
> > > -             if (!READ_ONCE(rcu_par_gp_wq) ||
> > > +             if (!READ_ONCE(rcu_exp_par_gp_kworker) ||
> > >                   rcu_scheduler_active != RCU_SCHEDULER_RUNNING ||
> > >                   rcu_is_last_leaf_node(rnp)) {
> > > -                     /* No workqueues yet or last leaf, do direct call. */
> > > +                     /* kthread worker not started yet or last leaf, do direct call. */
> > >                       sync_rcu_exp_select_node_cpus(&rnp->rew.rew_work);
> > >                       continue;
> > >               }
> > > -             INIT_WORK(&rnp->rew.rew_work, sync_rcu_exp_select_node_cpus);
> > > -             cpu = find_next_bit(&rnp->ffmask, BITS_PER_LONG, -1);
> > > -             /* If all offline, queue the work on an unbound CPU. */
> > > -             if (unlikely(cpu > rnp->grphi - rnp->grplo))
> > > -                     cpu = WORK_CPU_UNBOUND;
> > > -             else
> > > -                     cpu += rnp->grplo;
> > > -             queue_work_on(cpu, rcu_par_gp_wq, &rnp->rew.rew_work);
> > > +             kthread_init_work(&rnp->rew.rew_work, sync_rcu_exp_select_node_cpus);
> > > +             /*
> > > +              * Use rcu_exp_par_gp_kworker, because flushing a work item from
> > > +              * another work item on the same kthread worker can result in
> > > +              * deadlock.
> > > +              */
> > > +             kthread_queue_work(rcu_exp_par_gp_kworker, &rnp->rew.rew_work);
> >
> > It looks like kthread_queue_work() uses a single lock per worker.  This is
> > likely to be problematic on large systems having multiple leaf rcu_node
> > structures, both due to lock contention and due to reduced concurrency.
> > For a point of reference, I have gotten RCU bug reports for issues on
> > systems with 256 leaf rcu_node structures.
> >
> > One approach would be to create a new Kconfig option to select the
> > kthread_queue implementation on small systems.  This Kconfig option
> > could choose its default based on system size, perhaps with 32 or
> > more CPUs continuing to use workqueues.  Or it could choose its
> > default based on CONFIG_ANDROID.
> 
> I was concerned about the reduced concurrency here but wasn't sure if
> it's a problem in practice. Thanks for the explanation. Your
> suggestion of using the number of CPUs makes sense to me (we want to
> avoid making it android specific if possible). Perhaps
> CONFIG_RCU_EXP_KTHREAD?

A CONFIG_RCU_EXP_KTHREAD would make sense.  If it is user-settable,
it needs to depend on CONFIG_RCU_EXPERT.  One big advantage of being
user-settable is that it provides an easy workaround should someone
somewhere run into problems with this change.

							Thanx, Paul

> Thanks,
> Kalesh
> 
> >
> > Another approach would be to have a separate kthread_worker for each
> > leaf rcu_node structure.
> >
> > The first approach would be safer in that it would avoid changing
> > behavior for systems not needing ultrafast expedited grace-period
> > latencies.  It might also make more sense for systems built with
> > CONFIG_PREEMPT_NONE=y or CONFIG_PREEMPT_VOLUNTARY=y.
> >
> > I don't see a reason to make this switchable at boot time, but others
> > might be able to provide good reasons.
> >
> > Either way, good encapsulation will of course be necessary.
> >
> > >               rnp->exp_need_flush = true;
> > >       }
> > >
> > >       /* Wait for workqueue jobs (if any) to complete. */
> > >       rcu_for_each_leaf_node(rnp)
> > >               if (rnp->exp_need_flush)
> > > -                     flush_work(&rnp->rew.rew_work);
> > > +                     kthread_flush_work(&rnp->rew.rew_work);
> > >  }
> > >
> > >  /*
> > > @@ -625,7 +623,7 @@ static void rcu_exp_sel_wait_wake(unsigned long s)
> > >  /*
> > >   * Work-queue handler to drive an expedited grace period forward.
> > >   */
> > > -static void wait_rcu_exp_gp(struct work_struct *wp)
> > > +static void wait_rcu_exp_gp(struct kthread_work *wp)
> > >  {
> > >       struct rcu_exp_work *rewp;
> > >
> > > @@ -848,20 +846,17 @@ void synchronize_rcu_expedited(void)
> > >       } else {
> > >               /* Marshall arguments & schedule the expedited grace period. */
> > >               rew.rew_s = s;
> > > -             INIT_WORK_ONSTACK(&rew.rew_work, wait_rcu_exp_gp);
> > > -             queue_work(rcu_gp_wq, &rew.rew_work);
> > > +             kthread_init_work(&rew.rew_work, wait_rcu_exp_gp);
> > > +             kthread_queue_work(rcu_exp_gp_kworker, &rew.rew_work);
> > >       }
> > >
> > >       /* Wait for expedited grace period to complete. */
> > >       rnp = rcu_get_root();
> > >       wait_event(rnp->exp_wq[rcu_seq_ctr(s) & 0x3],
> > >                  sync_exp_work_done(s));
> > > -     smp_mb(); /* Workqueue actions happen before return. */
> > > +     smp_mb(); /* kthread actions happen before return. */
> > >
> > >       /* Let the next expedited grace period start. */
> > >       mutex_unlock(&rcu_state.exp_mutex);
> > > -
> > > -     if (likely(!boottime))
> > > -             destroy_work_on_stack(&rew.rew_work);
> > >  }
> > >  EXPORT_SYMBOL_GPL(synchronize_rcu_expedited);
> > >
> > > base-commit: 7a3ecddc571cc3294e5d6bb5948ff2b0cfa12735
> > > --
> > > 2.35.1.1094.g7c7d902a7c-goog
> >
> > ------------------------------------------------------------------------
> >
> > commit d9f3e7d671416fdf5b61f094765754269b652db0
> > Author: Kalesh Singh <kaleshsingh@google.com>
> > Date:   Fri Apr 1 15:57:40 2022 -0700
> >
> >     EXP rcu: Move expedited grace period (GP) work to RT kthread_worker
> >
> >     Enabling CONFIG_RCU_BOOST did not reduce RCU expedited grace-period
> >     latency because its workqueues run at SCHED_OTHER, and thus can be
> >     delayed by normal processes.  This commit avoids these delays by moving
> >     the expedited GP work items to a real-time-priority kthread_worker.
> >
> >     The results were evaluated on arm64 Android devices (6GB ram) running
> >     5.10 kernel, and capturing trace data in critical user-level code.
> >
> >     The table below shows the resulting order-of-magnitude improvements
> >     in synchronize_rcu_expedited() latency:
> >
> >      ---------------------------------------------------------------
> >     |                   |   workqueues  |  kthead_worker  |    Diff |
> >     ----------------------------------------------------------------
> >     | Max duration (ns) |  372,766,967  |      2,329,671  | -99.38% |
> >     ----------------------------------------------------------------
> >     | Avg duration (ns) |    2,746,353  |        151,242  | -94.49% |
> >      ---------------------------------------------------------------
> >
> >     Cc: "Paul E. McKenney" <paulmck@kernel.org>
> >     Cc: Tejun Heo <tj@kernel.org>
> >     Reported-by: Tim Murray <timmurray@google.com>
> >     Reported-by: Wei Wang <wvw@google.com>
> >     Tested-by: Kyle Lin <kylelin@google.com>
> >     Tested-by: Chunwei Lu <chunweilu@google.com>
> >     Tested-by: Lulu Wang <luluw@google.com>
> >     Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> >     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> >
> > diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> > index 23c877fa220e..a7f6c6665b01 100644
> > --- a/kernel/rcu/rcu.h
> > +++ b/kernel/rcu/rcu.h
> > @@ -566,6 +566,8 @@ void rcu_fwd_progress_check(unsigned long j);
> >  void rcu_force_quiescent_state(void);
> >  extern struct workqueue_struct *rcu_gp_wq;
> >  extern struct workqueue_struct *rcu_par_gp_wq;
> > +extern struct kthread_worker *rcu_exp_gp_kworker;
> > +extern struct kthread_worker *rcu_exp_par_gp_kworker;
> >  void rcu_gp_slow_register(atomic_t *rgssp);
> >  void rcu_gp_slow_unregister(atomic_t *rgssp);
> >  #endif /* #else #ifdef CONFIG_TINY_RCU */
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 542cb514567f..2c7e714d34e9 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -4559,6 +4559,33 @@ static int rcu_pm_notify(struct notifier_block *self,
> >         return NOTIFY_OK;
> >  }
> >
> > +struct kthread_worker *rcu_exp_gp_kworker;
> > +struct kthread_worker *rcu_exp_par_gp_kworker;
> > +
> > +static void __init rcu_start_exp_gp_kworkers(void)
> > +{
> > +       const char *par_gp_kworker_name = "rcu_exp_par_gp_kthread_worker";
> > +       const char *gp_kworker_name = "rcu_exp_gp_kthread_worker";
> > +       struct sched_param param = { .sched_priority = kthread_prio };
> > +
> > +       rcu_exp_gp_kworker = kthread_create_worker(0, gp_kworker_name);
> > +       if (IS_ERR_OR_NULL(rcu_exp_gp_kworker)) {
> > +               pr_err("Failed to create %s!\n", gp_kworker_name);
> > +               return;
> > +       }
> > +
> > +       rcu_exp_par_gp_kworker = kthread_create_worker(0, par_gp_kworker_name);
> > +       if (IS_ERR_OR_NULL(rcu_exp_par_gp_kworker)) {
> > +               pr_err("Failed to create %s!\n", par_gp_kworker_name);
> > +               kthread_destroy_worker(rcu_exp_gp_kworker);
> > +               return;
> > +       }
> > +
> > +       sched_setscheduler_nocheck(rcu_exp_gp_kworker->task, SCHED_FIFO, &param);
> > +       sched_setscheduler_nocheck(rcu_exp_par_gp_kworker->task, SCHED_FIFO,
> > +                                  &param);
> > +}
> > +
> >  /*
> >   * Spawn the kthreads that handle RCU's grace periods.
> >   */
> > @@ -4595,6 +4622,10 @@ static int __init rcu_spawn_gp_kthread(void)
> >         rcu_spawn_cpu_nocb_kthread(smp_processor_id());
> >         rcu_spawn_one_boost_kthread(rdp->mynode);
> >         rcu_spawn_core_kthreads();
> > +
> > +       /* Create kthread worker for expedited GPs */
> > +       rcu_start_exp_gp_kworkers();
> > +
> >         return 0;
> >  }
> >  early_initcall(rcu_spawn_gp_kthread);
> > @@ -4843,7 +4874,6 @@ static void __init rcu_dump_rcu_node_tree(void)
> >  }
> >
> >  struct workqueue_struct *rcu_gp_wq;
> > -struct workqueue_struct *rcu_par_gp_wq;
> >
> >  static void __init kfree_rcu_batch_init(void)
> >  {
> > @@ -4905,11 +4935,14 @@ void __init rcu_init(void)
> >         rcu_cpu_starting(cpu);
> >         rcutree_online_cpu(cpu);
> >
> > -       /* Create workqueue for Tree SRCU and for expedited GPs. */
> > +       /*
> > +        * Create workqueue for Tree SRCU.
> > +        *
> > +        * Expedited GPs use RT kthread_worker.
> > +        * See: rcu_start_exp_gp_kworkers()
> > +        */
> >         rcu_gp_wq = alloc_workqueue("rcu_gp", WQ_MEM_RECLAIM, 0);
> >         WARN_ON(!rcu_gp_wq);
> > -       rcu_par_gp_wq = alloc_workqueue("rcu_par_gp", WQ_MEM_RECLAIM, 0);
> > -       WARN_ON(!rcu_par_gp_wq);
> >
> >         /* Fill in default value for rcutree.qovld boot parameter. */
> >         /* -After- the rcu_node ->lock fields are initialized! */
> > diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
> > index b8d07bf92d29..b0afcc36a896 100644
> > --- a/kernel/rcu/tree.h
> > +++ b/kernel/rcu/tree.h
> > @@ -10,6 +10,7 @@
> >   */
> >
> >  #include <linux/cache.h>
> > +#include <linux/kthread.h>
> >  #include <linux/spinlock.h>
> >  #include <linux/rtmutex.h>
> >  #include <linux/threads.h>
> > @@ -23,7 +24,7 @@
> >  /* Communicate arguments to a workqueue handler. */
> >  struct rcu_exp_work {
> >         unsigned long rew_s;
> > -       struct work_struct rew_work;
> > +       struct kthread_work rew_work;
> >  };
> >
> >  /* RCU's kthread states for tracing. */
> > diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> > index bd47fce0e08c..cdb299e80cff 100644
> > --- a/kernel/rcu/tree_exp.h
> > +++ b/kernel/rcu/tree_exp.h
> > @@ -334,7 +334,7 @@ static bool exp_funnel_lock(unsigned long s)
> >   * Select the CPUs within the specified rcu_node that the upcoming
> >   * expedited grace period needs to wait for.
> >   */
> > -static void sync_rcu_exp_select_node_cpus(struct work_struct *wp)
> > +static void sync_rcu_exp_select_node_cpus(struct kthread_work *wp)
> >  {
> >         int cpu;
> >         unsigned long flags;
> > @@ -423,7 +423,6 @@ static void sync_rcu_exp_select_node_cpus(struct work_struct *wp)
> >   */
> >  static void sync_rcu_exp_select_cpus(void)
> >  {
> > -       int cpu;
> >         struct rcu_node *rnp;
> >
> >         trace_rcu_exp_grace_period(rcu_state.name, rcu_exp_gp_seq_endval(), TPS("reset"));
> > @@ -435,28 +434,27 @@ static void sync_rcu_exp_select_cpus(void)
> >                 rnp->exp_need_flush = false;
> >                 if (!READ_ONCE(rnp->expmask))
> >                         continue; /* Avoid early boot non-existent wq. */
> > -               if (!READ_ONCE(rcu_par_gp_wq) ||
> > +               if (!READ_ONCE(rcu_exp_par_gp_kworker) ||
> >                     rcu_scheduler_active != RCU_SCHEDULER_RUNNING ||
> >                     rcu_is_last_leaf_node(rnp)) {
> > -                       /* No workqueues yet or last leaf, do direct call. */
> > +                       /* kthread worker not started yet or last leaf, do direct call. */
> >                         sync_rcu_exp_select_node_cpus(&rnp->rew.rew_work);
> >                         continue;
> >                 }
> > -               INIT_WORK(&rnp->rew.rew_work, sync_rcu_exp_select_node_cpus);
> > -               cpu = find_next_bit(&rnp->ffmask, BITS_PER_LONG, -1);
> > -               /* If all offline, queue the work on an unbound CPU. */
> > -               if (unlikely(cpu > rnp->grphi - rnp->grplo))
> > -                       cpu = WORK_CPU_UNBOUND;
> > -               else
> > -                       cpu += rnp->grplo;
> > -               queue_work_on(cpu, rcu_par_gp_wq, &rnp->rew.rew_work);
> > +               kthread_init_work(&rnp->rew.rew_work, sync_rcu_exp_select_node_cpus);
> > +               /*
> > +                * Use rcu_exp_par_gp_kworker, because flushing a work item from
> > +                * another work item on the same kthread worker can result in
> > +                * deadlock.
> > +                */
> > +               kthread_queue_work(rcu_exp_par_gp_kworker, &rnp->rew.rew_work);
> >                 rnp->exp_need_flush = true;
> >         }
> >
> >         /* Wait for workqueue jobs (if any) to complete. */
> >         rcu_for_each_leaf_node(rnp)
> >                 if (rnp->exp_need_flush)
> > -                       flush_work(&rnp->rew.rew_work);
> > +                       kthread_flush_work(&rnp->rew.rew_work);
> >  }
> >
> >  /*
> > @@ -625,7 +623,7 @@ static void rcu_exp_sel_wait_wake(unsigned long s)
> >  /*
> >   * Work-queue handler to drive an expedited grace period forward.
> >   */
> > -static void wait_rcu_exp_gp(struct work_struct *wp)
> > +static void wait_rcu_exp_gp(struct kthread_work *wp)
> >  {
> >         struct rcu_exp_work *rewp;
> >
> > @@ -835,22 +833,18 @@ static void __synchronize_rcu_expedited(bool polling)
> >         } else {
> >                 /* Marshall arguments & schedule the expedited grace period. */
> >                 rew.rew_s = s;
> > -               INIT_WORK_ONSTACK(&rew.rew_work, wait_rcu_exp_gp);
> > -               queue_work(rcu_gp_wq, &rew.rew_work);
> > +               kthread_init_work(&rew.rew_work, wait_rcu_exp_gp);
> > +               kthread_queue_work(rcu_exp_gp_kworker, &rew.rew_work);
> >         }
> >
> >         /* Wait for expedited grace period to complete. */
> >         rnp = rcu_get_root();
> >         wait_event(rnp->exp_wq[rcu_seq_ctr(s) & 0x3],
> >                    sync_exp_work_done(s));
> > -       smp_mb(); /* Workqueue actions happen before return. */
> > +       smp_mb(); /* kthread actions happen before return. */
> >
> >         /* Let the next expedited grace period start. */
> >         mutex_unlock(&rcu_state.exp_mutex);
> > -
> > -       if (likely(!boottime))
> > -               destroy_work_on_stack(&rew.rew_work);
> > -
> >  }
> >
> >  /**
> >
> > --
> > To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
> >
