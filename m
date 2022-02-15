Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D71444B6343
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 07:07:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbiBOGHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 01:07:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiBOGHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 01:07:20 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD50D43AF3;
        Mon, 14 Feb 2022 22:07:02 -0800 (PST)
X-UUID: a2cb53b2c3f644f8bba8ce770ec60631-20220215
X-UUID: a2cb53b2c3f644f8bba8ce770ec60631-20220215
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <chun-jie.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 609010241; Tue, 15 Feb 2022 14:06:56 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Tue, 15 Feb 2022 14:06:54 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 15 Feb 2022 14:06:54 +0800
Message-ID: <5c2b97a1260b9349b151448d09e6308c2a3b252b.camel@mediatek.com>
Subject: Re: [PATCH v3 01/31] clk: mediatek: Use %pe to print errors
From:   Chun-Jie Chen <chun-jie.chen@mediatek.com>
To:     Chen-Yu Tsai <wenst@chromium.org>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Miles Chen <miles.chen@mediatek.com>,
        <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Date:   Tue, 15 Feb 2022 14:06:48 +0800
In-Reply-To: <20220208124034.414635-2-wenst@chromium.org>
References: <20220208124034.414635-1-wenst@chromium.org>
         <20220208124034.414635-2-wenst@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-02-08 at 20:40 +0800, Chen-Yu Tsai wrote:
> If %pe is used to print errors, a string representation of the error
> would be printed instead of a number as with %ld. Also, all the sites
> printing errors are deriving the error code from a pointer. Using %pe
> is more straightforward.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> Reviewed-by: Miles Chen <miles.chen@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <
> angelogioacchino.delregno@collabora.com>
> 

Reviewed-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> ---
>  drivers/clk/mediatek/clk-apmixed.c |  2 +-
>  drivers/clk/mediatek/clk-cpumux.c  |  6 ++----
>  drivers/clk/mediatek/clk-mtk.c     | 18 ++++++------------
>  drivers/clk/mediatek/clk-mux.c     |  6 ++----
>  drivers/clk/mediatek/clk-pll.c     |  3 +--
>  drivers/clk/mediatek/reset.c       |  3 +--
>  6 files changed, 13 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/clk/mediatek/clk-apmixed.c
> b/drivers/clk/mediatek/clk-apmixed.c
> index caa9119413f1..a29339cc26c4 100644
> --- a/drivers/clk/mediatek/clk-apmixed.c
> +++ b/drivers/clk/mediatek/clk-apmixed.c
> @@ -92,7 +92,7 @@ struct clk * __init
> mtk_clk_register_ref2usb_tx(const char *name,
>  	clk = clk_register(NULL, &tx->hw);
>  
>  	if (IS_ERR(clk)) {
> -		pr_err("Failed to register clk %s: %ld\n", name,
> PTR_ERR(clk));
> +		pr_err("Failed to register clk %s: %pe\n", name, clk);
>  		kfree(tx);
>  	}
>  
> diff --git a/drivers/clk/mediatek/clk-cpumux.c
> b/drivers/clk/mediatek/clk-cpumux.c
> index e188018bc906..cab5095416b6 100644
> --- a/drivers/clk/mediatek/clk-cpumux.c
> +++ b/drivers/clk/mediatek/clk-cpumux.c
> @@ -87,8 +87,7 @@ int mtk_clk_register_cpumuxes(struct device_node
> *node,
>  
>  	regmap = device_node_to_regmap(node);
>  	if (IS_ERR(regmap)) {
> -		pr_err("Cannot find regmap for %pOF: %ld\n", node,
> -		       PTR_ERR(regmap));
> +		pr_err("Cannot find regmap for %pOF: %pe\n", node,
> regmap);
>  		return PTR_ERR(regmap);
>  	}
>  
> @@ -97,8 +96,7 @@ int mtk_clk_register_cpumuxes(struct device_node
> *node,
>  
>  		clk = mtk_clk_register_cpumux(mux, regmap);
>  		if (IS_ERR(clk)) {
> -			pr_err("Failed to register clk %s: %ld\n",
> -			       mux->name, PTR_ERR(clk));
> +			pr_err("Failed to register clk %s: %pe\n", mux-
> >name, clk);
>  			continue;
>  		}
>  
> diff --git a/drivers/clk/mediatek/clk-mtk.c
> b/drivers/clk/mediatek/clk-mtk.c
> index 8d5791b3f460..519a461cbb6f 100644
> --- a/drivers/clk/mediatek/clk-mtk.c
> +++ b/drivers/clk/mediatek/clk-mtk.c
> @@ -70,8 +70,7 @@ void mtk_clk_register_fixed_clks(const struct
> mtk_fixed_clk *clks,
>  					      rc->rate);
>  
>  		if (IS_ERR(clk)) {
> -			pr_err("Failed to register clk %s: %ld\n",
> -					rc->name, PTR_ERR(clk));
> +			pr_err("Failed to register clk %s: %pe\n", rc-
> >name, clk);
>  			continue;
>  		}
>  
> @@ -97,8 +96,7 @@ void mtk_clk_register_factors(const struct
> mtk_fixed_factor *clks,
>  				CLK_SET_RATE_PARENT, ff->mult, ff-
> >div);
>  
>  		if (IS_ERR(clk)) {
> -			pr_err("Failed to register clk %s: %ld\n",
> -					ff->name, PTR_ERR(clk));
> +			pr_err("Failed to register clk %s: %pe\n", ff-
> >name, clk);
>  			continue;
>  		}
>  
> @@ -122,8 +120,7 @@ int mtk_clk_register_gates_with_dev(struct
> device_node *node,
>  
>  	regmap = device_node_to_regmap(node);
>  	if (IS_ERR(regmap)) {
> -		pr_err("Cannot find regmap for %pOF: %ld\n", node,
> -				PTR_ERR(regmap));
> +		pr_err("Cannot find regmap for %pOF: %pe\n", node,
> regmap);
>  		return PTR_ERR(regmap);
>  	}
>  
> @@ -141,8 +138,7 @@ int mtk_clk_register_gates_with_dev(struct
> device_node *node,
>  				gate->shift, gate->ops, gate->flags,
> dev);
>  
>  		if (IS_ERR(clk)) {
> -			pr_err("Failed to register clk %s: %ld\n",
> -					gate->name, PTR_ERR(clk));
> +			pr_err("Failed to register clk %s: %pe\n",
> gate->name, clk);
>  			continue;
>  		}
>  
> @@ -264,8 +260,7 @@ void mtk_clk_register_composites(const struct
> mtk_composite *mcs,
>  		clk = mtk_clk_register_composite(mc, base, lock);
>  
>  		if (IS_ERR(clk)) {
> -			pr_err("Failed to register clk %s: %ld\n",
> -					mc->name, PTR_ERR(clk));
> +			pr_err("Failed to register clk %s: %pe\n", mc-
> >name, clk);
>  			continue;
>  		}
>  
> @@ -293,8 +288,7 @@ void mtk_clk_register_dividers(const struct
> mtk_clk_divider *mcds,
>  			mcd->div_width, mcd->clk_divider_flags, lock);
>  
>  		if (IS_ERR(clk)) {
> -			pr_err("Failed to register clk %s: %ld\n",
> -				mcd->name, PTR_ERR(clk));
> +			pr_err("Failed to register clk %s: %pe\n", mcd-
> >name, clk);
>  			continue;
>  		}
>  
> diff --git a/drivers/clk/mediatek/clk-mux.c
> b/drivers/clk/mediatek/clk-mux.c
> index 6d3a50eb7d6f..89f23e111d91 100644
> --- a/drivers/clk/mediatek/clk-mux.c
> +++ b/drivers/clk/mediatek/clk-mux.c
> @@ -175,8 +175,7 @@ int mtk_clk_register_muxes(const struct mtk_mux
> *muxes,
>  
>  	regmap = device_node_to_regmap(node);
>  	if (IS_ERR(regmap)) {
> -		pr_err("Cannot find regmap for %pOF: %ld\n", node,
> -		       PTR_ERR(regmap));
> +		pr_err("Cannot find regmap for %pOF: %pe\n", node,
> regmap);
>  		return PTR_ERR(regmap);
>  	}
>  
> @@ -187,8 +186,7 @@ int mtk_clk_register_muxes(const struct mtk_mux
> *muxes,
>  			clk = mtk_clk_register_mux(mux, regmap, lock);
>  
>  			if (IS_ERR(clk)) {
> -				pr_err("Failed to register clk %s:
> %ld\n",
> -				       mux->name, PTR_ERR(clk));
> +				pr_err("Failed to register clk %s:
> %pe\n", mux->name, clk);
>  				continue;
>  			}
>  
> diff --git a/drivers/clk/mediatek/clk-pll.c
> b/drivers/clk/mediatek/clk-pll.c
> index 60d7ffa0b924..f04f724e12e5 100644
> --- a/drivers/clk/mediatek/clk-pll.c
> +++ b/drivers/clk/mediatek/clk-pll.c
> @@ -378,8 +378,7 @@ void mtk_clk_register_plls(struct device_node
> *node,
>  		clk = mtk_clk_register_pll(pll, base);
>  
>  		if (IS_ERR(clk)) {
> -			pr_err("Failed to register clk %s: %ld\n",
> -					pll->name, PTR_ERR(clk));
> +			pr_err("Failed to register clk %s: %pe\n", pll-
> >name, clk);
>  			continue;
>  		}
>  
> diff --git a/drivers/clk/mediatek/reset.c
> b/drivers/clk/mediatek/reset.c
> index ffe464ce7ff8..bcec4b89f449 100644
> --- a/drivers/clk/mediatek/reset.c
> +++ b/drivers/clk/mediatek/reset.c
> @@ -100,8 +100,7 @@ static void
> mtk_register_reset_controller_common(struct device_node *np,
>  
>  	regmap = device_node_to_regmap(np);
>  	if (IS_ERR(regmap)) {
> -		pr_err("Cannot find regmap for %pOF: %ld\n", np,
> -				PTR_ERR(regmap));
> +		pr_err("Cannot find regmap for %pOF: %pe\n", np,
> regmap);
>  		return;
>  	}
>  

