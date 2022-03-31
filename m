Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EFD14EDF0D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 18:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240185AbiCaQpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 12:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232097AbiCaQpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 12:45:46 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 398113587C
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 09:43:59 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id 6D81A1F46FA3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648745038;
        bh=94Cb7myupDPAqE8jKAnxrfz3kkcstfEKE3FYesYmFY8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WnU2A92cVWBCeTzZ3DSb/z5w+q3NrzUc5piQzdi37Hb5+v9KBKh+sXdqJ1sUcdqho
         WMi6YxxFQoGmezY679nf23D/jPAdf6pDmLwP9/qX54M04YBcnJT2DE1czXcgTetqrR
         qR0zAeIKal/RVFnZXOUySsYImTjWOVkJ+tHMzhQe7CNH4PG0ibD/pgxGUQKDqcj0y7
         HFgOOIYe4xaISAuHOJ/zSvvr6ATrpYKSqnBRA83UnK73YWAufPtMfOXLbbzWkvtcPr
         U7yUvhx8Q2AAp5+bFMh7rPOp0vrkKDEwfUHRExvr681eSN7ZVRaoAMYZxdHlv1wEQ3
         rDZBC4axRjpCA==
Date:   Thu, 31 Mar 2022 12:43:53 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] soc: mediatek: pwrap: Move and check return value
 of platform_get_irq()
Message-ID: <20220331164353.unrxdeq756tj5et3@notapiano>
References: <20220331075817.7122-1-angelogioacchino.delregno@collabora.com>
 <20220331075817.7122-4-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220331075817.7122-4-angelogioacchino.delregno@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 09:58:17AM +0200, AngeloGioacchino Del Regno wrote:
> Move the call to platform_get_irq() earlier in the probe function
> and check for its return value: if no interrupt is specified, it
> wouldn't make sense to try to call devm_request_irq() so, in that
> case, we can simply return early.
> 
> Moving the platform_get_irq() call also makes it possible to use
> one less goto, as clocks aren't required at that stage.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Tested-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

> ---
>  drivers/soc/mediatek/mtk-pmic-wrap.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
> index 852514366f1f..332cbcabc299 100644
> --- a/drivers/soc/mediatek/mtk-pmic-wrap.c
> +++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
> @@ -2204,6 +2204,10 @@ static int pwrap_probe(struct platform_device *pdev)
>  	if (!wrp)
>  		return -ENOMEM;
>  
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return irq;
> +
>  	platform_set_drvdata(pdev, wrp);
>  
>  	wrp->master = of_device_get_match_data(&pdev->dev);
> @@ -2316,7 +2320,6 @@ static int pwrap_probe(struct platform_device *pdev)
>  	if (HAS_CAP(wrp->master->caps, PWRAP_CAP_INT1_EN))
>  		pwrap_writel(wrp, wrp->master->int1_en_all, PWRAP_INT1_EN);
>  
> -	irq = platform_get_irq(pdev, 0);
>  	ret = devm_request_irq(wrp->dev, irq, pwrap_interrupt,
>  			       IRQF_TRIGGER_HIGH,
>  			       "mt-pmic-pwrap", wrp);
> -- 
> 2.35.1
> 
