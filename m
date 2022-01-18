Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0276492429
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 11:57:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238215AbiARK4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 05:56:45 -0500
Received: from foss.arm.com ([217.140.110.172]:53532 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238144AbiARK4m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 05:56:42 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C5EC5D6E;
        Tue, 18 Jan 2022 02:56:41 -0800 (PST)
Received: from FVFF7649Q05P (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2DE673F774;
        Tue, 18 Jan 2022 02:56:40 -0800 (PST)
Date:   Tue, 18 Jan 2022 10:56:37 +0000
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        Valentin.Schneider@arm.com, Morten.Rasmussen@arm.com,
        Chris.Redpath@arm.com, qperret@google.com, Lukasz.Luba@arm.com
Subject: Re: [PATCH v2 2/7] sched/fair: Decay task PELT values during
 migration
Message-ID: <Yeac5Y5Fzu/jaUf0@FVFF7649Q05P>
References: <20220112161230.836326-1-vincent.donnefort@arm.com>
 <20220112161230.836326-3-vincent.donnefort@arm.com>
 <CAKfTPtC2wCw4U9w=saW0dGYHfOKo42nBKU7oHcEM7KeDj7MzWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtC2wCw4U9w=saW0dGYHfOKo42nBKU7oHcEM7KeDj7MzWA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2022 at 06:31:25PM +0100, Vincent Guittot wrote:
> On Wed, 12 Jan 2022 at 17:14, Vincent Donnefort
> <vincent.donnefort@arm.com> wrote:
> >
> > Before being migrated to a new CPU, a task sees its PELT values
> > synchronized with rq last_update_time. Once done, that same task will also
> > have its sched_avg last_update_time reset. This means the time between
> > the migration and the last clock update (B) will not be accounted for in
> > util_avg and a discontinuity will appear. This issue is amplified by the
> > PELT clock scaling. If the clock hasn't been updated while the CPU is
> > idle, clock_pelt will not be aligned with clock_task and that time (A)
> > will be also lost.
> >
> >    ---------|----- A -----|-----------|------- B -----|>
> >         clock_pelt   clock_task     clock            now
> >
> > This is especially problematic for asymmetric CPU capacity systems which
> > need stable util_avg signals for task placement and energy estimation.
> >
> > Ideally, this problem would be solved by updating the runqueue clocks
> > before the migration. But that would require taking the runqueue lock
> > which is quite expensive [1]. Instead estimate the missing time and update
> > the task util_avg with that value:
> >
> >   A + B = clock_task - clock_pelt + sched_clock_cpu() - clock
> >
> > Neither clock_task, clock_pelt nor clock can be accessed without the
> > runqueue lock. The new runqueue clock_pelt_lag is therefore created and
> > encode those three values.
> >
> >   clock_pelt_lag = clock - clock_task + clock_pelt
> >
> > And we can then write the missing time as follow:
> >
> >   A + B = sched_clock_cpu() - clock_pelt_lag
> >
> > The B. part of the missing time is however an estimation that doesn't take
> > into account IRQ and Paravirt time.
> >
> > Now we have an estimation for A + B, we can create an estimator for the
> > PELT value at the time of the migration. We need for this purpose to
> > inject last_update_time which is a combination of both clock_pelt and
> > lost_idle_time. The latter is a time value which is completely lost form a
> > PELT point of view and must be ignored. And finally, we can write:
> >
> >   rq_clock_pelt_estimator() = last_update_time + A + B
> >                             = last_update_time +
> >                                    sched_clock_cpu() - clock_pelt_lag
> >
> > [1] https://lore.kernel.org/all/20190709115759.10451-1-chris.redpath@arm.com/
> >
> > Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
> >
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 06cf7620839a..11c6aeef4583 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -618,6 +618,12 @@ struct rq *task_rq_lock(struct task_struct *p, struct rq_flags *rf)
> >         }
> >  }
> >
> > +static void update_rq_clock_pelt_lag(struct rq *rq)
> > +{
> > +       u64_u32_store(rq->clock_pelt_lag,
> > +                     rq->clock - rq->clock_task + rq->clock_pelt);
> 
> This has several shortfalls:
> - have a look at cfs_rq_clock_pelt() and rq_clock_pelt(). What you
> name clock_pelt in your commit message and is used to update PELT and
> saved in se->avg.last_update_time is : rq->clock_pelt -
> rq->lost_idle_time - cfs_rq->throttled_clock_task_time

That's why, the PELT "lag" is added onto se->avg.last_update_time. (see the last
paragraph of the commit message) The estimator is just a time delta, that is
added on top of the entity's last_update_time. I don't see any problem with the
lost_idle_time here.

> - you are doing this whatever the state of the cpu : idle or not. But
> the clock cycles are not accounted for in the same way in both cases.

If the CPU is idle and clock_pelt == clock_task, the component A of the
estimator would be 0 and we only would account for how outdated is the rq's
clock, i.e. component B. 

> - (B) doesn't seem to be accurate as you skip irq and steal time
> accounting and you don't apply any scale invariance if the cpu is not
> idle

The missing irq and paravirt time is the reason why it is called "estimator".
But maybe there's a chance of improving this part with a lockless version of
rq->prev_irq_time and rq->prev_steal_time_rq?

> - IIUC your explanation in the commit message above, the (A) period
> seems to be a problem only when idle but you apply it unconditionally.

If the CPU is idle (and clock_pelt == clock_task), only the B part would be
worth something:

  A + B = [clock_task - clock_pelt] + [sched_clock_cpu() - clock]
                      A                            B

> If cpu is idle you can assume that clock_pelt should be equal to
> clock_task but you can't if cpu is not idle otherwise your sync will
> be inaccurate and defeat the primary goal of this patch. If your
> problem with clock_pelt is that the pending idle time is not accounted
> for when entering idle but only at the next update (update blocked
> load or wakeup of a thread). This patch below should fix this and
> remove your A.

That would help slightly the current situation, but this part is already
covered by the estimator.

> 
> 
> diff --git a/kernel/sched/pelt.h b/kernel/sched/pelt.h
> index e06071bf3472..855877be4dd8 100644
> --- a/kernel/sched/pelt.h
> +++ b/kernel/sched/pelt.h
> @@ -114,6 +114,7 @@ static inline void update_idle_rq_clock_pelt(struct rq *rq)
>  {
>         u32 divider = ((LOAD_AVG_MAX - 1024) << SCHED_CAPACITY_SHIFT)
> - LOAD_AVG_MAX;
>         u32 util_sum = rq->cfs.avg.util_sum;
> +       u64 now = rq_clock_task(rq);
>         util_sum += rq->avg_rt.util_sum;
>         util_sum += rq->avg_dl.util_sum;
> 
> @@ -127,7 +128,10 @@ static inline void update_idle_rq_clock_pelt(struct rq *rq)
>          * rq's clock_task.
>          */
>         if (util_sum >= divider)
> -               rq->lost_idle_time += rq_clock_task(rq) - rq->clock_pelt;
> +               rq->lost_idle_time += now - rq->clock_pelt;
> +
> +       /* The rq is idle, we can sync to clock_task */
> +       rq->clock_pelt  = now;
>  }
> 
>  static inline u64 rq_clock_pelt(struct rq *rq)
> 
> ---
> 
> 
> > +}
> > +
> >  /*
> >   * RQ-clock updating methods:
> >   */
> > @@ -674,6 +680,7 @@ static void update_rq_clock_task(struct rq *rq, s64 delta)
> >                 update_irq_load_avg(rq, irq_delta + steal);
> >  #endif
> >         update_rq_clock_pelt(rq, delta);
> > +       update_rq_clock_pelt_lag(rq);
> >  }
> >
> >  void update_rq_clock(struct rq *rq)
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 99ea9540ece4..046d5397eb8a 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -6852,6 +6852,14 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
> >
> >  static void detach_entity_cfs_rq(struct sched_entity *se);
> >
> > +static u64 rq_clock_pelt_estimator(struct rq *rq, u64 last_update_time)
> > +{
> > +       u64 pelt_lag = sched_clock_cpu(cpu_of(rq)) -
> > +                      u64_u32_load(rq->clock_pelt_lag);
> 
> Have you evaluated the impact of calling sched_clock_cpu(cpu_of(rq))
> for a remote cpu ? especially with a huge number of migration and
> concurrent access from several cpus

I have not, but I will have a look.

> 
> > +
> > +       return last_update_time + pelt_lag;
> > +}
> > +
> >  /*
> >   * Called immediately before a task is migrated to a new CPU; task_cpu(p) and
> >   * cfs_rq_of(p) references at time of call are still valid and identify the
> > @@ -6859,6 +6867,9 @@ static void detach_entity_cfs_rq(struct sched_entity *se);
> >   */
> >  static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
> >  {
> > +       struct sched_entity *se = &p->se;
> > +       struct rq *rq = task_rq(p);
> > +
> >         /*
> >          * As blocked tasks retain absolute vruntime the migration needs to
> >          * deal with this by subtracting the old and adding the new
> > @@ -6866,7 +6877,6 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
> >          * the task on the new runqueue.
> >          */
> >         if (READ_ONCE(p->__state) == TASK_WAKING) {
> > -               struct sched_entity *se = &p->se;
> >                 struct cfs_rq *cfs_rq = cfs_rq_of(se);
> >
> >                 se->vruntime -= u64_u32_load(cfs_rq->min_vruntime);
> > @@ -6877,26 +6887,32 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
> >                  * In case of TASK_ON_RQ_MIGRATING we in fact hold the 'old'
> >                  * rq->lock and can modify state directly.
> >                  */
> > -               lockdep_assert_rq_held(task_rq(p));
> > -               detach_entity_cfs_rq(&p->se);
> > +               lockdep_assert_rq_held(rq);
> > +               detach_entity_cfs_rq(se);
> >
> >         } else {
> > +               u64 now;
> > +
> > +               remove_entity_load_avg(se);
> > +
> >                 /*
> > -                * We are supposed to update the task to "current" time, then
> > -                * its up to date and ready to go to new CPU/cfs_rq. But we
> > -                * have difficulty in getting what current time is, so simply
> > -                * throw away the out-of-date time. This will result in the
> > -                * wakee task is less decayed, but giving the wakee more load
> > -                * sounds not bad.
> > +                * Here, the task's PELT values have been updated according to
> > +                * the current rq's clock. But if that clock hasn't been
> > +                * updated in a while, a substantial idle time will be missed,
> > +                * leading to an inflation after wake-up on the new rq.
> > +                *
> > +                * Estimate the PELT clock lag, and update sched_avg to ensure
> > +                * PELT continuity after migration.
> >                  */
> > -               remove_entity_load_avg(&p->se);
> > +               now = rq_clock_pelt_estimator(rq, se->avg.last_update_time);
> > +               __update_load_avg_blocked_se(now, se);
> >         }
> >
> >         /* Tell new CPU we are migrated */
> > -       p->se.avg.last_update_time = 0;
> > +       se->avg.last_update_time = 0;
> >
> >         /* We have migrated, no longer consider this task hot */
> > -       p->se.exec_start = 0;
> > +       se->exec_start = 0;
> >
> >         update_scan_period(p, new_cpu);
> >  }
> > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > index f1a445efdc63..fdf2a9e54c0e 100644
> > --- a/kernel/sched/sched.h
> > +++ b/kernel/sched/sched.h
> > @@ -1027,8 +1027,13 @@ struct rq {
> >         /* Ensure that all clocks are in the same cache line */
> >         u64                     clock_task ____cacheline_aligned;
> >         u64                     clock_pelt;
> > +       u64                     clock_pelt_lag;
> >         unsigned long           lost_idle_time;
> >
> > +#ifndef CONFIG_64BIT
> > +       u64                     clock_pelt_lag_copy;
> > +#endif
> > +
> >         atomic_t                nr_iowait;
> >
> >  #ifdef CONFIG_SCHED_DEBUG
> > --
> > 2.25.1
> >
