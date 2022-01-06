Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF6C4861E0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 10:13:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237244AbiAFJNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 04:13:48 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:55138 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S237200AbiAFJNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 04:13:46 -0500
X-UUID: 62544c99526148f1927aa3ecadaeb912-20220106
X-UUID: 62544c99526148f1927aa3ecadaeb912-20220106
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1000888201; Thu, 06 Jan 2022 17:13:44 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 6 Jan 2022 17:13:44 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 6 Jan 2022 17:13:43 +0800
Message-ID: <4d7195c3ac9bc63a5f980548f0c880484403346d.camel@mediatek.com>
Subject: Re: [PATCH 3/3] phy: mediatek: phy-mtk-mipi-dsi: Simplify with
 dev_err_probe()
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        <chunkuang.hu@kernel.org>
CC:     <p.zabel@pengutronix.de>, <kishon@ti.com>, <vkoul@kernel.org>,
        <matthias.bgg@gmail.com>, <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Date:   Thu, 6 Jan 2022 17:13:43 +0800
In-Reply-To: <20220103145324.48008-3-angelogioacchino.delregno@collabora.com>
References: <20220103145324.48008-1-angelogioacchino.delregno@collabora.com>
         <20220103145324.48008-3-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-01-03 at 15:53 +0100, AngeloGioacchino Del Regno wrote:
> Use the dev_err_probe() helper to simplify error handling during
> probe.
> 
> Signed-off-by: AngeloGioacchino Del Regno <
> angelogioacchino.delregno@collabora.com>
> ---
>  drivers/phy/mediatek/phy-mtk-mipi-dsi.c | 29 +++++++++------------
> ----
>  1 file changed, 10 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/phy/mediatek/phy-mtk-mipi-dsi.c
> b/drivers/phy/mediatek/phy-mtk-mipi-dsi.c
> index 6f7425b0bf5b..4b77508f5241 100644
> --- a/drivers/phy/mediatek/phy-mtk-mipi-dsi.c
> +++ b/drivers/phy/mediatek/phy-mtk-mipi-dsi.c
> @@ -148,11 +148,9 @@ static int mtk_mipi_tx_probe(struct
> platform_device *pdev)
>  		return PTR_ERR(mipi_tx->regmap);
>  
>  	ref_clk = devm_clk_get(dev, NULL);
> -	if (IS_ERR(ref_clk)) {
> -		ret = PTR_ERR(ref_clk);
> -		dev_err(dev, "Failed to get reference clock: %d\n",
> ret);
> -		return ret;
> -	}
> +	if (IS_ERR(ref_clk))
> +		return dev_err_probe(dev, PTR_ERR(ref_clk),
> +				     "Failed to get reference
> clock\n");
>  
>  	ret = of_property_read_u32(dev->of_node, "drive-strength-
> microamp",
>  				   &mipi_tx->mipitx_drive);
> @@ -172,27 +170,20 @@ static int mtk_mipi_tx_probe(struct
> platform_device *pdev)
>  
>  	ret = of_property_read_string(dev->of_node, "clock-output-
> names",
>  				      &clk_init.name);
> -	if (ret < 0) {
> -		dev_err(dev, "Failed to read clock-output-names: %d\n",
> ret);
> -		return ret;
> -	}
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Failed to read clock-
> output-names\n");
Seems no need change it here. (no EPROBE_DEFER error)

Thanks
>  
>  	clk_init.ops = mipi_tx->driver_data->mipi_tx_clk_ops;
>  
>  	mipi_tx->pll_hw.init = &clk_init;
>  	mipi_tx->pll = devm_clk_register(dev, &mipi_tx->pll_hw);
> -	if (IS_ERR(mipi_tx->pll)) {
> -		ret = PTR_ERR(mipi_tx->pll);
> -		dev_err(dev, "Failed to register PLL: %d\n", ret);
> -		return ret;
> -	}
> +	if (IS_ERR(mipi_tx->pll))
> +		return dev_err_probe(dev, PTR_ERR(mipi_tx->pll),
> "Cannot register PLL\n");
>  
>  	phy = devm_phy_create(dev, NULL, &mtk_mipi_tx_ops);
> -	if (IS_ERR(phy)) {
> -		ret = PTR_ERR(phy);
> -		dev_err(dev, "Failed to create MIPI D-PHY: %d\n", ret);
> -		return ret;
> -	}
> +	if (IS_ERR(phy))
> +		return dev_err_probe(dev, PTR_ERR(phy), "Failed to
> create MIPI D-PHY\n");
> +
>  	phy_set_drvdata(phy, mipi_tx);
>  
>  	phy_provider = devm_of_phy_provider_register(dev,
> of_phy_simple_xlate);

