Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39B49596DB5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 13:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235384AbiHQLiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 07:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234388AbiHQLiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 07:38:09 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E81EC324
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 04:38:05 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id h24so1808775wrb.8
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 04:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=8zWBbtZuu5qs3FU2M/zAVv2jUFXvo+MlpqCTMPSCLG8=;
        b=tPNE//mhA215YUqVD7L8gVQjfmcIuX2GctBypU/jpvChs+xX/gU0mdEsru/PXxN1bP
         K3JzmBaLLAOHsRoosvIm0SOIYTpxN62AqAeDcWKPVdWLttR6vuDo1cKJ5DTOQ2YHQB2l
         YoGjXPK1uInjuSg4hKCcHbrN0dTYSE4TbG1RdSaPFkvHbk4sUziXwfsXNp9+RWoWu9TJ
         FZimvgJSw9DybTWpXG/BBTSug3CMt+sPnB4V19gp0551/AoT9vCkAlWC0O+g7q7hA0xc
         vRKRuMohh3vK6z1Z3l4vJCDOLI3TBnnabs9neqTPa07l0W3cdIGi8D1Lm/82+96rPXTk
         smQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=8zWBbtZuu5qs3FU2M/zAVv2jUFXvo+MlpqCTMPSCLG8=;
        b=kLCN9WriH34NhLS/NqAek6YUUwR/C1vp+fqshI4HiFuCEbsuk5iQFuYNaVLoBoTNJF
         WEqlVNzWUaAFo5Nm0mHNZAkyyQeyMseIwhOs42953e7AvfheHgOX7ijZsIDDeYSSwHOJ
         BmkY2qnQT9l8JtmhOuCO9VIguGaknZY9S3bZHM4vTI2t6r0/KpTCPkhrFZUjFz6TJlpj
         sqKVDCdoSA4ANfKE2LruMSGn3RVUyPYbuQwYoImEsfM0BUPdYjgsqM9S/YM2RYpj5t/V
         4V318Ku0BpNwtgLTcQE3/tMlx9FP+MJwb9NR39VhizD38EkQd0h8cReZNHlZxaIJX4S/
         aUxA==
X-Gm-Message-State: ACgBeo3qAc+cGDnEQZLP4AJkw2NN6iWnbGmH3Q4UZnpKp+3nXWB6uJhL
        HtUKMTTJ5SSy1gv4j7291Pz//w==
X-Google-Smtp-Source: AA6agR65fr5JShdcHaKyhhDSx7UlH7X+h5T11kgC+s72BSY/Sayyae9ECz/2ks6JfYPyVPKz1HJvZA==
X-Received: by 2002:a5d:5408:0:b0:220:63d5:d9f3 with SMTP id g8-20020a5d5408000000b0022063d5d9f3mr13958498wrv.249.1660736284365;
        Wed, 17 Aug 2022 04:38:04 -0700 (PDT)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id m30-20020a05600c3b1e00b003a5ad7f6de2sm2004220wms.15.2022.08.17.04.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 04:38:03 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        linus.walleij@linaro.org
Cc:     konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, srinivas.kandagatla@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: pinctrl: qcom: Add sc8280xp lpass lpi pinctrl bindings
Date:   Wed, 17 Aug 2022 12:37:46 +0100
Message-Id: <20220817113747.9111-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220817113747.9111-1-srinivas.kandagatla@linaro.org>
References: <20220817113747.9111-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree binding Documentation details for Qualcomm SC8280XP
LPASS(Low Power Audio Sub System) LPI(Low Power Island) pinctrl driver.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../qcom,sc8280xp-lpass-lpi-pinctrl.yaml      | 133 ++++++++++++++++++
 1 file changed, 133 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-lpass-lpi-pinctrl.yaml

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-lpass-lpi-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-lpass-lpi-pinctrl.yaml
new file mode 100644
index 000000000000..1f468303bb08
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-lpass-lpi-pinctrl.yaml
@@ -0,0 +1,133 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/qcom,sc8280xp-lpass-lpi-pinctrl.yaml#
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
+    const: qcom,sc8280xp-lpass-lpi-pinctrl
+
+  reg:
+    items:
+      - description: LPASS LPI TLMM Control and Status registers
+      - description: LPASS LPI pins SLEW registers
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
+    $ref: /schemas/pinctrl/pincfg-node.yaml
+
+    properties:
+      pins:
+        description:
+          List of gpio pins affected by the properties specified in this
+          subnode.
+        items:
+          pattern: "^gpio([0-1]|1[0-8]])$"
+
+      function:
+        enum: [ swr_tx_clk, swr_tx_data, swr_rx_clk, swr_rx_data,
+                dmic1_clk, dmic1_data, dmic2_clk, dmic2_data, dmic4_clk,
+                dmic4_data, i2s2_clk, i2s2_ws, dmic3_clk, dmic3_data,
+                qua_mi2s_sclk, qua_mi2s_ws, qua_mi2s_data, i2s1_clk, i2s1_ws,
+                i2s1_data, wsa_swr_clk, wsa_swr_data, wsa2_swr_clk,
+                wsa2_swr_data, i2s2_data, i2s3_clk, i2s3_ws, i2s3_data,
+                ext_mclk1_c, ext_mclk1_b, ext_mclk1_a ]
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
+          0: No adjustments
+          1: Higher Slew rate (faster edges)
+          2: Lower Slew rate (slower edges)
+          3: Reserved (No adjustments)
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
+  - $ref: pinctrl.yaml#
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
+    pinctrl@33c0000 {
+        compatible = "qcom,sc8280xp-lpass-lpi-pinctrl";
+        reg = <0x33c0000 0x20000>,
+              <0x3550000 0x10000>;
+        clocks = <&q6afecc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+                 <&q6afecc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
+        clock-names = "core", "audio";
+        gpio-controller;
+        #gpio-cells = <2>;
+        gpio-ranges = <&lpi_tlmm 0 0 18>;
+    };
-- 
2.21.0

