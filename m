Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18DA64EDF07
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 18:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240178AbiCaQpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 12:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236346AbiCaQpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 12:45:13 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A0A0270E
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 09:43:24 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id 4C2071F46FA3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648745002;
        bh=uT5NxOT2hxMExd4I67KSu5UmcCZGrR+I7Ap+qLmu2RM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h4bVwDXdFftGkDwqukTvYLRUYMaTK0O9R7+SVp/Ajv6ZmQOdgk16pWGvTL8SN5BRT
         fY5at0sb/yVDCFC48w73x/4JM2RZt0svkWbLsE1Xw+6IDhTZL9hjy5yT1HTNi7GCK6
         LC/QFMo2MN/JXtJw2AvWr13rWQ2wM9WM3pLIR39zemHtbaUCl1s9LENeKi9UOZ8/Jf
         uE8N1MkpeMOnetnQDna6FTwH1lcwVH1kXlzKXoxRpdMwSwwA14uDEtC+LfxDV/4n+z
         0K40m3E0JTVigD7X/2KWyj9cS96GGcgjgShr6nZF5GIIEH6iqmjCi2rTI+2RMG5ENn
         uWGKVlnceG+yw==
Date:   Thu, 31 Mar 2022 12:43:18 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] soc: mediatek: pwrap: Switch to
 devm_platform_ioremap_resource_byname()
Message-ID: <20220331164318.5o53hxave6yrvkex@notapiano>
References: <20220331075817.7122-1-angelogioacchino.delregno@collabora.com>
 <20220331075817.7122-3-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220331075817.7122-3-angelogioacchino.delregno@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 09:58:16AM +0200, AngeloGioacchino Del Regno wrote:
> In order to simplify ioremapping resources, instead of calling
> platform_get_resource_byname() and then devm_ioremap_resource(),
> simply call devm_platform_ioremap_resource_byname().
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Tested-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

> ---
>  drivers/soc/mediatek/mtk-pmic-wrap.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
> index 54a5300ab72b..852514366f1f 100644
> --- a/drivers/soc/mediatek/mtk-pmic-wrap.c
> +++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
> @@ -2191,7 +2191,6 @@ static int pwrap_probe(struct platform_device *pdev)
>  	struct pmic_wrapper *wrp;
>  	struct device_node *np = pdev->dev.of_node;
>  	const struct of_device_id *of_slave_id = NULL;
> -	struct resource *res;
>  
>  	if (np->child)
>  		of_slave_id = of_match_node(of_slave_match_tbl, np->child);
> @@ -2211,8 +2210,7 @@ static int pwrap_probe(struct platform_device *pdev)
>  	wrp->slave = of_slave_id->data;
>  	wrp->dev = &pdev->dev;
>  
> -	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "pwrap");
> -	wrp->base = devm_ioremap_resource(wrp->dev, res);
> +	wrp->base = devm_platform_ioremap_resource_byname(pdev, "pwrap");
>  	if (IS_ERR(wrp->base))
>  		return PTR_ERR(wrp->base);
>  
> @@ -2226,9 +2224,7 @@ static int pwrap_probe(struct platform_device *pdev)
>  	}
>  
>  	if (HAS_CAP(wrp->master->caps, PWRAP_CAP_BRIDGE)) {
> -		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> -				"pwrap-bridge");
> -		wrp->bridge_base = devm_ioremap_resource(wrp->dev, res);
> +		wrp->bridge_base = devm_platform_ioremap_resource_byname(pdev, "pwrap-bridge");
>  		if (IS_ERR(wrp->bridge_base))
>  			return PTR_ERR(wrp->bridge_base);
>  
> -- 
> 2.35.1
> 
