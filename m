Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF6714FC06F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 17:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347888AbiDKPZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 11:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243212AbiDKPZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 11:25:10 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3AD73BBE4;
        Mon, 11 Apr 2022 08:22:51 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id c190-20020a1c35c7000000b0038e37907b5bso12403988wma.0;
        Mon, 11 Apr 2022 08:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dHT+2Pz3E8Ryq2hYcOXh5PKgBGdNhWwwwHyntc5u2ik=;
        b=DCN5hYPL3TOIgfntIt6LQldg0+mkVhN0+mCa0V4Fhv+OcBoOEMYfBtG0YwnZjfoATA
         wWRLHFHCTjfDBr0OnDfZ2HPXG4i+nIDYnez6smujxBAV7dlV9idjXDOhD968gTJT+3iT
         XvGhLDzE7ORk6MQH+jZHJ/6hC24m5IlOkQv31JfIMg4pvHL8DrIurgBhkVg2Uw42uHSy
         TdBIkFcn801Sy8s8rJ5qkpTg7yh0WimGR64xku1qRwNLRkk1KmJSO5v6OxBp34jB5BJL
         hzrXYc8fOkoKkMc/RXLSBYBMTIeSuo4SzofByFCZxFs83TkmFe6no1ejsvEo4lVxDzEk
         0FGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dHT+2Pz3E8Ryq2hYcOXh5PKgBGdNhWwwwHyntc5u2ik=;
        b=5UxngN0orS04JAYBSHETlH4XNWgxb+R1c7QxTJJzONhEM9fOrD/uLj+TJ+0X7b4mKf
         VB1SRTcPIaTY3KIREi6xLGpz8alEpZp9xSxq1dVyTuAnEIcvvhNXq9fXqkqE6f/foGff
         FX2StmZy45xb3HPM85M1zAFeQcUL8axGb9IKCTWtzkuJjpIXVbf6OFdvK6DLWpf7zkmE
         F1HT6Y1Tvyt7yrnFquIrLlHU//l6vS7uBETcWopTrA/Ms2Nu9yq06zlr1Nm5UPCLjkpL
         GKtJ2LRbysfTIO9VRxVAQnyo3G3tmmUjx6VkDVD5yJl4vk1N6sYGcE9LBxejXHVnbz+y
         6eiQ==
X-Gm-Message-State: AOAM531GcyHi652XZofSJ2qbmHCtGcGn0HJySWUedpoUki2w8b36Djb5
        lmsXYLoPYCSEEv2I3R2Cq+Y=
X-Google-Smtp-Source: ABdhPJy3nFu/hwIUXPeYBaVcqnuDaTm9nXde1AMXsLOvZJqJUi3Omd9v8Hxwiw16sg/xo8I6cXM1Dw==
X-Received: by 2002:a05:600c:1f0b:b0:38c:b121:c65f with SMTP id bd11-20020a05600c1f0b00b0038cb121c65fmr28833299wmb.124.1649690570416;
        Mon, 11 Apr 2022 08:22:50 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-124.static.upc.ch. [31.10.206.124])
        by smtp.gmail.com with ESMTPSA id a9-20020a7bc1c9000000b0038eb67e966esm5209374wmj.29.2022.04.11.08.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 08:22:50 -0700 (PDT)
From:   Max Krummenacher <max.oss.09@gmail.com>
To:     max.krummenacher@toradex.com
Cc:     Arnd Bergmann <arnd@arndb.de>, Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Olof Johansson <olof@lixom.net>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        soc@kernel.org
Subject: [PATCH v2 03/14] ARM: dts: imx6dl-colibri: Drop dedicated v1.1 device tree
Date:   Mon, 11 Apr 2022 17:22:23 +0200
Message-Id: <20220411152234.12678-4-max.oss.09@gmail.com>
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

Drop Colibri V1.1 device tree, this is just a duplicate of Colibri V1.0
with the possibility to use SD cards in UHS mode if the carrier board
does not have 3.3V pull up resistor.

The dedicated device tree kept the feature switched of by setting
the no-1-8-v property and thus does not offer anything different
than what the regular device tree does.

Thus drop the dedicated device tree and merge the preparation to
allow enabling the feature should a carrier without pull ups
be used into the regular device tree.

Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
---

(no changes since v1)

 arch/arm/boot/dts/Makefile                    |  1 -
 .../boot/dts/imx6dl-colibri-v1_1-eval-v3.dts  | 31 -------------
 .../boot/dts/imx6qdl-colibri-v1_1-uhs.dtsi    | 44 -------------------
 arch/arm/boot/dts/imx6qdl-colibri.dtsi        | 29 +++++++++++-
 4 files changed, 27 insertions(+), 78 deletions(-)
 delete mode 100644 arch/arm/boot/dts/imx6dl-colibri-v1_1-eval-v3.dts
 delete mode 100644 arch/arm/boot/dts/imx6qdl-colibri-v1_1-uhs.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 252353fb4e3b..ae3cac8e653b 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -459,7 +459,6 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
 	imx6dl-aristainetos2_4.dtb \
 	imx6dl-aristainetos2_7.dtb \
 	imx6dl-colibri-eval-v3.dtb \
-	imx6dl-colibri-v1_1-eval-v3.dtb \
 	imx6dl-cubox-i.dtb \
 	imx6dl-cubox-i-emmc-som-v15.dtb \
 	imx6dl-cubox-i-som-v15.dtb \
diff --git a/arch/arm/boot/dts/imx6dl-colibri-v1_1-eval-v3.dts b/arch/arm/boot/dts/imx6dl-colibri-v1_1-eval-v3.dts
deleted file mode 100644
index 223275f028f1..000000000000
--- a/arch/arm/boot/dts/imx6dl-colibri-v1_1-eval-v3.dts
+++ /dev/null
@@ -1,31 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+ OR MIT
-/*
- * Copyright 2020 Toradex
- */
-
-/dts-v1/;
-
-#include "imx6dl-colibri-eval-v3.dts"
-#include "imx6qdl-colibri-v1_1-uhs.dtsi"
-
-/ {
-	model = "Toradex Colibri iMX6DL/S V1.1 on Colibri Evaluation Board V3";
-	compatible = "toradex,colibri_imx6dl-v1_1-eval-v3",
-		     "toradex,colibri_imx6dl-v1_1",
-		     "toradex,colibri_imx6dl-eval-v3",
-		     "toradex,colibri_imx6dl",
-		     "fsl,imx6dl";
-};
-
-/* Colibri MMC */
-&usdhc1 {
-	status = "okay";
-	/*
-	 * Please make sure your carrier board does not pull-up any of
-	 * the MMC/SD signals to 3.3 volt before attempting to activate
-	 * UHS-I support.
-	 * To let signaling voltage be changed to 1.8V, please
-	 * delete no-1-8-v property (example below):
-	 * /delete-property/no-1-8-v;
-	 */
-};
diff --git a/arch/arm/boot/dts/imx6qdl-colibri-v1_1-uhs.dtsi b/arch/arm/boot/dts/imx6qdl-colibri-v1_1-uhs.dtsi
deleted file mode 100644
index 7672fbfc29be..000000000000
--- a/arch/arm/boot/dts/imx6qdl-colibri-v1_1-uhs.dtsi
+++ /dev/null
@@ -1,44 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+ OR MIT
-/*
- * Copyright 2020 Toradex
- */
-
-&iomuxc {
-	pinctrl_usdhc1_100mhz: usdhc1grp100mhz {
-		fsl,pins = <
-			MX6QDL_PAD_SD1_CMD__SD1_CMD    0x170b1
-			MX6QDL_PAD_SD1_CLK__SD1_CLK    0x100b1
-			MX6QDL_PAD_SD1_DAT0__SD1_DATA0 0x170b1
-			MX6QDL_PAD_SD1_DAT1__SD1_DATA1 0x170b1
-			MX6QDL_PAD_SD1_DAT2__SD1_DATA2 0x170b1
-			MX6QDL_PAD_SD1_DAT3__SD1_DATA3 0x170b1
-		>;
-	};
-
-	pinctrl_usdhc1_200mhz: usdhc1grp200mhz {
-		fsl,pins = <
-			MX6QDL_PAD_SD1_CMD__SD1_CMD    0x170f1
-			MX6QDL_PAD_SD1_CLK__SD1_CLK    0x100f1
-			MX6QDL_PAD_SD1_DAT0__SD1_DATA0 0x170f1
-			MX6QDL_PAD_SD1_DAT1__SD1_DATA1 0x170f1
-			MX6QDL_PAD_SD1_DAT2__SD1_DATA2 0x170f1
-			MX6QDL_PAD_SD1_DAT3__SD1_DATA3 0x170f1
-		>;
-	};
-};
-
-/* Colibri MMC */
-&usdhc1 {
-	pinctrl-names = "default", "state_100mhz", "state_200mhz";
-	pinctrl-0 = <&pinctrl_usdhc1 &pinctrl_mmc_cd>;
-	pinctrl-1 = <&pinctrl_usdhc1_100mhz &pinctrl_mmc_cd>;
-	pinctrl-2 = <&pinctrl_usdhc1_200mhz &pinctrl_mmc_cd>;
-	vmmc-supply = <&reg_module_3v3>;
-	vqmmc-supply = <&vgen3_reg>;
-	wakeup-source;
-	keep-power-in-suspend;
-	sd-uhs-sdr12;
-	sd-uhs-sdr25;
-	sd-uhs-sdr50;
-	sd-uhs-sdr104;
-};
diff --git a/arch/arm/boot/dts/imx6qdl-colibri.dtsi b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
index 4e2a309c93fa..16d38bc78b2a 100644
--- a/arch/arm/boot/dts/imx6qdl-colibri.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
@@ -370,11 +370,14 @@
 
 /* Colibri MMC */
 &usdhc1 {
-	pinctrl-names = "default";
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
 	pinctrl-0 = <&pinctrl_usdhc1 &pinctrl_mmc_cd>;
+	pinctrl-1 = <&pinctrl_usdhc1_100mhz &pinctrl_mmc_cd>;
+	pinctrl-2 = <&pinctrl_usdhc1_200mhz &pinctrl_mmc_cd>;
 	cd-gpios = <&gpio2 5 GPIO_ACTIVE_LOW>; /* MMCD */
 	disable-wp;
-	vqmmc-supply = <&reg_module_3v3>;
+	vmmc-supply = <&reg_module_3v3>;
+	vqmmc-supply = <&vgen3_reg>;
 	bus-width = <4>;
 	no-1-8-v;
 	status = "disabled";
@@ -692,6 +695,28 @@
 		>;
 	};
 
+	pinctrl_usdhc1_100mhz: usdhc1grp100mhz {
+		fsl,pins = <
+			MX6QDL_PAD_SD1_CMD__SD1_CMD    0x170b1
+			MX6QDL_PAD_SD1_CLK__SD1_CLK    0x100b1
+			MX6QDL_PAD_SD1_DAT0__SD1_DATA0 0x170b1
+			MX6QDL_PAD_SD1_DAT1__SD1_DATA1 0x170b1
+			MX6QDL_PAD_SD1_DAT2__SD1_DATA2 0x170b1
+			MX6QDL_PAD_SD1_DAT3__SD1_DATA3 0x170b1
+		>;
+	};
+
+	pinctrl_usdhc1_200mhz: usdhc1grp200mhz {
+		fsl,pins = <
+			MX6QDL_PAD_SD1_CMD__SD1_CMD    0x170f1
+			MX6QDL_PAD_SD1_CLK__SD1_CLK    0x100f1
+			MX6QDL_PAD_SD1_DAT0__SD1_DATA0 0x170f1
+			MX6QDL_PAD_SD1_DAT1__SD1_DATA1 0x170f1
+			MX6QDL_PAD_SD1_DAT2__SD1_DATA2 0x170f1
+			MX6QDL_PAD_SD1_DAT3__SD1_DATA3 0x170f1
+		>;
+	};
+
 	pinctrl_usdhc3: usdhc3grp {
 		fsl,pins = <
 			MX6QDL_PAD_SD3_CMD__SD3_CMD	0x17059
-- 
2.20.1

