Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D31E49C3EF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 07:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237450AbiAZG7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 01:59:03 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:56002 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231213AbiAZG7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 01:59:01 -0500
X-UUID: cb5c457e599f4c63a58b6a63c6ded947-20220126
X-UUID: cb5c457e599f4c63a58b6a63c6ded947-20220126
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2021312265; Wed, 26 Jan 2022 14:58:59 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 26 Jan 2022 14:58:58 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 26 Jan
 2022 14:58:57 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 26 Jan 2022 14:58:57 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     <wenst@chromium.org>
CC:     <chun-jie.chen@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>
Subject: Re: [PATCH 17/31] clk: mediatek: Implement mtk_clk_unregister_divider_clks() API
Date:   Wed, 26 Jan 2022 14:58:57 +0800
Message-ID: <20220126065857.24513-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220122091731.283592-18-wenst@chromium.org>
References: <20220122091731.283592-18-wenst@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> mtk_clk_register_divider_clks(), as the name suggests, is used to register
> a given list of divider clks. However it is lacking a counterpart
> unregister API.
> 
> Implement said unregister API so that the various clock platform drivers
> can utilize it to do proper unregistration, cleanup and removal.
> 
> In the header file, the register function's declaration is also
> reformatted to fit code style guidelines.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Reviewed-by: Miles Chen <miles.chen@mediatek.com>

> ---
>  drivers/clk/mediatek/clk-mtk.c | 19 +++++++++++++++++++
>  drivers/clk/mediatek/clk-mtk.h |  8 +++++---
>  2 files changed, 24 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
> index b267b2f04b84..3a6dfe445e63 100644
> --- a/drivers/clk/mediatek/clk-mtk.c
> +++ b/drivers/clk/mediatek/clk-mtk.c
> @@ -286,6 +286,25 @@ void mtk_clk_register_dividers(const struct mtk_clk_divider *mcds,
>  	}
>  }
>  
> +void mtk_clk_unregister_dividers(const struct mtk_clk_divider *mcds, int num,
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
> diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
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
> +void mtk_clk_register_dividers(const struct mtk_clk_divider *mcds, int num,
> +			       void __iomem *base, spinlock_t *lock,
> +			       struct clk_onecell_data *clk_data);
> +void mtk_clk_unregister_dividers(const struct mtk_clk_divider *mcds, int num,
> +				 struct clk_onecell_data *clk_data);
>  
>  struct clk_onecell_data *mtk_alloc_clk_data(unsigned int clk_num);
>  void mtk_free_clk_data(struct clk_onecell_data *clk_data);
> -- 
> 2.35.0.rc0.227.g00780c9af4-goog


