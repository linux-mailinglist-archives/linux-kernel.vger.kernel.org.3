Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8E3496388
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 18:05:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244026AbiAURFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 12:05:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232557AbiAURFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 12:05:44 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB36DC06173D
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 09:05:43 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id e9-20020a05600c4e4900b0034d23cae3f0so23165796wmq.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 09:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XO49xxpKmR4aueGBJofXWoeKHMR/BCNkq2cA/jF/D9Y=;
        b=ht8TPpEVm/y2ralBJuKQg1YnCAHmbnWWztgr53ji/RPYzVJU8qIkjosFjfNOuJ3ZJb
         omvHlQOsDClBlh7rlekccIozZCfYuRM0vl3Dtg+TrGc7lGYOA/qovDYrOEGGapgMQGgE
         Iaj2rYmOtO33LJq0HKiRlzpWLn5DC6VTgBsiP6IF3aFGNFikIBuzPq5E4E29qVwwsgHb
         Y5PZT1F8LZ7SudjTj3UloJXq2iprw8NoTqbRqvWuwZ5VvQAN4d5bJol/skfvUYphr0gi
         Qjn+NG8AeGexsUNrzUJjjQcfb6qC46VjH0RC5IFeGxsU5o1mbAGcKFyi1b3wAqyzmPkv
         ONNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XO49xxpKmR4aueGBJofXWoeKHMR/BCNkq2cA/jF/D9Y=;
        b=4l8Tk8qMuuXY2ee76/X57nYA8aKADmYOupMqb+TYySyYywg+JADOlPb4JJWKhu4v3G
         HCSfClOnpbxbctTumajNXTji1kw41NbeP+xKuuJhYv948DsiOZyNs0y7KPq7fnSDpZh+
         Km+SfpkJQIoKlbQQf+3M9uzWo6JktdeMRn/1V4yJX5lyhxjMUJ4Qz/wXOd6mnTYgVspF
         sQop/Qg//cRJ9aBp20YY7PZsfcl2Rs+dCFzskreoW4raL2VPokajOO3/HbO+11clqpdO
         iWM3krK6yhmCWItOZsmjsdIGTHC1Y/+bO+K3H38QCOGzLpqznO2BvaVSlwycGUunSfB2
         rBcQ==
X-Gm-Message-State: AOAM533TWTlX263wlaGxFXF5UOJOC7rsRzhrlE/4CdhkKE4a9LviM87N
        9cYB8rhrcqm8MKHTy43OSgirCw==
X-Google-Smtp-Source: ABdhPJyOIIVDjhZgAIjWZi5/7ffqRR9s4wi9uLGzJV1knpzUgZk/6EeGhl1TqSfO5dRqsaSuIB858g==
X-Received: by 2002:a7b:cd19:: with SMTP id f25mr1549412wmj.72.1642784742429;
        Fri, 21 Jan 2022 09:05:42 -0800 (PST)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id t8sm5809600wmq.21.2022.01.21.09.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 09:05:41 -0800 (PST)
Date:   Fri, 21 Jan 2022 17:05:40 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Luiz Sampaio <sampaio.ime@gmail.com>
Cc:     Michael Hennerich <michael.hennerich@analog.com>,
        Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH 24/31] video: backlight: changing LED_* from enum
 led_brightness to actual value
Message-ID: <20220121170540.w6c4wqwrqzpde2lm@maple.lan>
References: <20220121165436.30956-1-sampaio.ime@gmail.com>
 <20220121165436.30956-25-sampaio.ime@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220121165436.30956-25-sampaio.ime@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2022 at 01:54:29PM -0300, Luiz Sampaio wrote:
> The enum led_brightness, which contains the declaration of LED_OFF,
> LED_ON, LED_HALF and LED_FULL is obsolete, as the led class now supports
> max_brightness.

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>

BTW it looks like this patch might wants to land in one tree (I can't
see since I'm only on copy of this one). If so please discuss with Lee
how you want to land it. Put more directly, please don't treat my
Reviewed-by: as an Acked-by: ;-) !


Daniel.


> ---
>  drivers/video/backlight/adp8860_bl.c | 4 ++--
>  drivers/video/backlight/adp8870_bl.c | 4 ++--
>  drivers/video/backlight/led_bl.c     | 2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/video/backlight/adp8860_bl.c b/drivers/video/backlight/adp8860_bl.c
> index 8ec19425671f..063be4189e7e 100644
> --- a/drivers/video/backlight/adp8860_bl.c
> +++ b/drivers/video/backlight/adp8860_bl.c
> @@ -261,10 +261,10 @@ static int adp8860_led_probe(struct i2c_client *client)
>  		led_dat->cdev.name = cur_led->name;
>  		led_dat->cdev.default_trigger = cur_led->default_trigger;
>  		led_dat->cdev.brightness_set = adp8860_led_set;
> -		led_dat->cdev.brightness = LED_OFF;
> +		led_dat->cdev.brightness = 0;
>  		led_dat->flags = cur_led->flags >> FLAG_OFFT_SHIFT;
>  		led_dat->client = client;
> -		led_dat->new_brightness = LED_OFF;
> +		led_dat->new_brightness = 0;
>  		INIT_WORK(&led_dat->work, adp8860_led_work);
>  
>  		ret = led_classdev_register(&client->dev, &led_dat->cdev);
> diff --git a/drivers/video/backlight/adp8870_bl.c b/drivers/video/backlight/adp8870_bl.c
> index 8b5213a39527..b04faf8d631d 100644
> --- a/drivers/video/backlight/adp8870_bl.c
> +++ b/drivers/video/backlight/adp8870_bl.c
> @@ -287,10 +287,10 @@ static int adp8870_led_probe(struct i2c_client *client)
>  		led_dat->cdev.name = cur_led->name;
>  		led_dat->cdev.default_trigger = cur_led->default_trigger;
>  		led_dat->cdev.brightness_set = adp8870_led_set;
> -		led_dat->cdev.brightness = LED_OFF;
> +		led_dat->cdev.brightness = 0;
>  		led_dat->flags = cur_led->flags >> FLAG_OFFT_SHIFT;
>  		led_dat->client = client;
> -		led_dat->new_brightness = LED_OFF;
> +		led_dat->new_brightness = 0;
>  		INIT_WORK(&led_dat->work, adp8870_led_work);
>  
>  		ret = led_classdev_register(&client->dev, &led_dat->cdev);
> diff --git a/drivers/video/backlight/led_bl.c b/drivers/video/backlight/led_bl.c
> index f54d256e2d54..1b869624b4f8 100644
> --- a/drivers/video/backlight/led_bl.c
> +++ b/drivers/video/backlight/led_bl.c
> @@ -46,7 +46,7 @@ static void led_bl_power_off(struct led_bl_data *priv)
>  		return;
>  
>  	for (i = 0; i < priv->nb_leds; i++)
> -		led_set_brightness(priv->leds[i], LED_OFF);
> +		led_set_brightness(priv->leds[i], 0);
>  
>  	priv->enabled = false;
>  }
> -- 
> 2.34.1
> 
