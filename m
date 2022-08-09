Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 563B258D34E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 07:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234986AbiHIFnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 01:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232887AbiHIFnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 01:43:42 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432F41837E
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 22:43:42 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2794KPiw022113;
        Tue, 9 Aug 2022 05:43:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=5ML01rEQdxKrXfhJZ3nSqAy731kwFucqNO6kjqIfVZc=;
 b=QtE0xM6P9bPH/BfKV/eebyM8/8hOlRmdXyJD4N/apHHBdMTtBt2p2rMg9BeyzdZr2KSs
 RwOWJgjee6rXKF+z0oj9RH8Hk9/RmHeUtzObTH21EMG1/JVLQamR+krYS7io9krM4+fU
 KGqssYumQxWlqMaA8VOQ+s3BaG/85mxJZhyuKkeWEFaMrsVmKKYpTcxH4op0mvURmJHy
 JaBZo2Mlp9u/ufd3OwxXBVtGUPisewPp1dgWoYfe5k6gM+IWVY65Kpu0YIdrbpEvxbGu
 4OrnnUId3nofGeUAgVU47OGa0y3R6X4iXSUc9Yy9ug2ZqnZa11fgig4j4kq15LqYIuGY yQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3hugfhj2df-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Aug 2022 05:43:24 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2795UDNZ002492;
        Tue, 9 Aug 2022 05:43:24 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3hugfhj2ch-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Aug 2022 05:43:23 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2795awwE029647;
        Tue, 9 Aug 2022 05:43:22 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3hsfx8u12x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Aug 2022 05:43:21 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2795hJ5p31457606
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 9 Aug 2022 05:43:19 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B5A42AE04D;
        Tue,  9 Aug 2022 05:43:19 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5729DAE045;
        Tue,  9 Aug 2022 05:43:16 +0000 (GMT)
Received: from [9.109.205.170] (unknown [9.109.205.170])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  9 Aug 2022 05:43:16 +0000 (GMT)
Message-ID: <51770b88-fbf1-52e7-6d40-666e1fcfb0f2@linux.ibm.com>
Date:   Tue, 9 Aug 2022 11:13:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v13 9/9] lib/nodemask: Optimize node_random for nodemask
 with single NUMA node
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
 <20220808062601.836025-10-aneesh.kumar@linux.ibm.com>
 <87fsi6glcd.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
In-Reply-To: <87fsi6glcd.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -Ly7tQrQtziRCvobwpwhL1cxPA9bNukI
X-Proofpoint-ORIG-GUID: QgdNn5Itlc-TUmkNblQoePq00WiWf8e2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-08_14,2022-08-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 priorityscore=1501 clxscore=1015 impostorscore=0 malwarescore=0
 suspectscore=0 spamscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

On 8/9/22 8:43 AM, Huang, Ying wrote:
> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
> 
>> The most common case for certain node_random usage (demotion nodemask) is with
>> nodemask weight 1. We can avoid calling get_random_init() in that case and
>> always return the only node set in the nodemask.
> 
> I think that this patch can sit between [5/9] and [6/9], just after it
> is used.
> 
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>> ---
>>  lib/nodemask.c | 15 ++++++++++++---
>>  1 file changed, 12 insertions(+), 3 deletions(-)
>>
>> diff --git a/lib/nodemask.c b/lib/nodemask.c
>> index e22647f5181b..c91a6b0404a5 100644
>> --- a/lib/nodemask.c
>> +++ b/lib/nodemask.c
>> @@ -20,12 +20,21 @@ EXPORT_SYMBOL(__next_node_in);
>>   */
>>  int node_random(const nodemask_t *maskp)
>>  {
>> -	int w, bit = NUMA_NO_NODE;
>> +	int w, bit;
>>  
>>  	w = nodes_weight(*maskp);
>> -	if (w)
>> +	switch (w) {
>> +	case 0:
>> +		bit = NUMA_NO_NODE;
>> +		break;
>> +	case 1:
>> +		bit = __first_node(maskp);
> 
> Per my understanding, first_node() is the formal API and we should use
> that?  Just like we use nodes_weight() instead of __nodes_weight().
> 

updated.

-aneesh
