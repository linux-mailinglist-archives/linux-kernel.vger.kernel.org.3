Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BCA34672C3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 08:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378972AbhLCHqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 02:46:01 -0500
Received: from [113.204.237.245] ([113.204.237.245]:44180 "EHLO
        test.cqplus1.com" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1378940AbhLCHp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 02:45:56 -0500
X-MailGates: (flag:4,DYNAMIC,BADHELO,RELAY,NOHOST:PASS)(compute_score:DE
        LIVER,40,3)
Received: from 172.28.114.216
        by cqmailgates with MailGates ESMTP Server V5.0(21484:0:AUTH_RELAY)
        (envelope-from <qinjian@cqplus1.com>); Fri, 03 Dec 2021 15:35:50 +0800 (CST)
From:   Qin Jian <qinjian@cqplus1.com>
To:     robh+dt@kernel.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org, tglx@linutronix.de,
        maz@kernel.org, p.zabel@pengutronix.de, linux@armlinux.org.uk,
        broonie@kernel.org, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        wells.lu@sunplus.com, Qin Jian <qinjian@cqplus1.com>
Subject: [PATCH v5 00/10] Add Sunplus SP7021 SoC Support
Date:   Fri,  3 Dec 2021 15:34:17 +0800
Message-Id: <cover.1638515726.git.qinjian@cqplus1.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Qin Jian (10):
  dt-bindings: vendor-prefixes: Add Sunplus
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

 .../bindings/arm/sunplus,sp7021.yaml          |  27 +
 .../bindings/clock/sunplus,sp7021-clkc.yaml   |  38 +
 .../sunplus,sp7021-intc.yaml                  |  62 ++
 .../bindings/reset/sunplus,reset.yaml         |  38 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |  17 +
 arch/arm/Kconfig                              |  18 +
 arch/arm/Makefile                             |   2 +
 arch/arm/configs/sp7021_defconfig             | 178 +++++
 arch/arm/mach-sunplus/Kconfig                 |  20 +
 arch/arm/mach-sunplus/Makefile                |   9 +
 arch/arm/mach-sunplus/Makefile.boot           |   3 +
 arch/arm/mach-sunplus/sp7021.c                |  16 +
 drivers/clk/Kconfig                           |   9 +
 drivers/clk/Makefile                          |   1 +
 drivers/clk/clk-sp7021.c                      | 738 ++++++++++++++++++
 drivers/irqchip/Kconfig                       |   9 +
 drivers/irqchip/Makefile                      |   1 +
 drivers/irqchip/irq-sp7021-intc.c             | 284 +++++++
 drivers/reset/Kconfig                         |   9 +
 drivers/reset/Makefile                        |   1 +
 drivers/reset/reset-sunplus.c                 | 132 ++++
 include/dt-bindings/clock/sp-sp7021.h         | 112 +++
 include/dt-bindings/reset/sp-sp7021.h         |  97 +++
 24 files changed, 1823 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/sunplus,sp7021.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/sunplus,sp7021-clkc.yaml
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/sunplus,sp7021-intc.yaml
 create mode 100644 Documentation/devicetree/bindings/reset/sunplus,reset.yaml
 create mode 100644 arch/arm/configs/sp7021_defconfig
 create mode 100644 arch/arm/mach-sunplus/Kconfig
 create mode 100644 arch/arm/mach-sunplus/Makefile
 create mode 100644 arch/arm/mach-sunplus/Makefile.boot
 create mode 100644 arch/arm/mach-sunplus/sp7021.c
 create mode 100644 drivers/clk/clk-sp7021.c
 create mode 100644 drivers/irqchip/irq-sp7021-intc.c
 create mode 100644 drivers/reset/reset-sunplus.c
 create mode 100644 include/dt-bindings/clock/sp-sp7021.h
 create mode 100644 include/dt-bindings/reset/sp-sp7021.h

-- 
2.33.1

