Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 150AE4B635F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 07:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234371AbiBOGYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 01:24:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiBOGYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 01:24:00 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA83311E3C6;
        Mon, 14 Feb 2022 22:23:49 -0800 (PST)
X-UUID: 708de5bbb144497aa31571e2c4436f64-20220215
X-UUID: 708de5bbb144497aa31571e2c4436f64-20220215
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <chun-jie.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 261985693; Tue, 15 Feb 2022 14:23:46 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 15 Feb 2022 14:23:44 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 15 Feb
 2022 14:23:44 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 15 Feb 2022 14:23:44 +0800
Message-ID: <8e8ee05a2cbc9f4754abcc4597f9fd9da18caf70.camel@mediatek.com>
Subject: Re: [PATCH v3 04/31] clk: mediatek: gate: Implement unregister API
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
Date:   Tue, 15 Feb 2022 14:23:44 +0800
In-Reply-To: <20220208124034.414635-5-wenst@chromium.org>
References: <20220208124034.414635-1-wenst@chromium.org>
         <20220208124034.414635-5-wenst@chromium.org>
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
> The gate clk type within the MediaTek clk driver library only has a
> register function, and no corresponding unregister function. This
> means there is no way for its users to properly implement cleanup
> and removal.
> 
> Add a matching unregister function for the gate type clk.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> Reviewed-by: Miles Chen <miles.chen@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <
> angelogioacchino.delregno@collabora.com>

Reviewed-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> ---
>  drivers/clk/mediatek/clk-gate.c | 35
> +++++++++++++++++++++++++++++++++
>  drivers/clk/mediatek/clk-gate.h |  3 +++
>  2 files changed, 38 insertions(+)
> 
> diff --git a/drivers/clk/mediatek/clk-gate.c
> b/drivers/clk/mediatek/clk-gate.c
> index e51cfd8c653c..ed1ad5535d41 100644
> --- a/drivers/clk/mediatek/clk-gate.c
> +++ b/drivers/clk/mediatek/clk-gate.c
> @@ -193,6 +193,21 @@ static struct clk *mtk_clk_register_gate(const
> char *name,
>  	return clk;
>  }
>  
> +static void mtk_clk_unregister_gate(struct clk *clk)
> +{
> +	struct mtk_clk_gate *cg;
> +	struct clk_hw *hw;
> +
> +	hw = __clk_get_hw(clk);
> +	if (!hw)
> +		return;
> +
> +	cg = to_mtk_clk_gate(hw);
> +
> +	clk_unregister(clk);
> +	kfree(cg);
> +}
> +
>  int mtk_clk_register_gates_with_dev(struct device_node *node,
>  				    const struct mtk_gate *clks, int
> num,
>  				    struct clk_onecell_data *clk_data,
> @@ -244,4 +259,24 @@ int mtk_clk_register_gates(struct device_node
> *node,
>  }
>  EXPORT_SYMBOL_GPL(mtk_clk_register_gates);
>  
> +void mtk_clk_unregister_gates(const struct mtk_gate *clks, int num,
> +			      struct clk_onecell_data *clk_data)
> +{
> +	int i;
> +
> +	if (!clk_data)
> +		return;
> +
> +	for (i = num; i > 0; i--) {
> +		const struct mtk_gate *gate = &clks[i - 1];
> +
> +		if (IS_ERR_OR_NULL(clk_data->clks[gate->id]))
> +			continue;
> +
> +		mtk_clk_unregister_gate(clk_data->clks[gate->id]);
> +		clk_data->clks[gate->id] = ERR_PTR(-ENOENT);
> +	}
> +}
> +EXPORT_SYMBOL_GPL(mtk_clk_unregister_gates);
> +
>  MODULE_LICENSE("GPL");
> diff --git a/drivers/clk/mediatek/clk-gate.h
> b/drivers/clk/mediatek/clk-gate.h
> index 3d75521ba20c..344adffb6578 100644
> --- a/drivers/clk/mediatek/clk-gate.h
> +++ b/drivers/clk/mediatek/clk-gate.h
> @@ -55,4 +55,7 @@ int mtk_clk_register_gates_with_dev(struct
> device_node *node,
>  				    struct clk_onecell_data *clk_data,
>  				    struct device *dev);
>  
> +void mtk_clk_unregister_gates(const struct mtk_gate *clks, int num,
> +			      struct clk_onecell_data *clk_data);
> +
>  #endif /* __DRV_CLK_GATE_H */

