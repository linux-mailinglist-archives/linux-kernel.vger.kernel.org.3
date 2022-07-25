Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C048C57FBEE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 11:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234442AbiGYJFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 05:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233274AbiGYJFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 05:05:22 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D205E45
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 02:05:21 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26P8lvps020342;
        Mon, 25 Jul 2022 09:05:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=E0VKKAZH6Ei7cQbJpeZWaOE6ScVkZUFVFHC9ZYNcPYc=;
 b=lYikfyevXHKdoGkT+MeFhp9Fmc9JX8nMciihxNqqPNy3HBqlV870YiCViyMYmea6N4sT
 DiVmO/1M6mgjrPw3cT/unW+5cRbsv2j3VAFV6fdVGkOEGFSaHJO+Lu8rj1hweIjMWYu6
 GVMRmzdpEtSXiCeqZ3iOo0ssIgOV9p0pKEj0CohP59eZYCyUTxXmLV92UoirSLPZh4DT
 8YERIptNp91kkOLWcTnDNw8WpBjw7Bd8ONHBLecvmmo4wS+lEnYI0sm8LWT+AUNPuqQS
 np7S1ygnxYkGH8riQMw3Zg8pKbK3c+SccVmIsWRv3PRXC9hwEPCqArc1QS0qHIF++ciL JA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hhqyw0e90-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Jul 2022 09:05:05 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 26P8oEIq004698;
        Mon, 25 Jul 2022 09:05:04 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hhqyw0e7s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Jul 2022 09:05:04 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26P8pOWx025717;
        Mon, 25 Jul 2022 08:56:43 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 3hg96wj627-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Jul 2022 08:56:42 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26P8ueFE24772890
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Jul 2022 08:56:40 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B88674C044;
        Mon, 25 Jul 2022 08:56:40 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6CD414C040;
        Mon, 25 Jul 2022 08:56:37 +0000 (GMT)
Received: from [9.43.12.201] (unknown [9.43.12.201])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 25 Jul 2022 08:56:37 +0000 (GMT)
Message-ID: <e7073964-6631-38f1-62cb-f59b8d26f891@linux.ibm.com>
Date:   Mon, 25 Jul 2022 14:26:35 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v10 8/8] mm/demotion: Update node_is_toptier to work with
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
References: <20220720025920.1373558-1-aneesh.kumar@linux.ibm.com>
 <20220720025920.1373558-9-aneesh.kumar@linux.ibm.com>
 <87ilnly3m4.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
In-Reply-To: <87ilnly3m4.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 82-0Rdp8pj8H1cpAw7RnraOkpVi3Rjr9
X-Proofpoint-ORIG-GUID: 90ZgQ_CkFb_UpC6xB8YIblLqszGdFix1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-25_07,2022-07-21_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 malwarescore=0 suspectscore=0 adultscore=0 clxscore=1015 mlxscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207250038
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/25/22 2:24 PM, Huang, Ying wrote:
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
>>  include/linux/memory-tiers.h | 11 +++++++++
>>  include/linux/node.h         |  5 -----
>>  mm/huge_memory.c             |  1 +
>>  mm/memory-tiers.c            | 43 ++++++++++++++++++++++++++++++++++++
>>  mm/migrate.c                 |  1 +
>>  mm/mprotect.c                |  1 +
>>  6 files changed, 57 insertions(+), 5 deletions(-)
>>
>> diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
>> index 0e58588fa066..085dd815bf73 100644
>> --- a/include/linux/memory-tiers.h
>> +++ b/include/linux/memory-tiers.h
>> @@ -20,6 +20,7 @@ extern bool numa_demotion_enabled;
>>  #ifdef CONFIG_MIGRATION
>>  int next_demotion_node(int node);
>>  void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets);
>> +bool node_is_toptier(int node);
>>  #else
>>  static inline int next_demotion_node(int node)
>>  {
>> @@ -30,6 +31,11 @@ static inline void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *target
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
>> @@ -44,5 +50,10 @@ static inline void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *target
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
>> index a2a16d4104fd..d0432db18094 100644
>> --- a/include/linux/node.h
>> +++ b/include/linux/node.h
>> @@ -191,9 +191,4 @@ static inline void register_hugetlbfs_with_node(node_registration_func_t reg,
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
>> index 4a96e4213d66..f0515bfd4051 100644
>> --- a/mm/memory-tiers.c
>> +++ b/mm/memory-tiers.c
>> @@ -13,6 +13,7 @@
>>  
>>  struct memory_tier {
>>  	struct list_head list;
>> +	int id;
>>  	int perf_level;
>>  	nodemask_t nodelist;
>>  	nodemask_t lower_tier_mask;
>> @@ -26,6 +27,7 @@ static LIST_HEAD(memory_tiers);
>>  static DEFINE_MUTEX(memory_tier_lock);
>>  
>>  #ifdef CONFIG_MIGRATION
>> +static int top_tier_id;
>>  /*
>>   * node_demotion[] examples:
>>   *
>> @@ -129,6 +131,7 @@ static struct memory_tier *find_create_memory_tier(unsigned int perf_level)
>>  	if (!new_memtier)
>>  		return ERR_PTR(-ENOMEM);
>>  
>> +	new_memtier->id = perf_level >> MEMTIER_CHUNK_BITS;
>>  	new_memtier->perf_level = perf_level;
>>  	if (found_slot)
>>  		list_add_tail(&new_memtier->list, ent);
>> @@ -154,6 +157,31 @@ static struct memory_tier *__node_get_memory_tier(int node)
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
>> +	if (memtier->id >= top_tier_id)
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
>> @@ -304,6 +332,21 @@ static void establish_migration_targets(void)
>>  			}
>>  		} while (1);
>>  	}
>> +	/*
>> +	 * Promotion is allowed from a memory tier to higher
>> +	 * memory tier only if the memory tier doesn't include
>> +	 * compute. We want to  skip promotion from a memory tier,
>> +	 * if any node that is  part of the memory tier have CPUs.
>> +	 * Once we detect such a memory tier, we consider that tier
>> +	 * as top tiper from which promotion is not allowed.
>> +	 */
>> +	list_for_each_entry_reverse(memtier, &memory_tiers, list) {
>> +		nodes_and(used, node_states[N_CPU], memtier->nodelist);
>> +		if (!nodes_empty(used)) {
>> +			top_tier_id = memtier->id;
> 
> I don't think we need to introduce memory tier ID for this.  We can add
> a top_tier_perf_level, set it here and use it in node_is_toptier().
> 

Sure. Will switch to that in the next iteration.

-aneesh
