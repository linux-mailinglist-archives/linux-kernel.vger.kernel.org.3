Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE83A585963
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 11:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233619AbiG3JP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 05:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233508AbiG3JPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 05:15:24 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B9BAEE10
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 02:15:22 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id bp15so12169443ejb.6
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 02:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rwWtE2tS+sQfxC0TkYkw+6LysHn8HM6so6RxZNUEwWQ=;
        b=cUuJZ0nzayLtd8sD1yqDO+l52EhIAyWq6fLaHZagbbZVJKKCUYyqC0sLoFqK5i10zC
         OiQN+JhbXIBEd+ifQUUou0Xm4CHUyrEtDHAFIfsJ/thybpafFsKAGPc+zRW8drWcD/2y
         MbcptzAARs9f2bw9vbEiLNPGkXipLLlozKnC8B+j1/A0VCwDPynRlCFADJymcs/nZQMq
         0r+PNxvDlrSlp8SkpMFbTyC2zaG1kGz6VKlhT0BnkbvQfXkLmm9augDHwmRVcE0vsk27
         xIUv8XBlV3TzjiCAoD1ucUi3DHMqMiTxaxbG+/0huI6IfOY2cXOfRUJCzDSSbZHbPWt6
         B20A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rwWtE2tS+sQfxC0TkYkw+6LysHn8HM6so6RxZNUEwWQ=;
        b=ZQWSnncpfuD/NJHxRuN//P+zA9apQRPLAxZRH6voXE9TyZ9oWxAY8GtJW86XVY/8Zu
         EQnaqdJckNuGnUT5H/tFp+PyfLHDOa/d2WS4pyOVavaGpL2yZaaw7evk1Z6Njjg+wOIs
         IZdd0PUr3PMmTuJq+PCtDhpjK5mLDeY6QNJtvLXHIpbyMT+kKGwpW6Hs9Knq0wlnsGRA
         MCrXe06Y5AzKWTYpKYIgHTuvp3IaLhzugWDJLT078Sp6L4xatR/yeL8873lJl4U+KLrP
         CvldrtH6yNl1hhX2xRKf2jR2icQB2VEJ+Ih829UxNVDVXrt6eZ6oFiEBybE+Ym/TMgTU
         H7Bg==
X-Gm-Message-State: AJIora88GrRc4LTd+3r5zOOo/IzrmGwJO4KFT9s1fP2UTlF3LLbY7XAT
        AbPFr2uIyAP6c+7hU86eAuA=
X-Google-Smtp-Source: AGRyM1uUUQf/u0gQ0J3VcW2S6C2L6ixaRhj3FiMEXuT1uyjb9VsBFnqW3+WGYV9mlP57pVmny/vcAA==
X-Received: by 2002:a17:907:7638:b0:72d:f11b:5ebb with SMTP id jy24-20020a170907763800b0072df11b5ebbmr5799655ejc.647.1659172521175;
        Sat, 30 Jul 2022 02:15:21 -0700 (PDT)
Received: from jernej-laptop.localnet (194-152-27-124.dynamic.telemach.net. [194.152.27.124])
        by smtp.gmail.com with ESMTPSA id g5-20020a056402114500b0043cf0d56a61sm3623915edw.8.2022.07.30.02.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jul 2022 02:15:20 -0700 (PDT)
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
Subject: Re: [PATCH v1 30/35] drm/sun4i: tv: Rename error label
Date:   Sat, 30 Jul 2022 11:15:19 +0200
Message-ID: <2245985.ElGaqSPkdT@jernej-laptop>
In-Reply-To: <20220728-rpi-analog-tv-properties-v1-30-3d53ae722097@cerno.tech>
References: <20220728-rpi-analog-tv-properties-v1-0-3d53ae722097@cerno.tech> <20220728-rpi-analog-tv-properties-v1-30-3d53ae722097@cerno.tech>
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

Dne petek, 29. julij 2022 ob 18:35:13 CEST je Maxime Ripard napisal(a):
> The other error labels in sun4i_tv_bind() are named after the task they
> perform (err_disable_clk to call clk_disable_unprepare for example).
> 
> However, the err_cleanup_connector is named after the calling site
> (drm_connector_init failing) and will actually cleanup the encoder. Let's
> rename it to err_cleanup_encoder to be consistent.
> 
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> 
> diff --git a/drivers/gpu/drm/sun4i/sun4i_tv.c
> b/drivers/gpu/drm/sun4i/sun4i_tv.c index 6d7e1d51569a..ad6a3739bfa9 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_tv.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_tv.c
> @@ -580,7 +580,7 @@ static int sun4i_tv_bind(struct device *dev, struct
> device *master, if (ret) {
>  		dev_err(dev,
>  			"Couldn't initialise the Composite 
connector\n");
> -		goto err_cleanup_connector;
> +		goto err_cleanup_encoder;
>  	}
>  	tv->connector.interlace_allowed = true;
> 
> @@ -588,7 +588,7 @@ static int sun4i_tv_bind(struct device *dev, struct
> device *master,
> 
>  	return 0;
> 
> -err_cleanup_connector:
> +err_cleanup_encoder:
>  	drm_encoder_cleanup(&tv->encoder);
>  err_disable_clk:
>  	clk_disable_unprepare(tv->clk);




