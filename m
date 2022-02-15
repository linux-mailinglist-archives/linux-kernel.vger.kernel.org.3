Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA8A4B63EF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 08:05:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234697AbiBOHFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 02:05:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234690AbiBOHFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 02:05:35 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2730771C93;
        Mon, 14 Feb 2022 23:05:26 -0800 (PST)
X-UUID: 0c95046f90e142c3afecb40913d380a1-20220215
X-UUID: 0c95046f90e142c3afecb40913d380a1-20220215
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <chun-jie.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2031482880; Tue, 15 Feb 2022 15:05:24 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 15 Feb 2022 15:05:22 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 15 Feb 2022 15:05:22 +0800
Message-ID: <0ba7ab2a450546e7c920332a5a345396f3262f47.camel@mediatek.com>
Subject: Re: [PATCH v3 24/31] clk: mediatek: mux: Implement error handling
 in register API
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
Date:   Tue, 15 Feb 2022 15:05:22 +0800
In-Reply-To: <20220208124034.414635-25-wenst@chromium.org>
References: <20220208124034.414635-1-wenst@chromium.org>
         <20220208124034.414635-25-wenst@chromium.org>
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
> The mux clk type registration function does not stop or return errors
> if any clk failed to be registered, nor does it implement an error
> handling path. This may result in a partially working device if any
> step failed.
> 
> Make the register function return proper error codes, and bail out if
> errors occur. Proper cleanup, i.e. unregister any clks that were
> successfully registered, is done in the new error path.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> Reviewed-by: Miles Chen <miles.chen@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <
> angelogioacchino.delregno@collabora.com>

Reviewed-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> ---
>  drivers/clk/mediatek/clk-mux.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/mediatek/clk-mux.c
> b/drivers/clk/mediatek/clk-mux.c
> index 70aa42144632..f51e67650f03 100644
> --- a/drivers/clk/mediatek/clk-mux.c
> +++ b/drivers/clk/mediatek/clk-mux.c
> @@ -215,13 +215,26 @@ int mtk_clk_register_muxes(const struct mtk_mux
> *muxes,
>  
>  		if (IS_ERR(clk)) {
>  			pr_err("Failed to register clk %s: %pe\n", mux-
> >name, clk);
> -			continue;
> +			goto err;
>  		}
>  
>  		clk_data->clks[mux->id] = clk;
>  	}
>  
>  	return 0;
> +
> +err:
> +	while (--i >= 0) {
> +		const struct mtk_mux *mux = &muxes[i];
> +
> +		if (IS_ERR_OR_NULL(clk_data->clks[mux->id]))
> +			continue;
> +
> +		mtk_clk_unregister_mux(clk_data->clks[mux->id]);
> +		clk_data->clks[mux->id] = ERR_PTR(-ENOENT);
> +	}
> +
> +	return PTR_ERR(clk);
>  }
>  EXPORT_SYMBOL_GPL(mtk_clk_register_muxes);
>  

