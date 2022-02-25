Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7C914C3DE4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 06:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237539AbiBYFbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 00:31:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237522AbiBYFbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 00:31:31 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6333925D6CB
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 21:31:00 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id g6-20020a9d6486000000b005acf9a0b644so2915177otl.12
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 21:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HRtPNSZKQI7bpMca2A9QDVsOc/ZETx07EAg1FIwVxRw=;
        b=ey1AszojHGdk6ElmDks4JQxAmGWpwbsn1snjMYN2uIlr31hNGL9IPcMgzwrhn8e+lM
         YB/KpoLDA/V5rftxgyFs/Vjl7rwz4rHQLN10i6aNTTfILknRP/XbIrIxCqtDp+PAfPH8
         SGWy5Hkdp0T3Wc9aSLsy9P0RLwghUc0AxjQU494QJUpE8Sj86nso6vumTNmWeEgA3aLV
         3NDTN1aRlIbbZCLGnP77xZxH7k2m27/4+SuL3rX0EnzCbgOMcKFG+5hG1lAsgiXEDmsH
         nn37zuCYbkBKl2hnmQ1yVk+8+taasBOaUDPUF31W5oDHJ1F9x0ZleouXOpJ2jXbcPl72
         1wPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HRtPNSZKQI7bpMca2A9QDVsOc/ZETx07EAg1FIwVxRw=;
        b=zhXQVBFAvYQjXQbSSq7jlM3MYHZ695Yz6Z5HG4CI1Lc/yhOfBPqozyiJ66IscGa79r
         Bx9cTr2P1yCAryLMjuL5fFtbH5mirAq86DGD5jX+aI3crpSwi4WC6GgFgW8gh/DJL+mm
         SatTsQvZTHJidepHD8mf/V4/3q70Jnr6zlVXYhu+bKf+buTy0dY9AZXjD6ruEkNGNMFp
         FhQSnPaq3R6ko5EPAlvUpSx6SYdp7USXyg7gFI12rjt7GjWfxk6rDzvUxQQKPd1ZSLyL
         hPC2hxAXIdFVI6tMVLpLzRAbKrCvGnKYA8f+lBBVlpLavhjak32uP8rm26raP7i+1kF1
         Zq5g==
X-Gm-Message-State: AOAM532AJ9LF/8TYNTGE1nrgtKnvhrpf49n7Ci8t812Bs2EFcxLASQf3
        yBWj67erlDIk46k42B6aD8V3cQ==
X-Google-Smtp-Source: ABdhPJx7KHcnf0maHZp12bzMaaJY6bovqf/blb/HwIu60QT2OTlaX5YXyn9G2uSqbkDsjJPVBX8hCA==
X-Received: by 2002:a05:6830:b92:b0:5af:44c9:f115 with SMTP id a18-20020a0568300b9200b005af44c9f115mr2265651otv.24.1645767059704;
        Thu, 24 Feb 2022 21:30:59 -0800 (PST)
Received: from ripper.. ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id hj9-20020a056870c90900b000d3d15ecd18sm830823oab.8.2022.02.24.21.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 21:30:59 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: pinctrl: qcom: Add sc8280xp TLMM binding
Date:   Thu, 24 Feb 2022 21:32:56 -0800
Message-Id: <20220225053257.2479279-1-bjorn.andersson@linaro.org>
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
 .../pinctrl/qcom,sc8280xp-pinctrl.yaml        | 153 ++++++++++++++++++
 1 file changed, 153 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-pinctrl.yaml

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-pinctrl.yaml
new file mode 100644
index 000000000000..4199dfe992e0
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-pinctrl.yaml
@@ -0,0 +1,153 @@
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
+  - $ref: "pinctrl.yaml#"
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
+  - reg-names
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
+        pinctrl@3100000 {
+                compatible = "qcom,sc8280x-tlmm";
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

