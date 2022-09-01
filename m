Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F07915A8E28
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 08:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233309AbiIAGQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 02:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232744AbiIAGQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 02:16:25 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1068110B97E
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 23:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662012983; x=1693548983;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=yImlM/1OG2vrSOuvDpVrqiRnkRtOiJmPik+XMrb8h5M=;
  b=PsW2+BFcz6KDCUgH/g2q6uEctKM9kr06BI8lif0sqY1KkSFCeIVTYTqT
   4FJ4M3Gscj2JxqNhl8tSKxmnHz8knjqEW1RNTYcJnbXjS5KTwaPR+VXrh
   RZZ42BmpmKV9c7dNWw5vo4TtLl2m7xZf0TnNNvs2c7CAhgjfSq0Kfw34Z
   PUEqowXjF6AzJQUIk6xdcPmbf2lMO09pZVUocN/AfAYqgow/3EtbuYUA/
   vL7Du2jLCOtKGeNwKJ2G8HQRtBEj5r5bDk9OAbRz7oRiPBXjuFOQbpqzx
   16mSATlQylTtFCUKQ9l9R0gfuiW+5fwY+QPlyP32SIhlLolR03p5+ZL4u
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="359587720"
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="359587720"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 23:16:22 -0700
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="608431820"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 23:16:18 -0700
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
Subject: Re: [PATCH mm-unstable] mm/demotion: Assign correct memory type for
 multiple dax devices with the same node affinity
References: <20220826100224.542312-1-aneesh.kumar@linux.ibm.com>
Date:   Thu, 01 Sep 2022 14:15:31 +0800
In-Reply-To: <20220826100224.542312-1-aneesh.kumar@linux.ibm.com> (Aneesh
        Kumar K. V.'s message of "Fri, 26 Aug 2022 15:32:24 +0530")
Message-ID: <87a67j1uyk.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:

> With multiple dax devices having the same node affinity, the kernel wrongly assigned
> default_dram memory type to some devices after the memory hotplug operation. Fix this by
> not clearing node_memory_types on the dax device remove.

Sorry for late reply.

Just for confirmation.  There are multiple dax devices in one NUMA node?

If you can show the bug reproducing steps, that will make it even easier
to understand.

Best Regards,
Huang, Ying

> The current kernel cleared node_memory_type on successful removal of a dax device.
> But then we can have multiple dax devices with the same node affinity. Clearing the
> node_memory_type results in assigning other dax devices to the default dram type when
> we bring them online.
>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
>  mm/memory-tiers.c | 37 +++++++++++++++++++++++++++++--------
>  1 file changed, 29 insertions(+), 8 deletions(-)
>
> diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
> index ba844fe9cc8c..c4bd6d052a33 100644
> --- a/mm/memory-tiers.c
> +++ b/mm/memory-tiers.c
> @@ -27,9 +27,14 @@ struct demotion_nodes {
>  	nodemask_t preferred;
>  };
>  
> +struct node_memory_type_map {
> +	struct memory_dev_type *memtype;
> +	int map_count;
> +};
> +
>  static DEFINE_MUTEX(memory_tier_lock);
>  static LIST_HEAD(memory_tiers);
> -static struct memory_dev_type *node_memory_types[MAX_NUMNODES];
> +static struct node_memory_type_map node_memory_types[MAX_NUMNODES];
>  static struct memory_dev_type *default_dram_type;
>  #ifdef CONFIG_MIGRATION
>  static int top_tier_adistance;
> @@ -386,9 +391,19 @@ static inline void establish_demotion_targets(void) {}
>  
>  static inline void __init_node_memory_type(int node, struct memory_dev_type *memtype)
>  {
> -	if (!node_memory_types[node]) {
> -		node_memory_types[node] = memtype;
> -		kref_get(&memtype->kref);
> +	if (!node_memory_types[node].memtype)
> +		node_memory_types[node].memtype = memtype;
> +	/*
> +	 * for each device getting added in the same NUMA node
> +	 * with this specific memtype, bump the map count. We
> +	 * Only take memtype device reference once, so that
> +	 * changing a node memtype can be done by droping the
> +	 * only reference count taken here.
> +	 */
> +
> +	if (node_memory_types[node].memtype == memtype) {
> +		if (!node_memory_types[node].map_count++)
> +			kref_get(&memtype->kref);
>  	}
>  }
>  
> @@ -406,7 +421,7 @@ static struct memory_tier *set_node_memory_tier(int node)
>  
>  	__init_node_memory_type(node, default_dram_type);
>  
> -	memtype = node_memory_types[node];
> +	memtype = node_memory_types[node].memtype;
>  	node_set(node, memtype->nodes);
>  	memtier = find_create_memory_tier(memtype);
>  	if (!IS_ERR(memtier))
> @@ -448,7 +463,7 @@ static bool clear_node_memory_tier(int node)
>  
>  		rcu_assign_pointer(pgdat->memtier, NULL);
>  		synchronize_rcu();
> -		memtype = node_memory_types[node];
> +		memtype = node_memory_types[node].memtype;
>  		node_clear(node, memtype->nodes);
>  		if (nodes_empty(memtype->nodes)) {
>  			list_del_init(&memtype->tier_sibiling);
> @@ -502,8 +517,14 @@ EXPORT_SYMBOL_GPL(init_node_memory_type);
>  void clear_node_memory_type(int node, struct memory_dev_type *memtype)
>  {
>  	mutex_lock(&memory_tier_lock);
> -	if (node_memory_types[node] == memtype) {
> -		node_memory_types[node] = NULL;
> +	if (node_memory_types[node].memtype == memtype)
> +		node_memory_types[node].map_count--;
> +	/*
> +	 * If we umapped all the attached devices to this node,
> +	 * clear the node memory type.
> +	 */
> +	if (!node_memory_types[node].map_count) {
> +		node_memory_types[node].memtype = NULL;
>  		kref_put(&memtype->kref, release_memtype);
>  	}
>  	mutex_unlock(&memory_tier_lock);
