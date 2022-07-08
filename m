Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE6156B2F6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 08:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237286AbiGHGvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 02:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237176AbiGHGu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 02:50:57 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5336D575;
        Thu,  7 Jul 2022 23:50:56 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id v10-20020a05600c15ca00b003a2db8aa2c4so151508wmf.2;
        Thu, 07 Jul 2022 23:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6XBQce7zwRnpvaLmBaVIeotYp8P96ziIJytN85FXctM=;
        b=AjSeoUJbomeW1IXFjPXl7DIYIDNHlhxHbpb4eCW1LeYNMbOeZY3WC7g4TDTcUUqeIz
         +qIO0SuldALV6BH33PVe6Z3c7wF+Nj1fRXUOILQSAUjF3Tk8DoROaijdRobS93nPmD3q
         kyuzXr6q1Pb9o+mXNIvH7huLr18KYQ1NjxTpE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6XBQce7zwRnpvaLmBaVIeotYp8P96ziIJytN85FXctM=;
        b=TZu3uLEe47slIeYGGIxouPW0EKAIP/dlaq/bTRIOfeRqOKOeba23AqPOmOCKgd+RNV
         XK7TzcMBdyBGHmAAUJeyW5a/1ymByWN7OsglBWV+mfEtq3wneXg4BTAsRAwIwAAaKehq
         d0o4B/zeJM6lmjGRXTWS/g6PCM4GgKfllBwcSKMCVfj2kM106paK25cBze1D/5AiX7+Z
         TQB+b2Xok+94Q84o+pSx+nKIGLW16tzSaArI+TTcjHq0DqFb4CsKwkdcmTsNI7JfLiNs
         JHcblQEjJQaF/X39Bw7wIVrmwPZ56qEvrZ5HhNJ4k625mLgOogTjZ5TYtH5jq5WqAsHB
         j5eg==
X-Gm-Message-State: AJIora9du5A7pPVL8+eaFFkfvabpqtvjiEHF2+rOQ95K3LCI1CC+fZSv
        4owbkjC7T1Rr5WLNfjyagYiN4ktI4IBqQ9gv9KA=
X-Google-Smtp-Source: AGRyM1uz5oMoz8OYfAcWbQtcCuWZ0Lmg5PXdSShK8XZXZl42alrZYcKA24QoOUqYVKsip3j1GJvApRwA4bknAJwnMw0=
X-Received: by 2002:a05:600c:21c3:b0:3a0:3aad:7f30 with SMTP id
 x3-20020a05600c21c300b003a03aad7f30mr8958204wmj.190.1657263054976; Thu, 07
 Jul 2022 23:50:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220706165406.117349-1-tmaimon77@gmail.com>
In-Reply-To: <20220706165406.117349-1-tmaimon77@gmail.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Fri, 8 Jul 2022 06:50:42 +0000
Message-ID: <CACPK8Xd0n5cpsCJ6guPzEj8JfXkz_ERzU3VdXW-Xx2QX8ssNKg@mail.gmail.com>
Subject: Re: [PATCH v7 00/16] Introduce Nuvoton Arbel NPCM8XX BMC SoC
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     Avi Fishman <avifishman70@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, catalin.marinas@arm.com,
        will@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>,
        Jiri Slaby <jirislaby@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, bjorn.andersson@linaro.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        marcel.ziswiler@toradex.com, Vinod Koul <vkoul@kernel.org>,
        biju.das.jz@bp.renesas.com, nobuhiro1.iwamatsu@toshiba.co.jp,
        robert.hancock@calian.com,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Lubomir Rintel <lkundrak@v3.sk>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Wed, 6 Jul 2022 at 16:54, Tomer Maimon <tmaimon77@gmail.com> wrote:
>
> This patchset  adds initial support for the Nuvoton
> Arbel NPCM8XX Board Management controller (BMC) SoC family.

Are you happy with a cross tree new soc branch for this series? If so
I can put them in a branch and get some build coverage before sending
them out.

(I notice the clock and reset changes are waiting on acks still)

Cheers,

Joel


>
> The Nuvoton Arbel NPCM8XX SoC is a fourth-generation BMC.
> The NPCM8XX computing subsystem comprises a quadcore ARM
> Cortex A35 ARM-V8 architecture.
>
> This patchset adds minimal architecture and drivers such as:
> Clocksource, Clock, Reset, and WD.
>
> Some of the Arbel NPCM8XX peripherals are based on Poleg NPCM7XX.
>
> This patchset was tested on the Arbel NPCM8XX evaluation board.
>
> Addressed comments from:
>  - Philipp Zabel: https://www.spinics.net/lists/arm-kernel/msg993305.html
>
> Changes since version 6:
>  - NPCM reset driver
>         - Modify warning message.
>  - dt-bindings: serial: 8250: Add npcm845 compatible string patch accepted, due
>    to it the patch removed from the patchset.
>
> Changes since version 5:
>  - NPCM8XX clock driver
>         - Remove refclk if devm_of_clk_add_hw_provider function failed.
>  - NPCM8XX clock source driver
>         - Remove NPCM8XX TIMER_OF_DECLARE support, using the same as NPCM7XX.
>
> Changes since version 4:
>  - NPCM8XX clock driver
>         - Use the same quote in the dt-binding file.
>
> Changes since version 3:
>  - NPCM8XX clock driver
>         - Rename NPCM8xx clock dt-binding header file.
>         - Remove unused structures.
>         - Improve Handling the clocks registration.
>  - NPCM reset driver
>         - Add ref phandle to dt-binding.
>
> Changes since version 2:
>  - Remove NPCM8xx WDT compatible patch.
>  - Remove NPCM8xx UART compatible patch.
>  - NPCM8XX clock driver
>         - Add debug new line.
>         - Add 25M fixed rate clock.
>         - Remove unused clocks and clock name from dt-binding.
>  - NPCM reset driver
>         - Revert to npcm7xx dt-binding.
>         - Skip dt binding quotes.
>         - Adding DTS backward compatibility.
>         - Remove NPCM8xx binding include file.
>         - Warp commit message.
> - NPCM8XX device tree:
>         - Remove unused clock nodes (used in the clock driver)
>         - Modify gcr and rst node names.
>
> Changes since version 1:
>  - NPCM8XX clock driver
>         - Modify dt-binding.
>         - Remove unsed definition and include.
>         - Include alphabetically.
>         - Use clock devm.
>  - NPCM reset driver
>         - Modify dt-binding.
>         - Modify syscon name.
>         - Add syscon support to NPCM7XX dts reset node.
>         - use data structure.
>  - NPCM8XX device tree:
>         - Modify evb compatible name.
>         - Add NPCM7xx compatible.
>         - Remove disable nodes from the EVB DTS.
>
> Tomer Maimon (16):
>   dt-bindings: timer: npcm: Add npcm845 compatible string
>   dt-bindings: watchdog: npcm: Add npcm845 compatible string
>   dt-binding: clk: npcm845: Add binding for Nuvoton NPCM8XX Clock
>   clk: npcm8xx: add clock controller
>   dt-bindings: reset: npcm: add GCR syscon property
>   ARM: dts: nuvoton: add reset syscon property
>   reset: npcm: using syscon instead of device data
>   dt-bindings: reset: npcm: Add support for NPCM8XX
>   reset: npcm: Add NPCM8XX support
>   dt-bindings: arm: npcm: Add maintainer
>   dt-bindings: arm: npcm: Add nuvoton,npcm845 compatible string
>   dt-bindings: arm: npcm: Add nuvoton,npcm845 GCR compatible string
>   arm64: npcm: Add support for Nuvoton NPCM8XX BMC SoC
>   arm64: dts: nuvoton: Add initial NPCM8XX device tree
>   arm64: dts: nuvoton: Add initial NPCM845 EVB device tree
>   arm64: defconfig: Add Nuvoton NPCM family support
>
>  .../devicetree/bindings/arm/npcm/npcm.yaml    |   7 +
>  .../bindings/arm/npcm/nuvoton,gcr.yaml        |   2 +
>  .../bindings/clock/nuvoton,npcm845-clk.yaml   |  49 ++
>  .../bindings/reset/nuvoton,npcm750-reset.yaml |  10 +-
>  .../bindings/timer/nuvoton,npcm7xx-timer.yaml |   2 +
>  .../bindings/watchdog/nuvoton,npcm-wdt.txt    |   3 +-
>  MAINTAINERS                                   |   2 +
>  arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi |   1 +
>  arch/arm64/Kconfig.platforms                  |  11 +
>  arch/arm64/boot/dts/Makefile                  |   1 +
>  arch/arm64/boot/dts/nuvoton/Makefile          |   2 +
>  .../dts/nuvoton/nuvoton-common-npcm8xx.dtsi   | 170 +++++
>  .../boot/dts/nuvoton/nuvoton-npcm845-evb.dts  |  30 +
>  .../boot/dts/nuvoton/nuvoton-npcm845.dtsi     |  76 +++
>  arch/arm64/configs/defconfig                  |   3 +
>  drivers/clk/Kconfig                           |   6 +
>  drivers/clk/Makefile                          |   1 +
>  drivers/clk/clk-npcm8xx.c                     | 600 ++++++++++++++++++
>  drivers/reset/reset-npcm.c                    | 207 +++++-
>  .../dt-bindings/clock/nuvoton,npcm845-clk.h   |  49 ++
>  20 files changed, 1196 insertions(+), 36 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/nuvoton,npcm845-clk.yaml
>  create mode 100644 arch/arm64/boot/dts/nuvoton/Makefile
>  create mode 100644 arch/arm64/boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi
>  create mode 100644 arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dts
>  create mode 100644 arch/arm64/boot/dts/nuvoton/nuvoton-npcm845.dtsi
>  create mode 100644 drivers/clk/clk-npcm8xx.c
>  create mode 100644 include/dt-bindings/clock/nuvoton,npcm845-clk.h
>
> --
> 2.33.0
>
