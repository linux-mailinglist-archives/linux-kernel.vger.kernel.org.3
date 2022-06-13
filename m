Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD9D547EEE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 07:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbiFMFbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 01:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237487AbiFMFaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 01:30:18 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 975D9DF2E
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 22:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655098216; x=1686634216;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ghW3rN3OBLpbPzPBTn9lP2aXs1TLkV7KWuVQKAJotQI=;
  b=GmkqHy5Jv6mn6u+lwON/pINe2oyFtJVEk0i/w5kgc7dXbQJFUl9q2OBz
   TNSmqRyzDBc+9XWzNPJcvkBCGMgEHgrkQQTsewrOoRUML00l21UaEvvgW
   5zNb/1dlXPnaYweTlyhLBTUujzW6E1P0YKhf69lGrT9kZbgWpkFpD7ciz
   kOXBkbez0aBBym5sO3O85MJ0QDxHCNmTyCruzMabCDz6II+/VDo4muwin
   RN4iv/z5Wyd7tssdjo7x8feoB9Srdw0MWq65Fj0G/U9ywnxitcae8lemd
   a0Lyy1A3LPClUSTXh6LFB3+AtYmzxgLhAVn22HTW1cFYM2VQDWm0/mblZ
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10376"; a="303561735"
X-IronPort-AV: E=Sophos;i="5.91,296,1647327600"; 
   d="scan'208";a="303561735"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2022 22:30:16 -0700
X-IronPort-AV: E=Sophos;i="5.91,296,1647327600"; 
   d="scan'208";a="651217513"
Received: from xinyangc-mobl.ccr.corp.intel.com ([10.254.214.65])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2022 22:30:11 -0700
Message-ID: <a88bd25fc77252dee4f895f3a9b2c1f6ebb5169e.camel@intel.com>
Subject: Re: [PATCH v6 01/13] mm/demotion: Add support for explicit memory
 tiers
From:   Ying Huang <ying.huang@intel.com>
To:     Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org
Cc:     Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim C Chen <tim.c.chen@intel.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        David Rientjes <rientjes@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Date:   Mon, 13 Jun 2022 13:30:08 +0800
In-Reply-To: <48096ad7-ce6d-79b7-1edd-7e6652ab2a4d@linux.ibm.com>
References: <20220610135229.182859-1-aneesh.kumar@linux.ibm.com>
         <20220610135229.182859-2-aneesh.kumar@linux.ibm.com>
         <7e0b41422dbd0976cb43c2f126e9371d5e311e77.camel@intel.com>
         <48096ad7-ce6d-79b7-1edd-7e6652ab2a4d@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-06-13 at 09:01 +0530, Aneesh Kumar K V wrote:
> On 6/13/22 8:52 AM, Ying Huang wrote:
> > Hi, Aneesh,
> > 
> > On Fri, 2022-06-10 at 19:22 +0530, Aneesh Kumar K.V wrote:
> > > In the current kernel, memory tiers are defined implicitly via a
> > > demotion path relationship between NUMA nodes, which is created
> > > during the kernel initialization and updated when a NUMA node is
> > > hot-added or hot-removed.  The current implementation puts all
> > > nodes with CPU into the top tier, and builds the tier hierarchy
> > > tier-by-tier by establishing the per-node demotion targets based
> > > on the distances between nodes.
> > > 
> > > This current memory tier kernel interface needs to be improved for
> > > several important use cases,
> > > 
> > > The current tier initialization code always initializes
> > > each memory-only NUMA node into a lower tier.  But a memory-only
> > > NUMA node may have a high performance memory device (e.g. a DRAM
> > > device attached via CXL.mem or a DRAM-backed memory-only node on
> > > a virtual machine) and should be put into a higher tier.
> > > 
> > > The current tier hierarchy always puts CPU nodes into the top
> > > tier. But on a system with HBM or GPU devices, the
> > > memory-only NUMA nodes mapping these devices should be in the
> > > top tier, and DRAM nodes with CPUs are better to be placed into the
> > > next lower tier.
> > > 
> > > With current kernel higher tier node can only be demoted to selected nodes on the
> > > next lower tier as defined by the demotion path, not any other
> > > node from any lower tier.  This strict, hard-coded demotion order
> > > does not work in all use cases (e.g. some use cases may want to
> > > allow cross-socket demotion to another node in the same demotion
> > > tier as a fallback when the preferred demotion node is out of
> > > space), This demotion order is also inconsistent with the page
> > > allocation fallback order when all the nodes in a higher tier are
> > > out of space: The page allocation can fall back to any node from
> > > any lower tier, whereas the demotion order doesn't allow that.
> > > 
> > > The current kernel also don't provide any interfaces for the
> > > userspace to learn about the memory tier hierarchy in order to
> > > optimize its memory allocations.
> > > 
> > > This patch series address the above by defining memory tiers explicitly.
> > > 
> > > This patch introduce explicity memory tiers with ranks. The rank
> > > value of a memory tier is used to derive the demotion order between
> > > NUMA nodes. The memory tiers present in a system can be found at
> > > 
> > > "Rank" is an opaque value. Its absolute value doesn't have any
> > > special meaning. But the rank values of different memtiers can be
> > > compared with each other to determine the memory tier order.
> > > 
> > > For example, if we have 3 memtiers: memtier0, memtier1, memiter2, and
> > > their rank values are 300, 200, 100, then the memory tier order is:
> > > memtier0 -> memtier1 -> memtier2, where memtier0 is the highest tier
> > > and memtier2 is the lowest tier.
> > > 
> > > The rank value of each memtier should be unique.
> > > 
> > > A higher rank memory tier will appear first in the demotion order
> > > than a lower rank memory tier. ie. while reclaim we choose a node
> > > in higher rank memory tier to demote pages to as compared to a node
> > > in a lower rank memory tier.
> > > 
> > > This patchset introduce 3 memory tiers (memtier0, memtier1 and memtier2)
> > > which are created by different kernel subsystems. The default memory
> > > tier created by the kernel is memtier1. Once created these memory tiers
> > > are not destroyed even if they don't have any NUMA nodes assigned to
> > > them.
> > > 
> > > This patch is based on the proposal sent by Wei Xu <weixugc@google.com> at [1].
> > > 
> > > [1] https://lore.kernel.org/linux-mm/CAAPL-u9Wv+nH1VOZTj=9p9S70Y3Qz3+63EkqncRDdHfubsrjfw@mail.gmail.com
> > > 
> > > /sys/devices/system/memtier/memtierN/
> > > 
> > > The nodes which are part of a specific memory tier can be listed
> > > via
> > > /sys/devices/system/memtier/memtierN/nodelist
> > > 
> > > Suggested-by: Wei Xu <weixugc@google.com>
> > > Signed-off-by: Jagdish Gediya <jvgediya@linux.ibm.com>
> > > Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> > > ---
> > >   include/linux/memory-tiers.h | 20 ++++++++
> > >   mm/Kconfig                   |  3 ++
> > >   mm/Makefile                  |  1 +
> > >   mm/memory-tiers.c            | 89 ++++++++++++++++++++++++++++++++++++
> > >   4 files changed, 113 insertions(+)
> > >   create mode 100644 include/linux/memory-tiers.h
> > >   create mode 100644 mm/memory-tiers.c
> > > 
> > > diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
> > > new file mode 100644
> > > index 000000000000..e17f6b4ee177
> > > --- /dev/null
> > > +++ b/include/linux/memory-tiers.h
> > > @@ -0,0 +1,20 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +#ifndef _LINUX_MEMORY_TIERS_H
> > > +#define _LINUX_MEMORY_TIERS_H
> > > +
> > > +#ifdef CONFIG_TIERED_MEMORY
> > > +
> > > +#define MEMORY_TIER_HBM_GPU	0
> > > +#define MEMORY_TIER_DRAM	1
> > > +#define MEMORY_TIER_PMEM	2
> > > +
> > > +#define MEMORY_RANK_HBM_GPU	300
> > > +#define MEMORY_RANK_DRAM	200
> > > +#define MEMORY_RANK_PMEM	100
> > > +
> > > +#define DEFAULT_MEMORY_TIER	MEMORY_TIER_DRAM
> > > +#define MAX_MEMORY_TIERS  3
> > > +
> > > +#endif	/* CONFIG_TIERED_MEMORY */
> > > +
> > > +#endif
> > > diff --git a/mm/Kconfig b/mm/Kconfig
> > > index 169e64192e48..bb5aa585ab41 100644
> > > --- a/mm/Kconfig
> > > +++ b/mm/Kconfig
> > > @@ -614,6 +614,9 @@ config ARCH_ENABLE_HUGEPAGE_MIGRATION
> > >   config ARCH_ENABLE_THP_MIGRATION
> > >   	bool
> > >   
> > > 
> > > 
> > > +config TIERED_MEMORY
> > > +	def_bool NUMA
> > > +
> > 
> > As Yang pointed out, why not just use CONFIG_NUMA?  I suspect the
> > added value of CONIFIG_TIRED_MEMORY.
> > 
> 
> I decided to use TIERED_MEMORY to bring more clarity. It should be same 
> now that we have moved CONFIG_MIGRATION dependencies to runtime. IMHO 
> having CONFIG_TIERED_MEMORY is better than using CONFIG_NUMA.

I don't think CONFIG_TIERED_MEMORY bring no much value.  It's better
to use CONFIG_NUMA directly.  But this is just my opinion.

> > >   config HUGETLB_PAGE_SIZE_VARIABLE
> > >   	def_bool n
> > >   	help
> > > diff --git a/mm/Makefile b/mm/Makefile
> > > index 6f9ffa968a1a..482557fbc9d1 100644
> > > --- a/mm/Makefile
> > > +++ b/mm/Makefile
> > > @@ -92,6 +92,7 @@ obj-$(CONFIG_KFENCE) += kfence/
> > >   obj-$(CONFIG_FAILSLAB) += failslab.o
> > >   obj-$(CONFIG_MEMTEST)		+= memtest.o
> > >   obj-$(CONFIG_MIGRATION) += migrate.o
> > > +obj-$(CONFIG_TIERED_MEMORY) += memory-tiers.o
> > >   obj-$(CONFIG_DEVICE_MIGRATION) += migrate_device.o
> > >   obj-$(CONFIG_TRANSPARENT_HUGEPAGE) += huge_memory.o khugepaged.o
> > >   obj-$(CONFIG_PAGE_COUNTER) += page_counter.o
> > > diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
> > > new file mode 100644
> > > index 000000000000..d9fa955f208e
> > > --- /dev/null
> > > +++ b/mm/memory-tiers.c
> > > @@ -0,0 +1,89 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +#include <linux/types.h>
> > > +#include <linux/nodemask.h>
> > > +#include <linux/slab.h>
> > > +#include <linux/memory-tiers.h>
> > > +
> > > +struct memory_tier {
> > > +	struct list_head list;
> > > +	nodemask_t nodelist;
> > > +	int id;
> > > +	int rank;
> > > +};
> > > +
> > > +static DEFINE_MUTEX(memory_tier_lock);
> > > +static LIST_HEAD(memory_tiers);
> > > +
> > > +/*
> > > + * Keep it simple by having  direct mapping between
> > > + * tier index and rank value.
> > > + */
> > > +static inline int get_rank_from_tier(unsigned int tier)
> > > +{
> > > +	switch (tier) {
> > > +	case MEMORY_TIER_HBM_GPU:
> > > +		return MEMORY_RANK_HBM_GPU;
> > > +	case MEMORY_TIER_DRAM:
> > > +		return MEMORY_RANK_DRAM;
> > > +	case MEMORY_TIER_PMEM:
> > > +		return MEMORY_RANK_PMEM;
> > > +	}
> > > +	return -1;
> > > +}
> > > +
> > > +static void insert_memory_tier(struct memory_tier *memtier)
> > > +{
> > > +	struct list_head *ent;
> > > +	struct memory_tier *tmp_memtier;
> > > +
> > > +	list_for_each(ent, &memory_tiers) {
> > > +		tmp_memtier = list_entry(ent, struct memory_tier, list);
> > 
> > list_for_each_entry() ?
> > 
> 
> ent variable is used below. Hence I won't be able to use 
> list_for_each_entry.

ent == &tmp_memtier->list ?

> > > +		if (tmp_memtier->rank < memtier->rank) {
> > > +			list_add_tail(&memtier->list, ent);
> > 
> > > +			return;
> > > +		}
> > > +	}
> > > +	list_add_tail(&memtier->list, &memory_tiers);
> > > +}
> > > +
> > 
> > IMHO, the locking requirements are needed here as comments to avoid
> > confusing.
> > 
> 
> All those functions are called with memory_tier_lock_held. Infact all 
> list operations requires that lock held. What details do you suggest we 
> document? I can add extra comment to the mutex itself? Adding locking 
> details to all the functions will be duplicating the same details at 
> multiple places?

memory_tier_lock isn't held to call register_memory_tier() in this
patch.  That will cause confusion.

> > > +static struct memory_tier *register_memory_tier(unsigned int tier,
> > > +						unsigned int rank)
> > > +{
> > > +	struct memory_tier *memtier;
> > > +
> > > +	if (tier >= MAX_MEMORY_TIERS)
> > > +		return ERR_PTR(-EINVAL);
> > > +
> > > +	memtier = kzalloc(sizeof(struct memory_tier), GFP_KERNEL);
> > > +	if (!memtier)
> > > +		return ERR_PTR(-ENOMEM);
> > > +
> > > +	memtier->id   = tier;
> > > +	memtier->rank = rank;
> > > +
> > > +	insert_memory_tier(memtier);
> > > +
> > > +	return memtier;
> > > +}
> > > +
> > > +static int __init memory_tier_init(void)
> > > +{
> > > +	struct memory_tier *memtier;
> > > +
> > > +	/*
> > > +	 * Register only default memory tier to hide all empty
> > > +	 * memory tier from sysfs.
> > > +	 */
> > > +	memtier = register_memory_tier(DEFAULT_MEMORY_TIER,
> > > +				       get_rank_from_tier(DEFAULT_MEMORY_TIER));
> > > +
> > > +	if (IS_ERR(memtier))
> > > +		panic("%s() failed to register memory tier: %ld\n",
> > > +		      __func__, PTR_ERR(memtier));
> > > +
> > > +	/* CPU only nodes are not part of memory tiers. */
> > > +	memtier->nodelist = node_states[N_MEMORY];
> > > +
> > > +	return 0;
> > > +}
> > > +subsys_initcall(memory_tier_init);
> > 

Best Regards,
Huang, Ying


