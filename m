Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E20050685D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 12:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348980AbiDSKLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 06:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235416AbiDSKLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 06:11:17 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 579202528A
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 03:08:31 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-2eafabbc80aso166082167b3.11
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 03:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i0Q+Crc1VqlydEOjUU3KZ/Zdf7phXGpJG6Tv9xzpWdM=;
        b=Beu3cv80U0IwQTHVy4/OycSepRFHwoXAS26KLV2atF+2vsyBQScs1U2hd0+ejJ/88n
         PPGfmJtJ80b96q60igRJhSWibgaRL6s8fVlTR+/MSfRUf3N/Bxam/rwFDBYbadko8yZn
         GSoYXbCBZ0cFXJJzgvysWGHz8Imtad+scZPc+CMIQgn66uMQSwRhfarxObKehEFGcGSK
         eNgsTjsx0IF98FHI3tOAznh6JRCOY7RcnLy2Ym/mfhOjxGb0ohMXYoJRgLGbK71BIfsU
         zDykXBRnTbSlZj/P5DWjTfy38riwzfWBpKvZMADR7CPw6HYJI1mI+5orIz0LLrbCDCBu
         tPFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i0Q+Crc1VqlydEOjUU3KZ/Zdf7phXGpJG6Tv9xzpWdM=;
        b=qpv1ajNEKmf/de9M3A56RZeYaNe8LvRCYIoAqfP9RbygsWTQ0OliStFziQq38LtGyZ
         qL2rshLA+CrnvFEroOa/oNZom9cFKtelnZHxmWHaxNkV2hwEVAyTz7m4a+cnX6Iu2E6r
         BFHEETx7yB8uZPNpwJdn25cOl2Q3FNgM4C9WIbl0kufpI+m/UZHa5wvSMahANC9/1kSG
         Q3j7/jTqT+1y3NHyC2urUHl0/LX9IYop4IJtT7YrLfYc+VUYwGT+w0S1i6gHIq6fmTgC
         sVL3ADxmmw/HbFgHie0/32+YclVkjZQuokE1x1DJFkxuXNwD4H4jJYuDMWvxeMdhXUJr
         EsGw==
X-Gm-Message-State: AOAM531O5xvwj9oNRCjqb1GQDPg25m/0tGsk4W3+AxxHn0uVp6iDFzXr
        GQXYKWzgEDDVSCfAIPGCrZHns3aELxBBgb85qokkUQ==
X-Google-Smtp-Source: ABdhPJxADTm4TrYS+fkix7CxO5FppD+mFfWxzzPoHZWrzWj/A92AqDlT1fLP3cDkjIiIfULFzrjebJvDp4Eimp3wVUk=
X-Received: by 2002:a81:490f:0:b0:2ec:22d0:bdb7 with SMTP id
 w15-20020a81490f000000b002ec22d0bdb7mr14520891ywa.320.1650362910502; Tue, 19
 Apr 2022 03:08:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220412134220.1588482-1-vincent.donnefort@arm.com> <20220412134220.1588482-3-vincent.donnefort@arm.com>
In-Reply-To: <20220412134220.1588482-3-vincent.donnefort@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 19 Apr 2022 12:08:19 +0200
Message-ID: <CAKfTPtAZMwgKK8m5vdEjsXRJ73YWrZePoCtCu5KKBELtQMp3DA@mail.gmail.com>
Subject: Re: [PATCH v4 2/7] sched/fair: Decay task PELT values during wakeup migration
To:     Vincent Donnefort <vincent.donnefort@arm.com>
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com, qperret@google.com
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

On Tue, 12 Apr 2022 at 15:42, Vincent Donnefort
<vincent.donnefort@arm.com> wrote:
>
> Before being migrated to a new CPU, a task sees its PELT values
> synchronized with rq last_update_time. Once done, that same task will also
> have its sched_avg last_update_time reset. This means the time between
> the migration and the last clock update (B) will not be accounted for in
> util_avg and a discontinuity will appear. This issue is amplified by the
> PELT clock scaling. If the clock hasn't been updated while the CPU is
> idle, clock_pelt will not be aligned with clock_task and that time (A)
> will be also lost.
>
>    ---------|----- A -----|-----------|------- B -----|>
>         clock_pelt   clock_task     clock            now
>
> This is especially problematic for asymmetric CPU capacity systems which
> need stable util_avg signals for task placement and energy estimation.
>
> Ideally, this problem would be solved by updating the runqueue clocks
> before the migration. But that would require taking the runqueue lock
> which is quite expensive [1]. Instead estimate the missing time and update
> the task util_avg with that value:
>
>   A + B = clock_task - clock_pelt + sched_clock_cpu() - clock
>
> Neither clock_task, clock_pelt nor clock can be accessed without the
> runqueue lock. The new cfs_rq last_update_lag is therefore created and
> contains those three values when the last_update_time value for that very
> same cfs_rq is updated.
>
>   last_update_lag = clock - clock_task + clock_pelt
>
> And we can then write the missing time as follow:
>
>   A + B = sched_clock_cpu() - last_update_lag
>
> The B. part of the missing time is however an estimation that doesn't take
> into account IRQ and Paravirt time.
>
> Now we have an estimation for A + B, we can create an estimator for the
> PELT value at the time of the migration. We need for this purpose to
> inject last_update_time which is a combination of both clock_pelt and
> lost_idle_time. The latter is a time value which is completely lost from a
> PELT point of view and must be ignored. And finally, we can write:
>
>   now = last_update_time + A + B
>       = last_update_time + sched_clock_cpu() - last_update_lag
>
> This estimation has a cost, mostly due to sched_clock_cpu(). Limit the
> usage to the case where the source CPU is idle as we know this is when the
> clock is having the biggest risk of being outdated.
>
> [1] https://lore.kernel.org/all/20190709115759.10451-1-chris.redpath@arm.com/
>
> Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 5dd38c9df0cc..e234d015657f 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3694,6 +3694,57 @@ static inline void add_tg_cfs_propagate(struct cfs_rq *cfs_rq, long runnable_sum
>
>  #endif /* CONFIG_FAIR_GROUP_SCHED */
>
> +#ifdef CONFIG_NO_HZ_COMMON
> +static inline void update_cfs_rq_lag(struct cfs_rq *cfs_rq)
> +{
> +       struct rq *rq = rq_of(cfs_rq);
> +
> +       u64_u32_store(cfs_rq->last_update_lag,
> +#ifdef CONFIG_CFS_BANDWIDTH
> +                     /* Timer stopped by throttling */
> +                     unlikely(cfs_rq->throttle_count) ? U64_MAX :
> +#endif
> +                     rq->clock - rq->clock_task + rq->clock_pelt);

I'm worried that we will call this for each and every
update_cfs_rq_load_avg() whereas the content will be used only when
idle and not throttled. Can't we use these conditions to save values
only when needed and limit the number of useless updates ?

A quick test with hackbench on a 8 cpus system gives
around 60k call for a duration 550 msec run a root level
and 180k from a 3rd level cgroups

> +}
> +
> +static inline void migrate_se_pelt_lag(struct sched_entity *se)
> +{
> +       u64 now, last_update_lag;
> +       struct cfs_rq *cfs_rq;
> +       struct rq *rq;
> +       bool is_idle;
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
> +       last_update_lag = u64_u32_load(cfs_rq->last_update_lag);
> +
> +       /* The clock has been stopped for throttling */
> +       if (last_update_lag == U64_MAX)
> +               return;
> +
> +       now = se->avg.last_update_time - last_update_lag +
> +             sched_clock_cpu(cpu_of(rq));
> +
> +       __update_load_avg_blocked_se(now, se);
> +}
> +#else
> +static void update_cfs_rq_lag(struct cfs_rq *cfs_rq) {}
> +static void migrate_se_pelt_lag(struct sched_entity *se) {}
> +#endif
> +
>  /**
>   * update_cfs_rq_load_avg - update the cfs_rq's load/util averages
>   * @now: current time, as per cfs_rq_clock_pelt()
> @@ -3774,6 +3825,7 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
>                            cfs_rq->last_update_time_copy,
>                            sa->last_update_time);
>  #endif
> +       update_cfs_rq_lag(cfs_rq);
>
>         return decayed;
>  }
> @@ -6946,6 +6998,8 @@ static void detach_entity_cfs_rq(struct sched_entity *se);
>   */
>  static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
>  {
> +       struct sched_entity *se = &p->se;
> +
>         /*
>          * As blocked tasks retain absolute vruntime the migration needs to
>          * deal with this by subtracting the old and adding the new
> @@ -6953,7 +7007,6 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
>          * the task on the new runqueue.
>          */
>         if (READ_ONCE(p->__state) == TASK_WAKING) {
> -               struct sched_entity *se = &p->se;
>                 struct cfs_rq *cfs_rq = cfs_rq_of(se);
>
>                 se->vruntime -= u64_u32_load(cfs_rq->min_vruntime);
> @@ -6965,25 +7018,28 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
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
> +                * Estimate the missing time from the rq clock and update
> +                * sched_avg to improve the PELT continuity after migration.
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
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index e2cf6e48b165..2f6446295e7d 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -593,6 +593,12 @@ struct cfs_rq {
>         struct sched_avg        avg;
>  #ifndef CONFIG_64BIT
>         u64                     last_update_time_copy;
> +#endif
> +#ifdef CONFIG_NO_HZ_COMMON
> +       u64                     last_update_lag;
> +#ifndef CONFIG_64BIT
> +       u64                     last_update_lag_copy;
> +#endif
>  #endif
>         struct {
>                 raw_spinlock_t  lock ____cacheline_aligned;
> --
> 2.25.1
>
