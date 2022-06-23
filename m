Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86C37557D37
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 15:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbiFWNnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 09:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbiFWNn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 09:43:27 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 541B0240A8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 06:43:21 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id o16so28029825wra.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 06:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eRK+unsPW70xNn5MF8+19eCG7D3AK/lgynWxuPdsIyE=;
        b=KC804tV7q8m5lKxx02VfQNPyCFRxbLo+UN5MqQqk1P+QbuQa4VcB2DrqvkkpPc4wLh
         s8YD9o2Eiw8erHMZ6g3Ia7a0hyCPKQt3dQhrWjxY7MVQ+N+R6b5WlLXKQYsrlnRxHzog
         E2sf54tTcmTN6YbXT+A5UHQ5N/d1dBEzbXYSl58xn/DSXDKRHGikl18c1Dewu5+tmqAo
         JWR2R+BecqmGJdKOoqPajDcTtrvcsivMLPCP1TsgqwJCt60ewBhMWun7q+A0t7wb6Fa5
         u7SPQBBJb5LqETPHZT7BjI6j+0AwxO054RkyMDT9jgCAOSDplPJobh2EkUOEu7PwvTVI
         nrzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eRK+unsPW70xNn5MF8+19eCG7D3AK/lgynWxuPdsIyE=;
        b=jSfS+pq46v9wsqz/mmPj+onveM/KUlCdQDvHJndth+0Q3S3EvUF/mnX2u5VIu9PDC0
         piM8D8UVct0D3ik+uvApHgWBl/HUYXcPwnxnbopOZ5nLAJX/Ix4cgeMZmCXid+jhpT5H
         L0P86foVBBQJOvJGf3jRB3rWgaxhdPKoVZo4OqjpCCr+L/XRKwqEQRBfajXIUxrtX/HK
         UduOA5YvaWl0MMzHqyPqIkCzVM6QrsLz6XO39JGDbmk/SROBbGZs420UUcYhCvuufous
         ntYufvPZZQdwFwRZlCyjlrFRZSjrTpvKa8L2EI/7x1DLioS+g5q0EyT0TD+geNLI2t6i
         mOeA==
X-Gm-Message-State: AJIora9cZWj1GQCBLJW984tE0xXurBFmts3RO/N/CY983pUt38nOvOMp
        mw/gcZgCeMqgwaoKudF/2aJwlA==
X-Google-Smtp-Source: AGRyM1vjF4PN7klzy0olb9rrzdVMRPfVzufgs3EKRfc33dNmi33WjI/0td30uX34aWiNQWi+iEa1Yg==
X-Received: by 2002:a05:6000:10b:b0:21b:88ca:9abf with SMTP id o11-20020a056000010b00b0021b88ca9abfmr8191539wrx.694.1655991799771;
        Thu, 23 Jun 2022 06:43:19 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id p129-20020a1c2987000000b003974cb37a94sm3313906wmp.22.2022.06.23.06.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 06:43:18 -0700 (PDT)
Date:   Thu, 23 Jun 2022 14:43:16 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     ChiaEn Wu <peterwu.pub@gmail.com>
Cc:     lee.jones@linaro.org, jingoohan1@gmail.com, pavel@ucw.cz,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, sre@kernel.org, chunfeng.yun@mediatek.com,
        gregkh@linuxfoundation.org, jic23@kernel.org, lars@metafoo.de,
        lgirdwood@gmail.com, broonie@kernel.org, linux@roeck-us.net,
        heikki.krogerus@linux.intel.com, deller@gmx.de,
        chiaen_wu@richtek.com, alice_chen@richtek.com,
        cy_huang@richtek.com, dri-devel@lists.freedesktop.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org,
        szunichen@gmail.com
Subject: Re: [PATCH v3 14/14] video: backlight: mt6370: Add Mediatek MT6370
 support
Message-ID: <20220623134316.rg3adyobz3hkgflt@maple.lan>
References: <20220623115631.22209-1-peterwu.pub@gmail.com>
 <20220623115631.22209-15-peterwu.pub@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220623115631.22209-15-peterwu.pub@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2022 at 07:56:31PM +0800, ChiaEn Wu wrote:
> From: ChiaEn Wu <chiaen_wu@richtek.com>
> 
> Add Mediatek MT6370 Backlight support.
> 
> Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>

> diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
> index a003e02..7cd823d 100644
> <snip>
> +static int mt6370_init_backlight_properties(struct mt6370_priv *priv,
> +					    struct backlight_properties *props)
> +{
> +	struct device *dev = priv->dev;
> +	u8 prop_val;
> +	u32 brightness, ovp_uV, ocp_uA;
> +	unsigned int mask, val;
> +	int ret;
> +
> +	/* Vendor optional properties */
> +	val = 0;
> +	if (device_property_read_bool(dev, "mediatek,bled-pwm-enable"))
> +		val |= MT6370_BL_PWM_EN_MASK;
> +
> +	if (device_property_read_bool(dev, "mediatek,bled-pwm-hys-enable"))
> +		val |= MT6370_BL_PWM_HYS_EN_MASK;
> +
> +	ret = device_property_read_u8(dev,
> +				      "mediatek,bled-pwm-hys-input-th-steps",
> +				      &prop_val);
> +	if (!ret) {
> +		prop_val = clamp_val(prop_val,
> +				     MT6370_BL_PWM_HYS_TH_MIN_STEP,
> +				     MT6370_BL_PWM_HYS_TH_MAX_STEP);
> +		/*
> +		 * prop_val =  1      -->  1 steps --> 0x00
> +		 * prop_val =  2 ~  4 -->  4 steps --> 0x01
> +		 * prop_val =  5 ~ 16 --> 16 steps --> 0x10
> +		 * prop_val = 17 ~ 64 --> 64 steps --> 0x11

                                                      ^^^^^
These numbers are binary, not hex, right? If so, the comments
should be 0b00 to 0b03 .


> +		 */
> +		prop_val = (ilog2(roundup_pow_of_two(prop_val)) + 1) >> 1;
> +		val |= prop_val << (ffs(MT6370_BL_PWM_HYS_SEL_MASK) - 1);
> +	}
> +
> +	ret = regmap_update_bits(priv->regmap, MT6370_REG_BL_PWM,
> +				 val, val);
> +	if (ret)
> +		return ret;

Overall, I like this approach! Easy to read and understand.


> <snip>
> +static int mt6370_bl_probe(struct platform_device *pdev)
> +{
> +	struct mt6370_priv *priv;
> +	struct backlight_properties props = {
> +		.type = BACKLIGHT_RAW,
> +		.scale = BACKLIGHT_SCALE_LINEAR,

Sorry, I missed this before but the KConfig comment says that the
backlight can support both linear and exponential curves.

Is there a good reason to default to linear?


Daniel.
> 
