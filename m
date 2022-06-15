Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA37D54C1C1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 08:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233741AbiFOGXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 02:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352299AbiFOGXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 02:23:32 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD682408B
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 23:23:32 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25F4TPVR002417;
        Wed, 15 Jun 2022 06:23:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=RZrfj8lREFNJz5+9MLnve0EBIjWiIiV2Z3zvtZiS7vc=;
 b=NILFoaXbrqU8Cy86k1bsXauxtWHmNcOIFxz90hQ16GTO51kFrChd24pJ+u/Ur4QmU7tH
 H8+DUEyVWcwM1h9lBId0opiysCF1B5UirIXFt81K21wAhO2XpXNN17dVJJoP7K3DCEn9
 85ZHKGZ7GmBvNYu80EP1IcYjA4Mfpl7pbYJOIEFjKLvuAKb5xNjCQ/wyDe/ELONaO2nN
 pMKyBLGkcyagueLHbCGPuXvLcPBhaWM5gi3YXi3QsNvQ+fmJKzLZEyQ/AX6fOjtZCpI7
 Q8hsu7rws1M0WZsr4wG9rs9FK+/J6fNxOgbZ/vkJnuuI6fY9Yf3/kINQkGHEO5fcCoVX 2Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gpq77pyd3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Jun 2022 06:23:17 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25F5PYYW023866;
        Wed, 15 Jun 2022 06:23:17 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gpq77pyca-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Jun 2022 06:23:16 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25F6KOkw013242;
        Wed, 15 Jun 2022 06:23:14 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 3gmjajdbuc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Jun 2022 06:23:14 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25F6NBsD22413602
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jun 2022 06:23:11 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C2F1E4C044;
        Wed, 15 Jun 2022 06:23:11 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 84C3A4C040;
        Wed, 15 Jun 2022 06:23:05 +0000 (GMT)
Received: from [9.43.65.168] (unknown [9.43.65.168])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 15 Jun 2022 06:23:05 +0000 (GMT)
Message-ID: <7b72ccf4-f4ae-cb4e-f411-74d055482026@linux.ibm.com>
Date:   Wed, 15 Jun 2022 11:53:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v5 1/9] mm/demotion: Add support for explicit memory tiers
Content-Language: en-US
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org, Wei Xu <weixugc@google.com>,
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
References: <YqDncfLeEeBaosrY@cmpxchg.org>
 <02ee2c97-3bca-8eb6-97d8-1f8743619453@linux.ibm.com>
 <YqH74WaUzJlb+smt@cmpxchg.org> <20220609152243.00000332@Huawei.com>
 <YqJa4N/VlS4zN4vf@cmpxchg.org> <20220610105708.0000679b@Huawei.com>
 <YqdEEhJFr3SlfvSJ@cmpxchg.org>
 <4297bd21-e984-9d78-2bca-e70c11749a72@linux.ibm.com>
 <Yqdc4DE8gYJ3zesO@cmpxchg.org>
 <42f536af-b17d-b001-7b6b-2c6b928f3ecf@linux.ibm.com>
 <YqjZyP11O0yCMmiO@cmpxchg.org>
From:   Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
In-Reply-To: <YqjZyP11O0yCMmiO@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: UE7rD1qZMZAd4rBfSaq-B2eYKOGEWdQ9
X-Proofpoint-GUID: yal9TmQnKHHZqbdalo--b9edd0X6bwaX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-15_02,2022-06-13_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 impostorscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 adultscore=0 clxscore=1015 spamscore=0 bulkscore=0
 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2204290000 definitions=main-2206150020
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/15/22 12:26 AM, Johannes Weiner wrote:

....

>> What can happen is two devices that are managed by DAX/kmem that
>> should be in two memory tiers get assigned the same memory tier
>> because the dax/kmem driver added both the device to the same memory tier.
>>
>> In the future we would avoid that by using more device properties like HMAT
>> to create additional memory tiers with different rank values. ie, we would
>> do in the dax/kmem create_tier_from_rank() .
> 
> Yes, that's the type of collision I mean. Two GPUs, two CXL-attached
> DRAMs of different speeds etc.
> 
> I also like Huang's idea of using latency characteristics instead of
> abstract distances. Though I'm not quite sure how feasible this is in
> the short term, and share some concerns that Jonathan raised. But I
> think a wider possible range to begin with makes sense in any case.
> 

How about the below proposal? 

In this proposal, we use the tier ID as the value that determines the position
of the memory tier in the demotion order. A higher value of tier ID indicates a
higher memory tier. Memory demotion happens from a higher memory tier to a lower
memory tier.

By default memory get hotplugged into 'default_memory_tier' . There is a core
kernel parameter "default_memory_tier" which can be updated if the user wants to
modify the default tier ID.

dax/kmem driver use the "dax_kmem_memtier" module parameter to determine the
memory tier to which DAX/kmem memory will be added.

dax_kmem_memtier and default_memtier defaults to 100 and 200 respectively.

Later as we update dax/kmem to use additional device attributes, the driver will
be able to place new devices in different memory tiers. As we do that, it is
expected that users will have the ability to override these device attribute and
control which memory tiers the devices will be placed.

New memory tiers can also be created by using node/memtier attribute.
Moving a NUMA node to a non-existing memory tier results in creating
new memory tiers. So if the kernel default placement of memory devices
in memory tiers is not preferred, userspace could choose to create a
completely new memory tier hierarchy using this interface. Memory tiers
get deleted when they ends up with empty nodelist.

# cat /sys/module/kernel/parameters/default_memory_tier 
200
# cat /sys/module/kmem/parameters/dax_kmem_memtier 
100

# ls /sys/devices/system/memtier/
default_tier  max_tier  memtier200  power  uevent
# ls /sys/devices/system/memtier/memtier200/nodelist 
/sys/devices/system/memtier/memtier200/nodelist
# cat  /sys/devices/system/memtier/memtier200/nodelist 
1-3
# echo 20 > /sys/devices/system/node/node1/memtier 
# 
# ls /sys/devices/system/memtier/
default_tier  max_tier  memtier20  memtier200  power  uevent
# cat  /sys/devices/system/memtier/memtier20/nodelist 
1
# 

# echo 10 > /sys/module/kmem/parameters/dax_kmem_memtier 
# echo dax0.0 > /sys/bus/dax/drivers/device_dax/unbind 
# echo dax0.0 > /sys/bus/dax/drivers/kmem/new_id 
# 
# ls /sys/devices/system/memtier/
default_tier  max_tier  memtier10  memtier20  memtier200  power  uevent
# cat  /sys/devices/system/memtier/memtier10/nodelist 
4
# 

# grep . /sys/devices/system/memtier/memtier*/nodelist
/sys/devices/system/memtier/memtier10/nodelist:4
/sys/devices/system/memtier/memtier200/nodelist:2-3
/sys/devices/system/memtier/memtier20/nodelist:1

demotion order details for the above will be
lower tier mask for node 1 is 4 and preferred demotion node is  4
lower tier mask for node 2 is 1,4 and preferred demotion node is 1
lower tier mask for node 3 is 1,4 and preferred demotion node is 1
lower tier mask for node 4  None

:/sys/devices/system/memtier#  ls
default_tier  max_tier  memtier10  memtier20  memtier200  power  uevent
:/sys/devices/system/memtier#  cat memtier20/nodelist 
1
:/sys/devices/system/memtier# echo 200 > ../node/node1/memtier 
:/sys/devices/system/memtier# ls
default_tier  max_tier  memtier10  memtier200  power  uevent
:/sys/devices/system/memtier# 




>>> In the other email I had suggested the ability to override not just
>>> the per-device distance, but also the driver default for new devices
>>> to handle the hotplug situation.
>>>

.....

>>
>> Can you elaborate more on how distance value will be used? The device/device NUMA node can have
>> different distance value from other NUMA nodes. How do we group them?
>> for ex: earlier discussion did outline three different topologies. Can you
>> ellaborate how we would end up grouping them using distance?
>>
>> For ex: in the topology below node 2 is at distance 30 from Node0 and 40 from Nodes
>> so how will we classify node 2?
>>
>>
>> Node 0 & 1 are DRAM nodes, node 2 & 3 are PMEM nodes.
>>
>> 		  20
>>   Node 0 (DRAM)  ----  Node 1 (DRAM)
>>        |        \   /       |
>>        | 30    40 X 40      | 30
>>        |        /   \       |
>>   Node 2 (PMEM)  ----  Node 3 (PMEM)
>> 		  40
>>
>> node distances:
>> node   0    1    2    3
>>    0  10   20   30   40
>>    1  20   10   40   30
>>    2  30   40   10   40
>>    3  40   30   40   10
> 
> I'm fairly confused by this example. Do all nodes have CPUs? Isn't
> this just classic NUMA, where optimizing for locality makes the most
> sense, rather than tiering?
> 

Node 2 and Node3 will be memory only NUMA nodes.

> Forget the interface for a second, I have no idea how tiering on such
> a system would work. One CPU's lower tier can be another CPU's
> toptier. There is no lowest rung from which to actually *reclaim*
> pages. Would the CPUs just demote in circles?
> 
> And the coldest pages on one socket would get demoted into another
> socket and displace what that socket considers hot local memory?
> 
> I feel like I missing something.
> 
> When we're talking about tiered memory, I'm thinking about CPUs
> utilizing more than one memory node. If those other nodes have CPUs,
> you can't reliably establish a singular tier order anymore and it
> becomes classic NUMA, no?

