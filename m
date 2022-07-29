Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBEC1584B31
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 07:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234569AbiG2Fav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 01:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234391AbiG2Fa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 01:30:26 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE851193E5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 22:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659072622; x=1690608622;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=ercbijlouhtyzIM3o1wUqu+SodLfktbd6L58SWuUJoI=;
  b=kR9hdSnnc8MpgLjfbbNY+GGjhw+RKnzOmWDwX7b8yMguA2F6+/ggDflT
   87BSuM7bqnjkeR8MhCeSIufWidZ14NVAI2hxJU/AShSQb1Dux6Z3fFhFn
   nqEGy2f6nLgQM4Qx9+eIIUsVTMQUNfRJCf1PHJiWls00Yjku/fvw2a6eg
   SsONYdm7qAiWVaznVMN89nPlUCHRZiss3fS/OGgC6O4HIg5wbICbWmA8s
   RN6tk/VLSWxCeGBm+t3BvaGYMHYt/HgxtteQRD3ukIohFJp1hEGGrv3YJ
   WbfyzF0IfMSwkO8lpQZmnEEVVaym4kmKSNv6/WSFeWyRIoqTAZBtN0VtF
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10422"; a="286244831"
X-IronPort-AV: E=Sophos;i="5.93,200,1654585200"; 
   d="scan'208";a="286244831"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2022 22:30:22 -0700
X-IronPort-AV: E=Sophos;i="5.93,200,1654585200"; 
   d="scan'208";a="928616797"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.94])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2022 22:30:19 -0700
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
Subject: Re: [PATCH v11 0/8] mm/demotion: Memory tiers and demotion
References: <20220728190436.858458-1-aneesh.kumar@linux.ibm.com>
Date:   Fri, 29 Jul 2022 13:30:08 +0800
In-Reply-To: <20220728190436.858458-1-aneesh.kumar@linux.ibm.com> (Aneesh
        Kumar K. V.'s message of "Fri, 29 Jul 2022 00:34:28 +0530")
Message-ID: <87a68smqov.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
> current implementation puts all nodes with CPU into the top tier, and builds the
> tier hierarchy tier-by-tier by establishing the per-node demotion targets based
> on the distances between nodes.
>
> This current memory tier kernel interface needs to be improved for several
> important use cases:
>
> * The current tier initialization code always initializes each memory-only NUMA
>   node into a lower tier. But a memory-only NUMA node may have a high
>   performance memory device (e.g. a DRAM device attached via CXL.mem or a
>   DRAM-backed memory-only node on a virtual machine) and should be put into a
>   higher tier.
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
> * A higher tier node can only be demoted to selected nodes on the next lower
>   tier as defined by the demotion path, not any other node from any lower tier.
>   This strict, hard-coded demotion order does not work in all use cases (e.g.
>   some use cases may want to allow cross-socket demotion to another node in the
>   same demotion tier as a fallback when the preferred demotion node is out of
>   space), and has resulted in the feature request for an interface to override
>   the system-wide, per-node demotion order from the userspace. This demotion
>   order is also inconsistent with the page allocation fallback order when all
>   the nodes in a higher tier are out of space: The page allocation can fall back
>   to any node from any lower tier, whereas the demotion order doesn't allow
>   that.
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

Some patch description of [0/8] is same as that of [1/8] originally.  It
appears that you revised [1/8], but forget to revise [0/8] too.  Please
do that.

Best Regards,
Huang, Ying

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
> Aneesh Kumar K.V (7):
>   mm/demotion: Add support for explicit memory tiers
>   mm/demotion: Move memory demotion related code
>   mm/demotion: Add hotplug callbacks to handle new numa node onlined
>   mm/demotion/dax/kmem: Set node's abstract distance to
>     MEMTIER_ADISTANCE_PMEM
>   mm/demotion: Build demotion targets based on explicit memory tiers
>   mm/demotion: Add pg_data_t member to track node memory tier details
>   mm/demotion: Update node_is_toptier to work with memory tiers
>
> Jagdish Gediya (1):
>   mm/demotion: Demote pages according to allocation fallback order
>
>  drivers/dax/kmem.c           |   9 +
>  include/linux/memory-tiers.h |  79 +++++
>  include/linux/migrate.h      |  15 -
>  include/linux/mmzone.h       |   3 +
>  include/linux/node.h         |   5 -
>  mm/Makefile                  |   1 +
>  mm/huge_memory.c             |   1 +
>  mm/memory-tiers.c            | 586 +++++++++++++++++++++++++++++++++++
>  mm/migrate.c                 | 453 +--------------------------
>  mm/mprotect.c                |   1 +
>  mm/vmscan.c                  |  59 +++-
>  mm/vmstat.c                  |   4 -
>  12 files changed, 725 insertions(+), 491 deletions(-)
>  create mode 100644 include/linux/memory-tiers.h
>  create mode 100644 mm/memory-tiers.c
