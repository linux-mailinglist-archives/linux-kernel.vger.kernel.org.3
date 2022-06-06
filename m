Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3E153E357
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 10:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbiFFIEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 04:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbiFFIEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 04:04:25 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB40A37BC4
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 01:04:23 -0700 (PDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25661T6D023479;
        Mon, 6 Jun 2022 08:03:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=ny+FAz6nuu2u/36qZ6chXDStrrwab12RaIs5HNX+xBY=;
 b=l1t6gduQR2kYhE6oy7w9o42VNjCpr28D2uTO5TyJOQVlW+nf0IV4bFf19ftZR1Mss111
 a0fLCXKfbijkZAlupnWVgQfprgZa7lZlN/OFX1FRv7otgF3oPNbqytrK3Bxe0g2IxNEb
 HZQi8n58SzIUM9j7deFiSgmGnLUWhcrohkcG8AKr1W590JKWMtl44pqOIXyvl6l7Otad
 uqjAJ3s97tVCBWLl7+AQiIrmd7uEQL/NWpp8qxiYIyb+Sl0KupkLhQpjk92QqKukjn2P
 GRCIlLrxbmKduLleLucSro7PSlh0j31iRGQaXrTZBxcDRsGMQKRddAWwabXpnxvjrKhP Sw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3gg206v00g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Jun 2022 08:03:11 +0000
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25676UeA022879;
        Mon, 6 Jun 2022 08:03:11 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3gg206v002-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Jun 2022 08:03:11 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2567oVZF018205;
        Mon, 6 Jun 2022 08:03:09 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03fra.de.ibm.com with ESMTP id 3gfy18skup-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Jun 2022 08:03:08 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2568366620119824
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Jun 2022 08:03:06 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AC8FCA4051;
        Mon,  6 Jun 2022 08:03:06 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 49A78A4040;
        Mon,  6 Jun 2022 08:03:00 +0000 (GMT)
Received: from [9.43.87.254] (unknown [9.43.87.254])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  6 Jun 2022 08:03:00 +0000 (GMT)
Message-ID: <3d361a74-c333-da7f-9578-8774f6943d32@linux.ibm.com>
Date:   Mon, 6 Jun 2022 13:32:59 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [RFC PATCH v4 7/7] mm/demotion: Demote pages according to
 allocation fallback order
Content-Language: en-US
To:     Ying Huang <ying.huang@intel.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org
Cc:     Greg Thelen <gthelen@google.com>, Yang Shi <shy828301@gmail.com>,
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
References: <CAAPL-u-dFp7PwPH6DfbYdnY8xaGsHz3tRQ0CPGVkiqURvdN8=A@mail.gmail.com>
 <20220527122528.129445-1-aneesh.kumar@linux.ibm.com>
 <20220527122528.129445-8-aneesh.kumar@linux.ibm.com>
 <b102d5773bffd6391283773044f756e810c1f044.camel@intel.com>
 <046c373a-f30b-091d-47a1-e28bfb7e9394@linux.ibm.com>
 <9f6e60cc8be3cbde4871458c612c5c31d2a9e056.camel@intel.com>
 <a7d3829e-8bc5-d7a8-5e9e-a7943bb50740@linux.ibm.com>
 <65919df6b3302741780ff6fa69e497af06a9825e.camel@intel.com>
 <87leua8g7s.fsf@linux.ibm.com>
 <ab0178ad5e998907df763bd2678144eb817371d8.camel@intel.com>
From:   Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
In-Reply-To: <ab0178ad5e998907df763bd2678144eb817371d8.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: JJiEbAqACGyL-61FJCXTIpM7KxHbi7VV
X-Proofpoint-GUID: EvxQPpMSP99g8Dns8tIF-_kDK75ZKxG5
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-06_02,2022-06-03_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 suspectscore=0 impostorscore=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206060037
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/6/22 1:12 PM, Ying Huang wrote:
> On Mon, 2022-06-06 at 11:51 +0530, Aneesh Kumar K.V wrote:
>> Ying Huang <ying.huang@intel.com> writes:
>>
>> .....
>>
>>>>>>
>>>>>>> https://lore.kernel.org/lkml/69f2d063a15f8c4afb4688af7b7890f32af55391.camel@intel.com/
>>>>>>>
>>>>>>> That is, something like below,
>>>>>>>
>>>>>>> static struct page *alloc_demote_page(struct page *page, unsigned long node)
>>>>>>> {
>>>>>>> 	struct page *page;
>>>>>>> 	nodemask_t allowed_mask;
>>>>>>> 	struct migration_target_control mtc = {
>>>>>>> 		/*
>>>>>>> 		 * Allocate from 'node', or fail quickly and quietly.
>>>>>>> 		 * When this happens, 'page' will likely just be discarded
>>>>>>> 		 * instead of migrated.
>>>>>>> 		 */
>>>>>>> 		.gfp_mask = (GFP_HIGHUSER_MOVABLE & ~__GFP_RECLAIM) |
>>>>>>> 			    __GFP_THISNODE  | __GFP_NOWARN |
>>>>>>> 			    __GFP_NOMEMALLOC | GFP_NOWAIT,
>>>>>>> 		.nid = node
>>>>>>> 	};
>>>>>>>
>>>>>>> 	page = alloc_migration_target(page, (unsigned long)&mtc);
>>>>>>> 	if (page)
>>>>>>> 		return page;
>>>>>>>
>>>>>>> 	mtc.gfp_mask &= ~__GFP_THISNODE;
>>>>>>> 	mtc.nmask = &allowed_mask;
>>>>>>>
>>>>>>> 	return alloc_migration_target(page, (unsigned long)&mtc);
>>>>>>> }
>>>>>>
>>>>>> I skipped doing this in v5 because I was not sure this is really what we
>>>>>> want.
>>>>>
>>>>> I think so.  And this is the original behavior.  We should keep the
>>>>> original behavior as much as possible, then make changes if necessary.
>>>>>
>>>>
>>>> That is the reason I split the new page allocation as a separate patch.
>>>> Previous discussion on this topic didn't conclude on whether we really
>>>> need to do the above or not
>>>> https://lore.kernel.org/lkml/CAAPL-u9endrWf_aOnPENDPdvT-2-YhCAeJ7ONGckGnXErTLOfQ@mail.gmail.com/
>>>
>>> Please check the later email in the thread you referenced.  Both Wei and
>>> me agree that the use case needs to be supported.  We just didn't reach
>>> concensus about how to implement it.  If you think Wei's solution is
>>> better (referenced as below), you can try to do that too.  Although I
>>> think my proposed implementation is much simpler.
>>
>> How about the below details
>>
>> diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
>> index 79bd8d26feb2..cd6e71f702ad 100644
>> --- a/include/linux/memory-tiers.h
>> +++ b/include/linux/memory-tiers.h
>> @@ -21,6 +21,7 @@ void node_remove_from_memory_tier(int node);
>>   int node_get_memory_tier_id(int node);
>>   int node_set_memory_tier(int node, int tier);
>>   int node_reset_memory_tier(int node, int tier);
>> +void node_get_allowed_targets(int node, nodemask_t *targets);
>>   #else
>>   #define numa_demotion_enabled	false
>>   static inline int next_demotion_node(int node)
>> @@ -28,6 +29,10 @@ static inline int next_demotion_node(int node)
>>   	return NUMA_NO_NODE;
>>   }
>>   
>>
>>
>>
>> +static inline void node_get_allowed_targets(int node, nodemask_t *targets)
>> +{
>> +	*targets = NODE_MASK_NONE;
>> +}
>>   #endif	/* CONFIG_TIERED_MEMORY */
>>   
>>
>>
>>
>>   #endif
>> diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
>> index b4e72b672d4d..592d939ec28d 100644
>> --- a/mm/memory-tiers.c
>> +++ b/mm/memory-tiers.c
>> @@ -18,6 +18,7 @@ struct memory_tier {
>>   
>>
>>
>>
>>   struct demotion_nodes {
>>   	nodemask_t preferred;
>> +	nodemask_t allowed;
>>   };
>>   
>>
>>
>>
>>   #define to_memory_tier(device) container_of(device, struct memory_tier, dev)
>> @@ -378,6 +379,25 @@ int node_set_memory_tier(int node, int tier)
>>   }
>>   EXPORT_SYMBOL_GPL(node_set_memory_tier);
>>   
>>
>>
>>
>> +void node_get_allowed_targets(int node, nodemask_t *targets)
>> +{
>> +	/*
>> +	 * node_demotion[] is updated without excluding this
>> +	 * function from running.
>> +	 *
>> +	 * If any node is moving to lower tiers then modifications
>> +	 * in node_demotion[] are still valid for this node, if any
>> +	 * node is moving to higher tier then moving node may be
>> +	 * used once for demotion which should be ok so rcu should
>> +	 * be enough here.
>> +	 */
>> +	rcu_read_lock();
>> +
>> +	*targets = node_demotion[node].allowed;
>> +
>> +	rcu_read_unlock();
>> +}
>> +
>>   /**
>>    * next_demotion_node() - Get the next node in the demotion path
>>    * @node: The starting node to lookup the next node
>> @@ -437,8 +457,10 @@ static void __disable_all_migrate_targets(void)
>>   {
>>   	int node;
>>   
>>
>>
>>
>> -	for_each_node_mask(node, node_states[N_MEMORY])
>> +	for_each_node_mask(node, node_states[N_MEMORY]) {
>>   		node_demotion[node].preferred = NODE_MASK_NONE;
>> +		node_demotion[node].allowed = NODE_MASK_NONE;
>> +	}
>>   }
>>   
>>
>>
>>
>>   static void disable_all_migrate_targets(void)
>> @@ -465,7 +487,7 @@ static void establish_migration_targets(void)
>>   	struct demotion_nodes *nd;
>>   	int target = NUMA_NO_NODE, node;
>>   	int distance, best_distance;
>> -	nodemask_t used;
>> +	nodemask_t used, allowed = NODE_MASK_NONE;
>>   
>>
>>
>>
>>   	if (!node_demotion)
>>   		return;
>> @@ -511,6 +533,29 @@ static void establish_migration_targets(void)
>>   			}
>>   		} while (1);
>>   	}
>> +	/*
>> +	 * Now build the allowed mask for each node collecting node mask from
>> +	 * all memory tier below it. This allows us to fallback demotion page
>> +	 * allocation to a set of nodes that is closer the above selected
>> +	 * perferred node.
>> +	 */
>> +	list_for_each_entry(memtier, &memory_tiers, list)
>> +		nodes_or(allowed, allowed, memtier->nodelist);
>> +	/*
>> +	 * Removes nodes not yet in N_MEMORY.
>> +	 */
>> +	nodes_and(allowed, node_states[N_MEMORY], allowed);
>> +
>> +	list_for_each_entry(memtier, &memory_tiers, list) {
>> +		/*
>> +		 * Keep removing current tier from allowed nodes,
>> +		 * This will remove all nodes in current and above
>> +		 * memory tier from the allowed mask.
>> +		 */
>> +		nodes_andnot(allowed, allowed, memtier->nodelist);
>> +		for_each_node_mask(node, memtier->nodelist)
>> +			node_demotion[node].allowed = allowed;
>> +	}
>>   }
>>   
>>
>>
>>
>>   /*
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index 3a8f78277f99..b0792d838efb 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -1460,19 +1460,32 @@ static void folio_check_dirty_writeback(struct folio *folio,
>>   		mapping->a_ops->is_dirty_writeback(folio, dirty, writeback);
>>   }
>>   
>>
>>
>>
>> -static struct page *alloc_demote_page(struct page *page, unsigned long node)
>> +static struct page *alloc_demote_page(struct page *page, unsigned long private)
>>   {
>> -	struct migration_target_control mtc = {
>> -		/*
>> -		 * Allocate from 'node', or fail quickly and quietly.
>> -		 * When this happens, 'page' will likely just be discarded
>> -		 * instead of migrated.
>> -		 */
>> -		.gfp_mask = (GFP_HIGHUSER_MOVABLE & ~__GFP_RECLAIM) |
>> -			    __GFP_THISNODE  | __GFP_NOWARN |
>> -			    __GFP_NOMEMALLOC | GFP_NOWAIT,
>> -		.nid = node
>> -	};
>> +	struct page *target_page;
>> +	nodemask_t *allowed_mask;
>> +	struct migration_target_control *mtc;
>> +
>> +	mtc = (struct migration_target_control *)private;
>> +
>> +	allowed_mask = mtc->nmask;
>> +	/*
>> +	 * make sure we allocate from the target node first also trying to
>> +	 * reclaim pages from the target node via kswapd if we are low on
>> +	 * free memory on target node. If we don't do this and if we have low
>> +	 * free memory on the target memtier, we would start allocating pages
>> +	 * from higher memory tiers without even forcing a demotion of cold
>> +	 * pages from the target memtier. This can result in the kernel placing
>> +	 * hotpages in higher memory tiers.
>> +	 */
>> +	mtc->nmask = NULL;
>> +	mtc->gfp_mask |= __GFP_THISNODE;
>> +	target_page = alloc_migration_target(page, (unsigned long)&mtc);
>> +	if (target_page)
>> +		return target_page;
>> +
>> +	mtc->gfp_mask &= ~__GFP_THISNODE;
>> +	mtc->nmask = allowed_mask;
>>   
>>
>>
>>
>>   	return alloc_migration_target(page, (unsigned long)&mtc);
>>   }
>> @@ -1487,6 +1500,19 @@ static unsigned int demote_page_list(struct list_head *demote_pages,
>>   {
>>   	int target_nid = next_demotion_node(pgdat->node_id);
>>   	unsigned int nr_succeeded;
>> +	nodemask_t allowed_mask;
>> +
>> +	struct migration_target_control mtc = {
>> +		/*
>> +		 * Allocate from 'node', or fail quickly and quietly.
>> +		 * When this happens, 'page' will likely just be discarded
>> +		 * instead of migrated.
>> +		 */
>> +		.gfp_mask = (GFP_HIGHUSER_MOVABLE & ~__GFP_RECLAIM) | __GFP_NOWARN |
>> +			__GFP_NOMEMALLOC | GFP_NOWAIT,
>> +		.nid = target_nid,
>> +		.nmask = &allowed_mask
>> +	};
>>   
>>
>>
>>
>>   	if (list_empty(demote_pages))
>>   		return 0;
>> @@ -1494,10 +1520,12 @@ static unsigned int demote_page_list(struct list_head *demote_pages,
>>   	if (target_nid == NUMA_NO_NODE)
>>   		return 0;
>>   
>>
>>
>>
>> +	node_get_allowed_targets(pgdat->node_id, &allowed_mask);
>> +
>>   	/* Demotion ignores all cpuset and mempolicy settings */
>>   	migrate_pages(demote_pages, alloc_demote_page, NULL,
>> -			    target_nid, MIGRATE_ASYNC, MR_DEMOTION,
>> -			    &nr_succeeded);
>> +		      (unsigned long)&mtc, MIGRATE_ASYNC, MR_DEMOTION,
>> +		      &nr_succeeded);
> 
> Firstly, it addressed my requirement, Thanks!  And, I'd prefer to put
> mtc definition in alloc_demote_page().  Because that makes all page
> allocation logic in one function.  Thus the readability of code is
> better.

The challenge is in allowed_mask computation. That is based on the 
src_node and not target_node.

-aneesh
