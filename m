Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3720A4EAC3E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 13:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235795AbiC2L3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 07:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235783AbiC2L3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 07:29:10 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A511E7442
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 04:27:27 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id c62so20316517edf.5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 04:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SMoTIaUUthAjOzLwTdlUwACg0m9q40Zv/fQFa/fjWjc=;
        b=vUbcnnztCCDqfPbVstTl38YpzsYXJ0urjnSjlgbQw4X3CmGgt7mqzkefM9o8n1EIWx
         w1A0J69W8CW5mUli//9mTvBoTN1XkcjSr5qmseXp8uq4iSI3fIWkWo2Es1r4mZqodf62
         rXOMf8VLZ4gwrTDu6241/lUNLdo0oOa7Yerjy3KoCwK57Jl3hkg43c6SmwtwCo7CyCzB
         idQjIjMgijrCU69FZwUJkMopX2VYGnZNJOihk2m/URPgYMK7zBymLjGrxGHGIeV0OGff
         QNZ0QAFfz45W42smrz4pCkA9FMrWuHzecSg9R9joVXr0PUlvA+lKy4yj5UBTLyR6PiRA
         TAjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SMoTIaUUthAjOzLwTdlUwACg0m9q40Zv/fQFa/fjWjc=;
        b=6x2q/XPuBD7FieSHxEwQPZ5z/G+OeSuD+u+UaV3rPJV5n6OKP8wf2lTwLwPXKXu1hK
         Z9LB0qb9/FnG92UgHJLuNUJPBI4lLMdhdlUoOQALsh5UtAk+JX9wz5pgaafMLQ17l6JR
         eVhZyV8fm+BWIzqwWICpTPI3cqfF8+FDcLWQnJiZ9m/5pPFiDSgNSZRmBpACs1E7+VqX
         QhDfVnk2bceDXxjlCBMhex1sc9+ows3RypS7QcLzqRppS9NGBUIWRhbUtoahzFUhGj6h
         E9W1sGrKLyvQ5SICD6rnhzu69UXBCNT4nFdnWHr1LzBVQg/rDVair0hCilNFYQSQkE19
         TVDw==
X-Gm-Message-State: AOAM531Z/5zSY4eFr2mNRUS9Sab5iwbx1wySD8sM0XIibueT8AsZNrQB
        jILeLJ/27ku8Y2rjAr4eymy56Iu2lfYAgJKn
X-Google-Smtp-Source: ABdhPJz1Kq5z6PP9CVB7G5fXvzQH2zWP5Jxn/BkJ5k30+ZGWqZVul1gNnQ6ByQDgrdZ7t7wD2VOfxQ==
X-Received: by 2002:a05:6402:909:b0:415:cdbf:4748 with SMTP id g9-20020a056402090900b00415cdbf4748mr3836026edz.395.1648553245597;
        Tue, 29 Mar 2022 04:27:25 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id z13-20020a17090674cd00b006df78d85eabsm7043795ejl.111.2022.03.29.04.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 04:27:25 -0700 (PDT)
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
Subject: [PATCH 1/2] spi: dt-bindings: qcom,spi-geni-qcom: convert to dtschema
Date:   Tue, 29 Mar 2022 13:27:16 +0200
Message-Id: <20220329112717.252647-1-krzysztof.kozlowski@linaro.org>
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
properties already used in DTS and/or in the driver: reg-names, dmas,
interconnects, operating points and power-domains.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/spi/qcom,spi-geni-qcom.txt       |  39 ------
 .../bindings/spi/qcom,spi-geni-qcom.yaml      | 131 ++++++++++++++++++
 2 files changed, 131 insertions(+), 39 deletions(-)
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
index 000000000000..a85ff02ba1db
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.yaml
@@ -0,0 +1,131 @@
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
+  - $ref: /spi/spi-controller.yaml#
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
+    minItems: 2
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
+  reg-names:
+    const: se
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
+        reg = <0x880000 0x4000>;
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
+
+        tpm@0 {
+            compatible = "google,cr50";
+            reg = <0>;
+            pinctrl-names = "default";
+            pinctrl-0 = <&h1_ap_int_odl>;
+            spi-max-frequency = <800000>;
+            interrupt-parent = <&tlmm>;
+            interrupts = <42 IRQ_TYPE_EDGE_RISING>;
+        };
+    };
+
+  - |
+    #include <dt-bindings/dma/qcom-gpi.h>
+
+    spi@884000 {
+        compatible = "qcom,geni-spi";
+        reg = <0x884000 0x4000>;
+        reg-names = "se";
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

