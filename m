Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC64586399
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 06:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239546AbiHAEsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 00:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238845AbiHAEsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 00:48:00 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA6AA194
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 21:47:59 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2714dTvt029383;
        Mon, 1 Aug 2022 04:47:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=0ZeKB5/7UPuG9ARuCsC3LP8pAP1UFfxwG6u1FvcnW5s=;
 b=UQAU1V4JvANv28YZnJjvlHftJA0XRW8+dSYjSi1lu8ArfH7z+O6TJfWdx4gYzkGYsDvD
 qzrnST/XasSo2aCTHt79rIdnvc3LifUsAm/v+nelL38jAVs1DDZOzUsSJzoGnM8H+5Dm
 VSez5tPmeYI1SRehpCZHVQNssUSK/hUNSnzzR30ayebFVTiynjxqpC1v/LmVhRoZ32oI
 aT66c4TgK8CkZUUxQa2UY25JPGeDMOYKS1FwDeTSBtUW1gFsWpWbuRYOU3wjou/UYW7l
 kd5A6thRtXFvRJI1Y8olj0lvGV8dEYf5sbq9IvtMxyaNDmkyKV7xlNzT0s6F6rBRQ/3R KA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hp51q3xty-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Aug 2022 04:47:37 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2714Fnva008605;
        Mon, 1 Aug 2022 04:47:37 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hp51q3xt1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Aug 2022 04:47:37 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2714ZR6Y032306;
        Mon, 1 Aug 2022 04:47:35 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 3hmv98snuy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Aug 2022 04:47:35 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2714jMCP26345976
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 1 Aug 2022 04:45:22 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C330AAE04D;
        Mon,  1 Aug 2022 04:47:32 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 22E2CAE045;
        Mon,  1 Aug 2022 04:47:29 +0000 (GMT)
Received: from [9.43.22.209] (unknown [9.43.22.209])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  1 Aug 2022 04:47:28 +0000 (GMT)
Message-ID: <60846a10-f661-69e1-f4f2-71bfeca8f9b4@linux.ibm.com>
Date:   Mon, 1 Aug 2022 10:17:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v12 1/8] mm/demotion: Add support for explicit memory
 tiers
Content-Language: en-US
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        Wei Xu <weixugc@google.com>, Yang Shi <shy828301@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim C Chen <tim.c.chen@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>, jvgediya.oss@gmail.com,
        Jagdish Gediya <jvgediya@linux.ibm.com>
References: <20220729061349.968148-1-aneesh.kumar@linux.ibm.com>
 <20220729061349.968148-2-aneesh.kumar@linux.ibm.com>
 <877d3slmdm.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
In-Reply-To: <877d3slmdm.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: eIfzWnTfpgA0tsCGrJlY3NF1IA4ksNG5
X-Proofpoint-ORIG-GUID: IVMadr9TdV0EjcZnW-apW2XLMAPNHRjw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-01_01,2022-07-28_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 spamscore=0 impostorscore=0 suspectscore=0 mlxscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 bulkscore=0 mlxlogscore=999 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2208010024
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/1/22 8:07 AM, Huang, Ying wrote:
> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
> 
>> In the current kernel, memory tiers are defined implicitly via a demotion path
>> relationship between NUMA nodes, which is created during the kernel
>> initialization and updated when a NUMA node is hot-added or hot-removed. The
>> current implementation puts all nodes with CPU into the highest tier, and builds
>> the tier hierarchy tier-by-tier by establishing the per-node demotion targets
>> based on the distances between nodes.
>>
>> This current memory tier kernel implementation needs to be improved for several
>> important use cases,
>>
>> The current tier initialization code always initializes each memory-only NUMA
>> node into a lower tier. But a memory-only NUMA node may have a high performance
>> memory device (e.g. a DRAM-backed memory-only node on a virtual machine) that
>> should be put into a higher tier.
>>
>> The current tier hierarchy always puts CPU nodes into the top tier. But on a
>> system with HBM or GPU devices, the memory-only NUMA nodes mapping these devices
>> should be in the top tier, and DRAM nodes with CPUs are better to be placed into
>> the next lower tier.
>>
>> With current kernel higher tier node can only be demoted to nodes with shortest
>> distance on the next lower tier as defined by the demotion path, not any other
>> node from any lower tier. This strict, demotion order does not work in all use
>> cases (e.g. some use cases may want to allow cross-socket demotion to another
>> node in the same demotion tier as a fallback when the preferred demotion node is
>> out of space), This demotion order is also inconsistent with the page allocation
>> fallback order when all the nodes in a higher tier are out of space: The page
>> allocation can fall back to any node from any lower tier, whereas the demotion
>> order doesn't allow that.
>>
>> This patch series address the above by defining memory tiers explicitly.
>>
>> Linux kernel presents memory devices as NUMA nodes and each memory device is of
>> a specific type. The memory type of a device is represented by its abstract
>> distance. A memory tier corresponds to a range of abstract distance. This allows
>> for classifying memory devices with a specific performance range into a memory
>> tier.
>>
>> This patch configures the range/chunk size to be 128. The default DRAM
>> abstract distance is 512. We can have 4 memory tiers below the default DRAM
>                                                        ~~~~~
> 
> above?

Updated the above as below.


This patch configures the range/chunk size to be 128. The default DRAM abstract
distance is 512. We can have 4 memory tiers below the default DRAM with abstract
distance range 0 - 127, 127 - 255, 256- 383, 384 - 511. Faster memory devices
can be placed in these faster(higher) memory tiers. Slower memory devices like
persistent memory will have abstract distance higher than the default DRAM
level.




> 
>> abstract distance which cover the range 0 - 127, 127 - 255, 256- 383, 384 - 511.
>> Slower memory devices like persistent memory will have abstract distance higher
>> than the default DRAM level.
>>

-aneesh
