Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68466550E72
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 03:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237536AbiFTBzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 21:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236741AbiFTBzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 21:55:00 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65242B495
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 18:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655690099; x=1687226099;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=O3RtCrbFnVC0HPnibVXRT8LTRcN/4EUzb3joHdjUHwY=;
  b=ZadYlwEN8rRfy7wakgQ97f9NZmwPpYsGq/gak/dE8yEJD5b5ebsvADfN
   GSbC/i5jSJYe/bCLSARegzG/1U3lFTA2Jia4eGklgDyhSTsmU+syuNM8z
   Gxs+kAF4ebFx1dbQzkhcZG4rkYwp4kyNQc2PP+XVHgK6z+rTTXPXSalnT
   blH4fF66ed+AjF5/qBFFHhc0YvIUHxq2/Oll2qtdVAmpjadxMsBpbp5Qp
   +njUpEZkSlMl7HOgeSu9ksPLQQ+8F/eih+vQdgdEh+GHNPv1NtIxJ1RtN
   jIyiNVE8lPgXE9ZDM5SOEgE41023z4ckMvQNcA+2rNZAcnlNVyo9lGZqL
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="268500152"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="268500152"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2022 18:54:58 -0700
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="832885368"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.94])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2022 18:54:54 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>,
        <linux-mm@kvack.org>, <akpm@linux-foundation.org>,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim C Chen <tim.c.chen@intel.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Alistair Popple" <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Feng Tang" <feng.tang@intel.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        "Baolin Wang" <baolin.wang@linux.alibaba.com>,
        David Rientjes <rientjes@google.com>
Subject: Re: [PATCH v5 1/9] mm/demotion: Add support for explicit memory tiers
In-Reply-To: <20220617114132.00000e4b@Huawei.com> (Jonathan Cameron's message
        of "Fri, 17 Jun 2022 11:41:32 +0100")
References: <YqDncfLeEeBaosrY@cmpxchg.org>
        <02ee2c97-3bca-8eb6-97d8-1f8743619453@linux.ibm.com>
        <YqH74WaUzJlb+smt@cmpxchg.org> <20220609152243.00000332@Huawei.com>
        <YqJa4N/VlS4zN4vf@cmpxchg.org> <20220610105708.0000679b@Huawei.com>
        <YqdEEhJFr3SlfvSJ@cmpxchg.org>
        <4297bd21-e984-9d78-2bca-e70c11749a72@linux.ibm.com>
        <Yqdc4DE8gYJ3zesO@cmpxchg.org>
        <42f536af-b17d-b001-7b6b-2c6b928f3ecf@linux.ibm.com>
        <YqjZyP11O0yCMmiO@cmpxchg.org>
        <2b261518bbb5b8466301f8ab978f408141fa6e68.camel@intel.com>
        <20220617114132.00000e4b@Huawei.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Date:   Mon, 20 Jun 2022 09:54:47 +0800
Message-ID: <87mte8umjc.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Cameron <Jonathan.Cameron@Huawei.com> writes:

> On Thu, 16 Jun 2022 09:11:24 +0800
> Ying Huang <ying.huang@intel.com> wrote:
>
>> On Tue, 2022-06-14 at 14:56 -0400, Johannes Weiner wrote:
>> > On Tue, Jun 14, 2022 at 01:31:37PM +0530, Aneesh Kumar K V wrote:  
>> > > On 6/13/22 9:20 PM, Johannes Weiner wrote:  
>> > > > On Mon, Jun 13, 2022 at 07:53:03PM +0530, Aneesh Kumar K V wrote:  
>> > > > > If the kernel still can't make the right decision, userspace could rearrange
>> > > > > them in any order using rank values. Without something like rank, if
>> > > > > userspace needs to fix things up,  it gets hard with device
>> > > > > hotplugging. ie, the userspace policy could be that any new PMEM tier device
>> > > > > that is hotplugged, park it with a very low-rank value and hence lowest in
>> > > > > demotion order by default. (echo 10 >
>> > > > > /sys/devices/system/memtier/memtier2/rank) . After that userspace could
>> > > > > selectively move the new devices to the correct memory tier?  
>> > > > 
>> > > > I had touched on this in the other email.
>> > > > 
>> > > > This doesn't work if two drivers that should have separate policies
>> > > > collide into the same tier - which is very likely with just 3 tiers.
>> > > > So it seems to me the main usecase for having a rank tunable falls
>> > > > apart rather quickly until tiers are spaced out more widely. And it
>> > > > does so at the cost of an, IMO, tricky to understand interface.
>> > > >   
>> > > 
>> > > Considering the kernel has a static map for these tiers, how can two drivers
>> > > end up using the same tier? If a new driver is going to manage a memory
>> > > device that is of different characteristics than the one managed by dax/kmem,
>> > > we will end up adding 
>> > > 
>> > > #define MEMORY_TIER_NEW_DEVICE 4
>> > > 
>> > > The new driver will never use MEMORY_TIER_PMEM
>> > > 
>> > > What can happen is two devices that are managed by DAX/kmem that
>> > > should be in two memory tiers get assigned the same memory tier
>> > > because the dax/kmem driver added both the device to the same memory tier.
>> > > 
>> > > In the future we would avoid that by using more device properties like HMAT
>> > > to create additional memory tiers with different rank values. ie, we would
>> > > do in the dax/kmem create_tier_from_rank() .  
>> > 
>> > Yes, that's the type of collision I mean. Two GPUs, two CXL-attached
>> > DRAMs of different speeds etc.
>> > 
>> > I also like Huang's idea of using latency characteristics instead of
>> > abstract distances. Though I'm not quite sure how feasible this is in
>> > the short term, and share some concerns that Jonathan raised. But I
>> > think a wider possible range to begin with makes sense in any case.
>> >   
>> > > > In the other email I had suggested the ability to override not just
>> > > > the per-device distance, but also the driver default for new devices
>> > > > to handle the hotplug situation.
>> > > >   
>> > > 
>> > > I understand that the driver override will be done via module parameters.
>> > > How will we implement device override? For example in case of dax/kmem driver
>> > > the device override will be per dax device? What interface will we use to set the override?
>> > > 
>> > > IIUC in the above proposal the dax/kmem will do
>> > > 
>> > > node_create_and_set_memory_tier(numa_node, get_device_tier_index(dev_dax));
>> > > 
>> > > get_device_tier_index(struct dev_dax *dev)
>> > > {
>> > >  return dax_kmem_tier_index; // module parameter
>> > > }
>> > > 
>> > > Are you suggesting to add a dev_dax property to override the tier defaults?  
>> > 
>> > I was thinking a new struct memdevice and struct memtype(?). Every
>> > driver implementing memory devices like this sets those up and
>> > registers them with generic code and preset parameters. The generic
>> > code creates sysfs directories and allows overriding the parameters.
>> > 
>> > struct memdevice {
>> > 	struct device dev;
>> > 	unsigned long distance;
>> > 	struct list_head siblings;
>> > 	/* nid? ... */
>> > };
>> > 
>> > struct memtype {
>> > 	struct device_type type;
>> > 	unsigned long default_distance;
>> > 	struct list_head devices;
>> > };
>> > 
>> > That forms the (tweakable) tree describing physical properties.  
>> 
>> In general, I think memtype is a good idea.  I have suggested
>> something similar before.  It can describe the characters of a
>> specific type of memory (same memory media with different interface
>> (e.g., CXL, or DIMM) will be different memory types).  And they can
>> be used to provide overriding information.
> I'm not sure you are suggesting interface as one element of distinguishing
> types, or as the element - just in case it's as 'the element'.
> Ignore the next bit if not ;)
>
> Memory "interface" isn't going to be enough of a distinction.  If you want to have
> a default distance it would need to be different for cases where the
> same 'type' of RAM has very different characteristics. Applies everywhere
> but given CXL 'defines' a lot of this - if we just have DRAM attached
> via CXL:
>
> 1. 16-lane direct attached DRAM device.  (low latency - high bw)
> 2. 4x 16-lane direct attached DRAM interleaved (low latency - very high bw)
> 3. 4-lane direct attached DRAM device (low latency - low bandwidth)
> 4. 16-lane to single switch, 4x 4-lane devices interleaved (mid latency - high bw)
> 5. 4-lane to single switch, 4x 4-lane devices interleaved (mid latency, mid bw)
> 6. 4x 16-lane so 4 switch, each switch to 4 DRAM devices (mid latency, very high bw)
> (7. 16 land directed attached nvram. (midish latency, high bw - perf wise might be
>     similarish to 4).
>
> It could be a lot more complex, but hopefully that conveys that 'type'
> is next to useless to characterize things unless we have a very large number
> of potential subtypes. If we were on current tiering proposal
> we'd just have the CXL subsystem manage multiple tiers to cover what is
> attached.

Thanks for detailed explanation.  I learned a lot from you.  Yes,
interface itself isn't enough to character the memory devices.  We need
more fine-grained way to do that.  But anyway, I think that it's better
to identify this via BIOS or kernel instead of user space.

So the kernel drivers will

- group the memory devices enumerated into memory types

- provide latency/bandwidth or distance information for each memory type

Then user space may determine the policy via adjusting the
latency/bandwidth or distance and/or the tiering granularity.

Best Regards,
Huang, Ying

>> 
>> As for memdevice, I think that we already have "node" to represent
>> them in sysfs.  Do we really need another one?  Is it sufficient to
>> add some links to node in the appropriate directory?  For example,
>> make memtype class device under the physical device (e.g. CXL device),
>> and create links to node inside the memtype class device directory?
>> 
>> > From that, the kernel then generates the ordered list of tiers.  
>> 
>> As Jonathan Cameron pointed, we may need the memory tier ID to be
>> stable if possible.  I know this isn't a easy task.  At least we can
>> make the default memory tier (CPU local DRAM) ID stable (for example
>> make it always 128)?  That provides an anchor for users to understand.
>> 
>> Best Regards,
>> Huang, Ying
>> 
>> > > > This should be less policy than before. Driver default and per-device
>> > > > distances (both overridable) combined with one tunable to set the
>> > > > range of distances that get grouped into tiers.
>> > > >   
>> > > 
>> > > Can you elaborate more on how distance value will be used? The device/device NUMA node can have
>> > > different distance value from other NUMA nodes. How do we group them?
>> > > for ex: earlier discussion did outline three different topologies. Can you
>> > > ellaborate how we would end up grouping them using distance?
>> > > 
>> > > For ex: in the topology below node 2 is at distance 30 from Node0 and 40 from Nodes
>> > > so how will we classify node 2?
>> > > 
>> > > 
>> > > Node 0 & 1 are DRAM nodes, node 2 & 3 are PMEM nodes.
>> > > 
>> > > 		  20
>> > > Node 0 (DRAM)  ----  Node 1 (DRAM)
>> > >  |        \   /       |
>> > >  | 30    40 X 40      | 30
>> > >  |        /   \       |
>> > > Node 2 (PMEM)  ----  Node 3 (PMEM)
>> > > 		  40
>> > > 
>> > > node distances:
>> > > node   0    1    2    3
>> > > 0  10   20   30   40
>> > > 1  20   10   40   30
>> > > 2  30   40   10   40
>> > > 3  40   30   40   10  
>> > 
>> > I'm fairly confused by this example. Do all nodes have CPUs? Isn't
>> > this just classic NUMA, where optimizing for locality makes the most
>> > sense, rather than tiering?
>> > 
>> > Forget the interface for a second, I have no idea how tiering on such
>> > a system would work. One CPU's lower tier can be another CPU's
>> > toptier. There is no lowest rung from which to actually *reclaim*
>> > pages. Would the CPUs just demote in circles?
>> > 
>> > And the coldest pages on one socket would get demoted into another
>> > socket and displace what that socket considers hot local memory?
>> > 
>> > I feel like I missing something.
>> > 
>> > When we're talking about tiered memory, I'm thinking about CPUs
>> > utilizing more than one memory node. If those other nodes have CPUs,
>> > you can't reliably establish a singular tier order anymore and it
>> > becomes classic NUMA, no?  
>> 
>> 
