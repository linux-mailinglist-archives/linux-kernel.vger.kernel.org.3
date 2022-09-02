Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 327025AAAC9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 11:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235333AbiIBJA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 05:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232755AbiIBJAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 05:00:52 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A193AB15;
        Fri,  2 Sep 2022 02:00:50 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BB0196601F04;
        Fri,  2 Sep 2022 10:00:48 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1662109249;
        bh=7sU033mGQqMgLZYu1qj1vLeGlrTQhMdIgyO5Z9XmQvc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=btPA8d5oKPh+N3MfwdysLrom3fdzX4u65X9qfnk3UySmC4Rr6X36Ear26Wj7FapZi
         6u4cDtF0aNsgZWz6UU74e71kArJilGw1D4Tw4M8yPX6bDbQgU12EUjYA8Cl3oHgLCJ
         xF9xlD6AJ4y7aEX8OjRESLxjvhlAaVO4kC0XgW4cCVXb10lTkwJrgPTH2KosJMrzJA
         LwDKRV7AkWBwbvG/BD4JdtegLUe8Vy9K3eZ91qGsCBWOkPqbzsSPCFQsXHl2o0twv8
         3cjsb/g6tSFI2QYWhY6WRSByJm7lunT4Ix7ENhfLbGuWg5DIBTo8dli9LdQR7VOz3s
         W59oVfW64KNvg==
Message-ID: <8e398e71-1283-b5d7-2b17-958a25563c25@collabora.com>
Date:   Fri, 2 Sep 2022 11:00:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2 2/3] iommu/mediatek: Add enable IOMMU SMC command for
 INFRA master
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
 <20220831125502.7818-3-chengci.xu@mediatek.com>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220831125502.7818-3-chengci.xu@mediatek.com>
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
> The register which can enable IOMMU for INFRA master should be setted
> in secure world for security concerns. Therefore, we add a SMC command
> for INFRA master to enable/disable INFRA IOMMU in ATF. This function is
> prepared for MT8188.
> 
> Signed-off-by: Chengci.Xu <chengci.xu@mediatek.com>
> ---
>   drivers/iommu/mtk_iommu.c  | 34 ++++++++++++++++++++++++++--------
>   include/soc/mediatek/smi.h |  1 +
>   2 files changed, 27 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 7e363b1f24df..6fe780783ec8 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -3,6 +3,7 @@
>    * Copyright (c) 2015-2016 MediaTek Inc.
>    * Author: Yong Wu <yong.wu@mediatek.com>
>    */
> +#include <linux/arm-smccc.h>
>   #include <linux/bitfield.h>
>   #include <linux/bug.h>
>   #include <linux/clk.h>
> @@ -28,6 +29,7 @@
>   #include <linux/slab.h>
>   #include <linux/spinlock.h>
>   #include <linux/soc/mediatek/infracfg.h>
> +#include <linux/soc/mediatek/mtk_sip_svc.h>
>   #include <asm/barrier.h>
>   #include <soc/mediatek/smi.h>
>   
> @@ -138,6 +140,7 @@
>   #define PM_CLK_AO			BIT(15)
>   #define IFA_IOMMU_PCIE_SUPPORT		BIT(16)
>   #define PGTABLE_PA_35_EN		BIT(17)
> +#define CFG_IFA_MASTER_IN_ATF		BIT(18)
>   
>   #define MTK_IOMMU_HAS_FLAG_MASK(pdata, _x, mask)	\
>   				((((pdata)->flags) & (mask)) == (_x))
> @@ -554,14 +557,29 @@ static int mtk_iommu_config(struct mtk_iommu_data *data, struct device *dev,
>   			else
>   				larb_mmu->mmu &= ~MTK_SMI_MMU_EN(portid);
>   		} else if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_INFRA)) {
> -			peri_mmuen_msk = BIT(portid);
> -			/* PCI dev has only one output id, enable the next writing bit for PCIe */
> -			if (dev_is_pci(dev))
> -				peri_mmuen_msk |= BIT(portid + 1);
> -
> -			peri_mmuen = enable ? peri_mmuen_msk : 0;
> -			ret = regmap_update_bits(data->pericfg, PERICFG_IOMMU_1,
> -						 peri_mmuen_msk, peri_mmuen);
> +			if (MTK_IOMMU_HAS_FLAG(data->plat_data, CFG_IFA_MASTER_IN_ATF)) {
> +				struct arm_smccc_res res;
> +
> +				portid = MTK_M4U_TO_PORT(fwspec->ids[i]);

This assignment is redundant, as portid is initialized to the same value
just a few lines before. Please drop it.

Everything else looks good.

Regards,
Angelo

> +				arm_smccc_smc(MTK_SIP_KERNEL_IOMMU_CONTROL,
> +					      IOMMU_ATF_CMD_CONFIG_INFRA_IOMMU,
> +					      portid, enable, 0, 0, 0, 0, &res);
> +				ret = (int)res.a0;

