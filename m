Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7141C5462E6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 11:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244921AbiFJJ52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 05:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238786AbiFJJ5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 05:57:19 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D1D4D9E0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 02:57:15 -0700 (PDT)
Received: from fraeml702-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LKGTf4C8cz687qR;
        Fri, 10 Jun 2022 17:52:22 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml702-chm.china.huawei.com (10.206.15.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Fri, 10 Jun 2022 11:57:13 +0200
Received: from localhost (10.81.209.23) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 10 Jun
 2022 10:57:12 +0100
Date:   Fri, 10 Jun 2022 10:57:08 +0100
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
Message-ID: <20220610105708.0000679b@Huawei.com>
In-Reply-To: <YqJa4N/VlS4zN4vf@cmpxchg.org>
References: <20220603134237.131362-1-aneesh.kumar@linux.ibm.com>
        <20220603134237.131362-2-aneesh.kumar@linux.ibm.com>
        <YqCuE87gCcrnAiXG@cmpxchg.org>
        <YqDGYjgjcS5OoS3P@cmpxchg.org>
        <a4af7598-7bd3-0e70-a434-b1237ca403d6@linux.ibm.com>
        <YqDncfLeEeBaosrY@cmpxchg.org>
        <02ee2c97-3bca-8eb6-97d8-1f8743619453@linux.ibm.com>
        <YqH74WaUzJlb+smt@cmpxchg.org>
        <20220609152243.00000332@Huawei.com>
        <YqJa4N/VlS4zN4vf@cmpxchg.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.209.23]
X-ClientProxiedBy: lhreml725-chm.china.huawei.com (10.201.108.76) To
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

On Thu, 9 Jun 2022 16:41:04 -0400
Johannes Weiner <hannes@cmpxchg.org> wrote:

> On Thu, Jun 09, 2022 at 03:22:43PM +0100, Jonathan Cameron wrote:
> > I think discussion hinged on it making sense to be able to change
> > rank of a tier rather than create a new tier and move things one by one.
> > Example was wanting to change the rank of a tier that was created
> > either by core code or a subsystem.
> > 
> > E.g. If GPU driver creates a tier, assumption is all similar GPUs will
> > default to the same tier (if hot plugged later for example) as the
> > driver subsystem will keep a reference to the created tier.
> > Hence if user wants to change the order of that relative to
> > other tiers, the option of creating a new tier and moving the
> > devices would then require us to have infrastructure to tell the GPU
> > driver to now use the new tier for additional devices.  
> 
> That's an interesting point, thanks for explaining.
> 
> But that could still happen when two drivers report the same tier and
> one of them is wrong, right? You'd still need to separate out by hand
> to adjust rank, as well as handle hotplug events. Driver colllisions
> are probable with coarse categories like gpu, dram, pmem.

There will always be cases that need hand tweaking.  Also I'd envision
some driver subsystems being clever enough to manage several tiers and
use the information available to them to assign appropriately.  This
is definitely true for CXL 2.0+ devices where we can have radically
different device types under the same driver (volatile, persistent,
direct connect, behind switches etc).  There will be some interesting
choices to make on groupings in big systems as we don't want too many
tiers unless we naturally demote multiple levels in one go..

> 
> Would it make more sense to have the platform/devicetree/driver
> provide more fine-grained distance values similar to NUMA distances,
> and have a driver-scope tunable to override/correct? And then have the
> distance value function as the unique tier ID and rank in one.

Absolutely a good thing to provide that information, but it's black
magic. There are too many contradicting metrics (latency vs bandwidth etc)
even not including a more complex system model like Jerome Glisse proposed
a few years back. https://lore.kernel.org/all/20190118174512.GA3060@redhat.com/
CXL 2.0 got this more right than anything else I've seen as provides
discoverable topology along with details like latency to cross between
particular switch ports.  Actually using that data (other than by throwing
it to userspace controls for HPC apps etc) is going to take some figuring out.
Even the question of what + how we expose this info to userspace is non
obvious.

The 'right' decision is also usecase specific, so what you'd do for
particular memory characteristics for a GPU are not the same as what
you'd do for the same characteristics on a memory only device.

> 
> That would allow device class reassignments, too, and it would work
> with driver collisions where simple "tier stickiness" would
> not. (Although collisions would be less likely to begin with given a
> broader range of possible distance values.)

I think we definitely need the option to move individual nodes (in this
case nodes map to individual devices if characteristics vary between them)
around as well, but I think that's somewhat orthogonal to a good first guess.

> 
> Going further, it could be useful to separate the business of hardware
> properties (and configuring quirks) from the business of configuring
> MM policies that should be applied to the resulting tier hierarchy.
> They're somewhat orthogonal tuning tasks, and one of them might become
> obsolete before the other (if the quality of distance values provided
> by drivers improves before the quality of MM heuristics ;). Separating
> them might help clarify the interface for both designers and users.
> 
> E.g. a memdev class scope with a driver-wide distance value, and a
> memdev scope for per-device values that default to "inherit driver
> value". The memtier subtree would then have an r/o structure, but
> allow tuning per-tier interleaving ratio[1], demotion rules etc.

Ok that makes sense.  I'm not sure if that ends up as an implementation
detail, or effects the userspace interface of this particular element.

I'm not sure completely read only is flexible enough (though mostly RO is fine)
as we keep sketching out cases where any attempt to do things automatically
does the wrong thing and where we need to add an extra tier to get
everything to work.  Short of having a lot of tiers I'm not sure how
we could have the default work well.  Maybe a lot of "tiers" is fine
though perhaps we need to rename them if going this way and then they
don't really work as current concept of tier.

Imagine a system with subtle difference between different memories such
as 10% latency increase for same bandwidth.  To get an advantage from
demoting to such a tier will require really stable usage and long
run times. Whilst you could design a demotion scheme that takes that
into account, I think we are a long way from that today.

Jonathan


> 
> [1] https://lore.kernel.org/linux-mm/20220607171949.85796-1-hannes@cmpxchg.org/#t

