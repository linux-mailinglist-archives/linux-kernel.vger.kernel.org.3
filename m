Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9AF570F52
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 03:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbiGLBQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 21:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbiGLBQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 21:16:13 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6004F33A13
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 18:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657588572; x=1689124572;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=sXhI0+wuScURP0q4s6eeIPcqRoIT4rKN0ec56T4agtc=;
  b=ERlLhTBJWJghM5rxoeH3xzO29st2iSb5M4mRcw6znyyx1Fd9Jujxlsam
   FOkGqOzAOExKVhQsMTmGfJkU32vZNgwEJfSKrOFPhowA8X9FSVf0xrtfm
   P+KW7ZcWCrrJS/f9LMEbhwruTOKXEZCnTkWVh98EuSowOLJgojiEl/Jx3
   qmGfSwAaFLIC6jICvl42FOQiOXb9zHIRFumkRk6lCNuhGepDy1yrch64A
   f+/+A5jtKbgwUbPMUsbCLQ0GdJL3GZ2ooHZfVQS7nLGQ6ZHcTRpKLx59L
   jRvQesHXGaAb5LOi1CQWG9GOGT9DfcQwLoj829CIt8iYYi9eXNznl3bHd
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="284836641"
X-IronPort-AV: E=Sophos;i="5.92,264,1650956400"; 
   d="scan'208";a="284836641"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 18:16:11 -0700
X-IronPort-AV: E=Sophos;i="5.92,264,1650956400"; 
   d="scan'208";a="569996812"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.94])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 18:16:04 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
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
        Johannes Weiner <hannes@cmpxchg.org>, jvgediya.oss@gmail.com
Subject: Re: [PATCH v8 00/12] mm/demotion: Memory tiers and demotion
References: <20220704070612.299585-1-aneesh.kumar@linux.ibm.com>
        <87r130b2rh.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <60e97fa2-0b89-cf42-5307-5a57c956f741@linux.ibm.com>
Date:   Tue, 12 Jul 2022 09:16:01 +0800
In-Reply-To: <60e97fa2-0b89-cf42-5307-5a57c956f741@linux.ibm.com> (Aneesh
        Kumar K. V.'s message of "Tue, 5 Jul 2022 10:52:05 +0530")
Message-ID: <87r12r5dwu.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> writes:

> On 7/5/22 9:59 AM, Huang, Ying wrote:
>> Hi, Aneesh,
>> 
>> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
>> 
>>> The current kernel has the basic memory tiering support: Inactive
>>> pages on a higher tier NUMA node can be migrated (demoted) to a lower
>>> tier NUMA node to make room for new allocations on the higher tier
>>> NUMA node.  Frequently accessed pages on a lower tier NUMA node can be
>>> migrated (promoted) to a higher tier NUMA node to improve the
>>> performance.
>>>
>>> In the current kernel, memory tiers are defined implicitly via a
>>> demotion path relationship between NUMA nodes, which is created during
>>> the kernel initialization and updated when a NUMA node is hot-added or
>>> hot-removed.  The current implementation puts all nodes with CPU into
>>> the top tier, and builds the tier hierarchy tier-by-tier by establishing
>>> the per-node demotion targets based on the distances between nodes.
>>>
>>> This current memory tier kernel interface needs to be improved for
>>> several important use cases:
>>>
>>> * The current tier initialization code always initializes
>>>   each memory-only NUMA node into a lower tier.  But a memory-only
>>>   NUMA node may have a high performance memory device (e.g. a DRAM
>>>   device attached via CXL.mem or a DRAM-backed memory-only node on
>>>   a virtual machine) and should be put into a higher tier.
>>>
>>> * The current tier hierarchy always puts CPU nodes into the top
>>>   tier. But on a system with HBM (e.g. GPU memory) devices, these
>>>   memory-only HBM NUMA nodes should be in the top tier, and DRAM nodes
>>>   with CPUs are better to be placed into the next lower tier.
>>>
>>> * Also because the current tier hierarchy always puts CPU nodes
>>>   into the top tier, when a CPU is hot-added (or hot-removed) and
>>>   triggers a memory node from CPU-less into a CPU node (or vice
>>>   versa), the memory tier hierarchy gets changed, even though no
>>>   memory node is added or removed.  This can make the tier
>>>   hierarchy unstable and make it difficult to support tier-based
>>>   memory accounting.
>>>
>>> * A higher tier node can only be demoted to selected nodes on the
>>>   next lower tier as defined by the demotion path, not any other
>>>   node from any lower tier.  This strict, hard-coded demotion order
>>>   does not work in all use cases (e.g. some use cases may want to
>>>   allow cross-socket demotion to another node in the same demotion
>>>   tier as a fallback when the preferred demotion node is out of
>>>   space), and has resulted in the feature request for an interface to
>>>   override the system-wide, per-node demotion order from the
>>>   userspace.  This demotion order is also inconsistent with the page
>>>   allocation fallback order when all the nodes in a higher tier are
>>>   out of space: The page allocation can fall back to any node from
>>>   any lower tier, whereas the demotion order doesn't allow that.
>>>
>>> * There are no interfaces for the userspace to learn about the memory
>>>   tier hierarchy in order to optimize its memory allocations.
>>>
>>> This patch series make the creation of memory tiers explicit under
>>> the control of userspace or device driver.
>>>
>>> Memory Tier Initialization
>>> ==========================
>>>
>>> By default, all memory nodes are assigned to the default tier with
>>> tier ID value 200.
>>>
>>> A device driver can move up or down its memory nodes from the default
>>> tier.  For example, PMEM can move down its memory nodes below the
>>> default tier, whereas GPU can move up its memory nodes above the
>>> default tier.
>>>
>>> The kernel initialization code makes the decision on which exact tier
>>> a memory node should be assigned to based on the requests from the
>>> device drivers as well as the memory device hardware information
>>> provided by the firmware.
>>>
>>> Hot-adding/removing CPUs doesn't affect memory tier hierarchy.
>>>
>>> Memory Allocation for Demotion
>>> ==============================
>>> This patch series keep the demotion target page allocation logic same.
>>> The demotion page allocation pick the closest NUMA node in the
>>> next lower tier to the current NUMA node allocating pages from.
>>>
>>> This will be later improved to use the same page allocation strategy
>>> using fallback list.
>>>
>>> Sysfs Interface:
>>> -------------
>>> Listing current list of memory tiers details:
>>>
>>> :/sys/devices/system/memtier$ ls
>>> default_tier max_tier  memtier1  power  uevent
>>> :/sys/devices/system/memtier$ cat default_tier
>>> memtier200
>>> :/sys/devices/system/memtier$ cat max_tier 
>>> 400
>>> :/sys/devices/system/memtier$ 
>>>
>>> Per node memory tier details:
>>>
>>> For a cpu only NUMA node:
>>>
>>> :/sys/devices/system/node# cat node0/memtier 
>>> :/sys/devices/system/node# echo 1 > node0/memtier 
>>> :/sys/devices/system/node# cat node0/memtier 
>>> :/sys/devices/system/node# 
>>>
>>> For a NUMA node with memory:
>>> :/sys/devices/system/node# cat node1/memtier 
>>> 1
>>> :/sys/devices/system/node# ls ../memtier/
>>> default_tier  max_tier  memtier1  power  uevent
>>> :/sys/devices/system/node# echo 2 > node1/memtier 
>>> :/sys/devices/system/node# 
>>> :/sys/devices/system/node# ls ../memtier/
>>> default_tier  max_tier  memtier1  memtier2  power  uevent
>>> :/sys/devices/system/node# cat node1/memtier 
>>> 2
>>> :/sys/devices/system/node# 
>>>
>>> Removing a memory tier
>>> :/sys/devices/system/node# cat node1/memtier 
>>> 2
>>> :/sys/devices/system/node# echo 1 > node1/memtier
>> 
>> Thanks a lot for your patchset.
>> 
>> Per my understanding, we haven't reach consensus on
>> 
>> - how to create the default memory tiers in kernel (via abstract
>>   distance provided by drivers?  Or use SLIT as the first step?)
>> 
>> - how to override the default memory tiers from user space
>> 
>> As in the following thread and email,
>> 
>> https://lore.kernel.org/lkml/YqjZyP11O0yCMmiO@cmpxchg.org/
>> 
>> I think that we need to finalized on that firstly?
>
> I did list the proposal here 
>
> https://lore.kernel.org/linux-mm/7b72ccf4-f4ae-cb4e-f411-74d055482026@linux.ibm.com
>
> So both the kernel default and driver-specific default tiers now become kernel parameters that can be updated
> if the user wants a different tier topology. 
>
> All memory that is not managed by a driver gets added to default_memory_tier which got a default value of 200
>
> For now, the only driver that is updated is dax kmem, which adds the memory it manages to memory tier 100.
> Later as we learn more about the device attributes (HMAT or something similar) that we might want to use
> to control the tier assignment this can be a range of memory tiers. 
>
> Based on the above, I guess we can merge what is posted in this series and later fine-tune/update
> the memory tier assignment based on device attributes.

Sorry for late reply.

As the first step, it may be better to skip the parts that we haven't
reached consensus yet, for example, the user space interface to override
the default memory tiers.  And we can use 0, 1, 2 as the default memory
tier IDs.  We can refine/revise the in-kernel implementation, but we
cannot change the user space ABI.

Best Regards,
Huang, Ying
