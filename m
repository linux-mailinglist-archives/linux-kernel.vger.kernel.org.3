Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B69B53E939
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232555AbiFFJDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 05:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232515AbiFFJCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 05:02:52 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E678A21814
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 02:02:50 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2568a0Mt015613;
        Mon, 6 Jun 2022 09:02:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=mzZRZT0AHyq8asyKqO60WX5Lt3f8z0sEDNX/x+OL8GM=;
 b=KLLkjnVy1FzYLEa96yyDz9iJ+ljdJoPsG7XWRhczhNOYgOR+isSTFD/XaI0UPnQbLU8Q
 JbIu8fS68H7tbxPB947mfePx2DbiEJpmlrBvB0EXAV+Diy48JmHCr+4+mmLGpD9jixWf
 AVJlJQBZz7IPnUFUyn1Jq6uDv6fR40NmYA1QnHsS2EDe/wQkvf+e9U1RjVMGqRQ7FuQP
 tN851335kIwyaX5bH0E7wRF/eSCErRzZbqjRME7dcZrr6W8JbFRPIUCA4bpanqRIIbmZ
 UxXdMYox30RD1GKiJ4PtWIiSue5mjTHTnbhr9GHfheuFl97cHNQXY4auyVIOzfkLOeNz Cw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3gghf7bs03-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Jun 2022 09:02:30 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2568OtO1006102;
        Mon, 6 Jun 2022 09:02:29 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3gghf7bryd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Jun 2022 09:02:29 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2568pjjS002172;
        Mon, 6 Jun 2022 09:02:27 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma02fra.de.ibm.com with ESMTP id 3gfy191ngv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Jun 2022 09:02:27 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25692PZ913697476
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Jun 2022 09:02:25 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 47095A4040;
        Mon,  6 Jun 2022 09:02:25 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 02554A404D;
        Mon,  6 Jun 2022 09:02:19 +0000 (GMT)
Received: from [9.43.87.254] (unknown [9.43.87.254])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  6 Jun 2022 09:02:18 +0000 (GMT)
Message-ID: <1301311f-12f0-0fda-1245-82bb4c3f5e93@linux.ibm.com>
Date:   Mon, 6 Jun 2022 14:32:17 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [RFC PATCH v4 1/7] mm/demotion: Add support for explicit memory
 tiers
Content-Language: en-US
To:     Ying Huang <ying.huang@intel.com>
Cc:     Greg Thelen <gthelen@google.com>, Yang Shi <shy828301@gmail.com>,
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
        David Rientjes <rientjes@google.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org
References: <CAAPL-u-dFp7PwPH6DfbYdnY8xaGsHz3tRQ0CPGVkiqURvdN8=A@mail.gmail.com>
 <20220527122528.129445-1-aneesh.kumar@linux.ibm.com>
 <20220527122528.129445-2-aneesh.kumar@linux.ibm.com>
 <352ae5f408b6d7d4d3d820d68e2f2c6b494e95e1.camel@intel.com>
 <aeced91ea9d9396e9842f5c0264391aabd291726.camel@intel.com>
 <d429a644-ef27-bcd8-52bd-c8cbe5fedc26@linux.ibm.com>
 <143e40bcf46097d14514504518fdc1870fd8d4a1.camel@intel.com>
 <eb6d7346-32a9-4fb2-61c2-a413c9f94f1c@linux.ibm.com>
 <87ilpe8fxh.fsf@linux.ibm.com>
 <a20f4db3c55f9471d27eacd7a8a245691a8fcd2f.camel@intel.com>
 <b97d2013-ad5e-9b29-0b95-f52273bd3a8b@linux.ibm.com>
 <d36eabfdc062aeb5aee18ab7ac0bca36b19f8521.camel@intel.com>
From:   Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
In-Reply-To: <d36eabfdc062aeb5aee18ab7ac0bca36b19f8521.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: sJ8vN0SFkEeNXPAJn6o8Cf3tKTp8qn-N
X-Proofpoint-ORIG-GUID: -pUIvSSa_YdMBAh1F8FxerjJXz4pW1Hp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-06_02,2022-06-03_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 suspectscore=0 phishscore=0 clxscore=1015 adultscore=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
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

On 6/6/22 2:22 PM, Ying Huang wrote:
....
>>>> I can move the patch "mm/demotion/dax/kmem: Set node's memory tier to
>>>> MEMORY_TIER_PMEM" before switching the demotion logic so that on systems
>>>> with two memory tiers (DRAM and pmem) the demotion continues to work
>>>> as expected after patch 3 ("mm/demotion: Build demotion targets based on
>>>> explicit memory tiers"). With that, there will not be any regression in
>>>> between the patch series.
>>>>
>>>
>>> Thanks!  Please do that.  And I think you can add sysfs interface after
>>> that patch too.  That is, in [1/7]
>>>
>>
>> I am not sure why you insist on moving sysfs interfaces later. They are
>> introduced based on the helper added. It make patch review easier to
>> look at both the helpers and the user of the helper together in a patch.
> 
> Yes.  We should introduce a function and its user in one patch for
> review.  But this doesn't mean that we should introduce the user space
> interface as the first step.  I think the user space interface should
> output correct information when we expose it.
> 

If you look at this patchset we are not exposing any wrong information.

patch 1 -> adds ability to register the memory tiers and expose details 
of registered memory tier. At this point the patchset only support DRAM 
tier and hence only one tier is shown

patch 2 -> adds per node memtier attribute. So only DRAM nodes shows the 
details, because the patchset yet has not introduced a slower memory 
tier like PMEM.

patch 4 -> introducing demotion. Will make that patch 5

patch 5 -> add dax kmem numa nodes as slower memory tier. Now this 
becomes patch 4 at which point we will correctly show two memory tiers 
in the system.


>>> +struct memory_tier {
>>> +	nodemask_t nodelist;
>>> +};
>>>
>>> And struct device can be added after the kernel has switched the
>>> implementation based on explicit memory tiers.
>>>
>>> +struct memory_tier {
>>> +	struct device dev;
>>> +	nodemask_t nodelist;
>>> +};
>>>
>>
>>
>> Can you elaborate on this? or possibly review the v5 series indicating
>> what change you are suggesting here?
>>
>>
>>> But I don't think it's a good idea to have "struct device" embedded in
>>> "struct memory_tier".  We don't have "struct device" embedded in "struct
>>> pgdata_list"...
>>>
>>
>> I avoided creating an array for memory_tier (memory_tier[]) so that we
>> can keep it dynamic. Keeping dev embedded in struct memory_tier simplify
>> the life cycle management of that dynamic list. We free the struct
>> memory_tier allocation via device release function (memtier->dev.release
>> = memory_tier_device_release )
>>
>> Why do you think it is not a good idea?
> 
> I think that we shouldn't bind our kernel internal implementation with
> user space interface too much.  Yes.  We can expose kernel internal
> implementation to user space in a direct way.  I suggest you to follow
> the style of "struct pglist_data" and "struct node".  If we decouple
> "struct memory_tier" and "struct memory_tier_dev" (or some other name),
> we can refer to "struct memory_tier" without depending on all device
> core.  Memory tier should be accessible inside the kernel even without a
> user interface.  And memory tier isn't a device in concept.
> 

memory_tiers are different from pglist_data and struct node in that we 
also allow the creation of them from userspace. That is the life time of 
a memory tier is driven from userspace and it is much easier to manage 
them via sysfs file lifetime mechanism rather than inventing an 
independent and more complex way of doing the same.

> For life cycle management, I think that we can do that without sysfs
> too.
> 

unless there are specific details that you think will be broken by 
embedding struct device inside struct memory_tier, IMHO I still consider 
the embedded implementation much simpler and in accordance with other 
kernel design patterns.

-aneesh
