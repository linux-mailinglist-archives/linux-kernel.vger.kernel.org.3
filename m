Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E65849E5C7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 16:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243141AbiA0PR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 10:17:28 -0500
Received: from out28-149.mail.aliyun.com ([115.124.28.149]:49353 "EHLO
        out28-149.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242947AbiA0PRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 10:17:15 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07451715|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.277158-0.000105434-0.722737;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047212;MF=icenowy@nucleisys.com;NM=1;PH=DS;RN=10;RT=10;SR=0;TI=SMTPD_---.Mj85P.V_1643296630;
Received: from ice-e5v2.lan(mailfrom:icenowy@nucleisys.com fp:SMTPD_---.Mj85P.V_1643296630)
          by smtp.aliyun-inc.com(33.45.46.134);
          Thu, 27 Jan 2022 23:17:12 +0800
From:   Icenowy Zheng <icenowy@nucleisys.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org, Icenowy Zheng <icenowy@nucleisys.com>
Subject: [PATCH 09/12] riscv: dts: add device tree for Nuclei DemoSoC w/ UX600 on DDR200T
Date:   Thu, 27 Jan 2022 23:16:44 +0800
Message-Id: <20220127151647.2375449-10-icenowy@nucleisys.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220127151647.2375449-1-icenowy@nucleisys.com>
References: <20220127151647.2375449-1-icenowy@nucleisys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As we're supporting Nuclei DemoSoC for UX600 CPU cores on DDR200T FPGA
prototyping board, add device tree files for it, including DTSI files
for basic DemoSoC structure, DemoSoC with UX600 and DemoSoC running on
DDR200T for further reusing.

Signed-off-by: Icenowy Zheng <icenowy@nucleisys.com>
---
 arch/riscv/boot/dts/Makefile                  |  1 +
 arch/riscv/boot/dts/nuclei/Makefile           |  2 +
 .../dts/nuclei/nuclei-demosoc-ddr200t.dtsi    | 41 ++++++++++++
 .../nuclei/nuclei-demosoc-ux600-ddr200t.dts   | 13 ++++
 .../boot/dts/nuclei/nuclei-demosoc-ux600.dtsi | 49 ++++++++++++++
 .../riscv/boot/dts/nuclei/nuclei-demosoc.dtsi | 67 +++++++++++++++++++
 6 files changed, 173 insertions(+)
 create mode 100644 arch/riscv/boot/dts/nuclei/Makefile
 create mode 100644 arch/riscv/boot/dts/nuclei/nuclei-demosoc-ddr200t.dtsi
 create mode 100644 arch/riscv/boot/dts/nuclei/nuclei-demosoc-ux600-ddr200t.dts
 create mode 100644 arch/riscv/boot/dts/nuclei/nuclei-demosoc-ux600.dtsi
 create mode 100644 arch/riscv/boot/dts/nuclei/nuclei-demosoc.dtsi

diff --git a/arch/riscv/boot/dts/Makefile b/arch/riscv/boot/dts/Makefile
index ff174996cdfd..fd31084986da 100644
--- a/arch/riscv/boot/dts/Makefile
+++ b/arch/riscv/boot/dts/Makefile
@@ -3,5 +3,6 @@ subdir-y += sifive
 subdir-y += starfive
 subdir-$(CONFIG_SOC_CANAAN_K210_DTB_BUILTIN) += canaan
 subdir-y += microchip
+subdir-y += nuclei
 
 obj-$(CONFIG_BUILTIN_DTB) := $(addsuffix /, $(subdir-y))
diff --git a/arch/riscv/boot/dts/nuclei/Makefile b/arch/riscv/boot/dts/nuclei/Makefile
new file mode 100644
index 000000000000..57970aabf01d
--- /dev/null
+++ b/arch/riscv/boot/dts/nuclei/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_SOC_NUCLEI) += nuclei-demosoc-ux600-ddr200t.dtb
diff --git a/arch/riscv/boot/dts/nuclei/nuclei-demosoc-ddr200t.dtsi b/arch/riscv/boot/dts/nuclei/nuclei-demosoc-ddr200t.dtsi
new file mode 100644
index 000000000000..4f44c6b564bb
--- /dev/null
+++ b/arch/riscv/boot/dts/nuclei/nuclei-demosoc-ddr200t.dtsi
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/* Copyright (c) 2022 Nuclei System Technology */
+
+/ {
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory@a0000000 {
+		device_type = "memory";
+		reg = <0xa0000000 0xe000000>;
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&qspi0 {
+	status = "okay";
+
+	spi_nor: flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <8000000>;
+	};
+};
+
+&qspi2 {
+	status = "okay";
+
+	spi_mmc: mmc@0 {
+		compatible = "mmc-spi-slot";
+		reg = <0>;
+		spi-max-frequency = <8000000>;
+	};
+};
diff --git a/arch/riscv/boot/dts/nuclei/nuclei-demosoc-ux600-ddr200t.dts b/arch/riscv/boot/dts/nuclei/nuclei-demosoc-ux600-ddr200t.dts
new file mode 100644
index 000000000000..cd15ec2c1376
--- /dev/null
+++ b/arch/riscv/boot/dts/nuclei/nuclei-demosoc-ux600-ddr200t.dts
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/* Copyright (c) 2022 Nuclei System Technology */
+
+/dts-v1/;
+
+#include "nuclei-demosoc-ux600.dtsi"
+#include "nuclei-demosoc-ddr200t.dtsi"
+
+/ {
+	model = "Nuclei DemoSoC with UX600 on DDR200T";
+	compatible = "nuclei,demosoc-ux600-ddr200t",
+		     "nuclei,demosoc-ux600", "nuclei,demosoc";
+};
diff --git a/arch/riscv/boot/dts/nuclei/nuclei-demosoc-ux600.dtsi b/arch/riscv/boot/dts/nuclei/nuclei-demosoc-ux600.dtsi
new file mode 100644
index 000000000000..f3588907ce3f
--- /dev/null
+++ b/arch/riscv/boot/dts/nuclei/nuclei-demosoc-ux600.dtsi
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/* Copyright (c) 2022 Nuclei System Technology */
+
+#include "nuclei-demosoc.dtsi"
+
+/ {
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		/* The counting clock of the timer is the LF clock */
+		timebase-frequency = <32768>;
+
+		cpu0: cpu@0 {
+			compatible = "nuclei,ux607", "nuclei,ux600", "riscv";
+			device_type = "cpu";
+			reg = <0>;
+			riscv,isa = "rv64imafdc";
+			mmu-type = "riscv,sv39";
+			clock-frequency = <16000000>;
+
+			cpu0_intc: interrupt-controller {
+				#interrupt-cells = <1>;
+				compatible = "riscv,cpu-intc";
+				interrupt-controller;
+			};
+		};
+	};
+
+	clint: clint@2001000 {
+		compatible = "nuclei,ux600-clint", "sifive,clint0";
+		reg = <0x02001000 0xc000>;
+		interrupts-extended = <&cpu0_intc 3>, <&cpu0_intc 7>;
+	};
+
+	plic: plic@8000000 {
+		compatible = "nuclei,ux600-plic", "sifive,plic-1.0.0";
+		reg = <0x08000000 0x4000000>;
+		#address-cells = <0>;
+		#interrupt-cells = <1>;
+		interrupt-controller;
+		interrupts-extended =
+			<&cpu0_intc 11>, <&cpu0_intc 9>;
+		riscv,ndev = <52>;
+	};
+};
+
+&ppi {
+	interrupt-parent = <&plic>;
+};
diff --git a/arch/riscv/boot/dts/nuclei/nuclei-demosoc.dtsi b/arch/riscv/boot/dts/nuclei/nuclei-demosoc.dtsi
new file mode 100644
index 000000000000..85a4f713d3d9
--- /dev/null
+++ b/arch/riscv/boot/dts/nuclei/nuclei-demosoc.dtsi
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/* Copyright (c) 2022 Nuclei System Technology */
+
+/ {
+	/*
+	 * Nuclei DemoSoC is a 32-bit design even if 64-bit CPU core is
+	 * integrated into it.
+	 */
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	clocks {
+		/* For most of the SoC */
+		hfclk: hfclk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <16000000>;
+		};
+
+		/* For always-on zone */
+		lfclk: lfclk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <32768>;
+		};
+	};
+
+	/*
+	 * The interrupt controller and all peripherals' interrupt parent
+	 * are to be defined in individual CPU cores' DemoSoC DT.
+	 */
+	ppi: ppi {
+		compatible = "simple-bus";
+		ranges;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		uart0: serial@10010000 {
+			compatible = "nuclei,demosoc-uart", "sifive,uart0";
+			reg = <0x10013000 0x1000>;
+			clocks = <&hfclk>;
+			interrupts = <33>;
+			status = "disabled";
+		};
+
+		qspi0: spi@10014000 {
+			compatible = "nuclei,demosoc-spi", "sifive,spi0";
+			reg = <0x10014000 0x1000>,
+			      <0x20000000 0x20000000>;
+			interrupts = <35>;
+			clocks = <&hfclk>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		qspi2: spi@10034000 {
+			compatible = "nuclei,demosoc-spi", "sifive,spi0";
+			reg = <0x10034000 0x1000>;
+			interrupts = <37>;
+			clocks = <&hfclk>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+	};
+};
-- 
2.30.2

