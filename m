Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1605777B1
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 20:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232508AbiGQSKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 14:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbiGQSKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 14:10:19 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E14DFB5;
        Sun, 17 Jul 2022 11:10:17 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id d4so5010796ilc.8;
        Sun, 17 Jul 2022 11:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=745GMJpz3lSWbxLODZBtFB2ZMIv/EUuhk6yiHKFomYI=;
        b=e0hT/Sum0xdp5UNCix9q2gInMatAxLyvCTYaM2biynNLRA2RXv7aY+cFZ+ulmp9pTl
         xe2L9SvA1eGpDOnLrMq4FUEEo1k1K7i4LUV/LdkOjpmdG1lOXxnezEAg+qrQFcwh//qz
         syNXYHoxWC6uUIWXrx9sjcbSLZsPHnZTWnbd4Umr05Emd0/jSXG0QO5IiX1FxdjHbQ5B
         0XR3xx9O8so77nnkHyyP5/PDo3e+cy8SO3slIJTtdj5kjnnpALF1G+GNxEfZxrmTUeQQ
         4ugXM9Nvu9bjVpnAq9xEVg/iiEUvbCoi7TQbYV9OW6ocy9c68Pyj7Q5Z1gNtZ9DYmZ6o
         r7kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=745GMJpz3lSWbxLODZBtFB2ZMIv/EUuhk6yiHKFomYI=;
        b=42dIKQxVgm5tre8XHvetqI7SV701Q6xUkatGnkyRNNuJqWboOI5YS/e6lS+MDfBVp/
         AZmCgYkP3kZ0yyRo4z/D++mRsdKYPm1bl7IareuaMbL6xBbjDTNC2kufCrlJbkof1g7X
         3P12BPWy5S7G2BJJKz5+uDH6cwVwMQYxjQjD1uTToObENbi+XD9cMSSUJYqXdckqkRsG
         6EBh+SiSGSFOs8k29YGxyB2wgjEhYyewXANgOV5/6yQknQl6+wIvnXj60zWXxonblZ+G
         XlxPapB1HjZj7DNUhu1KN7fM/LtDr9FKcOZT1YV9pkHhYWUqL7VgKnn0Wu4VCLa6eeqf
         P6Nw==
X-Gm-Message-State: AJIora+1zq3LA0NIvO1jKHlUcovCymZLXqisJ43sCUTe0jwy2T5EyXc4
        IQyQEyR1GmNoefP8agqsziacKZ5PJq8=
X-Google-Smtp-Source: AGRyM1v2/+fAYqzjwLYpdUNOC8LrIDLhZzDwErhsmokGVtzPFy5usB+VtBpccWh4ugQYHobwLVmn7Q==
X-Received: by 2002:a92:b10:0:b0:2dc:e3e:195a with SMTP id b16-20020a920b10000000b002dc0e3e195amr11936574ilf.259.1658081416426;
        Sun, 17 Jul 2022 11:10:16 -0700 (PDT)
Received: from AIO.lan ([2601:448:8400:9e8:8e1b:7df0:7e10:ddb0])
        by smtp.gmail.com with ESMTPSA id f4-20020a056e0204c400b002dc1ea52967sm3869136ils.34.2022.07.17.11.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jul 2022 11:10:15 -0700 (PDT)
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
Subject: [PATCH 1/6] arm64: dts: imx8mn-beacon: Enable Digitial Microphone
Date:   Sun, 17 Jul 2022 13:09:55 -0500
Message-Id: <20220717181000.1186373-2-aford173@gmail.com>
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

There is a PDM microphone on the baseboard which is connected to the
micfil controller.  Create a new sound card to support this interface.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm64/boot/dts/freescale/imx8mn-beacon-baseboard.dtsi b/arch/arm64/boot/dts/freescale/imx8mn-beacon-baseboard.dtsi
index 9e82069c941f..fa66cc9bf455 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-beacon-baseboard.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn-beacon-baseboard.dtsi
@@ -63,7 +63,7 @@ reg_usb_otg_vbus: regulator-usb {
 		enable-active-high;
 	};
 
-	sound {
+	sound-codec {
 		compatible = "fsl,imx-audio-wm8962";
 		model = "wm8962-audio";
 		audio-cpu = <&sai3>;
@@ -76,6 +76,18 @@ sound {
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
 
 &ecspi2 {
@@ -150,6 +162,16 @@ &easrc {
 	status = "okay";
 };
 
+&micfil {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pdm>;
+	assigned-clocks = <&clk IMX8MN_CLK_PDM>;
+	assigned-clock-parents = <&clk IMX8MN_AUDIO_PLL1_OUT>;
+	assigned-clock-rates = <196608000>;
+	status = "okay";
+	#sound-dai-cells = <0>;
+};
+
 &sai3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_sai3>;
@@ -232,6 +254,13 @@ MX8MN_IOMUXC_SAI2_MCLK_GPIO4_IO27		0x19
 		>;
 	};
 
+	pinctrl_pdm: pdmgrp {
+		fsl,pins = <
+			MX8MN_IOMUXC_SAI5_RXC_PDM_CLK	0xd6
+			MX8MN_IOMUXC_SAI5_RXD0_PDM_BIT_STREAM0	0xd6
+		>;
+	};
+
 	pinctrl_reg_usb_otg: reg-otggrp {
 		fsl,pins = <
 			MX8MN_IOMUXC_SAI3_RXC_GPIO4_IO29     0x19
-- 
2.34.1

