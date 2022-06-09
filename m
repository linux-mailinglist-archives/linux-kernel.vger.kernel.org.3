Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E21A6545045
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 17:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344265AbiFIPKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 11:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344243AbiFIPJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 11:09:55 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 494513B091A;
        Thu,  9 Jun 2022 08:09:47 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id c2so31591257edf.5;
        Thu, 09 Jun 2022 08:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lx77UOaupWwlzkUixRuS3piMfwDqZ9k8cB+ZMRVws4c=;
        b=b1OgmnZHl9eXptVpFgW/BmfKWOfu0j0cY8FfPtRBIrAAWd0Rf9mHCC4bMsifWqhg0t
         hetfsmjMpvxLQXgm34pzHWReSZpV13NOKe0pZAyeAABjOnRXdMdygNi8tqLxuTYjUBwR
         yyJUs0X5Nom/cFTYiWONhTv8Hs71XcFiukmDWoE2h7SrdgTKD4S5nF8/fFipdSKxEWpL
         XXlHZVXbwnZ+yHysMCyCJAiDPoI/xtKqGcj91iHP0Aq4NRf0MTfSun6NWBpfeRed4Lri
         u+k0IjK9u7hqpWSTPlAEcHpQNKiK0TvzokqKwBnv6cPCVkBjRLV5lxZPGrkB/pEgJZFp
         iJKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lx77UOaupWwlzkUixRuS3piMfwDqZ9k8cB+ZMRVws4c=;
        b=DyTNsGn+5tm0Iev03QrSABFP/0zxZqKBV6mb3JZ/UXmPlug+LXA9FySeJlX3I/3byc
         BX4PpnsKO9q2okEg6qo0mvSCGAyalKnbVYIInvFjwDx92sD8QCQY5EWa3WyIlmi/LIBS
         /fdN21n8H7kyq33qu9oa82bpe8+r8iNk0k4HITpVqbRXqmc+S4YW9wxX0naj/kcd/hRm
         J7yyUwfk8cDtpQHoRVJcp/66maVGcgn6x7tXvtXGB6sK8GzZ93JwpOHnAUntEVO5XyKS
         ndO/09opctnGMy9BSehm8PzSSf6XIIjQ/bpHNUpigQb/GThLCLAutz5/rLXv0JJz/XhM
         sSFw==
X-Gm-Message-State: AOAM531H5LRVxOM3hMAAKnYm7zLorCjm4VPvu/8+PLMhO8/oT59RiSwm
        wcAzMyPCiE114cv2Ffe8b34TfS1Od20=
X-Google-Smtp-Source: ABdhPJxzzbRpgyXWvpRPFMQwauYPFOuiG70lGiC5OYNgL52n3WThXZoVrf9tG/vfL1CqbN89H4R9Mw==
X-Received: by 2002:a05:6402:e85:b0:41d:121b:f436 with SMTP id h5-20020a0564020e8500b0041d121bf436mr46130342eda.121.1654787385702;
        Thu, 09 Jun 2022 08:09:45 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id n24-20020aa7c698000000b0042bb229e81esm14395135edq.15.2022.06.09.08.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 08:09:44 -0700 (PDT)
From:   Max Krummenacher <max.oss.09@gmail.com>
To:     max.krummenacher@toradex.com
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 5/5] ARM64: verdin-imx8mm: use regulator power domain to model sleep-moci
Date:   Thu,  9 Jun 2022 17:08:51 +0200
Message-Id: <20220609150851.23084-6-max.oss.09@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220609150851.23084-1-max.oss.09@gmail.com>
References: <20220609150851.23084-1-max.oss.09@gmail.com>
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

The Verdin CTRL_SLEEP_MOCI# pin signals the carrier board that the module
is in sleep and it may switch off unneeded power.

Control this pin with a regulator power domain controller which uses a
fixed regulator with a gpio enable.

Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>

---

 .../dts/freescale/imx8mm-verdin-dahlia.dtsi   |  1 +
 .../boot/dts/freescale/imx8mm-verdin-dev.dtsi |  2 ++
 .../boot/dts/freescale/imx8mm-verdin.dtsi     | 35 +++++++++++++------
 3 files changed, 28 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-verdin-dahlia.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-verdin-dahlia.dtsi
index c2a5c2f7b204..03416dc593d8 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-verdin-dahlia.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-verdin-dahlia.dtsi
@@ -92,6 +92,7 @@
 
 /* Verdin PCIE_1 */
 &pcie0 {
+	power-domains = <&pd_sleep_moci>;
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-verdin-dev.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-verdin-dev.dtsi
index 73cc3fafa018..f887b907fdde 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-verdin-dev.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-verdin-dev.dtsi
@@ -50,6 +50,7 @@
 	/* Audio Codec */
 	nau8822_1a: audio-codec@1a {
 		compatible = "nuvoton,nau8822";
+		power-domains = <&pd_sleep_moci>;
 		reg = <0x1a>;
 	};
 };
@@ -59,6 +60,7 @@
 	linux,rs485-enabled-at-boot-time;
 	rs485-rts-active-low;
 	rs485-rx-during-tx;
+	power-domains = <&pd_sleep_moci>;
 };
 
 /* Limit frequency on dev board due to long traces and bad signal integrity */
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
index eafa88d980b3..b5daa8f83bef 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
@@ -53,6 +53,14 @@
 		};
 	};
 
+	pd_sleep_moci: power-domain-sleep-moci {
+		compatible = "regulator-pm-pd";
+		label = "pd_sleep_moci";
+		power-domains = <&pgc_pcie>;
+		power-supply = <&reg_sleep_moci>;
+		#power-domain-cells = <0>;
+	};
+
 	/* Carrier Board Supplies */
 	reg_1p8v: regulator-1p8v {
 		compatible = "regulator-fixed";
@@ -90,6 +98,19 @@
 		startup-delay-us = <200000>;
 	};
 
+	reg_sleep_moci: regulator-sleep-moci {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio5 1 GPIO_ACTIVE_HIGH>;
+		off-on-delay = <2000>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_ctrl_sleep_moci>;
+		regulator-max-microvolt = <1800000>;
+		regulator-min-microvolt = <1800000>;
+		regulator-name = "CTRL_SLEEP_MOCI#";
+		startup-delay-us = <2000>;
+	};
+
 	reg_usb_otg1_vbus: regulator-usb-otg1 {
 		compatible = "regulator-fixed";
 		enable-active-high;
@@ -109,6 +130,7 @@
 		gpio = <&gpio1 14 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_reg_usb2_en>;
+		power-domains = <&pd_sleep_moci>;
 		regulator-max-microvolt = <5000000>;
 		regulator-min-microvolt = <5000000>;
 		regulator-name = "USB_2_EN";
@@ -198,6 +220,7 @@
 		interrupts-extended = <&gpio1 6 IRQ_TYPE_EDGE_FALLING>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_can1_int>;
+		power-domains = <&pd_sleep_moci>;
 		reg = <0>;
 		spi-max-frequency = <8500000>;
 	};
@@ -305,16 +328,6 @@
 			  "SODIMM_212",
 			  "SODIMM_151",
 			  "SODIMM_153";
-
-	ctrl-sleep-moci-hog {
-		gpio-hog;
-		/* Verdin CTRL_SLEEP_MOCI# (SODIMM 256) */
-		gpios = <1 GPIO_ACTIVE_HIGH>;
-		line-name = "CTRL_SLEEP_MOCI#";
-		output-high;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_ctrl_sleep_moci>;
-	};
 };
 
 /* On-module I2C */
@@ -560,6 +573,7 @@
 		enable-gpios = <&gpio3 3 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_gpio_10_dsi>;
+		power-domains = <&pd_sleep_moci>;
 		reg = <0x2c>;
 		status = "disabled";
 	};
@@ -576,6 +590,7 @@
 		compatible = "lontium,lt8912b";
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_gpio_10_dsi>, <&pinctrl_pwm_3_dsi_hpd_gpio>;
+		power-domains = <&pd_sleep_moci>;
 		reg = <0x48>;
 		/* Verdin GPIO_9_DSI (LT8912 INT, SODIMM 17, unused) */
 		/* Verdin GPIO_10_DSI (SODIMM 21) */
-- 
2.20.1

