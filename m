Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAE2E58C895
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 14:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242960AbiHHMtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 08:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233836AbiHHMtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 08:49:14 -0400
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6571FB89
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 05:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org
        ; s=ds202112; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=G3MaW7kSYZuMclka/Q3KdMVcnRc0tc/Et8yfYULCynQ=; b=iqw5Csu28VnoEc7vARcIhbwfqu
        yMk2QZCnoa7Y+Nq1c4OYg/on/3g0JXfDfDVLkVT2gtS65R3lLIJjJhdlyn2NwE6tl6/gyCfDid9h4
        oIxM+W1wXM2ysGLQkxbxjtCH4eD9j2zbJs96qAMuUGEl6tM0J2RrWRu7hNGpJYGyTTfkkolsJkQCz
        NIFEpFgOiD9VVYG62zaxc+mn35nfaigoFiS4zh2ZrIhBTzBFyah/nnlJviuqjYXYv3SjClAAfMtAq
        nITFsMIMI8UCuXYMcJjdvJAfgfbH14cvX/qrbI5IYd9pj1EpH/C9qok5onYfzdunbnNb5WbCuDH2e
        krpv+m2w==;
Received: from [2a01:799:961:d200:fd91:af1e:9da7:f964] (port=64771)
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <noralf@tronnes.org>)
        id 1oL2By-0006Tp-QU; Mon, 08 Aug 2022 14:49:10 +0200
Message-ID: <d96df677-a1a7-ae49-bda6-abad025dc974@tronnes.org>
Date:   Mon, 8 Aug 2022 14:49:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 06/35] drm/connector: Only register TV mode property if
 present
To:     Maxime Ripard <maxime@cerno.tech>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Samuel Holland <samuel@sholland.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>, Emma Anholt <emma@anholt.net>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Maxime Ripard <mripard@kernel.org>
Cc:     linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Phil Elwell <phil@raspberrypi.com>,
        Mateusz Kwiatkowski <kfyatek+publicgit@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org,
        Dom Cobley <dom@raspberrypi.com>
References: <20220728-rpi-analog-tv-properties-v1-0-3d53ae722097@cerno.tech>
 <20220728-rpi-analog-tv-properties-v1-6-3d53ae722097@cerno.tech>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
In-Reply-To: <20220728-rpi-analog-tv-properties-v1-6-3d53ae722097@cerno.tech>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 29.07.2022 18.34, skrev Maxime Ripard:
> The drm_create_tv_properties() will create the TV mode property
> unconditionally.
> 
> However, since we'll gradually phase it out, let's register it only if we
> have a list passed as an argument. This will make the transition easier.
> 
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> 

I don't understand why this makes the transition easier, but if you
think so:

Acked-by: Noralf Trønnes <noralf@tronnes.org>

> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
> index 68a4e47f85a9..d73a68764b6e 100644
> --- a/drivers/gpu/drm/drm_connector.c
> +++ b/drivers/gpu/drm/drm_connector.c
> @@ -1684,7 +1684,6 @@ int drm_mode_create_tv_properties(struct drm_device *dev,
>  	struct drm_property *tv_selector;
>  	struct drm_property *tv_subconnector;
>  	struct drm_property *tv_norm;
> -	unsigned int i;
>  
>  	if (dev->mode_config.tv_select_subconnector_property)
>  		return 0;
> @@ -1723,15 +1722,19 @@ int drm_mode_create_tv_properties(struct drm_device *dev,
>  		goto nomem;
>  	dev->mode_config.tv_norm_property = tv_norm;
>  
> -	dev->mode_config.tv_mode_property =
> -		drm_property_create(dev, DRM_MODE_PROP_ENUM,
> -				    "mode", num_modes);
> -	if (!dev->mode_config.tv_mode_property)
> -		goto nomem;
> +	if (num_modes) {
> +		unsigned int i;
>  
> -	for (i = 0; i < num_modes; i++)
> -		drm_property_add_enum(dev->mode_config.tv_mode_property,
> -				      i, modes[i]);
> +		dev->mode_config.tv_mode_property =
> +			drm_property_create(dev, DRM_MODE_PROP_ENUM,
> +					    "mode", num_modes);
> +		if (!dev->mode_config.tv_mode_property)
> +			goto nomem;
> +
> +		for (i = 0; i < num_modes; i++)
> +			drm_property_add_enum(dev->mode_config.tv_mode_property,
> +					      i, modes[i]);
> +	}
>  
>  	dev->mode_config.tv_brightness_property =
>  		drm_property_create_range(dev, 0, "brightness", 0, 100);
> 
