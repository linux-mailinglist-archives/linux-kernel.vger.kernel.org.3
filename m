Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93A77524F3E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 16:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354911AbiELODG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 10:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343674AbiELODE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 10:03:04 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF475621F
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 07:03:03 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-2fb9a85a124so54408567b3.13
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 07:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KlDkQpCn49Egj2gNBh7QJsQSLZROJtZtgLe+YMoSoeo=;
        b=N3570Jyc5Be2853QkpFfp1yCxzkBQU3WOotacVP2mpU9bVdFZU9pNQNBGnXw6ZGK4p
         OK6g2jhm8N2ACXg12P63FUp7J3EQNCcAnJhkgWXeMmp/D7WLv1d22lfsfD1KCodNVg3/
         4wcCCLuCtkN2yUgOhBGKfZIFZFCj0pjOXSh8pe5l+hstpwodlzK7pes7t+dq15YwMLq0
         x5Myz0uiG8mSPZYxHSBkx8CDdr5cDPktvIOJaO/rZAnVGjBvU3pf+f43IaQlauwNIo/n
         3bpokGajPVE1F2fAvaB9UgUgk1IOmd+VwPb9NWRGQH4l6SbR/CCXQ0QT9g/SoDTUo/BJ
         Iimg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KlDkQpCn49Egj2gNBh7QJsQSLZROJtZtgLe+YMoSoeo=;
        b=OcbckI1Pkzl0AzzuyGFeuQqU8j9oaVb4abXdHau8H+u96txx+4BrkKiy8qDJnQ2zvv
         sSLLJNJeYUHNuT9UBWfdPoYSQdxwM4fq2/UWtxOk+72kcCqdoyPyhAqejeFPUF/oABeo
         W7AGI4K/q9jz2ywnu2yRcgJuhBeubORR8sl3JDA7PYTaUBqohd3Xk1PKj9z4Lc0BHugZ
         IIGkxsbI/GZv/PxfRixWMzt1C6bwMNS0LMcH7z3R2P8/L1wudyBA1IAq9FcGoNCGc/bI
         tRkjtWXa5p8yJaNhokG8w1TuwxAWAB1hOUKOjX+2pVVSUWJzT+IMNrAR4dwmzL2txyUs
         64AQ==
X-Gm-Message-State: AOAM531S2sKNIV0gZpjv36RFgBypJoxYLZRLlfCYor5cOm3+hXoJOQgL
        qjNA35OP6qbCWbCILktWVK1JG6K8T53OzaTB4CE7rFUZGMQ=
X-Google-Smtp-Source: ABdhPJxnn7D4LVeIOfQOk+RSZWj5mvF54pTLOLu7vH5wr16JxWLf2fOlF1Woe/Z0TOy+MD7A+t4Wk3Tl+SskM+2nWT8=
X-Received: by 2002:a81:5204:0:b0:2fb:9312:52fc with SMTP id
 g4-20020a815204000000b002fb931252fcmr169486ywb.67.1652364182208; Thu, 12 May
 2022 07:03:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220427160544.40309-1-zhouchengming@bytedance.com> <4f04f101-53c1-0ac8-c7e8-ff2999ed35ba@bytedance.com>
In-Reply-To: <4f04f101-53c1-0ac8-c7e8-ff2999ed35ba@bytedance.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 12 May 2022 16:02:49 +0200
Message-ID: <CAKfTPtDpqECw_mo1+iPN8OPb3cBf7ppJsLSTAJwPRLr-N3auqg@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: optimize and simplify rq leaf_cfs_rq_list
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, songmuchun@bytedance.com,
        zhengqi.arch@bytedance.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chengming,

Your patch is on my list but I have been busy on other stuff and we
had enough warnings and problems with this part that I want to
carefully review that all the cases are covered. I will review it soon

Vincent

On Wed, 11 May 2022 at 14:05, Chengming Zhou
<zhouchengming@bytedance.com> wrote:
>
> Hello, friendly ping...
>
>
> On 2022/4/28 00:05, Chengming Zhou wrote:
> > We notice the rq leaf_cfs_rq_list has two problems when do bugfix
> > backports and some test profiling.
> >
> > 1. cfs_rqs under throttled subtree could be added to the list, and
> >    make their fully decayed ancestors on the list, even though not needed.
> >
> > 2. #1 also make the leaf_cfs_rq_list management complex and error prone,
> >    this is the list of related bugfix so far:
> >
> >    commit 31bc6aeaab1d ("sched/fair: Optimize update_blocked_averages()")
> >    commit fe61468b2cbc ("sched/fair: Fix enqueue_task_fair warning")
> >    commit b34cb07dde7c ("sched/fair: Fix enqueue_task_fair() warning some more")
> >    commit 39f23ce07b93 ("sched/fair: Fix unthrottle_cfs_rq() for leaf_cfs_rq list")
> >    commit 0258bdfaff5b ("sched/fair: Fix unfairness caused by missing load decay")
> >    commit a7b359fc6a37 ("sched/fair: Correctly insert cfs_rq's to list on unthrottle")
> >    commit fdaba61ef8a2 ("sched/fair: Ensure that the CFS parent is added after unthrottling")
> >    commit 2630cde26711 ("sched/fair: Add ancestors of unthrottled undecayed cfs_rq")
> >
> > commit 31bc6aeaab1d ("sched/fair: Optimize update_blocked_averages()")
> > delete every cfs_rq under throttled subtree from rq->leaf_cfs_rq_list,
> > and delete the throttled_hierarchy() test in update_blocked_averages(),
> > which optimized update_blocked_averages().
> >
> > But those later bugfix add cfs_rqs under throttled subtree back to
> > rq->leaf_cfs_rq_list again, with their fully decayed ancestors, for
> > the integrity of rq->leaf_cfs_rq_list.
> >
> > This patch takes another method, skip all cfs_rqs under throttled
> > hierarchy when list_add_leaf_cfs_rq(), to completely make cfs_rqs
> > under throttled subtree off the leaf_cfs_rq_list.
> >
> > So we don't need to consider throttled related things in
> > enqueue_entity(), unthrottle_cfs_rq() and enqueue_task_fair(),
> > which simplify the code a lot. Also optimize update_blocked_averages()
> > since cfs_rqs under throttled hierarchy and their ancestors
> > won't be on the leaf_cfs_rq_list.
> >
> > Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> > ---
> >  kernel/sched/fair.c | 72 ++++++++++-----------------------------------
> >  1 file changed, 16 insertions(+), 56 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 1ad18b5cc1b8..083c3d32c899 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -309,6 +309,8 @@ const struct sched_class fair_sched_class;
> >
> >  #ifdef CONFIG_FAIR_GROUP_SCHED
> >
> > +static inline int throttled_hierarchy(struct cfs_rq *cfs_rq);
> > +
> >  /* Walk up scheduling entities hierarchy */
> >  #define for_each_sched_entity(se) \
> >               for (; se; se = se->parent)
> > @@ -331,7 +333,7 @@ static inline bool list_add_leaf_cfs_rq(struct cfs_rq *cfs_rq)
> >       struct rq *rq = rq_of(cfs_rq);
> >       int cpu = cpu_of(rq);
> >
> > -     if (cfs_rq->on_list)
> > +     if (cfs_rq->on_list || throttled_hierarchy(cfs_rq))
> >               return rq->tmp_alone_branch == &rq->leaf_cfs_rq_list;
> >
> >       cfs_rq->on_list = 1;
> > @@ -3242,8 +3244,6 @@ static long calc_group_shares(struct cfs_rq *cfs_rq)
> >  }
> >  #endif /* CONFIG_SMP */
> >
> > -static inline int throttled_hierarchy(struct cfs_rq *cfs_rq);
> > -
> >  /*
> >   * Recomputes the group entity based on the current state of its group
> >   * runqueue.
> > @@ -4356,16 +4356,10 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
> >               __enqueue_entity(cfs_rq, se);
> >       se->on_rq = 1;
> >
> > -     /*
> > -      * When bandwidth control is enabled, cfs might have been removed
> > -      * because of a parent been throttled but cfs->nr_running > 1. Try to
> > -      * add it unconditionally.
> > -      */
> > -     if (cfs_rq->nr_running == 1 || cfs_bandwidth_used())
> > +     if (cfs_rq->nr_running == 1) {
> >               list_add_leaf_cfs_rq(cfs_rq);
> > -
> > -     if (cfs_rq->nr_running == 1)
> >               check_enqueue_throttle(cfs_rq);
> > +     }
> >  }
> >
> >  static void __clear_buddies_last(struct sched_entity *se)
> > @@ -4980,11 +4974,18 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
> >       /* update hierarchical throttle state */
> >       walk_tg_tree_from(cfs_rq->tg, tg_nop, tg_unthrottle_up, (void *)rq);
> >
> > -     /* Nothing to run but something to decay (on_list)? Complete the branch */
> >       if (!cfs_rq->load.weight) {
> > -             if (cfs_rq->on_list)
> > -                     goto unthrottle_throttle;
> > -             return;
> > +             if (!cfs_rq->on_list)
> > +                     return;
> > +             /*
> > +              * Nothing to run but something to decay (on_list)?
> > +              * Complete the branch.
> > +              */
> > +             for_each_sched_entity(se) {
> > +                     if (list_add_leaf_cfs_rq(cfs_rq_of(se)))
> > +                             break;
> > +             }
> > +             goto unthrottle_throttle;
> >       }
> >
> >       task_delta = cfs_rq->h_nr_running;
> > @@ -5022,31 +5023,12 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
> >               /* end evaluation on encountering a throttled cfs_rq */
> >               if (cfs_rq_throttled(qcfs_rq))
> >                       goto unthrottle_throttle;
> > -
> > -             /*
> > -              * One parent has been throttled and cfs_rq removed from the
> > -              * list. Add it back to not break the leaf list.
> > -              */
> > -             if (throttled_hierarchy(qcfs_rq))
> > -                     list_add_leaf_cfs_rq(qcfs_rq);
> >       }
> >
> >       /* At this point se is NULL and we are at root level*/
> >       add_nr_running(rq, task_delta);
> >
> >  unthrottle_throttle:
> > -     /*
> > -      * The cfs_rq_throttled() breaks in the above iteration can result in
> > -      * incomplete leaf list maintenance, resulting in triggering the
> > -      * assertion below.
> > -      */
> > -     for_each_sched_entity(se) {
> > -             struct cfs_rq *qcfs_rq = cfs_rq_of(se);
> > -
> > -             if (list_add_leaf_cfs_rq(qcfs_rq))
> > -                     break;
> > -     }
> > -
> >       assert_list_leaf_cfs_rq(rq);
> >
> >       /* Determine whether we need to wake up potentially idle CPU: */
> > @@ -5701,13 +5683,6 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
> >               /* end evaluation on encountering a throttled cfs_rq */
> >               if (cfs_rq_throttled(cfs_rq))
> >                       goto enqueue_throttle;
> > -
> > -               /*
> > -                * One parent has been throttled and cfs_rq removed from the
> > -                * list. Add it back to not break the leaf list.
> > -                */
> > -               if (throttled_hierarchy(cfs_rq))
> > -                       list_add_leaf_cfs_rq(cfs_rq);
> >       }
> >
> >       /* At this point se is NULL and we are at root level*/
> > @@ -5731,21 +5706,6 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
> >               update_overutilized_status(rq);
> >
> >  enqueue_throttle:
> > -     if (cfs_bandwidth_used()) {
> > -             /*
> > -              * When bandwidth control is enabled; the cfs_rq_throttled()
> > -              * breaks in the above iteration can result in incomplete
> > -              * leaf list maintenance, resulting in triggering the assertion
> > -              * below.
> > -              */
> > -             for_each_sched_entity(se) {
> > -                     cfs_rq = cfs_rq_of(se);
> > -
> > -                     if (list_add_leaf_cfs_rq(cfs_rq))
> > -                             break;
> > -             }
> > -     }
> > -
> >       assert_list_leaf_cfs_rq(rq);
> >
> >       hrtick_update(rq);
