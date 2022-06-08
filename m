Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59C81542AC7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 11:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233444AbiFHJJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 05:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234041AbiFHJIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 05:08:15 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D23EBC6E4A
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 01:25:49 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2588EmIa024091;
        Wed, 8 Jun 2022 08:25:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=/LNWZ4oxESnaZCxhU8MtG30U6NZEerTPXIneTojBjXc=;
 b=AnFGNE5A2RM5/DQVyXnsNwehr/GSabrjSv0UlKtdWHbHmgEi1laAMN7d/15Kb40loUZ8
 8G1cQRv5Ger4Yq1N/a2Z9IdpjeZzRazBeatGDmFGMKjzRbl/IboMIdvewBwa5OdMqdjz
 beG+j2o4v1q8cjNacQFqDAYrQYuEqj6P0ZtARpv6h77KXHVOrMjctvScb2ajW3g8tbT8
 KbasxO7pz9UC8KFfZfRomXE36GmASZgj7t+UPMSqdRJ+Ppt5AHvmXGJfQfhkdA/Y++QQ
 Y6Fdat+fPxLq0YapcEPkBXe4TVXoSmS1oaLQrc0uUuzLgoDOEYaC0cLOz/3LDocNGVDk CQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gjr3cg8h3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Jun 2022 08:25:40 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2588IvQD011960;
        Wed, 8 Jun 2022 08:25:40 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gjr3cg8g9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Jun 2022 08:25:39 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2588LOUA023125;
        Wed, 8 Jun 2022 08:25:37 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04fra.de.ibm.com with ESMTP id 3gfy18ut4y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Jun 2022 08:25:37 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2588PZrg14156092
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Jun 2022 08:25:35 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 240785204E;
        Wed,  8 Jun 2022 08:25:35 +0000 (GMT)
Received: from [9.43.53.124] (unknown [9.43.53.124])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 71F8C52052;
        Wed,  8 Jun 2022 08:25:29 +0000 (GMT)
Message-ID: <f74a6310-a50c-ebd6-cf06-df90fb02dd64@linux.ibm.com>
Date:   Wed, 8 Jun 2022 13:55:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [RFC PATCH v4 2/7] mm/demotion: Expose per node memory tier to
 sysfs
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
 <20220527122528.129445-3-aneesh.kumar@linux.ibm.com>
 <e5c311d6c2f97407373aba0895aa6e7c0ce8d377.camel@intel.com>
From:   Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
In-Reply-To: <e5c311d6c2f97407373aba0895aa6e7c0ce8d377.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: hRgtdR-YKwvhsNwgH5QHdSbn8UektSfp
X-Proofpoint-GUID: _Z69ZV6m6GtV9p7DJFV0sWCugw90WdhF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-08_02,2022-06-07_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 suspectscore=0 mlxscore=0 clxscore=1015 mlxlogscore=999 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206080035
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/22 12:48 PM, Ying Huang wrote:
> On Fri, 2022-05-27 at 17:55 +0530, Aneesh Kumar K.V wrote:
>> From: Jagdish Gediya <jvgediya@linux.ibm.com>
>>
>> Add support to read/write the memory tierindex for a NUMA node.
>>
>> /sys/devices/system/node/nodeN/memtier
>>
>> where N = node id
>>
>> When read, It list the memory tier that the node belongs to.
>>
>> When written, the kernel moves the node into the specified
>> memory tier, the tier assignment of all other nodes are not
>> affected.
>>
>> If the memory tier does not exist, writing to the above file
>> create the tier and assign the NUMA node to that tier.
>>
>> mutex memory_tier_lock is introduced to protect memory tier
>> related chanegs as it can happen from sysfs as well on hot
>> plug events.
>>
>> Signed-off-by: Jagdish Gediya <jvgediya@linux.ibm.com>
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>> ---
>>   drivers/base/node.c     |  35 ++++++++++++++
>>   include/linux/migrate.h |   4 +-
>>   mm/migrate.c            | 103 ++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 141 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/base/node.c b/drivers/base/node.c
>> index ec8bb24a5a22..cf4a58446d8c 100644
>> --- a/drivers/base/node.c
>> +++ b/drivers/base/node.c
>> @@ -20,6 +20,7 @@
>>   #include <linux/pm_runtime.h>
>>   #include <linux/swap.h>
>>   #include <linux/slab.h>
>> +#include <linux/migrate.h>
>>   
>>
>>
>>
>>   static struct bus_type node_subsys = {
>>   	.name = "node",
>> @@ -560,11 +561,45 @@ static ssize_t node_read_distance(struct device *dev,
>>   }
>>   static DEVICE_ATTR(distance, 0444, node_read_distance, NULL);
>>   
>>
>>
>>
>> +#ifdef CONFIG_TIERED_MEMORY
>> +static ssize_t memtier_show(struct device *dev,
>> +			    struct device_attribute *attr,
>> +			    char *buf)
>> +{
>> +	int node = dev->id;
>> +
>> +	return sysfs_emit(buf, "%d\n", node_get_memory_tier(node));
>> +}
>> +
>> +static ssize_t memtier_store(struct device *dev,
>> +			     struct device_attribute *attr,
>> +			     const char *buf, size_t count)
>> +{
>> +	unsigned long tier;
>> +	int node = dev->id;
>> +
>> +	int ret = kstrtoul(buf, 10, &tier);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = node_reset_memory_tier(node, tier);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return count;
>> +}
>> +
>> +static DEVICE_ATTR_RW(memtier);
>> +#endif
>> +
>>   static struct attribute *node_dev_attrs[] = {
>>   	&dev_attr_meminfo.attr,
>>   	&dev_attr_numastat.attr,
>>   	&dev_attr_distance.attr,
>>   	&dev_attr_vmstat.attr,
>> +#ifdef CONFIG_TIERED_MEMORY
>> +	&dev_attr_memtier.attr,
>> +#endif
>>   	NULL
>>   };
>>   
>>
>>
>>
>> diff --git a/include/linux/migrate.h b/include/linux/migrate.h
>> index 0ec653623565..d37d1d5dee82 100644
>> --- a/include/linux/migrate.h
>> +++ b/include/linux/migrate.h
>> @@ -177,13 +177,15 @@ enum memory_tier_type {
>>   };
>>   
>>
>>
>>
>>   int next_demotion_node(int node);
>> -
>>   extern void migrate_on_reclaim_init(void);
>>   #ifdef CONFIG_HOTPLUG_CPU
>>   extern void set_migration_target_nodes(void);
>>   #else
>>   static inline void set_migration_target_nodes(void) {}
>>   #endif
>> +int node_get_memory_tier(int node);
>> +int node_set_memory_tier(int node, int tier);
>> +int node_reset_memory_tier(int node, int tier);
>>   #else
>>   #define numa_demotion_enabled	false
>>   static inline int next_demotion_node(int node)
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index f28ee93fb017..304559ba3372 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -2132,6 +2132,7 @@ static struct bus_type memory_tier_subsys = {
>>   	.dev_name = "memtier",
>>   };
>>   
>>
>>
>>
>> +DEFINE_MUTEX(memory_tier_lock);
>>   static struct memory_tier *memory_tiers[MAX_MEMORY_TIERS];
>>   
>>
>>
>>
>>   static ssize_t nodelist_show(struct device *dev,
>> @@ -2225,6 +2226,108 @@ static const struct attribute_group *memory_tier_attr_groups[] = {
>>   	NULL,
>>   };
>>   
>>
>>
>>
>> +static int __node_get_memory_tier(int node)
>> +{
>> +	int tier;
>> +
>> +	for (tier = 0; tier < MAX_MEMORY_TIERS; tier++) {
>> +		if (memory_tiers[tier] && node_isset(node, memory_tiers[tier]->nodelist))
>> +			return tier;
>> +	}
>> +
>> +	return -1;
>> +}
>> +
>> +int node_get_memory_tier(int node)
>> +{
>> +	int tier;
>> +
>> +	/*
>> +	 * Make sure memory tier is not unregistered
>> +	 * while it is being read.
>> +	 */
>> +	mutex_lock(&memory_tier_lock);
>> +
>> +	tier = __node_get_memory_tier(node);
>> +
>> +	mutex_unlock(&memory_tier_lock);
>> +
>> +	return tier;
>> +}
>> +
>> +int __node_set_memory_tier(int node, int tier)
>> +{
>> +	int ret = 0;
>> +	/*
>> +	 * As register_memory_tier() for new tier can fail,
>> +	 * try it before modifying existing tier. register
>> +	 * tier makes tier visible in sysfs.
>> +	 */
>> +	if (!memory_tiers[tier]) {
>> +		ret = register_memory_tier(tier);
>> +		if (ret) {
>> +			goto out;
>> +		}
>> +	}
>> +
>> +	node_set(node, memory_tiers[tier]->nodelist);
>> +
>> +out:
>> +	return ret;
>> +}
>> +
>> +int node_reset_memory_tier(int node, int tier)
> 
> I think "reset" isn't a good name here.  Maybe something like "change"
> or "move"?
> 

how about node_update_memory_tier()?

-aneesh
