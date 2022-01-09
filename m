Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46C16488CEF
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 23:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235803AbiAIW6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 17:58:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235684AbiAIW63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 17:58:29 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD5CC06173F;
        Sun,  9 Jan 2022 14:58:28 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 030D9E2C;
        Sun,  9 Jan 2022 23:58:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1641769107;
        bh=6UtBX64fInlzIOWD+Awy1R39whEsyOPyjRhMcW218zI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cX6TgJyEbMlYV6JzHVBXZw5zAPIyhjMJyRsRGYc3w8yFfKN+XzxNPrJH27I2PPOao
         JE9lAATo+NCzxseZSeoUgdagU9TG25ZBRB6gHt5JGVfMmtqU2mTMPOA2qzB5Ar+Gtg
         UH+/5JxaDw4zpuFcxNI1zisMJUiRkIm7wwc+VGZk=
Date:   Mon, 10 Jan 2022 00:58:17 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/bridge: adv7533: make array clock_div_by_lanes
 static const
Message-ID: <Ydtoib+OCyaPhrOH@pendragon.ideasonboard.com>
References: <20220109204105.51878-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220109204105.51878-1-colin.i.king@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Colin,

Thank you for the patch.

On Sun, Jan 09, 2022 at 08:41:05PM +0000, Colin Ian King wrote:
> Don't populate the read-only array clock_div_by_lanes on the stack but
> instead it static const. Also makes the object code a little smaller.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/gpu/drm/bridge/adv7511/adv7533.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/adv7511/adv7533.c b/drivers/gpu/drm/bridge/adv7511/adv7533.c
> index eb7579dec40a..ef6270806d1d 100644
> --- a/drivers/gpu/drm/bridge/adv7511/adv7533.c
> +++ b/drivers/gpu/drm/bridge/adv7511/adv7533.c
> @@ -29,7 +29,7 @@ static void adv7511_dsi_config_timing_gen(struct adv7511 *adv)
>  	struct mipi_dsi_device *dsi = adv->dsi;
>  	struct drm_display_mode *mode = &adv->curr_mode;
>  	unsigned int hsw, hfp, hbp, vsw, vfp, vbp;
> -	u8 clock_div_by_lanes[] = { 6, 4, 3 };	/* 2, 3, 4 lanes */
> +	static const u8 clock_div_by_lanes[] = { 6, 4, 3 };	/* 2, 3, 4 lanes */

It's not mandatory, but I have a tendency to declare static const
variable first before all mutable variables.

>  
>  	hsw = mode->hsync_end - mode->hsync_start;
>  	hfp = mode->hsync_start - mode->hdisplay;

I wonder if

	/* set pixel clock divider mode */
	regmap_write(adv->regmap_cec, 0x16, (12 / dsi->lanes) << 3);

would be even better, or if it would be too much black magic. Either
way,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

-- 
Regards,

Laurent Pinchart
