Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 923004B6394
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 07:34:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234453AbiBOGeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 01:34:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234540AbiBOGd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 01:33:57 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC7881216B0;
        Mon, 14 Feb 2022 22:33:34 -0800 (PST)
X-UUID: ceea0872b43742d88d5ef02656a08ddd-20220215
X-UUID: ceea0872b43742d88d5ef02656a08ddd-20220215
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <chun-jie.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 425920834; Tue, 15 Feb 2022 14:33:27 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Tue, 15 Feb 2022 14:33:26 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 15 Feb 2022 14:33:25 +0800
Message-ID: <38e537baa8153bbdc6963addf349570ae8189133.camel@mediatek.com>
Subject: Re: [PATCH v3 13/31] clk: mediatek: pll: Implement unregister API
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
Date:   Tue, 15 Feb 2022 14:33:26 +0800
In-Reply-To: <20220208124034.414635-14-wenst@chromium.org>
References: <20220208124034.414635-1-wenst@chromium.org>
         <20220208124034.414635-14-wenst@chromium.org>
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
> The PLL clk type within the MediaTek clk driver library only has a
> register function, and no corresponding unregister function. This
> means there is no way for its users to properly implement cleanup
> and removal.
> 
> Add a matching unregister function for the PLL type clk.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> Reviewed-by: Miles Chen <miles.chen@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <
> angelogioacchino.delregno@collabora.com>

Reviewed-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> ---
>  drivers/clk/mediatek/clk-pll.c | 55
> ++++++++++++++++++++++++++++++++++
>  drivers/clk/mediatek/clk-pll.h |  2 ++
>  2 files changed, 57 insertions(+)
> 
> diff --git a/drivers/clk/mediatek/clk-pll.c
> b/drivers/clk/mediatek/clk-pll.c
> index 64f59554bc9b..b54e33b75d4e 100644
> --- a/drivers/clk/mediatek/clk-pll.c
> +++ b/drivers/clk/mediatek/clk-pll.c
> @@ -360,6 +360,21 @@ static struct clk *mtk_clk_register_pll(const
> struct mtk_pll_data *data,
>  	return clk;
>  }
>  
> +static void mtk_clk_unregister_pll(struct clk *clk)
> +{
> +	struct clk_hw *hw;
> +	struct mtk_clk_pll *pll;
> +
> +	hw = __clk_get_hw(clk);
> +	if (!hw)
> +		return;
> +
> +	pll = to_mtk_clk_pll(hw);
> +
> +	clk_unregister(clk);
> +	kfree(pll);
> +}
> +
>  void mtk_clk_register_plls(struct device_node *node,
>  		const struct mtk_pll_data *plls, int num_plls, struct
> clk_onecell_data *clk_data)
>  {
> @@ -388,4 +403,44 @@ void mtk_clk_register_plls(struct device_node
> *node,
>  }
>  EXPORT_SYMBOL_GPL(mtk_clk_register_plls);
>  
> +static __iomem void *mtk_clk_pll_get_base(struct clk *clk,
> +					  const struct mtk_pll_data
> *data)
> +{
> +	struct clk_hw *hw = __clk_get_hw(clk);
> +	struct mtk_clk_pll *pll = to_mtk_clk_pll(hw);
> +
> +	return pll->base_addr - data->reg;
> +}
> +
> +void mtk_clk_unregister_plls(const struct mtk_pll_data *plls, int
> num_plls,
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
> +		 * This is quite ugly but unfortunately the clks don't
> have
> +		 * any device tied to them, so there's no place to
> store the
> +		 * pointer to the I/O region base address. We have to
> fetch
> +		 * it from one of the registered clks.
> +		 */
> +		base = mtk_clk_pll_get_base(clk_data->clks[pll->id],
> pll);
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
> diff --git a/drivers/clk/mediatek/clk-pll.h
> b/drivers/clk/mediatek/clk-pll.h
> index d01b0c38311d..a889b1e472e7 100644
> --- a/drivers/clk/mediatek/clk-pll.h
> +++ b/drivers/clk/mediatek/clk-pll.h
> @@ -51,5 +51,7 @@ struct mtk_pll_data {
>  void mtk_clk_register_plls(struct device_node *node,
>  			   const struct mtk_pll_data *plls, int
> num_plls,
>  			   struct clk_onecell_data *clk_data);
> +void mtk_clk_unregister_plls(const struct mtk_pll_data *plls, int
> num_plls,
> +			     struct clk_onecell_data *clk_data);
>  
>  #endif /* __DRV_CLK_MTK_PLL_H */

