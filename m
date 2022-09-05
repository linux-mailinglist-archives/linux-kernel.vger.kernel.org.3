Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 527B05ACA66
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 08:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236281AbiIEGPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 02:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbiIEGPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 02:15:21 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F7B13F49
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 23:15:19 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28562ioW012491;
        Mon, 5 Sep 2022 06:15:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=5U+jzJGAMY1npBZ3XGTldQ9MM14INcWILjRHop11LIM=;
 b=E0fkDEPo24X0NlCXKott5O7n3V3OX9kpmehD3KIBIm8Y6/plE0z6PDpxptG+5A3fE1IJ
 0agdASeq4lUodK3tWkLEk+1i346SGEBuovAmtcKG4k/+Gw4bhEHXOZXHnQIilQ74CaLU
 BfgXZeDS8P/TNBFYY8n0wdKQ86LAwoACeLGxi27JSvSfBJVRAPjOzuqvM7WezsXZAhW6
 o2l24c3gjAPtxs/CWgOkZDHm1ivTV1EHFRCENtd3hE5iBkiSlmywWoBsT6szjGQZknc8
 Eypu5lkYhB7L4PJTSipXXIBl2nVA2Z9B5Fhq8xtoBeQAed6OylwwfYo2EUCwaGT/LuD5 Tg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jdarn99ss-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Sep 2022 06:15:02 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2855ZgDg035066;
        Mon, 5 Sep 2022 06:15:01 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jdarn99rs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Sep 2022 06:15:01 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28566Awh011781;
        Mon, 5 Sep 2022 06:14:58 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3jbx6hj0mk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Sep 2022 06:14:58 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2856EumT32440664
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 5 Sep 2022 06:14:56 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 74DE54203F;
        Mon,  5 Sep 2022 06:14:56 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5091942041;
        Mon,  5 Sep 2022 06:14:50 +0000 (GMT)
Received: from [9.43.107.234] (unknown [9.43.107.234])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  5 Sep 2022 06:14:50 +0000 (GMT)
Message-ID: <22881fee-43d9-78ee-671f-b667b2198c90@linux.ibm.com>
Date:   Mon, 5 Sep 2022 11:44:49 +0530
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
 <5aaf395d-514a-2717-58c6-3845b97692bd@linux.ibm.com>
 <87sfl6y4d0.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <dbd5b8e4-2b74-97cd-f05c-1b57a2df5c0c@linux.ibm.com>
 <87ilm2xv26.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <8589e329-d06d-3be2-55f8-76d4539ea80f@linux.ibm.com>
 <87a67ext72.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
In-Reply-To: <87a67ext72.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: f1lpklguSIN6snAvIQZ7Pps9TS13yDGV
X-Proofpoint-ORIG-GUID: HNG6ZxmzKd0K6t1wILm2kPE4oF77FC_6
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-05_04,2022-09-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 impostorscore=0 clxscore=1015 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209050029
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/5/22 11:23 AM, Huang, Ying wrote:
> Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> writes:
> 
>> On 9/5/22 10:43 AM, Huang, Ying wrote:
>>> Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> writes:
>>>
>>>> On 9/5/22 7:22 AM, Huang, Ying wrote:
>>>>> Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> writes:
>>>>>
>>>>>> On 9/2/22 2:34 PM, Huang, Ying wrote:
>>>>>>> Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> writes:
>>>>>>>
>>>>>>>> On 9/2/22 1:27 PM, Huang, Ying wrote:
>>>>>>>>> Wei Xu <weixugc@google.com> writes:
>>>>>>>>>
>>>>>>>>>> On Thu, Sep 1, 2022 at 11:44 PM Aneesh Kumar K V
>>>>>>>>>> <aneesh.kumar@linux.ibm.com> wrote:
>>>>>>>>>>>
>>>>>>>>>>> On 9/2/22 12:10 PM, Huang, Ying wrote:
>>>>>>>>>>>> Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> writes:
>>>>>>>>>>>>
>>>>>>>>>>>>> On 9/2/22 11:42 AM, Huang, Ying wrote:
>>>>>>>>>>>>>> Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> writes:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> On 9/2/22 11:10 AM, Huang, Ying wrote:
>>>>>>>>>>>>>>>> Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> writes:
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> On 9/2/22 10:39 AM, Wei Xu wrote:
>>>>>>>>>>>>>>>>>> On Thu, Sep 1, 2022 at 5:33 PM Huang, Ying <ying.huang@intel.com> wrote:
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> writes:
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> On 9/1/22 12:31 PM, Huang, Ying wrote:
>>>>>>>>>>>>>>>>>>>>> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>> This patch adds /sys/devices/virtual/memory_tiering/ where all memory tier
>>>>>>>>>>>>>>>>>>>>>> related details can be found. All allocated memory tiers will be listed
>>>>>>>>>>>>>>>>>>>>>> there as /sys/devices/virtual/memory_tiering/memory_tierN/
>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>> The nodes which are part of a specific memory tier can be listed via
>>>>>>>>>>>>>>>>>>>>>> /sys/devices/virtual/memory_tiering/memory_tierN/nodes
>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>> I think "memory_tier" is a better subsystem/bus name than
>>>>>>>>>>>>>>>>>>>>> memory_tiering.  Because we have a set of memory_tierN devices inside.
>>>>>>>>>>>>>>>>>>>>> "memory_tier" sounds more natural.  I know this is subjective, just my
>>>>>>>>>>>>>>>>>>>>> preference.
>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> I missed replying to this earlier. I will keep memory_tiering as subsystem name in v4
>>>>>>>>>>>>>>>>> because we would want it to a susbsystem where all memory tiering related details can be found
>>>>>>>>>>>>>>>>> including memory type in the future. This is as per discussion
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> https://lore.kernel.org/linux-mm/CAAPL-u9TKbHGztAF=r-io3gkX7gorUunS2UfstudCWuihrA=0g@mail.gmail.com
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> I don't think that it's a good idea to mix 2 types of devices in one
>>>>>>>>>>>>>>>> subsystem (bus).  If my understanding were correct, that breaks the
>>>>>>>>>>>>>>>> driver core convention.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> All these are virtual devices .I am not sure i follow what you mean by 2 types of devices.
>>>>>>>>>>>>>>> memory_tiering is a subsystem that represents all the details w.r.t memory tiering. It shows
>>>>>>>>>>>>>>> details of memory tiers and can possibly contain details of different memory types .
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> IMHO, memory_tier and memory_type are 2 kind of devices.  They have
>>>>>>>>>>>>>> almost totally different attributes (sysfs file).  So, we should create
>>>>>>>>>>>>>> 2 buses for them.  Each has its own attribute group.  "virtual" itself
>>>>>>>>>>>>>> isn't a subsystem.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Considering both the details are related to memory tiering, wouldn't it be much simpler we consolidate
>>>>>>>>>>>>> them within the same subdirectory? I am still not clear why you are suggesting they need to be in different
>>>>>>>>>>>>> sysfs hierarchy.  It doesn't break any driver core convention as you mentioned earlier.
>>>>>>>>>>>>>
>>>>>>>>>>>>> /sys/devices/virtual/memory_tiering/memory_tierN
>>>>>>>>>>>>> /sys/devices/virtual/memory_tiering/memory_typeN
>>>>>>>>>>>>
>>>>>>>>>>>> I think we should add
>>>>>>>>>>>>
>>>>>>>>>>>>  /sys/devices/virtual/memory_tier/memory_tierN
>>>>>>>>>>>>  /sys/devices/virtual/memory_type/memory_typeN
>>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> I am trying to find if there is a technical reason to do the same?
>>>>>>>>>>>
>>>>>>>>>>>> I don't think this is complex.  Devices of same bus/subsystem should
>>>>>>>>>>>> have mostly same attributes.  This is my understanding of driver core
>>>>>>>>>>>> convention.
>>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> I was not looking at this from code complexity point. Instead of having multiple directories
>>>>>>>>>>> with details w.r.t memory tiering, I was looking at consolidating the details
>>>>>>>>>>> within the directory /sys/devices/virtual/memory_tiering. (similar to all virtual devices
>>>>>>>>>>> are consolidated within /sys/devics/virtual/).
>>>>>>>>>>>
>>>>>>>>>>> -aneesh
>>>>>>>>>>
>>>>>>>>>> Here is an example of /sys/bus/nd/devices (I know it is not under
>>>>>>>>>> /sys/devices/virtual, but it can still serve as a reference):
>>>>>>>>>>
>>>>>>>>>> ls -1 /sys/bus/nd/devices
>>>>>>>>>>
>>>>>>>>>> namespace2.0
>>>>>>>>>> namespace3.0
>>>>>>>>>> ndbus0
>>>>>>>>>> nmem0
>>>>>>>>>> nmem1
>>>>>>>>>> region0
>>>>>>>>>> region1
>>>>>>>>>> region2
>>>>>>>>>> region3
>>>>>>>>>>
>>>>>>>>>> So I think it is not unreasonable if we want to group memory tiering
>>>>>>>>>> related interfaces within a single top directory.
>>>>>>>>>
>>>>>>>>> Thanks for pointing this out.  My original understanding of driver core
>>>>>>>>> isn't correct.
>>>>>>>>>
>>>>>>>>> But I still think it's better to separate instead of mixing memory_tier
>>>>>>>>> and memory_type.  Per my understanding, memory_type shows information
>>>>>>>>> (abstract distance, latency, bandwidth, etc.) of memory types (and
>>>>>>>>> nodes), it can be useful even without memory tiers.  That is, memory
>>>>>>>>> types describes the physical characteristics, while memory tier reflects
>>>>>>>>> the policy.
>>>>>>>>>
>>>>>>>>
>>>>>>>> The latency and bandwidth details are already exposed via 
>>>>>>>>
>>>>>>>> 	/sys/devices/system/node/nodeY/access0/initiators/
>>>>>>>>
>>>>>>>> Documentation/admin-guide/mm/numaperf.rst
>>>>>>>>
>>>>>>>> That is the interface that libraries like libmemkind will look at for finding
>>>>>>>> details w.r.t latency/bandwidth
>>>>>>>
>>>>>>> Yes.  Only with that, it's still inconvenient to find out which nodes
>>>>>>> belong to same memory type (has same performance, same topology, managed
>>>>>>> by same driver, etc).  So memory types can still provide useful
>>>>>>> information even without memory tiering.
>>>>>>>
>>>>>>
>>>>>> I am not sure i quiet follow what to conclude from your reply. I used the subsystem name
>>>>>> "memory_tiering" so that all memory tiering related information can be consolidated there.
>>>>>> I guess you agreed to the above part that we can consolidated things like that. 
>>>>>
>>>>> I just prefer to separate memory_tier and memory_type sysfs directories
>>>>> personally.  Because memory_type describes the physical memory types and
>>>>> performance, while memory_tier is more about the policy to group
>>>>> memory_types.
>>>>>
>>>> IMHO we can decide on that based on why we end up adding memory_type details to sysfs. If that
>>>> is only for memory tier modification from userspace we can look at adding that in the memory tiering
>>>> sysfs hierarchy. 
>>>>
>>>> Also since we have precedence of consolidating things within a sysfs hierarchy as explained in previous emails,
>>>> I think we should keep "memory_tiering" as sysfs subsystem name? I hope we can get an agreement on that
>>>> for now?
>>>
>>> I prefer to separate memory_tier and memory_type, so the subsystem name
>>> should be "memory_tier".  You prefer to consolidate memory_tier and
>>> memory_type, so the subsystem name should be "memory_tiering".
>>>
>>> The main reason behind my idea is that memory_type isn't tied with
>>> memory tiering directly.  It describes some hardware property.  Even if
>>> we don't use memory tiering, we can still use that to classify the
>>> memory devices in the system.
>>>
>>> Why do you want to consolidate them?  To reduce one directory from
>>> sysfs?
>>>
>>
>> So that it is much intuitive for user to got to memory_tiering sysfs hierarchy
>> to change the memory tier levels. As I mentioned earlier the reason for consolidating things
>> is to accommodate the possibility of supporting changing abstract distance of a memory type
>> so that we can change the memory tier assignment of that specific
>> memory type.
> 
> If we put memory_tier and memory_type into 2 directories, it will be
> much harder to change the abstract distance of a memory_type?
> 

I did explain I believe it is more intuitive to manage memory tier levels within
memory tiering sysfs hierarchy. You seems to be ignoring my explanation in these emails. 


>> I don't see any other reason we would want to expose memory type to
>> userspace as of now.
> 
> Just like we expose the device tree to the user space via sysfs.  Memory
> types are used to describe some hardware property directly.  Users need
> these hardware information to manage their system.
> 

Again explained in earlier emails already, I don't see a reason to duplicate
attribute already present in /sys/devices/system/node/nodeY/access0/initiators/.
Only reason we might end up adding memory type to sysfs is to manage memory tier levels.
Hence the suggestion to consolidate things memory tiering directory.

-aneesh
