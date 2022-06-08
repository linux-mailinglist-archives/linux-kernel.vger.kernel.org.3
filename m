Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF6B54260D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232654AbiFHEKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 00:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232990AbiFHEJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 00:09:10 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA582A7880
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 18:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654651534; x=1686187534;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vtC+x3VoF0hLY5wXut7y+fi1xuSuwdoRGPO6T7AZRfU=;
  b=ZXZS+H7pMuH2XBqTVgl9vGMOydTTzfQcMBtxVwg4A0liloYM16EYHNBl
   Dc+2mgwulNFpvtVBRS/qKRheVbU6wXecTeBAGB5aI/uS2NbORqfyjMmIV
   D9G9qvIF/1vBzAlg1GUjyTGuXpu04uQ5M8pFLF0piE0jMuVxXOhUVV/lh
   7cXN+MyRonNLwQXnT9cBJ5QIlP+v7mt5om4hpSM3GYzVtABiaVCBBO3P9
   M2cngAvimu8pxnvLHuiB8FeBDtZgKfPgebU+ihCcuOEw7sb823XHAck9E
   moGr+132fdtDx9hLivFGSYmiWivYSlH/7SWop2GWaG3O7vwnJAqQtVzDK
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10371"; a="302132141"
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="302132141"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 18:24:31 -0700
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="584522217"
Received: from wantingz-mobl.ccr.corp.intel.com ([10.254.214.193])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 18:24:27 -0700
Message-ID: <8e826a0ae730f6f6e43e82a26a9e22059a5a1682.camel@intel.com>
Subject: Re: [RFC PATCH v4 1/7] mm/demotion: Add support for explicit memory
 tiers
From:   Ying Huang <ying.huang@intel.com>
To:     Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
Cc:     Greg Thelen <gthelen@google.com>, Yang Shi <shy828301@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim C Chen <tim.c.chen@intel.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        David Rientjes <rientjes@google.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org
Date:   Wed, 08 Jun 2022 09:24:25 +0800
In-Reply-To: <1301311f-12f0-0fda-1245-82bb4c3f5e93@linux.ibm.com>
References: <CAAPL-u-dFp7PwPH6DfbYdnY8xaGsHz3tRQ0CPGVkiqURvdN8=A@mail.gmail.com>
         <20220527122528.129445-1-aneesh.kumar@linux.ibm.com>
         <20220527122528.129445-2-aneesh.kumar@linux.ibm.com>
         <352ae5f408b6d7d4d3d820d68e2f2c6b494e95e1.camel@intel.com>
         <aeced91ea9d9396e9842f5c0264391aabd291726.camel@intel.com>
         <d429a644-ef27-bcd8-52bd-c8cbe5fedc26@linux.ibm.com>
         <143e40bcf46097d14514504518fdc1870fd8d4a1.camel@intel.com>
         <eb6d7346-32a9-4fb2-61c2-a413c9f94f1c@linux.ibm.com>
         <87ilpe8fxh.fsf@linux.ibm.com>
         <a20f4db3c55f9471d27eacd7a8a245691a8fcd2f.camel@intel.com>
         <b97d2013-ad5e-9b29-0b95-f52273bd3a8b@linux.ibm.com>
         <d36eabfdc062aeb5aee18ab7ac0bca36b19f8521.camel@intel.com>
         <1301311f-12f0-0fda-1245-82bb4c3f5e93@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-06-06 at 14:32 +0530, Aneesh Kumar K V wrote:
> On 6/6/22 2:22 PM, Ying Huang wrote:
> ....
> > > > > I can move the patch "mm/demotion/dax/kmem: Set node's memory tier to
> > > > > MEMORY_TIER_PMEM" before switching the demotion logic so that on systems
> > > > > with two memory tiers (DRAM and pmem) the demotion continues to work
> > > > > as expected after patch 3 ("mm/demotion: Build demotion targets based on
> > > > > explicit memory tiers"). With that, there will not be any regression in
> > > > > between the patch series.
> > > > > 
> > > > 
> > > > Thanks!  Please do that.  And I think you can add sysfs interface after
> > > > that patch too.  That is, in [1/7]
> > > > 
> > > 
> > > I am not sure why you insist on moving sysfs interfaces later. They are
> > > introduced based on the helper added. It make patch review easier to
> > > look at both the helpers and the user of the helper together in a patch.
> > 
> > Yes.  We should introduce a function and its user in one patch for
> > review.  But this doesn't mean that we should introduce the user space
> > interface as the first step.  I think the user space interface should
> > output correct information when we expose it.
> > 
> 
> If you look at this patchset we are not exposing any wrong information.
> 
> patch 1 -> adds ability to register the memory tiers and expose details 
> of registered memory tier. At this point the patchset only support DRAM 
> tier and hence only one tier is shown

But inside kernel, we actually work with 2 tiers and demote/prmote pages
between them.  With the information from your interface, users would
think that there is no any demotion/promotion in kernel because there's
only 1 tier.

> patch 2 -> adds per node memtier attribute. So only DRAM nodes shows the 
> details, because the patchset yet has not introduced a slower memory 
> tier like PMEM.
> 
> patch 4 -> introducing demotion. Will make that patch 5
> 
> patch 5 -> add dax kmem numa nodes as slower memory tier. Now this 
> becomes patch 4 at which point we will correctly show two memory tiers 
> in the system.
> 
> 
> > > > +struct memory_tier {
> > > > +	nodemask_t nodelist;
> > > > +};
> > > > 
> > > > And struct device can be added after the kernel has switched the
> > > > implementation based on explicit memory tiers.
> > > > 
> > > > +struct memory_tier {
> > > > +	struct device dev;
> > > > +	nodemask_t nodelist;
> > > > +};
> > > > 
> > > 
> > > 
> > > Can you elaborate on this? or possibly review the v5 series indicating
> > > what change you are suggesting here?
> > > 
> > > 
> > > > But I don't think it's a good idea to have "struct device" embedded in
> > > > "struct memory_tier".  We don't have "struct device" embedded in "struct
> > > > pgdata_list"...
> > > > 
> > > 
> > > I avoided creating an array for memory_tier (memory_tier[]) so that we
> > > can keep it dynamic. Keeping dev embedded in struct memory_tier simplify
> > > the life cycle management of that dynamic list. We free the struct
> > > memory_tier allocation via device release function (memtier->dev.release
> > > = memory_tier_device_release )
> > > 
> > > Why do you think it is not a good idea?
> > 
> > I think that we shouldn't bind our kernel internal implementation with
> > user space interface too much.  Yes.  We can expose kernel internal
> > implementation to user space in a direct way.  I suggest you to follow
> > the style of "struct pglist_data" and "struct node".  If we decouple
> > "struct memory_tier" and "struct memory_tier_dev" (or some other name),
> > we can refer to "struct memory_tier" without depending on all device
> > core.  Memory tier should be accessible inside the kernel even without a
> > user interface.  And memory tier isn't a device in concept.
> > 
> 
> memory_tiers are different from pglist_data and struct node in that we 
> also allow the creation of them from userspace.

I don't think that there's much difference.  struct pglist_data and
struct node can be created/destroyed dynamically too.  Please take a
look at

  __try_online_node()
  register_one_node()
  try_offline_node()
  unregister_one_node()

> That is the life time of 
> a memory tier is driven from userspace and it is much easier to manage 
> them via sysfs file lifetime mechanism rather than inventing an 
> independent and more complex way of doing the same.

You needs to manage the lifetime of struct memory_tier in kernel too. 
Because there are kernel users.  And even if you use device core
lifetime mechanism, you don't need to embed struct device in struct
memory_tier too, you can free "separate" struct memory_tier in "release"
callback of struct device.

> > For life cycle management, I think that we can do that without sysfs
> > too.
> > 
> 
> unless there are specific details that you think will be broken by 
> embedding struct device inside struct memory_tier, IMHO I still consider 
> the embedded implementation much simpler and in accordance with other 
> kernel design patterns.

In concept, struct memory_tier isn't a device.  Although we expose it as
a device in sysfs.  That's just an implementation detail.  So I think
it's better to make struct memory_tier independent of struct device if
possible.

Via not embeding struct device in struct memory_tier, it's much easier
to dereference struct memory_tier directly in inline function in ".h". 
We don't need to introduce one accessor function for each field of
struct memory_tier for that.

Best Regards,
Huang, Ying


