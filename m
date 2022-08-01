Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07971586269
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 04:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237625AbiHACG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 22:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233109AbiHACGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 22:06:53 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 143E3DF77
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 19:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659319612; x=1690855612;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=z3o9XhM+vgD3t9N8cNdE+UfIUMTL5F3Mmc63kX4QpwU=;
  b=HrR21sum+nTzOxu7oU+qDTUP8AAAXHAkxsaBdg/icuBytZYRVyW3ATI/
   VnVQI8sj0JmXF1ilqbzCKlEBcluMS1WaMX1UP/1ULFM4DMq1WIlwf+bsa
   aiGDx74ISncqWuk+iZtjimJoFoQ76iLE7rPXcLF0ODuvIy4Knmnek4Tn4
   z2XImQwFachuivu58Ejlk8d9h3a0NAcXRzcSWCM7ocfVLmsGKPU0xo/I6
   RGZdCu0wqQQZte8NKhnVT9UvAEywnr0lh0zwCyBFs7hjOrQNq9YAgCaQg
   gHy8+nva/jSKD9Y/iatlkje+WeKpF5lLrWsw6ZDJlVYn5G2nD/7/o/mqq
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10425"; a="290254398"
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="290254398"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2022 19:06:51 -0700
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="577612599"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2022 19:06:48 -0700
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
Subject: Re: [PATCH v11 4/8] mm/demotion/dax/kmem: Set node's abstract
 distance to MEMTIER_ADISTANCE_PMEM
References: <20220728190436.858458-1-aneesh.kumar@linux.ibm.com>
        <20220728190436.858458-5-aneesh.kumar@linux.ibm.com>
        <875yjgmocg.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <87bkt8s7w9.fsf@linux.ibm.com>
Date:   Mon, 01 Aug 2022 10:06:44 +0800
In-Reply-To: <87bkt8s7w9.fsf@linux.ibm.com> (Aneesh Kumar K. V.'s message of
        "Fri, 29 Jul 2022 12:49:34 +0530")
Message-ID: <87k07slnt7.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

> "Huang, Ying" <ying.huang@intel.com> writes:
>
>> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
>>
>>> By default, all nodes are assigned to the default memory tier which
>>> is the memory tier designated for nodes with DRAM
>>>
>>> Set dax kmem device node's tier to slower memory tier by assigning
>>> abstract distance to MEMTIER_ADISTANCE_PMEM. PMEM tier
>>> appears below the default memory tier in demotion order.
>>>
>>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>>> ---
>>>  drivers/dax/kmem.c           |  9 +++++++++
>>>  include/linux/memory-tiers.h | 19 ++++++++++++++++++-
>>>  mm/memory-tiers.c            | 28 ++++++++++++++++------------
>>>  3 files changed, 43 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
>>> index a37622060fff..6b0d5de9a3e9 100644
>>> --- a/drivers/dax/kmem.c
>>> +++ b/drivers/dax/kmem.c
>>> @@ -11,6 +11,7 @@
>>>  #include <linux/fs.h>
>>>  #include <linux/mm.h>
>>>  #include <linux/mman.h>
>>> +#include <linux/memory-tiers.h>
>>>  #include "dax-private.h"
>>>  #include "bus.h"
>>>  
>>> @@ -41,6 +42,12 @@ struct dax_kmem_data {
>>>  	struct resource *res[];
>>>  };
>>>  
>>> +static struct memory_dev_type default_pmem_type  = {
>>
>> Why is this named as default_pmem_type?  We will not change the memory
>> type of a node usually.
>>
>
> Any other suggestion? pmem_dev_type? 

Or dax_pmem_type?

DAX is used to enumerate the memory device.

>
>>> +	.adistance = MEMTIER_ADISTANCE_PMEM,
>>> +	.tier_sibiling = LIST_HEAD_INIT(default_pmem_type.tier_sibiling),
>>> +	.nodes  = NODE_MASK_NONE,
>>> +};
>>> +
>>>  static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
>>>  {
>>>  	struct device *dev = &dev_dax->dev;
>>> @@ -62,6 +69,8 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
>>>  		return -EINVAL;
>>>  	}
>>>  
>>> +	init_node_memory_type(numa_node, &default_pmem_type);
>>> +
>>
>> The memory hot-add below may fail.  So the error handling needs to be
>> added.
>>
>> And, it appears that the memory type and memory tier of a node may be
>> fully initialized here before NUMA hot-adding started.  So I suggest to
>> set node_memory_types[] here only.  And set memory_dev_type->nodes in
>> node hot-add callback.  I think there is the proper place to complete
>> the initialization.
>>
>> And, in theory dax/kmem.c can be unloaded.  So we need to clear
>> node_memory_types[] for nodes somewhere.
>>
>
> I guess by module exit we can be sure that all the memory managed
> by dax/kmem is hotplugged out. How about something like below?

Because we set node_memorty_types[] in dev_dax_kmem_probe(), it's
natural to clear it in dev_dax_kmem_remove().

Best Regards,
Huang, Ying

> diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
> index 6b0d5de9a3e9..eb4e158012a9 100644
> --- a/drivers/dax/kmem.c
> +++ b/drivers/dax/kmem.c
> @@ -248,6 +248,7 @@ static void __exit dax_kmem_exit(void)
>  	dax_driver_unregister(&device_dax_kmem_driver);
>  	if (!any_hotremove_failed)
>  		kfree_const(kmem_name);
> +	unregister_memory_type(&default_pmem_type);
>  }
>  
>  MODULE_AUTHOR("Intel Corporation");
> diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
> index fc6b7a14da51..8355baf5b8b4 100644
> --- a/include/linux/memory-tiers.h
> +++ b/include/linux/memory-tiers.h
> @@ -31,6 +31,7 @@ struct memory_dev_type {
>  #ifdef CONFIG_NUMA
>  extern bool numa_demotion_enabled;
>  void init_node_memory_type(int node, struct memory_dev_type *default_type);
> +void unregister_memory_type(struct memory_dev_type *memtype);
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
> diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
> index 064e0f932795..4d29ebd4c4f3 100644
> --- a/mm/memory-tiers.c
> +++ b/mm/memory-tiers.c
> @@ -500,6 +500,28 @@ void init_node_memory_type(int node, struct memory_dev_type *default_type)
>  	mutex_unlock(&memory_tier_lock);
>  }
>  
> +void unregister_memory_type(struct memory_dev_type *memtype)
> +{
> +	int node;
> +	struct memory_tier *memtier = memtype->memtier;
> +
> +	mutex_lock(&memory_tier_lock);
> +	for(node = 0; node < MAX_NUMNODES; node++) {
> +		if (node_memory_types[node] == memtype) {
> +			if (!nodes_empty(memtype->nodes))
> +				WARN_ON(1);
> +			node_memory_types[node] = NULL;
> +		}
> +	}
> +
> +	list_del(&memtype->tier_sibiling);
> +	memtype->memtier = NULL;
> +	if (list_empty(&memtier->memory_types))
> +		destroy_memory_tier(memtier);
> +
> +	mutex_unlock(&memory_tier_lock);
> +}
> +
>  void update_node_adistance(int node, struct memory_dev_type *memtype)
>  {
>  	pg_data_t *pgdat;
