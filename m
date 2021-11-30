Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12FF0462B07
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 04:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237854AbhK3D2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 22:28:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232594AbhK3D2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 22:28:34 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6571C061574;
        Mon, 29 Nov 2021 19:25:15 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 52A218F0;
        Tue, 30 Nov 2021 04:25:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1638242714;
        bh=GWpugv4jnyFlulT3or9yRBAZ4QMbPljZiymoOFQR00A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RnYBIRBE7hOmgrbiD2xVpmT9MO9Vfda/eJ+9GpveAXXyzCHiGTqDEh3J40/wBYT6O
         UUUbA3DePBPuKc2esYmupTaxuNYBGYDXcE0bTh/8G8yfqeIQ8ZR70CJcKz/r85kjPK
         63wMwbZw17VgC+DbbFVVyLD+xpGmRAOdi8M0/EKQ=
Date:   Tue, 30 Nov 2021 05:24:50 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc:     linux-renesas-soc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] drm: rcar-du: mipi-dsi: Support bridge probe ordering
Message-ID: <YaWZgkL6phajVdvy@pendragon.ideasonboard.com>
References: <20211126101518.938783-1-kieran.bingham+renesas@ideasonboard.com>
 <20211126101518.938783-5-kieran.bingham+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211126101518.938783-5-kieran.bingham+renesas@ideasonboard.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kieran,

Thank you for the patch.

On Fri, Nov 26, 2021 at 10:15:18AM +0000, Kieran Bingham wrote:
> The bridge probe ordering for DSI devices has been clarified and further
> documented in

In what ? :-)

> To support connecting with the SN65DSI86 device after commit c3b75d4734cb
> ("drm/bridge: sn65dsi86: Register and attach our DSI device at probe"),
> update to the new probe ordering to remove a perpetual -EPROBE_DEFER
> loop between the two devices.
> 
> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

Will you send a new version of this patch with Biju's comments taken
into account ? I've already applied 1/4 to 3/4 to my tree, so there's no
need to repost them.

> ---
>  drivers/gpu/drm/rcar-du/rcar_mipi_dsi.c | 48 +++++++++++++------------
>  1 file changed, 26 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/gpu/drm/rcar-du/rcar_mipi_dsi.c b/drivers/gpu/drm/rcar-du/rcar_mipi_dsi.c
> index 833f4480bdf3..f783bacee8da 100644
> --- a/drivers/gpu/drm/rcar-du/rcar_mipi_dsi.c
> +++ b/drivers/gpu/drm/rcar-du/rcar_mipi_dsi.c
> @@ -639,6 +639,8 @@ static int rcar_mipi_dsi_host_attach(struct mipi_dsi_host *host,
>  					struct mipi_dsi_device *device)
>  {
>  	struct rcar_mipi_dsi *dsi = host_to_rcar_mipi_dsi(host);
> +	struct drm_panel *panel;
> +	int ret;
>  
>  	if (device->lanes > dsi->num_data_lanes)
>  		return -EINVAL;
> @@ -646,12 +648,36 @@ static int rcar_mipi_dsi_host_attach(struct mipi_dsi_host *host,
>  	dsi->lanes = device->lanes;
>  	dsi->format = device->format;
>  
> +	ret = drm_of_find_panel_or_bridge(dsi->dev->of_node, 1, 0, &panel,
> +					  &dsi->next_bridge);
> +	if (ret) {
> +		dev_err_probe(dsi->dev, ret, "could not find next bridge\n");
> +		return ret;
> +	}
> +
> +	if (!dsi->next_bridge) {
> +		dsi->next_bridge = devm_drm_panel_bridge_add(dsi->dev, panel);
> +		if (IS_ERR(dsi->next_bridge)) {
> +			dev_err(dsi->dev, "failed to create panel bridge\n");
> +			return PTR_ERR(dsi->next_bridge);
> +		}
> +	}
> +
> +	/* Initialize the DRM bridge. */
> +	dsi->bridge.funcs = &rcar_mipi_dsi_bridge_ops;
> +	dsi->bridge.of_node = dsi->dev->of_node;
> +	drm_bridge_add(&dsi->bridge);
> +
>  	return 0;
>  }
>  
>  static int rcar_mipi_dsi_host_detach(struct mipi_dsi_host *host,
>  					struct mipi_dsi_device *device)
>  {
> +	struct rcar_mipi_dsi *dsi = host_to_rcar_mipi_dsi(host);
> +
> +	drm_bridge_remove(&dsi->bridge);
> +
>  	return 0;
>  }
>  
> @@ -766,21 +792,6 @@ static int rcar_mipi_dsi_probe(struct platform_device *pdev)
>  		return PTR_ERR(dsi->rstc);
>  	}
>  
> -	ret = drm_of_find_panel_or_bridge(dsi->dev->of_node, 1, 0, &panel,
> -					  &dsi->next_bridge);
> -	if (ret) {
> -		dev_err_probe(dsi->dev, ret, "could not find next bridge\n");
> -		return ret;
> -	}
> -
> -	if (!dsi->next_bridge) {
> -		dsi->next_bridge = devm_drm_panel_bridge_add(dsi->dev, panel);
> -		if (IS_ERR(dsi->next_bridge)) {
> -			dev_err(dsi->dev, "failed to create panel bridge\n");
> -			return PTR_ERR(dsi->next_bridge);
> -		}
> -	}
> -
>  	/* Initialize the DSI host. */
>  	dsi->host.dev = dsi->dev;
>  	dsi->host.ops = &rcar_mipi_dsi_host_ops;
> @@ -788,11 +799,6 @@ static int rcar_mipi_dsi_probe(struct platform_device *pdev)
>  	if (ret < 0)
>  		return ret;
>  
> -	/* Initialize the DRM bridge. */
> -	dsi->bridge.funcs = &rcar_mipi_dsi_bridge_ops;
> -	dsi->bridge.of_node = dsi->dev->of_node;
> -	drm_bridge_add(&dsi->bridge);
> -
>  	return 0;
>  }
>  
> @@ -800,8 +806,6 @@ static int rcar_mipi_dsi_remove(struct platform_device *pdev)
>  {
>  	struct rcar_mipi_dsi *dsi = platform_get_drvdata(pdev);
>  
> -	drm_bridge_remove(&dsi->bridge);
> -
>  	mipi_dsi_host_unregister(&dsi->host);
>  
>  	return 0;

-- 
Regards,

Laurent Pinchart
