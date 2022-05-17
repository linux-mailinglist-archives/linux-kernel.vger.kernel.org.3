Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACA0D52A107
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 14:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346019AbiEQMBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 08:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345696AbiEQMAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 08:00:09 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAAFA4C7B4;
        Tue, 17 May 2022 05:00:05 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id i40so7083150eda.7;
        Tue, 17 May 2022 05:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F+6WG3N5xv4+sMjttDuWqOLjGk9TC15LZ/t5RIcY7bs=;
        b=isxMZCvpM6acXCIPo/3tv8fTWgUiCcGCsv49FzHxzkmJcsoVyooXGAt1q2DiwCy0go
         8FAH7a72h34okawoFOSj2kecHBqyEpT/z8O6gTYuJf4jnykxOKYET57ugM1Thvqo4fD3
         9cF07Db7yW0Yf12lcQcl4bXqaI/5u6MBeIZwJnyU10LYMq73r/tVVaAgSzPu1aZruDe5
         4K4VI8oiGqc4J2ykv9DS22rKb21Gayr9RHwoZtSV/+5NPwE7qFSZ2SfNSMdzXbtdtF+E
         ABbamZnflpVTc3HgNXzQz4BIc9t7RUK5LE172ufEnThNhU1g7dKPNGw8IxKJpxVwiPi2
         Ud+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F+6WG3N5xv4+sMjttDuWqOLjGk9TC15LZ/t5RIcY7bs=;
        b=gxShBi6E5HrrTkTETAoN/3UIUlbuauH6M8NB1p39zeI2qDd8VSEXF7at3IX6Fx+jmn
         wm95ZiP4OS1oPfkEAZgqytPKW7MlyxIMb93yuYdah5OB8gqEtr1ewKsP16QHzO5glcr1
         TMGxQ7uk4hUGDdwhW86KCNtNCMFSYTaVa95UZs9GaeFLVgC2uo72h2KhSKmLR6R01l2Z
         r7aJfIRmfDhAsaKmw/bfWiYZOPlMFWuTtONMPyfqSahB+aZ39cmtEijnFvnDTjDZ2xog
         OaQjvTA2GzMHpqWN/oH3nyGaukJuwj5pgLHz5XWMs7SzdkV69btcCrTwoCJGVR9duYRn
         c8wQ==
X-Gm-Message-State: AOAM533EroU6+KFW4zrVnl+pZVvJsT8AnR0tqNCNac83/ovNvI9Abv6B
        BU4Qu4jjejXb+pn8PTbpNtU=
X-Google-Smtp-Source: ABdhPJwAHG/YZ/96i2OoPVe6xI9nsdtbCRhrMtNz5FwxTZgBGRO4d3NW/HYYIt+5IV/QhjZUtN8qtw==
X-Received: by 2002:a05:6402:17c1:b0:428:8016:d98d with SMTP id s1-20020a05640217c100b004288016d98dmr18608219edy.5.1652788803795;
        Tue, 17 May 2022 05:00:03 -0700 (PDT)
Received: from fedora.robimarko.hr (dh207-98-105.xnet.hr. [88.207.98.105])
        by smtp.googlemail.com with ESMTPSA id hg16-20020a1709072cd000b006f3ef214e20sm948793ejc.134.2022.05.17.05.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 05:00:03 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v2 1/6] dt-bindings: regulator: qcom,spmi-regulator: Convert to dtschema
Date:   Tue, 17 May 2022 13:59:55 +0200
Message-Id: <20220517120000.71048-1-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the bindings of Qualcomm SPMI regulators to DT schema.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
I am aware that syscon alone is not really acceptable, its converted
directly from the old text bindings.

There is also the issue of some MSM8994, MSM8996 and APQ8096 devices using
'#address-cells', '#size-cells', some even defining reg property for
regulators.

Any advice on how to solve these issues is appreciated.

Changes in v2:
* Remove the forgotten text bindings
* Move allOf after patternProperties
* Use my private email as the maintainer email
---
 .../regulator/qcom,spmi-regulator.txt         | 347 ------------------
 .../regulator/qcom,spmi-regulator.yaml        | 176 +++++++++
 2 files changed, 176 insertions(+), 347 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.yaml

diff --git a/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.txt b/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.txt
deleted file mode 100644
index c2a39b121b1b..000000000000
--- a/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.txt
+++ /dev/null
@@ -1,347 +0,0 @@
-Qualcomm SPMI Regulators
-
-- compatible:
-	Usage: required
-	Value type: <string>
-	Definition: must be one of:
-			"qcom,pm8004-regulators"
-			"qcom,pm8005-regulators"
-			"qcom,pm8226-regulators"
-			"qcom,pm8841-regulators"
-			"qcom,pm8916-regulators"
-			"qcom,pm8941-regulators"
-			"qcom,pm8950-regulators"
-			"qcom,pm8994-regulators"
-			"qcom,pmi8994-regulators"
-			"qcom,pm660-regulators"
-			"qcom,pm660l-regulators"
-			"qcom,pms405-regulators"
-
-- interrupts:
-	Usage: optional
-	Value type: <prop-encoded-array>
-	Definition: List of OCP interrupts.
-
-- interrupt-names:
-	Usage: required if 'interrupts' property present
-	Value type: <string-array>
-	Definition: List of strings defining the names of the
-		    interrupts in the 'interrupts' property 1-to-1.
-		    Supported values are "ocp-<regulator_name>", where
-		    <regulator_name> corresponds to a voltage switch
-		    type regulator.
-
-- vdd_s1-supply:
-- vdd_s2-supply:
-- vdd_s3-supply:
-- vdd_s4-supply:
-- vdd_s5-supply:
-- vdd_s6-supply:
-- vdd_s7-supply:
-- vdd_s8-supply:
-	Usage: optional (pm8841 only)
-	Value type: <phandle>
-	Definition: Reference to regulator supplying the input pin, as
-		    described in the data sheet.
-
-- vdd_s1-supply:
-- vdd_s2-supply:
-- vdd_s3-supply:
-- vdd_s4-supply:
-- vdd_l1_l3-supply:
-- vdd_l2-supply:
-- vdd_l4_l5_l6-supply:
-- vdd_l7-supply:
-- vdd_l8_l11_l14_l15_l16-supply:
-- vdd_l9_l10_l12_l13_l17_l18-supply:
-	Usage: optional (pm8916 only)
-	Value type: <phandle>
-	Definition: Reference to regulator supplying the input pin, as
-		    described in the data sheet.
-
-- vdd_s1-supply:
-- vdd_s2-supply:
-- vdd_s3-supply:
-- vdd_l1_l3-supply:
-- vdd_l2_lvs_1_2_3-supply:
-- vdd_l4_l11-supply:
-- vdd_l5_l7-supply:
-- vdd_l6_l12_l14_l15-supply:
-- vdd_l8_l16_l18_19-supply:
-- vdd_l9_l10_l17_l22-supply:
-- vdd_l13_l20_l23_l24-supply:
-- vdd_l21-supply:
-- vin_5vs-supply:
-	Usage: optional (pm8941 only)
-	Value type: <phandle>
-	Definition: Reference to regulator supplying the input pin, as
-		    described in the data sheet.
-
-- vdd_s1-supply:
-- vdd_s2-supply:
-- vdd_s3-supply:
-- vdd_s4-supply:
-- vdd_s4-supply:
-- vdd_s5-supply:
-- vdd_s6-supply:
-- vdd_l1_l19-supply:
-- vdd_l2_l23-supply:
-- vdd_l3-supply:
-- vdd_l4_l5_l6_l7_l16-supply:
-- vdd_l8_l11_l12_l17_l22-supply:
-- vdd_l9_l10_l13_l14_l15_l18-supply:
-- vdd_l20-supply:
-- vdd_l21-supply:
-	Usage: optional (pm8950 only)
-	Value type: <phandle>
-	Definition: reference to regulator supplying the input pin, as
-		    described in the data sheet
-
-- vdd_s1-supply:
-- vdd_s2-supply:
-- vdd_s3-supply:
-- vdd_s4-supply:
-- vdd_s5-supply:
-- vdd_s6-supply:
-- vdd_s7-supply:
-- vdd_s8-supply:
-- vdd_s9-supply:
-- vdd_s10-supply:
-- vdd_s11-supply:
-- vdd_s12-supply:
-- vdd_l1-supply:
-- vdd_l2_l26_l28-supply:
-- vdd_l3_l11-supply:
-- vdd_l4_l27_l31-supply:
-- vdd_l5_l7-supply:
-- vdd_l6_l12_l32-supply:
-- vdd_l8_l16_l30-supply:
-- vdd_l9_l10_l18_l22-supply:
-- vdd_l13_l19_l23_l24-supply:
-- vdd_l14_l15-supply:
-- vdd_l17_l29-supply:
-- vdd_l20_l21-supply:
-- vdd_l25-supply:
-- vdd_lvs_1_2-supply:
-	Usage: optional (pm8994 only)
-	Value type: <phandle>
-	Definition: Reference to regulator supplying the input pin, as
-		    described in the data sheet.
-
-- vdd_s1-supply:
-- vdd_s2-supply:
-- vdd_s3-supply:
-- vdd_l1-supply:
-	Usage: optional (pmi8994 only)
-	Value type: <phandle>
-	Definition: Reference to regulator supplying the input pin, as
-		    described in the data sheet.
-
-- vdd_l1_l6_l7-supply:
-- vdd_l2_l3-supply:
-- vdd_l5-supply:
-- vdd_l8_l9_l10_l11_l12_l13_l14-supply:
-- vdd_l15_l16_l17_l18_l19-supply:
-- vdd_s1-supply:
-- vdd_s2-supply:
-- vdd_s3-supply:
-- vdd_s5-supply:
-- vdd_s6-supply:
-	Usage: optional (pm660 only)
-	Value type: <phandle>
-	Definition: Reference to regulator supplying the input pin, as
-		    described in the data sheet.
-
-- vdd_l1_l9_l10-supply:
-- vdd_l2-supply:
-- vdd_l3_l5_l7_l8-supply:
-- vdd_l4_l6-supply:
-- vdd_s1-supply:
-- vdd_s2-supply:
-- vdd_s3-supply:
-- vdd_s4-supply:
-- vdd_s5-supply:
-	Usage: optional (pm660l only)
-	Value type: <phandle>
-	Definition: Reference to regulator supplying the input pin, as
-		    described in the data sheet.
-
-- vdd_l1_l2-supply:
-- vdd_l3_l8-supply:
-- vdd_l4-supply:
-- vdd_l5_l6-supply:
-- vdd_l10_l11_l12_l13-supply:
-- vdd_l7-supply:
-- vdd_l9-supply:
-- vdd_s1-supply:
-- vdd_s2-supply:
-- vdd_s3-supply:
-- vdd_s4-supply:
-- vdd_s5-supply
-	Usage: optional (pms405 only)
-	Value type: <phandle>
-	Definition: Reference to regulator supplying the input pin, as
-		    described in the data sheet.
-
-- qcom,saw-reg:
-	Usage: optional
-	Value type: <phandle>
-	Description: Reference to syscon node defining the SAW registers.
-
-
-The regulator node houses sub-nodes for each regulator within the device. Each
-sub-node is identified using the node's name, with valid values listed for each
-of the PMICs below.
-
-pm8004:
-	s2, s5
-
-pm8005:
-	s1, s2, s3, s4
-
-pm8841:
-	s1, s2, s3, s4, s5, s6, s7, s8
-
-pm8916:
-	s1, s2, s3, s4, l1, l2, l3, l4, l5, l6, l7, l8, l9, l10, l11, l12, l13,
-	l14, l15, l16, l17, l18
-
-pm8941:
-	s1, s2, s3, s4, l1, l2, l3, l4, l5, l6, l7, l8, l9, l10, l11, l12, l13,
-	l14, l15, l16, l17, l18, l19, l20, l21, l22, l23, l24, lvs1, lvs2, lvs3,
-	5vs1, 5vs2
-
-pm8994:
-	s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12, l1, l2, l3, l4, l5,
-	l6, l7, l8, l9, l10, l11, l12, l13, l14, l15, l16, l17, l18, l19, l20,
-	l21, l22, l23, l24, l25, l26, l27, l28, l29, l30, l31, l32, lvs1, lvs2
-
-pmi8994:
-	s1, s2, s3, l1
-
-The content of each sub-node is defined by the standard binding for regulators -
-see regulator.txt - with additional custom properties described below:
-
-- regulator-initial-mode:
-	Usage: optional
-	Value type: <u32>
-	Description: 2 = Set initial mode to auto mode (automatically select
-		    between HPM and LPM); not available on boost type
-		    regulators.
-
-		    1 = Set initial mode to high power mode (HPM), also referred
-		    to as NPM. HPM consumes more ground current than LPM, but
-		    it can source significantly higher load current. HPM is not
-		    available on boost type regulators. For voltage switch type
-		    regulators, HPM implies that over current protection and
-		    soft start are active all the time.
-
-		    0 = Set initial mode to low power mode (LPM).
-
-- qcom,ocp-max-retries:
-	Usage: optional
-	Value type: <u32>
-	Description: Maximum number of times to try toggling a voltage switch
-		     off and back on as a result of consecutive over current
-		     events.
-
-- qcom,ocp-retry-delay:
-	Usage: optional
-	Value type: <u32>
-	Description: Time to delay in milliseconds between each voltage switch
-		     toggle after an over current event takes place.
-
-- qcom,pin-ctrl-enable:
-	Usage: optional
-	Value type: <u32>
-	Description: Bit mask specifying which hardware pins should be used to
-		     enable the regulator, if any; supported bits are:
-			0 = ignore all hardware enable signals
-			BIT(0) = follow HW0_EN signal
-			BIT(1) = follow HW1_EN signal
-			BIT(2) = follow HW2_EN signal
-			BIT(3) = follow HW3_EN signal
-
-- qcom,pin-ctrl-hpm:
-	Usage: optional
-	Value type: <u32>
-	Description: Bit mask specifying which hardware pins should be used to
-		     force the regulator into high power mode, if any;
-		     supported bits are:
-			0 = ignore all hardware enable signals
-			BIT(0) = follow HW0_EN signal
-			BIT(1) = follow HW1_EN signal
-			BIT(2) = follow HW2_EN signal
-			BIT(3) = follow HW3_EN signal
-			BIT(4) = follow PMIC awake state
-
-- qcom,vs-soft-start-strength:
-	Usage: optional
-	Value type: <u32>
-	Description: This property sets the soft start strength for voltage
-		     switch type regulators; supported values are:
-			0 = 0.05 uA
-			1 = 0.25 uA
-			2 = 0.55 uA
-			3 = 0.75 uA
-
-- qcom,saw-slave:
-	Usage: optional
-	Value type: <boo>
-	Description: SAW controlled gang slave. Will not be configured.
-
-- qcom,saw-leader:
-	Usage: optional
-	Value type: <boo>
-	Description: SAW controlled gang leader. Will be configured as
-		     SAW regulator.
-
-Example:
-
-	regulators {
-		compatible = "qcom,pm8941-regulators";
-		vdd_l1_l3-supply = <&s1>;
-
-		s1: s1 {
-			regulator-min-microvolt = <1300000>;
-			regulator-max-microvolt = <1400000>;
-		};
-
-		...
-
-		l1: l1 {
-			regulator-min-microvolt = <1225000>;
-			regulator-max-microvolt = <1300000>;
-		};
-
-		....
-	};
-
-Example 2:
-
-	saw3: syscon@9A10000 {
-		compatible = "syscon";
-		reg = <0x9A10000 0x1000>;
-	};
-
-	...
-
-	spm-regulators {
-		compatible = "qcom,pm8994-regulators";
-		qcom,saw-reg = <&saw3>;
-		s8 {
-			qcom,saw-slave;
-		};
-		s9 {
-			qcom,saw-slave;
-		};
-		s10 {
-			qcom,saw-slave;
-		};
-		pm8994_s11_saw: s11 {
-			qcom,saw-leader;
-			regulator-always-on;
-			regulator-min-microvolt = <900000>;
-			regulator-max-microvolt = <1140000>;
-		};
-	};
diff --git a/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.yaml
new file mode 100644
index 000000000000..5c747c832529
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.yaml
@@ -0,0 +1,176 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/qcom,spmi-regulator.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm SPMI Regulators
+
+maintainers:
+  - Robert Marko <robimarko@gmail.com>
+
+properties:
+  compatible:
+    enum:
+      - qcom,pm660-regulators
+      - qcom,pm660l-regulators
+      - qcom,pm8004-regulators
+      - qcom,pm8005-regulators
+      - qcom,pm8226-regulators
+      - qcom,pm8841-regulators
+      - qcom,pm8916-regulators
+      - qcom,pm8941-regulators
+      - qcom,pm8950-regulators
+      - qcom,pm8994-regulators
+      - qcom,pmi8994-regulators
+      - qcom,pms405-regulators
+
+  qcom,saw-reg:
+    description: Reference to syscon node defining the SAW registers
+    $ref: "/schemas/types.yaml#/definitions/phandle"
+
+patternProperties:
+  ".*-supply$":
+    description: Input supply phandle(s) for this node
+    $ref: "/schemas/types.yaml#/definitions/phandle"
+
+  "^((s|l|lvs|5vs)[0-9]*)$":
+    description: List of regulators and its properties
+    $ref: regulator.yaml#
+
+    properties:
+      qcom,ocp-max-retries:
+        description:
+          Maximum number of times to try toggling a voltage switch off and
+          back on as a result of consecutive over current events
+        $ref: "/schemas/types.yaml#/definitions/uint32"
+
+      qcom,ocp-retry-delay:
+        description:
+          Time to delay in milliseconds between each voltage switch toggle
+          after an over current event takes place
+        $ref: "/schemas/types.yaml#/definitions/uint32"
+
+      qcom,pin-ctrl-enable:
+        description:
+          Bit mask specifying which hardware pins should be used to enable the
+          regulator, if any.
+          Supported bits are
+          0 = ignore all hardware enable signals
+          BIT(0) = follow HW0_EN signal
+          BIT(1) = follow HW1_EN signal
+          BIT(2) = follow HW2_EN signal
+          BIT(3) = follow HW3_EN signal
+        $ref: "/schemas/types.yaml#/definitions/uint32"
+        minimum: 0
+        maximum: 15
+
+      qcom,pin-ctrl-hpm:
+        description:
+          Bit mask specifying which hardware pins should be used to force the
+          regulator into high power mode, if any.
+          Supported bits are
+          0 = ignore all hardware enable signals
+          BIT(0) = follow HW0_EN signal
+          BIT(1) = follow HW1_EN signal
+          BIT(2) = follow HW2_EN signal
+          BIT(3) = follow HW3_EN signal
+          BIT(4) = follow PMIC awake state
+        $ref: "/schemas/types.yaml#/definitions/uint32"
+        minimum: 0
+        maximum: 31
+
+      qcom,vs-soft-start-strength:
+        description:
+          This property sets the soft start strength for voltage switch type
+          regulators.
+          Supported values are
+          0 = 0.05 uA
+          1 = 0.25 uA
+          2 = 0.55 uA
+          3 = 0.75 uA
+        $ref: "/schemas/types.yaml#/definitions/uint32"
+        minimum: 0
+        maximum: 3
+
+      qcom,saw-slave:
+        description: SAW controlled gang slave. Will not be configured.
+        type: boolean
+
+      qcom,saw-leader:
+        description:
+          SAW controlled gang leader. Will be configured as SAW regulator.
+        type: boolean
+
+      unevaluatedProperties: false
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,pm8941-regulators
+    then:
+      properties:
+        interrupts:
+          items:
+            - description: Over-current protection interrupt for 5V S1
+            - description: Over-current protection interrupt for 5V S2
+        interrupt-names:
+          items:
+            - const: ocp-5vs1
+            - const: ocp-5vs2
+
+unevaluatedProperties: false
+
+required:
+  - compatible
+
+examples:
+  - |
+    regulators {
+      compatible = "qcom,pm8941-regulators";
+      vdd_l1_l3-supply = <&s1>;
+
+      s1: s1 {
+        regulator-min-microvolt = <1300000>;
+        regulator-max-microvolt = <1400000>;
+      };
+
+      l1: l1 {
+        regulator-min-microvolt = <1225000>;
+        regulator-max-microvolt = <1300000>;
+      };
+    };
+
+  - |
+    saw3: syscon@9a10000 {
+      compatible = "syscon";
+      reg = <0x9a10000 0x1000>;
+    };
+
+    regulators {
+      compatible = "qcom,pm8994-regulators";
+      qcom,saw-reg = <&saw3>;
+
+      s8 {
+        qcom,saw-slave;
+      };
+
+      s9 {
+        qcom,saw-slave;
+      };
+
+      s10 {
+        qcom,saw-slave;
+      };
+
+      pm8994_s11_saw: s11 {
+        qcom,saw-leader;
+        regulator-always-on;
+        regulator-min-microvolt = <900000>;
+        regulator-max-microvolt = <1140000>;
+      };
+    };
+...
-- 
2.36.1

