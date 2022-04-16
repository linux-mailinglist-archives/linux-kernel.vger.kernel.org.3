Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32A7D503486
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 08:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbiDPGut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 02:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiDPGuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 02:50:46 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4DBCFA221;
        Fri, 15 Apr 2022 23:48:14 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KgNzm6KRZzfYnt;
        Sat, 16 Apr 2022 14:47:32 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 16 Apr 2022 14:48:10 +0800
Subject: Re: [PATCH v10 03/14] mm/vmscan.c: refactor shrink_node()
To:     Yu Zhao <yuzhao@google.com>, Stephen Rothwell <sfr@rothwell.id.au>,
        <linux-mm@kvack.org>
CC:     Andi Kleen <ak@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Barry Song <21cnbao@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Jesse Barnes <jsbarnes@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Ying Huang <ying.huang@intel.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <page-reclaim@google.com>, <x86@kernel.org>,
        Barry Song <baohua@kernel.org>,
        Brian Geffon <bgeffon@google.com>,
        Jan Alexander Steffens <heftig@archlinux.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Steven Barrett <steven@liquorix.net>,
        Suleiman Souhlal <suleiman@google.com>,
        Daniel Byrne <djbyrne@mtu.edu>,
        Donald Carr <d@chaos-reins.com>,
        =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        Shuang Zhai <szhai2@cs.rochester.edu>,
        Sofia Trinh <sofia.trinh@edi.works>,
        Vaibhav Jain <vaibhav@linux.ibm.com>
References: <20220407031525.2368067-1-yuzhao@google.com>
 <20220407031525.2368067-4-yuzhao@google.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <195d4677-e033-e124-144c-9ede270b4f70@huawei.com>
Date:   Sat, 16 Apr 2022 14:48:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220407031525.2368067-4-yuzhao@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/7 11:15, Yu Zhao wrote:
> This patch refactors shrink_node() to improve readability for the
> upcoming changes to mm/vmscan.c.
> 
> Signed-off-by: Yu Zhao <yuzhao@google.com>
> Reviewed-by: Barry Song <baohua@kernel.org>
> Acked-by: Brian Geffon <bgeffon@google.com>
> Acked-by: Jan Alexander Steffens (heftig) <heftig@archlinux.org>
> Acked-by: Oleksandr Natalenko <oleksandr@natalenko.name>
> Acked-by: Steven Barrett <steven@liquorix.net>
> Acked-by: Suleiman Souhlal <suleiman@google.com>
> Tested-by: Daniel Byrne <djbyrne@mtu.edu>
> Tested-by: Donald Carr <d@chaos-reins.com>
> Tested-by: Holger Hoffstätte <holger@applied-asynchrony.com>
> Tested-by: Konstantin Kharlamov <Hi-Angel@yandex.ru>
> Tested-by: Shuang Zhai <szhai2@cs.rochester.edu>
> Tested-by: Sofia Trinh <sofia.trinh@edi.works>
> Tested-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> ---
>  mm/vmscan.c | 198 +++++++++++++++++++++++++++-------------------------
>  1 file changed, 104 insertions(+), 94 deletions(-)
> 

Looks good to me. Thanks!

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 1678802e03e7..2232cb55af41 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2644,6 +2644,109 @@ enum scan_balance {
>  	SCAN_FILE,
>  };
>  
> +static void prepare_scan_count(pg_data_t *pgdat, struct scan_control *sc)
> +{
> +	unsigned long file;
> +	struct lruvec *target_lruvec;
> +
> +	target_lruvec = mem_cgroup_lruvec(sc->target_mem_cgroup, pgdat);
> +
> +	/*
> +	 * Flush the memory cgroup stats, so that we read accurate per-memcg
> +	 * lruvec stats for heuristics.
> +	 */
> +	mem_cgroup_flush_stats();
> +
> +	/*
> +	 * Determine the scan balance between anon and file LRUs.
> +	 */
> +	spin_lock_irq(&target_lruvec->lru_lock);
> +	sc->anon_cost = target_lruvec->anon_cost;
> +	sc->file_cost = target_lruvec->file_cost;
> +	spin_unlock_irq(&target_lruvec->lru_lock);
> +
> +	/*
> +	 * Target desirable inactive:active list ratios for the anon
> +	 * and file LRU lists.
> +	 */
> +	if (!sc->force_deactivate) {
> +		unsigned long refaults;
> +
> +		refaults = lruvec_page_state(target_lruvec,
> +				WORKINGSET_ACTIVATE_ANON);
> +		if (refaults != target_lruvec->refaults[0] ||
> +			inactive_is_low(target_lruvec, LRU_INACTIVE_ANON))
> +			sc->may_deactivate |= DEACTIVATE_ANON;
> +		else
> +			sc->may_deactivate &= ~DEACTIVATE_ANON;
> +
> +		/*
> +		 * When refaults are being observed, it means a new
> +		 * workingset is being established. Deactivate to get
> +		 * rid of any stale active pages quickly.
> +		 */
> +		refaults = lruvec_page_state(target_lruvec,
> +				WORKINGSET_ACTIVATE_FILE);
> +		if (refaults != target_lruvec->refaults[1] ||
> +		    inactive_is_low(target_lruvec, LRU_INACTIVE_FILE))
> +			sc->may_deactivate |= DEACTIVATE_FILE;
> +		else
> +			sc->may_deactivate &= ~DEACTIVATE_FILE;
> +	} else
> +		sc->may_deactivate = DEACTIVATE_ANON | DEACTIVATE_FILE;
> +
> +	/*
> +	 * If we have plenty of inactive file pages that aren't
> +	 * thrashing, try to reclaim those first before touching
> +	 * anonymous pages.
> +	 */
> +	file = lruvec_page_state(target_lruvec, NR_INACTIVE_FILE);
> +	if (file >> sc->priority && !(sc->may_deactivate & DEACTIVATE_FILE))
> +		sc->cache_trim_mode = 1;
> +	else
> +		sc->cache_trim_mode = 0;
> +
> +	/*
> +	 * Prevent the reclaimer from falling into the cache trap: as
> +	 * cache pages start out inactive, every cache fault will tip
> +	 * the scan balance towards the file LRU.  And as the file LRU
> +	 * shrinks, so does the window for rotation from references.
> +	 * This means we have a runaway feedback loop where a tiny
> +	 * thrashing file LRU becomes infinitely more attractive than
> +	 * anon pages.  Try to detect this based on file LRU size.
> +	 */
> +	if (!cgroup_reclaim(sc)) {
> +		unsigned long total_high_wmark = 0;
> +		unsigned long free, anon;
> +		int z;
> +
> +		free = sum_zone_node_page_state(pgdat->node_id, NR_FREE_PAGES);
> +		file = node_page_state(pgdat, NR_ACTIVE_FILE) +
> +			   node_page_state(pgdat, NR_INACTIVE_FILE);
> +
> +		for (z = 0; z < MAX_NR_ZONES; z++) {
> +			struct zone *zone = &pgdat->node_zones[z];
> +
> +			if (!managed_zone(zone))
> +				continue;
> +
> +			total_high_wmark += high_wmark_pages(zone);
> +		}
> +
> +		/*
> +		 * Consider anon: if that's low too, this isn't a
> +		 * runaway file reclaim problem, but rather just
> +		 * extreme pressure. Reclaim as per usual then.
> +		 */
> +		anon = node_page_state(pgdat, NR_INACTIVE_ANON);
> +
> +		sc->file_is_tiny =
> +			file + free <= total_high_wmark &&
> +			!(sc->may_deactivate & DEACTIVATE_ANON) &&
> +			anon >> sc->priority;
> +	}
> +}
> +
>  /*
>   * Determine how aggressively the anon and file LRU lists should be
>   * scanned.  The relative value of each set of LRU lists is determined
> @@ -3114,109 +3217,16 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
>  	unsigned long nr_reclaimed, nr_scanned;
>  	struct lruvec *target_lruvec;
>  	bool reclaimable = false;
> -	unsigned long file;
>  
>  	target_lruvec = mem_cgroup_lruvec(sc->target_mem_cgroup, pgdat);
>  
>  again:
> -	/*
> -	 * Flush the memory cgroup stats, so that we read accurate per-memcg
> -	 * lruvec stats for heuristics.
> -	 */
> -	mem_cgroup_flush_stats();
> -
>  	memset(&sc->nr, 0, sizeof(sc->nr));
>  
>  	nr_reclaimed = sc->nr_reclaimed;
>  	nr_scanned = sc->nr_scanned;
>  
> -	/*
> -	 * Determine the scan balance between anon and file LRUs.
> -	 */
> -	spin_lock_irq(&target_lruvec->lru_lock);
> -	sc->anon_cost = target_lruvec->anon_cost;
> -	sc->file_cost = target_lruvec->file_cost;
> -	spin_unlock_irq(&target_lruvec->lru_lock);
> -
> -	/*
> -	 * Target desirable inactive:active list ratios for the anon
> -	 * and file LRU lists.
> -	 */
> -	if (!sc->force_deactivate) {
> -		unsigned long refaults;
> -
> -		refaults = lruvec_page_state(target_lruvec,
> -				WORKINGSET_ACTIVATE_ANON);
> -		if (refaults != target_lruvec->refaults[0] ||
> -			inactive_is_low(target_lruvec, LRU_INACTIVE_ANON))
> -			sc->may_deactivate |= DEACTIVATE_ANON;
> -		else
> -			sc->may_deactivate &= ~DEACTIVATE_ANON;
> -
> -		/*
> -		 * When refaults are being observed, it means a new
> -		 * workingset is being established. Deactivate to get
> -		 * rid of any stale active pages quickly.
> -		 */
> -		refaults = lruvec_page_state(target_lruvec,
> -				WORKINGSET_ACTIVATE_FILE);
> -		if (refaults != target_lruvec->refaults[1] ||
> -		    inactive_is_low(target_lruvec, LRU_INACTIVE_FILE))
> -			sc->may_deactivate |= DEACTIVATE_FILE;
> -		else
> -			sc->may_deactivate &= ~DEACTIVATE_FILE;
> -	} else
> -		sc->may_deactivate = DEACTIVATE_ANON | DEACTIVATE_FILE;
> -
> -	/*
> -	 * If we have plenty of inactive file pages that aren't
> -	 * thrashing, try to reclaim those first before touching
> -	 * anonymous pages.
> -	 */
> -	file = lruvec_page_state(target_lruvec, NR_INACTIVE_FILE);
> -	if (file >> sc->priority && !(sc->may_deactivate & DEACTIVATE_FILE))
> -		sc->cache_trim_mode = 1;
> -	else
> -		sc->cache_trim_mode = 0;
> -
> -	/*
> -	 * Prevent the reclaimer from falling into the cache trap: as
> -	 * cache pages start out inactive, every cache fault will tip
> -	 * the scan balance towards the file LRU.  And as the file LRU
> -	 * shrinks, so does the window for rotation from references.
> -	 * This means we have a runaway feedback loop where a tiny
> -	 * thrashing file LRU becomes infinitely more attractive than
> -	 * anon pages.  Try to detect this based on file LRU size.
> -	 */
> -	if (!cgroup_reclaim(sc)) {
> -		unsigned long total_high_wmark = 0;
> -		unsigned long free, anon;
> -		int z;
> -
> -		free = sum_zone_node_page_state(pgdat->node_id, NR_FREE_PAGES);
> -		file = node_page_state(pgdat, NR_ACTIVE_FILE) +
> -			   node_page_state(pgdat, NR_INACTIVE_FILE);
> -
> -		for (z = 0; z < MAX_NR_ZONES; z++) {
> -			struct zone *zone = &pgdat->node_zones[z];
> -			if (!managed_zone(zone))
> -				continue;
> -
> -			total_high_wmark += high_wmark_pages(zone);
> -		}
> -
> -		/*
> -		 * Consider anon: if that's low too, this isn't a
> -		 * runaway file reclaim problem, but rather just
> -		 * extreme pressure. Reclaim as per usual then.
> -		 */
> -		anon = node_page_state(pgdat, NR_INACTIVE_ANON);
> -
> -		sc->file_is_tiny =
> -			file + free <= total_high_wmark &&
> -			!(sc->may_deactivate & DEACTIVATE_ANON) &&
> -			anon >> sc->priority;
> -	}
> +	prepare_scan_count(pgdat, sc);
>  
>  	shrink_node_memcgs(pgdat, sc);
>  
> 

