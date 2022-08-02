Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF5895879EE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 11:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235951AbiHBJfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 05:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235668AbiHBJf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 05:35:28 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 284AD25C7D
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 02:35:27 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 272902tU030844;
        Tue, 2 Aug 2022 09:34:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=oJ7DR1kW4R/+AYKFCNKuc6PXP4aoZi9kyAn9658g1hA=;
 b=MCtz9XvZapYO1C3vQ+GPuK8rBsvDEdF4u4GYX+DcaPJ9d8U2YaA6czThfi/fn0P/n0fV
 ogSFrwSZr5n6i7x+c1CpEHa4uS6P/jx61bIVLCPssvtxoDaP3mf/w2Jp7DEx5hEV+2XR
 3JhxacbQizVvp0gfTOMxA+nRDJxXAaoB0Yc7ZGbj7mru9csCUgkqXVt2xMpjwaUgr1v0
 byuZ5HI6YunYofGZGKFSRsD8ucPA6giOoAvyo5Qr7RvugvLA+z0X6ZRX4rPYWqOXqiXI
 zQIihA7Rs8lSW3Iwv7qP0MA9bPGjxzdVladGU+On6TQcrlSrt2/ZXD9KdxDKhRBciS6w hQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hq0wk962n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Aug 2022 09:34:59 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27290BTd031568;
        Tue, 2 Aug 2022 09:34:58 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hq0wk960w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Aug 2022 09:34:58 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2729KNmQ024313;
        Tue, 2 Aug 2022 09:34:56 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03fra.de.ibm.com with ESMTP id 3hmv98thy4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Aug 2022 09:34:56 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2729Yrqs28639524
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 2 Aug 2022 09:34:54 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DA9385204E;
        Tue,  2 Aug 2022 09:34:53 +0000 (GMT)
Received: from [9.109.205.170] (unknown [9.109.205.170])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 74AE352051;
        Tue,  2 Aug 2022 09:34:50 +0000 (GMT)
Message-ID: <4a96a3ff-9cb7-4e71-3e9f-95fbd99f5201@linux.ibm.com>
Date:   Tue, 2 Aug 2022 15:04:49 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v11 1/8] mm/demotion: Add support for explicit memory
 tiers
Content-Language: en-US
To:     "Huang, Ying" <ying.huang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
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
        Johannes Weiner <hannes@cmpxchg.org>, jvgediya.oss@gmail.com,
        Jagdish Gediya <jvgediya@linux.ibm.com>
References: <20220728190436.858458-1-aneesh.kumar@linux.ibm.com>
 <20220728190436.858458-2-aneesh.kumar@linux.ibm.com>
 <62e890da7f784_577a029473@dwillia2-xfh.jf.intel.com.notmuch>
 <874jyvjpw9.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <62e89c9addcc_62c2a29443@dwillia2-xfh.jf.intel.com.notmuch>
 <87zggni13h.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
In-Reply-To: <87zggni13h.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 7jHd0GF7BfMAr2vA2k1i1BGcNaBi51UK
X-Proofpoint-GUID: OLV5QL1dWnWElADmr6aso0K7xzLXdO2P
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-02_05,2022-08-01_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 priorityscore=1501 bulkscore=0 suspectscore=0 clxscore=1015
 impostorscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208020046
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/2/22 12:27 PM, Huang, Ying wrote:
> Dan Williams <dan.j.williams@intel.com> writes:
> 
>> Huang, Ying wrote:
>>> Dan Williams <dan.j.williams@intel.com> writes:
>>>
>>>> Aneesh Kumar K.V wrote:
>>>>> In the current kernel, memory tiers are defined implicitly via a demotion path
>>>>> relationship between NUMA nodes, which is created during the kernel
>>>>> initialization and updated when a NUMA node is hot-added or hot-removed. The
>>>>> current implementation puts all nodes with CPU into the highest tier, and builds
>>>>> the tier hierarchy tier-by-tier by establishing the per-node demotion targets
>>>>> based on the distances between nodes.
>>>>>
>>>>> This current memory tier kernel implementation needs to be improved for several
>>>>> important use cases,
>>>>>
>>>>> The current tier initialization code always initializes each memory-only NUMA
>>>>> node into a lower tier. But a memory-only NUMA node may have a high performance
>>>>> memory device (e.g. a DRAM-backed memory-only node on a virtual machine) that
>>>>> should be put into a higher tier.
>>>>>
>>>>> The current tier hierarchy always puts CPU nodes into the top tier. But on a
>>>>> system with HBM or GPU devices, the memory-only NUMA nodes mapping these devices
>>>>> should be in the top tier, and DRAM nodes with CPUs are better to be placed into
>>>>> the next lower tier.
>>>>>
>>>>> With current kernel higher tier node can only be demoted to nodes with shortest
>>>>> distance on the next lower tier as defined by the demotion path, not any other
>>>>> node from any lower tier. This strict, demotion order does not work in all use
>>>>> cases (e.g. some use cases may want to allow cross-socket demotion to another
>>>>> node in the same demotion tier as a fallback when the preferred demotion node is
>>>>> out of space), This demotion order is also inconsistent with the page allocation
>>>>> fallback order when all the nodes in a higher tier are out of space: The page
>>>>> allocation can fall back to any node from any lower tier, whereas the demotion
>>>>> order doesn't allow that.
>>>>>
>>>>> This patch series address the above by defining memory tiers explicitly.
>>>>>
>>>>> Linux kernel presents memory devices as NUMA nodes and each memory device is of
>>>>> a specific type. The memory type of a device is represented by its abstract
>>>>> distance. A memory tier corresponds to a range of abstract distance. This allows
>>>>> for classifying memory devices with a specific performance range into a memory
>>>>> tier.
>>>>>
>>>>> This patch configures the range/chunk size to be 128. The default DRAM
>>>>> abstract distance is 512. We can have 4 memory tiers below the default DRAM
>>>>> abstract distance which cover the range 0 - 127, 127 - 255, 256- 383, 384 - 511.
>>>>> Slower memory devices like persistent memory will have abstract distance below
>>>>> the default DRAM level and hence will be placed in these 4 lower tiers.
>>>>>
>>>>> A kernel parameter is provided to override the default memory tier.
>>>>>
>>>>> Link: https://lore.kernel.org/linux-mm/CAAPL-u9Wv+nH1VOZTj=9p9S70Y3Qz3+63EkqncRDdHfubsrjfw@mail.gmail.com
>>>>> Link: https://lore.kernel.org/linux-mm/7b72ccf4-f4ae-cb4e-f411-74d055482026@linux.ibm.com
>>>>>
>>>>> Signed-off-by: Jagdish Gediya <jvgediya@linux.ibm.com>
>>>>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>>>>> ---
>>>>>  include/linux/memory-tiers.h |  17 ++++++
>>>>>  mm/Makefile                  |   1 +
>>>>>  mm/memory-tiers.c            | 102 +++++++++++++++++++++++++++++++++++
>>>>>  3 files changed, 120 insertions(+)
>>>>>  create mode 100644 include/linux/memory-tiers.h
>>>>>  create mode 100644 mm/memory-tiers.c
>>>>>
>>>>> diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
>>>>> new file mode 100644
>>>>> index 000000000000..8d7884b7a3f0
>>>>> --- /dev/null
>>>>> +++ b/include/linux/memory-tiers.h
>>>>> @@ -0,0 +1,17 @@
>>>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>>>> +#ifndef _LINUX_MEMORY_TIERS_H
>>>>> +#define _LINUX_MEMORY_TIERS_H
>>>>> +
>>>>> +/*
>>>>> + * Each tier cover a abstrace distance chunk size of 128
>>>>> + */
>>>>> +#define MEMTIER_CHUNK_BITS	7
>>>>> +#define MEMTIER_CHUNK_SIZE	(1 << MEMTIER_CHUNK_BITS)
>>>>> +/*
>>>>> + * For now let's have 4 memory tier below default DRAM tier.
>>>>> + */
>>>>> +#define MEMTIER_ADISTANCE_DRAM	(1 << (MEMTIER_CHUNK_BITS + 2))
>>>>> +/* leave one tier below this slow pmem */
>>>>> +#define MEMTIER_ADISTANCE_PMEM	(1 << MEMTIER_CHUNK_BITS)
>>>>
>>>> Why is memory type encoded in these values? There is no reason to
>>>> believe that PMEM is of a lower performance tier than DRAM. Consider
>>>> high performance energy backed DRAM that makes it "PMEM", consider CXL
>>>> attached DRAM over a switch topology and constrained links that makes it
>>>> a lower performance tier than locally attached DRAM. The names should be
>>>> associated with tiers that indicate their usage. Something like HOT,
>>>> GENERAL, and COLD. Where, for example, HOT is low capacity high
>>>> performance compared to the general purpose pool, and COLD is high
>>>> capacity low performance intended to offload the general purpose tier.
>>>>
>>>> It does not need to be exactly that ontology, but please try to not
>>>> encode policy meaning behind memory types. There has been explicit
>>>> effort to avoid that to date because types are fraught for declaring
>>>> relative performance characteristics, and the relative performance
>>>> changes based on what memory types are assembled in a given system.
>>>
>>> Yes.  MEMTIER_ADISTANCE_PMEM is something over simplified.  That is only
>>> used in this very first version to make it as simple as possible.  
>>
>> I am failing to see the simplicity of using names that convey a
>> performance contract that are invalid depending on the system.
>>
>>> I think we can come up with something better in the later version.
>>> For example, identify the abstract distance of a PMEM device based on
>>> HMAT, etc. 
>>
>> Memory tiering has nothing to do with persistence why is PMEM in the
>> name at all?
>>
>>>  And even in this first version, we should put MEMTIER_ADISTANCE_PMEM
>>>  in dax/kmem.c.  Because it's just for that specific type of memory
>>>  used now, not for all PMEM.
>>
>> dax/kmem.c also handles HBM and "soft reserved" memory in general. There
>> is also nothing PMEM specific about the device-dax subsystem.
> 
> Ah... I see the issue here.  For the systems in our hand, dax/kmem.c is
> used to online PMEM only.  Even the "soft reserved" memory is used for
> PMEM or simulating PMEM too.  So to make the code as simple as possible,
> we treat all memory devices onlined by dax/kmem as PMEM in the first
> version.  And plan to support more memory types in the future versions.
> 
> But from your above words, our assumption are wrong here.  dax/kmem.c
> can online HBM and other memory devices already.  If so, how do we
> distinguish between them and how to get the performance character of
> these devices?  We can start with SLIT?
> 

We would let low level driver register memory_dev_types for the NUMA nodes
that will be mapped to these devices. ie, a papr_scm, ACPI NFIT or CXL
can register different memory_dev_type based on device tree, HMAT or CDAT. 

-aneesh
