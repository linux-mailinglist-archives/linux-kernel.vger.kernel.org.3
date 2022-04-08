Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 066394F999C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 17:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237661AbiDHPg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 11:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237653AbiDHPgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 11:36:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3616A1C1E52;
        Fri,  8 Apr 2022 08:34:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C03776200C;
        Fri,  8 Apr 2022 15:34:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 198E0C385A1;
        Fri,  8 Apr 2022 15:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649432088;
        bh=FlHAWBRVH3lwNdR+HHzy/rqfcK2ZBVSaJDnZBzaA6jI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=hhZDoZemb4VvhWosGSeZ5gkhTi7LPfuo/+82/mMz0+avqpWWqRch/V0DrzVqq2E4F
         nyBWey2AwkGvKoKBSJVpeg5MPgmKSVg1nc/P2xXj5I3uPiZxvuHPKyx4GuPLO9mBKF
         HpAVv/u/e6L/UBgEYM5FlcHk25LqBtEMjTga9df2lgmaHBLuzYOP/KMP0MjWkAA3Ew
         Zwh8dvSeSxq+B03tzYkSMxmfKarg9eSC9SGYG8tu/m6esLbYE9U5nP6KyVJN2ujj3G
         fFauPO+o1ZFlTN2p5EBESD3fmR1NeDnmkDPlx9Qq1qV+Rr8Y1dTWiTKObVguAqJXcH
         LJkXv2KnnB0lQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id BAE3C5C0176; Fri,  8 Apr 2022 08:34:47 -0700 (PDT)
Date:   Fri, 8 Apr 2022 08:34:47 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Kalesh Singh <kaleshsingh@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        kernel-team <kernel-team@android.com>, Tejun Heo <tj@kernel.org>,
        Tim Murray <timmurray@google.com>, Wei Wang <wvw@google.com>,
        Kyle Lin <kylelin@google.com>,
        Chunwei Lu <chunweilu@google.com>,
        Lulu Wang <luluw@google.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        rcu <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] EXP rcu: Move expedited grace period (GP) work to RT
 kthread_worker
Message-ID: <20220408153447.GE4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220408045734.1158817-1-kaleshsingh@google.com>
 <CAEXW_YQ6_VpneJnBfhTOMr6DwJhNmvMAKDRMnpr8LxB9Gtt=Xg@mail.gmail.com>
 <20220408143444.GC4285@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YSrGKXh5DiJyrNvmbssSXbWBkA-XUjGRdS8HtGvW1r6hw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YSrGKXh5DiJyrNvmbssSXbWBkA-XUjGRdS8HtGvW1r6hw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08, 2022 at 10:41:26AM -0400, Joel Fernandes wrote:
> On Fri, Apr 8, 2022 at 10:34 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Fri, Apr 08, 2022 at 06:42:42AM -0400, Joel Fernandes wrote:
> > > On Fri, Apr 8, 2022 at 12:57 AM Kalesh Singh <kaleshsingh@google.com> wrote:
> > > >
> > > [...]
> > > > @@ -334,15 +334,13 @@ static bool exp_funnel_lock(unsigned long s)
> > > >   * Select the CPUs within the specified rcu_node that the upcoming
> > > >   * expedited grace period needs to wait for.
> > > >   */
> > > > -static void sync_rcu_exp_select_node_cpus(struct work_struct *wp)
> > > > +static void __sync_rcu_exp_select_node_cpus(struct rcu_exp_work *rewp)
> > > >  {
> > > >         int cpu;
> > > >         unsigned long flags;
> > > >         unsigned long mask_ofl_test;
> > > >         unsigned long mask_ofl_ipi;
> > > >         int ret;
> > > > -       struct rcu_exp_work *rewp =
> > > > -               container_of(wp, struct rcu_exp_work, rew_work);
> > > >         struct rcu_node *rnp = container_of(rewp, struct rcu_node, rew);
> > > >
> > > >         raw_spin_lock_irqsave_rcu_node(rnp, flags);
> > > > @@ -417,13 +415,119 @@ static void sync_rcu_exp_select_node_cpus(struct work_struct *wp)
> > > >                 rcu_report_exp_cpu_mult(rnp, mask_ofl_test, false);
> > > >  }
> > > >
> > > > +static void rcu_exp_sel_wait_wake(unsigned long s);
> > > > +
> > > > +#ifdef CONFIG_RCU_EXP_KTHREAD
> > >
> > > Just my 2c:
> > >
> > > Honestly, I am not sure if the benefits of duplicating the code to use
> > > normal workqueues outweighs the drawbacks (namely code complexity,
> > > code duplication - which can in turn cause more bugs and maintenance
> > > headaches down the line). The code is harder to read and adding more
> > > 30 character function names does not help.
> > >
> > > For something as important as expedited GPs, I can't imagine a
> > > scenario where an RT kthread worker would cause "issues". If it does
> > > cause issues, that's what the -rc cycles and the stable releases are
> > > for. I prefer to trust the process than take a one-foot-in-the-door
> > > approach.
> > >
> > > So please, can we just keep it simple?
> >
> > Yes and no.
> >
> > This is a bug fix, but only for those systems that are expecting real-time
> > response from synchronize_rcu_expedited().  As far as I know, this is only
> > Android.  The rest of the systems are just fine with the current behavior.
> 
> As far as you know, but are you sure?

None of use are sure.  We are balancing risks and potential benefits.

> > In addition, this bug fix introduces significant risks, especially in
> > terms of performance for throughput-oriented workloads.
> 
> Could you explain what the risk is? That's the part I did not follow.
> How can making synchronize_rcu_expedited() work getting priority
> introduce throughput issues?

Status quo has synchronize_rcu_expedited() workqueues running as
SCHED_OTHER.  The users affected by this will instead have these running
as SCHED_FIFO.  That changes scheduling.  For users not explicitly
needing low-latency synchronize_rcu_expedited(), this change is very
unlikely to be for the better.  And historically, unnecessarily running
portions of RCU at real-time priorities has been a change for the worse.
As in greatly increased context-switch rates and consequently degraded
performance.  Please note that this is not a theoretical statement:  Real
users have really been burned by too much SCHED_FIFO in RCU kthreads in
the past.

> > So yes, let's do this bug fix (with appropriate adjustment), but let's
> > also avoid exposing the non-Android workloads to risks from the inevitable
> > unintended consequences.  ;-)
> 
> I would argue the risk is also adding code complexity and more bugs
> without clear rationale for why it is being done. There's always risk
> with any change, but that's the -rc cycles and stable kernels help
> catch those. I think we should not add more code complexity if it is a
> theoretical concern.
> 
> There's also another possible risk - there is a possible hidden
> problem here that probably the non-Android folks haven't noticed or
> been able to debug. I would rather just do the right thing.
> 
> Just my 2c,

Sorry, but my answer is still "no".

Your suggested change risks visiting unacceptable performance
degradation on a very large number of innocent users for whom current
synchronize_rcu_expedited() latency is pleent good enough.

After all, if simplicity were the only goal, we would set NR_CPUS=0
and be happy.  ;-)

							Thanx, Paul

> - Joel
> 
> 
> >
> >                                                         Thanx, Paul
> >
> > > Thanks,
> > >
> > >  - Joel
> > >
> > >
> > > > +static void sync_rcu_exp_select_node_cpus(struct kthread_work *wp)
> > > > +{
> > > > +       struct rcu_exp_work *rewp =
> > > > +               container_of(wp, struct rcu_exp_work, rew_work);
> > > > +
> > > > +       __sync_rcu_exp_select_node_cpus(rewp);
> > > > +}
> > > > +
> > > > +static inline bool rcu_gp_par_worker_started(void)
> > > > +{
> > > > +       return !!READ_ONCE(rcu_exp_par_gp_kworker);
> > > > +}
> > > > +
> > > > +static inline void sync_rcu_exp_select_cpus_queue_work(struct rcu_node *rnp)
> > > > +{
> > > > +       kthread_init_work(&rnp->rew.rew_work, sync_rcu_exp_select_node_cpus);
> > > > +       /*
> > > > +        * Use rcu_exp_par_gp_kworker, because flushing a work item from
> > > > +        * another work item on the same kthread worker can result in
> > > > +        * deadlock.
> > > > +        */
> > > > +       kthread_queue_work(rcu_exp_par_gp_kworker, &rnp->rew.rew_work);
> > > > +}
> > > > +
> > > > +static inline void sync_rcu_exp_select_cpus_flush_work(struct rcu_node *rnp)
> > > > +{
> > > > +       kthread_flush_work(&rnp->rew.rew_work);
> > > > +}
> > > > +
> > > > +/*
> > > > + * Work-queue handler to drive an expedited grace period forward.
> > > > + */
> > > > +static void wait_rcu_exp_gp(struct kthread_work *wp)
> > > > +{
> > > > +       struct rcu_exp_work *rewp;
> > > > +
> > > > +       rewp = container_of(wp, struct rcu_exp_work, rew_work);
> > > > +       rcu_exp_sel_wait_wake(rewp->rew_s);
> > > > +}
> > > > +
> > > > +static inline void synchronize_rcu_expedited_queue_work(struct rcu_exp_work *rew)
> > > > +{
> > > > +       kthread_init_work(&rew->rew_work, wait_rcu_exp_gp);
> > > > +       kthread_queue_work(rcu_exp_gp_kworker, &rew->rew_work);
> > > > +}
> > > > +
> > > > +static inline void synchronize_rcu_expedited_destroy_work(struct rcu_exp_work *rew)
> > > > +{
> > > > +}
> > > > +#else /* !CONFIG_RCU_EXP_KTHREAD */
> > > > +static void sync_rcu_exp_select_node_cpus(struct work_struct *wp)
> > > > +{
> > > > +       struct rcu_exp_work *rewp =
> > > > +               container_of(wp, struct rcu_exp_work, rew_work);
> > > > +
> > > > +       __sync_rcu_exp_select_node_cpus(rewp);
> > > > +}
> > > > +
> > > > +static inline bool rcu_gp_par_worker_started(void)
> > > > +{
> > > > +       return !!READ_ONCE(rcu_par_gp_wq);
> > > > +}
> > > > +
> > > > +static inline void sync_rcu_exp_select_cpus_queue_work(struct rcu_node *rnp)
> > > > +{
> > > > +       int cpu = find_next_bit(&rnp->ffmask, BITS_PER_LONG, -1);
> > > > +
> > > > +       INIT_WORK(&rnp->rew.rew_work, sync_rcu_exp_select_node_cpus);
> > > > +       /* If all offline, queue the work on an unbound CPU. */
> > > > +       if (unlikely(cpu > rnp->grphi - rnp->grplo))
> > > > +               cpu = WORK_CPU_UNBOUND;
> > > > +       else
> > > > +               cpu += rnp->grplo;
> > > > +       queue_work_on(cpu, rcu_par_gp_wq, &rnp->rew.rew_work);
> > > > +}
> > > > +
> > > > +static inline void sync_rcu_exp_select_cpus_flush_work(struct rcu_node *rnp)
> > > > +{
> > > > +       flush_work(&rnp->rew.rew_work);
> > > > +}
> > > > +
> > > > +/*
> > > > + * Work-queue handler to drive an expedited grace period forward.
> > > > + */
> > > > +static void wait_rcu_exp_gp(struct work_struct *wp)
> > > > +{
> > > > +       struct rcu_exp_work *rewp;
> > > > +
> > > > +       rewp = container_of(wp, struct rcu_exp_work, rew_work);
> > > > +       rcu_exp_sel_wait_wake(rewp->rew_s);
> > > > +}
> > > > +
> > > > +static inline void synchronize_rcu_expedited_queue_work(struct rcu_exp_work *rew)
> > > > +{
> > > > +       INIT_WORK_ONSTACK(&rew->rew_work, wait_rcu_exp_gp);
> > > > +       queue_work(rcu_gp_wq, &rew->rew_work);
> > > > +}
> > > > +
> > > > +static inline void synchronize_rcu_expedited_destroy_work(struct rcu_exp_work *rew)
> > > > +{
> > > > +       destroy_work_on_stack(&rew->rew_work);
> > > > +}
> > > > +#endif /* CONFIG_RCU_EXP_KTHREAD */
> > > > +
> > > >  /*
> > > >   * Select the nodes that the upcoming expedited grace period needs
> > > >   * to wait for.
> > > >   */
> > > >  static void sync_rcu_exp_select_cpus(void)
> > > >  {
> > > > -       int cpu;
> > > >         struct rcu_node *rnp;
> > > >
> > > >         trace_rcu_exp_grace_period(rcu_state.name, rcu_exp_gp_seq_endval(), TPS("reset"));
> > > > @@ -435,28 +539,21 @@ static void sync_rcu_exp_select_cpus(void)
> > > >                 rnp->exp_need_flush = false;
> > > >                 if (!READ_ONCE(rnp->expmask))
> > > >                         continue; /* Avoid early boot non-existent wq. */
> > > > -               if (!READ_ONCE(rcu_par_gp_wq) ||
> > > > +               if (!rcu_gp_par_worker_started() ||
> > > >                     rcu_scheduler_active != RCU_SCHEDULER_RUNNING ||
> > > >                     rcu_is_last_leaf_node(rnp)) {
> > > > -                       /* No workqueues yet or last leaf, do direct call. */
> > > > +                       /* No worker started yet or last leaf, do direct call. */
> > > >                         sync_rcu_exp_select_node_cpus(&rnp->rew.rew_work);
> > > >                         continue;
> > > >                 }
> > > > -               INIT_WORK(&rnp->rew.rew_work, sync_rcu_exp_select_node_cpus);
> > > > -               cpu = find_next_bit(&rnp->ffmask, BITS_PER_LONG, -1);
> > > > -               /* If all offline, queue the work on an unbound CPU. */
> > > > -               if (unlikely(cpu > rnp->grphi - rnp->grplo))
> > > > -                       cpu = WORK_CPU_UNBOUND;
> > > > -               else
> > > > -                       cpu += rnp->grplo;
> > > > -               queue_work_on(cpu, rcu_par_gp_wq, &rnp->rew.rew_work);
> > > > +               sync_rcu_exp_select_cpus_queue_work(rnp);
> > > >                 rnp->exp_need_flush = true;
> > > >         }
> > > >
> > > > -       /* Wait for workqueue jobs (if any) to complete. */
> > > > +       /* Wait for jobs (if any) to complete. */
> > > >         rcu_for_each_leaf_node(rnp)
> > > >                 if (rnp->exp_need_flush)
> > > > -                       flush_work(&rnp->rew.rew_work);
> > > > +                       sync_rcu_exp_select_cpus_flush_work(rnp);
> > > >  }
> > > >
> > > >  /*
> > > > @@ -622,17 +719,6 @@ static void rcu_exp_sel_wait_wake(unsigned long s)
> > > >         rcu_exp_wait_wake(s);
> > > >  }
> > > >
> > > > -/*
> > > > - * Work-queue handler to drive an expedited grace period forward.
> > > > - */
> > > > -static void wait_rcu_exp_gp(struct work_struct *wp)
> > > > -{
> > > > -       struct rcu_exp_work *rewp;
> > > > -
> > > > -       rewp = container_of(wp, struct rcu_exp_work, rew_work);
> > > > -       rcu_exp_sel_wait_wake(rewp->rew_s);
> > > > -}
> > > > -
> > > >  #ifdef CONFIG_PREEMPT_RCU
> > > >
> > > >  /*
> > > > @@ -848,20 +934,19 @@ void synchronize_rcu_expedited(void)
> > > >         } else {
> > > >                 /* Marshall arguments & schedule the expedited grace period. */
> > > >                 rew.rew_s = s;
> > > > -               INIT_WORK_ONSTACK(&rew.rew_work, wait_rcu_exp_gp);
> > > > -               queue_work(rcu_gp_wq, &rew.rew_work);
> > > > +               synchronize_rcu_expedited_queue_work(&rew);
> > > >         }
> > > >
> > > >         /* Wait for expedited grace period to complete. */
> > > >         rnp = rcu_get_root();
> > > >         wait_event(rnp->exp_wq[rcu_seq_ctr(s) & 0x3],
> > > >                    sync_exp_work_done(s));
> > > > -       smp_mb(); /* Workqueue actions happen before return. */
> > > > +       smp_mb(); /* Work actions happen before return. */
> > > >
> > > >         /* Let the next expedited grace period start. */
> > > >         mutex_unlock(&rcu_state.exp_mutex);
> > > >
> > > >         if (likely(!boottime))
> > > > -               destroy_work_on_stack(&rew.rew_work);
> > > > +               synchronize_rcu_expedited_destroy_work(&rew);
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(synchronize_rcu_expedited);
> > > >
> > > > base-commit: 42e7a03d3badebd4e70aea5362d6914dfc7c220b
> > > > --
> > > > 2.35.1.1178.g4f1659d476-goog
> > > >
