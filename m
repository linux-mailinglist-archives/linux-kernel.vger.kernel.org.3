Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D74457178A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 12:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbiGLKsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 06:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiGLKss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 06:48:48 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A0F989580
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 03:48:46 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CC2781515;
        Tue, 12 Jul 2022 03:48:46 -0700 (PDT)
Received: from wubuntu (unknown [10.57.86.197])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1E9003F792;
        Tue, 12 Jul 2022 03:48:44 -0700 (PDT)
Date:   Tue, 12 Jul 2022 11:48:43 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org, Xuewen Yan <xuewen.yan94@gmail.com>,
        Wei Wang <wvw@google.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>,
        Hank <han.lin@mediatek.com>
Subject: Re: [PATCH 2/7] sched/uclamp: Make task_fits_capacity() use
 util_fits_cpu()
Message-ID: <20220712104843.frbtkgkiftaovcon@wubuntu>
References: <20220629194632.1117723-1-qais.yousef@arm.com>
 <20220629194632.1117723-3-qais.yousef@arm.com>
 <CAKfTPtAxK=NGbpQkiW8-tx3kEwp-M7LAr1Rq_kdWDdsSq7Hd9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKfTPtAxK=NGbpQkiW8-tx3kEwp-M7LAr1Rq_kdWDdsSq7Hd9A@mail.gmail.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/11/22 15:09, Vincent Guittot wrote:
> On Wed, 29 Jun 2022 at 21:48, Qais Yousef <qais.yousef@arm.com> wrote:

[...]

> > @@ -8502,15 +8504,16 @@ static void update_cpu_capacity(struct sched_domain *sd, int cpu)
> >         trace_sched_cpu_capacity_tp(cpu_rq(cpu));
> >
> >         sdg->sgc->capacity = capacity;
> > -       sdg->sgc->min_capacity = capacity;
> > -       sdg->sgc->max_capacity = capacity;
> > +       sdg->sgc->min_capacity_cpu = cpu;
> > +       sdg->sgc->max_capacity_cpu = cpu;
> 
> you make these fields useless. There is only one cpu per sched_group
> at this level so you don't need to save the twice cpu number of the
> nly cpu of this group

Ah, so we can use group->asym_prefer_cpu then?

I think I got confused and thought we could cover multiple capacity levels
there.

> >  }
> >
> >  void update_group_capacity(struct sched_domain *sd, int cpu)
> >  {
> > -       struct sched_domain *child = sd->child;
> >         struct sched_group *group, *sdg = sd->groups;
> > -       unsigned long capacity, min_capacity, max_capacity;
> > +       struct sched_domain *child = sd->child;
> > +       int min_capacity_cpu, max_capacity_cpu;
> > +       unsigned long capacity;
> >         unsigned long interval;
> >
> >         interval = msecs_to_jiffies(sd->balance_interval);
> > @@ -8523,8 +8526,7 @@ void update_group_capacity(struct sched_domain *sd, int cpu)
> >         }
> >
> >         capacity = 0;
> > -       min_capacity = ULONG_MAX;
> > -       max_capacity = 0;
> > +       min_capacity_cpu = max_capacity_cpu = cpu;
> >
> >         if (child->flags & SD_OVERLAP) {
> >                 /*
> > @@ -8536,29 +8538,44 @@ void update_group_capacity(struct sched_domain *sd, int cpu)
> >                         unsigned long cpu_cap = capacity_of(cpu);
> >
> >                         capacity += cpu_cap;
> > -                       min_capacity = min(cpu_cap, min_capacity);
> > -                       max_capacity = max(cpu_cap, max_capacity);
> > +                       if (cpu_cap < capacity_of(min_capacity_cpu))
> > +                               min_capacity_cpu = cpu;
> > +
> > +                       if (cpu_cap > capacity_of(max_capacity_cpu))
> > +                               max_capacity_cpu = cpu;
> >                 }
> >         } else  {
> >                 /*
> >                  * !SD_OVERLAP domains can assume that child groups
> >                  * span the current group.
> >                  */
> > +               unsigned long min_capacity = ULONG_MAX;
> > +               unsigned long max_capacity = 0;
> >
> >                 group = child->groups;
> >                 do {
> >                         struct sched_group_capacity *sgc = group->sgc;
> > +                       unsigned long cpu_cap_min = capacity_of(sgc->min_capacity_cpu);
> > +                       unsigned long cpu_cap_max = capacity_of(sgc->max_capacity_cpu);
> 
> By replacing sgc->min_capacity with sgc->min_capacity_cpu, the
> min_capacity is no more stable and can become > max_capacity

Right.

> 
> >
> >                         capacity += sgc->capacity;
> > -                       min_capacity = min(sgc->min_capacity, min_capacity);
> > -                       max_capacity = max(sgc->max_capacity, max_capacity);
> > +                       if (cpu_cap_min < min_capacity) {
> > +                               min_capacity = cpu_cap_min;
> > +                               min_capacity_cpu = sgc->min_capacity_cpu;
> > +                       }
> > +
> > +                       if (cpu_cap_max > max_capacity) {
> > +                               max_capacity = cpu_cap_max;
> > +                               max_capacity_cpu = sgc->max_capacity_cpu;
> > +                       }
> > +
> >                         group = group->next;
> >                 } while (group != child->groups);
> >         }
> >
> >         sdg->sgc->capacity = capacity;
> > -       sdg->sgc->min_capacity = min_capacity;
> > -       sdg->sgc->max_capacity = max_capacity;
> > +       sdg->sgc->min_capacity_cpu = min_capacity_cpu;
> > +       sdg->sgc->max_capacity_cpu = max_capacity_cpu;
> >  }
> >
> >  /*
> > @@ -8902,7 +8919,7 @@ static bool update_sd_pick_busiest(struct lb_env *env,
> >          * internally or be covered by avg_load imbalance (eventually).
> >          */
> >         if (sgs->group_type == group_misfit_task &&
> > -           (!capacity_greater(capacity_of(env->dst_cpu), sg->sgc->max_capacity) ||
> > +           (!capacity_greater(env->dst_cpu, sg->sgc->max_capacity_cpu) ||
> >              sds->local_stat.group_type != group_has_spare))
> >                 return false;
> >
> > @@ -8986,7 +9003,7 @@ static bool update_sd_pick_busiest(struct lb_env *env,
> >          */
> >         if ((env->sd->flags & SD_ASYM_CPUCAPACITY) &&
> >             (sgs->group_type <= group_fully_busy) &&
> > -           (capacity_greater(sg->sgc->min_capacity, capacity_of(env->dst_cpu))))
> > +           (capacity_greater(sg->sgc->min_capacity_cpu, env->dst_cpu)))
> >                 return false;
> >
> >         return true;
> > @@ -9108,7 +9125,7 @@ static inline void update_sg_wakeup_stats(struct sched_domain *sd,
> >
> >         /* Check if task fits in the group */
> >         if (sd->flags & SD_ASYM_CPUCAPACITY &&
> > -           !task_fits_capacity(p, group->sgc->max_capacity)) {
> > +           !task_fits_cpu(p, group->sgc->max_capacity_cpu)) {
> 
> All the changes and added complexity above for this line. Can't you
> find another way ?

You're right, I might have got carried away trying to keep the logic the same.

Can we use group->asym_prefer_cpu or pick a cpu from group->sgc->cpumask
instead?

I'll dig more into it anyway and try to come up with simpler alternative.


Thanks!

--
Qais Yousef
