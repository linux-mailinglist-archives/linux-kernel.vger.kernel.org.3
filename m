Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7810753A9FF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 17:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355504AbiFAP2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 11:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355474AbiFAP16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 11:27:58 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7472333343
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 08:27:53 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id m20so4481382ejj.10
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 08:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DXHV9UQd65E5JHZd7pjDwKymfaDUFSZ63bdLaZpdowQ=;
        b=VD2UWJNwPqlx/yFFNX0BsWSvJOjFeVC+Y0R83/XM4f8WXY/OwE+A2dQvsUERynIZxh
         qmuIX4g/hbIshb7MADMXBhdvN9S7iaVG1K2N3hLd6AIAVfQSCYDfcMirY3Kn0j/mRUaH
         MJutMgf6zrKyWwV9NPl7hzeI04EoovZoUlCrjM4ZJBMG2WCQpHQTQ8/tTPwjw/DUYZzV
         dMw3uQ/KfH3CPWoTfVpb7EMFJ/A3QNrywpX/kXDIMf3vns96em6watTlLRGXOajmVSaj
         ABdgVk6XVtoFJRZC9Nv6bNIDdTI5B5KeMrz8nlvdBgKVEz0DXG1JmpMG7+1O/T4y3suQ
         nVKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DXHV9UQd65E5JHZd7pjDwKymfaDUFSZ63bdLaZpdowQ=;
        b=7fmgbI/jYpZZ9aQRngP1/pBsiqgtbz6X+k9Ap05qKKyrwN4c3yGTpa6Uc+RN8l1xrR
         MXdf2qaUo+F6f6WUfYOJI03WCI4AAwFeWGseELvazEwNjslq2Gzegzo00RWrSHV6Y86d
         rW/4qdecIcE3zQoUmFwb+ZmXqSzdlSUZ7BZJKnZkgSqzCnAhgSszAmPr5gxvaFEL1spF
         t0GGQFcZOkyQ0UhWK6YRJjPBE2dymPSWiXUy4Dfo7SoLkUl3GJP18XK2Kh2YK8nRdUKD
         bC5QnOhaD5ylOHggwR84hgy6rECBcrJn14mLllyG+d/pvRUpW2EgaiLetazA+3y1pDlp
         0Jfg==
X-Gm-Message-State: AOAM5308mzAiMl4oABqEnkd8NhR/HveOKeWvzVxV3KQO3AQMQ+6EdNfI
        s0Vdv0xeozP8D06Bdm2V/QlhmA==
X-Google-Smtp-Source: ABdhPJw2hsSBAEijto4XqpMxn5rSL2bEgcd/YUVRMck/m1LZ3CPy3QoPX97Fw4waXwhq1S6UWJbSkQ==
X-Received: by 2002:a17:907:7d94:b0:6ff:1580:4d01 with SMTP id oz20-20020a1709077d9400b006ff15804d01mr39837ejc.231.1654097271914;
        Wed, 01 Jun 2022 08:27:51 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id e13-20020a170906248d00b006fee7b5dff2sm845870ejb.143.2022.06.01.08.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 08:27:51 -0700 (PDT)
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
Subject: [PATCH v2 1/7] ARM: dts: s3c2410: use local header for pinctrl register values
Date:   Wed,  1 Jun 2022 17:27:14 +0200
Message-Id: <20220601152720.232383-2-krzysztof.kozlowski@linaro.org>
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
fit the purpose of bindings.  It is also quite confusing to use
constants prefixed with Exynos for other SoC, because there is actually
nothing here in common, except the actual value.

Store the constants in a header next to DTS and use them instead of
bindings.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/s3c2410-pinctrl.h    | 19 +++++++++++++
 arch/arm/boot/dts/s3c2416-pinctrl.dtsi | 38 +++++++++++++-------------
 2 files changed, 38 insertions(+), 19 deletions(-)
 create mode 100644 arch/arm/boot/dts/s3c2410-pinctrl.h

diff --git a/arch/arm/boot/dts/s3c2410-pinctrl.h b/arch/arm/boot/dts/s3c2410-pinctrl.h
new file mode 100644
index 000000000000..76b6171ae149
--- /dev/null
+++ b/arch/arm/boot/dts/s3c2410-pinctrl.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Samsung S3C2410 DTS pinctrl constants
+ *
+ * Copyright (c) 2016 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ * Copyright (c) 2022 Linaro Ltd
+ * Author: Krzysztof Kozlowski <krzk@kernel.org>
+ */
+
+#ifndef __DTS_ARM_SAMSUNG_S3C2410_PINCTRL_H__
+#define __DTS_ARM_SAMSUNG_S3C2410_PINCTRL_H__
+
+#define S3C2410_PIN_FUNC_INPUT		0
+#define S3C2410_PIN_FUNC_OUTPUT		1
+#define S3C2410_PIN_FUNC_2		2
+#define S3C2410_PIN_FUNC_3		3
+
+#endif /* __DTS_ARM_SAMSUNG_S3C2410_PINCTRL_H__ */
diff --git a/arch/arm/boot/dts/s3c2416-pinctrl.dtsi b/arch/arm/boot/dts/s3c2416-pinctrl.dtsi
index 20a7d72827c2..3268366bd8bc 100644
--- a/arch/arm/boot/dts/s3c2416-pinctrl.dtsi
+++ b/arch/arm/boot/dts/s3c2416-pinctrl.dtsi
@@ -5,7 +5,7 @@
  * Copyright (c) 2013 Heiko Stuebner <heiko@sntech.de>
  */
 
-#include <dt-bindings/pinctrl/samsung.h>
+#include "s3c2410-pinctrl.h"
 
 &pinctrl_0 {
 	/*
@@ -82,91 +82,91 @@ gpm: gpm-gpio-bank {
 
 	uart0_data: uart0-data-pins {
 		samsung,pins = "gph-0", "gph-1";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-function = <S3C2410_PIN_FUNC_2>;
 	};
 
 	uart0_fctl: uart0-fctl-pins {
 		samsung,pins = "gph-8", "gph-9";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-function = <S3C2410_PIN_FUNC_2>;
 	};
 
 	uart1_data: uart1-data-pins {
 		samsung,pins = "gph-2", "gph-3";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-function = <S3C2410_PIN_FUNC_2>;
 	};
 
 	uart1_fctl: uart1-fctl-pins {
 		samsung,pins = "gph-10", "gph-11";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-function = <S3C2410_PIN_FUNC_2>;
 	};
 
 	uart2_data: uart2-data-pins {
 		samsung,pins = "gph-4", "gph-5";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-function = <S3C2410_PIN_FUNC_2>;
 	};
 
 	uart2_fctl: uart2-fctl-pins {
 		samsung,pins = "gph-6", "gph-7";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-function = <S3C2410_PIN_FUNC_2>;
 	};
 
 	uart3_data: uart3-data-pins {
 		samsung,pins = "gph-6", "gph-7";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-function = <S3C2410_PIN_FUNC_2>;
 	};
 
 	extuart_clk: extuart-clk-pins {
 		samsung,pins = "gph-12";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-function = <S3C2410_PIN_FUNC_2>;
 	};
 
 	i2c0_bus: i2c0-bus-pins {
 		samsung,pins = "gpe-14", "gpe-15";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-function = <S3C2410_PIN_FUNC_2>;
 	};
 
 	spi0_bus: spi0-bus-pins {
 		samsung,pins = "gpe-11", "gpe-12", "gpe-13";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-function = <S3C2410_PIN_FUNC_2>;
 	};
 
 	sd0_clk: sd0-clk-pins {
 		samsung,pins = "gpe-5";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-function = <S3C2410_PIN_FUNC_2>;
 	};
 
 	sd0_cmd: sd0-cmd-pins {
 		samsung,pins = "gpe-6";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-function = <S3C2410_PIN_FUNC_2>;
 	};
 
 	sd0_bus1: sd0-bus1-pins {
 		samsung,pins = "gpe-7";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-function = <S3C2410_PIN_FUNC_2>;
 	};
 
 	sd0_bus4: sd0-bus4-pins {
 		samsung,pins = "gpe-8", "gpe-9", "gpe-10";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-function = <S3C2410_PIN_FUNC_2>;
 	};
 
 	sd1_cmd: sd1-cmd-pins {
 		samsung,pins = "gpl-8";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-function = <S3C2410_PIN_FUNC_2>;
 	};
 
 	sd1_clk: sd1-clk-pins {
 		samsung,pins = "gpl-9";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-function = <S3C2410_PIN_FUNC_2>;
 	};
 
 	sd1_bus1: sd1-bus1-pins {
 		samsung,pins = "gpl-0";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-function = <S3C2410_PIN_FUNC_2>;
 	};
 
 	sd1_bus4: sd1-bus4-pins {
 		samsung,pins = "gpl-1", "gpl-2", "gpl-3";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-function = <S3C2410_PIN_FUNC_2>;
 	};
 };
-- 
2.34.1

