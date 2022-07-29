Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 946B2584BA0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 08:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234611AbiG2GZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 02:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233734AbiG2GZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 02:25:15 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08E012A82
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 23:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659075914; x=1690611914;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=iAb39NiQRMJo7JQGxri/hlWsnn5atvY2xRJlmiRgfaU=;
  b=ZGurxiCPqEZkG/MSU9J4e3JtsG+LtYSehsK6lSjvqz8KKJ2OS8YlMYI+
   5f5Hlux+w9mNHgcQFuLusrp1QkJ2ZZGeWJ/lODDhpJSYm8/vMP6RM9KgR
   WhIFIv2SZYnGz59x6m07nuDELH4lcM/CCbwY/VleXo74/OGTLvFGR8zjy
   O2TD3g646ry8FOGsWns4/W+rrluo9GP9K4lNVw9AHvzJ8D1Ut1CmW1a2W
   lQ/gvjZv159a2TL8doqqadGDyQXW7q5IOc+YGhS6c1OGb94cXStHt3PLB
   60CgGz03uerWLmG7sil5qMAFHnxb5pJDXqWyPAYG1nHLHbfMPDApJ2Sit
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10422"; a="352702183"
X-IronPort-AV: E=Sophos;i="5.93,200,1654585200"; 
   d="scan'208";a="352702183"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2022 23:25:14 -0700
X-IronPort-AV: E=Sophos;i="5.93,200,1654585200"; 
   d="scan'208";a="551632401"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.94])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2022 23:25:10 -0700
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
Subject: Re: [PATCH v11 1/8] mm/demotion: Add support for explicit memory tiers
References: <20220728190436.858458-1-aneesh.kumar@linux.ibm.com>
        <20220728190436.858458-2-aneesh.kumar@linux.ibm.com>
Date:   Fri, 29 Jul 2022 14:25:05 +0800
In-Reply-To: <20220728190436.858458-2-aneesh.kumar@linux.ibm.com> (Aneesh
        Kumar K. V.'s message of "Fri, 29 Jul 2022 00:34:29 +0530")
Message-ID: <871qu4mo5a.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:

> In the current kernel, memory tiers are defined implicitly via a demotion path
> relationship between NUMA nodes, which is created during the kernel
> initialization and updated when a NUMA node is hot-added or hot-removed. The
> current implementation puts all nodes with CPU into the highest tier, and builds
> the tier hierarchy tier-by-tier by establishing the per-node demotion targets
> based on the distances between nodes.
>
> This current memory tier kernel implementation needs to be improved for several
> important use cases,
>
> The current tier initialization code always initializes each memory-only NUMA
> node into a lower tier. But a memory-only NUMA node may have a high performance
> memory device (e.g. a DRAM-backed memory-only node on a virtual machine) that
> should be put into a higher tier.
>
> The current tier hierarchy always puts CPU nodes into the top tier. But on a
> system with HBM or GPU devices, the memory-only NUMA nodes mapping these devices
> should be in the top tier, and DRAM nodes with CPUs are better to be placed into
> the next lower tier.
>
> With current kernel higher tier node can only be demoted to nodes with shortest
> distance on the next lower tier as defined by the demotion path, not any other
> node from any lower tier. This strict, demotion order does not work in all use
> cases (e.g. some use cases may want to allow cross-socket demotion to another
> node in the same demotion tier as a fallback when the preferred demotion node is
> out of space), This demotion order is also inconsistent with the page allocation
> fallback order when all the nodes in a higher tier are out of space: The page
> allocation can fall back to any node from any lower tier, whereas the demotion
> order doesn't allow that.
>
> This patch series address the above by defining memory tiers explicitly.
>
> Linux kernel presents memory devices as NUMA nodes and each memory device is of
> a specific type. The memory type of a device is represented by its abstract
> distance. A memory tier corresponds to a range of abstract distance. This allows
> for classifying memory devices with a specific performance range into a memory
> tier.
>
> This patch configures the range/chunk size to be 128. The default DRAM
> abstract distance is 512. We can have 4 memory tiers below the default DRAM
> abstract distance which cover the range 0 - 127, 127 - 255, 256- 383, 384 - 511.
> Slower memory devices like persistent memory will have abstract distance below
> the default DRAM level and hence will be placed in these 4 lower tiers.

For abstract distance, the lower value means higher performance, higher
value means lower performance.  So the abstract distance of PMEM should
be smaller than that of DRAM.

> A kernel parameter is provided to override the default memory tier.

Forget to delete?

Best Regards,
Huang, Ying

> Link: https://lore.kernel.org/linux-mm/CAAPL-u9Wv+nH1VOZTj=9p9S70Y3Qz3+63EkqncRDdHfubsrjfw@mail.gmail.com
> Link: https://lore.kernel.org/linux-mm/7b72ccf4-f4ae-cb4e-f411-74d055482026@linux.ibm.com
>
> Signed-off-by: Jagdish Gediya <jvgediya@linux.ibm.com>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
>  include/linux/memory-tiers.h |  17 ++++++
>  mm/Makefile                  |   1 +
>  mm/memory-tiers.c            | 102 +++++++++++++++++++++++++++++++++++
>  3 files changed, 120 insertions(+)
>  create mode 100644 include/linux/memory-tiers.h
>  create mode 100644 mm/memory-tiers.c
>
> diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
> new file mode 100644
> index 000000000000..8d7884b7a3f0
> --- /dev/null
> +++ b/include/linux/memory-tiers.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_MEMORY_TIERS_H
> +#define _LINUX_MEMORY_TIERS_H
> +
> +/*
> + * Each tier cover a abstrace distance chunk size of 128
> + */
> +#define MEMTIER_CHUNK_BITS	7
> +#define MEMTIER_CHUNK_SIZE	(1 << MEMTIER_CHUNK_BITS)
> +/*
> + * For now let's have 4 memory tier below default DRAM tier.
> + */
> +#define MEMTIER_ADISTANCE_DRAM	(1 << (MEMTIER_CHUNK_BITS + 2))
> +/* leave one tier below this slow pmem */
> +#define MEMTIER_ADISTANCE_PMEM	(1 << MEMTIER_CHUNK_BITS)
> +
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
> index 000000000000..01cfd514c192
> --- /dev/null
> +++ b/mm/memory-tiers.c
> @@ -0,0 +1,102 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/types.h>
> +#include <linux/nodemask.h>
> +#include <linux/slab.h>
> +#include <linux/lockdep.h>
> +#include <linux/memory-tiers.h>
> +
> +struct memory_tier {
> +	/* hierarchy of memory tiers */
> +	struct list_head list;
> +	/* list of all memory types part of this tier */
> +	struct list_head memory_types;
> +	/*
> +	 * start value of abstract distance. memory tier maps
> +	 * an abstract distance  range,
> +	 * adistance_start .. adistance_start + MEMTIER_CHUNK_SIZE
> +	 */
> +	int adistance_start;
> +};
> +
> +struct memory_dev_type {
> +	/* list of memory types that are are part of same tier as this type */
> +	struct list_head tier_sibiling;
> +	/* abstract distance for this specific memory type */
> +	int adistance;
> +	/* Nodes of same abstract distance */
> +	nodemask_t nodes;
> +	struct memory_tier *memtier;
> +};
> +
> +static DEFINE_MUTEX(memory_tier_lock);
> +static LIST_HEAD(memory_tiers);
> +struct memory_dev_type *node_memory_types[MAX_NUMNODES];
> +/*
> + * For now let's have 4 memory tier below default DRAM tier.
> + */
> +static struct memory_dev_type default_dram_type  = {
> +	.adistance = MEMTIER_ADISTANCE_DRAM,
> +	.tier_sibiling = LIST_HEAD_INIT(default_dram_type.tier_sibiling),
> +};
> +
> +static struct memory_tier *find_create_memory_tier(struct memory_dev_type *memtype)
> +{
> +	bool found_slot = false;
> +	struct memory_tier *memtier, *new_memtier;
> +	int adistance = memtype->adistance;
> +	unsigned int memtier_adistance_chunk_size = MEMTIER_CHUNK_SIZE;
> +
> +	lockdep_assert_held_once(&memory_tier_lock);
> +
> +	/*
> +	 * If the memtype is already part of a memory tier,
> +	 * just return that.
> +	 */
> +	if (memtype->memtier)
> +		return memtype->memtier;
> +
> +	adistance = round_down(adistance, memtier_adistance_chunk_size);
> +	list_for_each_entry(memtier, &memory_tiers, list) {
> +		if (adistance == memtier->adistance_start) {
> +			memtype->memtier = memtier;
> +			list_add(&memtype->tier_sibiling, &memtier->memory_types);
> +			return memtier;
> +		} else if (adistance < memtier->adistance_start) {
> +			found_slot = true;
> +			break;
> +		}
> +	}
> +
> +	new_memtier = kzalloc(sizeof(struct memory_tier), GFP_KERNEL);
> +	if (!new_memtier)
> +		return ERR_PTR(-ENOMEM);
> +
> +	new_memtier->adistance_start = adistance;
> +	INIT_LIST_HEAD(&new_memtier->list);
> +	INIT_LIST_HEAD(&new_memtier->memory_types);
> +	if (found_slot)
> +		list_add_tail(&new_memtier->list, &memtier->list);
> +	else
> +		list_add_tail(&new_memtier->list, &memory_tiers);
> +	memtype->memtier = new_memtier;
> +	list_add(&memtype->tier_sibiling, &new_memtier->memory_types);
> +	return new_memtier;
> +}
> +
> +static int __init memory_tier_init(void)
> +{
> +	struct memory_tier *memtier;
> +
> +	mutex_lock(&memory_tier_lock);
> +	/* CPU only nodes are not part of memory tiers. */
> +	default_dram_type.nodes = node_states[N_MEMORY];
> +
> +	memtier = find_create_memory_tier(&default_dram_type);
> +	if (IS_ERR(memtier))
> +		panic("%s() failed to register memory tier: %ld\n",
> +		      __func__, PTR_ERR(memtier));
> +	mutex_unlock(&memory_tier_lock);
> +
> +	return 0;
> +}
> +subsys_initcall(memory_tier_init);
