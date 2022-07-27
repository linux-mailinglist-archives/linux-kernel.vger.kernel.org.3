Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF18A581F09
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 06:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240386AbiG0EjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 00:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233245AbiG0Ei6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 00:38:58 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B493DF1D
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 21:38:57 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26R4Tcgd011016;
        Wed, 27 Jul 2022 04:38:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : content-type :
 mime-version; s=pp1; bh=7PkLLJfsngw7ZWteV9ZG6v5tDLrSl0UkFzTL7lb4Ess=;
 b=I6tnB+HigJUoLDUqbK/2M4zkykfMg7q26W69fXlwIcuPLDFF8rxapmOPsMoHgzWaUrcD
 Ae/z63LsSYUyb6BvB+uWVm+J2jvxNeBzhC/QkfPrCECDlgQGMKlp6jMj7wNi7AIXnrvG
 bIroX6FJ+KS6YivCQxs5BZnRu0JlhCKNwEc8+18sg9wNy1wzcqFT1gWCFMfwhvCX8G4h
 x8fHcyItGpuBQDvoPCrmXJeXkk1TeBOqlib+L2t3wspPUTHc3m6MDpqG8yi/3OumN5+U
 rLF2NynO2bFBzIGDXnJNye4S8pfCh/3lFn14xWiDsxPEG49FCcqjpMF5GVz/MS472qgX Zw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hjxcur6mk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Jul 2022 04:38:28 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 26R4Tta9011434;
        Wed, 27 Jul 2022 04:38:27 GMT
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hjxcur6ky-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Jul 2022 04:38:27 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26R4K1Cp007967;
        Wed, 27 Jul 2022 04:38:26 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma02wdc.us.ibm.com with ESMTP id 3hg97uexyb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Jul 2022 04:38:26 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26R4cPog1114744
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Jul 2022 04:38:25 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7570BAE060;
        Wed, 27 Jul 2022 04:38:25 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E5198AE05C;
        Wed, 27 Jul 2022 04:38:19 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.43.5.110])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 27 Jul 2022 04:38:19 +0000 (GMT)
X-Mailer: emacs 29.0.50 (via feedmail 11-beta-1 I)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     "Huang, Ying" <ying.huang@intel.com>,
        Alistair Popple <apopple@nvidia.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        Wei Xu <weixugc@google.com>, Yang Shi <shy828301@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim C Chen <tim.c.chen@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>, jvgediya.oss@gmail.com
Subject: Re: [PATCH v10 3/8] mm/demotion: Add hotplug callbacks to handle
 new numa node onlined
In-Reply-To: <87czdruxs0.fsf@yhuang6-desk2.ccr.corp.intel.com>
References: <20220720025920.1373558-1-aneesh.kumar@linux.ibm.com>
 <20220720025920.1373558-4-aneesh.kumar@linux.ibm.com>
 <87fsiowmdt.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <28582201-b438-9ac9-ca6b-1ee6e5794dd2@linux.ibm.com>
 <87czdruxs0.fsf@yhuang6-desk2.ccr.corp.intel.com>
Date:   Wed, 27 Jul 2022 10:08:16 +0530
Message-ID: <87h733rwzr.fsf@linux.ibm.com>
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: JOe4k0Eh7PPXbOycLuQEO_5le5QXvcEl
X-Proofpoint-ORIG-GUID: b0nmiTWrokmfvatE3ypJMmp47dUIXCve
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-26_07,2022-07-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 priorityscore=1501
 mlxlogscore=999 spamscore=0 mlxscore=0 adultscore=0 clxscore=1015
 impostorscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2206140000 definitions=main-2207270014
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Huang, Ying" <ying.huang@intel.com> writes:

> Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> writes:
>
>> On 7/26/22 9:33 AM, Huang, Ying wrote:
>>> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
>>> 
>>>> If the new NUMA node onlined doesn't have a performance level assigned,
>>>> the kernel adds the NUMA node to default memory tier.
>>>>
>>>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>>>> ---
>>>>  include/linux/memory-tiers.h |  1 +
>>>>  mm/memory-tiers.c            | 75 ++++++++++++++++++++++++++++++++++++
>>>>  2 files changed, 76 insertions(+)
>>>>
>>>> diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
>>>> index ef380a39db3a..3d5f14d57ae6 100644
>>>> --- a/include/linux/memory-tiers.h
>>>> +++ b/include/linux/memory-tiers.h
>>>> @@ -14,6 +14,7 @@
>>>>  #define MEMTIER_PERF_LEVEL_DRAM	(1 << (MEMTIER_CHUNK_BITS + 2))
>>>>  /* leave one tier below this slow pmem */
>>>>  #define MEMTIER_PERF_LEVEL_PMEM	(1 << MEMTIER_CHUNK_BITS)
>>>> +#define MEMTIER_HOTPLUG_PRIO	100
>>>>  
>>>>  extern bool numa_demotion_enabled;
>>>>  
>>>> diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
>>>> index 41a21cc5ae55..cc3a47ec18e4 100644
>>>> --- a/mm/memory-tiers.c
>>>> +++ b/mm/memory-tiers.c
>>>> @@ -5,6 +5,7 @@
>>>>  #include <linux/lockdep.h>
>>>>  #include <linux/moduleparam.h>
>>>>  #include <linux/node.h>
>>>> +#include <linux/memory.h>
>>>>  #include <linux/memory-tiers.h>
>>>>  
>>>>  struct memory_tier {
>>>> @@ -64,6 +65,78 @@ static struct memory_tier *find_create_memory_tier(unsigned int perf_level)
>>>>  	return new_memtier;
>>>>  }
>>>>  
>>>> +static struct memory_tier *__node_get_memory_tier(int node)
>>>> +{
>>>> +	struct memory_tier *memtier;
>>>> +
>>>> +	list_for_each_entry(memtier, &memory_tiers, list) {
>>>> +		if (node_isset(node, memtier->nodelist))
>>>> +			return memtier;
>>>> +	}
>>>> +	return NULL;
>>>> +}
>>>> +
>>>> +static void init_node_memory_tier(int node)
>>> 
>>> set_node_memory_tier()?
>>
>> That was done based on feedback from Alistair 
>>
>> https://lore.kernel.org/linux-mm/87h73iapg1.fsf@nvdebian.thelocal
>>
>>> 
>>>> +{
>>>> +	int perf_level;
>>>> +	struct memory_tier *memtier;
>>>> +
>>>> +	mutex_lock(&memory_tier_lock);
>>>> +
>>>> +	memtier = __node_get_memory_tier(node);
>>>> +	if (!memtier) {
>>>> +		perf_level = node_devices[node]->perf_level;
>>>> +		memtier = find_create_memory_tier(perf_level);
>>>> +		node_set(node, memtier->nodelist);
>>>> +	}
>
> It's related to Alistair's comments too.  When will memtier != NULL
> here?  We may need just VM_WARN_ON() here?

When the platform driver sets memory tier directly. With the old code
it can happen when dax/kmem register a node to a memory tier. With
memory_type proposal this can happen if the node is part of memory
type that is already added to a memory tier. 

>
>>>> +	mutex_unlock(&memory_tier_lock);
>>>> +}
>>>> +
>>>> +static void clear_node_memory_tier(int node)
>>>> +{
>>>> +	struct memory_tier *memtier;
>>>> +
>>>> +	mutex_lock(&memory_tier_lock);
>>>> +	memtier = __node_get_memory_tier(node);
>>>> +	if (memtier)
>>>> +		node_clear(node, memtier->nodelist);
>>> 
>>> When memtier->nodelist becomes empty, we need to free memtier?
>>> 
>>>> +	mutex_unlock(&memory_tier_lock);
>>>> +}
>>>> +
>>>> +/*
>>>> + * This runs whether reclaim-based migration is enabled or not,
>>>> + * which ensures that the user can turn reclaim-based migration
>>>> + * at any time without needing to recalculate migration targets.
>>>> + */
>>> 
>>> The comments doesn't apply here.
>>> 
>>>> +static int __meminit migrate_on_reclaim_callback(struct notifier_block *self,
>>>> +						 unsigned long action, void *_arg)
>>> 
>>> Now we are building memory tiers instead of working on demotion.  So I
>>> think we should rename the function to memtier_hotplug_callback().
>>> 
>>>> +{
>>>> +	struct memory_notify *arg = _arg;
>>>> +
>>>> +	/*
>>>> +	 * Only update the node migration order when a node is
>>>> +	 * changing status, like online->offline.
>>>> +	 */
>>>> +	if (arg->status_change_nid < 0)
>>>> +		return notifier_from_errno(0);
>>>> +
>>>> +	switch (action) {
>>>> +	case MEM_OFFLINE:
>>>> +		clear_node_memory_tier(arg->status_change_nid);
>>>> +		break;
>>>> +	case MEM_ONLINE:
>>>> +		init_node_memory_tier(arg->status_change_nid);
>>>> +		break;
>>>> +	}
>>>> +
>>>> +	return notifier_from_errno(0);
>>>> +}
>>>> +
>>>> +static void __init migrate_on_reclaim_init(void)
>>>> +{
>>>> +	hotplug_memory_notifier(migrate_on_reclaim_callback, MEMTIER_HOTPLUG_PRIO);
>>>> +}
>>> 
>>> I suggest to call hotplug_memory_notifier() in memory_tier_init()
>>> directly.  We are not working on demotion here.
>>> 
>>>> +
>>>>  static int __init memory_tier_init(void)
>>>>  {
>>>>  	int node;
>>>> @@ -96,6 +169,8 @@ static int __init memory_tier_init(void)
>>>>  			node_property->perf_level = default_memtier_perf_level;
>>>>  	}
>>>>  	mutex_unlock(&memory_tier_lock);
>>>> +
>>>> +	migrate_on_reclaim_init();
>>>>  	return 0;
>>>>  }
>>>>  subsys_initcall(memory_tier_init);
>>> 
>>> Best Regards,
>>> Huang, Ying
>>
>>
>> Will update the patch in next iteration to take care of other feedback.
>
> Thanks!
>
> Best Regards,
> Huang, Ying
