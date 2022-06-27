Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2199C55E28E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233023AbiF0Q2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 12:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239234AbiF0Q2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 12:28:17 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E146B7CA
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 09:28:13 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id o16so13851310wra.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 09:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=RFbscGfZ1HvqkolFfPgOHxRAqCYKsO6AGhI1CWcF3U0=;
        b=QL9P5fYJiAGJ0cVberqQxZgecUlCyO035Rs/RHERScTvlSGjFZWJwcJ83NKx7icnCf
         MmmkqeK7/MKYHkhThvS+4I5n6eilA1iv0cTdd1jM4UXHDDaaVEXvSnXIRzJWnCUCUcUi
         hfbpR0k3AwYuP7wFzDx1Qb4iWIpTN9nBpMOsMz5YzOvQfMZ+aNGdk1BwqtUaNtHKCBDC
         fA9t5x0TJ4kWUQmeUPz8VsbAvV+0a4AUoZiJIyO7qENghiYMyKTM8whwQHTooEBVZnfa
         hv7NO7jkwT4JYF/WPaOvNMBn/r4c0lJo2uE2cyoUPVH1HBvXxtPYqUUryaiaIppTOHk7
         Xteg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=RFbscGfZ1HvqkolFfPgOHxRAqCYKsO6AGhI1CWcF3U0=;
        b=6dy5044EZpNqgE/pl6dRQO27ntbSjBcTRAHR//Ww5N5MvzSoZBbZlcLxAP/Vq0KWs6
         rDQ7gAtO2oPF70j0ygP1rSkPaibwwv94mcDIJRtWmoDr0Un5L49Sxmvt1wO3wtT5GkhQ
         Az+owNPdT/UIpQvIlzLlGT4FXTOAgANcjp4peT64Q3qyjjeR+uAETXueT3meC1Jb/bb1
         CatQpVcUuEUgGJgwmdMcDoixHvQ8A/02kZT9UG+/EktscWQyNCICAZLEyzQfM3APovb4
         aYL17FLpbNXQvci5dka42+F1uZSfl1htj4BelIgMjjKo+5B4kh0oMMrB7h5z6dI+rl9o
         /MfA==
X-Gm-Message-State: AJIora/nip+G3rvXTAGs1tAwbspqV7BuuFWwuhRVlB+vMzTt35NCbjCe
        xKCYt2F4U+oyxYMNaJmLB5tunQ==
X-Google-Smtp-Source: AGRyM1tWghCzrhvaQKuNnG4CtD67zaV7MVCuo84J73jDL9LXJFGuDL/uN51RLsUeyYqHqBL/FNulUA==
X-Received: by 2002:a5d:5966:0:b0:21b:80b5:ecc3 with SMTP id e38-20020a5d5966000000b0021b80b5ecc3mr12930472wri.130.1656347292409;
        Mon, 27 Jun 2022 09:28:12 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id m17-20020adfe0d1000000b0021b866397a7sm11132854wri.1.2022.06.27.09.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 09:28:12 -0700 (PDT)
Date:   Mon, 27 Jun 2022 17:28:09 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     ChiaEn Wu <peterwu.pub@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>,
        "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>,
        szuni chen <szunichen@gmail.com>,
        ChiYuan Huang <cy_huang@richtek.com>
Subject: Re: [PATCH v2 08/15] mfd: mt6370: Add Mediatek MT6370 support
Message-ID: <YrnamaUx236MsNQa@google.com>
References: <20220613111146.25221-1-peterwu.pub@gmail.com>
 <20220613111146.25221-9-peterwu.pub@gmail.com>
 <Yqph8jwHU8rPooJA@google.com>
 <CABtFH5KLVQFYOBGZ--9+s4GrHXbsDao-yL-KCFwL3FD_kbNhjg@mail.gmail.com>
 <Yrm7NTID16g8gM5t@google.com>
 <CABtFH5L7B_kEvG5E2Um5EANEScJPTfQthyLNfCbvoHq_YDpXxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABtFH5L7B_kEvG5E2Um5EANEScJPTfQthyLNfCbvoHq_YDpXxQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

> > > > > +#define MT6370_IRQ_DSV_VPOS_OCP              124
> > > > > +#define MT6370_IRQ_DSV_BST_OCP               125
> > > > > +#define MT6370_IRQ_DSV_VNEG_SCP              126
> > > > > +#define MT6370_IRQ_DSV_VPOS_SCP              127
> > > > > +
> > > > > +struct mt6370_info {
> > > > > +     struct i2c_client *i2c[MT6370_MAX_I2C];
> > > > > +     struct device *dev;
> > > > > +     struct regmap *regmap;
> > > > > +     struct regmap_irq_chip_data *irq_data;
> > > > > +};
> > > >
> > > > Can we shove all of the above into a header file?
> > >
> > > Well... In Patch v1, we put these "#define IRQ" into
> > > "include/dt-bindings/mfd/mediatek,mt6370.h".
> > > But the reviewer of DT files hoped us to remove this header file, we
> > > put these "#define IRQ" in this .c file.
> > > Shall we leave them here or put them into the header file in
> > > "driver/power/supply/mt6370-charger.h"?
> >
> > Where are they used?
> 
> Sorry, I wrote the wrong path last time...
> What I should say last time was to put them into the header file into
> "driver/mfd/mt6370.h"
> These "#define IRQ" are just used in "driver/mfd/mt6370.c"
> I’m really sorry for making this mistake...

Yes, that would be fine.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
