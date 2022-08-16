Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E95C595431
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 09:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232191AbiHPH4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 03:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbiHPHze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 03:55:34 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C8CEEE696
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 22:10:15 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27G3wpen016972;
        Tue, 16 Aug 2022 05:09:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=P19XZtC8DbmGNuNVe9dCbncvC8uJ1x9Uf1lARPCoMBo=;
 b=qZwMH/7qjRKYWUSYPLdzGSBsv5KU7jbx0/yGTZFRlUuvhNmpdVzUuBWabst2ViuaIXTN
 v5DAiHoRJkEDBV95e2+e4quz/V/qBM6KFITA95IhGLAuB7zdSvsU26cNSSmlQEPhMMFA
 5KbcBz0sgYjtUeMdrimRnjoxuXPuUZXI3mpbnb5RUJNSBRmwu+GSTklg2whmPNW/87RI
 eCxxp2lNK3I1KGKLfuoGyLkkjxhdmhWoBwRJRC6cHDBx1bf5QTcccTJI7iQ0Jk5xOtEF
 KWqTsZngAm1lgl7r/ltxJnyent3kExr5HeeJ8np/HYXAmRvpbtfGH3Mxa20TVZj6xZjP cQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j03td9cwk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Aug 2022 05:09:54 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27G4hLGC016612;
        Tue, 16 Aug 2022 05:09:53 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j03td9cvk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Aug 2022 05:09:53 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27G4pofp011776;
        Tue, 16 Aug 2022 05:09:50 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03fra.de.ibm.com with ESMTP id 3hx3k8t0f1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Aug 2022 05:09:50 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27G59mgS34275678
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Aug 2022 05:09:48 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 41F45AE04D;
        Tue, 16 Aug 2022 05:09:48 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 211C2AE045;
        Tue, 16 Aug 2022 05:09:45 +0000 (GMT)
Received: from [9.109.205.170] (unknown [9.109.205.170])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 16 Aug 2022 05:09:44 +0000 (GMT)
Message-ID: <cd1c13ee-6fc3-bde8-96f9-8c3c93441275@linux.ibm.com>
Date:   Tue, 16 Aug 2022 10:39:44 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v14 04/10] mm/demotion/dax/kmem: Set node's abstract
 distance to MEMTIER_DEFAULT_DAX_ADISTANCE
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
        Johannes Weiner <hannes@cmpxchg.org>, jvgediya.oss@gmail.com,
        Bharata B Rao <bharata@amd.com>
References: <20220812055710.357820-1-aneesh.kumar@linux.ibm.com>
 <20220812055710.357820-5-aneesh.kumar@linux.ibm.com>
 <87wnbacjsh.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
In-Reply-To: <87wnbacjsh.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jiFcPnLpu9RytBmaMO2o5ofaKJ7p6sBP
X-Proofpoint-ORIG-GUID: y7Ia0hHGE22LCmXAPvzcvekG2o1CGWQs
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-16_03,2022-08-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 adultscore=0 bulkscore=0 priorityscore=1501 mlxscore=0 phishscore=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208160019
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/15/22 8:09 AM, Huang, Ying wrote:
> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
> 
>> By default, all nodes are assigned to the default memory tier which
>> is the memory tier designated for nodes with DRAM
>>
>> Set dax kmem device node's tier to slower memory tier by assigning
>> abstract distance to MEMTIER_DEFAULT_DAX_ADISTANCE. Low-level drivers
>> like papr_scm or ACPI NFIT can initialize memory device type to a
>> more accurate value based on device tree details or HMAT. If the
>> kernel doesn't find the memory type initialized, a default slower
>> memory type is assigned by the kmem driver.
>>
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>> ---
>>  drivers/dax/kmem.c           | 42 +++++++++++++++--
>>  include/linux/memory-tiers.h | 42 ++++++++++++++++-
>>  mm/memory-tiers.c            | 91 +++++++++++++++++++++++++++---------
>>  3 files changed, 149 insertions(+), 26 deletions(-)
>>
>> diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
>> index a37622060fff..d88814f1c414 100644
>> --- a/drivers/dax/kmem.c
>> +++ b/drivers/dax/kmem.c
>> @@ -11,9 +11,17 @@
>>  #include <linux/fs.h>
>>  #include <linux/mm.h>
>>  #include <linux/mman.h>
>> +#include <linux/memory-tiers.h>
>>  #include "dax-private.h"
>>  #include "bus.h"
>>  
>> +/*
>> + * Default abstract distance assigned to the NUMA node onlined
>> + * by DAX/kmem if the low level platform driver didn't initialize
>> + * one for this NUMA node.
>> + */
>> +#define MEMTIER_DEFAULT_DAX_ADISTANCE	(MEMTIER_ADISTANCE_DRAM * 2)
> 
> If my understanding were correct, this is targeting Optane DCPMM for
> now.  The measured results in the following paper is,
> 
> https://arxiv.org/pdf/2002.06018.pdf
> 
> Section: 2.1 Read/Write Latencies
> 
> "
> For read access, the latency of DCPMM was 400.1% higher than that of
> DRAM. For write access, it was 407.1% higher.
> "
> 
> Section: 2.2 Read/Write Bandwidths
> 
> "
> For read access, the throughput of DCPMM was 37.1% of DRAM. For write
> access, it was 7.8%
> "
> 
> According to the above data, I think the MEMTIER_DEFAULT_DAX_ADISTANCE
> can be "5 * MEMTIER_ADISTANCE_DRAM".
> 

If we look at mapping every 100% increase in latency as a memory tier, we essentially
will have 4 memory tier here. Each memory tier is covering a range of abstract distance 128.
which makes a total adistance increase from MEMTIER_ADISTANCE_DRAM by 512. This puts 
DEFAULT_DAX_DISTANCE at 1024 or  MEMTIER_ADISTANCE_DRAM * 2

-aneesh

