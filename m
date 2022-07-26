Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3E35812AB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 14:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239017AbiGZMCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 08:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238983AbiGZMCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 08:02:25 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA1842BB25
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 05:02:23 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id u20so8456591ljk.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 05:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cDTwEdu24/gUiDYI5ikSRUFSCHm0lJ9NOTljGODPF9I=;
        b=YhCuGXoaxj6XopgqvDBVaPEXJAZgT2pVfEwWuuT05I9axW8GWcr8XWrM8TdJxlGLQt
         Vv7QhcxfBokRnGtmJUzFBCEZdEIrFci7P3GknpnIZkQgLmaQBpvfXyyfPR7eA9J+ydd2
         EEdVqvBURz1qpSOvBj5tOyO/PPW3CQ7EPWazot/PWCmSath+M6LM7l3CV0YKOT7zfdZt
         ejUCCRm+zu7ZCbAn1C5zXYpf9ZFJ2yMGTNFB1g8V6sDNxBExm9wAosexUKvuS4AAsd/h
         +kjeSdlwOXK8KLWUdf4WogFdY81ldE6MgA3QqoN3EKdh2KwhvDjANKuVzGHpCKAmDC/5
         ThBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cDTwEdu24/gUiDYI5ikSRUFSCHm0lJ9NOTljGODPF9I=;
        b=MAWQbTewIWN3OoKWEyQAVDIdzQGGJ7a5LcgkZGgREm44/BO0N6MaFB0q4nYnvOztEv
         ECeknD6WTP4rZWuLTsDSyoXrfq0oBduf6k4cOwbtS53i1BQy8maA0AEA6akz0WQ6LVql
         regG5E9wu4pEihirkq5qDS58C/UHWlCWHfxeTz2b3C7Fb8A1AJ0J6RKg+YoLnZPW5Z0Q
         hNRZZ/MMyH34gOJxYu45yb7M2BVrvnAdI65ANZh1PJjlXDi6dzdYvXB8+oUhmVZ+n1gj
         DsxzMIQYoqFNmqtXrKyC9uEo0gG6BEootu4rSl28UP9ugt9NBgNa+emEE0bQJ0VXR9+F
         sAbw==
X-Gm-Message-State: AJIora9BTlVHr8BwDMdDP/KmxjJ98Vy/eaFwgaPyyRD1U13njcGjbMhw
        rmDirCoxTFitK/EIhiybwkK2qw==
X-Google-Smtp-Source: AGRyM1sJQepMPWvxdDDt7L0oKFQmlKY9LIoZbWgDeEG3eq4A6JiV3VK/8WNv8nzs/PQEyWYrNMsLVg==
X-Received: by 2002:a2e:bc06:0:b0:25e:19b8:637b with SMTP id b6-20020a2ebc06000000b0025e19b8637bmr687944ljf.356.1658836941744;
        Tue, 26 Jul 2022 05:02:21 -0700 (PDT)
Received: from krzk-bin.lan (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id p15-20020a2e804f000000b0025ddf9a5b9csm3221865ljg.72.2022.07.26.05.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 05:02:21 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Vinod Koul <vkoul@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-watchdog@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] dt-bindings: watchdog: qcom,pm8916-wdt: convert to dtschema
Date:   Tue, 26 Jul 2022 14:02:15 +0200
Message-Id: <20220726120215.101868-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220726120215.101868-1-krzysztof.kozlowski@linaro.org>
References: <20220726120215.101868-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Qualcomm PM8916 watchdog timer controller bindings to DT
schema and include them in parent device schema.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/power/reset/qcom,pon.yaml        |  4 ++
 .../bindings/watchdog/qcom,pm8916-wdt.txt     | 28 ----------
 .../bindings/watchdog/qcom,pm8916-wdt.yaml    | 51 +++++++++++++++++++
 3 files changed, 55 insertions(+), 28 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/watchdog/qcom,pm8916-wdt.txt
 create mode 100644 Documentation/devicetree/bindings/watchdog/qcom,pm8916-wdt.yaml

diff --git a/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml b/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
index e8ecb75155db..e7b436d2e757 100644
--- a/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
+++ b/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
@@ -36,6 +36,10 @@ properties:
     type: object
     $ref: /schemas/input/qcom,pm8941-pwrkey.yaml#
 
+  watchdog:
+    type: object
+    $ref: /schemas/watchdog/qcom,pm8916-wdt.yaml
+
 required:
   - compatible
   - reg
diff --git a/Documentation/devicetree/bindings/watchdog/qcom,pm8916-wdt.txt b/Documentation/devicetree/bindings/watchdog/qcom,pm8916-wdt.txt
deleted file mode 100644
index 6fb984f31982..000000000000
--- a/Documentation/devicetree/bindings/watchdog/qcom,pm8916-wdt.txt
+++ /dev/null
@@ -1,28 +0,0 @@
-QCOM PM8916 watchdog timer controller
-
-This pm8916 watchdog timer controller must be under pm8916-pon node.
-
-Required properties:
-- compatible: should be "qcom,pm8916-wdt"
-
-Optional properties :
-- interrupts : Watchdog pre-timeout (bark) interrupt.
-- timeout-sec : Watchdog timeout value in seconds.
-
-Example:
-
-	pm8916_0: pm8916@0 {
-		compatible = "qcom,pm8916", "qcom,spmi-pmic";
-		reg = <0x0 SPMI_USID>;
-
-		pon@800 {
-			compatible = "qcom,pm8916-pon";
-			reg = <0x800>;
-
-			watchdog {
-				compatible = "qcom,pm8916-wdt";
-				interrupts = <0x0 0x8 6 IRQ_TYPE_EDGE_RISING>;
-				timeout-sec = <10>;
-			};
-		};
-	};
diff --git a/Documentation/devicetree/bindings/watchdog/qcom,pm8916-wdt.yaml b/Documentation/devicetree/bindings/watchdog/qcom,pm8916-wdt.yaml
new file mode 100644
index 000000000000..568eb8480fc3
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/qcom,pm8916-wdt.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/watchdog/qcom,pm8916-wdt.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm PM8916 watchdog timer controller
+
+maintainers:
+  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+
+allOf:
+  - $ref: watchdog.yaml#
+
+properties:
+  compatible:
+    const: qcom,pm8916-wdt
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - interrupts
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/spmi/spmi.h>
+
+    pmic@0 {
+        compatible = "qcom,pm8916", "qcom,spmi-pmic";
+        reg = <0x0 SPMI_USID>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        pon@800 {
+            compatible = "qcom,pm8916-pon";
+            reg = <0x800>;
+            mode-bootloader = <0x2>;
+            mode-recovery = <0x1>;
+
+            watchdog {
+                compatible = "qcom,pm8916-wdt";
+                interrupts = <0x0 0x8 6 IRQ_TYPE_EDGE_RISING>;
+                timeout-sec = <60>;
+            };
+        };
+    };
-- 
2.34.1

