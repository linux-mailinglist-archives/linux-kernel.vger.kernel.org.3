Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1874586D39
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 16:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233023AbiHAOsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 10:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231953AbiHAOsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 10:48:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8875A3C14B
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 07:48:05 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659365283;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=s1arFACTzg54mgXd6bZUkPdmQPTM7u7EX6RxeCwhYQw=;
        b=l8vEI6XEtnxhM6J4ox6o7z9Fka3rVhdq4csrL1GPByDSjVnHeAJ/mUQBJpIiuSln8LA0xp
        3vL/1f4AXMtOxawPzFKuPUrkQTJqGfNVYFjdkyN3SBjlBg2zjcfkk7od97nm7sW3Q8lSlA
        LG6Bq5hKNxeawcIpU5IPwDJ60H6mELsa1ttNmK80mn24+5B9nee2bh096uju2ool8tUrSZ
        xfKdK6EGfLPQLimfOmp7uQhpDaYelLqKkkJxORJ3tLjQO3x8lPnbUUxV4sdTtisF7jT1Mg
        WFQeAPypINcKhQpoAVCYOppF5bEZPyAXdrhholVwtd6tGNK9Z04zVgaBeP24WQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659365283;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=s1arFACTzg54mgXd6bZUkPdmQPTM7u7EX6RxeCwhYQw=;
        b=ZzDBk0Ik0Bjep3Wxvgo1VrPh8tXqtK3IW2rNi2FY7cM8vOxBSRIXJ1kWpSNYw6xa1ycO2J
        y44SwCR7mK5RbxBA==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] irq/core for v6.0-rc1
Message-ID: <165936521992.1709539.10227752058452220355.tglx@xen13.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Mon,  1 Aug 2022 16:48:03 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest irq/core branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-2022-08=
-01

up to:  779fda86bdeb: Merge tag 'irqchip-5.20' of git://git.kernel.org/pub/sc=
m/linux/kernel/git/maz/arm-platforms into irq/core

Updates for interrupt core and drivers:

 core:
   - Fix a few inconsistencies between UP and SMP vs. interrupt affinities
   - Small updates and cleanups all over the place

 drivers:
   - New driver for the LoongArch interrupt controller
   - New driver for the Renesas RZ/G2L interrupt controller

   - Hotpath optimization for SiFive PLIC
   - Workaround for broken PLIC edge triggered interrupts

   - Small cleanups and improvements as usual

Thanks,

	tglx

------------------>
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
      dt-bindings: interrupt-controller: sifive,plic: Document Renesas RZ/Fiv=
e SoC
      irqchip/sifive-plic: Add support for Renesas RZ/Five SoC
      dt-bindings: interrupt-controller: Add Renesas RZ/G2L Interrupt Control=
ler
      irqchip: Add RZ/G2L IA55 Interrupt Controller driver
      gpio: gpiolib: Allow free() callback to be overridden
      dt-bindings: pinctrl: renesas,rzg2l-pinctrl: Document the properties to=
 handle GPIO IRQ
      pinctrl: renesas: pinctrl-rzg2l: Add IRQ domain to handle GPIO interrupt
      dt-bindings: interrupt-controller: renesas,rzg2l-irqc: Document RZ/V2L =
SoC

Loic Pallardy (1):
      irqchip/stm32-exti: Fix irq_mask/irq_unmask for direct events

Ludovic Barre (1):
      irqchip/stm32-exti: Fix irq_set_affinity return value

Lukas Wunner (1):
      genirq/PM: Unexport {suspend,resume}_device_irqs()

Marc Zyngier (5):
      gpio: Remove dynamic allocation from populate_parent_alloc_arg()
      gpio: thunderx: Don't directly include asm-generic/msi.h
      LoongArch: Provisionally add ACPICA data structures
      APCI: irq: Add support for multiple GSI domains
      ACPI: irq: Allow acpi_gsi_to_irq() to have an arch-specific fallback

Michael Walle (2):
      genirq: Allow irq_set_chip_handler_name_locked() to take a const irq_ch=
ip
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
 drivers/irqchip/irq-loongson-eiointc.c             | 395 +++++++++++++++++++=
++
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
 kernel/irq/pm.c                                    |   2 -
 69 files changed, 2780 insertions(+), 663 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/re=
nesas,rzg2l-irqc.yaml
 create mode 100644 drivers/irqchip/irq-loongarch-cpu.c
 create mode 100644 drivers/irqchip/irq-loongson-eiointc.c
 create mode 100644 drivers/irqchip/irq-loongson-pch-lpc.c
 create mode 100644 drivers/irqchip/irq-renesas-rzg2l.c

diff --git a/Documentation/devicetree/bindings/interrupt-controller/renesas,r=
zg2l-irqc.yaml b/Documentation/devicetree/bindings/interrupt-controller/renes=
as,rzg2l-irqc.yaml
new file mode 100644
index 000000000000..33b90e975e33
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-ir=
qc.yaml
@@ -0,0 +1,134 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/renesas,rzg2l-irqc.y=
aml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas RZ/G2L (and alike SoC's) Interrupt Controller (IA55)
+
+maintainers:
+  - Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
+  - Geert Uytterhoeven <geert+renesas@glider.be>
+
+description: |
+  IA55 performs various interrupt controls including synchronization for the=
 external
+  interrupts of NMI, IRQ, and GPIOINT and the interrupts of the built-in per=
ipheral
+  interrupts output by each IP. And it notifies the interrupt to the GIC
+    - IRQ sense select for 8 external interrupts, mapped to 8 GIC SPI interr=
upts
+    - GPIO pins used as external interrupt input pins, mapped to 32 GIC SPI =
interrupts
+    - NMI edge select (NMI is not treated as NMI exception and supports fall=
 edge and
+      stand-up edge detection interrupts)
+
+allOf:
+  - $ref: /schemas/interrupt-controller.yaml#
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - renesas,r9a07g044-irqc    # RZ/G2{L,LC}
+          - renesas,r9a07g054-irqc    # RZ/V2L
+      - const: renesas,rzg2l-irqc
+
+  '#interrupt-cells':
+    description: The first cell should contain external interrupt number (IR=
Q0-7) and the
+                 second cell is used to specify the flag.
+    const: 2
+
+  '#address-cells':
+    const: 0
+
+  interrupt-controller: true
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 41
+
+  clocks:
+    maxItems: 2
+
+  clock-names:
+    items:
+      - const: clk
+      - const: pclk
+
+  power-domains:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+required:
+  - compatible
+  - '#interrupt-cells'
+  - '#address-cells'
+  - interrupt-controller
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - power-domains
+  - resets
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/r9a07g044-cpg.h>
+
+    irqc: interrupt-controller@110a0000 {
+            compatible =3D "renesas,r9a07g044-irqc", "renesas,rzg2l-irqc";
+            reg =3D <0x110a0000 0x10000>;
+            #interrupt-cells =3D <2>;
+            #address-cells =3D <0>;
+            interrupt-controller;
+            interrupts =3D <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 444 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 445 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 446 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 447 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 448 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 449 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 450 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 451 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 452 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 453 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 454 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 455 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 456 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 457 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 458 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 459 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 460 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 461 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 462 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 463 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 464 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 465 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 466 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 467 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 468 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 469 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 470 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 471 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 472 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 473 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 474 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 475 IRQ_TYPE_LEVEL_HIGH>;
+            clocks =3D <&cpg CPG_MOD R9A07G044_IA55_CLK>,
+                     <&cpg CPG_MOD R9A07G044_IA55_PCLK>;
+            clock-names =3D "clk", "pclk";
+            power-domains =3D <&cpg>;
+            resets =3D <&cpg R9A07G044_IA55_RESETN>;
+    };
diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,pl=
ic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/sifive=
,plic-1.0.0.yaml
index 27092c6a86c4..92e0f8c3eff2 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.=
0.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.=
0.yaml
@@ -26,9 +26,14 @@ description:
   with priority below this threshold will not cause the PLIC to raise its
   interrupt line leading to the context.
=20
-  While the PLIC supports both edge-triggered and level-triggered interrupts,
-  interrupt handlers are oblivious to this distinction and therefore it is n=
ot
-  specified in the PLIC device-tree binding.
+  The PLIC supports both edge-triggered and level-triggered interrupts. For
+  edge-triggered interrupts, the RISC-V PLIC spec allows two responses to ed=
ges
+  seen while an interrupt handler is active; the PLIC may either queue them =
or
+  ignore them. In the first case, handlers are oblivious to the trigger type=
, so
+  it is not included in the interrupt specifier. In the second case, software
+  needs to know the trigger type, so it can reorder the interrupt flow to av=
oid
+  missing interrupts. This special handling is needed by at least the Renesas
+  RZ/Five SoC (AX45MP AndesCore with a NCEPLIC100) and the T-HEAD C900 PLIC.
=20
   While the RISC-V ISA doesn't specify a memory layout for the PLIC, the
   "sifive,plic-1.0.0" device is a concrete implementation of the PLIC that
@@ -47,6 +52,10 @@ maintainers:
 properties:
   compatible:
     oneOf:
+      - items:
+          - enum:
+              - renesas,r9a07g043-plic
+          - const: andestech,nceplic100
       - items:
           - enum:
               - sifive,fu540-c000-plic
@@ -64,8 +73,7 @@ properties:
   '#address-cells':
     const: 0
=20
-  '#interrupt-cells':
-    const: 1
+  '#interrupt-cells': true
=20
   interrupt-controller: true
=20
@@ -82,6 +90,12 @@ properties:
     description:
       Specifies how many external interrupts are supported by this controlle=
r.
=20
+  clocks: true
+
+  power-domains: true
+
+  resets: true
+
 required:
   - compatible
   - '#address-cells'
@@ -91,6 +105,47 @@ required:
   - interrupts-extended
   - riscv,ndev
=20
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - andestech,nceplic100
+              - thead,c900-plic
+
+    then:
+      properties:
+        '#interrupt-cells':
+          const: 2
+
+    else:
+      properties:
+        '#interrupt-cells':
+          const: 1
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,r9a07g043-plic
+
+    then:
+      properties:
+        clocks:
+          maxItems: 1
+
+        power-domains:
+          maxItems: 1
+
+        resets:
+          maxItems: 1
+
+      required:
+        - clocks
+        - power-domains
+        - resets
+
 additionalProperties: false
=20
 examples:
diff --git a/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.=
yaml b/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
index 52df1b146174..997b74639112 100644
--- a/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
@@ -47,6 +47,17 @@ properties:
   gpio-ranges:
     maxItems: 1
=20
+  interrupt-controller: true
+
+  '#interrupt-cells':
+    const: 2
+    description:
+      The first cell contains the global GPIO port index, constructed using =
the
+      RZG2L_GPIO() helper macro in <dt-bindings/pinctrl/rzg2l-pinctrl.h> and=
 the
+      second cell is used to specify the flag.
+      E.g. "interrupts =3D <RZG2L_GPIO(43, 0) IRQ_TYPE_EDGE_FALLING>;" if P4=
3_0 is
+      being used as an interrupt.
+
   clocks:
     maxItems: 1
=20
@@ -110,6 +121,8 @@ required:
   - gpio-controller
   - '#gpio-cells'
   - gpio-ranges
+  - interrupt-controller
+  - '#interrupt-cells'
   - clocks
   - power-domains
   - resets
@@ -126,6 +139,8 @@ examples:
             gpio-controller;
             #gpio-cells =3D <2>;
             gpio-ranges =3D <&pinctrl 0 0 392>;
+            interrupt-controller;
+            #interrupt-cells =3D <2>;
             clocks =3D <&cpg CPG_MOD R9A07G044_GPIO_HCLK>;
             resets =3D <&cpg R9A07G044_GPIO_RSTN>,
                      <&cpg R9A07G044_GPIO_PORT_RESETN>,
diff --git a/arch/alpha/kernel/irq.c b/arch/alpha/kernel/irq.c
index f6d2946edbd2..15f2effd6baf 100644
--- a/arch/alpha/kernel/irq.c
+++ b/arch/alpha/kernel/irq.c
@@ -60,7 +60,7 @@ int irq_select_affinity(unsigned int irq)
 		cpu =3D (cpu < (NR_CPUS-1) ? cpu + 1 : 0);
 	last_cpu =3D cpu;
=20
-	cpumask_copy(irq_data_get_affinity_mask(data), cpumask_of(cpu));
+	irq_data_update_affinity(data, cpumask_of(cpu));
 	chip->irq_set_affinity(data, cpumask_of(cpu), false);
 	return 0;
 }
diff --git a/arch/arm/mach-hisi/Kconfig b/arch/arm/mach-hisi/Kconfig
index 75cccbd3f05f..7b3440687176 100644
--- a/arch/arm/mach-hisi/Kconfig
+++ b/arch/arm/mach-hisi/Kconfig
@@ -40,7 +40,7 @@ config ARCH_HIP04
 	select HAVE_ARM_ARCH_TIMER
 	select MCPM if SMP
 	select MCPM_QUAD_CLUSTER if SMP
-	select GENERIC_IRQ_EFFECTIVE_AFF_MASK
+	select GENERIC_IRQ_EFFECTIVE_AFF_MASK if SMP
 	help
 	  Support for Hisilicon HiP04 SoC family
=20
diff --git a/arch/arm/mach-mmp/mmp2.h b/arch/arm/mach-mmp/mmp2.h
index 3ebc1bb13f71..7f80b90248fb 100644
--- a/arch/arm/mach-mmp/mmp2.h
+++ b/arch/arm/mach-mmp/mmp2.h
@@ -5,13 +5,13 @@
 #include <linux/platform_data/pxa_sdhci.h>
=20
 extern void mmp2_timer_init(void);
-extern void __init mmp2_init_icu(void);
 extern void __init mmp2_init_irq(void);
 extern void mmp2_clear_pmic_int(void);
=20
 #include <linux/i2c.h>
 #include <linux/platform_data/i2c-pxa.h>
 #include <linux/platform_data/dma-mmp_tdma.h>
+#include <linux/irqchip/mmp.h>
=20
 #include "devices.h"
=20
diff --git a/arch/arm/mach-mmp/pxa168.h b/arch/arm/mach-mmp/pxa168.h
index 34f907cd165a..c1547e098f09 100644
--- a/arch/arm/mach-mmp/pxa168.h
+++ b/arch/arm/mach-mmp/pxa168.h
@@ -5,7 +5,6 @@
 #include <linux/reboot.h>
=20
 extern void pxa168_timer_init(void);
-extern void __init icu_init_irq(void);
 extern void __init pxa168_init_irq(void);
 extern void pxa168_restart(enum reboot_mode, const char *);
 extern void pxa168_clear_keypad_wakeup(void);
@@ -18,6 +17,7 @@ extern void pxa168_clear_keypad_wakeup(void);
 #include <linux/pxa168_eth.h>
 #include <linux/platform_data/mv_usb.h>
 #include <linux/soc/mmp/cputype.h>
+#include <linux/irqchip/mmp.h>
=20
 #include "devices.h"
=20
diff --git a/arch/arm/mach-mmp/pxa910.h b/arch/arm/mach-mmp/pxa910.h
index 6ace5a8aa15b..7d229214065a 100644
--- a/arch/arm/mach-mmp/pxa910.h
+++ b/arch/arm/mach-mmp/pxa910.h
@@ -3,13 +3,13 @@
 #define __ASM_MACH_PXA910_H
=20
 extern void pxa910_timer_init(void);
-extern void __init icu_init_irq(void);
 extern void __init pxa910_init_irq(void);
=20
 #include <linux/i2c.h>
 #include <linux/platform_data/i2c-pxa.h>
 #include <linux/platform_data/mtd-nand-pxa3xx.h>
 #include <video/mmp_disp.h>
+#include <linux/irqchip/mmp.h>
=20
 #include "devices.h"
=20
diff --git a/arch/ia64/kernel/iosapic.c b/arch/ia64/kernel/iosapic.c
index 35adcf89035a..99300850abc1 100644
--- a/arch/ia64/kernel/iosapic.c
+++ b/arch/ia64/kernel/iosapic.c
@@ -834,7 +834,7 @@ iosapic_unregister_intr (unsigned int gsi)
 	if (iosapic_intr_info[irq].count =3D=3D 0) {
 #ifdef CONFIG_SMP
 		/* Clear affinity */
-		cpumask_setall(irq_get_affinity_mask(irq));
+		irq_data_update_affinity(irq_get_irq_data(irq), cpu_all_mask);
 #endif
 		/* Clear the interrupt information */
 		iosapic_intr_info[irq].dest =3D 0;
diff --git a/arch/ia64/kernel/irq.c b/arch/ia64/kernel/irq.c
index ecef17c7c35b..275b9ea58c64 100644
--- a/arch/ia64/kernel/irq.c
+++ b/arch/ia64/kernel/irq.c
@@ -57,8 +57,8 @@ static char irq_redir [NR_IRQS]; // =3D { [0 ... NR_IRQS-1]=
 =3D 1 };
 void set_irq_affinity_info (unsigned int irq, int hwid, int redir)
 {
 	if (irq < NR_IRQS) {
-		cpumask_copy(irq_get_affinity_mask(irq),
-			     cpumask_of(cpu_logical_id(hwid)));
+		irq_data_update_affinity(irq_get_irq_data(irq),
+					 cpumask_of(cpu_logical_id(hwid)));
 		irq_redir[irq] =3D (char) (redir & 0xff);
 	}
 }
diff --git a/arch/ia64/kernel/msi_ia64.c b/arch/ia64/kernel/msi_ia64.c
index df5c28f252e3..025e5133c860 100644
--- a/arch/ia64/kernel/msi_ia64.c
+++ b/arch/ia64/kernel/msi_ia64.c
@@ -37,7 +37,7 @@ static int ia64_set_msi_irq_affinity(struct irq_data *idata,
 	msg.data =3D data;
=20
 	pci_write_msi_msg(irq, &msg);
-	cpumask_copy(irq_data_get_affinity_mask(idata), cpumask_of(cpu));
+	irq_data_update_affinity(idata, cpumask_of(cpu));
=20
 	return 0;
 }
@@ -132,7 +132,7 @@ static int dmar_msi_set_affinity(struct irq_data *data,
 	msg.address_lo |=3D MSI_ADDR_DEST_ID_CPU(cpu_physical_id(cpu));
=20
 	dmar_msi_write(irq, &msg);
-	cpumask_copy(irq_data_get_affinity_mask(data), mask);
+	irq_data_update_affinity(data, mask);
=20
 	return 0;
 }
diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 1920d52653b4..fb1e73adbd1d 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -2,6 +2,7 @@
 config LOONGARCH
 	bool
 	default y
+	select ACPI_GENERIC_GSI if ACPI
 	select ACPI_SYSTEM_POWER_STATES_SUPPORT	if ACPI
 	select ARCH_BINFMT_ELF_STATE
 	select ARCH_ENABLE_MEMORY_HOTPLUG
diff --git a/arch/loongarch/include/asm/acpi.h b/arch/loongarch/include/asm/a=
cpi.h
index 62044cd5b7bc..c5108213876c 100644
--- a/arch/loongarch/include/asm/acpi.h
+++ b/arch/loongarch/include/asm/acpi.h
@@ -31,6 +31,148 @@ static inline bool acpi_has_cpu_in_madt(void)
=20
 extern struct list_head acpi_wakeup_device_list;
=20
+/*
+ * Temporary definitions until the core ACPICA code gets updated (see
+ * 1656837932-18257-1-git-send-email-lvjianmin@loongson.cn and its
+ * follow-ups for the "rationale").
+ *
+ * Once the "legal reasons" are cleared and that the code is merged,
+ * this can be dropped entierely.
+ */
+#if (ACPI_CA_VERSION =3D=3D 0x20220331 && !defined(LOONGARCH_ACPICA_EXT))
+
+#define LOONGARCH_ACPICA_EXT	1
+
+#define	ACPI_MADT_TYPE_CORE_PIC		17
+#define	ACPI_MADT_TYPE_LIO_PIC		18
+#define	ACPI_MADT_TYPE_HT_PIC		19
+#define	ACPI_MADT_TYPE_EIO_PIC		20
+#define	ACPI_MADT_TYPE_MSI_PIC		21
+#define	ACPI_MADT_TYPE_BIO_PIC		22
+#define	ACPI_MADT_TYPE_LPC_PIC		23
+
+/* Values for Version field above */
+
+enum acpi_madt_core_pic_version {
+	ACPI_MADT_CORE_PIC_VERSION_NONE =3D 0,
+	ACPI_MADT_CORE_PIC_VERSION_V1 =3D 1,
+	ACPI_MADT_CORE_PIC_VERSION_RESERVED =3D 2	/* 2 and greater are reserved */
+};
+
+enum acpi_madt_lio_pic_version {
+	ACPI_MADT_LIO_PIC_VERSION_NONE =3D 0,
+	ACPI_MADT_LIO_PIC_VERSION_V1 =3D 1,
+	ACPI_MADT_LIO_PIC_VERSION_RESERVED =3D 2	/* 2 and greater are reserved */
+};
+
+enum acpi_madt_eio_pic_version {
+	ACPI_MADT_EIO_PIC_VERSION_NONE =3D 0,
+	ACPI_MADT_EIO_PIC_VERSION_V1 =3D 1,
+	ACPI_MADT_EIO_PIC_VERSION_RESERVED =3D 2	/* 2 and greater are reserved */
+};
+
+enum acpi_madt_ht_pic_version {
+	ACPI_MADT_HT_PIC_VERSION_NONE =3D 0,
+	ACPI_MADT_HT_PIC_VERSION_V1 =3D 1,
+	ACPI_MADT_HT_PIC_VERSION_RESERVED =3D 2	/* 2 and greater are reserved */
+};
+
+enum acpi_madt_bio_pic_version {
+	ACPI_MADT_BIO_PIC_VERSION_NONE =3D 0,
+	ACPI_MADT_BIO_PIC_VERSION_V1 =3D 1,
+	ACPI_MADT_BIO_PIC_VERSION_RESERVED =3D 2	/* 2 and greater are reserved */
+};
+
+enum acpi_madt_msi_pic_version {
+	ACPI_MADT_MSI_PIC_VERSION_NONE =3D 0,
+	ACPI_MADT_MSI_PIC_VERSION_V1 =3D 1,
+	ACPI_MADT_MSI_PIC_VERSION_RESERVED =3D 2	/* 2 and greater are reserved */
+};
+
+enum acpi_madt_lpc_pic_version {
+	ACPI_MADT_LPC_PIC_VERSION_NONE =3D 0,
+	ACPI_MADT_LPC_PIC_VERSION_V1 =3D 1,
+	ACPI_MADT_LPC_PIC_VERSION_RESERVED =3D 2	/* 2 and greater are reserved */
+};
+
+#pragma pack(1)
+
+/* Core Interrupt Controller */
+
+struct acpi_madt_core_pic {
+	struct acpi_subtable_header header;
+	u8 version;
+	u32 processor_id;
+	u32 core_id;
+	u32 flags;
+};
+
+/* Legacy I/O Interrupt Controller */
+
+struct acpi_madt_lio_pic {
+	struct acpi_subtable_header header;
+	u8 version;
+	u64 address;
+	u16 size;
+	u8 cascade[2];
+	u32 cascade_map[2];
+};
+
+/* Extend I/O Interrupt Controller */
+
+struct acpi_madt_eio_pic {
+	struct acpi_subtable_header header;
+	u8 version;
+	u8 cascade;
+	u8 node;
+	u64 node_map;
+};
+
+/* HT Interrupt Controller */
+
+struct acpi_madt_ht_pic {
+	struct acpi_subtable_header header;
+	u8 version;
+	u64 address;
+	u16 size;
+	u8 cascade[8];
+};
+
+/* Bridge I/O Interrupt Controller */
+
+struct acpi_madt_bio_pic {
+	struct acpi_subtable_header header;
+	u8 version;
+	u64 address;
+	u16 size;
+	u16 id;
+	u16 gsi_base;
+};
+
+/* MSI Interrupt Controller */
+
+struct acpi_madt_msi_pic {
+	struct acpi_subtable_header header;
+	u8 version;
+	u64 msg_address;
+	u32 start;
+	u32 count;
+};
+
+/* LPC Interrupt Controller */
+
+struct acpi_madt_lpc_pic {
+	struct acpi_subtable_header header;
+	u8 version;
+	u64 address;
+	u16 size;
+	u8 cascade;
+};
+
+#pragma pack()
+
+#endif
+
 #endif /* !CONFIG_ACPI */
=20
 #define ACPI_TABLE_UPGRADE_MAX_PHYS ARCH_LOW_ADDRESS_LIMIT
diff --git a/arch/loongarch/include/asm/irq.h b/arch/loongarch/include/asm/ir=
q.h
index ace3ea6da72e..149b2123e7f4 100644
--- a/arch/loongarch/include/asm/irq.h
+++ b/arch/loongarch/include/asm/irq.h
@@ -35,9 +35,6 @@ static inline bool on_irq_stack(int cpu, unsigned long sp)
 	return (low <=3D sp && sp <=3D high);
 }
=20
-int get_ipi_irq(void);
-int get_pmc_irq(void);
-int get_timer_irq(void);
 void spurious_interrupt(void);
=20
 #define NR_IRQS_LEGACY 16
@@ -48,6 +45,14 @@ void arch_trigger_cpumask_backtrace(const struct cpumask *=
mask, bool exclude_sel
 #define MAX_IO_PICS 2
 #define NR_IRQS	(64 + (256 * MAX_IO_PICS))
=20
+struct acpi_vector_group {
+	int node;
+	int pci_segment;
+	struct irq_domain *parent;
+};
+extern struct acpi_vector_group pch_group[MAX_IO_PICS];
+extern struct acpi_vector_group msi_group[MAX_IO_PICS];
+
 #define CORES_PER_EIO_NODE	4
=20
 #define LOONGSON_CPU_UART0_VEC		10 /* CPU UART0 */
@@ -79,15 +84,6 @@ void arch_trigger_cpumask_backtrace(const struct cpumask *=
mask, bool exclude_sel
 extern int find_pch_pic(u32 gsi);
 extern int eiointc_get_node(int id);
=20
-static inline void eiointc_enable(void)
-{
-	uint64_t misc;
-
-	misc =3D iocsr_read64(LOONGARCH_IOCSR_MISC_FUNC);
-	misc |=3D IOCSR_MISC_FUNC_EXT_IOI_EN;
-	iocsr_write64(misc, LOONGARCH_IOCSR_MISC_FUNC);
-}
-
 struct acpi_madt_lio_pic;
 struct acpi_madt_eio_pic;
 struct acpi_madt_ht_pic;
@@ -95,21 +91,29 @@ struct acpi_madt_bio_pic;
 struct acpi_madt_msi_pic;
 struct acpi_madt_lpc_pic;
=20
-struct irq_domain *loongarch_cpu_irq_init(void);
-
-struct irq_domain *liointc_acpi_init(struct irq_domain *parent,
+int liointc_acpi_init(struct irq_domain *parent,
 					struct acpi_madt_lio_pic *acpi_liointc);
-struct irq_domain *eiointc_acpi_init(struct irq_domain *parent,
+int eiointc_acpi_init(struct irq_domain *parent,
 					struct acpi_madt_eio_pic *acpi_eiointc);
=20
 struct irq_domain *htvec_acpi_init(struct irq_domain *parent,
 					struct acpi_madt_ht_pic *acpi_htvec);
-struct irq_domain *pch_lpc_acpi_init(struct irq_domain *parent,
+int pch_lpc_acpi_init(struct irq_domain *parent,
 					struct acpi_madt_lpc_pic *acpi_pchlpc);
-struct irq_domain *pch_msi_acpi_init(struct irq_domain *parent,
+#if IS_ENABLED(CONFIG_LOONGSON_PCH_MSI)
+int pch_msi_acpi_init(struct irq_domain *parent,
 					struct acpi_madt_msi_pic *acpi_pchmsi);
-struct irq_domain *pch_pic_acpi_init(struct irq_domain *parent,
+#else
+static inline int pch_msi_acpi_init(struct irq_domain *parent,
+					struct acpi_madt_msi_pic *acpi_pchmsi)
+{
+	return 0;
+}
+#endif
+int pch_pic_acpi_init(struct irq_domain *parent,
 					struct acpi_madt_bio_pic *acpi_pchpic);
+int find_pch_pic(u32 gsi);
+struct fwnode_handle *get_pch_msi_handle(int pci_segment);
=20
 extern struct acpi_madt_lio_pic *acpi_liointc;
 extern struct acpi_madt_eio_pic *acpi_eiointc[MAX_IO_PICS];
@@ -119,11 +123,10 @@ extern struct acpi_madt_lpc_pic *acpi_pchlpc;
 extern struct acpi_madt_msi_pic *acpi_pchmsi[MAX_IO_PICS];
 extern struct acpi_madt_bio_pic *acpi_pchpic[MAX_IO_PICS];
=20
-extern struct irq_domain *cpu_domain;
-extern struct irq_domain *liointc_domain;
-extern struct irq_domain *pch_lpc_domain;
-extern struct irq_domain *pch_msi_domain[MAX_IO_PICS];
-extern struct irq_domain *pch_pic_domain[MAX_IO_PICS];
+extern struct fwnode_handle *cpuintc_handle;
+extern struct fwnode_handle *liointc_handle;
+extern struct fwnode_handle *pch_lpc_handle;
+extern struct fwnode_handle *pch_pic_handle[MAX_IO_PICS];
=20
 extern irqreturn_t loongson3_ipi_interrupt(int irq, void *dev);
=20
diff --git a/arch/loongarch/kernel/acpi.c b/arch/loongarch/kernel/acpi.c
index bb729ee8a237..03aa14581d0a 100644
--- a/arch/loongarch/kernel/acpi.c
+++ b/arch/loongarch/kernel/acpi.c
@@ -25,7 +25,6 @@ EXPORT_SYMBOL(acpi_pci_disabled);
 int acpi_strict =3D 1; /* We have no workarounds on LoongArch */
 int num_processors;
 int disabled_cpus;
-enum acpi_irq_model_id acpi_irq_model =3D ACPI_IRQ_MODEL_PLATFORM;
=20
 u64 acpi_saved_sp;
=20
@@ -33,70 +32,6 @@ u64 acpi_saved_sp;
=20
 #define PREFIX			"ACPI: "
=20
-int acpi_gsi_to_irq(u32 gsi, unsigned int *irqp)
-{
-	if (irqp !=3D NULL)
-		*irqp =3D acpi_register_gsi(NULL, gsi, -1, -1);
-	return (*irqp >=3D 0) ? 0 : -EINVAL;
-}
-EXPORT_SYMBOL_GPL(acpi_gsi_to_irq);
-
-int acpi_isa_irq_to_gsi(unsigned int isa_irq, u32 *gsi)
-{
-	if (gsi)
-		*gsi =3D isa_irq;
-	return 0;
-}
-
-/*
- * success: return IRQ number (>=3D0)
- * failure: return < 0
- */
-int acpi_register_gsi(struct device *dev, u32 gsi, int trigger, int polarity)
-{
-	struct irq_fwspec fwspec;
-
-	switch (gsi) {
-	case GSI_MIN_CPU_IRQ ... GSI_MAX_CPU_IRQ:
-		fwspec.fwnode =3D liointc_domain->fwnode;
-		fwspec.param[0] =3D gsi - GSI_MIN_CPU_IRQ;
-		fwspec.param_count =3D 1;
-
-		return irq_create_fwspec_mapping(&fwspec);
-
-	case GSI_MIN_LPC_IRQ ... GSI_MAX_LPC_IRQ:
-		if (!pch_lpc_domain)
-			return -EINVAL;
-
-		fwspec.fwnode =3D pch_lpc_domain->fwnode;
-		fwspec.param[0] =3D gsi - GSI_MIN_LPC_IRQ;
-		fwspec.param[1] =3D acpi_dev_get_irq_type(trigger, polarity);
-		fwspec.param_count =3D 2;
-
-		return irq_create_fwspec_mapping(&fwspec);
-
-	case GSI_MIN_PCH_IRQ ... GSI_MAX_PCH_IRQ:
-		if (!pch_pic_domain[0])
-			return -EINVAL;
-
-		fwspec.fwnode =3D pch_pic_domain[0]->fwnode;
-		fwspec.param[0] =3D gsi - GSI_MIN_PCH_IRQ;
-		fwspec.param[1] =3D IRQ_TYPE_LEVEL_HIGH;
-		fwspec.param_count =3D 2;
-
-		return irq_create_fwspec_mapping(&fwspec);
-	}
-
-	return -EINVAL;
-}
-EXPORT_SYMBOL_GPL(acpi_register_gsi);
-
-void acpi_unregister_gsi(u32 gsi)
-{
-
-}
-EXPORT_SYMBOL_GPL(acpi_unregister_gsi);
-
 void __init __iomem * __acpi_map_table(unsigned long phys, unsigned long siz=
e)
 {
=20
diff --git a/arch/loongarch/kernel/irq.c b/arch/loongarch/kernel/irq.c
index b34b8d792aa4..1ba19c76563e 100644
--- a/arch/loongarch/kernel/irq.c
+++ b/arch/loongarch/kernel/irq.c
@@ -25,12 +25,8 @@ DEFINE_PER_CPU(unsigned long, irq_stack);
 DEFINE_PER_CPU_SHARED_ALIGNED(irq_cpustat_t, irq_stat);
 EXPORT_PER_CPU_SYMBOL(irq_stat);
=20
-struct irq_domain *cpu_domain;
-struct irq_domain *liointc_domain;
-struct irq_domain *pch_lpc_domain;
-struct irq_domain *pch_msi_domain[MAX_IO_PICS];
-struct irq_domain *pch_pic_domain[MAX_IO_PICS];
-
+struct acpi_vector_group pch_group[MAX_IO_PICS];
+struct acpi_vector_group msi_group[MAX_IO_PICS];
 /*
  * 'what should we do if we get a hw irq event on an illegal vector'.
  * each architecture has to answer this themselves.
@@ -56,6 +52,51 @@ int arch_show_interrupts(struct seq_file *p, int prec)
 	return 0;
 }
=20
+static int __init early_pci_mcfg_parse(struct acpi_table_header *header)
+{
+	struct acpi_table_mcfg *mcfg;
+	struct acpi_mcfg_allocation *mptr;
+	int i, n;
+
+	if (header->length < sizeof(struct acpi_table_mcfg))
+		return -EINVAL;
+
+	n =3D (header->length - sizeof(struct acpi_table_mcfg)) /
+					sizeof(struct acpi_mcfg_allocation);
+	mcfg =3D (struct acpi_table_mcfg *)header;
+	mptr =3D (struct acpi_mcfg_allocation *) &mcfg[1];
+
+	for (i =3D 0; i < n; i++, mptr++) {
+		msi_group[i].pci_segment =3D mptr->pci_segment;
+		pch_group[i].node =3D msi_group[i].node =3D (mptr->address >> 44) & 0xf;
+	}
+
+	return 0;
+}
+
+static void __init init_vec_parent_group(void)
+{
+	int i;
+
+	for (i =3D 0; i < MAX_IO_PICS; i++) {
+		msi_group[i].pci_segment =3D -1;
+		msi_group[i].node =3D -1;
+		pch_group[i].node =3D -1;
+	}
+
+	acpi_table_parse(ACPI_SIG_MCFG, early_pci_mcfg_parse);
+}
+
+static int __init get_ipi_irq(void)
+{
+	struct irq_domain *d =3D irq_find_matching_fwnode(cpuintc_handle, DOMAIN_BU=
S_ANY);
+
+	if (d)
+		return irq_create_mapping(d, EXCCODE_IPI - EXCCODE_INT_START);
+
+	return -EINVAL;
+}
+
 void __init init_IRQ(void)
 {
 	int i;
@@ -69,9 +110,12 @@ void __init init_IRQ(void)
 	clear_csr_ecfg(ECFG0_IM);
 	clear_csr_estat(ESTATF_IP);
=20
+	init_vec_parent_group();
 	irqchip_init();
 #ifdef CONFIG_SMP
-	ipi_irq =3D EXCCODE_IPI - EXCCODE_INT_START;
+	ipi_irq =3D get_ipi_irq();
+	if (ipi_irq < 0)
+		panic("IPI IRQ mapping failed\n");
 	irq_set_percpu_devid(ipi_irq);
 	r =3D request_percpu_irq(ipi_irq, loongson3_ipi_interrupt, "IPI", &ipi_dumm=
y_dev);
 	if (r < 0)
diff --git a/arch/loongarch/kernel/time.c b/arch/loongarch/kernel/time.c
index fe6823875895..79dc5eddf504 100644
--- a/arch/loongarch/kernel/time.c
+++ b/arch/loongarch/kernel/time.c
@@ -123,6 +123,16 @@ void sync_counter(void)
 	csr_write64(-init_timeval, LOONGARCH_CSR_CNTC);
 }
=20
+static int get_timer_irq(void)
+{
+	struct irq_domain *d =3D irq_find_matching_fwnode(cpuintc_handle, DOMAIN_BU=
S_ANY);
+
+	if (d)
+		return irq_create_mapping(d, EXCCODE_TIMER - EXCCODE_INT_START);
+
+	return -EINVAL;
+}
+
 int constant_clockevent_init(void)
 {
 	unsigned int irq;
@@ -132,7 +142,9 @@ int constant_clockevent_init(void)
 	struct clock_event_device *cd;
 	static int timer_irq_installed =3D 0;
=20
-	irq =3D EXCCODE_TIMER - EXCCODE_INT_START;
+	irq =3D get_timer_irq();
+	if (irq < 0)
+		pr_err("Failed to map irq %d (timer)\n", irq);
=20
 	cd =3D &per_cpu(constant_clockevent_device, cpu);
=20
diff --git a/arch/mips/cavium-octeon/octeon-irq.c b/arch/mips/cavium-octeon/o=
cteon-irq.c
index 6cdcbf4de763..9cb9ed44bcaf 100644
--- a/arch/mips/cavium-octeon/octeon-irq.c
+++ b/arch/mips/cavium-octeon/octeon-irq.c
@@ -263,7 +263,7 @@ static int next_cpu_for_irq(struct irq_data *data)
=20
 #ifdef CONFIG_SMP
 	int cpu;
-	struct cpumask *mask =3D irq_data_get_affinity_mask(data);
+	const struct cpumask *mask =3D irq_data_get_affinity_mask(data);
 	int weight =3D cpumask_weight(mask);
 	struct octeon_ciu_chip_data *cd =3D irq_data_get_irq_chip_data(data);
=20
@@ -758,7 +758,7 @@ static void octeon_irq_cpu_offline_ciu(struct irq_data *d=
ata)
 {
 	int cpu =3D smp_processor_id();
 	cpumask_t new_affinity;
-	struct cpumask *mask =3D irq_data_get_affinity_mask(data);
+	const struct cpumask *mask =3D irq_data_get_affinity_mask(data);
=20
 	if (!cpumask_test_cpu(cpu, mask))
 		return;
diff --git a/arch/mips/include/asm/mach-loongson64/irq.h b/arch/mips/include/=
asm/mach-loongson64/irq.h
index 98ea977cf0b8..67c15f320f93 100644
--- a/arch/mips/include/asm/mach-loongson64/irq.h
+++ b/arch/mips/include/asm/mach-loongson64/irq.h
@@ -7,8 +7,9 @@
 #define NR_MIPS_CPU_IRQS	8
 #define NR_MAX_CHAINED_IRQS	40 /* Chained IRQs means those not directly used=
 by devices */
 #define NR_IRQS			(NR_IRQS_LEGACY + NR_MIPS_CPU_IRQS + NR_MAX_CHAINED_IRQS +=
 256)
-
+#define MAX_IO_PICS		1
 #define MIPS_CPU_IRQ_BASE 	NR_IRQS_LEGACY
+#define GSI_MIN_CPU_IRQ		0
=20
 #include <asm/mach-generic/irq.h>
=20
diff --git a/arch/parisc/kernel/irq.c b/arch/parisc/kernel/irq.c
index 0fe2d79fb123..5ebb1771b4ab 100644
--- a/arch/parisc/kernel/irq.c
+++ b/arch/parisc/kernel/irq.c
@@ -315,7 +315,7 @@ unsigned long txn_affinity_addr(unsigned int irq, int cpu)
 {
 #ifdef CONFIG_SMP
 	struct irq_data *d =3D irq_get_irq_data(irq);
-	cpumask_copy(irq_data_get_affinity_mask(d), cpumask_of(cpu));
+	irq_data_update_affinity(d, cpumask_of(cpu));
 #endif
=20
 	return per_cpu(cpu_data, cpu).txn_addr;
diff --git a/arch/sh/kernel/irq.c b/arch/sh/kernel/irq.c
index ef0f0827cf57..56269c2c3414 100644
--- a/arch/sh/kernel/irq.c
+++ b/arch/sh/kernel/irq.c
@@ -230,16 +230,17 @@ void migrate_irqs(void)
 		struct irq_data *data =3D irq_get_irq_data(irq);
=20
 		if (irq_data_get_node(data) =3D=3D cpu) {
-			struct cpumask *mask =3D irq_data_get_affinity_mask(data);
+			const struct cpumask *mask =3D irq_data_get_affinity_mask(data);
 			unsigned int newcpu =3D cpumask_any_and(mask,
 							      cpu_online_mask);
 			if (newcpu >=3D nr_cpu_ids) {
 				pr_info_ratelimited("IRQ%u no longer affine to CPU%u\n",
 						    irq, cpu);
=20
-				cpumask_setall(mask);
+				irq_set_affinity(irq, cpu_all_mask);
+			} else {
+				irq_set_affinity(irq, mask);
 			}
-			irq_set_affinity(irq, mask);
 		}
 	}
 }
diff --git a/arch/x86/hyperv/irqdomain.c b/arch/x86/hyperv/irqdomain.c
index 7e0f6bedc248..42c70d28ef27 100644
--- a/arch/x86/hyperv/irqdomain.c
+++ b/arch/x86/hyperv/irqdomain.c
@@ -192,7 +192,7 @@ static void hv_irq_compose_msi_msg(struct irq_data *data,=
 struct msi_msg *msg)
 	struct pci_dev *dev;
 	struct hv_interrupt_entry out_entry, *stored_entry;
 	struct irq_cfg *cfg =3D irqd_cfg(data);
-	cpumask_t *affinity;
+	const cpumask_t *affinity;
 	int cpu;
 	u64 status;
=20
diff --git a/arch/xtensa/kernel/irq.c b/arch/xtensa/kernel/irq.c
index 529fe9245821..42f106004400 100644
--- a/arch/xtensa/kernel/irq.c
+++ b/arch/xtensa/kernel/irq.c
@@ -169,7 +169,7 @@ void migrate_irqs(void)
=20
 	for_each_active_irq(i) {
 		struct irq_data *data =3D irq_get_irq_data(i);
-		struct cpumask *mask;
+		const struct cpumask *mask;
 		unsigned int newcpu;
=20
 		if (irqd_is_per_cpu(data))
@@ -185,9 +185,10 @@ void migrate_irqs(void)
 			pr_info_ratelimited("IRQ%u no longer affine to CPU%u\n",
 					    i, cpu);
=20
-			cpumask_setall(mask);
+			irq_set_affinity(i, cpu_all_mask);
+		} else {
+			irq_set_affinity(i, mask);
 		}
-		irq_set_affinity(i, mask);
 	}
 }
 #endif /* CONFIG_HOTPLUG_CPU */
diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 86fa61a21826..63fbf0022d39 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -1145,6 +1145,9 @@ static int __init acpi_bus_init_irq(void)
 	case ACPI_IRQ_MODEL_PLATFORM:
 		message =3D "platform specific model";
 		break;
+	case ACPI_IRQ_MODEL_LPIC:
+		message =3D "LPIC";
+		break;
 	default:
 		pr_info("Unknown interrupt routing model\n");
 		return -ENODEV;
diff --git a/drivers/acpi/irq.c b/drivers/acpi/irq.c
index c68e694fca26..dabe45eba055 100644
--- a/drivers/acpi/irq.c
+++ b/drivers/acpi/irq.c
@@ -12,7 +12,8 @@
=20
 enum acpi_irq_model_id acpi_irq_model;
=20
-static struct fwnode_handle *acpi_gsi_domain_id;
+static struct fwnode_handle *(*acpi_get_gsi_domain_id)(u32 gsi);
+static u32 (*acpi_gsi_to_irq_fallback)(u32 gsi);
=20
 /**
  * acpi_gsi_to_irq() - Retrieve the linux irq number for a given GSI
@@ -26,14 +27,18 @@ static struct fwnode_handle *acpi_gsi_domain_id;
  */
 int acpi_gsi_to_irq(u32 gsi, unsigned int *irq)
 {
-	struct irq_domain *d =3D irq_find_matching_fwnode(acpi_gsi_domain_id,
-							DOMAIN_BUS_ANY);
+	struct irq_domain *d;
=20
+	d =3D irq_find_matching_fwnode(acpi_get_gsi_domain_id(gsi),
+					DOMAIN_BUS_ANY);
 	*irq =3D irq_find_mapping(d, gsi);
 	/*
-	 * *irq =3D=3D 0 means no mapping, that should
-	 * be reported as a failure
+	 * *irq =3D=3D 0 means no mapping, that should be reported as a
+	 * failure, unless there is an arch-specific fallback handler.
 	 */
+	if (!*irq && acpi_gsi_to_irq_fallback)
+		*irq =3D acpi_gsi_to_irq_fallback(gsi);
+
 	return (*irq > 0) ? 0 : -EINVAL;
 }
 EXPORT_SYMBOL_GPL(acpi_gsi_to_irq);
@@ -53,12 +58,12 @@ int acpi_register_gsi(struct device *dev, u32 gsi, int tr=
igger,
 {
 	struct irq_fwspec fwspec;
=20
-	if (WARN_ON(!acpi_gsi_domain_id)) {
+	fwspec.fwnode =3D acpi_get_gsi_domain_id(gsi);
+	if (WARN_ON(!fwspec.fwnode)) {
 		pr_warn("GSI: No registered irqchip, giving up\n");
 		return -EINVAL;
 	}
=20
-	fwspec.fwnode =3D acpi_gsi_domain_id;
 	fwspec.param[0] =3D gsi;
 	fwspec.param[1] =3D acpi_dev_get_irq_type(trigger, polarity);
 	fwspec.param_count =3D 2;
@@ -73,13 +78,14 @@ EXPORT_SYMBOL_GPL(acpi_register_gsi);
  */
 void acpi_unregister_gsi(u32 gsi)
 {
-	struct irq_domain *d =3D irq_find_matching_fwnode(acpi_gsi_domain_id,
-							DOMAIN_BUS_ANY);
+	struct irq_domain *d;
 	int irq;
=20
 	if (WARN_ON(acpi_irq_model =3D=3D ACPI_IRQ_MODEL_GIC && gsi < 16))
 		return;
=20
+	d =3D irq_find_matching_fwnode(acpi_get_gsi_domain_id(gsi),
+				     DOMAIN_BUS_ANY);
 	irq =3D irq_find_mapping(d, gsi);
 	irq_dispose_mapping(irq);
 }
@@ -97,7 +103,8 @@ EXPORT_SYMBOL_GPL(acpi_unregister_gsi);
  * The referenced device fwhandle or NULL on failure
  */
 static struct fwnode_handle *
-acpi_get_irq_source_fwhandle(const struct acpi_resource_source *source)
+acpi_get_irq_source_fwhandle(const struct acpi_resource_source *source,
+			     u32 gsi)
 {
 	struct fwnode_handle *result;
 	struct acpi_device *device;
@@ -105,7 +112,7 @@ acpi_get_irq_source_fwhandle(const struct acpi_resource_s=
ource *source)
 	acpi_status status;
=20
 	if (!source->string_length)
-		return acpi_gsi_domain_id;
+		return acpi_get_gsi_domain_id(gsi);
=20
 	status =3D acpi_get_handle(NULL, source->string_ptr, &handle);
 	if (WARN_ON(ACPI_FAILURE(status)))
@@ -194,7 +201,7 @@ static acpi_status acpi_irq_parse_one_cb(struct acpi_reso=
urce *ares,
 			ctx->index -=3D irq->interrupt_count;
 			return AE_OK;
 		}
-		fwnode =3D acpi_gsi_domain_id;
+		fwnode =3D acpi_get_gsi_domain_id(irq->interrupts[ctx->index]);
 		acpi_irq_parse_one_match(fwnode, irq->interrupts[ctx->index],
 					 irq->triggering, irq->polarity,
 					 irq->shareable, ctx);
@@ -207,7 +214,8 @@ static acpi_status acpi_irq_parse_one_cb(struct acpi_reso=
urce *ares,
 			ctx->index -=3D eirq->interrupt_count;
 			return AE_OK;
 		}
-		fwnode =3D acpi_get_irq_source_fwhandle(&eirq->resource_source);
+		fwnode =3D acpi_get_irq_source_fwhandle(&eirq->resource_source,
+						      eirq->interrupts[ctx->index]);
 		acpi_irq_parse_one_match(fwnode, eirq->interrupts[ctx->index],
 					 eirq->triggering, eirq->polarity,
 					 eirq->shareable, ctx);
@@ -291,10 +299,20 @@ EXPORT_SYMBOL_GPL(acpi_irq_get);
  *          GSI interrupts
  */
 void __init acpi_set_irq_model(enum acpi_irq_model_id model,
-			       struct fwnode_handle *fwnode)
+			       struct fwnode_handle *(*fn)(u32))
 {
 	acpi_irq_model =3D model;
-	acpi_gsi_domain_id =3D fwnode;
+	acpi_get_gsi_domain_id =3D fn;
+}
+
+/**
+ * acpi_set_gsi_to_irq_fallback - Register a GSI transfer
+ * callback to fallback to arch specified implementation.
+ * @fn: arch-specific fallback handler
+ */
+void __init acpi_set_gsi_to_irq_fallback(u32 (*fn)(u32))
+{
+	acpi_gsi_to_irq_fallback =3D fn;
 }
=20
 /**
@@ -312,8 +330,14 @@ struct irq_domain *acpi_irq_create_hierarchy(unsigned in=
t flags,
 					     const struct irq_domain_ops *ops,
 					     void *host_data)
 {
-	struct irq_domain *d =3D irq_find_matching_fwnode(acpi_gsi_domain_id,
-							DOMAIN_BUS_ANY);
+	struct irq_domain *d;
+
+	/* This only works for the GIC model... */
+	if (acpi_irq_model !=3D ACPI_IRQ_MODEL_GIC)
+		return NULL;
+
+	d =3D irq_find_matching_fwnode(acpi_get_gsi_domain_id(0),
+				     DOMAIN_BUS_ANY);
=20
 	if (!d)
 		return NULL;
diff --git a/drivers/gpio/gpio-msc313.c b/drivers/gpio/gpio-msc313.c
index b2c90bdd39d0..52d7b8d99170 100644
--- a/drivers/gpio/gpio-msc313.c
+++ b/drivers/gpio/gpio-msc313.c
@@ -550,15 +550,12 @@ static struct irq_chip msc313_gpio_irqchip =3D {
  * so we need to provide the fwspec. Essentially gpiochip_populate_parent_fw=
spec_twocell
  * that puts GIC_SPI into the first cell.
  */
-static void *msc313_gpio_populate_parent_fwspec(struct gpio_chip *gc,
-					     unsigned int parent_hwirq,
-					     unsigned int parent_type)
+static int msc313_gpio_populate_parent_fwspec(struct gpio_chip *gc,
+					      union gpio_irq_fwspec *gfwspec,
+					      unsigned int parent_hwirq,
+					      unsigned int parent_type)
 {
-	struct irq_fwspec *fwspec;
-
-	fwspec =3D kmalloc(sizeof(*fwspec), GFP_KERNEL);
-	if (!fwspec)
-		return NULL;
+	struct irq_fwspec *fwspec =3D &gfwspec->fwspec;
=20
 	fwspec->fwnode =3D gc->irq.parent_domain->fwnode;
 	fwspec->param_count =3D 3;
@@ -566,7 +563,7 @@ static void *msc313_gpio_populate_parent_fwspec(struct gp=
io_chip *gc,
 	fwspec->param[1] =3D parent_hwirq;
 	fwspec->param[2] =3D parent_type;
=20
-	return fwspec;
+	return 0;
 }
=20
 static int msc313e_gpio_child_to_parent_hwirq(struct gpio_chip *chip,
diff --git a/drivers/gpio/gpio-tegra.c b/drivers/gpio/gpio-tegra.c
index ff2d2a1f9c73..e4fb4cb38a0f 100644
--- a/drivers/gpio/gpio-tegra.c
+++ b/drivers/gpio/gpio-tegra.c
@@ -443,15 +443,12 @@ static int tegra_gpio_child_to_parent_hwirq(struct gpio=
_chip *chip,
 	return 0;
 }
=20
-static void *tegra_gpio_populate_parent_fwspec(struct gpio_chip *chip,
-					       unsigned int parent_hwirq,
-					       unsigned int parent_type)
+static int tegra_gpio_populate_parent_fwspec(struct gpio_chip *chip,
+					     union gpio_irq_fwspec *gfwspec,
+					     unsigned int parent_hwirq,
+					     unsigned int parent_type)
 {
-	struct irq_fwspec *fwspec;
-
-	fwspec =3D kmalloc(sizeof(*fwspec), GFP_KERNEL);
-	if (!fwspec)
-		return NULL;
+	struct irq_fwspec *fwspec =3D &gfwspec->fwspec;
=20
 	fwspec->fwnode =3D chip->irq.parent_domain->fwnode;
 	fwspec->param_count =3D 3;
@@ -459,7 +456,7 @@ static void *tegra_gpio_populate_parent_fwspec(struct gpi=
o_chip *chip,
 	fwspec->param[1] =3D parent_hwirq;
 	fwspec->param[2] =3D parent_type;
=20
-	return fwspec;
+	return 0;
 }
=20
 #ifdef CONFIG_PM_SLEEP
diff --git a/drivers/gpio/gpio-tegra186.c b/drivers/gpio/gpio-tegra186.c
index de28a68daea0..54d9fa7da9c1 100644
--- a/drivers/gpio/gpio-tegra186.c
+++ b/drivers/gpio/gpio-tegra186.c
@@ -621,16 +621,13 @@ static int tegra186_gpio_irq_domain_translate(struct ir=
q_domain *domain,
 	return 0;
 }
=20
-static void *tegra186_gpio_populate_parent_fwspec(struct gpio_chip *chip,
-						 unsigned int parent_hwirq,
-						 unsigned int parent_type)
+static int tegra186_gpio_populate_parent_fwspec(struct gpio_chip *chip,
+						union gpio_irq_fwspec *gfwspec,
+						unsigned int parent_hwirq,
+						unsigned int parent_type)
 {
 	struct tegra_gpio *gpio =3D gpiochip_get_data(chip);
-	struct irq_fwspec *fwspec;
-
-	fwspec =3D kmalloc(sizeof(*fwspec), GFP_KERNEL);
-	if (!fwspec)
-		return NULL;
+	struct irq_fwspec *fwspec =3D &gfwspec->fwspec;
=20
 	fwspec->fwnode =3D chip->irq.parent_domain->fwnode;
 	fwspec->param_count =3D 3;
@@ -638,7 +635,7 @@ static void *tegra186_gpio_populate_parent_fwspec(struct =
gpio_chip *chip,
 	fwspec->param[1] =3D parent_hwirq;
 	fwspec->param[2] =3D parent_type;
=20
-	return fwspec;
+	return 0;
 }
=20
 static int tegra186_gpio_child_to_parent_hwirq(struct gpio_chip *chip,
diff --git a/drivers/gpio/gpio-thunderx.c b/drivers/gpio/gpio-thunderx.c
index 9f66deab46ea..cc62c6e64103 100644
--- a/drivers/gpio/gpio-thunderx.c
+++ b/drivers/gpio/gpio-thunderx.c
@@ -15,8 +15,6 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/spinlock.h>
-#include <asm-generic/msi.h>
-
=20
 #define GPIO_RX_DAT	0x0
 #define GPIO_TX_SET	0x8
@@ -408,18 +406,15 @@ static int thunderx_gpio_child_to_parent_hwirq(struct g=
pio_chip *gc,
 	return 0;
 }
=20
-static void *thunderx_gpio_populate_parent_alloc_info(struct gpio_chip *chip,
-						      unsigned int parent_hwirq,
-						      unsigned int parent_type)
+static int thunderx_gpio_populate_parent_alloc_info(struct gpio_chip *chip,
+						    union gpio_irq_fwspec *gfwspec,
+						    unsigned int parent_hwirq,
+						    unsigned int parent_type)
 {
-	msi_alloc_info_t *info;
-
-	info =3D kmalloc(sizeof(*info), GFP_KERNEL);
-	if (!info)
-		return NULL;
+	msi_alloc_info_t *info =3D &gfwspec->msiinfo;
=20
 	info->hwirq =3D parent_hwirq;
-	return info;
+	return 0;
 }
=20
 static int thunderx_gpio_probe(struct pci_dev *pdev,
diff --git a/drivers/gpio/gpio-visconti.c b/drivers/gpio/gpio-visconti.c
index e6534ea1eaa7..5e108ba9956a 100644
--- a/drivers/gpio/gpio-visconti.c
+++ b/drivers/gpio/gpio-visconti.c
@@ -103,15 +103,12 @@ static int visconti_gpio_child_to_parent_hwirq(struct g=
pio_chip *gc,
 	return -EINVAL;
 }
=20
-static void *visconti_gpio_populate_parent_fwspec(struct gpio_chip *chip,
-						  unsigned int parent_hwirq,
-						  unsigned int parent_type)
+static int visconti_gpio_populate_parent_fwspec(struct gpio_chip *chip,
+						union gpio_irq_fwspec *gfwspec,
+						unsigned int parent_hwirq,
+						unsigned int parent_type)
 {
-	struct irq_fwspec *fwspec;
-
-	fwspec =3D kmalloc(sizeof(*fwspec), GFP_KERNEL);
-	if (!fwspec)
-		return NULL;
+	struct irq_fwspec *fwspec =3D &gfwspec->fwspec;
=20
 	fwspec->fwnode =3D chip->irq.parent_domain->fwnode;
 	fwspec->param_count =3D 3;
@@ -119,7 +116,7 @@ static void *visconti_gpio_populate_parent_fwspec(struct =
gpio_chip *chip,
 	fwspec->param[1] =3D parent_hwirq;
 	fwspec->param[2] =3D parent_type;
=20
-	return fwspec;
+	return 0;
 }
=20
 static int visconti_gpio_probe(struct platform_device *pdev)
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 9535f48e18d1..68d9f95d7799 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1107,7 +1107,7 @@ static int gpiochip_hierarchy_irq_domain_alloc(struct i=
rq_domain *d,
 	irq_hw_number_t hwirq;
 	unsigned int type =3D IRQ_TYPE_NONE;
 	struct irq_fwspec *fwspec =3D data;
-	void *parent_arg;
+	union gpio_irq_fwspec gpio_parent_fwspec =3D {};
 	unsigned int parent_hwirq;
 	unsigned int parent_type;
 	struct gpio_irq_chip *girq =3D &gc->irq;
@@ -1147,14 +1147,15 @@ static int gpiochip_hierarchy_irq_domain_alloc(struct=
 irq_domain *d,
 	irq_set_probe(irq);
=20
 	/* This parent only handles asserted level IRQs */
-	parent_arg =3D girq->populate_parent_alloc_arg(gc, parent_hwirq, parent_typ=
e);
-	if (!parent_arg)
-		return -ENOMEM;
+	ret =3D girq->populate_parent_alloc_arg(gc, &gpio_parent_fwspec,
+					      parent_hwirq, parent_type);
+	if (ret)
+		return ret;
=20
 	chip_dbg(gc, "alloc_irqs_parent for %d parent hwirq %d\n",
 		  irq, parent_hwirq);
 	irq_set_lockdep_class(irq, gc->irq.lock_key, gc->irq.request_key);
-	ret =3D irq_domain_alloc_irqs_parent(d, irq, 1, parent_arg);
+	ret =3D irq_domain_alloc_irqs_parent(d, irq, 1, &gpio_parent_fwspec);
 	/*
 	 * If the parent irqdomain is msi, the interrupts have already
 	 * been allocated, so the EEXIST is good.
@@ -1166,7 +1167,6 @@ static int gpiochip_hierarchy_irq_domain_alloc(struct i=
rq_domain *d,
 			 "failed to allocate parent hwirq %d for hwirq %lu\n",
 			 parent_hwirq, hwirq);
=20
-	kfree(parent_arg);
 	return ret;
 }
=20
@@ -1181,15 +1181,18 @@ static void gpiochip_hierarchy_setup_domain_ops(struc=
t irq_domain_ops *ops)
 	ops->activate =3D gpiochip_irq_domain_activate;
 	ops->deactivate =3D gpiochip_irq_domain_deactivate;
 	ops->alloc =3D gpiochip_hierarchy_irq_domain_alloc;
-	ops->free =3D irq_domain_free_irqs_common;
=20
 	/*
-	 * We only allow overriding the translate() function for
+	 * We only allow overriding the translate() and free() functions for
 	 * hierarchical chips, and this should only be done if the user
-	 * really need something other than 1:1 translation.
+	 * really need something other than 1:1 translation for translate()
+	 * callback and free if user wants to free up any resources which
+	 * were allocated during callbacks, for example populate_parent_alloc_arg.
 	 */
 	if (!ops->translate)
 		ops->translate =3D gpiochip_hierarchy_irq_domain_translate;
+	if (!ops->free)
+		ops->free =3D irq_domain_free_irqs_common;
 }
=20
 static int gpiochip_hierarchy_add_domain(struct gpio_chip *gc)
@@ -1230,34 +1233,28 @@ static bool gpiochip_hierarchy_is_hierarchical(struct=
 gpio_chip *gc)
 	return !!gc->irq.parent_domain;
 }
=20
-void *gpiochip_populate_parent_fwspec_twocell(struct gpio_chip *gc,
-					     unsigned int parent_hwirq,
-					     unsigned int parent_type)
+int gpiochip_populate_parent_fwspec_twocell(struct gpio_chip *gc,
+					    union gpio_irq_fwspec *gfwspec,
+					    unsigned int parent_hwirq,
+					    unsigned int parent_type)
 {
-	struct irq_fwspec *fwspec;
-
-	fwspec =3D kmalloc(sizeof(*fwspec), GFP_KERNEL);
-	if (!fwspec)
-		return NULL;
+	struct irq_fwspec *fwspec =3D &gfwspec->fwspec;
=20
 	fwspec->fwnode =3D gc->irq.parent_domain->fwnode;
 	fwspec->param_count =3D 2;
 	fwspec->param[0] =3D parent_hwirq;
 	fwspec->param[1] =3D parent_type;
=20
-	return fwspec;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(gpiochip_populate_parent_fwspec_twocell);
=20
-void *gpiochip_populate_parent_fwspec_fourcell(struct gpio_chip *gc,
-					      unsigned int parent_hwirq,
-					      unsigned int parent_type)
+int gpiochip_populate_parent_fwspec_fourcell(struct gpio_chip *gc,
+					     union gpio_irq_fwspec *gfwspec,
+					     unsigned int parent_hwirq,
+					     unsigned int parent_type)
 {
-	struct irq_fwspec *fwspec;
-
-	fwspec =3D kmalloc(sizeof(*fwspec), GFP_KERNEL);
-	if (!fwspec)
-		return NULL;
+	struct irq_fwspec *fwspec =3D &gfwspec->fwspec;
=20
 	fwspec->fwnode =3D gc->irq.parent_domain->fwnode;
 	fwspec->param_count =3D 4;
@@ -1266,7 +1263,7 @@ void *gpiochip_populate_parent_fwspec_fourcell(struct g=
pio_chip *gc,
 	fwspec->param[2] =3D 0;
 	fwspec->param[3] =3D parent_type;
=20
-	return fwspec;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(gpiochip_populate_parent_fwspec_fourcell);
=20
diff --git a/drivers/iommu/hyperv-iommu.c b/drivers/iommu/hyperv-iommu.c
index e285a220c913..51bd66a45a11 100644
--- a/drivers/iommu/hyperv-iommu.c
+++ b/drivers/iommu/hyperv-iommu.c
@@ -194,7 +194,7 @@ hyperv_root_ir_compose_msi_msg(struct irq_data *irq_data,=
 struct msi_msg *msg)
 	u32 vector;
 	struct irq_cfg *cfg;
 	int ioapic_id;
-	struct cpumask *affinity;
+	const struct cpumask *affinity;
 	int cpu;
 	struct hv_interrupt_entry entry;
 	struct hyperv_root_ir_data *data =3D irq_data->chip_data;
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 1f23a6be7d88..7d5b17c54a58 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -8,7 +8,7 @@ config IRQCHIP
 config ARM_GIC
 	bool
 	select IRQ_DOMAIN_HIERARCHY
-	select GENERIC_IRQ_EFFECTIVE_AFF_MASK
+	select GENERIC_IRQ_EFFECTIVE_AFF_MASK if SMP
=20
 config ARM_GIC_PM
 	bool
@@ -34,7 +34,7 @@ config ARM_GIC_V3
 	bool
 	select IRQ_DOMAIN_HIERARCHY
 	select PARTITION_PERCPU
-	select GENERIC_IRQ_EFFECTIVE_AFF_MASK
+	select GENERIC_IRQ_EFFECTIVE_AFF_MASK if SMP
=20
 config ARM_GIC_V3_ITS
 	bool
@@ -76,7 +76,7 @@ config ARMADA_370_XP_IRQ
 	bool
 	select GENERIC_IRQ_CHIP
 	select PCI_MSI if PCI
-	select GENERIC_IRQ_EFFECTIVE_AFF_MASK
+	select GENERIC_IRQ_EFFECTIVE_AFF_MASK if SMP
=20
 config ALPINE_MSI
 	bool
@@ -112,7 +112,7 @@ config BCM6345_L1_IRQ
 	bool
 	select GENERIC_IRQ_CHIP
 	select IRQ_DOMAIN
-	select GENERIC_IRQ_EFFECTIVE_AFF_MASK
+	select GENERIC_IRQ_EFFECTIVE_AFF_MASK if SMP
=20
 config BCM7038_L1_IRQ
 	tristate "Broadcom STB 7038-style L1/L2 interrupt controller driver"
@@ -120,7 +120,7 @@ config BCM7038_L1_IRQ
 	default ARCH_BRCMSTB || BMIPS_GENERIC
 	select GENERIC_IRQ_CHIP
 	select IRQ_DOMAIN
-	select GENERIC_IRQ_EFFECTIVE_AFF_MASK
+	select GENERIC_IRQ_EFFECTIVE_AFF_MASK if SMP
=20
 config BCM7120_L2_IRQ
 	tristate "Broadcom STB 7120-style L2 interrupt controller driver"
@@ -177,9 +177,9 @@ config MADERA_IRQ
 config IRQ_MIPS_CPU
 	bool
 	select GENERIC_IRQ_CHIP
-	select GENERIC_IRQ_IPI if SYS_SUPPORTS_MULTITHREADING
+	select GENERIC_IRQ_IPI if SMP && SYS_SUPPORTS_MULTITHREADING
 	select IRQ_DOMAIN
-	select GENERIC_IRQ_EFFECTIVE_AFF_MASK
+	select GENERIC_IRQ_EFFECTIVE_AFF_MASK if SMP
=20
 config CLPS711X_IRQCHIP
 	bool
@@ -242,6 +242,14 @@ config RENESAS_RZA1_IRQC
 	  Enable support for the Renesas RZ/A1 Interrupt Controller, to use up
 	  to 8 external interrupts with configurable sense select.
=20
+config RENESAS_RZG2L_IRQC
+	bool "Renesas RZ/G2L (and alike SoC) IRQC support" if COMPILE_TEST
+	select GENERIC_IRQ_CHIP
+	select IRQ_DOMAIN_HIERARCHY
+	help
+	  Enable support for the Renesas RZ/G2L (and alike SoC) Interrupt Controller
+	  for external devices.
+
 config SL28CPLD_INTC
 	bool "Kontron sl28cpld IRQ controller"
 	depends on MFD_SL28CPLD=3Dy || COMPILE_TEST
@@ -294,7 +302,7 @@ config VERSATILE_FPGA_IRQ_NR
 config XTENSA_MX
 	bool
 	select IRQ_DOMAIN
-	select GENERIC_IRQ_EFFECTIVE_AFF_MASK
+	select GENERIC_IRQ_EFFECTIVE_AFF_MASK if SMP
=20
 config XILINX_INTC
 	bool "Xilinx Interrupt Controller IP"
@@ -322,7 +330,8 @@ config KEYSTONE_IRQ
=20
 config MIPS_GIC
 	bool
-	select GENERIC_IRQ_IPI
+	select GENERIC_IRQ_IPI if SMP
+	select IRQ_DOMAIN_HIERARCHY
 	select MIPS_CM
=20
 config INGENIC_IRQ
@@ -530,6 +539,7 @@ config SIFIVE_PLIC
 	bool "SiFive Platform-Level Interrupt Controller"
 	depends on RISCV
 	select IRQ_DOMAIN_HIERARCHY
+	select GENERIC_IRQ_EFFECTIVE_AFF_MASK if SMP
 	help
 	   This enables support for the PLIC chip found in SiFive (and
 	   potentially other) RISC-V systems.  The PLIC controls devices
@@ -546,6 +556,16 @@ config EXYNOS_IRQ_COMBINER
 	  Say yes here to add support for the IRQ combiner devices embedded
 	  in Samsung Exynos chips.
=20
+config IRQ_LOONGARCH_CPU
+	bool
+	select GENERIC_IRQ_CHIP
+	select IRQ_DOMAIN
+	select GENERIC_IRQ_EFFECTIVE_AFF_MASK
+	help
+	  Support for the LoongArch CPU Interrupt Controller. For details of
+	  irq chip hierarchy on LoongArch platforms please read the document
+	  Documentation/loongarch/irq-chip-model.rst.
+
 config LOONGSON_LIOINTC
 	bool "Loongson Local I/O Interrupt Controller"
 	depends on MACH_LOONGSON64
@@ -555,6 +575,16 @@ config LOONGSON_LIOINTC
 	help
 	  Support for the Loongson Local I/O Interrupt Controller.
=20
+config LOONGSON_EIOINTC
+	bool "Loongson Extend I/O Interrupt Controller"
+	depends on LOONGARCH
+	depends on MACH_LOONGSON64
+	default MACH_LOONGSON64
+	select IRQ_DOMAIN_HIERARCHY
+	select GENERIC_IRQ_CHIP
+	help
+	  Support for the Loongson3 Extend I/O Interrupt Vector Controller.
+
 config LOONGSON_HTPIC
 	bool "Loongson3 HyperTransport PIC Controller"
 	depends on MACH_LOONGSON64 && MIPS
@@ -574,7 +604,7 @@ config LOONGSON_HTVEC
=20
 config LOONGSON_PCH_PIC
 	bool "Loongson PCH PIC Controller"
-	depends on MACH_LOONGSON64 || COMPILE_TEST
+	depends on MACH_LOONGSON64
 	default MACH_LOONGSON64
 	select IRQ_DOMAIN_HIERARCHY
 	select IRQ_FASTEOI_HIERARCHY_HANDLERS
@@ -583,7 +613,7 @@ config LOONGSON_PCH_PIC
=20
 config LOONGSON_PCH_MSI
 	bool "Loongson PCH MSI Controller"
-	depends on MACH_LOONGSON64 || COMPILE_TEST
+	depends on MACH_LOONGSON64
 	depends on PCI
 	default MACH_LOONGSON64
 	select IRQ_DOMAIN_HIERARCHY
@@ -591,6 +621,14 @@ config LOONGSON_PCH_MSI
 	help
 	  Support for the Loongson PCH MSI Controller.
=20
+config LOONGSON_PCH_LPC
+	bool "Loongson PCH LPC Controller"
+	depends on MACH_LOONGSON64
+	default (MACH_LOONGSON64 && LOONGARCH)
+	select IRQ_DOMAIN_HIERARCHY
+	help
+	  Support for the Loongson PCH LPC Controller.
+
 config MST_IRQ
 	bool "MStar Interrupt Controller"
 	depends on ARCH_MEDIATEK || ARCH_MSTARV7 || COMPILE_TEST
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 5b67450a9538..86450eb11398 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -51,6 +51,7 @@ obj-$(CONFIG_RDA_INTC)			+=3D irq-rda-intc.o
 obj-$(CONFIG_RENESAS_INTC_IRQPIN)	+=3D irq-renesas-intc-irqpin.o
 obj-$(CONFIG_RENESAS_IRQC)		+=3D irq-renesas-irqc.o
 obj-$(CONFIG_RENESAS_RZA1_IRQC)		+=3D irq-renesas-rza1.o
+obj-$(CONFIG_RENESAS_RZG2L_IRQC)	+=3D irq-renesas-rzg2l.o
 obj-$(CONFIG_VERSATILE_FPGA_IRQ)	+=3D irq-versatile-fpga.o
 obj-$(CONFIG_ARCH_NSPIRE)		+=3D irq-zevio.o
 obj-$(CONFIG_ARCH_VT8500)		+=3D irq-vt8500.o
@@ -103,11 +104,14 @@ obj-$(CONFIG_LS1X_IRQ)			+=3D irq-ls1x.o
 obj-$(CONFIG_TI_SCI_INTR_IRQCHIP)	+=3D irq-ti-sci-intr.o
 obj-$(CONFIG_TI_SCI_INTA_IRQCHIP)	+=3D irq-ti-sci-inta.o
 obj-$(CONFIG_TI_PRUSS_INTC)		+=3D irq-pruss-intc.o
+obj-$(CONFIG_IRQ_LOONGARCH_CPU)		+=3D irq-loongarch-cpu.o
 obj-$(CONFIG_LOONGSON_LIOINTC)		+=3D irq-loongson-liointc.o
+obj-$(CONFIG_LOONGSON_EIOINTC)		+=3D irq-loongson-eiointc.o
 obj-$(CONFIG_LOONGSON_HTPIC)		+=3D irq-loongson-htpic.o
 obj-$(CONFIG_LOONGSON_HTVEC)		+=3D irq-loongson-htvec.o
 obj-$(CONFIG_LOONGSON_PCH_PIC)		+=3D irq-loongson-pch-pic.o
 obj-$(CONFIG_LOONGSON_PCH_MSI)		+=3D irq-loongson-pch-msi.o
+obj-$(CONFIG_LOONGSON_PCH_LPC)		+=3D irq-loongson-pch-lpc.o
 obj-$(CONFIG_MST_IRQ)			+=3D irq-mst-intc.o
 obj-$(CONFIG_SL28CPLD_INTC)		+=3D irq-sl28cpld.o
 obj-$(CONFIG_MACH_REALTEK_RTL)		+=3D irq-realtek-rtl.o
diff --git a/drivers/irqchip/irq-bcm6345-l1.c b/drivers/irqchip/irq-bcm6345-l=
1.c
index 142a7431745f..6899e37810a8 100644
--- a/drivers/irqchip/irq-bcm6345-l1.c
+++ b/drivers/irqchip/irq-bcm6345-l1.c
@@ -216,11 +216,11 @@ static int bcm6345_l1_set_affinity(struct irq_data *d,
 		enabled =3D intc->cpus[old_cpu]->enable_cache[word] & mask;
 		if (enabled)
 			__bcm6345_l1_mask(d);
-		cpumask_copy(irq_data_get_affinity_mask(d), dest);
+		irq_data_update_affinity(d, dest);
 		if (enabled)
 			__bcm6345_l1_unmask(d);
 	} else {
-		cpumask_copy(irq_data_get_affinity_mask(d), dest);
+		irq_data_update_affinity(d, dest);
 	}
 	raw_spin_unlock_irqrestore(&intc->lock, flags);
=20
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 5c1cf907ee68..34702e698d72 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -1783,7 +1783,7 @@ static void gic_enable_nmi_support(void)
 	 * the security state of the GIC (controlled by the GICD_CTRL.DS bit)
 	 * and if Group 0 interrupts can be delivered to Linux in the non-secure
 	 * world as FIQs (controlled by the SCR_EL3.FIQ bit). These affect the
-	 * the ICC_PMR_EL1 register and the priority that software assigns to
+	 * ICC_PMR_EL1 register and the priority that software assigns to
 	 * interrupts:
 	 *
 	 * GICD_CTRL.DS | SCR_EL3.FIQ | ICC_PMR_EL1 | Group 1 priority
@@ -2360,11 +2360,17 @@ static void __init gic_acpi_setup_kvm_info(void)
 	vgic_set_kvm_info(&gic_v3_kvm_info);
 }
=20
+static struct fwnode_handle *gsi_domain_handle;
+
+static struct fwnode_handle *gic_v3_get_gsi_domain_id(u32 gsi)
+{
+	return gsi_domain_handle;
+}
+
 static int __init
 gic_acpi_init(union acpi_subtable_headers *header, const unsigned long end)
 {
 	struct acpi_madt_generic_distributor *dist;
-	struct fwnode_handle *domain_handle;
 	size_t size;
 	int i, err;
=20
@@ -2396,18 +2402,18 @@ gic_acpi_init(union acpi_subtable_headers *header, co=
nst unsigned long end)
 	if (err)
 		goto out_redist_unmap;
=20
-	domain_handle =3D irq_domain_alloc_fwnode(&dist->base_address);
-	if (!domain_handle) {
+	gsi_domain_handle =3D irq_domain_alloc_fwnode(&dist->base_address);
+	if (!gsi_domain_handle) {
 		err =3D -ENOMEM;
 		goto out_redist_unmap;
 	}
=20
 	err =3D gic_init_bases(acpi_data.dist_base, acpi_data.redist_regs,
-			     acpi_data.nr_redist_regions, 0, domain_handle);
+			     acpi_data.nr_redist_regions, 0, gsi_domain_handle);
 	if (err)
 		goto out_fwhandle_free;
=20
-	acpi_set_irq_model(ACPI_IRQ_MODEL_GIC, domain_handle);
+	acpi_set_irq_model(ACPI_IRQ_MODEL_GIC, gic_v3_get_gsi_domain_id);
=20
 	if (static_branch_likely(&supports_deactivate_key))
 		gic_acpi_setup_kvm_info();
@@ -2415,7 +2421,7 @@ gic_acpi_init(union acpi_subtable_headers *header, cons=
t unsigned long end)
 	return 0;
=20
 out_fwhandle_free:
-	irq_domain_free_fwnode(domain_handle);
+	irq_domain_free_fwnode(gsi_domain_handle);
 out_redist_unmap:
 	for (i =3D 0; i < acpi_data.nr_redist_regions; i++)
 		if (acpi_data.redist_regs[i].redist_base)
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 820404cb56bc..4c7bae0ec8f9 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -1682,11 +1682,17 @@ static void __init gic_acpi_setup_kvm_info(void)
 	vgic_set_kvm_info(&gic_v2_kvm_info);
 }
=20
+static struct fwnode_handle *gsi_domain_handle;
+
+static struct fwnode_handle *gic_v2_get_gsi_domain_id(u32 gsi)
+{
+	return gsi_domain_handle;
+}
+
 static int __init gic_v2_acpi_init(union acpi_subtable_headers *header,
 				   const unsigned long end)
 {
 	struct acpi_madt_generic_distributor *dist;
-	struct fwnode_handle *domain_handle;
 	struct gic_chip_data *gic =3D &gic_data[0];
 	int count, ret;
=20
@@ -1724,22 +1730,22 @@ static int __init gic_v2_acpi_init(union acpi_subtabl=
e_headers *header,
 	/*
 	 * Initialize GIC instance zero (no multi-GIC support).
 	 */
-	domain_handle =3D irq_domain_alloc_fwnode(&dist->base_address);
-	if (!domain_handle) {
+	gsi_domain_handle =3D irq_domain_alloc_fwnode(&dist->base_address);
+	if (!gsi_domain_handle) {
 		pr_err("Unable to allocate domain handle\n");
 		gic_teardown(gic);
 		return -ENOMEM;
 	}
=20
-	ret =3D __gic_init_bases(gic, domain_handle);
+	ret =3D __gic_init_bases(gic, gsi_domain_handle);
 	if (ret) {
 		pr_err("Failed to initialise GIC\n");
-		irq_domain_free_fwnode(domain_handle);
+		irq_domain_free_fwnode(gsi_domain_handle);
 		gic_teardown(gic);
 		return ret;
 	}
=20
-	acpi_set_irq_model(ACPI_IRQ_MODEL_GIC, domain_handle);
+	acpi_set_irq_model(ACPI_IRQ_MODEL_GIC, gic_v2_get_gsi_domain_id);
=20
 	if (IS_ENABLED(CONFIG_ARM_GIC_V2M))
 		gicv2m_init(NULL, gic_data[0].domain);
diff --git a/drivers/irqchip/irq-loongarch-cpu.c b/drivers/irqchip/irq-loonga=
rch-cpu.c
new file mode 100644
index 000000000000..327f3ab62c03
--- /dev/null
+++ b/drivers/irqchip/irq-loongarch-cpu.c
@@ -0,0 +1,148 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/irqdomain.h>
+
+#include <asm/loongarch.h>
+#include <asm/setup.h>
+
+static struct irq_domain *irq_domain;
+struct fwnode_handle *cpuintc_handle;
+
+static u32 lpic_gsi_to_irq(u32 gsi)
+{
+	/* Only pch irqdomain transferring is required for LoongArch. */
+	if (gsi >=3D GSI_MIN_PCH_IRQ && gsi <=3D GSI_MAX_PCH_IRQ)
+		return acpi_register_gsi(NULL, gsi, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_HIGH=
);
+
+	return 0;
+}
+
+static struct fwnode_handle *lpic_get_gsi_domain_id(u32 gsi)
+{
+	int id;
+	struct fwnode_handle *domain_handle =3D NULL;
+
+	switch (gsi) {
+	case GSI_MIN_CPU_IRQ ... GSI_MAX_CPU_IRQ:
+		if (liointc_handle)
+			domain_handle =3D liointc_handle;
+		break;
+
+	case GSI_MIN_LPC_IRQ ... GSI_MAX_LPC_IRQ:
+		if (pch_lpc_handle)
+			domain_handle =3D pch_lpc_handle;
+		break;
+
+	case GSI_MIN_PCH_IRQ ... GSI_MAX_PCH_IRQ:
+		id =3D find_pch_pic(gsi);
+		if (id >=3D 0 && pch_pic_handle[id])
+			domain_handle =3D pch_pic_handle[id];
+		break;
+	}
+
+	return domain_handle;
+}
+
+static void mask_loongarch_irq(struct irq_data *d)
+{
+	clear_csr_ecfg(ECFGF(d->hwirq));
+}
+
+static void unmask_loongarch_irq(struct irq_data *d)
+{
+	set_csr_ecfg(ECFGF(d->hwirq));
+}
+
+static struct irq_chip cpu_irq_controller =3D {
+	.name		=3D "CPUINTC",
+	.irq_mask	=3D mask_loongarch_irq,
+	.irq_unmask	=3D unmask_loongarch_irq,
+};
+
+static void handle_cpu_irq(struct pt_regs *regs)
+{
+	int hwirq;
+	unsigned int estat =3D read_csr_estat() & CSR_ESTAT_IS;
+
+	while ((hwirq =3D ffs(estat))) {
+		estat &=3D ~BIT(hwirq - 1);
+		generic_handle_domain_irq(irq_domain, hwirq - 1);
+	}
+}
+
+static int loongarch_cpu_intc_map(struct irq_domain *d, unsigned int irq,
+			     irq_hw_number_t hwirq)
+{
+	irq_set_noprobe(irq);
+	irq_set_chip_and_handler(irq, &cpu_irq_controller, handle_percpu_irq);
+
+	return 0;
+}
+
+static const struct irq_domain_ops loongarch_cpu_intc_irq_domain_ops =3D {
+	.map =3D loongarch_cpu_intc_map,
+	.xlate =3D irq_domain_xlate_onecell,
+};
+
+static int __init
+liointc_parse_madt(union acpi_subtable_headers *header,
+		       const unsigned long end)
+{
+	struct acpi_madt_lio_pic *liointc_entry =3D (struct acpi_madt_lio_pic *)hea=
der;
+
+	return liointc_acpi_init(irq_domain, liointc_entry);
+}
+
+static int __init
+eiointc_parse_madt(union acpi_subtable_headers *header,
+		       const unsigned long end)
+{
+	struct acpi_madt_eio_pic *eiointc_entry =3D (struct acpi_madt_eio_pic *)hea=
der;
+
+	return eiointc_acpi_init(irq_domain, eiointc_entry);
+}
+
+static int __init acpi_cascade_irqdomain_init(void)
+{
+	acpi_table_parse_madt(ACPI_MADT_TYPE_LIO_PIC,
+			      liointc_parse_madt, 0);
+	acpi_table_parse_madt(ACPI_MADT_TYPE_EIO_PIC,
+			      eiointc_parse_madt, 0);
+	return 0;
+}
+
+static int __init cpuintc_acpi_init(union acpi_subtable_headers *header,
+				   const unsigned long end)
+{
+	if (irq_domain)
+		return 0;
+
+	/* Mask interrupts. */
+	clear_csr_ecfg(ECFG0_IM);
+	clear_csr_estat(ESTATF_IP);
+
+	cpuintc_handle =3D irq_domain_alloc_fwnode(NULL);
+	irq_domain =3D irq_domain_create_linear(cpuintc_handle, EXCCODE_INT_NUM,
+					&loongarch_cpu_intc_irq_domain_ops, NULL);
+
+	if (!irq_domain)
+		panic("Failed to add irqdomain for LoongArch CPU");
+
+	set_handle_irq(&handle_cpu_irq);
+	acpi_set_irq_model(ACPI_IRQ_MODEL_LPIC, lpic_get_gsi_domain_id);
+	acpi_set_gsi_to_irq_fallback(lpic_gsi_to_irq);
+	acpi_cascade_irqdomain_init();
+
+	return 0;
+}
+
+IRQCHIP_ACPI_DECLARE(cpuintc_v1, ACPI_MADT_TYPE_CORE_PIC,
+		NULL, ACPI_MADT_CORE_PIC_VERSION_V1, cpuintc_acpi_init);
diff --git a/drivers/irqchip/irq-loongson-eiointc.c b/drivers/irqchip/irq-loo=
ngson-eiointc.c
new file mode 100644
index 000000000000..80d8ca6f2d46
--- /dev/null
+++ b/drivers/irqchip/irq-loongson-eiointc.c
@@ -0,0 +1,395 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Loongson Extend I/O Interrupt Controller support
+ *
+ * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
+ */
+
+#define pr_fmt(fmt) "eiointc: " fmt
+
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/irqdomain.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/of_platform.h>
+
+#define EIOINTC_REG_NODEMAP	0x14a0
+#define EIOINTC_REG_IPMAP	0x14c0
+#define EIOINTC_REG_ENABLE	0x1600
+#define EIOINTC_REG_BOUNCE	0x1680
+#define EIOINTC_REG_ISR		0x1800
+#define EIOINTC_REG_ROUTE	0x1c00
+
+#define VEC_REG_COUNT		4
+#define VEC_COUNT_PER_REG	64
+#define VEC_COUNT		(VEC_REG_COUNT * VEC_COUNT_PER_REG)
+#define VEC_REG_IDX(irq_id)	((irq_id) / VEC_COUNT_PER_REG)
+#define VEC_REG_BIT(irq_id)     ((irq_id) % VEC_COUNT_PER_REG)
+#define EIOINTC_ALL_ENABLE	0xffffffff
+
+#define MAX_EIO_NODES		(NR_CPUS / CORES_PER_EIO_NODE)
+
+static int nr_pics;
+
+struct eiointc_priv {
+	u32			node;
+	nodemask_t		node_map;
+	cpumask_t		cpuspan_map;
+	struct fwnode_handle	*domain_handle;
+	struct irq_domain	*eiointc_domain;
+};
+
+static struct eiointc_priv *eiointc_priv[MAX_IO_PICS];
+
+static void eiointc_enable(void)
+{
+	uint64_t misc;
+
+	misc =3D iocsr_read64(LOONGARCH_IOCSR_MISC_FUNC);
+	misc |=3D IOCSR_MISC_FUNC_EXT_IOI_EN;
+	iocsr_write64(misc, LOONGARCH_IOCSR_MISC_FUNC);
+}
+
+static int cpu_to_eio_node(int cpu)
+{
+	return cpu_logical_map(cpu) / CORES_PER_EIO_NODE;
+}
+
+static void eiointc_set_irq_route(int pos, unsigned int cpu, unsigned int mn=
ode, nodemask_t *node_map)
+{
+	int i, node, cpu_node, route_node;
+	unsigned char coremap;
+	uint32_t pos_off, data, data_byte, data_mask;
+
+	pos_off =3D pos & ~3;
+	data_byte =3D pos & 3;
+	data_mask =3D ~BIT_MASK(data_byte) & 0xf;
+
+	/* Calculate node and coremap of target irq */
+	cpu_node =3D cpu_logical_map(cpu) / CORES_PER_EIO_NODE;
+	coremap =3D BIT(cpu_logical_map(cpu) % CORES_PER_EIO_NODE);
+
+	for_each_online_cpu(i) {
+		node =3D cpu_to_eio_node(i);
+		if (!node_isset(node, *node_map))
+			continue;
+
+		/* EIO node 0 is in charge of inter-node interrupt dispatch */
+		route_node =3D (node =3D=3D mnode) ? cpu_node : node;
+		data =3D ((coremap | (route_node << 4)) << (data_byte * 8));
+		csr_any_send(EIOINTC_REG_ROUTE + pos_off, data, data_mask, node * CORES_PE=
R_EIO_NODE);
+	}
+}
+
+static DEFINE_RAW_SPINLOCK(affinity_lock);
+
+static int eiointc_set_irq_affinity(struct irq_data *d, const struct cpumask=
 *affinity, bool force)
+{
+	unsigned int cpu;
+	unsigned long flags;
+	uint32_t vector, regaddr;
+	struct cpumask intersect_affinity;
+	struct eiointc_priv *priv =3D d->domain->host_data;
+
+	raw_spin_lock_irqsave(&affinity_lock, flags);
+
+	cpumask_and(&intersect_affinity, affinity, cpu_online_mask);
+	cpumask_and(&intersect_affinity, &intersect_affinity, &priv->cpuspan_map);
+
+	if (cpumask_empty(&intersect_affinity)) {
+		raw_spin_unlock_irqrestore(&affinity_lock, flags);
+		return -EINVAL;
+	}
+	cpu =3D cpumask_first(&intersect_affinity);
+
+	vector =3D d->hwirq;
+	regaddr =3D EIOINTC_REG_ENABLE + ((vector >> 5) << 2);
+
+	/* Mask target vector */
+	csr_any_send(regaddr, EIOINTC_ALL_ENABLE & (~BIT(vector & 0x1F)), 0x0, 0);
+	/* Set route for target vector */
+	eiointc_set_irq_route(vector, cpu, priv->node, &priv->node_map);
+	/* Unmask target vector */
+	csr_any_send(regaddr, EIOINTC_ALL_ENABLE, 0x0, 0);
+
+	irq_data_update_effective_affinity(d, cpumask_of(cpu));
+
+	raw_spin_unlock_irqrestore(&affinity_lock, flags);
+
+	return IRQ_SET_MASK_OK;
+}
+
+static int eiointc_index(int node)
+{
+	int i;
+
+	for (i =3D 0; i < nr_pics; i++) {
+		if (node_isset(node, eiointc_priv[i]->node_map))
+			return i;
+	}
+
+	return -1;
+}
+
+static int eiointc_router_init(unsigned int cpu)
+{
+	int i, bit;
+	uint32_t data;
+	uint32_t node =3D cpu_to_eio_node(cpu);
+	uint32_t index =3D eiointc_index(node);
+
+	if (index < 0) {
+		pr_err("Error: invalid nodemap!\n");
+		return -1;
+	}
+
+	if ((cpu_logical_map(cpu) % CORES_PER_EIO_NODE) =3D=3D 0) {
+		eiointc_enable();
+
+		for (i =3D 0; i < VEC_COUNT / 32; i++) {
+			data =3D (((1 << (i * 2 + 1)) << 16) | (1 << (i * 2)));
+			iocsr_write32(data, EIOINTC_REG_NODEMAP + i * 4);
+		}
+
+		for (i =3D 0; i < VEC_COUNT / 32 / 4; i++) {
+			bit =3D BIT(1 + index); /* Route to IP[1 + index] */
+			data =3D bit | (bit << 8) | (bit << 16) | (bit << 24);
+			iocsr_write32(data, EIOINTC_REG_IPMAP + i * 4);
+		}
+
+		for (i =3D 0; i < VEC_COUNT / 4; i++) {
+			/* Route to Node-0 Core-0 */
+			if (index =3D=3D 0)
+				bit =3D BIT(cpu_logical_map(0));
+			else
+				bit =3D (eiointc_priv[index]->node << 4) | 1;
+
+			data =3D bit | (bit << 8) | (bit << 16) | (bit << 24);
+			iocsr_write32(data, EIOINTC_REG_ROUTE + i * 4);
+		}
+
+		for (i =3D 0; i < VEC_COUNT / 32; i++) {
+			data =3D 0xffffffff;
+			iocsr_write32(data, EIOINTC_REG_ENABLE + i * 4);
+			iocsr_write32(data, EIOINTC_REG_BOUNCE + i * 4);
+		}
+	}
+
+	return 0;
+}
+
+static void eiointc_irq_dispatch(struct irq_desc *desc)
+{
+	int i;
+	u64 pending;
+	bool handled =3D false;
+	struct irq_chip *chip =3D irq_desc_get_chip(desc);
+	struct eiointc_priv *priv =3D irq_desc_get_handler_data(desc);
+
+	chained_irq_enter(chip, desc);
+
+	for (i =3D 0; i < VEC_REG_COUNT; i++) {
+		pending =3D iocsr_read64(EIOINTC_REG_ISR + (i << 3));
+		iocsr_write64(pending, EIOINTC_REG_ISR + (i << 3));
+		while (pending) {
+			int bit =3D __ffs(pending);
+			int irq =3D bit + VEC_COUNT_PER_REG * i;
+
+			generic_handle_domain_irq(priv->eiointc_domain, irq);
+			pending &=3D ~BIT(bit);
+			handled =3D true;
+		}
+	}
+
+	if (!handled)
+		spurious_interrupt();
+
+	chained_irq_exit(chip, desc);
+}
+
+static void eiointc_ack_irq(struct irq_data *d)
+{
+}
+
+static void eiointc_mask_irq(struct irq_data *d)
+{
+}
+
+static void eiointc_unmask_irq(struct irq_data *d)
+{
+}
+
+static struct irq_chip eiointc_irq_chip =3D {
+	.name			=3D "EIOINTC",
+	.irq_ack		=3D eiointc_ack_irq,
+	.irq_mask		=3D eiointc_mask_irq,
+	.irq_unmask		=3D eiointc_unmask_irq,
+	.irq_set_affinity	=3D eiointc_set_irq_affinity,
+};
+
+static int eiointc_domain_alloc(struct irq_domain *domain, unsigned int virq,
+				unsigned int nr_irqs, void *arg)
+{
+	int ret;
+	unsigned int i, type;
+	unsigned long hwirq =3D 0;
+	struct eiointc *priv =3D domain->host_data;
+
+	ret =3D irq_domain_translate_onecell(domain, arg, &hwirq, &type);
+	if (ret)
+		return ret;
+
+	for (i =3D 0; i < nr_irqs; i++) {
+		irq_domain_set_info(domain, virq + i, hwirq + i, &eiointc_irq_chip,
+					priv, handle_edge_irq, NULL, NULL);
+	}
+
+	return 0;
+}
+
+static void eiointc_domain_free(struct irq_domain *domain, unsigned int virq,
+				unsigned int nr_irqs)
+{
+	int i;
+
+	for (i =3D 0; i < nr_irqs; i++) {
+		struct irq_data *d =3D irq_domain_get_irq_data(domain, virq + i);
+
+		irq_set_handler(virq + i, NULL);
+		irq_domain_reset_irq_data(d);
+	}
+}
+
+static const struct irq_domain_ops eiointc_domain_ops =3D {
+	.translate	=3D irq_domain_translate_onecell,
+	.alloc		=3D eiointc_domain_alloc,
+	.free		=3D eiointc_domain_free,
+};
+
+static void acpi_set_vec_parent(int node, struct irq_domain *parent, struct =
acpi_vector_group *vec_group)
+{
+	int i;
+
+	if (cpu_has_flatmode)
+		node =3D cpu_to_node(node * CORES_PER_EIO_NODE);
+
+	for (i =3D 0; i < MAX_IO_PICS; i++) {
+		if (node =3D=3D vec_group[i].node) {
+			vec_group[i].parent =3D parent;
+			return;
+		}
+	}
+}
+
+struct irq_domain *acpi_get_vec_parent(int node, struct acpi_vector_group *v=
ec_group)
+{
+	int i;
+
+	for (i =3D 0; i < MAX_IO_PICS; i++) {
+		if (node =3D=3D vec_group[i].node)
+			return vec_group[i].parent;
+	}
+	return NULL;
+}
+
+static int __init
+pch_pic_parse_madt(union acpi_subtable_headers *header,
+		       const unsigned long end)
+{
+	struct acpi_madt_bio_pic *pchpic_entry =3D (struct acpi_madt_bio_pic *)head=
er;
+	unsigned int node =3D (pchpic_entry->address >> 44) & 0xf;
+	struct irq_domain *parent =3D acpi_get_vec_parent(node, pch_group);
+
+	if (parent)
+		return pch_pic_acpi_init(parent, pchpic_entry);
+
+	return -EINVAL;
+}
+
+static int __init
+pch_msi_parse_madt(union acpi_subtable_headers *header,
+		       const unsigned long end)
+{
+	struct acpi_madt_msi_pic *pchmsi_entry =3D (struct acpi_madt_msi_pic *)head=
er;
+	struct irq_domain *parent =3D acpi_get_vec_parent(eiointc_priv[nr_pics - 1]=
->node, msi_group);
+
+	if (parent)
+		return pch_msi_acpi_init(parent, pchmsi_entry);
+
+	return -EINVAL;
+}
+
+static int __init acpi_cascade_irqdomain_init(void)
+{
+	acpi_table_parse_madt(ACPI_MADT_TYPE_BIO_PIC,
+			      pch_pic_parse_madt, 0);
+	acpi_table_parse_madt(ACPI_MADT_TYPE_MSI_PIC,
+			      pch_msi_parse_madt, 1);
+	return 0;
+}
+
+int __init eiointc_acpi_init(struct irq_domain *parent,
+				     struct acpi_madt_eio_pic *acpi_eiointc)
+{
+	int i, parent_irq;
+	unsigned long node_map;
+	struct eiointc_priv *priv;
+
+	priv =3D kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->domain_handle =3D irq_domain_alloc_fwnode((phys_addr_t *)acpi_eiointc=
);
+	if (!priv->domain_handle) {
+		pr_err("Unable to allocate domain handle\n");
+		goto out_free_priv;
+	}
+
+	priv->node =3D acpi_eiointc->node;
+	node_map =3D acpi_eiointc->node_map ? : -1ULL;
+
+	for_each_possible_cpu(i) {
+		if (node_map & (1ULL << cpu_to_eio_node(i))) {
+			node_set(cpu_to_eio_node(i), priv->node_map);
+			cpumask_or(&priv->cpuspan_map, &priv->cpuspan_map, cpumask_of(i));
+		}
+	}
+
+	/* Setup IRQ domain */
+	priv->eiointc_domain =3D irq_domain_create_linear(priv->domain_handle, VEC_=
COUNT,
+					&eiointc_domain_ops, priv);
+	if (!priv->eiointc_domain) {
+		pr_err("loongson-eiointc: cannot add IRQ domain\n");
+		goto out_free_handle;
+	}
+
+	eiointc_priv[nr_pics++] =3D priv;
+
+	eiointc_router_init(0);
+
+	parent_irq =3D irq_create_mapping(parent, acpi_eiointc->cascade);
+	irq_set_chained_handler_and_data(parent_irq, eiointc_irq_dispatch, priv);
+
+	cpuhp_setup_state_nocalls(CPUHP_AP_IRQ_LOONGARCH_STARTING,
+				  "irqchip/loongarch/intc:starting",
+				  eiointc_router_init, NULL);
+
+	acpi_set_vec_parent(acpi_eiointc->node, priv->eiointc_domain, pch_group);
+	acpi_set_vec_parent(acpi_eiointc->node, priv->eiointc_domain, msi_group);
+	acpi_cascade_irqdomain_init();
+
+	return 0;
+
+out_free_handle:
+	irq_domain_free_fwnode(priv->domain_handle);
+	priv->domain_handle =3D NULL;
+out_free_priv:
+	kfree(priv);
+
+	return -ENOMEM;
+}
diff --git a/drivers/irqchip/irq-loongson-liointc.c b/drivers/irqchip/irq-loo=
ngson-liointc.c
index 8d05d8bcf56f..c4f3c886ad61 100644
--- a/drivers/irqchip/irq-loongson-liointc.c
+++ b/drivers/irqchip/irq-loongson-liointc.c
@@ -23,7 +23,7 @@
 #endif
=20
 #define LIOINTC_CHIP_IRQ	32
-#define LIOINTC_NUM_PARENT 4
+#define LIOINTC_NUM_PARENT	4
 #define LIOINTC_NUM_CORES	4
=20
 #define LIOINTC_INTC_CHIP_START	0x20
@@ -58,6 +58,8 @@ struct liointc_priv {
 	bool				has_lpc_irq_errata;
 };
=20
+struct fwnode_handle *liointc_handle;
+
 static void liointc_chained_handle_irq(struct irq_desc *desc)
 {
 	struct liointc_handler_data *handler =3D irq_desc_get_handler_data(desc);
@@ -153,97 +155,79 @@ static void liointc_resume(struct irq_chip_generic *gc)
 	irq_gc_unlock_irqrestore(gc, flags);
 }
=20
-static const char * const parent_names[] =3D {"int0", "int1", "int2", "int3"=
};
-static const char * const core_reg_names[] =3D {"isr0", "isr1", "isr2", "isr=
3"};
+static int parent_irq[LIOINTC_NUM_PARENT];
+static u32 parent_int_map[LIOINTC_NUM_PARENT];
+static const char *const parent_names[] =3D {"int0", "int1", "int2", "int3"};
+static const char *const core_reg_names[] =3D {"isr0", "isr1", "isr2", "isr3=
"};
=20
-static void __iomem *liointc_get_reg_byname(struct device_node *node,
-						const char *name)
+static int liointc_domain_xlate(struct irq_domain *d, struct device_node *ct=
rlr,
+			     const u32 *intspec, unsigned int intsize,
+			     unsigned long *out_hwirq, unsigned int *out_type)
 {
-	int index =3D of_property_match_string(node, "reg-names", name);
-
-	if (index < 0)
-		return NULL;
-
-	return of_iomap(node, index);
+	if (WARN_ON(intsize < 1))
+		return -EINVAL;
+	*out_hwirq =3D intspec[0] - GSI_MIN_CPU_IRQ;
+	*out_type =3D IRQ_TYPE_NONE;
+	return 0;
 }
=20
-static int __init liointc_of_init(struct device_node *node,
-				  struct device_node *parent)
+static const struct irq_domain_ops acpi_irq_gc_ops =3D {
+	.map	=3D irq_map_generic_chip,
+	.unmap  =3D irq_unmap_generic_chip,
+	.xlate	=3D liointc_domain_xlate,
+};
+
+static int liointc_init(phys_addr_t addr, unsigned long size, int revision,
+		struct fwnode_handle *domain_handle, struct device_node *node)
 {
+	int i, err;
+	void __iomem *base;
+	struct irq_chip_type *ct;
 	struct irq_chip_generic *gc;
 	struct irq_domain *domain;
-	struct irq_chip_type *ct;
 	struct liointc_priv *priv;
-	void __iomem *base;
-	u32 of_parent_int_map[LIOINTC_NUM_PARENT];
-	int parent_irq[LIOINTC_NUM_PARENT];
-	bool have_parent =3D FALSE;
-	int sz, i, err =3D 0;
=20
 	priv =3D kzalloc(sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
=20
-	if (of_device_is_compatible(node, "loongson,liointc-2.0")) {
-		base =3D liointc_get_reg_byname(node, "main");
-		if (!base) {
-			err =3D -ENODEV;
-			goto out_free_priv;
-		}
+	base =3D ioremap(addr, size);
+	if (!base)
+		goto out_free_priv;
=20
-		for (i =3D 0; i < LIOINTC_NUM_CORES; i++)
-			priv->core_isr[i] =3D liointc_get_reg_byname(node, core_reg_names[i]);
-		if (!priv->core_isr[0]) {
-			err =3D -ENODEV;
-			goto out_iounmap_base;
-		}
-	} else {
-		base =3D of_iomap(node, 0);
-		if (!base) {
-			err =3D -ENODEV;
-			goto out_free_priv;
-		}
+	for (i =3D 0; i < LIOINTC_NUM_CORES; i++)
+		priv->core_isr[i] =3D base + LIOINTC_REG_INTC_STATUS;
=20
-		for (i =3D 0; i < LIOINTC_NUM_CORES; i++)
-			priv->core_isr[i] =3D base + LIOINTC_REG_INTC_STATUS;
-	}
+	for (i =3D 0; i < LIOINTC_NUM_PARENT; i++)
+		priv->handler[i].parent_int_map =3D parent_int_map[i];
=20
-	for (i =3D 0; i < LIOINTC_NUM_PARENT; i++) {
-		parent_irq[i] =3D of_irq_get_byname(node, parent_names[i]);
-		if (parent_irq[i] > 0)
-			have_parent =3D TRUE;
-	}
-	if (!have_parent) {
-		err =3D -ENODEV;
-		goto out_iounmap_isr;
-	}
+	if (revision > 1) {
+		for (i =3D 0; i < LIOINTC_NUM_CORES; i++) {
+			int index =3D of_property_match_string(node,
+					"reg-names", core_reg_names[i]);
=20
-	sz =3D of_property_read_variable_u32_array(node,
-						"loongson,parent_int_map",
-						&of_parent_int_map[0],
-						LIOINTC_NUM_PARENT,
-						LIOINTC_NUM_PARENT);
-	if (sz < 4) {
-		pr_err("loongson-liointc: No parent_int_map\n");
-		err =3D -ENODEV;
-		goto out_iounmap_isr;
-	}
+			if (index < 0)
+				return -EINVAL;
=20
-	for (i =3D 0; i < LIOINTC_NUM_PARENT; i++)
-		priv->handler[i].parent_int_map =3D of_parent_int_map[i];
+			priv->core_isr[i] =3D of_iomap(node, index);
+		}
+	}
=20
 	/* Setup IRQ domain */
-	domain =3D irq_domain_add_linear(node, 32,
+	if (!acpi_disabled)
+		domain =3D irq_domain_create_linear(domain_handle, LIOINTC_CHIP_IRQ,
+					&acpi_irq_gc_ops, priv);
+	else
+		domain =3D irq_domain_create_linear(domain_handle, LIOINTC_CHIP_IRQ,
 					&irq_generic_chip_ops, priv);
 	if (!domain) {
 		pr_err("loongson-liointc: cannot add IRQ domain\n");
-		err =3D -EINVAL;
-		goto out_iounmap_isr;
+		goto out_iounmap;
 	}
=20
-	err =3D irq_alloc_domain_generic_chips(domain, 32, 1,
-					node->full_name, handle_level_irq,
-					IRQ_NOPROBE, 0, 0);
+	err =3D irq_alloc_domain_generic_chips(domain, LIOINTC_CHIP_IRQ, 1,
+					(node ? node->full_name : "LIOINTC"),
+					handle_level_irq, 0, IRQ_NOPROBE, 0);
 	if (err) {
 		pr_err("loongson-liointc: unable to register IRQ domain\n");
 		goto out_free_domain;
@@ -299,24 +283,93 @@ static int __init liointc_of_init(struct device_node *n=
ode,
 				liointc_chained_handle_irq, &priv->handler[i]);
 	}
=20
+	liointc_handle =3D domain_handle;
 	return 0;
=20
 out_free_domain:
 	irq_domain_remove(domain);
-out_iounmap_isr:
-	for (i =3D 0; i < LIOINTC_NUM_CORES; i++) {
-		if (!priv->core_isr[i])
-			continue;
-		iounmap(priv->core_isr[i]);
-	}
-out_iounmap_base:
+out_iounmap:
 	iounmap(base);
 out_free_priv:
 	kfree(priv);
=20
-	return err;
+	return -EINVAL;
+}
+
+#ifdef CONFIG_OF
+
+static int __init liointc_of_init(struct device_node *node,
+				  struct device_node *parent)
+{
+	bool have_parent =3D FALSE;
+	int sz, i, index, revision, err =3D 0;
+	struct resource res;
+
+	if (!of_device_is_compatible(node, "loongson,liointc-2.0")) {
+		index =3D 0;
+		revision =3D 1;
+	} else {
+		index =3D of_property_match_string(node, "reg-names", "main");
+		revision =3D 2;
+	}
+
+	if (of_address_to_resource(node, index, &res))
+		return -EINVAL;
+
+	for (i =3D 0; i < LIOINTC_NUM_PARENT; i++) {
+		parent_irq[i] =3D of_irq_get_byname(node, parent_names[i]);
+		if (parent_irq[i] > 0)
+			have_parent =3D TRUE;
+	}
+	if (!have_parent)
+		return -ENODEV;
+
+	sz =3D of_property_read_variable_u32_array(node,
+						"loongson,parent_int_map",
+						&parent_int_map[0],
+						LIOINTC_NUM_PARENT,
+						LIOINTC_NUM_PARENT);
+	if (sz < 4) {
+		pr_err("loongson-liointc: No parent_int_map\n");
+		return -ENODEV;
+	}
+
+	err =3D liointc_init(res.start, resource_size(&res),
+			revision, of_node_to_fwnode(node), node);
+	if (err < 0)
+		return err;
+
+	return 0;
 }
=20
 IRQCHIP_DECLARE(loongson_liointc_1_0, "loongson,liointc-1.0", liointc_of_ini=
t);
 IRQCHIP_DECLARE(loongson_liointc_1_0a, "loongson,liointc-1.0a", liointc_of_i=
nit);
 IRQCHIP_DECLARE(loongson_liointc_2_0, "loongson,liointc-2.0", liointc_of_ini=
t);
+
+#endif
+
+#ifdef CONFIG_ACPI
+int __init liointc_acpi_init(struct irq_domain *parent, struct acpi_madt_lio=
_pic *acpi_liointc)
+{
+	int ret;
+	struct fwnode_handle *domain_handle;
+
+	parent_int_map[0] =3D acpi_liointc->cascade_map[0];
+	parent_int_map[1] =3D acpi_liointc->cascade_map[1];
+
+	parent_irq[0] =3D irq_create_mapping(parent, acpi_liointc->cascade[0]);
+	parent_irq[1] =3D irq_create_mapping(parent, acpi_liointc->cascade[1]);
+
+	domain_handle =3D irq_domain_alloc_fwnode((phys_addr_t *)acpi_liointc);
+	if (!domain_handle) {
+		pr_err("Unable to allocate domain handle\n");
+		return -ENOMEM;
+	}
+	ret =3D liointc_init(acpi_liointc->address, acpi_liointc->size,
+			   1, domain_handle, NULL);
+	if (ret)
+		irq_domain_free_fwnode(domain_handle);
+
+	return ret;
+}
+#endif
diff --git a/drivers/irqchip/irq-loongson-pch-lpc.c b/drivers/irqchip/irq-loo=
ngson-pch-lpc.c
new file mode 100644
index 000000000000..bf2324910a75
--- /dev/null
+++ b/drivers/irqchip/irq-loongson-pch-lpc.c
@@ -0,0 +1,205 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Loongson LPC Interrupt Controller support
+ *
+ * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
+ */
+
+#define pr_fmt(fmt) "lpc: " fmt
+
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/irqdomain.h>
+#include <linux/kernel.h>
+
+/* Registers */
+#define LPC_INT_CTL		0x00
+#define LPC_INT_ENA		0x04
+#define LPC_INT_STS		0x08
+#define LPC_INT_CLR		0x0c
+#define LPC_INT_POL		0x10
+#define LPC_COUNT		16
+
+/* LPC_INT_CTL */
+#define LPC_INT_CTL_EN		BIT(31)
+
+struct pch_lpc {
+	void __iomem		*base;
+	struct irq_domain	*lpc_domain;
+	raw_spinlock_t		lpc_lock;
+	u32			saved_reg_ctl;
+	u32			saved_reg_ena;
+	u32			saved_reg_pol;
+};
+
+struct fwnode_handle *pch_lpc_handle;
+
+static void lpc_irq_ack(struct irq_data *d)
+{
+	unsigned long flags;
+	struct pch_lpc *priv =3D d->domain->host_data;
+
+	raw_spin_lock_irqsave(&priv->lpc_lock, flags);
+	writel(0x1 << d->hwirq, priv->base + LPC_INT_CLR);
+	raw_spin_unlock_irqrestore(&priv->lpc_lock, flags);
+}
+
+static void lpc_irq_mask(struct irq_data *d)
+{
+	unsigned long flags;
+	struct pch_lpc *priv =3D d->domain->host_data;
+
+	raw_spin_lock_irqsave(&priv->lpc_lock, flags);
+	writel(readl(priv->base + LPC_INT_ENA) & (~(0x1 << (d->hwirq))),
+			priv->base + LPC_INT_ENA);
+	raw_spin_unlock_irqrestore(&priv->lpc_lock, flags);
+}
+
+static void lpc_irq_unmask(struct irq_data *d)
+{
+	unsigned long flags;
+	struct pch_lpc *priv =3D d->domain->host_data;
+
+	raw_spin_lock_irqsave(&priv->lpc_lock, flags);
+	writel(readl(priv->base + LPC_INT_ENA) | (0x1 << (d->hwirq)),
+			priv->base + LPC_INT_ENA);
+	raw_spin_unlock_irqrestore(&priv->lpc_lock, flags);
+}
+
+static int lpc_irq_set_type(struct irq_data *d, unsigned int type)
+{
+	u32 val;
+	u32 mask =3D 0x1 << (d->hwirq);
+	struct pch_lpc *priv =3D d->domain->host_data;
+
+	if (!(type & IRQ_TYPE_LEVEL_MASK))
+		return 0;
+
+	val =3D readl(priv->base + LPC_INT_POL);
+
+	if (type =3D=3D IRQ_TYPE_LEVEL_HIGH)
+		val |=3D mask;
+	else
+		val &=3D ~mask;
+
+	writel(val, priv->base + LPC_INT_POL);
+
+	return 0;
+}
+
+static const struct irq_chip pch_lpc_irq_chip =3D {
+	.name			=3D "PCH LPC",
+	.irq_mask		=3D lpc_irq_mask,
+	.irq_unmask		=3D lpc_irq_unmask,
+	.irq_ack		=3D lpc_irq_ack,
+	.irq_set_type		=3D lpc_irq_set_type,
+	.flags			=3D IRQCHIP_SKIP_SET_WAKE,
+};
+
+static void lpc_irq_dispatch(struct irq_desc *desc)
+{
+	u32 pending, bit;
+	struct irq_chip *chip =3D irq_desc_get_chip(desc);
+	struct pch_lpc *priv =3D irq_desc_get_handler_data(desc);
+
+	chained_irq_enter(chip, desc);
+
+	pending =3D readl(priv->base + LPC_INT_ENA);
+	pending &=3D readl(priv->base + LPC_INT_STS);
+	if (!pending)
+		spurious_interrupt();
+
+	while (pending) {
+		bit =3D __ffs(pending);
+
+		generic_handle_domain_irq(priv->lpc_domain, bit);
+		pending &=3D ~BIT(bit);
+	}
+	chained_irq_exit(chip, desc);
+}
+
+static int pch_lpc_map(struct irq_domain *d, unsigned int irq,
+			irq_hw_number_t hw)
+{
+	irq_set_chip_and_handler(irq, &pch_lpc_irq_chip, handle_level_irq);
+	return 0;
+}
+
+static const struct irq_domain_ops pch_lpc_domain_ops =3D {
+	.map 		=3D pch_lpc_map,
+	.translate	=3D irq_domain_translate_twocell,
+};
+
+static void pch_lpc_reset(struct pch_lpc *priv)
+{
+	/* Enable the LPC interrupt, bit31: en  bit30: edge */
+	writel(LPC_INT_CTL_EN, priv->base + LPC_INT_CTL);
+	writel(0, priv->base + LPC_INT_ENA);
+	/* Clear all 18-bit interrpt bit */
+	writel(GENMASK(17, 0), priv->base + LPC_INT_CLR);
+}
+
+static int pch_lpc_disabled(struct pch_lpc *priv)
+{
+	return (readl(priv->base + LPC_INT_ENA) =3D=3D 0xffffffff) &&
+			(readl(priv->base + LPC_INT_STS) =3D=3D 0xffffffff);
+}
+
+int __init pch_lpc_acpi_init(struct irq_domain *parent,
+					struct acpi_madt_lpc_pic *acpi_pchlpc)
+{
+	int parent_irq;
+	struct pch_lpc *priv;
+	struct irq_fwspec fwspec;
+	struct fwnode_handle *irq_handle;
+
+	priv =3D kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	raw_spin_lock_init(&priv->lpc_lock);
+
+	priv->base =3D ioremap(acpi_pchlpc->address, acpi_pchlpc->size);
+	if (!priv->base)
+		goto free_priv;
+
+	if (pch_lpc_disabled(priv)) {
+		pr_err("Failed to get LPC status\n");
+		goto iounmap_base;
+	}
+
+	irq_handle =3D irq_domain_alloc_named_fwnode("lpcintc");
+	if (!irq_handle) {
+		pr_err("Unable to allocate domain handle\n");
+		goto iounmap_base;
+	}
+
+	priv->lpc_domain =3D irq_domain_create_linear(irq_handle, LPC_COUNT,
+					&pch_lpc_domain_ops, priv);
+	if (!priv->lpc_domain) {
+		pr_err("Failed to create IRQ domain\n");
+		goto free_irq_handle;
+	}
+	pch_lpc_reset(priv);
+
+	fwspec.fwnode =3D parent->fwnode;
+	fwspec.param[0] =3D acpi_pchlpc->cascade + GSI_MIN_PCH_IRQ;
+	fwspec.param[1] =3D IRQ_TYPE_LEVEL_HIGH;
+	fwspec.param_count =3D 2;
+	parent_irq =3D irq_create_fwspec_mapping(&fwspec);
+	irq_set_chained_handler_and_data(parent_irq, lpc_irq_dispatch, priv);
+
+	pch_lpc_handle =3D irq_handle;
+	return 0;
+
+free_irq_handle:
+	irq_domain_free_fwnode(irq_handle);
+iounmap_base:
+	iounmap(priv->base);
+free_priv:
+	kfree(priv);
+
+	return -ENOMEM;
+}
diff --git a/drivers/irqchip/irq-loongson-pch-msi.c b/drivers/irqchip/irq-loo=
ngson-pch-msi.c
index e3801c4a77ed..d0e8551bebfa 100644
--- a/drivers/irqchip/irq-loongson-pch-msi.c
+++ b/drivers/irqchip/irq-loongson-pch-msi.c
@@ -15,6 +15,8 @@
 #include <linux/pci.h>
 #include <linux/slab.h>
=20
+static int nr_pics;
+
 struct pch_msi_data {
 	struct mutex	msi_map_lock;
 	phys_addr_t	doorbell;
@@ -23,6 +25,8 @@ struct pch_msi_data {
 	unsigned long	*msi_map;
 };
=20
+static struct fwnode_handle *pch_msi_handle[MAX_IO_PICS];
+
 static void pch_msi_mask_msi_irq(struct irq_data *d)
 {
 	pci_msi_mask_irq(d);
@@ -154,12 +158,12 @@ static const struct irq_domain_ops pch_msi_middle_domai=
n_ops =3D {
 };
=20
 static int pch_msi_init_domains(struct pch_msi_data *priv,
-				struct device_node *node,
-				struct irq_domain *parent)
+				struct irq_domain *parent,
+				struct fwnode_handle *domain_handle)
 {
 	struct irq_domain *middle_domain, *msi_domain;
=20
-	middle_domain =3D irq_domain_create_linear(of_node_to_fwnode(node),
+	middle_domain =3D irq_domain_create_linear(domain_handle,
 						priv->num_irqs,
 						&pch_msi_middle_domain_ops,
 						priv);
@@ -171,7 +175,7 @@ static int pch_msi_init_domains(struct pch_msi_data *priv,
 	middle_domain->parent =3D parent;
 	irq_domain_update_bus_token(middle_domain, DOMAIN_BUS_NEXUS);
=20
-	msi_domain =3D pci_msi_create_irq_domain(of_node_to_fwnode(node),
+	msi_domain =3D pci_msi_create_irq_domain(domain_handle,
 					       &pch_msi_domain_info,
 					       middle_domain);
 	if (!msi_domain) {
@@ -183,19 +187,11 @@ static int pch_msi_init_domains(struct pch_msi_data *pr=
iv,
 	return 0;
 }
=20
-static int pch_msi_init(struct device_node *node,
-			    struct device_node *parent)
+static int pch_msi_init(phys_addr_t msg_address, int irq_base, int irq_count,
+			struct irq_domain *parent_domain, struct fwnode_handle *domain_handle)
 {
-	struct pch_msi_data *priv;
-	struct irq_domain *parent_domain;
-	struct resource res;
 	int ret;
-
-	parent_domain =3D irq_find_host(parent);
-	if (!parent_domain) {
-		pr_err("Failed to find the parent domain\n");
-		return -ENXIO;
-	}
+	struct pch_msi_data *priv;
=20
 	priv =3D kzalloc(sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -203,48 +199,95 @@ static int pch_msi_init(struct device_node *node,
=20
 	mutex_init(&priv->msi_map_lock);
=20
-	ret =3D of_address_to_resource(node, 0, &res);
-	if (ret) {
-		pr_err("Failed to allocate resource\n");
-		goto err_priv;
-	}
-
-	priv->doorbell =3D res.start;
-
-	if (of_property_read_u32(node, "loongson,msi-base-vec",
-				&priv->irq_first)) {
-		pr_err("Unable to parse MSI vec base\n");
-		ret =3D -EINVAL;
-		goto err_priv;
-	}
-
-	if (of_property_read_u32(node, "loongson,msi-num-vecs",
-				&priv->num_irqs)) {
-		pr_err("Unable to parse MSI vec number\n");
-		ret =3D -EINVAL;
-		goto err_priv;
-	}
+	priv->doorbell =3D msg_address;
+	priv->irq_first =3D irq_base;
+	priv->num_irqs =3D irq_count;
=20
 	priv->msi_map =3D bitmap_zalloc(priv->num_irqs, GFP_KERNEL);
-	if (!priv->msi_map) {
-		ret =3D -ENOMEM;
+	if (!priv->msi_map)
 		goto err_priv;
-	}
=20
 	pr_debug("Registering %d MSIs, starting at %d\n",
 		 priv->num_irqs, priv->irq_first);
=20
-	ret =3D pch_msi_init_domains(priv, node, parent_domain);
+	ret =3D pch_msi_init_domains(priv, parent_domain, domain_handle);
 	if (ret)
 		goto err_map;
=20
+	pch_msi_handle[nr_pics++] =3D domain_handle;
 	return 0;
=20
 err_map:
 	bitmap_free(priv->msi_map);
 err_priv:
 	kfree(priv);
-	return ret;
+
+	return -EINVAL;
+}
+
+#ifdef CONFIG_OF
+static int pch_msi_of_init(struct device_node *node, struct device_node *par=
ent)
+{
+	int err;
+	int irq_base, irq_count;
+	struct resource res;
+	struct irq_domain *parent_domain;
+
+	parent_domain =3D irq_find_host(parent);
+	if (!parent_domain) {
+		pr_err("Failed to find the parent domain\n");
+		return -ENXIO;
+	}
+
+	if (of_address_to_resource(node, 0, &res)) {
+		pr_err("Failed to allocate resource\n");
+		return -EINVAL;
+	}
+
+	if (of_property_read_u32(node, "loongson,msi-base-vec", &irq_base)) {
+		pr_err("Unable to parse MSI vec base\n");
+		return -EINVAL;
+	}
+
+	if (of_property_read_u32(node, "loongson,msi-num-vecs", &irq_count)) {
+		pr_err("Unable to parse MSI vec number\n");
+		return -EINVAL;
+	}
+
+	err =3D pch_msi_init(res.start, irq_base, irq_count, parent_domain, of_node=
_to_fwnode(node));
+	if (err < 0)
+		return err;
+
+	return 0;
 }
=20
-IRQCHIP_DECLARE(pch_msi, "loongson,pch-msi-1.0", pch_msi_init);
+IRQCHIP_DECLARE(pch_msi, "loongson,pch-msi-1.0", pch_msi_of_init);
+#endif
+
+#ifdef CONFIG_ACPI
+struct fwnode_handle *get_pch_msi_handle(int pci_segment)
+{
+	int i;
+
+	for (i =3D 0; i < MAX_IO_PICS; i++) {
+		if (msi_group[i].pci_segment =3D=3D pci_segment)
+			return pch_msi_handle[i];
+	}
+	return NULL;
+}
+
+int __init pch_msi_acpi_init(struct irq_domain *parent,
+					struct acpi_madt_msi_pic *acpi_pchmsi)
+{
+	int ret;
+	struct fwnode_handle *domain_handle;
+
+	domain_handle =3D irq_domain_alloc_fwnode((phys_addr_t *)acpi_pchmsi);
+	ret =3D pch_msi_init(acpi_pchmsi->msg_address, acpi_pchmsi->start,
+				acpi_pchmsi->count, parent, domain_handle);
+	if (ret < 0)
+		irq_domain_free_fwnode(domain_handle);
+
+	return ret;
+}
+#endif
diff --git a/drivers/irqchip/irq-loongson-pch-pic.c b/drivers/irqchip/irq-loo=
ngson-pch-pic.c
index a4eb8a2181c7..b6f1392964b1 100644
--- a/drivers/irqchip/irq-loongson-pch-pic.c
+++ b/drivers/irqchip/irq-loongson-pch-pic.c
@@ -33,13 +33,40 @@
 #define PIC_REG_IDX(irq_id)	((irq_id) / PIC_COUNT_PER_REG)
 #define PIC_REG_BIT(irq_id)	((irq_id) % PIC_COUNT_PER_REG)
=20
+static int nr_pics;
+
 struct pch_pic {
 	void __iomem		*base;
 	struct irq_domain	*pic_domain;
 	u32			ht_vec_base;
 	raw_spinlock_t		pic_lock;
+	u32			vec_count;
+	u32			gsi_base;
 };
=20
+static struct pch_pic *pch_pic_priv[MAX_IO_PICS];
+
+struct fwnode_handle *pch_pic_handle[MAX_IO_PICS];
+
+int find_pch_pic(u32 gsi)
+{
+	int i;
+
+	/* Find the PCH_PIC that manages this GSI. */
+	for (i =3D 0; i < MAX_IO_PICS; i++) {
+		struct pch_pic *priv =3D pch_pic_priv[i];
+
+		if (!priv)
+			return -1;
+
+		if (gsi >=3D priv->gsi_base && gsi < (priv->gsi_base + priv->vec_count))
+			return i;
+	}
+
+	pr_err("ERROR: Unable to locate PCH_PIC for GSI %d\n", gsi);
+	return -1;
+}
+
 static void pch_pic_bitset(struct pch_pic *priv, int offset, int bit)
 {
 	u32 reg;
@@ -139,6 +166,28 @@ static struct irq_chip pch_pic_irq_chip =3D {
 	.irq_set_type		=3D pch_pic_set_type,
 };
=20
+static int pch_pic_domain_translate(struct irq_domain *d,
+					struct irq_fwspec *fwspec,
+					unsigned long *hwirq,
+					unsigned int *type)
+{
+	struct pch_pic *priv =3D d->host_data;
+	struct device_node *of_node =3D to_of_node(fwspec->fwnode);
+
+	if (fwspec->param_count < 1)
+		return -EINVAL;
+
+	if (of_node) {
+		*hwirq =3D fwspec->param[0] + priv->ht_vec_base;
+		*type =3D fwspec->param[1] & IRQ_TYPE_SENSE_MASK;
+	} else {
+		*hwirq =3D fwspec->param[0] - priv->gsi_base;
+		*type =3D IRQ_TYPE_NONE;
+	}
+
+	return 0;
+}
+
 static int pch_pic_alloc(struct irq_domain *domain, unsigned int virq,
 			      unsigned int nr_irqs, void *arg)
 {
@@ -149,13 +198,13 @@ static int pch_pic_alloc(struct irq_domain *domain, uns=
igned int virq,
 	struct irq_fwspec parent_fwspec;
 	struct pch_pic *priv =3D domain->host_data;
=20
-	err =3D irq_domain_translate_twocell(domain, fwspec, &hwirq, &type);
+	err =3D pch_pic_domain_translate(domain, fwspec, &hwirq, &type);
 	if (err)
 		return err;
=20
 	parent_fwspec.fwnode =3D domain->parent->fwnode;
 	parent_fwspec.param_count =3D 1;
-	parent_fwspec.param[0] =3D hwirq + priv->ht_vec_base;
+	parent_fwspec.param[0] =3D hwirq;
=20
 	err =3D irq_domain_alloc_irqs_parent(domain, virq, 1, &parent_fwspec);
 	if (err)
@@ -170,7 +219,7 @@ static int pch_pic_alloc(struct irq_domain *domain, unsig=
ned int virq,
 }
=20
 static const struct irq_domain_ops pch_pic_domain_ops =3D {
-	.translate	=3D irq_domain_translate_twocell,
+	.translate	=3D pch_pic_domain_translate,
 	.alloc		=3D pch_pic_alloc,
 	.free		=3D irq_domain_free_irqs_parent,
 };
@@ -180,7 +229,7 @@ static void pch_pic_reset(struct pch_pic *priv)
 	int i;
=20
 	for (i =3D 0; i < PIC_COUNT; i++) {
-		/* Write vectored ID */
+		/* Write vector ID */
 		writeb(priv->ht_vec_base + i, priv->base + PCH_INT_HTVEC(i));
 		/* Hardcode route to HT0 Lo */
 		writeb(1, priv->base + PCH_INT_ROUTE(i));
@@ -198,50 +247,37 @@ static void pch_pic_reset(struct pch_pic *priv)
 	}
 }
=20
-static int pch_pic_of_init(struct device_node *node,
-				struct device_node *parent)
+static int pch_pic_init(phys_addr_t addr, unsigned long size, int vec_base,
+			struct irq_domain *parent_domain, struct fwnode_handle *domain_handle,
+			u32 gsi_base)
 {
 	struct pch_pic *priv;
-	struct irq_domain *parent_domain;
-	int err;
=20
 	priv =3D kzalloc(sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
=20
 	raw_spin_lock_init(&priv->pic_lock);
-	priv->base =3D of_iomap(node, 0);
-	if (!priv->base) {
-		err =3D -ENOMEM;
+	priv->base =3D ioremap(addr, size);
+	if (!priv->base)
 		goto free_priv;
-	}
=20
-	parent_domain =3D irq_find_host(parent);
-	if (!parent_domain) {
-		pr_err("Failed to find the parent domain\n");
-		err =3D -ENXIO;
-		goto iounmap_base;
-	}
-
-	if (of_property_read_u32(node, "loongson,pic-base-vec",
-				&priv->ht_vec_base)) {
-		pr_err("Failed to determine pic-base-vec\n");
-		err =3D -EINVAL;
-		goto iounmap_base;
-	}
+	priv->ht_vec_base =3D vec_base;
+	priv->vec_count =3D ((readq(priv->base) >> 48) & 0xff) + 1;
+	priv->gsi_base =3D gsi_base;
=20
 	priv->pic_domain =3D irq_domain_create_hierarchy(parent_domain, 0,
-						       PIC_COUNT,
-						       of_node_to_fwnode(node),
-						       &pch_pic_domain_ops,
-						       priv);
+						priv->vec_count, domain_handle,
+						&pch_pic_domain_ops, priv);
+
 	if (!priv->pic_domain) {
 		pr_err("Failed to create IRQ domain\n");
-		err =3D -ENOMEM;
 		goto iounmap_base;
 	}
=20
 	pch_pic_reset(priv);
+	pch_pic_handle[nr_pics] =3D domain_handle;
+	pch_pic_priv[nr_pics++] =3D priv;
=20
 	return 0;
=20
@@ -250,7 +286,86 @@ static int pch_pic_of_init(struct device_node *node,
 free_priv:
 	kfree(priv);
=20
-	return err;
+	return -EINVAL;
+}
+
+#ifdef CONFIG_OF
+
+static int pch_pic_of_init(struct device_node *node,
+				struct device_node *parent)
+{
+	int err, vec_base;
+	struct resource res;
+	struct irq_domain *parent_domain;
+
+	if (of_address_to_resource(node, 0, &res))
+		return -EINVAL;
+
+	parent_domain =3D irq_find_host(parent);
+	if (!parent_domain) {
+		pr_err("Failed to find the parent domain\n");
+		return -ENXIO;
+	}
+
+	if (of_property_read_u32(node, "loongson,pic-base-vec", &vec_base)) {
+		pr_err("Failed to determine pic-base-vec\n");
+		return -EINVAL;
+	}
+
+	err =3D pch_pic_init(res.start, resource_size(&res), vec_base,
+				parent_domain, of_node_to_fwnode(node), 0);
+	if (err < 0)
+		return err;
+
+	return 0;
 }
=20
 IRQCHIP_DECLARE(pch_pic, "loongson,pch-pic-1.0", pch_pic_of_init);
+
+#endif
+
+#ifdef CONFIG_ACPI
+static int __init
+pch_lpc_parse_madt(union acpi_subtable_headers *header,
+		       const unsigned long end)
+{
+	struct acpi_madt_lpc_pic *pchlpc_entry =3D (struct acpi_madt_lpc_pic *)head=
er;
+
+	return pch_lpc_acpi_init(pch_pic_priv[0]->pic_domain, pchlpc_entry);
+}
+
+static int __init acpi_cascade_irqdomain_init(void)
+{
+	acpi_table_parse_madt(ACPI_MADT_TYPE_LPC_PIC,
+			      pch_lpc_parse_madt, 0);
+	return 0;
+}
+
+int __init pch_pic_acpi_init(struct irq_domain *parent,
+					struct acpi_madt_bio_pic *acpi_pchpic)
+{
+	int ret, vec_base;
+	struct fwnode_handle *domain_handle;
+
+	vec_base =3D acpi_pchpic->gsi_base - GSI_MIN_PCH_IRQ;
+
+	domain_handle =3D irq_domain_alloc_fwnode((phys_addr_t *)acpi_pchpic);
+	if (!domain_handle) {
+		pr_err("Unable to allocate domain handle\n");
+		return -ENOMEM;
+	}
+
+	ret =3D pch_pic_init(acpi_pchpic->address, acpi_pchpic->size,
+				vec_base, parent, domain_handle, acpi_pchpic->gsi_base);
+
+	if (ret < 0) {
+		irq_domain_free_fwnode(domain_handle);
+		return ret;
+	}
+
+	if (acpi_pchpic->id =3D=3D 0)
+		acpi_cascade_irqdomain_init();
+
+	return ret;
+}
+#endif
diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index ff89b36267dd..1ba0f1555c80 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -52,13 +52,15 @@ static DEFINE_PER_CPU_READ_MOSTLY(unsigned long[GIC_MAX_L=
ONGS], pcpu_masks);
=20
 static DEFINE_SPINLOCK(gic_lock);
 static struct irq_domain *gic_irq_domain;
-static struct irq_domain *gic_ipi_domain;
 static int gic_shared_intrs;
 static unsigned int gic_cpu_pin;
 static unsigned int timer_cpu_pin;
 static struct irq_chip gic_level_irq_controller, gic_edge_irq_controller;
+
+#ifdef CONFIG_GENERIC_IRQ_IPI
 static DECLARE_BITMAP(ipi_resrv, GIC_MAX_INTRS);
 static DECLARE_BITMAP(ipi_available, GIC_MAX_INTRS);
+#endif /* CONFIG_GENERIC_IRQ_IPI */
=20
 static struct gic_all_vpes_chip_data {
 	u32	map;
@@ -472,9 +474,11 @@ static int gic_irq_domain_map(struct irq_domain *d, unsi=
gned int virq,
 	u32 map;
=20
 	if (hwirq >=3D GIC_SHARED_HWIRQ_BASE) {
+#ifdef CONFIG_GENERIC_IRQ_IPI
 		/* verify that shared irqs don't conflict with an IPI irq */
 		if (test_bit(GIC_HWIRQ_TO_SHARED(hwirq), ipi_resrv))
 			return -EBUSY;
+#endif /* CONFIG_GENERIC_IRQ_IPI */
=20
 		err =3D irq_domain_set_hwirq_and_chip(d, virq, hwirq,
 						    &gic_level_irq_controller,
@@ -567,6 +571,8 @@ static const struct irq_domain_ops gic_irq_domain_ops =3D=
 {
 	.map =3D gic_irq_domain_map,
 };
=20
+#ifdef CONFIG_GENERIC_IRQ_IPI
+
 static int gic_ipi_domain_xlate(struct irq_domain *d, struct device_node *ct=
rlr,
 				const u32 *intspec, unsigned int intsize,
 				irq_hw_number_t *out_hwirq,
@@ -670,6 +676,48 @@ static const struct irq_domain_ops gic_ipi_domain_ops =
=3D {
 	.match =3D gic_ipi_domain_match,
 };
=20
+static int gic_register_ipi_domain(struct device_node *node)
+{
+	struct irq_domain *gic_ipi_domain;
+	unsigned int v[2], num_ipis;
+
+	gic_ipi_domain =3D irq_domain_add_hierarchy(gic_irq_domain,
+						  IRQ_DOMAIN_FLAG_IPI_PER_CPU,
+						  GIC_NUM_LOCAL_INTRS + gic_shared_intrs,
+						  node, &gic_ipi_domain_ops, NULL);
+	if (!gic_ipi_domain) {
+		pr_err("Failed to add IPI domain");
+		return -ENXIO;
+	}
+
+	irq_domain_update_bus_token(gic_ipi_domain, DOMAIN_BUS_IPI);
+
+	if (node &&
+	    !of_property_read_u32_array(node, "mti,reserved-ipi-vectors", v, 2)) {
+		bitmap_set(ipi_resrv, v[0], v[1]);
+	} else {
+		/*
+		 * Reserve 2 interrupts per possible CPU/VP for use as IPIs,
+		 * meeting the requirements of arch/mips SMP.
+		 */
+		num_ipis =3D 2 * num_possible_cpus();
+		bitmap_set(ipi_resrv, gic_shared_intrs - num_ipis, num_ipis);
+	}
+
+	bitmap_copy(ipi_available, ipi_resrv, GIC_MAX_INTRS);
+
+	return 0;
+}
+
+#else /* !CONFIG_GENERIC_IRQ_IPI */
+
+static inline int gic_register_ipi_domain(struct device_node *node)
+{
+	return 0;
+}
+
+#endif /* !CONFIG_GENERIC_IRQ_IPI */
+
 static int gic_cpu_startup(unsigned int cpu)
 {
 	/* Enable or disable EIC */
@@ -688,11 +736,12 @@ static int gic_cpu_startup(unsigned int cpu)
 static int __init gic_of_init(struct device_node *node,
 			      struct device_node *parent)
 {
-	unsigned int cpu_vec, i, gicconfig, v[2], num_ipis;
+	unsigned int cpu_vec, i, gicconfig;
 	unsigned long reserved;
 	phys_addr_t gic_base;
 	struct resource res;
 	size_t gic_len;
+	int ret;
=20
 	/* Find the first available CPU vector. */
 	i =3D 0;
@@ -734,6 +783,10 @@ static int __init gic_of_init(struct device_node *node,
 	}
=20
 	mips_gic_base =3D ioremap(gic_base, gic_len);
+	if (!mips_gic_base) {
+		pr_err("Failed to ioremap gic_base\n");
+		return -ENOMEM;
+	}
=20
 	gicconfig =3D read_gic_config();
 	gic_shared_intrs =3D FIELD_GET(GIC_CONFIG_NUMINTERRUPTS, gicconfig);
@@ -780,30 +833,9 @@ static int __init gic_of_init(struct device_node *node,
 		return -ENXIO;
 	}
=20
-	gic_ipi_domain =3D irq_domain_add_hierarchy(gic_irq_domain,
-						  IRQ_DOMAIN_FLAG_IPI_PER_CPU,
-						  GIC_NUM_LOCAL_INTRS + gic_shared_intrs,
-						  node, &gic_ipi_domain_ops, NULL);
-	if (!gic_ipi_domain) {
-		pr_err("Failed to add IPI domain");
-		return -ENXIO;
-	}
-
-	irq_domain_update_bus_token(gic_ipi_domain, DOMAIN_BUS_IPI);
-
-	if (node &&
-	    !of_property_read_u32_array(node, "mti,reserved-ipi-vectors", v, 2)) {
-		bitmap_set(ipi_resrv, v[0], v[1]);
-	} else {
-		/*
-		 * Reserve 2 interrupts per possible CPU/VP for use as IPIs,
-		 * meeting the requirements of arch/mips SMP.
-		 */
-		num_ipis =3D 2 * num_possible_cpus();
-		bitmap_set(ipi_resrv, gic_shared_intrs - num_ipis, num_ipis);
-	}
-
-	bitmap_copy(ipi_available, ipi_resrv, GIC_MAX_INTRS);
+	ret =3D gic_register_ipi_domain(node);
+	if (ret)
+		return ret;
=20
 	board_bind_eic_interrupt =3D &gic_bind_eic_interrupt;
=20
diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesa=
s-rzg2l.c
new file mode 100644
index 000000000000..25fd8ee66565
--- /dev/null
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -0,0 +1,393 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Renesas RZ/G2L IRQC Driver
+ *
+ * Copyright (C) 2022 Renesas Electronics Corporation.
+ *
+ * Author: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/irqchip.h>
+#include <linux/irqdomain.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
+#include <linux/pm_runtime.h>
+#include <linux/reset.h>
+#include <linux/spinlock.h>
+
+#define IRQC_IRQ_START			1
+#define IRQC_IRQ_COUNT			8
+#define IRQC_TINT_START			(IRQC_IRQ_START + IRQC_IRQ_COUNT)
+#define IRQC_TINT_COUNT			32
+#define IRQC_NUM_IRQ			(IRQC_TINT_START + IRQC_TINT_COUNT)
+
+#define ISCR				0x10
+#define IITSR				0x14
+#define TSCR				0x20
+#define TITSR0				0x24
+#define TITSR1				0x28
+#define TITSR0_MAX_INT			16
+#define TITSEL_WIDTH			0x2
+#define TSSR(n)				(0x30 + ((n) * 4))
+#define TIEN				BIT(7)
+#define TSSEL_SHIFT(n)			(8 * (n))
+#define TSSEL_MASK			GENMASK(7, 0)
+#define IRQ_MASK			0x3
+
+#define TSSR_OFFSET(n)			((n) % 4)
+#define TSSR_INDEX(n)			((n) / 4)
+
+#define TITSR_TITSEL_EDGE_RISING	0
+#define TITSR_TITSEL_EDGE_FALLING	1
+#define TITSR_TITSEL_LEVEL_HIGH		2
+#define TITSR_TITSEL_LEVEL_LOW		3
+
+#define IITSR_IITSEL(n, sense)		((sense) << ((n) * 2))
+#define IITSR_IITSEL_LEVEL_LOW		0
+#define IITSR_IITSEL_EDGE_FALLING	1
+#define IITSR_IITSEL_EDGE_RISING	2
+#define IITSR_IITSEL_EDGE_BOTH		3
+#define IITSR_IITSEL_MASK(n)		IITSR_IITSEL((n), 3)
+
+#define TINT_EXTRACT_HWIRQ(x)           FIELD_GET(GENMASK(15, 0), (x))
+#define TINT_EXTRACT_GPIOINT(x)         FIELD_GET(GENMASK(31, 16), (x))
+
+struct rzg2l_irqc_priv {
+	void __iomem *base;
+	struct irq_fwspec fwspec[IRQC_NUM_IRQ];
+	raw_spinlock_t lock;
+};
+
+static struct rzg2l_irqc_priv *irq_data_to_priv(struct irq_data *data)
+{
+	return data->domain->host_data;
+}
+
+static void rzg2l_irq_eoi(struct irq_data *d)
+{
+	unsigned int hw_irq =3D irqd_to_hwirq(d) - IRQC_IRQ_START;
+	struct rzg2l_irqc_priv *priv =3D irq_data_to_priv(d);
+	u32 bit =3D BIT(hw_irq);
+	u32 reg;
+
+	reg =3D readl_relaxed(priv->base + ISCR);
+	if (reg & bit)
+		writel_relaxed(reg & ~bit, priv->base + ISCR);
+}
+
+static void rzg2l_tint_eoi(struct irq_data *d)
+{
+	unsigned int hw_irq =3D irqd_to_hwirq(d) - IRQC_TINT_START;
+	struct rzg2l_irqc_priv *priv =3D irq_data_to_priv(d);
+	u32 bit =3D BIT(hw_irq);
+	u32 reg;
+
+	reg =3D readl_relaxed(priv->base + TSCR);
+	if (reg & bit)
+		writel_relaxed(reg & ~bit, priv->base + TSCR);
+}
+
+static void rzg2l_irqc_eoi(struct irq_data *d)
+{
+	struct rzg2l_irqc_priv *priv =3D irq_data_to_priv(d);
+	unsigned int hw_irq =3D irqd_to_hwirq(d);
+
+	raw_spin_lock(&priv->lock);
+	if (hw_irq >=3D IRQC_IRQ_START && hw_irq <=3D IRQC_IRQ_COUNT)
+		rzg2l_irq_eoi(d);
+	else if (hw_irq >=3D IRQC_TINT_START && hw_irq < IRQC_NUM_IRQ)
+		rzg2l_tint_eoi(d);
+	raw_spin_unlock(&priv->lock);
+	irq_chip_eoi_parent(d);
+}
+
+static void rzg2l_irqc_irq_disable(struct irq_data *d)
+{
+	unsigned int hw_irq =3D irqd_to_hwirq(d);
+
+	if (hw_irq >=3D IRQC_TINT_START && hw_irq < IRQC_NUM_IRQ) {
+		struct rzg2l_irqc_priv *priv =3D irq_data_to_priv(d);
+		u32 offset =3D hw_irq - IRQC_TINT_START;
+		u32 tssr_offset =3D TSSR_OFFSET(offset);
+		u8 tssr_index =3D TSSR_INDEX(offset);
+		u32 reg;
+
+		raw_spin_lock(&priv->lock);
+		reg =3D readl_relaxed(priv->base + TSSR(tssr_index));
+		reg &=3D ~(TSSEL_MASK << tssr_offset);
+		writel_relaxed(reg, priv->base + TSSR(tssr_index));
+		raw_spin_unlock(&priv->lock);
+	}
+	irq_chip_disable_parent(d);
+}
+
+static void rzg2l_irqc_irq_enable(struct irq_data *d)
+{
+	unsigned int hw_irq =3D irqd_to_hwirq(d);
+
+	if (hw_irq >=3D IRQC_TINT_START && hw_irq < IRQC_NUM_IRQ) {
+		struct rzg2l_irqc_priv *priv =3D irq_data_to_priv(d);
+		unsigned long tint =3D (uintptr_t)d->chip_data;
+		u32 offset =3D hw_irq - IRQC_TINT_START;
+		u32 tssr_offset =3D TSSR_OFFSET(offset);
+		u8 tssr_index =3D TSSR_INDEX(offset);
+		u32 reg;
+
+		raw_spin_lock(&priv->lock);
+		reg =3D readl_relaxed(priv->base + TSSR(tssr_index));
+		reg |=3D (TIEN | tint) << TSSEL_SHIFT(tssr_offset);
+		writel_relaxed(reg, priv->base + TSSR(tssr_index));
+		raw_spin_unlock(&priv->lock);
+	}
+	irq_chip_enable_parent(d);
+}
+
+static int rzg2l_irq_set_type(struct irq_data *d, unsigned int type)
+{
+	unsigned int hw_irq =3D irqd_to_hwirq(d) - IRQC_IRQ_START;
+	struct rzg2l_irqc_priv *priv =3D irq_data_to_priv(d);
+	u16 sense, tmp;
+
+	switch (type & IRQ_TYPE_SENSE_MASK) {
+	case IRQ_TYPE_LEVEL_LOW:
+		sense =3D IITSR_IITSEL_LEVEL_LOW;
+		break;
+
+	case IRQ_TYPE_EDGE_FALLING:
+		sense =3D IITSR_IITSEL_EDGE_FALLING;
+		break;
+
+	case IRQ_TYPE_EDGE_RISING:
+		sense =3D IITSR_IITSEL_EDGE_RISING;
+		break;
+
+	case IRQ_TYPE_EDGE_BOTH:
+		sense =3D IITSR_IITSEL_EDGE_BOTH;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	raw_spin_lock(&priv->lock);
+	tmp =3D readl_relaxed(priv->base + IITSR);
+	tmp &=3D ~IITSR_IITSEL_MASK(hw_irq);
+	tmp |=3D IITSR_IITSEL(hw_irq, sense);
+	writel_relaxed(tmp, priv->base + IITSR);
+	raw_spin_unlock(&priv->lock);
+
+	return 0;
+}
+
+static int rzg2l_tint_set_edge(struct irq_data *d, unsigned int type)
+{
+	struct rzg2l_irqc_priv *priv =3D irq_data_to_priv(d);
+	unsigned int hwirq =3D irqd_to_hwirq(d);
+	u32 titseln =3D hwirq - IRQC_TINT_START;
+	u32 offset;
+	u8 sense;
+	u32 reg;
+
+	switch (type & IRQ_TYPE_SENSE_MASK) {
+	case IRQ_TYPE_EDGE_RISING:
+		sense =3D TITSR_TITSEL_EDGE_RISING;
+		break;
+
+	case IRQ_TYPE_EDGE_FALLING:
+		sense =3D TITSR_TITSEL_EDGE_FALLING;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	offset =3D TITSR0;
+	if (titseln >=3D TITSR0_MAX_INT) {
+		titseln -=3D TITSR0_MAX_INT;
+		offset =3D TITSR1;
+	}
+
+	raw_spin_lock(&priv->lock);
+	reg =3D readl_relaxed(priv->base + offset);
+	reg &=3D ~(IRQ_MASK << (titseln * TITSEL_WIDTH));
+	reg |=3D sense << (titseln * TITSEL_WIDTH);
+	writel_relaxed(reg, priv->base + offset);
+	raw_spin_unlock(&priv->lock);
+
+	return 0;
+}
+
+static int rzg2l_irqc_set_type(struct irq_data *d, unsigned int type)
+{
+	unsigned int hw_irq =3D irqd_to_hwirq(d);
+	int ret =3D -EINVAL;
+
+	if (hw_irq >=3D IRQC_IRQ_START && hw_irq <=3D IRQC_IRQ_COUNT)
+		ret =3D rzg2l_irq_set_type(d, type);
+	else if (hw_irq >=3D IRQC_TINT_START && hw_irq < IRQC_NUM_IRQ)
+		ret =3D rzg2l_tint_set_edge(d, type);
+	if (ret)
+		return ret;
+
+	return irq_chip_set_type_parent(d, IRQ_TYPE_LEVEL_HIGH);
+}
+
+static const struct irq_chip irqc_chip =3D {
+	.name			=3D "rzg2l-irqc",
+	.irq_eoi		=3D rzg2l_irqc_eoi,
+	.irq_mask		=3D irq_chip_mask_parent,
+	.irq_unmask		=3D irq_chip_unmask_parent,
+	.irq_disable		=3D rzg2l_irqc_irq_disable,
+	.irq_enable		=3D rzg2l_irqc_irq_enable,
+	.irq_get_irqchip_state	=3D irq_chip_get_parent_state,
+	.irq_set_irqchip_state	=3D irq_chip_set_parent_state,
+	.irq_retrigger		=3D irq_chip_retrigger_hierarchy,
+	.irq_set_type		=3D rzg2l_irqc_set_type,
+	.flags			=3D IRQCHIP_MASK_ON_SUSPEND |
+				  IRQCHIP_SET_TYPE_MASKED |
+				  IRQCHIP_SKIP_SET_WAKE,
+};
+
+static int rzg2l_irqc_alloc(struct irq_domain *domain, unsigned int virq,
+			    unsigned int nr_irqs, void *arg)
+{
+	struct rzg2l_irqc_priv *priv =3D domain->host_data;
+	unsigned long tint =3D 0;
+	irq_hw_number_t hwirq;
+	unsigned int type;
+	int ret;
+
+	ret =3D irq_domain_translate_twocell(domain, arg, &hwirq, &type);
+	if (ret)
+		return ret;
+
+	/*
+	 * For TINT interrupts ie where pinctrl driver is child of irqc domain
+	 * the hwirq and TINT are encoded in fwspec->param[0].
+	 * hwirq for TINT range from 9-40, hwirq is embedded 0-15 bits and TINT
+	 * from 16-31 bits. TINT from the pinctrl driver needs to be programmed
+	 * in IRQC registers to enable a given gpio pin as interrupt.
+	 */
+	if (hwirq > IRQC_IRQ_COUNT) {
+		tint =3D TINT_EXTRACT_GPIOINT(hwirq);
+		hwirq =3D TINT_EXTRACT_HWIRQ(hwirq);
+
+		if (hwirq < IRQC_TINT_START)
+			return -EINVAL;
+	}
+
+	if (hwirq > (IRQC_NUM_IRQ - 1))
+		return -EINVAL;
+
+	ret =3D irq_domain_set_hwirq_and_chip(domain, virq, hwirq, &irqc_chip,
+					    (void *)(uintptr_t)tint);
+	if (ret)
+		return ret;
+
+	return irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, &priv->fwspec[hw=
irq]);
+}
+
+static const struct irq_domain_ops rzg2l_irqc_domain_ops =3D {
+	.alloc =3D rzg2l_irqc_alloc,
+	.free =3D irq_domain_free_irqs_common,
+	.translate =3D irq_domain_translate_twocell,
+};
+
+static int rzg2l_irqc_parse_interrupts(struct rzg2l_irqc_priv *priv,
+				       struct device_node *np)
+{
+	struct of_phandle_args map;
+	unsigned int i;
+	int ret;
+
+	for (i =3D 0; i < IRQC_NUM_IRQ; i++) {
+		ret =3D of_irq_parse_one(np, i, &map);
+		if (ret)
+			return ret;
+		of_phandle_args_to_fwspec(np, map.args, map.args_count,
+					  &priv->fwspec[i]);
+	}
+
+	return 0;
+}
+
+static int rzg2l_irqc_init(struct device_node *node, struct device_node *par=
ent)
+{
+	struct irq_domain *irq_domain, *parent_domain;
+	struct platform_device *pdev;
+	struct reset_control *resetn;
+	struct rzg2l_irqc_priv *priv;
+	int ret;
+
+	pdev =3D of_find_device_by_node(node);
+	if (!pdev)
+		return -ENODEV;
+
+	parent_domain =3D irq_find_host(parent);
+	if (!parent_domain) {
+		dev_err(&pdev->dev, "cannot find parent domain\n");
+		return -ENODEV;
+	}
+
+	priv =3D devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->base =3D devm_of_iomap(&pdev->dev, pdev->dev.of_node, 0, NULL);
+	if (IS_ERR(priv->base))
+		return PTR_ERR(priv->base);
+
+	ret =3D rzg2l_irqc_parse_interrupts(priv, node);
+	if (ret) {
+		dev_err(&pdev->dev, "cannot parse interrupts: %d\n", ret);
+		return ret;
+	}
+
+	resetn =3D devm_reset_control_get_exclusive(&pdev->dev, NULL);
+	if (IS_ERR(resetn))
+		return PTR_ERR(resetn);
+
+	ret =3D reset_control_deassert(resetn);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to deassert resetn pin, %d\n", ret);
+		return ret;
+	}
+
+	pm_runtime_enable(&pdev->dev);
+	ret =3D pm_runtime_resume_and_get(&pdev->dev);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "pm_runtime_resume_and_get failed: %d\n", ret);
+		goto pm_disable;
+	}
+
+	raw_spin_lock_init(&priv->lock);
+
+	irq_domain =3D irq_domain_add_hierarchy(parent_domain, 0, IRQC_NUM_IRQ,
+					      node, &rzg2l_irqc_domain_ops,
+					      priv);
+	if (!irq_domain) {
+		dev_err(&pdev->dev, "failed to add irq domain\n");
+		ret =3D -ENOMEM;
+		goto pm_put;
+	}
+
+	return 0;
+
+pm_put:
+	pm_runtime_put(&pdev->dev);
+pm_disable:
+	pm_runtime_disable(&pdev->dev);
+	reset_control_assert(resetn);
+	return ret;
+}
+
+IRQCHIP_PLATFORM_DRIVER_BEGIN(rzg2l_irqc)
+IRQCHIP_MATCH("renesas,rzg2l-irqc", rzg2l_irqc_init)
+IRQCHIP_PLATFORM_DRIVER_END(rzg2l_irqc)
+MODULE_AUTHOR("Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>");
+MODULE_DESCRIPTION("Renesas RZ/G2L IRQC Driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-p=
lic.c
index bb87e4c3b88e..ba4938188570 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -60,10 +60,13 @@
 #define	PLIC_DISABLE_THRESHOLD		0x7
 #define	PLIC_ENABLE_THRESHOLD		0
=20
+#define PLIC_QUIRK_EDGE_INTERRUPT	0
+
 struct plic_priv {
 	struct cpumask lmask;
 	struct irq_domain *irqdomain;
 	void __iomem *regs;
+	unsigned long plic_quirks;
 };
=20
 struct plic_handler {
@@ -81,6 +84,8 @@ static int plic_parent_irq __ro_after_init;
 static bool plic_cpuhp_setup_done __ro_after_init;
 static DEFINE_PER_CPU(struct plic_handler, plic_handlers);
=20
+static int plic_irq_set_type(struct irq_data *d, unsigned int type);
+
 static void __plic_toggle(void __iomem *enable_base, int hwirq, int enable)
 {
 	u32 __iomem *reg =3D enable_base + (hwirq / 32) * sizeof(u32);
@@ -103,37 +108,43 @@ static inline void plic_irq_toggle(const struct cpumask=
 *mask,
 				   struct irq_data *d, int enable)
 {
 	int cpu;
-	struct plic_priv *priv =3D irq_data_get_irq_chip_data(d);
=20
-	writel(enable, priv->regs + PRIORITY_BASE + d->hwirq * PRIORITY_PER_ID);
 	for_each_cpu(cpu, mask) {
 		struct plic_handler *handler =3D per_cpu_ptr(&plic_handlers, cpu);
=20
-		if (handler->present &&
-		    cpumask_test_cpu(cpu, &handler->priv->lmask))
-			plic_toggle(handler, d->hwirq, enable);
+		plic_toggle(handler, d->hwirq, enable);
 	}
 }
=20
+static void plic_irq_enable(struct irq_data *d)
+{
+	plic_irq_toggle(irq_data_get_effective_affinity_mask(d), d, 1);
+}
+
+static void plic_irq_disable(struct irq_data *d)
+{
+	plic_irq_toggle(irq_data_get_effective_affinity_mask(d), d, 0);
+}
+
 static void plic_irq_unmask(struct irq_data *d)
 {
-	struct cpumask amask;
-	unsigned int cpu;
 	struct plic_priv *priv =3D irq_data_get_irq_chip_data(d);
=20
-	cpumask_and(&amask, &priv->lmask, cpu_online_mask);
-	cpu =3D cpumask_any_and(irq_data_get_affinity_mask(d),
-					   &amask);
-	if (WARN_ON_ONCE(cpu >=3D nr_cpu_ids))
-		return;
-	plic_irq_toggle(cpumask_of(cpu), d, 1);
+	writel(1, priv->regs + PRIORITY_BASE + d->hwirq * PRIORITY_PER_ID);
 }
=20
 static void plic_irq_mask(struct irq_data *d)
 {
 	struct plic_priv *priv =3D irq_data_get_irq_chip_data(d);
=20
-	plic_irq_toggle(&priv->lmask, d, 0);
+	writel(0, priv->regs + PRIORITY_BASE + d->hwirq * PRIORITY_PER_ID);
+}
+
+static void plic_irq_eoi(struct irq_data *d)
+{
+	struct plic_handler *handler =3D this_cpu_ptr(&plic_handlers);
+
+	writel(d->hwirq, handler->hart_base + CONTEXT_CLAIM);
 }
=20
 #ifdef CONFIG_SMP
@@ -154,38 +165,68 @@ static int plic_set_affinity(struct irq_data *d,
 	if (cpu >=3D nr_cpu_ids)
 		return -EINVAL;
=20
-	plic_irq_toggle(&priv->lmask, d, 0);
-	plic_irq_toggle(cpumask_of(cpu), d, !irqd_irq_masked(d));
+	plic_irq_disable(d);
=20
 	irq_data_update_effective_affinity(d, cpumask_of(cpu));
=20
+	if (!irqd_irq_disabled(d))
+		plic_irq_enable(d);
+
 	return IRQ_SET_MASK_OK_DONE;
 }
 #endif
=20
-static void plic_irq_eoi(struct irq_data *d)
-{
-	struct plic_handler *handler =3D this_cpu_ptr(&plic_handlers);
-
-	if (irqd_irq_masked(d)) {
-		plic_irq_unmask(d);
-		writel(d->hwirq, handler->hart_base + CONTEXT_CLAIM);
-		plic_irq_mask(d);
-	} else {
-		writel(d->hwirq, handler->hart_base + CONTEXT_CLAIM);
-	}
-}
+static struct irq_chip plic_edge_chip =3D {
+	.name		=3D "SiFive PLIC",
+	.irq_enable	=3D plic_irq_enable,
+	.irq_disable	=3D plic_irq_disable,
+	.irq_ack	=3D plic_irq_eoi,
+	.irq_mask	=3D plic_irq_mask,
+	.irq_unmask	=3D plic_irq_unmask,
+#ifdef CONFIG_SMP
+	.irq_set_affinity =3D plic_set_affinity,
+#endif
+	.irq_set_type	=3D plic_irq_set_type,
+	.flags		=3D IRQCHIP_AFFINITY_PRE_STARTUP,
+};
=20
 static struct irq_chip plic_chip =3D {
 	.name		=3D "SiFive PLIC",
+	.irq_enable	=3D plic_irq_enable,
+	.irq_disable	=3D plic_irq_disable,
 	.irq_mask	=3D plic_irq_mask,
 	.irq_unmask	=3D plic_irq_unmask,
 	.irq_eoi	=3D plic_irq_eoi,
 #ifdef CONFIG_SMP
 	.irq_set_affinity =3D plic_set_affinity,
 #endif
+	.irq_set_type	=3D plic_irq_set_type,
+	.flags		=3D IRQCHIP_AFFINITY_PRE_STARTUP,
 };
=20
+static int plic_irq_set_type(struct irq_data *d, unsigned int type)
+{
+	struct plic_priv *priv =3D irq_data_get_irq_chip_data(d);
+
+	if (!test_bit(PLIC_QUIRK_EDGE_INTERRUPT, &priv->plic_quirks))
+		return IRQ_SET_MASK_OK_NOCOPY;
+
+	switch (type) {
+	case IRQ_TYPE_EDGE_RISING:
+		irq_set_chip_handler_name_locked(d, &plic_edge_chip,
+						 handle_edge_irq, NULL);
+		break;
+	case IRQ_TYPE_LEVEL_HIGH:
+		irq_set_chip_handler_name_locked(d, &plic_chip,
+						 handle_fasteoi_irq, NULL);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return IRQ_SET_MASK_OK;
+}
+
 static int plic_irqdomain_map(struct irq_domain *d, unsigned int irq,
 			      irq_hw_number_t hwirq)
 {
@@ -198,6 +239,19 @@ static int plic_irqdomain_map(struct irq_domain *d, unsi=
gned int irq,
 	return 0;
 }
=20
+static int plic_irq_domain_translate(struct irq_domain *d,
+				     struct irq_fwspec *fwspec,
+				     unsigned long *hwirq,
+				     unsigned int *type)
+{
+	struct plic_priv *priv =3D d->host_data;
+
+	if (test_bit(PLIC_QUIRK_EDGE_INTERRUPT, &priv->plic_quirks))
+		return irq_domain_translate_twocell(d, fwspec, hwirq, type);
+
+	return irq_domain_translate_onecell(d, fwspec, hwirq, type);
+}
+
 static int plic_irq_domain_alloc(struct irq_domain *domain, unsigned int vir=
q,
 				 unsigned int nr_irqs, void *arg)
 {
@@ -206,7 +260,7 @@ static int plic_irq_domain_alloc(struct irq_domain *domai=
n, unsigned int virq,
 	unsigned int type;
 	struct irq_fwspec *fwspec =3D arg;
=20
-	ret =3D irq_domain_translate_onecell(domain, fwspec, &hwirq, &type);
+	ret =3D plic_irq_domain_translate(domain, fwspec, &hwirq, &type);
 	if (ret)
 		return ret;
=20
@@ -220,7 +274,7 @@ static int plic_irq_domain_alloc(struct irq_domain *domai=
n, unsigned int virq,
 }
=20
 static const struct irq_domain_ops plic_irqdomain_ops =3D {
-	.translate	=3D irq_domain_translate_onecell,
+	.translate	=3D plic_irq_domain_translate,
 	.alloc		=3D plic_irq_domain_alloc,
 	.free		=3D irq_domain_free_irqs_top,
 };
@@ -281,8 +335,9 @@ static int plic_starting_cpu(unsigned int cpu)
 	return 0;
 }
=20
-static int __init plic_init(struct device_node *node,
-		struct device_node *parent)
+static int __init __plic_init(struct device_node *node,
+			      struct device_node *parent,
+			      unsigned long plic_quirks)
 {
 	int error =3D 0, nr_contexts, nr_handlers =3D 0, i;
 	u32 nr_irqs;
@@ -293,6 +348,8 @@ static int __init plic_init(struct device_node *node,
 	if (!priv)
 		return -ENOMEM;
=20
+	priv->plic_quirks =3D plic_quirks;
+
 	priv->regs =3D of_iomap(node, 0);
 	if (WARN_ON(!priv->regs)) {
 		error =3D -EIO;
@@ -382,8 +439,11 @@ static int __init plic_init(struct device_node *node,
 			i * CONTEXT_ENABLE_SIZE;
 		handler->priv =3D priv;
 done:
-		for (hwirq =3D 1; hwirq <=3D nr_irqs; hwirq++)
+		for (hwirq =3D 1; hwirq <=3D nr_irqs; hwirq++) {
 			plic_toggle(handler, hwirq, 0);
+			writel(1, priv->regs + PRIORITY_BASE +
+				  hwirq * PRIORITY_PER_ID);
+		}
 		nr_handlers++;
 	}
=20
@@ -410,6 +470,20 @@ static int __init plic_init(struct device_node *node,
 	return error;
 }
=20
+static int __init plic_init(struct device_node *node,
+			    struct device_node *parent)
+{
+	return __plic_init(node, parent, 0);
+}
+
 IRQCHIP_DECLARE(sifive_plic, "sifive,plic-1.0.0", plic_init);
 IRQCHIP_DECLARE(riscv_plic0, "riscv,plic0", plic_init); /* for legacy system=
s */
-IRQCHIP_DECLARE(thead_c900_plic, "thead,c900-plic", plic_init); /* for firmw=
are driver */
+
+static int __init plic_edge_init(struct device_node *node,
+				 struct device_node *parent)
+{
+	return __plic_init(node, parent, BIT(PLIC_QUIRK_EDGE_INTERRUPT));
+}
+
+IRQCHIP_DECLARE(andestech_nceplic100, "andestech,nceplic100", plic_edge_init=
);
+IRQCHIP_DECLARE(thead_c900_plic, "thead,c900-plic", plic_edge_init);
diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-ext=
i.c
index 9d18f47040eb..a73763d475f0 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -34,21 +34,15 @@ struct stm32_exti_bank {
 	u32 swier_ofst;
 	u32 rpr_ofst;
 	u32 fpr_ofst;
+	u32 trg_ofst;
 };
=20
 #define UNDEF_REG ~0
=20
-struct stm32_desc_irq {
-	u32 exti;
-	u32 irq_parent;
-	struct irq_chip *chip;
-};
-
 struct stm32_exti_drv_data {
 	const struct stm32_exti_bank **exti_banks;
-	const struct stm32_desc_irq *desc_irqs;
+	const u8 *desc_irqs;
 	u32 bank_nr;
-	u32 irq_nr;
 };
=20
 struct stm32_exti_chip_data {
@@ -78,6 +72,7 @@ static const struct stm32_exti_bank stm32f4xx_exti_b1 =3D {
 	.swier_ofst	=3D 0x10,
 	.rpr_ofst	=3D 0x14,
 	.fpr_ofst	=3D UNDEF_REG,
+	.trg_ofst	=3D UNDEF_REG,
 };
=20
 static const struct stm32_exti_bank *stm32f4xx_exti_banks[] =3D {
@@ -97,6 +92,7 @@ static const struct stm32_exti_bank stm32h7xx_exti_b1 =3D {
 	.swier_ofst	=3D 0x08,
 	.rpr_ofst	=3D 0x88,
 	.fpr_ofst	=3D UNDEF_REG,
+	.trg_ofst	=3D UNDEF_REG,
 };
=20
 static const struct stm32_exti_bank stm32h7xx_exti_b2 =3D {
@@ -107,6 +103,7 @@ static const struct stm32_exti_bank stm32h7xx_exti_b2 =3D=
 {
 	.swier_ofst	=3D 0x28,
 	.rpr_ofst	=3D 0x98,
 	.fpr_ofst	=3D UNDEF_REG,
+	.trg_ofst	=3D UNDEF_REG,
 };
=20
 static const struct stm32_exti_bank stm32h7xx_exti_b3 =3D {
@@ -117,6 +114,7 @@ static const struct stm32_exti_bank stm32h7xx_exti_b3 =3D=
 {
 	.swier_ofst	=3D 0x48,
 	.rpr_ofst	=3D 0xA8,
 	.fpr_ofst	=3D UNDEF_REG,
+	.trg_ofst	=3D UNDEF_REG,
 };
=20
 static const struct stm32_exti_bank *stm32h7xx_exti_banks[] =3D {
@@ -132,32 +130,35 @@ static const struct stm32_exti_drv_data stm32h7xx_drv_d=
ata =3D {
=20
 static const struct stm32_exti_bank stm32mp1_exti_b1 =3D {
 	.imr_ofst	=3D 0x80,
-	.emr_ofst	=3D 0x84,
+	.emr_ofst	=3D UNDEF_REG,
 	.rtsr_ofst	=3D 0x00,
 	.ftsr_ofst	=3D 0x04,
 	.swier_ofst	=3D 0x08,
 	.rpr_ofst	=3D 0x0C,
 	.fpr_ofst	=3D 0x10,
+	.trg_ofst	=3D 0x3EC,
 };
=20
 static const struct stm32_exti_bank stm32mp1_exti_b2 =3D {
 	.imr_ofst	=3D 0x90,
-	.emr_ofst	=3D 0x94,
+	.emr_ofst	=3D UNDEF_REG,
 	.rtsr_ofst	=3D 0x20,
 	.ftsr_ofst	=3D 0x24,
 	.swier_ofst	=3D 0x28,
 	.rpr_ofst	=3D 0x2C,
 	.fpr_ofst	=3D 0x30,
+	.trg_ofst	=3D 0x3E8,
 };
=20
 static const struct stm32_exti_bank stm32mp1_exti_b3 =3D {
 	.imr_ofst	=3D 0xA0,
-	.emr_ofst	=3D 0xA4,
+	.emr_ofst	=3D UNDEF_REG,
 	.rtsr_ofst	=3D 0x40,
 	.ftsr_ofst	=3D 0x44,
 	.swier_ofst	=3D 0x48,
 	.rpr_ofst	=3D 0x4C,
 	.fpr_ofst	=3D 0x50,
+	.trg_ofst	=3D 0x3E4,
 };
=20
 static const struct stm32_exti_bank *stm32mp1_exti_banks[] =3D {
@@ -169,126 +170,114 @@ static const struct stm32_exti_bank *stm32mp1_exti_ba=
nks[] =3D {
 static struct irq_chip stm32_exti_h_chip;
 static struct irq_chip stm32_exti_h_chip_direct;
=20
-static const struct stm32_desc_irq stm32mp1_desc_irq[] =3D {
-	{ .exti =3D 0, .irq_parent =3D 6, .chip =3D &stm32_exti_h_chip },
-	{ .exti =3D 1, .irq_parent =3D 7, .chip =3D &stm32_exti_h_chip },
-	{ .exti =3D 2, .irq_parent =3D 8, .chip =3D &stm32_exti_h_chip },
-	{ .exti =3D 3, .irq_parent =3D 9, .chip =3D &stm32_exti_h_chip },
-	{ .exti =3D 4, .irq_parent =3D 10, .chip =3D &stm32_exti_h_chip },
-	{ .exti =3D 5, .irq_parent =3D 23, .chip =3D &stm32_exti_h_chip },
-	{ .exti =3D 6, .irq_parent =3D 64, .chip =3D &stm32_exti_h_chip },
-	{ .exti =3D 7, .irq_parent =3D 65, .chip =3D &stm32_exti_h_chip },
-	{ .exti =3D 8, .irq_parent =3D 66, .chip =3D &stm32_exti_h_chip },
-	{ .exti =3D 9, .irq_parent =3D 67, .chip =3D &stm32_exti_h_chip },
-	{ .exti =3D 10, .irq_parent =3D 40, .chip =3D &stm32_exti_h_chip },
-	{ .exti =3D 11, .irq_parent =3D 42, .chip =3D &stm32_exti_h_chip },
-	{ .exti =3D 12, .irq_parent =3D 76, .chip =3D &stm32_exti_h_chip },
-	{ .exti =3D 13, .irq_parent =3D 77, .chip =3D &stm32_exti_h_chip },
-	{ .exti =3D 14, .irq_parent =3D 121, .chip =3D &stm32_exti_h_chip },
-	{ .exti =3D 15, .irq_parent =3D 127, .chip =3D &stm32_exti_h_chip },
-	{ .exti =3D 16, .irq_parent =3D 1, .chip =3D &stm32_exti_h_chip },
-	{ .exti =3D 19, .irq_parent =3D 3, .chip =3D &stm32_exti_h_chip_direct },
-	{ .exti =3D 21, .irq_parent =3D 31, .chip =3D &stm32_exti_h_chip_direct },
-	{ .exti =3D 22, .irq_parent =3D 33, .chip =3D &stm32_exti_h_chip_direct },
-	{ .exti =3D 23, .irq_parent =3D 72, .chip =3D &stm32_exti_h_chip_direct },
-	{ .exti =3D 24, .irq_parent =3D 95, .chip =3D &stm32_exti_h_chip_direct },
-	{ .exti =3D 25, .irq_parent =3D 107, .chip =3D &stm32_exti_h_chip_direct },
-	{ .exti =3D 26, .irq_parent =3D 37, .chip =3D &stm32_exti_h_chip_direct },
-	{ .exti =3D 27, .irq_parent =3D 38, .chip =3D &stm32_exti_h_chip_direct },
-	{ .exti =3D 28, .irq_parent =3D 39, .chip =3D &stm32_exti_h_chip_direct },
-	{ .exti =3D 29, .irq_parent =3D 71, .chip =3D &stm32_exti_h_chip_direct },
-	{ .exti =3D 30, .irq_parent =3D 52, .chip =3D &stm32_exti_h_chip_direct },
-	{ .exti =3D 31, .irq_parent =3D 53, .chip =3D &stm32_exti_h_chip_direct },
-	{ .exti =3D 32, .irq_parent =3D 82, .chip =3D &stm32_exti_h_chip_direct },
-	{ .exti =3D 33, .irq_parent =3D 83, .chip =3D &stm32_exti_h_chip_direct },
-	{ .exti =3D 47, .irq_parent =3D 93, .chip =3D &stm32_exti_h_chip_direct },
-	{ .exti =3D 48, .irq_parent =3D 138, .chip =3D &stm32_exti_h_chip_direct },
-	{ .exti =3D 50, .irq_parent =3D 139, .chip =3D &stm32_exti_h_chip_direct },
-	{ .exti =3D 52, .irq_parent =3D 140, .chip =3D &stm32_exti_h_chip_direct },
-	{ .exti =3D 53, .irq_parent =3D 141, .chip =3D &stm32_exti_h_chip_direct },
-	{ .exti =3D 54, .irq_parent =3D 135, .chip =3D &stm32_exti_h_chip_direct },
-	{ .exti =3D 61, .irq_parent =3D 100, .chip =3D &stm32_exti_h_chip_direct },
-	{ .exti =3D 65, .irq_parent =3D 144, .chip =3D &stm32_exti_h_chip },
-	{ .exti =3D 68, .irq_parent =3D 143, .chip =3D &stm32_exti_h_chip },
-	{ .exti =3D 70, .irq_parent =3D 62, .chip =3D &stm32_exti_h_chip_direct },
-	{ .exti =3D 73, .irq_parent =3D 129, .chip =3D &stm32_exti_h_chip },
+#define EXTI_INVALID_IRQ       U8_MAX
+#define STM32MP1_DESC_IRQ_SIZE (ARRAY_SIZE(stm32mp1_exti_banks) * IRQS_PER_B=
ANK)
+
+static const u8 stm32mp1_desc_irq[] =3D {
+	/* default value */
+	[0 ... (STM32MP1_DESC_IRQ_SIZE - 1)] =3D EXTI_INVALID_IRQ,
+
+	[0] =3D 6,
+	[1] =3D 7,
+	[2] =3D 8,
+	[3] =3D 9,
+	[4] =3D 10,
+	[5] =3D 23,
+	[6] =3D 64,
+	[7] =3D 65,
+	[8] =3D 66,
+	[9] =3D 67,
+	[10] =3D 40,
+	[11] =3D 42,
+	[12] =3D 76,
+	[13] =3D 77,
+	[14] =3D 121,
+	[15] =3D 127,
+	[16] =3D 1,
+	[19] =3D 3,
+	[21] =3D 31,
+	[22] =3D 33,
+	[23] =3D 72,
+	[24] =3D 95,
+	[25] =3D 107,
+	[26] =3D 37,
+	[27] =3D 38,
+	[28] =3D 39,
+	[29] =3D 71,
+	[30] =3D 52,
+	[31] =3D 53,
+	[32] =3D 82,
+	[33] =3D 83,
+	[47] =3D 93,
+	[48] =3D 138,
+	[50] =3D 139,
+	[52] =3D 140,
+	[53] =3D 141,
+	[54] =3D 135,
+	[61] =3D 100,
+	[65] =3D 144,
+	[68] =3D 143,
+	[70] =3D 62,
+	[73] =3D 129,
 };
=20
-static const struct stm32_desc_irq stm32mp13_desc_irq[] =3D {
-	{ .exti =3D 0, .irq_parent =3D 6, .chip =3D &stm32_exti_h_chip },
-	{ .exti =3D 1, .irq_parent =3D 7, .chip =3D &stm32_exti_h_chip },
-	{ .exti =3D 2, .irq_parent =3D 8, .chip =3D &stm32_exti_h_chip },
-	{ .exti =3D 3, .irq_parent =3D 9, .chip =3D &stm32_exti_h_chip },
-	{ .exti =3D 4, .irq_parent =3D 10, .chip =3D &stm32_exti_h_chip },
-	{ .exti =3D 5, .irq_parent =3D 24, .chip =3D &stm32_exti_h_chip },
-	{ .exti =3D 6, .irq_parent =3D 65, .chip =3D &stm32_exti_h_chip },
-	{ .exti =3D 7, .irq_parent =3D 66, .chip =3D &stm32_exti_h_chip },
-	{ .exti =3D 8, .irq_parent =3D 67, .chip =3D &stm32_exti_h_chip },
-	{ .exti =3D 9, .irq_parent =3D 68, .chip =3D &stm32_exti_h_chip },
-	{ .exti =3D 10, .irq_parent =3D 41, .chip =3D &stm32_exti_h_chip },
-	{ .exti =3D 11, .irq_parent =3D 43, .chip =3D &stm32_exti_h_chip },
-	{ .exti =3D 12, .irq_parent =3D 77, .chip =3D &stm32_exti_h_chip },
-	{ .exti =3D 13, .irq_parent =3D 78, .chip =3D &stm32_exti_h_chip },
-	{ .exti =3D 14, .irq_parent =3D 106, .chip =3D &stm32_exti_h_chip },
-	{ .exti =3D 15, .irq_parent =3D 109, .chip =3D &stm32_exti_h_chip },
-	{ .exti =3D 16, .irq_parent =3D 1, .chip =3D &stm32_exti_h_chip },
-	{ .exti =3D 19, .irq_parent =3D 3, .chip =3D &stm32_exti_h_chip_direct },
-	{ .exti =3D 21, .irq_parent =3D 32, .chip =3D &stm32_exti_h_chip_direct },
-	{ .exti =3D 22, .irq_parent =3D 34, .chip =3D &stm32_exti_h_chip_direct },
-	{ .exti =3D 23, .irq_parent =3D 73, .chip =3D &stm32_exti_h_chip_direct },
-	{ .exti =3D 24, .irq_parent =3D 93, .chip =3D &stm32_exti_h_chip_direct },
-	{ .exti =3D 25, .irq_parent =3D 114, .chip =3D &stm32_exti_h_chip_direct },
-	{ .exti =3D 26, .irq_parent =3D 38, .chip =3D &stm32_exti_h_chip_direct },
-	{ .exti =3D 27, .irq_parent =3D 39, .chip =3D &stm32_exti_h_chip_direct },
-	{ .exti =3D 28, .irq_parent =3D 40, .chip =3D &stm32_exti_h_chip_direct },
-	{ .exti =3D 29, .irq_parent =3D 72, .chip =3D &stm32_exti_h_chip_direct },
-	{ .exti =3D 30, .irq_parent =3D 53, .chip =3D &stm32_exti_h_chip_direct },
-	{ .exti =3D 31, .irq_parent =3D 54, .chip =3D &stm32_exti_h_chip_direct },
-	{ .exti =3D 32, .irq_parent =3D 83, .chip =3D &stm32_exti_h_chip_direct },
-	{ .exti =3D 33, .irq_parent =3D 84, .chip =3D &stm32_exti_h_chip_direct },
-	{ .exti =3D 44, .irq_parent =3D 96, .chip =3D &stm32_exti_h_chip_direct },
-	{ .exti =3D 47, .irq_parent =3D 92, .chip =3D &stm32_exti_h_chip_direct },
-	{ .exti =3D 48, .irq_parent =3D 116, .chip =3D &stm32_exti_h_chip_direct },
-	{ .exti =3D 50, .irq_parent =3D 117, .chip =3D &stm32_exti_h_chip_direct },
-	{ .exti =3D 52, .irq_parent =3D 118, .chip =3D &stm32_exti_h_chip_direct },
-	{ .exti =3D 53, .irq_parent =3D 119, .chip =3D &stm32_exti_h_chip_direct },
-	{ .exti =3D 68, .irq_parent =3D 63, .chip =3D &stm32_exti_h_chip_direct },
-	{ .exti =3D 70, .irq_parent =3D 98, .chip =3D &stm32_exti_h_chip_direct },
+static const u8 stm32mp13_desc_irq[] =3D {
+	/* default value */
+	[0 ... (STM32MP1_DESC_IRQ_SIZE - 1)] =3D EXTI_INVALID_IRQ,
+
+	[0] =3D 6,
+	[1] =3D 7,
+	[2] =3D 8,
+	[3] =3D 9,
+	[4] =3D 10,
+	[5] =3D 24,
+	[6] =3D 65,
+	[7] =3D 66,
+	[8] =3D 67,
+	[9] =3D 68,
+	[10] =3D 41,
+	[11] =3D 43,
+	[12] =3D 77,
+	[13] =3D 78,
+	[14] =3D 106,
+	[15] =3D 109,
+	[16] =3D 1,
+	[19] =3D 3,
+	[21] =3D 32,
+	[22] =3D 34,
+	[23] =3D 73,
+	[24] =3D 93,
+	[25] =3D 114,
+	[26] =3D 38,
+	[27] =3D 39,
+	[28] =3D 40,
+	[29] =3D 72,
+	[30] =3D 53,
+	[31] =3D 54,
+	[32] =3D 83,
+	[33] =3D 84,
+	[44] =3D 96,
+	[47] =3D 92,
+	[48] =3D 116,
+	[50] =3D 117,
+	[52] =3D 118,
+	[53] =3D 119,
+	[68] =3D 63,
+	[70] =3D 98,
 };
=20
 static const struct stm32_exti_drv_data stm32mp1_drv_data =3D {
 	.exti_banks =3D stm32mp1_exti_banks,
 	.bank_nr =3D ARRAY_SIZE(stm32mp1_exti_banks),
 	.desc_irqs =3D stm32mp1_desc_irq,
-	.irq_nr =3D ARRAY_SIZE(stm32mp1_desc_irq),
 };
=20
 static const struct stm32_exti_drv_data stm32mp13_drv_data =3D {
 	.exti_banks =3D stm32mp1_exti_banks,
 	.bank_nr =3D ARRAY_SIZE(stm32mp1_exti_banks),
 	.desc_irqs =3D stm32mp13_desc_irq,
-	.irq_nr =3D ARRAY_SIZE(stm32mp13_desc_irq),
 };
=20
-static const struct
-stm32_desc_irq *stm32_exti_get_desc(const struct stm32_exti_drv_data *drv_da=
ta,
-				    irq_hw_number_t hwirq)
-{
-	const struct stm32_desc_irq *desc =3D NULL;
-	int i;
-
-	if (!drv_data->desc_irqs)
-		return NULL;
-
-	for (i =3D 0; i < drv_data->irq_nr; i++) {
-		desc =3D &drv_data->desc_irqs[i];
-		if (desc->exti =3D=3D hwirq)
-			break;
-	}
-
-	return desc;
-}
-
 static unsigned long stm32_exti_pending(struct irq_chip_generic *gc)
 {
 	struct stm32_exti_chip_data *chip_data =3D gc->private;
@@ -614,7 +603,7 @@ static int stm32_exti_h_set_affinity(struct irq_data *d,
 	if (d->parent_data->chip)
 		return irq_chip_set_affinity_parent(d, dest, force);
=20
-	return -EINVAL;
+	return IRQ_SET_MASK_OK_DONE;
 }
=20
 static int __maybe_unused stm32_exti_h_suspend(void)
@@ -691,8 +680,8 @@ static struct irq_chip stm32_exti_h_chip_direct =3D {
 	.name			=3D "stm32-exti-h-direct",
 	.irq_eoi		=3D irq_chip_eoi_parent,
 	.irq_ack		=3D irq_chip_ack_parent,
-	.irq_mask		=3D irq_chip_mask_parent,
-	.irq_unmask		=3D irq_chip_unmask_parent,
+	.irq_mask		=3D stm32_exti_h_mask,
+	.irq_unmask		=3D stm32_exti_h_unmask,
 	.irq_retrigger		=3D irq_chip_retrigger_hierarchy,
 	.irq_set_type		=3D irq_chip_set_type_parent,
 	.irq_set_wake		=3D stm32_exti_h_set_wake,
@@ -706,28 +695,36 @@ static int stm32_exti_h_domain_alloc(struct irq_domain =
*dm,
 {
 	struct stm32_exti_host_data *host_data =3D dm->host_data;
 	struct stm32_exti_chip_data *chip_data;
-	const struct stm32_desc_irq *desc;
+	u8 desc_irq;
 	struct irq_fwspec *fwspec =3D data;
 	struct irq_fwspec p_fwspec;
 	irq_hw_number_t hwirq;
 	int bank;
+	u32 event_trg;
+	struct irq_chip *chip;
=20
 	hwirq =3D fwspec->param[0];
+	if (hwirq >=3D host_data->drv_data->bank_nr * IRQS_PER_BANK)
+		return -EINVAL;
+
 	bank  =3D hwirq / IRQS_PER_BANK;
 	chip_data =3D &host_data->chips_data[bank];
=20
+	event_trg =3D readl_relaxed(host_data->base + chip_data->reg_bank->trg_ofst=
);
+	chip =3D (event_trg & BIT(hwirq % IRQS_PER_BANK)) ?
+	       &stm32_exti_h_chip : &stm32_exti_h_chip_direct;
+
+	irq_domain_set_hwirq_and_chip(dm, virq, hwirq, chip, chip_data);
=20
-	desc =3D stm32_exti_get_desc(host_data->drv_data, hwirq);
-	if (!desc)
+	if (!host_data->drv_data || !host_data->drv_data->desc_irqs)
 		return -EINVAL;
=20
-	irq_domain_set_hwirq_and_chip(dm, virq, hwirq, desc->chip,
-				      chip_data);
-	if (desc->irq_parent) {
+	desc_irq =3D host_data->drv_data->desc_irqs[hwirq];
+	if (desc_irq !=3D EXTI_INVALID_IRQ) {
 		p_fwspec.fwnode =3D dm->parent->fwnode;
 		p_fwspec.param_count =3D 3;
 		p_fwspec.param[0] =3D GIC_SPI;
-		p_fwspec.param[1] =3D desc->irq_parent;
+		p_fwspec.param[1] =3D desc_irq;
 		p_fwspec.param[2] =3D IRQ_TYPE_LEVEL_HIGH;
=20
 		return irq_domain_alloc_irqs_parent(dm, virq, 1, &p_fwspec);
@@ -792,7 +789,8 @@ stm32_exti_chip_data *stm32_exti_chip_init(struct stm32_e=
xti_host_data *h_data,
 	 * clear registers to avoid residue
 	 */
 	writel_relaxed(0, base + stm32_bank->imr_ofst);
-	writel_relaxed(0, base + stm32_bank->emr_ofst);
+	if (stm32_bank->emr_ofst !=3D UNDEF_REG)
+		writel_relaxed(0, base + stm32_bank->emr_ofst);
=20
 	pr_info("%pOF: bank%d\n", node, bank_idx);
=20
diff --git a/drivers/parisc/iosapic.c b/drivers/parisc/iosapic.c
index 8a3b0c3a1e92..3a8c98615634 100644
--- a/drivers/parisc/iosapic.c
+++ b/drivers/parisc/iosapic.c
@@ -677,7 +677,7 @@ static int iosapic_set_affinity_irq(struct irq_data *d,
 	if (dest_cpu < 0)
 		return -1;
=20
-	cpumask_copy(irq_data_get_affinity_mask(d), cpumask_of(dest_cpu));
+	irq_data_update_affinity(d, cpumask_of(dest_cpu));
 	vi->txn_addr =3D txn_affinity_addr(d->irq, dest_cpu);
=20
 	spin_lock_irqsave(&iosapic_lock, flags);
diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci=
-hyperv.c
index db814f7b93ba..e7c6f6629e7c 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -642,7 +642,7 @@ static void hv_arch_irq_unmask(struct irq_data *data)
 	struct hv_retarget_device_interrupt *params;
 	struct tran_int_desc *int_desc;
 	struct hv_pcibus_device *hbus;
-	struct cpumask *dest;
+	const struct cpumask *dest;
 	cpumask_var_t tmp;
 	struct pci_bus *pbus;
 	struct pci_dev *pdev;
@@ -1613,7 +1613,7 @@ static void hv_pci_compose_compl(void *context, struct =
pci_response *resp,
 }
=20
 static u32 hv_compose_msi_req_v1(
-	struct pci_create_interrupt *int_pkt, struct cpumask *affinity,
+	struct pci_create_interrupt *int_pkt, const struct cpumask *affinity,
 	u32 slot, u8 vector, u8 vector_count)
 {
 	int_pkt->message_type.type =3D PCI_CREATE_INTERRUPT_MESSAGE;
@@ -1635,13 +1635,13 @@ static u32 hv_compose_msi_req_v1(
  * Create MSI w/ dummy vCPU set targeting just one vCPU, overwritten
  * by subsequent retarget in hv_irq_unmask().
  */
-static int hv_compose_msi_req_get_cpu(struct cpumask *affinity)
+static int hv_compose_msi_req_get_cpu(const struct cpumask *affinity)
 {
 	return cpumask_first_and(affinity, cpu_online_mask);
 }
=20
 static u32 hv_compose_msi_req_v2(
-	struct pci_create_interrupt2 *int_pkt, struct cpumask *affinity,
+	struct pci_create_interrupt2 *int_pkt, const struct cpumask *affinity,
 	u32 slot, u8 vector, u8 vector_count)
 {
 	int cpu;
@@ -1660,7 +1660,7 @@ static u32 hv_compose_msi_req_v2(
 }
=20
 static u32 hv_compose_msi_req_v3(
-	struct pci_create_interrupt3 *int_pkt, struct cpumask *affinity,
+	struct pci_create_interrupt3 *int_pkt, const struct cpumask *affinity,
 	u32 slot, u32 vector, u8 vector_count)
 {
 	int cpu;
@@ -1697,7 +1697,7 @@ static void hv_compose_msi_msg(struct irq_data *data, s=
truct msi_msg *msg)
 	struct hv_pci_dev *hpdev;
 	struct pci_bus *pbus;
 	struct pci_dev *pdev;
-	struct cpumask *dest;
+	const struct cpumask *dest;
 	struct compose_comp_ctxt comp;
 	struct tran_int_desc *int_desc;
 	struct msi_desc *msi_desc;
diff --git a/drivers/pinctrl/pinctrl-ocelot.c b/drivers/pinctrl/pinctrl-ocelo=
t.c
index 5f4a8c5c6650..425c1a9883fd 100644
--- a/drivers/pinctrl/pinctrl-ocelot.c
+++ b/drivers/pinctrl/pinctrl-ocelot.c
@@ -1761,6 +1761,7 @@ static void ocelot_irq_mask(struct irq_data *data)
=20
 	regmap_update_bits(info->map, REG(OCELOT_GPIO_INTR_ENA, info, gpio),
 			   BIT(gpio % 32), 0);
+	gpiochip_disable_irq(chip, gpio);
 }
=20
 static void ocelot_irq_unmask(struct irq_data *data)
@@ -1769,6 +1770,7 @@ static void ocelot_irq_unmask(struct irq_data *data)
 	struct ocelot_pinctrl *info =3D gpiochip_get_data(chip);
 	unsigned int gpio =3D irqd_to_hwirq(data);
=20
+	gpiochip_enable_irq(chip, gpio);
 	regmap_update_bits(info->map, REG(OCELOT_GPIO_INTR_ENA, info, gpio),
 			   BIT(gpio % 32), BIT(gpio % 32));
 }
@@ -1790,8 +1792,10 @@ static struct irq_chip ocelot_eoi_irqchip =3D {
 	.irq_mask	=3D ocelot_irq_mask,
 	.irq_eoi	=3D ocelot_irq_ack,
 	.irq_unmask	=3D ocelot_irq_unmask,
-	.flags          =3D IRQCHIP_EOI_THREADED | IRQCHIP_EOI_IF_HANDLED,
+	.flags          =3D IRQCHIP_EOI_THREADED | IRQCHIP_EOI_IF_HANDLED |
+			  IRQCHIP_IMMUTABLE,
 	.irq_set_type	=3D ocelot_irq_set_type,
+	GPIOCHIP_IRQ_RESOURCE_HELPERS
 };
=20
 static struct irq_chip ocelot_irqchip =3D {
@@ -1800,6 +1804,8 @@ static struct irq_chip ocelot_irqchip =3D {
 	.irq_ack	=3D ocelot_irq_ack,
 	.irq_unmask	=3D ocelot_irq_unmask,
 	.irq_set_type	=3D ocelot_irq_set_type,
+	.flags          =3D IRQCHIP_IMMUTABLE,
+	GPIOCHIP_IRQ_RESOURCE_HELPERS
 };
=20
 static int ocelot_irq_set_type(struct irq_data *data, unsigned int type)
@@ -1863,7 +1869,7 @@ static int ocelot_gpiochip_register(struct platform_dev=
ice *pdev,
 	irq =3D platform_get_irq_optional(pdev, 0);
 	if (irq > 0) {
 		girq =3D &gc->irq;
-		girq->chip =3D &ocelot_irqchip;
+		gpio_irq_chip_set_chip(girq, &ocelot_irqchip);
 		girq->parent_handler =3D ocelot_irq_handler;
 		girq->num_parents =3D 1;
 		girq->parents =3D devm_kcalloc(&pdev->dev, 1,
diff --git a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c b/drivers/pinctrl/qcom/=
pinctrl-spmi-gpio.c
index fd5fff9adff0..3be2a08ae3a6 100644
--- a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
+++ b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
@@ -966,16 +966,13 @@ static int pmic_gpio_child_to_parent_hwirq(struct gpio_=
chip *chip,
 	return 0;
 }
=20
-static void *pmic_gpio_populate_parent_fwspec(struct gpio_chip *chip,
-					     unsigned int parent_hwirq,
-					     unsigned int parent_type)
+static int pmic_gpio_populate_parent_fwspec(struct gpio_chip *chip,
+					    union gpio_irq_fwspec *gfwspec,
+					    unsigned int parent_hwirq,
+					    unsigned int parent_type)
 {
 	struct pmic_gpio_state *state =3D gpiochip_get_data(chip);
-	struct irq_fwspec *fwspec;
-
-	fwspec =3D kzalloc(sizeof(*fwspec), GFP_KERNEL);
-	if (!fwspec)
-		return NULL;
+	struct irq_fwspec *fwspec =3D &gfwspec->fwspec;
=20
 	fwspec->fwnode =3D chip->irq.parent_domain->fwnode;
=20
@@ -985,7 +982,7 @@ static void *pmic_gpio_populate_parent_fwspec(struct gpio=
_chip *chip,
 	/* param[2] must be left as 0 */
 	fwspec->param[3] =3D parent_type;
=20
-	return fwspec;
+	return 0;
 }
=20
 static int pmic_gpio_probe(struct platform_device *pdev)
diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesa=
s/pinctrl-rzg2l.c
index a48cac55152c..c47eed9d948f 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -9,8 +9,10 @@
 #include <linux/clk.h>
 #include <linux/gpio/driver.h>
 #include <linux/io.h>
+#include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
+#include <linux/of_irq.h>
 #include <linux/pinctrl/pinconf-generic.h>
 #include <linux/pinctrl/pinconf.h>
 #include <linux/pinctrl/pinctrl.h>
@@ -89,6 +91,7 @@
 #define PIN(n)			(0x0800 + 0x10 + (n))
 #define IOLH(n)			(0x1000 + (n) * 8)
 #define IEN(n)			(0x1800 + (n) * 8)
+#define ISEL(n)			(0x2c80 + (n) * 8)
 #define PWPR			(0x3014)
 #define SD_CH(n)		(0x3000 + (n) * 4)
 #define QSPI			(0x3008)
@@ -112,6 +115,10 @@
 #define RZG2L_PIN_ID_TO_PORT_OFFSET(id)	(RZG2L_PIN_ID_TO_PORT(id) + 0x10)
 #define RZG2L_PIN_ID_TO_PIN(id)		((id) % RZG2L_PINS_PER_PORT)
=20
+#define RZG2L_TINT_MAX_INTERRUPT	32
+#define RZG2L_TINT_IRQ_START_INDEX	9
+#define RZG2L_PACK_HWIRQ(t, i)		(((t) << 16) | (i))
+
 struct rzg2l_dedicated_configs {
 	const char *name;
 	u32 config;
@@ -137,6 +144,9 @@ struct rzg2l_pinctrl {
=20
 	struct gpio_chip		gpio_chip;
 	struct pinctrl_gpio_range	gpio_range;
+	DECLARE_BITMAP(tint_slot, RZG2L_TINT_MAX_INTERRUPT);
+	spinlock_t			bitmap_lock;
+	unsigned int			hwirq[RZG2L_TINT_MAX_INTERRUPT];
=20
 	spinlock_t			lock;
 };
@@ -883,8 +893,14 @@ static int rzg2l_gpio_get(struct gpio_chip *chip, unsign=
ed int offset)
=20
 static void rzg2l_gpio_free(struct gpio_chip *chip, unsigned int offset)
 {
+	unsigned int virq;
+
 	pinctrl_gpio_free(chip->base + offset);
=20
+	virq =3D irq_find_mapping(chip->irq.domain, offset);
+	if (virq)
+		irq_dispose_mapping(virq);
+
 	/*
 	 * Set the GPIO as an input to ensure that the next GPIO request won't
 	 * drive the GPIO pin as an output.
@@ -1104,14 +1120,221 @@ static struct {
 	}
 };
=20
+static int rzg2l_gpio_get_gpioint(unsigned int virq)
+{
+	unsigned int gpioint;
+	unsigned int i;
+	u32 port, bit;
+
+	port =3D virq / 8;
+	bit =3D virq % 8;
+
+	if (port >=3D ARRAY_SIZE(rzg2l_gpio_configs) ||
+	    bit >=3D RZG2L_GPIO_PORT_GET_PINCNT(rzg2l_gpio_configs[port]))
+		return -EINVAL;
+
+	gpioint =3D bit;
+	for (i =3D 0; i < port; i++)
+		gpioint +=3D RZG2L_GPIO_PORT_GET_PINCNT(rzg2l_gpio_configs[i]);
+
+	return gpioint;
+}
+
+static void rzg2l_gpio_irq_disable(struct irq_data *d)
+{
+	struct gpio_chip *gc =3D irq_data_get_irq_chip_data(d);
+	struct rzg2l_pinctrl *pctrl =3D container_of(gc, struct rzg2l_pinctrl, gpio=
_chip);
+	unsigned int hwirq =3D irqd_to_hwirq(d);
+	unsigned long flags;
+	void __iomem *addr;
+	u32 port;
+	u8 bit;
+
+	port =3D RZG2L_PIN_ID_TO_PORT(hwirq);
+	bit =3D RZG2L_PIN_ID_TO_PIN(hwirq);
+
+	addr =3D pctrl->base + ISEL(port);
+	if (bit >=3D 4) {
+		bit -=3D 4;
+		addr +=3D 4;
+	}
+
+	spin_lock_irqsave(&pctrl->lock, flags);
+	writel(readl(addr) & ~BIT(bit * 8), addr);
+	spin_unlock_irqrestore(&pctrl->lock, flags);
+
+	gpiochip_disable_irq(gc, hwirq);
+	irq_chip_disable_parent(d);
+}
+
+static void rzg2l_gpio_irq_enable(struct irq_data *d)
+{
+	struct gpio_chip *gc =3D irq_data_get_irq_chip_data(d);
+	struct rzg2l_pinctrl *pctrl =3D container_of(gc, struct rzg2l_pinctrl, gpio=
_chip);
+	unsigned int hwirq =3D irqd_to_hwirq(d);
+	unsigned long flags;
+	void __iomem *addr;
+	u32 port;
+	u8 bit;
+
+	gpiochip_enable_irq(gc, hwirq);
+
+	port =3D RZG2L_PIN_ID_TO_PORT(hwirq);
+	bit =3D RZG2L_PIN_ID_TO_PIN(hwirq);
+
+	addr =3D pctrl->base + ISEL(port);
+	if (bit >=3D 4) {
+		bit -=3D 4;
+		addr +=3D 4;
+	}
+
+	spin_lock_irqsave(&pctrl->lock, flags);
+	writel(readl(addr) | BIT(bit * 8), addr);
+	spin_unlock_irqrestore(&pctrl->lock, flags);
+
+	irq_chip_enable_parent(d);
+}
+
+static int rzg2l_gpio_irq_set_type(struct irq_data *d, unsigned int type)
+{
+	return irq_chip_set_type_parent(d, type);
+}
+
+static void rzg2l_gpio_irqc_eoi(struct irq_data *d)
+{
+	irq_chip_eoi_parent(d);
+}
+
+static void rzg2l_gpio_irq_print_chip(struct irq_data *data, struct seq_file=
 *p)
+{
+	struct gpio_chip *gc =3D irq_data_get_irq_chip_data(data);
+
+	seq_printf(p, dev_name(gc->parent));
+}
+
+static const struct irq_chip rzg2l_gpio_irqchip =3D {
+	.name =3D "rzg2l-gpio",
+	.irq_disable =3D rzg2l_gpio_irq_disable,
+	.irq_enable =3D rzg2l_gpio_irq_enable,
+	.irq_mask =3D irq_chip_mask_parent,
+	.irq_unmask =3D irq_chip_unmask_parent,
+	.irq_set_type =3D rzg2l_gpio_irq_set_type,
+	.irq_eoi =3D rzg2l_gpio_irqc_eoi,
+	.irq_print_chip =3D rzg2l_gpio_irq_print_chip,
+	.flags =3D IRQCHIP_IMMUTABLE,
+	GPIOCHIP_IRQ_RESOURCE_HELPERS,
+};
+
+static int rzg2l_gpio_child_to_parent_hwirq(struct gpio_chip *gc,
+					    unsigned int child,
+					    unsigned int child_type,
+					    unsigned int *parent,
+					    unsigned int *parent_type)
+{
+	struct rzg2l_pinctrl *pctrl =3D gpiochip_get_data(gc);
+	unsigned long flags;
+	int gpioint, irq;
+
+	gpioint =3D rzg2l_gpio_get_gpioint(child);
+	if (gpioint < 0)
+		return gpioint;
+
+	spin_lock_irqsave(&pctrl->bitmap_lock, flags);
+	irq =3D bitmap_find_free_region(pctrl->tint_slot, RZG2L_TINT_MAX_INTERRUPT,=
 get_order(1));
+	spin_unlock_irqrestore(&pctrl->bitmap_lock, flags);
+	if (irq < 0)
+		return -ENOSPC;
+	pctrl->hwirq[irq] =3D child;
+	irq +=3D RZG2L_TINT_IRQ_START_INDEX;
+
+	/* All these interrupts are level high in the CPU */
+	*parent_type =3D IRQ_TYPE_LEVEL_HIGH;
+	*parent =3D RZG2L_PACK_HWIRQ(gpioint, irq);
+	return 0;
+}
+
+static int rzg2l_gpio_populate_parent_fwspec(struct gpio_chip *chip,
+					     union gpio_irq_fwspec *gfwspec,
+					     unsigned int parent_hwirq,
+					     unsigned int parent_type)
+{
+	struct irq_fwspec *fwspec =3D &gfwspec->fwspec;
+
+	fwspec->fwnode =3D chip->irq.parent_domain->fwnode;
+	fwspec->param_count =3D 2;
+	fwspec->param[0] =3D parent_hwirq;
+	fwspec->param[1] =3D parent_type;
+
+	return 0;
+}
+
+static void rzg2l_gpio_irq_domain_free(struct irq_domain *domain, unsigned i=
nt virq,
+				       unsigned int nr_irqs)
+{
+	struct irq_data *d;
+
+	d =3D irq_domain_get_irq_data(domain, virq);
+	if (d) {
+		struct gpio_chip *gc =3D irq_data_get_irq_chip_data(d);
+		struct rzg2l_pinctrl *pctrl =3D container_of(gc, struct rzg2l_pinctrl, gpi=
o_chip);
+		irq_hw_number_t hwirq =3D irqd_to_hwirq(d);
+		unsigned long flags;
+		unsigned int i;
+
+		for (i =3D 0; i < RZG2L_TINT_MAX_INTERRUPT; i++) {
+			if (pctrl->hwirq[i] =3D=3D hwirq) {
+				spin_lock_irqsave(&pctrl->bitmap_lock, flags);
+				bitmap_release_region(pctrl->tint_slot, i, get_order(1));
+				spin_unlock_irqrestore(&pctrl->bitmap_lock, flags);
+				pctrl->hwirq[i] =3D 0;
+				break;
+			}
+		}
+	}
+	irq_domain_free_irqs_common(domain, virq, nr_irqs);
+}
+
+static void rzg2l_init_irq_valid_mask(struct gpio_chip *gc,
+				      unsigned long *valid_mask,
+				      unsigned int ngpios)
+{
+	struct rzg2l_pinctrl *pctrl =3D gpiochip_get_data(gc);
+	struct gpio_chip *chip =3D &pctrl->gpio_chip;
+	unsigned int offset;
+
+	/* Forbid unused lines to be mapped as IRQs */
+	for (offset =3D 0; offset < chip->ngpio; offset++) {
+		u32 port, bit;
+
+		port =3D offset / 8;
+		bit =3D offset % 8;
+
+		if (port >=3D ARRAY_SIZE(rzg2l_gpio_configs) ||
+		    bit >=3D RZG2L_GPIO_PORT_GET_PINCNT(rzg2l_gpio_configs[port]))
+			clear_bit(offset, valid_mask);
+	}
+}
+
 static int rzg2l_gpio_register(struct rzg2l_pinctrl *pctrl)
 {
 	struct device_node *np =3D pctrl->dev->of_node;
 	struct gpio_chip *chip =3D &pctrl->gpio_chip;
 	const char *name =3D dev_name(pctrl->dev);
+	struct irq_domain *parent_domain;
 	struct of_phandle_args of_args;
+	struct device_node *parent_np;
+	struct gpio_irq_chip *girq;
 	int ret;
=20
+	parent_np =3D of_irq_find_parent(np);
+	if (!parent_np)
+		return -ENXIO;
+
+	parent_domain =3D irq_find_host(parent_np);
+	of_node_put(parent_np);
+	if (!parent_domain)
+		return -EPROBE_DEFER;
+
 	ret =3D of_parse_phandle_with_fixed_args(np, "gpio-ranges", 3, 0, &of_args);
 	if (ret) {
 		dev_err(pctrl->dev, "Unable to parse gpio-ranges\n");
@@ -1138,6 +1361,15 @@ static int rzg2l_gpio_register(struct rzg2l_pinctrl *p=
ctrl)
 	chip->base =3D -1;
 	chip->ngpio =3D of_args.args[2];
=20
+	girq =3D &chip->irq;
+	gpio_irq_chip_set_chip(girq, &rzg2l_gpio_irqchip);
+	girq->fwnode =3D of_node_to_fwnode(np);
+	girq->parent_domain =3D parent_domain;
+	girq->child_to_parent_hwirq =3D rzg2l_gpio_child_to_parent_hwirq;
+	girq->populate_parent_alloc_arg =3D rzg2l_gpio_populate_parent_fwspec;
+	girq->child_irq_domain_ops.free =3D rzg2l_gpio_irq_domain_free;
+	girq->init_valid_mask =3D rzg2l_init_irq_valid_mask;
+
 	pctrl->gpio_range.id =3D 0;
 	pctrl->gpio_range.pin_base =3D 0;
 	pctrl->gpio_range.base =3D 0;
@@ -1253,6 +1485,7 @@ static int rzg2l_pinctrl_probe(struct platform_device *=
pdev)
 	}
=20
 	spin_lock_init(&pctrl->lock);
+	spin_lock_init(&pctrl->bitmap_lock);
=20
 	platform_set_drvdata(pdev, pctrl);
=20
diff --git a/drivers/sh/intc/chip.c b/drivers/sh/intc/chip.c
index 358df7510186..828d81e02b37 100644
--- a/drivers/sh/intc/chip.c
+++ b/drivers/sh/intc/chip.c
@@ -72,7 +72,7 @@ static int intc_set_affinity(struct irq_data *data,
 	if (!cpumask_intersects(cpumask, cpu_online_mask))
 		return -1;
=20
-	cpumask_copy(irq_data_get_affinity_mask(data), cpumask);
+	irq_data_update_affinity(data, cpumask);
=20
 	return IRQ_SET_MASK_OK_NOCOPY;
 }
diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_bas=
e.c
index 46d9295d9a6e..5e8321f43cbd 100644
--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -528,9 +528,10 @@ static void bind_evtchn_to_cpu(evtchn_port_t evtchn, uns=
igned int cpu,
 	BUG_ON(irq =3D=3D -1);
=20
 	if (IS_ENABLED(CONFIG_SMP) && force_affinity) {
-		cpumask_copy(irq_get_affinity_mask(irq), cpumask_of(cpu));
-		cpumask_copy(irq_get_effective_affinity_mask(irq),
-			     cpumask_of(cpu));
+		struct irq_data *data =3D irq_get_irq_data(irq);
+
+		irq_data_update_affinity(data, cpumask_of(cpu));
+		irq_data_update_effective_affinity(data, cpumask_of(cpu));
 	}
=20
 	xen_evtchn_port_bind_to_cpu(evtchn, cpu, info->cpu);
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 4f82a5bc6d98..76520f379313 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -105,6 +105,7 @@ enum acpi_irq_model_id {
 	ACPI_IRQ_MODEL_IOSAPIC,
 	ACPI_IRQ_MODEL_PLATFORM,
 	ACPI_IRQ_MODEL_GIC,
+	ACPI_IRQ_MODEL_LPIC,
 	ACPI_IRQ_MODEL_COUNT
 };
=20
@@ -356,7 +357,8 @@ int acpi_gsi_to_irq (u32 gsi, unsigned int *irq);
 int acpi_isa_irq_to_gsi (unsigned isa_irq, u32 *gsi);
=20
 void acpi_set_irq_model(enum acpi_irq_model_id model,
-			struct fwnode_handle *fwnode);
+			struct fwnode_handle *(*)(u32));
+void acpi_set_gsi_to_irq_fallback(u32 (*)(u32));
=20
 struct irq_domain *acpi_irq_create_hierarchy(unsigned int flags,
 					     unsigned int size,
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 19f0dbfdd7fe..de662f3a6cee 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -151,6 +151,7 @@ enum cpuhp_state {
 	CPUHP_AP_IRQ_BCM2836_STARTING,
 	CPUHP_AP_IRQ_MIPS_GIC_STARTING,
 	CPUHP_AP_IRQ_RISCV_STARTING,
+	CPUHP_AP_IRQ_LOONGARCH_STARTING,
 	CPUHP_AP_IRQ_SIFIVE_PLIC_STARTING,
 	CPUHP_AP_ARM_MVEBU_COHERENCY,
 	CPUHP_AP_MICROCODE_LOADER,
diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index b1e0f1f8ee2e..ad5b92b74ccf 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -12,6 +12,8 @@
 #include <linux/property.h>
 #include <linux/types.h>
=20
+#include <asm/msi.h>
+
 struct gpio_desc;
 struct of_phandle_args;
 struct device_node;
@@ -23,6 +25,13 @@ enum gpio_lookup_flags;
=20
 struct gpio_chip;
=20
+union gpio_irq_fwspec {
+	struct irq_fwspec	fwspec;
+#ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
+	msi_alloc_info_t	msiinfo;
+#endif
+};
+
 #define GPIO_LINE_DIRECTION_IN	1
 #define GPIO_LINE_DIRECTION_OUT	0
=20
@@ -103,9 +112,10 @@ struct gpio_irq_chip {
 	 * variant named &gpiochip_populate_parent_fwspec_fourcell is also
 	 * available.
 	 */
-	void *(*populate_parent_alloc_arg)(struct gpio_chip *gc,
-				       unsigned int parent_hwirq,
-				       unsigned int parent_type);
+	int (*populate_parent_alloc_arg)(struct gpio_chip *gc,
+					 union gpio_irq_fwspec *fwspec,
+					 unsigned int parent_hwirq,
+					 unsigned int parent_type);
=20
 	/**
 	 * @child_offset_to_irq:
@@ -646,28 +656,14 @@ struct bgpio_pdata {
=20
 #ifdef CONFIG_IRQ_DOMAIN_HIERARCHY
=20
-void *gpiochip_populate_parent_fwspec_twocell(struct gpio_chip *gc,
+int gpiochip_populate_parent_fwspec_twocell(struct gpio_chip *gc,
+					    union gpio_irq_fwspec *gfwspec,
+					    unsigned int parent_hwirq,
+					    unsigned int parent_type);
+int gpiochip_populate_parent_fwspec_fourcell(struct gpio_chip *gc,
+					     union gpio_irq_fwspec *gfwspec,
 					     unsigned int parent_hwirq,
 					     unsigned int parent_type);
-void *gpiochip_populate_parent_fwspec_fourcell(struct gpio_chip *gc,
-					      unsigned int parent_hwirq,
-					      unsigned int parent_type);
-
-#else
-
-static inline void *gpiochip_populate_parent_fwspec_twocell(struct gpio_chip=
 *gc,
-						    unsigned int parent_hwirq,
-						    unsigned int parent_type)
-{
-	return NULL;
-}
-
-static inline void *gpiochip_populate_parent_fwspec_fourcell(struct gpio_chi=
p *gc,
-						     unsigned int parent_hwirq,
-						     unsigned int parent_type)
-{
-	return NULL;
-}
=20
 #endif /* CONFIG_IRQ_DOMAIN_HIERARCHY */
=20
diff --git a/include/linux/irq.h b/include/linux/irq.h
index 505308253d23..c3eb89606c2b 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -151,7 +151,9 @@ struct irq_common_data {
 #endif
 	void			*handler_data;
 	struct msi_desc		*msi_desc;
+#ifdef CONFIG_SMP
 	cpumask_var_t		affinity;
+#endif
 #ifdef CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK
 	cpumask_var_t		effective_affinity;
 #endif
@@ -879,21 +881,34 @@ static inline int irq_data_get_node(struct irq_data *d)
 	return irq_common_data_get_node(d->common);
 }
=20
-static inline struct cpumask *irq_get_affinity_mask(int irq)
+static inline
+const struct cpumask *irq_data_get_affinity_mask(struct irq_data *d)
 {
-	struct irq_data *d =3D irq_get_irq_data(irq);
+#ifdef CONFIG_SMP
+	return d->common->affinity;
+#else
+	return cpumask_of(0);
+#endif
+}
=20
-	return d ? d->common->affinity : NULL;
+static inline void irq_data_update_affinity(struct irq_data *d,
+					    const struct cpumask *m)
+{
+#ifdef CONFIG_SMP
+	cpumask_copy(d->common->affinity, m);
+#endif
 }
=20
-static inline struct cpumask *irq_data_get_affinity_mask(struct irq_data *d)
+static inline const struct cpumask *irq_get_affinity_mask(int irq)
 {
-	return d->common->affinity;
+	struct irq_data *d =3D irq_get_irq_data(irq);
+
+	return d ? irq_data_get_affinity_mask(d) : NULL;
 }
=20
 #ifdef CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK
 static inline
-struct cpumask *irq_data_get_effective_affinity_mask(struct irq_data *d)
+const struct cpumask *irq_data_get_effective_affinity_mask(struct irq_data *=
d)
 {
 	return d->common->effective_affinity;
 }
@@ -908,13 +923,14 @@ static inline void irq_data_update_effective_affinity(s=
truct irq_data *d,
 {
 }
 static inline
-struct cpumask *irq_data_get_effective_affinity_mask(struct irq_data *d)
+const struct cpumask *irq_data_get_effective_affinity_mask(struct irq_data *=
d)
 {
-	return d->common->affinity;
+	return irq_data_get_affinity_mask(d);
 }
 #endif
=20
-static inline struct cpumask *irq_get_effective_affinity_mask(unsigned int i=
rq)
+static inline
+const struct cpumask *irq_get_effective_affinity_mask(unsigned int irq)
 {
 	struct irq_data *d =3D irq_get_irq_data(irq);
=20
@@ -1121,6 +1137,7 @@ int irq_gc_set_wake(struct irq_data *d, unsigned int on=
);
 /* Setup functions for irq_chip_generic */
 int irq_map_generic_chip(struct irq_domain *d, unsigned int virq,
 			 irq_hw_number_t hw_irq);
+void irq_unmap_generic_chip(struct irq_domain *d, unsigned int virq);
 struct irq_chip_generic *
 irq_alloc_generic_chip(const char *name, int nr_ct, unsigned int irq_base,
 		       void __iomem *reg_base, irq_flow_handler_t handler);
diff --git a/include/linux/irqchip/mmp.h b/include/linux/irqchip/mmp.h
index cb8455c87c8a..aa1813749a4f 100644
--- a/include/linux/irqchip/mmp.h
+++ b/include/linux/irqchip/mmp.h
@@ -4,4 +4,7 @@
=20
 extern struct irq_chip icu_irq_chip;
=20
+extern void icu_init_irq(void);
+extern void mmp2_init_icu(void);
+
 #endif	/* __IRQCHIP_MMP_H */
diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
index a77584593f7d..1cd4e36890fb 100644
--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -209,14 +209,15 @@ static inline void irq_set_handler_locked(struct irq_da=
ta *data,
  * Must be called with irq_desc locked and valid parameters.
  */
 static inline void
-irq_set_chip_handler_name_locked(struct irq_data *data, struct irq_chip *chi=
p,
+irq_set_chip_handler_name_locked(struct irq_data *data,
+				 const struct irq_chip *chip,
 				 irq_flow_handler_t handler, const char *name)
 {
 	struct irq_desc *desc =3D irq_data_to_desc(data);
=20
 	desc->handle_irq =3D handler;
 	desc->name =3D name;
-	data->chip =3D chip;
+	data->chip =3D (struct irq_chip *)chip;
 }
=20
 bool irq_check_status_bit(unsigned int irq, unsigned int bitmask);
diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
index 10929eda9825..db3d174c53d4 100644
--- a/kernel/irq/Kconfig
+++ b/kernel/irq/Kconfig
@@ -24,6 +24,7 @@ config GENERIC_IRQ_SHOW_LEVEL
=20
 # Supports effective affinity mask
 config GENERIC_IRQ_EFFECTIVE_AFF_MASK
+       depends on SMP
        bool
=20
 # Support for delayed migration from interrupt context
@@ -82,6 +83,7 @@ config IRQ_FASTEOI_HIERARCHY_HANDLERS
 # Generic IRQ IPI support
 config GENERIC_IRQ_IPI
 	bool
+	depends on SMP
 	select IRQ_DOMAIN_HIERARCHY
=20
 # Generic MSI interrupt support
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 886789dcee43..8ac37e8e738a 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -188,7 +188,8 @@ enum {
=20
 #ifdef CONFIG_SMP
 static int
-__irq_startup_managed(struct irq_desc *desc, struct cpumask *aff, bool force)
+__irq_startup_managed(struct irq_desc *desc, const struct cpumask *aff,
+		      bool force)
 {
 	struct irq_data *d =3D irq_desc_get_irq_data(desc);
=20
@@ -224,7 +225,8 @@ __irq_startup_managed(struct irq_desc *desc, struct cpuma=
sk *aff, bool force)
 }
 #else
 static __always_inline int
-__irq_startup_managed(struct irq_desc *desc, struct cpumask *aff, bool force)
+__irq_startup_managed(struct irq_desc *desc, const struct cpumask *aff,
+		      bool force)
 {
 	return IRQ_STARTUP_NORMAL;
 }
@@ -252,7 +254,7 @@ static int __irq_startup(struct irq_desc *desc)
 int irq_startup(struct irq_desc *desc, bool resend, bool force)
 {
 	struct irq_data *d =3D irq_desc_get_irq_data(desc);
-	struct cpumask *aff =3D irq_data_get_affinity_mask(d);
+	const struct cpumask *aff =3D irq_data_get_affinity_mask(d);
 	int ret =3D 0;
=20
 	desc->depth =3D 0;
@@ -1516,7 +1518,8 @@ int irq_chip_request_resources_parent(struct irq_data *=
data)
 	if (data->chip->irq_request_resources)
 		return data->chip->irq_request_resources(data);
=20
-	return -ENOSYS;
+	/* no error on missing optional irq_chip::irq_request_resources */
+	return 0;
 }
 EXPORT_SYMBOL_GPL(irq_chip_request_resources_parent);
=20
diff --git a/kernel/irq/debugfs.c b/kernel/irq/debugfs.c
index bc8e40cf2b65..bbcaac64038e 100644
--- a/kernel/irq/debugfs.c
+++ b/kernel/irq/debugfs.c
@@ -30,7 +30,7 @@ static void irq_debug_show_bits(struct seq_file *m, int ind=
, unsigned int state,
 static void irq_debug_show_masks(struct seq_file *m, struct irq_desc *desc)
 {
 	struct irq_data *data =3D irq_desc_get_irq_data(desc);
-	struct cpumask *msk;
+	const struct cpumask *msk;
=20
 	msk =3D irq_data_get_affinity_mask(data);
 	seq_printf(m, "affinity: %*pbl\n", cpumask_pr_args(msk));
diff --git a/kernel/irq/generic-chip.c b/kernel/irq/generic-chip.c
index f0862eb6b506..c653cd31548d 100644
--- a/kernel/irq/generic-chip.c
+++ b/kernel/irq/generic-chip.c
@@ -431,7 +431,7 @@ int irq_map_generic_chip(struct irq_domain *d, unsigned i=
nt virq,
 	return 0;
 }
=20
-static void irq_unmap_generic_chip(struct irq_domain *d, unsigned int virq)
+void irq_unmap_generic_chip(struct irq_domain *d, unsigned int virq)
 {
 	struct irq_data *data =3D irq_domain_get_irq_data(d, virq);
 	struct irq_domain_chip_generic *dgc =3D d->gc;
diff --git a/kernel/irq/ipi.c b/kernel/irq/ipi.c
index 08ce7da3b57c..bbd945bacef0 100644
--- a/kernel/irq/ipi.c
+++ b/kernel/irq/ipi.c
@@ -115,11 +115,11 @@ int irq_reserve_ipi(struct irq_domain *domain,
 int irq_destroy_ipi(unsigned int irq, const struct cpumask *dest)
 {
 	struct irq_data *data =3D irq_get_irq_data(irq);
-	struct cpumask *ipimask =3D data ? irq_data_get_affinity_mask(data) : NULL;
+	const struct cpumask *ipimask;
 	struct irq_domain *domain;
 	unsigned int nr_irqs;
=20
-	if (!irq || !data || !ipimask)
+	if (!irq || !data)
 		return -EINVAL;
=20
 	domain =3D data->domain;
@@ -131,7 +131,8 @@ int irq_destroy_ipi(unsigned int irq, const struct cpumas=
k *dest)
 		return -EINVAL;
 	}
=20
-	if (WARN_ON(!cpumask_subset(dest, ipimask)))
+	ipimask =3D irq_data_get_affinity_mask(data);
+	if (!ipimask || WARN_ON(!cpumask_subset(dest, ipimask)))
 		/*
 		 * Must be destroying a subset of CPUs to which this IPI
 		 * was set up to target
@@ -162,12 +163,13 @@ int irq_destroy_ipi(unsigned int irq, const struct cpum=
ask *dest)
 irq_hw_number_t ipi_get_hwirq(unsigned int irq, unsigned int cpu)
 {
 	struct irq_data *data =3D irq_get_irq_data(irq);
-	struct cpumask *ipimask =3D data ? irq_data_get_affinity_mask(data) : NULL;
+	const struct cpumask *ipimask;
=20
-	if (!data || !ipimask || cpu >=3D nr_cpu_ids)
+	if (!data || cpu >=3D nr_cpu_ids)
 		return INVALID_HWIRQ;
=20
-	if (!cpumask_test_cpu(cpu, ipimask))
+	ipimask =3D irq_data_get_affinity_mask(data);
+	if (!ipimask || !cpumask_test_cpu(cpu, ipimask))
 		return INVALID_HWIRQ;
=20
 	/*
@@ -186,7 +188,7 @@ EXPORT_SYMBOL_GPL(ipi_get_hwirq);
 static int ipi_send_verify(struct irq_chip *chip, struct irq_data *data,
 			   const struct cpumask *dest, unsigned int cpu)
 {
-	struct cpumask *ipimask =3D irq_data_get_affinity_mask(data);
+	const struct cpumask *ipimask =3D irq_data_get_affinity_mask(data);
=20
 	if (!chip || !ipimask)
 		return -EINVAL;
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index d323b180b0f3..5db0230aa6b5 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -251,7 +251,7 @@ static ssize_t actions_show(struct kobject *kobj,
 	char *p =3D "";
=20
 	raw_spin_lock_irq(&desc->lock);
-	for (action =3D desc->action; action !=3D NULL; action =3D action->next) {
+	for_each_action_of_desc(desc, action) {
 		ret +=3D scnprintf(buf + ret, PAGE_SIZE - ret, "%s%s",
 				 p, action->name);
 		p =3D ",";
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index d5ce96510549..8fe1da9614ee 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -147,7 +147,8 @@ struct irq_domain *__irq_domain_add(struct fwnode_handle =
*fwnode, unsigned int s
 	static atomic_t unknown_domains;
=20
 	if (WARN_ON((size && direct_max) ||
-		    (!IS_ENABLED(CONFIG_IRQ_DOMAIN_NOMAP) && direct_max)))
+		    (!IS_ENABLED(CONFIG_IRQ_DOMAIN_NOMAP) && direct_max) ||
+		    (direct_max && (direct_max !=3D hwirq_max))))
 		return NULL;
=20
 	domain =3D kzalloc_node(struct_size(domain, revmap, size),
@@ -219,7 +220,6 @@ struct irq_domain *__irq_domain_add(struct fwnode_handle =
*fwnode, unsigned int s
 	domain->hwirq_max =3D hwirq_max;
=20
 	if (direct_max) {
-		size =3D direct_max;
 		domain->flags |=3D IRQ_DOMAIN_FLAG_NO_MAP;
 	}
=20
@@ -650,9 +650,9 @@ unsigned int irq_create_direct_mapping(struct irq_domain =
*domain)
 		pr_debug("create_direct virq allocation failed\n");
 		return 0;
 	}
-	if (virq >=3D domain->revmap_size) {
-		pr_err("ERROR: no free irqs available below %i maximum\n",
-			domain->revmap_size);
+	if (virq >=3D domain->hwirq_max) {
+		pr_err("ERROR: no free irqs available below %lu maximum\n",
+			domain->hwirq_max);
 		irq_free_desc(virq);
 		return 0;
 	}
@@ -906,10 +906,12 @@ struct irq_desc *__irq_resolve_mapping(struct irq_domai=
n *domain,
 		return desc;
=20
 	if (irq_domain_is_nomap(domain)) {
-		if (hwirq < domain->revmap_size) {
+		if (hwirq < domain->hwirq_max) {
 			data =3D irq_domain_get_irq_data(domain, hwirq);
 			if (data && data->hwirq =3D=3D hwirq)
 				desc =3D irq_data_to_desc(data);
+			if (irq && desc)
+				*irq =3D hwirq;
 		}
=20
 		return desc;
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 8c396319d5ac..40fe7806cc8c 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -205,16 +205,8 @@ static void irq_validate_effective_affinity(struct irq_d=
ata *data)
 	pr_warn_once("irq_chip %s did not update eff. affinity mask of irq %u\n",
 		     chip->name, data->irq);
 }
-
-static inline void irq_init_effective_affinity(struct irq_data *data,
-					       const struct cpumask *mask)
-{
-	cpumask_copy(irq_data_get_effective_affinity_mask(data), mask);
-}
 #else
 static inline void irq_validate_effective_affinity(struct irq_data *data) { }
-static inline void irq_init_effective_affinity(struct irq_data *data,
-					       const struct cpumask *mask) { }
 #endif
=20
 int irq_do_set_affinity(struct irq_data *data, const struct cpumask *mask,
@@ -347,7 +339,7 @@ static bool irq_set_affinity_deactivated(struct irq_data =
*data,
 		return false;
=20
 	cpumask_copy(desc->irq_common_data.affinity, mask);
-	irq_init_effective_affinity(data, mask);
+	irq_data_update_effective_affinity(data, mask);
 	irqd_set(data, IRQD_AFFINITY_SET);
 	return true;
 }
diff --git a/kernel/irq/pm.c b/kernel/irq/pm.c
index ca71123a6130..c556bc49d213 100644
--- a/kernel/irq/pm.c
+++ b/kernel/irq/pm.c
@@ -147,7 +147,6 @@ void suspend_device_irqs(void)
 			synchronize_irq(irq);
 	}
 }
-EXPORT_SYMBOL_GPL(suspend_device_irqs);
=20
 static void resume_irq(struct irq_desc *desc)
 {
@@ -259,4 +258,3 @@ void resume_device_irqs(void)
 {
 	resume_irqs(false);
 }
-EXPORT_SYMBOL_GPL(resume_device_irqs);

