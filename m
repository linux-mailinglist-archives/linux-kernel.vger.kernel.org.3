Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C90A2542F25
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 13:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238214AbiFHL1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 07:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238180AbiFHL1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 07:27:10 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0491E14A936
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 04:27:08 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id y19so40822849ejq.6
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 04:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GQP2bwf02bCPb3p1b5kmO7uKZq8s04Q6xeuolnL2ees=;
        b=Q4MJ7eCMUMGfx3UEpwkqoBH/mCtFQQg9j3lKLIIr4llFK49BreVYaukIl/VxNSSiqq
         YdsSF0VS4j78nZ/Ht+nIcEX7fsgmqAINZ9NGmPf+Cx60UdY4Ypdx69D0r6fuwoSmKxxb
         cUM0akJ112VkFYOikQYbpbOPgXXaxVciDCgsAf0yi1E9oPir84bZLEfcKfPHrXyKcSux
         Ck6srZSvDCrhoZkfpEpp93qTCcF/G/A/Xgy7UifxyjQlVcrwSkpKruCzCCi8WyqtsYgB
         +ad5LBBEssQ/STZXcDYqJ2pMlyScRe/AbHtfCi/SsdrRgZs7vdnWjywD/0tDjVuVG8Ek
         MgHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GQP2bwf02bCPb3p1b5kmO7uKZq8s04Q6xeuolnL2ees=;
        b=Ds+YbYYpw+qcFVb41sLWmsuAiLeCBmu4glmxexSNYPn5U1b68KTFXP73Ygo/gEP+iU
         AtzPABjBt7xPAJScd1AUW9naHZSG3K6PKu57C8YElwTl72plNCU01dt75oOOE+rqKGiY
         PTsA9BGOnHdpDv4alpUpGacXrFHZXG1JRXStEaL6tbG3OtLJY3PL7UARyweRs+JJIyZD
         Fc0e35/dBY9NXQJYh3EmazU2b49jRUx5v7YnBRHwC4lQPteGhQxDbLKKaiibB7UYf2h/
         gaIR0Lp5wgaNI8tXEjIXAo5v8VnzzBqkEYePIUFlfJ7nfWvlXLhVYK33vgP34JyXgnKK
         vAzw==
X-Gm-Message-State: AOAM5336jDcPe+78GJo3jLaAAGMCk7Wu+Nqv8N+YPEPO1JPnt4n494uZ
        teTd5CZH6jPf7lRoJwzDYHg3FA==
X-Google-Smtp-Source: ABdhPJwuljUq8jUguPt4DqqFPJ+0+t5pGM/BV881uqo9lRenq0gYe+ZVUWjx4dIPQ2+WeKB1o/YEFg==
X-Received: by 2002:a17:906:4fc9:b0:70f:8970:dda2 with SMTP id i9-20020a1709064fc900b0070f8970dda2mr23009032ejw.324.1654687626507;
        Wed, 08 Jun 2022 04:27:06 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id g12-20020a056402424c00b00431962fe5d4sm2729956edb.77.2022.06.08.04.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 04:27:05 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "Ivan T. Ivanov" <ivan.ivanov@linaro.org>,
        Kumar Gala <galak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] dt-bindings: thermal: qcom,spmi-temp-alarm: convert to dtschema
Date:   Wed,  8 Jun 2022 13:27:01 +0200
Message-Id: <20220608112702.80873-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Convert the Qualcomm QPNP PMIC Temperature Alarm to DT Schema.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../thermal/qcom,spmi-temp-alarm.yaml         | 85 +++++++++++++++++++
 .../bindings/thermal/qcom-spmi-temp-alarm.txt | 51 -----------
 2 files changed, 85 insertions(+), 51 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/thermal/qcom,spmi-temp-alarm.yaml
 delete mode 100644 Documentation/devicetree/bindings/thermal/qcom-spmi-temp-alarm.txt

diff --git a/Documentation/devicetree/bindings/thermal/qcom,spmi-temp-alarm.yaml b/Documentation/devicetree/bindings/thermal/qcom,spmi-temp-alarm.yaml
new file mode 100644
index 000000000000..5f08b6e59b8a
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/qcom,spmi-temp-alarm.yaml
@@ -0,0 +1,85 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/qcom,spmi-temp-alarm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm QPNP PMIC Temperature Alarm
+
+maintainers:
+  - Bjorn Andersson <bjorn.andersson@linaro.org>
+
+description:
+  QPNP temperature alarm peripherals are found inside of Qualcomm PMIC chips
+  that utilize the Qualcomm SPMI implementation. These peripherals provide an
+  interrupt signal and status register to identify high PMIC die temperature.
+
+allOf:
+  - $ref: thermal-sensor.yaml#
+
+properties:
+  compatible:
+    const: qcom,spmi-temp-alarm
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  io-channels:
+    items:
+      - description: ADC channel, which reports chip die temperature
+
+  io-channel-names:
+    items:
+      - const: thermal
+
+  '#thermal-sensor-cells':
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - '#thermal-sensor-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    pmic {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        pm8350_temp_alarm: temperature-sensor@a00 {
+            compatible = "qcom,spmi-temp-alarm";
+            reg = <0xa00>;
+            interrupts = <0x1 0xa 0x0 IRQ_TYPE_EDGE_BOTH>;
+            #thermal-sensor-cells = <0>;
+        };
+    };
+
+    thermal-zones {
+        pm8350_thermal: pm8350c-thermal {
+            polling-delay-passive = <100>;
+            polling-delay = <0>;
+            thermal-sensors = <&pm8350_temp_alarm>;
+
+            trips {
+                pm8350_trip0: trip0 {
+                    temperature = <95000>;
+                    hysteresis = <0>;
+                    type = "passive";
+                };
+
+                pm8350_crit: pm8350c-crit {
+                    temperature = <115000>;
+                    hysteresis = <0>;
+                    type = "critical";
+                };
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/thermal/qcom-spmi-temp-alarm.txt b/Documentation/devicetree/bindings/thermal/qcom-spmi-temp-alarm.txt
deleted file mode 100644
index 2d5b2ad03314..000000000000
--- a/Documentation/devicetree/bindings/thermal/qcom-spmi-temp-alarm.txt
+++ /dev/null
@@ -1,51 +0,0 @@
-Qualcomm QPNP PMIC Temperature Alarm
-
-QPNP temperature alarm peripherals are found inside of Qualcomm PMIC chips
-that utilize the Qualcomm SPMI implementation. These peripherals provide an
-interrupt signal and status register to identify high PMIC die temperature.
-
-Required properties:
-- compatible:      Should contain "qcom,spmi-temp-alarm".
-- reg:             Specifies the SPMI address.
-- interrupts:      PMIC temperature alarm interrupt.
-- #thermal-sensor-cells: Should be 0. See Documentation/devicetree/bindings/thermal/thermal-sensor.yaml for a description.
-
-Optional properties:
-- io-channels:     Should contain IIO channel specifier for the ADC channel,
-                   which report chip die temperature.
-- io-channel-names: Should contain "thermal".
-
-Example:
-
-	pm8941_temp: thermal-alarm@2400 {
-		compatible = "qcom,spmi-temp-alarm";
-		reg = <0x2400>;
-		interrupts = <0 0x24 0 IRQ_TYPE_EDGE_RISING>;
-		#thermal-sensor-cells = <0>;
-
-		io-channels = <&pm8941_vadc VADC_DIE_TEMP>;
-		io-channel-names = "thermal";
-	};
-
-	thermal-zones {
-		pm8941 {
-			polling-delay-passive = <250>;
-			polling-delay = <1000>;
-
-			thermal-sensors = <&pm8941_temp>;
-
-			trips {
-				stage1 {
-					temperature = <105000>;
-					hysteresis = <2000>;
-					type = "passive";
-				};
-				stage2 {
-					temperature = <125000>;
-					hysteresis = <2000>;
-					type = "critical";
-				};
-			};
-		};
-	};
-
-- 
2.34.1

