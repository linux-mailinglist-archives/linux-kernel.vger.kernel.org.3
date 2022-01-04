Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E11C448458A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 16:55:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235332AbiADPzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 10:55:22 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33370 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232465AbiADPzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 10:55:11 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 0AD2E1F43593
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641311709;
        bh=3smna2rui85hd0ub3WLoyVobn8DHHP5eQqp8Q9TuRHo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=fqocVfDSEzNSK52a1s2yP91kT0QXrE28aLrYgLgVVnizYZzYBoHRC2lC+TVQDCOIe
         Kz/qm0Giepgg9FQ/4K4GvgpSGVaLLfvKI5HIzdcKxPm3F55DCVGI9LMwRTNfZd8UK+
         NvEMzUrqVmUOQq/DAbZWexY6h8ORgfusoKnRryDXpwAbyPmx9eRnZrTFORJNXtWkWY
         K+XxN6vU06x1aNKWnUfWN89rFgo1OHflAJW+9/wEVjJMzmYCvMepROSGRUKb2PpMkF
         QJfGCz3JyVqNMEiGDtSb+/rFXoMK2sD+jhT5m+lrC3iHDjA7319nckiAz8zh7T0wKR
         TM5MCOR2+FQBw==
Subject: Re: [PATCH v3 13/33] iommu/mediatek: Remove the power status checking
 in tlb flush all
To:     Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Tomasz Figa <tfiga@chromium.org>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org,
        Hsin-Yi Wang <hsinyi@chromium.org>, youlin.pei@mediatek.com,
        anan.sun@mediatek.com, chao.hao@mediatek.com,
        yen-chang.chen@mediatek.com
References: <20210923115840.17813-1-yong.wu@mediatek.com>
 <20210923115840.17813-14-yong.wu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <1cb7458d-a012-2e84-82bd-7e4f30ed9162@collabora.com>
Date:   Tue, 4 Jan 2022 16:55:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210923115840.17813-14-yong.wu@mediatek.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 23/09/21 13:58, Yong Wu ha scritto:
> To simplify the code, Remove the power status checking in the
> tlb_flush_all, remove this:
>     if (pm_runtime_get_if_in_use(data->dev) <= 0)
> 	    continue;
> 
> After this patch, the mtk_iommu_tlb_flush_all will be called from
> a) isr
> b) pm runtime resume callback
> c) tlb flush range fail case
> d) iommu_create_device_direct_mappings
>     -> iommu_flush_iotlb_all
> In first three cases, the power and clock always are enabled; d) is direct
> mapping, the tlb flush is unnecessay since we already have tlb_flush_all
> in the pm_runtime_resume callback. When the iommu's power status is
> changed to active, the tlb always is clean.
> 
> In addition, there still are 2 reasons that don't add PM status checking
> in the tlb flush all:
> a) Write tlb flush all register also is ok even though the HW has no
> power and clocks. Write ignore.

Do you mean that the register write seemingly succeeds but the hardware
discards it?
Please, reword the `a` sentence to be clearer.

> b) pm_runtime_get_if_in_use(m4udev) is 0 when the tlb_flush_all
> is called frm pm_runtime_resume cb. From this point, we can not add
> this code above in this tlb_flush_all.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>   drivers/iommu/mtk_iommu.c | 20 +++++++-------------
>   1 file changed, 7 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index e9e94944ed91..4a33b6c6b1db 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -204,10 +204,14 @@ static struct mtk_iommu_domain *to_mtk_domain(struct iommu_domain *dom)
>   	return container_of(dom, struct mtk_iommu_domain, domain);
>   }
>   
> -static void mtk_iommu_tlb_do_flush_all(struct mtk_iommu_data *data)
> +static void mtk_iommu_tlb_flush_all(struct mtk_iommu_data *data)
>   {
>   	unsigned long flags;
>   
> +	/*
> +	 * No need get power status since the HW PM status nearly is active
> +	 * when entering here.

Please reword this comment to explain the entire situation.

> +	 */
>   	spin_lock_irqsave(&data->tlb_lock, flags);
>   	writel_relaxed(F_INVLD_EN1 | F_INVLD_EN0,
>   		       data->base + data->plat_data->inv_sel_reg);
> @@ -216,16 +220,6 @@ static void mtk_iommu_tlb_do_flush_all(struct mtk_iommu_data *data)
>   	spin_unlock_irqrestore(&data->tlb_lock, flags);
>   }
>   
> -static void mtk_iommu_tlb_flush_all(struct mtk_iommu_data *data)
> -{
> -	if (pm_runtime_get_if_in_use(data->dev) <= 0)
> -		return;
> -
> -	mtk_iommu_tlb_do_flush_all(data);
> -
> -	pm_runtime_put(data->dev);
> -}
> -
>   static void mtk_iommu_tlb_flush_range_sync(unsigned long iova, size_t size,
>   					   struct mtk_iommu_data *data)
>   {
> @@ -263,7 +257,7 @@ static void mtk_iommu_tlb_flush_range_sync(unsigned long iova, size_t size,
>   		if (ret) {
>   			dev_warn(data->dev,
>   				 "Partial TLB flush timed out, falling back to full flush\n");
> -			mtk_iommu_tlb_do_flush_all(data);
> +			mtk_iommu_tlb_flush_all(data);
>   		}
>   
>   		if (has_pm)
> @@ -993,7 +987,7 @@ static int __maybe_unused mtk_iommu_runtime_resume(struct device *dev)
>   	 *
>   	 * Thus, Make sure the tlb always is clean after each PM resume.
>   	 */
> -	mtk_iommu_tlb_do_flush_all(data);
> +	mtk_iommu_tlb_flush_all(data);
>   
>   	/*
>   	 * Uppon first resume, only enable the clk and return, since the values of the
> 

