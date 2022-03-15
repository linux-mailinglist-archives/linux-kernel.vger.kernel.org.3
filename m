Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DFF14D97CF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 10:38:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346719AbiCOJj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 05:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346697AbiCOJjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 05:39:16 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC76112609;
        Tue, 15 Mar 2022 02:38:03 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id D71161F436D5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647337082;
        bh=hZ3Ozc14j72XOG+b1t+GWcovi4uvCyAsuQVFavKh/sc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=R7SGXBVCLCthgJfbqNC649m2NSEhAmzxNhj9UIBmYiQfZ+UuBx+Om3Ph9ejXUlrGw
         b3sXqViSiqFKuv92g78KV63TidJpbB7q23XrfzGhKoY5rvrEGoo8xEKWi80Ukv+4TF
         LBsQ/APy3skr+3tXnNAAsd2HWPsORbBSUO7w3a3sC4yCs1/2Atuw6PmU1KZnPfQEOr
         ibYvS3dTk98lYZx8W1zV8i69uwnjgE5JLnpirElozBMPaCwbYWKnjk8K/nGWN0Kw1A
         ul+x+ebjfR25QCMP2jrkrvxR19DzFopWAvDUy79jhlrRSBJCNQcUa5BsK5yaMc4MXN
         5GC8jvbUL72Jw==
Message-ID: <e3facd86-9e93-bda7-b6dd-c18f1660466a@collabora.com>
Date:   Tue, 15 Mar 2022 10:37:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH V4 6/6] spi: mediatek: support hclk
Content-Language: en-US
To:     Leilk Liu <leilk.liu@mediatek.com>, Mark Brown <broonie@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <20220315032411.2826-1-leilk.liu@mediatek.com>
 <20220315032411.2826-7-leilk.liu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220315032411.2826-7-leilk.liu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 15/03/22 04:24, Leilk Liu ha scritto:
> this patch adds hclk support.
> 
> Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
> ---
>   drivers/spi/spi-mt65xx.c | 85 ++++++++++++++++++++++++++++++++--------
>   1 file changed, 69 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
> index 8958c3fa4fea..d4a602e78aa7 100644
> --- a/drivers/spi/spi-mt65xx.c
> +++ b/drivers/spi/spi-mt65xx.c
> @@ -130,7 +130,7 @@ struct mtk_spi {
>   	u32 state;
>   	int pad_num;
>   	u32 *pad_sel;
> -	struct clk *parent_clk, *sel_clk, *spi_clk;
> +	struct clk *parent_clk, *sel_clk, *spi_clk, *spi_hclk;
>   	struct spi_transfer *cur_transfer;
>   	u32 xfer_len;
>   	u32 num_xfered;
> @@ -1252,25 +1252,38 @@ static int mtk_spi_probe(struct platform_device *pdev)
>   		goto err_put_master;
>   	}
>   
> +	mdata->spi_hclk = devm_clk_get(&pdev->dev, "hclk");
> +	if (!IS_ERR(mdata->spi_hclk)) {

What you're doing here can be simplified by using devm_clk_get_optional() instead.
Please use that.

> +		ret = clk_prepare_enable(mdata->spi_hclk);
> +		if (ret < 0) {
> +			dev_err(&pdev->dev, "failed to enable hclk (%d)\n", ret);
> +			goto err_put_master;
> +		}
> +	}
> +
>   	ret = clk_prepare_enable(mdata->spi_clk);
>   	if (ret < 0) {
>   		dev_err(&pdev->dev, "failed to enable spi_clk (%d)\n", ret);
> -		goto err_put_master;
> +		goto err_disable_spi_hclk;
>   	}
>   
>   	ret = clk_set_parent(mdata->sel_clk, mdata->parent_clk);
>   	if (ret < 0) {
>   		dev_err(&pdev->dev, "failed to clk_set_parent (%d)\n", ret);
> -		clk_disable_unprepare(mdata->spi_clk);
> -		goto err_put_master;
> +		goto err_disable_spi_clk;
>   	}
>   
>   	mdata->spi_clk_hz = clk_get_rate(mdata->spi_clk);
>   
> -	if (mdata->dev_comp->no_need_unprepare)
> +	if (mdata->dev_comp->no_need_unprepare) {
>   		clk_disable(mdata->spi_clk);
> -	else
> +		if (!IS_ERR(mdata->spi_hclk))
> +			clk_disable(mdata->spi_hclk);
> +	} else {
>   		clk_disable_unprepare(mdata->spi_clk);
> +		if (!IS_ERR(mdata->spi_hclk))
> +			clk_disable_unprepare(mdata->spi_hclk);
> +	}
>   
>   	pm_runtime_enable(&pdev->dev);
>   
> @@ -1310,6 +1323,11 @@ static int mtk_spi_probe(struct platform_device *pdev)
>   
>   err_disable_runtime_pm:
>   	pm_runtime_disable(&pdev->dev);
> +err_disable_spi_clk:
> +	clk_disable_unprepare(mdata->spi_clk);
> +err_disable_spi_hclk:
> +	if (!IS_ERR(mdata->spi_hclk))

When using devm_clk_get_optional(), you can simply omit this check, since it will
be impossible to reach this point with an error pointer stored in spi_hclk.

> +		clk_disable_unprepare(mdata->spi_hclk);
>   err_put_master:
>   	spi_master_put(master);
>   
> @@ -1325,8 +1343,11 @@ static int mtk_spi_remove(struct platform_device *pdev)
>   
>   	mtk_spi_reset(mdata);
>   
> -	if (mdata->dev_comp->no_need_unprepare)
> +	if (mdata->dev_comp->no_need_unprepare) {
>   		clk_unprepare(mdata->spi_clk);
> +		if (!IS_ERR(mdata->spi_hclk))
> +			clk_unprepare(mdata->spi_hclk);
> +	}
>   
>   	return 0;
>   }
> @@ -1342,8 +1363,11 @@ static int mtk_spi_suspend(struct device *dev)
>   	if (ret)
>   		return ret;
>   
> -	if (!pm_runtime_suspended(dev))
> +	if (!pm_runtime_suspended(dev)) {
>   		clk_disable_unprepare(mdata->spi_clk);
> +		if (!IS_ERR(mdata->spi_hclk))
> +			clk_disable_unprepare(mdata->spi_hclk);
> +	}
>   
>   	return ret;
>   }
> @@ -1360,11 +1384,23 @@ static int mtk_spi_resume(struct device *dev)
>   			dev_err(dev, "failed to enable spi_clk (%d)\n", ret);
>   			return ret;
>   		}
> +
> +		if (!IS_ERR(mdata->spi_hclk)) {

Since you will be using devm_clk_get_optional(), you can also omit this check.

> +			clk_prepare_enable(mdata->spi_hclk);

There's a typo. ret = clk_prepare_enable....

> +			if (ret < 0) {
> +				dev_err(dev, "failed to enable spi_hclk (%d)\n", ret);
> +				clk_disable_unprepare(mdata->spi_clk);
> +				return ret;
> +			}
> +		}
>   	}
>   
>   	ret = spi_master_resume(master);
> -	if (ret < 0)
> +	if (ret < 0) {
>   		clk_disable_unprepare(mdata->spi_clk);
> +		if (!IS_ERR(mdata->spi_hclk))

Same here and everywhere else, no error check if you set this as optional clock.

> +			clk_disable_unprepare(mdata->spi_hclk);
> +	}
>   
>   	return ret;
>   }
> @@ -1376,10 +1412,15 @@ static int mtk_spi_runtime_suspend(struct device *dev)
>   	struct spi_master *master = dev_get_drvdata(dev);
>   	struct mtk_spi *mdata = spi_master_get_devdata(master);
>   
> -	if (mdata->dev_comp->no_need_unprepare)
> +	if (mdata->dev_comp->no_need_unprepare) {
>   		clk_disable(mdata->spi_clk);
> -	else
> +		if (!IS_ERR(mdata->spi_hclk))
> +			clk_disable(mdata->spi_hclk);
> +	} else {
>   		clk_disable_unprepare(mdata->spi_clk);
> +		if (!IS_ERR(mdata->spi_hclk))
> +			clk_disable_unprepare(mdata->spi_hclk);
> +	}
>   
>   	return 0;
>   }
> @@ -1390,13 +1431,25 @@ static int mtk_spi_runtime_resume(struct device *dev)
>   	struct mtk_spi *mdata = spi_master_get_devdata(master);
>   	int ret;
>   
> -	if (mdata->dev_comp->no_need_unprepare)
> +	if (mdata->dev_comp->no_need_unprepare) {
>   		ret = clk_enable(mdata->spi_clk);
> -	else
> +		if (!IS_ERR(mdata->spi_hclk))
> +			clk_enable(mdata->spi_hclk);
> +	} else {
>   		ret = clk_prepare_enable(mdata->spi_clk);
> -	if (ret < 0) {
> -		dev_err(dev, "failed to enable spi_clk (%d)\n", ret);
> -		return ret;
> +		if (ret < 0) {
> +			dev_err(dev, "failed to enable spi_clk (%d)\n", ret);
> +			return ret;
> +		}
> +
> +		if (!IS_ERR(mdata->spi_hclk)) {
> +			ret = clk_prepare_enable(mdata->spi_hclk);
> +			if (ret < 0) {
> +				dev_err(dev, "failed to enable spi_hclk (%d)\n", ret);
> +				clk_disable_unprepare(mdata->spi_clk);
> +				return ret;
> +			}
> +		}
>   	}
>   
>   	return 0;
> 


Regards,
Angelo


