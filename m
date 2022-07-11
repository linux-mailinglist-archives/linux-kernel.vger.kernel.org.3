Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6191B570255
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 14:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbiGKMfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 08:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiGKMfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 08:35:30 -0400
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1B85E53D02;
        Mon, 11 Jul 2022 05:35:27 -0700 (PDT)
Received: from NTHCCAS04.nuvoton.com (NTHCCAS04.nuvoton.com [10.1.8.29])
        by maillog.nuvoton.com (Postfix) with ESMTP id 041601C81183;
        Mon, 11 Jul 2022 20:35:25 +0800 (CST)
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS04.nuvoton.com
 (10.1.8.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 11
 Jul 2022 20:35:24 +0800
Received: from taln60.nuvoton.co.il (10.191.1.180) by NTHCCAS01.nuvoton.com
 (10.1.12.25) with Microsoft SMTP Server id 15.1.2375.7 via Frontend
 Transport; Mon, 11 Jul 2022 20:35:24 +0800
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id 80DD063A23; Mon, 11 Jul 2022 15:35:23 +0300 (IDT)
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
Subject: [PATCH v8 00/16] Introduce Nuvoton Arbel NPCM8XX BMC SoC
Date:   Mon, 11 Jul 2022 15:35:03 +0300
Message-ID: <20220711123519.217219-1-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
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

Changes since version 7:
 - NPCM8XX clock driver
	- The clock and reset registers using the same memory region, 
	  due to it the clock driver should claim the ioremap directly 
	  without checking the memory region.

Changes since version 6:
 - NPCM reset driver
	- Modify warning message.
 - dt-bindings: serial: 8250: Add npcm845 compatible string patch accepted, due
   to it the patch removed from the patchset.

Changes since version 5:
 - NPCM8XX clock driver
	- Remove refclk if devm_of_clk_add_hw_provider function failed.
 - NPCM8XX clock source driver
	- Remove NPCM8XX TIMER_OF_DECLARE support, using the same as NPCM7XX.

Changes since version 4:
 - NPCM8XX clock driver
	- Use the same quote in the dt-binding file.

Changes since version 3:
 - NPCM8XX clock driver
	- Rename NPCM8xx clock dt-binding header file.
	- Remove unused structures.
	- Improve Handling the clocks registration.
 - NPCM reset driver
	- Add ref phandle to dt-binding.

Changes since version 2:
 - Remove NPCM8xx WDT compatible patch.
 - Remove NPCM8xx UART compatible patch.
 - NPCM8XX clock driver
	- Add debug new line.
	- Add 25M fixed rate clock.
	- Remove unused clocks and clock name from dt-binding.
 - NPCM reset driver
	- Revert to npcm7xx dt-binding.
	- Skip dt binding quotes.
	- Adding DTS backward compatibility.
	- Remove NPCM8xx binding include file.
	- Warp commit message.
- NPCM8XX device tree:
	- Remove unused clock nodes (used in the clock driver)
	- Modify gcr and rst node names.

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

Tomer Maimon (16):
  dt-bindings: timer: npcm: Add npcm845 compatible string
  dt-bindings: watchdog: npcm: Add npcm845 compatible string
  dt-binding: clk: npcm845: Add binding for Nuvoton NPCM8XX Clock
  clk: npcm8xx: add clock controller
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
 .../bindings/clock/nuvoton,npcm845-clk.yaml   |  49 ++
 .../bindings/reset/nuvoton,npcm750-reset.yaml |  10 +-
 .../bindings/timer/nuvoton,npcm7xx-timer.yaml |   2 +
 .../bindings/watchdog/nuvoton,npcm-wdt.txt    |   3 +-
 MAINTAINERS                                   |   2 +
 arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi |   1 +
 arch/arm64/Kconfig.platforms                  |  11 +
 arch/arm64/boot/dts/Makefile                  |   1 +
 arch/arm64/boot/dts/nuvoton/Makefile          |   2 +
 .../dts/nuvoton/nuvoton-common-npcm8xx.dtsi   | 170 +++++
 .../boot/dts/nuvoton/nuvoton-npcm845-evb.dts  |  30 +
 .../boot/dts/nuvoton/nuvoton-npcm845.dtsi     |  76 +++
 arch/arm64/configs/defconfig                  |   3 +
 drivers/clk/Kconfig                           |   6 +
 drivers/clk/Makefile                          |   1 +
 drivers/clk/clk-npcm8xx.c                     | 610 ++++++++++++++++++
 drivers/reset/reset-npcm.c                    | 207 +++++-
 .../dt-bindings/clock/nuvoton,npcm845-clk.h   |  49 ++
 20 files changed, 1206 insertions(+), 36 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/nuvoton,npcm845-clk.yaml
 create mode 100644 arch/arm64/boot/dts/nuvoton/Makefile
 create mode 100644 arch/arm64/boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi
 create mode 100644 arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dts
 create mode 100644 arch/arm64/boot/dts/nuvoton/nuvoton-npcm845.dtsi
 create mode 100644 drivers/clk/clk-npcm8xx.c
 create mode 100644 include/dt-bindings/clock/nuvoton,npcm845-clk.h

-- 
2.33.0

