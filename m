Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDE0554D6CD
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 03:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348604AbiFPBLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 21:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245094AbiFPBLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 21:11:35 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 350243DA43
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 18:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655341891; x=1686877891;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+QIkip5gbWqgZibXqlEIGq7H8C0Cv7cvRNlpFbL7qJU=;
  b=OeSIdTLAg2Zrx26AqzSQYnfT29y1JFl/kA/4dIkGnAGLYuXX8frDapvY
   kIsUFLKXQSADeXTcgchBN2EDkvKwAQgjidBim/KlXCCrgQNV+NZhFqsoM
   s9YM+PMc4aE1FNYYefRLkEKc6g74080MU/OgY76Hf7STyYajn0gyY0PP3
   /ucUcmNPi33MyOzVeuhYviZyCUeuGcdQEPfX7MaUVjIKz39QRaVQ9IO4a
   AyvIriJzpwYIqPsUzs6I1uDqPoGHRS+PRzkz6Dpxk0rJE901GT9/Gb2Sa
   iRpAJA90w1AmHVGWFGmrkA72L4BYxYuuIcmmX7LDbrOxcMlKvHHAC9bL7
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10379"; a="276711936"
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="276711936"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 18:11:31 -0700
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="911937247"
Received: from junyizh1-mobl.ccr.corp.intel.com ([10.254.214.95])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 18:11:26 -0700
Message-ID: <2b261518bbb5b8466301f8ab978f408141fa6e68.camel@intel.com>
Subject: Re: [PATCH v5 1/9] mm/demotion: Add support for explicit memory
 tiers
From:   Ying Huang <ying.huang@intel.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org, Wei Xu <weixugc@google.com>,
        Greg Thelen <gthelen@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim C Chen <tim.c.chen@intel.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        David Rientjes <rientjes@google.com>
Date:   Thu, 16 Jun 2022 09:11:24 +0800
In-Reply-To: <YqjZyP11O0yCMmiO@cmpxchg.org>
References: <YqDncfLeEeBaosrY@cmpxchg.org>
         <02ee2c97-3bca-8eb6-97d8-1f8743619453@linux.ibm.com>
         <YqH74WaUzJlb+smt@cmpxchg.org> <20220609152243.00000332@Huawei.com>
         <YqJa4N/VlS4zN4vf@cmpxchg.org> <20220610105708.0000679b@Huawei.com>
         <YqdEEhJFr3SlfvSJ@cmpxchg.org>
         <4297bd21-e984-9d78-2bca-e70c11749a72@linux.ibm.com>
         <Yqdc4DE8gYJ3zesO@cmpxchg.org>
         <42f536af-b17d-b001-7b6b-2c6b928f3ecf@linux.ibm.com>
         <YqjZyP11O0yCMmiO@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-06-14 at 14:56 -0400, Johannes Weiner wrote:
> On Tue, Jun 14, 2022 at 01:31:37PM +0530, Aneesh Kumar K V wrote:
> > On 6/13/22 9:20 PM, Johannes Weiner wrote:
> > > On Mon, Jun 13, 2022 at 07:53:03PM +0530, Aneesh Kumar K V wrote:
> > > > If the kernel still can't make the right decision, userspace could rearrange
> > > > them in any order using rank values. Without something like rank, if
> > > > userspace needs to fix things up,  it gets hard with device
> > > > hotplugging. ie, the userspace policy could be that any new PMEM tier device
> > > > that is hotplugged, park it with a very low-rank value and hence lowest in
> > > > demotion order by default. (echo 10 >
> > > > /sys/devices/system/memtier/memtier2/rank) . After that userspace could
> > > > selectively move the new devices to the correct memory tier?
> > > 
> > > I had touched on this in the other email.
> > > 
> > > This doesn't work if two drivers that should have separate policies
> > > collide into the same tier - which is very likely with just 3 tiers.
> > > So it seems to me the main usecase for having a rank tunable falls
> > > apart rather quickly until tiers are spaced out more widely. And it
> > > does so at the cost of an, IMO, tricky to understand interface.
> > > 
> > 
> > Considering the kernel has a static map for these tiers, how can two drivers
> > end up using the same tier? If a new driver is going to manage a memory
> > device that is of different characteristics than the one managed by dax/kmem,
> > we will end up adding 
> > 
> > #define MEMORY_TIER_NEW_DEVICE 4
> > 
> > The new driver will never use MEMORY_TIER_PMEM
> > 
> > What can happen is two devices that are managed by DAX/kmem that
> > should be in two memory tiers get assigned the same memory tier
> > because the dax/kmem driver added both the device to the same memory tier.
> > 
> > In the future we would avoid that by using more device properties like HMAT
> > to create additional memory tiers with different rank values. ie, we would
> > do in the dax/kmem create_tier_from_rank() .
> 
> Yes, that's the type of collision I mean. Two GPUs, two CXL-attached
> DRAMs of different speeds etc.
> 
> I also like Huang's idea of using latency characteristics instead of
> abstract distances. Though I'm not quite sure how feasible this is in
> the short term, and share some concerns that Jonathan raised. But I
> think a wider possible range to begin with makes sense in any case.
> 
> > > In the other email I had suggested the ability to override not just
> > > the per-device distance, but also the driver default for new devices
> > > to handle the hotplug situation.
> > > 
> > 
> > I understand that the driver override will be done via module parameters.
> > How will we implement device override? For example in case of dax/kmem driver
> > the device override will be per dax device? What interface will we use to set the override?
> > 
> > IIUC in the above proposal the dax/kmem will do
> > 
> > node_create_and_set_memory_tier(numa_node, get_device_tier_index(dev_dax));
> > 
> > get_device_tier_index(struct dev_dax *dev)
> > {
> >     return dax_kmem_tier_index; // module parameter
> > }
> > 
> > Are you suggesting to add a dev_dax property to override the tier defaults?
> 
> I was thinking a new struct memdevice and struct memtype(?). Every
> driver implementing memory devices like this sets those up and
> registers them with generic code and preset parameters. The generic
> code creates sysfs directories and allows overriding the parameters.
> 
> struct memdevice {
> 	struct device dev;
> 	unsigned long distance;
> 	struct list_head siblings;
> 	/* nid? ... */
> };
> 
> struct memtype {
> 	struct device_type type;
> 	unsigned long default_distance;
> 	struct list_head devices;
> };
> 
> That forms the (tweakable) tree describing physical properties.

In general, I think memtype is a good idea.  I have suggested
something similar before.  It can describe the characters of a
specific type of memory (same memory media with different interface
(e.g., CXL, or DIMM) will be different memory types).  And they can
be used to provide overriding information.

As for memdevice, I think that we already have "node" to represent
them in sysfs.  Do we really need another one?  Is it sufficient to
add some links to node in the appropriate directory?  For example,
make memtype class device under the physical device (e.g. CXL device),
and create links to node inside the memtype class device directory?

> From that, the kernel then generates the ordered list of tiers.

As Jonathan Cameron pointed, we may need the memory tier ID to be
stable if possible.  I know this isn't a easy task.  At least we can
make the default memory tier (CPU local DRAM) ID stable (for example
make it always 128)?  That provides an anchor for users to understand.

Best Regards,
Huang, Ying

> > > This should be less policy than before. Driver default and per-device
> > > distances (both overridable) combined with one tunable to set the
> > > range of distances that get grouped into tiers.
> > > 
> > 
> > Can you elaborate more on how distance value will be used? The device/device NUMA node can have
> > different distance value from other NUMA nodes. How do we group them?
> > for ex: earlier discussion did outline three different topologies. Can you
> > ellaborate how we would end up grouping them using distance?
> > 
> > For ex: in the topology below node 2 is at distance 30 from Node0 and 40 from Nodes
> > so how will we classify node 2?
> > 
> > 
> > Node 0 & 1 are DRAM nodes, node 2 & 3 are PMEM nodes.
> > 
> > 		  20
> >   Node 0 (DRAM)  ----  Node 1 (DRAM)
> >        |        \   /       |
> >        | 30    40 X 40      | 30
> >        |        /   \       |
> >   Node 2 (PMEM)  ----  Node 3 (PMEM)
> > 		  40
> > 
> > node distances:
> > node   0    1    2    3
> >    0  10   20   30   40
> >    1  20   10   40   30
> >    2  30   40   10   40
> >    3  40   30   40   10
> 
> I'm fairly confused by this example. Do all nodes have CPUs? Isn't
> this just classic NUMA, where optimizing for locality makes the most
> sense, rather than tiering?
> 
> Forget the interface for a second, I have no idea how tiering on such
> a system would work. One CPU's lower tier can be another CPU's
> toptier. There is no lowest rung from which to actually *reclaim*
> pages. Would the CPUs just demote in circles?
> 
> And the coldest pages on one socket would get demoted into another
> socket and displace what that socket considers hot local memory?
> 
> I feel like I missing something.
> 
> When we're talking about tiered memory, I'm thinking about CPUs
> utilizing more than one memory node. If those other nodes have CPUs,
> you can't reliably establish a singular tier order anymore and it
> becomes classic NUMA, no?


