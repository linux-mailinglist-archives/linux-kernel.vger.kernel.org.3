Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0FDB49C36F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 07:04:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234613AbiAZGEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 01:04:55 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:46726 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S234569AbiAZGEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 01:04:54 -0500
X-UUID: f96c7f052f7b4840ba58f443d510bc82-20220126
X-UUID: f96c7f052f7b4840ba58f443d510bc82-20220126
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1330849330; Wed, 26 Jan 2022 14:04:50 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 26 Jan 2022 14:04:48 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 26 Jan 2022 14:04:48 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     <wenst@chromium.org>
CC:     <chun-jie.chen@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>
Subject: Re: [PATCH 13/31] clk: mediatek: pll: Implement unregister API
Date:   Wed, 26 Jan 2022 14:04:49 +0800
Message-ID: <20220126060449.24874-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220122091731.283592-10-wenst@chromium.org>
References: <20220122091731.283592-10-wenst@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +static void mtk_clk_unregister_pll(struct clk *clk)
> +{
> +	struct clk_hw *hw = __clk_get_hw(clk);
> +	struct mtk_clk_pll *pll = to_mtk_clk_pll(hw);
> +
> +	clk_unregister(clk);
> +	kfree(pll);
> +}
> +

mtk_clk_unregister_pll() looks different. 
Do we need to check hw before passing it to to_mtk_clk_pll(hw), like
mtk_clk_unregister_mux()?

>  void mtk_clk_register_plls(struct device_node *node,
>  		const struct mtk_pll_data *plls, int num_plls, struct clk_onecell_data *clk_data)
>  {
> @@ -388,4 +397,44 @@ void mtk_clk_register_plls(struct device_node *node,
>  }
>  EXPORT_SYMBOL_GPL(mtk_clk_register_plls);
>  
> +static __iomem void *mtk_clk_pll_get_base(struct clk *clk,
> +					  const struct mtk_pll_data *data)
> +{
> +	struct clk_hw *hw = __clk_get_hw(clk);
> +	struct mtk_clk_pll *pll = to_mtk_clk_pll(hw);
> +
> +	return pll->base_addr - data->reg;
> +}
> +
> +void mtk_clk_unregister_plls(const struct mtk_pll_data *plls, int num_plls,
> +			     struct clk_onecell_data *clk_data)
> +{
> +	__iomem void *base = NULL;
> +	int i;
> +
> +	if (!clk_data)
> +		return;
> +
> +	for (i = num_plls; i > 0; i--) {
> +		const struct mtk_pll_data *pll = &plls[i - 1];
> +
> +		if (IS_ERR_OR_NULL(clk_data->clks[pll->id]))
> +			continue;
> +
> +		/*
> +		 * This is quite ugly but unfortunately the clks don't have
> +		 * any device tied to them, so there's no place to store the
> +		 * pointer to the I/O region base address. We have to fetch
> +		 * it from one of the registered clks.
> +		 */
> +		base = mtk_clk_pll_get_base(clk_data->clks[pll->id], pll);
> +
> +		mtk_clk_unregister_pll(clk_data->clks[pll->id]);
> +		clk_data->clks[pll->id] = ERR_PTR(-ENOENT);
> +	}
> +
> +	iounmap(base);
> +}
> +EXPORT_SYMBOL_GPL(mtk_clk_unregister_plls);
> +
>  MODULE_LICENSE("GPL");
> diff --git a/drivers/clk/mediatek/clk-pll.h b/drivers/clk/mediatek/clk-pll.h
> index d01b0c38311d..a889b1e472e7 100644
> --- a/drivers/clk/mediatek/clk-pll.h
> +++ b/drivers/clk/mediatek/clk-pll.h
> @@ -51,5 +51,7 @@ struct mtk_pll_data {
>  void mtk_clk_register_plls(struct device_node *node,
>  			   const struct mtk_pll_data *plls, int num_plls,
>  			   struct clk_onecell_data *clk_data);
> +void mtk_clk_unregister_plls(const struct mtk_pll_data *plls, int num_plls,
> +			     struct clk_onecell_data *clk_data);
>  
>  #endif /* __DRV_CLK_MTK_PLL_H */
> -- 
> 2.35.0.rc0.227.g00780c9af4-goog


