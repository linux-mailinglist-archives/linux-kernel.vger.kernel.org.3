Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8910A53A62E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 15:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353342AbiFANuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 09:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353343AbiFANuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 09:50:32 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F8186EC76
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 06:50:31 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 251DmiCu019891;
        Wed, 1 Jun 2022 13:50:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=gd/mAvxg6Bz73rNeoqmbmUJ9MdEG/m90e3ZyXInA21E=;
 b=HuCaI40sOIxSa+JS5iZQzl7UwNGR6mCyN7RZxYMEQnmDzcFMEBCogcVRz7Rmr2lOvv01
 BXNutyF3dyN3VyJv5ku8qC16xNkc3zfclzwBu4bFNgdYWdpXlVuVutpem16CmGDWUnkW
 hG+AiyjQlt1IJfBGHOSPR2bFCLXYEG5HnrmAjpCpYEQQ8GyKEdAQQsJb4OsIF+VpkLin
 2K1sFleb1crK2wIMybe03Q1i9eAfpGxIh2ffd3Vla37R6nSwPn5LIaVootE8qDPG+WQd
 P3iujfEli1PdI1p11K+tki+Bo3K2mRemYIyKkiYLtV94gc1fh63mnrJavYDhCilEsHIE xA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ge4uq6asq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Jun 2022 13:50:11 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 251DFg5K023790;
        Wed, 1 Jun 2022 13:50:10 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ge4uq6art-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Jun 2022 13:50:10 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 251DbiiQ022897;
        Wed, 1 Jun 2022 13:50:08 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03fra.de.ibm.com with ESMTP id 3gbc97vah7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Jun 2022 13:50:08 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 251Do5dH20513098
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Jun 2022 13:50:05 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AF598AE045;
        Wed,  1 Jun 2022 13:50:05 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A5B4FAE04D;
        Wed,  1 Jun 2022 13:49:59 +0000 (GMT)
Received: from [9.43.5.42] (unknown [9.43.5.42])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  1 Jun 2022 13:49:59 +0000 (GMT)
Message-ID: <8e651a1e-d189-3e8a-438f-298f21402bd2@linux.ibm.com>
Date:   Wed, 1 Jun 2022 19:19:58 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RFC PATCH v4 4/7] mm/demotion/dax/kmem: Set node's memory tier
 to MEMORY_TIER_PMEM
Content-Language: en-US
To:     Bharata B Rao <bharata@amd.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org
Cc:     Huang Ying <ying.huang@intel.com>,
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
References: <CAAPL-u-dFp7PwPH6DfbYdnY8xaGsHz3tRQ0CPGVkiqURvdN8=A@mail.gmail.com>
 <20220527122528.129445-1-aneesh.kumar@linux.ibm.com>
 <20220527122528.129445-5-aneesh.kumar@linux.ibm.com>
 <5706f5e9-0609-98c9-a0cd-7d96336d73dd@amd.com>
From:   Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
In-Reply-To: <5706f5e9-0609-98c9-a0cd-7d96336d73dd@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Jz76fgsrFINs26AyXgYS2-7RW_TmK5u-
X-Proofpoint-GUID: 6T5w-AvgdYptZO8KVBG9aa4vAB8s5fo1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-01_04,2022-06-01_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 adultscore=0 mlxscore=0 suspectscore=0 spamscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1011 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206010062
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/1/22 11:59 AM, Bharata B Rao wrote:
> On 5/27/2022 5:55 PM, Aneesh Kumar K.V wrote:
>> From: Jagdish Gediya <jvgediya@linux.ibm.com>
>>
>> By default, all nodes are assigned to DEFAULT_MEMORY_TIER which
>> is memory tier 1 which is designated for nodes with DRAM, so it
>> is not the right tier for dax devices.
>>
>> Set dax kmem device node's tier to MEMORY_TIER_PMEM, In future,
>> support should be added to distinguish the dax-devices which should
>> not be MEMORY_TIER_PMEM and right memory tier should be set for them.
>>
>> Signed-off-by: Jagdish Gediya <jvgediya@linux.ibm.com>
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>> ---
>>   drivers/dax/kmem.c | 4 ++++
>>   mm/migrate.c       | 2 ++
>>   2 files changed, 6 insertions(+)
>>
>> diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
>> index a37622060fff..991782aa2448 100644
>> --- a/drivers/dax/kmem.c
>> +++ b/drivers/dax/kmem.c
>> @@ -11,6 +11,7 @@
>>   #include <linux/fs.h>
>>   #include <linux/mm.h>
>>   #include <linux/mman.h>
>> +#include <linux/migrate.h>
>>   #include "dax-private.h"
>>   #include "bus.h"
>>   
>> @@ -147,6 +148,9 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
>>   
>>   	dev_set_drvdata(dev, data);
>>   
>> +#ifdef CONFIG_TIERED_MEMORY
>> +	node_set_memory_tier(numa_node, MEMORY_TIER_PMEM);
>> +#endif
> 
> I was experimenting with this patchset and found this behaviour.
> Here's what I did:
> 
> Boot a KVM guest with vNVDIMM device which ends up with device_dax
> driver by default.
> 
> Use it as RAM by binding it to dax kmem driver. It now appears as
> RAM with a new NUMA node that is put to memtier1 (the existing tier
> where DRAM already exists)
> 

That should have placed it in memtier2.

> I can move it to memtier2 (MEMORY_RANK_PMEM) manually, but isn't
> that expected to happen automatically when a node with dax kmem
> device comes up?
> 

This can happen if we have added the same NUMA node to memtier1 before 
dax kmem driver initialized the pmem memory. Can you check before the 
above node_set_memory_tier_rank() whether the specific NUMA node is 
already part of any memory tier?

Thank you for testing the patchset.
-aneesh

