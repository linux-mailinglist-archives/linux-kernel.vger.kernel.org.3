Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 450654A678F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 23:10:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237396AbiBAWK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 17:10:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbiBAWKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 17:10:55 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B08C061714
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 14:10:55 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id u130so17120189pfc.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 14:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2xHEO6/IBGHMAC/QWKgy3q9RlJbp71AlC0JvRvEV/DE=;
        b=AMBjtxpi2+m2v8BOBUBBFm6evgAA7q21Mi7YpqNmsTNr+KPLlkkvJbAZRkeuTS2E27
         e70+E6dfkmznoSqepcK4TGSZt7l3+P5pQduy7QwipHihcNH+zA670k59ivCOBH8H6ApS
         +bwhjb2dRevjYyZRsKEdHDLv8yED/2cviLvH2/0cz9YWK362fLAZcEwKiLVgqR/5lLPI
         Lh2fd3Y6m4g7lh6072LVTfFRZWVYM3JSZv4tN5L5K+JYVRc60iP0nkmmrW6OBaKhH97d
         leiGTK39Evv2EbTMtjdkGXvoolqhhax44LaZHCXQS7aoaV/+uqPQKqKlzk/6jgcsoXjo
         u9uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2xHEO6/IBGHMAC/QWKgy3q9RlJbp71AlC0JvRvEV/DE=;
        b=3B6fIed0WJ4j4V41sjbpcyjC/poOK8462tpI0ftGPTAWp3rYLnW72AQLkI37b66r+f
         MdmkpBHbhIYI3sNJzA/Fn6KfQe3rYROO0tVLYrSKEHE5LSSzs8sVDp8QHd4nocPb8y/w
         FTonw0aHPUzl+CP/UzJph46Cmw5OPD3vhpol6ceorKjX16omnddqz9Je4+8lp/Vupsh3
         vyfkdWLF7dIoj/i3x0xuIjDxbMWGZjoUXV5HW6rJuIwpR1GPOZXBmhKDpbW5QbVl3Ao4
         lN08FmWPChX6+qwHGoURRVteCs2klyx6B8dCOkInDCtcxFRUjTDh0U4kPszFeqABymuo
         cTdQ==
X-Gm-Message-State: AOAM533bQ1oDmWUUvLjUWfjd0lO97SwT1t5A13Wzhdey4/L1KpWCvD+a
        x/FgTryyotnGVGC/gcBwTdWu0Qbvsjg6dLJoKpswywQk8e8ZfPGQ
X-Google-Smtp-Source: ABdhPJw95Z6BIWNIq4Ux1U5dRo6t0UlChSg6ajpZgF1yoghZAg6I52WPcd0fWNRigZqtiTqKl/OufKTdCeDrFiD3WDY=
X-Received: by 2002:a62:8183:: with SMTP id t125mr26780654pfd.41.1643753454908;
 Tue, 01 Feb 2022 14:10:54 -0800 (PST)
MIME-Version: 1.0
References: <20220201200823.3283171-1-yosryahmed@google.com> <YfmffkUfDGg4g+xt@cmpxchg.org>
In-Reply-To: <YfmffkUfDGg4g+xt@cmpxchg.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 1 Feb 2022 14:10:18 -0800
Message-ID: <CAJD7tkYQReWVG5f-xX8Lr7Yj0ewz4TFkN7uTe6Kkn8LDmp1zXQ@mail.gmail.com>
Subject: Re: [PATCH] memcg: add per-memcg total kernel memory stat
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Shakeel Butt <shakeelb@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Johannes,

Thanks so much for your review.

On Tue, Feb 1, 2022 at 1:00 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> Hello Yosry,
>
> On Tue, Feb 01, 2022 at 08:08:23PM +0000, Yosry Ahmed wrote:
> > Currently memcg stats show several types of kernel memory:
> > kernel stack, page tables, sock, vmalloc, and slab.
> > However, there are other allocations with __GFP_ACCOUNT
> > (or supersets such as GFP_KERNEL_ACCOUNT) that are not accounted
> > in any of those stats, a few examples are:
> > - various kvm allocations (e.g. allocated pages to create vcpus)
> > - io_uring
> > - tmp_page in pipes during pipe_write()
> > - bpf ringbuffers
> > - unix sockets
> >
> > Keeping track of the total kernel memory is essential for the ease of
> > migration from cgroup v1 to v2 as there are large discrepancies between
> > v1's kmem.usage_in_bytes and the sum of the available kernel memory stats
> > in v2. Adding separate memcg stats for all __GFP_ACCOUNT kernel
> > allocations is an impractical maintenance burden as there a lot of those
> > all over the kernel code, with more use cases likely to show up in the
> > future.
>
> No objection, I'm just curious how it makes migration to v2 easier in
> particular. Or is it just that you've used the v1 stat to track
> application regressions and would like to continue doing that in v2?
>

We are using "memory.kmem.usage_in_bytes" in v1 to get the total
kernel memory accounted to a memcg to maintain historical data of jobs
memory (anon, file, kernel), and for debugging purposes. In v2 there
is no equivalent.

We found that the total of other existing v2 kernel memory stats
(vmalloc, slab, stack, ..) is very different for some workloads
compared to v1's "memory.kmem.usage_in_bytes". We need a v2 indicator
of the total kernel memory accounted to a memcg."

> > Therefore, add a "kernel" memcg stat that is analogous to kmem
> > page counter, with added benefits such as using rstat infrastructure
> > which aggregates stats more efficiently. Additionally, this provides a
> > lighter alternative in case the legacy kmem is deprecated in the future
> >
> > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > ---
> >  Documentation/admin-guide/cgroup-v2.rst |  5 +++++
> >  include/linux/memcontrol.h              |  1 +
> >  mm/memcontrol.c                         | 24 ++++++++++++++++++------
> >  3 files changed, 24 insertions(+), 6 deletions(-)
> >
> > diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> > index 5aa368d165da..a0027d570a7f 100644
> > --- a/Documentation/admin-guide/cgroup-v2.rst
> > +++ b/Documentation/admin-guide/cgroup-v2.rst
> > @@ -1317,6 +1317,11 @@ PAGE_SIZE multiple when read back.
> >         vmalloc (npn)
> >               Amount of memory used for vmap backed memory.
> >
> > +       kernel (npn)
> > +             Amount of total kernel memory, including
> > +             (kernel_stack, pagetables, percpu, vmalloc, slab) in
> > +             addition to other kernel memory use cases.
> > +
> >         shmem
> >               Amount of cached filesystem data that is swap-backed,
> >               such as tmpfs, shm segments, shared anonymous mmap()s
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index b72d75141e12..fa51986365a4 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -34,6 +34,7 @@ enum memcg_stat_item {
> >       MEMCG_SOCK,
> >       MEMCG_PERCPU_B,
> >       MEMCG_VMALLOC,
> > +     MEMCG_KMEM,
> >       MEMCG_NR_STAT,
> >  };
> >
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 09d342c7cbd0..c55d7056ac98 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -1376,6 +1376,7 @@ static const struct memory_stat memory_stats[] = {
> >       { "percpu",                     MEMCG_PERCPU_B                  },
> >       { "sock",                       MEMCG_SOCK                      },
> >       { "vmalloc",                    MEMCG_VMALLOC                   },
> > +     { "kernel",                     MEMCG_KMEM                      },
>
> It's a superset of percpu, sock, vmalloc etc., so please move it ahead
> of them.
>
>         anon
>         file
>         kernel
>         kernel_stack
>         pagetables
>         ...
>
> and in the doc as well.
>

Done in v2.

> >       { "shmem",                      NR_SHMEM                        },
> >       { "file_mapped",                NR_FILE_MAPPED                  },
> >       { "file_dirty",                 NR_FILE_DIRTY                   },
> > @@ -2979,6 +2980,19 @@ static void memcg_free_cache_id(int id)
> >       ida_simple_remove(&memcg_cache_ida, id);
> >  }
> >
> > +static void mem_cgroup_kmem_record(struct mem_cgroup *memcg,
> > +                                int nr_pages)
>
> No real need for the namespace prefix since it's a static
> function. How about account_kmem()? Avoids the line wrap, too.

Does memcg_account_kmem() sound good? It avoids the line wrap too and
is more consistent with most static functions in the file that have
either a "memcg_" or "mem_cgroup_" prefix.

Thanks!

>
> Otherwise, looks good to me, so with those changes:
>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
>
> Thanks!
