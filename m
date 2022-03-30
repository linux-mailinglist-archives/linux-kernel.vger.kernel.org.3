Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18FB34EBE3B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 12:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245083AbiC3KC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 06:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238630AbiC3KCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 06:02:54 -0400
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D77ABAB9E;
        Wed, 30 Mar 2022 03:01:10 -0700 (PDT)
Received: by mail-qt1-f178.google.com with SMTP id t19so17607294qtc.4;
        Wed, 30 Mar 2022 03:01:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eWVEyP8xb0gTFVWSPikhwxNAnBSVX8r5lpCe0its8eQ=;
        b=XBDxFUybSvvC1Okm5OVt9T10EOLnylyF9AIL+6sVVbVgcKiwFNiNc8HlYQpfCYM3Xg
         OeMR9Hh7WZFiY4U8Zb9QJTCpzAidLpSYQGe5/oP+xwGePLI+ZMcXh5iIpJk6lIElMXlg
         AEuMhs0X5NSui6VETZ1fjnmlFcxHPsgsgF2YvAPqFwB8jisJZvOH4WyIY34Peew7u08y
         DCUi/hBu5LT96833QqdHPmD/8i7txHPPvqar/1/QotUijT/MrnPuk8HGkaR6UFbjT6zs
         N9lHMjaElE7B2Lsm4117xKqrnhLW0rXh6ilafI/yuV60wwcsWZlNqQZhzJmfxYSH/BfD
         5cnA==
X-Gm-Message-State: AOAM531CKSlhy83d2UeOkpcPD5d63IYJ7MFtJCYHT1K9Vf5DyY3r6NEx
        T2AzeSdYH8BDE6HboJE3td7gfdiR1hVaEw==
X-Google-Smtp-Source: ABdhPJyggRKEAKdza6eL+xsqfl3Lbe2LC+bU1LHjQKBDxw9ljm7XGvdQnctaM7WhblVR7NEv7uhMAw==
X-Received: by 2002:a05:622a:48e:b0:2e0:706f:1d4 with SMTP id p14-20020a05622a048e00b002e0706f01d4mr31845297qtx.326.1648634468538;
        Wed, 30 Mar 2022 03:01:08 -0700 (PDT)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id s13-20020a05620a0bcd00b0067afe7dd3ffsm11279652qki.49.2022.03.30.03.01.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Mar 2022 03:01:07 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-2e5757b57caso212260577b3.4;
        Wed, 30 Mar 2022 03:01:06 -0700 (PDT)
X-Received: by 2002:a25:aa0e:0:b0:633:7c3b:94a0 with SMTP id
 s14-20020a25aa0e000000b006337c3b94a0mr33028380ybi.546.1648634466403; Wed, 30
 Mar 2022 03:01:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220329152926.50958-1-andriy.shevchenko@linux.intel.com> <20220329152926.50958-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220329152926.50958-2-andriy.shevchenko@linux.intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 30 Mar 2022 12:00:55 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXhiLi8YxxG0f9hBfBkwds3LAdJNSOBSR9FYE4_z=RvcA@mail.gmail.com>
Message-ID: <CAMuHMdXhiLi8YxxG0f9hBfBkwds3LAdJNSOBSR9FYE4_z=RvcA@mail.gmail.com>
Subject: Re: [PATCH v2 01/13] gpiolib: Introduce for_each_gpiochip_node() loop helper
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2022 at 5:29 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> Introduce for_each_gpiochip_node() loop helper which iterates over
> the GPIO controller child nodes of a given device.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
