Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2729953EC36
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238168AbiFFNBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 09:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238150AbiFFNBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 09:01:23 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A83E752537
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 06:01:21 -0700 (PDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 256AqI1t023783;
        Mon, 6 Jun 2022 13:01:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=P2pTrKGmriKa8MjpMA2AodEX/embIURuicigU2uAguE=;
 b=YlC1LPUmx0gLwBkvBHC6AYHRBvQisdXXwgoJlGsyTwxAaRnuDg8SP9JS8BpD2wsWQRp2
 4Di/Pl1g2gY2bhpiwdjQyw25LFkiELFsk0E3JfnckoMoR1Q+UYaLcT34YlGbG4dRblUx
 /wqNA3Ns11vtnrdOiiFlFFbifJRTS+uqNVlDoolnxH8mzyZG3cWTc93MMZiKd6qlx73W
 zpWcsk1dSUKOyzWG+bgB+yjCdxGrnZXLygakwtu4jBBntwc1zU45VCa53PH+hm4eqiQg
 SWKjrorIr1q7mS/nBGnJW381a4mFqqdcTg+6XA5ZP1JlN1egpXdgDfzxYUsn9Zu/M7HQ Hg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gggr900vx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Jun 2022 13:01:03 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 256CTK5X014642;
        Mon, 6 Jun 2022 13:01:03 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gggr900u0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Jun 2022 13:01:02 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 256Cpg5j020245;
        Mon, 6 Jun 2022 13:00:59 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03ams.nl.ibm.com with ESMTP id 3gfy19adqq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Jun 2022 13:00:59 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 256D0voD12648854
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Jun 2022 13:00:57 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 28516A404D;
        Mon,  6 Jun 2022 13:00:57 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 229A1A4040;
        Mon,  6 Jun 2022 13:00:52 +0000 (GMT)
Received: from [9.43.87.254] (unknown [9.43.87.254])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  6 Jun 2022 13:00:51 +0000 (GMT)
Message-ID: <a3a7a8fe-5b54-d4ea-fdbf-c4b719c684d3@linux.ibm.com>
Date:   Mon, 6 Jun 2022 18:30:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
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
 <8e651a1e-d189-3e8a-438f-298f21402bd2@linux.ibm.com>
 <d45374fa-6e51-36cb-9a2c-96f85d9de528@amd.com>
 <c98eb873-a5bb-edcc-743d-89cfffe52cd9@linux.ibm.com>
 <d6c94fd5-053b-7e6f-dc4e-83184ecf131a@amd.com>
 <a844c8c9-e1e1-2ccb-d58c-a5a608afabc0@linux.ibm.com>
 <87fski80sx.fsf@linux.ibm.com> <eaf22a62-73c7-d96b-fcd8-4437eb3d8559@amd.com>
From:   Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
In-Reply-To: <eaf22a62-73c7-d96b-fcd8-4437eb3d8559@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: lzJsKC7-09VxNPdYZY2PR8UFTW5HgccR
X-Proofpoint-GUID: yDQ-_ayEtl6ToGmLOv8naK-5JGSOe49s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-06_04,2022-06-03_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0 clxscore=1015
 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206060057
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/6/22 5:39 PM, Bharata B Rao wrote:
> On 6/6/2022 5:24 PM, Aneesh Kumar K.V wrote:
>> Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> writes:
>>>
>> Can you try this change?
>>
>> diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
>> index 7a11c387fbbc..905609260dda 100644
>> --- a/drivers/dax/kmem.c
>> +++ b/drivers/dax/kmem.c
>> @@ -94,6 +94,17 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
>>   		goto err_reg_mgid;
>>   	data->mgid = rc;
>>   
>> +	/*
>> +	 * This get called before the node is brought online. That
>> +	 * is because depending on the value of mhp_default_online_type
>> +	 * the kernel will online the memory along with hotplug
>> +	 * operation. Add the new memory tier before we try to bring
>> +	 * memory blocks online. Otherwise new node will get added to
>> +	 * the default memory tier via hotplug callbacks.
>> +	 */
>> +#ifdef CONFIG_TIERED_MEMORY
>> +	node_set_memory_tier(numa_node, MEMORY_TIER_PMEM);
>> +#endif
>>   	for (i = 0; i < dev_dax->nr_range; i++) {
>>   		struct resource *res;
>>   		struct range range;
>> @@ -148,9 +159,6 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
>>   
>>   	dev_set_drvdata(dev, data);
>>   
>> -#ifdef CONFIG_TIERED_MEMORY
>> -	node_set_memory_tier(numa_node, MEMORY_TIER_PMEM);
>> -#endif
>>   	return 0;
>>   
>>   err_request_mem:
> 
> Yes, this fixes the issue for me. Thanks.
> 

I might put the below change instead of the above. In the end I guess it 
is better to add a NUMA node to memory tier after the node is brought 
online than before even though with the current code it shouldn't matter 
much.

modified   drivers/dax/kmem.c
@@ -147,9 +147,15 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
  	}

  	dev_set_drvdata(dev, data);
-
+	/*
+	 * node_reset_memory_tier is used here to ensure we force
+	 * update the NUMA node memory tier. Depending on the value
+	 * of mhp_default_online_type the kernel will online the memory
+	 * blocks along with hotplug operation above. This can result in dax
+	 * kmem memory NUMA node getting added to default memory tier.
+	 */
  #ifdef CONFIG_TIERED_MEMORY
-	node_set_memory_tier(numa_node, MEMORY_TIER_PMEM);
+	node_reset_memory_tier(numa_node, MEMORY_TIER_PMEM);
  #endif
  	return 0;

