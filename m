Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECE6B547E2C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 05:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232854AbiFMDcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 23:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232067AbiFMDcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 23:32:39 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB0210557
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 20:32:36 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25D0QFW8008319;
        Mon, 13 Jun 2022 03:32:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=O1XbGFnlCnNqAJ4x+1ENWzSNyTHw+ipMVsB08F8c21c=;
 b=oa/h/IYfoN6rolrOke/Qfhm68FHjEqm7Wm2Ut0qDKdqIwPeLhmmXoTcMP+rwzsLZPgGs
 /5Ohwcg7CVQZvcNnG9Fcb9NtRzK2DI9ODj+YCOeQHNcgCUeYk855+U5TVMi7Cf3VQVf7
 rN7dpLLqN9QKbNH8NV8O/844+w19RWRV+VHoIl7pn2y19vihjyqY1637Ae8F/zGCpm52
 YPP7Pm21I2PYFuq818oRL1sfW+8idqMwhJdbRltfIGvhKZ11ZigdHAwK8o80eQ1zJYXl
 rf3jE28Nbb7EEAe9T4mvRByG5OIF+SsHD6yK1LbOCCYWJAuXDEGa7bxuSA2C97fREkJY Qg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gn4btfc90-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Jun 2022 03:32:15 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25D3Ja3U011712;
        Mon, 13 Jun 2022 03:32:14 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gn4btfc8k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Jun 2022 03:32:14 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25D3MZIk002857;
        Mon, 13 Jun 2022 03:32:12 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma05fra.de.ibm.com with ESMTP id 3gmjp91jx7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Jun 2022 03:32:11 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25D3W9Pg8126950
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jun 2022 03:32:09 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7351FA4060;
        Mon, 13 Jun 2022 03:32:09 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BCAA1A4054;
        Mon, 13 Jun 2022 03:32:02 +0000 (GMT)
Received: from [9.43.31.74] (unknown [9.43.31.74])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 13 Jun 2022 03:32:02 +0000 (GMT)
Message-ID: <48096ad7-ce6d-79b7-1edd-7e6652ab2a4d@linux.ibm.com>
Date:   Mon, 13 Jun 2022 09:01:58 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v6 01/13] mm/demotion: Add support for explicit memory
 tiers
Content-Language: en-US
To:     Ying Huang <ying.huang@intel.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org
Cc:     Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
        Yang Shi <shy828301@gmail.com>,
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
        David Rientjes <rientjes@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>
References: <20220610135229.182859-1-aneesh.kumar@linux.ibm.com>
 <20220610135229.182859-2-aneesh.kumar@linux.ibm.com>
 <7e0b41422dbd0976cb43c2f126e9371d5e311e77.camel@intel.com>
From:   Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
In-Reply-To: <7e0b41422dbd0976cb43c2f126e9371d5e311e77.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Hp6Dj36l1juEk5fbgm7Vp18W2W9eSOUc
X-Proofpoint-GUID: yRqkQc2H8B2vgrDrHlttqJWCV1477nYJ
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-13_01,2022-06-09_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 suspectscore=0 mlxlogscore=993 spamscore=0 bulkscore=0 mlxscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206130014
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/13/22 8:52 AM, Ying Huang wrote:
> Hi, Aneesh,
> 
> On Fri, 2022-06-10 at 19:22 +0530, Aneesh Kumar K.V wrote:
>> In the current kernel, memory tiers are defined implicitly via a
>> demotion path relationship between NUMA nodes, which is created
>> during the kernel initialization and updated when a NUMA node is
>> hot-added or hot-removed.  The current implementation puts all
>> nodes with CPU into the top tier, and builds the tier hierarchy
>> tier-by-tier by establishing the per-node demotion targets based
>> on the distances between nodes.
>>
>> This current memory tier kernel interface needs to be improved for
>> several important use cases,
>>
>> The current tier initialization code always initializes
>> each memory-only NUMA node into a lower tier.  But a memory-only
>> NUMA node may have a high performance memory device (e.g. a DRAM
>> device attached via CXL.mem or a DRAM-backed memory-only node on
>> a virtual machine) and should be put into a higher tier.
>>
>> The current tier hierarchy always puts CPU nodes into the top
>> tier. But on a system with HBM or GPU devices, the
>> memory-only NUMA nodes mapping these devices should be in the
>> top tier, and DRAM nodes with CPUs are better to be placed into the
>> next lower tier.
>>
>> With current kernel higher tier node can only be demoted to selected nodes on the
>> next lower tier as defined by the demotion path, not any other
>> node from any lower tier.  This strict, hard-coded demotion order
>> does not work in all use cases (e.g. some use cases may want to
>> allow cross-socket demotion to another node in the same demotion
>> tier as a fallback when the preferred demotion node is out of
>> space), This demotion order is also inconsistent with the page
>> allocation fallback order when all the nodes in a higher tier are
>> out of space: The page allocation can fall back to any node from
>> any lower tier, whereas the demotion order doesn't allow that.
>>
>> The current kernel also don't provide any interfaces for the
>> userspace to learn about the memory tier hierarchy in order to
>> optimize its memory allocations.
>>
>> This patch series address the above by defining memory tiers explicitly.
>>
>> This patch introduce explicity memory tiers with ranks. The rank
>> value of a memory tier is used to derive the demotion order between
>> NUMA nodes. The memory tiers present in a system can be found at
>>
>> "Rank" is an opaque value. Its absolute value doesn't have any
>> special meaning. But the rank values of different memtiers can be
>> compared with each other to determine the memory tier order.
>>
>> For example, if we have 3 memtiers: memtier0, memtier1, memiter2, and
>> their rank values are 300, 200, 100, then the memory tier order is:
>> memtier0 -> memtier1 -> memtier2, where memtier0 is the highest tier
>> and memtier2 is the lowest tier.
>>
>> The rank value of each memtier should be unique.
>>
>> A higher rank memory tier will appear first in the demotion order
>> than a lower rank memory tier. ie. while reclaim we choose a node
>> in higher rank memory tier to demote pages to as compared to a node
>> in a lower rank memory tier.
>>
>> This patchset introduce 3 memory tiers (memtier0, memtier1 and memtier2)
>> which are created by different kernel subsystems. The default memory
>> tier created by the kernel is memtier1. Once created these memory tiers
>> are not destroyed even if they don't have any NUMA nodes assigned to
>> them.
>>
>> This patch is based on the proposal sent by Wei Xu <weixugc@google.com> at [1].
>>
>> [1] https://lore.kernel.org/linux-mm/CAAPL-u9Wv+nH1VOZTj=9p9S70Y3Qz3+63EkqncRDdHfubsrjfw@mail.gmail.com
>>
>> /sys/devices/system/memtier/memtierN/
>>
>> The nodes which are part of a specific memory tier can be listed
>> via
>> /sys/devices/system/memtier/memtierN/nodelist
>>
>> Suggested-by: Wei Xu <weixugc@google.com>
>> Signed-off-by: Jagdish Gediya <jvgediya@linux.ibm.com>
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>> ---
>>   include/linux/memory-tiers.h | 20 ++++++++
>>   mm/Kconfig                   |  3 ++
>>   mm/Makefile                  |  1 +
>>   mm/memory-tiers.c            | 89 ++++++++++++++++++++++++++++++++++++
>>   4 files changed, 113 insertions(+)
>>   create mode 100644 include/linux/memory-tiers.h
>>   create mode 100644 mm/memory-tiers.c
>>
>> diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
>> new file mode 100644
>> index 000000000000..e17f6b4ee177
>> --- /dev/null
>> +++ b/include/linux/memory-tiers.h
>> @@ -0,0 +1,20 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef _LINUX_MEMORY_TIERS_H
>> +#define _LINUX_MEMORY_TIERS_H
>> +
>> +#ifdef CONFIG_TIERED_MEMORY
>> +
>> +#define MEMORY_TIER_HBM_GPU	0
>> +#define MEMORY_TIER_DRAM	1
>> +#define MEMORY_TIER_PMEM	2
>> +
>> +#define MEMORY_RANK_HBM_GPU	300
>> +#define MEMORY_RANK_DRAM	200
>> +#define MEMORY_RANK_PMEM	100
>> +
>> +#define DEFAULT_MEMORY_TIER	MEMORY_TIER_DRAM
>> +#define MAX_MEMORY_TIERS  3
>> +
>> +#endif	/* CONFIG_TIERED_MEMORY */
>> +
>> +#endif
>> diff --git a/mm/Kconfig b/mm/Kconfig
>> index 169e64192e48..bb5aa585ab41 100644
>> --- a/mm/Kconfig
>> +++ b/mm/Kconfig
>> @@ -614,6 +614,9 @@ config ARCH_ENABLE_HUGEPAGE_MIGRATION
>>   config ARCH_ENABLE_THP_MIGRATION
>>   	bool
>>   
>>
>> +config TIERED_MEMORY
>> +	def_bool NUMA
>> +
> 
> As Yang pointed out, why not just use CONFIG_NUMA?  I suspect the
> added value of CONIFIG_TIRED_MEMORY.
> 

I decided to use TIERED_MEMORY to bring more clarity. It should be same 
now that we have moved CONFIG_MIGRATION dependencies to runtime. IMHO 
having CONFIG_TIERED_MEMORY is better than using CONFIG_NUMA.

>>   config HUGETLB_PAGE_SIZE_VARIABLE
>>   	def_bool n
>>   	help
>> diff --git a/mm/Makefile b/mm/Makefile
>> index 6f9ffa968a1a..482557fbc9d1 100644
>> --- a/mm/Makefile
>> +++ b/mm/Makefile
>> @@ -92,6 +92,7 @@ obj-$(CONFIG_KFENCE) += kfence/
>>   obj-$(CONFIG_FAILSLAB) += failslab.o
>>   obj-$(CONFIG_MEMTEST)		+= memtest.o
>>   obj-$(CONFIG_MIGRATION) += migrate.o
>> +obj-$(CONFIG_TIERED_MEMORY) += memory-tiers.o
>>   obj-$(CONFIG_DEVICE_MIGRATION) += migrate_device.o
>>   obj-$(CONFIG_TRANSPARENT_HUGEPAGE) += huge_memory.o khugepaged.o
>>   obj-$(CONFIG_PAGE_COUNTER) += page_counter.o
>> diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
>> new file mode 100644
>> index 000000000000..d9fa955f208e
>> --- /dev/null
>> +++ b/mm/memory-tiers.c
>> @@ -0,0 +1,89 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +#include <linux/types.h>
>> +#include <linux/nodemask.h>
>> +#include <linux/slab.h>
>> +#include <linux/memory-tiers.h>
>> +
>> +struct memory_tier {
>> +	struct list_head list;
>> +	nodemask_t nodelist;
>> +	int id;
>> +	int rank;
>> +};
>> +
>> +static DEFINE_MUTEX(memory_tier_lock);
>> +static LIST_HEAD(memory_tiers);
>> +
>> +/*
>> + * Keep it simple by having  direct mapping between
>> + * tier index and rank value.
>> + */
>> +static inline int get_rank_from_tier(unsigned int tier)
>> +{
>> +	switch (tier) {
>> +	case MEMORY_TIER_HBM_GPU:
>> +		return MEMORY_RANK_HBM_GPU;
>> +	case MEMORY_TIER_DRAM:
>> +		return MEMORY_RANK_DRAM;
>> +	case MEMORY_TIER_PMEM:
>> +		return MEMORY_RANK_PMEM;
>> +	}
>> +	return -1;
>> +}
>> +
>> +static void insert_memory_tier(struct memory_tier *memtier)
>> +{
>> +	struct list_head *ent;
>> +	struct memory_tier *tmp_memtier;
>> +
>> +	list_for_each(ent, &memory_tiers) {
>> +		tmp_memtier = list_entry(ent, struct memory_tier, list);
> 
> list_for_each_entry() ?
> 

ent variable is used below. Hence I won't be able to use 
list_for_each_entry.

>> +		if (tmp_memtier->rank < memtier->rank) {
>> +			list_add_tail(&memtier->list, ent);
> 
>> +			return;
>> +		}
>> +	}
>> +	list_add_tail(&memtier->list, &memory_tiers);
>> +}
>> +
> 
> IMHO, the locking requirements are needed here as comments to avoid
> confusing.
> 

All those functions are called with memory_tier_lock_held. Infact all 
list operations requires that lock held. What details do you suggest we 
document? I can add extra comment to the mutex itself? Adding locking 
details to all the functions will be duplicating the same details at 
multiple places?

>> +static struct memory_tier *register_memory_tier(unsigned int tier,
>> +						unsigned int rank)
>> +{
>> +	struct memory_tier *memtier;
>> +
>> +	if (tier >= MAX_MEMORY_TIERS)
>> +		return ERR_PTR(-EINVAL);
>> +
>> +	memtier = kzalloc(sizeof(struct memory_tier), GFP_KERNEL);
>> +	if (!memtier)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	memtier->id   = tier;
>> +	memtier->rank = rank;
>> +
>> +	insert_memory_tier(memtier);
>> +
>> +	return memtier;
>> +}
>> +
>> +static int __init memory_tier_init(void)
>> +{
>> +	struct memory_tier *memtier;
>> +
>> +	/*
>> +	 * Register only default memory tier to hide all empty
>> +	 * memory tier from sysfs.
>> +	 */
>> +	memtier = register_memory_tier(DEFAULT_MEMORY_TIER,
>> +				       get_rank_from_tier(DEFAULT_MEMORY_TIER));
>> +
>> +	if (IS_ERR(memtier))
>> +		panic("%s() failed to register memory tier: %ld\n",
>> +		      __func__, PTR_ERR(memtier));
>> +
>> +	/* CPU only nodes are not part of memory tiers. */
>> +	memtier->nodelist = node_states[N_MEMORY];
>> +
>> +	return 0;
>> +}
>> +subsys_initcall(memory_tier_init);
> 

-aneesh

