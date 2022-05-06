Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E521951D9B5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 15:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441947AbiEFOCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 10:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349347AbiEFOCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 10:02:40 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB42C5DBEE
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 06:58:56 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 125-20020a1c1983000000b003941f354c62so4444829wmz.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 06:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=7NQi7Z+MZ52ekr9qbB30etuO5d+uXm02093D4Ar3iUY=;
        b=izUwHl+6O1fYAkEKEALbECwguy+X/j89VkQigILj0y7jZ3pMSEPYxFvNwEuT/KmgwI
         bkV2OIpaed4d9FwqjSEqOc4X52rijGwEdv6lZ8VpWajtsnMqYNxRCZitn8IFW40jlR1Q
         ruIxNx1wEMHcu+LZVbzldi3qGIUG5LymSTKwOMpj7Nm6bgRHyUBOuneq6bJmvTuuqHeG
         k+XBU9L4yifEydIeTYZhc2swKzu8ZhWXdF3cBuDSZwLj1sE2dgWYzxxKIhmItldknsN1
         ETp4qs/P7rp0yHv8c2dc75lCM/rBIZ7YUf+fHwBSe/xXiYADn5p130nZMv5j67dAK27Y
         L8WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=7NQi7Z+MZ52ekr9qbB30etuO5d+uXm02093D4Ar3iUY=;
        b=2hv+B9jQZXr/Phzg+iiptC6MPEf6vJ5vZ0u1Re6Fy0dFmjKTCoawcVUJuk37900XU0
         OtUX5ERzqDOd7sjdKTRbkqBc1O3MxmarDaxeQ468x2lQPNASY++x6GvRxJyaZ9jTq/PW
         vEB4bahwbhgtWcQshKIHDZT70enKoCGKiAvFJ3MLM5O8OpSa5RjZYM2Eiho3P8lVSu6P
         EChs84cPtTCXQhRbpAWWWQEN4Yi3Zz1nechAGZs6PNyPLcLfs8gQPEMSOeAMcXXbmJT2
         84K4xKePl91hcmRQ9WGLdpO0YsA9kn8Cv8pFg76QScyNVYYBJ4BI2ZeRH1JyL1gnOsxN
         X6iA==
X-Gm-Message-State: AOAM5305VGFv0RK0kYm4EvwK/RfsMHCP+LREIuZL7ngdWaF87ApH3XaH
        mePxMcio7+Wafobm3za68PekBaRTsZ0UuA==
X-Google-Smtp-Source: ABdhPJyS7SDb8cfXhEFwryu2L62y7sr8nqg3z2w7oVctIccmu3jA/QytEMpnBUe3ad/UHI63kieDDQ==
X-Received: by 2002:a05:600c:1d95:b0:394:5d0d:6f70 with SMTP id p21-20020a05600c1d9500b003945d0d6f70mr3511520wms.48.1651845535398;
        Fri, 06 May 2022 06:58:55 -0700 (PDT)
Received: from vingu-book ([2a01:e0a:f:6020:c5b3:7af9:c7ac:f42])
        by smtp.gmail.com with ESMTPSA id y9-20020adfdf09000000b0020c5253d90dsm3740765wrl.89.2022.05.06.06.58.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 May 2022 06:58:54 -0700 (PDT)
Date:   Fri, 6 May 2022 15:58:52 +0200
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     Tao Zhou <tao.zhou@linux.dev>
Cc:     Vincent Donnefort <vincent.donnefort@arm.com>,
        peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com, qperret@google.com
Subject: Re: [PATCH v8 2/7] sched/fair: Decay task PELT values during wakeup
 migration
Message-ID: <20220506135852.GA3444@vingu-book>
References: <20220429141148.181816-1-vincent.donnefort@arm.com>
 <20220429141148.181816-3-vincent.donnefort@arm.com>
 <YmwbxQ83RnbXYwgZ@geo.homenetwork>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YmwbxQ83RnbXYwgZ@geo.homenetwork>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le samedi 30 avril 2022 à 01:09:25 (+0800), Tao Zhou a écrit :
> On Fri, Apr 29, 2022 at 03:11:43PM +0100, Vincent Donnefort wrote:

[..]

> >  
> > -static inline u64 rq_clock_pelt(struct rq *rq)
> > +#ifdef CONFIG_CFS_BANDWIDTH
> > +static inline void update_idle_cfs_rq_clock_pelt(struct cfs_rq *cfs_rq)
> >  {
> > -	lockdep_assert_rq_held(rq);
> > -	assert_clock_updated(rq);
> > -
> > -	return rq->clock_pelt - rq->lost_idle_time;
> > +	/*
> > +	 * Make sure that pending update of rq->clock_pelt_idle and
> > +	 * rq->enter_idle are visible during update_blocked_average() before
> > +	 * updating cfs_rq->throttled_pelt_idle.
> > +	 */
> 
> Two places to call update_idle_cfs_rq_clock_pelt():
> 
> 1 dequeue_entity()
>     (no pending update before. and this is fast path)
>     update_idle_cfs_rq_clock_pelt
> 
> 2 update_blocked_averages()
>     update_clock_rq() -> pending update here.
>     __update_blocked_fair()
>       update_idle_cfs_rq_clock_pelt
> 
> Another way will be to move the smp_wmb() to _update_idle_rq_clock_pelt()
> 
> static inline void _update_idle_rq_clock_pelt(struct rq *rq)
> {
> 	rq->clock_pelt  = rq_clock_task(rq);
> 
> 	u64_u32_store(rq->enter_idle, rq_clock(rq));
> 	u64_u32_store(rq->clock_pelt_idle, rq_clock_pelt(rq));
>     smp_wmb();
> }
> 
> But does this function called more often enough than dequeue_entity(), 
> 
> pick_next_task_fair()
>   (rq will be idle)
>   update_idle_rq_clock_pelt()
> 
> update_rq_clock_pelt()
>   (curr is idle)
>   _update_idle_rq_clock_pelt()
> 
> The condition is they are all idle.
> And the migrate_se_pelt_lag() is for idle also.
> 
> If smp_wmb() is here like the patch, smp_rmb() place in 
> migrate_se_pelt_lag() here:
>   
> #ifdef CONFIG_CFS_BANDWIDTH
> 	throttled = u64_u32_load(cfs_rq->throttled_pelt_idle);
>     smp_rmb();
> 	/* The clock has been stopped for throttling */
> 	if (throttled == U64_MAX)
> 		return;
> #endif
> 
> If smp_wmb() is in _update_idle_rq_clock_pelt(), smp_rmb() place in
> migrate_se_pelt_lag() here:
> 
> #ifdef CONFIG_CFS_BANDWIDTH
> 	throttled = u64_u32_load(cfs_rq->throttled_pelt_idle);
> 	/* The clock has been stopped for throttling */
> 	if (throttled == U64_MAX)
> 		return;
> #endif
>     smp_rmb();
> 	now = u64_u32_load(rq->clock_pelt_idle);
> 	now -= throttled;
> 
> Sorry for these noise words.

I thought a bit more on this and the memory barrier should be put as below.
This will ensure that we will not over estimate the lag but only under estimate
it if an update happens in the middle of the computation of the lag.


---
 kernel/sched/fair.c | 18 +++++++++++++-----
 kernel/sched/pelt.h | 11 +++++------
 2 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ce94df5a6df6..1aeca8d518a2 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3705,7 +3705,7 @@ static inline void add_tg_cfs_propagate(struct cfs_rq *cfs_rq, long runnable_sum
 #ifdef CONFIG_NO_HZ_COMMON
 static inline void migrate_se_pelt_lag(struct sched_entity *se)
 {
-	u64 throttled = 0, now;
+	u64 throttled = 0, now, lut;
 	struct cfs_rq *cfs_rq;
 	struct rq *rq;
 	bool is_idle;
@@ -3761,13 +3761,21 @@ static inline void migrate_se_pelt_lag(struct sched_entity *se)
 		return;
 #endif
 	now = u64_u32_load(rq->clock_pelt_idle);
+	smp_rmb();
 	now -= throttled;
 
-	/* An update happened while computing lag */
-	if (now < cfs_rq_last_update_time(cfs_rq))
-		return;
+	lut = cfs_rq_last_update_time(cfs_rq);
 
-	now += sched_clock_cpu(cpu_of(rq)) - u64_u32_load(rq->enter_idle);
+	if (now < lut)
+		/*
+		 * cfs_rq->avg.last_update_time is more recent than our
+		 * estimation which means that an update happened while
+		 * computing the lag. LUT is the most up to date value so use
+		 * it instead of trying to estimate what it should be
+		 */
+		now = lut;
+	else
+		now += sched_clock_cpu(cpu_of(rq)) - u64_u32_load(rq->enter_idle);
 
 	__update_load_avg_blocked_se(now, se);
 }
diff --git a/kernel/sched/pelt.h b/kernel/sched/pelt.h
index 9aed92262bd9..330d582efafe 100644
--- a/kernel/sched/pelt.h
+++ b/kernel/sched/pelt.h
@@ -75,6 +75,11 @@ static inline void _update_idle_rq_clock_pelt(struct rq *rq)
 	rq->clock_pelt  = rq_clock_task(rq);
 
 	u64_u32_store(rq->enter_idle, rq_clock(rq));
+	/*
+	 * Make sure that pending update of rq->enter_idle is visible before
+	 * rq->clock_pelt_idle so we will never overestimate the lag.
+	 */
+	smp_wmb();
 	u64_u32_store(rq->clock_pelt_idle, rq_clock_pelt(rq));
 }
 
@@ -153,12 +158,6 @@ static inline void update_idle_rq_clock_pelt(struct rq *rq)
 #ifdef CONFIG_CFS_BANDWIDTH
 static inline void update_idle_cfs_rq_clock_pelt(struct cfs_rq *cfs_rq)
 {
-	/*
-	 * Make sure that pending update of rq->clock_pelt_idle and
-	 * rq->enter_idle are visible during update_blocked_average() before
-	 * updating cfs_rq->throttled_pelt_idle.
-	 */
-	smp_wmb();
 	if (unlikely(cfs_rq->throttle_count))
 		u64_u32_store(cfs_rq->throttled_pelt_idle, U64_MAX);
 	else
-- 
2.17.1



> > +	smp_wmb();
> > +	if (unlikely(cfs_rq->throttle_count))
> > +		u64_u32_store(cfs_rq->throttled_pelt_idle, U64_MAX);
> > +	else
> > +		u64_u32_store(cfs_rq->throttled_pelt_idle,
> > +			      cfs_rq->throttled_clock_pelt_time);
> >  }
> >  
> > -#ifdef CONFIG_CFS_BANDWIDTH
> >  /* rq->task_clock normalized against any time this cfs_rq has spent throttled */
> >  static inline u64 cfs_rq_clock_pelt(struct cfs_rq *cfs_rq)
> >  {
> > @@ -150,6 +175,7 @@ static inline u64 cfs_rq_clock_pelt(struct cfs_rq *cfs_rq)
> >  	return rq_clock_pelt(rq_of(cfs_rq)) - cfs_rq->throttled_clock_pelt_time;
> >  }
> >  #else
> > +static inline void update_idle_cfs_rq_clock_pelt(struct cfs_rq *cfs_rq) { }
> >  static inline u64 cfs_rq_clock_pelt(struct cfs_rq *cfs_rq)
> >  {
> >  	return rq_clock_pelt(rq_of(cfs_rq));
> > @@ -204,6 +230,7 @@ update_rq_clock_pelt(struct rq *rq, s64 delta) { }
> >  static inline void
> >  update_idle_rq_clock_pelt(struct rq *rq) { }
> >  
> > +static inline void update_idle_cfs_rq_clock_pelt(struct cfs_rq *cfs_rq) { }
> >  #endif
> >  
> >  
> > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > index e2cf6e48b165..ea9365e1a24e 100644
> > --- a/kernel/sched/sched.h
> > +++ b/kernel/sched/sched.h
> > @@ -641,6 +641,10 @@ struct cfs_rq {
> >  	int			runtime_enabled;
> >  	s64			runtime_remaining;
> >  
> > +	u64			throttled_pelt_idle;
> > +#ifndef CONFIG_64BIT
> > +	u64                     throttled_pelt_idle_copy;
> > +#endif
> >  	u64			throttled_clock;
> >  	u64			throttled_clock_pelt;
> >  	u64			throttled_clock_pelt_time;
> > @@ -1013,6 +1017,12 @@ struct rq {
> >  	u64			clock_task ____cacheline_aligned;
> >  	u64			clock_pelt;
> >  	unsigned long		lost_idle_time;
> > +	u64			clock_pelt_idle;
> > +	u64			enter_idle;
> > +#ifndef CONFIG_64BIT
> > +	u64			clock_pelt_idle_copy;
> > +	u64			enter_idle_copy;
> > +#endif
> >  
> >  	atomic_t		nr_iowait;
> >  
> > -- 
> > 2.25.1
