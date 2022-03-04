Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1CE4CDE69
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 21:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbiCDUBz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 4 Mar 2022 15:01:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbiCDUBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 15:01:48 -0500
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9F5972F2
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 11:56:02 -0800 (PST)
Date:   Fri, 04 Mar 2022 19:38:29 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] drm/bridge_connector: enable HPD by default if supported
To:     Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Message-Id: <5WJ88R.LXNASHJRBDGL1@crapouillou.net>
In-Reply-To: <20211225063151.2110878-1-nikita.yoush@cogentembedded.com>
References: <20211225063151.2110878-1-nikita.yoush@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nikita,

Le sam., déc. 25 2021 at 09:31:51 +0300, Nikita Yushchenko 
<nikita.yoush@cogentembedded.com> a écrit :
> Hotplug events reported by bridge drivers over drm_bridge_hpd_notify()
> get ignored unless somebody calls drm_bridge_hpd_enable(). When the
> connector for the bridge is bridge_connector, such a call is done from
> drm_bridge_connector_enable_hpd().
> 
> However drm_bridge_connector_enable_hpd() is never called on init 
> paths,
> documentation suggests that it is intended for suspend/resume paths.
> 
> In result, once encoders are switched to bridge_connector,
> bridge-detected HPD stops working.
> 
> This patch adds a call to that API on init path.
> 
> This fixes HDMI HPD with rcar-du + adv7513 case when adv7513 reports 
> HPD
> events via interrupts.
> 
> Fixes: c24110a8fd09 ("drm: rcar-du: Use drm_bridge_connector_init() 
> helper")
> Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>

Merged to drm-misc-next.

Thanks!

Cheers,
-Paul

> ---
>  drivers/gpu/drm/drm_bridge_connector.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_bridge_connector.c 
> b/drivers/gpu/drm/drm_bridge_connector.c
> index 791379816837..4f20137ef21d 100644
> --- a/drivers/gpu/drm/drm_bridge_connector.c
> +++ b/drivers/gpu/drm/drm_bridge_connector.c
> @@ -369,8 +369,10 @@ struct drm_connector 
> *drm_bridge_connector_init(struct drm_device *drm,
>  				    connector_type, ddc);
>  	drm_connector_helper_add(connector, 
> &drm_bridge_connector_helper_funcs);
> 
> -	if (bridge_connector->bridge_hpd)
> +	if (bridge_connector->bridge_hpd) {
>  		connector->polled = DRM_CONNECTOR_POLL_HPD;
> +		drm_bridge_connector_enable_hpd(connector);
> +	}
>  	else if (bridge_connector->bridge_detect)
>  		connector->polled = DRM_CONNECTOR_POLL_CONNECT
>  				  | DRM_CONNECTOR_POLL_DISCONNECT;
> --
> 2.30.2


