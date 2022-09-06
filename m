Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB51F5AF583
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 22:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbiIFUJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 16:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbiIFUJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 16:09:12 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39F622B1C
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 13:04:37 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id b16so16628875edd.4
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 13:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=plI2ccCtxFfQQaA/IHicso25P4hNeiGkni4LSwxPbm4=;
        b=Oa0+iWZ5DBGIMbtbaWYlC5APlU/wi67OB46kQ8Fked1WkqCJO7eSuYV4pXcpMtsrLh
         h4m8ns9bM2EwwF1pb3EvhBxIuI6zX9ev0R6fn6dUX6ngsdv7SQcvBDNqWnFLGSyURMsG
         3t1udFKm1hYrJJ9BkltIYCn31OmFy6AZPUQ8/Sj6T1LlhFdQjhA57LTt7OJxR5vTJLKR
         IuunwxnSMYyOBJoMqzyfHehMGdq3P/FdVikYQbvRTcieYwm9qSRwWDkFuVFhqCAaAZGj
         eCCSN7KdX2r0rqA0gSJxLFOqvSdqphm5EeP5zTMWlKZ20BzoIgCkXDmhh8P46XPQ9TEb
         YhLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=plI2ccCtxFfQQaA/IHicso25P4hNeiGkni4LSwxPbm4=;
        b=SzlxdmyuARIvzsSkxQZ6FxBQyUTTu+BBJrYjRqFc+8y9pEQB4zua8IusP66j3QEwWD
         oR8wCZTRa7NCu0VV90RgZhDG+rm8y0gKBUhQ9+RGzAPuv/VOpUtIzH/V/W9OcfglX8HA
         UzNzD9lTK8VN00EN1XaMpXiaVo/xYKulAaOih+qUiNsnwZvYZvFu7EjWWPtMN2jGnl+1
         lKRjZW19O1Ipl/wapAcf3v6uvyMjiaVzsEbG65VvD2VjRrRhdkCsiElLEXL8YLSB/h+J
         sLoqpuqwWqZPwxHoN5mtjKr8626J8Jk3EnMxEUjZMlvNQ+McrjADKHhs60dqot1BR8aH
         xGlA==
X-Gm-Message-State: ACgBeo3SD4/lQ52Gih86qNdEORBEvhD38i6bqXoGQOclHF0Atl4EAt86
        fVAieUs/MImYRT7k1hZ1ElI=
X-Google-Smtp-Source: AA6agR6Kk9aCcEfrY5Ey5jOi/kWmdkQVgNAUGJ16H1QclaprIGEZQnyZQvab5nv2idHUjXMCwzagDQ==
X-Received: by 2002:a05:6402:911:b0:44e:a5b4:74f7 with SMTP id g17-20020a056402091100b0044ea5b474f7mr211765edz.249.1662494675009;
        Tue, 06 Sep 2022 13:04:35 -0700 (PDT)
Received: from kista.localnet (82-149-1-172.dynamic.telemach.net. [82.149.1.172])
        by smtp.gmail.com with ESMTPSA id i6-20020a170906850600b0073d9a0d0cbcsm7193709ejx.72.2022.09.06.13.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 13:04:33 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Lyude Paul <lyude@redhat.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Samuel Holland <samuel@sholland.org>,
        Karol Herbst <kherbst@redhat.com>,
        Noralf =?ISO-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        Emma Anholt <emma@anholt.net>, Daniel Vetter <daniel@ffwll.ch>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Maxime Ripard <maxime@cerno.tech>
Cc:     Maxime Ripard <maxime@cerno.tech>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-arm-kernel@lists.infradead.org,
        Phil Elwell <phil@raspberrypi.com>,
        intel-gfx@lists.freedesktop.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        dri-devel@lists.freedesktop.org, Dom Cobley <dom@raspberrypi.com>,
        linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org,
        linux-sunxi@lists.linux.dev,
        Mateusz Kwiatkowski <kfyatek+publicgit@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 36/41] drm/sun4i: tv: Merge mode_set into atomic_enable
Date:   Tue, 06 Sep 2022 22:04:32 +0200
Message-ID: <10138422.nUPlyArG6x@kista>
In-Reply-To: <20220728-rpi-analog-tv-properties-v2-36-459522d653a7@cerno.tech>
References: <20220728-rpi-analog-tv-properties-v2-0-459522d653a7@cerno.tech> <20220728-rpi-analog-tv-properties-v2-36-459522d653a7@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne ponedeljek, 29. avgust 2022 ob 15:11:50 CEST je Maxime Ripard napisal(a):
> Our mode_set implementation can be merged into our atomic_enable
> implementation to simplify things, so let's do this.

Are you sure this is a good thing in long term? What if user wants to change 
mode? Unlikely, but why not.

Best regards,
Jernej

> 
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> 
> diff --git a/drivers/gpu/drm/sun4i/sun4i_tv.c
> b/drivers/gpu/drm/sun4i/sun4i_tv.c
> index f7aad995ab5b..3944da9a3c34 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_tv.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_tv.c
> @@ -359,23 +359,13 @@ static void sun4i_tv_enable(struct drm_encoder
> *encoder,
 {
>  	struct sun4i_tv *tv = drm_encoder_to_sun4i_tv(encoder);
>  	struct sun4i_crtc *crtc = drm_crtc_to_sun4i_crtc(encoder->crtc);
> -
> -	DRM_DEBUG_DRIVER("Enabling the TV Output\n");
> -
> -	sunxi_engine_apply_color_correction(crtc->engine);
> -
> -	regmap_update_bits(tv->regs, SUN4I_TVE_EN_REG,
> -			   SUN4I_TVE_EN_ENABLE,
> -			   SUN4I_TVE_EN_ENABLE);
> -}
> -
> -static void sun4i_tv_mode_set(struct drm_encoder *encoder,
> -			      struct drm_display_mode *mode,
> -			      struct drm_display_mode 
*adjusted_mode)
> -{
> -	struct sun4i_tv *tv = drm_encoder_to_sun4i_tv(encoder);
> +	struct drm_crtc_state *crtc_state =
> +		drm_atomic_get_new_crtc_state(state, encoder->crtc);
> +	struct drm_display_mode *mode = &crtc_state->mode;
>  	const struct tv_mode *tv_mode = sun4i_tv_find_tv_by_mode(mode);
>  
> +	DRM_DEBUG_DRIVER("Enabling the TV Output\n");
> +
>  	/* Enable and map the DAC to the output */
>  	regmap_update_bits(tv->regs, SUN4I_TVE_EN_REG,
>  			   SUN4I_TVE_EN_DAC_MAP_MASK,
> @@ -468,12 +458,17 @@ static void sun4i_tv_mode_set(struct drm_encoder
> *encoder,
> SUN4I_TVE_RESYNC_FIELD : 0));
>  
>  	regmap_write(tv->regs, SUN4I_TVE_SLAVE_REG, 0);
> +
> +	sunxi_engine_apply_color_correction(crtc->engine);
> +
> +	regmap_update_bits(tv->regs, SUN4I_TVE_EN_REG,
> +			   SUN4I_TVE_EN_ENABLE,
> +			   SUN4I_TVE_EN_ENABLE);
>  }
>  
>  static const struct drm_encoder_helper_funcs sun4i_tv_helper_funcs = {
>  	.atomic_disable	= sun4i_tv_disable,
>  	.atomic_enable	= sun4i_tv_enable,
> -	.mode_set	= sun4i_tv_mode_set,
>  };
>  
>  static int sun4i_tv_comp_get_modes(struct drm_connector *connector)
> 
> -- 
> b4 0.10.0-dev-65ba7



