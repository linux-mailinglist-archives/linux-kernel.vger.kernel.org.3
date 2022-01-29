Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 179AF4A2AC7
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 01:54:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351916AbiA2AyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 19:54:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348632AbiA2AyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 19:54:05 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B31C061714
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 16:54:05 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id o9-20020a9d7189000000b0059ee49b4f0fso7384502otj.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 16:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yewUOj5wqot9NSfoWtOsiXnSQ4oLQ+gETxP2wF5utdI=;
        b=y+4okgZYuLlYNjEkAQ7HWXKcxFOdUJtjYzYweRL0Vc8tG5QfAvmVhPWfesawYTqD9F
         TBBpGB5jYYfgCUtydYevV1CIamMmMSBLaVK6io/W9DyyVycCUS/0BB2EjKMFKWy6khvk
         sH7ebUqAhCj3NjQNEwLgY01nv9q03fFOla2ffUb6J2+gOxjqQfsHfGo7DA7DZLAJ8iff
         foqjq+UlIBK2HoXudiaAKVXfiX3ANOI1fKMENPK13617FyLkJmsConeOsgaw0mmab0oe
         ZVMjMF1vG21GkUoUOoaUGPn/jfXOEkvIL0ZOQVqmAv//+8EhbVYYmHiFOuLiEvhUfJEV
         k9uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yewUOj5wqot9NSfoWtOsiXnSQ4oLQ+gETxP2wF5utdI=;
        b=bZzcy4AuFXPn2gJHPTgu7hrY4gKU1Fdzzgy8Fm+VTkhe00vsRdIXmhTujC7VYdqj9L
         GRBLnPwFKomZWOze8vKkCXEjWFJ/mzbmS8jxApdN+M9YCJD6Ho+SItUkfcwlej3w782K
         gTLaw0Z3/sqmvyc/WxeX8YUo0HebHeCRzbNQMaUpFKwrRPthy0KoapMUmqAOp0p2Q9sh
         nprzAb0my1aBg+YDlxvW3nfyDddfMoYz1B4DSjToC5P+NMr5pA25d7kyWDo8hAli23k7
         LtdDnJuimmo8ZLmdgJnC9LD2G0LC94sO+wi0M3UGk4tidi+3QQUBxBRmyqT9mNtnZC1J
         c36Q==
X-Gm-Message-State: AOAM5313R6rePN/9cgTV1rrrjbvRCux+Q/6aB3Hix0PRlPr/GHQplia/
        QH6QgI4nBHBd52dvG/dEkzrTuw==
X-Google-Smtp-Source: ABdhPJzq6EMZDOaUXCU4fvakck5Myb2A3TBHH9OKiwDDGj3iblrdYZLVH8WNMWyNXzEcM4Rx3AwVsQ==
X-Received: by 2002:a9d:6c54:: with SMTP id g20mr6198578otq.107.1643417644837;
        Fri, 28 Jan 2022 16:54:04 -0800 (PST)
Received: from ripper.. ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id n4sm8615612otq.63.2022.01.28.16.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 16:54:04 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Pavel Machek <pavel@ucw.cz>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Satya Priya Kakitapalli <c_skakit@qti.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Luca Weiss <luca@z3ntu.xyz>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v11 1/2] dt-bindings: leds: Add Qualcomm Light Pulse Generator binding
Date:   Fri, 28 Jan 2022 16:54:28 -0800
Message-Id: <20220129005429.754727-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Changes since v10:
- Picked up Rob and Stephen's R-b

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

