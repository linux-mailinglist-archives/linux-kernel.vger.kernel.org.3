Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F72A545C12
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 08:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346396AbiFJGEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 02:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245377AbiFJGEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 02:04:36 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E67146776
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 23:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654841074; x=1686377074;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R+DSh2EEu94BxaaMFthJVuW4/txPO8GfM9ooK/W62F0=;
  b=cMpWjx/9XR9aMBB7BZKaprv66Dg0AElMmnMQcCRUvFBtQvhBAKxZIeRg
   wc8aN9rLzUzh9UY4f1h0J3hpj76nUzSA4jSMqpRTRgAVoEha/cg7D3Soj
   8CE3qCi+mHdCR3m44VQMrwXGYhYgMNcF5GxY9SRHEqxtQk4e8T2W5zEDR
   mwlilmXSTwhcYSZ/RjO1gVVIIfgkW+pwO5rAglwWlRhfRuGx+jXss7o/1
   ExPDOOFcfSOTkoCHSYFh0YVombUhwx/+qpTwxgsSI8G6lNm3KMQ0bMboQ
   hde9XLOjBVD9jq0pHP2ranx0Hbf9K/njx2Bl+ddZ8BHyiBNhIXF2SgBtW
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="257358855"
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="257358855"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 23:04:34 -0700
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="828061405"
Received: from qingfen1-mobl1.ccr.corp.intel.com ([10.254.215.73])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 23:04:29 -0700
Message-ID: <9f05470b3188c2a81696841a3a3e007e99caecea.camel@intel.com>
Subject: Re: [PATCH v5 9/9] mm/demotion: Update node_is_toptier to work with
 memory tiers
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
Date:   Fri, 10 Jun 2022 14:04:26 +0800
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
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-06-08 at 20:07 +0530, Aneesh Kumar K.V wrote:
> Ying Huang <ying.huang@intel.com> writes:
> 
> ....
> 
> > > > 
> > > > > is this good (not tested)?
> > > > > /*
> > > > >    * build the allowed promotion mask. Promotion is allowed
> > > > >    * from higher memory tier to lower memory tier only if
> > > > >    * lower memory tier doesn't include compute. We want to
> > > > >    * skip promotion from a memory tier, if any node which is
> > > > >    * part of that memory tier have CPUs. Once we detect such
> > > > >    * a memory tier, we consider that tier as top tier from
> > > > >    * which promotion is not allowed.
> > > > >    */
> > > > > list_for_each_entry_reverse(memtier, &memory_tiers, list) {
> > > > > 	nodes_and(allowed, node_state[N_CPU], memtier->nodelist);
> > > > > 	if (nodes_empty(allowed))
> > > > > 		nodes_or(promotion_mask, promotion_mask, allowed);
> > > > > 	else
> > > > > 		break;
> > > > > }
> > > > > 
> > > > > and then
> > > > > 
> > > > > static inline bool node_is_toptier(int node)
> > > > > {
> > > > > 
> > > > > 	return !node_isset(node, promotion_mask);
> > > > > }
> > > > > 
> > > > 
> > > > This should work.  But it appears unnatural.  So, I don't think we
> > > > should avoid to add more and more node masks to mitigate the design
> > > > decision that we cannot access memory tier information directly.  All
> > > > these becomes simple and natural, if we can access memory tier
> > > > information directly.
> > > > 
> > > 
> > > how do you derive whether node is toptier details if we have memtier 
> > > details in pgdat?
> > 
> > pgdat -> memory tier -> rank
> > 
> > Then we can compare this rank with the fast memory rank.  The fast
> > memory rank can be calculated dynamically at appropriate places.
> 
> This is what I am testing now. We still need to closely audit that lock
> free access to the NODE_DATA()->memtier. For v6 I will keep this as a
> separate patch and once we all agree that it is safe, I will fold it
> back.

Thanks for doing this.  We finally have a way to access memory_tier in
hot path.

[snip]

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
> 
> +	rcu_assign_pointer(pgdat->memtier, NULL);
> +	synchronize_rcu();

Per my understanding, in your code, when we change pgdat->memtier, we
will call synchronize_rcu() twice.  IMHO, once should be OK.  That is,
something like below,

	rcu_assign_pointer(pgdat->memtier, NULL);
	node_clear(node, memtier->nodelist);
	synchronize_rcu();
	node_set(node, new_memtier->nodelist);
	rcu_assign_pointer(pgdat->memtier, new_memtier);

In this way, there will be 3 states,

1. prev

pgdat->memtier == old_memtier
node_isset(node, old_memtier->node_list)
!node_isset(node, new_memtier->node_list)

2. transitioning

pgdat->memtier == NULL
!node_isset(node, old_memtier->node_list)
!node_isset(node, new_memtier->node_list)

3. after

pgdat->memtier == new_memtier
!node_isset(node, old_memtier->node_list)
node_isset(node, new_memtier->node_list)

The real state may be one of 1, 2, 3, 1+2, or 2+3.  But it will not be
1+3.  I think that this satisfied our requirements.

[snip]

>  static int __node_create_and_set_memory_tier(int node, int tier)
>  {
>  	int ret = 0;
> @@ -253,7 +318,7 @@ static int __node_create_and_set_memory_tier(int node, int tier)
>  			goto out;
>  		}
>  	}
> -	node_set(node, memtier->nodelist);
> +	memtier_node_set(node, memtier);
>  out:
>  	return ret;
>  }
> @@ -275,12 +340,12 @@ int node_create_and_set_memory_tier(int node, int tier)
>  	if (current_tier->dev.id == tier)
>  		goto out;
> -	node_clear(node, current_tier->nodelist);
> +	memtier_node_clear(node, current_tier);+	node_set(node, memtier->nodelist);
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
> 
>   	ret = __node_create_and_set_memory_tier(node, tier);
> 
>  	if (ret) {
>  		/* reset it back to older tier */
> -		node_set(node, current_tier->nodelist);
> +		memtier_node_set(node, current_tier);
>  		goto out;
>  	}
>  
> 

[snip]

>  static int __init memory_tier_init(void)
>  {
> -	int ret;
> +	int ret, node;
>  	struct memory_tier *memtier;
>
>  	ret = subsys_system_register(&memory_tier_subsys, memory_tier_attr_groups);
> 
> @@ -766,7 +829,13 @@ static int __init memory_tier_init(void)
> 
>  		panic("%s() failed to register memory tier: %d\n", __func__, ret);
>
>  	/* CPU only nodes are not part of memory tiers. */
> 
> -	memtier->nodelist = node_states[N_MEMORY];
> +	for_each_node_state(node, N_MEMORY) {
> +		/*
> +		 * Should be safe to do this early in the boot.
> +		 */
> +		NODE_DATA(node)->memtier = memtier;

No required absoluately.  But IMHO it's more consistent to use
rcu_assign_pointer() here.

> +		node_set(node, memtier->nodelist);
> +	}
>  	migrate_on_reclaim_init();
>  
> > 	return 0;

Best Regareds,
Huang, Ying


