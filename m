Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D48BA530DDB
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 12:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233796AbiEWKEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 06:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233679AbiEWKEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 06:04:43 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B22E4DE2;
        Mon, 23 May 2022 03:04:41 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 695421F41C08
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653300280;
        bh=nikwer9gVP1aMdWQqAPZU00MWdHcjPiQkcZmJpOI/6c=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=P7YTLX+Ym2FYe6eT9rDUdd8ETIPiIiYCbk00+vqVPBQtImH8hKHshZE/5KaFgW7Dq
         GloerK1d+zp5JuMNh3T+Z12lQNImk3xXtm4tSHjd1o5swfkAUyhztOu1cPGkMQQ2cK
         jecf4h2mzW29htMQYH1G42J4czNU3mvWlo49snE4tzvbOFqrQgKG//CkknAS7mr1mK
         DEDCkQTFIR7jPt8owr4oRvRmIeEv2Xt02dLr57SKdE7zz+kd2Cd+wmDOQE9+KUvU69
         TagWWRwuK470WQHtltpIUsHTLcJ2YpC9hDcJ5OfYZdZuxg3M8oSGKlxOlr9/7vGbUb
         kLl+OL6aZcglw==
Message-ID: <f6cd735b-2ba4-7456-684d-b20f0b46effe@collabora.com>
Date:   Mon, 23 May 2022 12:04:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2 3/4] clk: mediatek: mux: add clk notifier functions
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220523085923.1430470-1-wenst@chromium.org>
 <20220523085923.1430470-4-wenst@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220523085923.1430470-4-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 23/05/22 10:59, Chen-Yu Tsai ha scritto:
> With device frequency scaling, the mux clock that (indirectly) feeds the
> device selects between a dedicated PLL, and some other stable clocks.
> 
> When a clk rate change is requested, the (normally) upstream PLL is
> reconfigured. It's possible for the clock output of the PLL to become
> unstable during this process.
> 
> To avoid causing the device to glitch, the mux should temporarily be
> switched over to another "stable" clock during the PLL rate change.
> This is done with clk notifiers.
> 
> This patch adds common functions for notifiers to temporarily and
> transparently reparent mux clocks.
> 
> This was loosely based on commit 8adfb08605a9 ("clk: sunxi-ng: mux: Add
> clk notifier functions").
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
>   drivers/clk/mediatek/clk-mux.c | 42 ++++++++++++++++++++++++++++++++++
>   drivers/clk/mediatek/clk-mux.h | 15 ++++++++++++
>   2 files changed, 57 insertions(+)
> 
> diff --git a/drivers/clk/mediatek/clk-mux.c b/drivers/clk/mediatek/clk-mux.c
> index cd5f9fd8cb98..f84a5a753c09 100644
> --- a/drivers/clk/mediatek/clk-mux.c
> +++ b/drivers/clk/mediatek/clk-mux.c
> @@ -4,6 +4,7 @@
>    * Author: Owen Chen <owen.chen@mediatek.com>
>    */
>   
> +#include <linux/clk.h>
>   #include <linux/clk-provider.h>
>   #include <linux/compiler_types.h>
>   #include <linux/container_of.h>
> @@ -259,4 +260,45 @@ void mtk_clk_unregister_muxes(const struct mtk_mux *muxes, int num,
>   }
>   EXPORT_SYMBOL_GPL(mtk_clk_unregister_muxes);
>   
> +/*
> + * This clock notifier is called when the frequency of the of the parent
> + * PLL clock is to be changed. The idea is to switch the parent to a
> + * stable clock, such as the main oscillator, while the PLL frequency
> + * stabilizes.
> + */
> +static int mtk_clk_mux_notifier_cb(struct notifier_block *nb,
> +				   unsigned long event, void *_data)
> +{
> +	struct clk_notifier_data *data = _data;
> +	struct mtk_mux_nb *mux_nb = to_mtk_mux_nb(nb);
> +	const struct mtk_mux *mux = mux_nb->mux;
> +	struct clk_hw *hw;
> +	int ret = 0;
> +
> +	hw = __clk_get_hw(data->clk);
> +
> +	switch (event) {
> +	case PRE_RATE_CHANGE:
> +		mux_nb->original_index = mux->ops->get_parent(hw);
> +		ret = mux->ops->set_parent(hw, mux_nb->bypass_index);
> +		break;
> +
> +	case POST_RATE_CHANGE:
> +	case ABORT_RATE_CHANGE:

I agree with this change, entirely - but there's an issue here.
If we enter ABORT_RATE_CHANGE, this means that "something has failed": now,
what if the failure point was the PLL being unable to lock?

In that case, we would switch the parent back to a PLL that's not outputting
any clock, crashing the GPU, or a bogus rate, potentially undervolting the GPU.

I think that the best idea here would be to do something like..

	switch (event) {
	case PRE_RATE_CHANGE:
		mux_nb->old_parent_idx = mux->ops->get_parent(hw);
		ret = mux->ops->set_parent(hw, mux_nb->safe_parent_idx);
		break;
	case POST_RATE_CHANGE:
		ret = mux->ops->set_parent(hw, mux_nb->old_parent_idx);
		break;
	case ABORT_RATE_CHANGE:
		ret = -EINVAL; /* or -ECANCELED, whatever... */
		break;
	}

> +		ret = mux->ops->set_parent(hw, mux_nb->original_index);
> +		break;
> +	}
> +
> +	return notifier_from_errno(ret);
> +}
> +
> +int devm_mtk_clk_mux_notifier_register(struct device *dev, struct clk *clk,
> +				       struct mtk_mux_nb *mux_nb)
> +{
> +	mux_nb->nb.notifier_call = mtk_clk_mux_notifier_cb;
> +
> +	return devm_clk_notifier_register(dev, clk, &mux_nb->nb);
> +}
> +EXPORT_SYMBOL_GPL(devm_mtk_clk_mux_notifier_register);
> +
>   MODULE_LICENSE("GPL");
> diff --git a/drivers/clk/mediatek/clk-mux.h b/drivers/clk/mediatek/clk-mux.h
> index 6539c58f5d7d..506e91125a3d 100644
> --- a/drivers/clk/mediatek/clk-mux.h
> +++ b/drivers/clk/mediatek/clk-mux.h
> @@ -7,12 +7,14 @@
>   #ifndef __DRV_CLK_MTK_MUX_H
>   #define __DRV_CLK_MTK_MUX_H
>   
> +#include <linux/notifier.h>
>   #include <linux/spinlock.h>
>   #include <linux/types.h>
>   
>   struct clk;
>   struct clk_hw_onecell_data;
>   struct clk_ops;
> +struct device;
>   struct device_node;
>   
>   struct mtk_mux {
> @@ -89,4 +91,17 @@ int mtk_clk_register_muxes(const struct mtk_mux *muxes,
>   void mtk_clk_unregister_muxes(const struct mtk_mux *muxes, int num,
>   			      struct clk_hw_onecell_data *clk_data);
>   
> +struct mtk_mux_nb {
> +	struct notifier_block	nb;
> +	const struct mtk_mux	*mux;
> +
> +	u8	bypass_index;	/* Which parent to temporarily use */
> +	u8	original_index;	/* Set by notifier callback */

I think that the following names are more explanatory:

	u8	safe_parent_idx;
	u8	old_parent_idx;

...because I see this as a mechanism to switch the mux to a "safe" clock output
and then back to the PLL (like it's done on some qcom clocks as well).

You're free to ignore this comment, as this is, of course, just a personal opinion.

Cheers,
Angelo


