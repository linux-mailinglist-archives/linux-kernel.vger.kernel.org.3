Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48687584C17
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 08:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234943AbiG2Gmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 02:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233813AbiG2Gmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 02:42:43 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E427280488
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 23:42:42 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26T6RcqC010283;
        Fri, 29 Jul 2022 06:42:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=kj0Kk/lxUhod21OuHXXtIfLlVCej2PwE34+4rV/c62Y=;
 b=DZxTUrWeTvF1ebr1oPqYSsLMTYYoEv4U4QD3F8m0c7oX+9OpYx9j3sh7iJx+gJVjV6Z1
 YolN+Q+I6cOd0m7jT/f9T7TdvHiZcs6R6wv9vBXKhiknIqAzVVbgAMXU4NXreWbRAkUc
 fmseElkCqrElaPCGmZzSnMCxiddjjON7y652NKQb4Q8Q+ba2aHdfbRdBovXge8UD/7mr
 0ht9KxLbB032MDj7sTfQ4riY9ZRTZP4tyK/zRc/6xtbpc+mDuJkouod0AHU1lCl6ILbs
 Iw86sC0Pit3feEnCBdMR2TD6DbL202Sc2R3GQ8/+Lm2rrYuoAUCN7FLt6BF+aUQ/Z6BF Ow== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hmaa5gnkh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Jul 2022 06:42:25 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 26T6SCs1011635;
        Fri, 29 Jul 2022 06:42:25 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hmaa5gnjf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Jul 2022 06:42:24 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26T6a9pS018740;
        Fri, 29 Jul 2022 06:42:22 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 3hg96wq88s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Jul 2022 06:42:22 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26T6gJUA29491520
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Jul 2022 06:42:20 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D9CCBAE04D;
        Fri, 29 Jul 2022 06:42:19 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BCEC2AE045;
        Fri, 29 Jul 2022 06:42:16 +0000 (GMT)
Received: from [9.43.86.244] (unknown [9.43.86.244])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 29 Jul 2022 06:42:16 +0000 (GMT)
Message-ID: <9fa09da8-eff7-e39a-96b0-2bc51711f08f@linux.ibm.com>
Date:   Fri, 29 Jul 2022 12:11:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v11 8/8] mm/demotion: Update node_is_toptier to work with
 memory tiers
Content-Language: en-US
To:     "Huang, Ying" <ying.huang@intel.com>
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
References: <20220728190436.858458-1-aneesh.kumar@linux.ibm.com>
 <20220728190436.858458-9-aneesh.kumar@linux.ibm.com>
 <87sfmkl8x0.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
In-Reply-To: <87sfmkl8x0.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: lfdallBhMO1H6FWSmHLaDOuXYeEgYnI6
X-Proofpoint-ORIG-GUID: kXmSMPVDVJP0XA-g3U3awcWmjBtVh5Ke
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-28_06,2022-07-28_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 mlxlogscore=999 lowpriorityscore=0 adultscore=0 phishscore=0 mlxscore=0
 clxscore=1015 malwarescore=0 impostorscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207290026
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/29/22 12:09 PM, Huang, Ying wrote:
> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
> 
>> With memory tiers support we can have memory only NUMA nodes
>> in the top tier from which we want to avoid promotion tracking NUMA
>> faults. Update node_is_toptier to work with memory tiers.
>> All NUMA nodes are by default top tier nodes. With lower memory
>> tiers added we consider all memory tiers above a memory tier having
>> CPU NUMA nodes as a top memory tier
>>
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>> ---
>>  include/linux/memory-tiers.h | 11 ++++++++++
>>  include/linux/node.h         |  5 -----
>>  mm/huge_memory.c             |  1 +
>>  mm/memory-tiers.c            | 42 ++++++++++++++++++++++++++++++++++++
>>  mm/migrate.c                 |  1 +
>>  mm/mprotect.c                |  1 +
>>  6 files changed, 56 insertions(+), 5 deletions(-)
>>
>> diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
>> index f8dbeda617a7..bc9fb9d39b2c 100644
>> --- a/include/linux/memory-tiers.h
>> +++ b/include/linux/memory-tiers.h
>> @@ -35,6 +35,7 @@ struct memory_dev_type *init_node_memory_type(int node, struct memory_dev_type *
>>  #ifdef CONFIG_MIGRATION
>>  int next_demotion_node(int node);
>>  void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets);
>> +bool node_is_toptier(int node);
>>  #else
>>  static inline int next_demotion_node(int node)
>>  {
>> @@ -45,6 +46,11 @@ static inline void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *target
>>  {
>>  	*targets = NODE_MASK_NONE;
>>  }
>> +
>> +static inline bool node_is_toptier(int node)
>> +{
>> +	return true;
>> +}
>>  #endif
>>  
>>  #else
>> @@ -64,5 +70,10 @@ static inline void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *target
>>  {
>>  	*targets = NODE_MASK_NONE;
>>  }
>> +
>> +static inline bool node_is_toptier(int node)
>> +{
>> +	return true;
>> +}
>>  #endif	/* CONFIG_NUMA */
>>  #endif  /* _LINUX_MEMORY_TIERS_H */
>> diff --git a/include/linux/node.h b/include/linux/node.h
>> index 40d641a8bfb0..9ec680dd607f 100644
>> --- a/include/linux/node.h
>> +++ b/include/linux/node.h
>> @@ -185,9 +185,4 @@ static inline void register_hugetlbfs_with_node(node_registration_func_t reg,
>>  
>>  #define to_node(device) container_of(device, struct node, dev)
>>  
>> -static inline bool node_is_toptier(int node)
>> -{
>> -	return node_state(node, N_CPU);
>> -}
>> -
>>  #endif /* _LINUX_NODE_H_ */
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 834f288b3769..8405662646e9 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -35,6 +35,7 @@
>>  #include <linux/numa.h>
>>  #include <linux/page_owner.h>
>>  #include <linux/sched/sysctl.h>
>> +#include <linux/memory-tiers.h>
>>  
>>  #include <asm/tlb.h>
>>  #include <asm/pgalloc.h>
>> diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
>> index 84e2be31a853..36d87dc422ab 100644
>> --- a/mm/memory-tiers.c
>> +++ b/mm/memory-tiers.c
>> @@ -30,6 +30,7 @@ static DEFINE_MUTEX(memory_tier_lock);
>>  static LIST_HEAD(memory_tiers);
>>  struct memory_dev_type *node_memory_types[MAX_NUMNODES];
>>  #ifdef CONFIG_MIGRATION
>> +static int top_tier_adistance;
>>  /*
>>   * node_demotion[] examples:
>>   *
>> @@ -159,6 +160,31 @@ static struct memory_tier *__node_get_memory_tier(int node)
>>  }
>>  
>>  #ifdef CONFIG_MIGRATION
>> +bool node_is_toptier(int node)
>> +{
>> +	bool toptier;
>> +	pg_data_t *pgdat;
>> +	struct memory_tier *memtier;
>> +
>> +	pgdat = NODE_DATA(node);
>> +	if (!pgdat)
>> +		return false;
>> +
>> +	rcu_read_lock();
>> +	memtier = rcu_dereference(pgdat->memtier);
>> +	if (!memtier) {
>> +		toptier = true;
>> +		goto out;
>> +	}
>> +	if (memtier->adistance_start >= top_tier_adistance)
>> +		toptier = true;
>> +	else
>> +		toptier = false;
>> +out:
>> +	rcu_read_unlock();
>> +	return toptier;
>> +}
>> +
>>  void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets)
>>  {
>>  	struct memory_tier *memtier;
>> @@ -315,6 +341,22 @@ static void establish_demotion_targets(void)
>>  			}
>>  		} while (1);
>>  	}
>> +	/*
>> +	 * Promotion is allowed from a memory tier to higher
>> +	 * memory tier only if the memory tier doesn't include
>> +	 * compute. We want to  skip promotion from a memory tier,
>> +	 * if any node that is  part of the memory tier have CPUs.
>> +	 * Once we detect such a memory tier, we consider that tier
>> +	 * as top tiper from which promotion on is not allowed.
>> +	 */
>> +	list_for_each_entry(memtier, &memory_tiers, list) {
>> +		tier_nodes = get_memtier_nodemask(memtier);
>> +		nodes_and(tier_nodes, node_states[N_CPU], tier_nodes);
>> +		if (!nodes_empty(tier_nodes)) {
>> +			top_tier_adistance = memtier->adistance_start;
> 
> IMHO, this should be,
> 
> 			top_tier_adistance = memtier->adistance_start + MEMTIER_CHUNK_SIZE;
> 

Good catch. Will update. BTW i did send v12 version of the patchset already to the list. 

-aneesh
