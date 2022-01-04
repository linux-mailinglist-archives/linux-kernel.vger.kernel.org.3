Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1139B4842C2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 14:48:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233797AbiADNsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 08:48:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232396AbiADNsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 08:48:15 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617EAC061761
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 05:48:15 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id v15so60963994ljc.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 05:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/QI617JV8HrQwoDhzfwapgkFs0oiBH9+yGBicdUDbiQ=;
        b=YK26rRtWCs/hi7Bmh9+UWLjp5DStQjNoOHAxNkQ5rx/y85kY6HjjSBEJPNghqMZZuL
         balLCNodVqPyltCre8Tflp9OarVrPGb4otmyqN2WRwdHg9faSnUwEp09EU8zt8yfR1mZ
         vfM4Ux6j2P3auMj4LVeKAxN9YafksyZw7N3uWrHL/6tr/kB/AIXxsY3pn/6UC5GeJYwC
         hW/TcQweNLh2DEIhOZuMj01DWcCyKkiVNGq+YnefH3nm3woEsonyeR4G6OZ59CrHeSGk
         ge0LDNQ7X9noLgZbNI7yjJeXND2TGN6XN1fNVzno6zFRMr/09rh7pYEjsOY3h/C7dzll
         DLtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/QI617JV8HrQwoDhzfwapgkFs0oiBH9+yGBicdUDbiQ=;
        b=8L68A3euu4/UqvldPgyVCaFrNnkJLfB2GlJidFXp9IjYQiDxO1FdgzQLv2APBTU8+x
         yAfKZOPu+wcAhjZmsjNkBFZL1QEUN+uwUaCgtBITY7TKKljKco0jaKuNv5zyQzLK3Ino
         78Du0CKa5pMqrKsHWOq3qha1iL5aGmL2seGedQDLA6yfjnOob4qJnU876pFhSlJ6eLMp
         iFtnsL/kSHbhtSFTrdg3+YGlMiJ9fcOpjFTDT2uF8XCNDrTqHFDCla0k342b2nCDBjZ7
         Jkxn6kHH4tXrJTur+yxbmDmmLqx80JxAFX7xM+T6qKjSlLrc4Pn404ITeK+aG2eNUYjO
         GDjw==
X-Gm-Message-State: AOAM5328uvmVarY/6Zes7DuCAI61bM+Ee1rGwb++VkU+IiLLQIWbizH2
        rxB+nQ3Jhq4dMWGs2uk7IQbqpb5P5gqovuyXd+WD4g==
X-Google-Smtp-Source: ABdhPJzFa3EX2g4Hz5fA++dAN4Tk7eBMxpr+mG2J+ZX6qI1jxZMT8hqnt3bRI2UQVEMDTTZqPtvLnRPWQPp/31vdXZI=
X-Received: by 2002:a05:651c:1a1f:: with SMTP id by31mr32305889ljb.266.1641304093609;
 Tue, 04 Jan 2022 05:48:13 -0800 (PST)
MIME-Version: 1.0
References: <20211222093802.22357-1-vincent.guittot@linaro.org>
 <20211222093802.22357-2-vincent.guittot@linaro.org> <9e526482-905c-e759-8aa6-1ff84bb5b2a3@arm.com>
In-Reply-To: <9e526482-905c-e759-8aa6-1ff84bb5b2a3@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 4 Jan 2022 14:48:02 +0100
Message-ID: <CAKfTPtCpRHDKSwn2qEja=p-W_5YiYYJxAtA5fn2V33ZMUuB0Mw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] sched/pelt: Don't sync hardly util_sum with uti_avg
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        rickyiu@google.com, odin@uged.al, sachinp@linux.vnet.ibm.com,
        naresh.kamboju@linaro.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jan 2022 at 12:47, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> On 22/12/2021 10:38, Vincent Guittot wrote:
>
> s/util_sum with uti_avg/util_sum with util_avg
>
> [...]
>
> > +#define MIN_DIVIDER (LOAD_AVG_MAX - 1024)
>
> Shouldn't this be in pelt.h?

It is only used in fair.c so I kept it local like some other defines in fair.c


>
> [...]
>
> > @@ -3466,13 +3466,30 @@ update_tg_cfs_util(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cfs_rq
> >        */
> >       divider = get_pelt_divider(&cfs_rq->avg);
> >
> > +
> >       /* Set new sched_entity's utilization */
> >       se->avg.util_avg = gcfs_rq->avg.util_avg;
> > -     se->avg.util_sum = se->avg.util_avg * divider;
> > +     new_sum = se->avg.util_avg * divider;
> > +     delta_sum = (long)new_sum - (long)se->avg.util_sum;
> > +     se->avg.util_sum = new_sum;
> >
> >       /* Update parent cfs_rq utilization */
> > -     add_positive(&cfs_rq->avg.util_avg, delta);
> > -     cfs_rq->avg.util_sum = cfs_rq->avg.util_avg * divider;
> > +     add_positive(&cfs_rq->avg.util_avg, delta_avg);
> > +     add_positive(&cfs_rq->avg.util_sum, delta_sum);
> > +
> > +     /*
> > +      * Because of rounding, se->util_sum might ends up being +1 more than
> > +      * cfs->util_sum (XXX fix the rounding). Although this is not
> > +      * a problem by itself, detaching a lot of tasks with the rounding
> > +      * problem between 2 updates of util_avg (~1ms) can make cfs->util_sum
> > +      * becoming null whereas cfs_util_avg is not.
> > +      * Check that util_sum is still above its lower bound for the new
> > +      * util_avg. Given that period_contrib might have moved since the last
> > +      * sync, we are only sure that util_sum must be above or equal to
> > +      *    util_avg * minimum possible divider
> > +      */
> > +     cfs_rq->avg.util_sum = max_t(u32, cfs_rq->avg.util_sum,
> > +                                       cfs_rq->avg.util_avg * MIN_DIVIDER);
> >  }
> >
>
> I still wonder whether the regression only comes from the changes in
> update_cfs_rq_load_avg(), introduced by 1c35b07e6d39.
> And could be fixed only by this part of the patch-set (A):
>
> @@ -3677,15 +3706,22 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq
> *cfs_rq)
>
>     r = removed_load;
>     sub_positive(&sa->load_avg, r);
> -   sa->load_sum = sa->load_avg * divider;
> +   sub_positive(&sa->load_sum, r * divider);
> +   sa->load_sum = max_t(u32, sa->load_sum, sa->load_avg * MIN_DIVIDER);
>
>     r = removed_util;
>     sub_positive(&sa->util_avg, r);
> -   sa->util_sum = sa->util_avg * divider;
> +   sub_positive(&sa->util_sum, r * divider);
> +   sa->util_sum = max_t(u32, sa->util_sum, sa->util_avg * MIN_DIVIDER);
>
>     r = removed_runnable;
>     sub_positive(&sa->runnable_avg, r);
> -   sa->runnable_sum = sa->runnable_avg * divider;
> +   sub_positive(&sa->runnable_sum, r * divider);
> +   sa->runnable_sum = max_t(u32, sa->runnable_sum,
> +                                 sa->runnable_avg * MIN_DIVIDER);
>
> i.e. w/o changing update_tg_cfs_X() (and
> detach_entity_load_avg()/dequeue_load_avg()).
>
> update_load_avg()
>   update_cfs_rq_load_avg()    <---
>   propagate_entity_load_avg()
>     update_tg_cfs_X()         <---
>
>
> I didn't see the SCHED_WARN_ON() [cfs_rq_is_decayed()] when looping on
> hackbench in several different sched group levels on
> [Hikey620 (Arm64, 8 CPUs, SMP, 4 taskgroups: A/B C/D E/F G/H), >12h uptime].
>
> Rick is probably in a position to test whether this would be sufficient
> to cure the CPU frequency regression.
>
> I can see that you want to use the same _avg/_sum sync in
> detach_entity_load_avg()/dequeue_load_avg() as in
> update_cfs_rq_load_avg(). (B)
>
> And finally in update_tg_cfs_X() as well plus down-propagating _sum
> independently from _avg. (C)
>
> So rather splitting the patchset into X (util, runnable, load) the whole
> change might be easier to handle IMHO when split into (A), (B), (C)
> (obviously only in case (A) cures the regression).
>
> >  static inline void
> > @@ -3681,7 +3698,9 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
> >
> >               r = removed_util;
> >               sub_positive(&sa->util_avg, r);
> > -             sa->util_sum = sa->util_avg * divider;
> > +             sub_positive(&sa->util_sum, r * divider);
> > +             /* See update_tg_cfs_util() */
> > +             sa->util_sum = max_t(u32, sa->util_sum, sa->util_avg * MIN_DIVIDER);
> >
> >               r = removed_runnable;
> >               sub_positive(&sa->runnable_avg, r);
> > @@ -3780,7 +3799,11 @@ static void detach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
> >
> >       dequeue_load_avg(cfs_rq, se);
> >       sub_positive(&cfs_rq->avg.util_avg, se->avg.util_avg);
> > -     cfs_rq->avg.util_sum = cfs_rq->avg.util_avg * divider;
> > +     sub_positive(&cfs_rq->avg.util_sum, se->avg.util_sum);
> > +     /* See update_tg_cfs_util() */
> > +     cfs_rq->avg.util_sum = max_t(u32, cfs_rq->avg.util_sum,
> > +                                       cfs_rq->avg.util_avg * MIN_DIVIDER);
> > +
>
> Maybe add a:
>
> Fixes: fcf6631f3736 ("sched/pelt: Ensure that *_sum is always synced
> with *_avg")
>
> [...]
>
> This max_t() should make sure that `_sum is always >= _avg *
> MIN_DIVIDER`. Which is not the case sometimes. Currently this is done in
>
> (1) update_cfs_rq_load_avg()
> (2) detach_entity_load_avg() and dequeue_load_avg()
> (3) update_tg_cfs_X()
>
> but not in attach_entity_load_avg(), enqueue_load_avg(). What's the
> reason for this?
