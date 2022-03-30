Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFE8A4EC474
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 14:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344631AbiC3MkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 08:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345594AbiC3Mh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 08:37:57 -0400
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C645AB6E4B;
        Wed, 30 Mar 2022 05:28:41 -0700 (PDT)
Received: by mail-vs1-f43.google.com with SMTP id i186so22350332vsc.9;
        Wed, 30 Mar 2022 05:28:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UOWc2z4o6DC6pqDz0yydlogP1ndPfXTDpB2t/FafZMU=;
        b=teXZgOOf7AgSgKM9Tnt3dscj6JJd3X1J2xFFSVDyx/tjbECD5FKHt0v1JgfhM+cOKT
         qSBg1Mr4dIOyuLRj+4qD6AAdQ5VRTiNS/WgnByOqfK7NwucXePaCQEASQcIlG+CzCPhd
         a8zXyY7RiPxEH4k1ToTob7wczNacaU4tEX+vI8/nAA5a2LdRmFVFRrgaLrVBqC1yrkFr
         JgGT6CtP4bBHo3b3QRz0tkwNmxDNtBxqOGjXaFODZCmAwH14x5C2a2jDYSVeayQaoOkU
         X0g6RB54QaSllhIn8Dgwcynhu7TkroAzqhaq3OFZmU65nBqePo/7kYqgwKJbRCYVG0Z9
         4Pyw==
X-Gm-Message-State: AOAM533LRUt37XV0/wn9y+4tV1phpzCgTBy0jEJhCm32RAl9iGaHRNnH
        BsckO8D66c39f9gsZCB4u9Ng/6vKGZYSsA==
X-Google-Smtp-Source: ABdhPJybvOcCU6phUffPJYqI6FXSp7eEtLE0QS7MGUZmZpWAJajQt03aKDxv2jwerNt1AGwU/6G/+Q==
X-Received: by 2002:a05:6102:3c85:b0:325:b017:ae6d with SMTP id c5-20020a0561023c8500b00325b017ae6dmr10322125vsv.5.1648643320764;
        Wed, 30 Mar 2022 05:28:40 -0700 (PDT)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com. [209.85.222.49])
        by smtp.gmail.com with ESMTPSA id z13-20020a67db0d000000b0031bd1ad83c5sm1804925vsj.21.2022.03.30.05.28.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Mar 2022 05:28:40 -0700 (PDT)
Received: by mail-ua1-f49.google.com with SMTP id o10so322945uar.0;
        Wed, 30 Mar 2022 05:28:40 -0700 (PDT)
X-Received: by 2002:a25:9e89:0:b0:63c:ad37:a5de with SMTP id
 p9-20020a259e89000000b0063cad37a5demr17071596ybq.342.1648642915183; Wed, 30
 Mar 2022 05:21:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220329152926.50958-1-andriy.shevchenko@linux.intel.com>
 <20220329152926.50958-8-andriy.shevchenko@linux.intel.com>
 <CAMuHMdWs+OuxV0cO=XGYvOOJ0Mctwu6fKV5HnkdRBXNKkLE3uQ@mail.gmail.com> <YkRKI6W4vR/aCr8c@smile.fi.intel.com>
In-Reply-To: <YkRKI6W4vR/aCr8c@smile.fi.intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 30 Mar 2022 14:21:43 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWiL+R=9NSgpxo+9e+_8jj9zm4nGwcfejap5z3XdYYtwA@mail.gmail.com>
Message-ID: <CAMuHMdWiL+R=9NSgpxo+9e+_8jj9zm4nGwcfejap5z3XdYYtwA@mail.gmail.com>
Subject: Re: [PATCH v2 07/13] pinctrl: renesas: rza1: Switch to use
 for_each_gpiochip_node() helper
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

On Wed, Mar 30, 2022 at 2:17 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Wed, Mar 30, 2022 at 12:00:27PM +0200, Geert Uytterhoeven wrote:
> > On Tue, Mar 29, 2022 at 5:29 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
>
> ...
>
> > > +       struct fwnode_reference_args of_args;
> >
> > fw_args?
>
> Perhaps just args as other drivers do?

Fine for me.

> > > -       chip->label     = devm_kasprintf(rza1_pctl->dev, GFP_KERNEL, "%pOFn",
> > > -                                        np);
> > > +       chip->label     = devm_kasprintf(rza1_pctl->dev, GFP_KERNEL, "%pfw", fwnode);
> >
> > This changes the label from e.g. "/soc/pinctrl@fcfe3000/gpio-11" to "gpio-11".
>
> Hmm... It seems other way around, i.e. it changes from the name to full name.

Oops, sorry about that.
(I accidentally included the change from testing "%pfwP" ;-)

>
> > %pfwP?
>
> But conclusion here is correct. Good catch!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
