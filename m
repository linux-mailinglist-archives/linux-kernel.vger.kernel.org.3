Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4FD6544ED6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 16:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237080AbiFIOYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 10:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344064AbiFIOYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 10:24:00 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B34B2EEBCE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 07:22:48 -0700 (PDT)
Received: from fraeml738-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LJmS03JqVz67yl7;
        Thu,  9 Jun 2022 22:19:12 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml738-chm.china.huawei.com (10.206.15.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 9 Jun 2022 16:22:46 +0200
Received: from localhost (10.81.202.195) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 9 Jun
 2022 15:22:44 +0100
Date:   Thu, 9 Jun 2022 15:22:43 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
CC:     Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>,
        <linux-mm@kvack.org>, <akpm@linux-foundation.org>,
        Wei Xu <weixugc@google.com>, Huang Ying <ying.huang@intel.com>,
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
Subject: Re: [PATCH v5 1/9] mm/demotion: Add support for explicit memory
 tiers
Message-ID: <20220609152243.00000332@Huawei.com>
In-Reply-To: <YqH74WaUzJlb+smt@cmpxchg.org>
References: <20220603134237.131362-1-aneesh.kumar@linux.ibm.com>
        <20220603134237.131362-2-aneesh.kumar@linux.ibm.com>
        <YqCuE87gCcrnAiXG@cmpxchg.org>
        <YqDGYjgjcS5OoS3P@cmpxchg.org>
        <a4af7598-7bd3-0e70-a434-b1237ca403d6@linux.ibm.com>
        <YqDncfLeEeBaosrY@cmpxchg.org>
        <02ee2c97-3bca-8eb6-97d8-1f8743619453@linux.ibm.com>
        <YqH74WaUzJlb+smt@cmpxchg.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.202.195]
X-ClientProxiedBy: lhreml731-chm.china.huawei.com (10.201.108.82) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Jun 2022 09:55:45 -0400
Johannes Weiner <hannes@cmpxchg.org> wrote:

> On Thu, Jun 09, 2022 at 08:03:26AM +0530, Aneesh Kumar K V wrote:
> > On 6/8/22 11:46 PM, Johannes Weiner wrote:  
> > > On Wed, Jun 08, 2022 at 09:43:52PM +0530, Aneesh Kumar K V wrote:  
> > > > On 6/8/22 9:25 PM, Johannes Weiner wrote:  
> > > > > Hello,
> > > > > 
> > > > > On Wed, Jun 08, 2022 at 10:11:31AM -0400, Johannes Weiner wrote:  
> > > > > > On Fri, Jun 03, 2022 at 07:12:29PM +0530, Aneesh Kumar K.V wrote:  
> > > > > > > @@ -0,0 +1,20 @@
> > > > > > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > > > > > +#ifndef _LINUX_MEMORY_TIERS_H
> > > > > > > +#define _LINUX_MEMORY_TIERS_H
> > > > > > > +
> > > > > > > +#ifdef CONFIG_TIERED_MEMORY
> > > > > > > +
> > > > > > > +#define MEMORY_TIER_HBM_GPU	0
> > > > > > > +#define MEMORY_TIER_DRAM	1
> > > > > > > +#define MEMORY_TIER_PMEM	2
> > > > > > > +
> > > > > > > +#define MEMORY_RANK_HBM_GPU	300
> > > > > > > +#define MEMORY_RANK_DRAM	200
> > > > > > > +#define MEMORY_RANK_PMEM	100
> > > > > > > +
> > > > > > > +#define DEFAULT_MEMORY_TIER	MEMORY_TIER_DRAM
> > > > > > > +#define MAX_MEMORY_TIERS  3  
> > > > > > 
> > > > > > I understand the names are somewhat arbitrary, and the tier ID space
> > > > > > can be expanded down the line by bumping MAX_MEMORY_TIERS.
> > > > > > 
> > > > > > But starting out with a packed ID space can get quite awkward for
> > > > > > users when new tiers - especially intermediate tiers - show up in
> > > > > > existing configurations. I mentioned in the other email that DRAM !=
> > > > > > DRAM, so new tiers seem inevitable already.
> > > > > > 
> > > > > > It could make sense to start with a bigger address space and spread
> > > > > > out the list of kernel default tiers a bit within it:
> > > > > > 
> > > > > > MEMORY_TIER_GPU		0
> > > > > > MEMORY_TIER_DRAM	10
> > > > > > MEMORY_TIER_PMEM	20  
> > > > > 
> > > > > Forgive me if I'm asking a question that has been answered. I went
> > > > > back to earlier threads and couldn't work it out - maybe there were
> > > > > some off-list discussions? Anyway...
> > > > > 
> > > > > Why is there a distinction between tier ID and rank? I undestand that
> > > > > rank was added because tier IDs were too few. But if rank determines
> > > > > ordering, what is the use of a separate tier ID? IOW, why not make the
> > > > > tier ID space wider and have the kernel pick a few spread out defaults
> > > > > based on known hardware, with plenty of headroom to be future proof.
> > > > > 
> > > > >     $ ls tiers
> > > > >     100				# DEFAULT_TIER
> > > > >     $ cat tiers/100/nodelist
> > > > >     0-1				# conventional numa nodes
> > > > > 
> > > > >     <pmem is onlined>
> > > > > 
> > > > >     $ grep . tiers/*/nodelist
> > > > >     tiers/100/nodelist:0-1	# conventional numa
> > > > >     tiers/200/nodelist:2		# pmem
> > > > > 
> > > > >     $ grep . nodes/*/tier
> > > > >     nodes/0/tier:100
> > > > >     nodes/1/tier:100
> > > > >     nodes/2/tier:200
> > > > > 
> > > > >     <unknown device is online as node 3, defaults to 100>
> > > > > 
> > > > >     $ grep . tiers/*/nodelist
> > > > >     tiers/100/nodelist:0-1,3
> > > > >     tiers/200/nodelist:2
> > > > > 
> > > > >     $ echo 300 >nodes/3/tier
> > > > >     $ grep . tiers/*/nodelist
> > > > >     tiers/100/nodelist:0-1
> > > > >     tiers/200/nodelist:2
> > > > >     tiers/300/nodelist:3
> > > > > 
> > > > >     $ echo 200 >nodes/3/tier
> > > > >     $ grep . tiers/*/nodelist
> > > > >     tiers/100/nodelist:0-1	
> > > > >     tiers/200/nodelist:2-3
> > > > > 
> > > > > etc.  
> > > > 
> > > > tier ID is also used as device id memtier.dev.id. It was discussed that we
> > > > would need the ability to change the rank value of a memory tier. If we make
> > > > rank value same as tier ID or tier device id, we will not be able to support
> > > > that.  
> > > 
> > > Is the idea that you could change the rank of a collection of nodes in
> > > one go? Rather than moving the nodes one by one into a new tier?
> > > 
> > > [ Sorry, I wasn't able to find this discussion. AFAICS the first
> > >    patches in RFC4 already had the struct device { .id = tier }
> > >    logic. Could you point me to it? In general it would be really
> > >    helpful to maintain summarized rationales for such decisions in the
> > >    coverletter to make sure things don't get lost over many, many
> > >    threads, conferences, and video calls. ]  
> > 
> > Most of the discussion happened not int he patch review email threads.
> > 
> > RFC: Memory Tiering Kernel Interfaces (v2)
> > https://lore.kernel.org/linux-mm/CAAPL-u_diGYEb7+WsgqNBLRix-nRCk2SsDj6p9r8j5JZwOABZQ@mail.gmail.com
> > 
> > RFC: Memory Tiering Kernel Interfaces (v4)
> > https://lore.kernel.org/linux-mm/CAAPL-u9Wv+nH1VOZTj=9p9S70Y3Qz3+63EkqncRDdHfubsrjfw@mail.gmail.com  
> 
> I read the RFCs, the discussions and your code. It's still not clear
> why the tier/device ID and the rank need to be two separate,
> user-visible things. There is only one tier of a given rank, why can't
> the rank be the unique device id? dev->id = 100. One number. Or use a
> unique device id allocator if large numbers are causing problems
> internally. But I don't see an explanation why they need to be two
> different things, let alone two different things in the user ABI.

I think discussion hinged on it making sense to be able to change
rank of a tier rather than create a new tier and move things one by one.
Example was wanting to change the rank of a tier that was created
either by core code or a subsystem.

E.g. If GPU driver creates a tier, assumption is all similar GPUs will
default to the same tier (if hot plugged later for example) as the
driver subsystem will keep a reference to the created tier.
Hence if user wants to change the order of that relative to
other tiers, the option of creating a new tier and moving the
devices would then require us to have infrastructure to tell the GPU
driver to now use the new tier for additional devices.

Or we could go with new nodes are not assigned to a tier and userspace is
always responsible for that assignment.  That may be a problem for
anything relying on existing behavior.  Means that there must always
be a sensible userspace script...

Jonathan




