Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99C3D4EAC52
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 13:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233755AbiC2LbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 07:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235839AbiC2La5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 07:30:57 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CCBD217C5C
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 04:29:13 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id r13so34463043ejd.5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 04:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wwsD36jkMu3Ozm4XuoFqVrrV9ruReCnAdUyWlsceS8Q=;
        b=TfBZHVsi5hEmilaXd0EDXgtTDF7kzsGppVJcp4BBY9LfA2cr6ZpzDAhAh/+ruKfhCp
         NutylsGq/Oh57YdhiuuxYKI7srGmAtqJLU6jukDZIiHDqe1y8SMfMWTB37CTtZqGvbPn
         lxZDVgH/mZsNMYXc8zp3DvhGEzFKq+dzff3q/p7UTyR9bBc1XzhYXuVESBB+0c1/HUmf
         GezEUu9q2HBx1XONuKueWS0m0CEq5cJHG+RiWHJgIVUCnDI7ZbJ7VV/ZaajMzLYW0znn
         GW+db0N+u9/XcRoTQnshEMNB0NdoWu7dyNU0gAEBMTJduasp5GjlgAYYVHnB6p1Hje15
         ycYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wwsD36jkMu3Ozm4XuoFqVrrV9ruReCnAdUyWlsceS8Q=;
        b=3WBWLGIA2RngILP4TpFFSyTnq05oRyt3FFzODKSlIdVDJFkk3imgApnJ4ly9nzx2IY
         4pI+q16NMATh17X+LBC57iURyxz2Rn2bHc9l1z+QNxQjDJ0acPsfybJ0oexj1KTbFaB6
         H893POZnuJlELUVXQrnyPj6rifHTMJ3Cj3cDsHD5IlPVxN1IoR5FmtkOnrH6Y38F54G+
         7KkhKWruqIILoWQJDSHuElzwENyPyW9sLbdtbzHnhyhiFiS+F4FtRf5vt4YEk3xpfe4y
         VQmXVLzNjBWHEfWG2tCQw0OwtUaPnx4Iwltb0hG4plXctBxG3ZmdiKR3fK5ow38sTJmU
         AmrQ==
X-Gm-Message-State: AOAM533MsXw2OwoACp+Sdd4ZaNl9hwPSercIUQviaUv+ajuB9Lpof5JO
        KWGaEyM/WMUDKzWggqau+Qn0CoLI6PtOxirD
X-Google-Smtp-Source: ABdhPJxJ+BHLQTLhufREjnk6sinn7NMmw2bohnYnQD6TiKRg9oB/89z+TACfOBkV/ki4rboLBhhOAw==
X-Received: by 2002:a17:906:6a1a:b0:6e1:87a:151f with SMTP id qw26-20020a1709066a1a00b006e1087a151fmr13558941ejc.715.1648553351332;
        Tue, 29 Mar 2022 04:29:11 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id t19-20020a056402525300b0041952a1a764sm8510909edd.33.2022.03.29.04.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 04:29:10 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 4/4] spi: dt-bindings: qcom,spi-qup: convert to dtschema
Date:   Tue, 29 Mar 2022 13:29:02 +0200
Message-Id: <20220329112902.252937-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220329112902.252937-1-krzysztof.kozlowski@linaro.org>
References: <20220329112902.252937-1-krzysztof.kozlowski@linaro.org>
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

Convert the Qualcomm Universal Peripheral (QUP) Serial Peripheral
Interface (SPI) bindings to DT Schema.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/spi/qcom,spi-qup.txt  | 103 ------------------
 .../devicetree/bindings/spi/qcom,spi-qup.yaml |  82 ++++++++++++++
 2 files changed, 82 insertions(+), 103 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/spi/qcom,spi-qup.txt
 create mode 100644 Documentation/devicetree/bindings/spi/qcom,spi-qup.yaml

diff --git a/Documentation/devicetree/bindings/spi/qcom,spi-qup.txt b/Documentation/devicetree/bindings/spi/qcom,spi-qup.txt
deleted file mode 100644
index 5c090771c016..000000000000
--- a/Documentation/devicetree/bindings/spi/qcom,spi-qup.txt
+++ /dev/null
@@ -1,103 +0,0 @@
-Qualcomm Universal Peripheral (QUP) Serial Peripheral Interface (SPI)
-
-The QUP core is an AHB slave that provides a common data path (an output FIFO
-and an input FIFO) for serial peripheral interface (SPI) mini-core.
-
-SPI in master mode supports up to 50MHz, up to four chip selects, programmable
-data path from 4 bits to 32 bits and numerous protocol variants.
-
-Required properties:
-- compatible:     Should contain:
-		  "qcom,spi-qup-v1.1.1" for 8660, 8960 and 8064.
-		  "qcom,spi-qup-v2.1.1" for 8974 and later
-		  "qcom,spi-qup-v2.2.1" for 8974 v2 and later.
-
-- reg:            Should contain base register location and length
-- interrupts:     Interrupt number used by this controller
-
-- clocks:         Should contain the core clock and the AHB clock.
-- clock-names:    Should be "core" for the core clock and "iface" for the
-                  AHB clock.
-
-- #address-cells: Number of cells required to define a chip select
-                  address on the SPI bus. Should be set to 1.
-- #size-cells:    Should be zero.
-
-Optional properties:
-- spi-max-frequency: Specifies maximum SPI clock frequency,
-                     Units - Hz. Definition as per
-                     Documentation/devicetree/bindings/spi/spi-bus.txt
-- num-cs:	total number of chipselects
-- cs-gpios:	should specify GPIOs used for chipselects.
-		The gpios will be referred to as reg = <index> in the SPI child
-		nodes.  If unspecified, a single SPI device without a chip
-		select can be used.
-
-- dmas:         Two DMA channel specifiers following the convention outlined
-                in bindings/dma/dma.txt
-- dma-names:    Names for the dma channels, if present. There must be at
-                least one channel named "tx" for transmit and named "rx" for
-                receive.
-
-SPI slave nodes must be children of the SPI master node and can contain
-properties described in Documentation/devicetree/bindings/spi/spi-bus.txt
-
-Example:
-
-	spi_8: spi@f9964000 { /* BLSP2 QUP2 */
-
-		compatible = "qcom,spi-qup-v2";
-		#address-cells = <1>;
-		#size-cells = <0>;
-		reg = <0xf9964000 0x1000>;
-		interrupts = <0 102 0>;
-		spi-max-frequency = <19200000>;
-
-		clocks = <&gcc GCC_BLSP2_QUP2_SPI_APPS_CLK>, <&gcc GCC_BLSP2_AHB_CLK>;
-		clock-names = "core", "iface";
-
-		dmas = <&blsp1_bam 13>, <&blsp1_bam 12>;
-		dma-names = "rx", "tx";
-
-		pinctrl-names = "default";
-		pinctrl-0 = <&spi8_default>;
-
-		device@0 {
-			compatible = "arm,pl022-dummy";
-			#address-cells = <1>;
-			#size-cells = <1>;
-			reg = <0>; /* Chip select 0 */
-			spi-max-frequency = <19200000>;
-			spi-cpol;
-		};
-
-		device@1 {
-			compatible = "arm,pl022-dummy";
-			#address-cells = <1>;
-			#size-cells = <1>;
-			reg = <1>; /* Chip select 1 */
-			spi-max-frequency = <9600000>;
-			spi-cpha;
-		};
-
-		device@2 {
-			compatible = "arm,pl022-dummy";
-			#address-cells = <1>;
-			#size-cells = <1>;
-			reg = <2>; /* Chip select 2 */
-			spi-max-frequency = <19200000>;
-			spi-cpol;
-			spi-cpha;
-		};
-
-		device@3 {
-			compatible = "arm,pl022-dummy";
-			#address-cells = <1>;
-			#size-cells = <1>;
-			reg = <3>; /* Chip select 3 */
-			spi-max-frequency = <19200000>;
-			spi-cpol;
-			spi-cpha;
-			spi-cs-high;
-		};
-	};
diff --git a/Documentation/devicetree/bindings/spi/qcom,spi-qup.yaml b/Documentation/devicetree/bindings/spi/qcom,spi-qup.yaml
new file mode 100644
index 000000000000..aa5756f7ba85
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/qcom,spi-qup.yaml
@@ -0,0 +1,82 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/qcom,spi-qup.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Universal Peripheral (QUP) Serial Peripheral Interface (SPI)
+
+maintainers:
+  - Andy Gross <agross@kernel.org>
+  - Bjorn Andersson <bjorn.andersson@linaro.org>
+  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+
+description:
+  The QUP core is an AHB slave that provides a common data path (an output FIFO
+  and an input FIFO) for serial peripheral interface (SPI) mini-core.
+
+  SPI in master mode supports up to 50MHz, up to four chip selects,
+  programmable data path from 4 bits to 32 bits and numerous protocol variants.
+
+allOf:
+  - $ref: /spi/spi-controller.yaml#
+
+properties:
+  compatible:
+    enum:
+      - qcom,spi-qup-v1.1.1 # for 8660, 8960 and 8064
+      - qcom,spi-qup-v2.1.1 # for 8974 and later
+      - qcom,spi-qup-v2.2.1 # for 8974 v2 and later
+
+  clocks:
+    maxItems: 2
+
+  clock-names:
+    items:
+      - const: core
+      - const: iface
+
+  dmas:
+    maxItems: 2
+
+  dma-names:
+    items:
+      - const: tx
+      - const: rx
+
+  interrupts:
+    maxItems: 1
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - clocks
+  - clock-names
+  - interrupts
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,gcc-msm8996.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    spi@7575000 {
+        compatible = "qcom,spi-qup-v2.2.1";
+        reg = <0x07575000 0x600>;
+        interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&gcc GCC_BLSP1_QUP1_SPI_APPS_CLK>,
+                 <&gcc GCC_BLSP1_AHB_CLK>;
+        clock-names = "core",
+                      "iface";
+        pinctrl-names = "default", "sleep";
+        pinctrl-0 = <&blsp1_spi1_default>;
+        pinctrl-1 = <&blsp1_spi1_sleep>;
+        dmas = <&blsp1_dma 12>, <&blsp1_dma 13>;
+        dma-names = "tx", "rx";
+        #address-cells = <1>;
+        #size-cells = <0>;
+    };
-- 
2.32.0

