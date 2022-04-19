Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81E64506908
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 12:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350774AbiDSKtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 06:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350746AbiDSKtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 06:49:25 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1500315A39;
        Tue, 19 Apr 2022 03:46:43 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 296241F41FED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650365201;
        bh=LnqSUtBwZPUm5/PXU0VqgPrbRkp9kCvPI/w5X2wzHus=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=G9OKdXqiTAz+yHzeqbtbvVkiPFzfq4QA7gORSLdSPj5OJvRicnapKQoQUQxBFs8BZ
         +LUJyL6sa7/TbIt7lmZBHWjjkpiVK9oQPGotYWlsCzXIm1VMdAd2WOM2aBggVDst/t
         mzYUH07wThjFVkdXSs3VK4xYUAnxdzZkwdDrqJ8nJ3wscr3JPdkML0FJNItrB20BOu
         unElsw3pC3F9eEbWI4fW9WcdFwZXBb4m0HD9Vbo3+mHWAxs+bDGSs/kadyXTZhCio5
         dNGVT4X/qcHAqHKNd4EnuWZNub1uoUavQ1kp39XK8ufUZpCkAUMxaRYzx0jqyhrSQ8
         uKGLiY+3VMrDg==
Message-ID: <dc4277ce-cf80-7176-a71f-cb9f93411086@collabora.com>
Date:   Tue, 19 Apr 2022 12:46:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 5/7] clk: mediatek: reset: Revise structure to control
 reset register
Content-Language: en-US
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>, mturquette@baylibre.com,
        sboyd@kernel.org
Cc:     matthias.bgg@gmail.com, p.zabel@pengutronix.de,
        chun-jie.chen@mediatek.com, wenst@chromium.org,
        yong.liang@mediatek.com, runyang.chen@mediatek.com,
        linux-kernel@vger.kernel.org, allen-kh.cheng@mediatek.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220418132154.7401-1-rex-bc.chen@mediatek.com>
 <20220418132154.7401-6-rex-bc.chen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220418132154.7401-6-rex-bc.chen@mediatek.com>
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

Il 18/04/22 15:21, Rex-BC Chen ha scritto:
> Replace the structure "struct mtk_reset" to reset.h, and rename it as
> "mtk_clk_rst_data". We use it to input the resset register data and
> store reset controller device.
> 
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> ---
>   drivers/clk/mediatek/clk-mt2701-eth.c |  9 +++-
>   drivers/clk/mediatek/clk-mt2701-g3d.c |  9 +++-
>   drivers/clk/mediatek/clk-mt2701-hif.c |  9 +++-
>   drivers/clk/mediatek/clk-mt2701.c     | 19 +++++++-
>   drivers/clk/mediatek/clk-mt2712.c     | 19 +++++++-
>   drivers/clk/mediatek/clk-mt7622-eth.c |  9 +++-
>   drivers/clk/mediatek/clk-mt7622-hif.c | 19 +++++++-
>   drivers/clk/mediatek/clk-mt7622.c     | 19 +++++++-
>   drivers/clk/mediatek/clk-mt7629-eth.c |  9 +++-
>   drivers/clk/mediatek/clk-mt7629-hif.c | 19 +++++++-
>   drivers/clk/mediatek/clk-mt8135.c     | 19 +++++++-
>   drivers/clk/mediatek/clk-mt8173.c     | 19 +++++++-
>   drivers/clk/mediatek/clk-mt8183.c     | 10 ++++-
>   drivers/clk/mediatek/reset.c          | 62 +++++++++++++--------------
>   drivers/clk/mediatek/reset.h          | 12 +++++-
>   15 files changed, 209 insertions(+), 53 deletions(-)
> 
> diff --git a/drivers/clk/mediatek/clk-mt2701-eth.c b/drivers/clk/mediatek/clk-mt2701-eth.c
> index 71257714e6a6..16fc4a50d513 100644
> --- a/drivers/clk/mediatek/clk-mt2701-eth.c
> +++ b/drivers/clk/mediatek/clk-mt2701-eth.c
> @@ -36,6 +36,13 @@ static const struct mtk_gate eth_clks[] = {
>   	GATE_ETH(CLK_ETHSYS_CRYPTO, "crypto_clk", "ethif_sel", 29),
>   };
>   
> +static struct mtk_clk_rst_data clk_rst_data = {

static const struct mtk_clk_rst_data clk_rst_data[] = {

...because this is initialization data that is never supposed to change, and
in the init function of reset.c, you should never modify this struct.

> +	.supported = true,

It would make no sense to call mtk_clk_register_rst_ctrl() if the resets
are not supported, so this .supported member is useless and should be
removed.

I will avoid commenting on patch 7/7 and will say it here: I know that on that
patch you're checking for this one but, especially if this reset data becomes a
const you can, at that point, simply check if anything has been assigned to it
so that if it's not NULL, we implicitly know that said clock controller instance
supports resets, and we register them:

int mtk_clk_simple_probe(...)
{
	.. blah blah ..

	if (mcd->rst)
		r = mtk_clk_register_rst_ctrl(....)
	return r;
}


> +	.version = MTK_RST_V1,
> +	.reg_num = 1,
> +	.reg_ofs = 0x34,
> +};
> +
>   static const struct of_device_id of_match_clk_mt2701_eth[] = {
>   	{ .compatible = "mediatek,mt2701-ethsys", },
>   	{}

..snip..

> diff --git a/drivers/clk/mediatek/clk-mt2701.c b/drivers/clk/mediatek/clk-mt2701.c
> index c1100a20c7ed..a8ac3d11ced6 100644
> --- a/drivers/clk/mediatek/clk-mt2701.c
> +++ b/drivers/clk/mediatek/clk-mt2701.c
> @@ -735,6 +735,21 @@ static const struct mtk_fixed_factor infra_fixed_divs[] = {
>   	FACTOR(CLK_INFRA_CLK_13M, "clk13m", "clk26m", 1, 2),
>   };
>   

For increased readability, perhaps it's a good idea to do something like...

> +static struct mtk_clk_rst_data clk_rst_data[] = {
> +	{
	{	/* infrasys */

> +		.supported = true,
> +		.version = MTK_RST_V1,
> +		.reg_num = 2,
> +		.reg_ofs = 0x30,
> +	},

	{	/* pericfg */

> +	{
> +		.supported = true,
> +		.version = MTK_RST_V1,
> +		.reg_num = 2,
> +		.reg_ofs = 0x0,
> +	},
> +};
> +
>   static struct clk_onecell_data *infra_clk_data;
>   
>   static void __init mtk_infrasys_init_early(struct device_node *node)

..snip...

> diff --git a/drivers/clk/mediatek/clk-mt7622-hif.c b/drivers/clk/mediatek/clk-mt7622-hif.c
> index 6be894299ae3..a10ecc5b88a1 100644
> --- a/drivers/clk/mediatek/clk-mt7622-hif.c
> +++ b/drivers/clk/mediatek/clk-mt7622-hif.c
> @@ -76,6 +76,21 @@ static const struct mtk_gate pcie_clks[] = {
>   	GATE_PCIE(CLK_SATA_PM_EN, "sata_pm_en", "univpll2_d4", 30),
>   };
>   
> +static struct mtk_clk_rst_data clk_rst_data[] = {
> +	{
> +		.supported = true,
> +		.version = MTK_RST_V1,
> +		.reg_num = 1,
> +		.reg_ofs = 0x34,
> +	},

I get that the intention here is to separate the reset data between ssusbsys
and pciesys, but both entries are declaring the exact same... since (as pointed out
earlier) this should be a const, you can use the same entry for both.

> +	{
> +		.supported = true,
> +		.version = MTK_RST_V1,
> +		.reg_num = 1,
> +		.reg_ofs = 0x34,
> +	},
> +};
> +
>   static int clk_mt7622_ssusbsys_init(struct platform_device *pdev)
>   {
>   	struct clk_onecell_data *clk_data;

..snip..


> diff --git a/drivers/clk/mediatek/reset.c b/drivers/clk/mediatek/reset.c
> index 2a55e8bf6b28..709ae54efc18 100644
> --- a/drivers/clk/mediatek/reset.c
> +++ b/drivers/clk/mediatek/reset.c

..snip..

> @@ -117,21 +123,15 @@ int mtk_clk_register_rst_ctrl(struct device_node *np,
>   		return -EINVAL;
>   	}
>   
> -	data = kzalloc(sizeof(*data), GFP_KERNEL);
> -	if (!data)
> -		return -ENOMEM;
> -
> -	data->regmap = regmap;
> -	data->regofs = reg_ofs;
> -	data->rcdev.owner = THIS_MODULE;
> -	data->rcdev.nr_resets = reg_num * 32;
> -	data->rcdev.ops = rst_op[version];
> -	data->rcdev.of_node = np;


Here's a cleaner version of this:

int mtk_clk_register_rst_ctrl(struct device *dev,
			      const struct mtk_clk_rst_desc *rst_desc)
{
	....some code....

	struct mtk_reset_data *mtk_reset;

	mtk_reset = devm_kzalloc(dev, sizeof(*mtk_reset), GFP_KERNEL)
	if (!mtk_reset)
		return -ENOMEM;

	mtk_reset->desc = rst_desc;
	mtk_reset->regmap = regmap;
	mtk_reset->rcdev.owner = .... blah blah

	ret = devm_reset_controller_register(dev, &mtk_reset->rcdev);
	if (ret)
		return ret;

....so if you use the devm_* variant, you don't need patch 6/7, as unregistering
the reset controller will be taken care of by devm actions.

Besides, this is most probably not the case but remember that if you need to
perform more operations to unregister this reset controller, you can always
add a custom devm action with function devm_add_action_or_reset(dev, func, parm).


> +	clk_rst->regmap = regmap;
> +	clk_rst->rcdev.owner = THIS_MODULE;
> +	clk_rst->rcdev.nr_resets = clk_rst->reg_num * 32;
> +	clk_rst->rcdev.ops = rst_op[clk_rst->version];
> +	clk_rst->rcdev.of_node = np;
>   
> -	ret = reset_controller_register(&data->rcdev);
> +	ret = reset_controller_register(&clk_rst->rcdev);
>   	if (ret) {
>   		pr_err("could not register reset controller: %d\n", ret);
> -		kfree(data);
>   		return -EINVAL;
>   	}
>   
> diff --git a/drivers/clk/mediatek/reset.h b/drivers/clk/mediatek/reset.h
> index 0af77531b918..851a29c92440 100644
> --- a/drivers/clk/mediatek/reset.h
> +++ b/drivers/clk/mediatek/reset.h
> @@ -6,6 +6,7 @@
>   #ifndef __DRV_CLK_MTK_RESET_H
>   #define __DRV_CLK_MTK_RESET_H
>   
> +#include <linux/reset-controller.h>
>   #include <linux/types.h>
>   
>   enum mtk_reset_version {
> @@ -14,7 +15,16 @@ enum mtk_reset_version {
>   	MTK_RST_MAX,
>   };
>   
> +struct mtk_clk_rst_data {
> +	struct reset_controller_dev rcdev;
> +	struct regmap *regmap;
> +	bool supported;
> +	u8 version;
> +	u32 reg_num;
> +	u16 reg_ofs;
> +};

...so here you'd have something like:

struct mtk_clk_rst_desc {
	u8 version;
	u32 reg_num;
	u16 reg_ofs;
};

struct mtk_reset_data {
	struct regmap *regmap;
	struct reset_controller_dev rcdev;
	const struct mtk_clk_rst_desc *desc;
};


Cheers,
Angelo

