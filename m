Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE6F6465EFC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 08:53:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355993AbhLBH46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 02:56:58 -0500
Received: from st43p00im-zteg10061901.me.com ([17.58.63.168]:42377 "EHLO
        st43p00im-zteg10061901.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1355904AbhLBHyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 02:54:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1638431489; bh=L4zSbFE1rtbsJXFDdo2aYFkfF0tDiNZW+Yi0vRdSSok=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=rR8ZWpYRkvqFz7fzYCsKpzGRBWwkRcrd/uBKMBitPdKACO+UObGmmz8Ja52sNrFfT
         bPfcJ0CJld005tBEuy0oifoY6W86u+dj/Dlhcjpthr35yjx+ZRbV2xHmf3L+n1314Z
         WXcL8hWTqD4UGQr9q9Zl1gMo5ZAitN0rX5zzBRk8EEkbqw8RmXE1vo9xYjxbzHqhyp
         dqG9B4/+GPvGjemd25VjZp6JWbdfXr+W7Vae0FfxIFFySFVh2ropBtRR4eVHj4GzHC
         XX/0Lgf2Rmd7MvmgUFtdgnTsuiUmQPR0zcjpzYdkcKgytdKAwzazjlek1oc+jFdI1k
         F63tILylE1g5Q==
Received: from localhost (101.220.150.77.rev.sfr.net [77.150.220.101])
        by st43p00im-zteg10061901.me.com (Postfix) with ESMTPSA id E08A8860809;
        Thu,  2 Dec 2021 07:51:28 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     patrice.chotard@st.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     avolmat@me.com
Subject: [PATCH 04/12] ARM: dts: sti: move some nodes out of the soc section in stih407-family.dtsi
Date:   Thu,  2 Dec 2021 08:50:57 +0100
Message-Id: <20211202075105.195664-5-avolmat@me.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211202075105.195664-1-avolmat@me.com>
References: <20211202075105.195664-1-avolmat@me.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.790
 definitions=2021-12-01_01:2021-11-30,2021-11-30 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2009150000 definitions=main-2112020046
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move all nodes without reg property out of the soc section of
stih407-family.dtsi.  This avoid to set a <0> reg property.

Signed-off-by: Alain Volmat <avolmat@me.com>
---
 arch/arm/boot/dts/stih407-family.dtsi | 262 +++++++++++++-------------
 1 file changed, 126 insertions(+), 136 deletions(-)

diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
index 21f3347a91d6..1713f7878117 100644
--- a/arch/arm/boot/dts/stih407-family.dtsi
+++ b/arch/arm/boot/dts/stih407-family.dtsi
@@ -115,37 +115,140 @@ pwm_regulator: pwm-regulator {
 		status = "okay";
 	};
 
-	soc {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		interrupt-parent = <&intc>;
+	restart: restart-controller {
+		compatible = "st,stih407-restart";
+		st,syscfg = <&syscfg_sbc_reg>;
+		status = "okay";
+	};
+
+	powerdown: powerdown-controller {
+		compatible = "st,stih407-powerdown";
+		#reset-cells = <1>;
+	};
+
+	softreset: softreset-controller {
+		compatible = "st,stih407-softreset";
+		#reset-cells = <1>;
+	};
+
+	picophyreset: picophyreset-controller {
+		compatible = "st,stih407-picophyreset";
+		#reset-cells = <1>;
+	};
+
+	irq-syscfg {
+		compatible    = "st,stih407-irq-syscfg";
+		st,syscfg     = <&syscfg_core>;
+		st,irq-device = <ST_IRQ_SYSCFG_PMU_0>,
+				<ST_IRQ_SYSCFG_PMU_1>;
+		st,fiq-device = <ST_IRQ_SYSCFG_DISABLED>,
+				<ST_IRQ_SYSCFG_DISABLED>;
+	};
+
+	usb2_picophy0: phy1 {
+		compatible = "st,stih407-usb2-phy";
+		#phy-cells = <0>;
+		st,syscfg = <&syscfg_core 0x100 0xf4>;
+		resets = <&softreset STIH407_PICOPHY_SOFTRESET>,
+			 <&picophyreset STIH407_PICOPHY2_RESET>;
+		reset-names = "global", "port";
+	};
+
+	miphy28lp_phy: miphy28lp {
+		compatible = "st,miphy28lp-phy";
+		st,syscfg = <&syscfg_core>;
+		#address-cells	= <1>;
+		#size-cells	= <1>;
 		ranges;
-		compatible = "simple-bus";
 
-		restart: restart-controller@0 {
-			compatible = "st,stih407-restart";
-			reg = <0 0>;
-			st,syscfg = <&syscfg_sbc_reg>;
-			status = "okay";
-		};
+		phy_port0: port@9b22000 {
+			reg = <0x9b22000 0xff>,
+			      <0x9b09000 0xff>,
+			      <0x9b04000 0xff>;
+			reg-names = "sata-up",
+				    "pcie-up",
+				    "pipew";
+
+			st,syscfg = <0x114 0x818 0xe0 0xec>;
+			#phy-cells = <1>;
 
-		powerdown: powerdown-controller@0 {
-			compatible = "st,stih407-powerdown";
-			reg = <0 0>;
-			#reset-cells = <1>;
+			reset-names = "miphy-sw-rst";
+			resets = <&softreset STIH407_MIPHY0_SOFTRESET>;
 		};
 
-		softreset: softreset-controller@0 {
-			compatible = "st,stih407-softreset";
-			reg = <0 0>;
-			#reset-cells = <1>;
+		phy_port1: port@9b2a000 {
+			reg = <0x9b2a000 0xff>,
+			      <0x9b19000 0xff>,
+			      <0x9b14000 0xff>;
+			reg-names = "sata-up",
+				    "pcie-up",
+				    "pipew";
+
+			st,syscfg = <0x118 0x81c 0xe4 0xf0>;
+
+			#phy-cells = <1>;
+
+			reset-names = "miphy-sw-rst";
+			resets = <&softreset STIH407_MIPHY1_SOFTRESET>;
 		};
 
-		picophyreset: picophyreset-controller@0 {
-			compatible = "st,stih407-picophyreset";
-			reg = <0 0>;
-			#reset-cells = <1>;
+		phy_port2: port@8f95000 {
+			reg = <0x8f95000 0xff>,
+			      <0x8f90000 0xff>;
+			reg-names = "pipew",
+				    "usb3-up";
+
+			st,syscfg = <0x11c 0x820>;
+
+			#phy-cells = <1>;
+
+			reset-names = "miphy-sw-rst";
+			resets = <&softreset STIH407_MIPHY2_SOFTRESET>;
 		};
+	};
+
+	st231_gp0: st231-gp0 {
+		compatible	= "st,st231-rproc";
+		memory-region	= <&gp0_reserved>;
+		resets		= <&softreset STIH407_ST231_GP0_SOFTRESET>;
+		reset-names	= "sw_reset";
+		clocks		= <&clk_s_c0_flexgen CLK_ST231_GP_0>;
+		clock-frequency	= <600000000>;
+		st,syscfg	= <&syscfg_core 0x22c>;
+		#mbox-cells = <1>;
+		mbox-names = "vq0_rx", "vq0_tx", "vq1_rx", "vq1_tx";
+		mboxes = <&mailbox0 0 2>, <&mailbox2 0 1>, <&mailbox0 0 3>, <&mailbox2 0 0>;
+	};
+
+	st231_delta: st231-delta {
+		compatible	= "st,st231-rproc";
+		memory-region	= <&delta_reserved>;
+		resets		= <&softreset STIH407_ST231_DMU_SOFTRESET>;
+		reset-names	= "sw_reset";
+		clocks		= <&clk_s_c0_flexgen CLK_ST231_DMU>;
+		clock-frequency	= <600000000>;
+		st,syscfg	= <&syscfg_core 0x224>;
+		#mbox-cells = <1>;
+		mbox-names = "vq0_rx", "vq0_tx", "vq1_rx", "vq1_tx";
+		mboxes = <&mailbox0 0 0>, <&mailbox3 0 1>, <&mailbox0 0 1>, <&mailbox3 0 0>;
+	};
+
+	delta0 {
+		compatible = "st,st-delta";
+		clock-names = "delta",
+			      "delta-st231",
+			      "delta-flash-promip";
+		clocks = <&clk_s_c0_flexgen CLK_VID_DMU>,
+			 <&clk_s_c0_flexgen CLK_ST231_DMU>,
+			 <&clk_s_c0_flexgen CLK_FLASH_PROMIP>;
+	};
+
+	soc {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		interrupt-parent = <&intc>;
+		ranges;
+		compatible = "simple-bus";
 
 		syscfg_sbc: sbc-syscfg@9620000 {
 			compatible = "st,stih407-sbc-syscfg", "syscon";
@@ -189,16 +292,6 @@ syscfg_lpm: lpm-syscfg@94b5100 {
 			reg = <0x94b5100 0x1000>;
 		};
 
-		irq-syscfg@0 {
-			compatible    = "st,stih407-irq-syscfg";
-			reg = <0 0>;
-			st,syscfg     = <&syscfg_core>;
-			st,irq-device = <ST_IRQ_SYSCFG_PMU_0>,
-					<ST_IRQ_SYSCFG_PMU_1>;
-			st,fiq-device = <ST_IRQ_SYSCFG_DISABLED>,
-					<ST_IRQ_SYSCFG_DISABLED>;
-		};
-
 		/* Display */
 		vtg_main: sti-vtg-main@8d02800 {
 			compatible = "st,vtg";
@@ -389,70 +482,6 @@ i2c@9541000 {
 			status = "disabled";
 		};
 
-		usb2_picophy0: phy1@0 {
-			compatible = "st,stih407-usb2-phy";
-			reg = <0 0>;
-			#phy-cells = <0>;
-			st,syscfg = <&syscfg_core 0x100 0xf4>;
-			resets = <&softreset STIH407_PICOPHY_SOFTRESET>,
-				 <&picophyreset STIH407_PICOPHY2_RESET>;
-			reset-names = "global", "port";
-		};
-
-		miphy28lp_phy: miphy28lp@0 {
-			compatible = "st,miphy28lp-phy";
-			st,syscfg = <&syscfg_core>;
-			#address-cells	= <1>;
-			#size-cells	= <1>;
-			ranges;
-			reg = <0 0>;
-
-			phy_port0: port@9b22000 {
-				reg = <0x9b22000 0xff>,
-				      <0x9b09000 0xff>,
-				      <0x9b04000 0xff>;
-				reg-names = "sata-up",
-					    "pcie-up",
-					    "pipew";
-
-				st,syscfg = <0x114 0x818 0xe0 0xec>;
-				#phy-cells = <1>;
-
-				reset-names = "miphy-sw-rst";
-				resets = <&softreset STIH407_MIPHY0_SOFTRESET>;
-			};
-
-			phy_port1: port@9b2a000 {
-				reg = <0x9b2a000 0xff>,
-				      <0x9b19000 0xff>,
-				      <0x9b14000 0xff>;
-				reg-names = "sata-up",
-					    "pcie-up",
-					    "pipew";
-
-				st,syscfg = <0x118 0x81c 0xe4 0xf0>;
-
-				#phy-cells = <1>;
-
-				reset-names = "miphy-sw-rst";
-				resets = <&softreset STIH407_MIPHY1_SOFTRESET>;
-			};
-
-			phy_port2: port@8f95000 {
-				reg = <0x8f95000 0xff>,
-				      <0x8f90000 0xff>;
-				reg-names = "pipew",
-					    "usb3-up";
-
-				st,syscfg = <0x11c 0x820>;
-
-				#phy-cells = <1>;
-
-				reset-names = "miphy-sw-rst";
-				resets = <&softreset STIH407_MIPHY2_SOFTRESET>;
-			};
-		};
-
 		spi@9840000 {
 			compatible = "st,comms-ssc4-spi";
 			reg = <0x9840000 0x110>;
@@ -815,34 +844,6 @@ mailbox3: mailbox@8f03000 {
 			status		= "okay";
 		};
 
-		st231_gp0: st231-gp0@0 {
-			compatible	= "st,st231-rproc";
-			reg		= <0 0>;
-			memory-region	= <&gp0_reserved>;
-			resets		= <&softreset STIH407_ST231_GP0_SOFTRESET>;
-			reset-names	= "sw_reset";
-			clocks		= <&clk_s_c0_flexgen CLK_ST231_GP_0>;
-			clock-frequency	= <600000000>;
-			st,syscfg	= <&syscfg_core 0x22c>;
-			#mbox-cells = <1>;
-			mbox-names = "vq0_rx", "vq0_tx", "vq1_rx", "vq1_tx";
-			mboxes = <&mailbox0 0 2>, <&mailbox2 0 1>, <&mailbox0 0 3>, <&mailbox2 0 0>;
-		};
-
-		st231_delta: st231-delta@0 {
-			compatible	= "st,st231-rproc";
-			reg		= <0 0>;
-			memory-region	= <&delta_reserved>;
-			resets		= <&softreset STIH407_ST231_DMU_SOFTRESET>;
-			reset-names	= "sw_reset";
-			clocks		= <&clk_s_c0_flexgen CLK_ST231_DMU>;
-			clock-frequency	= <600000000>;
-			st,syscfg	= <&syscfg_core 0x224>;
-			#mbox-cells = <1>;
-			mbox-names = "vq0_rx", "vq0_tx", "vq1_rx", "vq1_tx";
-			mboxes = <&mailbox0 0 0>, <&mailbox3 0 1>, <&mailbox0 0 1>, <&mailbox3 0 0>;
-		};
-
 		/* fdma audio */
 		fdma0: dma-controller@8e20000 {
 			compatible = "st,stih407-fdma-mpe31-11", "st,slim-rproc";
@@ -986,16 +987,5 @@ sti_uni_reader1: sti-uni-reader@8d84000 {
 
 			status = "disabled";
 		};
-
-		delta0@0 {
-			compatible = "st,st-delta";
-			reg = <0 0>;
-			clock-names = "delta",
-				      "delta-st231",
-				      "delta-flash-promip";
-			clocks = <&clk_s_c0_flexgen CLK_VID_DMU>,
-				 <&clk_s_c0_flexgen CLK_ST231_DMU>,
-				 <&clk_s_c0_flexgen CLK_FLASH_PROMIP>;
-		};
 	};
 };
-- 
2.25.1

