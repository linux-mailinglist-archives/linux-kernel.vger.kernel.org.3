Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1855581965
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 20:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239228AbiGZSHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 14:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239160AbiGZSHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 14:07:10 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C87253134E;
        Tue, 26 Jul 2022 11:07:06 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.93,194,1654527600"; 
   d="scan'208";a="129202711"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 27 Jul 2022 03:07:04 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 3D13F40C58B3;
        Wed, 27 Jul 2022 03:06:59 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Anup Patel <anup@brainfault.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6/6] riscv: dts: renesas: Add initial devicetree for Renesas RZ/Five SoC
Date:   Tue, 26 Jul 2022 19:06:23 +0100
Message-Id: <20220726180623.1668-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220726180623.1668-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220726180623.1668-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial device tree for Renesas RZ/Five RISC-V CPU Core (AX45MP
Single).

Below is the list of IP blocks added in the initial SoC DTSI which can be
used to boot via initramfs on RZ/Five SMARC EVK:
- AX45MP CPU
- CPG
- PINCTRL
- PLIC
- SCIF0
- SYSC

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/riscv/boot/dts/Makefile               |   1 +
 arch/riscv/boot/dts/renesas/r9a07g043.dtsi | 121 +++++++++++++++++++++
 2 files changed, 122 insertions(+)
 create mode 100644 arch/riscv/boot/dts/renesas/r9a07g043.dtsi

diff --git a/arch/riscv/boot/dts/Makefile b/arch/riscv/boot/dts/Makefile
index ff174996cdfd..b0ff5fbabb0c 100644
--- a/arch/riscv/boot/dts/Makefile
+++ b/arch/riscv/boot/dts/Makefile
@@ -3,5 +3,6 @@ subdir-y += sifive
 subdir-y += starfive
 subdir-$(CONFIG_SOC_CANAAN_K210_DTB_BUILTIN) += canaan
 subdir-y += microchip
+subdir-y += renesas
 
 obj-$(CONFIG_BUILTIN_DTB) := $(addsuffix /, $(subdir-y))
diff --git a/arch/riscv/boot/dts/renesas/r9a07g043.dtsi b/arch/riscv/boot/dts/renesas/r9a07g043.dtsi
new file mode 100644
index 000000000000..6e0b640c6c7f
--- /dev/null
+++ b/arch/riscv/boot/dts/renesas/r9a07g043.dtsi
@@ -0,0 +1,121 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/*
+ * Device Tree Source for the RZ/Five SoC
+ *
+ * Copyright (C) 2022 Renesas Electronics Corp.
+ */
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/clock/r9a07g043-cpg.h>
+
+/ {
+	compatible = "renesas,r9a07g043";
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	/* clock can be either from exclk or crystal oscillator (XIN/XOUT) */
+	extal_clk: extal-clk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		/* This value must be overridden by the board */
+		clock-frequency = <0>;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		timebase-frequency = <24000000>;
+
+		ax45mp: cpu@0 {
+			compatible = "andestech,ax45mp", "riscv";
+			device_type = "cpu";
+			reg = <0x0>;
+			status = "okay";
+			riscv,isa = "rv64imafdc";
+			mmu-type = "riscv,sv39";
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <0x40>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <0x40>;
+			clocks = <&cpg CPG_CORE R9A07G043_AX45MP_CORE0_CLK>,
+				 <&cpg CPG_CORE R9A07G043_AX45MP_ACLK>;
+
+			cpu0_intc: interrupt-controller {
+				#interrupt-cells = <1>;
+				compatible = "riscv,cpu-intc";
+				interrupt-controller;
+			};
+		};
+	};
+
+	soc: soc {
+		compatible = "simple-bus";
+		interrupt-parent = <&plic>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		scif0: serial@1004b800 {
+			compatible = "renesas,scif-r9a07g043",
+				     "renesas,scif-r9a07g044";
+			reg = <0 0x1004b800 0 0x400>;
+			interrupts = <412 IRQ_TYPE_LEVEL_HIGH>,
+				     <414 IRQ_TYPE_LEVEL_HIGH>,
+				     <415 IRQ_TYPE_LEVEL_HIGH>,
+				     <413 IRQ_TYPE_LEVEL_HIGH>,
+				     <416 IRQ_TYPE_LEVEL_HIGH>,
+				     <416 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "eri", "rxi", "txi",
+					  "bri", "dri", "tei";
+			clocks = <&cpg CPG_MOD R9A07G043_SCIF0_CLK_PCK>;
+			clock-names = "fck";
+			power-domains = <&cpg>;
+			resets = <&cpg R9A07G043_SCIF0_RST_SYSTEM_N>;
+			status = "disabled";
+		};
+
+		cpg: clock-controller@11010000 {
+			compatible = "renesas,r9a07g043-cpg";
+			reg = <0 0x11010000 0 0x10000>;
+			clocks = <&extal_clk>;
+			clock-names = "extal";
+			#clock-cells = <2>;
+			#reset-cells = <1>;
+			#power-domain-cells = <0>;
+		};
+
+		sysc: system-controller@11020000 {
+			compatible = "renesas,r9a07g043-sysc";
+			reg = <0 0x11020000 0 0x10000>;
+			status = "disabled";
+		};
+
+		pinctrl: pinctrl@11030000 {
+			compatible = "renesas,r9a07g043-pinctrl";
+			reg = <0 0x11030000 0 0x10000>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+			gpio-ranges = <&pinctrl 0 0 152>;
+			clocks = <&cpg CPG_MOD R9A07G043_GPIO_HCLK>;
+			power-domains = <&cpg>;
+			resets = <&cpg R9A07G043_GPIO_RSTN>,
+				 <&cpg R9A07G043_GPIO_PORT_RESETN>,
+				 <&cpg R9A07G043_GPIO_SPARE_RESETN>;
+		};
+
+		plic: interrupt-controller@12c00000 {
+			compatible = "renesas,r9a07g043-plic", "andestech,nceplic100";
+			#interrupt-cells = <2>;
+			#address-cells = <0>;
+			riscv,ndev = <543>;
+			interrupt-controller;
+			reg = <0x0 0x12c00000 0 0x400000>;
+			clocks = <&cpg CPG_MOD R9A07G043_NCEPLIC_ACLK>;
+			power-domains = <&cpg>;
+			resets = <&cpg R9A07G043_NCEPLIC_ARESETN>;
+			interrupts-extended = <&cpu0_intc 11 &cpu0_intc 9>;
+		};
+	};
+};
-- 
2.17.1

