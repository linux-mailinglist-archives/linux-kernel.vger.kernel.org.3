Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62FA249C3E3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 07:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237217AbiAZGzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 01:55:36 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:34732 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S237124AbiAZGzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 01:55:35 -0500
X-UUID: b18902c3acc94a128f67bbf855fd1510-20220126
X-UUID: b18902c3acc94a128f67bbf855fd1510-20220126
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 788781598; Wed, 26 Jan 2022 14:55:33 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 26 Jan 2022 14:55:32 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 26 Jan 2022 14:55:32 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     <wenst@chromium.org>
CC:     <chun-jie.chen@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>
Subject: Re: [PATCH 15/31] clk: mediatek: Implement mtk_clk_unregister_fixed_clks() API
Date:   Wed, 26 Jan 2022 14:55:32 +0800
Message-ID: <20220126065532.22463-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220122091731.283592-16-wenst@chromium.org>
References: <20220122091731.283592-16-wenst@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> mtk_clk_register_fixed_clks(), as the name suggests, is used to register
> a given list of fixed rate clks. However it is lacking a counterpart
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
> index 0c5db3c71fdd..7c0d5706eed7 100644
> --- a/drivers/clk/mediatek/clk-mtk.c
> +++ b/drivers/clk/mediatek/clk-mtk.c
> @@ -80,6 +80,26 @@ void mtk_clk_register_fixed_clks(const struct mtk_fixed_clk *clks,
>  }
>  EXPORT_SYMBOL_GPL(mtk_clk_register_fixed_clks);
>  
> +void mtk_clk_unregister_fixed_clks(const struct mtk_fixed_clk *clks, int num,
> +				   struct clk_onecell_data *clk_data)
> +{
> +	int i;
> +
> +	if (!clk_data)
> +		return;
> +
> +	for (i = num; i > 0; i--) {
> +		const struct mtk_fixed_clk *rc = &clks[i - 1];
> +
> +		if (IS_ERR_OR_NULL(clk_data->clks[rc->id]))
> +			continue;
> +
> +		clk_unregister_fixed_rate(clk_data->clks[rc->id]);
> +		clk_data->clks[rc->id] = ERR_PTR(-ENOENT);
> +	}
> +}
> +EXPORT_SYMBOL_GPL(mtk_clk_unregister_fixed_clks);
> +
>  void mtk_clk_register_factors(const struct mtk_fixed_factor *clks,
>  		int num, struct clk_onecell_data *clk_data)
>  {
> diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
> index 168220f85489..cc7f920eabb4 100644
> --- a/drivers/clk/mediatek/clk-mtk.h
> +++ b/drivers/clk/mediatek/clk-mtk.h
> @@ -34,8 +34,10 @@ struct mtk_fixed_clk {
>  		.rate = _rate,				\
>  	}
>  
> -void mtk_clk_register_fixed_clks(const struct mtk_fixed_clk *clks,
> -		int num, struct clk_onecell_data *clk_data);
> +void mtk_clk_register_fixed_clks(const struct mtk_fixed_clk *clks, int num,
> +				 struct clk_onecell_data *clk_data);
> +void mtk_clk_unregister_fixed_clks(const struct mtk_fixed_clk *clks, int num,
> +				   struct clk_onecell_data *clk_data);
>  
>  struct mtk_fixed_factor {
>  	int id;
> -- 
> 2.35.0.rc0.227.g00780c9af4-goog


