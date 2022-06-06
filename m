Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85D6E53ECA7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233895AbiFFKXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 06:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233892AbiFFKXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 06:23:13 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF60714D27
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 03:23:05 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2567q3wT012559;
        Mon, 6 Jun 2022 10:16:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=r/7ltCWmf5+CKc8gc8bl1t4b1h7KsBC3K0+0gW7Z0lE=;
 b=nAk+2lbNVTQW4/Yq+bZG7rmAbRE4ObGjHVHSJ/fOqyE2rAhOSI3OdLM01rE/q4Y9PoNg
 gSMMv/wdCbYXq/GvT+HBWn6RXqhv8W32xFIQwPSugTPkGrythzT37PL14hBp6cloByiQ
 5/5XUi8Gq23vrj7/9G3eyAgyqLEN+HHCOXmbHBh6kKtoUk/aL0TOw2450JejvaCl33Ct
 IEZvqFfpZ4wn9fOFqmXmleFCTZJk2JLqUXT+nK8vKLgtlNZKPuwWvEN6pqe3ZlK5oVlL
 ahmuzBrOkqL1l4ZBt+BPQlUdpx9p/tJQBehyxZyYobIuMAWwgCy4kLi69q5iQFJv0EDJ gQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ggh6sd6da-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Jun 2022 10:16:47 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2569oWPH020869;
        Mon, 6 Jun 2022 10:16:47 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ggh6sd6cn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Jun 2022 10:16:46 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 256A5Wks013910;
        Mon, 6 Jun 2022 10:16:44 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03ams.nl.ibm.com with ESMTP id 3gfy19a7g5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Jun 2022 10:16:44 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 256AGgoF22806976
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Jun 2022 10:16:42 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E34F6A4051;
        Mon,  6 Jun 2022 10:16:41 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CFAA1A404D;
        Mon,  6 Jun 2022 10:16:37 +0000 (GMT)
Received: from [9.43.87.254] (unknown [9.43.87.254])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  6 Jun 2022 10:16:37 +0000 (GMT)
Message-ID: <a844c8c9-e1e1-2ccb-d58c-a5a608afabc0@linux.ibm.com>
Date:   Mon, 6 Jun 2022 15:46:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [RFC PATCH v4 4/7] mm/demotion/dax/kmem: Set node's memory tier
 to MEMORY_TIER_PMEM
Content-Language: en-US
To:     Bharata B Rao <bharata@amd.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org
Cc:     Huang Ying <ying.huang@intel.com>,
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
References: <CAAPL-u-dFp7PwPH6DfbYdnY8xaGsHz3tRQ0CPGVkiqURvdN8=A@mail.gmail.com>
 <20220527122528.129445-1-aneesh.kumar@linux.ibm.com>
 <20220527122528.129445-5-aneesh.kumar@linux.ibm.com>
 <5706f5e9-0609-98c9-a0cd-7d96336d73dd@amd.com>
 <8e651a1e-d189-3e8a-438f-298f21402bd2@linux.ibm.com>
 <d45374fa-6e51-36cb-9a2c-96f85d9de528@amd.com>
 <c98eb873-a5bb-edcc-743d-89cfffe52cd9@linux.ibm.com>
 <d6c94fd5-053b-7e6f-dc4e-83184ecf131a@amd.com>
From:   Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
In-Reply-To: <d6c94fd5-053b-7e6f-dc4e-83184ecf131a@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: qyDZgh5gwRpVe2aO-bzsSTlAQrg9c9sK
X-Proofpoint-ORIG-GUID: LD_gjvEYbJ2LODADHpKqSS83C8Epu5FQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-06_03,2022-06-03_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 mlxscore=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 clxscore=1015 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206060046
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/6/22 3:41 PM, Bharata B Rao wrote:
> On 6/3/2022 2:34 PM, Aneesh Kumar K V wrote:
>> On 6/2/22 12:06 PM, Bharata B Rao wrote:
>>> On 6/1/2022 7:19 PM, Aneesh Kumar K V wrote:
>>>> On 6/1/22 11:59 AM, Bharata B Rao wrote:
>>>>> I was experimenting with this patchset and found this behaviour.
>>>>> Here's what I did:
>>>>>
>>>>> Boot a KVM guest with vNVDIMM device which ends up with device_dax
>>>>> driver by default.
>>>>>
>>>>> Use it as RAM by binding it to dax kmem driver. It now appears as
>>>>> RAM with a new NUMA node that is put to memtier1 (the existing tier
>>>>> where DRAM already exists)
>>>>>
>>>>
>>>> That should have placed it in memtier2.
>>>>
>>>>> I can move it to memtier2 (MEMORY_RANK_PMEM) manually, but isn't
>>>>> that expected to happen automatically when a node with dax kmem
>>>>> device comes up?
>>>>>
>>>>
>>>> This can happen if we have added the same NUMA node to memtier1 before dax kmem driver initialized the pmem memory. Can you check before the above node_set_memory_tier_rank() whether the specific NUMA node is already part of any memory tier?
>>>
>>> When we reach node_set_memory_tier_rank(), node1 (that has the pmem device)
>>> is already part of memtier1 whose nodelist shows 0-1.
>>>
>>
>> can you find out which code path added node1 to memtier1?
> 
>   node_set_memory_tier_rank+0x63/0x80
>   migrate_on_reclaim_callback+0x40/0x4d
>   blocking_notifier_call_chain+0x68/0x90
>   memory_notify+0x1b/0x20
>   online_pages+0x257/0x2f0
>   memory_subsys_online+0x99/0x150
>   device_online+0x65/0x90
>   online_memory_block+0x1b/0x20
>   walk_memory_blocks+0x85/0xc0
>   ? generic_online_page+0x40/0x40
>   add_memory_resource+0x1fa/0x2d0
>   add_memory_driver_managed+0x80/0xc0
>   dev_dax_kmem_probe+0x1af/0x250
>   dax_bus_probe+0x6e/0xa0
> 
> After this the explicit call to node_set_memory_tier_rank(numa_node, MEMORY_RANK_PMEM)
> from dev_dax_kmem_probe() finds that the memtier is already set.
> 
>> Do you have regular memory also appearing on node1?
> 
> No, regular memory is on Node0.
> 

Thanks for the stack trace. I was getting the kvm setup on my laptop to 
test this. We should move node_set_mem_tier() early. You had automatic 
online on memory hotplug

	/* online pages if requested */
	if (mhp_default_online_type != MMOP_OFFLINE)
		walk_memory_blocks(start, size, NULL, online_memory_block);


which caused memory to be onlined before we could do node_set_mem_tier. 
That is a bug on my side. Will send you a change after testing .

-aneesh

