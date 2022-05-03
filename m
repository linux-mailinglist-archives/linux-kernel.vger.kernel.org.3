Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE72C518CE6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 21:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241769AbiECTQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 15:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241749AbiECTQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 15:16:02 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5C03F8B8
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 12:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651605149; x=1683141149;
  h=message-id:subject:from:to:date:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=au8P1JHW90k0N+LFChH9TefW4Iia/a9oVWmfDOi2Aaw=;
  b=edqY/9b17xs3+zNPBb0mh3UFvsE2Ccgq7rdn7AvdpghtJWseD7zPxeKx
   bOwyU+toCCD+SoUW2lXvXpo6ZWuR7RKmDGOltLxxTuU6dpJrFiqhzJtmk
   JcGNHARzTHv8Su6tsDNJlkqJidt/z/Qv/D7wwuzbKpdsa/2F13NVmTPXz
   aNo7Xc99tDESwcGaFoQMY7S36dLpQHmI3JTrdYJt/AX7ebp8AsN+xuCzq
   oi5fngPsg6E7azvi2kmR1Ne3AADg6eMsNoG+9Ne7zUvNmsm9fjeVPABTL
   8DK1ZYzJI2V51eHErb2EfBp4kMhh7+qH8vNOSfgOHJKQQ19EQOGCTs8vd
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10336"; a="267443651"
X-IronPort-AV: E=Sophos;i="5.91,196,1647327600"; 
   d="scan'208";a="267443651"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 12:12:28 -0700
X-IronPort-AV: E=Sophos;i="5.91,196,1647327600"; 
   d="scan'208";a="562344288"
Received: from schen9-mobl.amr.corp.intel.com ([10.212.186.253])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 12:12:28 -0700
Message-ID: <1b6ab66587cfef8574f38cafdd1796daf2a92346.camel@linux.intel.com>
Subject: Re: RFC: Memory Tiering Kernel Interfaces
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Wei Xu <weixugc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
Date:   Tue, 03 May 2022 12:12:28 -0700
In-Reply-To: <CAAPL-u9sVx94ACSuCVN8V0tKp+AMxiY89cro0japtyB=xNfNBw@mail.gmail.com>
References: <CAAPL-u9sVx94ACSuCVN8V0tKp+AMxiY89cro0japtyB=xNfNBw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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

Thanks for making this proposal.  It has many of the elements needed
for the tiering support.

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
> 

I assume that the preferred list is auto-configured/initialized based on
NUMA distances.  Not sure why "allowed" list is only to the same demotion
tier?  For example, I think the default should be tier 0 should 
is allowed to demote to tier 1 and tier 2, not just to tier 1.  So if we
fail to demote to tier 1, we can demote to tier 2.  

Do you also expose the demotion preferred node and allowed
list via /sys/devices/system/node/memory_tiers, as you have done in the examples?

> Examples
> ========
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

Do we expect to later allow configuration of the demotion list explicitly?
Something like:

echo "demotion 0 1 1-3" > /sys/devices/system/node/memory_tiers

to set demotion list for node 0, where preferred demote node is 1, 
allowed demote node list is 1-3.

Thanks.

Tim


