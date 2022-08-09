Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79E1B58D23C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 05:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232206AbiHIDH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 23:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiHIDH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 23:07:26 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE851FD35
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 20:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660014444; x=1691550444;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=UbJ/HBFckkQ6tZf+/b1u3HTfo3CBwfQHw0C3q+PeE2c=;
  b=GLTacdamVWn1kXpFfaQPyFWfVeD0ushjTikG2uV8BdDVcvaCesQj689g
   +TxCDALJZrZ86V+JI0nPo8rxiMD9tJgeOsd5xCMjP/scCFjVk/cBxqi/8
   +8groKUdXXGKrlzb6+egRghxEHq58HUTZW/KGma2z0I8cv6qDvpNGS1Ya
   P1TuX0U6NC5/NqXQR4XP80Xnkjs6tAM9RN65zSaQEH5XRmE8xFRHuw9C5
   NjaOJGfLUR64yHAIVMirfm62hgy35xrK62meCUcPYtNapIH9RTl3yhfck
   l6syPZBVsqudzTUv/ZzGVnLEkGrFvBKk37fXIrmvxrbFXcc9z9L3oszVn
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10433"; a="289497895"
X-IronPort-AV: E=Sophos;i="5.93,223,1654585200"; 
   d="scan'208";a="289497895"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 20:07:24 -0700
X-IronPort-AV: E=Sophos;i="5.93,223,1654585200"; 
   d="scan'208";a="637554673"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 20:07:20 -0700
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
Subject: Re: [PATCH v13 6/9] mm/demotion: Add pg_data_t member to track node
 memory tier details
References: <20220808062601.836025-1-aneesh.kumar@linux.ibm.com>
        <20220808062601.836025-7-aneesh.kumar@linux.ibm.com>
Date:   Tue, 09 Aug 2022 11:07:17 +0800
In-Reply-To: <20220808062601.836025-7-aneesh.kumar@linux.ibm.com> (Aneesh
        Kumar K. V.'s message of "Mon, 8 Aug 2022 11:55:58 +0530")
Message-ID: <87k07iglne.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:

> Also update different helpes to use NODE_DATA()->memtier. Since
> node specific memtier can change based on the reassignment of
> NUMA node to a different memory tiers, accessing NODE_DATA()->memtier
> needs to happen under an rcu read lock or memory_tier_lock.
>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
>  include/linux/mmzone.h |  3 +++
>  mm/memory-tiers.c      | 38 ++++++++++++++++++++++++++++++++------
>  2 files changed, 35 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index aab70355d64f..353812495a70 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -928,6 +928,9 @@ typedef struct pglist_data {
>  	/* Per-node vmstats */
>  	struct per_cpu_nodestat __percpu *per_cpu_nodestats;
>  	atomic_long_t		vm_stat[NR_VM_NODE_STAT_ITEMS];
> +#ifdef CONFIG_NUMA
> +	struct memory_tier __rcu *memtier;
> +#endif
>  } pg_data_t;
>  
>  #define node_present_pages(nid)	(NODE_DATA(nid)->node_present_pages)
> diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
> index 02e514e87d5c..3778ac6a44a1 100644
> --- a/mm/memory-tiers.c
> +++ b/mm/memory-tiers.c
> @@ -5,6 +5,7 @@
>  #include <linux/kobject.h>
>  #include <linux/memory.h>
>  #include <linux/random.h>
> +#include <linux/mmzone.h>
>  #include <linux/memory-tiers.h>
>  
>  #include "internal.h"
> @@ -137,12 +138,18 @@ static struct memory_tier *find_create_memory_tier(struct memory_dev_type *memty
>  
>  static struct memory_tier *__node_get_memory_tier(int node)
>  {
> -	struct memory_dev_type *memtype;
> +	pg_data_t *pgdat;
>  
> -	memtype = node_memory_types[node];
> -	if (memtype && node_isset(node, memtype->nodes))
> -		return memtype->memtier;
> -	return NULL;
> +	pgdat = NODE_DATA(node);
> +	if (!pgdat)
> +		return NULL;
> +	/*
> +	 * Since we hold memory_tier_lock, we can avoid
> +	 * RCU read locks when accessing the details. No
> +	 * parallel updates are possible here.
> +	 */
> +	return rcu_dereference_check(pgdat->memtier,
> +				     lockdep_is_held(&memory_tier_lock));
>  }
>  
>  #ifdef CONFIG_MIGRATION
> @@ -295,6 +302,8 @@ static struct memory_tier *set_node_memory_tier(int node)
>  {
>  	struct memory_tier *memtier;
>  	struct memory_dev_type *memtype;
> +	pg_data_t *pgdat = NODE_DATA(node);
> +
>  
>  	lockdep_assert_held_once(&memory_tier_lock);
>  
> @@ -307,6 +316,8 @@ static struct memory_tier *set_node_memory_tier(int node)
>  	memtype = node_memory_types[node];
>  	node_set(node, memtype->nodes);
>  	memtier = find_create_memory_tier(memtype);
> +	if (!IS_ERR(memtier))
> +		rcu_assign_pointer(pgdat->memtier, memtier);
>  	return memtier;
>  }
>  
> @@ -319,12 +330,25 @@ static void destroy_memory_tier(struct memory_tier *memtier)
>  static bool clear_node_memory_tier(int node)
>  {
>  	bool cleared = false;
> +	pg_data_t *pgdat;
>  	struct memory_tier *memtier;
>  
> +	pgdat = NODE_DATA(node);
> +	if (!pgdat)
> +		return false;
> +
> +	/*
> +	 * Make sure that anybody looking at NODE_DATA who finds
> +	 * a valid memtier finds memory_dev_types with nodes still
> +	 * linked to the memtier. We achieve this by waiting for
> +	 * rcu read section to finish using synchronize_rcu.
> +	 */

The synchronize_rcu() is also needed because we may free the memory
tier.

Best Regards,
Huang, Ying

>  	memtier = __node_get_memory_tier(node);
>  	if (memtier) {
>  		struct memory_dev_type *memtype;
>  
> +		rcu_assign_pointer(pgdat->memtier, NULL);
> +		synchronize_rcu();
>  		memtype = node_memory_types[node];
>  		node_clear(node, memtype->nodes);
>  		if (nodes_empty(memtype->nodes)) {
> @@ -422,8 +446,10 @@ static int __init memory_tier_init(void)
>  		panic("%s() failed to register memory tier: %ld\n",
>  		      __func__, PTR_ERR(memtier));
>  
> -	for_each_node_state(node, N_MEMORY)
> +	for_each_node_state(node, N_MEMORY) {
>  		__init_node_memory_type(node, default_dram_type);
> +		rcu_assign_pointer(NODE_DATA(node)->memtier, memtier);
> +	}
>  
>  	mutex_unlock(&memory_tier_lock);
>  #ifdef CONFIG_MIGRATION
