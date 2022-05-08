Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64CD951F0CB
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 21:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbiEHTsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 15:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiEHTsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 15:48:10 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B5DB7EF;
        Sun,  8 May 2022 12:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1652039021;
        bh=F4hpWVjFvpqMCwemAl2z39vRoOEsiSoGp9rSz1F1/+E=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=g+/mU7SoUFXR0pMX0f/tDjz/Ei6WblXyDaJJYkT8nFUbGfwcM+PUfSxUtblVDdIEF
         EebIZzgocMZj6BY/JBpGvIZfp+md4RcSDBgYSTo3wRm1jkmpULaXx5O4YhvX+l2ZwV
         0Gd16QIF2p75HHXhVBGwR0S7PU9hWPqKUESO1kLM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.215.103]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MO9z7-1nPu8y2sll-00OWeA; Sun, 08
 May 2022 21:43:41 +0200
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
Subject: [PATCH v3 0/7] Nuvoton WPCM450 clock and reset driver
Date:   Sun,  8 May 2022 21:43:25 +0200
Message-Id: <20220508194333.2170161-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DUrKjj9a6jTNCSAXIMTL+32UvpFfbMWVMeduiJnOB22p9vBDes/
 oMOOTY1V99JhK6XGiPLWMCVYKPi8DOI+K8Eig4A5Jl3sfLDTY+KqX6PDQrfHMprT9a8VWWZ
 MlKLLrx5owTsaZZbVkX2jKVs0ZVyBxJkKLT76b2Y0kC+Cp6xyCh/0z3PtmS76Z1CxB2GOo8
 tCrWaOTTquoW5AebXdUDg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gA7hVeznCgU=:iBXOY2Lo5osORmZNpmZcm/
 nnJVb0OL1mfMk97XuMqv38zbcNrUQg8yN7O29x0JOAGWJZlie2E3QXwYeQv6GVj4XvZzuS4Wm
 NL9xBjm/iBNPGi8VK83n69FsbK1KNmXPeSMyxIITmr+nhoCEdIvDI3bJUiow4+YxmgdI7omOH
 DzWiUTY9OLYyvQ4dkVe0R9C3qMvKZqJbpK28eQeQDAuyNgChq0PTK5rRK4pW5iK0mhGaaXtlQ
 T3OFqZwtI0kv19VULt3tZZWknrhSCDm+27M5cItZ4Ap2PF0o+Tu4RCmIcVY7tX05YFT36JVoi
 wHOVGz1hvFeHBx2wuZo65LG8z1bIgpIAlN44g0I+ESFgs37xI/GweP5JCEuRndYzFxECah2Bo
 NDI6nCl7YsP6nCfaV3GjXt3nNyHB4XanFecAF5KlEk5So3m9HB0gD4RZzG3tkWu7LHwsnPNqq
 JfMpvRSyleu39IZYUyod9Gbv/UE94oKtW26C6zOXqNDCJljFJsu8lIOkdD0swkL3iq9Sc4hAO
 DZ06HsFGEDgT6kJWni+m2HTLm2u66rYd8VAXry9hhlDZiYYCeOwUF09ePyslp/10FWauYG0GD
 BE4uu41aaoqlwuPKhrC+e4NN6Hpp7yZTwDwVQ74EKil6JNGFtxLtDRR+laUXXNAlhH9ySEf8a
 a02cSskMjKGlo/EiXwjMW6nB0MhPybv3FxHNf4DzwbpV6UkEyeetYN2/V2VVKODzG93n1MEyT
 yVhA9Vyq50Jg9zHBPm/Ym4fMC5lsTSH4fUrxaEzU6FaKwtYKeB+gWogtAE0YR+7ldDV7HYxuc
 ulucSr6hUwGvUbFncxK0Fv80DJBGs4qYgpQnm2Dm2BgKwfDbAh2C2gap6vMgfx2/HtF5hJudu
 BFsIt0FO8RKTTmVfXVsUatkam4fX2V5H8H4y9yL1iAiIIbZZli7ZZCwJQ8uEGvMvo8g1EbOeq
 o+TXZMaA17Rie6tfyYiMf+R8l0QhU/Z4cEioflxYACjUsuXYbfX0ewMIYFkqfP5P8wgMJezjK
 RaJlFdVzfEDa2HT2AykTmiBp7Zbhn3RQKQFnHPB0RDUcEzOmbceGmQ5Ci+SqJ6pYM0FCQt5p9
 xBDLNM1hQb48mY=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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


v3:
- Changed "refclk" string to "ref"
- Fixed some dead code in the driver
- Added clk_prepare_enable call to the watchdog restart handler
- Added a few review tags

v2:
- https://lore.kernel.org/lkml/20220429172030.398011-1-j.neuschaefer@gmx.n=
et/
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

 .../bindings/clock/nuvoton,wpcm450-clk.yaml   |  66 ++++
 .../bindings/timer/nuvoton,npcm7xx-timer.yaml |   8 +-
 arch/arm/boot/dts/nuvoton-wpcm450.dtsi        |  29 +-
 drivers/clk/Makefile                          |   1 +
 drivers/clk/clk-wpcm450.c                     | 363 ++++++++++++++++++
 drivers/clocksource/timer-npcm7xx.c           |  10 +
 drivers/reset/Kconfig                         |   2 +-
 drivers/watchdog/npcm_wdt.c                   |  18 +
 .../dt-bindings/clock/nuvoton,wpcm450-clk.h   |  67 ++++
 9 files changed, 555 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/nuvoton,wpcm45=
0-clk.yaml
 create mode 100644 drivers/clk/clk-wpcm450.c
 create mode 100644 include/dt-bindings/clock/nuvoton,wpcm450-clk.h

=2D-
2.35.1

