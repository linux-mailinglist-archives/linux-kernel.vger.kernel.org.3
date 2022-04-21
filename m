Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61A80509BCA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 11:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387325AbiDUJKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 05:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387297AbiDUJKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 05:10:38 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5FE32315D;
        Thu, 21 Apr 2022 02:07:48 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id DB0591F45279
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650532067;
        bh=tb++htDWk/P/kh+yJkp0hPfRxlrxeXi4tKHeB0AnpV0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=n84OI35RxbQy50D/JAZvFas9G4XgXg1uk/TciCrzNNtm/T9v8dRv9Jm68V/XSs/wc
         0lZZS/5BwKZasAFVvUCBnoL1T9+o93fEL5N5h0FetM2Ecal1c2uyzg8eYyg9hbKS4E
         aHdvQhJ+SgdlxOXmI9xwxUki0r9M3s1YGJNfL4BXuzrpes15BXoYSVQ0M9SX6lyCcS
         ntiVZr7cJejkeKZzufsRWfOyGnSHDeucwyzzqDcHw43IysiJmrFgbgWDF2TcrGWysU
         tNV7Rq/9AjPQBYimkrRqaIczuF6Ys+PRiBSqMhFZ4Ht124yYI9UAY7soxHtWNOXg0Q
         Cq1ZRUo8EEfbQ==
Message-ID: <bff10500-4b63-9553-2ce0-3e46eb261d7a@collabora.com>
Date:   Thu, 21 Apr 2022 11:07:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH V2 08/12] clk: mediatek: reset: Add new register reset
 function with device
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
 <20220420130527.23200-9-rex-bc.chen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220420130527.23200-9-rex-bc.chen@mediatek.com>
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
> Some clock drvier only support device_node, so we still remain
> register reset function with device_node and add a function to
> register reset controller with device.
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
>   drivers/clk/mediatek/clk-mt8183.c     |  2 +-
>   drivers/clk/mediatek/reset.c          | 43 +++++++++++++++++++++++++++
>   drivers/clk/mediatek/reset.h          |  2 ++
>   13 files changed, 61 insertions(+), 16 deletions(-)
> 


..snip..

> diff --git a/drivers/clk/mediatek/reset.c b/drivers/clk/mediatek/reset.c
> index b164b1da7dd3..1173111af3ab 100644
> --- a/drivers/clk/mediatek/reset.c
> +++ b/drivers/clk/mediatek/reset.c
> @@ -107,4 +107,47 @@ int mtk_clk_register_rst_ctrl(struct device_node *np,
>   	return ret;
>   }
>   
> +int mtk_clk_register_rst_ctrl_with_dev(struct device *dev,
> +				       const struct mtk_clk_rst_desc *desc)
> +{
> +	struct device_node *np = dev->of_node;
> +	struct regmap *regmap;
> +	struct mtk_clk_rst_data *data;
> +	int ret;
> +
> +	if (!desc) {
> +		dev_err(dev, "mtk clock reset desc is NULL\n");
> +		return -EINVAL;
> +	}
> +
> +	if (desc->version >= MTK_RST_MAX) {
> +		dev_err(dev, "Error version number: %d\n", desc->version);
> +		return -EINVAL;
> +	}
> +
> +	regmap = device_node_to_regmap(np);
> +	if (IS_ERR(regmap)) {
> +		dev_err(dev, "Cannot find regmap %pe\n", regmap);
> +		return -EINVAL;
> +	}
> +
> +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->desc = desc;
> +	data->regmap = regmap;
> +	data->rcdev.owner = THIS_MODULE;
> +	data->rcdev.nr_resets = desc->reg_num * 32;
> +	data->rcdev.ops = rst_op[desc->version];
> +	data->rcdev.of_node = np;
> +	data->rcdev.dev = dev;
> +
> +	ret = devm_reset_controller_register(dev, &data->rcdev);
> +	if (ret)
> +		dev_err(dev, "could not register reset controller: %d\n", ret);

	if (ret) {
		dev_err(dev, "could not register reset controller: %d\n", ret);
		return ret;
	}

	return 0;

> +
> +	return ret;
> +}
> +
>   MODULE_LICENSE("GPL");
