Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC4034817CB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 00:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233389AbhL2Xof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 18:44:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232732AbhL2Xoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 18:44:34 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8836C061574
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 15:44:33 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0D4FE2A5;
        Thu, 30 Dec 2021 00:44:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1640821472;
        bh=EKJWcHIEQZewdbTOk+cU/n4oiB8qgEvXbZQWRa+u7oY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qduy1Zno1qWlzopoqpJQFfNnK1KAvx80kEjmRacHOZyI7MlAjMuNjJQoNF/7BMZAf
         LMrENXvs+3VF+pj3zMm0Vv27RfPPu2/xnOm4ClwnNVT/umlbrtagEEsQwRGOJPIGga
         5i/LCNq6hS7pJ4UR2RCExD3PASGUUswmFpKCnlZE=
Date:   Thu, 30 Dec 2021 01:44:29 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/bridge_connector: enable HPD by default if supported
Message-ID: <Yczy3UYpU2UMFQ6N@pendragon.ideasonboard.com>
References: <20211225063151.2110878-1-nikita.yoush@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211225063151.2110878-1-nikita.yoush@cogentembedded.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nikita,

Thank you for the patch.

On Sat, Dec 25, 2021 at 09:31:51AM +0300, Nikita Yushchenko wrote:
> Hotplug events reported by bridge drivers over drm_bridge_hpd_notify()
> get ignored unless somebody calls drm_bridge_hpd_enable(). When the
> connector for the bridge is bridge_connector, such a call is done from
> drm_bridge_connector_enable_hpd().
> 
> However drm_bridge_connector_enable_hpd() is never called on init paths,
> documentation suggests that it is intended for suspend/resume paths.

Hmmmm... I'm in two minds about this. The problem description is
correct, but I wonder if HPD should be enabled unconditionally here, or
if this should be left to display drivers to control.
drivers/gpu/drm/imx/dcss/dcss-kms.c enables HPD manually at init time,
other drivers don't.

It feels like this should be under control of the display controller
driver, but I can't think of a use case for not enabling HPD at init
time. Any second opinion from anyone ?

> In result, once encoders are switched to bridge_connector,
> bridge-detected HPD stops working.
> 
> This patch adds a call to that API on init path.
> 
> This fixes HDMI HPD with rcar-du + adv7513 case when adv7513 reports HPD
> events via interrupts.
> 
> Fixes: c24110a8fd09 ("drm: rcar-du: Use drm_bridge_connector_init() helper")
> Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
> ---
>  drivers/gpu/drm/drm_bridge_connector.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_bridge_connector.c b/drivers/gpu/drm/drm_bridge_connector.c
> index 791379816837..4f20137ef21d 100644
> --- a/drivers/gpu/drm/drm_bridge_connector.c
> +++ b/drivers/gpu/drm/drm_bridge_connector.c
> @@ -369,8 +369,10 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
>  				    connector_type, ddc);
>  	drm_connector_helper_add(connector, &drm_bridge_connector_helper_funcs);
>  
> -	if (bridge_connector->bridge_hpd)
> +	if (bridge_connector->bridge_hpd) {
>  		connector->polled = DRM_CONNECTOR_POLL_HPD;
> +		drm_bridge_connector_enable_hpd(connector);
> +	}
>  	else if (bridge_connector->bridge_detect)
>  		connector->polled = DRM_CONNECTOR_POLL_CONNECT
>  				  | DRM_CONNECTOR_POLL_DISCONNECT;

-- 
Regards,

Laurent Pinchart
