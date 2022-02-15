Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48EB24B5FEF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 02:17:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233016AbiBOBRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 20:17:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbiBOBRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 20:17:12 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7BB97BB8;
        Mon, 14 Feb 2022 17:17:03 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 23E821F43839
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1644887821;
        bh=z+Pkjj4FCBWwphTASrycJ+DSyiPQpio9khcfraStadg=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=HAWv1GWk79QOFTN1XRGwER8IeQYSu+lF/EGQF2nZDTedBqNrkhG7xPrRYOUAtZAdo
         abUnkEPUAjC2K1ibW0LmXH7mduwUhIVTXAoGqr3uSC3mUWKulcQppQji8tX0BvFlw7
         amoDp6LQsvGVLTvIq3LgXyvHBbh3g5FEuhx4dDtmEOATvWiqOXMJeHOb0IoAf9ysme
         VaDslraajxiKEbP5m/iLYi3QSmPewPf6sQisKIWo1FoZ1Ho8/CqgYWPm+coIUbQsF8
         JLs1qIdVs/NEz4GvkrCTJvJuEdt/6XG4TiXnEsa5lDLL/4/uuWcwBnIXpIQwBn7Cp/
         ySE5zSpd49vYg==
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Sean Paul <sean@poorly.run>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Simon Ser <contact@emersion.fr>,
        Harry Wentland <harry.wentland@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Jani Nikula <jani.nikula@linux.intel.com>
Subject: Re: [PATCH v8 1/3] gpu: drm: separate panel orientation property
 creating and value setting
References: <20220208084234.1684930-1-hsinyi@chromium.org>
Date:   Mon, 14 Feb 2022 20:16:56 -0500
In-Reply-To: <20220208084234.1684930-1-hsinyi@chromium.org> (Hsin-Yi Wang's
        message of "Tue, 8 Feb 2022 16:42:32 +0800")
Message-ID: <87leydhqt3.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hsin-Yi Wang <hsinyi@chromium.org> writes:

> drm_dev_register() sets connector->registration_state to
> DRM_CONNECTOR_REGISTERED and dev->registered to true. If
> drm_connector_set_panel_orientation() is first called after
> drm_dev_register(), it will fail several checks and results in following
> warning.

Hi,

I stumbled upon this when investigating the same WARN_ON on amdgpu.
Thanks for the patch :)

> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
> index a50c82bc2b2fec..572ead7ac10690 100644
> --- a/drivers/gpu/drm/drm_connector.c
> +++ b/drivers/gpu/drm/drm_connector.c
> @@ -1252,7 +1252,7 @@ static const struct drm_prop_enum_list dp_colorspaces[] = {
>   *	INPUT_PROP_DIRECT) will still map 1:1 to the actual LCD panel
>   *	coordinates, so if userspace rotates the picture to adjust for
>   *	the orientation it must also apply the same transformation to the
> - *	touchscreen input coordinates. This property is initialized by calling
> + *	touchscreen input coordinates. This property value is set by calling
>   *	drm_connector_set_panel_orientation() or
>   *	drm_connector_set_panel_orientation_with_quirk()
>   *
> @@ -2341,8 +2341,8 @@ EXPORT_SYMBOL(drm_connector_set_vrr_capable_property);
>   * @connector: connector for which to set the panel-orientation property.
>   * @panel_orientation: drm_panel_orientation value to set
>   *
> - * This function sets the connector's panel_orientation and attaches
> - * a "panel orientation" property to the connector.
> + * This function sets the connector's panel_orientation value. If the property
> + * doesn't exist, it will try to create one.
>   *
>   * Calling this function on a connector where the panel_orientation has
>   * already been set is a no-op (e.g. the orientation has been overridden with
> @@ -2373,19 +2373,12 @@ int drm_connector_set_panel_orientation(
>  	info->panel_orientation = panel_orientation;
>  
>  	prop = dev->mode_config.panel_orientation_property;
> -	if (!prop) {
> -		prop = drm_property_create_enum(dev, DRM_MODE_PROP_IMMUTABLE,
> -				"panel orientation",
> -				drm_panel_orientation_enum_list,
> -				ARRAY_SIZE(drm_panel_orientation_enum_list));
> -		if (!prop)
> -			return -ENOMEM;
> -
> -		dev->mode_config.panel_orientation_property = prop;
> -	}
> +	if (!prop &&
> +	    drm_connector_init_panel_orientation_property(connector) < 0)
> +		return -ENOMEM;
>

In the case where the property has not been created beforehand, you
forgot to reinitialize prop here, after calling
drm_connector_init_panel_orientation_property().  This means
drm_object_property_set_value() will be called with a NULL second argument
and Oops the kernel.


> -	drm_object_attach_property(&connector->base, prop,
> -				   info->panel_orientation);
> +	drm_object_property_set_value(&connector->base, prop,
> +				      info->panel_orientation);


-- 
Gabriel Krisman Bertazi
