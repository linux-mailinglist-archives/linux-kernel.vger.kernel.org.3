Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3C153C73C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 11:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242946AbiFCJFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 05:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiFCJFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 05:05:05 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0670A381B1
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 02:05:04 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2536DNMu018802;
        Fri, 3 Jun 2022 09:04:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=fkgjiBbvfssojcLQ5Xrtaf/b+dhAnuUhltuZxxE14dI=;
 b=Wnm87g9cv/OXyRG2iPsmT0vdxsFSuIvKeOHM8JuM/Qxtjh6f6JvoPBQAhgn9nK9Kl+30
 YicjWWZLTm2D/g3IjKTWANv7vp5Zwt9rQhU56OySYx2e0RmNv3M2v1qFw7Yoy9EC5s7d
 G7t8UokrZs60Zi0hKzI5p1eE4ypTnzIhjXJZ25dgyQBM/KX6RMCl/otn8/xjLpOYAAeu
 P0etDZTOeCt81w0yAixagmYRzpSJRcLqi7p4c0dKJN6qNQ7lJcljLyaFs9JbMCHxVSfp
 qK3Pr8gRfizOC5hSCBSZNEeJT97S2Lbx5VSg76re2EXXNWUG/ibyd9UW7/IbnMs1oTo9 wA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3gfcu8jss1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Jun 2022 09:04:44 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2538usfW020405;
        Fri, 3 Jun 2022 09:04:43 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3gfcu8jsrg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Jun 2022 09:04:43 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2538pqgb014509;
        Fri, 3 Jun 2022 09:04:41 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 3gbcae85bu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Jun 2022 09:04:41 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25394doC44302756
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 Jun 2022 09:04:39 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0ED5A4C044;
        Fri,  3 Jun 2022 09:04:39 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C18B34C046;
        Fri,  3 Jun 2022 09:04:32 +0000 (GMT)
Received: from [9.43.93.173] (unknown [9.43.93.173])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  3 Jun 2022 09:04:32 +0000 (GMT)
Message-ID: <c98eb873-a5bb-edcc-743d-89cfffe52cd9@linux.ibm.com>
Date:   Fri, 3 Jun 2022 14:34:31 +0530
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
From:   Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
In-Reply-To: <d45374fa-6e51-36cb-9a2c-96f85d9de528@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: oSx9HJET7Gpw0PQRshfj_d5cI9DoJaRx
X-Proofpoint-ORIG-GUID: kEMdneNsbdlx1A764xvy2vRfXW557sLJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-03_02,2022-06-02_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 suspectscore=0 clxscore=1015 mlxscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206030039
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/2/22 12:06 PM, Bharata B Rao wrote:
> On 6/1/2022 7:19 PM, Aneesh Kumar K V wrote:
>> On 6/1/22 11:59 AM, Bharata B Rao wrote:
>>> I was experimenting with this patchset and found this behaviour.
>>> Here's what I did:
>>>
>>> Boot a KVM guest with vNVDIMM device which ends up with device_dax
>>> driver by default.
>>>
>>> Use it as RAM by binding it to dax kmem driver. It now appears as
>>> RAM with a new NUMA node that is put to memtier1 (the existing tier
>>> where DRAM already exists)
>>>
>>
>> That should have placed it in memtier2.
>>
>>> I can move it to memtier2 (MEMORY_RANK_PMEM) manually, but isn't
>>> that expected to happen automatically when a node with dax kmem
>>> device comes up?
>>>
>>
>> This can happen if we have added the same NUMA node to memtier1 before dax kmem driver initialized the pmem memory. Can you check before the above node_set_memory_tier_rank() whether the specific NUMA node is already part of any memory tier?
> 
> When we reach node_set_memory_tier_rank(), node1 (that has the pmem device)
> is already part of memtier1 whose nodelist shows 0-1.
> 

can you find out which code path added node1 to memtier1? Do you have 
regular memory also appearing on node1?

-aneesh
