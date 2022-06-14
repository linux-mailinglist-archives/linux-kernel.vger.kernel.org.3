Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD3354B9F2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 21:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357991AbiFNTA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 15:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357492AbiFNTAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 15:00:39 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1933610FEA
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 11:56:10 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id o73so7094643qke.7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 11:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=D/amhMnxEv23l1CDHe8t+0iD0/8RH5XeHhHTbzqvxBc=;
        b=40Yr4u03oqI1QOuCygf9IV94nUOWYYy9enAmln7kfebNt6/0E0t2sn+ZVbMHJbJSft
         mGNZqxUKgwQDq5rZKBxNQOdlOL1baTALpE32BZWfvwD1ey37zcelNL06EMODz5BEDRWU
         CRlwQ5ioxG2BGXhkwX2nKjcRAoR4JaOE8SOKLw+jZput+fsOA4XQuyRIV9XxRLJO5EK9
         lPH5dU2xsU9YyAZLHyPvUKs7Q2eFqKeRaGIqbu1l6dJ/qlRxgZjGhRSZvSNvprL26Y0M
         BQjbsFWOQfw6C0HK8nlJ7B+upVONkciIoa7hZYgKh+r3PN48Wle1kk5cCG4srSSsPUzh
         jwKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=D/amhMnxEv23l1CDHe8t+0iD0/8RH5XeHhHTbzqvxBc=;
        b=2F/ImJQrU490AEqywZ8aC2TBQCPBMQaI0UtOs3+1cu+szK+vk4zLbktUfYd1SyaMca
         YjUiALz2ribvsPou88zRnJfEKQE3khouuD5wGEBafd2j2zii4Wm0TBxcyQa2r862psyq
         rzQn6KWXdADYRbLV5/Z27UhZovcZdpb7VT/B19RLxHlXEaq0gBI9pizf2X7pCXIwWi0u
         WOCXboRoqznHHDIGy1aOnzFD+iuQmLzmgQJQQr+milbkrUrcv3PRbGAEpfr59eAZUNux
         fMCjAjlwuK8GJMgmU2Z1jQX0XPkl01V+vGXWnZL0nHWDTWAR7de7BiKQ/cRt1nguqK2T
         n4XQ==
X-Gm-Message-State: AOAM533tx9h3OUd0GtAcFesk383NTuqfUBg88c4dMz+2ExEsFk+YfPaX
        9Zq2p8TgXyWYn3KOKietoTXLGA==
X-Google-Smtp-Source: ABdhPJz2d8USlLi0PoaDfbH4tRFawudNH2svR2xswibtMQuwRnSH2m+w2kuyhEKDZ1RVev6KUhN+Jg==
X-Received: by 2002:a37:b58:0:b0:6a6:9f80:5ff7 with SMTP id 85-20020a370b58000000b006a69f805ff7mr5121540qkl.697.1655232969111;
        Tue, 14 Jun 2022 11:56:09 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:2c45])
        by smtp.gmail.com with ESMTPSA id h16-20020ac87d50000000b003051e3b49c2sm7793663qtb.61.2022.06.14.11.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 11:56:08 -0700 (PDT)
Date:   Tue, 14 Jun 2022 14:56:08 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org, Wei Xu <weixugc@google.com>,
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
Subject: Re: [PATCH v5 1/9] mm/demotion: Add support for explicit memory tiers
Message-ID: <YqjZyP11O0yCMmiO@cmpxchg.org>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42f536af-b17d-b001-7b6b-2c6b928f3ecf@linux.ibm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 01:31:37PM +0530, Aneesh Kumar K V wrote:
> On 6/13/22 9:20 PM, Johannes Weiner wrote:
> > On Mon, Jun 13, 2022 at 07:53:03PM +0530, Aneesh Kumar K V wrote:
> >> If the kernel still can't make the right decision, userspace could rearrange
> >> them in any order using rank values. Without something like rank, if
> >> userspace needs to fix things up,  it gets hard with device
> >> hotplugging. ie, the userspace policy could be that any new PMEM tier device
> >> that is hotplugged, park it with a very low-rank value and hence lowest in
> >> demotion order by default. (echo 10 >
> >> /sys/devices/system/memtier/memtier2/rank) . After that userspace could
> >> selectively move the new devices to the correct memory tier?
> > 
> > I had touched on this in the other email.
> > 
> > This doesn't work if two drivers that should have separate policies
> > collide into the same tier - which is very likely with just 3 tiers.
> > So it seems to me the main usecase for having a rank tunable falls
> > apart rather quickly until tiers are spaced out more widely. And it
> > does so at the cost of an, IMO, tricky to understand interface.
> > 
> 
> Considering the kernel has a static map for these tiers, how can two drivers
> end up using the same tier? If a new driver is going to manage a memory
> device that is of different characteristics than the one managed by dax/kmem,
> we will end up adding 
> 
> #define MEMORY_TIER_NEW_DEVICE 4
> 
> The new driver will never use MEMORY_TIER_PMEM
> 
> What can happen is two devices that are managed by DAX/kmem that
> should be in two memory tiers get assigned the same memory tier
> because the dax/kmem driver added both the device to the same memory tier.
> 
> In the future we would avoid that by using more device properties like HMAT
> to create additional memory tiers with different rank values. ie, we would
> do in the dax/kmem create_tier_from_rank() .

Yes, that's the type of collision I mean. Two GPUs, two CXL-attached
DRAMs of different speeds etc.

I also like Huang's idea of using latency characteristics instead of
abstract distances. Though I'm not quite sure how feasible this is in
the short term, and share some concerns that Jonathan raised. But I
think a wider possible range to begin with makes sense in any case.

> > In the other email I had suggested the ability to override not just
> > the per-device distance, but also the driver default for new devices
> > to handle the hotplug situation.
> > 
> 
> I understand that the driver override will be done via module parameters.
> How will we implement device override? For example in case of dax/kmem driver
> the device override will be per dax device? What interface will we use to set the override?
> 
> IIUC in the above proposal the dax/kmem will do
> 
> node_create_and_set_memory_tier(numa_node, get_device_tier_index(dev_dax));
> 
> get_device_tier_index(struct dev_dax *dev)
> {
>     return dax_kmem_tier_index; // module parameter
> }
> 
> Are you suggesting to add a dev_dax property to override the tier defaults?

I was thinking a new struct memdevice and struct memtype(?). Every
driver implementing memory devices like this sets those up and
registers them with generic code and preset parameters. The generic
code creates sysfs directories and allows overriding the parameters.

struct memdevice {
	struct device dev;
	unsigned long distance;
	struct list_head siblings;
	/* nid? ... */
};

struct memtype {
	struct device_type type;
	unsigned long default_distance;
	struct list_head devices;
};

That forms the (tweakable) tree describing physical properties.

From that, the kernel then generates the ordered list of tiers.

> > This should be less policy than before. Driver default and per-device
> > distances (both overridable) combined with one tunable to set the
> > range of distances that get grouped into tiers.
> > 
> 
> Can you elaborate more on how distance value will be used? The device/device NUMA node can have
> different distance value from other NUMA nodes. How do we group them?
> for ex: earlier discussion did outline three different topologies. Can you
> ellaborate how we would end up grouping them using distance?
> 
> For ex: in the topology below node 2 is at distance 30 from Node0 and 40 from Nodes
> so how will we classify node 2?
> 
> 
> Node 0 & 1 are DRAM nodes, node 2 & 3 are PMEM nodes.
> 
> 		  20
>   Node 0 (DRAM)  ----  Node 1 (DRAM)
>        |        \   /       |
>        | 30    40 X 40      | 30
>        |        /   \       |
>   Node 2 (PMEM)  ----  Node 3 (PMEM)
> 		  40
> 
> node distances:
> node   0    1    2    3
>    0  10   20   30   40
>    1  20   10   40   30
>    2  30   40   10   40
>    3  40   30   40   10

I'm fairly confused by this example. Do all nodes have CPUs? Isn't
this just classic NUMA, where optimizing for locality makes the most
sense, rather than tiering?

Forget the interface for a second, I have no idea how tiering on such
a system would work. One CPU's lower tier can be another CPU's
toptier. There is no lowest rung from which to actually *reclaim*
pages. Would the CPUs just demote in circles?

And the coldest pages on one socket would get demoted into another
socket and displace what that socket considers hot local memory?

I feel like I missing something.

When we're talking about tiered memory, I'm thinking about CPUs
utilizing more than one memory node. If those other nodes have CPUs,
you can't reliably establish a singular tier order anymore and it
becomes classic NUMA, no?
