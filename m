Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 717EA47C949
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 23:40:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbhLUWkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 17:40:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbhLUWkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 17:40:41 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6195AC061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 14:40:41 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id v64so755441ybi.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 14:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hD0pZoQcS3KfcyiV0zGmIHG20iPzEg5VDSH1vfbov/g=;
        b=pW8gWI/jXD1bJTfs0SmV/vRFgZ/l0OgWGoCeQJIUXMToVGWQjowAEFmE8bTjEsXKKr
         OVz91r8Apn2zb1pfGQ9THwvt3YnCMt8lJ23OyzFvzWbfoqY6SHp4LmtQPU6Mhca3xptN
         Vu/8AAsttTOCKpmdyPLx8d4SZ8c69vNhZ/BUOWwQXLKZSpEJh7Ybh4KSwAKUypIzIGJH
         Twh2S8CKOHJqEpLpSJP+hltUxa3yo5zcak81sXNHz+2O9FwcHB370RoHYmh1gvkL4ESL
         THgawQXsrZImhr0IoF4r72Ij0TSvMKTPuDBaRlJ7XKgR0t9izDBll9bPslN+n4j8UB6/
         rbSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hD0pZoQcS3KfcyiV0zGmIHG20iPzEg5VDSH1vfbov/g=;
        b=PRATt9IntSPGSFIIAyR9+4Cn2K2eZCi8cjcyLFmXv75SmP2eD0hQ7bnFG6vXd022FF
         Mfl2hX4yfsigvtzjnz07aUcvrW74GD+zDMozJO9g3A92vph+fUGvNuHlCUJfSOiT/JAB
         tQkfgAJIEEQA0PH6hkL7OE/7RtkoBHMTzSBevjZuUbL8GpuEPzD/COHlLbBAkK3I9mVs
         W4HV0S1IRE6U3V6Ur5LWUL2vMET96RLbGkiiwHL0Qzlw9OiAQMFLhnNxI9zP1kNK48Y2
         yswXUOGyRklMYAlB0dHajxKXxfTWP2xGqOdr9T34WpOzF+OT3GwwkaqQxzjZ7RMX4U/9
         seCA==
X-Gm-Message-State: AOAM531aKOQp+ovknSx6zJend8E/XGcaNeSiNNnPRF7qFF546bBpM6I6
        VhWxK80TIBDN6NnTohMMZNRKUo3/gMnxa9nBRw8fFV/72kzEeVZz
X-Google-Smtp-Source: ABdhPJwewWZuE8UNQR14Q3RT96/FbV3ekF2iUw1OO7au3+ISkSasPaUEout5OHOQO2w1HJi/gQW2EnKR18y+6kndlkg=
X-Received: by 2002:a5b:c0b:: with SMTP id f11mr694892ybq.488.1640126440296;
 Tue, 21 Dec 2021 14:40:40 -0800 (PST)
MIME-Version: 1.0
References: <1640075637-14520-1-git-send-email-huangzhaoyang@gmail.com>
In-Reply-To: <1640075637-14520-1-git-send-email-huangzhaoyang@gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 21 Dec 2021 14:40:29 -0800
Message-ID: <CAJuCfpGTmbbT0kf8USCLZYtC0txOioNO-OyigCJGKb0Pf5eppA@mail.gmail.com>
Subject: Re: [PATCH v2] psi: fix possible trigger missing in the window
To:     Huangzhaoyang <huangzhaoyang@gmail.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2021 at 12:34 AM Huangzhaoyang <huangzhaoyang@gmail.com> wrote:
>
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

CC'ing PeterZ since I think this change will need to be accepted into
his tree. Please include Peter in the future versions of this patch.

>
> There could be missing wake up if the rest of the window remain the
> same stall states as the polling_total updates for every polling_min_period.
> Introducing threshold_breach flag to record the trigger's status and update
> the logic.

At least for me, it's hard to understand the problem from this
description. Suggest something like this:

When a new threshold breaching stall happens after a psi event was
generated and within the window duration, the new event is not
generated because the events are rate-limited to one per window. If
after that no new stall is recorded then the event will not be
generated even after rate-limiting duration has passed. This is
happening because with no new stall, window_update will not be called
even though threshold was previously breached. To fix this, record
threshold breaching occurrence and generate the event once window
duration is passed.

The code looks good to me. Thanks!

>
> Suggested-by: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> ---
> v2: modify the logic according to Suren's suggestion
> ---
> ---
>  include/linux/psi_types.h |  2 ++
>  kernel/sched/psi.c        | 38 +++++++++++++++++++++++---------------
>  2 files changed, 25 insertions(+), 15 deletions(-)
>
> diff --git a/include/linux/psi_types.h b/include/linux/psi_types.h
> index 0a23300..87b694a 100644
> --- a/include/linux/psi_types.h
> +++ b/include/linux/psi_types.h
> @@ -132,6 +132,8 @@ struct psi_trigger {
>
>         /* Refcounting to prevent premature destruction */
>         struct kref refcount;
> +
> +       bool threshold_breach;
>  };
>
>  struct psi_group {
> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> index 1652f2b..5c67ab9 100644
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -524,24 +524,29 @@ static u64 update_triggers(struct psi_group *group, u64 now)
>          */
>         list_for_each_entry(t, &group->triggers, node) {
>                 u64 growth;
> +               bool trigger_stalled =
> +                       group->polling_total[t->state] != total[t->state];
>
> -               /* Check for stall activity */
> -               if (group->polling_total[t->state] == total[t->state])
> -                       continue;
> -
> -               /*
> -                * Multiple triggers might be looking at the same state,
> -                * remember to update group->polling_total[] once we've
> -                * been through all of them. Also remember to extend the
> -                * polling time if we see new stall activity.
> -                */
> -               new_stall = true;
> -
> -               /* Calculate growth since last update */
> -               growth = window_update(&t->win, now, total[t->state]);
> -               if (growth < t->threshold)
> +               /* Check for stall activity or a previous threshold breach */
> +               if (!trigger_stalled && !t->threshold_breach)
>                         continue;
>
> +               if (trigger_stalled) {
> +                       /*
> +                        * Multiple triggers might be looking at the same state,
> +                        * remember to update group->polling_total[] once we've
> +                        * been through all of them. Also remember to extend the
> +                        * polling time if we see new stall activity.
> +                        */
> +                       new_stall = true;
> +
> +                       /* Calculate growth since last update */
> +                       growth = window_update(&t->win, now, total[t->state]);
> +                       if (growth < t->threshold)
> +                               continue;
> +
> +                       t->threshold_breach = true;
> +               }
>                 /* Limit event signaling to once per window */
>                 if (now < t->last_event_time + t->win.size)
>                         continue;
> @@ -550,6 +555,8 @@ static u64 update_triggers(struct psi_group *group, u64 now)
>                 if (cmpxchg(&t->event, 0, 1) == 0)
>                         wake_up_interruptible(&t->event_wait);
>                 t->last_event_time = now;
> +               /* Reset threshold breach flag once event got generated */
> +               t->threshold_breach = false;
>         }
>
>         if (new_stall)
> @@ -1152,6 +1159,7 @@ struct psi_trigger *psi_trigger_create(struct psi_group *group,
>         t->last_event_time = 0;
>         init_waitqueue_head(&t->event_wait);
>         kref_init(&t->refcount);
> +       t->threshold_breach = false;
>
>         mutex_lock(&group->trigger_lock);
>
> --
> 1.9.1
>
