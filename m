Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 749A95736DE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 15:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235836AbiGMNHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 09:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235051AbiGMNHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 09:07:47 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4D6637D
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 06:07:40 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id q9so15431537wrd.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 06:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ZDp5NtLIxNT/y/y4TV28JKQZE5KPsmeDwau7U2nvfbI=;
        b=ykcE/L76OyKjfmB6gW/9PEIXPb7KX9wbY5QZt6rzoJ7cx+NshQnf3zYFk9CJJmZ/WM
         Yjn5tpbDrFkjNkWS+WFrkqjSfGYuauzrhkLnPgPWJ+ijDPIFajS1TTDtmC2uQEI2eXJq
         v/PjSpgG/525Lm1jJ94ez4EFFEytapEdMWKLq79xQRBWSawK2YgrGJjhf+6mviSVU3q3
         kOx9C54FFQzStrBSdTBuFlQdgkenCIZH2XWgb8DLkaqKQZ3XbPUtvaJN7A3d1aNdPv+L
         MOY47XiJ+MoxEz7XvBmRhEiBH0MhBUFHBMZQFzRyd4+1IQ/e0LRFMgzPqoPQQ++2EeCE
         bFRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ZDp5NtLIxNT/y/y4TV28JKQZE5KPsmeDwau7U2nvfbI=;
        b=6EsJQZRYVT7eM2qSK4S3Q0/W/FqkvjrDJrbYy4aTsoAXgFLQOGxr5OOdGfV1PtQKyP
         PFEhvtvmoGQx9TA8GAwSNzzbRcr/xQGTLqvg0lTuu4WyLINd7qyHklkBI2LtbkK2SlNI
         4CkQUGwZqUp+A5UHFA2TsAYHvAHdcffTpTCqUg3RqbDjhU/Zr6EuU847DO6g0iQw6ihk
         F0qZVGaKWjsNYylDBzG69htZR4A8Jwl5ABgpCDeYaYKMbiHsJ4ELBxqRZqXhozBygvAi
         mv+9+5OBsmfv/gOW+JWr48yloPneh7rvrQkPE1ZGpBNleuZ+Fw6Z0VFKfN6IWHHeUblt
         kh4g==
X-Gm-Message-State: AJIora9+eemf7YoR6zmBo6sb6SDnP1uadnbtNvx36bCZPDfbSwqElPps
        5a5doSl33hQOHvy530qhFWQ6Eg==
X-Google-Smtp-Source: AGRyM1v3Wejcmcef1+JLx2OGnt8FIDdBIQxbNYoMtF21Qn+Urzq7T2tg4YCX+P2hq8vPNX2sKjEQ7Q==
X-Received: by 2002:a5d:5747:0:b0:21d:65e9:be07 with SMTP id q7-20020a5d5747000000b0021d65e9be07mr3162978wrw.215.1657717658781;
        Wed, 13 Jul 2022 06:07:38 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id l29-20020a05600c1d1d00b0039749b01ea7sm2628398wms.32.2022.07.13.06.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 06:07:38 -0700 (PDT)
Date:   Wed, 13 Jul 2022 14:07:35 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     ChiaEn Wu <peterwu.pub@gmail.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>,
        Helge Deller <deller@gmx.de>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Alice Chen <alice_chen@richtek.com>,
        cy_huang <cy_huang@richtek.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>,
        szuni chen <szunichen@gmail.com>
Subject: Re: [PATCH v4 13/13] video: backlight: mt6370: Add Mediatek MT6370
 support
Message-ID: <Ys7Dl1oApfww27MJ@google.com>
References: <20220704053901.728-1-peterwu.pub@gmail.com>
 <20220704053901.728-14-peterwu.pub@gmail.com>
 <CAHp75VdwEc9AW1w8ejsxkw+sBTF1dumd99QyzTY9BZaXiViRWQ@mail.gmail.com>
 <CABtFH5K-2+2hbpvpq2nPE5AsznkQxZF2r3MVC64Q39DJhVuUtA@mail.gmail.com>
 <CAHp75VevDwdAKLYEWJgnMDvzuPuFibLuVqH-GKazEOT76wM6_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VevDwdAKLYEWJgnMDvzuPuFibLuVqH-GKazEOT76wM6_A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jul 2022, Andy Shevchenko wrote:

> On Wed, Jul 13, 2022 at 12:53 PM ChiaEn Wu <peterwu.pub@gmail.com> wrote:
> > Andy Shevchenko <andy.shevchenko@gmail.com> 於 2022年7月5日 週二 清晨5:14寫道：
> > > On Mon, Jul 4, 2022 at 7:43 AM ChiaEn Wu <peterwu.pub@gmail.com> wrote:
> 
> Please, remove unneeded context when replying!
> 
> ...
> 
> > > > +               brightness_val[0] = (brightness - 1) & MT6370_BL_DIM2_MASK;
> > > > +               brightness_val[1] = (brightness - 1)
> > > > +                                   >> fls(MT6370_BL_DIM2_MASK);
> > >
> > > Bad indentation. One line?
> >
> > Well... if indent to one line, it will be over 80 characters(or called columns?)
> > From my understanding, it is not allowed, right??
> 
> It's allowed to some extent.Use your common sense.
> Here it's obviously broken indentation.

Refrain from going crazy though - hard limit is 100 chars.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
