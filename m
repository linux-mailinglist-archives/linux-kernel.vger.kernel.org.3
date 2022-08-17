Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 689D4596DB9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 13:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238617AbiHQLip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 07:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235718AbiHQLik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 07:38:40 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC5D4BA45
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 04:38:38 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id f8so2189665wru.13
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 04:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=AkV027oQRU5HguOlfIJw4T8snOwpws3kkSRECnams/I=;
        b=zNr3GKjbpA0OH81XXOlbqVVsy+1EtoFj2uSmXwggs0wVZW3OtlxUVDAEcDex0UNYPc
         rAzeEDTItGvd1+ZSJAOCLYtNLPXXvu3cd7lVPddBZMDN3On9q06vGHl1gH/lwS/5IP8C
         Bhu+gUAuAtuL6gfBcM4hmEnORRxCkhNPpVZJCavk0qa85XE3DziYSFWp9toBZBr+OYaf
         vN0uosMqRw8962npXSHET5zds46jZxUMsMR41KO2v+ZtMRuvOZwgsH3uQJ13Fvl7Bft6
         Gh9tKpS0K/rL+kl7ouJ1IWifZ9e1w/pxqomsFfCpgyJfHGxhJn9UOSzkn7RHYFxBnt9q
         LWwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=AkV027oQRU5HguOlfIJw4T8snOwpws3kkSRECnams/I=;
        b=3Fq4nzoVdWaY421H8Zx89Of1Fx9/PMNLyeoTL3K0jxIFMMzKiq/6NirtjgOGf+uQtq
         ZBg1N+EFycmMJl5BfMe7D9m+lCrN7EJcJhzFeLnuwZ8uC+Ey1Zrfjw89TdXQunx7j81c
         fOj/6nqtnHNwY8bvSaQmleRcAv8PH1+/VMUUex3sbUcDb9r8PpvO5fFn3AYsDYAgwCk0
         IUQcZxaN/UrjgHjkrLRTrP/AghVgVEsNkwHTnGksIYcJR241ZTh7f5uJ09mv6O7keku3
         LHJxa/n/SSINX22hiu5hAjuoFWbwWLTY2OgKBSYRDXqkExY84p9eIgnzeKL6r2/lsA6I
         rP1g==
X-Gm-Message-State: ACgBeo0Idq18zVtXvi8EJk4Qt/TEEaRk1rT2PXvwzqVNBjLBUq/YV8FW
        eFHIvoZYKNC7ofI3E3twZcDgAw==
X-Google-Smtp-Source: AA6agR6NUZWKOniHasBwCkWp30q2Tz8Bubiykw91ylJSnEySzS2vlYws1OUdpa5S3YXDSC87qI+ftA==
X-Received: by 2002:adf:f208:0:b0:225:25e6:c964 with SMTP id p8-20020adff208000000b0022525e6c964mr1273672wro.531.1660736317798;
        Wed, 17 Aug 2022 04:38:37 -0700 (PDT)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id a21-20020a05600c349500b003a60edc3a44sm2222695wmq.5.2022.08.17.04.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 04:38:37 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        linus.walleij@linaro.org
Cc:     konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, srinivas.kandagatla@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] dt-bindings: pinctrl: qcom: Add sm8450 lpass lpi pinctrl bindings
Date:   Wed, 17 Aug 2022 12:38:32 +0100
Message-Id: <20220817113833.9625-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220817113833.9625-1-srinivas.kandagatla@linaro.org>
References: <20220817113833.9625-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree binding Documentation details for Qualcomm SM8450
LPASS(Low Power Audio Sub System) LPI(Low Power Island) pinctrl driver.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../qcom,sm8450-lpass-lpi-pinctrl.yaml        | 135 ++++++++++++++++++
 1 file changed, 135 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sm8450-lpass-lpi-pinctrl.yaml

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm8450-lpass-lpi-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm8450-lpass-lpi-pinctrl.yaml
new file mode 100644
index 000000000000..3694795ec793
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm8450-lpass-lpi-pinctrl.yaml
@@ -0,0 +1,135 @@
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
+    $ref: /schemas/pinctrl/pincfg-node.yaml
+
+    properties:
+      pins:
+        description:
+          List of gpio pins affected by the properties specified in this
+          subnode.
+        items:
+          pattern: "^gpio([0-9]|[1-2][0-9]])$"
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
+    pinctrl@3440000 {
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

