Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C22358D336
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 07:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234501AbiHIFdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 01:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbiHIFdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 01:33:53 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B47D217A9B
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 22:33:51 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2795E2f3023195;
        Tue, 9 Aug 2022 05:33:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=XGYkTpconbzQwmprRkeEYJbDaMMfqoEFq3tXmLIDmz8=;
 b=Gj1oDnwsF9BV0Hl6ew/gGaS+ErlpxMd33E09wtHNS+s0/cxYBojyR1iqlbgGkc3noK80
 ZG1fGcdDA82DLkUFLeaooxh2h4qXycUunmsXCkMZjhg7rw8vFoYZcgjmX1xBWxhT9PbJ
 7ziCSVz+uNyl7R4bapME/aJ8q20uhS+dmcUMxQO7ui40ZKxO3LLrg+0ZfD7LKN4zsyPa
 NHyCOrFfil97o9Bxqh3A+az50Lh1qjUWKur2f4e+IsXpyiDKNKhv3r/0nWi5vl/QKi/Z
 lfG1PjdTIGoHk8oHM1FoQnOELpCfWhG8bdjODi700+9/po3XGSrGdt8LSSh3UuvB4aMC pQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3huh8h0ecf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Aug 2022 05:33:32 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2795Qkap008533;
        Tue, 9 Aug 2022 05:33:32 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3huh8h0ebq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Aug 2022 05:33:32 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2795L1uX014697;
        Tue, 9 Aug 2022 05:33:30 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03fra.de.ibm.com with ESMTP id 3hsfx8t8ct-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Aug 2022 05:33:29 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2795XRBU17957330
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 9 Aug 2022 05:33:27 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8FBEBAE051;
        Tue,  9 Aug 2022 05:33:27 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A8E47AE045;
        Tue,  9 Aug 2022 05:33:23 +0000 (GMT)
Received: from [9.109.205.170] (unknown [9.109.205.170])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  9 Aug 2022 05:33:23 +0000 (GMT)
Message-ID: <46c8d7c2-004f-1945-8614-2452d4f28d2a@linux.ibm.com>
Date:   Tue, 9 Aug 2022 11:03:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v13 4/9] mm/demotion/dax/kmem: Set node's abstract
 distance to MEMTIER_DEFAULT_DAX_ADISTANCE
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
References: <20220808062601.836025-1-aneesh.kumar@linux.ibm.com>
 <20220808062601.836025-5-aneesh.kumar@linux.ibm.com>
 <87o7wuglrq.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
In-Reply-To: <87o7wuglrq.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hscxkpJ5fQdklaDEybTpRhkBaKAqHwWE
X-Proofpoint-ORIG-GUID: vs7jF0D1wkL5bZWRoNAwP60jSpAa-RaF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-08_14,2022-08-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 mlxscore=0 suspectscore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208090023
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/9/22 8:34 AM, Huang, Ying wrote:
> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
> 
>> By default, all nodes are assigned to the default memory tier which
>> is the memory tier designated for nodes with DRAM
>>
>> Set dax kmem device node's tier to slower memory tier by assigning
>> abstract distance to MEMTIER_DEFAULT_DAX_ADISTANCE. Low-level drivers
>> like papr_scm or ACPI NFIT can initialize memory device type to a
>> more accurate value based on device tree details or HMAT.
> 
> I don't know how ACPI NFIT can help here.  Can you teach me?
> 
> Per my understanding, we may use the information provided by ACPI SLIT
> or HMAT (or device tree via papr_scm) to create memory types.  Before
> that is implemented, we just create a memory type with default abstract
> distance.
> 

My idea is to use ACPI NFIT driver that creates a persistent memory region
(nvdimm_region_create) to also create memory type and assign that to the
NUMA node mapping that region. For now NFIT driver manages all the persistent
memory region/DIMM creation (drivers/acpi/nfit/core.c). It can also do the
memory type creation using other ACPI information like SLIT/HMAT etc. Similarly
CXL driver can do the same using CDAT.



>> If the
>> kernel doesn't find the memory type initialized, a default slower
>> memory type is assigned by the kmem driver.
>>
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>> ---
>>  drivers/dax/kmem.c           | 40 ++++++++++++++++++-
>>  include/linux/memory-tiers.h | 26 ++++++++++++-
>>  mm/memory-tiers.c            | 74 +++++++++++++++++++++++++-----------
>>  3 files changed, 115 insertions(+), 25 deletions(-)
>>
>> diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
>> index a37622060fff..b5cb03307af8 100644
>> --- a/drivers/dax/kmem.c
>> +++ b/drivers/dax/kmem.c
>> @@ -11,9 +11,17 @@
>>  #include <linux/fs.h>
>>  #include <linux/mm.h>
>>  #include <linux/mman.h>
>> +#include <linux/memory-tiers.h>
>>  #include "dax-private.h"
>>  #include "bus.h"
>>  
>> +/*
>> + * Default abstract distance assigned to the NUMA node onlined
>> + * by DAX/kmem if the low level platform driver didn't initialize
>> + * one for this NUMA node.
>> + */
> 
> We have 2 choices here.
> 
> 1. The low level drivers create memory types and set
> node_memory_types[].  We need a mechanism to coordinate among multiple
> drivers.  On x86, we have ACPI SLIT, HMAT.  And we have platform
> independent CXL defined CDAT.
> 
> 2. The high level driver (such as dax/kmem.c) coordinate among multiple
> low level drivers.  For example, it may query CXL CDAT firstly, and use
> a notifier chain to query platform drivers with priority.
> 
> Personally, I prefer choice 2.  We can discuss this later.  But can we
> make the comments more general to avoid to make decision now?
> 
>> +#define MEMTIER_DEFAULT_DAX_ADISTANCE	(MEMTIER_ADISTANCE_DRAM * 2)
>> +
>>  /* Memory resource name used for add_memory_driver_managed(). */
>>  static const char *kmem_name;
>>  /* Set if any memory will remain added when the driver will be unloaded. */
>> @@ -41,6 +49,7 @@ struct dax_kmem_data {
>>  	struct resource *res[];
>>  };
>>  
>> +static struct memory_dev_type *dax_slowmem_type;
> 
> I don't think "slowmem" make much sense here.  There may be even slower
> memory.  Just dax_mem_type or dax_kmem_type should be OK?
> 

Dan Williams had a question about why we are adding an abstract distance slower than DRAM in
dax/kmem where we can also initialize faster than DRAM memory using kmem. The
"slowmem" was added to indicate that this type is slower than DRAM.

>>  static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
>>  {
>>  	struct device *dev = &dev_dax->dev;
>> @@ -62,6 +71,8 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
>>  		return -EINVAL;
>>  	}
>>  
>> +	init_node_memory_type(numa_node, dax_slowmem_type);
>> +
> 
> I don't find error handling in this function.  Per my understanding, if
> memory hot-add fails, we need to call clear_node_memory_type().
> 

Added

>>  	for (i = 0; i < dev_dax->nr_range; i++) {
>>  		struct range range;
>>  
>> @@ -162,6 +173,7 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
>>  static void dev_dax_kmem_remove(struct dev_dax *dev_dax)
>>  {
>>  	int i, success = 0;
>> +	int node = dev_dax->target_node;
>>  	struct device *dev = &dev_dax->dev;
>>  	struct dax_kmem_data *data = dev_get_drvdata(dev);
>>  
>> @@ -198,6 +210,14 @@ static void dev_dax_kmem_remove(struct dev_dax *dev_dax)
>>  		kfree(data->res_name);
>>  		kfree(data);
>>  		dev_set_drvdata(dev, NULL);
>> +		/*
>> +		 * Clear the memtype association on successful unplug.
>> +		 * If not, we have memory blocks left which can be
>> +		 * offlined/onlined later. We need to keep memory_dev_type
>> +		 * for that. This implies this reference will be around
>> +		 * till next reboot.
>> +		 */
>> +		clear_node_memory_type(node, dax_slowmem_type);
>>  	}
>>  }
>>  #else
>> @@ -228,9 +248,27 @@ static int __init dax_kmem_init(void)
>>  	if (!kmem_name)
>>  		return -ENOMEM;
>>  
>> +	dax_slowmem_type = kmalloc(sizeof(*dax_slowmem_type), GFP_KERNEL);
>> +	if (!dax_slowmem_type) {
>> +		rc = -ENOMEM;
>> +		goto kmem_name_free;
>> +	}
>> +	dax_slowmem_type->adistance = MEMTIER_DEFAULT_DAX_ADISTANCE;
>> +	INIT_LIST_HEAD(&dax_slowmem_type->tier_sibiling);
>> +	dax_slowmem_type->nodes  = NODE_MASK_NONE;
>> +	dax_slowmem_type->memtier = NULL;
>> +	kref_init(&dax_slowmem_type->kref);
>> +
> 
> Here we initialize the kref to 1.  So in dax_kmem_exit() we should drop
> the last reference, otherwise we cannot free the memory type?
> 

Add the required destroy to dax_kmem_exit()

>>  	rc = dax_driver_register(&device_dax_kmem_driver);
>>  	if (rc)
>> -		kfree_const(kmem_name);
>> +		goto error_out;
>> +
>> +	return rc;
>> +
>> +error_out:
>> +	kfree(dax_slowmem_type);
>> +kmem_name_free:
>> +	kfree_const(kmem_name);
>>  	return rc;
>>  }
>>  
>> diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
>> index cc89876899a6..7bf6f47d581a 100644
>> --- a/include/linux/memory-tiers.h
>> +++ b/include/linux/memory-tiers.h
>> @@ -2,6 +2,8 @@
>>  #ifndef _LINUX_MEMORY_TIERS_H
>>  #define _LINUX_MEMORY_TIERS_H
>>  
>> +#include <linux/types.h>
>> +#include <linux/nodemask.h>
>>  /*
>>   * Each tier cover a abstrace distance chunk size of 128
>>   */
>> @@ -13,12 +15,34 @@
>>  #define MEMTIER_ADISTANCE_DRAM	(4 * MEMTIER_CHUNK_SIZE)
>>  #define MEMTIER_HOTPLUG_PRIO	100
>>  
>> +struct memory_tier;
>> +struct memory_dev_type {
>> +	/* list of memory types that are part of same tier as this type */
>> +	struct list_head tier_sibiling;
>> +	/* abstract distance for this specific memory type */
>> +	int adistance;
>> +	/* Nodes of same abstract distance */
>> +	nodemask_t nodes;
>> +	struct kref kref;
>> +	struct memory_tier *memtier;
>> +};
>> +
>>  #ifdef CONFIG_NUMA
>> -#include <linux/types.h>
>>  extern bool numa_demotion_enabled;
>> +void init_node_memory_type(int node, struct memory_dev_type *default_type);
>> +void clear_node_memory_type(int node, struct memory_dev_type *memtype);
>>  
>>  #else
>>  
>>  #define numa_demotion_enabled	false
>> +static inline void init_node_memory_type(int node, struct memory_dev_type *default_type)
>> +{
>> +
>> +}
>> +
>> +static inline void clear_node_memory_type(int node, struct memory_dev_type *memtype)
>> +{
>> +
>> +}
>>  #endif	/* CONFIG_NUMA */
>>  #endif  /* _LINUX_MEMORY_TIERS_H */
>> diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
>> index 2caa5ab446b8..e07dffb67567 100644
>> --- a/mm/memory-tiers.c
>> +++ b/mm/memory-tiers.c
>> @@ -1,6 +1,4 @@
>>  // SPDX-License-Identifier: GPL-2.0
>> -#include <linux/types.h>
>> -#include <linux/nodemask.h>
>>  #include <linux/slab.h>
>>  #include <linux/lockdep.h>
>>  #include <linux/sysfs.h>
>> @@ -21,26 +19,10 @@ struct memory_tier {
>>  	int adistance_start;
>>  };
>>  
>> -struct memory_dev_type {
>> -	/* list of memory types that are part of same tier as this type */
>> -	struct list_head tier_sibiling;
>> -	/* abstract distance for this specific memory type */
>> -	int adistance;
>> -	/* Nodes of same abstract distance */
>> -	nodemask_t nodes;
>> -	struct memory_tier *memtier;
>> -};
>> -
>>  static DEFINE_MUTEX(memory_tier_lock);
>>  static LIST_HEAD(memory_tiers);
>>  static struct memory_dev_type *node_memory_types[MAX_NUMNODES];
>> -/*
>> - * For now let's have 4 memory tier below default DRAM tier.
>> - */
>> -static struct memory_dev_type default_dram_type  = {
>> -	.adistance = MEMTIER_ADISTANCE_DRAM,
>> -	.tier_sibiling = LIST_HEAD_INIT(default_dram_type.tier_sibiling),
>> -};
>> +static struct memory_dev_type *default_dram_type;
>>  
>>  static struct memory_tier *find_create_memory_tier(struct memory_dev_type *memtype)
>>  {
>> @@ -96,6 +78,14 @@ static struct memory_tier *__node_get_memory_tier(int node)
>>  	return NULL;
>>  }
>>  
>> +static inline void __init_node_memory_type(int node, struct memory_dev_type *default_type)
>> +{
>> +	if (!node_memory_types[node]) {
>> +		node_memory_types[node] = default_type;
>> +		kref_get(&default_type->kref);
>> +	}
>> +}
>> +
>>  static struct memory_tier *set_node_memory_tier(int node)
>>  {
>>  	struct memory_tier *memtier;
>> @@ -107,7 +97,7 @@ static struct memory_tier *set_node_memory_tier(int node)
>>  		return ERR_PTR(-EINVAL);
>>  
>>  	if (!node_memory_types[node])
>> -		node_memory_types[node] = &default_dram_type;
>> +		__init_node_memory_type(node, default_dram_type);
>>  
>>  	memtype = node_memory_types[node];
>>  	node_set(node, memtype->nodes);
>> @@ -143,6 +133,34 @@ static bool clear_node_memory_tier(int node)
>>  	return cleared;
>>  }
>>  
>> +void init_node_memory_type(int node, struct memory_dev_type *default_type)
>> +{
>> +
>> +	mutex_lock(&memory_tier_lock);
>> +	__init_node_memory_type(node, default_type);
>> +	mutex_unlock(&memory_tier_lock);
>> +}
>> +EXPORT_SYMBOL_GPL(init_node_memory_type);
>> +
>> +static void release_memtype(struct kref *kref)
>> +{
>> +	struct memory_dev_type *memtype;
>> +
>> +	memtype = container_of(kref, struct memory_dev_type, kref);
>> +	kfree(memtype);
>> +}
>> +
>> +void clear_node_memory_type(int node, struct memory_dev_type *memtype)
>> +{
>> +	mutex_lock(&memory_tier_lock);
>> +	if (node_memory_types[node] == memtype) {
>> +		node_memory_types[node] = NULL;
>> +		kref_put(&memtype->kref, release_memtype);
>> +	}
>> +	mutex_unlock(&memory_tier_lock);
>> +}
>> +EXPORT_SYMBOL_GPL(clear_node_memory_type);
>> +
>>  static int __meminit memtier_hotplug_callback(struct notifier_block *self,
>>  					      unsigned long action, void *_arg)
>>  {
>> @@ -176,17 +194,27 @@ static int __init memory_tier_init(void)
>>  	int node;
>>  	struct memory_tier *memtier;
>>  
>> +	default_dram_type = kmalloc(sizeof(*default_dram_type), GFP_KERNEL);
>> +	if (!default_dram_type)
>> +		panic("%s() failed to allocate default DRAM tier\n", __func__);
>> +
>>  	mutex_lock(&memory_tier_lock);
>> +
>> +	/* For now let's have 4 memory tier below default DRAM tier. */
>> +	default_dram_type->adistance = MEMTIER_ADISTANCE_DRAM;
>> +	INIT_LIST_HEAD(&default_dram_type->tier_sibiling);
>> +	default_dram_type->memtier = NULL;
>> +	kref_init(&default_dram_type->kref);
> 
> It appears that we can define a function to initialize a memory type.

I added  the below

static inline struct memory_dev_type *alloc_memory_type(int adistance)
static inline void destroy_memory_type(struct memory_dev_type *memtype)


> 
>>  	/* CPU only nodes are not part of memory tiers. */
>> -	default_dram_type.nodes = node_states[N_MEMORY];
>> +	default_dram_type->nodes = node_states[N_MEMORY];
>>  
>> -	memtier = find_create_memory_tier(&default_dram_type);
>> +	memtier = find_create_memory_tier(default_dram_type);
>>  	if (IS_ERR(memtier))
>>  		panic("%s() failed to register memory tier: %ld\n",
>>  		      __func__, PTR_ERR(memtier));
>>  
>>  	for_each_node_state(node, N_MEMORY)
>> -		node_memory_types[node] = &default_dram_type;
>> +		__init_node_memory_type(node, default_dram_type);
>>  
>>  	mutex_unlock(&memory_tier_lock);
> 
> Best Regards,
> Huang, Ying

