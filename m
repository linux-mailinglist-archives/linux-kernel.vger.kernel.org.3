Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49F7D511067
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 07:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357802AbiD0FJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 01:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245431AbiD0FJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 01:09:38 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3CE142EFA
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 22:06:28 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23R0kgKO020360;
        Wed, 27 Apr 2022 05:06:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=hJvnSUbZy25UMCTi1FMd0CCHepnruFgCsLq+n7+gHOQ=;
 b=s6OJB/wCsSsoG4fN6mpk9Kh6zorUJhCI8r+nrtceQGGsR39c0ivsNNs2cSPMU3z1+VJr
 hLLmD22MWMZIB6XAhHsIFb2vlYbn1HuaBb8g6tMp9/Z2z8V7qirzK6N3RFOrmwY0/ia1
 C5NyUxwDZaYT3Nsz/5YgCtW71e1e07E0AHK2AA3giaD4kvAqfkZFRUbdDBA0lGOlfFpP
 9RPH/mc+GD1+16VAu5IvXQfndo+LKgH+6eD/D2tRuNhnTFmg/JV7Jn9XXFnS1iwjoT/m
 PGDQ1hawc4vooeVHv3uh+KTO/3c5MS74sCfyUGOd9sSHJ9uAigQV6J7LSMKbSbgLu2Qf 6A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fpuk8uayw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Apr 2022 05:06:22 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 23R51M8x040006;
        Wed, 27 Apr 2022 05:06:21 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fpuk8uaye-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Apr 2022 05:06:21 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23R54kMi005620;
        Wed, 27 Apr 2022 05:06:18 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 3fm938wbyh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Apr 2022 05:06:18 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23R4rDOP51577276
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Apr 2022 04:53:13 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 88501A405C;
        Wed, 27 Apr 2022 05:06:16 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 54B5EA405B;
        Wed, 27 Apr 2022 05:06:12 +0000 (GMT)
Received: from [9.43.50.189] (unknown [9.43.50.189])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 27 Apr 2022 05:06:12 +0000 (GMT)
Message-ID: <b1f58fd4-e23b-f617-b4a7-b80b1ffbe13f@linux.ibm.com>
Date:   Wed, 27 Apr 2022 10:36:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2 0/5] mm: demotion: Introduce new node state
 N_DEMOTION_TARGETS
Content-Language: en-US
To:     Wei Xu <weixugc@google.com>,
        "ying.huang@intel.com" <ying.huang@intel.com>
Cc:     Jagdish Gediya <jvgediya@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Greg Thelen <gthelen@google.com>,
        MichalHocko <mhocko@kernel.org>,
        Brice Goglin <brice.goglin@gmail.com>
References: <CAAPL-u_pSWD6U0yQ8Ws+_Yfb_3ZEmNXJsYcRJjAFBkyDk=nq8g@mail.gmail.com>
 <ea73f6fda9cafdd0cb6ba8351139e6f4b47354a8.camel@intel.com>
 <CAAPL-u-aeceXFUNdok_GYb2aLhZa0zBBuSqHxFznQob3PbJt7Q@mail.gmail.com>
 <a80647053bba44623094995730e061f0e6129677.camel@intel.com>
 <CAAPL-u89Jxutu1VH0LnO5VGdMbkLvc2M9eapuwP-y9oG9QSsrA@mail.gmail.com>
 <610ccaad03f168440ce765ae5570634f3b77555e.camel@intel.com>
 <CAAPL-u9ktM82zAW_OVwqTmQsr-XC8XOPmAsjoiCLo18cxUWA=A@mail.gmail.com>
 <8e31c744a7712bb05dbf7ceb2accf1a35e60306a.camel@intel.com>
 <CAAPL-u9uP+FUh7Yn0ByOECo+EP32ZABnCvNPKQB9JCA68VHEqQ@mail.gmail.com>
 <78b5f4cfd86efda14c61d515e4db9424e811c5be.camel@intel.com>
 <YmKKwXa2XI/nwac0@li-6e1fa1cc-351b-11b2-a85c-b897023bb5f3.ibm.com>
 <200e95cf36c1642512d99431014db8943fed715d.camel@intel.com>
 <CAAPL-u94H9FLjVtYLhi_A2AqLTOCTMRh6=Sx9cX8A3WGNM-OdA@mail.gmail.com>
From:   Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
In-Reply-To: <CAAPL-u94H9FLjVtYLhi_A2AqLTOCTMRh6=Sx9cX8A3WGNM-OdA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: zcsXG75rmd7P91OW5F4IYocVhoZkwC-h
X-Proofpoint-GUID: r3ifzdgu2dYa4p5g4oo_b58XhBl-EXd-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-27_01,2022-04-26_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 spamscore=0 bulkscore=0 suspectscore=0 clxscore=1015 mlxlogscore=999
 impostorscore=0 adultscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204270032
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/25/22 10:26 PM, Wei Xu wrote:
> On Sat, Apr 23, 2022 at 8:02 PM ying.huang@intel.com
> <ying.huang@intel.com> wrote:
>>

....

>> 2. For machines with PMEM installed in only 1 of 2 sockets, for example,
>>
>> Node 0 & 2 are cpu + dram nodes and node 1 are slow
>> memory node near node 0,
>>
>> available: 3 nodes (0-2)
>> node 0 cpus: 0 1
>> node 0 size: n MB
>> node 0 free: n MB
>> node 1 cpus:
>> node 1 size: n MB
>> node 1 free: n MB
>> node 2 cpus: 2 3
>> node 2 size: n MB
>> node 2 free: n MB
>> node distances:
>> node   0   1   2
>>    0:  10  40  20
>>    1:  40  10  80
>>    2:  20  80  10
>>
>> We have 2 choices,
>>
>> a)
>> node    demotion targets
>> 0       1
>> 2       1
>>
>> b)
>> node    demotion targets
>> 0       1
>> 2       X
>>
>> a) is good to take advantage of PMEM.  b) is good to reduce cross-socket
>> traffic.  Both are OK as defualt configuration.  But some users may
>> prefer the other one.  So we need a user space ABI to override the
>> default configuration.
> 
> I think 2(a) should be the system-wide configuration and 2(b) can be
> achieved with NUMA mempolicy (which needs to be added to demotion).
> 
> In general, we can view the demotion order in a way similar to
> allocation fallback order (after all, if we don't demote or demotion
> lags behind, the allocations will go to these demotion target nodes
> according to the allocation fallback order anyway).  If we initialize
> the demotion order in that way (i.e. every node can demote to any node
> in the next tier, and the priority of the target nodes is sorted for
> each source node), we don't need per-node demotion order override from
> the userspace.  What we need is to specify what nodes should be in
> each tier and support NUMA mempolicy in demotion.
> 

I have been wondering how we would handle this. For ex: If an 
application has specified an MPOL_BIND policy and restricted the 
allocation to be from Node0 and Node1, should we demote pages allocated 
by that application
to Node10? The other alternative for that demotion is swapping. So from 
the page point of view, we either demote to a slow memory or pageout to 
swap. But then if we demote we are also breaking the MPOL_BIND rule.

The above says we would need some kind of mem policy interaction, but 
what I am not sure about is how to find the memory policy in the 
demotion path.


> Cross-socket demotion should not be too big a problem in practice
> because we can optimize the code to do the demotion from the local CPU
> node (i.e. local writes to the target node and remote read from the
> source node).  The bigger issue is cross-socket memory access onto the
> demoted pages from the applications, which is why NUMA mempolicy is
> important here.
> 
>
-aneesh
