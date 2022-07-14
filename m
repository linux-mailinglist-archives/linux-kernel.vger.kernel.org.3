Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F01957447F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 07:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbiGNF3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 01:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbiGNF3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 01:29:47 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6965717A8C
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 22:29:46 -0700 (PDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26E4gJFT029207;
        Thu, 14 Jul 2022 05:29:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=we5m36/LXg0P96+74TS+EpPM4gc2HjLquDTpQ818IRw=;
 b=EbQh/pEPi6+Y59+GBHm1zEAWHGV2lyRMo0oXXIbDsL1v7Vh6KlvWkhxzg8/LzTMNwsoN
 idThS37OxFXa9IqGBEDNufKHMjiYgR7kpDb8nCfx/l/oyF7xQJMA67BIMhB27WclR6bR
 5v+Awp8Dt+oiyKpXxmL69SaAoFzg036BT44qgMCJc9j/KiaP7vBYCdKcoFR68Od1Q5Zv
 kZfjDSIoEiJuehrWTuvHMA1EOjOE5m+qTHAEaZ01WO/6wynvZV/s9omkfM4j+3T0AEaN
 cIoP4gT6iQVoGfd7HYUT6KE686/Czh/PpKEdZjJ5Yq96FbIPvryDMjj5koZbw0xbU32p ZA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hacbg0y74-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Jul 2022 05:29:34 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 26E5Qugv020279;
        Thu, 14 Jul 2022 05:29:33 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hacbg0y6p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Jul 2022 05:29:33 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26E5Lulp032192;
        Thu, 14 Jul 2022 05:29:30 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04fra.de.ibm.com with ESMTP id 3h99s79smu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Jul 2022 05:29:30 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26E5TSZj24445338
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jul 2022 05:29:28 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3B29F11C04A;
        Thu, 14 Jul 2022 05:29:28 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 54C1F11C052;
        Thu, 14 Jul 2022 05:29:24 +0000 (GMT)
Received: from [9.43.119.34] (unknown [9.43.119.34])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 14 Jul 2022 05:29:24 +0000 (GMT)
Message-ID: <1c4bfd5d-80ac-6fc7-80aa-89aaad5cd73a@linux.ibm.com>
Date:   Thu, 14 Jul 2022 10:59:23 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v8 00/12] mm/demotion: Memory tiers and demotion
Content-Language: en-US
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
        akpm@linux-foundation.org, Wei Xu <weixugc@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim C Chen <tim.c.chen@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>, jvgediya.oss@gmail.com
References: <20220704070612.299585-1-aneesh.kumar@linux.ibm.com>
 <87r130b2rh.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <60e97fa2-0b89-cf42-5307-5a57c956f741@linux.ibm.com>
 <87r12r5dwu.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <0a55e48a-b4b7-4477-a72f-73644b5fc4cb@linux.ibm.com>
 <87mtde6cla.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <fef35622-0bd4-f220-26bd-37d8e0112c4d@linux.ibm.com>
 <87ilo267jl.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ad4b095b-bb85-b01f-5d69-383219384c29@linux.ibm.com>
 <87edyp67m1.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <878roxuz9l.fsf@linux.ibm.com>
 <87o7xs47hk.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
In-Reply-To: <87o7xs47hk.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: rLsLoEBidXnbP1GZF5y6PSnPEy9fKIRP
X-Proofpoint-GUID: yPT6qeX1jwUO_xPyhSp5VNaYb0s6_e3t
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-14_03,2022-07-13_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207140022
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/14/22 10:26 AM, Huang, Ying wrote:
> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
> 
>> "Huang, Ying" <ying.huang@intel.com> writes:
> 
> [snip]
> 
>>>
>>> I believe that sparse memory tier IDs can make memory tier more stable
>>> in some cases.  But this is different from the system suggested by
>>> Johannes.  Per my understanding, with Johannes' system, we will
>>>
>>> - one driver may online different memory types (such as kmem_dax may
>>>   online HBM, PMEM, etc.)
>>>
>>> - one memory type manages several memory nodes (NUMA nodes)
>>>
>>> - one "abstract distance" for each memory type
>>>
>>> - the "abstract distance" can be offset by user space override knob
>>>
>>> - memory tiers generated dynamic from different memory types according
>>>   "abstract distance" and overridden "offset"
>>>
>>> - the granularity to group several memory types into one memory tier can
>>>   be overridden via user space knob
>>>
>>> In this way, the memory tiers may be changed totally after user space
>>> overridden.  It may be hard to link memory tiers before/after the
>>> overridden.  So we may need to reset all per-memory-tier configuration,
>>> such as cgroup paritation limit or interleave weight, etc.
>>
>> Making sure we all agree on the details.
>>
>> In the proposal https://lore.kernel.org/linux-mm/7b72ccf4-f4ae-cb4e-f411-74d055482026@linux.ibm.com
>> instead of calling it "abstract distance" I was referring it as device
>> attributes.
>>
>> Johannes also suggested these device attributes/"abstract distance"
>> to be used to derive the memory tier to which the memory type/memory
>> device will be assigned.
>>
>> So dax kmem would manage different types of memory and based on the device
>> attributes, we would assign them to different memory tiers (memory tiers
>> in the range [0-200)).
>>
>> Now the additional detail here is that we might add knobs that will be
>> used by dax kmem to fine-tune memory types to memory tiers assignment.
>> On updating these knob values, the kernel should rebuild the entire
>> memory tier hierarchy. (earlier I was considering only newly added
>> memory devices will get impacted by such a change. But I agree it
>> makes sense to rebuild the entire hierarchy again) But that rebuilding
>> will be restricted to dax kmem driver.
>>
> 
> Thanks for explanation and pointer.  Per my understanding, memory
> types and memory devices including abstract distances are used to
> describe the *physical* memory devices, not *policy*.  We may add more
> physical attributes to these memory devices, such as, latency,
> throughput, etc.  I think we can reach consensus on this point?
> 
> In contrast, memory tiers are more about policy, such as
> demotion/promotion, interleaving and possible partition among cgroups.
> How to derive memory tiers from memory types (or devices)?  We have
> multiple choices.
> 

agreed to the above.

> Per my understanding, Johannes suggested to use some policy parameters
> such as distance granularity (e.g., if granularity is 100, then memory
> devices with abstract distance 0-100, 100-200, 200-300, ... will be put
> to memory tier 0, 1, 2, ...) to build the memory tiers.  Distance
> granularity may be not flexible enough, we may need something like a set
> of cutoffs or range, e.g., 50, 100, 200, 500, or 0-50, 50-100, 100-200,
> 200-500, >500.  These policy parameters should be overridable from user
> space.
> 

The term distance was always confusing to me. Instead, I was generalizing it as an attribute.
The challenge with the term distance for me was in clarifying the distance of this memory device from
where? Instead, it is much simpler to group devices based on device attributes such as write latency.

So everything you explained above is correct, except we describe it in terms of a
single device attribute or a combination of multiple device attributes. We could convert
a combination of multiple device attribute to an "abstract distance". Such an
"abstract distance" is derived based on different device attribute values with
policy parameters overridable from userspace.


> And per my understanding, you suggested to place memory devices to
> memory tiers directly via a knob of memory types (or memory devices).
> e.g., memory_type/memtier can be written to place the memory devices of
> the memory_type to the specified memtier.  Or via
> memorty_type/distance_offset to do that.
> 

What I explained above is what I would expect the kernel to do by default. Before we can
reach there we need to get a better understanding of which device attribute describes
the grouping of memory devices to a memory tier. Do we need latency-based grouping
or bandwidth-based grouping? Till then userspace can place these devices to different
memory tiers. Hence the addition of /sys/devices/system/node/nodeN/memtier write feature
which moves a memory node to a specific memory tier. 

I am not suggesting we override the memory types from userspace.

-aneesh
