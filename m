Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 379AE4AF171
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 13:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232881AbiBIMXr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 9 Feb 2022 07:23:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233101AbiBIMVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 07:21:49 -0500
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1C6C02B5FB;
        Wed,  9 Feb 2022 04:18:29 -0800 (PST)
Date:   Wed, 09 Feb 2022 12:18:14 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v13 6/9] dw-hdmi/ingenic-dw-hdmi: repair interworking with
 hdmi-connector
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Paul Boddie <paul@boddie.org.uk>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org,
        Jonas Karlman <jonas@kwiboo.se>,
        dri-devel@lists.freedesktop.org
Message-Id: <E6E17R.ND5XW1IG4SYA@crapouillou.net>
In-Reply-To: <866f84621974992f4831bd471ae5a53414de9255.1643819482.git.hns@goldelico.com>
References: <cover.1643819482.git.hns@goldelico.com>
        <866f84621974992f4831bd471ae5a53414de9255.1643819482.git.hns@goldelico.com>
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

Hi Nikolaus,

Le mer., févr. 2 2022 at 17:31:20 +0100, H. Nikolaus Schaller 
<hns@goldelico.com> a écrit :
> Commit 7cd70656d1285b ("drm/bridge: display-connector: implement bus 
> fmts callbacks")
> 
> introduced a new mechanism to negotiate bus formats between hdmi 
> connector
> and the synopsys hdmi driver inside the jz4780.
> 
> By this, the dw-hdmi is no longer the only bridge and sets up a list
> of formats in dw_hdmi_bridge_atomic_get_output_bus_fmts().
> 
> This includes MEDIA_BUS_FMT_UYVY8_1X16 which is chosen for the jz4780 
> but only
> produces a black screen.
> 
> This fix is based on the observation that max_bpc = 0 when running 
> this
> function while info->bpc = 8. Since the formats checks before this 
> always test
> for max_bpc >= info->pbc indirectly my assumption is that we must 
> check it
> here as well.

This fix looks really strange to me, so I'll let the DRM experts 
comment.

It would still be better to move the patch before the introduction of 
dw-ingenic-hdmi.c, so that once this one is introduced, everything 
works. This also enables bisectability.

Cheers,
-Paul


> 
> Adding the proposed patch makes the CI20/jz4780 panel work again in
> MEDIA_BUS_FMT_RGB888_1X24 mode.
> 
> Fixes: 7cd70656d1285b ("drm/bridge: display-connector: implement bus 
> fmts callbacks")
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> ---
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c 
> b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> index 52e7cd2e020d3..34703a15ee4ff 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -2620,10 +2620,10 @@ static u32 
> *dw_hdmi_bridge_atomic_get_output_bus_fmts(struct drm_bridge *bridge,
>  		output_fmts[i++] = MEDIA_BUS_FMT_RGB101010_1X30;
>  	}
> 
> -	if (info->color_formats & DRM_COLOR_FORMAT_YCRCB422)
> +	if (max_bpc >= info->bpc && info->color_formats & 
> DRM_COLOR_FORMAT_YCRCB422)
>  		output_fmts[i++] = MEDIA_BUS_FMT_UYVY8_1X16;
> 
> -	if (info->color_formats & DRM_COLOR_FORMAT_YCRCB444)
> +	if (max_bpc >= info->bpc && info->color_formats & 
> DRM_COLOR_FORMAT_YCRCB444)
>  		output_fmts[i++] = MEDIA_BUS_FMT_YUV8_1X24;
> 
>  	/* Default 8bit RGB fallback */
> --
> 2.33.0
> 


