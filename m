Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1368A565E93
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 22:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233568AbiGDUg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 16:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiGDUg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 16:36:27 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA4E1BE39;
        Mon,  4 Jul 2022 13:36:26 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id e69so11960963ybh.2;
        Mon, 04 Jul 2022 13:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i7pfQddT00wwybN55WXtE8jeGfJuRCDhkTs8A9N9Avc=;
        b=juo7rzkgyOnogzMhLYCktRvFpSFkP3vvhbMY8Uk0vJKYeWueIKW+lWdoXP3yLwbds6
         vcrr5NUqPVbQnT0hwWaYs4EEj2Nkh5SCjrFrs18UN6hZAi3OYtxjuCQlEQvAQUlc9Dpv
         J7v71ibaYThmJdJsc986feiZcZN+aEpDukUNqgPRhJF8LMCaE4eeOYQA30SWbqQhe9N9
         uD2O3yv/dhvIOAfc/Yh+JrL6jYRzMb9TGUOPIk36TgGFoLO92g7jiweWYexkxNNBIGdE
         16csuxysxq+iUAOhEZmurW/lnrwSZZbdImIhQoMrVi+ukTjz9HsWjjHwlR4I1VW1mjTI
         xbUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i7pfQddT00wwybN55WXtE8jeGfJuRCDhkTs8A9N9Avc=;
        b=nZpdPcn2Obpreocg3995PpIalItzsq5aXZ9FdVISee1wvxNzsIZasydILZtzexPlYi
         ItW2O0Khh02e7WWDbonco6Wzk3YT0/aEYHU/V9w3IpvI1QvcIiZdfpY0TqxTFHi8FtDc
         0jYjIuB2he2WU2V6fOdNv7BRm85aXIKJahkTBS2YiEVvq/LIYfgogC4Kb2xuOBxYpp+I
         hE7yfGduVHr++/eaWHLi5C0VsvbbPZp6Bn9J6UI/8je4hy4lCfVsvkkn66GopMnbymT0
         KQw7mxdzhpb3CwWB1LJ+EfgkSrjkkmNDQzg0MafGxQ/Dn3ldZyvYSDXYf8QGJUgKj0qA
         Iosg==
X-Gm-Message-State: AJIora/IOuzHjECZLJi0uKIS7RN+D+GqPRsUyGZJ6XAeRAWquGWEXcNP
        8IcUSPdDm2oyvZ7V+bzzfDJvlKIQp6cIQ7M3JTn7Kf+ILyUQdA==
X-Google-Smtp-Source: AGRyM1u/kp8kfUd0nPXCHFP2i3Eix2PxxDcpp8y9ipLkrPPb23jLPB36f0GfOZtN0YbNTf6oiGSAGugY2K6v9bhH1+c=
X-Received: by 2002:a5b:68a:0:b0:66e:472a:83f4 with SMTP id
 j10-20020a5b068a000000b0066e472a83f4mr8583937ybq.570.1656966985988; Mon, 04
 Jul 2022 13:36:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220704053901.728-1-peterwu.pub@gmail.com> <20220704053901.728-10-peterwu.pub@gmail.com>
In-Reply-To: <20220704053901.728-10-peterwu.pub@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 4 Jul 2022 22:35:47 +0200
Message-ID: <CAHp75Ve+-ht6J5PZXS1jO1qfxn6Nfd2wDfuW-NsigR_k7iRJGg@mail.gmail.com>
Subject: Re: [PATCH v4 09/13] iio: adc: mt6370: Add Mediatek MT6370 support
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

On Mon, Jul 4, 2022 at 7:42 AM ChiaEn Wu <peterwu.pub@gmail.com> wrote:
>
> From: ChiaEn Wu <chiaen_wu@richtek.com>
>
> Add Mediatek MT6370 ADC support.

...

> +         This driver can also be built as a module. If so the module

If so,

> +         will be called "mt6370-adc.ko".

No ".ko" part.

...

> +#define ADC_CONV_TIME_US               35000

Since it's actually MS, drop this and use MS * 1000 whenever it's needed.


> +#define ADC_CONV_TIME_MS               (ADC_CONV_TIME_US / 1000)

...

> +static int mt6370_adc_read_label(struct iio_dev *iio_dev,
> +                                struct iio_chan_spec const *chan, char *label)
> +{
> +       return snprintf(label, PAGE_SIZE, "%s\n",
> +                       mt6370_channel_labels[chan->channel]);

sysfs_emit()

> +}

...

> +static int mt6370_adc_probe(struct platform_device *pdev)
> +{
> +       int ret;
> +       struct mt6370_adc_data *priv;
> +       struct regmap *regmap;
> +       struct iio_dev *indio_dev;

Per all your patches, use reversed xmas tree ordering ("longest line
first" rule).
Also it may be good to have a temporary variable for struct device pointer.

> +}

...

> +MODULE_DESCRIPTION("MT6370 ADC Drvier");

Driver. Spell check your patches.

-- 
With Best Regards,
Andy Shevchenko
