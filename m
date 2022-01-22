Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3F83496B92
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 10:50:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbiAVJur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 04:50:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiAVJuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 04:50:46 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F0CC06173B
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 01:50:45 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id h15so13031989qtx.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 01:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=/DvivhbrHIY4f17iliBHPV/kS4qRh7JJhxcfM6F15FI=;
        b=KT3hk/STET5VuhcsVl0dSnqPd5cHz7tzpsyNVWb62Ck6N85363yhKnMV4tVI2S7X2X
         rCIpPqYYwIjwVYsFJSaolhdHr3yxtgiFLBf3qwoQJmUyiK+K8ED9BPJnSEa1+os1xJr0
         a2kOG2fsJxDOntLwpOpzqsCGEYRMDX41zY6RpgMXDae4K3zNAFEBW5f0iQvHvvBMWTpJ
         kasANM/E6rzDHUHck3pkfk+qtO9fkx5kBXhB1vk2XZdFXSLQrldNOC9vxBnPZzOqF6ms
         ZeBh6tNi4eQ63lMUAB99ylbBFhtpNgRSHu5nTaj6mjCYFfHXyvjuuvvWsFv5PlN2qhVE
         8q8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=/DvivhbrHIY4f17iliBHPV/kS4qRh7JJhxcfM6F15FI=;
        b=NMu4ZfUe0bHKDKSCUDN0FfKsZfxENOH40lobEqALYcBkfiP0UL8A8ERWVpGuy2OYoz
         9Ptfqns54kvk/Iedb96Gdn/2g1gRNKNzVbHHmAuXwe/pf6UaByTgiHYhfAb3dd8xr6Bj
         kZ4mOwTJgBL01G4s8dWOnxUPII1yG2CaA04K0tNcgCH3VLFnzpxglyiwO2lmdu7d7yz3
         bAC4e4amirZHkhFI+6J5FTYmWjQeF8Ha/NN5ZENr6Paoiq37vzssVByFL2ZsDfD8rt9x
         ZhQCvh8nYnTyp6yhM6yUcx8uChjRDfAa86cIx4r3Ojo2rDyKjzhqv2H9Ovxznq1XRfu/
         PxkA==
X-Gm-Message-State: AOAM532k/R66ST9zOMqptumRQN0W0ChKEHcJrAbKf7GC+kIuVQmxu+Ft
        1zZmL4fkMTKcza127GXV199iRW2/xP5apDeHwTs=
X-Google-Smtp-Source: ABdhPJyQYqn281mdojFMqETNlLuw4H/1mQrK+zUsXLy7tZTw3i9h2sBlFf+uz6cKqcQ1VNG8G7LO7d29gH3Op8Gm8fc=
X-Received: by 2002:ac8:5bd5:: with SMTP id b21mr6195415qtb.68.1642845044338;
 Sat, 22 Jan 2022 01:50:44 -0800 (PST)
MIME-Version: 1.0
References: <1642649516-15076-1-git-send-email-huangzhaoyang@gmail.com>
In-Reply-To: <1642649516-15076-1-git-send-email-huangzhaoyang@gmail.com>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Sat, 22 Jan 2022 17:50:06 +0800
Message-ID: <CAGWkznEeeSCrL1SiFi1uuWG05LTECYGOnGn6-7Y5zXpUvt+Rag@mail.gmail.com>
Subject: Re: [Resend PATCH v3] psi: fix possible trigger missing in the window
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        Ingo Molnar <mingo@redhat.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sorry for broadcasting here. Is anyone aware of Johannes and Peter's
status? The following patch has been waiting for their comments for a
long time. Are they available recently?  thanks.

On Thu, Jan 20, 2022 at 11:32 AM Huangzhaoyang <huangzhaoyang@gmail.com> wrote:
>
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
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
