Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DAF852A473
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 16:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348571AbiEQOMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 10:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348609AbiEQOMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 10:12:24 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1EE3D193CA;
        Tue, 17 May 2022 07:12:23 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C8B2B1042;
        Tue, 17 May 2022 07:12:22 -0700 (PDT)
Received: from [10.57.82.55] (unknown [10.57.82.55])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 02C113F718;
        Tue, 17 May 2022 07:12:20 -0700 (PDT)
Message-ID: <16fb07d9-28d8-5c73-1eb5-ec13544d22e5@arm.com>
Date:   Tue, 17 May 2022 15:12:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 2/8] iommu: mtk_iommu: Lookup phandle to retrieve syscon
 to infracfg
Content-Language: en-GB
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, yong.wu@mediatek.com
Cc:     joro@8bytes.org, will@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        iommu@lists.linux-foundation.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20220517132107.195932-1-angelogioacchino.delregno@collabora.com>
 <20220517132107.195932-3-angelogioacchino.delregno@collabora.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220517132107.195932-3-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-05-17 14:21, AngeloGioacchino Del Regno wrote:
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
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>   drivers/iommu/mtk_iommu.c | 40 +++++++++++++++++++++++++--------------
>   1 file changed, 26 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 71b2ace74cd6..cfaaa98d2b50 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -1134,22 +1134,34 @@ static int mtk_iommu_probe(struct platform_device *pdev)
>   	data->protect_base = ALIGN(virt_to_phys(protect), MTK_PROTECT_PA_ALIGN);
>   
>   	if (MTK_IOMMU_HAS_FLAG(data->plat_data, HAS_4GB_MODE)) {
> -		switch (data->plat_data->m4u_plat) {
> -		case M4U_MT2712:
> -			p = "mediatek,mt2712-infracfg";
> -			break;
> -		case M4U_MT8173:
> -			p = "mediatek,mt8173-infracfg";
> -			break;
> -		default:
> -			p = NULL;
> +		infracfg = syscon_regmap_lookup_by_phandle(dev->of_node, "mediatek,infracfg");
> +		if (IS_ERR(infracfg)) {
> +			dev_warn(dev, "Cannot find phandle to mediatek,infracfg:"
> +				      " Please update your devicetree.\n");

Is this really a dev_warn-level problem? There's no functional impact, 
given that we can't stop supporting the original binding any time soon, 
if ever, so I suspect this is more likely to just annoy users and CI 
systems than effect any significant change.

> +			/*
> +			 * Legacy devicetrees will not specify a phandle to
> +			 * mediatek,infracfg: in that case, we use the older
> +			 * way to retrieve a syscon to infra.
> +			 *
> +			 * This is for retrocompatibility purposes only, hence
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
> +
> +			infracfg = syscon_regmap_lookup_by_compatible(p);

Would it not make sense to punt this over to the same mechanism as for 
pericfg, such that it simplifies down to something like:

	if (IS_ERR(infracfg) && plat_data->infracfg) {
		infracfg = syscon_regmap_lookup_by_compatible(plat_data->infracfg);
		...
	}

?

TBH if we're still going to have a load of per-SoC data in the driver 
anyway then I don't see that we really gain much by delegating one 
aspect of it to DT, but meh. I would note that with the phandle 
approach, you still need some *other* flag in the driver to know whether 
a phandle is expected to be present or not, whereas a NULL vs. non-NULL 
string is at least neatly self-describing.

Robin.

> +			if (IS_ERR(infracfg))
> +				return PTR_ERR(infracfg);
>   		}
>   
> -		infracfg = syscon_regmap_lookup_by_compatible(p);
> -
> -		if (IS_ERR(infracfg))
> -			return PTR_ERR(infracfg);
> -
>   		ret = regmap_read(infracfg, REG_INFRA_MISC, &val);
>   		if (ret)
>   			return ret;
