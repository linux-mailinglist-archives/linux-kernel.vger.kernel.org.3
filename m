Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A29248B85E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 21:18:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350549AbiAKUSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 15:18:52 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:60248
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346143AbiAKUST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 15:18:19 -0500
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 86CF53F1AA
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 20:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1641932298;
        bh=qfYilsFRDVZLJ+BbKtg6m7PgGSNQvBvx1O93UtvvKSg=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=L0HUWcXtEX0ukGVNR0ccNhCcLKptxpRkyecLDzBROuukKVP2y1VE1EjPyZGW6WI/L
         7r0Zt4sa/6jP5MusyZo1rW3mOyfrr36zqfXJcYxQhFNGZKTZfQwV9aqfukSsGQXeDj
         eLb0UDfNZMs71UJwXSoqIsSvQqa7vw6zqYlmNXIH+RV9l/viNNGJYYElsSbOhafmYx
         lbHXdg+Dd1dXmV3VrK+rS0kMWoymSjVCMsTKvZMYti2MiWNgHkvhsFRADdJv0Gmd3X
         oZA+jIj6JlqYH2BGaFTc4Grk6qSBKMf3P8ASjQrhiElNoYb3lqv9UAHXOfb0c/efhQ
         DKFD18E5MXSew==
Received: by mail-ed1-f70.google.com with SMTP id x19-20020a05640226d300b003f8b80f5729so180716edd.13
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 12:18:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qfYilsFRDVZLJ+BbKtg6m7PgGSNQvBvx1O93UtvvKSg=;
        b=07VdRi0k90lLWbWybNMGQ/wYsqZbzJ5eCaxH5YTf+WE3RCk0w4NWtQsE2czank8zw7
         UbelikQ+xJMr6CSoAtsw7CURSe3oP6b6h6lI/2IP/TujI9gU9MjR4EumhKraTErISodv
         /mLmg8nyP49tdcXcBIIEjVg0akbgBVqBPUxJk58lCje3lcCCPB0TqsqeUYv9W4qr7zAo
         5V9gQ5SIGNQSlPBDyfp3X8lK8aQRovgz00XygLPxozEcOabGeSQq8gyDQ48i9Ws3jGiM
         C81nAwUWv0De7Icfy+VZRChVY+vzI2O0bNSA/ETj5EVka7zLuCuTnx5ar4+YY3kd0wzb
         AH0w==
X-Gm-Message-State: AOAM531BPYBBggjwgcGJOC4I8qRPl7tgCKFrDk/2CJ3aqEl/4fqOdwbz
        MjbOFkChfQQMH87ncvO9RHI2T59PEwjU2FdZBUswR2UP6wlLCwJPCHH8+F9n9hcNe6YBTZOBEKI
        0yhzYqxjLyIV3quRWF4/La/7w+9rtBuunpNZmJCx4QQ==
X-Received: by 2002:a05:6402:7d0:: with SMTP id u16mr5821299edy.367.1641932298244;
        Tue, 11 Jan 2022 12:18:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzg5koFjhI9MsPoxsO7ulSUXZUs4wFKjp0TGusoYrl4j+1hRugCavSi2yYKwgoqzZkVrlAF1Q==
X-Received: by 2002:a05:6402:7d0:: with SMTP id u16mr5821285edy.367.1641932298101;
        Tue, 11 Jan 2022 12:18:18 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id e4sm4030881ejs.13.2022.01.11.12.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 12:18:17 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Tomasz Figa <tomasz.figa@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        Chanho Park <chanho61.park@samsung.com>,
        Alim Akhtar <alim.akhtar@gmail.com>
Subject: [PATCH v2 19/28] arm64: dts: exynos: align pinctrl with dtschema in Exynos850
Date:   Tue, 11 Jan 2022 21:17:13 +0100
Message-Id: <20220111201722.327219-13-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220111201426.326777-1-krzysztof.kozlowski@canonical.com>
References: <20220111201426.326777-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Align the pin controller related nodes with dtschema.  No functional
change expected.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 .../boot/dts/exynos/exynos850-pinctrl.dtsi    | 52 +++++++++----------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos850-pinctrl.dtsi b/arch/arm64/boot/dts/exynos/exynos850-pinctrl.dtsi
index f576b29c9b16..a71acf358d2d 100644
--- a/arch/arm64/boot/dts/exynos/exynos850-pinctrl.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos850-pinctrl.dtsi
@@ -13,7 +13,7 @@
 #include <dt-bindings/pinctrl/samsung.h>
 
 &pinctrl_alive {
-	gpa0: gpa0 {
+	gpa0: gpa0-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -30,7 +30,7 @@ gpa0: gpa0 {
 			     <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
-	gpa1: gpa1 {
+	gpa1: gpa1-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -47,7 +47,7 @@ gpa1: gpa1 {
 			     <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
-	gpa2: gpa2 {
+	gpa2: gpa2-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -64,7 +64,7 @@ gpa2: gpa2 {
 			     <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
-	gpa3: gpa3 {
+	gpa3: gpa3-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -81,7 +81,7 @@ gpa3: gpa3 {
 			     <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
-	gpa4: gpa4 {
+	gpa4: gpa4-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -94,7 +94,7 @@ gpa4: gpa4 {
 			     <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
-	gpq0: gpq0 {
+	gpq0: gpq0-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -134,7 +134,7 @@ uart1_pins: uart1-pins {
 };
 
 &pinctrl_cmgp {
-	gpm0: gpm0 {
+	gpm0: gpm0-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -144,7 +144,7 @@ gpm0: gpm0 {
 		interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
-	gpm1: gpm1 {
+	gpm1: gpm1-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -154,7 +154,7 @@ gpm1: gpm1 {
 		interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
-	gpm2: gpm2 {
+	gpm2: gpm2-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -164,7 +164,7 @@ gpm2: gpm2 {
 		interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
-	gpm3: gpm3 {
+	gpm3: gpm3-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -174,7 +174,7 @@ gpm3: gpm3 {
 		interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
-	gpm4: gpm4 {
+	gpm4: gpm4-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -184,7 +184,7 @@ gpm4: gpm4 {
 		interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
-	gpm5: gpm5 {
+	gpm5: gpm5-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -256,7 +256,7 @@ spi2_pins: spi2-pins {
 };
 
 &pinctrl_aud {
-	gpb0: gpb0 {
+	gpb0: gpb0-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -264,7 +264,7 @@ gpb0: gpb0 {
 		#interrupt-cells = <2>;
 	};
 
-	gpb1: gpb1 {
+	gpb1: gpb1-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -322,7 +322,7 @@ aud_fm_idle_pins: aud-fm-idle-pins {
 };
 
 &pinctrl_hsi {
-	gpf2: gpf2 {
+	gpf2: gpf2-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -367,7 +367,7 @@ sd2_pdn_pins: sd2-pdn-pins {
 };
 
 &pinctrl_core {
-	gpf0: gpf0 {
+	gpf0: gpf0-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -375,7 +375,7 @@ gpf0: gpf0 {
 		#interrupt-cells = <2>;
 	};
 
-	gpf1: gpf1 {
+	gpf1: gpf1-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -434,7 +434,7 @@ sd0_bus8_pins: sd0-bus8-pins {
 };
 
 &pinctrl_peri {
-	gpc0: gpc0 {
+	gpc0: gpc0-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -442,7 +442,7 @@ gpc0: gpc0 {
 		#interrupt-cells = <2>;
 	};
 
-	gpc1: gpc1 {
+	gpc1: gpc1-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -450,7 +450,7 @@ gpc1: gpc1 {
 		#interrupt-cells = <2>;
 	};
 
-	gpg0: gpg0 {
+	gpg0: gpg0-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -458,7 +458,7 @@ gpg0: gpg0 {
 		#interrupt-cells = <2>;
 	};
 
-	gpg1: gpg1 {
+	gpg1: gpg1-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -466,7 +466,7 @@ gpg1: gpg1 {
 		#interrupt-cells = <2>;
 	};
 
-	gpg2: gpg2 {
+	gpg2: gpg2-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -474,7 +474,7 @@ gpg2: gpg2 {
 		#interrupt-cells = <2>;
 	};
 
-	gpg3: gpg3 {
+	gpg3: gpg3-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -482,14 +482,14 @@ gpg3: gpg3 {
 		#interrupt-cells = <2>;
 	};
 
-	gpp0: gpp0 {
+	gpp0: gpp0-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
 		interrupt-controller;
 		#interrupt-cells = <2>;
 	};
-	gpp1: gpp1 {
+	gpp1: gpp1-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -497,7 +497,7 @@ gpp1: gpp1 {
 		#interrupt-cells = <2>;
 	};
 
-	gpp2: gpp2 {
+	gpp2: gpp2-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
-- 
2.32.0

