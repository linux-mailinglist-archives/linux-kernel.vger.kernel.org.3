Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64A67484599
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 16:56:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbiADPzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 10:55:41 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33410 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235183AbiADPzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 10:55:22 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 807461F43593
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641311721;
        bh=V052X6CDRqGtUFJ9/x/emU0xn91Fbjw/PEV/sXPRzeQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=DONGLC2hY7afAnjU2pD69F6yoQtckqgDyfVXGrV9S7yr4nBspBHhjw+C5Y7ZfSRD6
         pcy60TFAq9Gjd8ObWJUnIkyC3zKY8Ef47nQx9V7caoOiCp3L4HPd+VWVS7wttJrZI5
         xyhlyiQ8aOFEk4edgoHX+3zuRvz98P58oOa2Sq8up9fu5YN5qUyYbnJ2e1bk03QfBS
         yepEvPax+fe1PvQDBmdlvyGBxehQxCOn+OufgkQuwWjPMUSn1XC31TN1wAIsYqS2oD
         D/fSKoZsUKhuSPi86VkYTS7fq80pyNf1t3DYDePF8KHSV7Kk6FRneoroyM9WRpbcNu
         yL3AUJ3Z3bKpA==
Subject: Re: [PATCH v3 09/33] iommu/mediatek: Remove for_each_m4u in
 tlb_sync_all
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
 <20210923115840.17813-10-yong.wu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <bfa33e94-c2e5-5dab-c9af-b674e1669daa@collabora.com>
Date:   Tue, 4 Jan 2022 16:55:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210923115840.17813-10-yong.wu@mediatek.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 23/09/21 13:58, Yong Wu ha scritto:
> The tlb_sync_all is called from these three functions:
> a) flush_iotlb_all: it will be called for each a iommu HW.
> b) tlb_flush_range_sync: it already has for_each_m4u.
> c) in irq: When IOMMU HW translation fault, Only need flush itself.
> 
> Thus, No need for_each_m4u in this tlb_sync_all. Remove it.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>   drivers/iommu/mtk_iommu.c | 18 +++++++-----------
>   1 file changed, 7 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 6f4f6624e3ac..0b4c30baa864 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -206,19 +206,15 @@ static struct mtk_iommu_domain *to_mtk_domain(struct iommu_domain *dom)
>   
>   static void mtk_iommu_tlb_flush_all(struct mtk_iommu_data *data)
>   {
> -	struct list_head *head = data->hw_list;
> -
> -	for_each_m4u(data, head) {
> -		if (pm_runtime_get_if_in_use(data->dev) <= 0)
> -			continue;
> +	if (pm_runtime_get_if_in_use(data->dev) <= 0)
> +		return;
>   
> -		writel_relaxed(F_INVLD_EN1 | F_INVLD_EN0,
> -			       data->base + data->plat_data->inv_sel_reg);
> -		writel_relaxed(F_ALL_INVLD, data->base + REG_MMU_INVALIDATE);
> -		wmb(); /* Make sure the tlb flush all done */
> +	writel_relaxed(F_INVLD_EN1 | F_INVLD_EN0,
> +		       data->base + data->plat_data->inv_sel_reg);
> +	writel_relaxed(F_ALL_INVLD, data->base + REG_MMU_INVALIDATE);
> +	wmb(); /* Make sure the tlb flush all done */

There aren't a lot of writes here - not anymore, since you are no longer doing
this for_each_m4u()...
...so, please change writel_relaxed() to writel() calls, allowing you to also
remove the write barrier at the end (since in the non relaxed version, order
is already ensured).

>   
> -		pm_runtime_put(data->dev);
> -	}
> +	pm_runtime_put(data->dev);
>   }
>   
>   static void mtk_iommu_tlb_flush_range_sync(unsigned long iova, size_t size,
> 
