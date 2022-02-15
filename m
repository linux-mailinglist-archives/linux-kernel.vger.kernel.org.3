Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 612F54B6363
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 07:25:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234382AbiBOGZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 01:25:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiBOGZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 01:25:36 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD7011E3D3;
        Mon, 14 Feb 2022 22:25:25 -0800 (PST)
X-UUID: b777ccd3ce5347d1b8d946e8d59dfc13-20220215
X-UUID: b777ccd3ce5347d1b8d946e8d59dfc13-20220215
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <chun-jie.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1042392645; Tue, 15 Feb 2022 14:25:21 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 15 Feb 2022 14:25:20 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 15 Feb
 2022 14:25:19 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 15 Feb 2022 14:25:19 +0800
Message-ID: <5c9f31fdd2fdd4d9dfd584e14328133bcb1ac7f5.camel@mediatek.com>
Subject: Re: [PATCH v3 06/31] clk: mediatek: cpumux: Implement unregister API
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
Date:   Tue, 15 Feb 2022 14:25:19 +0800
In-Reply-To: <20220208124034.414635-7-wenst@chromium.org>
References: <20220208124034.414635-1-wenst@chromium.org>
         <20220208124034.414635-7-wenst@chromium.org>
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
> The cpumux clk type within the MediaTek clk driver library only has
> a register function, and no corresponding unregister function. This
> means there is no way for its users to properly implement cleanup
> and removal.
> 
> Add a matching unregister function for the cpumux type clk.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> Reviewed-by: Miles Chen <miles.chen@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <
> angelogioacchino.delregno@collabora.com>

Reviewed-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> ---
>  drivers/clk/mediatek/clk-cpumux.c | 31
> +++++++++++++++++++++++++++++++
>  drivers/clk/mediatek/clk-cpumux.h |  3 +++
>  2 files changed, 34 insertions(+)
> 
> diff --git a/drivers/clk/mediatek/clk-cpumux.c
> b/drivers/clk/mediatek/clk-cpumux.c
> index cab5095416b6..99a819e3673f 100644
> --- a/drivers/clk/mediatek/clk-cpumux.c
> +++ b/drivers/clk/mediatek/clk-cpumux.c
> @@ -77,6 +77,21 @@ mtk_clk_register_cpumux(const struct mtk_composite
> *mux,
>  	return clk;
>  }
>  
> +static void mtk_clk_unregister_cpumux(struct clk *clk)
> +{
> +	struct mtk_clk_cpumux *cpumux;
> +	struct clk_hw *hw;
> +
> +	hw = __clk_get_hw(clk);
> +	if (!hw)
> +		return;
> +
> +	cpumux = to_mtk_clk_cpumux(hw);
> +
> +	clk_unregister(clk);
> +	kfree(cpumux);
> +}
> +
>  int mtk_clk_register_cpumuxes(struct device_node *node,
>  			      const struct mtk_composite *clks, int
> num,
>  			      struct clk_onecell_data *clk_data)
> @@ -106,4 +121,20 @@ int mtk_clk_register_cpumuxes(struct device_node
> *node,
>  	return 0;
>  }
>  
> +void mtk_clk_unregister_cpumuxes(const struct mtk_composite *clks,
> int num,
> +				 struct clk_onecell_data *clk_data)
> +{
> +	int i;
> +
> +	for (i = num; i > 0; i--) {
> +		const struct mtk_composite *mux = &clks[i - 1];
> +
> +		if (IS_ERR_OR_NULL(clk_data->clks[mux->id]))
> +			continue;
> +
> +		mtk_clk_unregister_cpumux(clk_data->clks[mux->id]);
> +		clk_data->clks[mux->id] = ERR_PTR(-ENOENT);
> +	}
> +}
> +
>  MODULE_LICENSE("GPL");
> diff --git a/drivers/clk/mediatek/clk-cpumux.h
> b/drivers/clk/mediatek/clk-cpumux.h
> index 2aaf1afd4e5f..fda7770fd803 100644
> --- a/drivers/clk/mediatek/clk-cpumux.h
> +++ b/drivers/clk/mediatek/clk-cpumux.h
> @@ -19,4 +19,7 @@ int mtk_clk_register_cpumuxes(struct device_node
> *node,
>  			      const struct mtk_composite *clks, int
> num,
>  			      struct clk_onecell_data *clk_data);
>  
> +void mtk_clk_unregister_cpumuxes(const struct mtk_composite *clks,
> int num,
> +				 struct clk_onecell_data *clk_data);
> +
>  #endif /* __DRV_CLK_CPUMUX_H */

