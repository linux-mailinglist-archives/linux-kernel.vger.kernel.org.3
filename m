Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 610D85350D7
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 16:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347721AbiEZOhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 10:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347669AbiEZOhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 10:37:33 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F81DCFE14
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 07:37:27 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id rq11so3430363ejc.4
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 07:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WJmcWhJedvtcAjo+j/3Du5ncLIVMWf7SK53AaOQi+fo=;
        b=SN7wiGemmQNeEVblaLi2mtCv6WB0+wyJ0SdVyzC6EUv2g4/3z+qxLmJQT3IRU3cFpX
         DArpt1KyWOljFY7tI77RmdCdjH5zoi2TIK51Ng5OfFbN1bk+zNjaWz1aLDtBtpByyAVk
         NFiZvZsh5qmlqmGS/nauBCgoiPAXQWC8lokCIQ/8cUQZlN6Gt+Im8+8IANBt6VnXBfZk
         ypR45lFNI7bVSsz63n597M0r0WsVnpibxrPgMqGwn0oAfbxRKL3kucN1n5vBtDuYWx1F
         /DOnoNT6yRj6HOYfki2nRRO6Fap+ZWcGoXQsXC5ibsP55h7zSwI48rVRwrthshkLkMz9
         e2bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WJmcWhJedvtcAjo+j/3Du5ncLIVMWf7SK53AaOQi+fo=;
        b=Uf6TRDNWwFkxcgp1XaZrnufOnZqiSqe8QWA88ajGB/KqGmADhAC5Rkt+CY9bfzJFuJ
         vJ2uhQHtM9CXHIlYMK4MWUIpPzGtKhQAe0J/3G+jESJDVNwke3SWVzGEN+WcV0/ZX94D
         TK87FvoKOjh9tzmcTlhyTCxSI+uD93qcHFA5s/HcDrY5cyskHc4TKhDetdpiCJVhc7Fj
         8Hxvmde/rvA88U/oxxPHWZX7+e3CBg1ei86A1rwx83uN/+rp3dWa1uQW63tyqKMLT0o0
         WIkYUHxXjT8HROiUfY8qC/GVV7j6xr4RPtxuFvv2yuv55CcwWLfqs6/wlD4vWDSDPlRt
         eW6A==
X-Gm-Message-State: AOAM530Cb4cYKvICwILVgjnFDsV4JvuT1DHr8a9yaeY21AN7cIUuG2qc
        JHDPbYJ9dwHJyIVk+3GhIkt3Kw==
X-Google-Smtp-Source: ABdhPJx2xrSY0c+2+H54SwAGuUmhzFRo8nhpO/9DPmdxqXJmVWAhCw7HXa42Tb5ojlGhGv9MMXQFqw==
X-Received: by 2002:a17:907:6d1f:b0:6fe:e53b:7f53 with SMTP id sa31-20020a1709076d1f00b006fee53b7f53mr18495027ejc.375.1653575845845;
        Thu, 26 May 2022 07:37:25 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id f27-20020a50a6db000000b0042be2dfa8bdsm267962edc.81.2022.05.26.07.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 07:37:25 -0700 (PDT)
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
Subject: [PATCH 4/7] ARM: dts: exynos: use local header for pinctrl register values
Date:   Thu, 26 May 2022 16:37:04 +0200
Message-Id: <20220526143707.767490-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220526143707.767490-1-krzysztof.kozlowski@linaro.org>
References: <20220526143707.767490-1-krzysztof.kozlowski@linaro.org>
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
index 000000000000..3a96915ae9b6
--- /dev/null
+++ b/arch/arm/boot/dts/exynos-pinctrl.h
@@ -0,0 +1,55 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Samsung's Exynos pinctrl bindings
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

