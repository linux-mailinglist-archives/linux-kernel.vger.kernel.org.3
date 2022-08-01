Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A67395862B1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 04:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239219AbiHAChz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 22:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239203AbiHAChu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 22:37:50 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9963C13D00
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 19:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659321469; x=1690857469;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=fLOqIaghCnBMA/V/2uzDON1uQCBgbi8n/oBdERYXHgk=;
  b=UcZWVY4fQlpuufGY2mIXO4CvdvKw6tFFiuJFgRdd+b/qtfJalANGb4BM
   cUXBgXXQReJH+T4GHF0p0iSz/E+Dy2PogHmzRkk5869LnZkZqEy1V6Rc+
   wxInvTpBuDVbz1N+dVzOjAjDOn9F0xGYDN2FvlFXqxWEq6h0mSFlKcuIu
   bIBAu+IToRAnTBaG3jf2DTb+4TGtE30zrh+Fd4Qyg1Wvpq3GdJ/CKbz3Q
   rHIHmf//DoWvaHHBUKDHT0i26CgpVeUsNrLCdQ4CHGBpfVHYmkVuXrWvt
   Z18DX9/52usDR5ileeSfsYGFnnzs1Su3M4KFMD2PIjEJN6qauIAN1gGA9
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10425"; a="375352763"
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="375352763"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2022 19:37:49 -0700
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="728300221"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2022 19:37:45 -0700
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
Subject: Re: [PATCH v12 1/8] mm/demotion: Add support for explicit memory tiers
References: <20220729061349.968148-1-aneesh.kumar@linux.ibm.com>
        <20220729061349.968148-2-aneesh.kumar@linux.ibm.com>
Date:   Mon, 01 Aug 2022 10:37:41 +0800
In-Reply-To: <20220729061349.968148-2-aneesh.kumar@linux.ibm.com> (Aneesh
        Kumar K. V.'s message of "Fri, 29 Jul 2022 11:43:42 +0530")
Message-ID: <877d3slmdm.fsf@yhuang6-desk2.ccr.corp.intel.com>
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
                                                       ~~~~~

above?

> abstract distance which cover the range 0 - 127, 127 - 255, 256- 383, 384 - 511.
> Slower memory devices like persistent memory will have abstract distance higher
> than the default DRAM level.
>
> Signed-off-by: Jagdish Gediya <jvgediya@linux.ibm.com>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
>  include/linux/memory-tiers.h |  16 ++++++
>  mm/Makefile                  |   1 +
>  mm/memory-tiers.c            | 107 +++++++++++++++++++++++++++++++++++
>  3 files changed, 124 insertions(+)
>  create mode 100644 include/linux/memory-tiers.h
>  create mode 100644 mm/memory-tiers.c
>
> diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
> new file mode 100644
> index 000000000000..9238c3291aaf
> --- /dev/null
> +++ b/include/linux/memory-tiers.h
> @@ -0,0 +1,16 @@
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
> + * Smaller abstract distance value imply faster(higher) memory tiers.
> + */
> +#define MEMTIER_ADISTANCE_DRAM	(1 << (MEMTIER_CHUNK_BITS + 2))
> +#define MEMTIER_ADISTANCE_PMEM	(1 << (MEMTIER_CHUNK_BITS + 3))

Not a big issue, I am easier to understand it with the following format,

#define MEMTIER_ADISTANCE_DRAM	\
        (4 * MEMTIER_CHUNK_SIZE + #MEMTIER_CHUNK_SIZE / 2)
#define MEMTIER_ADISTANCE_PMEM	\
        (8 * MEMTIER_CHUNK_SIZE + #MEMTIER_CHUNK_SIZE / 2)

And it appears better to put the predefined abstract distance at the
middle of the range.

Best Regards,
Huang, Ying

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
> index 000000000000..60f82667d942
> --- /dev/null
> +++ b/mm/memory-tiers.c
> @@ -0,0 +1,107 @@
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
> +	int node;
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
> +
> +	for_each_node_state(node, N_MEMORY)
> +		node_memory_types[node] = &default_dram_type;
> +
> +	mutex_unlock(&memory_tier_lock);
> +
> +	return 0;
> +}
> +subsys_initcall(memory_tier_init);
