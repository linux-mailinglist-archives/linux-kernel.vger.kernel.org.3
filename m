Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46B2757FD86
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 12:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234399AbiGYKbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 06:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234382AbiGYKbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 06:31:34 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 836D113F21
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 03:31:32 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id q18so4884789wrx.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 03:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QR4thViojhLm7m3iVqTAzOPrEuZ+oboQVEbkcRYR7U0=;
        b=hcY3ebDhxmUgKAKSOPUOX7d/LMYdV3cijN2N6OfC0kvVYjMwOvmOolx+2NETIKYqUp
         GPy3YFMR7smmOlatz8CKT+4p2UQ+6lI9Ejv06f+y6zEFBSmLUPFbbscFbBBsOCvH434Q
         ke8WXFQ+uXl36Kdevvs6uhTIaQQgtIFRovUfQ/RDq3AHQ469OhSceGOKRnPmFWjpxVnH
         VERQ2rtptnToPx6leEXxAAby7RDypiZaQady2IbBpsvPlsYJ0uSwLW6l0adFiFhqOZ8D
         XJZDsGiJcpWWsVtF7ngMWVpb9VQHwHEkKK2RVLip5CsQWVUMkj1jqMMhHMjq3wvU4bke
         J0IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QR4thViojhLm7m3iVqTAzOPrEuZ+oboQVEbkcRYR7U0=;
        b=cmoW9pnoTGChJU+puAIWFvPyenOq6UJbTDvxTTvuTAJ9sVkAMyKIJNsT8QRrorwVG3
         Psd39liwoIeiYvMMRpwzSNwZHEpVuSHYj4mCrEBmqIBmaKh503fz5+UXMNIdijsYcWLz
         JgJIAtpyKXe3MsY8tTLH2/RB+jQyc8Zy5gujjC8MShGxOgzkni82Rqgn1tgHRgKDIA0z
         /6tw7mDOdllrZfzChVTp6n3YWMcdgheDA/LGq4ZIxJguffphXN9QRZtq5SCcVcyO0HJX
         9GbCvY9vY20D6UIK4Mz3nYAXLaD9kjCuh/GL8bxmcSz3YE3mENmZJip5hleHKFYUvro4
         8r8w==
X-Gm-Message-State: AJIora+amltEAgiwOFsJqaxa8yhxmvd+6fL2pwmGL5UJei0BQWaFbVEA
        a5wjKojJr7ayMvvFc/UHpB7icQ==
X-Google-Smtp-Source: AGRyM1uhInd5p9lSRbYGnaq9oTNYSYBtNWlkq9wyaVzmMkSkg4hYhWboyJgYIo9QbRHYBeJSc2cjCg==
X-Received: by 2002:a5d:584c:0:b0:21e:7f48:bf19 with SMTP id i12-20020a5d584c000000b0021e7f48bf19mr5190179wrf.474.1658745090915;
        Mon, 25 Jul 2022 03:31:30 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id l18-20020a05600c1d1200b003a04d19dab3sm29367538wms.3.2022.07.25.03.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 03:31:30 -0700 (PDT)
Date:   Mon, 25 Jul 2022 11:31:28 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     ChiaEn Wu <peterwu.pub@gmail.com>
Cc:     lee.jones@linaro.org, jingoohan1@gmail.com, pavel@ucw.cz,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, sre@kernel.org, chunfeng.yun@mediatek.com,
        gregkh@linuxfoundation.org, jic23@kernel.org, lars@metafoo.de,
        lgirdwood@gmail.com, broonie@kernel.org, linux@roeck-us.net,
        heikki.krogerus@linux.intel.com, deller@gmx.de,
        andy.shevchenko@gmail.com, chiaen_wu@richtek.com,
        alice_chen@richtek.com, cy_huang@richtek.com,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org,
        szunichen@gmail.com
Subject: Re: [PATCH v6 13/13] video: backlight: mt6370: Add MediaTek MT6370
 support
Message-ID: <20220725103128.xtaw2c4y5fobowg7@maple.lan>
References: <20220722102407.2205-1-peterwu.pub@gmail.com>
 <20220722102407.2205-14-peterwu.pub@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220722102407.2205-14-peterwu.pub@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 22, 2022 at 06:24:07PM +0800, ChiaEn Wu wrote:
> diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
> index a003e02..846dbe7 100644
> --- a/drivers/video/backlight/Kconfig
> +++ b/drivers/video/backlight/Kconfig
> @@ -268,6 +268,18 @@ config BACKLIGHT_MAX8925
>  	  If you have a LCD backlight connected to the WLED output of MAX8925
>  	  WLED output, say Y here to enable this driver.
>
> +config BACKLIGHT_MT6370
> +	tristate "MediaTek MT6370 Backlight Driver"
> +	depends on MFD_MT6370
> +	help
> +	  This enables support for Mediatek MT6370 Backlight driver.
> +	  It's commonly used to drive the display WLED. There are 4 channels
> +	  inside, and each channel supports up to 30mA of current capability
> +	  with 2048 current steps in exponential or linear mapping curves.

Does the MT6372 support more steps than this? In other words does it use
a fourteen bit scale or does it use an 11-bit scale at a different
register location?


> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called "mt6370-backlight".
> +
> [...]
> diff --git a/drivers/video/backlight/mt6370-backlight.c b/drivers/video/backlight/mt6370-backlight.c
> new file mode 100644
> index 0000000..ba00a8f
> --- /dev/null
> +++ b/drivers/video/backlight/mt6370-backlight.c
> [...]
> +static int mt6370_bl_update_status(struct backlight_device *bl_dev)
> +{
> +	struct mt6370_priv *priv = bl_get_data(bl_dev);
> +	int brightness = backlight_get_brightness(bl_dev);
> +	unsigned int enable_val;
> +	u8 brightness_val[2];
> +	int ret;
> +
> +	if (brightness) {
> +		brightness_val[0] = (brightness - 1) & MT6370_BL_DIM2_MASK;
> +		brightness_val[1] = (brightness - 1) >> fls(MT6370_BL_DIM2_MASK);
> +
> +		/*
> +		 * To make MT6372 using 14 bits to control the brightness
> +		 * backward compatible with 11 bits brightness control
> +		 * (like MT6370 and MT6371 do), we left shift the value
> +		 * and pad with 1 to remaining bits. Hence, the MT6372's
> +		 * backlight brightness will be almost the same as MT6370's
> +		 * and MT6371's.
> +		 */
> +		if (priv->vid_type == MT6370_VID_6372) {
> +			brightness_val[0] <<= MT6370_BL_DIM2_6372_SHIFT;
> +			brightness_val[0] |= MT6370_BL_DUMMY_6372_MASK;
> +		}

This somewhat depends on the answer to the first question above, but
what is the point of this shifting? If the range is 14-bit then the
driver should set max_brightness to 16384 and present the full range of
the MT6372 to the user.

Especially when using linear mappings (which are a totally pointless
scale to use for a backlight) the extra steps are useful for backlight
animation.


Daniel.
