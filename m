Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E07A4A81B0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 10:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349807AbiBCJr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 04:47:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236142AbiBCJr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 04:47:26 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE623C061714;
        Thu,  3 Feb 2022 01:47:25 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 4409D1F45304
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1643881644;
        bh=daIWMKQR9fyJ/RDFOrTuswHu7PdSrexQuHGnoAKw++c=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=jTGw1yY7hHVFiriNMrM0FW1RuIe1U71Lsmz+XODL2SlNv3W6tVR3T4kL/qPILp9ln
         px2CeaskYzwexlU+lUpLsUxeE6yrjmXOgQHS4QJcZE9qMUGDi5RGJPMGdVHct6VkzS
         yIEGNn7r2jG3NxdPQpW7TTkKwIgSOaT4VhYufyAYLtrShi3CG9U+9RzNAmEm2tRudC
         XFymb/f07RCN2x4PQInqY0OwU4vk3Qs+ZFJfdNxIM5dPn33woMDw2FyPLe2HUBM7qO
         N3FSF2mXUEWu7ivJ5sgVoGrKLEfDxHxIc5CZKClCPRpyTqIGns6P5QU3ZDe8jLZc6a
         rdbhiCJtNJRrQ==
Message-ID: <540b2d6f-b3eb-5e7a-67b1-65cc27abb511@collabora.com>
Date:   Thu, 3 Feb 2022 10:47:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v2 29/31] clk: mediatek: mt8195: Implement error handling
 in probe functions
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220202134834.690675-1-wenst@chromium.org>
 <20220202134834.690675-30-wenst@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220202134834.690675-30-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 02/02/22 14:48, Chen-Yu Tsai ha scritto:
> Until now the mediatek clk driver library did not have any way to
> unregister clks, and so all drivers did not do proper cleanup in
> their error paths.
> 
> Now that the library does have APIs to unregister clks, use them
> in the error path of the probe functions for the mt8195 clk drivers
> to do proper cleanup.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> Reviewed-by: Miles Chen <miles.chen@mediatek.com>
> ---
>   drivers/clk/mediatek/clk-mt8195-apmixedsys.c | 13 ++++--
>   drivers/clk/mediatek/clk-mt8195-apusys_pll.c | 11 ++++-
>   drivers/clk/mediatek/clk-mt8195-topckgen.c   | 49 +++++++++++++++-----
>   drivers/clk/mediatek/clk-mt8195-vdo0.c       |  4 +-
>   drivers/clk/mediatek/clk-mt8195-vdo1.c       |  4 +-
>   5 files changed, 63 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/clk/mediatek/clk-mt8195-apmixedsys.c b/drivers/clk/mediatek/clk-mt8195-apmixedsys.c
> index 5b1b7dc447eb..af8d80f25f30 100644
> --- a/drivers/clk/mediatek/clk-mt8195-apmixedsys.c
> +++ b/drivers/clk/mediatek/clk-mt8195-apmixedsys.c
> @@ -120,17 +120,24 @@ static int clk_mt8195_apmixed_probe(struct platform_device *pdev)
>   	if (!clk_data)
>   		return -ENOMEM;
>   
> -	mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls), clk_data);
> -	r = mtk_clk_register_gates(node, apmixed_clks, ARRAY_SIZE(apmixed_clks), clk_data);
> +	r = mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls), clk_data);
>   	if (r)
>   		goto free_apmixed_data;
>   
> +	r = mtk_clk_register_gates(node, apmixed_clks, ARRAY_SIZE(apmixed_clks), clk_data);
> +	if (r)
> +		goto unregister_plls;
> +
>   	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
>   	if (r)
> -		goto free_apmixed_data;
> +		goto unregister_gates;
>   
>   	return r;
>   
> +unregister_gates:
> +	mtk_clk_register_gates(node, apmixed_clks, ARRAY_SIZE(apmixed_clks), clk_data);
> +unregister_plls:
> +	mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls), clk_data);

You mean mtk_clk_*un*register_{gates,plls} here... please fix!



