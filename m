Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 182E04A6EBF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 11:32:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343531AbiBBKcY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 2 Feb 2022 05:32:24 -0500
Received: from aposti.net ([89.234.176.197]:46030 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232194AbiBBKcV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 05:32:21 -0500
Date:   Wed, 02 Feb 2022 10:32:01 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v12 7/9] drm/bridge: display-connector: add ddc-en gpio
 support
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
Message-Id: <DLAO6R.7AAJRIJFJSDD3@crapouillou.net>
In-Reply-To: <77a7a1daaf381e1651be38adb62f9af9dd6c8fc5.1643632014.git.hns@goldelico.com>
References: <cover.1643632014.git.hns@goldelico.com>
        <77a7a1daaf381e1651be38adb62f9af9dd6c8fc5.1643632014.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nikolaus,

Le lun., janv. 31 2022 at 13:26:53 +0100, H. Nikolaus Schaller 
<hns@goldelico.com> a écrit :
> "hdmi-connector.yaml" bindings defines an optional property
> "ddc-en-gpios" for a single gpio to enable DDC operation.
> 
> Usually this controls +5V power on the HDMI connector.
> This +5V may also be needed for HPD.
> 
> This was not reflected in code.
> 
> Now, the driver activates the ddc gpio after probe and
> deactivates after remove so it is "almost on".
> 
> But only if this driver is loaded (and not e.g. blacklisted
> as module).
> 
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> ---
>  drivers/gpu/drm/bridge/display-connector.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/gpu/drm/bridge/display-connector.c 
> b/drivers/gpu/drm/bridge/display-connector.c
> index d24f5b90feabf..555395e301096 100644
> --- a/drivers/gpu/drm/bridge/display-connector.c
> +++ b/drivers/gpu/drm/bridge/display-connector.c
> @@ -24,6 +24,7 @@ struct display_connector {
>  	int			hpd_irq;
> 
>  	struct regulator	*dp_pwr;
> +	struct gpio_desc	*ddc_en;
>  };
> 
>  static inline struct display_connector *
> @@ -345,6 +346,19 @@ static int display_connector_probe(struct 
> platform_device *pdev)
>  		}
>  	}
> 
> +	/* enable DDC */
> +	if (type == DRM_MODE_CONNECTOR_HDMIA) {
> +		conn->ddc_en = devm_gpiod_get_optional(&pdev->dev, "ddc-en",
> +						       GPIOD_OUT_HIGH);
> +
> +		if (IS_ERR(conn->ddc_en)) {
> +			dev_err(&pdev->dev, "Couldn't get ddc-en gpio\n");
> +			return PTR_ERR(conn->ddc_en);
> +		}
> +
> +		gpiod_set_value(conn->ddc_en, 1);

You already requested the gpio with the GPIOD_OUT_HIGH flag, so this 
can be removed.


> +	}
> +
>  	conn->bridge.funcs = &display_connector_bridge_funcs;
>  	conn->bridge.of_node = pdev->dev.of_node;
> 
> @@ -373,6 +387,9 @@ static int display_connector_remove(struct 
> platform_device *pdev)
>  {
>  	struct display_connector *conn = platform_get_drvdata(pdev);
> 
> +	if (conn->ddc_en)
> +		gpiod_set_value(conn->ddc_en, 0);

Note that gpiod_set_value() already does the null-check internally. I 
actually do prefer your solution, so this is fine with me, but 
maintainers may have a different opinion.

Cheers,
-Paul

> +
>  	if (conn->dp_pwr)
>  		regulator_disable(conn->dp_pwr);
> 
> --
> 2.33.0
> 


