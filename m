Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77D28575CD3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 09:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232402AbiGOHxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 03:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbiGOHxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 03:53:48 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0A711C1F
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 00:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657871626; x=1689407626;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=x/yTnY3wBHEpDL3ZzTEI8pYmzlYgS435hhzAGVgEBwo=;
  b=hL2kXi/jgCmrNg2D2NbJVYfiDw9EaBI2iYymDNcZejtlPtd719Zrp9Mk
   VOVeLVE0ravpczoOqKuVS5M7h43cJ7mUh4/MEa5dL2g21KLucNM6UpH0F
   5Dc+PDx62DSnl5soDGFGRISLBV7EDtJKcFrtKVUV7a5CmK2LwrWop3xpM
   beTyT20uWuebcCEKACqcvpGGwirnvUSlwXy4iryHT411+y77wkEeK74Ta
   4+j5OQk+ALA19F0aTKhxR0fx+zNUA7HoNMwqO0LugkS9FW81LEd8wgRg7
   99wmCXBwj23vQeD4NvZ2AA7yEf+DJz4W2QnOM4ZkplHOZRmaeNEXUVxAi
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="372044396"
X-IronPort-AV: E=Sophos;i="5.92,273,1650956400"; 
   d="scan'208";a="372044396"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2022 00:53:45 -0700
X-IronPort-AV: E=Sophos;i="5.92,273,1650956400"; 
   d="scan'208";a="571428075"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.94])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2022 00:53:40 -0700
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
        Johannes Weiner <hannes@cmpxchg.org>, jvgediya.oss@gmail.com,
        Jagdish Gediya <jvgediya@linux.ibm.com>
Subject: Re: [PATCH v9 1/8] mm/demotion: Add support for explicit memory tiers
References: <20220714045351.434957-1-aneesh.kumar@linux.ibm.com>
        <20220714045351.434957-2-aneesh.kumar@linux.ibm.com>
Date:   Fri, 15 Jul 2022 15:53:28 +0800
In-Reply-To: <20220714045351.434957-2-aneesh.kumar@linux.ibm.com> (Aneesh
        Kumar K. V.'s message of "Thu, 14 Jul 2022 10:23:44 +0530")
Message-ID: <87bktq4xs7.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

> In the current kernel, memory tiers are defined implicitly via a
> demotion path relationship between NUMA nodes, which is created
> during the kernel initialization and updated when a NUMA node is
> hot-added or hot-removed.  The current implementation puts all
> nodes with CPU into the top tier, and builds the tier hierarchy
> tier-by-tier by establishing the per-node demotion targets based
> on the distances between nodes.
>
> This current memory tier kernel interface needs to be improved for
> several important use cases,
>
> The current tier initialization code always initializes
> each memory-only NUMA node into a lower tier.  But a memory-only
> NUMA node may have a high performance memory device (e.g. a DRAM
> device attached via CXL.mem or a DRAM-backed memory-only node on
> a virtual machine) and should be put into a higher tier.
>
> The current tier hierarchy always puts CPU nodes into the top
> tier. But on a system with HBM or GPU devices, the
> memory-only NUMA nodes mapping these devices should be in the
> top tier, and DRAM nodes with CPUs are better to be placed into the
> next lower tier.
>
> With current kernel higher tier node can only be demoted to selected nodes on the
> next lower tier as defined by the demotion path, not any other
> node from any lower tier.  This strict, hard-coded demotion order
> does not work in all use cases (e.g. some use cases may want to
> allow cross-socket demotion to another node in the same demotion
> tier as a fallback when the preferred demotion node is out of
> space), This demotion order is also inconsistent with the page
> allocation fallback order when all the nodes in a higher tier are
> out of space: The page allocation can fall back to any node from
> any lower tier, whereas the demotion order doesn't allow that.
>
> The current kernel also don't provide any interfaces for the
> userspace to learn about the memory tier hierarchy in order to
> optimize its memory allocations.
>
> This patch series address the above by defining memory tiers explicitly.
>
> This patch introduce explicity memory tiers. The tier ID value
> of a memory tier is used to derive the demotion order between
> NUMA nodes.
>
> For example, if we have 3 memtiers: memtier100, memtier200, memiter300
> then the memory tier order is: memtier300 -> memtier200 -> memtier100
> where memtier300 is the highest tier and memtier100 is the lowest tier.
>
> While reclaim we migrate pages from fast(higher) tiers to slow(lower)
> tiers when the fast(higher) tier is under memory pressure.
>
> This patchset introduce 3 memory tiers (memtier100, memtier200 and memtier300)
> which are created by different kernel subsystems. The default memory
> tier created by the kernel is memtier200. A kernel parameter is provided
> to override the default memory tier.
>
> Link: https://lore.kernel.org/linux-mm/CAAPL-u9Wv+nH1VOZTj=9p9S70Y3Qz3+63EkqncRDdHfubsrjfw@mail.gmail.com
> Link: https://lore.kernel.org/linux-mm/7b72ccf4-f4ae-cb4e-f411-74d055482026@linux.ibm.com
>
> Signed-off-by: Jagdish Gediya <jvgediya@linux.ibm.com>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
>  include/linux/memory-tiers.h | 15 +++++++
>  mm/Makefile                  |  1 +
>  mm/memory-tiers.c            | 78 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 94 insertions(+)
>  create mode 100644 include/linux/memory-tiers.h
>  create mode 100644 mm/memory-tiers.c
>
> diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
> new file mode 100644
> index 000000000000..a81dbc20e0d1
> --- /dev/null
> +++ b/include/linux/memory-tiers.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_MEMORY_TIERS_H
> +#define _LINUX_MEMORY_TIERS_H
> +
> +#ifdef CONFIG_NUMA
> +
> +#define MEMORY_TIER_HBM_GPU	300
> +#define MEMORY_TIER_DRAM	200
> +#define MEMORY_TIER_PMEM	100
> +
> +#define DEFAULT_MEMORY_TIER	MEMORY_TIER_DRAM
> +#define MAX_MEMORY_TIER_ID	400
> +
> +#endif	/* CONFIG_NUMA */
> +#endif  /* _LINUX_MEMORY_TIERS_H */
> diff --git a/mm/Makefile b/mm/Makefile
> index 6f9ffa968a1a..d30acebc2164 100644
> --- a/mm/Makefile
> +++ b/mm/Makefile
> @@ -92,6 +92,7 @@ obj-$(CONFIG_KFENCE) += kfence/
>  obj-$(CONFIG_FAILSLAB) += failslab.o
>  obj-$(CONFIG_MEMTEST)		+= memtest.o
>  obj-$(CONFIG_MIGRATION) += migrate.o
> +obj-$(CONFIG_NUMA) += memory-tiers.o
>  obj-$(CONFIG_DEVICE_MIGRATION) += migrate_device.o
>  obj-$(CONFIG_TRANSPARENT_HUGEPAGE) += huge_memory.o khugepaged.o
>  obj-$(CONFIG_PAGE_COUNTER) += page_counter.o
> diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
> new file mode 100644
> index 000000000000..011877b6dbb9
> --- /dev/null
> +++ b/mm/memory-tiers.c
> @@ -0,0 +1,78 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/types.h>
> +#include <linux/nodemask.h>
> +#include <linux/slab.h>
> +#include <linux/lockdep.h>
> +#include <linux/moduleparam.h>
> +#include <linux/memory-tiers.h>
> +
> +struct memory_tier {
> +	struct list_head list;
> +	int id;
> +	nodemask_t nodelist;
> +};
> +
> +static DEFINE_MUTEX(memory_tier_lock);
> +static LIST_HEAD(memory_tiers);
> +
> +static void insert_memory_tier(struct memory_tier *memtier)
> +{
> +	struct list_head *ent;
> +	struct memory_tier *tmp_memtier;
> +
> +	lockdep_assert_held_once(&memory_tier_lock);
> +
> +	list_for_each(ent, &memory_tiers) {
> +		tmp_memtier = list_entry(ent, struct memory_tier, list);
> +		if (tmp_memtier->id < memtier->id) {
> +			list_add_tail(&memtier->list, ent);
> +			return;
> +		}
> +	}
> +	list_add_tail(&memtier->list, &memory_tiers);
> +}
> +
> +static struct memory_tier *register_memory_tier(unsigned int tier)
> +{
> +	struct memory_tier *memtier;
> +
> +	if (tier > MAX_MEMORY_TIER_ID)
> +		return ERR_PTR(-EINVAL);
> +
> +	memtier = kzalloc(sizeof(struct memory_tier), GFP_KERNEL);
> +	if (!memtier)
> +		return ERR_PTR(-ENOMEM);
> +
> +	memtier->id   = tier;
> +
> +	insert_memory_tier(memtier);
> +
> +	return memtier;
> +}
> +
> +static unsigned int default_memtier = DEFAULT_MEMORY_TIER;
> +core_param(default_memory_tier, default_memtier, uint, 0644);
> +
> +static int __init memory_tier_init(void)
> +{
> +	struct memory_tier *memtier;
> +
> +	/*
> +	 * Register only default memory tier to hide all empty
> +	 * memory tier from sysfs. Since this is early during
> +	 * boot, we could avoid holding memtory_tier_lock. But
> +	 * keep it simple by holding locks. So we can add lock
> +	 * held debug checks in other functions.
> +	 */
> +	mutex_lock(&memory_tier_lock);
> +	memtier = register_memory_tier(default_memtier);
> +	if (IS_ERR(memtier))
> +		panic("%s() failed to register memory tier: %ld\n",
> +		      __func__, PTR_ERR(memtier));
> +
> +	/* CPU only nodes are not part of memory tiers. */
> +	memtier->nodelist = node_states[N_MEMORY];
> +	mutex_unlock(&memory_tier_lock);
> +	return 0;
> +}
> +subsys_initcall(memory_tier_init);

You dropped the original sysfs interface patches from the series, but
the kernel internal implementation is still for the original sysfs
interface.  For example, memory tier ID is for the original sysfs
interface, not for the new proposed sysfs interface.  So I suggest you
to implement with the new interface in mind.  What do you think about
the following design?

- Each NUMA node belongs to a memory type, and each memory type
  corresponds to a "abstract distance", so each NUMA node corresonds to
  a "distance".  For simplicity, we can start with static distances, for
  example, DRAM (default): 150, PMEM: 250.  The distance of each NUMA
  node can be recorded in a global array,

    int node_distances[MAX_NUMNODES];

  or, just

    pgdat->distance

- Each memory tier corresponds to a range of distance, for example,
  0-100, 100-200, 200-300, >300, we can start with static ranges too.

- The core API of memory tier could be

    struct memory_tier *find_create_memory_tier(int distance);

  it will find the memory tier which covers "distance" in the memory
  tier list, or create a new memory tier if not found.

- kmem_dax driver will setup distance for PMEM NUMA nodes before online
  them.

- When a NUMA node is onlined, we will use find_create_memory_tier() to
  find or create its memory tier and add the NUMA node into the memory
  tier.

- Or we can add memory type data structure now.

Best Regards,
Huang, Ying
