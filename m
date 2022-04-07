Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA944F863C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 19:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241150AbiDGRbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 13:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346421AbiDGRao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 13:30:44 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50EF329C9E
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 10:28:17 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id o20so5580277pla.13
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 10:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HPJ/gxwWTPMsjVq1wqt/856o/PLEpZi5P1LCQp3vihA=;
        b=b0Fftw2gYiSz51wMYQnmyWiSCHVpRn1cZ2/G1Tb72pQ9W/97f89BBukh/dVUpOTJiD
         k4psjM6QujlBWLsJ7MjiCngT/pCWFjO7Y7wjEtK8+Iqsaotw1ekB0brOF+mo9/r44Bld
         tX+zELWubhSNeeQdAf6ydkz8LmwPLvMUJaKduE7leSwYi4nH06HrCbW1Zdi9MH78J2x6
         //KLsIz9xT/XZYKDMqRh0Ufc4P69lRMPTA5DN8idndiqK2hrf7Kb8GyxlhhTHVpCBApx
         xwRFpcGrksg3DskkJPZkPRytVgCyNxVw7Fmq6SqgR+sZrIiHNF+xX7vPp+vOsNvvLLfw
         yMJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HPJ/gxwWTPMsjVq1wqt/856o/PLEpZi5P1LCQp3vihA=;
        b=Rj7dMvT8iOsTf/FOFizqhqqTVKz0PYiZtF3LoWdgW9gkVctRfbLjKkRK5SRfgeB+2Q
         q8Doom7aKuQbxeXS+LifLTamwzqlqJ/174LatfOlu0cRHYZPBIwnMnqsO+XJXIDsIv4a
         LZWjevChsVzp0qO6jGS2ymTex+4UncO0FrzvKjgbFT1Qf1IoCoXq9x9bcGo/6AHNaCxS
         i7mZB1pnb2N6s7MOVkCZrz6BqdXb2yQV6AAjEuSlt5drZAITgplC1QFIzRe+XjRJjn+I
         1CrPZgQJ4fsR7ba5gevPO0v4iPWG4x0S/hiITf/Kcc2HYPW1tI1CDLYWVoYvahGAVBre
         xiAw==
X-Gm-Message-State: AOAM531bSos6mW9Dm8KkHmtK/HcrloZN7vSW1nYN8F9kONP9iJtUosoH
        PP1DdjVXaNnDxUgwfTvKLJIleEZKdT/A8dL39Nc=
X-Google-Smtp-Source: ABdhPJyBfPqYUFav5ezxzPl+JV/tc6dKIYnkPoGCeq8d25sJyX8RW8GzYLZdqrWJnXesr4888MzMP04wf1DyVwL40t8=
X-Received: by 2002:a17:90a:5298:b0:1ca:7fb3:145 with SMTP id
 w24-20020a17090a529800b001ca7fb30145mr17083799pjh.200.1649352482048; Thu, 07
 Apr 2022 10:28:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220407020953.475626-1-shy828301@gmail.com> <Yk6YKwZR5JjBokOs@dhcp22.suse.cz>
In-Reply-To: <Yk6YKwZR5JjBokOs@dhcp22.suse.cz>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 7 Apr 2022 10:27:50 -0700
Message-ID: <CAHbLzkpYJTRO5AsUYt+C3f+FJO2CQeTAzaNnzu-TxXn8j0ZuqA@mail.gmail.com>
Subject: Re: [PATCH] mm: swap: determine swap device by using page nid
To:     Michal Hocko <mhocko@suse.com>
Cc:     Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Aaron Lu <aaron.lu@intel.com>
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

On Thu, Apr 7, 2022 at 12:52 AM Michal Hocko <mhocko@suse.com> wrote:
>
> [Cc Aaron who has introduced the per node swap changes]
>
> On Wed 06-04-22 19:09:53, Yang Shi wrote:
> > The swap devices are linked to per node priority lists, the swap device
> > closer to the node has higher priority on that node's priority list.
> > This is supposed to improve I/O latency, particularly for some fast
> > devices.  But the current code gets nid by calling numa_node_id() which
> > actually returns the nid that the reclaimer is running on instead of the
> > nid that the page belongs to.
> >
> > Pass the page's nid dow to get_swap_pages() in order to pick up the
> > right swap device.  But it doesn't work for the swap slots cache which
> > is per cpu.  We could skip swap slots cache if the current node is not
> > the page's node, but it may be overkilling. So keep using the current
> > node's swap slots cache.  The issue was found by visual code inspection
> > so it is not sure how much improvement could be achieved due to lack of
> > suitable testing device.  But anyway the current code does violate the
> > design.
>
> Do you have any perf numbers for this change?

No, it was found by visual code inspection and offline discussion with
Huang Ying.

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
>
> --
> Michal Hocko
> SUSE Labs
