Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB93566269
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 06:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234218AbiGEEaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 00:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbiGEEaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 00:30:21 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3287C60FD
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 21:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656995420; x=1688531420;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=4iSVL5XrTKRcFj2RV5PluukMrOatIbtb3cD8pWKbhZw=;
  b=VarDAf7lS1GqPWK4FkkBsCyNi3ugOTRQ/4fDpLnxZ9PQwY0Wxk1Nkehs
   zd2Y9uTUg2kRPcR12RCnsFM67/fNtylA8ckwvyQa2cYL59TTCVa7300wh
   ayXM+xCJy1977/6oVc6jiOPf439FtS+WSdpvcCm7a/ERjW05RweI5VSku
   0VrmGiN8dgg6dXZTziZvtN/NoiURY96hNqahuIId3kHEa1xPaG9qGn9Hi
   ZdthQIzYhDx/QJBeR4YKwhAvrISfI2LtXduQWc5G+lvPyT3Ocu8oRHX5p
   R0jZPAwLoy/WISCJb1DBUWzXcfqav+NMNWf1oONhT6G0v2MbRgQJ126Cy
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10398"; a="283274989"
X-IronPort-AV: E=Sophos;i="5.92,245,1650956400"; 
   d="scan'208";a="283274989"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2022 21:30:19 -0700
X-IronPort-AV: E=Sophos;i="5.92,245,1650956400"; 
   d="scan'208";a="567444970"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.94])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2022 21:30:16 -0700
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
Subject: Re: [PATCH v8 00/12] mm/demotion: Memory tiers and demotion
References: <20220704070612.299585-1-aneesh.kumar@linux.ibm.com>
Date:   Tue, 05 Jul 2022 12:29:54 +0800
In-Reply-To: <20220704070612.299585-1-aneesh.kumar@linux.ibm.com> (Aneesh
        Kumar K. V.'s message of "Mon, 4 Jul 2022 12:36:00 +0530")
Message-ID: <87r130b2rh.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Aneesh,

"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:

> The current kernel has the basic memory tiering support: Inactive
> pages on a higher tier NUMA node can be migrated (demoted) to a lower
> tier NUMA node to make room for new allocations on the higher tier
> NUMA node.  Frequently accessed pages on a lower tier NUMA node can be
> migrated (promoted) to a higher tier NUMA node to improve the
> performance.
>
> In the current kernel, memory tiers are defined implicitly via a
> demotion path relationship between NUMA nodes, which is created during
> the kernel initialization and updated when a NUMA node is hot-added or
> hot-removed.  The current implementation puts all nodes with CPU into
> the top tier, and builds the tier hierarchy tier-by-tier by establishing
> the per-node demotion targets based on the distances between nodes.
>
> This current memory tier kernel interface needs to be improved for
> several important use cases:
>
> * The current tier initialization code always initializes
>   each memory-only NUMA node into a lower tier.  But a memory-only
>   NUMA node may have a high performance memory device (e.g. a DRAM
>   device attached via CXL.mem or a DRAM-backed memory-only node on
>   a virtual machine) and should be put into a higher tier.
>
> * The current tier hierarchy always puts CPU nodes into the top
>   tier. But on a system with HBM (e.g. GPU memory) devices, these
>   memory-only HBM NUMA nodes should be in the top tier, and DRAM nodes
>   with CPUs are better to be placed into the next lower tier.
>
> * Also because the current tier hierarchy always puts CPU nodes
>   into the top tier, when a CPU is hot-added (or hot-removed) and
>   triggers a memory node from CPU-less into a CPU node (or vice
>   versa), the memory tier hierarchy gets changed, even though no
>   memory node is added or removed.  This can make the tier
>   hierarchy unstable and make it difficult to support tier-based
>   memory accounting.
>
> * A higher tier node can only be demoted to selected nodes on the
>   next lower tier as defined by the demotion path, not any other
>   node from any lower tier.  This strict, hard-coded demotion order
>   does not work in all use cases (e.g. some use cases may want to
>   allow cross-socket demotion to another node in the same demotion
>   tier as a fallback when the preferred demotion node is out of
>   space), and has resulted in the feature request for an interface to
>   override the system-wide, per-node demotion order from the
>   userspace.  This demotion order is also inconsistent with the page
>   allocation fallback order when all the nodes in a higher tier are
>   out of space: The page allocation can fall back to any node from
>   any lower tier, whereas the demotion order doesn't allow that.
>
> * There are no interfaces for the userspace to learn about the memory
>   tier hierarchy in order to optimize its memory allocations.
>
> This patch series make the creation of memory tiers explicit under
> the control of userspace or device driver.
>
> Memory Tier Initialization
> ==========================
>
> By default, all memory nodes are assigned to the default tier with
> tier ID value 200.
>
> A device driver can move up or down its memory nodes from the default
> tier.  For example, PMEM can move down its memory nodes below the
> default tier, whereas GPU can move up its memory nodes above the
> default tier.
>
> The kernel initialization code makes the decision on which exact tier
> a memory node should be assigned to based on the requests from the
> device drivers as well as the memory device hardware information
> provided by the firmware.
>
> Hot-adding/removing CPUs doesn't affect memory tier hierarchy.
>
> Memory Allocation for Demotion
> ==============================
> This patch series keep the demotion target page allocation logic same.
> The demotion page allocation pick the closest NUMA node in the
> next lower tier to the current NUMA node allocating pages from.
>
> This will be later improved to use the same page allocation strategy
> using fallback list.
>
> Sysfs Interface:
> -------------
> Listing current list of memory tiers details:
>
> :/sys/devices/system/memtier$ ls
> default_tier max_tier  memtier1  power  uevent
> :/sys/devices/system/memtier$ cat default_tier
> memtier200
> :/sys/devices/system/memtier$ cat max_tier 
> 400
> :/sys/devices/system/memtier$ 
>
> Per node memory tier details:
>
> For a cpu only NUMA node:
>
> :/sys/devices/system/node# cat node0/memtier 
> :/sys/devices/system/node# echo 1 > node0/memtier 
> :/sys/devices/system/node# cat node0/memtier 
> :/sys/devices/system/node# 
>
> For a NUMA node with memory:
> :/sys/devices/system/node# cat node1/memtier 
> 1
> :/sys/devices/system/node# ls ../memtier/
> default_tier  max_tier  memtier1  power  uevent
> :/sys/devices/system/node# echo 2 > node1/memtier 
> :/sys/devices/system/node# 
> :/sys/devices/system/node# ls ../memtier/
> default_tier  max_tier  memtier1  memtier2  power  uevent
> :/sys/devices/system/node# cat node1/memtier 
> 2
> :/sys/devices/system/node# 
>
> Removing a memory tier
> :/sys/devices/system/node# cat node1/memtier 
> 2
> :/sys/devices/system/node# echo 1 > node1/memtier

Thanks a lot for your patchset.

Per my understanding, we haven't reach consensus on

- how to create the default memory tiers in kernel (via abstract
  distance provided by drivers?  Or use SLIT as the first step?)

- how to override the default memory tiers from user space

As in the following thread and email,

https://lore.kernel.org/lkml/YqjZyP11O0yCMmiO@cmpxchg.org/

I think that we need to finalized on that firstly?

Best Regards,
Huang, Ying

> :/sys/devices/system/node# 
> :/sys/devices/system/node# cat node1/memtier 
> 1
> :/sys/devices/system/node# 
> :/sys/devices/system/node# ls ../memtier/
> default_tier  max_tier  memtier1  power  uevent
> :/sys/devices/system/node# 
>
> The above resulted in removal of memtier2 which was created in the earlier step.
>
> Changes from v7:
> * Fix kernel crash with demotion.
> * Improve documentation.
>
> Changes from v6:
> * Drop the usage of rank.
> * Address other review feedback.
>
> Changes from v5:
> * Remove patch supporting N_MEMORY node removal from memory tiers. memory tiers
>   are going to be used for features other than demotion. Hence keep all N_MEMORY
>   nodes in memory tiers irrespective of whether they want to participate in promotion or demotion.
> * Add NODE_DATA->memtier
> * Rearrage patches to add sysfs files later.
> * Add support to create memory tiers from userspace.
> * Address other review feedback.
>
>
> Changes from v4:
> * Address review feedback.
> * Reverse the meaning of "rank": higher rank value means higher tier.
> * Add "/sys/devices/system/memtier/default_tier".
> * Add node_is_toptier
>
> v4:
> Add support for explicit memory tiers and ranks.
>
> v3:
> - Modify patch 1 subject to make it more specific
> - Remove /sys/kernel/mm/numa/demotion_targets interface, use
>   /sys/devices/system/node/demotion_targets instead and make
>   it writable to override node_states[N_DEMOTION_TARGETS].
> - Add support to view per node demotion targets via sysfs
>
> v2:
> In v1, only 1st patch of this patch series was sent, which was
> implemented to avoid some of the limitations on the demotion
> target sharing, however for certain numa topology, the demotion
> targets found by that patch was not most optimal, so 1st patch
> in this series is modified according to suggestions from Huang
> and Baolin. Different examples of demotion list comparasion
> between existing implementation and changed implementation can
> be found in the commit message of 1st patch.
>
>
> Aneesh Kumar K.V (10):
>   mm/demotion: Add support for explicit memory tiers
>   mm/demotion: Move memory demotion related code
>   mm/demotion/dax/kmem: Set node's memory tier to MEMORY_TIER_PMEM
>   mm/demotion: Add hotplug callbacks to handle new numa node onlined
>   mm/demotion: Build demotion targets based on explicit memory tiers
>   mm/demotion: Expose memory tier details via sysfs
>   mm/demotion: Add per node memory tier attribute to sysfs
>   mm/demotion: Add pg_data_t member to track node memory tier details
>   mm/demotion: Update node_is_toptier to work with memory tiers
>   mm/demotion: Add sysfs ABI documentation
>
> Jagdish Gediya (2):
>   mm/demotion: Demote pages according to allocation fallback order
>   mm/demotion: Add documentation for memory tiering
>
>  .../ABI/testing/sysfs-kernel-mm-memory-tiers  |  61 ++
>  Documentation/admin-guide/mm/index.rst        |   1 +
>  .../admin-guide/mm/memory-tiering.rst         | 192 +++++
>  drivers/base/node.c                           |  42 +
>  drivers/dax/kmem.c                            |   6 +-
>  include/linux/memory-tiers.h                  |  72 ++
>  include/linux/migrate.h                       |  15 -
>  include/linux/mmzone.h                        |   3 +
>  include/linux/node.h                          |   5 -
>  mm/Makefile                                   |   1 +
>  mm/huge_memory.c                              |   1 +
>  mm/memory-tiers.c                             | 791 ++++++++++++++++++
>  mm/migrate.c                                  | 453 +---------
>  mm/mprotect.c                                 |   1 +
>  mm/vmscan.c                                   |  59 +-
>  mm/vmstat.c                                   |   4 -
>  16 files changed, 1215 insertions(+), 492 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-kernel-mm-memory-tiers
>  create mode 100644 Documentation/admin-guide/mm/memory-tiering.rst
>  create mode 100644 include/linux/memory-tiers.h
>  create mode 100644 mm/memory-tiers.c
