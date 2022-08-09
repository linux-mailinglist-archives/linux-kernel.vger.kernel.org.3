Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69A3A58D236
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 05:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbiHIDEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 23:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiHIDEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 23:04:50 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD2C318
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 20:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660014288; x=1691550288;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=JOcCc0KYzx02fSk5EvG90qtDbizMYTOXE+s2cK++fHQ=;
  b=fmmKnheUHfU+3PIZuHmw3rPYkZ4Qql6G0VvFaLP+z8BwBIjyZmpW9Rgx
   JK7hsPyttu38JhxbL/abPRkuL3HATRzYCjly6i9j30e+zD2MnK9RAt4IP
   BZBFZoCPM1kZsvddVfHq5/ekvUptsALFSJRqwKvX7h8DRv2fXlBADmiQ/
   AQOokURF+OTOnt5ZFEwLgV05ipZ6Z+MNb6ZYrxsqjvPz1OZj/4T3i9cCK
   W9zBBjZeyIVdZ6tIKAgzKbOzdrfyEFbpA/EKSSGcgRFFg9Fk82WIpXZR+
   rE47BKr1ozwdcHj6zH4yZBPgmPCnFHEQhGy15a5ANhp8/UgB5LWNhNvbw
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10433"; a="316667951"
X-IronPort-AV: E=Sophos;i="5.93,223,1654585200"; 
   d="scan'208";a="316667951"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 20:04:48 -0700
X-IronPort-AV: E=Sophos;i="5.93,223,1654585200"; 
   d="scan'208";a="580621843"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 20:04:44 -0700
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
Subject: Re: [PATCH v13 4/9] mm/demotion/dax/kmem: Set node's abstract
 distance to MEMTIER_DEFAULT_DAX_ADISTANCE
References: <20220808062601.836025-1-aneesh.kumar@linux.ibm.com>
        <20220808062601.836025-5-aneesh.kumar@linux.ibm.com>
Date:   Tue, 09 Aug 2022 11:04:41 +0800
In-Reply-To: <20220808062601.836025-5-aneesh.kumar@linux.ibm.com> (Aneesh
        Kumar K. V.'s message of "Mon, 8 Aug 2022 11:55:56 +0530")
Message-ID: <87o7wuglrq.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
> more accurate value based on device tree details or HMAT.

I don't know how ACPI NFIT can help here.  Can you teach me?

Per my understanding, we may use the information provided by ACPI SLIT
or HMAT (or device tree via papr_scm) to create memory types.  Before
that is implemented, we just create a memory type with default abstract
distance.

> If the
> kernel doesn't find the memory type initialized, a default slower
> memory type is assigned by the kmem driver.
>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
>  drivers/dax/kmem.c           | 40 ++++++++++++++++++-
>  include/linux/memory-tiers.h | 26 ++++++++++++-
>  mm/memory-tiers.c            | 74 +++++++++++++++++++++++++-----------
>  3 files changed, 115 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
> index a37622060fff..b5cb03307af8 100644
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

We have 2 choices here.

1. The low level drivers create memory types and set
node_memory_types[].  We need a mechanism to coordinate among multiple
drivers.  On x86, we have ACPI SLIT, HMAT.  And we have platform
independent CXL defined CDAT.

2. The high level driver (such as dax/kmem.c) coordinate among multiple
low level drivers.  For example, it may query CXL CDAT firstly, and use
a notifier chain to query platform drivers with priority.

Personally, I prefer choice 2.  We can discuss this later.  But can we
make the comments more general to avoid to make decision now?

> +#define MEMTIER_DEFAULT_DAX_ADISTANCE	(MEMTIER_ADISTANCE_DRAM * 2)
> +
>  /* Memory resource name used for add_memory_driver_managed(). */
>  static const char *kmem_name;
>  /* Set if any memory will remain added when the driver will be unloaded. */
> @@ -41,6 +49,7 @@ struct dax_kmem_data {
>  	struct resource *res[];
>  };
>  
> +static struct memory_dev_type *dax_slowmem_type;

I don't think "slowmem" make much sense here.  There may be even slower
memory.  Just dax_mem_type or dax_kmem_type should be OK?

>  static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
>  {
>  	struct device *dev = &dev_dax->dev;
> @@ -62,6 +71,8 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
>  		return -EINVAL;
>  	}
>  
> +	init_node_memory_type(numa_node, dax_slowmem_type);
> +

I don't find error handling in this function.  Per my understanding, if
memory hot-add fails, we need to call clear_node_memory_type().

>  	for (i = 0; i < dev_dax->nr_range; i++) {
>  		struct range range;
>  
> @@ -162,6 +173,7 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
>  static void dev_dax_kmem_remove(struct dev_dax *dev_dax)
>  {
>  	int i, success = 0;
> +	int node = dev_dax->target_node;
>  	struct device *dev = &dev_dax->dev;
>  	struct dax_kmem_data *data = dev_get_drvdata(dev);
>  
> @@ -198,6 +210,14 @@ static void dev_dax_kmem_remove(struct dev_dax *dev_dax)
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
> @@ -228,9 +248,27 @@ static int __init dax_kmem_init(void)
>  	if (!kmem_name)
>  		return -ENOMEM;
>  
> +	dax_slowmem_type = kmalloc(sizeof(*dax_slowmem_type), GFP_KERNEL);
> +	if (!dax_slowmem_type) {
> +		rc = -ENOMEM;
> +		goto kmem_name_free;
> +	}
> +	dax_slowmem_type->adistance = MEMTIER_DEFAULT_DAX_ADISTANCE;
> +	INIT_LIST_HEAD(&dax_slowmem_type->tier_sibiling);
> +	dax_slowmem_type->nodes  = NODE_MASK_NONE;
> +	dax_slowmem_type->memtier = NULL;
> +	kref_init(&dax_slowmem_type->kref);
> +

Here we initialize the kref to 1.  So in dax_kmem_exit() we should drop
the last reference, otherwise we cannot free the memory type?

>  	rc = dax_driver_register(&device_dax_kmem_driver);
>  	if (rc)
> -		kfree_const(kmem_name);
> +		goto error_out;
> +
> +	return rc;
> +
> +error_out:
> +	kfree(dax_slowmem_type);
> +kmem_name_free:
> +	kfree_const(kmem_name);
>  	return rc;
>  }
>  
> diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
> index cc89876899a6..7bf6f47d581a 100644
> --- a/include/linux/memory-tiers.h
> +++ b/include/linux/memory-tiers.h
> @@ -2,6 +2,8 @@
>  #ifndef _LINUX_MEMORY_TIERS_H
>  #define _LINUX_MEMORY_TIERS_H
>  
> +#include <linux/types.h>
> +#include <linux/nodemask.h>
>  /*
>   * Each tier cover a abstrace distance chunk size of 128
>   */
> @@ -13,12 +15,34 @@
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
> +void init_node_memory_type(int node, struct memory_dev_type *default_type);
> +void clear_node_memory_type(int node, struct memory_dev_type *memtype);
>  
>  #else
>  
>  #define numa_demotion_enabled	false
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
> index 2caa5ab446b8..e07dffb67567 100644
> --- a/mm/memory-tiers.c
> +++ b/mm/memory-tiers.c
> @@ -1,6 +1,4 @@
>  // SPDX-License-Identifier: GPL-2.0
> -#include <linux/types.h>
> -#include <linux/nodemask.h>
>  #include <linux/slab.h>
>  #include <linux/lockdep.h>
>  #include <linux/sysfs.h>
> @@ -21,26 +19,10 @@ struct memory_tier {
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
> - * For now let's have 4 memory tier below default DRAM tier.
> - */
> -static struct memory_dev_type default_dram_type  = {
> -	.adistance = MEMTIER_ADISTANCE_DRAM,
> -	.tier_sibiling = LIST_HEAD_INIT(default_dram_type.tier_sibiling),
> -};
> +static struct memory_dev_type *default_dram_type;
>  
>  static struct memory_tier *find_create_memory_tier(struct memory_dev_type *memtype)
>  {
> @@ -96,6 +78,14 @@ static struct memory_tier *__node_get_memory_tier(int node)
>  	return NULL;
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
> @@ -107,7 +97,7 @@ static struct memory_tier *set_node_memory_tier(int node)
>  		return ERR_PTR(-EINVAL);
>  
>  	if (!node_memory_types[node])
> -		node_memory_types[node] = &default_dram_type;
> +		__init_node_memory_type(node, default_dram_type);
>  
>  	memtype = node_memory_types[node];
>  	node_set(node, memtype->nodes);
> @@ -143,6 +133,34 @@ static bool clear_node_memory_tier(int node)
>  	return cleared;
>  }
>  
> +void init_node_memory_type(int node, struct memory_dev_type *default_type)
> +{
> +
> +	mutex_lock(&memory_tier_lock);
> +	__init_node_memory_type(node, default_type);
> +	mutex_unlock(&memory_tier_lock);
> +}
> +EXPORT_SYMBOL_GPL(init_node_memory_type);
> +
> +static void release_memtype(struct kref *kref)
> +{
> +	struct memory_dev_type *memtype;
> +
> +	memtype = container_of(kref, struct memory_dev_type, kref);
> +	kfree(memtype);
> +}
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
> @@ -176,17 +194,27 @@ static int __init memory_tier_init(void)
>  	int node;
>  	struct memory_tier *memtier;
>  
> +	default_dram_type = kmalloc(sizeof(*default_dram_type), GFP_KERNEL);
> +	if (!default_dram_type)
> +		panic("%s() failed to allocate default DRAM tier\n", __func__);
> +
>  	mutex_lock(&memory_tier_lock);
> +
> +	/* For now let's have 4 memory tier below default DRAM tier. */
> +	default_dram_type->adistance = MEMTIER_ADISTANCE_DRAM;
> +	INIT_LIST_HEAD(&default_dram_type->tier_sibiling);
> +	default_dram_type->memtier = NULL;
> +	kref_init(&default_dram_type->kref);

It appears that we can define a function to initialize a memory type.

>  	/* CPU only nodes are not part of memory tiers. */
> -	default_dram_type.nodes = node_states[N_MEMORY];
> +	default_dram_type->nodes = node_states[N_MEMORY];
>  
> -	memtier = find_create_memory_tier(&default_dram_type);
> +	memtier = find_create_memory_tier(default_dram_type);
>  	if (IS_ERR(memtier))
>  		panic("%s() failed to register memory tier: %ld\n",
>  		      __func__, PTR_ERR(memtier));
>  
>  	for_each_node_state(node, N_MEMORY)
> -		node_memory_types[node] = &default_dram_type;
> +		__init_node_memory_type(node, default_dram_type);
>  
>  	mutex_unlock(&memory_tier_lock);

Best Regards,
Huang, Ying
