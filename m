Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF535777AE
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 20:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbiGQSKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 14:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiGQSKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 14:10:16 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2EDADFB5;
        Sun, 17 Jul 2022 11:10:15 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id 125so7747681iou.6;
        Sun, 17 Jul 2022 11:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U4N3gZV/nuDX3nI3v1SIMvgTdRQ6+jjx/bi21jCcF58=;
        b=fbMFkRxC5NTeyMwXvTwiDCLSGPFvItl2hxsrbmGsM+eu7gMvba4R9PHXt1ILQHDEiM
         oLAQkwjVRoeMG6POUBsNhbeS6/+CqpUtb+679XVYs3ZuAnv0lXrFuetcTdDpO1QIJ3wZ
         6RW6PQa8OgD1RWHLqNuN3ScgHVL5Wj4CUWXdHgEsvQCKuJqxAXPF6Q9TX5NBgaVA4lM0
         HJHu006+pZ5P5X1hHMTM5kvOu5Wy9W0eMl83CbwkJsFm7z1mSSZbCVCMfKHJLelHi7SA
         eAk8I5D39C/8dX74Ox3t6ndaDmU2dNRDtNn8uB3CDJjgg3QO8U+xNUI1mcP4j7IS05+X
         HYmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U4N3gZV/nuDX3nI3v1SIMvgTdRQ6+jjx/bi21jCcF58=;
        b=fat8ilt19+ceyKcRkuAcw2WfF2NE5t4qrGxMzNUqEbdVpGbyBkgdYXoV/mXhT/N1HW
         hpvuDKjn5gf6MyB2JmWClxp3BsbTJ/No/wYjQFak4KVKdtYZeQbxjv5uUo8652d418p5
         kOyyZK0sOtQuoPeM2YlwuN+VLldYygiuZQ635MPFb2TmYGlBPQUYVPkhV26HR45UjPNA
         GU3zrpQlKfmKutExoi3MANANIq2DV+wZaUC6jYq2Xp8P/EHn1YYmk5XwxNMfWZKRfbqW
         pkFM0yeRq9VRy+NngII4WhMV5Q1LJPjp/SL5+DdETCheKXb5DPle1h15UByqrUrXtwGk
         ZzAQ==
X-Gm-Message-State: AJIora/0CFGWPdk9PeqqpOiLSbZUN82OlopboosmYoZN+7lwJvJW4zjb
        Qjy1ZfDYhTof003sekR0ujpQI5quke4=
X-Google-Smtp-Source: AGRyM1uei0fCj7ox+EYWdwRgZ/KuxIPyuwugVxBWeEJui16Q35wWwqn04XegknYYIWwvnIuRRkhREg==
X-Received: by 2002:a6b:b40c:0:b0:67b:e564:f977 with SMTP id d12-20020a6bb40c000000b0067be564f977mr5612709iof.130.1658081414825;
        Sun, 17 Jul 2022 11:10:14 -0700 (PDT)
Received: from AIO.lan ([2601:448:8400:9e8:8e1b:7df0:7e10:ddb0])
        by smtp.gmail.com with ESMTPSA id f4-20020a056e0204c400b002dc1ea52967sm3869136ils.34.2022.07.17.11.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jul 2022 11:10:14 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Adam Ford <aford173@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: imx8mm-beacon: Enable Digitial Microphone
Date:   Sun, 17 Jul 2022 13:09:54 -0500
Message-Id: <20220717181000.1186373-1-aford173@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a PDM microphone port on the baseboard which is connected to the
micfil controller.  Create a new sound card to support this interface.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi
index 03266bd90a06..16444954f873 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi
@@ -98,7 +98,7 @@ reg_usdhc2_vmmc: regulator-usdhc2 {
 		enable-active-high;
 	};
 
-	sound {
+	sound-codec {
 		compatible = "fsl,imx-audio-wm8962";
 		model = "wm8962-audio";
 		audio-cpu = <&sai3>;
@@ -111,6 +111,18 @@ sound {
 			"AMIC", "MICBIAS",
 			"IN3R", "AMIC";
 	};
+
+	sound-micfil {
+		compatible = "fsl,imx-audio-card";
+		model = "imx-audio-micfil";
+		pri-dai-link {
+			link-name = "micfil hifi";
+			format = "i2s";
+			cpu {
+				sound-dai = <&micfil>;
+			};
+		};
+	};
 };
 
 &csi {
@@ -215,6 +227,16 @@ pca6416_1: gpio@21 {
 	};
 };
 
+&micfil {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pdm>;
+	assigned-clocks = <&clk IMX8MM_CLK_PDM>;
+	assigned-clock-parents = <&clk IMX8MM_AUDIO_PLL1_OUT>;
+	assigned-clock-rates = <196608000>;
+	#sound-dai-cells = <0>;
+	status = "okay";
+};
+
 &mipi_csi {
 	status = "okay";
 	ports {
@@ -354,6 +376,13 @@ MX8MM_IOMUXC_SAI2_MCLK_GPIO4_IO27		0x19
 		>;
 	};
 
+	pinctrl_pdm: pdmgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SAI5_RXC_PDM_CLK		0xd6
+			MX8MM_IOMUXC_SAI5_RXD0_PDM_DATA0	0xd6
+		>;
+	};
+
 	pinctrl_reg_usb_otg1: usbotg1grp {
 		fsl,pins = <
 			MX8MM_IOMUXC_SAI3_RXC_GPIO4_IO29     0x19
-- 
2.34.1

