Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB8A74EBE62
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 12:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245207AbiC3KKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 06:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239182AbiC3KKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 06:10:34 -0400
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A366154062;
        Wed, 30 Mar 2022 03:08:49 -0700 (PDT)
Received: by mail-oi1-f169.google.com with SMTP id w127so21570785oig.10;
        Wed, 30 Mar 2022 03:08:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xxF35tmxxnkPH4ZK5NEAQj60FJRzpVvnSJO5oaHeufw=;
        b=bXL1LDJiE/6ieyVsC90DLDVyC8H1dKobB4kHzTlDE9Z2547r/IDGGYH8DiJWkVUBCT
         pcE0oGhb4L3WhvncB8ozlqungtkvBf5GVYwEpQ6SX2DfMxrwp4rf4rFJf7JrCmg0saQr
         N5EbzB/Q8YEcgJJAhP9TvJd6pjohubjrImmANwNIc6jF24Td6iBKumJfDLugJ5m18XYW
         zFwfC8S6P9sxJ/wRI2EemqttjWVcdNBGJR/7M4S83h5tJ4vIL6SgkSS9ks43kwRP4fQ2
         Jo5gHaJK0POdLwt1JSqdkc86Cb9CwGN/qZjTGYWzZ2DjgTPms//ZXQWRYXt4Var6TG1Y
         D+8w==
X-Gm-Message-State: AOAM530mMYtjo8iU5txLYS28mh4DSIAH/CRL2AH3Fc0v/tte+wMVZGH6
        ClGDDcdv8kOcVw41F/R8oCdrFL6vGp6TSQ==
X-Google-Smtp-Source: ABdhPJymrMim6GuwgG9rkn34Y1quZ1IiNIC4NOmV1OZ5Z5iCKb5JvPXw5xtEE+GYbr53q5P+yRUSMA==
X-Received: by 2002:a05:6808:f07:b0:2da:4916:578e with SMTP id m7-20020a0568080f0700b002da4916578emr1377280oiw.271.1648634928459;
        Wed, 30 Mar 2022 03:08:48 -0700 (PDT)
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com. [209.85.210.42])
        by smtp.gmail.com with ESMTPSA id u23-20020a056870d59700b000de821ba7cbsm9454429oao.15.2022.03.30.03.08.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Mar 2022 03:08:48 -0700 (PDT)
Received: by mail-ot1-f42.google.com with SMTP id i11-20020a9d4a8b000000b005cda3b9754aso14578539otf.12;
        Wed, 30 Mar 2022 03:08:48 -0700 (PDT)
X-Received: by 2002:a0d:ccd6:0:b0:2e7:98e2:a5a2 with SMTP id
 o205-20020a0dccd6000000b002e798e2a5a2mr28100571ywd.479.1648634538529; Wed, 30
 Mar 2022 03:02:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220329152926.50958-1-andriy.shevchenko@linux.intel.com> <20220329152926.50958-3-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220329152926.50958-3-andriy.shevchenko@linux.intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 30 Mar 2022 12:02:07 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWFENTrXsYq3PKRFBqUL570-pPMG43Vct62=U9cyyF0yQ@mail.gmail.com>
Message-ID: <CAMuHMdWFENTrXsYq3PKRFBqUL570-pPMG43Vct62=U9cyyF0yQ@mail.gmail.com>
Subject: Re: [PATCH v2 02/13] gpiolib: Introduce gpiochip_node_count() helper
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Qianggui Song <qianggui.song@amlogic.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Fabien Dessenne <fabien.dessenne@foss.st.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        openbmc@lists.ozlabs.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Linus Walleij <linus.walleij@linaro.org>,
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
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Philipp Zabel <p.zabel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
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

On Tue, Mar 29, 2022 at 5:29 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> The gpiochip_node_count() helper iterates over the device child nodes that
> have the "gpio-controller" property set. It returns the number of such nodes
> under a given device.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks for your patch!

> --- a/include/linux/gpio/driver.h
> +++ b/include/linux/gpio/driver.h
> @@ -755,4 +755,16 @@ static inline void gpiochip_unlock_as_irq(struct gpio_chip *gc,
>         device_for_each_child_node(dev, child)                                  \
>                 if (!fwnode_property_present(child, "gpio-controller")) {} else
>
> +static inline unsigned int gpiochip_node_count(struct device *dev)
> +{
> +       struct fwnode_handle *child;
> +       unsigned int count;

Preinitialize to zero?

> +
> +       count = 0;
> +       for_each_gpiochip_node(dev, child)
> +               count++;
> +
> +       return count;
> +}
> +
>  #endif /* __LINUX_GPIO_DRIVER_H */

Regardless:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
