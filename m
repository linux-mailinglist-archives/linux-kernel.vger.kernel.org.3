Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 734E747DCBA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 02:12:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345904AbhLWBMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 20:12:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345897AbhLWBMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 20:12:06 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B63F8C061757
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 17:11:52 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id j2so11533678ybg.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 17:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qRpS9GO+nyuDq6fnvSY9uBB02k3InwFJwb2n473ioEY=;
        b=Zc5D/VDQT1bzGScMnBP2qSmhie5dDKT2bySJqKk24sWYsc69eqsngsVKBIl1AbNvWb
         Ye4VAAhECbBZdAr1b/KrQuD3jSg6gOLXyc2556Wfmtct87GOn1Wp5TG5Rbwt6bgYL270
         QtgBVI7Zuk/Ehrq+VAwKYOGH4DaSj2CdBqApTyPsAq/ScKHkJTwLrQrRIk8m5pCl4DZ3
         Em0hjEjqX0ro7ZMIgSQBZTqN/cyW3db8Qjgz4/7j3K0xS7wQIEZlszLQyJAXdFyc9sO/
         RPwB6m98Blf2HpSuGJbX8SmU5iZsFgnT9DPWZ3GdE8/EpCHWlLYWRC15PYwUX7GI1YyP
         QcgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qRpS9GO+nyuDq6fnvSY9uBB02k3InwFJwb2n473ioEY=;
        b=awdrmaBgE0XFvFnn4NlSC6Gr9ZFtuLq30Ih+LINGpyfi0YjHHjdjX3uzQV7DNBuHt3
         gYO/nmIEf5Ful6eqM+sfi/rpilNO+EF2TFDsl9otv74Sqz+PByrr3HGu66hq6Q9VeQBG
         zZp3VYqjcsEONh6/aDr1O3PEKkr60r6evsEkEmT+67UGQK13H0zaSJmVlpg0Zp5iJd/C
         9UEi6LWF/YWEniMVErNcsvH0PL1/6EqUYDWrnPuLE5LFhlrQv/GpPSYYCbJin1Y+8d/c
         PShSi8C0lv68xzYFCl9B9oj136USmWc+6x2au7kJ1TJ8H0Xb+SiV+dP3s85d1TJmt8gp
         gUgg==
X-Gm-Message-State: AOAM530cFWI6eag0lL98vKcg9GCrVaH3YH5B5wpmOhU00KlRdG0zZy9S
        y/45x0EHCXnEPi462e2U3U5/LBM6YjK22+/0I4E09Q==
X-Google-Smtp-Source: ABdhPJx2NYMONbioCxps3nJVWm787JBFhNgsc0twm+/smBnB0ZR3vjY5R+FOqqjTOXDx2waYp4OGbVClZheFLgNZvuI=
X-Received: by 2002:a05:6902:552:: with SMTP id z18mr352788ybs.318.1640221911761;
 Wed, 22 Dec 2021 17:11:51 -0800 (PST)
MIME-Version: 1.0
References: <1640132668-28249-1-git-send-email-huangzhaoyang@gmail.com>
 <CAJuCfpFdb7VAZExs=ejqG0FDJqRi4LwOEu5E1EM8rtyv1HzbaQ@mail.gmail.com> <CAGWkznGJE32mQAve+MB3YrCwmLAGbwd9oyn3rWN2SZj07ez9jw@mail.gmail.com>
In-Reply-To: <CAGWkznGJE32mQAve+MB3YrCwmLAGbwd9oyn3rWN2SZj07ez9jw@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 22 Dec 2021 17:11:40 -0800
Message-ID: <CAJuCfpG0Y8BstFhKV8c_EcT-REmXpwrxXXPk_JwiUwK9k2RMgA@mail.gmail.com>
Subject: Re: [PATCH v3] psi: fix possible trigger missing in the window
To:     Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 4:50 PM Zhaoyang Huang <huangzhaoyang@gmail.com> wrote:
>
> @Peter Zijlstra @Johannes Weiner
> Would you please review this patch? We would like to have it be merged
> ASAP. Thanks.

It's the holiday season, so I would not expect a quick turnaround.

>
> On Wed, Dec 22, 2021 at 8:31 AM Suren Baghdasaryan <surenb@google.com> wrote:
> >
> > On Tue, Dec 21, 2021 at 4:24 PM Huangzhaoyang <huangzhaoyang@gmail.com> wrote:
> > >
> > > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> >
> > Please remember to CC Peter.
> >
> > >
> > > When a new threshold breaching stall happens after a psi event was
> > > generated and within the window duration, the new event is not
> > > generated because the events are rate-limited to one per window. If
> > > after that no new stall is recorded then the event will not be
> > > generated even after rate-limiting duration has passed. This is
> > > happening because with no new stall, window_update will not be called
> > > even though threshold was previously breached. To fix this, record
> > > threshold breaching occurrence and generate the event once window
> > > duration is passed.
> > >
> > > Suggested-by: Suren Baghdasaryan <surenb@google.com>
> > > Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > > ---
> > > v2: modify the logic according to Suren's suggestion
> > > v3: update commit message
> > > ---
> > > ---
> > >  include/linux/psi_types.h |  2 ++
> > >  kernel/sched/psi.c        | 38 +++++++++++++++++++++++---------------
> > >  2 files changed, 25 insertions(+), 15 deletions(-)
> > >
> > > diff --git a/include/linux/psi_types.h b/include/linux/psi_types.h
> > > index 0a23300..87b694a 100644
> > > --- a/include/linux/psi_types.h
> > > +++ b/include/linux/psi_types.h
> > > @@ -132,6 +132,8 @@ struct psi_trigger {
> > >
> > >         /* Refcounting to prevent premature destruction */
> > >         struct kref refcount;
> > > +
> > > +       bool threshold_breach;
> > >  };
> > >
> > >  struct psi_group {
> > > diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> > > index 1652f2b..5c67ab9 100644
> > > --- a/kernel/sched/psi.c
> > > +++ b/kernel/sched/psi.c
> > > @@ -524,24 +524,29 @@ static u64 update_triggers(struct psi_group *group, u64 now)
> > >          */
> > >         list_for_each_entry(t, &group->triggers, node) {
> > >                 u64 growth;
> > > +               bool trigger_stalled =
> > > +                       group->polling_total[t->state] != total[t->state];
> > >
> > > -               /* Check for stall activity */
> > > -               if (group->polling_total[t->state] == total[t->state])
> > > -                       continue;
> > > -
> > > -               /*
> > > -                * Multiple triggers might be looking at the same state,
> > > -                * remember to update group->polling_total[] once we've
> > > -                * been through all of them. Also remember to extend the
> > > -                * polling time if we see new stall activity.
> > > -                */
> > > -               new_stall = true;
> > > -
> > > -               /* Calculate growth since last update */
> > > -               growth = window_update(&t->win, now, total[t->state]);
> > > -               if (growth < t->threshold)
> > > +               /* Check for stall activity or a previous threshold breach */
> > > +               if (!trigger_stalled && !t->threshold_breach)
> > >                         continue;
> > >
> > > +               if (trigger_stalled) {
> > > +                       /*
> > > +                        * Multiple triggers might be looking at the same state,
> > > +                        * remember to update group->polling_total[] once we've
> > > +                        * been through all of them. Also remember to extend the
> > > +                        * polling time if we see new stall activity.
> > > +                        */
> > > +                       new_stall = true;
> > > +
> > > +                       /* Calculate growth since last update */
> > > +                       growth = window_update(&t->win, now, total[t->state]);
> > > +                       if (growth < t->threshold)
> > > +                               continue;
> > > +
> > > +                       t->threshold_breach = true;
> > > +               }
> > >                 /* Limit event signaling to once per window */
> > >                 if (now < t->last_event_time + t->win.size)
> > >                         continue;
> > > @@ -550,6 +555,8 @@ static u64 update_triggers(struct psi_group *group, u64 now)
> > >                 if (cmpxchg(&t->event, 0, 1) == 0)
> > >                         wake_up_interruptible(&t->event_wait);
> > >                 t->last_event_time = now;
> > > +               /* Reset threshold breach flag once event got generated */
> > > +               t->threshold_breach = false;
> > >         }
> > >
> > >         if (new_stall)
> > > @@ -1152,6 +1159,7 @@ struct psi_trigger *psi_trigger_create(struct psi_group *group,
> > >         t->last_event_time = 0;
> > >         init_waitqueue_head(&t->event_wait);
> > >         kref_init(&t->refcount);
> > > +       t->threshold_breach = false;
> > >
> > >         mutex_lock(&group->trigger_lock);
> > >
> > > --
> > > 1.9.1
> > >
