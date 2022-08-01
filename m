Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10136586D38
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 16:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232999AbiHAOsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 10:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbiHAOsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 10:48:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 070EA3C8C1
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 07:48:06 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659365284;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=JN5Yu4EB2IMiBPrhl/LVJFGeYlU8Sy0I7HC+ycze+R8=;
        b=Czk/KibLF8S8hYjlrGmJdthG2rVcQ9gTJcDZBdQ3QkZyHGkpxs8MFYkoyJAQ6cHwPUPQHD
        ibmTi7EmLwLTk9XiflodupYbcZDQoo6rdJHE/IhJWrgYPc7blAiSbum8QsVu6kt1ZkbChK
        VbkEGbMniBv4AspTMOlvkbcJLhp4kYc/OCiUaK0GgjjBYJmw/0TC9yyvUA+SLRp6ceFGnV
        2Eo63FvsIbMNuRpmy/cL7mCtXeM2ISko0PDMGH/hqHuP1kXMqIBekffS9yOrYSdzd8+va4
        DcS7RGTrJyPOouXHz+cC/Pl9ffbmZHbknUroMFdd8Qg9uuUFd3q5fSbQmO6sNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659365284;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=JN5Yu4EB2IMiBPrhl/LVJFGeYlU8Sy0I7HC+ycze+R8=;
        b=n3mmcKh3AbzNKtshN4NIL+PcEHTksZn2xawROsN2JMt7wdAWNFZPSUdZ6NKZVPddUs8/Jo
        NvqLPGT5XRzK4NCw==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] timers/core for v6.0-rc1
References: <165936521992.1709539.10227752058452220355.tglx@xen13.tec.linutronix.de>
Message-ID: <165936522118.1709539.13739925223035696779.tglx@xen13.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Mon,  1 Aug 2022 16:48:04 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest timers/core branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-2022=
-08-01

up to:  cceeeb6a6d02: wait: Fix __wait_event_hrtimeout for RT/DL tasks

Timers, timekeeping and related drivers update:

 core:
   - Make wait_event_hrtimeout() ware of RT/DL tasks

 drivers:
   - New driver for the R-Car Gen4 timer
   - New driver for the Tegra186 timer
   - New driver for the Mediatek MT6795 CPUXGPT timer

   - Rework suspend/resume handling in timer drivers so it
     takes inactive clocks into account.

   - The usual device tree compatible add ons

   - Small fixed and cleanups all over the place

Thanks,

	tglx

------------------>
AngeloGioacchino Del Regno (2):
      dt-bindings: timer: mediatek: Add CPUX System Timer and MT6795 compatib=
le
      clocksource/drivers/timer-mediatek: Implement CPUXGPT timers

Claudiu Beznea (3):
      clocksource/drivers/timer-microchip-pit64b: Remove suspend/resume ops f=
or ce
      clocksource/drivers/timer-microchip-pit64b: Use mchp_pit64b_{suspend, r=
esume}
      clocksource/drivers/timer-microchip-pit64b: Fix compilation warnings

Daniel Lezcano (1):
      clocksource/drivers/tegra186: Put Kconfig option 'tristate' to 'bool'

Geert Uytterhoeven (1):
      dt-bindings: timer: renesas,cmt: Fix R-Car Gen4 fall-out

Juri Lelli (1):
      wait: Fix __wait_event_hrtimeout for RT/DL tasks

Kartik (1):
      clocksource/drivers/timer-tegra186: Add support for Tegra234 SoC

Krzysztof Kozlowski (1):
      dt-bindings: timer: ingenic,tcu: use absolute path to other schema

Li zeming (1):
      clocksource/drivers/sun5i: Remove unnecessary (void*) conversions

Linus Walleij (1):
      dt-bindings: timer: Add Nomadik MTU binding

Randy Dunlap (1):
      clocksource/drivers/arm_global_timer: Fix Kconfig "its" grammar

Samuel Holland (1):
      dt-bindings: timer: allwinner,sun4i-a10-timer: Add D1 compatible

Thierry Reding (1):
      clocksource: Add Tegra186 timers support

Tony Lindgren (4):
      clocksource/drivers/timer-ti-dm: Move inline functions to driver for am6
      clocksource/drivers/timer-ti-dm: Make timer selectable for ARCH_K3
      clocksource/drivers/timer-ti-dm: Add compatible for am6 SoCs
      clocksource/drivers/timer-ti-dm: Make driver selection bool for TI K3

Wolfram Sang (4):
      thermal/drivers/rcar_gen3_thermal: Add r8a779f0 support
      dt-bindings: timer: renesas,cmt: Add r8a779f0 and generic Gen4 CMT supp=
ort
      dt-bindings: timer: renesas,cmt: R-Car V3U is R-Car Gen4
      clocksource/drivers/sh_cmt: Add R-Car Gen4 support

XU pengfei (1):
      clocksource/drivers/sun4i: Remove unnecessary (void*) conversions


 .../bindings/timer/allwinner,sun4i-a10-timer.yaml  |   1 +
 .../devicetree/bindings/timer/ingenic,tcu.yaml     |   4 +-
 .../bindings/timer/mediatek,mtk-timer.txt          |   6 +-
 .../devicetree/bindings/timer/renesas,cmt.yaml     |  16 +-
 .../devicetree/bindings/timer/st,nomadik-mtu.yaml  |  58 +++
 arch/arm/mach-omap2/Kconfig                        |   2 +
 drivers/clocksource/Kconfig                        |  19 +-
 drivers/clocksource/Makefile                       |   3 +-
 drivers/clocksource/sh_cmt.c                       |   8 +
 drivers/clocksource/timer-mediatek.c               | 114 +++++
 drivers/clocksource/timer-microchip-pit64b.c       |  64 ++-
 drivers/clocksource/timer-sun4i.c                  |   2 +-
 drivers/clocksource/timer-sun5i.c                  |   2 +-
 drivers/clocksource/timer-tegra186.c               | 514 +++++++++++++++++++=
++
 drivers/clocksource/timer-ti-dm.c                  | 123 +++++
 drivers/thermal/rcar_gen3_thermal.c                |   4 +
 include/clocksource/timer-ti-dm.h                  | 144 ------
 include/linux/wait.h                               |   9 +-
 18 files changed, 898 insertions(+), 195 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/timer/st,nomadik-mtu.ya=
ml
 create mode 100644 drivers/clocksource/timer-tegra186.c

diff --git a/Documentation/devicetree/bindings/timer/allwinner,sun4i-a10-time=
r.yaml b/Documentation/devicetree/bindings/timer/allwinner,sun4i-a10-timer.ya=
ml
index 53fd24bdc34e..3711872b6b99 100644
--- a/Documentation/devicetree/bindings/timer/allwinner,sun4i-a10-timer.yaml
+++ b/Documentation/devicetree/bindings/timer/allwinner,sun4i-a10-timer.yaml
@@ -20,6 +20,7 @@ properties:
           - allwinner,suniv-f1c100s-timer
       - items:
           - enum:
+              - allwinner,sun20i-d1-timer
               - allwinner,sun50i-a64-timer
               - allwinner,sun50i-h6-timer
               - allwinner,sun50i-h616-timer
diff --git a/Documentation/devicetree/bindings/timer/ingenic,tcu.yaml b/Docum=
entation/devicetree/bindings/timer/ingenic,tcu.yaml
index d541cf2067bc..0a01e4f5eddb 100644
--- a/Documentation/devicetree/bindings/timer/ingenic,tcu.yaml
+++ b/Documentation/devicetree/bindings/timer/ingenic,tcu.yaml
@@ -113,7 +113,7 @@ properties:
 patternProperties:
   "^watchdog@[a-f0-9]+$":
     type: object
-    $ref: ../watchdog/watchdog.yaml#
+    $ref: /schemas/watchdog/watchdog.yaml#
     properties:
       compatible:
         oneOf:
@@ -145,7 +145,7 @@ patternProperties:
=20
   "^pwm@[a-f0-9]+$":
     type: object
-    $ref: ../pwm/pwm.yaml#
+    $ref: /schemas/pwm/pwm.yaml#
     properties:
       compatible:
         oneOf:
diff --git a/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt b=
/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
index 6f1f9dba6e88..f1c848af91d3 100644
--- a/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
+++ b/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
@@ -1,7 +1,8 @@
 MediaTek Timers
 ---------------
=20
-MediaTek SoCs have two different timers on different platforms,
+MediaTek SoCs have different timers on different platforms,
+- CPUX (ARM/ARM64 System Timer)
 - GPT (General Purpose Timer)
 - SYST (System Timer)
=20
@@ -29,6 +30,9 @@ Required properties:
 	* "mediatek,mt7629-timer" for MT7629 compatible timers (SYST)
 	* "mediatek,mt6765-timer" for MT6765 and all above compatible timers (SYST)
=20
+	For those SoCs that use CPUX
+	* "mediatek,mt6795-systimer" for MT6795 compatible timers (CPUX)
+
 - reg: Should contain location and length for timer register.
 - clocks: Should contain system clock.
=20
diff --git a/Documentation/devicetree/bindings/timer/renesas,cmt.yaml b/Docum=
entation/devicetree/bindings/timer/renesas,cmt.yaml
index 53dd6d9f518f..bde6c9b66bf4 100644
--- a/Documentation/devicetree/bindings/timer/renesas,cmt.yaml
+++ b/Documentation/devicetree/bindings/timer/renesas,cmt.yaml
@@ -80,7 +80,6 @@ properties:
               - renesas,r8a77980-cmt0     # 32-bit CMT0 on R-Car V3H
               - renesas,r8a77990-cmt0     # 32-bit CMT0 on R-Car E3
               - renesas,r8a77995-cmt0     # 32-bit CMT0 on R-Car D3
-              - renesas,r8a779a0-cmt0     # 32-bit CMT0 on R-Car V3U
           - const: renesas,rcar-gen3-cmt0 # 32-bit CMT0 on R-Car Gen3 and RZ=
/G2
=20
       - items:
@@ -97,9 +96,20 @@ properties:
               - renesas,r8a77980-cmt1     # 48-bit CMT on R-Car V3H
               - renesas,r8a77990-cmt1     # 48-bit CMT on R-Car E3
               - renesas,r8a77995-cmt1     # 48-bit CMT on R-Car D3
-              - renesas,r8a779a0-cmt1     # 48-bit CMT on R-Car V3U
           - const: renesas,rcar-gen3-cmt1 # 48-bit CMT on R-Car Gen3 and RZ/=
G2
=20
+      - items:
+          - enum:
+              - renesas,r8a779a0-cmt0     # 32-bit CMT0 on R-Car V3U
+              - renesas,r8a779f0-cmt0     # 32-bit CMT0 on R-Car S4-8
+          - const: renesas,rcar-gen4-cmt0 # 32-bit CMT0 on R-Car Gen4
+
+      - items:
+          - enum:
+              - renesas,r8a779a0-cmt1     # 48-bit CMT on R-Car V3U
+              - renesas,r8a779f0-cmt1     # 48-bit CMT on R-Car S4-8
+          - const: renesas,rcar-gen4-cmt1 # 48-bit CMT on R-Car Gen4
+
   reg:
     maxItems: 1
=20
@@ -135,6 +145,7 @@ allOf:
             enum:
               - renesas,rcar-gen2-cmt0
               - renesas,rcar-gen3-cmt0
+              - renesas,rcar-gen4-cmt0
     then:
       properties:
         interrupts:
@@ -148,6 +159,7 @@ allOf:
             enum:
               - renesas,rcar-gen2-cmt1
               - renesas,rcar-gen3-cmt1
+              - renesas,rcar-gen4-cmt1
     then:
       properties:
         interrupts:
diff --git a/Documentation/devicetree/bindings/timer/st,nomadik-mtu.yaml b/Do=
cumentation/devicetree/bindings/timer/st,nomadik-mtu.yaml
new file mode 100644
index 000000000000..901848d298ec
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/st,nomadik-mtu.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2022 Linaro Ltd.
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/timer/st,nomadik-mtu.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: ST Microelectronics Nomadik Multi-Timer Unit MTU Timer
+
+maintainers:
+  - Linus Walleij <linus.walleij@linaro.org>
+
+description: This timer is found in the ST Microelectronics Nomadik
+  SoCs STn8800, STn8810 and STn8815 as well as in ST-Ericsson DB8500.
+
+properties:
+  compatible:
+    items:
+      - const: st,nomadik-mtu
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    description: The first clock named TIMCLK clocks the actual timers and
+      the second clock clocks the digital interface to the interconnect.
+    maxItems: 2
+
+  clock-names:
+    items:
+      - const: timclk
+      - const: apb_pclk
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/mfd/dbx500-prcmu.h>
+    timer@a03c6000 {
+      compatible =3D "st,nomadik-mtu";
+      reg =3D <0xa03c6000 0x1000>;
+      interrupts =3D <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
+
+      clocks =3D <&prcmu_clk PRCMU_TIMCLK>, <&prcc_pclk 6 6>;
+      clock-names =3D "timclk", "apb_pclk";
+    };
diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index a8adbb4d478a..f7f940282c3f 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -105,6 +105,7 @@ config ARCH_OMAP2PLUS
 	select MACH_OMAP_GENERIC
 	select MEMORY
 	select MFD_SYSCON
+	select OMAP_DM_SYSTIMER
 	select OMAP_DM_TIMER
 	select OMAP_GPMC
 	select PINCTRL
@@ -209,6 +210,7 @@ config SOC_OMAP2420
 	bool "OMAP2420 support"
 	depends on ARCH_OMAP2
 	default y
+	select OMAP_DM_SYSTIMER
 	select OMAP_DM_TIMER
 	select SOC_HAS_OMAP2_SDRC
=20
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 3c0ee102fe73..4f2bb7315b67 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -22,7 +22,7 @@ config CLKEVT_I8253
 config I8253_LOCK
 	bool
=20
-config OMAP_DM_TIMER
+config OMAP_DM_SYSTIMER
 	bool
 	select TIMER_OF
=20
@@ -56,6 +56,13 @@ config DIGICOLOR_TIMER
 	help
 	  Enables the support for the digicolor timer driver.
=20
+config OMAP_DM_TIMER
+	bool "OMAP dual-mode timer driver" if ARCH_K3 || COMPILE_TEST
+	default y if ARCH_K3
+	select TIMER_OF
+	help
+	  Enables the support for the TI dual-mode timer driver.
+
 config DW_APB_TIMER
 	bool "DW APB timer driver" if COMPILE_TEST
 	help
@@ -150,6 +157,14 @@ config TEGRA_TIMER
 	help
 	  Enables support for the Tegra driver.
=20
+config TEGRA186_TIMER
+	bool "NVIDIA Tegra186 timer driver"
+	depends on ARCH_TEGRA || COMPILE_TEST
+	depends on WATCHDOG && WATCHDOG_CORE
+	help
+	  Enables support for the timers and watchdogs found on NVIDIA
+	  Tegra186 and later SoCs.
+
 config VT8500_TIMER
 	bool "VT8500 timer driver" if COMPILE_TEST
 	depends on HAS_IOMEM
@@ -367,7 +382,7 @@ config ARM_GT_INITIAL_PRESCALER_VAL
 	depends on ARM_GLOBAL_TIMER
 	help
 	  When the ARM global timer initializes, its current rate is declared
-	  to the kernel and maintained forever. Should it's parent clock
+	  to the kernel and maintained forever. Should its parent clock
 	  change, the driver tries to fix the timer's internal prescaler.
 	  On some machs (i.e. Zynq) the initial prescaler value thus poses
 	  bounds about how much the parent clock is allowed to decrease or
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 6ca640019e10..64ab547de97b 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -18,7 +18,7 @@ obj-$(CONFIG_CLKSRC_MMIO)	+=3D mmio.o
 obj-$(CONFIG_DAVINCI_TIMER)	+=3D timer-davinci.o
 obj-$(CONFIG_DIGICOLOR_TIMER)	+=3D timer-digicolor.o
 obj-$(CONFIG_OMAP_DM_TIMER)	+=3D timer-ti-dm.o
-obj-$(CONFIG_OMAP_DM_TIMER)	+=3D timer-ti-dm-systimer.o
+obj-$(CONFIG_OMAP_DM_SYSTIMER)	+=3D timer-ti-dm-systimer.o
 obj-$(CONFIG_DW_APB_TIMER)	+=3D dw_apb_timer.o
 obj-$(CONFIG_DW_APB_TIMER_OF)	+=3D dw_apb_timer_of.o
 obj-$(CONFIG_FTTMR010_TIMER)	+=3D timer-fttmr010.o
@@ -36,6 +36,7 @@ obj-$(CONFIG_SUN4I_TIMER)	+=3D timer-sun4i.o
 obj-$(CONFIG_SUN5I_HSTIMER)	+=3D timer-sun5i.o
 obj-$(CONFIG_MESON6_TIMER)	+=3D timer-meson6.o
 obj-$(CONFIG_TEGRA_TIMER)	+=3D timer-tegra.o
+obj-$(CONFIG_TEGRA186_TIMER)	+=3D timer-tegra186.o
 obj-$(CONFIG_VT8500_TIMER)	+=3D timer-vt8500.o
 obj-$(CONFIG_NSPIRE_TIMER)	+=3D timer-zevio.o
 obj-$(CONFIG_BCM_KONA_TIMER)	+=3D bcm_kona_timer.o
diff --git a/drivers/clocksource/sh_cmt.c b/drivers/clocksource/sh_cmt.c
index dd0956ad969c..64dcb082d4cf 100644
--- a/drivers/clocksource/sh_cmt.c
+++ b/drivers/clocksource/sh_cmt.c
@@ -981,6 +981,14 @@ static const struct of_device_id sh_cmt_of_table[] __may=
be_unused =3D {
 		.compatible =3D "renesas,rcar-gen3-cmt1",
 		.data =3D &sh_cmt_info[SH_CMT1_RCAR_GEN2]
 	},
+	{
+		.compatible =3D "renesas,rcar-gen4-cmt0",
+		.data =3D &sh_cmt_info[SH_CMT0_RCAR_GEN2]
+	},
+	{
+		.compatible =3D "renesas,rcar-gen4-cmt1",
+		.data =3D &sh_cmt_info[SH_CMT1_RCAR_GEN2]
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, sh_cmt_of_table);
diff --git a/drivers/clocksource/timer-mediatek.c b/drivers/clocksource/timer=
-mediatek.c
index 7bcb4a3f26fb..d5b29fd03ca2 100644
--- a/drivers/clocksource/timer-mediatek.c
+++ b/drivers/clocksource/timer-mediatek.c
@@ -22,6 +22,19 @@
=20
 #define TIMER_SYNC_TICKS        (3)
=20
+/* cpux mcusys wrapper */
+#define CPUX_CON_REG		0x0
+#define CPUX_IDX_REG		0x4
+
+/* cpux */
+#define CPUX_IDX_GLOBAL_CTRL	0x0
+ #define CPUX_ENABLE		BIT(0)
+ #define CPUX_CLK_DIV_MASK	GENMASK(10, 8)
+ #define CPUX_CLK_DIV1		BIT(8)
+ #define CPUX_CLK_DIV2		BIT(9)
+ #define CPUX_CLK_DIV4		BIT(10)
+#define CPUX_IDX_GLOBAL_IRQ	0x30
+
 /* gpt */
 #define GPT_IRQ_EN_REG          0x00
 #define GPT_IRQ_ENABLE(val)     BIT((val) - 1)
@@ -72,6 +85,52 @@
=20
 static void __iomem *gpt_sched_reg __read_mostly;
=20
+static u32 mtk_cpux_readl(u32 reg_idx, struct timer_of *to)
+{
+	writel(reg_idx, timer_of_base(to) + CPUX_IDX_REG);
+	return readl(timer_of_base(to) + CPUX_CON_REG);
+}
+
+static void mtk_cpux_writel(u32 val, u32 reg_idx, struct timer_of *to)
+{
+	writel(reg_idx, timer_of_base(to) + CPUX_IDX_REG);
+	writel(val, timer_of_base(to) + CPUX_CON_REG);
+}
+
+static void mtk_cpux_set_irq(struct timer_of *to, bool enable)
+{
+	const unsigned long *irq_mask =3D cpumask_bits(cpu_possible_mask);
+	u32 val;
+
+	val =3D mtk_cpux_readl(CPUX_IDX_GLOBAL_IRQ, to);
+
+	if (enable)
+		val |=3D *irq_mask;
+	else
+		val &=3D ~(*irq_mask);
+
+	mtk_cpux_writel(val, CPUX_IDX_GLOBAL_IRQ, to);
+}
+
+static int mtk_cpux_clkevt_shutdown(struct clock_event_device *clkevt)
+{
+	/* Clear any irq */
+	mtk_cpux_set_irq(to_timer_of(clkevt), false);
+
+	/*
+	 * Disabling CPUXGPT timer will crash the platform, especially
+	 * if Trusted Firmware is using it (usually, for sleep states),
+	 * so we only mask the IRQ and call it a day.
+	 */
+	return 0;
+}
+
+static int mtk_cpux_clkevt_resume(struct clock_event_device *clkevt)
+{
+	mtk_cpux_set_irq(to_timer_of(clkevt), true);
+	return 0;
+}
+
 static void mtk_syst_ack_irq(struct timer_of *to)
 {
 	/* Clear and disable interrupt */
@@ -281,6 +340,60 @@ static struct timer_of to =3D {
 	},
 };
=20
+static int __init mtk_cpux_init(struct device_node *node)
+{
+	static struct timer_of to_cpux;
+	u32 freq, val;
+	int ret;
+
+	/*
+	 * There are per-cpu interrupts for the CPUX General Purpose Timer
+	 * but since this timer feeds the AArch64 System Timer we can rely
+	 * on the CPU timer PPIs as well, so we don't declare TIMER_OF_IRQ.
+	 */
+	to_cpux.flags =3D TIMER_OF_BASE | TIMER_OF_CLOCK;
+	to_cpux.clkevt.name =3D "mtk-cpuxgpt";
+	to_cpux.clkevt.rating =3D 10;
+	to_cpux.clkevt.cpumask =3D cpu_possible_mask;
+	to_cpux.clkevt.set_state_shutdown =3D mtk_cpux_clkevt_shutdown;
+	to_cpux.clkevt.tick_resume =3D mtk_cpux_clkevt_resume;
+
+	/* If this fails, bad things are about to happen... */
+	ret =3D timer_of_init(node, &to_cpux);
+	if (ret) {
+		WARN(1, "Cannot start CPUX timers.\n");
+		return ret;
+	}
+
+	/*
+	 * Check if we're given a clock with the right frequency for this
+	 * timer, otherwise warn but keep going with the setup anyway, as
+	 * that makes it possible to still boot the kernel, even though
+	 * it may not work correctly (random lockups, etc).
+	 * The reason behind this is that having an early UART may not be
+	 * possible for everyone and this gives a chance to retrieve kmsg
+	 * for eventual debugging even on consumer devices.
+	 */
+	freq =3D timer_of_rate(&to_cpux);
+	if (freq > 13000000)
+		WARN(1, "Requested unsupported timer frequency %u\n", freq);
+
+	/* Clock input is 26MHz, set DIV2 to achieve 13MHz clock */
+	val =3D mtk_cpux_readl(CPUX_IDX_GLOBAL_CTRL, &to_cpux);
+	val &=3D ~CPUX_CLK_DIV_MASK;
+	val |=3D CPUX_CLK_DIV2;
+	mtk_cpux_writel(val, CPUX_IDX_GLOBAL_CTRL, &to_cpux);
+
+	/* Enable all CPUXGPT timers */
+	val =3D mtk_cpux_readl(CPUX_IDX_GLOBAL_CTRL, &to_cpux);
+	mtk_cpux_writel(val | CPUX_ENABLE, CPUX_IDX_GLOBAL_CTRL, &to_cpux);
+
+	clockevents_config_and_register(&to_cpux.clkevt, timer_of_rate(&to_cpux),
+					TIMER_SYNC_TICKS, 0xffffffff);
+
+	return 0;
+}
+
 static int __init mtk_syst_init(struct device_node *node)
 {
 	int ret;
@@ -339,3 +452,4 @@ static int __init mtk_gpt_init(struct device_node *node)
 }
 TIMER_OF_DECLARE(mtk_mt6577, "mediatek,mt6577-timer", mtk_gpt_init);
 TIMER_OF_DECLARE(mtk_mt6765, "mediatek,mt6765-timer", mtk_syst_init);
+TIMER_OF_DECLARE(mtk_mt6795, "mediatek,mt6795-systimer", mtk_cpux_init);
diff --git a/drivers/clocksource/timer-microchip-pit64b.c b/drivers/clocksour=
ce/timer-microchip-pit64b.c
index abce83d2f00b..d5f1436f33d9 100644
--- a/drivers/clocksource/timer-microchip-pit64b.c
+++ b/drivers/clocksource/timer-microchip-pit64b.c
@@ -61,7 +61,7 @@ struct mchp_pit64b_timer {
 };
=20
 /**
- * mchp_pit64b_clkevt - PIT64B clockevent data structure
+ * struct mchp_pit64b_clkevt - PIT64B clockevent data structure
  * @timer: PIT64B timer
  * @clkevt: clockevent
  */
@@ -75,7 +75,7 @@ struct mchp_pit64b_clkevt {
 		struct mchp_pit64b_clkevt, clkevt))
=20
 /**
- * mchp_pit64b_clksrc - PIT64B clocksource data structure
+ * struct mchp_pit64b_clksrc - PIT64B clocksource data structure
  * @timer: PIT64B timer
  * @clksrc: clocksource
  */
@@ -173,7 +173,8 @@ static int mchp_pit64b_clkevt_shutdown(struct clock_event=
_device *cedev)
 {
 	struct mchp_pit64b_timer *timer =3D clkevt_to_mchp_pit64b_timer(cedev);
=20
-	writel_relaxed(MCHP_PIT64B_CR_SWRST, timer->base + MCHP_PIT64B_CR);
+	if (!clockevent_state_detached(cedev))
+		mchp_pit64b_suspend(timer);
=20
 	return 0;
 }
@@ -182,35 +183,37 @@ static int mchp_pit64b_clkevt_set_periodic(struct clock=
_event_device *cedev)
 {
 	struct mchp_pit64b_timer *timer =3D clkevt_to_mchp_pit64b_timer(cedev);
=20
+	if (clockevent_state_shutdown(cedev))
+		mchp_pit64b_resume(timer);
+
 	mchp_pit64b_reset(timer, mchp_pit64b_ce_cycles, MCHP_PIT64B_MR_CONT,
 			  MCHP_PIT64B_IER_PERIOD);
=20
 	return 0;
 }
=20
-static int mchp_pit64b_clkevt_set_next_event(unsigned long evt,
-					     struct clock_event_device *cedev)
+static int mchp_pit64b_clkevt_set_oneshot(struct clock_event_device *cedev)
 {
 	struct mchp_pit64b_timer *timer =3D clkevt_to_mchp_pit64b_timer(cedev);
=20
-	mchp_pit64b_reset(timer, evt, MCHP_PIT64B_MR_ONE_SHOT,
+	if (clockevent_state_shutdown(cedev))
+		mchp_pit64b_resume(timer);
+
+	mchp_pit64b_reset(timer, mchp_pit64b_ce_cycles, MCHP_PIT64B_MR_ONE_SHOT,
 			  MCHP_PIT64B_IER_PERIOD);
=20
 	return 0;
 }
=20
-static void mchp_pit64b_clkevt_suspend(struct clock_event_device *cedev)
+static int mchp_pit64b_clkevt_set_next_event(unsigned long evt,
+					     struct clock_event_device *cedev)
 {
 	struct mchp_pit64b_timer *timer =3D clkevt_to_mchp_pit64b_timer(cedev);
=20
-	mchp_pit64b_suspend(timer);
-}
-
-static void mchp_pit64b_clkevt_resume(struct clock_event_device *cedev)
-{
-	struct mchp_pit64b_timer *timer =3D clkevt_to_mchp_pit64b_timer(cedev);
+	mchp_pit64b_reset(timer, evt, MCHP_PIT64B_MR_ONE_SHOT,
+			  MCHP_PIT64B_IER_PERIOD);
=20
-	mchp_pit64b_resume(timer);
+	return 0;
 }
=20
 static irqreturn_t mchp_pit64b_interrupt(int irq, void *dev_id)
@@ -242,8 +245,10 @@ static void __init mchp_pit64b_pres_compute(u32 *pres, u=
32 clk_rate,
 }
=20
 /**
- * mchp_pit64b_init_mode - prepare PIT64B mode register value to be used at
- *			   runtime; this includes prescaler and SGCLK bit
+ * mchp_pit64b_init_mode() - prepare PIT64B mode register value to be used at
+ *			     runtime; this includes prescaler and SGCLK bit
+ * @timer: pointer to pit64b timer to init
+ * @max_rate: maximum rate that timer's clock could use
  *
  * PIT64B timer may be fed by gclk or pclk. When gclk is used its rate has to
  * be at least 3 times lower that pclk's rate. pclk rate is fixed, gclk rate
@@ -341,6 +346,7 @@ static int __init mchp_pit64b_init_clksrc(struct mchp_pit=
64b_timer *timer,
 	if (!cs)
 		return -ENOMEM;
=20
+	mchp_pit64b_resume(timer);
 	mchp_pit64b_reset(timer, ULLONG_MAX, MCHP_PIT64B_MR_CONT, 0);
=20
 	mchp_pit64b_cs_base =3D timer->base;
@@ -362,8 +368,7 @@ static int __init mchp_pit64b_init_clksrc(struct mchp_pit=
64b_timer *timer,
 		pr_debug("clksrc: Failed to register PIT64B clocksource!\n");
=20
 		/* Stop timer. */
-		writel_relaxed(MCHP_PIT64B_CR_SWRST,
-			       timer->base + MCHP_PIT64B_CR);
+		mchp_pit64b_suspend(timer);
 		kfree(cs);
=20
 		return ret;
@@ -395,9 +400,8 @@ static int __init mchp_pit64b_init_clkevt(struct mchp_pit=
64b_timer *timer,
 	ce->clkevt.rating =3D 150;
 	ce->clkevt.set_state_shutdown =3D mchp_pit64b_clkevt_shutdown;
 	ce->clkevt.set_state_periodic =3D mchp_pit64b_clkevt_set_periodic;
+	ce->clkevt.set_state_oneshot =3D mchp_pit64b_clkevt_set_oneshot;
 	ce->clkevt.set_next_event =3D mchp_pit64b_clkevt_set_next_event;
-	ce->clkevt.suspend =3D mchp_pit64b_clkevt_suspend;
-	ce->clkevt.resume =3D mchp_pit64b_clkevt_resume;
 	ce->clkevt.cpumask =3D cpumask_of(0);
 	ce->clkevt.irq =3D irq;
=20
@@ -448,19 +452,10 @@ static int __init mchp_pit64b_dt_init_timer(struct devi=
ce_node *node,
 	if (ret)
 		goto irq_unmap;
=20
-	ret =3D clk_prepare_enable(timer.pclk);
-	if (ret)
-		goto irq_unmap;
-
-	if (timer.mode & MCHP_PIT64B_MR_SGCLK) {
-		ret =3D clk_prepare_enable(timer.gclk);
-		if (ret)
-			goto pclk_unprepare;
-
+	if (timer.mode & MCHP_PIT64B_MR_SGCLK)
 		clk_rate =3D clk_get_rate(timer.gclk);
-	} else {
+	else
 		clk_rate =3D clk_get_rate(timer.pclk);
-	}
 	clk_rate =3D clk_rate / (MCHP_PIT64B_MODE_TO_PRES(timer.mode) + 1);
=20
 	if (clkevt)
@@ -469,15 +464,10 @@ static int __init mchp_pit64b_dt_init_timer(struct devi=
ce_node *node,
 		ret =3D mchp_pit64b_init_clksrc(&timer, clk_rate);
=20
 	if (ret)
-		goto gclk_unprepare;
+		goto irq_unmap;
=20
 	return 0;
=20
-gclk_unprepare:
-	if (timer.mode & MCHP_PIT64B_MR_SGCLK)
-		clk_disable_unprepare(timer.gclk);
-pclk_unprepare:
-	clk_disable_unprepare(timer.pclk);
 irq_unmap:
 	irq_dispose_mapping(irq);
 io_unmap:
diff --git a/drivers/clocksource/timer-sun4i.c b/drivers/clocksource/timer-su=
n4i.c
index bb6ea6c19829..94dc6e42e983 100644
--- a/drivers/clocksource/timer-sun4i.c
+++ b/drivers/clocksource/timer-sun4i.c
@@ -128,7 +128,7 @@ static void sun4i_timer_clear_interrupt(void __iomem *bas=
e)
=20
 static irqreturn_t sun4i_timer_interrupt(int irq, void *dev_id)
 {
-	struct clock_event_device *evt =3D (struct clock_event_device *)dev_id;
+	struct clock_event_device *evt =3D dev_id;
 	struct timer_of *to =3D to_timer_of(evt);
=20
 	sun4i_timer_clear_interrupt(timer_of_base(to));
diff --git a/drivers/clocksource/timer-sun5i.c b/drivers/clocksource/timer-su=
n5i.c
index 85900f7fc69f..7d5fa9069906 100644
--- a/drivers/clocksource/timer-sun5i.c
+++ b/drivers/clocksource/timer-sun5i.c
@@ -142,7 +142,7 @@ static int sun5i_clkevt_next_event(unsigned long evt,
=20
 static irqreturn_t sun5i_timer_interrupt(int irq, void *dev_id)
 {
-	struct sun5i_timer_clkevt *ce =3D (struct sun5i_timer_clkevt *)dev_id;
+	struct sun5i_timer_clkevt *ce =3D dev_id;
=20
 	writel(0x1, ce->timer.base + TIMER_IRQ_ST_REG);
 	ce->clkevt.event_handler(&ce->clkevt);
diff --git a/drivers/clocksource/timer-tegra186.c b/drivers/clocksource/timer=
-tegra186.c
new file mode 100644
index 000000000000..ea742889ee06
--- /dev/null
+++ b/drivers/clocksource/timer-tegra186.c
@@ -0,0 +1,514 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2019-2020 NVIDIA Corporation. All rights reserved.
+ */
+
+#include <linux/clocksource.h>
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/pm.h>
+#include <linux/watchdog.h>
+
+/* shared registers */
+#define TKETSC0 0x000
+#define TKETSC1 0x004
+#define TKEUSEC 0x008
+#define TKEOSC  0x00c
+
+#define TKEIE(x) (0x100 + ((x) * 4))
+#define  TKEIE_WDT_MASK(x, y) ((y) << (16 + 4 * (x)))
+
+/* timer registers */
+#define TMRCR 0x000
+#define  TMRCR_ENABLE BIT(31)
+#define  TMRCR_PERIODIC BIT(30)
+#define  TMRCR_PTV(x) ((x) & 0x0fffffff)
+
+#define TMRSR 0x004
+#define  TMRSR_INTR_CLR BIT(30)
+
+#define TMRCSSR 0x008
+#define  TMRCSSR_SRC_USEC (0 << 0)
+
+/* watchdog registers */
+#define WDTCR 0x000
+#define  WDTCR_SYSTEM_POR_RESET_ENABLE BIT(16)
+#define  WDTCR_SYSTEM_DEBUG_RESET_ENABLE BIT(15)
+#define  WDTCR_REMOTE_INT_ENABLE BIT(14)
+#define  WDTCR_LOCAL_FIQ_ENABLE BIT(13)
+#define  WDTCR_LOCAL_INT_ENABLE BIT(12)
+#define  WDTCR_PERIOD_MASK (0xff << 4)
+#define  WDTCR_PERIOD(x) (((x) & 0xff) << 4)
+#define  WDTCR_TIMER_SOURCE_MASK 0xf
+#define  WDTCR_TIMER_SOURCE(x) ((x) & 0xf)
+
+#define WDTCMDR 0x008
+#define  WDTCMDR_DISABLE_COUNTER BIT(1)
+#define  WDTCMDR_START_COUNTER BIT(0)
+
+#define WDTUR 0x00c
+#define  WDTUR_UNLOCK_PATTERN 0x0000c45a
+
+struct tegra186_timer_soc {
+	unsigned int num_timers;
+	unsigned int num_wdts;
+};
+
+struct tegra186_tmr {
+	struct tegra186_timer *parent;
+	void __iomem *regs;
+	unsigned int index;
+	unsigned int hwirq;
+};
+
+struct tegra186_wdt {
+	struct watchdog_device base;
+
+	void __iomem *regs;
+	unsigned int index;
+	bool locked;
+
+	struct tegra186_tmr *tmr;
+};
+
+static inline struct tegra186_wdt *to_tegra186_wdt(struct watchdog_device *w=
dd)
+{
+	return container_of(wdd, struct tegra186_wdt, base);
+}
+
+struct tegra186_timer {
+	const struct tegra186_timer_soc *soc;
+	struct device *dev;
+	void __iomem *regs;
+
+	struct tegra186_wdt *wdt;
+	struct clocksource usec;
+	struct clocksource tsc;
+	struct clocksource osc;
+};
+
+static void tmr_writel(struct tegra186_tmr *tmr, u32 value, unsigned int off=
set)
+{
+	writel_relaxed(value, tmr->regs + offset);
+}
+
+static void wdt_writel(struct tegra186_wdt *wdt, u32 value, unsigned int off=
set)
+{
+	writel_relaxed(value, wdt->regs + offset);
+}
+
+static u32 wdt_readl(struct tegra186_wdt *wdt, unsigned int offset)
+{
+	return readl_relaxed(wdt->regs + offset);
+}
+
+static struct tegra186_tmr *tegra186_tmr_create(struct tegra186_timer *tegra,
+						unsigned int index)
+{
+	unsigned int offset =3D 0x10000 + index * 0x10000;
+	struct tegra186_tmr *tmr;
+
+	tmr =3D devm_kzalloc(tegra->dev, sizeof(*tmr), GFP_KERNEL);
+	if (!tmr)
+		return ERR_PTR(-ENOMEM);
+
+	tmr->parent =3D tegra;
+	tmr->regs =3D tegra->regs + offset;
+	tmr->index =3D index;
+	tmr->hwirq =3D 0;
+
+	return tmr;
+}
+
+static const struct watchdog_info tegra186_wdt_info =3D {
+	.options =3D WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE | WDIOF_KEEPALIVEPING,
+	.identity =3D "NVIDIA Tegra186 WDT",
+};
+
+static void tegra186_wdt_disable(struct tegra186_wdt *wdt)
+{
+	/* unlock and disable the watchdog */
+	wdt_writel(wdt, WDTUR_UNLOCK_PATTERN, WDTUR);
+	wdt_writel(wdt, WDTCMDR_DISABLE_COUNTER, WDTCMDR);
+
+	/* disable timer */
+	tmr_writel(wdt->tmr, 0, TMRCR);
+}
+
+static void tegra186_wdt_enable(struct tegra186_wdt *wdt)
+{
+	struct tegra186_timer *tegra =3D wdt->tmr->parent;
+	u32 value;
+
+	/* unmask hardware IRQ, this may have been lost across powergate */
+	value =3D TKEIE_WDT_MASK(wdt->index, 1);
+	writel(value, tegra->regs + TKEIE(wdt->tmr->hwirq));
+
+	/* clear interrupt */
+	tmr_writel(wdt->tmr, TMRSR_INTR_CLR, TMRSR);
+
+	/* select microsecond source */
+	tmr_writel(wdt->tmr, TMRCSSR_SRC_USEC, TMRCSSR);
+
+	/* configure timer (system reset happens on the fifth expiration) */
+	value =3D TMRCR_PTV(wdt->base.timeout * USEC_PER_SEC / 5) |
+		TMRCR_PERIODIC | TMRCR_ENABLE;
+	tmr_writel(wdt->tmr, value, TMRCR);
+
+	if (!wdt->locked) {
+		value =3D wdt_readl(wdt, WDTCR);
+
+		/* select the proper timer source */
+		value &=3D ~WDTCR_TIMER_SOURCE_MASK;
+		value |=3D WDTCR_TIMER_SOURCE(wdt->tmr->index);
+
+		/* single timer period since that's already configured */
+		value &=3D ~WDTCR_PERIOD_MASK;
+		value |=3D WDTCR_PERIOD(1);
+
+		/* enable local interrupt for WDT petting */
+		value |=3D WDTCR_LOCAL_INT_ENABLE;
+
+		/* enable local FIQ and remote interrupt for debug dump */
+		if (0)
+			value |=3D WDTCR_REMOTE_INT_ENABLE |
+				 WDTCR_LOCAL_FIQ_ENABLE;
+
+		/* enable system debug reset (doesn't properly reboot) */
+		if (0)
+			value |=3D WDTCR_SYSTEM_DEBUG_RESET_ENABLE;
+
+		/* enable system POR reset */
+		value |=3D WDTCR_SYSTEM_POR_RESET_ENABLE;
+
+		wdt_writel(wdt, value, WDTCR);
+	}
+
+	wdt_writel(wdt, WDTCMDR_START_COUNTER, WDTCMDR);
+}
+
+static int tegra186_wdt_start(struct watchdog_device *wdd)
+{
+	struct tegra186_wdt *wdt =3D to_tegra186_wdt(wdd);
+
+	tegra186_wdt_enable(wdt);
+
+	return 0;
+}
+
+static int tegra186_wdt_stop(struct watchdog_device *wdd)
+{
+	struct tegra186_wdt *wdt =3D to_tegra186_wdt(wdd);
+
+	tegra186_wdt_disable(wdt);
+
+	return 0;
+}
+
+static int tegra186_wdt_ping(struct watchdog_device *wdd)
+{
+	struct tegra186_wdt *wdt =3D to_tegra186_wdt(wdd);
+
+	tegra186_wdt_disable(wdt);
+	tegra186_wdt_enable(wdt);
+
+	return 0;
+}
+
+static int tegra186_wdt_set_timeout(struct watchdog_device *wdd,
+				    unsigned int timeout)
+{
+	struct tegra186_wdt *wdt =3D to_tegra186_wdt(wdd);
+
+	if (watchdog_active(&wdt->base))
+		tegra186_wdt_disable(wdt);
+
+	wdt->base.timeout =3D timeout;
+
+	if (watchdog_active(&wdt->base))
+		tegra186_wdt_enable(wdt);
+
+	return 0;
+}
+
+static const struct watchdog_ops tegra186_wdt_ops =3D {
+	.owner =3D THIS_MODULE,
+	.start =3D tegra186_wdt_start,
+	.stop =3D tegra186_wdt_stop,
+	.ping =3D tegra186_wdt_ping,
+	.set_timeout =3D tegra186_wdt_set_timeout,
+};
+
+static struct tegra186_wdt *tegra186_wdt_create(struct tegra186_timer *tegra,
+						unsigned int index)
+{
+	unsigned int offset =3D 0x10000, source;
+	struct tegra186_wdt *wdt;
+	u32 value;
+	int err;
+
+	offset +=3D tegra->soc->num_timers * 0x10000 + index * 0x10000;
+
+	wdt =3D devm_kzalloc(tegra->dev, sizeof(*wdt), GFP_KERNEL);
+	if (!wdt)
+		return ERR_PTR(-ENOMEM);
+
+	wdt->regs =3D tegra->regs + offset;
+	wdt->index =3D index;
+
+	/* read the watchdog configuration since it might be locked down */
+	value =3D wdt_readl(wdt, WDTCR);
+
+	if (value & WDTCR_LOCAL_INT_ENABLE)
+		wdt->locked =3D true;
+
+	source =3D value & WDTCR_TIMER_SOURCE_MASK;
+
+	wdt->tmr =3D tegra186_tmr_create(tegra, source);
+	if (IS_ERR(wdt->tmr))
+		return ERR_CAST(wdt->tmr);
+
+	wdt->base.info =3D &tegra186_wdt_info;
+	wdt->base.ops =3D &tegra186_wdt_ops;
+	wdt->base.min_timeout =3D 1;
+	wdt->base.max_timeout =3D 255;
+	wdt->base.parent =3D tegra->dev;
+
+	err =3D watchdog_init_timeout(&wdt->base, 5, tegra->dev);
+	if (err < 0) {
+		dev_err(tegra->dev, "failed to initialize timeout: %d\n", err);
+		return ERR_PTR(err);
+	}
+
+	err =3D devm_watchdog_register_device(tegra->dev, &wdt->base);
+	if (err < 0) {
+		dev_err(tegra->dev, "failed to register WDT: %d\n", err);
+		return ERR_PTR(err);
+	}
+
+	return wdt;
+}
+
+static u64 tegra186_timer_tsc_read(struct clocksource *cs)
+{
+	struct tegra186_timer *tegra =3D container_of(cs, struct tegra186_timer,
+						    tsc);
+	u32 hi, lo, ss;
+
+	hi =3D readl_relaxed(tegra->regs + TKETSC1);
+
+	/*
+	 * The 56-bit value of the TSC is spread across two registers that are
+	 * not synchronized. In order to read them atomically, ensure that the
+	 * high 24 bits match before and after reading the low 32 bits.
+	 */
+	do {
+		/* snapshot the high 24 bits */
+		ss =3D hi;
+
+		lo =3D readl_relaxed(tegra->regs + TKETSC0);
+		hi =3D readl_relaxed(tegra->regs + TKETSC1);
+	} while (hi !=3D ss);
+
+	return (u64)hi << 32 | lo;
+}
+
+static int tegra186_timer_tsc_init(struct tegra186_timer *tegra)
+{
+	tegra->tsc.name =3D "tsc";
+	tegra->tsc.rating =3D 300;
+	tegra->tsc.read =3D tegra186_timer_tsc_read;
+	tegra->tsc.mask =3D CLOCKSOURCE_MASK(56);
+	tegra->tsc.flags =3D CLOCK_SOURCE_IS_CONTINUOUS;
+
+	return clocksource_register_hz(&tegra->tsc, 31250000);
+}
+
+static u64 tegra186_timer_osc_read(struct clocksource *cs)
+{
+	struct tegra186_timer *tegra =3D container_of(cs, struct tegra186_timer,
+						    osc);
+
+	return readl_relaxed(tegra->regs + TKEOSC);
+}
+
+static int tegra186_timer_osc_init(struct tegra186_timer *tegra)
+{
+	tegra->osc.name =3D "osc";
+	tegra->osc.rating =3D 300;
+	tegra->osc.read =3D tegra186_timer_osc_read;
+	tegra->osc.mask =3D CLOCKSOURCE_MASK(32);
+	tegra->osc.flags =3D CLOCK_SOURCE_IS_CONTINUOUS;
+
+	return clocksource_register_hz(&tegra->osc, 38400000);
+}
+
+static u64 tegra186_timer_usec_read(struct clocksource *cs)
+{
+	struct tegra186_timer *tegra =3D container_of(cs, struct tegra186_timer,
+						    usec);
+
+	return readl_relaxed(tegra->regs + TKEUSEC);
+}
+
+static int tegra186_timer_usec_init(struct tegra186_timer *tegra)
+{
+	tegra->usec.name =3D "usec";
+	tegra->usec.rating =3D 300;
+	tegra->usec.read =3D tegra186_timer_usec_read;
+	tegra->usec.mask =3D CLOCKSOURCE_MASK(32);
+	tegra->usec.flags =3D CLOCK_SOURCE_IS_CONTINUOUS;
+
+	return clocksource_register_hz(&tegra->usec, USEC_PER_SEC);
+}
+
+static irqreturn_t tegra186_timer_irq(int irq, void *data)
+{
+	struct tegra186_timer *tegra =3D data;
+
+	if (watchdog_active(&tegra->wdt->base)) {
+		tegra186_wdt_disable(tegra->wdt);
+		tegra186_wdt_enable(tegra->wdt);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int tegra186_timer_probe(struct platform_device *pdev)
+{
+	struct device *dev =3D &pdev->dev;
+	struct tegra186_timer *tegra;
+	unsigned int irq;
+	int err;
+
+	tegra =3D devm_kzalloc(dev, sizeof(*tegra), GFP_KERNEL);
+	if (!tegra)
+		return -ENOMEM;
+
+	tegra->soc =3D of_device_get_match_data(dev);
+	dev_set_drvdata(dev, tegra);
+	tegra->dev =3D dev;
+
+	tegra->regs =3D devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(tegra->regs))
+		return PTR_ERR(tegra->regs);
+
+	err =3D platform_get_irq(pdev, 0);
+	if (err < 0)
+		return err;
+
+	irq =3D err;
+
+	/* create a watchdog using a preconfigured timer */
+	tegra->wdt =3D tegra186_wdt_create(tegra, 0);
+	if (IS_ERR(tegra->wdt)) {
+		err =3D PTR_ERR(tegra->wdt);
+		dev_err(dev, "failed to create WDT: %d\n", err);
+		return err;
+	}
+
+	err =3D tegra186_timer_tsc_init(tegra);
+	if (err < 0) {
+		dev_err(dev, "failed to register TSC counter: %d\n", err);
+		return err;
+	}
+
+	err =3D tegra186_timer_osc_init(tegra);
+	if (err < 0) {
+		dev_err(dev, "failed to register OSC counter: %d\n", err);
+		goto unregister_tsc;
+	}
+
+	err =3D tegra186_timer_usec_init(tegra);
+	if (err < 0) {
+		dev_err(dev, "failed to register USEC counter: %d\n", err);
+		goto unregister_osc;
+	}
+
+	err =3D devm_request_irq(dev, irq, tegra186_timer_irq, 0,
+			       "tegra186-timer", tegra);
+	if (err < 0) {
+		dev_err(dev, "failed to request IRQ#%u: %d\n", irq, err);
+		goto unregister_usec;
+	}
+
+	return 0;
+
+unregister_usec:
+	clocksource_unregister(&tegra->usec);
+unregister_osc:
+	clocksource_unregister(&tegra->osc);
+unregister_tsc:
+	clocksource_unregister(&tegra->tsc);
+	return err;
+}
+
+static int tegra186_timer_remove(struct platform_device *pdev)
+{
+	struct tegra186_timer *tegra =3D platform_get_drvdata(pdev);
+
+	clocksource_unregister(&tegra->usec);
+	clocksource_unregister(&tegra->osc);
+	clocksource_unregister(&tegra->tsc);
+
+	return 0;
+}
+
+static int __maybe_unused tegra186_timer_suspend(struct device *dev)
+{
+	struct tegra186_timer *tegra =3D dev_get_drvdata(dev);
+
+	if (watchdog_active(&tegra->wdt->base))
+		tegra186_wdt_disable(tegra->wdt);
+
+	return 0;
+}
+
+static int __maybe_unused tegra186_timer_resume(struct device *dev)
+{
+	struct tegra186_timer *tegra =3D dev_get_drvdata(dev);
+
+	if (watchdog_active(&tegra->wdt->base))
+		tegra186_wdt_enable(tegra->wdt);
+
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(tegra186_timer_pm_ops, tegra186_timer_suspend,
+			 tegra186_timer_resume);
+
+static const struct tegra186_timer_soc tegra186_timer =3D {
+	.num_timers =3D 10,
+	.num_wdts =3D 3,
+};
+
+static const struct tegra186_timer_soc tegra234_timer =3D {
+	.num_timers =3D 16,
+	.num_wdts =3D 3,
+};
+
+static const struct of_device_id tegra186_timer_of_match[] =3D {
+	{ .compatible =3D "nvidia,tegra186-timer", .data =3D &tegra186_timer },
+	{ .compatible =3D "nvidia,tegra234-timer", .data =3D &tegra234_timer },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, tegra186_timer_of_match);
+
+static struct platform_driver tegra186_wdt_driver =3D {
+	.driver =3D {
+		.name =3D "tegra186-timer",
+		.pm =3D &tegra186_timer_pm_ops,
+		.of_match_table =3D tegra186_timer_of_match,
+	},
+	.probe =3D tegra186_timer_probe,
+	.remove =3D tegra186_timer_remove,
+};
+module_platform_driver(tegra186_wdt_driver);
+
+MODULE_AUTHOR("Thierry Reding <treding@nvidia.com>");
+MODULE_DESCRIPTION("NVIDIA Tegra186 timers driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti=
-dm.c
index c194e8f74e1d..469f7c91564b 100644
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -44,6 +44,121 @@ enum {
 	REQUEST_BY_NODE,
 };
=20
+static inline u32 __omap_dm_timer_read(struct omap_dm_timer *timer, u32 reg,
+						int posted)
+{
+	if (posted)
+		while (readl_relaxed(timer->pend) & (reg >> WPSHIFT))
+			cpu_relax();
+
+	return readl_relaxed(timer->func_base + (reg & 0xff));
+}
+
+static inline void __omap_dm_timer_write(struct omap_dm_timer *timer,
+					u32 reg, u32 val, int posted)
+{
+	if (posted)
+		while (readl_relaxed(timer->pend) & (reg >> WPSHIFT))
+			cpu_relax();
+
+	writel_relaxed(val, timer->func_base + (reg & 0xff));
+}
+
+static inline void __omap_dm_timer_init_regs(struct omap_dm_timer *timer)
+{
+	u32 tidr;
+
+	/* Assume v1 ip if bits [31:16] are zero */
+	tidr =3D readl_relaxed(timer->io_base);
+	if (!(tidr >> 16)) {
+		timer->revision =3D 1;
+		timer->irq_stat =3D timer->io_base + OMAP_TIMER_V1_STAT_OFFSET;
+		timer->irq_ena =3D timer->io_base + OMAP_TIMER_V1_INT_EN_OFFSET;
+		timer->irq_dis =3D timer->io_base + OMAP_TIMER_V1_INT_EN_OFFSET;
+		timer->pend =3D timer->io_base + _OMAP_TIMER_WRITE_PEND_OFFSET;
+		timer->func_base =3D timer->io_base;
+	} else {
+		timer->revision =3D 2;
+		timer->irq_stat =3D timer->io_base + OMAP_TIMER_V2_IRQSTATUS;
+		timer->irq_ena =3D timer->io_base + OMAP_TIMER_V2_IRQENABLE_SET;
+		timer->irq_dis =3D timer->io_base + OMAP_TIMER_V2_IRQENABLE_CLR;
+		timer->pend =3D timer->io_base +
+			_OMAP_TIMER_WRITE_PEND_OFFSET +
+				OMAP_TIMER_V2_FUNC_OFFSET;
+		timer->func_base =3D timer->io_base + OMAP_TIMER_V2_FUNC_OFFSET;
+	}
+}
+
+/*
+ * __omap_dm_timer_enable_posted - enables write posted mode
+ * @timer:      pointer to timer instance handle
+ *
+ * Enables the write posted mode for the timer. When posted mode is enabled
+ * writes to certain timer registers are immediately acknowledged by the
+ * internal bus and hence prevents stalling the CPU waiting for the write to
+ * complete. Enabling this feature can improve performance for writing to the
+ * timer registers.
+ */
+static inline void __omap_dm_timer_enable_posted(struct omap_dm_timer *timer)
+{
+	if (timer->posted)
+		return;
+
+	if (timer->errata & OMAP_TIMER_ERRATA_I103_I767) {
+		timer->posted =3D OMAP_TIMER_NONPOSTED;
+		__omap_dm_timer_write(timer, OMAP_TIMER_IF_CTRL_REG, 0, 0);
+		return;
+	}
+
+	__omap_dm_timer_write(timer, OMAP_TIMER_IF_CTRL_REG,
+			      OMAP_TIMER_CTRL_POSTED, 0);
+	timer->context.tsicr =3D OMAP_TIMER_CTRL_POSTED;
+	timer->posted =3D OMAP_TIMER_POSTED;
+}
+
+static inline void __omap_dm_timer_stop(struct omap_dm_timer *timer,
+					int posted, unsigned long rate)
+{
+	u32 l;
+
+	l =3D __omap_dm_timer_read(timer, OMAP_TIMER_CTRL_REG, posted);
+	if (l & OMAP_TIMER_CTRL_ST) {
+		l &=3D ~0x1;
+		__omap_dm_timer_write(timer, OMAP_TIMER_CTRL_REG, l, posted);
+#ifdef CONFIG_ARCH_OMAP2PLUS
+		/* Readback to make sure write has completed */
+		__omap_dm_timer_read(timer, OMAP_TIMER_CTRL_REG, posted);
+		/*
+		 * Wait for functional clock period x 3.5 to make sure that
+		 * timer is stopped
+		 */
+		udelay(3500000 / rate + 1);
+#endif
+	}
+
+	/* Ack possibly pending interrupt */
+	writel_relaxed(OMAP_TIMER_INT_OVERFLOW, timer->irq_stat);
+}
+
+static inline void __omap_dm_timer_int_enable(struct omap_dm_timer *timer,
+						unsigned int value)
+{
+	writel_relaxed(value, timer->irq_ena);
+	__omap_dm_timer_write(timer, OMAP_TIMER_WAKEUP_EN_REG, value, 0);
+}
+
+static inline unsigned int
+__omap_dm_timer_read_counter(struct omap_dm_timer *timer, int posted)
+{
+	return __omap_dm_timer_read(timer, OMAP_TIMER_COUNTER_REG, posted);
+}
+
+static inline void __omap_dm_timer_write_status(struct omap_dm_timer *timer,
+						unsigned int value)
+{
+	writel_relaxed(value, timer->irq_stat);
+}
+
 /**
  * omap_dm_timer_read_reg - read timer registers in posted and non-posted mo=
de
  * @timer:      timer pointer over which read operation to perform
@@ -921,6 +1036,10 @@ static const struct dmtimer_platform_data omap3plus_pda=
ta =3D {
 	.timer_ops =3D &dmtimer_ops,
 };
=20
+static const struct dmtimer_platform_data am6_pdata =3D {
+	.timer_ops =3D &dmtimer_ops,
+};
+
 static const struct of_device_id omap_timer_match[] =3D {
 	{
 		.compatible =3D "ti,omap2420-timer",
@@ -949,6 +1068,10 @@ static const struct of_device_id omap_timer_match[] =3D=
 {
 		.compatible =3D "ti,dm816-timer",
 		.data =3D &omap3plus_pdata,
 	},
+	{
+		.compatible =3D "ti,am654-timer",
+		.data =3D &am6_pdata,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, omap_timer_match);
diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_=
thermal.c
index 43eb25b167bc..ccdf8a24ddc7 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -399,6 +399,10 @@ static const struct of_device_id rcar_gen3_thermal_dt_id=
s[] =3D {
 		.compatible =3D "renesas,r8a779a0-thermal",
 		.data =3D &rcar_gen3_ths_tj_1,
 	},
+	{
+		.compatible =3D "renesas,r8a779f0-thermal",
+		.data =3D &rcar_gen3_ths_tj_1,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, rcar_gen3_thermal_dt_ids);
diff --git a/include/clocksource/timer-ti-dm.h b/include/clocksource/timer-ti=
-dm.h
index f6da8a132639..b0f80cfd2a26 100644
--- a/include/clocksource/timer-ti-dm.h
+++ b/include/clocksource/timer-ti-dm.h
@@ -247,148 +247,4 @@ int omap_dm_timers_active(void);
 #define OMAP_TIMER_TICK_INT_MASK_COUNT_REG				\
 		(_OMAP_TIMER_TICK_INT_MASK_COUNT_OFFSET | (WP_TOWR << WPSHIFT))
=20
-/*
- * The below are inlined to optimize code size for system timers. Other code
- * should not need these at all.
- */
-#if defined(CONFIG_ARCH_OMAP1) || defined(CONFIG_ARCH_OMAP2PLUS)
-static inline u32 __omap_dm_timer_read(struct omap_dm_timer *timer, u32 reg,
-						int posted)
-{
-	if (posted)
-		while (readl_relaxed(timer->pend) & (reg >> WPSHIFT))
-			cpu_relax();
-
-	return readl_relaxed(timer->func_base + (reg & 0xff));
-}
-
-static inline void __omap_dm_timer_write(struct omap_dm_timer *timer,
-					u32 reg, u32 val, int posted)
-{
-	if (posted)
-		while (readl_relaxed(timer->pend) & (reg >> WPSHIFT))
-			cpu_relax();
-
-	writel_relaxed(val, timer->func_base + (reg & 0xff));
-}
-
-static inline void __omap_dm_timer_init_regs(struct omap_dm_timer *timer)
-{
-	u32 tidr;
-
-	/* Assume v1 ip if bits [31:16] are zero */
-	tidr =3D readl_relaxed(timer->io_base);
-	if (!(tidr >> 16)) {
-		timer->revision =3D 1;
-		timer->irq_stat =3D timer->io_base + OMAP_TIMER_V1_STAT_OFFSET;
-		timer->irq_ena =3D timer->io_base + OMAP_TIMER_V1_INT_EN_OFFSET;
-		timer->irq_dis =3D timer->io_base + OMAP_TIMER_V1_INT_EN_OFFSET;
-		timer->pend =3D timer->io_base + _OMAP_TIMER_WRITE_PEND_OFFSET;
-		timer->func_base =3D timer->io_base;
-	} else {
-		timer->revision =3D 2;
-		timer->irq_stat =3D timer->io_base + OMAP_TIMER_V2_IRQSTATUS;
-		timer->irq_ena =3D timer->io_base + OMAP_TIMER_V2_IRQENABLE_SET;
-		timer->irq_dis =3D timer->io_base + OMAP_TIMER_V2_IRQENABLE_CLR;
-		timer->pend =3D timer->io_base +
-			_OMAP_TIMER_WRITE_PEND_OFFSET +
-				OMAP_TIMER_V2_FUNC_OFFSET;
-		timer->func_base =3D timer->io_base + OMAP_TIMER_V2_FUNC_OFFSET;
-	}
-}
-
-/*
- * __omap_dm_timer_enable_posted - enables write posted mode
- * @timer:      pointer to timer instance handle
- *
- * Enables the write posted mode for the timer. When posted mode is enabled
- * writes to certain timer registers are immediately acknowledged by the
- * internal bus and hence prevents stalling the CPU waiting for the write to
- * complete. Enabling this feature can improve performance for writing to the
- * timer registers.
- */
-static inline void __omap_dm_timer_enable_posted(struct omap_dm_timer *timer)
-{
-	if (timer->posted)
-		return;
-
-	if (timer->errata & OMAP_TIMER_ERRATA_I103_I767) {
-		timer->posted =3D OMAP_TIMER_NONPOSTED;
-		__omap_dm_timer_write(timer, OMAP_TIMER_IF_CTRL_REG, 0, 0);
-		return;
-	}
-
-	__omap_dm_timer_write(timer, OMAP_TIMER_IF_CTRL_REG,
-			      OMAP_TIMER_CTRL_POSTED, 0);
-	timer->context.tsicr =3D OMAP_TIMER_CTRL_POSTED;
-	timer->posted =3D OMAP_TIMER_POSTED;
-}
-
-/**
- * __omap_dm_timer_override_errata - override errata flags for a timer
- * @timer:      pointer to timer handle
- * @errata:	errata flags to be ignored
- *
- * For a given timer, override a timer errata by clearing the flags
- * specified by the errata argument. A specific erratum should only be
- * overridden for a timer if the timer is used in such a way the erratum
- * has no impact.
- */
-static inline void __omap_dm_timer_override_errata(struct omap_dm_timer *tim=
er,
-						   u32 errata)
-{
-	timer->errata &=3D ~errata;
-}
-
-static inline void __omap_dm_timer_stop(struct omap_dm_timer *timer,
-					int posted, unsigned long rate)
-{
-	u32 l;
-
-	l =3D __omap_dm_timer_read(timer, OMAP_TIMER_CTRL_REG, posted);
-	if (l & OMAP_TIMER_CTRL_ST) {
-		l &=3D ~0x1;
-		__omap_dm_timer_write(timer, OMAP_TIMER_CTRL_REG, l, posted);
-#ifdef CONFIG_ARCH_OMAP2PLUS
-		/* Readback to make sure write has completed */
-		__omap_dm_timer_read(timer, OMAP_TIMER_CTRL_REG, posted);
-		/*
-		 * Wait for functional clock period x 3.5 to make sure that
-		 * timer is stopped
-		 */
-		udelay(3500000 / rate + 1);
-#endif
-	}
-
-	/* Ack possibly pending interrupt */
-	writel_relaxed(OMAP_TIMER_INT_OVERFLOW, timer->irq_stat);
-}
-
-static inline void __omap_dm_timer_load_start(struct omap_dm_timer *timer,
-						u32 ctrl, unsigned int load,
-						int posted)
-{
-	__omap_dm_timer_write(timer, OMAP_TIMER_COUNTER_REG, load, posted);
-	__omap_dm_timer_write(timer, OMAP_TIMER_CTRL_REG, ctrl, posted);
-}
-
-static inline void __omap_dm_timer_int_enable(struct omap_dm_timer *timer,
-						unsigned int value)
-{
-	writel_relaxed(value, timer->irq_ena);
-	__omap_dm_timer_write(timer, OMAP_TIMER_WAKEUP_EN_REG, value, 0);
-}
-
-static inline unsigned int
-__omap_dm_timer_read_counter(struct omap_dm_timer *timer, int posted)
-{
-	return __omap_dm_timer_read(timer, OMAP_TIMER_COUNTER_REG, posted);
-}
-
-static inline void __omap_dm_timer_write_status(struct omap_dm_timer *timer,
-						unsigned int value)
-{
-	writel_relaxed(value, timer->irq_stat);
-}
-#endif /* CONFIG_ARCH_OMAP1 || CONFIG_ARCH_OMAP2PLUS */
 #endif /* __CLOCKSOURCE_DMTIMER_H */
diff --git a/include/linux/wait.h b/include/linux/wait.h
index 851e07da2583..58cfbf81447c 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -544,10 +544,11 @@ do {										\
 										\
 	hrtimer_init_sleeper_on_stack(&__t, CLOCK_MONOTONIC,			\
 				      HRTIMER_MODE_REL);			\
-	if ((timeout) !=3D KTIME_MAX)						\
-		hrtimer_start_range_ns(&__t.timer, timeout,			\
-				       current->timer_slack_ns,			\
-				       HRTIMER_MODE_REL);			\
+	if ((timeout) !=3D KTIME_MAX) {						\
+		hrtimer_set_expires_range_ns(&__t.timer, timeout,		\
+					current->timer_slack_ns);		\
+		hrtimer_sleeper_start_expires(&__t, HRTIMER_MODE_REL);		\
+	}									\
 										\
 	__ret =3D ___wait_event(wq_head, condition, state, 0, 0,			\
 		if (!__t.task) {						\

