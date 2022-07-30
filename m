Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7838D58595D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 11:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233445AbiG3JMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 05:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231984AbiG3JM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 05:12:29 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D71B3DF2D
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 02:12:28 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id c12so8283321ede.3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 02:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hll3ibUAqwWMG/OtKvhLlM3Hjch+TNh/bFfU6jv+6g4=;
        b=UIvlOiZjgq7+FWhOckuO00o7AIlyQZ2vDqbOSmqJnIrmhVs3J56EiTFct5I279Lkqf
         +eXwGIIecQdAbHOb+l2dJWwK/lr4IWvn2nDdgucESnOsZS3WLnG5r++kWrEXnIqL6t2b
         yElo8+B3x0fX7dLh4mMQabuoB0PE5PO1XMK0gYrC8qDyYujV8TAHQoCZmLn6j1f9azUc
         YzVJhvTOSMTX0zI6cAaIxHiY3BP2ybwCILXOVPqgwxt77MANU1iyXgpXCb3NvDHNJTTv
         yxUakWjvKPdk7KDgqdeB9DGPej6EBT8/T7FmJtCr7c9E7l+2NpQKxRwl65Ts+1XWrk52
         tsWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hll3ibUAqwWMG/OtKvhLlM3Hjch+TNh/bFfU6jv+6g4=;
        b=kR/OENB69yzlNgyAAB7/MuDqicdJKYm0/l2EFLosrvEIXjbti+2rjced1mT8NglnZv
         LJHZJsPMDJyOGxPCipmFMuKh7VHBXbbABIT8oNz9Vt3ZSum7iHUoXLwjOfCu23dLQDHL
         V5JiFjLi46xNXX0zp5ziHqkQ8pInsAJC++bk8CtO2rV0hCwWx4JcApqPR4HRiU7jP1No
         6lUnrJ5qn/3Crlh+iQdUf1yU+XPGV6nZ9nbtWt/fXiehX/1EFO3HzVUddCYqVcH/gF9/
         hkDk5V+9K1B9nEMgkU9cRBZWwZ3+Qmq9F0wdlDGN5hrbxXbwjnYPp9tuM1GR845cnRZE
         1HLw==
X-Gm-Message-State: AJIora+VmDT4AFh6YEK9pG66BxI1poFEnBQI9PNs94zQKm0BqM7CgeIT
        9gBAeil7Dcl57nJtDNiI2RY=
X-Google-Smtp-Source: AGRyM1s0xAfvYSqaUCZnsf6TarPfFgDLdgevrEr1is/O1hRHAi0uogjW59OUmgXy0aJbO16CWW7UwQ==
X-Received: by 2002:a05:6402:51d1:b0:43b:f89e:a751 with SMTP id r17-20020a05640251d100b0043bf89ea751mr6943326edd.391.1659172347045;
        Sat, 30 Jul 2022 02:12:27 -0700 (PDT)
Received: from jernej-laptop.localnet (194-152-27-124.dynamic.telemach.net. [194.152.27.124])
        by smtp.gmail.com with ESMTPSA id 1-20020a170906200100b0072b40cb28a8sm2706263ejo.29.2022.07.30.02.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jul 2022 02:12:26 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Samuel Holland <samuel@sholland.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>, Emma Anholt <emma@anholt.net>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Noralf =?ISO-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Maxime Ripard <mripard@kernel.org>,
        Maxime Ripard <maxime@cerno.tech>
Cc:     Maxime Ripard <maxime@cerno.tech>, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, Phil Elwell <phil@raspberrypi.com>,
        Mateusz Kwiatkowski <kfyatek+publicgit@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org,
        Dom Cobley <dom@raspberrypi.com>
Subject: Re: [PATCH v1 26/35] drm/sun4i: tv: Convert to atomic hooks
Date:   Sat, 30 Jul 2022 11:12:24 +0200
Message-ID: <2638619.mvXUDI8C0e@jernej-laptop>
In-Reply-To: <20220728-rpi-analog-tv-properties-v1-26-3d53ae722097@cerno.tech>
References: <20220728-rpi-analog-tv-properties-v1-0-3d53ae722097@cerno.tech> <20220728-rpi-analog-tv-properties-v1-26-3d53ae722097@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne petek, 29. julij 2022 ob 18:35:09 CEST je Maxime Ripard napisal(a):
> The VC4 VEC driver still uses legacy enable and disable hook

s/VC4 VEC/sun4i tv/

Best regards,
Jernej

> implementation. Let's convert to the atomic variants.
> 
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> 
> diff --git a/drivers/gpu/drm/sun4i/sun4i_tv.c
> b/drivers/gpu/drm/sun4i/sun4i_tv.c index 53152d77c392..f7aad995ab5b 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_tv.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_tv.c
> @@ -339,7 +339,8 @@ static void sun4i_tv_mode_to_drm_mode(const struct
> tv_mode *tv_mode, mode->vtotal = mode->vsync_end  + tv_mode->vback_porch;
>  }
> 
> -static void sun4i_tv_disable(struct drm_encoder *encoder)
> +static void sun4i_tv_disable(struct drm_encoder *encoder,
> +			    struct drm_atomic_state *state)
>  {
>  	struct sun4i_tv *tv = drm_encoder_to_sun4i_tv(encoder);
>  	struct sun4i_crtc *crtc = drm_crtc_to_sun4i_crtc(encoder->crtc);
> @@ -353,7 +354,8 @@ static void sun4i_tv_disable(struct drm_encoder
> *encoder) sunxi_engine_disable_color_correction(crtc->engine);
>  }
> 
> -static void sun4i_tv_enable(struct drm_encoder *encoder)
> +static void sun4i_tv_enable(struct drm_encoder *encoder,
> +			    struct drm_atomic_state *state)
>  {
>  	struct sun4i_tv *tv = drm_encoder_to_sun4i_tv(encoder);
>  	struct sun4i_crtc *crtc = drm_crtc_to_sun4i_crtc(encoder->crtc);
> @@ -469,8 +471,8 @@ static void sun4i_tv_mode_set(struct drm_encoder
> *encoder, }
> 
>  static const struct drm_encoder_helper_funcs sun4i_tv_helper_funcs = {
> -	.disable	= sun4i_tv_disable,
> -	.enable		= sun4i_tv_enable,
> +	.atomic_disable	= sun4i_tv_disable,
> +	.atomic_enable	= sun4i_tv_enable,
>  	.mode_set	= sun4i_tv_mode_set,
>  };




