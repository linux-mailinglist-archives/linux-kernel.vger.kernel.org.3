Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0976477D65
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 21:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241389AbhLPUVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 15:21:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31033 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232532AbhLPUVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 15:21:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639686081;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UROZJHfxiAlJ7HASqgNbTv6n7Grg5ftbDdoCWDIq/Qw=;
        b=h+T5lKdxe7qtUbGnVt1rVrRsJvYelvZhhoqY2Qg5BJZ7Z0pWo1XEyYakVt89QUX2Cqu3O4
        wxSE7UKsIZXiPoJ89zUjDzmzN0Wtldnfs3vE/orAhEuMLGixB7P/o5+ZxHip16ctD9uXBR
        eXEO+DgMNwSrJT75QircTurKi3zx2DU=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-232-SAAUjkIyPRCsqIIc1nb6fg-1; Thu, 16 Dec 2021 15:21:20 -0500
X-MC-Unique: SAAUjkIyPRCsqIIc1nb6fg-1
Received: by mail-ed1-f70.google.com with SMTP id t2-20020a056402524200b003f7ed6cf4f1so5260285edd.21
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 12:21:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UROZJHfxiAlJ7HASqgNbTv6n7Grg5ftbDdoCWDIq/Qw=;
        b=XIytaKVSJACxej6Z2Jk5icbNi9lb4H4vdEYDH7LEToj112/WRyu4Oalfo3TIOdSxy8
         n4LJIgGvYdREbUwReAjOeq1aeVpmns8bIbjAWunwMESUOiZjaDHzLZT0Zwp02wFxurHg
         6BGHlfnDAbs1xC/KlPgoVRWj0+5ZkO9Afe23x7ByphsiwO1muP6ohUmg2xkTzHjrVNtG
         vOnq9iWCdLlc8Eq7mhGMbRnPbQuwlr9D/LyuUGFgrgLcEnwR89rYUtttgJR7mUXRGEK4
         18Mosbc2hf7qxF3ZKZCDbTkfgoio1fboRIHm7Xl4aJ8ve/zBRshtWMnGmJWJcYiYteHI
         oztg==
X-Gm-Message-State: AOAM533wOJxbXjO5n5sDfNuB/oH/r9uo6wJJzIqQjypirqG43MedNlGV
        zlsGg2wSNZNHqAVcyf8Iam+cGQ2yS5IHWlS7M8dDby9wvGlDKlPhwWnrwoAqvR5SQkmzPMu/6pr
        hEBf9rdYNi1cwHWnVv2xgxf68Izu7nHKQIp2xPpH5
X-Received: by 2002:a17:906:c155:: with SMTP id dp21mr17124278ejc.450.1639686078667;
        Thu, 16 Dec 2021 12:21:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzl1b6zX5KpLf73/C8bWNIU7WQ2dUHtDcImZYamSAV6mETbxVK3ZyK0dBVUhGLNsZu4IC10XTg346c1J3Bk/9w=
X-Received: by 2002:a17:906:c155:: with SMTP id dp21mr17124255ejc.450.1639686078320;
 Thu, 16 Dec 2021 12:21:18 -0800 (PST)
MIME-Version: 1.0
References: <20211213123737.9147-1-wander@redhat.com> <20211213123737.9147-2-wander@redhat.com>
 <YboeqlSsoFRbjEv2@linutronix.de>
In-Reply-To: <YboeqlSsoFRbjEv2@linutronix.de>
From:   Wander Costa <wcosta@redhat.com>
Date:   Thu, 16 Dec 2021 17:21:07 -0300
Message-ID: <CAAq0SUkamkGvcBWpSwuZ6brFw=7qnmiE8huX6xEE643ohBVuZQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] block: Avoid sleeping function called from invalid
 context bug
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Wander Lairson Costa <wander@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021 at 1:58 PM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2021-12-13 09:37:36 [-0300], Wander Lairson Costa wrote:
> > ---
> >  block/blk-cgroup.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> > index 663aabfeba18..0a532bb3003c 100644
> > --- a/block/blk-cgroup.c
> > +++ b/block/blk-cgroup.c
> > @@ -1911,7 +1911,7 @@ void blk_cgroup_bio_start(struct bio *bio)
> >       struct blkg_iostat_set *bis;
> >       unsigned long flags;
> >
> > -     cpu = get_cpu();
> > +     cpu = get_cpu_light();
> >       bis = per_cpu_ptr(bio->bi_blkg->iostat_cpu, cpu);
> >       flags = u64_stats_update_begin_irqsave(&bis->sync);
> >
> > @@ -1928,7 +1928,7 @@ void blk_cgroup_bio_start(struct bio *bio)
> >       u64_stats_update_end_irqrestore(&bis->sync, flags);
> >       if (cgroup_subsys_on_dfl(io_cgrp_subsys))
> >               cgroup_rstat_updated(bio->bi_blkg->blkcg->css.cgroup, cpu);
> > -     put_cpu();
> > +     put_cpu_light();
> >  }
>
> Are you sure patch and backtrace match? There is also
> u64_stats_update_begin_irqsave() which disables preemption on RT. So by
> doing what you are suggesting, you only avoid disabling preemption in
> cgroup_rstat_updated() which acquires a raw_spinlock_t.
>

You're right. I double-checked and noticed my tree didn't have the
call to u64_stats_update_begin_irqsave. Only patch 2 is necessary
indeed.

> Sebastian
>

