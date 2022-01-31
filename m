Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21BD64A3C10
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 01:03:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243863AbiAaADo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 19:03:44 -0500
Received: from gloria.sntech.de ([185.11.138.130]:55888 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235023AbiAaADn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 19:03:43 -0500
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nEKAS-0003bh-DW; Mon, 31 Jan 2022 01:03:36 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Jagan Teki <jagan@amarulasolutions.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     Peter Geis <pgwipeout@gmail.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] drm/panel: feiyang-fy07024di26a30d: make reset gpio optional
Date:   Mon, 31 Jan 2022 01:03:35 +0100
Message-ID: <4380260.tF47cCTlra@diego>
In-Reply-To: <20220107051335.3812535-3-pgwipeout@gmail.com>
References: <20220107051335.3812535-1-pgwipeout@gmail.com> <20220107051335.3812535-3-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

Am Freitag, 7. Januar 2022, 06:13:33 CET schrieb Peter Geis:
> Some implementations do not use the reset signal, instead tying it to dvdd.
> Make the reset gpio optional to permit this.
> 
> Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> ---
>  drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c b/drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c
> index 581661b506f8..1c88d752b14e 100644
> --- a/drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c
> +++ b/drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c
> @@ -65,7 +65,8 @@ static int feiyang_prepare(struct drm_panel *panel)
>  	/* T3 (dvdd rise + avdd start + avdd rise) T3 >= 20ms */
>  	msleep(20);
>  
> -	gpiod_set_value(ctx->reset, 0);
> +	if (ctx->reset)
> +		gpiod_set_value(ctx->reset, 0);

gpio_set_value does 
	VALIDATE_DESC_VOID(desc);

which checks for "desc" (ctx->reset in this case) to be valid and especially
not null and simply returns when this is the case.

So from what I see, we don't need all the added conditionals here and below
and would just need the switch to devm_gpiod_get_optional alone.

Heiko

>  
>  	/*
>  	 * T5 + T6 (avdd rise + video & logic signal rise)
> @@ -73,7 +74,8 @@ static int feiyang_prepare(struct drm_panel *panel)
>  	 */
>  	msleep(20);
>  
> -	gpiod_set_value(ctx->reset, 1);
> +	if (ctx->reset)
> +		gpiod_set_value(ctx->reset, 1);
>  
>  	/* T12 (video & logic signal rise + backlight rise) T12 >= 200ms */
>  	msleep(200);
> @@ -126,7 +128,8 @@ static int feiyang_unprepare(struct drm_panel *panel)
>  	/* T13 (backlight fall + video & logic signal fall) T13 >= 200ms */
>  	msleep(200);
>  
> -	gpiod_set_value(ctx->reset, 0);
> +	if (ctx->reset)
> +		gpiod_set_value(ctx->reset, 0);
>  
>  	regulator_disable(ctx->avdd);
>  
> @@ -211,7 +214,7 @@ static int feiyang_dsi_probe(struct mipi_dsi_device *dsi)
>  		return PTR_ERR(ctx->avdd);
>  	}
>  
> -	ctx->reset = devm_gpiod_get(&dsi->dev, "reset", GPIOD_OUT_LOW);
> +	ctx->reset = devm_gpiod_get_optional(&dsi->dev, "reset", GPIOD_OUT_LOW);
>  	if (IS_ERR(ctx->reset)) {
>  		dev_err(&dsi->dev, "Couldn't get our reset GPIO\n");
>  		return PTR_ERR(ctx->reset);
> 




