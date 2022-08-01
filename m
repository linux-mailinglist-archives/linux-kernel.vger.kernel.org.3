Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2F65871B0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 21:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235071AbiHATss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 15:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235052AbiHATsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 15:48:43 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 54B182F64E
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 12:48:40 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D5D2139F;
        Mon,  1 Aug 2022 12:48:40 -0700 (PDT)
Received: from [10.57.10.23] (unknown [10.57.10.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C76103F67D;
        Mon,  1 Aug 2022 12:48:38 -0700 (PDT)
Message-ID: <da4a7491-36c6-346e-a22b-9554070ab674@arm.com>
Date:   Mon, 1 Aug 2022 20:48:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH -next] iommu/dma: Fix missing mutex_init() in
 iommu_get_msi_cookie()
Content-Language: en-GB
To:     Yang Yingliang <yangyingliang@huawei.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        iommu@lists.linux-foundation.org, will@kernel.org,
        yf.wang@mediatek.com
References: <20220627085533.1469141-1-yangyingliang@huawei.com>
 <YtEcB6717b3d5suQ@8bytes.org> <5d056fea-ee52-b7f8-a8c1-095f695ac805@arm.com>
 <a3fd3fef-f5fc-d89c-99de-4e7870cc9974@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <a3fd3fef-f5fc-d89c-99de-4e7870cc9974@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-07-18 07:42, Yang Yingliang wrote:
> Hi,
> 
> On 2022/7/15 17:28, Robin Murphy wrote:
>> On 2022-07-15 08:49, Joerg Roedel wrote:
>>> Adding Robin.
>>>
>>> On Mon, Jun 27, 2022 at 04:55:33PM +0800, Yang Yingliang wrote:
>>>> cookie_alloc() is called by iommu_get_dma_cookie() and 
>>>> iommu_get_msi_cookie(),
>>>> but the mutex is only initialized in iommu_get_dma_cookie(), move 
>>>> mutex_init()
>>>> into cookie_alloc() to make sure the mutex will be initialized.
>>
>> The mutex is only used in iommu_dma_init_domain(), which is only 
>> called by iommu_setup_dma_ops() for IOMMU_DOMAIN_DMA domains. How is 
>> there a problem here?
> It's no problem now, but I thinks it's better to initialize the 'mutex' 
> in cookie_alloc() to make code stronger.

Stronger against what, though? The sole reason this mutex exists at all 
is as a temporary measure to protect the IOVA domain from concurrent 
initialisation - I suppose in hindsight it might have made sense to 
define it inside the union, but I don't see much point in churning that 
now. I'd rather spend the time on continuing to get the 
iommu_probe_device() path sorted out so that we don't have the whole 
problematic driver-probe-time-replay mess in the first place and this 
mutex can be reverted ASAP.

>>>> Fixes: ac9a5d522bb8 ("iommu/dma: Fix race condition during 
>>>> iova_domain initialization")
>>>> Reported-by: Hulk Robot <hulkci@huawei.com>

Please teach your robot to care about things that actually matter. All 
it's "reporting" here is that it isn't clever enough to follow control 
flow across multiple compilation units, otherwise it should have seen 
the matching iommu_is_dma_domain() checks between __iommu_domain_alloc() 
and iommu_setup_dma_ops(). Having to explain this is not a good use of 
the kernel community's time and effort.

Thanks,
Robin.

>>>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
>>>> ---
>>>>   drivers/iommu/dma-iommu.c | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>>>> index 1910f4f1612b..e29157380c48 100644
>>>> --- a/drivers/iommu/dma-iommu.c
>>>> +++ b/drivers/iommu/dma-iommu.c
>>>> @@ -294,6 +294,7 @@ static struct iommu_dma_cookie 
>>>> *cookie_alloc(enum iommu_dma_cookie_type type)
>>>>       if (cookie) {
>>>>           INIT_LIST_HEAD(&cookie->msi_page_list);
>>>>           cookie->type = type;
>>>> +        mutex_init(&cookie->mutex);
>>>>       }
>>>>       return cookie;
>>>>   }
>>>> @@ -311,7 +312,6 @@ int iommu_get_dma_cookie(struct iommu_domain 
>>>> *domain)
>>>>       if (!domain->iova_cookie)
>>>>           return -ENOMEM;
>>>>   -    mutex_init(&domain->iova_cookie->mutex);
>>>>       return 0;
>>>>   }
>>>>   --
>>>> 2.25.1
>> .
