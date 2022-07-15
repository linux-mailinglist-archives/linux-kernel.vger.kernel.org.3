Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA4FA575C41
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 09:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbiGOHTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 03:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbiGOHTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 03:19:44 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B051B3F302
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 00:19:42 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26F6htbB010010;
        Fri, 15 Jul 2022 07:19:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=yucGW5QiRJtbdc7M2Oc/PRPSqY0bvhQ8HLYWNk66xz0=;
 b=m39yGSzbvmLbaK4i50GhgtKY10IVD4cTy2rmPvy7nuXS3ssJ79+9MP8c6duTaFxnnpFl
 6rI5sZjrgW+X4AsxRNCm+dze9Bt5JJSCLUW+sZMbyCyub/E4YidxhqKp80Ox3wlzFL+u
 cBZ4BxEcN9nje8iu6uQLux7MZC6e01hNJskOYJ5fG37/4lc47MS7LnJDWaU0qYXBKIla
 DiJ98t+eWp5cOUQWnWoHHjmYjQR4O3k05Q/t7dcxVi0WqyiYDVhfKuXqgTUzX3MqcShT
 forCilzhUqbuYUo+XuymMn1WBNhMAkmUMF0rwvHrYwajlNkSi7PAGptQK2TFx6CqYPo2 2A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hb37g0rm9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Jul 2022 07:19:13 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 26F7ARId030550;
        Fri, 15 Jul 2022 07:19:13 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hb37g0rky-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Jul 2022 07:19:13 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26F76NSf024604;
        Fri, 15 Jul 2022 07:19:12 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma01dal.us.ibm.com with ESMTP id 3h71aahfj1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Jul 2022 07:19:12 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26F7JBt623003628
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Jul 2022 07:19:11 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 404E3124054;
        Fri, 15 Jul 2022 07:19:11 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E6F4412405E;
        Fri, 15 Jul 2022 07:19:05 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.43.84.38])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 15 Jul 2022 07:19:05 +0000 (GMT)
X-Mailer: emacs 29.0.50 (via feedmail 11-beta-1 I)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        Wei Xu <weixugc@google.com>, Huang Ying <ying.huang@intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim C Chen <tim.c.chen@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>, jvgediya.oss@gmail.com
Subject: Re: [PATCH v9 6/8] mm/demotion: Add pg_data_t member to track node
 memory tier details
In-Reply-To: <878rouap2e.fsf@nvdebian.thelocal>
References: <20220714045351.434957-1-aneesh.kumar@linux.ibm.com>
 <20220714045351.434957-7-aneesh.kumar@linux.ibm.com>
 <878rouap2e.fsf@nvdebian.thelocal>
Date:   Fri, 15 Jul 2022 12:49:03 +0530
Message-ID: <8735f2vo60.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: TPr54HsAFA6DZ7VBaU7ZdQ2anfaKWXWl
X-Proofpoint-ORIG-GUID: iKFcGVHTt8WGy0GRc5FgAiZseHNsnvUh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-15_02,2022-07-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 lowpriorityscore=0 mlxscore=0 bulkscore=0 adultscore=0
 malwarescore=0 impostorscore=0 phishscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207150029
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alistair Popple <apopple@nvidia.com> writes:

> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
>
>> Also update different helpes to use NODE_DATA()->memtier. Since
>> node specific memtier can change based on the reassignment of
>> NUMA node to a different memory tiers, accessing NODE_DATA()->memtier
>> needs to happen under an rcu read lock or memory_tier_lock.
>>
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>> ---
>>  include/linux/mmzone.h |  3 ++
>>  mm/memory-tiers.c      | 64 +++++++++++++++++++++++++++++++-----------
>>  2 files changed, 50 insertions(+), 17 deletions(-)
>>
>> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
>> index aab70355d64f..353812495a70 100644
>> --- a/include/linux/mmzone.h
>> +++ b/include/linux/mmzone.h
>> @@ -928,6 +928,9 @@ typedef struct pglist_data {
>>  	/* Per-node vmstats */
>>  	struct per_cpu_nodestat __percpu *per_cpu_nodestats;
>>  	atomic_long_t		vm_stat[NR_VM_NODE_STAT_ITEMS];
>> +#ifdef CONFIG_NUMA
>> +	struct memory_tier __rcu *memtier;
>> +#endif
>>  } pg_data_t;
>>
>>  #define node_present_pages(nid)	(NODE_DATA(nid)->node_present_pages)
>> diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
>> index e951f54ce56c..bab4700bf58d 100644
>> --- a/mm/memory-tiers.c
>> +++ b/mm/memory-tiers.c
>> @@ -7,6 +7,7 @@
>>  #include <linux/moduleparam.h>
>>  #include <linux/memory.h>
>>  #include <linux/random.h>
>> +#include <linux/rcupdate.h>
>>  #include <linux/memory-tiers.h>
>>
>>  #include "internal.h"
>> @@ -124,18 +125,23 @@ static struct memory_tier *register_memory_tier(unsigned int tier)
>>  static void unregister_memory_tier(struct memory_tier *memtier)
>>  {
>>  	list_del(&memtier->list);
>> -	kfree(memtier);
>> +	kfree_rcu(memtier);
>>  }
>>
>>  static struct memory_tier *__node_get_memory_tier(int node)
>>  {
>> -	struct memory_tier *memtier;
>> +	pg_data_t *pgdat;
>>
>> -	list_for_each_entry(memtier, &memory_tiers, list) {
>> -		if (node_isset(node, memtier->nodelist))
>> -			return memtier;
>> -	}
>> -	return NULL;
>> +	pgdat = NODE_DATA(node);
>> +	if (!pgdat)
>> +		return NULL;
>> +	/*
>> +	 * Since we hold memory_tier_lock, we can avoid
>> +	 * RCU read locks when accessing the details. No
>> +	 * parallel updates are possible here.
>> +	 */
>> +	return rcu_dereference_check(pgdat->memtier,
>> +				     lockdep_is_held(&memory_tier_lock));
>>  }
>>
>>  static struct memory_tier *__get_memory_tier_from_id(int id)
>> @@ -149,6 +155,33 @@ static struct memory_tier *__get_memory_tier_from_id(int id)
>>  	return NULL;
>>  }
>>
>> +/*
>> + * Called with memory_tier_lock. Hence the device references cannot
>> + * be dropped during this function.
>> + */
>> +static void memtier_node_set(int node, struct memory_tier *memtier)
>> +{
>> +	pg_data_t *pgdat;
>> +	struct memory_tier *current_memtier;
>> +
>> +	pgdat = NODE_DATA(node);
>> +	if (!pgdat)
>> +		return;
>> +	/*
>> +	 * Make sure we mark the memtier NULL before we assign the new memory tier
>> +	 * to the NUMA node. This make sure that anybody looking at NODE_DATA
>> +	 * finds a NULL memtier or the one which is still valid.
>> +	 */
>> +	current_memtier = rcu_dereference_check(pgdat->memtier,
>> +						lockdep_is_held(&memory_tier_lock));
>> +	rcu_assign_pointer(pgdat->memtier, NULL);
>> +	if (current_memtier)
>> +		node_clear(node, current_memtier->nodelist);
>
> It seems odd to me that you would update the current memtier prior to
> the synchronize_rcu(). I suppose it's really memory_tier_lock that
> protects the details like ->nodelist, but is there any reason not do the
> update after anyway?

The synchronize_rcu ensures that the lockless read of pgdat->memtier
either see value NULL or a stable memtier which got current numa node in
its nodelist. IIUC what you are suggesting is we should move the
node_clear after synchronize_rcu?. I am also wondering whether I need
a smp_wmb()?

pgdat->memtier = NULL;
synchronize_rcu
remove node from memtier;
set node in new memtier
smp_wmb();
pgdat->memtier = new memtier;


>
>> +	synchronize_rcu();
>> +	node_set(node, memtier->nodelist);
>> +	rcu_assign_pointer(pgdat->memtier, memtier);
>> +}
>> +
>>  static int __node_create_and_set_memory_tier(int node, int tier)
>>  {
>>  	int ret = 0;
>> @@ -162,7 +195,7 @@ static int __node_create_and_set_memory_tier(int node, int tier)
>>  			goto out;
>>  		}
>>  	}
>> -	node_set(node, memtier->nodelist);
>> +	memtier_node_set(node, memtier);
>>  out:
>>  	return ret;
>>  }
>> @@ -184,14 +217,7 @@ int node_create_and_set_memory_tier(int node, int tier)
>>  	if (current_tier->id == tier)
>>  		goto out;
>>
>> -	node_clear(node, current_tier->nodelist);
>> -
>>  	ret = __node_create_and_set_memory_tier(node, tier);
>> -	if (ret) {
>> -		/* reset it back to older tier */
>> -		node_set(node, current_tier->nodelist);
>> -		goto out;
>> -	}
>>  	if (nodes_empty(current_tier->nodelist))
>>  		unregister_memory_tier(current_tier);
>>
>> @@ -213,7 +239,7 @@ static int __node_set_memory_tier(int node, int tier)
>>  		ret = -EINVAL;
>>  		goto out;
>>  	}
>> -	node_set(node, memtier->nodelist);
>> +	memtier_node_set(node, memtier);
>>  out:
>>  	return ret;
>>  }
>> @@ -428,6 +454,7 @@ static void __init migrate_on_reclaim_init(void)
>>
>>  static int __init memory_tier_init(void)
>>  {
>> +	int node;
>>  	struct memory_tier *memtier;
>>
>>  	/*
>> @@ -444,7 +471,10 @@ static int __init memory_tier_init(void)
>>  		      __func__, PTR_ERR(memtier));
>>
>>  	/* CPU only nodes are not part of memory tiers. */
>> -	memtier->nodelist = node_states[N_MEMORY];
>> +	for_each_node_state(node, N_MEMORY) {
>> +		rcu_assign_pointer(NODE_DATA(node)->memtier, memtier);
>> +		node_set(node, memtier->nodelist);
>
> Similar comment here - the order seems opposite to what I'd expect.
> Shouldn't memtier->nodelist be fully initialised prior to making it
> visible with rcu_assign_pointer()?

Will fix this. This is early during boot. So the ordering won't impact
correctness. Hence i can skip the smp_wmb()? 

>
>> +	}
>>  	mutex_unlock(&memory_tier_lock);
>>
>>  	migrate_on_reclaim_init();
