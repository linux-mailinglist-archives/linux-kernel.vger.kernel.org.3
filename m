Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4502649C56E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 09:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238529AbiAZIkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 03:40:39 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:40768 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230519AbiAZIki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 03:40:38 -0500
X-UUID: 29c83b0b7f444af6a02331b618126f4d-20220126
X-UUID: 29c83b0b7f444af6a02331b618126f4d-20220126
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1909331291; Wed, 26 Jan 2022 16:40:35 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 26 Jan 2022 16:40:33 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 26 Jan 2022 16:40:33 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     <wenst@chromium.org>
CC:     <chun-jie.chen@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>
Subject: Re: [PATCH 30/31] clk: mediatek: mt8195: Implement remove functions
Date:   Wed, 26 Jan 2022 16:40:33 +0800
Message-ID: <20220126084033.20234-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220122091731.283592-31-wenst@chromium.org>
References: <20220122091731.283592-31-wenst@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Until now the mediatek clk driver library did not have any way to
> unregister clks, and so none of the drivers implemented remove
> functions.
> 
> Now that the library does have APIs to unregister clks, use them
> to implement remove functions for the mt8195 clk drivers.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Reviewed-by: Miles Chen <miles.chen@mediatek.com>

> ---
>  drivers/clk/mediatek/clk-mt8195-apmixedsys.c | 16 ++++++++++++++++
>  drivers/clk/mediatek/clk-mt8195-apusys_pll.c | 13 +++++++++++++
>  drivers/clk/mediatek/clk-mt8195-topckgen.c   | 20 ++++++++++++++++++++
>  drivers/clk/mediatek/clk-mt8195-vdo0.c       | 16 ++++++++++++++++
>  drivers/clk/mediatek/clk-mt8195-vdo1.c       | 16 ++++++++++++++++
>  5 files changed, 81 insertions(+)
> 
> diff --git a/drivers/clk/mediatek/clk-mt8195-apmixedsys.c b/drivers/clk/mediatek/clk-mt8195-apmixedsys.c
> index af8d80f25f30..29cac3cf5f53 100644
> --- a/drivers/clk/mediatek/clk-mt8195-apmixedsys.c
> +++ b/drivers/clk/mediatek/clk-mt8195-apmixedsys.c
> @@ -132,6 +132,8 @@ static int clk_mt8195_apmixed_probe(struct platform_device *pdev)
>  	if (r)
>  		goto unregister_gates;
>  
> +	platform_set_drvdata(pdev, clk_data);
> +
>  	return r;
>  
>  unregister_gates:
> @@ -143,8 +145,22 @@ static int clk_mt8195_apmixed_probe(struct platform_device *pdev)
>  	return r;
>  }
>  
> +static int clk_mt8195_apmixed_remove(struct platform_device *pdev)
> +{
> +	struct device_node *node = pdev->dev.of_node;
> +	struct clk_onecell_data *clk_data = platform_get_drvdata(pdev);
> +
> +	of_clk_del_provider(node);
> +	mtk_clk_unregister_gates(apmixed_clks, ARRAY_SIZE(apmixed_clks), clk_data);
> +	mtk_clk_unregister_plls(plls, ARRAY_SIZE(plls), clk_data);
> +	mtk_free_clk_data(clk_data);
> +
> +	return 0;
> +}
> +
>  static struct platform_driver clk_mt8195_apmixed_drv = {
>  	.probe = clk_mt8195_apmixed_probe,
> +	.remove = clk_mt8195_apmixed_remove,
>  	.driver = {
>  		.name = "clk-mt8195-apmixed",
>  		.of_match_table = of_match_clk_mt8195_apmixed,
> diff --git a/drivers/clk/mediatek/clk-mt8195-apusys_pll.c b/drivers/clk/mediatek/clk-mt8195-apusys_pll.c
> index 1fff6f3d2dc7..8cd88dfc3283 100644
> --- a/drivers/clk/mediatek/clk-mt8195-apusys_pll.c
> +++ b/drivers/clk/mediatek/clk-mt8195-apusys_pll.c
> @@ -85,6 +85,18 @@ static int clk_mt8195_apusys_pll_probe(struct platform_device *pdev)
>  	return r;
>  }
>  
> +static int clk_mt8195_apusys_pll_remove(struct platform_device *pdev)
> +{
> +	struct clk_onecell_data *clk_data = platform_get_drvdata(pdev);
> +	struct device_node *node = pdev->dev.of_node;
> +
> +	of_clk_del_provider(node);
> +	mtk_clk_unregister_plls(apusys_plls, ARRAY_SIZE(apusys_plls), clk_data);
> +	mtk_free_clk_data(clk_data);
> +
> +	return 0;
> +}
> +
>  static const struct of_device_id of_match_clk_mt8195_apusys_pll[] = {
>  	{ .compatible = "mediatek,mt8195-apusys_pll", },
>  	{}
> @@ -92,6 +104,7 @@ static const struct of_device_id of_match_clk_mt8195_apusys_pll[] = {
>  
>  static struct platform_driver clk_mt8195_apusys_pll_drv = {
>  	.probe = clk_mt8195_apusys_pll_probe,
> +	.remove = clk_mt8195_apusys_pll_remove,
>  	.driver = {
>  		.name = "clk-mt8195-apusys_pll",
>  		.of_match_table = of_match_clk_mt8195_apusys_pll,
> diff --git a/drivers/clk/mediatek/clk-mt8195-topckgen.c b/drivers/clk/mediatek/clk-mt8195-topckgen.c
> index 3631f49a5e5a..b602fcd7f1d1 100644
> --- a/drivers/clk/mediatek/clk-mt8195-topckgen.c
> +++ b/drivers/clk/mediatek/clk-mt8195-topckgen.c
> @@ -1271,6 +1271,8 @@ static int clk_mt8195_topck_probe(struct platform_device *pdev)
>  	if (r)
>  		goto unregister_gates;
>  
> +	platform_set_drvdata(pdev, top_clk_data);
> +
>  	return r;
>  
>  unregister_gates:
> @@ -1290,8 +1292,26 @@ static int clk_mt8195_topck_probe(struct platform_device *pdev)
>  	return r;
>  }
>  
> +static int clk_mt8195_topck_remove(struct platform_device *pdev)
> +{
> +	struct clk_onecell_data *top_clk_data = platform_get_drvdata(pdev);
> +	struct device_node *node = pdev->dev.of_node;
> +
> +	of_clk_del_provider(node);
> +	mtk_clk_unregister_gates(top_clks, ARRAY_SIZE(top_clks), top_clk_data);
> +	mtk_clk_unregister_composites(top_adj_divs, ARRAY_SIZE(top_adj_divs), top_clk_data);
> +	mtk_clk_unregister_composites(top_muxes, ARRAY_SIZE(top_muxes), top_clk_data);
> +	mtk_clk_unregister_muxes(top_mtk_muxes, ARRAY_SIZE(top_mtk_muxes), top_clk_data);
> +	mtk_clk_unregister_factors(top_divs, ARRAY_SIZE(top_divs), top_clk_data);
> +	mtk_clk_unregister_fixed_clks(top_fixed_clks, ARRAY_SIZE(top_fixed_clks), top_clk_data);
> +	mtk_free_clk_data(top_clk_data);
> +
> +	return 0;
> +}
> +
>  static struct platform_driver clk_mt8195_topck_drv = {
>  	.probe = clk_mt8195_topck_probe,
> +	.remove = clk_mt8195_topck_remove,
>  	.driver = {
>  		.name = "clk-mt8195-topck",
>  		.of_match_table = of_match_clk_mt8195_topck,
> diff --git a/drivers/clk/mediatek/clk-mt8195-vdo0.c b/drivers/clk/mediatek/clk-mt8195-vdo0.c
> index af34eb564b1d..3bc7ed19d550 100644
> --- a/drivers/clk/mediatek/clk-mt8195-vdo0.c
> +++ b/drivers/clk/mediatek/clk-mt8195-vdo0.c
> @@ -107,6 +107,8 @@ static int clk_mt8195_vdo0_probe(struct platform_device *pdev)
>  	if (r)
>  		goto unregister_gates;
>  
> +	platform_set_drvdata(pdev, clk_data);
> +
>  	return r;
>  
>  unregister_gates:
> @@ -116,8 +118,22 @@ static int clk_mt8195_vdo0_probe(struct platform_device *pdev)
>  	return r;
>  }
>  
> +static int clk_mt8195_vdo0_remove(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *node = dev->parent->of_node;
> +	struct clk_onecell_data *clk_data = platform_get_drvdata(pdev);
> +
> +	of_clk_del_provider(node);
> +	mtk_clk_unregister_gates(vdo0_clks, ARRAY_SIZE(vdo0_clks), clk_data);
> +	mtk_free_clk_data(clk_data);
> +
> +	return 0;
> +}
> +
>  static struct platform_driver clk_mt8195_vdo0_drv = {
>  	.probe = clk_mt8195_vdo0_probe,
> +	.remove = clk_mt8195_vdo0_remove,
>  	.driver = {
>  		.name = "clk-mt8195-vdo0",
>  	},
> diff --git a/drivers/clk/mediatek/clk-mt8195-vdo1.c b/drivers/clk/mediatek/clk-mt8195-vdo1.c
> index 6b502bbc730c..90c738a85ff1 100644
> --- a/drivers/clk/mediatek/clk-mt8195-vdo1.c
> +++ b/drivers/clk/mediatek/clk-mt8195-vdo1.c
> @@ -124,6 +124,8 @@ static int clk_mt8195_vdo1_probe(struct platform_device *pdev)
>  	if (r)
>  		goto unregister_gates;
>  
> +	platform_set_drvdata(pdev, clk_data);
> +
>  	return r;
>  
>  unregister_gates:
> @@ -133,8 +135,22 @@ static int clk_mt8195_vdo1_probe(struct platform_device *pdev)
>  	return r;
>  }
>  
> +static int clk_mt8195_vdo1_remove(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *node = dev->parent->of_node;
> +	struct clk_onecell_data *clk_data = platform_get_drvdata(pdev);
> +
> +	of_clk_del_provider(node);
> +	mtk_clk_unregister_gates(vdo1_clks, ARRAY_SIZE(vdo1_clks), clk_data);
> +	mtk_free_clk_data(clk_data);
> +
> +	return 0;
> +}
> +
>  static struct platform_driver clk_mt8195_vdo1_drv = {
>  	.probe = clk_mt8195_vdo1_probe,
> +	.remove = clk_mt8195_vdo1_remove,
>  	.driver = {
>  		.name = "clk-mt8195-vdo1",
>  	},
> -- 
> 2.35.0.rc0.227.g00780c9af4-goog
> 
> 
