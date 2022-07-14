Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E797574426
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 07:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232557AbiGNFCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 01:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbiGNFAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 01:00:22 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A2325E94
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 21:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657774637; x=1689310637;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=lwQnOGjgivQ5p2oJYc4Kbap67iNh8bkmNF0iKNVM8Oo=;
  b=GtPSE7cV+cUQQj2ay8gZSqzTOaSta9qsTh+r0Jg7W+nS4BwjVqHY1kL+
   tpXxKXIcwPjEZsuU4/9SSWhfEdThoMdzxBkOpQjBn9jfkgOGs7Bvbgaiw
   2Twjnu/eoQOx6UGu/xItgsHEQTiJ4tZpBvYGTdPQVQ+sVjkmVKXz0xFfK
   YXAi2JBGqMJQhvSagcz31cOL9e9WzMjpay+MJxYCm5rDqJzQbzS+r+QkZ
   /t0s3xZJpkcTS18hLQfE1yPJnRdqIJ0tfVqP/Rd6magt4nmA1Je+xT/9D
   aZ2FWY/Fz7Pmb9IThkvf9nc2dNlc/vtqVe+kigyT6mUlVtYtIQBQTBogf
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10407"; a="286554359"
X-IronPort-AV: E=Sophos;i="5.92,269,1650956400"; 
   d="scan'208";a="286554359"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 21:57:16 -0700
X-IronPort-AV: E=Sophos;i="5.92,269,1650956400"; 
   d="scan'208";a="546128526"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.94])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 21:57:13 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
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
Date:   Thu, 14 Jul 2022 12:56:55 +0800
In-Reply-To: <878roxuz9l.fsf@linux.ibm.com> (Aneesh Kumar K. V.'s message of
        "Wed, 13 Jul 2022 15:10:06 +0530")
Message-ID: <87o7xs47hk.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:

> "Huang, Ying" <ying.huang@intel.com> writes:

[snip]

>>
>> I believe that sparse memory tier IDs can make memory tier more stable
>> in some cases.  But this is different from the system suggested by
>> Johannes.  Per my understanding, with Johannes' system, we will
>>
>> - one driver may online different memory types (such as kmem_dax may
>>   online HBM, PMEM, etc.)
>>
>> - one memory type manages several memory nodes (NUMA nodes)
>>
>> - one "abstract distance" for each memory type
>>
>> - the "abstract distance" can be offset by user space override knob
>>
>> - memory tiers generated dynamic from different memory types according
>>   "abstract distance" and overridden "offset"
>>
>> - the granularity to group several memory types into one memory tier can
>>   be overridden via user space knob
>>
>> In this way, the memory tiers may be changed totally after user space
>> overridden.  It may be hard to link memory tiers before/after the
>> overridden.  So we may need to reset all per-memory-tier configuration,
>> such as cgroup paritation limit or interleave weight, etc.
>
> Making sure we all agree on the details.
>
> In the proposal https://lore.kernel.org/linux-mm/7b72ccf4-f4ae-cb4e-f411-74d055482026@linux.ibm.com
> instead of calling it "abstract distance" I was referring it as device
> attributes.
>
> Johannes also suggested these device attributes/"abstract distance"
> to be used to derive the memory tier to which the memory type/memory
> device will be assigned.
>
> So dax kmem would manage different types of memory and based on the device
> attributes, we would assign them to different memory tiers (memory tiers
> in the range [0-200)).
>
> Now the additional detail here is that we might add knobs that will be
> used by dax kmem to fine-tune memory types to memory tiers assignment.
> On updating these knob values, the kernel should rebuild the entire
> memory tier hierarchy. (earlier I was considering only newly added
> memory devices will get impacted by such a change. But I agree it
> makes sense to rebuild the entire hierarchy again) But that rebuilding
> will be restricted to dax kmem driver.
>

Thanks for explanation and pointer.  Per my understanding, memory
types and memory devices including abstract distances are used to
describe the *physical* memory devices, not *policy*.  We may add more
physical attributes to these memory devices, such as, latency,
throughput, etc.  I think we can reach consensus on this point?

In contrast, memory tiers are more about policy, such as
demotion/promotion, interleaving and possible partition among cgroups.
How to derive memory tiers from memory types (or devices)?  We have
multiple choices.

Per my understanding, Johannes suggested to use some policy parameters
such as distance granularity (e.g., if granularity is 100, then memory
devices with abstract distance 0-100, 100-200, 200-300, ... will be put
to memory tier 0, 1, 2, ...) to build the memory tiers.  Distance
granularity may be not flexible enough, we may need something like a set
of cutoffs or range, e.g., 50, 100, 200, 500, or 0-50, 50-100, 100-200,
200-500, >500.  These policy parameters should be overridable from user
space.

And per my understanding, you suggested to place memory devices to
memory tiers directly via a knob of memory types (or memory devices).
e.g., memory_type/memtier can be written to place the memory devices of
the memory_type to the specified memtier.  Or via
memorty_type/distance_offset to do that.

Best Regards,
Huang, Ying

[snip]
