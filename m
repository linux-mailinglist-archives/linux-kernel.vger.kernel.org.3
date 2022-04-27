Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E27A510EA2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 04:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357108AbiD0CT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 22:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243942AbiD0CTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 22:19:23 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE7B140903
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 19:16:13 -0700 (PDT)
Date:   Wed, 27 Apr 2022 10:16:46 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1651025772;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=25L3lWUxeIr1lZ6znnTjqJdO9Zp8f+8QCFUx4HCyX9E=;
        b=nTNEJ248/EDRBu6jboImhy41ROWOhs8PIDF5sjqQcmNa7ZgzHgoA+Kybf11B0sVQhznTLi
        6cI8TQE4K/7QQIxC1gvwvLbg8vPrkxAL1QrCtIa+qm0tS5Pr0Nv+1YJSz3YSeo27r+ndKB
        uUta0zMhV0TNm8qhn1ahkDDdxVPqD+Y=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Tao Zhou <tao.zhou@linux.dev>
To:     Vincent Donnefort <vincent.donnefort@arm.com>,
        Tao Zhou <tao.zhou@linux.dev>
Cc:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com, qperret@google.com
Subject: Re: [PATCH v6 1/7] sched/fair: Provide u64 read for 32-bits arch
 helper
Message-ID: <YminjvSRtKdHETF4@geo.homenetwork>
References: <20220426093506.3415588-1-vincent.donnefort@arm.com>
 <20220426093506.3415588-2-vincent.donnefort@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426093506.3415588-2-vincent.donnefort@arm.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        TO_EQ_FM_DIRECT_MX autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 10:35:00AM +0100, Vincent Donnefort wrote:

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
> index 4c420124b5d6..abd1feeec0c2 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -600,11 +600,8 @@ static void update_min_vruntime(struct cfs_rq *cfs_rq)
>  	}
>  
>  	/* ensure we never gain time by being placed backwards. */
> -	cfs_rq->min_vruntime = max_vruntime(cfs_rq->min_vruntime, vruntime);

This is like RMW right . Presume that min_vruntime cached on CPU1 and
min_vruntime_copy cached on CPU0. CPU0 load cfs_rq->min_runtime and
it need to send the 'read invalid' message(not 'read' because this is
like RMW, is it know about this, don't know, if this assert is not right,
the below is not right too) to CPU1. This invalidation will be synced
on CPU1 and do invalid and the cache data will be on CPU0 and the state
is like 'exclusve'. The modification of this cache on CPU0 will not need
to store on store buffer because the cache is local now. Feel the smp_wmb()
is not needed here. But not sure.

> -#ifndef CONFIG_64BIT
> -	smp_wmb();
> -	cfs_rq->min_vruntime_copy = cfs_rq->min_vruntime;
> -#endif
> +	u64_u32_store(cfs_rq->min_vruntime,
> +		      max_vruntime(cfs_rq->min_vruntime, vruntime));
>  }
>  
>  static inline bool __entity_less(struct rb_node *a, const struct rb_node *b)
> @@ -3301,6 +3298,11 @@ static inline void cfs_rq_util_change(struct cfs_rq *cfs_rq, int flags)
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
> @@ -3411,27 +3413,9 @@ void set_task_rq_fair(struct sched_entity *se,
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
> @@ -3786,8 +3770,9 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
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
> @@ -3921,27 +3906,6 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
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
> @@ -6991,21 +6955,8 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
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
> @@ -11453,10 +11404,7 @@ static void set_next_task_fair(struct rq *rq, struct task_struct *p, bool first)
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
> index 762be73972bd..e2cf6e48b165 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -513,6 +513,45 @@ struct cfs_bandwidth { };
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
> +#endif
> +# define u64_u32_load(var)      u64_u32_load_copy(var, var##_copy)
> +# define u64_u32_store(var, val) u64_u32_store_copy(var, var##_copy, val)
> +
>  /* CFS-related fields in a runqueue */
>  struct cfs_rq {
>  	struct load_weight	load;
> @@ -553,7 +592,7 @@ struct cfs_rq {
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
