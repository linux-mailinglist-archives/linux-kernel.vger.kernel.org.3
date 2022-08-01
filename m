Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D81E9586395
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 06:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239483AbiHAElR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 00:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232156AbiHAElQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 00:41:16 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3973E13E18
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 21:41:15 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2714cg0C029348;
        Mon, 1 Aug 2022 04:40:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=uhpKx3x0xG9N3j2V9BpIaZmBpPxWP4s8h0X7qAg6OhY=;
 b=ZzRmp3uhrlC7a8mH6AAQMtSq8C3gZeyheV+v/gom7bg/yquWEGofRRaPSgYYS5y6SW2M
 9h8KW4Wavf6qxgairLyjPOtH8IznDbiTXyJRtWtimTK6blRg4XpxAifC/GJ7Qd3yXRkq
 fgEEmILYs2X4Yf2pieWP+BK8EGeoLhpE62qJNzWFV3ODGyMFaOlf5Pq2LzgYgWkjxCm8
 fjYWxR//0Esc/4Jvxit8Cq7PXbcdYeubgMUg51FgQAd/lCisgsDjDLMO0ffLieGONCHw
 Ab0KGPzEfTiiKQUTk/F4LhDcEqpTCayvXUmouY8VGM7FIM5ZU/n7CzLg/ykuK5VgCwDW KA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hp51q3t2b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Aug 2022 04:40:49 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2714Huj1018438;
        Mon, 1 Aug 2022 04:40:48 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hp51q3t1u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Aug 2022 04:40:48 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2714Zabi032343;
        Mon, 1 Aug 2022 04:40:46 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 3hmv98snq7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Aug 2022 04:40:46 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2714ehVG21823866
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 1 Aug 2022 04:40:43 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B6879AE04D;
        Mon,  1 Aug 2022 04:40:43 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4F528AE045;
        Mon,  1 Aug 2022 04:40:40 +0000 (GMT)
Received: from [9.43.22.209] (unknown [9.43.22.209])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  1 Aug 2022 04:40:40 +0000 (GMT)
Message-ID: <e5545c90-9595-d08c-8a1c-1c15e3b94999@linux.ibm.com>
Date:   Mon, 1 Aug 2022 10:10:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v11 4/8] mm/demotion/dax/kmem: Set node's abstract
 distance to MEMTIER_ADISTANCE_PMEM
Content-Language: en-US
To:     "Huang, Ying" <ying.huang@intel.com>
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
        Dan Williams <dan.j.williams@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>, jvgediya.oss@gmail.com
References: <20220728190436.858458-1-aneesh.kumar@linux.ibm.com>
 <20220728190436.858458-5-aneesh.kumar@linux.ibm.com>
 <875yjgmocg.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <87bkt8s7w9.fsf@linux.ibm.com>
 <87k07slnt7.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
In-Reply-To: <87k07slnt7.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: M1GP1LNOeqYg8rUFG5j6zI2HEJ6fJ9BQ
X-Proofpoint-ORIG-GUID: QRYI9fI8bNG1DvGisY4jgeL4iFNBpJcO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-01_01,2022-07-28_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 spamscore=0 impostorscore=0 suspectscore=0 mlxscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 bulkscore=0 mlxlogscore=999 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2208010024
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/1/22 7:36 AM, Huang, Ying wrote:
> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
> 
>> "Huang, Ying" <ying.huang@intel.com> writes:
>>
>>> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
>>>
>>>> By default, all nodes are assigned to the default memory tier which
>>>> is the memory tier designated for nodes with DRAM
>>>>
>>>> Set dax kmem device node's tier to slower memory tier by assigning
>>>> abstract distance to MEMTIER_ADISTANCE_PMEM. PMEM tier
>>>> appears below the default memory tier in demotion order.
>>>>
>>>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>>>> ---
>>>>  drivers/dax/kmem.c           |  9 +++++++++
>>>>  include/linux/memory-tiers.h | 19 ++++++++++++++++++-
>>>>  mm/memory-tiers.c            | 28 ++++++++++++++++------------
>>>>  3 files changed, 43 insertions(+), 13 deletions(-)
>>>>
>>>> diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
>>>> index a37622060fff..6b0d5de9a3e9 100644
>>>> --- a/drivers/dax/kmem.c
>>>> +++ b/drivers/dax/kmem.c
>>>> @@ -11,6 +11,7 @@
>>>>  #include <linux/fs.h>
>>>>  #include <linux/mm.h>
>>>>  #include <linux/mman.h>
>>>> +#include <linux/memory-tiers.h>
>>>>  #include "dax-private.h"
>>>>  #include "bus.h"
>>>>  
>>>> @@ -41,6 +42,12 @@ struct dax_kmem_data {
>>>>  	struct resource *res[];
>>>>  };
>>>>  
>>>> +static struct memory_dev_type default_pmem_type  = {
>>>
>>> Why is this named as default_pmem_type?  We will not change the memory
>>> type of a node usually.
>>>
>>
>> Any other suggestion? pmem_dev_type? 
> 
> Or dax_pmem_type?
> 
> DAX is used to enumerate the memory device.
> 
>>
>>>> +	.adistance = MEMTIER_ADISTANCE_PMEM,
>>>> +	.tier_sibiling = LIST_HEAD_INIT(default_pmem_type.tier_sibiling),
>>>> +	.nodes  = NODE_MASK_NONE,
>>>> +};
>>>> +
>>>>  static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
>>>>  {
>>>>  	struct device *dev = &dev_dax->dev;
>>>> @@ -62,6 +69,8 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
>>>>  		return -EINVAL;
>>>>  	}
>>>>  
>>>> +	init_node_memory_type(numa_node, &default_pmem_type);
>>>> +
>>>
>>> The memory hot-add below may fail.  So the error handling needs to be
>>> added.
>>>
>>> And, it appears that the memory type and memory tier of a node may be
>>> fully initialized here before NUMA hot-adding started.  So I suggest to
>>> set node_memory_types[] here only.  And set memory_dev_type->nodes in
>>> node hot-add callback.  I think there is the proper place to complete
>>> the initialization.
>>>
>>> And, in theory dax/kmem.c can be unloaded.  So we need to clear
>>> node_memory_types[] for nodes somewhere.
>>>
>>
>> I guess by module exit we can be sure that all the memory managed
>> by dax/kmem is hotplugged out. How about something like below?
> 
> Because we set node_memorty_types[] in dev_dax_kmem_probe(), it's
> natural to clear it in dev_dax_kmem_remove().
> 

Most of required reset/clear is done as part of memory hotunplug. So
if we did manage to successfully unplug the memory, everything except
node_memory_types[node] should be reset. That makes the clear_node_memory_type
the below. 

void clear_node_memory_type(int node, struct memory_dev_type *memtype)
{

	mutex_lock(&memory_tier_lock);
	/*
	 * memory unplug did clear the node from the memtype and
	 * dax/kem did initialize this node's memory type.
	 */
	if (!node_isset(node, memtype->nodes) && node_memory_types[node]  == memtype){
		node_memory_types[node] = NULL;
	}
	mutex_unlock(&memory_tier_lock);
}

With the module unload, it is kind of force removing the usage of the specific memtype.
Considering module unload will remove the usage of specific memtype from other parts
of the kernel and we already do all the required reset in memory hot unplug, do we
need to do the clear_node_memory_type above? 

-aneesh



