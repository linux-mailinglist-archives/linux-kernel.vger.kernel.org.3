Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0957553AA11
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 17:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346244AbiFAP2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 11:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355542AbiFAP2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 11:28:09 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4859A4739F
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 08:27:57 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id gi33so4526673ejc.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 08:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xkCtDUW8KDmXB613fVyiMXB2YkEaxXKxwnsWXEUT47c=;
        b=XiP4K+OXtb2g0sAVbW0Ke2qwQoraPZr10w0/Vtq1k4TkIRE0u3eyrJjQZe43kL6Dav
         0ZSeFadD2rPMIK9nkZSwaTUvt+Q59JnKkGT11v0vjEoD+RkBhgviiwz3JeBREIrYzweG
         dZls+QHYfxbcxzOvNqXjFjTfr5pqWXEfs6MMiSc+blzO213hf7lxfAUUCqRuaCKANMf9
         aftTQse8lDSa7syQNh+PcCG2f2+STlqhkbE5z70DLnPpxzLPCXd9twT1Hyl3IIidxKKA
         xgQ34hV625zUna8caTadBULW8PNRR1iTxczINECy+2bzW704DGgWqQF8mvAMYO0Ay1WC
         cT1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xkCtDUW8KDmXB613fVyiMXB2YkEaxXKxwnsWXEUT47c=;
        b=tkXr/jiwM4AK4qsQ9fPBpnIxYJ46Z83lByXMvHVKWj6b4VOuULBI9ItBFbjXRXJFn3
         ck4jykBod4HMZjz8VdzUCO1ncka4Sq07u4PvSlq5LcNm+LQ2zd+YB8NUdq+QiHXjlDzt
         y44LerUiTxUoYBVdstEdzsEDm+fZZaZbtrMEFyiGmG1TfBBjahkxf/OpFM1Lr5Bw+9gr
         4HcxmWi0pS0SOf4x0hoE0mS2W1TPBkeNdhGixhjFGlB+lWuOUKJmgVPQ8npfMTPaOLCN
         8Xg3VSuolgfOj0cf6ukWGxezqVuxp72OgecJpNyUy91cYL/XWW2tGsgDzDh+vzHR1SpM
         Ik1A==
X-Gm-Message-State: AOAM530Pft0TjQw7EUAF61O4ry/usX8N18ZH1m5aexHNWQZocglX/Y0h
        A8FF34cJw9Q1LBD1TJZwEXfA9w==
X-Google-Smtp-Source: ABdhPJzGUdJeCPAq3rdMERlG9nMzXccLGpPuKiSoDNm457/XviI9WvS5F1tm5ZIc1Ggy5IZD4IwCFg==
X-Received: by 2002:a17:907:1690:b0:6f5:40d:f4bb with SMTP id hc16-20020a170907169000b006f5040df4bbmr25515ejc.495.1654097275757;
        Wed, 01 Jun 2022 08:27:55 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id e13-20020a170906248d00b006fee7b5dff2sm845870ejb.143.2022.06.01.08.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 08:27:55 -0700 (PDT)
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
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 4/7] ARM: dts: exynos: use local header for pinctrl register values
Date:   Wed,  1 Jun 2022 17:27:17 +0200
Message-Id: <20220601152720.232383-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220601152720.232383-1-krzysztof.kozlowski@linaro.org>
References: <20220601152720.232383-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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
---
 arch/arm/boot/dts/exynos-pinctrl.h        | 55 +++++++++++++++++++++++
 arch/arm/boot/dts/exynos3250-pinctrl.dtsi |  2 +-
 arch/arm/boot/dts/exynos4210-pinctrl.dtsi |  2 +-
 arch/arm/boot/dts/exynos4412-midas.dtsi   |  3 +-
 arch/arm/boot/dts/exynos4412-p4note.dtsi  |  2 +-
 arch/arm/boot/dts/exynos4412-pinctrl.dtsi |  2 +-
 arch/arm/boot/dts/exynos5250-pinctrl.dtsi |  2 +-
 arch/arm/boot/dts/exynos5260-pinctrl.dtsi |  2 +-
 arch/arm/boot/dts/exynos5410-pinctrl.dtsi |  2 +-
 arch/arm/boot/dts/exynos5420-pinctrl.dtsi |  2 +-
 10 files changed, 65 insertions(+), 9 deletions(-)
 create mode 100644 arch/arm/boot/dts/exynos-pinctrl.h

diff --git a/arch/arm/boot/dts/exynos-pinctrl.h b/arch/arm/boot/dts/exynos-pinctrl.h
new file mode 100644
index 000000000000..e3a6df95281c
--- /dev/null
+++ b/arch/arm/boot/dts/exynos-pinctrl.h
@@ -0,0 +1,55 @@
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
+#ifndef __DTS_ARM_SAMSUNG_EXYNOS_PINCTRL_H__
+#define __DTS_ARM_SAMSUNG_EXYNOS_PINCTRL_H__
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
+/* Drive strengths for Exynos3250, Exynos4 (all) and Exynos5250 */
+#define EXYNOS4_PIN_DRV_LV1		0
+#define EXYNOS4_PIN_DRV_LV2		2
+#define EXYNOS4_PIN_DRV_LV3		1
+#define EXYNOS4_PIN_DRV_LV4		3
+
+/* Drive strengths for Exynos5260 */
+#define EXYNOS5260_PIN_DRV_LV1		0
+#define EXYNOS5260_PIN_DRV_LV2		1
+#define EXYNOS5260_PIN_DRV_LV4		2
+#define EXYNOS5260_PIN_DRV_LV6		3
+
+/*
+ * Drive strengths for Exynos5410, Exynos542x, Exynos5800 and Exynos850 (except
+ * GPIO_HSI block)
+ */
+#define EXYNOS5420_PIN_DRV_LV1		0
+#define EXYNOS5420_PIN_DRV_LV2		1
+#define EXYNOS5420_PIN_DRV_LV3		2
+#define EXYNOS5420_PIN_DRV_LV4		3
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
+#endif /* __DTS_ARM_SAMSUNG_EXYNOS_PINCTRL_H__ */
diff --git a/arch/arm/boot/dts/exynos3250-pinctrl.dtsi b/arch/arm/boot/dts/exynos3250-pinctrl.dtsi
index cc30d154ec94..011ba2eff29e 100644
--- a/arch/arm/boot/dts/exynos3250-pinctrl.dtsi
+++ b/arch/arm/boot/dts/exynos3250-pinctrl.dtsi
@@ -9,7 +9,7 @@
  * tree nodes are listed in this file.
  */
 
-#include <dt-bindings/pinctrl/samsung.h>
+#include "exynos-pinctrl.h"
 
 #define PIN_IN(_pin, _pull, _drv)					\
 	pin- ## _pin {							\
diff --git a/arch/arm/boot/dts/exynos4210-pinctrl.dtsi b/arch/arm/boot/dts/exynos4210-pinctrl.dtsi
index 6373009bb727..76f44ae0de46 100644
--- a/arch/arm/boot/dts/exynos4210-pinctrl.dtsi
+++ b/arch/arm/boot/dts/exynos4210-pinctrl.dtsi
@@ -11,7 +11,7 @@
  * tree nodes are listed in this file.
  */
 
-#include <dt-bindings/pinctrl/samsung.h>
+#include "exynos-pinctrl.h"
 
 &pinctrl_0 {
 	gpa0: gpa0-gpio-bank {
diff --git a/arch/arm/boot/dts/exynos4412-midas.dtsi b/arch/arm/boot/dts/exynos4412-midas.dtsi
index 23f50c9be527..b967397a46c5 100644
--- a/arch/arm/boot/dts/exynos4412-midas.dtsi
+++ b/arch/arm/boot/dts/exynos4412-midas.dtsi
@@ -12,11 +12,12 @@
 /dts-v1/;
 #include "exynos4412.dtsi"
 #include "exynos4412-ppmu-common.dtsi"
+
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/clock/maxim,max77686.h>
-#include <dt-bindings/pinctrl/samsung.h>
+#include "exynos-pinctrl.h"
 
 / {
 	compatible = "samsung,midas", "samsung,exynos4412", "samsung,exynos4";
diff --git a/arch/arm/boot/dts/exynos4412-p4note.dtsi b/arch/arm/boot/dts/exynos4412-p4note.dtsi
index 97f131b1014b..286a547b110e 100644
--- a/arch/arm/boot/dts/exynos4412-p4note.dtsi
+++ b/arch/arm/boot/dts/exynos4412-p4note.dtsi
@@ -15,8 +15,8 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/linux-event-codes.h>
 #include <dt-bindings/interrupt-controller/irq.h>
-#include <dt-bindings/pinctrl/samsung.h>
 #include <dt-bindings/power/summit,smb347-charger.h>
+#include "exynos-pinctrl.h"
 
 / {
 	compatible = "samsung,p4note", "samsung,exynos4412", "samsung,exynos4";
diff --git a/arch/arm/boot/dts/exynos4412-pinctrl.dtsi b/arch/arm/boot/dts/exynos4412-pinctrl.dtsi
index 88b8afd55664..58847d4fa846 100644
--- a/arch/arm/boot/dts/exynos4412-pinctrl.dtsi
+++ b/arch/arm/boot/dts/exynos4412-pinctrl.dtsi
@@ -9,7 +9,7 @@
  * tree nodes are listed in this file.
  */
 
-#include <dt-bindings/pinctrl/samsung.h>
+#include "exynos-pinctrl.h"
 
 #define PIN_SLP(_pin, _mode, _pull)					\
 	_pin {								\
diff --git a/arch/arm/boot/dts/exynos5250-pinctrl.dtsi b/arch/arm/boot/dts/exynos5250-pinctrl.dtsi
index 918947a3897e..48732edadff1 100644
--- a/arch/arm/boot/dts/exynos5250-pinctrl.dtsi
+++ b/arch/arm/boot/dts/exynos5250-pinctrl.dtsi
@@ -9,7 +9,7 @@
  * tree nodes are listed in this file.
  */
 
-#include <dt-bindings/pinctrl/samsung.h>
+#include "exynos-pinctrl.h"
 
 &pinctrl_0 {
 	gpa0: gpa0-gpio-bank {
diff --git a/arch/arm/boot/dts/exynos5260-pinctrl.dtsi b/arch/arm/boot/dts/exynos5260-pinctrl.dtsi
index 150607f8103d..43e4a541f479 100644
--- a/arch/arm/boot/dts/exynos5260-pinctrl.dtsi
+++ b/arch/arm/boot/dts/exynos5260-pinctrl.dtsi
@@ -9,7 +9,7 @@
  * tree nodes are listed in this file.
  */
 
-#include <dt-bindings/pinctrl/samsung.h>
+#include "exynos-pinctrl.h"
 
 &pinctrl_0 {
 	gpa0: gpa0-gpio-bank {
diff --git a/arch/arm/boot/dts/exynos5410-pinctrl.dtsi b/arch/arm/boot/dts/exynos5410-pinctrl.dtsi
index 6c7814b4372e..f7b923382892 100644
--- a/arch/arm/boot/dts/exynos5410-pinctrl.dtsi
+++ b/arch/arm/boot/dts/exynos5410-pinctrl.dtsi
@@ -6,7 +6,7 @@
  *              https://www.hardkernel.com
  */
 
-#include <dt-bindings/pinctrl/samsung.h>
+#include "exynos-pinctrl.h"
 
 &pinctrl_0 {
 	gpa0: gpa0-gpio-bank {
diff --git a/arch/arm/boot/dts/exynos5420-pinctrl.dtsi b/arch/arm/boot/dts/exynos5420-pinctrl.dtsi
index 546ba274f4e5..14cf9c4ca0ed 100644
--- a/arch/arm/boot/dts/exynos5420-pinctrl.dtsi
+++ b/arch/arm/boot/dts/exynos5420-pinctrl.dtsi
@@ -9,7 +9,7 @@
  * tree nodes are listed in this file.
  */
 
-#include <dt-bindings/pinctrl/samsung.h>
+#include "exynos-pinctrl.h"
 
 &pinctrl_0 {
 	gpy7: gpy7-gpio-bank {
-- 
2.34.1

