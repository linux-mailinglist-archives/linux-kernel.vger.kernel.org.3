Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69B9D5587F9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 20:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiFWS46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 14:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbiFWS4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 14:56:33 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72977104EE8;
        Thu, 23 Jun 2022 11:01:27 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id y32so298702lfa.6;
        Thu, 23 Jun 2022 11:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=htpW4KO87Pa3rfVeMc6d2EASyy2GIlidpaFdVmoZj4s=;
        b=Mccp92zjcX1919GaiWQ+VcL44gQ1EA9AwWWZhvKCZACiwpUQzrT5asRNoyYMMeJKeC
         yy/NqYIyPtk0agQcs5WsY9lJn2YR5/tQ19F7LTwOI6teZ09YI+MJW+vrfMnml19eJH9W
         StZkhocl5dtWKAdtG5QOWy4AoGTqZajadCgPjbh8vbjw3qjfrBxQFGbGKG1S1eFika4f
         iz3UbI46YvLKErei68dWMmN2PQPtZXRGKO8UnvCMrqWl1yG1JjteJCCwXoerzr0t2A1N
         VjVir3hJ6EXhYzrkJ65P/LA8tcdSLX4Y6vsnbVAIdq9UTFeXC3SdGD4c7gIFoLF41/ya
         hC4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=htpW4KO87Pa3rfVeMc6d2EASyy2GIlidpaFdVmoZj4s=;
        b=1JanYD5U8FjT6zhVreDEfABf9swN/dQrp6QqHvhGxxXjXHxRXS1M8sUZpB81EEwIIC
         /C6f7lK1h0AwNUjdfIgz5MIT4RXC4yTcEAhLTIAhCdQunD1T1JZ0vUlhguSWqmuqWK2T
         BSY8oNQ1j/RoynHGgBih0YJ9oRFg9JK0H/V7gysNCvUqy1Yvn7NrEfw5QOMbWbQcKAWo
         +eig0Tw+WjUFg/ftDYwavXPDMCrlXsHI8DZF9eD8HCpvlOcEBI62FGWSd8xSCLLJoAuk
         /yNn3Js7PYw+5sgvDV7KzURNCKjbFDrPO1dJjAfMsIUmLrvhS3q88/HWvXv3HGBuf00Y
         N3pQ==
X-Gm-Message-State: AJIora+DOQkJKLtTDeVbDjU/6obtMlmj4h/SzbDPriAaEEOZrAl5te1M
        3cxZSV5INFiR/2WM/2Odu8zt6CrIzP0Lo1iGWpqvPe2g0Y0zA/3h
X-Google-Smtp-Source: AGRyM1tGbyFaN7xD4syfsOma3gUoWvRL9AeKqEpXbVc0stZoknt2cnh9AdCxTQhuI7/2pxW4uHg+rH97OEElrDn8l58=
X-Received: by 2002:a05:6512:3183:b0:47f:79f3:af9a with SMTP id
 i3-20020a056512318300b0047f79f3af9amr6025265lfe.182.1656007284378; Thu, 23
 Jun 2022 11:01:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220623115631.22209-1-peterwu.pub@gmail.com> <20220623115631.22209-8-peterwu.pub@gmail.com>
In-Reply-To: <20220623115631.22209-8-peterwu.pub@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 23 Jun 2022 20:00:47 +0200
Message-ID: <CAHp75Vd95sEQz8y4ZcviUKaC9ic27yitR+VCwkfb38MTTe0mkg@mail.gmail.com>
Subject: Re: [PATCH v3 07/14] mfd: mt6370: Add Mediatek MT6370 support
To:     ChiaEn Wu <peterwu.pub@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
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
        Helge Deller <deller@gmx.de>, chiaen_wu@richtek.com,
        alice_chen@richtek.com, cy_huang <cy_huang@richtek.com>,
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2022 at 1:59 PM ChiaEn Wu <peterwu.pub@gmail.com> wrote:
>
> From: ChiYuan Huang <cy_huang@richtek.com>
>
> Add Mediatek MT6370 MFD support.

...

> +config MFD_MT6370
> +       tristate "Mediatek MT6370 SubPMIC"
> +       select MFD_CORE
> +       select REGMAP_I2C
> +       select REGMAP_IRQ
> +       depends on I2C
> +       help
> +         Say Y here to enable MT6370 SubPMIC functional support.
> +         It consists of a single cell battery charger with ADC monitoring, RGB
> +         LEDs, dual channel flashlight, WLED backlight driver, display bias
> +         voltage supply, one general purpose LDO, and the USB Type-C & PD
> +         controller complies with the latest USB Type-C and PD standards.

What will be the module name in case it's chosen to be built as a module?

...

>  obj-$(CONFIG_INTEL_SOC_PMIC_BXTWC)  += intel_soc_pmic_bxtwc.o
>  obj-$(CONFIG_INTEL_SOC_PMIC_CHTWC)     += intel_soc_pmic_chtwc.o
>  obj-$(CONFIG_INTEL_SOC_PMIC_CHTDC_TI)  += intel_soc_pmic_chtdc_ti.o
>  obj-$(CONFIG_MFD_MT6360)       += mt6360-core.o
> +obj-$(CONFIG_MFD_MT6370)       += mt6370.o
>  mt6397-objs                    := mt6397-core.o mt6397-irq.o mt6358-irq.o
>  obj-$(CONFIG_MFD_MT6397)       += mt6397.o
>  obj-$(CONFIG_INTEL_SOC_PMIC_MRFLD)     += intel_soc_pmic_mrfld.o

This whole bunch of drivers is in the wrong place in Makefile.

https://lore.kernel.org/all/20220616182524.7956-2-andriy.shevchenko@linux.intel.com/

...

> +#define MT6370_REG_MAXADDR     0x1FF

Wondering if (BIT(10) - 1) gives a better hint on how hardware limits
this (so it will be clear it's 10-bit address).

...

> +static int mt6370_check_vendor_info(struct mt6370_info *info)
> +{
> +       unsigned int devinfo;
> +       int ret;
> +
> +       ret = regmap_read(info->regmap, MT6370_REG_DEV_INFO, &devinfo);
> +       if (ret)
> +               return ret;
> +
> +       switch (FIELD_GET(MT6370_VENID_MASK, devinfo)) {
> +       case MT6370_VENID_RT5081:
> +       case MT6370_VENID_RT5081A:
> +       case MT6370_VENID_MT6370:
> +       case MT6370_VENID_MT6371:
> +       case MT6370_VENID_MT6372P:
> +       case MT6370_VENID_MT6372CP:

return 0;

> +               break;
> +       default:
> +               dev_err(info->dev, "Unknown Vendor ID 0x%02x\n", devinfo);
> +               return -ENODEV;
> +       }
> +
> +       return 0;

...and drop these two lines?

> +}

...

> +       bank_idx = *(u8 *)reg_buf;
> +       bank_addr = *(u8 *)(reg_buf + 1);

Why not

  const u8 *u8_buf = reg_buf;

  bank_idx = u8_buf[0];
  bank_addr = u8_buf[1];

?

...

> +       if (ret < 0)
> +               return ret;
> +       else if (ret != val_size)

Redundant 'else'.

> +               return -EIO;

...

> +       bank_idx = *(u8 *)data;
> +       bank_addr = *(u8 *)(data + 1);

As per above.

-- 
With Best Regards,
Andy Shevchenko
