Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75CCA48C7D3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 17:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354934AbiALQFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 11:05:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354942AbiALQFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 11:05:10 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88AB6C061759
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 08:05:09 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id o15so9706855lfo.11
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 08:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qkk97kiXQqzrGBcQJYaVxB/UXpa6dnPkR941yAd4Qyc=;
        b=Yy/hfYB+WHR1iGCb7/+27pCO4bwhk7+oKZZ62ioR7UZaTJZ9Oap6+iNOi0W36NxstC
         mUqKU3NqFMQ1tZ5ZoJtHLWVWKkMDhXZPb6SDCV8nUudrndfaK1taOFFu+tCkhVI6wEv2
         0V1emCaIOFnckqeK+gtCsI8G7M0o6SNfM+Zu34/bJWVPVC+seTmtdRBOJzB+NvnqW6iu
         a+xJQL27jKpCSiDgL5BiogLGomnJQoopNR2Ojv75Uv4Au+xdo5ieu4mPROJrgGeH+1Zi
         c2azu93GfvEs0gxXgRJI+umWav8BLnPSsZmFbGAvicvG0DDgwxWx9dh3Cs49zfKo8Dur
         iSjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qkk97kiXQqzrGBcQJYaVxB/UXpa6dnPkR941yAd4Qyc=;
        b=bIcZy+zq8rOj24qdb5QkEJ8keVO3r4m3JNAFF60L2MzhYbR+HmFMhw/Uj5vTQo/guq
         352yt6khygs1y6dJes0O9MzbHLK0kZb9VEKBMcY9pg3hta2cM2whQoANxoeQ89YLC7O6
         e5GB+3K+GRpPSu0MBx77jfK+UMBsvtDP86aQAmDVFmLYLuowpQ6l/BTHIYw1z4Br4jIM
         eDAw8i6JLy7EmQda9uEORcZsCPsOStqTm35C1yNwNa+piXRKW++yuUutA8jTug1cWAjG
         Q4G5yP2sae1H25ULD+QFwnYTGZpYueWSM5zuwHIwtvUGvaKktl9tv5kXUqIiNayEurMm
         UdRA==
X-Gm-Message-State: AOAM531yR554yCIrDF/LsTvWPsAp+RWBWoIFe6l4SiOk1/cHkIxcXEgj
        TVH3+BVAy0tTccjtD6icSyM/xmTLec7wssKEYoMHmg==
X-Google-Smtp-Source: ABdhPJxn2sXBkzOwW9ifPY1bn1qeGAiDmGQJ9+no3ZenAzbvJ0qVudx4/VJPnIlquoKROUu+xjHo0AHOlfVKGHw0SZw=
X-Received: by 2002:a2e:bc17:: with SMTP id b23mr126162ljf.365.1642003507837;
 Wed, 12 Jan 2022 08:05:07 -0800 (PST)
MIME-Version: 1.0
References: <20220111134659.24961-1-vincent.guittot@linaro.org>
 <20220111134659.24961-2-vincent.guittot@linaro.org> <1e64dac6-7724-f3f8-978e-fc70dbcc0ae3@arm.com>
In-Reply-To: <1e64dac6-7724-f3f8-978e-fc70dbcc0ae3@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 12 Jan 2022 17:04:56 +0100
Message-ID: <CAKfTPtD0547r118KfpdSSiQPh5r9K_KWGshC1+U2y7czo8c=dA@mail.gmail.com>
Subject: Re: [PATCH 3 1/4] sched/pelt: Relax the sync of util_sum with util_avg
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

On Wed, 12 Jan 2022 at 16:26, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> On 11/01/2022 14:46, Vincent Guittot wrote:
> > Rick reported performance regressions in bugzilla because of cpu frequency
> > being lower than before:
> >     https://bugzilla.kernel.org/show_bug.cgi?id=215045
> >
> > He bisected the problem to:
> > commit 1c35b07e6d39 ("sched/fair: Ensure _sum and _avg values stay consistent")
> >
> > This commit forces util_sum to be synced with the new util_avg after
> > removing the contribution of a task and before the next periodic sync. By
> > doing so util_sum is rounded to its lower bound and might lost up to
> > LOAD_AVG_MAX-1 of accumulated contribution which has not yet been
> > reflected in util_avg.
> >
> > Instead of always setting util_sum to the low bound of util_avg, which can
> > significantly lower the utilization of root cfs_rq after propagating the
> > change down into the hierarchy, we revert the change of util_sum and
> > propagate the difference.
>
> IMHO, this paragraph does not match the changes in this patch.



>
> > In addition, we also check that cfs's util_sum always stays above the
> > lower bound for a given util_avg as it has been observed that
> > sched_entity's util_sum is sometimes above cfs one.
>
> And I guess this one also refers to the code change in 2/4, i.e. in
> update_tg_cfs_util().

The 3 places can have the problem although it's probably more obvious
in detach_entity_load_avg or update_tg_cfs_util because this is done
synchronously unlike here

> > Reported-by: Rick Yiu <rickyiu@google.com>
> > Fixes: 1c35b07e6d39 ("sched/fair: Ensure _sum and _avg values stay consistent")
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >  kernel/sched/fair.c | 16 ++++++++++++++--
> >  1 file changed, 14 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 095b0aa378df..ed35255fdb85 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -3381,6 +3381,7 @@ void set_task_rq_fair(struct sched_entity *se,
> >       se->avg.last_update_time = n_last_update_time;
> >  }
> >
> > +#define MIN_DIVIDER (LOAD_AVG_MAX - 1024)
> >
> >  /*
> >   * When on migration a sched_entity joins/leaves the PELT hierarchy, we need to
> > @@ -3449,7 +3450,6 @@ void set_task_rq_fair(struct sched_entity *se,
> >   * XXX: only do this for the part of runnable > running ?
> >   *
> >   */
> > -
> >  static inline void
> >  update_tg_cfs_util(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cfs_rq *gcfs_rq)
> >  {
> > @@ -3681,7 +3681,19 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
> >
> >               r = removed_util;
> >               sub_positive(&sa->util_avg, r);
> > -             sa->util_sum = sa->util_avg * divider;
> > +             sub_positive(&sa->util_sum, r * divider);
> > +             /*
> > +              * Because of rounding, se->util_sum might ends up being +1 more than
>
> There are no se's involved in update_cfs_rq_load_avg(). Could be hard to
> grasp for people only looking at this function.

I moved the comment there to stay in patch 1 but it reflects the whole
problem of rounding when removing some util_avg/sum from a cfs whereas
we only have part of the problem in update_cfs_rq_load_avg()

>
> > +              * cfs->util_sum. Although this is not a problem by itself, detaching
> > +              * a lot of tasks with the rounding problem between 2 updates of
> > +              * util_avg (~1ms) can make cfs->util_sum becoming null whereas
> > +              * cfs_util_avg is not.
> > +              * Check that util_sum is still above its lower bound for the new
> > +              * util_avg. Given that period_contrib might have moved since the last
> > +              * sync, we are only sure that util_sum must be above or equal to
> > +              *    util_avg * minimum possible divider
>                    ^^^
> some superfluous whitepaces.
>
> > +              */
> > +             sa->util_sum = max_t(u32, sa->util_sum, sa->util_avg * MIN_DIVIDER);
> >
> >               r = removed_runnable;
> >               sub_positive(&sa->runnable_avg, r);
> >
>
