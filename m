Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 741B956B349
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 09:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbiGHHRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 03:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237495AbiGHHRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 03:17:48 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B707B7B343
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 00:17:43 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 6so7550697ybc.8
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 00:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4Yu0KW7+9Bd1rQhLTjrom6E2qGYCiTJNNljSOfnndPM=;
        b=JrcfjTQ8LHKEMMcb5dxkAmlHlqVeuPfADlXkw2C2PQhtaJ1pXR6CyBGjHT4pEcMGcm
         YLR3biXzIovOVzkv4joNlDbIN/TyoWM71wumrnUUNkPBl6YyHPo7ukNdQNjEEwzDSKPb
         xVj08BVEBGrds/Tu8SRaSyEABXD6QmpkskCig0FaWOCN3s15v8MJVeVXhLBBHESvAZAg
         qXvbdLYoFwXgxzEg5XGq0y54Sz23VFHcefgBqcDsktTT9d1crgHDdhgqz8ZGD/8rY1cU
         hy9oTTTIQq9H5tkAkITj5ebMiq02/NHxuoXvhvSdVBlSD6DdYltubRK+XHl4os7qY4wO
         IWNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4Yu0KW7+9Bd1rQhLTjrom6E2qGYCiTJNNljSOfnndPM=;
        b=I6TP325Ay4QDR1bfAyG+x/w1OSZLmqYiA/bJymrhzliPLPUSHMOrJJmhRwOMhHOkjU
         8qMyqRR+XtoPvQHuQ5YCfmvv6/BX/aAN1jWewd++0RsmrHM4uOrjTCi2UEXScQ+5NRWQ
         duCLXaOJi36F41vCWyzl8vGfnctPxAEKu/RiltagACDvOrCgVF2OjI91spXpxEc+5teG
         6y+OpuxmMqq9C4Goly9m0yqt+QZJJMTm4rpoTrjijTlDhsTY27jXmyo/acCnZGx6Um5U
         P81Qik7aA2D06xv53kMEx4RONZ9aBZEKDjKL5qXAI2fEJ/AWUxxwrnuCVfsJhcMGzLcG
         2Baw==
X-Gm-Message-State: AJIora/qJ0/dQpXsQsLYbTYb1L5+tuqAR87JjDLn+Fdje8CsTItnN27m
        r8gSDIfiiGrG6BmZGhznNeS7otpyanc7dPZqAn6AFA==
X-Google-Smtp-Source: AGRyM1u7uT/Kv8PBtbHJC9b5FUuKjWc8tpcS0l7j6DRjTU8hb8ZMubKhHHgCCE+Zv019Cj0LLP1wOCOIYRPwmoiw6bY=
X-Received: by 2002:a25:3085:0:b0:66e:4440:f42e with SMTP id
 w127-20020a253085000000b0066e4440f42emr1978855ybw.403.1657264662727; Fri, 08
 Jul 2022 00:17:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220702045254.22922-1-vincent.guittot@linaro.org> <88fab4b6-8e5c-3a4e-e32b-a0867d51398b@arm.com>
In-Reply-To: <88fab4b6-8e5c-3a4e-e32b-a0867d51398b@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 8 Jul 2022 09:17:30 +0200
Message-ID: <CAKfTPtA07H=nkXdyCto9=7Zzixwnu_N_4L-vfn+0ONCQ464biA@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: fix case with reduced capacity CPU
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, david.chen@nutanix.com,
        zhangqiao22@huawei.com
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

On Thu, 7 Jul 2022 at 18:43, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> On 02/07/2022 06:52, Vincent Guittot wrote:
> > The capacity of the CPU available for CFS tasks can be reduced because of
> > other activities running on the latter. In such case, it's worth trying to
> > move CFS tasks on a CPU with more available capacity.
> >
> > The rework of the load balance has filterd the case when the CPU is
> > classified to be fully busy but its capacity is reduced.
> >
> > Check if CPU's capacity is reduced while gathering load balance statistics
> > and classify it group_misfit_task instead of group_fully_busy so we can
> > try to move the load on another CPU.
> >
> > Reported-by: David Chen <david.chen@nutanix.com>
> > Reported-by: Zhang Qiao <zhangqiao22@huawei.com>
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >
> > David, Zhang,
> >
> > I haven't put your tested-by because I have reworked and cleaned the patch to
> > cover more cases.
> >
> > Could you run some tests with this version ?
> >
> > Thanks
> >
> >  kernel/sched/fair.c | 50 ++++++++++++++++++++++++++++++++++++---------
> >  1 file changed, 40 insertions(+), 10 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index a78d2e3b9d49..126b82ef4279 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -8798,6 +8798,19 @@ sched_asym(struct lb_env *env, struct sd_lb_stats *sds,  struct sg_lb_stats *sgs
> >       return sched_asym_prefer(env->dst_cpu, group->asym_prefer_cpu);
> >  }
> >
> > +static inline bool
> > +sched_reduced_capacity(struct rq *rq, struct sched_domain *sd)
> > +{
> > +     /*
> > +      * When there is more than 1 task, the group_overloaded case already
> > +      * takes care of cpu with reduced capacity
> > +      */
> > +     if (rq->cfs.h_nr_running != 1)
> > +             return false;
> > +
> > +     return check_cpu_capacity(rq, sd);
> > +}
> > +
> >  /**
> >   * update_sg_lb_stats - Update sched_group's statistics for load balancing.
> >   * @env: The load balancing environment.
> > @@ -8820,8 +8833,9 @@ static inline void update_sg_lb_stats(struct lb_env *env,
> >
> >       for_each_cpu_and(i, sched_group_span(group), env->cpus) {
> >               struct rq *rq = cpu_rq(i);
> > +             unsigned long load = cpu_load(rq);
> >
> > -             sgs->group_load += cpu_load(rq);
> > +             sgs->group_load += load;
> >               sgs->group_util += cpu_util_cfs(i);
> >               sgs->group_runnable += cpu_runnable(rq);
> >               sgs->sum_h_nr_running += rq->cfs.h_nr_running;
> > @@ -8851,11 +8865,17 @@ static inline void update_sg_lb_stats(struct lb_env *env,
> >               if (local_group)
> >                       continue;
> >
> > -             /* Check for a misfit task on the cpu */
> > -             if (env->sd->flags & SD_ASYM_CPUCAPACITY &&
> > -                 sgs->group_misfit_task_load < rq->misfit_task_load) {
> > -                     sgs->group_misfit_task_load = rq->misfit_task_load;
> > -                     *sg_status |= SG_OVERLOAD;
> > +             if (env->sd->flags & SD_ASYM_CPUCAPACITY) {
> > +                     /* Check for a misfit task on the cpu */
> > +                     if (sgs->group_misfit_task_load < rq->misfit_task_load) {
> > +                             sgs->group_misfit_task_load = rq->misfit_task_load;
> > +                             *sg_status |= SG_OVERLOAD;
> > +                     }
> > +             } else if ((env->idle != CPU_NOT_IDLE) &&
> > +                        sched_reduced_capacity(rq, env->sd) &&
> > +                        (sgs->group_misfit_task_load < load)) {
> > +                     /* Check for a task running on a CPU with reduced capacity */
> > +                     sgs->group_misfit_task_load = load;
> >               }
> >       }
> >
> > @@ -8908,7 +8928,8 @@ static bool update_sd_pick_busiest(struct lb_env *env,
> >        * CPUs in the group should either be possible to resolve
> >        * internally or be covered by avg_load imbalance (eventually).
> >        */
> > -     if (sgs->group_type == group_misfit_task &&
> > +     if ((env->sd->flags & SD_ASYM_CPUCAPACITY) &&
> > +         (sgs->group_type == group_misfit_task) &&
> >           (!capacity_greater(capacity_of(env->dst_cpu), sg->sgc->max_capacity) ||
> >            sds->local_stat.group_type != group_has_spare))
> >               return false;
> > @@ -9517,9 +9538,18 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
> >       busiest = &sds->busiest_stat;
> >
> >       if (busiest->group_type == group_misfit_task) {
> > -             /* Set imbalance to allow misfit tasks to be balanced. */
> > -             env->migration_type = migrate_misfit;
> > -             env->imbalance = 1;
> > +             if (env->sd->flags & SD_ASYM_CPUCAPACITY) {
> > +                     /* Set imbalance to allow misfit tasks to be balanced. */
> > +                     env->migration_type = migrate_misfit;
> > +                     env->imbalance = 1;
> > +             } else {
> > +                     /*
> > +                      * Set load imbalance to allow moving task from cpu
> > +                      * with reduced capacity
> > +                      */
> > +                     env->migration_type = migrate_load;
> > +                     env->imbalance = busiest->group_misfit_task_load;
>
> I'm wondering why you've chosen that hybrid approach `group_misfit_task
> -> migrate_load` and not `group_misfit_task -> migrate_misfit`.

because, it means enabling the tracking of misfit task on rq at each
task enqueue/dequeue/tick ...  Then mistfit for heterogeneous platform
checks max_cpu_capacity what we don't care and will trigger unwanted
misfit migration for smp

>
> It looks like this `rq->cfs.h_nr_running = 1` case almost (since we
> check `busiest->nr_running > 1`) always ends up in the load_balance()
> `if (!ld_moved)` condition and need_active_balance() can return 1 in
> case `if ((env->idle != CPU_NOT_IDLE) && ...` condition. This leads to
> active load_balance and this
>
> IMHO, the same you can achieve when you would stay with
> `group_misfit_task -> migrate_misfit`.
>
> I think cpu_load(rq) can be used instead of `rq->misfit_task_load` in
> the migrate_misfit case of find_busiest_queue() too.

I don't think because you can have a higher cpu_load() but not being misfit

>
> [...]
