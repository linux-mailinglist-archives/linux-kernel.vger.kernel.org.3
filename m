Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D767947B41B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 20:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233299AbhLTT6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 14:58:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234102AbhLTT6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 14:58:50 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FFD5C061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 11:58:50 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id d10so32152813ybe.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 11:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9lDdg+MUWH6RIaXbhbBHcadu/VOGGuYgmaFf6YkYH2Q=;
        b=eMvVq35drMk8sk2dkSowFPRdBDicG95euCGgm7DAonJxf+ofRXeRuDR2cb40/LWiuA
         1kaphwTNameVPDRMN3t6ORd2Pgf5oSp2MwFY32oWvqDe0TIWR1byGrWOqWtL5d3ipt/h
         rp+uMFVK/YnuwRBHWA0qWpkeolVET3vw9OGJgzKKtIxlyoeEJjPgZieOjY7NMHwNNVwt
         Pbs0gpvz0CAIafq4Ah67fkVSPp70jHRtLAvaGfTgnmURpaCDkTXKMePqwgPx8m1zQ3qe
         61F7+NlWvAz8C8A5uxxvxUmQxZYHdIng4uICkrIlFneTFL9WDsqFvFyV3DZjIB4P/Omh
         gytg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9lDdg+MUWH6RIaXbhbBHcadu/VOGGuYgmaFf6YkYH2Q=;
        b=3QdLbU1IMlMzk8dpNLC70XgQWaSyVURh3ZaYoqiGqLs/+irtmHG5YflHT3LWcDgU0+
         1jrBu8/JWMCh5YauGubt9fDks1P2JLlLHWBYqjQmdyXSgnCXzK/+GR4vf8NF1JzR6lUN
         Zrrv93niqjx2S9vTyjpL136X1QiM2hQ0vz3kfmioHrcFE8VUQw9Hd+o713P73Vbk7Bhk
         OtbSS5sSErwOwOAykciNmtDHmY5UN9WsNlAs6ekToPiUQE+NsyzDbTlgKwsry2yXFYDZ
         vxj+PdcyqPoF0aWULwc9gDORJGKBN0cAKrwj+wAbWg2Ew7XHGXgSP2VGep9Z9bATW1on
         BYqQ==
X-Gm-Message-State: AOAM532oOsXSiL+jFE1sA5e6rQ4TFvlyOaJz+5Iv61fHTMxoYK9Umtyt
        0chL2tY8xzHPSU1MLJSyd9yZXOIAWf/7TTglA3mlxQ==
X-Google-Smtp-Source: ABdhPJyfeFtLMyeNs1xYvK67zNRo6BTDnF2e8rJqc+2MvbKjgNvR9PCFuyWX7fukFlnsXRA9KWlpUpBT+ENQ6X1OqTg=
X-Received: by 2002:a25:d186:: with SMTP id i128mr10844633ybg.602.1640030329168;
 Mon, 20 Dec 2021 11:58:49 -0800 (PST)
MIME-Version: 1.0
References: <1639721264-12294-1-git-send-email-huangzhaoyang@gmail.com> <CAGWkznGdvLobshPvg2KY+D71Zh0625+V=WsAS9uExRspRFFjVQ@mail.gmail.com>
In-Reply-To: <CAGWkznGdvLobshPvg2KY+D71Zh0625+V=WsAS9uExRspRFFjVQ@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 20 Dec 2021 11:58:38 -0800
Message-ID: <CAJuCfpF9tJupcyWVeDHyEBnQqTZTnoyKVcKLqB1wWXyks6Z0Cw@mail.gmail.com>
Subject: Re: [PATCH] psi: fix possible trigger missing in the window
To:     Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 10:03 PM Zhaoyang Huang <huangzhaoyang@gmail.com> wrote:
>
> loop Suren

Thanks.


>
> On Fri, Dec 17, 2021 at 2:08 PM Huangzhaoyang <huangzhaoyang@gmail.com> wrote:
> >
> > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> >
> > There could be missing wake up if the rest of the window remain the
> > same stall states as the polling_total updates for every polling_min_period.

Could you please expand on this description? I'm unclear what the
problem is. I assume "polling_min_period" in this description refers
to the group->poll_min_period.

From the code, looks like the change results in update_triggers()
calling window_update() once there was a new stall recorded for the
trigger state and until the tracking window is complete. I don't see
the point of calling window_update() if there was no stall change
since the last call to window_update(). The resulting growth will not
increase if there is no new stall.
Maybe what you want to achieve here is more than one trigger per
window if the stall limit was breached? If so, then this goes against
the design for psi triggers in which we want to rate-limit the number
of generated triggers per tracking window (see:
https://elixir.bootlin.com/linux/latest/source/kernel/sched/psi.c#L545).
Please clarify the issue and the intentions here.
Thanks!

> >
> > Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > ---
> >  include/linux/psi_types.h |  2 ++
> >  kernel/sched/psi.c        | 30 ++++++++++++++++++------------
> >  2 files changed, 20 insertions(+), 12 deletions(-)
> >
> > diff --git a/include/linux/psi_types.h b/include/linux/psi_types.h
> > index 0a23300..9533d2e 100644
> > --- a/include/linux/psi_types.h
> > +++ b/include/linux/psi_types.h
> > @@ -132,6 +132,8 @@ struct psi_trigger {
> >
> >         /* Refcounting to prevent premature destruction */
> >         struct kref refcount;
> > +
> > +       bool new_stall;
> >  };
> >
> >  struct psi_group {
> > diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> > index 1652f2b..402718c 100644
> > --- a/kernel/sched/psi.c
> > +++ b/kernel/sched/psi.c
> > @@ -458,9 +458,12 @@ static void psi_avgs_work(struct work_struct *work)
> >  static void window_reset(struct psi_window *win, u64 now, u64 value,
> >                          u64 prev_growth)
> >  {
> > +       struct psi_trigger *t = container_of(win, struct psi_trigger, win);
> > +
> >         win->start_time = now;
> >         win->start_value = value;
> >         win->prev_growth = prev_growth;
> > +       t->new_stall = false;
> >  }
> >
> >  /*
> > @@ -515,7 +518,6 @@ static void init_triggers(struct psi_group *group, u64 now)
> >  static u64 update_triggers(struct psi_group *group, u64 now)
> >  {
> >         struct psi_trigger *t;
> > -       bool new_stall = false;
> >         u64 *total = group->total[PSI_POLL];
> >
> >         /*
> > @@ -523,19 +525,26 @@ static u64 update_triggers(struct psi_group *group, u64 now)
> >          * watchers know when their specified thresholds are exceeded.
> >          */
> >         list_for_each_entry(t, &group->triggers, node) {
> > -               u64 growth;
> > -
> >                 /* Check for stall activity */
> >                 if (group->polling_total[t->state] == total[t->state])
> >                         continue;
> >
> >                 /*
> > -                * Multiple triggers might be looking at the same state,
> > -                * remember to update group->polling_total[] once we've
> > -                * been through all of them. Also remember to extend the
> > -                * polling time if we see new stall activity.
> > +                * update the trigger if there is new stall which will be
> > +                * reset when run out of the window
> >                  */
> > -               new_stall = true;
> > +               t->new_stall = true;
> > +
> > +               memcpy(&group->polling_total[t->state], &total[t->state],
> > +                               sizeof(group->polling_total[t->state]));
> > +       }
> > +
> > +       list_for_each_entry(t, &group->triggers, node) {
> > +               u64 growth;
> > +
> > +               /* check if new stall happened during this window*/
> > +               if (!t->new_stall)
> > +                       continue;
> >
> >                 /* Calculate growth since last update */
> >                 growth = window_update(&t->win, now, total[t->state]);
> > @@ -552,10 +561,6 @@ static u64 update_triggers(struct psi_group *group, u64 now)
> >                 t->last_event_time = now;
> >         }
> >
> > -       if (new_stall)
> > -               memcpy(group->polling_total, total,
> > -                               sizeof(group->polling_total));
> > -
> >         return now + group->poll_min_period;
> >  }
> >
> > @@ -1152,6 +1157,7 @@ struct psi_trigger *psi_trigger_create(struct psi_group *group,
> >         t->last_event_time = 0;
> >         init_waitqueue_head(&t->event_wait);
> >         kref_init(&t->refcount);
> > +       t->new_stall = false;
> >
> >         mutex_lock(&group->trigger_lock);
> >
> > --
> > 1.9.1
> >
