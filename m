Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E15235863C6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 07:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239626AbiHAFjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 01:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiHAFjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 01:39:01 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3356CDF5B
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 22:39:00 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2712r7Z4012091;
        Mon, 1 Aug 2022 05:38:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=+XUJq65YQ6YJFY/baYu7z8L7TVBrcbxPxGAQCqKq4N0=;
 b=UH/kKAT0kO9HxYX2lCOblR5A7yES9onVPXvVNInB0kXAE03f29oGBMm1gwGI9o/XxiWP
 oqYcZhw8V2ESA4rPSt89P/dcaNZFWu7EAnQZ+5TgPJCKFoiQp2JjiCll6N8AVRSqlV5a
 h8MW8Nd9RxOkmDWOaXxOlvfb/jbihs/0zmD1SreE5/kz8N4MgQA2ToT9KoyO65uo+v9q
 g3Ee59XVbrf8gwuSsnPieymOfaJE0583opWof2sfsg/yZyXXJbkYUQV16dsbsyqH110H
 JzGi61ERnmj5E15FU7Qm4J5gswFYxT68Rz0ckrb5s3F1kIHDefIrTxMQAdbSxCbEo3ee wg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hp6efufq7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Aug 2022 05:38:30 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2715OP37022803;
        Mon, 1 Aug 2022 05:38:30 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hp6efufpg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Aug 2022 05:38:30 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2715Zhls009428;
        Mon, 1 Aug 2022 05:38:27 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04fra.de.ibm.com with ESMTP id 3hmv98h9w1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Aug 2022 05:38:27 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2715cPls12255620
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 1 Aug 2022 05:38:25 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 29134AE04D;
        Mon,  1 Aug 2022 05:38:25 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8199CAE045;
        Mon,  1 Aug 2022 05:38:21 +0000 (GMT)
Received: from [9.43.22.209] (unknown [9.43.22.209])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  1 Aug 2022 05:38:21 +0000 (GMT)
Message-ID: <826fbdbc-219f-8f4a-7373-41c718287533@linux.ibm.com>
Date:   Mon, 1 Aug 2022 11:08:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v11 4/8] mm/demotion/dax/kmem: Set node's abstract
 distance to MEMTIER_ADISTANCE_PMEM
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
 <20220728190436.858458-5-aneesh.kumar@linux.ibm.com>
 <875yjgmocg.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <87bkt8s7w9.fsf@linux.ibm.com>
 <87k07slnt7.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <e5545c90-9595-d08c-8a1c-1c15e3b94999@linux.ibm.com>
 <87tu6wk0q5.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
In-Reply-To: <87tu6wk0q5.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: DZr36wxaqANDjFspu4dHOdyjpdUCTGpE
X-Proofpoint-GUID: ax0mn281_lu61-Cld190YjwgofvW9kXE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-01_01,2022-07-28_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 adultscore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 phishscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208010028
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/1/22 10:40 AM, Huang, Ying wrote:
> Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> writes:
> 
>> On 8/1/22 7:36 AM, Huang, Ying wrote:
>>> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
>>>
>>>> "Huang, Ying" <ying.huang@intel.com> writes:
>>>>
>>>>> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
>>>>>
>>>>>> By default, all nodes are assigned to the default memory tier which
>>>>>> is the memory tier designated for nodes with DRAM
>>>>>>
>>>>>> Set dax kmem device node's tier to slower memory tier by assigning
>>>>>> abstract distance to MEMTIER_ADISTANCE_PMEM. PMEM tier
>>>>>> appears below the default memory tier in demotion order.
>>>>>>
>>>>>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>>>>>> ---
>>>>>>  drivers/dax/kmem.c           |  9 +++++++++
>>>>>>  include/linux/memory-tiers.h | 19 ++++++++++++++++++-
>>>>>>  mm/memory-tiers.c            | 28 ++++++++++++++++------------
>>>>>>  3 files changed, 43 insertions(+), 13 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
>>>>>> index a37622060fff..6b0d5de9a3e9 100644
>>>>>> --- a/drivers/dax/kmem.c
>>>>>> +++ b/drivers/dax/kmem.c
>>>>>> @@ -11,6 +11,7 @@
>>>>>>  #include <linux/fs.h>
>>>>>>  #include <linux/mm.h>
>>>>>>  #include <linux/mman.h>
>>>>>> +#include <linux/memory-tiers.h>
>>>>>>  #include "dax-private.h"
>>>>>>  #include "bus.h"
>>>>>>  
>>>>>> @@ -41,6 +42,12 @@ struct dax_kmem_data {
>>>>>>  	struct resource *res[];
>>>>>>  };
>>>>>>  
>>>>>> +static struct memory_dev_type default_pmem_type  = {
>>>>>
>>>>> Why is this named as default_pmem_type?  We will not change the memory
>>>>> type of a node usually.
>>>>>
>>>>
>>>> Any other suggestion? pmem_dev_type? 
>>>
>>> Or dax_pmem_type?
>>>
>>> DAX is used to enumerate the memory device.
>>>
>>>>
>>>>>> +	.adistance = MEMTIER_ADISTANCE_PMEM,
>>>>>> +	.tier_sibiling = LIST_HEAD_INIT(default_pmem_type.tier_sibiling),
>>>>>> +	.nodes  = NODE_MASK_NONE,
>>>>>> +};
>>>>>> +
>>>>>>  static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
>>>>>>  {
>>>>>>  	struct device *dev = &dev_dax->dev;
>>>>>> @@ -62,6 +69,8 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
>>>>>>  		return -EINVAL;
>>>>>>  	}
>>>>>>  
>>>>>> +	init_node_memory_type(numa_node, &default_pmem_type);
>>>>>> +
>>>>>
>>>>> The memory hot-add below may fail.  So the error handling needs to be
>>>>> added.
>>>>>
>>>>> And, it appears that the memory type and memory tier of a node may be
>>>>> fully initialized here before NUMA hot-adding started.  So I suggest to
>>>>> set node_memory_types[] here only.  And set memory_dev_type->nodes in
>>>>> node hot-add callback.  I think there is the proper place to complete
>>>>> the initialization.
>>>>>
>>>>> And, in theory dax/kmem.c can be unloaded.  So we need to clear
>>>>> node_memory_types[] for nodes somewhere.
>>>>>
>>>>
>>>> I guess by module exit we can be sure that all the memory managed
>>>> by dax/kmem is hotplugged out. How about something like below?
>>>
>>> Because we set node_memorty_types[] in dev_dax_kmem_probe(), it's
>>> natural to clear it in dev_dax_kmem_remove().
>>>
>>
>> Most of required reset/clear is done as part of memory hotunplug. So
>> if we did manage to successfully unplug the memory, everything except
>> node_memory_types[node] should be reset. That makes the clear_node_memory_type
>> the below. 
>>
>> void clear_node_memory_type(int node, struct memory_dev_type *memtype)
>> {
>>
>> 	mutex_lock(&memory_tier_lock);
>> 	/*
>> 	 * memory unplug did clear the node from the memtype and
>> 	 * dax/kem did initialize this node's memory type.
>> 	 */
>> 	if (!node_isset(node, memtype->nodes) && node_memory_types[node]  == memtype){
>> 		node_memory_types[node] = NULL;
>> 	}
>> 	mutex_unlock(&memory_tier_lock);
>> }
>>
>> With the module unload, it is kind of force removing the usage of the specific memtype.
>> Considering module unload will remove the usage of specific memtype from other parts
>> of the kernel and we already do all the required reset in memory hot unplug, do we
>> need to do the clear_node_memory_type above? 
> 
> Per my understanding, we need to call clear_node_memory_type() in
> dev_dax_kmem_remove().  After that, we have nothing to do in
> dax_kmem_exit().
> 

Ok, I guess you are suggesting to do the clear_node_memory_type even if we fail the memory remove. 
Should we also rebuild demotion order? On a successful memory remove we do rebuild demotion order.
This is what i ended up with.

modified   drivers/dax/kmem.c
@@ -171,6 +171,7 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 static void dev_dax_kmem_remove(struct dev_dax *dev_dax)
 {
 	int i, success = 0;
+	int node = dev_dax->target_node;
 	struct device *dev = &dev_dax->dev;
 	struct dax_kmem_data *data = dev_get_drvdata(dev);
 
@@ -208,6 +209,12 @@ static void dev_dax_kmem_remove(struct dev_dax *dev_dax)
 		kfree(data);
 		dev_set_drvdata(dev, NULL);
 	}
+	/*
+	 * Clear the memtype association, even if the memory
+	 * remove failed.
+	 */
+	clear_node_memory_type(node, dax_pmem_type);
+
 }
 #else
 static void dev_dax_kmem_remove(struct dev_dax *dev_dax)
modified   include/linux/memory-tiers.h
@@ -31,6 +31,7 @@ struct memory_dev_type {
 #ifdef CONFIG_NUMA
 extern bool numa_demotion_enabled;
 void init_node_memory_type(int node, struct memory_dev_type *default_type);
+void clear_node_memory_type(int node, struct memory_dev_type *memtype);
 #ifdef CONFIG_MIGRATION
 int next_demotion_node(int node);
 void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets);
@@ -57,6 +58,10 @@ static inline bool node_is_toptier(int node)
 #define numa_demotion_enabled	false
 static inline void init_node_memory_type(int node, struct memory_dev_type *default_type)
 {
+}
+
+static inline void unregister_memory_type(struct memory_dev_type *memtype)
+{
 
 }
 
modified   mm/memory-tiers.c
@@ -501,6 +501,36 @@ void init_node_memory_type(int node, struct memory_dev_type *default_type)
 }
 EXPORT_SYMBOL_GPL(init_node_memory_type);
 
+void clear_node_memory_type(int node, struct memory_dev_type *memtype)
+{
+	struct memory_tier *memtier;
+
+	mutex_lock(&memory_tier_lock);
+	/*
+	 * Even if we fail to unplug memory, clear the association of
+	 * this node to this specific memory type.
+	 */
+	if (node_memory_types[node] == memtype) {
+
+		memtier = __node_get_memory_tier(node);
+		if (memtier) {
+			rcu_assign_pointer(pgdat->memtier, NULL);
+			synchronize_rcu();
+		}
+		node_clear(node, memtype->nodes);
+		if (nodes_empty(memtype->nodes)) {
+			list_del(&memtype->tier_sibiling);
+			memtype->memtier = NULL;
+			if (current_memtier && list_empty(&current_memtier->memory_types))
+				destroy_memory_tier(current_memtier);
+
+		}
+		node_memory_types[node] = NULL;
+	}
+	mutex_unlock(&memory_tier_lock);
+}
+EXPORT_SYMBOL_GPL(init_node_memory_type);
+
 void update_node_adistance(int node, struct memory_dev_type *memtype)
 {
 	pg_data_t *pgdat;

[back


