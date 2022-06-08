Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8CEE5429DA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 10:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232381AbiFHIuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 04:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232384AbiFHItu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 04:49:50 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E69167CDFD
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 01:06:54 -0700 (PDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 258837w0022441;
        Wed, 8 Jun 2022 08:04:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=OsOMP2pddvT34VMihhk9HBu9kF1H0WfO+h43RB+Rm3A=;
 b=dKE4Da97Kx8o+li2nVSML/NLPOeqXir3+wjxeTj7YUf6qwSYYaeiuTWj4P18cjEdJGAV
 jwmkyUlg3HHeMfYBfDXvMLYa2ydpE5LhXMaUPc4q+jlN5Pcsk+QQkfVWGQ7Q4GF1SJO2
 eT8hXjRvUHTxpt06B7k+2hlVeqW80x8NT8G/9FwkPdjnO8oG4wQR8sc3hIZZ6jxyl8Id
 Z8Z9ZL1Y6T74dtdTXEAQ2dcotL0Nin/QOlpUr+UiAtZaKUYaS/Uj/0B4XmO+up7tCab4
 YteeLFasCzSC1OLPz360LjkHMvNAr6c6UmFjSVLmRhx1CAf/lkBoDkAuGupk2H5E4quI tQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gjnyejdpa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Jun 2022 08:04:40 +0000
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2586S7H6013236;
        Wed, 8 Jun 2022 08:04:38 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gjnyejdmf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Jun 2022 08:04:38 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2587a5OG017679;
        Wed, 8 Jun 2022 08:04:35 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3gfy19cue7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Jun 2022 08:04:34 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25884WRj16515396
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Jun 2022 08:04:32 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8273C5204F;
        Wed,  8 Jun 2022 08:04:32 +0000 (GMT)
Received: from [9.43.53.124] (unknown [9.43.53.124])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id A490E5204E;
        Wed,  8 Jun 2022 08:04:27 +0000 (GMT)
Message-ID: <52b0bb03-a6f6-b68e-49a6-e6d37fe4eaa2@linux.ibm.com>
Date:   Wed, 8 Jun 2022 13:34:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v5 1/9] mm/demotion: Add support for explicit memory tiers
Content-Language: en-US
To:     Ying Huang <ying.huang@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, linux-mm@kvack.org,
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
 <20220603134237.131362-2-aneesh.kumar@linux.ibm.com>
 <92649c9a6e0b6931b34aeaaf22c0a1e874484b7f.camel@linux.intel.com>
 <f5480a57-4335-d982-8462-d4465369082d@linux.ibm.com>
 <71a0734bc918b7a6cf75b0b411b7b6a87f0bda92.camel@intel.com>
From:   Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
In-Reply-To: <71a0734bc918b7a6cf75b0b411b7b6a87f0bda92.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NFeuMQN_JsKr2J3mVmjNAEo31Rajt9tS
X-Proofpoint-ORIG-GUID: Qqr03HE60P0T-PywrolsftA5Kh_B3bd3
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

On 6/8/22 11:40 AM, Ying Huang wrote:
> On Wed, 2022-06-08 at 10:07 +0530, Aneesh Kumar K V wrote:
>> On 6/8/22 12:13 AM, Tim Chen wrote:
>> ...
>>
>>>>
>>>> +
>>>> +static void memory_tier_device_release(struct device *dev)
>>>> +{
>>>> +	struct memory_tier *tier = to_memory_tier(dev);
>>>> +
>>>
>>> Do we need some ref counts on memory_tier?
>>> If there is another device still using the same memtier,
>>> free below could cause problem.
>>>
>>>> +	kfree(tier);
>>>> +}
>>>> +
>>>>
>>> ...
>>
>> The lifecycle of the memory_tier struct is tied to the sysfs device life
>> time. ie, memory_tier_device_relese get called only after the last
>> reference on that sysfs dev object is released. Hence we can be sure
>> there is no userspace that is keeping one of the memtier related sysfs
>> file open.
>>
>> W.r.t other memory device sharing the same memtier, we unregister the
>> sysfs device only when the memory tier nodelist is empty. That is no
>> memory device is present in this memory tier.
> 
> memory_tier isn't only used by user space.  It is used inside kernel
> too.  If some kernel code get a pointer to struct memory_tier, we need
> to guarantee the pointer will not be freed under us. 

As mentioned above current patchset avoid doing that.

> And as Tim pointed
> out, we need to use it in hot path (for statistics), so some kind of rcu
> lock may be good.
> 

Sure when those statistics code get added, we can add the relevant kref 
and locking details.

-aneesh


