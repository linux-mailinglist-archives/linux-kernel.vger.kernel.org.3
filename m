Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09CF94DAC1D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 08:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354362AbiCPH4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 03:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352661AbiCPH4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 03:56:07 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0FC60CFB
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 00:54:53 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id v62so1388206vsv.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 00:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b5gTRuko97eI/fthkcfnm9gayEQtvFpZFqZB8tduF7c=;
        b=WEe9+Bxpxgg10owxznjLHnSwYsxADD5OwT5rKXFFA++k6khG8td0tx9nt5rmyU+hKE
         gyqj+Vj4rThPsgWeQqN/nUwF+EhGps1cOTqW8y8kn3HflTz0/RlrfHsoJrXexBqRxRSv
         4w2LSS6KYHffsXK+CNuyGjSqRUiaCtYTHvkfNn7VhTOzljys9we1ZgXrh83Z+WEQgPtp
         LzKIRHetzS+NyotLb5RgaeAJJd1KTkWIX3t2A5f5I0PHf4RVEj9ccb7uyFEPm30pJN7t
         uQqAlWqe7whNwPfU2GEq5GzeaTP6oh3fHKjQRM3PBFASqZ1d5W0d8KeWPlIzlthazodb
         otgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b5gTRuko97eI/fthkcfnm9gayEQtvFpZFqZB8tduF7c=;
        b=cIDE66ZtfHH4uyaX7ks4gJV/hJ+ouRrIrGdnvUh7kGJM3S+KtKOJRWoymO+1OPfm4+
         4OHwai9tQY4LoPJpc1x3ZXQGA45HR9AjSIcTkZxUJIZ6lb5doIeYo+Od5Ehlnq4RiKtp
         Et3UcHjEnNpt1YeZBZhTdk8o5tXt+pJrsbe0hsZ+SJMqxu3t7qNnSj2fqwgApSgm6h0L
         7tF5ijPS3a0T2e0MsxWOeg4CSxf10IhJkfiCLWfAzQpMApIclfOd8ZaV2kJ9j0mlU+0Z
         6uOZl9hRq6pY2FgAcDJbmkKovPdNTT+0wkvVWd0BAxeBjJFxZhRqNZEAId7/VcRSIHEH
         ax4g==
X-Gm-Message-State: AOAM533a6w40u2wAdWnkGQBh+BA30/xtdgpsFmlb62mW1yuWkB2ToNee
        L1SH3mwPmQnWMpZBzGI4UkL+FCgAe7palYAGtYVd7g==
X-Google-Smtp-Source: ABdhPJwGuAArwozEUZv8gKaGEUnT0xpDpZgIxvxFfayV12kU/WqsaR4Ko1uznCEbu2B6kiUcO73yy/9VP99wOuSBNVI=
X-Received: by 2002:a05:6102:f0c:b0:320:9156:732f with SMTP id
 v12-20020a0561020f0c00b003209156732fmr13355818vss.6.1647417291993; Wed, 16
 Mar 2022 00:54:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220309021230.721028-1-yuzhao@google.com> <20220309021230.721028-7-yuzhao@google.com>
 <87wnguwif3.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87wnguwif3.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Wed, 16 Mar 2022 01:54:41 -0600
Message-ID: <CAOUHufYBPSx8W5oP=Rf2Sa9QoMhUbEyiF-heR9SuQhcVp+42Rw@mail.gmail.com>
Subject: Re: [PATCH v9 06/14] mm: multi-gen LRU: minimal implementation
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Jesse Barnes <jsbarnes@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Kernel Page Reclaim v2 <page-reclaim@google.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Brian Geffon <bgeffon@google.com>,
        Jan Alexander Steffens <heftig@archlinux.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Steven Barrett <steven@liquorix.net>,
        Suleiman Souhlal <suleiman@google.com>,
        Daniel Byrne <djbyrne@mtu.edu>,
        Donald Carr <d@chaos-reins.com>,
        =?UTF-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        Shuang Zhai <szhai2@cs.rochester.edu>,
        Sofia Trinh <sofia.trinh@edi.works>,
        Vaibhav Jain <vaibhav@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 11:55 PM Huang, Ying <ying.huang@intel.com> wrote:
>
> Hi, Yu,
>
> Yu Zhao <yuzhao@google.com> writes:
>
> [snip]
>
> >
> > +static int get_swappiness(struct lruvec *lruvec, struct scan_control *sc)
> > +{
> > +     struct mem_cgroup *memcg = lruvec_memcg(lruvec);
> > +     struct pglist_data *pgdat = lruvec_pgdat(lruvec);
> > +
> > +     if (!can_demote(pgdat->node_id, sc) &&
> > +         mem_cgroup_get_nr_swap_pages(memcg) < MIN_LRU_BATCH)
> > +             return 0;
> > +
> > +     return mem_cgroup_swappiness(memcg);
> > +}
> > +
>
> We have tested v9 for memory tiering system, the demotion works now even
> without swap devices configured.  Thanks!

Admittedly I didn't test it :) So thanks for testing -- I'm glad to
hear it didn't fall apart.

> And we found that the demotion (page reclaiming on DRAM nodes) speed is
> lower than the original implementation.

This sounds like an improvement to me, assuming the initial hot/cold
memory placements were similar for both the baseline and MGLRU.

Correct me if I'm wrong: since demotion is driven by promotion, lower
demotion speed means hot and cold pages were sorted out to DRAM and
AEP at a faster speed, hence an improvement.

# promotion path:
numa_hint_faults    498301236
numa_pages_migrated 152650705

numa_hint_faults    494583387
numa_pages_migrated 34165992

# demotion path:
pgsteal_anon 153798203
pgsteal_file 33

pgsteal_anon 32701576
pgsteal_file 33

The hint faults are similar but MGLRU has much fewer migrated -- my
guess is it demoted much fewer hot/warm pages and therefore led to
less work on the promotion path.

>  The workload itself is just a
> memory accessing micro-benchmark with Gauss distribution.  It is run on
> a system with DRAM and PMEM.  Initially, quite some hot pages are placed
> in PMEM and quite some cold pages are placed in DRAM.  Then the page
> placement optimizing mechanism based on NUMA balancing will try to
> promote some hot pages from PMEM node to DRAM node.

My understanding seems to be correct?

>  If the DRAM node
> near full (reach high watermark), kswapd of the DRAM node will be woke
> up to demote (reclaim) some cold DRAM pages to PMEM.  Because quite some
> pages on DRAM is very cold (not accessed for at least several seconds),
> the benchmark performance will be better if demotion speed is faster.

I'm confused. It seems to me demotion speed is irrelevant. The time to
reach the equilibrium is what we want to measure.

> Some data comes from /proc/vmstat and perf-profile is as follows.
>
> From /proc/vmstat, it seems that the page scanned and page demoted is
> much less with MGLRU enabled.  The pgdemote_kswapd / pgscan_kswapd is
> 5.22 times higher with MGLRU enabled than that with MGLRU disabled.  I
> think this shows the value of direct page table scanning.

Can't disagree :)

> From perf-profile, the CPU cycles for kswapd is same.  But less pages
> are demoted (reclaimed) with MGLRU.  And it appears that the total page
> table scanning time of MGLRU is longer if we compare walk_page_range
> (1.97%, MGLRU enabled) and page_referenced (0.54%, MGLRU disabled)?

It's possible if the address space is very large and sparse. But once
MGLRU warms up, it should detect it and fall back to
page_referenced().

> Because we only demote (reclaim) from DRAM nodes, but not demote
> (reclaim) from PMEM nodes and bloom filter doesn't work well enough?

The bloom filters are per lruvec. So this should affect them.

> One thing that may be not friendly for bloom filter is that some virtual
> pages may change their resident nodes because of demotion/promotion.

Yes, it's possible.

> Can you teach me to how interpret these data for MGLRU?  Or can you
> point me to the other/better data for MGLRU?

You are the expert :)

My current understanding is that this is an improvement. IOW, with
MGLRU, DRAM (hot) <-> AEP (cold) reached equilibrium a lot faster.


> MGLRU disabled via: echo -n 0 > /sys/kernel/mm/lru_gen/enabled
> --------------------------------------------------------------
>
> /proc/vmstat:
>
> pgactivate 1767172340
> pgdeactivate 1740111896
> pglazyfree 0
> pgfault 583875828
> pgmajfault 0
> pglazyfreed 0
> pgrefill 1740111896
> pgreuse 22626572
> pgsteal_kswapd 153796237
> pgsteal_direct 1999
> pgdemote_kswapd 153796237
> pgdemote_direct 1999
> pgscan_kswapd 2055504891
> pgscan_direct 1999
> pgscan_direct_throttle 0
> pgscan_anon 2055356614
> pgscan_file 150276
> pgsteal_anon 153798203
> pgsteal_file 33
> zone_reclaim_failed 0
> pginodesteal 0
> slabs_scanned 82761
> kswapd_inodesteal 0
> kswapd_low_wmark_hit_quickly 2960
> kswapd_high_wmark_hit_quickly 17732
> pageoutrun 21583
> pgrotated 0
> drop_pagecache 0
> drop_slab 0
> oom_kill 0
> numa_pte_updates 515994024
> numa_huge_pte_updates 154
> numa_hint_faults 498301236
> numa_hint_faults_local 121109067
> numa_pages_migrated 152650705
> pgmigrate_success 307213704
> pgmigrate_fail 39
> thp_migration_success 93
> thp_migration_fail 0
> thp_migration_split 0
>
> perf-profile:
>
> kswapd.kthread.ret_from_fork: 2.86
> balance_pgdat.kswapd.kthread.ret_from_fork: 2.86
> shrink_node.balance_pgdat.kswapd.kthread.ret_from_fork: 2.85
> shrink_lruvec.shrink_node.balance_pgdat.kswapd.kthread: 2.76
> shrink_inactive_list.shrink_lruvec.shrink_node.balance_pgdat.kswapd: 1.9
> shrink_page_list.shrink_inactive_list.shrink_lruvec.shrink_node.balance_pgdat: 1.52
> shrink_active_list.shrink_lruvec.shrink_node.balance_pgdat.kswapd: 0.85
> migrate_pages.shrink_page_list.shrink_inactive_list.shrink_lruvec.shrink_node: 0.79
> page_referenced.shrink_page_list.shrink_inactive_list.shrink_lruvec.shrink_node: 0.54
>
>
> MGLRU enabled via: echo -n 7 > /sys/kernel/mm/lru_gen/enabled
> -------------------------------------------------------------
>
> /proc/vmstat:
>
> pgactivate 47212585
> pgdeactivate 0
> pglazyfree 0
> pgfault 580056521
> pgmajfault 0
> pglazyfreed 0
> pgrefill 6911868880
> pgreuse 25108929
> pgsteal_kswapd 32701609
> pgsteal_direct 0
> pgdemote_kswapd 32701609
> pgdemote_direct 0
> pgscan_kswapd 83582770
> pgscan_direct 0
> pgscan_direct_throttle 0
> pgscan_anon 83549777
> pgscan_file 32993
> pgsteal_anon 32701576
> pgsteal_file 33
> zone_reclaim_failed 0
> pginodesteal 0
> slabs_scanned 84829
> kswapd_inodesteal 0
> kswapd_low_wmark_hit_quickly 313
> kswapd_high_wmark_hit_quickly 5262
> pageoutrun 5895
> pgrotated 0
> drop_pagecache 0
> drop_slab 0
> oom_kill 0
> numa_pte_updates 512084786
> numa_huge_pte_updates 198
> numa_hint_faults 494583387
> numa_hint_faults_local 129411334
> numa_pages_migrated 34165992
> pgmigrate_success 67833977
> pgmigrate_fail 7
> thp_migration_success 135
> thp_migration_fail 0
> thp_migration_split 0
>
> perf-profile:
>
> kswapd.kthread.ret_from_fork: 2.86
> balance_pgdat.kswapd.kthread.ret_from_fork: 2.86
> lru_gen_age_node.balance_pgdat.kswapd.kthread.ret_from_fork: 1.97
> walk_page_range.try_to_inc_max_seq.lru_gen_age_node.balance_pgdat.kswapd: 1.97
> shrink_node.balance_pgdat.kswapd.kthread.ret_from_fork: 0.89
> evict_folios.lru_gen_shrink_lruvec.shrink_lruvec.shrink_node.balance_pgdat: 0.89
> scan_folios.evict_folios.lru_gen_shrink_lruvec.shrink_lruvec.shrink_node: 0.66
>
> Best Regards,
> Huang, Ying
>
> [snip]
>
