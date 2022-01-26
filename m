Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15CA049C4E6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 09:08:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238151AbiAZIIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 03:08:41 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:43536 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S238131AbiAZIIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 03:08:40 -0500
X-UUID: 4ca71b6cea074c898b00582c1f7c8774-20220126
X-UUID: 4ca71b6cea074c898b00582c1f7c8774-20220126
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2052481523; Wed, 26 Jan 2022 16:08:37 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 26 Jan 2022 16:08:36 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 26 Jan
 2022 16:08:36 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 26 Jan 2022 16:08:36 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     <wenst@chromium.org>
CC:     <chun-jie.chen@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>
Subject: Re: [PATCH 23/31] clk: mediatek: mux: Reverse check for existing clk to reduce nesting level
Date:   Wed, 26 Jan 2022 16:08:36 +0800
Message-ID: <20220126080836.1148-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220122091731.283592-24-wenst@chromium.org>
References: <20220122091731.283592-24-wenst@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The clk registration code here currently does:
> 
>     if (IS_ERR_OR_NULL(clk_data->clks[mux->id])) {
>             ... do clk registration ...
>     }
> 
> This extra level of nesting wastes screen real estate.
> 
> Reduce the nesting level by reversing the conditional shown above.
> Other than that, functionality is not changed.
>
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Reviewed-by: Miles Chen <miles.chen@mediatek.com>
> ---
>  drivers/clk/mediatek/clk-mux.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> Diff --git a/drivers/clk/mediatek/clk-mux.c b/drivers/clk/mediatek/clk-mux.c
> Index 01af6a52711a..70aa42144632 100644
> --- a/drivers/clk/mediatek/clk-mux.c
> +++ b/drivers/clk/mediatek/clk-mux.c
> @@ -208,16 +208,17 @@ int mtk_clk_register_muxes(const struct mtk_mux *muxes,
>  	for (i = 0; i < num; i++) {
>  		const struct mtk_mux *mux = &muxes[i];
>  
> -		if (IS_ERR_OR_NULL(clk_data->clks[mux->id])) {
> -			clk = mtk_clk_register_mux(mux, regmap, lock);
> +		if (!IS_ERR_OR_NULL(clk_data->clks[mux->id]))
> +			continue;
>  
> -			if (IS_ERR(clk)) {
> -				pr_err("Failed to register clk %s: %pe\n", mux->name, clk);
> -				continue;
> -			}
> +		clk = mtk_clk_register_mux(mux, regmap, lock);
>  
> -			clk_data->clks[mux->id] = clk;
> +		if (IS_ERR(clk)) {
> +			pr_err("Failed to register clk %s: %pe\n", mux->name, clk);
> +			continue;
>  		}
> +
> +		clk_data->clks[mux->id] = clk;
>  	}
>  
>  	return 0;
> -- 
> 2.35.0.rc0.227.g00780c9af4-goog


