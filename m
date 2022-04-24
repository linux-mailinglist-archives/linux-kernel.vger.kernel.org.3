Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E60650D502
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 22:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235691AbiDXULY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 16:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiDXULS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 16:11:18 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F74188B10;
        Sun, 24 Apr 2022 13:08:16 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id g6so3136048ejw.1;
        Sun, 24 Apr 2022 13:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sudUzil2TeGtGGqvHjugQsy8d/UrN+DwGR4+Ef4x1Kg=;
        b=maOBumgDQGBkUzklplB1UFE2bwWZfJQfJTafW0PmOMkFWVnN2oeXdc7HPJnueqqqV/
         YNnhAncdsA+C1p1GcZ98NsTyatxwo0LXVBs1NiLmxnINTWSbMfEOVnihqXtTcDMhSTKG
         EmHkhppovTi80fY72HGDLMYCZUe/+FpITY4xmjr0qPR1k9TfcVBX0rUesp0oQ9mIM4Jj
         4xJx3E3XfAGdqzzJwF644y9q2lZfCerI20QlBzZ/mJelnFMlMTaA4S7y4At4iU+I5iKO
         f7yOxm/FAY2uizoM5Pk9kLXG+U9FB3ClSK2JvfFC7bMsQxMNWB0b6w9/QBdNDfuVCZ94
         IrDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sudUzil2TeGtGGqvHjugQsy8d/UrN+DwGR4+Ef4x1Kg=;
        b=W5KLACly7MHVO+ge2893xvmxlKItQ0Wyal7KPTgxPbGh6RhKdsxykOL0MVesc41gEl
         0TncdChaaiL8qkbkmHDLwIFzxMSsP+MMjrQx3c3DKQWupbDr8f/z6VMWnjJK8qvlAuYG
         X2HFlMKUkL+1UyHEAJxU2nhLDUc0u7Th+08cHCnOeS+xCWQSxhx/IXiRe2gvU0GjsHYt
         NSgbXk+mwe+ISAEmGNxipy7KZIsde5G/WzBjLwDwlLFSowAkIKvVyDSX48Ampxk7bc0I
         V5X4CmKaEvZHq+ctylSn7VeBAAJyKdlo6acPyIPMdvVYgu8YUHuYWhHN7pTByFOFYWcX
         OAhQ==
X-Gm-Message-State: AOAM533LJmNRARIuED9DMYfOBxcnFoBPTWsWrADF+Si3KHF2i3g/LorW
        FHixIYhzoxMDREEMR02idVQ=
X-Google-Smtp-Source: ABdhPJyHJKKOxw8s1yJlNHqrD4UJnk4HSPgCDiT1JHiiYrtZFxHbUJW0QWUiJ2r37sWgPoDPw2ht3A==
X-Received: by 2002:a17:907:7704:b0:6cf:48ac:b4a8 with SMTP id kw4-20020a170907770400b006cf48acb4a8mr13128991ejc.305.1650830895109;
        Sun, 24 Apr 2022 13:08:15 -0700 (PDT)
Received: from kista.localnet (cpe-86-58-32-107.static.triera.net. [86.58.32.107])
        by smtp.gmail.com with ESMTPSA id p12-20020a50c94c000000b00425c48132bfsm2982323edh.55.2022.04.24.13.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 13:08:14 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <mripard@kernel.org>,
        Samuel Holland <samuel@sholland.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v3 13/14] drm/sun4i: Add support for D1 TCONs
Date:   Sun, 24 Apr 2022 22:08:13 +0200
Message-ID: <3164754.aeNJFYEL58@kista>
In-Reply-To: <20220424162633.12369-14-samuel@sholland.org>
References: <20220424162633.12369-1-samuel@sholland.org> <20220424162633.12369-14-samuel@sholland.org>
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

Dne nedelja, 24. april 2022 ob 18:26:31 CEST je Samuel Holland napisal(a):
> D1 has a TCON TOP, so its quirks are similar to those for the R40 TCONs.
> While there are some register changes, the part of the TCON TV supported
> by the driver matches the R40 quirks, so that quirks structure can be
> reused. D1 has the first supported TCON LCD with a TCON TOP, so the TCON
> LCD needs a new quirks structure.
> 
> D1's TCON LCD hardware supports LVDS; in fact it provides dual-link LVDS
> from a single TCON. However, it comes with a brand new LVDS PHY. Since
> this PHY has not been tested, leave out LVDS driver support for now.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej Skrabec

> ---
> 
> (no changes since v1)
> 
>  drivers/gpu/drm/sun4i/sun4i_tcon.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/
sun4i_tcon.c
> index 88db2d2a9336..2ee158aaeb9e 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> @@ -1542,6 +1542,12 @@ static const struct sun4i_tcon_quirks 
sun9i_a80_tcon_tv_quirks = {
>  	.needs_edp_reset = true,
>  };
>  
> +static const struct sun4i_tcon_quirks sun20i_d1_lcd_quirks = {
> +	.has_channel_0		= true,
> +	.dclk_min_div		= 1,
> +	.set_mux		= sun8i_r40_tcon_tv_set_mux,
> +};
> +
>  /* sun4i_drv uses this list to check if a device node is a TCON */
>  const struct of_device_id sun4i_tcon_of_table[] = {
>  	{ .compatible = "allwinner,sun4i-a10-tcon", .data = 
&sun4i_a10_quirks },
> @@ -1559,6 +1565,8 @@ const struct of_device_id sun4i_tcon_of_table[] = {
>  	{ .compatible = "allwinner,sun8i-v3s-tcon", .data = 
&sun8i_v3s_quirks },
>  	{ .compatible = "allwinner,sun9i-a80-tcon-lcd", .data = 
&sun9i_a80_tcon_lcd_quirks },
>  	{ .compatible = "allwinner,sun9i-a80-tcon-tv", .data = 
&sun9i_a80_tcon_tv_quirks },
> +	{ .compatible = "allwinner,sun20i-d1-tcon-lcd", .data = 
&sun20i_d1_lcd_quirks },
> +	{ .compatible = "allwinner,sun20i-d1-tcon-tv", .data = 
&sun8i_r40_tv_quirks },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, sun4i_tcon_of_table);
> -- 
> 2.35.1
> 
> 


