Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F095457FBCC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 10:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234305AbiGYIyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 04:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234146AbiGYIyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 04:54:21 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB2614D1A
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 01:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658739260; x=1690275260;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=OrzwBXpnNbo5Nk2jFhqfvGwcX5FcuWicAaomGIwDPHo=;
  b=l2i916UvKAxKh9ZZtghbrL5PalwgkBcRqJ15ZnMb4kHiLjslqLy3b7UB
   7w/yeZUjobhCgjKWDCdenp6QxQapboB9SMw0YUmR4brusZTF/ci1Dzm3Z
   /dIEX++4jLvYR4ZrKrOgSZUicFrXHrxBfVu6NnP7n80AY82bCExF8tB0a
   4p+LNmboJ83t5ALAFlBPMiA7E+EO9JzJ3Ke5Y+isZt3eq2SXSN0/ShClx
   K6rKgIL9DfHuWy39nAlVqNfrzCPLA6viazjNQ7gO8zcZW4gdVwCA+MHR0
   lY4WCshs47FSB+U5oExopIgr9jtbmlPHFxPRsax83ADJhWLTQFjMTWlSj
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10418"; a="373953216"
X-IronPort-AV: E=Sophos;i="5.93,192,1654585200"; 
   d="scan'208";a="373953216"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2022 01:54:20 -0700
X-IronPort-AV: E=Sophos;i="5.93,192,1654585200"; 
   d="scan'208";a="632283294"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.94])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2022 01:54:16 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        Wei Xu <weixugc@google.com>, Yang Shi <shy828301@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim C Chen <tim.c.chen@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>, jvgediya.oss@gmail.com
Subject: Re: [PATCH v10 8/8] mm/demotion: Update node_is_toptier to work
 with memory tiers
References: <20220720025920.1373558-1-aneesh.kumar@linux.ibm.com>
        <20220720025920.1373558-9-aneesh.kumar@linux.ibm.com>
Date:   Mon, 25 Jul 2022 16:54:11 +0800
In-Reply-To: <20220720025920.1373558-9-aneesh.kumar@linux.ibm.com> (Aneesh
        Kumar K. V.'s message of "Wed, 20 Jul 2022 08:29:20 +0530")
Message-ID: <87ilnly3m4.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:

> With memory tiers support we can have memory only NUMA nodes
> in the top tier from which we want to avoid promotion tracking NUMA
> faults. Update node_is_toptier to work with memory tiers.
> All NUMA nodes are by default top tier nodes. With lower memory
> tiers added we consider all memory tiers above a memory tier having
> CPU NUMA nodes as a top memory tier
>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
>  include/linux/memory-tiers.h | 11 +++++++++
>  include/linux/node.h         |  5 -----
>  mm/huge_memory.c             |  1 +
>  mm/memory-tiers.c            | 43 ++++++++++++++++++++++++++++++++++++
>  mm/migrate.c                 |  1 +
>  mm/mprotect.c                |  1 +
>  6 files changed, 57 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
> index 0e58588fa066..085dd815bf73 100644
> --- a/include/linux/memory-tiers.h
> +++ b/include/linux/memory-tiers.h
> @@ -20,6 +20,7 @@ extern bool numa_demotion_enabled;
>  #ifdef CONFIG_MIGRATION
>  int next_demotion_node(int node);
>  void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets);
> +bool node_is_toptier(int node);
>  #else
>  static inline int next_demotion_node(int node)
>  {
> @@ -30,6 +31,11 @@ static inline void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *target
>  {
>  	*targets = NODE_MASK_NONE;
>  }
> +
> +static inline bool node_is_toptier(int node)
> +{
> +	return true;
> +}
>  #endif
>  
>  #else
> @@ -44,5 +50,10 @@ static inline void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *target
>  {
>  	*targets = NODE_MASK_NONE;
>  }
> +
> +static inline bool node_is_toptier(int node)
> +{
> +	return true;
> +}
>  #endif	/* CONFIG_NUMA */
>  #endif  /* _LINUX_MEMORY_TIERS_H */
> diff --git a/include/linux/node.h b/include/linux/node.h
> index a2a16d4104fd..d0432db18094 100644
> --- a/include/linux/node.h
> +++ b/include/linux/node.h
> @@ -191,9 +191,4 @@ static inline void register_hugetlbfs_with_node(node_registration_func_t reg,
>  
>  #define to_node(device) container_of(device, struct node, dev)
>  
> -static inline bool node_is_toptier(int node)
> -{
> -	return node_state(node, N_CPU);
> -}
> -
>  #endif /* _LINUX_NODE_H_ */
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 834f288b3769..8405662646e9 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -35,6 +35,7 @@
>  #include <linux/numa.h>
>  #include <linux/page_owner.h>
>  #include <linux/sched/sysctl.h>
> +#include <linux/memory-tiers.h>
>  
>  #include <asm/tlb.h>
>  #include <asm/pgalloc.h>
> diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
> index 4a96e4213d66..f0515bfd4051 100644
> --- a/mm/memory-tiers.c
> +++ b/mm/memory-tiers.c
> @@ -13,6 +13,7 @@
>  
>  struct memory_tier {
>  	struct list_head list;
> +	int id;
>  	int perf_level;
>  	nodemask_t nodelist;
>  	nodemask_t lower_tier_mask;
> @@ -26,6 +27,7 @@ static LIST_HEAD(memory_tiers);
>  static DEFINE_MUTEX(memory_tier_lock);
>  
>  #ifdef CONFIG_MIGRATION
> +static int top_tier_id;
>  /*
>   * node_demotion[] examples:
>   *
> @@ -129,6 +131,7 @@ static struct memory_tier *find_create_memory_tier(unsigned int perf_level)
>  	if (!new_memtier)
>  		return ERR_PTR(-ENOMEM);
>  
> +	new_memtier->id = perf_level >> MEMTIER_CHUNK_BITS;
>  	new_memtier->perf_level = perf_level;
>  	if (found_slot)
>  		list_add_tail(&new_memtier->list, ent);
> @@ -154,6 +157,31 @@ static struct memory_tier *__node_get_memory_tier(int node)
>  }
>  
>  #ifdef CONFIG_MIGRATION
> +bool node_is_toptier(int node)
> +{
> +	bool toptier;
> +	pg_data_t *pgdat;
> +	struct memory_tier *memtier;
> +
> +	pgdat = NODE_DATA(node);
> +	if (!pgdat)
> +		return false;
> +
> +	rcu_read_lock();
> +	memtier = rcu_dereference(pgdat->memtier);
> +	if (!memtier) {
> +		toptier = true;
> +		goto out;
> +	}
> +	if (memtier->id >= top_tier_id)
> +		toptier = true;
> +	else
> +		toptier = false;
> +out:
> +	rcu_read_unlock();
> +	return toptier;
> +}
> +
>  void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets)
>  {
>  	struct memory_tier *memtier;
> @@ -304,6 +332,21 @@ static void establish_migration_targets(void)
>  			}
>  		} while (1);
>  	}
> +	/*
> +	 * Promotion is allowed from a memory tier to higher
> +	 * memory tier only if the memory tier doesn't include
> +	 * compute. We want to  skip promotion from a memory tier,
> +	 * if any node that is  part of the memory tier have CPUs.
> +	 * Once we detect such a memory tier, we consider that tier
> +	 * as top tiper from which promotion is not allowed.
> +	 */
> +	list_for_each_entry_reverse(memtier, &memory_tiers, list) {
> +		nodes_and(used, node_states[N_CPU], memtier->nodelist);
> +		if (!nodes_empty(used)) {
> +			top_tier_id = memtier->id;

I don't think we need to introduce memory tier ID for this.  We can add
a top_tier_perf_level, set it here and use it in node_is_toptier().

Best Regards,
Huang, Ying

> +			break;
> +		}
> +	}
>  	/*
>  	 * Now build the lower_tier mask for each node collecting node mask from
>  	 * all memory tier below it. This allows us to fallback demotion page
> diff --git a/mm/migrate.c b/mm/migrate.c
> index c758c9c21d7d..1da81136eaaa 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -50,6 +50,7 @@
>  #include <linux/memory.h>
>  #include <linux/random.h>
>  #include <linux/sched/sysctl.h>
> +#include <linux/memory-tiers.h>
>  
>  #include <asm/tlbflush.h>
>  
> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index ba5592655ee3..92a2fc0fa88b 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -31,6 +31,7 @@
>  #include <linux/pgtable.h>
>  #include <linux/sched/sysctl.h>
>  #include <linux/userfaultfd_k.h>
> +#include <linux/memory-tiers.h>
>  #include <asm/cacheflush.h>
>  #include <asm/mmu_context.h>
>  #include <asm/tlbflush.h>
