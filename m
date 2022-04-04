Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6C334F0F88
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 08:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377538AbiDDGm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 02:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377531AbiDDGmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 02:42:24 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0C42B246
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 23:40:28 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id ot30so7841590ejb.12
        for <linux-kernel@vger.kernel.org>; Sun, 03 Apr 2022 23:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8gCgi9p6TQq4anxDc6yg6qvIn2LRBKe/bblZh/HGFbI=;
        b=D3wXcsYlnjTOFVZAZ55nRd97pR9b05nmrThFjbi/X+vRgaCEOgRUfOSYCQ/64n7ery
         xyXa+ZAxEX9u29ExhayG/++ZyLvlGDitznAuSsSZ0+PUC061DP7Elrw8YPW0HoIen2ZH
         ZehLlWOUgAqK+DDGnvje7RFhyh1WcguupVArAohM2LzTX1SQV5xE5N3XzGya7km/P76T
         IyESDXJsFeKcEJ96r0yhpJTJgdHtvF0XhfgUIRX/2UeeFIrhDaqQV4L0RGEAS3K6qWTo
         7YnE6O/d3rAIR6lbsp76Ri3y0RNSdpw9VJqiCJLxN9jXGq/FJnZzqHmeZRXHWnamGDuy
         Pxyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8gCgi9p6TQq4anxDc6yg6qvIn2LRBKe/bblZh/HGFbI=;
        b=LrPvw1ubtx/5fZNWuP3mirD6mhV1i88NMYYJabmIC4juZbTzihV0ndA68oGXwL18QX
         wV1Vkh4NKDWDVKubkOIaTGdyasJIKnUfx8bcDax1zFJdIwzhF8/uziShCDP6pasMfnYn
         nVW929wjD0/9PLFpJus/FLXSOw+XmEEtKsNTCqNHclniNT19060x0rn9Th12ZArilWqF
         DZ6+DyS2WomAkXKivljLKXzgKx+nV/4Ir0MKKY5A6XYDc/9i4YLaEUSZTVSjYcme4M0f
         LrUUKWSqqQ0g0HlpcZ2LfsnPzSTM9au45IBsAD6tIAmF2wg7q7GglVL4DICJS6SQ32LC
         HZ5g==
X-Gm-Message-State: AOAM532yczwtOF4s8BQRzp5F4G5Vyld1wVfhl3shQEckWHhB/nUag0fm
        VOan7oAdu7BJ2caPZed7QzfkIg==
X-Google-Smtp-Source: ABdhPJxx4XA9m4Y0ezx+xMbqpjNDdZ4/b0rLJQGyTSRnV7VNL8h3tZTlWBj7fdxRpU/0WLK5BggX8g==
X-Received: by 2002:a17:906:2f97:b0:6ce:3ef6:94be with SMTP id w23-20020a1709062f9700b006ce3ef694bemr9704339eji.136.1649054422386;
        Sun, 03 Apr 2022 23:40:22 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id i14-20020a50cfce000000b0041cbaba8743sm2676515edk.56.2022.04.03.23.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Apr 2022 23:40:21 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Cc:     Kuldeep Singh <singh.kuldeep87k@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 1/2] spi: dt-bindings: qcom,spi-geni-qcom: convert to dtschema
Date:   Mon,  4 Apr 2022 08:40:16 +0200
Message-Id: <20220404064017.68634-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
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

Convert the GENI based Qualcomm Universal Peripheral (QUP) Serial
Peripheral Interface (SPI) bindings to DT Schema.

The original bindings in TXT were not complete, so add during conversion
properties already used in DTS and/or in the driver: dmas,
interconnects, operating points and power-domains.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v2:
1. Drop reg-names.

Changes since v1:
1. Correct $ref path and remove interconnect minItems (Kuldeep).
2. Remove child tpm device from example.
3. Pad reg hex addresses with 00.
---
 .../bindings/spi/qcom,spi-geni-qcom.txt       |  39 ------
 .../bindings/spi/qcom,spi-geni-qcom.yaml      | 116 ++++++++++++++++++
 2 files changed, 116 insertions(+), 39 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.txt
 create mode 100644 Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.yaml

diff --git a/Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.txt b/Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.txt
deleted file mode 100644
index c8c1e913f4e7..000000000000
--- a/Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.txt
+++ /dev/null
@@ -1,39 +0,0 @@
-GENI based Qualcomm Universal Peripheral (QUP) Serial Peripheral Interface (SPI)
-
-The QUP v3 core is a GENI based AHB slave that provides a common data path
-(an output FIFO and an input FIFO) for serial peripheral interface (SPI)
-mini-core.
-
-SPI in master mode supports up to 50MHz, up to four chip selects, programmable
-data path from 4 bits to 32 bits and numerous protocol variants.
-
-Required properties:
-- compatible:		Must contain "qcom,geni-spi".
-- reg:			Must contain SPI register location and length.
-- interrupts:		Must contain SPI controller interrupts.
-- clock-names:		Must contain "se".
-- clocks:		Serial engine core clock needed by the device.
-- #address-cells:	Must be <1> to define a chip select address on
-			the SPI bus.
-- #size-cells:		Must be <0>.
-
-SPI Controller nodes must be child of GENI based Qualcomm Universal
-Peripharal. Please refer GENI based QUP wrapper controller node bindings
-described in Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml.
-
-SPI slave nodes must be children of the SPI master node and conform to SPI bus
-binding as described in Documentation/devicetree/bindings/spi/spi-bus.txt.
-
-Example:
-	spi0: spi@a84000 {
-		compatible = "qcom,geni-spi";
-		reg = <0xa84000 0x4000>;
-		interrupts = <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>;
-		clock-names = "se";
-		clocks = <&clock_gcc GCC_QUPV3_WRAP0_S0_CLK>;
-		pinctrl-names = "default", "sleep";
-		pinctrl-0 = <&qup_1_spi_2_active>;
-		pinctrl-1 = <&qup_1_spi_2_sleep>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-	};
diff --git a/Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.yaml b/Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.yaml
new file mode 100644
index 000000000000..e2c7b934c50d
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.yaml
@@ -0,0 +1,116 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/qcom,spi-geni-qcom.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: GENI based Qualcomm Universal Peripheral (QUP) Serial Peripheral Interface (SPI)
+
+maintainers:
+  - Andy Gross <agross@kernel.org>
+  - Bjorn Andersson <bjorn.andersson@linaro.org>
+  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+
+description:
+  The QUP v3 core is a GENI based AHB slave that provides a common data path
+  (an output FIFO and an input FIFO) for serial peripheral interface (SPI)
+  mini-core.
+
+  SPI in master mode supports up to 50MHz, up to four chip selects,
+  programmable data path from 4 bits to 32 bits and numerous protocol variants.
+
+  SPI Controller nodes must be child of GENI based Qualcomm Universal
+  Peripharal. Please refer GENI based QUP wrapper controller node bindings
+  described in Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml.
+
+allOf:
+  - $ref: /schemas/spi/spi-controller.yaml#
+
+properties:
+  compatible:
+    const: qcom,geni-spi
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: se
+
+  dmas:
+    maxItems: 2
+
+  dma-names:
+    items:
+      - const: tx
+      - const: rx
+
+  interconnects:
+    maxItems: 2
+
+  interconnect-names:
+    items:
+      - const: qup-core
+      - const: qup-config
+
+  interrupts:
+    maxItems: 1
+
+  operating-points-v2: true
+
+  power-domains:
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
+    #include <dt-bindings/clock/qcom,gcc-sc7180.h>
+    #include <dt-bindings/interconnect/qcom,sc7180.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/power/qcom-rpmpd.h>
+
+    spi@880000 {
+        compatible = "qcom,geni-spi";
+        reg = <0x00880000 0x4000>;
+        clock-names = "se";
+        clocks = <&gcc GCC_QUPV3_WRAP0_S0_CLK>;
+        pinctrl-names = "default";
+        pinctrl-0 = <&qup_spi0_default>;
+        interrupts = <GIC_SPI 601 IRQ_TYPE_LEVEL_HIGH>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+        power-domains = <&rpmhpd SC7180_CX>;
+        operating-points-v2 = <&qup_opp_table>;
+        interconnects = <&qup_virt MASTER_QUP_CORE_0 0 &qup_virt SLAVE_QUP_CORE_0 0>,
+                        <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_0 0>;
+        interconnect-names = "qup-core", "qup-config";
+    };
+
+  - |
+    #include <dt-bindings/dma/qcom-gpi.h>
+
+    spi@884000 {
+        compatible = "qcom,geni-spi";
+        reg = <0x00884000 0x4000>;
+        clock-names = "se";
+        clocks = <&gcc GCC_QUPV3_WRAP0_S1_CLK>;
+        dmas = <&gpi_dma0 0 1 QCOM_GPI_SPI>,
+               <&gpi_dma0 1 1 QCOM_GPI_SPI>;
+        dma-names = "tx", "rx";
+        pinctrl-names = "default";
+        pinctrl-0 = <&qup_spi1_default>;
+        interrupts = <GIC_SPI 602 IRQ_TYPE_LEVEL_HIGH>;
+        spi-max-frequency = <50000000>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+    };
-- 
2.32.0

