Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3EB4D23FC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 23:11:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350498AbiCHWKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 17:10:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240380AbiCHWKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 17:10:48 -0500
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35CBE31911
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 14:09:50 -0800 (PST)
Received: by mail-oo1-xc35.google.com with SMTP id n5-20020a4a9545000000b0031d45a442feso708900ooi.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 14:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ddW2fY9LvB2Nj22VUxUaG3e+eaf3kPwjMZ+2+JZW1rk=;
        b=jCjC5sYk1VByjCwp98OgD3SvDExuzN5oAfh50l2iAOJ31vqosIicjs5JxltaheGmlL
         cFuMzPmcVLnTJAN4Z88hnIslH87qZuZFvvUd4Pa+js6EBTn+4yCmC7FQu91UgXJSXWCf
         2UQ5M45pSII8FacN1wn8W9RkUHYjo41T8Z8PXAsQHWxA8LZo2TaZv1FHr7P33vtvG1vS
         8wB1yI1LXolpdOfds9JPX/qfEkGU+DeNHpeOkePv/UkmGIWXTHOohmt+krKIrkhymPI+
         cob0nKKmAUPVLnzzf/X0J9vukEJ0nI3JjZRqiIgWAjVRhaXkkVZmfGlyY6drpAzqb/LT
         H12Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ddW2fY9LvB2Nj22VUxUaG3e+eaf3kPwjMZ+2+JZW1rk=;
        b=SHrATghyrDB1G0oH/GT8iDoxF1HJxdGTbxa3HDm9Yoj1xL/LUE4edfVJ097HGFUWek
         C7WijfPMIJGsZnw4RGj+I1tuLxMqIQfvCf8BXkLU01OxHc9WRMFpHDEY/3p6VmEgaUd6
         4Ftz7/ScAKqtIGZcnv2NRg1yocqA2VFZokxgL163Pj1+dFP5dCXYXWvbu/Ys+tZIY57e
         5bNC5UZoq2vxpn4RVKrME4o/xw7x7r1M/WhgQglwoA47xzKHQiju/svtEG0Fw1o6hlAc
         v2dNk0lBxXCKLC2XauO90DVkRh6KUpjRbUXve8Sza3yXlmAe8oBVaVenq0mH1O4g8v6y
         yd2Q==
X-Gm-Message-State: AOAM531/lR+5GZqfl37bLzFuU8FJV83KjATSZNMh01OOwrEPXkGcfpYj
        9Z0vuhuXRpYOj/nUqOUNfq2DUGMCMJy8tA==
X-Google-Smtp-Source: ABdhPJyQF+fUUCO1OmFokSVxMnTpHlK6L3MD61JBsleRWaGh1MaN6NU0T+NY74s9fC1L25JX8IBAWw==
X-Received: by 2002:a05:6870:a102:b0:d9:bcaf:7181 with SMTP id m2-20020a056870a10200b000d9bcaf7181mr3697672oae.8.1646777389536;
        Tue, 08 Mar 2022 14:09:49 -0800 (PST)
Received: from ripper.. ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id bx10-20020a0568081b0a00b002d70da1ac54sm71107oib.19.2022.03.08.14.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 14:09:48 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: pinctrl: qcom: Add sc8280xp TLMM binding
Date:   Tue,  8 Mar 2022 14:11:31 -0800
Message-Id: <20220308221132.1423218-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Qualcomm SC8280XP platform contains a single block of registers
for the TLMM block. This provides pinconf and pinmux for 228 GPIOs, 2
UFS_RESET pins and one SDC interface.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- Dropped $ref: pinctrl.yaml
- Dropped reg-names from required list
- Fixed spelling mistake in example

 .../pinctrl/qcom,sc8280xp-pinctrl.yaml        | 151 ++++++++++++++++++
 1 file changed, 151 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-pinctrl.yaml

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-pinctrl.yaml
new file mode 100644
index 000000000000..87a381c9a19d
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-pinctrl.yaml
@@ -0,0 +1,151 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/qcom,sc8280xp-pinctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Technologies, Inc. SC8280XP TLMM block
+
+maintainers:
+  - Bjorn Andersson <bjorn.andersson@linaro.org>
+
+description: |
+  This binding describes the Top Level Mode Multiplexer block found in the
+  SC8280XP platform.
+
+allOf:
+  - $ref: /schemas/pinctrl/qcom,tlmm-common.yaml#
+
+properties:
+  compatible:
+    const: qcom,sc8280xp-tlmm
+
+  reg:
+    maxItems: 1
+
+  interrupts: true
+  interrupt-controller: true
+  '#interrupt-cells': true
+  gpio-controller: true
+  gpio-reserved-ranges: true
+  '#gpio-cells': true
+  gpio-ranges: true
+  wakeup-parent: true
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+patternProperties:
+  '-state$':
+    oneOf:
+      - $ref: "#/$defs/qcom-sc8280xp-tlmm-state"
+      - patternProperties:
+          ".*":
+            $ref: "#/$defs/qcom-sc8280xp-tlmm-state"
+
+'$defs':
+  qcom-sc8280xp-tlmm-state:
+    type: object
+    description:
+      Pinctrl node's client devices use subnodes for desired pin configuration.
+      Client device subnodes use below standard properties.
+    $ref: "qcom,tlmm-common.yaml#/$defs/qcom-tlmm-state"
+
+    properties:
+      pins:
+        description:
+          List of gpio pins affected by the properties specified in this
+          subnode.
+        items:
+          oneOf:
+            - pattern: "^gpio([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-1][0-9]|22[0-7])$"
+            - enum: [ sdc2_clk, sdc2_cmd, sdc2_data, ufs_reset, ufs1_reset ]
+        minItems: 1
+        maxItems: 16
+
+      function:
+        description:
+          Specify the alternative function to be configured for the specified
+          pins.
+
+        enum: [ atest_char, atest_usb, audio_ref, cam_mclk, cci_async, cci_i2c,
+                cci_timer0, cci_timer1, cci_timer2, cci_timer3, cci_timer4,
+                cci_timer5, cci_timer6, cci_timer7, cci_timer8, cci_timer9,
+                cmu_rng, cri_trng, cri_trng0, cri_trng1, dbg_out, ddr_bist,
+                ddr_pxi0, ddr_pxi1, ddr_pxi2, ddr_pxi3, ddr_pxi4, ddr_pxi5,
+                ddr_pxi6, ddr_pxi7, dp2_hot, dp3_hot, edp0_lcd, edp1_lcd,
+                edp2_lcd, edp3_lcd, edp_hot, emac0_dll, emac0_mcg0, emac0_mcg1,
+                emac0_mcg2, emac0_mcg3, emac0_phy, emac0_ptp, emac1_dll0,
+                emac1_dll1, emac1_mcg0, emac1_mcg1, emac1_mcg2, emac1_mcg3,
+                emac1_phy, emac1_ptp, gcc_gp1, gcc_gp2, gcc_gp3, gcc_gp4,
+                gcc_gp5, gpio, hs1_mi2s, hs2_mi2s, hs3_mi2s, ibi_i3c,
+                jitter_bist, lpass_slimbus, mdp0_vsync0, mdp0_vsync1,
+                mdp0_vsync2, mdp0_vsync3, mdp0_vsync4, mdp0_vsync5,
+                mdp0_vsync6, mdp0_vsync7, mdp0_vsync8, mdp1_vsync0,
+                mdp1_vsync1, mdp1_vsync2, mdp1_vsync3, mdp1_vsync4,
+                mdp1_vsync5, mdp1_vsync6, mdp1_vsync7, mdp1_vsync8, mdp_vsync,
+                mi2s0_data0, mi2s0_data1, mi2s0_sck, mi2s0_ws, mi2s1_data0,
+                mi2s1_data1, mi2s1_sck, mi2s1_ws, mi2s2_data0, mi2s2_data1,
+                mi2s2_sck, mi2s2_ws, mi2s_mclk1, mi2s_mclk2, pcie2a_clkreq,
+                pcie2b_clkreq, pcie3a_clkreq, pcie3b_clkreq, pcie4_clkreq,
+                phase_flag, pll_bist, pll_clk, prng_rosc0, prng_rosc1,
+                prng_rosc2, prng_rosc3, qdss_cti, qdss_gpio, qspi, qspi_clk,
+                qspi_cs, qup0, qup1, qup2, qup3, qup4, qup5, qup6, qup7, qup8,
+                qup9, qup10, qup11, qup12, qup13, qup14, qup15, qup16, qup17,
+                qup18, qup19, qup20, qup21, qup22, qup23, rgmii_0, rgmii_1,
+                sd_write, sdc40, sdc42, sdc43, sdc4_clk, sdc4_cmd, tb_trig,
+                tgu, tsense_pwm1, tsense_pwm2, tsense_pwm3, tsense_pwm4,
+                usb0_dp, usb0_phy, usb0_sbrx, usb0_sbtx, usb0_usb4, usb1_dp,
+                usb1_phy, usb1_sbrx, usb1_sbtx, usb1_usb4, usb2phy_ac,
+                vsense_trigger ]
+
+      bias-disable: true
+      bias-pull-down: true
+      bias-pull-up: true
+      drive-strength: true
+      input-enable: true
+      output-high: true
+      output-low: true
+
+    required:
+      - pins
+      - function
+
+    additionalProperties: false
+
+examples:
+  - |
+        #include <dt-bindings/interrupt-controller/arm-gic.h>
+        pinctrl@f100000 {
+                compatible = "qcom,sc8280xp-tlmm";
+                reg = <0x0f100000 0x300000>;
+                interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
+                gpio-controller;
+                #gpio-cells = <2>;
+                interrupt-controller;
+                #interrupt-cells = <2>;
+                gpio-ranges = <&tlmm 0 0 230>;
+
+                gpio-wo-subnode-state {
+                        pins = "gpio1";
+                        function = "gpio";
+                };
+
+                uart-w-subnodes-state {
+                        rx {
+                                pins = "gpio4";
+                                function = "qup14";
+                                bias-pull-up;
+                        };
+
+                        tx {
+                                pins = "gpio5";
+                                function = "qup14";
+                                bias-disable;
+                        };
+                };
+        };
+...
-- 
2.33.1

