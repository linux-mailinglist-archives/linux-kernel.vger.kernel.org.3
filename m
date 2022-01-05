Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 669B74853E9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 14:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240475AbiAEN6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 08:58:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240470AbiAEN56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 08:57:58 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32CB9C061761
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 05:57:58 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id h7so44727441lfu.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 05:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q8pF2tkMHXrzMZTrOC7iAxy/+sODMzNZLCINoVG646c=;
        b=wqKnLqRj+vbSZk+zGzMgwGA7M4g5ml5adiibcIDI4+L0ScfB541bvcoTHYiHsPDHWV
         mMEp1EhIuImqHr1bT8EpxED6sue5uvVpF6wbDrGiY1cm0zz4KxZnpoBXx/vT5Qvx8+il
         8tGsLl/lFOXEP0zVLklQKDCXqL5gPlVwOqeTmzOCnj6qQGS+dDNw5TAxAUxLDIGBg/Qz
         vbkX5VA+aLHuH0n8blXcYhiQRMH4EhFXd17MBmH2dI9L+vDpeyEvjplcMZVHERJYMLhr
         9eDcEuDLkSXzzjBKhKJj8RYjaa4MJu5bacHHnjVqYLu2+M3vrdTE/urFjR82zU5qksu4
         gC7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q8pF2tkMHXrzMZTrOC7iAxy/+sODMzNZLCINoVG646c=;
        b=vDzf7JdtH8d/b/YVlgQANzbH8cJA5wnff9ES1WuiCVq/jwEZmkc5Wfe/XrNwJxeZop
         38orAms8nhfccRwRnPhbKwm5rqADB8L+e2UsvRqFrqQ+seBvVWiIK4SW8rBbzt+LL6jL
         phi8Cu9w6cxQ9AoRLHGWPR141pXvXkTMv54oV2HXdJn9BuPTVXf8A6HsOX9PdXr0yiih
         z8B1lX4G6huEVzkBmQykDBzfZcC7wyA4XhHoP3nZsX7dacILu2BVAW3i8ypOzfOpqJ1P
         x0Bl7m8pIdtumflL/At1nFtvc4SpWRZl1/GjLH9MHbo2yVBf86luRyZT4S9czJZX2ukj
         aV1Q==
X-Gm-Message-State: AOAM532WgZq8eoj2HSsYXSbP9zUnBzK81Ev9HKcafey/HeCFgYeUBunx
        8kmcJL5pn/X9YFnK4JHAKbnCKsFv4M0rrJZMAW6PTw==
X-Google-Smtp-Source: ABdhPJwF6FxqkTrMl5tNOJiMqWBkxjEYB7VKP1QLdptsLoMtoQBzHLiykU/IarkbuQVP33HWZhaiIRp6wy8TdzoHCGg=
X-Received: by 2002:a05:6512:3d17:: with SMTP id d23mr46346264lfv.523.1641391076394;
 Wed, 05 Jan 2022 05:57:56 -0800 (PST)
MIME-Version: 1.0
References: <20211222093802.22357-1-vincent.guittot@linaro.org>
 <20211222093802.22357-2-vincent.guittot@linaro.org> <9e526482-905c-e759-8aa6-1ff84bb5b2a3@arm.com>
 <CAKfTPtBR3BWCwEaJe0Cq6K5__zNxfU7FFo2f0bpOPkvzxKdiww@mail.gmail.com> <8f39d837-2589-4f7b-5232-1ed134fb1ad7@arm.com>
In-Reply-To: <8f39d837-2589-4f7b-5232-1ed134fb1ad7@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 5 Jan 2022 14:57:45 +0100
Message-ID: <CAKfTPtCVD40GiDEG0pnU+k-nwMAh2PSu_OXq4w3k0A0zR4cLpw@mail.gmail.com>
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

On Wed, 5 Jan 2022 at 14:15, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> On 04/01/2022 14:42, Vincent Guittot wrote:
> > On Tue, 4 Jan 2022 at 12:47, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
> >>
> >> On 22/12/2021 10:38, Vincent Guittot wrote:
>
> [...]
>
> >> I still wonder whether the regression only comes from the changes in
> >> update_cfs_rq_load_avg(), introduced by 1c35b07e6d39.
> >> And could be fixed only by this part of the patch-set (A):
> >
> > I have been able to trigger the warning even with (A) though It took
> > much more time.
> > And I have been able to catch wrong situations  (with additional
> > traces) in the 3 places A, B and C
>
> OK. By wrong situation you mean '_sum < _avg * MIN_DIVIDER' ?

not only.
also util_sum == 0 but util_avg !=0 in different places although these
situation didn't trigger sched_warn because some other sync happened
before the periodic call of __update_blocked_fair
or if nr_running == 1 and  and task's util_avg/sum > cfs' util_avg/sum
just before removing the task

>
> >> @@ -3677,15 +3706,22 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq
> >> *cfs_rq)
> >>
> >>     r = removed_load;
> >>     sub_positive(&sa->load_avg, r);
> >> -   sa->load_sum = sa->load_avg * divider;
> >> +   sub_positive(&sa->load_sum, r * divider);
> >> +   sa->load_sum = max_t(u32, sa->load_sum, sa->load_avg * MIN_DIVIDER);
> >>
> >>     r = removed_util;
> >>     sub_positive(&sa->util_avg, r);
> >> -   sa->util_sum = sa->util_avg * divider;
> >> +   sub_positive(&sa->util_sum, r * divider);
> >> +   sa->util_sum = max_t(u32, sa->util_sum, sa->util_avg * MIN_DIVIDER);
> >>
> >>     r = removed_runnable;
> >>     sub_positive(&sa->runnable_avg, r);
> >> -   sa->runnable_sum = sa->runnable_avg * divider;
> >> +   sub_positive(&sa->runnable_sum, r * divider);
> >> +   sa->runnable_sum = max_t(u32, sa->runnable_sum,
> >> +                                 sa->runnable_avg * MIN_DIVIDER);
> >>
> >> i.e. w/o changing update_tg_cfs_X() (and
> >> detach_entity_load_avg()/dequeue_load_avg()).
> >>
> >> update_load_avg()
> >>   update_cfs_rq_load_avg()    <---
> >>   propagate_entity_load_avg()
> >>     update_tg_cfs_X()         <---
> >>
> >>
> >> I didn't see the SCHED_WARN_ON() [cfs_rq_is_decayed()] when looping on
> >> hackbench in several different sched group levels on
> >> [Hikey620 (Arm64, 8 CPUs, SMP, 4 taskgroups: A/B C/D E/F G/H), >12h uptime].
> >
> > IIRC, it was with hikey960 with cgroup v1
> > As a side note, I never trigger the problem with dragonboard845 and cgroup v2
>
> OK, just started a test on hikey960 cgroupv1. Let's see if I can catch it.
>
> [...]
>
> >>> @@ -3780,7 +3799,11 @@ static void detach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
> >>>
> >>>       dequeue_load_avg(cfs_rq, se);
> >>>       sub_positive(&cfs_rq->avg.util_avg, se->avg.util_avg);
> >>> -     cfs_rq->avg.util_sum = cfs_rq->avg.util_avg * divider;
> >>> +     sub_positive(&cfs_rq->avg.util_sum, se->avg.util_sum);
> >>> +     /* See update_tg_cfs_util() */
> >>> +     cfs_rq->avg.util_sum = max_t(u32, cfs_rq->avg.util_sum,
> >>> +                                       cfs_rq->avg.util_avg * MIN_DIVIDER);
> >>> +
> >>
> >> Maybe add a:
> >>
> >> Fixes: fcf6631f3736 ("sched/pelt: Ensure that *_sum is always synced
> >> with *_avg")
> >
> > I spent time thinking about adding fixes tag. There is no crash/warn
> > so far so should we propagate it back in LTS for better performance ?
>
> Not sure I understand. What do you mean by 'should we propagate it back
> in LTS'?

Sorry I had any stables in mind and not only LTS.

Some of the changes done in PELT signal propagation that replace
subtracting util_sum  by using util_avg * divider instead, are related
to other problems with sched group hierarchy and
throttling/unthrottling. I'm not 100% confident that using fixes tag
to backport this on stables doesn't need to backport more patches on
other areas in order to not resurrect old problems. So I wonder if
it's worth  backporting this on stables

>
> [...]
>
> >> This max_t() should make sure that `_sum is always >= _avg *
> >> MIN_DIVIDER`. Which is not the case sometimes. Currently this is done in
> >>
> >> (1) update_cfs_rq_load_avg()
> >> (2) detach_entity_load_avg() and dequeue_load_avg()
> >> (3) update_tg_cfs_X()
> >>
> >> but not in attach_entity_load_avg(), enqueue_load_avg(). What's the
> >> reason for this?
> >
> > Main reason is that I have never seen the problem.
> > Then, the problem comes from subtracting task's value whereas here we
> > always add positive value
>
> OK, I see. The add_positive()'s in update_tg_cfs_X() deal w/ `long` values.
