Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4F354271B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbiFHEN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 00:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232815AbiFHENb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 00:13:31 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20DA82C5DB3
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 18:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654652088; x=1686188088;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CRbo66F+8nU/4KLZzDKdqTu4eIY1TyfFqC5hNfynGT8=;
  b=nJIFZyJJxZ6zoams2C9KU8ryjc+CzrpNLRPAAvx/dMQcKawzLUbxwHdn
   d0oiTmaorp5DX2ycRrcEzoJJoDxhx/P0+ucsRqY655ZSBJ/FSILgio6ut
   FQ6gti22zbSfksI/vUxY5LZcVg/Fh9vWzUxFMI7tfYvxcywwRVwHjbAqm
   hpXR82516sFMweklElOerBNImdpiGyLmwRVQLPpBkwVQ/W6nqnJBd3lVw
   DC/lJ0V+ZUb7dlGcb2/HHf1sbicDqp6YPcWjj1zHeNfNkX/62/fEyH0PW
   +n2qWXSHOl+GHkR3tnk+S8RDlS28U2VQV+fx4i8JSp1m3Li8fkDZGyH6H
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10371"; a="256605211"
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="256605211"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 18:34:07 -0700
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="584525849"
Received: from wantingz-mobl.ccr.corp.intel.com ([10.254.214.193])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 18:34:03 -0700
Message-ID: <ccd58db2398cb5f8df72ead1c131e8a5914755f1.camel@intel.com>
Subject: Re: [PATCH v5 1/9] mm/demotion: Add support for explicit memory
 tiers
From:   Ying Huang <ying.huang@intel.com>
To:     Yang Shi <shy828301@gmail.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
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
        David Rientjes <rientjes@google.com>
Date:   Wed, 08 Jun 2022 09:34:00 +0800
In-Reply-To: <CAHbLzkrWer5-HgujZ12b=qxtT2ByV0+Sy7fsYb2EBgHAGRuPpw@mail.gmail.com>
References: <20220603134237.131362-1-aneesh.kumar@linux.ibm.com>
         <20220603134237.131362-2-aneesh.kumar@linux.ibm.com>
         <CAHbLzkrWer5-HgujZ12b=qxtT2ByV0+Sy7fsYb2EBgHAGRuPpw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-06-07 at 14:32 -0700, Yang Shi wrote:
> On Fri, Jun 3, 2022 at 6:43 AM Aneesh Kumar K.V
> <aneesh.kumar@linux.ibm.com> wrote:
> > 
> > In the current kernel, memory tiers are defined implicitly via a
> > demotion path relationship between NUMA nodes, which is created
> > during the kernel initialization and updated when a NUMA node is
> > hot-added or hot-removed.  The current implementation puts all
> > nodes with CPU into the top tier, and builds the tier hierarchy
> > tier-by-tier by establishing the per-node demotion targets based
> > on the distances between nodes.
> > 
> > This current memory tier kernel interface needs to be improved for
> > several important use cases,
> > 
> > The current tier initialization code always initializes
> > each memory-only NUMA node into a lower tier.  But a memory-only
> > NUMA node may have a high performance memory device (e.g. a DRAM
> > device attached via CXL.mem or a DRAM-backed memory-only node on
> > a virtual machine) and should be put into a higher tier.
> > 
> > The current tier hierarchy always puts CPU nodes into the top
> > tier. But on a system with HBM or GPU devices, the
> > memory-only NUMA nodes mapping these devices should be in the
> > top tier, and DRAM nodes with CPUs are better to be placed into the
> > next lower tier.
> > 
> > With current kernel higher tier node can only be demoted to selected nodes on the
> > next lower tier as defined by the demotion path, not any other
> > node from any lower tier.  This strict, hard-coded demotion order
> > does not work in all use cases (e.g. some use cases may want to
> > allow cross-socket demotion to another node in the same demotion
> > tier as a fallback when the preferred demotion node is out of
> > space), This demotion order is also inconsistent with the page
> > allocation fallback order when all the nodes in a higher tier are
> > out of space: The page allocation can fall back to any node from
> > any lower tier, whereas the demotion order doesn't allow that.
> > 
> > The current kernel also don't provide any interfaces for the
> > userspace to learn about the memory tier hierarchy in order to
> > optimize its memory allocations.
> > 
> > This patch series address the above by defining memory tiers explicitly.
> > 
> > This patch introduce explicity memory tiers with ranks. The rank
> > value of a memory tier is used to derive the demotion order between
> > NUMA nodes. The memory tiers present in a system can be found at
> > 
> > /sys/devices/system/memtier/memtierN/
> > 
> > The nodes which are part of a specific memory tier can be listed
> > via
> > /sys/devices/system/memtier/memtierN/nodelist
> > 
> > "Rank" is an opaque value. Its absolute value doesn't have any
> > special meaning. But the rank values of different memtiers can be
> > compared with each other to determine the memory tier order.
> > 
> > For example, if we have 3 memtiers: memtier0, memtier1, memiter2, and
> > their rank values are 300, 200, 100, then the memory tier order is:
> > memtier0 -> memtier2 -> memtier1, where memtier0 is the highest tier
> > and memtier1 is the lowest tier.
> > 
> > The rank value of each memtier should be unique.
> > 
> > A higher rank memory tier will appear first in the demotion order
> > than a lower rank memory tier. ie. while reclaim we choose a node
> > in higher rank memory tier to demote pages to as compared to a node
> > in a lower rank memory tier.
> > 
> > For now we are not adding the dynamic number of memory tiers.
> > But a future series supporting that is possible. Currently
> > number of tiers supported is limitted to MAX_MEMORY_TIERS(3).
> > When doing memory hotplug, if not added to a memory tier, the NUMA
> > node gets added to DEFAULT_MEMORY_TIER(1).
> > 
> > This patch is based on the proposal sent by Wei Xu <weixugc@google.com> at [1].
> > 
> > [1] https://lore.kernel.org/linux-mm/CAAPL-u9Wv+nH1VOZTj=9p9S70Y3Qz3+63EkqncRDdHfubsrjfw@mail.gmail.com
> > 
> > Suggested-by: Wei Xu <weixugc@google.com>
> > Signed-off-by: Jagdish Gediya <jvgediya@linux.ibm.com>
> > Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> > ---
> >  include/linux/memory-tiers.h |  20 ++++
> >  mm/Kconfig                   |  11 ++
> >  mm/Makefile                  |   1 +
> >  mm/memory-tiers.c            | 188 +++++++++++++++++++++++++++++++++++
> >  4 files changed, 220 insertions(+)
> >  create mode 100644 include/linux/memory-tiers.h
> >  create mode 100644 mm/memory-tiers.c
> > 
> > diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
> > new file mode 100644
> > index 000000000000..e17f6b4ee177
> > --- /dev/null
> > +++ b/include/linux/memory-tiers.h
> > @@ -0,0 +1,20 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef _LINUX_MEMORY_TIERS_H
> > +#define _LINUX_MEMORY_TIERS_H
> > +
> > +#ifdef CONFIG_TIERED_MEMORY
> > +
> > +#define MEMORY_TIER_HBM_GPU    0
> > +#define MEMORY_TIER_DRAM       1
> > +#define MEMORY_TIER_PMEM       2
> > +
> > +#define MEMORY_RANK_HBM_GPU    300
> > +#define MEMORY_RANK_DRAM       200
> > +#define MEMORY_RANK_PMEM       100
> > +
> > +#define DEFAULT_MEMORY_TIER    MEMORY_TIER_DRAM
> > +#define MAX_MEMORY_TIERS  3
> > +
> > +#endif /* CONFIG_TIERED_MEMORY */
> > +
> > +#endif
> > diff --git a/mm/Kconfig b/mm/Kconfig
> > index 169e64192e48..08a3d330740b 100644
> > --- a/mm/Kconfig
> > +++ b/mm/Kconfig
> > @@ -614,6 +614,17 @@ config ARCH_ENABLE_HUGEPAGE_MIGRATION
> >  config ARCH_ENABLE_THP_MIGRATION
> >         bool
> > 
> > +config TIERED_MEMORY
> > +       bool "Support for explicit memory tiers"
> > +       def_bool n
> > +       depends on MIGRATION && NUMA
> > +       help
> > +         Support to split nodes into memory tiers explicitly and
> > +         to demote pages on reclaim to lower tiers. This option
> > +         also exposes sysfs interface to read nodes available in
> > +         specific tier and to move specific node among different
> > +         possible tiers.
> 
> IMHO we should not need a new kernel config. If tiering is not present
> then there is just one tier on the system. And tiering is a kind of
> hardware configuration, the information could be shown regardless of
> whether demotion/promotion is supported/enabled or not.

I think so too.  At least it appears unnecessary to let the user turn
on/off it at configuration time.

All the code should be enclosed by #if defined(CONFIG_NUMA) &&
defined(CONIFIG_MIGRATION).  So we will not waste memory in small
systems.

Best Regards,
Huang, Ying

> > +
> >  config HUGETLB_PAGE_SIZE_VARIABLE
> >         def_bool n
> >         help
> > diff --git a/mm/Makefile b/mm/Makefile
> > index 6f9ffa968a1a..482557fbc9d1 100644
> > --- a/mm/Makefile
> > +++ b/mm/Makefile
> > @@ -92,6 +92,7 @@ obj-$(CONFIG_KFENCE) += kfence/
> >  obj-$(CONFIG_FAILSLAB) += failslab.o
> >  obj-$(CONFIG_MEMTEST)          += memtest.o
> >  obj-$(CONFIG_MIGRATION) += migrate.o
> > +obj-$(CONFIG_TIERED_MEMORY) += memory-tiers.o
> >  obj-$(CONFIG_DEVICE_MIGRATION) += migrate_device.o
> >  obj-$(CONFIG_TRANSPARENT_HUGEPAGE) += huge_memory.o khugepaged.o
> >  obj-$(CONFIG_PAGE_COUNTER) += page_counter.o
> > diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
> > new file mode 100644
> > index 000000000000..7de18d94a08d
> > --- /dev/null
> > +++ b/mm/memory-tiers.c
> > @@ -0,0 +1,188 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#include <linux/types.h>
> > +#include <linux/device.h>
> > +#include <linux/nodemask.h>
> > +#include <linux/slab.h>
> > +#include <linux/memory-tiers.h>
> > +
> > +struct memory_tier {
> > +       struct list_head list;
> > +       struct device dev;
> > +       nodemask_t nodelist;
> > +       int rank;
> > +};
> > +
> > +#define to_memory_tier(device) container_of(device, struct memory_tier, dev)
> > +
> > +static struct bus_type memory_tier_subsys = {
> > +       .name = "memtier",
> > +       .dev_name = "memtier",
> > +};
> > +
> > +static DEFINE_MUTEX(memory_tier_lock);
> > +static LIST_HEAD(memory_tiers);
> > +
> > +
> > +static ssize_t nodelist_show(struct device *dev,
> > +                            struct device_attribute *attr, char *buf)
> > +{
> > +       struct memory_tier *memtier = to_memory_tier(dev);
> > +
> > +       return sysfs_emit(buf, "%*pbl\n",
> > +                         nodemask_pr_args(&memtier->nodelist));
> > +}
> > +static DEVICE_ATTR_RO(nodelist);
> > +
> > +static ssize_t rank_show(struct device *dev,
> > +                        struct device_attribute *attr, char *buf)
> > +{
> > +       struct memory_tier *memtier = to_memory_tier(dev);
> > +
> > +       return sysfs_emit(buf, "%d\n", memtier->rank);
> > +}
> > +static DEVICE_ATTR_RO(rank);
> > +
> > +static struct attribute *memory_tier_dev_attrs[] = {
> > +       &dev_attr_nodelist.attr,
> > +       &dev_attr_rank.attr,
> > +       NULL
> > +};
> > +
> > +static const struct attribute_group memory_tier_dev_group = {
> > +       .attrs = memory_tier_dev_attrs,
> > +};
> > +
> > +static const struct attribute_group *memory_tier_dev_groups[] = {
> > +       &memory_tier_dev_group,
> > +       NULL
> > +};
> > +
> > +static void memory_tier_device_release(struct device *dev)
> > +{
> > +       struct memory_tier *tier = to_memory_tier(dev);
> > +
> > +       kfree(tier);
> > +}
> > +
> > +/*
> > + * Keep it simple by having  direct mapping between
> > + * tier index and rank value.
> > + */
> > +static inline int get_rank_from_tier(unsigned int tier)
> > +{
> > +       switch (tier) {
> > +       case MEMORY_TIER_HBM_GPU:
> > +               return MEMORY_RANK_HBM_GPU;
> > +       case MEMORY_TIER_DRAM:
> > +               return MEMORY_RANK_DRAM;
> > +       case MEMORY_TIER_PMEM:
> > +               return MEMORY_RANK_PMEM;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static void insert_memory_tier(struct memory_tier *memtier)
> > +{
> > +       struct list_head *ent;
> > +       struct memory_tier *tmp_memtier;
> > +
> > +       list_for_each(ent, &memory_tiers) {
> > +               tmp_memtier = list_entry(ent, struct memory_tier, list);
> > +               if (tmp_memtier->rank < memtier->rank) {
> > +                       list_add_tail(&memtier->list, ent);
> > +                       return;
> > +               }
> > +       }
> > +       list_add_tail(&memtier->list, &memory_tiers);
> > +}
> > +
> > +static struct memory_tier *register_memory_tier(unsigned int tier)
> > +{
> > +       int error;
> > +       struct memory_tier *memtier;
> > +
> > +       if (tier >= MAX_MEMORY_TIERS)
> > +               return NULL;
> > +
> > +       memtier = kzalloc(sizeof(struct memory_tier), GFP_KERNEL);
> > +       if (!memtier)
> > +               return NULL;
> > +
> > +       memtier->dev.id = tier;
> > +       memtier->rank = get_rank_from_tier(tier);
> > +       memtier->dev.bus = &memory_tier_subsys;
> > +       memtier->dev.release = memory_tier_device_release;
> > +       memtier->dev.groups = memory_tier_dev_groups;
> > +
> > +       insert_memory_tier(memtier);
> > +
> > +       error = device_register(&memtier->dev);
> > +       if (error) {
> > +               list_del(&memtier->list);
> > +               put_device(&memtier->dev);
> > +               return NULL;
> > +       }
> > +       return memtier;
> > +}
> > +
> > +__maybe_unused // temporay to prevent warnings during bisects
> > +static void unregister_memory_tier(struct memory_tier *memtier)
> > +{
> > +       list_del(&memtier->list);
> > +       device_unregister(&memtier->dev);
> > +}
> > +
> > +static ssize_t
> > +max_tier_show(struct device *dev, struct device_attribute *attr, char *buf)
> > +{
> > +       return sysfs_emit(buf, "%d\n", MAX_MEMORY_TIERS);
> > +}
> > +static DEVICE_ATTR_RO(max_tier);
> > +
> > +static ssize_t
> > +default_tier_show(struct device *dev, struct device_attribute *attr, char *buf)
> > +{
> > +       return sysfs_emit(buf, "memtier%d\n", DEFAULT_MEMORY_TIER);
> > +}
> > +static DEVICE_ATTR_RO(default_tier);
> > +
> > +static struct attribute *memory_tier_attrs[] = {
> > +       &dev_attr_max_tier.attr,
> > +       &dev_attr_default_tier.attr,
> > +       NULL
> > +};
> > +
> > +static const struct attribute_group memory_tier_attr_group = {
> > +       .attrs = memory_tier_attrs,
> > +};
> > +
> > +static const struct attribute_group *memory_tier_attr_groups[] = {
> > +       &memory_tier_attr_group,
> > +       NULL,
> > +};
> > +
> > +static int __init memory_tier_init(void)
> > +{
> > +       int ret;
> > +       struct memory_tier *memtier;
> > +
> > +       ret = subsys_system_register(&memory_tier_subsys, memory_tier_attr_groups);
> > +       if (ret)
> > +               panic("%s() failed to register subsystem: %d\n", __func__, ret);
> > +
> > +       /*
> > +        * Register only default memory tier to hide all empty
> > +        * memory tier from sysfs.
> > +        */
> > +       memtier = register_memory_tier(DEFAULT_MEMORY_TIER);
> > +       if (!memtier)
> > +               panic("%s() failed to register memory tier: %d\n", __func__, ret);
> > +
> > +       /* CPU only nodes are not part of memory tiers. */
> > +       memtier->nodelist = node_states[N_MEMORY];
> > +
> > +       return 0;
> > +}
> > +subsys_initcall(memory_tier_init);
> > +
> > --
> > 2.36.1
> > 


