Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7424453EA65
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241391AbiFFQBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 12:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241374AbiFFQBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 12:01:47 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6442A5F8EC
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 09:01:45 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 256EFPMx004746;
        Mon, 6 Jun 2022 16:01:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=3HIhbIpWxbWLPGLMfByZdm1sKGbdvpDG4GoCHEVpvvI=;
 b=BpVvmMcdpmD4I/sBBqFy7nIxd0ara7C7BR/kf8//qgYRG3yhZ089JukO09t0cBZYB97I
 pY1YKDuwJeLGF/ewRLaZnIdNuT0e6KtwBD41IkAXU1EtUXvDFTvy49wnLq2zmChpQrcs
 cxJGioGfUm2+NJn9ZMGKzdCM3FJuRVLZLenPkGuAYHJZJH30hxMERPLCVJ5VWgbZ9ZaT
 Q7uD81tFqBe0ce4nTtt8ELQmYxuqJDigGzlkQ6RVloLG4mM+AdxEziPciJ1tCKK5Xs+a
 Elm70EYR+53BIuZE1luLDvI0yH9vsZAwzKUetormGmBXAu6N3RQHTMyvE8P/9LWvv+Xd 0g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gggpvm4cn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Jun 2022 16:01:28 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 256Expol006216;
        Mon, 6 Jun 2022 16:01:27 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gggpvm4bh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Jun 2022 16:01:27 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 256FofBH023350;
        Mon, 6 Jun 2022 16:01:25 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 3gfy19ak9b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Jun 2022 16:01:25 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 256G1N1I16777684
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Jun 2022 16:01:23 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E1B654203F;
        Mon,  6 Jun 2022 16:01:22 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A89B842045;
        Mon,  6 Jun 2022 16:01:17 +0000 (GMT)
Received: from [9.43.87.254] (unknown [9.43.87.254])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  6 Jun 2022 16:01:17 +0000 (GMT)
Message-ID: <3a557f74-cc3a-c0ee-78e8-2cf50bee5f2d@linux.ibm.com>
Date:   Mon, 6 Jun 2022 21:31:16 +0530
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
From:   Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
In-Reply-To: <20220606155920.00004ce9@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: FYKk9iv1-EOjwDEnva-GGmA2i4RTBehY
X-Proofpoint-GUID: 6ZCav8lFZIaHvAfErRuEKfRcyfm0bEwB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-06_04,2022-06-03_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 impostorscore=0 bulkscore=0 phishscore=0
 clxscore=1015 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2204290000 definitions=main-2206060071
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/6/22 8:29 PM, Jonathan Cameron wrote:
> On Fri, 3 Jun 2022 14:10:47 +0530
> Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> wrote:
> 
>> On 5/27/22 7:45 PM, Jonathan Cameron wrote:
>>> On Fri, 27 May 2022 17:55:23 +0530
>>> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> wrote:
>>>    
>>>> From: Jagdish Gediya <jvgediya@linux.ibm.com>
>>>>
>>>> Add support to read/write the memory tierindex for a NUMA node.
>>>>
>>>> /sys/devices/system/node/nodeN/memtier
>>>>
>>>> where N = node id
>>>>
>>>> When read, It list the memory tier that the node belongs to.
>>>>
>>>> When written, the kernel moves the node into the specified
>>>> memory tier, the tier assignment of all other nodes are not
>>>> affected.
>>>>
>>>> If the memory tier does not exist, writing to the above file
>>>> create the tier and assign the NUMA node to that tier.
>>> creates
>>>
>>> There was some discussion in v2 of Wei Xu's RFC that what matter
>>> for creation is the rank, not the tier number.
>>>
>>> My suggestion is move to an explicit creation file such as
>>> memtier/create_tier_from_rank
>>> to which writing the rank gives results in a new tier
>>> with the next device ID and requested rank.
>>
>> I think the below workflow is much simpler.
>>
>> :/sys/devices/system# cat memtier/memtier1/nodelist
>> 1-3
>> :/sys/devices/system# cat node/node1/memtier
>> 1
>> :/sys/devices/system# ls memtier/memtier*
>> nodelist  power  rank  subsystem  uevent
>> /sys/devices/system# ls memtier/
>> default_rank  max_tier  memtier1  power  uevent
>> :/sys/devices/system# echo 2 > node/node1/memtier
>> :/sys/devices/system#
>>
>> :/sys/devices/system# ls memtier/
>> default_rank  max_tier  memtier1  memtier2  power  uevent
>> :/sys/devices/system# cat memtier/memtier1/nodelist
>> 2-3
>> :/sys/devices/system# cat memtier/memtier2/nodelist
>> 1
>> :/sys/devices/system#
>>
>> ie, to create a tier we just write the tier id/tier index to
>> node/nodeN/memtier file. That will create a new memory tier if needed
>> and add the node to that specific memory tier. Since for now we are
>> having 1:1 mapping between tier index to rank value, we can derive the
>> rank value from the memory tier index.
>>
>> For dynamic memory tier support, we can assign a rank value such that
>> new memory tiers are always created such that it comes last in the
>> demotion order.
> 
> I'm not keen on having to pass through an intermediate state where
> the rank may well be wrong, but I guess it's not that harmful even
> if it feels wrong ;)
> 

Any new memory tier added can be of lowest rank (rank - 0) and hence 
will appear as the highest memory tier in demotion order. User can then
assign the right rank value to the memory tier? Also the actual demotion 
target paths are built during memory block online which in most case 
would happen after we properly verify that the device got assigned to 
the right memory tier with correct rank value?

> Races are potentially a bit of a pain though depending on what we
> expect the usage model to be.
> 
> There are patterns (CXL regions for example) of guaranteeing the
> 'right' device is created by doing something like
> 
> cat create_tier > temp.txt
> #(temp gets 2 for example on first call then
> # next read of this file gets 3 etc)
> 
> cat temp.txt > create_tier
> # will fail if there hasn't been a read of the same value
> 
> Assuming all software keeps to the model, then there are no
> race conditions over creation.  Otherwise we have two new
> devices turn up very close to each other and userspace scripting
> tries to create two new tiers - if it races they may end up in
> the same tier when that wasn't the intent.  Then code to set
> the rank also races and we get two potentially very different
> memories in a tier with a randomly selected rank.
> 
> Fun and games...  And a fine illustration why sysfs based 'device'
> creation is tricky to get right (and lots of cases in the kernel
> don't).
> 

I would expect userspace to be careful and verify the memory tier and 
rank value before we online the memory blocks backed by the device. Even 
if we race, the result would be two device not intended to be part of 
the same memory tier appearing at the same tier. But then we won't be 
building demotion targets yet. So userspace could verify this, move the 
nodes out of the memory tier. Once it is verified, memory blocks can be 
onlined.

Having said that can you outline the usage of 
memtier/create_tier_from_rank ?

-aneesh
