Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8153A57FB72
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 10:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234021AbiGYIfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 04:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiGYIf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 04:35:28 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A82813F11
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 01:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658738127; x=1690274127;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=UDMDJz3MwFoJPekzCYzBqOFV43jJdG0572fd8ItnWRA=;
  b=OyMzlEa0xA68Mnbn09QHadykEdrP55+ExkgD6pO07q3Wan8/6RVXkFnN
   c+1bUow5G2RAvCsnOcjjPiRz/2jsKotuYnqlD9JgIlvTrRa6DV3K0hAvt
   Tk0lUfcTbXBVNIp4msNYHkjioPxd2DNkCMwCEWCm+C46zc+vbkdXH8K/6
   uU8zndkOY1iZ9hGDG6NRmK0ou4zBX47xu2lIzwXCQoubp0LH/Xxk3qVVe
   It8ZL4LWJKSjd5thRLQcJ0ur3bItd5abnlAgV/Kbaj15m2yhIbVhq5eMz
   islFDHOmlEkY48hM814VJbwuIotB3gzLVTjuTVcGTAu6AhQLrPz8N8rN5
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10418"; a="288404740"
X-IronPort-AV: E=Sophos;i="5.93,192,1654585200"; 
   d="scan'208";a="288404740"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2022 01:35:27 -0700
X-IronPort-AV: E=Sophos;i="5.93,192,1654585200"; 
   d="scan'208";a="574963532"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.94])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2022 01:35:23 -0700
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
Subject: Re: [PATCH v10 4/8] mm/demotion/dax/kmem: Set node's performance
 level to MEMTIER_PERF_LEVEL_PMEM
References: <20220720025920.1373558-1-aneesh.kumar@linux.ibm.com>
        <20220720025920.1373558-5-aneesh.kumar@linux.ibm.com>
        <874jz5zoi9.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <adbf4fc8-80a6-3160-3338-ea4e8739cb64@linux.ibm.com>
Date:   Mon, 25 Jul 2022 16:35:10 +0800
In-Reply-To: <adbf4fc8-80a6-3160-3338-ea4e8739cb64@linux.ibm.com> (Aneesh
        Kumar K. V.'s message of "Mon, 25 Jul 2022 12:18:39 +0530")
Message-ID: <87mtcxy4ht.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> writes:

> On 7/25/22 12:07 PM, Huang, Ying wrote:
>> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
>> 
>>> By default, all nodes are assigned to the default memory tier which
>>> is the memory tier designated for nodes with DRAM
>>>
>>> Set dax kmem device node's tier to slower memory tier by assigning
>>> performance level to MEMTIER_PERF_LEVEL_PMEM. PMEM tier
>>> appears below the default memory tier in demotion order.
>>>
>>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>>> ---
>>>  arch/powerpc/platforms/pseries/papr_scm.c | 41 ++++++++++++++++++++---
>>>  drivers/acpi/nfit/core.c                  | 41 ++++++++++++++++++++++-
>>>  2 files changed, 76 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
>>> index 82cae08976bc..3b6164418d6f 100644
>>> --- a/arch/powerpc/platforms/pseries/papr_scm.c
>>> +++ b/arch/powerpc/platforms/pseries/papr_scm.c
>>> @@ -14,6 +14,8 @@
>>>  #include <linux/delay.h>
>>>  #include <linux/seq_buf.h>
>>>  #include <linux/nd.h>
>>> +#include <linux/memory.h>
>>> +#include <linux/memory-tiers.h>
>>>  
>>>  #include <asm/plpar_wrappers.h>
>>>  #include <asm/papr_pdsm.h>
>>> @@ -98,6 +100,7 @@ struct papr_scm_priv {
>>>  	bool hcall_flush_required;
>>>  
>>>  	uint64_t bound_addr;
>>> +	int target_node;
>>>  
>>>  	struct nvdimm_bus_descriptor bus_desc;
>>>  	struct nvdimm_bus *bus;
>>> @@ -1278,6 +1281,7 @@ static int papr_scm_nvdimm_init(struct papr_scm_priv *p)
>>>  	p->bus_desc.module = THIS_MODULE;
>>>  	p->bus_desc.of_node = p->pdev->dev.of_node;
>>>  	p->bus_desc.provider_name = kstrdup(p->pdev->name, GFP_KERNEL);
>>> +	p->target_node = dev_to_node(&p->pdev->dev);
>>>  
>>>  	/* Set the dimm command family mask to accept PDSMs */
>>>  	set_bit(NVDIMM_FAMILY_PAPR, &p->bus_desc.dimm_family_mask);
>>> @@ -1322,7 +1326,7 @@ static int papr_scm_nvdimm_init(struct papr_scm_priv *p)
>>>  	mapping.size = p->blocks * p->block_size; // XXX: potential overflow?
>>>  
>>>  	memset(&ndr_desc, 0, sizeof(ndr_desc));
>>> -	target_nid = dev_to_node(&p->pdev->dev);
>>> +	target_nid = p->target_node;
>>>  	online_nid = numa_map_to_online_node(target_nid);
>>>  	ndr_desc.numa_node = online_nid;
>>>  	ndr_desc.target_node = target_nid;
>>> @@ -1582,15 +1586,42 @@ static struct platform_driver papr_scm_driver = {
>>>  	},
>>>  };
>>>  
>>> +static int papr_scm_callback(struct notifier_block *self,
>>> +			     unsigned long action, void *arg)
>>> +{
>>> +	struct memory_notify *mnb = arg;
>>> +	int nid = mnb->status_change_nid;
>>> +	struct papr_scm_priv *p;
>>> +
>>> +	if (nid == NUMA_NO_NODE || action != MEM_ONLINE)
>>> +		return NOTIFY_OK;
>>> +
>>> +	mutex_lock(&papr_ndr_lock);
>>> +	list_for_each_entry(p, &papr_nd_regions, region_list) {
>>> +		if (p->target_node == nid) {
>>> +			node_devices[nid]->perf_level = MEMTIER_PERF_LEVEL_PMEM;
>>> +			break;
>>> +		}
>>> +	}
>>> +
>>> +	mutex_unlock(&papr_ndr_lock);
>>> +	return NOTIFY_OK;
>>> +}
>>> +
>>>  static int __init papr_scm_init(void)
>>>  {
>>>  	int ret;
>>>  
>>>  	ret = platform_driver_register(&papr_scm_driver);
>>> -	if (!ret)
>>> -		mce_register_notifier(&mce_ue_nb);
>>> -
>>> -	return ret;
>>> +	if (ret)
>>> +		return ret;
>>> +	mce_register_notifier(&mce_ue_nb);
>>> +	/*
>>> +	 * register a memory hotplug notifier at prio 2 so that we
>>> +	 * can update the perf level for the node.
>>> +	 */
>>> +	hotplug_memory_notifier(papr_scm_callback, MEMTIER_HOTPLUG_PRIO + 1);
>>> +	return 0;
>>>  }
>>>  module_init(papr_scm_init);
>>>  
>>> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
>>> index ae5f4acf2675..7ea1017ef790 100644
>>> --- a/drivers/acpi/nfit/core.c
>>> +++ b/drivers/acpi/nfit/core.c
>>> @@ -15,6 +15,8 @@
>>>  #include <linux/sort.h>
>>>  #include <linux/io.h>
>>>  #include <linux/nd.h>
>>> +#include <linux/memory.h>
>>> +#include <linux/memory-tiers.h>
>>>  #include <asm/cacheflush.h>
>>>  #include <acpi/nfit.h>
>>>  #include "intel.h"
>>> @@ -3470,6 +3472,39 @@ static struct acpi_driver acpi_nfit_driver = {
>>>  	},
>>>  };
>>>  
>>> +static int nfit_callback(struct notifier_block *self,
>>> +			 unsigned long action, void *arg)
>>> +{
>>> +	bool found = false;
>>> +	struct memory_notify *mnb = arg;
>>> +	int nid = mnb->status_change_nid;
>>> +	struct nfit_spa *nfit_spa;
>>> +	struct acpi_nfit_desc *acpi_desc;
>>> +
>>> +	if (nid == NUMA_NO_NODE || action != MEM_ONLINE)
>>> +		return NOTIFY_OK;
>>> +
>>> +	mutex_lock(&acpi_desc_lock);
>>> +	list_for_each_entry(acpi_desc, &acpi_descs, list) {
>>> +		mutex_lock(&acpi_desc->init_mutex);
>>> +		list_for_each_entry(nfit_spa, &acpi_desc->spas, list) {
>>> +			struct acpi_nfit_system_address *spa = nfit_spa->spa;
>>> +			int target_node = pxm_to_node(spa->proximity_domain);
>>> +
>>> +			if (target_node == nid) {
>>> +				node_devices[nid]->perf_level = MEMTIER_PERF_LEVEL_PMEM;
>>> +				found = true;
>>> +				break;
>>> +			}
>>> +		}
>>> +		mutex_unlock(&acpi_desc->init_mutex);
>>> +		if (found)
>>> +			break;
>>> +	}
>>> +	mutex_unlock(&acpi_desc_lock);
>>> +	return NOTIFY_OK;
>>> +}
>>> +
>>>  static __init int nfit_init(void)
>>>  {
>>>  	int ret;
>>> @@ -3509,7 +3544,11 @@ static __init int nfit_init(void)
>>>  		nfit_mce_unregister();
>>>  		destroy_workqueue(nfit_wq);
>>>  	}
>>> -
>>> +	/*
>>> +	 * register a memory hotplug notifier at prio 2 so that we
>>> +	 * can update the perf level for the node.
>>> +	 */
>>> +	hotplug_memory_notifier(nfit_callback, MEMTIER_HOTPLUG_PRIO + 1);
>>>  	return ret;
>>>  
>>>  }
>> 
>> I don't think that it's a good idea to set perf_level of a memory device
>> (node) via NFIT only.
>
>> 
>> For example, we may prefer HMAT over NFIT when it's available.  So the
>> perf_level should be set in dax/kmem.c based on information provided by
>> ACPI or other information sources.  ACPI can provide some functions/data
>> structures to let drivers (like dax/kmem.c) to query the properties of
>> the memory device (node).
>> 
>
> I was trying to make it architecture specific so that we have a placeholder
> to fine-tune this better. For example, ppc64 will look at device tree
> details to find the performance level and x86 will look at ACPI data structure.
> Adding that hotplug callback in dax/kmem will prevent that architecture-specific
> customization? 
>
> I would expect that callback to move to the generic ACPI layer so that even
> firmware managed CXL devices can be added to a lower tier?  I don't understand
> ACPI enough to find the right abstraction for that hotplug callback. 

I'm OK for this to be architecture specific.

But ACPI NFIT isn't enough for x86.  For example, PMEM can be added to a
virtual machine as normal memory nodes without NFIT.  Instead, PMEM is
marked via "memmap=<nn>G!<ss>G" or "efi_fake_mem=<nn>G@<ss>G:0x40000",
and dax/kmem.c is used to hot-add the memory.

So, before a more sophisticated version is implemented for x86.  The
simplest version as I suggested below works even better.

>> As the simplest first version, this can be just hard coded.
>> 
>
> If you are suggesting to not use hotplug callback, one of the challenge was node_devices[nid]
> get allocated pretty late when we try to online the node. 

As the simplest first version, this can be as simple as,

/* dax/kmem.c */
static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
{
	node_devices[dev_dax->target_node]->perf_level = MEMTIER_PERF_LEVEL_PMEM;
	/* add_memory_driver_managed() */
}

To be compatible with ppc64 version, how about make dev_dax_kmem_probe()
set perf_level only if it's uninitialized?

Best Regards,
Huang, Ying
