Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAEEB4842B1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 14:43:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233634AbiADNnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 08:43:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiADNm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 08:42:59 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABBA2C061761
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 05:42:58 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id q8so44957708ljp.9
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 05:42:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P328GzDE331oAl4IkFGvoSoLjEuRs+6xbeCUTZ411oY=;
        b=pPlGOtXaSXtFtb5pvNzFV8BQ2rgA8DyuzLo8BnlRLvSMpbwn6ACqNhNQKl7I2XursU
         N2avKb1jr8uSoq4Az8947Wc8aRHuiPco5lxBsDfNoHjHCjksvWvCFJXw8ZPNkx9Rcoko
         HTcerZR8+0BLhR6pspG89T29e7onStKjcI1tdBfI6r4aV8U8rP7sW76YoaSlJx2s1dql
         ctFQH7rPY4mIr+0i1w6tIQzhbYj/PtJ4xdJPCElnHaONFPFzB60V3HLxTDcmDNBG/Ojl
         NZrKlnRgtc+2LpLika9BHAXauzhCBcXkRuAmOF14aajrg/rMn31ecSOQlNraXSI1U05l
         aLfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P328GzDE331oAl4IkFGvoSoLjEuRs+6xbeCUTZ411oY=;
        b=MgiEI2YyZxR7l/wekUH8Gjs96VLhrb0NxSJStDrXMtyal8jJDaZR7Rs4GnENX/V07x
         oO7lXvt/9Cpc5bSDqC5VfTcBssea1FuE9S/V2D6iwnAGKlLYl6n+6L9rwuK+40L6TBwc
         wyo1oVjIijHmd0bfnjB9E03/YGEbCjA0cvQpVeJrYFTtzVyki9le8MJ3hmLMdMhouWCr
         yUSbrh0TMdJTukA7W3O0/3i4J9yo/f/QF/IU5tFkXHUH74EniAx23y6eFir8cXy0aqqL
         MzJfU0s5X/jmCtBp/c9lI5oMihArcTMfiKl3L41bIHjdhSjAYOWa5wBdXVaINwNup6ry
         7bUw==
X-Gm-Message-State: AOAM533gsXip8PRfqG8ENufuvIY6Hy2+v4tFTr5bzexUuVerpxi45EnL
        nGGJbGOd1OWxlKCjB6izKlAPu3NWarpjow6b3xcDsQ==
X-Google-Smtp-Source: ABdhPJylP16NMrdiPl+9KJyQ2NmNFhZFjZyEUkUXLH5deocynXZs/jp3YDSPnQqqPSykL9Wwuz+FuwkOpc4RAOir9N4=
X-Received: by 2002:a05:651c:612:: with SMTP id k18mr40860937lje.383.1641303776879;
 Tue, 04 Jan 2022 05:42:56 -0800 (PST)
MIME-Version: 1.0
References: <20211222093802.22357-1-vincent.guittot@linaro.org>
 <20211222093802.22357-2-vincent.guittot@linaro.org> <9e526482-905c-e759-8aa6-1ff84bb5b2a3@arm.com>
In-Reply-To: <9e526482-905c-e759-8aa6-1ff84bb5b2a3@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 4 Jan 2022 14:42:45 +0100
Message-ID: <CAKfTPtBR3BWCwEaJe0Cq6K5__zNxfU7FFo2f0bpOPkvzxKdiww@mail.gmail.com>
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

yes

>
> [...]
>
> > +#define MIN_DIVIDER (LOAD_AVG_MAX - 1024)
>
> Shouldn't this be in pelt.h?
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

I have been able to trigger the warning even with (A) though It took
much more time.
And I have been able to catch wrong situations  (with additional
traces) in the 3 places A, B and C

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

IIRC, it was with hikey960 with cgroup v1
As a side note, I never trigger the problem with dragonboard845 and cgroup v2

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

I spent time thinking about adding fixes tag. There is no crash/warn
so far so should we propagate it back in LTS for better performance ?

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

Main reason is that I have never seen the problem.
Then, the problem comes from subtracting task's value whereas here we
always add positive value
