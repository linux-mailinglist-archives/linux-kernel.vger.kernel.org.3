Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8391B49C3E8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 07:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237424AbiAZG5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 01:57:02 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:51494 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S237299AbiAZG47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 01:56:59 -0500
X-UUID: 170623d6002f4a4b8a7a774e26ed8423-20220126
X-UUID: 170623d6002f4a4b8a7a774e26ed8423-20220126
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1320218509; Wed, 26 Jan 2022 14:56:55 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 26 Jan 2022 14:56:54 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 26 Jan 2022 14:56:54 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     <wenst@chromium.org>
CC:     <chun-jie.chen@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>
Subject: Re: [PATCH 16/31] clk: mediatek: Implement mtk_clk_unregister_factors() API
Date:   Wed, 26 Jan 2022 14:56:54 +0800
Message-ID: <20220126065654.23309-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220122091731.283592-17-wenst@chromium.org>
References: <20220122091731.283592-17-wenst@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> mtk_clk_register_factors(), as the name suggests, is used to register
> a given list of fixed factor clks. However it is lacking a counterpart
> unregister API.
> 
> Implement said unregister API so that the various clock platform drivers
> can utilize it to do proper unregistration, cleanup and removal.
> 
> In the header file, the register function's declaration is also
> reformatted to fit code style guidelines.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
>
Reviewed-by: Miles Chen <miles.chen@mediatek.com>
> ---
>  drivers/clk/mediatek/clk-mtk.c | 20 ++++++++++++++++++++
>  drivers/clk/mediatek/clk-mtk.h |  6 ++++--
>  2 files changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
> index 7c0d5706eed7..b267b2f04b84 100644
> --- a/drivers/clk/mediatek/clk-mtk.c
> +++ b/drivers/clk/mediatek/clk-mtk.c
> @@ -126,6 +126,26 @@ void mtk_clk_register_factors(const struct mtk_fixed_factor *clks,
>  }
>  EXPORT_SYMBOL_GPL(mtk_clk_register_factors);
>  
> +void mtk_clk_unregister_factors(const struct mtk_fixed_factor *clks, int num,
> +				struct clk_onecell_data *clk_data)
> +{
> +	int i;
> +
> +	if (!clk_data)
> +		return;
> +
> +	for (i = num; i > 0; i--) {
> +		const struct mtk_fixed_factor *ff = &clks[i - 1];
> +
> +		if (IS_ERR_OR_NULL(clk_data->clks[ff->id]))
> +			continue;
> +
> +		clk_unregister_fixed_factor(clk_data->clks[ff->id]);
> +		clk_data->clks[ff->id] = ERR_PTR(-ENOENT);
> +	}
> +}
> +EXPORT_SYMBOL_GPL(mtk_clk_unregister_factors);
> +
>  struct clk *mtk_clk_register_composite(const struct mtk_composite *mc,
>  		void __iomem *base, spinlock_t *lock)
>  {
> diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
> index cc7f920eabb4..4db1a97c1250 100644
> --- a/drivers/clk/mediatek/clk-mtk.h
> +++ b/drivers/clk/mediatek/clk-mtk.h
> @@ -55,8 +55,10 @@ struct mtk_fixed_factor {
>  		.div = _div,				\
>  	}
>  
> -void mtk_clk_register_factors(const struct mtk_fixed_factor *clks,
> -		int num, struct clk_onecell_data *clk_data);
> +void mtk_clk_register_factors(const struct mtk_fixed_factor *clks, int num,
> +			      struct clk_onecell_data *clk_data);
> +void mtk_clk_unregister_factors(const struct mtk_fixed_factor *clks, int num,
> +				struct clk_onecell_data *clk_data);
>  
>  struct mtk_composite {
>  	int id;
> -- 
> 2.35.0.rc0.227.g00780c9af4-goog


