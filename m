Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A17575AA838
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 08:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235376AbiIBGpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 02:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233557AbiIBGpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 02:45:04 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 572751010
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 23:45:00 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2826gWN4015477;
        Fri, 2 Sep 2022 06:44:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=oXfhblV9Gn509Y6lsGhV9mLyu7HT0FI0E4q3AT34Jts=;
 b=r2je0uCUUgYTQcWTwSYN70/0y+ay8pqVL2pV4dBVbTTd82Hxl4liJKoSFRoSIdMaTfV9
 Drmjr+ChhfjS/8oIyk1TYe2bkRRKyHpEzrHzQ16BOmG6m+TpGQeBVmahzj9jXLdvFmRJ
 GNLKHNQeRB7q7p6LvEhL2tYpsgSUYxQncEMt3l6Qr5A+jcJCQdg+lsj0zcP4+qMWrikZ
 ZWJPVjfC2O/hBI2H2XS0CW3ABOSHySMjmNqsITnWFji8Y+SnlsCMRk43upJn7eUm7qvQ
 KaiNS4iB+7XYLTFm5+FANdCl8dwy/arp7EsqDf1DF31WEDKBK2XwDuI3qp38jx/4fQbN WQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jbcsu8215-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Sep 2022 06:44:44 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2826hYGC018244;
        Fri, 2 Sep 2022 06:44:44 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jbcsu81ye-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Sep 2022 06:44:43 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2826aBFV005974;
        Fri, 2 Sep 2022 06:44:41 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma05fra.de.ibm.com with ESMTP id 3j7aw8wp5h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Sep 2022 06:44:41 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2826j1ED40436108
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 2 Sep 2022 06:45:01 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DA9F04C04A;
        Fri,  2 Sep 2022 06:44:38 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0BECA4C040;
        Fri,  2 Sep 2022 06:44:33 +0000 (GMT)
Received: from [9.43.64.219] (unknown [9.43.64.219])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  2 Sep 2022 06:44:32 +0000 (GMT)
Message-ID: <45488760-02b5-115b-c16d-5219303f2f33@linux.ibm.com>
Date:   Fri, 2 Sep 2022 12:14:31 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v3 updated] mm/demotion: Expose memory tier details via
 sysfs
Content-Language: en-US
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Wei Xu <weixugc@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <shy828301@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim C Chen <tim.c.chen@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        jvgediya.oss@gmail.com, Bharata B Rao <bharata@amd.com>,
        Greg Thelen <gthelen@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <20220830081736.119281-1-aneesh.kumar@linux.ibm.com>
 <87tu5rzigc.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ad19e105-9290-922d-59e6-e6813a30f5f0@linux.ibm.com>
 <87pmgezkhp.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <CAAPL-u8MEs04DkHy6kaS788VjdYZZjAYOgzMnioOzDXbc0ZhhQ@mail.gmail.com>
 <d91beb53-e940-e02a-f9ca-3326bf914da7@linux.ibm.com>
 <87fshaz63h.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <698120ce-d4df-3d13-dea9-a8f5c298783c@linux.ibm.com>
 <87bkryz4nh.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <2b4ddc45-74ae-27df-d973-6724f61f4e18@linux.ibm.com>
 <877d2mz3c1.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
In-Reply-To: <877d2mz3c1.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: id3h1xHQI30Uq9IFIfXdbOVYH4Nu8qtS
X-Proofpoint-GUID: Vy__WMwFUcpmib_RCUdVcQyq-Vg3vas3
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-01_12,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 clxscore=1015
 phishscore=0 mlxscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209020029
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/2/22 12:10 PM, Huang, Ying wrote:
> Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> writes:
> 
>> On 9/2/22 11:42 AM, Huang, Ying wrote:
>>> Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> writes:
>>>
>>>> On 9/2/22 11:10 AM, Huang, Ying wrote:
>>>>> Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> writes:
>>>>>
>>>>>> On 9/2/22 10:39 AM, Wei Xu wrote:
>>>>>>> On Thu, Sep 1, 2022 at 5:33 PM Huang, Ying <ying.huang@intel.com> wrote:
>>>>>>>>
>>>>>>>> Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> writes:
>>>>>>>>
>>>>>>>>> On 9/1/22 12:31 PM, Huang, Ying wrote:
>>>>>>>>>> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
>>>>>>>>>>
>>>>>>>>>>> This patch adds /sys/devices/virtual/memory_tiering/ where all memory tier
>>>>>>>>>>> related details can be found. All allocated memory tiers will be listed
>>>>>>>>>>> there as /sys/devices/virtual/memory_tiering/memory_tierN/
>>>>>>>>>>>
>>>>>>>>>>> The nodes which are part of a specific memory tier can be listed via
>>>>>>>>>>> /sys/devices/virtual/memory_tiering/memory_tierN/nodes
>>>>>>>>>>
>>>>>>>>>> I think "memory_tier" is a better subsystem/bus name than
>>>>>>>>>> memory_tiering.  Because we have a set of memory_tierN devices inside.
>>>>>>>>>> "memory_tier" sounds more natural.  I know this is subjective, just my
>>>>>>>>>> preference.
>>>>>>>>>>
>>>>>>
>>>>>>
>>>>>> I missed replying to this earlier. I will keep memory_tiering as subsystem name in v4 
>>>>>> because we would want it to a susbsystem where all memory tiering related details can be found
>>>>>> including memory type in the future. This is as per discussion 
>>>>>>
>>>>>> https://lore.kernel.org/linux-mm/CAAPL-u9TKbHGztAF=r-io3gkX7gorUunS2UfstudCWuihrA=0g@mail.gmail.com
>>>>>
>>>>> I don't think that it's a good idea to mix 2 types of devices in one
>>>>> subsystem (bus).  If my understanding were correct, that breaks the
>>>>> driver core convention.
>>>>>
>>>>
>>>> All these are virtual devices .I am not sure i follow what you mean by 2 types of devices.
>>>> memory_tiering is a subsystem that represents all the details w.r.t memory tiering. It shows
>>>> details of memory tiers and can possibly contain details of different memory types .
>>>
>>> IMHO, memory_tier and memory_type are 2 kind of devices.  They have
>>> almost totally different attributes (sysfs file).  So, we should create
>>> 2 buses for them.  Each has its own attribute group.  "virtual" itself
>>> isn't a subsystem.
>>
>> Considering both the details are related to memory tiering, wouldn't it be much simpler we consolidate
>> them within the same subdirectory? I am still not clear why you are suggesting they need to be in different
>> sysfs hierarchy.  It doesn't break any driver core convention as you mentioned earlier. 
>>
>> /sys/devices/virtual/memory_tiering/memory_tierN
>> /sys/devices/virtual/memory_tiering/memory_typeN
> 
> I think we should add
> 
>  /sys/devices/virtual/memory_tier/memory_tierN
>  /sys/devices/virtual/memory_type/memory_typeN
> 

I am trying to find if there is a technical reason to do the same? 

> I don't think this is complex.  Devices of same bus/subsystem should
> have mostly same attributes.  This is my understanding of driver core
> convention.
> 

I was not looking at this from code complexity point. Instead of having multiple directories
with details w.r.t memory tiering, I was looking at consolidating the details
within the directory /sys/devices/virtual/memory_tiering. (similar to all virtual devices
are consolidated within /sys/devics/virtual/).

-aneesh

