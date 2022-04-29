Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FEBE5151A8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 19:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbiD2RYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 13:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235457AbiD2RY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 13:24:29 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02B24EF69;
        Fri, 29 Apr 2022 10:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1651252835;
        bh=2h4V0W/yZhCGU1mSyzjHlAuoaUTbxzS6gJejM6vkUcc=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=UsxigpwSjfbS0HKai5sT9/OgsaE1eJu29VEgfFrBixpIDJisHnShF/6KGIuvqR3tT
         oIkG/nN0UmL/MlQgLkjdPkxB8SuSNggQ3olLPmwnuxRlo90pzlqbzoO2VNjGjFWmQG
         OuyIuY6aA/i+kqVP1pwHHBpBfItmrvVAKECFxDOs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.215.103]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MBlxM-1nYPT50EGK-00CATa; Fri, 29
 Apr 2022 19:20:35 +0200
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-clk@vger.kernel.org, openbmc@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 0/7] Nuvoton WPCM450 clock and reset driver
Date:   Fri, 29 Apr 2022 19:20:23 +0200
Message-Id: <20220429172030.398011-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TwLeqC0Md/m/ttyQAH8dOoovZVevV61hYozSDqi4RiDGLFt1HpI
 F4vnLOhH3qGNu8Ob+KwyGa8g8zikwbZ3yRSdu97LnDkVon+U0nKqckfpmgwlpomC+kV9v0C
 44G9l/cZKGNUgDhpI+nQQMq7n1hASAQkTI8CUeBoVWWCd4G6dTiIyOAY84nL/HI8R78plRR
 wbkeCJC8EzSwcIKawVbGw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3ZFw5jkiuog=:39Sd7Zc9bT++8WE1jaR3bU
 49oHNXN70y/k456eSqtJRPUA3b1MgZnRGoG/0a+bGA579Px7GzP/2ELmTEAupf+kxSFFzKWfZ
 7AyFAr1MMLa6X9qUImPQTkuKThlDbb+4COriI5kSXEY9ZOTwFXQq7FdUDmxiQNsuK8IanUWQK
 htemUfBrV5P0TVslwbr9E1nbc2b5bqLNMvt4LJ7ejQY4Qn7HLuiHWiQzcODEWlo/cgq41myFG
 dJAG4mhyyFZxTZ9c6XP8CKXknXRbM7whzddETbGQQAD4i0yAYb14oudC2nGeunL7j5xEzzWQl
 4dE0DRQ8hFL6SeylDXRZT/GbJOa5hg0Ig+XFYArwV9CPxzgSQh8jL5wVg2hjng6Et5vpt45oe
 o225HMdimy85rZkKPD2uNGTXwBAj4r+pKdtIZ9O9RiZYm9pTekGL6bMkkgZSYFzeTp4SBtEEB
 2iMVMgbYTaceVEhbv9RvKV/D26RNXdB+EEB52pS3Isl7/BqHnRMCujH/qagrSxsZy/FYi9zNd
 blhmOc+Y/QnE4nkll+rYI1z7TYoPiflty/O2g+v/rNB69/esNHdw49fP6E6jwPud3vqkXA+8a
 IzV2KwZpxZewsaYB6hvsq2YCMbhFOWsbY3BqJ4ohuEUYZrcojN9IpqUg+si+84RsQ2EH4lw9O
 YNh7f1qgEiJE6XBGcrBoB7NhaLZ+ZvAIvUIbx8xktUXRd9Qh+KV+4i1hWyxRzNLJaObWP2DiX
 fvDTKREuaELFCZdX9HUf6TmiaEgfMFwCslxWczjHNUarWFBC78ePWBXi3Lz1jdT42P2XMQypK
 RNNgYnVtxzKntm2SqBTNab0wegmBTZwDMD/V/Ja69VwIgaIDuIiUQfjjVYyvN3SKcFp7z5xE7
 ChFpcZkKJuEqscq38EuULjWJX8wp64C855bzO+RkDrE8l8ViMB9Qqd4o3+0Gr0G40QPAKGcjp
 Z+zr6muGR8WcSZ6Mo4UrGZ+cJfCRynWoUxCzkWMa3PxBcjF0ApapvieL2iCez9x4y89t3bCjt
 3IXFynkqME34CrEH2lIFBiV8q15pX1vsT8YzxNUiFQy25LGeWi6Stlyfg3d1q1/U9gEAP0+lP
 oAkFGfO2rZDrkM=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for the clock and reset controller in the Nuvoton
WPCM450 SoC. This means that the clock rates for peripherals will be calcu=
lated
automatically based on the clock tree as it was preconfigured by the bootl=
oader.
The 24 MHz dummy clock, that is currently in the devicetree, is no longer =
needed.
Somewhat unfortunately, this also means that there is a breaking change on=
ce
the devicetree starts relying on the clock driver, but I find it acceptabl=
e in
this case, because WPCM450 is still at a somewhat early stage.


Upstreaming plan (although other suggestions are welcome):

Once reviewed,

- The ARM/dts changes should go through Joel Stanley's bmc tree
- The clocksource/timer changes should probably go via Daniel Lezcano and =
TIP
- The watchdog patch should go via the watchdog tree
- The clock controller bindings and driver should go through the clk tree
- It might make sense to delay the final ARM/dts patch ("ARM: dts: wpcm450=
:
  Switch clocks to clock controller") until next cycle to make sure it is
  merged after the clock driver.


New in version 2:
- various small improvements

v1:
- https://lore.kernel.org/lkml/20220422183012.444674-1-j.neuschaefer@gmx.n=
et/


Jonathan Neusch=C3=A4fer (7):
  dt-bindings: timer: nuvoton,npcm7xx-timer: Allow specifying all clocks
  clocksource: timer-npcm7xx: Enable timer 1 clock before use
  watchdog: npcm: Enable clock if provided
  dt-bindings: clock: Add Nuvoton WPCM450 clock/reset controller
  ARM: dts: wpcm450: Add clock controller node
  clk: wpcm450: Add Nuvoton WPCM450 clock/reset controller driver
  ARM: dts: wpcm450: Switch clocks to clock controller

 .../bindings/clock/nuvoton,wpcm450-clk.yaml   |  66 +++
 .../bindings/timer/nuvoton,npcm7xx-timer.yaml |   8 +-
 arch/arm/boot/dts/nuvoton-wpcm450.dtsi        |  29 +-
 drivers/clk/Makefile                          |   1 +
 drivers/clk/clk-wpcm450.c                     | 378 ++++++++++++++++++
 drivers/clocksource/timer-npcm7xx.c           |  10 +
 drivers/reset/Kconfig                         |   2 +-
 drivers/watchdog/npcm_wdt.c                   |  12 +
 .../dt-bindings/clock/nuvoton,wpcm450-clk.h   |  67 ++++
 9 files changed, 564 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/nuvoton,wpcm45=
0-clk.yaml
 create mode 100644 drivers/clk/clk-wpcm450.c
 create mode 100644 include/dt-bindings/clock/nuvoton,wpcm450-clk.h

=2D-
2.35.1

