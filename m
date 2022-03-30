Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71B904EBE15
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 11:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241224AbiC3JxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 05:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238458AbiC3JxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 05:53:19 -0400
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A81C3BBC0;
        Wed, 30 Mar 2022 02:51:32 -0700 (PDT)
Received: by mail-qv1-f48.google.com with SMTP id gh15so16426782qvb.8;
        Wed, 30 Mar 2022 02:51:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e6Qd1JdMt3NwzWK7NAVAPGEjLMWhB8qclJNlYrQ8idw=;
        b=EKnrNHAMeA1X+dMlPr6fefrf1ornReBzgw+UFvXRIkOjaXTtq5XvgIv3VhER/bIM42
         RJW+SQm/0J0Cyu1hlEh+1RILbUUbL3Mq4VjkTtMvPtSJ5JtSpBLDUeoZF6f89ckOxXHR
         hepLay/97LXQGCBb/OId5laxHXOmlD9BzhsX4mcHb5SuVM4pFEW1LJa72DLmCpIbI4yE
         s3xGM73sj7oWhV2SlRcKTURJqyg+jl/iq4rdl+dBkQZDHYLhheqfI1SpzjiOcExiej8y
         A4ai/OppzfezzaCJGsP3jb7Rc2mrmCsnKK0Q2UN3wtnww4dKqUwXKoB7+2cqlVJgqhad
         gusg==
X-Gm-Message-State: AOAM531UNUOFwAJZ+L8FsHnPWGTewzL2OQp+51ZFQZVUem4xR1RQyOXC
        UcG8XnyXLjb0CTjBRAWqhSuzAc9Z/fc/UQ==
X-Google-Smtp-Source: ABdhPJxL7t74eeJaRcq1jmZDN1SAUAM/kucneLUPvtemPzCU+PidNJuDdcjObQOqqxoy/jf7CPRQGA==
X-Received: by 2002:a05:6214:4016:b0:441:28be:7c45 with SMTP id kd22-20020a056214401600b0044128be7c45mr31024352qvb.80.1648633891525;
        Wed, 30 Mar 2022 02:51:31 -0700 (PDT)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id bm21-20020a05620a199500b0067d5e6c7bd8sm10798220qkb.56.2022.03.30.02.51.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Mar 2022 02:51:31 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-2e64a6b20eeso211858937b3.3;
        Wed, 30 Mar 2022 02:51:30 -0700 (PDT)
X-Received: by 2002:a81:c703:0:b0:2d0:cc6b:3092 with SMTP id
 m3-20020a81c703000000b002d0cc6b3092mr34863152ywi.449.1648633890723; Wed, 30
 Mar 2022 02:51:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220329152926.50958-1-andriy.shevchenko@linux.intel.com> <20220329152926.50958-7-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220329152926.50958-7-andriy.shevchenko@linux.intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 30 Mar 2022 11:51:19 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVSBh7Tnf5pnCfzf7=h5sttX2qH5j4kOkvvcuCMydmeYw@mail.gmail.com>
Message-ID: <CAMuHMdVSBh7Tnf5pnCfzf7=h5sttX2qH5j4kOkvvcuCMydmeYw@mail.gmail.com>
Subject: Re: [PATCH v2 06/13] pinctrl: renesas: rza1: Replace custom code by
 gpiochip_node_count() call
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

On Tue, Mar 29, 2022 at 5:29 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> Since we have generic function to count GPIO controller nodes
> under a given device, there is no need to open code it. Replace
> custom code by gpiochip_node_count() call.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
