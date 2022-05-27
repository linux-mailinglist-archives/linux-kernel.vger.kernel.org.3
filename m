Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 088385364DC
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 17:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352314AbiE0Ppu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 11:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237404AbiE0Ppr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 11:45:47 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3CCE108AB4
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 08:45:46 -0700 (PDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24RFAnKL006018;
        Fri, 27 May 2022 15:45:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=eumXYU/1SyssZe3QyFPznCoi3Qilm3WDxCBzeP7b46k=;
 b=Du6/Wl+rUEa3rnMICapztfxX21pvzrXfQIZupvI38UIWreA+x2xMjykDOelARNveKuNI
 /RQKZaiVlPVsieCPQ0aD2iJsSyiNCAH4qqA4WsCXNs1h3xOzaPQl9bgOof8pP7PEPpvO
 A1Aeh98znIavY6YrREv1i3H3VFSkotMa3NBN5KsRuG7gjyfwr6JqBtVCK1E6d80pQHUj
 ZfRZVwyO03SyNVbvJjnBzKRyS4IwmgdBIBl/VCx+lLOzWj5D2v4UVrINp5I4P7lXOu90
 Mjn+k5Hn+zcx1C0pnR4O0wdIxYhgNHMQ55d09TXofPyDX7cDYPlqLCFg2T8DMzSRkfIu Vw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gaxhqv8be-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 May 2022 15:45:21 +0000
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24RF0Z8Z025261;
        Fri, 27 May 2022 15:45:21 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gaxhqv89w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 May 2022 15:45:20 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24RFcmhD027686;
        Fri, 27 May 2022 15:45:18 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 3g93v044e0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 May 2022 15:45:18 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24RFjF5T18809312
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 May 2022 15:45:15 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B3A0A52050;
        Fri, 27 May 2022 15:45:15 +0000 (GMT)
Received: from [9.43.91.191] (unknown [9.43.91.191])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 3F3EB5204E;
        Fri, 27 May 2022 15:45:09 +0000 (GMT)
Message-ID: <37d91345-306d-e308-61c1-50e0d76992c0@linux.ibm.com>
Date:   Fri, 27 May 2022 21:15:09 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RFC PATCH v4 5/7] mm/demotion: Add support to associate rank
 with memory tier
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        Huang Ying <ying.huang@intel.com>,
        Greg Thelen <gthelen@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim C Chen <tim.c.chen@intel.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        David Rientjes <rientjes@google.com>
References: <CAAPL-u-dFp7PwPH6DfbYdnY8xaGsHz3tRQ0CPGVkiqURvdN8=A@mail.gmail.com>
 <20220527122528.129445-1-aneesh.kumar@linux.ibm.com>
 <20220527122528.129445-6-aneesh.kumar@linux.ibm.com>
 <20220527154557.00002c56@Huawei.com>
From:   Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
In-Reply-To: <20220527154557.00002c56@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: TiMnfCAN-gc4vlqu8Bt72nOKVUhdQyaf
X-Proofpoint-ORIG-GUID: r0xnC_bhPbEjRrslKarP_UFm2A_aN_SH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-27_04,2022-05-27_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 malwarescore=0 phishscore=0
 mlxlogscore=999 clxscore=1015 mlxscore=0 spamscore=0 bulkscore=0
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2204290000 definitions=main-2205270074
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/27/22 8:15 PM, Jonathan Cameron wrote:
> On Fri, 27 May 2022 17:55:26 +0530
> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> wrote:
> 
>> The rank approach allows us to keep memory tier device IDs stable even if there
>> is a need to change the tier ordering among different memory tiers. e.g. DRAM
>> nodes with CPUs will always be on memtier1, no matter how many tiers are higher
>> or lower than these nodes. A new memory tier can be inserted into the tier
>> hierarchy for a new set of nodes without affecting the node assignment of any
>> existing memtier, provided that there is enough gap in the rank values for the
>> new memtier.
>>
>> The absolute value of "rank" of a memtier doesn't necessarily carry any meaning.
>> Its value relative to other memtiers decides the level of this memtier in the tier
>> hierarchy.
>>
>> For now, This patch supports hardcoded rank values which are 100, 200, & 300 for
>> memory tiers 0,1 & 2 respectively.
>>
>> Below is the sysfs interface to read the rank values of memory tier,
>> /sys/devices/system/memtier/memtierN/rank
>>
>> This interface is read only for now, write support can be added when there is
>> a need of flexibility of more number of memory tiers(> 3) with flexibile ordering
>> requirement among them, rank can be utilized there as rank decides now memory
>> tiering ordering and not memory tier device ids.
>>
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> 
> I'd squash a lot of this with the original patch introducing tiers. As things
> stand we have 2 tricky to follow patches covering the same code rather than
> one that would be simpler.
> 

Sure. Will do that in the next update.

> Jonathan
> 
>> ---
>>   drivers/base/node.c     |   5 +-
>>   drivers/dax/kmem.c      |   2 +-
>>   include/linux/migrate.h |  17 ++--
>>   mm/migrate.c            | 218 ++++++++++++++++++++++++----------------
>>   4 files changed, 144 insertions(+), 98 deletions(-)
>>
>> diff --git a/drivers/base/node.c b/drivers/base/node.c
>> index cf4a58446d8c..892f7c23c94e 100644
>> --- a/drivers/base/node.c
>> +++ b/drivers/base/node.c
>> @@ -567,8 +567,11 @@ static ssize_t memtier_show(struct device *dev,
>>   			    char *buf)
>>   {
>>   	int node = dev->id;
>> +	int tier_index = node_get_memory_tier_id(node);
>>   
>> -	return sysfs_emit(buf, "%d\n", node_get_memory_tier(node));
>> +	if (tier_index != -1)
>> +		return sysfs_emit(buf, "%d\n", tier_index);
> I think failure to get a tier is an error. So if it happens, return an error code.
> Also prefered to handle errors out of line as more idiomatic so reviewers
> read it quicker.
> 
> 	if (tier_index == -1)
> 		return -EINVAL;
> 
> 	return sysfs_emit()...
> 
>> +	return 0;
>>   }
>>   


That was needed to handle NUMA nodes that is not part of any memory 
tiers, like CPU only NUMA node or NUMA node that doesn't want to 
participate in memory demotion.



>>   static ssize_t memtier_store(struct device *dev,
>> diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
>> index 991782aa2448..79953426ddaf 100644
>> --- a/drivers/dax/kmem.c
>> +++ b/drivers/dax/kmem.c
>> @@ -149,7 +149,7 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
>>   	dev_set_drvdata(dev, data);
>>   


...

>>   
>> -static DEVICE_ATTR_RO(default_tier);
>> +static DEVICE_ATTR_RO(default_rank);
>>   
>>   static struct attribute *memoty_tier_attrs[] = {
>> -	&dev_attr_max_tiers.attr,
>> -	&dev_attr_default_tier.attr,
>> +	&dev_attr_max_tier.attr,
>> +	&dev_attr_default_rank.attr,
> 
> hmm. Not sure why rename to tier rather than tiers.
> 
> Also, I think we default should be tier, not rank.  If someone later
> wants to change the rank of tier1 that's up to them, but any new hotplugged
> memory should still end up in their by default.
> 

Didn't we say, the tier index/device id is a meaning less entity that 
control just the naming. ie, for memtier128, 128 doesn't mean anything.
Instead it is the rank value associated with memtier128 that control the 
demotion order? If so what we want to update the userspace is max tier 
index userspace can expect and what is the default rank value to which 
memory will be added by hotplug.

But yes. tierindex 1 and default rank 200 are reserved and created by 
default.


....

>>   	/*
>>   	 * if node is already part of the tier proceed with the
>>   	 * current tier value, because we might want to establish
>> @@ -2411,15 +2452,17 @@ int node_set_memory_tier(int node, int tier)
>>   	 * before it was made part of N_MEMORY, hence estabilish_migration_targets
>>   	 * will have skipped this node.
>>   	 */
>> -	if (current_tier != -1)
>> -		tier = current_tier;
>> -	ret = __node_set_memory_tier(node, tier);
>> +	if (memtier)
>> +		establish_migration_targets();
>> +	else {
>> +		/* For now rank value and tier value is same. */
> 
> We should avoid baking that in...


Making it dynamic adds lots of complexity such as an ida alloc for tier 
index etc. I didn't want to get there unless we are sure we need dynamic 
number of tiers.

-aneesh

