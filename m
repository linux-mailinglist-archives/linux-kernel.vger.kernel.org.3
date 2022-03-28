Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 251994E8F19
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 09:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238856AbiC1HhX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 28 Mar 2022 03:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238843AbiC1HhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 03:37:19 -0400
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA2F51E5B;
        Mon, 28 Mar 2022 00:35:38 -0700 (PDT)
Received: by mail-qv1-f41.google.com with SMTP id b17so1566277qvf.12;
        Mon, 28 Mar 2022 00:35:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NSmS9k73z1IP3D2QdHYwh4TDW9fTJmU9UMoo6xsufQI=;
        b=acfAYp2ABR1gjv+B5A6ocgOn4nsKn1gDGOGBIPK/n/joHLigwfGyWK/wkD7lqsjuLg
         EgrY8JyXT/a8Td3oSgP6Vt05Vsd7nc3TxeSybqhrwUz4R2SnPVEZECwQJbODVQVYNYyc
         Xg3Rynz44u6FBUoMfgEA22Bl6FtmI08H3IaeuyBqllTk1haPQNOSdA/4aGAcHO/syCFX
         Kb0zU5fIEQtnpT6hAsbIe+xoj9VvpT+aM/aNUp678J2zjXxcK4fBxuruhm4Rul79fBei
         AgvPDPEbIVZGZisGyRry6btbDljNyzbYIdvFJbpDHGeR3FGSSqo93mAVkFYYnbMKF+J0
         kowQ==
X-Gm-Message-State: AOAM531EKenaGCIjUCYy4KyURRamXVxvODdCCtPN3fohEjEgXw0NyP1j
        MY+BvnOk857+mAaRkmaI1OQs9RZH3FtZJg==
X-Google-Smtp-Source: ABdhPJx9HCSlrOfCy1RX0tHlKOQi7AonJNJPNbcRkXBbYAxLHj+oH8V7T0d4vs8/bxWyDQ/6aPlndg==
X-Received: by 2002:a05:6214:2a49:b0:441:69b0:84c7 with SMTP id jf9-20020a0562142a4900b0044169b084c7mr19452797qvb.122.1648452937649;
        Mon, 28 Mar 2022 00:35:37 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id x6-20020a376306000000b0067b32a8568esm7815817qkb.101.2022.03.28.00.35.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Mar 2022 00:35:37 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id g9so22079449ybf.1;
        Mon, 28 Mar 2022 00:35:36 -0700 (PDT)
X-Received: by 2002:a05:6902:101:b0:633:ccde:cfca with SMTP id
 o1-20020a056902010100b00633ccdecfcamr20853450ybh.207.1648452936744; Mon, 28
 Mar 2022 00:35:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220325200338.54270-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220325200338.54270-1-andriy.shevchenko@linux.intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 28 Mar 2022 09:35:25 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXJo=XWNLKpFFe65fx-c7oPXmydvXxiPzGicNaxYthGbg@mail.gmail.com>
Message-ID: <CAMuHMdXJo=XWNLKpFFe65fx-c7oPXmydvXxiPzGicNaxYthGbg@mail.gmail.com>
Subject: Re: [PATCH v1 1/5] gpiolib: Introduce gpiochip_count() helper
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Fabien Dessenne <fabien.dessenne@foss.st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Fri, Mar 25, 2022 at 9:04 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> The gpiochip_count() helper iterates over the device child nodes that have
> the "gpio-controller" property set. It returns the number of such nodes
> under given device.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks for your patch!

> --- a/include/linux/gpio/driver.h
> +++ b/include/linux/gpio/driver.h
> @@ -750,4 +751,17 @@ static inline void gpiochip_unlock_as_irq(struct gpio_chip *gc,
>  }
>  #endif /* CONFIG_GPIOLIB */
>
> +static inline unsigned int gpiochip_count(struct device *dev)
> +{
> +       struct fwnode_handle *child;
> +       unsigned int count = 0;
> +
> +       device_for_each_child_node(dev, child) {
> +               if (device_property_read_bool(child, "gpio-controller"))

error: passing argument 1 of ‘device_property_read_bool’ from
incompatible pointer type [-Werror=incompatible-pointer-types]

So I'm afraid I cannot test patch 3/5 yet ;-)

> +                       count++;
> +       }
> +
> +       return count;
> +}
> +
>  #endif /* __LINUX_GPIO_DRIVER_H */

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
