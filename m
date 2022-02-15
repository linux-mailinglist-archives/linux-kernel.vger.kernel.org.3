Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E33E64B63A7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 07:37:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234542AbiBOGhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 01:37:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiBOGhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 01:37:46 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F50AC07F;
        Mon, 14 Feb 2022 22:37:36 -0800 (PST)
X-UUID: 158efde242c841ae8be7ea3a91e9068c-20220215
X-UUID: 158efde242c841ae8be7ea3a91e9068c-20220215
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <chun-jie.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 153329230; Tue, 15 Feb 2022 14:37:32 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 15 Feb 2022 14:37:31 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 15 Feb
 2022 14:37:30 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 15 Feb 2022 14:37:30 +0800
Message-ID: <d564f1566e970647e105433316f3c4fa3f847df3.camel@mediatek.com>
Subject: Re: [PATCH v3 18/31] clk: mediatek: Implement
 mtk_clk_unregister_composites() API
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
Date:   Tue, 15 Feb 2022 14:37:30 +0800
In-Reply-To: <20220208124034.414635-19-wenst@chromium.org>
References: <20220208124034.414635-1-wenst@chromium.org>
         <20220208124034.414635-19-wenst@chromium.org>
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
> mtk_clk_register_composites(), as the name suggests, is used to
> register
> a given list of composite clks. However it is lacking a counterpart
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
> Reviewed-by: AngeloGioacchino Del Regno <
> angelogioacchino.delregno@collabora.com>
> Reviewed-by: Miles Chen <miles.chen@mediatek.com>

Reviewed-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> ---
>  drivers/clk/mediatek/clk-mtk.c | 46
> ++++++++++++++++++++++++++++++++++
>  drivers/clk/mediatek/clk-mtk.h |  2 ++
>  2 files changed, 48 insertions(+)
> 
> diff --git a/drivers/clk/mediatek/clk-mtk.c
> b/drivers/clk/mediatek/clk-mtk.c
> index 3a6dfe445e63..869e6ae55c82 100644
> --- a/drivers/clk/mediatek/clk-mtk.c
> +++ b/drivers/clk/mediatek/clk-mtk.c
> @@ -233,6 +233,32 @@ struct clk *mtk_clk_register_composite(const
> struct mtk_composite *mc,
>  	return ERR_PTR(ret);
>  }
>  
> +static void mtk_clk_unregister_composite(struct clk *clk)
> +{
> +	struct clk_hw *hw;
> +	struct clk_composite *composite;
> +	struct clk_mux *mux = NULL;
> +	struct clk_gate *gate = NULL;
> +	struct clk_divider *div = NULL;
> +
> +	hw = __clk_get_hw(clk);
> +	if (!hw)
> +		return;
> +
> +	composite = to_clk_composite(hw);
> +	if (composite->mux_hw)
> +		mux = to_clk_mux(composite->mux_hw);
> +	if (composite->gate_hw)
> +		gate = to_clk_gate(composite->gate_hw);
> +	if (composite->rate_hw)
> +		div = to_clk_divider(composite->rate_hw);
> +
> +	clk_unregister_composite(clk);
> +	kfree(div);
> +	kfree(gate);
> +	kfree(mux);
> +}
> +
>  void mtk_clk_register_composites(const struct mtk_composite *mcs,
>  		int num, void __iomem *base, spinlock_t *lock,
>  		struct clk_onecell_data *clk_data)
> @@ -259,6 +285,26 @@ void mtk_clk_register_composites(const struct
> mtk_composite *mcs,
>  }
>  EXPORT_SYMBOL_GPL(mtk_clk_register_composites);
>  
> +void mtk_clk_unregister_composites(const struct mtk_composite *mcs,
> int num,
> +				   struct clk_onecell_data *clk_data)
> +{
> +	int i;
> +
> +	if (!clk_data)
> +		return;
> +
> +	for (i = num; i > 0; i--) {
> +		const struct mtk_composite *mc = &mcs[i - 1];
> +
> +		if (IS_ERR_OR_NULL(clk_data->clks[mc->id]))
> +			continue;
> +
> +		mtk_clk_unregister_composite(clk_data->clks[mc->id]);
> +		clk_data->clks[mc->id] = ERR_PTR(-ENOENT);
> +	}
> +}
> +EXPORT_SYMBOL_GPL(mtk_clk_unregister_composites);
> +
>  void mtk_clk_register_dividers(const struct mtk_clk_divider *mcds,
>  			int num, void __iomem *base, spinlock_t *lock,
>  				struct clk_onecell_data *clk_data)
> diff --git a/drivers/clk/mediatek/clk-mtk.h
> b/drivers/clk/mediatek/clk-mtk.h
> index e3ae22fb0334..3c3a934f53cd 100644
> --- a/drivers/clk/mediatek/clk-mtk.h
> +++ b/drivers/clk/mediatek/clk-mtk.h
> @@ -153,6 +153,8 @@ struct clk *mtk_clk_register_composite(const
> struct mtk_composite *mc,
>  void mtk_clk_register_composites(const struct mtk_composite *mcs,
>  		int num, void __iomem *base, spinlock_t *lock,
>  		struct clk_onecell_data *clk_data);
> +void mtk_clk_unregister_composites(const struct mtk_composite *mcs,
> int num,
> +				   struct clk_onecell_data *clk_data);
>  
>  struct mtk_clk_divider {
>  	int id;

