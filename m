Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1829A471E70
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 23:59:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbhLLW7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 17:59:41 -0500
Received: from mail.wizzup.org ([95.217.97.174]:44004 "EHLO wizzup.org"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230088AbhLLW7h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 17:59:37 -0500
X-Greylist: delayed 1497 seconds by postgrey-1.27 at vger.kernel.org; Sun, 12 Dec 2021 17:59:37 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=wizzup.org;
        s=mail; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=5DMTAtnX0dwbB4pzMdMP9C9FA35ra736TcCnoY+8mIg=; b=sd3SqY497G6Ct6bleLCcdmA1OU
        cZ2RVc/Hy/elb10NqGHPLuxWR0agsG+9KtLBAQ5v2XfnKtI4ua3Vkua+NXGUhlKU2UAUXRszEhF1N
        tSSAdV+O6ZXzEJ7QPhTkSXk8Esc2BCUZXPBsYPoSuSrTEFkV2BMSPBHeEXZgWscXCtseUepCAN8dV
        zOtKM++IlUlEPiSg/hSnOCIqpSgxqu1+xI1Dxp7e8cK0PQDkaWfbuqP2+OYHs+hzpyZQmLRd1F9lO
        p2mU5DwZbcPvSXEuNl3Twc7g/b0EbUQw/eIr2BupEPQLnL1Q6a1KoMySD3o6liqKMVX8V34zO9ASt
        E3uUaSyA==;
Received: from [45.83.235.159] (helo=gentoo-x13.fritz.box)
        by wizzup.org with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <merlijn@wizzup.org>)
        id 1mwXoZ-0001el-SE; Sun, 12 Dec 2021 22:59:32 +0000
From:   Merlijn Wajer <merlijn@wizzup.org>
To:     merlijn@wizzup.org
Cc:     Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        Dev Null <devnull@uvos.xyz>, Tony Lindgren <tony@atomide.com>,
        Sebastian Reichel <sre@kernel.org>, linux-omap@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/2] Droid3: add initial DTS
Date:   Mon, 13 Dec 2021 00:04:59 +0100
Message-Id: <20211212230459.13579-3-merlijn@wizzup.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211212230459.13579-1-merlijn@wizzup.org>
References: <20211212230459.13579-1-merlijn@wizzup.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not everything works yet, but a lot does work:

* serial
* display
* keyboard
* touchscreen
* slider/power button

What doesn't work yet:

* display backlight
* keyboard backlight

Signed-off-by: Merlijn Wajer <merlijn@wizzup.org>
---
 arch/arm/boot/dts/Makefile                    |   1 +
 .../boot/dts/motorola-mapphone-common.dtsi    |   4 +-
 arch/arm/boot/dts/omap4-droid3-xt862.dts      | 163 ++++++++++++++++++
 3 files changed, 166 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/boot/dts/omap4-droid3-xt862.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 7e0934180724..7ea8441817e5 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -874,6 +874,7 @@ dtb-$(CONFIG_SOC_AM33XX) += \
 	am335x-osd3358-sm-red.dtb
 dtb-$(CONFIG_ARCH_OMAP4) += \
 	omap4-droid-bionic-xt875.dtb \
+	omap4-droid3-xt862.dtb \
 	omap4-droid4-xt894.dtb \
 	omap4-duovero-parlor.dtb \
 	omap4-kc1.dtb \
diff --git a/arch/arm/boot/dts/motorola-mapphone-common.dtsi b/arch/arm/boot/dts/motorola-mapphone-common.dtsi
index bf18ff33d900..d0d1a1b1676c 100644
--- a/arch/arm/boot/dts/motorola-mapphone-common.dtsi
+++ b/arch/arm/boot/dts/motorola-mapphone-common.dtsi
@@ -19,7 +19,7 @@ aliases {
 	 * We seem to have only 1021 MB accessible, 1021 - 1022 is locked,
 	 * then 1023 - 1024 seems to contain mbm.
 	 */
-	memory {
+	memory0: memory {
 		device_type = "memory";
 		reg = <0x80000000 0x3fd00000>;	/* 1021 MB */
 	};
@@ -35,7 +35,7 @@ reserved-memory {
 		 * first 512K of that and just overwrite the rest and configure
 		 * only 384K instead of 2M.
 		 */
-		ramoops@a0080000 {
+		ramoops0: ramoops@a0080000 {
 			compatible = "ramoops";
 			reg = <0xa0080000 0x60000>;
 			record-size = <0x20000>;
diff --git a/arch/arm/boot/dts/omap4-droid3-xt862.dts b/arch/arm/boot/dts/omap4-droid3-xt862.dts
new file mode 100644
index 000000000000..f3a7175301ec
--- /dev/null
+++ b/arch/arm/boot/dts/omap4-droid3-xt862.dts
@@ -0,0 +1,163 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/dts-v1/;
+
+#include "motorola-mapphone-common.dtsi"
+
+/ {
+	model = "Motorola Droid 3 XT862";
+	compatible = "motorola,droid3", "ti,omap4430", "ti,omap4";
+
+	/*
+	 * We use pad 0x4a100116 abe_dmic_din3.gpio_122 as the irq instead
+	 * of the gpio interrupt to avoid lost events in deeper idle states.
+	 */
+	gpio_keys {
+		compatible = "gpio-keys";
+
+		slider {
+			label = "Keypad Slide";
+			interrupts-extended = <&omap4_pmx_core 0xd6>;
+			gpios = <&gpio4 26 GPIO_ACTIVE_HIGH>; /* gpio122 */
+			linux,input-type = <EV_SW>;
+			linux,code = <SW_KEYPAD_SLIDE>;
+			linux,can-disable;
+			/* Value above 7.95ms for no GPIO hardware debounce */
+			debounce-interval = <10>;
+		};
+	};
+};
+
+// Do don't know if pstore is supported, but the current config causes panics,
+// so delete the node for now
+/delete-node/ &ramoops0;
+
+&memory0 {
+	reg = <0x80000000 0x1fd00000>;	/* 509 MB */
+};
+
+&dsi1_out_ep {
+	lanes = <1 0 3 2 5 4>;
+};
+
+&i2c1 {
+	led-controller@38 {
+		compatible = "ti,lm3532";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x38>;
+
+		enable-gpios = <&gpio6 12 GPIO_ACTIVE_HIGH>;
+
+		ramp-up-us = <1024>;
+		ramp-down-us = <8193>;
+
+		backlight_led: led@0 {
+			reg = <0>;
+			led-sources = <2>;
+			ti,led-mode = <0>;
+			label = ":backlight";
+		};
+
+		led@1 {
+			reg = <1>;
+			led-sources = <1>;
+			ti,led-mode = <0>;
+			label = ":kbd_backlight";
+		};
+	};
+};
+
+&i2c4 {
+	kxtf9: accelerometer@f {
+		compatible = "kionix,kxtf9";
+		reg = <0x0f>;
+
+		vdd-supply = <&vhvio>;
+
+		interrupt-parent = <&gpio2>;
+		interrupts = <2 IRQ_TYPE_EDGE_RISING>;
+
+		rotation-matrix = "1", "0", "0",
+				  "0", "1", "0",
+				  "0", "0", "1";
+	};
+};
+
+&aes2_target {
+	status = "disabled";
+};
+
+&keypad {
+	keypad,num-rows = <8>;
+	keypad,num-columns = <8>;
+	linux,keymap = <
+
+	/* Row 1 */
+	MATRIX_KEY(0, 2, KEY_1)
+	MATRIX_KEY(0, 6, KEY_2)
+	MATRIX_KEY(2, 3, KEY_3)
+	MATRIX_KEY(0, 7, KEY_4)
+	MATRIX_KEY(0, 4, KEY_5)
+	MATRIX_KEY(5, 5, KEY_6)
+	MATRIX_KEY(0, 1, KEY_7)
+	MATRIX_KEY(0, 5, KEY_8)
+	MATRIX_KEY(0, 0, KEY_9)
+	MATRIX_KEY(1, 6, KEY_0)
+
+	/* Row 2 */
+	MATRIX_KEY(3, 4, KEY_APOSTROPHE)
+	MATRIX_KEY(7, 6, KEY_Q)
+	MATRIX_KEY(7, 7, KEY_W)
+	MATRIX_KEY(7, 2, KEY_E)
+	MATRIX_KEY(1, 0, KEY_R)
+	MATRIX_KEY(4, 4, KEY_T)
+	MATRIX_KEY(1, 2, KEY_Y)
+	MATRIX_KEY(6, 7, KEY_U)
+	MATRIX_KEY(2, 2, KEY_I)
+	MATRIX_KEY(5, 6, KEY_O)
+	MATRIX_KEY(3, 7, KEY_P)
+	MATRIX_KEY(6, 5, KEY_BACKSPACE)
+
+	/* Row 3 */
+	MATRIX_KEY(5, 4, KEY_TAB)
+	MATRIX_KEY(7, 5, KEY_A)
+	//MATRIX_KEY(5, 7, KEY_A)
+	MATRIX_KEY(2, 7, KEY_S)
+	MATRIX_KEY(7, 0, KEY_D)
+	MATRIX_KEY(2, 6, KEY_F)
+	MATRIX_KEY(6, 2, KEY_G)
+	MATRIX_KEY(6, 6, KEY_H)
+	MATRIX_KEY(1, 4, KEY_J)
+	MATRIX_KEY(3, 1, KEY_K)
+	MATRIX_KEY(2, 1, KEY_L)
+	MATRIX_KEY(4, 6, KEY_ENTER)
+
+	/* Row 4 */
+	MATRIX_KEY(3, 6, KEY_LEFTSHIFT)		/* KEY_CAPSLOCK */
+	MATRIX_KEY(6, 1, KEY_Z)
+	MATRIX_KEY(7, 4, KEY_X)
+	MATRIX_KEY(5, 1, KEY_C)
+	MATRIX_KEY(1, 7, KEY_V)
+	MATRIX_KEY(2, 4, KEY_B)
+	MATRIX_KEY(4, 1, KEY_N)
+	MATRIX_KEY(1, 1, KEY_M)
+	MATRIX_KEY(3, 5, KEY_COMMA)
+	MATRIX_KEY(5, 2, KEY_DOT)
+	MATRIX_KEY(6, 3, KEY_UP)
+	MATRIX_KEY(7, 3, KEY_OK)
+
+	/* Row 5 */
+	MATRIX_KEY(2, 5, KEY_LEFTCTRL)		/* KEY_LEFTSHIFT */
+	MATRIX_KEY(4, 5, KEY_LEFTALT)		/* SYM */
+	MATRIX_KEY(6, 0, KEY_MINUS)
+	MATRIX_KEY(4, 7, KEY_EQUAL)
+	MATRIX_KEY(1, 5, KEY_SPACE)
+	MATRIX_KEY(3, 2, KEY_SLASH)
+	MATRIX_KEY(4, 3, KEY_LEFT)
+	MATRIX_KEY(5, 3, KEY_DOWN)
+	MATRIX_KEY(3, 3, KEY_RIGHT)
+
+	MATRIX_KEY(5, 0, KEY_VOLUMEUP)
+	MATRIX_KEY(3, 0, KEY_VOLUMEDOWN)
+	>;
+};
-- 
2.32.0

