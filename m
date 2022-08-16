Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92FD65961C9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 20:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236826AbiHPSCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 14:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236880AbiHPSCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 14:02:06 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2FF083BEF
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 11:02:03 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id e27so8824333wra.11
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 11:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=2roQgrVvYqh7lFTEG8aSvWbpT7RRQ2uvduuFxroa9Z8=;
        b=q+CNqLQv1mpCI6bE480reW6zrda/NfIHUWc08Rgt0CEmXgDeQ7SqGlfzAupdpFnXgQ
         RxjIOtrwwOnvd6adasxyvbSDr05McyNSW6u9SW346oIaJj5afSo5nEdPHNwK66HkjPIA
         LJTQWaB8JHJiVB70lEOLRb28gyWDHKyol00l9phRsq8kJmCnu9jJ+g221Pzn+oNQi4YU
         8Ef2TJ28vkVxPJU1Dr+EPlplJeJ1OQM6C5OIcgNBUAkI2cvnYBFBgrlj9xDwmwB8mRpQ
         QM8o5QP9AQ6aCt/uWagcVeXAh5KDI/PPTvPhBy2pzQD7y4+QMcJMtM0r0pV1KIqc1DzE
         ClCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=2roQgrVvYqh7lFTEG8aSvWbpT7RRQ2uvduuFxroa9Z8=;
        b=G8quaSR8YTOa7Wg4QfPQtyWa9SW2ACtQjhniShbF0MHm8waY9hVN6qK1WkIEZrGEPb
         j7C7a6Dl+QeKxzORVNTHWVoNhYYN7+lETxqNEL8PE6jFtZbPfmGHgGOkMem+AC6nPYAd
         L22fwJ58JqclG5U4OU20mlmM8eRbGiPr9aSwR/FXYqD4cfchLhlkP950jrsT1USb32M4
         sCmrb1Qa/lQ7xafuVvAItjx7zlGa/X3K/9gE35tg85KjHj8HcwGBFjTI3zQb7aJjw9V3
         SngAkhpQOufmda364VrN0SeKlKgKJVwn0uKXaVPbx/bthnYCpmYeW6BP5nUjhFy2S96e
         zTPA==
X-Gm-Message-State: ACgBeo2U7XZjOZv3Vv4blPqs9nfioAUa9YRPzuKd/BRmae2OSR3QTARn
        jir0zvkWrIySx8yuc4DBxicXvQ==
X-Google-Smtp-Source: AA6agR42QcatdSU2tDnCRs7uGfQkSo3KD4SWKOYrMts4PbhCWXqzp67qHSrcj5Dj1FVHD+jqjjXzeA==
X-Received: by 2002:adf:e74d:0:b0:225:17bd:9715 with SMTP id c13-20020adfe74d000000b0022517bd9715mr2201012wrn.602.1660672922201;
        Tue, 16 Aug 2022 11:02:02 -0700 (PDT)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id p185-20020a1c29c2000000b003a4f1385f0asm14383253wmp.24.2022.08.16.11.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 11:02:01 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        linus.walleij@linaro.org
Cc:     konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, srinivas.kandagatla@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: pinctrl: qcom: Add sm8450 lpass lpi pinctrl bindings
Date:   Tue, 16 Aug 2022 19:01:56 +0100
Message-Id: <20220816180157.6711-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220816180157.6711-1-srinivas.kandagatla@linaro.org>
References: <20220816180157.6711-1-srinivas.kandagatla@linaro.org>
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
 .../qcom,sm8450-lpass-lpi-pinctrl.yaml        | 136 ++++++++++++++++++
 1 file changed, 136 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sm8450-lpass-lpi-pinctrl.yaml

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm8450-lpass-lpi-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm8450-lpass-lpi-pinctrl.yaml
new file mode 100644
index 000000000000..3d75c87c259d
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm8450-lpass-lpi-pinctrl.yaml
@@ -0,0 +1,136 @@
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
+    $ref: "/schemas/pinctrl/pincfg-node.yaml"
+
+    properties:
+      pins:
+        description:
+          List of gpio pins affected by the properties specified in this
+          subnode.
+        items:
+          pattern: "^gpio([0-1]|[0-8]])$"
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
+    lpi_tlmm: pinctrl@33c0000 {
+        compatible = "qcom,sm8450-lpass-lpi-pinctrl";
+        reg = <0x3440000 0x20000>,
+              <0x34d0000 0x10000>;
+        clocks = <&q6afecc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+                 <&q6afecc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
+        clock-names = "core", "audio";
+        gpio-controller;
+        #gpio-cells = <2>;
+        gpio-ranges = <&lpi_tlmm 0 0 23>;
+    };
-- 
2.21.0

