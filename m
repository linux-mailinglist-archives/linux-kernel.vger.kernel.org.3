Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECCBC585960
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 11:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233551AbiG3JOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 05:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbiG3JOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 05:14:48 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F773DF19
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 02:14:47 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id bp15so12168161ejb.6
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 02:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i+7O6hms/hqLnG44y9CuXX+hyQPYHHY40QX+YQRZrcQ=;
        b=I463grYfVol0JRUlt+Ar+SpcJUB4ZO9pNGMk3/6nbERWzXNnIlibdYQ9cGLRUwcdn0
         7fPs1V3TsdNGHjKKB5BGN45EUyF7Wugi7wwhUJ/7OxSNvgtsEo1A8biJVgtzfbXFqgfK
         I2oOZ6oRwBoo7JEE1aAnCwt43GepXKPWGHhnUmmM6ZV+wrcdgIu5wwhgd1X934R+b+PS
         N+pb9eFkY8TnaObP8ZIpEJwsPFxFwSNi9+uy+Ucj9ofrw7BTQe8qYLQRsn56BEQmQhkc
         4Rl8DvXCRHTHsdydiNGH8CZ0PJtM3lIFi7IlIKiKUDGDHkYi4jP9KdDTDjAxBLxSVhck
         XRfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i+7O6hms/hqLnG44y9CuXX+hyQPYHHY40QX+YQRZrcQ=;
        b=5aV3dz18x/WDksJmM7F72pK5G1p3enAcHwrgYfaUNHMYd560Fef9LSVOXQ4SoQcRc6
         GWbmXvdcZe5tjbtU3HaUPt02MDlY9jfR4cfdo82MC8pf9O3SbmWKeAtGDWajrSRM/rcp
         DpcVtTtwFsptXqnsSdlNFpzbjqCuyngns3vsPMRKb4VmW6QjL6v3u+AEw62bgei7zE22
         gejHaUylmzLGx4KLEZlazu07pE1j9g5GR/qJ4XtqAI9BCog3xELSiO58Ym17R4ksiCi1
         n6WgmE+gjpbJpm0D3pA7xBLLjRr/ICm2/FqZhHheYadm8F83gYquuNWgb7FrnGAvY81O
         QjXw==
X-Gm-Message-State: ACgBeo0bcHPLZu9W91INKTuZ/SWsZZQKrYY/t9tM9m+W8RbqdLBdaUxz
        GhBLTqnVf/OJ3lRTbkYmOmU=
X-Google-Smtp-Source: AA6agR4VYJrXZiOXIvhb8G1HuoD3AuMr4cbsju8RIBJv//kfsMPN/cLW/Y0CDv/M1HP7A2m0gTyCfw==
X-Received: by 2002:a17:907:75f7:b0:730:5b01:56b0 with SMTP id jz23-20020a17090775f700b007305b0156b0mr145624ejc.689.1659172485555;
        Sat, 30 Jul 2022 02:14:45 -0700 (PDT)
Received: from jernej-laptop.localnet (194-152-27-124.dynamic.telemach.net. [194.152.27.124])
        by smtp.gmail.com with ESMTPSA id p3-20020a17090653c300b00730223dc5c0sm2204354ejo.206.2022.07.30.02.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jul 2022 02:14:45 -0700 (PDT)
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
Subject: Re: [PATCH v1 29/35] drm/sun4i: tv: Remove useless destroy function
Date:   Sat, 30 Jul 2022 11:14:43 +0200
Message-ID: <4754901.31r3eYUQgx@jernej-laptop>
In-Reply-To: <20220728-rpi-analog-tv-properties-v1-29-3d53ae722097@cerno.tech>
References: <20220728-rpi-analog-tv-properties-v1-0-3d53ae722097@cerno.tech> <20220728-rpi-analog-tv-properties-v1-29-3d53ae722097@cerno.tech>
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

Dne petek, 29. julij 2022 ob 18:35:12 CEST je Maxime Ripard napisal(a):
> Our destroy implementation is just calling the generic helper, so let's
> just remove our function and directly use the helper.
> 
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> 
> diff --git a/drivers/gpu/drm/sun4i/sun4i_tv.c
> b/drivers/gpu/drm/sun4i/sun4i_tv.c index 52bbba8f19dc..6d7e1d51569a 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_tv.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_tv.c
> @@ -491,15 +491,9 @@ static const struct drm_connector_helper_funcs
> sun4i_tv_comp_connector_helper_fu .get_modes	= sun4i_tv_comp_get_modes,
>  };
> 
> -static void
> -sun4i_tv_comp_connector_destroy(struct drm_connector *connector)
> -{
> -	drm_connector_cleanup(connector);
> -}
> -
>  static const struct drm_connector_funcs sun4i_tv_comp_connector_funcs = {
>  	.fill_modes		= drm_helper_probe_single_connector_modes,
> -	.destroy		= sun4i_tv_comp_connector_destroy,
> +	.destroy		= drm_connector_cleanup,
>  	.reset			= 
drm_atomic_helper_connector_reset,
>  	.atomic_duplicate_state	= 
drm_atomic_helper_connector_duplicate_state,
>  	.atomic_destroy_state	= 
drm_atomic_helper_connector_destroy_state,




