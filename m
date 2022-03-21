Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 813E94E24EF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 12:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346661AbiCULEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 07:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346597AbiCULDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 07:03:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E931914DFEA
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 04:02:27 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647860546;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=RhYPZxFc16XcJVa5C1sOmlr6nw9J2jPvm4r0gjQ+Roo=;
        b=Jnlczzz+/EIfzmhBgU2kqiPv4OaG7j6Zoa0BomWh9o4AT5dL8vErIhAPmTIjAhLnaFkxg4
        Q+GRbf1EHp2H6dSFwqUHOGT+MWvA9KIhrgdR27X6A73FumbPEQxG2KZDVxczox69iIbHGD
        grnWvH0wL8aG2WIUc3e7da4QsrmCDhcj/vvyLnBN4hNpWi1eI0+J9GVzqkpK3bqUjpLysE
        aAZPyb0sAk3DiwECLuqGffioQOKEID+ymZVdnN+cbpxPs9xIVa1tDPXka1TzwBTUbT/xuf
        oppPginRPWyPQEy29HTiZsIFQGE3a8ROwjbpgQeFZOI7R8LlCkjlz9yBUCfsyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647860546;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=RhYPZxFc16XcJVa5C1sOmlr6nw9J2jPvm4r0gjQ+Roo=;
        b=TYbZKnWgNXUa8qf4VMCBNwKp1HTcf0BuyEa3S0tVygwM1Y06tKRafJ+4HDtBtnCUOkdsI4
        qGnqjr7JCuYUozAQ==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] timers/core for v5.18-rc1
References: <164786042536.122591.4459156564791679956.tglx@xen13>
Message-ID: <164786042893.122591.10484394565817935694.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Mon, 21 Mar 2022 12:02:25 +0100 (CET)
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

please pull the latest timers/core branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-2022=
-03-21

up to:  b166e52541f2: Merge tag 'timers-v5.18-rc1' of https://git.linaro.org/=
people/daniel.lezcano/linux into timers/core


Timers and timekeeping updates:

 Core code:

    - Make the NOHZ handling of the timekeeping/tick core more robust to
      prevent a rare jiffies update stall.

    - Handle softirqs in the NOHZ/idle case correctly

 Drivers:

    - Add support for event stream scaling of the 1GHz counter on ARM(64)

    - Correct an error code check in the timer-of layer

    - The usual cleanups and improvements all over the place


Thanks,

	tglx

------------------>
Alim Akhtar (3):
      clocksource/drivers/exynos_mct: Remove mct interrupt index enum
      clocksource/drivers/exynos_mct: Bump up mct max irq number
      clocksource/drivers/exynos_mct: Increase the size of name array

Claudiu Beznea (3):
      clocksource/drivers/timer-microchip-pit64b: Remove mmio selection
      clocksource/drivers/timer-microchip-pit64b: Use notrace
      clocksource/drivers/timer-microchip-pit64b: Use 5MHz for clockevent

David Heidelberg (1):
      dt-bindings: timer: Tegra: Convert text bindings to yaml

Drew Fustini (1):
      clocksource/drivers/timer-ti-dm: Fix regression from errata i940 fix

Frederic Weisbecker (4):
      tick: Detect and fix jiffies update stall
      tick/rcu: Remove obsolete rcu_needs_cpu() parameters
      tick/rcu: Stop allowing RCU_SOFTIRQ in idle
      lib/irq_poll: Declare IRQ_POLL softirq vector as ksoftirqd-parking safe

Guillaume Ranquet (1):
      clocksource/drivers/timer-of: Check return value of of_iomap in timer_o=
f_base_init()

Krzysztof Kozlowski (1):
      clocksource/drivers/exynos_mct: Handle DTS with higher number of interr=
upts

Marc Zyngier (1):
      clocksource/drivers/arm_arch_timer: Use event stream scaling when avail=
able

Nathan Chancellor (1):
      clocksource/drivers/imx-tpm: Move tpm_read_sched_clock() under CONFIG_A=
RM

Peng Fan (6):
      clocksource/drivers/imx-sysctr: Drop IRQF_IRQPOLL
      clocksource/drivers/imx-tpm: Drop IRQF_IRQPOLL
      clocksource/drivers/imx-tpm: Mark two variable with __ro_after_init
      clocksource/drivers/imx-tpm: Add CLOCK_EVT_FEAT_DYNIRQ
      clocksource/drivers/imx-tpm: Update name of clkevt
      clocksource/drivers/imx-tpm: Exclude sched clock for ARM64

Waiman Long (1):
      clocksource: Add a Kconfig option for WATCHDOG_MAX_SKEW


 .../bindings/timer/nvidia,tegra-timer.yaml         | 150 +++++++++++++++++++=
++
 .../bindings/timer/nvidia,tegra20-timer.txt        |  24 ----
 .../bindings/timer/nvidia,tegra210-timer.txt       |  36 -----
 .../bindings/timer/nvidia,tegra30-timer.txt        |  28 ----
 arch/arm/boot/dts/dra7-l4.dtsi                     |   5 +-
 arch/arm/boot/dts/dra7.dtsi                        |   8 +-
 drivers/clocksource/Kconfig                        |   1 -
 drivers/clocksource/arm_arch_timer.c               |  13 +-
 drivers/clocksource/exynos_mct.c                   |  39 +++---
 drivers/clocksource/timer-imx-sysctr.c             |   2 +-
 drivers/clocksource/timer-imx-tpm.c                |  14 +-
 drivers/clocksource/timer-microchip-pit64b.c       |   8 +-
 drivers/clocksource/timer-of.c                     |   6 +-
 drivers/clocksource/timer-ti-dm-systimer.c         |   4 +-
 include/clocksource/arm_arch_timer.h               |   1 +
 include/linux/interrupt.h                          |  11 +-
 include/linux/rcutiny.h                            |   3 +-
 include/linux/rcutree.h                            |   2 +-
 kernel/rcu/tree.c                                  |   3 +-
 kernel/time/Kconfig                                |   9 ++
 kernel/time/clocksource.c                          |   8 +-
 kernel/time/tick-sched.c                           |  77 ++++++++---
 kernel/time/tick-sched.h                           |   4 +
 23 files changed, 299 insertions(+), 157 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/timer/nvidia,tegra-time=
r.yaml
 delete mode 100644 Documentation/devicetree/bindings/timer/nvidia,tegra20-ti=
mer.txt
 delete mode 100644 Documentation/devicetree/bindings/timer/nvidia,tegra210-t=
imer.txt
 delete mode 100644 Documentation/devicetree/bindings/timer/nvidia,tegra30-ti=
mer.txt

diff --git a/Documentation/devicetree/bindings/timer/nvidia,tegra-timer.yaml =
b/Documentation/devicetree/bindings/timer/nvidia,tegra-timer.yaml
new file mode 100644
index 000000000000..b78209cd0f28
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/nvidia,tegra-timer.yaml
@@ -0,0 +1,150 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/timer/nvidia,tegra-timer.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: NVIDIA Tegra timer
+
+maintainers:
+  - Stephen Warren <swarren@nvidia.com>
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: nvidia,tegra210-timer
+    then:
+      properties:
+        interrupts:
+          # Either a single combined interrupt or up to 14 individual interr=
upts
+          minItems: 1
+          maxItems: 14
+          description: >
+            A list of 14 interrupts; one per each timer channels 0 through 13
+
+  - if:
+      properties:
+        compatible:
+          oneOf:
+            - items:
+                - enum:
+                    - nvidia,tegra114-timer
+                    - nvidia,tegra124-timer
+                    - nvidia,tegra132-timer
+                - const: nvidia,tegra30-timer
+            - items:
+                - const: nvidia,tegra30-timer
+                - const: nvidia,tegra20-timer
+    then:
+      properties:
+        interrupts:
+          # Either a single combined interrupt or up to 6 individual interru=
pts
+          minItems: 1
+          maxItems: 6
+          description: >
+            A list of 6 interrupts; one per each of timer channels 1 through=
 5,
+            and one for the shared interrupt for the remaining channels.
+
+  - if:
+      properties:
+        compatible:
+          const: nvidia,tegra20-timer
+    then:
+      properties:
+        interrupts:
+          # Either a single combined interrupt or up to 4 individual interru=
pts
+          minItems: 1
+          maxItems: 4
+          description: |
+            A list of 4 interrupts; one per timer channel.
+
+properties:
+  compatible:
+    oneOf:
+      - const: nvidia,tegra210-timer
+        description: >
+          The Tegra210 timer provides fourteen 29-bit timer counters and one=
 32-bit
+          timestamp counter. The TMRs run at either a fixed 1 MHz clock rate=
 derived
+          from the oscillator clock (TMR0-TMR9) or directly at the oscillato=
r clock
+          (TMR10-TMR13). Each TMR can be programmed to generate one-shot, pe=
riodic,
+          or watchdog interrupts.
+      - items:
+          - enum:
+              - nvidia,tegra114-timer
+              - nvidia,tegra124-timer
+              - nvidia,tegra132-timer
+          - const: nvidia,tegra30-timer
+      - items:
+          - const: nvidia,tegra30-timer
+          - const: nvidia,tegra20-timer
+        description: >
+          The Tegra30 timer provides ten 29-bit timer channels, a single 32-=
bit free
+          running counter, and 5 watchdog modules. The first two channels ma=
y also
+          trigger a legacy watchdog reset.
+      - const: nvidia,tegra20-timer
+        description: >
+          The Tegra20 timer provides four 29-bit timer channels and a single=
 32-bit free
+          running counter. The first two channels may also trigger a watchdo=
g reset.
+
+  reg:
+    maxItems: 1
+
+  interrupts: true
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: timer
+
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    timer@60005000 {
+        compatible =3D "nvidia,tegra30-timer", "nvidia,tegra20-timer";
+        reg =3D <0x60005000 0x400>;
+        interrupts =3D <0 0 IRQ_TYPE_LEVEL_HIGH>,
+                     <0 1 IRQ_TYPE_LEVEL_HIGH>,
+                     <0 41 IRQ_TYPE_LEVEL_HIGH>,
+                     <0 42 IRQ_TYPE_LEVEL_HIGH>,
+                     <0 121 IRQ_TYPE_LEVEL_HIGH>,
+                     <0 122 IRQ_TYPE_LEVEL_HIGH>;
+        clocks =3D <&tegra_car 214>;
+    };
+  - |
+    #include <dt-bindings/clock/tegra210-car.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    timer@60005000 {
+        compatible =3D "nvidia,tegra210-timer";
+        reg =3D <0x60005000 0x400>;
+        interrupts =3D <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 178 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 179 IRQ_TYPE_LEVEL_HIGH>;
+        clocks =3D <&tegra_car TEGRA210_CLK_TIMER>;
+        clock-names =3D "timer";
+    };
diff --git a/Documentation/devicetree/bindings/timer/nvidia,tegra20-timer.txt=
 b/Documentation/devicetree/bindings/timer/nvidia,tegra20-timer.txt
deleted file mode 100644
index 4a864bd10d3d..000000000000
--- a/Documentation/devicetree/bindings/timer/nvidia,tegra20-timer.txt
+++ /dev/null
@@ -1,24 +0,0 @@
-NVIDIA Tegra20 timer
-
-The Tegra20 timer provides four 29-bit timer channels and a single 32-bit fr=
ee
-running counter. The first two channels may also trigger a watchdog reset.
-
-Required properties:
-
-- compatible : should be "nvidia,tegra20-timer".
-- reg : Specifies base physical address and size of the registers.
-- interrupts : A list of 4 interrupts; one per timer channel.
-- clocks : Must contain one entry, for the module clock.
-  See ../clocks/clock-bindings.txt for details.
-
-Example:
-
-timer {
-	compatible =3D "nvidia,tegra20-timer";
-	reg =3D <0x60005000 0x60>;
-	interrupts =3D <0 0 0x04
-			0 1 0x04
-			0 41 0x04
-			0 42 0x04>;
-	clocks =3D <&tegra_car 132>;
-};
diff --git a/Documentation/devicetree/bindings/timer/nvidia,tegra210-timer.tx=
t b/Documentation/devicetree/bindings/timer/nvidia,tegra210-timer.txt
deleted file mode 100644
index 032cda96fe0d..000000000000
--- a/Documentation/devicetree/bindings/timer/nvidia,tegra210-timer.txt
+++ /dev/null
@@ -1,36 +0,0 @@
-NVIDIA Tegra210 timer
-
-The Tegra210 timer provides fourteen 29-bit timer counters and one 32-bit
-timestamp counter. The TMRs run at either a fixed 1 MHz clock rate derived
-from the oscillator clock (TMR0-TMR9) or directly at the oscillator clock
-(TMR10-TMR13). Each TMR can be programmed to generate one-shot, periodic,
-or watchdog interrupts.
-
-Required properties:
-- compatible : "nvidia,tegra210-timer".
-- reg : Specifies base physical address and size of the registers.
-- interrupts : A list of 14 interrupts; one per each timer channels 0 through
-  13.
-- clocks : Must contain one entry, for the module clock.
-  See ../clocks/clock-bindings.txt for details.
-
-timer@60005000 {
-	compatible =3D "nvidia,tegra210-timer";
-	reg =3D <0x0 0x60005000 0x0 0x400>;
-	interrupts =3D <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 178 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 179 IRQ_TYPE_LEVEL_HIGH>;
-	clocks =3D <&tegra_car TEGRA210_CLK_TIMER>;
-	clock-names =3D "timer";
-};
diff --git a/Documentation/devicetree/bindings/timer/nvidia,tegra30-timer.txt=
 b/Documentation/devicetree/bindings/timer/nvidia,tegra30-timer.txt
deleted file mode 100644
index 1761f53ee36f..000000000000
--- a/Documentation/devicetree/bindings/timer/nvidia,tegra30-timer.txt
+++ /dev/null
@@ -1,28 +0,0 @@
-NVIDIA Tegra30 timer
-
-The Tegra30 timer provides ten 29-bit timer channels, a single 32-bit free
-running counter, and 5 watchdog modules. The first two channels may also
-trigger a legacy watchdog reset.
-
-Required properties:
-
-- compatible : For Tegra30, must contain "nvidia,tegra30-timer".  Otherwise,
-  must contain '"nvidia,<chip>-timer", "nvidia,tegra30-timer"' where
-  <chip> is tegra124 or tegra132.
-- reg : Specifies base physical address and size of the registers.
-- interrupts : A list of 6 interrupts; one per each of timer channels 1
-    through 5, and one for the shared interrupt for the remaining channels.
-- clocks : Must contain one entry, for the module clock.
-  See ../clocks/clock-bindings.txt for details.
-
-timer {
-	compatible =3D "nvidia,tegra30-timer", "nvidia,tegra20-timer";
-	reg =3D <0x60005000 0x400>;
-	interrupts =3D <0 0 0x04
-		      0 1 0x04
-		      0 41 0x04
-		      0 42 0x04
-		      0 121 0x04
-		      0 122 0x04>;
-	clocks =3D <&tegra_car 214>;
-};
diff --git a/arch/arm/boot/dts/dra7-l4.dtsi b/arch/arm/boot/dts/dra7-l4.dtsi
index 956a26d52a4c..0a11bacffc1f 100644
--- a/arch/arm/boot/dts/dra7-l4.dtsi
+++ b/arch/arm/boot/dts/dra7-l4.dtsi
@@ -3482,8 +3482,7 @@ timer14: timer@0 {
 				ti,timer-pwm;
 			};
 		};
-
-		target-module@2c000 {			/* 0x4882c000, ap 17 02.0 */
+		timer15_target: target-module@2c000 {	/* 0x4882c000, ap 17 02.0 */
 			compatible =3D "ti,sysc-omap4-timer", "ti,sysc";
 			reg =3D <0x2c000 0x4>,
 			      <0x2c010 0x4>;
@@ -3511,7 +3510,7 @@ timer15: timer@0 {
 			};
 		};
=20
-		target-module@2e000 {			/* 0x4882e000, ap 19 14.0 */
+		timer16_target: target-module@2e000 {	/* 0x4882e000, ap 19 14.0 */
 			compatible =3D "ti,sysc-omap4-timer", "ti,sysc";
 			reg =3D <0x2e000 0x4>,
 			      <0x2e010 0x4>;
diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 42bff117656c..97ce0c4f1df7 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -1339,20 +1339,20 @@ timer@0 {
 };
=20
 /* Local timers, see ARM architected timer wrap erratum i940 */
-&timer3_target {
+&timer15_target {
 	ti,no-reset-on-init;
 	ti,no-idle;
 	timer@0 {
-		assigned-clocks =3D <&l4per_clkctrl DRA7_L4PER_TIMER3_CLKCTRL 24>;
+		assigned-clocks =3D <&l4per3_clkctrl DRA7_L4PER3_TIMER15_CLKCTRL 24>;
 		assigned-clock-parents =3D <&timer_sys_clk_div>;
 	};
 };
=20
-&timer4_target {
+&timer16_target {
 	ti,no-reset-on-init;
 	ti,no-idle;
 	timer@0 {
-		assigned-clocks =3D <&l4per_clkctrl DRA7_L4PER_TIMER4_CLKCTRL 24>;
+		assigned-clocks =3D <&l4per3_clkctrl DRA7_L4PER3_TIMER16_CLKCTRL 24>;
 		assigned-clock-parents =3D <&timer_sys_clk_div>;
 	};
 };
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index cfb8ea0df3b1..1ea556e75494 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -713,7 +713,6 @@ config INGENIC_OST
 config MICROCHIP_PIT64B
 	bool "Microchip PIT64B support"
 	depends on OF || COMPILE_TEST
-	select CLKSRC_MMIO
 	select TIMER_OF
 	help
 	  This option enables Microchip PIT64B timer for Atmel
diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_a=
rch_timer.c
index 1ecd52f903b8..9ab8221ee3c6 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -880,10 +880,19 @@ static void __arch_timer_setup(unsigned type,
 	clockevents_config_and_register(clk, arch_timer_rate, 0xf, max_delta);
 }
=20
-static void arch_timer_evtstrm_enable(int divider)
+static void arch_timer_evtstrm_enable(unsigned int divider)
 {
 	u32 cntkctl =3D arch_timer_get_cntkctl();
=20
+#ifdef CONFIG_ARM64
+	/* ECV is likely to require a large divider. Use the EVNTIS flag. */
+	if (cpus_have_const_cap(ARM64_HAS_ECV) && divider > 15) {
+		cntkctl |=3D ARCH_TIMER_EVT_INTERVAL_SCALE;
+		divider -=3D 8;
+	}
+#endif
+
+	divider =3D min(divider, 15U);
 	cntkctl &=3D ~ARCH_TIMER_EVT_TRIGGER_MASK;
 	/* Set the divider and enable virtual event stream */
 	cntkctl |=3D (divider << ARCH_TIMER_EVT_TRIGGER_SHIFT)
@@ -912,7 +921,7 @@ static void arch_timer_configure_evtstream(void)
 		lsb++;
=20
 	/* enable event stream */
-	arch_timer_evtstrm_enable(max(0, min(lsb, 15)));
+	arch_timer_evtstrm_enable(max(0, lsb));
 }
=20
 static void arch_counter_set_user_access(void)
diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mc=
t.c
index 6db3d5511b0f..f29c812b70c9 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -60,27 +60,18 @@
 #define MCT_CLKEVENTS_RATING		350
 #endif
=20
+/* There are four Global timers starting with 0 offset */
+#define MCT_G0_IRQ	0
+/* Local timers count starts after global timer count */
+#define MCT_L0_IRQ	4
+/* Max number of IRQ as per DT binding document */
+#define MCT_NR_IRQS	20
+
 enum {
 	MCT_INT_SPI,
 	MCT_INT_PPI
 };
=20
-enum {
-	MCT_G0_IRQ,
-	MCT_G1_IRQ,
-	MCT_G2_IRQ,
-	MCT_G3_IRQ,
-	MCT_L0_IRQ,
-	MCT_L1_IRQ,
-	MCT_L2_IRQ,
-	MCT_L3_IRQ,
-	MCT_L4_IRQ,
-	MCT_L5_IRQ,
-	MCT_L6_IRQ,
-	MCT_L7_IRQ,
-	MCT_NR_IRQS,
-};
-
 static void __iomem *reg_base;
 static unsigned long clk_rate;
 static unsigned int mct_int_type;
@@ -89,7 +80,11 @@ static int mct_irqs[MCT_NR_IRQS];
 struct mct_clock_event_device {
 	struct clock_event_device evt;
 	unsigned long base;
-	char name[10];
+	/**
+	 *  The length of the name must be adjusted if number of
+	 *  local timer interrupts grow over two digits
+	 */
+	char name[11];
 };
=20
 static void exynos4_mct_write(unsigned int value, unsigned long offset)
@@ -541,6 +536,11 @@ static int __init exynos4_timer_interrupts(struct device=
_node *np,
 	 * irqs are specified.
 	 */
 	nr_irqs =3D of_irq_count(np);
+	if (nr_irqs > ARRAY_SIZE(mct_irqs)) {
+		pr_err("exynos-mct: too many (%d) interrupts configured in DT\n",
+			nr_irqs);
+		nr_irqs =3D ARRAY_SIZE(mct_irqs);
+	}
 	for (i =3D MCT_L0_IRQ; i < nr_irqs; i++)
 		mct_irqs[i] =3D irq_of_parse_and_map(np, i);
=20
@@ -553,11 +553,14 @@ static int __init exynos4_timer_interrupts(struct devic=
e_node *np,
 		     mct_irqs[MCT_L0_IRQ], err);
 	} else {
 		for_each_possible_cpu(cpu) {
-			int mct_irq =3D mct_irqs[MCT_L0_IRQ + cpu];
+			int mct_irq;
 			struct mct_clock_event_device *pcpu_mevt =3D
 				per_cpu_ptr(&percpu_mct_tick, cpu);
=20
 			pcpu_mevt->evt.irq =3D -1;
+			if (MCT_L0_IRQ + cpu >=3D ARRAY_SIZE(mct_irqs))
+				break;
+			mct_irq =3D mct_irqs[MCT_L0_IRQ + cpu];
=20
 			irq_set_status_flags(mct_irq, IRQ_NOAUTOEN);
 			if (request_irq(mct_irq,
diff --git a/drivers/clocksource/timer-imx-sysctr.c b/drivers/clocksource/tim=
er-imx-sysctr.c
index 55a8e198d2a1..523e37662a6e 100644
--- a/drivers/clocksource/timer-imx-sysctr.c
+++ b/drivers/clocksource/timer-imx-sysctr.c
@@ -110,7 +110,7 @@ static struct timer_of to_sysctr =3D {
 	},
 	.of_irq =3D {
 		.handler		=3D sysctr_timer_interrupt,
-		.flags			=3D IRQF_TIMER | IRQF_IRQPOLL,
+		.flags			=3D IRQF_TIMER,
 	},
 	.of_clk =3D {
 		.name =3D "per",
diff --git a/drivers/clocksource/timer-imx-tpm.c b/drivers/clocksource/timer-=
imx-tpm.c
index 2cdc077a39f5..bd64a8a8427f 100644
--- a/drivers/clocksource/timer-imx-tpm.c
+++ b/drivers/clocksource/timer-imx-tpm.c
@@ -32,8 +32,8 @@
 #define TPM_C0SC_CHF_MASK		(0x1 << 7)
 #define TPM_C0V				0x24
=20
-static int counter_width;
-static void __iomem *timer_base;
+static int counter_width __ro_after_init;
+static void __iomem *timer_base __ro_after_init;
=20
 static inline void tpm_timer_disable(void)
 {
@@ -73,12 +73,12 @@ static unsigned long tpm_read_current_timer(void)
 {
 	return tpm_read_counter();
 }
-#endif
=20
 static u64 notrace tpm_read_sched_clock(void)
 {
 	return tpm_read_counter();
 }
+#endif
=20
 static int tpm_set_next_event(unsigned long delta,
 				struct clock_event_device *evt)
@@ -127,9 +127,9 @@ static irqreturn_t tpm_timer_interrupt(int irq, void *dev=
_id)
 static struct timer_of to_tpm =3D {
 	.flags =3D TIMER_OF_IRQ | TIMER_OF_BASE | TIMER_OF_CLOCK,
 	.clkevt =3D {
-		.name			=3D "i.MX7ULP TPM Timer",
+		.name			=3D "i.MX TPM Timer",
 		.rating			=3D 200,
-		.features		=3D CLOCK_EVT_FEAT_ONESHOT,
+		.features		=3D CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_DYNIRQ,
 		.set_state_shutdown	=3D tpm_set_state_shutdown,
 		.set_state_oneshot	=3D tpm_set_state_oneshot,
 		.set_next_event		=3D tpm_set_next_event,
@@ -137,7 +137,7 @@ static struct timer_of to_tpm =3D {
 	},
 	.of_irq =3D {
 		.handler		=3D tpm_timer_interrupt,
-		.flags			=3D IRQF_TIMER | IRQF_IRQPOLL,
+		.flags			=3D IRQF_TIMER,
 	},
 	.of_clk =3D {
 		.name =3D "per",
@@ -150,10 +150,10 @@ static int __init tpm_clocksource_init(void)
 	tpm_delay_timer.read_current_timer =3D &tpm_read_current_timer;
 	tpm_delay_timer.freq =3D timer_of_rate(&to_tpm) >> 3;
 	register_current_timer_delay(&tpm_delay_timer);
-#endif
=20
 	sched_clock_register(tpm_read_sched_clock, counter_width,
 			     timer_of_rate(&to_tpm) >> 3);
+#endif
=20
 	return clocksource_mmio_init(timer_base + TPM_CNT,
 				     "imx-tpm",
diff --git a/drivers/clocksource/timer-microchip-pit64b.c b/drivers/clocksour=
ce/timer-microchip-pit64b.c
index cfa4ec7ef396..abce83d2f00b 100644
--- a/drivers/clocksource/timer-microchip-pit64b.c
+++ b/drivers/clocksource/timer-microchip-pit64b.c
@@ -42,8 +42,7 @@
 #define MCHP_PIT64B_LSBMASK		GENMASK_ULL(31, 0)
 #define MCHP_PIT64B_PRES_TO_MODE(p)	(MCHP_PIT64B_MR_PRES & ((p) << 8))
 #define MCHP_PIT64B_MODE_TO_PRES(m)	((MCHP_PIT64B_MR_PRES & (m)) >> 8)
-#define MCHP_PIT64B_DEF_CS_FREQ		5000000UL	/* 5 MHz */
-#define MCHP_PIT64B_DEF_CE_FREQ		32768		/* 32 KHz */
+#define MCHP_PIT64B_DEF_FREQ		5000000UL	/* 5 MHz */
=20
 #define MCHP_PIT64B_NAME		"pit64b"
=20
@@ -165,7 +164,7 @@ static u64 mchp_pit64b_clksrc_read(struct clocksource *cs)
 	return mchp_pit64b_cnt_read(mchp_pit64b_cs_base);
 }
=20
-static u64 mchp_pit64b_sched_read_clk(void)
+static u64 notrace mchp_pit64b_sched_read_clk(void)
 {
 	return mchp_pit64b_cnt_read(mchp_pit64b_cs_base);
 }
@@ -418,7 +417,6 @@ static int __init mchp_pit64b_init_clkevt(struct mchp_pit=
64b_timer *timer,
 static int __init mchp_pit64b_dt_init_timer(struct device_node *node,
 					    bool clkevt)
 {
-	u32 freq =3D clkevt ? MCHP_PIT64B_DEF_CE_FREQ : MCHP_PIT64B_DEF_CS_FREQ;
 	struct mchp_pit64b_timer timer;
 	unsigned long clk_rate;
 	u32 irq =3D 0;
@@ -446,7 +444,7 @@ static int __init mchp_pit64b_dt_init_timer(struct device=
_node *node,
 	}
=20
 	/* Initialize mode (prescaler + SGCK bit). To be used at runtime. */
-	ret =3D mchp_pit64b_init_mode(&timer, freq);
+	ret =3D mchp_pit64b_init_mode(&timer, MCHP_PIT64B_DEF_FREQ);
 	if (ret)
 		goto irq_unmap;
=20
diff --git a/drivers/clocksource/timer-of.c b/drivers/clocksource/timer-of.c
index 529cc6a51cdb..c3f54d9912be 100644
--- a/drivers/clocksource/timer-of.c
+++ b/drivers/clocksource/timer-of.c
@@ -157,9 +157,9 @@ static __init int timer_of_base_init(struct device_node *=
np,
 	of_base->base =3D of_base->name ?
 		of_io_request_and_map(np, of_base->index, of_base->name) :
 		of_iomap(np, of_base->index);
-	if (IS_ERR(of_base->base)) {
-		pr_err("Failed to iomap (%s)\n", of_base->name);
-		return PTR_ERR(of_base->base);
+	if (IS_ERR_OR_NULL(of_base->base)) {
+		pr_err("Failed to iomap (%s:%s)\n", np->name, of_base->name);
+		return of_base->base ? PTR_ERR(of_base->base) : -ENOMEM;
 	}
=20
 	return 0;
diff --git a/drivers/clocksource/timer-ti-dm-systimer.c b/drivers/clocksource=
/timer-ti-dm-systimer.c
index 5c40ca1d4740..f19a1f0bb432 100644
--- a/drivers/clocksource/timer-ti-dm-systimer.c
+++ b/drivers/clocksource/timer-ti-dm-systimer.c
@@ -695,9 +695,9 @@ static int __init dmtimer_percpu_quirk_init(struct device=
_node *np, u32 pa)
 		return 0;
 	}
=20
-	if (pa =3D=3D 0x48034000)		/* dra7 dmtimer3 */
+	if (pa =3D=3D 0x4882c000)           /* dra7 dmtimer15 */
 		return dmtimer_percpu_timer_init(np, 0);
-	else if (pa =3D=3D 0x48036000)	/* dra7 dmtimer4 */
+	else if (pa =3D=3D 0x4882e000)      /* dra7 dmtimer16 */
 		return dmtimer_percpu_timer_init(np, 1);
=20
 	return 0;
diff --git a/include/clocksource/arm_arch_timer.h b/include/clocksource/arm_a=
rch_timer.h
index e715bdb720d5..057c8964aefb 100644
--- a/include/clocksource/arm_arch_timer.h
+++ b/include/clocksource/arm_arch_timer.h
@@ -56,6 +56,7 @@ enum arch_timer_spi_nr {
 #define ARCH_TIMER_EVT_TRIGGER_MASK	(0xF << ARCH_TIMER_EVT_TRIGGER_SHIFT)
 #define ARCH_TIMER_USR_VT_ACCESS_EN	(1 << 8) /* virtual timer registers */
 #define ARCH_TIMER_USR_PT_ACCESS_EN	(1 << 9) /* physical timer registers */
+#define ARCH_TIMER_EVT_INTERVAL_SCALE	(1 << 17) /* EVNTIS in the ARMv8 ARM */
=20
 #define ARCH_TIMER_EVT_STREAM_PERIOD_US	100
 #define ARCH_TIMER_EVT_STREAM_FREQ				\
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 9367f1cb2e3c..f40754caaefa 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -579,7 +579,16 @@ enum
 	NR_SOFTIRQS
 };
=20
-#define SOFTIRQ_STOP_IDLE_MASK (~(1 << RCU_SOFTIRQ))
+/*
+ * The following vectors can be safely ignored after ksoftirqd is parked:
+ *
+ * _ RCU:
+ * 	1) rcutree_migrate_callbacks() migrates the queue.
+ * 	2) rcu_report_dead() reports the final quiescent states.
+ *
+ * _ IRQ_POLL: irq_poll_cpu_dead() migrates the queue
+ */
+#define SOFTIRQ_HOTPLUG_SAFE_MASK (BIT(RCU_SOFTIRQ) | BIT(IRQ_POLL_SOFTIRQ))
=20
 /* map softirq index to softirq name. update 'softirq_to_name' in
  * kernel/softirq.c when adding a new softirq.
diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
index 858f4d429946..5fed476f977f 100644
--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -64,9 +64,8 @@ static inline void rcu_softirq_qs(void)
 		rcu_tasks_qs(current, (preempt)); \
 	} while (0)
=20
-static inline int rcu_needs_cpu(u64 basemono, u64 *nextevt)
+static inline int rcu_needs_cpu(void)
 {
-	*nextevt =3D KTIME_MAX;
 	return 0;
 }
=20
diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index 53209d669400..6cc91291d078 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -19,7 +19,7 @@
=20
 void rcu_softirq_qs(void);
 void rcu_note_context_switch(bool preempt);
-int rcu_needs_cpu(u64 basem, u64 *nextevt);
+int rcu_needs_cpu(void);
 void rcu_cpu_stall_reset(void);
=20
 /*
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index a4c25a6283b0..80faf2273ce9 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1086,9 +1086,8 @@ void rcu_irq_enter_irqson(void)
  * Just check whether or not this CPU has non-offloaded RCU callbacks
  * queued.
  */
-int rcu_needs_cpu(u64 basemono, u64 *nextevt)
+int rcu_needs_cpu(void)
 {
-	*nextevt =3D KTIME_MAX;
 	return !rcu_segcblist_empty(&this_cpu_ptr(&rcu_data)->cblist) &&
 		!rcu_rdp_is_offloaded(this_cpu_ptr(&rcu_data));
 }
diff --git a/kernel/time/Kconfig b/kernel/time/Kconfig
index 04bfd62f5e5c..27b7868b5c30 100644
--- a/kernel/time/Kconfig
+++ b/kernel/time/Kconfig
@@ -181,5 +181,14 @@ config HIGH_RES_TIMERS
 	  hardware is not capable then this option only increases
 	  the size of the kernel image.
=20
+config CLOCKSOURCE_WATCHDOG_MAX_SKEW_US
+	int "Clocksource watchdog maximum allowable skew (in =CE=BCs)"
+	depends on CLOCKSOURCE_WATCHDOG
+	range 50 1000
+	default 100
+	help
+	  Specify the maximum amount of allowable watchdog skew in
+	  microseconds before reporting the clocksource to be unstable.
+
 endmenu
 endif
diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 1cf73807b450..95d7ca35bdf2 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -107,7 +107,13 @@ static u64 suspend_start;
  * This delay could be due to SMIs, NMIs, or to VCPU preemptions.  Used as
  * a lower bound for cs->uncertainty_margin values when registering clocks.
  */
-#define WATCHDOG_MAX_SKEW (100 * NSEC_PER_USEC)
+#ifdef CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US
+#define MAX_SKEW_USEC	CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US
+#else
+#define MAX_SKEW_USEC	100
+#endif
+
+#define WATCHDOG_MAX_SKEW (MAX_SKEW_USEC * NSEC_PER_USEC)
=20
 #ifdef CONFIG_CLOCKSOURCE_WATCHDOG
 static void clocksource_watchdog_work(struct work_struct *work);
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 17a283ce2b20..2d76c91b85de 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -169,6 +169,8 @@ static ktime_t tick_init_jiffy_update(void)
 	return period;
 }
=20
+#define MAX_STALLED_JIFFIES 5
+
 static void tick_sched_do_timer(struct tick_sched *ts, ktime_t now)
 {
 	int cpu =3D smp_processor_id();
@@ -196,6 +198,21 @@ static void tick_sched_do_timer(struct tick_sched *ts, k=
time_t now)
 	if (tick_do_timer_cpu =3D=3D cpu)
 		tick_do_update_jiffies64(now);
=20
+	/*
+	 * If jiffies update stalled for too long (timekeeper in stop_machine()
+	 * or VMEXIT'ed for several msecs), force an update.
+	 */
+	if (ts->last_tick_jiffies !=3D jiffies) {
+		ts->stalled_jiffies =3D 0;
+		ts->last_tick_jiffies =3D READ_ONCE(jiffies);
+	} else {
+		if (++ts->stalled_jiffies =3D=3D MAX_STALLED_JIFFIES) {
+			tick_do_update_jiffies64(now);
+			ts->stalled_jiffies =3D 0;
+			ts->last_tick_jiffies =3D READ_ONCE(jiffies);
+		}
+	}
+
 	if (ts->inidle)
 		ts->got_idle_tick =3D 1;
 }
@@ -768,7 +785,7 @@ static inline bool local_timer_softirq_pending(void)
=20
 static ktime_t tick_nohz_next_event(struct tick_sched *ts, int cpu)
 {
-	u64 basemono, next_tick, next_tmr, next_rcu, delta, expires;
+	u64 basemono, next_tick, delta, expires;
 	unsigned long basejiff;
 	unsigned int seq;
=20
@@ -791,7 +808,7 @@ static ktime_t tick_nohz_next_event(struct tick_sched *ts=
, int cpu)
 	 * minimal delta which brings us back to this place
 	 * immediately. Lather, rinse and repeat...
 	 */
-	if (rcu_needs_cpu(basemono, &next_rcu) || arch_needs_cpu() ||
+	if (rcu_needs_cpu() || arch_needs_cpu() ||
 	    irq_work_needs_cpu() || local_timer_softirq_pending()) {
 		next_tick =3D basemono + TICK_NSEC;
 	} else {
@@ -802,10 +819,8 @@ static ktime_t tick_nohz_next_event(struct tick_sched *t=
s, int cpu)
 		 * disabled this also looks at the next expiring
 		 * hrtimer.
 		 */
-		next_tmr =3D get_next_timer_interrupt(basejiff, basemono);
-		ts->next_timer =3D next_tmr;
-		/* Take the next rcu event into account */
-		next_tick =3D next_rcu < next_tmr ? next_rcu : next_tmr;
+		next_tick =3D get_next_timer_interrupt(basejiff, basemono);
+		ts->next_timer =3D next_tick;
 	}
=20
 	/*
@@ -984,6 +999,45 @@ static void tick_nohz_full_update_tick(struct tick_sched=
 *ts)
 	__tick_nohz_full_update_tick(ts, ktime_get());
 }
=20
+/*
+ * A pending softirq outside an IRQ (or softirq disabled section) context
+ * should be waiting for ksoftirqd to handle it. Therefore we shouldn't
+ * reach here due to the need_resched() early check in can_stop_idle_tick().
+ *
+ * However if we are between CPUHP_AP_SMPBOOT_THREADS and CPU_TEARDOWN_CPU o=
n the
+ * cpu_down() process, softirqs can still be raised while ksoftirqd is parke=
d,
+ * triggering the below since wakep_softirqd() is ignored.
+ *
+ */
+static bool report_idle_softirq(void)
+{
+	static int ratelimit;
+	unsigned int pending =3D local_softirq_pending();
+
+	if (likely(!pending))
+		return false;
+
+	/* Some softirqs claim to be safe against hotplug and ksoftirqd parking */
+	if (!cpu_active(smp_processor_id())) {
+		pending &=3D ~SOFTIRQ_HOTPLUG_SAFE_MASK;
+		if (!pending)
+			return false;
+	}
+
+	if (ratelimit < 10)
+		return false;
+
+	/* On RT, softirqs handling may be waiting on some lock */
+	if (!local_bh_blocked())
+		return false;
+
+	pr_warn("NOHZ tick-stop error: local softirq work is pending, handler #%02x=
!!!\n",
+		pending);
+	ratelimit++;
+
+	return true;
+}
+
 static bool can_stop_idle_tick(int cpu, struct tick_sched *ts)
 {
 	/*
@@ -1010,17 +1064,8 @@ static bool can_stop_idle_tick(int cpu, struct tick_sc=
hed *ts)
 	if (need_resched())
 		return false;
=20
-	if (unlikely(local_softirq_pending())) {
-		static int ratelimit;
-
-		if (ratelimit < 10 && !local_bh_blocked() &&
-		    (local_softirq_pending() & SOFTIRQ_STOP_IDLE_MASK)) {
-			pr_warn("NOHZ tick-stop error: Non-RCU local softirq work is pending, han=
dler #%02x!!!\n",
-				(unsigned int) local_softirq_pending());
-			ratelimit++;
-		}
+	if (unlikely(report_idle_softirq()))
 		return false;
-	}
=20
 	if (tick_nohz_full_enabled()) {
 		/*
diff --git a/kernel/time/tick-sched.h b/kernel/time/tick-sched.h
index d952ae393423..504649513399 100644
--- a/kernel/time/tick-sched.h
+++ b/kernel/time/tick-sched.h
@@ -49,6 +49,8 @@ enum tick_nohz_mode {
  * @timer_expires_base:	Base time clock monotonic for @timer_expires
  * @next_timer:		Expiry time of next expiring timer for debugging purpose on=
ly
  * @tick_dep_mask:	Tick dependency mask - is set, if someone needs the tick
+ * @last_tick_jiffies:	Value of jiffies seen on last tick
+ * @stalled_jiffies:	Number of stalled jiffies detected across ticks
  */
 struct tick_sched {
 	struct hrtimer			sched_timer;
@@ -77,6 +79,8 @@ struct tick_sched {
 	u64				next_timer;
 	ktime_t				idle_expires;
 	atomic_t			tick_dep_mask;
+	unsigned long			last_tick_jiffies;
+	unsigned int			stalled_jiffies;
 };
=20
 extern struct tick_sched *tick_get_tick_sched(int cpu);

