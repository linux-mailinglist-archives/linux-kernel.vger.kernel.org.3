Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81AA054A9B7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 08:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352362AbiFNGsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 02:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232702AbiFNGs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 02:48:28 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC9F2B1B2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 23:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655189307; x=1686725307;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KU9PONEWvvNw7HKYzfGC0SWpZRYFyweY+FoWBruNvgA=;
  b=f3wVLL8CCqAoavYo3NDbDLP1dwL3cXRSvoK/4CHK6TsEaAaI2TfKr229
   T6XDGJHTd3dYaQbseaOVbbLwnrqJgh18Qu6RrLewYHJKccVUwIkApG/o5
   +TDxBykbf40D4unAT6mzXvgszJpZLuQpOmrh8Eq/PRP45e1nfMka6anPD
   2SWasomooZ5L4nwNQ2Os8FggNouDrpfOZHncMLA5GXkkgd3EeVlvhr8OP
   lSI05dSYHHYDg+3otYZ4RrjKxWIxhYKvEMJ6kY5aQXvECA/p5nllcLZQM
   qQrU890PVPofr5i5F+5eRyQC5oNqy10qGWjRY/h5v+PZv38HTfhdisSkQ
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="340193454"
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="340193454"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 23:48:27 -0700
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="651863868"
Received: from unknown (HELO yhuang6-mobl1.ccr.corp.intel.com) ([10.254.215.153])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 23:48:21 -0700
Message-ID: <646519718c47fb8daf2ecebead0399393733a800.camel@intel.com>
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
Date:   Tue, 14 Jun 2022 14:48:19 +0800
In-Reply-To: <Yqdc4DE8gYJ3zesO@cmpxchg.org>
References: <YqDGYjgjcS5OoS3P@cmpxchg.org>
         <a4af7598-7bd3-0e70-a434-b1237ca403d6@linux.ibm.com>
         <YqDncfLeEeBaosrY@cmpxchg.org>
         <02ee2c97-3bca-8eb6-97d8-1f8743619453@linux.ibm.com>
         <YqH74WaUzJlb+smt@cmpxchg.org> <20220609152243.00000332@Huawei.com>
         <YqJa4N/VlS4zN4vf@cmpxchg.org> <20220610105708.0000679b@Huawei.com>
         <YqdEEhJFr3SlfvSJ@cmpxchg.org>
         <4297bd21-e984-9d78-2bca-e70c11749a72@linux.ibm.com>
         <Yqdc4DE8gYJ3zesO@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-06-13 at 11:50 -0400, Johannes Weiner wrote:
> On Mon, Jun 13, 2022 at 07:53:03PM +0530, Aneesh Kumar K V wrote:
> > On 6/13/22 7:35 PM, Johannes Weiner wrote:
> > > On Fri, Jun 10, 2022 at 10:57:08AM +0100, Jonathan Cameron wrote:
> > > > I'm not sure completely read only is flexible enough (though mostly RO is fine)
> > > > as we keep sketching out cases where any attempt to do things automatically
> > > > does the wrong thing and where we need to add an extra tier to get
> > > > everything to work.  Short of having a lot of tiers I'm not sure how
> > > > we could have the default work well.  Maybe a lot of "tiers" is fine
> > > > though perhaps we need to rename them if going this way and then they
> > > > don't really work as current concept of tier.
> > > > 
> > > > Imagine a system with subtle difference between different memories such
> > > > as 10% latency increase for same bandwidth.  To get an advantage from
> > > > demoting to such a tier will require really stable usage and long
> > > > run times. Whilst you could design a demotion scheme that takes that
> > > > into account, I think we are a long way from that today.
> > > 
> > > Good point: there can be a clear hardware difference, but it's a
> > > policy choice whether the MM should treat them as one or two tiers.
> > > 
> > > What do you think of a per-driver/per-device (overridable) distance
> > > number, combined with a configurable distance cutoff for what
> > > constitutes separate tiers. E.g. cutoff=20 means two devices with
> > > distances of 10 and 20 respectively would be in the same tier, devices
> > > with 10 and 100 would be in separate ones. The kernel then generates
> > > and populates the tiers based on distances and grouping cutoff, and
> > > populates the memtier directory tree and nodemasks in sysfs.
> > > 
> > 
> > Right now core/generic code doesn't get involved in building tiers. It just
> > defines three tiers where drivers could place the respective devices they
> > manage. The above suggestion would imply we are moving quite a lot of policy
> > decision logic into the generic code?.
> 
> No. The driver still chooses its own number, just from a wider
> range. The only policy in generic code is the distance cutoff for
> which devices are grouped into tiers together.
> 
> > At some point, we will have to depend on more attributes other than
> > distance(may be HMAT?) and each driver should have the flexibility to place
> > the device it is managing in a specific tier? By then we may decide to
> > support more than 3 static tiers which the core kernel currently does.
> 
> If we start with a larger possible range of "distance" values right
> away, we can still let the drivers ballpark into 3 tiers for now (100,
> 200, 300). But it will be easier to take additional metrics into
> account later and fine tune accordingly (120, 260, 90 etc.) without
> having to update all the other drivers as well.
> 
> > If the kernel still can't make the right decision, userspace could rearrange
> > them in any order using rank values. Without something like rank, if
> > userspace needs to fix things up,  it gets hard with device
> > hotplugging. ie, the userspace policy could be that any new PMEM tier device
> > that is hotplugged, park it with a very low-rank value and hence lowest in
> > demotion order by default. (echo 10 >
> > /sys/devices/system/memtier/memtier2/rank) . After that userspace could
> > selectively move the new devices to the correct memory tier?
> 
> I had touched on this in the other email.
> 
> This doesn't work if two drivers that should have separate policies
> collide into the same tier - which is very likely with just 3 tiers.
> So it seems to me the main usecase for having a rank tunable falls
> apart rather quickly until tiers are spaced out more widely. And it
> does so at the cost of an, IMO, tricky to understand interface.
> 
> In the other email I had suggested the ability to override not just
> the per-device distance, but also the driver default for new devices
> to handle the hotplug situation.
> 
> This should be less policy than before. Driver default and per-device
> distances (both overridable) combined with one tunable to set the
> range of distances that get grouped into tiers.
> 
> With these parameters alone, you can generate an ordered list of tiers
> and their devices. The tier numbers make sense, and no rank is needed.
> 
> Do you still need the ability to move nodes by writing nodemasks? I
> don't think so. Assuming you would never want to have an actually
> slower device in a higher tier than a faster device, the only time
> you'd want to move a device is when the device's distance value is
> wrong. So you override that (until you update to a fixed kernel).

This sounds good to me.  In this way, we override driver parameter
instead of memory tiers itself.  So I guess when we do that, the memory
tier of the NUMA nodes controlled by the driver will be changed.  Or all
memory tiers will be regenerated?

I have a suggestion.  Instead of abstract distance number, how about
using memory latency and bandwidth directly?  These can be gotten from
HMAT directly when necessary.  Even if they are not available directly,
they may be tested at runtime by the drivers.

Best Regards,
Huang, Ying

