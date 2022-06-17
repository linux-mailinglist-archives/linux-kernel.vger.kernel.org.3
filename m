Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC0654F5AF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 12:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381942AbiFQKlo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 17 Jun 2022 06:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381868AbiFQKlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 06:41:42 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408736B023
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 03:41:40 -0700 (PDT)
Received: from fraeml706-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LPb8w3WG6z687Rd;
        Fri, 17 Jun 2022 18:37:52 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml706-chm.china.huawei.com (10.206.15.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Fri, 17 Jun 2022 12:41:37 +0200
Received: from localhost (10.81.209.131) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2375.24; Fri, 17 Jun
 2022 11:41:36 +0100
Date:   Fri, 17 Jun 2022 11:41:32 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ying Huang <ying.huang@intel.com>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
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
Subject: Re: [PATCH v5 1/9] mm/demotion: Add support for explicit memory
 tiers
Message-ID: <20220617114132.00000e4b@Huawei.com>
In-Reply-To: <2b261518bbb5b8466301f8ab978f408141fa6e68.camel@intel.com>
References: <YqDncfLeEeBaosrY@cmpxchg.org>
        <02ee2c97-3bca-8eb6-97d8-1f8743619453@linux.ibm.com>
        <YqH74WaUzJlb+smt@cmpxchg.org>
        <20220609152243.00000332@Huawei.com>
        <YqJa4N/VlS4zN4vf@cmpxchg.org>
        <20220610105708.0000679b@Huawei.com>
        <YqdEEhJFr3SlfvSJ@cmpxchg.org>
        <4297bd21-e984-9d78-2bca-e70c11749a72@linux.ibm.com>
        <Yqdc4DE8gYJ3zesO@cmpxchg.org>
        <42f536af-b17d-b001-7b6b-2c6b928f3ecf@linux.ibm.com>
        <YqjZyP11O0yCMmiO@cmpxchg.org>
        <2b261518bbb5b8466301f8ab978f408141fa6e68.camel@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.81.209.131]
X-ClientProxiedBy: lhreml709-chm.china.huawei.com (10.201.108.58) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jun 2022 09:11:24 +0800
Ying Huang <ying.huang@intel.com> wrote:

> On Tue, 2022-06-14 at 14:56 -0400, Johannes Weiner wrote:
> > On Tue, Jun 14, 2022 at 01:31:37PM +0530, Aneesh Kumar K V wrote:  
> > > On 6/13/22 9:20 PM, Johannes Weiner wrote:  
> > > > On Mon, Jun 13, 2022 at 07:53:03PM +0530, Aneesh Kumar K V wrote:  
> > > > > If the kernel still can't make the right decision, userspace could rearrange
> > > > > them in any order using rank values. Without something like rank, if
> > > > > userspace needs to fix things up,  it gets hard with device
> > > > > hotplugging. ie, the userspace policy could be that any new PMEM tier device
> > > > > that is hotplugged, park it with a very low-rank value and hence lowest in
> > > > > demotion order by default. (echo 10 >
> > > > > /sys/devices/system/memtier/memtier2/rank) . After that userspace could
> > > > > selectively move the new devices to the correct memory tier?  
> > > > 
> > > > I had touched on this in the other email.
> > > > 
> > > > This doesn't work if two drivers that should have separate policies
> > > > collide into the same tier - which is very likely with just 3 tiers.
> > > > So it seems to me the main usecase for having a rank tunable falls
> > > > apart rather quickly until tiers are spaced out more widely. And it
> > > > does so at the cost of an, IMO, tricky to understand interface.
> > > >   
> > > 
> > > Considering the kernel has a static map for these tiers, how can two drivers
> > > end up using the same tier? If a new driver is going to manage a memory
> > > device that is of different characteristics than the one managed by dax/kmem,
> > > we will end up adding 
> > > 
> > > #define MEMORY_TIER_NEW_DEVICE 4
> > > 
> > > The new driver will never use MEMORY_TIER_PMEM
> > > 
> > > What can happen is two devices that are managed by DAX/kmem that
> > > should be in two memory tiers get assigned the same memory tier
> > > because the dax/kmem driver added both the device to the same memory tier.
> > > 
> > > In the future we would avoid that by using more device properties like HMAT
> > > to create additional memory tiers with different rank values. ie, we would
> > > do in the dax/kmem create_tier_from_rank() .  
> > 
> > Yes, that's the type of collision I mean. Two GPUs, two CXL-attached
> > DRAMs of different speeds etc.
> > 
> > I also like Huang's idea of using latency characteristics instead of
> > abstract distances. Though I'm not quite sure how feasible this is in
> > the short term, and share some concerns that Jonathan raised. But I
> > think a wider possible range to begin with makes sense in any case.
> >   
> > > > In the other email I had suggested the ability to override not just
> > > > the per-device distance, but also the driver default for new devices
> > > > to handle the hotplug situation.
> > > >   
> > > 
> > > I understand that the driver override will be done via module parameters.
> > > How will we implement device override? For example in case of dax/kmem driver
> > > the device override will be per dax device? What interface will we use to set the override?
> > > 
> > > IIUC in the above proposal the dax/kmem will do
> > > 
> > > node_create_and_set_memory_tier(numa_node, get_device_tier_index(dev_dax));
> > > 
> > > get_device_tier_index(struct dev_dax *dev)
> > > {
> > >     return dax_kmem_tier_index; // module parameter
> > > }
> > > 
> > > Are you suggesting to add a dev_dax property to override the tier defaults?  
> > 
> > I was thinking a new struct memdevice and struct memtype(?). Every
> > driver implementing memory devices like this sets those up and
> > registers them with generic code and preset parameters. The generic
> > code creates sysfs directories and allows overriding the parameters.
> > 
> > struct memdevice {
> > 	struct device dev;
> > 	unsigned long distance;
> > 	struct list_head siblings;
> > 	/* nid? ... */
> > };
> > 
> > struct memtype {
> > 	struct device_type type;
> > 	unsigned long default_distance;
> > 	struct list_head devices;
> > };
> > 
> > That forms the (tweakable) tree describing physical properties.  
> 
> In general, I think memtype is a good idea.  I have suggested
> something similar before.  It can describe the characters of a
> specific type of memory (same memory media with different interface
> (e.g., CXL, or DIMM) will be different memory types).  And they can
> be used to provide overriding information.
I'm not sure you are suggesting interface as one element of distinguishing
types, or as the element - just in case it's as 'the element'.
Ignore the next bit if not ;)

Memory "interface" isn't going to be enough of a distinction.  If you want to have
a default distance it would need to be different for cases where the
same 'type' of RAM has very different characteristics. Applies everywhere
but given CXL 'defines' a lot of this - if we just have DRAM attached
via CXL:

1. 16-lane direct attached DRAM device.  (low latency - high bw)
2. 4x 16-lane direct attached DRAM interleaved (low latency - very high bw)
3. 4-lane direct attached DRAM device (low latency - low bandwidth)
4. 16-lane to single switch, 4x 4-lane devices interleaved (mid latency - high bw)
5. 4-lane to single switch, 4x 4-lane devices interleaved (mid latency, mid bw)
6. 4x 16-lane so 4 switch, each switch to 4 DRAM devices (mid latency, very high bw)
(7. 16 land directed attached nvram. (midish latency, high bw - perf wise might be
    similarish to 4).

It could be a lot more complex, but hopefully that conveys that 'type'
is next to useless to characterize things unless we have a very large number
of potential subtypes. If we were on current tiering proposal
we'd just have the CXL subsystem manage multiple tiers to cover what is
attached.

> 
> As for memdevice, I think that we already have "node" to represent
> them in sysfs.  Do we really need another one?  Is it sufficient to
> add some links to node in the appropriate directory?  For example,
> make memtype class device under the physical device (e.g. CXL device),
> and create links to node inside the memtype class device directory?
> 
> > From that, the kernel then generates the ordered list of tiers.  
> 
> As Jonathan Cameron pointed, we may need the memory tier ID to be
> stable if possible.  I know this isn't a easy task.  At least we can
> make the default memory tier (CPU local DRAM) ID stable (for example
> make it always 128)?  That provides an anchor for users to understand.
> 
> Best Regards,
> Huang, Ying
> 
> > > > This should be less policy than before. Driver default and per-device
> > > > distances (both overridable) combined with one tunable to set the
> > > > range of distances that get grouped into tiers.
> > > >   
> > > 
> > > Can you elaborate more on how distance value will be used? The device/device NUMA node can have
> > > different distance value from other NUMA nodes. How do we group them?
> > > for ex: earlier discussion did outline three different topologies. Can you
> > > ellaborate how we would end up grouping them using distance?
> > > 
> > > For ex: in the topology below node 2 is at distance 30 from Node0 and 40 from Nodes
> > > so how will we classify node 2?
> > > 
> > > 
> > > Node 0 & 1 are DRAM nodes, node 2 & 3 are PMEM nodes.
> > > 
> > > 		  20
> > >   Node 0 (DRAM)  ----  Node 1 (DRAM)
> > >        |        \   /       |
> > >        | 30    40 X 40      | 30
> > >        |        /   \       |
> > >   Node 2 (PMEM)  ----  Node 3 (PMEM)
> > > 		  40
> > > 
> > > node distances:
> > > node   0    1    2    3
> > >    0  10   20   30   40
> > >    1  20   10   40   30
> > >    2  30   40   10   40
> > >    3  40   30   40   10  
> > 
> > I'm fairly confused by this example. Do all nodes have CPUs? Isn't
> > this just classic NUMA, where optimizing for locality makes the most
> > sense, rather than tiering?
> > 
> > Forget the interface for a second, I have no idea how tiering on such
> > a system would work. One CPU's lower tier can be another CPU's
> > toptier. There is no lowest rung from which to actually *reclaim*
> > pages. Would the CPUs just demote in circles?
> > 
> > And the coldest pages on one socket would get demoted into another
> > socket and displace what that socket considers hot local memory?
> > 
> > I feel like I missing something.
> > 
> > When we're talking about tiered memory, I'm thinking about CPUs
> > utilizing more than one memory node. If those other nodes have CPUs,
> > you can't reliably establish a singular tier order anymore and it
> > becomes classic NUMA, no?  
> 
> 

