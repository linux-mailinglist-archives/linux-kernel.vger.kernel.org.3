Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C898853E34F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 10:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbiFFIiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 04:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232010AbiFFIhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 04:37:52 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16EE21811
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 01:37:48 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25661WvX010595;
        Mon, 6 Jun 2022 08:33:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=D6RD3ix5AkUWorpYfTPLoFeoD4U7HldNHq2KlxZp0YY=;
 b=PCgymK3S58nk1PEsSDL71lxpRs8qjmH8LcBMTSWLxLKiFlG41kjC0GNubSNweDSOu8CK
 fOFsjhT6rj40bPZvQEDeGny+Ac4k97m0SRZKKvW4IraeToECv5iH4PnBsRa70OYk4MKz
 R97LDK3NMWcwzTDw+6vQYkeyLVHDMQmRYZtKtRCQh2f8a4qO8234OmQQ7/C8BYH0qDo9
 kdBGPjym3dbqFgOUVXj19raNbwElbEXQARXWTffgFjLJ8Uz0JVYiIE7z9D9fduBx1XLr
 jeQIYn8XLcD/llLmSmaAhoczn2etlbn6xRY5USt67kR+gNFIFZZ/4AQqZb5KK97iICBD 9A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ggh2judcj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Jun 2022 08:33:35 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2568XZe3020633;
        Mon, 6 Jun 2022 08:33:35 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ggh2judc3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Jun 2022 08:33:34 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2568Jops007834;
        Mon, 6 Jun 2022 08:33:32 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 3gfy19a3gu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Jun 2022 08:33:32 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2568XUkI22675842
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Jun 2022 08:33:30 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 207F0A4053;
        Mon,  6 Jun 2022 08:33:30 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8C814A4051;
        Mon,  6 Jun 2022 08:33:23 +0000 (GMT)
Received: from [9.43.87.254] (unknown [9.43.87.254])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  6 Jun 2022 08:33:23 +0000 (GMT)
Message-ID: <d2513be5-be87-2957-a0d4-1d99b9e83114@linux.ibm.com>
Date:   Mon, 6 Jun 2022 14:03:21 +0530
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
From:   Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
In-Reply-To: <11f94e0c50f17f4a6a2f974cb69a1ae72853e2be.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: CGFDgbn45xL78LkzZ6dNilLNfTc0dKCP
X-Proofpoint-ORIG-GUID: e52-4VTv95LSENaHpH1V1Dipw53a7BsH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-06_02,2022-06-03_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 lowpriorityscore=0
 clxscore=1015 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206060039
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/6/22 12:54 PM, Ying Huang wrote:
> On Mon, 2022-06-06 at 09:22 +0530, Aneesh Kumar K V wrote:
>> On 6/6/22 8:41 AM, Ying Huang wrote:
>>> On Fri, 2022-06-03 at 19:12 +0530, Aneesh Kumar K.V wrote:
>>>> With memory tiers support we can have memory on NUMA nodes
>>>> in the top tier from which we want to avoid promotion tracking NUMA
>>>> faults. Update node_is_toptier to work with memory tiers. To
>>>> avoid taking locks, a nodemask is maintained for all demotion
>>>> targets. All NUMA nodes are by default top tier nodes and as
>>>> we add new lower memory tiers NUMA nodes get added to the
>>>> demotion targets thereby moving them out of the top tier.
>>>
>>> Check the usage of node_is_toptier(),
>>>
>>> - migrate_misplaced_page()
>>>     node_is_toptier() is used to check whether migration is a promotion.
>>> We can avoid to use it.  Just compare the rank of the nodes.
>>>
>>> - change_pte_range() and change_huge_pmd()
>>>     node_is_toptier() is used to avoid scanning fast memory (DRAM) pages
>>> for promotion.  So I think we should change the name to node_is_fast()
>>> as follows,
>>>
>>> static inline bool node_is_fast(int node)
>>> {
>>> 	return NODE_DATA(node)->mt_rank >= MEMORY_RANK_DRAM;
>>> }
>>>
>>
>> But that gives special meaning to MEMORY_RANK_DRAM. As detailed in other
>> patches, absolute value of rank doesn't carry any meaning. It is only
>> the relative value w.r.t other memory tiers that decide whether it is
>> fast or not. Agreed by default memory tiers get built with
>> MEMORY_RANK_DRAM. But userspace can change the rank value of 'memtier1'
>> Hence to determine a node is consisting of fast memory is essentially
>> figuring out whether node is the top most tier in memory hierarchy and
>> not just the memory tier rank value is >= MEMORY_RANK_DRAM?
> 
> In a system with 3 tiers,
> 
> HBM	0
> DRAM	1
> PMEM	2
> 
> In your implementation, only HBM will be considered fast.  But what we
> need is to consider both HBM and DRAM fast.  Because we use NUMA
> balancing to promote PMEM pages to DRAM.  It's unnecessary to scan HBM
> and DRAM pages for that.  And there're no requirements to promote DRAM
> pages to HBM with NUMA balancing.
> 
> I can understand that the memory tiers are more dynamic now.  For
> requirements of NUMA balancing, we need the lowest memory tier (rank)
> where there's at least one node with CPU.  The nodes in it and the
> higher tiers will be considered fast.
> 

is this good (not tested)?
/*
  * build the allowed promotion mask. Promotion is allowed
  * from higher memory tier to lower memory tier only if
  * lower memory tier doesn't include compute. We want to
  * skip promotion from a memory tier, if any node which is
  * part of that memory tier have CPUs. Once we detect such
  * a memory tier, we consider that tier as top tier from
  * which promotion is not allowed.
  */
list_for_each_entry_reverse(memtier, &memory_tiers, list) {
	nodes_and(allowed, node_state[N_CPU], memtier->nodelist);
	if (nodes_empty(allowed))
		nodes_or(promotion_mask, promotion_mask, allowed);
	else
		break;
}

and then

static inline bool node_is_toptier(int node)
{

	return !node_isset(node, promotion_mask);
}

