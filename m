Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2E24AF13F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 13:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbiBIMRU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 9 Feb 2022 07:17:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232888AbiBIMPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 07:15:41 -0500
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC8DC05CB9D;
        Wed,  9 Feb 2022 04:01:29 -0800 (PST)
Date:   Wed, 09 Feb 2022 12:01:16 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v13 5/9] drm/synopsys+ingenic: repair hot plug detection
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
Message-Id: <4ED17R.TVHQS4U654LE@crapouillou.net>
In-Reply-To: <08fb9549042d35c1904fd977e68aa52f74f755b0.1643819482.git.hns@goldelico.com>
References: <cover.1643819482.git.hns@goldelico.com>
        <08fb9549042d35c1904fd977e68aa52f74f755b0.1643819482.git.hns@goldelico.com>
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

Le mer., févr. 2 2022 at 17:31:19 +0100, H. Nikolaus Schaller 
<hns@goldelico.com> a écrit :
> so that it calls drm_kms_helper_hotplug_event().
> 
> We need to set .poll_enabled but that struct component
> can only be accessed in the core code. Hence we add a public
> setter function.
> 
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> ---
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 9 +++++++++
>  drivers/gpu/drm/ingenic/ingenic-dw-hdmi.c | 2 ++
>  include/drm/bridge/dw_hdmi.h              | 1 +
>  3 files changed, 12 insertions(+)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c 
> b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> index 54d8fdad395f5..52e7cd2e020d3 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -3216,6 +3216,15 @@ static int dw_hdmi_parse_dt(struct dw_hdmi 
> *hdmi)
>  	return 0;
>  }
> 
> +void dw_hdmi_enable_poll(struct dw_hdmi *hdmi, bool enable)
> +{
> +	if (hdmi->bridge.dev)
> +		hdmi->bridge.dev->mode_config.poll_enabled = enable;
> +	else
> +		dev_warn(hdmi->dev, "no hdmi->bridge.dev");
> +}
> +EXPORT_SYMBOL_GPL(dw_hdmi_enable_poll);
> +
>  struct dw_hdmi *dw_hdmi_probe(struct platform_device *pdev,
>  			      const struct dw_hdmi_plat_data *plat_data)
>  {
> diff --git a/drivers/gpu/drm/ingenic/ingenic-dw-hdmi.c 
> b/drivers/gpu/drm/ingenic/ingenic-dw-hdmi.c
> index 34e986dd606cf..90547a28dc5c7 100644
> --- a/drivers/gpu/drm/ingenic/ingenic-dw-hdmi.c
> +++ b/drivers/gpu/drm/ingenic/ingenic-dw-hdmi.c
> @@ -55,6 +55,8 @@ ingenic_dw_hdmi_mode_valid(struct dw_hdmi *hdmi, 
> void *data,
>  	if (mode->clock > 216000)
>  		return MODE_CLOCK_HIGH;
> 
> +	dw_hdmi_enable_poll(hdmi, true);
> +

It would be a better idea to move this patch before the patch that 
creates ingenic-dw-hdmi.c. Then you wouldn't have to patch a file that 
was just introduced.

As for the patch itself, I guess it's fine, but is that really needed? 
My understanding is that it's the hdmi-connector's job to poll.

Cheers,
-Paul

>  	return MODE_OK;
>  }
> 
> diff --git a/include/drm/bridge/dw_hdmi.h 
> b/include/drm/bridge/dw_hdmi.h
> index 2a1f85f9a8a3f..963960794b40e 100644
> --- a/include/drm/bridge/dw_hdmi.h
> +++ b/include/drm/bridge/dw_hdmi.h
> @@ -196,5 +196,6 @@ enum drm_connector_status 
> dw_hdmi_phy_read_hpd(struct dw_hdmi *hdmi,
>  void dw_hdmi_phy_update_hpd(struct dw_hdmi *hdmi, void *data,
>  			    bool force, bool disabled, bool rxsense);
>  void dw_hdmi_phy_setup_hpd(struct dw_hdmi *hdmi, void *data);
> +void dw_hdmi_enable_poll(struct dw_hdmi *hdmi, bool enable);
> 
>  #endif /* __IMX_HDMI_H__ */
> --
> 2.33.0
> 


