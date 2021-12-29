Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C93E48104A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 07:23:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238930AbhL2GXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 01:23:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238916AbhL2GXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 01:23:31 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 954F8C061574;
        Tue, 28 Dec 2021 22:23:31 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 168B5464;
        Wed, 29 Dec 2021 07:23:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1640759008;
        bh=yuTsMkMOJBK1rnaIA7xI8px/7g87HJbdYgwt4YL7wi0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ex6vX+XqONsZEXU/yL2xyXSVYKeRxgFYm9Gm7bQmSHFb2aXOXmsN2ie09XjbwrnkM
         stIfCXdE+khltDRqSOU+yIXwuLvT4AdY/31Vt5cIEeieR89nHcswOolGE3h3h+7bWl
         A7JRYVJZP3uHKwc7hSeSQK4qMyonqEvImDSv6m94=
Date:   Wed, 29 Dec 2021 08:23:26 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     andrzej.hajda@intel.com, narmstrong@baylibre.com,
        robert.foss@linaro.org, jonas@kwiboo.se, jernej.skrabec@gmail.com,
        airlied@linux.ie, daniel@ffwll.ch, marex@denx.de,
        linus.walleij@linaro.org, frieder.schrempf@kontron.de,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] drm/bridge: sn65dsi83: Fix an error handling path in
 sn65dsi83_probe()
Message-ID: <Ycv+3pWote4yeBtF@pendragon.ideasonboard.com>
References: <16e7c6e94a61e6fc2d65db61620955c388798dbb.1640730512.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <16e7c6e94a61e6fc2d65db61620955c388798dbb.1640730512.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

Thank you for the patch.

On Tue, Dec 28, 2021 at 11:37:25PM +0100, Christophe JAILLET wrote:
> sn65dsi83_parse_dt() takes a reference on 'ctx->host_node' that must be
> released in the error handling path of the probe.
> This is only done in the remove function up to now.
> 
> Fixes: ceb515ba29ba ("drm/bridge: ti-sn65dsi83: Add TI SN65DSI83 and SN65DSI84 driver")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/gpu/drm/bridge/ti-sn65dsi83.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> index 945f08de45f1..6edea9f8f8c4 100644
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> @@ -673,8 +673,10 @@ static int sn65dsi83_probe(struct i2c_client *client,
>  		return ret;
>  
>  	ctx->regmap = devm_regmap_init_i2c(client, &sn65dsi83_regmap_config);
> -	if (IS_ERR(ctx->regmap))
> -		return PTR_ERR(ctx->regmap);
> +	if (IS_ERR(ctx->regmap)) {
> +		ret = PTR_ERR(ctx->regmap);
> +		goto err_put_node;
> +	}

There's another similar issue if sn65dsi83_parse_dt() fails. Would you
mind fixing them all in the same patch ?

>  
>  	dev_set_drvdata(dev, ctx);
>  	i2c_set_clientdata(client, ctx);
> @@ -691,6 +693,8 @@ static int sn65dsi83_probe(struct i2c_client *client,
>  
>  err_remove_bridge:
>  	drm_bridge_remove(&ctx->bridge);
> +err_put_node:
> +	of_node_put(ctx->host_node);
>  	return ret;
>  }
>  

-- 
Regards,

Laurent Pinchart
