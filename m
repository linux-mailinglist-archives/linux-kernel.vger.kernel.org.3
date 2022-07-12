Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE53057150C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 10:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232514AbiGLIs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 04:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232474AbiGLIsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 04:48:24 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA79FA9E41
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 01:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657615701; x=1689151701;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=IIX0Zsrk66VnATYBdenN++Ii/iU7GnyE7n8FlLOQuKA=;
  b=FDNdxQdcronr8yJibG37fV4yVG5OxF06FAIls0pZBzxDlg8xopXTtLAw
   sAHdDIFSrbZ9Pxm6kkEeqEPDETCxPdwwPPQCY3moxS7Kt65Mo/LDVmlqK
   HfyTHSvQabXOwe0qbDn+UYk/uKj/brXsO2lDuY7wRWc5AoMrHVkgrdZrQ
   mhy4OtrOhcHUsFcUxs/jzF14uNDNVbqjrwGqwZSIdFh2Xc0LW7MZmQpHM
   eTWcRqah7nqyYzWe9aZ9lFgdwR95LT/DzsZDJ7wSCzrJMmw+KiBkBHjNx
   w7xpwkZ+L9RBDhNteGFFH2ht9ARhBwIPfB7RldxC+pRVxOkNjFI43oMV5
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="286006677"
X-IronPort-AV: E=Sophos;i="5.92,265,1650956400"; 
   d="scan'208";a="286006677"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 01:48:21 -0700
X-IronPort-AV: E=Sophos;i="5.92,265,1650956400"; 
   d="scan'208";a="570115109"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.94])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 01:48:17 -0700
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
References: <20220704070612.299585-1-aneesh.kumar@linux.ibm.com>
        <87r130b2rh.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <60e97fa2-0b89-cf42-5307-5a57c956f741@linux.ibm.com>
        <87r12r5dwu.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <0a55e48a-b4b7-4477-a72f-73644b5fc4cb@linux.ibm.com>
        <87mtde6cla.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <fef35622-0bd4-f220-26bd-37d8e0112c4d@linux.ibm.com>
Date:   Tue, 12 Jul 2022 16:48:14 +0800
In-Reply-To: <fef35622-0bd4-f220-26bd-37d8e0112c4d@linux.ibm.com> (Aneesh
        Kumar K. V.'s message of "Tue, 12 Jul 2022 13:01:35 +0530")
Message-ID: <87ilo267jl.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> writes:

> On 7/12/22 12:29 PM, Huang, Ying wrote:
>> Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> writes:
>> 
>>> On 7/12/22 6:46 AM, Huang, Ying wrote:
>>>> Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> writes:
>>>>
>>>>> On 7/5/22 9:59 AM, Huang, Ying wrote:
>>>>>> Hi, Aneesh,
>>>>>>
>>>>>> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
>>>>>>
>>>>>>> The current kernel has the basic memory tiering support: Inactive
>>>>>>> pages on a higher tier NUMA node can be migrated (demoted) to a lower
>>>>>>> tier NUMA node to make room for new allocations on the higher tier
>>>>>>> NUMA node.  Frequently accessed pages on a lower tier NUMA node can be
>>>>>>> migrated (promoted) to a higher tier NUMA node to improve the
>>>>>>> performance.
>>>>>>>
>>>>>>> In the current kernel, memory tiers are defined implicitly via a
>>>>>>> demotion path relationship between NUMA nodes, which is created during
>>>>>>> the kernel initialization and updated when a NUMA node is hot-added or
>>>>>>> hot-removed.  The current implementation puts all nodes with CPU into
>>>>>>> the top tier, and builds the tier hierarchy tier-by-tier by establishing
>>>>>>> the per-node demotion targets based on the distances between nodes.
>>>>>>>
>>>>>>> This current memory tier kernel interface needs to be improved for
>>>>>>> several important use cases:
>>>>>>>
>>>>>>> * The current tier initialization code always initializes
>>>>>>>   each memory-only NUMA node into a lower tier.  But a memory-only
>>>>>>>   NUMA node may have a high performance memory device (e.g. a DRAM
>>>>>>>   device attached via CXL.mem or a DRAM-backed memory-only node on
>>>>>>>   a virtual machine) and should be put into a higher tier.
>>>>>>>
>>>>>>> * The current tier hierarchy always puts CPU nodes into the top
>>>>>>>   tier. But on a system with HBM (e.g. GPU memory) devices, these
>>>>>>>   memory-only HBM NUMA nodes should be in the top tier, and DRAM nodes
>>>>>>>   with CPUs are better to be placed into the next lower tier.
>>>>>>>
>>>>>>> * Also because the current tier hierarchy always puts CPU nodes
>>>>>>>   into the top tier, when a CPU is hot-added (or hot-removed) and
>>>>>>>   triggers a memory node from CPU-less into a CPU node (or vice
>>>>>>>   versa), the memory tier hierarchy gets changed, even though no
>>>>>>>   memory node is added or removed.  This can make the tier
>>>>>>>   hierarchy unstable and make it difficult to support tier-based
>>>>>>>   memory accounting.
>>>>>>>
>>>>>>> * A higher tier node can only be demoted to selected nodes on the
>>>>>>>   next lower tier as defined by the demotion path, not any other
>>>>>>>   node from any lower tier.  This strict, hard-coded demotion order
>>>>>>>   does not work in all use cases (e.g. some use cases may want to
>>>>>>>   allow cross-socket demotion to another node in the same demotion
>>>>>>>   tier as a fallback when the preferred demotion node is out of
>>>>>>>   space), and has resulted in the feature request for an interface to
>>>>>>>   override the system-wide, per-node demotion order from the
>>>>>>>   userspace.  This demotion order is also inconsistent with the page
>>>>>>>   allocation fallback order when all the nodes in a higher tier are
>>>>>>>   out of space: The page allocation can fall back to any node from
>>>>>>>   any lower tier, whereas the demotion order doesn't allow that.
>>>>>>>
>>>>>>> * There are no interfaces for the userspace to learn about the memory
>>>>>>>   tier hierarchy in order to optimize its memory allocations.
>>>>>>>
>>>>>>> This patch series make the creation of memory tiers explicit under
>>>>>>> the control of userspace or device driver.
>>>>>>>
>>>>>>> Memory Tier Initialization
>>>>>>> ==========================
>>>>>>>
>>>>>>> By default, all memory nodes are assigned to the default tier with
>>>>>>> tier ID value 200.
>>>>>>>
>>>>>>> A device driver can move up or down its memory nodes from the default
>>>>>>> tier.  For example, PMEM can move down its memory nodes below the
>>>>>>> default tier, whereas GPU can move up its memory nodes above the
>>>>>>> default tier.
>>>>>>>
>>>>>>> The kernel initialization code makes the decision on which exact tier
>>>>>>> a memory node should be assigned to based on the requests from the
>>>>>>> device drivers as well as the memory device hardware information
>>>>>>> provided by the firmware.
>>>>>>>
>>>>>>> Hot-adding/removing CPUs doesn't affect memory tier hierarchy.
>>>>>>>
>>>>>>> Memory Allocation for Demotion
>>>>>>> ==============================
>>>>>>> This patch series keep the demotion target page allocation logic same.
>>>>>>> The demotion page allocation pick the closest NUMA node in the
>>>>>>> next lower tier to the current NUMA node allocating pages from.
>>>>>>>
>>>>>>> This will be later improved to use the same page allocation strategy
>>>>>>> using fallback list.
>>>>>>>
>>>>>>> Sysfs Interface:
>>>>>>> -------------
>>>>>>> Listing current list of memory tiers details:
>>>>>>>
>>>>>>> :/sys/devices/system/memtier$ ls
>>>>>>> default_tier max_tier  memtier1  power  uevent
>>>>>>> :/sys/devices/system/memtier$ cat default_tier
>>>>>>> memtier200
>>>>>>> :/sys/devices/system/memtier$ cat max_tier 
>>>>>>> 400
>>>>>>> :/sys/devices/system/memtier$ 
>>>>>>>
>>>>>>> Per node memory tier details:
>>>>>>>
>>>>>>> For a cpu only NUMA node:
>>>>>>>
>>>>>>> :/sys/devices/system/node# cat node0/memtier 
>>>>>>> :/sys/devices/system/node# echo 1 > node0/memtier 
>>>>>>> :/sys/devices/system/node# cat node0/memtier 
>>>>>>> :/sys/devices/system/node# 
>>>>>>>
>>>>>>> For a NUMA node with memory:
>>>>>>> :/sys/devices/system/node# cat node1/memtier 
>>>>>>> 1
>>>>>>> :/sys/devices/system/node# ls ../memtier/
>>>>>>> default_tier  max_tier  memtier1  power  uevent
>>>>>>> :/sys/devices/system/node# echo 2 > node1/memtier 
>>>>>>> :/sys/devices/system/node# 
>>>>>>> :/sys/devices/system/node# ls ../memtier/
>>>>>>> default_tier  max_tier  memtier1  memtier2  power  uevent
>>>>>>> :/sys/devices/system/node# cat node1/memtier 
>>>>>>> 2
>>>>>>> :/sys/devices/system/node# 
>>>>>>>
>>>>>>> Removing a memory tier
>>>>>>> :/sys/devices/system/node# cat node1/memtier 
>>>>>>> 2
>>>>>>> :/sys/devices/system/node# echo 1 > node1/memtier
>>>>>>
>>>>>> Thanks a lot for your patchset.
>>>>>>
>>>>>> Per my understanding, we haven't reach consensus on
>>>>>>
>>>>>> - how to create the default memory tiers in kernel (via abstract
>>>>>>   distance provided by drivers?  Or use SLIT as the first step?)
>>>>>>
>>>>>> - how to override the default memory tiers from user space
>>>>>>
>>>>>> As in the following thread and email,
>>>>>>
>>>>>> https://lore.kernel.org/lkml/YqjZyP11O0yCMmiO@cmpxchg.org/
>>>>>>
>>>>>> I think that we need to finalized on that firstly?
>>>>>
>>>>> I did list the proposal here 
>>>>>
>>>>> https://lore.kernel.org/linux-mm/7b72ccf4-f4ae-cb4e-f411-74d055482026@linux.ibm.com
>>>>>
>>>>> So both the kernel default and driver-specific default tiers now become kernel parameters that can be updated
>>>>> if the user wants a different tier topology. 
>>>>>
>>>>> All memory that is not managed by a driver gets added to default_memory_tier which got a default value of 200
>>>>>
>>>>> For now, the only driver that is updated is dax kmem, which adds the memory it manages to memory tier 100.
>>>>> Later as we learn more about the device attributes (HMAT or something similar) that we might want to use
>>>>> to control the tier assignment this can be a range of memory tiers. 
>>>>>
>>>>> Based on the above, I guess we can merge what is posted in this series and later fine-tune/update
>>>>> the memory tier assignment based on device attributes.
>>>>
>>>> Sorry for late reply.
>>>>
>>>> As the first step, it may be better to skip the parts that we haven't
>>>> reached consensus yet, for example, the user space interface to override
>>>> the default memory tiers.  And we can use 0, 1, 2 as the default memory
>>>> tier IDs.  We can refine/revise the in-kernel implementation, but we
>>>> cannot change the user space ABI.
>>>>
>>>
>>> Can you help list the use case that will be broken by using tierID as outlined in this series?
>>> One of the details that were mentioned earlier was the need to track top-tier memory usage in a
>>> memcg and IIUC the patchset posted https://lore.kernel.org/linux-mm/cover.1655242024.git.tim.c.chen@linux.intel.com
>>> can work with tier IDs too. Let me know if you think otherwise. So at this point
>>> I am not sure which area we are still debating w.r.t the userspace interface.
>> 
>> In
>> 
>> https://lore.kernel.org/lkml/YqjZyP11O0yCMmiO@cmpxchg.org/
>> 
>> per my understanding, Johannes suggested to override the kernel default
>> memory tiers with "abstract distance" via drivers implementing memory
>> devices.  As you said in another email, that is related to [7/12] of the
>> series.  And we can table it for future.
>> 
>> And per my understanding, he also suggested to make memory tier IDs
>> dynamic.  For example, after the "abstract distance" of a driver is
>> overridden by users, the total number of memory tiers may be changed,
>> and the memory tier ID of some nodes may be changed too.  This will make
>> memory tier ID easier to be understood, but more unstable.  For example,
>> this will make it harder to specify the per-memory-tier memory partition
>> for a cgroup.
>> 
>
> With all the approaches we discussed so far, a memory tier of a numa node can be changed.
> ie, pgdat->memtier can change anytime. The per memcg top tier mem usage tracking patches
> posted here
> https://lore.kernel.org/linux-mm/cefeb63173fa0fac7543315a2abbd4b5a1b25af8.1655242024.git.tim.c.chen@linux.intel.com/
> doesn't consider the node movement from one memory tier to another. If we need
> a stable pgdat->memtier we will have to prevent a node memory tier reassignment
> while we have pages from the memory tier charged to a cgroup. This patchset should not
> prevent such a restriction.

Absolute stableness doesn't exist even in "rank" based solution.  But
"rank" can improve the stableness at some degree.  For example, if we
move the tier of HBM nodes (from below DRAM to above DRAM), the DRAM
nodes can keep its memory tier ID stable.  This may be not a real issue
finally.  But we need to discuss that.

Tim has suggested to use top-tier(s) memory partition among cgroups.
But I don't think that has been finalized.  We may use per-memory-tier
memory partition among cgroups.  I don't know whether Wei will use that
(may be implemented in the user space).

And, if we thought stableness between nodes and memory tier ID isn't
important.  Why should we use sparse memory device IDs (that is, 100,
200, 300)?  Why not just 0, 1, 2, ...?  That looks more natural.

> There are 3 knobs provided in this patchset. 
>
> 1. kernel parameter to change default memory tier. Changing this applies only to new memory that is
>  hotplugged. The existing node to memtier mapping remains the same.
>
> 2. module parameter to change dax kmem memory tier. Same as above. 

Why do we need these 2 knobs?  For example, we may use user space
overridden mechanism suggested by Johannes.

> 3. Ability to change node to memory tier mapping via /sys/devices/system/node/nodeN/memtier . We
>  should be able to add any restrictions w.r.t cgroup there. 

I think that we have decided to delay this feature ([7/12])?

Best Regards,
Huang, Ying

> Hence my observation is that the requirement for a stable node to memory tier mapping should not
> prevent the merging of this patch series.
>
>
>>> I will still keep the default tier IDs with a large range between them. That will allow
>>> us to go back to tierID based demotion order if we can. That is much simpler than using tierID and rank
>>> together. If we still want to go back to rank based approach the tierID value won't have much
>>> meaning anyway.
>> 
>> I agree to get rid of "rank".
>> 
>>> Any feedback on patches 1 - 5, so that I can request Andrew to merge
>>> them?
>> 
>> I hope that we can discuss with Johannes firstly.  But it appears that
>> he is busy recently.
>> 
>
>
> -aneesh
