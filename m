Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD1A4B6403
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 08:10:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233378AbiBOHKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 02:10:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbiBOHKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 02:10:32 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323DCA8ED5;
        Mon, 14 Feb 2022 23:10:19 -0800 (PST)
X-UUID: 1d5134b350114f69a4f09cb4ee186759-20220215
X-UUID: 1d5134b350114f69a4f09cb4ee186759-20220215
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <chun-jie.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2011686599; Tue, 15 Feb 2022 15:10:15 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Tue, 15 Feb 2022 15:10:15 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 15 Feb
 2022 15:10:11 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 15 Feb 2022 15:10:11 +0800
Message-ID: <fc5593073d85e3575993eeb92c546db90730cb23.camel@mediatek.com>
Subject: Re: [PATCH v3 26/31] clk: mediatek: mtk: Implement error handling
 in register APIs
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
Date:   Tue, 15 Feb 2022 15:10:11 +0800
In-Reply-To: <20220208124034.414635-27-wenst@chromium.org>
References: <20220208124034.414635-1-wenst@chromium.org>
         <20220208124034.414635-27-wenst@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-02-08 at 20:40 +0800, Chen-Yu Tsai wrote:
> The remaining clk registration functions do not stop or return errors
> if any clk failed to be registered, nor do they implement error
> handling paths. This may result in a partially working device if any
> step fails.
> 
> Make the register functions return proper error codes, and bail out
> if
> errors occur. Proper cleanup, i.e. unregister any clks that were
> successfully registered, is done in the new error path.
> 
> This also makes the |struct clk_data *| argument mandatory, as it is
> used to track the list of clks registered.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> Reviewed-by: Miles Chen <miles.chen@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <
> angelogioacchino.delregno@collabora.com>

Reviewed-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> ---
>  drivers/clk/mediatek/clk-mtk.c | 118 ++++++++++++++++++++++++++-----
> --
>  drivers/clk/mediatek/clk-mtk.h |  20 +++---
>  2 files changed, 103 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/clk/mediatek/clk-mtk.c
> b/drivers/clk/mediatek/clk-mtk.c
> index 5618c84e4e08..8f15e9de742e 100644
> --- a/drivers/clk/mediatek/clk-mtk.c
> +++ b/drivers/clk/mediatek/clk-mtk.c
> @@ -53,16 +53,19 @@ void mtk_free_clk_data(struct clk_onecell_data
> *clk_data)
>  	kfree(clk_data);
>  }
>  
> -void mtk_clk_register_fixed_clks(const struct mtk_fixed_clk *clks,
> -		int num, struct clk_onecell_data *clk_data)
> +int mtk_clk_register_fixed_clks(const struct mtk_fixed_clk *clks,
> int num,
> +				struct clk_onecell_data *clk_data)
>  {
>  	int i;
>  	struct clk *clk;
>  
> +	if (!clk_data)
> +		return -ENOMEM;
> +
>  	for (i = 0; i < num; i++) {
>  		const struct mtk_fixed_clk *rc = &clks[i];
>  
> -		if (clk_data && !IS_ERR_OR_NULL(clk_data->clks[rc-
> >id]))
> +		if (!IS_ERR_OR_NULL(clk_data->clks[rc->id]))
>  			continue;
>  
>  		clk = clk_register_fixed_rate(NULL, rc->name, rc-
> >parent, 0,
> @@ -70,12 +73,26 @@ void mtk_clk_register_fixed_clks(const struct
> mtk_fixed_clk *clks,
>  
>  		if (IS_ERR(clk)) {
>  			pr_err("Failed to register clk %s: %pe\n", rc-
> >name, clk);
> -			continue;
> +			goto err;
>  		}
>  
> -		if (clk_data)
> -			clk_data->clks[rc->id] = clk;
> +		clk_data->clks[rc->id] = clk;
>  	}
> +
> +	return 0;
> +
> +err:
> +	while (--i >= 0) {
> +		const struct mtk_fixed_clk *rc = &clks[i];
> +
> +		if (IS_ERR_OR_NULL(clk_data->clks[rc->id]))
> +			continue;
> +
> +		clk_unregister_fixed_rate(clk_data->clks[rc->id]);
> +		clk_data->clks[rc->id] = ERR_PTR(-ENOENT);
> +	}
> +
> +	return PTR_ERR(clk);
>  }
>  EXPORT_SYMBOL_GPL(mtk_clk_register_fixed_clks);
>  
> @@ -99,16 +116,19 @@ void mtk_clk_unregister_fixed_clks(const struct
> mtk_fixed_clk *clks, int num,
>  }
>  EXPORT_SYMBOL_GPL(mtk_clk_unregister_fixed_clks);
>  
> -void mtk_clk_register_factors(const struct mtk_fixed_factor *clks,
> -		int num, struct clk_onecell_data *clk_data)
> +int mtk_clk_register_factors(const struct mtk_fixed_factor *clks,
> int num,
> +			     struct clk_onecell_data *clk_data)
>  {
>  	int i;
>  	struct clk *clk;
>  
> +	if (!clk_data)
> +		return -ENOMEM;
> +
>  	for (i = 0; i < num; i++) {
>  		const struct mtk_fixed_factor *ff = &clks[i];
>  
> -		if (clk_data && !IS_ERR_OR_NULL(clk_data->clks[ff-
> >id]))
> +		if (!IS_ERR_OR_NULL(clk_data->clks[ff->id]))
>  			continue;
>  
>  		clk = clk_register_fixed_factor(NULL, ff->name, ff-
> >parent_name,
> @@ -116,12 +136,26 @@ void mtk_clk_register_factors(const struct
> mtk_fixed_factor *clks,
>  
>  		if (IS_ERR(clk)) {
>  			pr_err("Failed to register clk %s: %pe\n", ff-
> >name, clk);
> -			continue;
> +			goto err;
>  		}
>  
> -		if (clk_data)
> -			clk_data->clks[ff->id] = clk;
> +		clk_data->clks[ff->id] = clk;
> +	}
> +
> +	return 0;
> +
> +err:
> +	while (--i >= 0) {
> +		const struct mtk_fixed_factor *ff = &clks[i];
> +
> +		if (IS_ERR_OR_NULL(clk_data->clks[ff->id]))
> +			continue;
> +
> +		clk_unregister_fixed_factor(clk_data->clks[ff->id]);
> +		clk_data->clks[ff->id] = ERR_PTR(-ENOENT);
>  	}
> +
> +	return PTR_ERR(clk);
>  }
>  EXPORT_SYMBOL_GPL(mtk_clk_register_factors);
>  
> @@ -258,13 +292,16 @@ static void mtk_clk_unregister_composite(struct
> clk *clk)
>  	kfree(mux);
>  }
>  
> -void mtk_clk_register_composites(const struct mtk_composite *mcs,
> -		int num, void __iomem *base, spinlock_t *lock,
> -		struct clk_onecell_data *clk_data)
> +int mtk_clk_register_composites(const struct mtk_composite *mcs, int
> num,
> +				void __iomem *base, spinlock_t *lock,
> +				struct clk_onecell_data *clk_data)
>  {
>  	struct clk *clk;
>  	int i;
>  
> +	if (!clk_data)
> +		return -ENOMEM;
> +
>  	for (i = 0; i < num; i++) {
>  		const struct mtk_composite *mc = &mcs[i];
>  
> @@ -275,12 +312,26 @@ void mtk_clk_register_composites(const struct
> mtk_composite *mcs,
>  
>  		if (IS_ERR(clk)) {
>  			pr_err("Failed to register clk %s: %pe\n", mc-
> >name, clk);
> -			continue;
> +			goto err;
>  		}
>  
> -		if (clk_data)
> -			clk_data->clks[mc->id] = clk;
> +		clk_data->clks[mc->id] = clk;
> +	}
> +
> +	return 0;
> +
> +err:
> +	while (--i >= 0) {
> +		const struct mtk_composite *mc = &mcs[i];
> +
> +		if (IS_ERR_OR_NULL(clk_data->clks[mcs->id]))
> +			continue;
> +
> +		mtk_clk_unregister_composite(clk_data->clks[mc->id]);
> +		clk_data->clks[mc->id] = ERR_PTR(-ENOENT);
>  	}
> +
> +	return PTR_ERR(clk);
>  }
>  EXPORT_SYMBOL_GPL(mtk_clk_register_composites);
>  
> @@ -304,17 +355,20 @@ void mtk_clk_unregister_composites(const struct
> mtk_composite *mcs, int num,
>  }
>  EXPORT_SYMBOL_GPL(mtk_clk_unregister_composites);
>  
> -void mtk_clk_register_dividers(const struct mtk_clk_divider *mcds,
> -			int num, void __iomem *base, spinlock_t *lock,
> -				struct clk_onecell_data *clk_data)
> +int mtk_clk_register_dividers(const struct mtk_clk_divider *mcds,
> int num,
> +			      void __iomem *base, spinlock_t *lock,
> +			      struct clk_onecell_data *clk_data)
>  {
>  	struct clk *clk;
>  	int i;
>  
> +	if (!clk_data)
> +		return -ENOMEM;
> +
>  	for (i = 0; i <  num; i++) {
>  		const struct mtk_clk_divider *mcd = &mcds[i];
>  
> -		if (clk_data && !IS_ERR_OR_NULL(clk_data->clks[mcd-
> >id]))
> +		if (!IS_ERR_OR_NULL(clk_data->clks[mcd->id]))
>  			continue;
>  
>  		clk = clk_register_divider(NULL, mcd->name, mcd-
> >parent_name,
> @@ -323,12 +377,26 @@ void mtk_clk_register_dividers(const struct
> mtk_clk_divider *mcds,
>  
>  		if (IS_ERR(clk)) {
>  			pr_err("Failed to register clk %s: %pe\n", mcd-
> >name, clk);
> -			continue;
> +			goto err;
>  		}
>  
> -		if (clk_data)
> -			clk_data->clks[mcd->id] = clk;
> +		clk_data->clks[mcd->id] = clk;
> +	}
> +
> +	return 0;
> +
> +err:
> +	while (--i >= 0) {
> +		const struct mtk_clk_divider *mcd = &mcds[i];
> +
> +		if (IS_ERR_OR_NULL(clk_data->clks[mcd->id]))
> +			continue;
> +
> +		mtk_clk_unregister_composite(clk_data->clks[mcd->id]);
> +		clk_data->clks[mcd->id] = ERR_PTR(-ENOENT);
>  	}
> +
> +	return PTR_ERR(clk);
>  }
>  
>  void mtk_clk_unregister_dividers(const struct mtk_clk_divider *mcds,
> int num,
> diff --git a/drivers/clk/mediatek/clk-mtk.h
> b/drivers/clk/mediatek/clk-mtk.h
> index 7f902581a115..bf6565aa7319 100644
> --- a/drivers/clk/mediatek/clk-mtk.h
> +++ b/drivers/clk/mediatek/clk-mtk.h
> @@ -34,8 +34,8 @@ struct mtk_fixed_clk {
>  		.rate = _rate,				\
>  	}
>  
> -void mtk_clk_register_fixed_clks(const struct mtk_fixed_clk *clks,
> int num,
> -				 struct clk_onecell_data *clk_data);
> +int mtk_clk_register_fixed_clks(const struct mtk_fixed_clk *clks,
> int num,
> +				struct clk_onecell_data *clk_data);
>  void mtk_clk_unregister_fixed_clks(const struct mtk_fixed_clk *clks,
> int num,
>  				   struct clk_onecell_data *clk_data);
>  
> @@ -55,8 +55,8 @@ struct mtk_fixed_factor {
>  		.div = _div,				\
>  	}
>  
> -void mtk_clk_register_factors(const struct mtk_fixed_factor *clks,
> int num,
> -			      struct clk_onecell_data *clk_data);
> +int mtk_clk_register_factors(const struct mtk_fixed_factor *clks,
> int num,
> +			     struct clk_onecell_data *clk_data);
>  void mtk_clk_unregister_factors(const struct mtk_fixed_factor *clks,
> int num,
>  				struct clk_onecell_data *clk_data);
>  
> @@ -150,9 +150,9 @@ struct mtk_composite {
>  struct clk *mtk_clk_register_composite(const struct mtk_composite
> *mc,
>  		void __iomem *base, spinlock_t *lock);
>  
> -void mtk_clk_register_composites(const struct mtk_composite *mcs,
> -		int num, void __iomem *base, spinlock_t *lock,
> -		struct clk_onecell_data *clk_data);
> +int mtk_clk_register_composites(const struct mtk_composite *mcs, int
> num,
> +				void __iomem *base, spinlock_t *lock,
> +				struct clk_onecell_data *clk_data);
>  void mtk_clk_unregister_composites(const struct mtk_composite *mcs,
> int num,
>  				   struct clk_onecell_data *clk_data);
>  
> @@ -178,9 +178,9 @@ struct mtk_clk_divider {
>  		.div_width = _width,				\
>  }
>  
> -void mtk_clk_register_dividers(const struct mtk_clk_divider *mcds,
> int num,
> -			       void __iomem *base, spinlock_t *lock,
> -			       struct clk_onecell_data *clk_data);
> +int mtk_clk_register_dividers(const struct mtk_clk_divider *mcds,
> int num,
> +			      void __iomem *base, spinlock_t *lock,
> +			      struct clk_onecell_data *clk_data);
>  void mtk_clk_unregister_dividers(const struct mtk_clk_divider *mcds,
> int num,
>  				 struct clk_onecell_data *clk_data);
>  

