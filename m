Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A39658D337
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 07:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234719AbiHIFeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 01:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbiHIFef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 01:34:35 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4363C17A9B
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 22:34:34 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2795Nw0h007796;
        Tue, 9 Aug 2022 05:34:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=/7Op0SDmAucXIzTtF4ws6gTT63IRBMOXdXdJVJa8Q7s=;
 b=ZqZ+v0xuro9UDZZ6pm4iPP5i2wpzydkmF/1yHX6CcLRKY6ATTGuPais2hWifoGvUGp32
 R7spqVtFruRAEGBj93fCPzn7/cLyY8rIwj+QOTbaMzAHM9xTI0NJLXd8OZ4wW8ZW5i8H
 z21N820EHLIB/Uh8cRy0EAe46B7it+C+nM/V8kMUZ9WxP6whA99EirShvEfSpXQjxrI4
 Gq3TIIJNCn9WyW+xi680skAz2EwgBQiT1NEZX79c4Oe5ZskNkvmawcchNxIYBxEG+1W0
 C5557Kbw3YOG+ChydAutyLdGl1o03FraX7A+fMvWKzij4uO6lh6EWM7iXXVv+y3oFqHG qg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3huhd107a4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Aug 2022 05:34:20 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2795OZMb010627;
        Tue, 9 Aug 2022 05:34:20 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3huhd1079f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Aug 2022 05:34:20 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2795LDse014372;
        Tue, 9 Aug 2022 05:34:18 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 3hu4rp8mrq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Aug 2022 05:34:18 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2795YGPA33096052
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 9 Aug 2022 05:34:16 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 22FF5AE04D;
        Tue,  9 Aug 2022 05:34:16 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C6655AE045;
        Tue,  9 Aug 2022 05:34:12 +0000 (GMT)
Received: from [9.109.205.170] (unknown [9.109.205.170])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  9 Aug 2022 05:34:12 +0000 (GMT)
Message-ID: <e9c1d9e2-251a-1e17-3dd5-4e5fc2a62757@linux.ibm.com>
Date:   Tue, 9 Aug 2022 11:04:11 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v13 1/9] mm/demotion: Add support for explicit memory
 tiers
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
 <20220808062601.836025-2-aneesh.kumar@linux.ibm.com>
 <87sfm6gotr.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
In-Reply-To: <87sfm6gotr.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: P1QL-dScocUkPuhw1LNaLEoR2Hm60lXs
X-Proofpoint-ORIG-GUID: ykTwLxnC0a-SB0LP137Ko4x1ZyKm-MCL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-08_14,2022-08-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 phishscore=0 spamscore=0 mlxlogscore=999 suspectscore=0 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

On 8/9/22 7:28 AM, Huang, Ying wrote:
> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
> 
>> In the current kernel, memory tiers are defined implicitly via a demotion path
>> relationship between NUMA nodes, which is created during the kernel
>> initialization and updated when a NUMA node is hot-added or hot-removed. The
>> current implementation puts all nodes with CPU into the highest tier, and builds
>> the tier hierarchy by establishing the per-node demotion targets based on the
>> distances between nodes.
>>
>> This current memory tier kernel implementation needs to be improved for several
>> important use cases,
>>
>> The current tier initialization code always initializes each memory-only NUMA
>> node into a lower tier. But a memory-only NUMA node may have a high performance
>> memory device (e.g. a DRAM-backed memory-only node on a virtual machine) that
>> should be put into a higher tier.
>>
>> The current tier hierarchy always puts CPU nodes into the top tier. But on a
>> system with HBM or GPU devices, the memory-only NUMA nodes mapping these devices
>> should be in the top tier, and DRAM nodes with CPUs are better to be placed into
>> the next lower tier.
>>
>> With current kernel higher tier node can only be demoted to nodes with shortest
>> distance on the next lower tier as defined by the demotion path, not any other
>> node from any lower tier. This strict, demotion order does not work in all use
>> cases (e.g. some use cases may want to allow cross-socket demotion to another
>> node in the same demotion tier as a fallback when the preferred demotion node is
>> out of space), This demotion order is also inconsistent with the page allocation
>> fallback order when all the nodes in a higher tier are out of space: The page
>> allocation can fall back to any node from any lower tier, whereas the demotion
>> order doesn't allow that.
>>
>> This patch series address the above by defining memory tiers explicitly.
>>
>> Linux kernel presents memory devices as NUMA nodes and each memory device is of
>> a specific type. The memory type of a device is represented by its abstract
>> distance. A memory tier corresponds to a range of abstract distance. This allows
>> for classifying memory devices with a specific performance range into a memory
>> tier.
>>
>> This patch configures the range/chunk size to be 128. The default DRAM abstract
>> distance is 512. We can have 4 memory tiers below the default DRAM with abstract
>> distance range 0 - 127, 127 - 255, 256- 383, 384 - 511. Faster memory devices
>> can be placed in these faster(higher) memory tiers. Slower memory devices like
>> persistent memory will have abstract distance higher than the default DRAM
>> level.
>>
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>> ---
>>  include/linux/memory-tiers.h |  15 +++++
>>  mm/Makefile                  |   1 +
>>  mm/memory-tiers.c            | 107 +++++++++++++++++++++++++++++++++++
>>  3 files changed, 123 insertions(+)
>>  create mode 100644 include/linux/memory-tiers.h
>>  create mode 100644 mm/memory-tiers.c
>>
>> diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
>> new file mode 100644
>> index 000000000000..bc7c1b799bef
>> --- /dev/null
>> +++ b/include/linux/memory-tiers.h
>> @@ -0,0 +1,15 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef _LINUX_MEMORY_TIERS_H
>> +#define _LINUX_MEMORY_TIERS_H
>> +
>> +/*
>> + * Each tier cover a abstrace distance chunk size of 128
>> + */
>> +#define MEMTIER_CHUNK_BITS	7
>> +#define MEMTIER_CHUNK_SIZE	(1 << MEMTIER_CHUNK_BITS)
>> +/*
>> + * Smaller abstract distance value imply faster(higher) memory tiers.
>> + */
>> +#define MEMTIER_ADISTANCE_DRAM	(4 * MEMTIER_CHUNK_SIZE)
>> +
>> +#endif  /* _LINUX_MEMORY_TIERS_H */
>> diff --git a/mm/Makefile b/mm/Makefile
>> index 6f9ffa968a1a..d30acebc2164 100644
>> --- a/mm/Makefile
>> +++ b/mm/Makefile
>> @@ -92,6 +92,7 @@ obj-$(CONFIG_KFENCE) += kfence/
>>  obj-$(CONFIG_FAILSLAB) += failslab.o
>>  obj-$(CONFIG_MEMTEST)		+= memtest.o
>>  obj-$(CONFIG_MIGRATION) += migrate.o
>> +obj-$(CONFIG_NUMA) += memory-tiers.o
>>  obj-$(CONFIG_DEVICE_MIGRATION) += migrate_device.o
>>  obj-$(CONFIG_TRANSPARENT_HUGEPAGE) += huge_memory.o khugepaged.o
>>  obj-$(CONFIG_PAGE_COUNTER) += page_counter.o
>> diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
>> new file mode 100644
>> index 000000000000..78b311d9bde9
>> --- /dev/null
>> +++ b/mm/memory-tiers.c
>> @@ -0,0 +1,107 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +#include <linux/types.h>
>> +#include <linux/nodemask.h>
>> +#include <linux/slab.h>
>> +#include <linux/lockdep.h>
>> +#include <linux/memory-tiers.h>
>> +
>> +struct memory_tier {
>> +	/* hierarchy of memory tiers */
>> +	struct list_head list;
>> +	/* list of all memory types part of this tier */
>> +	struct list_head memory_types;
>> +	/*
>> +	 * start value of abstract distance. memory tier maps
>> +	 * an abstract distance  range,
>> +	 * adistance_start .. adistance_start + MEMTIER_CHUNK_SIZE
>> +	 */
>> +	int adistance_start;
>> +};
>> +
>> +struct memory_dev_type {
>> +	/* list of memory types that are part of same tier as this type */
>> +	struct list_head tier_sibiling;
>> +	/* abstract distance for this specific memory type */
>> +	int adistance;
>> +	/* Nodes of same abstract distance */
>> +	nodemask_t nodes;
>> +	struct memory_tier *memtier;
>> +};
>> +
>> +static DEFINE_MUTEX(memory_tier_lock);
>> +static LIST_HEAD(memory_tiers);
>> +static struct memory_dev_type *node_memory_types[MAX_NUMNODES];
>> +/*
>> + * For now let's have 4 memory tier below default DRAM tier.
>> + */
>> +static struct memory_dev_type default_dram_type  = {
>> +	.adistance = MEMTIER_ADISTANCE_DRAM,
>> +	.tier_sibiling = LIST_HEAD_INIT(default_dram_type.tier_sibiling),
>> +};
>> +
>> +static struct memory_tier *find_create_memory_tier(struct memory_dev_type *memtype)
>> +{
>> +	bool found_slot = false;
>> +	struct memory_tier *memtier, *new_memtier;
>> +	int adistance = memtype->adistance;
>> +	unsigned int memtier_adistance_chunk_size = MEMTIER_CHUNK_SIZE;
>> +
>> +	lockdep_assert_held_once(&memory_tier_lock);
>> +
>> +	/*
>> +	 * If the memtype is already part of a memory tier,
>> +	 * just return that.
>> +	 */
>> +	if (memtype->memtier)
>> +		return memtype->memtier;
>> +
>> +	adistance = round_down(adistance, memtier_adistance_chunk_size);
>> +	list_for_each_entry(memtier, &memory_tiers, list) {
>> +		if (adistance == memtier->adistance_start) {
>> +			memtype->memtier = memtier;
>> +			list_add(&memtype->tier_sibiling, &memtier->memory_types);
>> +			return memtier;
>> +		} else if (adistance < memtier->adistance_start) {
>> +			found_slot = true;
>> +			break;
>> +		}
>> +	}
>> +
>> +	new_memtier = kmalloc(sizeof(struct memory_tier), GFP_KERNEL);
>> +	if (!new_memtier)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	new_memtier->adistance_start = adistance;
>> +	INIT_LIST_HEAD(&new_memtier->list);
>> +	INIT_LIST_HEAD(&new_memtier->memory_types);
>> +	if (found_slot)
>> +		list_add_tail(&new_memtier->list, &memtier->list);
>> +	else
>> +		list_add_tail(&new_memtier->list, &memory_tiers);
>> +	memtype->memtier = new_memtier;
>> +	list_add(&memtype->tier_sibiling, &new_memtier->memory_types);
>> +	return new_memtier;
>> +}
>> +
>> +static int __init memory_tier_init(void)
>> +{
>> +	int node;
>> +	struct memory_tier *memtier;
>> +
>> +	mutex_lock(&memory_tier_lock);
>> +	/* CPU only nodes are not part of memory tiers. */
>> +	default_dram_type.nodes = node_states[N_MEMORY];
>> +
>> +	memtier = find_create_memory_tier(&default_dram_type);
>> +	if (IS_ERR(memtier))
>> +		panic("%s() failed to register memory tier: %ld\n",
>> +		      __func__, PTR_ERR(memtier));
>> +
>> +	for_each_node_state(node, N_MEMORY)
>> +		node_memory_types[node] = &default_dram_type;
> 
> Although not absolutely necessary, it seems better to set
> node_memory_types[] before adding nodes to the memory type and adding
> the memory type to the memory tier.
> 
> 

updated. 

-aneesh
