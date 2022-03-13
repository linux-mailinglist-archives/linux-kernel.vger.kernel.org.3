Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08E9C4D748A
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 11:53:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234369AbiCMKyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 06:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234465AbiCMKxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 06:53:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD33112D212
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 03:52:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 556F560EC5
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 10:51:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C0FDC340E8;
        Sun, 13 Mar 2022 10:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647168718;
        bh=eewEAPuCCiKFpQs1yXVAy8eiRfWQlN62XY/fNZJ8AL4=;
        h=From:To:Cc:Subject:Date:From;
        b=asXlyLNT/Po9i0rQY57GOF7XMgFKVlCOCkHtqDV2AqDfS6cqAYdkAmGkxD8Q+5WDu
         U7wncyqMyrZ5u0uLyYnN9Cj34shxBp2E6/564GDIyjal7eAFE4Ai0uLZ52UcFTHW/8
         LUH2Dq0TwQfqULSofnIORRLP3OizlWcX2eTPoHc3KVgYBv8h++w3tLlr6lcQjAv1XP
         GYZgRlVgiRMhdHTqEVMXFpX1NhDoPRV6G0q/nFDIQFHA686DmQrP6jm6pW8FF25Ywj
         H+u2prPsYyoSZlOjEpFU7nSxolFb2zJbb405e35SedkVcLwfCbs5huQGk5jZvS52E7
         YvWnBNAOgOx6w==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nTLpM-00E8XJ-2b; Sun, 13 Mar 2022 10:51:56 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Anup Patel <anup@brainfault.org>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Hector Martin <marcan@marcan.st>,
        Linus Walleij <linus.walleij@linaro.org>,
        Maulik Shah <quic_mkshah@quicinc.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Qianggui Song <qianggui.song@amlogic.com>,
        Rob Herring <robh@kernel.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Stefan Asserhall <stefan.asserhall@xilinx.com>,
        Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: [GIT PULL] irqchip updates for 5.18
Date:   Sun, 13 Mar 2022 10:51:42 +0000
Message-Id: <20220313105142.704579-1-maz@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: tglx@linutronix.de, alexandre.torgue@foss.st.com, anup@brainfault.org, song.bao.hua@hisilicon.com, brgl@bgdev.pl, dan.carpenter@oracle.com, kernel@esmil.dk, geert+renesas@glider.be, gregory.clement@bootlin.com, marcan@marcan.st, linus.walleij@linaro.org, quic_mkshah@quicinc.com, michal.simek@xilinx.com, niklas.cassel@wdc.com, qianggui.song@amlogic.com, robh@kernel.org, shawn.guo@linaro.org, jrdr.linux@gmail.com, stefan.asserhall@xilinx.com, tony@atomide.com, linux-kernel@vger.kernel.org, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

Here's the set of irqchip updates for 5.18, slightly larger than the
past couple of cycles. The highlights are:

- support for a bunch of new (and not so new) HW (STM32, AICv2, MPM,
  Meson GPIO)
- the first drop of my work trying to make the irq_chip structure const
- a bunch of cleanups (QDC, Xilinx, PLIC...)

Note that the AIC PMU branch is shared with the arm64 tree, as it has
pretty invasive ramifications. There is also a small conflict between
this branch (based on 5.17-rc3) and a fix that went that went in -rc5
(the resolution is trivial).

Please pull,

	M.

The following changes since commit dfd42facf1e4ada021b939b4e19c935dcdd55566:

  Linux 5.17-rc3 (2022-02-06 12:20:50 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git tags/irqchip-5.18

for you to fetch changes up to de26a7424331493311c08625a700cf45d1eaf151:

  Merge branch irq/qcom-mpm into irq/irqchip-next (2022-03-11 19:22:24 +0000)

----------------------------------------------------------------
irqchip updates for 5.18

- Add support for the STM32MP13 variant

- Move parent device away from struct irq_chip

- Remove all instances of non-const strings assigned to
  struct irq_chip::name, enabling a nice cleanup for VIC and GIC)

- Simplify the Qualcomm PDC driver

- A bunch of SiFive PLIC cleanups

- Add support for a new variant of the Meson GPIO block

- Add support for the irqchip side of the Apple M1 PMU

- Add support for the Apple M1 Pro/Max AICv2 irqchip

- Add support for the Qualcomm MPM wakeup gadget

- Move the Xilinx driver over to the generic irqdomain handling

- Tiny speedup for IPIs on GICv3 systems

- The usual odd cleanups

----------------------------------------------------------------
Alexandre Torgue (2):
      dt-bindings: interrupt-controller: stm32-exti: document st,stm32mp13-exti
      irqchip/stm32-exti: Add STM32MP13 support

Barry Song (1):
      irqchip/gic-v3: Use dsb(ishst) to order writes with ICC_SGI1R_EL1 accesses

Hector Martin (7):
      PCI: apple: Change MSI handling to handle 4-cell AIC fwspec form
      dt-bindings: interrupt-controller: apple,aic2: New binding for AICv2
      irqchip/apple-aic: Add Fast IPI support
      irqchip/apple-aic: Switch to irq_domain_create_tree and sparse hwirqs
      irqchip/apple-aic: Dynamically compute register offsets
      irqchip/apple-aic: Support multiple dies
      irqchip/apple-aic: Add support for AICv2

Marc Zyngier (44):
      dt-bindings: arm-pmu: Document Apple PMU compatible strings
      dt-bindings: apple,aic: Add CPU PMU per-cpu pseudo-interrupts
      dt-bindings: apple,aic: Add affinity description for per-cpu pseudo-interrupts
      irqchip/apple-aic: Parse FIQ affinities from device-tree
      irqchip/apple-aic: Wire PMU interrupts
      arm64: dts: apple: Add t8103 PMU interrupt affinities
      arm64: dts: apple: Add t8303 PMU nodes
      irqchip/apple-aic: Move PMU-specific registers to their own include file
      genirq: Allow the PM device to originate from irq domain
      irqchip/gic: Move PM device over to irq domain
      irqchip/renesas-intc-irqpin: Move PM device over to irq domain
      irqchip/renesas-irqc: Move PM device over to irq domain
      irqchip/imx-intmux: Move PM device over to irq domain
      gpio: mt7621: Kill parent_device usage
      gpio: omap: Move PM device over to irq domain
      gpio: rcar: Move PM device over to irq domain
      gpio: tpmx86: Move PM device over to irq domain
      pinctrl: npcm: Fix broken references to chip->parent_device
      pinctrl: starfive: Move PM device over to irq domain
      genirq: Kill irq_chip::parent_device
      Merge branch irq/stm32mp13 into irq/irqchip-next
      Merge branch irq/parent_device into irq/irqchip-next
      irqdomain: Let irq_domain_set_{info,hwirq_and_chip} take a const irq_chip
      genirq: Allow irq_chip registration functions to take a const irq_chip
      genirq/debugfs: Use irq_print_chip() when provided by irqchip
      irqchip/gic: Switch to dynamic chip name output
      irqchip/lpc32xx: Switch to dynamic chip name output
      irqchip/mvebu-pic: Switch to dynamic chip name output
      irqchip/ts4800: Switch to dynamic chip name output
      irqchip/versatile-fpga: Switch to dynamic chip name output
      Merge branch irq/print_chip into irq/irqchip-next
      irqchip/qcom-pdc: Kill PDC_NO_PARENT_IRQ
      irqchip/qcom-pdc: Kill non-wakeup irqdomain
      irqchip/qcom-pdc: Kill qcom_pdc_translate helper
      irqchip/qcom-pdc: Fix broken locking
      irqchip/qcom-pdc: Drop open coded version of __assign_bit()
      Merge branch irq/qcom-pdc-cleanup into irq/irqchip-next
      Merge branch irq/plic-cleanups into irq/irqchip-next
      Merge branch irq/misc-5.18 into irq/irqchip-next
      Merge branch irq/meson-gpio into irq/irqchip-next
      irqchip/apple-aic: Fix cpumask allocation for FIQs
      Merge branch irq/aic-pmu into irq/irqchip-next
      Merge branch irq/aic-v2 into irq/irqchip-next
      Merge branch irq/qcom-mpm into irq/irqchip-next

Michal Simek (1):
      irqchip/xilinx: Switch to GENERIC_IRQ_MULTI_HANDLER

Niklas Cassel (2):
      irqchip/sifive-plic: Improve naming scheme for per context offsets
      irqchip/sifive-plic: Disable S-mode IRQs if running in M-mode

Qianggui Song (4):
      dt-bindings: interrupt-controller: New binding for Meson-S4 SoCs
      irqchip/meson-gpio: support more than 8 channels gpio irq
      irqchip/meson-gpio: add select trigger type callback
      irqchip/meson-gpio: Add support for meson s4 SoCs

Shawn Guo (2):
      dt-bindings: interrupt-controller: Add Qualcomm MPM support
      irqchip: Add Qualcomm MPM controller driver

Souptick Joarder (HPE) (1):
      irqchip/nvic: Release nvic_base upon failure

 Documentation/devicetree/bindings/arm/pmu.yaml     |   2 +
 .../amlogic,meson-gpio-intc.txt                    |   1 +
 .../bindings/interrupt-controller/apple,aic.yaml   |  31 ++
 .../bindings/interrupt-controller/apple,aic2.yaml  |  98 ++++
 .../bindings/interrupt-controller/qcom,mpm.yaml    |  96 ++++
 .../interrupt-controller/st,stm32-exti.yaml        |   1 +
 MAINTAINERS                                        |   2 +-
 arch/arm64/boot/dts/apple/t8103.dtsi               |  24 +
 arch/arm64/include/asm/apple_m1_pmu.h              |  19 +
 arch/microblaze/Kconfig                            |   2 +
 arch/microblaze/include/asm/irq.h                  |   3 -
 arch/microblaze/kernel/irq.c                       |  16 +-
 drivers/gpio/gpio-mt7621.c                         |   1 -
 drivers/gpio/gpio-omap.c                           |   7 +-
 drivers/gpio/gpio-rcar.c                           |   2 +-
 drivers/gpio/gpio-tqmx86.c                         |   3 +-
 drivers/irqchip/Kconfig                            |   8 +
 drivers/irqchip/Makefile                           |   1 +
 drivers/irqchip/irq-apple-aic.c                    | 551 +++++++++++++++++----
 drivers/irqchip/irq-ftintc010.c                    |   1 -
 drivers/irqchip/irq-gic-v3.c                       |   2 +-
 drivers/irqchip/irq-gic.c                          | 104 ++--
 drivers/irqchip/irq-imx-intmux.c                   |   8 +-
 drivers/irqchip/irq-lpc32xx.c                      |  34 +-
 drivers/irqchip/irq-meson-gpio.c                   | 106 +++-
 drivers/irqchip/irq-mvebu-pic.c                    |  28 +-
 drivers/irqchip/irq-nvic.c                         |   2 +
 drivers/irqchip/irq-qcom-mpm.c                     | 461 +++++++++++++++++
 drivers/irqchip/irq-renesas-intc-irqpin.c          |   3 +-
 drivers/irqchip/irq-renesas-irqc.c                 |   3 +-
 drivers/irqchip/irq-sifive-plic.c                  |  38 +-
 drivers/irqchip/irq-stm32-exti.c                   |  50 ++
 drivers/irqchip/irq-ts4800.c                       |  25 +-
 drivers/irqchip/irq-versatile-fpga.c               |  46 +-
 drivers/irqchip/irq-xilinx-intc.c                  |  30 +-
 drivers/irqchip/qcom-pdc.c                         | 137 ++---
 drivers/pci/controller/pcie-apple.c                |   2 +-
 drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c          |  25 +-
 drivers/pinctrl/pinctrl-starfive.c                 |   3 +-
 .../dt-bindings/interrupt-controller/apple-aic.h   |   2 +
 include/linux/irq.h                                |   9 +-
 include/linux/irqchip/versatile-fpga.h             |  14 -
 include/linux/irqdomain.h                          |  15 +-
 kernel/irq/chip.c                                  |  29 +-
 kernel/irq/debugfs.c                               |   8 +-
 kernel/irq/irqdomain.c                             |   9 +-
 46 files changed, 1618 insertions(+), 444 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/apple,aic2.yaml
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/qcom,mpm.yaml
 create mode 100644 arch/arm64/include/asm/apple_m1_pmu.h
 create mode 100644 drivers/irqchip/irq-qcom-mpm.c
 delete mode 100644 include/linux/irqchip/versatile-fpga.h
