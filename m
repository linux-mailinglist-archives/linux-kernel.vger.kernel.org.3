Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30A184FB443
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 08:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245244AbiDKHAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 03:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245185AbiDKG7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 02:59:42 -0400
Received: from mx1.cqplus1.com (unknown [113.204.237.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0B61A3DDC2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 23:57:12 -0700 (PDT)
X-MailGates: (flag:4,DYNAMIC,BADHELO,RELAY,NOHOST:PASS)(compute_score:DE
        LIVER,40,3)
Received: from 172.28.114.216
        by mx1.cqplus1.com with MailGates ESMTP Server V5.0(1173:0:AUTH_RELAY)
        (envelope-from <qinjian@cqplus1.com>); Mon, 11 Apr 2022 14:49:04 +0800 (CST)
From:   Qin Jian <qinjian@cqplus1.com>
To:     krzysztof.kozlowski@linaro.org
Cc:     robh+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        tglx@linutronix.de, maz@kernel.org, p.zabel@pengutronix.de,
        linux@armlinux.org.uk, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Qin Jian <qinjian@cqplus1.com>
Subject: [PATCH v13 0/9] Add Sunplus SP7021 SoC Support
Date:   Mon, 11 Apr 2022 14:49:50 +0800
Message-Id: <cover.1649659095.git.qinjian@cqplus1.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series add Sunplus SP7021 SoC support.

Sunplus SP7021 is an ARM Cortex A7 (4 cores) based SoC. It integrates many
peripherals (ex: UART, I2C, SPI, SDIO, eMMC, USB, SD card and etc.) into a
single chip. It is designed for industrial control.

SP7021 consists of two chips (dies) in a package. One is called C-chip
(computing chip). It is a 4-core ARM Cortex A7 CPU. It adopts high-level
process (22 nm) for high performance computing. The other is called P-
chip (peripheral chip). It has many peripherals and an ARM A926 added
especially for real-time control. P-chip is made for customers. It adopts
low-level process (ex: 0.11 um) to reduce cost.

Refer to (for documentations):
https://sunplus-tibbo.atlassian.net/wiki/spaces/doc/overview

Refer to (applications):
https://tibbo.com/store/plus1.html

Refer to (applications):
http://www.sinovoip.com.cn/ecp_view.asp?id=586

Changes in v13:
- reset/sp-sp7021.h: Move HW mapping from dt-binding header to driver
- reset-sunplus.c: Move HW mapping from dt-binding header to driver
- clock/sp-sp7021.h: Move HW mapping from dt-binding header to driver
- clk-sp7021.c: Fix the comments from Arnd
- irq-sp7021-intc.c: Remove empty set_affinity callback function
- sp7021_defconfig: Fix the comments from Arnd

Changes in v12:
- sunplus,sp7021-clkc.yaml: Move 'reg' after 'compatible'
- sunplus,sp7021-intc.yaml: Move 'reg' after 'compatible'
- sunplus,reset.yaml: Move 'reg' after 'compatible'
- Remove wrong reviewed-tags

Changes in v11:
- clk-sp7021.c: Remove the dead code

Changes in v10:
- arm/sunplus,sp7021.yaml: Add SoC compatible: "sunplus,sp7021"
- clock/sunplus,sp7021-clkc.yaml: Remove the internal clock parent from DTS
- clk-sp7021.c: Refine the macro DBG_CLK
- clk-sp7021.c: Refine the clock_parent_data

Changes in v9:
- clk/Kconfig: fix the comments form Stephen Boyd
- clk-sp7021.c: fix the comments form Stephen Boyd

Changes in v8:
- clk-sp7021.c: fix the comments form Stephen Boyd

Changes in v7:
- sunplus,sp7021-clkc.yaml: Add clocks & clock-names
- clk-sp7021.c: fix the comments form Stephen Boyd
- irq-sp7021-intc.c: fix the comments from Marc

Changes in v6:
- reset-sunplus.c: fix the comments from Philipp
- irq-sp7021-intc.c: fix the comments from Marc
- mach-sunplus: fix the comments from Arnd

Changes in v5:
- reset-sunplus.c: fix strict checks
- clk/Kconfig: fix spell
- clk-sp7021.c: using bitfield ops, fix strict checks
- irqchip/Kconfig: fix spell
- irq-sp7021-intc.c: cleanup error path in probe, fix strict checks
- arm/Kconfig: fix spell & typo, remove CONFIG_SERIAL_SUNPLUS
- mach-sunplus/Kconfig: fix typo
- sp7021_defconfig: add CONFIG_SERIAL_SUNPLUS

Changes in v4:
- mach-sunplus: add initial support for SP7021
- sp7021_defconfig: add generic SP7021 defconfig
- reset-sunplus: remove Q645 support
- reset-sunplus.c: refine code based on Philipp's review
- clk-sp7021: clock defines add prefix, more clean up

Changes in v3:
- sp7021-intc: remove primary controller mode due to P-chip running Linux
  not supported any more.
- sp7021-intc.h: removed, not set ext through the DT but sp_intc_set_ext()
- sunplus,sp7021-intc.yaml: update descriptions for above changes
- irq-sp7021-intc.c: more cleanup based on Marc's review
- all driver's Kconfig removed default, it's selected by platform config

Changes in v2:
- sunplus,sp7021-intc.yaml: add descrption for "#interrupt-cells", interrupts
- sunplus,sp7021-intc.yaml: drop "ext0-mask"/"ext1-mask" from DT
- sunplus,sp7021-intc.yaml: fix example.dt too long error
- irq-sp7021-intc.c: major rewrite
- all files with dual license

Qin Jian (9):
  dt-bindings: arm: sunplus: Add bindings for Sunplus SP7021 SoC boards
  dt-bindings: reset: Add bindings for SP7021 reset driver
  reset: Add Sunplus SP7021 reset driver
  dt-bindings: clock: Add bindings for SP7021 clock driver
  clk: Add Sunplus SP7021 clock driver
  dt-bindings: interrupt-controller: Add bindings for SP7021 interrupt
    controller
  irqchip: Add Sunplus SP7021 interrupt controller driver
  ARM: sunplus: Add initial support for Sunplus SP7021 SoC
  ARM: sp7021_defconfig: Add Sunplus SP7021 defconfig

 .../bindings/arm/sunplus,sp7021.yaml          |  28 +
 .../bindings/clock/sunplus,sp7021-clkc.yaml   |  39 +
 .../sunplus,sp7021-intc.yaml                  |  62 ++
 .../bindings/reset/sunplus,reset.yaml         |  38 +
 MAINTAINERS                                   |  17 +
 arch/arm/Kconfig                              |   2 +
 arch/arm/Makefile                             |   1 +
 arch/arm/configs/multi_v7_defconfig           |   1 +
 arch/arm/configs/sp7021_defconfig             |  59 ++
 arch/arm/mach-sunplus/Kconfig                 |  27 +
 arch/arm/mach-sunplus/Makefile                |   9 +
 arch/arm/mach-sunplus/sp7021.c                |  16 +
 drivers/clk/Kconfig                           |  10 +
 drivers/clk/Makefile                          |   1 +
 drivers/clk/clk-sp7021.c                      | 721 ++++++++++++++++++
 drivers/irqchip/Kconfig                       |   9 +
 drivers/irqchip/Makefile                      |   2 +
 drivers/irqchip/irq-sp7021-intc.c             | 278 +++++++
 drivers/reset/Kconfig                         |   9 +
 drivers/reset/Makefile                        |   1 +
 drivers/reset/reset-sunplus.c                 | 212 +++++
 include/dt-bindings/clock/sp-sp7021.h         |  90 +++
 include/dt-bindings/reset/sp-sp7021.h         |  87 +++
 23 files changed, 1719 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/sunplus,sp7021.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/sunplus,sp7021-clkc.yaml
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/sunplus,sp7021-intc.yaml
 create mode 100644 Documentation/devicetree/bindings/reset/sunplus,reset.yaml
 create mode 100644 arch/arm/configs/sp7021_defconfig
 create mode 100644 arch/arm/mach-sunplus/Kconfig
 create mode 100644 arch/arm/mach-sunplus/Makefile
 create mode 100644 arch/arm/mach-sunplus/sp7021.c
 create mode 100644 drivers/clk/clk-sp7021.c
 create mode 100644 drivers/irqchip/irq-sp7021-intc.c
 create mode 100644 drivers/reset/reset-sunplus.c
 create mode 100644 include/dt-bindings/clock/sp-sp7021.h
 create mode 100644 include/dt-bindings/reset/sp-sp7021.h

-- 
2.33.1

