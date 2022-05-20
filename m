Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2159452E492
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 07:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345661AbiETF5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 01:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344545AbiETF46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 01:56:58 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E154D625;
        Thu, 19 May 2022 22:56:53 -0700 (PDT)
X-UUID: 2f027c609e45441bb79b34e7bd7b33e8-20220520
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:ba3ede63-5d6f-44c3-86e4-b5e60af6369a,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:2a19b09,CLOUDID:fd48f779-5ef6-470b-96c9-bdb8ced32786,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:0,BEC:nil
X-UUID: 2f027c609e45441bb79b34e7bd7b33e8-20220520
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2111618802; Fri, 20 May 2022 13:56:48 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Fri, 20 May 2022 13:56:47 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 20 May 2022 13:56:46 +0800
Message-ID: <90dcce6722cc0904b777311e11b18d834730f01a.camel@mediatek.com>
Subject: Re: [PATCH 3/6] clk: mediatek: reset: Return reset data pointer on
 register
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     Yassine Oudjana <yassine.oudjana@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Miles Chen <miles.chen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        =?ISO-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <~postmarketos/upstreaming@lists.sr.ht>
Date:   Fri, 20 May 2022 13:56:47 +0800
In-Reply-To: <20220519134728.456643-4-y.oudjana@protonmail.com>
References: <20220519134728.456643-1-y.oudjana@protonmail.com>
         <20220519134728.456643-4-y.oudjana@protonmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-05-19 at 17:47 +0400, Yassine Oudjana wrote:
> From: Yassine Oudjana <y.oudjana@protonmail.com>
> 
> Return a struct mtk_clk_rst_data * when registering a reset
> controller in preparation for adding an unregister helper
> that will take it as an argument. Make the necessary changes
> in drivers that do not currently discard the return value
> of register functions.
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---
> Dependencies:
> - clk: mediatek: Move to struct clk_hw provider APIs (series)
>   
> https://urldefense.com/v3/__https://patchwork.kernel.org/project/linux-mediatek/cover/20220510104804.544597-1-wenst@chromium.org/__;!!CTRNKA9wMg0ARbw!1TS-6hbS7UPn08ETCuNFzymINPNyp_PlQ22cQbJVNp6vDRjgREzDVlLjvsmyN1YkE77G$ 
>  
> - Cleanup MediaTek clk reset drivers and support MT8192/MT8195
> (series)
>   
> https://urldefense.com/v3/__https://patchwork.kernel.org/project/linux-mediatek/cover/20220503093856.22250-1-rex-bc.chen@mediatek.com/__;!!CTRNKA9wMg0ARbw!1TS-6hbS7UPn08ETCuNFzymINPNyp_PlQ22cQbJVNp6vDRjgREzDVlLjvsmyNwSqs3wS$
>  
> - Export required symbols to compile clk drivers as module (single
> patch)
>   
> https://urldefense.com/v3/__https://patchwork.kernel.org/project/linux-mediatek/patch/20220518111652.223727-7-angelogioacchino.delregno@collabora.com/__;!!CTRNKA9wMg0ARbw!1TS-6hbS7UPn08ETCuNFzymINPNyp_PlQ22cQbJVNp6vDRjgREzDVlLjvsmyNwGDWf68$
>  
> 
>  drivers/clk/mediatek/clk-mt8192.c |  7 +++++--
>  drivers/clk/mediatek/clk-mtk.c    |  9 +++++---
>  drivers/clk/mediatek/reset.c      | 34 ++++++++++++++++-------------
> --
>  drivers/clk/mediatek/reset.h      | 14 +++++++------
>  4 files changed, 37 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/clk/mediatek/clk-mt8192.c
> b/drivers/clk/mediatek/clk-mt8192.c
> index ebbd2798d9a3..a658a74644de 100644
> --- a/drivers/clk/mediatek/clk-mt8192.c
> +++ b/drivers/clk/mediatek/clk-mt8192.c
> @@ -1255,6 +1255,7 @@ static int clk_mt8192_infra_probe(struct
> platform_device *pdev)
>  {
>  	struct clk_hw_onecell_data *clk_data;
>  	struct device_node *node = pdev->dev.of_node;
> +	struct mtk_clk_rst_data *rst_data;
>  	int r;
>  
>  	clk_data = mtk_alloc_clk_data(CLK_INFRA_NR_CLK);
> @@ -1265,9 +1266,11 @@ static int clk_mt8192_infra_probe(struct
> platform_device *pdev)
>  	if (r)
>  		goto free_clk_data;
>  
> -	r = mtk_register_reset_controller_with_dev(&pdev->dev,
> &clk_rst_desc);
> -	if (r)
> +	rst_data = mtk_register_reset_controller_with_dev(&pdev->dev,
> &clk_rst_desc);
> +	if (IS_ERR(rst_data)) {
> +		r = PTR_ERR(rst_data);
>  		goto free_clk_data;
> +	}
>  
>  	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get,
> clk_data);
>  	if (r)
> diff --git a/drivers/clk/mediatek/clk-mtk.c
> b/drivers/clk/mediatek/clk-mtk.c
> index 3a8875b6c37f..1b5591733e2b 100644
> --- a/drivers/clk/mediatek/clk-mtk.c
> +++ b/drivers/clk/mediatek/clk-mtk.c
> @@ -424,6 +424,7 @@ int mtk_clk_simple_probe(struct platform_device
> *pdev)
>  	const struct mtk_clk_desc *mcd;
>  	struct clk_hw_onecell_data *clk_data;
>  	struct device_node *node = pdev->dev.of_node;
> +	struct mtk_clk_rst_data *rst_data;
>  	int r;
>  
>  	mcd = of_device_get_match_data(&pdev->dev);
> @@ -446,10 +447,12 @@ int mtk_clk_simple_probe(struct platform_device
> *pdev)
>  	platform_set_drvdata(pdev, clk_data);
>  
>  	if (mcd->rst_desc) {
> -		r = mtk_register_reset_controller_with_dev(&pdev->dev,
> -							   mcd-
> >rst_desc);
> -		if (r)
> +		rst_data =
> mtk_register_reset_controller_with_dev(&pdev->dev,
> +							   	  mcd
> ->rst_desc);
> +		if (IS_ERR(rst_data)) {
> +			r = PTR_ERR(rst_data);
>  			goto unregister_clks;
> +		}
>  	}
>  
>  	return r;
> diff --git a/drivers/clk/mediatek/reset.c
> b/drivers/clk/mediatek/reset.c
> index 290ceda84ce4..09862baf1d57 100644
> --- a/drivers/clk/mediatek/reset.c
> +++ b/drivers/clk/mediatek/reset.c
> @@ -110,8 +110,9 @@ static int reset_xlate(struct
> reset_controller_dev *rcdev,
>  	return data->desc->rst_idx_map[reset_spec->args[0]];
>  }
>  
> -int mtk_register_reset_controller(struct device_node *np,
> -				  const struct mtk_clk_rst_desc *desc)
> +struct mtk_clk_rst_data
> +*mtk_register_reset_controller(struct device_node *np,
> +			       const struct mtk_clk_rst_desc *desc)
>  {
>  	struct regmap *regmap;
>  	const struct reset_control_ops *rcops = NULL;
> @@ -120,7 +121,7 @@ int mtk_register_reset_controller(struct
> device_node *np,
>  
>  	if (!desc) {
>  		pr_err("mtk clock reset desc is NULL\n");
> -		return -EINVAL;
> +		return ERR_PTR(-EINVAL);
>  	}
>  
>  	switch (desc->version) {
> @@ -132,18 +133,18 @@ int mtk_register_reset_controller(struct
> device_node *np,
>  		break;
>  	default:
>  		pr_err("Unknown reset version %d\n", desc->version);
> -		return -EINVAL;
> +		return ERR_PTR(-EINVAL);
>  	}
>  
>  	regmap = device_node_to_regmap(np);
>  	if (IS_ERR(regmap)) {
>  		pr_err("Cannot find regmap for %pOF: %pe\n", np,
> regmap);
> -		return -EINVAL;
> +		return ERR_PTR(-EINVAL);
>  	}
>  
>  	data = kzalloc(sizeof(*data), GFP_KERNEL);
>  	if (!data)
> -		return -ENOMEM;
> +		return ERR_PTR(-ENOMEM);
>  
>  	data->desc = desc;
>  	data->regmap = regmap;
> @@ -163,14 +164,15 @@ int mtk_register_reset_controller(struct
> device_node *np,
>  	if (ret) {
>  		pr_err("could not register reset controller: %d\n",
> ret);
>  		kfree(data);
> -		return ret;
> +		return ERR_PTR(ret);
>  	}
>  
> -	return 0;
> +	return data;
>  }
>  
> -int mtk_register_reset_controller_with_dev(struct device *dev,
> -					   const struct
> mtk_clk_rst_desc *desc)
> +struct mtk_clk_rst_data
> +*mtk_register_reset_controller_with_dev(struct device *dev,
> +					const struct mtk_clk_rst_desc
> *desc)
>  {
>  	struct device_node *np = dev->of_node;
>  	struct regmap *regmap;
> @@ -180,7 +182,7 @@ int mtk_register_reset_controller_with_dev(struct
> device *dev,
>  
>  	if (!desc) {
>  		dev_err(dev, "mtk clock reset desc is NULL\n");
> -		return -EINVAL;
> +		return ERR_PTR(-EINVAL);
>  	}
>  
>  	switch (desc->version) {
> @@ -192,18 +194,18 @@ int
> mtk_register_reset_controller_with_dev(struct device *dev,
>  		break;
>  	default:
>  		dev_err(dev, "Unknown reset version %d\n", desc-
> >version);
> -		return -EINVAL;
> +		return ERR_PTR(-EINVAL);
>  	}
>  
>  	regmap = device_node_to_regmap(np);
>  	if (IS_ERR(regmap)) {
>  		dev_err(dev, "Cannot find regmap %pe\n", regmap);
> -		return -EINVAL;
> +		return ERR_PTR(-EINVAL);
>  	}
>  
>  	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
>  	if (!data)
> -		return -ENOMEM;
> +		return ERR_PTR(-ENOMEM);
>  
>  	data->desc = desc;
>  	data->regmap = regmap;
> @@ -223,10 +225,10 @@ int
> mtk_register_reset_controller_with_dev(struct device *dev,
>  	ret = devm_reset_controller_register(dev, &data->rcdev);
>  	if (ret) {
>  		dev_err(dev, "could not register reset controller:
> %d\n", ret);
> -		return ret;
> +		return ERR_PTR(ret);
>  	}
>  
> -	return 0;
> +	return data;
>  }
>  EXPORT_SYMBOL_GPL(mtk_register_reset_controller_with_dev);
>  
> diff --git a/drivers/clk/mediatek/reset.h
> b/drivers/clk/mediatek/reset.h
> index 913fe676cba7..7418dd0d046f 100644
> --- a/drivers/clk/mediatek/reset.h
> +++ b/drivers/clk/mediatek/reset.h
> @@ -64,19 +64,21 @@ struct mtk_clk_rst_data {
>   * @np: Pointer to device node.
>   * @desc: Constant pointer to description of clock reset.
>   *
> - * Return: 0 on success and errorno otherwise.
> + * Return: Pointer to struct mtk_clk_rst_data on success and error
> pointer otherwise.
>   */
> -int mtk_register_reset_controller(struct device_node *np,
> -				  const struct mtk_clk_rst_desc *desc);
> +struct mtk_clk_rst_data
> +*mtk_register_reset_controller(struct device_node *np,
> +			       const struct mtk_clk_rst_desc *desc);
>  
>  /**
>   * mtk_register_reset_controller - Register mediatek clock reset
> controller with device
>   * @np: Pointer to device.
>   * @desc: Constant pointer to description of clock reset.
>   *
> - * Return: 0 on success and errorno otherwise.
> + * Return: Pointer to struct mtk_clk_rst_data on success and error
> pointer otherwise.
>   */
> -int mtk_register_reset_controller_with_dev(struct device *dev,
> -					   const struct
> mtk_clk_rst_desc *desc);
> +struct mtk_clk_rst_data
> +*mtk_register_reset_controller_with_dev(struct device *dev,
> +					const struct mtk_clk_rst_desc
> *desc);
>  
>  #endif /* __DRV_CLK_MTK_RESET_H */
> -- 
> 2.36.1
> 

Hello,

Stephen wants me to use  "auxiliary bus" in [1].
I am not sure why it didn't appear in lore, so I add the message.
I said I will find some time to do this after my reset cleanup series.
If so, I think we don't need to modify this in this time?

-----
Quoting Rex-BC Chen (2022-05-08 22:35:55)
> 
> The drivers of this series are reviewed.
> The binding of this series are also acked.
> Could you spare some time and give us some suggestion?

Have you considered using the auxiliary bus to split the Mediatek clk
and reset device up into a clk device and a reset device? The idea
would be to move the reset related code into drivers/reset and have the
clk code in drivers/clk. It's purely an organizational thing and it can
certainly be done later but it may be a good idea to do this to clearly
split out the two different functionalities.
-----

[1]:
https://lore.kernel.org/all/20220503093856.22250-1-rex-bc.chen@mediatek.com/

BRs,
Rex

