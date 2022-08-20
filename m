Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A48C159AA97
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 03:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238939AbiHTBzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 21:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiHTBzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 21:55:03 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018C2DDAA3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 18:55:01 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id p9so4656953pfq.13
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 18:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=7qNRmSKx6dng0szgtUPCAb9wPBSkj9/hqnB/dGOA0x8=;
        b=hoOjndKnE52oxuIUy/R8MbMIkCf8KHxfspEl7kcwdgnq1l9x/26u6kIVged2a5qpno
         gXGJb9tr6UOaXk/9ZdUGntNTm9GRnKFMMRop1Rf9j+Dvn5veCL3wl8YsRNs3SFsHjm/R
         U2jt9wJ35hdNQmZFnYMgmo17/dY2u02GGygHGrO90AkTiCMYQ1wAyYDHSVybOmbiTDi3
         y+T5EGoNiCzeYQDJU2WBDulqpnKp0R3xLHe/Z0LGyxOQyx0ZcuXIlakN7aMLhQGWW3oB
         kT5fyTTuIi69ZyIgHnx+o1UtNmo0cAYIvDJXMrg0jjpjjhG6mPCreqUkpBKv13fPKvOU
         XTSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=7qNRmSKx6dng0szgtUPCAb9wPBSkj9/hqnB/dGOA0x8=;
        b=M30xaTC2/qN22Y9LSBnppxuyynv7G7cTOrwbeNYLcg8WZItpkDRhZn4npLibLZ+Jp2
         0iKGd3g+sJxZiuOEBDTezl6LVC+NtZfhWTCip7dZJgyTMikzoioozWi/YEVDQUv76xM8
         JI7nALi29tO6RJ1eUFUbviouS4Lo90QA5pbicOBb0KIixNW4OBfqqYVmXdwTRiu7dYOn
         65Q8Hx24psTuJFKfEM/6jivHkA+ShHBMqFL0y10KDHxVEB9xhzjjior9IPpXdJSJXCCE
         qhL52sSwZ82n+v6ayMzrdKP5F50NM/JO7ssfIFW7NkZte43RLqFhAjAUvuRYp2/KZw0P
         FirQ==
X-Gm-Message-State: ACgBeo03zhEJfec4TAiujghp6No6XbTs++trjD2C4PuIy6SSD17VFZoI
        JptJI0x9Cy2RL1xxpYW/Su4C2auLYUqnljwCHvXnDQ==
X-Google-Smtp-Source: AA6agR69IPi5cJ5qGkhCbV3mOm8p+BXNAadc91YDgoEpjqK3WJMI91Rwyvhi/EvFxaLiPk61rGNmHf7L2ghHSZ+0ZMI=
X-Received: by 2002:a05:6a00:1a14:b0:52d:3e35:5b38 with SMTP id
 g20-20020a056a001a1400b0052d3e355b38mr10602325pfv.11.1660960501200; Fri, 19
 Aug 2022 18:55:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220818131042.113280-1-aneesh.kumar@linux.ibm.com>
In-Reply-To: <20220818131042.113280-1-aneesh.kumar@linux.ibm.com>
From:   Wei Xu <weixugc@google.com>
Date:   Fri, 19 Aug 2022 18:54:49 -0700
Message-ID: <CAAPL-u8ptL4T6_EUHOSps_tLNAU9W8Bdt9AHN0e0=gWT81zoBw@mail.gmail.com>
Subject: Re: [PATCH v15 00/10] mm/demotion: Memory tiers and demotion
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim C Chen <tim.c.chen@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>, jvgediya.oss@gmail.com,
        Bharata B Rao <bharata@amd.com>
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

Acked-by: Wei Xu <weixugc@google.com>

On Thu, Aug 18, 2022 at 6:10 AM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
>
> The current kernel has the basic memory tiering support: Inactive pages on a
> higher tier NUMA node can be migrated (demoted) to a lower tier NUMA node to
> make room for new allocations on the higher tier NUMA node. Frequently accessed
> pages on a lower tier NUMA node can be migrated (promoted) to a higher tier NUMA
> node to improve the performance.
>
> In the current kernel, memory tiers are defined implicitly via a demotion path
> relationship between NUMA nodes, which is created during the kernel
> initialization and updated when a NUMA node is hot-added or hot-removed. The
> current implementation puts all nodes with CPU into the highest tier, and builds the
> tier hierarchy tier-by-tier by establishing the per-node demotion targets based
> on the distances between nodes.
>
> This current memory tier kernel implementation needs to be improved for several
> important use cases:
>
> * The current tier initialization code always initializes each memory-only NUMA
>   node into a lower tier. But a memory-only NUMA node may have a high
>   performance memory device (e.g. a DRAM-backed memory-only node on a virtual
>   machine) and that should be put into a higher tier.
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
> * A higher tier node can only be demoted to nodes with shortest distance on the
>   next lower tier as defined by the demotion path, not any other node from any
>   lower tier. This strict, demotion order does not work in all use
>   cases (e.g. some use cases may want to allow cross-socket demotion to another
>   node in the same demotion tier as a fallback when the preferred demotion node
>   is out of space), and has resulted in the feature request for an interface to
>   override the system-wide, per-node demotion order from the userspace. This
>   demotion order is also inconsistent with the page allocation fallback order
>   when all the nodes in a higher tier are out of space: The page allocation can
>   fall back to any node from any lower tier, whereas the demotion order doesn't
>   allow that.
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
>
> Changes from v14
> * Add Reviewed-by:
> * Address review feedback w.r.t default adistance value
>
> Changes from v13
> * Address review feedback.
> * Add path dropping memtier from struct memory_dev_type
>
> Changes from v12
> * Fix kernel crash on module unload
> * Address review feedback.
> * Add node_random patch to this series based on review feedback
>
> Changes from v11:
> * smaller abstract distance imply faster(higher) memory tier.
>
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
> Aneesh Kumar K.V (9):
>   mm/demotion: Add support for explicit memory tiers
>   mm/demotion: Move memory demotion related code
>   mm/demotion: Add hotplug callbacks to handle new numa node onlined
>   mm/demotion/dax/kmem: Set node's abstract distance to
>     MEMTIER_DEFAULT_DAX_ADISTANCE
>   mm/demotion: Build demotion targets based on explicit memory tiers
>   mm/demotion: Add pg_data_t member to track node memory tier details
>   mm/demotion: Drop memtier from memtype
>   mm/demotion: Update node_is_toptier to work with memory tiers
>   lib/nodemask: Optimize node_random for nodemask with single NUMA node
>
> Jagdish Gediya (1):
>   mm/demotion: Demote pages according to allocation fallback order
>
>  drivers/dax/kmem.c           |  42 ++-
>  include/linux/memory-tiers.h | 102 ++++++
>  include/linux/migrate.h      |  15 -
>  include/linux/mmzone.h       |   3 +
>  include/linux/node.h         |   5 -
>  include/linux/nodemask.h     |  15 +-
>  mm/Makefile                  |   1 +
>  mm/huge_memory.c             |   1 +
>  mm/memory-tiers.c            | 645 +++++++++++++++++++++++++++++++++++
>  mm/migrate.c                 | 453 +-----------------------
>  mm/mprotect.c                |   1 +
>  mm/vmscan.c                  |  59 +++-
>  mm/vmstat.c                  |   4 -
>  13 files changed, 849 insertions(+), 497 deletions(-)
>  create mode 100644 include/linux/memory-tiers.h
>  create mode 100644 mm/memory-tiers.c
>
> --
> 2.37.2
>
