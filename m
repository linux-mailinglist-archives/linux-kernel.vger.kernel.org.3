Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9565A5CDE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 09:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbiH3H2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 03:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiH3H2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 03:28:46 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE6939F8ED
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 00:28:45 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27U7ITvb027552;
        Tue, 30 Aug 2022 07:28:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=WeNv+LY/qC4unbGWA+rZL0j3Exo6NFHf8oMxYQdckNg=;
 b=ET/DVqaaTnd0UvozYE7GjUh2qY9bj6SmU1KFIo33gHR5mn2dLMOFX3izOvInV2K1D9C/
 qdBdbITq4t9uG0LVWFx314e0vy4gwwqID7ZD/E4F4+/E/SfVVh5J4izgBaKY6gZ94ReJ
 myiW1tL2Ukddy7UMsQDEyucGKH37xrTKBqQhSFOpb/40/fUz8QIUewRdGLvd6xfBirRU
 hz4rcf7iPzK8AF0VNVt4sE1uC5oklwp4CzSoKzNLsaxJDlgAqtxNOswMkjTz3Ii0RVVV
 5REQBzq8SiHZ9JkS/Q0Z9riFk7VDDCK6oBYAW7tXC7RDxmQrqwMAeeKsRV3AmlwIq3Pj kw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j9e1pr8pr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Aug 2022 07:28:21 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27U7KPcZ000949;
        Tue, 30 Aug 2022 07:28:20 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j9e1pr8nc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Aug 2022 07:28:20 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27U7NOUt018714;
        Tue, 30 Aug 2022 07:28:17 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma02fra.de.ibm.com with ESMTP id 3j7aw8teem-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Aug 2022 07:28:17 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27U7SFFY41288028
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Aug 2022 07:28:15 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1A658A405C;
        Tue, 30 Aug 2022 07:28:15 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AAFA6A4054;
        Tue, 30 Aug 2022 07:28:10 +0000 (GMT)
Received: from [9.43.77.247] (unknown [9.43.77.247])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 30 Aug 2022 07:28:10 +0000 (GMT)
Message-ID: <40b5c045-1825-e0f3-ffe3-b90e96f940a2@linux.ibm.com>
Date:   Tue, 30 Aug 2022 12:58:09 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2] mm/demotion: Expose memory tier details via sysfs
Content-Language: en-US
To:     Wei Xu <weixugc@google.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>,
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
        Johannes Weiner <hannes@cmpxchg.org>, jvgediya.oss@gmail.com,
        Bharata B Rao <bharata@amd.com>
References: <20220829060745.287468-1-aneesh.kumar@linux.ibm.com>
 <CAAPL-u9HRHyQEw7q+bTUvYRQWwii7DWYyx3DCgmxJu+u3panbQ@mail.gmail.com>
 <22cb7a8a-84fe-04c7-41ea-50eff8184dc1@linux.ibm.com>
 <CAAPL-u-YuecdVsyr_Tdery8qqPDnzHxGaQL+CSO8x5xv8QH7kg@mail.gmail.com>
From:   Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
In-Reply-To: <CAAPL-u-YuecdVsyr_Tdery8qqPDnzHxGaQL+CSO8x5xv8QH7kg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: unvKeZ3qAjfaGW4aNQ8nEUsJN2WAJfkW
X-Proofpoint-GUID: RHtnbh4a5aKcsbmtmpxI4ejGYgtMR1ZN
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-30_02,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501
 phishscore=0 adultscore=0 impostorscore=0 spamscore=0 clxscore=1015
 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208300033
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/30/22 12:47 PM, Wei Xu wrote:
> On Mon, Aug 29, 2022 at 11:46 PM Aneesh Kumar K V
> <aneesh.kumar@linux.ibm.com> wrote:
>>
>> On 8/30/22 12:01 PM, Wei Xu wrote:
>>> On Sun, Aug 28, 2022 at 11:08 PM Aneesh Kumar K.V
>>> <aneesh.kumar@linux.ibm.com> wrote:
>>>>
>>>> This patch adds /sys/devices/virtual/memory_tiering/ where all memory tier
>>>> related details can be found. All allocated memory tiers will be listed
>>>> there as /sys/devices/virtual/memory_tiering/memory_tierN/
>>>>
>>>> The nodes which are part of a specific memory tier can be listed via
>>>> /sys/devices/virtual/memory_tiering/memory_tierN/nodes
>>>>
>>>> The abstract distance range value of a specific memory tier can be listed via
>>>> /sys/devices/virtual/memory_tiering/memory_tierN/abstract_distance
>>>>
>>>> A directory hierarchy looks like
>>>> :/sys/devices/virtual/memory_tiering$ tree memory_tier4/
>>>> memory_tier4/
>>>> ├── abstract_distance
>>>> ├── nodes
>>>> ├── subsystem -> ../../../../bus/memory_tiering
>>>> └── uevent
>>>>
>>>> All toptier nodes are listed via
>>>> /sys/devices/virtual/memory_tiering/toptier_nodes
>>>>
>>>> :/sys/devices/virtual/memory_tiering$ cat toptier_nodes
>>>> 0,2
>>>> :/sys/devices/virtual/memory_tiering$ cat memory_tier4/nodes
>>>> 0,2
>>>> :/sys/devices/virtual/memory_tiering$ cat memory_tier4/abstract_distance
>>>> 512 - 639
>>>>
>>>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>>>> ---
>>>>  .../ABI/testing/sysfs-kernel-mm-memory-tiers  |  41 +++++
>>>>  mm/memory-tiers.c                             | 155 +++++++++++++++---
>>>>  2 files changed, 174 insertions(+), 22 deletions(-)
>>>>  create mode 100644 Documentation/ABI/testing/sysfs-kernel-mm-memory-tiers
>>>>
>>>> diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-memory-tiers b/Documentation/ABI/testing/sysfs-kernel-mm-memory-tiers
>>>> new file mode 100644
>>>> index 000000000000..6955f69a4423
>>>> --- /dev/null
>>>> +++ b/Documentation/ABI/testing/sysfs-kernel-mm-memory-tiers
>>>> @@ -0,0 +1,41 @@
>>>> +What:          /sys/devices/virtual/memory_tiering/
>>>> +Date:          August 2022
>>>> +Contact:       Linux memory management mailing list <linux-mm@kvack.org>
>>>> +Description:   A collection of all the memory tiers allocated.
>>>> +
>>>> +               Individual memory tier details are contained in subdirectories
>>>> +               named by the abstract distance of the memory tier.
>>>> +
>>>> +               /sys/devices/virtual/memory_tiering/memory_tierN/
>>>> +
>>>> +
>>>> +What:          /sys/devices/virtual/memory_tiering/memory_tierN/
>>>> +               /sys/devices/virtual/memory_tiering/memory_tierN/abstract_distance
>>>> +               /sys/devices/virtual/memory_tiering/memory_tierN/nodes
>>>> +Date:          August 2022
>>>> +Contact:       Linux memory management mailing list <linux-mm@kvack.org>
>>>> +Description:   Directory with details of a specific memory tier
>>>> +
>>>> +               This is the directory containing information about a particular
>>>> +               memory tier, memtierN, where N is derived based on abstract distance.
>>>> +
>>>> +               A smaller value of N implies a higher (faster) memory tier in the
>>>> +               hierarchy.
>>>
>>> Given that abstract_distance is provided, it would be more flexible if
>>> we don't commit to the interface where N in memtierN also indicates
>>> the memory tier ordering.
>>
>>
>> IIUC this is one of the request that Johannes had ie, to be able to understand the
>> memory tier hierarchy based on memtier name.
>>
>>>> +
>>>> +               abstract_distance: The abstract distance range this specific memory
>>>> +               tier maps to.
>>>
>>> I still think the name of "abstract distance" is kind of confusing
>>> because it is not clear what is the other object that this distance
>>> value is relative to.  Do we have to expose this value at this point
>>> if N in memtierN can already indicate the memory tier ordering?
>>>
>>
>> I do agree that abstract distance is confusing. But IIUC we agreed that it is much better
>> than other names suggested and is closer to already understood "numa distance" term.
>>
>> https://lore.kernel.org/linux-mm/YuLF%2FGG8x5lQvg%2Ff@cmpxchg.org/
>>
> 
> "NUMA distance" measures the distance between two NUMA nodes.
> 
> I bring it up again because this name will become a user visible
> kernel interface, which we will need to live with for a long time.
> Even if we decide to keep the name, it would be better if we can
> define between which two (abstract) points the abstract distance
> reports.
> 
> Another option is to remove this interface for now until it becomes
> necessary to report abstract distances to userspace.
> 

Ok I will send a v3 with abstract_distance dropped.

-aneesh

