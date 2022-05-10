Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D98275214DD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 14:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241443AbiEJMOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 08:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233297AbiEJMOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 08:14:33 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07AA82992D6
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 05:10:36 -0700 (PDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24ABJkNO002974;
        Tue, 10 May 2022 12:10:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=mzNOXhcjmsKPzuKgqGfty3R6sY92hW9Rr5/I9r4b3Hs=;
 b=MiUILQ7+fJOMseVbUoKDx3af5Lij7C0/SWhIXs6K3SJmFRc6GCBcK3X/t9vQ/Pid85bv
 R3tl9brd+QwWzdINEhkzJwoRQADfM6fjEfSWjBARQE19xglZS8E4djiCV8UpGR5wtEhS
 JK2TDanT/zN69Vx6Hp6rqCAaNcrdZGiqhaH2+JsLgnimx9UQX+wDvmmm/I4i/pmYZNND
 SpVSBQlYp5Qd8F4o0LHN6ugn4T1Ey6GsEz0EFdO9wBvRMpGsUCN1jeiYmks0J8GNv9zw
 9HKF02fYnSdy5oOwL7++3n1FupGGfVGabFl5ellKB3JYiIs4zWqk28Gn8JkPDthR/enc aQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fyq338xsr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 May 2022 12:10:22 +0000
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24AC6UFO024768;
        Tue, 10 May 2022 12:10:22 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fyq338xrk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 May 2022 12:10:21 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24AC2cBn029060;
        Tue, 10 May 2022 12:10:19 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3fwgd8v1fr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 May 2022 12:10:19 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24ACAHUO50069798
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 May 2022 12:10:17 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1996B5204E;
        Tue, 10 May 2022 12:10:17 +0000 (GMT)
Received: from [9.43.24.223] (unknown [9.43.24.223])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 6512A52057;
        Tue, 10 May 2022 12:10:11 +0000 (GMT)
Message-ID: <e1bf6346-fd93-13ee-0b38-c1d956df0e99@linux.ibm.com>
Date:   Tue, 10 May 2022 17:40:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: RFC: Memory Tiering Kernel Interfaces
Content-Language: en-US
To:     Hesham Almatary <hesham.almatary@huawei.com>,
        Yang Shi <shy828301@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Huang Ying <ying.huang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux MM <linux-mm@kvack.org>,
        Greg Thelen <gthelen@google.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alistair Popple <apopple@nvidia.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Michal Hocko <mhocko@kernel.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Feng Tang <feng.tang@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Wei Xu <weixugc@google.com>
References: <CAAPL-u9sVx94ACSuCVN8V0tKp+AMxiY89cro0japtyB=xNfNBw@mail.gmail.com>
 <CAHbLzkq1YXXLMiREpGnzhJjPssu4WpSsnkTmrLJ=hAEhZVUr9w@mail.gmail.com>
 <CAAPL-u-r2Pc_MaHQmKKNH_icAa_fH1COWb5qSPpr8xffREQ_cQ@mail.gmail.com>
 <CAHbLzkrit3SDQUWPQ_RtTO_xFqxoqR9LpY=72afERapUgkjxZg@mail.gmail.com>
 <1642ab64-7957-e1e6-71c5-ceab9c23bf41@huawei.com>
 <CAHbLzkqBVdaT5wwPuCXUMb8DwLEzHPaQwCKXsjsPBRTgZAAgnw@mail.gmail.com>
 <c272e43d-47c5-d7d4-cb17-95dc6f28f5cd@huawei.com>
From:   Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
In-Reply-To: <c272e43d-47c5-d7d4-cb17-95dc6f28f5cd@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: nuEGgPOXmFpGslgUksrlba9uGF1Bklcz
X-Proofpoint-GUID: lhwH-Ctb-QymV8c4lcCWXWU3_v3NnIxI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-10_01,2022-05-10_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 clxscore=1011 suspectscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 mlxscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205100055
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/10/22 3:29 PM, Hesham Almatary wrote:
> Hello Yang,
> 
> On 5/10/2022 4:24 AM, Yang Shi wrote:
>> On Mon, May 9, 2022 at 7:32 AM Hesham Almatary
>> <hesham.almatary@huawei.com> wrote:


...

>>>
>>> node 0 has a CPU and DDR memory in tier 0, node 1 has GPU and DDR memory
>>> in tier 0,
>>> node 2 has NVMM memory in tier 1, node 3 has some sort of bigger memory
>>> (could be a bigger DDR or something) in tier 2. The distances are as
>>> follows:
>>>
>>> --------------          --------------
>>> |   Node 0   |          |   Node 1   |
>>> |  -------   |          |  -------   |
>>> | |  DDR  |  |          | |  DDR  |  |
>>> |  -------   |          |  -------   |
>>> |            |          |            |
>>> --------------          --------------
>>>          | 20               | 120    |
>>>          v                  v        |
>>> ----------------------------       |
>>> | Node 2     PMEM          |       | 100
>>> ----------------------------       |
>>>          | 100                       |
>>>          v                           v
>>> --------------------------------------
>>> | Node 3    Large mem                |
>>> --------------------------------------
>>>
>>> node distances:
>>> node   0    1    2    3
>>>      0  10   20   20  120
>>>      1  20   10  120  100
>>>      2  20  120   10  100
>>>      3  120 100  100   10
>>>
>>> /sys/devices/system/node/memory_tiers
>>> 0-1
>>> 2
>>> 3
>>>
>>> N_TOPTIER_MEMORY: 0-1
>>>
>>>
>>> In this case, we want to be able to "skip" the demotion path from Node 1
>>> to Node 2,
>>>
>>> and make demotion go directely to Node 3 as it is closer, distance wise.
>>> How can
>>>
>>> we accommodate this scenario (or at least not rule it out as future
>>> work) with the
>>>
>>> current RFC?
>> If I remember correctly NUMA distance is hardcoded in SLIT by the
>> firmware, it is supposed to reflect the latency. So I suppose it is
>> the firmware's responsibility to have correct information. And the RFC
>> assumes higher tier memory has better performance than lower tier
>> memory (latency, bandwidth, throughput, etc), so it sounds like a
>> buggy firmware to have lower tier memory with shorter distance than
>> higher tier memory IMHO.
> 
> You are correct if you're assuming the topology is all hierarchically
> 
> symmetric, but unfortuantely, in real hardware (e.g., my example above)
> 
> it is not. The distance/latency between two nodes in the same tier
> 
> and a third node, is different. The firmware still provides the correct
> 
> latency, but putting a node in a tier is up to the kernel/user, and
> 
> is relative: e.g., Node 3 could belong to tier 1 from Node 1's
> 
> perspective, but to tier 2 from Node 0's.
> 
> 
> A more detailed example (building on my previous one) is when having
> 
> the GPU connected to a switch:
> 
> ----------------------------
> | Node 2     PMEM          |
> ----------------------------
>        ^
>        |
> --------------          --------------
> |   Node 0   |          |   Node 1   |
> |  -------   |          |  -------   |
> | |  DDR  |  |          | |  DDR  |  |
> |  -------   |          |  -------   |
> |    CPU     |          |    GPU     |
> --------------          --------------
>         |                  |
>         v                  v
> ----------------------------
> |         Switch           |
> ----------------------------
>         |
>         v
> --------------------------------------
> | Node 3    Large mem                |
> --------------------------------------
> 
> Here, demoting from Node 1 to Node 3 directly would be faster as
> 
> it only has to go through one hub, compared to demoting from Node 1
> 
> to Node 2, where it goes through two hubs. I hope that example
> 
> clarifies things a little bit.
> 

Alistair mentioned that we want to consider GPU memory to be expensive 
and want to demote from GPU to regular DRAM. In that case for the above 
case we should end up with


tier 0 - > Node3
tier 1 ->  Node0, Node1
tier 2 ->  Node2

Hence

  node 0: allowed=2
  node 1: allowed=2
  node 2: allowed = empty
  node 3: allowed = 0-1 , based on fallback order 1, 0

-aneesh


