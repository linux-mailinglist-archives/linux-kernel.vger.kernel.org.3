Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 032CC48306D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 12:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232951AbiACLWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 06:22:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231570AbiACLWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 06:22:30 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB47C061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 03:22:30 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id w20so60264707wra.9
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 03:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BNbTKpjbmWU2ee+fIXH6oE6o9ijvgMX48fYdOT45X/Q=;
        b=b3llH14P0tfs30LgRrpzXrfr0/n+TkaCFTaW3eqCfql3dGHMmzBmYbjldPk30kJtFq
         VeHKftyBKTQ4mXPxNBDGjuani4Inopixvs9yPJcxoJY02+glRC+806t5RC2nMMTxUMG7
         h7Ilc2xD1NY6yvaZLZSjJNO2DIjEB4KSoRDc8qnE3avLo1LlXmpZptmS7qfYmd0yPrV5
         oL2Aq71fYpe2+MCYZqyFIRInof5FoFR4DDY1XQCaI0HhVIb17K982XRxtz4jHHy44xqQ
         4Nn33FcnMU0VgVxLl2d0MkPjmJXvYo92PDEMo8UXpVIN2rydjDUSe06mDYsIwEKaMAWd
         mo1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=BNbTKpjbmWU2ee+fIXH6oE6o9ijvgMX48fYdOT45X/Q=;
        b=rTFL7RHWft8u7fXdmN8Gl7ZWPq8HDzxBvj/KOTHDYuBYjZ9iiHEzh6Z0/okAevIxoA
         bU18fW6KLsrw4ioReAY9m7+D1ZIg7vw5Dwg2rxPbS1mtdHtYQVRuDW+qtHMOxeHhPKsP
         8B6J0bI1pJqbAg943o23pz4v9l3i+X8waNtzJggpj4uTnXbmGOSzdSRbNMjTh1yYZEEi
         BThPW9ZbNP50gWjznUqd4hD38MiXQny+5rRoeRmZn2BBC98E4ZH0pyKzeW8V3goq95wU
         QqYmI37TkjLni+n4UCgOxkLleLmaCGzQQUkixoBwKKj00Co1zVAiKCrBeGwoYBxLcrZp
         tgLw==
X-Gm-Message-State: AOAM530RPMRIGr5LdYaUr75Q5rHIsGoP3l4AwnalRZnz8l2niNobUmug
        qnzEfPELSvj0P5Gv1HKx3rOkKzk5LY9TXQ==
X-Google-Smtp-Source: ABdhPJwlW5bTY0c+ncM+C9gmKuAqCov9E4Zx3krZ9I9IaDZkpiD+J1KC4iz71QV3+92ok2Ll7laMnQ==
X-Received: by 2002:adf:e0ce:: with SMTP id m14mr20370362wri.630.1641208948255;
        Mon, 03 Jan 2022 03:22:28 -0800 (PST)
Received: from ?IPv6:2001:861:44c0:66c0:7c9d:a967:38e2:5220? ([2001:861:44c0:66c0:7c9d:a967:38e2:5220])
        by smtp.gmail.com with ESMTPSA id b2sm38209160wrd.35.2022.01.03.03.22.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jan 2022 03:22:27 -0800 (PST)
Subject: Re: [PATCH 2/2] drm/meson: Fix error handling when afbcd.ops->init
 fails
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20211230235515.1627522-1-martin.blumenstingl@googlemail.com>
 <20211230235515.1627522-3-martin.blumenstingl@googlemail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <386f5be4-eca0-6117-82f5-317b82ee66a7@baylibre.com>
Date:   Mon, 3 Jan 2022 12:22:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211230235515.1627522-3-martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/12/2021 00:55, Martin Blumenstingl wrote:
> When afbcd.ops->init fails we need to free the struct drm_device. Also
> all errors which come after afbcd.ops->init was successful need to exit
> the AFBCD, just like meson_drv_unbind() does.
> 
> Fixes: d1b5e41e13a7e9 ("drm/meson: Add AFBCD module driver")
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  drivers/gpu/drm/meson/meson_drv.c | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
> index b919271a6e50..26aeaf0ab86e 100644
> --- a/drivers/gpu/drm/meson/meson_drv.c
> +++ b/drivers/gpu/drm/meson/meson_drv.c
> @@ -302,42 +302,42 @@ static int meson_drv_bind_master(struct device *dev, bool has_components)
>  	if (priv->afbcd.ops) {
>  		ret = priv->afbcd.ops->init(priv);
>  		if (ret)
> -			return ret;
> +			goto free_drm;
>  	}
>  
>  	/* Encoder Initialization */
>  
>  	ret = meson_encoder_cvbs_init(priv);
>  	if (ret)
> -		goto free_drm;
> +		goto exit_afbcd;
>  
>  	if (has_components) {
>  		ret = component_bind_all(drm->dev, drm);
>  		if (ret) {
>  			dev_err(drm->dev, "Couldn't bind all components\n");
> -			goto free_drm;
> +			goto exit_afbcd;
>  		}
>  	}
>  
>  	ret = meson_encoder_hdmi_init(priv);
>  	if (ret)
> -		goto free_drm;
> +		goto exit_afbcd;
>  
>  	ret = meson_plane_create(priv);
>  	if (ret)
> -		goto free_drm;
> +		goto exit_afbcd;
>  
>  	ret = meson_overlay_create(priv);
>  	if (ret)
> -		goto free_drm;
> +		goto exit_afbcd;
>  
>  	ret = meson_crtc_create(priv);
>  	if (ret)
> -		goto free_drm;
> +		goto exit_afbcd;
>  
>  	ret = request_irq(priv->vsync_irq, meson_irq, 0, drm->driver->name, drm);
>  	if (ret)
> -		goto free_drm;
> +		goto exit_afbcd;
>  
>  	drm_mode_config_reset(drm);
>  
> @@ -355,6 +355,9 @@ static int meson_drv_bind_master(struct device *dev, bool has_components)
>  
>  uninstall_irq:
>  	free_irq(priv->vsync_irq, drm);
> +exit_afbcd:
> +	if (priv->afbcd.ops)
> +		priv->afbcd.ops->exit(priv);
>  free_drm:
>  	drm_dev_put(drm);
>  
> 

Acked-by: Neil Armstrong <narmstrong@baylibre.com>

Thanks,

But this depends on patch 1, so I'll add the same Fixes tag on patch 1 and add to drm-misc-next so it won't pollute -fixes but will still be eventually be backported when landing on linus master.

Neil
