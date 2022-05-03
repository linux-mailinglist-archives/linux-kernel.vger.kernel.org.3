Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B864517E09
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 09:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbiECHGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 03:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbiECHG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 03:06:27 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB96C23171
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 00:02:55 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id q2so15609124vsr.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 00:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YRa5FtHK50FQisB4IvadQi9eX727llxqdD3BBf/n9f0=;
        b=VS1NwEq8gwn3D9X7poQgyObo6azyEzgnLHdKqX6T/NHRiEGjJkYV3TUQq6af9uOMnx
         MHk/iY4oQ0cerdpjGLIZ4qpgU+URewg+avzSQP+djRuFuL9+Zm32Uhh4qmPYSKrQcfrA
         C6O3KKVcRvZVhOs5KPmtgI/G8WoGKB6FMyq7sU1jtAkVJL8DrWzOniMDmwilmmA3asgJ
         +ly9ph+Fj3YJ7KKABa70m6BiVHCXYnSDKxtK63ZgRvMBde1HJ5sDU+2NBhBR8ZjTFCXk
         c0aqIenkMUdHZp3FoFsrdIl5k/PuTV14AM7q9VcN/95wXQUgecYVMSfbmzRGPu8aC6Yn
         xQPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YRa5FtHK50FQisB4IvadQi9eX727llxqdD3BBf/n9f0=;
        b=XB99FD/k3BOpzZZJuAAqETFSuF0JzMR4WZ/o8EvfKIMm41HOy9XayYDZKPLYQD09+s
         Oa1/b61388nHdIq+83cO2qb+8XpZzC4xLEvwQ0ETuXeD2hcAaiL0oyKLLE7QDT9FHCZD
         UnYNkOZxysLYJmIu85p6TiRnBnB8NY0xswGhIwJslsBi+UnZYFb95SU6BkoVjbFcq4c1
         Z73ZrOoaJ/3SGPis9E57u6ZvkJCJifsNFT1ma2gwWey3TppxOdc1H6ph2P1dkWOdobuf
         z/ussAcYmRvcp4vpcgD515AlAxZQsu+f4nJKksZNfiUXdxawDFUv8Nelv7nin6HP0MhY
         Pbiw==
X-Gm-Message-State: AOAM533qmb71vtbMSewVmXuQi2gkdwlPvAJnmcHyFbQNvl83bUASBCD6
        tT8oZv9l7eTFcgZlr44D7iZRtP6c0i+b073q4zbeOA==
X-Google-Smtp-Source: ABdhPJyKchgAvdO4C5OT6vhSPVpJY0blx+1tImcyVue+4SF8wwvFGIahDftRES3uX0zg9eAtlGsDi8HCu20tAFbSFo0=
X-Received: by 2002:a67:ed88:0:b0:328:27d9:1381 with SMTP id
 d8-20020a67ed88000000b0032827d91381mr4403354vsp.12.1651561374947; Tue, 03 May
 2022 00:02:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAAPL-u9sVx94ACSuCVN8V0tKp+AMxiY89cro0japtyB=xNfNBw@mail.gmail.com>
 <87ilqov4bc.fsf@linux.ibm.com>
In-Reply-To: <87ilqov4bc.fsf@linux.ibm.com>
From:   Wei Xu <weixugc@google.com>
Date:   Tue, 3 May 2022 00:02:43 -0700
Message-ID: <CAAPL-u9G=oojWT82mSuAfJGdDjf8GSAW1=xhFgY+ce9K7xNnKA@mail.gmail.com>
Subject: Re: RFC: Memory Tiering Kernel Interfaces
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Huang Ying <ying.huang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Yang Shi <shy828301@gmail.com>, Linux MM <linux-mm@kvack.org>,
        Greg Thelen <gthelen@google.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alistair Popple <apopple@nvidia.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Michal Hocko <mhocko@kernel.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Feng Tang <feng.tang@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
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

On Sun, May 1, 2022 at 11:25 PM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
>
> Wei Xu <weixugc@google.com> writes:
>
> ....
>
> >
> > Tiering Hierarchy Initialization
> > ================================
> >
> > By default, all memory nodes are in the top tier (N_TOPTIER_MEMORY).
> >
> > A device driver can remove its memory nodes from the top tier, e.g.
> > a dax driver can remove PMEM nodes from the top tier.
>
> Should we look at the tier in which to place the memory an option that
> device drivers like dax driver can select? Or dax driver just selects
> the desire to mark a specific memory only numa node as demotion target
> and won't explicity specify the tier in which it should be placed. I
> would like to go for the later and choose the tier details based on the
> current memory tiers and the NUMA distance value (even HMAT at some
> point in the future).

This is what has been proposed here.  The driver doesn't determine
which particular tier the node should be placed in.  It just removes
the node from the top-tier (i.e. making the node a demotion target).
The actual tier of the node is determined based on all the nodes and
their NUMA distance values.

> The challenge with NUMA distance though is which
> distance value we will pick. For example, in your example1.
>
>  node   0    1    2    3
>     0  10   20   30   40
>     1  20   10   40   30
>     2  30   40   10   40
>     3  40   30   40   10
>
> When Node3 is registered, how do we decide to create a Tier2 or add it
> to Tier1? .

This proposal assumes a breadth-first search in tier construction,
which is also how the current implementation works.  In this example,
the top-tier nodes are [0,1].  We then find a best demotion node for
each of [0,1] and get [0->2, 1->3]. Now we have two tiers: [0,1],
[2,3], and the search terminates.

But this algorithm doesn't work if there is no node 1 and we still
want node 2 & 3 in the same tier.  Without the additional hardware
information such as HMAT, we will need a way to override the default
tier definition.

> We could say devices that wish to be placed in the same tier
> will have same distance as the existing tier device ie, for the above
> case,
>
> node_distance[2][2] == node_distance[2][3] ? Can we expect the firmware
> to have distance value like that?

node_distance[2][2] is local, which should be smaller than
node_distance[2][3].  I expect that this should be the case in normal
firmwares.

> >
> > The kernel builds the memory tiering hierarchy and per-node demotion
> > order tier-by-tier starting from N_TOPTIER_MEMORY.  For a node N, the
> > best distance nodes in the next lower tier are assigned to
> > node_demotion[N].preferred and all the nodes in the next lower tier
> > are assigned to node_demotion[N].allowed.
> >
> > node_demotion[N].preferred can be empty if no preferred demotion node
> > is available for node N.
> >
> > If the userspace overrides the tiers via the memory_tiers sysfs
> > interface, the kernel then only rebuilds the per-node demotion order
> > accordingly.
> >
> > Memory tiering hierarchy is rebuilt upon hot-add or hot-remove of a
> > memory node, but is NOT rebuilt upon hot-add or hot-remove of a CPU
> > node.
> >
> >
> > Memory Allocation for Demotion
> > ==============================
> >
> > When allocating a new demotion target page, both a preferred node
> > and the allowed nodemask are provided to the allocation function.
> > The default kernel allocation fallback order is used to allocate the
> > page from the specified node and nodemask.
> >
> > The memopolicy of cpuset, vma and owner task of the source page can
> > be set to refine the demotion nodemask, e.g. to prevent demotion or
> > select a particular allowed node as the demotion target.
> >
> >
> > Examples
> > ========
> >
> > * Example 1:
> >   Node 0 & 1 are DRAM nodes, node 2 & 3 are PMEM nodes.
> >
> >   Node 0 has node 2 as the preferred demotion target and can also
> >   fallback demotion to node 3.
> >
> >   Node 1 has node 3 as the preferred demotion target and can also
> >   fallback demotion to node 2.
> >
> >   Set mempolicy to prevent cross-socket demotion and memory access,
> >   e.g. cpuset.mems=0,2
> >
> > node distances:
> > node   0    1    2    3
> >    0  10   20   30   40
> >    1  20   10   40   30
> >    2  30   40   10   40
> >    3  40   30   40   10
> >
> > /sys/devices/system/node/memory_tiers
> > 0-1
> > 2-3
>
> How can I make Node3 the demotion target for Node2 in this case? Can
> we have one file for each tier? ie, we start with
> /sys/devices/system/node/memory_tier0. Removing a node with memory from
> the above file/list results in the creation of new tiers.
>
> /sys/devices/system/node/memory_tier0
> 0-1
> /sys/devices/system/node/memory_tier1
> 2-3
>
> echo 2 > /sys/devices/system/node/memory_tier1
> /sys/devices/system/node/memory_tier1
> 2
> /sys/devices/system/node/memory_tier2
> 3

The proposal does something similar, except using a single file: memory_tiers.

Another idea is to pass the tier override from a kernel boot argument,
though it is challenging to deal with hot-plugged nodes.

> >
> > N_TOPTIER_MEMORY: 0-1
> >
> > node_demotion[]:
> >   0: [2], [2-3]
> >   1: [3], [2-3]
> >   2: [],  []
> >   3: [],  []
> >
> > * Example 2:
> >   Node 0 & 1 are DRAM nodes.
> >   Node 2 is a PMEM node and closer to node 0.
> >
> >   Node 0 has node 2 as the preferred and only demotion target.
> >
> >   Node 1 has no preferred demotion target, but can still demote
> >   to node 2.
> >
> >   Set mempolicy to prevent cross-socket demotion and memory access,
> >   e.g. cpuset.mems=0,2
> >
> > node distances:
> > node   0    1    2
> >    0  10   20   30
> >    1  20   10   40
> >    2  30   40   10
> >
> > /sys/devices/system/node/memory_tiers
> > 0-1
> > 2
> >
> > N_TOPTIER_MEMORY: 0-1
> >
> > node_demotion[]:
> >   0: [2], [2]
> >   1: [],  [2]
> >   2: [],  []
> >
> >
> > * Example 3:
> >   Node 0 & 1 are DRAM nodes.
> >   Node 2 is a PMEM node and has the same distance to node 0 & 1.
> >
> >   Node 0 has node 2 as the preferred and only demotion target.
> >
> >   Node 1 has node 2 as the preferred and only demotion target.
> >
> > node distances:
> > node   0    1    2
> >    0  10   20   30
> >    1  20   10   30
> >    2  30   30   10
> >
> > /sys/devices/system/node/memory_tiers
> > 0-1
> > 2
> >
> > N_TOPTIER_MEMORY: 0-1
> >
> > node_demotion[]:
> >   0: [2], [2]
> >   1: [2], [2]
> >   2: [],  []
> >
> >
> > * Example 4:
> >   Node 0 & 1 are DRAM nodes, Node 2 is a memory-only DRAM node.
> >
> >   All nodes are top-tier.
> >
> > node distances:
> > node   0    1    2
> >    0  10   20   30
> >    1  20   10   30
> >    2  30   30   10
> >
> > /sys/devices/system/node/memory_tiers
> > 0-2
> >
> > N_TOPTIER_MEMORY: 0-2
> >
> > node_demotion[]:
> >   0: [],  []
> >   1: [],  []
> >   2: [],  []
> >
> >
> > * Example 5:
> >   Node 0 is a DRAM node with CPU.
> >   Node 1 is a HBM node.
> >   Node 2 is a PMEM node.
> >
> >   With userspace override, node 1 is the top tier and has node 0 as
> >   the preferred and only demotion target.
> >
> >   Node 0 is in the second tier, tier 1, and has node 2 as the
> >   preferred and only demotion target.
> >
> >   Node 2 is in the lowest tier, tier 2, and has no demotion targets.
> >
> > node distances:
> > node   0    1    2
> >    0  10   21   30
> >    1  21   10   40
> >    2  30   40   10
> >
> > /sys/devices/system/node/memory_tiers (userspace override)
> > 1
> > 0
> > 2
> >
> > N_TOPTIER_MEMORY: 1
> >
> > node_demotion[]:
> >   0: [2], [2]
> >   1: [0], [0]
> >   2: [],  []
> >
> > -- Wei
