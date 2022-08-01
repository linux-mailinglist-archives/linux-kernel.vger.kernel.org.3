Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A915658621D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 03:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238686AbiHABEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 21:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231234AbiHABE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 21:04:28 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C3C61146C
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 18:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659315868; x=1690851868;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=MBsZNqKqs+B3csBGzjyuQ2OxAFygDzHNCmXM9erWVhI=;
  b=Qf2ObXLTuGbWJvPTcbs3Ifgiuzc1hvta6SAF0z+tPuwPwDDCjN0PoYEP
   vz7Wa/A6AY7p5BlAwQuM9TjhqgLmpgVhPwgU8nAX4D1j/IMDqXtk8Oj7L
   ExPy1+658bDqJXWvWNufrWvKZqE1KFmP7bbm9O3popeS4ThbLief3SJqO
   4Fzopt74FckhgrJ3Yk6uhzUYVXTM2vL8ik5uxQfqyAxJjLPWV1eHFQyhX
   VYgGJ99cdH7dGjz+LFVnFZMnGr4fJElvgh+yH/IWYk5Qi4sO+JN1naHfg
   pis5dilK4ZstedOVTTLgNXjzt4eA86jSm65OkjgDW5iUtptATQGiFeJwq
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10425"; a="289053326"
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="289053326"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2022 18:04:27 -0700
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="552346665"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2022 18:04:23 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
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
Subject: Re: [PATCH v11 8/8] mm/demotion: Update node_is_toptier to work
 with memory tiers
References: <20220728190436.858458-1-aneesh.kumar@linux.ibm.com>
        <20220728190436.858458-9-aneesh.kumar@linux.ibm.com>
        <87sfmkl8x0.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <9fa09da8-eff7-e39a-96b0-2bc51711f08f@linux.ibm.com>
        <e213cd43-e451-e837-b591-08e3400dd22e@linux.ibm.com>
Date:   Mon, 01 Aug 2022 09:04:08 +0800
In-Reply-To: <e213cd43-e451-e837-b591-08e3400dd22e@linux.ibm.com> (Aneesh
        Kumar K. V.'s message of "Fri, 29 Jul 2022 12:17:45 +0530")
Message-ID: <87o7x4lqpj.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> writes:

> On 7/29/22 12:11 PM, Aneesh Kumar K V wrote:
>> On 7/29/22 12:09 PM, Huang, Ying wrote:
>>> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
>>>
>>>> With memory tiers support we can have memory only NUMA nodes
>>>> in the top tier from which we want to avoid promotion tracking NUMA
>>>> faults. Update node_is_toptier to work with memory tiers.
>>>> All NUMA nodes are by default top tier nodes. With lower memory
>>>> tiers added we consider all memory tiers above a memory tier having
>>>> CPU NUMA nodes as a top memory tier
>>>>
>>>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>>>> ---
>>>>  include/linux/memory-tiers.h | 11 ++++++++++
>>>>  include/linux/node.h         |  5 -----
>>>>  mm/huge_memory.c             |  1 +
>>>>  mm/memory-tiers.c            | 42 ++++++++++++++++++++++++++++++++++++
>>>>  mm/migrate.c                 |  1 +
>>>>  mm/mprotect.c                |  1 +
>>>>  6 files changed, 56 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
>>>> index f8dbeda617a7..bc9fb9d39b2c 100644
>>>> --- a/include/linux/memory-tiers.h
>>>> +++ b/include/linux/memory-tiers.h
>>>> @@ -35,6 +35,7 @@ struct memory_dev_type *init_node_memory_type(int node, struct memory_dev_type *
>>>>  #ifdef CONFIG_MIGRATION
>>>>  int next_demotion_node(int node);
>>>>  void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets);
>>>> +bool node_is_toptier(int node);
>>>>  #else
>>>>  static inline int next_demotion_node(int node)
>>>>  {
>>>> @@ -45,6 +46,11 @@ static inline void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *target
>>>>  {
>>>>  	*targets = NODE_MASK_NONE;
>>>>  }
>>>> +
>>>> +static inline bool node_is_toptier(int node)
>>>> +{
>>>> +	return true;
>>>> +}
>>>>  #endif
>>>>  
>>>>  #else
>>>> @@ -64,5 +70,10 @@ static inline void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *target
>>>>  {
>>>>  	*targets = NODE_MASK_NONE;
>>>>  }
>>>> +
>>>> +static inline bool node_is_toptier(int node)
>>>> +{
>>>> +	return true;
>>>> +}
>>>>  #endif	/* CONFIG_NUMA */
>>>>  #endif  /* _LINUX_MEMORY_TIERS_H */
>>>> diff --git a/include/linux/node.h b/include/linux/node.h
>>>> index 40d641a8bfb0..9ec680dd607f 100644
>>>> --- a/include/linux/node.h
>>>> +++ b/include/linux/node.h
>>>> @@ -185,9 +185,4 @@ static inline void register_hugetlbfs_with_node(node_registration_func_t reg,
>>>>  
>>>>  #define to_node(device) container_of(device, struct node, dev)
>>>>  
>>>> -static inline bool node_is_toptier(int node)
>>>> -{
>>>> -	return node_state(node, N_CPU);
>>>> -}
>>>> -
>>>>  #endif /* _LINUX_NODE_H_ */
>>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>>> index 834f288b3769..8405662646e9 100644
>>>> --- a/mm/huge_memory.c
>>>> +++ b/mm/huge_memory.c
>>>> @@ -35,6 +35,7 @@
>>>>  #include <linux/numa.h>
>>>>  #include <linux/page_owner.h>
>>>>  #include <linux/sched/sysctl.h>
>>>> +#include <linux/memory-tiers.h>
>>>>  
>>>>  #include <asm/tlb.h>
>>>>  #include <asm/pgalloc.h>
>>>> diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
>>>> index 84e2be31a853..36d87dc422ab 100644
>>>> --- a/mm/memory-tiers.c
>>>> +++ b/mm/memory-tiers.c
>>>> @@ -30,6 +30,7 @@ static DEFINE_MUTEX(memory_tier_lock);
>>>>  static LIST_HEAD(memory_tiers);
>>>>  struct memory_dev_type *node_memory_types[MAX_NUMNODES];
>>>>  #ifdef CONFIG_MIGRATION
>>>> +static int top_tier_adistance;
>>>>  /*
>>>>   * node_demotion[] examples:
>>>>   *
>>>> @@ -159,6 +160,31 @@ static struct memory_tier *__node_get_memory_tier(int node)
>>>>  }
>>>>  
>>>>  #ifdef CONFIG_MIGRATION
>>>> +bool node_is_toptier(int node)
>>>> +{
>>>> +	bool toptier;
>>>> +	pg_data_t *pgdat;
>>>> +	struct memory_tier *memtier;
>>>> +
>>>> +	pgdat = NODE_DATA(node);
>>>> +	if (!pgdat)
>>>> +		return false;
>>>> +
>>>> +	rcu_read_lock();
>>>> +	memtier = rcu_dereference(pgdat->memtier);
>>>> +	if (!memtier) {
>>>> +		toptier = true;
>>>> +		goto out;
>>>> +	}
>>>> +	if (memtier->adistance_start >= top_tier_adistance)
>>>> +		toptier = true;
>>>> +	else
>>>> +		toptier = false;
>>>> +out:
>>>> +	rcu_read_unlock();
>>>> +	return toptier;
>>>> +}
>>>> +
>>>>  void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets)
>>>>  {
>>>>  	struct memory_tier *memtier;
>>>> @@ -315,6 +341,22 @@ static void establish_demotion_targets(void)
>>>>  			}
>>>>  		} while (1);
>>>>  	}
>>>> +	/*
>>>> +	 * Promotion is allowed from a memory tier to higher
>>>> +	 * memory tier only if the memory tier doesn't include
>>>> +	 * compute. We want to  skip promotion from a memory tier,
>>>> +	 * if any node that is  part of the memory tier have CPUs.
>>>> +	 * Once we detect such a memory tier, we consider that tier
>>>> +	 * as top tiper from which promotion on is not allowed.
>>>> +	 */
>>>> +	list_for_each_entry(memtier, &memory_tiers, list) {
>>>> +		tier_nodes = get_memtier_nodemask(memtier);
>>>> +		nodes_and(tier_nodes, node_states[N_CPU], tier_nodes);
>>>> +		if (!nodes_empty(tier_nodes)) {
>>>> +			top_tier_adistance = memtier->adistance_start;
>>>
>>> IMHO, this should be,
>>>
>>> 			top_tier_adistance = memtier->adistance_start + MEMTIER_CHUNK_SIZE;
>>>
>> 
>> Good catch. Will update. BTW i did send v12 version of the patchset already to the list. 
>> 
>>
>
> Checking this again, we consider a node top tier if the node's memtier abstract distance
> satisfy the below.  
>
> 	if (memtier->adistance_start <= top_tier_adistance)
> 		toptier = true;

I admit that this works correctly.  And I think that the following code
is even more correct conceptually.  If so, why not help the code reader
to understand it more easily?

        if (memtier->adistance_start + MEMTIER_CHUNK_SIZE <= top_tier_adistance)
                toptier = true;

Best Regards,
Huang, Ying

> With that we should be good with the current code. But I agree with you that top_tier_distance
> should cover the full range of the top memory tier.
>
> -aneesh
