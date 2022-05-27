Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5B9C5363BD
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 16:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352930AbiE0OFf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 27 May 2022 10:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240326AbiE0OFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 10:05:33 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807EB1C920
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 07:05:31 -0700 (PDT)
Received: from fraeml705-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4L8mgL0RJ9z67sMs;
        Fri, 27 May 2022 22:01:18 +0800 (CST)
Received: from lhreml751-chm.china.huawei.com (10.201.108.201) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Fri, 27 May 2022 16:05:29 +0200
Received: from localhost (10.47.84.9) by lhreml751-chm.china.huawei.com
 (10.201.108.201) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 27 May
 2022 15:05:27 +0100
Date:   Fri, 27 May 2022 15:05:24 +0100
From:   Hesham Almatary <hesham.almatary@huawei.com>
To:     Ying Huang <ying.huang@intel.com>
CC:     Wei Xu <weixugc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Thelen <gthelen@google.com>,
        Yang Shi <shy828301@gmail.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim C Chen <tim.c.chen@intel.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        "Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Feng Tang <feng.tang@intel.com>, Linux MM <linux-mm@kvack.org>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        David Rientjes <rientjes@google.com>, <linuxarm@huawei.com>
Subject: Re: RFC: Memory Tiering Kernel Interfaces (v3)
Message-ID: <20220527150524.00000871@huawei.com>
In-Reply-To: <a612bf4ff68c2f6a33f01eb06cc97100a0036332.camel@intel.com>
References: <CAAPL-u-dFp7PwPH6DfbYdnY8xaGsHz3tRQ0CPGVkiqURvdN8=A@mail.gmail.com>
        <a612bf4ff68c2f6a33f01eb06cc97100a0036332.camel@intel.com>
Organization: Huawei UK R&D
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.47.84.9]
X-ClientProxiedBy: lhreml725-chm.china.huawei.com (10.201.108.76) To
 lhreml751-chm.china.huawei.com (10.201.108.201)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Wei and Ying,

Please find my comments below based on a discussion with Jonathan.

On Fri, 27 May 2022 10:58:39 +0800
Ying Huang <ying.huang@intel.com> wrote:

> On Thu, 2022-05-26 at 14:22 -0700, Wei Xu wrote:
> > Changes since v2
> > ================
> > * Updated the design and examples to use "rank" instead of device ID
> >   to determine the order between memory tiers for better
> > flexibility.
> > 
> > Overview
> > ========
> > 
> > The current kernel has the basic memory tiering support: Inactive
> > pages on a higher tier NUMA node can be migrated (demoted) to a
> > lower tier NUMA node to make room for new allocations on the higher
> > tier NUMA node.  Frequently accessed pages on a lower tier NUMA
> > node can be migrated (promoted) to a higher tier NUMA node to
> > improve the performance.
> > 
> > In the current kernel, memory tiers are defined implicitly via a
> > demotion path relationship between NUMA nodes, which is created
> > during the kernel initialization and updated when a NUMA node is
> > hot-added or hot-removed.  The current implementation puts all
> > nodes with CPU into the top tier, and builds the tier hierarchy
> > tier-by-tier by establishing the per-node demotion targets based on
> > the distances between nodes.
> > 
> > This current memory tier kernel interface needs to be improved for
> > several important use cases:
> > 
> > * The current tier initialization code always initializes
> >   each memory-only NUMA node into a lower tier.  But a memory-only
> >   NUMA node may have a high performance memory device (e.g. a DRAM
> >   device attached via CXL.mem or a DRAM-backed memory-only node on
> >   a virtual machine) and should be put into a higher tier.
> > 
> > * The current tier hierarchy always puts CPU nodes into the top
> >   tier. But on a system with HBM (e.g. GPU memory) devices, these
> >   memory-only HBM NUMA nodes should be in the top tier, and DRAM
> > nodes with CPUs are better to be placed into the next lower tier.
> > 
> > * Also because the current tier hierarchy always puts CPU nodes
> >   into the top tier, when a CPU is hot-added (or hot-removed) and
> >   triggers a memory node from CPU-less into a CPU node (or vice
> >   versa), the memory tier hierarchy gets changed, even though no
> >   memory node is added or removed.  This can make the tier
> >   hierarchy unstable and make it difficult to support tier-based
> >   memory accounting.
> > 
> > * A higher tier node can only be demoted to selected nodes on the
> >   next lower tier as defined by the demotion path, not any other
> >   node from any lower tier.  This strict, hard-coded demotion order
> >   does not work in all use cases (e.g. some use cases may want to
> >   allow cross-socket demotion to another node in the same demotion
> >   tier as a fallback when the preferred demotion node is out of
> >   space), and has resulted in the feature request for an interface
> > to override the system-wide, per-node demotion order from the
> >   userspace.  This demotion order is also inconsistent with the page
> >   allocation fallback order when all the nodes in a higher tier are
> >   out of space: The page allocation can fall back to any node from
> >   any lower tier, whereas the demotion order doesn't allow that.
> > 
> > * There are no interfaces for the userspace to learn about the
> > memory tier hierarchy in order to optimize its memory allocations.
> > 
> > I'd like to propose revised memory tier kernel interfaces based on
> > the discussions in the threads:
> > 
> > -
> > https://lore.kernel.org/lkml/20220425201728.5kzm4seu7rep7ndr@offworld/T/
> > -
> > https://lore.kernel.org/linux-mm/20220426114300.00003ad8@Huawei.com/t/
> > -
> > https://lore.kernel.org/linux-mm/867bc216386eb6cbf54648f23e5825830f5b922e.camel@intel.com/T/
> > -
> > https://lore.kernel.org/linux-mm/d6314cfe1c7898a6680bed1e7cc93b0ab93e3155.camel@intel.com/T/
> > 
> > 
> > High-level Design Ideas
> > =======================
> > 
> > * Define memory tiers explicitly, not implicitly.
> > 
> > * Memory tiers are defined based on hardware capabilities of memory
> >   nodes, not their relative node distances between each other.
> > 
> > * The tier assignment of each node is independent from each other.
> >   Moving a node from one tier to another tier doesn't affect the
> > tier assignment of any other node.
> > 
> > * The node-tier association is stable. A node can be reassigned to a
> >   different tier only under the specific conditions that don't block
> >   future tier-based memory cgroup accounting.
> > 
> > * A node can demote its pages to any nodes of any lower tiers. The
> >   demotion target node selection follows the allocation fallback
> > order of the source node, which is built based on node distances.
> > The demotion targets are also restricted to only the nodes from the
> > tiers lower than the source node.  We no longer need to maintain a
> > separate per-node demotion order (node_demotion[]).
> > 
> > 
> > Sysfs Interfaces
> > ================
> > 
> > * /sys/devices/system/memtier/
> > 
> >   This is the directory containing the information about memory
> > tiers.
> > 
> >   Each memory tier has its own subdirectory.
> > 
> >   The order of memory tiers is determined by their rank values, not
> > by their memtier device names.
> > 
> >   - /sys/devices/system/memtier/possible
> > 
> >     Format: ordered list of "memtier(rank)"
> >     Example: 0(64), 1(128), 2(192)
> > 
> >     Read-only.  When read, list all available memory tiers and their
> >     associated ranks, ordered by the rank values (from the highest
> >      tier to the lowest tier).
> 
> I like the idea of "possible" file.  And I think we can show default
> tier too.  That is, if "1(128)" is the default tier (tier with DRAM),
> then the list can be,
> 
> "
> 0/64 [1/128] 2/192
> "
> 
> To make it more easier to be parsed by shell, I will prefer something
> like,
> 
> "
> 0	64
> 1	128	default
> 2	192
> "
> 
> But one line format is OK for me too.
> 
I wonder if there's a good argument to have this "possible" file at all?
My thinking is that, 1) all the details can be scripted at
user-level by reading memtierN/nodeN, offloading some work from the
kernel side, and 2) the format/numbers are confusing anyway; it could
get tricky when/if tier device IDs are similar to ranks.

The other thing is whether we should have a file called "default"
containing the default tier value for the user to read?

> > 
> > * /sys/devices/system/memtier/memtierN/
> > 
> >   This is the directory containing the information about a
> > particular memory tier, memtierN, where N is the memtier device ID
> > (e.g. 0, 1).
> > 
> >   The memtier device ID number itself is just an identifier and has
> > no special meaning, i.e. memtier device ID numbers do not determine
> > the order of memory tiers.
> > 
> >   - /sys/devices/system/memtier/memtierN/rank
> > 
> >     Format: int
> >     Example: 100
> > 
> >     Read-only.  When read, list the "rank" value associated with
> > memtierN.
> > 
> >     "Rank" is an opaque value. Its absolute value doesn't have any
> >     special meaning. But the rank values of different memtiers can
> > be compared with each other to determine the memory tier order.
> >     For example, if we have 3 memtiers: memtier0, memtier1,
> > memiter2, and their rank values are 10, 20, 15, then the memory
> > tier order is: memtier0 -> memtier2 -> memtier1, where memtier0 is
> > the highest tier and memtier1 is the lowest tier.
> > 
> >     The rank value of each memtier should be unique.
> > 
> >   - /sys/devices/system/memtier/memtierN/nodelist
> > 
> >     Format: node_list
> >     Example: 1-2
> > 
> >     Read-only.  When read, list the memory nodes in the specified
> > tier.
> > 
> >     If a memory tier has no memory nodes, the kernel can hide the
> > sysfs directory of this memory tier, though the tier itself can
> > still be visible from /sys/devices/system/memtier/possible.
> > 
Is there a good reason why the kernel needs to hide this directory?

> > * /sys/devices/system/node/nodeN/memtier
> > 
> >   where N = 0, 1, ...
> > 
> >   Format: int or empty
> >   Example: 1
> > 
> >   When read, list the device ID of the memory tier that the node
> > belongs to.  Its value is empty for a CPU-only NUMA node.
> > 
> >   When written, the kernel moves the node into the specified memory
> >   tier if the move is allowed.  The tier assignment of all other
> > nodes are not affected.
> > 
Who decides if the move is allowed or not? Might need to explicitly
mention that?

> >   Initially, we can make this interface read-only.
> > 
> > 
> > Kernel Representation
> > =====================
> > 
> > * All memory tiering code is guarded by CONFIG_TIERED_MEMORY.
> > 
> > * #define MAX_MEMORY_TIERS  3
> > 
> >   Support 3 memory tiers for now.  This can be a kconfig option.
> > 
> > * #define MEMORY_DEFAULT_TIER_DEVICE 1
> > 
> >   The default tier device that a memory node is assigned to.
> > 
> > * struct memtier_dev {
> >       nodemask_t nodelist;
> >       int rank;
> >       int tier;
> >   } memtier_devices[MAX_MEMORY_TIERS]
> > 
> >   Store memory tiers by device IDs.
> > 
> > * struct memtier_dev *memory_tier(int tier)
> > 
> >   Returns the memtier device for a given memory tier.
> > 
Might need to define the case where there's no memory tier device for a
specific tier number. For example, we can return NULL or an error code
when an invalid tier number is passed (e.g., -1 for CPU-only nodes).

> > * int node_tier_dev_map[MAX_NUMNODES]
> > 
> >   Map a node to its tier device ID..
> > 
> >   For each CPU-only node c, node_tier_dev_map[c] = -1.
> > 
> > 
> > Memory Tier Initialization
> > ==========================
> > 
> > By default, all memory nodes are assigned to the default tier
> > (MEMORY_DEFAULT_TIER_DEVICE).  The default tier device has a rank
> > value in the middle of the possible rank value range (e.g. 127 if
> > the range is [0..255]).
> > 
> > A device driver can move up or down its memory nodes from the
> > default tier.  For example, PMEM can move down its memory nodes
> > below the default tier, whereas GPU can move up its memory nodes
> > above the default tier.
> > 
Is "up/down" here still relative after the rank addition?

> > The kernel initialization code makes the decision on which exact
> > tier a memory node should be assigned to based on the requests from
> > the device drivers as well as the memory device hardware information
> > provided by the firmware.
> > 
> > 
> > Memory Tier Reassignment
> > ========================
> > 
> > After a memory node is hot-removed, it can be hot-added back to a
> > different memory tier.  This is useful for supporting dynamically
> > provisioned CXL.mem NUMA nodes, which may connect to different
> > memory devices across hot-plug events.  Such tier changes should
> > be compatible with tier-based memory accounting.
> > 
> > The userspace may also reassign an existing online memory node to a
> > different tier.  However, this should only be allowed when no pages
> > are allocated from the memory node or when there are no non-root
> > memory cgroups (e.g. during the system boot).  This restriction is
> > important for keeping memory tier hierarchy stable enough for
> > tier-based memory cgroup accounting.
> 
> One way to do this is hot-remove all memory of a node, change its
> memtier, then hot-add its memory.
> 
> Best Regards,
> Huang, Ying
> 
> > Hot-adding/removing CPUs doesn't affect memory tier hierarchy.
> > 
> > 
> > Memory Allocation for Demotion
> > ==============================
> > 
> > To allocate a new page as the demotion target for a page, the kernel
> > calls the allocation function (__alloc_pages_nodemask) with the
> > source page node as the preferred node and the union of all lower
> > tier nodes as the allowed nodemask.  The actual target node
> > selection then follows the allocation fallback order that the
> > kernel has already defined.
> > 
> > The pseudo code looks like:
> > 
> >     targets = NODE_MASK_NONE;
> >     src_nid = page_to_nid(page);
> >     src_tier = memtier_devices[node_tier_dev_map[src_nid]].tier;
> >     for (i = src_tier + 1; i < MAX_MEMORY_TIERS; i++)
> >             nodes_or(targets, targets, memory_tier(i)->nodelist);
> >     new_page = __alloc_pages_nodemask(gfp, order, src_nid, targets);
> > 
> > The memopolicy of cpuset, vma and owner task of the source page can
> > be set to refine the demotion target nodemask, e.g. to prevent
> > demotion or select a particular allowed node as the demotion target.
> > 
> > 
> > Memory Allocation for Promotion
> > ===============================
> > 
> > The page allocation for promotion is similar to demotion, except
> > that (1) the target nodemask uses the promotion tiers, (2) the
> > preferred node can be the accessing CPU node, not the source page
> > node.
> > 
> > 
> > Examples
> > ========
> > 
> > * Example 1:
> > 
> > Node 0 & 1 are DRAM nodes, node 2 & 3 are PMEM nodes.
> > 
> >                   20
> >   Node 0 (DRAM)  ----  Node 1 (DRAM)
> >        |        \   /       |
> >        | 30    40 X 40      | 30
> >        |        /   \       |
> >   Node 2 (PMEM)  ----  Node 3 (PMEM)
> >                   40
> > 
> > node distances:
> > node   0    1    2    3
> >    0  10   20   30   40
> >    1  20   10   40   30
> >    2  30   40   10   40
> >    3  40   30   40   10
> > 
> > $ cat /sys/devices/system/memtier/possible
> > 0(64), 1(128), 2(192)
> > 
> > $ grep '' /sys/devices/system/memtier/memtier*/rank
> > /sys/devices/system/memtier/memtier1/rank:128
> > /sys/devices/system/memtier/memtier2/rank:192
> > 
> > $ grep '' /sys/devices/system/memtier/memtier*/nodelist
> > /sys/devices/system/memtier/memtier1/nodelist:0-1
> > /sys/devices/system/memtier/memtier2/nodelist:2-3
> > 
> > $ grep '' /sys/devices/system/node/node*/memtier
> > /sys/devices/system/node/node0/memtier:1
> > /sys/devices/system/node/node1/memtier:1
> > /sys/devices/system/node/node2/memtier:2
> > /sys/devices/system/node/node3/memtier:2
> > 
> > Demotion fallback order:
> > node 0: 2, 3
> > node 1: 3, 2
> > node 2: empty
> > node 3: empty
> > 
> > To prevent cross-socket demotion and memory access, the user can set
> > mempolicy, e.g. cpuset.mems=0,2.
> > 
> > 
> > * Example 2:
> > 
> > Node 0 & 1 are DRAM nodes.
> > Node 2 is a PMEM node and closer to node 0.
> > 
> >                   20
> >   Node 0 (DRAM)  ----  Node 1 (DRAM)
> >        |            /
> >        | 30       / 40
> >        |        /
> >   Node 2 (PMEM)
> > 
> > node distances:
> > node   0    1    2
> >    0  10   20   30
> >    1  20   10   40
> >    2  30   40   10
> > 
> > $ cat /sys/devices/system/memtier/possible
> > 0(64), 1(128), 2(192)
> > 
> > $ grep '' /sys/devices/system/memtier/memtier*/rank
> > /sys/devices/system/memtier/memtier1/rank:128
> > /sys/devices/system/memtier/memtier2/rank:192
> > 
> > $ grep '' /sys/devices/system/memtier/memtier*/nodelist
> > /sys/devices/system/memtier/memtier1/nodelist:0-1
> > /sys/devices/system/memtier/memtier2/nodelist:2
> > 
> > $ grep '' /sys/devices/system/node/node*/memtier
> > /sys/devices/system/node/node0/memtier:1
> > /sys/devices/system/node/node1/memtier:1
> > /sys/devices/system/node/node2/memtier:2
> > 
> > Demotion fallback order:
> > node 0: 2
> > node 1: 2
> > node 2: empty
> > 
> > 
> > * Example 3:
> > 
> > Node 0 & 1 are DRAM nodes, Node 2 is a memory-only DRAM node.
> > 
np: PMEM instead of memory-only DRAM?

> > All nodes are in the same tier.
> > 
> >                   20
> >   Node 0 (DRAM)  ----  Node 1 (DRAM)
> >          \                 /
> >           \ 30            / 30
> >            \             /
> >              Node 2 (PMEM)
> > 
> > node distances:
> > node   0    1    2
> >    0  10   20   30
> >    1  20   10   30
> >    2  30   30   10
> > 
> > $ cat /sys/devices/system/memtier/possible
> > 0(64), 1(128), 2(192)
> > 
> > $ grep '' /sys/devices/system/memtier/memtier*/rank
> > /sys/devices/system/memtier/memtier1/rank:128
> > 
> > $ grep '' /sys/devices/system/memtier/memtier*/nodelist
> > /sys/devices/system/memtier/memtier1/nodelist:0-2
> > 
> > $ grep '' /sys/devices/system/node/node*/memtier
> > /sys/devices/system/node/node0/memtier:1
> > /sys/devices/system/node/node1/memtier:1
> > /sys/devices/system/node/node2/memtier:1
> > 
> > Demotion fallback order:
> > node 0: empty
> > node 1: empty
> > node 2: empty
> > 
> > 
> > * Example 4:
> > 
> > Node 0 is a DRAM node with CPU.
> > Node 1 is a PMEM node.
> > Node 2 is a GPU node.
> > 
> >                   50
> >   Node 0 (DRAM)  ----  Node 2 (GPU)
> >          \                 /
> >           \ 30            / 60
> >            \             /
> >              Node 1 (PMEM)
> > 
> > node distances:
> > node   0    1    2
> >    0  10   30   50
> >    1  30   10   60
> >    2  50   60   10
> > 
> > $ cat /sys/devices/system/memtier/possible
> > 0(64), 1(128), 2(192)
> > 
> > $ grep '' /sys/devices/system/memtier/memtier*/rank
> > /sys/devices/system/memtier/memtier0/rank:64
> > /sys/devices/system/memtier/memtier1/rank:128
> > /sys/devices/system/memtier/memtier2/rank:192
> > 
> > $ grep '' /sys/devices/system/memtier/memtier*/nodelist
> > /sys/devices/system/memtier/memtier0/nodelist:2
> > /sys/devices/system/memtier/memtier1/nodelist:0
> > /sys/devices/system/memtier/memtier2/nodelist:1
> > 
> > $ grep '' /sys/devices/system/node/node*/memtier
> > /sys/devices/system/node/node0/memtier:1
> > /sys/devices/system/node/node1/memtier:2
> > /sys/devices/system/node/node2/memtier:0
> > 
> > Demotion fallback order:
> > node 0: 1
> > node 1: empty
> > node 2: 0, 1
> > 
> > 
> > * Example 5:
> > 
> > Node 0 is a DRAM node with CPU.
> > Node 1 is a GPU node.
> > Node 2 is a PMEM node.
> > Node 3 is a large, slow DRAM node without CPU.
> > 
> >                     100
> >      Node 0 (DRAM)  ----  Node 1 (GPU)
> >     /     |               /    |
> >    /40    |30        120 /     | 110
> >   |       |             /      |
> >   |  Node 2 (PMEM) ----       /
> >   |        \                 /
> >    \     80 \               /
> >     ------- Node 3 (Slow DRAM)
> > 
> > node distances:
> > node    0    1    2    3
> >    0   10  100   30   40
> >    1  100   10  120  110
> >    2   30  120   10   80
> >    3   40  110   80   10
> > 
> > MAX_MEMORY_TIERS=4 (memtier3 is a memory tier added later).
> > 
> > $ cat /sys/devices/system/memtier/possible
> > 0(64), 1(128), 3(160), 2(192)
> > 
> > $ grep '' /sys/devices/system/memtier/memtier*/rank
> > /sys/devices/system/memtier/memtier0/rank:64
> > /sys/devices/system/memtier/memtier1/rank:128
> > /sys/devices/system/memtier/memtier2/rank:192
> > /sys/devices/system/memtier/memtier3/rank:160
> > 
> > $ grep '' /sys/devices/system/memtier/memtier*/nodelist
> > /sys/devices/system/memtier/memtier0/nodelist:1
> > /sys/devices/system/memtier/memtier1/nodelist:0
> > /sys/devices/system/memtier/memtier2/nodelist:2
> > /sys/devices/system/memtier/memtier3/nodelist:3
> > 
> > $ grep '' /sys/devices/system/node/node*/memtier
> > /sys/devices/system/node/node0/memtier:1
> > /sys/devices/system/node/node1/memtier:0
> > /sys/devices/system/node/node2/memtier:2
> > /sys/devices/system/node/node3/memtier:3
> > 
> > Demotion fallback order:
> > node 0: 2, 3
> > node 1: 0, 3, 2
> > node 2: empty
> > node 3: 2
> 
> 

