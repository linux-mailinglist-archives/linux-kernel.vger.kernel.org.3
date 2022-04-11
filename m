Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BBA84FB6A6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 11:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344041AbiDKJCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 05:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344029AbiDKJCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 05:02:08 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC27B3ED23
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 01:59:52 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id v4so3977371edl.7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 01:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DUqShBCntoT3uLKtv7YF9v9JMeujIHoqreREvQDk5XY=;
        b=zc1xhz9AKME5urDos9TsIK2tzwn0BzMorSTnQPUj6FfKxVlF0G335aDaNAH7mL7P5M
         LjV8csQRm8S48Aa4D1Xfy56D8QAAAZ04JzJF5mp4JW8AtKjOhdpxKB9N3Vh20jE2k7v0
         2cLg7PAk+sQCMl8gRQHPvxh3UIlV/Z/Y+0A7o3yxYHtwQemgPexMJxUevbUv1ums1gjY
         Kr3yqx3az+OVKBAZfh7IkYOp3Vl3UCEt89vqleiuSKu3nTHwzW+p0ajYjBN5E+eMf+F4
         LjqRBA1DY7XYgRgqOhYGjpvRaNtqJan/W/CGDBTqvmvOQEN6Y0N4RE13haViZbugXC5F
         MNxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DUqShBCntoT3uLKtv7YF9v9JMeujIHoqreREvQDk5XY=;
        b=LYxh1mLzb911iMK+uGJCogF7VoNzPCf7doYHMenBhqOFpR9VRs8dTo3/RM19U/y4z1
         kh7WkBvUYVXpV3n62oHbXlOnAHhfbrWnloal2zWAxVOg9pC6TRCp/ccSde59PCDar//b
         6PeAcORVlez6wep6uN9ImMLgl1NRF+ZLEG27CzpdcRvhnyEw8oTM0k11Xrubq47gbewi
         qmvzwjvn12MtfGzYpdIaVvpTFHXXEYZOxKBEU91wxMYKqYxyVuKsQws4V+XjZ8uCNKdK
         Gxh+btZ8Hc5XXS05QPwrAUI+e/fmzUO5NfHYSIG2Z/DyobB/h3RQ3LFPwXtzpG0nXttf
         z6Mw==
X-Gm-Message-State: AOAM531w5i99IL8iuq0xQCa5eoGO6jJyZKq2KY7e3oi97Q2qW5KKkuOb
        BjMMueCXo6M/CZ9e9EpSQ/SuwQ==
X-Google-Smtp-Source: ABdhPJwuCTHxJSJfXKACJCmdW88h8vSTQ6VZSoSR8zJdIYaH4yMs47i/Z1PSKx8l1lM4Cnj7C9vvDA==
X-Received: by 2002:a05:6402:348b:b0:419:172c:e2aa with SMTP id v11-20020a056402348b00b00419172ce2aamr32209520edc.261.1649667590968;
        Mon, 11 Apr 2022 01:59:50 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id x17-20020a170906297100b006e49a9535f3sm11705416ejd.114.2022.04.11.01.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 01:59:50 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vamsi krishna Lanka <quic_vamslank@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 4/4] dt-bindings: soc: qcom,rpmh-rsc: convert to dtschema
Date:   Mon, 11 Apr 2022 10:59:35 +0200
Message-Id: <20220411085935.130072-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220411085935.130072-1-krzysztof.kozlowski@linaro.org>
References: <20220411085935.130072-1-krzysztof.kozlowski@linaro.org>
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

Convert the Qualcomm RPMH RSC bindings to DT Schema.

Changes against original bindings:
1. Add qcom,tcs-offset as a property instead of one of reg (not used
   that way).
2. Add limits to interrupts.
3. Add child nodes (bcm-voter, clock-controller, power-controller).
4. Extend the example with more complex one.

The device description and DTS examples were copied from existing
sources, so keep the license as GPL-2.0-only.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/interconnect/qcom,bcm-voter.yaml |   8 +-
 .../bindings/soc/qcom/qcom,rpmh-rsc.yaml      | 272 ++++++++++++++++++
 .../devicetree/bindings/soc/qcom/rpmh-rsc.txt | 137 ---------
 3 files changed, 276 insertions(+), 141 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,rpmh-rsc.yaml
 delete mode 100644 Documentation/devicetree/bindings/soc/qcom/rpmh-rsc.txt

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,bcm-voter.yaml b/Documentation/devicetree/bindings/interconnect/qcom,bcm-voter.yaml
index e23df4836c6f..eec987640b37 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,bcm-voter.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,bcm-voter.yaml
@@ -45,20 +45,20 @@ additionalProperties: false
 
 examples:
   # Example 1: apps bcm_voter on SDM845 SoC should be defined inside &apps_rsc node
-  # as defined in Documentation/devicetree/bindings/soc/qcom/rpmh-rsc.txt
+  # as defined in Documentation/devicetree/bindings/soc/qcom/qcom,rpmh-rsc.yaml
   - |
 
-    apps_bcm_voter: bcm_voter {
+    apps_bcm_voter: bcm-voter {
         compatible = "qcom,bcm-voter";
     };
 
   # Example 2: disp bcm_voter on SDM845 should be defined inside &disp_rsc node
-  # as defined in Documentation/devicetree/bindings/soc/qcom/rpmh-rsc.txt
+  # as defined in Documentation/devicetree/bindings/soc/qcom/qcom,rpmh-rsc.yaml
   - |
 
     #include <dt-bindings/interconnect/qcom,icc.h>
 
-    disp_bcm_voter: bcm_voter {
+    disp_bcm_voter: bcm-voter {
         compatible = "qcom,bcm-voter";
         qcom,tcs-wait = <QCOM_ICC_TAG_AMC>;
     };
diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,rpmh-rsc.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,rpmh-rsc.yaml
new file mode 100644
index 000000000000..f5ecf4a8c377
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,rpmh-rsc.yaml
@@ -0,0 +1,272 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/qcom/qcom,rpmh-rsc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm RPMH RSC
+
+maintainers:
+  - Bjorn Andersson <bjorn.andersson@linaro.org>
+
+description: |
+  Resource Power Manager Hardened (RPMH) is the mechanism for communicating
+  with the hardened resource accelerators on Qualcomm SoCs. Requests to the
+  resources can be written to the Trigger Command Set (TCS)  registers and
+  using a (addr, val) pair and triggered. Messages in the TCS are then sent in
+  sequence over an internal bus.
+
+  The hardware block (Direct Resource Voter or DRV) is a part of the h/w entity
+  (Resource State Coordinator a.k.a RSC) that can handle multiple sleep and
+  active/wake resource requests. Multiple such DRVs can exist in a SoC and can
+  be written to from Linux. The structure of each DRV follows the same template
+  with a few variations that are captured by the properties here.
+
+  A TCS may be triggered from Linux or triggered by the F/W after all the CPUs
+  have powered off to facilitate idle power saving. TCS could be classified as::
+    ACTIVE  - Triggered by Linux
+    SLEEP   - Triggered by F/W
+    WAKE    - Triggered by F/W
+    CONTROL - Triggered by F/W
+  See also:: <dt-bindings/soc/qcom,rpmh-rsc.h>
+
+  The order in which they are described in the DT, should match the hardware
+  configuration.
+
+  Requests can be made for the state of a resource, when the subsystem is
+  active or idle. When all subsystems like Modem, GPU, CPU are idle, the
+  resource state will be an aggregate of the sleep votes from each of those
+  subsystems. Clients may request a sleep value for their shared resources in
+  addition to the active mode requests.
+
+  Drivers that want to use the RSC to communicate with RPMH must specify their
+  bindings as child nodes of the RSC controllers they wish to communicate with.
+
+properties:
+  compatible:
+    const: qcom,rpmh-rsc
+
+  interrupts:
+    minItems: 1
+    maxItems: 4
+    description:
+      The interrupt that trips when a message complete/response is received for
+      this DRV from the accelerators.
+      Number of interrupts must match number of DRV blocks.
+
+  label:
+    description:
+      Name for the RSC. The name would be used in trace logs.
+
+  qcom,drv-id:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      The ID of the DRV in the RSC block that will be used by this controller.
+
+  qcom,tcs-config:
+    $ref: /schemas/types.yaml#/definitions/uint32-matrix
+    items:
+      - items:
+          - description: TCS type
+            enum: [ 0, 1, 2, 3 ]
+          - description: Number of TCS
+      - items:
+          - description: TCS type
+            enum: [ 0, 1, 2, 3 ]
+          - description: Number of TCS
+      - items:
+          - description: TCS type
+            enum: [ 0, 1, 2, 3]
+          - description: Numbe r of TCS
+      - items:
+          - description: TCS type
+            enum: [ 0, 1, 2, 3 ]
+          - description: Number of TCS
+    description: |
+      The tuple defining the configuration of TCS. Must have two cells which
+      describe each TCS type.  The order of the TCS must match the hardware
+      configuration.
+      Cell 1 (TCS Type):: TCS types to be specified::
+       - ACTIVE_TCS
+       - SLEEP_TCS
+       - WAKE_TCS
+       - CONTROL_TCS
+      Cell 2 (Number of TCS):: <u32>
+
+  qcom,tcs-offset:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      The offset of the TCS blocks.
+
+  reg:
+    minItems: 1
+    maxItems: 4
+
+  reg-names:
+    minItems: 1
+    items:
+      - const: drv-0
+      - const: drv-1
+      - const: drv-2
+      - const: drv-3
+
+  bcm-voter:
+    $ref: /schemas/interconnect/qcom,bcm-voter.yaml#
+
+  clock-controller:
+    $ref: /schemas/clock/qcom,rpmhcc.yaml#
+
+  power-controller:
+    $ref: /schemas/power/qcom,rpmpd.yaml#
+
+patternProperties:
+  '-regulators$':
+    $ref: /schemas/regulator/qcom,rpmh-regulator.yaml#
+
+required:
+  - compatible
+  - interrupts
+  - qcom,drv-id
+  - qcom,tcs-config
+  - qcom,tcs-offset
+  - reg
+  - reg-names
+
+additionalProperties: false
+
+examples:
+  - |
+    // For a TCS whose RSC base address is 0x179C0000 and is at a DRV id of
+    // 2, the register offsets for DRV2 start at 0D00, the register
+    // calculations are like this::
+    // DRV0: 0x179C0000
+    // DRV2: 0x179C0000 + 0x10000 = 0x179D0000
+    // DRV2: 0x179C0000 + 0x10000 * 2 = 0x179E0000
+    // TCS-OFFSET: 0xD00
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/soc/qcom,rpmh-rsc.h>
+
+    rsc@179c0000 {
+        compatible = "qcom,rpmh-rsc";
+        reg = <0x179c0000 0x10000>,
+              <0x179d0000 0x10000>,
+              <0x179e0000 0x10000>;
+        reg-names = "drv-0", "drv-1", "drv-2";
+        interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
+        label = "apps_rsc";
+        qcom,tcs-offset = <0xd00>;
+        qcom,drv-id = <2>;
+        qcom,tcs-config = <ACTIVE_TCS  2>,
+                          <SLEEP_TCS   3>,
+                          <WAKE_TCS    3>,
+                          <CONTROL_TCS 1>;
+      };
+
+  - |
+    // For a TCS whose RSC base address is 0xAF20000 and is at DRV id of 0, the
+    // register offsets for DRV0 start at 01C00, the register calculations are
+    // like this::
+    // DRV0: 0xAF20000
+    // TCS-OFFSET: 0x1C00
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/soc/qcom,rpmh-rsc.h>
+
+    rsc@af20000 {
+        compatible = "qcom,rpmh-rsc";
+        reg = <0xaf20000 0x10000>;
+        reg-names = "drv-0";
+        interrupts = <GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH>;
+        label = "disp_rsc";
+        qcom,tcs-offset = <0x1c00>;
+        qcom,drv-id = <0>;
+        qcom,tcs-config = <ACTIVE_TCS  0>,
+                          <SLEEP_TCS   1>,
+                          <WAKE_TCS    1>,
+                          <CONTROL_TCS 0>;
+    };
+
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/soc/qcom,rpmh-rsc.h>
+    #include <dt-bindings/power/qcom-rpmpd.h>
+
+    rsc@18200000 {
+        compatible = "qcom,rpmh-rsc";
+        reg = <0x18200000 0x10000>,
+              <0x18210000 0x10000>,
+              <0x18220000 0x10000>;
+        reg-names = "drv-0", "drv-1", "drv-2";
+        interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
+        label = "apps_rsc";
+        qcom,tcs-offset = <0xd00>;
+        qcom,drv-id = <2>;
+        qcom,tcs-config = <ACTIVE_TCS  2>,
+                          <SLEEP_TCS   3>,
+                          <WAKE_TCS    3>,
+                          <CONTROL_TCS 0>;
+
+        clock-controller {
+            compatible = "qcom,sm8350-rpmh-clk";
+            #clock-cells = <1>;
+            clock-names = "xo";
+            clocks = <&xo_board>;
+        };
+
+        power-controller {
+            compatible = "qcom,sm8350-rpmhpd";
+            #power-domain-cells = <1>;
+            operating-points-v2 = <&rpmhpd_opp_table>;
+
+            rpmhpd_opp_table: opp-table {
+                compatible = "operating-points-v2";
+
+                rpmhpd_opp_ret: opp1 {
+                    opp-level = <RPMH_REGULATOR_LEVEL_RETENTION>;
+                };
+
+                rpmhpd_opp_min_svs: opp2 {
+                    opp-level = <RPMH_REGULATOR_LEVEL_MIN_SVS>;
+                };
+
+                rpmhpd_opp_low_svs: opp3 {
+                    opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
+                };
+
+                rpmhpd_opp_svs: opp4 {
+                    opp-level = <RPMH_REGULATOR_LEVEL_SVS>;
+                };
+
+                rpmhpd_opp_svs_l1: opp5 {
+                    opp-level = <RPMH_REGULATOR_LEVEL_SVS_L1>;
+                };
+
+                rpmhpd_opp_nom: opp6 {
+                    opp-level = <RPMH_REGULATOR_LEVEL_NOM>;
+                };
+
+                rpmhpd_opp_nom_l1: opp7 {
+                    opp-level = <RPMH_REGULATOR_LEVEL_NOM_L1>;
+                };
+
+                rpmhpd_opp_nom_l2: opp8 {
+                    opp-level = <RPMH_REGULATOR_LEVEL_NOM_L2>;
+                };
+
+                rpmhpd_opp_turbo: opp9 {
+                    opp-level = <RPMH_REGULATOR_LEVEL_TURBO>;
+                };
+
+                rpmhpd_opp_turbo_l1: opp10 {
+                    opp-level = <RPMH_REGULATOR_LEVEL_TURBO_L1>;
+                };
+            };
+        };
+
+        bcm-voter {
+            compatible = "qcom,bcm-voter";
+        };
+    };
diff --git a/Documentation/devicetree/bindings/soc/qcom/rpmh-rsc.txt b/Documentation/devicetree/bindings/soc/qcom/rpmh-rsc.txt
deleted file mode 100644
index 9b86d1eff219..000000000000
--- a/Documentation/devicetree/bindings/soc/qcom/rpmh-rsc.txt
+++ /dev/null
@@ -1,137 +0,0 @@
-RPMH RSC:
-------------
-
-Resource Power Manager Hardened (RPMH) is the mechanism for communicating with
-the hardened resource accelerators on Qualcomm SoCs. Requests to the resources
-can be written to the Trigger Command Set (TCS)  registers and using a (addr,
-val) pair and triggered. Messages in the TCS are then sent in sequence over an
-internal bus.
-
-The hardware block (Direct Resource Voter or DRV) is a part of the h/w entity
-(Resource State Coordinator a.k.a RSC) that can handle multiple sleep and
-active/wake resource requests. Multiple such DRVs can exist in a SoC and can
-be written to from Linux. The structure of each DRV follows the same template
-with a few variations that are captured by the properties here.
-
-A TCS may be triggered from Linux or triggered by the F/W after all the CPUs
-have powered off to facilitate idle power saving. TCS could be classified as -
-
-	ACTIVE  /* Triggered by Linux */
-	SLEEP   /* Triggered by F/W */
-	WAKE    /* Triggered by F/W */
-	CONTROL /* Triggered by F/W */
-
-The order in which they are described in the DT, should match the hardware
-configuration.
-
-Requests can be made for the state of a resource, when the subsystem is active
-or idle. When all subsystems like Modem, GPU, CPU are idle, the resource state
-will be an aggregate of the sleep votes from each of those subsystems. Clients
-may request a sleep value for their shared resources in addition to the active
-mode requests.
-
-Properties:
-
-- compatible:
-	Usage: required
-	Value type: <string>
-	Definition: Should be "qcom,rpmh-rsc".
-
-- reg:
-	Usage: required
-	Value type: <prop-encoded-array>
-	Definition: The first register specifies the base address of the
-		    DRV(s). The number of DRVs in the dependent on the RSC.
-	            The tcs-offset specifies the start address of the
-	            TCS in the DRVs.
-
-- reg-names:
-	Usage: required
-	Value type: <string>
-	Definition: Maps the register specified in the reg property. Must be
-	            "drv-0", "drv-1", "drv-2" etc and "tcs-offset". The
-
-- interrupts:
-	Usage: required
-	Value type: <prop-encoded-interrupt>
-	Definition: The interrupt that trips when a message complete/response
-	           is received for this DRV from the accelerators.
-
-- qcom,drv-id:
-	Usage: required
-	Value type: <u32>
-	Definition: The id of the DRV in the RSC block that will be used by
-		    this controller.
-
-- qcom,tcs-config:
-	Usage: required
-	Value type: <prop-encoded-array>
-	Definition: The tuple defining the configuration of TCS.
-	            Must have 2 cells which describe each TCS type.
-	            <type number_of_tcs>.
-	            The order of the TCS must match the hardware
-	            configuration.
-	- Cell #1 (TCS Type): TCS types to be specified -
-	            ACTIVE_TCS
-	            SLEEP_TCS
-	            WAKE_TCS
-	            CONTROL_TCS
-	- Cell #2 (Number of TCS): <u32>
-
-- label:
-	Usage: optional
-	Value type: <string>
-	Definition: Name for the RSC. The name would be used in trace logs.
-
-Drivers that want to use the RSC to communicate with RPMH must specify their
-bindings as child nodes of the RSC controllers they wish to communicate with.
-
-Example 1:
-
-For a TCS whose RSC base address is is 0x179C0000 and is at a DRV id of 2, the
-register offsets for DRV2 start at 0D00, the register calculations are like
-this -
-DRV0: 0x179C0000
-DRV2: 0x179C0000 + 0x10000 = 0x179D0000
-DRV2: 0x179C0000 + 0x10000 * 2 = 0x179E0000
-TCS-OFFSET: 0xD00
-
-	apps_rsc: rsc@179c0000 {
-		label = "apps_rsc";
-		compatible = "qcom,rpmh-rsc";
-		reg = <0x179c0000 0x10000>,
-		      <0x179d0000 0x10000>,
-		      <0x179e0000 0x10000>;
-		reg-names = "drv-0", "drv-1", "drv-2";
-		interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
-		qcom,tcs-offset = <0xd00>;
-		qcom,drv-id = <2>;
-		qcom,tcs-config = <ACTIVE_TCS  2>,
-				  <SLEEP_TCS   3>,
-				  <WAKE_TCS    3>,
-				  <CONTROL_TCS 1>;
-	};
-
-Example 2:
-
-For a TCS whose RSC base address is 0xAF20000 and is at DRV id of 0, the
-register offsets for DRV0 start at 01C00, the register calculations are like
-this -
-DRV0: 0xAF20000
-TCS-OFFSET: 0x1C00
-
-	disp_rsc: rsc@af20000 {
-		label = "disp_rsc";
-		compatible = "qcom,rpmh-rsc";
-		reg = <0xaf20000 0x10000>;
-		reg-names = "drv-0";
-		interrupts = <GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH>;
-		qcom,tcs-offset = <0x1c00>;
-		qcom,drv-id = <0>;
-		qcom,tcs-config = <ACTIVE_TCS  0>,
-				  <SLEEP_TCS   1>,
-				  <WAKE_TCS    1>,
-				  <CONTROL_TCS 0>;
-	};
-- 
2.32.0

