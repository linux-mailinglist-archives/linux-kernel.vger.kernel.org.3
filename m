Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8497554B54
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 15:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357142AbiFVN3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 09:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357846AbiFVN2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 09:28:35 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B497463FE
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 06:28:03 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 83B1113D5;
        Wed, 22 Jun 2022 06:28:03 -0700 (PDT)
Received: from [10.57.85.1] (unknown [10.57.85.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 398063F534;
        Wed, 22 Jun 2022 06:28:01 -0700 (PDT)
Message-ID: <a0f0d3da-6992-7033-5262-156ffa5316e7@arm.com>
Date:   Wed, 22 Jun 2022 14:27:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] iommu/dma: Fix race condition during iova_domain
 initialization
Content-Language: en-GB
To:     Joerg Roedel <joro@8bytes.org>, yf.wang@mediatek.com
Cc:     Miles Chen <miles.chen@mediatek.com>, wsd_upstream@mediatek.com,
        open list <linux-kernel@vger.kernel.org>,
        Libo Kang <Libo.Kang@mediatek.com>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Ning Li <ning.li@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Will Deacon <will@kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>
References: <20220530120748.31733-1-yf.wang@mediatek.com>
 <YrMPG4dIEnFkCbi9@8bytes.org>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <YrMPG4dIEnFkCbi9@8bytes.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-06-22 13:46, Joerg Roedel wrote:
> Please re-send with
> 
> 	Robin Murphy <robin.murphy@arm.com>
> 
> in Cc.

Apologies, I did spot this before, I've just been tied up with other 
things and dropping everything non-critical on the floor, so didn't get 
round to replying before it slipped my mind again.

In summary, I hate it, but mostly because the whole situation of calling 
iommu_probe_device off the back of driver probe is fundamentally broken. 
I'm still a few steps away from fixing that properly, at which point I 
can just as well rip all these little bodges out again. If it really 
does need mitigating in the meantime (i.e. this is real-world async 
probe, not just some contrived testcase), then I can't easily think of 
any cleaner hack, so,

Acked-by: Robin Murphy <robin.murphy@arm.com>

(somewhat reluctantly)

Cheers,
Robin.

> On Mon, May 30, 2022 at 08:07:45PM +0800, yf.wang@mediatek.com wrote:
>> From: Yunfei Wang <yf.wang@mediatek.com>
>>
>> When many devices share the same iova domain, iommu_dma_init_domain()
>> may be called at the same time. The checking of iovad->start_pfn will
>> all get false in iommu_dma_init_domain() and both enter init_iova_domain()
>> to do iovad initialization.
>>
>> Fix this by protecting init_iova_domain() with iommu_dma_cookie->mutex.
>>
>> Exception backtrace:
>> rb_insert_color(param1=0xFFFFFF80CD2BDB40, param3=1) + 64
>> init_iova_domain() + 180
>> iommu_setup_dma_ops() + 260
>> arch_setup_dma_ops() + 132
>> of_dma_configure_id() + 468
>> platform_dma_configure() + 32
>> really_probe() + 1168
>> driver_probe_device() + 268
>> __device_attach_driver() + 524
>> __device_attach() + 524
>> bus_probe_device() + 64
>> deferred_probe_work_func() + 260
>> process_one_work() + 580
>> worker_thread() + 1076
>> kthread() + 332
>> ret_from_fork() + 16
>>
>> Signed-off-by: Ning Li <ning.li@mediatek.com>
>> Signed-off-by: Yunfei Wang <yf.wang@mediatek.com>
>> ---
>>   drivers/iommu/dma-iommu.c | 17 +++++++++++++----
>>   1 file changed, 13 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>> index 09f6e1c0f9c0..b38c5041eeab 100644
>> --- a/drivers/iommu/dma-iommu.c
>> +++ b/drivers/iommu/dma-iommu.c
>> @@ -63,6 +63,7 @@ struct iommu_dma_cookie {
>>   
>>   	/* Domain for flush queue callback; NULL if flush queue not in use */
>>   	struct iommu_domain		*fq_domain;
>> +	struct mutex			mutex;
>>   };
>>   
>>   static DEFINE_STATIC_KEY_FALSE(iommu_deferred_attach_enabled);
>> @@ -309,6 +310,7 @@ int iommu_get_dma_cookie(struct iommu_domain *domain)
>>   	if (!domain->iova_cookie)
>>   		return -ENOMEM;
>>   
>> +	mutex_init(&domain->iova_cookie->mutex);
>>   	return 0;
>>   }
>>   
>> @@ -549,26 +551,33 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
>>   	}
>>   
>>   	/* start_pfn is always nonzero for an already-initialised domain */
>> +	mutex_lock(&cookie->mutex);
>>   	if (iovad->start_pfn) {
>>   		if (1UL << order != iovad->granule ||
>>   		    base_pfn != iovad->start_pfn) {
>>   			pr_warn("Incompatible range for DMA domain\n");
>> -			return -EFAULT;
>> +			ret = -EFAULT;
>> +			goto done_unlock;
>>   		}
>>   
>> -		return 0;
>> +		ret = 0;
>> +		goto done_unlock;
>>   	}
>>   
>>   	init_iova_domain(iovad, 1UL << order, base_pfn);
>>   	ret = iova_domain_init_rcaches(iovad);
>>   	if (ret)
>> -		return ret;
>> +		goto done_unlock;
>>   
>>   	/* If the FQ fails we can simply fall back to strict mode */
>>   	if (domain->type == IOMMU_DOMAIN_DMA_FQ && iommu_dma_init_fq(domain))
>>   		domain->type = IOMMU_DOMAIN_DMA;
>>   
>> -	return iova_reserve_iommu_regions(dev, domain);
>> +	ret = iova_reserve_iommu_regions(dev, domain);
>> +
>> +done_unlock:
>> +	mutex_unlock(&cookie->mutex);
>> +	return ret;
>>   }
>>   
>>   /**
>> -- 
>> 2.18.0
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
