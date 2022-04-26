Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE0185103BB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 18:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353072AbiDZQob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 12:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345421AbiDZQo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 12:44:29 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BCD52B1A8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 09:41:20 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id n126-20020a1c2784000000b0038e8af3e788so1947272wmn.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 09:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=N19Vg9tafFbCMdK8u9g0MLsgxUWixaXSYbRz2XuhVes=;
        b=w2cSH2CiZ/HJU7TSvhoodtRrVnrh1rKVpyjjOv4LEhftaqexEsJmcbZSpAVjpQ0YXM
         dR80O2dj+6cg44nPxiwWfLp1zde89O9SdTa5ZHpXMJ30aVCYSko0gjqwIFu3YJQ2IS+R
         Iy2acKnzvlLqp3tepxBNVSqdLAV9h3ffr5fsOW6/s/4GWLB3DN/T0zXkAfdDLqkPhW/O
         v8d5OXVZ1VceyFhBo4c5WPs9VzDOm2KqpprffbF68Ri6N5+XSsNL8IVZ/Eh3GzEu8p7A
         Tlrv+PSL/OtRbArOpdMnGIwnUVQon9tUgVuNOwnRdE+VhAJH3ouSzW2pMnWuigJM3ZBU
         vv8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=N19Vg9tafFbCMdK8u9g0MLsgxUWixaXSYbRz2XuhVes=;
        b=oCOop5lsERPDu/azf6B3HaweKdIbfo5nHvdCmxgO7xSu8+UVlIlm+CL18zFRmd6MQU
         9eOBNpKUQHxaXmv9rEfO1sGJ0Vr64C5mgBtH0qhr+iOEkRpfYEBywCJVLwWlmGtu6x3K
         /8LXThQ81S0uQMEWoW/wH5upSTZ4z1BZ4cIzGqjGqOWlkP9o2Jv6TqkhZyR+vvHfCAuq
         WyZWirDw/U+FAngyapWJygMLbKYJQ5rh0D7xzLfjoR9KNiYNqi9pBsTlqQ14FXBLAAhz
         7XR+pmm3EsEj6oRcw3usUIAFvi/bGbTz/vA6ViE98CO/pIyVs76GF7iJCUJhXoyHbGjL
         14mw==
X-Gm-Message-State: AOAM533mwJxyfSeG49y4CEaOYCZmOZmDcobxz1CJ+KSxZdfL0C7CAk5T
        vG5dJJXYfahcYGH2CiH1gG+3DA==
X-Google-Smtp-Source: ABdhPJyT6bDo6QVV/85FXbM0p0Sh3ef6O2Bbc6aTuqNmN6MDZwTu/IRgzu5AuEMggTAJ3EPKSRx+NA==
X-Received: by 2002:a1c:a301:0:b0:392:9bc5:203c with SMTP id m1-20020a1ca301000000b003929bc5203cmr22278596wme.67.1650991278993;
        Tue, 26 Apr 2022 09:41:18 -0700 (PDT)
Received: from vingu-book ([2a01:e0a:f:6020:5461:c9a1:ed41:cca9])
        by smtp.gmail.com with ESMTPSA id v188-20020a1cacc5000000b0038e9c60f0e7sm11623362wme.28.2022.04.26.09.41.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Apr 2022 09:41:18 -0700 (PDT)
Date:   Tue, 26 Apr 2022 18:41:16 +0200
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     Vincent Donnefort <vincent.donnefort@arm.com>
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com, qperret@google.com
Subject: Re: [PATCH v6 2/7] sched/fair: Decay task PELT values during wakeup
 migration
Message-ID: <20220426164116.GA24773@vingu-book>
References: <20220426093506.3415588-1-vincent.donnefort@arm.com>
 <20220426093506.3415588-3-vincent.donnefort@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220426093506.3415588-3-vincent.donnefort@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

Le mardi 26 avril 2022 à 10:35:01 (+0100), Vincent Donnefort a écrit :
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
> sched_clock_cpu() is a costly functinon. Limit the usage to the case where
> the source CPU is idle as we know this is when the clock is having the
> biggest risk of being outdated.
> 
> Neither clock_task, clock_pelt nor clock can be accessed without the
> runqueue lock. We then need to store those values in a timestamp variable
> which can be accessed during the migration. rq's enter_idle will give the
> wall-clock time when the rq went idle. We have then:
> 
>   B = sched_clock_cpu() - rq->enter_idle.
> 
> Then, to catch-up the PELT clock scaling (A), two cases:
> 
>   * !CFS_BANDWIDTH: We can simply use clock_task(). This value is stored
>     in rq's clock_pelt_idle, before the rq enters idle. The estimated time
>     is then:
> 
>       rq->clock_pelt_idle + sched_clock_cpu() - rq->enter_idle.
> 
>   * CFS_BANDWIDTH: We can't catch-up with clock_task because of the
>     throttled_clock_task_time offset. cfs_rq's clock_pelt_idle is then
>     giving the PELT clock when the cfs_rq becomes idle. This gives:
> 
>       A = rq->clock_pelt_idle - cfs_rq->clock_pelt_idle
> 
>     And gives the following estimated time:
> 
>       cfs_rq->last_update_time +
>       rq->clock_pelt_idle - cfs_rq->clock_pelt_idle + (A)
>       sched_clock_cpu() - rq->enter_idle (B)
> 
> The (B) part of the missing time is however an estimation that doesn't
> take into account IRQ and Paravirt time.
> 
> [1] https://lore.kernel.org/all/20190709115759.10451-1-chris.redpath@arm.com/
> 
> Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index abd1feeec0c2..1256e2c0e2e2 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3694,6 +3694,48 @@ static inline void add_tg_cfs_propagate(struct cfs_rq *cfs_rq, long runnable_sum
>  
>  #endif /* CONFIG_FAIR_GROUP_SCHED */
>  
> +#ifdef CONFIG_NO_HZ_COMMON
> +static inline void migrate_se_pelt_lag(struct sched_entity *se)
> +{
> +	struct cfs_rq *cfs_rq;
> +	struct rq *rq;
> +	bool is_idle;
> +	u64 now;
> +
> +	cfs_rq = cfs_rq_of(se);
> +	rq = rq_of(cfs_rq);
> +
> +	rcu_read_lock();
> +	is_idle = is_idle_task(rcu_dereference(rq->curr));
> +	rcu_read_unlock();
> +
> +	/*
> +	 * The lag estimation comes with a cost we don't want to pay all the
> +	 * time. Hence, limiting to the case where the source CPU is idle and
> +	 * we know we are at the greatest risk to have an outdated clock.
> +	 */
> +	if (!is_idle)
> +		return;
> +
> +#ifdef CONFIG_CFS_BANDWIDTH
> +	now = u64_u32_load(cfs_rq->clock_pelt_idle);
> +	/* The clock has been stopped for throttling */
> +	if (now == U64_MAX)
> +		return;
> +
> +	now += cfs_rq_last_update_time(cfs_rq);
> +	now -= u64_u32_load(rq->clock_pelt_idle);

This is a bit difficult to read and follow.

we should have 
/* start at the last cfs pelt update time */
now = cfs_rq_last_update_time(cfs_rq);
/* Add delta between cfs rq becoming idle and rq becoming idle */
now += u64_u32_load(cfs_rq->clock_pelt_idle); - u64_u32_load(rq->clock_pelt_idle);

But IIUC, you started with u64_u32_load(cfs_rq->clock_pelt_idle) to dectect throttled case

All this would deserve a comment explaining what we are computing here at least


> +#else
> +	now = u64_u32_load(rq->clock_pelt_idle);
> +#endif
> +	now += sched_clock_cpu(cpu_of(rq)) - u64_u32_load(rq->enter_idle);
> +
> +	__update_load_avg_blocked_se(now, se);
> +}
> +#else
> +static void migrate_se_pelt_lag(struct sched_entity *se) {}
> +#endif
> +
>  /**
>   * update_cfs_rq_load_avg - update the cfs_rq's load/util averages
>   * @now: current time, as per cfs_rq_clock_pelt()
> @@ -4429,6 +4471,9 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>  	 */
>  	if ((flags & (DEQUEUE_SAVE | DEQUEUE_MOVE)) != DEQUEUE_SAVE)
>  		update_min_vruntime(cfs_rq);
> +
> +	if (cfs_rq->nr_running == 0)
> +		update_idle_cfs_rq_clock_pelt(cfs_rq);
>  }
>  
>  /*
> @@ -6946,6 +6991,8 @@ static void detach_entity_cfs_rq(struct sched_entity *se);
>   */
>  static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
>  {
> +	struct sched_entity *se = &p->se;
> +
>  	/*
>  	 * As blocked tasks retain absolute vruntime the migration needs to
>  	 * deal with this by subtracting the old and adding the new
> @@ -6953,7 +7000,6 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
>  	 * the task on the new runqueue.
>  	 */
>  	if (READ_ONCE(p->__state) == TASK_WAKING) {
> -		struct sched_entity *se = &p->se;
>  		struct cfs_rq *cfs_rq = cfs_rq_of(se);
>  
>  		se->vruntime -= u64_u32_load(cfs_rq->min_vruntime);
> @@ -6965,25 +7011,29 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
>  		 * rq->lock and can modify state directly.
>  		 */
>  		lockdep_assert_rq_held(task_rq(p));
> -		detach_entity_cfs_rq(&p->se);
> +		detach_entity_cfs_rq(se);
>  
>  	} else {
> +		remove_entity_load_avg(se);
> +
>  		/*
> -		 * We are supposed to update the task to "current" time, then
> -		 * its up to date and ready to go to new CPU/cfs_rq. But we
> -		 * have difficulty in getting what current time is, so simply
> -		 * throw away the out-of-date time. This will result in the
> -		 * wakee task is less decayed, but giving the wakee more load
> -		 * sounds not bad.
> +		 * Here, the task's PELT values have been updated according to
> +		 * the current rq's clock. But if that clock hasn't been
> +		 * updated in a while, a substantial idle time will be missed,
> +		 * leading to an inflation after wake-up on the new rq.
> +		 *
> +		 * Estimate the missing time from the cfs_rq last_update_time
> +		 * and update sched_avg to improve the PELT continuity after
> +		 * migration.
>  		 */
> -		remove_entity_load_avg(&p->se);
> +		migrate_se_pelt_lag(se);
>  	}
>  
>  	/* Tell new CPU we are migrated */
> -	p->se.avg.last_update_time = 0;
> +	se->avg.last_update_time = 0;
>  
>  	/* We have migrated, no longer consider this task hot */
> -	p->se.exec_start = 0;
> +	se->exec_start = 0;
>  
>  	update_scan_period(p, new_cpu);
>  }
> diff --git a/kernel/sched/pelt.h b/kernel/sched/pelt.h
> index 4ff2ed4f8fa1..0380f750adbe 100644
> --- a/kernel/sched/pelt.h
> +++ b/kernel/sched/pelt.h
> @@ -103,6 +103,14 @@ static inline void update_rq_clock_pelt(struct rq *rq, s64 delta)
>  	rq->clock_pelt += delta;
>  }
>  
> +static inline u64 rq_clock_pelt(struct rq *rq)
> +{
> +	lockdep_assert_rq_held(rq);
> +	assert_clock_updated(rq);
> +
> +	return rq->clock_pelt - rq->lost_idle_time;
> +}
> +
>  /*
>   * When rq becomes idle, we have to check if it has lost idle time
>   * because it was fully busy. A rq is fully used when the /Sum util_sum
> @@ -130,17 +138,24 @@ static inline void update_idle_rq_clock_pelt(struct rq *rq)
>  	 */
>  	if (util_sum >= divider)
>  		rq->lost_idle_time += rq_clock_task(rq) - rq->clock_pelt;
> -}
>  
> -static inline u64 rq_clock_pelt(struct rq *rq)
> -{
> -	lockdep_assert_rq_held(rq);
> -	assert_clock_updated(rq);
> +	 /* The rq is idle, we can sync with clock_task */
> +	rq->clock_pelt = rq_clock_task(rq);
>  
> -	return rq->clock_pelt - rq->lost_idle_time;
> +	u64_u32_store(rq->enter_idle, rq_clock(rq));
> +	u64_u32_store(rq->clock_pelt_idle, rq_clock_pelt(rq));

rq and cfs rq clock pelt can also be updated during ILB/update_blocked_load.
So you also need this:

---
 kernel/sched/fair.c |  4 ++++
 kernel/sched/pelt.h | 18 ++++++++++--------
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index fa79d31a36bd..3c1d243079a3 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8269,6 +8269,10 @@ static bool __update_blocked_fair(struct rq *rq, bool *done)
 		if (update_cfs_rq_load_avg(cfs_rq_clock_pelt(cfs_rq), cfs_rq)) {
 			update_tg_load_avg(cfs_rq);

+			/* sync clock_pelt_idle with last update */
+			if (cfs_rq->nr_running == 0)
+				update_idle_cfs_rq_clock_pelt(cfs_rq);
+
 			if (cfs_rq == &rq->cfs)
 				decayed = true;
 		}
diff --git a/kernel/sched/pelt.h b/kernel/sched/pelt.h
index 0380f750adbe..6a4dbff8fdd3 100644
--- a/kernel/sched/pelt.h
+++ b/kernel/sched/pelt.h
@@ -61,6 +61,14 @@ static inline void cfs_se_util_change(struct sched_avg *avg)
 	WRITE_ONCE(avg->util_est.enqueued, enqueued);
 }

+static inline u64 rq_clock_pelt(struct rq *rq)
+{
+	lockdep_assert_rq_held(rq);
+	assert_clock_updated(rq);
+
+	return rq->clock_pelt - rq->lost_idle_time;
+}
+
 /*
  * The clock_pelt scales the time to reflect the effective amount of
  * computation done during the running delta time but then sync back to
@@ -78,6 +86,8 @@ static inline void update_rq_clock_pelt(struct rq *rq, s64 delta)
 	if (unlikely(is_idle_task(rq->curr))) {
 		/* The rq is idle, we can sync to clock_task */
 		rq->clock_pelt  = rq_clock_task(rq);
+		u64_u32_store(rq->enter_idle, rq_clock(rq));
+		u64_u32_store(rq->clock_pelt_idle, rq_clock_pelt(rq));
 		return;
 	}

@@ -103,14 +113,6 @@ static inline void update_rq_clock_pelt(struct rq *rq, s64 delta)
 	rq->clock_pelt += delta;
 }

-static inline u64 rq_clock_pelt(struct rq *rq)
-{
-	lockdep_assert_rq_held(rq);
-	assert_clock_updated(rq);
-
-	return rq->clock_pelt - rq->lost_idle_time;
-}
-
 /*
  * When rq becomes idle, we have to check if it has lost idle time
  * because it was fully busy. A rq is fully used when the /Sum util_sum
--



>  }
>  
>  #ifdef CONFIG_CFS_BANDWIDTH
> +static inline void update_idle_cfs_rq_clock_pelt(struct cfs_rq *cfs_rq)
> +{
> +	if (unlikely(cfs_rq->throttle_count))
> +		u64_u32_store(cfs_rq->clock_pelt_idle, U64_MAX);
> +	else
> +		u64_u32_store(cfs_rq->clock_pelt_idle,
> +			      rq_clock_pelt(rq_of(cfs_rq)));
> +}
> +
>  /* rq->task_clock normalized against any time this cfs_rq has spent throttled */
>  static inline u64 cfs_rq_clock_pelt(struct cfs_rq *cfs_rq)
>  {
> @@ -150,6 +165,7 @@ static inline u64 cfs_rq_clock_pelt(struct cfs_rq *cfs_rq)
>  	return rq_clock_pelt(rq_of(cfs_rq)) - cfs_rq->throttled_clock_pelt_time;
>  }
>  #else
> +static inline void update_idle_cfs_rq_clock_pelt(struct cfs_rq *cfs_rq) { }
>  static inline u64 cfs_rq_clock_pelt(struct cfs_rq *cfs_rq)
>  {
>  	return rq_clock_pelt(rq_of(cfs_rq));
> @@ -204,6 +220,7 @@ update_rq_clock_pelt(struct rq *rq, s64 delta) { }
>  static inline void
>  update_idle_rq_clock_pelt(struct rq *rq) { }
>  
> +static inline void update_idle_cfs_rq_clock_pelt(struct cfs_rq *cfs_rq) { }
>  #endif
>  
>  
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index e2cf6e48b165..07014e8cbae2 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -641,6 +641,10 @@ struct cfs_rq {
>  	int			runtime_enabled;
>  	s64			runtime_remaining;
>  
> +	u64			clock_pelt_idle;
> +#ifndef CONFIG_64BIT
> +	u64                     clock_pelt_idle_copy;
> +#endif
>  	u64			throttled_clock;
>  	u64			throttled_clock_pelt;
>  	u64			throttled_clock_pelt_time;
> @@ -1013,6 +1017,12 @@ struct rq {
>  	u64			clock_task ____cacheline_aligned;
>  	u64			clock_pelt;
>  	unsigned long		lost_idle_time;
> +	u64			clock_pelt_idle;
> +	u64			enter_idle;
> +#ifndef CONFIG_64BIT
> +	u64			clock_pelt_idle_copy;
> +	u64			enter_idle_copy;
> +#endif
>  
>  	atomic_t		nr_iowait;
>  
> -- 
> 2.25.1
> 
