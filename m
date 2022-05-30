Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C96A6537AB4
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 14:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236162AbiE3MhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 08:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232599AbiE3MhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 08:37:04 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F129E50476
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 05:37:02 -0700 (PDT)
Received: from fraeml734-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LBZdn6wwXz67LR8;
        Mon, 30 May 2022 20:36:13 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml734-chm.china.huawei.com (10.206.15.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 30 May 2022 14:37:00 +0200
Received: from localhost (10.81.211.14) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 30 May
 2022 13:36:59 +0100
Date:   Mon, 30 May 2022 13:36:57 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
CC:     <linux-mm@kvack.org>, <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>,
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
Subject: Re: [RFC PATCH v4 5/7] mm/demotion: Add support to associate rank
 with memory tier
Message-ID: <20220530133657.00001164@Huawei.com>
In-Reply-To: <37d91345-306d-e308-61c1-50e0d76992c0@linux.ibm.com>
References: <CAAPL-u-dFp7PwPH6DfbYdnY8xaGsHz3tRQ0CPGVkiqURvdN8=A@mail.gmail.com>
        <20220527122528.129445-1-aneesh.kumar@linux.ibm.com>
        <20220527122528.129445-6-aneesh.kumar@linux.ibm.com>
        <20220527154557.00002c56@Huawei.com>
        <37d91345-306d-e308-61c1-50e0d76992c0@linux.ibm.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.211.14]
X-ClientProxiedBy: lhreml732-chm.china.huawei.com (10.201.108.83) To
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

On Fri, 27 May 2022 21:15:09 +0530
Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> wrote:

> On 5/27/22 8:15 PM, Jonathan Cameron wrote:
> > On Fri, 27 May 2022 17:55:26 +0530
> > "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> wrote:
> >   
> >> The rank approach allows us to keep memory tier device IDs stable even if there
> >> is a need to change the tier ordering among different memory tiers. e.g. DRAM
> >> nodes with CPUs will always be on memtier1, no matter how many tiers are higher
> >> or lower than these nodes. A new memory tier can be inserted into the tier
> >> hierarchy for a new set of nodes without affecting the node assignment of any
> >> existing memtier, provided that there is enough gap in the rank values for the
> >> new memtier.
> >>
> >> The absolute value of "rank" of a memtier doesn't necessarily carry any meaning.
> >> Its value relative to other memtiers decides the level of this memtier in the tier
> >> hierarchy.
> >>
> >> For now, This patch supports hardcoded rank values which are 100, 200, & 300 for
> >> memory tiers 0,1 & 2 respectively.
> >>
> >> Below is the sysfs interface to read the rank values of memory tier,
> >> /sys/devices/system/memtier/memtierN/rank
> >>
> >> This interface is read only for now, write support can be added when there is
> >> a need of flexibility of more number of memory tiers(> 3) with flexibile ordering
> >> requirement among them, rank can be utilized there as rank decides now memory
> >> tiering ordering and not memory tier device ids.
> >>
> >> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>  
> > 
> > I'd squash a lot of this with the original patch introducing tiers. As things
> > stand we have 2 tricky to follow patches covering the same code rather than
> > one that would be simpler.
> >   
> 
> Sure. Will do that in the next update.
> 
> > Jonathan
> >   
> >> ---
> >>   drivers/base/node.c     |   5 +-
> >>   drivers/dax/kmem.c      |   2 +-
> >>   include/linux/migrate.h |  17 ++--
> >>   mm/migrate.c            | 218 ++++++++++++++++++++++++----------------
> >>   4 files changed, 144 insertions(+), 98 deletions(-)
> >>
> >> diff --git a/drivers/base/node.c b/drivers/base/node.c
> >> index cf4a58446d8c..892f7c23c94e 100644
> >> --- a/drivers/base/node.c
> >> +++ b/drivers/base/node.c
> >> @@ -567,8 +567,11 @@ static ssize_t memtier_show(struct device *dev,
> >>   			    char *buf)
> >>   {
> >>   	int node = dev->id;
> >> +	int tier_index = node_get_memory_tier_id(node);
> >>   
> >> -	return sysfs_emit(buf, "%d\n", node_get_memory_tier(node));
> >> +	if (tier_index != -1)
> >> +		return sysfs_emit(buf, "%d\n", tier_index);  
> > I think failure to get a tier is an error. So if it happens, return an error code.
> > Also prefered to handle errors out of line as more idiomatic so reviewers
> > read it quicker.
> > 
> > 	if (tier_index == -1)
> > 		return -EINVAL;
> > 
> > 	return sysfs_emit()...
> >   
> >> +	return 0;
> >>   }
> >>     
> 
> 
> That was needed to handle NUMA nodes that is not part of any memory 
> tiers, like CPU only NUMA node or NUMA node that doesn't want to 
> participate in memory demotion.
> 
> 
> 
> >>   static ssize_t memtier_store(struct device *dev,
> >> diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
> >> index 991782aa2448..79953426ddaf 100644
> >> --- a/drivers/dax/kmem.c
> >> +++ b/drivers/dax/kmem.c
> >> @@ -149,7 +149,7 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
> >>   	dev_set_drvdata(dev, data);
> >>     
> 
> 
> ...
> 
> >>   
> >> -static DEVICE_ATTR_RO(default_tier);
> >> +static DEVICE_ATTR_RO(default_rank);
> >>   
> >>   static struct attribute *memoty_tier_attrs[] = {
> >> -	&dev_attr_max_tiers.attr,
> >> -	&dev_attr_default_tier.attr,
> >> +	&dev_attr_max_tier.attr,
> >> +	&dev_attr_default_rank.attr,  
> > 
> > hmm. Not sure why rename to tier rather than tiers.
> > 
> > Also, I think we default should be tier, not rank.  If someone later
> > wants to change the rank of tier1 that's up to them, but any new hotplugged
> > memory should still end up in their by default.
> >   
> 
> Didn't we say, the tier index/device id is a meaning less entity that 
> control just the naming. ie, for memtier128, 128 doesn't mean anything.

> Instead it is the rank value associated with memtier128 that control the 
> demotion order? If so what we want to update the userspace is max tier 
> index userspace can expect and what is the default rank value to which 
> memory will be added by hotplug.

Sort of.  I think we want default to refer to a particular tier, probably
at all times, thus allowing the administrator to potentially change what the
rank of that default group is for everything currently in it and anything
added later.  So I would keep the default as pointing to a particular
tier. This also reflect the earlier discussion about having multiple tiers
with the same rank. I would allow that as it makes for a cleaner interface
if we make rank writeable in the future. If that happens, what does
default rank mean? Which of the the tiers is used?

For other cases, rank is the value that matters for ordering but the particular
tier is what a driver etc uses.

The reason being to allow an admin to change the rank of (for example)
all GPU memory, such that it affects the GPU memory already present and
any added in the future (rather than a new tier being created with whatever
the GPU driver thinks the rank should be).  The way I think about this
means that default should be the same - tied to a particular tier, not
a particular rank.  If software wants the current rank of the default tier
then it can go look it up in the tier. 

> 
> But yes. tierindex 1 and default rank 200 are reserved and created by 
> default.
> 
> 
> ....
> 
> >>   	/*
> >>   	 * if node is already part of the tier proceed with the
> >>   	 * current tier value, because we might want to establish
> >> @@ -2411,15 +2452,17 @@ int node_set_memory_tier(int node, int tier)
> >>   	 * before it was made part of N_MEMORY, hence estabilish_migration_targets
> >>   	 * will have skipped this node.
> >>   	 */
> >> -	if (current_tier != -1)
> >> -		tier = current_tier;
> >> -	ret = __node_set_memory_tier(node, tier);
> >> +	if (memtier)
> >> +		establish_migration_targets();
> >> +	else {
> >> +		/* For now rank value and tier value is same. */  
> > 
> > We should avoid baking that in...  
> 
> 
> Making it dynamic adds lots of complexity such as an ida alloc for tier 
> index etc. I didn't want to get there unless we are sure we need dynamic 
> number of tiers.

Agreed it's more complex (though not very).  I'm just suggesting dropping
the comment.

If it were me, I'd make tier0 the default with the mid rank. Then tier1
as slower and tier2 as faster.  Hopefully that would avoid any userspace
code making assumptions about the ordering.

Jonathan




> 
> -aneesh
> 

