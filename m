Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7C35777B9
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 20:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233027AbiGQSKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 14:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232017AbiGQSKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 14:10:22 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC3EDFE1;
        Sun, 17 Jul 2022 11:10:22 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id m20so5014038ili.3;
        Sun, 17 Jul 2022 11:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U4N3gZV/nuDX3nI3v1SIMvgTdRQ6+jjx/bi21jCcF58=;
        b=JfgS3R2XbWOPDaDrENl1ZF0O1KehxV8V/JNqmsaLJCswDHYm5np2VXukYtiFBUlq8T
         oAnr4nQiJvq9IvZm3O5fkqnCnLOyUE4kjxChuVe/Bxd+CNJiRv3ePvUDp13ptJjJiBuI
         OfiA0EOa0vi8XSkdlzZ4DI8Kh3cs5p+eYYzqFmmRnV/2LeLzdIcHlw1NDfUU4meZnT4u
         PiTw9jZiHXuc3OLoF2/UCR/UyirihdBUjYO3CvVY6/8ivhCL5l5odgcBdwWuRSQ5hNpO
         haITtP/gWt1f4iSSXWzX/aFd/7dLwqEjhM1/5mwa0QqWUBuv4Hp+sMwFSp7bybLZGkKo
         FtMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U4N3gZV/nuDX3nI3v1SIMvgTdRQ6+jjx/bi21jCcF58=;
        b=h/cgIK7MqJ3nU+Y8J+qhhBqEqAWAoypjrtjZM0hi4nIck/vSTBJZoZ5wUOmyik859P
         364ms9kn5yOFC2tuSODQjoLxnldCRga5mFOKLIbUW5PmERf1NTAHmminRnZZwLATJ4fP
         8lj/TFk9QonusWP0uy2/oLaeyCj//B9SD6FL1QkYYGdqMwCMHN+FW+beDN8MwTjewP54
         mY3sRaGhiJeketCrseZ6a5CGHmsgsG/NBbsIxHGmR7DQNM6EkcbwsdzvOjImk8bDO1T/
         FZpZ4qWtjKtGQpgnTMeFRXPqqfUtyjvCYqJzU1bwWRVsuyxxpjDu7x4pqiz0rOVPHUNI
         Jaxw==
X-Gm-Message-State: AJIora9znB8+9ACkckse5QfzQQxP5tmKp41vikginKDfppRjEKlF1d+g
        Xx61U9osLhQRMaKMahJQnGg=
X-Google-Smtp-Source: AGRyM1vO3Wc7qvfGOgOCzISWXHVQCBBaY6Jk8Fi/kFUEx3QsqUryEzvG4amTpJK9FG+BQ0TY8PXNVg==
X-Received: by 2002:a05:6e02:19cc:b0:2db:f05e:676c with SMTP id r12-20020a056e0219cc00b002dbf05e676cmr11130994ill.212.1658081421501;
        Sun, 17 Jul 2022 11:10:21 -0700 (PDT)
Received: from AIO.lan ([2601:448:8400:9e8:8e1b:7df0:7e10:ddb0])
        by smtp.gmail.com with ESMTPSA id f4-20020a056e0204c400b002dc1ea52967sm3869136ils.34.2022.07.17.11.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jul 2022 11:10:20 -0700 (PDT)
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
Subject: [PATCH 4/6] arm64: dts: imx8mm-beacon: Enable Digitial Microphone
Date:   Sun, 17 Jul 2022 13:09:58 -0500
Message-Id: <20220717181000.1186373-5-aford173@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220717181000.1186373-1-aford173@gmail.com>
References: <20220717181000.1186373-1-aford173@gmail.com>
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

