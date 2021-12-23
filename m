Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF33247DC5D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 01:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239138AbhLWAux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 19:50:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238150AbhLWAuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 19:50:52 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50078C061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 16:50:52 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id fo11so3809360qvb.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 16:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5ojLwmjQpkbFYUPrgr9e5LBbVEdE5fLHBr16hsYVDs8=;
        b=ZFc9wRu/xtOdyh2hglOWsy8PxyPGLBNp2wRznQCYjdhbQ85WoeZRfxnBonPI7i/ga7
         ttCz25lTHf/u6edQuVFJVGtKFyncjOo1oTG8mSH0Y/Vvwagrx94+4d1yPmnHYxV8rhi2
         d2PHIPUgadHq6oEKQ9rcmtZaQ/NUKWMcTNequq+mjzDcArvs7JwM959M5VN/Y4EY9kui
         oZ42vRx6is0M2fvEfPbIArVrHot0JnRTC93c2d358YNwwA4pEmfIWywW/Fzd8CJOTMTh
         T7zdNEMvlyWMgCMfrGwG8lLwqYJAaBy1vf1Vir8fvVYLA7WMNq2YZgwut0lsFDq06BlP
         biYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5ojLwmjQpkbFYUPrgr9e5LBbVEdE5fLHBr16hsYVDs8=;
        b=m1exwo/2OJ0bC4NwTcAwvPAxAq3dbh5qw4ztM/Ac0c0ocIpT5lFT6K27TlEHujGQtT
         BDWrv/QU0oj6iGSKi0xJHvm7fZ8mmeHlzjKCEhu1XRScLXr75eW0soprWEaaiyObtjFQ
         yKQjyz04SjZiiTc5WLy42W7Se8jeNRYML5yam3U/Afu4tlJzUqR8RodFcBHEtkTxrE4/
         BMLXYEcI5+kMrDzvYW8yciYycRrl1COG1KeuFqVlUbeA+UZbbXoZ74hN/1oXzd9LBk+A
         sRFX3HYsCUUbCMz6WqZl88G7wL6tcgYehZa3QqXHi89RJodsWJfsRRKO+RvsdwLYSfCd
         iudg==
X-Gm-Message-State: AOAM530BuBQPDa2PcYI5+rVF1CZyhYqkbKI0JZ9GdsCVb4nMCP73rdiB
        Xf8KEBRTvz/L/PrN5S4+0+Hj035fqMe8ELbThw0=
X-Google-Smtp-Source: ABdhPJzcZhSaI4yJNcOImOTYhAE+s8f8/SkSTThE6t6JN7xPRbvP4MLjHsQkhBWhX6JJbyr1tCBtcCScaZzHzMVObEk=
X-Received: by 2002:a05:6214:c21:: with SMTP id a1mr29492qvd.15.1640220651470;
 Wed, 22 Dec 2021 16:50:51 -0800 (PST)
MIME-Version: 1.0
References: <1640132668-28249-1-git-send-email-huangzhaoyang@gmail.com> <CAJuCfpFdb7VAZExs=ejqG0FDJqRi4LwOEu5E1EM8rtyv1HzbaQ@mail.gmail.com>
In-Reply-To: <CAJuCfpFdb7VAZExs=ejqG0FDJqRi4LwOEu5E1EM8rtyv1HzbaQ@mail.gmail.com>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Thu, 23 Dec 2021 08:50:31 +0800
Message-ID: <CAGWkznGJE32mQAve+MB3YrCwmLAGbwd9oyn3rWN2SZj07ez9jw@mail.gmail.com>
Subject: Re: [PATCH v3] psi: fix possible trigger missing in the window
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

@Peter Zijlstra @Johannes Weiner
Would you please review this patch? We would like to have it be merged
ASAP. Thanks.

On Wed, Dec 22, 2021 at 8:31 AM Suren Baghdasaryan <surenb@google.com> wrote:
>
> On Tue, Dec 21, 2021 at 4:24 PM Huangzhaoyang <huangzhaoyang@gmail.com> wrote:
> >
> > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
>
> Please remember to CC Peter.
>
> >
> > When a new threshold breaching stall happens after a psi event was
> > generated and within the window duration, the new event is not
> > generated because the events are rate-limited to one per window. If
> > after that no new stall is recorded then the event will not be
> > generated even after rate-limiting duration has passed. This is
> > happening because with no new stall, window_update will not be called
> > even though threshold was previously breached. To fix this, record
> > threshold breaching occurrence and generate the event once window
> > duration is passed.
> >
> > Suggested-by: Suren Baghdasaryan <surenb@google.com>
> > Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > ---
> > v2: modify the logic according to Suren's suggestion
> > v3: update commit message
> > ---
> > ---
> >  include/linux/psi_types.h |  2 ++
> >  kernel/sched/psi.c        | 38 +++++++++++++++++++++++---------------
> >  2 files changed, 25 insertions(+), 15 deletions(-)
> >
> > diff --git a/include/linux/psi_types.h b/include/linux/psi_types.h
> > index 0a23300..87b694a 100644
> > --- a/include/linux/psi_types.h
> > +++ b/include/linux/psi_types.h
> > @@ -132,6 +132,8 @@ struct psi_trigger {
> >
> >         /* Refcounting to prevent premature destruction */
> >         struct kref refcount;
> > +
> > +       bool threshold_breach;
> >  };
> >
> >  struct psi_group {
> > diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> > index 1652f2b..5c67ab9 100644
> > --- a/kernel/sched/psi.c
> > +++ b/kernel/sched/psi.c
> > @@ -524,24 +524,29 @@ static u64 update_triggers(struct psi_group *group, u64 now)
> >          */
> >         list_for_each_entry(t, &group->triggers, node) {
> >                 u64 growth;
> > +               bool trigger_stalled =
> > +                       group->polling_total[t->state] != total[t->state];
> >
> > -               /* Check for stall activity */
> > -               if (group->polling_total[t->state] == total[t->state])
> > -                       continue;
> > -
> > -               /*
> > -                * Multiple triggers might be looking at the same state,
> > -                * remember to update group->polling_total[] once we've
> > -                * been through all of them. Also remember to extend the
> > -                * polling time if we see new stall activity.
> > -                */
> > -               new_stall = true;
> > -
> > -               /* Calculate growth since last update */
> > -               growth = window_update(&t->win, now, total[t->state]);
> > -               if (growth < t->threshold)
> > +               /* Check for stall activity or a previous threshold breach */
> > +               if (!trigger_stalled && !t->threshold_breach)
> >                         continue;
> >
> > +               if (trigger_stalled) {
> > +                       /*
> > +                        * Multiple triggers might be looking at the same state,
> > +                        * remember to update group->polling_total[] once we've
> > +                        * been through all of them. Also remember to extend the
> > +                        * polling time if we see new stall activity.
> > +                        */
> > +                       new_stall = true;
> > +
> > +                       /* Calculate growth since last update */
> > +                       growth = window_update(&t->win, now, total[t->state]);
> > +                       if (growth < t->threshold)
> > +                               continue;
> > +
> > +                       t->threshold_breach = true;
> > +               }
> >                 /* Limit event signaling to once per window */
> >                 if (now < t->last_event_time + t->win.size)
> >                         continue;
> > @@ -550,6 +555,8 @@ static u64 update_triggers(struct psi_group *group, u64 now)
> >                 if (cmpxchg(&t->event, 0, 1) == 0)
> >                         wake_up_interruptible(&t->event_wait);
> >                 t->last_event_time = now;
> > +               /* Reset threshold breach flag once event got generated */
> > +               t->threshold_breach = false;
> >         }
> >
> >         if (new_stall)
> > @@ -1152,6 +1159,7 @@ struct psi_trigger *psi_trigger_create(struct psi_group *group,
> >         t->last_event_time = 0;
> >         init_waitqueue_head(&t->event_wait);
> >         kref_init(&t->refcount);
> > +       t->threshold_breach = false;
> >
> >         mutex_lock(&group->trigger_lock);
> >
> > --
> > 1.9.1
> >
