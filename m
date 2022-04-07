Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 468594F7781
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 09:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241824AbiDGHc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 03:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241814AbiDGHcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 03:32:51 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8421C45AE8;
        Thu,  7 Apr 2022 00:30:52 -0700 (PDT)
Received: from pendragon.ideasonboard.com (117.145-247-81.adsl-dyn.isp.belgacom.be [81.247.145.117])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 52E14499;
        Thu,  7 Apr 2022 09:30:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1649316650;
        bh=1eYFzMoK6H6YYEen2Elb5S6MFSJv6PvKrhbGFK6YAmQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CDNK07HLiQt8KNFejRu9SlEOiqnqmisrPh8vREkV5t2BWV3Ne7HUmKOhvOS+kiwRe
         UVr59wrSJ7lKyu5DTFTkE8l9d62e65coFCQMDDmdsOANTjLbkkFgtY+d0vQ3xf4rZv
         Dor/3DxdKtAjB5H95KydaMJWpt222kn0AuKAE1v4=
Date:   Thu, 7 Apr 2022 10:30:46 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Paul Boddie <paul@boddie.org.uk>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Paul Cercueil <paul@crapouillou.net>,
        Maxime Ripard <maxime@cerno.tech>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-mips@vger.kernel.org,
        letux-kernel@openphoenux.org
Subject: Re: [PATCH v17 6/6] drm/bridge: display-connector: add ddc-en gpio
 support
Message-ID: <Yk6TJgdoSqthWUiz@pendragon.ideasonboard.com>
References: <cover.1649262368.git.hns@goldelico.com>
 <bf90de303a5dbc587517fe4a1bb437e198b90198.1649262368.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bf90de303a5dbc587517fe4a1bb437e198b90198.1649262368.git.hns@goldelico.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nikolaus,

Thank you for the patch.

On Wed, Apr 06, 2022 at 06:26:08PM +0200, H. Nikolaus Schaller wrote:
> "hdmi-connector.yaml" bindings defines an optional property
> "ddc-en-gpios" for a single gpio to enable DDC operation.
> 
> Usually this controls +5V power on the HDMI connector.
> This +5V may also be needed for HPD.
> 
> This was not reflected in code but is needed to make the CI20
> board work.
> 
> Now, the driver activates the ddc gpio after probe and
> deactivates after remove so it is "almost on".
> 
> But only if this driver is loaded (and not e.g. blacklisted
> as module).
> 
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/gpu/drm/bridge/display-connector.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/gpu/drm/bridge/display-connector.c b/drivers/gpu/drm/bridge/display-connector.c
> index d24f5b90feabf..e4d52a7e31b71 100644
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
> @@ -345,6 +346,17 @@ static int display_connector_probe(struct platform_device *pdev)
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
> +	}
> +
>  	conn->bridge.funcs = &display_connector_bridge_funcs;
>  	conn->bridge.of_node = pdev->dev.of_node;
>  
> @@ -373,6 +385,9 @@ static int display_connector_remove(struct platform_device *pdev)
>  {
>  	struct display_connector *conn = platform_get_drvdata(pdev);
>  
> +	if (conn->ddc_en)
> +		gpiod_set_value(conn->ddc_en, 0);
> +
>  	if (conn->dp_pwr)
>  		regulator_disable(conn->dp_pwr);
>  

-- 
Regards,

Laurent Pinchart
