Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0344DAA14
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 06:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353686AbiCPF4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 01:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238982AbiCPF4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 01:56:36 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B5A62667;
        Tue, 15 Mar 2022 22:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647410122; x=1678946122;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=hXbcQT9FRmDvFtocUaLFO+s9TeLyNb12ETvlhaJ5DxU=;
  b=M3UqvqePqja31swBvgDmw4V26JkOSJ5ip3TzQkH8xYxg/CC5P7JOn3Yi
   Gz/AngdtJdOpCfWF6fL4fyjmZcJJX1X3eJoEwC9opN04alhx1nuP9lAFv
   7YYZxvJu953VO6BnI9QndzVt6hW9N8btTYs6/XA20+FhueMg5m/uEISI9
   Yu4vdkSgGwdvG97p6RLJcLaqc5/cJdfXJRu34n2Z5p8W9xYC62VCLEzzb
   usZIMzm5x8YrwFxnMA1eJUfrDkW552C0njecFDiwT5SqsGlL56PefpGKK
   nUMmU2FI2/XrrC9wiN1s0skgcwEVqa+jfut3YHopYC5KY79OZvSiE7qaB
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="256689119"
X-IronPort-AV: E=Sophos;i="5.90,185,1643702400"; 
   d="scan'208";a="256689119"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 22:55:22 -0700
X-IronPort-AV: E=Sophos;i="5.90,185,1643702400"; 
   d="scan'208";a="540769039"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.94])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 22:55:14 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Yu Zhao <yuzhao@google.com>
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
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        page-reclaim@google.com, x86@kernel.org,
        Brian Geffon <bgeffon@google.com>,
        Jan Alexander Steffens <heftig@archlinux.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Steven Barrett <steven@liquorix.net>,
        Suleiman Souhlal <suleiman@google.com>,
        Daniel Byrne <djbyrne@mtu.edu>,
        Donald Carr <d@chaos-reins.com>,
        =?utf-8?Q?Hol?= =?utf-8?Q?ger_Hoffst=C3=A4tte?= 
        <holger@applied-asynchrony.com>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        Shuang Zhai <szhai2@cs.rochester.edu>,
        Sofia Trinh <sofia.trinh@edi.works>,
        Vaibhav Jain <vaibhav@linux.ibm.com>
Subject: Re: [PATCH v9 06/14] mm: multi-gen LRU: minimal implementation
References: <20220309021230.721028-1-yuzhao@google.com>
        <20220309021230.721028-7-yuzhao@google.com>
Date:   Wed, 16 Mar 2022 13:55:12 +0800
In-Reply-To: <20220309021230.721028-7-yuzhao@google.com> (Yu Zhao's message of
        "Tue, 8 Mar 2022 19:12:23 -0700")
Message-ID: <87wnguwif3.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Yu,

Yu Zhao <yuzhao@google.com> writes:

[snip]

>  
> +static int get_swappiness(struct lruvec *lruvec, struct scan_control *sc)
> +{
> +	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
> +	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
> +
> +	if (!can_demote(pgdat->node_id, sc) &&
> +	    mem_cgroup_get_nr_swap_pages(memcg) < MIN_LRU_BATCH)
> +		return 0;
> +
> +	return mem_cgroup_swappiness(memcg);
> +}
> +

We have tested v9 for memory tiering system, the demotion works now even
without swap devices configured.  Thanks!

And we found that the demotion (page reclaiming on DRAM nodes) speed is
lower than the original implementation.  The workload itself is just a
memory accessing micro-benchmark with Gauss distribution.  It is run on
a system with DRAM and PMEM.  Initially, quite some hot pages are placed
in PMEM and quite some cold pages are placed in DRAM.  Then the page
placement optimizing mechanism based on NUMA balancing will try to
promote some hot pages from PMEM node to DRAM node.  If the DRAM node
near full (reach high watermark), kswapd of the DRAM node will be woke
up to demote (reclaim) some cold DRAM pages to PMEM.  Because quite some
pages on DRAM is very cold (not accessed for at least several seconds),
the benchmark performance will be better if demotion speed is faster.

Some data comes from /proc/vmstat and perf-profile is as follows.

From /proc/vmstat, it seems that the page scanned and page demoted is
much less with MGLRU enabled.  The pgdemote_kswapd / pgscan_kswapd is
5.22 times higher with MGLRU enabled than that with MGLRU disabled.  I
think this shows the value of direct page table scanning.

From perf-profile, the CPU cycles for kswapd is same.  But less pages
are demoted (reclaimed) with MGLRU.  And it appears that the total page
table scanning time of MGLRU is longer if we compare walk_page_range
(1.97%, MGLRU enabled) and page_referenced (0.54%, MGLRU disabled)?
Because we only demote (reclaim) from DRAM nodes, but not demote
(reclaim) from PMEM nodes and bloom filter doesn't work well enough?
One thing that may be not friendly for bloom filter is that some virtual
pages may change their resident nodes because of demotion/promotion.

Can you teach me to how interpret these data for MGLRU?  Or can you
point me to the other/better data for MGLRU?

MGLRU disabled via: echo -n 0 > /sys/kernel/mm/lru_gen/enabled
--------------------------------------------------------------

/proc/vmstat:

pgactivate 1767172340
pgdeactivate 1740111896
pglazyfree 0
pgfault 583875828
pgmajfault 0
pglazyfreed 0
pgrefill 1740111896
pgreuse 22626572
pgsteal_kswapd 153796237
pgsteal_direct 1999
pgdemote_kswapd 153796237
pgdemote_direct 1999
pgscan_kswapd 2055504891
pgscan_direct 1999
pgscan_direct_throttle 0
pgscan_anon 2055356614
pgscan_file 150276
pgsteal_anon 153798203
pgsteal_file 33
zone_reclaim_failed 0
pginodesteal 0
slabs_scanned 82761
kswapd_inodesteal 0
kswapd_low_wmark_hit_quickly 2960
kswapd_high_wmark_hit_quickly 17732
pageoutrun 21583
pgrotated 0
drop_pagecache 0
drop_slab 0
oom_kill 0
numa_pte_updates 515994024
numa_huge_pte_updates 154
numa_hint_faults 498301236
numa_hint_faults_local 121109067
numa_pages_migrated 152650705
pgmigrate_success 307213704
pgmigrate_fail 39
thp_migration_success 93
thp_migration_fail 0
thp_migration_split 0

perf-profile:

kswapd.kthread.ret_from_fork: 2.86
balance_pgdat.kswapd.kthread.ret_from_fork: 2.86
shrink_node.balance_pgdat.kswapd.kthread.ret_from_fork: 2.85
shrink_lruvec.shrink_node.balance_pgdat.kswapd.kthread: 2.76
shrink_inactive_list.shrink_lruvec.shrink_node.balance_pgdat.kswapd: 1.9
shrink_page_list.shrink_inactive_list.shrink_lruvec.shrink_node.balance_pgdat: 1.52
shrink_active_list.shrink_lruvec.shrink_node.balance_pgdat.kswapd: 0.85
migrate_pages.shrink_page_list.shrink_inactive_list.shrink_lruvec.shrink_node: 0.79
page_referenced.shrink_page_list.shrink_inactive_list.shrink_lruvec.shrink_node: 0.54


MGLRU enabled via: echo -n 7 > /sys/kernel/mm/lru_gen/enabled
-------------------------------------------------------------

/proc/vmstat:

pgactivate 47212585
pgdeactivate 0
pglazyfree 0
pgfault 580056521
pgmajfault 0
pglazyfreed 0
pgrefill 6911868880
pgreuse 25108929
pgsteal_kswapd 32701609
pgsteal_direct 0
pgdemote_kswapd 32701609
pgdemote_direct 0
pgscan_kswapd 83582770
pgscan_direct 0
pgscan_direct_throttle 0
pgscan_anon 83549777
pgscan_file 32993
pgsteal_anon 32701576
pgsteal_file 33
zone_reclaim_failed 0
pginodesteal 0
slabs_scanned 84829
kswapd_inodesteal 0
kswapd_low_wmark_hit_quickly 313
kswapd_high_wmark_hit_quickly 5262
pageoutrun 5895
pgrotated 0
drop_pagecache 0
drop_slab 0
oom_kill 0
numa_pte_updates 512084786
numa_huge_pte_updates 198
numa_hint_faults 494583387
numa_hint_faults_local 129411334
numa_pages_migrated 34165992
pgmigrate_success 67833977
pgmigrate_fail 7
thp_migration_success 135
thp_migration_fail 0
thp_migration_split 0

perf-profile:

kswapd.kthread.ret_from_fork: 2.86
balance_pgdat.kswapd.kthread.ret_from_fork: 2.86
lru_gen_age_node.balance_pgdat.kswapd.kthread.ret_from_fork: 1.97
walk_page_range.try_to_inc_max_seq.lru_gen_age_node.balance_pgdat.kswapd: 1.97
shrink_node.balance_pgdat.kswapd.kthread.ret_from_fork: 0.89
evict_folios.lru_gen_shrink_lruvec.shrink_lruvec.shrink_node.balance_pgdat: 0.89
scan_folios.evict_folios.lru_gen_shrink_lruvec.shrink_lruvec.shrink_node: 0.66

Best Regards,
Huang, Ying

[snip]
