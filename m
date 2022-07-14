Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 729CF5745CE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 09:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236686AbiGNHVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 03:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbiGNHVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 03:21:20 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5154E12D16
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 00:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657783279; x=1689319279;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=uFvTT90ASqkAYU1hw+FzUocxYkA9Bx3aChsoh1OLC08=;
  b=Lmzv3l2jH5o17ifl8kMelsSTShrRJuuUhWLULjz+YRB9z3Ilo6XApzv5
   AtbhXZbx0lLx22JYeyU4LAWJErlxGwlGf4zqotU9hhqtkGyJ456vP8nBG
   pPSxepZ06gE1AaEr5HORSS7eW7369o99b9ckFO7p51j5Um8PluOHDRp/J
   0oUEZLdyCb/7mHjOCt2TX/XIMdbtSLSMA+VUZ8Acdj78fuu9HrA3qsNQc
   /W9ZqA86UIZ2w3/abLVgEBvIgK6KgxWnbQ0udpRlwEaldO+kNlkQn76Yo
   ylKrefJ+6JScH4c3U0gl0p+2A4pswcjNhiNuNcgG6/XQGncVwwfSRabVG
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10407"; a="265227107"
X-IronPort-AV: E=Sophos;i="5.92,269,1650956400"; 
   d="scan'208";a="265227107"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 00:21:19 -0700
X-IronPort-AV: E=Sophos;i="5.92,269,1650956400"; 
   d="scan'208";a="570953254"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.94])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 00:21:15 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
        akpm@linux-foundation.org, Wei Xu <weixugc@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim C Chen <tim.c.chen@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>, jvgediya.oss@gmail.com
Subject: Re: [PATCH v8 00/12] mm/demotion: Memory tiers and demotion
In-Reply-To: <1c4bfd5d-80ac-6fc7-80aa-89aaad5cd73a@linux.ibm.com> (Aneesh
        Kumar K. V.'s message of "Thu, 14 Jul 2022 10:59:23 +0530")
References: <20220704070612.299585-1-aneesh.kumar@linux.ibm.com>
        <87r130b2rh.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <60e97fa2-0b89-cf42-5307-5a57c956f741@linux.ibm.com>
        <87r12r5dwu.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <0a55e48a-b4b7-4477-a72f-73644b5fc4cb@linux.ibm.com>
        <87mtde6cla.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <fef35622-0bd4-f220-26bd-37d8e0112c4d@linux.ibm.com>
        <87ilo267jl.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <ad4b095b-bb85-b01f-5d69-383219384c29@linux.ibm.com>
        <87edyp67m1.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <878roxuz9l.fsf@linux.ibm.com>
        <87o7xs47hk.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <1c4bfd5d-80ac-6fc7-80aa-89aaad5cd73a@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Date:   Thu, 14 Jul 2022 15:21:11 +0800
Message-ID: <87ilo040t4.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> writes:

> On 7/14/22 10:26 AM, Huang, Ying wrote:
>> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
>> 
>>> "Huang, Ying" <ying.huang@intel.com> writes:
>> 
>> [snip]
>> 
>>>>
>>>> I believe that sparse memory tier IDs can make memory tier more stable
>>>> in some cases.  But this is different from the system suggested by
>>>> Johannes.  Per my understanding, with Johannes' system, we will
>>>>
>>>> - one driver may online different memory types (such as kmem_dax may
>>>>   online HBM, PMEM, etc.)
>>>>
>>>> - one memory type manages several memory nodes (NUMA nodes)
>>>>
>>>> - one "abstract distance" for each memory type
>>>>
>>>> - the "abstract distance" can be offset by user space override knob
>>>>
>>>> - memory tiers generated dynamic from different memory types according
>>>>   "abstract distance" and overridden "offset"
>>>>
>>>> - the granularity to group several memory types into one memory tier can
>>>>   be overridden via user space knob
>>>>
>>>> In this way, the memory tiers may be changed totally after user space
>>>> overridden.  It may be hard to link memory tiers before/after the
>>>> overridden.  So we may need to reset all per-memory-tier configuration,
>>>> such as cgroup paritation limit or interleave weight, etc.
>>>
>>> Making sure we all agree on the details.
>>>
>>> In the proposal https://lore.kernel.org/linux-mm/7b72ccf4-f4ae-cb4e-f411-74d055482026@linux.ibm.com
>>> instead of calling it "abstract distance" I was referring it as device
>>> attributes.
>>>
>>> Johannes also suggested these device attributes/"abstract distance"
>>> to be used to derive the memory tier to which the memory type/memory
>>> device will be assigned.
>>>
>>> So dax kmem would manage different types of memory and based on the device
>>> attributes, we would assign them to different memory tiers (memory tiers
>>> in the range [0-200)).
>>>
>>> Now the additional detail here is that we might add knobs that will be
>>> used by dax kmem to fine-tune memory types to memory tiers assignment.
>>> On updating these knob values, the kernel should rebuild the entire
>>> memory tier hierarchy. (earlier I was considering only newly added
>>> memory devices will get impacted by such a change. But I agree it
>>> makes sense to rebuild the entire hierarchy again) But that rebuilding
>>> will be restricted to dax kmem driver.
>>>
>> 
>> Thanks for explanation and pointer.  Per my understanding, memory
>> types and memory devices including abstract distances are used to
>> describe the *physical* memory devices, not *policy*.  We may add more
>> physical attributes to these memory devices, such as, latency,
>> throughput, etc.  I think we can reach consensus on this point?
>> 
>> In contrast, memory tiers are more about policy, such as
>> demotion/promotion, interleaving and possible partition among cgroups.
>> How to derive memory tiers from memory types (or devices)?  We have
>> multiple choices.
>> 
>
> agreed to the above.
>
>> Per my understanding, Johannes suggested to use some policy parameters
>> such as distance granularity (e.g., if granularity is 100, then memory
>> devices with abstract distance 0-100, 100-200, 200-300, ... will be put
>> to memory tier 0, 1, 2, ...) to build the memory tiers.  Distance
>> granularity may be not flexible enough, we may need something like a set
>> of cutoffs or range, e.g., 50, 100, 200, 500, or 0-50, 50-100, 100-200,
>> 200-500, >500.  These policy parameters should be overridable from user
>> space.
>> 
>
> The term distance was always confusing to me. Instead, I was
> generalizing it as an attribute.

Attributes sounds too general to me :-)

> The challenge with the term distance for me was in clarifying the
> distance of this memory device from where? Instead, it is much simpler
> to group devices based on device attributes such as write latency.

Per my understanding, the "distance" here is the distance from local
CPUs, that is, get rid of the influence of NUMA topology as much as
possible.

There may be other memory accessing initiators in the system, such as
GPU, etc.  But we don't want to have different memory tiers for each
initiators, so we mainly consider CPUs.  The device drivers of other
initiators may consider other type of memory tiers.

The "distance" characters the latency of the memory device under typical
memory throughput in the system.  So it characterizes both latency and
throughput, because the latency will increase with the throughput.  This
one of reasons we need to override the default distance, because the
typical memory throughput may be different among different workloads.

The "abstract distance" can come from SLIT, HMAT firstly.  Then we can
try to explore the other possible sources of information.

> So everything you explained above is correct, except we describe it in terms of a
> single device attribute or a combination of multiple device attributes. We could convert
> a combination of multiple device attribute to an "abstract distance".

Sounds good to me.

> Such an "abstract distance" is derived based on different device
> attribute values with policy parameters overridable from userspace.

I think "abstract distance" is different from policy parameters.

>> And per my understanding, you suggested to place memory devices to
>> memory tiers directly via a knob of memory types (or memory devices).
>> e.g., memory_type/memtier can be written to place the memory devices of
>> the memory_type to the specified memtier.  Or via
>> memorty_type/distance_offset to do that.
>> 
>
> What I explained above is what I would expect the kernel to do by default. Before we can
> reach there we need to get a better understanding of which device attribute describes
> the grouping of memory devices to a memory tier. Do we need latency-based grouping
> or bandwidth-based grouping? Till then userspace can place these devices to different
> memory tiers. Hence the addition of /sys/devices/system/node/nodeN/memtier write feature
> which moves a memory node to a specific memory tier. 
>
> I am not suggesting we override the memory types from userspace.

OK.  I don't think we need this.  We can examine the target solution
above and try to find any issue with it.

Best Regards,
Huang, Ying
