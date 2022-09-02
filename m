Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0FAD5AAADA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 11:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235469AbiIBJEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 05:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236071AbiIBJEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 05:04:52 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E693B38A7;
        Fri,  2 Sep 2022 02:04:48 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3A8486601F04;
        Fri,  2 Sep 2022 10:04:46 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1662109486;
        bh=yvwwoBkByqJ5cx4uVKskzHBO8ILIZF3f4Da7QWytnDE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=jR/695CKTH7D1U/VSzyMePn4k8uuuO9xvO0kF9h1XqacwzhDi8kU+Pdi/UWb0+ioJ
         WTXnrV968hQT4Gez+SlfnYYaiXFs1nF5BJHTNRUqgIHxax9HQuJEyu/wMfpERM/sCY
         v6EjEdz3cbjpgWM+hH0gCwi9qj/B2kTC71pEaQK8WggY7bQdvIaPFAF/P+ySg5Daqt
         BSmvjRUnTeZe1IeJfhFRsmp1eqGlSPBiNhAn1iWsGAeMP9rkVBcqmqbqEundF91Zft
         wt35NUet0b656hL6r2rqQdf1fBObKsNwCYLB7HNRdi/PE/AhH7NDNJtXj442upFOrd
         MjxKi4AFPAdPA==
Message-ID: <c6853021-e7ef-3078-9c9e-f0c6b56e566d@collabora.com>
Date:   Fri, 2 Sep 2022 11:04:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2 3/3] iommu/mediatek: Add MT8188 IOMMU Support
Content-Language: en-US
To:     "Chengci.Xu" <chengci.xu@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     iommu@lists.linux.dev, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220831125502.7818-1-chengci.xu@mediatek.com>
 <20220831125502.7818-4-chengci.xu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220831125502.7818-4-chengci.xu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 31/08/22 14:55, Chengci.Xu ha scritto:
> MT8188 has 3 IOMMU, containing 2 MM IOMMUs, one is for vdo, the other
> is for vpp. and 1 INFRA IOMMU.
> 
> Signed-off-by: Chengci.Xu <chengci.xu@mediatek.com>
> ---
>   drivers/iommu/mtk_iommu.c | 48 +++++++++++++++++++++++++++++++++++++++
>   1 file changed, 48 insertions(+)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 6fe780783ec8..98c2eae5229e 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -164,6 +164,7 @@ enum mtk_iommu_plat {
>   	M4U_MT8173,
>   	M4U_MT8183,
>   	M4U_MT8186,
> +	M4U_MT8188,
>   	M4U_MT8192,
>   	M4U_MT8195,
>   };
> @@ -1479,6 +1480,50 @@ static const struct mtk_iommu_plat_data mt8186_data_mm = {
>   	.iova_region_nr = ARRAY_SIZE(mt8192_multi_dom),
>   };
>   
> +static const struct mtk_iommu_plat_data mt8188_data_infra = {
> +	.m4u_plat	  = M4U_MT8188,
> +	.flags            = WR_THROT_EN | DCM_DISABLE | STD_AXI_MODE | PM_CLK_AO |
> +			    MTK_IOMMU_TYPE_INFRA | IFA_IOMMU_PCIE_SUPPORT |
> +			    CFG_IFA_MASTER_IN_ATF,
> +	.pericfg_comp_str = "mediatek,mt8188-pericfg_ao",

pericfg_comp_str is used only for IOMMU enable from Linux, but MT8188 enables it
with a SMC command, so this is unused.

Please drop it.

> +	.inv_sel_reg      = REG_MMU_INV_SEL_GEN2,
> +	.banks_num	  = 1,
> +	.banks_enable     = {true},
> +	.iova_region      = single_domain,
> +	.iova_region_nr   = ARRAY_SIZE(single_domain),
> +};
> +

Regards,
Angelo

