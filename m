Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C633C581295
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 14:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238941AbiGZMAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 08:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238962AbiGZMA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 08:00:28 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C40E132EC3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 05:00:27 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26QAV9Ar027515;
        Tue, 26 Jul 2022 12:00:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=pUJ9hVGmoW1g5dUuSJMrZiPBT3Gn9gvcys//WFaFVdc=;
 b=XMaSkbLJWsVoaQU6q6X752BIomSxVd2UJG9ojXDdFG73NrVfk+gb5aqh9a7C9tbuOjyK
 S2aWUzZnwXYL23Xlm0byqycVsQTkozgBMTGx3CBlEGJ+5Rt+OjHEtS249bxty4od1ju9
 BNjaPwjcL059sU2sWcncaU5tSHsGpSG8p7Ibmhu99dSrvuIz+6Hh/FKmLGoZWd5YlRDE
 yY3oh/tLNJVivydrH4JOssmT6O5fq3vJPhYd7eC43uEUQTidPlbZyCRYp+iLc1h5K8CB
 6G1jJhaPszH/0gYTLJrSyFeSjc86taSnqeRNQwAo2c609XRix741furQMjwYd2ESlA1f BA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hjcq2x1hb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Jul 2022 12:00:07 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 26QBifIq013547;
        Tue, 26 Jul 2022 12:00:07 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hjcq2x1ef-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Jul 2022 12:00:06 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26QBq8wU005557;
        Tue, 26 Jul 2022 12:00:03 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06fra.de.ibm.com with ESMTP id 3hg98fhbjh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Jul 2022 12:00:03 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26QC00QR20513262
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Jul 2022 12:00:00 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D165542041;
        Tue, 26 Jul 2022 12:00:00 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0F1FD4203F;
        Tue, 26 Jul 2022 11:59:57 +0000 (GMT)
Received: from [9.43.64.160] (unknown [9.43.64.160])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 26 Jul 2022 11:59:56 +0000 (GMT)
Message-ID: <9e9ba2e4-3a87-3a79-e336-8849dad4856a@linux.ibm.com>
Date:   Tue, 26 Jul 2022 17:29:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v10 1/8] mm/demotion: Add support for explicit memory
 tiers
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
        Jagdish Gediya <jvgediya@linux.ibm.com>
References: <20220720025920.1373558-1-aneesh.kumar@linux.ibm.com>
 <20220720025920.1373558-2-aneesh.kumar@linux.ibm.com>
 <87k080wmvb.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
In-Reply-To: <87k080wmvb.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6y-OBH2B61fOSCTU1nTn3MeBZEcvUzei
X-Proofpoint-GUID: 4ya5gc6aGV8hUKqHfsCN-R6E9lFp-wQW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-26_04,2022-07-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207260043
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> diff --git a/include/linux/node.h b/include/linux/node.h
>> index 40d641a8bfb0..a2a16d4104fd 100644
>> --- a/include/linux/node.h
>> +++ b/include/linux/node.h
>> @@ -92,6 +92,12 @@ struct node {
>>  	struct list_head cache_attrs;
>>  	struct device *cache_dev;
>>  #endif
>> +	/*
>> +	 * For memory devices, perf_level describes
>> +	 * the device performance and how it should be used
>> +	 * while building a memory hierarchy.
>> +	 */
>> +	int perf_level;
> 
> Think again, I found that "perf_level" may be not the best abstraction
> of the performance of memory devices.  In concept, it's an abstraction of the memory
> bandwidth.  But it will not reflect the memory latency.
> 
> Instead, the previous proposed "abstract_distance" is an abstraction of
> the memory latency.  Per my understanding, the memory latency has more
> direct influence on system performance.  And because the latency of the
> memory device will increase if the memory accessing throughput nears its
> max bandwidth, so the memory bandwidth can be reflected in the "abstract
> distance" too.  That is, the "abstract distance" is an abstraction of
> the memory latency under the expected memory accessing throughput.  The
> "offset" to the default "abstract distance" reflects the different
> expected memory accessing throughput.
> 
> So, I think we need some kind of abstraction of the memory latency
> instead of memory bandwidth, e.g., "abstract distance".
> 

I am reworking other parts of the patch set based on your feedback. This part
I guess we need to reach some consensus. 

IMHO perf_level (performance level) can indicate a combination of both latency
and bandwidth. It is an abstract concept that indicates the performance of the
device. As we learn more about which device attribute makes more impact in
defining hierarchy, performance level will give more weightage to that specific
attribute. It could be write latency or bandwidth. For me, distance has a direct
linkage to latency because that is how we define numa distance now. Adding
abstract to the name is not making it more abstract than perf_level. 

I am open to suggestions from others.  Wei Xu has also suggested perf_level name.
I can rename this to abstract_distance if that indicates the goal better.


-aneesh

