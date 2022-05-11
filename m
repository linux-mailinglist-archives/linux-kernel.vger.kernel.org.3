Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 576A25231D7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 13:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239248AbiEKLfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 07:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240403AbiEKLfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 07:35:25 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640B723887F;
        Wed, 11 May 2022 04:35:24 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id v11so2043856qkf.1;
        Wed, 11 May 2022 04:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TASe7e8staripPUTtHYJHBu8o4s+0xu3fkgvGutfur4=;
        b=lfpwdTliBUFOuGKLeYuoJowajrhtcHVr4wNf3BxOcCnDMTdpPbKWlJSo7e9o8Rai1T
         VcO1sP33hQT8oOxhrpLl2MOcwLeEoqdhNQPurF3O7u4ummg09F2ns8Qx/N+3nFy9JAKt
         V314hh0UmgQpeRXzKI6bw2l+Ez4uatHRJFopqlAMUvVieftkxyb3OjBwFYStV1KiK53L
         2SPZfEd7UKpwbBGfCPfbDvXX5tfTsMzP84EtZcX20o+GwRzPZjFjELnCBt9d+auGUVyl
         X1xLUvxmHK3Ux9bx6eQ4M2z2V2BXkIaW7Uq/7tTmXSxkA0uw+yppuWwWMQT6eGVcLwDu
         qapA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TASe7e8staripPUTtHYJHBu8o4s+0xu3fkgvGutfur4=;
        b=APfFikouAJxFRtPLLE4eQzD50uT1P86O9dDRc0YSDHQQSi5D3wSLVHgTeLQGn4MMVL
         9ez972k7J5hve0OzGB++TMYqgRrQqC5JKPdBx4bTBafQNhSDAuTzAWvLdwcR0lMHolIs
         WtnDLYC9/5FjKy8fwlwHuLcuR4jn1FeC7t1FJvsNU2V6e2FKgdUOjCpWNvWyXH5Racw7
         V2BowwPtVsQBJ7VecVNNmbo9HGvWAOs6IDaLg32MUUwHOVRSTOu6BSI5UT5XHaKvDwMs
         Fgxd7ZrD85ssvmtyRa4Cq7Sb5qsmtZhTtXD7i1kZQIeuaXQl99kBXgjH/dMQXqsJ5YZK
         IJrQ==
X-Gm-Message-State: AOAM533O6xNXxNUsfkdk4M1b0uIkGWtBtpOVuYzd0Ssu4N1+Ysl9h0Ci
        /rzzrvwvjbwv13KPrup/AeI=
X-Google-Smtp-Source: ABdhPJzKRwT45sGp+GMJgGVh5netETKrJdksDPYQxG4bvZtdsZuc4PeQRazYRe767WcLk6MecTlgVA==
X-Received: by 2002:a37:ad16:0:b0:6a0:1468:4513 with SMTP id f22-20020a37ad16000000b006a014684513mr18321635qkm.96.1652268923469;
        Wed, 11 May 2022 04:35:23 -0700 (PDT)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id bw26-20020a05622a099a00b002f39b99f6basm953377qtb.84.2022.05.11.04.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 04:35:23 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
To:     linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peter Geis <pgwipeout@gmail.com>
Subject: [PATCH v2 3/3] arm64: dts: rockchip: add pine64 touch panel display to rockpro64
Date:   Wed, 11 May 2022 07:35:16 -0400
Message-Id: <20220511113517.4172962-4-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220511113517.4172962-1-pgwipeout@gmail.com>
References: <20220511113517.4172962-1-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Pine64 touch panel is a panel consisting of the Feiyang fy07024di26a30d
panel with a Goodix gt911 touch screen. Add the device tree nodes to the
rockpro64 to permit attaching this display to the device.

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
---
 .../boot/dts/rockchip/rk3399-rockpro64.dtsi   | 80 ++++++++++++++++++-
 1 file changed, 76 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
index 45e77f86d329..f0fb450ddba6 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
@@ -20,6 +20,15 @@ chosen {
 		stdout-path = "serial2:1500000n8";
 	};
 
+	/* enable for panel backlight support */
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pwm0 0 1000000 0>;
+		brightness-levels = <0 4 8 16 32 64 128 255>;
+		default-brightness-level = <5>;
+		status = "disabled";
+	};
+
 	clkin_gmac: external-gmac-clock {
 		compatible = "fixed-clock";
 		clock-frequency = <125000000>;
@@ -220,6 +229,14 @@ vdd_log: vdd-log {
 		regulator-min-microvolt = <800000>;
 		regulator-max-microvolt = <1700000>;
 	};
+
+	avdd: avdd {
+		compatible = "regulator-fixed";
+		regulator-name = "avdd";
+		regulator-min-microvolt = <11000000>;
+		regulator-max-microvolt = <11000000>;
+		vin-supply = <&vcc3v3_s0>;
+	};
 };
 
 &cpu_l0 {
@@ -301,6 +318,11 @@ &hdmi {
 	status = "okay";
 };
 
+/* force hdmi to vopb */
+&hdmi_in_vopl {
+	status = "disabled";
+};
+
 &hdmi_sound {
 	status = "okay";
 };
@@ -400,8 +422,6 @@ regulator-state-mem {
 
 			vcc3v0_touch: LDO_REG2 {
 				regulator-name = "vcc3v0_touch";
-				regulator-always-on;
-				regulator-boot-on;
 				regulator-min-microvolt = <3000000>;
 				regulator-max-microvolt = <3000000>;
 				regulator-state-mem {
@@ -490,8 +510,6 @@ regulator-state-mem {
 
 			vcc3v3_s0: SWITCH_REG2 {
 				regulator-name = "vcc3v3_s0";
-				regulator-always-on;
-				regulator-boot-on;
 				regulator-state-mem {
 					regulator-off-in-suspend;
 				};
@@ -565,6 +583,19 @@ fusb0: typec-portc@22 {
 		vbus-supply = <&vcc5v0_typec>;
 		status = "okay";
 	};
+
+	/* enable for pine64 touch screen support */
+	touch: touchscreen@5d {
+		compatible = "goodix,gt911";
+		reg = <0x5d>;
+		AVDD28-supply = <&vcc3v0_touch>;
+		VDDIO-supply = <&vcc3v0_touch>;
+		interrupt-parent = <&gpio4>;
+		interrupts = <RK_PD5 IRQ_TYPE_EDGE_FALLING>;
+		irq-gpios = <&gpio4 RK_PD5 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&gpio4 RK_PD6 GPIO_ACTIVE_HIGH>;
+		status = "disabled";
+	};
 };
 
 &i2s0 {
@@ -600,6 +631,47 @@ &io_domains {
 	gpio1830-supply = <&vcc_3v0>;
 };
 
+/* enable for pine64 panel display support */
+&mipi_dsi {
+	status = "disabled";
+	clock-master;
+
+	ports {
+		mipi_out: port@1 {
+			reg = <1>;
+
+			mipi_out_panel: endpoint {
+				remote-endpoint = <&mipi_in_panel>;
+			};
+		};
+	};
+
+	mipi_panel: panel@0 {
+		compatible = "feiyang,fy07024di26a30d";
+		reg = <0>;
+		avdd-supply = <&avdd>;
+		backlight = <&backlight>;
+		dvdd-supply = <&vcc3v3_s0>;
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				mipi_in_panel: endpoint {
+					remote-endpoint = <&mipi_out_panel>;
+				};
+			};
+		};
+	};
+};
+
+/* force dsi to vopl */
+&mipi_in_vopb {
+	status="disabled";
+};
+
 &pcie0 {
 	ep-gpios = <&gpio2 RK_PD4 GPIO_ACTIVE_HIGH>;
 	num-lanes = <4>;
-- 
2.25.1

