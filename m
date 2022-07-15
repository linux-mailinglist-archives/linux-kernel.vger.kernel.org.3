Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA1F575E75
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 11:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231998AbiGOJY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 05:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbiGOJY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 05:24:56 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6674D77A7F
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 02:24:55 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26F97ILI001577;
        Fri, 15 Jul 2022 09:24:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=jOPCDgt909fqm2rts/2DiFiVoEhbYfARHQH9CcW/wdI=;
 b=czyBieGoW1VHbZV6QiKUzBGdoFmmwnmYsLnfXyMzsqL79rN9SdxjkJcjG3a+u0pDRcM8
 shIxS4IWBdvuaXl4KpBUBh2O1jPh/x7Et5Kp+C91BbyH7hrpkdagdmodCFh1vQhpeXjJ
 m4DRS7oOY7FsRZGtKxB2ITdRR7K1DtWlYiWeA8H9qNdB6j1lroY/gUbxqiQu6EnuFrlP
 bAjDjp3Jdg9eWpEkmUpmIJe6JUf462iZ3aYkfxtQYu5MKLB0ZkX7oj6FG1V7XSFNlJSw
 JdhmOZXr0V/E6+Ye7RmFIQNkhGpWnUdArDxtrDzwm6Roit3FNw4k9VuKEqbrfKN3AtUT iQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hb37g3guy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Jul 2022 09:24:39 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 26F97TpI002997;
        Fri, 15 Jul 2022 09:24:38 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hb37g3gua-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Jul 2022 09:24:38 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26F9KcnI018223;
        Fri, 15 Jul 2022 09:24:36 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3h71a906st-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Jul 2022 09:24:36 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26F9Ojju33161666
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Jul 2022 09:24:45 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 08C30A4051;
        Fri, 15 Jul 2022 09:24:34 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DE148A4055;
        Fri, 15 Jul 2022 09:24:28 +0000 (GMT)
Received: from [9.43.84.38] (unknown [9.43.84.38])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 15 Jul 2022 09:24:28 +0000 (GMT)
Message-ID: <ac0ae2fb-b613-76ee-cf29-ed2abc52bbd5@linux.ibm.com>
Date:   Fri, 15 Jul 2022 14:54:27 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v9 1/8] mm/demotion: Add support for explicit memory tiers
Content-Language: en-US
From:   Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
To:     "Huang, Ying" <ying.huang@intel.com>
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
References: <20220714045351.434957-1-aneesh.kumar@linux.ibm.com>
 <20220714045351.434957-2-aneesh.kumar@linux.ibm.com>
 <87bktq4xs7.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <3659f1bb-a82e-1aad-f297-808a2c17687d@linux.ibm.com>
In-Reply-To: <3659f1bb-a82e-1aad-f297-808a2c17687d@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: x2hQhQERjU7us09S1xUZ4CV89QLzVWDq
X-Proofpoint-ORIG-GUID: 85Bq7JjysbxQwEmAnmdLhwq0XbGYzlSx
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-15_03,2022-07-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 lowpriorityscore=0 mlxscore=0 bulkscore=0 adultscore=0
 malwarescore=0 impostorscore=0 phishscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207150039
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/15/22 2:38 PM, Aneesh Kumar K V wrote:
> On 7/15/22 1:23 PM, Huang, Ying wrote:
>> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
>>
>>> In the current kernel, memory tiers are defined implicitly via a
>>> demotion path relationship between NUMA nodes, which is created
>>> during the kernel initialization and updated when a NUMA node is
>>> hot-added or hot-removed.  The current implementation puts all
>>> nodes with CPU into the top tier, and builds the tier hierarchy
>>> tier-by-tier by establishing the per-node demotion targets based
>>> on the distances between nodes.
>>>
>>> This current memory tier kernel interface needs to be improved for
>>> several important use cases,
>>>
>>> The current tier initialization code always initializes
>>> each memory-only NUMA node into a lower tier.  But a memory-only
>>> NUMA node may have a high performance memory device (e.g. a DRAM
>>> device attached via CXL.mem or a DRAM-backed memory-only node on
>>> a virtual machine) and should be put into a higher tier.
>>>
>>> The current tier hierarchy always puts CPU nodes into the top
>>> tier. But on a system with HBM or GPU devices, the
>>> memory-only NUMA nodes mapping these devices should be in the
>>> top tier, and DRAM nodes with CPUs are better to be placed into the
>>> next lower tier.
>>>
>>> With current kernel higher tier node can only be demoted to selected nodes on the
>>> next lower tier as defined by the demotion path, not any other
>>> node from any lower tier.  This strict, hard-coded demotion order
>>> does not work in all use cases (e.g. some use cases may want to
>>> allow cross-socket demotion to another node in the same demotion
>>> tier as a fallback when the preferred demotion node is out of
>>> space), This demotion order is also inconsistent with the page
>>> allocation fallback order when all the nodes in a higher tier are
>>> out of space: The page allocation can fall back to any node from
>>> any lower tier, whereas the demotion order doesn't allow that.
>>>
>>> The current kernel also don't provide any interfaces for the
>>> userspace to learn about the memory tier hierarchy in order to
>>> optimize its memory allocations.
>>>
>>> This patch series address the above by defining memory tiers explicitly.
>>>
>>> This patch introduce explicity memory tiers. The tier ID value
>>> of a memory tier is used to derive the demotion order between
>>> NUMA nodes.
>>>
>>> For example, if we have 3 memtiers: memtier100, memtier200, memiter300
>>> then the memory tier order is: memtier300 -> memtier200 -> memtier100
>>> where memtier300 is the highest tier and memtier100 is the lowest tier.
>>>
>>> While reclaim we migrate pages from fast(higher) tiers to slow(lower)
>>> tiers when the fast(higher) tier is under memory pressure.
>>>
>>> This patchset introduce 3 memory tiers (memtier100, memtier200 and memtier300)
>>> which are created by different kernel subsystems. The default memory
>>> tier created by the kernel is memtier200. A kernel parameter is provided
>>> to override the default memory tier.
>>>
>>> Link: https://lore.kernel.org/linux-mm/CAAPL-u9Wv+nH1VOZTj=9p9S70Y3Qz3+63EkqncRDdHfubsrjfw@mail.gmail.com
>>> Link: https://lore.kernel.org/linux-mm/7b72ccf4-f4ae-cb4e-f411-74d055482026@linux.ibm.com
>>>
>>> Signed-off-by: Jagdish Gediya <jvgediya@linux.ibm.com>
>>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>>> ---
>>>  include/linux/memory-tiers.h | 15 +++++++
>>>  mm/Makefile                  |  1 +
>>>  mm/memory-tiers.c            | 78 ++++++++++++++++++++++++++++++++++++
>>>  3 files changed, 94 insertions(+)
>>>  create mode 100644 include/linux/memory-tiers.h
>>>  create mode 100644 mm/memory-tiers.c
>>>
>>> diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
>>> new file mode 100644
>>> index 000000000000..a81dbc20e0d1
>>> --- /dev/null
>>> +++ b/include/linux/memory-tiers.h
>>> @@ -0,0 +1,15 @@
>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>> +#ifndef _LINUX_MEMORY_TIERS_H
>>> +#define _LINUX_MEMORY_TIERS_H
>>> +
>>> +#ifdef CONFIG_NUMA
>>> +
>>> +#define MEMORY_TIER_HBM_GPU	300
>>> +#define MEMORY_TIER_DRAM	200
>>> +#define MEMORY_TIER_PMEM	100
>>> +
>>> +#define DEFAULT_MEMORY_TIER	MEMORY_TIER_DRAM
>>> +#define MAX_MEMORY_TIER_ID	400
>>> +
>>> +#endif	/* CONFIG_NUMA */
>>> +#endif  /* _LINUX_MEMORY_TIERS_H */
>>> diff --git a/mm/Makefile b/mm/Makefile
>>> index 6f9ffa968a1a..d30acebc2164 100644
>>> --- a/mm/Makefile
>>> +++ b/mm/Makefile
>>> @@ -92,6 +92,7 @@ obj-$(CONFIG_KFENCE) += kfence/
>>>  obj-$(CONFIG_FAILSLAB) += failslab.o
>>>  obj-$(CONFIG_MEMTEST)		+= memtest.o
>>>  obj-$(CONFIG_MIGRATION) += migrate.o
>>> +obj-$(CONFIG_NUMA) += memory-tiers.o
>>>  obj-$(CONFIG_DEVICE_MIGRATION) += migrate_device.o
>>>  obj-$(CONFIG_TRANSPARENT_HUGEPAGE) += huge_memory.o khugepaged.o
>>>  obj-$(CONFIG_PAGE_COUNTER) += page_counter.o
>>> diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
>>> new file mode 100644
>>> index 000000000000..011877b6dbb9
>>> --- /dev/null
>>> +++ b/mm/memory-tiers.c
>>> @@ -0,0 +1,78 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +#include <linux/types.h>
>>> +#include <linux/nodemask.h>
>>> +#include <linux/slab.h>
>>> +#include <linux/lockdep.h>
>>> +#include <linux/moduleparam.h>
>>> +#include <linux/memory-tiers.h>
>>> +
>>> +struct memory_tier {
>>> +	struct list_head list;
>>> +	int id;
>>> +	nodemask_t nodelist;
>>> +};
>>> +
>>> +static DEFINE_MUTEX(memory_tier_lock);
>>> +static LIST_HEAD(memory_tiers);
>>> +
>>> +static void insert_memory_tier(struct memory_tier *memtier)
>>> +{
>>> +	struct list_head *ent;
>>> +	struct memory_tier *tmp_memtier;
>>> +
>>> +	lockdep_assert_held_once(&memory_tier_lock);
>>> +
>>> +	list_for_each(ent, &memory_tiers) {
>>> +		tmp_memtier = list_entry(ent, struct memory_tier, list);
>>> +		if (tmp_memtier->id < memtier->id) {
>>> +			list_add_tail(&memtier->list, ent);
>>> +			return;
>>> +		}
>>> +	}
>>> +	list_add_tail(&memtier->list, &memory_tiers);
>>> +}
>>> +
>>> +static struct memory_tier *register_memory_tier(unsigned int tier)
>>> +{
>>> +	struct memory_tier *memtier;
>>> +
>>> +	if (tier > MAX_MEMORY_TIER_ID)
>>> +		return ERR_PTR(-EINVAL);
>>> +
>>> +	memtier = kzalloc(sizeof(struct memory_tier), GFP_KERNEL);
>>> +	if (!memtier)
>>> +		return ERR_PTR(-ENOMEM);
>>> +
>>> +	memtier->id   = tier;
>>> +
>>> +	insert_memory_tier(memtier);
>>> +
>>> +	return memtier;
>>> +}
>>> +
>>> +static unsigned int default_memtier = DEFAULT_MEMORY_TIER;
>>> +core_param(default_memory_tier, default_memtier, uint, 0644);
>>> +
>>> +static int __init memory_tier_init(void)
>>> +{
>>> +	struct memory_tier *memtier;
>>> +
>>> +	/*
>>> +	 * Register only default memory tier to hide all empty
>>> +	 * memory tier from sysfs. Since this is early during
>>> +	 * boot, we could avoid holding memtory_tier_lock. But
>>> +	 * keep it simple by holding locks. So we can add lock
>>> +	 * held debug checks in other functions.
>>> +	 */
>>> +	mutex_lock(&memory_tier_lock);
>>> +	memtier = register_memory_tier(default_memtier);
>>> +	if (IS_ERR(memtier))
>>> +		panic("%s() failed to register memory tier: %ld\n",
>>> +		      __func__, PTR_ERR(memtier));
>>> +
>>> +	/* CPU only nodes are not part of memory tiers. */
>>> +	memtier->nodelist = node_states[N_MEMORY];
>>> +	mutex_unlock(&memory_tier_lock);
>>> +	return 0;
>>> +}
>>> +subsys_initcall(memory_tier_init);
>>
>> You dropped the original sysfs interface patches from the series, but
>> the kernel internal implementation is still for the original sysfs
>> interface.  For example, memory tier ID is for the original sysfs
>> interface, not for the new proposed sysfs interface.  So I suggest you
>> to implement with the new interface in mind.  What do you think about
>> the following design?
>>
> 
> Sorry I am not able to follow you here. This patchset completely drops
> exposing memory tiers to userspace via sysfs. Instead it allow
> creation of memory tiers with specific tierID from within the kernel/device driver.
> Default tierID is 200 and dax kmem creates memory tier with tierID 100. 
> 
> 
>> - Each NUMA node belongs to a memory type, and each memory type
>>   corresponds to a "abstract distance", so each NUMA node corresonds to
>>   a "distance".  For simplicity, we can start with static distances, for
>>   example, DRAM (default): 150, PMEM: 250.  The distance of each NUMA
>>   node can be recorded in a global array,
>>
>>     int node_distances[MAX_NUMNODES];
>>
>>   or, just
>>
>>     pgdat->distance
>>
> 
> I don't follow this. I guess you are trying to have a different design.
> Would it be much easier if you can write this in the form of a patch? 
> 
> 
>> - Each memory tier corresponds to a range of distance, for example,
>>   0-100, 100-200, 200-300, >300, we can start with static ranges too.
>>
>> - The core API of memory tier could be
>>
>>     struct memory_tier *find_create_memory_tier(int distance);
>>
>>   it will find the memory tier which covers "distance" in the memory
>>   tier list, or create a new memory tier if not found.
>>
> 
> I was expecting this to be internal to dax kmem. How dax kmem maps
> "abstract distance" to a memory tier. At this point this patchset is
> keeping all that for a future patchset. 
> 

At an abstract level, something like this.

modified   drivers/dax/kmem.c
@@ -150,7 +150,8 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 	}
 
 	dev_set_drvdata(dev, data);
-	node_create_and_set_memory_tier(numa_node, dax_kmem_memtier);
+	this_device_tier = find_memtier_from_distance(dev_dax);
+	node_create_and_set_memory_tier(numa_node, this_device_tier);
 	return 0;
 
 err_request_mem:



>> - kmem_dax driver will setup distance for PMEM NUMA nodes before online
>>   them.
>>
> 
> Sure we can do that as part of future patchset ?
> 
>> - When a NUMA node is onlined, we will use find_create_memory_tier() to
>>   find or create its memory tier and add the NUMA node into the memory
>>   tier.
>>
> 
> This is what this patchset does. When we online a numa node the kernel 
> find the memory tier for the node (__node_get_memory_tier). If it doesn't
> exist, we create one. (The new one created is not dynamic as you outlined
> earlier. But then that can be done in a future patchset). For now I am
> keeping this simpler.
> 
> static int node_set_memory_tier(int node, int tier)
> {
> 	struct memory_tier *memtier;
> 	int ret = 0;
> 
> 	mutex_lock(&memory_tier_lock);
> 	memtier = __node_get_memory_tier(node);
> 	/*
> 	 * if node is already part of the tier proceed with the
> 	 * current tier value, because we might want to establish
> 	 * new migration paths now. The node might be added to a tier
> 	 * before it was made part of N_MEMORY, hence estabilish_migration_targets
> 	 * will have skipped this node.
> 	 */
> 	if (!memtier)
> 		ret = __node_set_memory_tier(node, tier);
> 	establish_migration_targets();
> 
> 	mutex_unlock(&memory_tier_lock);
> 
> 	return ret;
> }
> 
> 
> 
> 
> 
>> - Or we can add memory type data structure now.
>>
>> Best Regards,
>> Huang, Ying
> 
> -aneesh

