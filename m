Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90CD3484549
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 16:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235042AbiADPx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 10:53:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234968AbiADPx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 10:53:28 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57EEC061784;
        Tue,  4 Jan 2022 07:53:27 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 220F51F434D9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641311606;
        bh=8YQxFbvnIvsl0bXf11gulFrkxkDU8PWus97Bhbnjwoc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=j/EV3NtSordrsTUj8H8TAxeAccfm0+fuX5BE6C5pnJw5aHba8HJThhaX3MUdwwZUM
         tGRsxyt2yOWiO9Zeqg0gVLU7vZ1IcO83FDPT2J9/sXrQ8NlfuL+6QYAhVtEKWeoChI
         CtIlAJQ8ZUZHiF0sGbhY5AuGs7hUYi5leuxd/a/PpYWMZaC1L53BfXB8vY4jlwzNUn
         DQnt+uCZoIPykQXAC/cPwZHnoALbQuCfZOLnIjYAGhN+6HKBwn0Hv+jWNzlIplM0rU
         CYld++ZTVbHnAk1jszWUuxpCObT9jBwP+h6xOGebqJxSIUP+GLZYTpLPXCWtl2v849
         U8nDWu23ObTKw==
Subject: Re: [PATCH v3 28/33] iommu/mediatek: Add bank_nr and bank_enable
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
 <20210923115840.17813-29-yong.wu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <48493504-8877-b78d-0476-118a8b1441e0@collabora.com>
Date:   Tue, 4 Jan 2022 16:53:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210923115840.17813-29-yong.wu@mediatek.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 23/09/21 13:58, Yong Wu ha scritto:
> Prepare for supporting multi banks, Adds two variables in the plat_data:
> bank_nr: the bank number that this SoC support;
> bank_enable: list if the banks is enabled.
> 
> Add them for all the current SoC, bank_nr always is 1 and only
> bank_enable[0] is enabled.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>   drivers/iommu/mtk_iommu.c | 18 ++++++++++++++++++
>   drivers/iommu/mtk_iommu.h |  3 +++
>   2 files changed, 21 insertions(+)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index c139675d99e6..4ad85469f68f 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -1134,6 +1134,8 @@ static const struct mtk_iommu_plat_data mt2712_data = {
>   			NOT_STD_AXI_MODE | MTK_IOMMU_TYPE_MM,
>   	.hw_list      = &m4ulist,
>   	.inv_sel_reg  = REG_MMU_INV_SEL_GEN1,
> +	.bank_nr      = 1,
> +	.bank_enable  = {true},
>   	.iova_region  = single_domain,
>   	.iova_region_nr = ARRAY_SIZE(single_domain),
>   	.larbid_remap = {{0}, {1}, {2}, {3}, {4}, {5}, {6}, {7}},
> @@ -1144,6 +1146,8 @@ static const struct mtk_iommu_plat_data mt6779_data = {
>   	.flags         = HAS_SUB_COMM_2BITS | OUT_ORDER_WR_EN | WR_THROT_EN |
>   			 NOT_STD_AXI_MODE | MTK_IOMMU_TYPE_MM,
>   	.inv_sel_reg   = REG_MMU_INV_SEL_GEN2,
> +	.bank_nr       = 1,
> +	.bank_enable   = {true},
>   	.iova_region   = single_domain,
>   	.iova_region_nr = ARRAY_SIZE(single_domain),
>   	.larbid_remap  = {{0}, {1}, {2}, {3}, {5}, {7, 8}, {10}, {9}},
> @@ -1154,6 +1158,8 @@ static const struct mtk_iommu_plat_data mt8167_data = {
>   	.flags        = RESET_AXI | HAS_LEGACY_IVRP_PADDR | NOT_STD_AXI_MODE |
>   			MTK_IOMMU_TYPE_MM,
>   	.inv_sel_reg  = REG_MMU_INV_SEL_GEN1,
> +	.bank_nr      = 1,
> +	.bank_enable  = {true},
>   	.iova_region  = single_domain,
>   	.iova_region_nr = ARRAY_SIZE(single_domain),
>   	.larbid_remap = {{0}, {1}, {2}}, /* Linear mapping. */
> @@ -1165,6 +1171,8 @@ static const struct mtk_iommu_plat_data mt8173_data = {
>   			HAS_LEGACY_IVRP_PADDR | NOT_STD_AXI_MODE |
>   			MTK_IOMMU_TYPE_MM,
>   	.inv_sel_reg  = REG_MMU_INV_SEL_GEN1,
> +	.bank_nr      = 1,
> +	.bank_enable  = {true},
>   	.iova_region  = single_domain,
>   	.iova_region_nr = ARRAY_SIZE(single_domain),
>   	.larbid_remap = {{0}, {1}, {2}, {3}, {4}, {5}}, /* Linear mapping. */
> @@ -1174,6 +1182,8 @@ static const struct mtk_iommu_plat_data mt8183_data = {
>   	.m4u_plat     = M4U_MT8183,
>   	.flags        = RESET_AXI | MTK_IOMMU_TYPE_MM,
>   	.inv_sel_reg  = REG_MMU_INV_SEL_GEN1,
> +	.bank_nr      = 1,
> +	.bank_enable  = {true},
>   	.iova_region  = single_domain,
>   	.iova_region_nr = ARRAY_SIZE(single_domain),
>   	.larbid_remap = {{0}, {4}, {5}, {6}, {7}, {2}, {3}, {1}},
> @@ -1185,6 +1195,8 @@ static const struct mtk_iommu_plat_data mt8192_data = {
>   			  WR_THROT_EN | IOVA_34_EN | NOT_STD_AXI_MODE |
>   			  MTK_IOMMU_TYPE_MM,
>   	.inv_sel_reg    = REG_MMU_INV_SEL_GEN2,
> +	.bank_nr        = 1,
> +	.bank_enable    = {true},
>   	.iova_region    = mt8192_multi_dom,
>   	.iova_region_nr = ARRAY_SIZE(mt8192_multi_dom),
>   	.larbid_remap   = {{0}, {1}, {4, 5}, {7}, {2}, {9, 11, 19, 20},
> @@ -1196,6 +1208,8 @@ static const struct mtk_iommu_plat_data mt8195_data_infra = {
>   	.flags            = WR_THROT_EN | DCM_DISABLE |
>   			    MTK_IOMMU_TYPE_INFRA | IFA_IOMMU_PCIe_SUPPORT,
>   	.pericfg_comp_str = "mediatek,mt8195-pericfg_ao",
> +	.bank_nr	  = 1,
> +	.bank_enable      = {true},
>   	.inv_sel_reg      = REG_MMU_INV_SEL_GEN2,
>   	.iova_region      = single_domain,
>   	.iova_region_nr   = ARRAY_SIZE(single_domain),
> @@ -1208,6 +1222,8 @@ static const struct mtk_iommu_plat_data mt8195_data_vdo = {
>   			  SHARE_PGTABLE | MTK_IOMMU_TYPE_MM,
>   	.hw_list        = &m4ulist,
>   	.inv_sel_reg    = REG_MMU_INV_SEL_GEN2,
> +	.bank_nr	= 1,
> +	.bank_enable    = {true},
>   	.iova_region	= mt8192_multi_dom,
>   	.iova_region_nr	= ARRAY_SIZE(mt8192_multi_dom),
>   	.larbid_remap   = {{2, 0}, {21}, {24}, {7}, {19}, {9, 10, 11},
> @@ -1221,6 +1237,8 @@ static const struct mtk_iommu_plat_data mt8195_data_vpp = {
>   			  SHARE_PGTABLE | MTK_IOMMU_TYPE_MM,
>   	.hw_list        = &m4ulist,
>   	.inv_sel_reg    = REG_MMU_INV_SEL_GEN2,
> +	.bank_nr	= 1,
> +	.bank_enable    = {true},
>   	.iova_region	= mt8192_multi_dom,
>   	.iova_region_nr	= ARRAY_SIZE(mt8192_multi_dom),
>   	.larbid_remap   = {{1}, {3}, {22, 0, 0, 0, 23}, {8},
> diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
> index 881fade8d39a..dc0190edebf0 100644
> --- a/drivers/iommu/mtk_iommu.h
> +++ b/drivers/iommu/mtk_iommu.h
> @@ -62,6 +62,9 @@ struct mtk_iommu_plat_data {
>   	struct list_head			*hw_list;
>   	unsigned int				iova_region_nr;
>   	const struct mtk_iommu_iova_region	*iova_region;
> +
> +	unsigned int        bank_nr;

As said in the review for patch 26/33, maybe this can be renamed as `num_banks`
instead... and also, this can be a `u8` to save some memory.

> +	bool                bank_enable[MTK_IOMMU_BANK_MAX];
>   	unsigned char       larbid_remap[MTK_LARB_COM_MAX][MTK_LARB_SUBCOM_MAX];
>   };
>   
> 

