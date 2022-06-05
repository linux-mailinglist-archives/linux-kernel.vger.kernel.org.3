Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A40F953DD1F
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 18:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351305AbiFEQhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 12:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351266AbiFEQhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 12:37:24 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA03E183BC
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 09:37:20 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id o10so15924394edi.1
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jun 2022 09:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yfRrjYpaDT1X7JG9M9WZZ4jakO99u/ZXgr26brnBGvQ=;
        b=RcAegJmjNC9vwwCwfQ6rQoL/mcTtxYsKp3WedQ1r36gSU77HgPWr8pB7bAFsdUKAXp
         U3aaGplF3lhKNZnq1Dbsvd1Y+4aBD4/xPbxalGlWVom3cMHTNsZINlxGL1+HfcTRiNYX
         o/H9rnYLx/TzWAEB75pNezBPAS520dWUt/lz8kfsynwx8B6JEm0+odjCjyXD2tShBroU
         FJjUOQiNkKBNRP/QqvnodqEr14cvaf6J27Stpthx2PMKTkC+79SJAIzMxxF4ZdUxQ5Tn
         GAHOll4LgFlvYxp+pSuvnTWpk6zWs3Q4WKPSUaR0QdIZ+cmedymXThTRJEDW2v/G5I6o
         /+Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yfRrjYpaDT1X7JG9M9WZZ4jakO99u/ZXgr26brnBGvQ=;
        b=ATb9ga+Nel7EjVxvsoc4QdO83C2Bkd6PE/XRDe5de6jXXcM+fpq8kz1B1x8CW5Ay3E
         LeEnCODnqQoJtNfzwFyVv0qdNIRRI6sh6trjH6XFO00TB+cZC+/X4qErncAxcJ8UNwjJ
         Gg/NxhqH/kjxT7d1rdkRRzPq4U8PSug0DgzjWnwnkfL9Dvc15PsKk+/l10+qTHLQT7jP
         XVTnPmx40/mS2hS/AXg8I6ZP2ihYe9RPyKcnhf+kLTPaJE1ggwEDEFjV/CC2Jgsoh16a
         nxdWAx9b0Cc+QJgSfZuYCVITExSVGmLuJOemcBvwcVDO9KHppJ5Y7nteynd6+nO9Xsz0
         LX9w==
X-Gm-Message-State: AOAM5310eQcaa1LkDfD0/IHr51qNxNgFrl+HkXeO3bR/rjdjWSUWdzCs
        nuNaeZQnEk9W9/8zxcoJZqbLcciXFOBXQw==
X-Google-Smtp-Source: ABdhPJzscnJUUIWurCZClZ8CJ1uB9kz0tMVAOIGpUNaAeeymzW/+3fisbOnQ1XjovWECLzpaUmIjug==
X-Received: by 2002:aa7:c34d:0:b0:42d:ce57:5df2 with SMTP id j13-20020aa7c34d000000b0042dce575df2mr21857864edr.315.1654447039169;
        Sun, 05 Jun 2022 09:37:19 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id w3-20020a1709064a0300b006ff0b457cdasm5346770eju.53.2022.06.05.09.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jun 2022 09:37:18 -0700 (PDT)
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
Subject: [PATCH v2 3/4] dt-bindings: mmc: samsung,exynos-dw-mshc: convert to dtschema
Date:   Sun,  5 Jun 2022 18:37:09 +0200
Message-Id: <20220605163710.144210-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220605163710.144210-1-krzysztof.kozlowski@linaro.org>
References: <20220605163710.144210-1-krzysztof.kozlowski@linaro.org>
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
 .../bindings/mmc/exynos-dw-mshc.txt           |  94 -----------
 .../bindings/mmc/samsung,exynos-dw-mshc.yaml  | 159 ++++++++++++++++++
 2 files changed, 159 insertions(+), 94 deletions(-)
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
index 000000000000..80c557e938a2
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml
@@ -0,0 +1,159 @@
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
+    mmc@12220000 {
+        compatible = "samsung,exynos5420-dw-mshc";
+        interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+        reg = <0x12220000 0x1000>;
+        clocks = <&clock CLK_MMC2>, <&clock CLK_SCLK_MMC2>;
+        clock-names = "biu", "ciu";
+        fifo-depth = <0x40>;
+        card-detect-delay = <200>;
+        samsung,dw-mshc-ciu-div = <3>;
+        samsung,dw-mshc-sdr-timing = <0 4>;
+        samsung,dw-mshc-ddr-timing = <0 2>;
+        pinctrl-names = "default";
+        pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_wp &sd2_bus1 &sd2_bus4>;
+        bus-width = <4>;
+        cap-sd-highspeed;
+        max-frequency = <200000000>;
+        vmmc-supply = <&ldo19_reg>;
+        vqmmc-supply = <&ldo13_reg>;
+        sd-uhs-sdr50;
+        sd-uhs-sdr104;
+        sd-uhs-ddr50;
+    };
-- 
2.34.1

