Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2B655AA730
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 07:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233250AbiIBFYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 01:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiIBFYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 01:24:14 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6593B6572
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 22:24:13 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2825GRbt039775;
        Fri, 2 Sep 2022 05:23:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=1FwgvqB2kOUB4vunT2quwBJ0MRT6IRnP/7Q3j22eWWI=;
 b=k/VGC6fU8gklGyakqxHEkMlJpQpkYIThSZIRzyjeRky3o6mSY0PLr1Qmt8UNbRIV5+Y0
 ruh83oW4XT+JTfhCpobB7+unOJHj71mCotAZxqYUzsGLyPVWPlcUAYYdHOYOIAHZGe1n
 cWlJcNfzNp8SX8x7elvc2xVqEt1ka/H+3gc27VEZZe2hgsTSQncNRRwiop7XsJhUn63X
 15EgDacoOYZrOap+/I6WzrjbcNXV41S1ZlojYM514yOvhxLBAq7g/sXqNOqi+FMjeXTo
 0/mNd6ib7B2XR0eBKtDQxqeLB6pNeU4/6GESHb4y3kPPZQ5Mlb+fV9/3BcK62XpNOJW/ Dw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jbbhhg67e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Sep 2022 05:23:52 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2825GmoO040202;
        Fri, 2 Sep 2022 05:23:51 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jbbhhg66u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Sep 2022 05:23:51 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2825Lc9r008851;
        Fri, 2 Sep 2022 05:23:49 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma05fra.de.ibm.com with ESMTP id 3j7aw8wm0v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Sep 2022 05:23:49 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2825Nkol39846296
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 2 Sep 2022 05:23:46 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C37EF4C040;
        Fri,  2 Sep 2022 05:23:46 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8D4F44C044;
        Fri,  2 Sep 2022 05:23:41 +0000 (GMT)
Received: from [9.43.64.219] (unknown [9.43.64.219])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  2 Sep 2022 05:23:41 +0000 (GMT)
Message-ID: <d91beb53-e940-e02a-f9ca-3326bf914da7@linux.ibm.com>
Date:   Fri, 2 Sep 2022 10:53:40 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v3 updated] mm/demotion: Expose memory tier details via
 sysfs
Content-Language: en-US
To:     Wei Xu <weixugc@google.com>, "Huang, Ying" <ying.huang@intel.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
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
        jvgediya.oss@gmail.com, Bharata B Rao <bharata@amd.com>,
        Greg Thelen <gthelen@google.com>
References: <20220830081736.119281-1-aneesh.kumar@linux.ibm.com>
 <87tu5rzigc.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ad19e105-9290-922d-59e6-e6813a30f5f0@linux.ibm.com>
 <87pmgezkhp.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <CAAPL-u8MEs04DkHy6kaS788VjdYZZjAYOgzMnioOzDXbc0ZhhQ@mail.gmail.com>
From:   Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
In-Reply-To: <CAAPL-u8MEs04DkHy6kaS788VjdYZZjAYOgzMnioOzDXbc0ZhhQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: JVbLPad--HYiCEG4zpi3nnsqOoocNTdu
X-Proofpoint-ORIG-GUID: _QRjILfWhJm9MSUJf7nlcEmHJd8-cy2j
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-01_12,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 malwarescore=0 priorityscore=1501 mlxscore=0 clxscore=1015 mlxlogscore=993
 impostorscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209020021
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/2/22 10:39 AM, Wei Xu wrote:
> On Thu, Sep 1, 2022 at 5:33 PM Huang, Ying <ying.huang@intel.com> wrote:
>>
>> Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> writes:
>>
>>> On 9/1/22 12:31 PM, Huang, Ying wrote:
>>>> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
>>>>
>>>>> This patch adds /sys/devices/virtual/memory_tiering/ where all memory tier
>>>>> related details can be found. All allocated memory tiers will be listed
>>>>> there as /sys/devices/virtual/memory_tiering/memory_tierN/
>>>>>
>>>>> The nodes which are part of a specific memory tier can be listed via
>>>>> /sys/devices/virtual/memory_tiering/memory_tierN/nodes
>>>>
>>>> I think "memory_tier" is a better subsystem/bus name than
>>>> memory_tiering.  Because we have a set of memory_tierN devices inside.
>>>> "memory_tier" sounds more natural.  I know this is subjective, just my
>>>> preference.
>>>>


I missed replying to this earlier. I will keep memory_tiering as subsystem name in v4 
because we would want it to a susbsystem where all memory tiering related details can be found
including memory type in the future. This is as per discussion 

https://lore.kernel.org/linux-mm/CAAPL-u9TKbHGztAF=r-io3gkX7gorUunS2UfstudCWuihrA=0g@mail.gmail.com

>>>>>
>>>>> A directory hierarchy looks like
>>>>> :/sys/devices/virtual/memory_tiering$ tree memory_tier4/
>>>>> memory_tier4/
>>>>> ├── nodes
>>>>> ├── subsystem -> ../../../../bus/memory_tiering
>>>>> └── uevent
>>>>>
>>>>> All toptier nodes are listed via
>>>>> /sys/devices/virtual/memory_tiering/toptier_nodes
>>>>>
>>>>> :/sys/devices/virtual/memory_tiering$ cat toptier_nodes
>>>>> 0,2
>>>>> :/sys/devices/virtual/memory_tiering$ cat memory_tier4/nodes
>>>>> 0,2
>>>>
>>>> I don't think that it is a good idea to show toptier information in user
>>>> space interface.  Because it is just a in kernel implementation
>>>> details.  Now, we only promote pages from !toptier to toptier.  But
>>>> there may be multiple memory tiers in toptier and !toptier, we may
>>>> change the implementation in the future.  For example, we may promote
>>>> pages from DRAM to HBM in the future.
>>>>
>>>
>>>
>>> In the case you describe above and others, we will always have a list of
>>> NUMA nodes from which memory promotion is not done.
>>> /sys/devices/virtual/memory_tiering/toptier_nodes shows that list.
>>
>> I don't think we will need that interface if we don't restrict promotion
>> in the future.  For example, he can just check the memory tier with
>> smallest number.
>>
>> TBH, I don't know why do we need that interface.  What is it for?  We
>> don't want to expose unnecessary information to restrict our in kernel
>> implementation in the future.
>>
>> So, please remove that interface at least before we discussing it
>> thoroughly.
> 
> I have asked for this interface to allow the userspace to query a list
> of top-tier nodes as the targets of userspace-driven promotions.  The
> idea is that demotion can gradually go down tier by tier, but we
> promote hot pages directly to the top-tier and bypass the immediate
> tiers.
> 
> Certainly, this can be viewed as a policy choice.  Given that now we
> have a clearly defined memory tier hierarchy in sysfs and the
> toptier_nodes content can be constructed from this memory tier
> hierarchy and other information from the node sysfs interfaces, I am
> fine if we want to remove toptier_nodes and keep the current memory
> tier sysfs interfaces to the minimal.
>


Ok I can do a v4 with toptier_nodes dropped.

 
-aneesh

