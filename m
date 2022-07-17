Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C817E5777B6
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 20:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232813AbiGQSK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 14:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbiGQSKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 14:10:19 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4307DFC5;
        Sun, 17 Jul 2022 11:10:18 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id r70so6597569iod.10;
        Sun, 17 Jul 2022 11:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LQv1x1CMU9dHw2UgXHFEIhfhfWQgdyhgWe5xhYIl+Aw=;
        b=MoxhHZBfdUw0zj2to3W51BCEWcS781wXb+YEaAfQmg64gs2uhJ/xqO17VuQqEtsBUj
         9CUv7mCCK4SCAOFuLtV9dDjiHFFPSZqIWDMZcpi8WmlDJaS5z1ZImwRaM4HqaUSqPBa0
         HRnyfwMCxwJ/aoHlJ5oGOhVT5LexTCmdiXO8Dx5cBPVFZRiMplC/aoPCrKn5ZLDKQVb6
         jG0QFiF+copqOcwUNQWd7ghD4375e2DkccJ0vqeb8hsj+/wFSCfjAzczWxLN6ZnLagK6
         F579Lovn0gh22QOsjBvlck1Im8m6tO2SRy13I4oU2Xugd3vq1ncVijq5aQQM520q2aDJ
         gdFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LQv1x1CMU9dHw2UgXHFEIhfhfWQgdyhgWe5xhYIl+Aw=;
        b=U3SH/kXodw/FvI71XJYlBFEW/pak01EBhOVr8hrRk4abojs/cd5xxAf2qd5TZz61jn
         uEzdVvVcLlOTJB9ZkGDRdHUT9o+14yZxHpqPr+VCy4502yGMu8rYjKsBCborpuMFQ/55
         QicyTaqlpCYIzA+jvGKLSq2PmlDboMWirctBvuLW9Xgg7NwGMHEpqEeHM57gmLgvKCtS
         0fgEmcfbOycGWi8JAsDn72NHHZnu/YyW/vHIsSc5B6MBJ+/D0/50sC4/gMGrHw4wEebW
         OBsZ0sDnQJeIkE6kZM99blzz1U3JGMcpiz7FQRt1ksQ2+cMjq5xmg7EoC+imxYv2NAJz
         cYFQ==
X-Gm-Message-State: AJIora90vP8xy2+hKoP89JVHmCxhIDzDqM3W/Hxb9fYbdjHTsZaj74of
        YCeOeP2pPBQ4LydnWBuz+hU=
X-Google-Smtp-Source: AGRyM1uaZisKSzPYLJpZ/146FYQ5bV/X7yNEnpErDMR0d1EUVcrXhudBkfqGB9MWGyUgmS0y9V5Rvg==
X-Received: by 2002:a05:6638:4089:b0:33f:7f78:1cd2 with SMTP id m9-20020a056638408900b0033f7f781cd2mr13090903jam.130.1658081418027;
        Sun, 17 Jul 2022 11:10:18 -0700 (PDT)
Received: from AIO.lan ([2601:448:8400:9e8:8e1b:7df0:7e10:ddb0])
        by smtp.gmail.com with ESMTPSA id f4-20020a056e0204c400b002dc1ea52967sm3869136ils.34.2022.07.17.11.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jul 2022 11:10:17 -0700 (PDT)
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
Subject: [PATCH 2/6] arm64: dts: imx8mn-beacon: Enable SPDIF Sound card
Date:   Sun, 17 Jul 2022 13:09:56 -0500
Message-Id: <20220717181000.1186373-3-aford173@gmail.com>
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

diff --git a/arch/arm64/boot/dts/freescale/imx8mn-beacon-baseboard.dtsi b/arch/arm64/boot/dts/freescale/imx8mn-beacon-baseboard.dtsi
index fa66cc9bf455..224845d24b64 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-beacon-baseboard.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn-beacon-baseboard.dtsi
@@ -88,6 +88,14 @@ cpu {
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
 
 &ecspi2 {
@@ -186,6 +194,23 @@ &snvs_pwrkey {
 	status = "okay";
 };
 
+&spdif1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_spdif1>;
+	assigned-clocks = <&clk IMX8MN_CLK_SPDIF1>;
+	assigned-clock-parents = <&clk IMX8MN_AUDIO_PLL1_OUT>;
+	assigned-clock-rates = <24576000>;
+	clocks = <&clk IMX8MN_CLK_AUDIO_AHB>, <&clk IMX8MN_CLK_24M>,
+		<&clk IMX8MN_CLK_SPDIF1>, <&clk IMX8MN_CLK_DUMMY>,
+		<&clk IMX8MN_CLK_DUMMY>, <&clk IMX8MN_CLK_DUMMY>,
+		<&clk IMX8MN_CLK_AUDIO_AHB>, <&clk IMX8MN_CLK_DUMMY>,
+		<&clk IMX8MN_CLK_DUMMY>, <&clk IMX8MN_CLK_DUMMY>,
+		<&clk IMX8MN_AUDIO_PLL1_OUT>, <&clk IMX8MN_AUDIO_PLL2_OUT>;
+	clock-names = "core", "rxtx0", "rxtx1", "rxtx2", "rxtx3",
+		"rxtx4", "rxtx5", "rxtx6", "rxtx7", "spba", "pll8k", "pll11k";
+	status = "okay";
+};
+
 &uart2 { /* console */
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart2>;
@@ -277,6 +302,13 @@ MX8MN_IOMUXC_SAI3_RXD_SAI3_RX_DATA0	0xd6
 		>;
 	};
 
+	pinctrl_spdif1: spdif1grp {
+		fsl,pins = <
+			MX8MN_IOMUXC_SPDIF_TX_SPDIF1_OUT	0xd6
+			MX8MN_IOMUXC_SPDIF_RX_SPDIF1_IN	0xd6
+		>;
+	};
+
 	pinctrl_uart2: uart2grp {
 		fsl,pins = <
 			MX8MN_IOMUXC_UART2_RXD_UART2_DCE_RX	0x140
-- 
2.34.1

