Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59E1253DCCA
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 18:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351134AbiFEQGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 12:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345751AbiFEQFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 12:05:38 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5735C4DF47
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 09:05:33 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id n10so24740984ejk.5
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jun 2022 09:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DbDXrhv3IGv7hkgqZA1X2AggUMv4xlh4IdX76CRZ7RM=;
        b=mZKCLZu5xxTKyDgJM9/nCoxEQRZSfJ7IvHCP4pneKBrfLVSn4khaVRpNujuM6kJcP2
         KzsEFUExrMCnhFfXAm76lrfgEILCPJZkZvAd0c1Wz0lm7goTjMSIm5hMAKKCNz7vULip
         6NEYNdEbVlLoZt/FVUQFAaMCITS60EKJGU5M8ha05S5sLjjNm/XYcehnOCkc75WJd/A4
         pdxaLYn0ON6cMysVpjZvTx6Wf4fyC8THhTver0IUxgfFAiyTsW2YokfNH+MYsXt47sGo
         3x2kroc1F7Tr6IYm7d1YdDAjS5pT9KTXeNTrgIH45ZSetGSpeyh9vjW5jxYQNim2/iJ8
         orAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DbDXrhv3IGv7hkgqZA1X2AggUMv4xlh4IdX76CRZ7RM=;
        b=HU95JpA52LX4tg1M0x1I1nzkJ7Muqn0VTF6WuKH0T9mpOr2ZkJNj/aZW3oySPiPe8j
         /fOjYGnDa2mhLgnP1+aDQcHYJXWPInGRdIis55rhSy/4jCopC3XQOAJCeuDNiimZPxIy
         TtHWwhU1PWmIvNHJNBCqz50d6K1Xo1U5vmqT08qMgq+3A14RnJmuZ2fMTWAWUQHAanVG
         wrqH2C5aBKlBLKPp88ggKUrZ+dcih1zDuG0GCpVQHM4AJX83afkCj/QJFwC+4GfAFy1k
         7t5MpyCWaPs+20jH6wdVul75c5TuqtsLD2xJI9Uk2Ld8s7E0CVYHN4OMv+EBNC0b3VRX
         pL+A==
X-Gm-Message-State: AOAM533QeAt5RvqcTYpQE9K7+4eu9kxXGWMvNBn3evIt0EPwY7qpvqXD
        8au1UXYkl3NlN3gqMahfAOSH1Q==
X-Google-Smtp-Source: ABdhPJwRTkjIVHfR5IPXa9QvCNSsvUfnmYWBaTE4EGMOFgelTHtLX2D7QEoqL6P13yhijyLTTyEJCA==
X-Received: by 2002:a17:906:b294:b0:6fe:fdb9:5fb4 with SMTP id q20-20020a170906b29400b006fefdb95fb4mr17755065ejz.179.1654445131420;
        Sun, 05 Jun 2022 09:05:31 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id x18-20020a170906805200b0070b7875aa6asm3969963ejw.166.2022.06.05.09.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jun 2022 09:05:30 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Chanho Park <chanho61.park@samsung.com>
Subject: [PATCH v3 5/8] arm64: dts: exynos: use local header for pinctrl register values
Date:   Sun,  5 Jun 2022 18:05:05 +0200
Message-Id: <20220605160508.134075-6-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220605160508.134075-1-krzysztof.kozlowski@linaro.org>
References: <20220605160508.134075-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DTS uses hardware register values directly in pin controller pin
configuration.  These are not some IDs or other abstraction layer but
raw numbers used in the registers.

These numbers were previously put in the bindings header to avoid code
duplication and to provide some context meaning (name), but they do not
fit the purpose of bindings.

Store the constants in a header next to DTS and use them instead of
bindings.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Chanho Park <chanho61.park@samsung.com>
Tested-by: Chanho Park <chanho61.park@samsung.com>
---
 arch/arm64/boot/dts/exynos/exynos-pinctrl.h   | 79 +++++++++++++++++++
 .../boot/dts/exynos/exynos5433-pinctrl.dtsi   |  2 +-
 .../boot/dts/exynos/exynos7-espresso.dts      |  6 +-
 .../boot/dts/exynos/exynos7-pinctrl.dtsi      | 72 ++++++++---------
 .../boot/dts/exynos/exynos7885-pinctrl.dtsi   |  2 +-
 .../boot/dts/exynos/exynos850-pinctrl.dtsi    |  2 +-
 .../boot/dts/exynos/exynosautov9-pinctrl.dtsi |  2 +-
 7 files changed, 122 insertions(+), 43 deletions(-)
 create mode 100644 arch/arm64/boot/dts/exynos/exynos-pinctrl.h

diff --git a/arch/arm64/boot/dts/exynos/exynos-pinctrl.h b/arch/arm64/boot/dts/exynos/exynos-pinctrl.h
new file mode 100644
index 000000000000..7dd94a9b3652
--- /dev/null
+++ b/arch/arm64/boot/dts/exynos/exynos-pinctrl.h
@@ -0,0 +1,79 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Samsung Exynos DTS pinctrl constants
+ *
+ * Copyright (c) 2016 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ * Copyright (c) 2022 Linaro Ltd
+ * Author: Krzysztof Kozlowski <krzk@kernel.org>
+ */
+
+#ifndef __DTS_ARM64_SAMSUNG_EXYNOS_PINCTRL_H__
+#define __DTS_ARM64_SAMSUNG_EXYNOS_PINCTRL_H__
+
+#define EXYNOS_PIN_PULL_NONE		0
+#define EXYNOS_PIN_PULL_DOWN		1
+#define EXYNOS_PIN_PULL_UP		3
+
+/* Pin function in power down mode */
+#define EXYNOS_PIN_PDN_OUT0		0
+#define EXYNOS_PIN_PDN_OUT1		1
+#define EXYNOS_PIN_PDN_INPUT		2
+#define EXYNOS_PIN_PDN_PREV		3
+
+/*
+ * Drive strengths for Exynos5410, Exynos542x, Exynos5800, Exynos7885, Exynos850
+ * (except GPIO_HSI block), ExynosAutov9 (FSI0, PERIC1)
+ */
+#define EXYNOS5420_PIN_DRV_LV1		0
+#define EXYNOS5420_PIN_DRV_LV2		1
+#define EXYNOS5420_PIN_DRV_LV3		2
+#define EXYNOS5420_PIN_DRV_LV4		3
+
+/* Drive strengths for Exynos5433 */
+#define EXYNOS5433_PIN_DRV_FAST_SR1	0
+#define EXYNOS5433_PIN_DRV_FAST_SR2	1
+#define EXYNOS5433_PIN_DRV_FAST_SR3	2
+#define EXYNOS5433_PIN_DRV_FAST_SR4	3
+#define EXYNOS5433_PIN_DRV_FAST_SR5	4
+#define EXYNOS5433_PIN_DRV_FAST_SR6	5
+#define EXYNOS5433_PIN_DRV_SLOW_SR1	8
+#define EXYNOS5433_PIN_DRV_SLOW_SR2	9
+#define EXYNOS5433_PIN_DRV_SLOW_SR3	0xa
+#define EXYNOS5433_PIN_DRV_SLOW_SR4	0xb
+#define EXYNOS5433_PIN_DRV_SLOW_SR5	0xc
+#define EXYNOS5433_PIN_DRV_SLOW_SR6	0xf
+
+/* Drive strengths for Exynos7 (except FSYS1) */
+#define EXYNOS7_PIN_DRV_LV1		0
+#define EXYNOS7_PIN_DRV_LV2		2
+#define EXYNOS7_PIN_DRV_LV3		1
+#define EXYNOS7_PIN_DRV_LV4		3
+
+/* Drive strengths for Exynos7 FSYS1 block */
+#define EXYNOS7_FSYS1_PIN_DRV_LV1	0
+#define EXYNOS7_FSYS1_PIN_DRV_LV2	4
+#define EXYNOS7_FSYS1_PIN_DRV_LV3	2
+#define EXYNOS7_FSYS1_PIN_DRV_LV4	6
+#define EXYNOS7_FSYS1_PIN_DRV_LV5	1
+#define EXYNOS7_FSYS1_PIN_DRV_LV6	5
+
+/* Drive strengths for Exynos850 GPIO_HSI block */
+#define EXYNOS850_HSI_PIN_DRV_LV1	0	/* 1x   */
+#define EXYNOS850_HSI_PIN_DRV_LV1_5	1	/* 1.5x */
+#define EXYNOS850_HSI_PIN_DRV_LV2	2	/* 2x   */
+#define EXYNOS850_HSI_PIN_DRV_LV2_5	3	/* 2.5x */
+#define EXYNOS850_HSI_PIN_DRV_LV3	4	/* 3x   */
+#define EXYNOS850_HSI_PIN_DRV_LV4	5	/* 4x   */
+
+#define EXYNOS_PIN_FUNC_INPUT		0
+#define EXYNOS_PIN_FUNC_OUTPUT		1
+#define EXYNOS_PIN_FUNC_2		2
+#define EXYNOS_PIN_FUNC_3		3
+#define EXYNOS_PIN_FUNC_4		4
+#define EXYNOS_PIN_FUNC_5		5
+#define EXYNOS_PIN_FUNC_6		6
+#define EXYNOS_PIN_FUNC_EINT		0xf
+#define EXYNOS_PIN_FUNC_F		EXYNOS_PIN_FUNC_EINT
+
+#endif /* __DTS_ARM64_SAMSUNG_EXYNOS_PINCTRL_H__ */
diff --git a/arch/arm64/boot/dts/exynos/exynos5433-pinctrl.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-pinctrl.dtsi
index 4b46af3e164d..681553577ebc 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433-pinctrl.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433-pinctrl.dtsi
@@ -9,7 +9,7 @@
  * tree nodes are listed in this file.
  */
 
-#include <dt-bindings/pinctrl/samsung.h>
+#include "exynos-pinctrl.h"
 
 #define PIN(_pin, _func, _pull, _drv)					\
 	pin- ## _pin {							\
diff --git a/arch/arm64/boot/dts/exynos/exynos7-espresso.dts b/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
index 0895e818d3c1..e38c59cf18dc 100644
--- a/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
+++ b/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
@@ -357,7 +357,7 @@ &pinctrl_alive {
 	pmic_irq: pmic-irq-pins {
 		samsung,pins = "gpa0-2";
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
+		samsung,pin-drv = <EXYNOS7_PIN_DRV_LV4>;
 	};
 };
 
@@ -397,14 +397,14 @@ usb30_vbus_en: usb30-vbus-en-pins {
 		samsung,pins = "gph1-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-drv = <EXYNOS7_PIN_DRV_LV1>;
 	};
 
 	usb3drd_boost_en: usb3drd-boost-en-pins {
 		samsung,pins = "gpf4-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-drv = <EXYNOS7_PIN_DRV_LV1>;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/exynos/exynos7-pinctrl.dtsi b/arch/arm64/boot/dts/exynos/exynos7-pinctrl.dtsi
index be9b971f3697..ee9c24a226f3 100644
--- a/arch/arm64/boot/dts/exynos/exynos7-pinctrl.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos7-pinctrl.dtsi
@@ -9,7 +9,7 @@
  * device tree nodes in this file.
  */
 
-#include <dt-bindings/pinctrl/samsung.h>
+#include "exynos-pinctrl.h"
 
 &pinctrl_alive {
 	gpa0: gpa0-gpio-bank {
@@ -188,161 +188,161 @@ hs_i2c10_bus: hs-i2c10-bus-pins {
 		samsung,pins = "gpb0-1", "gpb0-0";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-drv = <EXYNOS7_PIN_DRV_LV1>;
 	};
 
 	hs_i2c11_bus: hs-i2c11-bus-pins {
 		samsung,pins = "gpb0-3", "gpb0-2";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-drv = <EXYNOS7_PIN_DRV_LV1>;
 	};
 
 	hs_i2c2_bus: hs-i2c2-bus-pins {
 		samsung,pins = "gpd0-3", "gpd0-2";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-drv = <EXYNOS7_PIN_DRV_LV1>;
 	};
 
 	uart0_data: uart0-data-pins {
 		samsung,pins = "gpd0-0", "gpd0-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-drv = <EXYNOS7_PIN_DRV_LV1>;
 	};
 
 	uart0_fctl: uart0-fctl-pins {
 		samsung,pins = "gpd0-2", "gpd0-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-drv = <EXYNOS7_PIN_DRV_LV1>;
 	};
 
 	uart2_data: uart2-data-pins {
 		samsung,pins = "gpd1-4", "gpd1-5";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-drv = <EXYNOS7_PIN_DRV_LV1>;
 	};
 
 	hs_i2c3_bus: hs-i2c3-bus-pins {
 		samsung,pins = "gpd1-3", "gpd1-2";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-drv = <EXYNOS7_PIN_DRV_LV1>;
 	};
 
 	uart1_data: uart1-data-pins {
 		samsung,pins = "gpd1-0", "gpd1-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-drv = <EXYNOS7_PIN_DRV_LV1>;
 	};
 
 	uart1_fctl: uart1-fctl-pins {
 		samsung,pins = "gpd1-2", "gpd1-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-drv = <EXYNOS7_PIN_DRV_LV1>;
 	};
 
 	hs_i2c0_bus: hs-i2c0-bus-pins {
 		samsung,pins = "gpd2-1", "gpd2-0";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-drv = <EXYNOS7_PIN_DRV_LV1>;
 	};
 
 	hs_i2c1_bus: hs-i2c1-bus-pins {
 		samsung,pins = "gpd2-3", "gpd2-2";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-drv = <EXYNOS7_PIN_DRV_LV1>;
 	};
 
 	hs_i2c9_bus: hs-i2c9-bus-pins {
 		samsung,pins = "gpd2-7", "gpd2-6";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-drv = <EXYNOS7_PIN_DRV_LV1>;
 	};
 
 	pwm0_out: pwm0-out-pins {
 		samsung,pins = "gpd2-4";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-drv = <EXYNOS7_PIN_DRV_LV1>;
 	};
 
 	pwm1_out: pwm1-out-pins {
 		samsung,pins = "gpd2-5";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-drv = <EXYNOS7_PIN_DRV_LV1>;
 	};
 
 	pwm2_out: pwm2-out-pins {
 		samsung,pins = "gpd2-6";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-drv = <EXYNOS7_PIN_DRV_LV1>;
 	};
 
 	pwm3_out: pwm3-out-pins {
 		samsung,pins = "gpd2-7";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-drv = <EXYNOS7_PIN_DRV_LV1>;
 	};
 
 	hs_i2c8_bus: hs-i2c8-bus-pins {
 		samsung,pins = "gpd5-3", "gpd5-2";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-drv = <EXYNOS7_PIN_DRV_LV1>;
 	};
 
 	uart3_data: uart3-data-pins {
 		samsung,pins = "gpd5-0", "gpd5-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-drv = <EXYNOS7_PIN_DRV_LV1>;
 	};
 
 	spi2_bus: spi2-bus-pins {
 		samsung,pins = "gpd5-0", "gpd5-1", "gpd5-2", "gpd5-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-drv = <EXYNOS7_PIN_DRV_LV1>;
 	};
 
 	spi1_bus: spi1-bus-pins {
 		samsung,pins = "gpd6-2", "gpd6-3", "gpd6-4", "gpd6-5";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-drv = <EXYNOS7_PIN_DRV_LV1>;
 	};
 
 	spi0_bus: spi0-bus-pins {
 		samsung,pins = "gpd8-0", "gpd8-1", "gpd6-0", "gpd6-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-drv = <EXYNOS7_PIN_DRV_LV1>;
 	};
 
 	hs_i2c4_bus: hs-i2c4-bus-pins {
 		samsung,pins = "gpg3-1", "gpg3-0";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-drv = <EXYNOS7_PIN_DRV_LV1>;
 	};
 
 	hs_i2c5_bus: hs-i2c5-bus-pins {
 		samsung,pins = "gpg3-3", "gpg3-2";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-drv = <EXYNOS7_PIN_DRV_LV1>;
 	};
 };
 
@@ -359,7 +359,7 @@ hs_i2c6_bus: hs-i2c6-bus-pins {
 		samsung,pins = "gpj0-1", "gpj0-0";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-drv = <EXYNOS7_PIN_DRV_LV1>;
 	};
 };
 
@@ -376,7 +376,7 @@ hs_i2c7_bus: hs-i2c7-bus-pins {
 		samsung,pins = "gpj1-1", "gpj1-0";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-drv = <EXYNOS7_PIN_DRV_LV1>;
 	};
 };
 
@@ -393,7 +393,7 @@ spi3_bus: spi3-bus-pins {
 		samsung,pins = "gpg4-0", "gpg4-1", "gpg4-2", "gpg4-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-drv = <EXYNOS7_PIN_DRV_LV1>;
 	};
 };
 
@@ -410,7 +410,7 @@ spi4_bus: spi4-bus-pins {
 		samsung,pins = "gpv7-0", "gpv7-1", "gpv7-2", "gpv7-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-drv = <EXYNOS7_PIN_DRV_LV1>;
 	};
 };
 
@@ -427,35 +427,35 @@ sd2_clk: sd2-clk-pins {
 		samsung,pins = "gpr4-0";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
+		samsung,pin-drv = <EXYNOS7_PIN_DRV_LV4>;
 	};
 
 	sd2_cmd: sd2-cmd-pins {
 		samsung,pins = "gpr4-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
+		samsung,pin-drv = <EXYNOS7_PIN_DRV_LV4>;
 	};
 
 	sd2_cd: sd2-cd-pins {
 		samsung,pins = "gpr4-2";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
+		samsung,pin-drv = <EXYNOS7_PIN_DRV_LV4>;
 	};
 
 	sd2_bus1: sd2-bus-width1-pins {
 		samsung,pins = "gpr4-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
+		samsung,pin-drv = <EXYNOS7_PIN_DRV_LV4>;
 	};
 
 	sd2_bus4: sd2-bus-width4-pins {
 		samsung,pins = "gpr4-4", "gpr4-5", "gpr4-6";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
+		samsung,pin-drv = <EXYNOS7_PIN_DRV_LV4>;
 	};
 };
 
@@ -683,20 +683,20 @@ spi5_bus: spi5-bus-pins {
 		samsung,pins = "gpf2-0", "gpf2-1", "gpf2-2", "gpf2-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-drv = <EXYNOS7_PIN_DRV_LV1>;
 	};
 
 	ufs_refclk_out: ufs-refclk-out-pins {
 		samsung,pins = "gpg2-4";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV2>;
+		samsung,pin-drv = <EXYNOS7_PIN_DRV_LV2>;
 	};
 
 	ufs_rst_n: ufs-rst-n-pins {
 		samsung,pins = "gph1-5";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-drv = <EXYNOS7_PIN_DRV_LV1>;
 	};
 };
diff --git a/arch/arm64/boot/dts/exynos/exynos7885-pinctrl.dtsi b/arch/arm64/boot/dts/exynos/exynos7885-pinctrl.dtsi
index a50c1dbd5545..34bb12191955 100644
--- a/arch/arm64/boot/dts/exynos/exynos7885-pinctrl.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos7885-pinctrl.dtsi
@@ -9,8 +9,8 @@
  * device tree nodes in this file.
  */
 
-#include <dt-bindings/pinctrl/samsung.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include "exynos-pinctrl.h"
 
 &pinctrl_alive {
 	etc0: etc0-gpio-bank {
diff --git a/arch/arm64/boot/dts/exynos/exynos850-pinctrl.dtsi b/arch/arm64/boot/dts/exynos/exynos850-pinctrl.dtsi
index f43e4a206282..424bc80bde68 100644
--- a/arch/arm64/boot/dts/exynos/exynos850-pinctrl.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos850-pinctrl.dtsi
@@ -10,7 +10,7 @@
  */
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
-#include <dt-bindings/pinctrl/samsung.h>
+#include "exynos-pinctrl.h"
 
 &pinctrl_alive {
 	gpa0: gpa0-gpio-bank {
diff --git a/arch/arm64/boot/dts/exynos/exynosautov9-pinctrl.dtsi b/arch/arm64/boot/dts/exynos/exynosautov9-pinctrl.dtsi
index ef0349d1c3d0..2a616d23c09f 100644
--- a/arch/arm64/boot/dts/exynos/exynosautov9-pinctrl.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynosautov9-pinctrl.dtsi
@@ -8,7 +8,7 @@
  * device tree nodes in this file.
  */
 
-#include <dt-bindings/pinctrl/samsung.h>
+#include "exynos-pinctrl.h"
 
 &pinctrl_alive {
 	gpa0: gpa0-gpio-bank {
-- 
2.34.1

