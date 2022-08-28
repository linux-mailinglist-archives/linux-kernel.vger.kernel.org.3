Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA9E5A3E8A
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 18:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbiH1QVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 12:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiH1QVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 12:21:08 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60BD865E0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 09:21:06 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27SBfKWt014197;
        Sun, 28 Aug 2022 16:20:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=Du1m+/CG7EP6EXZbBN33ly9Q3u5BC+2hcziJgxO6tPQ=;
 b=DQNGhJFNl05qcx0o0yM6Xk9K08xHAx4bsDcgO/tnnhoGmt8yDmojGj9gS9A294eA9m2S
 pDAuqL2Vxgf47x8CfUxaY72r9NdIoJIJTIKjQMjSDlvLulFsqWDi8v4/+FrrIqB0Hd+a
 lce9359pFC1NYEVv9XhQ+W1UnnJJ8lN7+BMnRLN/VRwgWsmgGTdSufLxKPeSSpIwDFE6
 7PL6ybAC3adN8jnM2gNY2tqCgwkFUgCpa9qxt3hXX4VV1TMbnRF9I+PbwQ9lV+z4uMr9
 40Rm794vuARnoPLCaNtagKq5qLxb5RIFC6hGvIacE2m13YG5T/bIBLM8Chk3Zu5uYHUH wA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j7waqg9t6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 28 Aug 2022 16:20:33 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27SGExJx035811;
        Sun, 28 Aug 2022 16:20:32 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j7waqg9ss-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 28 Aug 2022 16:20:32 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27SG6pIo012671;
        Sun, 28 Aug 2022 16:20:31 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma01dal.us.ibm.com with ESMTP id 3j7aw9a8rt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 28 Aug 2022 16:20:31 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27SGKUVa60227886
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 28 Aug 2022 16:20:30 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7D3A0AE063;
        Sun, 28 Aug 2022 16:20:30 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DEA09AE060;
        Sun, 28 Aug 2022 16:20:24 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.43.1.229])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Sun, 28 Aug 2022 16:20:24 +0000 (GMT)
X-Mailer: emacs 29.0.50 (via feedmail 11-beta-1 I)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
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
Subject: Re: [RFC PATCH 1/2] mm/demotion: Expose memory type details via sysfs
In-Reply-To: <CAAPL-u_d_vozgSum7gX8Ecvh2ZY75KmB0+Z3d0yf7McqsfOU2Q@mail.gmail.com>
References: <20220825092325.381517-1-aneesh.kumar@linux.ibm.com>
 <877d2v3h8s.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <e2f20ae9-5761-c170-a4e7-121d6b69ebfb@linux.ibm.com>
 <CAAPL-u9TKbHGztAF=r-io3gkX7gorUunS2UfstudCWuihrA=0g@mail.gmail.com>
 <4abb84e8-8035-65aa-941a-98f0d7902c42@linux.ibm.com>
 <CAAPL-u_d_vozgSum7gX8Ecvh2ZY75KmB0+Z3d0yf7McqsfOU2Q@mail.gmail.com>
Date:   Sun, 28 Aug 2022 21:50:22 +0530
Message-ID: <87sflgqr09.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: yw6Erhy7x9ajuyn9D16P2LajVMrXQDMm
X-Proofpoint-GUID: e9w2DCRE0iRPUlmx8jMHf92MQEIddl_Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-28_10,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 phishscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208280068
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wei Xu <weixugc@google.com> writes:

>
> On Fri, Aug 26, 2022 at 1:05 AM Aneesh Kumar K V
> <aneesh.kumar@linux.ibm.com> wrote:
>>
>> On 8/26/22 1:30 PM, Wei Xu wrote:
>> > On Thu, Aug 25, 2022 at 8:00 PM Aneesh Kumar K V
>> > <aneesh.kumar@linux.ibm.com> wrote:
>> >>
>> >> On 8/26/22 7:20 AM, Huang, Ying wrote:
>> >>> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
>> >>>
>> >>>> This patch adds /sys/devices/virtual/memtier/ where all memory tier related
>> >>>> details can be found. All allocated memory types will be listed there as
>> >>>> /sys/devices/virtual/memtier/memtypeN/
>> >>>
>> >>> Another choice is to make memory types and memory tiers system devices.
>> >>> That is,
>> >>>
>> >>> /sys/devices/system/memory_type/memory_typeN
>> >>> /sys/devices/system/memory_tier/memory_tierN
>> >>>
>> >>
>> >> subsys_system_register() documentation says
>> >>
>> >>  * Do not use this interface for anything new, it exists for compatibility
>> >>  * with bad ideas only. New subsystems should use plain subsystems; and
>> >>  * add the subsystem-wide attributes should be added to the subsystem
>> >>  * directory itself and not some create fake root-device placed in
>> >>  * /sys/devices/system/<name>.
>> >>
>> >> memtier being a virtual device, I was under the impression that /sys/devices/virtual
>> >> is the recommended place.
>> >>
>> >>> That looks more natural to me.  Because we already have "node" and
>> >>> "memory" devices there.  Why don't you put memory types and memory tiers
>> >>> there?
>> >>>
>> >>> And, I think we shouldn't put "memory_type" in the "memory_tier"
>> >>> directory.  "memory_type" isn't a part of "memory_tier".
>> >>>
>> >>
>> >> I was looking consolidating both memory tier and memory type into the same sysfs subsystem.
>> >> Your recommendation imply we create two subsystem memory_tier and memtype. I was
>> >> trying to avoid that. May be a generic term like "memory_tiering" can help to
>> >> consolidate all tiering related details there?
>> >>
>> >
>> > A generic term "memory_tiering" sounds good to me.
>> >
>> > Given that this will be a user-facing, stable kernel API, I think we'd
>> > better to only add what is most useful for userspace and don't have to
>> > mirror the kernel internal data structures in this interface.
>> >
>> > My understanding is that we haven't fully settled down on how to
>> > customize memory tiers from userspace.  So we don't have to show
>> > memory_type yet, which is a kernel data structure at this point.
>> >
>> > The userspace does need to know what are the memory tiers and which
>> > NUMA nodes are included in each memory tier.  How about we provide the
>> > "nodelist" interface for each memory tier as in the original proposal?
>> >
>> > The userspace would also like to know which memory tiers/nodes belong
>> > to the top tiers (the promotion targets).  We can provide a "toptiers"
>> > or "toptiers_nodelist" interface to report that.
>> >
>>
>> How about also including abstract distance range of a memory tier?
>> That will be useful to derive the hierarchy.
>
> With the base abstract distance in the memtier name, do we need to
> show the abstract distance range if we don't customize memory tiers?
>

IMHO it would simpler to let userspace find abstract distance by reading
a file rather than parsing a file name.

-aneesh
