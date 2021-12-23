Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48C0347E736
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 18:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244509AbhLWRom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 12:44:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbhLWRol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 12:44:41 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E86CC061401
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 09:44:40 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id h2so3351241lfv.9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 09:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kCoqrpzyBTBAFkNQrSL2lVl577ZYSazg2YApIhci1P8=;
        b=aioqg8kANp4+1uEKiPqYO+5fpB6qLkCWQE0myDscDMWPzrYaWPb3VcyvoNkHLs8w4O
         8UdnMsOLsUZOZ5qMWk1T9tKCPyh/JiIGsOfPNvARKvuJN29Z/loSRdlHOW2T5F3Yu5mU
         37qnWrsJzPSQiI6zrZlH9FyjNWKG+MkTqP5/8pgnSb5HlEduDtzE5bmDU3lX6qfCLzwm
         fcthTEfWb18Hsk6xt/4uIjgCktjTT7Afh/OV3l81d8ewNE5FnaGjg3NIB/BbGWqMW702
         2ch7M8Y77CnA9ITiNWeoAl3vVnZfLN9DfyIYR3+Jow67d9JtXMXBR8o+d5y1yDszkWBx
         wY/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kCoqrpzyBTBAFkNQrSL2lVl577ZYSazg2YApIhci1P8=;
        b=XqPNeFiw6JThJOuQNspLZoyP/fiSEjSL8xLAO0oRxC2v0nnesnHdEY1svLAZFwB2jX
         NlQuuqdgExDZBHaQZMO24VSAMaoX3NCQfLf3pcWODEADC/sYkooN9Ps3Yp8/Nku3JG/E
         kMA7snnnk0AOcB3agLVI5xgvRZk6e0Mk99Z0hxAt92z2BgcMl9XuTIHaQxgtcoBlSRfb
         yM7ZNiagZRb4vxAPmTldOiiAJU1gIFCNjuijY31szRthzsGr17i0WjTTlPFCLkTGWnos
         GbrKf5zDquqwTHWy1s/YZNGbdb0A4LbMmlWl/POpqUwLEmL+jl/V7lUZ03TukrGbLaWP
         ESdQ==
X-Gm-Message-State: AOAM5307OIvY0uXf9Ehr/O5zvjwQBWvKgg4GsAB0GPJCdFxYOv/YaxQI
        DM+oFuSB9zlgY9oCU1fe/BDcdCTUkYBxN/ntPyjWDg==
X-Google-Smtp-Source: ABdhPJy25Zli9adXeJWapHOtWu1NDXAb0yFFA4Ygsp2oTCsoL5rExYDN/IoG7gZUh26uFgieRbiFcwrOJbwzhY3YL+Q=
X-Received: by 2002:a05:6512:3d9e:: with SMTP id k30mr2478976lfv.184.1640281478363;
 Thu, 23 Dec 2021 09:44:38 -0800 (PST)
MIME-Version: 1.0
References: <20211222052457.1960701-1-shakeelb@google.com> <YcPYz4N0sXEVFaJA@carbon.dhcp.thefacebook.com>
In-Reply-To: <YcPYz4N0sXEVFaJA@carbon.dhcp.thefacebook.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 23 Dec 2021 09:44:26 -0800
Message-ID: <CALvZod4HWG2+8WF6=OVwst1S205Z_3gB=AtbvnQ7jDpmFt0iZg@mail.gmail.com>
Subject: Re: [PATCH v2] memcg: add per-memcg vmalloc stat
To:     Roman Gushchin <guro@fb.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 6:03 PM Roman Gushchin <guro@fb.com> wrote:
>
> On Tue, Dec 21, 2021 at 09:24:57PM -0800, Shakeel Butt wrote:
> > The kvmalloc* allocation functions can fallback to vmalloc allocations
> > and more often on long running machines. In addition the kernel does
> > have __GFP_ACCOUNT kvmalloc* calls. So, often on long running machines,
> > the memory.stat does not tell the complete picture which type of memory
> > is charged to the memcg. So add a per-memcg vmalloc stat.
> >
> > Signed-off-by: Shakeel Butt <shakeelb@google.com>
> >
> > ---
> > Changelog since v1:
> > - page_memcg() within rcu lock as suggested by Muchun.
> >
> >  Documentation/admin-guide/cgroup-v2.rst |  3 +++
> >  include/linux/memcontrol.h              | 21 +++++++++++++++++++++
> >  mm/memcontrol.c                         |  1 +
> >  mm/vmalloc.c                            |  5 +++++
> >  4 files changed, 30 insertions(+)
> >
> > diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> > index 82c8dc91b2be..5aa368d165da 100644
> > --- a/Documentation/admin-guide/cgroup-v2.rst
> > +++ b/Documentation/admin-guide/cgroup-v2.rst
> > @@ -1314,6 +1314,9 @@ PAGE_SIZE multiple when read back.
> >         sock (npn)
> >               Amount of memory used in network transmission buffers
> >
> > +       vmalloc (npn)
> > +             Amount of memory used for vmap backed memory.
> > +
>
> It's a bid sad that this counter will partially intersect with others
> (e.g. percpu and stack), but I don't see how it can be easily fixed.

I checked those again. For vmap based stack we do vmalloc() without
__GFP_ACCOUNT and charge the stack page afterwards with
memcg_kmem_charge_page() interface.

I think we do the same for percpu as well i.e. not use GFP_ACCOUNT for
underlying memory but later use objcg infrastructure to charge at
finer grain.

So, I think at least percpu and stack should not intersect with
vmalloc per-memcg stat.

>
> But I agree that the counter is useful and worth adding.
>
> Acked-by: Roman Gushchin <guro@fb.com>

Thanks.
