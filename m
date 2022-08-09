Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B36358D34C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 07:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234940AbiHIFlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 01:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233673AbiHIFln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 01:41:43 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F21125DB
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 22:41:42 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2794obfn036061;
        Tue, 9 Aug 2022 05:41:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=WkIbFEOkPmK9UE8789KKdSs/NYWfyLh4YmkPmJENNzk=;
 b=myF+xfhHDnSqitw7HdwxaCypTL0ZtH/I7zVOcsP+Aihhi7Ba+GDxpNrur1p6nHaXEIVK
 cSQoJrvQa71IitIdI+vnx150Sn3R/3iCeaFnP4UCUYdehOdLa3EXgxiSJYcW91tggXtP
 B2z/LexF2wrgBDXrgkx8e/ZZAiDJI88XsFF37BMw462NcjgasnVR59oZJlJNiQ1gzG/R
 0ELQsCz31PTeX3jNpuTiZSs5certKz8KJ+gS6tMQCwQNgfEBXS2HHglofBbKC5eYfF+5
 L0XvMneoDSvzfVF6KyCO0i2z6dYvIk82BrCGHYGs6fSNXd3WUQyNR9gurMydXbt4r9nE 0A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hugwph7kt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Aug 2022 05:41:26 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2794tlRF009940;
        Tue, 9 Aug 2022 05:41:25 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hugwph7k3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Aug 2022 05:41:25 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2795b8tm029421;
        Tue, 9 Aug 2022 05:41:23 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3hu4rp8n0a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Aug 2022 05:41:23 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2795fK9j26149144
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 9 Aug 2022 05:41:20 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A1F4CAE04D;
        Tue,  9 Aug 2022 05:41:20 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D978EAE045;
        Tue,  9 Aug 2022 05:41:16 +0000 (GMT)
Received: from [9.109.205.170] (unknown [9.109.205.170])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  9 Aug 2022 05:41:16 +0000 (GMT)
Message-ID: <f3590060-3b7b-e576-0742-bd0dae8c760d@linux.ibm.com>
Date:   Tue, 9 Aug 2022 11:11:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v13 6/9] mm/demotion: Add pg_data_t member to track node
 memory tier details
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
References: <20220808062601.836025-1-aneesh.kumar@linux.ibm.com>
 <20220808062601.836025-7-aneesh.kumar@linux.ibm.com>
 <87bksugfex.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
In-Reply-To: <87bksugfex.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: uUA-OyQIaDlI8_E4PCctLJX_yhkN7Kca
X-Proofpoint-GUID: yYCoDjjhtkS2ON-eZC172paZ_oNBD07e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-08_14,2022-08-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=999 lowpriorityscore=0
 impostorscore=0 phishscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208090023
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/9/22 10:51 AM, Huang, Ying wrote:
> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
> 
>> Also update different helpes to use NODE_DATA()->memtier. Since
>> node specific memtier can change based on the reassignment of
>> NUMA node to a different memory tiers, accessing NODE_DATA()->memtier
>> needs to happen under an rcu read lock or memory_tier_lock.
>>
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>> ---
>>  include/linux/mmzone.h |  3 +++
>>  mm/memory-tiers.c      | 38 ++++++++++++++++++++++++++++++++------
>>  2 files changed, 35 insertions(+), 6 deletions(-)
>>
>> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
>> index aab70355d64f..353812495a70 100644
>> --- a/include/linux/mmzone.h
>> +++ b/include/linux/mmzone.h
>> @@ -928,6 +928,9 @@ typedef struct pglist_data {
>>  	/* Per-node vmstats */
>>  	struct per_cpu_nodestat __percpu *per_cpu_nodestats;
>>  	atomic_long_t		vm_stat[NR_VM_NODE_STAT_ITEMS];
>> +#ifdef CONFIG_NUMA
>> +	struct memory_tier __rcu *memtier;
>> +#endif
>>  } pg_data_t;
>>  
>>  #define node_present_pages(nid)	(NODE_DATA(nid)->node_present_pages)
>> diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
>> index 02e514e87d5c..3778ac6a44a1 100644
>> --- a/mm/memory-tiers.c
>> +++ b/mm/memory-tiers.c
>> @@ -5,6 +5,7 @@
>>  #include <linux/kobject.h>
>>  #include <linux/memory.h>
>>  #include <linux/random.h>
>> +#include <linux/mmzone.h>
>>  #include <linux/memory-tiers.h>
>>  
>>  #include "internal.h"
>> @@ -137,12 +138,18 @@ static struct memory_tier *find_create_memory_tier(struct memory_dev_type *memty
>>  
>>  static struct memory_tier *__node_get_memory_tier(int node)
>>  {
>> -	struct memory_dev_type *memtype;
>> +	pg_data_t *pgdat;
>>  
>> -	memtype = node_memory_types[node];
>> -	if (memtype && node_isset(node, memtype->nodes))
>> -		return memtype->memtier;
>> -	return NULL;
> 
> After adding pgdat->memtier, it appears there's unnecessary to keep
> memtype->memtier?
> 

It do simplify find_create_memory_tier() where I use if (memtype->memtier) 
to check whether the memtype is already added to a memory tier. I could switch
that to list_empty(memtype->tier_sibiling). But I felt the current one is much
cleaner
.
-aneesh
