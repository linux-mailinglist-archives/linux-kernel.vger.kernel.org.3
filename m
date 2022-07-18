Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34280577AC7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 08:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233366AbiGRGIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 02:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233274AbiGRGIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 02:08:19 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7CD513D55
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 23:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658124498; x=1689660498;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=Iy/C5nIVHEHmLHZUhJ378y+kBUGWLBxvC8bLlhAGmqQ=;
  b=NdV1h5FqFZ3UXKpgpG2vNpy80V5JSSvZUs3JW1/NLfWBM2TY+KEx74SJ
   FHgNqKppSf05glbUXsvccWWV6w1rk/d5ypdhXxY8qwBOvXLXSElMXkE9q
   w3OuUujy8sMbblab2jXmmVLFCLfqShkePoEGJV/m5d5S8koUhB5HpJf3y
   /OtEZYeCpVY4fh5KqAXwDwVxLUEVEpUpXOhFbsqCrnbU1gR2IzOb9+yk7
   D47+xmjR5mP1B1dGOqrcrDy6NKAu/ZZOF2f8hElZppZNPofvlm5lwOsrd
   /gadLPCCb1QdVNg/vRu8zo9yaaHubXN6TFP9EXgTgKWDnPpm3WN/i68O0
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10411"; a="347831482"
X-IronPort-AV: E=Sophos;i="5.92,280,1650956400"; 
   d="scan'208";a="347831482"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2022 23:08:18 -0700
X-IronPort-AV: E=Sophos;i="5.92,280,1650956400"; 
   d="scan'208";a="572269840"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.94])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2022 23:08:14 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        Wei Xu <weixugc@google.com>, Yang Shi <shy828301@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim C Chen <tim.c.chen@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>, jvgediya.oss@gmail.com,
        Jagdish Gediya <jvgediya@linux.ibm.com>
Subject: Re: [PATCH v9 1/8] mm/demotion: Add support for explicit memory tiers
References: <20220714045351.434957-1-aneesh.kumar@linux.ibm.com>
        <20220714045351.434957-2-aneesh.kumar@linux.ibm.com>
        <87bktq4xs7.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <3659f1bb-a82e-1aad-f297-808a2c17687d@linux.ibm.com>
        <87sfn2u0vy.fsf@linux.ibm.com>
Date:   Mon, 18 Jul 2022 14:08:11 +0800
In-Reply-To: <87sfn2u0vy.fsf@linux.ibm.com> (Aneesh Kumar K. V.'s message of
        "Fri, 15 Jul 2022 15:57:13 +0530")
Message-ID: <87y1wr2bsk.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:

> Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> writes:
>
> ....
>
>> 
>>> You dropped the original sysfs interface patches from the series, but
>>> the kernel internal implementation is still for the original sysfs
>>> interface.  For example, memory tier ID is for the original sysfs
>>> interface, not for the new proposed sysfs interface.  So I suggest you
>>> to implement with the new interface in mind.  What do you think about
>>> the following design?
>>> 
>>
>> Sorry I am not able to follow you here. This patchset completely drops
>> exposing memory tiers to userspace via sysfs. Instead it allow
>> creation of memory tiers with specific tierID from within the kernel/device driver.
>> Default tierID is 200 and dax kmem creates memory tier with tierID 100. 
>>
>>
>>> - Each NUMA node belongs to a memory type, and each memory type
>>>   corresponds to a "abstract distance", so each NUMA node corresonds to
>>>   a "distance".  For simplicity, we can start with static distances, for
>>>   example, DRAM (default): 150, PMEM: 250.  The distance of each NUMA
>>>   node can be recorded in a global array,
>>> 
>>>     int node_distances[MAX_NUMNODES];
>>> 
>>>   or, just
>>> 
>>>     pgdat->distance
>>> 
>>
>> I don't follow this. I guess you are trying to have a different design.
>> Would it be much easier if you can write this in the form of a patch? 
>>
>>
>>> - Each memory tier corresponds to a range of distance, for example,
>>>   0-100, 100-200, 200-300, >300, we can start with static ranges too.
>>> 
>>> - The core API of memory tier could be
>>> 
>>>     struct memory_tier *find_create_memory_tier(int distance);
>>> 
>>>   it will find the memory tier which covers "distance" in the memory
>>>   tier list, or create a new memory tier if not found.
>>> 
>>
>> I was expecting this to be internal to dax kmem. How dax kmem maps
>> "abstract distance" to a memory tier. At this point this patchset is
>> keeping all that for a future patchset. 
>>
>
> This shows how i was expecting "abstract distance" to be integrated.
>

Thanks!

To make the first version as simple as possible, I think we can just use
some static "abstract distance" for dax_kmem, e.g., 250.  Because we
use it for PMEM only now.  We can enhance dax_kmem later.

IMHO, we should make the core framework correct firstly.

- A device driver should report the capability (or performance level) of
  the hardware to the memory tier core via abstract distance.  This can
  be done via some global data structure (e.g. node_distances[]) at
  least in the first version.

- Memory tier core determines the mapping from the abstract distance to
  the memory tier via abstract distance ranges, and allocate the struct
  memory_tier when necessary.  That is, memory tier core determines
  whether to allocate or reuse which memory tier for NUMA nodes, not
  device drivers.

- It's better to place the NUMA node to the correct memory tier in the
  fist place.  We should avoid to place the PMEM node in the default
  tier, then change it to the correct memory tier.  That is, device
  drivers should report the abstract distance before onlining NUMA
  nodes.

Please check my reply to Wei too about my other suggestions for the
first version.

Best Regards,
Huang, Ying
