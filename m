Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DEE1542DAF
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 12:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237242AbiFHKan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 06:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238191AbiFHK34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 06:29:56 -0400
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 28276C0E3D;
        Wed,  8 Jun 2022 03:22:09 -0700 (PDT)
Received: from NTHCCAS04.nuvoton.com (NTHCCAS04.nuvoton.com [10.1.8.29])
        by maillog.nuvoton.com (Postfix) with ESMTP id 6C0A21C80414;
        Wed,  8 Jun 2022 17:56:29 +0800 (CST)
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS04.nuvoton.com
 (10.1.8.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 8 Jun
 2022 17:56:29 +0800
Received: from taln60.nuvoton.com (10.191.1.180) by NTHCCAS01.nuvoton.com
 (10.1.12.25) with Microsoft SMTP Server id 15.1.2375.7 via Frontend
 Transport; Wed, 8 Jun 2022 17:56:28 +0800
Received: by taln60.nuvoton.com (Postfix, from userid 10070)
        id D27B362D98; Wed,  8 Jun 2022 12:56:27 +0300 (IDT)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     <avifishman70@gmail.com>, <tali.perry1@gmail.com>,
        <joel@jms.id.au>, <venture@google.com>, <yuenn@google.com>,
        <benjaminfair@google.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <p.zabel@pengutronix.de>,
        <gregkh@linuxfoundation.org>, <daniel.lezcano@linaro.org>,
        <tglx@linutronix.de>, <wim@linux-watchdog.org>,
        <linux@roeck-us.net>, <catalin.marinas@arm.com>, <will@kernel.org>,
        <arnd@arndb.de>, <olof@lixom.net>, <jirislaby@kernel.org>,
        <shawnguo@kernel.org>, <bjorn.andersson@linaro.org>,
        <geert+renesas@glider.be>, <marcel.ziswiler@toradex.com>,
        <vkoul@kernel.org>, <biju.das.jz@bp.renesas.com>,
        <nobuhiro1.iwamatsu@toshiba.co.jp>, <robert.hancock@calian.com>,
        <j.neuschaefer@gmx.net>, <lkundrak@v3.sk>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <linux-watchdog@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v2 00/20] Introduce Nuvoton Arbel NPCM8XX BMC SoC
Date:   Wed, 8 Jun 2022 12:56:03 +0300
Message-ID: <20220608095623.22327-1-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset  adds initial support for the Nuvoton 
Arbel NPCM8XX Board Management controller (BMC) SoC family. 

The Nuvoton Arbel NPCM8XX SoC is a fourth-generation BMC.
The NPCM8XX computing subsystem comprises a quadcore ARM 
Cortex A35 ARM-V8 architecture.

This patchset adds minimal architecture and drivers such as:
Clocksource, Clock, Reset, and WD.

Some of the Arbel NPCM8XX peripherals are based on Poleg NPCM7XX.

This patchset was tested on the Arbel NPCM8XX evaluation board.

Addressed comments from:
 - Arnd Bergmann : https://www.spinics.net/lists/arm-kernel/msg982728.html
		   https://www.spinics.net/lists/linux-serial/msg48179.html
 - Stephen Boyd: https://www.spinics.net/lists/arm-kernel/msg983594.html
 - Krzysztof Kozlowski: https://www.spinics.net/lists/kernel/msg4368955.html
			https://www.spinics.net/lists/arm-kernel/msg982427.html
			https://lore.kernel.org/all/973d75b8-0eb6-ff5b-6cd2-9b7d7c5cbcaa@linaro.org/
			https://www.spinics.net/lists/arm-kernel/msg982778.html
			https://www.spinics.net/lists/arm-kernel/msg982588.html
 - Ilpo Järvinen: https://www.spinics.net/lists/kernel/msg4368936.html
 - Stephen Boyd: https://www.spinics.net/lists/arm-kernel/msg983596.html
 - Geert Uytterhoeven : https://www.spinics.net/lists/kernel/msg4369514.html

Changes since version 1:
 - NPCM8XX clock driver
	- Modify dt-binding.
	- Remove unsed definition and include.
	- Include alphabetically.
	- Use clock devm.
 - NPCM reset driver
	- Modify dt-binding.
	- Modify syscon name.
	- Add syscon support to NPCM7XX dts reset node.
	- use data structure.
 - NPCM8XX device tree:
	- Modify evb compatible name.
	- Add NPCM7xx compatible.
	- Remove disable nodes from the EVB DTS.

Tomer Maimon (20):
  clocksource: timer-npcm7xx: Add NPCM845 timer
  dt-bindings: serial: 8250: Add npcm845 compatible string
  tty: serial: 8250: Add NPCM845 UART support
  dt-bindings: watchdog: npcm: Add npcm845 compatible string
  watchdog: npcm_wdt: Add NPCM845 watchdog support
  dt-binding: clk: npcm845: Add binding for Nuvoton NPCM8XX Clock
  clk: npcm8xx: add clock controller
  dt-bindings: reset: modify to general NPCM name
  dt-bindings: reset: npcm: add GCR syscon property
  ARM: dts: nuvoton: add reset syscon property
  reset: npcm: using syscon instead of device data
  dt-bindings: reset: npcm: Add support for NPCM8XX
  reset: npcm: Add NPCM8XX support
  dt-bindings: arm: npcm: Add maintainer
  dt-bindings: arm: npcm: Add nuvoton,npcm845 compatible string
  dt-bindings: arm: npcm: Add nuvoton,npcm845 GCR compatible string
  arm64: npcm: Add support for Nuvoton NPCM8XX BMC SoC
  arm64: dts: nuvoton: Add initial NPCM8XX device tree
  arm64: dts: nuvoton: Add initial NPCM845 EVB device tree
  arm64: defconfig: Add Nuvoton NPCM family support

 .../devicetree/bindings/arm/npcm/npcm.yaml    |   7 +
 .../bindings/arm/npcm/nuvoton,gcr.yaml        |   2 +
 .../bindings/clock/nuvoton,npcm845-clk.yaml   |  63 ++
 ...750-reset.yaml => nuvoton,npcm-reset.yaml} |  21 +-
 .../devicetree/bindings/serial/8250.yaml      |   1 +
 .../bindings/watchdog/nuvoton,npcm-wdt.txt    |   3 +-
 MAINTAINERS                                   |   3 +
 arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi |   1 +
 arch/arm64/Kconfig.platforms                  |  11 +
 arch/arm64/boot/dts/Makefile                  |   1 +
 arch/arm64/boot/dts/nuvoton/Makefile          |   2 +
 .../dts/nuvoton/nuvoton-common-npcm8xx.dtsi   | 197 +++++
 .../boot/dts/nuvoton/nuvoton-npcm845-evb.dts  |  30 +
 .../boot/dts/nuvoton/nuvoton-npcm845.dtsi     |  76 ++
 arch/arm64/configs/defconfig                  |   3 +
 drivers/clk/Kconfig                           |   6 +
 drivers/clk/Makefile                          |   1 +
 drivers/clk/clk-npcm8xx.c                     | 756 ++++++++++++++++++
 drivers/clocksource/timer-npcm7xx.c           |   1 +
 drivers/reset/reset-npcm.c                    | 202 ++++-
 drivers/tty/serial/8250/8250_of.c             |   1 +
 drivers/watchdog/npcm_wdt.c                   |   1 +
 .../dt-bindings/clock/nuvoton,npcm8xx-clock.h |  50 ++
 .../dt-bindings/reset/nuvoton,npcm8xx-reset.h | 128 +++
 24 files changed, 1530 insertions(+), 37 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/nuvoton,npcm845-clk.yaml
 rename Documentation/devicetree/bindings/reset/{nuvoton,npcm750-reset.yaml => nuvoton,npcm-reset.yaml} (58%)
 create mode 100644 arch/arm64/boot/dts/nuvoton/Makefile
 create mode 100644 arch/arm64/boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi
 create mode 100644 arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dts
 create mode 100644 arch/arm64/boot/dts/nuvoton/nuvoton-npcm845.dtsi
 create mode 100644 drivers/clk/clk-npcm8xx.c
 create mode 100644 include/dt-bindings/clock/nuvoton,npcm8xx-clock.h
 create mode 100644 include/dt-bindings/reset/nuvoton,npcm8xx-reset.h

-- 
2.33.0

