Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80F7B54800A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 09:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237938AbiFMG7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 02:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237424AbiFMG7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 02:59:21 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58E816582
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 23:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655103560; x=1686639560;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=j3eWTQk7h2QMpwvrlWqr83AalhCYxmBrbOjJyKycaFI=;
  b=jiOvPTSb+4GKPygiyshSGwBuYHDwWNg0O3aCDQbzAAqmZxbuf0yHk5bD
   i2ZD9zENICFksu5fFF2iom74EQwVlPbitOE/TPKHzAErDBYYu/JerTUDQ
   /NS5kudxPtyXh4K44r0473H4xKZjxy2yZ+2Vd02/fxZLdHHXzxwhphIUl
   OYToqS7hc/fYrhBSL+ux+11BLuz1d0eRHPIp7/lt+frIDBrxViRg0a296
   fL6KVe2FhoT9EgguaYIWs02QaIXMse66Or/0OEfPx29aRN0imzQru3auU
   l20VxBdBBU9lxn0p7enSGmR7MoPGgdO9hoHjRFb4E+Vpg9zsRmceFbCLz
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10376"; a="258629725"
X-IronPort-AV: E=Sophos;i="5.91,296,1647327600"; 
   d="scan'208";a="258629725"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2022 23:59:20 -0700
X-IronPort-AV: E=Sophos;i="5.91,296,1647327600"; 
   d="scan'208";a="639563620"
Received: from xinyangc-mobl.ccr.corp.intel.com ([10.254.214.65])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2022 23:59:15 -0700
Message-ID: <193ad45f2ec47ac157a812975f3e4235fcbc061a.camel@intel.com>
Subject: Re: [PATCH v6 04/13] mm/demotion/dax/kmem: Set node's memory tier
 to MEMORY_TIER_PMEM
From:   Ying Huang <ying.huang@intel.com>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linux-mm@kvack.org, akpm@linux-foundation.org
Cc:     Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim C Chen <tim.c.chen@intel.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        David Rientjes <rientjes@google.com>
Date:   Mon, 13 Jun 2022 14:59:12 +0800
In-Reply-To: <20220610135229.182859-5-aneesh.kumar@linux.ibm.com>
References: <20220610135229.182859-1-aneesh.kumar@linux.ibm.com>
         <20220610135229.182859-5-aneesh.kumar@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-06-10 at 19:22 +0530, Aneesh Kumar K.V wrote:
> By default, all nodes are assigned to DEFAULT_MEMORY_TIER which
> is the memory tier designated for nodes with DRAM
> 
> Set dax kmem device node's tier to MEMORY_TIER_PMEM. MEMORY_TIER_PMEM
> is assigned a default rank value of 100 and appears below DEFAULT_MEMORY_TIER
> in demotion order.
> 
> Signed-off-by: Jagdish Gediya <jvgediya@linux.ibm.com>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
>  drivers/dax/kmem.c           |  4 ++
>  include/linux/memory-tiers.h |  1 +
>  mm/memory-tiers.c            | 78 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 83 insertions(+)
> 
> diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
> index a37622060fff..0cb3de3d138f 100644
> --- a/drivers/dax/kmem.c
> +++ b/drivers/dax/kmem.c
> @@ -11,6 +11,7 @@
>  #include <linux/fs.h>
>  #include <linux/mm.h>
>  #include <linux/mman.h>
> +#include <linux/memory-tiers.h>
>  #include "dax-private.h"
>  #include "bus.h"
>  
> 
> @@ -147,6 +148,9 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
>  
> 
>  	dev_set_drvdata(dev, data);
>  
> 
> +#ifdef CONFIG_TIERED_MEMORY
> +	node_create_and_set_memory_tier(numa_node, MEMORY_TIER_PMEM);
> +#endif
>  	return 0;
>  
> 
>  err_request_mem:
> diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
> index 44c3c3b16a36..e102ec73ab80 100644
> --- a/include/linux/memory-tiers.h
> +++ b/include/linux/memory-tiers.h
> @@ -18,6 +18,7 @@
>  #define MAX_MEMORY_TIERS  3
>  
> 
>  extern bool numa_demotion_enabled;
> +int node_create_and_set_memory_tier(int node, int tier);
>  #else
>  #define numa_demotion_enabled	false
>  
> 
> diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
> index c3123a457d90..00d393a5a628 100644
> --- a/mm/memory-tiers.c
> +++ b/mm/memory-tiers.c
> @@ -67,6 +67,84 @@ static struct memory_tier *register_memory_tier(unsigned int tier,
>  	return memtier;
>  }
>  
> 
> +static struct memory_tier *__node_get_memory_tier(int node)
> +{
> +	struct memory_tier *memtier;
> +
> +	list_for_each_entry(memtier, &memory_tiers, list) {
> +		if (node_isset(node, memtier->nodelist))
> +			return memtier;
> +	}
> +	return NULL;
> +}
> +

I suggest to add NODE_DATA(nid)->mem_tier before this patch.  That is,
part of [9/13].  That will make code much simpler and easier to
review.

And, in addition to dax_kmem, whenever a normal node is onlined, we
need to add it to the default memory tier.  I found this is done in
[5/13].  IMHO, we should move that part before this patch.

Best Regards,
Huang, Ying

> +static struct memory_tier *__get_memory_tier_from_id(int id)
> +{
> +	struct memory_tier *memtier;
> +
> +	list_for_each_entry(memtier, &memory_tiers, list) {
> +		if (memtier->id == id)
> +			return memtier;
> +	}
> +	return NULL;
> +}
> +
> +static int __node_create_and_set_memory_tier(int node, int tier)
> +{
> +	int ret = 0;
> +	struct memory_tier *memtier;
> +
> +	memtier = __get_memory_tier_from_id(tier);
> +	if (!memtier) {
> +		int rank;
> +
> +		rank = get_rank_from_tier(tier);
> +		if (rank == -1) {
> +			ret = -EINVAL;
> +			goto out;
> +		}
> +		memtier = register_memory_tier(tier, rank);
> +		if (!memtier) {
> +			ret = -EINVAL;
> +			goto out;
> +		}
> +	}
> +	node_set(node, memtier->nodelist);
> +out:
> +	return ret;
> +}
> +
> +int node_create_and_set_memory_tier(int node, int tier)
> +{
> +	struct memory_tier *current_tier;
> +	int ret = 0;
> +
> +	mutex_lock(&memory_tier_lock);
> +
> +	current_tier = __node_get_memory_tier(node);
> +	if (!current_tier) {
> +		ret = __node_create_and_set_memory_tier(node, tier);
> +		goto out;
> +	}
> +
> +	if (current_tier->id == tier)
> +		goto out;
> +
> +	node_clear(node, current_tier->nodelist);
> +
> +	ret = __node_create_and_set_memory_tier(node, tier);
> +	if (ret) {
> +		/* reset it back to older tier */
> +		node_set(node, current_tier->nodelist);
> +		goto out;
> +	}
> +out:
> +	mutex_unlock(&memory_tier_lock);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(node_create_and_set_memory_tier);
> +
>  static int __init memory_tier_init(void)
>  {
>  	struct memory_tier *memtier;


