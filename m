Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CDEF545C23
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 08:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346415AbiFJGPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 02:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234524AbiFJGPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 02:15:41 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E8922AE51
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 23:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654841740; x=1686377740;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Mubq2Tkji6PEsori3NpFWcqeLApjc4Mu831DOd1/+iU=;
  b=aSO/lCgK4G3h6CljByjbZwwykrpdtTIM00kbbPw16xrJC4xWxyU7MghL
   KeK0lpBIs9P0fD7l67JOjSFe6U03GWCBowTit1a8ZIIYkmkYpJYGMK7qn
   u9c45nVasNiJnpcXDN8XJiI8En5Wa6quhG+rWkzu32f4lx3ROkEZ0k0Xg
   XfLx9Mzo3p4MbJFCknKf027tEZ7D0RTCRHs39tDrfuuj8/WyadHgb+wfj
   bDUr2vDW2nzKY7/tmyx4tuIs/xVq1PH+0umA0MY+n8Zcp3b7Jvpz4jaEz
   14Hma9zhXdQUMPWzYnrV0zCoNajK8EDwVahFvyqGF9mCbUuh55Gth8wMR
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="276304238"
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="276304238"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 23:15:40 -0700
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="637958331"
Received: from qingfen1-mobl1.ccr.corp.intel.com ([10.254.215.73])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 23:15:36 -0700
Message-ID: <6e5ecbe5544ca8a434499e95f4d2b9f53a43d91e.camel@intel.com>
Subject: Re: [PATCH v5 1/9] mm/demotion: Add support for explicit memory
 tiers
From:   Ying Huang <ying.huang@intel.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>, linux-mm@kvack.org,
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
Date:   Fri, 10 Jun 2022 14:15:34 +0800
In-Reply-To: <YqJa4N/VlS4zN4vf@cmpxchg.org>
References: <20220603134237.131362-1-aneesh.kumar@linux.ibm.com>
         <20220603134237.131362-2-aneesh.kumar@linux.ibm.com>
         <YqCuE87gCcrnAiXG@cmpxchg.org> <YqDGYjgjcS5OoS3P@cmpxchg.org>
         <a4af7598-7bd3-0e70-a434-b1237ca403d6@linux.ibm.com>
         <YqDncfLeEeBaosrY@cmpxchg.org>
         <02ee2c97-3bca-8eb6-97d8-1f8743619453@linux.ibm.com>
         <YqH74WaUzJlb+smt@cmpxchg.org> <20220609152243.00000332@Huawei.com>
         <YqJa4N/VlS4zN4vf@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-06-09 at 16:41 -0400, Johannes Weiner wrote:
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

I have proposed to use sparse memory tier device ID and remove rank. 
The response from Wei Xu is as follows,

"
Using the rank value directly as the device ID has some disadvantages:
- It is kind of unconventional to number devices in this way.
- We cannot assign DRAM nodes with CPUs with a specific memtier device
ID (even though this is not mandated by the "rank" proposal, I expect
the device will likely always be memtier1 in practice).
- It is possible that we may eventually allow the rank value to be
modified as a way to adjust the tier ordering.  We cannot do that
easily for device IDs.
"

in

https://lore.kernel.org/lkml/CAAPL-u9t=9hYfcXyCZwYFmVTUQGrWVq3cndpN+sqPSm5cwE4Yg@mail.gmail.com/

I think that your proposal below has resolved the latter "disadvantage".
So if the former one isn't so important, we can go to remove "rank". 
That will make memory tier much easier to be understand and use.

Best Regards,
Huang, Ying

> But that could still happen when two drivers report the same tier and
> one of them is wrong, right? You'd still need to separate out by hand
> to adjust rank, as well as handle hotplug events. Driver colllisions
> are probable with coarse categories like gpu, dram, pmem.
> 
> Would it make more sense to have the platform/devicetree/driver
> provide more fine-grained distance values similar to NUMA distances,
> and have a driver-scope tunable to override/correct? And then have the
> distance value function as the unique tier ID and rank in one.
> 
> That would allow device class reassignments, too, and it would work
> with driver collisions where simple "tier stickiness" would
> not. (Although collisions would be less likely to begin with given a
> broader range of possible distance values.)
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
> 
> [1] https://lore.kernel.org/linux-mm/20220607171949.85796-1-hannes@cmpxchg.org/#t


