Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3344E21AC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 09:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345083AbiCUIEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 04:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240711AbiCUIEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 04:04:37 -0400
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD20632988;
        Mon, 21 Mar 2022 01:03:11 -0700 (PDT)
Received: by mail-qt1-f175.google.com with SMTP id v19so3189004qtw.9;
        Mon, 21 Mar 2022 01:03:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=teTz6hR8vkK2RK+SXqwF1pvHE4MUy9t3M4zQfofPznY=;
        b=DFpu9wElW+LSQm+kp9zGFnsCRsu9mH+ch9zIuHCHGBp43rQNVzSGe7N/N7thvGKoDQ
         XT/UMWnYJPIUOm7nmlnabVB6x7Pw9pEwg2Gaim5kB+Vlq+yanwrcDjHUH6zJ750kyVYL
         2FLA5WQ/mNtDKKl6XyrEOXbCwkbC2RmoQSy0WXvbbZJtumFV3igssztvNQBmKT+5mTf9
         VburAVXp9aGk7hu/Zbtdqkib79FpDecBPw+zVdO0w0TB6gr6E12oJQvuvkc2tnd+zKU2
         IkhapE3BhlGRbjuJAftjA/y8Mw8LPviciQtOgEtxC0JRyKZyaBysJaXxCWBbHW43Eh1K
         Q6fQ==
X-Gm-Message-State: AOAM531Nsc2WTKzZHZDDoQ49VFaIO2xDkxgvk54e40+IeMKBXAIQ6Jhv
        5rqdmH/TJSsqTexHZaWJrq3x6yXXonVhHg==
X-Google-Smtp-Source: ABdhPJyV54O+hByVFp+yMQW3WbgAtXSbTgYmo/1lNbaxkADDT69H/t3jNwYhR8Ijbgx5fJR2aJeQcg==
X-Received: by 2002:ac8:578a:0:b0:2e1:a0d2:c3a with SMTP id v10-20020ac8578a000000b002e1a0d20c3amr15480073qta.261.1647849789907;
        Mon, 21 Mar 2022 01:03:09 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id w17-20020ac857d1000000b002e19feda592sm10901470qta.85.2022.03.21.01.03.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Mar 2022 01:03:09 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id z8so26552627ybh.7;
        Mon, 21 Mar 2022 01:03:09 -0700 (PDT)
X-Received: by 2002:a25:aa0e:0:b0:633:7c3b:94a0 with SMTP id
 s14-20020a25aa0e000000b006337c3b94a0mr22974180ybi.546.1647849788969; Mon, 21
 Mar 2022 01:03:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220124121009.108649-1-alistair@alistair23.me>
 <20220124121009.108649-6-alistair@alistair23.me> <CAMuHMdUe-z-6_=W5AFtWMug-cqTZKJhd-iLbdoRnSKoXwm27Uw@mail.gmail.com>
 <CAKmqyKNtE8=Jna78+L2a8BwsgM+LZVPi4ppg8Z0RGJ-21RqPtw@mail.gmail.com>
In-Reply-To: <CAKmqyKNtE8=Jna78+L2a8BwsgM+LZVPi4ppg8Z0RGJ-21RqPtw@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 21 Mar 2022 09:02:57 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWF5z7oYpsBybeAGRA2jWToZD=7wnvtiULg9irQ=rbQSQ@mail.gmail.com>
Message-ID: <CAMuHMdWF5z7oYpsBybeAGRA2jWToZD=7wnvtiULg9irQ=rbQSQ@mail.gmail.com>
Subject: Re: [PATCH v18 5/8] hwmon: sy7636a: Add temperature driver for sy7636a
To:     Alistair Francis <alistair23@gmail.com>
Cc:     Alistair Francis <alistair@alistair23.me>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-hwmon@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, NXP Linux Team <linux-imx@nxp.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Andreas Kemnade <andreas@kemnade.info>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
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

Hi Alistair,

On Mon, Mar 21, 2022 at 8:35 AM Alistair Francis <alistair23@gmail.com> wrote:
> On Tue, Mar 8, 2022 at 9:21 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Mon, Jan 24, 2022 at 1:25 PM Alistair Francis <alistair@alistair23.me> wrote:
> > > This is a multi-function device to interface with the sy7636a
> > > EPD PMIC chip from Silergy.
> > >
> > > Signed-off-by: Alistair Francis <alistair@alistair23.me>
> > > Acked-by: Guenter Roeck <linux@roeck-us.net>
> >
> > Thanks for your patch, which is now commit de34a40532507814 ("hwmon:
> > sy7636a: Add temperature driver for sy7636a") in mfd/for-mfd-next.
> >
> > > --- a/drivers/hwmon/Kconfig
> > > +++ b/drivers/hwmon/Kconfig
> > > @@ -1672,6 +1672,15 @@ config SENSORS_SIS5595
> > >           This driver can also be built as a module. If so, the module
> > >           will be called sis5595.
> > >
> > > +config SENSORS_SY7636A
> > > +       tristate "Silergy SY7636A"
> > > +       help
> > > +         If you say yes here you get support for the thermistor readout of
> > > +         the Silergy SY7636A PMIC.
> >
> > As this is an i2c mfd device, you do need a dependency on MFD and I2C,
> > or some other symbol, unless compile-testing?
>
> It doesn't depend on either to build though. It can be built independently.

That is true.

But do you think all users configuring their kernel should be asked
about all (thousands) of config symbols for drivers that can be built,
but won't work or are irrelevant otherwise?

Please read
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/kbuild/kconfig-language.rst#n541

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
