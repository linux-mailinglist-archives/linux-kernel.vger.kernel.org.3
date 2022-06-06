Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 950E653EC11
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233041AbiFFJb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 05:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233046AbiFFJbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 05:31:24 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8585156443
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 02:31:22 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id p10so19027728wrg.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 02:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8FFuelqdflTE0MJzrMLZRwe95WZO1bU5dyLDKC24R/g=;
        b=l/LxjbvsOUhl5bFOqfpJGV+N7zzHUGoru+sU3F68msDMG4gD02ztB8RbM6RAayDTS8
         iidT5+v/IDnsu4zRzqtisQtta3HdaaT3gG5o3/z0+EYWtN84GwKANc35u9L7K54aqlcp
         ZmgLzpbHMX7oZIpzw/t0KLAcx6PM5ce18dwL9YRN56+wOWrJNibXIimUWzkuI0F4NUYg
         /sJ9GoMAs4OrwuS0AkEOLbMM9DQILzWBjL4V312jg06PQnVhhh2/m3x/852wRe0gw5te
         kAa9kuvFecCTgYm/fHwWrjpkGumnHmetXIBQ6NeJhtFG7Rj4zXXUIbxbWdGxdth5jvdy
         VHjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8FFuelqdflTE0MJzrMLZRwe95WZO1bU5dyLDKC24R/g=;
        b=oHr35tEZEG5jmS2PNFL93hxvMkt/HSjTMwYq+XP3djCjaJJuT0uahiLo9cWOSrMram
         BLlkK2/KAFeF4udGabQGXu2yhaq1tmjy/77sBjA0s5GR1QSwzXvzgx0cvFBz2ma4IZXF
         VkFo3FAXoA7k+PLuHGS1hfpPNlNc9yKdPg+OYJXFK2HLfisn7jL50G1JVgsv2tl5x4z0
         fKJb96o7sdvQFNOrWp4yva44D5Mr1+ekhZaMCIJ4H/wrtVDdAc8UzK2dpw7fCwDqkl2n
         bNae+WXY5eYAb+RExE2d+oFxmgS9eTKq99waJvOwEp+zzBfgMcxMOEGaFx0xYkFUQtEG
         YTvw==
X-Gm-Message-State: AOAM533WMOJJzNLFicBXCNvzoWOTDwSjIM36+OuLSP47ZFy0i4cLAQ9w
        uzZozuvT6UBxhk2tDuV12JDbf6cn5RhL/uN/
X-Google-Smtp-Source: ABdhPJyAsnZFZgWa2G73FZxd9TdV2gvDTaU8LMGawz6RAQIbnw3Ak5YfGZJ4PxjjbfWCqNtGhn5tuw==
X-Received: by 2002:adf:fe52:0:b0:210:12ab:76e6 with SMTP id m18-20020adffe52000000b0021012ab76e6mr21006406wrs.120.1654507881102;
        Mon, 06 Jun 2022 02:31:21 -0700 (PDT)
Received: from google.com (109.36.187.35.bc.googleusercontent.com. [35.187.36.109])
        by smtp.gmail.com with ESMTPSA id x4-20020adfffc4000000b0021018642ff8sm14763440wrs.76.2022.06.06.02.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 02:31:20 -0700 (PDT)
Date:   Mon, 6 Jun 2022 10:31:16 +0100
From:   Vincent Donnefort <vdonnefort@google.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, morten.rasmussen@arm.com,
        chris.redpath@arm.com, qperret@google.com, tao.zhou@linux.dev,
        kernel-team@android.com
Subject: Re: [PATCH v9 2/7] sched/fair: Decay task PELT values during wakeup
 migration
Message-ID: <Yp3JZIokwFxT+X6M@google.com>
References: <20220523155140.2878563-1-vdonnefort@google.com>
 <20220523155140.2878563-3-vdonnefort@google.com>
 <72bd6945-c167-65ba-6f81-fad2768972dc@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72bd6945-c167-65ba-6f81-fad2768972dc@arm.com>
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

[...]
> > @@ -8114,6 +8212,10 @@ static bool __update_blocked_fair(struct rq *rq, bool *done)
> >  		if (update_cfs_rq_load_avg(cfs_rq_clock_pelt(cfs_rq), cfs_rq)) {
> >  			update_tg_load_avg(cfs_rq);
> >  
> > +			/* sync clock_pelt_idle with last update */
> 
> update_idle_cfs_rq_clock_pelt() syncs cfs_rq->throttled_pelt_idle with
> cfs_rq->throttled_clock_pelt_time. Not sure what `clock_pelt_idle` and
> `last update` here mean?


Indeed, this comment is not helpful at all. What matters here is that the cfs_rq
is idle and we need to update the throttled_pelt_idle accordingly.

> 
> [...]
> 
> > +/* The rq is idle, we can sync to clock_task */
> > +static inline void _update_idle_rq_clock_pelt(struct rq *rq)
> > +{
> > +	rq->clock_pelt  = rq_clock_task(rq);
> > +
> > +	u64_u32_store(rq->enter_idle, rq_clock(rq));
> > +	/* Paired with smp_rmb in migrate_se_pelt_lag */
> 
> minor:
> 
> s/migrate_se_pelt_lag/migrate_se_pelt_lag()
> 
> [...]
> 
> > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > index bf4a0ec98678..97bc26e5c8af 100644
> > --- a/kernel/sched/sched.h
> > +++ b/kernel/sched/sched.h
> > @@ -648,6 +648,10 @@ struct cfs_rq {
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
> > @@ -1020,6 +1024,12 @@ struct rq {
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
> 
> `throttled_pelt_idle`, `clock_pelt_idle` and `enter_idle` are clock
> snapshots when cfs_rq resp. rq go idle. But the naming does not really
> show this relation. And this makes reading those equations rather difficult.
> 
> What about something like `throttled_clock_pelt_time_enter_idle`,
> `clock_pelt_enter_idle`, `clock_enter_idle`? Especially the first one is
> too long but something which shows that those are clock snapshots when
> enter idle would IMHO augment readability in migrate_se_pelt_lag().

What if I drop the "enter"?

 clock_idle;
 clock_pelt_idle;
 throttled_clock_pelt_time_idle;

> 
> Besides these small issues:
> 
> Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

Thanks!
