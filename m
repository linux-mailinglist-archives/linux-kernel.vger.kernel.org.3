Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7742D57654D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 18:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233595AbiGOQ3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 12:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233314AbiGOQ3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 12:29:21 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06BAA22BE7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 09:29:18 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id f2so7409831wrr.6
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 09:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=g4utnIEpgUH8SrFacOeGCRYGCTX0362lTOZoYsGdnLU=;
        b=OzC/9QXaaDqxoCP/B7s3PFEoW1r/3BL4QbU0Itu4yM/SSqwTf9zl3vnXpqm6D9/wLg
         u9IULLjrR/XGDkdPfCpFCJs5/QboFpLuQOffp2IKLY+TcH8l8BzzHthtTM5hML+jlRHO
         FG6Cxp7CivJKWEJLvCIuG26LkXP6sxJbO1IKctA1ERVcnJsmcMUdeLVDCwMA4onz9+H1
         1MNjc+56N5uGO0uP7FpLmEqEBd9LvV4yyBSj2q2kCVBKFG5yQDPjhzHOHdM+unWA77AD
         SzvLrlWu0scXmQGI3iWJ+50TPqZt4sVHUFRyHKBkMNQSgWZ1mUzUSIa7VQPGG7NvSDCO
         TFOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=g4utnIEpgUH8SrFacOeGCRYGCTX0362lTOZoYsGdnLU=;
        b=LSo+C3+3fDInxC9uL02xJeFthEvAbxCeL9sgFIjQsX06x+yQFm+mCmvHcSeYm3OH8I
         39p1gv6aP5/0pEkPyawCnHALm8+yoOGrwGA8J786thG/p4CQ1qkQKjlG9zHO5qaFC32Z
         wQ2Gz4bq91opREz11WN7xpM5vvUNxE7nFHZXAIzN7hQ/nt0X/c+AS8bCXpEpnpeHIpVs
         Qxi+AdRIzPE7FHzWUYBDrhWsIyN2oyORGEuU2ylCG9160f5TmEr+A5xbSeukY14xIdZw
         HiQYJ1V/dBESQEPoyzBU2Oj8bDknx/9RoVl9jMaBBAQjCKxoLtUwJ+TDtl0QQkuqBEEi
         K6XQ==
X-Gm-Message-State: AJIora8fqHg1Y8ynqZJk4XObD5aLCmL8uobwdzev6bvTZs8UnkHhBnkN
        UGct9GIYB0ICqc50cOKXMpCOCQ==
X-Google-Smtp-Source: AGRyM1tSF48yUDKFkMabG1ZK0Ufn2HDShLc1rfkqldFR9s050thAUB7FUGwV6hpIfcU96gErNHiZ9Q==
X-Received: by 2002:a05:6000:16cb:b0:21d:7b9e:d0af with SMTP id h11-20020a05600016cb00b0021d7b9ed0afmr13306509wrf.139.1657902556488;
        Fri, 15 Jul 2022 09:29:16 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id h7-20020adffd47000000b0021d650e4df4sm4283198wrs.87.2022.07.15.09.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 09:29:16 -0700 (PDT)
Date:   Fri, 15 Jul 2022 17:29:13 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     ChiaEn Wu <peterwu.pub@gmail.com>, lee.jones@linaro.org,
        jingoohan1@gmail.com, pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        sre@kernel.org, chunfeng.yun@mediatek.com,
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
Subject: Re: [PATCH v5 13/13] video: backlight: mt6370: Add MediaTek MT6370
 support
Message-ID: <20220715162913.5ewxwhv6jtdgt3c2@maple.lan>
References: <20220715112607.591-1-peterwu.pub@gmail.com>
 <20220715112607.591-14-peterwu.pub@gmail.com>
 <ec3bdfb8-0e42-a772-28b1-165811872afa@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec3bdfb8-0e42-a772-28b1-165811872afa@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2022 at 02:38:45PM +0200, AngeloGioacchino Del Regno wrote:
> Il 15/07/22 13:26, ChiaEn Wu ha scritto:
> > From: ChiaEn Wu <chiaen_wu@richtek.com>
> >
> > MediaTek MT6370 is a SubPMIC consisting of a single cell battery charger
> > with ADC monitoring, RGB LEDs, dual channel flashlight, WLED backlight
> > driver, display bias voltage supply, one general purpose LDO, and the
> > USB Type-C & PD controller complies with the latest USB Type-C and PD
> > standards.
> >
> > This adds support for MediaTek MT6370 Backlight driver. It's commonly used
> > to drive the display WLED. There are 4 channels inside, and each channel
> > supports up to 30mA of current capability with 2048 current steps in
> > exponential or linear mapping curves.
> >
> > Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>
>
> Hello ChiaEn,
>
> I propose to move this one to drivers/leds (or drivers/pwm) and, instead of
> registering a backlight device, register a PWM device.
>
> This way you will be able to reuse the generic backlight-pwm driver, as you'd
> be feeding the PWM device exposed by this driver to the generic one: this will
> most importantly make it easy to chain it with MTK_DISP_PWM (mtk-pwm-disp)
> with a devicetree that looks like...

Out of interest, does MT6370 have the same structure for backlights as the prior
systems using mtk-pwm-disp or was mtk-pwm-disp simply a normal(-ish) PWM
that relied on something on the board for all the constant current
driver hardware?


>
> 	pwmleds-disp {
> 		compatible = "pwm-leds";
>
> 		disp_led: disp-pwm {
> 			label = "backlight-pwm";
> 			pwms = <&pwm0 0 500000>;
> 			max-brightness = <1024>;
> 		};
> 	};
>
> 	backlight_lcd0: backlight {
> 		compatible = "led-backlight";
> 		leds = <&disp_led>, <&pmic_bl_led>;
> 		default-brightness-level = <300>;
> 	};

I think this proposal has to start with the devicetree bindings rather
than the driver. Instead I think the question is: does this proposal
result in DT bindings that better describe the underlying hardware?

This device has lots of backlight centric features (OCP, OVP, single
control with multiple outputs, exponential curves, etc) and its not
clear where they would fit into the "PWM" bindings.

Come to think of it I'm also a little worried also about the whole linear
versus exponential curve thing since I thought LED drivers were required
to use exponential curves.


Daniel.
