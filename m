Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC0F513AC6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 19:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244569AbiD1RZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 13:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234091AbiD1RY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 13:24:59 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FAFF5BD39
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 10:21:42 -0700 (PDT)
Date:   Fri, 29 Apr 2022 01:22:19 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1651166499;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=14oIOwae7vGTu3q8GJ1mkeKhyRyGGAWtEdc1n08dSKE=;
        b=VYMiXMOPHAPCkXHAfiR7xQIMO35ovUziJndObpQPm4f8940zfPZWGZXXzoBS7+WfwTI1jK
        onG8WhlXfjQ1taHAxJ6oaBhUnRV8PAVUxKxE8kfcaxcLigwyy242xkqgqc4kvWBpfkErUH
        ufyJjbcAhZ7Z0xIRUWRTkIROcmW0e+w=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Tao Zhou <tao.zhou@linux.dev>
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        Tao Zhou <tao.zhou@linux.dev>
Cc:     Vincent Donnefort <vincent.donnefort@arm.com>,
        peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com, qperret@google.com
Subject: Re: [PATCH v7 2/7] sched/fair: Decay task PELT values during wakeup
 migration
Message-ID: <YmrNS6JmjkMDj8SL@geo.homenetwork>
References: <20220427143304.3950488-1-vincent.donnefort@arm.com>
 <20220427143304.3950488-3-vincent.donnefort@arm.com>
 <Yml/icTe26CfweCd@geo.homenetwork>
 <CAKfTPtCsZTm_jx-BS00UkFUqW66x--6T8Bb2LRsD1S0a3rN0iQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtCsZTm_jx-BS00UkFUqW66x--6T8Bb2LRsD1S0a3rN0iQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,TO_EQ_FM_DIRECT_MX autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

On Thu, Apr 28, 2022 at 03:38:39PM +0200, Vincent Guittot wrote:

> On Wed, 27 Apr 2022 at 19:37, Tao Zhou <tao.zhou@linux.dev> wrote:
> >
> > On Wed, Apr 27, 2022 at 03:32:59PM +0100, Vincent Donnefort wrote:
> > > Before being migrated to a new CPU, a task sees its PELT values
> > > synchronized with rq last_update_time. Once done, that same task will also
> > > have its sched_avg last_update_time reset. This means the time between
> > > the migration and the last clock update (B) will not be accounted for in
> > > util_avg and a discontinuity will appear. This issue is amplified by the
> > > PELT clock scaling. If the clock hasn't been updated while the CPU is
> > > idle, clock_pelt will not be aligned with clock_task and that time (A)
> > > will be also lost.
> > >
> > >    ---------|----- A -----|-----------|------- B -----|>
> > >         clock_pelt   clock_task     clock            now
> > >
> > > This is especially problematic for asymmetric CPU capacity systems which
> > > need stable util_avg signals for task placement and energy estimation.
> > >
> > > Ideally, this problem would be solved by updating the runqueue clocks
> > > before the migration. But that would require taking the runqueue lock
> > > which is quite expensive [1]. Instead estimate the missing time and update
> > > the task util_avg with that value:
> > >
> > >   A + B = clock_task - clock_pelt + sched_clock_cpu() - clock
> > >
> > > sched_clock_cpu() is a costly function. Limit the usage to the case where
> > > the source CPU is idle as we know this is when the clock is having the
> > > biggest risk of being outdated.
> > >
> > > Neither clock_task, clock_pelt nor clock can be accessed without the
> > > runqueue lock. We then need to store those values in a timestamp variable
> > > which can be accessed during the migration. rq's enter_idle will give the
> > > wall-clock time when the rq went idle. We have then:
> > >
> > >   B = sched_clock_cpu() - rq->enter_idle.
> > >
> > > Then, to catch-up the PELT clock scaling (A), two cases:
> > >
> > >   * !CFS_BANDWIDTH: We can simply use clock_task(). This value is stored
> > >     in rq's clock_pelt_idle, before the rq enters idle. The estimated time
> > >     is then:
> > >
> > >       rq->clock_pelt_idle + sched_clock_cpu() - rq->enter_idle.
> > >
> > >   * CFS_BANDWIDTH: We can't catch-up with clock_task because of the
> > >     throttled_clock_task_time offset. cfs_rq's clock_pelt_idle is then
> > >     giving the PELT clock when the cfs_rq becomes idle. This gives:
> > >
> > >       A = rq->clock_pelt_idle - cfs_rq->clock_pelt_idle
> > >
> > >     And gives the following estimated time:
> > >
> > >       cfs_rq->last_update_time +
> > >       rq->clock_pelt_idle - cfs_rq->clock_pelt_idle + (A)
> > >       sched_clock_cpu() - rq->enter_idle (B)
> > >
> > > The (B) part of the missing time is however an estimation that doesn't
> > > take into account IRQ and Paravirt time.
> > >
> > > [1] https://lore.kernel.org/all/20190709115759.10451-1-chris.redpath@arm.com/
> > >
> > > Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
> > >
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index abd1feeec0c2..9cd506dc682c 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -3694,6 +3694,57 @@ static inline void add_tg_cfs_propagate(struct cfs_rq *cfs_rq, long runnable_sum
> > >
> > >  #endif /* CONFIG_FAIR_GROUP_SCHED */
> > >
> > > +#ifdef CONFIG_NO_HZ_COMMON
> > > +static inline void migrate_se_pelt_lag(struct sched_entity *se)
> > > +{
> > > +     struct cfs_rq *cfs_rq;
> > > +     struct rq *rq;
> > > +     bool is_idle;
> > > +     u64 now;
> > > +
> 
> would it make sense to check if pelt value of the task are not fully
> decayed before starting the below : ie after syncing with
> last_update_time of the cfs

The below diff include this check in.

> > > +     cfs_rq = cfs_rq_of(se);
> > > +     rq = rq_of(cfs_rq);
> > > +
> > > +     rcu_read_lock();
> > > +     is_idle = is_idle_task(rcu_dereference(rq->curr));
> > > +     rcu_read_unlock();
> > > +
> > > +     /*
> > > +      * The lag estimation comes with a cost we don't want to pay all the
> > > +      * time. Hence, limiting to the case where the source CPU is idle and
> > > +      * we know we are at the greatest risk to have an outdated clock.
> > > +      */
> > > +     if (!is_idle)
> > > +             return;
> > > +
> > > +     /*
> > > +      * estimated "now" is:
> > > +      *   last_update_time +
> > > +      *   PELT scaling (rq->clock_pelt_idle - cfs_rq->clock_pelt_idle) +
> 
> PELT scaling is in fact the time between cfs becoming idle and rq
> becoming idle. Naming it PELT scaling is misleading because even at
> max frequency (ie without pelt scaling) we can have this delta.
> 
> > > +      *   rq clock lag (sched_clock_cpu() - rq->enter_idle)
> 
> and this is the time between rq becoming idle and current time
> 
> > > +      *
> > > +      *   The PELT scaling contribution is always 0 when !CFS_BANDWIDTH.
> > > +      *   (see clock_pelt = clock_task in _update_idle_rq_clock_pelt())
> 
> The contribution becomes 0 because we use the same clock reference
> 
> last_update_time (cfs_clock_pelt when cfs became idle) +
> rq->clock_pelt_idle (rq_clock_pelt when rq became idle) -
> cfs_rq->clock_pelt_idle (rq_clock_pelt when cfs became idle)
> 
> when !CFS_BANDWIDTH, cfs_clock_pelt == rq_clock_pelt because there is
> no throttling offset (which can dynamically change)
> so we have:
> 
> last_update_time (rq_clock_pelt when cfs became idle) +
> rq->clock_pelt_idle (rq_clock_pelt when rq became idle) -
> cfs_rq->clock_pelt_idle (rq_clock_pelt when cfs became idle)
> 
> which is equals to rq->clock_pelt_idle (rq_clock_pelt when rq became idle)
> 
> This also means that we only need a snapshot of the
> cfs_rq->throttled_clock_pelt_time when cfs became idle and the
> equation becomes like below for CFS_BANDWIDTH
> 
>  rq->clock_pelt_idle - snapshot of cfs_rq->throttled_clock_pelt_time
> when entering idle
> 
> which remove one u64_u32_load

Include these as comments in the below diff.

> > > +      */
> > > +#ifdef CONFIG_CFS_BANDWIDTH
> > > +     now = u64_u32_load(cfs_rq->clock_pelt_idle);
> > > +     /* The clock has been stopped for throttling */
> > > +     if (now == U64_MAX)
> > > +             return;
> > > +
> > > +     now = u64_u32_load(rq->clock_pelt_idle) - now;
> > > +     now += cfs_rq_last_update_time(cfs_rq);
> > > +#else
> > > +     now = u64_u32_load(rq->clock_pelt_idle);
> > > +#endif
> > > +     now += sched_clock_cpu(cpu_of(rq)) - u64_u32_load(rq->enter_idle);
> > > +
> > > +     __update_load_avg_blocked_se(now, se);
> > > +}
> > > +#else
> > > +static void migrate_se_pelt_lag(struct sched_entity *se) {}
> > > +#endif
> > > +
> > >  /**
> > >   * update_cfs_rq_load_avg - update the cfs_rq's load/util averages
> > >   * @now: current time, as per cfs_rq_clock_pelt()
> > > @@ -4429,6 +4480,9 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
> > >        */
> > >       if ((flags & (DEQUEUE_SAVE | DEQUEUE_MOVE)) != DEQUEUE_SAVE)
> > >               update_min_vruntime(cfs_rq);
> > > +
> > > +     if (cfs_rq->nr_running == 0)
> > > +             update_idle_cfs_rq_clock_pelt(cfs_rq);
> > >  }
> > >
> > >  /*
> > > @@ -6946,6 +7000,8 @@ static void detach_entity_cfs_rq(struct sched_entity *se);
> > >   */
> > >  static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
> > >  {
> > > +     struct sched_entity *se = &p->se;
> > > +
> > >       /*
> > >        * As blocked tasks retain absolute vruntime the migration needs to
> > >        * deal with this by subtracting the old and adding the new
> > > @@ -6953,7 +7009,6 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
> > >        * the task on the new runqueue.
> > >        */
> > >       if (READ_ONCE(p->__state) == TASK_WAKING) {
> > > -             struct sched_entity *se = &p->se;
> > >               struct cfs_rq *cfs_rq = cfs_rq_of(se);
> > >
> > >               se->vruntime -= u64_u32_load(cfs_rq->min_vruntime);
> > > @@ -6965,25 +7020,29 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
> > >                * rq->lock and can modify state directly.
> > >                */
> > >               lockdep_assert_rq_held(task_rq(p));
> > > -             detach_entity_cfs_rq(&p->se);
> > > +             detach_entity_cfs_rq(se);
> > >
> > >       } else {
> > > +             remove_entity_load_avg(se);
> > > +
> > >               /*
> > > -              * We are supposed to update the task to "current" time, then
> > > -              * its up to date and ready to go to new CPU/cfs_rq. But we
> > > -              * have difficulty in getting what current time is, so simply
> > > -              * throw away the out-of-date time. This will result in the
> > > -              * wakee task is less decayed, but giving the wakee more load
> > > -              * sounds not bad.
> > > +              * Here, the task's PELT values have been updated according to
> > > +              * the current rq's clock. But if that clock hasn't been
> > > +              * updated in a while, a substantial idle time will be missed,
> > > +              * leading to an inflation after wake-up on the new rq.
> > > +              *
> > > +              * Estimate the missing time from the cfs_rq last_update_time
> > > +              * and update sched_avg to improve the PELT continuity after
> > > +              * migration.
> > >                */
> > > -             remove_entity_load_avg(&p->se);
> > > +             migrate_se_pelt_lag(se);
> > >       }
> > >
> > >       /* Tell new CPU we are migrated */
> > > -     p->se.avg.last_update_time = 0;
> > > +     se->avg.last_update_time = 0;
> > >
> > >       /* We have migrated, no longer consider this task hot */
> > > -     p->se.exec_start = 0;
> > > +     se->exec_start = 0;
> > >
> > >       update_scan_period(p, new_cpu);
> > >  }
> > > @@ -8149,6 +8208,10 @@ static bool __update_blocked_fair(struct rq *rq, bool *done)
> > >               if (update_cfs_rq_load_avg(cfs_rq_clock_pelt(cfs_rq), cfs_rq)) {
> > >                       update_tg_load_avg(cfs_rq);
> > >
> > > +                     /* sync clock_pelt_idle with last update */
> > > +                     if (cfs_rq->nr_running == 0)
> > > +                             update_idle_cfs_rq_clock_pelt(cfs_rq);
> >
> > I think that if cfs_rq->nr_running == 0 then use cfs rq pelt_idle to update
> > idle cfs rq.
> 
> update_blocked_averages() updates all cfs rq to be aligned with now so
> we don't need to calculate an estimated now. update_rq_clock(rq) is
> called 1st to update the rq->clock and childs
> 
> With only need to save when happened the last update which is done in
> update_rq_clock_pelt(rq) for rq->clock_pelt and with
> update_idle_cfs_rq_clock_pelt(cfs) for the cfs_rq_clock_pelt

I missed this.

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a68482d66535..98c81bdb120a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3357,6 +3357,29 @@ static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
        return true;
 }
 
+static inline bool task_se_is_decayed(struct sched_entity *se)
+{
+       if (se->avg.load_sum)
+               return false;
+
+       if (se->avg.util_sum)
+               return false;
+
+       if (se->avg.runnable_sum)
+               return false;
+
+       /*
+        * _avg must be null when _sum are null because _avg = _sum / divider
+        * Make sure that rounding and/or propagation of PELT values never
+        * break this.
+        */
+       SCHED_WARN_ON(se->avg.load_avg ||
+                     se->avg.util_avg ||
+                     se->avg.runnable_avg);
+
+       return true;
+}
+
 /**
  * update_tg_load_avg - update the tg's load avg
  * @cfs_rq: the cfs_rq whose avg changed
@@ -3710,6 +3733,77 @@ static inline void add_tg_cfs_propagate(struct cfs_rq *cfs_rq, long runnable_sum
 
 #endif /* CONFIG_FAIR_GROUP_SCHED */
 
+#ifdef CONFIG_NO_HZ_COMMON
+static inline void migrate_se_pelt_lag(struct sched_entity *se)
+{
+       struct cfs_rq *cfs_rq;
+       struct rq *rq;
+       bool is_idle;
+       u64 now;
+
+       /* check if pelt value of the task are fully decayed */
+       if (task_se_is_decayed(se))
+               return;
+
+       cfs_rq = cfs_rq_of(se);
+       rq = rq_of(cfs_rq);
+
+       rcu_read_lock();
+       is_idle = is_idle_task(rcu_dereference(rq->curr));
+       rcu_read_unlock();
+
+       /*
+        * The lag estimation comes with a cost we don't want to pay all the
+        * time. Hence, limiting to the case where the source CPU is idle and
+        * we know we are at the greatest risk to have an outdated clock.
+        */
+       if (!is_idle)
+               return;
+
+       /*
+        * estimated "now" is:
+        *   last_update_time (cfs_clock_pelt when cfs became idle) +
+        *   rq->clock_pelt_idle (rq_clock_pelt when rq became idle) -
+        *   cfs_rq->clock_pelt_idle (rq_clock_pelt when cfs became idle)
+        *
+        *   PELT idle lag is in fact the time between cfs becoming idle and
+        *   rq becoming idle.
+        *   rq clock lag is the time between rq becoming idle and current time.
+        *
+        *   when !CFS_BANDWIDTH, cfs_clock_pelt == rq_clock_pelt because there is
+        *   no throttling offset (which can dynamically change)
+        *   so we have:
+        *   last_update_time (rq_clock_pelt when cfs became idle) +
+        *   rq->clock_pelt_idle (rq_clock_pelt when rq became idle) -
+        *   cfs_rq->clock_pelt_idle (rq_clock_pelt when cfs became idle)
+        *
+        *   which is equals to rq->clock_pelt_idle (rq_clock_pelt when rq became idle)
+        *   This also means that we only need a snapshot of the
+        *   cfs_rq->throttled_clock_pelt_time when cfs became idle and the
+        *   equation becomes like below for CFS_BANDWIDTH
+        *   rq->clock_pelt_idle - snapshot of cfs_rq->throttled_clock_pelt_time
+        *   when entering idle
+        *
+        */
+#ifdef CONFIG_CFS_BANDWIDTH
+       now = u64_u32_load(cfs_rq->throttled_clock_pelt_time);
+       /* The clock has been stopped for throttling */
+       if (now == U64_MAX)
+               return;
+
+       now = u64_u32_load(rq->clock_pelt_idle) - now;
+#else
+       now = u64_u32_load(rq->clock_pelt_idle);
+#endif
+       now += sched_clock_cpu(cpu_of(rq)) - u64_u32_load(rq->enter_idle);
+
+       __update_load_avg_blocked_se(now, se);
+}
+#else
+static void migrate_se_pelt_lag(struct sched_entity *se) {}
+#endif
+
+
 /**
  * update_cfs_rq_load_avg - update the cfs_rq's load/util averages
  * @now: current time, as per cfs_rq_clock_pelt()
@@ -4191,6 +4285,11 @@ static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
        return true;
 }
 
+static inline bool task_se_is_decayed(struct sched_entity *se)
+{
+       return true;
+}
+
 #define UPDATE_TG      0x0
 #define SKIP_AGE_LOAD  0x0
 #define DO_ATTACH      0x0
@@ -4465,6 +4564,9 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
         */
        if ((flags & (DEQUEUE_SAVE | DEQUEUE_MOVE)) != DEQUEUE_SAVE)
                update_min_vruntime(cfs_rq);
+
+       if (cfs_rq->nr_running == 0)
+               update_idle_cfs_rq_clock_pelt(cfs_rq);
 }
 
 /*
@@ -6982,6 +7084,8 @@ static void detach_entity_cfs_rq(struct sched_entity *se);
  */
 static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
 {
+       struct sched_entity *se = &p->se;
+
        /*
         * As blocked tasks retain absolute vruntime the migration needs to
         * deal with this by subtracting the old and adding the new
@@ -6989,7 +7093,6 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
         * the task on the new runqueue.
         */
        if (READ_ONCE(p->__state) == TASK_WAKING) {
-               struct sched_entity *se = &p->se;
                struct cfs_rq *cfs_rq = cfs_rq_of(se);
                u64 min_vruntime;
 
@@ -7014,25 +7117,28 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
                 * rq->lock and can modify state directly.
                 */
                lockdep_assert_rq_held(task_rq(p));
-               detach_entity_cfs_rq(&p->se);
+               detach_entity_cfs_rq(se);
 
        } else {
+               remove_entity_load_avg(&p->se);
                /*
-                * We are supposed to update the task to "current" time, then
-                * its up to date and ready to go to new CPU/cfs_rq. But we
-                * have difficulty in getting what current time is, so simply
-                * throw away the out-of-date time. This will result in the
-                * wakee task is less decayed, but giving the wakee more load
-                * sounds not bad.
+                * Here, the task's PELT values have been updated according to
+                * the current rq's clock. But if that clock hasn't been
+                * updated in a while, a substantial idle time will be missed,
+                * leading to an inflation after wake-up on the new rq.
+                *
+                * Estimate the missing time from the cfs_rq last_update_time
+                * and update sched_avg to improve the PELT continuity after
+                * migration.
                 */
-               remove_entity_load_avg(&p->se);
+               migrate_se_pelt_lag(se);
        }
 
        /* Tell new CPU we are migrated */
-       p->se.avg.last_update_time = 0;
+       se.avg.last_update_time = 0;
 
        /* We have migrated, no longer consider this task hot */
-       p->se.exec_start = 0;
+       se.exec_start = 0;
 
        update_scan_period(p, new_cpu);
 }
@@ -8198,6 +8304,10 @@ static bool __update_blocked_fair(struct rq *rq, bool *done)
                if (update_cfs_rq_load_avg(cfs_rq_clock_pelt(cfs_rq), cfs_rq)) {
                        update_tg_load_avg(cfs_rq);
 
+                       /* sync clock_pelt_idle with last update */
+                       if (cfs_rq->nr_running == 0)
+                               update_idle_cfs_rq_clock_pelt(cfs_rq);
+
                        if (cfs_rq == &rq->cfs)
                                decayed = true;
                }
diff --git a/kernel/sched/pelt.h b/kernel/sched/pelt.h
index c336f5f481bc..0a01fe1b6ff4 100644
--- a/kernel/sched/pelt.h
+++ b/kernel/sched/pelt.h
@@ -61,6 +61,23 @@ static inline void cfs_se_util_change(struct sched_avg *avg)
        WRITE_ONCE(avg->util_est.enqueued, enqueued);
 }
 
+static inline u64 rq_clock_pelt(struct rq *rq)
+{
+       lockdep_assert_rq_held(rq);
+       assert_clock_updated(rq);
+
+       return rq->clock_pelt - rq->lost_idle_time;
+}
+
+/* The rq is idle, we can sync to clock_task */
+static inline void _update_idle_rq_clock_pelt(struct rq *rq)
+{
+       rq->clock_pelt  = rq_clock_task(rq);
+
+       u64_u32_store(rq->enter_idle, rq_clock(rq));
+       u64_u32_store(rq->clock_pelt_idle, rq_clock_pelt(rq));
+}
+
 /*
  * The clock_pelt scales the time to reflect the effective amount of
  * computation done during the running delta time but then sync back to
@@ -76,8 +93,7 @@ static inline void cfs_se_util_change(struct sched_avg *avg)
 static inline void update_rq_clock_pelt(struct rq *rq, s64 delta)
 {
        if (unlikely(is_idle_task(rq->curr))) {
-               /* The rq is idle, we can sync to clock_task */
-               rq->clock_pelt  = rq_clock_task(rq);
+               _update_idle_rq_clock_pelt(rq);
                return;
        }
 
@@ -130,17 +146,24 @@ static inline void update_idle_rq_clock_pelt(struct rq *rq)
         */
        if (util_sum >= divider)
                rq->lost_idle_time += rq_clock_task(rq) - rq->clock_pelt;
-}
 
-static inline u64 rq_clock_pelt(struct rq *rq)
-{
-       lockdep_assert_rq_held(rq);
-       assert_clock_updated(rq);
-
-       return rq->clock_pelt - rq->lost_idle_time;
+       _update_idle_rq_clock_pelt(rq);
 }
 
 #ifdef CONFIG_CFS_BANDWIDTH
+static inline void update_idle_cfs_rq_clock_pelt(struct cfs_rq *cfs_rq)
+{
+       if (unlikely(cfs_rq->throttle_count)) {
+               u64_u32_store(cfs_rq->clock_pelt_idle, U64_MAX);
+               u64_u32_store(cfs_rq->throttled_clock_pelt_time, U64_MAX);
+       } else {
+               u64_u32_store(cfs_rq->clock_pelt_idle,
+                             rq_clock_pelt(rq_of(cfs_rq)));
+               u64_u32_store(cfs_rq->throttled_clock_pelt_time,
+                                 cfs_rq->throttled_clock_task_time);
+       }
+}
+
 /* rq->task_clock normalized against any time this cfs_rq has spent throttled */
 static inline u64 cfs_rq_clock_pelt(struct cfs_rq *cfs_rq)
 {
@@ -150,6 +173,7 @@ static inline u64 cfs_rq_clock_pelt(struct cfs_rq *cfs_rq)
        return rq_clock_pelt(rq_of(cfs_rq)) - cfs_rq->throttled_clock_task_time;
 }
 #else
+static inline void update_idle_cfs_rq_clock_pelt(struct cfs_rq *cfs_rq) { }
 static inline u64 cfs_rq_clock_pelt(struct cfs_rq *cfs_rq)
 {
        return rq_clock_pelt(rq_of(cfs_rq));
@@ -204,6 +228,7 @@ update_rq_clock_pelt(struct rq *rq, s64 delta) { }
 static inline void
 update_idle_rq_clock_pelt(struct rq *rq) { }
 
+static inline void update_idle_cfs_rq_clock_pelt(struct cfs_rq *cfs_rq) { }
 #endif
 
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 8dccb34eb190..3bd77a011676 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -602,6 +602,12 @@ struct cfs_rq {
        int                     runtime_enabled;
        s64                     runtime_remaining;
 
+       u64                     clock_pelt_idle;
+       u64                     throttled_clock_pelt_time;
+#ifndef CONFIG_64BIT
+       u64                     clock_pelt_idle_copy;
+       u64                     throttled_clock_pelt_time_copy;
+#endif
        u64                     throttled_clock;
        u64                     throttled_clock_task;
        u64                     throttled_clock_task_time;
@@ -974,6 +980,12 @@ struct rq {
        u64                     clock_task ____cacheline_aligned;
        u64                     clock_pelt;
        unsigned long           lost_idle_time;
+       u64                     clock_pelt_idle;
+       u64                     enter_idle;
+#ifndef CONFIG_64BIT
+       u64                     clock_pelt_idle_copy;
+       u64                     enter_idle_copy;
+#endif
 
        atomic_t                nr_iowait;
 
 
+       u64                     clock_pelt_idle;
+       u64                     throttled_clock_pelt_time;
+#ifndef CONFIG_64BIT
+       u64                     clock_pelt_idle_copy;
+       u64                     throttled_clock_pelt_time_copy;
+#endif
        u64                     throttled_clock;
        u64                     throttled_clock_task;
        u64                     throttled_clock_task_time;
@@ -974,6 +980,12 @@ struct rq {
        u64                     clock_task ____cacheline_aligned;
        u64                     clock_pelt;
        unsigned long           lost_idle_time;
+       u64                     clock_pelt_idle;
+       u64                     enter_idle;
+#ifndef CONFIG_64BIT
+       u64                     clock_pelt_idle_copy;
+       u64                     enter_idle_copy;
+#endif
 
        atomic_t                nr_iowait;



Thanks,
Tao
> >
> > if (!cfs_rq->nr_running) {
> >     /* A part. calculation of idle cfs rq */
> >     calculate now like in migrate_se_pelt_lag().
> >     decay = update_cfs_rq_load_avg(now, cfs_rq);
> > } else {
> >     decay = update_cfs_rq_load_avg(cfs_rq_clock_pelt(cfs_rq), cfs_rq))
> > }
> >
> > if (decay) {
> >     update_tg_load_avg(cfs_rq);
> >     if (cfs_rq == &rq->cfs)
> >         decayed == ture;
> > }
> >
> > Thanks,
> > Tao
> > >                       if (cfs_rq == &rq->cfs)
> > >                               decayed = true;
> > >               }
> > > diff --git a/kernel/sched/pelt.h b/kernel/sched/pelt.h
> > > index 4ff2ed4f8fa1..6b39e07b2919 100644
> > > --- a/kernel/sched/pelt.h
> > > +++ b/kernel/sched/pelt.h
> > > @@ -61,6 +61,23 @@ static inline void cfs_se_util_change(struct sched_avg *avg)
> > >       WRITE_ONCE(avg->util_est.enqueued, enqueued);
> > >  }
> > >
> > > +static inline u64 rq_clock_pelt(struct rq *rq)
> > > +{
> > > +     lockdep_assert_rq_held(rq);
> > > +     assert_clock_updated(rq);
> > > +
> > > +     return rq->clock_pelt - rq->lost_idle_time;
> > > +}
> > > +
> > > +/* The rq is idle, we can sync to clock_task */
> > > +static inline void _update_idle_rq_clock_pelt(struct rq *rq)
> > > +{
> > > +     rq->clock_pelt  = rq_clock_task(rq);
> > > +
> > > +     u64_u32_store(rq->enter_idle, rq_clock(rq));
> > > +     u64_u32_store(rq->clock_pelt_idle, rq_clock_pelt(rq));
> > > +}
> > > +
> > >  /*
> > >   * The clock_pelt scales the time to reflect the effective amount of
> > >   * computation done during the running delta time but then sync back to
> > > @@ -76,8 +93,7 @@ static inline void cfs_se_util_change(struct sched_avg *avg)
> > >  static inline void update_rq_clock_pelt(struct rq *rq, s64 delta)
> > >  {
> > >       if (unlikely(is_idle_task(rq->curr))) {
> > > -             /* The rq is idle, we can sync to clock_task */
> > > -             rq->clock_pelt  = rq_clock_task(rq);
> > > +             _update_idle_rq_clock_pelt(rq);
> > >               return;
> > >       }
> > >
> > > @@ -130,17 +146,20 @@ static inline void update_idle_rq_clock_pelt(struct rq *rq)
> > >        */
> > >       if (util_sum >= divider)
> > >               rq->lost_idle_time += rq_clock_task(rq) - rq->clock_pelt;
> > > +
> > > +     _update_idle_rq_clock_pelt(rq);
> > >  }
> > >
> > > -static inline u64 rq_clock_pelt(struct rq *rq)
> > > +#ifdef CONFIG_CFS_BANDWIDTH
> > > +static inline void update_idle_cfs_rq_clock_pelt(struct cfs_rq *cfs_rq)
> > >  {
> > > -     lockdep_assert_rq_held(rq);
> > > -     assert_clock_updated(rq);
> > > -
> > > -     return rq->clock_pelt - rq->lost_idle_time;
> > > +     if (unlikely(cfs_rq->throttle_count))
> > > +             u64_u32_store(cfs_rq->clock_pelt_idle, U64_MAX);
> > > +     else
> > > +             u64_u32_store(cfs_rq->clock_pelt_idle,
> > > +                           rq_clock_pelt(rq_of(cfs_rq)));
> > >  }
> > >
> > > -#ifdef CONFIG_CFS_BANDWIDTH
> > >  /* rq->task_clock normalized against any time this cfs_rq has spent throttled */
> > >  static inline u64 cfs_rq_clock_pelt(struct cfs_rq *cfs_rq)
> > >  {
> > > @@ -150,6 +169,7 @@ static inline u64 cfs_rq_clock_pelt(struct cfs_rq *cfs_rq)
> > >       return rq_clock_pelt(rq_of(cfs_rq)) - cfs_rq->throttled_clock_pelt_time;
> > >  }
> > >  #else
> > > +static inline void update_idle_cfs_rq_clock_pelt(struct cfs_rq *cfs_rq) { }
> > >  static inline u64 cfs_rq_clock_pelt(struct cfs_rq *cfs_rq)
> > >  {
> > >       return rq_clock_pelt(rq_of(cfs_rq));
> > > @@ -204,6 +224,7 @@ update_rq_clock_pelt(struct rq *rq, s64 delta) { }
> > >  static inline void
> > >  update_idle_rq_clock_pelt(struct rq *rq) { }
> > >
> > > +static inline void update_idle_cfs_rq_clock_pelt(struct cfs_rq *cfs_rq) { }
> > >  #endif
> > >
> > >
> > > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > > index e2cf6e48b165..07014e8cbae2 100644
> > > --- a/kernel/sched/sched.h
> > > +++ b/kernel/sched/sched.h
> > > @@ -641,6 +641,10 @@ struct cfs_rq {
> > >       int                     runtime_enabled;
> > >       s64                     runtime_remaining;
> > >
> > > +     u64                     clock_pelt_idle;
> > > +#ifndef CONFIG_64BIT
> > > +     u64                     clock_pelt_idle_copy;
> > > +#endif
> > >       u64                     throttled_clock;
> > >       u64                     throttled_clock_pelt;
> > >       u64                     throttled_clock_pelt_time;
> > > @@ -1013,6 +1017,12 @@ struct rq {
> > >       u64                     clock_task ____cacheline_aligned;
> > >       u64                     clock_pelt;
> > >       unsigned long           lost_idle_time;
> > > +     u64                     clock_pelt_idle;
> > > +     u64                     enter_idle;
> > > +#ifndef CONFIG_64BIT
> > > +     u64                     clock_pelt_idle_copy;
> > > +     u64                     enter_idle_copy;
> > > +#endif
> > >
> > >       atomic_t                nr_iowait;
> > >
> > > --
> > > 2.25.1
> > >
