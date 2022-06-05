Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9889253DCC9
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 18:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351146AbiFEQGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 12:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345954AbiFEQFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 12:05:38 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23FFB4DF53
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 09:05:34 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id u12so24727015eja.8
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jun 2022 09:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5tWwxJzn2yH78biWqXwadWWd5pjAI0E9L48ilmZjn+o=;
        b=lEnxmG4PK+6MSiOl3DGcBNMtfoA2OmdEaREl5eX1EUog1Xq8dH3BJq5eCWYPDPhKT0
         zjv029NCpL9cCw1J8ghtlScdxhZYIqP8rFBv2FHlzS4G4NTCbnvXttZVFqtA7Otw/fuR
         sFtkaxLgOjsJjRzuKpJsG1yZ5bgoEDIDgFn8PcCOhXlV0vCjUv0VzJGyJLdGHj0wiT8C
         3CphQLkS/j2Ttox158vS2610cb8441b3ZGmO9bC9kcKbAT/MzbOOQBWa+6vhJ55Z+3Pg
         48eHdXN6E8gb0vzBgUenCD29du5jzgQDRH1gbIKzR0viHKz0ZilFNs3izBNoabRmaeHW
         HYdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5tWwxJzn2yH78biWqXwadWWd5pjAI0E9L48ilmZjn+o=;
        b=WGFr+a52lh7MH2GeGzrOSDGnzOwJyTnblMJvJuSzejVjnMGNHoHZFetYVHkwwVQs1F
         +ctDZ5lZJHpZV+8IoOyh4gR1CJ6U8HewzKYvwSLgNog3u4VuVSTj3BqCewLnlmRDBB2e
         Eb45tS3erThJKDZVBd9fFrihRORkTjMiefK4fgFOOC1XRDWEH/3y9a3+XYdn13vud9RB
         hHYtNmDoaZdcVYdVXH1GvSb7qBFH0ThwZ6IJnkud6Dt7pJjtakERmfMX7yYIKD+vkBfU
         wcp2UEZQ+HitaKt573wmcmKjOihiS+jEzpuehR829ZL3LRQ219acGctxS8oOU3ynym6W
         7l3A==
X-Gm-Message-State: AOAM532pg736DBi3aJ4fzE+EwyF66fHMnFow/8L6G7bsFxCr7V5yJd8k
        +fTLKXaL2Pz2k/i6mkh8pcWyqg==
X-Google-Smtp-Source: ABdhPJycPnDVLUAGeX1gnsMgLI7BRaJNnkKdHgBsB16LcFV7xRBWpE4GKKr4f0j9HikE7eKBGR0K+Q==
X-Received: by 2002:a17:907:7fa9:b0:706:e7c6:b0b1 with SMTP id qk41-20020a1709077fa900b00706e7c6b0b1mr17343551ejc.163.1654445132626;
        Sun, 05 Jun 2022 09:05:32 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id x18-20020a170906805200b0070b7875aa6asm3969963ejw.166.2022.06.05.09.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jun 2022 09:05:32 -0700 (PDT)
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
Subject: [PATCH v3 6/8] arm64: dts: fsd: use local header for pinctrl register values
Date:   Sun,  5 Jun 2022 18:05:06 +0200
Message-Id: <20220605160508.134075-7-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220605160508.134075-1-krzysztof.kozlowski@linaro.org>
References: <20220605160508.134075-1-krzysztof.kozlowski@linaro.org>
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
Reviewed-by: Chanho Park <chanho61.park@samsung.com>
---
 arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi | 92 +++++++++++-----------
 arch/arm64/boot/dts/tesla/fsd-pinctrl.h    | 33 ++++++++
 2 files changed, 79 insertions(+), 46 deletions(-)
 create mode 100644 arch/arm64/boot/dts/tesla/fsd-pinctrl.h

diff --git a/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi b/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi
index d4d0cb005712..257e1d3efcb6 100644
--- a/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi
+++ b/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi
@@ -8,7 +8,7 @@
  *		https://www.tesla.com
  */
 
-#include <dt-bindings/pinctrl/samsung.h>
+#include "fsd-pinctrl.h"
 
 &pinctrl_fsys0 {
 	gpf0: gpf0-gpio-bank {
@@ -223,107 +223,107 @@ gpg7: gpg7-gpio-bank {
 
 	pwm0_out: pwm0-out-pins {
 		samsung,pins = "gpb6-1";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
-		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV2>;
+		samsung,pin-function = <FSD_PIN_FUNC_2>;
+		samsung,pin-pud = <FSD_PIN_PULL_UP>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV2>;
 	};
 
 	pwm1_out: pwm1-out-pins {
 		samsung,pins = "gpb6-5";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
-		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV2>;
+		samsung,pin-function = <FSD_PIN_FUNC_2>;
+		samsung,pin-pud = <FSD_PIN_PULL_UP>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV2>;
 	};
 
 	hs_i2c0_bus: hs-i2c0-bus-pins {
 		samsung,pins = "gpb0-0", "gpb0-1";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
-		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-function = <FSD_PIN_FUNC_2>;
+		samsung,pin-pud = <FSD_PIN_PULL_UP>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV1>;
 	};
 
 	hs_i2c1_bus: hs-i2c1-bus-pins {
 		samsung,pins = "gpb0-2", "gpb0-3";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
-		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-function = <FSD_PIN_FUNC_2>;
+		samsung,pin-pud = <FSD_PIN_PULL_UP>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV1>;
 	};
 
 	hs_i2c2_bus: hs-i2c2-bus-pins {
 		samsung,pins = "gpb0-4", "gpb0-5";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
-		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-function = <FSD_PIN_FUNC_2>;
+		samsung,pin-pud = <FSD_PIN_PULL_UP>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV1>;
 	};
 
 	hs_i2c3_bus: hs-i2c3-bus-pins {
 		samsung,pins = "gpb0-6", "gpb0-7";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
-		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-function = <FSD_PIN_FUNC_2>;
+		samsung,pin-pud = <FSD_PIN_PULL_UP>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV1>;
 	};
 
 	hs_i2c4_bus: hs-i2c4-bus-pins {
 		samsung,pins = "gpb1-0", "gpb1-1";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
-		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-function = <FSD_PIN_FUNC_2>;
+		samsung,pin-pud = <FSD_PIN_PULL_UP>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV1>;
 	};
 
 	hs_i2c5_bus: hs-i2c5-bus-pins {
 		samsung,pins = "gpb1-2", "gpb1-3";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
-		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-function = <FSD_PIN_FUNC_2>;
+		samsung,pin-pud = <FSD_PIN_PULL_UP>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV1>;
 	};
 
 	hs_i2c6_bus: hs-i2c6-bus-pins {
 		samsung,pins = "gpb1-4", "gpb1-5";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
-		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-function = <FSD_PIN_FUNC_2>;
+		samsung,pin-pud = <FSD_PIN_PULL_UP>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV1>;
 	};
 
 	hs_i2c7_bus: hs-i2c7-bus-pins {
 		samsung,pins = "gpb1-6", "gpb1-7";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
-		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-function = <FSD_PIN_FUNC_2>;
+		samsung,pin-pud = <FSD_PIN_PULL_UP>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV1>;
 	};
 
 	uart0_data: uart0-data-pins {
 		samsung,pins = "gpb7-0", "gpb7-1";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
-		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-function = <FSD_PIN_FUNC_2>;
+		samsung,pin-pud = <FSD_PIN_PULL_NONE>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV1>;
 	};
 
 	uart1_data: uart1-data-pins {
 		samsung,pins = "gpb7-4", "gpb7-5";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
-		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-function = <FSD_PIN_FUNC_2>;
+		samsung,pin-pud = <FSD_PIN_PULL_NONE>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV1>;
 	};
 
 	spi0_bus: spi0-bus-pins {
 		samsung,pins = "gpb4-0", "gpb4-2", "gpb4-3";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
-		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-function = <FSD_PIN_FUNC_2>;
+		samsung,pin-pud = <FSD_PIN_PULL_UP>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV1>;
 	};
 
 	spi1_bus: spi1-bus-pins {
 		samsung,pins = "gpb4-4", "gpb4-6", "gpb4-7";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
-		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-function = <FSD_PIN_FUNC_2>;
+		samsung,pin-pud = <FSD_PIN_PULL_UP>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV1>;
 	};
 
 	spi2_bus: spi2-bus-pins {
 		samsung,pins = "gpb5-0", "gpb5-2", "gpb5-3";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
-		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-function = <FSD_PIN_FUNC_2>;
+		samsung,pin-pud = <FSD_PIN_PULL_UP>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV1>;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/tesla/fsd-pinctrl.h b/arch/arm64/boot/dts/tesla/fsd-pinctrl.h
new file mode 100644
index 000000000000..6ffbda362493
--- /dev/null
+++ b/arch/arm64/boot/dts/tesla/fsd-pinctrl.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Tesla FSD DTS pinctrl constants
+ *
+ * Copyright (c) 2016 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ * Copyright (c) 2022 Linaro Ltd
+ * Author: Krzysztof Kozlowski <krzk@kernel.org>
+ */
+
+#ifndef __DTS_ARM64_TESLA_FSD_PINCTRL_H__
+#define __DTS_ARM64_TESLA_FSD_PINCTRL_H__
+
+#define FSD_PIN_PULL_NONE		0
+#define FSD_PIN_PULL_DOWN		1
+#define FSD_PIN_PULL_UP			3
+
+#define FSD_PIN_DRV_LV1			0
+#define FSD_PIN_DRV_LV2			2
+#define FSD_PIN_DRV_LV3			1
+#define FSD_PIN_DRV_LV4			3
+
+#define FSD_PIN_FUNC_INPUT		0
+#define FSD_PIN_FUNC_OUTPUT		1
+#define FSD_PIN_FUNC_2			2
+#define FSD_PIN_FUNC_3			3
+#define FSD_PIN_FUNC_4			4
+#define FSD_PIN_FUNC_5			5
+#define FSD_PIN_FUNC_6			6
+#define FSD_PIN_FUNC_EINT		0xf
+#define FSD_PIN_FUNC_F			FSD_PIN_FUNC_EINT
+
+#endif /* __DTS_ARM64_TESLA_FSD_PINCTRL_H__ */
-- 
2.34.1

