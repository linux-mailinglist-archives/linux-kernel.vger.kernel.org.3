Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E51EB5A2292
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 10:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245306AbiHZIGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 04:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235918AbiHZIGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 04:06:30 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1645BD41B8
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 01:06:30 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27Q7qibT026387;
        Fri, 26 Aug 2022 08:05:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=+q+mcuZT1yCtfvoq3MQBSvgKBHU0yUIHVcNQ3mpq+bU=;
 b=V/vCTwqxvCTwc1Kn1DTNMXFcn/IPK8RQScj8VK70CL1u/9rBrJyRATHzPCF6e3sSILvn
 1FtM8jk8F49OU+qoKiwk8Cr4ACQBxo9EtsAjffDvVOar+isIEEcCHTEYb+MwutLo6OsU
 tW9vgdn3aZNWakoyV/Y9whZV+duF/MD68xgRRWRjVGmhjkVWEEO6gV/XNcULCEceR2CV
 NBFQ/nYs95ch67gb9Ncj0KYRjhEwHZVBYXw4d6Fy8FwMMpVGs13Zqn0cGYwU+MuSCD2A
 NkpVAdi5PSVS4DOGjeCmG+CMWp8nDxNUtdvGp08GdoukZE0+En2QpM4bay5CfrE/Aj9Y oQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j6t62gbvh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Aug 2022 08:05:56 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27Q7v080038655;
        Fri, 26 Aug 2022 08:05:55 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j6t62gbtj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Aug 2022 08:05:55 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27Q7pbw2003400;
        Fri, 26 Aug 2022 08:05:53 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 3j2q88ye8u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Aug 2022 08:05:53 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27Q85p7E35783036
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Aug 2022 08:05:51 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 39C84A4053;
        Fri, 26 Aug 2022 08:05:51 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DE272A4040;
        Fri, 26 Aug 2022 08:05:45 +0000 (GMT)
Received: from [9.43.10.139] (unknown [9.43.10.139])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 26 Aug 2022 08:05:45 +0000 (GMT)
Message-ID: <4abb84e8-8035-65aa-941a-98f0d7902c42@linux.ibm.com>
Date:   Fri, 26 Aug 2022 13:35:44 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [RFC PATCH 1/2] mm/demotion: Expose memory type details via sysfs
Content-Language: en-US
To:     Wei Xu <weixugc@google.com>
Cc:     "Huang, Ying" <ying.huang@intel.com>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <shy828301@gmail.com>,
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
        Bharata B Rao <bharata@amd.com>
References: <20220825092325.381517-1-aneesh.kumar@linux.ibm.com>
 <877d2v3h8s.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <e2f20ae9-5761-c170-a4e7-121d6b69ebfb@linux.ibm.com>
 <CAAPL-u9TKbHGztAF=r-io3gkX7gorUunS2UfstudCWuihrA=0g@mail.gmail.com>
From:   Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
In-Reply-To: <CAAPL-u9TKbHGztAF=r-io3gkX7gorUunS2UfstudCWuihrA=0g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: f5uYDCTq5rIu0455lEF1GcIUMLo4MQoc
X-Proofpoint-ORIG-GUID: JPItfWiSpSd6K9jtVpalgu9qdigvGpiO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-26_03,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208260029
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/26/22 1:30 PM, Wei Xu wrote:
> On Thu, Aug 25, 2022 at 8:00 PM Aneesh Kumar K V
> <aneesh.kumar@linux.ibm.com> wrote:
>>
>> On 8/26/22 7:20 AM, Huang, Ying wrote:
>>> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
>>>
>>>> This patch adds /sys/devices/virtual/memtier/ where all memory tier related
>>>> details can be found. All allocated memory types will be listed there as
>>>> /sys/devices/virtual/memtier/memtypeN/
>>>
>>> Another choice is to make memory types and memory tiers system devices.
>>> That is,
>>>
>>> /sys/devices/system/memory_type/memory_typeN
>>> /sys/devices/system/memory_tier/memory_tierN
>>>
>>
>> subsys_system_register() documentation says
>>
>>  * Do not use this interface for anything new, it exists for compatibility
>>  * with bad ideas only. New subsystems should use plain subsystems; and
>>  * add the subsystem-wide attributes should be added to the subsystem
>>  * directory itself and not some create fake root-device placed in
>>  * /sys/devices/system/<name>.
>>
>> memtier being a virtual device, I was under the impression that /sys/devices/virtual
>> is the recommended place.
>>
>>> That looks more natural to me.  Because we already have "node" and
>>> "memory" devices there.  Why don't you put memory types and memory tiers
>>> there?
>>>
>>> And, I think we shouldn't put "memory_type" in the "memory_tier"
>>> directory.  "memory_type" isn't a part of "memory_tier".
>>>
>>
>> I was looking consolidating both memory tier and memory type into the same sysfs subsystem.
>> Your recommendation imply we create two subsystem memory_tier and memtype. I was
>> trying to avoid that. May be a generic term like "memory_tiering" can help to
>> consolidate all tiering related details there?
>>
> 
> A generic term "memory_tiering" sounds good to me.
> 
> Given that this will be a user-facing, stable kernel API, I think we'd
> better to only add what is most useful for userspace and don't have to
> mirror the kernel internal data structures in this interface.
> 
> My understanding is that we haven't fully settled down on how to
> customize memory tiers from userspace.  So we don't have to show
> memory_type yet, which is a kernel data structure at this point.
> 
> The userspace does need to know what are the memory tiers and which
> NUMA nodes are included in each memory tier.  How about we provide the
> "nodelist" interface for each memory tier as in the original proposal?
> 
> The userspace would also like to know which memory tiers/nodes belong
> to the top tiers (the promotion targets).  We can provide a "toptiers"
> or "toptiers_nodelist" interface to report that.
> 

How about also including abstract distance range of a memory tier?
That will be useful to derive the hierarchy.

> Both should still be useful even if we decide to add memory_type for
> memory tier customization.
> 

-aneesh
