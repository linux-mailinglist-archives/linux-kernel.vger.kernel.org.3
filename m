Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA04515A3A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 06:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240108AbiD3EDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 00:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiD3EDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 00:03:00 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7007CFE50
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 20:59:39 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id k1so77640pll.4
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 20:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VXhNyYPG1BzflQFcUH/DAfsSajV0WNssODtPmfXXJFU=;
        b=LI8nPtWhyyHP8B8M7PZd2xCoZREemFp5DQpo8RyYBmbDdO6go44jfaZFWYKgWvom9p
         PolWjfWOx+j9fEzvXOPWye0HG8NMgYDpuN9ZyyYJ4ZUKv1jq6OgB1Eby8SFABLw9N8eF
         CvTVBn0s3ez+mgTxpII8RAzL0HEN2dPPjx61HP4Df5J60Z+nJEXDfT2Bjbv0n7nysoNx
         l7ALItGKbnOaHS13umCEBwEfJmrXrj/9Nq0Nhg9odVu+9tJ0VF7bSbcr+WKNe5AL+K6U
         4ElqSk1MdwB1c6oU68WLCj2XmwPMyg4sX7QNLPgOs6tb7OoyPP40VMul2nqUcdn34ZR1
         fZlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VXhNyYPG1BzflQFcUH/DAfsSajV0WNssODtPmfXXJFU=;
        b=2jPk1G0iECAmQKXnRUbyg4lPsPoDRngTt90NdNOmqjkGhLa57otKInSmljmT5iqiIW
         y+ZDJ1hORo7E/WoK9+R4AAC5QFmx4N2cEDIw7E0V01ny4ETyb3uN/ghb0vQ3kmR7Hh9k
         WBOs9m4ral42cVebuPEL/XWKK6hVLxEYS591E8jerX3Kglhfzk7dD81tK3KM6/QcsqGZ
         CN1zIjiVFgamecFvG0Me1AVwJCAwuN2TPrYsNAqF5kL2QWFZqKQ2XWeMYxM0fXxhcLG1
         h4Cm4mxvuGCsfGt+b8ji8nxNrfy8nL+82Xs/2dgLjoOHSJ8El09j/ey6MwQhqnmGVgvi
         VDuw==
X-Gm-Message-State: AOAM532u1yBoohCPngHQMtt5pURiiZLdTJSZ4MrXnzRBRWK+Y0AWw+6q
        wkrveQUN/EU1pNB3to1W/XJMBsqSpZ5FDHUDoZE=
X-Google-Smtp-Source: ABdhPJzHcQycpfYbifWtaanbH1R8kFGgaO51YmjnPiljmzg6rw3DNhsh57S6q05xtmTW8lD/D6n40ufzYCpMk5q+lyY=
X-Received: by 2002:a17:90b:4b07:b0:1db:c488:7394 with SMTP id
 lx7-20020a17090b4b0700b001dbc4887394mr7254843pjb.21.1651291179018; Fri, 29
 Apr 2022 20:59:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAAPL-u9sVx94ACSuCVN8V0tKp+AMxiY89cro0japtyB=xNfNBw@mail.gmail.com>
In-Reply-To: <CAAPL-u9sVx94ACSuCVN8V0tKp+AMxiY89cro0japtyB=xNfNBw@mail.gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 29 Apr 2022 20:59:25 -0700
Message-ID: <CAHbLzkq1YXXLMiREpGnzhJjPssu4WpSsnkTmrLJ=hAEhZVUr9w@mail.gmail.com>
Subject: Re: RFC: Memory Tiering Kernel Interfaces
To:     Wei Xu <weixugc@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Huang Ying <ying.huang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux MM <linux-mm@kvack.org>,
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
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wei,

Thanks for the nice writing. Please see the below inline comments.

On Fri, Apr 29, 2022 at 7:10 PM Wei Xu <weixugc@google.com> wrote:
>
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
>   each memory-only NUMA node into a lower tier.  But a memory-only
>   NUMA node may have a high performance memory device (e.g. a DRAM
>   device attached via CXL.mem or a DRAM-backed memory-only node on
>   a virtual machine) and should be put into the top tier.
>
> * The current tiering hierarchy always puts CPU nodes into the top
>   tier. But on a system with HBM (e.g. GPU memory) devices, these
>   memory-only HBM NUMA nodes should be in the top tier, and DRAM nodes
>   with CPUs are better to be placed into the next lower tier.
>
> * Also because the current tiering hierarchy always puts CPU nodes
>   into the top tier, when a CPU is hot-added (or hot-removed) and
>   triggers a memory node from CPU-less into a CPU node (or vice
>   versa), the memory tiering hierarchy gets changed, even though no
>   memory node is added or removed.  This can make the tiering
>   hierarchy much less stable.

I'd prefer the firmware builds up tiers topology then passes it to
kernel so that kernel knows what nodes are in what tiers. No matter
what nodes are hot-removed/hot-added they always stay in their tiers
defined by the firmware. I think this is important information like
numa distances. NUMA distance alone can't satisfy all the usecases
IMHO.

>
> * A higher tier node can only be demoted to selected nodes on the
>   next lower tier, not any other node from the next lower tier.  This
>   strict, hard-coded demotion order does not work in all use cases
>   (e.g. some use cases may want to allow cross-socket demotion to
>   another node in the same demotion tier as a fallback when the
>   preferred demotion node is out of space), and has resulted in the
>   feature request for an interface to override the system-wide,
>   per-node demotion order from the userspace.
>
> * There are no interfaces for the userspace to learn about the memory
>   tiering hierarchy in order to optimize its memory allocations.
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
>   Format: node list (one tier per line, in the tier order)
>
>   When read, list memory nodes by tiers.
>
>   When written (one tier per line), take the user-provided node-tier
>   assignment as the new tiering hierarchy and rebuild the per-node
>   demotion order.  It is allowed to only override the top tiers, in
>   which cases, the kernel will establish the lower tiers automatically.

TBH I still think it is too soon to define proper user visible
interfaces for now, particularly for override.

>
>
> Kernel Representation
> =====================
>
> * nodemask_t node_states[N_TOPTIER_MEMORY]
>
>   Store all top-tier memory nodes.
>
> * nodemask_t memory_tiers[MAX_TIERS]
>
>   Store memory nodes by tiers.

I'd prefer nodemask_t node_states[MAX_TIERS][]. Tier 0 is always the
top tier. The kernel could build this with the topology built by
firmware.

>
> * struct demotion_nodes node_demotion[]
>
>   where: struct demotion_nodes { nodemask_t preferred; nodemask_t allowed; }
>
>   For a node N:
>
>   node_demotion[N].preferred lists all preferred demotion targets;
>
>   node_demotion[N].allowed lists all allowed demotion targets
>   (initialized to be all the nodes in the same demotion tier).

It seems unnecessary to define preferred and allowed IMHO. Why not
just use something like the allocation fallback list? The first node
in the list is the preferred one. When allocating memory for demotion,
convert the list to a nodemask, then call __alloc_pages(gfp, order,
first_node, nodemask). So the allocation could fallback to the allowed
nodes automatically.

>
>
> Tiering Hierarchy Initialization
> ================================
>
> By default, all memory nodes are in the top tier (N_TOPTIER_MEMORY).
>
> A device driver can remove its memory nodes from the top tier, e.g.
> a dax driver can remove PMEM nodes from the top tier.

With the topology built by firmware we should not need this.

>
> The kernel builds the memory tiering hierarchy and per-node demotion
> order tier-by-tier starting from N_TOPTIER_MEMORY.  For a node N, the
> best distance nodes in the next lower tier are assigned to
> node_demotion[N].preferred and all the nodes in the next lower tier
> are assigned to node_demotion[N].allowed.

I'm not sure whether it should be allowed to demote to multiple lower
tiers. But it is totally fine to *NOT* allow it at the moment. Once we
figure out a good way to define demotion targets, it could be extended
to support this easily.

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
>   Node 0 & 1 are DRAM nodes, node 2 & 3 are PMEM nodes.
>
>   Node 0 has node 2 as the preferred demotion target and can also
>   fallback demotion to node 3.
>
>   Node 1 has node 3 as the preferred demotion target and can also
>   fallback demotion to node 2.
>
>   Set mempolicy to prevent cross-socket demotion and memory access,
>   e.g. cpuset.mems=0,2
>
> node distances:
> node   0    1    2    3
>    0  10   20   30   40
>    1  20   10   40   30
>    2  30   40   10   40
>    3  40   30   40   10
>
> /sys/devices/system/node/memory_tiers
> 0-1
> 2-3
>
> N_TOPTIER_MEMORY: 0-1
>
> node_demotion[]:
>   0: [2], [2-3]
>   1: [3], [2-3]
>   2: [],  []
>   3: [],  []
>
> * Example 2:
>   Node 0 & 1 are DRAM nodes.
>   Node 2 is a PMEM node and closer to node 0.
>
>   Node 0 has node 2 as the preferred and only demotion target.
>
>   Node 1 has no preferred demotion target, but can still demote
>   to node 2.
>
>   Set mempolicy to prevent cross-socket demotion and memory access,
>   e.g. cpuset.mems=0,2
>
> node distances:
> node   0    1    2
>    0  10   20   30
>    1  20   10   40
>    2  30   40   10
>
> /sys/devices/system/node/memory_tiers
> 0-1
> 2
>
> N_TOPTIER_MEMORY: 0-1
>
> node_demotion[]:
>   0: [2], [2]
>   1: [],  [2]
>   2: [],  []
>
>
> * Example 3:
>   Node 0 & 1 are DRAM nodes.
>   Node 2 is a PMEM node and has the same distance to node 0 & 1.
>
>   Node 0 has node 2 as the preferred and only demotion target.
>
>   Node 1 has node 2 as the preferred and only demotion target.
>
> node distances:
> node   0    1    2
>    0  10   20   30
>    1  20   10   30
>    2  30   30   10
>
> /sys/devices/system/node/memory_tiers
> 0-1
> 2
>
> N_TOPTIER_MEMORY: 0-1
>
> node_demotion[]:
>   0: [2], [2]
>   1: [2], [2]
>   2: [],  []
>
>
> * Example 4:
>   Node 0 & 1 are DRAM nodes, Node 2 is a memory-only DRAM node.
>
>   All nodes are top-tier.
>
> node distances:
> node   0    1    2
>    0  10   20   30
>    1  20   10   30
>    2  30   30   10
>
> /sys/devices/system/node/memory_tiers
> 0-2
>
> N_TOPTIER_MEMORY: 0-2
>
> node_demotion[]:
>   0: [],  []
>   1: [],  []
>   2: [],  []
>
>
> * Example 5:
>   Node 0 is a DRAM node with CPU.
>   Node 1 is a HBM node.
>   Node 2 is a PMEM node.
>
>   With userspace override, node 1 is the top tier and has node 0 as
>   the preferred and only demotion target.
>
>   Node 0 is in the second tier, tier 1, and has node 2 as the
>   preferred and only demotion target.
>
>   Node 2 is in the lowest tier, tier 2, and has no demotion targets.
>
> node distances:
> node   0    1    2
>    0  10   21   30
>    1  21   10   40
>    2  30   40   10
>
> /sys/devices/system/node/memory_tiers (userspace override)
> 1
> 0
> 2
>
> N_TOPTIER_MEMORY: 1
>
> node_demotion[]:
>   0: [2], [2]
>   1: [0], [0]
>   2: [],  []
>
> -- Wei
