Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8C4509298
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 00:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354429AbiDTWY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 18:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353886AbiDTWYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 18:24:25 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D4A39BB3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 15:21:38 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id b7so3093153plh.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 15:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J+3TZrmgsd10xjKjh55vuRPI46+lAlZjLqxT3fkPnkM=;
        b=FvUoKoCF17LOFBW/3Qi5eAQLo8bwnT77xjsSkruxm15I7WLMnrxV92REYV2Vsseo/B
         tnHNCZN2x6eJgFvJuSYOdn9X2zTuWdGVp0Aitc2CAuBBB8fX9jN6DC1AjL6dTPUcp9cT
         Nw8lfA8sbcShKXsrje+yjg3SE0oY+w9m7kKmcUr15s5GXg+5VHXdM7MyZ9vWwalrpJOc
         cMA9Fv2gywIHURORBf5Wr9mSGxFZoHW3312GZ2HV89Bs5duu4PU5wKDFnrY+Sl7ayGqE
         RILEQN/dIiVG+ntwX50hC1FxNByPeROatXSSfvsOhxNmETETlZkdd7RlQ3yJVD2rmwj2
         V/ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J+3TZrmgsd10xjKjh55vuRPI46+lAlZjLqxT3fkPnkM=;
        b=p+E7W/2rn6Nf1ekJoRvh11OKABnlLKPPr/rY+Dk+kK0SLQhYaakKMAUdy/AKnsOfK1
         hNqimyfbrYMKkWVFyg7rb4qDHr3pXfvA1BzyJubRQ+5IbgWzfBmumwqbkvbe/CFF+kga
         rO201m/g4wYb2jIHRcCZGDLLPUnMCjLo6NhSSExBuCrmFCHP71A582ybAvps+/+L5fa1
         U/PgQVMC2csSJVCRPHrt6bC7DCcUR9XBFo4pdp5Pmnnre/InpGZ+BMvVFFqeK7GDj51Q
         D6xBnaOgLT7KYFQkhLkQ8kg07hjnmGmFfgwIWJBTLzscvAtibn1TafbkJ4Fv76pqujsP
         szAQ==
X-Gm-Message-State: AOAM5326slsi+LH9fh+daoT/KoM9ircU/527dyvwkfraoED2bRQIxV5Z
        A05+jgHhstw+3lxPF6Q1zZCSAV+AW/ul0Zaf9bE=
X-Google-Smtp-Source: ABdhPJy574m3C4A6IPzDDPlLPM6v9dTjkP3tPTpH/rL2uyQn6bOMCkoHQTKGDvdzb1dRXoeBDJw+mW+oVADG4AesBcI=
X-Received: by 2002:a17:90a:5298:b0:1ca:7fb3:145 with SMTP id
 w24-20020a17090a529800b001ca7fb30145mr6850911pjh.200.1650493297774; Wed, 20
 Apr 2022 15:21:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220407020953.475626-1-shy828301@gmail.com> <Yk6cutNf5sOuYbDl@ziqianlu-nuc9qn>
 <CAHbLzkq+eKcKCsxXDTiOcBxk8FjMdWBqOxwi4N_NG7PZWbAAkA@mail.gmail.com> <Yl/FS9enAD4V8jG3@ziqianlu-nuc9qn>
In-Reply-To: <Yl/FS9enAD4V8jG3@ziqianlu-nuc9qn>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 20 Apr 2022 15:21:25 -0700
Message-ID: <CAHbLzkobQ4pn57LPe8neo-TUeVHcueSpEC1hm_9DZ0yaKgc41w@mail.gmail.com>
Subject: Re: [PATCH] mm: swap: determine swap device by using page nid
To:     Aaron Lu <aaron.lu@intel.com>
Cc:     Huang Ying <ying.huang@intel.com>, Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 1:33 AM Aaron Lu <aaron.lu@intel.com> wrote:
>
> On Thu, Apr 07, 2022 at 10:36:54AM -0700, Yang Shi wrote:
> > On Thu, Apr 7, 2022 at 1:12 AM Aaron Lu <aaron.lu@intel.com> wrote:
> > >
> > > On Wed, Apr 06, 2022 at 07:09:53PM -0700, Yang Shi wrote:
> > > > The swap devices are linked to per node priority lists, the swap device
> > > > closer to the node has higher priority on that node's priority list.
> > > > This is supposed to improve I/O latency, particularly for some fast
> > > > devices.  But the current code gets nid by calling numa_node_id() which
> > > > actually returns the nid that the reclaimer is running on instead of the
> > > > nid that the page belongs to.
> > > >
> > >
> > > Right.
> > >
> > > > Pass the page's nid dow to get_swap_pages() in order to pick up the
> > > > right swap device.  But it doesn't work for the swap slots cache which
> > > > is per cpu.  We could skip swap slots cache if the current node is not
> > > > the page's node, but it may be overkilling. So keep using the current
> > > > node's swap slots cache.  The issue was found by visual code inspection
> > > > so it is not sure how much improvement could be achieved due to lack of
> > > > suitable testing device.  But anyway the current code does violate the
> > > > design.
> > > >
> > >
> > > I intentionally used the reclaimer's nid because I think when swapping
> > > out to a device, it is faster when the device is on the same node as
> > > the cpu.
> >
> > OK, the offline discussion with Huang Ying showed the design was to
> > have page's nid in order to achieve better I/O performance (more
> > noticeable on faster devices) since the reclaimer may be running on a
> > different node from the reclaimed page.
> >
> > >
> > > Anyway, I think I can make a test case where the workload allocates all
> > > its memory on the remote node and its workingset memory is larger then
> > > the available memory so swap is triggered, then we can see which way
> > > achieves better performance. Sounds reasonable to you?
> >
> > Yeah, definitely, thank you so much. I don't have a fast enough device
> > by hand to show the difference right now. If you could get some data
> > it would be perfect.
> >
>
> Failed to find a test box that has two NVMe disks attached to different
> nodes and since Shanghai is locked down right now, we couldn't install
> another NVMe on the box so I figured it might be OK to test on a box that
> has a single NVMe attached to node 0 like this:
>
> 1) restrict the test processes to run on node 0 and allocate on node 1;
> 2) restrict the test processes to run on node 1 and allocate on node 0.
>
> In case 1), the reclaimer's node id is the same as the swap device's so
> it's the same as current behaviour and in case 2), the page's node id is
> the same as the swap device's so it's what your patch proposed.
>
> The test I used is vm-scalability/case-swap-w-rand:
> https://git.kernel.org/pub/scm/linux/kernel/git/wfg/vm-scalability.git/tree/case-swap-w-seq
> which spawns $nr_task processes and each will mmap $size and then
> randomly write to that area. I set nr_task=32 and $size=4G, so a total
> of 128G memory will be needed and I used memory.limit_in_bytes to
> restrict the available memory to 64G, to make sure swap is triggered.
>
> The reason why cgroup is used is to avoid waking up the per-node kswapd
> which can trigger swapping with reclaimer/page/swap device all having the
> same node id.
>
> And I don't see a measuable difference from the result:
> case1(using reclaimer's node id) vm-scalability.throughput: 10574 KB/s
> case2(using page's node id)      vm-scalability.throughput: 10567 KB/s
>
> My interpretation of the result is, when reclaiming a remote page, it
> doesn't matter much which swap device to use if the swap device is a IO
> device.
>
> Later Ying reminded me we have test box that has optane installed on
> different nodes so I also tested there: Icelake 2 sockets server with 2
> optane installed on each node. I did the test there like this:
> 1) restrict the test processes to run on node 0 and allocate on node 1
>    and only swapon pmem0, which is the optane backed swap device on node 0;
> 2) restrict the test processes to run on node 0 and allocate on node 1
>    and only swapon pmem1, which is the optane backed swap device on node 1.
>
> So case 1) is current behaviour and case 2) is what your patch proposed.
>
> With the same test and the same nr_task/size, the result is:
> case1(using reclaimer's node id) vm-scalability.throughput: 71033 KB/s
> case2(using page's node id)      vm-scalability.throughput: 58753 KB/s
>
> The result suggested when using a memory like device as swap device,
> it's better to use the reclaimer's node id when swapping.
>
> What do you think of these tests and results?

Thanks, Aaron. Since you are using PMEM so I'm supposed case #2
actually has 1 more cross node memory copy than case #1. Swapping
doesn't incur the block I/O (DMA) but memory copy in this
configuration.

IIUC, case #1 would do node1 -> node0 -> pmem0, but case #2 would do
node1 -> node0 -> pmem1.

Actually I was thinking about Optane SSD instead of PMEM when
discussing this with Ying offline. Not sure if Optane SSD would have
any measurable difference or not. But anyway if PMEM is used as swap
device the current implementation does make more sense.

>
> Thanks,
> Aaron
>
> > BTW, this patch doesn't change the node for swap slots cache, so it
> > may still use the swap device on a remote node if swap slots cache is
> > used.
> >
> > >
> > > > Cc: Huang Ying <ying.huang@intel.com>
> > > > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > > > ---
> > > >  include/linux/swap.h | 3 ++-
> > > >  mm/swap_slots.c      | 7 ++++---
> > > >  mm/swapfile.c        | 5 ++---
> > > >  3 files changed, 8 insertions(+), 7 deletions(-)
> > > >
> > > > diff --git a/include/linux/swap.h b/include/linux/swap.h
> > > > index 27093b477c5f..e442cf6b61ea 100644
> > > > --- a/include/linux/swap.h
> > > > +++ b/include/linux/swap.h
> > > > @@ -497,7 +497,8 @@ extern void si_swapinfo(struct sysinfo *);
> > > >  extern swp_entry_t get_swap_page(struct page *page);
> > > >  extern void put_swap_page(struct page *page, swp_entry_t entry);
> > > >  extern swp_entry_t get_swap_page_of_type(int);
> > > > -extern int get_swap_pages(int n, swp_entry_t swp_entries[], int entry_size);
> > > > +extern int get_swap_pages(int n, swp_entry_t swp_entries[], int entry_size,
> > > > +                       int node);
> > > >  extern int add_swap_count_continuation(swp_entry_t, gfp_t);
> > > >  extern void swap_shmem_alloc(swp_entry_t);
> > > >  extern int swap_duplicate(swp_entry_t);
> > > > diff --git a/mm/swap_slots.c b/mm/swap_slots.c
> > > > index 2b5531840583..a1c5cf6a4302 100644
> > > > --- a/mm/swap_slots.c
> > > > +++ b/mm/swap_slots.c
> > > > @@ -264,7 +264,7 @@ static int refill_swap_slots_cache(struct swap_slots_cache *cache)
> > > >       cache->cur = 0;
> > > >       if (swap_slot_cache_active)
> > > >               cache->nr = get_swap_pages(SWAP_SLOTS_CACHE_SIZE,
> > > > -                                        cache->slots, 1);
> > > > +                                        cache->slots, 1, numa_node_id());
> > > >
> > > >       return cache->nr;
> > > >  }
> > > > @@ -305,12 +305,13 @@ swp_entry_t get_swap_page(struct page *page)
> > > >  {
> > > >       swp_entry_t entry;
> > > >       struct swap_slots_cache *cache;
> > > > +     int nid = page_to_nid(page);
> > > >
> > > >       entry.val = 0;
> > > >
> > > >       if (PageTransHuge(page)) {
> > > >               if (IS_ENABLED(CONFIG_THP_SWAP))
> > > > -                     get_swap_pages(1, &entry, HPAGE_PMD_NR);
> > > > +                     get_swap_pages(1, &entry, HPAGE_PMD_NR, nid);
> > > >               goto out;
> > > >       }
> > > >
> > > > @@ -342,7 +343,7 @@ swp_entry_t get_swap_page(struct page *page)
> > > >                       goto out;
> > > >       }
> > > >
> > > > -     get_swap_pages(1, &entry, 1);
> > > > +     get_swap_pages(1, &entry, 1, nid);
> > > >  out:
> > > >       if (mem_cgroup_try_charge_swap(page, entry)) {
> > > >               put_swap_page(page, entry);
> > > > diff --git a/mm/swapfile.c b/mm/swapfile.c
> > > > index 63c61f8b2611..151fffe0fd60 100644
> > > > --- a/mm/swapfile.c
> > > > +++ b/mm/swapfile.c
> > > > @@ -1036,13 +1036,13 @@ static void swap_free_cluster(struct swap_info_struct *si, unsigned long idx)
> > > >       swap_range_free(si, offset, SWAPFILE_CLUSTER);
> > > >  }
> > > >
> > > > -int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_size)
> > > > +int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_size,
> > > > +                int node)
> > > >  {
> > > >       unsigned long size = swap_entry_size(entry_size);
> > > >       struct swap_info_struct *si, *next;
> > > >       long avail_pgs;
> > > >       int n_ret = 0;
> > > > -     int node;
> > > >
> > > >       /* Only single cluster request supported */
> > > >       WARN_ON_ONCE(n_goal > 1 && size == SWAPFILE_CLUSTER);
> > > > @@ -1060,7 +1060,6 @@ int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_size)
> > > >       atomic_long_sub(n_goal * size, &nr_swap_pages);
> > > >
> > > >  start_over:
> > > > -     node = numa_node_id();
> > > >       plist_for_each_entry_safe(si, next, &swap_avail_heads[node], avail_lists[node]) {
> > > >               /* requeue si to after same-priority siblings */
> > > >               plist_requeue(&si->avail_lists[node], &swap_avail_heads[node]);
> > > > --
> > > > 2.26.3
> > > >
> > > >
> >
