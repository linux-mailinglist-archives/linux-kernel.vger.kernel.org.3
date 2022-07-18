Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFB45577A5F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 07:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232755AbiGRF2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 01:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiGRF2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 01:28:39 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7FA11813
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 22:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658122117; x=1689658117;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=0b7S+GNCemhe7GvHK5p4aozzCcBDgi6yoKuuO33tyVk=;
  b=A98VAgieiv3dsUuEubVPiRlTXB42Inr5sjU3TvPC+J28P8BbiICypmqQ
   +r0IZaRa8EG2dj1DrClyLJKLaC/CbXp3yDTiTg2NXoS7oENT/AF8LbmwQ
   nhAY7DklXyMZnTpnGHpF/Rpm0J7gL+I4KvAvgkfVsgdlwImqqeu3b5dMq
   NzNDfE+lyy12qSssatGovNXJ50NDmVDbBkZd+0DOJeWuByo9X64VBN29u
   IoTzF1Kn3X1VpsMc5UdHPDyDx9tr9VMe1ekG+N2EzuMpmJs5zPJr8EXAR
   zirq9wbIxwzz/bTC5H5MVX3cxKCh/ZIMIQF+aCfqQkB1jmGomi66SKesf
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10411"; a="269159516"
X-IronPort-AV: E=Sophos;i="5.92,280,1650956400"; 
   d="scan'208";a="269159516"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2022 22:28:37 -0700
X-IronPort-AV: E=Sophos;i="5.92,280,1650956400"; 
   d="scan'208";a="572259705"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.94])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2022 22:28:33 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Wei Xu <weixugc@google.com>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <shy828301@gmail.com>,
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
        <87bktq4xs7.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <CAAPL-u_F=RBnCy3_WfbDyM0x7_CWPAK+fvwwLZvyRGUgVoS_VQ@mail.gmail.com>
Date:   Mon, 18 Jul 2022 13:28:17 +0800
In-Reply-To: <CAAPL-u_F=RBnCy3_WfbDyM0x7_CWPAK+fvwwLZvyRGUgVoS_VQ@mail.gmail.com>
        (Wei Xu's message of "Fri, 15 Jul 2022 09:59:25 -0700")
Message-ID: <8735ez3s7i.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wei Xu <weixugc@google.com> writes:

> On Fri, Jul 15, 2022 at 12:53 AM Huang, Ying <ying.huang@intel.com> wrote:
>>
>> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
>>
>> > In the current kernel, memory tiers are defined implicitly via a
>> > demotion path relationship between NUMA nodes, which is created
>> > during the kernel initialization and updated when a NUMA node is
>> > hot-added or hot-removed.  The current implementation puts all
>> > nodes with CPU into the top tier, and builds the tier hierarchy
>> > tier-by-tier by establishing the per-node demotion targets based
>> > on the distances between nodes.
>> >
>> > This current memory tier kernel interface needs to be improved for
>> > several important use cases,
>> >
>> > The current tier initialization code always initializes
>> > each memory-only NUMA node into a lower tier.  But a memory-only
>> > NUMA node may have a high performance memory device (e.g. a DRAM
>> > device attached via CXL.mem or a DRAM-backed memory-only node on
>> > a virtual machine) and should be put into a higher tier.
>> >
>> > The current tier hierarchy always puts CPU nodes into the top
>> > tier. But on a system with HBM or GPU devices, the
>> > memory-only NUMA nodes mapping these devices should be in the
>> > top tier, and DRAM nodes with CPUs are better to be placed into the
>> > next lower tier.
>> >
>> > With current kernel higher tier node can only be demoted to selected nodes on the
>> > next lower tier as defined by the demotion path, not any other
>> > node from any lower tier.  This strict, hard-coded demotion order
>> > does not work in all use cases (e.g. some use cases may want to
>> > allow cross-socket demotion to another node in the same demotion
>> > tier as a fallback when the preferred demotion node is out of
>> > space), This demotion order is also inconsistent with the page
>> > allocation fallback order when all the nodes in a higher tier are
>> > out of space: The page allocation can fall back to any node from
>> > any lower tier, whereas the demotion order doesn't allow that.
>> >
>> > The current kernel also don't provide any interfaces for the
>> > userspace to learn about the memory tier hierarchy in order to
>> > optimize its memory allocations.
>> >
>> > This patch series address the above by defining memory tiers explicitly.
>> >
>> > This patch introduce explicity memory tiers. The tier ID value
>> > of a memory tier is used to derive the demotion order between
>> > NUMA nodes.
>> >
>> > For example, if we have 3 memtiers: memtier100, memtier200, memiter300
>> > then the memory tier order is: memtier300 -> memtier200 -> memtier100
>> > where memtier300 is the highest tier and memtier100 is the lowest tier.
>> >
>> > While reclaim we migrate pages from fast(higher) tiers to slow(lower)
>> > tiers when the fast(higher) tier is under memory pressure.
>> >
>> > This patchset introduce 3 memory tiers (memtier100, memtier200 and memtier300)
>> > which are created by different kernel subsystems. The default memory
>> > tier created by the kernel is memtier200. A kernel parameter is provided
>> > to override the default memory tier.
>> >
>> > Link: https://lore.kernel.org/linux-mm/CAAPL-u9Wv+nH1VOZTj=9p9S70Y3Qz3+63EkqncRDdHfubsrjfw@mail.gmail.com
>> > Link: https://lore.kernel.org/linux-mm/7b72ccf4-f4ae-cb4e-f411-74d055482026@linux.ibm.com
>> >
>> > Signed-off-by: Jagdish Gediya <jvgediya@linux.ibm.com>
>> > Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>> > ---
>> >  include/linux/memory-tiers.h | 15 +++++++
>> >  mm/Makefile                  |  1 +
>> >  mm/memory-tiers.c            | 78 ++++++++++++++++++++++++++++++++++++
>> >  3 files changed, 94 insertions(+)
>> >  create mode 100644 include/linux/memory-tiers.h
>> >  create mode 100644 mm/memory-tiers.c
>> >
>> > diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
>> > new file mode 100644
>> > index 000000000000..a81dbc20e0d1
>> > --- /dev/null
>> > +++ b/include/linux/memory-tiers.h
>> > @@ -0,0 +1,15 @@
>> > +/* SPDX-License-Identifier: GPL-2.0 */
>> > +#ifndef _LINUX_MEMORY_TIERS_H
>> > +#define _LINUX_MEMORY_TIERS_H
>> > +
>> > +#ifdef CONFIG_NUMA
>> > +
>> > +#define MEMORY_TIER_HBM_GPU  300
>> > +#define MEMORY_TIER_DRAM     200
>> > +#define MEMORY_TIER_PMEM     100
>> > +
>> > +#define DEFAULT_MEMORY_TIER  MEMORY_TIER_DRAM
>> > +#define MAX_MEMORY_TIER_ID   400
>> > +
>> > +#endif       /* CONFIG_NUMA */
>> > +#endif  /* _LINUX_MEMORY_TIERS_H */
>> > diff --git a/mm/Makefile b/mm/Makefile
>> > index 6f9ffa968a1a..d30acebc2164 100644
>> > --- a/mm/Makefile
>> > +++ b/mm/Makefile
>> > @@ -92,6 +92,7 @@ obj-$(CONFIG_KFENCE) += kfence/
>> >  obj-$(CONFIG_FAILSLAB) += failslab.o
>> >  obj-$(CONFIG_MEMTEST)                += memtest.o
>> >  obj-$(CONFIG_MIGRATION) += migrate.o
>> > +obj-$(CONFIG_NUMA) += memory-tiers.o
>> >  obj-$(CONFIG_DEVICE_MIGRATION) += migrate_device.o
>> >  obj-$(CONFIG_TRANSPARENT_HUGEPAGE) += huge_memory.o khugepaged.o
>> >  obj-$(CONFIG_PAGE_COUNTER) += page_counter.o
>> > diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
>> > new file mode 100644
>> > index 000000000000..011877b6dbb9
>> > --- /dev/null
>> > +++ b/mm/memory-tiers.c
>> > @@ -0,0 +1,78 @@
>> > +// SPDX-License-Identifier: GPL-2.0
>> > +#include <linux/types.h>
>> > +#include <linux/nodemask.h>
>> > +#include <linux/slab.h>
>> > +#include <linux/lockdep.h>
>> > +#include <linux/moduleparam.h>
>> > +#include <linux/memory-tiers.h>
>> > +
>> > +struct memory_tier {
>> > +     struct list_head list;
>> > +     int id;
>> > +     nodemask_t nodelist;
>> > +};
>> > +
>> > +static DEFINE_MUTEX(memory_tier_lock);
>> > +static LIST_HEAD(memory_tiers);
>> > +
>> > +static void insert_memory_tier(struct memory_tier *memtier)
>> > +{
>> > +     struct list_head *ent;
>> > +     struct memory_tier *tmp_memtier;
>> > +
>> > +     lockdep_assert_held_once(&memory_tier_lock);
>> > +
>> > +     list_for_each(ent, &memory_tiers) {
>> > +             tmp_memtier = list_entry(ent, struct memory_tier, list);
>> > +             if (tmp_memtier->id < memtier->id) {
>> > +                     list_add_tail(&memtier->list, ent);
>> > +                     return;
>> > +             }
>> > +     }
>> > +     list_add_tail(&memtier->list, &memory_tiers);
>> > +}
>> > +
>> > +static struct memory_tier *register_memory_tier(unsigned int tier)
>> > +{
>> > +     struct memory_tier *memtier;
>> > +
>> > +     if (tier > MAX_MEMORY_TIER_ID)
>> > +             return ERR_PTR(-EINVAL);
>> > +
>> > +     memtier = kzalloc(sizeof(struct memory_tier), GFP_KERNEL);
>> > +     if (!memtier)
>> > +             return ERR_PTR(-ENOMEM);
>> > +
>> > +     memtier->id   = tier;
>> > +
>> > +     insert_memory_tier(memtier);
>> > +
>> > +     return memtier;
>> > +}
>> > +
>> > +static unsigned int default_memtier = DEFAULT_MEMORY_TIER;
>> > +core_param(default_memory_tier, default_memtier, uint, 0644);
>> > +
>> > +static int __init memory_tier_init(void)
>> > +{
>> > +     struct memory_tier *memtier;
>> > +
>> > +     /*
>> > +      * Register only default memory tier to hide all empty
>> > +      * memory tier from sysfs. Since this is early during
>> > +      * boot, we could avoid holding memtory_tier_lock. But
>> > +      * keep it simple by holding locks. So we can add lock
>> > +      * held debug checks in other functions.
>> > +      */
>> > +     mutex_lock(&memory_tier_lock);
>> > +     memtier = register_memory_tier(default_memtier);
>> > +     if (IS_ERR(memtier))
>> > +             panic("%s() failed to register memory tier: %ld\n",
>> > +                   __func__, PTR_ERR(memtier));
>> > +
>> > +     /* CPU only nodes are not part of memory tiers. */
>> > +     memtier->nodelist = node_states[N_MEMORY];
>> > +     mutex_unlock(&memory_tier_lock);
>> > +     return 0;
>> > +}
>> > +subsys_initcall(memory_tier_init);
>>
>> You dropped the original sysfs interface patches from the series, but
>> the kernel internal implementation is still for the original sysfs
>> interface.  For example, memory tier ID is for the original sysfs
>> interface, not for the new proposed sysfs interface.  So I suggest you
>> to implement with the new interface in mind.  What do you think about
>> the following design?
>>
>> - Each NUMA node belongs to a memory type, and each memory type
>>   corresponds to a "abstract distance", so each NUMA node corresonds to
>>   a "distance".  For simplicity, we can start with static distances, for
>>   example, DRAM (default): 150, PMEM: 250.
>
> I agree with this design, though I'd prefer the new attribute to not
> be named as "distance".  This is to both avoid the confusion with the
> SLIT distance and to avoid the misconception that only the latency
> matters, but the bandwidth doesn't.
>
> How about we call it "performance level" (perf_level) or something
> similar instead?

I have no strong opinion on this.  Both "distance" or "perf_level" looks
OK to me.

>> The distance of each NUMA
>>   node can be recorded in a global array,
>>
>>     int node_distances[MAX_NUMNODES];
>>
>>   or, just
>>
>>     pgdat->distance
>
> I think node_devices[] is a better place to record this new attribute.
> The HMAT performance data is also listed there.

Firstly, we all agree that we need a place to record this information,
per node or per memory type.  Personally, I prefer to separate the data
and its interface (such as sysfs).

>> - Each memory tier corresponds to a range of distance, for example,
>>   0-100, 100-200, 200-300, >300, we can start with static ranges too.
>>
>> - The core API of memory tier could be
>>
>>     struct memory_tier *find_create_memory_tier(int distance);
>>
>>   it will find the memory tier which covers "distance" in the memory
>>   tier list, or create a new memory tier if not found.
>>
>> - kmem_dax driver will setup distance for PMEM NUMA nodes before online
>>   them.
>
> This attribute should be a property of the NUMA node based on the
> device hardware.

Yes.  Or a property of a memory type.

> For PMEM, it is better to handle at the ACPI level.
> For example, we can consider initializing this attribute for a PMEM
> node in acpi_numa_memory_affinity_init() when the node is
> non-volatile.

The abstract_distance/perf_level may be determined from multiple
information sources, e.g., ACPI SLIT/SRAT/HMAT, etc.  It should be the
responsibility of device drivers (e.g., kmem_dax) to determine the final
value of abstract_distance/perf_level based on the information
availability/priority and some specific knowledge of the hardware.  Yes,
ACPI SRAT is valuable to determine the abstract_distance/perf_level.
And, it's better for kmem_dax to use it to determine the final value of
abstract_distance/perf_level.

To make the first version as simple as possible, I think we can just use
some static abstract_distance/perf_level in kmem_dax driver for the NUMA
nodes onlined by it.  Because we use the driver for PMEM only now.  We
can enhance the implementation later.

>> - When a NUMA node is onlined, we will use find_create_memory_tier() to
>>   find or create its memory tier and add the NUMA node into the memory
>>   tier.
>
> I think we should create all the memory tiers up-front, just like NUMA
> nodes, to keep their devices and IDs stable.  Similar to offline NUMA
> nodes, when a memory tier has no online nodes, we can mark it as
> offline and exclude it from online-related operations (e.g. demotion).
> A memory tier can be made online when it gets assigned with an online
> node.

Each memory tier corresponds to a range of abstract_distance/perf_level.
For example, if 1 <= abstract_distance/perf_level <= 500, 5 memory tiers
can be defined with abstract_distance/perf_level ranges 1-100, 101-200,
201-300, 301-400, 401-500.  We can create these 5 memory tiers up-front
of course.  In the new design, we may change the ranges at run time
according to policy chosen by the users.  For example, we may change 5
memory tiers above to 500 memory tiers, with
abstract_distance/perf_level ranges 1-1, 2-2, ..., 500-500.  This may
make memory tier devices and their IDs unstable at some degree.  But if
we are cautious to customize the ranges, it's possible to make the
memory tier devices and their IDs stable in most cases.

Because we may define 500 memory tiers, it's hard to create all memory
tiers up-front really.  But we can create them all in concept and
allocate memory/resources for one when we add the first NUMA node to it.

To make the fist version as simple as possible, I suggest to define 500
memory tiers as above statically.

>> - Or we can add memory type data structure now.

Best Regards,
Huang, Ying
