Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8EE1589728
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 06:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237391AbiHDEuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 00:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbiHDEuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 00:50:07 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF465C352
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 21:50:06 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2744mUbQ018314;
        Thu, 4 Aug 2022 04:49:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=PIWE/PiIIheKEv4Y5dIX9cPVbmHbGIPQiok4XK13+No=;
 b=EQcOIg6nFsWr4D9B/eBUnv27wSekg4R6XsD3Y4XzbQj6FIjJPTmoZcAB1qAiQvHjeelZ
 DW6PrIvW6QlP/TwHfYfUGmfXyWs0TK/m2+9Nn+XwMYAC6sVoIr7COvbI0DU+T/cE7ZiN
 xUTQIMYKCORMlbieZuPZWysJZCmb6LXXLfyWBA4ItSp9cz28LC+k4iJ/KwcsJWAlTMRk
 WbftYYffaJQ0K7MFjFF0fJ1kcDVEpS76GsaOP6/8hks3rgC2pKtqfMAx3fBiXAmKBbEb
 6GfNW53nX0DVqW5sOftOzIUFkHq+2cSAzcYE3iq4s9nzueQLoIBa/5HhVFwhlqOHh1eq yA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3hr7dp80rp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Aug 2022 04:49:52 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2744n3AX020101;
        Thu, 4 Aug 2022 04:49:51 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3hr7dp80r5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Aug 2022 04:49:51 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2744bs5x017610;
        Thu, 4 Aug 2022 04:49:49 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 3hmuwhwq0f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Aug 2022 04:49:49 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2744nkD511076016
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 4 Aug 2022 04:49:46 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9F4B552050;
        Thu,  4 Aug 2022 04:49:46 +0000 (GMT)
Received: from [9.109.205.170] (unknown [9.109.205.170])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 84B735204F;
        Thu,  4 Aug 2022 04:49:43 +0000 (GMT)
Message-ID: <30212141-9f72-6727-ce7b-74623c25552c@linux.ibm.com>
Date:   Thu, 4 Aug 2022 10:19:42 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v11 1/8] mm/demotion: Add support for explicit memory
 tiers
Content-Language: en-US
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, linux-mm@kvack.org,
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
        Johannes Weiner <hannes@cmpxchg.org>, jvgediya.oss@gmail.com,
        Jagdish Gediya <jvgediya@linux.ibm.com>
References: <20220728190436.858458-1-aneesh.kumar@linux.ibm.com>
 <20220728190436.858458-2-aneesh.kumar@linux.ibm.com>
 <62e890da7f784_577a029473@dwillia2-xfh.jf.intel.com.notmuch>
 <874jyvjpw9.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <62e89c9addcc_62c2a29443@dwillia2-xfh.jf.intel.com.notmuch>
 <87zggni13h.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <4a96a3ff-9cb7-4e71-3e9f-95fbd99f5201@linux.ibm.com>
 <87r11wj07a.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
In-Reply-To: <87r11wj07a.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kOkBU8Os7QDCm4j-bA3q2ycg93y6Qv7X
X-Proofpoint-ORIG-GUID: mbDzg2-keoSEqTmhvrn6Nhk-4EKUihOj
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-04_01,2022-08-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 phishscore=0 mlxscore=0 spamscore=0
 adultscore=0 clxscore=1015 bulkscore=0 impostorscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208040019
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/4/22 6:26 AM, Huang, Ying wrote:
> Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> writes:
> 
>> On 8/2/22 12:27 PM, Huang, Ying wrote:
>>> Dan Williams <dan.j.williams@intel.com> writes:
>>>
>>>> Huang, Ying wrote:
>>>>> Dan Williams <dan.j.williams@intel.com> writes:
>>>>>
>>>>>> Aneesh Kumar K.V wrote:
>>>>>>> In the current kernel, memory tiers are defined implicitly via a demotion path
>>>>>>> relationship between NUMA nodes, which is created during the kernel
>>>>>>> initialization and updated when a NUMA node is hot-added or hot-removed. The
>>>>>>> current implementation puts all nodes with CPU into the highest tier, and builds
>>>>>>> the tier hierarchy tier-by-tier by establishing the per-node demotion targets
>>>>>>> based on the distances between nodes.
>>>>>>>
>>>>>>> This current memory tier kernel implementation needs to be improved for several
>>>>>>> important use cases,
>>>>>>>
>>>>>>> The current tier initialization code always initializes each memory-only NUMA
>>>>>>> node into a lower tier. But a memory-only NUMA node may have a high performance
>>>>>>> memory device (e.g. a DRAM-backed memory-only node on a virtual machine) that
>>>>>>> should be put into a higher tier.
>>>>>>>
>>>>>>> The current tier hierarchy always puts CPU nodes into the top tier. But on a
>>>>>>> system with HBM or GPU devices, the memory-only NUMA nodes mapping these devices
>>>>>>> should be in the top tier, and DRAM nodes with CPUs are better to be placed into
>>>>>>> the next lower tier.
>>>>>>>
>>>>>>> With current kernel higher tier node can only be demoted to nodes with shortest
>>>>>>> distance on the next lower tier as defined by the demotion path, not any other
>>>>>>> node from any lower tier. This strict, demotion order does not work in all use
>>>>>>> cases (e.g. some use cases may want to allow cross-socket demotion to another
>>>>>>> node in the same demotion tier as a fallback when the preferred demotion node is
>>>>>>> out of space), This demotion order is also inconsistent with the page allocation
>>>>>>> fallback order when all the nodes in a higher tier are out of space: The page
>>>>>>> allocation can fall back to any node from any lower tier, whereas the demotion
>>>>>>> order doesn't allow that.
>>>>>>>
>>>>>>> This patch series address the above by defining memory tiers explicitly.
>>>>>>>
>>>>>>> Linux kernel presents memory devices as NUMA nodes and each memory device is of
>>>>>>> a specific type. The memory type of a device is represented by its abstract
>>>>>>> distance. A memory tier corresponds to a range of abstract distance. This allows
>>>>>>> for classifying memory devices with a specific performance range into a memory
>>>>>>> tier.
>>>>>>>
>>>>>>> This patch configures the range/chunk size to be 128. The default DRAM
>>>>>>> abstract distance is 512. We can have 4 memory tiers below the default DRAM
>>>>>>> abstract distance which cover the range 0 - 127, 127 - 255, 256- 383, 384 - 511.
>>>>>>> Slower memory devices like persistent memory will have abstract distance below
>>>>>>> the default DRAM level and hence will be placed in these 4 lower tiers.
>>>>>>>
>>>>>>> A kernel parameter is provided to override the default memory tier.
>>>>>>>
>>>>>>> Link: https://lore.kernel.org/linux-mm/CAAPL-u9Wv+nH1VOZTj=9p9S70Y3Qz3+63EkqncRDdHfubsrjfw@mail.gmail.com
>>>>>>> Link: https://lore.kernel.org/linux-mm/7b72ccf4-f4ae-cb4e-f411-74d055482026@linux.ibm.com
>>>>>>>
>>>>>>> Signed-off-by: Jagdish Gediya <jvgediya@linux.ibm.com>
>>>>>>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>>>>>>> ---
>>>>>>>  include/linux/memory-tiers.h |  17 ++++++
>>>>>>>  mm/Makefile                  |   1 +
>>>>>>>  mm/memory-tiers.c            | 102 +++++++++++++++++++++++++++++++++++
>>>>>>>  3 files changed, 120 insertions(+)
>>>>>>>  create mode 100644 include/linux/memory-tiers.h
>>>>>>>  create mode 100644 mm/memory-tiers.c
>>>>>>>
>>>>>>> diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
>>>>>>> new file mode 100644
>>>>>>> index 000000000000..8d7884b7a3f0
>>>>>>> --- /dev/null
>>>>>>> +++ b/include/linux/memory-tiers.h
>>>>>>> @@ -0,0 +1,17 @@
>>>>>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>>>>>> +#ifndef _LINUX_MEMORY_TIERS_H
>>>>>>> +#define _LINUX_MEMORY_TIERS_H
>>>>>>> +
>>>>>>> +/*
>>>>>>> + * Each tier cover a abstrace distance chunk size of 128
>>>>>>> + */
>>>>>>> +#define MEMTIER_CHUNK_BITS	7
>>>>>>> +#define MEMTIER_CHUNK_SIZE	(1 << MEMTIER_CHUNK_BITS)
>>>>>>> +/*
>>>>>>> + * For now let's have 4 memory tier below default DRAM tier.
>>>>>>> + */
>>>>>>> +#define MEMTIER_ADISTANCE_DRAM	(1 << (MEMTIER_CHUNK_BITS + 2))
>>>>>>> +/* leave one tier below this slow pmem */
>>>>>>> +#define MEMTIER_ADISTANCE_PMEM	(1 << MEMTIER_CHUNK_BITS)
>>>>>>
>>>>>> Why is memory type encoded in these values? There is no reason to
>>>>>> believe that PMEM is of a lower performance tier than DRAM. Consider
>>>>>> high performance energy backed DRAM that makes it "PMEM", consider CXL
>>>>>> attached DRAM over a switch topology and constrained links that makes it
>>>>>> a lower performance tier than locally attached DRAM. The names should be
>>>>>> associated with tiers that indicate their usage. Something like HOT,
>>>>>> GENERAL, and COLD. Where, for example, HOT is low capacity high
>>>>>> performance compared to the general purpose pool, and COLD is high
>>>>>> capacity low performance intended to offload the general purpose tier.
>>>>>>
>>>>>> It does not need to be exactly that ontology, but please try to not
>>>>>> encode policy meaning behind memory types. There has been explicit
>>>>>> effort to avoid that to date because types are fraught for declaring
>>>>>> relative performance characteristics, and the relative performance
>>>>>> changes based on what memory types are assembled in a given system.
>>>>>
>>>>> Yes.  MEMTIER_ADISTANCE_PMEM is something over simplified.  That is only
>>>>> used in this very first version to make it as simple as possible.  
>>>>
>>>> I am failing to see the simplicity of using names that convey a
>>>> performance contract that are invalid depending on the system.
>>>>
>>>>> I think we can come up with something better in the later version.
>>>>> For example, identify the abstract distance of a PMEM device based on
>>>>> HMAT, etc. 
>>>>
>>>> Memory tiering has nothing to do with persistence why is PMEM in the
>>>> name at all?
>>>>
>>>>>  And even in this first version, we should put MEMTIER_ADISTANCE_PMEM
>>>>>  in dax/kmem.c.  Because it's just for that specific type of memory
>>>>>  used now, not for all PMEM.
>>>>
>>>> dax/kmem.c also handles HBM and "soft reserved" memory in general. There
>>>> is also nothing PMEM specific about the device-dax subsystem.
>>>
>>> Ah... I see the issue here.  For the systems in our hand, dax/kmem.c is
>>> used to online PMEM only.  Even the "soft reserved" memory is used for
>>> PMEM or simulating PMEM too.  So to make the code as simple as possible,
>>> we treat all memory devices onlined by dax/kmem as PMEM in the first
>>> version.  And plan to support more memory types in the future versions.
>>>
>>> But from your above words, our assumption are wrong here.  dax/kmem.c
>>> can online HBM and other memory devices already.  If so, how do we
>>> distinguish between them and how to get the performance character of
>>> these devices?  We can start with SLIT?
>>>
>>
>> We would let low level driver register memory_dev_types for the NUMA nodes
>> that will be mapped to these devices. ie, a papr_scm, ACPI NFIT or CXL
>> can register different memory_dev_type based on device tree, HMAT or CDAT. 
> 
> I didn't find ACPI NFIT can provide any performance information, just
> whether it's non-volatile.  HMAT or CDAT should help here, but it's not
> available always.  For now, what we have is just SLIT at least for quite
> some machines.
> 


The lower level driver that is creating the nvdimm regions can assign a
memory type to the numa node which it associates with the region. For now,
drivers like papr_scm do that on ppc64. When it associates a numa node to
nvdimm regions, it can query every detail available (device tree
in case of papr_scm, can be HMAT/SLIT or CDAT) to associate the NUMA node
to a memory type. 


> I prefer to create memory_dev_type in high level driver like dax/kmem.
> And it may query low level driver like SLIT, HMAT, CDAT, etc for more
> information based on availability etc.
> 
> Best Regards,
> Huang, Ying

