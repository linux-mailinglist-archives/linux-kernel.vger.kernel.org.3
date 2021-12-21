Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86C1547B6FD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 02:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbhLUB5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 20:57:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231309AbhLUB5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 20:57:06 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D06C061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 17:57:06 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id p4so11188690qkm.7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 17:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5kGGZNA6AABEoxSURNI3DwDCVPmsZyAz/hG0EO01Rc0=;
        b=dx85LNEfgR1alPkW0MG24kKEKn1Mowf775AiiZt+x22oJIbufoQtrOZU0BZdmNbqhW
         2Mo8VQl5cvCA5kisl9jvkN8TnxjI1xi2DG+HCbucRh+eJpA6uhOph6uiREBcrWcyvr0e
         fKrBxOagfQSc+a9EbUAW4LCZs7pyqg9JmDf0Pzl+lAHrHF7b5Tsa/VEvCw/bsUHxQlQL
         ZtfQosRx7Alpdbt4xJknSc6Vy60774tq9w0ivntJCyfI9CezR+GguglQ3gbgJl+hhXni
         78A4TwSF3y2cROB3HlEFHlYf+dWEZb7KQBLsI75BQd5tpyybPqkwfiyrx9CTXOnTj04V
         2R9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5kGGZNA6AABEoxSURNI3DwDCVPmsZyAz/hG0EO01Rc0=;
        b=FMjJUC0zqsBEHkm3xptdlW+e/b4x0mcdjU7mdqOvOEdYXyEFIPqeYVK8bfwCZ17Aaq
         5rTWBtsl8sx2UPA3Y1RR4PTgRYFdikU8FT2t86zZ1bNVKc4qU+hrXM1nCF9mO0DSCS/U
         asPW4EZKYUwZWlpgo46Bg3cSBsADV8koXZWnA/Y/S+qTPbvmKs2FcCXj3c2nNFYbi0Ru
         ICcghLDxT41mjIz+VeGRDMjrp5QuLaoDBphMKaZsG8ioJzIRRQ+t593KZVjFnCOPVMnb
         J+Ta0iic3Uc4+nE1KyF7ju6ToLNO8z8b96hufueZLGADqDvmfOSy40UZUOF7q535BBFI
         rdcA==
X-Gm-Message-State: AOAM531cVvAIKPzaTo9HwjjAzKURUjDMuODfwLJGmf+PyTbKVDMP2nTz
        RreM5xrmKSD2+P2ekkm2yXbdZuWifbw4sxEsSba0W/5iNvMadKXI
X-Google-Smtp-Source: ABdhPJzBKKiOV2mJ9YbMyaKpDVwWh0kSy+6nMj3o/nNlJeIGpk0WFEK0TX2Af6fLNCw7YkWRAKWcXDt2JTJTOMLh3RE=
X-Received: by 2002:a05:620a:1713:: with SMTP id az19mr678889qkb.297.1640051825786;
 Mon, 20 Dec 2021 17:57:05 -0800 (PST)
MIME-Version: 1.0
References: <1639721264-12294-1-git-send-email-huangzhaoyang@gmail.com>
 <CAGWkznGdvLobshPvg2KY+D71Zh0625+V=WsAS9uExRspRFFjVQ@mail.gmail.com> <CAJuCfpF9tJupcyWVeDHyEBnQqTZTnoyKVcKLqB1wWXyks6Z0Cw@mail.gmail.com>
In-Reply-To: <CAJuCfpF9tJupcyWVeDHyEBnQqTZTnoyKVcKLqB1wWXyks6Z0Cw@mail.gmail.com>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Tue, 21 Dec 2021 09:56:45 +0800
Message-ID: <CAGWkznG8ipn96YgyOatF=i5acLGoLp9G8E4jD7vHKMw9aOV1ZA@mail.gmail.com>
Subject: Re: [PATCH] psi: fix possible trigger missing in the window
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2021 at 3:58 AM Suren Baghdasaryan <surenb@google.com> wrote:
>
> On Fri, Dec 17, 2021 at 10:03 PM Zhaoyang Huang <huangzhaoyang@gmail.com> wrote:
> >
> > loop Suren
>
> Thanks.
>
>
> >
> > On Fri, Dec 17, 2021 at 2:08 PM Huangzhaoyang <huangzhaoyang@gmail.com> wrote:
> > >
> > > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > >
> > > There could be missing wake up if the rest of the window remain the
> > > same stall states as the polling_total updates for every polling_min_period.
>
> Could you please expand on this description? I'm unclear what the
> problem is. I assume "polling_min_period" in this description refers
> to the group->poll_min_period.
>
> From the code, looks like the change results in update_triggers()
> calling window_update() once there was a new stall recorded for the
> trigger state and until the tracking window is complete. I don't see
> the point of calling window_update() if there was no stall change
> since the last call to window_update(). The resulting growth will not
> increase if there is no new stall.
> Maybe what you want to achieve here is more than one trigger per
> window if the stall limit was breached? If so, then this goes against
> the design for psi triggers in which we want to rate-limit the number
> of generated triggers per tracking window (see:
> https://elixir.bootlin.com/linux/latest/source/kernel/sched/psi.c#L545).
> Please clarify the issue and the intentions here.
> Thanks!
Please correct me if I am wrong. Imagine that there is a new stall
during the 1st polling_min_period among 10 of them in the window and
group->polling_total will be updated to total without trigger. If the
rest of 9 polling_min_periods remain the same states, the trigger will
be missed when window timing is reached.
>
> > >
> > > Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > > ---
> > >  include/linux/psi_types.h |  2 ++
> > >  kernel/sched/psi.c        | 30 ++++++++++++++++++------------
> > >  2 files changed, 20 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/include/linux/psi_types.h b/include/linux/psi_types.h
> > > index 0a23300..9533d2e 100644
> > > --- a/include/linux/psi_types.h
> > > +++ b/include/linux/psi_types.h
> > > @@ -132,6 +132,8 @@ struct psi_trigger {
> > >
> > >         /* Refcounting to prevent premature destruction */
> > >         struct kref refcount;
> > > +
> > > +       bool new_stall;
> > >  };
> > >
> > >  struct psi_group {
> > > diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> > > index 1652f2b..402718c 100644
> > > --- a/kernel/sched/psi.c
> > > +++ b/kernel/sched/psi.c
> > > @@ -458,9 +458,12 @@ static void psi_avgs_work(struct work_struct *work)
> > >  static void window_reset(struct psi_window *win, u64 now, u64 value,
> > >                          u64 prev_growth)
> > >  {
> > > +       struct psi_trigger *t = container_of(win, struct psi_trigger, win);
> > > +
> > >         win->start_time = now;
> > >         win->start_value = value;
> > >         win->prev_growth = prev_growth;
> > > +       t->new_stall = false;
> > >  }
> > >
> > >  /*
> > > @@ -515,7 +518,6 @@ static void init_triggers(struct psi_group *group, u64 now)
> > >  static u64 update_triggers(struct psi_group *group, u64 now)
> > >  {
> > >         struct psi_trigger *t;
> > > -       bool new_stall = false;
> > >         u64 *total = group->total[PSI_POLL];
> > >
> > >         /*
> > > @@ -523,19 +525,26 @@ static u64 update_triggers(struct psi_group *group, u64 now)
> > >          * watchers know when their specified thresholds are exceeded.
> > >          */
> > >         list_for_each_entry(t, &group->triggers, node) {
> > > -               u64 growth;
> > > -
> > >                 /* Check for stall activity */
> > >                 if (group->polling_total[t->state] == total[t->state])
> > >                         continue;
> > >
> > >                 /*
> > > -                * Multiple triggers might be looking at the same state,
> > > -                * remember to update group->polling_total[] once we've
> > > -                * been through all of them. Also remember to extend the
> > > -                * polling time if we see new stall activity.
> > > +                * update the trigger if there is new stall which will be
> > > +                * reset when run out of the window
> > >                  */
> > > -               new_stall = true;
> > > +               t->new_stall = true;
> > > +
> > > +               memcpy(&group->polling_total[t->state], &total[t->state],
> > > +                               sizeof(group->polling_total[t->state]));
> > > +       }
> > > +
> > > +       list_for_each_entry(t, &group->triggers, node) {
> > > +               u64 growth;
> > > +
> > > +               /* check if new stall happened during this window*/
> > > +               if (!t->new_stall)
> > > +                       continue;
> > >
> > >                 /* Calculate growth since last update */
> > >                 growth = window_update(&t->win, now, total[t->state]);
> > > @@ -552,10 +561,6 @@ static u64 update_triggers(struct psi_group *group, u64 now)
> > >                 t->last_event_time = now;
> > >         }
> > >
> > > -       if (new_stall)
> > > -               memcpy(group->polling_total, total,
> > > -                               sizeof(group->polling_total));
> > > -
> > >         return now + group->poll_min_period;
> > >  }
> > >
> > > @@ -1152,6 +1157,7 @@ struct psi_trigger *psi_trigger_create(struct psi_group *group,
> > >         t->last_event_time = 0;
> > >         init_waitqueue_head(&t->event_wait);
> > >         kref_init(&t->refcount);
> > > +       t->new_stall = false;
> > >
> > >         mutex_lock(&group->trigger_lock);
> > >
> > > --
> > > 1.9.1
> > >
