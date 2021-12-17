Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36B6F47858D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 08:25:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233660AbhLQHY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 02:24:59 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:37137 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232167AbhLQHY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 02:24:58 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0V-tDW0N_1639725890;
Received: from 30.21.164.42(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0V-tDW0N_1639725890)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 17 Dec 2021 15:24:51 +0800
Message-ID: <2d1e14d2-a27d-a1d1-bd43-f933c1bf5e76@linux.alibaba.com>
Date:   Fri, 17 Dec 2021 15:25:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH -V10 RESEND 1/6] NUMA Balancing: add page promotion
 counter
To:     Huang Ying <ying.huang@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Feng Tang <feng.tang@intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Zi Yan <ziy@nvidia.com>, Wei Xu <weixugc@google.com>,
        osalvador <osalvador@suse.de>,
        Shakeel Butt <shakeelb@google.com>,
        Hasan Al Maruf <hasanalmaruf@fb.com>
References: <20211207022757.2523359-1-ying.huang@intel.com>
 <20211207022757.2523359-2-ying.huang@intel.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20211207022757.2523359-2-ying.huang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/7/2021 10:27 AM, Huang Ying wrote:
> In a system with multiple memory types, e.g. DRAM and PMEM, the CPU
> and DRAM in one socket will be put in one NUMA node as before, while
> the PMEM will be put in another NUMA node as described in the
> description of the commit c221c0b0308f ("device-dax: "Hotplug"
> persistent memory for use like normal RAM").  So, the NUMA balancing
> mechanism will identify all PMEM accesses as remote access and try to
> promote the PMEM pages to DRAM.
> 
> To distinguish the number of the inter-type promoted pages from that
> of the inter-socket migrated pages.  A new vmstat count is added.  The
> counter is per-node (count in the target node).  So this can be used
> to identify promotion imbalance among the NUMA nodes.
> 
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Reviewed-by: Yang Shi <shy828301@gmail.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Rik van Riel <riel@surriel.com>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Wei Xu <weixugc@google.com>
> Cc: osalvador <osalvador@suse.de>
> Cc: Shakeel Butt <shakeelb@google.com>
> Cc: Hasan Al Maruf <hasanalmaruf@fb.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mm@kvack.org
> ---

Tested on my tiered memory system, and works well. Please feel free to add:
Tested-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

>   include/linux/mmzone.h |  3 +++
>   include/linux/node.h   |  5 +++++
>   mm/migrate.c           | 13 ++++++++++---
>   mm/vmstat.c            |  3 +++
>   4 files changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 58e744b78c2c..eda6d2f09d77 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -210,6 +210,9 @@ enum node_stat_item {
>   	NR_PAGETABLE,		/* used for pagetables */
>   #ifdef CONFIG_SWAP
>   	NR_SWAPCACHE,
> +#endif
> +#ifdef CONFIG_NUMA_BALANCING
> +	PGPROMOTE_SUCCESS,	/* promote successfully */
>   #endif
>   	NR_VM_NODE_STAT_ITEMS
>   };
> diff --git a/include/linux/node.h b/include/linux/node.h
> index bb21fd631b16..81bbf1c0afd3 100644
> --- a/include/linux/node.h
> +++ b/include/linux/node.h
> @@ -181,4 +181,9 @@ static inline void register_hugetlbfs_with_node(node_registration_func_t reg,
>   
>   #define to_node(device) container_of(device, struct node, dev)
>   
> +static inline bool node_is_toptier(int node)
> +{
> +	return node_state(node, N_CPU);
> +}
> +
>   #endif /* _LINUX_NODE_H_ */
> diff --git a/mm/migrate.c b/mm/migrate.c
> index cf25b00f03c8..b7c27abb0e5c 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -2141,6 +2141,7 @@ int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
>   	pg_data_t *pgdat = NODE_DATA(node);
>   	int isolated;
>   	int nr_remaining;
> +	int nr_succeeded;
>   	LIST_HEAD(migratepages);
>   	new_page_t *new;
>   	bool compound;
> @@ -2179,7 +2180,8 @@ int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
>   
>   	list_add(&page->lru, &migratepages);
>   	nr_remaining = migrate_pages(&migratepages, *new, NULL, node,
> -				     MIGRATE_ASYNC, MR_NUMA_MISPLACED, NULL);
> +				     MIGRATE_ASYNC, MR_NUMA_MISPLACED,
> +				     &nr_succeeded);
>   	if (nr_remaining) {
>   		if (!list_empty(&migratepages)) {
>   			list_del(&page->lru);
> @@ -2188,8 +2190,13 @@ int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
>   			putback_lru_page(page);
>   		}
>   		isolated = 0;
> -	} else
> -		count_vm_numa_events(NUMA_PAGE_MIGRATE, nr_pages);
> +	}
> +	if (nr_succeeded) {
> +		count_vm_numa_events(NUMA_PAGE_MIGRATE, nr_succeeded);
> +		if (!node_is_toptier(page_to_nid(page)) && node_is_toptier(node))
> +			mod_node_page_state(NODE_DATA(node), PGPROMOTE_SUCCESS,
> +					    nr_succeeded);
> +	}
>   	BUG_ON(!list_empty(&migratepages));
>   	return isolated;
>   
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index d701c335628c..53a6e92b1efb 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -1242,6 +1242,9 @@ const char * const vmstat_text[] = {
>   #ifdef CONFIG_SWAP
>   	"nr_swapcached",
>   #endif
> +#ifdef CONFIG_NUMA_BALANCING
> +	"pgpromote_success",
> +#endif
>   
>   	/* enum writeback_stat_item counters */
>   	"nr_dirty_threshold",
