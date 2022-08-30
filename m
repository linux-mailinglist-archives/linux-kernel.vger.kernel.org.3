Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCF0F5A6435
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 14:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbiH3M6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 08:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiH3M6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 08:58:05 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A73524BD4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 05:58:01 -0700 (PDT)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MH6gM4yVTzYcpg;
        Tue, 30 Aug 2022 20:53:35 +0800 (CST)
Received: from [10.174.178.41] (10.174.178.41) by
 dggpeml500024.china.huawei.com (7.185.36.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 30 Aug 2022 20:57:58 +0800
Message-ID: <2501c884-7c78-d367-3463-5b86d302da89@huawei.com>
Date:   Tue, 30 Aug 2022 20:57:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] iommu: use iommu_group_ref_get to hold group reference
To:     Robin Murphy <robin.murphy@arm.com>, <joro@8bytes.org>,
        <will@kernel.org>, <iommu@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <baolu.lu@linux.intel.com>,
        <haifeng.zhao@linux.intel.com>
References: <20220826024024.101553-1-yuancan@huawei.com>
 <5f47c5b7-534d-5714-1f91-04005ada8b8f@arm.com>
From:   Yuan Can <yuancan@huawei.com>
In-Reply-To: <5f47c5b7-534d-5714-1f91-04005ada8b8f@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.41]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500024.china.huawei.com (7.185.36.10)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/8/30 17:32, Robin Murphy 写道:
> On 2022-08-26 03:40, Yuan Can wrote:
>> Replace kobject_get with iommu_group_ref_get for better
>> readability.
>
> I disagree, sorry. iommu_group_ref_get() is meant as a helper for 
> drivers, and the core code uses the raw kobject internally everywhere 
> else, including several other times within this function. Especially 
> the raw kobject_put() in the cleanup path - in terms of readability 
> I'd say it's actively harmful to obfuscate what that pairs with.
>
> Thanks,
> Robin.

Understood, thanks for your reply.

Best regards,

Yuan Can

>
>> Signed-off-by: Yuan Can <yuancan@huawei.com>
>> ---
>>   drivers/iommu/iommu.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index 780fb7071577..8e7f30f7188c 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -903,7 +903,7 @@ int iommu_group_add_device(struct iommu_group 
>> *group, struct device *dev)
>>           goto err_free_name;
>>       }
>>   -    kobject_get(group->devices_kobj);
>> +    iommu_group_ref_get(group);
>>         dev->iommu_group = group;
>
