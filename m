Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA52955E2E6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239540AbiF1A2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 20:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233155AbiF1A2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 20:28:47 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E735C1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 17:28:46 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-3177f4ce3e2so101331817b3.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 17:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OI8KFS/MG8qYDZZOBh+beFO1gKec4GF6QKoqxod5QFQ=;
        b=noNgb/VbH44goc3ZUEsYRujiK+oPLe3kvD/nb8Y3yUqvGFlIkmSQGkjJxw40yuE2kV
         6TVweWjXEp+3PiAM6Or9a1DedSv/2Kd4mXGMTZ2lVJ4i6hMsGcqjk4kvWq4KbV8jKRt3
         lGX9KCQ3Nsz9FOI2C/RvrFeSkbtTYoN3CTGqNPNgZKvaoxFkIIsgl28fap7KshOA4o9z
         8zAGlbf85zC2CprB/ejtqCFWA9dccVDqiHnuTz2PORkfOL459vTevKtGjvRDSiO9+das
         kNyOeMIdJ1gFnt0PidBfXvir6EVf3ExJm4qK4MiMkYdEpf1hP1AewsOr1N8Xc25d2Iig
         w21A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OI8KFS/MG8qYDZZOBh+beFO1gKec4GF6QKoqxod5QFQ=;
        b=Etu8qkRgOEPWVKrUmlQy1wPDdCp6NLedghUmEwexsGA6aIdfUNUBqF5WAgmDDmEsWp
         bQ/iFFxKgxuIeAreFWlpjZHwvJmibk72oO+tIH9HTBQNejEkUcupUp9oEyaqlB87U2k2
         rjTvoO0pAykJzmwGT5cqqzyjTX+b7pbeKYF+uTgiqhQ1IfDxohp7zFXC1kmE45OntXza
         rJU3nDSm24EPCxjMis5iNhVRjfdhMq24B4lvlZ4hkdw/KbuajS2DjAz6dkoWrWvDP7V5
         EGKwIva57R3eqypNF7I7MqizUBl0kTFFR8njVQ65TvzyrnMhgpkLeMthsK6m2o0ipIkn
         mcfQ==
X-Gm-Message-State: AJIora8eICyE/DSW+AiuKoPdN6nl0lvsBXmTf7h8THmBH7ZFLYggufGQ
        N6ftSB9GPV5qsMQ9o/LnBadEWlnRSaaCzWYG6AUoGA==
X-Google-Smtp-Source: AGRyM1vHEwZDkZLQsHKKdpUUDKO7xI6aDgTqgQ7MMS428HH/kztQIriYFH8gRJOCEQvoqQauDzfAuK9pyZD+/e4ifas=
X-Received: by 2002:a81:9847:0:b0:317:cba2:2558 with SMTP id
 p68-20020a819847000000b00317cba22558mr18673314ywg.440.1656376125288; Mon, 27
 Jun 2022 17:28:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220619120451.95251-1-wuyun.abel@bytedance.com> <20220619120451.95251-6-wuyun.abel@bytedance.com>
In-Reply-To: <20220619120451.95251-6-wuyun.abel@bytedance.com>
From:   Josh Don <joshdon@google.com>
Date:   Mon, 27 Jun 2022 17:28:34 -0700
Message-ID: <CABk29NtsTgJT1c-Vg6B5dgYbi+nHEDk2vsBRzRowCXiOPT2qnA@mail.gmail.com>
Subject: Re: [PATCH v4 5/7] sched/fair: skip SIS domain search if fully busy
To:     Abel Wu <wuyun.abel@bytedance.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Chen Yu <yu.c.chen@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 19, 2022 at 5:05 AM Abel Wu <wuyun.abel@bytedance.com> wrote:
>
> If a full scan on SIS domain failed, then no unoccupied cpus available
> and the LLC is fully busy. In this case we'd better spend the time on
> something more useful, rather than wasting it trying to find an idle
> cpu that probably not exist.
>
> The fully busy status will be re-evaluated when any core of this LLC
> domain enters load balancing, and cleared once idle cpus found.
>
> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
> ---
>  include/linux/sched/topology.h | 35 ++++++++++++++-
>  kernel/sched/fair.c            | 82 +++++++++++++++++++++++++++++-----
>  2 files changed, 104 insertions(+), 13 deletions(-)
>
> diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
> index 56cffe42abbc..3e99ac98d766 100644
> --- a/include/linux/sched/topology.h
> +++ b/include/linux/sched/topology.h
> @@ -77,10 +77,43 @@ extern int sched_domain_level_max;
>
>  struct sched_group;
>
> +/*
> + * States of the sched-domain
> + *
> + * - sd_has_icores
> + *     This state is only used in LLC domains to indicate worthy
> + *     of a full scan in SIS due to idle cores available.
> + *
> + * - sd_has_icpus
> + *     This state indicates that unoccupied (sched-idle/idle) cpus
> + *     might exist in this domain. For the LLC domains it is the
> + *     default state since these cpus are the main targets of SIS
> + *     search, and is also used as a fallback state of the other
> + *     states.
> + *
> + * - sd_is_busy
> + *     This state indicates there are no unoccupied cpus in this
> + *     domain. So for LLC domains, it gives the hint on whether
> + *     we should put efforts on the SIS search or not.
> + *
> + * For LLC domains, sd_has_icores is set when the last non-idle cpu of
> + * a core becomes idle. After a full SIS scan and if no idle cores found,
> + * sd_has_icores must be cleared and the state will be set to sd_has_icpus
> + * or sd_is_busy depending on whether there is any idle cpu. And during
> + * load balancing on each SMT domain inside the LLC, the state will be
> + * re-evaluated and switch from sd_is_busy to sd_has_icpus if idle cpus
> + * exist.
> + */
> +enum sd_state {
> +       sd_has_icores,
> +       sd_has_icpus,
> +       sd_is_busy
> +};
> +
>  struct sched_domain_shared {
>         atomic_t        ref;
>         atomic_t        nr_busy_cpus;
> -       int             has_idle_cores;
> +       int             state;  /* see enum sd_state */

nit: s/int/enum sd_state

>  };
>
>  struct sched_domain {
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 1cc86e76e38e..2ca37fdc6c4d 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5642,11 +5642,15 @@ static inline void update_overutilized_status(struct rq *rq)
>  static inline void update_overutilized_status(struct rq *rq) { }
>  #endif
>
> +static int unoccupied_rq(struct rq *rq)
> +{
> +       return rq->nr_running == rq->cfs.idle_h_nr_running;
> +}

nit: static inline int

> +
>  /* Runqueue only has SCHED_IDLE tasks enqueued */
>  static int sched_idle_rq(struct rq *rq)
>  {
> -       return unlikely(rq->nr_running == rq->cfs.idle_h_nr_running &&
> -                       rq->nr_running);
> +       return unlikely(rq->nr_running && unoccupied_rq(rq));
>  }
>
>  /*
> @@ -6197,24 +6201,44 @@ static inline int __select_idle_cpu(int cpu, struct task_struct *p)
>  DEFINE_STATIC_KEY_FALSE(sched_smt_present);
>  EXPORT_SYMBOL_GPL(sched_smt_present);
>
> -static inline void set_idle_cores(int cpu, int val)
> +static inline void sd_set_state(int cpu, enum sd_state state)
>  {
>         struct sched_domain_shared *sds;
>
>         sds = rcu_dereference(per_cpu(sd_llc_shared, cpu));
>         if (sds)
> -               WRITE_ONCE(sds->has_idle_cores, val);
> +               WRITE_ONCE(sds->state, state);
>  }
>
> -static inline bool test_idle_cores(int cpu)
> +static inline enum sd_state sd_get_state(int cpu)
>  {
>         struct sched_domain_shared *sds;
>
>         sds = rcu_dereference(per_cpu(sd_llc_shared, cpu));
>         if (sds)
> -               return READ_ONCE(sds->has_idle_cores);
> +               return READ_ONCE(sds->state);
>
> -       return false;
> +       return sd_has_icpus;
> +}

Why is default not sd_is_busy?

> +
> +static inline void set_idle_cores(int cpu, int idle)

nit: Slightly confusing to call the param 'idle', since in the case it
is false we still mark icpus. Consider possibly 'core_idle'.

> +{
> +       sd_set_state(cpu, idle ? sd_has_icores : sd_has_icpus);
> +}
> +
> +static inline bool test_idle_cores(int cpu)
> +{
> +       return sd_get_state(cpu) == sd_has_icores;
> +}
> +
> +static inline void set_idle_cpus(int cpu, int idle)
> +{
> +       sd_set_state(cpu, idle ? sd_has_icpus : sd_is_busy);
> +}
> +
> +static inline bool test_idle_cpus(int cpu)
> +{
> +       return sd_get_state(cpu) != sd_is_busy;
>  }
>
>  /*
> @@ -6298,7 +6322,7 @@ static int select_idle_smt(struct task_struct *p, int target)
>
>  #else /* CONFIG_SCHED_SMT */
>
> -static inline void set_idle_cores(int cpu, int val)
> +static inline void set_idle_cores(int cpu, int idle)
>  {
>  }
>
> @@ -6307,6 +6331,15 @@ static inline bool test_idle_cores(int cpu)
>         return false;
>  }
>
> +static inline void set_idle_cpus(int cpu, int idle)
> +{
> +}
> +
> +static inline bool test_idle_cpus(int cpu)
> +{
> +       return true;
> +}
> +
>  static inline int select_idle_core(struct task_struct *p, int core, struct cpumask *cpus, int *idle_cpu)
>  {
>         return __select_idle_cpu(core, p);
> @@ -6382,7 +6415,9 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
>                 }
>         }
>
> -       if (has_idle_core)
> +       if (idle_cpu == -1)
> +               set_idle_cpus(target, false);
> +       else if (has_idle_core)
>                 set_idle_cores(target, false);
>
>         if (sched_feat(SIS_PROP) && !has_idle_core) {
> @@ -6538,6 +6573,9 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>                         if ((unsigned int)i < nr_cpumask_bits)
>                                 return i;
>                 }
> +
> +               if (!has_idle_core && !test_idle_cpus(target))
> +                       return target;
>         }
>
>         i = select_idle_cpu(p, sd, has_idle_core, target);
> @@ -8303,6 +8341,8 @@ struct sd_lb_stats {
>         unsigned long avg_load; /* Average load across all groups in sd */
>         unsigned int prefer_sibling; /* tasks should go to sibling first */
>
> +       int sd_state;
> +
>         struct sg_lb_stats busiest_stat;/* Statistics of the busiest group */
>         struct sg_lb_stats local_stat;  /* Statistics of the local group */
>  };
> @@ -8321,6 +8361,7 @@ static inline void init_sd_lb_stats(struct sd_lb_stats *sds)
>                 .local = NULL,
>                 .total_load = 0UL,
>                 .total_capacity = 0UL,
> +               .sd_state = sd_is_busy,
>                 .busiest_stat = {
>                         .idle_cpus = UINT_MAX,
>                         .group_type = group_has_spare,
> @@ -8661,6 +8702,12 @@ sched_asym(struct lb_env *env, struct sd_lb_stats *sds,  struct sg_lb_stats *sgs
>         return sched_asym_prefer(env->dst_cpu, group->asym_prefer_cpu);
>  }
>
> +static inline void sd_classify(struct sd_lb_stats *sds, struct rq *rq)
> +{
> +       if (sds->sd_state != sd_has_icpus && unoccupied_rq(rq))
> +               sds->sd_state = sd_has_icpus;
> +}
> +
>  /**
>   * update_sg_lb_stats - Update sched_group's statistics for load balancing.
>   * @env: The load balancing environment.
> @@ -8675,11 +8722,12 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>                                       struct sg_lb_stats *sgs,
>                                       int *sg_status)
>  {
> -       int i, nr_running, local_group;
> +       int i, nr_running, local_group, update_core;
>
>         memset(sgs, 0, sizeof(*sgs));
>
>         local_group = group == sds->local;
> +       update_core = env->sd->flags & SD_SHARE_CPUCAPACITY;

Nothing special about SD_SHARE_CPUCAPACITY here other than you want to
do the update early on at the lowest domain level during balancing
right?


>         for_each_cpu_and(i, sched_group_span(group), env->cpus) {
>                 struct rq *rq = cpu_rq(i);
> @@ -8692,6 +8740,9 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>                 nr_running = rq->nr_running;
>                 sgs->sum_nr_running += nr_running;
>
> +               if (update_core)
> +                       sd_classify(sds, rq);
> +
>                 if (nr_running > 1)
>                         *sg_status |= SG_OVERLOAD;
>
> @@ -9220,6 +9271,12 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
>         return idlest;
>  }
>
> +static void sd_update_state(struct lb_env *env, struct sd_lb_stats *sds)
> +{
> +       if (sds->sd_state == sd_has_icpus && !test_idle_cpus(env->dst_cpu))
> +               set_idle_cpus(env->dst_cpu, true);
> +}

We're only setting state to has_icpus here in sd_update_state. That
doesn't feel good enough, since we're only updating state for
env->dst_cpu; all the other per-cpu state will remain stale (ie.
falsely sd_is_busy).

I think you also want a case in __update_idle_core() to call
set_idle_cores(core, 0) in the case where we have a non-idle sibling,
since we want to at least mark has_icpus even if the entire core isn't
idle.

Still, that doesn't feel quite good enough, since we're only updating
the per_cpu sd state for the given cpu. That seems like it will
frequently leave us with idle cpus, and select_idle_sibling() skipping
select_idle_cpu due to a false negative from test_idle_cpus(). Am I
missing something there?

> +
>  /**
>   * update_sd_lb_stats - Update sched_domain's statistics for load balancing.
>   * @env: The load balancing environment.
> @@ -9270,8 +9327,9 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
>         /* Tag domain that child domain prefers tasks go to siblings first */
>         sds->prefer_sibling = child && child->flags & SD_PREFER_SIBLING;
>
> -
> -       if (env->sd->flags & SD_NUMA)
> +       if (env->sd->flags & SD_SHARE_CPUCAPACITY)
> +               sd_update_state(env, sds);
> +       else if (env->sd->flags & SD_NUMA)
>                 env->fbq_type = fbq_classify_group(&sds->busiest_stat);
>
>         if (!env->sd->parent) {
> --
> 2.31.1
>
