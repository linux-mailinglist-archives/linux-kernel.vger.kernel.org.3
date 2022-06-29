Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8195155FBA1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 11:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232030AbiF2JRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 05:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232448AbiF2JR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 05:17:27 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18392CDDE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 02:17:25 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id d17so15799660wrc.10
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 02:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9d56+qD56YHFFQAE+2WwcEsFKc57gJBmjSIIl+R37lQ=;
        b=lxV8eW9VPicdRuK1A8Kd7B/y7bhJ3TgYzKMeOC8FYef8Qqt1ieGWtgusL72CSC6iYm
         9RwTdG58eCR5zsPKbHDn5jqKigQTSOh8cq7sTnZYAlqpRMb9HnhLAkE1whMMT+tFixm/
         eQTaNTmM3/IsNdYX2EUlMWK0gFWv+aS0Cz0k+jAY0hzwDVBHfrnzrm3ArNuFXsqT4HLE
         L/eVLMsKecTcLpwAWcG17lV7C7gBq9s1E2Xeft6JR+8Y+tm3pHW9Nys7RvWxrbkkcyNU
         3ZeiHIvsldjryRoXq0Yz5khC+Mg2G4UeknM069sLDamFyaNlGyhDtRCgoeb7bpKaJylL
         4xPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9d56+qD56YHFFQAE+2WwcEsFKc57gJBmjSIIl+R37lQ=;
        b=xCk/7eWUmiP0pHYOt4tN+k5/zSVkvQK0tw2ckq8AuJvnSpN3zyTCd15AmH9YDgvdeE
         6Dd7hI9cNzXfn6R0+T2S5A76mYW3u3x+fOQaVHg4z5LgRieVbecVCB0CTlp8hS1x9QEM
         y9CocfVg3zmCwiXf84auaQulxpzQLtklIEuEEWsgSaBZLT4m623aVQoOwMAlJaJiG+Mh
         giZJZkREcAIZqtUcw+zSxFgAO31/wQAshlwIekNao8vLNykkeBzfdSXCVbuHLgjBiupV
         Zf+A8y28QrMnZybDTSIW5Cg21uJpf8jKeIqFW6S5xLSQ+z/fGHrCr5x4B2Y7frTSAsyr
         a6OQ==
X-Gm-Message-State: AJIora+F7C1xgrKC3W+tUPHwKHF+J/ek7ClYEWtcJVy5Ti0WCIcvE777
        7ZtTBkJCEH0B8cWpl7NLUM+DcQ==
X-Google-Smtp-Source: AGRyM1tqehhbHavpAmwF3OC2TUC2FdkUf9Z1g0NMG/efzBXL5Dqo7aiPTlaYcqdns7tuK7jnMCj4cg==
X-Received: by 2002:a05:6000:904:b0:21a:3dca:4297 with SMTP id bz4-20020a056000090400b0021a3dca4297mr2009210wrb.487.1656494244029;
        Wed, 29 Jun 2022 02:17:24 -0700 (PDT)
Received: from srini-hackbase.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id t18-20020a05600c199200b003a03a8475bfsm2896443wmq.16.2022.06.29.02.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 02:17:23 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     bjorn.andersson@linaro.org, linus.walleij@linaro.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/2] dt-bindings: pinctrl: qcom: Add sm8450 lpass lpi pinctrl bindings
Date:   Wed, 29 Jun 2022 10:17:15 +0100
Message-Id: <20220629091716.68771-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220629091716.68771-1-srinivas.kandagatla@linaro.org>
References: <20220629091716.68771-1-srinivas.kandagatla@linaro.org>
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

Add device tree binding Documentation details for Qualcomm SM8450
LPASS(Low Power Audio Sub System) LPI(Low Power Island) pinctrl driver.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../qcom,sm8450-lpass-lpi-pinctrl.yaml        | 138 ++++++++++++++++++
 1 file changed, 138 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sm8450-lpass-lpi-pinctrl.yaml

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm8450-lpass-lpi-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm8450-lpass-lpi-pinctrl.yaml
new file mode 100644
index 000000000000..b49d70b9ba9a
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm8450-lpass-lpi-pinctrl.yaml
@@ -0,0 +1,138 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/qcom,sm8450-lpass-lpi-pinctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Technologies, Inc. Low Power Audio SubSystem (LPASS)
+  Low Power Island (LPI) TLMM block
+
+maintainers:
+  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
+
+description: |
+  This binding describes the Top Level Mode Multiplexer block found in the
+  LPASS LPI IP on most Qualcomm SoCs
+
+properties:
+  compatible:
+    const: qcom,sm8450-lpass-lpi-pinctrl
+
+  reg:
+    minItems: 2
+    maxItems: 2
+
+  clocks:
+    items:
+      - description: LPASS Core voting clock
+      - description: LPASS Audio voting clock
+
+  clock-names:
+    items:
+      - const: core
+      - const: audio
+
+  gpio-controller: true
+
+  '#gpio-cells':
+    description: Specifying the pin number and flags, as defined in
+      include/dt-bindings/gpio/gpio.h
+    const: 2
+
+  gpio-ranges:
+    maxItems: 1
+
+#PIN CONFIGURATION NODES
+patternProperties:
+  '-pins$':
+    type: object
+    description:
+      Pinctrl node's client devices use subnodes for desired pin configuration.
+      Client device subnodes use below standard properties.
+    $ref: "/schemas/pinctrl/pincfg-node.yaml"
+
+    properties:
+      pins:
+        description:
+          List of gpio pins affected by the properties specified in this
+          subnode.
+        items:
+          oneOf:
+            - pattern: "^gpio([0-9]|[1-9][0-9])$"
+        minItems: 1
+        maxItems: 23
+
+      function:
+        enum: [ swr_tx_clk, swr_tx_data, swr_rx_clk, swr_rx_data,
+                dmic1_clk, dmic1_data, dmic2_clk, dmic2_data, dmic4_clk,
+                dmic4_data, i2s2_clk, i2s2_ws, dmic3_clk, dmic3_data,
+                qua_mi2s_sclk, qua_mi2s_ws, qua_mi2s_data, i2s1_clk, i2s1_ws,
+                i2s1_data, wsa_swr_clk, wsa_swr_data, wsa2_swr_clk,
+                wsa2_swr_data, i2s2_data, i2s4_ws, i2s4_clk, i2s4_data,
+                slimbus_clk, i2s3_clk, i2s3_ws, i2s3_data, slimbus_data,
+                ext_mclk1_c, ext_mclk1_b, ext_mclk1_a, ext_mclk1_d,
+                ext_mclk1_e ]
+
+        description:
+          Specify the alternative function to be configured for the specified
+          pins.
+
+      drive-strength:
+        enum: [2, 4, 6, 8, 10, 12, 14, 16]
+        default: 2
+        description:
+          Selects the drive strength for the specified pins, in mA.
+
+      slew-rate:
+        enum: [0, 1, 2, 3]
+        default: 0
+        description: |
+            0: No adjustments
+            1: Higher Slew rate (faster edges)
+            2: Lower Slew rate (slower edges)
+            3: Reserved (No adjustments)
+
+      bias-pull-down: true
+
+      bias-pull-up: true
+
+      bias-disable: true
+
+      output-high: true
+
+      output-low: true
+
+    required:
+      - pins
+      - function
+
+    additionalProperties: false
+
+allOf:
+  - $ref: "pinctrl.yaml#"
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - gpio-controller
+  - '#gpio-cells'
+  - gpio-ranges
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/sound/qcom,q6afe.h>
+    lpi_tlmm: pinctrl@3440000 {
+        compatible = "qcom,sm8450-lpass-lpi-pinctrl";
+        reg = <0x3440000 0x20000>,
+              <0x34d0000 0x10000>;
+        clocks = <&q6prmcc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+                 <&q6prmcc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
+        clock-names = "core", "audio";
+        gpio-controller;
+        #gpio-cells = <2>;
+        gpio-ranges = <&lpi_tlmm 0 0 23>;
+    };
-- 
2.25.1

