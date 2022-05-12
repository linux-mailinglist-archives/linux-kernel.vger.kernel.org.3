Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 012C7524594
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 08:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350270AbiELGWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 02:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350264AbiELGWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 02:22:25 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D330E515B4
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 23:22:22 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id z144so4132725vsz.13
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 23:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=EEe5kh9bmjogHNSPdX3NxuCv83cKTbUKeA2aaQghZCI=;
        b=Aj9tzqKdxPctZJq3Qx6T/F1PWIgfRy2VcSekFoGiUtciCdoc3akqQlKeG4eSPM+kq6
         yuk/2PR4TCe4yC9KLi8H+iuaO5zl3Q6JypIKz6JJhN/0T0dxndOTyZ1CFijGRVU+EfUQ
         WE1+BzFOGLkIZvjSPf7+M1JvweutEkSvc4lMIAR+IWTx8UJGGwa4q8e/u4aJTSTp2Slu
         /j1GJD9jA8kqyXCiUghN7v0t3+uf5Z4g30dHBgoreZk2xXAiSIEbKeTYXogDkCIPfRyi
         eL+hb8hMKxjh+aZT7THWD91II0rRJunRDdKoF6sW8b5uRQaN5dGAq7aGYUWZZs56kTMk
         CfVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=EEe5kh9bmjogHNSPdX3NxuCv83cKTbUKeA2aaQghZCI=;
        b=FpA+mEZaS8tUIWIRtEiZujdjUCW1TOBJebrCPkUx/rsR00AVfsUq8OY0jBzUJAMTS7
         HQP2W8bQy6aCGIYol3VYdDBeqtr5UguMHyVy8qzw0CoKMt3tahtKOXXQ3betm+50Fi9U
         QMCUGo1f/6P9TtMf2UU5Krb9Iazq7u23cbBCIL2cOHZuULz9BJsJ2mx6zQSDf6h8ZtEQ
         eeW4ggL7Jb2wuEKy/AnmA0OFEP3rDQPoqf344oWVtPnVlojIUKkboiUjvD1UeTWD/FO/
         0tGCQy7Wr2fmaqL6wJUKqRNvkmEYMb14TQ3kipc/LhKrdFawLaHgOMr9ti1ZwUt39P+/
         Cfag==
X-Gm-Message-State: AOAM533ZmyyVxNGdGBati9RG7gJYg0oZFvGh7ccWzNe8dJgCgh3P8sJ9
        ZtAnadfPUY5Yf9/Cvny7NRFG6oTUttuy8AL5FH6VIslXEHJPDTJf
X-Google-Smtp-Source: ABdhPJxfO3wLveXdgB5UtbzfCMlIEefwl4o7fUZR4HqM6VZEhBIZIC4IUV+BUiQUr3AFuz88B13dfdWDujkwjI6sDE0=
X-Received: by 2002:a67:f343:0:b0:32c:c4b7:e238 with SMTP id
 p3-20020a67f343000000b0032cc4b7e238mr14425535vsm.77.1652336541724; Wed, 11
 May 2022 23:22:21 -0700 (PDT)
MIME-Version: 1.0
From:   Wei Xu <weixugc@google.com>
Date:   Wed, 11 May 2022 23:22:11 -0700
Message-ID: <CAAPL-u-DGLcKRVDnChN9ZhxPkfxQvz9Sb93kVoX_4J2oiJSkUw@mail.gmail.com>
Subject: RFC: Memory Tiering Kernel Interfaces (v2)
To:     Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Thelen <gthelen@google.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Michal Hocko <mhocko@kernel.org>,
        Tim C Chen <tim.c.chen@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Alistair Popple <apopple@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Feng Tang <feng.tang@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dan Williams <dan.j.williams@intel.com>,
        David Rientjes <rientjes@google.com>,
        Linux MM <linux-mm@kvack.org>,
        Brice Goglin <brice.goglin@gmail.com>,
        Hesham Almatary <hesham.almatary@huawei.com>
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
the top tier, and builds the tier hierarchy tier-by-tier by establishing
the per-node demotion targets based on the distances between nodes.

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

* /sys/devices/system/memtier/memtierN/nodelist

  where N = 0, 1, 2 (the kernel supports only 3 tiers for now).

  Format: node_list

  Read-only.  When read, list the memory nodes in the specified tier.

  Tier 0 is the highest tier, while tier 2 is the lowest tier.

  The absolute value of a tier id number has no specific meaning.
  What matters is the relative order of the tier id numbers.

  When a memory tier has no nodes, the kernel can hide its memtier
  sysfs files.

* /sys/devices/system/node/nodeN/memtier

  where N = 0, 1, ...

  Format: int or empty

  When read, list the memory tier that the node belongs to.  Its value
  is empty for a CPU-only NUMA node.

  When written, the kernel moves the node into the specified memory
  tier if the move is allowed.  The tier assignment of all other nodes
  are not affected.

  Initially, we can make this interface read-only.


Kernel Representation
=====================

* All memory tiering code is guarded by CONFIG_TIERED_MEMORY.

* #define MAX_MEMORY_TIERS 3

  Support 3 memory tiers for now.

* #define MEMORY_DEFAULT_TIER 1

  The default tier that a memory node is assigned to.

* nodemask_t memory_tiers[MAX_MEMORY_TIERS]

  Store memory nodes by tiers.

* int node_tier_map[MAX_NUMNODES]

  Map a node to its tier.

  For each CPU-only node c, node_tier_map[c] = -1.


Memory Tier Initialization
==========================

By default, all memory nodes are assigned to the default tier
(MEMORY_DEFAULT_TIER).

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
calls the allocation function (__alloc_pages_nodemask) with the
source page node as the preferred node and the union of all lower
tier nodes as the allowed nodemask.  The actual target node selection
then follows the allocation fallback order that the kernel has
already defined.

The pseudo code looks like:

    targets = NODE_MASK_NONE;
    src_nid = page_to_nid(page);
    src_tier = node_tier_map[src_nid];
    for (i = src_tier + 1; i < MAX_MEMORY_TIERS; i++)
            nodes_or(targets, targets, memory_tiers[i]);
    new_page = __alloc_pages_nodemask(gfp, order, src_nid, targets);

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

$ cat /sys/devices/system/memtier/memtier*/nodelist
<empty>
0-1
2-3

$ cat /sys/devices/system/node/node*/memtier
1
1
2
2

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

$ cat /sys/devices/system/memtier/memtier*/nodelist
<empty>
0-1
2

$ cat /sys/devices/system/node/node*/memtier
1
1
2

Demotion fallback order:
node 0: 2
node 1: 2
node 2: empty


* Example 3:

Node 0 & 1 are DRAM nodes, Node 2 is a memory-only DRAM node.

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

$ cat /sys/devices/system/memtier/memtier*/nodelist
<empty>
0-2
<empty>

$ cat /sys/devices/system/node/node*/memtier
1
1
1

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

$ cat /sys/devices/system/memtier/memtier*/nodelist
2
0
1

$ cat /sys/devices/system/node/node*/memtier
1
2
0

Demotion fallback order:
node 0: 1
node 1: empty
node 2: 0, 1


* Example 5:

Node 0 is a DRAM node with CPU.
Node 1 is a GPU node.
Node 2 is a PMEM node.
Node 3 is a large, slow DRAM node without CPU.


     Node 2 (PMEM)  ----
   /      |              \
  /       | 30            \ 120
 |        |         100    \
 |   Node 0 (DRAM)  ----  Node 1 (GPU)
  \         \                 /
    \        \ 40            / 110
  80  \       \             /
        ---  Node 3 (Slow DRAM)

node distances:
node    0    1    2    3
   0   10  100   30   40
   1  100   10  120  110
   2   30  120   10   80
   3   40  110   80   10

$ cat /sys/devices/system/memtier/memtier*/nodelist
1
0,3
2

$ cat /sys/devices/system/node/node*/memtier
1
0
2
1

Demotion fallback order:
node 0: 2
node 1: 0, 3, 2
node 2: empty
node 3: 2
