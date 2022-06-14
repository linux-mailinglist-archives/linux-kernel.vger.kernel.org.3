Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92F8754B6A6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 18:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243244AbiFNQqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 12:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234800AbiFNQpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 12:45:47 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA9D719037
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 09:45:45 -0700 (PDT)
Received: from fraeml701-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LMvQx4Gg1z6H6vG;
        Wed, 15 Jun 2022 00:44:09 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Tue, 14 Jun 2022 18:45:42 +0200
Received: from localhost (10.81.210.75) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 14 Jun
 2022 17:45:41 +0100
Date:   Tue, 14 Jun 2022 17:45:39 +0100
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
Message-ID: <20220614174539.00004145@Huawei.com>
In-Reply-To: <YqdEEhJFr3SlfvSJ@cmpxchg.org>
References: <20220603134237.131362-2-aneesh.kumar@linux.ibm.com>
        <YqCuE87gCcrnAiXG@cmpxchg.org>
        <YqDGYjgjcS5OoS3P@cmpxchg.org>
        <a4af7598-7bd3-0e70-a434-b1237ca403d6@linux.ibm.com>
        <YqDncfLeEeBaosrY@cmpxchg.org>
        <02ee2c97-3bca-8eb6-97d8-1f8743619453@linux.ibm.com>
        <YqH74WaUzJlb+smt@cmpxchg.org>
        <20220609152243.00000332@Huawei.com>
        <YqJa4N/VlS4zN4vf@cmpxchg.org>
        <20220610105708.0000679b@Huawei.com>
        <YqdEEhJFr3SlfvSJ@cmpxchg.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.210.75]
X-ClientProxiedBy: lhreml740-chm.china.huawei.com (10.201.108.190) To
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

On Mon, 13 Jun 2022 10:05:06 -0400
Johannes Weiner <hannes@cmpxchg.org> wrote:

> On Fri, Jun 10, 2022 at 10:57:08AM +0100, Jonathan Cameron wrote:
> > On Thu, 9 Jun 2022 16:41:04 -0400
> > Johannes Weiner <hannes@cmpxchg.org> wrote:  
> > > On Thu, Jun 09, 2022 at 03:22:43PM +0100, Jonathan Cameron wrote:
> > > Would it make more sense to have the platform/devicetree/driver
> > > provide more fine-grained distance values similar to NUMA distances,
> > > and have a driver-scope tunable to override/correct? And then have the
> > > distance value function as the unique tier ID and rank in one.  
> > 
> > Absolutely a good thing to provide that information, but it's black
> > magic. There are too many contradicting metrics (latency vs bandwidth etc)
> > even not including a more complex system model like Jerome Glisse proposed
> > a few years back. https://lore.kernel.org/all/20190118174512.GA3060@redhat.com/
> > CXL 2.0 got this more right than anything else I've seen as provides
> > discoverable topology along with details like latency to cross between
> > particular switch ports.  Actually using that data (other than by throwing
> > it to userspace controls for HPC apps etc) is going to take some figuring out.
> > Even the question of what + how we expose this info to userspace is non
> > obvious.  

Was offline for a few days.  At risk of splitting a complex thread
even more....

> 
> Right, I don't think those would be scientifically accurate - but
> neither is a number between 1 and 3.

The 3 tiers in this proposal are just a starting point (and one I'd
expect we'll move beyond very quickly) - aim is to define a userspace
that is flexible enough, but then only use a tiny bit of that flexibility
to get an initial version in place.  Even relatively trivial CXL systems
will include.

1) Direct connected volatile memory, (similar to a memory only NUMA node / socket)
2) Direct connected non volatile (similar to pmem Numa node, but maybe not
   similar enough to fuse with socket connected pmem)
3) Switch connected volatile memory (typically a disagregated memory device,
   so huge, high bandwidth, not great latency)
4) Switch connected non volatile (typically huge, high bandwidth, even wors
   latency).
5) Much more fun if we care about bandwidth as interleaving going on
   in hardware across either similar, or mixed sets of switch connected
   and direct connected.

Sure we might fuse some of those.  But just the CXL driver is likely to have
groups separate enough we want to handle them as 4 tiers and migrate between
those tiers...  Obviously might want a clever strategy for cold / hot migration!

> The way I look at it is more
> about spreading out the address space a bit, to allow expressing
> nuanced differences without risking conflicts and overlaps. Hopefully
> this results in the shipped values stabilizing over time and thus
> requiring less and less intervention and overriding from userspace.

I don't think they ever will stabilize, because the right answer isn't
definable in terms of just one number.  We'll end up with the old mess of
magic values in SLIT in which systems have been tuned against particular
use cases. HMAT was meant to solve that, but not yet clear it it will.

> 
> > > Going further, it could be useful to separate the business of hardware
> > > properties (and configuring quirks) from the business of configuring
> > > MM policies that should be applied to the resulting tier hierarchy.
> > > They're somewhat orthogonal tuning tasks, and one of them might become
> > > obsolete before the other (if the quality of distance values provided
> > > by drivers improves before the quality of MM heuristics ;). Separating
> > > them might help clarify the interface for both designers and users.
> > > 
> > > E.g. a memdev class scope with a driver-wide distance value, and a
> > > memdev scope for per-device values that default to "inherit driver
> > > value". The memtier subtree would then have an r/o structure, but
> > > allow tuning per-tier interleaving ratio[1], demotion rules etc.  
> > 
> > Ok that makes sense.  I'm not sure if that ends up as an implementation
> > detail, or effects the userspace interface of this particular element.
> > 
> > I'm not sure completely read only is flexible enough (though mostly RO is fine)
> > as we keep sketching out cases where any attempt to do things automatically
> > does the wrong thing and where we need to add an extra tier to get
> > everything to work.  Short of having a lot of tiers I'm not sure how
> > we could have the default work well.  Maybe a lot of "tiers" is fine
> > though perhaps we need to rename them if going this way and then they
> > don't really work as current concept of tier.
> > 
> > Imagine a system with subtle difference between different memories such
> > as 10% latency increase for same bandwidth.  To get an advantage from
> > demoting to such a tier will require really stable usage and long
> > run times. Whilst you could design a demotion scheme that takes that
> > into account, I think we are a long way from that today.  
> 
> Good point: there can be a clear hardware difference, but it's a
> policy choice whether the MM should treat them as one or two tiers.
> 
> What do you think of a per-driver/per-device (overridable) distance
> number, combined with a configurable distance cutoff for what
> constitutes separate tiers. E.g. cutoff=20 means two devices with
> distances of 10 and 20 respectively would be in the same tier, devices
> with 10 and 100 would be in separate ones. The kernel then generates
> and populates the tiers based on distances and grouping cutoff, and
> populates the memtier directory tree and nodemasks in sysfs.

I think we'll need something along those lines, though I was envisioning
it sitting at the level of what we do with the tiers, rather than how
we create them.  So particularly usecases would decide to treat
sets of tiers as if they were one.  Have enough tiers and we'll end up
with k-means or similar to figure out the groupings. Of course there
is then a soft of 'tier group for use XX' concept so maybe not much
difference until we have a bunch of usecases.

> 
> It could be simple tier0, tier1, tier2 numbering again, but the
> numbers now would mean something to the user. A rank tunable is no
> longer necessary.

This feels like it might make tier assignments a bit less stable
and hence run into question of how to hook up accounting. Not my
area of expertise though, but it was put forward as one of the reasons
we didn't want hotplug to potentially end up shuffling other tiers
around.  The desire was for a 'stable' entity.  Can avoid that with
'space' between them but then we sort of still have rank, just in a
form that makes updating it messy (need to create a new tier to do
it).

> 
> I think even the nodemasks in the memtier tree could be read-only
> then, since corrections should only be necessary when either the
> device distance is wrong or the tier grouping cutoff.
> 
> Can you think of scenarios where that scheme would fall apart?

Simplest (I think) is the GPU one. Often those have very nice
memory that we CPU software developers would love to use, but
some pesky GPGPU folk think it is for GPU related data. Anyhow, folk
who care about GPUs have requested that it be in a tier that
is lower rank than main memory.

If you just categorize it by performance (from CPUs) then it
might well end up elsewhere.  These folk do want to demote
to CPU attached DRAM though.  Which raises the question of
'where is your distance between?'

Definitely policy decision, and one we can't get from perf
characteristics.  It's a blurry line. There are classes
of fairly low spec memory attached accelerators on the horizon.
For those preventing migration to the memory they are associated
with might generally not make sense.

Tweaking policy by messing with anything that claims to be a
distance is a bit nasty at looks like the SLIT table tuning
that's still happens. Could have a per device rank though
and make it clear this isn't cleanly related to any perf
characterstics.  So ultimately that moves rank to devices
and then we have to put them into nodes. Not sure it gained
us much other than seeming more complex to me.

Jonathan


