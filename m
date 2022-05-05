Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7F5551BB4A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 10:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345239AbiEEJBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 05:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351298AbiEEJBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 05:01:44 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 058BB4BB83
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 01:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651741079; x=1683277079;
  h=message-id:subject:from:to:date:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=OwaADqInLFvML8Pzn4Xj8vEJaMmYcXVodZ6+QSyN9F0=;
  b=O4zw4w0n5hdX8uMVJnkzi3HMQtbV5nd+5NOmlvnifnLnBbpVwbLHpW1k
   Yd2O+miTCFCQk6qQvtP8IeXCPbupST71dAblDr3fO8Hsul5ORbkBhnQvf
   9YPmgRaAxKWxIx097mfF5MwCLsz5VZ3m/iuR/McUxHerWUZta4wQnqS4S
   d6ONjoB4OTw/Kch88lqFc1IwhuFqjcaC1OiZP8uN9JRjzJDLsTWe+qbV6
   HfBngH7WbpxLy+CeHJ+O90CTMHpL3G7n3rbZhjfbcpy7110DxQhdjFDj8
   W6CfLZb0c50YCk9Dq9/OCfFLz1jtnvlZ623xq4J8y11F2GpWF74z2hnvp
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="268196432"
X-IronPort-AV: E=Sophos;i="5.91,200,1647327600"; 
   d="scan'208";a="268196432"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 01:57:59 -0700
X-IronPort-AV: E=Sophos;i="5.91,200,1647327600"; 
   d="scan'208";a="537244278"
Received: from jchen40-mobl2.ccr.corp.intel.com ([10.254.213.126])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 01:57:55 -0700
Message-ID: <867bc216386eb6cbf54648f23e5825830f5b922e.camel@intel.com>
Subject: Re: RFC: Memory Tiering Kernel Interfaces
From:   "ying.huang@intel.com" <ying.huang@intel.com>
To:     Wei Xu <weixugc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Yang Shi <shy828301@gmail.com>, Linux MM <linux-mm@kvack.org>,
        Greg Thelen <gthelen@google.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alistair Popple <apopple@nvidia.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Michal Hocko <mhocko@kernel.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Feng Tang <feng.tang@intel.com>, Jonathan.Cameron@huawei.com
Date:   Thu, 05 May 2022 16:57:53 +0800
In-Reply-To: <CAAPL-u9sVx94ACSuCVN8V0tKp+AMxiY89cro0japtyB=xNfNBw@mail.gmail.com>
References: <CAAPL-u9sVx94ACSuCVN8V0tKp+AMxiY89cro0japtyB=xNfNBw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-04-29 at 19:10 -0700, Wei Xu wrote:
> The current kernel has the basic memory tiering support: Inactive
> pages on a higher tier NUMA node can be migrated (demoted) to a lower
> tier NUMA node to make room for new allocations on the higher tier
> NUMA node.  Frequently accessed pages on a lower tier NUMA node can be
> migrated (promoted) to a higher tier NUMA node to improve the
> performance.
> 
> A tiering relationship between NUMA nodes in the form of demotion path
> is created during the kernel initialization and updated when a NUMA
> node is hot-added or hot-removed.  The current implementation puts all
> nodes with CPU into the top tier, and then builds the tiering hierarchy
> tier-by-tier by establishing the per-node demotion targets based on
> the distances between nodes.
> 
> The current memory tiering interface needs to be improved to address
> several important use cases:
> 
> * The current tiering initialization code always initializes
>   each memory-only NUMA node into a lower tier.  But a memory-only
>   NUMA node may have a high performance memory device (e.g. a DRAM
>   device attached via CXL.mem or a DRAM-backed memory-only node on
>   a virtual machine) and should be put into the top tier.
> 
> * The current tiering hierarchy always puts CPU nodes into the top
>   tier. But on a system with HBM (e.g. GPU memory) devices, these
>   memory-only HBM NUMA nodes should be in the top tier, and DRAM nodes
>   with CPUs are better to be placed into the next lower tier.
> 
> * Also because the current tiering hierarchy always puts CPU nodes
>   into the top tier, when a CPU is hot-added (or hot-removed) and
>   triggers a memory node from CPU-less into a CPU node (or vice
>   versa), the memory tiering hierarchy gets changed, even though no
>   memory node is added or removed.  This can make the tiering
>   hierarchy much less stable.
> 
> * A higher tier node can only be demoted to selected nodes on the
>   next lower tier, not any other node from the next lower tier.  This
>   strict, hard-coded demotion order does not work in all use cases
>   (e.g. some use cases may want to allow cross-socket demotion to
>   another node in the same demotion tier as a fallback when the
>   preferred demotion node is out of space), and has resulted in the
>   feature request for an interface to override the system-wide,
>   per-node demotion order from the userspace.
> 
> * There are no interfaces for the userspace to learn about the memory
>   tiering hierarchy in order to optimize its memory allocations.
> 
> I'd like to propose revised memory tiering kernel interfaces based on
> the discussions in the threads:
> 
> - https://lore.kernel.org/lkml/20220425201728.5kzm4seu7rep7ndr@offworld/T/
> - https://lore.kernel.org/linux-mm/20220426114300.00003ad8@Huawei.com/t/
> 
> 
> Sysfs Interfaces
> ================
> 
> * /sys/devices/system/node/memory_tiers
> 
>   Format: node list (one tier per line, in the tier order)
> 
>   When read, list memory nodes by tiers.
> 
>   When written (one tier per line), take the user-provided node-tier
>   assignment as the new tiering hierarchy and rebuild the per-node
>   demotion order.  It is allowed to only override the top tiers, in
>   which cases, the kernel will establish the lower tiers automatically.
> 
> 
> Kernel Representation
> =====================
> 
> * nodemask_t node_states[N_TOPTIER_MEMORY]
> 
>   Store all top-tier memory nodes.
> 
> * nodemask_t memory_tiers[MAX_TIERS]
> 
>   Store memory nodes by tiers.
> 
> * struct demotion_nodes node_demotion[]
> 
>   where: struct demotion_nodes { nodemask_t preferred; nodemask_t allowed; }
> 
>   For a node N:
> 
>   node_demotion[N].preferred lists all preferred demotion targets;
> 
>   node_demotion[N].allowed lists all allowed demotion targets
>   (initialized to be all the nodes in the same demotion tier).
> 
> 
> Tiering Hierarchy Initialization
> ================================
> 
> By default, all memory nodes are in the top tier (N_TOPTIER_MEMORY).
> 
> A device driver can remove its memory nodes from the top tier, e.g.
> a dax driver can remove PMEM nodes from the top tier.
> 
> The kernel builds the memory tiering hierarchy and per-node demotion
> order tier-by-tier starting from N_TOPTIER_MEMORY.  For a node N, the
> best distance nodes in the next lower tier are assigned to
> node_demotion[N].preferred and all the nodes in the next lower tier
> are assigned to node_demotion[N].allowed.
> 
> node_demotion[N].preferred can be empty if no preferred demotion node
> is available for node N.
> 
> If the userspace overrides the tiers via the memory_tiers sysfs
> interface, the kernel then only rebuilds the per-node demotion order
> accordingly.
> 
> Memory tiering hierarchy is rebuilt upon hot-add or hot-remove of a
> memory node, but is NOT rebuilt upon hot-add or hot-remove of a CPU
> node.
> 
> 
> Memory Allocation for Demotion
> ==============================
> 
> When allocating a new demotion target page, both a preferred node
> and the allowed nodemask are provided to the allocation function.
> The default kernel allocation fallback order is used to allocate the
> page from the specified node and nodemask.
> 
> The memopolicy of cpuset, vma and owner task of the source page can
> be set to refine the demotion nodemask, e.g. to prevent demotion or
> select a particular allowed node as the demotion target.
> 
> 
> Examples
> ========
> 
> * Example 1:
>   Node 0 & 1 are DRAM nodes, node 2 & 3 are PMEM nodes.
> 
>   Node 0 has node 2 as the preferred demotion target and can also
>   fallback demotion to node 3.
> 
>   Node 1 has node 3 as the preferred demotion target and can also
>   fallback demotion to node 2.
> 
>   Set mempolicy to prevent cross-socket demotion and memory access,
>   e.g. cpuset.mems=0,2
> 
> node distances:
> node   0    1    2    3
>    0  10   20   30   40
>    1  20   10   40   30
>    2  30   40   10   40
>    3  40   30   40   10
> 
> /sys/devices/system/node/memory_tiers
> 0-1
> 2-3
> 
> N_TOPTIER_MEMORY: 0-1
> 
> node_demotion[]:
>   0: [2], [2-3]
>   1: [3], [2-3]
>   2: [],  []
>   3: [],  []
> 
> * Example 2:
>   Node 0 & 1 are DRAM nodes.
>   Node 2 is a PMEM node and closer to node 0.
> 
>   Node 0 has node 2 as the preferred and only demotion target.
> 
>   Node 1 has no preferred demotion target, but can still demote
>   to node 2.
> 
>   Set mempolicy to prevent cross-socket demotion and memory access,
>   e.g. cpuset.mems=0,2
> 
> node distances:
> node   0    1    2
>    0  10   20   30
>    1  20   10   40
>    2  30   40   10
> 
> /sys/devices/system/node/memory_tiers
> 0-1
> 2
> 
> N_TOPTIER_MEMORY: 0-1
> 
> node_demotion[]:
>   0: [2], [2]
>   1: [],  [2]
>   2: [],  []
> 
> 
> * Example 3:
>   Node 0 & 1 are DRAM nodes.
>   Node 2 is a PMEM node and has the same distance to node 0 & 1.
> 
>   Node 0 has node 2 as the preferred and only demotion target.
> 
>   Node 1 has node 2 as the preferred and only demotion target.
> 
> node distances:
> node   0    1    2
>    0  10   20   30
>    1  20   10   30
>    2  30   30   10
> 
> /sys/devices/system/node/memory_tiers
> 0-1
> 2
> 
> N_TOPTIER_MEMORY: 0-1
> 
> node_demotion[]:
>   0: [2], [2]
>   1: [2], [2]
>   2: [],  []
> 
> 
> * Example 4:
>   Node 0 & 1 are DRAM nodes, Node 2 is a memory-only DRAM node.
> 
>   All nodes are top-tier.
> 
> node distances:
> node   0    1    2
>    0  10   20   30
>    1  20   10   30
>    2  30   30   10
> 
> /sys/devices/system/node/memory_tiers
> 0-2
> 
> N_TOPTIER_MEMORY: 0-2
> 
> node_demotion[]:
>   0: [],  []
>   1: [],  []
>   2: [],  []
> 
> 
> * Example 5:
>   Node 0 is a DRAM node with CPU.
>   Node 1 is a HBM node.
>   Node 2 is a PMEM node.
> 
>   With userspace override, node 1 is the top tier and has node 0 as
>   the preferred and only demotion target.
> 
>   Node 0 is in the second tier, tier 1, and has node 2 as the
>   preferred and only demotion target.
> 
>   Node 2 is in the lowest tier, tier 2, and has no demotion targets.
> 
> node distances:
> node   0    1    2
>    0  10   21   30
>    1  21   10   40
>    2  30   40   10
> 
> /sys/devices/system/node/memory_tiers (userspace override)
> 1
> 0
> 2
> 
> N_TOPTIER_MEMORY: 1
> 
> node_demotion[]:
>   0: [2], [2]
>   1: [0], [0]
>   2: [],  []

Sorry for late reply.

I think the proposed interfaces above and more "tiered" organization is
a good idea in general.  As in your later email, we should use one file
for each tier as suggested by Dave Hansen.  And we can start with 2
tiers for now.  That is, all nodes start with tier0, and the nodes
onlined via kmem dax driver are in tierN (N >= 1) as suggested by Aneesh
Kumar and Jagdish Gediya.  When we have more information and clearer
requirement in the future, we can improve our implementation and extend
our user space interface.

We can even start with just one file: "tier0", because all nodes except
that in tier0 will be in tier1.

Best Regards,
Huang, Ying


