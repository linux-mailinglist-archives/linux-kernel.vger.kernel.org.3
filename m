Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0F94B63F2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 08:06:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234719AbiBOHGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 02:06:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234722AbiBOHGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 02:06:14 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3171723FB;
        Mon, 14 Feb 2022 23:06:02 -0800 (PST)
X-UUID: f5796883f5814dc9ae98d17e31b6d026-20220215
X-UUID: f5796883f5814dc9ae98d17e31b6d026-20220215
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <chun-jie.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1097150039; Tue, 15 Feb 2022 15:05:57 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 15 Feb 2022 15:05:56 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 15 Feb 2022 15:05:56 +0800
Message-ID: <3062ed3573797e18997ac4fc9d37a898056fdf59.camel@mediatek.com>
Subject: Re: [PATCH v3 25/31] clk: mediatek: pll: Implement error handling
 in register API
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
Date:   Tue, 15 Feb 2022 15:05:56 +0800
In-Reply-To: <20220208124034.414635-26-wenst@chromium.org>
References: <20220208124034.414635-1-wenst@chromium.org>
         <20220208124034.414635-26-wenst@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-02-08 at 20:40 +0800, Chen-Yu Tsai wrote:
> The pll clk type registration function does not stop or return errors
> if any clk failed to be registered, nor does it implement an error
> handling path. This may result in a partially working device if any
> step failed.
> 
> Make the register function return proper error codes, and bail out if
> errors occur. Proper cleanup, i.e. unregister any clks that were
> successfully registered, and unmap the I/O space, is done in the new
> error path.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> Reviewed-by: Miles Chen <miles.chen@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <
> angelogioacchino.delregno@collabora.com>

Reviewed-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> ---
>  drivers/clk/mediatek/clk-pll.c | 23 +++++++++++++++++++----
>  drivers/clk/mediatek/clk-pll.h |  6 +++---
>  2 files changed, 22 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/clk/mediatek/clk-pll.c
> b/drivers/clk/mediatek/clk-pll.c
> index 8439d37e354d..817a80293bfc 100644
> --- a/drivers/clk/mediatek/clk-pll.c
> +++ b/drivers/clk/mediatek/clk-pll.c
> @@ -377,8 +377,9 @@ static void mtk_clk_unregister_pll(struct clk
> *clk)
>  	kfree(pll);
>  }
>  
> -void mtk_clk_register_plls(struct device_node *node,
> -		const struct mtk_pll_data *plls, int num_plls, struct
> clk_onecell_data *clk_data)
> +int mtk_clk_register_plls(struct device_node *node,
> +			  const struct mtk_pll_data *plls, int
> num_plls,
> +			  struct clk_onecell_data *clk_data)
>  {
>  	void __iomem *base;
>  	int i;
> @@ -387,7 +388,7 @@ void mtk_clk_register_plls(struct device_node
> *node,
>  	base = of_iomap(node, 0);
>  	if (!base) {
>  		pr_err("%s(): ioremap failed\n", __func__);
> -		return;
> +		return -EINVAL;
>  	}
>  
>  	for (i = 0; i < num_plls; i++) {
> @@ -397,11 +398,25 @@ void mtk_clk_register_plls(struct device_node
> *node,
>  
>  		if (IS_ERR(clk)) {
>  			pr_err("Failed to register clk %s: %pe\n", pll-
> >name, clk);
> -			continue;
> +			goto err;
>  		}
>  
>  		clk_data->clks[pll->id] = clk;
>  	}
> +
> +	return 0;
> +
> +err:
> +	while (--i >= 0) {
> +		const struct mtk_pll_data *pll = &plls[i];
> +
> +		mtk_clk_unregister_pll(clk_data->clks[pll->id]);
> +		clk_data->clks[pll->id] = ERR_PTR(-ENOENT);
> +	}
> +
> +	iounmap(base);
> +
> +	return PTR_ERR(clk);
>  }
>  EXPORT_SYMBOL_GPL(mtk_clk_register_plls);
>  
> diff --git a/drivers/clk/mediatek/clk-pll.h
> b/drivers/clk/mediatek/clk-pll.h
> index a889b1e472e7..bf06e44caef9 100644
> --- a/drivers/clk/mediatek/clk-pll.h
> +++ b/drivers/clk/mediatek/clk-pll.h
> @@ -48,9 +48,9 @@ struct mtk_pll_data {
>  	u8 pll_en_bit; /* Assume 0, indicates BIT(0) by default */
>  };
>  
> -void mtk_clk_register_plls(struct device_node *node,
> -			   const struct mtk_pll_data *plls, int
> num_plls,
> -			   struct clk_onecell_data *clk_data);
> +int mtk_clk_register_plls(struct device_node *node,
> +			  const struct mtk_pll_data *plls, int
> num_plls,
> +			  struct clk_onecell_data *clk_data);
>  void mtk_clk_unregister_plls(const struct mtk_pll_data *plls, int
> num_plls,
>  			     struct clk_onecell_data *clk_data);
>  

