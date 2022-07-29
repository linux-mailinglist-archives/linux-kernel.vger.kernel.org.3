Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECF94584C15
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 08:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234716AbiG2Gji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 02:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233813AbiG2Gjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 02:39:33 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05266192B7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 23:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659076771; x=1690612771;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=QxPIsZYp1dzDk4XgY8+hubI+o2ZQeHuKi4/q6YVnXDU=;
  b=Sd/EczS640jM5R4dimYA6HD+wgVqOSwZZGwmfSBrfNDWrsxsFYGt4Brm
   U+cAoYOe2beGmvMmLUAMHjTNtMuy+GdSGAyTF9X/134Sg+noUPEVH6+c/
   mk/pRbRKWYqZ9cnpjFP4uV6uLvRYsfXowtwEMYNUdqSM3uS0VrieGXbVY
   zKtJMT3P/i696pyLfFPvcgWFXwxdC576vBlLZyWLznEKZR0Q4yX3mONWY
   Ff2ZBfHYtB+1e+r6YG0J96hd5CafTTn9cSwCNdfgwSEOcPPQLp/0cSU4p
   uWemfAufhkmIPwXyXjTsKIXTBssqKIY4sasxeyBILN0yfgpCa0zBFOVqY
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10422"; a="289475319"
X-IronPort-AV: E=Sophos;i="5.93,200,1654585200"; 
   d="scan'208";a="289475319"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2022 23:39:30 -0700
X-IronPort-AV: E=Sophos;i="5.93,200,1654585200"; 
   d="scan'208";a="690640882"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.94])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2022 23:39:27 -0700
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
Subject: Re: [PATCH v11 8/8] mm/demotion: Update node_is_toptier to work
 with memory tiers
References: <20220728190436.858458-1-aneesh.kumar@linux.ibm.com>
        <20220728190436.858458-9-aneesh.kumar@linux.ibm.com>
Date:   Fri, 29 Jul 2022 14:39:23 +0800
In-Reply-To: <20220728190436.858458-9-aneesh.kumar@linux.ibm.com> (Aneesh
        Kumar K. V.'s message of "Fri, 29 Jul 2022 00:34:36 +0530")
Message-ID: <87sfmkl8x0.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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
>  include/linux/memory-tiers.h | 11 ++++++++++
>  include/linux/node.h         |  5 -----
>  mm/huge_memory.c             |  1 +
>  mm/memory-tiers.c            | 42 ++++++++++++++++++++++++++++++++++++
>  mm/migrate.c                 |  1 +
>  mm/mprotect.c                |  1 +
>  6 files changed, 56 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
> index f8dbeda617a7..bc9fb9d39b2c 100644
> --- a/include/linux/memory-tiers.h
> +++ b/include/linux/memory-tiers.h
> @@ -35,6 +35,7 @@ struct memory_dev_type *init_node_memory_type(int node, struct memory_dev_type *
>  #ifdef CONFIG_MIGRATION
>  int next_demotion_node(int node);
>  void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets);
> +bool node_is_toptier(int node);
>  #else
>  static inline int next_demotion_node(int node)
>  {
> @@ -45,6 +46,11 @@ static inline void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *target
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
> @@ -64,5 +70,10 @@ static inline void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *target
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
> index 40d641a8bfb0..9ec680dd607f 100644
> --- a/include/linux/node.h
> +++ b/include/linux/node.h
> @@ -185,9 +185,4 @@ static inline void register_hugetlbfs_with_node(node_registration_func_t reg,
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
> index 84e2be31a853..36d87dc422ab 100644
> --- a/mm/memory-tiers.c
> +++ b/mm/memory-tiers.c
> @@ -30,6 +30,7 @@ static DEFINE_MUTEX(memory_tier_lock);
>  static LIST_HEAD(memory_tiers);
>  struct memory_dev_type *node_memory_types[MAX_NUMNODES];
>  #ifdef CONFIG_MIGRATION
> +static int top_tier_adistance;
>  /*
>   * node_demotion[] examples:
>   *
> @@ -159,6 +160,31 @@ static struct memory_tier *__node_get_memory_tier(int node)
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
> +	if (memtier->adistance_start >= top_tier_adistance)
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
> @@ -315,6 +341,22 @@ static void establish_demotion_targets(void)
>  			}
>  		} while (1);
>  	}
> +	/*
> +	 * Promotion is allowed from a memory tier to higher
> +	 * memory tier only if the memory tier doesn't include
> +	 * compute. We want to  skip promotion from a memory tier,
> +	 * if any node that is  part of the memory tier have CPUs.
> +	 * Once we detect such a memory tier, we consider that tier
> +	 * as top tiper from which promotion on is not allowed.
> +	 */
> +	list_for_each_entry(memtier, &memory_tiers, list) {
> +		tier_nodes = get_memtier_nodemask(memtier);
> +		nodes_and(tier_nodes, node_states[N_CPU], tier_nodes);
> +		if (!nodes_empty(tier_nodes)) {
> +			top_tier_adistance = memtier->adistance_start;

IMHO, this should be,

			top_tier_adistance = memtier->adistance_start + MEMTIER_CHUNK_SIZE;

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
