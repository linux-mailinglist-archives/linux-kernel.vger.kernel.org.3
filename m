Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEE01543D7B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 22:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbiFHUV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 16:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiFHUVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 16:21:25 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A2ED47
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 13:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654719683; x=1686255683;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dLp0cUT1fUxwoqMLlx+zcnqvmgDGV98fyxDj54aIu5I=;
  b=glCHWxYf/lbUJQ3j4JQ1PiEMGAH525o59SK/ewwNReAez2igdnKK0wjn
   Gs/Zb4+uPw7W/pRDY9wUsDtzKpU0EkGRNnVdSeXdo/5oENayVOTVdLH5e
   rNbZ7Pb7iwSrqRFnRTJFyjExElKwZqfQNAGW2I6KYBQB5f3Y2wP7HgWo+
   8XNVpv0y7mDNoTQo+QReJQkYmrnpok0HHmuwx39K9BZJAvW9IByE+hzL5
   a7ZR3QwwEaZwkPHeGmivlfV/1KF+z3n+7AdUHdum59S4EM12ICLsXWrff
   TlYLShxQMDMDbA0dFhUjXI7ssrf//JVwW4E5Lm0qx2+kuECvUrvTKSqgD
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10372"; a="278201172"
X-IronPort-AV: E=Sophos;i="5.91,286,1647327600"; 
   d="scan'208";a="278201172"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 13:14:56 -0700
X-IronPort-AV: E=Sophos;i="5.91,286,1647327600"; 
   d="scan'208";a="533256642"
Received: from schen9-mobl.amr.corp.intel.com ([10.209.124.119])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 13:14:55 -0700
Message-ID: <0d8849467053cf48f5d7356de5f1e3e600a85b39.camel@linux.intel.com>
Subject: Re: [PATCH v5 9/9] mm/demotion: Update node_is_toptier to work with
 memory tiers
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Ying Huang <ying.huang@intel.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org
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
Date:   Wed, 08 Jun 2022 13:14:55 -0700
In-Reply-To: <87sfoffcfz.fsf@linux.ibm.com>
References: <20220603134237.131362-1-aneesh.kumar@linux.ibm.com>
         <20220603134237.131362-10-aneesh.kumar@linux.ibm.com>
         <6e94b7e2a6192e4cacba1db3676b5b5cf9b98eac.camel@intel.com>
         <f9a26536-05f6-5d12-5c61-cdd35ab33a40@linux.ibm.com>
         <11f94e0c50f17f4a6a2f974cb69a1ae72853e2be.camel@intel.com>
         <d2513be5-be87-2957-a0d4-1d99b9e83114@linux.ibm.com>
         <db0200f4467c072470d8ed7e272132bfeb146ac2.camel@intel.com>
         <232817e0-24fd-e022-6c92-c260f7f01f8a@linux.ibm.com>
         <cc9566421dedf10b5b7149d093992797540c31e2.camel@intel.com>
         <87sfoffcfz.fsf@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-06-08 at 20:07 +0530, Aneesh Kumar K.V wrote:
> 
> 
> This is what I am testing now. We still need to closely audit that lock
> free access to the NODE_DATA()->memtier. 

You're refering to this or something else?  This is a write so seems okay.

> +	for_each_node_state(node, N_MEMORY) {
> +		/*
> +		 * Should be safe to do this early in the boot.
> +		 */
> +		NODE_DATA(node)->memtier = memtier;
> +		node_set(node, memtier->nodelist);
> +	}
>  	migrate_on_reclaim_init();


> For v6 I will keep this as a
> separate patch and once we all agree that it is safe, I will fold it
> back.

Please update code that uses __node_get_memory_tier(node) to use
NODE_DATA(node)->memtier;

Otherwise the code looks okay at a first glance.

Tim

> 
> diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
> index a388a806b61a..3e733de1a8a0 100644
> --- a/include/linux/memory-tiers.h
> +++ b/include/linux/memory-tiers.h
> @@ -17,7 +17,6 @@
>  #define MAX_MEMORY_TIERS  (MAX_STATIC_MEMORY_TIERS + 2)
>  
>  extern bool numa_demotion_enabled;
> -extern nodemask_t promotion_mask;
>  int node_create_and_set_memory_tier(int node, int tier);
>  int next_demotion_node(int node);
>  int node_set_memory_tier(int node, int tier);
> @@ -25,15 +24,7 @@ int node_get_memory_tier_id(int node);
>  int node_reset_memory_tier(int node, int tier);
>  void node_remove_from_memory_tier(int node);
>  void node_get_allowed_targets(int node, nodemask_t *targets);
> -
> -/*
> - * By default all nodes are top tiper. As we create new memory tiers
> - * we below top tiers we add them to NON_TOP_TIER state.
> - */
> -static inline bool node_is_toptier(int node)
> -{
> -	return !node_isset(node, promotion_mask);
> -}
> +bool node_is_toptier(int node);
>  
>  #else
>  #define numa_demotion_enabled	false
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index aab70355d64f..c4fcfd2b9980 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -928,6 +928,9 @@ typedef struct pglist_data {
>  	/* Per-node vmstats */
>  	struct per_cpu_nodestat __percpu *per_cpu_nodestats;
>  	atomic_long_t		vm_stat[NR_VM_NODE_STAT_ITEMS];
> +#ifdef CONFIG_TIERED_MEMORY
> +	struct memory_tier *memtier;
> +#endif
>  } pg_data_t;
>  
>  #define node_present_pages(nid)	(NODE_DATA(nid)->node_present_pages)
> diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
> index 29a038bb38b0..31ef0fab5f19 100644
> --- a/mm/memory-tiers.c
> +++ b/mm/memory-tiers.c
> @@ -7,6 +7,7 @@
>  #include <linux/random.h>
>  #include <linux/memory.h>
>  #include <linux/idr.h>
> +#include <linux/rcupdate.h>
>  
>  #include "internal.h"
>  
> @@ -26,7 +27,7 @@ struct demotion_nodes {
>  static void establish_migration_targets(void);
>  static DEFINE_MUTEX(memory_tier_lock);
>  static LIST_HEAD(memory_tiers);
> -nodemask_t promotion_mask;
> +static int top_tier_rank;
>  /*
>   * node_demotion[] examples:
>   *
> @@ -135,7 +136,7 @@ static void memory_tier_device_release(struct device *dev)
>  	if (tier->dev.id >= MAX_STATIC_MEMORY_TIERS)
>  		ida_free(&memtier_dev_id, tier->dev.id);
>  
> -	kfree(tier);
> +	kfree_rcu(tier);
>  }
>  
>  /*
> @@ -233,6 +234,70 @@ static struct memory_tier *__get_memory_tier_from_id(int id)
>  	return NULL;
>  }
>  
> +/*
> + * Called with memory_tier_lock. Hence the device references cannot
> + * be dropped during this function.
> + */
> +static void memtier_node_clear(int node, struct memory_tier *memtier)
> +{
> +	pg_data_t *pgdat;
> +
> +	pgdat = NODE_DATA(node);
> +	if (!pgdat)
> +		return;
> +
> +	rcu_assign_pointer(pgdat->memtier, NULL);
> +	/*
> +	 * Make sure read side see the NULL value before we clear the node
> +	 * from the nodelist.
> +	 */
> +	synchronize_rcu();
> +	node_clear(node, memtier->nodelist);
> +}
> +
> +static void memtier_node_set(int node, struct memory_tier *memtier)
> +{
> +	pg_data_t *pgdat;
> +
> +	pgdat = NODE_DATA(node);
> +	if (!pgdat)
> +		return;
> +	/*
> +	 * Make sure we mark the memtier NULL before we assign the new memory tier
> +	 * to the NUMA node. This make sure that anybody looking at NODE_DATA
> +	 * finds a NULL memtier or the one which is still valid.
> +	 */
> +	rcu_assign_pointer(pgdat->memtier, NULL);
> +	synchronize_rcu();
> +	node_set(node, memtier->nodelist);
> +	rcu_assign_pointer(pgdat->memtier, memtier);
> +}
> +
> +bool node_is_toptier(int node)
> +{
> +	bool toptier;
> +	pg_data_t *pgdat;
> +	struct memory_tier *memtier;
> +
> +	pgdat = NODE_DATA(node);
> +	if (!pgdat)
> +		return false;
> +
> +	rcu_read_lock();
> +	memtier = rcu_dereference(pgdat->memtier);
> +	if (!memtier) {
> +		toptier = true;
> +		goto out;
> +	}
> +	if (memtier->rank >= top_tier_rank)
> +		toptier = true;
> +	else
> +		toptier = false;
> +out:
> +	rcu_read_unlock();
> +	return toptier;
> +}
> +
>  static int __node_create_and_set_memory_tier(int node, int tier)
>  {
>  	int ret = 0;
> @@ -253,7 +318,7 @@ static int __node_create_and_set_memory_tier(int node, int tier)
>  			goto out;
>  		}
>  	}
> -	node_set(node, memtier->nodelist);
> +	memtier_node_set(node, memtier);
>  out:
>  	return ret;
>  }
> @@ -275,12 +340,12 @@ int node_create_and_set_memory_tier(int node, int tier)
>  	if (current_tier->dev.id == tier)
>  		goto out;
>  
> -	node_clear(node, current_tier->nodelist);
> +	memtier_node_clear(node, current_tier);
>  
>  	ret = __node_create_and_set_memory_tier(node, tier);
>  	if (ret) {
>  		/* reset it back to older tier */
> -		node_set(node, current_tier->nodelist);
> +		memtier_node_set(node, current_tier);
>  		goto out;
>  	}
>  
> @@ -305,7 +370,7 @@ static int __node_set_memory_tier(int node, int tier)
>  		ret = -EINVAL;
>  		goto out;
>  	}
> -	node_set(node, memtier->nodelist);
> +	memtier_node_set(node, memtier);
>  out:
>  	return ret;
>  }
> @@ -374,12 +439,12 @@ int node_reset_memory_tier(int node, int tier)
>  	if (current_tier->dev.id == tier)
>  		goto out;
>  
> -	node_clear(node, current_tier->nodelist);
> +	memtier_node_clear(node, current_tier);
>  
>  	ret = __node_set_memory_tier(node, tier);
>  	if (ret) {
>  		/* reset it back to older tier */
> -		node_set(node, current_tier->nodelist);
> +		memtier_node_set(node, current_tier);
>  		goto out;
>  	}
>  
> @@ -407,7 +472,7 @@ void node_remove_from_memory_tier(int node)
>  	 * empty then unregister it to make it invisible
>  	 * in sysfs.
>  	 */
> -	node_clear(node, memtier->nodelist);
> +	memtier_node_clear(node, memtier);
>  	if (nodes_empty(memtier->nodelist))
>  		unregister_memory_tier(memtier);
>  
> @@ -570,15 +635,13 @@ static void establish_migration_targets(void)
>  	 * a memory tier, we consider that tier as top tiper from
>  	 * which promotion is not allowed.
>  	 */
> -	promotion_mask = NODE_MASK_NONE;
>  	list_for_each_entry_reverse(memtier, &memory_tiers, list) {
>  		nodes_and(allowed, node_states[N_CPU], memtier->nodelist);
> -		if (nodes_empty(allowed))
> -			nodes_or(promotion_mask, promotion_mask, memtier->nodelist);
> -		else
> +		if (!nodes_empty(allowed)) {
> +			top_tier_rank = memtier->rank;
>  			break;
> +		}
>  	}
> -
>  	pr_emerg("top tier rank is %d\n", top_tier_rank);
>  	allowed = NODE_MASK_NONE;
>  	/*
> @@ -748,7 +811,7 @@ static const struct attribute_group *memory_tier_attr_groups[] = {
>  
>  static int __init memory_tier_init(void)
>  {
> -	int ret;
> +	int ret, node;
>  	struct memory_tier *memtier;
>  
>  	ret = subsys_system_register(&memory_tier_subsys, memory_tier_attr_groups);
> @@ -766,7 +829,13 @@ static int __init memory_tier_init(void)
>  		panic("%s() failed to register memory tier: %d\n", __func__, ret);
>  
>  	/* CPU only nodes are not part of memory tiers. */
> -	memtier->nodelist = node_states[N_MEMORY];
> +	for_each_node_state(node, N_MEMORY) {
> +		/*
> +		 * Should be safe to do this early in the boot.
> +		 */
> +		NODE_DATA(node)->memtier = memtier;
> +		node_set(node, memtier->nodelist);
> +	}
>  	migrate_on_reclaim_init();
>  
>  	return 0;

