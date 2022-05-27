Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1B795365EF
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 18:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353867AbiE0QZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 12:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232903AbiE0QZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 12:25:22 -0400
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C980A53E01
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 09:25:20 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id m203so2230311vke.13
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 09:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xk3GE9mKVJ+FTazqYgiXCOtksLH6UilEeScKUMAEg1o=;
        b=eAPRCuY7auUMLd/tu5367LqEsEabFWRdFGohJb7nCDKFq0XObUsP6l61vpyzFCSIl0
         jGgkMYQ/XNFdE2mhmiKNO6KvB/lxNzVI71U+XzFUssr9nK1+uVhgJ/fwzhmNnBSuwRSj
         n6ZKBIV4W/uJ8A9vHS5lmGdMIdAFET4Ou9u7EJ5SZwKPBUJ3rWCGQqSaFF1ZteozhJD0
         iI50Bf/38T+hiflPosjKcAcm+ps57WUrBGZ3pdXAl0FbfHMc0HTI/ya2lBCsAfrYmGeM
         8OXZJyiSUoYXNzeUCUf+nbBdtjV3BDSByySHnZscjs4o3+i/7pxwGZcb/Mj909z9PDOq
         3cDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xk3GE9mKVJ+FTazqYgiXCOtksLH6UilEeScKUMAEg1o=;
        b=ASvNols+USPkbRDTAXlQ8WRw+hfrN/ARijPacFvUfgnPcueOgCINwE+OjdsoIuERbm
         HLPyaYUJRG4JLJVe25DuyEuc/RFDHzHnx1mLUwLWNtxp6aeWCEsSbfckxK47rBU6uCr/
         dMMInXL9NVodZrMf2V2eTgC1jd34YT6Ie+cySWA5kTUiN0HabgNpDoupyIclOY7AnPR5
         92wdBd0VZs+SzyYU290JYJV3uOXeu7tjlAVcOOPtJZW1ydWOZGf9KEujNGgbDS6DnnW6
         juuAkS/1iZGwtx1UXvXpi4Ae3Ax2nUGFLIVpOUWAJbkJs/N2xJvfERTi4ulLnZFzo9Lj
         omVg==
X-Gm-Message-State: AOAM532vBk2FoUFVntpYf4xTEWY8/mfY6C/aou04NM2A8zxeWluVo0vr
        2ZcxX1lRIesc9QuG3qKvhgCnrd5oulYrkGkQqBEtgQ==
X-Google-Smtp-Source: ABdhPJxyEfLqdRDAaio66W1XD5VcV5Cw0vKONkTtpoZSJc8xa5fzwnLROapssfoesr/sWGXFAYsaJKBWglnhN7TBWro=
X-Received: by 2002:a05:6122:2229:b0:32d:1642:b58b with SMTP id
 bb41-20020a056122222900b0032d1642b58bmr16231808vkb.27.1653668719589; Fri, 27
 May 2022 09:25:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAAPL-u-dFp7PwPH6DfbYdnY8xaGsHz3tRQ0CPGVkiqURvdN8=A@mail.gmail.com>
 <a612bf4ff68c2f6a33f01eb06cc97100a0036332.camel@intel.com> <20220527150524.00000871@huawei.com>
In-Reply-To: <20220527150524.00000871@huawei.com>
From:   Wei Xu <weixugc@google.com>
Date:   Fri, 27 May 2022 09:25:08 -0700
Message-ID: <CAAPL-u_drb_vjjre3Eh9ATZnvLBbQWEjL-M+97UTBKZH3Ff9Uw@mail.gmail.com>
Subject: Re: RFC: Memory Tiering Kernel Interfaces (v3)
To:     Hesham Almatary <hesham.almatary@huawei.com>
Cc:     Ying Huang <ying.huang@intel.com>,
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
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Feng Tang <feng.tang@intel.com>, Linux MM <linux-mm@kvack.org>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        David Rientjes <rientjes@google.com>, linuxarm@huawei.com
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

On Fri, May 27, 2022 at 7:05 AM Hesham Almatary
<hesham.almatary@huawei.com> wrote:
>
> Hello Wei and Ying,
>
> Please find my comments below based on a discussion with Jonathan.
>
> On Fri, 27 May 2022 10:58:39 +0800
> Ying Huang <ying.huang@intel.com> wrote:
>
> > On Thu, 2022-05-26 at 14:22 -0700, Wei Xu wrote:
> > > Changes since v2
> > > ================
> > > * Updated the design and examples to use "rank" instead of device ID
> > >   to determine the order between memory tiers for better
> > > flexibility.
> > >
> > > Overview
> > > ========
> > >
> > > The current kernel has the basic memory tiering support: Inactive
> > > pages on a higher tier NUMA node can be migrated (demoted) to a
> > > lower tier NUMA node to make room for new allocations on the higher
> > > tier NUMA node.  Frequently accessed pages on a lower tier NUMA
> > > node can be migrated (promoted) to a higher tier NUMA node to
> > > improve the performance.
> > >
> > > In the current kernel, memory tiers are defined implicitly via a
> > > demotion path relationship between NUMA nodes, which is created
> > > during the kernel initialization and updated when a NUMA node is
> > > hot-added or hot-removed.  The current implementation puts all
> > > nodes with CPU into the top tier, and builds the tier hierarchy
> > > tier-by-tier by establishing the per-node demotion targets based on
> > > the distances between nodes.
> > >
> > > This current memory tier kernel interface needs to be improved for
> > > several important use cases:
> > >
> > > * The current tier initialization code always initializes
> > >   each memory-only NUMA node into a lower tier.  But a memory-only
> > >   NUMA node may have a high performance memory device (e.g. a DRAM
> > >   device attached via CXL.mem or a DRAM-backed memory-only node on
> > >   a virtual machine) and should be put into a higher tier.
> > >
> > > * The current tier hierarchy always puts CPU nodes into the top
> > >   tier. But on a system with HBM (e.g. GPU memory) devices, these
> > >   memory-only HBM NUMA nodes should be in the top tier, and DRAM
> > > nodes with CPUs are better to be placed into the next lower tier.
> > >
> > > * Also because the current tier hierarchy always puts CPU nodes
> > >   into the top tier, when a CPU is hot-added (or hot-removed) and
> > >   triggers a memory node from CPU-less into a CPU node (or vice
> > >   versa), the memory tier hierarchy gets changed, even though no
> > >   memory node is added or removed.  This can make the tier
> > >   hierarchy unstable and make it difficult to support tier-based
> > >   memory accounting.
> > >
> > > * A higher tier node can only be demoted to selected nodes on the
> > >   next lower tier as defined by the demotion path, not any other
> > >   node from any lower tier.  This strict, hard-coded demotion order
> > >   does not work in all use cases (e.g. some use cases may want to
> > >   allow cross-socket demotion to another node in the same demotion
> > >   tier as a fallback when the preferred demotion node is out of
> > >   space), and has resulted in the feature request for an interface
> > > to override the system-wide, per-node demotion order from the
> > >   userspace.  This demotion order is also inconsistent with the page
> > >   allocation fallback order when all the nodes in a higher tier are
> > >   out of space: The page allocation can fall back to any node from
> > >   any lower tier, whereas the demotion order doesn't allow that.
> > >
> > > * There are no interfaces for the userspace to learn about the
> > > memory tier hierarchy in order to optimize its memory allocations.
> > >
> > > I'd like to propose revised memory tier kernel interfaces based on
> > > the discussions in the threads:
> > >
> > > -
> > > https://lore.kernel.org/lkml/20220425201728.5kzm4seu7rep7ndr@offworld/T/
> > > -
> > > https://lore.kernel.org/linux-mm/20220426114300.00003ad8@Huawei.com/t/
> > > -
> > > https://lore.kernel.org/linux-mm/867bc216386eb6cbf54648f23e5825830f5b922e.camel@intel.com/T/
> > > -
> > > https://lore.kernel.org/linux-mm/d6314cfe1c7898a6680bed1e7cc93b0ab93e3155.camel@intel.com/T/
> > >
> > >
> > > High-level Design Ideas
> > > =======================
> > >
> > > * Define memory tiers explicitly, not implicitly.
> > >
> > > * Memory tiers are defined based on hardware capabilities of memory
> > >   nodes, not their relative node distances between each other.
> > >
> > > * The tier assignment of each node is independent from each other.
> > >   Moving a node from one tier to another tier doesn't affect the
> > > tier assignment of any other node.
> > >
> > > * The node-tier association is stable. A node can be reassigned to a
> > >   different tier only under the specific conditions that don't block
> > >   future tier-based memory cgroup accounting.
> > >
> > > * A node can demote its pages to any nodes of any lower tiers. The
> > >   demotion target node selection follows the allocation fallback
> > > order of the source node, which is built based on node distances.
> > > The demotion targets are also restricted to only the nodes from the
> > > tiers lower than the source node.  We no longer need to maintain a
> > > separate per-node demotion order (node_demotion[]).
> > >
> > >
> > > Sysfs Interfaces
> > > ================
> > >
> > > * /sys/devices/system/memtier/
> > >
> > >   This is the directory containing the information about memory
> > > tiers.
> > >
> > >   Each memory tier has its own subdirectory.
> > >
> > >   The order of memory tiers is determined by their rank values, not
> > > by their memtier device names.
> > >
> > >   - /sys/devices/system/memtier/possible
> > >
> > >     Format: ordered list of "memtier(rank)"
> > >     Example: 0(64), 1(128), 2(192)
> > >
> > >     Read-only.  When read, list all available memory tiers and their
> > >     associated ranks, ordered by the rank values (from the highest
> > >      tier to the lowest tier).
> >
> > I like the idea of "possible" file.  And I think we can show default
> > tier too.  That is, if "1(128)" is the default tier (tier with DRAM),
> > then the list can be,
> >
> > "
> > 0/64 [1/128] 2/192
> > "
> >
> > To make it more easier to be parsed by shell, I will prefer something
> > like,
> >
> > "
> > 0     64
> > 1     128     default
> > 2     192
> > "
> >
> > But one line format is OK for me too.
> >
> I wonder if there's a good argument to have this "possible" file at all?
> My thinking is that, 1) all the details can be scripted at
> user-level by reading memtierN/nodeN, offloading some work from the
> kernel side, and 2) the format/numbers are confusing anyway; it could
> get tricky when/if tier device IDs are similar to ranks.

If we don't hide memtiers that have no nodes, we don't need this
"possible" file. I am fine either way.  Given that there should not be
too many tiers, it doesn't add much value to hide the empty tiers.  We
can go without this "possible" file.

> The other thing is whether we should have a file called "default"
> containing the default tier value for the user to read?

Sure, we can have a default_tier or default_rank file for this.

> > >
> > > * /sys/devices/system/memtier/memtierN/
> > >
> > >   This is the directory containing the information about a
> > > particular memory tier, memtierN, where N is the memtier device ID
> > > (e.g. 0, 1).
> > >
> > >   The memtier device ID number itself is just an identifier and has
> > > no special meaning, i.e. memtier device ID numbers do not determine
> > > the order of memory tiers.
> > >
> > >   - /sys/devices/system/memtier/memtierN/rank
> > >
> > >     Format: int
> > >     Example: 100
> > >
> > >     Read-only.  When read, list the "rank" value associated with
> > > memtierN.
> > >
> > >     "Rank" is an opaque value. Its absolute value doesn't have any
> > >     special meaning. But the rank values of different memtiers can
> > > be compared with each other to determine the memory tier order.
> > >     For example, if we have 3 memtiers: memtier0, memtier1,
> > > memiter2, and their rank values are 10, 20, 15, then the memory
> > > tier order is: memtier0 -> memtier2 -> memtier1, where memtier0 is
> > > the highest tier and memtier1 is the lowest tier.
> > >
> > >     The rank value of each memtier should be unique.
> > >
> > >   - /sys/devices/system/memtier/memtierN/nodelist
> > >
> > >     Format: node_list
> > >     Example: 1-2
> > >
> > >     Read-only.  When read, list the memory nodes in the specified
> > > tier.
> > >
> > >     If a memory tier has no memory nodes, the kernel can hide the
> > > sysfs directory of this memory tier, though the tier itself can
> > > still be visible from /sys/devices/system/memtier/possible.
> > >
> Is there a good reason why the kernel needs to hide this directory?

It is just to reduce the clutter of empty tiers.  Given that there
should not be too many tiers, we can revert this and always show all
tiers.

> > > * /sys/devices/system/node/nodeN/memtier
> > >
> > >   where N = 0, 1, ...
> > >
> > >   Format: int or empty
> > >   Example: 1
> > >
> > >   When read, list the device ID of the memory tier that the node
> > > belongs to.  Its value is empty for a CPU-only NUMA node.
> > >
> > >   When written, the kernel moves the node into the specified memory
> > >   tier if the move is allowed.  The tier assignment of all other
> > > nodes are not affected.
> > >
> Who decides if the move is allowed or not? Might need to explicitly
> mention that?

"memory tier reassignment" discusses the conditions when the move is allowed.

> > >   Initially, we can make this interface read-only.
> > >
> > >
> > > Kernel Representation
> > > =====================
> > >
> > > * All memory tiering code is guarded by CONFIG_TIERED_MEMORY.
> > >
> > > * #define MAX_MEMORY_TIERS  3
> > >
> > >   Support 3 memory tiers for now.  This can be a kconfig option.
> > >
> > > * #define MEMORY_DEFAULT_TIER_DEVICE 1
> > >
> > >   The default tier device that a memory node is assigned to.
> > >
> > > * struct memtier_dev {
> > >       nodemask_t nodelist;
> > >       int rank;
> > >       int tier;
> > >   } memtier_devices[MAX_MEMORY_TIERS]
> > >
> > >   Store memory tiers by device IDs.
> > >
> > > * struct memtier_dev *memory_tier(int tier)
> > >
> > >   Returns the memtier device for a given memory tier.
> > >
> Might need to define the case where there's no memory tier device for a
> specific tier number. For example, we can return NULL or an error code
> when an invalid tier number is passed (e.g., -1 for CPU-only nodes).

Sure.

> > > * int node_tier_dev_map[MAX_NUMNODES]
> > >
> > >   Map a node to its tier device ID..
> > >
> > >   For each CPU-only node c, node_tier_dev_map[c] = -1.
> > >
> > >
> > > Memory Tier Initialization
> > > ==========================
> > >
> > > By default, all memory nodes are assigned to the default tier
> > > (MEMORY_DEFAULT_TIER_DEVICE).  The default tier device has a rank
> > > value in the middle of the possible rank value range (e.g. 127 if
> > > the range is [0..255]).
> > >
> > > A device driver can move up or down its memory nodes from the
> > > default tier.  For example, PMEM can move down its memory nodes
> > > below the default tier, whereas GPU can move up its memory nodes
> > > above the default tier.
> > >
> Is "up/down" here still relative after the rank addition?

Good point. I think we should reverse the definition of rank: a higher
rank value means a higher tier, to avoid this kind of confusion.

> > > The kernel initialization code makes the decision on which exact
> > > tier a memory node should be assigned to based on the requests from
> > > the device drivers as well as the memory device hardware information
> > > provided by the firmware.
> > >
> > >
> > > Memory Tier Reassignment
> > > ========================
> > >
> > > After a memory node is hot-removed, it can be hot-added back to a
> > > different memory tier.  This is useful for supporting dynamically
> > > provisioned CXL.mem NUMA nodes, which may connect to different
> > > memory devices across hot-plug events.  Such tier changes should
> > > be compatible with tier-based memory accounting.
> > >
> > > The userspace may also reassign an existing online memory node to a
> > > different tier.  However, this should only be allowed when no pages
> > > are allocated from the memory node or when there are no non-root
> > > memory cgroups (e.g. during the system boot).  This restriction is
> > > important for keeping memory tier hierarchy stable enough for
> > > tier-based memory cgroup accounting.
> >
> > One way to do this is hot-remove all memory of a node, change its
> > memtier, then hot-add its memory.
> >
> > Best Regards,
> > Huang, Ying
> >
> > > Hot-adding/removing CPUs doesn't affect memory tier hierarchy.
> > >
> > >
> > > Memory Allocation for Demotion
> > > ==============================
> > >
> > > To allocate a new page as the demotion target for a page, the kernel
> > > calls the allocation function (__alloc_pages_nodemask) with the
> > > source page node as the preferred node and the union of all lower
> > > tier nodes as the allowed nodemask.  The actual target node
> > > selection then follows the allocation fallback order that the
> > > kernel has already defined.
> > >
> > > The pseudo code looks like:
> > >
> > >     targets = NODE_MASK_NONE;
> > >     src_nid = page_to_nid(page);
> > >     src_tier = memtier_devices[node_tier_dev_map[src_nid]].tier;
> > >     for (i = src_tier + 1; i < MAX_MEMORY_TIERS; i++)
> > >             nodes_or(targets, targets, memory_tier(i)->nodelist);
> > >     new_page = __alloc_pages_nodemask(gfp, order, src_nid, targets);
> > >
> > > The memopolicy of cpuset, vma and owner task of the source page can
> > > be set to refine the demotion target nodemask, e.g. to prevent
> > > demotion or select a particular allowed node as the demotion target.
> > >
> > >
> > > Memory Allocation for Promotion
> > > ===============================
> > >
> > > The page allocation for promotion is similar to demotion, except
> > > that (1) the target nodemask uses the promotion tiers, (2) the
> > > preferred node can be the accessing CPU node, not the source page
> > > node.
> > >
> > >
> > > Examples
> > > ========
> > >
> > > * Example 1:
> > >
> > > Node 0 & 1 are DRAM nodes, node 2 & 3 are PMEM nodes.
> > >
> > >                   20
> > >   Node 0 (DRAM)  ----  Node 1 (DRAM)
> > >        |        \   /       |
> > >        | 30    40 X 40      | 30
> > >        |        /   \       |
> > >   Node 2 (PMEM)  ----  Node 3 (PMEM)
> > >                   40
> > >
> > > node distances:
> > > node   0    1    2    3
> > >    0  10   20   30   40
> > >    1  20   10   40   30
> > >    2  30   40   10   40
> > >    3  40   30   40   10
> > >
> > > $ cat /sys/devices/system/memtier/possible
> > > 0(64), 1(128), 2(192)
> > >
> > > $ grep '' /sys/devices/system/memtier/memtier*/rank
> > > /sys/devices/system/memtier/memtier1/rank:128
> > > /sys/devices/system/memtier/memtier2/rank:192
> > >
> > > $ grep '' /sys/devices/system/memtier/memtier*/nodelist
> > > /sys/devices/system/memtier/memtier1/nodelist:0-1
> > > /sys/devices/system/memtier/memtier2/nodelist:2-3
> > >
> > > $ grep '' /sys/devices/system/node/node*/memtier
> > > /sys/devices/system/node/node0/memtier:1
> > > /sys/devices/system/node/node1/memtier:1
> > > /sys/devices/system/node/node2/memtier:2
> > > /sys/devices/system/node/node3/memtier:2
> > >
> > > Demotion fallback order:
> > > node 0: 2, 3
> > > node 1: 3, 2
> > > node 2: empty
> > > node 3: empty
> > >
> > > To prevent cross-socket demotion and memory access, the user can set
> > > mempolicy, e.g. cpuset.mems=0,2.
> > >
> > >
> > > * Example 2:
> > >
> > > Node 0 & 1 are DRAM nodes.
> > > Node 2 is a PMEM node and closer to node 0.
> > >
> > >                   20
> > >   Node 0 (DRAM)  ----  Node 1 (DRAM)
> > >        |            /
> > >        | 30       / 40
> > >        |        /
> > >   Node 2 (PMEM)
> > >
> > > node distances:
> > > node   0    1    2
> > >    0  10   20   30
> > >    1  20   10   40
> > >    2  30   40   10
> > >
> > > $ cat /sys/devices/system/memtier/possible
> > > 0(64), 1(128), 2(192)
> > >
> > > $ grep '' /sys/devices/system/memtier/memtier*/rank
> > > /sys/devices/system/memtier/memtier1/rank:128
> > > /sys/devices/system/memtier/memtier2/rank:192
> > >
> > > $ grep '' /sys/devices/system/memtier/memtier*/nodelist
> > > /sys/devices/system/memtier/memtier1/nodelist:0-1
> > > /sys/devices/system/memtier/memtier2/nodelist:2
> > >
> > > $ grep '' /sys/devices/system/node/node*/memtier
> > > /sys/devices/system/node/node0/memtier:1
> > > /sys/devices/system/node/node1/memtier:1
> > > /sys/devices/system/node/node2/memtier:2
> > >
> > > Demotion fallback order:
> > > node 0: 2
> > > node 1: 2
> > > node 2: empty
> > >
> > >
> > > * Example 3:
> > >
> > > Node 0 & 1 are DRAM nodes, Node 2 is a memory-only DRAM node.
> > >
> np: PMEM instead of memory-only DRAM?
>
> > > All nodes are in the same tier.
> > >
> > >                   20
> > >   Node 0 (DRAM)  ----  Node 1 (DRAM)
> > >          \                 /
> > >           \ 30            / 30
> > >            \             /
> > >              Node 2 (PMEM)
> > >
> > > node distances:
> > > node   0    1    2
> > >    0  10   20   30
> > >    1  20   10   30
> > >    2  30   30   10
> > >
> > > $ cat /sys/devices/system/memtier/possible
> > > 0(64), 1(128), 2(192)
> > >
> > > $ grep '' /sys/devices/system/memtier/memtier*/rank
> > > /sys/devices/system/memtier/memtier1/rank:128
> > >
> > > $ grep '' /sys/devices/system/memtier/memtier*/nodelist
> > > /sys/devices/system/memtier/memtier1/nodelist:0-2
> > >
> > > $ grep '' /sys/devices/system/node/node*/memtier
> > > /sys/devices/system/node/node0/memtier:1
> > > /sys/devices/system/node/node1/memtier:1
> > > /sys/devices/system/node/node2/memtier:1
> > >
> > > Demotion fallback order:
> > > node 0: empty
> > > node 1: empty
> > > node 2: empty
> > >
> > >
> > > * Example 4:
> > >
> > > Node 0 is a DRAM node with CPU.
> > > Node 1 is a PMEM node.
> > > Node 2 is a GPU node.
> > >
> > >                   50
> > >   Node 0 (DRAM)  ----  Node 2 (GPU)
> > >          \                 /
> > >           \ 30            / 60
> > >            \             /
> > >              Node 1 (PMEM)
> > >
> > > node distances:
> > > node   0    1    2
> > >    0  10   30   50
> > >    1  30   10   60
> > >    2  50   60   10
> > >
> > > $ cat /sys/devices/system/memtier/possible
> > > 0(64), 1(128), 2(192)
> > >
> > > $ grep '' /sys/devices/system/memtier/memtier*/rank
> > > /sys/devices/system/memtier/memtier0/rank:64
> > > /sys/devices/system/memtier/memtier1/rank:128
> > > /sys/devices/system/memtier/memtier2/rank:192
> > >
> > > $ grep '' /sys/devices/system/memtier/memtier*/nodelist
> > > /sys/devices/system/memtier/memtier0/nodelist:2
> > > /sys/devices/system/memtier/memtier1/nodelist:0
> > > /sys/devices/system/memtier/memtier2/nodelist:1
> > >
> > > $ grep '' /sys/devices/system/node/node*/memtier
> > > /sys/devices/system/node/node0/memtier:1
> > > /sys/devices/system/node/node1/memtier:2
> > > /sys/devices/system/node/node2/memtier:0
> > >
> > > Demotion fallback order:
> > > node 0: 1
> > > node 1: empty
> > > node 2: 0, 1
> > >
> > >
> > > * Example 5:
> > >
> > > Node 0 is a DRAM node with CPU.
> > > Node 1 is a GPU node.
> > > Node 2 is a PMEM node.
> > > Node 3 is a large, slow DRAM node without CPU.
> > >
> > >                     100
> > >      Node 0 (DRAM)  ----  Node 1 (GPU)
> > >     /     |               /    |
> > >    /40    |30        120 /     | 110
> > >   |       |             /      |
> > >   |  Node 2 (PMEM) ----       /
> > >   |        \                 /
> > >    \     80 \               /
> > >     ------- Node 3 (Slow DRAM)
> > >
> > > node distances:
> > > node    0    1    2    3
> > >    0   10  100   30   40
> > >    1  100   10  120  110
> > >    2   30  120   10   80
> > >    3   40  110   80   10
> > >
> > > MAX_MEMORY_TIERS=4 (memtier3 is a memory tier added later).
> > >
> > > $ cat /sys/devices/system/memtier/possible
> > > 0(64), 1(128), 3(160), 2(192)
> > >
> > > $ grep '' /sys/devices/system/memtier/memtier*/rank
> > > /sys/devices/system/memtier/memtier0/rank:64
> > > /sys/devices/system/memtier/memtier1/rank:128
> > > /sys/devices/system/memtier/memtier2/rank:192
> > > /sys/devices/system/memtier/memtier3/rank:160
> > >
> > > $ grep '' /sys/devices/system/memtier/memtier*/nodelist
> > > /sys/devices/system/memtier/memtier0/nodelist:1
> > > /sys/devices/system/memtier/memtier1/nodelist:0
> > > /sys/devices/system/memtier/memtier2/nodelist:2
> > > /sys/devices/system/memtier/memtier3/nodelist:3
> > >
> > > $ grep '' /sys/devices/system/node/node*/memtier
> > > /sys/devices/system/node/node0/memtier:1
> > > /sys/devices/system/node/node1/memtier:0
> > > /sys/devices/system/node/node2/memtier:2
> > > /sys/devices/system/node/node3/memtier:3
> > >
> > > Demotion fallback order:
> > > node 0: 2, 3
> > > node 1: 0, 3, 2
> > > node 2: empty
> > > node 3: 2
> >
> >
>
>
