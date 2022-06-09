Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C197544185
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 04:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236955AbiFICd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 22:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbiFICd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 22:33:56 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F9A23D1DD
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 19:33:55 -0700 (PDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2591Up3S013937;
        Thu, 9 Jun 2022 02:33:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=IUfYex3BH5dlnbkn9HKpr53TSZGDJ7nzyCAYMjc/dug=;
 b=dcEBHfwXqjArYiRgMauWXnUmQaQUDZcVfFUimHUI06X0uD/WXHlYAYzPMVU/aS50FdJl
 ljpKOnt/1Gkzyv3nBkef5GdYLhLW1F7EelaFM9+H7qNkPUHqCYJ/ffb0nZMw3RFY9R29
 9uWaRSLghgUK4IFMM+yU0tfBLzUot8nxUgnlvniWW5dRMM5zhukxla8a5aYbfnEtuKrK
 tg7rJ2sJzmD3pSSTPEHz/t6SkIdN2nCS5Xp5udgX2ehdX/cK3WXz4k6hwnTZk2udf5s+
 6BkVTvaGVmw7V4cC9OdzCaxbCmBUjmT15h4fURc4kMBLeceu4/kr1vZXxm6i5bSKG3zk Jw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gk73yrymn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Jun 2022 02:33:37 +0000
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2592QcAu028456;
        Thu, 9 Jun 2022 02:33:37 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gk73yryku-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Jun 2022 02:33:37 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2592Lfmn005950;
        Thu, 9 Jun 2022 02:33:34 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma05fra.de.ibm.com with ESMTP id 3gfy18vxym-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Jun 2022 02:33:34 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2592XWbQ22282582
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 9 Jun 2022 02:33:32 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EF8F0AE051;
        Thu,  9 Jun 2022 02:33:31 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 602D8AE04D;
        Thu,  9 Jun 2022 02:33:27 +0000 (GMT)
Received: from [9.43.85.47] (unknown [9.43.85.47])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  9 Jun 2022 02:33:27 +0000 (GMT)
Message-ID: <02ee2c97-3bca-8eb6-97d8-1f8743619453@linux.ibm.com>
Date:   Thu, 9 Jun 2022 08:03:26 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v5 1/9] mm/demotion: Add support for explicit memory tiers
Content-Language: en-US
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        Wei Xu <weixugc@google.com>, Huang Ying <ying.huang@intel.com>,
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
 <20220603134237.131362-2-aneesh.kumar@linux.ibm.com>
 <YqCuE87gCcrnAiXG@cmpxchg.org> <YqDGYjgjcS5OoS3P@cmpxchg.org>
 <a4af7598-7bd3-0e70-a434-b1237ca403d6@linux.ibm.com>
 <YqDncfLeEeBaosrY@cmpxchg.org>
From:   Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
In-Reply-To: <YqDncfLeEeBaosrY@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wEAzTjhUU1kYNhwRNFZgwKfHS9tZQMLT
X-Proofpoint-GUID: 6fR29GcG1LZ8hz6lGmBK46moE_6slpF8
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-08_05,2022-06-07_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 suspectscore=0 impostorscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206090006
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/22 11:46 PM, Johannes Weiner wrote:
> On Wed, Jun 08, 2022 at 09:43:52PM +0530, Aneesh Kumar K V wrote:
>> On 6/8/22 9:25 PM, Johannes Weiner wrote:
>>> Hello,
>>>
>>> On Wed, Jun 08, 2022 at 10:11:31AM -0400, Johannes Weiner wrote:
>>>> On Fri, Jun 03, 2022 at 07:12:29PM +0530, Aneesh Kumar K.V wrote:
>>>>> @@ -0,0 +1,20 @@
>>>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>>>> +#ifndef _LINUX_MEMORY_TIERS_H
>>>>> +#define _LINUX_MEMORY_TIERS_H
>>>>> +
>>>>> +#ifdef CONFIG_TIERED_MEMORY
>>>>> +
>>>>> +#define MEMORY_TIER_HBM_GPU	0
>>>>> +#define MEMORY_TIER_DRAM	1
>>>>> +#define MEMORY_TIER_PMEM	2
>>>>> +
>>>>> +#define MEMORY_RANK_HBM_GPU	300
>>>>> +#define MEMORY_RANK_DRAM	200
>>>>> +#define MEMORY_RANK_PMEM	100
>>>>> +
>>>>> +#define DEFAULT_MEMORY_TIER	MEMORY_TIER_DRAM
>>>>> +#define MAX_MEMORY_TIERS  3
>>>>
>>>> I understand the names are somewhat arbitrary, and the tier ID space
>>>> can be expanded down the line by bumping MAX_MEMORY_TIERS.
>>>>
>>>> But starting out with a packed ID space can get quite awkward for
>>>> users when new tiers - especially intermediate tiers - show up in
>>>> existing configurations. I mentioned in the other email that DRAM !=
>>>> DRAM, so new tiers seem inevitable already.
>>>>
>>>> It could make sense to start with a bigger address space and spread
>>>> out the list of kernel default tiers a bit within it:
>>>>
>>>> MEMORY_TIER_GPU		0
>>>> MEMORY_TIER_DRAM	10
>>>> MEMORY_TIER_PMEM	20
>>>
>>> Forgive me if I'm asking a question that has been answered. I went
>>> back to earlier threads and couldn't work it out - maybe there were
>>> some off-list discussions? Anyway...
>>>
>>> Why is there a distinction between tier ID and rank? I undestand that
>>> rank was added because tier IDs were too few. But if rank determines
>>> ordering, what is the use of a separate tier ID? IOW, why not make the
>>> tier ID space wider and have the kernel pick a few spread out defaults
>>> based on known hardware, with plenty of headroom to be future proof.
>>>
>>>     $ ls tiers
>>>     100				# DEFAULT_TIER
>>>     $ cat tiers/100/nodelist
>>>     0-1				# conventional numa nodes
>>>
>>>     <pmem is onlined>
>>>
>>>     $ grep . tiers/*/nodelist
>>>     tiers/100/nodelist:0-1	# conventional numa
>>>     tiers/200/nodelist:2		# pmem
>>>
>>>     $ grep . nodes/*/tier
>>>     nodes/0/tier:100
>>>     nodes/1/tier:100
>>>     nodes/2/tier:200
>>>
>>>     <unknown device is online as node 3, defaults to 100>
>>>
>>>     $ grep . tiers/*/nodelist
>>>     tiers/100/nodelist:0-1,3
>>>     tiers/200/nodelist:2
>>>
>>>     $ echo 300 >nodes/3/tier
>>>     $ grep . tiers/*/nodelist
>>>     tiers/100/nodelist:0-1
>>>     tiers/200/nodelist:2
>>>     tiers/300/nodelist:3
>>>
>>>     $ echo 200 >nodes/3/tier
>>>     $ grep . tiers/*/nodelist
>>>     tiers/100/nodelist:0-1	
>>>     tiers/200/nodelist:2-3
>>>
>>> etc.
>>
>> tier ID is also used as device id memtier.dev.id. It was discussed that we
>> would need the ability to change the rank value of a memory tier. If we make
>> rank value same as tier ID or tier device id, we will not be able to support
>> that.
> 
> Is the idea that you could change the rank of a collection of nodes in
> one go? Rather than moving the nodes one by one into a new tier?
> 
> [ Sorry, I wasn't able to find this discussion. AFAICS the first
>    patches in RFC4 already had the struct device { .id = tier }
>    logic. Could you point me to it? In general it would be really
>    helpful to maintain summarized rationales for such decisions in the
>    coverletter to make sure things don't get lost over many, many
>    threads, conferences, and video calls. ]

Most of the discussion happened not int he patch review email threads.

RFC: Memory Tiering Kernel Interfaces (v2)
https://lore.kernel.org/linux-mm/CAAPL-u_diGYEb7+WsgqNBLRix-nRCk2SsDj6p9r8j5JZwOABZQ@mail.gmail.com

RFC: Memory Tiering Kernel Interfaces (v4)
https://lore.kernel.org/linux-mm/CAAPL-u9Wv+nH1VOZTj=9p9S70Y3Qz3+63EkqncRDdHfubsrjfw@mail.gmail.com

-aneesh
