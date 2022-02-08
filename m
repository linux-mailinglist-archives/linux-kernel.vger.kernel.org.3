Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4777C4ADF53
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 18:19:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384139AbiBHRTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 12:19:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383870AbiBHRTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 12:19:30 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDEECC061579
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 09:19:28 -0800 (PST)
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id AB36240050
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 17:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644340767;
        bh=4Kqc6L6Q9tC6aVZ4IcSd8iWDDGh3wUIB157CLAeaaFw=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=UFWEQ/Dv+i3gLblZjeZWbvQMWKUiPylCrm2wrHUCUDD/xBOAA8A0KG7TfZ83jNiuk
         902GqxA561IEplS8FPoA6liEWnbsr4y0YLPuQ+PzK0k+pDSGwHgT4RLTx8WzKP2HPM
         wy9pbQEg1bY7v7QAiybExC65OQXhUUn+QqPBxzYveo/EgBwmXxfFYL7mzefMrMrmxk
         jlut7Oo8llCe3FrivAjS74VkjTtGgseTopz+2EiH7JlT2LYQTAEGSkvGGTpSrIljw5
         M/WBFzpP8jabCvxnbyuayS9RF7IZ5vYjp2nbJT/mK8GGvCcZgo1BKyHxiQFKLMACZe
         jm/obUqbigSzg==
Received: by mail-ej1-f71.google.com with SMTP id aj9-20020a1709069a4900b006cd205be806so1145690ejc.18
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 09:19:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4Kqc6L6Q9tC6aVZ4IcSd8iWDDGh3wUIB157CLAeaaFw=;
        b=GZYgsN78RrHQ2dpUAWg2AfkrlCkJwSzdfeq8FgggM2VNxAJKKr3NDwsZXrSjJfOAAk
         /k/mUA3icft6aSOSKtxrwRK8aQjP19UQY2IFRWvgoc03sEoJwpvT96zGkyYsriUvTK4u
         xzTswdHt5VuwYcoUGUzm65e8g65uHHnY8mNC5aZo1KyB/gkvUVCc+UKG17/gvJ7s7tWG
         bSqzGh39CuOioRSYpABD7R1C+KlbvN2S0uYzDzBaS4k9HbA1caqOYDvtThm8MRbeybDE
         fRJkLPfBX3yHyNsO1GzsYRO98nrgbq9QwsywcIP0s/Ek+pS/SA75uFjum/qCUTr9gp1c
         JZuw==
X-Gm-Message-State: AOAM533gCjMRwGq6u+1voAFScw3EhtvOIqkkpKK6u5VDkXBs5KVusxSv
        tEOZ+VqkcLFbvTO+HCfiKdHMtFUyOOSic8XGWbG8w2n07GzsNnHOA/qZWe4v1HZpfOJ3tGFRTPu
        alJT+clmT5hX7pKrfn6sDsurPOIPHDsF44hZ6LiCA3A==
X-Received: by 2002:a05:6402:510b:: with SMTP id m11mr5597645edd.290.1644340765084;
        Tue, 08 Feb 2022 09:19:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxRZNXcZzMs0TAC2gPdxKPihRqli2IMBZU42Ls1ax0iChpkOJ4tgyVxzgjOsC0cDw2k6wkGXQ==
X-Received: by 2002:a05:6402:510b:: with SMTP id m11mr5597617edd.290.1644340764811;
        Tue, 08 Feb 2022 09:19:24 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id r10sm5125550ejy.148.2022.02.08.09.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 09:19:24 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>
Subject: [PATCH 10/10] dt-bindings: display: samsung,exynos-fimd: convert to dtschema
Date:   Tue,  8 Feb 2022 18:18:23 +0100
Message-Id: <20220208171823.226211-11-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220208171823.226211-1-krzysztof.kozlowski@canonical.com>
References: <20220208171823.226211-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the S3C/S5P/Exynos FIMD bindings to DT schema format.

The conversion includes also updates to the bindings, matching the
current DTS and Linux driver: adding optional iommus and power-domains.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../bindings/display/exynos/samsung-fimd.txt  | 107 ----------
 .../display/samsung/samsung,fimd.yaml         | 198 ++++++++++++++++++
 2 files changed, 198 insertions(+), 107 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/exynos/samsung-fimd.txt
 create mode 100644 Documentation/devicetree/bindings/display/samsung/samsung,fimd.yaml

diff --git a/Documentation/devicetree/bindings/display/exynos/samsung-fimd.txt b/Documentation/devicetree/bindings/display/exynos/samsung-fimd.txt
deleted file mode 100644
index b3096421d42b..000000000000
--- a/Documentation/devicetree/bindings/display/exynos/samsung-fimd.txt
+++ /dev/null
@@ -1,107 +0,0 @@
-Device-Tree bindings for Samsung SoC display controller (FIMD)
-
-FIMD (Fully Interactive Mobile Display) is the Display Controller for the
-Samsung series of SoCs which transfers the image data from a video memory
-buffer to an external LCD interface.
-
-Required properties:
-- compatible: value should be one of the following
-		"samsung,s3c2443-fimd"; /* for S3C24XX SoCs */
-		"samsung,s3c6400-fimd"; /* for S3C64XX SoCs */
-		"samsung,s5pv210-fimd"; /* for S5PV210 SoC */
-		"samsung,exynos3250-fimd"; /* for Exynos3250/3472 SoCs */
-		"samsung,exynos4210-fimd"; /* for Exynos4 SoCs */
-		"samsung,exynos5250-fimd"; /* for Exynos5250 SoCs */
-		"samsung,exynos5420-fimd"; /* for Exynos5420/5422/5800 SoCs */
-
-- reg: physical base address and length of the FIMD registers set.
-
-- interrupts: should contain a list of all FIMD IP block interrupts in the
-		 order: FIFO Level, VSYNC, LCD_SYSTEM. The interrupt specifier
-		 format depends on the interrupt controller used.
-
-- interrupt-names: should contain the interrupt names: "fifo", "vsync",
-	"lcd_sys", in the same order as they were listed in the interrupts
-        property.
-
-- pinctrl-0: pin control group to be used for this controller.
-
-- pinctrl-names: must contain a "default" entry.
-
-- clocks: must include clock specifiers corresponding to entries in the
-         clock-names property.
-
-- clock-names: list of clock names sorted in the same order as the clocks
-               property. Must contain "sclk_fimd" and "fimd".
-
-Optional Properties:
-- power-domains: a phandle to FIMD power domain node.
-- samsung,invert-vden: video enable signal is inverted
-- samsung,invert-vclk: video clock signal is inverted
-- display-timings: timing settings for FIMD, as described in document [1].
-		Can be used in case timings cannot be provided otherwise
-		or to override timings provided by the panel.
-- samsung,sysreg: handle to syscon used to control the system registers
-- i80-if-timings: timing configuration for lcd i80 interface support.
-  - cs-setup: clock cycles for the active period of address signal is enabled
-              until chip select is enabled.
-              If not specified, the default value(0) will be used.
-  - wr-setup: clock cycles for the active period of CS signal is enabled until
-              write signal is enabled.
-              If not specified, the default value(0) will be used.
-  - wr-active: clock cycles for the active period of CS is enabled.
-               If not specified, the default value(1) will be used.
-  - wr-hold: clock cycles for the active period of CS is disabled until write
-             signal is disabled.
-             If not specified, the default value(0) will be used.
-
-  The parameters are defined as:
-
-    VCLK(internal)  __|??????|_____|??????|_____|??????|_____|??????|_____|??
-                      :            :            :            :            :
-    Address Output  --:<XXXXXXXXXXX:XXXXXXXXXXXX:XXXXXXXXXXXX:XXXXXXXXXXXX:XX
-                      | cs-setup+1 |            :            :            :
-                      |<---------->|            :            :            :
-    Chip Select     ???????????????|____________:____________:____________|??
-                                   | wr-setup+1 |            | wr-hold+1  |
-                                   |<---------->|            |<---------->|
-    Write Enable    ????????????????????????????|____________|???????????????
-                                                | wr-active+1|
-                                                |<---------->|
-    Video Data      ----------------------------<XXXXXXXXXXXXXXXXXXXXXXXXX>--
-
-The device node can contain 'port' child nodes according to the bindings defined
-in [2]. The following are properties specific to those nodes:
-- reg: (required) port index, can be:
-		0 - for CAMIF0 input,
-		1 - for CAMIF1 input,
-		2 - for CAMIF2 input,
-		3 - for parallel output,
-		4 - for write-back interface
-
-[1]: Documentation/devicetree/bindings/display/panel/display-timing.txt
-[2]: Documentation/devicetree/bindings/media/video-interfaces.txt
-
-Example:
-
-SoC specific DT entry:
-
-	fimd@11c00000 {
-		compatible = "samsung,exynos4210-fimd";
-		interrupt-parent = <&combiner>;
-		reg = <0x11c00000 0x20000>;
-		interrupt-names = "fifo", "vsync", "lcd_sys";
-		interrupts = <11 0>, <11 1>, <11 2>;
-		clocks = <&clock 140>, <&clock 283>;
-		clock-names = "sclk_fimd", "fimd";
-		power-domains = <&pd_lcd0>;
-		status = "disabled";
-	};
-
-Board specific DT entry:
-
-	fimd@11c00000 {
-		pinctrl-0 = <&lcd_clk &lcd_data24 &pwm1_out>;
-		pinctrl-names = "default";
-		status = "okay";
-	};
diff --git a/Documentation/devicetree/bindings/display/samsung/samsung,fimd.yaml b/Documentation/devicetree/bindings/display/samsung/samsung,fimd.yaml
new file mode 100644
index 000000000000..9cf5f120d516
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/samsung/samsung,fimd.yaml
@@ -0,0 +1,198 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/samsung/samsung,fimd.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung S3C/S5P/Exynos SoC Fully Interactive Mobile Display (FIMD)
+
+maintainers:
+  - Inki Dae <inki.dae@samsung.com>
+  - Joonyoung Shim <jy0922.shim@samsung.com>
+  - Seung-Woo Kim <sw0312.kim@samsung.com>
+  - Kyungmin Park <kyungmin.park@samsung.com>
+  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
+
+properties:
+  compatible:
+    enum:
+      - samsung,s3c2443-fimd
+      - samsung,s3c6400-fimd
+      - samsung,s5pv210-fimd
+      - samsung,exynos3250-fimd
+      - samsung,exynos4210-fimd
+      - samsung,exynos5250-fimd
+      - samsung,exynos5420-fimd
+
+  '#address-cells':
+    const: 1
+
+  clocks:
+    minItems: 2
+    maxItems: 2
+
+  clock-names:
+    items:
+      - const: sclk_fimd
+      - const: fimd
+
+  display-timings:
+    $ref: ../panel/display-timings.yaml#
+
+  i80-if-timings:
+    type: object
+    description: |
+      Timing configuration for lcd i80 interface support.
+      The parameters are defined as::
+      VCLK(internal)  __|??????|_____|??????|_____|??????|_____|??????|_____|??
+                        :            :            :            :            :
+      Address Output  --:<XXXXXXXXXXX:XXXXXXXXXXXX:XXXXXXXXXXXX:XXXXXXXXXXXX:XX
+                        | cs-setup+1 |            :            :            :
+                        |<---------->|            :            :            :
+      Chip Select     ???????????????|____________:____________:____________|??
+                                     | wr-setup+1 |            | wr-hold+1  |
+                                     |<---------->|            |<---------->|
+      Write Enable    ????????????????????????????|____________|???????????????
+                                                  | wr-active+1|
+                                                  |<---------->|
+      Video Data      ----------------------------<XXXXXXXXXXXXXXXXXXXXXXXXX>--
+
+    properties:
+      cs-setup:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description:
+          Clock cycles for the active period of address signal is enabled until
+          chip select is enabled.
+        default: 0
+
+      wr-active:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description:
+          Clock cycles for the active period of CS is enabled.
+        default: 1
+
+      wr-hold:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description:
+          Clock cycles for the active period of CS is disabled until write
+          signal is disabled.
+        default: 0
+
+      wr-setup:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description:
+          Clock cycles for the active period of CS signal is enabled until
+          write signal is enabled.
+        default: 0
+
+  iommus:
+    minItems: 1
+    maxItems: 2
+
+  iommu-names:
+    items:
+      - const: m0
+      - const: m1
+
+  interrupts:
+    items:
+      - description: FIFO level
+      - description: VSYNC
+      - description: LCD system
+
+  interrupt-names:
+    items:
+      - const: fifo
+      - const: vsync
+      - const: lcd_sys
+
+  power-domains:
+    maxItems: 1
+
+  reg:
+    maxItems: 1
+
+  samsung,invert-vden:
+    type: boolean
+    description:
+      Video enable signal is inverted.
+
+  samsung,invert-vclk:
+    type: boolean
+    description:
+      Video clock signal is inverted.
+
+  samsung,sysreg:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to System Register syscon.
+
+  '#size-cells':
+    const: 0
+
+patternProperties:
+  "^port@[0-4]+$":
+    $ref: /schemas/graph.yaml#/properties/port
+    description: |
+      Contains ports with port with index::
+       0 - for CAMIF0 input,
+       1 - for CAMIF1 input,
+       2 - for CAMIF2 input,
+       3 - for parallel output,
+       4 - for write-back interface
+
+required:
+  - compatible
+  - clocks
+  - clock-names
+  - interrupts
+  - interrupt-names
+  - reg
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: samsung,exynos5420-fimd
+    then:
+      properties:
+        iommus:
+          minItems: 2
+          maxItems: 2
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/exynos4.h>
+
+    fimd@11c00000 {
+        compatible = "samsung,exynos4210-fimd";
+        interrupt-parent = <&combiner>;
+        reg = <0x11c00000 0x20000>;
+        interrupt-names = "fifo", "vsync", "lcd_sys";
+        interrupts = <11 0>, <11 1>, <11 2>;
+        clocks = <&clock CLK_SCLK_FIMD0>, <&clock CLK_FIMD0>;
+        clock-names = "sclk_fimd", "fimd";
+        power-domains = <&pd_lcd0>;
+        iommus = <&sysmmu_fimd0>;
+        samsung,sysreg = <&sys_reg>;
+
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        samsung,invert-vden;
+        samsung,invert-vclk;
+
+        pinctrl-0 = <&lcd_clk>, <&lcd_data24>;
+        pinctrl-names = "default";
+
+        port@3 {
+            reg = <3>;
+
+            fimd_dpi_ep: endpoint {
+                remote-endpoint = <&lcd_ep>;
+            };
+        };
+    };
-- 
2.32.0

