Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35F5153BA97
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 16:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235787AbiFBOUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 10:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232088AbiFBOUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 10:20:41 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2537714084B
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 07:20:36 -0700 (PDT)
Received: from pendragon.ideasonboard.com (lmontsouris-659-1-41-236.w92-154.abo.wanadoo.fr [92.154.76.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id D2CE2474;
        Thu,  2 Jun 2022 16:20:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1654179632;
        bh=cW56JNy1YMzo/+mpBUCnE11x7qyE/FsTuFp/vI0Hu4g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pSmlqs942oDdUxWYEtAWQyZeoYuxBbiqIcUaMg+PU49W8Fy2PlrU8NmzkLykZe7Rj
         LZ1SZF6IWyHuyeh0d6ITrTYFnwci5K99VDcPSqLQNTB1qpRM4vOAA1DClGJ5HjgcxS
         2cAFkflFQRCeeo7i9PpMk5sbYWfjaG/fOK8cAZ+w=
Date:   Thu, 2 Jun 2022 17:20:28 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     andrzej.hajda@intel.com, narmstrong@baylibre.com,
        robert.foss@linaro.org, jonas@kwiboo.se, jernej.skrabec@gmail.com,
        airlied@linux.ie, daniel@ffwll.ch, maxime@cerno.tech,
        sam@ravnborg.org, alsi@bang-olufsen.dk, jagan@amarulasolutions.com,
        biju.das.jz@bp.renesas.com, l.stach@pengutronix.de,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm: bridge: adv7511: Add check for
 mipi_dsi_driver_register
Message-ID: <YpjHLN2U8DOh9NLH@pendragon.ideasonboard.com>
References: <20220602103401.2980938-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220602103401.2980938-1-jiasheng@iscas.ac.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiasheng,

Thank you for the patch.

On Thu, Jun 02, 2022 at 06:34:01PM +0800, Jiasheng Jiang wrote:
> As mipi_dsi_driver_register could return error if fails,
> it should be better to check the return value and return error
> if fails.
> Moreover, if i2c_add_driver fails,  mipi_dsi_driver_register
> should be reverted.
> 
> Fixes: 1e4d58cd7f88 ("drm/bridge: adv7533: Create a MIPI DSI device")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> Changelog:
> 
> v1 -> v2
> 
> *Change 1. Add the mipi_dsi_driver_unregister if i2c_add_driver fails.
> ---
>  drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> index 5bb9300040dd..2275d15d4a8b 100644
> --- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> +++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> @@ -1392,10 +1392,21 @@ static struct i2c_driver adv7511_driver = {
>  
>  static int __init adv7511_init(void)
>  {
> -	if (IS_ENABLED(CONFIG_DRM_MIPI_DSI))
> -		mipi_dsi_driver_register(&adv7533_dsi_driver);
> +	int ret;
> +
> +	if (IS_ENABLED(CONFIG_DRM_MIPI_DSI)) {
> +		ret = mipi_dsi_driver_register(&adv7533_dsi_driver);
> +		if (ret)
> +			return ret;
> +	}
>  
> -	return i2c_add_driver(&adv7511_driver);
> +	ret = i2c_add_driver(&adv7511_driver);
> +	if (ret) {
> +		if (IS_ENABLED(CONFIG_DRM_MIPI_DSI))
> +			mipi_dsi_driver_unregister(&adv7533_dsi_driver);
> +	}
> +
> +	return ret;
>  }
>  module_init(adv7511_init);
>  

-- 
Regards,

Laurent Pinchart
