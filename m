Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B733751847B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 14:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235472AbiECMoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 08:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231669AbiECMoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 08:44:07 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F2E1B7A7
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 05:40:34 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-2f7d7e3b5bfso177943157b3.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 05:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y3cZzqp+dH+7vp78r28myXxPMUTDGkLEsUCOqzQtjbU=;
        b=RJDJMuc0YQdpb6cCTFE2pMIR9HPNprQATAOjd/oeJ0ANcN2YgE/R5sBT+rCIyv3KIk
         H/BECnz651W6kYDZrH/6SM/E+tVrQKUsvGe/FdInUIizOFN7oU74uiZl26ukNSBwuG3w
         pR8DMAPzX/0YJx0/WGsWpOEknGLaYZGkg9I6L0ypLCuPNaCpdeMZOrQDAwfBamPN4qGJ
         jlvxjHuESFyhuftL7mtXTSq0qBGFhDp1N786cz2UPNwjKiPtGISIs5U8XtCF9llTSteV
         bvvWsUrVhTBghltfL1yQPLWhroE5VEDxXjVW7OjLcoDzGD6Pb6R0uwMg07/gBNtNM8BV
         fWUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y3cZzqp+dH+7vp78r28myXxPMUTDGkLEsUCOqzQtjbU=;
        b=LhOM88hYaYyCjkwkfu/BY9/HWBsTfQtIknJnqhX1E+2tfvEl28Tl+X/b0oe4iQSp2/
         MFjEJQWgVsdIcIjgj5W0yLbzolnqnlVpND8WDr1e0IY7gBNq3KAtRy+t5G5AMU26wUqt
         XecvcJsmEdNeq1cNv4l87hK9u4xGn1vor+EQ+ybzzXh8Mhm8HpTuephpq5K9/DwwIOIp
         TA1nwPVSK93Zf8mARAILFwGGGgCddMwvQK2R5248ftEogQSR9AQM4+/nGvuiJMMhpaza
         B6QCiGvI5SCF8LVqbAOedUpGROJWkkmKen1IORr7oWXVcY5Kp1Pf3k4btPTIed0e4WhG
         jsrg==
X-Gm-Message-State: AOAM530FrpDENEnCPAj4X0+bkN1tYxAocwhccZOASmSbgg6Awt6B8iHd
        29MRYufdBSuZ5m3P1G0QMPpZ+FDmC5Q937jNQD6A2w==
X-Google-Smtp-Source: ABdhPJwndUmlc3qzk89zAfuNmHUdsD2YdXI1EbcxHeL2qQwEmYsael8p1PG8mpVSw7Zy8y50ybrVdpSyMmU4dsNZzSc=
X-Received: by 2002:a81:492:0:b0:2f7:ce87:c324 with SMTP id
 140-20020a810492000000b002f7ce87c324mr15335658ywe.359.1651581633109; Tue, 03
 May 2022 05:40:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220311161406.23497-1-vincent.guittot@linaro.org>
 <20220311161406.23497-6-vincent.guittot@linaro.org> <Ym6uMoHVkqr9zOpj@geo.homenetwork>
 <YnCTwQlDFPfFOJJ3@geo.homenetwork>
In-Reply-To: <YnCTwQlDFPfFOJJ3@geo.homenetwork>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 3 May 2022 14:40:21 +0200
Message-ID: <CAKfTPtBo+FVB=qW-bqp2fMBk6=1cyUWeAN3-UMghWGdbof3ghw@mail.gmail.com>
Subject: Re: [RFC 5/6] sched/fair: Take into account latency nice at wakeup
To:     Tao Zhou <tao.zhou@linux.dev>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org, parth@linux.ibm.com,
        qais.yousef@arm.com, chris.hyser@oracle.com,
        pkondeti@codeaurora.org, vschneid@redhat.com,
        patrick.bellasi@matbug.net, David.Laight@aculab.com,
        pjt@google.com, pavel@ucw.cz, tj@kernel.org,
        dhaval.giani@oracle.com, qperret@google.com,
        tim.c.chen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_BTC_ID,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 May 2022 at 04:29, Tao Zhou <tao.zhou@linux.dev> wrote:
>
> On Sun, May 01, 2022 at 11:58:42PM +0800, Tao Zhou wrote:
> > Hi Vincent,
> >
> > Change to Valentin Schneider's now using mail address.
> >
> > On Fri, Mar 11, 2022 at 05:14:05PM +0100, Vincent Guittot wrote:
> >
> > > Take into account the nice latency priority of a thread when deciding to
> > > preempt the current running thread. We don't want to provide more CPU
> > > bandwidth to a thread but reorder the scheduling to run latency sensitive
> > > task first whenever possible.
> > >
> > > As long as a thread didn't use its bandwidth, it will be able to preempt
> > > the current thread.
> > >
> > > At the opposite, a thread with a low latency priority will preempt current
> > > thread at wakeup only to keep fair CPU bandwidth sharing. Otherwise it will
> > > wait for the tick to get its sched slice.
> > >
> > >                                    curr vruntime
> > >                                        |
> > >                       sysctl_sched_wakeup_granularity
> > >                                    <-->
> > > ----------------------------------|----|-----------------------|---------------
> > >                                   |    |<--------------------->
> > >                                   |    .  sysctl_sched_latency
> > >                                   |    .
> > > default/current latency entity    |    .
> > >                                   |    .
> > > 1111111111111111111111111111111111|0000|-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-
> > > se preempts curr at wakeup ------>|<- se doesn't preempt curr -----------------
> > >                                   |    .
> > >                                   |    .
> > >                                   |    .
> > > low latency entity                |    .
> > >                                    ---------------------->|
> > >                                % of sysctl_sched_latency  |
> > > 1111111111111111111111111111111111111111111111111111111111|0000|-1-1-1-1-1-1-1-
> > > preempt ------------------------------------------------->|<- do not preempt --
> > >                                   |    .
> > >                                   |    .
> > >                                   |    .
> > > high latency entity               |    .
> > >          |<-----------------------|    .
> > >          | % of sysctl_sched_latency   .
> > > 111111111|0000|-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1
> > > preempt->|<- se doesn't preempt curr ------------------------------------------
> > >
> > > Tests results of nice latency impact on heavy load like hackbench:
> > >
> > > hackbench -l (2560 / group) -g group
> > > group        latency 0             latency 19
> > > 1            1.450(+/- 0.60%)      1.376(+/- 0.54%) + 5%
> > > 4            1.537(+/- 1.75%)      1.335(+/- 1.81%) +13%
> > > 8            1.414(+/- 1.91%)      1.348(+/- 1.88%) + 5%
> > > 16           1.423(+/- 1.65%)      1.374(+/- 0.58%) + 3%
> > >
> > > hackbench -p -l (2560 / group) -g group
> > > group
> > > 1            1.416(+/- 3.45%)      0.886(+/- 0.54%) +37%
> > > 4            1.634(+/- 7.14%)      0.888(+/- 5.40%) +45%
> > > 8            1.449(+/- 2.14%)      0.804(+/- 4.55%) +44%
> > > 16           0.917(+/- 4.12%)      0.777(+/- 1.41%) +15%
> > >
> > > By deacreasing the latency prio, we reduce the number of preemption at
> >
> > s/deacreasing/decreasing/
> > s/reduce/increase/
> >
> > > wakeup and help hackbench making progress.
> > >
> > > Test results of nice latency impact on short live load like cyclictest
> > > while competing with heavy load like hackbench:
> > >
> > > hackbench -l 10000 -g group &
> > > cyclictest --policy other -D 5 -q -n
> > >         latency 0           latency -20
> > > group   min  avg    max     min  avg    max
> > > 0       16    17     28      15   17     27
> > > 1       61   382  10603      63   89   4628
> > > 4       52   437  15455      54   98  16238
> > > 8       56   728  38499      61  125  28983
> > > 16      53  1215  52207      61  183  80751
> > >
> > > group = 0 means that hackbench is not running.
> > >
> > > The avg is significantly improved with nice latency -20 especially with
> > > large number of groups but min and max remain quite similar. If we add the
> > > histogram parameters to get details of latency, we have :
> > >
> > > hackbench -l 10000 -g 16 &
> > > cyclictest --policy other -D 5 -q -n  -H 20000 --histfile data.txt
> > >               latency 0    latency -20
> > > Min Latencies:    63           62
> > > Avg Latencies:  1397          218
> > > Max Latencies: 44926        42291
> > > 50% latencies:   100           98
> > > 75% latencies:   762          116
> > > 85% latencies:  1118          126
> > > 90% latencies:  1540          130
> > > 95% latencies:  5610          138
> > > 99% latencies: 13738          266
> > >
> > > With percentile details, we see the benefit of nice latency -20 as
> > > 1% of the latencies stays above 266us whereas the default latency has
> > > got 25% are above 762us and 10% over the 1ms.
> > >
> > > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > > ---
> > >  include/linux/sched.h |  4 ++-
> > >  init/init_task.c      |  2 +-
> > >  kernel/sched/core.c   | 32 +++++++++++++++++++----
> > >  kernel/sched/debug.c  |  2 +-
> > >  kernel/sched/fair.c   | 60 +++++++++++++++++++++++++++++++++++++++++--
> > >  kernel/sched/sched.h  | 12 +++++++++
> > >  6 files changed, 102 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > > index 2aa889a59054..9aeb157e819b 100644
> > > --- a/include/linux/sched.h
> > > +++ b/include/linux/sched.h
> > > @@ -560,6 +560,8 @@ struct sched_entity {
> > >     unsigned long                   runnable_weight;
> > >  #endif
> > >
> > > +   int                             latency_weight;
> > > +
> > >  #ifdef CONFIG_SMP
> > >     /*
> > >      * Per entity load average tracking.
> > > @@ -779,7 +781,7 @@ struct task_struct {
> > >     int                             static_prio;
> > >     int                             normal_prio;
> > >     unsigned int                    rt_priority;
> > > -   int                             latency_nice;
> > > +   int                             latency_prio;
> > >
> > >     struct sched_entity             se;
> > >     struct sched_rt_entity          rt;
> > > diff --git a/init/init_task.c b/init/init_task.c
> > > index 2afa249c253b..e98c71f24981 100644
> > > --- a/init/init_task.c
> > > +++ b/init/init_task.c
> > > @@ -78,7 +78,7 @@ struct task_struct init_task
> > >     .prio           = MAX_PRIO - 20,
> > >     .static_prio    = MAX_PRIO - 20,
> > >     .normal_prio    = MAX_PRIO - 20,
> > > -   .latency_nice   = 0,
> > > +   .latency_prio   = NICE_WIDTH - 20,
> > >     .policy         = SCHED_NORMAL,
> > >     .cpus_ptr       = &init_task.cpus_mask,
> > >     .user_cpus_ptr  = NULL,
> > > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > > index 8f8b102a75c4..547b0da01efe 100644
> > > --- a/kernel/sched/core.c
> > > +++ b/kernel/sched/core.c
> > > @@ -1241,6 +1241,11 @@ static void set_load_weight(struct task_struct *p, bool update_load)
> > >     }
> > >  }
> > >
> > > +static void set_latency_weight(struct task_struct *p)
> > > +{
> > > +   p->se.latency_weight = sched_latency_to_weight[p->latency_prio];
> > > +}
> > > +
> > >  #ifdef CONFIG_UCLAMP_TASK
> > >  /*
> > >   * Serializes updates of utilization clamp values
> > > @@ -4394,7 +4399,7 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
> > >     p->prio = current->normal_prio;
> > >
> > >     /* Propagate the parent's latency requirements to the child as well */
> > > -   p->latency_nice = current->latency_nice;
> > > +   p->latency_prio = current->latency_prio;
> > >
> > >     uclamp_fork(p);
> > >
> > > @@ -4412,7 +4417,7 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
> > >             p->prio = p->normal_prio = p->static_prio;
> > >             set_load_weight(p, false);
> > >
> > > -           p->latency_nice = DEFAULT_LATENCY_NICE;
> > > +           p->latency_prio = NICE_TO_LATENCY(0);
> > >             /*
> > >              * We don't need the reset flag anymore after the fork. It has
> > >              * fulfilled its duty:
> > > @@ -4420,6 +4425,9 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
> > >             p->sched_reset_on_fork = 0;
> > >     }
> > >
> > > +   /* Once latency_prio is set, update the latency weight */
> > > +   set_latency_weight(p);
> > > +
> > >     if (dl_prio(p->prio))
> > >             return -EAGAIN;
> > >     else if (rt_prio(p->prio))
> > > @@ -7361,7 +7369,7 @@ static int __sched_setscheduler(struct task_struct *p,
> > >             if (attr->sched_latency_nice < MIN_LATENCY_NICE)
> > >                     return -EINVAL;
> > >             /* Use the same security checks as NICE */
> > > -           if (attr->sched_latency_nice < p->latency_nice &&
> > > +           if (attr->sched_latency_nice < LATENCY_TO_NICE(p->latency_prio) &&
> > >                 !capable(CAP_SYS_NICE))
> > >                     return -EPERM;
> > >     }
> > > @@ -7401,7 +7409,7 @@ static int __sched_setscheduler(struct task_struct *p,
> > >             if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)
> > >                     goto change;
> > >             if (attr->sched_flags & SCHED_FLAG_LATENCY_NICE &&
> > > -               attr->sched_latency_nice != p->latency_nice)
> > > +               attr->sched_latency_nice != LATENCY_TO_NICE(p->latency_prio))
> > >                     goto change;
> > >
> > >             p->sched_reset_on_fork = reset_on_fork;
> > > @@ -7942,7 +7950,7 @@ SYSCALL_DEFINE4(sched_getattr, pid_t, pid, struct sched_attr __user *, uattr,
> > >     get_params(p, &kattr);
> > >     kattr.sched_flags &= SCHED_FLAG_ALL;
> > >
> > > -   kattr.sched_latency_nice = p->latency_nice;
> > > +   kattr.sched_latency_nice = LATENCY_TO_NICE(p->latency_prio);
> > >
> > >  #ifdef CONFIG_UCLAMP_TASK
> > >     /*
> > > @@ -10954,6 +10962,20 @@ const u32 sched_prio_to_wmult[40] = {
> > >   /*  15 */ 119304647, 148102320, 186737708, 238609294, 286331153,
> > >  };
> > >
> > > +/*
> > > + * latency weight for wakeup preemption
> > > + */
> > > +const int sched_latency_to_weight[40] = {
> > > + /* -20 */      1024,       973,       922,       870,       819,
> > > + /* -15 */       768,       717,       666,       614,       563,
> > > + /* -10 */       512,       461,       410,       358,       307,
> > > + /*  -5 */       256,       205,       154,       102,       51,
> > > + /*   0 */    0,       -51,      -102,      -154,      -205,
> > > + /*   5 */      -256,      -307,      -358,      -410,      -461,
> > > + /*  10 */      -512,      -563,      -614,      -666,      -717,
> > > + /*  15 */      -768,      -819,      -870,      -922,      -973,
> > > +};
> > > +
> > >  void call_trace_sched_update_nr_running(struct rq *rq, int count)
> > >  {
> > >          trace_sched_update_nr_running_tp(rq, count);
> > > diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> > > index 5d76a8927888..253e52ec73fb 100644
> > > --- a/kernel/sched/debug.c
> > > +++ b/kernel/sched/debug.c
> > > @@ -1043,7 +1043,7 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
> > >  #endif
> > >     P(policy);
> > >     P(prio);
> > > -   P(latency_nice);
> > > +   P(latency_prio);
> > >     if (task_has_dl_policy(p)) {
> > >             P(dl.runtime);
> > >             P(dl.deadline);
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index 5c4bfffe8c2c..506c482a0e48 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -5555,6 +5555,35 @@ static int sched_idle_cpu(int cpu)
> > >  }
> > >  #endif
> > >
> > > +static void set_next_buddy(struct sched_entity *se);
> > > +
> > > +static void check_preempt_from_idle(struct cfs_rq *cfs, struct sched_entity *se)
> > > +{
> > > +   struct sched_entity *next;
> > > +
> > > +   if (se->latency_weight <= 0)
> > > +           return;
> > > +
> > > +   if (cfs->nr_running <= 1)
> > > +           return;
> > > +   /*
> > > +    * When waking from idle, we don't need to check to preempt at wakeup
> > > +    * the idle thread and don't set next buddy as a candidate for being
> > > +    * picked in priority.
> > > +    * In case of simultaneous wakeup from idle, the latency sensitive tasks
> > > +    * lost opportunity to preempt non sensitive tasks which woke up
> > > +    * simultaneously.
> > > +    */
> > > +
> > > +   if (cfs->next)
> > > +           next = cfs->next;
> > > +   else
> > > +           next = __pick_first_entity(cfs);
> > > +
> > > +   if (next && wakeup_preempt_entity(next, se) == 1)
> > > +           set_next_buddy(se);
> > > +}
> > > +
> > >  /*
> > >   * The enqueue_task method is called before nr_running is
> > >   * increased. Here we update the fair scheduling stats and
> > > @@ -5648,6 +5677,9 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
> > >     if (!task_new)
> > >             update_overutilized_status(rq);
> > >
> > > +   if (rq->curr == rq->idle)
> > > +           check_preempt_from_idle(cfs_rq_of(&p->se), &p->se);
> > > +
> > >  enqueue_throttle:
> > >     if (cfs_bandwidth_used()) {
> > >             /*
> > > @@ -5669,8 +5701,6 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
> > >     hrtick_update(rq);
> > >  }
> > >
> > > -static void set_next_buddy(struct sched_entity *se);
> > > -
> > >  /*
> > >   * The dequeue_task method is called before nr_running is
> > >   * decreased. We remove the task from the rbtree and
> > > @@ -6970,6 +7000,27 @@ balance_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
> > >  }
> > >  #endif /* CONFIG_SMP */
> > >
> > > +static long wakeup_latency_gran(int latency_weight)
> > > +{
> > > +   long thresh = sysctl_sched_latency;
> > > +
> > > +   if (!latency_weight)
> > > +           return 0;
> > > +
> > > +   if (sched_feat(GENTLE_FAIR_SLEEPERS))
> > > +           thresh >>= 1;
> > > +
> > > +   /*
> > > +    * Clamp the delta to stay in the scheduler period range
> > > +    * [-sysctl_sched_latency:sysctl_sched_latency]
> > > +    */
> > > +   latency_weight = clamp_t(long, latency_weight,
> > > +                           -1 * NICE_LATENCY_WEIGHT_MAX,
> > > +                           NICE_LATENCY_WEIGHT_MAX);
> > > +
> > > +   return (thresh * latency_weight) >> NICE_LATENCY_SHIFT;
> > > +}
> > > +
> > >  static unsigned long wakeup_gran(struct sched_entity *se)
> > >  {
> > >     unsigned long gran = sysctl_sched_wakeup_granularity;
> > > @@ -7008,6 +7059,10 @@ static int
> > >  wakeup_preempt_entity(struct sched_entity *curr, struct sched_entity *se)
> > >  {
> > >     s64 gran, vdiff = curr->vruntime - se->vruntime;
> > > +   int latency_weight = se->latency_weight - curr->latency_weight;
> > > +
> > > +   latency_weight = min(latency_weight, se->latency_weight);
> >
> > Let lable A=se->latency_weight, B=curr->latency_weight, C=A-B.
> >
> > 1 A>0 B>0
> >     ::C=A-B<0, min(C,A)=C, latency decrease, C is the real diff value no matter
> >       what A is. That means it can be very 'long'(-sched_latency) and vdiff is
> >       more possible to be in <= 0 case and return -1.
> >     ::C=A-B>0, min(C,A)=A, latency increase, but it is conservative. Limit to
> >       A/1024*sched_latency.
> >     When latecy is decreased, the negtive value added to vdiff is larger than the
> >     positive value added to vdiff when latency is increased.
> >
> > 2 A>0 B<0
> >     ::C=A-B>0 and C>A, min(C,A)=A, latency increase and it is conservative.
> >
> > 3 A<0 B<0
> >     ::C=A-B>0, min(C,A)=A, latency increase but min(C,A)<0, I think if latency
> >     increase means the value added to vdiff will be a positive value to increase
> >     the chance to return 1. I would say it is max(C,A)=C
> >     ::C=A-B<0, min(C,A)=A, latency decrease and the real negtive value.
> >
> > 4 A<0,B>0
> >     ::C=A-B<0, min(C,A)=C, latency decrease and the real negtive value.
> >
> > Is there a reason that the value when latency increase and latency decrease
> > be treated differently. Latency increase value is limited to se's latency_weight
> > but latency decrease value can extend to -sched_latency or treat them the same.
> > Penalty latency decrease and conserve latency increase.
> >
> >
> > There is any value that this latency_weight can be considered to be a average.
> >
> > The delta value choose is ~%5 to 1024. %5*sched_latency=0.05*6ms=0.3ms.(no scale)
> > I do not think over that vdiff equation  and others though.
>
> vruntime is the accumulated weight history scaled time.
> vdiff is the scaled diff time delta.
>
> latency_gran = [delta_weight|latency_weight]/1024*thresh.
> If also to scale this latency_gran to reflect the load weight
> distribution in sched_latency like:
>
> latency_gran*1024/load_weight=[delta_weight|latency_weight]/load_weight*thresh.

wakeup_gran already scales with se load_weight

>
> About [delta_weight|latency_weight]/load_weight. Because latency nice and prio nice
> range is the same. Can make a table to const this calculation.. But I do not
> make sure that it is valuable to make this change. Just some random inputs..
>
> > Thanks,
> > Tao
> > > +   vdiff += wakeup_latency_gran(latency_weight);
> > >
> > >     if (vdiff <= 0)
> > >             return -1;
> > > @@ -7117,6 +7172,7 @@ static void check_preempt_wakeup(struct rq *rq, struct task_struct *p, int wake_
> > >             return;
> > >
> > >     update_curr(cfs_rq_of(se));
> > > +
> > >     if (wakeup_preempt_entity(se, pse) == 1) {
> > >             /*
> > >              * Bias pick_next to pick the sched entity that is
> > > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > > index 456ad2159eb1..dd92aa9c36f9 100644
> > > --- a/kernel/sched/sched.h
> > > +++ b/kernel/sched/sched.h
> > > @@ -122,6 +122,17 @@ extern void call_trace_sched_update_nr_running(struct rq *rq, int count);
> > >   * Default tasks should be treated as a task with latency_nice = 0.
> > >   */
> > >  #define DEFAULT_LATENCY_NICE       0
> > > +#define DEFAULT_LATENCY_PRIO       (DEFAULT_LATENCY_NICE + LATENCY_NICE_WIDTH/2)
> > > +
> > > +/*
> > > + * Convert user-nice values [ -20 ... 0 ... 19 ]
> > > + * to static latency [ 0..39 ],
> > > + * and back.
> > > + */
> > > +#define NICE_TO_LATENCY(nice)      ((nice) + DEFAULT_LATENCY_PRIO)
> > > +#define LATENCY_TO_NICE(prio)      ((prio) - DEFAULT_LATENCY_PRIO)
> > > +#define NICE_LATENCY_SHIFT (SCHED_FIXEDPOINT_SHIFT)
> > > +#define NICE_LATENCY_WEIGHT_MAX    (1L << NICE_LATENCY_SHIFT)
> > >
> > >  /*
> > >   * Increase resolution of nice-level calculations for 64-bit architectures.
> > > @@ -2098,6 +2109,7 @@ static_assert(WF_TTWU == SD_BALANCE_WAKE);
> > >
> > >  extern const int           sched_prio_to_weight[40];
> > >  extern const u32           sched_prio_to_wmult[40];
> > > +extern const int           sched_latency_to_weight[40];
> > >
> > >  /*
> > >   * {de,en}queue flags:
> > > --
> > > 2.17.1
> > >
