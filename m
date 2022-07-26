Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B619580E67
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 10:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238349AbiGZICx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 04:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238245AbiGZICm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 04:02:42 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D95E2C654
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 01:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658822561; x=1690358561;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=CUZxTvCqlorgPopyQrREkP5nuwha/hRCiZS4ejKQGYk=;
  b=oGqx0ZKQEpNpAVJ966LQ8PmWhm75+fchc6gHzplOtxz1t7jcnIh18wLn
   YS915w0Qq5MsxWMHBS44G9ggpXBwklH3FI6p3M4kisTJK2iSsK37F+BW0
   2no+0rIA+7zzXn3fApNr/8HeFJD5CgZ0FYDuuG3jw99U3edx3izJapFgo
   BENubgpxQH7sZWxq+AqPB9UvfZrIfCOsKKAzvtudSBvFSg8fAEinGbmVD
   uA0Q8uVxQhftvBURU+Bj5ckj2mDJ6YyiT19GxQOGCZkndNtylW/c0RlwJ
   8x7sC7HKKFtqPoTMyDMXEUf1UjVAQ0JqaZPeljtzFRQewpaCApLwAKsLw
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10419"; a="274757297"
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="274757297"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2022 01:02:40 -0700
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="575389671"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.94])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2022 01:02:36 -0700
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
Subject: Re: [PATCH v10 6/8] mm/demotion: Add pg_data_t member to track node
 memory tier details
References: <20220720025920.1373558-1-aneesh.kumar@linux.ibm.com>
        <20220720025920.1373558-7-aneesh.kumar@linux.ibm.com>
Date:   Tue, 26 Jul 2022 16:02:33 +0800
In-Reply-To: <20220720025920.1373558-7-aneesh.kumar@linux.ibm.com> (Aneesh
        Kumar K. V.'s message of "Wed, 20 Jul 2022 08:29:18 +0530")
Message-ID: <87wnc0uwrq.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:

> Also update different helpes to use NODE_DATA()->memtier. Since
> node specific memtier can change based on the reassignment of
> NUMA node to a different memory tiers, accessing NODE_DATA()->memtier
> needs to happen under an rcu read lock or memory_tier_lock.
>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
>  include/linux/mmzone.h |  3 ++
>  mm/memory-tiers.c      | 65 +++++++++++++++++++++++++++++++++++-------
>  2 files changed, 57 insertions(+), 11 deletions(-)
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
> index a8cfe2ca3903..4715f9b96a44 100644
> --- a/mm/memory-tiers.c
> +++ b/mm/memory-tiers.c
> @@ -138,13 +138,18 @@ static struct memory_tier *find_create_memory_tier(unsigned int perf_level)
>  
>  static struct memory_tier *__node_get_memory_tier(int node)
>  {
> -	struct memory_tier *memtier;
> +	pg_data_t *pgdat;
>  
> -	list_for_each_entry(memtier, &memory_tiers, list) {
> -		if (node_isset(node, memtier->nodelist))
> -			return memtier;
> -	}
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
> @@ -277,6 +282,29 @@ static inline void disable_all_migrate_targets(void) {}
>  static inline void establish_migration_targets(void) {}
>  #endif /* CONFIG_MIGRATION */
>  
> +static void memtier_node_set(int node, struct memory_tier *memtier)
> +{
> +	pg_data_t *pgdat;
> +	struct memory_tier *current_memtier;
> +
> +	pgdat = NODE_DATA(node);
> +	if (!pgdat)
> +		return;
> +	/*
> +	 * Make sure we mark the memtier NULL before we assign the new memory tier
> +	 * to the NUMA node. This make sure that anybody looking at NODE_DATA
> +	 * finds a NULL memtier or the one which is still valid.
> +	 */
> +	current_memtier = rcu_dereference_check(pgdat->memtier,
> +						lockdep_is_held(&memory_tier_lock));
> +	rcu_assign_pointer(pgdat->memtier, NULL);
> +	synchronize_rcu();
> +	if (current_memtier)
> +		node_clear(node, current_memtier->nodelist);

If pgdat->memtier == NULL, we don't need to set it to NULL and call
synchronize_rcu().  That is,

+	current_memtier = rcu_dereference_check(pgdat->memtier,
+						lockdep_is_held(&memory_tier_lock));
+	if (current_memtier) {
+               rcu_assign_pointer(pgdat->memtier, NULL);
+               synchronize_rcu();
+		node_clear(node, current_memtier->nodelist);
+       }

Same for clear_node_memory_tier().

Best Regards,
Huang, Ying

> +	node_set(node, memtier->nodelist);
> +	rcu_assign_pointer(pgdat->memtier, memtier);
> +}
> +
>  static void init_node_memory_tier(int node)
>  {
>  	int perf_level;
> @@ -295,7 +323,7 @@ static void init_node_memory_tier(int node)
>  	if (!memtier) {
>  		perf_level = node_devices[node]->perf_level;
>  		memtier = find_create_memory_tier(perf_level);
> -		node_set(node, memtier->nodelist);
> +		memtier_node_set(node, memtier);
>  	}
>  	establish_migration_targets();
>  	mutex_unlock(&memory_tier_lock);
> @@ -303,12 +331,25 @@ static void init_node_memory_tier(int node)
>  
>  static void clear_node_memory_tier(int node)
>  {
> -	struct memory_tier *memtier;
> +	pg_data_t *pgdat;
> +	struct memory_tier *current_memtier;
> +
> +	pgdat = NODE_DATA(node);
> +	if (!pgdat)
> +		return;
>  
>  	mutex_lock(&memory_tier_lock);
> -	memtier = __node_get_memory_tier(node);
> -	if (memtier) {
> -		node_clear(node, memtier->nodelist);
> +	/*
> +	 * Make sure we mark the memtier NULL before we assign the new memory tier
> +	 * to the NUMA node. This make sure that anybody looking at NODE_DATA
> +	 * finds a NULL memtier or the one which is still valid.
> +	 */
> +	current_memtier = rcu_dereference_check(pgdat->memtier,
> +						lockdep_is_held(&memory_tier_lock));
> +	rcu_assign_pointer(pgdat->memtier, NULL);
> +	synchronize_rcu();
> +	if (current_memtier) {
> +		node_clear(node, current_memtier->nodelist);
>  		establish_migration_targets();
>  	}
>  	mutex_unlock(&memory_tier_lock);
> @@ -383,6 +424,8 @@ static int __init memory_tier_init(void)
>  
>  		if (!node_property->perf_level)
>  			node_property->perf_level = default_memtier_perf_level;
> +
> +		rcu_assign_pointer(NODE_DATA(node)->memtier, memtier);
>  	}
>  	mutex_unlock(&memory_tier_lock);
