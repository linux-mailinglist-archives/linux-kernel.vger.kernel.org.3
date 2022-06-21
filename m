Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB6C552D0A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 10:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348193AbiFUIch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 04:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348190AbiFUIcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 04:32:35 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD0D15830
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 01:32:33 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id o16so17828267wra.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 01:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LjO7Mi3v5SiRcxe9gzo49oqtHUHeSrc+LgHV3ioEodU=;
        b=DHTcbBs0EksoTE5Dow/BFyfvYZpjxq1xX9vocYN3PjbYtSk79XTBey4E5XbzEhyuEw
         aeCqvcTvmYxgE5SdNKZJcaWlfILA79N+lQOD/iPg1iIURud5dx9L5PA7Nd1j16RJzrPS
         MFSEKOwkpFL7/aQ/DbHDp3HHLwFEO/YAX1TW8NT36gXzHsS41hjXLMBflMtgX3lWI6w1
         2kycb/cog5I7JdRAJLjA9XAC3udKccokV93tascPJmhHDMhRIGgFdNJxZA5hxmoiLU/K
         WEOv3ztPaxHYjy5jcDhJPxHGq8RtRA/hMrX2ltssHqInkRwK6L9evYcjcpRJHoGC2Ok/
         JeQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LjO7Mi3v5SiRcxe9gzo49oqtHUHeSrc+LgHV3ioEodU=;
        b=5g0i47sYsCtXLHmITMsqow90Kk2HR7SYdmNjN7YHIA0j0TsS2OwcpiHMWJ9h0RGB2V
         8gI+wTcXtMoq796SarTIQht15rLjdMdvjY5OjfX2Y2wZhKy36etZPC8HfAygjo1yaHkI
         q2uLhIRSDX3lF729LG8ztfdI7oHC9I0HRPiufGewHDedCZ77Ei3c20nie6rT4UldPm6p
         p3rbLjawi52sEQHeQ1I5j9Iho/4Oax+aIKVL10AUfwqmbsSiqyTLkjt7Mbfd82omhhzx
         D2Yqx0I8yxGmTpfrbwbVd7SxfTiUatpsQfdbh+lu/nhUEi4ld9mCD2nx5yOxdXX8+ozO
         BLag==
X-Gm-Message-State: AJIora90wJfq/ZXqDtIZeA+mTNplB+2pwB9Pjw1B2ziC9GyPwaYdy5Zw
        zzPLUMIGC9lVKZoXLj0zCgl+aw==
X-Google-Smtp-Source: AGRyM1vyPQcUpgDW+qH/0j9aw3GRRxZv0VLtoRcnvrXsa+ZJwcZmPcIySCHg2yP+WPZpVQDPvuopQg==
X-Received: by 2002:a5d:620f:0:b0:20c:c1ba:cf8e with SMTP id y15-20020a5d620f000000b0020cc1bacf8emr26676958wru.426.1655800351502;
        Tue, 21 Jun 2022 01:32:31 -0700 (PDT)
Received: from google.com (109.36.187.35.bc.googleusercontent.com. [35.187.36.109])
        by smtp.gmail.com with ESMTPSA id h17-20020a05600c2cb100b00397393419e3sm21979197wmc.28.2022.06.21.01.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 01:32:30 -0700 (PDT)
Date:   Tue, 21 Jun 2022 09:32:26 +0100
From:   Vincent Donnefort <vdonnefort@google.com>
To:     Tao Zhou <tao.zhou@linux.dev>
Cc:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com,
        qperret@google.com, kernel-team@android.com
Subject: Re: [PATCH v10 1/7] sched/fair: Provide u64 read for 32-bits arch
 helper
Message-ID: <YrGCGiesVhrx/Ej1@google.com>
References: <20220607123254.565579-1-vdonnefort@google.com>
 <20220607123254.565579-2-vdonnefort@google.com>
 <YqIQW14RLk6DBmmt@geo.homenetwork>
 <Yqh07r/lOq2Y7LPk@google.com>
 <YqibDwOz7/sb6sSz@geo.homenetwork>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqibDwOz7/sb6sSz@geo.homenetwork>
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

On Tue, Jun 14, 2022 at 10:28:31PM +0800, Tao Zhou wrote:
> On Tue, Jun 14, 2022 at 12:45:50PM +0100, Vincent Donnefort wrote:
> 
> > On Thu, Jun 09, 2022 at 11:23:07PM +0800, Tao Zhou wrote:
> > > On Tue, Jun 07, 2022 at 01:32:48PM +0100, Vincent Donnefort wrote:
> > > 
> > > > From: Vincent Donnefort <vincent.donnefort@arm.com>
> > > > 
> > > > Introducing macro helpers u64_u32_{store,load}() to factorize lockless
> > > > accesses to u64 variables for 32-bits architectures.
> > > > 
> > > > Users are for now cfs_rq.min_vruntime and sched_avg.last_update_time. To
> > > > accommodate the later where the copy lies outside of the structure
> > > > (cfs_rq.last_udpate_time_copy instead of sched_avg.last_update_time_copy),
> > > > use the _copy() version of those helpers.
> > > > 
> > > > Those new helpers encapsulate smp_rmb() and smp_wmb() synchronization and
> > > > therefore, have a small penalty for 32-bits machines in set_task_rq_fair()
> > > > and init_cfs_rq().
> > > > 
> > > > Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
> > > > Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
> > > > Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> > > > 
> > > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > > index 77b2048a9326..05614d9b919c 100644
> > > > --- a/kernel/sched/fair.c
> > > > +++ b/kernel/sched/fair.c
> > > > @@ -612,11 +612,8 @@ static void update_min_vruntime(struct cfs_rq *cfs_rq)
> > > >  	}
> > > >  
> > > >  	/* ensure we never gain time by being placed backwards. */
> > > > -	cfs_rq->min_vruntime = max_vruntime(cfs_rq->min_vruntime, vruntime);
> > > > -#ifndef CONFIG_64BIT
> > > > -	smp_wmb();
> > > > -	cfs_rq->min_vruntime_copy = cfs_rq->min_vruntime;
> > > > -#endif
> > > > +	u64_u32_store(cfs_rq->min_vruntime,
> > > > +		      max_vruntime(cfs_rq->min_vruntime, vruntime));
> > > >  }
> > > >  
> > > >  static inline bool __entity_less(struct rb_node *a, const struct rb_node *b)
> > > > @@ -3313,6 +3310,11 @@ static inline void cfs_rq_util_change(struct cfs_rq *cfs_rq, int flags)
> > > >  }
> > > >  
> > > >  #ifdef CONFIG_SMP
> > > > +static inline u64 cfs_rq_last_update_time(struct cfs_rq *cfs_rq)
> > > > +{
> > > > +	return u64_u32_load_copy(cfs_rq->avg.last_update_time,
> > > > +				 cfs_rq->last_update_time_copy);
> > > > +}
> > > >  #ifdef CONFIG_FAIR_GROUP_SCHED
> > > >  /*
> > > >   * Because list_add_leaf_cfs_rq always places a child cfs_rq on the list
> > > > @@ -3423,27 +3425,9 @@ void set_task_rq_fair(struct sched_entity *se,
> > > >  	if (!(se->avg.last_update_time && prev))
> > > >  		return;
> > > >  
> > > > -#ifndef CONFIG_64BIT
> > > > -	{
> > > > -		u64 p_last_update_time_copy;
> > > > -		u64 n_last_update_time_copy;
> > > > -
> > > > -		do {
> > > > -			p_last_update_time_copy = prev->load_last_update_time_copy;
> > > > -			n_last_update_time_copy = next->load_last_update_time_copy;
> > > > -
> > > > -			smp_rmb();
> > > > -
> > > > -			p_last_update_time = prev->avg.last_update_time;
> > > > -			n_last_update_time = next->avg.last_update_time;
> > > > +	p_last_update_time = cfs_rq_last_update_time(prev);
> > > > +	n_last_update_time = cfs_rq_last_update_time(next);
> > > >  
> > > > -		} while (p_last_update_time != p_last_update_time_copy ||
> > > > -			 n_last_update_time != n_last_update_time_copy);
> > > > -	}
> > > > -#else
> > > > -	p_last_update_time = prev->avg.last_update_time;
> > > > -	n_last_update_time = next->avg.last_update_time;
> > > > -#endif
> > > >  	__update_load_avg_blocked_se(p_last_update_time, se);
> > > >  	se->avg.last_update_time = n_last_update_time;
> > > >  }
> > > > @@ -3796,12 +3780,9 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
> > > >  	}
> > > >  
> > > >  	decayed |= __update_load_avg_cfs_rq(now, cfs_rq);
> > > > -
> > > > -#ifndef CONFIG_64BIT
> > > > -	smp_wmb();
> > > > -	cfs_rq->load_last_update_time_copy = sa->last_update_time;
> > > > -#endif
> > > > -
> > > > +	u64_u32_store_copy(sa->last_update_time,
> > > > +			   cfs_rq->last_update_time_copy,
> > > > +			   sa->last_update_time);
> > > >  	return decayed;
> > > >  }
> > > >  
> > > > @@ -3933,27 +3914,6 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
> > > >  	}
> > > >  }
> > > >  
> > > > -#ifndef CONFIG_64BIT
> > > > -static inline u64 cfs_rq_last_update_time(struct cfs_rq *cfs_rq)
> > > > -{
> > > > -	u64 last_update_time_copy;
> > > > -	u64 last_update_time;
> > > > -
> > > > -	do {
> > > > -		last_update_time_copy = cfs_rq->load_last_update_time_copy;
> > > > -		smp_rmb();
> > > > -		last_update_time = cfs_rq->avg.last_update_time;
> > > > -	} while (last_update_time != last_update_time_copy);
> > > > -
> > > > -	return last_update_time;
> > > > -}
> > > > -#else
> > > > -static inline u64 cfs_rq_last_update_time(struct cfs_rq *cfs_rq)
> > > > -{
> > > > -	return cfs_rq->avg.last_update_time;
> > > > -}
> > > > -#endif
> > > > -
> > > >  /*
> > > >   * Synchronize entity load avg of dequeued entity without locking
> > > >   * the previous rq.
> > > > @@ -6960,21 +6920,8 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
> > > >  	if (READ_ONCE(p->__state) == TASK_WAKING) {
> > > >  		struct sched_entity *se = &p->se;
> > > >  		struct cfs_rq *cfs_rq = cfs_rq_of(se);
> > > > -		u64 min_vruntime;
> > > > -
> > > > -#ifndef CONFIG_64BIT
> > > > -		u64 min_vruntime_copy;
> > > > -
> > > > -		do {
> > > > -			min_vruntime_copy = cfs_rq->min_vruntime_copy;
> > > > -			smp_rmb();
> > > > -			min_vruntime = cfs_rq->min_vruntime;
> > > > -		} while (min_vruntime != min_vruntime_copy);
> > > > -#else
> > > > -		min_vruntime = cfs_rq->min_vruntime;
> > > > -#endif
> > > >  
> > > > -		se->vruntime -= min_vruntime;
> > > > +		se->vruntime -= u64_u32_load(cfs_rq->min_vruntime);
> > > >  	}
> > > >  
> > > >  	if (p->on_rq == TASK_ON_RQ_MIGRATING) {
> > > > @@ -11422,10 +11369,7 @@ static void set_next_task_fair(struct rq *rq, struct task_struct *p, bool first)
> > > >  void init_cfs_rq(struct cfs_rq *cfs_rq)
> > > >  {
> > > >  	cfs_rq->tasks_timeline = RB_ROOT_CACHED;
> > > > -	cfs_rq->min_vruntime = (u64)(-(1LL << 20));
> > > > -#ifndef CONFIG_64BIT
> > > > -	cfs_rq->min_vruntime_copy = cfs_rq->min_vruntime;
> > > > -#endif
> > > > +	u64_u32_store(cfs_rq->min_vruntime, (u64)(-(1LL << 20)));
> > > >  #ifdef CONFIG_SMP
> > > >  	raw_spin_lock_init(&cfs_rq->removed.lock);
> > > >  #endif
> > > > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > > > index 1f97f357aacd..bf4a0ec98678 100644
> > > > --- a/kernel/sched/sched.h
> > > > +++ b/kernel/sched/sched.h
> > > > @@ -520,6 +520,45 @@ struct cfs_bandwidth { };
> > > >  
> > > >  #endif	/* CONFIG_CGROUP_SCHED */
> > > >  
> > > > +/*
> > > > + * u64_u32_load/u64_u32_store
> > > > + *
> > > > + * Use a copy of a u64 value to protect against data race. This is only
> > > > + * applicable for 32-bits architectures.
> > > > + */
> > > > +#ifdef CONFIG_64BIT
> > > > +# define u64_u32_load_copy(var, copy)       var
> > > > +# define u64_u32_store_copy(var, copy, val) (var = val)
> > > > +#else
> > > > +# define u64_u32_load_copy(var, copy)					\
> > > > +({									\
> > > > +	u64 __val, __val_copy;						\
> > > > +	do {								\
> > > > +		__val_copy = copy;					\
> > > > +		/*							\
> > > > +		 * paired with u64_u32_store, ordering access		\
> > > 
> > > s/u64_u32_store/u64_u32_store_copy()/
> > 
> > Ack.
> > 
> > > 
> > > > +		 * to var and copy.					\
> > > > +		 */							\
> > > > +		smp_rmb();						\
> > > > +		__val = var;						\
> > > > +	} while (__val != __val_copy);					\
> > > > +	__val;								\
> > > > +})
> > > > +# define u64_u32_store_copy(var, copy, val)				\
> > > > +do {									\
> > > > +	typeof(val) __val = (val);					\
>         ^^^^^^^^^^^^^^^^^^^^^^^^^^
>         Instructs to store a local __val..(I missed this sorry)
>         The time for these cycles is possible that eg. cfs_rq->min_vruntime
>         has been updated in this period. But here locally store the
>         old value.

Concurent copies are not possible, min_vruntime needs a lock to be
written.

> 
> > > > +	var = __val;							\
>         ^^^^^^^^^^^^
>         Original code here will load the even updated(more recently)
>         eg. cfs_rq->min_vruntime from other cpus update(the load here
>         is also need a read pair barrier, so I reference that use the
>         smp_mb, but I do not know).
> 
>         I mean the __val here is more possible to be stale. That the
>         ->min_vruntime or ->lut is not latest.
> 
> Your code simplify something but not lead to be more accurate compared to
> original code. Is it possible to delete that local store and restore
> the Data Dependancies that the original code do if your code is not DD.
> 
> All the above may be wrong. Thanks for your time.
> 

[...]
