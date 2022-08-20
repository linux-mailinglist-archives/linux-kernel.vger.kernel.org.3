Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C13E359AF21
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 19:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346133AbiHTRXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 13:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiHTRXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 13:23:01 -0400
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D316440E3C
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 10:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org
        ; s=ds202112; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=8BklGePlOGzlIbyB2AgDUWEPfUhqmEkqZKMYHVCAb3o=; b=N/8vyFTCNC0NQfLmopwfofzrMI
        cxEchZwTKKEv3rOttPBJkoH3/az9oOr+CeJG2ofTnEKJBK4cTDNGj+5xWzB2Sp2I8HmKkoHZhMe6M
        sbw5MdTw7QL2H6KTDimKuwPJsfTQM4vgCYA6U0HJdmnjP5gno5KQdcwR+uCvarfxd1kBAI1ydLdn6
        O+uKEhq+KmwB0qKN+WjHHZxzCS4Gnp4j4HuHKP4AO4y/cZUwXAqi8Y4LjrpE8fmjtNRfZxAsoKwOF
        L6c/nh1rdlDkw/ecDnLLBpRKG29oFbgNu/ilORvV+04iF7sdVDASM0SPQo9bW+jHsIKt1nvxVJuKp
        KjU9Fxqg==;
Received: from [2a01:799:961:d200:cca0:57ac:c55d:a485] (port=55975)
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <noralf@tronnes.org>)
        id 1oPSBU-0001ci-DT; Sat, 20 Aug 2022 19:22:56 +0200
Message-ID: <0255f7c6-0484-6456-350d-cf24f3fee5d6@tronnes.org>
Date:   Sat, 20 Aug 2022 19:22:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v1 23/35] drm/vc4: vec: Convert to the new TV mode
 property
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
        Dom Cobley <dom@raspberrypi.com>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
References: <20220728-rpi-analog-tv-properties-v1-0-3d53ae722097@cerno.tech>
 <20220728-rpi-analog-tv-properties-v1-23-3d53ae722097@cerno.tech>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
In-Reply-To: <20220728-rpi-analog-tv-properties-v1-23-3d53ae722097@cerno.tech>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 29.07.2022 18.35, skrev Maxime Ripard:
> Now that the core can deal fine with analog TV modes, let's convert the vc4
> VEC driver to leverage those new features.
> 
> We've added some backward compatibility to support the old TV mode property
> and translate it into the new TV norm property.
> 
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> 
> diff --git a/drivers/gpu/drm/vc4/vc4_vec.c b/drivers/gpu/drm/vc4/vc4_vec.c

>  static int vc4_vec_connector_get_modes(struct drm_connector *connector)
>  {
> -	struct drm_connector_state *state = connector->state;
>  	struct drm_display_mode *mode;
>  
> -	mode = drm_mode_duplicate(connector->dev,
> -				  vc4_vec_tv_modes[state->tv.mode].mode);
> +	mode = drm_mode_duplicate(connector->dev, &drm_mode_480i);
> +	if (!mode) {
> +		DRM_ERROR("Failed to create a new display mode\n");
> +		return -ENOMEM;
> +	}
> +
> +	drm_mode_probed_add(connector, mode);
> +
> +	mode = drm_mode_duplicate(connector->dev, &drm_mode_576i);

Maybe the mode that matches tv.norm should be marked as preferred so
userspace knows which one to pick?

Noralf.

>  	if (!mode) {
>  		DRM_ERROR("Failed to create a new display mode\n");
>  		return -ENOMEM;
> @@ -277,21 +313,95 @@ static int vc4_vec_connector_get_modes(struct drm_connector *connector)
>  	return 1;
>  }
