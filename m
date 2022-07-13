Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6EED573313
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 11:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234875AbiGMJm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 05:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236181AbiGMJmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 05:42:23 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F38BEF5D74
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 02:42:20 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26D9KUJd018813;
        Wed, 13 Jul 2022 09:41:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : content-type :
 mime-version; s=pp1; bh=WlhuHIFaw8lou36Z/sN63sh6UjUFaMTTng/QrABOpIM=;
 b=BmFKNCmdPXnvMB5xrNWvryyURsuogJbmFvequP0iJM5vxPZZJCMeM8gsFr3NgHfJSbGg
 pVoJpK9u1iPl3upFzna+kJtVXg7yOd+P7rUD/fE17f/yiehAyn72ngPGLvA6pyQZMaek
 eRzmIO2D2ifX7CkywcTZZ75cDeyYwds3UV0rNVUKukS+n7d5Uhs74QPUWEQNBC4SCIUK
 cWYRmA35k4YIIcg47A/ZujogAjZAqsWlc96gyuB4D8tYPah5XFMfYC8EUwEpUC9/JFQm
 ujnKlCnD/t/D+bs/mwqYXMgRfHJEbKogontL7YOjTOdvhBjsmWXMjrgUMMPB8QV0vy3O Wg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3h9ub60eu4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Jul 2022 09:41:32 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 26D9L8wC020242;
        Wed, 13 Jul 2022 09:41:32 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3h9ub60etk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Jul 2022 09:41:31 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26D9ahRC030229;
        Wed, 13 Jul 2022 09:41:31 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma02dal.us.ibm.com with ESMTP id 3h9am4peg4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Jul 2022 09:41:31 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26D9fUEm28836318
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jul 2022 09:41:30 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3746CAE062;
        Wed, 13 Jul 2022 09:41:30 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CA7F0AE060;
        Wed, 13 Jul 2022 09:40:09 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.43.122.219])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 13 Jul 2022 09:40:09 +0000 (GMT)
X-Mailer: emacs 29.0.50 (via feedmail 11-beta-1 I)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     "Huang, Ying" <ying.huang@intel.com>
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
In-Reply-To: <87edyp67m1.fsf@yhuang6-desk2.ccr.corp.intel.com>
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
Date:   Wed, 13 Jul 2022 15:10:06 +0530
Message-ID: <878roxuz9l.fsf@linux.ibm.com>
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: G61D4RC8Cmbu22RKRKO7zUcddQp0EfzQ
X-Proofpoint-ORIG-GUID: oIbyz33A7MbyF3oxqXmfFCU4HsIvQ-Nv
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-12_14,2022-07-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 phishscore=0 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=999 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207130040
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Huang, Ying" <ying.huang@intel.com> writes:

> Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> writes:
>
>> On 7/12/22 2:18 PM, Huang, Ying wrote:
>>> Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> writes:
>>> 
>>>> On 7/12/22 12:29 PM, Huang, Ying wrote:
>>>>> Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> writes:
>>>>>
>>>>>> On 7/12/22 6:46 AM, Huang, Ying wrote:
>>>>>>> Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> writes:
>>>>>>>
>>>>>>>> On 7/5/22 9:59 AM, Huang, Ying wrote:
>>>>>>>>> Hi, Aneesh,
>>>>>>>>>
>>>>>>>>> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
>>>>>>>>>
>>>>>>>>>> The current kernel has the basic memory tiering support: Inactive
>>>>>>>>>> pages on a higher tier NUMA node can be migrated (demoted) to a lower
>>>>>>>>>> tier NUMA node to make room for new allocations on the higher tier
>>>>>>>>>> NUMA node.  Frequently accessed pages on a lower tier NUMA node can be
>>>>>>>>>> migrated (promoted) to a higher tier NUMA node to improve the
>>>>>>>>>> performance.
>>>>>>>>>>
>>>>>>>>>> In the current kernel, memory tiers are defined implicitly via a
>>>>>>>>>> demotion path relationship between NUMA nodes, which is created during
>>>>>>>>>> the kernel initialization and updated when a NUMA node is hot-added or
>>>>>>>>>> hot-removed.  The current implementation puts all nodes with CPU into
>>>>>>>>>> the top tier, and builds the tier hierarchy tier-by-tier by establishing
>>>>>>>>>> the per-node demotion targets based on the distances between nodes.
>>>>>>>>>>
>>>>>>>>>> This current memory tier kernel interface needs to be improved for
>>>>>>>>>> several important use cases:
>>>>>>>>>>
>>>>>>>>>> * The current tier initialization code always initializes
>>>>>>>>>>   each memory-only NUMA node into a lower tier.  But a memory-only
>>>>>>>>>>   NUMA node may have a high performance memory device (e.g. a DRAM
>>>>>>>>>>   device attached via CXL.mem or a DRAM-backed memory-only node on
>>>>>>>>>>   a virtual machine) and should be put into a higher tier.
>>>>>>>>>>
>>>>>>>>>> * The current tier hierarchy always puts CPU nodes into the top
>>>>>>>>>>   tier. But on a system with HBM (e.g. GPU memory) devices, these
>>>>>>>>>>   memory-only HBM NUMA nodes should be in the top tier, and DRAM nodes
>>>>>>>>>>   with CPUs are better to be placed into the next lower tier.
>>>>>>>>>>
>>>>>>>>>> * Also because the current tier hierarchy always puts CPU nodes
>>>>>>>>>>   into the top tier, when a CPU is hot-added (or hot-removed) and
>>>>>>>>>>   triggers a memory node from CPU-less into a CPU node (or vice
>>>>>>>>>>   versa), the memory tier hierarchy gets changed, even though no
>>>>>>>>>>   memory node is added or removed.  This can make the tier
>>>>>>>>>>   hierarchy unstable and make it difficult to support tier-based
>>>>>>>>>>   memory accounting.
>>>>>>>>>>
>>>>>>>>>> * A higher tier node can only be demoted to selected nodes on the
>>>>>>>>>>   next lower tier as defined by the demotion path, not any other
>>>>>>>>>>   node from any lower tier.  This strict, hard-coded demotion order
>>>>>>>>>>   does not work in all use cases (e.g. some use cases may want to
>>>>>>>>>>   allow cross-socket demotion to another node in the same demotion
>>>>>>>>>>   tier as a fallback when the preferred demotion node is out of
>>>>>>>>>>   space), and has resulted in the feature request for an interface to
>>>>>>>>>>   override the system-wide, per-node demotion order from the
>>>>>>>>>>   userspace.  This demotion order is also inconsistent with the page
>>>>>>>>>>   allocation fallback order when all the nodes in a higher tier are
>>>>>>>>>>   out of space: The page allocation can fall back to any node from
>>>>>>>>>>   any lower tier, whereas the demotion order doesn't allow that.
>>>>>>>>>>
>>>>>>>>>> * There are no interfaces for the userspace to learn about the memory
>>>>>>>>>>   tier hierarchy in order to optimize its memory allocations.
>>>>>>>>>>
>>>>>>>>>> This patch series make the creation of memory tiers explicit under
>>>>>>>>>> the control of userspace or device driver.
>>>>>>>>>>
>>>>>>>>>> Memory Tier Initialization
>>>>>>>>>> ==========================
>>>>>>>>>>
>>>>>>>>>> By default, all memory nodes are assigned to the default tier with
>>>>>>>>>> tier ID value 200.
>>>>>>>>>>
>>>>>>>>>> A device driver can move up or down its memory nodes from the default
>>>>>>>>>> tier.  For example, PMEM can move down its memory nodes below the
>>>>>>>>>> default tier, whereas GPU can move up its memory nodes above the
>>>>>>>>>> default tier.
>>>>>>>>>>
>>>>>>>>>> The kernel initialization code makes the decision on which exact tier
>>>>>>>>>> a memory node should be assigned to based on the requests from the
>>>>>>>>>> device drivers as well as the memory device hardware information
>>>>>>>>>> provided by the firmware.
>>>>>>>>>>
>>>>>>>>>> Hot-adding/removing CPUs doesn't affect memory tier hierarchy.
>>>>>>>>>>
>>>>>>>>>> Memory Allocation for Demotion
>>>>>>>>>> ==============================
>>>>>>>>>> This patch series keep the demotion target page allocation logic same.
>>>>>>>>>> The demotion page allocation pick the closest NUMA node in the
>>>>>>>>>> next lower tier to the current NUMA node allocating pages from.
>>>>>>>>>>
>>>>>>>>>> This will be later improved to use the same page allocation strategy
>>>>>>>>>> using fallback list.
>>>>>>>>>>
>>>>>>>>>> Sysfs Interface:
>>>>>>>>>> -------------
>>>>>>>>>> Listing current list of memory tiers details:
>>>>>>>>>>
>>>>>>>>>> :/sys/devices/system/memtier$ ls
>>>>>>>>>> default_tier max_tier  memtier1  power  uevent
>>>>>>>>>> :/sys/devices/system/memtier$ cat default_tier
>>>>>>>>>> memtier200
>>>>>>>>>> :/sys/devices/system/memtier$ cat max_tier 
>>>>>>>>>> 400
>>>>>>>>>> :/sys/devices/system/memtier$ 
>>>>>>>>>>
>>>>>>>>>> Per node memory tier details:
>>>>>>>>>>
>>>>>>>>>> For a cpu only NUMA node:
>>>>>>>>>>
>>>>>>>>>> :/sys/devices/system/node# cat node0/memtier 
>>>>>>>>>> :/sys/devices/system/node# echo 1 > node0/memtier 
>>>>>>>>>> :/sys/devices/system/node# cat node0/memtier 
>>>>>>>>>> :/sys/devices/system/node# 
>>>>>>>>>>
>>>>>>>>>> For a NUMA node with memory:
>>>>>>>>>> :/sys/devices/system/node# cat node1/memtier 
>>>>>>>>>> 1
>>>>>>>>>> :/sys/devices/system/node# ls ../memtier/
>>>>>>>>>> default_tier  max_tier  memtier1  power  uevent
>>>>>>>>>> :/sys/devices/system/node# echo 2 > node1/memtier 
>>>>>>>>>> :/sys/devices/system/node# 
>>>>>>>>>> :/sys/devices/system/node# ls ../memtier/
>>>>>>>>>> default_tier  max_tier  memtier1  memtier2  power  uevent
>>>>>>>>>> :/sys/devices/system/node# cat node1/memtier 
>>>>>>>>>> 2
>>>>>>>>>> :/sys/devices/system/node# 
>>>>>>>>>>
>>>>>>>>>> Removing a memory tier
>>>>>>>>>> :/sys/devices/system/node# cat node1/memtier 
>>>>>>>>>> 2
>>>>>>>>>> :/sys/devices/system/node# echo 1 > node1/memtier
>>>>>>>>>
>>>>>>>>> Thanks a lot for your patchset.
>>>>>>>>>
>>>>>>>>> Per my understanding, we haven't reach consensus on
>>>>>>>>>
>>>>>>>>> - how to create the default memory tiers in kernel (via abstract
>>>>>>>>>   distance provided by drivers?  Or use SLIT as the first step?)
>>>>>>>>>
>>>>>>>>> - how to override the default memory tiers from user space
>>>>>>>>>
>>>>>>>>> As in the following thread and email,
>>>>>>>>>
>>>>>>>>> https://lore.kernel.org/lkml/YqjZyP11O0yCMmiO@cmpxchg.org/
>>>>>>>>>
>>>>>>>>> I think that we need to finalized on that firstly?
>>>>>>>>
>>>>>>>> I did list the proposal here 
>>>>>>>>
>>>>>>>> https://lore.kernel.org/linux-mm/7b72ccf4-f4ae-cb4e-f411-74d055482026@linux.ibm.com
>>>>>>>>
>>>>>>>> So both the kernel default and driver-specific default tiers now become kernel parameters that can be updated
>>>>>>>> if the user wants a different tier topology. 
>>>>>>>>
>>>>>>>> All memory that is not managed by a driver gets added to default_memory_tier which got a default value of 200
>>>>>>>>
>>>>>>>> For now, the only driver that is updated is dax kmem, which adds the memory it manages to memory tier 100.
>>>>>>>> Later as we learn more about the device attributes (HMAT or something similar) that we might want to use
>>>>>>>> to control the tier assignment this can be a range of memory tiers. 
>>>>>>>>
>>>>>>>> Based on the above, I guess we can merge what is posted in this series and later fine-tune/update
>>>>>>>> the memory tier assignment based on device attributes.
>>>>>>>
>>>>>>> Sorry for late reply.
>>>>>>>
>>>>>>> As the first step, it may be better to skip the parts that we haven't
>>>>>>> reached consensus yet, for example, the user space interface to override
>>>>>>> the default memory tiers.  And we can use 0, 1, 2 as the default memory
>>>>>>> tier IDs.  We can refine/revise the in-kernel implementation, but we
>>>>>>> cannot change the user space ABI.
>>>>>>>
>>>>>>
>>>>>> Can you help list the use case that will be broken by using tierID as outlined in this series?
>>>>>> One of the details that were mentioned earlier was the need to track top-tier memory usage in a
>>>>>> memcg and IIUC the patchset posted https://lore.kernel.org/linux-mm/cover.1655242024.git.tim.c.chen@linux.intel.com
>>>>>> can work with tier IDs too. Let me know if you think otherwise. So at this point
>>>>>> I am not sure which area we are still debating w.r.t the userspace interface.
>>>>>
>>>>> In
>>>>>
>>>>> https://lore.kernel.org/lkml/YqjZyP11O0yCMmiO@cmpxchg.org/
>>>>>
>>>>> per my understanding, Johannes suggested to override the kernel default
>>>>> memory tiers with "abstract distance" via drivers implementing memory
>>>>> devices.  As you said in another email, that is related to [7/12] of the
>>>>> series.  And we can table it for future.
>>>>>
>>>>> And per my understanding, he also suggested to make memory tier IDs
>>>>> dynamic.  For example, after the "abstract distance" of a driver is
>>>>> overridden by users, the total number of memory tiers may be changed,
>>>>> and the memory tier ID of some nodes may be changed too.  This will make
>>>>> memory tier ID easier to be understood, but more unstable.  For example,
>>>>> this will make it harder to specify the per-memory-tier memory partition
>>>>> for a cgroup.
>>>>>
>>>>
>>>> With all the approaches we discussed so far, a memory tier of a numa node can be changed.
>>>> ie, pgdat->memtier can change anytime. The per memcg top tier mem usage tracking patches
>>>> posted here
>>>> https://lore.kernel.org/linux-mm/cefeb63173fa0fac7543315a2abbd4b5a1b25af8.1655242024.git.tim.c.chen@linux.intel.com/
>>>> doesn't consider the node movement from one memory tier to another. If we need
>>>> a stable pgdat->memtier we will have to prevent a node memory tier reassignment
>>>> while we have pages from the memory tier charged to a cgroup. This patchset should not
>>>> prevent such a restriction.
>>> 
>>> Absolute stableness doesn't exist even in "rank" based solution.  But
>>> "rank" can improve the stableness at some degree.  For example, if we
>>> move the tier of HBM nodes (from below DRAM to above DRAM), the DRAM
>>> nodes can keep its memory tier ID stable.  This may be not a real issue
>>> finally.  But we need to discuss that.
>>> 
>>
>> I agree that using ranks gives us the flexibility to change demotion order
>> without being blocked by cgroup usage. But how frequently do we expect the
>> tier assignment to change? My expectation was these reassignments are going
>> to be rare and won't happen frequently after a system is up and running?
>> Hence using tierID for demotion order won't prevent a node reassignment
>> much because we don't expect to change the node tierID during runtime. In
>> the rare case we do, we will have to make sure there is no cgroup usage from
>> the specific memory tier. 
>>
>> Even if we use ranks, we will have to avoid a rank update, if such
>> an update can change the meaning of top tier? ie, if a rank update
>> can result in a node being moved from top tier to non top tier.
>>
>>> Tim has suggested to use top-tier(s) memory partition among cgroups.
>>> But I don't think that has been finalized.  We may use per-memory-tier
>>> memory partition among cgroups.  I don't know whether Wei will use that
>>> (may be implemented in the user space).
>>> 
>>> And, if we thought stableness between nodes and memory tier ID isn't
>>> important.  Why should we use sparse memory device IDs (that is, 100,
>>> 200, 300)?  Why not just 0, 1, 2, ...?  That looks more natural.
>>> 
>>
>>
>> The range allows us to use memtier ID for demotion order. ie, as we start initializing
>> devices with different attributes via dax kmem, there will be a desire to
>> assign them to different tierIDs. Having default memtier ID (DRAM) at 200 enables
>> us to put these devices in the range [0 - 200) without updating the node to memtier
>> mapping of existing NUMA nodes (ie, without updating default memtier).
>
> I believe that sparse memory tier IDs can make memory tier more stable
> in some cases.  But this is different from the system suggested by
> Johannes.  Per my understanding, with Johannes' system, we will
>
> - one driver may online different memory types (such as kmem_dax may
>   online HBM, PMEM, etc.)
>
> - one memory type manages several memory nodes (NUMA nodes)
>
> - one "abstract distance" for each memory type
>
> - the "abstract distance" can be offset by user space override knob
>
> - memory tiers generated dynamic from different memory types according
>   "abstract distance" and overridden "offset"
>
> - the granularity to group several memory types into one memory tier can
>   be overridden via user space knob
>
> In this way, the memory tiers may be changed totally after user space
> overridden.  It may be hard to link memory tiers before/after the
> overridden.  So we may need to reset all per-memory-tier configuration,
> such as cgroup paritation limit or interleave weight, etc.

Making sure we all agree on the details.

In the proposal https://lore.kernel.org/linux-mm/7b72ccf4-f4ae-cb4e-f411-74d055482026@linux.ibm.com
instead of calling it "abstract distance" I was referring it as device
attributes.

Johannes also suggested these device attributes/"abstract distance"
to be used to derive the memory tier to which the memory type/memory
device will be assigned.

So dax kmem would manage different types of memory and based on the device
attributes, we would assign them to different memory tiers (memory tiers
in the range [0-200)).

Now the additional detail here is that we might add knobs that will be
used by dax kmem to fine-tune memory types to memory tiers assignment.
On updating these knob values, the kernel should rebuild the entire
memory tier hierarchy. (earlier I was considering only newly added
memory devices will get impacted by such a change. But I agree it
makes sense to rebuild the entire hierarchy again) But that rebuilding
will be restricted to dax kmem driver.


>
> Personally, I think the system above makes sense.  But I think we need
> to make sure whether it satisfies the requirements.

-aneesh
