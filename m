Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B56058337B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 21:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233239AbiG0TYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 15:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbiG0TYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 15:24:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D39E98D
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 12:24:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5CB5BB8224A
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 19:24:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9756CC433C1;
        Wed, 27 Jul 2022 19:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658949857;
        bh=E7rloOwSbS02utoDEWkdS4y6aLgX2QGaT8w49rPJtvo=;
        h=From:To:Cc:Subject:Date:From;
        b=PYSP/bvdLKoLkpiigfpWYHVfFFi/uolR+kYu/KMNU7E6QtySjgATiHdYP1NBAAMPN
         cZIVG6dWDetjLiXR49ZOxrhTJMs00Mak/wnlokygqoUhmcrFcZ3601CFF5Gza1mhCW
         Zm5C2hYfbq3RuPxunMt11W8IMmCGwDYazzYNsr/S5D0vk4sEFfpZ0IstgzS2gwJlZe
         eLuGicS5fcPNjhAyiTIYYx64AcykVvCj04g6hzfAz0pntQc8IPSNI/+gPCQTwaONCQ
         DqYop+fH8AmJXOhramAJ7KRf7oikXZ3lA/ob3TX9omov8aXAZEeJ56CFOXy1AdXmL0
         wi3TdpAWoEj6g==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1oGmdh-00AVIK-Vr;
        Wed, 27 Jul 2022 20:24:14 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andy Gross <agross@kernel.org>,
        Antonio Borneo <antonio.borneo@foss.st.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Ben Dooks <ben-linux@fluff.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Daniel Palmer <daniel@thingy.jp>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Guo Ren <guoren@kernel.org>,
        Hacash Robot <hacashRobot@santino.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Jason Wang <wangborong@cdjrlc.com>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Loic Pallardy <loic.pallardy@foss.st.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ludovic Barre <ludovic.barre@foss.st.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Michael Walle <michael@walle.cc>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Paran Lee <p4ranlee@gmail.com>,
        Robert Richter <rric@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Romain Perier <romain.perier@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Thierry Reding <thierry.reding@gmail.com>,
        William Dean <williamsukatube@163.com>,
        Xu Qiang <xuqiang36@huawei.com>, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: [GIT PULL] irqchip/genirq updates for 5.20
Date:   Wed, 27 Jul 2022 20:23:56 +0100
Message-Id: <20220727192356.1860546-1-maz@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: tglx@linutronix.de, alexandre.torgue@foss.st.com, agross@kernel.org, antonio.borneo@foss.st.com, brgl@bgdev.pl, ben-linux@fluff.org, bjorn.andersson@linaro.org, daniel@thingy.jp, geert+renesas@glider.be, guoren@kernel.org, hacashRobot@santino.com, guohanjun@huawei.com, chenhuacai@loongson.cn, wangborong@cdjrlc.com, lvjianmin@loongson.cn, jonathanh@nvidia.com, prabhakar.mahadev-lad.rj@bp.renesas.com, linus.walleij@linaro.org, loic.pallardy@foss.st.com, lorenzo.pieralisi@arm.com, ludovic.barre@foss.st.com, mikelley@microsoft.com, michael@walle.cc, nobuhiro1.iwamatsu@toshiba.co.jp, oleksandr_tyshchenko@epam.com, p4ranlee@gmail.com, rric@kernel.org, robh@kernel.org, romain.perier@gmail.com, samuel@sholland.org, sfr@canb.auug.org.au, thierry.reding@gmail.com, williamsukatube@163.com, xuqiang36@huawei.com, linux-kernel@vger.kernel.org, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

5.19 had been pretty quiet on the IRQ front. Well, 5.20 is going
unfortunately back to normal with a bang.

The largest item here is the long awaited LoongArch IRQ support, which
comes with a flurry of irqchip updates and ACPI support (fools!).

The rest divides pretty equally between core code update (making the
affinity functions work for UP kernel is the biggest item), new
drivers (LoongArch, Renesas), and some updates (PLIC, stm32, PLIC
again) and the usual churn, just because people like that.

Please pull,

	M.

The following changes since commit a111daf0c53ae91e71fd2bfe7497862d14132e3e:

  Linux 5.19-rc3 (2022-06-19 15:06:47 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git tags/irqchip-5.20

for you to fetch changes up to 2bd1753e8c431fc7475c04ac8d14a4e9930f47f6:

  Merge branch irq/misc-5.20 into irq/irqchip-next (2022-07-25 09:45:34 +0100)

----------------------------------------------------------------
irqchip/genirq updates for 5.20:

* Core code update:

  - Non-SMP IRQ affinity fixes, allowing UP kernel to behave similarly
    to SMP ones for the purpose of interrupt affinity

  - Let irq_set_chip_handler_name_locked() take a const struct irq_chip *

  - Tidy-up the NOMAP irqdomain API variant

  - Teach action_show() to use for_each_action_of_desc()

  - Make irq_chip_request_resources_parent() allow the parent callback
    to be optional

  - Remove dynamic allocations from populate_parent_alloc_arg()

* New drivers:

  - Merge the long awaited IRQ support for the LoongArch architecture,
    with the provisional ACPICA update (to be reverted once the official
    support lands)

  - New Renesas RZ/G2L IRQC driver, equipped with its companion GPIO
    driver

* Driver updates

  - Optimise the hot path operations for the SiFive PLIC, trading the
    locking for per-CPU priority masking masking operations which are
    apparently faster

  - Work around broken PLIC implementations that deal pretty badly with
    edge-triggered interrupts. Flag two implementations as affected.

  - Simplify the irq-stm32-exti driver, particularly the table that
    remaps the interrupts from exti to the GIC, reducing the memory usage

  - Convert the ocelot irq_chip to being immutable

  - Check ioremap() return value in the MIPS GIC driver

  - Move MMP driver init function declarations into the common .h

  - The obligatory typo fixes

----------------------------------------------------------------
Alexandre Torgue (1):
      irqchip/stm32-exti: Tag emr register as undefined for stm32mp15

Antonio Borneo (4):
      genirq: Don't return error on missing optional irq_request_resources()
      irqchip/stm32-exti: Prevent illegal read due to unbounded DT value
      irqchip/stm32-exti: Read event trigger type from event_trg register
      irqchip/stm32-exti: Simplify irq description table

Ben Dooks (1):
      irqchip/mmp: Declare init functions in common header file

Huacai Chen (6):
      irqchip: Add Loongson PCH LPC controller support
      irqchip/loongson-pch-pic: Add ACPI init support
      irqchip/loongson-pch-msi: Add ACPI init support
      irqchip/loongson-liointc: Add ACPI init support
      irqchip: Add Loongson Extended I/O interrupt controller support
      irqchip: Add LoongArch CPU interrupt controller support

Jason Wang (1):
      irqchip/gic-v3: Fix comment typo

Jianmin Lv (4):
      genirq/generic_chip: Export irq_unmap_generic_chip
      LoongArch: Use ACPI_GENERIC_GSI for gsi handling
      LoongArch: Prepare to support multiple pch-pic and pch-msi irqdomain
      irqchip / ACPI: Introduce ACPI_IRQ_MODEL_LPIC for LoongArch

Lad Prabhakar (8):
      dt-bindings: interrupt-controller: sifive,plic: Document Renesas RZ/Five SoC
      irqchip/sifive-plic: Add support for Renesas RZ/Five SoC
      dt-bindings: interrupt-controller: Add Renesas RZ/G2L Interrupt Controller
      irqchip: Add RZ/G2L IA55 Interrupt Controller driver
      gpio: gpiolib: Allow free() callback to be overridden
      dt-bindings: pinctrl: renesas,rzg2l-pinctrl: Document the properties to handle GPIO IRQ
      pinctrl: renesas: pinctrl-rzg2l: Add IRQ domain to handle GPIO interrupt
      dt-bindings: interrupt-controller: renesas,rzg2l-irqc: Document RZ/V2L SoC

Loic Pallardy (1):
      irqchip/stm32-exti: Fix irq_mask/irq_unmask for direct events

Ludovic Barre (1):
      irqchip/stm32-exti: Fix irq_set_affinity return value

Marc Zyngier (12):
      Merge branch irq/plic-edge-fixes into irq/irqchip-next
      gpio: Remove dynamic allocation from populate_parent_alloc_arg()
      Merge branch irq/stm32-exti-updates into irq/irqchip-next
      Merge branch irq/affinity-nosmp into irq/plic-masking
      Merge branch irq/plic-masking into irq/irqchip-next
      gpio: thunderx: Don't directly include asm-generic/msi.h
      Merge branch irq/renesas-irqc into irq/irqchip-next
      LoongArch: Provisionally add ACPICA data structures
      APCI: irq: Add support for multiple GSI domains
      ACPI: irq: Allow acpi_gsi_to_irq() to have an arch-specific fallback
      Merge branch irq/loongarch into irq/irqchip-next
      Merge branch irq/misc-5.20 into irq/irqchip-next

Michael Walle (2):
      genirq: Allow irq_set_chip_handler_name_locked() to take a const irq_chip
      pinctrl: ocelot: Make irq_chip immutable

Paran Lee (1):
      genirq: Use for_each_action_of_desc in actions_show()

Samuel Holland (13):
      dt-bindings: interrupt-controller: Require trigger type for T-HEAD PLIC
      irqchip/sifive-plic: Fix T-HEAD PLIC edge trigger handling
      irqchip/mips-gic: Only register IPI domain when SMP is enabled
      genirq: GENERIC_IRQ_IPI depends on SMP
      genirq: GENERIC_IRQ_EFFECTIVE_AFF_MASK depends on SMP
      genirq: Drop redundant irq_init_effective_affinity
      genirq: Refactor accessors to use irq_data_get_affinity_mask
      genirq: Add and use an irq_data_update_affinity helper
      genirq: Return a const cpumask from irq_data_get_affinity_mask
      genirq: Provide an IRQ affinity mask in non-SMP configs
      PCI: hv: Take a const cpumask in hv_compose_msi_req_get_cpu()
      irqchip/sifive-plic: Make better use of the effective affinity mask
      irqchip/sifive-plic: Separate the enable and mask operations

William Dean (1):
      irqchip/mips-gic: Check the return value of ioremap() in gic_of_init()

Xu Qiang (2):
      irqdomain: Report irq number for NOMAP domains
      irqdomain: Use hwirq_max instead of revmap_size for NOMAP domains

 .../interrupt-controller/renesas,rzg2l-irqc.yaml   | 134 +++++++
 .../interrupt-controller/sifive,plic-1.0.0.yaml    |  65 +++-
 .../bindings/pinctrl/renesas,rzg2l-pinctrl.yaml    |  15 +
 arch/alpha/kernel/irq.c                            |   2 +-
 arch/arm/mach-hisi/Kconfig                         |   2 +-
 arch/arm/mach-mmp/mmp2.h                           |   2 +-
 arch/arm/mach-mmp/pxa168.h                         |   2 +-
 arch/arm/mach-mmp/pxa910.h                         |   2 +-
 arch/ia64/kernel/iosapic.c                         |   2 +-
 arch/ia64/kernel/irq.c                             |   4 +-
 arch/ia64/kernel/msi_ia64.c                        |   4 +-
 arch/loongarch/Kconfig                             |   1 +
 arch/loongarch/include/asm/acpi.h                  | 142 ++++++++
 arch/loongarch/include/asm/irq.h                   |  51 +--
 arch/loongarch/kernel/acpi.c                       |  65 ----
 arch/loongarch/kernel/irq.c                        |  58 ++-
 arch/loongarch/kernel/time.c                       |  14 +-
 arch/mips/cavium-octeon/octeon-irq.c               |   4 +-
 arch/mips/include/asm/mach-loongson64/irq.h        |   3 +-
 arch/parisc/kernel/irq.c                           |   2 +-
 arch/sh/kernel/irq.c                               |   7 +-
 arch/x86/hyperv/irqdomain.c                        |   2 +-
 arch/xtensa/kernel/irq.c                           |   7 +-
 drivers/acpi/bus.c                                 |   3 +
 drivers/acpi/irq.c                                 |  58 ++-
 drivers/gpio/gpio-msc313.c                         |  15 +-
 drivers/gpio/gpio-tegra.c                          |  15 +-
 drivers/gpio/gpio-tegra186.c                       |  15 +-
 drivers/gpio/gpio-thunderx.c                       |  17 +-
 drivers/gpio/gpio-visconti.c                       |  15 +-
 drivers/gpio/gpiolib.c                             |  51 ++-
 drivers/iommu/hyperv-iommu.c                       |   2 +-
 drivers/irqchip/Kconfig                            |  60 +++-
 drivers/irqchip/Makefile                           |   4 +
 drivers/irqchip/irq-bcm6345-l1.c                   |   4 +-
 drivers/irqchip/irq-gic-v3.c                       |  20 +-
 drivers/irqchip/irq-gic.c                          |  18 +-
 drivers/irqchip/irq-loongarch-cpu.c                | 148 ++++++++
 drivers/irqchip/irq-loongson-eiointc.c             | 395 +++++++++++++++++++++
 drivers/irqchip/irq-loongson-liointc.c             | 203 +++++++----
 drivers/irqchip/irq-loongson-pch-lpc.c             | 205 +++++++++++
 drivers/irqchip/irq-loongson-pch-msi.c             | 127 ++++---
 drivers/irqchip/irq-loongson-pch-pic.c             | 177 +++++++--
 drivers/irqchip/irq-mips-gic.c                     |  84 +++--
 drivers/irqchip/irq-renesas-rzg2l.c                | 393 ++++++++++++++++++++
 drivers/irqchip/irq-sifive-plic.c                  | 142 ++++++--
 drivers/irqchip/irq-stm32-exti.c                   | 250 +++++++------
 drivers/parisc/iosapic.c                           |   2 +-
 drivers/pci/controller/pci-hyperv.c                |  12 +-
 drivers/pinctrl/pinctrl-ocelot.c                   |  10 +-
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c           |  15 +-
 drivers/pinctrl/renesas/pinctrl-rzg2l.c            | 233 ++++++++++++
 drivers/sh/intc/chip.c                             |   2 +-
 drivers/xen/events/events_base.c                   |   7 +-
 include/linux/acpi.h                               |   4 +-
 include/linux/cpuhotplug.h                         |   1 +
 include/linux/gpio/driver.h                        |  42 +--
 include/linux/irq.h                                |  35 +-
 include/linux/irqchip/mmp.h                        |   3 +
 include/linux/irqdesc.h                            |   5 +-
 kernel/irq/Kconfig                                 |   2 +
 kernel/irq/chip.c                                  |  11 +-
 kernel/irq/debugfs.c                               |   2 +-
 kernel/irq/generic-chip.c                          |   2 +-
 kernel/irq/ipi.c                                   |  16 +-
 kernel/irq/irqdesc.c                               |   2 +-
 kernel/irq/irqdomain.c                             |  14 +-
 kernel/irq/manage.c                                |  10 +-
 68 files changed, 2780 insertions(+), 661 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
 create mode 100644 drivers/irqchip/irq-loongarch-cpu.c
 create mode 100644 drivers/irqchip/irq-loongson-eiointc.c
 create mode 100644 drivers/irqchip/irq-loongson-pch-lpc.c
 create mode 100644 drivers/irqchip/irq-renesas-rzg2l.c
