Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16A235927E2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 04:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbiHOCt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 22:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbiHOCtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 22:49:55 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38DB13D55
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 19:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660531794; x=1692067794;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=tB6VsR4a2LMqyhb0v/1jwuRQahmaC3JDWBwMeSJ3pmM=;
  b=l4hcgd8TEOJ0OYI5KJH+GcpeksWDmO8lZkfaYKOoBlkuHwUbssA2fwxL
   S8eyCyffEF1r7HhJ+PfMFOlLiKzpa3jJqiDnOR3LNGMAf0uDoM1LkfF+y
   AIxEPxNTBe6wwiQMu/XeuqOyRo+FIsHGs+MN0WR6SjETi11bMrTqqQpMa
   8Oo71owUqfb6n5gACBO1HhGiv4o/rV7QLPrTNy5+CW36GRZZmooSd6++3
   vXICIF8xoV6eklc7jNssEvTxS42wFnti0/3M39v/lwaxhjEa3xp69iu6M
   3by9vZWTXwckn/1m5q8yC9YWLGFhd1OXm9/sHr/Yw1fWLorNxFKz65uVX
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10439"; a="291875778"
X-IronPort-AV: E=Sophos;i="5.93,237,1654585200"; 
   d="scan'208";a="291875778"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2022 19:49:54 -0700
X-IronPort-AV: E=Sophos;i="5.93,237,1654585200"; 
   d="scan'208";a="557142202"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2022 19:49:50 -0700
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
        Bharata B Rao <bharata@amd.com>
Subject: Re: [PATCH v14 00/10] mm/demotion: Memory tiers and demotion
References: <20220812055710.357820-1-aneesh.kumar@linux.ibm.com>
Date:   Mon, 15 Aug 2022 10:49:46 +0800
In-Reply-To: <20220812055710.357820-1-aneesh.kumar@linux.ibm.com> (Aneesh
        Kumar K. V.'s message of "Fri, 12 Aug 2022 11:26:59 +0530")
Message-ID: <87sflycjat.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:

> The current kernel has the basic memory tiering support: Inactive pages on a
> higher tier NUMA node can be migrated (demoted) to a lower tier NUMA node to
> make room for new allocations on the higher tier NUMA node. Frequently accessed
> pages on a lower tier NUMA node can be migrated (promoted) to a higher tier NUMA
> node to improve the performance.
>
> In the current kernel, memory tiers are defined implicitly via a demotion path
> relationship between NUMA nodes, which is created during the kernel
> initialization and updated when a NUMA node is hot-added or hot-removed. The
> current implementation puts all nodes with CPU into the highest tier, and builds the
> tier hierarchy tier-by-tier by establishing the per-node demotion targets based
> on the distances between nodes.
>
> This current memory tier kernel implementation needs to be improved for several
> important use cases:
>
> * The current tier initialization code always initializes each memory-only NUMA
>   node into a lower tier. But a memory-only NUMA node may have a high
>   performance memory device (e.g. a DRAM-backed memory-only node on a virtual
>   machine) and that should be put into a higher tier.
>
> * The current tier hierarchy always puts CPU nodes into the top tier. But on a
>   system with HBM (e.g. GPU memory) devices, these memory-only HBM NUMA nodes
>   should be in the top tier, and DRAM nodes with CPUs are better to be placed
>   into the next lower tier.
>
> * Also because the current tier hierarchy always puts CPU nodes into the top
>   tier, when a CPU is hot-added (or hot-removed) and triggers a memory node from
>   CPU-less into a CPU node (or vice versa), the memory tier hierarchy gets
>   changed, even though no memory node is added or removed. This can make the
>   tier hierarchy unstable and make it difficult to support tier-based memory
>   accounting.
>
> * A higher tier node can only be demoted to nodes with shortest distance on the
>   next lower tier as defined by the demotion path, not any other node from any
>   lower tier. This strict, demotion order does not work in all use
>   cases (e.g. some use cases may want to allow cross-socket demotion to another
>   node in the same demotion tier as a fallback when the preferred demotion node
>   is out of space), and has resulted in the feature request for an interface to
>   override the system-wide, per-node demotion order from the userspace. This
>   demotion order is also inconsistent with the page allocation fallback order
>   when all the nodes in a higher tier are out of space: The page allocation can
>   fall back to any node from any lower tier, whereas the demotion order doesn't
>   allow that.
>
> This patch series make the creation of memory tiers explicit under
> the control of device driver.
>
> Memory Tier Initialization
> ==========================
>
> Linux kernel presents memory devices as NUMA nodes and each memory device is of
> a specific type. The memory type of a device is represented by its abstract 
> distance. A memory tier corresponds to a range of abstract distance. This allows
> for classifying memory devices with a specific performance range into a memory
> tier.
>
> By default, all memory nodes are assigned to the default tier with
> abstract distance 512.
>
> A device driver can move its memory nodes from the default tier. For example,
> PMEM can move its memory nodes below the default tier, whereas GPU can move its
> memory nodes above the default tier.
>
> The kernel initialization code makes the decision on which exact tier a memory
> node should be assigned to based on the requests from the device drivers as well
> as the memory device hardware information provided by the firmware.
>
> Hot-adding/removing CPUs doesn't affect memory tier hierarchy.
>
> Changes from v13
> * Address review feedback.
> * Add path dropping memtier from struct memory_dev_type
>
> Changes from v12
> * Fix kernel crash on module unload
> * Address review feedback.
> * Add node_random patch to this series based on review feedback
>
> Changes from v11:
> * smaller abstract distance imply faster(higher) memory tier.
>
> Changes from v10:
> * rename performance level to abstract distance
> * Thanks to all the good feedback from Huang, Ying <ying.huang@intel.com>.
>   Updated the patchset to cover most of the review feedback.
>
> Changes from v9:
> * Use performance level for initializing memory tiers.
>
> Changes from v8:
> * Drop the sysfs interface patches and  related documentation changes.
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
>
> Aneesh Kumar K.V (9):
>   mm/demotion: Add support for explicit memory tiers
>   mm/demotion: Move memory demotion related code
>   mm/demotion: Add hotplug callbacks to handle new numa node onlined
>   mm/demotion/dax/kmem: Set node's abstract distance to
>     MEMTIER_DEFAULT_DAX_ADISTANCE
>   mm/demotion: Build demotion targets based on explicit memory tiers
>   mm/demotion: Add pg_data_t member to track node memory tier details
>   mm/demotion: Drop memtier from memtype
>   mm/demotion: Update node_is_toptier to work with memory tiers
>   lib/nodemask: Optimize node_random for nodemask with single NUMA node
>
> Jagdish Gediya (1):
>   mm/demotion: Demote pages according to allocation fallback order
>
>  drivers/dax/kmem.c           |  42 ++-
>  include/linux/memory-tiers.h |  99 ++++++
>  include/linux/migrate.h      |  15 -
>  include/linux/mmzone.h       |   3 +
>  include/linux/node.h         |   5 -
>  include/linux/nodemask.h     |  15 +-
>  mm/Makefile                  |   1 +
>  mm/huge_memory.c             |   1 +
>  mm/memory-tiers.c            | 645 +++++++++++++++++++++++++++++++++++
>  mm/migrate.c                 | 453 +-----------------------
>  mm/mprotect.c                |   1 +
>  mm/vmscan.c                  |  59 +++-
>  mm/vmstat.c                  |   4 -
>  13 files changed, 846 insertions(+), 497 deletions(-)
>  create mode 100644 include/linux/memory-tiers.h
>  create mode 100644 mm/memory-tiers.c

Except some minor comments, the series looks good to me.  Thanks!  Feel
free to add

Reviewed-by: "Huang, Ying" <ying.huang@intel.com>

for the whole series.

Best Regards,
Huang, Ying
