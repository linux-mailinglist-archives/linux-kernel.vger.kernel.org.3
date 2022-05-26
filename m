Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9785F5350CA
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 16:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347688AbiEZOhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 10:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235749AbiEZOh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 10:37:29 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F98DCC170
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 07:37:23 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id er5so2042287edb.12
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 07:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zNSo7HTnhss/iN+yIa+zDeGfGrWjHSHbXmTwg6rvYSg=;
        b=WMbm+hYGQ9xqTT/qhKPIxU89RPI9AFSdjCzL9SY5HuOaGS9ulotU5V5OPAg4yEco0q
         i2Uy2vZzSgdQ2n5nuAIsy4CUWxzuGvp9yDHxZBeIl/uD2oZ8XpCQUdorqY5yXyEiCPHP
         FzzrgBDIuD66PkeBb39LoSJropq75pzDe23C3g7Dooi2MAlCpneL61n0gDU3fd8P6vbJ
         hTXWQaB/aSvAhNU8w2l1PZzQgU7raUiJml6qjgzW9r+PUOBxpyZKgjrRHf4Iyan5k54o
         iFY9p2gZ37C9u7U8SiUH1R7lR0yJWm6ckmTcGwq3cY64xwrQE8H5ns2caX5zGtK4bvDy
         8F7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zNSo7HTnhss/iN+yIa+zDeGfGrWjHSHbXmTwg6rvYSg=;
        b=Tla5J7i7QCiBOxcxdgeGK7LNhVOdh000ZAFl9uEaQ+YZ/rPO5pF5gCrJ8OBypSFq5L
         GT/cBFhg/qUaBDEEoScixbhl6PkttYpjssw152JvggT9aiDJRZErS3469spX/DO9hOvS
         i2KWQF6Sp0X1odK75khmbYaAP7IYAWoRwYd8LUfTuib40P8Mw1g3yUPrqOEu+mynNJE0
         KCXKrE6/YE/lrLB91GGxq8VS17lrz7hgZmon6qOOaUU9a+SfGkydBUcJce1tszCDdPsx
         pHc652eGlrD39ua1A4dChDdiPYDsoaGE/n1Vf0umb7RU8Su/F3F0nIJvpYFZMoCvX+SR
         VcaQ==
X-Gm-Message-State: AOAM532qgB/X8txqfs4nyOf2wzlqaP4OJpNn9oGDhfj9UqhGu7w+645v
        hCOGsb/nMNc5otmpRZogVH5uYg==
X-Google-Smtp-Source: ABdhPJymHiX88K/xjCvH2KfypXYu/3gtAaIbA2GNOdZO2h8pLUJbffiE7mdcw5T7++JcYYXhO3sR/w==
X-Received: by 2002:aa7:d412:0:b0:42a:b8bf:89f7 with SMTP id z18-20020aa7d412000000b0042ab8bf89f7mr40717484edq.410.1653575841960;
        Thu, 26 May 2022 07:37:21 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id f27-20020a50a6db000000b0042be2dfa8bdsm267962edc.81.2022.05.26.07.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 07:37:21 -0700 (PDT)
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
Subject: [PATCH 1/7] ARM: dts: s3c2410: use local header for pinctrl register values
Date:   Thu, 26 May 2022 16:37:01 +0200
Message-Id: <20220526143707.767490-2-krzysztof.kozlowski@linaro.org>
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
index 000000000000..71cb0ac815b3
--- /dev/null
+++ b/arch/arm/boot/dts/s3c2410-pinctrl.h
@@ -0,0 +1,19 @@
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

