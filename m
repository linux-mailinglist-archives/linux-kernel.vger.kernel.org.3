Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEA03584B9C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 08:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234670AbiG2GU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 02:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234515AbiG2GUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 02:20:55 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC0817AC03
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 23:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659075654; x=1690611654;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=p53zOWl9ehLCjjDCiyqYBG5Q0r1x8FuF8Dzv+TD7iFE=;
  b=FccKIEEBX4XzASkb2pDcoW44zxHzqBi1zFgtaEAYytuP4uQ5d2U/s9cn
   I0EO1BmMOB7Fr7uTH5d2XPS2klsv2lT0yyah1pF1dKdClCy2OlJJ3/nxg
   P3KuDxisZaU9fiQBDugxBTtM3SJ4nmXGAWlo+IxBPdRyKzcwgG8Yg7/wh
   BdZm3xn2B3+C4BbVO16fUQd8ir7mU+X34IURHC+CQDCUTIY0PLlJbPHXX
   tyrbsglHYkwuXWJ+yi85KJhqk0QPyls3ji20ZUm72+koeU/BNIvuA8rIw
   G6kYUKkmk2OB4kUMrEOB1Z2LVruwxJGxyaGO2PbKZrngG1vuh6tjp641T
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10422"; a="269085202"
X-IronPort-AV: E=Sophos;i="5.93,200,1654585200"; 
   d="scan'208";a="269085202"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2022 23:20:54 -0700
X-IronPort-AV: E=Sophos;i="5.93,200,1654585200"; 
   d="scan'208";a="928629089"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.94])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2022 23:20:51 -0700
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
Date:   Fri, 29 Jul 2022 14:20:47 +0800
In-Reply-To: <20220728190436.858458-5-aneesh.kumar@linux.ibm.com> (Aneesh
        Kumar K. V.'s message of "Fri, 29 Jul 2022 00:34:32 +0530")
Message-ID: <875yjgmocg.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
> abstract distance to MEMTIER_ADISTANCE_PMEM. PMEM tier
> appears below the default memory tier in demotion order.
>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
>  drivers/dax/kmem.c           |  9 +++++++++
>  include/linux/memory-tiers.h | 19 ++++++++++++++++++-
>  mm/memory-tiers.c            | 28 ++++++++++++++++------------
>  3 files changed, 43 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
> index a37622060fff..6b0d5de9a3e9 100644
> --- a/drivers/dax/kmem.c
> +++ b/drivers/dax/kmem.c
> @@ -11,6 +11,7 @@
>  #include <linux/fs.h>
>  #include <linux/mm.h>
>  #include <linux/mman.h>
> +#include <linux/memory-tiers.h>
>  #include "dax-private.h"
>  #include "bus.h"
>  
> @@ -41,6 +42,12 @@ struct dax_kmem_data {
>  	struct resource *res[];
>  };
>  
> +static struct memory_dev_type default_pmem_type  = {

Why is this named as default_pmem_type?  We will not change the memory
type of a node usually.

> +	.adistance = MEMTIER_ADISTANCE_PMEM,
> +	.tier_sibiling = LIST_HEAD_INIT(default_pmem_type.tier_sibiling),
> +	.nodes  = NODE_MASK_NONE,
> +};
> +
>  static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
>  {
>  	struct device *dev = &dev_dax->dev;
> @@ -62,6 +69,8 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
>  		return -EINVAL;
>  	}
>  
> +	init_node_memory_type(numa_node, &default_pmem_type);
> +

The memory hot-add below may fail.  So the error handling needs to be
added.

And, it appears that the memory type and memory tier of a node may be
fully initialized here before NUMA hot-adding started.  So I suggest to
set node_memory_types[] here only.  And set memory_dev_type->nodes in
node hot-add callback.  I think there is the proper place to complete
the initialization.

And, in theory dax/kmem.c can be unloaded.  So we need to clear
node_memory_types[] for nodes somewhere.

Best Regards,
Huang, Ying

>  	for (i = 0; i < dev_dax->nr_range; i++) {
>  		struct range range;
>  
> diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
> index 976f43a5e3be..4f4baf0bf430 100644
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
> @@ -15,12 +17,27 @@
>  #define MEMTIER_ADISTANCE_PMEM	(1 << MEMTIER_CHUNK_BITS)
>  #define MEMTIER_HOTPLUG_PRIO	100
>  
> +struct memory_tier;
> +struct memory_dev_type {
> +	/* list of memory types that are are part of same tier as this type */
> +	struct list_head tier_sibiling;
> +	/* abstract distance for this specific memory type */
> +	int adistance;
> +	/* Nodes of same abstract distance */
> +	nodemask_t nodes;
> +	struct memory_tier *memtier;
> +};
> +
>  #ifdef CONFIG_NUMA
> -#include <linux/types.h>
>  extern bool numa_demotion_enabled;
> +struct memory_dev_type *init_node_memory_type(int node, struct memory_dev_type *default_type);
>  
>  #else
>  
>  #define numa_demotion_enabled	false
> +static inline struct memory_dev_type *init_node_memory_type(int node, struct memory_dev_type *default_type)
> +{
> +	return ERR_PTR(-EINVAL);
> +}
>  #endif	/* CONFIG_NUMA */
>  #endif  /* _LINUX_MEMORY_TIERS_H */
> diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
> index c9854a394d9b..109be75fa554 100644
> --- a/mm/memory-tiers.c
> +++ b/mm/memory-tiers.c
> @@ -1,6 +1,4 @@
>  // SPDX-License-Identifier: GPL-2.0
> -#include <linux/types.h>
> -#include <linux/nodemask.h>
>  #include <linux/slab.h>
>  #include <linux/lockdep.h>
>  #include <linux/memory.h>
> @@ -19,16 +17,6 @@ struct memory_tier {
>  	int adistance_start;
>  };
>  
> -struct memory_dev_type {
> -	/* list of memory types that are are part of same tier as this type */
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
>  struct memory_dev_type *node_memory_types[MAX_NUMNODES];
> @@ -141,6 +129,22 @@ static void clear_node_memory_tier(int node)
>  	mutex_unlock(&memory_tier_lock);
>  }
>  
> +struct memory_dev_type *init_node_memory_type(int node, struct memory_dev_type *default_type)
> +{
> +	struct memory_dev_type *mem_type;
> +
> +	mutex_lock(&memory_tier_lock);
> +	if (node_memory_types[node]) {
> +		mem_type = node_memory_types[node];
> +	} else {
> +		node_memory_types[node] = default_type;
> +		node_set(node, default_type->nodes);
> +		mem_type = default_type;
> +	}
> +	mutex_unlock(&memory_tier_lock);
> +	return mem_type;
> +}
> +
>  static int __meminit memtier_hotplug_callback(struct notifier_block *self,
>  					      unsigned long action, void *_arg)
>  {
