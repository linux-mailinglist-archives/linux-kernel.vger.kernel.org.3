Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9F1F4B63A6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 07:37:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234584AbiBOGhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 01:37:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiBOGhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 01:37:08 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A87AC07F;
        Mon, 14 Feb 2022 22:36:58 -0800 (PST)
X-UUID: 9b95f74982ee40fd9837496290a40352-20220215
X-UUID: 9b95f74982ee40fd9837496290a40352-20220215
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <chun-jie.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1788521189; Tue, 15 Feb 2022 14:36:54 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Tue, 15 Feb 2022 14:36:52 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 15 Feb
 2022 14:36:52 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 15 Feb 2022 14:36:52 +0800
Message-ID: <a1bd326e24c36995b049a3957cf5323c4af27fc3.camel@mediatek.com>
Subject: Re: [PATCH v3 17/31] clk: mediatek: Implement
 mtk_clk_unregister_divider_clks() API
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
Date:   Tue, 15 Feb 2022 14:36:52 +0800
In-Reply-To: <20220208124034.414635-18-wenst@chromium.org>
References: <20220208124034.414635-1-wenst@chromium.org>
         <20220208124034.414635-18-wenst@chromium.org>
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
> mtk_clk_register_divider_clks(), as the name suggests, is used to
> register
> a given list of divider clks. However it is lacking a counterpart
> unregister API.
> 
> Implement said unregister API so that the various clock platform
> drivers
> can utilize it to do proper unregistration, cleanup and removal.
> 
> In the header file, the register function's declaration is also
> reformatted to fit code style guidelines.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> Reviewed-by: Miles Chen <miles.chen@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <
> angelogioacchino.delregno@collabora.com>

Reviewed-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> ---
>  drivers/clk/mediatek/clk-mtk.c | 19 +++++++++++++++++++
>  drivers/clk/mediatek/clk-mtk.h |  8 +++++---
>  2 files changed, 24 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/mediatek/clk-mtk.c
> b/drivers/clk/mediatek/clk-mtk.c
> index b267b2f04b84..3a6dfe445e63 100644
> --- a/drivers/clk/mediatek/clk-mtk.c
> +++ b/drivers/clk/mediatek/clk-mtk.c
> @@ -286,6 +286,25 @@ void mtk_clk_register_dividers(const struct
> mtk_clk_divider *mcds,
>  	}
>  }
>  
> +void mtk_clk_unregister_dividers(const struct mtk_clk_divider *mcds,
> int num,
> +				 struct clk_onecell_data *clk_data)
> +{
> +	int i;
> +
> +	if (!clk_data)
> +		return;
> +
> +	for (i = num; i > 0; i--) {
> +		const struct mtk_clk_divider *mcd = &mcds[i - 1];
> +
> +		if (IS_ERR_OR_NULL(clk_data->clks[mcd->id]))
> +			continue;
> +
> +		clk_unregister_divider(clk_data->clks[mcd->id]);
> +		clk_data->clks[mcd->id] = ERR_PTR(-ENOENT);
> +	}
> +}
> +
>  int mtk_clk_simple_probe(struct platform_device *pdev)
>  {
>  	const struct mtk_clk_desc *mcd;
> diff --git a/drivers/clk/mediatek/clk-mtk.h
> b/drivers/clk/mediatek/clk-mtk.h
> index 4db1a97c1250..e3ae22fb0334 100644
> --- a/drivers/clk/mediatek/clk-mtk.h
> +++ b/drivers/clk/mediatek/clk-mtk.h
> @@ -176,9 +176,11 @@ struct mtk_clk_divider {
>  		.div_width = _width,				\
>  }
>  
> -void mtk_clk_register_dividers(const struct mtk_clk_divider *mcds,
> -			int num, void __iomem *base, spinlock_t *lock,
> -				struct clk_onecell_data *clk_data);
> +void mtk_clk_register_dividers(const struct mtk_clk_divider *mcds,
> int num,
> +			       void __iomem *base, spinlock_t *lock,
> +			       struct clk_onecell_data *clk_data);
> +void mtk_clk_unregister_dividers(const struct mtk_clk_divider *mcds,
> int num,
> +				 struct clk_onecell_data *clk_data);
>  
>  struct clk_onecell_data *mtk_alloc_clk_data(unsigned int clk_num);
>  void mtk_free_clk_data(struct clk_onecell_data *clk_data);

