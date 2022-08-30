Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0A165A6333
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 14:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbiH3MVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 08:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbiH3MVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 08:21:38 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D80CDC650D;
        Tue, 30 Aug 2022 05:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661862087; x=1693398087;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yilvub0N+ZLWbVr8R2JtpvM3e6wJMcNccDNvxhh0vq8=;
  b=pYL9UTpeVjeKLsbvBI5GHKubttMAYTdE7y4LCUTViS4TQs50Y67edljw
   /Bw7h49ZvwycOE1ZqZZo0zFpi0TN0tfbOsiO+Zsb166fyyOLOR/9X+CDq
   mUx6QKhgffQjgn7n9T27FZwsZ97h2xUAH8BXBNmndeGRou/UCKtClhNvq
   as/o2jtZvF/j0gblzr3xtB8w500AcQyXPnR6mK3k1uX6hsh68r5e+LRIL
   T69h5biQy+pUrUnAnXysoyt3dpMdWPbw3LD8rC7wsy5lutPnfEVfoKjoV
   92gAs2JSj9CDYtd64TG4ZZhRvLULxhBrY8k/kXHWxg21F4IWhGZx/f7hR
   g==;
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; 
   d="scan'208";a="111374842"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Aug 2022 05:21:26 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 30 Aug 2022 05:21:25 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.12 via Frontend
 Transport; Tue, 30 Aug 2022 05:21:22 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Hugh Breslin <hugh.breslin@microchip.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: [PATCH v3 5/5] riscv: dts: microchip: add the mpfs' fabric clock control
Date:   Tue, 30 Aug 2022 13:20:24 +0100
Message-ID: <20220830122023.2204485-6-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220830122023.2204485-1-conor.dooley@microchip.com>
References: <20220830122023.2204485-1-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "fabric clocks" in current PolarFire SoC device trees are not
really fixed clocks. Their frequency is set by the bitstream, so having
them located in -fabric.dtsi is not a problem - they're just as "fixed"
as the IP blocks etc used in the FPGA fabric.
However, their configuration can be read at runtime (and to an extent
they can be controlled, although the intended usage is static
configurations set by the bitstream) through the system controller bus.

In the v2209 reference design a single CCC (north-west corner) is
enabled, using a 50 MHz off-chip oscillator as its reference.

Updating to the v2209 reference design is required.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../dts/microchip/mpfs-icicle-kit-fabric.dtsi | 27 +++++++++------
 .../boot/dts/microchip/mpfs-icicle-kit.dts    |  4 +++
 .../dts/microchip/mpfs-polarberry-fabric.dtsi |  5 +++
 arch/riscv/boot/dts/microchip/mpfs.dtsi       | 34 +++++++++++++++++--
 4 files changed, 58 insertions(+), 12 deletions(-)

diff --git a/arch/riscv/boot/dts/microchip/mpfs-icicle-kit-fabric.dtsi b/arch/riscv/boot/dts/microchip/mpfs-icicle-kit-fabric.dtsi
index 0d28858b83f2..f17cb00df467 100644
--- a/arch/riscv/boot/dts/microchip/mpfs-icicle-kit-fabric.dtsi
+++ b/arch/riscv/boot/dts/microchip/mpfs-icicle-kit-fabric.dtsi
@@ -2,14 +2,14 @@
 /* Copyright (c) 2020-2021 Microchip Technology Inc */
 
 / {
-	compatible = "microchip,mpfs-icicle-reference-rtlv2203", "microchip,mpfs";
+	compatible = "microchip,mpfs-icicle-reference-rtlv2209", "microchip,mpfs";
 
 	core_pwm0: pwm@41000000 {
 		compatible = "microchip,corepwm-rtl-v4";
 		reg = <0x0 0x41000000 0x0 0xF0>;
 		microchip,sync-update-mask = /bits/ 32 <0>;
 		#pwm-cells = <2>;
-		clocks = <&fabric_clk3>;
+		clocks = <&ccc_nw CLK_CCC_PLL0_OUT0>;
 		status = "disabled";
 	};
 
@@ -18,22 +18,29 @@ i2c2: i2c@44000000 {
 		reg = <0x0 0x44000000 0x0 0x1000>;
 		#address-cells = <1>;
 		#size-cells = <0>;
-		clocks = <&fabric_clk3>;
+		clocks = <&ccc_nw CLK_CCC_PLL0_OUT3>;
 		interrupt-parent = <&plic>;
 		interrupts = <122>;
 		clock-frequency = <100000>;
 		status = "disabled";
 	};
 
-	fabric_clk3: fabric-clk3 {
+	refclk_ccc: cccrefclk {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
-		clock-frequency = <62500000>;
 	};
+};
 
-	fabric_clk1: fabric-clk1 {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <125000000>;
-	};
+&ccc_nw {
+	clocks = <&refclk_ccc>, <&refclk_ccc>, <&refclk_ccc>, <&refclk_ccc>,
+		 <&refclk_ccc>, <&refclk_ccc>;
+	clock-names = "pll0_ref0", "pll0_ref1", "pll1_ref0", "pll1_ref1",
+		      "dll0_ref", "dll1_ref";
+	status = "okay";
+};
+
+&pcie {
+	clocks = <&ccc_nw CLK_CCC_PLL0_OUT0>, <&ccc_nw CLK_CCC_PLL0_OUT1>,
+		 <&ccc_nw CLK_CCC_PLL0_OUT3>;
+	clock-names = "fic0", "fic1", "fic3";
 };
diff --git a/arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dts b/arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dts
index f3f87ed2007f..e7bd564291d6 100644
--- a/arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dts
+++ b/arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dts
@@ -137,6 +137,10 @@ &refclk {
 	clock-frequency = <125000000>;
 };
 
+&refclk_ccc {
+	clock-frequency = <50000000>;
+};
+
 &rtc {
 	status = "okay";
 };
diff --git a/arch/riscv/boot/dts/microchip/mpfs-polarberry-fabric.dtsi b/arch/riscv/boot/dts/microchip/mpfs-polarberry-fabric.dtsi
index 49380c428ec9..3beb450b4259 100644
--- a/arch/riscv/boot/dts/microchip/mpfs-polarberry-fabric.dtsi
+++ b/arch/riscv/boot/dts/microchip/mpfs-polarberry-fabric.dtsi
@@ -14,3 +14,8 @@ fabric_clk1: fabric-clk1 {
 		clock-frequency = <125000000>;
 	};
 };
+
+&pcie {
+	clocks = <&fabric_clk1>, <&fabric_clk1>, <&fabric_clk3>;
+	clock-names = "fic0", "fic1", "fic3";
+};
diff --git a/arch/riscv/boot/dts/microchip/mpfs.dtsi b/arch/riscv/boot/dts/microchip/mpfs.dtsi
index 74493344ea41..1e92adf0094e 100644
--- a/arch/riscv/boot/dts/microchip/mpfs.dtsi
+++ b/arch/riscv/boot/dts/microchip/mpfs.dtsi
@@ -236,6 +236,38 @@ clkcfg: clkcfg@20002000 {
 			#clock-cells = <1>;
 		};
 
+		ccc_se: clock-controller@38010000 {
+			compatible = "microchip,mpfs-ccc";
+			reg = <0x0 0x38010000 0x0 0x1000>, <0x0 0x38020000 0x0 0x1000>,
+			      <0x0 0x39010000 0x0 0x1000>, <0x0 0x39020000 0x0 0x1000>;
+			#clock-cells = <1>;
+			status = "disabled";
+		};
+
+		ccc_ne: clock-controller@38040000 {
+			compatible = "microchip,mpfs-ccc";
+			reg = <0x0 0x38040000 0x0 0x1000>, <0x0 0x38080000 0x0 0x1000>,
+			      <0x0 0x39040000 0x0 0x1000>, <0x0 0x39080000 0x0 0x1000>;
+			#clock-cells = <1>;
+			status = "disabled";
+		};
+
+		ccc_nw: clock-controller@38100000 {
+			compatible = "microchip,mpfs-ccc";
+			reg = <0x0 0x38100000 0x0 0x1000>, <0x0 0x38200000 0x0 0x1000>,
+			      <0x0 0x39100000 0x0 0x1000>, <0x0 0x39200000 0x0 0x1000>;
+			#clock-cells = <1>;
+			status = "disabled";
+		};
+
+		ccc_sw: clock-controller@38400000 {
+			compatible = "microchip,mpfs-ccc";
+			reg = <0x0 0x38400000 0x0 0x1000>, <0x0 0x38800000 0x0 0x1000>,
+			      <0x0 0x39400000 0x0 0x1000>, <0x0 0x39800000 0x0 0x1000>;
+			#clock-cells = <1>;
+			status = "disabled";
+		};
+
 		mmuart0: serial@20000000 {
 			compatible = "ns16550a";
 			reg = <0x0 0x20000000 0x0 0x400>;
@@ -480,8 +512,6 @@ pcie: pcie@2000000000 {
 					<0 0 0 3 &pcie_intc 2>,
 					<0 0 0 4 &pcie_intc 3>;
 			interrupt-map-mask = <0 0 0 7>;
-			clocks = <&fabric_clk1>, <&fabric_clk1>, <&fabric_clk3>;
-			clock-names = "fic0", "fic1", "fic3";
 			ranges = <0x3000000 0x0 0x8000000 0x20 0x8000000 0x0 0x80000000>;
 			msi-parent = <&pcie>;
 			msi-controller;
-- 
2.36.1

