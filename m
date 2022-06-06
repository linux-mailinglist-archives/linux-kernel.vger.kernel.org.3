Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 892B253E3D3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 10:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbiFFIyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 04:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231789AbiFFIxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 04:53:51 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F8B49F1E
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 01:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654505625; x=1686041625;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xMOKQ7MtJ7lXYmN8Z6cuSMfZ/K6LCwhMDoazTyfDpTU=;
  b=b0awr1S5Uh/JuLPt//O/LB1JO0c9YcNn4EROPKcR0P9DxLSeI8cU9lNi
   sJmHi/6eHr0+BWAfg7Aju3wLhYB+xbiHw9CuDcVIrDfw3b48jbATD/oVp
   Gb0+1t6hCjdzIi/4gydGezFUaJ+Pfs+XYmvsmduVmXUK7OCCkxi51VncE
   tWojar2UFtUpQtsWbW2loa03ObksXpEqwtERr6Mqi7zAws4C+suMlBA4z
   7R8vUCa7ePaLIdMEbzAcj0u2xlovqkvREyDYm6dE4HXHgP6cRqCFAf8Zy
   dR4ZCfNPyOhMHowCPlhHaQ7IME5nEe4X2vE2DUVqVLJr/QCokdfPhh+rA
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10369"; a="258890810"
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="258890810"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 01:53:09 -0700
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="635495180"
Received: from xingguom-mobl.ccr.corp.intel.com ([10.254.213.116])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 01:53:01 -0700
Message-ID: <d36eabfdc062aeb5aee18ab7ac0bca36b19f8521.camel@intel.com>
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
Date:   Mon, 06 Jun 2022 16:52:56 +0800
In-Reply-To: <b97d2013-ad5e-9b29-0b95-f52273bd3a8b@linux.ibm.com>
References: <CAAPL-u-dFp7PwPH6DfbYdnY8xaGsHz3tRQ0CPGVkiqURvdN8=A@mail.gmail.com>
         <20220527122528.129445-1-aneesh.kumar@linux.ibm.com>
         <20220527122528.129445-2-aneesh.kumar@linux.ibm.com>
         <352ae5f408b6d7d4d3d820d68e2f2c6b494e95e1.camel@intel.com>
         <aeced91ea9d9396e9842f5c0264391aabd291726.camel@intel.com>
         <d429a644-ef27-bcd8-52bd-c8cbe5fedc26@linux.ibm.com>
         <143e40bcf46097d14514504518fdc1870fd8d4a1.camel@intel.com>
         <eb6d7346-32a9-4fb2-61c2-a413c9f94f1c@linux.ibm.com>
         <87ilpe8fxh.fsf@linux.ibm.com>
         <a20f4db3c55f9471d27eacd7a8a245691a8fcd2f.camel@intel.com>
         <b97d2013-ad5e-9b29-0b95-f52273bd3a8b@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-06-06 at 13:31 +0530, Aneesh Kumar K V wrote:
> On 6/6/22 1:23 PM, Ying Huang wrote:
> > On Mon, 2022-06-06 at 11:57 +0530, Aneesh Kumar K.V wrote:
> > > Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> writes:
> > > 
> > > > On 6/6/22 11:03 AM, Ying Huang wrote:
> > > > > On Mon, 2022-06-06 at 09:26 +0530, Aneesh Kumar K V wrote:
> > > > > > On 6/6/22 8:19 AM, Ying Huang wrote:
> > > > > > > On Thu, 2022-06-02 at 14:07 +0800, Ying Huang wrote:
> > > > > > > > On Fri, 2022-05-27 at 17:55 +0530, Aneesh Kumar K.V wrote:
> > > > > > > > > From: Jagdish Gediya <jvgediya@linux.ibm.com>
> > > > > > > > > 
> > > > > > > > > In the current kernel, memory tiers are defined implicitly via a
> > > > > > > > > demotion path relationship between NUMA nodes, which is created
> > > > > > > > > during the kernel initialization and updated when a NUMA node is
> > > > > > > > > hot-added or hot-removed.  The current implementation puts all
> > > > > > > > > nodes with CPU into the top tier, and builds the tier hierarchy
> > > > > > > > > tier-by-tier by establishing the per-node demotion targets based
> > > > > > > > > on the distances between nodes.
> > > > > > > > > 
> > > > > > > > > This current memory tier kernel interface needs to be improved for
> > > > > > > > > several important use cases,
> > > > > > > > > 
> > > > > > > > > The current tier initialization code always initializes
> > > > > > > > > each memory-only NUMA node into a lower tier.  But a memory-only
> > > > > > > > > NUMA node may have a high performance memory device (e.g. a DRAM
> > > > > > > > > device attached via CXL.mem or a DRAM-backed memory-only node on
> > > > > > > > > a virtual machine) and should be put into a higher tier.
> > > > > > > > > 
> > > > > > > > > The current tier hierarchy always puts CPU nodes into the top
> > > > > > > > > tier. But on a system with HBM or GPU devices, the
> > > > > > > > > memory-only NUMA nodes mapping these devices should be in the
> > > > > > > > > top tier, and DRAM nodes with CPUs are better to be placed into the
> > > > > > > > > next lower tier.
> > > > > > > > > 
> > > > > > > > > With current kernel higher tier node can only be demoted to selected nodes on the
> > > > > > > > > next lower tier as defined by the demotion path, not any other
> > > > > > > > > node from any lower tier.  This strict, hard-coded demotion order
> > > > > > > > > does not work in all use cases (e.g. some use cases may want to
> > > > > > > > > allow cross-socket demotion to another node in the same demotion
> > > > > > > > > tier as a fallback when the preferred demotion node is out of
> > > > > > > > > space), This demotion order is also inconsistent with the page
> > > > > > > > > allocation fallback order when all the nodes in a higher tier are
> > > > > > > > > out of space: The page allocation can fall back to any node from
> > > > > > > > > any lower tier, whereas the demotion order doesn't allow that.
> > > > > > > > > 
> > > > > > > > > The current kernel also don't provide any interfaces for the
> > > > > > > > > userspace to learn about the memory tier hierarchy in order to
> > > > > > > > > optimize its memory allocations.
> > > > > > > > > 
> > > > > > > > > This patch series address the above by defining memory tiers explicitly.
> > > > > > > > > 
> > > > > > > > > This patch adds below sysfs interface which is read-only and
> > > > > > > > > can be used to read nodes available in specific tier.
> > > > > > > > > 
> > > > > > > > > /sys/devices/system/memtier/memtierN/nodelist
> > > > > > > > > 
> > > > > > > > > Tier 0 is the highest tier, while tier MAX_MEMORY_TIERS - 1 is the
> > > > > > > > > lowest tier. The absolute value of a tier id number has no specific
> > > > > > > > > meaning. what matters is the relative order of the tier id numbers.
> > > > > > > > > 
> > > > > > > > > All the tiered memory code is guarded by CONFIG_TIERED_MEMORY.
> > > > > > > > > Default number of memory tiers are MAX_MEMORY_TIERS(3). All the
> > > > > > > > > nodes are by default assigned to DEFAULT_MEMORY_TIER(1).
> > > > > > > > > 
> > > > > > > > > Default memory tier can be read from,
> > > > > > > > > /sys/devices/system/memtier/default_tier
> > > > > > > > > 
> > > > > > > > > Max memory tier can be read from,
> > > > > > > > > /sys/devices/system/memtier/max_tiers
> > > > > > > > > 
> > > > > > > > > This patch implements the RFC spec sent by Wei Xu <weixugc@google.com> at [1].
> > > > > > > > > 
> > > > > > > > > [1] https://lore.kernel.org/linux-mm/CAAPL-u-DGLcKRVDnChN9ZhxPkfxQvz9Sb93kVoX_4J2oiJSkUw@mail.gmail.com/
> > > > > > > > > 
> > > > > > > > > Signed-off-by: Jagdish Gediya <jvgediya@linux.ibm.com>
> > > > > > > > > Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> > > > > > > > 
> > > > > > > > IMHO, we should change the kernel internal implementation firstly, then
> > > > > > > > implement the kerne/user space interface.  That is, make memory tier
> > > > > > > > explicit inside kernel, then expose it to user space.
> > > > > > > 
> > > > > > > Why ignore this comment for v5?  If you don't agree, please respond me.
> > > > > > > 
> > > > > > 
> > > > > > I am not sure what benefit such a rearrange would bring in? Right now I
> > > > > > am writing the series from the point of view of introducing all the
> > > > > > plumbing and them switching the existing demotion logic to use the new
> > > > > > infrastructure. Redoing the code to hide all the userspace sysfs till we
> > > > > > switch the demotion logic to use the new infrastructure doesn't really
> > > > > > bring any additional clarity to patch review and would require me to
> > > > > > redo the series with a lot of conflicts across the patches in the patchset.
> > > > > 
> > > > > IMHO, we shouldn't introduce regression even in the middle of a
> > > > > patchset.  Each step should only rely on previous patches in the series
> > > > > to work correctly.  In your current way of organization, after patch
> > > > > [1/7], on a system with 2 memory tiers, the user space interface will
> > > > > output wrong information (only 1 memory tier).  So I think the correct
> > > > > way is to make it right inside the kenrel firstly, then expose the right
> > > > > information to user space.
> > > > > 
> > > > 
> > > > The patchset doesn't add additional tier until "mm/demotion/dax/kmem:
> > > > Set node's memory tier to MEMORY_TIER_PMEM". ie, there is no additional
> > > > tiers done till all the demotion logic is in place. So even if the
> > > > system got dax/kmem, the support for adding dax/kmem as a memory tier
> > > > comes later in the patch series.
> > > 
> > > Let me clarify this a bit more. This patchset doesn't change the
> > > existing kernel behavior till "mm/demotion: Build demotion targets
> > > based on explicit memory tiers". So there is no regression till then.
> > > It adds a parallel framework (memory tiers to the existing demotion
> > > logic).
> > > 
> > > I can move the patch "mm/demotion/dax/kmem: Set node's memory tier to
> > > MEMORY_TIER_PMEM" before switching the demotion logic so that on systems
> > > with two memory tiers (DRAM and pmem) the demotion continues to work
> > > as expected after patch 3 ("mm/demotion: Build demotion targets based on
> > > explicit memory tiers"). With that, there will not be any regression in
> > > between the patch series.
> > > 
> > 
> > Thanks!  Please do that.  And I think you can add sysfs interface after
> > that patch too.  That is, in [1/7]
> > 
> 
> I am not sure why you insist on moving sysfs interfaces later. They are 
> introduced based on the helper added. It make patch review easier to 
> look at both the helpers and the user of the helper together in a patch.

Yes.  We should introduce a function and its user in one patch for
review.  But this doesn't mean that we should introduce the user space
interface as the first step.  I think the user space interface should
output correct information when we expose it.

> > +struct memory_tier {
> > +	nodemask_t nodelist;
> > +};
> > 
> > And struct device can be added after the kernel has switched the
> > implementation based on explicit memory tiers.
> > 
> > +struct memory_tier {
> > +	struct device dev;
> > +	nodemask_t nodelist;
> > +};
> > 
> 
> 
> Can you elaborate on this? or possibly review the v5 series indicating 
> what change you are suggesting here?
> 
> 
> > But I don't think it's a good idea to have "struct device" embedded in
> > "struct memory_tier".  We don't have "struct device" embedded in "struct
> > pgdata_list"...
> > 
> 
> I avoided creating an array for memory_tier (memory_tier[]) so that we 
> can keep it dynamic. Keeping dev embedded in struct memory_tier simplify 
> the life cycle management of that dynamic list. We free the struct 
> memory_tier allocation via device release function (memtier->dev.release 
> = memory_tier_device_release )
> 
> Why do you think it is not a good idea?

I think that we shouldn't bind our kernel internal implementation with
user space interface too much.  Yes.  We can expose kernel internal
implementation to user space in a direct way.  I suggest you to follow
the style of "struct pglist_data" and "struct node".  If we decouple
"struct memory_tier" and "struct memory_tier_dev" (or some other name),
we can refer to "struct memory_tier" without depending on all device
core.  Memory tier should be accessible inside the kernel even without a
user interface.  And memory tier isn't a device in concept.

For life cycle management, I think that we can do that without sysfs
too.

Best Regards,
Huang, Ying



