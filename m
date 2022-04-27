Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF6A510F10
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 04:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357330AbiD0DAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 23:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353915AbiD0DAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 23:00:51 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5489E16E6AC
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 19:57:42 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23R227gL005739;
        Wed, 27 Apr 2022 02:57:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=YOdJEHbkmZXpZt3YX1SzZyrIG2RcBbTDlw0VLZ/qrOs=;
 b=axhV2S1PAlg4ma9IMo9muO0ISi8tbUI6DJplSEewUD7ss5zrMv3MmofY7UxVbkHgWn15
 +NiQ7GWikkLLOh30cJGLtd4MdOGnxqYOoAPFQ+8PnunO65Zo8knVz4sT3mj9WnJXSLzS
 uCf4WNAMBtTsa5LaFz4Dm6b6Eb0KD4gsJZ9XLlfidJTzP5r0aHuSoHxo91ujQQxFX3zB
 EaehcPvnfEtSlgGyoMEFOPFp3btdBDu+BWuL6SNaj53IvsIJ0JUJQRGXcYQiX8lS2nUi
 oY0MtHMuP1h4yagIi3baPUU565Mzuu3kXeiiJRyXrMfqvcVqscgDU1WWtVlpKe4xZH96 fQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fprrpchg8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Apr 2022 02:57:30 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 23R2Uhp4023886;
        Wed, 27 Apr 2022 02:57:29 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fprrpchfp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Apr 2022 02:57:29 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23R2vRdL000332;
        Wed, 27 Apr 2022 02:57:27 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma02fra.de.ibm.com with ESMTP id 3fpuyg82e6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Apr 2022 02:57:26 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23R2vOGx42598662
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Apr 2022 02:57:24 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 557CFA405B;
        Wed, 27 Apr 2022 02:57:24 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9747CA4054;
        Wed, 27 Apr 2022 02:57:20 +0000 (GMT)
Received: from [9.43.50.189] (unknown [9.43.50.189])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 27 Apr 2022 02:57:20 +0000 (GMT)
Message-ID: <4a9eaf06-294c-032d-9b85-14c1d91fb732@linux.ibm.com>
Date:   Wed, 27 Apr 2022 08:27:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v3 0/7] mm: demotion: Introduce new node state
 N_DEMOTION_TARGETS
Content-Language: en-US
To:     "ying.huang@intel.com" <ying.huang@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, baolin.wang@linux.alibaba.com,
        dave.hansen@linux.intel.com, shy828301@gmail.com,
        weixugc@google.com, gthelen@google.com, dan.j.williams@intel.com
References: <20220422195516.10769-1-jvgediya@linux.ibm.com>
 <4b986b46afb2fe888c127d8758221d0f0d3ec55f.camel@intel.com>
 <YmaC2jw6WaQ4X+8W@li-6e1fa1cc-351b-11b2-a85c-b897023bb5f3.ibm.com>
 <20220425145735.000007ca@Huawei.com>
 <8a8d14ca-0976-41cc-02cb-dd1680fa37ef@linux.ibm.com>
 <0b2fd48049e8f59fb132f260df9e2a84b58e4577.camel@intel.com>
From:   Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
In-Reply-To: <0b2fd48049e8f59fb132f260df9e2a84b58e4577.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: CDPp5zFvR7mBHxwarSRRUEba97-hzXDb
X-Proofpoint-ORIG-GUID: PtsqmxcuByTZjb7-_q2-YeJHBN6LWfX3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-26_06,2022-04-26_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=725
 impostorscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 mlxscore=0 adultscore=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204270013
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/27/22 6:59 AM, ying.huang@intel.com wrote:
> On Mon, 2022-04-25 at 20:14 +0530, Aneesh Kumar K V wrote:
>> On 4/25/22 7:27 PM, Jonathan Cameron wrote:
>>> On Mon, 25 Apr 2022 16:45:38 +0530
>>> Jagdish Gediya <jvgediya@linux.ibm.com> wrote:
>>>
>>>> On Sun, Apr 24, 2022 at 11:19:53AM +0800, ying.huang@intel.com wrote:
>>>>> On Sat, 2022-04-23 at 01:25 +0530, Jagdish Gediya wrote:
>>>>>> Some systems(e.g. PowerVM) can have both DRAM(fast memory) only
>>>>>> NUMA node which are N_MEMORY and slow memory(persistent memory)
>>>>>> only NUMA node which are also N_MEMORY. As the current demotion
>>>>>> target finding algorithm works based on N_MEMORY and best distance,
>>>>>> it will choose DRAM only NUMA node as demotion target instead of
>>>>>> persistent memory node on such systems. If DRAM only NUMA node is
>>>>>> filled with demoted pages then at some point new allocations can
>>>>>> start falling to persistent memory, so basically cold pages are in
>>>>>> fast memor (due to demotion) and new pages are in slow memory, this
>>>>>> is why persistent memory nodes should be utilized for demotion and
>>>>>> dram node should be avoided for demotion so that they can be used
>>>>>> for new allocations.
>>>>>>
>>>>>> Current implementation can work fine on the system where the memory
>>>>>> only numa nodes are possible only for persistent/slow memory but it
>>>>>> is not suitable for the like of systems mentioned above.
>>>>>
>>>>> Can you share the NUMA topology information of your machine?  And the
>>>>> demotion order before and after your change?
>>>>>
>>>>> Whether it's good to use the PMEM nodes as the demotion targets of the
>>>>> DRAM-only node too?
>>>>
>>>> $ numactl -H
>>>> available: 2 nodes (0-1)
>>>> node 0 cpus: 0 1 2 3 4 5 6 7
>>>> node 0 size: 14272 MB
>>>> node 0 free: 13392 MB
>>>> node 1 cpus:
>>>> node 1 size: 2028 MB
>>>> node 1 free: 1971 MB
>>>> node distances:
>>>> node   0   1
>>>>     0:  10  40
>>>>     1:  40  10
>>>>
>>>> 1) without N_DEMOTION_TARGETS patch series, 1 is demotion target
>>>>      for 0 even when 1 is DRAM node and there is no demotion targets for 1.
>>>
>>> I'm not convinced the distinction between DRAM and persistent memory is
>>> valid. There will definitely be systems with a large pool
>>> of remote DRAM (and potentially no NV memory) where the right choice
>>> is to demote to that DRAM pool.
>>>
>>> Basing the decision on whether the memory is from kmem or
>>> normal DRAM doesn't provide sufficient information to make the decision.
>>>
>>
>> Hence the suggestion for the ability to override this from userspace.
>> Now, for example, we could build a system with memory from the remote
>> machine (memory inception in case of power which will mostly be plugged
>> in as regular hotpluggable memory ) and a slow CXL memory or OpenCAPI
>> memory.
>>
>> In the former case, we won't consider that for demotion with this series
>> because that is not instantiated via dax kmem. So yes definitely we
>> would need the ability to override this from userspace so that we could
>> put these remote memory NUMA nodes as demotion targets if we want.
>>>>
> 
> Is there a driver for the device (memory from the remote machine)?  If
> so, we can adjust demotion order for it in the driver.
> 

At this point, it is managed by hypervisor, is hotplugged into the the 
LPAR with more additional properties specified via device tree. So there 
is no inception specific device driver.

> In general, I think that we can adjust demotion order inside kernel from
> various information sources.  In addition to ACPI SLIT, we also have
> HMAT, kmem driver, other drivers, etc.
> 

Managing inception memory will any way requires a userspace component to 
track the owner machine for the remote memory. So we should be ok to 
have userspace manage demotion order.

-aneesh

