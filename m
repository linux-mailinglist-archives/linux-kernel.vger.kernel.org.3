Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0DB5AABB7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 11:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235751AbiIBJpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 05:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235744AbiIBJo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 05:44:56 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0120DD125
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 02:44:53 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2828wVw0009142;
        Fri, 2 Sep 2022 09:44:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=OHrCdqR+7nVowticktGiwfekN4OfMW/k6KwPMJ/DUGA=;
 b=Ao3hDPfZPJpIMMh7TyygNsdKsW9JuAwzV1khfeK5KWmYoZ2UPfhgghxWn5L/dYxEH2OX
 9N+qrqdVQpEgq+QMVbLNAUWBN06TbSYYOsFGTuhilZnRdzNub0u5IkzF6VkTD7ZHOZ65
 tot7Aj+rXOg53du8w6R7+B2f6XrVz3uoyx5kciSw4UHdzOwcKTjXVHXbG2R5j3kuXitB
 IWHvwJDeReQ1WdMlKmCBSf7Z1FFJqp+QbY0Psl7F9t4gHcvc5EIg2Swida5ExS9wobi5
 gKeyu8KrK8E1dXt5cGLMQPrKNxAYu3zRz30V4Kl2MBSj5g/nx9hTp56jllNeslwahoT8 EA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jbesvsj4g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Sep 2022 09:44:26 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2828xoaZ011574;
        Fri, 2 Sep 2022 09:44:25 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jbesvsj3k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Sep 2022 09:44:25 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2829a7ti018046;
        Fri, 2 Sep 2022 09:44:23 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma01fra.de.ibm.com with ESMTP id 3j8hkacnsd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Sep 2022 09:44:23 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2829iKaZ42139988
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 2 Sep 2022 09:44:20 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B58F9AE055;
        Fri,  2 Sep 2022 09:44:20 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5FA12AE04D;
        Fri,  2 Sep 2022 09:44:15 +0000 (GMT)
Received: from [9.43.81.233] (unknown [9.43.81.233])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  2 Sep 2022 09:44:15 +0000 (GMT)
Message-ID: <5aaf395d-514a-2717-58c6-3845b97692bd@linux.ibm.com>
Date:   Fri, 2 Sep 2022 15:14:14 +0530
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
 <45488760-02b5-115b-c16d-5219303f2f33@linux.ibm.com>
 <CAAPL-u_UoAQ9koo892sG-Tx4bi4xDRe9PUtjmFSsn90uU-n31g@mail.gmail.com>
 <871qsuyzr2.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <672e528d-40b7-fc12-9b0c-1591d586c079@linux.ibm.com>
 <87wnamxi30.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
In-Reply-To: <87wnamxi30.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ZfX0-LowShHPJLjikCQJmx_d2Dkg0j6M
X-Proofpoint-ORIG-GUID: Tshqiy_QkK55o91ca1MWM24NLLIaypB1
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-02_01,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 mlxlogscore=999 clxscore=1015
 spamscore=0 impostorscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209020045
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/2/22 2:34 PM, Huang, Ying wrote:
> Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> writes:
> 
>> On 9/2/22 1:27 PM, Huang, Ying wrote:
>>> Wei Xu <weixugc@google.com> writes:
>>>
>>>> On Thu, Sep 1, 2022 at 11:44 PM Aneesh Kumar K V
>>>> <aneesh.kumar@linux.ibm.com> wrote:
>>>>>
>>>>> On 9/2/22 12:10 PM, Huang, Ying wrote:
>>>>>> Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> writes:
>>>>>>
>>>>>>> On 9/2/22 11:42 AM, Huang, Ying wrote:
>>>>>>>> Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> writes:
>>>>>>>>
>>>>>>>>> On 9/2/22 11:10 AM, Huang, Ying wrote:
>>>>>>>>>> Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> writes:
>>>>>>>>>>
>>>>>>>>>>> On 9/2/22 10:39 AM, Wei Xu wrote:
>>>>>>>>>>>> On Thu, Sep 1, 2022 at 5:33 PM Huang, Ying <ying.huang@intel.com> wrote:
>>>>>>>>>>>>>
>>>>>>>>>>>>> Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> writes:
>>>>>>>>>>>>>
>>>>>>>>>>>>>> On 9/1/22 12:31 PM, Huang, Ying wrote:
>>>>>>>>>>>>>>> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> This patch adds /sys/devices/virtual/memory_tiering/ where all memory tier
>>>>>>>>>>>>>>>> related details can be found. All allocated memory tiers will be listed
>>>>>>>>>>>>>>>> there as /sys/devices/virtual/memory_tiering/memory_tierN/
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> The nodes which are part of a specific memory tier can be listed via
>>>>>>>>>>>>>>>> /sys/devices/virtual/memory_tiering/memory_tierN/nodes
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> I think "memory_tier" is a better subsystem/bus name than
>>>>>>>>>>>>>>> memory_tiering.  Because we have a set of memory_tierN devices inside.
>>>>>>>>>>>>>>> "memory_tier" sounds more natural.  I know this is subjective, just my
>>>>>>>>>>>>>>> preference.
>>>>>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> I missed replying to this earlier. I will keep memory_tiering as subsystem name in v4
>>>>>>>>>>> because we would want it to a susbsystem where all memory tiering related details can be found
>>>>>>>>>>> including memory type in the future. This is as per discussion
>>>>>>>>>>>
>>>>>>>>>>> https://lore.kernel.org/linux-mm/CAAPL-u9TKbHGztAF=r-io3gkX7gorUunS2UfstudCWuihrA=0g@mail.gmail.com
>>>>>>>>>>
>>>>>>>>>> I don't think that it's a good idea to mix 2 types of devices in one
>>>>>>>>>> subsystem (bus).  If my understanding were correct, that breaks the
>>>>>>>>>> driver core convention.
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> All these are virtual devices .I am not sure i follow what you mean by 2 types of devices.
>>>>>>>>> memory_tiering is a subsystem that represents all the details w.r.t memory tiering. It shows
>>>>>>>>> details of memory tiers and can possibly contain details of different memory types .
>>>>>>>>
>>>>>>>> IMHO, memory_tier and memory_type are 2 kind of devices.  They have
>>>>>>>> almost totally different attributes (sysfs file).  So, we should create
>>>>>>>> 2 buses for them.  Each has its own attribute group.  "virtual" itself
>>>>>>>> isn't a subsystem.
>>>>>>>
>>>>>>> Considering both the details are related to memory tiering, wouldn't it be much simpler we consolidate
>>>>>>> them within the same subdirectory? I am still not clear why you are suggesting they need to be in different
>>>>>>> sysfs hierarchy.  It doesn't break any driver core convention as you mentioned earlier.
>>>>>>>
>>>>>>> /sys/devices/virtual/memory_tiering/memory_tierN
>>>>>>> /sys/devices/virtual/memory_tiering/memory_typeN
>>>>>>
>>>>>> I think we should add
>>>>>>
>>>>>>  /sys/devices/virtual/memory_tier/memory_tierN
>>>>>>  /sys/devices/virtual/memory_type/memory_typeN
>>>>>>
>>>>>
>>>>> I am trying to find if there is a technical reason to do the same?
>>>>>
>>>>>> I don't think this is complex.  Devices of same bus/subsystem should
>>>>>> have mostly same attributes.  This is my understanding of driver core
>>>>>> convention.
>>>>>>
>>>>>
>>>>> I was not looking at this from code complexity point. Instead of having multiple directories
>>>>> with details w.r.t memory tiering, I was looking at consolidating the details
>>>>> within the directory /sys/devices/virtual/memory_tiering. (similar to all virtual devices
>>>>> are consolidated within /sys/devics/virtual/).
>>>>>
>>>>> -aneesh
>>>>
>>>> Here is an example of /sys/bus/nd/devices (I know it is not under
>>>> /sys/devices/virtual, but it can still serve as a reference):
>>>>
>>>> ls -1 /sys/bus/nd/devices
>>>>
>>>> namespace2.0
>>>> namespace3.0
>>>> ndbus0
>>>> nmem0
>>>> nmem1
>>>> region0
>>>> region1
>>>> region2
>>>> region3
>>>>
>>>> So I think it is not unreasonable if we want to group memory tiering
>>>> related interfaces within a single top directory.
>>>
>>> Thanks for pointing this out.  My original understanding of driver core
>>> isn't correct.
>>>
>>> But I still think it's better to separate instead of mixing memory_tier
>>> and memory_type.  Per my understanding, memory_type shows information
>>> (abstract distance, latency, bandwidth, etc.) of memory types (and
>>> nodes), it can be useful even without memory tiers.  That is, memory
>>> types describes the physical characteristics, while memory tier reflects
>>> the policy.
>>>
>>
>> The latency and bandwidth details are already exposed via 
>>
>> 	/sys/devices/system/node/nodeY/access0/initiators/
>>
>> Documentation/admin-guide/mm/numaperf.rst
>>
>> That is the interface that libraries like libmemkind will look at for finding
>> details w.r.t latency/bandwidth
> 
> Yes.  Only with that, it's still inconvenient to find out which nodes
> belong to same memory type (has same performance, same topology, managed
> by same driver, etc).  So memory types can still provide useful
> information even without memory tiering.
> 

I am not sure i quiet follow what to conclude from your reply. I used the subsystem name
"memory_tiering" so that all memory tiering related information can be consolidated there.
I guess you agreed to the above part that we can consolidated things like that. 


We might end up adding memory_type there if we allow changing "abstract distance" of a
memory type from userspace later. Otherwise, I don't see a reason for memory type to be
exposed. But then we don't have to decide on this now. 


-aneesh

