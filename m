Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E970256863A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 12:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233204AbiGFKyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 06:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233245AbiGFKyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 06:54:43 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 61AE027CEB
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 03:54:39 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 68C5E1042;
        Wed,  6 Jul 2022 03:54:39 -0700 (PDT)
Received: from [10.57.86.2] (unknown [10.57.86.2])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CD69B3F66F;
        Wed,  6 Jul 2022 03:54:36 -0700 (PDT)
Message-ID: <8915e679-71b2-eef4-88d5-127bcc6cf990@arm.com>
Date:   Wed, 6 Jul 2022 11:54:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 09/14] iommu/ipmmu-vmsa: Clean up bus_set_iommu()
Content-Language: en-GB
To:     Alexey Kardashevskiy <aik@ozlabs.ru>, joro@8bytes.org,
        will@kernel.org
Cc:     jean-philippe@linaro.org, zhang.lyra@gmail.com,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        thierry.reding@gmail.com, gerald.schaefer@linux.ibm.com,
        linux-arm-kernel@lists.infradead.org
References: <cover.1650890638.git.robin.murphy@arm.com>
 <01a58dcc9c70836b7556d54dbdac6a340f206781.1650890638.git.robin.murphy@arm.com>
 <aef1d470-e8a0-4ba8-2a55-adf05b836684@ozlabs.ru>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <aef1d470-e8a0-4ba8-2a55-adf05b836684@ozlabs.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-07-06 09:38, Alexey Kardashevskiy wrote:
> 
> 
> On 28/04/2022 23:18, Robin Murphy wrote:
>> Stop calling bus_set_iommu() since it's now unnecessary. This also
>> leaves the custom initcall effectively doing nothing but register
>> the driver, which no longer needs to happen early either, so convert
>> it to builtin_platform_driver().
>>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>   drivers/iommu/ipmmu-vmsa.c | 35 +----------------------------------
>>   1 file changed, 1 insertion(+), 34 deletions(-)
>>
>> diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
>> index 8fdb84b3642b..2549d32f0ddd 100644
>> --- a/drivers/iommu/ipmmu-vmsa.c
>> +++ b/drivers/iommu/ipmmu-vmsa.c
>> @@ -1090,11 +1090,6 @@ static int ipmmu_probe(struct platform_device 
>> *pdev)
>>           ret = iommu_device_register(&mmu->iommu, &ipmmu_ops, 
>> &pdev->dev);
>>           if (ret)
>>               return ret;
>> -
>> -#if defined(CONFIG_IOMMU_DMA)
>> -        if (!iommu_present(&platform_bus_type))
>> -            bus_set_iommu(&platform_bus_type, &ipmmu_ops);
>> -#endif
>>       }
>>       /*
> 
> The comment which starts here did not make it to the patch but it should 
> have as it mentions bus_set_iommu() which is gone by the end of the series.

Heh, busted! In fact I think the whole point of that comment stops being 
true, but I couldn't be bothered to reason about it since one of the 
next steps after this is to start ripping all the arm_iommu_* stuff out 
anyway.

> More general question/request - could you please include the exact sha1 
> the patchset is based on? It did not apply to any current trees and 
> while it was trivial, it was slightly annoying to resolve the conflicts 
> :)  Thanks,

v3 is based directly on 5.19-rc3:

https://lore.kernel.org/lkml/cover.1657034827.git.robin.murphy@arm.com/

And if it helps I have it on a branch here as well:

https://gitlab.arm.com/linux-arm/linux-rm/-/tree/bus-set-iommu-v3

Robin.
