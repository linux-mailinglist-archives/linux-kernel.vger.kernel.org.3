Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18DBE4FC082
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 17:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347953AbiDKP0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 11:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347914AbiDKPZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 11:25:23 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A002D3C70F;
        Mon, 11 Apr 2022 08:22:57 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id i7-20020a1c3b07000000b0038eb92fa965so782756wma.4;
        Mon, 11 Apr 2022 08:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OzbWjh8sKV/ROSexmDdz4skMJ4dtzVR35i5rogX6hBA=;
        b=f2Hvmt9PMiv6gaKXCm7yk/XPQRNqZqAtiF5G6lNwBgLFryXkKVt+sQEpdFg1N2Xwpi
         AsYw+Yxtegv7+3ardT+lu+B17otLqWylzchTt360a9LPmuUpVOP2y+fUIDRor1+Ge6qs
         Pm2f+Do9pnRs4aTs78WsC5Eg89Wjcsxlaa0lRG1Zd3N4KBoCNtNePfT00k/pQBLUfErx
         mozkJQl+abVVUmhSDGt1wQBAPQi0/5QxEcZE6exVoMLkEAhaJ0VAw6dENqBg+iPlla87
         DRe8fx1TYnGTHP9GgUfO+yDpPrbcP0GwO723TT40CFy1j0RK3kMJt1ZWb33k/W44mCSO
         Ueeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OzbWjh8sKV/ROSexmDdz4skMJ4dtzVR35i5rogX6hBA=;
        b=vaPxsI999Fgz5IPDsOPlyaQ7O+QzcpEzhlnB36EKNT54tFBoXlNHTb7e6nsTjKYrWz
         6qbVWxMY0dUKl0Vzbk46XwOBp6VmWmCeUPMu4MmsqxcltGszmlMz+m1A2iwN9kzSgkH8
         LNSYE9gt7qS3DcbYSYpVEjT2xo2aF4Bn4rT+6VcNTeGD/vIRbdxWUgydYkrLu9e3poyQ
         l+lPdvgUn9vy97ajfwgHGU1Znf+/SMSIiyuV7vBoV6Jn7iP+ZJ/cf+v1+lMsji63CPHg
         kzNW6GG6Z6kRr/DxH/HQOGYgvxSRkuM0FW79gk1JTsPWpA2mnU7O1IdAU75N09MWgCcO
         ge2w==
X-Gm-Message-State: AOAM530jqykFidX2M20hfxVXhUA9Tp7BmN5jB0MjX14P4UHR4fWm37V4
        F7Kk4L0zk7QI6WMVJftfsRU=
X-Google-Smtp-Source: ABdhPJwqmQ6enx856HE3pcJUbewHjC+52+2/gNX0rAbEdAfaCpeGf0hb2lNVVv7wA8VdB2p2Y9QnRQ==
X-Received: by 2002:a7b:ce99:0:b0:38e:b72a:382c with SMTP id q25-20020a7bce99000000b0038eb72a382cmr8092362wmj.128.1649690576192;
        Mon, 11 Apr 2022 08:22:56 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-124.static.upc.ch. [31.10.206.124])
        by smtp.gmail.com with ESMTPSA id a9-20020a7bc1c9000000b0038eb67e966esm5209374wmj.29.2022.04.11.08.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 08:22:55 -0700 (PDT)
From:   Max Krummenacher <max.oss.09@gmail.com>
To:     max.krummenacher@toradex.com
Cc:     Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/14] ARM: dts: imx6dl-colibri: Move common nodes to SoM dtsi
Date:   Mon, 11 Apr 2022 17:22:29 +0200
Message-Id: <20220411152234.12678-10-max.oss.09@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220411152234.12678-1-max.oss.09@gmail.com>
References: <20220411152234.12678-1-max.oss.09@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Max Krummenacher <max.krummenacher@toradex.com>

The following two nodes define module level functionality, move
them from the carrier board dts file to the SoM file.
While at it, reorder the properties in the gpio-keys node alphabetical.

- gpio-keys defining the wakeup pin
- memory node

The atmel touchscreen node can be used on any carrier board.
Move it from the carrier board to the module-level device tree and
keep it disabled.
Set the default pinmuxing to the dedicated connector available
on newer carrier boards and rename the pinctrl labels specifying
the INT/Reset signal to a common pattern.
  pinctrl_atmel_conn - uses 107/106 pins as used on dedicated connector
  pinctrl_atmel_adap - uses 28/30 pins as used with jumper wires

Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
---

(no changes since v1)

 arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts | 49 ------------------
 arch/arm/boot/dts/imx6qdl-colibri.dtsi       | 53 ++++++++++++++++++++
 2 files changed, 53 insertions(+), 49 deletions(-)

diff --git a/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts b/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts
index 535b5c156229..dff2d35e693b 100644
--- a/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts
+++ b/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts
@@ -17,12 +17,6 @@
 	compatible = "toradex,colibri_imx6dl-eval-v3", "toradex,colibri_imx6dl",
 		     "fsl,imx6dl";
 
-	/* Will be filled by the bootloader */
-	memory@10000000 {
-		device_type = "memory";
-		reg = <0x10000000 0>;
-	};
-
 	aliases {
 		i2c0 = &i2c2;
 		i2c1 = &i2c3;
@@ -44,20 +38,6 @@
 		clock-frequency = <16000000>;
 		clock-output-names = "clk16m";
 	};
-
-	gpio-keys {
-		compatible = "gpio-keys";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_gpio_keys>;
-
-		wakeup {
-			label = "Wake-Up";
-			gpios = <&gpio2 22 GPIO_ACTIVE_HIGH>; /* SODIMM 45 */
-			linux,code = <KEY_WAKEUP>;
-			debounce-interval = <10>;
-			wakeup-source;
-		};
-	};
 };
 
 /* Colibri SSP */
@@ -81,21 +61,6 @@
 &i2c3 {
 	status = "okay";
 
-	/*
-	 * Touchscreen is using SODIMM 28/30, also used for PWM<B>, PWM<C>,
-	 * aka pwm2, pwm3. so if you enable touchscreen, disable the pwms
-	 */
-	touchscreen@4a {
-		compatible = "atmel,maxtouch";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_pcap_1>;
-		reg = <0x4a>;
-		interrupt-parent = <&gpio1>;
-		interrupts = <9 IRQ_TYPE_EDGE_FALLING>;		/* SODIMM 28 */
-		reset-gpios = <&gpio2 10 GPIO_ACTIVE_LOW>;	/* SODIMM 30 */
-		status = "disabled";
-	};
-
 	/* M41T0M6 real time clock on carrier board */
 	rtc_i2c: rtc@68 {
 		compatible = "st,m41t0";
@@ -111,20 +76,6 @@
 		&pinctrl_weim_gpio_5 &pinctrl_weim_gpio_6
 		&pinctrl_usbh_oc_1 &pinctrl_usbc_id_1
 	>;
-
-	pinctrl_pcap_1: pcap1grp {
-		fsl,pins = <
-			MX6QDL_PAD_GPIO_9__GPIO1_IO09	0x1b0b0 /* SODIMM 28 */
-			MX6QDL_PAD_SD4_DAT2__GPIO2_IO10	0x1b0b0 /* SODIMM 30 */
-		>;
-	};
-
-	pinctrl_mxt_ts: mxttsgrp {
-		fsl,pins = <
-			MX6QDL_PAD_EIM_CS1__GPIO2_IO24	0x130b0 /* SODIMM 107 */
-			MX6QDL_PAD_SD2_DAT1__GPIO1_IO14	0x130b0 /* SODIMM 106 */
-		>;
-	};
 };
 
 &pwm1 {
diff --git a/arch/arm/boot/dts/imx6qdl-colibri.dtsi b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
index 3459bfb5c60b..1c49fd3e6286 100644
--- a/arch/arm/boot/dts/imx6qdl-colibri.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
@@ -23,6 +23,20 @@
 		status = "disabled";
 	};
 
+	gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_keys>;
+
+		wakeup {
+			debounce-interval = <10>;
+			gpios = <&gpio2 22 GPIO_ACTIVE_HIGH>; /* SODIMM 45 */
+			label = "Wake-Up";
+			linux,code = <KEY_WAKEUP>;
+			wakeup-source;
+		};
+	};
+
 	lcd_display: disp0 {
 		compatible = "fsl,imx-parallel-display";
 		interface-pix-fmt = "bgr666";
@@ -50,6 +64,12 @@
 		};
 	};
 
+	/* Will be filled by the bootloader */
+	memory@10000000 {
+		device_type = "memory";
+		reg = <0x10000000 0>;
+	};
+
 	panel_dpi: panel-dpi {
 		/*
 		 * edt,et057090dhu: EDT 5.7" LCD TFT
@@ -564,6 +584,17 @@
 	scl-gpios = <&gpio1 3 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 	sda-gpios = <&gpio1 6 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 	status = "disabled";
+
+	atmel_mxt_ts: touchscreen@4a {
+		compatible = "atmel,maxtouch";
+		interrupt-parent = <&gpio2>;
+		interrupts = <24 IRQ_TYPE_EDGE_FALLING>;	/* SODIMM 107 */
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_atmel_conn>;
+		reg = <0x4a>;
+		reset-gpios = <&gpio1 14 GPIO_ACTIVE_HIGH>;	/* SODIMM 106 */
+		status = "disabled";
+	};
 };
 
 &ipu1_di0_disp0 {
@@ -682,6 +713,28 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usbh_oc_1>;
 
+	/* Atmel MXT touchsceen + Capacitive Touch Adapter */
+	/* NOTE: This pin group conflicts with pin groups
+	 * pinctrl_pwm1/pinctrl_pwm4. Don't use them simultaneously.
+	 */
+	pinctrl_atmel_adap: atmeladaptergrp {
+		fsl,pins = <
+			MX6QDL_PAD_GPIO_9__GPIO1_IO09   0xb0b1  /* SODIMM  28 */
+			MX6QDL_PAD_SD4_DAT2__GPIO2_IO10 0xb0b1  /* SODIMM  30 */
+		>;
+	};
+
+	/* Atmel MXT touchsceen + boards with built-in Capacitive Touch Connector */
+	/* NOTE: This pin group conflicts with pin groups pinctrl_weim_cs1 and
+	 * pinctrl_weim_cs2. Don't use them simultaneously.
+	 */
+	pinctrl_atmel_conn: atmelconnectorgrp {
+		fsl,pins = <
+			MX6QDL_PAD_EIM_CS1__GPIO2_IO24  0xb0b1  /* SODIMM_107 */
+			MX6QDL_PAD_SD2_DAT1__GPIO1_IO14 0xb0b1  /* SODIMM_106 */
+		>;
+	};
+
 	pinctrl_audmux: audmuxgrp {
 		fsl,pins = <
 			MX6QDL_PAD_KEY_COL0__AUD5_TXC	0x130b0
-- 
2.20.1

