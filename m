Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 998AE54AF73
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 13:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237325AbiFNLqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 07:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231934AbiFNLqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 07:46:02 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB2546C94
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 04:46:00 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id q15so10866831wrc.11
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 04:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NbrvkQXoWAIdbm2OdMqGbk8XqEkcTdgt+y9/urcm7w8=;
        b=ZinIhmpcEeg4a+4vWFH8GCDTWKCkaG2CiMrC2KL2DgxZGJmIzHcharGFdoGM3XqhjC
         +LAhhB/U+1aCC3yYqX0/t6B3O0SGCuFYjObfXaucSQ6h/i5pF3RYB7a15wQ/9S77eRfc
         9yOxOKV5OjD84jN42I8g8GfPWxJRnTM+lO5OG37yBXmK/wqXZfNJNT3ohiRjCdQaufhq
         WK3QqCWUadL4Q9CSkGJAD0Bv8/D11wG1okGts3PYyljjH8a8jHaA9xBDAnWqzV834S64
         i0mPTD3rqOQLFSEuHjaxOIntS+W8fX06fqYSodT9Fn+9xb+j1GVmx4eP25qbzPFEY7TM
         LLdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NbrvkQXoWAIdbm2OdMqGbk8XqEkcTdgt+y9/urcm7w8=;
        b=MOH5BkiQ7ToUrOJQc8B7bXgdEx/GM4yFwKbUsErSI3baCP8etJlXE/8HkMJE/YHPgG
         xu+AHSWKhuEFCTwmjTGKWynBjtAH51JyJMq02MWbyYd2sj7X4QHnsjzEVKwl9txlw2Gz
         0vthnUaPod6r66c3wgjy9Lbrmz98cNG1Ye3Mso+GEmw4p03lt0evp6NF4dI5sGI48rcL
         YH04qOZb9Rd4p71f0zqMXa6D86WdxCvYWs75Nvyncdnc01pejU0i/SkkbqgDdOc8eW8N
         /lPYek4qkO8935lHrWvJJkVPgVXVidoI14NcvszFR2dBn9g5lAPdRLNAuFLzFStUMWrs
         Xipg==
X-Gm-Message-State: AJIora/DbN0+Vl1VdOcei7PsbeMBMeVkIGtZH2M6f15txz0gnkDnXp+G
        4YRPufemsXkySZo9ufhmp4KgPQ==
X-Google-Smtp-Source: AGRyM1saoV0190lsBq4i8sQykPS69jqUO/5h0hYtfZRZ+jx2B5cB5Sb/1xfX4Jr2MwsJ6MU9V5LCVw==
X-Received: by 2002:a5d:6d85:0:b0:20f:e96b:84de with SMTP id l5-20020a5d6d85000000b0020fe96b84demr4508277wrs.427.1655207158897;
        Tue, 14 Jun 2022 04:45:58 -0700 (PDT)
Received: from google.com (109.36.187.35.bc.googleusercontent.com. [35.187.36.109])
        by smtp.gmail.com with ESMTPSA id bd17-20020a05600c1f1100b0039c975aa553sm5483964wmb.25.2022.06.14.04.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 04:45:58 -0700 (PDT)
Date:   Tue, 14 Jun 2022 12:45:50 +0100
From:   Vincent Donnefort <vdonnefort@google.com>
To:     Tao Zhou <tao.zhou@linux.dev>
Cc:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com,
        qperret@google.com, kernel-team@android.com
Subject: Re: [PATCH v10 1/7] sched/fair: Provide u64 read for 32-bits arch
 helper
Message-ID: <Yqh07r/lOq2Y7LPk@google.com>
References: <20220607123254.565579-1-vdonnefort@google.com>
 <20220607123254.565579-2-vdonnefort@google.com>
 <YqIQW14RLk6DBmmt@geo.homenetwork>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqIQW14RLk6DBmmt@geo.homenetwork>
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

On Thu, Jun 09, 2022 at 11:23:07PM +0800, Tao Zhou wrote:
> On Tue, Jun 07, 2022 at 01:32:48PM +0100, Vincent Donnefort wrote:
> 
> > From: Vincent Donnefort <vincent.donnefort@arm.com>
> > 
> > Introducing macro helpers u64_u32_{store,load}() to factorize lockless
> > accesses to u64 variables for 32-bits architectures.
> > 
> > Users are for now cfs_rq.min_vruntime and sched_avg.last_update_time. To
> > accommodate the later where the copy lies outside of the structure
> > (cfs_rq.last_udpate_time_copy instead of sched_avg.last_update_time_copy),
> > use the _copy() version of those helpers.
> > 
> > Those new helpers encapsulate smp_rmb() and smp_wmb() synchronization and
> > therefore, have a small penalty for 32-bits machines in set_task_rq_fair()
> > and init_cfs_rq().
> > 
> > Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
> > Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
> > Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> > 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 77b2048a9326..05614d9b919c 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -612,11 +612,8 @@ static void update_min_vruntime(struct cfs_rq *cfs_rq)
> >  	}
> >  
> >  	/* ensure we never gain time by being placed backwards. */
> > -	cfs_rq->min_vruntime = max_vruntime(cfs_rq->min_vruntime, vruntime);
> > -#ifndef CONFIG_64BIT
> > -	smp_wmb();
> > -	cfs_rq->min_vruntime_copy = cfs_rq->min_vruntime;
> > -#endif
> > +	u64_u32_store(cfs_rq->min_vruntime,
> > +		      max_vruntime(cfs_rq->min_vruntime, vruntime));
> >  }
> >  
> >  static inline bool __entity_less(struct rb_node *a, const struct rb_node *b)
> > @@ -3313,6 +3310,11 @@ static inline void cfs_rq_util_change(struct cfs_rq *cfs_rq, int flags)
> >  }
> >  
> >  #ifdef CONFIG_SMP
> > +static inline u64 cfs_rq_last_update_time(struct cfs_rq *cfs_rq)
> > +{
> > +	return u64_u32_load_copy(cfs_rq->avg.last_update_time,
> > +				 cfs_rq->last_update_time_copy);
> > +}
> >  #ifdef CONFIG_FAIR_GROUP_SCHED
> >  /*
> >   * Because list_add_leaf_cfs_rq always places a child cfs_rq on the list
> > @@ -3423,27 +3425,9 @@ void set_task_rq_fair(struct sched_entity *se,
> >  	if (!(se->avg.last_update_time && prev))
> >  		return;
> >  
> > -#ifndef CONFIG_64BIT
> > -	{
> > -		u64 p_last_update_time_copy;
> > -		u64 n_last_update_time_copy;
> > -
> > -		do {
> > -			p_last_update_time_copy = prev->load_last_update_time_copy;
> > -			n_last_update_time_copy = next->load_last_update_time_copy;
> > -
> > -			smp_rmb();
> > -
> > -			p_last_update_time = prev->avg.last_update_time;
> > -			n_last_update_time = next->avg.last_update_time;
> > +	p_last_update_time = cfs_rq_last_update_time(prev);
> > +	n_last_update_time = cfs_rq_last_update_time(next);
> >  
> > -		} while (p_last_update_time != p_last_update_time_copy ||
> > -			 n_last_update_time != n_last_update_time_copy);
> > -	}
> > -#else
> > -	p_last_update_time = prev->avg.last_update_time;
> > -	n_last_update_time = next->avg.last_update_time;
> > -#endif
> >  	__update_load_avg_blocked_se(p_last_update_time, se);
> >  	se->avg.last_update_time = n_last_update_time;
> >  }
> > @@ -3796,12 +3780,9 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
> >  	}
> >  
> >  	decayed |= __update_load_avg_cfs_rq(now, cfs_rq);
> > -
> > -#ifndef CONFIG_64BIT
> > -	smp_wmb();
> > -	cfs_rq->load_last_update_time_copy = sa->last_update_time;
> > -#endif
> > -
> > +	u64_u32_store_copy(sa->last_update_time,
> > +			   cfs_rq->last_update_time_copy,
> > +			   sa->last_update_time);
> >  	return decayed;
> >  }
> >  
> > @@ -3933,27 +3914,6 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
> >  	}
> >  }
> >  
> > -#ifndef CONFIG_64BIT
> > -static inline u64 cfs_rq_last_update_time(struct cfs_rq *cfs_rq)
> > -{
> > -	u64 last_update_time_copy;
> > -	u64 last_update_time;
> > -
> > -	do {
> > -		last_update_time_copy = cfs_rq->load_last_update_time_copy;
> > -		smp_rmb();
> > -		last_update_time = cfs_rq->avg.last_update_time;
> > -	} while (last_update_time != last_update_time_copy);
> > -
> > -	return last_update_time;
> > -}
> > -#else
> > -static inline u64 cfs_rq_last_update_time(struct cfs_rq *cfs_rq)
> > -{
> > -	return cfs_rq->avg.last_update_time;
> > -}
> > -#endif
> > -
> >  /*
> >   * Synchronize entity load avg of dequeued entity without locking
> >   * the previous rq.
> > @@ -6960,21 +6920,8 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
> >  	if (READ_ONCE(p->__state) == TASK_WAKING) {
> >  		struct sched_entity *se = &p->se;
> >  		struct cfs_rq *cfs_rq = cfs_rq_of(se);
> > -		u64 min_vruntime;
> > -
> > -#ifndef CONFIG_64BIT
> > -		u64 min_vruntime_copy;
> > -
> > -		do {
> > -			min_vruntime_copy = cfs_rq->min_vruntime_copy;
> > -			smp_rmb();
> > -			min_vruntime = cfs_rq->min_vruntime;
> > -		} while (min_vruntime != min_vruntime_copy);
> > -#else
> > -		min_vruntime = cfs_rq->min_vruntime;
> > -#endif
> >  
> > -		se->vruntime -= min_vruntime;
> > +		se->vruntime -= u64_u32_load(cfs_rq->min_vruntime);
> >  	}
> >  
> >  	if (p->on_rq == TASK_ON_RQ_MIGRATING) {
> > @@ -11422,10 +11369,7 @@ static void set_next_task_fair(struct rq *rq, struct task_struct *p, bool first)
> >  void init_cfs_rq(struct cfs_rq *cfs_rq)
> >  {
> >  	cfs_rq->tasks_timeline = RB_ROOT_CACHED;
> > -	cfs_rq->min_vruntime = (u64)(-(1LL << 20));
> > -#ifndef CONFIG_64BIT
> > -	cfs_rq->min_vruntime_copy = cfs_rq->min_vruntime;
> > -#endif
> > +	u64_u32_store(cfs_rq->min_vruntime, (u64)(-(1LL << 20)));
> >  #ifdef CONFIG_SMP
> >  	raw_spin_lock_init(&cfs_rq->removed.lock);
> >  #endif
> > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > index 1f97f357aacd..bf4a0ec98678 100644
> > --- a/kernel/sched/sched.h
> > +++ b/kernel/sched/sched.h
> > @@ -520,6 +520,45 @@ struct cfs_bandwidth { };
> >  
> >  #endif	/* CONFIG_CGROUP_SCHED */
> >  
> > +/*
> > + * u64_u32_load/u64_u32_store
> > + *
> > + * Use a copy of a u64 value to protect against data race. This is only
> > + * applicable for 32-bits architectures.
> > + */
> > +#ifdef CONFIG_64BIT
> > +# define u64_u32_load_copy(var, copy)       var
> > +# define u64_u32_store_copy(var, copy, val) (var = val)
> > +#else
> > +# define u64_u32_load_copy(var, copy)					\
> > +({									\
> > +	u64 __val, __val_copy;						\
> > +	do {								\
> > +		__val_copy = copy;					\
> > +		/*							\
> > +		 * paired with u64_u32_store, ordering access		\
> 
> s/u64_u32_store/u64_u32_store_copy()/

Ack.

> 
> > +		 * to var and copy.					\
> > +		 */							\
> > +		smp_rmb();						\
> > +		__val = var;						\
> > +	} while (__val != __val_copy);					\
> > +	__val;								\
> > +})
> > +# define u64_u32_store_copy(var, copy, val)				\
> > +do {									\
> > +	typeof(val) __val = (val);					\
> > +	var = __val;							\
> > +	/*								\
> > +	 * paired with u64_u32_load, ordering access to var and		\
> 
> s/u64_u32_load/u64_u32_load_copy()/

Ack.

> 
> > +	 * copy.							\
> > +	 */								\
> > +	smp_wmb();							\
> > +	copy = __val;							\
> > +} while (0)
> 
> Try again here from me.
> The semantics of this macro is different from the original code.
> To be consistent with the original code, the 'copy = __val;' should
> be changed to 'copy = var'. Why not original code here.
> 
> They are different in that the var can be changed currently on another
> CPU and copy can be different from __val.

I'm not sure I understand your point here. We are using a temporary variable to
set both var and copy. They'll end-up with the same value which is what we want.

If what you worries is a concurrent write, you need a lock to modify the
last_update_time or the min_vruntime (and the other values introduced
by this patchset).

This is not about reading an up to date value, it is about reading a sane one.

> 
> Documentation/memory-barriers.txt(line 1351, 5.19.0-rc1-rt1):
> In section:
> (*) What are memory barriers?
>      - Multicopy atomicity.
> The example there can be referenced here I think.
> 
> And I feel that here the smp_wmb() should be changed to smp_mb(). One user
> of this macro have the load/write  write. Another user have write  write
> if I am not wrong.

I do not get this part. the _store_copy() only store var and copy. Hence the
smp_wmb. While the _load_copy() only load var and and copy, hence the smp_rmb.

This is actually described in the section "SMP BARRIER PAIRING".

> 
> Also,
> 
> 'Memory Barriers: a Hardware View for Software Hackers' (July 23, 2010)
> Section: 6.3 Example 2, I just scrolled to the code in table 3 and check
> that the semantics there is almost the same with the semantics here.
> 
> I do not have confidence to convince anything just after some days when I
> read it.
> 
> According to those two examples, if the small penalty is small, this
> u64_u32_store_copy() macro should be changed like this:
> 
> # define u64_u32_store_copy(var, copy, val)				\
> do {									\
> 	typeof(val) __val = (val);					\
> 	var = __val;							\
> 	/*								\
> 	 * paired with u64_u32_load_copy(), ordering access to var and	\
> 	 * copy.							\
> 	 */								\
> 	smp_mb();							\
> 	copy = var;							\
> } while (0)
> 
> Not sure and this is the continuation to my reply to this patch in v4.
> 
> Thanks,
> Tao
> > +#endif
> > +# define u64_u32_load(var)      u64_u32_load_copy(var, var##_copy)
> > +# define u64_u32_store(var, val) u64_u32_store_copy(var, var##_copy, val)
> > +
> >  /* CFS-related fields in a runqueue */
> >  struct cfs_rq {	
> >  	struct load_weight	load;
> > @@ -560,7 +599,7 @@ struct cfs_rq {
> >  	 */
> >  	struct sched_avg	avg;
> >  #ifndef CONFIG_64BIT
> > -	u64			load_last_update_time_copy;
> > +	u64			last_update_time_copy;
> >  #endif
> >  	struct {
> >  		raw_spinlock_t	lock ____cacheline_aligned;
> > -- 
> > 2.36.1.255.ge46751e96f-goog
> 
> -- 
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
> 
