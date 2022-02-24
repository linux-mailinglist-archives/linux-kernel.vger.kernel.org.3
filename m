Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 109104C3207
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 17:51:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbiBXQtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 11:49:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbiBXQtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 11:49:08 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41EDF1A806B;
        Thu, 24 Feb 2022 08:48:38 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id bg16-20020a05600c3c9000b00380f6f473b0so175237wmb.1;
        Thu, 24 Feb 2022 08:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=5n+YmZADmI+5l9TOlH203XWY15HaqS7yg/VyfHKcfS4=;
        b=LGnHUm4FINZkUs+VFF3PSu9fi/ePC6oansgcqaK3zBZDgeE+WpQnh57XffUidLgQXS
         TlvMGVtgUNgqg0qN8vV4T6POp7uFsDvlnZVgGlMTrV7VKt2RYoEehhLZJNPBZeCxpvSV
         XkyXeabvIqlL9r+DpIIou/mckWU+idA8gS/AcTc48npGFWBJ80QnMVI/cCTTFEApjVMz
         Q+0nWrIwjy1AzaX4Asw0PsXV8zWFBE9cSrOsNWZhAVW8v2V3hk1IiW27bINqZyqxwQW4
         iBJ167IJLrbaQ6pJkM8H5CCExKvsMN0xf31I0IuBcyr8ylbVhoJrHoVJXpXHXBwirMUC
         M0bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5n+YmZADmI+5l9TOlH203XWY15HaqS7yg/VyfHKcfS4=;
        b=CDBH8guDW590aERs+cSdLSYiL0vQo0103QiwZAf7MxSEP1IALPaOVbmCP/c32uyqdC
         eQJQbT3Bf74clSTtz8ffcG21VA02cpNcj7EOM3+mBfSLZUcOQ8DTufpM052XRgHIGCl4
         AEDWX5ZMk2/95wRp0oKF2CnsjGvWOcvNMQT9oYHUjZo99bZLL6WQ3a3uhQxyH7CkOp1O
         vmGlbB/1l1kbs5rztNC4cvULaVy07g6TL2dk0T/8ulh9wR1A1lImwIgFPApFEKmYNI/T
         jX/88jgZPXKL2glr2mAJUodAzAuxy+sF0Ze/2GfaenZ+yIoX/4noa4Xig8CvwAXyTEu0
         K/Gw==
X-Gm-Message-State: AOAM5337eYJXclNw7mUGXgZIqNjXAYmsvGhdNDtLLjASZ1bwvwbVMkDP
        gwo1gSUBy2u5oZpcthmtaSU=
X-Google-Smtp-Source: ABdhPJzdBjegTwQT0bWP4O+CniG3blNwx+mjTuk+uWD7LEPKWgez4CjVKUTPUnN1IkE99VmKBjJDZw==
X-Received: by 2002:a1c:a443:0:b0:381:d21:de2e with SMTP id n64-20020a1ca443000000b003810d21de2emr3334879wme.131.1645721316658;
        Thu, 24 Feb 2022 08:48:36 -0800 (PST)
Received: from Ansuel-xps.localdomain ([5.170.140.187])
        by smtp.googlemail.com with ESMTPSA id k18sm2694095wrp.104.2022.02.24.08.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 08:48:36 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Taniya Das <tdas@codeaurora.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 01/15] dt-bindings: clock: split qcom,gcc.yaml to common and specific schema
Date:   Thu, 24 Feb 2022 17:48:17 +0100
Message-Id: <20220224164831.21475-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220224164831.21475-1-ansuelsmth@gmail.com>
References: <20220224164831.21475-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Split qcom,gcc.yaml to common and specific schema to use it as a
template for schema that needs to use the gcc bindings and require
to add additional bindings.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 .../bindings/clock/qcom,gcc-other.yaml        | 76 +++++++++++++++++++
 .../devicetree/bindings/clock/qcom,gcc.yaml   | 59 +-------------
 2 files changed, 80 insertions(+), 55 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml

diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml
new file mode 100644
index 000000000000..4e5903bcd70d
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml
@@ -0,0 +1,76 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/qcom,gcc-other.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Global Clock & Reset Controller Binding
+
+maintainers:
+  - Stephen Boyd <sboyd@kernel.org>
+  - Taniya Das <tdas@codeaurora.org>
+
+description:
+  Qualcomm global clock control module which supports the clocks, resets and
+  power domains.
+
+  See also:
+  - dt-bindings/clock/qcom,gcc-apq8084.h
+  - dt-bindings/reset/qcom,gcc-apq8084.h
+  - dt-bindings/clock/qcom,gcc-ipq4019.h
+  - dt-bindings/clock/qcom,gcc-ipq6018.h
+  - dt-bindings/reset/qcom,gcc-ipq6018.h
+  - dt-bindings/clock/qcom,gcc-ipq806x.h (qcom,gcc-ipq8064)
+  - dt-bindings/reset/qcom,gcc-ipq806x.h (qcom,gcc-ipq8064)
+  - dt-bindings/clock/qcom,gcc-msm8939.h
+  - dt-bindings/clock/qcom,gcc-msm8953.h
+  - dt-bindings/reset/qcom,gcc-msm8939.h
+  - dt-bindings/clock/qcom,gcc-msm8660.h
+  - dt-bindings/reset/qcom,gcc-msm8660.h
+  - dt-bindings/clock/qcom,gcc-msm8974.h (qcom,gcc-msm8226 and qcom,gcc-msm8974)
+  - dt-bindings/reset/qcom,gcc-msm8974.h (qcom,gcc-msm8226 and qcom,gcc-msm8974)
+  - dt-bindings/clock/qcom,gcc-mdm9607.h
+  - dt-bindings/clock/qcom,gcc-mdm9615.h
+  - dt-bindings/reset/qcom,gcc-mdm9615.h
+  - dt-bindings/clock/qcom,gcc-sdm660.h  (qcom,gcc-sdm630 and qcom,gcc-sdm660)
+
+allOf:
+  - $ref: "qcom,gcc.yaml#"
+
+properties:
+  compatible:
+    enum:
+      - qcom,gcc-apq8084
+      - qcom,gcc-ipq4019
+      - qcom,gcc-ipq6018
+      - qcom,gcc-ipq8064
+      - qcom,gcc-mdm9607
+      - qcom,gcc-msm8226
+      - qcom,gcc-msm8660
+      - qcom,gcc-msm8916
+      - qcom,gcc-msm8939
+      - qcom,gcc-msm8953
+      - qcom,gcc-msm8960
+      - qcom,gcc-msm8974
+      - qcom,gcc-msm8974pro
+      - qcom,gcc-msm8974pro-ac
+      - qcom,gcc-mdm9615
+      - qcom,gcc-sdm630
+      - qcom,gcc-sdm660
+
+required:
+  - compatible
+
+unevaluatedProperties: false
+
+examples:
+  # Example for GCC for MSM8960:
+  - |
+    clock-controller@900000 {
+      compatible = "qcom,gcc-msm8960";
+      reg = <0x900000 0x4000>;
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+      #power-domain-cells = <1>;
+    };
+...
diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc.yaml
index f66d703bd913..2ed27a2ef445 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc.yaml
@@ -4,57 +4,17 @@
 $id: http://devicetree.org/schemas/clock/qcom,gcc.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Qualcomm Global Clock & Reset Controller Binding
+title: Qualcomm Global Clock & Reset Controller Binding Common Bindings
 
 maintainers:
   - Stephen Boyd <sboyd@kernel.org>
   - Taniya Das <tdas@codeaurora.org>
 
 description: |
-  Qualcomm global clock control module which supports the clocks, resets and
-  power domains.
-
-  See also:
-  - dt-bindings/clock/qcom,gcc-apq8084.h
-  - dt-bindings/reset/qcom,gcc-apq8084.h
-  - dt-bindings/clock/qcom,gcc-ipq4019.h
-  - dt-bindings/clock/qcom,gcc-ipq6018.h
-  - dt-bindings/reset/qcom,gcc-ipq6018.h
-  - dt-bindings/clock/qcom,gcc-ipq806x.h (qcom,gcc-ipq8064)
-  - dt-bindings/reset/qcom,gcc-ipq806x.h (qcom,gcc-ipq8064)
-  - dt-bindings/clock/qcom,gcc-msm8939.h
-  - dt-bindings/clock/qcom,gcc-msm8953.h
-  - dt-bindings/reset/qcom,gcc-msm8939.h
-  - dt-bindings/clock/qcom,gcc-msm8660.h
-  - dt-bindings/reset/qcom,gcc-msm8660.h
-  - dt-bindings/clock/qcom,gcc-msm8974.h (qcom,gcc-msm8226 and qcom,gcc-msm8974)
-  - dt-bindings/reset/qcom,gcc-msm8974.h (qcom,gcc-msm8226 and qcom,gcc-msm8974)
-  - dt-bindings/clock/qcom,gcc-mdm9607.h
-  - dt-bindings/clock/qcom,gcc-mdm9615.h
-  - dt-bindings/reset/qcom,gcc-mdm9615.h
-  - dt-bindings/clock/qcom,gcc-sdm660.h  (qcom,gcc-sdm630 and qcom,gcc-sdm660)
+  Common bindings for Qualcomm global clock control module which supports
+  the clocks, resets and power domains.
 
 properties:
-  compatible:
-    enum:
-      - qcom,gcc-apq8084
-      - qcom,gcc-ipq4019
-      - qcom,gcc-ipq6018
-      - qcom,gcc-ipq8064
-      - qcom,gcc-mdm9607
-      - qcom,gcc-msm8226
-      - qcom,gcc-msm8660
-      - qcom,gcc-msm8916
-      - qcom,gcc-msm8939
-      - qcom,gcc-msm8953
-      - qcom,gcc-msm8960
-      - qcom,gcc-msm8974
-      - qcom,gcc-msm8974pro
-      - qcom,gcc-msm8974pro-ac
-      - qcom,gcc-mdm9615
-      - qcom,gcc-sdm630
-      - qcom,gcc-sdm660
-
   '#clock-cells':
     const: 1
 
@@ -72,22 +32,11 @@ properties:
       Protected clock specifier list as per common clock binding.
 
 required:
-  - compatible
   - reg
   - '#clock-cells'
   - '#reset-cells'
   - '#power-domain-cells'
 
-additionalProperties: false
+additionalProperties: true
 
-examples:
-  # Example for GCC for MSM8960:
-  - |
-    clock-controller@900000 {
-      compatible = "qcom,gcc-msm8960";
-      reg = <0x900000 0x4000>;
-      #clock-cells = <1>;
-      #reset-cells = <1>;
-      #power-domain-cells = <1>;
-    };
 ...
-- 
2.34.1

