Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2954F49B9E5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 18:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390621AbiAYROk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 12:14:40 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:55158 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1389994AbiAYRL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 12:11:57 -0500
X-UUID: 594fd2776546451ba0d1228dc3276dcb-20220126
X-UUID: 594fd2776546451ba0d1228dc3276dcb-20220126
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 448498903; Wed, 26 Jan 2022 01:11:49 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 26 Jan 2022 01:11:48 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 26 Jan
 2022 01:11:48 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 26 Jan 2022 01:11:48 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     <wenst@chromium.org>
CC:     <chun-jie.chen@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>
Subject: Re: [PATCH 06/31] clk: mediatek: cpumux: Implement unregister API
Date:   Wed, 26 Jan 2022 01:11:48 +0800
Message-ID: <20220125171148.31102-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220122091731.283592-7-wenst@chromium.org>
References: <20220122091731.283592-7-wenst@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The cpumux clk type within the MediaTek clk driver library only has
> a register function, and no corresponding unregister function. This
> means there is no way for its users to properly implement cleanup
> and removal.
> 
> Add a matching unregister function for the cpumux type clk.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
>
Reviewed-by: Miles Chen <miles.chen@mediatek.com>
> ---
>  drivers/clk/mediatek/clk-cpumux.c | 31 +++++++++++++++++++++++++++++++
>  drivers/clk/mediatek/clk-cpumux.h |  3 +++
>  2 files changed, 34 insertions(+)
> 
> diff --git a/drivers/clk/mediatek/clk-cpumux.c b/drivers/clk/mediatek/clk-cpumux.c
> index cab5095416b6..99a819e3673f 100644
> --- a/drivers/clk/mediatek/clk-cpumux.c
> +++ b/drivers/clk/mediatek/clk-cpumux.c
> @@ -77,6 +77,21 @@ mtk_clk_register_cpumux(const struct mtk_composite *mux,
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
>  			      const struct mtk_composite *clks, int num,
>  			      struct clk_onecell_data *clk_data)
> @@ -106,4 +121,20 @@ int mtk_clk_register_cpumuxes(struct device_node *node,
>  	return 0;
>  }
>  
> +void mtk_clk_unregister_cpumuxes(const struct mtk_composite *clks, int num,
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
> diff --git a/drivers/clk/mediatek/clk-cpumux.h b/drivers/clk/mediatek/clk-cpumux.h
> index 2aaf1afd4e5f..fda7770fd803 100644
> --- a/drivers/clk/mediatek/clk-cpumux.h
> +++ b/drivers/clk/mediatek/clk-cpumux.h
> @@ -19,4 +19,7 @@ int mtk_clk_register_cpumuxes(struct device_node *node,
>  			      const struct mtk_composite *clks, int num,
>  			      struct clk_onecell_data *clk_data);
>  
> +void mtk_clk_unregister_cpumuxes(const struct mtk_composite *clks, int num,
> +				 struct clk_onecell_data *clk_data);
> +
>  #endif /* __DRV_CLK_CPUMUX_H */
> -- 
> 2.35.0.rc0.227.g00780c9af4-goog


