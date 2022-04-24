Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8079150D4FF
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 22:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239530AbiDXUJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 16:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235691AbiDXUJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 16:09:12 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9840F2124D;
        Sun, 24 Apr 2022 13:06:09 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id y3so5583607ejo.12;
        Sun, 24 Apr 2022 13:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=88N/1qAZ8VIjuS2R1sRrs/MALWlEK6AkrWPDLccyzys=;
        b=K1edaGaOacjw80WVtueFnAw4giTEfU2sak5dGFtN6QQLPFylYk0rANxVN+weUL2Sed
         EYlRbQtra/oEBwdIisXjiI62T9ecUkEbHqCtePlXJY7WiGLcYETVAHRew6Pf+FxzNj0L
         p2BwMYyGxAPaaFedkJIvDfNh+pjmVFeExPl9OdAdECsbB6VpeKdmeMRWa5fux8NLPsI/
         I4G4ixkWLXjUA0CQsN9ipzeRPtJssww5pZWMuwlU+7C8CDrpzhIQjf4fxsG7/00jmEgk
         ZVJpmSNWUIzopYiPkICQ5hQCGjtTMAxk+HTsDor5y5tBpq49ABc8WTCi8MMjDlb1npgi
         sAhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=88N/1qAZ8VIjuS2R1sRrs/MALWlEK6AkrWPDLccyzys=;
        b=3Qi0cT/xXiK6Xwcwl5CgnYPWpXruV1NaqLJRnmtlk39ak1+hetRNiDYhTvm5QzahgI
         rPrWu1CednsNrRNargE6S6SZ053ZDh+aT7agOchw5Mwyo9lk/whIgQqK4hlM9RW41m9/
         evGk4pK6pOka55Sho8Sci+E0k4KJgw/q+oGctxx3+My7j3peMNJtNvCbaYWKZBXz3w2T
         yi1Sdmh320SD3/zGeyXuyjs8gvxbFDBoVtUsa+Dkp4Ut0ggnm2EAzgrlylJ1Wp80VUfu
         p92vmoCgY0i3PG5t/m+ilsif3dkzvN6Sv7PLg8hoXrN9Bx1n8XezPZSrUB8nBapsRcis
         isRA==
X-Gm-Message-State: AOAM532xqMDY1nHa1/CQJr7w8bp78p5hvmuQNvNohxWqE+45Zn6Z3jXV
        c62Xcbfh83wnE23/WDakNIc=
X-Google-Smtp-Source: ABdhPJwPTndJLo/fj/nqzGhKpv1Odq/tnRLyRXZ6JHKhIo3rLA9hBiZqsjUjKlaQ5rMdlZP0TTa1hA==
X-Received: by 2002:a17:906:4fc8:b0:6d8:5059:f998 with SMTP id i8-20020a1709064fc800b006d85059f998mr13536450ejw.487.1650830768172;
        Sun, 24 Apr 2022 13:06:08 -0700 (PDT)
Received: from kista.localnet (cpe-86-58-32-107.static.triera.net. [86.58.32.107])
        by smtp.gmail.com with ESMTPSA id b17-20020a170906195100b006e8be812f08sm2956838eje.0.2022.04.24.13.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 13:06:07 -0700 (PDT)
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
Subject: Re: [PATCH v3 12/14] drm/sun4i: Add support for D1 TCON TOP
Date:   Sun, 24 Apr 2022 22:06:06 +0200
Message-ID: <13000910.uLZWGnKmhe@kista>
In-Reply-To: <20220424162633.12369-13-samuel@sholland.org>
References: <20220424162633.12369-1-samuel@sholland.org> <20220424162633.12369-13-samuel@sholland.org>
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

Dne nedelja, 24. april 2022 ob 18:26:30 CEST je Samuel Holland napisal(a):
> D1 has a TCON TOP with TCON TV0 and DSI, but no TCON TV1. This puts the
> DSI clock name at index 1 in clock-output-names. Support this by only
> incrementing the index for clocks that are actually supported.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej Skrabec

> ---
> 
> (no changes since v1)
> 
>  drivers/gpu/drm/sun4i/sun8i_tcon_top.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun8i_tcon_top.c b/drivers/gpu/drm/sun4i/
sun8i_tcon_top.c
> index 1b9b8b48f4a7..da97682b6835 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
> @@ -189,22 +189,23 @@ static int sun8i_tcon_top_bind(struct device *dev, 
struct device *master,
>  	 * if TVE is active on each TCON TV. If it is, mux should be 
switched
>  	 * to TVE clock parent.
>  	 */
> +	i = 0;
>  	clk_data->hws[CLK_TCON_TOP_TV0] =
>  		sun8i_tcon_top_register_gate(dev, "tcon-tv0", regs,
>  					     &tcon_top-
>reg_lock,
> -					     
TCON_TOP_TCON_TV0_GATE, 0);
> +					     
TCON_TOP_TCON_TV0_GATE, i++);
>  
>  	if (quirks->has_tcon_tv1)
>  		clk_data->hws[CLK_TCON_TOP_TV1] =
>  			sun8i_tcon_top_register_gate(dev, "tcon-
tv1", regs,
>  						     
&tcon_top->reg_lock,
> -						     
TCON_TOP_TCON_TV1_GATE, 1);
> +						     
TCON_TOP_TCON_TV1_GATE, i++);
>  
>  	if (quirks->has_dsi)
>  		clk_data->hws[CLK_TCON_TOP_DSI] =
>  			sun8i_tcon_top_register_gate(dev, "dsi", 
regs,
>  						     
&tcon_top->reg_lock,
> -						     
TCON_TOP_TCON_DSI_GATE, 2);
> +						     
TCON_TOP_TCON_DSI_GATE, i++);
>  
>  	for (i = 0; i < CLK_NUM; i++)
>  		if (IS_ERR(clk_data->hws[i])) {
> @@ -272,6 +273,10 @@ static const struct sun8i_tcon_top_quirks 
sun8i_r40_tcon_top_quirks = {
>  	.has_dsi	= true,
>  };
>  
> +static const struct sun8i_tcon_top_quirks sun20i_d1_tcon_top_quirks = {
> +	.has_dsi	= true,
> +};
> +
>  static const struct sun8i_tcon_top_quirks sun50i_h6_tcon_top_quirks = {
>  	/* Nothing special */
>  };
> @@ -282,6 +287,10 @@ const struct of_device_id sun8i_tcon_top_of_table[] = {
>  		.compatible = "allwinner,sun8i-r40-tcon-top",
>  		.data = &sun8i_r40_tcon_top_quirks
>  	},
> +	{
> +		.compatible = "allwinner,sun20i-d1-tcon-top",
> +		.data = &sun20i_d1_tcon_top_quirks
> +	},
>  	{
>  		.compatible = "allwinner,sun50i-h6-tcon-top",
>  		.data = &sun50i_h6_tcon_top_quirks
> -- 
> 2.35.1
> 
> 


