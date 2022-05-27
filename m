Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09B125366CF
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 20:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353605AbiE0SCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 14:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbiE0SCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 14:02:50 -0400
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0268C964D
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 11:02:48 -0700 (PDT)
Received: by mail-vk1-xa31.google.com with SMTP id bj35so2340360vkb.10
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 11:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=4AkWsHH9GIlT6Mijzl5O9g1IxisxYF8qe2eMQ9dnhUs=;
        b=qqgw04RZsr9hR/CX3NxyGTgVP4pW3jhAxEQuhysEwsJRqp9EsshLSp7NNCLcQa2CB3
         ogJa9mcOOl3EKEpUDc6T78DmuSyq4/sNQFw8a7AJUYgmKpaJYhok/HqD5cg6Z9IXr2dQ
         ibqa2+UvbD2QLvzcWMPgBbA+tsQRGEmwjEYV5uX44h5Jv83UX/wGKDInn7CBBcqIfFk8
         Bp4O6sjNuTOIaJfDpXlAaCLKQHRFJcyiw/SEj/V17lBxOqkRAngC96VqGuF5Onw18Gak
         LORaJwnvQylXOCYaqObuMs0aksOzHDhNI+6vX75ch3QsFCY/klxgCrBHQGDbfpd5z9YO
         UKcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=4AkWsHH9GIlT6Mijzl5O9g1IxisxYF8qe2eMQ9dnhUs=;
        b=P6qIUJtoIp9X4lYbgTHrZlz7CQ3eH+PRDfo1/0Ykp9pLzilP0Ilx76PH9bWTQOIunb
         7JG0hu2B4PcWS3v/wCc6b4mFx+8tN9e4zxamhZsOyaV30B/6WeG419GwciJ8vZm5LpDL
         pXwJMe8ZP4Ut28WP8enA+06SPpcUoP0ty5LTt1tE+Av0ra+T6Ydy7QLzKrzjoCuMRnxV
         BLMpIKe9mXhmSujCD7++Ba+lqJBTvp2jJYA949w2/FDDhi8NPGHIZMEB5EYGt2dL7NXd
         ZnDKfZTw6+AZ+7QrlEyrAVnN/x9Zas6AyVE/3j4piKXhgh7bJdXPQIhZawCupQX+1ehA
         6ZwA==
X-Gm-Message-State: AOAM531EBNwHv0cu2MZDe7IGnvNj12KzBoUcDOUm8pU2LjmD/jU6htMY
        JQLAljQApB9MMlunDFDbiDcSDl1bi6F1F7/ofyEoYmlLVZ3inW7h
X-Google-Smtp-Source: ABdhPJwb4xtWIAKCHy39CNcY6ejhN3CnmoJiGiNbrGvokhPSsB/zqMi0IaLqDKeIrIM0aakb4lCfVSft1B/5kNmXbUI=
X-Received: by 2002:a1f:9b85:0:b0:32d:4d56:cf64 with SMTP id
 d127-20020a1f9b85000000b0032d4d56cf64mr16999685vke.31.1653674567436; Fri, 27
 May 2022 11:02:47 -0700 (PDT)
MIME-Version: 1.0
From:   Wei Xu <weixugc@google.com>
Date:   Fri, 27 May 2022 11:02:36 -0700
Message-ID: <CAAPL-u9Wv+nH1VOZTj=9p9S70Y3Qz3+63EkqncRDdHfubsrjfw@mail.gmail.com>
Subject: RFC: Memory Tiering Kernel Interfaces (v4)
To:     Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Thelen <gthelen@google.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        Feng Tang <feng.tang@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alistair Popple <apopple@nvidia.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux MM <linux-mm@kvack.org>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        David Rientjes <rientjes@google.com>,
        Tim C Chen <tim.c.chen@intel.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change History
================
* v4
  - Reverse the meaning of "rank": higher rank value means higher tier.
  - Remove "/sys/devices/system/memtier/possible".
  - Add "/sys/devices/system/memtier/default_tier".

* v3
  - Updated the design and examples to use "rank" instead of device ID
    to determine the order between memory tiers for better flexibility.

Overview
========

The current kernel has the basic memory tiering support: Inactive
pages on a higher tier NUMA node can be migrated (demoted) to a lower
tier NUMA node to make room for new allocations on the higher tier
NUMA node.  Frequently accessed pages on a lower tier NUMA node can be
migrated (promoted) to a higher tier NUMA node to improve the
performance.

In the current kernel, memory tiers are defined implicitly via a
demotion path relationship between NUMA nodes, which is created during
the kernel initialization and updated when a NUMA node is hot-added or
hot-removed.  The current implementation puts all nodes with CPU into
the top tier, and builds the tier hierarchy tier-by-tier by
establishing the per-node demotion targets based on the distances
between nodes.

This current memory tier kernel interface needs to be improved for
several important use cases:

* The current tier initialization code always initializes
  each memory-only NUMA node into a lower tier.  But a memory-only
  NUMA node may have a high performance memory device (e.g. a DRAM
  device attached via CXL.mem or a DRAM-backed memory-only node on
  a virtual machine) and should be put into a higher tier.

* The current tier hierarchy always puts CPU nodes into the top
  tier. But on a system with HBM (e.g. GPU memory) devices, these
  memory-only HBM NUMA nodes should be in the top tier, and DRAM nodes
  with CPUs are better to be placed into the next lower tier.

* Also because the current tier hierarchy always puts CPU nodes
  into the top tier, when a CPU is hot-added (or hot-removed) and
  triggers a memory node from CPU-less into a CPU node (or vice
  versa), the memory tier hierarchy gets changed, even though no
  memory node is added or removed.  This can make the tier
  hierarchy unstable and make it difficult to support tier-based
  memory accounting.

* A higher tier node can only be demoted to selected nodes on the
  next lower tier as defined by the demotion path, not any other
  node from any lower tier.  This strict, hard-coded demotion order
  does not work in all use cases (e.g. some use cases may want to
  allow cross-socket demotion to another node in the same demotion
  tier as a fallback when the preferred demotion node is out of
  space), and has resulted in the feature request for an interface to
  override the system-wide, per-node demotion order from the
  userspace.  This demotion order is also inconsistent with the page
  allocation fallback order when all the nodes in a higher tier are
  out of space: The page allocation can fall back to any node from
  any lower tier, whereas the demotion order doesn't allow that.

* There are no interfaces for the userspace to learn about the memory
  tier hierarchy in order to optimize its memory allocations.

I'd like to propose revised memory tier kernel interfaces based on
the discussions in the threads:

- https://lore.kernel.org/lkml/20220425201728.5kzm4seu7rep7ndr@offworld/T/
- https://lore.kernel.org/linux-mm/20220426114300.00003ad8@Huawei.com/t/
- https://lore.kernel.org/linux-mm/867bc216386eb6cbf54648f23e5825830f5b922e.camel@intel.com/T/
- https://lore.kernel.org/linux-mm/d6314cfe1c7898a6680bed1e7cc93b0ab93e3155.camel@intel.com/T/
- https://lore.kernel.org/linux-mm/CAAPL-u_NwJuxWe7Wfn3A1sut+QwEmoZh2QUBQKNPq4bU=NjybA@mail.gmail.com/T/

High-level Design Ideas
=======================

* Define memory tiers explicitly, not implicitly.

* Memory tiers are defined based on hardware capabilities of memory
  nodes, not their relative node distances between each other.

* The tier assignment of each node is independent from each other.
  Moving a node from one tier to another tier doesn't affect the tier
  assignment of any other node.

* The node-tier association is stable. A node can be reassigned to a
  different tier only under the specific conditions that don't block
  future tier-based memory cgroup accounting.

* A node can demote its pages to any nodes of any lower tiers. The
  demotion target node selection follows the allocation fallback order
  of the source node, which is built based on node distances.  The
  demotion targets are also restricted to only the nodes from the tiers
  lower than the source node.  We no longer need to maintain a separate
  per-node demotion order (node_demotion[]).


Sysfs Interfaces
================

* /sys/devices/system/memtier/

  This is the directory containing the information about memory tiers.

  Each memory tier has its own subdirectory.

  The order of memory tiers is determined by their rank values, not by
  their memtier device names.  A higher rank value means a higher tier.

* /sys/devices/system/memtier/default_tier

  Format: int
  Example: 1

  The default memory tier to which memory would get added via hotplug
  if the NUMA node is not part of any memory tier.

* /sys/devices/system/memtier/memtierN/

  This is the directory containing the information about a particular
  memory tier, memtierN, where N is the memtier device ID (e.g. 0, 1).

  The memtier device ID number itself is just an identifier and has no
  special meaning, i.e. memtier device ID numbers do not determine the
  order of memory tiers.

  - /sys/devices/system/memtier/memtierN/rank

    Format: int
    Example: 100

    Read-only.  When read, list the "rank" value associated with memtierN.

    "Rank" is an opaque value. Its absolute value doesn't have any
    special meaning. But the rank values of different memtiers can be
    compared with each other to determine the memory tier order.

    For example, if we have 3 memtiers: memtier0, memtier1, memiter2, and
    their rank values are 100, 10, 50, then the memory tier order is:
    memtier0 -> memtier2 -> memtier1, where memtier0 is the highest tier
    and memtier1 is the lowest tier.

    The rank value of each memtier should be unique.

  - /sys/devices/system/memtier/memtierN/nodelist

    Format: node_list
    Example: 1-2

    Read-only.  When read, list the memory nodes in the specified tier.

* /sys/devices/system/node/nodeN/memtier

  where N = 0, 1, ...

  Format: int or empty
  Example: 1

  When read, list the device ID of the memory tier that the node belongs
  to.  Its value is empty for a CPU-only NUMA node.

  When written, the kernel moves the node into the specified memory
  tier if the move is allowed ("Memory Tier Reassignment" discusses the
  conditions required for the moves).  The tier assignments of all other
  nodes are not affected.

  Initially, we can make this interface read-only.


Memory Tier Kernel Representation
=================================

* All memory tiering code is guarded by CONFIG_TIERED_MEMORY.

* #define MAX_MEMORY_TIERS  3

  Support 3 memory tiers for now.  This can be a kconfig option.

* #define MEMORY_DEFAULT_TIER_DEVICE 1

  The default tier device that a memory node is assigned to.

* struct memtier_dev {
      nodemask_t nodelist;
      int rank;
      int tier;
  } memtier_devices[MAX_MEMORY_TIERS]

  Store memory tiers by device IDs.

* struct memtier_dev *memory_tier(int tier)

  Returns the memtier device for a given memory tier, or NULL if the
  tier is invalid.

* struct memtier_dev *node_to_memory_tier(int nid)

  Return the memtier device for a given NUMA node, or NULL if the node
  has no memory tier assigned (e.g. a CPU-only NUMA node).


Memory Tier Initialization
==========================

By default, all memory nodes are assigned to the default tier
(MEMORY_DEFAULT_TIER_DEVICE).  The default tier device has a rank value
in the middle of the possible rank value range (e.g. 127 if the range
is [0..255]).

A device driver can move up or down its memory nodes from the default
tier.  For example, PMEM can move down its memory nodes below the
default tier, whereas GPU can move up its memory nodes above the
default tier.

The kernel initialization code makes the decision on which exact tier
a memory node should be assigned to based on the requests from the
device drivers as well as the memory device hardware information
provided by the firmware.


Memory Tier Reassignment
========================

After a memory node is hot-removed, it can be hot-added back to a
different memory tier.  This is useful for supporting dynamically
provisioned CXL.mem NUMA nodes, which may connect to different
memory devices across hot-plug events.  Such tier changes should
be compatible with tier-based memory accounting.

The userspace may also reassign an existing online memory node to a
different tier.  However, this should only be allowed when no pages
are allocated from the memory node or when there are no non-root
memory cgroups (e.g. during the system boot).  This restriction is
important for keeping memory tier hierarchy stable enough for
tier-based memory cgroup accounting.

Hot-adding/removing CPUs doesn't affect memory tier hierarchy.


Memory Allocation for Demotion
==============================

To allocate a new page as the demotion target for a page, the kernel
calls the allocation function (__alloc_pages) with the source page
node as the preferred node and the union of all lower tier nodes as
the allowed nodemask.  The actual target node selection then follows
the allocation fallback order that the kernel has already defined.

The pseudo code looks like:

    targets = NODE_MASK_NONE;
    src_nid = page_to_nid(page);
    src_tier = node_to_memory_tier(src_nid)->tier;
    for (i = src_tier + 1; i < MAX_MEMORY_TIERS; i++)
            nodes_or(targets, targets, memory_tier(i)->nodelist);
    new_page = __alloc_pages(gfp, order, src_nid, targets);

The memopolicy of cpuset, vma and owner task of the source page can
be set to refine the demotion target nodemask, e.g. to prevent
demotion or select a particular allowed node as the demotion target.


Memory Allocation for Promotion
===============================

The page allocation for promotion is similar to demotion, except that (1)
the target nodemask uses the promotion tiers, (2) the preferred node can
be the accessing CPU node, not the source page node.


Examples
========

* Example 1:

Node 0 & 1 are DRAM nodes, node 2 & 3 are PMEM nodes.

                  20
  Node 0 (DRAM)  ----  Node 1 (DRAM)
       |        \   /       |
       | 30    40 X 40      | 30
       |        /   \       |
  Node 2 (PMEM)  ----  Node 3 (PMEM)
                  40

node distances:
node   0    1    2    3
   0  10   20   30   40
   1  20   10   40   30
   2  30   40   10   40
   3  40   30   40   10

$ cat /sys/devices/system/memtier/default_tier
1

$ grep '' /sys/devices/system/memtier/memtier*/rank
/sys/devices/system/memtier/memtier0/rank:192
/sys/devices/system/memtier/memtier1/rank:128
/sys/devices/system/memtier/memtier2/rank:64

$ grep '' /sys/devices/system/memtier/memtier*/nodelist
/sys/devices/system/memtier/memtier0/nodelist:
/sys/devices/system/memtier/memtier1/nodelist:0-1
/sys/devices/system/memtier/memtier2/nodelist:2-3

$ grep '' /sys/devices/system/node/node*/memtier
/sys/devices/system/node/node0/memtier:1
/sys/devices/system/node/node1/memtier:1
/sys/devices/system/node/node2/memtier:2
/sys/devices/system/node/node3/memtier:2

Demotion fallback order:
node 0: 2, 3
node 1: 3, 2
node 2: empty
node 3: empty

To prevent cross-socket demotion and memory access, the user can set
mempolicy, e.g. cpuset.mems=0,2.


* Example 2:

Node 0 & 1 are DRAM nodes.
Node 2 is a PMEM node and closer to node 0.

                  20
  Node 0 (DRAM)  ----  Node 1 (DRAM)
       |            /
       | 30       / 40
       |        /
  Node 2 (PMEM)

node distances:
node   0    1    2
   0  10   20   30
   1  20   10   40
   2  30   40   10

$ cat /sys/devices/system/memtier/default_tier
1

$ grep '' /sys/devices/system/memtier/memtier*/rank
/sys/devices/system/memtier/memtier0/rank:192
/sys/devices/system/memtier/memtier1/rank:128
/sys/devices/system/memtier/memtier2/rank:64

$ grep '' /sys/devices/system/memtier/memtier*/nodelist
/sys/devices/system/memtier/memtier0/nodelist:
/sys/devices/system/memtier/memtier1/nodelist:0-1
/sys/devices/system/memtier/memtier2/nodelist:2

$ grep '' /sys/devices/system/node/node*/memtier
/sys/devices/system/node/node0/memtier:1
/sys/devices/system/node/node1/memtier:1
/sys/devices/system/node/node2/memtier:2

Demotion fallback order:
node 0: 2
node 1: 2
node 2: empty


* Example 3:

Node 0 & 1 are DRAM nodes, Node 2 is a memory-only PMEM node.

All nodes are in the same tier.

                  20
  Node 0 (DRAM)  ----  Node 1 (DRAM)
         \                 /
          \ 30            / 30
           \             /
             Node 2 (PMEM)

node distances:
node   0    1    2
   0  10   20   30
   1  20   10   30
   2  30   30   10

$ cat /sys/devices/system/memtier/default_tier
1

$ grep '' /sys/devices/system/memtier/memtier*/rank
/sys/devices/system/memtier/memtier0/rank:192
/sys/devices/system/memtier/memtier1/rank:128
/sys/devices/system/memtier/memtier2/rank:64

$ grep '' /sys/devices/system/memtier/memtier*/nodelist
/sys/devices/system/memtier/memtier0/nodelist:
/sys/devices/system/memtier/memtier1/nodelist:0-2
/sys/devices/system/memtier/memtier2/nodelist:

$ grep '' /sys/devices/system/node/node*/memtier
/sys/devices/system/node/node0/memtier:1
/sys/devices/system/node/node1/memtier:1
/sys/devices/system/node/node2/memtier:1

Demotion fallback order:
node 0: empty
node 1: empty
node 2: empty


* Example 4:

Node 0 is a DRAM node with CPU.
Node 1 is a PMEM node.
Node 2 is a GPU node.

                  50
  Node 0 (DRAM)  ----  Node 2 (GPU)
         \                 /
          \ 30            / 60
           \             /
             Node 1 (PMEM)

node distances:
node   0    1    2
   0  10   30   50
   1  30   10   60
   2  50   60   10

$ cat /sys/devices/system/memtier/default_tier
1

$ grep '' /sys/devices/system/memtier/memtier*/rank
/sys/devices/system/memtier/memtier0/rank:192
/sys/devices/system/memtier/memtier1/rank:128
/sys/devices/system/memtier/memtier2/rank:64

$ grep '' /sys/devices/system/memtier/memtier*/nodelist
/sys/devices/system/memtier/memtier0/nodelist:2
/sys/devices/system/memtier/memtier1/nodelist:0
/sys/devices/system/memtier/memtier2/nodelist:1

$ grep '' /sys/devices/system/node/node*/memtier
/sys/devices/system/node/node0/memtier:1
/sys/devices/system/node/node1/memtier:2
/sys/devices/system/node/node2/memtier:0

Demotion fallback order:
node 0: 1
node 1: empty
node 2: 0, 1


* Example 5:

Node 0 is a DRAM node with CPU.
Node 1 is a GPU node.
Node 2 is a PMEM node.
Node 3 is a large, slow DRAM node without CPU.

                    100
     Node 0 (DRAM)  ----  Node 1 (GPU)
    /     |               /    |
   /40    |30        120 /     | 110
  |       |             /      |
  |  Node 2 (PMEM) ----       /
  |        \                 /
   \     80 \               /
    ------- Node 3 (Slow DRAM)

node distances:
node    0    1    2    3
   0   10  100   30   40
   1  100   10  120  110
   2   30  120   10   80
   3   40  110   80   10

MAX_MEMORY_TIERS=4 (memtier3 is a memory tier added later).

$ cat /sys/devices/system/memtier/default_tier
1

$ grep '' /sys/devices/system/memtier/memtier*/rank
/sys/devices/system/memtier/memtier0/rank:192
/sys/devices/system/memtier/memtier1/rank:128
/sys/devices/system/memtier/memtier2/rank:64
/sys/devices/system/memtier/memtier3/rank:96

$ grep '' /sys/devices/system/memtier/memtier*/nodelist
/sys/devices/system/memtier/memtier0/nodelist:1
/sys/devices/system/memtier/memtier1/nodelist:0
/sys/devices/system/memtier/memtier2/nodelist:2
/sys/devices/system/memtier/memtier3/nodelist:3

$ grep '' /sys/devices/system/node/node*/memtier
/sys/devices/system/node/node0/memtier:1
/sys/devices/system/node/node1/memtier:0
/sys/devices/system/node/node2/memtier:2
/sys/devices/system/node/node3/memtier:3

Demotion fallback order:
node 0: 2, 3
node 1: 0, 3, 2
node 2: empty
node 3: 2
