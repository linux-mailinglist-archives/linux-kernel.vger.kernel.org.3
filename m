Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B18F509BD2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 11:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387355AbiDUJLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 05:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387344AbiDUJKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 05:10:53 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54EBF23169;
        Thu, 21 Apr 2022 02:08:01 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 6F36F1F45276
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650532080;
        bh=b12S/GGfLM+hr9wK/Kd71hajyO38MEtI8nnnJ80yYtE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=kPrjkyumGDlUZvYYyc2UvX8vjPLZe/bwNGl5Km4Ya5MNPeQ1aRr1HfiYV0n2Nj59T
         7xn2w23N7m0oEIl8NVXR8w67DXmzlizmOtBd6+JkgrDOjjGK381HAQO0KJwfTXDuJs
         JxqxyPlrllgybpybDB8eYWmwJuR+sHL/NDxGNhptwMrhBJhPHZIwiSegY0p3Yri5XU
         97ShgEuIuUhSv3G1zPckAV2edbxsHCcFRes6LK1ehfvzu3djyPgztPEsmUOTAouxht
         TATNzmcIRPNoBdgj/yt9nKxrq/RVtZn5JBSW6Hq04domx5ipZh/cDvvoelLuhpFOug
         DZeEGCJfSHIuA==
Message-ID: <a2341eae-3a3a-ca26-8ce7-a4ba9219566c@collabora.com>
Date:   Thu, 21 Apr 2022 11:07:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH V2 04/12] clk: mediatek: reset: Merge and revise reset
 register function
Content-Language: en-US
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>, mturquette@baylibre.com,
        sboyd@kernel.org
Cc:     matthias.bgg@gmail.com, p.zabel@pengutronix.de,
        chun-jie.chen@mediatek.com, wenst@chromium.org,
        runyang.chen@mediatek.com, linux-kernel@vger.kernel.org,
        allen-kh.cheng@mediatek.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220420130527.23200-1-rex-bc.chen@mediatek.com>
 <20220420130527.23200-5-rex-bc.chen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220420130527.23200-5-rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 20/04/22 15:05, Rex-BC Chen ha scritto:
> Merge the reset register function of simple and set_clr into one function.
> - Input the version number to determine which version we will use.
> - Rename reset register function to "mtk_clk_register_rst_ctrl"
> 
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> ---
>   drivers/clk/mediatek/clk-mt2701-eth.c |  2 +-
>   drivers/clk/mediatek/clk-mt2701-g3d.c |  2 +-
>   drivers/clk/mediatek/clk-mt2701-hif.c |  2 +-
>   drivers/clk/mediatek/clk-mt2701.c     |  4 +--
>   drivers/clk/mediatek/clk-mt2712.c     |  4 +--
>   drivers/clk/mediatek/clk-mt7622-eth.c |  2 +-
>   drivers/clk/mediatek/clk-mt7622-hif.c |  4 +--
>   drivers/clk/mediatek/clk-mt7622.c     |  4 +--
>   drivers/clk/mediatek/clk-mt7629-eth.c |  2 +-
>   drivers/clk/mediatek/clk-mt7629-hif.c |  4 +--
>   drivers/clk/mediatek/clk-mt8135.c     |  4 +--
>   drivers/clk/mediatek/clk-mt8173.c     |  4 +--
>   drivers/clk/mediatek/clk-mt8183.c     |  3 ++-
>   drivers/clk/mediatek/clk-mtk.h        | 13 ++++++----
>   drivers/clk/mediatek/reset.c          | 35 ++++++++++++---------------
>   15 files changed, 44 insertions(+), 45 deletions(-)
> 

..snip..

> diff --git a/drivers/clk/mediatek/reset.c b/drivers/clk/mediatek/reset.c
> index 6574b19daf0f..8e42deee80a3 100644
> --- a/drivers/clk/mediatek/reset.c
> +++ b/drivers/clk/mediatek/reset.c
> @@ -65,14 +65,23 @@ static const struct reset_control_ops mtk_reset_ops_set_clr = {
>   	.reset = mtk_reset_set_clr,
>   };
>   
> -static void mtk_register_reset_controller_common(struct device_node *np,
> -			unsigned int num_regs, int regofs,
> -			const struct reset_control_ops *reset_ops)
> +static const struct reset_control_ops *rst_op[MTK_RST_MAX] = {
> +	[MTK_RST_SIMPLE] = &reset_simple_ops,
> +	[MTK_RST_SET_CLR] = &mtk_reset_ops_set_clr,
> +};

I don't think that we really need this to go to .rodata to get an improvement
in boot times in the order of nanoseconds....

> +
> +void mtk_clk_register_rst_ctrl(struct device_node *np,
> +			       u32 reg_num, u16 reg_ofs, u8 version)
>   {
>   	struct mtk_reset *data;
>   	int ret;
>   	struct regmap *regmap;
>   
> +	if (version >= MTK_RST_MAX) {
> +		pr_err("Error version number: %d\n", version);
> +		return;
> +	}
> +
>   	regmap = device_node_to_regmap(np);
>   	if (IS_ERR(regmap)) {
>   		pr_err("Cannot find regmap for %pOF: %pe\n", np, regmap);
> @@ -84,10 +93,10 @@ static void mtk_register_reset_controller_common(struct device_node *np,
>   		return;
>   
>   	data->regmap = regmap;
> -	data->regofs = regofs;
> +	data->regofs = reg_ofs;
>   	data->rcdev.owner = THIS_MODULE;
> -	data->rcdev.nr_resets = num_regs * 32;
> -	data->rcdev.ops = reset_ops;
> +	data->rcdev.nr_resets = reg_num * 32;
> +	data->rcdev.ops = rst_op[version];
>   	data->rcdev.of_node = np;

...hence, I would prefer to see something like:

	switch (version) {
	case MTK_RST_SIMPLE:
		data->rcdev.ops = &reset_simple_ops;
		break;
	case MTK_RST_SET_CLR:
		data->rcdev.ops = &mtk_reset_ops_set_clr;
		break;
	default:
		pr_err("Unknown reset version %d\n", version);
		return;
	}

Like that, you'd also replace that if branch at the beginning where you
do the reset version sanity check.
If you don't want to allocate a struct mtk_reset before running this switch,
you can also declare a `struct reset_control_ops *rcops = NULL;` locally and
then assign `data->rcdev.ops = rcops;` later: that would also be acceptable.

Cheers,
Angelo
