Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBD354803C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 09:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238988AbiFMHGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 03:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238848AbiFMHFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 03:05:54 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9824D18E00
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 00:05:53 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25D4luJ0002090;
        Mon, 13 Jun 2022 07:05:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=90wNVQAs7GsbSew2Laoy8zLL4m7qa0zP4QQopuuLVg8=;
 b=lEmfzx2eUUy/PH3xxVgz+kfn0MfolmkOByJyPu7LUtDVHWmra95aUPIYUAUxXdXLSGnM
 SKzcD3aAp1d/ONui0kE/GQky8U8OciPohd1vVIKPecUwzXKYyhXKd0S638FskndvXhwJ
 Ybddxzj816l2owJmdWiyMjvhfBMiYJc92CzW7eLDYO2u12Rm03fIb9EKtjqy5o3Ibnbn
 wgYkKicJpwS5e3pXiLJiCZnBGWXjFlgGKRE3C1Hopgz4CFNuMKB7PuYU+F5zRDQ3TjQr
 CDJz0VOiM5pDAMwDaeFIUJDGcqGxE45CWJLi+M0uNPYrvAj1JkwGgJ/W82Bp3q+2gy+S vw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gn4qjhuvc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Jun 2022 07:05:39 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25D6Z5wf004498;
        Mon, 13 Jun 2022 07:05:38 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gn4qjhuuq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Jun 2022 07:05:38 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25D6oKfB008989;
        Mon, 13 Jun 2022 07:05:36 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 3gmjajaavr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Jun 2022 07:05:36 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25D75YoT22413788
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jun 2022 07:05:34 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 34DCDA405B;
        Mon, 13 Jun 2022 07:05:34 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A06F0A4060;
        Mon, 13 Jun 2022 07:05:28 +0000 (GMT)
Received: from [9.43.31.74] (unknown [9.43.31.74])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 13 Jun 2022 07:05:28 +0000 (GMT)
Message-ID: <81e5904b-73f7-2977-d135-2d27c6c216ac@linux.ibm.com>
Date:   Mon, 13 Jun 2022 12:35:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v6 04/13] mm/demotion/dax/kmem: Set node's memory tier to
 MEMORY_TIER_PMEM
Content-Language: en-US
To:     Ying Huang <ying.huang@intel.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org
Cc:     Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
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
References: <20220610135229.182859-1-aneesh.kumar@linux.ibm.com>
 <20220610135229.182859-5-aneesh.kumar@linux.ibm.com>
 <193ad45f2ec47ac157a812975f3e4235fcbc061a.camel@intel.com>
From:   Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
In-Reply-To: <193ad45f2ec47ac157a812975f3e4235fcbc061a.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BKl-RWz6saa2SjyTpViSL0jofm2AofLH
X-Proofpoint-ORIG-GUID: j5fUOnyPl-nbkQoFImUumeAQy9XudaRP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-13_02,2022-06-09_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 priorityscore=1501
 phishscore=0 impostorscore=0 clxscore=1015 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206130030
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/13/22 12:29 PM, Ying Huang wrote:
> On Fri, 2022-06-10 at 19:22 +0530, Aneesh Kumar K.V wrote:
>> By default, all nodes are assigned to DEFAULT_MEMORY_TIER which
>> is the memory tier designated for nodes with DRAM
>>
>> Set dax kmem device node's tier to MEMORY_TIER_PMEM. MEMORY_TIER_PMEM
>> is assigned a default rank value of 100 and appears below DEFAULT_MEMORY_TIER
>> in demotion order.
>>
>> Signed-off-by: Jagdish Gediya <jvgediya@linux.ibm.com>
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>> ---
>>   drivers/dax/kmem.c           |  4 ++
>>   include/linux/memory-tiers.h |  1 +
>>   mm/memory-tiers.c            | 78 ++++++++++++++++++++++++++++++++++++
>>   3 files changed, 83 insertions(+)
>>
>> diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
>> index a37622060fff..0cb3de3d138f 100644
>> --- a/drivers/dax/kmem.c
>> +++ b/drivers/dax/kmem.c
>> @@ -11,6 +11,7 @@
>>   #include <linux/fs.h>
>>   #include <linux/mm.h>
>>   #include <linux/mman.h>
>> +#include <linux/memory-tiers.h>
>>   #include "dax-private.h"
>>   #include "bus.h"
>>   
>>
>> @@ -147,6 +148,9 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
>>   
>>
>>   	dev_set_drvdata(dev, data);
>>   
>>
>> +#ifdef CONFIG_TIERED_MEMORY
>> +	node_create_and_set_memory_tier(numa_node, MEMORY_TIER_PMEM);
>> +#endif
>>   	return 0;
>>   
>>
>>   err_request_mem:
>> diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
>> index 44c3c3b16a36..e102ec73ab80 100644
>> --- a/include/linux/memory-tiers.h
>> +++ b/include/linux/memory-tiers.h
>> @@ -18,6 +18,7 @@
>>   #define MAX_MEMORY_TIERS  3
>>   
>>
>>   extern bool numa_demotion_enabled;
>> +int node_create_and_set_memory_tier(int node, int tier);
>>   #else
>>   #define numa_demotion_enabled	false
>>   
>>
>> diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
>> index c3123a457d90..00d393a5a628 100644
>> --- a/mm/memory-tiers.c
>> +++ b/mm/memory-tiers.c
>> @@ -67,6 +67,84 @@ static struct memory_tier *register_memory_tier(unsigned int tier,
>>   	return memtier;
>>   }
>>   
>>
>> +static struct memory_tier *__node_get_memory_tier(int node)
>> +{
>> +	struct memory_tier *memtier;
>> +
>> +	list_for_each_entry(memtier, &memory_tiers, list) {
>> +		if (node_isset(node, memtier->nodelist))
>> +			return memtier;
>> +	}
>> +	return NULL;
>> +}
>> +
> 
> I suggest to add NODE_DATA(nid)->mem_tier before this patch.  That is,
> part of [9/13].  That will make code much simpler and easier to
> review.
> 

I would still like to keep introducing that NODE_DATA()->memtier later, 
so that the everything before that can be reviewed with simpler locking. 
__node_get_memory_tier() get fixed in patch 9 where all the details of 
that lockless access is documented. This also enables one to look at the 
history later.

> And, in addition to dax_kmem, whenever a normal node is onlined, we
> need to add it to the default memory tier.  I found this is done in
> [5/13].  IMHO, we should move that part before this patch.
>

Sure will move the hotplug callback earlier.


-aneesh
