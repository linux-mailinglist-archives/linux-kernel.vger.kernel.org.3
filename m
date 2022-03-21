Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 653E54E24EC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 12:03:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346629AbiCULEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 07:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346585AbiCULDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 07:03:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB90514DFD6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 04:02:26 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647860545;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=u6q6sDc0PUjyfm6A7m0Wbx8eTI2J7ZzKaZ2LLWxrWlA=;
        b=ABkeiwL3Bq52cldsafJ50APYDQNsVXCWSMWRCUAQo4tT9Oa7szBefpnRs5YZb5K5bJDMCV
        o3jBlW38TtETBV9z4KOmmSS3MQvp8+iwGnAHFDaoq4pZZG81Yb+Q0/r5OZKmOI/h/HiIVY
        lbv7WwRzpplo/MIQ7uG6zGWy6IjlyAL4NLylWSE3Na9Yjq05eCvfdAUTbP9p6NBfmt3Qaj
        cKHZFmb152b9OWdu5YgjhL0iWsLfEHNWb8V7PBKLJ+jkoJMgu79czb0hn6PJtUAkd9FPYn
        Kao7tvMLrsrG9U85RpEGtMBrZcVa0a2/GsR/CkGvAP7mRBdlae0NBNwFJwoFSw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647860545;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=u6q6sDc0PUjyfm6A7m0Wbx8eTI2J7ZzKaZ2LLWxrWlA=;
        b=sPlVY9PhsTP4EnFO0k0y/3liWqoOp04jMgfgMqt7Fmb/536NY5Wwffnxbm69wxk4R6GU7G
        jwYFcqzLmaS92uCg==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] irq/core for v5.18-rc1
References: <164786042536.122591.4459156564791679956.tglx@xen13>
Message-ID: <164786042731.122591.2741068913623154.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Mon, 21 Mar 2022 12:02:24 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest irq/core branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-2022-03=
-21

up to:  411472ae5bb4: Merge tag 'v5.17-rc8' into irq/core, to fix conflicts


Updates for the interrupt subsystem:

 Core code:

   - Provide generic_handle_irq_safe() which can be invoked from any
     context (hard interrupt or threaded). This allows to remove ugly
     workarounds in drivers all over the place.

   - Use generic_handle_irq_safe() in the affected drivers.

   - The usual cleanups and improvements.

 Interrupt chip drivers:

   - Support for new interrupt chips or not yet supported variants:
     STM32MP14, Meson GPIO, Apple M1 PMU, Apple M1 AICv2, Qualcomm MPM

   - Convert the Xilinx driver to generic interrupt domains

   - Cleanup the irq_chip::name handling

   - The usual cleanups and improvements all over the place


Thanks,

	tglx

------------------>
Alexandre Torgue (2):
      dt-bindings: interrupt-controller: stm32-exti: document st,stm32mp13-ex=
ti
      irqchip/stm32-exti: Add STM32MP13 support

Barry Song (1):
      irqchip/gic-v3: Use dsb(ishst) to order writes with ICC_SGI1R_EL1 acces=
ses

Changbin Du (1):
      genirq, softirq: Use in_hardirq() instead of in_irq()

Hector Martin (7):
      PCI: apple: Change MSI handling to handle 4-cell AIC fwspec form
      dt-bindings: interrupt-controller: apple,aic2: New binding for AICv2
      irqchip/apple-aic: Add Fast IPI support
      irqchip/apple-aic: Switch to irq_domain_create_tree and sparse hwirqs
      irqchip/apple-aic: Dynamically compute register offsets
      irqchip/apple-aic: Support multiple dies
      irqchip/apple-aic: Add support for AICv2

Marc Zyngier (34):
      dt-bindings: arm-pmu: Document Apple PMU compatible strings
      dt-bindings: apple,aic: Add CPU PMU per-cpu pseudo-interrupts
      dt-bindings: apple,aic: Add affinity description for per-cpu pseudo-int=
errupts
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
      irqdomain: Let irq_domain_set_{info,hwirq_and_chip} take a const irq_ch=
ip
      genirq: Allow irq_chip registration functions to take a const irq_chip
      genirq/debugfs: Use irq_print_chip() when provided by irqchip
      irqchip/gic: Switch to dynamic chip name output
      irqchip/lpc32xx: Switch to dynamic chip name output
      irqchip/mvebu-pic: Switch to dynamic chip name output
      irqchip/ts4800: Switch to dynamic chip name output
      irqchip/versatile-fpga: Switch to dynamic chip name output
      irqchip/qcom-pdc: Kill PDC_NO_PARENT_IRQ
      irqchip/qcom-pdc: Kill non-wakeup irqdomain
      irqchip/qcom-pdc: Kill qcom_pdc_translate helper
      irqchip/qcom-pdc: Fix broken locking
      irqchip/qcom-pdc: Drop open coded version of __assign_bit()
      irqchip/apple-aic: Fix cpumask allocation for FIQs

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

Sebastian Andrzej Siewior (5):
      genirq: Provide generic_handle_irq_safe()
      misc: hi6421-spmi-pmic: Use generic_handle_irq_safe().
      mfd: ezx-pcap: Use generic_handle_irq_safe().
      net: usb: lan78xx: Use generic_handle_irq_safe().
      staging: greybus: gpio: Use generic_handle_irq_safe().

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
 drivers/irqchip/irq-apple-aic.c                    | 551 +++++++++++++++++--=
--
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
 drivers/mfd/ezx-pcap.c                             |   4 +-
 drivers/misc/hi6421v600-irq.c                      |   6 +-
 drivers/net/usb/lan78xx.c                          |   7 +-
 drivers/pci/controller/pcie-apple.c                |   2 +-
 drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c          |  25 +-
 drivers/pinctrl/pinctrl-starfive.c                 |   4 +-
 drivers/staging/greybus/gpio.c                     |   5 +-
 .../dt-bindings/interrupt-controller/apple-aic.h   |   2 +
 include/linux/irq.h                                |   9 +-
 include/linux/irqchip/versatile-fpga.h             |  14 -
 include/linux/irqdesc.h                            |   1 +
 include/linux/irqdomain.h                          |  15 +-
 kernel/irq/chip.c                                  |  29 +-
 kernel/irq/debugfs.c                               |   8 +-
 kernel/irq/irqdesc.c                               |  27 +-
 kernel/irq/irqdomain.c                             |   9 +-
 kernel/softirq.c                                   |  10 +-
 53 files changed, 1656 insertions(+), 467 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/ap=
ple,aic2.yaml
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/qc=
om,mpm.yaml
 create mode 100644 arch/arm64/include/asm/apple_m1_pmu.h
 create mode 100644 drivers/irqchip/irq-qcom-mpm.c
 delete mode 100644 include/linux/irqchip/versatile-fpga.h

diff --git a/Documentation/devicetree/bindings/arm/pmu.yaml b/Documentation/d=
evicetree/bindings/arm/pmu.yaml
index 981bac451698..7a04b8aaaec3 100644
--- a/Documentation/devicetree/bindings/arm/pmu.yaml
+++ b/Documentation/devicetree/bindings/arm/pmu.yaml
@@ -20,6 +20,8 @@ properties:
     items:
       - enum:
           - apm,potenza-pmu
+          - apple,firestorm-pmu
+          - apple,icestorm-pmu
           - arm,armv8-pmuv3 # Only for s/w models
           - arm,arm1136-pmu
           - arm,arm1176-pmu
diff --git a/Documentation/devicetree/bindings/interrupt-controller/amlogic,m=
eson-gpio-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/a=
mlogic,meson-gpio-intc.txt
index 23b18b92c558..bde63f8f090e 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gp=
io-intc.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gp=
io-intc.txt
@@ -18,6 +18,7 @@ Required properties:
     "amlogic,meson-g12a-gpio-intc" for G12A SoCs (S905D2, S905X2, S905Y2)
     "amlogic,meson-sm1-gpio-intc" for SM1 SoCs (S905D3, S905X3, S905Y3)
     "amlogic,meson-a1-gpio-intc" for A1 SoCs (A113L)
+    "amlogic,meson-s4-gpio-intc" for S4 SoCs (S802X2, S905Y4, S805X2G, S905W=
2)
 - reg : Specifies base physical address and size of the registers.
 - interrupt-controller : Identifies the node as an interrupt controller.
 - #interrupt-cells : Specifies the number of cells needed to encode an
diff --git a/Documentation/devicetree/bindings/interrupt-controller/apple,aic=
.yaml b/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
index 97359024709a..85c85b694217 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
@@ -56,6 +56,8 @@ properties:
           - 1: virtual HV timer
           - 2: physical guest timer
           - 3: virtual guest timer
+          - 4: 'efficient' CPU PMU
+          - 5: 'performance' CPU PMU
=20
       The 3rd cell contains the interrupt flags. This is normally
       IRQ_TYPE_LEVEL_HIGH (4).
@@ -68,6 +70,35 @@ properties:
   power-domains:
     maxItems: 1
=20
+  affinities:
+    type: object
+    additionalProperties: false
+    description:
+      FIQ affinity can be expressed as a single "affinities" node,
+      containing a set of sub-nodes, one per FIQ with a non-default
+      affinity.
+    patternProperties:
+      "^.+-affinity$":
+        type: object
+        additionalProperties: false
+        properties:
+          apple,fiq-index:
+            description:
+              The interrupt number specified as a FIQ, and for which
+              the affinity is not the default.
+            $ref: /schemas/types.yaml#/definitions/uint32
+            maximum: 5
+
+          cpus:
+            $ref: /schemas/types.yaml#/definitions/phandle-array
+            description:
+              Should be a list of phandles to CPU nodes (as described in
+              Documentation/devicetree/bindings/arm/cpus.yaml).
+
+        required:
+          - fiq-index
+          - cpus
+
 required:
   - compatible
   - '#interrupt-cells'
diff --git a/Documentation/devicetree/bindings/interrupt-controller/apple,aic=
2.yaml b/Documentation/devicetree/bindings/interrupt-controller/apple,aic2.ya=
ml
new file mode 100644
index 000000000000..47a78a167aba
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/apple,aic2.yaml
@@ -0,0 +1,98 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/apple,aic2.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Apple Interrupt Controller 2
+
+maintainers:
+  - Hector Martin <marcan@marcan.st>
+
+description: |
+  The Apple Interrupt Controller 2 is a simple interrupt controller present =
on
+  Apple ARM SoC platforms starting with t600x (M1 Pro and Max).
+
+  It provides the following features:
+
+  - Level-triggered hardware IRQs wired to SoC blocks
+    - Single mask bit per IRQ
+    - Automatic masking on event delivery (auto-ack)
+    - Software triggering (ORed with hw line)
+  - Automatic prioritization (single event/ack register per CPU, lower IRQs =
=3D
+    higher priority)
+  - Automatic masking on ack
+  - Support for multiple dies
+
+  This device also represents the FIQ interrupt sources on platforms using A=
IC,
+  which do not go through a discrete interrupt controller. It also handles
+  FIQ-based Fast IPIs.
+
+properties:
+  compatible:
+    items:
+      - const: apple,t6000-aic
+      - const: apple,aic2
+
+  interrupt-controller: true
+
+  '#interrupt-cells':
+    const: 4
+    description: |
+      The 1st cell contains the interrupt type:
+        - 0: Hardware IRQ
+        - 1: FIQ
+
+      The 2nd cell contains the die ID.
+
+      The next cell contains the interrupt number.
+        - HW IRQs: interrupt number
+        - FIQs:
+          - 0: physical HV timer
+          - 1: virtual HV timer
+          - 2: physical guest timer
+          - 3: virtual guest timer
+
+      The last cell contains the interrupt flags. This is normally
+      IRQ_TYPE_LEVEL_HIGH (4).
+
+  reg:
+    items:
+      - description: Address and size of the main AIC2 registers.
+      - description: Address and size of the AIC2 Event register.
+
+  reg-names:
+    items:
+      - const: core
+      - const: event
+
+  power-domains:
+    maxItems: 1
+
+required:
+  - compatible
+  - '#interrupt-cells'
+  - interrupt-controller
+  - reg
+  - reg-names
+
+additionalProperties: false
+
+allOf:
+  - $ref: /schemas/interrupt-controller.yaml#
+
+examples:
+  - |
+    soc {
+        #address-cells =3D <2>;
+        #size-cells =3D <2>;
+
+        aic: interrupt-controller@28e100000 {
+            compatible =3D "apple,t6000-aic", "apple,aic2";
+            #interrupt-cells =3D <4>;
+            interrupt-controller;
+            reg =3D <0x2 0x8e100000 0x0 0xc000>,
+                  <0x2 0x8e10c000 0x0 0x4>;
+            reg-names =3D "core", "event";
+        };
+    };
diff --git a/Documentation/devicetree/bindings/interrupt-controller/qcom,mpm.=
yaml b/Documentation/devicetree/bindings/interrupt-controller/qcom,mpm.yaml
new file mode 100644
index 000000000000..509d20c091af
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/qcom,mpm.yaml
@@ -0,0 +1,96 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/qcom,mpm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcom MPM Interrupt Controller
+
+maintainers:
+  - Shawn Guo <shawn.guo@linaro.org>
+
+description:
+  Qualcomm Technologies Inc. SoCs based on the RPM architecture have a
+  MSM Power Manager (MPM) that is in always-on domain. In addition to managi=
ng
+  resources during sleep, the hardware also has an interrupt controller that
+  monitors the interrupts when the system is asleep, wakes up the APSS when
+  one of these interrupts occur and replays it to GIC interrupt controller
+  after GIC becomes operational.
+
+allOf:
+  - $ref: /schemas/interrupt-controller.yaml#
+
+properties:
+  compatible:
+    items:
+      - const: qcom,mpm
+
+  reg:
+    maxItems: 1
+    description:
+      Specifies the base address and size of vMPM registers in RPM MSG RAM.
+
+  interrupts:
+    maxItems: 1
+    description:
+      Specify the IRQ used by RPM to wakeup APSS.
+
+  mboxes:
+    maxItems: 1
+    description:
+      Specify the mailbox used to notify RPM for writing vMPM registers.
+
+  interrupt-controller: true
+
+  '#interrupt-cells':
+    const: 2
+    description:
+      The first cell is the MPM pin number for the interrupt, and the second
+      is the trigger type.
+
+  qcom,mpm-pin-count:
+    description:
+      Specify the total MPM pin count that a SoC supports.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  qcom,mpm-pin-map:
+    description:
+      A set of MPM pin numbers and the corresponding GIC SPIs.
+    $ref: /schemas/types.yaml#/definitions/uint32-matrix
+    items:
+      items:
+        - description: MPM pin number
+        - description: GIC SPI number for the MPM pin
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - mboxes
+  - interrupt-controller
+  - '#interrupt-cells'
+  - qcom,mpm-pin-count
+  - qcom,mpm-pin-map
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    mpm: interrupt-controller@45f01b8 {
+        compatible =3D "qcom,mpm";
+        interrupts =3D <GIC_SPI 197 IRQ_TYPE_EDGE_RISING>;
+        reg =3D <0x45f01b8 0x1000>;
+        mboxes =3D <&apcs_glb 1>;
+        interrupt-controller;
+        #interrupt-cells =3D <2>;
+        interrupt-parent =3D <&intc>;
+        qcom,mpm-pin-count =3D <96>;
+        qcom,mpm-pin-map =3D <2 275>,
+                           <5 296>,
+                           <12 422>,
+                           <24 79>,
+                           <86 183>,
+                           <90 260>,
+                           <91 260>;
+    };
diff --git a/Documentation/devicetree/bindings/interrupt-controller/st,stm32-=
exti.yaml b/Documentation/devicetree/bindings/interrupt-controller/st,stm32-e=
xti.yaml
index d19c881b4abc..e44daa09b137 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.ya=
ml
+++ b/Documentation/devicetree/bindings/interrupt-controller/st,stm32-exti.ya=
ml
@@ -20,6 +20,7 @@ properties:
       - items:
           - enum:
               - st,stm32mp1-exti
+              - st,stm32mp13-exti
           - const: syscon
=20
   "#interrupt-cells":
diff --git a/MAINTAINERS b/MAINTAINERS
index e127c2fb08a7..ad752aa077e8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1769,7 +1769,7 @@ T:	git https://github.com/AsahiLinux/linux.git
 F:	Documentation/devicetree/bindings/arm/apple.yaml
 F:	Documentation/devicetree/bindings/arm/apple/*
 F:	Documentation/devicetree/bindings/i2c/apple,i2c.yaml
-F:	Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
+F:	Documentation/devicetree/bindings/interrupt-controller/apple,*
 F:	Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml
 F:	Documentation/devicetree/bindings/pci/apple,pcie.yaml
 F:	Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
diff --git a/arch/arm64/boot/dts/apple/t8103.dtsi b/arch/arm64/boot/dts/apple=
/t8103.dtsi
index 19afbc91020a..9f8f4145db88 100644
--- a/arch/arm64/boot/dts/apple/t8103.dtsi
+++ b/arch/arm64/boot/dts/apple/t8103.dtsi
@@ -97,6 +97,18 @@ timer {
 			     <AIC_FIQ AIC_TMR_HV_VIRT IRQ_TYPE_LEVEL_HIGH>;
 	};
=20
+	pmu-e {
+		compatible =3D "apple,icestorm-pmu";
+		interrupt-parent =3D <&aic>;
+		interrupts =3D <AIC_FIQ AIC_CPU_PMU_E IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	pmu-p {
+		compatible =3D "apple,firestorm-pmu";
+		interrupt-parent =3D <&aic>;
+		interrupts =3D <AIC_FIQ AIC_CPU_PMU_P IRQ_TYPE_LEVEL_HIGH>;
+	};
+
 	clkref: clock-ref {
 		compatible =3D "fixed-clock";
 		#clock-cells =3D <0>;
@@ -213,6 +225,18 @@ aic: interrupt-controller@23b100000 {
 			interrupt-controller;
 			reg =3D <0x2 0x3b100000 0x0 0x8000>;
 			power-domains =3D <&ps_aic>;
+
+			affinities {
+				e-core-pmu-affinity {
+					apple,fiq-index =3D <AIC_CPU_PMU_E>;
+					cpus =3D <&cpu0 &cpu1 &cpu2 &cpu3>;
+				};
+
+				p-core-pmu-affinity {
+					apple,fiq-index =3D <AIC_CPU_PMU_P>;
+					cpus =3D <&cpu4 &cpu5 &cpu6 &cpu7>;
+				};
+			};
 		};
=20
 		pmgr: power-management@23b700000 {
diff --git a/arch/arm64/include/asm/apple_m1_pmu.h b/arch/arm64/include/asm/a=
pple_m1_pmu.h
new file mode 100644
index 000000000000..b848af7faadc
--- /dev/null
+++ b/arch/arm64/include/asm/apple_m1_pmu.h
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#ifndef __ASM_APPLE_M1_PMU_h
+#define __ASM_APPLE_M1_PMU_h
+
+#include <linux/bits.h>
+#include <asm/sysreg.h>
+
+/* Core PMC control register */
+#define SYS_IMP_APL_PMCR0_EL1	sys_reg(3, 1, 15, 0, 0)
+#define PMCR0_IMODE		GENMASK(10, 8)
+#define PMCR0_IMODE_OFF		0
+#define PMCR0_IMODE_PMI		1
+#define PMCR0_IMODE_AIC		2
+#define PMCR0_IMODE_HALT	3
+#define PMCR0_IMODE_FIQ		4
+#define PMCR0_IACT		BIT(11)
+
+#endif /* __ASM_APPLE_M1_PMU_h */
diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
index 59798e43cdb0..da568e981604 100644
--- a/arch/microblaze/Kconfig
+++ b/arch/microblaze/Kconfig
@@ -45,6 +45,8 @@ config MICROBLAZE
 	select SET_FS
 	select ZONE_DMA
 	select TRACE_IRQFLAGS_SUPPORT
+	select GENERIC_IRQ_MULTI_HANDLER
+	select HANDLE_DOMAIN_IRQ
=20
 # Endianness selection
 choice
diff --git a/arch/microblaze/include/asm/irq.h b/arch/microblaze/include/asm/=
irq.h
index 0a28e80bbab0..cb6ab55d1d01 100644
--- a/arch/microblaze/include/asm/irq.h
+++ b/arch/microblaze/include/asm/irq.h
@@ -11,7 +11,4 @@
 struct pt_regs;
 extern void do_IRQ(struct pt_regs *regs);
=20
-/* should be defined in each interrupt controller driver */
-extern unsigned int xintc_get_irq(void);
-
 #endif /* _ASM_MICROBLAZE_IRQ_H */
diff --git a/arch/microblaze/kernel/irq.c b/arch/microblaze/kernel/irq.c
index 903dad822fad..1f8cb4c4f74f 100644
--- a/arch/microblaze/kernel/irq.c
+++ b/arch/microblaze/kernel/irq.c
@@ -20,27 +20,13 @@
 #include <linux/irqchip.h>
 #include <linux/of_irq.h>
=20
-static u32 concurrent_irq;
-
 void __irq_entry do_IRQ(struct pt_regs *regs)
 {
-	unsigned int irq;
 	struct pt_regs *old_regs =3D set_irq_regs(regs);
 	trace_hardirqs_off();
=20
 	irq_enter();
-	irq =3D xintc_get_irq();
-next_irq:
-	BUG_ON(!irq);
-	generic_handle_irq(irq);
-
-	irq =3D xintc_get_irq();
-	if (irq !=3D -1U) {
-		pr_debug("next irq: %d\n", irq);
-		++concurrent_irq;
-		goto next_irq;
-	}
-
+	handle_arch_irq(regs);
 	irq_exit();
 	set_irq_regs(old_regs);
 	trace_hardirqs_on();
diff --git a/drivers/gpio/gpio-mt7621.c b/drivers/gpio/gpio-mt7621.c
index ccaad1cb3c2e..d8a26e503ca5 100644
--- a/drivers/gpio/gpio-mt7621.c
+++ b/drivers/gpio/gpio-mt7621.c
@@ -239,7 +239,6 @@ mediatek_gpio_bank_probe(struct device *dev, int bank)
=20
 	rg->chip.offset =3D bank * MTK_BANK_WIDTH;
 	rg->irq_chip.name =3D dev_name(dev);
-	rg->irq_chip.parent_device =3D dev;
 	rg->irq_chip.irq_unmask =3D mediatek_gpio_irq_unmask;
 	rg->irq_chip.irq_mask =3D mediatek_gpio_irq_mask;
 	rg->irq_chip.irq_mask_ack =3D mediatek_gpio_irq_mask;
diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index e099c39e0355..80ddc43fd875 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -986,7 +986,8 @@ static void omap_gpio_mod_init(struct gpio_bank *bank)
 		writel_relaxed(0, base + bank->regs->ctrl);
 }
=20
-static int omap_gpio_chip_init(struct gpio_bank *bank, struct irq_chip *irqc)
+static int omap_gpio_chip_init(struct gpio_bank *bank, struct irq_chip *irqc,
+			       struct device *pm_dev)
 {
 	struct gpio_irq_chip *irq;
 	static int gpio;
@@ -1052,6 +1053,7 @@ static int omap_gpio_chip_init(struct gpio_bank *bank, =
struct irq_chip *irqc)
 	if (ret)
 		return dev_err_probe(bank->chip.parent, ret, "Could not register gpio chip=
\n");
=20
+	irq_domain_set_pm_device(bank->chip.irq.domain, pm_dev);
 	ret =3D devm_request_irq(bank->chip.parent, bank->irq,
 			       omap_gpio_irq_handler,
 			       0, dev_name(bank->chip.parent), bank);
@@ -1402,7 +1404,6 @@ static int omap_gpio_probe(struct platform_device *pdev)
 	irqc->irq_bus_sync_unlock =3D gpio_irq_bus_sync_unlock,
 	irqc->name =3D dev_name(&pdev->dev);
 	irqc->flags =3D IRQCHIP_MASK_ON_SUSPEND;
-	irqc->parent_device =3D dev;
=20
 	bank->irq =3D platform_get_irq(pdev, 0);
 	if (bank->irq <=3D 0) {
@@ -1466,7 +1467,7 @@ static int omap_gpio_probe(struct platform_device *pdev)
=20
 	omap_gpio_mod_init(bank);
=20
-	ret =3D omap_gpio_chip_init(bank, irqc);
+	ret =3D omap_gpio_chip_init(bank, irqc, dev);
 	if (ret) {
 		pm_runtime_put_sync(dev);
 		pm_runtime_disable(dev);
diff --git a/drivers/gpio/gpio-rcar.c b/drivers/gpio/gpio-rcar.c
index bd2e16d6e21c..3a76538f27fa 100644
--- a/drivers/gpio/gpio-rcar.c
+++ b/drivers/gpio/gpio-rcar.c
@@ -530,7 +530,6 @@ static int gpio_rcar_probe(struct platform_device *pdev)
=20
 	irq_chip =3D &p->irq_chip;
 	irq_chip->name =3D "gpio-rcar";
-	irq_chip->parent_device =3D dev;
 	irq_chip->irq_mask =3D gpio_rcar_irq_disable;
 	irq_chip->irq_unmask =3D gpio_rcar_irq_enable;
 	irq_chip->irq_set_type =3D gpio_rcar_irq_set_type;
@@ -552,6 +551,7 @@ static int gpio_rcar_probe(struct platform_device *pdev)
 		goto err0;
 	}
=20
+	irq_domain_set_pm_device(gpio_chip->irq.domain, dev);
 	ret =3D devm_request_irq(dev, p->irq_parent, gpio_rcar_irq_handler,
 			       IRQF_SHARED, name, p);
 	if (ret) {
diff --git a/drivers/gpio/gpio-tqmx86.c b/drivers/gpio/gpio-tqmx86.c
index 5b103221b58d..fa4bc7481f9a 100644
--- a/drivers/gpio/gpio-tqmx86.c
+++ b/drivers/gpio/gpio-tqmx86.c
@@ -281,7 +281,6 @@ static int tqmx86_gpio_probe(struct platform_device *pdev)
 		u8 irq_status;
=20
 		irq_chip->name =3D chip->label;
-		irq_chip->parent_device =3D &pdev->dev;
 		irq_chip->irq_mask =3D tqmx86_gpio_irq_mask;
 		irq_chip->irq_unmask =3D tqmx86_gpio_irq_unmask;
 		irq_chip->irq_set_type =3D tqmx86_gpio_irq_set_type;
@@ -316,6 +315,8 @@ static int tqmx86_gpio_probe(struct platform_device *pdev)
 		goto out_pm_dis;
 	}
=20
+	irq_domain_set_pm_device(girq->domain, dev);
+
 	dev_info(dev, "GPIO functionality initialized with %d pins\n",
 		 chip->ngpio);
=20
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 7038957f4a77..680d2fcf2686 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -430,6 +430,14 @@ config QCOM_PDC
 	  Power Domain Controller driver to manage and configure wakeup
 	  IRQs for Qualcomm Technologies Inc (QTI) mobile chips.
=20
+config QCOM_MPM
+	tristate "QCOM MPM"
+	depends on ARCH_QCOM
+	select IRQ_DOMAIN_HIERARCHY
+	help
+	  MSM Power Manager driver to manage and configure wakeup
+	  IRQs for Qualcomm Technologies Inc (QTI) mobile chips.
+
 config CSKY_MPINTC
 	bool
 	depends on CSKY
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index c1f611cbfbf8..1f8990f812f1 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -94,6 +94,7 @@ obj-$(CONFIG_MESON_IRQ_GPIO)		+=3D irq-meson-gpio.o
 obj-$(CONFIG_GOLDFISH_PIC) 		+=3D irq-goldfish-pic.o
 obj-$(CONFIG_NDS32)			+=3D irq-ativic32.o
 obj-$(CONFIG_QCOM_PDC)			+=3D qcom-pdc.o
+obj-$(CONFIG_QCOM_MPM)			+=3D irq-qcom-mpm.o
 obj-$(CONFIG_CSKY_MPINTC)		+=3D irq-csky-mpintc.o
 obj-$(CONFIG_CSKY_APB_INTC)		+=3D irq-csky-apb-intc.o
 obj-$(CONFIG_RISCV_INTC)		+=3D irq-riscv-intc.o
diff --git a/drivers/irqchip/irq-apple-aic.c b/drivers/irqchip/irq-apple-aic.c
index 38091ebb9403..12dd48727a15 100644
--- a/drivers/irqchip/irq-apple-aic.c
+++ b/drivers/irqchip/irq-apple-aic.c
@@ -24,7 +24,7 @@
  * - Default "this CPU" register view and explicit per-CPU views
  *
  * In addition, this driver also handles FIQs, as these are routed to the sa=
me
- * IRQ vector. These are used for Fast IPIs (TODO), the ARMv8 timer IRQs, and
+ * IRQ vector. These are used for Fast IPIs, the ARMv8 timer IRQs, and
  * performance counters (TODO).
  *
  * Implementation notes:
@@ -52,9 +52,12 @@
 #include <linux/irqchip.h>
 #include <linux/irqchip/arm-vgic-info.h>
 #include <linux/irqdomain.h>
+#include <linux/jump_label.h>
 #include <linux/limits.h>
 #include <linux/of_address.h>
 #include <linux/slab.h>
+#include <asm/apple_m1_pmu.h>
+#include <asm/cputype.h>
 #include <asm/exception.h>
 #include <asm/sysreg.h>
 #include <asm/virt.h>
@@ -62,20 +65,22 @@
 #include <dt-bindings/interrupt-controller/apple-aic.h>
=20
 /*
- * AIC registers (MMIO)
+ * AIC v1 registers (MMIO)
  */
=20
 #define AIC_INFO		0x0004
-#define AIC_INFO_NR_HW		GENMASK(15, 0)
+#define AIC_INFO_NR_IRQ		GENMASK(15, 0)
=20
 #define AIC_CONFIG		0x0010
=20
 #define AIC_WHOAMI		0x2000
 #define AIC_EVENT		0x2004
-#define AIC_EVENT_TYPE		GENMASK(31, 16)
+#define AIC_EVENT_DIE		GENMASK(31, 24)
+#define AIC_EVENT_TYPE		GENMASK(23, 16)
 #define AIC_EVENT_NUM		GENMASK(15, 0)
=20
-#define AIC_EVENT_TYPE_HW	1
+#define AIC_EVENT_TYPE_FIQ	0 /* Software use */
+#define AIC_EVENT_TYPE_IRQ	1
 #define AIC_EVENT_TYPE_IPI	4
 #define AIC_EVENT_IPI_OTHER	1
 #define AIC_EVENT_IPI_SELF	2
@@ -91,34 +96,73 @@
 #define AIC_IPI_SELF		BIT(31)
=20
 #define AIC_TARGET_CPU		0x3000
-#define AIC_SW_SET		0x4000
-#define AIC_SW_CLR		0x4080
-#define AIC_MASK_SET		0x4100
-#define AIC_MASK_CLR		0x4180
=20
 #define AIC_CPU_IPI_SET(cpu)	(0x5008 + ((cpu) << 7))
 #define AIC_CPU_IPI_CLR(cpu)	(0x500c + ((cpu) << 7))
 #define AIC_CPU_IPI_MASK_SET(cpu) (0x5024 + ((cpu) << 7))
 #define AIC_CPU_IPI_MASK_CLR(cpu) (0x5028 + ((cpu) << 7))
=20
+#define AIC_MAX_IRQ		0x400
+
+/*
+ * AIC v2 registers (MMIO)
+ */
+
+#define AIC2_VERSION		0x0000
+#define AIC2_VERSION_VER	GENMASK(7, 0)
+
+#define AIC2_INFO1		0x0004
+#define AIC2_INFO1_NR_IRQ	GENMASK(15, 0)
+#define AIC2_INFO1_LAST_DIE	GENMASK(27, 24)
+
+#define AIC2_INFO2		0x0008
+
+#define AIC2_INFO3		0x000c
+#define AIC2_INFO3_MAX_IRQ	GENMASK(15, 0)
+#define AIC2_INFO3_MAX_DIE	GENMASK(27, 24)
+
+#define AIC2_RESET		0x0010
+#define AIC2_RESET_RESET	BIT(0)
+
+#define AIC2_CONFIG		0x0014
+#define AIC2_CONFIG_ENABLE	BIT(0)
+#define AIC2_CONFIG_PREFER_PCPU	BIT(28)
+
+#define AIC2_TIMEOUT		0x0028
+#define AIC2_CLUSTER_PRIO	0x0030
+#define AIC2_DELAY_GROUPS	0x0100
+
+#define AIC2_IRQ_CFG		0x2000
+
+/*
+ * AIC2 registers are laid out like this, starting at AIC2_IRQ_CFG:
+ *
+ * Repeat for each die:
+ *   IRQ_CFG: u32 * MAX_IRQS
+ *   SW_SET: u32 * (MAX_IRQS / 32)
+ *   SW_CLR: u32 * (MAX_IRQS / 32)
+ *   MASK_SET: u32 * (MAX_IRQS / 32)
+ *   MASK_CLR: u32 * (MAX_IRQS / 32)
+ *   HW_STATE: u32 * (MAX_IRQS / 32)
+ *
+ * This is followed by a set of event registers, each 16K page aligned.
+ * The first one is the AP event register we will use. Unfortunately,
+ * the actual implemented die count is not specified anywhere in the
+ * capability registers, so we have to explicitly specify the event
+ * register as a second reg entry in the device tree to remain
+ * forward-compatible.
+ */
+
+#define AIC2_IRQ_CFG_TARGET	GENMASK(3, 0)
+#define AIC2_IRQ_CFG_DELAY_IDX	GENMASK(7, 5)
+
 #define MASK_REG(x)		(4 * ((x) >> 5))
 #define MASK_BIT(x)		BIT((x) & GENMASK(4, 0))
=20
 /*
  * IMP-DEF sysregs that control FIQ sources
- * Note: sysreg-based IPIs are not supported yet.
  */
=20
-/* Core PMC control register */
-#define SYS_IMP_APL_PMCR0_EL1		sys_reg(3, 1, 15, 0, 0)
-#define PMCR0_IMODE			GENMASK(10, 8)
-#define PMCR0_IMODE_OFF			0
-#define PMCR0_IMODE_PMI			1
-#define PMCR0_IMODE_AIC			2
-#define PMCR0_IMODE_HALT		3
-#define PMCR0_IMODE_FIQ			4
-#define PMCR0_IACT			BIT(11)
-
 /* IPI request registers */
 #define SYS_IMP_APL_IPI_RR_LOCAL_EL1	sys_reg(3, 5, 15, 0, 0)
 #define SYS_IMP_APL_IPI_RR_GLOBAL_EL1	sys_reg(3, 5, 15, 0, 1)
@@ -155,7 +199,18 @@
 #define SYS_IMP_APL_UPMSR_EL1		sys_reg(3, 7, 15, 6, 4)
 #define UPMSR_IACT			BIT(0)
=20
-#define AIC_NR_FIQ		4
+/* MPIDR fields */
+#define MPIDR_CPU(x)			MPIDR_AFFINITY_LEVEL(x, 0)
+#define MPIDR_CLUSTER(x)		MPIDR_AFFINITY_LEVEL(x, 1)
+
+#define AIC_IRQ_HWIRQ(die, irq)	(FIELD_PREP(AIC_EVENT_DIE, die) | \
+				 FIELD_PREP(AIC_EVENT_TYPE, AIC_EVENT_TYPE_IRQ) | \
+				 FIELD_PREP(AIC_EVENT_NUM, irq))
+#define AIC_FIQ_HWIRQ(x)	(FIELD_PREP(AIC_EVENT_TYPE, AIC_EVENT_TYPE_FIQ) | \
+				 FIELD_PREP(AIC_EVENT_NUM, x))
+#define AIC_HWIRQ_IRQ(x)	FIELD_GET(AIC_EVENT_NUM, x)
+#define AIC_HWIRQ_DIE(x)	FIELD_GET(AIC_EVENT_DIE, x)
+#define AIC_NR_FIQ		6
 #define AIC_NR_SWIPI		32
=20
 /*
@@ -173,11 +228,81 @@
 #define AIC_TMR_EL02_PHYS	AIC_TMR_GUEST_PHYS
 #define AIC_TMR_EL02_VIRT	AIC_TMR_GUEST_VIRT
=20
+DEFINE_STATIC_KEY_TRUE(use_fast_ipi);
+
+struct aic_info {
+	int version;
+
+	/* Register offsets */
+	u32 event;
+	u32 target_cpu;
+	u32 irq_cfg;
+	u32 sw_set;
+	u32 sw_clr;
+	u32 mask_set;
+	u32 mask_clr;
+
+	u32 die_stride;
+
+	/* Features */
+	bool fast_ipi;
+};
+
+static const struct aic_info aic1_info =3D {
+	.version	=3D 1,
+
+	.event		=3D AIC_EVENT,
+	.target_cpu	=3D AIC_TARGET_CPU,
+};
+
+static const struct aic_info aic1_fipi_info =3D {
+	.version	=3D 1,
+
+	.event		=3D AIC_EVENT,
+	.target_cpu	=3D AIC_TARGET_CPU,
+
+	.fast_ipi	=3D true,
+};
+
+static const struct aic_info aic2_info =3D {
+	.version	=3D 2,
+
+	.irq_cfg	=3D AIC2_IRQ_CFG,
+
+	.fast_ipi	=3D true,
+};
+
+static const struct of_device_id aic_info_match[] =3D {
+	{
+		.compatible =3D "apple,t8103-aic",
+		.data =3D &aic1_fipi_info,
+	},
+	{
+		.compatible =3D "apple,aic",
+		.data =3D &aic1_info,
+	},
+	{
+		.compatible =3D "apple,aic2",
+		.data =3D &aic2_info,
+	},
+	{}
+};
+
 struct aic_irq_chip {
 	void __iomem *base;
+	void __iomem *event;
 	struct irq_domain *hw_domain;
 	struct irq_domain *ipi_domain;
-	int nr_hw;
+	struct {
+		cpumask_t aff;
+	} *fiq_aff[AIC_NR_FIQ];
+
+	int nr_irq;
+	int max_irq;
+	int nr_die;
+	int max_die;
+
+	struct aic_info info;
 };
=20
 static DEFINE_PER_CPU(uint32_t, aic_fiq_unmasked);
@@ -205,18 +330,24 @@ static void aic_ic_write(struct aic_irq_chip *ic, u32 r=
eg, u32 val)
=20
 static void aic_irq_mask(struct irq_data *d)
 {
+	irq_hw_number_t hwirq =3D irqd_to_hwirq(d);
 	struct aic_irq_chip *ic =3D irq_data_get_irq_chip_data(d);
=20
-	aic_ic_write(ic, AIC_MASK_SET + MASK_REG(irqd_to_hwirq(d)),
-		     MASK_BIT(irqd_to_hwirq(d)));
+	u32 off =3D AIC_HWIRQ_DIE(hwirq) * ic->info.die_stride;
+	u32 irq =3D AIC_HWIRQ_IRQ(hwirq);
+
+	aic_ic_write(ic, ic->info.mask_set + off + MASK_REG(irq), MASK_BIT(irq));
 }
=20
 static void aic_irq_unmask(struct irq_data *d)
 {
+	irq_hw_number_t hwirq =3D irqd_to_hwirq(d);
 	struct aic_irq_chip *ic =3D irq_data_get_irq_chip_data(d);
=20
-	aic_ic_write(ic, AIC_MASK_CLR + MASK_REG(d->hwirq),
-		     MASK_BIT(irqd_to_hwirq(d)));
+	u32 off =3D AIC_HWIRQ_DIE(hwirq) * ic->info.die_stride;
+	u32 irq =3D AIC_HWIRQ_IRQ(hwirq);
+
+	aic_ic_write(ic, ic->info.mask_clr + off + MASK_REG(irq), MASK_BIT(irq));
 }
=20
 static void aic_irq_eoi(struct irq_data *d)
@@ -239,12 +370,12 @@ static void __exception_irq_entry aic_handle_irq(struct=
 pt_regs *regs)
 		 * We cannot use a relaxed read here, as reads from DMA buffers
 		 * need to be ordered after the IRQ fires.
 		 */
-		event =3D readl(ic->base + AIC_EVENT);
+		event =3D readl(ic->event + ic->info.event);
 		type =3D FIELD_GET(AIC_EVENT_TYPE, event);
 		irq =3D FIELD_GET(AIC_EVENT_NUM, event);
=20
-		if (type =3D=3D AIC_EVENT_TYPE_HW)
-			generic_handle_domain_irq(aic_irqc->hw_domain, irq);
+		if (type =3D=3D AIC_EVENT_TYPE_IRQ)
+			generic_handle_domain_irq(aic_irqc->hw_domain, event);
 		else if (type =3D=3D AIC_EVENT_TYPE_IPI && irq =3D=3D 1)
 			aic_handle_ipi(regs);
 		else if (event !=3D 0)
@@ -271,12 +402,14 @@ static int aic_irq_set_affinity(struct irq_data *d,
 	struct aic_irq_chip *ic =3D irq_data_get_irq_chip_data(d);
 	int cpu;
=20
+	BUG_ON(!ic->info.target_cpu);
+
 	if (force)
 		cpu =3D cpumask_first(mask_val);
 	else
 		cpu =3D cpumask_any_and(mask_val, cpu_online_mask);
=20
-	aic_ic_write(ic, AIC_TARGET_CPU + hwirq * 4, BIT(cpu));
+	aic_ic_write(ic, ic->info.target_cpu + AIC_HWIRQ_IRQ(hwirq) * 4, BIT(cpu));
 	irq_data_update_effective_affinity(d, cpumask_of(cpu));
=20
 	return IRQ_SET_MASK_OK;
@@ -300,15 +433,21 @@ static struct irq_chip aic_chip =3D {
 	.irq_set_type =3D aic_irq_set_type,
 };
=20
+static struct irq_chip aic2_chip =3D {
+	.name =3D "AIC2",
+	.irq_mask =3D aic_irq_mask,
+	.irq_unmask =3D aic_irq_unmask,
+	.irq_eoi =3D aic_irq_eoi,
+	.irq_set_type =3D aic_irq_set_type,
+};
+
 /*
  * FIQ irqchip
  */
=20
 static unsigned long aic_fiq_get_idx(struct irq_data *d)
 {
-	struct aic_irq_chip *ic =3D irq_data_get_irq_chip_data(d);
-
-	return irqd_to_hwirq(d) - ic->nr_hw;
+	return AIC_HWIRQ_IRQ(irqd_to_hwirq(d));
 }
=20
 static void aic_fiq_set_mask(struct irq_data *d)
@@ -386,17 +525,21 @@ static void __exception_irq_entry aic_handle_fiq(struct=
 pt_regs *regs)
 	 */
=20
 	if (read_sysreg_s(SYS_IMP_APL_IPI_SR_EL1) & IPI_SR_PENDING) {
-		pr_err_ratelimited("Fast IPI fired. Acking.\n");
-		write_sysreg_s(IPI_SR_PENDING, SYS_IMP_APL_IPI_SR_EL1);
+		if (static_branch_likely(&use_fast_ipi)) {
+			aic_handle_ipi(regs);
+		} else {
+			pr_err_ratelimited("Fast IPI fired. Acking.\n");
+			write_sysreg_s(IPI_SR_PENDING, SYS_IMP_APL_IPI_SR_EL1);
+		}
 	}
=20
 	if (TIMER_FIRING(read_sysreg(cntp_ctl_el0)))
 		generic_handle_domain_irq(aic_irqc->hw_domain,
-					  aic_irqc->nr_hw + AIC_TMR_EL0_PHYS);
+					  AIC_FIQ_HWIRQ(AIC_TMR_EL0_PHYS));
=20
 	if (TIMER_FIRING(read_sysreg(cntv_ctl_el0)))
 		generic_handle_domain_irq(aic_irqc->hw_domain,
-					  aic_irqc->nr_hw + AIC_TMR_EL0_VIRT);
+					  AIC_FIQ_HWIRQ(AIC_TMR_EL0_VIRT));
=20
 	if (is_kernel_in_hyp_mode()) {
 		uint64_t enabled =3D read_sysreg_s(SYS_IMP_APL_VM_TMR_FIQ_ENA_EL2);
@@ -404,24 +547,23 @@ static void __exception_irq_entry aic_handle_fiq(struct=
 pt_regs *regs)
 		if ((enabled & VM_TMR_FIQ_ENABLE_P) &&
 		    TIMER_FIRING(read_sysreg_s(SYS_CNTP_CTL_EL02)))
 			generic_handle_domain_irq(aic_irqc->hw_domain,
-						  aic_irqc->nr_hw + AIC_TMR_EL02_PHYS);
+						  AIC_FIQ_HWIRQ(AIC_TMR_EL02_PHYS));
=20
 		if ((enabled & VM_TMR_FIQ_ENABLE_V) &&
 		    TIMER_FIRING(read_sysreg_s(SYS_CNTV_CTL_EL02)))
 			generic_handle_domain_irq(aic_irqc->hw_domain,
-						  aic_irqc->nr_hw + AIC_TMR_EL02_VIRT);
+						  AIC_FIQ_HWIRQ(AIC_TMR_EL02_VIRT));
 	}
=20
-	if ((read_sysreg_s(SYS_IMP_APL_PMCR0_EL1) & (PMCR0_IMODE | PMCR0_IACT)) =3D=
=3D
-			(FIELD_PREP(PMCR0_IMODE, PMCR0_IMODE_FIQ) | PMCR0_IACT)) {
-		/*
-		 * Not supported yet, let's figure out how to handle this when
-		 * we implement these proprietary performance counters. For now,
-		 * just mask it and move on.
-		 */
-		pr_err_ratelimited("PMC FIQ fired. Masking.\n");
-		sysreg_clear_set_s(SYS_IMP_APL_PMCR0_EL1, PMCR0_IMODE | PMCR0_IACT,
-				   FIELD_PREP(PMCR0_IMODE, PMCR0_IMODE_OFF));
+	if (read_sysreg_s(SYS_IMP_APL_PMCR0_EL1) & PMCR0_IACT) {
+		int irq;
+		if (cpumask_test_cpu(smp_processor_id(),
+				     &aic_irqc->fiq_aff[AIC_CPU_PMU_P]->aff))
+			irq =3D AIC_CPU_PMU_P;
+		else
+			irq =3D AIC_CPU_PMU_E;
+		generic_handle_domain_irq(aic_irqc->hw_domain,
+					  AIC_FIQ_HWIRQ(irq));
 	}
=20
 	if (FIELD_GET(UPMCR0_IMODE, read_sysreg_s(SYS_IMP_APL_UPMCR0_EL1)) =3D=3D U=
PMCR0_IMODE_FIQ &&
@@ -455,13 +597,29 @@ static int aic_irq_domain_map(struct irq_domain *id, un=
signed int irq,
 			      irq_hw_number_t hw)
 {
 	struct aic_irq_chip *ic =3D id->host_data;
+	u32 type =3D FIELD_GET(AIC_EVENT_TYPE, hw);
+	struct irq_chip *chip =3D &aic_chip;
=20
-	if (hw < ic->nr_hw) {
-		irq_domain_set_info(id, irq, hw, &aic_chip, id->host_data,
+	if (ic->info.version =3D=3D 2)
+		chip =3D &aic2_chip;
+
+	if (type =3D=3D AIC_EVENT_TYPE_IRQ) {
+		irq_domain_set_info(id, irq, hw, chip, id->host_data,
 				    handle_fasteoi_irq, NULL, NULL);
 		irqd_set_single_target(irq_desc_get_irq_data(irq_to_desc(irq)));
 	} else {
-		irq_set_percpu_devid(irq);
+		int fiq =3D FIELD_GET(AIC_EVENT_NUM, hw);
+
+		switch (fiq) {
+		case AIC_CPU_PMU_P:
+		case AIC_CPU_PMU_E:
+			irq_set_percpu_devid_partition(irq, &ic->fiq_aff[fiq]->aff);
+			break;
+		default:
+			irq_set_percpu_devid(irq);
+			break;
+		}
+
 		irq_domain_set_info(id, irq, hw, &fiq_chip, id->host_data,
 				    handle_percpu_devid_irq, NULL, NULL);
 	}
@@ -475,32 +633,46 @@ static int aic_irq_domain_translate(struct irq_domain *=
id,
 				    unsigned int *type)
 {
 	struct aic_irq_chip *ic =3D id->host_data;
+	u32 *args;
+	u32 die =3D 0;
=20
-	if (fwspec->param_count !=3D 3 || !is_of_node(fwspec->fwnode))
+	if (fwspec->param_count < 3 || fwspec->param_count > 4 ||
+	    !is_of_node(fwspec->fwnode))
 		return -EINVAL;
=20
+	args =3D &fwspec->param[1];
+
+	if (fwspec->param_count =3D=3D 4) {
+		die =3D args[0];
+		args++;
+	}
+
 	switch (fwspec->param[0]) {
 	case AIC_IRQ:
-		if (fwspec->param[1] >=3D ic->nr_hw)
+		if (die >=3D ic->nr_die)
 			return -EINVAL;
-		*hwirq =3D fwspec->param[1];
+		if (args[0] >=3D ic->nr_irq)
+			return -EINVAL;
+		*hwirq =3D AIC_IRQ_HWIRQ(die, args[0]);
 		break;
 	case AIC_FIQ:
-		if (fwspec->param[1] >=3D AIC_NR_FIQ)
+		if (die !=3D 0)
+			return -EINVAL;
+		if (args[0] >=3D AIC_NR_FIQ)
 			return -EINVAL;
-		*hwirq =3D ic->nr_hw + fwspec->param[1];
+		*hwirq =3D AIC_FIQ_HWIRQ(args[0]);
=20
 		/*
 		 * In EL1 the non-redirected registers are the guest's,
 		 * not EL2's, so remap the hwirqs to match.
 		 */
 		if (!is_kernel_in_hyp_mode()) {
-			switch (fwspec->param[1]) {
+			switch (args[0]) {
 			case AIC_TMR_GUEST_PHYS:
-				*hwirq =3D ic->nr_hw + AIC_TMR_EL0_PHYS;
+				*hwirq =3D AIC_FIQ_HWIRQ(AIC_TMR_EL0_PHYS);
 				break;
 			case AIC_TMR_GUEST_VIRT:
-				*hwirq =3D ic->nr_hw + AIC_TMR_EL0_VIRT;
+				*hwirq =3D AIC_FIQ_HWIRQ(AIC_TMR_EL0_VIRT);
 				break;
 			case AIC_TMR_HV_PHYS:
 			case AIC_TMR_HV_VIRT:
@@ -514,7 +686,7 @@ static int aic_irq_domain_translate(struct irq_domain *id,
 		return -EINVAL;
 	}
=20
-	*type =3D fwspec->param[2] & IRQ_TYPE_SENSE_MASK;
+	*type =3D args[1] & IRQ_TYPE_SENSE_MASK;
=20
 	return 0;
 }
@@ -563,6 +735,22 @@ static const struct irq_domain_ops aic_irq_domain_ops =
=3D {
  * IPI irqchip
  */
=20
+static void aic_ipi_send_fast(int cpu)
+{
+	u64 mpidr =3D cpu_logical_map(cpu);
+	u64 my_mpidr =3D read_cpuid_mpidr();
+	u64 cluster =3D MPIDR_CLUSTER(mpidr);
+	u64 idx =3D MPIDR_CPU(mpidr);
+
+	if (MPIDR_CLUSTER(my_mpidr) =3D=3D cluster)
+		write_sysreg_s(FIELD_PREP(IPI_RR_CPU, idx),
+			       SYS_IMP_APL_IPI_RR_LOCAL_EL1);
+	else
+		write_sysreg_s(FIELD_PREP(IPI_RR_CPU, idx) | FIELD_PREP(IPI_RR_CLUSTER, cl=
uster),
+			       SYS_IMP_APL_IPI_RR_GLOBAL_EL1);
+	isb();
+}
+
 static void aic_ipi_mask(struct irq_data *d)
 {
 	u32 irq_bit =3D BIT(irqd_to_hwirq(d));
@@ -588,8 +776,12 @@ static void aic_ipi_unmask(struct irq_data *d)
 	 * If a pending vIPI was unmasked, raise a HW IPI to ourselves.
 	 * No barriers needed here since this is a self-IPI.
 	 */
-	if (atomic_read(this_cpu_ptr(&aic_vipi_flag)) & irq_bit)
-		aic_ic_write(ic, AIC_IPI_SEND, AIC_IPI_SEND_CPU(smp_processor_id()));
+	if (atomic_read(this_cpu_ptr(&aic_vipi_flag)) & irq_bit) {
+		if (static_branch_likely(&use_fast_ipi))
+			aic_ipi_send_fast(smp_processor_id());
+		else
+			aic_ic_write(ic, AIC_IPI_SEND, AIC_IPI_SEND_CPU(smp_processor_id()));
+	}
 }
=20
 static void aic_ipi_send_mask(struct irq_data *d, const struct cpumask *mask)
@@ -617,8 +809,12 @@ static void aic_ipi_send_mask(struct irq_data *d, const =
struct cpumask *mask)
 		smp_mb__after_atomic();
=20
 		if (!(pending & irq_bit) &&
-		    (atomic_read(per_cpu_ptr(&aic_vipi_enable, cpu)) & irq_bit))
-			send |=3D AIC_IPI_SEND_CPU(cpu);
+		    (atomic_read(per_cpu_ptr(&aic_vipi_enable, cpu)) & irq_bit)) {
+			if (static_branch_likely(&use_fast_ipi))
+				aic_ipi_send_fast(cpu);
+			else
+				send |=3D AIC_IPI_SEND_CPU(cpu);
+		}
 	}
=20
 	/*
@@ -650,8 +846,16 @@ static void aic_handle_ipi(struct pt_regs *regs)
 	/*
 	 * Ack the IPI. We need to order this after the AIC event read, but
 	 * that is enforced by normal MMIO ordering guarantees.
+	 *
+	 * For the Fast IPI case, this needs to be ordered before the vIPI
+	 * handling below, so we need to isb();
 	 */
-	aic_ic_write(aic_irqc, AIC_IPI_ACK, AIC_IPI_OTHER);
+	if (static_branch_likely(&use_fast_ipi)) {
+		write_sysreg_s(IPI_SR_PENDING, SYS_IMP_APL_IPI_SR_EL1);
+		isb();
+	} else {
+		aic_ic_write(aic_irqc, AIC_IPI_ACK, AIC_IPI_OTHER);
+	}
=20
 	/*
 	 * The mask read does not need to be ordered. Only we can change
@@ -679,7 +883,8 @@ static void aic_handle_ipi(struct pt_regs *regs)
 	 * No ordering needed here; at worst this just changes the timing of
 	 * when the next IPI will be delivered.
 	 */
-	aic_ic_write(aic_irqc, AIC_IPI_MASK_CLR, AIC_IPI_OTHER);
+	if (!static_branch_likely(&use_fast_ipi))
+		aic_ic_write(aic_irqc, AIC_IPI_MASK_CLR, AIC_IPI_OTHER);
 }
=20
 static int aic_ipi_alloc(struct irq_domain *d, unsigned int virq,
@@ -766,20 +971,27 @@ static int aic_init_cpu(unsigned int cpu)
 	/* Commit all of the above */
 	isb();
=20
-	/*
-	 * Make sure the kernel's idea of logical CPU order is the same as AIC's
-	 * If we ever end up with a mismatch here, we will have to introduce
-	 * a mapping table similar to what other irqchip drivers do.
-	 */
-	WARN_ON(aic_ic_read(aic_irqc, AIC_WHOAMI) !=3D smp_processor_id());
+	if (aic_irqc->info.version =3D=3D 1) {
+		/*
+		 * Make sure the kernel's idea of logical CPU order is the same as AIC's
+		 * If we ever end up with a mismatch here, we will have to introduce
+		 * a mapping table similar to what other irqchip drivers do.
+		 */
+		WARN_ON(aic_ic_read(aic_irqc, AIC_WHOAMI) !=3D smp_processor_id());
=20
-	/*
-	 * Always keep IPIs unmasked at the hardware level (except auto-masking
-	 * by AIC during processing). We manage masks at the vIPI level.
-	 */
-	aic_ic_write(aic_irqc, AIC_IPI_ACK, AIC_IPI_SELF | AIC_IPI_OTHER);
-	aic_ic_write(aic_irqc, AIC_IPI_MASK_SET, AIC_IPI_SELF);
-	aic_ic_write(aic_irqc, AIC_IPI_MASK_CLR, AIC_IPI_OTHER);
+		/*
+		 * Always keep IPIs unmasked at the hardware level (except auto-masking
+		 * by AIC during processing). We manage masks at the vIPI level.
+		 * These registers only exist on AICv1, AICv2 always uses fast IPIs.
+		 */
+		aic_ic_write(aic_irqc, AIC_IPI_ACK, AIC_IPI_SELF | AIC_IPI_OTHER);
+		if (static_branch_likely(&use_fast_ipi)) {
+			aic_ic_write(aic_irqc, AIC_IPI_MASK_SET, AIC_IPI_SELF | AIC_IPI_OTHER);
+		} else {
+			aic_ic_write(aic_irqc, AIC_IPI_MASK_SET, AIC_IPI_SELF);
+			aic_ic_write(aic_irqc, AIC_IPI_MASK_CLR, AIC_IPI_OTHER);
+		}
+	}
=20
 	/* Initialize the local mask state */
 	__this_cpu_write(aic_fiq_unmasked, 0);
@@ -793,68 +1005,193 @@ static struct gic_kvm_info vgic_info __initdata =3D {
 	.no_hw_deactivation	=3D true,
 };
=20
+static void build_fiq_affinity(struct aic_irq_chip *ic, struct device_node *=
aff)
+{
+	int i, n;
+	u32 fiq;
+
+	if (of_property_read_u32(aff, "apple,fiq-index", &fiq) ||
+	    WARN_ON(fiq >=3D AIC_NR_FIQ) || ic->fiq_aff[fiq])
+		return;
+
+	n =3D of_property_count_elems_of_size(aff, "cpus", sizeof(u32));
+	if (WARN_ON(n < 0))
+		return;
+
+	ic->fiq_aff[fiq] =3D kzalloc(sizeof(*ic->fiq_aff[fiq]), GFP_KERNEL);
+	if (!ic->fiq_aff[fiq])
+		return;
+
+	for (i =3D 0; i < n; i++) {
+		struct device_node *cpu_node;
+		u32 cpu_phandle;
+		int cpu;
+
+		if (of_property_read_u32_index(aff, "cpus", i, &cpu_phandle))
+			continue;
+
+		cpu_node =3D of_find_node_by_phandle(cpu_phandle);
+		if (WARN_ON(!cpu_node))
+			continue;
+
+		cpu =3D of_cpu_node_to_id(cpu_node);
+		if (WARN_ON(cpu < 0))
+			continue;
+
+		cpumask_set_cpu(cpu, &ic->fiq_aff[fiq]->aff);
+	}
+}
+
 static int __init aic_of_ic_init(struct device_node *node, struct device_nod=
e *parent)
 {
-	int i;
+	int i, die;
+	u32 off, start_off;
 	void __iomem *regs;
-	u32 info;
 	struct aic_irq_chip *irqc;
+	struct device_node *affs;
+	const struct of_device_id *match;
=20
 	regs =3D of_iomap(node, 0);
 	if (WARN_ON(!regs))
 		return -EIO;
=20
 	irqc =3D kzalloc(sizeof(*irqc), GFP_KERNEL);
-	if (!irqc)
+	if (!irqc) {
+		iounmap(regs);
 		return -ENOMEM;
+	}
=20
-	aic_irqc =3D irqc;
 	irqc->base =3D regs;
=20
-	info =3D aic_ic_read(irqc, AIC_INFO);
-	irqc->nr_hw =3D FIELD_GET(AIC_INFO_NR_HW, info);
+	match =3D of_match_node(aic_info_match, node);
+	if (!match)
+		goto err_unmap;
=20
-	irqc->hw_domain =3D irq_domain_create_linear(of_node_to_fwnode(node),
-						   irqc->nr_hw + AIC_NR_FIQ,
-						   &aic_irq_domain_ops, irqc);
-	if (WARN_ON(!irqc->hw_domain)) {
-		iounmap(irqc->base);
-		kfree(irqc);
-		return -ENODEV;
+	irqc->info =3D *(struct aic_info *)match->data;
+
+	aic_irqc =3D irqc;
+
+	switch (irqc->info.version) {
+	case 1: {
+		u32 info;
+
+		info =3D aic_ic_read(irqc, AIC_INFO);
+		irqc->nr_irq =3D FIELD_GET(AIC_INFO_NR_IRQ, info);
+		irqc->max_irq =3D AIC_MAX_IRQ;
+		irqc->nr_die =3D irqc->max_die =3D 1;
+
+		off =3D start_off =3D irqc->info.target_cpu;
+		off +=3D sizeof(u32) * irqc->max_irq; /* TARGET_CPU */
+
+		irqc->event =3D irqc->base;
+
+		break;
 	}
+	case 2: {
+		u32 info1, info3;
+
+		info1 =3D aic_ic_read(irqc, AIC2_INFO1);
+		info3 =3D aic_ic_read(irqc, AIC2_INFO3);
+
+		irqc->nr_irq =3D FIELD_GET(AIC2_INFO1_NR_IRQ, info1);
+		irqc->max_irq =3D FIELD_GET(AIC2_INFO3_MAX_IRQ, info3);
+		irqc->nr_die =3D FIELD_GET(AIC2_INFO1_LAST_DIE, info1) + 1;
+		irqc->max_die =3D FIELD_GET(AIC2_INFO3_MAX_DIE, info3);
+
+		off =3D start_off =3D irqc->info.irq_cfg;
+		off +=3D sizeof(u32) * irqc->max_irq; /* IRQ_CFG */
+
+		irqc->event =3D of_iomap(node, 1);
+		if (WARN_ON(!irqc->event))
+			goto err_unmap;
+
+		break;
+	}
+	}
+
+	irqc->info.sw_set =3D off;
+	off +=3D sizeof(u32) * (irqc->max_irq >> 5); /* SW_SET */
+	irqc->info.sw_clr =3D off;
+	off +=3D sizeof(u32) * (irqc->max_irq >> 5); /* SW_CLR */
+	irqc->info.mask_set =3D off;
+	off +=3D sizeof(u32) * (irqc->max_irq >> 5); /* MASK_SET */
+	irqc->info.mask_clr =3D off;
+	off +=3D sizeof(u32) * (irqc->max_irq >> 5); /* MASK_CLR */
+	off +=3D sizeof(u32) * (irqc->max_irq >> 5); /* HW_STATE */
+
+	if (irqc->info.fast_ipi)
+		static_branch_enable(&use_fast_ipi);
+	else
+		static_branch_disable(&use_fast_ipi);
+
+	irqc->info.die_stride =3D off - start_off;
+
+	irqc->hw_domain =3D irq_domain_create_tree(of_node_to_fwnode(node),
+						 &aic_irq_domain_ops, irqc);
+	if (WARN_ON(!irqc->hw_domain))
+		goto err_unmap;
=20
 	irq_domain_update_bus_token(irqc->hw_domain, DOMAIN_BUS_WIRED);
=20
-	if (aic_init_smp(irqc, node)) {
-		irq_domain_remove(irqc->hw_domain);
-		iounmap(irqc->base);
-		kfree(irqc);
-		return -ENODEV;
+	if (aic_init_smp(irqc, node))
+		goto err_remove_domain;
+
+	affs =3D of_get_child_by_name(node, "affinities");
+	if (affs) {
+		struct device_node *chld;
+
+		for_each_child_of_node(affs, chld)
+			build_fiq_affinity(irqc, chld);
 	}
=20
 	set_handle_irq(aic_handle_irq);
 	set_handle_fiq(aic_handle_fiq);
=20
-	for (i =3D 0; i < BITS_TO_U32(irqc->nr_hw); i++)
-		aic_ic_write(irqc, AIC_MASK_SET + i * 4, U32_MAX);
-	for (i =3D 0; i < BITS_TO_U32(irqc->nr_hw); i++)
-		aic_ic_write(irqc, AIC_SW_CLR + i * 4, U32_MAX);
-	for (i =3D 0; i < irqc->nr_hw; i++)
-		aic_ic_write(irqc, AIC_TARGET_CPU + i * 4, 1);
+	off =3D 0;
+	for (die =3D 0; die < irqc->nr_die; die++) {
+		for (i =3D 0; i < BITS_TO_U32(irqc->nr_irq); i++)
+			aic_ic_write(irqc, irqc->info.mask_set + off + i * 4, U32_MAX);
+		for (i =3D 0; i < BITS_TO_U32(irqc->nr_irq); i++)
+			aic_ic_write(irqc, irqc->info.sw_clr + off + i * 4, U32_MAX);
+		if (irqc->info.target_cpu)
+			for (i =3D 0; i < irqc->nr_irq; i++)
+				aic_ic_write(irqc, irqc->info.target_cpu + off + i * 4, 1);
+		off +=3D irqc->info.die_stride;
+	}
+
+	if (irqc->info.version =3D=3D 2) {
+		u32 config =3D aic_ic_read(irqc, AIC2_CONFIG);
+
+		config |=3D AIC2_CONFIG_ENABLE;
+		aic_ic_write(irqc, AIC2_CONFIG, config);
+	}
=20
 	if (!is_kernel_in_hyp_mode())
 		pr_info("Kernel running in EL1, mapping interrupts");
=20
+	if (static_branch_likely(&use_fast_ipi))
+		pr_info("Using Fast IPIs");
+
 	cpuhp_setup_state(CPUHP_AP_IRQ_APPLE_AIC_STARTING,
 			  "irqchip/apple-aic/ipi:starting",
 			  aic_init_cpu, NULL);
=20
 	vgic_set_kvm_info(&vgic_info);
=20
-	pr_info("Initialized with %d IRQs, %d FIQs, %d vIPIs\n",
-		irqc->nr_hw, AIC_NR_FIQ, AIC_NR_SWIPI);
+	pr_info("Initialized with %d/%d IRQs * %d/%d die(s), %d FIQs, %d vIPIs",
+		irqc->nr_irq, irqc->max_irq, irqc->nr_die, irqc->max_die, AIC_NR_FIQ, AIC_=
NR_SWIPI);
=20
 	return 0;
+
+err_remove_domain:
+	irq_domain_remove(irqc->hw_domain);
+err_unmap:
+	if (irqc->event && irqc->event !=3D irqc->base)
+		iounmap(irqc->event);
+	iounmap(irqc->base);
+	kfree(irqc);
+	return -ENODEV;
 }
=20
-IRQCHIP_DECLARE(apple_m1_aic, "apple,aic", aic_of_ic_init);
+IRQCHIP_DECLARE(apple_aic, "apple,aic", aic_of_ic_init);
+IRQCHIP_DECLARE(apple_aic2, "apple,aic2", aic_of_ic_init);
diff --git a/drivers/irqchip/irq-ftintc010.c b/drivers/irqchip/irq-ftintc010.c
index 5cc268880f8e..46a3aa60e50e 100644
--- a/drivers/irqchip/irq-ftintc010.c
+++ b/drivers/irqchip/irq-ftintc010.c
@@ -11,7 +11,6 @@
 #include <linux/irq.h>
 #include <linux/io.h>
 #include <linux/irqchip.h>
-#include <linux/irqchip/versatile-fpga.h>
 #include <linux/irqdomain.h>
 #include <linux/module.h>
 #include <linux/of.h>
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 5e935d97207d..0efe1a9a9f3b 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -1211,7 +1211,7 @@ static void gic_ipi_send_mask(struct irq_data *d, const=
 struct cpumask *mask)
 	 * Ensure that stores to Normal memory are visible to the
 	 * other CPUs before issuing the IPI.
 	 */
-	wmb();
+	dsb(ishst);
=20
 	for_each_cpu(cpu, mask) {
 		u64 cluster_id =3D MPIDR_TO_SGI_CLUSTER_ID(cpu_logical_map(cpu));
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index b8bb46c65a97..58ba835bee1f 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -34,6 +34,7 @@
 #include <linux/irqdomain.h>
 #include <linux/interrupt.h>
 #include <linux/percpu.h>
+#include <linux/seq_file.h>
 #include <linux/slab.h>
 #include <linux/irqchip.h>
 #include <linux/irqchip/chained_irq.h>
@@ -66,7 +67,6 @@ union gic_base {
 };
=20
 struct gic_chip_data {
-	struct irq_chip chip;
 	union gic_base dist_base;
 	union gic_base cpu_base;
 	void __iomem *raw_dist_base;
@@ -397,18 +397,15 @@ static void gic_handle_cascade_irq(struct irq_desc *des=
c)
 	chained_irq_exit(chip, desc);
 }
=20
-static const struct irq_chip gic_chip =3D {
-	.irq_mask		=3D gic_mask_irq,
-	.irq_unmask		=3D gic_unmask_irq,
-	.irq_eoi		=3D gic_eoi_irq,
-	.irq_set_type		=3D gic_set_type,
-	.irq_retrigger          =3D gic_retrigger,
-	.irq_get_irqchip_state	=3D gic_irq_get_irqchip_state,
-	.irq_set_irqchip_state	=3D gic_irq_set_irqchip_state,
-	.flags			=3D IRQCHIP_SET_TYPE_MASKED |
-				  IRQCHIP_SKIP_SET_WAKE |
-				  IRQCHIP_MASK_ON_SUSPEND,
-};
+static void gic_irq_print_chip(struct irq_data *d, struct seq_file *p)
+{
+	struct gic_chip_data *gic =3D irq_data_get_irq_chip_data(d);
+
+	if (gic->domain->dev)
+		seq_printf(p, gic->domain->dev->of_node->name);
+	else
+		seq_printf(p, "GIC-%d", (int)(gic - &gic_data[0]));
+}
=20
 void __init gic_cascade_irq(unsigned int gic_nr, unsigned int irq)
 {
@@ -799,8 +796,12 @@ static int gic_set_affinity(struct irq_data *d, const st=
ruct cpumask *mask_val,
 			    bool force)
 {
 	void __iomem *reg =3D gic_dist_base(d) + GIC_DIST_TARGET + gic_irq(d);
+	struct gic_chip_data *gic =3D irq_data_get_irq_chip_data(d);
 	unsigned int cpu;
=20
+	if (unlikely(gic !=3D &gic_data[0]))
+		return -EINVAL;
+
 	if (!force)
 		cpu =3D cpumask_any_and(mask_val, cpu_online_mask);
 	else
@@ -880,6 +881,39 @@ static __init void gic_smp_init(void)
 #define gic_ipi_send_mask	NULL
 #endif
=20
+static const struct irq_chip gic_chip =3D {
+	.irq_mask		=3D gic_mask_irq,
+	.irq_unmask		=3D gic_unmask_irq,
+	.irq_eoi		=3D gic_eoi_irq,
+	.irq_set_type		=3D gic_set_type,
+	.irq_retrigger          =3D gic_retrigger,
+	.irq_set_affinity	=3D gic_set_affinity,
+	.ipi_send_mask		=3D gic_ipi_send_mask,
+	.irq_get_irqchip_state	=3D gic_irq_get_irqchip_state,
+	.irq_set_irqchip_state	=3D gic_irq_set_irqchip_state,
+	.irq_print_chip		=3D gic_irq_print_chip,
+	.flags			=3D IRQCHIP_SET_TYPE_MASKED |
+				  IRQCHIP_SKIP_SET_WAKE |
+				  IRQCHIP_MASK_ON_SUSPEND,
+};
+
+static const struct irq_chip gic_chip_mode1 =3D {
+	.name			=3D "GICv2",
+	.irq_mask		=3D gic_eoimode1_mask_irq,
+	.irq_unmask		=3D gic_unmask_irq,
+	.irq_eoi		=3D gic_eoimode1_eoi_irq,
+	.irq_set_type		=3D gic_set_type,
+	.irq_retrigger          =3D gic_retrigger,
+	.irq_set_affinity	=3D gic_set_affinity,
+	.ipi_send_mask		=3D gic_ipi_send_mask,
+	.irq_get_irqchip_state	=3D gic_irq_get_irqchip_state,
+	.irq_set_irqchip_state	=3D gic_irq_set_irqchip_state,
+	.irq_set_vcpu_affinity	=3D gic_irq_set_vcpu_affinity,
+	.flags			=3D IRQCHIP_SET_TYPE_MASKED |
+				  IRQCHIP_SKIP_SET_WAKE |
+				  IRQCHIP_MASK_ON_SUSPEND,
+};
+
 #ifdef CONFIG_BL_SWITCHER
 /*
  * gic_send_sgi - send a SGI directly to given CPU interface number
@@ -1024,15 +1058,19 @@ static int gic_irq_domain_map(struct irq_domain *d, u=
nsigned int irq,
 {
 	struct gic_chip_data *gic =3D d->host_data;
 	struct irq_data *irqd =3D irq_desc_get_irq_data(irq_to_desc(irq));
+	const struct irq_chip *chip;
+
+	chip =3D (static_branch_likely(&supports_deactivate_key) &&
+		gic =3D=3D &gic_data[0]) ? &gic_chip_mode1 : &gic_chip;
=20
 	switch (hw) {
 	case 0 ... 31:
 		irq_set_percpu_devid(irq);
-		irq_domain_set_info(d, irq, hw, &gic->chip, d->host_data,
+		irq_domain_set_info(d, irq, hw, chip, d->host_data,
 				    handle_percpu_devid_irq, NULL, NULL);
 		break;
 	default:
-		irq_domain_set_info(d, irq, hw, &gic->chip, d->host_data,
+		irq_domain_set_info(d, irq, hw, chip, d->host_data,
 				    handle_fasteoi_irq, NULL, NULL);
 		irq_set_probe(irq);
 		irqd_set_single_target(irqd);
@@ -1127,26 +1165,6 @@ static const struct irq_domain_ops gic_irq_domain_ops =
=3D {
 	.unmap =3D gic_irq_domain_unmap,
 };
=20
-static void gic_init_chip(struct gic_chip_data *gic, struct device *dev,
-			  const char *name, bool use_eoimode1)
-{
-	/* Initialize irq_chip */
-	gic->chip =3D gic_chip;
-	gic->chip.name =3D name;
-	gic->chip.parent_device =3D dev;
-
-	if (use_eoimode1) {
-		gic->chip.irq_mask =3D gic_eoimode1_mask_irq;
-		gic->chip.irq_eoi =3D gic_eoimode1_eoi_irq;
-		gic->chip.irq_set_vcpu_affinity =3D gic_irq_set_vcpu_affinity;
-	}
-
-	if (gic =3D=3D &gic_data[0]) {
-		gic->chip.irq_set_affinity =3D gic_set_affinity;
-		gic->chip.ipi_send_mask =3D gic_ipi_send_mask;
-	}
-}
-
 static int gic_init_bases(struct gic_chip_data *gic,
 			  struct fwnode_handle *handle)
 {
@@ -1246,7 +1264,6 @@ static int gic_init_bases(struct gic_chip_data *gic,
 static int __init __gic_init_bases(struct gic_chip_data *gic,
 				   struct fwnode_handle *handle)
 {
-	char *name;
 	int i, ret;
=20
 	if (WARN_ON(!gic || gic->domain))
@@ -1266,18 +1283,8 @@ static int __init __gic_init_bases(struct gic_chip_dat=
a *gic,
 			pr_info("GIC: Using split EOI/Deactivate mode\n");
 	}
=20
-	if (static_branch_likely(&supports_deactivate_key) && gic =3D=3D &gic_data[=
0]) {
-		name =3D kasprintf(GFP_KERNEL, "GICv2");
-		gic_init_chip(gic, NULL, name, true);
-	} else {
-		name =3D kasprintf(GFP_KERNEL, "GIC-%d", (int)(gic-&gic_data[0]));
-		gic_init_chip(gic, NULL, name, false);
-	}
-
 	ret =3D gic_init_bases(gic, handle);
-	if (ret)
-		kfree(name);
-	else if (gic =3D=3D &gic_data[0])
+	if (gic =3D=3D &gic_data[0])
 		gic_smp_init();
=20
 	return ret;
@@ -1460,8 +1467,6 @@ int gic_of_init_child(struct device *dev, struct gic_ch=
ip_data **gic, int irq)
 	if (!*gic)
 		return -ENOMEM;
=20
-	gic_init_chip(*gic, dev, dev->of_node->name, false);
-
 	ret =3D gic_of_setup(*gic, dev->of_node);
 	if (ret)
 		return ret;
@@ -1472,6 +1477,7 @@ int gic_of_init_child(struct device *dev, struct gic_ch=
ip_data **gic, int irq)
 		return ret;
 	}
=20
+	irq_domain_set_pm_device((*gic)->domain, dev);
 	irq_set_chained_handler_and_data(irq, gic_handle_cascade_irq, *gic);
=20
 	return 0;
diff --git a/drivers/irqchip/irq-imx-intmux.c b/drivers/irqchip/irq-imx-intmu=
x.c
index e86ff743e98c..80aaea82468a 100644
--- a/drivers/irqchip/irq-imx-intmux.c
+++ b/drivers/irqchip/irq-imx-intmux.c
@@ -61,7 +61,6 @@
 #define CHAN_MAX_NUM		0x8
=20
 struct intmux_irqchip_data {
-	struct irq_chip		chip;
 	u32			saved_reg;
 	int			chanidx;
 	int			irq;
@@ -114,7 +113,7 @@ static void imx_intmux_irq_unmask(struct irq_data *d)
 	raw_spin_unlock_irqrestore(&data->lock, flags);
 }
=20
-static struct irq_chip imx_intmux_irq_chip =3D {
+static struct irq_chip imx_intmux_irq_chip __ro_after_init =3D {
 	.name		=3D "intmux",
 	.irq_mask	=3D imx_intmux_irq_mask,
 	.irq_unmask	=3D imx_intmux_irq_unmask,
@@ -126,7 +125,7 @@ static int imx_intmux_irq_map(struct irq_domain *h, unsig=
ned int irq,
 	struct intmux_irqchip_data *data =3D h->host_data;
=20
 	irq_set_chip_data(irq, data);
-	irq_set_chip_and_handler(irq, &data->chip, handle_level_irq);
+	irq_set_chip_and_handler(irq, &imx_intmux_irq_chip, handle_level_irq);
=20
 	return 0;
 }
@@ -241,8 +240,6 @@ static int imx_intmux_probe(struct platform_device *pdev)
 	}
=20
 	for (i =3D 0; i < channum; i++) {
-		data->irqchip_data[i].chip =3D imx_intmux_irq_chip;
-		data->irqchip_data[i].chip.parent_device =3D &pdev->dev;
 		data->irqchip_data[i].chanidx =3D i;
=20
 		data->irqchip_data[i].irq =3D irq_of_parse_and_map(np, i);
@@ -260,6 +257,7 @@ static int imx_intmux_probe(struct platform_device *pdev)
 			goto out;
 		}
 		data->irqchip_data[i].domain =3D domain;
+		irq_domain_set_pm_device(domain, &pdev->dev);
=20
 		/* disable all interrupt sources of this channel firstly */
 		writel_relaxed(0, data->regs + CHANIER(i));
diff --git a/drivers/irqchip/irq-lpc32xx.c b/drivers/irqchip/irq-lpc32xx.c
index a29357f39450..4d70a857133f 100644
--- a/drivers/irqchip/irq-lpc32xx.c
+++ b/drivers/irqchip/irq-lpc32xx.c
@@ -11,6 +11,7 @@
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
+#include <linux/seq_file.h>
 #include <linux/slab.h>
 #include <asm/exception.h>
=20
@@ -25,8 +26,8 @@
=20
 struct lpc32xx_irq_chip {
 	void __iomem *base;
+	phys_addr_t addr;
 	struct irq_domain *domain;
-	struct irq_chip chip;
 };
=20
 static struct lpc32xx_irq_chip *lpc32xx_mic_irqc;
@@ -118,6 +119,24 @@ static int lpc32xx_irq_set_type(struct irq_data *d, unsi=
gned int type)
 	return 0;
 }
=20
+static void lpc32xx_irq_print_chip(struct irq_data *d, struct seq_file *p)
+{
+	struct lpc32xx_irq_chip *ic =3D irq_data_get_irq_chip_data(d);
+
+	if (ic =3D=3D lpc32xx_mic_irqc)
+		seq_printf(p, "%08x.mic", ic->addr);
+	else
+		seq_printf(p, "%08x.sic", ic->addr);
+}
+
+static const struct irq_chip lpc32xx_chip =3D {
+	.irq_ack	=3D lpc32xx_irq_ack,
+	.irq_mask	=3D lpc32xx_irq_mask,
+	.irq_unmask	=3D lpc32xx_irq_unmask,
+	.irq_set_type	=3D lpc32xx_irq_set_type,
+	.irq_print_chip	=3D lpc32xx_irq_print_chip,
+};
+
 static void __exception_irq_entry lpc32xx_handle_irq(struct pt_regs *regs)
 {
 	struct lpc32xx_irq_chip *ic =3D lpc32xx_mic_irqc;
@@ -153,7 +172,7 @@ static int lpc32xx_irq_domain_map(struct irq_domain *id, =
unsigned int virq,
 	struct lpc32xx_irq_chip *ic =3D id->host_data;
=20
 	irq_set_chip_data(virq, ic);
-	irq_set_chip_and_handler(virq, &ic->chip, handle_level_irq);
+	irq_set_chip_and_handler(virq, &lpc32xx_chip, handle_level_irq);
 	irq_set_status_flags(virq, IRQ_LEVEL);
 	irq_set_noprobe(virq);
=20
@@ -183,6 +202,7 @@ static int __init lpc32xx_of_ic_init(struct device_node *=
node,
 	if (!irqc)
 		return -ENOMEM;
=20
+	irqc->addr =3D addr;
 	irqc->base =3D of_iomap(node, 0);
 	if (!irqc->base) {
 		pr_err("%pOF: unable to map registers\n", node);
@@ -190,21 +210,11 @@ static int __init lpc32xx_of_ic_init(struct device_node=
 *node,
 		return -EINVAL;
 	}
=20
-	irqc->chip.irq_ack =3D lpc32xx_irq_ack;
-	irqc->chip.irq_mask =3D lpc32xx_irq_mask;
-	irqc->chip.irq_unmask =3D lpc32xx_irq_unmask;
-	irqc->chip.irq_set_type =3D lpc32xx_irq_set_type;
-	if (is_mic)
-		irqc->chip.name =3D kasprintf(GFP_KERNEL, "%08x.mic", addr);
-	else
-		irqc->chip.name =3D kasprintf(GFP_KERNEL, "%08x.sic", addr);
-
 	irqc->domain =3D irq_domain_add_linear(node, NR_LPC32XX_IC_IRQS,
 					     &lpc32xx_irq_domain_ops, irqc);
 	if (!irqc->domain) {
 		pr_err("unable to add irq domain\n");
 		iounmap(irqc->base);
-		kfree(irqc->chip.name);
 		kfree(irqc);
 		return -ENODEV;
 	}
diff --git a/drivers/irqchip/irq-meson-gpio.c b/drivers/irqchip/irq-meson-gpi=
o.c
index d90ff0b92480..2aaa9aad3e87 100644
--- a/drivers/irqchip/irq-meson-gpio.c
+++ b/drivers/irqchip/irq-meson-gpio.c
@@ -16,7 +16,7 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
=20
-#define NUM_CHANNEL 8
+#define MAX_NUM_CHANNEL 64
 #define MAX_INPUT_MUX 256
=20
 #define REG_EDGE_POL	0x00
@@ -26,6 +26,8 @@
=20
 /* use for A1 like chips */
 #define REG_PIN_A1_SEL	0x04
+/* Used for s4 chips */
+#define REG_EDGE_POL_S4	0x1c
=20
 /*
  * Note: The S905X3 datasheet reports that BOTH_EDGE is controlled by
@@ -51,15 +53,22 @@ static void meson_a1_gpio_irq_sel_pin(struct meson_gpio_i=
rq_controller *ctl,
 				      unsigned int channel,
 				      unsigned long hwirq);
 static void meson_a1_gpio_irq_init(struct meson_gpio_irq_controller *ctl);
+static int meson8_gpio_irq_set_type(struct meson_gpio_irq_controller *ctl,
+				    unsigned int type, u32 *channel_hwirq);
+static int meson_s4_gpio_irq_set_type(struct meson_gpio_irq_controller *ctl,
+				      unsigned int type, u32 *channel_hwirq);
=20
 struct irq_ctl_ops {
 	void (*gpio_irq_sel_pin)(struct meson_gpio_irq_controller *ctl,
 				 unsigned int channel, unsigned long hwirq);
 	void (*gpio_irq_init)(struct meson_gpio_irq_controller *ctl);
+	int (*gpio_irq_set_type)(struct meson_gpio_irq_controller *ctl,
+				 unsigned int type, u32 *channel_hwirq);
 };
=20
 struct meson_gpio_irq_params {
 	unsigned int nr_hwirq;
+	unsigned int nr_channels;
 	bool support_edge_both;
 	unsigned int edge_both_offset;
 	unsigned int edge_single_offset;
@@ -68,28 +77,44 @@ struct meson_gpio_irq_params {
 	struct irq_ctl_ops ops;
 };
=20
-#define INIT_MESON_COMMON(irqs, init, sel)			\
+#define INIT_MESON_COMMON(irqs, init, sel, type)		\
 	.nr_hwirq =3D irqs,					\
 	.ops =3D {						\
 		.gpio_irq_init =3D init,				\
 		.gpio_irq_sel_pin =3D sel,			\
+		.gpio_irq_set_type =3D type,			\
 	},
=20
 #define INIT_MESON8_COMMON_DATA(irqs)				\
 	INIT_MESON_COMMON(irqs, meson_gpio_irq_init_dummy,	\
-			  meson8_gpio_irq_sel_pin)		\
+			  meson8_gpio_irq_sel_pin,		\
+			  meson8_gpio_irq_set_type)		\
 	.edge_single_offset =3D 0,				\
 	.pol_low_offset =3D 16,					\
 	.pin_sel_mask =3D 0xff,					\
+	.nr_channels =3D 8,					\
=20
 #define INIT_MESON_A1_COMMON_DATA(irqs)				\
 	INIT_MESON_COMMON(irqs, meson_a1_gpio_irq_init,		\
-			  meson_a1_gpio_irq_sel_pin)		\
+			  meson_a1_gpio_irq_sel_pin,		\
+			  meson8_gpio_irq_set_type)		\
 	.support_edge_both =3D true,				\
 	.edge_both_offset =3D 16,					\
 	.edge_single_offset =3D 8,				\
 	.pol_low_offset =3D 0,					\
 	.pin_sel_mask =3D 0x7f,					\
+	.nr_channels =3D 8,					\
+
+#define INIT_MESON_S4_COMMON_DATA(irqs)				\
+	INIT_MESON_COMMON(irqs, meson_a1_gpio_irq_init,		\
+			  meson_a1_gpio_irq_sel_pin,		\
+			  meson_s4_gpio_irq_set_type)		\
+	.support_edge_both =3D true,				\
+	.edge_both_offset =3D 0,					\
+	.edge_single_offset =3D 12,				\
+	.pol_low_offset =3D 0,					\
+	.pin_sel_mask =3D 0xff,					\
+	.nr_channels =3D 12,					\
=20
 static const struct meson_gpio_irq_params meson8_params =3D {
 	INIT_MESON8_COMMON_DATA(134)
@@ -121,6 +146,10 @@ static const struct meson_gpio_irq_params a1_params =3D {
 	INIT_MESON_A1_COMMON_DATA(62)
 };
=20
+static const struct meson_gpio_irq_params s4_params =3D {
+	INIT_MESON_S4_COMMON_DATA(82)
+};
+
 static const struct of_device_id meson_irq_gpio_matches[] =3D {
 	{ .compatible =3D "amlogic,meson8-gpio-intc", .data =3D &meson8_params },
 	{ .compatible =3D "amlogic,meson8b-gpio-intc", .data =3D &meson8b_params },
@@ -130,14 +159,15 @@ static const struct of_device_id meson_irq_gpio_matches=
[] =3D {
 	{ .compatible =3D "amlogic,meson-g12a-gpio-intc", .data =3D &axg_params },
 	{ .compatible =3D "amlogic,meson-sm1-gpio-intc", .data =3D &sm1_params },
 	{ .compatible =3D "amlogic,meson-a1-gpio-intc", .data =3D &a1_params },
+	{ .compatible =3D "amlogic,meson-s4-gpio-intc", .data =3D &s4_params },
 	{ }
 };
=20
 struct meson_gpio_irq_controller {
 	const struct meson_gpio_irq_params *params;
 	void __iomem *base;
-	u32 channel_irqs[NUM_CHANNEL];
-	DECLARE_BITMAP(channel_map, NUM_CHANNEL);
+	u32 channel_irqs[MAX_NUM_CHANNEL];
+	DECLARE_BITMAP(channel_map, MAX_NUM_CHANNEL);
 	spinlock_t lock;
 };
=20
@@ -207,8 +237,8 @@ meson_gpio_irq_request_channel(struct meson_gpio_irq_cont=
roller *ctl,
 	spin_lock_irqsave(&ctl->lock, flags);
=20
 	/* Find a free channel */
-	idx =3D find_first_zero_bit(ctl->channel_map, NUM_CHANNEL);
-	if (idx >=3D NUM_CHANNEL) {
+	idx =3D find_first_zero_bit(ctl->channel_map, ctl->params->nr_channels);
+	if (idx >=3D ctl->params->nr_channels) {
 		spin_unlock_irqrestore(&ctl->lock, flags);
 		pr_err("No channel available\n");
 		return -ENOSPC;
@@ -256,9 +286,8 @@ meson_gpio_irq_release_channel(struct meson_gpio_irq_cont=
roller *ctl,
 	clear_bit(idx, ctl->channel_map);
 }
=20
-static int meson_gpio_irq_type_setup(struct meson_gpio_irq_controller *ctl,
-				     unsigned int type,
-				     u32 *channel_hwirq)
+static int meson8_gpio_irq_set_type(struct meson_gpio_irq_controller *ctl,
+				    unsigned int type, u32 *channel_hwirq)
 {
 	u32 val =3D 0;
 	unsigned int idx;
@@ -299,6 +328,51 @@ static int meson_gpio_irq_type_setup(struct meson_gpio_i=
rq_controller *ctl,
 	return 0;
 }
=20
+/*
+ * gpio irq relative registers for s4
+ * -PADCTRL_GPIO_IRQ_CTRL0
+ * bit[31]:    enable/disable all the irq lines
+ * bit[12-23]: single edge trigger
+ * bit[0-11]:  polarity trigger
+ *
+ * -PADCTRL_GPIO_IRQ_CTRL[X]
+ * bit[0-16]: 7 bits to choose gpio source for irq line 2*[X] - 2
+ * bit[16-22]:7 bits to choose gpio source for irq line 2*[X] - 1
+ * where X =3D 1-6
+ *
+ * -PADCTRL_GPIO_IRQ_CTRL[7]
+ * bit[0-11]: both edge trigger
+ */
+static int meson_s4_gpio_irq_set_type(struct meson_gpio_irq_controller *ctl,
+				      unsigned int type, u32 *channel_hwirq)
+{
+	u32 val =3D 0;
+	unsigned int idx;
+
+	idx =3D meson_gpio_irq_get_channel_idx(ctl, channel_hwirq);
+
+	type &=3D IRQ_TYPE_SENSE_MASK;
+
+	meson_gpio_irq_update_bits(ctl, REG_EDGE_POL_S4, BIT(idx), 0);
+
+	if (type =3D=3D IRQ_TYPE_EDGE_BOTH) {
+		val |=3D BIT(ctl->params->edge_both_offset + idx);
+		meson_gpio_irq_update_bits(ctl, REG_EDGE_POL_S4,
+					   BIT(ctl->params->edge_both_offset + idx), val);
+		return 0;
+	}
+
+	if (type & (IRQ_TYPE_LEVEL_LOW | IRQ_TYPE_EDGE_FALLING))
+		val |=3D BIT(ctl->params->pol_low_offset + idx);
+
+	if (type & (IRQ_TYPE_EDGE_RISING | IRQ_TYPE_EDGE_FALLING))
+		val |=3D BIT(ctl->params->edge_single_offset + idx);
+
+	meson_gpio_irq_update_bits(ctl, REG_EDGE_POL,
+				   BIT(idx) | BIT(12 + idx), val);
+	return 0;
+};
+
 static unsigned int meson_gpio_irq_type_output(unsigned int type)
 {
 	unsigned int sense =3D type & IRQ_TYPE_SENSE_MASK;
@@ -323,7 +397,7 @@ static int meson_gpio_irq_set_type(struct irq_data *data,=
 unsigned int type)
 	u32 *channel_hwirq =3D irq_data_get_irq_chip_data(data);
 	int ret;
=20
-	ret =3D meson_gpio_irq_type_setup(ctl, type, channel_hwirq);
+	ret =3D ctl->params->ops.gpio_irq_set_type(ctl, type, channel_hwirq);
 	if (ret)
 		return ret;
=20
@@ -450,10 +524,10 @@ static int meson_gpio_irq_parse_dt(struct device_node *=
node, struct meson_gpio_i
 	ret =3D of_property_read_variable_u32_array(node,
 						  "amlogic,channel-interrupts",
 						  ctl->channel_irqs,
-						  NUM_CHANNEL,
-						  NUM_CHANNEL);
+						  ctl->params->nr_channels,
+						  ctl->params->nr_channels);
 	if (ret < 0) {
-		pr_err("can't get %d channel interrupts\n", NUM_CHANNEL);
+		pr_err("can't get %d channel interrupts\n", ctl->params->nr_channels);
 		return ret;
 	}
=20
@@ -507,7 +581,7 @@ static int meson_gpio_irq_of_init(struct device_node *nod=
e, struct device_node *
 	}
=20
 	pr_info("%d to %d gpio interrupt mux initialized\n",
-		ctl->params->nr_hwirq, NUM_CHANNEL);
+		ctl->params->nr_hwirq, ctl->params->nr_channels);
=20
 	return 0;
=20
diff --git a/drivers/irqchip/irq-mvebu-pic.c b/drivers/irqchip/irq-mvebu-pic.c
index 870f9866b8da..ef3d3646ccc2 100644
--- a/drivers/irqchip/irq-mvebu-pic.c
+++ b/drivers/irqchip/irq-mvebu-pic.c
@@ -18,6 +18,7 @@
 #include <linux/module.h>
 #include <linux/of_irq.h>
 #include <linux/platform_device.h>
+#include <linux/seq_file.h>
=20
 #define PIC_CAUSE	       0x0
 #define PIC_MASK	       0x4
@@ -29,7 +30,7 @@ struct mvebu_pic {
 	void __iomem *base;
 	u32 parent_irq;
 	struct irq_domain *domain;
-	struct irq_chip irq_chip;
+	struct platform_device *pdev;
 };
=20
 static void mvebu_pic_reset(struct mvebu_pic *pic)
@@ -66,6 +67,20 @@ static void mvebu_pic_unmask_irq(struct irq_data *d)
 	writel(reg, pic->base + PIC_MASK);
 }
=20
+static void mvebu_pic_print_chip(struct irq_data *d, struct seq_file *p)
+{
+	struct mvebu_pic *pic =3D irq_data_get_irq_chip_data(d);
+
+	seq_printf(p, dev_name(&pic->pdev->dev));
+}
+
+static const struct irq_chip mvebu_pic_chip =3D {
+	.irq_mask	=3D mvebu_pic_mask_irq,
+	.irq_unmask	=3D mvebu_pic_unmask_irq,
+	.irq_eoi	=3D mvebu_pic_eoi_irq,
+	.irq_print_chip	=3D mvebu_pic_print_chip,
+};
+
 static int mvebu_pic_irq_map(struct irq_domain *domain, unsigned int virq,
 			     irq_hw_number_t hwirq)
 {
@@ -73,8 +88,7 @@ static int mvebu_pic_irq_map(struct irq_domain *domain, uns=
igned int virq,
=20
 	irq_set_percpu_devid(virq);
 	irq_set_chip_data(virq, pic);
-	irq_set_chip_and_handler(virq, &pic->irq_chip,
-				 handle_percpu_devid_irq);
+	irq_set_chip_and_handler(virq, &mvebu_pic_chip, handle_percpu_devid_irq);
 	irq_set_status_flags(virq, IRQ_LEVEL);
 	irq_set_probe(virq);
=20
@@ -120,22 +134,16 @@ static int mvebu_pic_probe(struct platform_device *pdev)
 {
 	struct device_node *node =3D pdev->dev.of_node;
 	struct mvebu_pic *pic;
-	struct irq_chip *irq_chip;
=20
 	pic =3D devm_kzalloc(&pdev->dev, sizeof(struct mvebu_pic), GFP_KERNEL);
 	if (!pic)
 		return -ENOMEM;
=20
+	pic->pdev =3D pdev;
 	pic->base =3D devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(pic->base))
 		return PTR_ERR(pic->base);
=20
-	irq_chip =3D &pic->irq_chip;
-	irq_chip->name =3D dev_name(&pdev->dev);
-	irq_chip->irq_mask =3D mvebu_pic_mask_irq;
-	irq_chip->irq_unmask =3D mvebu_pic_unmask_irq;
-	irq_chip->irq_eoi =3D mvebu_pic_eoi_irq;
-
 	pic->parent_irq =3D irq_of_parse_and_map(node, 0);
 	if (pic->parent_irq <=3D 0) {
 		dev_err(&pdev->dev, "Failed to parse parent interrupt\n");
diff --git a/drivers/irqchip/irq-nvic.c b/drivers/irqchip/irq-nvic.c
index ba4759b3e269..94230306e0ee 100644
--- a/drivers/irqchip/irq-nvic.c
+++ b/drivers/irqchip/irq-nvic.c
@@ -107,6 +107,7 @@ static int __init nvic_of_init(struct device_node *node,
=20
 	if (!nvic_irq_domain) {
 		pr_warn("Failed to allocate irq domain\n");
+		iounmap(nvic_base);
 		return -ENOMEM;
 	}
=20
@@ -116,6 +117,7 @@ static int __init nvic_of_init(struct device_node *node,
 	if (ret) {
 		pr_warn("Failed to allocate irq chips\n");
 		irq_domain_remove(nvic_irq_domain);
+		iounmap(nvic_base);
 		return ret;
 	}
=20
diff --git a/drivers/irqchip/irq-qcom-mpm.c b/drivers/irqchip/irq-qcom-mpm.c
new file mode 100644
index 000000000000..eea5a753618c
--- /dev/null
+++ b/drivers/irqchip/irq-qcom-mpm.c
@@ -0,0 +1,461 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2021, Linaro Limited
+ * Copyright (c) 2010-2020, The Linux Foundation. All rights reserved.
+ */
+
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/irqchip.h>
+#include <linux/irqdomain.h>
+#include <linux/mailbox_client.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/pm_domain.h>
+#include <linux/slab.h>
+#include <linux/soc/qcom/irq.h>
+#include <linux/spinlock.h>
+
+/*
+ * This is the driver for Qualcomm MPM (MSM Power Manager) interrupt control=
ler,
+ * which is commonly found on Qualcomm SoCs built on the RPM architecture.
+ * Sitting in always-on domain, MPM monitors the wakeup interrupts when SoC =
is
+ * asleep, and wakes up the AP when one of those interrupts occurs.  This dr=
iver
+ * doesn't directly access physical MPM registers though.  Instead, the acce=
ss
+ * is bridged via a piece of internal memory (SRAM) that is accessible to bo=
th
+ * AP and RPM.  This piece of memory is called 'vMPM' in the driver.
+ *
+ * When SoC is awake, the vMPM is owned by AP and the register setup by this
+ * driver all happens on vMPM.  When AP is about to get power collapsed, the
+ * driver sends a mailbox notification to RPM, which will take over the vMPM
+ * ownership and dump vMPM into physical MPM registers.  On wakeup, AP is wo=
ken
+ * up by a MPM pin/interrupt, and RPM will copy STATUS registers into vMPM.
+ * Then AP start owning vMPM again.
+ *
+ * vMPM register map:
+ *
+ *    31                              0
+ *    +--------------------------------+
+ *    |            TIMER0              | 0x00
+ *    +--------------------------------+
+ *    |            TIMER1              | 0x04
+ *    +--------------------------------+
+ *    |            ENABLE0             | 0x08
+ *    +--------------------------------+
+ *    |              ...               | ...
+ *    +--------------------------------+
+ *    |            ENABLEn             |
+ *    +--------------------------------+
+ *    |          FALLING_EDGE0         |
+ *    +--------------------------------+
+ *    |              ...               |
+ *    +--------------------------------+
+ *    |            STATUSn             |
+ *    +--------------------------------+
+ *
+ *    n =3D DIV_ROUND_UP(pin_cnt, 32)
+ *
+ */
+
+#define MPM_REG_ENABLE		0
+#define MPM_REG_FALLING_EDGE	1
+#define MPM_REG_RISING_EDGE	2
+#define MPM_REG_POLARITY	3
+#define MPM_REG_STATUS		4
+
+/* MPM pin map to GIC hwirq */
+struct mpm_gic_map {
+	int pin;
+	irq_hw_number_t hwirq;
+};
+
+struct qcom_mpm_priv {
+	void __iomem *base;
+	raw_spinlock_t lock;
+	struct mbox_client mbox_client;
+	struct mbox_chan *mbox_chan;
+	struct mpm_gic_map *maps;
+	unsigned int map_cnt;
+	unsigned int reg_stride;
+	struct irq_domain *domain;
+	struct generic_pm_domain genpd;
+};
+
+static u32 qcom_mpm_read(struct qcom_mpm_priv *priv, unsigned int reg,
+			 unsigned int index)
+{
+	unsigned int offset =3D (reg * priv->reg_stride + index + 2) * 4;
+
+	return readl_relaxed(priv->base + offset);
+}
+
+static void qcom_mpm_write(struct qcom_mpm_priv *priv, unsigned int reg,
+			   unsigned int index, u32 val)
+{
+	unsigned int offset =3D (reg * priv->reg_stride + index + 2) * 4;
+
+	writel_relaxed(val, priv->base + offset);
+
+	/* Ensure the write is completed */
+	wmb();
+}
+
+static void qcom_mpm_enable_irq(struct irq_data *d, bool en)
+{
+	struct qcom_mpm_priv *priv =3D d->chip_data;
+	int pin =3D d->hwirq;
+	unsigned int index =3D pin / 32;
+	unsigned int shift =3D pin % 32;
+	unsigned long flags, val;
+
+	raw_spin_lock_irqsave(&priv->lock, flags);
+
+	val =3D qcom_mpm_read(priv, MPM_REG_ENABLE, index);
+	__assign_bit(shift, &val, en);
+	qcom_mpm_write(priv, MPM_REG_ENABLE, index, val);
+
+	raw_spin_unlock_irqrestore(&priv->lock, flags);
+}
+
+static void qcom_mpm_mask(struct irq_data *d)
+{
+	qcom_mpm_enable_irq(d, false);
+
+	if (d->parent_data)
+		irq_chip_mask_parent(d);
+}
+
+static void qcom_mpm_unmask(struct irq_data *d)
+{
+	qcom_mpm_enable_irq(d, true);
+
+	if (d->parent_data)
+		irq_chip_unmask_parent(d);
+}
+
+static void mpm_set_type(struct qcom_mpm_priv *priv, bool set, unsigned int =
reg,
+			 unsigned int index, unsigned int shift)
+{
+	unsigned long flags, val;
+
+	raw_spin_lock_irqsave(&priv->lock, flags);
+
+	val =3D qcom_mpm_read(priv, reg, index);
+	__assign_bit(shift, &val, set);
+	qcom_mpm_write(priv, reg, index, val);
+
+	raw_spin_unlock_irqrestore(&priv->lock, flags);
+}
+
+static int qcom_mpm_set_type(struct irq_data *d, unsigned int type)
+{
+	struct qcom_mpm_priv *priv =3D d->chip_data;
+	int pin =3D d->hwirq;
+	unsigned int index =3D pin / 32;
+	unsigned int shift =3D pin % 32;
+
+	if (type & IRQ_TYPE_EDGE_RISING)
+		mpm_set_type(priv, true, MPM_REG_RISING_EDGE, index, shift);
+	else
+		mpm_set_type(priv, false, MPM_REG_RISING_EDGE, index, shift);
+
+	if (type & IRQ_TYPE_EDGE_FALLING)
+		mpm_set_type(priv, true, MPM_REG_FALLING_EDGE, index, shift);
+	else
+		mpm_set_type(priv, false, MPM_REG_FALLING_EDGE, index, shift);
+
+	if (type & IRQ_TYPE_LEVEL_HIGH)
+		mpm_set_type(priv, true, MPM_REG_POLARITY, index, shift);
+	else
+		mpm_set_type(priv, false, MPM_REG_POLARITY, index, shift);
+
+	if (!d->parent_data)
+		return 0;
+
+	if (type & IRQ_TYPE_EDGE_BOTH)
+		type =3D IRQ_TYPE_EDGE_RISING;
+
+	if (type & IRQ_TYPE_LEVEL_MASK)
+		type =3D IRQ_TYPE_LEVEL_HIGH;
+
+	return irq_chip_set_type_parent(d, type);
+}
+
+static struct irq_chip qcom_mpm_chip =3D {
+	.name			=3D "mpm",
+	.irq_eoi		=3D irq_chip_eoi_parent,
+	.irq_mask		=3D qcom_mpm_mask,
+	.irq_unmask		=3D qcom_mpm_unmask,
+	.irq_retrigger		=3D irq_chip_retrigger_hierarchy,
+	.irq_set_type		=3D qcom_mpm_set_type,
+	.irq_set_affinity	=3D irq_chip_set_affinity_parent,
+	.flags			=3D IRQCHIP_MASK_ON_SUSPEND |
+				  IRQCHIP_SKIP_SET_WAKE,
+};
+
+static struct mpm_gic_map *get_mpm_gic_map(struct qcom_mpm_priv *priv, int p=
in)
+{
+	struct mpm_gic_map *maps =3D priv->maps;
+	int i;
+
+	for (i =3D 0; i < priv->map_cnt; i++) {
+		if (maps[i].pin =3D=3D pin)
+			return &maps[i];
+	}
+
+	return NULL;
+}
+
+static int qcom_mpm_alloc(struct irq_domain *domain, unsigned int virq,
+			  unsigned int nr_irqs, void *data)
+{
+	struct qcom_mpm_priv *priv =3D domain->host_data;
+	struct irq_fwspec *fwspec =3D data;
+	struct irq_fwspec parent_fwspec;
+	struct mpm_gic_map *map;
+	irq_hw_number_t pin;
+	unsigned int type;
+	int  ret;
+
+	ret =3D irq_domain_translate_twocell(domain, fwspec, &pin, &type);
+	if (ret)
+		return ret;
+
+	ret =3D irq_domain_set_hwirq_and_chip(domain, virq, pin,
+					    &qcom_mpm_chip, priv);
+	if (ret)
+		return ret;
+
+	map =3D get_mpm_gic_map(priv, pin);
+	if (map =3D=3D NULL)
+		return irq_domain_disconnect_hierarchy(domain->parent, virq);
+
+	if (type & IRQ_TYPE_EDGE_BOTH)
+		type =3D IRQ_TYPE_EDGE_RISING;
+
+	if (type & IRQ_TYPE_LEVEL_MASK)
+		type =3D IRQ_TYPE_LEVEL_HIGH;
+
+	parent_fwspec.fwnode =3D domain->parent->fwnode;
+	parent_fwspec.param_count =3D 3;
+	parent_fwspec.param[0] =3D 0;
+	parent_fwspec.param[1] =3D map->hwirq;
+	parent_fwspec.param[2] =3D type;
+
+	return irq_domain_alloc_irqs_parent(domain, virq, nr_irqs,
+					    &parent_fwspec);
+}
+
+static const struct irq_domain_ops qcom_mpm_ops =3D {
+	.alloc		=3D qcom_mpm_alloc,
+	.free		=3D irq_domain_free_irqs_common,
+	.translate	=3D irq_domain_translate_twocell,
+};
+
+/* Triggered by RPM when system resumes from deep sleep */
+static irqreturn_t qcom_mpm_handler(int irq, void *dev_id)
+{
+	struct qcom_mpm_priv *priv =3D dev_id;
+	unsigned long enable, pending;
+	irqreturn_t ret =3D IRQ_NONE;
+	unsigned long flags;
+	int i, j;
+
+	for (i =3D 0; i < priv->reg_stride; i++) {
+		raw_spin_lock_irqsave(&priv->lock, flags);
+		enable =3D qcom_mpm_read(priv, MPM_REG_ENABLE, i);
+		pending =3D qcom_mpm_read(priv, MPM_REG_STATUS, i);
+		pending &=3D enable;
+		raw_spin_unlock_irqrestore(&priv->lock, flags);
+
+		for_each_set_bit(j, &pending, 32) {
+			unsigned int pin =3D 32 * i + j;
+			struct irq_desc *desc =3D irq_resolve_mapping(priv->domain, pin);
+			struct irq_data *d =3D &desc->irq_data;
+
+			if (!irqd_is_level_type(d))
+				irq_set_irqchip_state(d->irq,
+						IRQCHIP_STATE_PENDING, true);
+			ret =3D IRQ_HANDLED;
+		}
+	}
+
+	return ret;
+}
+
+static int mpm_pd_power_off(struct generic_pm_domain *genpd)
+{
+	struct qcom_mpm_priv *priv =3D container_of(genpd, struct qcom_mpm_priv,
+						  genpd);
+	int i, ret;
+
+	for (i =3D 0; i < priv->reg_stride; i++)
+		qcom_mpm_write(priv, MPM_REG_STATUS, i, 0);
+
+	/* Notify RPM to write vMPM into HW */
+	ret =3D mbox_send_message(priv->mbox_chan, NULL);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static bool gic_hwirq_is_mapped(struct mpm_gic_map *maps, int cnt, u32 hwirq)
+{
+	int i;
+
+	for (i =3D 0; i < cnt; i++)
+		if (maps[i].hwirq =3D=3D hwirq)
+			return true;
+
+	return false;
+}
+
+static int qcom_mpm_init(struct device_node *np, struct device_node *parent)
+{
+	struct platform_device *pdev =3D of_find_device_by_node(np);
+	struct device *dev =3D &pdev->dev;
+	struct irq_domain *parent_domain;
+	struct generic_pm_domain *genpd;
+	struct qcom_mpm_priv *priv;
+	unsigned int pin_cnt;
+	int i, irq;
+	int ret;
+
+	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	ret =3D of_property_read_u32(np, "qcom,mpm-pin-count", &pin_cnt);
+	if (ret) {
+		dev_err(dev, "failed to read qcom,mpm-pin-count: %d\n", ret);
+		return ret;
+	}
+
+	priv->reg_stride =3D DIV_ROUND_UP(pin_cnt, 32);
+
+	ret =3D of_property_count_u32_elems(np, "qcom,mpm-pin-map");
+	if (ret < 0) {
+		dev_err(dev, "failed to read qcom,mpm-pin-map: %d\n", ret);
+		return ret;
+	}
+
+	if (ret % 2) {
+		dev_err(dev, "invalid qcom,mpm-pin-map\n");
+		return -EINVAL;
+	}
+
+	priv->map_cnt =3D ret / 2;
+	priv->maps =3D devm_kcalloc(dev, priv->map_cnt, sizeof(*priv->maps),
+				  GFP_KERNEL);
+	if (!priv->maps)
+		return -ENOMEM;
+
+	for (i =3D 0; i < priv->map_cnt; i++) {
+		u32 pin, hwirq;
+
+		of_property_read_u32_index(np, "qcom,mpm-pin-map", i * 2, &pin);
+		of_property_read_u32_index(np, "qcom,mpm-pin-map", i * 2 + 1, &hwirq);
+
+		if (gic_hwirq_is_mapped(priv->maps, i, hwirq)) {
+			dev_warn(dev, "failed to map pin %d as GIC hwirq %d is already mapped\n",
+				 pin, hwirq);
+			continue;
+		}
+
+		priv->maps[i].pin =3D pin;
+		priv->maps[i].hwirq =3D hwirq;
+	}
+
+	raw_spin_lock_init(&priv->lock);
+
+	priv->base =3D devm_platform_ioremap_resource(pdev, 0);
+	if (!priv->base)
+		return PTR_ERR(priv->base);
+
+	for (i =3D 0; i < priv->reg_stride; i++) {
+		qcom_mpm_write(priv, MPM_REG_ENABLE, i, 0);
+		qcom_mpm_write(priv, MPM_REG_FALLING_EDGE, i, 0);
+		qcom_mpm_write(priv, MPM_REG_RISING_EDGE, i, 0);
+		qcom_mpm_write(priv, MPM_REG_POLARITY, i, 0);
+		qcom_mpm_write(priv, MPM_REG_STATUS, i, 0);
+	}
+
+	irq =3D platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	genpd =3D &priv->genpd;
+	genpd->flags =3D GENPD_FLAG_IRQ_SAFE;
+	genpd->power_off =3D mpm_pd_power_off;
+
+	genpd->name =3D devm_kasprintf(dev, GFP_KERNEL, "%s", dev_name(dev));
+	if (!genpd->name)
+		return -ENOMEM;
+
+	ret =3D pm_genpd_init(genpd, NULL, false);
+	if (ret) {
+		dev_err(dev, "failed to init genpd: %d\n", ret);
+		return ret;
+	}
+
+	ret =3D of_genpd_add_provider_simple(np, genpd);
+	if (ret) {
+		dev_err(dev, "failed to add genpd provider: %d\n", ret);
+		goto remove_genpd;
+	}
+
+	priv->mbox_client.dev =3D dev;
+	priv->mbox_chan =3D mbox_request_channel(&priv->mbox_client, 0);
+	if (IS_ERR(priv->mbox_chan)) {
+		ret =3D PTR_ERR(priv->mbox_chan);
+		dev_err(dev, "failed to acquire IPC channel: %d\n", ret);
+		return ret;
+	}
+
+	parent_domain =3D irq_find_host(parent);
+	if (!parent_domain) {
+		dev_err(dev, "failed to find MPM parent domain\n");
+		ret =3D -ENXIO;
+		goto free_mbox;
+	}
+
+	priv->domain =3D irq_domain_create_hierarchy(parent_domain,
+				IRQ_DOMAIN_FLAG_QCOM_MPM_WAKEUP, pin_cnt,
+				of_node_to_fwnode(np), &qcom_mpm_ops, priv);
+	if (!priv->domain) {
+		dev_err(dev, "failed to create MPM domain\n");
+		ret =3D -ENOMEM;
+		goto free_mbox;
+	}
+
+	irq_domain_update_bus_token(priv->domain, DOMAIN_BUS_WAKEUP);
+
+	ret =3D devm_request_irq(dev, irq, qcom_mpm_handler, IRQF_NO_SUSPEND,
+			       "qcom_mpm", priv);
+	if (ret) {
+		dev_err(dev, "failed to request irq: %d\n", ret);
+		goto remove_domain;
+	}
+
+	return 0;
+
+remove_domain:
+	irq_domain_remove(priv->domain);
+free_mbox:
+	mbox_free_channel(priv->mbox_chan);
+remove_genpd:
+	pm_genpd_remove(genpd);
+	return ret;
+}
+
+IRQCHIP_PLATFORM_DRIVER_BEGIN(qcom_mpm)
+IRQCHIP_MATCH("qcom,mpm", qcom_mpm_init)
+IRQCHIP_PLATFORM_DRIVER_END(qcom_mpm)
+MODULE_DESCRIPTION("Qualcomm Technologies, Inc. MSM Power Manager");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/irqchip/irq-renesas-intc-irqpin.c b/drivers/irqchip/irq-=
renesas-intc-irqpin.c
index 37f9a4499fdb..e83756aca14e 100644
--- a/drivers/irqchip/irq-renesas-intc-irqpin.c
+++ b/drivers/irqchip/irq-renesas-intc-irqpin.c
@@ -508,7 +508,6 @@ static int intc_irqpin_probe(struct platform_device *pdev)
=20
 	irq_chip =3D &p->irq_chip;
 	irq_chip->name =3D "intc-irqpin";
-	irq_chip->parent_device =3D dev;
 	irq_chip->irq_mask =3D disable_fn;
 	irq_chip->irq_unmask =3D enable_fn;
 	irq_chip->irq_set_type =3D intc_irqpin_irq_set_type;
@@ -523,6 +522,8 @@ static int intc_irqpin_probe(struct platform_device *pdev)
 		goto err0;
 	}
=20
+	irq_domain_set_pm_device(p->irq_domain, dev);
+
 	if (p->shared_irqs) {
 		/* request one shared interrupt */
 		if (devm_request_irq(dev, p->irq[0].requested_irq,
diff --git a/drivers/irqchip/irq-renesas-irqc.c b/drivers/irqchip/irq-renesas=
-irqc.c
index 909325f88239..1ee5e9941f67 100644
--- a/drivers/irqchip/irq-renesas-irqc.c
+++ b/drivers/irqchip/irq-renesas-irqc.c
@@ -188,13 +188,14 @@ static int irqc_probe(struct platform_device *pdev)
 	p->gc->reg_base =3D p->cpu_int_base;
 	p->gc->chip_types[0].regs.enable =3D IRQC_EN_SET;
 	p->gc->chip_types[0].regs.disable =3D IRQC_EN_STS;
-	p->gc->chip_types[0].chip.parent_device =3D dev;
 	p->gc->chip_types[0].chip.irq_mask =3D irq_gc_mask_disable_reg;
 	p->gc->chip_types[0].chip.irq_unmask =3D irq_gc_unmask_enable_reg;
 	p->gc->chip_types[0].chip.irq_set_type	=3D irqc_irq_set_type;
 	p->gc->chip_types[0].chip.irq_set_wake	=3D irqc_irq_set_wake;
 	p->gc->chip_types[0].chip.flags	=3D IRQCHIP_MASK_ON_SUSPEND;
=20
+	irq_domain_set_pm_device(p->irq_domain, dev);
+
 	/* request interrupts one by one */
 	for (k =3D 0; k < p->number_of_irqs; k++) {
 		if (devm_request_irq(dev, p->irq[k].requested_irq,
diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-p=
lic.c
index 09cc98266d30..bb87e4c3b88e 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -44,8 +44,8 @@
  * Each hart context has a vector of interrupt enable bits associated with i=
t.
  * There's one bit for each interrupt source.
  */
-#define ENABLE_BASE			0x2000
-#define     ENABLE_PER_HART		0x80
+#define CONTEXT_ENABLE_BASE		0x2000
+#define     CONTEXT_ENABLE_SIZE		0x80
=20
 /*
  * Each hart context has a set of control registers associated with it.  Rig=
ht
@@ -53,7 +53,7 @@
  * take an interrupt, and a register to claim interrupts.
  */
 #define CONTEXT_BASE			0x200000
-#define     CONTEXT_PER_HART		0x1000
+#define     CONTEXT_SIZE		0x1000
 #define     CONTEXT_THRESHOLD		0x00
 #define     CONTEXT_CLAIM		0x04
=20
@@ -81,17 +81,21 @@ static int plic_parent_irq __ro_after_init;
 static bool plic_cpuhp_setup_done __ro_after_init;
 static DEFINE_PER_CPU(struct plic_handler, plic_handlers);
=20
-static inline void plic_toggle(struct plic_handler *handler,
-				int hwirq, int enable)
+static void __plic_toggle(void __iomem *enable_base, int hwirq, int enable)
 {
-	u32 __iomem *reg =3D handler->enable_base + (hwirq / 32) * sizeof(u32);
+	u32 __iomem *reg =3D enable_base + (hwirq / 32) * sizeof(u32);
 	u32 hwirq_mask =3D 1 << (hwirq % 32);
=20
-	raw_spin_lock(&handler->enable_lock);
 	if (enable)
 		writel(readl(reg) | hwirq_mask, reg);
 	else
 		writel(readl(reg) & ~hwirq_mask, reg);
+}
+
+static void plic_toggle(struct plic_handler *handler, int hwirq, int enable)
+{
+	raw_spin_lock(&handler->enable_lock);
+	__plic_toggle(handler->enable_base, hwirq, enable);
 	raw_spin_unlock(&handler->enable_lock);
 }
=20
@@ -324,8 +328,18 @@ static int __init plic_init(struct device_node *node,
 		 * Skip contexts other than external interrupts for our
 		 * privilege level.
 		 */
-		if (parent.args[0] !=3D RV_IRQ_EXT)
+		if (parent.args[0] !=3D RV_IRQ_EXT) {
+			/* Disable S-mode enable bits if running in M-mode. */
+			if (IS_ENABLED(CONFIG_RISCV_M_MODE)) {
+				void __iomem *enable_base =3D priv->regs +
+					CONTEXT_ENABLE_BASE +
+					i * CONTEXT_ENABLE_SIZE;
+
+				for (hwirq =3D 1; hwirq <=3D nr_irqs; hwirq++)
+					__plic_toggle(enable_base, hwirq, 0);
+			}
 			continue;
+		}
=20
 		hartid =3D riscv_of_parent_hartid(parent.np);
 		if (hartid < 0) {
@@ -361,11 +375,11 @@ static int __init plic_init(struct device_node *node,
=20
 		cpumask_set_cpu(cpu, &priv->lmask);
 		handler->present =3D true;
-		handler->hart_base =3D
-			priv->regs + CONTEXT_BASE + i * CONTEXT_PER_HART;
+		handler->hart_base =3D priv->regs + CONTEXT_BASE +
+			i * CONTEXT_SIZE;
 		raw_spin_lock_init(&handler->enable_lock);
-		handler->enable_base =3D
-			priv->regs + ENABLE_BASE + i * ENABLE_PER_HART;
+		handler->enable_base =3D priv->regs + CONTEXT_ENABLE_BASE +
+			i * CONTEXT_ENABLE_SIZE;
 		handler->priv =3D priv;
 done:
 		for (hwirq =3D 1; hwirq <=3D nr_irqs; hwirq++)
diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-ext=
i.c
index b7cb2da71888..9d18f47040eb 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -214,6 +214,48 @@ static const struct stm32_desc_irq stm32mp1_desc_irq[] =
=3D {
 	{ .exti =3D 73, .irq_parent =3D 129, .chip =3D &stm32_exti_h_chip },
 };
=20
+static const struct stm32_desc_irq stm32mp13_desc_irq[] =3D {
+	{ .exti =3D 0, .irq_parent =3D 6, .chip =3D &stm32_exti_h_chip },
+	{ .exti =3D 1, .irq_parent =3D 7, .chip =3D &stm32_exti_h_chip },
+	{ .exti =3D 2, .irq_parent =3D 8, .chip =3D &stm32_exti_h_chip },
+	{ .exti =3D 3, .irq_parent =3D 9, .chip =3D &stm32_exti_h_chip },
+	{ .exti =3D 4, .irq_parent =3D 10, .chip =3D &stm32_exti_h_chip },
+	{ .exti =3D 5, .irq_parent =3D 24, .chip =3D &stm32_exti_h_chip },
+	{ .exti =3D 6, .irq_parent =3D 65, .chip =3D &stm32_exti_h_chip },
+	{ .exti =3D 7, .irq_parent =3D 66, .chip =3D &stm32_exti_h_chip },
+	{ .exti =3D 8, .irq_parent =3D 67, .chip =3D &stm32_exti_h_chip },
+	{ .exti =3D 9, .irq_parent =3D 68, .chip =3D &stm32_exti_h_chip },
+	{ .exti =3D 10, .irq_parent =3D 41, .chip =3D &stm32_exti_h_chip },
+	{ .exti =3D 11, .irq_parent =3D 43, .chip =3D &stm32_exti_h_chip },
+	{ .exti =3D 12, .irq_parent =3D 77, .chip =3D &stm32_exti_h_chip },
+	{ .exti =3D 13, .irq_parent =3D 78, .chip =3D &stm32_exti_h_chip },
+	{ .exti =3D 14, .irq_parent =3D 106, .chip =3D &stm32_exti_h_chip },
+	{ .exti =3D 15, .irq_parent =3D 109, .chip =3D &stm32_exti_h_chip },
+	{ .exti =3D 16, .irq_parent =3D 1, .chip =3D &stm32_exti_h_chip },
+	{ .exti =3D 19, .irq_parent =3D 3, .chip =3D &stm32_exti_h_chip_direct },
+	{ .exti =3D 21, .irq_parent =3D 32, .chip =3D &stm32_exti_h_chip_direct },
+	{ .exti =3D 22, .irq_parent =3D 34, .chip =3D &stm32_exti_h_chip_direct },
+	{ .exti =3D 23, .irq_parent =3D 73, .chip =3D &stm32_exti_h_chip_direct },
+	{ .exti =3D 24, .irq_parent =3D 93, .chip =3D &stm32_exti_h_chip_direct },
+	{ .exti =3D 25, .irq_parent =3D 114, .chip =3D &stm32_exti_h_chip_direct },
+	{ .exti =3D 26, .irq_parent =3D 38, .chip =3D &stm32_exti_h_chip_direct },
+	{ .exti =3D 27, .irq_parent =3D 39, .chip =3D &stm32_exti_h_chip_direct },
+	{ .exti =3D 28, .irq_parent =3D 40, .chip =3D &stm32_exti_h_chip_direct },
+	{ .exti =3D 29, .irq_parent =3D 72, .chip =3D &stm32_exti_h_chip_direct },
+	{ .exti =3D 30, .irq_parent =3D 53, .chip =3D &stm32_exti_h_chip_direct },
+	{ .exti =3D 31, .irq_parent =3D 54, .chip =3D &stm32_exti_h_chip_direct },
+	{ .exti =3D 32, .irq_parent =3D 83, .chip =3D &stm32_exti_h_chip_direct },
+	{ .exti =3D 33, .irq_parent =3D 84, .chip =3D &stm32_exti_h_chip_direct },
+	{ .exti =3D 44, .irq_parent =3D 96, .chip =3D &stm32_exti_h_chip_direct },
+	{ .exti =3D 47, .irq_parent =3D 92, .chip =3D &stm32_exti_h_chip_direct },
+	{ .exti =3D 48, .irq_parent =3D 116, .chip =3D &stm32_exti_h_chip_direct },
+	{ .exti =3D 50, .irq_parent =3D 117, .chip =3D &stm32_exti_h_chip_direct },
+	{ .exti =3D 52, .irq_parent =3D 118, .chip =3D &stm32_exti_h_chip_direct },
+	{ .exti =3D 53, .irq_parent =3D 119, .chip =3D &stm32_exti_h_chip_direct },
+	{ .exti =3D 68, .irq_parent =3D 63, .chip =3D &stm32_exti_h_chip_direct },
+	{ .exti =3D 70, .irq_parent =3D 98, .chip =3D &stm32_exti_h_chip_direct },
+};
+
 static const struct stm32_exti_drv_data stm32mp1_drv_data =3D {
 	.exti_banks =3D stm32mp1_exti_banks,
 	.bank_nr =3D ARRAY_SIZE(stm32mp1_exti_banks),
@@ -221,6 +263,13 @@ static const struct stm32_exti_drv_data stm32mp1_drv_dat=
a =3D {
 	.irq_nr =3D ARRAY_SIZE(stm32mp1_desc_irq),
 };
=20
+static const struct stm32_exti_drv_data stm32mp13_drv_data =3D {
+	.exti_banks =3D stm32mp1_exti_banks,
+	.bank_nr =3D ARRAY_SIZE(stm32mp1_exti_banks),
+	.desc_irqs =3D stm32mp13_desc_irq,
+	.irq_nr =3D ARRAY_SIZE(stm32mp13_desc_irq),
+};
+
 static const struct
 stm32_desc_irq *stm32_exti_get_desc(const struct stm32_exti_drv_data *drv_da=
ta,
 				    irq_hw_number_t hwirq)
@@ -922,6 +971,7 @@ static int stm32_exti_probe(struct platform_device *pdev)
 /* platform driver only for MP1 */
 static const struct of_device_id stm32_exti_ids[] =3D {
 	{ .compatible =3D "st,stm32mp1-exti", .data =3D &stm32mp1_drv_data},
+	{ .compatible =3D "st,stm32mp13-exti", .data =3D &stm32mp13_drv_data},
 	{},
 };
 MODULE_DEVICE_TABLE(of, stm32_exti_ids);
diff --git a/drivers/irqchip/irq-ts4800.c b/drivers/irqchip/irq-ts4800.c
index f032db23b30f..b2d61d4f6fe6 100644
--- a/drivers/irqchip/irq-ts4800.c
+++ b/drivers/irqchip/irq-ts4800.c
@@ -19,14 +19,15 @@
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/platform_device.h>
+#include <linux/seq_file.h>
=20
 #define IRQ_MASK        0x4
 #define IRQ_STATUS      0x8
=20
 struct ts4800_irq_data {
 	void __iomem            *base;
+	struct platform_device	*pdev;
 	struct irq_domain       *domain;
-	struct irq_chip         irq_chip;
 };
=20
 static void ts4800_irq_mask(struct irq_data *d)
@@ -47,12 +48,25 @@ static void ts4800_irq_unmask(struct irq_data *d)
 	writew(reg & ~mask, data->base + IRQ_MASK);
 }
=20
+static void ts4800_irq_print_chip(struct irq_data *d, struct seq_file *p)
+{
+	struct ts4800_irq_data *data =3D irq_data_get_irq_chip_data(d);
+
+	seq_printf(p, "%s", dev_name(&data->pdev->dev));
+}
+
+static const struct irq_chip ts4800_chip =3D {
+	.irq_mask	=3D ts4800_irq_mask,
+	.irq_unmask	=3D ts4800_irq_unmask,
+	.irq_print_chip	=3D ts4800_irq_print_chip,
+};
+
 static int ts4800_irqdomain_map(struct irq_domain *d, unsigned int irq,
 				irq_hw_number_t hwirq)
 {
 	struct ts4800_irq_data *data =3D d->host_data;
=20
-	irq_set_chip_and_handler(irq, &data->irq_chip, handle_simple_irq);
+	irq_set_chip_and_handler(irq, &ts4800_chip, handle_simple_irq);
 	irq_set_chip_data(irq, data);
 	irq_set_noprobe(irq);
=20
@@ -92,13 +106,13 @@ static int ts4800_ic_probe(struct platform_device *pdev)
 {
 	struct device_node *node =3D pdev->dev.of_node;
 	struct ts4800_irq_data *data;
-	struct irq_chip *irq_chip;
 	int parent_irq;
=20
 	data =3D devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
=20
+	data->pdev =3D pdev;
 	data->base =3D devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(data->base))
 		return PTR_ERR(data->base);
@@ -111,11 +125,6 @@ static int ts4800_ic_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
=20
-	irq_chip =3D &data->irq_chip;
-	irq_chip->name =3D dev_name(&pdev->dev);
-	irq_chip->irq_mask =3D ts4800_irq_mask;
-	irq_chip->irq_unmask =3D ts4800_irq_unmask;
-
 	data->domain =3D irq_domain_add_linear(node, 8, &ts4800_ic_ops, data);
 	if (!data->domain) {
 		dev_err(&pdev->dev, "cannot add IRQ domain\n");
diff --git a/drivers/irqchip/irq-versatile-fpga.c b/drivers/irqchip/irq-versa=
tile-fpga.c
index f2757b6aecc8..ba543ed9c154 100644
--- a/drivers/irqchip/irq-versatile-fpga.c
+++ b/drivers/irqchip/irq-versatile-fpga.c
@@ -7,12 +7,12 @@
 #include <linux/io.h>
 #include <linux/irqchip.h>
 #include <linux/irqchip/chained_irq.h>
-#include <linux/irqchip/versatile-fpga.h>
 #include <linux/irqdomain.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
+#include <linux/seq_file.h>
=20
 #include <asm/exception.h>
 #include <asm/mach/irq.h>
@@ -34,14 +34,12 @@
 /**
  * struct fpga_irq_data - irq data container for the FPGA IRQ controller
  * @base: memory offset in virtual memory
- * @chip: chip container for this instance
  * @domain: IRQ domain for this instance
  * @valid: mask for valid IRQs on this controller
  * @used_irqs: number of active IRQs on this controller
  */
 struct fpga_irq_data {
 	void __iomem *base;
-	struct irq_chip chip;
 	u32 valid;
 	struct irq_domain *domain;
 	u8 used_irqs;
@@ -67,6 +65,20 @@ static void fpga_irq_unmask(struct irq_data *d)
 	writel(mask, f->base + IRQ_ENABLE_SET);
 }
=20
+static void fpga_irq_print_chip(struct irq_data *d, struct seq_file *p)
+{
+	struct fpga_irq_data *f =3D irq_data_get_irq_chip_data(d);
+
+	seq_printf(p, irq_domain_get_of_node(f->domain)->name);
+}
+
+static const struct irq_chip fpga_chip =3D {
+	.irq_ack	=3D fpga_irq_mask,
+	.irq_mask	=3D fpga_irq_mask,
+	.irq_unmask	=3D fpga_irq_unmask,
+	.irq_print_chip	=3D fpga_irq_print_chip,
+};
+
 static void fpga_irq_handle(struct irq_desc *desc)
 {
 	struct irq_chip *chip =3D irq_desc_get_chip(desc);
@@ -116,7 +128,7 @@ static int handle_one_fpga(struct fpga_irq_data *f, struc=
t pt_regs *regs)
  * Keep iterating over all registered FPGA IRQ controllers until there are
  * no pending interrupts.
  */
-asmlinkage void __exception_irq_entry fpga_handle_irq(struct pt_regs *regs)
+static asmlinkage void __exception_irq_entry fpga_handle_irq(struct pt_regs =
*regs)
 {
 	int i, handled;
=20
@@ -135,8 +147,7 @@ static int fpga_irqdomain_map(struct irq_domain *d, unsig=
ned int irq,
 	if (!(f->valid & BIT(hwirq)))
 		return -EPERM;
 	irq_set_chip_data(irq, f);
-	irq_set_chip_and_handler(irq, &f->chip,
-				handle_level_irq);
+	irq_set_chip_and_handler(irq, &fpga_chip, handle_level_irq);
 	irq_set_probe(irq);
 	return 0;
 }
@@ -146,8 +157,8 @@ static const struct irq_domain_ops fpga_irqdomain_ops =3D=
 {
 	.xlate =3D irq_domain_xlate_onetwocell,
 };
=20
-void __init fpga_irq_init(void __iomem *base, const char *name, int irq_star=
t,
-			  int parent_irq, u32 valid, struct device_node *node)
+static void __init fpga_irq_init(void __iomem *base, int parent_irq,
+				 u32 valid, struct device_node *node)
 {
 	struct fpga_irq_data *f;
 	int i;
@@ -158,10 +169,6 @@ void __init fpga_irq_init(void __iomem *base, const char=
 *name, int irq_start,
 	}
 	f =3D &fpga_irq_devices[fpga_irq_id];
 	f->base =3D base;
-	f->chip.name =3D name;
-	f->chip.irq_ack =3D fpga_irq_mask;
-	f->chip.irq_mask =3D fpga_irq_mask;
-	f->chip.irq_unmask =3D fpga_irq_unmask;
 	f->valid =3D valid;
=20
 	if (parent_irq !=3D -1) {
@@ -169,20 +176,19 @@ void __init fpga_irq_init(void __iomem *base, const cha=
r *name, int irq_start,
 						 f);
 	}
=20
-	/* This will also allocate irq descriptors */
-	f->domain =3D irq_domain_add_simple(node, fls(valid), irq_start,
+	f->domain =3D irq_domain_add_linear(node, fls(valid),
 					  &fpga_irqdomain_ops, f);
=20
 	/* This will allocate all valid descriptors in the linear case */
 	for (i =3D 0; i < fls(valid); i++)
 		if (valid & BIT(i)) {
-			if (!irq_start)
-				irq_create_mapping(f->domain, i);
+			/* Is this still required? */
+			irq_create_mapping(f->domain, i);
 			f->used_irqs++;
 		}
=20
 	pr_info("FPGA IRQ chip %d \"%s\" @ %p, %u irqs",
-		fpga_irq_id, name, base, f->used_irqs);
+		fpga_irq_id, node->name, base, f->used_irqs);
 	if (parent_irq !=3D -1)
 		pr_cont(", parent IRQ: %d\n", parent_irq);
 	else
@@ -192,8 +198,8 @@ void __init fpga_irq_init(void __iomem *base, const char =
*name, int irq_start,
 }
=20
 #ifdef CONFIG_OF
-int __init fpga_irq_of_init(struct device_node *node,
-			    struct device_node *parent)
+static int __init fpga_irq_of_init(struct device_node *node,
+				   struct device_node *parent)
 {
 	void __iomem *base;
 	u32 clear_mask;
@@ -222,7 +228,7 @@ int __init fpga_irq_of_init(struct device_node *node,
 		parent_irq =3D -1;
 	}
=20
-	fpga_irq_init(base, node->name, 0, parent_irq, valid_mask, node);
+	fpga_irq_init(base, parent_irq, valid_mask, node);
=20
 	/*
 	 * On Versatile AB/PB, some secondary interrupts have a direct
diff --git a/drivers/irqchip/irq-xilinx-intc.c b/drivers/irqchip/irq-xilinx-i=
ntc.c
index 356a59755d63..238d3d344949 100644
--- a/drivers/irqchip/irq-xilinx-intc.c
+++ b/drivers/irqchip/irq-xilinx-intc.c
@@ -32,6 +32,8 @@
 #define MER_ME (1<<0)
 #define MER_HIE (1<<1)
=20
+#define SPURIOUS_IRQ	(-1U)
+
 static DEFINE_STATIC_KEY_FALSE(xintc_is_be);
=20
 struct xintc_irq_chip {
@@ -110,20 +112,6 @@ static struct irq_chip intc_dev =3D {
 	.irq_mask_ack =3D intc_mask_ack,
 };
=20
-unsigned int xintc_get_irq(void)
-{
-	unsigned int irq =3D -1;
-	u32 hwirq;
-
-	hwirq =3D xintc_read(primary_intc, IVR);
-	if (hwirq !=3D -1U)
-		irq =3D irq_find_mapping(primary_intc->root_domain, hwirq);
-
-	pr_debug("irq-xilinx: hwirq=3D%d, irq=3D%d\n", hwirq, irq);
-
-	return irq;
-}
-
 static int xintc_map(struct irq_domain *d, unsigned int irq, irq_hw_number_t=
 hw)
 {
 	struct xintc_irq_chip *irqc =3D d->host_data;
@@ -164,6 +152,19 @@ static void xil_intc_irq_handler(struct irq_desc *desc)
 	chained_irq_exit(chip, desc);
 }
=20
+static void xil_intc_handle_irq(struct pt_regs *regs)
+{
+	u32 hwirq;
+
+	do {
+		hwirq =3D xintc_read(primary_intc, IVR);
+		if (unlikely(hwirq =3D=3D SPURIOUS_IRQ))
+			break;
+
+		generic_handle_domain_irq(primary_intc->root_domain, hwirq);
+	} while (true);
+}
+
 static int __init xilinx_intc_of_init(struct device_node *intc,
 					     struct device_node *parent)
 {
@@ -233,6 +234,7 @@ static int __init xilinx_intc_of_init(struct device_node =
*intc,
 	} else {
 		primary_intc =3D irqc;
 		irq_set_default_host(primary_intc->root_domain);
+		set_handle_irq(xil_intc_handle_irq);
 	}
=20
 	return 0;
diff --git a/drivers/irqchip/qcom-pdc.c b/drivers/irqchip/qcom-pdc.c
index 173e6520e06e..d96916cf6a41 100644
--- a/drivers/irqchip/qcom-pdc.c
+++ b/drivers/irqchip/qcom-pdc.c
@@ -21,23 +21,19 @@
 #include <linux/slab.h>
 #include <linux/types.h>
=20
-#define PDC_MAX_IRQS		168
 #define PDC_MAX_GPIO_IRQS	256
=20
-#define CLEAR_INTR(reg, intr)	(reg & ~(1 << intr))
-#define ENABLE_INTR(reg, intr)	(reg | (1 << intr))
-
 #define IRQ_ENABLE_BANK		0x10
 #define IRQ_i_CFG		0x110
=20
-#define PDC_NO_PARENT_IRQ	~0UL
-
 struct pdc_pin_region {
 	u32 pin_base;
 	u32 parent_base;
 	u32 cnt;
 };
=20
+#define pin_to_hwirq(r, p)	((r)->parent_base + (p) - (r)->pin_base)
+
 static DEFINE_RAW_SPINLOCK(pdc_lock);
 static void __iomem *pdc_base;
 static struct pdc_pin_region *pdc_region;
@@ -56,17 +52,18 @@ static u32 pdc_reg_read(int reg, u32 i)
 static void pdc_enable_intr(struct irq_data *d, bool on)
 {
 	int pin_out =3D d->hwirq;
+	unsigned long enable;
+	unsigned long flags;
 	u32 index, mask;
-	u32 enable;
=20
 	index =3D pin_out / 32;
 	mask =3D pin_out % 32;
=20
-	raw_spin_lock(&pdc_lock);
+	raw_spin_lock_irqsave(&pdc_lock, flags);
 	enable =3D pdc_reg_read(IRQ_ENABLE_BANK, index);
-	enable =3D on ? ENABLE_INTR(enable, mask) : CLEAR_INTR(enable, mask);
+	__assign_bit(mask, &enable, on);
 	pdc_reg_write(IRQ_ENABLE_BANK, index, enable);
-	raw_spin_unlock(&pdc_lock);
+	raw_spin_unlock_irqrestore(&pdc_lock, flags);
 }
=20
 static void qcom_pdc_gic_disable(struct irq_data *d)
@@ -186,34 +183,17 @@ static struct irq_chip qcom_pdc_gic_chip =3D {
 	.irq_set_affinity	=3D irq_chip_set_affinity_parent,
 };
=20
-static irq_hw_number_t get_parent_hwirq(int pin)
+static struct pdc_pin_region *get_pin_region(int pin)
 {
 	int i;
-	struct pdc_pin_region *region;
=20
 	for (i =3D 0; i < pdc_region_cnt; i++) {
-		region =3D &pdc_region[i];
-		if (pin >=3D region->pin_base &&
-		    pin < region->pin_base + region->cnt)
-			return (region->parent_base + pin - region->pin_base);
+		if (pin >=3D pdc_region[i].pin_base &&
+		    pin < pdc_region[i].pin_base + pdc_region[i].cnt)
+			return &pdc_region[i];
 	}
=20
-	return PDC_NO_PARENT_IRQ;
-}
-
-static int qcom_pdc_translate(struct irq_domain *d, struct irq_fwspec *fwspe=
c,
-			      unsigned long *hwirq, unsigned int *type)
-{
-	if (is_of_node(fwspec->fwnode)) {
-		if (fwspec->param_count !=3D 2)
-			return -EINVAL;
-
-		*hwirq =3D fwspec->param[0];
-		*type =3D fwspec->param[1] & IRQ_TYPE_SENSE_MASK;
-		return 0;
-	}
-
-	return -EINVAL;
+	return NULL;
 }
=20
 static int qcom_pdc_alloc(struct irq_domain *domain, unsigned int virq,
@@ -221,55 +201,12 @@ static int qcom_pdc_alloc(struct irq_domain *domain, un=
signed int virq,
 {
 	struct irq_fwspec *fwspec =3D data;
 	struct irq_fwspec parent_fwspec;
-	irq_hw_number_t hwirq, parent_hwirq;
-	unsigned int type;
-	int ret;
-
-	ret =3D qcom_pdc_translate(domain, fwspec, &hwirq, &type);
-	if (ret)
-		return ret;
-
-	ret  =3D irq_domain_set_hwirq_and_chip(domain, virq, hwirq,
-					     &qcom_pdc_gic_chip, NULL);
-	if (ret)
-		return ret;
-
-	parent_hwirq =3D get_parent_hwirq(hwirq);
-	if (parent_hwirq =3D=3D PDC_NO_PARENT_IRQ)
-		return irq_domain_disconnect_hierarchy(domain->parent, virq);
-
-	if (type & IRQ_TYPE_EDGE_BOTH)
-		type =3D IRQ_TYPE_EDGE_RISING;
-
-	if (type & IRQ_TYPE_LEVEL_MASK)
-		type =3D IRQ_TYPE_LEVEL_HIGH;
-
-	parent_fwspec.fwnode      =3D domain->parent->fwnode;
-	parent_fwspec.param_count =3D 3;
-	parent_fwspec.param[0]    =3D 0;
-	parent_fwspec.param[1]    =3D parent_hwirq;
-	parent_fwspec.param[2]    =3D type;
-
-	return irq_domain_alloc_irqs_parent(domain, virq, nr_irqs,
-					    &parent_fwspec);
-}
-
-static const struct irq_domain_ops qcom_pdc_ops =3D {
-	.translate	=3D qcom_pdc_translate,
-	.alloc		=3D qcom_pdc_alloc,
-	.free		=3D irq_domain_free_irqs_common,
-};
-
-static int qcom_pdc_gpio_alloc(struct irq_domain *domain, unsigned int virq,
-			       unsigned int nr_irqs, void *data)
-{
-	struct irq_fwspec *fwspec =3D data;
-	struct irq_fwspec parent_fwspec;
-	irq_hw_number_t hwirq, parent_hwirq;
+	struct pdc_pin_region *region;
+	irq_hw_number_t hwirq;
 	unsigned int type;
 	int ret;
=20
-	ret =3D qcom_pdc_translate(domain, fwspec, &hwirq, &type);
+	ret =3D irq_domain_translate_twocell(domain, fwspec, &hwirq, &type);
 	if (ret)
 		return ret;
=20
@@ -281,8 +218,8 @@ static int qcom_pdc_gpio_alloc(struct irq_domain *domain,=
 unsigned int virq,
 	if (ret)
 		return ret;
=20
-	parent_hwirq =3D get_parent_hwirq(hwirq);
-	if (parent_hwirq =3D=3D PDC_NO_PARENT_IRQ)
+	region =3D get_pin_region(hwirq);
+	if (!region)
 		return irq_domain_disconnect_hierarchy(domain->parent, virq);
=20
 	if (type & IRQ_TYPE_EDGE_BOTH)
@@ -294,23 +231,16 @@ static int qcom_pdc_gpio_alloc(struct irq_domain *domai=
n, unsigned int virq,
 	parent_fwspec.fwnode      =3D domain->parent->fwnode;
 	parent_fwspec.param_count =3D 3;
 	parent_fwspec.param[0]    =3D 0;
-	parent_fwspec.param[1]    =3D parent_hwirq;
+	parent_fwspec.param[1]    =3D pin_to_hwirq(region, hwirq);
 	parent_fwspec.param[2]    =3D type;
=20
 	return irq_domain_alloc_irqs_parent(domain, virq, nr_irqs,
 					    &parent_fwspec);
 }
=20
-static int qcom_pdc_gpio_domain_select(struct irq_domain *d,
-				       struct irq_fwspec *fwspec,
-				       enum irq_domain_bus_token bus_token)
-{
-	return bus_token =3D=3D DOMAIN_BUS_WAKEUP;
-}
-
-static const struct irq_domain_ops qcom_pdc_gpio_ops =3D {
-	.select		=3D qcom_pdc_gpio_domain_select,
-	.alloc		=3D qcom_pdc_gpio_alloc,
+static const struct irq_domain_ops qcom_pdc_ops =3D {
+	.translate	=3D irq_domain_translate_twocell,
+	.alloc		=3D qcom_pdc_alloc,
 	.free		=3D irq_domain_free_irqs_common,
 };
=20
@@ -361,7 +291,7 @@ static int pdc_setup_pin_mapping(struct device_node *np)
=20
 static int qcom_pdc_init(struct device_node *node, struct device_node *paren=
t)
 {
-	struct irq_domain *parent_domain, *pdc_domain, *pdc_gpio_domain;
+	struct irq_domain *parent_domain, *pdc_domain;
 	int ret;
=20
 	pdc_base =3D of_iomap(node, 0);
@@ -383,32 +313,21 @@ static int qcom_pdc_init(struct device_node *node, stru=
ct device_node *parent)
 		goto fail;
 	}
=20
-	pdc_domain =3D irq_domain_create_hierarchy(parent_domain, 0, PDC_MAX_IRQS,
-						 of_fwnode_handle(node),
-						 &qcom_pdc_ops, NULL);
-	if (!pdc_domain) {
-		pr_err("%pOF: GIC domain add failed\n", node);
-		ret =3D -ENOMEM;
-		goto fail;
-	}
-
-	pdc_gpio_domain =3D irq_domain_create_hierarchy(parent_domain,
+	pdc_domain =3D irq_domain_create_hierarchy(parent_domain,
 					IRQ_DOMAIN_FLAG_QCOM_PDC_WAKEUP,
 					PDC_MAX_GPIO_IRQS,
 					of_fwnode_handle(node),
-					&qcom_pdc_gpio_ops, NULL);
-	if (!pdc_gpio_domain) {
-		pr_err("%pOF: PDC domain add failed for GPIO domain\n", node);
+					&qcom_pdc_ops, NULL);
+	if (!pdc_domain) {
+		pr_err("%pOF: PDC domain add failed\n", node);
 		ret =3D -ENOMEM;
-		goto remove;
+		goto fail;
 	}
=20
-	irq_domain_update_bus_token(pdc_gpio_domain, DOMAIN_BUS_WAKEUP);
+	irq_domain_update_bus_token(pdc_domain, DOMAIN_BUS_WAKEUP);
=20
 	return 0;
=20
-remove:
-	irq_domain_remove(pdc_domain);
 fail:
 	kfree(pdc_region);
 	iounmap(pdc_base);
diff --git a/drivers/mfd/ezx-pcap.c b/drivers/mfd/ezx-pcap.c
index 70fa18b04ad2..b14d3f98e1eb 100644
--- a/drivers/mfd/ezx-pcap.c
+++ b/drivers/mfd/ezx-pcap.c
@@ -193,13 +193,11 @@ static void pcap_isr_work(struct work_struct *work)
 		ezx_pcap_write(pcap, PCAP_REG_MSR, isr | msr);
 		ezx_pcap_write(pcap, PCAP_REG_ISR, isr);
=20
-		local_irq_disable();
 		service =3D isr & ~msr;
 		for (irq =3D pcap->irq_base; service; service >>=3D 1, irq++) {
 			if (service & 1)
-				generic_handle_irq(irq);
+				generic_handle_irq_safe(irq);
 		}
-		local_irq_enable();
 		ezx_pcap_write(pcap, PCAP_REG_MSR, pcap->msr);
 	} while (gpio_get_value(pdata->gpio));
 }
diff --git a/drivers/misc/hi6421v600-irq.c b/drivers/misc/hi6421v600-irq.c
index 1c763796cf1f..caa3de37698b 100644
--- a/drivers/misc/hi6421v600-irq.c
+++ b/drivers/misc/hi6421v600-irq.c
@@ -117,8 +117,8 @@ static irqreturn_t hi6421v600_irq_handler(int irq, void *=
__priv)
 			 * If both powerkey down and up IRQs are received,
 			 * handle them at the right order
 			 */
-			generic_handle_irq(priv->irqs[POWERKEY_DOWN]);
-			generic_handle_irq(priv->irqs[POWERKEY_UP]);
+			generic_handle_irq_safe(priv->irqs[POWERKEY_DOWN]);
+			generic_handle_irq_safe(priv->irqs[POWERKEY_UP]);
 			pending &=3D ~HISI_IRQ_POWERKEY_UP_DOWN;
 		}
=20
@@ -126,7 +126,7 @@ static irqreturn_t hi6421v600_irq_handler(int irq, void *=
__priv)
 			continue;
=20
 		for_each_set_bit(offset, &pending, BITS_PER_BYTE) {
-			generic_handle_irq(priv->irqs[offset + i * BITS_PER_BYTE]);
+			generic_handle_irq_safe(priv->irqs[offset + i * BITS_PER_BYTE]);
 		}
 	}
=20
diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index b8e20a3f2b84..415f16662f88 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -1537,11 +1537,8 @@ static void lan78xx_status(struct lan78xx_net *dev, st=
ruct urb *urb)
 		netif_dbg(dev, link, dev->net, "PHY INTR: 0x%08x\n", intdata);
 		lan78xx_defer_kevent(dev, EVENT_LINK_RESET);
=20
-		if (dev->domain_data.phyirq > 0) {
-			local_irq_disable();
-			generic_handle_irq(dev->domain_data.phyirq);
-			local_irq_enable();
-		}
+		if (dev->domain_data.phyirq > 0)
+			generic_handle_irq_safe(dev->domain_data.phyirq);
 	} else {
 		netdev_warn(dev->net,
 			    "unexpected interrupt: 0x%08x\n", intdata);
diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pci=
e-apple.c
index 854d95163112..a2c3c207a04b 100644
--- a/drivers/pci/controller/pcie-apple.c
+++ b/drivers/pci/controller/pcie-apple.c
@@ -219,7 +219,7 @@ static int apple_msi_domain_alloc(struct irq_domain *doma=
in, unsigned int virq,
 	if (hwirq < 0)
 		return -ENOSPC;
=20
-	fwspec.param[1] +=3D hwirq;
+	fwspec.param[fwspec.param_count - 2] +=3D hwirq;
=20
 	ret =3D irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, &fwspec);
 	if (ret)
diff --git a/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c b/drivers/pinctrl/nuvo=
ton/pinctrl-npcm7xx.c
index 4d81908d6725..ba536fd4d674 100644
--- a/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c
+++ b/drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c
@@ -78,7 +78,6 @@ struct npcm7xx_gpio {
 	struct gpio_chip	gc;
 	int			irqbase;
 	int			irq;
-	void			*priv;
 	struct irq_chip		irq_chip;
 	u32			pinctrl_id;
 	int (*direction_input)(struct gpio_chip *chip, unsigned offset);
@@ -226,7 +225,7 @@ static void npcmgpio_irq_handler(struct irq_desc *desc)
 	chained_irq_enter(chip, desc);
 	sts =3D ioread32(bank->base + NPCM7XX_GP_N_EVST);
 	en  =3D ioread32(bank->base + NPCM7XX_GP_N_EVEN);
-	dev_dbg(chip->parent_device, "=3D=3D> got irq sts %.8x %.8x\n", sts,
+	dev_dbg(bank->gc.parent, "=3D=3D> got irq sts %.8x %.8x\n", sts,
 		en);
=20
 	sts &=3D en;
@@ -241,33 +240,33 @@ static int npcmgpio_set_irq_type(struct irq_data *d, un=
signed int type)
 		gpiochip_get_data(irq_data_get_irq_chip_data(d));
 	unsigned int gpio =3D BIT(d->hwirq);
=20
-	dev_dbg(d->chip->parent_device, "setirqtype: %u.%u =3D %u\n", gpio,
+	dev_dbg(bank->gc.parent, "setirqtype: %u.%u =3D %u\n", gpio,
 		d->irq, type);
 	switch (type) {
 	case IRQ_TYPE_EDGE_RISING:
-		dev_dbg(d->chip->parent_device, "edge.rising\n");
+		dev_dbg(bank->gc.parent, "edge.rising\n");
 		npcm_gpio_clr(&bank->gc, bank->base + NPCM7XX_GP_N_EVBE, gpio);
 		npcm_gpio_clr(&bank->gc, bank->base + NPCM7XX_GP_N_POL, gpio);
 		break;
 	case IRQ_TYPE_EDGE_FALLING:
-		dev_dbg(d->chip->parent_device, "edge.falling\n");
+		dev_dbg(bank->gc.parent, "edge.falling\n");
 		npcm_gpio_clr(&bank->gc, bank->base + NPCM7XX_GP_N_EVBE, gpio);
 		npcm_gpio_set(&bank->gc, bank->base + NPCM7XX_GP_N_POL, gpio);
 		break;
 	case IRQ_TYPE_EDGE_BOTH:
-		dev_dbg(d->chip->parent_device, "edge.both\n");
+		dev_dbg(bank->gc.parent, "edge.both\n");
 		npcm_gpio_set(&bank->gc, bank->base + NPCM7XX_GP_N_EVBE, gpio);
 		break;
 	case IRQ_TYPE_LEVEL_LOW:
-		dev_dbg(d->chip->parent_device, "level.low\n");
+		dev_dbg(bank->gc.parent, "level.low\n");
 		npcm_gpio_set(&bank->gc, bank->base + NPCM7XX_GP_N_POL, gpio);
 		break;
 	case IRQ_TYPE_LEVEL_HIGH:
-		dev_dbg(d->chip->parent_device, "level.high\n");
+		dev_dbg(bank->gc.parent, "level.high\n");
 		npcm_gpio_clr(&bank->gc, bank->base + NPCM7XX_GP_N_POL, gpio);
 		break;
 	default:
-		dev_dbg(d->chip->parent_device, "invalid irq type\n");
+		dev_dbg(bank->gc.parent, "invalid irq type\n");
 		return -EINVAL;
 	}
=20
@@ -289,7 +288,7 @@ static void npcmgpio_irq_ack(struct irq_data *d)
 		gpiochip_get_data(irq_data_get_irq_chip_data(d));
 	unsigned int gpio =3D d->hwirq;
=20
-	dev_dbg(d->chip->parent_device, "irq_ack: %u.%u\n", gpio, d->irq);
+	dev_dbg(bank->gc.parent, "irq_ack: %u.%u\n", gpio, d->irq);
 	iowrite32(BIT(gpio), bank->base + NPCM7XX_GP_N_EVST);
 }
=20
@@ -301,7 +300,7 @@ static void npcmgpio_irq_mask(struct irq_data *d)
 	unsigned int gpio =3D d->hwirq;
=20
 	/* Clear events */
-	dev_dbg(d->chip->parent_device, "irq_mask: %u.%u\n", gpio, d->irq);
+	dev_dbg(bank->gc.parent, "irq_mask: %u.%u\n", gpio, d->irq);
 	iowrite32(BIT(gpio), bank->base + NPCM7XX_GP_N_EVENC);
 }
=20
@@ -313,7 +312,7 @@ static void npcmgpio_irq_unmask(struct irq_data *d)
 	unsigned int gpio =3D d->hwirq;
=20
 	/* Enable events */
-	dev_dbg(d->chip->parent_device, "irq_unmask: %u.%u\n", gpio, d->irq);
+	dev_dbg(bank->gc.parent, "irq_unmask: %u.%u\n", gpio, d->irq);
 	iowrite32(BIT(gpio), bank->base + NPCM7XX_GP_N_EVENS);
 }
=20
@@ -323,7 +322,7 @@ static unsigned int npcmgpio_irq_startup(struct irq_data =
*d)
 	unsigned int gpio =3D d->hwirq;
=20
 	/* active-high, input, clear interrupt, enable interrupt */
-	dev_dbg(d->chip->parent_device, "startup: %u.%u\n", gpio, d->irq);
+	dev_dbg(gc->parent, "startup: %u.%u\n", gpio, d->irq);
 	npcmgpio_direction_input(gc, gpio);
 	npcmgpio_irq_ack(d);
 	npcmgpio_irq_unmask(d);
diff --git a/drivers/pinctrl/pinctrl-starfive.c b/drivers/pinctrl/pinctrl-sta=
rfive.c
index 266da41a6162..ab4b2ee9f217 100644
--- a/drivers/pinctrl/pinctrl-starfive.c
+++ b/drivers/pinctrl/pinctrl-starfive.c
@@ -1308,8 +1308,6 @@ static int starfive_probe(struct platform_device *pdev)
 	sfp->gc.base =3D -1;
 	sfp->gc.ngpio =3D NR_GPIOS;
=20
-	starfive_irq_chip.parent_device =3D dev;
-
 	sfp->gc.irq.chip =3D &starfive_irq_chip;
 	sfp->gc.irq.parent_handler =3D starfive_gpio_irq_handler;
 	sfp->gc.irq.num_parents =3D 1;
@@ -1330,6 +1328,8 @@ static int starfive_probe(struct platform_device *pdev)
 	if (ret)
 		return dev_err_probe(dev, ret, "could not register gpiochip\n");
=20
+	irq_domain_set_pm_device(sfp->gc.irq.domain, dev);
+
 out_pinctrl_enable:
 	return pinctrl_enable(sfp->pctl);
 }
diff --git a/drivers/staging/greybus/gpio.c b/drivers/staging/greybus/gpio.c
index 7e6347fe93f9..8a7cf1d0e968 100644
--- a/drivers/staging/greybus/gpio.c
+++ b/drivers/staging/greybus/gpio.c
@@ -391,10 +391,7 @@ static int gb_gpio_request_handler(struct gb_operation *=
op)
 		return -EINVAL;
 	}
=20
-	local_irq_disable();
-	ret =3D generic_handle_irq(irq);
-	local_irq_enable();
-
+	ret =3D generic_handle_irq_safe(irq);
 	if (ret)
 		dev_err(dev, "failed to invoke irq handler\n");
=20
diff --git a/include/dt-bindings/interrupt-controller/apple-aic.h b/include/d=
t-bindings/interrupt-controller/apple-aic.h
index 604f2bb30ac0..bf3aac0e5491 100644
--- a/include/dt-bindings/interrupt-controller/apple-aic.h
+++ b/include/dt-bindings/interrupt-controller/apple-aic.h
@@ -11,5 +11,7 @@
 #define AIC_TMR_HV_VIRT		1
 #define AIC_TMR_GUEST_PHYS	2
 #define AIC_TMR_GUEST_VIRT	3
+#define AIC_CPU_PMU_E		4
+#define AIC_CPU_PMU_P		5
=20
 #endif
diff --git a/include/linux/irq.h b/include/linux/irq.h
index 848e1e12c5c6..f92788ccdba2 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -456,7 +456,6 @@ static inline irq_hw_number_t irqd_to_hwirq(struct irq_da=
ta *d)
 /**
  * struct irq_chip - hardware interrupt chip descriptor
  *
- * @parent_device:	pointer to parent device for irqchip
  * @name:		name for /proc/interrupts
  * @irq_startup:	start up the interrupt (defaults to ->enable if NULL)
  * @irq_shutdown:	shut down the interrupt (defaults to ->disable if NULL)
@@ -503,7 +502,6 @@ static inline irq_hw_number_t irqd_to_hwirq(struct irq_da=
ta *d)
  * @flags:		chip specific flags
  */
 struct irq_chip {
-	struct device	*parent_device;
 	const char	*name;
 	unsigned int	(*irq_startup)(struct irq_data *data);
 	void		(*irq_shutdown)(struct irq_data *data);
@@ -712,10 +710,11 @@ extern struct irq_chip no_irq_chip;
 extern struct irq_chip dummy_irq_chip;
=20
 extern void
-irq_set_chip_and_handler_name(unsigned int irq, struct irq_chip *chip,
+irq_set_chip_and_handler_name(unsigned int irq, const struct irq_chip *chip,
 			      irq_flow_handler_t handle, const char *name);
=20
-static inline void irq_set_chip_and_handler(unsigned int irq, struct irq_chi=
p *chip,
+static inline void irq_set_chip_and_handler(unsigned int irq,
+					    const struct irq_chip *chip,
 					    irq_flow_handler_t handle)
 {
 	irq_set_chip_and_handler_name(irq, chip, handle, NULL);
@@ -805,7 +804,7 @@ static inline void irq_set_percpu_devid_flags(unsigned in=
t irq)
 }
=20
 /* Set/get chip/data for an IRQ: */
-extern int irq_set_chip(unsigned int irq, struct irq_chip *chip);
+extern int irq_set_chip(unsigned int irq, const struct irq_chip *chip);
 extern int irq_set_handler_data(unsigned int irq, void *data);
 extern int irq_set_chip_data(unsigned int irq, void *data);
 extern int irq_set_irq_type(unsigned int irq, unsigned int type);
diff --git a/include/linux/irqchip/versatile-fpga.h b/include/linux/irqchip/v=
ersatile-fpga.h
deleted file mode 100644
index a978fc8c7996..000000000000
--- a/include/linux/irqchip/versatile-fpga.h
+++ /dev/null
@@ -1,14 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef PLAT_FPGA_IRQ_H
-#define PLAT_FPGA_IRQ_H
-
-struct device_node;
-struct pt_regs;
-
-void fpga_handle_irq(struct pt_regs *regs);
-void fpga_irq_init(void __iomem *, const char *, int, int, u32,
-		struct device_node *node);
-int fpga_irq_of_init(struct device_node *node,
-		     struct device_node *parent);
-
-#endif
diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
index 93d270ca0c56..a77584593f7d 100644
--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -160,6 +160,7 @@ static inline void generic_handle_irq_desc(struct irq_des=
c *desc)
=20
 int handle_irq_desc(struct irq_desc *desc);
 int generic_handle_irq(unsigned int irq);
+int generic_handle_irq_safe(unsigned int irq);
=20
 #ifdef CONFIG_IRQ_DOMAIN
 /*
diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index d476405802e9..00d577f90883 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -151,6 +151,8 @@ struct irq_domain_chip_generic;
  * @gc: Pointer to a list of generic chips. There is a helper function for
  *      setting up one or more generic chips for interrupt controllers
  *      drivers using the generic chip library which uses this pointer.
+ * @dev: Pointer to a device that the domain represent, and that will be
+ *       used for power management purposes.
  * @parent: Pointer to parent irq_domain to support hierarchy irq_domains
  *
  * Revmap data, used internally by irq_domain
@@ -171,6 +173,7 @@ struct irq_domain {
 	struct fwnode_handle *fwnode;
 	enum irq_domain_bus_token bus_token;
 	struct irq_domain_chip_generic *gc;
+	struct device *dev;
 #ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
 	struct irq_domain *parent;
 #endif
@@ -226,6 +229,13 @@ static inline struct device_node *irq_domain_get_of_node=
(struct irq_domain *d)
 	return to_of_node(d->fwnode);
 }
=20
+static inline void irq_domain_set_pm_device(struct irq_domain *d,
+					    struct device *dev)
+{
+	if (d)
+		d->dev =3D dev;
+}
+
 #ifdef CONFIG_IRQ_DOMAIN
 struct fwnode_handle *__irq_domain_alloc_fwnode(unsigned int type, int id,
 						const char *name, phys_addr_t *pa);
@@ -469,7 +479,8 @@ int irq_destroy_ipi(unsigned int irq, const struct cpumas=
k *dest);
 extern struct irq_data *irq_domain_get_irq_data(struct irq_domain *domain,
 						unsigned int virq);
 extern void irq_domain_set_info(struct irq_domain *domain, unsigned int virq,
-				irq_hw_number_t hwirq, struct irq_chip *chip,
+				irq_hw_number_t hwirq,
+				const struct irq_chip *chip,
 				void *chip_data, irq_flow_handler_t handler,
 				void *handler_data, const char *handler_name);
 extern void irq_domain_reset_irq_data(struct irq_data *irq_data);
@@ -512,7 +523,7 @@ extern int irq_domain_alloc_irqs_hierarchy(struct irq_dom=
ain *domain,
 extern int irq_domain_set_hwirq_and_chip(struct irq_domain *domain,
 					 unsigned int virq,
 					 irq_hw_number_t hwirq,
-					 struct irq_chip *chip,
+					 const struct irq_chip *chip,
 					 void *chip_data);
 extern void irq_domain_free_irqs_common(struct irq_domain *domain,
 					unsigned int virq,
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index c09324663088..54af0deb239b 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -38,7 +38,7 @@ struct irqaction chained_action =3D {
  *	@irq:	irq number
  *	@chip:	pointer to irq chip description structure
  */
-int irq_set_chip(unsigned int irq, struct irq_chip *chip)
+int irq_set_chip(unsigned int irq, const struct irq_chip *chip)
 {
 	unsigned long flags;
 	struct irq_desc *desc =3D irq_get_desc_lock(irq, &flags, 0);
@@ -46,10 +46,7 @@ int irq_set_chip(unsigned int irq, struct irq_chip *chip)
 	if (!desc)
 		return -EINVAL;
=20
-	if (!chip)
-		chip =3D &no_irq_chip;
-
-	desc->irq_data.chip =3D chip;
+	desc->irq_data.chip =3D (struct irq_chip *)(chip ?: &no_irq_chip);
 	irq_put_desc_unlock(desc, flags);
 	/*
 	 * For !CONFIG_SPARSE_IRQ make the irq show up in
@@ -1073,7 +1070,7 @@ irq_set_chained_handler_and_data(unsigned int irq, irq_=
flow_handler_t handle,
 EXPORT_SYMBOL_GPL(irq_set_chained_handler_and_data);
=20
 void
-irq_set_chip_and_handler_name(unsigned int irq, struct irq_chip *chip,
+irq_set_chip_and_handler_name(unsigned int irq, const struct irq_chip *chip,
 			      irq_flow_handler_t handle, const char *name)
 {
 	irq_set_chip(irq, chip);
@@ -1558,6 +1555,14 @@ int irq_chip_compose_msi_msg(struct irq_data *data, st=
ruct msi_msg *msg)
 	return 0;
 }
=20
+static struct device *irq_get_parent_device(struct irq_data *data)
+{
+	if (data->domain)
+		return data->domain->dev;
+
+	return NULL;
+}
+
 /**
  * irq_chip_pm_get - Enable power for an IRQ chip
  * @data:	Pointer to interrupt specific data
@@ -1567,12 +1572,13 @@ int irq_chip_compose_msi_msg(struct irq_data *data, s=
truct msi_msg *msg)
  */
 int irq_chip_pm_get(struct irq_data *data)
 {
+	struct device *dev =3D irq_get_parent_device(data);
 	int retval;
=20
-	if (IS_ENABLED(CONFIG_PM) && data->chip->parent_device) {
-		retval =3D pm_runtime_get_sync(data->chip->parent_device);
+	if (IS_ENABLED(CONFIG_PM) && dev) {
+		retval =3D pm_runtime_get_sync(dev);
 		if (retval < 0) {
-			pm_runtime_put_noidle(data->chip->parent_device);
+			pm_runtime_put_noidle(dev);
 			return retval;
 		}
 	}
@@ -1590,10 +1596,11 @@ int irq_chip_pm_get(struct irq_data *data)
  */
 int irq_chip_pm_put(struct irq_data *data)
 {
+	struct device *dev =3D irq_get_parent_device(data);
 	int retval =3D 0;
=20
-	if (IS_ENABLED(CONFIG_PM) && data->chip->parent_device)
-		retval =3D pm_runtime_put(data->chip->parent_device);
+	if (IS_ENABLED(CONFIG_PM) && dev)
+		retval =3D pm_runtime_put(dev);
=20
 	return (retval < 0) ? retval : 0;
 }
diff --git a/kernel/irq/debugfs.c b/kernel/irq/debugfs.c
index e4cff358b437..2b43f5f5033d 100644
--- a/kernel/irq/debugfs.c
+++ b/kernel/irq/debugfs.c
@@ -69,8 +69,12 @@ irq_debug_show_chip(struct seq_file *m, struct irq_data *d=
ata, int ind)
 		seq_printf(m, "chip: None\n");
 		return;
 	}
-	seq_printf(m, "%*schip:    %s\n", ind, "", chip->name);
-	seq_printf(m, "%*sflags:   0x%lx\n", ind + 1, "", chip->flags);
+	seq_printf(m, "%*schip:    ", ind, "");
+	if (chip->irq_print_chip)
+		chip->irq_print_chip(data, m);
+	else
+		seq_printf(m, "%s", chip->name);
+	seq_printf(m, "\n%*sflags:   0x%lx\n", ind + 1, "", chip->flags);
 	irq_debug_show_bits(m, ind, chip->flags, irqchip_flags,
 			    ARRAY_SIZE(irqchip_flags));
 }
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 2267e6527db3..939d21cd55c3 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -640,7 +640,7 @@ int handle_irq_desc(struct irq_desc *desc)
 		return -EINVAL;
=20
 	data =3D irq_desc_get_irq_data(desc);
-	if (WARN_ON_ONCE(!in_irq() && handle_enforce_irqctx(data)))
+	if (WARN_ON_ONCE(!in_hardirq() && handle_enforce_irqctx(data)))
 		return -EPERM;
=20
 	generic_handle_irq_desc(desc);
@@ -662,6 +662,29 @@ int generic_handle_irq(unsigned int irq)
 }
 EXPORT_SYMBOL_GPL(generic_handle_irq);
=20
+/**
+ * generic_handle_irq_safe - Invoke the handler for a particular irq from any
+ *			     context.
+ * @irq:	The irq number to handle
+ *
+ * Returns:	0 on success, a negative value on error.
+ *
+ * This function can be called from any context (IRQ or process context). It
+ * will report an error if not invoked from IRQ context and the irq has been
+ * marked to enforce IRQ-context only.
+ */
+int generic_handle_irq_safe(unsigned int irq)
+{
+	unsigned long flags;
+	int ret;
+
+	local_irq_save(flags);
+	ret =3D handle_irq_desc(irq_to_desc(irq));
+	local_irq_restore(flags);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(generic_handle_irq_safe);
+
 #ifdef CONFIG_IRQ_DOMAIN
 /**
  * generic_handle_domain_irq - Invoke the handler for a HW irq belonging
@@ -676,7 +699,7 @@ EXPORT_SYMBOL_GPL(generic_handle_irq);
  */
 int generic_handle_domain_irq(struct irq_domain *domain, unsigned int hwirq)
 {
-	WARN_ON_ONCE(!in_irq());
+	WARN_ON_ONCE(!in_hardirq());
 	return handle_irq_desc(irq_resolve_mapping(domain, hwirq));
 }
 EXPORT_SYMBOL_GPL(generic_handle_domain_irq);
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index bf38c546aa25..d5ce96510549 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -1319,7 +1319,8 @@ EXPORT_SYMBOL_GPL(irq_domain_get_irq_data);
  * @chip_data:	The associated chip data
  */
 int irq_domain_set_hwirq_and_chip(struct irq_domain *domain, unsigned int vi=
rq,
-				  irq_hw_number_t hwirq, struct irq_chip *chip,
+				  irq_hw_number_t hwirq,
+				  const struct irq_chip *chip,
 				  void *chip_data)
 {
 	struct irq_data *irq_data =3D irq_domain_get_irq_data(domain, virq);
@@ -1328,7 +1329,7 @@ int irq_domain_set_hwirq_and_chip(struct irq_domain *do=
main, unsigned int virq,
 		return -ENOENT;
=20
 	irq_data->hwirq =3D hwirq;
-	irq_data->chip =3D chip ? chip : &no_irq_chip;
+	irq_data->chip =3D (struct irq_chip *)(chip ? chip : &no_irq_chip);
 	irq_data->chip_data =3D chip_data;
=20
 	return 0;
@@ -1347,7 +1348,7 @@ EXPORT_SYMBOL_GPL(irq_domain_set_hwirq_and_chip);
  * @handler_name:	The interrupt handler name
  */
 void irq_domain_set_info(struct irq_domain *domain, unsigned int virq,
-			 irq_hw_number_t hwirq, struct irq_chip *chip,
+			 irq_hw_number_t hwirq, const struct irq_chip *chip,
 			 void *chip_data, irq_flow_handler_t handler,
 			 void *handler_data, const char *handler_name)
 {
@@ -1853,7 +1854,7 @@ EXPORT_SYMBOL_GPL(irq_domain_get_irq_data);
  * @handler_name:	The interrupt handler name
  */
 void irq_domain_set_info(struct irq_domain *domain, unsigned int virq,
-			 irq_hw_number_t hwirq, struct irq_chip *chip,
+			 irq_hw_number_t hwirq, const struct irq_chip *chip,
 			 void *chip_data, irq_flow_handler_t handler,
 			 void *handler_data, const char *handler_name)
 {
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 41f470929e99..fac801815554 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -222,7 +222,7 @@ void __local_bh_enable_ip(unsigned long ip, unsigned int =
cnt)
 	u32 pending;
 	int curcnt;
=20
-	WARN_ON_ONCE(in_irq());
+	WARN_ON_ONCE(in_hardirq());
 	lockdep_assert_irqs_enabled();
=20
 	local_irq_save(flags);
@@ -305,7 +305,7 @@ void __local_bh_disable_ip(unsigned long ip, unsigned int=
 cnt)
 {
 	unsigned long flags;
=20
-	WARN_ON_ONCE(in_irq());
+	WARN_ON_ONCE(in_hardirq());
=20
 	raw_local_irq_save(flags);
 	/*
@@ -352,14 +352,14 @@ static void __local_bh_enable(unsigned int cnt)
  */
 void _local_bh_enable(void)
 {
-	WARN_ON_ONCE(in_irq());
+	WARN_ON_ONCE(in_hardirq());
 	__local_bh_enable(SOFTIRQ_DISABLE_OFFSET);
 }
 EXPORT_SYMBOL(_local_bh_enable);
=20
 void __local_bh_enable_ip(unsigned long ip, unsigned int cnt)
 {
-	WARN_ON_ONCE(in_irq());
+	WARN_ON_ONCE(in_hardirq());
 	lockdep_assert_irqs_enabled();
 #ifdef CONFIG_TRACE_IRQFLAGS
 	local_irq_disable();
@@ -618,7 +618,7 @@ static inline void tick_irq_exit(void)
=20
 	/* Make sure that timer wheel updates are propagated */
 	if ((idle_cpu(cpu) && !need_resched()) || tick_nohz_full_cpu(cpu)) {
-		if (!in_irq())
+		if (!in_hardirq())
 			tick_nohz_irq_exit();
 	}
 #endif

