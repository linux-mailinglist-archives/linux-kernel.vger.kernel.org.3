Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03DAE54509F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 17:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242717AbiFIPWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 11:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235758AbiFIPWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 11:22:20 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A664A90E
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 08:22:18 -0700 (PDT)
Date:   Thu, 9 Jun 2022 23:23:07 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1654788136;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EvFlr9jWMKJlj83y7nexAJxr7Y4+e2ShZqmtpIoClAQ=;
        b=oCxB2LqT8cvG54QvEQZ60RdyEib+dYZOp4BhdE95SbyWmJWwJpJuE0HV/8QiZUSKBWCJ3o
        TaDFyJm58NJijKbi7OEuK9xYDD4WahKkBsDLbr1XCOcvH2SBAkdU9hX0zBzfGYq1WaA7x4
        iOZj5ybAlO5mc5tK3rsTWyqAhFKMnFE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Tao Zhou <tao.zhou@linux.dev>
To:     Vincent Donnefort <vdonnefort@google.com>
Cc:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com,
        qperret@google.com, kernel-team@android.com,
        Tao Zhou <tao.zhou@linux.dev>
Subject: Re: [PATCH v10 1/7] sched/fair: Provide u64 read for 32-bits arch
 helper
Message-ID: <YqIQW14RLk6DBmmt@geo.homenetwork>
References: <20220607123254.565579-1-vdonnefort@google.com>
 <20220607123254.565579-2-vdonnefort@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607123254.565579-2-vdonnefort@google.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2022 at 01:32:48PM +0100, Vincent Donnefort wrote:

> From: Vincent Donnefort <vincent.donnefort@arm.com>
> 
> Introducing macro helpers u64_u32_{store,load}() to factorize lockless
> accesses to u64 variables for 32-bits architectures.
> 
> Users are for now cfs_rq.min_vruntime and sched_avg.last_update_time. To
> accommodate the later where the copy lies outside of the structure
> (cfs_rq.last_udpate_time_copy instead of sched_avg.last_update_time_copy),
> use the _copy() version of those helpers.
> 
> Those new helpers encapsulate smp_rmb() and smp_wmb() synchronization and
> therefore, have a small penalty for 32-bits machines in set_task_rq_fair()
> and init_cfs_rq().
> 
> Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
> Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
> Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 77b2048a9326..05614d9b919c 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -612,11 +612,8 @@ static void update_min_vruntime(struct cfs_rq *cfs_rq)
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
> @@ -3313,6 +3310,11 @@ static inline void cfs_rq_util_change(struct cfs_rq *cfs_rq, int flags)
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
> @@ -3423,27 +3425,9 @@ void set_task_rq_fair(struct sched_entity *se,
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
> -
> -			p_last_update_time = prev->avg.last_update_time;
> -			n_last_update_time = next->avg.last_update_time;
> +	p_last_update_time = cfs_rq_last_update_time(prev);
> +	n_last_update_time = cfs_rq_last_update_time(next);
>  
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
> @@ -3796,12 +3780,9 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
>  	}
>  
>  	decayed |= __update_load_avg_cfs_rq(now, cfs_rq);
> -
> -#ifndef CONFIG_64BIT
> -	smp_wmb();
> -	cfs_rq->load_last_update_time_copy = sa->last_update_time;
> -#endif
> -
> +	u64_u32_store_copy(sa->last_update_time,
> +			   cfs_rq->last_update_time_copy,
> +			   sa->last_update_time);
>  	return decayed;
>  }
>  
> @@ -3933,27 +3914,6 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
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
> @@ -6960,21 +6920,8 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
>  	if (READ_ONCE(p->__state) == TASK_WAKING) {
>  		struct sched_entity *se = &p->se;
>  		struct cfs_rq *cfs_rq = cfs_rq_of(se);
> -		u64 min_vruntime;
> -
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
>  
> -		se->vruntime -= min_vruntime;
> +		se->vruntime -= u64_u32_load(cfs_rq->min_vruntime);
>  	}
>  
>  	if (p->on_rq == TASK_ON_RQ_MIGRATING) {
> @@ -11422,10 +11369,7 @@ static void set_next_task_fair(struct rq *rq, struct task_struct *p, bool first)
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
> index 1f97f357aacd..bf4a0ec98678 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -520,6 +520,45 @@ struct cfs_bandwidth { };
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

s/u64_u32_store/u64_u32_store_copy()/

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

s/u64_u32_load/u64_u32_load_copy()/

> +	 * copy.							\
> +	 */								\
> +	smp_wmb();							\
> +	copy = __val;							\
> +} while (0)

Try again here from me.
The semantics of this macro is different from the original code.
To be consistent with the original code, the 'copy = __val;' should
be changed to 'copy = var'. Why not original code here.

They are different in that the var can be changed currently on another
CPU and copy can be different from __val.

Documentation/memory-barriers.txt(line 1351, 5.19.0-rc1-rt1):
In section:
(*) What are memory barriers?
     - Multicopy atomicity.
The example there can be referenced here I think.

And I feel that here the smp_wmb() should be changed to smp_mb(). One user
of this macro have the load/write  write. Another user have write  write
if I am not wrong.

Also,

'Memory Barriers: a Hardware View for Software Hackers' (July 23, 2010)
Section: 6.3 Example 2, I just scrolled to the code in table 3 and check
that the semantics there is almost the same with the semantics here.

I do not have confidence to convince anything just after some days when I
read it.

According to those two examples, if the small penalty is small, this
u64_u32_store_copy() macro should be changed like this:

# define u64_u32_store_copy(var, copy, val)				\
do {									\
	typeof(val) __val = (val);					\
	var = __val;							\
	/*								\
	 * paired with u64_u32_load_copy(), ordering access to var and	\
	 * copy.							\
	 */								\
	smp_mb();							\
	copy = var;							\
} while (0)

Not sure and this is the continuation to my reply to this patch in v4.

Thanks,
Tao
> +#endif
> +# define u64_u32_load(var)      u64_u32_load_copy(var, var##_copy)
> +# define u64_u32_store(var, val) u64_u32_store_copy(var, var##_copy, val)
> +
>  /* CFS-related fields in a runqueue */
>  struct cfs_rq {
>  	struct load_weight	load;
> @@ -560,7 +599,7 @@ struct cfs_rq {
>  	 */
>  	struct sched_avg	avg;
>  #ifndef CONFIG_64BIT
> -	u64			load_last_update_time_copy;
> +	u64			last_update_time_copy;
>  #endif
>  	struct {
>  		raw_spinlock_t	lock ____cacheline_aligned;
> -- 
> 2.36.1.255.ge46751e96f-goog
