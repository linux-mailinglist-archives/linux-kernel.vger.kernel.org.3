Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB1BD478597
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 08:35:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233706AbhLQHfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 02:35:04 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:50920 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233685AbhLQHfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 02:35:03 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R951e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0V-t-QjF_1639726498;
Received: from 30.21.164.42(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0V-t-QjF_1639726498)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 17 Dec 2021 15:34:59 +0800
Message-ID: <f81625ea-51dc-57ec-8833-203ba8345f1c@linux.alibaba.com>
Date:   Fri, 17 Dec 2021 15:35:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH -V10 RESEND 2/6] NUMA balancing: optimize page placement
 for memory tiering system
To:     Huang Ying <ying.huang@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Feng Tang <feng.tang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        Wei Xu <weixugc@google.com>, osalvador <osalvador@suse.de>,
        Shakeel Butt <shakeelb@google.com>,
        Hasan Al Maruf <hasanalmaruf@fb.com>
References: <20211207022757.2523359-1-ying.huang@intel.com>
 <20211207022757.2523359-3-ying.huang@intel.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20211207022757.2523359-3-ying.huang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/7/2021 10:27 AM, Huang Ying wrote:
> With the advent of various new memory types, some machines will have
> multiple types of memory, e.g. DRAM and PMEM (persistent memory).  The
> memory subsystem of these machines can be called memory tiering
> system, because the performance of the different types of memory are
> usually different.
> 
> In such system, because of the memory accessing pattern changing etc,
> some pages in the slow memory may become hot globally.  So in this
> patch, the NUMA balancing mechanism is enhanced to optimize the page
> placement among the different memory types according to hot/cold
> dynamically.
> 
> In a typical memory tiering system, there are CPUs, fast memory and
> slow memory in each physical NUMA node.  The CPUs and the fast memory
> will be put in one logical node (called fast memory node), while the
> slow memory will be put in another (faked) logical node (called slow
> memory node).  That is, the fast memory is regarded as local while the
> slow memory is regarded as remote.  So it's possible for the recently
> accessed pages in the slow memory node to be promoted to the fast
> memory node via the existing NUMA balancing mechanism.
> 
> The original NUMA balancing mechanism will stop to migrate pages if the free
> memory of the target node will become below the high watermark.  This
> is a reasonable policy if there's only one memory type.  But this
> makes the original NUMA balancing mechanism almost not work to optimize page
> placement among different memory types.  Details are as follows.
> 
> It's the common cases that the working-set size of the workload is
> larger than the size of the fast memory nodes.  Otherwise, it's
> unnecessary to use the slow memory at all.  So in the common cases,
> there are almost always no enough free pages in the fast memory nodes,
> so that the globally hot pages in the slow memory node cannot be
> promoted to the fast memory node.  To solve the issue, we have 2
> choices as follows,
> 
> a. Ignore the free pages watermark checking when promoting hot pages
>     from the slow memory node to the fast memory node.  This will
>     create some memory pressure in the fast memory node, thus trigger
>     the memory reclaiming.  So that, the cold pages in the fast memory
>     node will be demoted to the slow memory node.
> 
> b. Make kswapd of the fast memory node to reclaim pages until the free
>     pages are a little more (about 10MB) than the high watermark.  Then,
>     if the free pages of the fast memory node reaches high watermark, and
>     some hot pages need to be promoted, kswapd of the fast memory node
>     will be waken up to demote some cold pages in the fast memory node to
>     the slow memory node.  This will free some extra space in the fast
>     memory node, so the hot pages in the slow memory node can be
>     promoted to the fast memory node.
> 
> The choice "a" will create the memory pressure in the fast memory
> node.  If the memory pressure of the workload is high, the memory
> pressure may become so high that the memory allocation latency of the
> workload is influenced, e.g. the direct reclaiming may be triggered.
> 
> The choice "b" works much better at this aspect.  If the memory
> pressure of the workload is high, the hot pages promotion will stop
> earlier because its allocation watermark is higher than that of the
> normal memory allocation.  So in this patch, choice "b" is
> implemented.
> 
> In addition to the original page placement optimization among sockets,
> the NUMA balancing mechanism is extended to be used to optimize page
> placement according to hot/cold among different memory types.  So the
> sysctl user space interface (numa_balancing) is extended in a backward
> compatible way as follow, so that the users can enable/disable these
> functionality individually.
> 
> The sysctl is converted from a Boolean value to a bits field.  The
> definition of the flags is,
> 
> - 0x0: NUMA_BALANCING_DISABLED
> - 0x1: NUMA_BALANCING_NORMAL
> - 0x2: NUMA_BALANCING_MEMORY_TIERING
> 
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Rik van Riel <riel@surriel.com>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Yang Shi <shy828301@gmail.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Wei Xu <weixugc@google.com>
> Cc: osalvador <osalvador@suse.de>
> Cc: Shakeel Butt <shakeelb@google.com>
> Cc: Hasan Al Maruf <hasanalmaruf@fb.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mm@kvack.org
> ---
>   Documentation/admin-guide/sysctl/kernel.rst | 29 ++++++++++++++-------
>   include/linux/sched/sysctl.h                | 10 +++++++
>   kernel/sched/core.c                         | 21 ++++++++++++---
>   kernel/sysctl.c                             |  3 ++-
>   mm/migrate.c                                | 19 ++++++++++++--
>   mm/vmscan.c                                 | 16 ++++++++++++
>   6 files changed, 82 insertions(+), 16 deletions(-)
> 
> diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
> index 0e486f41185e..5502ea6083ba 100644
> --- a/Documentation/admin-guide/sysctl/kernel.rst
> +++ b/Documentation/admin-guide/sysctl/kernel.rst
> @@ -595,16 +595,23 @@ Documentation/admin-guide/kernel-parameters.rst).
>   numa_balancing
>   ==============
>   
> -Enables/disables automatic page fault based NUMA memory
> -balancing. Memory is moved automatically to nodes
> -that access it often.
> +Enables/disables and configure automatic page fault based NUMA memory
> +balancing.  Memory is moved automatically to nodes that access it
> +often.  The value to set can be the result to OR the following,
>   
> -Enables/disables automatic NUMA memory balancing. On NUMA machines, there
> -is a performance penalty if remote memory is accessed by a CPU. When this
> -feature is enabled the kernel samples what task thread is accessing memory
> -by periodically unmapping pages and later trapping a page fault. At the
> -time of the page fault, it is determined if the data being accessed should
> -be migrated to a local memory node.
> += =================================
> +0x0 NUMA_BALANCING_DISABLED
> +0x1 NUMA_BALANCING_NORMAL
> +0x2 NUMA_BALANCING_MEMORY_TIERING
> += =================================
> +
> +Or NUMA_BALANCING_NORMAL to optimize page placement among different
> +NUMA nodes to reduce remote accessing.  On NUMA machines, there is a
> +performance penalty if remote memory is accessed by a CPU. When this
> +feature is enabled the kernel samples what task thread is accessing
> +memory by periodically unmapping pages and later trapping a page
> +fault. At the time of the page fault, it is determined if the data
> +being accessed should be migrated to a local memory node.
>   
>   The unmapping of pages and trapping faults incur additional overhead that
>   ideally is offset by improved memory locality but there is no universal
> @@ -615,6 +622,10 @@ faults may be controlled by the `numa_balancing_scan_period_min_ms,
>   numa_balancing_scan_delay_ms, numa_balancing_scan_period_max_ms,
>   numa_balancing_scan_size_mb`_, and numa_balancing_settle_count sysctls.
>   
> +Or NUMA_BALANCING_MEMORY_TIERING to optimize page placement among
> +different types of memory (represented as different NUMA nodes) to
> +place the hot pages in the fast memory.  This is implemented based on
> +unmapping and page fault too.
>   
>   numa_balancing_scan_period_min_ms, numa_balancing_scan_delay_ms, numa_balancing_scan_period_max_ms, numa_balancing_scan_size_mb
>   ===============================================================================================================================
> diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
> index 304f431178fd..bc54c1d75d6d 100644
> --- a/include/linux/sched/sysctl.h
> +++ b/include/linux/sched/sysctl.h
> @@ -35,6 +35,16 @@ enum sched_tunable_scaling {
>   	SCHED_TUNABLESCALING_END,
>   };
>   
> +#define NUMA_BALANCING_DISABLED		0x0
> +#define NUMA_BALANCING_NORMAL		0x1
> +#define NUMA_BALANCING_MEMORY_TIERING	0x2
> +
> +#ifdef CONFIG_NUMA_BALANCING
> +extern int sysctl_numa_balancing_mode;
> +#else
> +#define sysctl_numa_balancing_mode	0
> +#endif
> +
>   /*
>    *  control realtime throttling:
>    *
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 3c9b0fda64ac..5dcabc98432f 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -4265,7 +4265,9 @@ DEFINE_STATIC_KEY_FALSE(sched_numa_balancing);
>   
>   #ifdef CONFIG_NUMA_BALANCING
>   
> -void set_numabalancing_state(bool enabled)
> +int sysctl_numa_balancing_mode;
> +
> +static void __set_numabalancing_state(bool enabled)
>   {
>   	if (enabled)
>   		static_branch_enable(&sched_numa_balancing);
> @@ -4273,13 +4275,22 @@ void set_numabalancing_state(bool enabled)
>   		static_branch_disable(&sched_numa_balancing);
>   }
>   
> +void set_numabalancing_state(bool enabled)
> +{
> +	if (enabled)
> +		sysctl_numa_balancing_mode = NUMA_BALANCING_NORMAL;
> +	else
> +		sysctl_numa_balancing_mode = NUMA_BALANCING_DISABLED;
> +	__set_numabalancing_state(enabled);
> +}
> +
>   #ifdef CONFIG_PROC_SYSCTL
>   int sysctl_numa_balancing(struct ctl_table *table, int write,
>   			  void *buffer, size_t *lenp, loff_t *ppos)
>   {
>   	struct ctl_table t;
>   	int err;
> -	int state = static_branch_likely(&sched_numa_balancing);
> +	int state = sysctl_numa_balancing_mode;
>   
>   	if (write && !capable(CAP_SYS_ADMIN))
>   		return -EPERM;
> @@ -4289,8 +4300,10 @@ int sysctl_numa_balancing(struct ctl_table *table, int write,
>   	err = proc_dointvec_minmax(&t, write, buffer, lenp, ppos);
>   	if (err < 0)
>   		return err;
> -	if (write)
> -		set_numabalancing_state(state);
> +	if (write) {
> +		sysctl_numa_balancing_mode = state;
> +		__set_numabalancing_state(state);
> +	}
>   	return err;
>   }
>   #endif
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 083be6af29d7..a1be94ea80ba 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -115,6 +115,7 @@ static int sixty = 60;
>   
>   static int __maybe_unused neg_one = -1;
>   static int __maybe_unused two = 2;
> +static int __maybe_unused three = 3;
>   static int __maybe_unused four = 4;
>   static unsigned long zero_ul;
>   static unsigned long one_ul = 1;
> @@ -1808,7 +1809,7 @@ static struct ctl_table kern_table[] = {
>   		.mode		= 0644,
>   		.proc_handler	= sysctl_numa_balancing,
>   		.extra1		= SYSCTL_ZERO,
> -		.extra2		= SYSCTL_ONE,
> +		.extra2		= &three,
>   	},
>   #endif /* CONFIG_NUMA_BALANCING */
>   	{
> diff --git a/mm/migrate.c b/mm/migrate.c
> index b7c27abb0e5c..286c84c014dd 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -50,6 +50,7 @@
>   #include <linux/ptrace.h>
>   #include <linux/oom.h>
>   #include <linux/memory.h>
> +#include <linux/sched/sysctl.h>
>   
>   #include <asm/tlbflush.h>
>   
> @@ -2103,16 +2104,30 @@ static int numamigrate_isolate_page(pg_data_t *pgdat, struct page *page)
>   {
>   	int page_lru;
>   	int nr_pages = thp_nr_pages(page);
> +	int order = compound_order(page);
>   
> -	VM_BUG_ON_PAGE(compound_order(page) && !PageTransHuge(page), page);
> +	VM_BUG_ON_PAGE(order && !PageTransHuge(page), page);
>   
>   	/* Do not migrate THP mapped by multiple processes */
>   	if (PageTransHuge(page) && total_mapcount(page) > 1)
>   		return 0;
>   
>   	/* Avoid migrating to a node that is nearly full */
> -	if (!migrate_balanced_pgdat(pgdat, nr_pages))
> +	if (!migrate_balanced_pgdat(pgdat, nr_pages)) {
> +		int z;
> +
> +		if (!(sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING) ||
> +		    !numa_demotion_enabled)
> +			return 0;
> +		if (next_demotion_node(pgdat->node_id) == NUMA_NO_NODE)
> +			return 0;
> +		for (z = pgdat->nr_zones - 1; z >= 0; z--) {
> +			if (populated_zone(pgdat->node_zones + z))
> +				break;
> +		}
> +		wakeup_kswapd(pgdat->node_zones + z, 0, order, ZONE_MOVABLE);
>   		return 0;
> +	}
>   
>   	if (isolate_lru_page(page))
>   		return 0;
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index c266e64d2f7e..5edb5dfa8900 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -56,6 +56,7 @@
>   
>   #include <linux/swapops.h>
>   #include <linux/balloon_compaction.h>
> +#include <linux/sched/sysctl.h>
>   
>   #include "internal.h"
>   
> @@ -3919,6 +3920,12 @@ static bool pgdat_watermark_boosted(pg_data_t *pgdat, int highest_zoneidx)
>   	return false;
>   }
>   
> +/*
> + * Keep the free pages on fast memory node a little more than the high
> + * watermark to accommodate the promoted pages.
> + */
> +#define NUMA_BALANCING_PROMOTE_WATERMARK	(10UL * 1024 * 1024 >> PAGE_SHIFT)

 From our testing the fixed promote wartermark is not suitable for all 
scenarios, but as you said, I also agree with that we can start from a 
simplest solution that works. So please feel free to add:

Tested-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> +
>   /*
>    * Returns true if there is an eligible zone balanced for the request order
>    * and highest_zoneidx
> @@ -3940,6 +3947,15 @@ static bool pgdat_balanced(pg_data_t *pgdat, int order, int highest_zoneidx)
>   			continue;
>   
>   		mark = high_wmark_pages(zone);
> +		if (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING &&
> +		    numa_demotion_enabled &&
> +		    next_demotion_node(pgdat->node_id) != NUMA_NO_NODE) {
> +			unsigned long promote_mark;
> +
> +			promote_mark = min(NUMA_BALANCING_PROMOTE_WATERMARK,
> +					   pgdat->node_present_pages >> 6);
> +			mark += promote_mark;
> +		}
>   		if (zone_watermark_ok_safe(zone, order, mark, highest_zoneidx))
>   			return true;
>   	}
