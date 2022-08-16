Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C352F5961E9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 20:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236898AbiHPSG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 14:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236873AbiHPSF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 14:05:57 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C995832F2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 11:05:50 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id bs25so13578668wrb.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 11:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=BY2szPU8S68ae3tLgDbLNOADXcgdGDgLTIggRQTgQOw=;
        b=MlsuJ8ntMFJRgPMWNKKz2RpkstmQwtrTWeF3Yv0wnjXSfCM3tz3fkJzXserOjmKY0D
         7+V5xMZJ8AhguoNzWfuL4blhODGxoEhw0jDd6sl9fAB/2CbuESmHl/Ry5PJ2jOJA5F7+
         DsUSa3HbOLLTzsR2ChkjinXnyLQY6KuBgoxvct4foMnnqd7zEkAM8e38NhCU+TO8rltu
         8M0CbVKfJlsAmhfmptoQ2ziuKdRdRkYTl3WgRnTvjm95L8FQZ50wVfFlnpbxOEib1F9d
         5WHLYXY4edfU+yW06jNIJ4qGaTaEyQPwhSDDBqj7UXgmUvngkDmncN66cbjg8q25BK2a
         Cijg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=BY2szPU8S68ae3tLgDbLNOADXcgdGDgLTIggRQTgQOw=;
        b=x9Q7xcpSOCQck1TkAOHsFcc8lbExlyEmZzJ6HlCHtue7+Q2PBLPPhq6agquwhET4Qq
         F4fYIOjzpxCPnbD1use+F+/6omLKYaSrBrPOA1uggxIq30CT+1i9fyrItsxzbaoSF04f
         qRCgq55Hl/EX0e1ufcBpFzLmylrgspPT2y6n5+wQEZDKRmUpgA39hnq4VBZkUQAFAwv3
         EhQ96MwBZKuZvR0soaj30kfyNFvy5eNKpBdEK4US1R/vmgFeA8Mr+uO1OXb3kSwzsyLA
         sd+pzX+lHmYtJUE7o7+M2xAcjp7CSD3FMF1Z6fOtEqM+WIwkq6VmLpNQDds6LdMHIk8V
         y3sA==
X-Gm-Message-State: ACgBeo35hXrEABISLel9TZu+s7Cd6tqC0+xW//UwwbkldOLgEgNi5cV+
        GkdsBq14JNcJ78yUXwlEcOHbkw==
X-Google-Smtp-Source: AA6agR4Yp0RKBYM8aBVScoG4j4MpBGqVnd089ON6w5QRCIzWqEVeod7EjsQrCmi+3gGI/naWpXXhWQ==
X-Received: by 2002:adf:f50b:0:b0:221:46b4:3995 with SMTP id q11-20020adff50b000000b0022146b43995mr12769026wro.74.1660673148233;
        Tue, 16 Aug 2022 11:05:48 -0700 (PDT)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id e14-20020a05600c4e4e00b003a31ca9dfb6sm17510062wmq.32.2022.08.16.11.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 11:05:47 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        linus.walleij@linaro.org
Cc:     konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, srinivas.kandagatla@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: pinctrl: qcom: Add sc8280xp lpass lpi pinctrl bindings
Date:   Tue, 16 Aug 2022 19:05:37 +0100
Message-Id: <20220816180538.9039-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220816180538.9039-1-srinivas.kandagatla@linaro.org>
References: <20220816180538.9039-1-srinivas.kandagatla@linaro.org>
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

Add device tree binding Documentation details for Qualcomm SC8280XP
LPASS(Low Power Audio Sub System) LPI(Low Power Island) pinctrl driver.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../qcom,sc8280xp-lpass-lpi-pinctrl.yaml      | 134 ++++++++++++++++++
 1 file changed, 134 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-lpass-lpi-pinctrl.yaml

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-lpass-lpi-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-lpass-lpi-pinctrl.yaml
new file mode 100644
index 000000000000..04a4cc8a7e99
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-lpass-lpi-pinctrl.yaml
@@ -0,0 +1,134 @@
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
+                wsa2_swr_data, i2s2_data, i2s3_clk, i2s3_ws, i2s3_data,
+                ext_mclk1_c, ext_mclk1_b, ext_mclk1_a ]
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

