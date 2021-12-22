Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20BED47CA44
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 01:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235402AbhLVAbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 19:31:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbhLVAbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 19:31:24 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 424D4C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 16:31:24 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id d10so1511738ybn.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 16:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SNBOqHfYsJM2XZlslGfzynJiGbFC42u78YgcTz+rAh8=;
        b=M35vDBWAW30c2baNvX9BJWGmyh/THdKlN8RuZDFGfMf2sDU19vO24epqQfgQxboz7t
         BgXOvTwHkKYLLdhV3Twm8gmg+ISNRYfh6JhCv9QxTj2Wy0ErmA64qJcWtrG3Cim/roMX
         O57PJ0pdtHQ/xpwGpWrzfuxVgA5So1hSLcv7P7gVrf15BlrXEaI2wD9YXLeyz+Zk0jnL
         MB9bWtlGZmD1yFPcnj6Vnu9c9LJH/jrllyqHvNFWF+hQgrXfd9QhmOV6heiOgNCfbUzn
         NSZS3XUEXrTKfvaiHbxeIR/hRpaaiCDjqloda6iqoiyCbLr0DmRVrD5dl69QcndgdsjR
         LDwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SNBOqHfYsJM2XZlslGfzynJiGbFC42u78YgcTz+rAh8=;
        b=4fa0mvYtdqLpzs4tyi80eK8YZcHETkivAaDLww+bJayVYugPs+peE/ksiM+m6ZbhQU
         L4d39B1UpyLXju7LFssVY8f4ZeSldUQ2TXRZWti6bCE9YYFhzn8vwmgphm6XLjDDd/Gl
         xFxeagzP/lqOLL9brjCtCEVWI3lRq4uXONS4fPtDmVfhAXJBZFfGisYLGwwamTMMIViZ
         nCb76f4AEvq874jygZ5kX5Jor94EX+v/ia0vGLQBEP6D65ts6rfHdOpYHGO9bw/aONHM
         oJG6nF2R2gBVLBkSTpSIWAW2WbB5mQRtATU0I8RGS4uzIf248XpUTwwd+mwt9Lzwngr2
         OclQ==
X-Gm-Message-State: AOAM531MTTelh3gdKYNmRgm5bTg4Ghi3iUbnTZDKR5Iz8Fm/lTKPfeG+
        CaWJur4UPaFcIUMBcs+TvyuJZ2HF5Z1EnFD78Xl6/g==
X-Google-Smtp-Source: ABdhPJwHIrqzqXnbWGciVfLyz7Dd8ESbFT+V2xQjqBJqnlKSHttH8THwUYvYz5f+WLqbA9AimTR1cDTfP39gTm8VkOA=
X-Received: by 2002:a25:610d:: with SMTP id v13mr1084267ybb.1.1640133083191;
 Tue, 21 Dec 2021 16:31:23 -0800 (PST)
MIME-Version: 1.0
References: <1640132668-28249-1-git-send-email-huangzhaoyang@gmail.com>
In-Reply-To: <1640132668-28249-1-git-send-email-huangzhaoyang@gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 21 Dec 2021 16:31:12 -0800
Message-ID: <CAJuCfpFdb7VAZExs=ejqG0FDJqRi4LwOEu5E1EM8rtyv1HzbaQ@mail.gmail.com>
Subject: Re: [PATCH v3] psi: fix possible trigger missing in the window
To:     Huangzhaoyang <huangzhaoyang@gmail.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2021 at 4:24 PM Huangzhaoyang <huangzhaoyang@gmail.com> wrote:
>
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

Please remember to CC Peter.

>
> When a new threshold breaching stall happens after a psi event was
> generated and within the window duration, the new event is not
> generated because the events are rate-limited to one per window. If
> after that no new stall is recorded then the event will not be
> generated even after rate-limiting duration has passed. This is
> happening because with no new stall, window_update will not be called
> even though threshold was previously breached. To fix this, record
> threshold breaching occurrence and generate the event once window
> duration is passed.
>
> Suggested-by: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> ---
> v2: modify the logic according to Suren's suggestion
> v3: update commit message
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
