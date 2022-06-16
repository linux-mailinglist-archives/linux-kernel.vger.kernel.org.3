Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE0854D8FE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 05:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358201AbiFPDp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 23:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343970AbiFPDpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 23:45:55 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BCDD42ED0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 20:45:54 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id g6so125274vsb.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 20:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k7VXVbqh0bhzQK4yW0QJWfypGCveVteOymCQFvAwJB8=;
        b=na36DyrTfQu1n/OqBEP3BerJJX8gLahUFmWmw7cSgpwPcazwJc9FDc9pT9DAEFVdKR
         ctcfwmN9VqdierMnOzJo/8kc1U5kWDdoSMSnC0cQ0jLU2qgxHDmSwZY1+5oaJxPZLTW2
         Akxkm79mwVWYwfZnLcUVBrcH2qKhf3mWu5og1yQqx14RohLCBa/+kDA9dwULNXJfCfOT
         NSXrTeGRgE5+bf37s6cMP/OGFs79QatJe3d9Xf7QIEJvsg7er9ed1dPnPSaKFM7ZpSMY
         SBi4g8sHkIjWCXcQoGJ/LWgUjlhrHlMRf3uY/x+D7zPHVmdkzUydNCG1tC5nK7dGd/OE
         XCtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k7VXVbqh0bhzQK4yW0QJWfypGCveVteOymCQFvAwJB8=;
        b=bJF2yCU3MbJxL19QC/6CVPzOeGthnDzUgM57VQpWrykIGFpNHV7tkqq+RHybWzcHN3
         5E/26qdBb/By/9+FVOVea7Mo8ABtOZEqhTsyqmjz090Ro8laTodrX23ElWHtSaJgtWe/
         dbXMhYb6p7vt+jhVOxSArcCMczZOVrioNwAHs5yw+9nG54riBQ3ZrNb0qlZxyw31rNlQ
         7E7kZIGv0EAOG5o0IKOFEqBgi2Q8v+E/+G7k4nYI2Wjkqx+83lm2+UUG1GDMhiIWqgjY
         LJBPKNKriVq2Q2raDnH3IZoaDQ+BFhEhrPtRbnkf+ox1aEdOnJ2fuyPWYYILts0nJsVN
         B2eA==
X-Gm-Message-State: AJIora/zCEcChvWusJlKWfJEY6EINzygYQ6tZDTQ5c3yg+S0a8vkIwBD
        DDiLrp29AO1bP5lEMgREgudjIxOhAss8tXnO5NAvJA==
X-Google-Smtp-Source: AGRyM1utwYUcs7rjymmDuVwA9/HUeNqJhefjrWmnuwOUtFitsp3/T+5eisHFb6LIznNPR9meg30yHLqbVnpkjepjzP0=
X-Received: by 2002:a67:e185:0:b0:34c:46ab:ca96 with SMTP id
 e5-20020a67e185000000b0034c46abca96mr1354060vsl.77.1655351153487; Wed, 15 Jun
 2022 20:45:53 -0700 (PDT)
MIME-Version: 1.0
References: <YqDncfLeEeBaosrY@cmpxchg.org> <02ee2c97-3bca-8eb6-97d8-1f8743619453@linux.ibm.com>
 <YqH74WaUzJlb+smt@cmpxchg.org> <20220609152243.00000332@Huawei.com>
 <YqJa4N/VlS4zN4vf@cmpxchg.org> <20220610105708.0000679b@Huawei.com>
 <YqdEEhJFr3SlfvSJ@cmpxchg.org> <4297bd21-e984-9d78-2bca-e70c11749a72@linux.ibm.com>
 <Yqdc4DE8gYJ3zesO@cmpxchg.org> <42f536af-b17d-b001-7b6b-2c6b928f3ecf@linux.ibm.com>
 <YqjZyP11O0yCMmiO@cmpxchg.org> <2b261518bbb5b8466301f8ab978f408141fa6e68.camel@intel.com>
In-Reply-To: <2b261518bbb5b8466301f8ab978f408141fa6e68.camel@intel.com>
From:   Wei Xu <weixugc@google.com>
Date:   Wed, 15 Jun 2022 20:45:42 -0700
Message-ID: <CAAPL-u9hjR8sFeUYM46TXPg-Lho6hr0zaLvrGhg9=htRrPtjqw@mail.gmail.com>
Subject: Re: [PATCH v5 1/9] mm/demotion: Add support for explicit memory tiers
To:     Ying Huang <ying.huang@intel.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 6:11 PM Ying Huang <ying.huang@intel.com> wrote:
>
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
> > >     return dax_kmem_tier_index; // module parameter
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
> >       struct device dev;
> >       unsigned long distance;
> >       struct list_head siblings;
> >       /* nid? ... */
> > };
> >
> > struct memtype {
> >       struct device_type type;
> >       unsigned long default_distance;
> >       struct list_head devices;
> > };
> >
> > That forms the (tweakable) tree describing physical properties.
>
> In general, I think memtype is a good idea.  I have suggested
> something similar before.  It can describe the characters of a
> specific type of memory (same memory media with different interface
> (e.g., CXL, or DIMM) will be different memory types).  And they can
> be used to provide overriding information.
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

One of the motivations of introducing "rank" is to allow memory tier
ID to be stable, at least for the well-defined tiers such as the
default memory tier.  The default memory tier can be moved around in
the tier hierarchy by adjusting its rank position relative to other
tiers, but its device ID can remain the same, e.g. always 1.

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
> > >               20
> > >   Node 0 (DRAM)  ----  Node 1 (DRAM)
> > >        |        \   /       |
> > >        | 30    40 X 40      | 30
> > >        |        /   \       |
> > >   Node 2 (PMEM)  ----  Node 3 (PMEM)
> > >               40
> > >
> > > node distances:
> > > node   0    1    2    3
> > >    0  10   20   30   40
> > >    1  20   10   40   30
> > >    2  30   40   10   40
> > >    3  40   30   40   10
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
>
