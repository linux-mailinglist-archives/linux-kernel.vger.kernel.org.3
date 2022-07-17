Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 680B55777B7
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 20:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232660AbiGQSKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 14:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232667AbiGQSK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 14:10:26 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 951DC13F18;
        Sun, 17 Jul 2022 11:10:23 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id d4so5010901ilc.8;
        Sun, 17 Jul 2022 11:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bR99Ry5I8XOx6eiXpUBvuyzFcUYxLa/QeGPkfsdFL9M=;
        b=ZKFieejT1uRDajIygnXihJYzjwYxq2ZsisyAC/sWFjarNKwqb+1I+PQNHv6qiZ0688
         WAnWDKo8RJkSOz46P9lR7sLsTsmIe1Mk7EXlqPJ/UeFbgcG8a/GE08ycVCIL9tnFxyoY
         Nqm6DF1XDXeaNQjt05sjwK4Qb0VgEHtpjRsJdT6tTtQKv+YZtsDsp0cKLhanZcaRNhyk
         DAhNudPOeNRlzkPsJQDdq0MQH+wRflRfz9g3ouqoboJ70Ircw0wQePCQR/QJxBzleNhd
         rDxqudzJ0ftPWZHJg7JNooE03crgRwoZn1vNs+rX+in0F/1c1lAXhamVEMD6o/4gDIXc
         s7Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bR99Ry5I8XOx6eiXpUBvuyzFcUYxLa/QeGPkfsdFL9M=;
        b=GLEVmIEWlON27gcfSV/8MG0z+c2Iyn/dWv+yxaT1SCygfU0udfFAedtqmly+HFhLQ9
         X+pFxpmuJ+n6oQBzcPMIMGNJWpGcP4Uf8E9dXsLRg5Gu45zksxi8wRGstuVRk0Nkaf5p
         iiO9AC4OCvoa5rBqruL3M4JCDzmZAMqDBRDchZLX0pjAoc/NZT+mw941YhslWr8Vm2XR
         kE+xcj0ZcoqlC3/YZk9NyUn/n5EIDzTViUTBUH41sq7Rd9Xv5XDsKoYfG36jT6XjleCW
         8HKk7OS6HZouUfxR7d+pC34AMhZECHRxHijmeoqW504+D8GEN8wPv4laLX0adJ66XgDt
         rs4Q==
X-Gm-Message-State: AJIora+LmmT5JWiYGKC6yFJsXve3VcV4gWGXEKnIBWLTVvJZ9Q0oJ73q
        w7aqx+im9R2nqzstsBvyqqrd0YnO2ys=
X-Google-Smtp-Source: AGRyM1v7z4/H26vIdYR/gwVBm4entsqxzrDHUwNvDYebtDJXftJBweneLsl+IrrHMOZSu6X9uopPUQ==
X-Received: by 2002:a05:6e02:19cc:b0:2db:f435:61f3 with SMTP id r12-20020a056e0219cc00b002dbf43561f3mr12356543ill.130.1658081423187;
        Sun, 17 Jul 2022 11:10:23 -0700 (PDT)
Received: from AIO.lan ([2601:448:8400:9e8:8e1b:7df0:7e10:ddb0])
        by smtp.gmail.com with ESMTPSA id f4-20020a056e0204c400b002dc1ea52967sm3869136ils.34.2022.07.17.11.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jul 2022 11:10:22 -0700 (PDT)
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
Subject: [PATCH 5/6] arm64: dts: imx8mm-beacon: Enable SPDIF Sound card
Date:   Sun, 17 Jul 2022 13:09:59 -0500
Message-Id: <20220717181000.1186373-6-aford173@gmail.com>
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

Add a sound card to support SPDIF since the imx8mn-beacon baseboard
can support it.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi
index 16444954f873..c41359c74c50 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi
@@ -123,6 +123,14 @@ cpu {
 			};
 		};
 	};
+
+	sound-spdif {
+		compatible = "fsl,imx-audio-spdif";
+		model = "imx-spdif";
+		spdif-controller = <&spdif1>;
+		spdif-out;
+		spdif-in;
+	};
 };
 
 &csi {
@@ -289,6 +297,23 @@ &snvs_pwrkey {
 	status = "okay";
 };
 
+&spdif1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_spdif1>;
+	assigned-clocks = <&clk IMX8MM_CLK_SPDIF1>;
+	assigned-clock-parents = <&clk IMX8MM_AUDIO_PLL1_OUT>;
+	assigned-clock-rates = <24576000>;
+	clocks = <&clk IMX8MM_CLK_AUDIO_AHB>, <&clk IMX8MM_CLK_24M>,
+		<&clk IMX8MM_CLK_SPDIF1>, <&clk IMX8MM_CLK_DUMMY>,
+		<&clk IMX8MM_CLK_DUMMY>, <&clk IMX8MM_CLK_DUMMY>,
+		<&clk IMX8MM_CLK_AUDIO_AHB>, <&clk IMX8MM_CLK_DUMMY>,
+		<&clk IMX8MM_CLK_DUMMY>, <&clk IMX8MM_CLK_DUMMY>,
+		<&clk IMX8MM_AUDIO_PLL1_OUT>, <&clk IMX8MM_AUDIO_PLL2_OUT>;
+	clock-names = "core", "rxtx0", "rxtx1", "rxtx2", "rxtx3",
+		"rxtx4", "rxtx5", "rxtx6", "rxtx7", "spba", "pll8k", "pll11k";
+	status = "okay";
+};
+
 &uart2 { /* console */
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart2>;
@@ -405,6 +430,14 @@ MX8MM_IOMUXC_SAI3_RXD_SAI3_RX_DATA0	0xd6
 		>;
 	};
 
+	pinctrl_spdif1: spdif1grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SPDIF_TX_SPDIF1_OUT	0xd6
+			MX8MM_IOMUXC_SPDIF_RX_SPDIF1_IN		0xd6
+			MX8MM_IOMUXC_SPDIF_EXT_CLK_SPDIF1_EXT_CLK	0xd6
+		>;
+	};
+
 	pinctrl_uart2: uart2grp {
 		fsl,pins = <
 			MX8MM_IOMUXC_UART2_RXD_UART2_DCE_RX	0x140
-- 
2.34.1

