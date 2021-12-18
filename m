Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B607479918
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 07:03:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232146AbhLRGD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 01:03:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbhLRGDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 01:03:25 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 005C0C061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 22:03:24 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id g28so4344558qkk.9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 22:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=JkH82Y5mSBqKmWXWre7SqOOoFhR5WDoFjJYNZaqCJjU=;
        b=fnQATQtlokIbwbZKwvBtTPl5gtKIDf8rgl9Trcy/HIt7VimXJ5mF38W3tEevaz1blq
         ljFS3dom7VzkvhwXD+IYMY1AmSJcEkMlRWbo/SZQFSw4lhNtaVipD7HPK+8ENctRukiC
         DAJg+sunC05JDUakBNmyD+8z0j5UZKw53sZanj40UBhVmeP1eX5EBOHlDsuISr/XM+ip
         B0SzKcedT8EiDIA0gyMvYWAzO+O+0nc19SPKOPigso9A06uZIe/axbgU0DkuR2l3r+w3
         gqyV5qfdX3kejorASSArarsw/BMxP/IwT72NsXngUKeBI9n5Z+V03Enutp2VOH+b3SBc
         ihBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=JkH82Y5mSBqKmWXWre7SqOOoFhR5WDoFjJYNZaqCJjU=;
        b=dwnztEMPhVrPqOB0l67Q5lOugEF4h26dIM2LCoqmNTJr2LwZh9zXLuHXHH8VbRN2Ys
         U0B1HbR59ASZc0kMGva+uDRxReOTa6NBuvhdmIXuW7xXj9cUS04QnLrIWOodsSoCL5SF
         x1EtKefArcGTsI6EbUCBloYv4qf7P36Vxk+E7IcmVrmoslumaYIvLQTuIRbEouOJfgpm
         9c8peXVPgnihLF8F6KqIIKFhycUlTRemcTatRRXABmzR37ZBKVaxm/v7q4CyQew9Pgvg
         koocc6pCvRUjXw6Ktz/TVYuuJl3A9ibl3jtKwIpnpxJcs1ITi+4RRBuqmY1eHqF4UvY5
         4CfQ==
X-Gm-Message-State: AOAM533VBU2sm/tMvTXN22dluPTKpuAArzhQ43NknGE3hdzufG86IXpr
        lCwaEFt0lmct+jaZwwTIh8ssu2Y0yqSfIlotCUs=
X-Google-Smtp-Source: ABdhPJy8j3DUO3jo5bHvJpMUrHYMHtyKfmCM/5grz4jgJPYMfHOBkhofwLTSJu/WUbetOaml8FyrTVOXEOUut8ztlLg=
X-Received: by 2002:a05:620a:1713:: with SMTP id az19mr3939566qkb.297.1639807404165;
 Fri, 17 Dec 2021 22:03:24 -0800 (PST)
MIME-Version: 1.0
References: <1639721264-12294-1-git-send-email-huangzhaoyang@gmail.com>
In-Reply-To: <1639721264-12294-1-git-send-email-huangzhaoyang@gmail.com>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Sat, 18 Dec 2021 14:03:04 +0800
Message-ID: <CAGWkznGdvLobshPvg2KY+D71Zh0625+V=WsAS9uExRspRFFjVQ@mail.gmail.com>
Subject: Re: [PATCH] psi: fix possible trigger missing in the window
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Suren Baghdasaryan <surenb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

loop Suren

On Fri, Dec 17, 2021 at 2:08 PM Huangzhaoyang <huangzhaoyang@gmail.com> wrote:
>
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
>
> There could be missing wake up if the rest of the window remain the
> same stall states as the polling_total updates for every polling_min_period.
>
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> ---
>  include/linux/psi_types.h |  2 ++
>  kernel/sched/psi.c        | 30 ++++++++++++++++++------------
>  2 files changed, 20 insertions(+), 12 deletions(-)
>
> diff --git a/include/linux/psi_types.h b/include/linux/psi_types.h
> index 0a23300..9533d2e 100644
> --- a/include/linux/psi_types.h
> +++ b/include/linux/psi_types.h
> @@ -132,6 +132,8 @@ struct psi_trigger {
>
>         /* Refcounting to prevent premature destruction */
>         struct kref refcount;
> +
> +       bool new_stall;
>  };
>
>  struct psi_group {
> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> index 1652f2b..402718c 100644
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -458,9 +458,12 @@ static void psi_avgs_work(struct work_struct *work)
>  static void window_reset(struct psi_window *win, u64 now, u64 value,
>                          u64 prev_growth)
>  {
> +       struct psi_trigger *t = container_of(win, struct psi_trigger, win);
> +
>         win->start_time = now;
>         win->start_value = value;
>         win->prev_growth = prev_growth;
> +       t->new_stall = false;
>  }
>
>  /*
> @@ -515,7 +518,6 @@ static void init_triggers(struct psi_group *group, u64 now)
>  static u64 update_triggers(struct psi_group *group, u64 now)
>  {
>         struct psi_trigger *t;
> -       bool new_stall = false;
>         u64 *total = group->total[PSI_POLL];
>
>         /*
> @@ -523,19 +525,26 @@ static u64 update_triggers(struct psi_group *group, u64 now)
>          * watchers know when their specified thresholds are exceeded.
>          */
>         list_for_each_entry(t, &group->triggers, node) {
> -               u64 growth;
> -
>                 /* Check for stall activity */
>                 if (group->polling_total[t->state] == total[t->state])
>                         continue;
>
>                 /*
> -                * Multiple triggers might be looking at the same state,
> -                * remember to update group->polling_total[] once we've
> -                * been through all of them. Also remember to extend the
> -                * polling time if we see new stall activity.
> +                * update the trigger if there is new stall which will be
> +                * reset when run out of the window
>                  */
> -               new_stall = true;
> +               t->new_stall = true;
> +
> +               memcpy(&group->polling_total[t->state], &total[t->state],
> +                               sizeof(group->polling_total[t->state]));
> +       }
> +
> +       list_for_each_entry(t, &group->triggers, node) {
> +               u64 growth;
> +
> +               /* check if new stall happened during this window*/
> +               if (!t->new_stall)
> +                       continue;
>
>                 /* Calculate growth since last update */
>                 growth = window_update(&t->win, now, total[t->state]);
> @@ -552,10 +561,6 @@ static u64 update_triggers(struct psi_group *group, u64 now)
>                 t->last_event_time = now;
>         }
>
> -       if (new_stall)
> -               memcpy(group->polling_total, total,
> -                               sizeof(group->polling_total));
> -
>         return now + group->poll_min_period;
>  }
>
> @@ -1152,6 +1157,7 @@ struct psi_trigger *psi_trigger_create(struct psi_group *group,
>         t->last_event_time = 0;
>         init_waitqueue_head(&t->event_wait);
>         kref_init(&t->refcount);
> +       t->new_stall = false;
>
>         mutex_lock(&group->trigger_lock);
>
> --
> 1.9.1
>
