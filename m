Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCB024AAA99
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 18:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380716AbiBERbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 12:31:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243210AbiBERbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 12:31:15 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF20FC061348;
        Sat,  5 Feb 2022 09:31:14 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id q204so11435184iod.8;
        Sat, 05 Feb 2022 09:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B7ae3D4rUnPUq4I9rkec078QG4GFhhpI1PCfRmSdqos=;
        b=McF5SpS9uR6S3+wV5rih2BZn+qMTwPrlPwUEkJxqgxHwtuxY4ReOk9dRX/BsDuXSqA
         g3A9RAoyUANhoZTAsU9tGbXU7/uNnRk8PiWPHT+1+lm322xVAVFTVIs1jxuJoCGKt/GY
         Lv9xTskkBU6j8+AvHoPI0O5twj4Na0FDIqAjii4vObStOObLrEQbibhpHQk6pzlnJK9b
         rwbXMfznsjSKW1auXJ9DmgMCE4jv27ILw0LTKXjOhC0m2Psl9+PEjoNMI/T0BvqhMVyA
         1pgG0F4b4oWRmZaT0eYBmHiub2MNosMG3n1gFdDTcmwmcsV2qKlbcowRU8fjTYjlC2+r
         2hWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B7ae3D4rUnPUq4I9rkec078QG4GFhhpI1PCfRmSdqos=;
        b=xDWgyxhCCFRddfaCK3kOaTKhwLGpny2StknQ58O5IBwMHq7EB7ISeul5/xKTfPMjYP
         JZYfeNDBFf9AuDak313akQ1OcAtSa1RmqjBiM3kay7obaadZUi8D9oaa0vCjoH7Mxzk5
         wNaNTEHTmdrfJziLhpoAyxEuUFGaRoKGCJMaYC4dCCSx1NV5llJXywDtT8/Q+vQy7UOG
         HUduKHBtueYeuKOAzqVXAvLDB+EQGrfAFNOY6WTh/Lw/m4NcGTyN9QNicxBMQlGbNi9a
         5mmWgYjP4ZdpUvBCJfrfpS3paY14nLLRxEgMn8sU1QdE/bj7P1U6fnT4KgiRio5q4jSR
         Artg==
X-Gm-Message-State: AOAM532OhVohxf6ssindLeCe68d6CpRbk5sNgoft/nla3ewmELF4Ek5m
        RTGh8rO6zF6oiuiRruu4Jbk=
X-Google-Smtp-Source: ABdhPJyyUoWTSY4SmqrymwmRBM9J91E4h4KDEuhqUZtNHpf83yzAPDEu8RtaPhuYUT4zYQIcx6dJ2A==
X-Received: by 2002:a05:6638:1ea:: with SMTP id t10mr2119175jaq.77.1644082274143;
        Sat, 05 Feb 2022 09:31:14 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:3c7c:8f64:a6ca:72d3])
        by smtp.gmail.com with ESMTPSA id n3sm2750839ioz.9.2022.02.05.09.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Feb 2022 09:31:13 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: imx8mm-beacon: Enable PCIe
Date:   Sat,  5 Feb 2022 11:31:01 -0600
Message-Id: <20220205173102.970040-1-aford173@gmail.com>
X-Mailer: git-send-email 2.32.0
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

The baseboard supports a PCIe slot with a 100MHz reference clock,
but it's controlled by a different GPIO, so a gated clock is
required.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi
index 0fb95f4a5e78..1af3b0a7c4c1 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi
@@ -3,6 +3,8 @@
  * Copyright 2020 Compass Electronics Group, LLC
  */
 
+#include <dt-bindings/phy/phy-imx8-pcie.h>
+
 / {
 	leds {
 		compatible = "gpio-leds";
@@ -34,6 +36,19 @@ led3 {
 		};
 	};
 
+	pcie0_refclk: pcie0-refclk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <100000000>;
+	};
+
+	pcie0_refclk_gated:  pcie0-refclk-gated {
+		compatible = "gpio-gate-clock";
+		clocks = <&pcie0_refclk>;
+		#clock-cells = <0>;
+		enable-gpios = <&pca6416_1 2 GPIO_ACTIVE_LOW>;
+	};
+
 	reg_audio: regulator-audio {
 		compatible = "regulator-fixed";
 		regulator-name = "3v3_aud";
@@ -53,6 +68,16 @@ reg_camera: regulator-camera {
 		startup-delay-us = <100000>;
 	};
 
+	reg_pcie0: regulator-pcie {
+		compatible = "regulator-fixed";
+		regulator-name = "pci_pwr_en";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		enable-active-high;
+		gpio = <&pca6416_1 1 GPIO_ACTIVE_HIGH>;
+		startup-delay-us = <100000>;
+	};
+
 	reg_usdhc2_vmmc: regulator-usdhc2 {
 		compatible = "regulator-fixed";
 		regulator-name = "VSD_3V3";
@@ -191,6 +216,32 @@ imx8mm_mipi_csi_in: endpoint {
 	};
 };
 
+&pcie_phy {
+	fsl,refclk-pad-mode = <IMX8_PCIE_REFCLK_PAD_INPUT>;
+	fsl,tx-deemph-gen1 = <0x2d>;
+	fsl,tx-deemph-gen2 = <0xf>;
+	fsl,clkreq-unsupported;
+	clocks = <&pcie0_refclk_gated>;
+	clock-names = "ref";
+	status = "okay";
+};
+
+&pcie0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pcie0>;
+	reset-gpio = <&gpio4 21 GPIO_ACTIVE_LOW>;
+	clocks = <&clk IMX8MM_CLK_PCIE1_ROOT>, <&clk IMX8MM_CLK_PCIE1_AUX>,
+		 <&pcie0_refclk_gated>;
+	clock-names = "pcie", "pcie_aux", "pcie_bus";
+	assigned-clocks = <&clk IMX8MM_CLK_PCIE1_AUX>,
+			  <&clk IMX8MM_CLK_PCIE1_CTRL>;
+	assigned-clock-rates = <10000000>, <250000000>;
+	assigned-clock-parents = <&clk IMX8MM_SYS_PLL2_50M>,
+				 <&clk IMX8MM_SYS_PLL2_250M>;
+	vpcie-supply = <&reg_pcie0>;
+	status = "okay";
+};
+
 &sai3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_sai3>;
@@ -273,6 +324,12 @@ MX8MM_IOMUXC_SAI2_MCLK_GPIO4_IO27		0x19
 		>;
 	};
 
+	pinctrl_pcie0: pcie0grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SAI2_RXFS_GPIO4_IO21       0x41
+		>;
+	};
+
 	pinctrl_sai3: sai3grp {
 		fsl,pins = <
 			MX8MM_IOMUXC_SAI3_TXFS_SAI3_TX_SYNC     0xd6
-- 
2.32.0

