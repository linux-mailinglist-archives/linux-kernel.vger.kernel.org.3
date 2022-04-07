Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A21174F865A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 19:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346474AbiDGRjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 13:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346431AbiDGRjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 13:39:08 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEBB1196089
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 10:37:05 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id s8so6059526pfk.12
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 10:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4eRHeyIBtK2JphAWCbOBSoQhEFWtF686Z+g4Q2iefZY=;
        b=if1xA9KX9VUTDYBy0O1Zbzhz932LFp3+2Z0+M0/iAM1d7aH8Oghn1gsf598e7WzX6E
         yP9cHjyzH8NAwlk2gZm3hDipOcAcsuk1xpWpOMJdvm05A4Kztodou5S6IQRP0RwCWV2E
         zQtFut+48Y3CkrBhfBqL2MRLUrq15pR3yX/TBwQ3rr8iuRptW/DxKxWr0i84MfZGfZVQ
         mJej6gVfgREaKDyjBH7piajMe9slo5nWkD94tXfrRDVUQ+OM3nMSehw1wiXyC7wcxddu
         oUp+uwT3nVnpPIkubQe6gA1CE5Nk/GNch0uhP6o5bMlvJs2LknYP4IO0UHFhYMCr/23I
         338w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4eRHeyIBtK2JphAWCbOBSoQhEFWtF686Z+g4Q2iefZY=;
        b=FdU8ujNzlNnhU+PBoEy91Q+q9k3MGUdcQSIhGIjwcFJis3h9vF+IoZPeIw8hW/Wi22
         ss56lrH1jXDv3ZYHMFk4MPn0BMil5AErH6WLsV9wP70DSH1eKaDQ8dj9CxUZwOkFMKum
         nDGXlbvz1Ehk7Z8dYW7wBeDFOAlrby7Q6/QQhvcOH+VxGABgKScT+DJ4XS3r5sflFlgk
         YDffmOcogq1KysXlU1xNC41648njjyRXWF4Jcc64BYD4myT8EcaFt4ejK83pTnXZvJf7
         omdJtfxnQhBrUoZOi0t+Om/EonKAVCOzvQiCnRbNSsBvSFZuZXpbu6RGkfy6t1KJ/xdj
         MG+A==
X-Gm-Message-State: AOAM5333LlEgeG1o1r8Hw/xnLEF+sMbVmnmKhqbyqKc9bD+TAjX0g4Qq
        wM8OH0Wn3iqt5OPI447YSMJkCst72Vow8c20ibFX9Wv9
X-Google-Smtp-Source: ABdhPJzlAS8hmsxylYW21tU1uJImhTA4zhDVtcCR3MC9HC0ShdzrzYF8a+gHsxc7uFNWNMLBKZgjlplgu2SkBL7uJ/g=
X-Received: by 2002:a62:7952:0:b0:4fd:a244:f67b with SMTP id
 u79-20020a627952000000b004fda244f67bmr15332141pfc.23.1649353025396; Thu, 07
 Apr 2022 10:37:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220407020953.475626-1-shy828301@gmail.com> <Yk6cutNf5sOuYbDl@ziqianlu-nuc9qn>
In-Reply-To: <Yk6cutNf5sOuYbDl@ziqianlu-nuc9qn>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 7 Apr 2022 10:36:54 -0700
Message-ID: <CAHbLzkq+eKcKCsxXDTiOcBxk8FjMdWBqOxwi4N_NG7PZWbAAkA@mail.gmail.com>
Subject: Re: [PATCH] mm: swap: determine swap device by using page nid
To:     Aaron Lu <aaron.lu@intel.com>
Cc:     Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 7, 2022 at 1:12 AM Aaron Lu <aaron.lu@intel.com> wrote:
>
> On Wed, Apr 06, 2022 at 07:09:53PM -0700, Yang Shi wrote:
> > The swap devices are linked to per node priority lists, the swap device
> > closer to the node has higher priority on that node's priority list.
> > This is supposed to improve I/O latency, particularly for some fast
> > devices.  But the current code gets nid by calling numa_node_id() which
> > actually returns the nid that the reclaimer is running on instead of the
> > nid that the page belongs to.
> >
>
> Right.
>
> > Pass the page's nid dow to get_swap_pages() in order to pick up the
> > right swap device.  But it doesn't work for the swap slots cache which
> > is per cpu.  We could skip swap slots cache if the current node is not
> > the page's node, but it may be overkilling. So keep using the current
> > node's swap slots cache.  The issue was found by visual code inspection
> > so it is not sure how much improvement could be achieved due to lack of
> > suitable testing device.  But anyway the current code does violate the
> > design.
> >
>
> I intentionally used the reclaimer's nid because I think when swapping
> out to a device, it is faster when the device is on the same node as
> the cpu.

OK, the offline discussion with Huang Ying showed the design was to
have page's nid in order to achieve better I/O performance (more
noticeable on faster devices) since the reclaimer may be running on a
different node from the reclaimed page.

>
> Anyway, I think I can make a test case where the workload allocates all
> its memory on the remote node and its workingset memory is larger then
> the available memory so swap is triggered, then we can see which way
> achieves better performance. Sounds reasonable to you?

Yeah, definitely, thank you so much. I don't have a fast enough device
by hand to show the difference right now. If you could get some data
it would be perfect.

BTW, this patch doesn't change the node for swap slots cache, so it
may still use the swap device on a remote node if swap slots cache is
used.

>
> > Cc: Huang Ying <ying.huang@intel.com>
> > Signed-off-by: Yang Shi <shy828301@gmail.com>
> > ---
> >  include/linux/swap.h | 3 ++-
> >  mm/swap_slots.c      | 7 ++++---
> >  mm/swapfile.c        | 5 ++---
> >  3 files changed, 8 insertions(+), 7 deletions(-)
> >
> > diff --git a/include/linux/swap.h b/include/linux/swap.h
> > index 27093b477c5f..e442cf6b61ea 100644
> > --- a/include/linux/swap.h
> > +++ b/include/linux/swap.h
> > @@ -497,7 +497,8 @@ extern void si_swapinfo(struct sysinfo *);
> >  extern swp_entry_t get_swap_page(struct page *page);
> >  extern void put_swap_page(struct page *page, swp_entry_t entry);
> >  extern swp_entry_t get_swap_page_of_type(int);
> > -extern int get_swap_pages(int n, swp_entry_t swp_entries[], int entry_size);
> > +extern int get_swap_pages(int n, swp_entry_t swp_entries[], int entry_size,
> > +                       int node);
> >  extern int add_swap_count_continuation(swp_entry_t, gfp_t);
> >  extern void swap_shmem_alloc(swp_entry_t);
> >  extern int swap_duplicate(swp_entry_t);
> > diff --git a/mm/swap_slots.c b/mm/swap_slots.c
> > index 2b5531840583..a1c5cf6a4302 100644
> > --- a/mm/swap_slots.c
> > +++ b/mm/swap_slots.c
> > @@ -264,7 +264,7 @@ static int refill_swap_slots_cache(struct swap_slots_cache *cache)
> >       cache->cur = 0;
> >       if (swap_slot_cache_active)
> >               cache->nr = get_swap_pages(SWAP_SLOTS_CACHE_SIZE,
> > -                                        cache->slots, 1);
> > +                                        cache->slots, 1, numa_node_id());
> >
> >       return cache->nr;
> >  }
> > @@ -305,12 +305,13 @@ swp_entry_t get_swap_page(struct page *page)
> >  {
> >       swp_entry_t entry;
> >       struct swap_slots_cache *cache;
> > +     int nid = page_to_nid(page);
> >
> >       entry.val = 0;
> >
> >       if (PageTransHuge(page)) {
> >               if (IS_ENABLED(CONFIG_THP_SWAP))
> > -                     get_swap_pages(1, &entry, HPAGE_PMD_NR);
> > +                     get_swap_pages(1, &entry, HPAGE_PMD_NR, nid);
> >               goto out;
> >       }
> >
> > @@ -342,7 +343,7 @@ swp_entry_t get_swap_page(struct page *page)
> >                       goto out;
> >       }
> >
> > -     get_swap_pages(1, &entry, 1);
> > +     get_swap_pages(1, &entry, 1, nid);
> >  out:
> >       if (mem_cgroup_try_charge_swap(page, entry)) {
> >               put_swap_page(page, entry);
> > diff --git a/mm/swapfile.c b/mm/swapfile.c
> > index 63c61f8b2611..151fffe0fd60 100644
> > --- a/mm/swapfile.c
> > +++ b/mm/swapfile.c
> > @@ -1036,13 +1036,13 @@ static void swap_free_cluster(struct swap_info_struct *si, unsigned long idx)
> >       swap_range_free(si, offset, SWAPFILE_CLUSTER);
> >  }
> >
> > -int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_size)
> > +int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_size,
> > +                int node)
> >  {
> >       unsigned long size = swap_entry_size(entry_size);
> >       struct swap_info_struct *si, *next;
> >       long avail_pgs;
> >       int n_ret = 0;
> > -     int node;
> >
> >       /* Only single cluster request supported */
> >       WARN_ON_ONCE(n_goal > 1 && size == SWAPFILE_CLUSTER);
> > @@ -1060,7 +1060,6 @@ int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_size)
> >       atomic_long_sub(n_goal * size, &nr_swap_pages);
> >
> >  start_over:
> > -     node = numa_node_id();
> >       plist_for_each_entry_safe(si, next, &swap_avail_heads[node], avail_lists[node]) {
> >               /* requeue si to after same-priority siblings */
> >               plist_requeue(&si->avail_lists[node], &swap_avail_heads[node]);
> > --
> > 2.26.3
> >
> >
