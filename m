Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D57184BE2C0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:55:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377256AbiBUOCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 09:02:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377249AbiBUOCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 09:02:00 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D28B87A
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 06:01:37 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: detlev)
        with ESMTPSA id 5CE061F43612
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645452096;
        bh=GSKaJKaMls8xwW6meE9ILXHJGyO0wr4LFCfu7Pug/uM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fHSkoRhf7DErstGaYtaJn6m/YV8ZFb7cgvTEWLJ4fQJ//I5mI395gDpLVReNn9gqm
         9syjMRq9XJsJ5o2lMcgUYnkt/lLoK45EGxTQ/BAaBEkxIpmnZxY4iwfV6dKCEp9RyW
         FZpPIuOWbpkijYRGPrms2czmxk4uH4MtWyD9sV6mGzH0gla+UBcOUnmDIFf1/gW33C
         h8sEspdc34YXQ7Cb7CvD4noQvnZaBwnQ/LYw1jgCKYSa6zbbdx2Hp0Wu5CoSwKhaaX
         Ys12MheenrDYg1Fwifxbev/nb+TWXkaRm2YlCmMAh9RMtAh2Lt+/syvg+6zeYpY2D3
         VHiT2W3kE0GDg==
From:   Detlev Casanova <detlev.casanova@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Detlev Casanova <detlev.casanova@collabora.com>
Subject: [RFC PATCH v2 1/3] ARM: dts: bcm2*: Demux i2c0 with a pinctrl
Date:   Mon, 21 Feb 2022 09:01:15 -0500
Message-Id: <20220221140117.90284-2-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220221140117.90284-1-detlev.casanova@collabora.com>
References: <20220221140117.90284-1-detlev.casanova@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i2c0 device has 2 different busses controlled by a pinctrl.
This commit separates the device node into 2 i2c devices:
 * pin 0: Base i2c bus
 * pin 44: DSI i2c bus

i2c0 is renamed to i2c0if so that device-trees referencing i2c0 don't
break and use the i2c0 node defined in i2c0mux node.

i2c_csi_dsi can be used to control devices via the DSI i2c bus, used for
DSI displays.

Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
---
 arch/arm/boot/dts/bcm2711-rpi-4-b.dts         |  1 +
 arch/arm/boot/dts/bcm2711.dtsi                |  2 +-
 arch/arm/boot/dts/bcm2835-rpi.dtsi            |  9 ++++---
 .../boot/dts/bcm283x-rpi-i2c0mux_0_44.dtsi    |  4 +++
 arch/arm/boot/dts/bcm283x.dtsi                | 26 ++++++++++++++++++-
 5 files changed, 37 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm/boot/dts/bcm283x-rpi-i2c0mux_0_44.dtsi

diff --git a/arch/arm/boot/dts/bcm2711-rpi-4-b.dts b/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
index 4432412044de..5dcce58817e6 100644
--- a/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
+++ b/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
@@ -4,6 +4,7 @@
 #include "bcm2711-rpi.dtsi"
 #include "bcm283x-rpi-usb-peripheral.dtsi"
 #include "bcm283x-rpi-wifi-bt.dtsi"
+#include "bcm283x-rpi-i2c0mux_0_44.dtsi"
 
 / {
 	compatible = "raspberrypi,4-model-b", "brcm,bcm2711";
diff --git a/arch/arm/boot/dts/bcm2711.dtsi b/arch/arm/boot/dts/bcm2711.dtsi
index dff18fc9a906..96209ed89c36 100644
--- a/arch/arm/boot/dts/bcm2711.dtsi
+++ b/arch/arm/boot/dts/bcm2711.dtsi
@@ -1045,7 +1045,7 @@ &cma {
 	alloc-ranges = <0x0 0x00000000 0x40000000>;
 };
 
-&i2c0 {
+&i2c0if {
 	compatible = "brcm,bcm2711-i2c", "brcm,bcm2835-i2c";
 	interrupts = <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>;
 };
diff --git a/arch/arm/boot/dts/bcm2835-rpi.dtsi b/arch/arm/boot/dts/bcm2835-rpi.dtsi
index 87ddcad76083..1e38f9f0e80e 100644
--- a/arch/arm/boot/dts/bcm2835-rpi.dtsi
+++ b/arch/arm/boot/dts/bcm2835-rpi.dtsi
@@ -49,13 +49,16 @@ alt0: alt0 {
 	};
 };
 
-&i2c0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_gpio0>;
+&i2c0if {
 	status = "okay";
 	clock-frequency = <100000>;
 };
 
+&i2c0mux {
+	pinctrl-0 = <&i2c0_gpio0>;
+	status = "okay";
+};
+
 &i2c1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c1_gpio2>;
diff --git a/arch/arm/boot/dts/bcm283x-rpi-i2c0mux_0_44.dtsi b/arch/arm/boot/dts/bcm283x-rpi-i2c0mux_0_44.dtsi
new file mode 100644
index 000000000000..119946d878db
--- /dev/null
+++ b/arch/arm/boot/dts/bcm283x-rpi-i2c0mux_0_44.dtsi
@@ -0,0 +1,4 @@
+&i2c0mux {
+	pinctrl-0 = <&i2c0_gpio0>;
+	pinctrl-1 = <&i2c0_gpio44>;
+};
diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.dtsi
index c113661a6668..62d7ee513549 100644
--- a/arch/arm/boot/dts/bcm283x.dtsi
+++ b/arch/arm/boot/dts/bcm283x.dtsi
@@ -336,7 +336,7 @@ spi: spi@7e204000 {
 			status = "disabled";
 		};
 
-		i2c0: i2c@7e205000 {
+		i2c0if: i2c@7e205000 {
 			compatible = "brcm,bcm2835-i2c";
 			reg = <0x7e205000 0x200>;
 			interrupts = <2 21>;
@@ -346,6 +346,30 @@ i2c0: i2c@7e205000 {
 			status = "disabled";
 		};
 
+		i2c0mux: i2c0mux {
+			compatible = "i2c-mux-pinctrl";
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			i2c-parent = <&i2c0if>;
+
+			pinctrl-names = "i2c0", "i2c_csi_dsi";
+
+			status = "disabled";
+
+			i2c0: i2c@0 {
+				reg = <0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+
+			i2c_csi_dsi: i2c@1 {
+				reg = <1>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+		};
+
 		dpi: dpi@7e208000 {
 			compatible = "brcm,bcm2835-dpi";
 			reg = <0x7e208000 0x8c>;
-- 
2.35.1

