Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 935AF52B311
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 09:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbiERHK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 03:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231742AbiERHKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 03:10:03 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32768E52BA
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 00:10:01 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id n24so507376uap.13
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 00:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9HOc1B9n+VpgK2l/uOFuOGTE0nOsSucQdjTHM/6lfM4=;
        b=gt93yXfiGckbUSR6+1ClodmMB0wDbrRmHal9I3Njx5HSZa77aPSwCOAaDSAKA4d4kx
         2ZlUY2F2sPKqBWq1FXaezwxkNMG1QSoT47tk3YCMFeGp9nQrqTTCbTMOP8pWSKO+wGem
         UrLPyshYPfdLDsG5JPn+/ekFPiNw2mYzdHFr8qsfd+k7Sxim5OJdbxKN3wUKr/FUMdCD
         L8OW8cVda/Xgb1lvGo8y79KyMXI/tVw5ddut0rWIGIlcgZ6oxiOugzdJDR94FqPbRboK
         cXACUCwcmp47bctSFnBU7tmdESkOIHCZFF0O0ISLyH7LYmezO0uTNto+84m5mqKy9+Le
         X1rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9HOc1B9n+VpgK2l/uOFuOGTE0nOsSucQdjTHM/6lfM4=;
        b=XpT95r49eb8Xx0FO7dsa3xJmArwAwKS8slNpw1rI390e8msgDhAQ4GQ40pTKd4i71z
         JvjC/o8Z/4aMFF5vJFMHFGcuW3pm2UMIfuy/oOPILfdKag2xUJJzn0yb8W5O2WZPB2NR
         dWm0rOOnXahB3rFxvLAOfTU8WWgFce/UAEjL1WWpZPXH5nWNCKv+645uYMqgkOxYqUWh
         Tn0iGppsYjyMN3fY3NdneOUemhqTqo7s1bW6KGCUyci2LI7zv2kJaj2tqChTCcibBNwg
         sBRJyRcEgmE7WDvk85U3hhmX91JfyTfglThrxs+sQcK81WfKJUDVNdV1PtaJCKIKsFgG
         Bb/Q==
X-Gm-Message-State: AOAM5339hhVqQuCfp7Vd2gFhMyz+qlfhhCufzLzcr4nuQ5aFq4n3+PR/
        b5Hi1gGFMcYDdBoKt0B6GLNZdGQ21VmELftc4eAs/g==
X-Google-Smtp-Source: ABdhPJwJRMTAHkdxGMBE2P/tdvC8xOGEF+ZqwYeH+EIw3quAgtuTeiZ0hNbBwD8j7xISkY6TCMrvENRjQKLNcT0wPP8=
X-Received: by 2002:a9f:3592:0:b0:365:ef07:68c9 with SMTP id
 t18-20020a9f3592000000b00365ef0768c9mr10012643uad.60.1652857799968; Wed, 18
 May 2022 00:09:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAAPL-u-DGLcKRVDnChN9ZhxPkfxQvz9Sb93kVoX_4J2oiJSkUw@mail.gmail.com>
 <20220512160010.00005bc4@Huawei.com>
In-Reply-To: <20220512160010.00005bc4@Huawei.com>
From:   Wei Xu <weixugc@google.com>
Date:   Wed, 18 May 2022 00:09:48 -0700
Message-ID: <CAAPL-u_diGYEb7+WsgqNBLRix-nRCk2SsDj6p9r8j5JZwOABZQ@mail.gmail.com>
Subject: Re: RFC: Memory Tiering Kernel Interfaces (v2)
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Huang Ying <ying.huang@intel.com>,
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

On Thu, May 12, 2022 at 8:00 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Wed, 11 May 2022 23:22:11 -0700
> Wei Xu <weixugc@google.com> wrote:
> > The current kernel has the basic memory tiering support: Inactive
> > pages on a higher tier NUMA node can be migrated (demoted) to a lower
> > tier NUMA node to make room for new allocations on the higher tier
> > NUMA node.  Frequently accessed pages on a lower tier NUMA node can be
> > migrated (promoted) to a higher tier NUMA node to improve the
> > performance.
> >
> > In the current kernel, memory tiers are defined implicitly via a
> > demotion path relationship between NUMA nodes, which is created during
> > the kernel initialization and updated when a NUMA node is hot-added or
> > hot-removed.  The current implementation puts all nodes with CPU into
> > the top tier, and builds the tier hierarchy tier-by-tier by establishing
> > the per-node demotion targets based on the distances between nodes.
> >
> > This current memory tier kernel interface needs to be improved for
> > several important use cases:
> >
> > * The current tier initialization code always initializes
> >   each memory-only NUMA node into a lower tier.  But a memory-only
> >   NUMA node may have a high performance memory device (e.g. a DRAM
> >   device attached via CXL.mem or a DRAM-backed memory-only node on
> >   a virtual machine) and should be put into a higher tier.
> >
> > * The current tier hierarchy always puts CPU nodes into the top
> >   tier. But on a system with HBM (e.g. GPU memory) devices, these
> >   memory-only HBM NUMA nodes should be in the top tier, and DRAM nodes
> >   with CPUs are better to be placed into the next lower tier.
> >
> > * Also because the current tier hierarchy always puts CPU nodes
> >   into the top tier, when a CPU is hot-added (or hot-removed) and
> >   triggers a memory node from CPU-less into a CPU node (or vice
> >   versa), the memory tier hierarchy gets changed, even though no
> >   memory node is added or removed.  This can make the tier
> >   hierarchy unstable and make it difficult to support tier-based
> >   memory accounting.
> >
> > * A higher tier node can only be demoted to selected nodes on the
> >   next lower tier as defined by the demotion path, not any other
> >   node from any lower tier.  This strict, hard-coded demotion order
> >   does not work in all use cases (e.g. some use cases may want to
> >   allow cross-socket demotion to another node in the same demotion
> >   tier as a fallback when the preferred demotion node is out of
> >   space), and has resulted in the feature request for an interface to
> >   override the system-wide, per-node demotion order from the
> >   userspace.  This demotion order is also inconsistent with the page
> >   allocation fallback order when all the nodes in a higher tier are
> >   out of space: The page allocation can fall back to any node from
> >   any lower tier, whereas the demotion order doesn't allow that.
> >
> > * There are no interfaces for the userspace to learn about the memory
> >   tier hierarchy in order to optimize its memory allocations.
> >
> > I'd like to propose revised memory tier kernel interfaces based on
> > the discussions in the threads:
> >
> > - https://lore.kernel.org/lkml/20220425201728.5kzm4seu7rep7ndr@offworld/T/
> > - https://lore.kernel.org/linux-mm/20220426114300.00003ad8@Huawei.com/t/
> > - https://lore.kernel.org/linux-mm/867bc216386eb6cbf54648f23e5825830f5b922e.camel@intel.com/T/
> >
> >
> > High-level Design Ideas
> > =======================
> >
> > * Define memory tiers explicitly, not implicitly.
> >
> > * Memory tiers are defined based on hardware capabilities of memory
> >   nodes, not their relative node distances between each other.
> >
> > * The tier assignment of each node is independent from each other.
> >   Moving a node from one tier to another tier doesn't affect the tier
> >   assignment of any other node.
> >
> > * The node-tier association is stable. A node can be reassigned to a
> >   different tier only under the specific conditions that don't block
> >   future tier-based memory cgroup accounting.
> >
> > * A node can demote its pages to any nodes of any lower tiers. The
> >   demotion target node selection follows the allocation fallback order
> >   of the source node, which is built based on node distances.  The
> >   demotion targets are also restricted to only the nodes from the tiers
> >   lower than the source node.  We no longer need to maintain a separate
> >   per-node demotion order (node_demotion[]).
> >
>
> Hi Wei,
>
> This proposal looks good to me, though we'll be having fun
> white boarding topologies from our roadmaps for the next few days :)

That's good to hear.

> A few comments inline. It also seems likely to me that there is little
> benefit in starting with 3 tiers as the maximum.  Seems unlikely the
> code will be substantially simpler for 3 than it would be for 4 or 5.
> I've drawn out one simple case that needs 4 to do sensible things.

We can make the number of tiers a config option. 3 tiers are just what
the kernel can reasonably initialize when there isn't enough hardware
performance information from the firmware.

> >
> > Sysfs Interfaces
> > ================
> >
> > * /sys/devices/system/memtier/memtierN/nodelist
> >
> >   where N = 0, 1, 2 (the kernel supports only 3 tiers for now).
> >
> >   Format: node_list
> >
> >   Read-only.  When read, list the memory nodes in the specified tier.
> >
> >   Tier 0 is the highest tier, while tier 2 is the lowest tier.
> >
> >   The absolute value of a tier id number has no specific meaning.
> >   What matters is the relative order of the tier id numbers.
> >
> >   When a memory tier has no nodes, the kernel can hide its memtier
> >   sysfs files.
> >
> > * /sys/devices/system/node/nodeN/memtier
> >
> >   where N = 0, 1, ...
> >
> >   Format: int or empty
> >
> >   When read, list the memory tier that the node belongs to.  Its value
> >   is empty for a CPU-only NUMA node.
> >
> >   When written, the kernel moves the node into the specified memory
> >   tier if the move is allowed.  The tier assignment of all other nodes
> >   are not affected.
> >
> >   Initially, we can make this interface read-only.
> >
> >
> > Kernel Representation
> > =====================
> >
> > * All memory tiering code is guarded by CONFIG_TIERED_MEMORY.
> >
> > * #define MAX_MEMORY_TIERS 3
> >
> >   Support 3 memory tiers for now.
> >
> > * #define MEMORY_DEFAULT_TIER 1
> >
> >   The default tier that a memory node is assigned to.
> >
> > * nodemask_t memory_tiers[MAX_MEMORY_TIERS]
> >
> >   Store memory nodes by tiers.
> >
> > * int node_tier_map[MAX_NUMNODES]
> >
> >   Map a node to its tier.
> >
> >   For each CPU-only node c, node_tier_map[c] = -1.
> >
> >
> > Memory Tier Initialization
> > ==========================
> >
> > By default, all memory nodes are assigned to the default tier
> > (MEMORY_DEFAULT_TIER).
>
> This is tighter than it needs to be.  In many cases we can easily
> establish if there is any possibility of CPU being hotplugged into
> a memory node.  If it's CXL attached no way CPUs are going to be
> turning up their later :)  If CPU HP into a given node can't happen
> we can be more flexible and I think that often results in better decisions.
> See example below, though obviously I could just use the userspace
> interface to fix that up anyway or have a CXL driver move it around
> if that's relevant.  In some other cases I'm fairly sure we know in
> advance where CPUs can be added but I'd need to check all the
> relevant specs to be sure there aren't any corner cases.  I 'think'
> for ARM for example we know where all possible CPUs can be hotplugged
> (constraint coming from the interrupt controller + the fact that only
> virtual CPU HP is defined).

We may not always want to put a CXL-attached memory device into a
slower tier because even though CXL does add some additional latency,
both the memory device and CXL can still be very capable in
performance and may not be much slower (if any) than the on-board DRAM
(e.g. DRAM from a remote CPU socket).

Also, the default tier here is just the initial tier assignment of
each node, which behaves as if there were no tiering.  A tiering
kernel init function can certainly reassign the tier for each node if
it knows enough about the hardware performance for these nodes from
the firmware.

> >
> > A device driver can move up or down its memory nodes from the default
> > tier.  For example, PMEM can move down its memory nodes below the
> > default tier, whereas GPU can move up its memory nodes above the
> > default tier.
> >
> > The kernel initialization code makes the decision on which exact tier
> > a memory node should be assigned to based on the requests from the
> > device drivers as well as the memory device hardware information
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
> >
> > Hot-adding/removing CPUs doesn't affect memory tier hierarchy.
> >
> >
> > Memory Allocation for Demotion
> > ==============================
> >
> > To allocate a new page as the demotion target for a page, the kernel
> > calls the allocation function (__alloc_pages_nodemask) with the
> > source page node as the preferred node and the union of all lower
> > tier nodes as the allowed nodemask.  The actual target node selection
> > then follows the allocation fallback order that the kernel has
> > already defined.
> >
> > The pseudo code looks like:
> >
> >     targets = NODE_MASK_NONE;
> >     src_nid = page_to_nid(page);
> >     src_tier = node_tier_map[src_nid];
> >     for (i = src_tier + 1; i < MAX_MEMORY_TIERS; i++)
> >             nodes_or(targets, targets, memory_tiers[i]);
> >     new_page = __alloc_pages_nodemask(gfp, order, src_nid, targets);
> >
> > The memopolicy of cpuset, vma and owner task of the source page can
> > be set to refine the demotion target nodemask, e.g. to prevent
> > demotion or select a particular allowed node as the demotion target.
> >
> >
> > Memory Allocation for Promotion
> > ===============================
> >
> > The page allocation for promotion is similar to demotion, except that (1)
> > the target nodemask uses the promotion tiers, (2) the preferred node can
> > be the accessing CPU node, not the source page node.
> >
> >
> > Examples
> > ========
> >
>
> ...
>
> > * Example 3:
> >
> > Node 0 & 1 are DRAM nodes, Node 2 is a memory-only DRAM node.
>
> Node2 is drawn as pmem.

Typo. Good catch.

> >
> > All nodes are in the same tier.
> >
> >                   20
> >   Node 0 (DRAM)  ----  Node 1 (DRAM)
> >          \                 /
> >           \ 30            / 30
> >            \             /
> >              Node 2 (PMEM)
> >
> > node distances:
> > node   0    1    2
> >    0  10   20   30
> >    1  20   10   30
> >    2  30   30   10
> >
> > $ cat /sys/devices/system/memtier/memtier*/nodelist
> > <empty>
> > 0-2
> > <empty>
> >
> > $ cat /sys/devices/system/node/node*/memtier
> > 1
> > 1
> > 1
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
> >                   50
> >   Node 0 (DRAM)  ----  Node 2 (GPU)
> >          \                 /
> >           \ 30            / 60
> >            \             /
> >              Node 1 (PMEM)
> >
> > node distances:
> > node   0    1    2
> >    0  10   30   50
> >    1  30   10   60
> >    2  50   60   10
> >
> > $ cat /sys/devices/system/memtier/memtier*/nodelist
> > 2
> > 0
> > 1
> >
> > $ cat /sys/devices/system/node/node*/memtier
> > 1
> > 2
> > 0
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
> >
> >      Node 2 (PMEM)  ----
> >    /      |              \
> >   /       | 30            \ 120
> >  |        |         100    \
> >  |   Node 0 (DRAM)  ----  Node 1 (GPU)
> >   \         \                 /
> >     \        \ 40            / 110
> >   80  \       \             /
> >         ---  Node 3 (Slow DRAM)
>
> This is close but not quite what was intended for Hesham's
> example... (note we just checked that Hesham's original node0-1
> timing didn't make any sense.).
>

This was inspired by Hesham's example. But I should have also included
the version that illustrates the need to skip a tier when demoting
from certain nodes.

> >
> > node distances:
> > node    0    1    2    3
> >    0   10  100   30   40
> >    1  100   10  120  110
> >    2   30  120   10   80
> >    3   40  110   80   10
> >
> > $ cat /sys/devices/system/memtier/memtier*/nodelist
> > 1
> > 0,3
> > 2
> >
> > $ cat /sys/devices/system/node/node*/memtier
> > 1
> > 0
> > 2
> > 1
> >
> > Demotion fallback order:
> > node 0: 2
> > node 1: 0, 3, 2
> > node 2: empty
> > node 3: 2
>
> This is close but not quite the same as the example
> Hesham gave (note the node timing 1 to 0 on in the table
> with that example didn't make sense).  I added another
> level of switching to make the numbers more obviously
> different and show how critical it might be.
>
> * Example 6:
>
> Node 0 is a DRAM node with CPU.
> Node 1 is a GPU node.
> Node 2 is a PMEM node.
> Node 3 is an extremely large, DRAM node without CPU.
>   (Key point here being that it probably never makes sense
>    to demote to anywhere else from this memory).
>
>
> I've redone the timings wrt to example 5.
> Basis for this is 0 and 2 are directly connected
> via controllers in an SoC. 1 and 3 are connected
> via a a common switch one switch down switch
> (each hop via this is 100)
> All drams cost 10 once you've reached correct node
> and pmem costs 30 from SoC.
> Numbers get too large as a result but meh, I'm making
> a point not providing real numbers :)
>
>          PMEM Node 2
>             |(30)
>         CPU + DRAM Node0
>             |(100)
>          Switch 1
>             |(100)
>           Switch 2
>     (100)  |      |(100)
> Node 1 GPU     Node3 Large memory.
>
>
> With one level of s
>
>      Node 2 (PMEM)  ----
>     /      |              \
>    /       | 30            \ 330
>   |        |         310    \
>   |   Node 0 (DRAM)  ----  Node 1 (GPU)
>    \         \                 /
>      \        \ 310           / 210
>    330 \       \             /
>          ---  Node 3 (Extremely large DRAM)
>
> To my mind, we should potentially also take into account
> the fact that Node3 can be known to never contain CPUs
> (in at least some architectures we know where the CPUs
>  might be added later, they can't just magically turn up
>  anywhere in the topology).
>
> node distances:
> node    0    1    2    3
>     0   10   310  30   310
>     1   310  10   330  210
>     2   30   330  10   330
>     3   310  210  330   10
>
> So, my ideal would treat node 3 different from other dram nodes
> as we know it can't have CPUs. Trying to come up with an
> always correct order for nodes 3 and 2 is tricky as to a certain
> extent depends on capacity. If node 2 was  big enough to take
> any demotion from node 0 and still have lots of room then demoting
> there form node 3 would make sense and visa versa.
>
>
>  $ cat /sys/devices/system/memtier/memtier*/nodelist
>  1
>  0
>  2
>  3
>
>
>  $ cat /sys/devices/system/node/node*/memtier
>   1
>   0
>   2
>   3
>
>  Demotion fallback order:
>  node 0: 2, 3
>  node 1: 3, 0, 2 (key being we will almost always have less pressure on node 3)
>  node 2: 3
>  node 3: empty
>
> or as Hesham just pointed out this can be done with 3 tiers
> because we can put the GPU and CPU in the same tier because
> their is little reason to demote from one to the other.

Thank you for the example.  It makes sense to me to have node 3 on its
own tier.  We can have either 3 tiers or 4 tiers in total (assuming
that the max number of tiers is a config option).

> We are also a bit worried about ABI backwards compatibility because
> of potential need to make more space in tiers lower in number than
> CPU attached DDR. I rather liked the negative proposal with
> default as 0 that Huang, Ying made.

It is hard to have negative values as the device IDs.

The current proposal equals the tier device ID to the tier hierarchy
level, which makes the interface simpler, but less flexible.  How
about the following proposal (which decouples the tier device ID from
the tier level)?

/sys/devices/system/memtier/memtierN/nodelist
/sys/devices/system/memtier/memtierN/rank

Each memory tier N has two sysfs files:
- nodelist: the nodes that are in this tier
- rank: an opaque value that helps decide the level at which this tier
is in the tier hierarchy (smaller value means faster tier)

The tier hierarchy is determined by "rank", not by the device id
number N from "memtierN".

The absolute value of "rank" of a memtier doesn't necessarily carry
any meaning. Its value relative to other memtiers decides the level of
this memtier in the tier hierarchy.

The CPU-attached DRAM nodes are always in memtier0 (the device ID),
but memtier0 may not always be the top-tier, e.g. its level can be 3
in a 5-tier system.

For the above example (example 6), we can have:

$ ls /sys/devices/system/memtier
memtier0
memtier1
memtier2
memtier128

$ cat /sys/devices/system/memtier/memtier*/rank
50
60
70
10

The tier order: memtier128 -> memtier0 -> memtier1 -> memtier2

$ cat /sys/devices/system/memtier/memtier*/nodelist
0
2
3
1

$ ls -l /sys/devices/system/node/node*/memtier
/sys/devices/system/node/node0/memtier -> /sys/devices/system/memtier/memtier0
/sys/devices/system/node/node1/memtier -> /sys/devices/system/memtier/memtier128
/sys/devices/system/node/node2/memtier -> /sys/devices/system/memtier/memtier1
/sys/devices/system/node/node3/memtier -> /sys/devices/system/memtier/memtier2

To override the memory tier of a node, we can use a new, write-only,
per-node interface file:

/sys/devices/system/node/nodeN/set_memtier

e.g.

$ echo "memtier128" > sys/devices/system/node/node1/set_memtier

Any comments?

> Jonathan
>
>
>
>
>
