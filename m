Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC14573005
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 10:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235003AbiGMIEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 04:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbiGMIE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 04:04:28 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF27E146E
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 01:04:27 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id v16so14303760wrd.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 01:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=yaBi5+j2aB+gOEpu/CS6a4crTXK1oluI+G7cSMbxelM=;
        b=MduZJ4LcUwia674sobuaUywFu/y9XJbPCqF8UXjn0wnRaCT+QZ3XOGx+YAje4xxfsx
         x9gPEEwK6l26zgKylqiCX6kg+6Qcrx6/7WQ/ytwHvcda4vtybERuZ4s70YTn/BNqLy24
         5MeZn8161zhdqCh3Gug8o1zPTpESCgZp9pNlebMEHS9aj8RGpd5fMetXcNCgQ8tnZWl2
         oITFcoQoNbdZcmx8uMXLq2HS15pvFWibAtvysAkVPH+IejhAt1//CsNF6qnytW3Sp+Yo
         iZrLyWZCZeToIHPCPlOTz9lFBuwhiDKL4zdw/LqWzu1dOoE8C4t19oUDKrZTd7BZsh3v
         b4DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=yaBi5+j2aB+gOEpu/CS6a4crTXK1oluI+G7cSMbxelM=;
        b=1ef1Rk8lOYjivB1vvzuekNr4w/LaFhC1cKHHMF3yQrxkfTrPZ7oGqGZne6Fxv7+f3V
         fe4ckcMJoyByCU2ege55Jg6reOL8REysxOUyOaIN+bFO6g25qMtVCoE5+2bm1SI/cDWu
         1JhPx+rcz77idTZvLRBs1oT9Xy3sSrsssh0870Pb2ulX1it9hsnjDjSApy0ItSVYzXav
         x5tlUMP7TcJHQnf71uRf0Cdr6GpSdwzB2SYoZg3Ek5zKEprpOik0sEFgeQoe9VvAXVZ0
         h6SvtdigIYiNpL+/rxe/LMWg5a8+wCMVF5gDj8L+RuG+S0ionqO/DbAdndWFKOqX7H2A
         8OAw==
X-Gm-Message-State: AJIora9v1j6OuHvS3fL4UkzPCEuwNQqmKNc+RelruY/0YdwoqidV0vXQ
        6mGZDepJ+TVnvN2rx7gWEmqINw==
X-Google-Smtp-Source: AGRyM1sox2gwD2oOUs0Po8YP6r0hOoKvkq7xKaXz/jSSA3VY7uq2zQIZPBxBD2yVdN4jLfilFwtkQw==
X-Received: by 2002:a5d:4890:0:b0:21d:9bf3:89b5 with SMTP id g16-20020a5d4890000000b0021d9bf389b5mr1887795wrq.153.1657699465867;
        Wed, 13 Jul 2022 01:04:25 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id l29-20020a05600c1d1d00b0039749b01ea7sm1616879wms.32.2022.07.13.01.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 01:04:25 -0700 (PDT)
Date:   Wed, 13 Jul 2022 09:04:22 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     ChiaEn Wu <peterwu.pub@gmail.com>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
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
        ChiYuan Huang <cy_huang@richtek.com>,
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
Subject: Re: [PATCH v3 07/14] mfd: mt6370: Add Mediatek MT6370 support
Message-ID: <Ys58hr3AK/p/4/ng@google.com>
References: <20220623115631.22209-1-peterwu.pub@gmail.com>
 <20220623115631.22209-8-peterwu.pub@gmail.com>
 <Ys2TTsv1oU8n1fUE@google.com>
 <CABtFH5LMHrfOdLZZxpjwsHmyHZsHUmevpQJYDFqZtvfpC6AVxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABtFH5LMHrfOdLZZxpjwsHmyHZsHUmevpQJYDFqZtvfpC6AVxg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jul 2022, ChiaEn Wu wrote:

> Hi Lee,
> 
> Thanks for your reply.
> 
> Lee Jones <lee.jones@linaro.org> 於 2022年7月12日 週二 晚上11:29寫道：
> >
> > On Thu, 23 Jun 2022, ChiaEn Wu wrote:
> >
> > > From: ChiYuan Huang <cy_huang@richtek.com>
> > >
> > > Add Mediatek MT6370 MFD support.
> >
> > No such thing as "MFD support".
> >
> > And you're not getting away with submitting a 370 line patch with a 5
> > word change log either. :)
> >
> > Please at least tell us what the device is and what it's used for.
> 
> I sincerely apologize.
> We will add more descriptions of the MT6370 feature in the v5 patch.
> 
> >
> > > Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> > > ---
> > >
> > > v3
> > > - Refine Kconfig help text
> > > - Refine error message of unknown vendor ID in
> > >   mt6370_check_vendor_info()
> > > - Refine return value handling of mt6370_regmap_read()
> > > - Refine all probe error by using dev_err_probe()
> > > - Refine "bank_idx" and "bank_addr" in mt6370_regmap_read() and
> > >   mt6370_regmap_write()
> > > - Add "#define VENID*" and drop the comments in
> > >   mt6370_check_vendor_info()
> > > - Drop "MFD" in MODULE_DESCRIPTION()
> > > ---
> > >  drivers/mfd/Kconfig  |  13 ++
> > >  drivers/mfd/Makefile |   1 +
> > >  drivers/mfd/mt6370.c | 358 +++++++++++++++++++++++++++++++++++++++++++++++++++
> > >  3 files changed, 372 insertions(+)
> > >  create mode 100644 drivers/mfd/mt6370.c

[...]

> > > +static int mt6370_probe(struct i2c_client *i2c)
> > > +{
> > > +     struct mt6370_info *info;
> > > +     struct i2c_client *usbc_i2c;
> > > +     int ret;
> > > +
> > > +     info = devm_kzalloc(&i2c->dev, sizeof(*info), GFP_KERNEL);
> > > +     if (!info)
> > > +             return -ENOMEM;
> > > +
> > > +     info->dev = &i2c->dev;
> > > +
> > > +     usbc_i2c = devm_i2c_new_dummy_device(&i2c->dev, i2c->adapter,
> > > +                                          MT6370_USBC_I2CADDR);
> > > +     if (IS_ERR(usbc_i2c))
> > > +             return dev_err_probe(&i2c->dev, PTR_ERR(usbc_i2c),
> > > +                                  "Failed to register USBC I2C client\n");
> > > +
> > > +     /* Assign I2C client for PMU and TypeC */
> > > +     info->i2c[MT6370_PMU_I2C] = i2c;
> > > +     info->i2c[MT6370_USBC_I2C] = usbc_i2c;
> > > +
> > > +     info->regmap = devm_regmap_init(&i2c->dev, &mt6370_regmap_bus, info,
> > > +                                     &mt6370_regmap_config);
> >
> > Apart from in mt6370_check_vendor_info() where is this actually used?
> 
> Well... from my understanding, we use this MFD driver to make other
> drivers of MT6370 (e.g. charger, ADC, led...) use the same regmap
> settings.
> Thus, this regmap is not only used in mt6370_check_vendor_info().

Well for that to happen you need to store the data somewhere for the
child devices to fetch from.  I don't see that happening in this
patch?  What did I miss?

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
