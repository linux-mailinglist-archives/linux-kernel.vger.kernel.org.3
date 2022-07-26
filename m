Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9306580A1E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 05:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbiGZDxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 23:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiGZDxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 23:53:47 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D912982A
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 20:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658807625; x=1690343625;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=cLxpnh430w6GdWDAGIQb0qrxvvmjCVCOOn9RuEF19iY=;
  b=TBTcY+UrSwjj1SwuU550YX9n924wfd4WNq8OAp5YqU404TXOZWxp41cB
   GizmXmnpxMpXdU2Px/QFsSWqNKQYzCwZlly//C1yTSRNw9Lc4XDYjhquT
   0vt2LwzCdR3soq2kqvCalqsZ9fTenq66dJ+k3Vd/cu+LODlOdkfp79k3k
   FtrLg7az1X28NgTyNHRfkJSjvIVy9IOvNF62kuky6pWTDrFU4MYyy5S5k
   ABXgkF1nBpKoSd37v/uw+zEjzRX4olu1Vh39qkyesJDOk9xLktG4uPhL3
   4kYoMWHIy4xFRcsjY5SvchbafFMCoT8uXq2rUz3bKEEyW/v/JXlPgDpX1
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10419"; a="289041423"
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="289041423"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2022 20:53:45 -0700
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="550243023"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.94])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2022 20:53:41 -0700
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
Subject: Re: [PATCH v10 1/8] mm/demotion: Add support for explicit memory tiers
References: <20220720025920.1373558-1-aneesh.kumar@linux.ibm.com>
        <20220720025920.1373558-2-aneesh.kumar@linux.ibm.com>
Date:   Tue, 26 Jul 2022 11:53:28 +0800
In-Reply-To: <20220720025920.1373558-2-aneesh.kumar@linux.ibm.com> (Aneesh
        Kumar K. V.'s message of "Wed, 20 Jul 2022 08:29:13 +0530")
Message-ID: <87k080wmvb.fsf@yhuang6-desk2.ccr.corp.intel.com>
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
> nodes with CPU into the top tier,
                          ~~~~~~~~

Because we will change the semantics of "top tier" later in the
patchset, I suggest to replace "top tier" with "highest tier" in the
patch description to avoid potential confusing.

> and builds the tier hierarchy
> tier-by-tier by establishing the per-node demotion targets based
> on the distances between nodes.
>
> This current memory tier kernel interface needs to be improved for
                                  ~~~~~~~~~

s/interface/implementation/

> several important use cases,
>
> The current tier initialization code always initializes
> each memory-only NUMA node into a lower tier.  But a memory-only
> NUMA node may have a high performance memory device (e.g. a DRAM
> device attached via CXL.mem

Per my understanding, CXL attached DRAM may be put in a lower tier in
some use cases, such as the one in the following paper from Meta,

https://arxiv.org/pdf/2206.02878.pdf

So I suggest to remove this use case here.

> or a DRAM-backed memory-only node on
> a virtual machine) and should be put into a higher tier.
>
> The current tier hierarchy always puts CPU nodes into the top
> tier. But on a system with HBM or GPU devices, the
> memory-only NUMA nodes mapping these devices should be in the
> top tier, and DRAM nodes with CPUs are better to be placed into the
> next lower tier.
>
> With current kernel higher tier node can only be demoted to selected nodes on the
                                                              ~~~~~~~~~~~~~~

nodes with shortest distance

> next lower tier as defined by the demotion path, not any other
> node from any lower tier.  This strict, hard-coded demotion order
                                          ~~~~~~~~~~

The demotion path is generated automatically instead of hard-coded.  So
I suggest to remove "hard-coded", "too strict" should be enough to
describe the current issue.

> does not work in all use cases (e.g. some use cases may want to
> allow cross-socket demotion to another node in the same demotion
> tier as a fallback when the preferred demotion node is out of
> space), This demotion order is also inconsistent with the page
> allocation fallback order when all the nodes in a higher tier are
> out of space: The page allocation can fall back to any node from
> any lower tier, whereas the demotion order doesn't allow that.

I can understand the description above.  But I think an example may be
easier to be understood.

> The current kernel also don't provide any interfaces for the
> userspace to learn about the memory tier hierarchy in order to
> optimize its memory allocations.

We don't provide user space interface in this patchset, so we should
remove this paragraph?

In addition to the above, I think the explicit memory tier make it easier
to manage memory tiers and build additional mechanisms on top of it,
e.g., demotion, promotion, partitioning, interleaving, etc.

> This patch series address the above by defining memory tiers explicitly.
>
> Linux kernel presents memory devices as NUMA nodes and each memory device is of
> a specific type. The memory type of a device is represented by its performance
> level. A memory tier corresponds to a range of performance levels. This allows
> for classifying memory devices with a specific performance range into a memory
> tier.
>
> This patch configures the range/chunk size to be 128. The default DRAM
> performance level is 512. We can have 4 memory tiers below the default DRAM
> performance level which cover the range 0 - 127, 127 - 255, 256- 383, 384 - 511.
> Slower memory devices like persistent memory will have performance levels below
> the default DRAM level and hence will be placed in these 4 lower tiers.
>
> While reclaim we migrate pages from fast(higher) tiers to slow(lower) tiers when
> the fast(higher) tier is under memory pressure.

This appears not related to the patch?

> A kernel parameter is provided to override the default memory tier.
>
> Link: https://lore.kernel.org/linux-mm/CAAPL-u9Wv+nH1VOZTj=9p9S70Y3Qz3+63EkqncRDdHfubsrjfw@mail.gmail.com
> Link: https://lore.kernel.org/linux-mm/7b72ccf4-f4ae-cb4e-f411-74d055482026@linux.ibm.com
>
> Signed-off-by: Jagdish Gediya <jvgediya@linux.ibm.com>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
>  include/linux/memory-tiers.h |  18 +++++++
>  include/linux/node.h         |   6 +++
>  mm/Makefile                  |   1 +
>  mm/memory-tiers.c            | 101 +++++++++++++++++++++++++++++++++++
>  4 files changed, 126 insertions(+)
>  create mode 100644 include/linux/memory-tiers.h
>  create mode 100644 mm/memory-tiers.c
>
> diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
> new file mode 100644
> index 000000000000..f28f9910a4e7
> --- /dev/null
> +++ b/include/linux/memory-tiers.h
> @@ -0,0 +1,18 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_MEMORY_TIERS_H
> +#define _LINUX_MEMORY_TIERS_H
> +
> +#ifdef CONFIG_NUMA
> +/*
> + * Each tier cover a performance level chunk size of 128
> + */
> +#define MEMTIER_CHUNK_BITS	7

Instead of playing with BITS always, it may be easier to use _SIZE too.

#define MEMTIER_CHUNK_SIZE	(1 << MEMTIER_CHUNK_BITS)

> +/*
> + * For now let's have 4 memory tier below default DRAM tier.
> + */
> +#define MEMTIER_PERF_LEVEL_DRAM	(1 << (MEMTIER_CHUNK_BITS + 2))
> +/* leave one tier below this slow pmem */
> +#define MEMTIER_PERF_LEVEL_PMEM	(1 << MEMTIER_CHUNK_BITS)
> +
> +#endif	/* CONFIG_NUMA */
> +#endif  /* _LINUX_MEMORY_TIERS_H */
> diff --git a/include/linux/node.h b/include/linux/node.h
> index 40d641a8bfb0..a2a16d4104fd 100644
> --- a/include/linux/node.h
> +++ b/include/linux/node.h
> @@ -92,6 +92,12 @@ struct node {
>  	struct list_head cache_attrs;
>  	struct device *cache_dev;
>  #endif
> +	/*
> +	 * For memory devices, perf_level describes
> +	 * the device performance and how it should be used
> +	 * while building a memory hierarchy.
> +	 */
> +	int perf_level;

Think again, I found that "perf_level" may be not the best abstraction
of the performance of memory devices.  In concept, it's an abstraction of the memory
bandwidth.  But it will not reflect the memory latency.

Instead, the previous proposed "abstract_distance" is an abstraction of
the memory latency.  Per my understanding, the memory latency has more
direct influence on system performance.  And because the latency of the
memory device will increase if the memory accessing throughput nears its
max bandwidth, so the memory bandwidth can be reflected in the "abstract
distance" too.  That is, the "abstract distance" is an abstraction of
the memory latency under the expected memory accessing throughput.  The
"offset" to the default "abstract distance" reflects the different
expected memory accessing throughput.

So, I think we need some kind of abstraction of the memory latency
instead of memory bandwidth, e.g., "abstract distance".

>  };
>  
>  struct memory_block;
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
> index 000000000000..61bb84c54091
> --- /dev/null
> +++ b/mm/memory-tiers.c
> @@ -0,0 +1,101 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/types.h>
> +#include <linux/nodemask.h>
> +#include <linux/slab.h>
> +#include <linux/lockdep.h>
> +#include <linux/moduleparam.h>
> +#include <linux/node.h>
> +#include <linux/memory-tiers.h>
> +
> +struct memory_tier {
> +	struct list_head list;
> +	int perf_level;

Because memory_tier corresponds to a range of perf_levels, I think the
better name is "perf_level_start".  And, we can add some comments about
the range, that is, perf_level_start .. per_level_start + MEMTIER_CHUNK_SIZE.

> +	nodemask_t nodelist;

I don't think nodelist is good name here.  It's a bitmask instead of
linked list.  I suggest to use "nodemask" or "nodes".

> +};
> +
> +static LIST_HEAD(memory_tiers);
> +static DEFINE_MUTEX(memory_tier_lock);
> +
> +/*
> + * For now let's have 4 memory tier below default DRAM tier.
> + */
> +static unsigned int default_memtier_perf_level = MEMTIER_PERF_LEVEL_DRAM;
> +core_param(default_memory_tier_perf_level, default_memtier_perf_level, uint, 0644);

Do you have any existing use case of the kernel parameter?  If not, we
can add some kind of knob when the use cases are clear.

We don't even need default_memtier_perf_level for now, why not just use
MEMTIER_PERF_LEVEL_DRAM?

> +/*
> + * performance levels are grouped into memtiers each of chunk size
> + * memtier_perf_chunk
> + */
> +static struct memory_tier *find_create_memory_tier(unsigned int perf_level)
> +{
> +	bool found_slot = false;
> +	struct list_head *ent;
> +	struct memory_tier *memtier, *new_memtier;
> +	unsigned int memtier_perf_chunk_size = 1 << MEMTIER_CHUNK_BITS;
> +	/*
> +	 * zero is special in that it indicates uninitialized
> +	 * perf level by respective driver. Pick default memory
> +	 * tier perf level for that.
> +	 */
> +	if (!perf_level)
> +		perf_level = default_memtier_perf_level;
> +
> +	lockdep_assert_held_once(&memory_tier_lock);
> +
> +	perf_level = round_down(perf_level, memtier_perf_chunk_size);
> +	list_for_each(ent, &memory_tiers) {

We can use list_for_each_entry(memtier, &memory_tiers) here.  When we
need to insert into list below, we can use

  list_add_tail(&new_memtier->list, &memtier->list);

> +		memtier = list_entry(ent, struct memory_tier, list);
> +		if (perf_level == memtier->perf_level) {
> +			return memtier;
> +		} else if (perf_level < memtier->perf_level) {
> +			found_slot = true;
> +			break;
> +		}
> +	}
> +
> +	new_memtier = kzalloc(sizeof(struct memory_tier), GFP_KERNEL);
> +	if (!new_memtier)
> +		return ERR_PTR(-ENOMEM);
> +
> +	new_memtier->perf_level = perf_level;
> +	if (found_slot)
> +		list_add_tail(&new_memtier->list, ent);
> +	else
> +		list_add_tail(&new_memtier->list, &memory_tiers);
> +	return new_memtier;
> +}
> +
> +static int __init memory_tier_init(void)
> +{
> +	int node;
> +	struct memory_tier *memtier;
> +
> +	/*
> +	 * Since this is early during  boot, we could avoid
> +	 * holding memtory_tier_lock. But keep it simple by
> +	 * holding locks. So we can add lock held debug checks
> +	 * in other functions.
> +	 */

I don't think the comments above is necessary.  Acquiring a uncontended
lock in a slow path isn't a big deal.

> +	mutex_lock(&memory_tier_lock);
> +	memtier = find_create_memory_tier(default_memtier_perf_level);
> +	if (IS_ERR(memtier))
> +		panic("%s() failed to register memory tier: %ld\n",
> +		      __func__, PTR_ERR(memtier));
> +
> +	/* CPU only nodes are not part of memory tiers. */
> +	memtier->nodelist = node_states[N_MEMORY];
> +
> +	/*
> +	 * nodes that are already online and that doesn't
> +	 * have perf level assigned is assigned a default perf
> +	 * level.
> +	 */
> +	for_each_node_state(node, N_MEMORY) {
> +		struct node *node_property = node_devices[node];
> +
> +		if (!node_property->perf_level)
> +			node_property->perf_level = default_memtier_perf_level;
> +	}
> +	mutex_unlock(&memory_tier_lock);

Another implementation is to call "online" function for each node with
memory.  In this way, the same code path can be used for static and
dynamic onlined node.

> +	return 0;
> +}
> +subsys_initcall(memory_tier_init);

Best Regards,
Huang, Ying
