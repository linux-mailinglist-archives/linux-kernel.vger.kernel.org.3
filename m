Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE3DC577119
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 21:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232040AbiGPT3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 15:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231684AbiGPT3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 15:29:14 -0400
Received: from relay07.th.seeweb.it (relay07.th.seeweb.it [5.144.164.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F4A91D0FE;
        Sat, 16 Jul 2022 12:29:13 -0700 (PDT)
Received: from localhost.localdomain (abxj77.neoplus.adsl.tpnet.pl [83.9.3.77])
        by m-r2.th.seeweb.it (Postfix) with ESMTPA id CD9333F6C1;
        Sat, 16 Jul 2022 21:29:10 +0200 (CEST)
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
To:     ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: pinctrl: Add DT schema for SM6375 TLMM
Date:   Sat, 16 Jul 2022 21:28:59 +0200
Message-Id: <20220716192900.454653-1-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the TLMM driver for SM6375.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 .../bindings/pinctrl/qcom,sm6375-tlmm.yaml    | 158 ++++++++++++++++++
 1 file changed, 158 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sm6375-tlmm.yaml

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm6375-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm6375-tlmm.yaml
new file mode 100644
index 000000000000..3908807a8339
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm6375-tlmm.yaml
@@ -0,0 +1,158 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/qcom,sm6375-tlmm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Technologies, Inc. SM6375 TLMM block
+
+maintainers:
+  - Konrad Dybcio <konrad.dybcio@somainline.org>
+
+description: |
+  This binding describes the Top Level Mode Multiplexer (TLMM) block found
+  in the SM6375 platform.
+
+allOf:
+  - $ref: "pinctrl.yaml#"
+  - $ref: /schemas/pinctrl/qcom,tlmm-common.yaml#
+
+properties:
+  compatible:
+    const: qcom,sm6375-tlmm
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
+      - $ref: "#/$defs/qcom-sm6375-tlmm-state"
+      - patternProperties:
+          ".*":
+            $ref: "#/$defs/qcom-sm6375-tlmm-state"
+
+$defs:
+  qcom-sm6375-tlmm-state:
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
+            - pattern: "^gpio([0-9]|[1-9][0-9]|1[0-4][0-9]|15[0-6])$"
+            - enum: [ ufs_reset, sdc1_clk, sdc1_cmd, sdc1_data, sdc2_clk,
+                      sdc2_cmd, sdc2_data ]
+        minItems: 1
+        maxItems: 36
+
+      function:
+        description:
+          Specify the alternative function to be configured for the specified
+          pins.
+
+        enum: [ adsp_ext, agera_pll, atest_char, atest_char0, atest_char1,
+                atest_char2, atest_char3, atest_tsens, atest_tsens2,
+                atest_usb1, atest_usb10, atest_usb11, atest_usb12,
+                atest_usb13, atest_usb2, atest_usb20, atest_usb21,
+                atest_usb22, atest_usb23, audio_ref, btfm_slimbus, cam_mclk,
+                cci_async, cci_i2c, cci_timer0, cci_timer1, cci_timer2,
+                cci_timer3, cci_timer4, cri_trng, dbg_out, ddr_bist,
+                ddr_pxi0, ddr_pxi1, ddr_pxi2, ddr_pxi3, dp_hot, edp_lcd,
+                gcc_gp1, gcc_gp2, gcc_gp3, gp_pdm0, gp_pdm1, gp_pdm2, gpio,
+                gps_tx, ibi_i3c, jitter_bist, ldo_en, ldo_update, lpass_ext,
+                m_voc, mclk, mdp_vsync, mdp_vsync0, mdp_vsync1, mdp_vsync2,
+                mdp_vsync3, mi2s_0, mi2s_1, mi2s_2, mss_lte, nav_gpio,
+                nav_pps, pa_indicator, phase_flag0, phase_flag1, phase_flag10,
+                phase_flag11, phase_flag12, phase_flag13, phase_flag14,
+                phase_flag15, phase_flag16, phase_flag17, phase_flag18,
+                phase_flag19, phase_flag2, phase_flag20, phase_flag21,
+                phase_flag22, phase_flag23, phase_flag24, phase_flag25,
+                phase_flag26, phase_flag27, phase_flag28, phase_flag29,
+                phase_flag3, phase_flag30, phase_flag31, phase_flag4,
+                phase_flag5, phase_flag6, phase_flag7, phase_flag8,
+                phase_flag9, pll_bist, pll_bypassnl, pll_clk, pll_reset,
+                prng_rosc0, prng_rosc1, prng_rosc2, prng_rosc3, qdss_cti,
+                qdss_gpio, qdss_gpio0, qdss_gpio1, qdss_gpio10, qdss_gpio11,
+                qdss_gpio12, qdss_gpio13, qdss_gpio14, qdss_gpio15,
+                qdss_gpio2, qdss_gpio3, qdss_gpio4, qdss_gpio5, qdss_gpio6,
+                qdss_gpio7, qdss_gpio8, qdss_gpio9, qlink0_enable,
+                qlink0_request, qlink0_wmss, qlink1_enable, qlink1_request,
+                qlink1_wmss, qup00, qup01, qup02, qup10, qup11_f1, qup11_f2,
+                qup12, qup13_f1, qup13_f2, qup14, sd_write, sdc1_tb, sdc2_tb,
+                sp_cmu, tgu_ch0, tgu_ch1, tgu_ch2, tgu_ch3, tsense_pwm1,
+                tsense_pwm2, uim1_clk, uim1_data, uim1_present, uim1_reset,
+                uim2_clk, uim2_data, uim2_present, uim2_reset, usb2phy_ac,
+                usb_phy, vfr_1, vsense_trigger, wlan1_adc0, wlan1_adc1,
+                wlan2_adc0, wlan2_adc1 ]
+
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
+        pinctrl@500000 {
+                compatible = "qcom,sm6375-tlmm";
+                reg = <0x00500000 0x800000>;
+                interrupts = <GIC_SPI 227 IRQ_TYPE_LEVEL_HIGH>;
+                gpio-controller;
+                #gpio-cells = <2>;
+                interrupt-controller;
+                #interrupt-cells = <2>;
+                gpio-ranges = <&tlmm 0 0 157>;
+
+                gpio-wo-subnode-state {
+                        pins = "gpio1";
+                        function = "gpio";
+                };
+
+                uart-w-subnodes-state {
+                        rx {
+                                pins = "gpio18";
+                                function = "qup13_f2";
+                                bias-pull-up;
+                        };
+
+                        tx {
+                                pins = "gpio19";
+                                function = "qup13_f2";
+                                bias-disable;
+                        };
+                };
+        };
+...
-- 
2.37.0

