Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DAB44F4424
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 00:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442976AbiDEUHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 16:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378121AbiDENNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 09:13:17 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 937449A990
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 05:13:20 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id l26so9946777ejx.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 05:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w/Z5VzjPaah7N0YUbtAhapqjSjMXfGCadaBASbAspD0=;
        b=7dOiBFDRRvuhX8nNQguHmbWm8+QE2DPP5lE6QQD4Pd+x55V/KnhDuzAmKXTJfOARUL
         v+TNzqGFPW3+EGqiUCPOVmiDKgZxsGTSTnC0X5ZQVtl974YDs4B5Iz5CXjBqWbou2Awp
         yWqAzw62kex2Pk0y9GpVAT1Se8ZGHdxfLA76vbdm1RNCzc9+ANL/kg7ntkI2zIpHTr/m
         Llp/luaTI55RpNSJ/yjFbyWKipC98B7qcWuHW98I4ksMx0B2VYan5xfJEd3fz9r65Fbo
         yYv+658/+ggJ1eqVFoc8k39bYRCt6XFnmBAmyIWw26HtjOd8PhMgKFU8rHcLxqexneSl
         iQZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w/Z5VzjPaah7N0YUbtAhapqjSjMXfGCadaBASbAspD0=;
        b=6GKMTmPFmh6uVc5clTxb1WgvQgnm59OYo3OnAS6FnzPbuvjl9hrAw8cdvyxzf16wHI
         TwPBA3aNLaTI4weBEGNqDUpp0vksr07SuGW2f/CIevaBMthurXvQ/iEqKwABQFVkqZRk
         8GA1sZA4yjbKFp2eYmL7GBt9B8gRbP+GHU8GLku0tAFvjH6vzsXHny5uUeYJAvCDJA3x
         bzHK47BDuFLHKHyS7uyrLKDOoPzfQD4iBiu7Xz5Nei+/+5amEEUyByjsDQKfgu/r46Ms
         xMxCv8woKoHFNlBj/mTt3JNiEjD/4eU5nsnZl9EqsY8r9lV3LNvdOW7dq6BJOe56hsK5
         bdYw==
X-Gm-Message-State: AOAM5338pYiSobGOmqLhi0hzQ1F7m2Vqz9LBoKIEGMce7YMBbXy26tzQ
        dudqsgmD3VKATB7HJmQvHSu1D551Pcz2mjNq6V10mg==
X-Google-Smtp-Source: ABdhPJxVvhV5WZmApCq0DsgEovGa26+9MHznvNSVzqBc6ACt4ofBrfoHmbUA4s/kOIOSyV1hrsGZJlqKWGVuGtI+4qo=
X-Received: by 2002:a17:906:6a1d:b0:6e8:35a:4439 with SMTP id
 qw29-20020a1709066a1d00b006e8035a4439mr3387538ejc.734.1649160799105; Tue, 05
 Apr 2022 05:13:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220401103604.8705-1-andriy.shevchenko@linux.intel.com> <20220401103604.8705-3-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220401103604.8705-3-andriy.shevchenko@linux.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 5 Apr 2022 14:13:08 +0200
Message-ID: <CAMRc=MeaSC6kvwfGAhX7XbeFvaw7MiozTj1p+ThZYCHZFppSzg@mail.gmail.com>
Subject: Re: [PATCH v4 02/13] gpiolib: Introduce gpiochip_node_count() helper
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Qianggui Song <qianggui.song@amlogic.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Fabien Dessenne <fabien.dessenne@foss.st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-samsung-soc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 1, 2022 at 12:36 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> The gpiochip_node_count() helper iterates over the device child nodes that
> have the "gpio-controller" property set. It returns the number of such nodes
> under a given device.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  include/linux/gpio/driver.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
> index bfc91f122d5f..12de0b22b4ef 100644
> --- a/include/linux/gpio/driver.h
> +++ b/include/linux/gpio/driver.h
> @@ -755,4 +755,15 @@ static inline void gpiochip_unlock_as_irq(struct gpio_chip *gc,
>         device_for_each_child_node(dev, child)                                  \
>                 if (!fwnode_property_present(child, "gpio-controller")) {} else
>
> +static inline unsigned int gpiochip_node_count(struct device *dev)
> +{
> +       struct fwnode_handle *child;
> +       unsigned int count = 0;
> +
> +       for_each_gpiochip_node(dev, child)
> +               count++;
> +
> +       return count;
> +}
> +
>  #endif /* __LINUX_GPIO_DRIVER_H */
> --
> 2.35.1
>

Acked-by: Bartosz Golaszewski <brgl@bgdev.pl>
