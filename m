Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A921F47888A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 11:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234881AbhLQKNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 05:13:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234760AbhLQKM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 05:12:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4802C06173E;
        Fri, 17 Dec 2021 02:12:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A79C9B82788;
        Fri, 17 Dec 2021 10:12:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 676BFC36AEE;
        Fri, 17 Dec 2021 10:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639735975;
        bh=D5n3Gqz846mEtcLkrq2xHAalohEXwI4fhrOFgrUoiqM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MuAGJLPXqzOt1o/9sYxx2OMX+KCPQbFNp2P83OOqjLO51uF8ZNQOibIGnYr1OwTz2
         ivcll4VVyUDdBACNvaAq6YaqeU9KXoGqtN1DC5Wr7rJdh0mUyUaw7Yhsktyv8jOarb
         yh1lhARoKhCjGd6WenUQ1LLujoFvw/5He1gLQu+u0iMPZ0RHoanCWhsLOA6sYHNPO1
         gGKyfNMRv/RHyqhbdCyH5J3Ifmg+6LOTW9/60DQWNJ/QSyeG269pU2jtSppSfrF7/e
         8wvoMRcdAZzpRhKgvhJztd9Xy0w8jVOwajf4g8FhxE6XkNGh1WRJUAP0Him12PUH+f
         8R4O6IiXnoQ9g==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1myAEP-000g6K-A6; Fri, 17 Dec 2021 11:12:53 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH v2 4/7] arm64: dts: hisilicon: Add support for Hikey 970 USB3 PHY
Date:   Fri, 17 Dec 2021 11:12:48 +0100
Message-Id: <302bdf9f49298c2378dfe64ab3808d70e7ba7cdb.1639735742.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1639735742.git.mchehab@kernel.org>
References: <cover.1639735742.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Add the USB3 bindings for Kirin 970 phy and Hikey 970 board.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

See [PATCH v2 0/7] at: https://lore.kernel.org/all/cover.1639735742.git.mchehab@kernel.org/

 .../boot/dts/hisilicon/hi3670-hikey970.dts    | 83 +++++++++++++++++++
 arch/arm64/boot/dts/hisilicon/hi3670.dtsi     | 56 +++++++++++++
 2 files changed, 139 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts b/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts
index 7c32f5fd5cc5..60594db07041 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts
@@ -430,3 +430,86 @@ &uart6 {
 	label = "LS-UART1";
 	status = "okay";
 };
+
+&usb_phy {
+	phy-supply = <&ldo17>;
+};
+
+&i2c1 {
+	status = "okay";
+
+	rt1711h: rt1711h@4e {
+		compatible = "richtek,rt1711h";
+		reg = <0x4e>;
+		status = "okay";
+		interrupt-parent = <&gpio27>;
+		interrupts = <5 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&usb_cfg_func>;
+
+		usb_con: connector {
+			compatible = "usb-c-connector";
+			label = "USB-C";
+			data-role = "dual";
+			power-role = "dual";
+			try-power-role = "sink";
+			source-pdos = <PDO_FIXED(5000, 500, PDO_FIXED_USB_COMM)>;
+			sink-pdos = <PDO_FIXED(5000, 500, PDO_FIXED_USB_COMM)
+				PDO_VAR(5000, 5000, 1000)>;
+			op-sink-microwatt = <10000000>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				port@1 {
+					reg = <1>;
+					usb_con_ss: endpoint {
+						remote-endpoint = <&dwc3_ss>;
+					};
+				};
+			};
+		};
+		port {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			rt1711h_ep: endpoint@0 {
+				reg = <0>;
+				remote-endpoint = <&hikey_usb_ep1>;
+			};
+		};
+	};
+};
+
+&i2c2 {
+	/* USB HUB is on this bus at address 0x44 */
+	status = "okay";
+};
+
+&dwc3 { /* USB */
+	dr_mode = "otg";
+	maximum-speed = "super-speed";
+	phy_type = "utmi";
+	snps,dis-del-phy-power-chg-quirk;
+	snps,dis_u2_susphy_quirk;
+	snps,dis_u3_susphy_quirk;
+	snps,tx_de_emphasis_quirk;
+	snps,tx_de_emphasis = <1>;
+	snps,dis-split-quirk;
+	snps,gctl-reset-quirk;
+	usb-role-switch;
+	role-switch-default-mode = "host";
+	port {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		dwc3_role_switch: endpoint@0 {
+			reg = <0>;
+			remote-endpoint = <&hikey_usb_ep0>;
+		};
+
+		dwc3_ss: endpoint@1 {
+			reg = <1>;
+			remote-endpoint = <&usb_con_ss>;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
index 636c8817df7e..782e1487666d 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
@@ -8,6 +8,7 @@
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/hi3670-clock.h>
+#include <dt-bindings/usb/pd.h>
 
 / {
 	compatible = "hisilicon,hi3670";
@@ -785,5 +786,60 @@ i2c4: i2c@fdf0d000 {
 			pinctrl-0 = <&i2c4_pmx_func &i2c4_cfg_func>;
 			status = "disabled";
 		};
+
+		usb3_otg_bc: usb3_otg_bc@ff200000 {
+			compatible = "syscon", "simple-mfd";
+			reg = <0x0 0xff200000 0x0 0x1000>;
+
+			usb_phy: usbphy {
+				compatible = "hisilicon,hi3670-usb-phy";
+				#phy-cells = <0>;
+				hisilicon,pericrg-syscon = <&crg_ctrl>;
+				hisilicon,pctrl-syscon = <&pctrl>;
+				hisilicon,sctrl-syscon = <&sctrl>;
+				hisilicon,eye-diagram-param = <0xFDFEE4>;
+				hisilicon,tx-vboost-lvl = <0x5>;
+			};
+		};
+
+		usb31_misc_rst: usb31_misc_rst_controller {
+			compatible = "hisilicon,hi3660-reset";
+			#reset-cells = <2>;
+			hisi,rst-syscon = <&usb3_otg_bc>;
+		};
+
+		usb3: hisi_dwc3 {
+			compatible = "hisilicon,hi3670-dwc3";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+
+			clocks = <&crg_ctrl HI3670_CLK_GATE_ABB_USB>,
+				  <&crg_ctrl HI3670_HCLK_GATE_USB3OTG>,
+				  <&crg_ctrl HI3670_CLK_GATE_USB3OTG_REF>,
+				  <&crg_ctrl HI3670_ACLK_GATE_USB3DVFS>;
+			clock-names = "clk_gate_abb_usb",
+				      "hclk_gate_usb3otg",
+				      "clk_gate_usb3otg_ref",
+				      "aclk_gate_usb3dvfs";
+
+			assigned-clocks = <&crg_ctrl HI3670_ACLK_GATE_USB3DVFS>;
+			assigned-clock-rates = <238000000>;
+			resets = <&crg_rst 0x90 6>,
+				 <&crg_rst 0x90 7>,
+				 <&usb31_misc_rst 0xA0 8>,
+				 <&usb31_misc_rst 0xA0 9>;
+
+			dwc3: usb@ff100000 {
+				compatible = "snps,dwc3";
+				reg = <0x0 0xff100000 0x0 0x100000>;
+
+				interrupts = <0 159 IRQ_TYPE_LEVEL_HIGH>,
+					    <0 161 IRQ_TYPE_LEVEL_HIGH>;
+
+				phys = <&usb_phy>;
+				phy-names = "usb3-phy";
+			};
+		};
 	};
 };
-- 
2.33.1

