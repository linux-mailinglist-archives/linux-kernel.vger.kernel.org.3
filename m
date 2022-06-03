Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 933C853C7F3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 11:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243252AbiFCJuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 05:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243230AbiFCJt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 05:49:57 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8415724977
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 02:49:55 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 25so9180330edw.8
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 02:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=99fGaK4RqqX9TZZDosYGNUyUM6sQSl8Udc/LexVf/3o=;
        b=QCS+MIM1geXNdiRcZOC4FD0SyAAqkSlkfTTUPJw4QLBCQF889VGxDCbxdlALwKGjWz
         rLuFPiz7C+dq5dJJ4F8XDRvvf7wAIK0AEKNjSqQyJoZyK/WLd70iLsBVEOLxBYZHrrLQ
         Sve9nlrCz+AL/4UrefSaHN5L0iexFfWRaU43Y764pCBdo6EXF7hjvH2bw89U/+cUiqU/
         Nhdt0e3nK8QAwWhUtwOU3j0GXfYH3BbrjMv87Ts4UCFNiIyiFyOtRmMLB0I3yG16Qy2i
         tAs6NOV0OmGUdVhPwUY/GCx81HbePeNIisAaxZ27V/fqo22DVS4VnGDaXUXQt/9gF45D
         upkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=99fGaK4RqqX9TZZDosYGNUyUM6sQSl8Udc/LexVf/3o=;
        b=FFAJni2U8eSgJWEZaLqFY5VVcBv4iMnxufV7RYL5R/C+GEKavb9zV5hCqIhT4Pa+Et
         s2HUHoBVZ7IVO9N2PF9g/oGheaoy0uVrWfnaPPi0b3zkvzH/Ck6zoxY53CE+u/m4bK0o
         GskqG+wjIGTgaf+rWzemeqbebf0p40n65wcAEO3UrKV/uKUKqt8fxKtuelC7c5r4l0k2
         sV4ENQPquktdTLMiotdFMVp8YgCQGE9D4Q/7IT3CgkWsw7QFgvlSg1w4wyxEBv+yrW1O
         nW5gv4oN9gKMp6Vkq5B913VrngWQMDcd6ciBVdlXVQOHBlQXFYDnkcOe9Ojxrgw6SsJ5
         Sn3Q==
X-Gm-Message-State: AOAM530qQ4VHIKMlgTGsJjFI3IIZtShpQyrSsJYTKklfNcHyqYywOULi
        bBazh3tN/sHOxwf0E6YXBFVXzA==
X-Google-Smtp-Source: ABdhPJzIhBBSSjBKJbGWTQF1sawSyCvgi/jnEyy+I3PWM2Bn6W08R7yGLlLw2HEYq8rp9W3gbT7jAQ==
X-Received: by 2002:a05:6402:3310:b0:42d:e77b:fef0 with SMTP id e16-20020a056402331000b0042de77bfef0mr9668823eda.193.1654249795082;
        Fri, 03 Jun 2022 02:49:55 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id y22-20020aa7ca16000000b0042dcbc3f302sm3669561eds.36.2022.06.03.02.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 02:49:54 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/3] dt-bindings: mmc: samsung,exynos-dw-mshc: convert to dtschema
Date:   Fri,  3 Jun 2022 11:49:46 +0200
Message-Id: <20220603094946.509919-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220603094946.509919-1-krzysztof.kozlowski@linaro.org>
References: <20220603094946.509919-1-krzysztof.kozlowski@linaro.org>
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

Convert the Samsung Exynos SoC specific extensions to the Synopsys
Designware Mobile Storage Host Controller to DT schema.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/mmc/exynos-dw-mshc.txt           |  94 ----------
 .../bindings/mmc/samsung,exynos-dw-mshc.yaml  | 162 ++++++++++++++++++
 2 files changed, 162 insertions(+), 94 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
 create mode 100644 Documentation/devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml

diff --git a/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
deleted file mode 100644
index 753e9d7d8956..000000000000
--- a/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
+++ /dev/null
@@ -1,94 +0,0 @@
-* Samsung Exynos specific extensions to the Synopsys Designware Mobile
-  Storage Host Controller
-
-The Synopsys designware mobile storage host controller is used to interface
-a SoC with storage medium such as eMMC or SD/MMC cards. This file documents
-differences between the core Synopsys dw mshc controller properties described
-by synopsys-dw-mshc.txt and the properties used by the Samsung Exynos specific
-extensions to the Synopsys Designware Mobile Storage Host Controller.
-
-Required Properties:
-
-* compatible: should be
-	- "samsung,exynos4210-dw-mshc": for controllers with Samsung Exynos4210
-	  specific extensions.
-	- "samsung,exynos4412-dw-mshc": for controllers with Samsung Exynos4412
-	  specific extensions.
-	- "samsung,exynos5250-dw-mshc": for controllers with Samsung Exynos5250
-	  specific extensions.
-	- "samsung,exynos5420-dw-mshc": for controllers with Samsung Exynos5420
-	  specific extensions.
-	- "samsung,exynos7-dw-mshc": for controllers with Samsung Exynos7
-	  specific extensions.
-	- "samsung,exynos7-dw-mshc-smu": for controllers with Samsung Exynos7
-	  specific extensions having an SMU.
-	- "axis,artpec8-dw-mshc": for controllers with ARTPEC-8 specific
-	  extensions.
-
-* samsung,dw-mshc-ciu-div: Specifies the divider value for the card interface
-  unit (ciu) clock. This property is applicable only for Exynos5 SoC's and
-  ignored for Exynos4 SoC's. The valid range of divider value is 0 to 7.
-
-* samsung,dw-mshc-sdr-timing: Specifies the value of CIU clock phase shift value
-  in transmit mode and CIU clock phase shift value in receive mode for single
-  data rate mode operation. Refer notes below for the order of the cells and the
-  valid values.
-
-* samsung,dw-mshc-ddr-timing: Specifies the value of CUI clock phase shift value
-  in transmit mode and CIU clock phase shift value in receive mode for double
-  data rate mode operation. Refer notes below for the order of the cells and the
-  valid values.
-* samsung,dw-mshc-hs400-timing: Specifies the value of CIU TX and RX clock phase
-  shift value for hs400 mode operation.
-
-  Notes for the sdr-timing and ddr-timing values:
-
-    The order of the cells should be
-      - First Cell: CIU clock phase shift value for tx mode.
-      - Second Cell: CIU clock phase shift value for rx mode.
-
-    Valid values for SDR and DDR CIU clock timing for Exynos5250:
-      - valid value for tx phase shift and rx phase shift is 0 to 7.
-      - when CIU clock divider value is set to 3, all possible 8 phase shift
-        values can be used.
-      - if CIU clock divider value is 0 (that is divide by 1), both tx and rx
-        phase shift clocks should be 0.
-
-* samsung,read-strobe-delay: RCLK (Data strobe) delay to control HS400 mode
-  (Latency value for delay line in Read path)
-
-Required properties for a slot (Deprecated - Recommend to use one slot per host):
-
-* gpios: specifies a list of gpios used for command, clock and data bus. The
-  first gpio is the command line and the second gpio is the clock line. The
-  rest of the gpios (depending on the bus-width property) are the data lines in
-  no particular order. The format of the gpio specifier depends on the gpio
-  controller.
-(Deprecated - Refer to Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt)
-
-Example:
-
-  The MSHC controller node can be split into two portions, SoC specific and
-  board specific portions as listed below.
-
-	dwmmc0@12200000 {
-		compatible = "samsung,exynos5250-dw-mshc";
-		reg = <0x12200000 0x1000>;
-		interrupts = <0 75 0>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-	};
-
-	dwmmc0@12200000 {
-		cap-mmc-highspeed;
-		cap-sd-highspeed;
-		broken-cd;
-		fifo-depth = <0x80>;
-		card-detect-delay = <200>;
-		samsung,dw-mshc-ciu-div = <3>;
-		samsung,dw-mshc-sdr-timing = <2 3>;
-		samsung,dw-mshc-ddr-timing = <1 2>;
-		samsung,dw-mshc-hs400-timing = <0 2>;
-		samsung,read-strobe-delay = <90>;
-		bus-width = <8>;
-	};
diff --git a/Documentation/devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml
new file mode 100644
index 000000000000..ccb9d22c1702
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml
@@ -0,0 +1,162 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mmc/samsung,exynos-dw-mshc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title:
+  Samsung Exynos SoC specific extensions to the Synopsys Designware Mobile
+  Storage Host Controller
+
+maintainers:
+  - Jaehoon Chung <jh80.chung@samsung.com>
+  - Krzysztof Kozlowski <krzk@kernel.org>
+
+properties:
+  compatible:
+    enum:
+      - samsung,exynos4210-dw-mshc
+      - samsung,exynos4412-dw-mshc
+      - samsung,exynos5250-dw-mshc
+      - samsung,exynos5420-dw-mshc
+      - samsung,exynos7-dw-mshc
+      - samsung,exynos7-dw-mshc-smu
+      - axis,artpec8-dw-mshc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 2
+    description:
+      Handle to "biu" and "ciu" clocks for the
+      bus interface unit clock and the card interface unit clock.
+
+  clock-names:
+    items:
+      - const: biu
+      - const: ciu
+
+  samsung,dw-mshc-ciu-div:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 7
+    description:
+      The divider value for the card interface unit (ciu) clock.
+
+  samsung,dw-mshc-ddr-timing:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    items:
+      - description: CIU clock phase shift value for tx mode
+        minimum: 0
+        maximum: 7
+      - description: CIU clock phase shift value for rx mode
+        minimum: 0
+        maximum: 7
+    description:
+      The value of CUI clock phase shift value in transmit mode and CIU clock
+      phase shift value in receive mode for double data rate mode operation.
+      See also samsung,dw-mshc-hs400-timing property.
+
+  samsung,dw-mshc-hs400-timing:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    items:
+      - description: CIU clock phase shift value for tx mode
+        minimum: 0
+        maximum: 7
+      - description: CIU clock phase shift value for rx mode
+        minimum: 0
+        maximum: 7
+    description: |
+      The value of CIU TX and RX clock phase shift value for HS400 mode
+      operation.
+      Valid values for SDR and DDR CIU clock timing::
+        - valid value for tx phase shift and rx phase shift is 0 to 7.
+        - when CIU clock divider value is set to 3, all possible 8 phase shift
+          values can be used.
+        - if CIU clock divider value is 0 (that is divide by 1), both tx and rx
+          phase shift clocks should be 0.
+      If missing, values from samsung,dw-mshc-ddr-timing property are used.
+
+  samsung,dw-mshc-sdr-timing:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    items:
+      - description: CIU clock phase shift value for tx mode
+        minimum: 0
+        maximum: 7
+      - description: CIU clock phase shift value for rx mode
+        minimum: 0
+        maximum: 7
+    description:
+      The value of CIU clock phase shift value in transmit mode and CIU clock
+      phase shift value in receive mode for single data rate mode operation.
+      See also samsung,dw-mshc-hs400-timing property.
+
+  samsung,read-strobe-delay:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      RCLK (Data strobe) delay to control HS400 mode (Latency value for delay
+      line in Read path). If missing, default from hardware is used.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - samsung,dw-mshc-ddr-timing
+  - samsung,dw-mshc-sdr-timing
+
+allOf:
+  - $ref: "synopsys-dw-mshc-common.yaml#"
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - samsung,exynos5250-dw-mshc
+              - samsung,exynos5420-dw-mshc
+              - samsung,exynos7-dw-mshc
+              - samsung,exynos7-dw-mshc-smu
+              - axis,artpec8-dw-mshc
+    then:
+      required:
+        - samsung,dw-mshc-ciu-div
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/exynos5420.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    mmc@12200000 {
+        compatible = "samsung,exynos5420-dw-mshc-smu";
+        interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+        reg = <0x12200000 0x2000>;
+        clocks = <&clock CLK_MMC0>, <&clock CLK_SCLK_MMC0>;
+        clock-names = "biu", "ciu";
+        fifo-depth = <0x40>;
+
+        mmc-pwrseq = <&emmc_pwrseq>;
+        card-detect-delay = <200>;
+        samsung,dw-mshc-ciu-div = <3>;
+        samsung,dw-mshc-sdr-timing = <0 4>;
+        samsung,dw-mshc-ddr-timing = <0 2>;
+        samsung,dw-mshc-hs400-timing = <0 2>;
+        samsung,read-strobe-delay = <90>;
+        pinctrl-names = "default";
+        pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus1 &sd0_bus4 &sd0_bus8 &sd0_cd &sd0_rclk>;
+        bus-width = <8>;
+        cap-mmc-highspeed;
+        mmc-hs200-1_8v;
+        mmc-hs400-1_8v;
+        max-frequency = <200000000>;
+        vmmc-supply = <&ldo18_reg>;
+        vqmmc-supply = <&ldo3_reg>;
+    };
-- 
2.34.1

