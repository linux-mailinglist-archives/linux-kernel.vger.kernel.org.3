Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC1C49C50F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 09:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238267AbiAZIQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 03:16:59 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:55210 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230117AbiAZIQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 03:16:58 -0500
X-UUID: b4fc01865b32476bbb4c0505c215f4ae-20220126
X-UUID: b4fc01865b32476bbb4c0505c215f4ae-20220126
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1623290798; Wed, 26 Jan 2022 16:16:55 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 26 Jan 2022 16:16:54 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 26 Jan 2022 16:16:54 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     <wenst@chromium.org>
CC:     <chun-jie.chen@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>
Subject: Re: [PATCH 26/31] clk: mediatek: mtk: Implement error handling in register APIs
Date:   Wed, 26 Jan 2022 16:16:54 +0800
Message-ID: <20220126081654.5988-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220122091731.283592-27-wenst@chromium.org>
References: <20220122091731.283592-27-wenst@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The remaining clk registration functions do not stop or return errors
> if any clk failed to be registered, nor do they implement error
> handling paths. This may result in a partially working device if any
> step fails.
> 
> Make the register functions return proper error codes, and bail out if
> errors occur. Proper cleanup, i.e. unregister any clks that were
> successfully registered, is done in the new error path.
> 
> This also makes the |struct clk_data *| argument mandatory, as it is
> used to track the list of clks registered.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Reviewed-by: Miles Chen <miles.chen@mediatek.com>

> ---
>  drivers/clk/mediatek/clk-mtk.c | 118 ++++++++++++++++++++++++++-------
>  drivers/clk/mediatek/clk-mtk.h |  20 +++---
>  2 files changed, 103 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
> index d2c50186cceb..e1977c8e130a 100644
> --- a/drivers/clk/mediatek/clk-mtk.c
> +++ b/drivers/clk/mediatek/clk-mtk.c
> @@ -53,16 +53,19 @@ void mtk_free_clk_data(struct clk_onecell_data *clk_data)
>  	kfree(clk_data);
>  }
>  
> -void mtk_clk_register_fixed_clks(const struct mtk_fixed_clk *clks,
> -		int num, struct clk_onecell_data *clk_data)
> +int mtk_clk_register_fixed_clks(const struct mtk_fixed_clk *clks, int num,
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
> -		if (clk_data && !IS_ERR_OR_NULL(clk_data->clks[rc->id]))
> +		if (!IS_ERR_OR_NULL(clk_data->clks[rc->id]))
>  			continue;
>  
>  		clk = clk_register_fixed_rate(NULL, rc->name, rc->parent, 0,
> @@ -70,12 +73,26 @@ void mtk_clk_register_fixed_clks(const struct mtk_fixed_clk *clks,
>  
>  		if (IS_ERR(clk)) {
>  			pr_err("Failed to register clk %s: %pe\n", rc->name, clk);
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
> @@ -99,16 +116,19 @@ void mtk_clk_unregister_fixed_clks(const struct mtk_fixed_clk *clks, int num,
>  }
>  EXPORT_SYMBOL_GPL(mtk_clk_unregister_fixed_clks);
>  
> -void mtk_clk_register_factors(const struct mtk_fixed_factor *clks,
> -		int num, struct clk_onecell_data *clk_data)
> +int mtk_clk_register_factors(const struct mtk_fixed_factor *clks, int num,
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
> -		if (clk_data && !IS_ERR_OR_NULL(clk_data->clks[ff->id]))
> +		if (!IS_ERR_OR_NULL(clk_data->clks[ff->id]))
>  			continue;
>  
>  		clk = clk_register_fixed_factor(NULL, ff->name, ff->parent_name,
> @@ -116,12 +136,26 @@ void mtk_clk_register_factors(const struct mtk_fixed_factor *clks,
>  
>  		if (IS_ERR(clk)) {
>  			pr_err("Failed to register clk %s: %pe\n", ff->name, clk);
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
> @@ -253,13 +287,16 @@ static void mtk_clk_unregister_composite(struct clk *clk)
>  	kfree(mux);
>  }
>  
> -void mtk_clk_register_composites(const struct mtk_composite *mcs,
> -		int num, void __iomem *base, spinlock_t *lock,
> -		struct clk_onecell_data *clk_data)
> +int mtk_clk_register_composites(const struct mtk_composite *mcs, int num,
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
> @@ -270,12 +307,26 @@ void mtk_clk_register_composites(const struct mtk_composite *mcs,
>  
>  		if (IS_ERR(clk)) {
>  			pr_err("Failed to register clk %s: %pe\n", mc->name, clk);
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
> @@ -299,17 +350,20 @@ void mtk_clk_unregister_composites(const struct mtk_composite *mcs, int num,
>  }
>  EXPORT_SYMBOL_GPL(mtk_clk_unregister_composites);
>  
> -void mtk_clk_register_dividers(const struct mtk_clk_divider *mcds,
> -			int num, void __iomem *base, spinlock_t *lock,
> -				struct clk_onecell_data *clk_data)
> +int mtk_clk_register_dividers(const struct mtk_clk_divider *mcds, int num,
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
> -		if (clk_data && !IS_ERR_OR_NULL(clk_data->clks[mcd->id]))
> +		if (!IS_ERR_OR_NULL(clk_data->clks[mcd->id]))
>  			continue;
>  
>  		clk = clk_register_divider(NULL, mcd->name, mcd->parent_name,
> @@ -318,12 +372,26 @@ void mtk_clk_register_dividers(const struct mtk_clk_divider *mcds,
>  
>  		if (IS_ERR(clk)) {
>  			pr_err("Failed to register clk %s: %pe\n", mcd->name, clk);
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
>  void mtk_clk_unregister_dividers(const struct mtk_clk_divider *mcds, int num,
> diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
> index 7f902581a115..bf6565aa7319 100644
> --- a/drivers/clk/mediatek/clk-mtk.h
> +++ b/drivers/clk/mediatek/clk-mtk.h
> @@ -34,8 +34,8 @@ struct mtk_fixed_clk {
>  		.rate = _rate,				\
>  	}
>  
> -void mtk_clk_register_fixed_clks(const struct mtk_fixed_clk *clks, int num,
> -				 struct clk_onecell_data *clk_data);
> +int mtk_clk_register_fixed_clks(const struct mtk_fixed_clk *clks, int num,
> +				struct clk_onecell_data *clk_data);
>  void mtk_clk_unregister_fixed_clks(const struct mtk_fixed_clk *clks, int num,
>  				   struct clk_onecell_data *clk_data);
>  
> @@ -55,8 +55,8 @@ struct mtk_fixed_factor {
>  		.div = _div,				\
>  	}
>  
> -void mtk_clk_register_factors(const struct mtk_fixed_factor *clks, int num,
> -			      struct clk_onecell_data *clk_data);
> +int mtk_clk_register_factors(const struct mtk_fixed_factor *clks, int num,
> +			     struct clk_onecell_data *clk_data);
>  void mtk_clk_unregister_factors(const struct mtk_fixed_factor *clks, int num,
>  				struct clk_onecell_data *clk_data);
>  
> @@ -150,9 +150,9 @@ struct mtk_composite {
>  struct clk *mtk_clk_register_composite(const struct mtk_composite *mc,
>  		void __iomem *base, spinlock_t *lock);
>  
> -void mtk_clk_register_composites(const struct mtk_composite *mcs,
> -		int num, void __iomem *base, spinlock_t *lock,
> -		struct clk_onecell_data *clk_data);
> +int mtk_clk_register_composites(const struct mtk_composite *mcs, int num,
> +				void __iomem *base, spinlock_t *lock,
> +				struct clk_onecell_data *clk_data);
>  void mtk_clk_unregister_composites(const struct mtk_composite *mcs, int num,
>  				   struct clk_onecell_data *clk_data);
>  
> @@ -178,9 +178,9 @@ struct mtk_clk_divider {
>  		.div_width = _width,				\
>  }
>  
> -void mtk_clk_register_dividers(const struct mtk_clk_divider *mcds, int num,
> -			       void __iomem *base, spinlock_t *lock,
> -			       struct clk_onecell_data *clk_data);
> +int mtk_clk_register_dividers(const struct mtk_clk_divider *mcds, int num,
> +			      void __iomem *base, spinlock_t *lock,
> +			      struct clk_onecell_data *clk_data);
>  void mtk_clk_unregister_dividers(const struct mtk_clk_divider *mcds, int num,
>  				 struct clk_onecell_data *clk_data);
>  
> -- 
> 2.35.0.rc0.227.g00780c9af4-goog
> 

