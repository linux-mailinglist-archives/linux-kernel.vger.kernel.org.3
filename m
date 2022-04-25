Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A966750E38F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 16:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242561AbiDYOsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 10:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235491AbiDYOs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 10:48:29 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C86F24F1B
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 07:45:25 -0700 (PDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23PEOZs6003291;
        Mon, 25 Apr 2022 14:45:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=6RZB3SkZ8ke/vLyXgfSZPU0lBqdMbSp7Hx+Db351wmw=;
 b=HlMgRmypBleW/pM+kmD+YoKk7+l7SVTSBnIiyV837xy7fxJ4SOW3/YYmXsZ+axZ0kTvo
 bQpNwu+LuYi91fqaUewd/LQTw6/BolblMcZfs2vmY5GnScvjv2YoTylWJrhquXQM8L7n
 DLroSePqN9zupBclxvFKxFaYX1og8yLRkkCbNv0A4Ys4mw6NoLrBOxiZzvvY7KHEqX/a
 3CYHbvvQBrrMwmfVzcWuKY1bQ1+EyKR8wJN8yS5Fz1bdK1sDlRyu0uuAOnO6uayY+oHX
 JmWpsDVzK/DqnmHD2eeGx8mdEoxWJ22JCfjAcO9KQQI2zZc0TPKfrydpNAn3C9vryL2W Mw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3fnwcr8h1a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Apr 2022 14:45:08 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 23PEPPVG005629;
        Mon, 25 Apr 2022 14:45:07 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3fnwcr8h0h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Apr 2022 14:45:07 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23PEceTk030721;
        Mon, 25 Apr 2022 14:45:05 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 3fm938tja7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Apr 2022 14:45:05 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23PEj3DN32178640
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Apr 2022 14:45:03 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5BCE6AE053;
        Mon, 25 Apr 2022 14:45:03 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 47648AE045;
        Mon, 25 Apr 2022 14:45:00 +0000 (GMT)
Received: from [9.43.106.14] (unknown [9.43.106.14])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 25 Apr 2022 14:45:00 +0000 (GMT)
Message-ID: <8a8d14ca-0976-41cc-02cb-dd1680fa37ef@linux.ibm.com>
Date:   Mon, 25 Apr 2022 20:14:58 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v3 0/7] mm: demotion: Introduce new node state
 N_DEMOTION_TARGETS
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>
Cc:     "ying.huang@intel.com" <ying.huang@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        baolin.wang@linux.alibaba.com, dave.hansen@linux.intel.com,
        shy828301@gmail.com, weixugc@google.com, gthelen@google.com,
        dan.j.williams@intel.com
References: <20220422195516.10769-1-jvgediya@linux.ibm.com>
 <4b986b46afb2fe888c127d8758221d0f0d3ec55f.camel@intel.com>
 <YmaC2jw6WaQ4X+8W@li-6e1fa1cc-351b-11b2-a85c-b897023bb5f3.ibm.com>
 <20220425145735.000007ca@Huawei.com>
From:   Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
In-Reply-To: <20220425145735.000007ca@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 5qGB7tJTjro-EnV4AaDGZBI9VtizgOMk
X-Proofpoint-GUID: K2g8UW15wnnpCWUT6v5itZ7i61JugLhs
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-25_08,2022-04-25_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 spamscore=0 suspectscore=0 malwarescore=0 impostorscore=0
 adultscore=0 clxscore=1011 phishscore=0 lowpriorityscore=0 mlxscore=0
 mlxlogscore=703 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204250063
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/25/22 7:27 PM, Jonathan Cameron wrote:
> On Mon, 25 Apr 2022 16:45:38 +0530
> Jagdish Gediya <jvgediya@linux.ibm.com> wrote:
> 
>> On Sun, Apr 24, 2022 at 11:19:53AM +0800, ying.huang@intel.com wrote:
>>> On Sat, 2022-04-23 at 01:25 +0530, Jagdish Gediya wrote:
>>>> Some systems(e.g. PowerVM) can have both DRAM(fast memory) only
>>>> NUMA node which are N_MEMORY and slow memory(persistent memory)
>>>> only NUMA node which are also N_MEMORY. As the current demotion
>>>> target finding algorithm works based on N_MEMORY and best distance,
>>>> it will choose DRAM only NUMA node as demotion target instead of
>>>> persistent memory node on such systems. If DRAM only NUMA node is
>>>> filled with demoted pages then at some point new allocations can
>>>> start falling to persistent memory, so basically cold pages are in
>>>> fast memor (due to demotion) and new pages are in slow memory, this
>>>> is why persistent memory nodes should be utilized for demotion and
>>>> dram node should be avoided for demotion so that they can be used
>>>> for new allocations.
>>>>
>>>> Current implementation can work fine on the system where the memory
>>>> only numa nodes are possible only for persistent/slow memory but it
>>>> is not suitable for the like of systems mentioned above.
>>>
>>> Can you share the NUMA topology information of your machine?  And the
>>> demotion order before and after your change?
>>>
>>> Whether it's good to use the PMEM nodes as the demotion targets of the
>>> DRAM-only node too?
>>
>> $ numactl -H
>> available: 2 nodes (0-1)
>> node 0 cpus: 0 1 2 3 4 5 6 7
>> node 0 size: 14272 MB
>> node 0 free: 13392 MB
>> node 1 cpus:
>> node 1 size: 2028 MB
>> node 1 free: 1971 MB
>> node distances:
>> node   0   1
>>    0:  10  40
>>    1:  40  10
>>
>> 1) without N_DEMOTION_TARGETS patch series, 1 is demotion target
>>     for 0 even when 1 is DRAM node and there is no demotion targets for 1.
> 
> I'm not convinced the distinction between DRAM and persistent memory is
> valid. There will definitely be systems with a large pool
> of remote DRAM (and potentially no NV memory) where the right choice
> is to demote to that DRAM pool.
> 
> Basing the decision on whether the memory is from kmem or
> normal DRAM doesn't provide sufficient information to make the decision.
> 

Hence the suggestion for the ability to override this from userspace. 
Now, for example, we could build a system with memory from the remote 
machine (memory inception in case of power which will mostly be plugged 
in as regular hotpluggable memory ) and a slow CXL memory or OpenCAPI 
memory.

In the former case, we won't consider that for demotion with this series 
because that is not instantiated via dax kmem. So yes definitely we 
would need the ability to override this from userspace so that we could 
put these remote memory NUMA nodes as demotion targets if we want.

>>
>> $ cat /sys/bus/nd/devices/dax0.0/target_node
>> 2
>> $
>> # cd /sys/bus/dax/drivers/
>> :/sys/bus/dax/drivers# ls
>> device_dax  kmem
>> :/sys/bus/dax/drivers# cd device_dax/
>> :/sys/bus/dax/drivers/device_dax# echo dax0.0 > unbind
>> :/sys/bus/dax/drivers/device_dax# echo dax0.0 >  ../kmem/new_id
>> :/sys/bus/dax/drivers/device_dax# numactl -H
>> available: 3 nodes (0-2)
>> node 0 cpus: 0 1 2 3 4 5 6 7
>> node 0 size: 14272 MB
>> node 0 free: 13380 MB
>> node 1 cpus:
>> node 1 size: 2028 MB
>> node 1 free: 1961 MB
>> node 2 cpus:
>> node 2 size: 0 MB
>> node 2 free: 0 MB
>> node distances:
>> node   0   1   2
>>    0:  10  40  80
>>    1:  40  10  80
>>    2:  80  80  10
>>
>> 2) Once this new node brought online,  without N_DEMOTION_TARGETS
>> patch series, 1 is demotion target for 0 and 2 is demotion target
>> for 1.
>>
>> With this patch series applied,
>> 1) No demotion target for either 0 or 1 before dax device is online
> 
> I'd argue that is wrong.  At this state you have a tiered memory system
> be it one with just DRAM.  Using it as such is correct behavior that
> we should not be preventing.  Sure some usecases wouldn't want that
> arrangement but some do want it.
> 
> For your case we could add a heuristic along the lines of the demotion
> target should be at least as big as the starting point but that would
> be a bit hacky.
> 

Hence the proposal to do a per node demotion target override with the 
semantics that i explained here


https://lore.kernel.org/linux-mm/8735i1zurt.fsf@linux.ibm.com/

Let me know if that interface would be good to handle all the possible 
demotion target configs we would want to have.

-aneesh
