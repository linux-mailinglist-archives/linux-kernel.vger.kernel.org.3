Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40A1E5438A3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 18:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245254AbiFHQQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 12:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245263AbiFHQQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 12:16:07 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED694667C
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 09:16:06 -0700 (PDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 258G46D4008343;
        Wed, 8 Jun 2022 16:15:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=RYpIPpUz753ngwR1UwTc/RTtwIYGK+V+8sLhAcMQujE=;
 b=SvjjZ9PKdhaAFOotcQI+aFuTJaVbDHVjcNB6pttvL35mMbB9q2ykMLKsyHVsWFYz4SMC
 t4CGqcRXHuDM87l/qFjAd9rFoJJ1RxMGnoaJX08H81pp0Hhpllm0aJscebBizr3FGKA7
 6GiT5qc4g82S0TNMsEe+QBke+RoqoIdUn53QsXU3az05Mf2zcUVxbsSpUQ4HxPxhiUv5
 nR0cV4VVi2oa1zvULZkyCspYJfjq3Q+xZjjGWhhMitw5HG5BK3yCoQm1HSOB5BfUHhGe
 7cVnqeBfGfnUKcpt3hpc/UzXcbURmpNsknL/Ak0hY3CGq7Efw3gkYQzx/B2iVM/EaegT bg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gjvvm3fpp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Jun 2022 16:15:56 +0000
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 258FmO75021544;
        Wed, 8 Jun 2022 16:15:55 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gjvvm3fnr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Jun 2022 16:15:55 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 258Fq88i021798;
        Wed, 8 Jun 2022 16:15:53 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3gfy19dmx7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Jun 2022 16:15:53 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 258GFqdG22544894
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Jun 2022 16:15:53 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DB02C5204F;
        Wed,  8 Jun 2022 16:15:50 +0000 (GMT)
Received: from [9.43.53.124] (unknown [9.43.53.124])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id CE0705204E;
        Wed,  8 Jun 2022 16:15:44 +0000 (GMT)
Message-ID: <c810947d-26a4-96f9-de01-7f74e64877db@linux.ibm.com>
Date:   Wed, 8 Jun 2022 21:45:43 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v5 2/9] mm/demotion: Expose per node memory tier to sysfs
Content-Language: en-US
To:     Tim Chen <tim.c.chen@linux.intel.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org
Cc:     Wei Xu <weixugc@google.com>, Huang Ying <ying.huang@intel.com>,
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
References: <20220603134237.131362-1-aneesh.kumar@linux.ibm.com>
 <20220603134237.131362-3-aneesh.kumar@linux.ibm.com>
 <fa6b575dfea7c2131ecfec0f5578d72ca4acfd95.camel@linux.intel.com>
 <626023e8-8443-619e-18ee-a758c37fcec2@linux.ibm.com>
 <fe42ee1ebe85362f888010b1b310e456a49abb4f.camel@linux.intel.com>
From:   Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
In-Reply-To: <fe42ee1ebe85362f888010b1b310e456a49abb4f.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NvDdaqAk1ab3z8KB1xmubNOvHgEMwSU0
X-Proofpoint-ORIG-GUID: uN8Y7nCPra6bmDl1Og_OOyaZNt0yB6M2
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-08_05,2022-06-07_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 malwarescore=0 phishscore=0 priorityscore=1501 impostorscore=0 mlxscore=0
 clxscore=1015 spamscore=0 suspectscore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206080066
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/22 9:36 PM, Tim Chen wrote:
> On Wed, 2022-06-08 at 10:25 +0530, Aneesh Kumar K V wrote:
>> On 6/8/22 1:45 AM, Tim Chen wrote:
>>> On Fri, 2022-06-03 at 19:12 +0530, Aneesh Kumar K.V wrote:
>>>>    
>>>> +static struct memory_tier *__node_get_memory_tier(int node)
>>>> +{
>>>> +	struct memory_tier *memtier;
>>>> +
>>>> +	list_for_each_entry(memtier, &memory_tiers, list) {
>>>
>>> We could need to map node to mem_tier quite often, if we need
>>> to account memory usage at tier level.  It will be more efficient
>>> to have a pointer from node (pgdat) to memtier rather
>>> than doing a search through the list.
>>>
>>>
>>
>> That is something I was actively trying to avoid. Currently all struct
>> memory_tier references are with memory_tier_lock mutex held. That
>> simplify the locking and reference counting.
>>
>> As of now we are able to implement all the required interfaces without
>> pgdat having pointers to struct memory_tier. We can update pgdat with
>> memtier details when we are implementing changes requiring those. We
>> could keep additional memtier->dev reference to make sure memory tiers
>> are not destroyed while other part of the kernel is referencing the
>> same. But IMHO such changes should wait till we have users for the same.
>>
> 
> I think we should have an efficient mapping from node to memtier from
> the get go.  There are many easily envisioned scenarios where
> we need to map from node to memtier, which Ying pointed out.
> 

I did an initial implementation here. We need to make sure we can access 
NODE_DATA()->memtier lockless. Can you review the changes here

https://lore.kernel.org/linux-mm/87sfoffcfz.fsf@linux.ibm.com

-aneesh
