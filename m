Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BDE74984F6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 17:38:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243538AbiAXQiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 11:38:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236102AbiAXQiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 11:38:10 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC4EC06173B
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 08:38:10 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id h14so53043649ybe.12
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 08:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J8ycivHdU9v2HmuEv4lTg2qC6izyVod1QqFr0SelWOE=;
        b=Ji+MSNF4pYwPoh7iPNo0AIs29aypuZNI03FIOxoIf4UlhRewBmOnp7m6hLTM2fEM+E
         mkTUHB5wtnyvPphdtxKwnjLuTCPiOsrPulAwu4Au1almQbVWdocm98GhXO1+wbbU5m8x
         9ny7w1HqLHLWNmkai3OZkesA5H2H+UqACv8C0wxHoKOL8snZTfd56Gvj2qasAyEUm5pa
         /kNU6cAFW/BkyKA4hpgnyCWxLDwZdjIRIWawvLp0OFHzgwyHXvtBbQZ570v4BcThxJUr
         +LooAypKttU4Ba8L6ceEjp6oC8P+N0Q+H3NwWo6fz3i2bi/xyuS+Wt4BOfieOZ35cAzb
         h4Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J8ycivHdU9v2HmuEv4lTg2qC6izyVod1QqFr0SelWOE=;
        b=4jZV8tyWvsYDhtjuyyA9YMISpx6iD/2+mBzaRbw2mxEa2rCsJaF05fi/E+1ZF0oEjC
         ItrXf7jy/LZaP8aywH4YiY0D1QU3AGKEVfRSTb2MgBeUYwOePA+1nBQ6zKCbMGJLVMYJ
         0VcIC+5YkA4N8OjiUCfyxry5A8tqFKscTqBNIsk42KcHb9MP4/iavIAF56bN6PMYSwuo
         RGEPstsrEk1+yMkRugTvCDnQWyHgDSOoeKuvsKsz++5M8PCDTTe1wmDTIqGjZEfn4CYI
         L4BKyz0GzHtawRa9zdVuqa0nv05KR6tHhy15zyKLg596q61nTn/AD75K2WVqTDOtgzda
         vtwg==
X-Gm-Message-State: AOAM530W+XMxIToGwtW5zvqASwaQDHBEJE2IlbHOg93LonptcEh7f/ag
        5CPQudYu7esotjtOyONVwgcgfB9KbYei+EpP32tzozhdjAYzsw==
X-Google-Smtp-Source: ABdhPJwdmbYvlu5sk5zS4/vbCTud0ofYtsymijqTtFDv8truJQRJYVBkxNIMGQbbB8TPYAabRLWn4T3853biseIK0RI=
X-Received: by 2002:a25:d617:: with SMTP id n23mr25290949ybg.488.1643042288901;
 Mon, 24 Jan 2022 08:38:08 -0800 (PST)
MIME-Version: 1.0
References: <1642649516-15076-1-git-send-email-huangzhaoyang@gmail.com> <Ye7Lc1vIVwICZQet@cmpxchg.org>
In-Reply-To: <Ye7Lc1vIVwICZQet@cmpxchg.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 24 Jan 2022 08:37:58 -0800
Message-ID: <CAJuCfpFe-ZrYZ=o1YnxcjK3aQakxUaU6aKnOZRkKSSsJ=_pbxg@mail.gmail.com>
Subject: Re: [Resend PATCH v3] psi: fix possible trigger missing in the window
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Huangzhaoyang <huangzhaoyang@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        Ingo Molnar <mingo@redhat.com>, linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 7:53 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Thu, Jan 20, 2022 at 11:31:56AM +0800, Huangzhaoyang wrote:
> > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
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
>
> Good catch. The change makes sense to me.
>
> However, I had to re-read the discussion to understand *why*
> triggering once per window can be a practical problem. Could you
> please include the lkmd scenario you mentioned?
>
> Suren, even though it's your suggested code, can you please also add
> ack/review tags? Thanks!

Will do as soon as the new version is posted and your comments are
addressed. Thanks!

>
> Some minor inline comments:
>
> > diff --git a/include/linux/psi_types.h b/include/linux/psi_types.h
> > index 0a23300..87b694a 100644
> > --- a/include/linux/psi_types.h
> > +++ b/include/linux/psi_types.h
> > @@ -132,6 +132,8 @@ struct psi_trigger {
> >
> >       /* Refcounting to prevent premature destruction */
> >       struct kref refcount;
> > +
> > +     bool threshold_breach;
>
> Something like bool pending_event would be more descriptive, IMO.
>
> Also please remember to add a short comment like we have for the other
> struct members. For example:
>
>         /* Deferred event(s) from previous ratelimit window */
>
> > @@ -524,24 +524,29 @@ static u64 update_triggers(struct psi_group *group, u64 now)
> >        */
> >       list_for_each_entry(t, &group->triggers, node) {
> >               u64 growth;
> > +             bool trigger_stalled =
> > +                     group->polling_total[t->state] != total[t->state];
>
> Triggers don't stall, they trigger on stalls. How about this:
>
>                 bool new_stall;
>                 u64 growth;
>
>                 new_stall = group->polling_total[t->state] != total[t->state];
>
> (order local declarations by length, avoid line wraps where possible)
>
> > -             /* Check for stall activity */
> > -             if (group->polling_total[t->state] == total[t->state])
> > -                     continue;
> > -
> > -             /*
> > -              * Multiple triggers might be looking at the same state,
> > -              * remember to update group->polling_total[] once we've
> > -              * been through all of them. Also remember to extend the
> > -              * polling time if we see new stall activity.
> > -              */
> > -             new_stall = true;
> > -
> > -             /* Calculate growth since last update */
> > -             growth = window_update(&t->win, now, total[t->state]);
> > -             if (growth < t->threshold)
> > +             /* Check for stall activity or a previous threshold breach */
> > +             if (!trigger_stalled && !t->threshold_breach)
> >                       continue;
>
> This could use a bit more explanation imo:
>
>                 /*
>                  * Check for new stall activity, as well as deferred
>                  * events that occurred in the last window after the
>                  * trigger had already fired (we want to ratelimit
>                  * events without dropping any).
>                  */
>                 if (!new_stall && !t->pending_event)
>                         continue;
>
> > +             if (trigger_stalled) {
> > +                     /*
> > +                      * Multiple triggers might be looking at the same state,
> > +                      * remember to update group->polling_total[] once we've
> > +                      * been through all of them. Also remember to extend the
> > +                      * polling time if we see new stall activity.
> > +                      */
> > +                     new_stall = true;
>
> and then rename this flag `update_total'.
>
> > +                     /* Calculate growth since last update */
> > +                     growth = window_update(&t->win, now, total[t->state]);
> > +                     if (growth < t->threshold)
> > +                             continue;
> > +
> > +                     t->threshold_breach = true;
> > +             }
> >               /* Limit event signaling to once per window */
> >               if (now < t->last_event_time + t->win.size)
> >                       continue;
> > @@ -550,6 +555,8 @@ static u64 update_triggers(struct psi_group *group, u64 now)
> >               if (cmpxchg(&t->event, 0, 1) == 0)
> >                       wake_up_interruptible(&t->event_wait);
> >               t->last_event_time = now;
> > +             /* Reset threshold breach flag once event got generated */
> > +             t->threshold_breach = false;
> >       }
> >
> >       if (new_stall)
> > @@ -1152,6 +1159,7 @@ struct psi_trigger *psi_trigger_create(struct psi_group *group,
> >       t->last_event_time = 0;
> >       init_waitqueue_head(&t->event_wait);
> >       kref_init(&t->refcount);
> > +     t->threshold_breach = false;
> >
> >       mutex_lock(&group->trigger_lock);
>
> Thanks!
