Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3CB45427DB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 09:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245337AbiFHHOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 03:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349889AbiFHF7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 01:59:09 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B4465BD35
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 21:39:39 -0700 (PDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2583PxJQ004885;
        Wed, 8 Jun 2022 04:35:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=a+p482rR+3kcQLXkhpumh4IBH6Oc8ja3uPipsy097sY=;
 b=ZDaGpjyvmLQCjDOklgrY65JVIquDKphEmXd3Iy/8EZehNQZ/yHOQOaxwONF/ZDiVOYI7
 Ud9NyLjqzek8iH3m08rmI0dfDqWkAlrzV87bGB0g9VlJYBMWwVZ8tF8jVoBebNmOfJTk
 cRS5JxgECU7zvLHtyV8iMo5He4fNgw8UccD/kKlfOiuHsjoMJ66avB5GdPFxjHFAkR1T
 zg8eV9xxOuzyNUmVrJbO2SzPDNXafSTGDYK2lZB0xKL2kYgV/m7bSdNo3pDOCkqx9Vol
 FJysMFWwk/TFHKzrjZ3FIJE17WXdKxWKczyfrWL4s2OT3ibNgTPuJVXlwdj/4XlYeDzf vg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3gjkv112ma-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Jun 2022 04:35:55 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2584VIUm016383;
        Wed, 8 Jun 2022 04:35:54 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3gjkv112km-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Jun 2022 04:35:54 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2584LWK7005778;
        Wed, 8 Jun 2022 04:30:51 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06fra.de.ibm.com with ESMTP id 3gfxnj3kg0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Jun 2022 04:30:51 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2584Um6A11206998
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Jun 2022 04:30:48 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AD98852050;
        Wed,  8 Jun 2022 04:30:48 +0000 (GMT)
Received: from [9.43.53.124] (unknown [9.43.53.124])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 4B7275204E;
        Wed,  8 Jun 2022 04:30:42 +0000 (GMT)
Message-ID: <8a42d52c-6275-4798-19c0-dfc530c04b0e@linux.ibm.com>
Date:   Wed, 8 Jun 2022 10:00:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v5 1/9] mm/demotion: Add support for explicit memory tiers
Content-Language: en-US
To:     Tim Chen <tim.c.chen@linux.intel.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org
Cc:     Wei Xu <weixugc@google.com>, Huang Ying <ying.huang@intel.com>,
        Greg Thelen <gthelen@google.com>,
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
        David Rientjes <rientjes@google.com>
References: <20220603134237.131362-1-aneesh.kumar@linux.ibm.com>
 <20220603134237.131362-2-aneesh.kumar@linux.ibm.com>
 <92649c9a6e0b6931b34aeaaf22c0a1e874484b7f.camel@linux.intel.com>
From:   Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
In-Reply-To: <92649c9a6e0b6931b34aeaaf22c0a1e874484b7f.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6H-um7iv2foE4P3iXiT2PpRZcZgkhxnx
X-Proofpoint-ORIG-GUID: ETVjLeLWT17NeNWEgf4QZpnyFCJLhcWB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-08_01,2022-06-07_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 clxscore=1015 malwarescore=0 bulkscore=0 spamscore=0
 adultscore=0 phishscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206080019
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/22 12:13 AM, Tim Chen wrote:
> On Fri, 2022-06-03 at 19:12 +0530, Aneesh Kumar K.V wrote:
>>
>>
>> The nodes which are part of a specific memory tier can be listed
>> via
>> /sys/devices/system/memtier/memtierN/nodelist
>>
>> "Rank" is an opaque value. Its absolute value doesn't have any
>> special meaning. But the rank values of different memtiers can be
>> compared with each other to determine the memory tier order.
>>
>> For example, if we have 3 memtiers: memtier0, memtier1, memiter2, and
>> their rank values are 300, 200, 100, then the memory tier order is:
>> memtier0 -> memtier2 -> memtier1,
> 
> Why is memtier2 (rank 100) higher than memtier1 (rank 200)?  Seems like
> the order should be memtier0 -> memtier1 -> memtier2?
>                      (rank 300)  (rank 200)  (rank 100)
> 
>> where memtier0 is the highest tier
>> and memtier1 is the lowest tier.
> 
> I think memtier2 is the lowest as it has the lowest rank value.


typo error. Will fix that in the next update

>>
>> The rank value of each memtier should be unique.
>>
>>
>> +
>> +static void memory_tier_device_release(struct device *dev)
>> +{
>> +	struct memory_tier *tier = to_memory_tier(dev);
>> +
> 
> Do we need some ref counts on memory_tier?
> If there is another device still using the same memtier,
> free below could cause problem.
> 
>> +	kfree(tier);
>> +}
>> +
>>
> ...
>> +static struct memory_tier *register_memory_tier(unsigned int tier)
>> +{
>> +	int error;
>> +	struct memory_tier *memtier;
>> +
>> +	if (tier >= MAX_MEMORY_TIERS)
>> +		return NULL;
>> +
>> +	memtier = kzalloc(sizeof(struct memory_tier), GFP_KERNEL);
>> +	if (!memtier)
>> +		return NULL;
>> +
>> +	memtier->dev.id = tier;
>> +	memtier->rank = get_rank_from_tier(tier);
>> +	memtier->dev.bus = &memory_tier_subsys;
>> +	memtier->dev.release = memory_tier_device_release;
>> +	memtier->dev.groups = memory_tier_dev_groups;
>> +
> 
> Should you take the mem_tier_lock before you insert to
> memtier-list?


Both register_memory_tier and unregister_memory_tier get called with 
memory_tier_lock held.

> 
>> +	insert_memory_tier(memtier);
>> +
>> +	error = device_register(&memtier->dev);
>> +	if (error) {
>> +		list_del(&memtier->list);
>> +		put_device(&memtier->dev);
>> +		return NULL;
>> +	}
>> +	return memtier;
>> +}
>> +
>> +__maybe_unused // temporay to prevent warnings during bisects
>> +static void unregister_memory_tier(struct memory_tier *memtier)
>> +{
> 
> I think we should take mem_tier_lock before modifying memtier->list.
> 

unregister_memory_tier get called with memory_tier_lock held.

>> +	list_del(&memtier->list);
>> +	device_unregister(&memtier->dev);
>> +}
>> +
>>

-aneesh
