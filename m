Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C06F252446A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 06:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347683AbiELElD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 00:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347736AbiELEkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 00:40:55 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED5055B2
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 21:40:45 -0700 (PDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24C0CMoj018599;
        Thu, 12 May 2022 04:40:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=FfGQH6EnuDT0qje5WQHmAuHuuKmfBW3cozUw0FnkIKY=;
 b=GIU3MdfxqNtxnlI8KwRx2/M3bxzzW5rhuuFkRRaSESzy08YCuUaupmf26SFQcRmnnCzy
 IVX/i2N7KPCHtMJ1fiwwU6KSoC4wIZt/q8oMuy7Ow9lQRxm4fLwg92SAwU3Hxfb3ZDtq
 YdmfVHemr6SUIMBUWDDYGJ7QXvIPyjzbvAGSSGIGnM8CIl8NJ6egNZXr7/ai3BFC4fP/
 +mqv1NUjn2DZFN9qUl+JMitwJQFU8KjROvWRClt4B9gLCJgmqxch5CP3Wxp+4sBWy88v
 xw1fkrg97tmPbbMl/kXHseCpXQbNrPI+Z+p1RdECtEJZr3AaOwa6ua9SiWr8RtSBaoF0 kg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g0qfy3fvc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 May 2022 04:40:33 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24C4Z20b009619;
        Thu, 12 May 2022 04:40:32 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g0qfy3fuu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 May 2022 04:40:32 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24C4bLTZ022487;
        Thu, 12 May 2022 04:40:30 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06fra.de.ibm.com with ESMTP id 3fwg1hvy0e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 May 2022 04:40:29 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24C4Qn8t52953344
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 May 2022 04:26:49 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6E786A405F;
        Thu, 12 May 2022 04:40:27 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8BE58A405B;
        Thu, 12 May 2022 04:40:21 +0000 (GMT)
Received: from [9.43.96.94] (unknown [9.43.96.94])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 12 May 2022 04:40:21 +0000 (GMT)
Message-ID: <c6a4db88-b27f-0539-b66d-2b67533e0c9b@linux.ibm.com>
Date:   Thu, 12 May 2022 10:10:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: RFC: Memory Tiering Kernel Interfaces
Content-Language: en-US
To:     Alistair Popple <apopple@nvidia.com>, Wei Xu <weixugc@google.com>
Cc:     Hesham Almatary <hesham.almatary@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Huang Ying <ying.huang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux MM <linux-mm@kvack.org>,
        Greg Thelen <gthelen@google.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Michal Hocko <mhocko@kernel.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Feng Tang <feng.tang@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>
References: <CAAPL-u9sVx94ACSuCVN8V0tKp+AMxiY89cro0japtyB=xNfNBw@mail.gmail.com>
 <CAHbLzkq1YXXLMiREpGnzhJjPssu4WpSsnkTmrLJ=hAEhZVUr9w@mail.gmail.com>
 <CAAPL-u-r2Pc_MaHQmKKNH_icAa_fH1COWb5qSPpr8xffREQ_cQ@mail.gmail.com>
 <CAHbLzkrit3SDQUWPQ_RtTO_xFqxoqR9LpY=72afERapUgkjxZg@mail.gmail.com>
 <1642ab64-7957-e1e6-71c5-ceab9c23bf41@huawei.com>
 <CAHbLzkqBVdaT5wwPuCXUMb8DwLEzHPaQwCKXsjsPBRTgZAAgnw@mail.gmail.com>
 <c272e43d-47c5-d7d4-cb17-95dc6f28f5cd@huawei.com>
 <e1bf6346-fd93-13ee-0b38-c1d956df0e99@linux.ibm.com>
 <CAAPL-u-Q1_19TM-J-QD9QWXGcp6A9xJS126xO54H83u+c569Tg@mail.gmail.com>
 <87o804r08w.fsf@nvdebian.thelocal>
From:   Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
In-Reply-To: <87o804r08w.fsf@nvdebian.thelocal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: anRa3kAqg9twVciGYU-IkcUEGPS1sFzi
X-Proofpoint-GUID: _S2BNRuY37_Zwjz87wfgnHRLx3gb7-FX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-11_07,2022-05-11_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 mlxscore=0 phishscore=0 adultscore=0 impostorscore=0
 malwarescore=0 priorityscore=1501 clxscore=1015 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205120022
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/11/22 12:42 PM, Alistair Popple wrote:
> 
> Wei Xu <weixugc@google.com> writes:
> 
>> On Tue, May 10, 2022 at 5:10 AM Aneesh Kumar K V
>> <aneesh.kumar@linux.ibm.com> wrote:
>>>
>>> On 5/10/22 3:29 PM, Hesham Almatary wrote:
>>>> Hello Yang,
>>>>
>>>> On 5/10/2022 4:24 AM, Yang Shi wrote:
>>>>> On Mon, May 9, 2022 at 7:32 AM Hesham Almatary
>>>>> <hesham.almatary@huawei.com> wrote:
>>>
>>>
>>> ...
>>>
>>>>>>
>>>>>> node 0 has a CPU and DDR memory in tier 0, node 1 has GPU and DDR memory
>>>>>> in tier 0,
>>>>>> node 2 has NVMM memory in tier 1, node 3 has some sort of bigger memory
>>>>>> (could be a bigger DDR or something) in tier 2. The distances are as
>>>>>> follows:
>>>>>>
>>>>>> --------------          --------------
>>>>>> |   Node 0   |          |   Node 1   |
>>>>>> |  -------   |          |  -------   |
>>>>>> | |  DDR  |  |          | |  DDR  |  |
>>>>>> |  -------   |          |  -------   |
>>>>>> |            |          |            |
>>>>>> --------------          --------------
>>>>>>           | 20               | 120    |
>>>>>>           v                  v        |
>>>>>> ----------------------------       |
>>>>>> | Node 2     PMEM          |       | 100
>>>>>> ----------------------------       |
>>>>>>           | 100                       |
>>>>>>           v                           v
>>>>>> --------------------------------------
>>>>>> | Node 3    Large mem                |
>>>>>> --------------------------------------
>>>>>>
>>>>>> node distances:
>>>>>> node   0    1    2    3
>>>>>>       0  10   20   20  120
>>>>>>       1  20   10  120  100
>>>>>>       2  20  120   10  100
>>>>>>       3  120 100  100   10
>>>>>>
>>>>>> /sys/devices/system/node/memory_tiers
>>>>>> 0-1
>>>>>> 2
>>>>>> 3
>>>>>>
>>>>>> N_TOPTIER_MEMORY: 0-1
>>>>>>
>>>>>>
>>>>>> In this case, we want to be able to "skip" the demotion path from Node 1
>>>>>> to Node 2,
>>>>>>
>>>>>> and make demotion go directely to Node 3 as it is closer, distance wise.
>>>>>> How can
>>>>>>
>>>>>> we accommodate this scenario (or at least not rule it out as future
>>>>>> work) with the
>>>>>>
>>>>>> current RFC?
>>>>> If I remember correctly NUMA distance is hardcoded in SLIT by the
>>>>> firmware, it is supposed to reflect the latency. So I suppose it is
>>>>> the firmware's responsibility to have correct information. And the RFC
>>>>> assumes higher tier memory has better performance than lower tier
>>>>> memory (latency, bandwidth, throughput, etc), so it sounds like a
>>>>> buggy firmware to have lower tier memory with shorter distance than
>>>>> higher tier memory IMHO.
>>>>
>>>> You are correct if you're assuming the topology is all hierarchically
>>>>
>>>> symmetric, but unfortuantely, in real hardware (e.g., my example above)
>>>>
>>>> it is not. The distance/latency between two nodes in the same tier
>>>>
>>>> and a third node, is different. The firmware still provides the correct
>>>>
>>>> latency, but putting a node in a tier is up to the kernel/user, and
>>>>
>>>> is relative: e.g., Node 3 could belong to tier 1 from Node 1's
>>>>
>>>> perspective, but to tier 2 from Node 0's.
>>>>
>>>>
>>>> A more detailed example (building on my previous one) is when having
>>>>
>>>> the GPU connected to a switch:
>>>>
>>>> ----------------------------
>>>> | Node 2     PMEM          |
>>>> ----------------------------
>>>>         ^
>>>>         |
>>>> --------------          --------------
>>>> |   Node 0   |          |   Node 1   |
>>>> |  -------   |          |  -------   |
>>>> | |  DDR  |  |          | |  DDR  |  |
>>>> |  -------   |          |  -------   |
>>>> |    CPU     |          |    GPU     |
>>>> --------------          --------------
>>>>          |                  |
>>>>          v                  v
>>>> ----------------------------
>>>> |         Switch           |
>>>> ----------------------------
>>>>          |
>>>>          v
>>>> --------------------------------------
>>>> | Node 3    Large mem                |
>>>> --------------------------------------
>>>>
>>>> Here, demoting from Node 1 to Node 3 directly would be faster as
>>>>
>>>> it only has to go through one hub, compared to demoting from Node 1
>>>>
>>>> to Node 2, where it goes through two hubs. I hope that example
>>>>
>>>> clarifies things a little bit.
>>>>
>>>
>>> Alistair mentioned that we want to consider GPU memory to be expensive
>>> and want to demote from GPU to regular DRAM. In that case for the above
>>> case we should end up with
>>>
>>>
>>> tier 0 - > Node3
>>> tier 1 ->  Node0, Node1
>>> tier 2 ->  Node2
> 
> I'm a little bit confused by the tiering here as I don't think it's
> quite what we want. As pointed out GPU memory is expensive and therefore
> we don't want anything demoting to it. That implies it should be in the
> top tier:
> 


I didn't look closely at the topology and assumed that Node3 is the GPU 
connected to the switch. Hence all the confusion.


> tier 0 -> Node1
> tier 1 -> Node0, Node3
> tier 2 -> Node2
> 
> Hence:
> 
> node 0: allowed=2
> node 1: allowed=0,3,2
> node 2: allowed=empty
> node 3: allowed=2

looks good to be default and simple.

> 
> Alternatively Node3 could be put in tier 2 which would prevent demotion
> to PMEM via the switch/CPU:
> 
> tier 0 -> Node1
> tier 1 -> Node0
> tier 2 -> Node2, Node3
> 
> node 0: allowed=2,3
> node 1: allowed=0,3,2
> node 2: allowed=empty
> node 3: allowed=empty
> 

and this can be configured via userspace?

> Both of these would be an improvement over the current situation
> upstream, which demotes everything to GPU memory and doesn't support
> demoting from the GPU (meaning reclaim on GPU memory pages everything to
> disk).
> 
>>>
>>> Hence
>>>
>>>    node 0: allowed=2
>>>    node 1: allowed=2
>>>    node 2: allowed = empty
>>>    node 3: allowed = 0-1 , based on fallback order 1, 0
>>
>> If we have 3 tiers as defined above, then we'd better to have:
>>
>> node 0: allowed = 2
>> node 1: allowed = 2
>> node 2: allowed = empty
>> node 3: allowed = 0-2, based on fallback order: 1,0,2
>>
>> The firmware should provide the node distance values to reflect that
>> PMEM is slowest and should have the largest distance away from node 3.
> 
> Right. In my above example firmware would have to provide reasonable
> distance values to ensure optimal fallback order.
> 
>>> -aneesh
>>>
>>>

