Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA5B586420
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 08:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232432AbiHAGh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 02:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiHAGh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 02:37:27 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370BB12756
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 23:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659335846; x=1690871846;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=MaJXiBaxLLBxqBVZFl3PrTZwYtLf0XxDzp3tXRpmeBM=;
  b=agLWfDvKiU11A2VYIM3lkNDMRKoSE1u5dZqSXsjfSq0V1qT+rcuORapJ
   RKdNREKAvpN+z3w71zEIPbw+PfFhP0TiK95XaObXev+TAjBKDd6AcifU+
   EAQWfQs4NPlgtKKuBI07IVdVmR0ojDapc4SKII7EcT/3dsdqMKiU0ZC2q
   D2i+PtTUJeTyFNTUiaIIWTbLafA5EAvDDkwG9uHE/h96kxXDQ915wTGAP
   CBCyAXlIFa8/LPeEPLT5bmbW9XkPYGP3kUTUX9PbiZVM+O0+VWtMkybQN
   fafmVyHusqnyR1P+TN6+40ciiGi5rus/KJH6cel1qU07/XQbOmY82xvNQ
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10425"; a="275974617"
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="275974617"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2022 23:37:25 -0700
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="577671306"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2022 23:37:21 -0700
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
Subject: Re: [PATCH v11 4/8] mm/demotion/dax/kmem: Set node's abstract
 distance to MEMTIER_ADISTANCE_PMEM
References: <20220728190436.858458-1-aneesh.kumar@linux.ibm.com>
        <20220728190436.858458-5-aneesh.kumar@linux.ibm.com>
        <875yjgmocg.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <87bkt8s7w9.fsf@linux.ibm.com>
        <87k07slnt7.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <e5545c90-9595-d08c-8a1c-1c15e3b94999@linux.ibm.com>
        <87tu6wk0q5.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <826fbdbc-219f-8f4a-7373-41c718287533@linux.ibm.com>
Date:   Mon, 01 Aug 2022 14:37:17 +0800
In-Reply-To: <826fbdbc-219f-8f4a-7373-41c718287533@linux.ibm.com> (Aneesh
        Kumar K. V.'s message of "Mon, 1 Aug 2022 11:08:20 +0530")
Message-ID: <87les8jwpu.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

> On 8/1/22 10:40 AM, Huang, Ying wrote:
>> Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> writes:
>> 
>>> On 8/1/22 7:36 AM, Huang, Ying wrote:
>>>> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
>>>>
>>>>> "Huang, Ying" <ying.huang@intel.com> writes:
>>>>>
>>>>>> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
>>>>>>
>>>>>>> By default, all nodes are assigned to the default memory tier which
>>>>>>> is the memory tier designated for nodes with DRAM
>>>>>>>
>>>>>>> Set dax kmem device node's tier to slower memory tier by assigning
>>>>>>> abstract distance to MEMTIER_ADISTANCE_PMEM. PMEM tier
>>>>>>> appears below the default memory tier in demotion order.
>>>>>>>
>>>>>>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>>>>>>> ---
>>>>>>>  drivers/dax/kmem.c           |  9 +++++++++
>>>>>>>  include/linux/memory-tiers.h | 19 ++++++++++++++++++-
>>>>>>>  mm/memory-tiers.c            | 28 ++++++++++++++++------------
>>>>>>>  3 files changed, 43 insertions(+), 13 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
>>>>>>> index a37622060fff..6b0d5de9a3e9 100644
>>>>>>> --- a/drivers/dax/kmem.c
>>>>>>> +++ b/drivers/dax/kmem.c
>>>>>>> @@ -11,6 +11,7 @@
>>>>>>>  #include <linux/fs.h>
>>>>>>>  #include <linux/mm.h>
>>>>>>>  #include <linux/mman.h>
>>>>>>> +#include <linux/memory-tiers.h>
>>>>>>>  #include "dax-private.h"
>>>>>>>  #include "bus.h"
>>>>>>>  
>>>>>>> @@ -41,6 +42,12 @@ struct dax_kmem_data {
>>>>>>>  	struct resource *res[];
>>>>>>>  };
>>>>>>>  
>>>>>>> +static struct memory_dev_type default_pmem_type  = {
>>>>>>
>>>>>> Why is this named as default_pmem_type?  We will not change the memory
>>>>>> type of a node usually.
>>>>>>
>>>>>
>>>>> Any other suggestion? pmem_dev_type? 
>>>>
>>>> Or dax_pmem_type?
>>>>
>>>> DAX is used to enumerate the memory device.
>>>>
>>>>>
>>>>>>> +	.adistance = MEMTIER_ADISTANCE_PMEM,
>>>>>>> +	.tier_sibiling = LIST_HEAD_INIT(default_pmem_type.tier_sibiling),
>>>>>>> +	.nodes  = NODE_MASK_NONE,
>>>>>>> +};
>>>>>>> +
>>>>>>>  static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
>>>>>>>  {
>>>>>>>  	struct device *dev = &dev_dax->dev;
>>>>>>> @@ -62,6 +69,8 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
>>>>>>>  		return -EINVAL;
>>>>>>>  	}
>>>>>>>  
>>>>>>> +	init_node_memory_type(numa_node, &default_pmem_type);
>>>>>>> +
>>>>>>
>>>>>> The memory hot-add below may fail.  So the error handling needs to be
>>>>>> added.
>>>>>>
>>>>>> And, it appears that the memory type and memory tier of a node may be
>>>>>> fully initialized here before NUMA hot-adding started.  So I suggest to
>>>>>> set node_memory_types[] here only.  And set memory_dev_type->nodes in
>>>>>> node hot-add callback.  I think there is the proper place to complete
>>>>>> the initialization.
>>>>>>
>>>>>> And, in theory dax/kmem.c can be unloaded.  So we need to clear
>>>>>> node_memory_types[] for nodes somewhere.
>>>>>>
>>>>>
>>>>> I guess by module exit we can be sure that all the memory managed
>>>>> by dax/kmem is hotplugged out. How about something like below?
>>>>
>>>> Because we set node_memorty_types[] in dev_dax_kmem_probe(), it's
>>>> natural to clear it in dev_dax_kmem_remove().
>>>>
>>>
>>> Most of required reset/clear is done as part of memory hotunplug. So
>>> if we did manage to successfully unplug the memory, everything except
>>> node_memory_types[node] should be reset. That makes the clear_node_memory_type
>>> the below. 
>>>
>>> void clear_node_memory_type(int node, struct memory_dev_type *memtype)
>>> {
>>>
>>> 	mutex_lock(&memory_tier_lock);
>>> 	/*
>>> 	 * memory unplug did clear the node from the memtype and
>>> 	 * dax/kem did initialize this node's memory type.
>>> 	 */
>>> 	if (!node_isset(node, memtype->nodes) && node_memory_types[node]  == memtype){
>>> 		node_memory_types[node] = NULL;
>>> 	}
>>> 	mutex_unlock(&memory_tier_lock);
>>> }
>>>
>>> With the module unload, it is kind of force removing the usage of the specific memtype.
>>> Considering module unload will remove the usage of specific memtype from other parts
>>> of the kernel and we already do all the required reset in memory hot unplug, do we
>>> need to do the clear_node_memory_type above? 
>> 
>> Per my understanding, we need to call clear_node_memory_type() in
>> dev_dax_kmem_remove().  After that, we have nothing to do in
>> dax_kmem_exit().
>> 
>
> Ok, I guess you are suggesting to do the clear_node_memory_type even if we fail the memory remove. 

Can we use node_memory_types[] to indicate whether a node is managed by
a driver?

Regardless being succeeded or failed, dev_dax_kmem_remove() will set
node_memory_types[] = NULL.  But until node is offlined, we will still
keep the node in the memory_dev_type (dax_pmem_type).

And we will prevent dax/kmem from unloading via try_module_get() and add
"struct module *" to struct memory_dev_type.

Best Regards,
Huang, Ying

> Should we also rebuild demotion order? On a successful memory remove we do rebuild demotion order.
> This is what i ended up with.
>
> modified   drivers/dax/kmem.c
> @@ -171,6 +171,7 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
>  static void dev_dax_kmem_remove(struct dev_dax *dev_dax)
>  {
>  	int i, success = 0;
> +	int node = dev_dax->target_node;
>  	struct device *dev = &dev_dax->dev;
>  	struct dax_kmem_data *data = dev_get_drvdata(dev);
>  
> @@ -208,6 +209,12 @@ static void dev_dax_kmem_remove(struct dev_dax *dev_dax)
>  		kfree(data);
>  		dev_set_drvdata(dev, NULL);
>  	}
> +	/*
> +	 * Clear the memtype association, even if the memory
> +	 * remove failed.
> +	 */
> +	clear_node_memory_type(node, dax_pmem_type);
> +
>  }
>  #else
>  static void dev_dax_kmem_remove(struct dev_dax *dev_dax)
> modified   include/linux/memory-tiers.h
> @@ -31,6 +31,7 @@ struct memory_dev_type {
>  #ifdef CONFIG_NUMA
>  extern bool numa_demotion_enabled;
>  void init_node_memory_type(int node, struct memory_dev_type *default_type);
> +void clear_node_memory_type(int node, struct memory_dev_type *memtype);
>  #ifdef CONFIG_MIGRATION
>  int next_demotion_node(int node);
>  void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets);
> @@ -57,6 +58,10 @@ static inline bool node_is_toptier(int node)
>  #define numa_demotion_enabled	false
>  static inline void init_node_memory_type(int node, struct memory_dev_type *default_type)
>  {
> +}
> +
> +static inline void unregister_memory_type(struct memory_dev_type *memtype)
> +{
>  
>  }
>  
> modified   mm/memory-tiers.c
> @@ -501,6 +501,36 @@ void init_node_memory_type(int node, struct memory_dev_type *default_type)
>  }
>  EXPORT_SYMBOL_GPL(init_node_memory_type);
>  
> +void clear_node_memory_type(int node, struct memory_dev_type *memtype)
> +{
> +	struct memory_tier *memtier;
> +
> +	mutex_lock(&memory_tier_lock);
> +	/*
> +	 * Even if we fail to unplug memory, clear the association of
> +	 * this node to this specific memory type.
> +	 */
> +	if (node_memory_types[node] == memtype) {
> +
> +		memtier = __node_get_memory_tier(node);
> +		if (memtier) {
> +			rcu_assign_pointer(pgdat->memtier, NULL);
> +			synchronize_rcu();
> +		}
> +		node_clear(node, memtype->nodes);
> +		if (nodes_empty(memtype->nodes)) {
> +			list_del(&memtype->tier_sibiling);
> +			memtype->memtier = NULL;
> +			if (current_memtier && list_empty(&current_memtier->memory_types))
> +				destroy_memory_tier(current_memtier);
> +
> +		}
> +		node_memory_types[node] = NULL;
> +	}
> +	mutex_unlock(&memory_tier_lock);
> +}
> +EXPORT_SYMBOL_GPL(init_node_memory_type);
> +
>  void update_node_adistance(int node, struct memory_dev_type *memtype)
>  {
>  	pg_data_t *pgdat;
>
> [back
