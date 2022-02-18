Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 325754BBF7B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 19:29:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239239AbiBRS3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 13:29:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239224AbiBRS32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 13:29:28 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2510998F6D
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 10:29:11 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id y7so3994279oih.5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 10:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cFSq9u4vD4UcKyJIIrFupSdAy07113Uhr4g6Ew3+KZg=;
        b=FSc5Pv2P+ySfnR7n+Ln1v2i0xuZ5WpguCxqWsQYjEnrxIJFV/z4tRvEe2mCmzPGTks
         LFKm6xqBJbPmkB2A4lzQ2Hbgxhi56UyA90PlILf65z8N9P5Diea6xljQYjxa62O7UfGT
         oHUei0ETX5Ttc2N9Y60F1Wsoa4Szg9+f99tti1oKev6q7IhPBmCYds5wESLrQuc+/eTT
         ZJjrZII0c2sOVBaI+8Qi2gLViMHek5NyCFQzbzHve40/M3z6IpDbhiJnXSPY3xg1fUdR
         06qp37X0UiZBpXqcPxAg7hWiuohuRnCmNnWebB3nbUS+PC9S+UFiBrG5F76+pTWvV/Hr
         0B5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cFSq9u4vD4UcKyJIIrFupSdAy07113Uhr4g6Ew3+KZg=;
        b=c9ktrnD2eHdTMtR6tdF6i2Yp2uqWqAs842deNvh7l/o6mkJyBlheWsL6FfAgloPtL7
         h/TM8z3f0eNL86sO0pYMTtrW2VzNFV8T8CFkgvIUgvHtNEDvjGisYp4uDfV8JbUW6XyT
         q922zPclWBB4kQ+l7CAJxOvZCoxTUCHXoMuruQ8VvapgWgTM8wq1GeelRXc5+hgNyWpF
         IZsqfJEOKp4Rfik5N8CxoIM3xsJ9mJ0bLMleZwOumHUsoJeFK4ckVvSRJKS2lEe/Ak9+
         zhHb8baFQqFTIpN72r2/s+iHp8YTPGO2+GPSyvRSu1QbcV71/z0Vfd4/M+cH53u7fEx1
         XaFw==
X-Gm-Message-State: AOAM533I5g+Mi2ZyBpZScQgHvpTQcxOU/2foISXTFnX4QMNVh/easbOd
        DRydtb4JJEuNLjsE6KB2ROgQCA==
X-Google-Smtp-Source: ABdhPJzipan26q7Kr1WPJtXmIQjRduE4kKD2gVEfvqnpxsMURORRiE9THsaoHG4yUOV6QrcvLuNgkg==
X-Received: by 2002:a05:6808:1b11:b0:2d0:5d57:af3b with SMTP id bx17-20020a0568081b1100b002d05d57af3bmr3884106oib.306.1645208950441;
        Fri, 18 Feb 2022 10:29:10 -0800 (PST)
Received: from ripper.. ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id t5sm1742508otp.67.2022.02.18.10.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 10:29:09 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Pavel Machek <pavel@ucw.cz>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v13 1/2] dt-bindings: leds: Add Qualcomm Light Pulse Generator binding
Date:   Fri, 18 Feb 2022 10:31:15 -0800
Message-Id: <20220218183116.2261770-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.33.1
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

This adds the binding document describing the three hardware blocks
related to the Light Pulse Generator found in a wide range of Qualcomm
PMICs.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---

Changes since v12:
- None

 .../bindings/leds/leds-qcom-lpg.yaml          | 173 ++++++++++++++++++
 1 file changed, 173 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml

diff --git a/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml b/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
new file mode 100644
index 000000000000..336bd8e10efd
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
@@ -0,0 +1,173 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/leds-qcom-lpg.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Light Pulse Generator
+
+maintainers:
+  - Bjorn Andersson <bjorn.andersson@linaro.org>
+
+description: >
+  The Qualcomm Light Pulse Generator consists of three different hardware blocks;
+  a ramp generator with lookup table, the light pulse generator and a three
+  channel current sink. These blocks are found in a wide range of Qualcomm PMICs.
+
+properties:
+  compatible:
+    enum:
+      - qcom,pm8150b-lpg
+      - qcom,pm8150l-lpg
+      - qcom,pm8916-pwm
+      - qcom,pm8941-lpg
+      - qcom,pm8994-lpg
+      - qcom,pmc8180c-lpg
+      - qcom,pmi8994-lpg
+      - qcom,pmi8998-lpg
+
+  "#pwm-cells":
+    const: 2
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+  qcom,power-source:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      power-source used to drive the output, as defined in the datasheet.
+      Should be specified if the TRILED block is present
+    enum: [0, 1, 3]
+
+  qcom,dtest:
+    $ref: /schemas/types.yaml#/definitions/uint32-matrix
+    description: >
+      A list of integer pairs, where each pair represent the dtest line the
+      particular channel should be connected to and the flags denoting how the
+      value should be outputed, as defined in the datasheet. The number of
+      pairs should be the same as the number of channels.
+    items:
+      items:
+        - description: dtest line to attach
+        - description: flags for the attachment
+
+  multi-led:
+    type: object
+    $ref: leds-class-multicolor.yaml#
+    properties:
+      "#address-cells":
+        const: 1
+
+      "#size-cells":
+        const: 0
+
+    patternProperties:
+      "^led@[0-9a-f]$":
+        type: object
+        $ref: common.yaml#
+
+patternProperties:
+  "^led@[0-9a-f]$":
+    type: object
+    $ref: common.yaml#
+
+    properties:
+      reg: true
+
+    required:
+      - reg
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/leds/common.h>
+
+    led-controller {
+      compatible = "qcom,pmi8994-lpg";
+
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      qcom,power-source = <1>;
+
+      qcom,dtest = <0 0>,
+                   <0 0>,
+                   <0 0>,
+                   <4 1>;
+
+      led@1 {
+        reg = <1>;
+        color = <LED_COLOR_ID_GREEN>;
+        function = LED_FUNCTION_INDICATOR;
+        function-enumerator = <1>;
+      };
+
+      led@2 {
+        reg = <2>;
+        color = <LED_COLOR_ID_GREEN>;
+        function = LED_FUNCTION_INDICATOR;
+        function-enumerator = <0>;
+        default-state = "on";
+      };
+
+      led@3 {
+        reg = <3>;
+        color = <LED_COLOR_ID_GREEN>;
+        function = LED_FUNCTION_INDICATOR;
+        function-enumerator = <2>;
+      };
+
+      led@4 {
+        reg = <4>;
+        color = <LED_COLOR_ID_GREEN>;
+        function = LED_FUNCTION_INDICATOR;
+        function-enumerator = <3>;
+      };
+    };
+  - |
+    #include <dt-bindings/leds/common.h>
+
+    led-controller {
+      compatible = "qcom,pmi8994-lpg";
+
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      qcom,power-source = <1>;
+
+      multi-led {
+        color = <LED_COLOR_ID_RGB>;
+        function = LED_FUNCTION_STATUS;
+
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        led@1 {
+          reg = <1>;
+          color = <LED_COLOR_ID_RED>;
+        };
+
+        led@2 {
+          reg = <2>;
+          color = <LED_COLOR_ID_GREEN>;
+        };
+
+        led@3 {
+          reg = <3>;
+          color = <LED_COLOR_ID_BLUE>;
+        };
+      };
+    };
+  - |
+    pwm-controller {
+      compatible = "qcom,pm8916-pwm";
+      #pwm-cells = <2>;
+    };
+...
-- 
2.33.1

