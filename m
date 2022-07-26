Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE16F5812B8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 14:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238960AbiGZMEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 08:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238867AbiGZMEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 08:04:06 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E0E26AE4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 05:04:02 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26QBqoSF008818;
        Tue, 26 Jul 2022 12:03:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=GtRe0xGF3XVFJ3GltHT2iZtyWnzEgyGBEtgUluYOGMs=;
 b=jXslaxJqq4iFjP4Ru/SIcD0XHF/eet8GYwHkUIVgb4cb+ymm4VbBQ2dGOzFZCU+cByoR
 b3MBlBFB6RQ3P0FQxZ2uqjOcZcm80eFUjrpASAfGgBqJi86p8d7yRRLpLlXuarrr06vN
 sqDey8twOXjHGqdQtrpWRAl/EJvaeI8UER8XTphuMhkqu0qbLCUxXocIEMLWQJXMMHuh
 BC7olWuS43J9tMYqstvIcLpk1HGGhz3xwQgd2sbpL5Tq20l/n94+QUybn5n6C7Z1ftH6
 rmYfDfZs3+eomSk7DIrJDOgpOKjnVm6fMQ6n/yHN7jqFab4XShCsUiq2MXNxStMDwtv8 nA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hjfsjga5p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Jul 2022 12:03:47 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 26QBrhnE011074;
        Tue, 26 Jul 2022 12:03:46 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hjfsjga4u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Jul 2022 12:03:46 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26QBqjMW005638;
        Tue, 26 Jul 2022 12:03:44 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06fra.de.ibm.com with ESMTP id 3hg98fhbm4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Jul 2022 12:03:43 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26QC3tHk27001104
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Jul 2022 12:03:55 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B395C42042;
        Tue, 26 Jul 2022 12:03:41 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 23C1842041;
        Tue, 26 Jul 2022 12:03:38 +0000 (GMT)
Received: from [9.43.64.160] (unknown [9.43.64.160])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 26 Jul 2022 12:03:37 +0000 (GMT)
Message-ID: <28582201-b438-9ac9-ca6b-1ee6e5794dd2@linux.ibm.com>
Date:   Tue, 26 Jul 2022 17:33:37 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v10 3/8] mm/demotion: Add hotplug callbacks to handle new
 numa node onlined
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
 <20220720025920.1373558-4-aneesh.kumar@linux.ibm.com>
 <87fsiowmdt.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
In-Reply-To: <87fsiowmdt.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: alNSt9nSVlq-7FKl7tCvNJnnVqAakFSu
X-Proofpoint-GUID: xG5bvd_FpzCowMgCE4gs1eprFVnVA4-w
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-26_04,2022-07-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 impostorscore=0 adultscore=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207260046
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/26/22 9:33 AM, Huang, Ying wrote:
> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
> 
>> If the new NUMA node onlined doesn't have a performance level assigned,
>> the kernel adds the NUMA node to default memory tier.
>>
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>> ---
>>  include/linux/memory-tiers.h |  1 +
>>  mm/memory-tiers.c            | 75 ++++++++++++++++++++++++++++++++++++
>>  2 files changed, 76 insertions(+)
>>
>> diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
>> index ef380a39db3a..3d5f14d57ae6 100644
>> --- a/include/linux/memory-tiers.h
>> +++ b/include/linux/memory-tiers.h
>> @@ -14,6 +14,7 @@
>>  #define MEMTIER_PERF_LEVEL_DRAM	(1 << (MEMTIER_CHUNK_BITS + 2))
>>  /* leave one tier below this slow pmem */
>>  #define MEMTIER_PERF_LEVEL_PMEM	(1 << MEMTIER_CHUNK_BITS)
>> +#define MEMTIER_HOTPLUG_PRIO	100
>>  
>>  extern bool numa_demotion_enabled;
>>  
>> diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
>> index 41a21cc5ae55..cc3a47ec18e4 100644
>> --- a/mm/memory-tiers.c
>> +++ b/mm/memory-tiers.c
>> @@ -5,6 +5,7 @@
>>  #include <linux/lockdep.h>
>>  #include <linux/moduleparam.h>
>>  #include <linux/node.h>
>> +#include <linux/memory.h>
>>  #include <linux/memory-tiers.h>
>>  
>>  struct memory_tier {
>> @@ -64,6 +65,78 @@ static struct memory_tier *find_create_memory_tier(unsigned int perf_level)
>>  	return new_memtier;
>>  }
>>  
>> +static struct memory_tier *__node_get_memory_tier(int node)
>> +{
>> +	struct memory_tier *memtier;
>> +
>> +	list_for_each_entry(memtier, &memory_tiers, list) {
>> +		if (node_isset(node, memtier->nodelist))
>> +			return memtier;
>> +	}
>> +	return NULL;
>> +}
>> +
>> +static void init_node_memory_tier(int node)
> 
> set_node_memory_tier()?

That was done based on feedback from Alistair 

https://lore.kernel.org/linux-mm/87h73iapg1.fsf@nvdebian.thelocal


> 
>> +{
>> +	int perf_level;
>> +	struct memory_tier *memtier;
>> +
>> +	mutex_lock(&memory_tier_lock);
>> +
>> +	memtier = __node_get_memory_tier(node);
>> +	if (!memtier) {
>> +		perf_level = node_devices[node]->perf_level;
>> +		memtier = find_create_memory_tier(perf_level);
>> +		node_set(node, memtier->nodelist);
>> +	}
>> +	mutex_unlock(&memory_tier_lock);
>> +}
>> +
>> +static void clear_node_memory_tier(int node)
>> +{
>> +	struct memory_tier *memtier;
>> +
>> +	mutex_lock(&memory_tier_lock);
>> +	memtier = __node_get_memory_tier(node);
>> +	if (memtier)
>> +		node_clear(node, memtier->nodelist);
> 
> When memtier->nodelist becomes empty, we need to free memtier?
> 
>> +	mutex_unlock(&memory_tier_lock);
>> +}
>> +
>> +/*
>> + * This runs whether reclaim-based migration is enabled or not,
>> + * which ensures that the user can turn reclaim-based migration
>> + * at any time without needing to recalculate migration targets.
>> + */
> 
> The comments doesn't apply here.
> 
>> +static int __meminit migrate_on_reclaim_callback(struct notifier_block *self,
>> +						 unsigned long action, void *_arg)
> 
> Now we are building memory tiers instead of working on demotion.  So I
> think we should rename the function to memtier_hotplug_callback().
> 
>> +{
>> +	struct memory_notify *arg = _arg;
>> +
>> +	/*
>> +	 * Only update the node migration order when a node is
>> +	 * changing status, like online->offline.
>> +	 */
>> +	if (arg->status_change_nid < 0)
>> +		return notifier_from_errno(0);
>> +
>> +	switch (action) {
>> +	case MEM_OFFLINE:
>> +		clear_node_memory_tier(arg->status_change_nid);
>> +		break;
>> +	case MEM_ONLINE:
>> +		init_node_memory_tier(arg->status_change_nid);
>> +		break;
>> +	}
>> +
>> +	return notifier_from_errno(0);
>> +}
>> +
>> +static void __init migrate_on_reclaim_init(void)
>> +{
>> +	hotplug_memory_notifier(migrate_on_reclaim_callback, MEMTIER_HOTPLUG_PRIO);
>> +}
> 
> I suggest to call hotplug_memory_notifier() in memory_tier_init()
> directly.  We are not working on demotion here.
> 
>> +
>>  static int __init memory_tier_init(void)
>>  {
>>  	int node;
>> @@ -96,6 +169,8 @@ static int __init memory_tier_init(void)
>>  			node_property->perf_level = default_memtier_perf_level;
>>  	}
>>  	mutex_unlock(&memory_tier_lock);
>> +
>> +	migrate_on_reclaim_init();
>>  	return 0;
>>  }
>>  subsys_initcall(memory_tier_init);
> 
> Best Regards,
> Huang, Ying


Will update the patch in next iteration to take care of other feedback.

Thanks
-aneesh

