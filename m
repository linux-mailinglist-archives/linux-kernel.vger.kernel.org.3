Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2060149C566
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 09:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238524AbiAZIhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 03:37:45 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:35976 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230519AbiAZIhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 03:37:43 -0500
X-UUID: 0bf26c1694c445c5a00fa6f56753a0b3-20220126
X-UUID: 0bf26c1694c445c5a00fa6f56753a0b3-20220126
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1614965601; Wed, 26 Jan 2022 16:37:41 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 26 Jan 2022 16:37:41 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 26 Jan
 2022 16:37:41 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 26 Jan 2022 16:37:41 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     <wenst@chromium.org>
CC:     <chun-jie.chen@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>
Subject: Re: [PATCH 29/31] clk: mediatek: mt8195: Implement error handling in probe functions
Date:   Wed, 26 Jan 2022 16:37:41 +0800
Message-ID: <20220126083741.18563-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220122091731.283592-30-wenst@chromium.org>
References: <20220122091731.283592-30-wenst@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Until now the mediatek clk driver library did not have any way to
> unregister clks, and so all drivers did not do proper cleanup in
> their error paths.
> 
> Now that the library does have APIs to unregister clks, use them
> in the error path of the probe functions for the mt8195 clk drivers
> to do proper cleanup.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Reviewed-by: Miles Chen <miles.chen@mediatek.com>

> ---
>  drivers/clk/mediatek/clk-mt8195-apmixedsys.c | 13 ++++--
>  drivers/clk/mediatek/clk-mt8195-apusys_pll.c | 11 ++++-
>  drivers/clk/mediatek/clk-mt8195-topckgen.c   | 49 +++++++++++++++-----
>  drivers/clk/mediatek/clk-mt8195-vdo0.c       |  4 +-
>  drivers/clk/mediatek/clk-mt8195-vdo1.c       |  4 +-
>  5 files changed, 63 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/clk/mediatek/clk-mt8195-apmixedsys.c b/drivers/clk/mediatek/clk-mt8195-apmixedsys.c
> index 5b1b7dc447eb..af8d80f25f30 100644
> --- a/drivers/clk/mediatek/clk-mt8195-apmixedsys.c
> +++ b/drivers/clk/mediatek/clk-mt8195-apmixedsys.c
> @@ -120,17 +120,24 @@ static int clk_mt8195_apmixed_probe(struct platform_device *pdev)
>  	if (!clk_data)
>  		return -ENOMEM;
>  
> -	mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls), clk_data);
> -	r = mtk_clk_register_gates(node, apmixed_clks, ARRAY_SIZE(apmixed_clks), clk_data);
> +	r = mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls), clk_data);
>  	if (r)
>  		goto free_apmixed_data;
>  
> +	r = mtk_clk_register_gates(node, apmixed_clks, ARRAY_SIZE(apmixed_clks), clk_data);
> +	if (r)
> +		goto unregister_plls;
> +
>  	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
>  	if (r)
> -		goto free_apmixed_data;
> +		goto unregister_gates;
>  
>  	return r;
>  
> +unregister_gates:
> +	mtk_clk_register_gates(node, apmixed_clks, ARRAY_SIZE(apmixed_clks), clk_data);
> +unregister_plls:
> +	mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls), clk_data);
>  free_apmixed_data:
>  	mtk_free_clk_data(clk_data);
>  	return r;
> diff --git a/drivers/clk/mediatek/clk-mt8195-apusys_pll.c b/drivers/clk/mediatek/clk-mt8195-apusys_pll.c
> index db449ff877d7..1fff6f3d2dc7 100644
> --- a/drivers/clk/mediatek/clk-mt8195-apusys_pll.c
> +++ b/drivers/clk/mediatek/clk-mt8195-apusys_pll.c
> @@ -66,13 +66,20 @@ static int clk_mt8195_apusys_pll_probe(struct platform_device *pdev)
>  	if (!clk_data)
>  		return -ENOMEM;
>  
> -	mtk_clk_register_plls(node, apusys_plls, ARRAY_SIZE(apusys_plls), clk_data);
> -	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
> +	r = mtk_clk_register_plls(node, apusys_plls, ARRAY_SIZE(apusys_plls), clk_data);
>  	if (r)
>  		goto free_apusys_pll_data;
>  
> +	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
> +	if (r)
> +		goto unregister_plls;
> +
> +	platform_set_drvdata(pdev, clk_data);
> +
>  	return r;
>  
> +unregister_plls:
> +	mtk_clk_unregister_plls(apusys_plls, ARRAY_SIZE(apusys_plls), clk_data);
>  free_apusys_pll_data:
>  	mtk_free_clk_data(clk_data);
>  	return r;
> diff --git a/drivers/clk/mediatek/clk-mt8195-topckgen.c b/drivers/clk/mediatek/clk-mt8195-topckgen.c
> index 3e2aba9c40bb..3631f49a5e5a 100644
> --- a/drivers/clk/mediatek/clk-mt8195-topckgen.c
> +++ b/drivers/clk/mediatek/clk-mt8195-topckgen.c
> @@ -1239,25 +1239,52 @@ static int clk_mt8195_topck_probe(struct platform_device *pdev)
>  		goto free_top_data;
>  	}
>  
> -	mtk_clk_register_fixed_clks(top_fixed_clks, ARRAY_SIZE(top_fixed_clks),
> -				    top_clk_data);
> -	mtk_clk_register_factors(top_divs, ARRAY_SIZE(top_divs), top_clk_data);
> -	mtk_clk_register_muxes(top_mtk_muxes, ARRAY_SIZE(top_mtk_muxes), node,
> -			       &mt8195_clk_lock, top_clk_data);
> -	mtk_clk_register_composites(top_muxes, ARRAY_SIZE(top_muxes), base,
> -				    &mt8195_clk_lock, top_clk_data);
> -	mtk_clk_register_composites(top_adj_divs, ARRAY_SIZE(top_adj_divs), base,
> -				    &mt8195_clk_lock, top_clk_data);
> -	r = mtk_clk_register_gates(node, top_clks, ARRAY_SIZE(top_clks), top_clk_data);
> +	r = mtk_clk_register_fixed_clks(top_fixed_clks, ARRAY_SIZE(top_fixed_clks),
> +					top_clk_data);
>  	if (r)
>  		goto free_top_data;
>  
> +	r = mtk_clk_register_factors(top_divs, ARRAY_SIZE(top_divs), top_clk_data);
> +	if (r)
> +		goto unregister_fixed_clks;
> +
> +	r = mtk_clk_register_muxes(top_mtk_muxes, ARRAY_SIZE(top_mtk_muxes), node,
> +				   &mt8195_clk_lock, top_clk_data);
> +	if (r)
> +		goto unregister_factors;
> +
> +	r = mtk_clk_register_composites(top_muxes, ARRAY_SIZE(top_muxes), base,
> +					&mt8195_clk_lock, top_clk_data);
> +	if (r)
> +		goto unregister_muxes;
> +
> +	r = mtk_clk_register_composites(top_adj_divs, ARRAY_SIZE(top_adj_divs), base,
> +					&mt8195_clk_lock, top_clk_data);
> +	if (r)
> +		goto unregister_composite_muxes;
> +
> +	r = mtk_clk_register_gates(node, top_clks, ARRAY_SIZE(top_clks), top_clk_data);
> +	if (r)
> +		goto unregister_composite_divs;
> +
>  	r = of_clk_add_provider(node, of_clk_src_onecell_get, top_clk_data);
>  	if (r)
> -		goto free_top_data;
> +		goto unregister_gates;
>  
>  	return r;
>  
> +unregister_gates:
> +	mtk_clk_unregister_gates(top_clks, ARRAY_SIZE(top_clks), top_clk_data);
> +unregister_composite_divs:
> +	mtk_clk_unregister_composites(top_adj_divs, ARRAY_SIZE(top_adj_divs), top_clk_data);
> +unregister_composite_muxes:
> +	mtk_clk_unregister_composites(top_muxes, ARRAY_SIZE(top_muxes), top_clk_data);
> +unregister_muxes:
> +	mtk_clk_unregister_muxes(top_mtk_muxes, ARRAY_SIZE(top_mtk_muxes), top_clk_data);
> +unregister_factors:
> +	mtk_clk_unregister_factors(top_divs, ARRAY_SIZE(top_divs), top_clk_data);
> +unregister_fixed_clks:
> +	mtk_clk_unregister_fixed_clks(top_fixed_clks, ARRAY_SIZE(top_fixed_clks), top_clk_data);
>  free_top_data:
>  	mtk_free_clk_data(top_clk_data);
>  	return r;
> diff --git a/drivers/clk/mediatek/clk-mt8195-vdo0.c b/drivers/clk/mediatek/clk-mt8195-vdo0.c
> index f7ff7618c714..af34eb564b1d 100644
> --- a/drivers/clk/mediatek/clk-mt8195-vdo0.c
> +++ b/drivers/clk/mediatek/clk-mt8195-vdo0.c
> @@ -105,10 +105,12 @@ static int clk_mt8195_vdo0_probe(struct platform_device *pdev)
>  
>  	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
>  	if (r)
> -		goto free_vdo0_data;
> +		goto unregister_gates;
>  
>  	return r;
>  
> +unregister_gates:
> +	mtk_clk_unregister_gates(vdo0_clks, ARRAY_SIZE(vdo0_clks), clk_data);
>  free_vdo0_data:
>  	mtk_free_clk_data(clk_data);
>  	return r;
> diff --git a/drivers/clk/mediatek/clk-mt8195-vdo1.c b/drivers/clk/mediatek/clk-mt8195-vdo1.c
> index 03df8eae8838..6b502bbc730c 100644
> --- a/drivers/clk/mediatek/clk-mt8195-vdo1.c
> +++ b/drivers/clk/mediatek/clk-mt8195-vdo1.c
> @@ -122,10 +122,12 @@ static int clk_mt8195_vdo1_probe(struct platform_device *pdev)
>  
>  	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
>  	if (r)
> -		goto free_vdo1_data;
> +		goto unregister_gates;
>  
>  	return r;
>  
> +unregister_gates:
> +	mtk_clk_unregister_gates(vdo1_clks, ARRAY_SIZE(vdo1_clks), clk_data);
>  free_vdo1_data:
>  	mtk_free_clk_data(clk_data);
>  	return r;
> -- 
> 2.35.0.rc0.227.g00780c9af4-goog
> 
> 
