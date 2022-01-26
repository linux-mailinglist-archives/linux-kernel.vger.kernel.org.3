Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16EC949C3F9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 08:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237552AbiAZHGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 02:06:15 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:54012 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229979AbiAZHGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 02:06:13 -0500
X-UUID: 9468cd6333a943dc9e1a583a4c7e165c-20220126
X-UUID: 9468cd6333a943dc9e1a583a4c7e165c-20220126
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 24402797; Wed, 26 Jan 2022 15:06:10 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 26 Jan 2022 15:06:09 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 26 Jan 2022 15:06:09 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     <wenst@chromium.org>
CC:     <chun-jie.chen@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>
Subject: Re: [PATCH 18/31] clk: mediatek: Implement mtk_clk_unregister_composites() API
Date:   Wed, 26 Jan 2022 15:06:09 +0800
Message-ID: <20220126070609.28749-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220122091731.283592-19-wenst@chromium.org>
References: <20220122091731.283592-19-wenst@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> mtk_clk_register_composites(), as the name suggests, is used to register
> a given list of composite clks. However it is lacking a counterpart
> unregister API.
> 
> Implement said unregister API so that the various clock platform drivers
> can utilize it to do proper unregistration, cleanup and removal.
> 
> In the header file, the register function's declaration is also
> reformatted to fit code style guidelines.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
>  drivers/clk/mediatek/clk-mtk.c | 41 ++++++++++++++++++++++++++++++++++
>  drivers/clk/mediatek/clk-mtk.h |  2 ++
>  2 files changed, 43 insertions(+)
> 
> diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
> index 3a6dfe445e63..2150ed8678e0 100644
> --- a/drivers/clk/mediatek/clk-mtk.c
> +++ b/drivers/clk/mediatek/clk-mtk.c
> @@ -233,6 +233,27 @@ struct clk *mtk_clk_register_composite(const struct mtk_composite *mc,
>  	return ERR_PTR(ret);
>  }
>  
> +static void mtk_clk_unregister_composite(struct clk *clk)
> +{
> +	struct clk_hw *hw = __clk_get_hw(clk);
> +	struct clk_composite *composite = to_clk_composite(hw);
> +	struct clk_mux *mux = NULL;
> +	struct clk_gate *gate = NULL;
> +	struct clk_divider *div = NULL;

Like mtk_clk_unregister_pll(clk), let's check !hw for consistency
of clk unregister functions.

thanks,
Miles
> +
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
> @@ -259,6 +280,26 @@ void mtk_clk_register_composites(const struct mtk_composite *mcs,
>  }
>  EXPORT_SYMBOL_GPL(mtk_clk_register_composites);
>  
> +void mtk_clk_unregister_composites(const struct mtk_composite *mcs, int num,
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
> diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
> index e3ae22fb0334..3c3a934f53cd 100644
> --- a/drivers/clk/mediatek/clk-mtk.h
> +++ b/drivers/clk/mediatek/clk-mtk.h
> @@ -153,6 +153,8 @@ struct clk *mtk_clk_register_composite(const struct mtk_composite *mc,
>  void mtk_clk_register_composites(const struct mtk_composite *mcs,
>  		int num, void __iomem *base, spinlock_t *lock,
>  		struct clk_onecell_data *clk_data);
> +void mtk_clk_unregister_composites(const struct mtk_composite *mcs, int num,
> +				   struct clk_onecell_data *clk_data);
>  
>  struct mtk_clk_divider {
>  	int id;
> -- 
> 2.35.0.rc0.227.g00780c9af4-goog


