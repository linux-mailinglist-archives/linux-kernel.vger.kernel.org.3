Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6BD4ACE6D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 02:53:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345622AbiBHBw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 20:52:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345724AbiBHBwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 20:52:46 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B215FC00498F
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 17:50:23 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id D988D340;
        Tue,  8 Feb 2022 02:50:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1644285017;
        bh=54RXyBFN1XLouxjG1y5X1f2y2yfBy76HJn50KqRDiOY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=afS2BOYr6nvpIXII1E3nqlJGWpLM5PmVah7wqGyjfQ9kPEJkISHVQqpWTCNwUzmPR
         25SYBZBZVFXtsUq2CbImsASFa0om6w5gMwLnxo8CSq2NduYhe2Faf52WIfKrX6WTrS
         LJwHUcp9nSr103pCvjLaBQB3lgZo1k3Ay7hk+ru0=
Date:   Tue, 8 Feb 2022 03:50:14 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        Javier Martinez Canillas <javierm@redhat.com>,
        robert.foss@linaro.org, lschyi@chromium.org,
        Sam Ravnborg <sam@ravnborg.org>, jjsu@chromium.org,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] drm/bridge: ti-sn65dsi86: Use drm_bridge_connector
Message-ID: <YgHMVneO/Y/qopEX@pendragon.ideasonboard.com>
References: <20220205001342.3155839-1-dianders@chromium.org>
 <20220204161245.v2.1.I3ab26b7f197cc56c874246a43e57913e9c2c1028@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220204161245.v2.1.I3ab26b7f197cc56c874246a43e57913e9c2c1028@changeid>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug,

Thank you for the patch.

On Fri, Feb 04, 2022 at 04:13:40PM -0800, Douglas Anderson wrote:
> The ti-sn65dsi86 driver shouldn't hand-roll its own bridge
> connector. It should use the normal drm_bridge_connector. Let's switch
> to do that, removing all of the custom code.
> 
> NOTE: this still _doesn't_ implement DRM_BRIDGE_ATTACH_NO_CONNECTOR
> support for ti-sn65dsi86 and that would still be a useful thing to do
> in the future. It was attempted in the past [1] but put on the back
> burner. However, unless we instantly change ti-sn65dsi86 fully from
> not supporting DRM_BRIDGE_ATTACH_NO_CONNECTOR at all to _only_
> supporting DRM_BRIDGE_ATTACH_NO_CONNECTOR then we'll still need a bit
> of time when we support both. This is a better way to support the old
> way where the driver hand rolls things itself.
> 
> A new notes about the implementation here:
> * When using the drm_bridge_connector the connector should be created
>   after all the bridges, so we change the ordering a bit.
> * I'm reasonably certain that we don't need to do anything to "free"
>   the new drm_bridge_connector. If drm_bridge_connector_init() returns
>   success then we know drm_connector_init() was called with the
>   `drm_bridge_connector_funcs`. The `drm_bridge_connector_funcs` has a
>   .destroy() that does all the cleanup. drm_connector_init() calls
>   __drm_mode_object_add() with a drm_connector_free() that will call
>   the .destroy().
> * I'm also reasonably certain that I don't need to "undo" the
>   drm_bridge_attach() if drm_bridge_connector_init() fails. The
>   "detach" function is private and other similar code doesn't try to
>   undo the drm_bridge_attach() in error cases. There's also a comment
>   indicating the lack of balance at the top of drm_bridge_attach().
> 
> [1] https://lore.kernel.org/r/20210920225801.227211-4-robdclark@gmail.com
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> 
> Changes in v2:
> - ("ti-sn65dsi86: Use drm_bridge_connector") new for v2.
> 
>  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 72 ++++++---------------------
>  1 file changed, 14 insertions(+), 58 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> index ba136a188be7..38616aab12ac 100644
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> @@ -26,6 +26,7 @@
>  #include <drm/drm_atomic.h>
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_bridge.h>
> +#include <drm/drm_bridge_connector.h>
>  #include <drm/dp/drm_dp_aux_bus.h>
>  #include <drm/dp/drm_dp_helper.h>
>  #include <drm/drm_mipi_dsi.h>
> @@ -174,7 +175,7 @@ struct ti_sn65dsi86 {
>  	struct regmap			*regmap;
>  	struct drm_dp_aux		aux;
>  	struct drm_bridge		bridge;
> -	struct drm_connector		connector;
> +	struct drm_connector		*connector;
>  	struct device_node		*host_node;
>  	struct mipi_dsi_device		*dsi;
>  	struct clk			*refclk;
> @@ -646,54 +647,6 @@ static struct auxiliary_driver ti_sn_aux_driver = {
>  	.id_table = ti_sn_aux_id_table,
>  };
>  
> -/* -----------------------------------------------------------------------------
> - * DRM Connector Operations
> - */
> -
> -static struct ti_sn65dsi86 *
> -connector_to_ti_sn65dsi86(struct drm_connector *connector)
> -{
> -	return container_of(connector, struct ti_sn65dsi86, connector);
> -}
> -
> -static int ti_sn_bridge_connector_get_modes(struct drm_connector *connector)
> -{
> -	struct ti_sn65dsi86 *pdata = connector_to_ti_sn65dsi86(connector);
> -
> -	return drm_bridge_get_modes(pdata->next_bridge, connector);
> -}
> -
> -static struct drm_connector_helper_funcs ti_sn_bridge_connector_helper_funcs = {
> -	.get_modes = ti_sn_bridge_connector_get_modes,
> -};
> -
> -static const struct drm_connector_funcs ti_sn_bridge_connector_funcs = {
> -	.fill_modes = drm_helper_probe_single_connector_modes,
> -	.destroy = drm_connector_cleanup,
> -	.reset = drm_atomic_helper_connector_reset,
> -	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
> -	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
> -};
> -
> -static int ti_sn_bridge_connector_init(struct ti_sn65dsi86 *pdata)
> -{
> -	int ret;
> -
> -	ret = drm_connector_init(pdata->bridge.dev, &pdata->connector,
> -				 &ti_sn_bridge_connector_funcs,
> -				 DRM_MODE_CONNECTOR_eDP);
> -	if (ret) {
> -		DRM_ERROR("Failed to initialize connector with drm\n");
> -		return ret;
> -	}
> -
> -	drm_connector_helper_add(&pdata->connector,
> -				 &ti_sn_bridge_connector_helper_funcs);
> -	drm_connector_attach_encoder(&pdata->connector, pdata->bridge.encoder);
> -
> -	return 0;
> -}
> -
>  /*------------------------------------------------------------------------------
>   * DRM Bridge
>   */
> @@ -757,10 +710,6 @@ static int ti_sn_bridge_attach(struct drm_bridge *bridge,
>  		return ret;
>  	}
>  
> -	ret = ti_sn_bridge_connector_init(pdata);
> -	if (ret < 0)
> -		goto err_conn_init;
> -
>  	/* We never want the next bridge to *also* create a connector: */
>  	flags |= DRM_BRIDGE_ATTACH_NO_CONNECTOR;
>  
> @@ -768,13 +717,20 @@ static int ti_sn_bridge_attach(struct drm_bridge *bridge,
>  	ret = drm_bridge_attach(bridge->encoder, pdata->next_bridge,
>  				&pdata->bridge, flags);
>  	if (ret < 0)
> -		goto err_dsi_host;
> +		goto err_initted_aux;
> +
> +	pdata->connector = drm_bridge_connector_init(pdata->bridge.dev,
> +						     pdata->bridge.encoder);
> +	if (IS_ERR(pdata->connector)) {
> +		ret = PTR_ERR(pdata->connector);
> +		goto err_initted_aux;
> +	}
> +
> +	drm_connector_attach_encoder(pdata->connector, pdata->bridge.encoder);
>  
>  	return 0;
>  
> -err_dsi_host:
> -	drm_connector_cleanup(&pdata->connector);
> -err_conn_init:
> +err_initted_aux:
>  	drm_dp_aux_unregister(&pdata->aux);
>  	return ret;
>  }
> @@ -824,7 +780,7 @@ static void ti_sn_bridge_set_dsi_rate(struct ti_sn65dsi86 *pdata)
>  
>  static unsigned int ti_sn_bridge_get_bpp(struct ti_sn65dsi86 *pdata)
>  {
> -	if (pdata->connector.display_info.bpc <= 6)
> +	if (pdata->connector->display_info.bpc <= 6)
>  		return 18;
>  	else
>  		return 24;

-- 
Regards,

Laurent Pinchart
