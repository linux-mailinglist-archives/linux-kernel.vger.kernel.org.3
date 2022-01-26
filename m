Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13CE549C503
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 09:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238235AbiAZINp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 03:13:45 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:49484 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230117AbiAZINl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 03:13:41 -0500
X-UUID: d58b8e005bca474d96ba35fda47a7dfe-20220126
X-UUID: d58b8e005bca474d96ba35fda47a7dfe-20220126
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1527592547; Wed, 26 Jan 2022 16:13:39 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 26 Jan 2022 16:13:38 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 26 Jan 2022 16:13:37 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     <wenst@chromium.org>
CC:     <chun-jie.chen@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>
Subject: Re: [PATCH 25/31] clk: mediatek: pll: Implement error handling in register API
Date:   Wed, 26 Jan 2022 16:13:38 +0800
Message-ID: <20220126081338.4114-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220122091731.283592-26-wenst@chromium.org>
References: <20220122091731.283592-26-wenst@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Reviewed-by: Miles Chen <miles.chen@mediatek.com>
> ---
>  drivers/clk/mediatek/clk-pll.c | 23 +++++++++++++++++++----
>  drivers/clk/mediatek/clk-pll.h |  6 +++---
>  2 files changed, 22 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/clk/mediatek/clk-pll.c b/drivers/clk/mediatek/clk-pll.c
> index 9698d1c97cd6..1dd15f560659 100644
> --- a/drivers/clk/mediatek/clk-pll.c
> +++ b/drivers/clk/mediatek/clk-pll.c
> @@ -369,8 +369,9 @@ static void mtk_clk_unregister_pll(struct clk *clk)
>  	kfree(pll);
>  }
>  
> -void mtk_clk_register_plls(struct device_node *node,
> -		const struct mtk_pll_data *plls, int num_plls, struct clk_onecell_data *clk_data)
> +int mtk_clk_register_plls(struct device_node *node,
> +			  const struct mtk_pll_data *plls, int num_plls,
> +			  struct clk_onecell_data *clk_data)
>  {
>  	void __iomem *base;
>  	int i;
> @@ -379,7 +380,7 @@ void mtk_clk_register_plls(struct device_node *node,
>  	base = of_iomap(node, 0);
>  	if (!base) {
>  		pr_err("%s(): ioremap failed\n", __func__);
> -		return;
> +		return -EINVAL;
>  	}
>  
>  	for (i = 0; i < num_plls; i++) {
> @@ -389,11 +390,25 @@ void mtk_clk_register_plls(struct device_node *node,
>  
>  		if (IS_ERR(clk)) {
>  			pr_err("Failed to register clk %s: %pe\n", pll->name, clk);
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
> +	};
> +
> +	iounmap(base);
> +
> +	return PTR_ERR(clk);
>  }
>  EXPORT_SYMBOL_GPL(mtk_clk_register_plls);
>  
> diff --git a/drivers/clk/mediatek/clk-pll.h b/drivers/clk/mediatek/clk-pll.h
> index a889b1e472e7..bf06e44caef9 100644
> --- a/drivers/clk/mediatek/clk-pll.h
> +++ b/drivers/clk/mediatek/clk-pll.h
> @@ -48,9 +48,9 @@ struct mtk_pll_data {
>  	u8 pll_en_bit; /* Assume 0, indicates BIT(0) by default */
>  };
>  
> -void mtk_clk_register_plls(struct device_node *node,
> -			   const struct mtk_pll_data *plls, int num_plls,
> -			   struct clk_onecell_data *clk_data);
> +int mtk_clk_register_plls(struct device_node *node,
> +			  const struct mtk_pll_data *plls, int num_plls,
> +			  struct clk_onecell_data *clk_data);
>  void mtk_clk_unregister_plls(const struct mtk_pll_data *plls, int num_plls,
>  			     struct clk_onecell_data *clk_data);
>  
> -- 
> 2.35.0.rc0.227.g00780c9af4-goog


