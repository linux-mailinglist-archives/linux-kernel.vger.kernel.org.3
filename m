Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76AE34758EB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 13:35:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242542AbhLOMfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 07:35:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242501AbhLOMfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 07:35:21 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF727C06173E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 04:35:21 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id f9so54740329ybq.10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 04:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/PPAsdJy1fvI4IOk7fwhrZPqTZxBHd9OaF3oRGCQhSE=;
        b=W044lgVz7oRByJHiznLwmwuOhHSsIr9WupRS5mvk2WZ9VbtiG5EK3x8N6zldAG079F
         SkUvnhF2zswp6UvcJZEDGkw5ZzrBd8tPuevXvcjR8WZGRP0Vek4u6zRY/B78EnA/w9fl
         vaUDkKJ3IED9TBzE4j+Cm1JI8UHqEUKxfDIc11VzejXBcZlmwf28OLn3zljG5QT29JUq
         c5l/9c8WEz+Btspj0KgGAln22fEFaBV3WhjcDEHAb98qIlJyFPxSoawx5vWbhvY98CLr
         tM3/p0ZROCe+YBgg4vEAL5AmEH0kV4Rr94PT63I9CBl/M4IuUeWl+ZrdpNS4QyK/0/6V
         B0jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/PPAsdJy1fvI4IOk7fwhrZPqTZxBHd9OaF3oRGCQhSE=;
        b=ja8Gy61zkmsItPBGTeHhgz5qo9EwJ713tTNZn0ca/grNPo+QHV39+H0g0ipsfUtIXk
         7oqlBx9hqafwlMxLTKfmMln+6kPFbsPwXwHwqhWyV+P0q53cKQwotDV8ADZ9FThBI93t
         ZjdrL9+G12GDoFGDuiQCPcLc4Z9YehH4cn7z6B/v27J9zeNrUlUk7X3el8O4CqRJ3l7J
         eJQdWilLQCEIhyiWbS94BqCdbw73slsRakYi4os04M8eOxNIqYJPPiqJi76RiPNXgn2C
         ETFToTqIbrubnk7lHo111SpEQfS9m85lzG+ZoU8Uhas+KGBeM7LBmRynbhaZrnj0itfK
         PIQw==
X-Gm-Message-State: AOAM532clAvSUbTnrNZryN3Fi8QcKHR0YnEdJ/BqWhfW7sLc8fv0Pq9K
        oF27z2AKZia6dONDs7wDbniWHD6YtSZy7yuWCPo3RA==
X-Google-Smtp-Source: ABdhPJyxflIhvpUmrJZ5mUXlnXimvj20RtQWT1adLFErhhGflKCG4cbZFFkiqSaQvpBKD6qVNrEcGYUKSk146eY/mL8=
X-Received: by 2002:a25:d157:: with SMTP id i84mr5541033ybg.703.1639571720913;
 Wed, 15 Dec 2021 04:35:20 -0800 (PST)
MIME-Version: 1.0
References: <20211213165342.74704-1-songmuchun@bytedance.com>
 <20211213165342.74704-3-songmuchun@bytedance.com> <YbihOFJHqvQ9hsjO@cmpxchg.org>
In-Reply-To: <YbihOFJHqvQ9hsjO@cmpxchg.org>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 15 Dec 2021 20:34:45 +0800
Message-ID: <CAMZfGtVTztinpOTCAAWW+0Q7SAcGfFW4PVW+bHnFQLN-nDBwSg@mail.gmail.com>
Subject: Re: [PATCH v4 02/17] mm: introduce kmem_cache_alloc_lru
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>, Yang Shi <shy828301@gmail.com>,
        Alex Shi <alexs@kernel.org>,
        Wei Yang <richard.weiyang@gmail.com>,
        Dave Chinner <david@fromorbit.com>,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        jaegeuk@kernel.org, chao@kernel.org,
        Kari Argillander <kari.argillander@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-nfs@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        fam.zheng@bytedance.com, Muchun Song <smuchun@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 9:50 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Tue, Dec 14, 2021 at 12:53:27AM +0800, Muchun Song wrote:
> > +/*
> > + * The allocated list lru pointers array is not accounted directly.
> > + * Moreover, it should not come from DMA buffer and is not readily
> > + * reclaimable. So those GFP bits should be masked off.
> > + */
> > +#define LRUS_CLEAR_MASK      (__GFP_DMA | __GFP_RECLAIMABLE | __GFP_ACCOUNT | __GFP_ZERO)
>
> There is already GFP_RECLAIM_MASK for this purpose, you can use that.

Cool. Thanks.

>
> > +int memcg_list_lru_alloc(struct mem_cgroup *memcg, struct list_lru *lru,
> > +                      gfp_t gfp)
> > +{
> > +     int i;
> > +     unsigned long flags;
> > +     struct list_lru_memcg *mlrus;
> > +     struct list_lru_memcg_table {
> > +             struct list_lru_per_memcg *mlru;
> > +             struct mem_cgroup *memcg;
> > +     } *table;
> > +
> > +     if (!list_lru_memcg_aware(lru) || memcg_list_lru_allocated(memcg, lru))
> > +             return 0;
> > +
> > +     gfp &= ~LRUS_CLEAR_MASK;
>
>         gfp &= GFP_RECLAIM_MASK;
