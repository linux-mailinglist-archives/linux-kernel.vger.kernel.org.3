Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BCCE50C358
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 01:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233318AbiDVWnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 18:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234084AbiDVWm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 18:42:56 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C35214124;
        Fri, 22 Apr 2022 14:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1650663739;
        bh=FASJJR2Tx4uF4/s/WY7/LWoW20ycDshiMItQZbSs9bU=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=MrF6gSUstM2zHBTkft9N0k3blkosRvqMDcnr9VfSgB9oE0Tk7dlp6H/3X/WJoySuP
         jjWEmtDakDxs0kIm/6IuW+ednbCRxCMKR6wxsa/M97RWFFNtorI/+SlFDXCCmTUPux
         jd/Xl67fKHd4mFmM315ulL76Men47npBl1g4TnZE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([87.78.190.74]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mlw3N-1o7vEZ2TLf-00izyL; Fri, 22
 Apr 2022 20:31:44 +0200
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
Subject: [PATCH 0/7] Nuvoton WPCM450 clock and reset driver
Date:   Fri, 22 Apr 2022 20:30:05 +0200
Message-Id: <20220422183012.444674-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lUBjNycijZc1q4is3LS9ZHsMWEXwBBLNpAxLeKbzlS/j8Due5p2
 ljr6755Dqs0uo5UTwhnk2Ib3iRRxTbS5Smc24rInSA9LcKoMsBxfM3ZWZ/dVZ/wSUBKXWr6
 Xf+kT3a3SsjJBWESluVcRlWa6VD3IcYWQm9jGqM/0ZPIcNQa3SScSfnxtrXoqY6l8IdVyb3
 x7/RLynriNGKabyGwlBCA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IHcu07vI+r0=:ftzINHBaRsiwNBb4Ii7qFZ
 e6loVkQcZ1CYeY9+XTmcU1I3B3ksH6S0td2DzoUrYlGnRoVu+DUhaLaM+j4Li0zxoIcTpplDl
 R+XqCEUZ53w0Ee0HpuOgzq4bhxKj7P/osSSH/TKnOL/mEgSIJjvEC0QhamiZXgpPZ3mWvqMKR
 C3n8S5esU/xYPPxfuLE9ccIBeJeVgZcJzGwAIZSlx0Z5fz89ijugK065K4wP90Fi84XmhI6Fo
 DwNd2NylDyoSMufFth+1JBzjfG6kpVVOPZCdU4Il9bTMOFMIQ9ESoYQ95GJyBOLbh6DZ0Vjvi
 GcGFR7hqbMk7kq5PThv1r44UlQ6P1DqGlU6VTsgZ9QuAqeYk/DVQa1NUNGE7oI+9UR2Wpo9w1
 Ixs/Y7M/vXhG00vMcAvH5opd+kw07thxRhA2I6hX0XSX7MI6Ikjxf5zpTaA7G/xRHUtfT959V
 f3dMH+iMCEXQVHo8wsWHUV3vHmQkuo4GHEyjNAy9uCLko2V0ZCvMFOrzeMSRcQuq9pmkLTCyh
 mCJmyCsO0Q3TyVxSdxev9RLlNiV9UE77NhcfrGtFXlwv1Wk6daYIhTAzYYxz6x6jhtPoIaaq8
 NWl/6MdZOIiDumAmDMEDvk796WCMr/j+K3YSueC+pz8k3sXtgBUNlcbMVU+EaSHT8uCiomZ0T
 JKqL9qM2eTQA2sV/ze0IYAblIYcw1p4ZLtqs7Jm2wGq8SP2D1ok6qzJrKPVCaUmASLz7niRtW
 hYfHAjLZGd0rSEur92CG79sm0v0EqOlT+bG7uimDaX7nfF5IOI8EQ/TFLvpA02OusfKVvU6qW
 B+fMHHpWsNQXr9+9yYFnbNsCS8VDeDMyxwwBvwBuLNlZCcDcPRbWW2xI68cwq0Yjr5tNN6kWr
 nRQxNO7bfijbecvStWMHXz9JhnimyTIH2IoZbLhxAk7SDk8X5huW8a12eT88J9ybgvvzzT29L
 A2MzGdyvkCP8WKSPEZLjlnxTSsjt1wGZ12qx+FnXx4S+lZ9KJ03gZ42TNb6VwL6+qndS28Tyo
 Qkc1o9rt6op8eurWjqszM8dZvxNEE5IgVesnczDGjWU3YAZxHJpMuWj70z8iI5kuep6aR9uHa
 oB3Xi3d5P4WNmU=
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

Jonathan Neusch=C3=A4fer (7):
  dt-bindings: timer: nuvoton,npcm7xx-timer: Allow specifying all clocks
  clocksource: timer-npcm7xx: Enable timer 1 clock before use
  watchdog: npcm: Enable clock if provided
  dt-bindings: clock: Add Nuvoton WPCM450 clock/reset controller
  ARM: dts: wpcm450: Add clock controller node
  clk: wpcm450: Add Nuvoton WPCM450 clock/reset controller driver
  ARM: dts: wpcm450: Switch clocks to clock controller

 .../bindings/clock/nuvoton,wpcm450-clk.yaml   |  74 ++++
 .../bindings/timer/nuvoton,npcm7xx-timer.yaml |   8 +-
 arch/arm/boot/dts/nuvoton-wpcm450.dtsi        |  29 +-
 drivers/clk/Makefile                          |   1 +
 drivers/clk/clk-wpcm450.c                     | 378 ++++++++++++++++++
 drivers/clocksource/timer-npcm7xx.c           |  14 +-
 drivers/reset/Kconfig                         |   2 +-
 drivers/watchdog/npcm_wdt.c                   |   9 +
 .../dt-bindings/clock/nuvoton,wpcm450-clk.h   |  67 ++++
 9 files changed, 572 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/nuvoton,wpcm45=
0-clk.yaml
 create mode 100644 drivers/clk/clk-wpcm450.c
 create mode 100644 include/dt-bindings/clock/nuvoton,wpcm450-clk.h

=2D-
2.35.1

