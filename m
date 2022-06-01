Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 296BF539D72
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 08:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343718AbiFAGwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 02:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244719AbiFAGwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 02:52:10 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A722A738
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 23:52:08 -0700 (PDT)
Received: from pendragon.ideasonboard.com (lmontsouris-659-1-41-236.w92-154.abo.wanadoo.fr [92.154.76.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 35F9D6D1;
        Wed,  1 Jun 2022 08:52:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1654066326;
        bh=9U51zIdFo623msxiQzlZ5c7urUVTOlg5NLFUSyleXjA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T9U4nYh3scF7O79G7ri7mNf7EnIC7VTS5q1eVW+AyUiy4ZQok/wAL+N6UiU3ISjX/
         fSP3Dno+DLsZtIrc5M7Q2X3r/mUsKwtVm2oIhauQSDxh4A4aOWOcNVRTyCD0+1rno3
         X8LQDEIVHhg/VYlHnFLdfVgkbVTVnfFcyNRaxAJs=
Date:   Wed, 1 Jun 2022 09:52:00 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     andrzej.hajda@intel.com, narmstrong@baylibre.com,
        robert.foss@linaro.org, jonas@kwiboo.se, jernej.skrabec@gmail.com,
        airlied@linux.ie, daniel@ffwll.ch, maxime@cerno.tech,
        sam@ravnborg.org, alsi@bang-olufsen.dk, jagan@amarulasolutions.com,
        biju.das.jz@bp.renesas.com, l.stach@pengutronix.de,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: bridge: adv7511: Add check for
 mipi_dsi_driver_register
Message-ID: <YpcMkIefWGCwZZJ+@pendragon.ideasonboard.com>
References: <20220601024822.2804516-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220601024822.2804516-1-jiasheng@iscas.ac.cn>
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

On Wed, Jun 01, 2022 at 10:48:22AM +0800, Jiasheng Jiang wrote:
> As mipi_dsi_driver_register could return error if fails,
> it should be better to check the return value and return error
> if fails.
> 
> Fixes: 1e4d58cd7f88 ("drm/bridge: adv7533: Create a MIPI DSI device")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
>  drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> index 5bb9300040dd..795855b41eb2 100644
> --- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> +++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> @@ -1392,8 +1392,13 @@ static struct i2c_driver adv7511_driver = {
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
>  	return i2c_add_driver(&adv7511_driver);

While at it, should this then call mipi_dsi_driver_unregister() on
failure ?

>  }
> -- 
> 2.25.1
> 

-- 
Regards,

Laurent Pinchart
