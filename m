Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8EDE514A65
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 15:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353001AbiD2N0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 09:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232889AbiD2N0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 09:26:46 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A76C8651
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 06:23:27 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id f38so14484054ybi.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 06:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wz3EzdrtfPU2QUe78y/a9hmd09MeAAEnns0tCtz1LMM=;
        b=k0VRoQg9y3hAbdslXgXNgEVpKKuuZA+2kp4F9PHcwk/y1uru0dmD21kbhP4evedXn4
         zRMmEuL3TUzUzwBAN64On9P2LbTaHz8gWYBqc8GO99JNdqqmAxrHFnkrw6r+IFCTaz2/
         F6KII64KQ9CeXmGIiQmXY9bqMBtaxRr6Bj/W0QBx2rXwyO+gwo+qSsiMiu1cGzXDVxTm
         mn2aAlghqcwMF3CNPUuCeBqTirmK7XbvvZA2nM7BDKsCi0P/l5uUMo8hLEpLv7HvFJtE
         1kSnqIe2s9EZPBuGYYEUdMby7s0qZC9oMU5ZZCde6Q438+ncVT1X8mOLIy1Pbf8qCjAm
         vZJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wz3EzdrtfPU2QUe78y/a9hmd09MeAAEnns0tCtz1LMM=;
        b=CPSe5l2fH4qynyMouXLmj3ZuwTDFzxsBpPXBw5wM2+NiVGBpePI+91ivhsabGY2xPB
         +SIGEcEZkcUnQ+ePgvZdRUUIa634qDMZhMWkTNXC2Xv8EXBRbCchxoz20vpI2Y0r3KkF
         EQ+YLlHGnQIICDNll4GgNgWkLLYcr9yN5GolsbLttRHjMrpJIovrM87Vlp4VJ50NvL+f
         pHhQf9D6uWTWN/Cwryj2c4EYcUITd8cZnAyD8CNGnmDuYf39NTCv9DYb9lD3Jie4wmRX
         ZeikSmBMKgIiQBZRc4h0FJ2c+GoRl2oHvZ8oZkHsJ9tF4ipJOmuMIWSZ6WjdywfJQvxa
         FTeA==
X-Gm-Message-State: AOAM533IsTMgkLo0+8RYINLnuVXN7oJyHFpaMoTPHZNfDYrjetF86kWp
        zffD6KzU0YLzpVdFf8AQZbDekA3eJeqoSds1jgBtqC15xPE=
X-Google-Smtp-Source: ABdhPJx8+ZjX+atmM37NElQgdlqFQw8KDT+p697Cokugaf15FLSLv/i+YcUoPI6vSROJp9Axy6KLKKDWx/gu4/aAVW4=
X-Received: by 2002:a25:6f54:0:b0:648:b8a1:d212 with SMTP id
 k81-20020a256f54000000b00648b8a1d212mr17160768ybc.225.1651238606700; Fri, 29
 Apr 2022 06:23:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220427143304.3950488-1-vincent.donnefort@arm.com>
 <20220427143304.3950488-3-vincent.donnefort@arm.com> <Yml/icTe26CfweCd@geo.homenetwork>
 <CAKfTPtCsZTm_jx-BS00UkFUqW66x--6T8Bb2LRsD1S0a3rN0iQ@mail.gmail.com>
 <YmrNS6JmjkMDj8SL@geo.homenetwork> <20220429082000.GA14214@vingu-book> <YmvfXjGBeasdKNfQ@geo.homenetwork>
In-Reply-To: <YmvfXjGBeasdKNfQ@geo.homenetwork>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 29 Apr 2022 15:23:15 +0200
Message-ID: <CAKfTPtCMA+H7HNvi=N6EZhhn6JnLQ2Mf5fDWQ8FK5Hh8G-ffTg@mail.gmail.com>
Subject: Re: [PATCH v7 2/7] sched/fair: Decay task PELT values during wakeup migration
To:     Tao Zhou <tao.zhou@linux.dev>
Cc:     Vincent Donnefort <vincent.donnefort@arm.com>,
        peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com, qperret@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Apr 2022 at 14:51, Tao Zhou <tao.zhou@linux.dev> wrote:
>
> On Fri, Apr 29, 2022 at 10:20:00AM +0200, Vincent Guittot wrote:
>
> > Le vendredi 29 avril 2022 =C3=A0 01:22:19 (+0800), Tao Zhou a =C3=A9cri=
t :
> > > Hi Vincent,
> > >
> > > On Thu, Apr 28, 2022 at 03:38:39PM +0200, Vincent Guittot wrote:
> > >
> > > > On Wed, 27 Apr 2022 at 19:37, Tao Zhou <tao.zhou@linux.dev> wrote:
> > > > >
> >
> > [..]
> >
> > > > > > +                     /* sync clock_pelt_idle with last update =
*/
> > > > > > +                     if (cfs_rq->nr_running =3D=3D 0)
> > > > > > +                             update_idle_cfs_rq_clock_pelt(cfs=
_rq);
> > > > >
> > > > > I think that if cfs_rq->nr_running =3D=3D 0 then use cfs rq pelt_=
idle to update
> > > > > idle cfs rq.
> > > >
> > > > update_blocked_averages() updates all cfs rq to be aligned with now=
 so
> > > > we don't need to calculate an estimated now. update_rq_clock(rq) is
> > > > called 1st to update the rq->clock and childs
> > > >
> > > > With only need to save when happened the last update which is done =
in
> > > > update_rq_clock_pelt(rq) for rq->clock_pelt and with
> > > > update_idle_cfs_rq_clock_pelt(cfs) for the cfs_rq_clock_pelt
> > >
> > > I missed this.
> >
> > I ended up with something a bit different:
> >
> > ---
> >  kernel/sched/fair.c  | 133 ++++++++++++++++++++++++++++++++++---------
> >  kernel/sched/pelt.h  |  66 ++++++++++++++++++---
> >  kernel/sched/sched.h |  10 ++++
> >  3 files changed, 174 insertions(+), 35 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index abd1feeec0c2..63e4cf225292 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -3335,27 +3335,12 @@ static inline bool cfs_rq_is_decayed(struct cfs=
_rq *cfs_rq)
> >       if (cfs_rq->load.weight)
> >               return false;
> >
> > -     if (cfs_rq->avg.load_sum)
> > -             return false;
> > -
> > -     if (cfs_rq->avg.util_sum)
> > -             return false;
> > -
> > -     if (cfs_rq->avg.runnable_sum)
> > +     if (load_avg_is_decayed(&cfs_rq->avg))
> >               return false;
> >
> >       if (child_cfs_rq_on_list(cfs_rq))
> >               return false;
> >
> > -     /*
> > -      * _avg must be null when _sum are null because _avg =3D _sum / d=
ivider
> > -      * Make sure that rounding and/or propagation of PELT values neve=
r
> > -      * break this.
> > -      */
> > -     SCHED_WARN_ON(cfs_rq->avg.load_avg ||
> > -                   cfs_rq->avg.util_avg ||
> > -                   cfs_rq->avg.runnable_avg);
> > -
> >       return true;
> >  }
> >
> > @@ -3694,6 +3679,88 @@ static inline void add_tg_cfs_propagate(struct c=
fs_rq *cfs_rq, long runnable_sum
> >
> >  #endif /* CONFIG_FAIR_GROUP_SCHED */
> >
> > +#ifdef CONFIG_NO_HZ_COMMON
> > +static inline void migrate_se_pelt_lag(struct sched_entity *se)
> > +{
> > +     struct cfs_rq *cfs_rq;
> > +     struct rq *rq;
> > +     bool is_idle;
> > +     u64 now, throttled =3D 0;
> > +
> > +     /* utilization is already fully decayed */
> > +     if (load_avg_is_decayed(&se->avg))
> > +             return;
> > +
> > +     cfs_rq =3D cfs_rq_of(se);
> > +     rq =3D rq_of(cfs_rq);
> > +
> > +     rcu_read_lock();
> > +     is_idle =3D is_idle_task(rcu_dereference(rq->curr));
> > +     rcu_read_unlock();
> > +
> > +     /*
> > +      * The lag estimation comes with a cost we don't want to pay all =
the
> > +      * time. Hence, limiting to the case where the source CPU is idle=
 and
> > +      * we know we are at the greatest risk to have an outdated clock.
> > +      */
> > +     if (!is_idle)
> > +             return;
> > +
> > +     /*
> > +      * Estimated "now" is:
> > +      *   last_update_time: last update of the cfs_lock_pelt +
> > +      *   cfs_idle_lag: rq_clock_pelt delta bewteen last cfs update an=
d last rq update +
>
> s/bewteen/between/
>
> > +      *   rq_idle_lag: rq_clock delta between last rq update and now
> > +      *
> > +      * with
> > +      *
> > +      * last_update_time =3D=3D cfs_clock_pelt()
> > +      *                  =3D=3D rq_clock_pelt() - cfs->throttled_clock=
_pelt_time
> > +      *
> > +      * cfs_idle_lag: rq_clock_pelt() when rq is idle - rq_clock_pelt(=
) when cfs is idle
> > +      *
> > +      * rq_idle_lag : sched_clock_cpu() - rq_clock() when rq is idle
> > +      *
> > +      * In fact, rq_clock_pelt() that is used for last_update_time and=
 when
> > +      * cfs is idle are the same because their last update happens att=
he
>
> s/atthe/at the/
>
> > +      * same time.
> > +      *
> > +      * We can optimize "now" to be:
> > +      *   rq_clock_pelt when rq is idle - cfs->throttled_clock_pelt_ti=
me when cfs is idle +
> > +      *   sched_clock_cpu() - rq_clock() when rq is idle
> > +      *
> > +      * when rq is idle
> > +      *   rq_clock_pelt() is saved in rq->clock_pelt_idle
> > +      *   rq_clock()  is saved in rq->enter idle
> > +      *
> > +      * when cfs is idle
> > +      *    cfs->throttled_clock_pelt_time is saved in cfs_rq->throttle=
d_pelt_idle
> > +      *
> > +      * When !CFS_BANDWIDTH, cfs->throttled_clock_pelt_time is null
> > +      */
> > +
> > +#ifdef CONFIG_CFS_BANDWIDTH
> > +     throttled =3D u64_u32_load(cfs_rq->throttled_pelt_idle);
> > +     /* The clock has been stopped for throttling */
> > +     if (throttled =3D=3D U64_MAX)
> > +             return;
> > +#endif
> > +
> > +     now =3D u64_u32_load(rq->clock_pelt_idle);
> > +     now -=3D throttled;
> > +
> > +     /* An update happened while computing lag */
> > +     if (now < cfs_rq_last_update_time(cfs_rq))
> > +             return;
> > +
> > +     now +=3D sched_clock_cpu(cpu_of(rq)) - u64_u32_load(rq->enter_idl=
e);
> > +
> > +     __update_load_avg_blocked_se(now, se);
> > +}
> > +#else
> > +static void migrate_se_pelt_lag(struct sched_entity *se) {}
> > +#endif
> > +
> >  /**
> >   * update_cfs_rq_load_avg - update the cfs_rq's load/util averages
> >   * @now: current time, as per cfs_rq_clock_pelt()
> > @@ -4429,6 +4496,9 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sche=
d_entity *se, int flags)
> >        */
> >       if ((flags & (DEQUEUE_SAVE | DEQUEUE_MOVE)) !=3D DEQUEUE_SAVE)
> >               update_min_vruntime(cfs_rq);
> > +
> > +     if (cfs_rq->nr_running =3D=3D 0)
> > +             update_idle_cfs_rq_clock_pelt(cfs_rq);
> >  }
> >
> >  /*
> > @@ -6946,6 +7016,8 @@ static void detach_entity_cfs_rq(struct sched_ent=
ity *se);
> >   */
> >  static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
> >  {
> > +     struct sched_entity *se =3D &p->se;
> > +
> >       /*
> >        * As blocked tasks retain absolute vruntime the migration needs =
to
> >        * deal with this by subtracting the old and adding the new
> > @@ -6953,7 +7025,6 @@ static void migrate_task_rq_fair(struct task_stru=
ct *p, int new_cpu)
> >        * the task on the new runqueue.
> >        */
> >       if (READ_ONCE(p->__state) =3D=3D TASK_WAKING) {
> > -             struct sched_entity *se =3D &p->se;
> >               struct cfs_rq *cfs_rq =3D cfs_rq_of(se);
> >
> >               se->vruntime -=3D u64_u32_load(cfs_rq->min_vruntime);
> > @@ -6965,25 +7036,29 @@ static void migrate_task_rq_fair(struct task_st=
ruct *p, int new_cpu)
> >                * rq->lock and can modify state directly.
> >                */
> >               lockdep_assert_rq_held(task_rq(p));
> > -             detach_entity_cfs_rq(&p->se);
> > +             detach_entity_cfs_rq(se);
> >
> >       } else {
> > +             remove_entity_load_avg(se);
> > +
> >               /*
> > -              * We are supposed to update the task to "current" time, =
then
> > -              * its up to date and ready to go to new CPU/cfs_rq. But =
we
> > -              * have difficulty in getting what current time is, so si=
mply
> > -              * throw away the out-of-date time. This will result in t=
he
> > -              * wakee task is less decayed, but giving the wakee more =
load
> > -              * sounds not bad.
> > +              * Here, the task's PELT values have been updated accordi=
ng to
> > +              * the current rq's clock. But if that clock hasn't been
> > +              * updated in a while, a substantial idle time will be mi=
ssed,
> > +              * leading to an inflation after wake-up on the new rq.
> > +              *
> > +              * Estimate the missing time from the cfs_rq last_update_=
time
> > +              * and update sched_avg to improve the PELT continuity af=
ter
> > +              * migration.
> >                */
> > -             remove_entity_load_avg(&p->se);
> > +             migrate_se_pelt_lag(se);
> >       }
> >
> >       /* Tell new CPU we are migrated */
> > -     p->se.avg.last_update_time =3D 0;
> > +     se->avg.last_update_time =3D 0;
> >
> >       /* We have migrated, no longer consider this task hot */
> > -     p->se.exec_start =3D 0;
> > +     se->exec_start =3D 0;
> >
> >       update_scan_period(p, new_cpu);
> >  }
> > @@ -8149,6 +8224,10 @@ static bool __update_blocked_fair(struct rq *rq,=
 bool *done)
> >               if (update_cfs_rq_load_avg(cfs_rq_clock_pelt(cfs_rq), cfs=
_rq)) {
> >                       update_tg_load_avg(cfs_rq);
> >
> > +                     /* sync clock_pelt_idle with last update */
> > +                     if (cfs_rq->nr_running =3D=3D 0)
> > +                             update_idle_cfs_rq_clock_pelt(cfs_rq);
> > +
> >                       if (cfs_rq =3D=3D &rq->cfs)
> >                               decayed =3D true;
> >               }
> > diff --git a/kernel/sched/pelt.h b/kernel/sched/pelt.h
> > index 4ff2ed4f8fa1..4143c6dc64dc 100644
> > --- a/kernel/sched/pelt.h
> > +++ b/kernel/sched/pelt.h
> > @@ -37,6 +37,29 @@ update_irq_load_avg(struct rq *rq, u64 running)
> >  }
> >  #endif
> >
> > +static inline bool load_avg_is_decayed(struct sched_avg *sa)
> > +{
> > +     if (sa->load_sum)
> > +             return false;
> > +
> > +     if (sa->util_sum)
> > +             return false;
> > +
> > +     if (sa->runnable_sum)
> > +             return false;
> > +
> > +     /*
> > +      * _avg must be null when _sum are null because _avg =3D _sum / d=
ivider
> > +      * Make sure that rounding and/or propagation of PELT values neve=
r
> > +      * break this.
> > +      */
> > +     SCHED_WARN_ON(sa->load_avg ||
> > +                   sa->util_avg ||
> > +                   sa->runnable_avg);
> > +
> > +     return true;
> > +}
> > +
> >  #define PELT_MIN_DIVIDER     (LOAD_AVG_MAX - 1024)
> >
> >  static inline u32 get_pelt_divider(struct sched_avg *avg)
> > @@ -61,6 +84,23 @@ static inline void cfs_se_util_change(struct sched_a=
vg *avg)
> >       WRITE_ONCE(avg->util_est.enqueued, enqueued);
> >  }
> >
> > +static inline u64 rq_clock_pelt(struct rq *rq)
> > +{
> > +     lockdep_assert_rq_held(rq);
> > +     assert_clock_updated(rq);
> > +
> > +     return rq->clock_pelt - rq->lost_idle_time;
> > +}
> > +
> > +/* The rq is idle, we can sync to clock_task */
> > +static inline void _update_idle_rq_clock_pelt(struct rq *rq)
> > +{
> > +     rq->clock_pelt  =3D rq_clock_task(rq);
> > +
> > +     u64_u32_store(rq->enter_idle, rq_clock(rq));
> > +     u64_u32_store(rq->clock_pelt_idle, rq_clock_pelt(rq));
> > +}
> > +
> >  /*
> >   * The clock_pelt scales the time to reflect the effective amount of
> >   * computation done during the running delta time but then sync back t=
o
> > @@ -76,8 +116,7 @@ static inline void cfs_se_util_change(struct sched_a=
vg *avg)
> >  static inline void update_rq_clock_pelt(struct rq *rq, s64 delta)
> >  {
> >       if (unlikely(is_idle_task(rq->curr))) {
> > -             /* The rq is idle, we can sync to clock_task */
> > -             rq->clock_pelt  =3D rq_clock_task(rq);
> > +             _update_idle_rq_clock_pelt(rq);
> >               return;
> >       }
> >
> > @@ -130,17 +169,26 @@ static inline void update_idle_rq_clock_pelt(stru=
ct rq *rq)
> >        */
> >       if (util_sum >=3D divider)
> >               rq->lost_idle_time +=3D rq_clock_task(rq) - rq->clock_pel=
t;
> > +
> > +     _update_idle_rq_clock_pelt(rq);
> >  }
> >
> > -static inline u64 rq_clock_pelt(struct rq *rq)
> > +#ifdef CONFIG_CFS_BANDWIDTH
> > +static inline void update_idle_cfs_rq_clock_pelt(struct cfs_rq *cfs_rq=
)
> >  {
> > -     lockdep_assert_rq_held(rq);
> > -     assert_clock_updated(rq);
> > -
> > -     return rq->clock_pelt - rq->lost_idle_time;
> > +     /*
> > +      * Make sure that pending update of rq->clock_pelt_idle and
> > +      * rq->enter_idle are visible during update_blocked_average() bef=
ore
> > +      * updating cfs_rq->throttled_pelt_idle.
> > +      */
> > +     smp_wmb();
>
> No smp_rmb() at read side and I feel it is in migrate_se_pelt_lag()
> before this line=EF=BC=9A
>     =E2=80=98now =3D u64_u32_load(rq->clock_pelt_idle);=E2=80=99
> The load of cfs_rq->throttled_pelt_idle should be valid before the load
> of rq->clock_pelt_idle and rq->enter_idle. This is paired with the write
> side in update_idle_cfs_rq_clock_pelt().

Yes

>
> > +     if (unlikely(cfs_rq->throttle_count))
> > +             u64_u32_store(cfs_rq->throttled_pelt_idle, U64_MAX);
> > +     else
> > +             u64_u32_store(cfs_rq->throttled_pelt_idle,
> > +                           cfs_rq->throttled_clock_pelt_time);
> >  }
> >
> > -#ifdef CONFIG_CFS_BANDWIDTH
> >  /* rq->task_clock normalized against any time this cfs_rq has spent th=
rottled */
> >  static inline u64 cfs_rq_clock_pelt(struct cfs_rq *cfs_rq)
> >  {
> > @@ -150,6 +198,7 @@ static inline u64 cfs_rq_clock_pelt(struct cfs_rq *=
cfs_rq)
> >       return rq_clock_pelt(rq_of(cfs_rq)) - cfs_rq->throttled_clock_pel=
t_time;
> >  }
> >  #else
> > +static inline void update_idle_cfs_rq_clock_pelt(struct cfs_rq *cfs_rq=
) { }
> >  static inline u64 cfs_rq_clock_pelt(struct cfs_rq *cfs_rq)
> >  {
> >       return rq_clock_pelt(rq_of(cfs_rq));
> > @@ -204,6 +253,7 @@ update_rq_clock_pelt(struct rq *rq, s64 delta) { }
> >  static inline void
> >  update_idle_rq_clock_pelt(struct rq *rq) { }
> >
> > +static inline void update_idle_cfs_rq_clock_pelt(struct cfs_rq *cfs_rq=
) { }
> >  #endif
> >
> >
> > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > index e2cf6e48b165..ea9365e1a24e 100644
> > --- a/kernel/sched/sched.h
> > +++ b/kernel/sched/sched.h
> > @@ -641,6 +641,10 @@ struct cfs_rq {
> >       int                     runtime_enabled;
> >       s64                     runtime_remaining;
> >
> > +     u64                     throttled_pelt_idle;
> > +#ifndef CONFIG_64BIT
> > +     u64                     throttled_pelt_idle_copy;
> > +#endif
> >       u64                     throttled_clock;
> >       u64                     throttled_clock_pelt;
> >       u64                     throttled_clock_pelt_time;
> > @@ -1013,6 +1017,12 @@ struct rq {
> >       u64                     clock_task ____cacheline_aligned;
> >       u64                     clock_pelt;
> >       unsigned long           lost_idle_time;
> > +     u64                     clock_pelt_idle;
> > +     u64                     enter_idle;
> > +#ifndef CONFIG_64BIT
> > +     u64                     clock_pelt_idle_copy;
> > +     u64                     enter_idle_copy;
> > +#endif
> >
> >       atomic_t                nr_iowait;
> >
> > --
> > 2.17.1
