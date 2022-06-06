Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA88753E0C0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 08:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbiFFFeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 01:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiFFFeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 01:34:10 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4961A18B25
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 22:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654493649; x=1686029649;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/SZSzFZ1dFhPPIgGw9fcoNgrT9yACgit2VivRF4SOag=;
  b=UfcPeV7O14q16dym74ZeewMoq/m29HcMG69QVZbRUsgWaXN5qiaDpvYz
   a5fM3jM2C8HeBmCA05rq37nr7pFnRIq8OZCJaW94qQBkN2b/njnn6ST6+
   OspgFvx+GFpiTKc9u2JgNLDNa4RIvBf1yCnkrHwhObcttDYqlwpNIGeIn
   aQYN7YVE2A1tLAfzZXtrlialBHRdTW36jM1j02uDKeuexPe2skZ8tFIYU
   O//HK5OaR7cHf47nlatJmpSq0/o3YLKnvIahGVdoHbqKxwe1KRsmKae5O
   iZh8ZoKOIa1esMNKY0sQAQjQlH00tDB4I0l6NIolKNg8wGYEZl+OXgYWo
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10369"; a="301985140"
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="301985140"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2022 22:34:09 -0700
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="635417555"
Received: from xingguom-mobl.ccr.corp.intel.com ([10.254.213.116])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2022 22:34:00 -0700
Message-ID: <143e40bcf46097d14514504518fdc1870fd8d4a1.camel@intel.com>
Subject: Re: [RFC PATCH v4 1/7] mm/demotion: Add support for explicit memory
 tiers
From:   Ying Huang <ying.huang@intel.com>
To:     Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
Cc:     Greg Thelen <gthelen@google.com>, Yang Shi <shy828301@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim C Chen <tim.c.chen@intel.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        David Rientjes <rientjes@google.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org
Date:   Mon, 06 Jun 2022 13:33:55 +0800
In-Reply-To: <d429a644-ef27-bcd8-52bd-c8cbe5fedc26@linux.ibm.com>
References: <CAAPL-u-dFp7PwPH6DfbYdnY8xaGsHz3tRQ0CPGVkiqURvdN8=A@mail.gmail.com>
         <20220527122528.129445-1-aneesh.kumar@linux.ibm.com>
         <20220527122528.129445-2-aneesh.kumar@linux.ibm.com>
         <352ae5f408b6d7d4d3d820d68e2f2c6b494e95e1.camel@intel.com>
         <aeced91ea9d9396e9842f5c0264391aabd291726.camel@intel.com>
         <d429a644-ef27-bcd8-52bd-c8cbe5fedc26@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-06-06 at 09:26 +0530, Aneesh Kumar K V wrote:
> On 6/6/22 8:19 AM, Ying Huang wrote:
> > On Thu, 2022-06-02 at 14:07 +0800, Ying Huang wrote:
> > > On Fri, 2022-05-27 at 17:55 +0530, Aneesh Kumar K.V wrote:
> > > > From: Jagdish Gediya <jvgediya@linux.ibm.com>
> > > > 
> > > > In the current kernel, memory tiers are defined implicitly via a
> > > > demotion path relationship between NUMA nodes, which is created
> > > > during the kernel initialization and updated when a NUMA node is
> > > > hot-added or hot-removed.  The current implementation puts all
> > > > nodes with CPU into the top tier, and builds the tier hierarchy
> > > > tier-by-tier by establishing the per-node demotion targets based
> > > > on the distances between nodes.
> > > > 
> > > > This current memory tier kernel interface needs to be improved for
> > > > several important use cases,
> > > > 
> > > > The current tier initialization code always initializes
> > > > each memory-only NUMA node into a lower tier.  But a memory-only
> > > > NUMA node may have a high performance memory device (e.g. a DRAM
> > > > device attached via CXL.mem or a DRAM-backed memory-only node on
> > > > a virtual machine) and should be put into a higher tier.
> > > > 
> > > > The current tier hierarchy always puts CPU nodes into the top
> > > > tier. But on a system with HBM or GPU devices, the
> > > > memory-only NUMA nodes mapping these devices should be in the
> > > > top tier, and DRAM nodes with CPUs are better to be placed into the
> > > > next lower tier.
> > > > 
> > > > With current kernel higher tier node can only be demoted to selected nodes on the
> > > > next lower tier as defined by the demotion path, not any other
> > > > node from any lower tier.  This strict, hard-coded demotion order
> > > > does not work in all use cases (e.g. some use cases may want to
> > > > allow cross-socket demotion to another node in the same demotion
> > > > tier as a fallback when the preferred demotion node is out of
> > > > space), This demotion order is also inconsistent with the page
> > > > allocation fallback order when all the nodes in a higher tier are
> > > > out of space: The page allocation can fall back to any node from
> > > > any lower tier, whereas the demotion order doesn't allow that.
> > > > 
> > > > The current kernel also don't provide any interfaces for the
> > > > userspace to learn about the memory tier hierarchy in order to
> > > > optimize its memory allocations.
> > > > 
> > > > This patch series address the above by defining memory tiers explicitly.
> > > > 
> > > > This patch adds below sysfs interface which is read-only and
> > > > can be used to read nodes available in specific tier.
> > > > 
> > > > /sys/devices/system/memtier/memtierN/nodelist
> > > > 
> > > > Tier 0 is the highest tier, while tier MAX_MEMORY_TIERS - 1 is the
> > > > lowest tier. The absolute value of a tier id number has no specific
> > > > meaning. what matters is the relative order of the tier id numbers.
> > > > 
> > > > All the tiered memory code is guarded by CONFIG_TIERED_MEMORY.
> > > > Default number of memory tiers are MAX_MEMORY_TIERS(3). All the
> > > > nodes are by default assigned to DEFAULT_MEMORY_TIER(1).
> > > > 
> > > > Default memory tier can be read from,
> > > > /sys/devices/system/memtier/default_tier
> > > > 
> > > > Max memory tier can be read from,
> > > > /sys/devices/system/memtier/max_tiers
> > > > 
> > > > This patch implements the RFC spec sent by Wei Xu <weixugc@google.com> at [1].
> > > > 
> > > > [1] https://lore.kernel.org/linux-mm/CAAPL-u-DGLcKRVDnChN9ZhxPkfxQvz9Sb93kVoX_4J2oiJSkUw@mail.gmail.com/
> > > > 
> > > > Signed-off-by: Jagdish Gediya <jvgediya@linux.ibm.com>
> > > > Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> > > 
> > > IMHO, we should change the kernel internal implementation firstly, then
> > > implement the kerne/user space interface.  That is, make memory tier
> > > explicit inside kernel, then expose it to user space.
> > 
> > Why ignore this comment for v5?  If you don't agree, please respond me.
> > 
> 
> I am not sure what benefit such a rearrange would bring in? Right now I 
> am writing the series from the point of view of introducing all the 
> plumbing and them switching the existing demotion logic to use the new 
> infrastructure. Redoing the code to hide all the userspace sysfs till we 
> switch the demotion logic to use the new infrastructure doesn't really 
> bring any additional clarity to patch review and would require me to 
> redo the series with a lot of conflicts across the patches in the patchset.

IMHO, we shouldn't introduce regression even in the middle of a
patchset.  Each step should only rely on previous patches in the series
to work correctly.  In your current way of organization, after patch
[1/7], on a system with 2 memory tiers, the user space interface will
output wrong information (only 1 memory tier).  So I think the correct
way is to make it right inside the kenrel firstly, then expose the right
information to user space.

Best Regards,
Huang, Ying

