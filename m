Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2279E490C36
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 17:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240814AbiAQQLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 11:11:35 -0500
Received: from out1.migadu.com ([91.121.223.63]:33674 "EHLO out1.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237430AbiAQQLf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 11:11:35 -0500
Date:   Tue, 18 Jan 2022 00:11:23 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1642435893;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TR1Rqj9G1NiwuvZQW+k8MsaJSXqQZgpQ0AFCS2DTpzE=;
        b=PfFCw8kSxevEgpFRQlR7oFdcAg9s9uo+vrMi+tm6vlRe98fJaCxj1GEONR/UQztQ8MGG4/
        BqNxOzZztddwruMoAwhKZuAUJNRO8pSMmjbWsTJExQhp+afr9OkKgBHfseE+WaIx63+ZO9
        T3lHSCTjjzeGMg9KYTJp4sPkdkyefjM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Tao Zhou <tao.zhou@linux.dev>
To:     Vincent Donnefort <vincent.donnefort@arm.com>
Cc:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        valentin.schneider@arm.com, morten.rasmussen@arm.com,
        chris.redpath@arm.com, qperret@google.com, lukasz.luba@arm.com,
        Tao Zhou <tao.zhou@linux.dev>
Subject: Re: [PATCH v2 1/7] sched/fair: Provide u64 read for 32-bits arch
 helper
Message-ID: <YeWVK8EY/s1TMOD4@geo.homenetwork>
References: <20220112161230.836326-1-vincent.donnefort@arm.com>
 <20220112161230.836326-2-vincent.donnefort@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220112161230.836326-2-vincent.donnefort@arm.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jan 12, 2022 at 04:12:24PM +0000, Vincent Donnefort wrote:

> Introducing macro helpers u64_u32_{store,load}() to factorize lockless
> accesses to u64 variables for 32-bits architectures.
> 
> Users are for now cfs_rq.min_vruntime and sched_avg.last_update_time. To
> accommodate the later where the copy lies outside of the structure
> (cfs_rq.last_udpate_time_copy instead of sched_avg.last_update_time_copy),
> use the _copy() version of those helpers.
> 
> Those new helpers encapsulate smp_rmb() and smp_wmb() synchronization and
> therefore, have a small penalty in set_task_rq_fair() and init_cfs_rq().
> 
> Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 095b0aa378df..99ea9540ece4 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -568,11 +568,8 @@ static void update_min_vruntime(struct cfs_rq *cfs_rq)
>  	}
>  
>  	/* ensure we never gain time by being placed backwards. */
> -	cfs_rq->min_vruntime = max_vruntime(cfs_rq->min_vruntime, vruntime);
> -#ifndef CONFIG_64BIT
> -	smp_wmb();
> -	cfs_rq->min_vruntime_copy = cfs_rq->min_vruntime;
> -#endif
> +	u64_u32_store(cfs_rq->min_vruntime,
> +		      max_vruntime(cfs_rq->min_vruntime, vruntime));
>  }
>  
>  static inline bool __entity_less(struct rb_node *a, const struct rb_node *b)
> @@ -3246,6 +3243,11 @@ static inline void cfs_rq_util_change(struct cfs_rq *cfs_rq, int flags)
>  }
>  
>  #ifdef CONFIG_SMP
> +static inline u64 cfs_rq_last_update_time(struct cfs_rq *cfs_rq)
> +{
> +	return u64_u32_load_copy(cfs_rq->avg.last_update_time,
> +				 cfs_rq->last_update_time_copy);
> +}
>  #ifdef CONFIG_FAIR_GROUP_SCHED
>  /*
>   * Because list_add_leaf_cfs_rq always places a child cfs_rq on the list
> @@ -3356,27 +3358,9 @@ void set_task_rq_fair(struct sched_entity *se,
>  	if (!(se->avg.last_update_time && prev))
>  		return;
>  
> -#ifndef CONFIG_64BIT
> -	{
> -		u64 p_last_update_time_copy;
> -		u64 n_last_update_time_copy;
> -
> -		do {
> -			p_last_update_time_copy = prev->load_last_update_time_copy;
> -			n_last_update_time_copy = next->load_last_update_time_copy;
> -
> -			smp_rmb();
> +	p_last_update_time = cfs_rq_last_update_time(prev);
> +	n_last_update_time = cfs_rq_last_update_time(next);
>  
> -			p_last_update_time = prev->avg.last_update_time;
> -			n_last_update_time = next->avg.last_update_time;
> -
> -		} while (p_last_update_time != p_last_update_time_copy ||
> -			 n_last_update_time != n_last_update_time_copy);
> -	}
> -#else
> -	p_last_update_time = prev->avg.last_update_time;
> -	n_last_update_time = next->avg.last_update_time;
> -#endif
>  	__update_load_avg_blocked_se(p_last_update_time, se);
>  	se->avg.last_update_time = n_last_update_time;
>  }
> @@ -3700,8 +3684,9 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
>  	decayed |= __update_load_avg_cfs_rq(now, cfs_rq);
>  
>  #ifndef CONFIG_64BIT
> -	smp_wmb();
> -	cfs_rq->load_last_update_time_copy = sa->last_update_time;
> +	u64_u32_store_copy(sa->last_update_time,
> +			   cfs_rq->last_update_time_copy,
> +			   sa->last_update_time);
>  #endif
>  
>  	return decayed;
> @@ -3834,27 +3819,6 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
>  	}
>  }
>  
> -#ifndef CONFIG_64BIT
> -static inline u64 cfs_rq_last_update_time(struct cfs_rq *cfs_rq)
> -{
> -	u64 last_update_time_copy;
> -	u64 last_update_time;
> -
> -	do {
> -		last_update_time_copy = cfs_rq->load_last_update_time_copy;
> -		smp_rmb();
> -		last_update_time = cfs_rq->avg.last_update_time;
> -	} while (last_update_time != last_update_time_copy);
> -
> -	return last_update_time;
> -}
> -#else
> -static inline u64 cfs_rq_last_update_time(struct cfs_rq *cfs_rq)
> -{
> -	return cfs_rq->avg.last_update_time;
> -}
> -#endif
> -
>  /*
>   * Synchronize entity load avg of dequeued entity without locking
>   * the previous rq.
> @@ -6904,21 +6868,8 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
>  	if (READ_ONCE(p->__state) == TASK_WAKING) {
>  		struct sched_entity *se = &p->se;
>  		struct cfs_rq *cfs_rq = cfs_rq_of(se);
> -		u64 min_vruntime;
>  
> -#ifndef CONFIG_64BIT
> -		u64 min_vruntime_copy;
> -
> -		do {
> -			min_vruntime_copy = cfs_rq->min_vruntime_copy;
> -			smp_rmb();
> -			min_vruntime = cfs_rq->min_vruntime;
> -		} while (min_vruntime != min_vruntime_copy);
> -#else
> -		min_vruntime = cfs_rq->min_vruntime;
> -#endif
> -
> -		se->vruntime -= min_vruntime;
> +		se->vruntime -= u64_u32_load(cfs_rq->min_vruntime);
>  	}
>  
>  	if (p->on_rq == TASK_ON_RQ_MIGRATING) {
> @@ -11362,10 +11313,7 @@ static void set_next_task_fair(struct rq *rq, struct task_struct *p, bool first)
>  void init_cfs_rq(struct cfs_rq *cfs_rq)
>  {
>  	cfs_rq->tasks_timeline = RB_ROOT_CACHED;
> -	cfs_rq->min_vruntime = (u64)(-(1LL << 20));
> -#ifndef CONFIG_64BIT
> -	cfs_rq->min_vruntime_copy = cfs_rq->min_vruntime;
> -#endif
> +	u64_u32_store(cfs_rq->min_vruntime, (u64)(-(1LL << 20)));
>  #ifdef CONFIG_SMP
>  	raw_spin_lock_init(&cfs_rq->removed.lock);
>  #endif
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index de53be905739..f1a445efdc63 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -528,6 +528,45 @@ struct cfs_bandwidth { };
>  
>  #endif	/* CONFIG_CGROUP_SCHED */
>  
> +/*
> + * u64_u32_load/u64_u32_store
> + *
> + * Use a copy of a u64 value to protect against data race. This is only
> + * applicable for 32-bits architectures.
> + */
> +#ifdef CONFIG_64BIT
> +# define u64_u32_load_copy(var, copy)       var
> +# define u64_u32_store_copy(var, copy, val) (var = val)
> +#else
> +# define u64_u32_load_copy(var, copy)					\
> +({									\
> +	u64 __val, __val_copy;						\
> +	do {								\
> +		__val_copy = copy;					\
> +		/*							\
> +		 * paired with u64_u32_store, ordering access		\
> +		 * to var and copy.					\
> +		 */							\
> +		smp_rmb();						\
> +		__val = var;						\
> +	} while (__val != __val_copy);					\
> +	__val;								\
> +})
> +# define u64_u32_store_copy(var, copy, val)				\
> +do {									\
> +	typeof(val) __val = (val);					\
> +	var = __val;							\
> +	/*								\
> +	 * paired with u64_u32_load, ordering access to var and		\
> +	 * copy.							\
> +	 */								\
> +	smp_wmb();							\
> +	copy = __val;							\
> +} while (0)

Code stay there some time from me. Just from my crude review;
The above macro need a variable to load @var temporarily for
later store; that means the @copy value is from @var not @val.

  # define u64_u32_store_copy(var, copy, val)				\
  do {									\
    typeof(val) __val = (val), __var = (var);					\
    var = __val;							\
    /*								\
     * paired with u64_u32_load, ordering access to var and		\
     * copy.							\
     */								\
    smp_wmb();							\
    copy = __var;							\
  } while (0)



Thanks,
Tao
> +#endif
> +# define u64_u32_load(var)      u64_u32_load_copy(var, var##_copy)
> +# define u64_u32_store(var, val) u64_u32_store_copy(var, var##_copy, val)
> +
>  /* CFS-related fields in a runqueue */
>  struct cfs_rq {
>  	struct load_weight	load;
> @@ -568,7 +607,7 @@ struct cfs_rq {
>  	 */
>  	struct sched_avg	avg;
>  #ifndef CONFIG_64BIT
> -	u64			load_last_update_time_copy;
> +	u64			last_update_time_copy;
>  #endif
>  	struct {
>  		raw_spinlock_t	lock ____cacheline_aligned;
> -- 
> 2.25.1
> 
