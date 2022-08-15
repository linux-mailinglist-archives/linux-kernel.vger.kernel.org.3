Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01F4A5927D6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 04:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232704AbiHOCjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 22:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiHOCjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 22:39:19 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F67413D5D
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 19:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660531158; x=1692067158;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=AN1MAQ1y/+tkJccB2YCf5QJeYOGrQnHWd3cYrqupcmg=;
  b=CrtqDGA0boqdqyYid8KGhCsDe3fQR4mKv3VhBbjQt3LsftJTJZKOH+gx
   aqVz2naPciMWlM4bFtuvYs6hze0AYbXyIpCjJBj8VeezwD1RFLKEwgt2l
   VAWkG6UM/Sm2mRG5tx3VBXAoLIY8gKlZ3BEKdChaRq6c4dlMnOnMLExlI
   4xY+V2AkNvRZDs1Dr/gpeHpoG7f9xwLL5V9CoAHF4X6/xBsh+Q4v0S5rG
   UaO3L1MpYjGZLyidrnLwUe3ueXTAG3cO0bAcxBP8epYE5b4aiz17hu0s6
   WSO08KLsomjhwDmVjOOTrXxPGzrfgmbImk3c8nTvdocVbFpTLlxJFBMm1
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10439"; a="271649094"
X-IronPort-AV: E=Sophos;i="5.93,237,1654585200"; 
   d="scan'208";a="271649094"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2022 19:39:17 -0700
X-IronPort-AV: E=Sophos;i="5.93,237,1654585200"; 
   d="scan'208";a="557140195"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2022 19:39:13 -0700
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
        Bharata B Rao <bharata@amd.com>
Subject: Re: [PATCH v14 04/10] mm/demotion/dax/kmem: Set node's abstract
 distance to MEMTIER_DEFAULT_DAX_ADISTANCE
References: <20220812055710.357820-1-aneesh.kumar@linux.ibm.com>
        <20220812055710.357820-5-aneesh.kumar@linux.ibm.com>
Date:   Mon, 15 Aug 2022 10:39:10 +0800
In-Reply-To: <20220812055710.357820-5-aneesh.kumar@linux.ibm.com> (Aneesh
        Kumar K. V.'s message of "Fri, 12 Aug 2022 11:27:03 +0530")
Message-ID: <87wnbacjsh.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:

> By default, all nodes are assigned to the default memory tier which
> is the memory tier designated for nodes with DRAM
>
> Set dax kmem device node's tier to slower memory tier by assigning
> abstract distance to MEMTIER_DEFAULT_DAX_ADISTANCE. Low-level drivers
> like papr_scm or ACPI NFIT can initialize memory device type to a
> more accurate value based on device tree details or HMAT. If the
> kernel doesn't find the memory type initialized, a default slower
> memory type is assigned by the kmem driver.
>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
>  drivers/dax/kmem.c           | 42 +++++++++++++++--
>  include/linux/memory-tiers.h | 42 ++++++++++++++++-
>  mm/memory-tiers.c            | 91 +++++++++++++++++++++++++++---------
>  3 files changed, 149 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
> index a37622060fff..d88814f1c414 100644
> --- a/drivers/dax/kmem.c
> +++ b/drivers/dax/kmem.c
> @@ -11,9 +11,17 @@
>  #include <linux/fs.h>
>  #include <linux/mm.h>
>  #include <linux/mman.h>
> +#include <linux/memory-tiers.h>
>  #include "dax-private.h"
>  #include "bus.h"
>  
> +/*
> + * Default abstract distance assigned to the NUMA node onlined
> + * by DAX/kmem if the low level platform driver didn't initialize
> + * one for this NUMA node.
> + */
> +#define MEMTIER_DEFAULT_DAX_ADISTANCE	(MEMTIER_ADISTANCE_DRAM * 2)

If my understanding were correct, this is targeting Optane DCPMM for
now.  The measured results in the following paper is,

https://arxiv.org/pdf/2002.06018.pdf

Section: 2.1 Read/Write Latencies

"
For read access, the latency of DCPMM was 400.1% higher than that of
DRAM. For write access, it was 407.1% higher.
"

Section: 2.2 Read/Write Bandwidths

"
For read access, the throughput of DCPMM was 37.1% of DRAM. For write
access, it was 7.8%
"

According to the above data, I think the MEMTIER_DEFAULT_DAX_ADISTANCE
can be "5 * MEMTIER_ADISTANCE_DRAM".

Best Regards,
Huang, Ying

> +
>  /* Memory resource name used for add_memory_driver_managed(). */
>  static const char *kmem_name;
>  /* Set if any memory will remain added when the driver will be unloaded. */
> @@ -41,6 +49,7 @@ struct dax_kmem_data {
>  	struct resource *res[];
>  };
>  
> +static struct memory_dev_type *dax_slowmem_type;
>  static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
>  {
>  	struct device *dev = &dev_dax->dev;
> @@ -79,11 +88,13 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
>  		return -EINVAL;
>  	}
>  
> +	init_node_memory_type(numa_node, dax_slowmem_type);
> +
> +	rc = -ENOMEM;
>  	data = kzalloc(struct_size(data, res, dev_dax->nr_range), GFP_KERNEL);
>  	if (!data)
> -		return -ENOMEM;
> +		goto err_dax_kmem_data;
>  
> -	rc = -ENOMEM;
>  	data->res_name = kstrdup(dev_name(dev), GFP_KERNEL);
>  	if (!data->res_name)
>  		goto err_res_name;
> @@ -155,6 +166,8 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
>  	kfree(data->res_name);
>  err_res_name:
>  	kfree(data);
> +err_dax_kmem_data:
> +	clear_node_memory_type(numa_node, dax_slowmem_type);
>  	return rc;
>  }
>  
> @@ -162,6 +175,7 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
>  static void dev_dax_kmem_remove(struct dev_dax *dev_dax)
>  {
>  	int i, success = 0;
> +	int node = dev_dax->target_node;
>  	struct device *dev = &dev_dax->dev;
>  	struct dax_kmem_data *data = dev_get_drvdata(dev);
>  
> @@ -198,6 +212,14 @@ static void dev_dax_kmem_remove(struct dev_dax *dev_dax)
>  		kfree(data->res_name);
>  		kfree(data);
>  		dev_set_drvdata(dev, NULL);
> +		/*
> +		 * Clear the memtype association on successful unplug.
> +		 * If not, we have memory blocks left which can be
> +		 * offlined/onlined later. We need to keep memory_dev_type
> +		 * for that. This implies this reference will be around
> +		 * till next reboot.
> +		 */
> +		clear_node_memory_type(node, dax_slowmem_type);
>  	}
>  }
>  #else
> @@ -228,9 +250,22 @@ static int __init dax_kmem_init(void)
>  	if (!kmem_name)
>  		return -ENOMEM;
>  
> +	dax_slowmem_type = alloc_memory_type(MEMTIER_DEFAULT_DAX_ADISTANCE);
> +	if (IS_ERR(dax_slowmem_type)) {
> +		rc = PTR_ERR(dax_slowmem_type);
> +		goto err_dax_slowmem_type;
> +	}
> +
>  	rc = dax_driver_register(&device_dax_kmem_driver);
>  	if (rc)
> -		kfree_const(kmem_name);
> +		goto error_dax_driver;
> +
> +	return rc;
> +
> +error_dax_driver:
> +	destroy_memory_type(dax_slowmem_type);
> +err_dax_slowmem_type:
> +	kfree_const(kmem_name);
>  	return rc;
>  }
>  
> @@ -239,6 +274,7 @@ static void __exit dax_kmem_exit(void)
>  	dax_driver_unregister(&device_dax_kmem_driver);
>  	if (!any_hotremove_failed)
>  		kfree_const(kmem_name);
> +	destroy_memory_type(dax_slowmem_type);
>  }
>  
>  MODULE_AUTHOR("Intel Corporation");
> diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
> index cc89876899a6..0c739508517a 100644
> --- a/include/linux/memory-tiers.h
> +++ b/include/linux/memory-tiers.h
> @@ -2,6 +2,9 @@
>  #ifndef _LINUX_MEMORY_TIERS_H
>  #define _LINUX_MEMORY_TIERS_H
>  
> +#include <linux/types.h>
> +#include <linux/nodemask.h>
> +#include <linux/kref.h>
>  /*
>   * Each tier cover a abstrace distance chunk size of 128
>   */
> @@ -13,12 +16,49 @@
>  #define MEMTIER_ADISTANCE_DRAM	(4 * MEMTIER_CHUNK_SIZE)
>  #define MEMTIER_HOTPLUG_PRIO	100
>  
> +struct memory_tier;
> +struct memory_dev_type {
> +	/* list of memory types that are part of same tier as this type */
> +	struct list_head tier_sibiling;
> +	/* abstract distance for this specific memory type */
> +	int adistance;
> +	/* Nodes of same abstract distance */
> +	nodemask_t nodes;
> +	struct kref kref;
> +	struct memory_tier *memtier;
> +};
> +
>  #ifdef CONFIG_NUMA
> -#include <linux/types.h>
>  extern bool numa_demotion_enabled;
> +struct memory_dev_type *alloc_memory_type(int adistance);
> +void destroy_memory_type(struct memory_dev_type *memtype);
> +void init_node_memory_type(int node, struct memory_dev_type *default_type);
> +void clear_node_memory_type(int node, struct memory_dev_type *memtype);
>  
>  #else
>  
>  #define numa_demotion_enabled	false
> +/*
> + * CONFIG_NUMA implementation returns non NULL error.
> + */
> +static inline struct memory_dev_type *alloc_memory_type(int adistance)
> +{
> +	return NULL;
> +}
> +
> +static inline void destroy_memory_type(struct memory_dev_type *memtype)
> +{
> +
> +}
> +
> +static inline void init_node_memory_type(int node, struct memory_dev_type *default_type)
> +{
> +
> +}
> +
> +static inline void clear_node_memory_type(int node, struct memory_dev_type *memtype)
> +{
> +
> +}
>  #endif	/* CONFIG_NUMA */
>  #endif  /* _LINUX_MEMORY_TIERS_H */
> diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
> index 05f05395468a..e52ccbcb2b27 100644
> --- a/mm/memory-tiers.c
> +++ b/mm/memory-tiers.c
> @@ -1,6 +1,4 @@
>  // SPDX-License-Identifier: GPL-2.0
> -#include <linux/types.h>
> -#include <linux/nodemask.h>
>  #include <linux/slab.h>
>  #include <linux/lockdep.h>
>  #include <linux/sysfs.h>
> @@ -21,27 +19,10 @@ struct memory_tier {
>  	int adistance_start;
>  };
>  
> -struct memory_dev_type {
> -	/* list of memory types that are part of same tier as this type */
> -	struct list_head tier_sibiling;
> -	/* abstract distance for this specific memory type */
> -	int adistance;
> -	/* Nodes of same abstract distance */
> -	nodemask_t nodes;
> -	struct memory_tier *memtier;
> -};
> -
>  static DEFINE_MUTEX(memory_tier_lock);
>  static LIST_HEAD(memory_tiers);
>  static struct memory_dev_type *node_memory_types[MAX_NUMNODES];
> -/*
> - * For now we can have 4 faster memory tiers with smaller adistance
> - * than default DRAM tier.
> - */
> -static struct memory_dev_type default_dram_type  = {
> -	.adistance = MEMTIER_ADISTANCE_DRAM,
> -	.tier_sibiling = LIST_HEAD_INIT(default_dram_type.tier_sibiling),
> -};
> +static struct memory_dev_type *default_dram_type;
>  
>  static struct memory_tier *find_create_memory_tier(struct memory_dev_type *memtype)
>  {
> @@ -87,6 +68,14 @@ static struct memory_tier *find_create_memory_tier(struct memory_dev_type *memty
>  	return new_memtier;
>  }
>  
> +static inline void __init_node_memory_type(int node, struct memory_dev_type *default_type)
> +{
> +	if (!node_memory_types[node]) {
> +		node_memory_types[node] = default_type;
> +		kref_get(&default_type->kref);
> +	}
> +}
> +
>  static struct memory_tier *set_node_memory_tier(int node)
>  {
>  	struct memory_tier *memtier;
> @@ -97,8 +86,7 @@ static struct memory_tier *set_node_memory_tier(int node)
>  	if (!node_state(node, N_MEMORY))
>  		return ERR_PTR(-EINVAL);
>  
> -	if (!node_memory_types[node])
> -		node_memory_types[node] = &default_dram_type;
> +	__init_node_memory_type(node, default_dram_type);
>  
>  	memtype = node_memory_types[node];
>  	node_set(node, memtype->nodes);
> @@ -144,6 +132,57 @@ static bool clear_node_memory_tier(int node)
>  	return cleared;
>  }
>  
> +static void release_memtype(struct kref *kref)
> +{
> +	struct memory_dev_type *memtype;
> +
> +	memtype = container_of(kref, struct memory_dev_type, kref);
> +	kfree(memtype);
> +}
> +
> +struct memory_dev_type *alloc_memory_type(int adistance)
> +{
> +	struct memory_dev_type *memtype;
> +
> +	memtype = kmalloc(sizeof(*memtype), GFP_KERNEL);
> +	if (!memtype)
> +		return ERR_PTR(-ENOMEM);
> +
> +	memtype->adistance = adistance;
> +	INIT_LIST_HEAD(&memtype->tier_sibiling);
> +	memtype->nodes  = NODE_MASK_NONE;
> +	memtype->memtier = NULL;
> +	kref_init(&memtype->kref);
> +	return memtype;
> +}
> +EXPORT_SYMBOL_GPL(alloc_memory_type);
> +
> +void destroy_memory_type(struct memory_dev_type *memtype)
> +{
> +	kref_put(&memtype->kref, release_memtype);
> +}
> +EXPORT_SYMBOL_GPL(destroy_memory_type);
> +
> +void init_node_memory_type(int node, struct memory_dev_type *default_type)
> +{
> +
> +	mutex_lock(&memory_tier_lock);
> +	__init_node_memory_type(node, default_type);
> +	mutex_unlock(&memory_tier_lock);
> +}
> +EXPORT_SYMBOL_GPL(init_node_memory_type);
> +
> +void clear_node_memory_type(int node, struct memory_dev_type *memtype)
> +{
> +	mutex_lock(&memory_tier_lock);
> +	if (node_memory_types[node] == memtype) {
> +		node_memory_types[node] = NULL;
> +		kref_put(&memtype->kref, release_memtype);
> +	}
> +	mutex_unlock(&memory_tier_lock);
> +}
> +EXPORT_SYMBOL_GPL(clear_node_memory_type);
> +
>  static int __meminit memtier_hotplug_callback(struct notifier_block *self,
>  					      unsigned long action, void *_arg)
>  {
> @@ -178,6 +217,14 @@ static int __init memory_tier_init(void)
>  	struct memory_tier *memtier;
>  
>  	mutex_lock(&memory_tier_lock);
> +	/*
> +	 * For now we can have 4 faster memory tiers with smaller adistance
> +	 * than default DRAM tier.
> +	 */
> +	default_dram_type = alloc_memory_type(MEMTIER_ADISTANCE_DRAM);
> +	if (!default_dram_type)
> +		panic("%s() failed to allocate default DRAM tier\n", __func__);
> +
>  	/*
>  	 * Look at all the existing N_MEMORY nodes and add them to
>  	 * default memory tier or to a tier if we already have memory
