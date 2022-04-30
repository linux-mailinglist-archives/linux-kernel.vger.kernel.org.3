Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 667A55159C3
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 04:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355411AbiD3COT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 22:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240220AbiD3COR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 22:14:17 -0400
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55987D17F7
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 19:10:57 -0700 (PDT)
Received: by mail-vk1-xa35.google.com with SMTP id q136so4502267vke.10
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 19:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=niB8HkuoqiT56uikZtBpshfk5BjQ9RlAZ15YvCwaKPU=;
        b=MxXPnY8/L9n7R3r8Ww76pyWJm18WqMoEm+Nyg69g4bGkJRx6F9qbW/Ii6NVvSRzr0f
         rqosnjYbBLBSKItoxiIF8L7lHxfCMycbD5bPhMEZwEtJfdA/CKtx74BR9pYClU/dMISD
         wT05plVTvUS74cqejezPuRJpI2M3nV0N9CgridMNdnqa3kufekE9T1bhZ08jby0X9uQl
         Ucjkhr5FabUAi8RW/++wgCFquiZQEYAKuvnnFjssnK5LlZqCFPwQM69vYQryAuV2xoDa
         AupkynMRKDijjKHuQ5M1hqln9HVukGAFL2tKowQw5H+eEsbPfe9f2dQcZyTw7d8Qp/F6
         H6SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=niB8HkuoqiT56uikZtBpshfk5BjQ9RlAZ15YvCwaKPU=;
        b=0o3rzkoKy36Kuzic1A7vlKFNLduNqmvG2QF/4x3u56oq73lPj9N0HXR/CNGe9m1i+C
         myex3QtpzET+x5LMa7yf+uvbvgOwkbXokJ3ZQH8ahAse1t9rVfuHrAF99kBan94WSrH5
         F6SbpmOJ0RfPF6jKnLU3YZ9W/W3ivyB2b0iks2w0bk/6Cb9mgXfonqzMLocfyd0sWVfM
         sAk9mAKRkfe8TUu/04ipSk+bFIc8btJq6xiazN5UXH6f6VmiezUUy/kWjs48DXL2caER
         wbiIiNR3EssM90r6d5UUj6TvZFO3RmxnXrds1nHYovbWZiod58wd7M/JcEr1+yW5tPi2
         V3fA==
X-Gm-Message-State: AOAM531sFLCux1PrvWdrvIvHZB/d53YrkspL9JBTwANHF6BsZO/ZNsJu
        +mKfEvH8SxlapxU8KlJoQj23GpkrbxS1Sx34V7i7VQ==
X-Google-Smtp-Source: ABdhPJwkWN3PvMc0i2F/7LvxJJ6RvuMGZjJXQEsfxVyItKvDQP1oFtKBxNoZg5QxQ0HdQ0C7FF0Tz/fLzlmx/H8Uo8M=
X-Received: by 2002:ac5:c3d0:0:b0:344:44f4:25c3 with SMTP id
 t16-20020ac5c3d0000000b0034444f425c3mr608834vkk.23.1651284656107; Fri, 29 Apr
 2022 19:10:56 -0700 (PDT)
MIME-Version: 1.0
From:   Wei Xu <weixugc@google.com>
Date:   Fri, 29 Apr 2022 19:10:45 -0700
Message-ID: <CAAPL-u9sVx94ACSuCVN8V0tKp+AMxiY89cro0japtyB=xNfNBw@mail.gmail.com>
Subject: RFC: Memory Tiering Kernel Interfaces
To:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Huang Ying <ying.huang@intel.com>,
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
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

A tiering relationship between NUMA nodes in the form of demotion path
is created during the kernel initialization and updated when a NUMA
node is hot-added or hot-removed.  The current implementation puts all
nodes with CPU into the top tier, and then builds the tiering hierarchy
tier-by-tier by establishing the per-node demotion targets based on
the distances between nodes.

The current memory tiering interface needs to be improved to address
several important use cases:

* The current tiering initialization code always initializes
  each memory-only NUMA node into a lower tier.  But a memory-only
  NUMA node may have a high performance memory device (e.g. a DRAM
  device attached via CXL.mem or a DRAM-backed memory-only node on
  a virtual machine) and should be put into the top tier.

* The current tiering hierarchy always puts CPU nodes into the top
  tier. But on a system with HBM (e.g. GPU memory) devices, these
  memory-only HBM NUMA nodes should be in the top tier, and DRAM nodes
  with CPUs are better to be placed into the next lower tier.

* Also because the current tiering hierarchy always puts CPU nodes
  into the top tier, when a CPU is hot-added (or hot-removed) and
  triggers a memory node from CPU-less into a CPU node (or vice
  versa), the memory tiering hierarchy gets changed, even though no
  memory node is added or removed.  This can make the tiering
  hierarchy much less stable.

* A higher tier node can only be demoted to selected nodes on the
  next lower tier, not any other node from the next lower tier.  This
  strict, hard-coded demotion order does not work in all use cases
  (e.g. some use cases may want to allow cross-socket demotion to
  another node in the same demotion tier as a fallback when the
  preferred demotion node is out of space), and has resulted in the
  feature request for an interface to override the system-wide,
  per-node demotion order from the userspace.

* There are no interfaces for the userspace to learn about the memory
  tiering hierarchy in order to optimize its memory allocations.

I'd like to propose revised memory tiering kernel interfaces based on
the discussions in the threads:

- https://lore.kernel.org/lkml/20220425201728.5kzm4seu7rep7ndr@offworld/T/
- https://lore.kernel.org/linux-mm/20220426114300.00003ad8@Huawei.com/t/


Sysfs Interfaces
================

* /sys/devices/system/node/memory_tiers

  Format: node list (one tier per line, in the tier order)

  When read, list memory nodes by tiers.

  When written (one tier per line), take the user-provided node-tier
  assignment as the new tiering hierarchy and rebuild the per-node
  demotion order.  It is allowed to only override the top tiers, in
  which cases, the kernel will establish the lower tiers automatically.


Kernel Representation
=====================

* nodemask_t node_states[N_TOPTIER_MEMORY]

  Store all top-tier memory nodes.

* nodemask_t memory_tiers[MAX_TIERS]

  Store memory nodes by tiers.

* struct demotion_nodes node_demotion[]

  where: struct demotion_nodes { nodemask_t preferred; nodemask_t allowed; }

  For a node N:

  node_demotion[N].preferred lists all preferred demotion targets;

  node_demotion[N].allowed lists all allowed demotion targets
  (initialized to be all the nodes in the same demotion tier).


Tiering Hierarchy Initialization
================================

By default, all memory nodes are in the top tier (N_TOPTIER_MEMORY).

A device driver can remove its memory nodes from the top tier, e.g.
a dax driver can remove PMEM nodes from the top tier.

The kernel builds the memory tiering hierarchy and per-node demotion
order tier-by-tier starting from N_TOPTIER_MEMORY.  For a node N, the
best distance nodes in the next lower tier are assigned to
node_demotion[N].preferred and all the nodes in the next lower tier
are assigned to node_demotion[N].allowed.

node_demotion[N].preferred can be empty if no preferred demotion node
is available for node N.

If the userspace overrides the tiers via the memory_tiers sysfs
interface, the kernel then only rebuilds the per-node demotion order
accordingly.

Memory tiering hierarchy is rebuilt upon hot-add or hot-remove of a
memory node, but is NOT rebuilt upon hot-add or hot-remove of a CPU
node.


Memory Allocation for Demotion
==============================

When allocating a new demotion target page, both a preferred node
and the allowed nodemask are provided to the allocation function.
The default kernel allocation fallback order is used to allocate the
page from the specified node and nodemask.

The memopolicy of cpuset, vma and owner task of the source page can
be set to refine the demotion nodemask, e.g. to prevent demotion or
select a particular allowed node as the demotion target.


Examples
========

* Example 1:
  Node 0 & 1 are DRAM nodes, node 2 & 3 are PMEM nodes.

  Node 0 has node 2 as the preferred demotion target and can also
  fallback demotion to node 3.

  Node 1 has node 3 as the preferred demotion target and can also
  fallback demotion to node 2.

  Set mempolicy to prevent cross-socket demotion and memory access,
  e.g. cpuset.mems=0,2

node distances:
node   0    1    2    3
   0  10   20   30   40
   1  20   10   40   30
   2  30   40   10   40
   3  40   30   40   10

/sys/devices/system/node/memory_tiers
0-1
2-3

N_TOPTIER_MEMORY: 0-1

node_demotion[]:
  0: [2], [2-3]
  1: [3], [2-3]
  2: [],  []
  3: [],  []

* Example 2:
  Node 0 & 1 are DRAM nodes.
  Node 2 is a PMEM node and closer to node 0.

  Node 0 has node 2 as the preferred and only demotion target.

  Node 1 has no preferred demotion target, but can still demote
  to node 2.

  Set mempolicy to prevent cross-socket demotion and memory access,
  e.g. cpuset.mems=0,2

node distances:
node   0    1    2
   0  10   20   30
   1  20   10   40
   2  30   40   10

/sys/devices/system/node/memory_tiers
0-1
2

N_TOPTIER_MEMORY: 0-1

node_demotion[]:
  0: [2], [2]
  1: [],  [2]
  2: [],  []


* Example 3:
  Node 0 & 1 are DRAM nodes.
  Node 2 is a PMEM node and has the same distance to node 0 & 1.

  Node 0 has node 2 as the preferred and only demotion target.

  Node 1 has node 2 as the preferred and only demotion target.

node distances:
node   0    1    2
   0  10   20   30
   1  20   10   30
   2  30   30   10

/sys/devices/system/node/memory_tiers
0-1
2

N_TOPTIER_MEMORY: 0-1

node_demotion[]:
  0: [2], [2]
  1: [2], [2]
  2: [],  []


* Example 4:
  Node 0 & 1 are DRAM nodes, Node 2 is a memory-only DRAM node.

  All nodes are top-tier.

node distances:
node   0    1    2
   0  10   20   30
   1  20   10   30
   2  30   30   10

/sys/devices/system/node/memory_tiers
0-2

N_TOPTIER_MEMORY: 0-2

node_demotion[]:
  0: [],  []
  1: [],  []
  2: [],  []


* Example 5:
  Node 0 is a DRAM node with CPU.
  Node 1 is a HBM node.
  Node 2 is a PMEM node.

  With userspace override, node 1 is the top tier and has node 0 as
  the preferred and only demotion target.

  Node 0 is in the second tier, tier 1, and has node 2 as the
  preferred and only demotion target.

  Node 2 is in the lowest tier, tier 2, and has no demotion targets.

node distances:
node   0    1    2
   0  10   21   30
   1  21   10   40
   2  30   40   10

/sys/devices/system/node/memory_tiers (userspace override)
1
0
2

N_TOPTIER_MEMORY: 1

node_demotion[]:
  0: [2], [2]
  1: [0], [0]
  2: [],  []

-- Wei
