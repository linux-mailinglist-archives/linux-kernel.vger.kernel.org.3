Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A630C5838DE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 08:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233468AbiG1GjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 02:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiG1GjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 02:39:17 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F2454AD3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 23:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658990355; x=1690526355;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=vy2zs8bw881etlbT+DKQV96mESapI1R9Qii2gk3En/4=;
  b=g3uTpgxDfctEcRAn5gsiPyE0SZZ02i5um7m28DuV7biean6uSZ0V4OKA
   AZCzOUiPne6DKgyNu063OchiUUyGMlozdh9JhrWZy+LLTZ9B7DVmRPxvc
   46srvrlHnsHHls4O2EnTj5Kw2LSdNZs5tGTNvLtPZIvwwLlkHk2n4UTJQ
   LwcmU17RyEMsQRQFZI2U7n4LMIQ81TO6pp7WmDjdtWv7cZE9kYUJF3ZZx
   4qI8iHElydJBvYlTSAGqk7iGEWf0KxAwZ5hDJBcp6KqNjQRr7pOBLG2iM
   roZIEhsHzpASmQOuhk62eLb7amevADeeCX8ZvRMuzlzU5GX8jH2sa4NtO
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10421"; a="268199672"
X-IronPort-AV: E=Sophos;i="5.93,196,1654585200"; 
   d="scan'208";a="268199672"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2022 23:39:15 -0700
X-IronPort-AV: E=Sophos;i="5.93,196,1654585200"; 
   d="scan'208";a="928140459"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.94])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2022 23:39:11 -0700
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
        Johannes Weiner <hannes@cmpxchg.org>, jvgediya.oss@gmail.com
Subject: Re: [PATCH v10 4/8] mm/demotion/dax/kmem: Set node's performance
 level to MEMTIER_PERF_LEVEL_PMEM
References: <20220720025920.1373558-1-aneesh.kumar@linux.ibm.com>
        <20220720025920.1373558-5-aneesh.kumar@linux.ibm.com>
        <874jz5zoi9.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <adbf4fc8-80a6-3160-3338-ea4e8739cb64@linux.ibm.com>
        <87mtcxy4ht.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <3f67b269-b69f-86a1-db1f-ba2408949b38@linux.ibm.com>
        <87o7xcwrio.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <87mtcvrxb0.fsf@linux.ibm.com>
Date:   Thu, 28 Jul 2022 14:39:07 +0800
In-Reply-To: <87mtcvrxb0.fsf@linux.ibm.com> (Aneesh Kumar K. V.'s message of
        "Wed, 27 Jul 2022 10:01:31 +0530")
Message-ID: <874jz1oi5w.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:

> "Huang, Ying" <ying.huang@intel.com> writes:
>
>> Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> writes:
>>
>>> On 7/25/22 2:05 PM, Huang, Ying wrote:
>>>> Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> writes:
>>>> 
>>>>> On 7/25/22 12:07 PM, Huang, Ying wrote:
>>>>>> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
>>>>>>
>>>>>>> By default, all nodes are assigned to the default memory tier which
>>>>>>> is the memory tier designated for nodes with DRAM
>>>>>>>
>>>>>>> Set dax kmem device node's tier to slower memory tier by assigning
>>>>>>> performance level to MEMTIER_PERF_LEVEL_PMEM. PMEM tier
>>>>>>> appears below the default memory tier in demotion order.
>>>>>>>
>>>>>>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>>>>>>> ---
>>>>>>>  arch/powerpc/platforms/pseries/papr_scm.c | 41 ++++++++++++++++++++---
>>>>>>>  drivers/acpi/nfit/core.c                  | 41 ++++++++++++++++++++++-
>>>>>>>  2 files changed, 76 insertions(+), 6 deletions(-)
>>>>>>>
>>>>>>> diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
>>>>>>> index 82cae08976bc..3b6164418d6f 100644
>>>>>>> --- a/arch/powerpc/platforms/pseries/papr_scm.c
>>>>>>> +++ b/arch/powerpc/platforms/pseries/papr_scm.c
>>>>>>> @@ -14,6 +14,8 @@
>>>>>>>  #include <linux/delay.h>
>>>>>>>  #include <linux/seq_buf.h>
>>>>>>>  #include <linux/nd.h>
>>>>>>> +#include <linux/memory.h>
>>>>>>> +#include <linux/memory-tiers.h>
>>>>>>>  
>>>>>>>  #include <asm/plpar_wrappers.h>
>>>>>>>  #include <asm/papr_pdsm.h>
>>>>>>> @@ -98,6 +100,7 @@ struct papr_scm_priv {
>>>>>>>  	bool hcall_flush_required;
>>>>>>>  
>>>>>>>  	uint64_t bound_addr;
>>>>>>> +	int target_node;
>>>>>>>  
>>>>>>>  	struct nvdimm_bus_descriptor bus_desc;
>>>>>>>  	struct nvdimm_bus *bus;
>>>>>>> @@ -1278,6 +1281,7 @@ static int papr_scm_nvdimm_init(struct papr_scm_priv *p)
>>>>>>>  	p->bus_desc.module = THIS_MODULE;
>>>>>>>  	p->bus_desc.of_node = p->pdev->dev.of_node;
>>>>>>>  	p->bus_desc.provider_name = kstrdup(p->pdev->name, GFP_KERNEL);
>>>>>>> +	p->target_node = dev_to_node(&p->pdev->dev);
>>>>>>>  
>>>>>>>  	/* Set the dimm command family mask to accept PDSMs */
>>>>>>>  	set_bit(NVDIMM_FAMILY_PAPR, &p->bus_desc.dimm_family_mask);
>>>>>>> @@ -1322,7 +1326,7 @@ static int papr_scm_nvdimm_init(struct papr_scm_priv *p)
>>>>>>>  	mapping.size = p->blocks * p->block_size; // XXX: potential overflow?
>>>>>>>  
>>>>>>>  	memset(&ndr_desc, 0, sizeof(ndr_desc));
>>>>>>> -	target_nid = dev_to_node(&p->pdev->dev);
>>>>>>> +	target_nid = p->target_node;
>>>>>>>  	online_nid = numa_map_to_online_node(target_nid);
>>>>>>>  	ndr_desc.numa_node = online_nid;
>>>>>>>  	ndr_desc.target_node = target_nid;
>>>>>>> @@ -1582,15 +1586,42 @@ static struct platform_driver papr_scm_driver = {
>>>>>>>  	},
>>>>>>>  };
>>>>>>>  
>>>>>>> +static int papr_scm_callback(struct notifier_block *self,
>>>>>>> +			     unsigned long action, void *arg)
>>>>>>> +{
>>>>>>> +	struct memory_notify *mnb = arg;
>>>>>>> +	int nid = mnb->status_change_nid;
>>>>>>> +	struct papr_scm_priv *p;
>>>>>>> +
>>>>>>> +	if (nid == NUMA_NO_NODE || action != MEM_ONLINE)
>>>>>>> +		return NOTIFY_OK;
>>>>>>> +
>>>>>>> +	mutex_lock(&papr_ndr_lock);
>>>>>>> +	list_for_each_entry(p, &papr_nd_regions, region_list) {
>>>>>>> +		if (p->target_node == nid) {
>>>>>>> +			node_devices[nid]->perf_level = MEMTIER_PERF_LEVEL_PMEM;
>>>>>>> +			break;
>>>>>>> +		}
>>>>>>> +	}
>>>>>>> +
>>>>>>> +	mutex_unlock(&papr_ndr_lock);
>>>>>>> +	return NOTIFY_OK;
>>>>>>> +}
>>>>>>> +
>>>>>>>  static int __init papr_scm_init(void)
>>>>>>>  {
>>>>>>>  	int ret;
>>>>>>>  
>>>>>>>  	ret = platform_driver_register(&papr_scm_driver);
>>>>>>> -	if (!ret)
>>>>>>> -		mce_register_notifier(&mce_ue_nb);
>>>>>>> -
>>>>>>> -	return ret;
>>>>>>> +	if (ret)
>>>>>>> +		return ret;
>>>>>>> +	mce_register_notifier(&mce_ue_nb);
>>>>>>> +	/*
>>>>>>> +	 * register a memory hotplug notifier at prio 2 so that we
>>>>>>> +	 * can update the perf level for the node.
>>>>>>> +	 */
>>>>>>> +	hotplug_memory_notifier(papr_scm_callback, MEMTIER_HOTPLUG_PRIO + 1);
>>>>>>> +	return 0;
>>>>>>>  }
>>>>>>>  module_init(papr_scm_init);
>>>>>>>  
>>>>>>> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
>>>>>>> index ae5f4acf2675..7ea1017ef790 100644
>>>>>>> --- a/drivers/acpi/nfit/core.c
>>>>>>> +++ b/drivers/acpi/nfit/core.c
>>>>>>> @@ -15,6 +15,8 @@
>>>>>>>  #include <linux/sort.h>
>>>>>>>  #include <linux/io.h>
>>>>>>>  #include <linux/nd.h>
>>>>>>> +#include <linux/memory.h>
>>>>>>> +#include <linux/memory-tiers.h>
>>>>>>>  #include <asm/cacheflush.h>
>>>>>>>  #include <acpi/nfit.h>
>>>>>>>  #include "intel.h"
>>>>>>> @@ -3470,6 +3472,39 @@ static struct acpi_driver acpi_nfit_driver = {
>>>>>>>  	},
>>>>>>>  };
>>>>>>>  
>>>>>>> +static int nfit_callback(struct notifier_block *self,
>>>>>>> +			 unsigned long action, void *arg)
>>>>>>> +{
>>>>>>> +	bool found = false;
>>>>>>> +	struct memory_notify *mnb = arg;
>>>>>>> +	int nid = mnb->status_change_nid;
>>>>>>> +	struct nfit_spa *nfit_spa;
>>>>>>> +	struct acpi_nfit_desc *acpi_desc;
>>>>>>> +
>>>>>>> +	if (nid == NUMA_NO_NODE || action != MEM_ONLINE)
>>>>>>> +		return NOTIFY_OK;
>>>>>>> +
>>>>>>> +	mutex_lock(&acpi_desc_lock);
>>>>>>> +	list_for_each_entry(acpi_desc, &acpi_descs, list) {
>>>>>>> +		mutex_lock(&acpi_desc->init_mutex);
>>>>>>> +		list_for_each_entry(nfit_spa, &acpi_desc->spas, list) {
>>>>>>> +			struct acpi_nfit_system_address *spa = nfit_spa->spa;
>>>>>>> +			int target_node = pxm_to_node(spa->proximity_domain);
>>>>>>> +
>>>>>>> +			if (target_node == nid) {
>>>>>>> +				node_devices[nid]->perf_level = MEMTIER_PERF_LEVEL_PMEM;
>>>>>>> +				found = true;
>>>>>>> +				break;
>>>>>>> +			}
>>>>>>> +		}
>>>>>>> +		mutex_unlock(&acpi_desc->init_mutex);
>>>>>>> +		if (found)
>>>>>>> +			break;
>>>>>>> +	}
>>>>>>> +	mutex_unlock(&acpi_desc_lock);
>>>>>>> +	return NOTIFY_OK;
>>>>>>> +}
>>>>>>> +
>>>>>>>  static __init int nfit_init(void)
>>>>>>>  {
>>>>>>>  	int ret;
>>>>>>> @@ -3509,7 +3544,11 @@ static __init int nfit_init(void)
>>>>>>>  		nfit_mce_unregister();
>>>>>>>  		destroy_workqueue(nfit_wq);
>>>>>>>  	}
>>>>>>> -
>>>>>>> +	/*
>>>>>>> +	 * register a memory hotplug notifier at prio 2 so that we
>>>>>>> +	 * can update the perf level for the node.
>>>>>>> +	 */
>>>>>>> +	hotplug_memory_notifier(nfit_callback, MEMTIER_HOTPLUG_PRIO + 1);
>>>>>>>  	return ret;
>>>>>>>  
>>>>>>>  }
>>>>>>
>>>>>> I don't think that it's a good idea to set perf_level of a memory device
>>>>>> (node) via NFIT only.
>>>>>
>>>>>>
>>>>>> For example, we may prefer HMAT over NFIT when it's available.  So the
>>>>>> perf_level should be set in dax/kmem.c based on information provided by
>>>>>> ACPI or other information sources.  ACPI can provide some functions/data
>>>>>> structures to let drivers (like dax/kmem.c) to query the properties of
>>>>>> the memory device (node).
>>>>>>
>>>>>
>>>>> I was trying to make it architecture specific so that we have a placeholder
>>>>> to fine-tune this better. For example, ppc64 will look at device tree
>>>>> details to find the performance level and x86 will look at ACPI data structure.
>>>>> Adding that hotplug callback in dax/kmem will prevent that architecture-specific
>>>>> customization? 
>>>>>
>>>>> I would expect that callback to move to the generic ACPI layer so that even
>>>>> firmware managed CXL devices can be added to a lower tier?  I don't understand
>>>>> ACPI enough to find the right abstraction for that hotplug callback. 
>>>> 
>>>> I'm OK for this to be architecture specific.
>>>> 
>>>> But ACPI NFIT isn't enough for x86.  For example, PMEM can be added to a
>>>> virtual machine as normal memory nodes without NFIT.  Instead, PMEM is
>>>> marked via "memmap=<nn>G!<ss>G" or "efi_fake_mem=<nn>G@<ss>G:0x40000",
>>>> and dax/kmem.c is used to hot-add the memory.
>>>> 
>>>> So, before a more sophisticated version is implemented for x86.  The
>>>> simplest version as I suggested below works even better.
>>>> 
>>>>>> As the simplest first version, this can be just hard coded.
>>>>>>
>>>>>
>>>>> If you are suggesting to not use hotplug callback, one of the challenge was node_devices[nid]
>>>>> get allocated pretty late when we try to online the node. 
>>>> 
>>>> As the simplest first version, this can be as simple as,
>>>> 
>>>> /* dax/kmem.c */
>>>> static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
>>>> {
>>>> 	node_devices[dev_dax->target_node]->perf_level = MEMTIER_PERF_LEVEL_PMEM;
>>>> 	/* add_memory_driver_managed() */
>>>> }
>>>> 
>>>> To be compatible with ppc64 version, how about make dev_dax_kmem_probe()
>>>> set perf_level only if it's uninitialized?
>>>
>>> That will result in kernel crash because node_devices[dev_dax->target_node] is not initialized there. 
>>>
>>> it get allocated in add_memory_resource -> __try_online_node ->
>>> register_one_node -> __register_one_node -> node_devices[nid] =
>>> kzalloc(sizeof(struct node), GFP_KERNEL);
>>
>> Ah, right!  So we need some other way to do that, for example, a global
>> array as follows,
>>
>>   int node_perf_levels[MAX_NUMNODES];
>
> This would be much simpler than adding memory_type, but then it is a
> memory device property and hence it will be a good idea to group
> it together with other properties in node_devices[]. We could look at
> allocating nodes_devices[] for dax/kmem nodes from within the driver?

We have other choices too.  For example, we have per-node memory tier
related data structure node_demotion[].  And we have NODE_DATA().  But I
think we can try memory_type firstly.

> I did implement memory_type and it do bring some additional complexity
> though it simplfy the interface. 

Thanks!  Let's look at it.  It's something we need to try sooner or later.

> I was looking at the platform drivers calling
> struct memory_dev_type *register_memory_type(int perf_level, int node)
> to register a new memory_type. if dax/kmem don't find a memory_dev_type
> registered for the NUMA node it will assign default pmem type.
>
> 	if (!node_memory_types[numa_node]) {
> 		/*
> 		 * low level drivers didn't initialize the memory type.
> 		 * assign a default level.
> 		 */
> 		node_memory_types[numa_node] = &default_pmem_type;
> 		node_set(numa_node, default_pmem_type.nodes);
> 	}
>
> This should allow ACPI or papr_scm to fine tune the memory type of
> the deivce they are initializing

I guess that you are trying to coordinate multiple drivers that may
manage the same memory devices?  For example, ACPI NFIT, ACPI HMAT,
dax/kmem may "manage" a PMEM device.  So it's possible for any driver to
set its memory_type and even change it?

To simplify the situation, I suggest that only the driver which will
online the memory node will set the memory_type for the node.  In this
way, we will never change the memory_type of a memory node.  And we will
not change the memory_tier of a memory node during boot.  The driver
which onlines the memory node (e.g., dax/kmem.c) may query ACPI
NFIT/ACPI HMAT or papr_scm to get more information.

We can use a special driver to manage memory nodes onlined during boot.

Because memory_type is per driver, the memory devices that have same
performance, but managed by different drivers can be put in different
memory_type.  So we don't need default_pmem_type.  This is different
from memory_tier, where the memory devices with same performance needs
to be put in one memory_tier.

>>
>> And, I think that we need to consider the memory type here too.  As
>> suggested by Johannes, memory type describes a set of memory devices
>> (NUMA nodes) with same performance character (that is, abstract distance
>> or perf level).  The data structure can be something as follows,
>>
>>   struct memory_type {
>>         int perf_level;
>>         struct list_head tier_sibling;
>>         nodemask_t nodes;
>>   };
>
> memory type is already used in include/linux/memremap.h
>
> enum memory_type 
>
> How about struct memory_dev_type? 

Sound good to me.

> How about we also add memtier here that is only accessed with
> memory_tier_lock held? That will allow easy access to the memory
> tier this type belongs

Who will use it?  If we have no users now, we can add it when there are.

>>
>> The memory_type should be created and managed by the device drivers
>> (e.g., dax/kmem) which manages the memory devices.  In the future, we
>> will represent it in sysfs, and a per-memory_type knob will be provided
>> to offset the perf_level of all memory devices managed by the
>> memory_type.
>>
>> With memory_type, the memory_tier becomes,
>>
>>   struct memory_tier {
>>         int perf_level_start;
>>         struct list_head sibling;
>>         struct list_head memory_types;
>>   };
>>
>> And we need an array to map from nid to memory_type, e.g., as follows,
>>
>>   struct memory_type *node_memory_types[MAX_NUMNODES];
>
> Changing the perf level of a memory devices will move it from one
> memory type to the other and such a move should will also results
> in updating node's memory tier. ie, it will be something like below

I think that we should only change the perf level of a memory_type (so
that all of its memory devices), but never change the perf level of an
individual memory device.  Per my understanding, this was suggested by
Johannes too.

And we don't need to change perf level now too.  It needs to be done via
a user space knob per memory type.

> static void update_node_perf_level(int node, struct memory_dev_type *memtype)
> {
> 	pg_data_t *pgdat;
> 	struct memory_dev_type *current_memtype;
> 	struct memory_tier *memtier;
>
> 	pgdat = NODE_DATA(node);
> 	if (!pgdat)
> 		return;
>
> 	mutex_lock(&memory_tier_lock);
> 	/*
> 	 * Make sure we mark the memtier NULL before we assign the new memory tier
> 	 * to the NUMA node. This make sure that anybody looking at NODE_DATA
> 	 * finds a NULL memtier or the one which is still valid.
> 	 */
> 	rcu_assign_pointer(pgdat->memtier, NULL);
> 	synchronize_rcu();
>
> 	if (!memtype->memtier) {
> 		memtier = find_create_memory_tier(memtype);
> 		if (IS_ERR(memtier))
> 			goto err_out;
> 	}
> 	current_memtype = node_memory_types[node];
> 	node_clear(node, current_memtype->nodes);
> 	/*
> 	 * If current memtype becomes empty, we should kill the memory tiers
> 	 */
> 	node_set(node, memtype->nodes);
>         node_memory_types[node] = memtype;
> 	rcu_assign_pointer(pgdat->memtier, memtype->memtier);
> 	establish_migration_targets();
> err_out:
> 	mutex_unlock(&memory_tier_lock);
> }
>
>
>>
>> We need to manage the memory_type in device drivers, instead of ACPI or
>> device tree callbacks.
>>
>> Because memory_type is an important part of the explicit memory tier
>> implementation and may influence the design, I suggest to include it in
>> the implementation now.  It appears not too complex anyway.
>>
>
> One thing I observed while implementing this is the additional
> complexity while walking the memory tiers. Any tier related operation
> impacting memory numa nodes now becomes a two linked list walk as below.
>
> ex:
> list_for_each_entry(memtier, &memory_tiers, list) {
> 	list_for_each_entry(memtype, &memtier->memory_types, tier_sibiling)
> 		nodes_or(nodes, nodes, memtype->nodes);
>
> As we offline N_MEMORY nodes, we now have to do
>
> 	memtype = node_memory_types[node];
>         if (nodes_empty(memtype->nodes)) {
>         	list_del(&memtype->tier_sibiling);
>                         if (list_empty(&current_memtier->memory_types))
>                         	destroy_memory_tier(current_memtier);
>

Yes.  This may increase code complexity.  Let's check the resulting code.

Best Regards,
Huang, Ying
