Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 500324EDE3D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 18:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238816AbiCaQFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 12:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239510AbiCaQFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 12:05:00 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C7E1F2DF9
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 09:03:03 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id g20so28692617edw.6
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 09:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LsohyqOTYtjeLY/FdtDq9Hs2S+lnj2GyDL8XIkBv7/s=;
        b=SP0DnT+zXeheKpY08siB7JfjgUoxE/xUvqlEpO3D2qYuG3hYVRt8OIEVKqUcSLB4wU
         bgqFSkgeK3wzbMo4z10UQhP0u/V/Pk9mW2HCjtXkmOZPsMgubNbmyvQofMo+GCMdfllz
         O4hg0wPw9KOPbo3I34u6BtAh5H09tlr5V671oXSeo54Qwn+/1rjLC2cY62hIyxE7MxCq
         8EkK94jwiy8YA6eMRm9IP+VRhCms5NHWwG0jzrOxpncTS+yuVdP7/F2x0ldWipPmQdS7
         MLzG+v/XeR5cxmLD0GrnBIHSuRZsMf0YX5YVxKzq1r8AWg94mZIVmJSUsgE2V/md1qiK
         ZJFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LsohyqOTYtjeLY/FdtDq9Hs2S+lnj2GyDL8XIkBv7/s=;
        b=Q8wlZNjF348wcqjbvfIDZJRQd+Yot3IC17Qhu/9bQCxeC1yVHX0IoQpuMLj/5bNNJR
         y8IjJgyWhi3Z4PhKaf4an6vWQRfB1naCsZAccXMz/xO/1FqDCYiZIjEmBHmxDaDcVh3H
         +rt1nJHeIrJWC0ig+/qYo2dEe03g0FZNvqWHc2CfWblkLKkChxzx1WMGJBHCdmwb/Nyw
         hhYLAvwi+zmeltC0G6lcZQEqbL26TzBMTrcs1Xeupi0uxvwITTZ+3T3G9CeaYVgZrncJ
         5h9r5ONf6YQ1vCUghJ5VpZgaBhbzd+X4wFatSOvikO5rNyQ+jrD9dw1aT7snmGtf/k4p
         JWoA==
X-Gm-Message-State: AOAM530UWsWurbKP92uQvx4IIPs+IeY5RHPmtYwAhal9XlfOnKMoqgOs
        c0kxTh/BnfOiI404JL/1aRDstw==
X-Google-Smtp-Source: ABdhPJxB0u62yvNMPi8+ehPNmcqqLZYj23E/zLB13I42inTDaqG5vRRNOI45+sI6ALrh2HwMKlXYEA==
X-Received: by 2002:a05:6402:289d:b0:419:437:ef4f with SMTP id eg29-20020a056402289d00b004190437ef4fmr17270028edb.110.1648742579833;
        Thu, 31 Mar 2022 09:02:59 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id n6-20020aa7c786000000b00410d2403ccfsm11441148eds.21.2022.03.31.09.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 09:02:59 -0700 (PDT)
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
Subject: [PATCH v2 1/2] spi: dt-bindings: qcom,spi-geni-qcom: convert to dtschema
Date:   Thu, 31 Mar 2022 18:02:47 +0200
Message-Id: <20220331160248.716234-1-krzysztof.kozlowski@linaro.org>
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

Changes since v1:
1. Correct $ref path and remove interconnect minItems (Kuldeep).
2. Remove child tpm device from example.
3. Pad reg hex addresses with 00.
---
 .../bindings/spi/qcom,spi-geni-qcom.txt       |  39 ------
 .../bindings/spi/qcom,spi-geni-qcom.yaml      | 120 ++++++++++++++++++
 2 files changed, 120 insertions(+), 39 deletions(-)
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
index 000000000000..62c4a9598e16
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.yaml
@@ -0,0 +1,120 @@
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

