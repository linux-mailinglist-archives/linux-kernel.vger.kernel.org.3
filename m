Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D14E5577C03
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 08:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233466AbiGRG5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 02:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233490AbiGRG5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 02:57:19 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1539D1659E
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 23:57:18 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26I6hjJ3008260;
        Mon, 18 Jul 2022 06:56:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=Vhvb5smH6OhEXuIrrEGONcEK7Unm65zgDzqfQWVZTz0=;
 b=hGUub6rmVIM0EDKMIjL9OPq9RKR+8UQx9geK6RgGIWFuTzinJYpjwe7HsE+yCVj9HmV8
 as5cqg3Iu8oyE+a+ZuoT0m+/F1Jh2IQlBkFiIGQektxU4ifzpvHowUUcwOvb1Eaf5y9M
 N0DMls387/16GUcVRXVd0sYDkHZjFmqxhkk3fjJ8eBApk2aSOpE48Wd0T5qXNC7Q75A+
 HP5FWdCWzDiTgbq1WVRZKxHU+0qOnYctj8iCD7Q1iXruzhKBi5Iws+eSpeAd594Oose7
 KARPUxnw/Wlkcj6TGXbjUb13F+Z2ELh4n1ukItpnrJn9KP87v5pYLz+Rm6dIAVcfnXo2 FA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hd2gng9fa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Jul 2022 06:56:53 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 26I6ja3l018436;
        Mon, 18 Jul 2022 06:56:52 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hd2gng9ej-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Jul 2022 06:56:51 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26I6ot5g016544;
        Mon, 18 Jul 2022 06:56:49 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06ams.nl.ibm.com with ESMTP id 3hbmkj262s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Jul 2022 06:56:48 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26I6t5ir18481538
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Jul 2022 06:55:05 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8095AA405B;
        Mon, 18 Jul 2022 06:56:46 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3E6BDA4054;
        Mon, 18 Jul 2022 06:56:42 +0000 (GMT)
Received: from [9.43.44.250] (unknown [9.43.44.250])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 18 Jul 2022 06:56:42 +0000 (GMT)
Message-ID: <a95688f3-3a5d-5238-d38b-e8eb5a6c63a7@linux.ibm.com>
Date:   Mon, 18 Jul 2022 12:26:41 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v9 1/8] mm/demotion: Add support for explicit memory tiers
Content-Language: en-US
To:     Alistair Popple <apopple@nvidia.com>,
        "Huang, Ying" <ying.huang@intel.com>
Cc:     Wei Xu <weixugc@google.com>, Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <shy828301@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim C Chen <tim.c.chen@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>, jvgediya.oss@gmail.com,
        Jagdish Gediya <jvgediya@linux.ibm.com>
References: <20220714045351.434957-1-aneesh.kumar@linux.ibm.com>
 <20220714045351.434957-2-aneesh.kumar@linux.ibm.com>
 <87bktq4xs7.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <CAAPL-u_F=RBnCy3_WfbDyM0x7_CWPAK+fvwwLZvyRGUgVoS_VQ@mail.gmail.com>
 <8735ez3s7i.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <87y1wrc5f4.fsf@nvdebian.thelocal>
From:   Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
In-Reply-To: <87y1wrc5f4.fsf@nvdebian.thelocal>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2DB46FZ2kKKXDrq3YW414PW2GBsIgxKS
X-Proofpoint-ORIG-GUID: P6nx1rRS97036_VrPm3q5TgMXcVALeBS
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-18_04,2022-07-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 mlxscore=0 suspectscore=0 phishscore=0
 mlxlogscore=999 priorityscore=1501 clxscore=1015 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207180026
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/18/22 11:28 AM, Alistair Popple wrote:
> 
> "Huang, Ying" <ying.huang@intel.com> writes:
> 
>> Wei Xu <weixugc@google.com> writes:
>>
>>> On Fri, Jul 15, 2022 at 12:53 AM Huang, Ying <ying.huang@intel.com> wrote:
>>>>
>>>> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
>>>>
>>>>> In the current kernel, memory tiers are defined implicitly via a
>>>>> demotion path relationship between NUMA nodes, which is created
>>>>> during the kernel initialization and updated when a NUMA node is
>>>>> hot-added or hot-removed.  The current implementation puts all
>>>>> nodes with CPU into the top tier, and builds the tier hierarchy
>>>>> tier-by-tier by establishing the per-node demotion targets based
>>>>> on the distances between nodes.
>>>>>
>>>>> This current memory tier kernel interface needs to be improved for
>>>>> several important use cases,
>>>>>
>>>>> The current tier initialization code always initializes
>>>>> each memory-only NUMA node into a lower tier.  But a memory-only
>>>>> NUMA node may have a high performance memory device (e.g. a DRAM
>>>>> device attached via CXL.mem or a DRAM-backed memory-only node on
>>>>> a virtual machine) and should be put into a higher tier.
>>>>>
>>>>> The current tier hierarchy always puts CPU nodes into the top
>>>>> tier. But on a system with HBM or GPU devices, the
>>>>> memory-only NUMA nodes mapping these devices should be in the
>>>>> top tier, and DRAM nodes with CPUs are better to be placed into the
>>>>> next lower tier.
>>>>>
>>>>> With current kernel higher tier node can only be demoted to selected nodes on the
>>>>> next lower tier as defined by the demotion path, not any other
>>>>> node from any lower tier.  This strict, hard-coded demotion order
>>>>> does not work in all use cases (e.g. some use cases may want to
>>>>> allow cross-socket demotion to another node in the same demotion
>>>>> tier as a fallback when the preferred demotion node is out of
>>>>> space), This demotion order is also inconsistent with the page
>>>>> allocation fallback order when all the nodes in a higher tier are
>>>>> out of space: The page allocation can fall back to any node from
>>>>> any lower tier, whereas the demotion order doesn't allow that.
>>>>>
>>>>> The current kernel also don't provide any interfaces for the
>>>>> userspace to learn about the memory tier hierarchy in order to
>>>>> optimize its memory allocations.
>>>>>
>>>>> This patch series address the above by defining memory tiers explicitly.
>>>>>
>>>>> This patch introduce explicity memory tiers. The tier ID value
>>>>> of a memory tier is used to derive the demotion order between
>>>>> NUMA nodes.
>>>>>
>>>>> For example, if we have 3 memtiers: memtier100, memtier200, memiter300
>>>>> then the memory tier order is: memtier300 -> memtier200 -> memtier100
>>>>> where memtier300 is the highest tier and memtier100 is the lowest tier.
>>>>>
>>>>> While reclaim we migrate pages from fast(higher) tiers to slow(lower)
>>>>> tiers when the fast(higher) tier is under memory pressure.
>>>>>
>>>>> This patchset introduce 3 memory tiers (memtier100, memtier200 and memtier300)
>>>>> which are created by different kernel subsystems. The default memory
>>>>> tier created by the kernel is memtier200. A kernel parameter is provided
>>>>> to override the default memory tier.
>>>>>
>>>>> Link: https://lore.kernel.org/linux-mm/CAAPL-u9Wv+nH1VOZTj=9p9S70Y3Qz3+63EkqncRDdHfubsrjfw@mail.gmail.com
>>>>> Link: https://lore.kernel.org/linux-mm/7b72ccf4-f4ae-cb4e-f411-74d055482026@linux.ibm.com
>>>>>
>>>>> Signed-off-by: Jagdish Gediya <jvgediya@linux.ibm.com>
>>>>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>>>>> ---
>>>>>  include/linux/memory-tiers.h | 15 +++++++
>>>>>  mm/Makefile                  |  1 +
>>>>>  mm/memory-tiers.c            | 78 ++++++++++++++++++++++++++++++++++++
>>>>>  3 files changed, 94 insertions(+)
>>>>>  create mode 100644 include/linux/memory-tiers.h
>>>>>  create mode 100644 mm/memory-tiers.c
>>>>>
>>>>> diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
>>>>> new file mode 100644
>>>>> index 000000000000..a81dbc20e0d1
>>>>> --- /dev/null
>>>>> +++ b/include/linux/memory-tiers.h
>>>>> @@ -0,0 +1,15 @@
>>>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>>>> +#ifndef _LINUX_MEMORY_TIERS_H
>>>>> +#define _LINUX_MEMORY_TIERS_H
>>>>> +
>>>>> +#ifdef CONFIG_NUMA
>>>>> +
>>>>> +#define MEMORY_TIER_HBM_GPU  300
>>>>> +#define MEMORY_TIER_DRAM     200
>>>>> +#define MEMORY_TIER_PMEM     100
>>>>> +
>>>>> +#define DEFAULT_MEMORY_TIER  MEMORY_TIER_DRAM
>>>>> +#define MAX_MEMORY_TIER_ID   400
>>>>> +
>>>>> +#endif       /* CONFIG_NUMA */
>>>>> +#endif  /* _LINUX_MEMORY_TIERS_H */
>>>>> diff --git a/mm/Makefile b/mm/Makefile
>>>>> index 6f9ffa968a1a..d30acebc2164 100644
>>>>> --- a/mm/Makefile
>>>>> +++ b/mm/Makefile
>>>>> @@ -92,6 +92,7 @@ obj-$(CONFIG_KFENCE) += kfence/
>>>>>  obj-$(CONFIG_FAILSLAB) += failslab.o
>>>>>  obj-$(CONFIG_MEMTEST)                += memtest.o
>>>>>  obj-$(CONFIG_MIGRATION) += migrate.o
>>>>> +obj-$(CONFIG_NUMA) += memory-tiers.o
>>>>>  obj-$(CONFIG_DEVICE_MIGRATION) += migrate_device.o
>>>>>  obj-$(CONFIG_TRANSPARENT_HUGEPAGE) += huge_memory.o khugepaged.o
>>>>>  obj-$(CONFIG_PAGE_COUNTER) += page_counter.o
>>>>> diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
>>>>> new file mode 100644
>>>>> index 000000000000..011877b6dbb9
>>>>> --- /dev/null
>>>>> +++ b/mm/memory-tiers.c
>>>>> @@ -0,0 +1,78 @@
>>>>> +// SPDX-License-Identifier: GPL-2.0
>>>>> +#include <linux/types.h>
>>>>> +#include <linux/nodemask.h>
>>>>> +#include <linux/slab.h>
>>>>> +#include <linux/lockdep.h>
>>>>> +#include <linux/moduleparam.h>
>>>>> +#include <linux/memory-tiers.h>
>>>>> +
>>>>> +struct memory_tier {
>>>>> +     struct list_head list;
>>>>> +     int id;
>>>>> +     nodemask_t nodelist;
>>>>> +};
>>>>> +
>>>>> +static DEFINE_MUTEX(memory_tier_lock);
>>>>> +static LIST_HEAD(memory_tiers);
>>>>> +
>>>>> +static void insert_memory_tier(struct memory_tier *memtier)
>>>>> +{
>>>>> +     struct list_head *ent;
>>>>> +     struct memory_tier *tmp_memtier;
>>>>> +
>>>>> +     lockdep_assert_held_once(&memory_tier_lock);
>>>>> +
>>>>> +     list_for_each(ent, &memory_tiers) {
>>>>> +             tmp_memtier = list_entry(ent, struct memory_tier, list);
>>>>> +             if (tmp_memtier->id < memtier->id) {
>>>>> +                     list_add_tail(&memtier->list, ent);
>>>>> +                     return;
>>>>> +             }
>>>>> +     }
>>>>> +     list_add_tail(&memtier->list, &memory_tiers);
>>>>> +}
>>>>> +
>>>>> +static struct memory_tier *register_memory_tier(unsigned int tier)
>>>>> +{
>>>>> +     struct memory_tier *memtier;
>>>>> +
>>>>> +     if (tier > MAX_MEMORY_TIER_ID)
>>>>> +             return ERR_PTR(-EINVAL);
>>>>> +
>>>>> +     memtier = kzalloc(sizeof(struct memory_tier), GFP_KERNEL);
>>>>> +     if (!memtier)
>>>>> +             return ERR_PTR(-ENOMEM);
>>>>> +
>>>>> +     memtier->id   = tier;
>>>>> +
>>>>> +     insert_memory_tier(memtier);
>>>>> +
>>>>> +     return memtier;
>>>>> +}
>>>>> +
>>>>> +static unsigned int default_memtier = DEFAULT_MEMORY_TIER;
>>>>> +core_param(default_memory_tier, default_memtier, uint, 0644);
>>>>> +
>>>>> +static int __init memory_tier_init(void)
>>>>> +{
>>>>> +     struct memory_tier *memtier;
>>>>> +
>>>>> +     /*
>>>>> +      * Register only default memory tier to hide all empty
>>>>> +      * memory tier from sysfs. Since this is early during
>>>>> +      * boot, we could avoid holding memtory_tier_lock. But
>>>>> +      * keep it simple by holding locks. So we can add lock
>>>>> +      * held debug checks in other functions.
>>>>> +      */
>>>>> +     mutex_lock(&memory_tier_lock);
>>>>> +     memtier = register_memory_tier(default_memtier);
>>>>> +     if (IS_ERR(memtier))
>>>>> +             panic("%s() failed to register memory tier: %ld\n",
>>>>> +                   __func__, PTR_ERR(memtier));
>>>>> +
>>>>> +     /* CPU only nodes are not part of memory tiers. */
>>>>> +     memtier->nodelist = node_states[N_MEMORY];
>>>>> +     mutex_unlock(&memory_tier_lock);
>>>>> +     return 0;
>>>>> +}
>>>>> +subsys_initcall(memory_tier_init);
>>>>
>>>> You dropped the original sysfs interface patches from the series, but
>>>> the kernel internal implementation is still for the original sysfs
>>>> interface.  For example, memory tier ID is for the original sysfs
>>>> interface, not for the new proposed sysfs interface.  So I suggest you
>>>> to implement with the new interface in mind.  What do you think about
>>>> the following design?
>>>>
>>>> - Each NUMA node belongs to a memory type, and each memory type
>>>>   corresponds to a "abstract distance", so each NUMA node corresonds to
>>>>   a "distance".  For simplicity, we can start with static distances, for
>>>>   example, DRAM (default): 150, PMEM: 250.
>>>
>>> I agree with this design, though I'd prefer the new attribute to not
>>> be named as "distance".  This is to both avoid the confusion with the
>>> SLIT distance and to avoid the misconception that only the latency
>>> matters, but the bandwidth doesn't.
>>>
>>> How about we call it "performance level" (perf_level) or something
>>> similar instead?
>>
>> I have no strong opinion on this.  Both "distance" or "perf_level" looks
>> OK to me.
>>
>>>> The distance of each NUMA
>>>>   node can be recorded in a global array,
>>>>
>>>>     int node_distances[MAX_NUMNODES];
>>>>
>>>>   or, just
>>>>
>>>>     pgdat->distance
>>>
>>> I think node_devices[] is a better place to record this new attribute.
>>> The HMAT performance data is also listed there.
>>
>> Firstly, we all agree that we need a place to record this information,
>> per node or per memory type.  Personally, I prefer to separate the data
>> and its interface (such as sysfs).
>>
>>>> - Each memory tier corresponds to a range of distance, for example,
>>>>   0-100, 100-200, 200-300, >300, we can start with static ranges too.
>>>>
>>>> - The core API of memory tier could be
>>>>
>>>>     struct memory_tier *find_create_memory_tier(int distance);
>>>>
>>>>   it will find the memory tier which covers "distance" in the memory
>>>>   tier list, or create a new memory tier if not found.
>>>>
>>>> - kmem_dax driver will setup distance for PMEM NUMA nodes before online
>>>>   them.
>>>
>>> This attribute should be a property of the NUMA node based on the
>>> device hardware.
>>
>> Yes.  Or a property of a memory type.
>>
>>> For PMEM, it is better to handle at the ACPI level.
>>> For example, we can consider initializing this attribute for a PMEM
>>> node in acpi_numa_memory_affinity_init() when the node is
>>> non-volatile.
>>
>> The abstract_distance/perf_level may be determined from multiple
>> information sources, e.g., ACPI SLIT/SRAT/HMAT, etc.  It should be the
>> responsibility of device drivers (e.g., kmem_dax) to determine the final
>> value of abstract_distance/perf_level based on the information
>> availability/priority and some specific knowledge of the hardware.  Yes,
>> ACPI SRAT is valuable to determine the abstract_distance/perf_level.
>> And, it's better for kmem_dax to use it to determine the final value of
>> abstract_distance/perf_level.
>>
>> To make the first version as simple as possible, I think we can just use
>> some static abstract_distance/perf_level in kmem_dax driver for the NUMA
>> nodes onlined by it.  Because we use the driver for PMEM only now.  We
>> can enhance the implementation later.
> 
> I agree. Ideally I think all this should be derived from ACPI tables,
> etc. However I think it will take a while for both FW and SW to make
> that information available and correct. Letting drivers initialise that
> for now at least should aid development in determining how performance
> levels should be set from multiple information sources, especially if
> there is no way of overriding it from userspace.
>

When we parse the firmware tables, node_devices is mostly not allocated.
That get allocated in register_one_node. We can do a hotplug
callback like below. This should also allow us to update perf_level based
ACPI tables.

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index ae5f4acf2675..89b010e0461e 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -15,6 +15,7 @@
 #include <linux/sort.h>
 #include <linux/io.h>
 #include <linux/nd.h>
+#include <linux/memory.h>
 #include <asm/cacheflush.h>
 #include <acpi/nfit.h>
 #include "intel.h"
@@ -3470,6 +3471,45 @@ static struct acpi_driver acpi_nfit_driver = {
 	},
 };
 
+static int nfit_callback(struct notifier_block *self,
+			 unsigned long action, void *arg)
+{
+	bool found = false;
+	struct memory_notify *mnb = arg;
+	int nid = mnb->status_change_nid;
+	struct nfit_spa *nfit_spa;
+	struct acpi_nfit_desc *acpi_desc;
+
+	if (nid == NUMA_NO_NODE || action != MEM_ONLINE)
+		return NOTIFY_OK;
+
+	mutex_lock(&acpi_desc_lock);
+	list_for_each_entry(acpi_desc, &acpi_descs, list) {
+		mutex_lock(&acpi_desc->init_mutex);
+		list_for_each_entry(nfit_spa, &acpi_desc->spas, list) {
+			struct acpi_nfit_system_address *spa = nfit_spa->spa;
+			int target_node = pxm_to_node(spa->proximity_domain);
+
+			if (target_node == nid) {
+				node_devices[nid]->perf_level = 1;
+				found = true;
+				break;
+			}
+		}
+		mutex_unlock(&acpi_desc->init_mutex);
+		if (found)
+			break;
+	}
+	mutex_unlock(&acpi_desc_lock);
+	return NOTIFY_OK;
+}
+
+static struct notifier_block nfit_callback_nb = {
+	.notifier_call = nfit_callback,
+	.priority = 2,
+};
+
+
 static __init int nfit_init(void)
 {
 	int ret;
@@ -3509,7 +3549,11 @@ static __init int nfit_init(void)
 		nfit_mce_unregister();
 		destroy_workqueue(nfit_wq);
 	}
-
+	/*
+	 * register a memory hotplug notifier at prio 2 so that we
+	 * can update the perf level for the node.
+	 */
+	register_hotmemory_notifier(&nfit_callback_nb);
 	return ret;
 
 }



 
