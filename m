Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5156538624
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 18:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238729AbiE3Qb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 12:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233727AbiE3Qb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 12:31:26 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58DB49A983
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 09:31:24 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id l204so9098820ybf.10
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 09:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=anw7j66xDAbgLwKqE878q5J8sc6mH72ypPnJaho9Zlo=;
        b=H+VDqvdowr3p4fLpidKQ5J2/ln7UvYfB9jWpmFWrDICpan94Fjv4SOO9xToEhdFbOz
         23ABbDQ7WF04MSJA0IwOtrSo9+lCsaZc+++wvbE4Svxz7GVjUZQO3u6EKEHYujq3y9ww
         QDGABi6Yn8rbxyXLYTW5pEdACkYUeC6W8thjcJAVItc9f4Li9CmnVIbox7wq1W3cFAID
         IIE12q9oBZEJxPEBoM4+igfLhrZUAzP/bEsxbh3e0ymnDF0wAubSOU8ag/+Cz3oB3/MK
         Ofq/hgPevq92lt6hYXxx0+McnsPfsyzxaNMGwntjtzeBbjNiWT5R/YzQHf9381p5zkGD
         LAaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=anw7j66xDAbgLwKqE878q5J8sc6mH72ypPnJaho9Zlo=;
        b=2NA71E9ajqJaVWAsvq9+VCKfmls6oAFTkl5lbewBlEIz7Khe1EBC1/pRUOFFJZIFY8
         W3A48Pbp5YqPyVaFPk9hAV32QJWaXpGs8xHqYVoFL0+jjX3PX7qQQZHyyddjA2YTZYlk
         aOzj2ItiQJANbr5R90nKcwlNdXHeicSOJpkzTLBhy0qcMxg3mx2IYl1JuB0/kr/IABeE
         Y1bdr/e5WVPrLgNkj9svTRJbfGVq8w6XkvTwvWm7QiBLwnwsLnU8piArrSwc/w5beoCA
         FnPeLHObdL8f7bloy3JZ9PG5nucmqyv4c59u5XEhE3oi+85EVLcP9V7kkbeEB17W6Ybw
         hI1w==
X-Gm-Message-State: AOAM532KsGF6yBYl0NoYBK/r30gkf3oOuta2cbOwd6aB4i+tJqBwajaR
        rCVh4yL+pL7T3kfDRKXMJ7/hUpicA2Ku8vjozwxpQA==
X-Google-Smtp-Source: ABdhPJztDibQjA2Pfcm8KECHmwC+yzDwrYhM24BYQGWeX4opH1SUdmUWER1i6++rqr0GxjlZ86A19hTkeUMw/tI83+8=
X-Received: by 2002:a5b:8:0:b0:65c:3b20:6c95 with SMTP id a8-20020a5b0008000000b0065c3b206c95mr12976536ybp.241.1653928283440;
 Mon, 30 May 2022 09:31:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220523155140.2878563-1-vdonnefort@google.com> <20220523155140.2878563-3-vdonnefort@google.com>
In-Reply-To: <20220523155140.2878563-3-vdonnefort@google.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 30 May 2022 18:31:11 +0200
Message-ID: <CAKfTPtDOw1WumFmRvKFX55DcamBCH=4zMUXX0=uzFBUKjE--qg@mail.gmail.com>
Subject: Re: [PATCH v9 2/7] sched/fair: Decay task PELT values during wakeup migration
To:     Vincent Donnefort <vdonnefort@google.com>
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com,
        qperret@google.com, tao.zhou@linux.dev, kernel-team@android.com,
        Vincent Donnefort <vincent.donnefort@arm.com>
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

On Mon, 23 May 2022 at 17:52, Vincent Donnefort <vdonnefort@google.com> wrote:
>
> From: Vincent Donnefort <vincent.donnefort@arm.com>
>
> Before being migrated to a new CPU, a task sees its PELT values
> synchronized with rq last_update_time. Once done, that same task will also

it's the cfs_rq last_update_time not the rq

> have its sched_avg last_update_time reset. This means the time between
> the migration and the last clock update will not be accounted for in
> util_avg and a discontinuity will appear. This issue is amplified by the
> PELT clock scaling. It takes currently one tick after the CPU being idle
> to let clock_pelt catching up clock_task.
>
> This is especially problematic for asymmetric CPU capacity systems which
> need stable util_avg signals for task placement and energy estimation.
>
> Ideally, this problem would be solved by updating the runqueue clocks
> before the migration. But that would require taking the runqueue lock
> which is quite expensive [1]. Instead estimate the missing time and update
> the task util_avg with that value.
>
> To that end, we need sched_clock_cpu() but it is a costly function. Limit
> the usage to the case where the source CPU is idle as we know this is when
> the clock is having the biggest risk of being outdated. In this such case,
> let's call it cfs_idle_lag the delta time between the rq_clock_pelt value
> at rq idle and cfs_rq idle. And rq_idle_lag the delta between "now" and
> the rq_clock_pelt at rq idle.
>
> The estimated PELT clock is then:
>
>    last_update_time + (the cfs_rq's last_update_time)
>    cfs_idle_lag + (delta between cfs_rq's update and rq's update)
>    rq_idle_lag (delta between rq's update and now)

moving '+' at the beginning of the line make it easier to understand

    last_update_time (the cfs_rq's last_update_time)
    + cfs_idle_lag (delta between cfs_rq's update and rq's update)
    + rq_idle_lag (delta between rq's update and now)

>
>   last_update_time = cfs_rq_clock_pelt()
>                    = rq_clock_pelt() - cfs->throttled_clock_pelt_time
>
>   cfs_idle_lag = rq_clock_pelt()@rq_idle -
>                  rq_clock_pelt()@cfs_rq_idle
>
>   rq_idle_lag = sched_clock_cpu() - rq_clock()@rq_idle
>
> The rq_clock_pelt() from last_update_time being the same as
> rq_clock_pelt()@cfs_rq_idle, we can write:
>
>   estimation = rq_clock_pelt()@rq_idle - cfs->throttled_clock_pelt_time +
>                sched_clock_cpu() - rq_clock()@rq_idle
>
> The clocks being not accessible without the rq lock taken, some timestamps
> are created:
>
>       rq_clock_pelt()@rq_idle        is rq->clock_pelt_idle
>       rq_clock()@rq_idle             is rq->enter_idle
>       cfs->throttled_clock_pelt_time is cfs_rq->throttled_pelt_idle
>
> The rq_idle_lag part of the missing time is however an estimation that
> doesn't take into account IRQ and Paravirt time.
>
> [1] https://lore.kernel.org/all/20190709115759.10451-1-chris.redpath@arm.com/
>
> Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
> Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

minor typo but otherwise

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

Thanks

>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 05614d9b919c..df5e6e565b4d 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3310,6 +3310,29 @@ static inline void cfs_rq_util_change(struct cfs_rq *cfs_rq, int flags)
>  }
>
>  #ifdef CONFIG_SMP
> +static inline bool load_avg_is_decayed(struct sched_avg *sa)
> +{
> +       if (sa->load_sum)
> +               return false;
> +
> +       if (sa->util_sum)
> +               return false;
> +
> +       if (sa->runnable_sum)
> +               return false;
> +
> +       /*
> +        * _avg must be null when _sum are null because _avg = _sum / divider
> +        * Make sure that rounding and/or propagation of PELT values never
> +        * break this.
> +        */
> +       SCHED_WARN_ON(sa->load_avg ||
> +                     sa->util_avg ||
> +                     sa->runnable_avg);
> +
> +       return true;
> +}
> +
>  static inline u64 cfs_rq_last_update_time(struct cfs_rq *cfs_rq)
>  {
>         return u64_u32_load_copy(cfs_rq->avg.last_update_time,
> @@ -3347,27 +3370,12 @@ static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
>         if (cfs_rq->load.weight)
>                 return false;
>
> -       if (cfs_rq->avg.load_sum)
> -               return false;
> -
> -       if (cfs_rq->avg.util_sum)
> -               return false;
> -
> -       if (cfs_rq->avg.runnable_sum)
> +       if (!load_avg_is_decayed(&cfs_rq->avg))
>                 return false;
>
>         if (child_cfs_rq_on_list(cfs_rq))
>                 return false;
>
> -       /*
> -        * _avg must be null when _sum are null because _avg = _sum / divider
> -        * Make sure that rounding and/or propagation of PELT values never
> -        * break this.
> -        */
> -       SCHED_WARN_ON(cfs_rq->avg.load_avg ||
> -                     cfs_rq->avg.util_avg ||
> -                     cfs_rq->avg.runnable_avg);
> -
>         return true;
>  }
>
> @@ -3706,6 +3714,88 @@ static inline void add_tg_cfs_propagate(struct cfs_rq *cfs_rq, long runnable_sum
>
>  #endif /* CONFIG_FAIR_GROUP_SCHED */
>
> +#ifdef CONFIG_NO_HZ_COMMON
> +static inline void migrate_se_pelt_lag(struct sched_entity *se)
> +{
> +       u64 throttled = 0, now, lut;
> +       struct cfs_rq *cfs_rq;
> +       struct rq *rq;
> +       bool is_idle;
> +
> +       if (load_avg_is_decayed(&se->avg))
> +               return;
> +
> +       cfs_rq = cfs_rq_of(se);
> +       rq = rq_of(cfs_rq);
> +
> +       rcu_read_lock();
> +       is_idle = is_idle_task(rcu_dereference(rq->curr));
> +       rcu_read_unlock();
> +
> +       /*
> +        * The lag estimation comes with a cost we don't want to pay all the
> +        * time. Hence, limiting to the case where the source CPU is idle and
> +        * we know we are at the greatest risk to have an outdated clock.
> +        */
> +       if (!is_idle)
> +               return;
> +
> +       /*
> +        * Estimated "now" is: last_update_time + cfs_idle_lag + rq_idle_lag, where:
> +        *
> +        *   last_update_time (the cfs_rq's last_update_time)
> +        *      = cfs_rq_clock_pelt()
> +        *      = rq_clock_pelt() - cfs->throttled_clock_pelt_time
> +        *
> +        *   cfs_idle_lag (delta between cfs_rq's update and rq's update)
> +        *      = rq_clock_pelt()@rq_idle - rq_clock_pelt()@cfs_rq_idle
> +        *
> +        *   rq_idle_lag (delta between rq's update and now)
> +        *      = sched_clock_cpu() - rq_clock()@rq_idle
> +        *
> +        * The rq_clock_pelt() from last_update_time being the same as
> +        * rq_clock_pelt()@cfs_rq_idle, we can write:
> +        *
> +        *    now = rq_clock_pelt()@rq_idle - cfs->throttled_clock_pelt_time +
> +        *          sched_clock_cpu() - rq_clock()@rq_idle
> +        * Where:
> +        *      rq_clock_pelt()@rq_idle        is rq->clock_pelt_idle
> +        *      rq_clock()@rq_idle             is rq->enter_idle
> +        *      cfs->throttled_clock_pelt_time is cfs_rq->throttled_pelt_idle
> +        */
> +
> +#ifdef CONFIG_CFS_BANDWIDTH
> +       throttled = u64_u32_load(cfs_rq->throttled_pelt_idle);
> +       /* The clock has been stopped for throttling */
> +       if (throttled == U64_MAX)
> +               return;
> +#endif
> +       now = u64_u32_load(rq->clock_pelt_idle);
> +       /*
> +        * Paired with _update_idle_rq_clock_pelt. It ensures at the worst case
> +        * is observed the old clock_pelt_idle value and the new enter_idle,
> +        * which lead to an understimation. The opposite would lead to an

s/understimation/underestimation/

> +        * overestimation.
> +        */
> +       smp_rmb();
> +       lut = cfs_rq_last_update_time(cfs_rq);
> +
> +       now -= throttled;
> +       if (now < lut)
> +               /*
> +                * cfs_rq->avg.last_update_time is more recent than our
> +                * estimation, let's use it.
> +                */
> +               now = lut;
> +       else
> +               now += sched_clock_cpu(cpu_of(rq)) - u64_u32_load(rq->enter_idle);
> +
> +       __update_load_avg_blocked_se(now, se);
> +}
> +#else
> +static void migrate_se_pelt_lag(struct sched_entity *se) {}
> +#endif
> +
>  /**
>   * update_cfs_rq_load_avg - update the cfs_rq's load/util averages
>   * @now: current time, as per cfs_rq_clock_pelt()
> @@ -4437,6 +4527,9 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>          */
>         if ((flags & (DEQUEUE_SAVE | DEQUEUE_MOVE)) != DEQUEUE_SAVE)
>                 update_min_vruntime(cfs_rq);
> +
> +       if (cfs_rq->nr_running == 0)
> +               update_idle_cfs_rq_clock_pelt(cfs_rq);
>  }
>
>  /*
> @@ -6911,6 +7004,8 @@ static void detach_entity_cfs_rq(struct sched_entity *se);
>   */
>  static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
>  {
> +       struct sched_entity *se = &p->se;
> +
>         /*
>          * As blocked tasks retain absolute vruntime the migration needs to
>          * deal with this by subtracting the old and adding the new
> @@ -6918,7 +7013,6 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
>          * the task on the new runqueue.
>          */
>         if (READ_ONCE(p->__state) == TASK_WAKING) {
> -               struct sched_entity *se = &p->se;
>                 struct cfs_rq *cfs_rq = cfs_rq_of(se);
>
>                 se->vruntime -= u64_u32_load(cfs_rq->min_vruntime);
> @@ -6930,25 +7024,29 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
>                  * rq->lock and can modify state directly.
>                  */
>                 lockdep_assert_rq_held(task_rq(p));
> -               detach_entity_cfs_rq(&p->se);
> +               detach_entity_cfs_rq(se);
>
>         } else {
> +               remove_entity_load_avg(se);
> +
>                 /*
> -                * We are supposed to update the task to "current" time, then
> -                * its up to date and ready to go to new CPU/cfs_rq. But we
> -                * have difficulty in getting what current time is, so simply
> -                * throw away the out-of-date time. This will result in the
> -                * wakee task is less decayed, but giving the wakee more load
> -                * sounds not bad.
> +                * Here, the task's PELT values have been updated according to
> +                * the current rq's clock. But if that clock hasn't been
> +                * updated in a while, a substantial idle time will be missed,
> +                * leading to an inflation after wake-up on the new rq.
> +                *
> +                * Estimate the missing time from the cfs_rq last_update_time
> +                * and update sched_avg to improve the PELT continuity after
> +                * migration.
>                  */
> -               remove_entity_load_avg(&p->se);
> +               migrate_se_pelt_lag(se);
>         }
>
>         /* Tell new CPU we are migrated */
> -       p->se.avg.last_update_time = 0;
> +       se->avg.last_update_time = 0;
>
>         /* We have migrated, no longer consider this task hot */
> -       p->se.exec_start = 0;
> +       se->exec_start = 0;
>
>         update_scan_period(p, new_cpu);
>  }
> @@ -8114,6 +8212,10 @@ static bool __update_blocked_fair(struct rq *rq, bool *done)
>                 if (update_cfs_rq_load_avg(cfs_rq_clock_pelt(cfs_rq), cfs_rq)) {
>                         update_tg_load_avg(cfs_rq);
>
> +                       /* sync clock_pelt_idle with last update */
> +                       if (cfs_rq->nr_running == 0)
> +                               update_idle_cfs_rq_clock_pelt(cfs_rq);
> +
>                         if (cfs_rq == &rq->cfs)
>                                 decayed = true;
>                 }
> diff --git a/kernel/sched/pelt.h b/kernel/sched/pelt.h
> index 4ff2ed4f8fa1..647e5fcc041b 100644
> --- a/kernel/sched/pelt.h
> +++ b/kernel/sched/pelt.h
> @@ -61,6 +61,25 @@ static inline void cfs_se_util_change(struct sched_avg *avg)
>         WRITE_ONCE(avg->util_est.enqueued, enqueued);
>  }
>
> +static inline u64 rq_clock_pelt(struct rq *rq)
> +{
> +       lockdep_assert_rq_held(rq);
> +       assert_clock_updated(rq);
> +
> +       return rq->clock_pelt - rq->lost_idle_time;
> +}
> +
> +/* The rq is idle, we can sync to clock_task */
> +static inline void _update_idle_rq_clock_pelt(struct rq *rq)
> +{
> +       rq->clock_pelt  = rq_clock_task(rq);
> +
> +       u64_u32_store(rq->enter_idle, rq_clock(rq));
> +       /* Paired with smp_rmb in migrate_se_pelt_lag */
> +       smp_wmb();
> +       u64_u32_store(rq->clock_pelt_idle, rq_clock_pelt(rq));
> +}
> +
>  /*
>   * The clock_pelt scales the time to reflect the effective amount of
>   * computation done during the running delta time but then sync back to
> @@ -76,8 +95,7 @@ static inline void cfs_se_util_change(struct sched_avg *avg)
>  static inline void update_rq_clock_pelt(struct rq *rq, s64 delta)
>  {
>         if (unlikely(is_idle_task(rq->curr))) {
> -               /* The rq is idle, we can sync to clock_task */
> -               rq->clock_pelt  = rq_clock_task(rq);
> +               _update_idle_rq_clock_pelt(rq);
>                 return;
>         }
>
> @@ -130,17 +148,23 @@ static inline void update_idle_rq_clock_pelt(struct rq *rq)
>          */
>         if (util_sum >= divider)
>                 rq->lost_idle_time += rq_clock_task(rq) - rq->clock_pelt;
> +
> +       _update_idle_rq_clock_pelt(rq);
>  }
>
> -static inline u64 rq_clock_pelt(struct rq *rq)
> +#ifdef CONFIG_CFS_BANDWIDTH
> +static inline void update_idle_cfs_rq_clock_pelt(struct cfs_rq *cfs_rq)
>  {
> -       lockdep_assert_rq_held(rq);
> -       assert_clock_updated(rq);
> +       u64 throttled;
>
> -       return rq->clock_pelt - rq->lost_idle_time;
> +       if (unlikely(cfs_rq->throttle_count))
> +               throttled = U64_MAX;
> +       else
> +               throttled = cfs_rq->throttled_clock_pelt_time;
> +
> +       u64_u32_store(cfs_rq->throttled_pelt_idle, throttled);
>  }
>
> -#ifdef CONFIG_CFS_BANDWIDTH
>  /* rq->task_clock normalized against any time this cfs_rq has spent throttled */
>  static inline u64 cfs_rq_clock_pelt(struct cfs_rq *cfs_rq)
>  {
> @@ -150,6 +174,7 @@ static inline u64 cfs_rq_clock_pelt(struct cfs_rq *cfs_rq)
>         return rq_clock_pelt(rq_of(cfs_rq)) - cfs_rq->throttled_clock_pelt_time;
>  }
>  #else
> +static inline void update_idle_cfs_rq_clock_pelt(struct cfs_rq *cfs_rq) { }
>  static inline u64 cfs_rq_clock_pelt(struct cfs_rq *cfs_rq)
>  {
>         return rq_clock_pelt(rq_of(cfs_rq));
> @@ -204,6 +229,7 @@ update_rq_clock_pelt(struct rq *rq, s64 delta) { }
>  static inline void
>  update_idle_rq_clock_pelt(struct rq *rq) { }
>
> +static inline void update_idle_cfs_rq_clock_pelt(struct cfs_rq *cfs_rq) { }
>  #endif
>
>
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index bf4a0ec98678..97bc26e5c8af 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -648,6 +648,10 @@ struct cfs_rq {
>         int                     runtime_enabled;
>         s64                     runtime_remaining;
>
> +       u64                     throttled_pelt_idle;
> +#ifndef CONFIG_64BIT
> +       u64                     throttled_pelt_idle_copy;
> +#endif
>         u64                     throttled_clock;
>         u64                     throttled_clock_pelt;
>         u64                     throttled_clock_pelt_time;
> @@ -1020,6 +1024,12 @@ struct rq {
>         u64                     clock_task ____cacheline_aligned;
>         u64                     clock_pelt;
>         unsigned long           lost_idle_time;
> +       u64                     clock_pelt_idle;
> +       u64                     enter_idle;
> +#ifndef CONFIG_64BIT
> +       u64                     clock_pelt_idle_copy;
> +       u64                     enter_idle_copy;
> +#endif
>
>         atomic_t                nr_iowait;
>
> --
> 2.36.1.124.g0e6072fb45-goog
>
