Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 129544ACE72
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 02:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239702AbiBHByL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 20:54:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237747AbiBHByD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 20:54:03 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCD2C061A73
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 17:54:02 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id D9222340;
        Tue,  8 Feb 2022 02:53:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1644285240;
        bh=8SOb7WY/C5MVQclIAXnV4Guf5IVY1sW+SVXDe2gIdNg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iePNPe/r1H9kMW1s2sbTf/eQa5OenB0l/iUlAI3czaxLmgKiL0+xcvYKUwrdAQ07Z
         L5G/oV688qeA8Mn1J3tk0yL+IEDaMXd7zpL0jG6maBUGKOD1tIjn76N4itvHoYhwxX
         zntncxoe+4wND//hkR7YzPG/LyP7wwyDCnZL0kq4=
Date:   Tue, 8 Feb 2022 03:53:56 +0200
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
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] drm: Plumb debugfs_init through to panels
Message-ID: <YgHNNBShfCh8CuCC@pendragon.ideasonboard.com>
References: <20220205001342.3155839-1-dianders@chromium.org>
 <20220204161245.v2.2.Ib0bd5346135cbb0b63006b69b61d4c8af6484740@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220204161245.v2.2.Ib0bd5346135cbb0b63006b69b61d4c8af6484740@changeid>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Douglas,

Thank you for the patch.

On Fri, Feb 04, 2022 at 04:13:41PM -0800, Douglas Anderson wrote:
> We'd like panels to be able to add things to debugfs underneath the
> connector's directory. Let's plumb it through. A panel will be able to
> put things in a "panel" directory under the connector's
> directory. Note that debugfs is not ABI and so it's always possible
> that the location that the panel gets for its debugfs could change in
> the future.
> 
> NOTE: this currently only works if you're using a modern
> architecture. Specifically the plumbing relies on _both_
> drm_bridge_connector and drm_panel_bridge. If you're not using one or
> both of these things then things won't be plumbed through.
> 
> As a side effect of this change, drm_bridges can also get callbacks to
> put stuff underneath the connector's debugfs directory. At the moment
> all bridges in the chain have their debugfs_init() called with the
> connector's root directory.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> 
> Changes in v2:
> - ("drm: Plumb debugfs_init through to panels") new for v2.
> 
>  drivers/gpu/drm/bridge/panel.c         | 12 ++++++++++++
>  drivers/gpu/drm/drm_bridge_connector.c | 15 +++++++++++++++
>  drivers/gpu/drm/drm_debugfs.c          |  3 +++
>  include/drm/drm_bridge.h               |  7 +++++++
>  include/drm/drm_connector.h            |  7 +++++++
>  include/drm/drm_panel.h                |  8 ++++++++
>  6 files changed, 52 insertions(+)
> 
> diff --git a/drivers/gpu/drm/bridge/panel.c b/drivers/gpu/drm/bridge/panel.c
> index b32295abd9e7..5be057575183 100644
> --- a/drivers/gpu/drm/bridge/panel.c
> +++ b/drivers/gpu/drm/bridge/panel.c
> @@ -138,6 +138,17 @@ static int panel_bridge_get_modes(struct drm_bridge *bridge,
>  	return drm_panel_get_modes(panel_bridge->panel, connector);
>  }
>  
> +static void panel_bridge_debugfs_init(struct drm_bridge *bridge,
> +				      struct dentry *root)
> +{
> +	struct panel_bridge *panel_bridge = drm_bridge_to_panel_bridge(bridge);
> +	struct drm_panel *panel = panel_bridge->panel;
> +
> +	root = debugfs_create_dir("panel", root);
> +	if (panel->funcs->debugfs_init)
> +		panel->funcs->debugfs_init(panel, root);
> +}
> +
>  static const struct drm_bridge_funcs panel_bridge_bridge_funcs = {
>  	.attach = panel_bridge_attach,
>  	.detach = panel_bridge_detach,
> @@ -150,6 +161,7 @@ static const struct drm_bridge_funcs panel_bridge_bridge_funcs = {
>  	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
>  	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
>  	.atomic_get_input_bus_fmts = drm_atomic_helper_bridge_propagate_bus_fmt,
> +	.debugfs_init = panel_bridge_debugfs_init,
>  };
>  
>  /**
> diff --git a/drivers/gpu/drm/drm_bridge_connector.c b/drivers/gpu/drm/drm_bridge_connector.c
> index 791379816837..60923cdfe8e1 100644
> --- a/drivers/gpu/drm/drm_bridge_connector.c
> +++ b/drivers/gpu/drm/drm_bridge_connector.c
> @@ -216,6 +216,20 @@ static void drm_bridge_connector_destroy(struct drm_connector *connector)
>  	kfree(bridge_connector);
>  }
>  
> +static void drm_bridge_connector_debugfs_init(struct drm_connector *connector,
> +					      struct dentry *root)
> +{
> +	struct drm_bridge_connector *bridge_connector =
> +		to_drm_bridge_connector(connector);
> +	struct drm_encoder *encoder = bridge_connector->encoder;
> +	struct drm_bridge *bridge;
> +
> +	list_for_each_entry(bridge, &encoder->bridge_chain, chain_node) {
> +		if (bridge->funcs->debugfs_init)
> +			bridge->funcs->debugfs_init(bridge, root);
> +	}
> +}
> +
>  static const struct drm_connector_funcs drm_bridge_connector_funcs = {
>  	.reset = drm_atomic_helper_connector_reset,
>  	.detect = drm_bridge_connector_detect,
> @@ -223,6 +237,7 @@ static const struct drm_connector_funcs drm_bridge_connector_funcs = {
>  	.destroy = drm_bridge_connector_destroy,
>  	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
>  	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
> +	.debugfs_init = drm_bridge_connector_debugfs_init,
>  };
>  
>  /* -----------------------------------------------------------------------------
> diff --git a/drivers/gpu/drm/drm_debugfs.c b/drivers/gpu/drm/drm_debugfs.c
> index b0a826489488..7f1b82dbaebb 100644
> --- a/drivers/gpu/drm/drm_debugfs.c
> +++ b/drivers/gpu/drm/drm_debugfs.c
> @@ -436,6 +436,9 @@ void drm_debugfs_connector_add(struct drm_connector *connector)
>  	/* vrr range */
>  	debugfs_create_file("vrr_range", S_IRUGO, root, connector,
>  			    &vrr_range_fops);
> +
> +	if (connector->funcs->debugfs_init)
> +		connector->funcs->debugfs_init(connector, root);
>  }
>  
>  void drm_debugfs_connector_remove(struct drm_connector *connector)
> diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
> index 061d87313fac..f27b4060faa2 100644
> --- a/include/drm/drm_bridge.h
> +++ b/include/drm/drm_bridge.h
> @@ -649,6 +649,13 @@ struct drm_bridge_funcs {
>  	 * the DRM_BRIDGE_OP_HPD flag in their &drm_bridge->ops.
>  	 */
>  	void (*hpd_disable)(struct drm_bridge *bridge);
> +
> +	/**
> +	 * @debugfs_init:
> +	 *
> +	 * Allows bridges to create bridge-specific debugfs files.
> +	 */
> +	void (*debugfs_init)(struct drm_bridge *bridge, struct dentry *root);
>  };
>  
>  /**
> diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
> index 64cf5f88c05b..54429dde744a 100644
> --- a/include/drm/drm_connector.h
> +++ b/include/drm/drm_connector.h
> @@ -1142,6 +1142,13 @@ struct drm_connector_funcs {
>  	 * has been received from a source outside the display driver / device.
>  	 */
>  	void (*oob_hotplug_event)(struct drm_connector *connector);
> +
> +	/**
> +	 * @debugfs_init:
> +	 *
> +	 * Allows connectors to create connector-specific debugfs files.
> +	 */
> +	void (*debugfs_init)(struct drm_connector *connector, struct dentry *root);
>  };
>  
>  /**
> diff --git a/include/drm/drm_panel.h b/include/drm/drm_panel.h
> index 4602f833eb51..1ba2d424a53f 100644
> --- a/include/drm/drm_panel.h
> +++ b/include/drm/drm_panel.h
> @@ -29,6 +29,7 @@
>  #include <linux/list.h>
>  
>  struct backlight_device;
> +struct dentry;
>  struct device_node;
>  struct drm_connector;
>  struct drm_device;
> @@ -125,6 +126,13 @@ struct drm_panel_funcs {
>  	 */
>  	int (*get_timings)(struct drm_panel *panel, unsigned int num_timings,
>  			   struct display_timing *timings);
> +
> +	/**
> +	 * @debugfs_init:
> +	 *
> +	 * Allows panels to create panels-specific debugfs files.
> +	 */
> +	void (*debugfs_init)(struct drm_panel *panel, struct dentry *root);
>  };
>  
>  /**

-- 
Regards,

Laurent Pinchart
