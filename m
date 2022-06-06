Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABE4953E9BA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241778AbiFFQjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 12:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbiFFQjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 12:39:36 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F8A143878
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 09:39:34 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 256GB37u022119;
        Mon, 6 Jun 2022 16:39:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=N3cEJfftz2jNhqoKFiafd4KJpeSdPAttN3iYXjVNlXY=;
 b=ViIcx5SCXWoeNQm1MVN+uzHqzg7qUdHbdu79vJIcGFm2qYQVv+Qau1AO4hc0+xPoCrIv
 96b3vHe31RUlKM12nXWdr+aKwkFMr3JiLaLO/OY5jaad1XK7zdEAZw6enJnUg+a/2d9+
 GbBs0T3EppI0fRrFr2VN5gwlhP/zPPQTXEKpyjnHwSQcLr7g0ACD9zqy1qpoiDJECJ1P
 8T7U8aL4rLDLpgHK3lfOaReOBKUYYc3420DjBWsJeWcsIN6sZLQs67Qx+6CA1TPrXVuh
 A6jDv89Vyfo5onPB0WxOpYpyO+8GXkbwy2v57GLk4DJSuYgEZjgiZ4Xlx8bg5pUPbt4E gA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ggh2k4b06-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Jun 2022 16:39:15 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 256GHXZ7009785;
        Mon, 6 Jun 2022 16:39:14 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ggh2k4aym-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Jun 2022 16:39:14 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 256GMTE6016014;
        Mon, 6 Jun 2022 16:39:12 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 3gfy19amd7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Jun 2022 16:39:12 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 256GdA7O20971810
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Jun 2022 16:39:10 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7F5DF42041;
        Mon,  6 Jun 2022 16:39:10 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B701C4203F;
        Mon,  6 Jun 2022 16:39:03 +0000 (GMT)
Received: from [9.43.87.254] (unknown [9.43.87.254])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  6 Jun 2022 16:39:03 +0000 (GMT)
Message-ID: <efede910-e0d7-02e6-d536-c25a7225d88c@linux.ibm.com>
Date:   Mon, 6 Jun 2022 22:09:02 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [RFC PATCH v4 2/7] mm/demotion: Expose per node memory tier to
 sysfs
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
 <20220527122528.129445-3-aneesh.kumar@linux.ibm.com>
 <20220527151531.00002a0c@Huawei.com>
 <fbebbd2b-2ddb-bee6-5e12-67e3e18648ee@linux.ibm.com>
 <20220606155920.00004ce9@Huawei.com>
 <3a557f74-cc3a-c0ee-78e8-2cf50bee5f2d@linux.ibm.com>
 <20220606171622.000036ed@Huawei.com>
From:   Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
In-Reply-To: <20220606171622.000036ed@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ZaRGfWkLjzn2qQ_hghrvH2kaHIAqDj5y
X-Proofpoint-ORIG-GUID: 03Q6M6wipTdAzustv1f2bWXoVnEfmFiw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-06_04,2022-06-03_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 lowpriorityscore=0
 clxscore=1015 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206060071
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/6/22 9:46 PM, Jonathan Cameron wrote:
> On Mon, 6 Jun 2022 21:31:16 +0530
> Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> wrote:
> 
>> On 6/6/22 8:29 PM, Jonathan Cameron wrote:
>>> On Fri, 3 Jun 2022 14:10:47 +0530
>>> Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> wrote:
>>>    
>>>> On 5/27/22 7:45 PM, Jonathan Cameron wrote:
>>>>> On Fri, 27 May 2022 17:55:23 +0530
>>>>> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> wrote:
>>>>>       
>>>>>> From: Jagdish Gediya <jvgediya@linux.ibm.com>
>>>>>>
>>>>>> Add support to read/write the memory tierindex for a NUMA node.
>>>>>>
>>>>>> /sys/devices/system/node/nodeN/memtier
>>>>>>
>>>>>> where N = node id
>>>>>>
>>>>>> When read, It list the memory tier that the node belongs to.
>>>>>>
>>>>>> When written, the kernel moves the node into the specified
>>>>>> memory tier, the tier assignment of all other nodes are not
>>>>>> affected.
>>>>>>
>>>>>> If the memory tier does not exist, writing to the above file
>>>>>> create the tier and assign the NUMA node to that tier.
>>>>> creates
>>>>>
>>>>> There was some discussion in v2 of Wei Xu's RFC that what matter
>>>>> for creation is the rank, not the tier number.
>>>>>
>>>>> My suggestion is move to an explicit creation file such as
>>>>> memtier/create_tier_from_rank
>>>>> to which writing the rank gives results in a new tier
>>>>> with the next device ID and requested rank.
>>>>
>>>> I think the below workflow is much simpler.
>>>>
>>>> :/sys/devices/system# cat memtier/memtier1/nodelist
>>>> 1-3
>>>> :/sys/devices/system# cat node/node1/memtier
>>>> 1
>>>> :/sys/devices/system# ls memtier/memtier*
>>>> nodelist  power  rank  subsystem  uevent
>>>> /sys/devices/system# ls memtier/
>>>> default_rank  max_tier  memtier1  power  uevent
>>>> :/sys/devices/system# echo 2 > node/node1/memtier
>>>> :/sys/devices/system#
>>>>
>>>> :/sys/devices/system# ls memtier/
>>>> default_rank  max_tier  memtier1  memtier2  power  uevent
>>>> :/sys/devices/system# cat memtier/memtier1/nodelist
>>>> 2-3
>>>> :/sys/devices/system# cat memtier/memtier2/nodelist
>>>> 1
>>>> :/sys/devices/system#
>>>>
>>>> ie, to create a tier we just write the tier id/tier index to
>>>> node/nodeN/memtier file. That will create a new memory tier if needed
>>>> and add the node to that specific memory tier. Since for now we are
>>>> having 1:1 mapping between tier index to rank value, we can derive the
>>>> rank value from the memory tier index.
>>>>
>>>> For dynamic memory tier support, we can assign a rank value such that
>>>> new memory tiers are always created such that it comes last in the
>>>> demotion order.
>>>
>>> I'm not keen on having to pass through an intermediate state where
>>> the rank may well be wrong, but I guess it's not that harmful even
>>> if it feels wrong ;)
>>>    
>>
>> Any new memory tier added can be of lowest rank (rank - 0) and hence
>> will appear as the highest memory tier in demotion order.
> 
> Depends on driver interaction - if new memory is CXL attached or
> GPU attached, chances are the driver has an input on which tier
> it is put in by default.
> 
>> User can then
>> assign the right rank value to the memory tier? Also the actual demotion
>> target paths are built during memory block online which in most case
>> would happen after we properly verify that the device got assigned to
>> the right memory tier with correct rank value?
> 
> Agreed, though that may change the model of how memory is brought online
> somewhat.
> 
>>
>>> Races are potentially a bit of a pain though depending on what we
>>> expect the usage model to be.
>>>
>>> There are patterns (CXL regions for example) of guaranteeing the
>>> 'right' device is created by doing something like
>>>
>>> cat create_tier > temp.txt
>>> #(temp gets 2 for example on first call then
>>> # next read of this file gets 3 etc)
>>>
>>> cat temp.txt > create_tier
>>> # will fail if there hasn't been a read of the same value
>>>
>>> Assuming all software keeps to the model, then there are no
>>> race conditions over creation.  Otherwise we have two new
>>> devices turn up very close to each other and userspace scripting
>>> tries to create two new tiers - if it races they may end up in
>>> the same tier when that wasn't the intent.  Then code to set
>>> the rank also races and we get two potentially very different
>>> memories in a tier with a randomly selected rank.
>>>
>>> Fun and games...  And a fine illustration why sysfs based 'device'
>>> creation is tricky to get right (and lots of cases in the kernel
>>> don't).
>>>    
>>
>> I would expect userspace to be careful and verify the memory tier and
>> rank value before we online the memory blocks backed by the device. Even
>> if we race, the result would be two device not intended to be part of
>> the same memory tier appearing at the same tier. But then we won't be
>> building demotion targets yet. So userspace could verify this, move the
>> nodes out of the memory tier. Once it is verified, memory blocks can be
>> onlined.
> 
> The race is there and not avoidable as far as I can see. Two processes A and B.
> 
> A checks for a spare tier number
> B checks for a spare tier number
> A tries to assign node 3 to new tier 2 (new tier created)
> B tries to assign node 4 to new tier 2 (accidentally hits existing tier - as this
> is the same method we'd use to put it in the existing tier we can't tell this
> write was meant to create a new tier).
> A writes rank 100 to tier 2
> A checks rank for tier 2 and finds it is 100 as expected.
> B write rank 200 to tier 2 (it could check if still default but even that is racy)
> B checks rank for tier 2 rank and finds it is 200 as expected.
> A onlines memory.
> B onlines memory.
> 
> Both think they got what they wanted, but A definitely didn't.
> 
> One work around is the read / write approach and create_tier.
> 
> A reads create_tier - gets 2.
> B reads create_tier - gets 3.
> A writes 2 to create_tier as that's what it read.
> B writes 3 to create_tier as that's what it read.
> 
> continue with created tiers.  Obviously can exhaust tiers, but if this is
> root only, could just create lots anyway so no worse off.
>   
>>
>> Having said that can you outline the usage of
>> memtier/create_tier_from_rank ?
> 
> There are corner cases to deal with...
> 
> A writes 100 to create_tier_from_rank.
> A goes looking for matching tier - finds it: tier2
> B writes 200 to create_tier_from_rank
> B goes looking for matching tier - finds it: tier3
> 
> rest is fine as operating on different tiers.
> 
> Trickier is
> A writes 100 to create_tier_from_rank  - succeed.
> B writes 100 to create_tier_from_rank  - Could fail, or could just eat it?
> 
> Logically this is same as separate create_tier and then a write
> of rank, but in one operation, but then you need to search
> for the right one.  As such, perhaps a create_tier
> that does the read/write pair as above is the best solution.
> 

This all is good when we allow dynamic rank values. But currently we are 
restricting ourselves to three rank value as below:

rank   memtier
300    memtier0
200    memtier1
100    memtier2

Now with the above, how do we define a write to create_tier_from_rank. 
What should be the behavior if user write value other than above defined 
rank values? Also enforcing the above three rank values as supported 
implies teaching userspace about them. I am trying to see how to fit
create_tier_from_rank without requiring the above.

Can we look at implementing create_tier_from_rank when we start 
supporting dynamic tiers/rank values? ie,

we still allow node/nodeN/memtier. But with dynamic tiers a race free
way to get a new memory tier would be echo rank > 
memtier/create_tier_from_rank. We could also say, memtier0/1/2 are 
kernel defined memory tiers. Writing to memtier/create_tier_from_rank 
will create new memory tiers above memtier2 with the rank value specified?

-aneesh



