Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E31F9489E06
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 18:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237927AbiAJRJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 12:09:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31045 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237655AbiAJRJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 12:09:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641834597;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tBR8KnvX63pvs+Mv7Kb2j3m653wYDjd5gSjSGP6dBRs=;
        b=THOtJVuBSQgwy8HUoph4Aymft8xrFgbvuuD3gtEDFKDs+0ebbNX98KeQJDbjgWhXVSIqiU
        PgWWzRAp6aKnS8SYhnrMzGiK/xRaX9w2j8AdqobcI/ms85WLJGVnbGGABPuodyDFox7XSG
        kIk9QSGNlyRO7RFaQvqM3hmkgWdK7/8=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-586-O3WVMwWEPZ63eKumOIuQhg-1; Mon, 10 Jan 2022 12:09:56 -0500
X-MC-Unique: O3WVMwWEPZ63eKumOIuQhg-1
Received: by mail-oi1-f200.google.com with SMTP id s127-20020aca5e85000000b002c807e9c48aso6989072oib.10
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 09:09:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tBR8KnvX63pvs+Mv7Kb2j3m653wYDjd5gSjSGP6dBRs=;
        b=ZBAqVLtRiblTmFEz9BLtefUQtOaY/XnkDdK7f72ERY1GHobim8w8mCr0B+ug/NWmSY
         SBYCCWgrOCSv+zl5a0VHXr0UAv0JzplvkEuJJKoWjP+ARiRPOq72MBdFwiaRegL56zbX
         Wy9s2LlPE5rQfZBe0Qh7AbDJxbaOcGFcameA6FB2xAchvBl7pvZXi3RD/7HwG2VneEk8
         KhRFrn2OuCmNCi54KxeqYO4040VsiQ23GUkRRjKrKLORhC/bDMUHRF7UB/d+UaMbniVx
         HKOzYOZ0mvHkEXTviIvYpccN2b1LLRuA/swKJPCXsIjOX8t8O4CIXgwqLUO0t76pZ//B
         f/xg==
X-Gm-Message-State: AOAM533Er2V19GmfGx6AhmDEGD52rYfEu3l1TNNe/2UiCaW8tNusWboJ
        PPY8a8Qa0QcRbwHVCYE+joHLa25yxUXZ3nsqgIGzmLWESNsg3dos9xQwgaFYSowqscknIgub1oT
        5I8cA10fnERn9Qq4YD7Ar3uMZ
X-Received: by 2002:a9d:7d99:: with SMTP id j25mr565811otn.252.1641834594152;
        Mon, 10 Jan 2022 09:09:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwmX+24PBb8HyPbtQL8beByYwrkmR0B9Wexnr9flf86/F/kvxiYcT4yZ3RwPWsBHgabHSSqzQ==
X-Received: by 2002:a9d:7d99:: with SMTP id j25mr565787otn.252.1641834593854;
        Mon, 10 Jan 2022 09:09:53 -0800 (PST)
Received: from optiplex-fbsd (c-73-182-255-193.hsd1.nh.comcast.net. [73.182.255.193])
        by smtp.gmail.com with ESMTPSA id f9sm1536135oto.56.2022.01.10.09.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 09:09:53 -0800 (PST)
Date:   Mon, 10 Jan 2022 12:09:50 -0500
From:   Rafael Aquini <aquini@redhat.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nico Pache <npache@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Shakeel Butt <shakeelb@google.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, raquini@redhat.com,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2 1/1] mm/vmscan.c: Prevent allocating shrinker_info on
 offlined nodes
Message-ID: <YdxoXhTqCmVrT0R5@optiplex-fbsd>
References: <20211207224013.880775-1-npache@redhat.com>
 <20211207224013.880775-2-npache@redhat.com>
 <20211207154438.c1e49a3f0b5ebc9245aac61b@linux-foundation.org>
 <CAHbLzkoCds-WOoN5CKas4DThk8hU65pgtMcga10QEqEmKU2f5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbLzkoCds-WOoN5CKas4DThk8hU65pgtMcga10QEqEmKU2f5A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2021 at 04:26:28PM -0800, Yang Shi wrote:
> On Tue, Dec 7, 2021 at 3:44 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Tue,  7 Dec 2021 17:40:13 -0500 Nico Pache <npache@redhat.com> wrote:
> >
> > > We have run into a panic caused by a shrinker allocation being attempted
> > > on an offlined node.
> > >
> > > Our crash analysis has determined that the issue originates from trying
> > > to allocate pages on an offlined node in expand_one_shrinker_info. This
> > > function makes the incorrect assumption that we can allocate on any node.
> > > To correct this we make sure the node is online before tempting an
> > > allocation. If it is not online choose the closest node.
> >
> > This isn't fully accurate, is it?  We could allocate on a node which is
> > presently offline but which was previously onlined, by testing
> > NODE_DATA(nid).
> >
> > It isn't entirely clear to me from the v1 discussion why this approach
> > isn't being taken?
> >
> > AFAICT the proposed patch is *already* taking this approach, by having
> > no protection against a concurrent or subsequent node offlining?
> 
> AFAICT, we have not reached agreement on how to fix it yet. I saw 3
> proposals at least:
> 
> 1. From Michal, allocate node data for all possible nodes.
> https://lore.kernel.org/all/Ya89aqij6nMwJrIZ@dhcp22.suse.cz/T/#u
> 
> 2. What this patch does. Proposed originally from
> https://lore.kernel.org/all/20211108202325.20304-1-amakhalov@vmware.com/T/#u
>

This patch doesn't cut it, because it only fixes up one caller. The issue,
however, boils down to any iteration like

...
   for_each_possible_cpu(cpu) {
      struct page *page = alloc_pages_node(cpu_to_node(cpu), gfp, 0);
...

where topology allows for possible cpus in yet-to-be-online node to
cause node_zonelist() to produce a bogus zonelist pointer when
populating ac->zonelist within prepare_alloc_pages().

I just bisected the following commit causing a PPC host to crash
at boot, when initializing the cgoup subsystem:

    commit bd0e7491a931f5a2960555b10b9551464ff8cc8e
    Author: Vlastimil Babka <vbabka@suse.cz>
    Date:   Sat May 22 01:59:38 2021 +0200

        mm, slub: convert kmem_cpu_slab protection to local_lock

The commit, obviously is not responsible for the crash, and the only "sin" 
committed by commit bd0e7491a93 as far as the crash issue is concerned is to
increase the size of struct kmem_cache_cpu size with one local_lock_t, which
in the worst case scenario -- !CONFIG_PREEMPT_RT && CONFIG_DEBUG_LOCK_ALLOC --
will end up creating an overhead of 56 bytes for each kmem_cache_cpu created,
burning faster through the bootstrap pre-allocated embedded per-cpu pool.

---8<---
[    0.001888] BUG: Kernel NULL pointer dereference on read at 0x00001508
[    0.001900] Faulting instruction address: 0xc0000000005277fc
[    0.001905] Oops: Kernel access of bad area, sig: 11 [#1]
[    0.001909] LE PAGE_SIZE=64K MMU=Hash SMP NR_CPUS=2048 NUMA pSeries
[    0.001915] Modules linked in:
[    0.001919] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.14.0+ #24
[    0.001925] NIP:  c0000000005277fc LR: c0000000005276d8 CTR: 0000000000000000
[    0.001930] REGS: c000000002c936d0 TRAP: 0380   Not tainted  (5.14.0+)
[    0.001935] MSR:  8000000002009033 <SF,VEC,EE,ME,IR,DR,RI,LE>  CR: 24024222  XER: 00000002
[    0.001948] CFAR: c0000000005276e0 IRQMASK: 0
[    0.001948] GPR00: c0000000005276d8 c000000002c93970 c000000002c95500 0000000000001500
[    0.001948] GPR04: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
[    0.001948] GPR08: 0000000000000081 0000000000000001 0000000000001500 0000000044024222
[    0.001948] GPR12: 00000003fa6a0000 c0000000049d0000 0000000000000000 c0000000053f0780
[    0.001948] GPR16: 0000000000000000 0000000000000000 0000000000000008 c000000002cec160
[    0.001948] GPR20: 0000000000000000 0000000000000cc2 c000000002cf0a30 c000000002cf02c0
[    0.001948] GPR24: 0000000000000001 0000000000000001 0000000000000000 0000000000000000
[    0.001948] GPR28: 0000000000000000 c000000002c939e8 c000000002c939f0 0000000000000000
[    0.002007] NIP [c0000000005277fc] prepare_alloc_pages.constprop.0+0x20c/0x280
[    0.002014] LR [c0000000005276d8] prepare_alloc_pages.constprop.0+0xe8/0x280
[    0.002020] Call Trace:
[    0.002022] [c000000002c93970] [c0000000005276c4] prepare_alloc_pages.constprop.0+0xd4/0x280 (unreliable)
[    0.002030] [c000000002c939c0] [c000000000531270] __alloc_pages+0xb0/0x3b0
[    0.002036] [c000000002c93a50] [c0000000004cd4d4] pcpu_alloc_pages.constprop.0+0x144/0x2a0
[    0.002044] [c000000002c93ae0] [c0000000004cd714] pcpu_populate_chunk+0x64/0x2b0
[    0.002050] [c000000002c93b90] [c0000000004d1a14] pcpu_alloc+0x944/0xd80
[    0.002056] [c000000002c93cb0] [c0000000005abcd4] mem_cgroup_alloc+0x144/0x470
[    0.002063] [c000000002c93d30] [c0000000005bcedc] mem_cgroup_css_alloc+0xac/0x390
[    0.002070] [c000000002c93d80] [c00000000203181c] cgroup_init_subsys+0xf4/0x260
[    0.002078] [c000000002c93e30] [c000000002031d40] cgroup_init+0x1f4/0x528
[    0.002085] [c000000002c93f00] [c0000000020051ec] start_kernel+0x64c/0x6b0
[    0.002091] [c000000002c93f90] [c00000000000d39c] start_here_common+0x1c/0x600
[    0.002098] Instruction dump:
[    0.002101] 61280080 2c0a0001 7d28489e 913d0000 57ffa7fe 9bfe0020 809e001c e8be0008
[    0.002112] e87e0000 2c250000 7c6a1b78 40820058 <81230008> 7c044840 4180004c f95e0010
[    0.002124] ---[ end trace 7392155448beabaa ]---
[    0.002127]
[    1.002133] Kernel panic - not syncing: Attempted to kill the idle task!
[    1.002195] ------------[ cut here ]------------
--->8---


> 3. From David, fix in node_zonelist().
> https://lore.kernel.org/all/51c65635-1dae-6ba4-daf9-db9df0ec35d8@redhat.com/T/#u

It seems to me that (3) is the simplest and effective way to cope with this case

Cheers,
-- Rafael

> >
> > > --- a/mm/vmscan.c
> > > +++ b/mm/vmscan.c
> > > @@ -222,13 +222,16 @@ static int expand_one_shrinker_info(struct mem_cgroup *memcg,
> > >       int size = map_size + defer_size;
> > >
> > >       for_each_node(nid) {
> > > +             int tmp = nid;
> >
> > Not `tmp', please.  Better to use an identifier which explains the
> > variable's use.  target_nid?
> >
> > And a newline after defining locals, please.
> >
> > >               pn = memcg->nodeinfo[nid];
> > >               old = shrinker_info_protected(memcg, nid);
> > >               /* Not yet online memcg */
> > >               if (!old)
> > >                       return 0;
> > >
> > > -             new = kvmalloc_node(sizeof(*new) + size, GFP_KERNEL, nid);
> > > +             if(!node_online(nid))
> >
> > s/if(/if (/
> >
> > > +                     tmp = numa_mem_id();
> > > +             new = kvmalloc_node(sizeof(*new) + size, GFP_KERNEL, tmp);
> > >               if (!new)
> > >                       return -ENOMEM;
> > >
> >
> > And a code comment fully explaining what's going on here?
> 

