Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43F8053E8E8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241423AbiFFQQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 12:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241363AbiFFQQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 12:16:29 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 798ED17CE45
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 09:16:27 -0700 (PDT)
Received: from fraeml715-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LGz9J19Pyz6896B;
        Tue,  7 Jun 2022 00:15:16 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml715-chm.china.huawei.com (10.206.15.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 6 Jun 2022 18:16:24 +0200
Received: from localhost (10.202.226.42) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 6 Jun
 2022 17:16:24 +0100
Date:   Mon, 6 Jun 2022 17:16:22 +0100
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
Subject: Re: [RFC PATCH v4 2/7] mm/demotion: Expose per node memory tier to
 sysfs
Message-ID: <20220606171622.000036ed@Huawei.com>
In-Reply-To: <3a557f74-cc3a-c0ee-78e8-2cf50bee5f2d@linux.ibm.com>
References: <CAAPL-u-dFp7PwPH6DfbYdnY8xaGsHz3tRQ0CPGVkiqURvdN8=A@mail.gmail.com>
        <20220527122528.129445-1-aneesh.kumar@linux.ibm.com>
        <20220527122528.129445-3-aneesh.kumar@linux.ibm.com>
        <20220527151531.00002a0c@Huawei.com>
        <fbebbd2b-2ddb-bee6-5e12-67e3e18648ee@linux.ibm.com>
        <20220606155920.00004ce9@Huawei.com>
        <3a557f74-cc3a-c0ee-78e8-2cf50bee5f2d@linux.ibm.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhreml728-chm.china.huawei.com (10.201.108.79) To
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

On Mon, 6 Jun 2022 21:31:16 +0530
Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> wrote:

> On 6/6/22 8:29 PM, Jonathan Cameron wrote:
> > On Fri, 3 Jun 2022 14:10:47 +0530
> > Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> wrote:
> >   
> >> On 5/27/22 7:45 PM, Jonathan Cameron wrote:  
> >>> On Fri, 27 May 2022 17:55:23 +0530
> >>> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> wrote:
> >>>      
> >>>> From: Jagdish Gediya <jvgediya@linux.ibm.com>
> >>>>
> >>>> Add support to read/write the memory tierindex for a NUMA node.
> >>>>
> >>>> /sys/devices/system/node/nodeN/memtier
> >>>>
> >>>> where N = node id
> >>>>
> >>>> When read, It list the memory tier that the node belongs to.
> >>>>
> >>>> When written, the kernel moves the node into the specified
> >>>> memory tier, the tier assignment of all other nodes are not
> >>>> affected.
> >>>>
> >>>> If the memory tier does not exist, writing to the above file
> >>>> create the tier and assign the NUMA node to that tier.  
> >>> creates
> >>>
> >>> There was some discussion in v2 of Wei Xu's RFC that what matter
> >>> for creation is the rank, not the tier number.
> >>>
> >>> My suggestion is move to an explicit creation file such as
> >>> memtier/create_tier_from_rank
> >>> to which writing the rank gives results in a new tier
> >>> with the next device ID and requested rank.  
> >>
> >> I think the below workflow is much simpler.
> >>
> >> :/sys/devices/system# cat memtier/memtier1/nodelist
> >> 1-3
> >> :/sys/devices/system# cat node/node1/memtier
> >> 1
> >> :/sys/devices/system# ls memtier/memtier*
> >> nodelist  power  rank  subsystem  uevent
> >> /sys/devices/system# ls memtier/
> >> default_rank  max_tier  memtier1  power  uevent
> >> :/sys/devices/system# echo 2 > node/node1/memtier
> >> :/sys/devices/system#
> >>
> >> :/sys/devices/system# ls memtier/
> >> default_rank  max_tier  memtier1  memtier2  power  uevent
> >> :/sys/devices/system# cat memtier/memtier1/nodelist
> >> 2-3
> >> :/sys/devices/system# cat memtier/memtier2/nodelist
> >> 1
> >> :/sys/devices/system#
> >>
> >> ie, to create a tier we just write the tier id/tier index to
> >> node/nodeN/memtier file. That will create a new memory tier if needed
> >> and add the node to that specific memory tier. Since for now we are
> >> having 1:1 mapping between tier index to rank value, we can derive the
> >> rank value from the memory tier index.
> >>
> >> For dynamic memory tier support, we can assign a rank value such that
> >> new memory tiers are always created such that it comes last in the
> >> demotion order.  
> > 
> > I'm not keen on having to pass through an intermediate state where
> > the rank may well be wrong, but I guess it's not that harmful even
> > if it feels wrong ;)
> >   
> 
> Any new memory tier added can be of lowest rank (rank - 0) and hence 
> will appear as the highest memory tier in demotion order. 

Depends on driver interaction - if new memory is CXL attached or
GPU attached, chances are the driver has an input on which tier
it is put in by default.

> User can then
> assign the right rank value to the memory tier? Also the actual demotion 
> target paths are built during memory block online which in most case 
> would happen after we properly verify that the device got assigned to 
> the right memory tier with correct rank value?

Agreed, though that may change the model of how memory is brought online
somewhat.

> 
> > Races are potentially a bit of a pain though depending on what we
> > expect the usage model to be.
> > 
> > There are patterns (CXL regions for example) of guaranteeing the
> > 'right' device is created by doing something like
> > 
> > cat create_tier > temp.txt
> > #(temp gets 2 for example on first call then
> > # next read of this file gets 3 etc)
> > 
> > cat temp.txt > create_tier
> > # will fail if there hasn't been a read of the same value
> > 
> > Assuming all software keeps to the model, then there are no
> > race conditions over creation.  Otherwise we have two new
> > devices turn up very close to each other and userspace scripting
> > tries to create two new tiers - if it races they may end up in
> > the same tier when that wasn't the intent.  Then code to set
> > the rank also races and we get two potentially very different
> > memories in a tier with a randomly selected rank.
> > 
> > Fun and games...  And a fine illustration why sysfs based 'device'
> > creation is tricky to get right (and lots of cases in the kernel
> > don't).
> >   
> 
> I would expect userspace to be careful and verify the memory tier and 
> rank value before we online the memory blocks backed by the device. Even 
> if we race, the result would be two device not intended to be part of 
> the same memory tier appearing at the same tier. But then we won't be 
> building demotion targets yet. So userspace could verify this, move the 
> nodes out of the memory tier. Once it is verified, memory blocks can be 
> onlined.

The race is there and not avoidable as far as I can see. Two processes A and B.

A checks for a spare tier number
B checks for a spare tier number
A tries to assign node 3 to new tier 2 (new tier created)
B tries to assign node 4 to new tier 2 (accidentally hits existing tier - as this
is the same method we'd use to put it in the existing tier we can't tell this
write was meant to create a new tier).
A writes rank 100 to tier 2
A checks rank for tier 2 and finds it is 100 as expected.
B write rank 200 to tier 2 (it could check if still default but even that is racy)
B checks rank for tier 2 rank and finds it is 200 as expected.
A onlines memory.
B onlines memory.

Both think they got what they wanted, but A definitely didn't.

One work around is the read / write approach and create_tier.

A reads create_tier - gets 2.
B reads create_tier - gets 3.
A writes 2 to create_tier as that's what it read.
B writes 3 to create_tier as that's what it read.

continue with created tiers.  Obviously can exhaust tiers, but if this is
root only, could just create lots anyway so no worse off.
 
> 
> Having said that can you outline the usage of 
> memtier/create_tier_from_rank ?

There are corner cases to deal with...

A writes 100 to create_tier_from_rank.
A goes looking for matching tier - finds it: tier2
B writes 200 to create_tier_from_rank
B goes looking for matching tier - finds it: tier3

rest is fine as operating on different tiers.

Trickier is
A writes 100 to create_tier_from_rank  - succeed.
B writes 100 to create_tier_from_rank  - Could fail, or could just eat it?

Logically this is same as separate create_tier and then a write
of rank, but in one operation, but then you need to search
for the right one.  As such, perhaps a create_tier
that does the read/write pair as above is the best solution.

Jonathan


> 
> -aneesh

