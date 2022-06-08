Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0E4A542AD8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 11:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232948AbiFHJLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 05:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234041AbiFHJJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 05:09:31 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB9AED71E
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 01:28:39 -0700 (PDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2588HD3M022307;
        Wed, 8 Jun 2022 08:28:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=2yi8GTScbM2yQ43r5cWVCSxMSVp3ZaSmcNdP7hKN6+A=;
 b=pp9ZGnKgXHZ9fbqlyFeo8cmGxbDZcEAiOvBegNCfHVS1yuLhPBcu6cyJ7B1ZIjQzIYBV
 h6LwV7rzw/JL+QdsweqX/GVZc5R1QXzWzgOI0Qn/FN9WdhjSq+eT9v2/lthSKWkS/7yn
 qPaRZS2zZjGwKVSXT6nNOs4dCHD2Tk4JLz01K8ZKK2P9MikGkDbqGjOzATDC+B50CvFU
 u3n4yz+S5jf/R7R3Yk4yyMhI9tc5tT7ZrysNFykGTwpyMj/VvOq1pbOf9hhQed684rH1
 LVINKE355Amqe3/OO3ZGQ+6oeAgYhSDkbn0ReJX3NER+LXqzl29tm+vlcsBG/HjxDM0H sA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gjnyejwqk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Jun 2022 08:28:24 +0000
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25880IrW031436;
        Wed, 8 Jun 2022 08:28:23 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gjnyejwpw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Jun 2022 08:28:23 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2588K0Wc027152;
        Wed, 8 Jun 2022 08:28:20 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 3gfxnhvwt6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Jun 2022 08:28:20 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2588SIof54919506
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Jun 2022 08:28:18 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7680F52052;
        Wed,  8 Jun 2022 08:28:18 +0000 (GMT)
Received: from [9.43.53.124] (unknown [9.43.53.124])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id EE48A5204E;
        Wed,  8 Jun 2022 08:28:11 +0000 (GMT)
Message-ID: <232817e0-24fd-e022-6c92-c260f7f01f8a@linux.ibm.com>
Date:   Wed, 8 Jun 2022 13:58:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v5 9/9] mm/demotion: Update node_is_toptier to work with
 memory tiers
Content-Language: en-US
To:     Ying Huang <ying.huang@intel.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org
Cc:     Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
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
 <20220603134237.131362-10-aneesh.kumar@linux.ibm.com>
 <6e94b7e2a6192e4cacba1db3676b5b5cf9b98eac.camel@intel.com>
 <f9a26536-05f6-5d12-5c61-cdd35ab33a40@linux.ibm.com>
 <11f94e0c50f17f4a6a2f974cb69a1ae72853e2be.camel@intel.com>
 <d2513be5-be87-2957-a0d4-1d99b9e83114@linux.ibm.com>
 <db0200f4467c072470d8ed7e272132bfeb146ac2.camel@intel.com>
From:   Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
In-Reply-To: <db0200f4467c072470d8ed7e272132bfeb146ac2.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zj3NFK7waFu_KZtx0i_0GFbHdGOcMmJh
X-Proofpoint-ORIG-GUID: 9OCi_E_0aYO-w1Pds5nraGjCXj0OyITf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-08_02,2022-06-07_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0
 clxscore=1015 malwarescore=0 adultscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206080035
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/22 12:56 PM, Ying Huang wrote:
> On Mon, 2022-06-06 at 14:03 +0530, Aneesh Kumar K V wrote:
>> On 6/6/22 12:54 PM, Ying Huang wrote:
>>> On Mon, 2022-06-06 at 09:22 +0530, Aneesh Kumar K V wrote:
>>>> On 6/6/22 8:41 AM, Ying Huang wrote:
>>>>> On Fri, 2022-06-03 at 19:12 +0530, Aneesh Kumar K.V wrote:
>>>>>> With memory tiers support we can have memory on NUMA nodes
>>>>>> in the top tier from which we want to avoid promotion tracking NUMA
>>>>>> faults. Update node_is_toptier to work with memory tiers. To
>>>>>> avoid taking locks, a nodemask is maintained for all demotion
>>>>>> targets. All NUMA nodes are by default top tier nodes and as
>>>>>> we add new lower memory tiers NUMA nodes get added to the
>>>>>> demotion targets thereby moving them out of the top tier.
>>>>>
>>>>> Check the usage of node_is_toptier(),
>>>>>
>>>>> - migrate_misplaced_page()
>>>>>      node_is_toptier() is used to check whether migration is a promotion.
>>>>> We can avoid to use it.  Just compare the rank of the nodes.
>>>>>
>>>>> - change_pte_range() and change_huge_pmd()
>>>>>      node_is_toptier() is used to avoid scanning fast memory (DRAM) pages
>>>>> for promotion.  So I think we should change the name to node_is_fast()
>>>>> as follows,
>>>>>
>>>>> static inline bool node_is_fast(int node)
>>>>> {
>>>>> 	return NODE_DATA(node)->mt_rank >= MEMORY_RANK_DRAM;
>>>>> }
>>>>>
>>>>
>>>> But that gives special meaning to MEMORY_RANK_DRAM. As detailed in other
>>>> patches, absolute value of rank doesn't carry any meaning. It is only
>>>> the relative value w.r.t other memory tiers that decide whether it is
>>>> fast or not. Agreed by default memory tiers get built with
>>>> MEMORY_RANK_DRAM. But userspace can change the rank value of 'memtier1'
>>>> Hence to determine a node is consisting of fast memory is essentially
>>>> figuring out whether node is the top most tier in memory hierarchy and
>>>> not just the memory tier rank value is >= MEMORY_RANK_DRAM?
>>>
>>> In a system with 3 tiers,
>>>
>>> HBM	0
>>> DRAM	1
>>> PMEM	2
>>>
>>> In your implementation, only HBM will be considered fast.  But what we
>>> need is to consider both HBM and DRAM fast.  Because we use NUMA
>>> balancing to promote PMEM pages to DRAM.  It's unnecessary to scan HBM
>>> and DRAM pages for that.  And there're no requirements to promote DRAM
>>> pages to HBM with NUMA balancing.
>>>
>>> I can understand that the memory tiers are more dynamic now.  For
>>> requirements of NUMA balancing, we need the lowest memory tier (rank)
>>> where there's at least one node with CPU.  The nodes in it and the
>>> higher tiers will be considered fast.
>>>
>>
>> is this good (not tested)?
>> /*
>>    * build the allowed promotion mask. Promotion is allowed
>>    * from higher memory tier to lower memory tier only if
>>    * lower memory tier doesn't include compute. We want to
>>    * skip promotion from a memory tier, if any node which is
>>    * part of that memory tier have CPUs. Once we detect such
>>    * a memory tier, we consider that tier as top tier from
>>    * which promotion is not allowed.
>>    */
>> list_for_each_entry_reverse(memtier, &memory_tiers, list) {
>> 	nodes_and(allowed, node_state[N_CPU], memtier->nodelist);
>> 	if (nodes_empty(allowed))
>> 		nodes_or(promotion_mask, promotion_mask, allowed);
>> 	else
>> 		break;
>> }
>>
>> and then
>>
>> static inline bool node_is_toptier(int node)
>> {
>>
>> 	return !node_isset(node, promotion_mask);
>> }
>>
> 
> This should work.  But it appears unnatural.  So, I don't think we
> should avoid to add more and more node masks to mitigate the design
> decision that we cannot access memory tier information directly.  All
> these becomes simple and natural, if we can access memory tier
> information directly.
> 

how do you derive whether node is toptier details if we have memtier 
details in pgdat?

-aneesh



