Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1E2534BAF
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 10:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238808AbiEZIW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 04:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236174AbiEZIWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 04:22:20 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC761ADAB;
        Thu, 26 May 2022 01:22:18 -0700 (PDT)
X-UUID: a0aacaf875ce4ec9a62ea1c1b15c4998-20220526
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:246c3ae8-4f9e-4a48-9e69-70028e763de0,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:2a19b09,CLOUDID:239353b8-3c45-407b-8f66-25095432a27a,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:0,BEC:nil
X-UUID: a0aacaf875ce4ec9a62ea1c1b15c4998-20220526
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 472255416; Thu, 26 May 2022 16:22:15 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Thu, 26 May 2022 16:22:14 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Thu, 26 May 2022 16:22:14 +0800
Message-ID: <86bc853d39a0c001f5b1bbbeecaf9a6d92abfe94.camel@mediatek.com>
Subject: Re: [PATCH v2 2/7] iommu: mtk_iommu: Lookup phandle to retrieve
 syscon to infracfg
From:   Yong Wu <yong.wu@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
CC:     <joro@8bytes.org>, <will@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <matthias.bgg@gmail.com>,
        <iommu@lists.linux-foundation.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <krzysztof.kozlowski@linaro.org>
Date:   Thu, 26 May 2022 16:22:13 +0800
In-Reply-To: <20220518100503.37279-3-angelogioacchino.delregno@collabora.com>
References: <20220518100503.37279-1-angelogioacchino.delregno@collabora.com>
         <20220518100503.37279-3-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-05-18 at 12:04 +0200, AngeloGioacchino Del Regno wrote:
> This driver will get support for more SoCs and the list of infracfg
> compatibles is expected to grow: in order to prevent getting this
> situation out of control and see a long list of compatible strings,
> add support to retrieve a handle to infracfg's regmap through a
> new "mediatek,infracfg" phandle.
> 
> In order to keep retrocompatibility with older devicetrees, the old
> way is kept in place, but also a dev_warn() was added to advertise
> this change in hope that the user will see it and eventually update
> the devicetree if this is possible.
> 
> Signed-off-by: AngeloGioacchino Del Regno <
> angelogioacchino.delregno@collabora.com>
> ---
>  drivers/iommu/mtk_iommu.c | 40 +++++++++++++++++++++++++----------
> ----
>  1 file changed, 26 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 71b2ace74cd6..d16b95e71ded 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -1134,22 +1134,34 @@ static int mtk_iommu_probe(struct
> platform_device *pdev)
>  	data->protect_base = ALIGN(virt_to_phys(protect),
> MTK_PROTECT_PA_ALIGN);
>  
>  	if (MTK_IOMMU_HAS_FLAG(data->plat_data, HAS_4GB_MODE)) {
> -		switch (data->plat_data->m4u_plat) {
> -		case M4U_MT2712:
> -			p = "mediatek,mt2712-infracfg";
> -			break;
> -		case M4U_MT8173:
> -			p = "mediatek,mt8173-infracfg";
> -			break;
> -		default:
> -			p = NULL;
> +		infracfg = syscon_regmap_lookup_by_phandle(dev-
> >of_node, "mediatek,infracfg");
> +		if (IS_ERR(infracfg)) {
> +			dev_info(dev, "Cannot find phandle to
> mediatek,infracfg:"
> +				      " Please update your
> devicetree.\n");

Remove the log from Robin?

> +			/*
> +			 * Legacy devicetrees will not specify a
> phandle to
> +			 * mediatek,infracfg: in that case, we use the
> older
> +			 * way to retrieve a syscon to infra.
> +			 *
> +			 * This is for retrocompatibility purposes
> only, hence
> +			 * no more compatibles shall be added to this.
> +			 */
> +			switch (data->plat_data->m4u_plat) {
> +			case M4U_MT2712:
> +				p = "mediatek,mt2712-infracfg";
> +				break;
> +			case M4U_MT8173:
> +				p = "mediatek,mt8173-infracfg";
> +				break;
> +			default:
> +				p = NULL;
> +			}

We already use "mediatek,infracfg" property for commonizing. For the
previous SoC, I also prefer to put the string into the platform data.

After this, "->m4u_plat" could be removed. Of course, this is not the
main purpose of this patchset. it also is ok currently.

> +
> +			infracfg =
> syscon_regmap_lookup_by_compatible(p);
> +			if (IS_ERR(infracfg))
> +				return PTR_ERR(infracfg);
>  		}
>  
> -		infracfg = syscon_regmap_lookup_by_compatible(p);
> -
> -		if (IS_ERR(infracfg))
> -			return PTR_ERR(infracfg);
> -
>  		ret = regmap_read(infracfg, REG_INFRA_MISC, &val);
>  		if (ret)
>  			return ret;

