Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F31C45279DA
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 22:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235113AbiEOUb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 16:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbiEOUbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 16:31:23 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC532BE5;
        Sun, 15 May 2022 13:31:22 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id g6so25221459ejw.1;
        Sun, 15 May 2022 13:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GMH39Son2N3gZ9c/oeFLwOmolsOkBedh777nxOuqfek=;
        b=ICNuozQdrKs9S7QW4c7BmzeSDmB6P5eSXxchDKGIniTnOy9u6UXnhLsLw06CAeFl35
         uU4YG5BYBnA8tlQzkDNgjEu5qF1AFJj8HCdiwMzY6I5uc8cBL6JyC5jRFfRAVVjJm1Fn
         m8lK6UslYi8crDNayf8bv+RCUyk7sFme0sdXzIEvOh65pwhGcKVk6bFxHmnLtyeJzT7b
         YBd9w+9sNPXw3e47DOOwbDYGsTIgMqXkzTgvYpkfeh2S0pc3gKxKVQzRsT3TSTyZDFrg
         9OT0H+64hSrJ8iZObQ4VouvaCfXl3RWSBcYfGMQusyeLvGZbx4kLMz4yyif0tYyMg+od
         bGzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GMH39Son2N3gZ9c/oeFLwOmolsOkBedh777nxOuqfek=;
        b=fEtjlNHCfwCvSN0vTGrXK+GBKRwwkLEtoSR1b0xgjipDZp5gaTfJOkmkMgZGCx0wqv
         0PRaWSYyfD2fykBWe2n7yYzI9soM7HKcNw6qkv6GDqr2x8EWZ/u2XAEkBU+yPtGaEH3F
         kwR3hFElXBzkEiik0FUN9OOcBDMqwpz2SUdlOPUcKhNgyzM1g8Qdkg3rOn88jtH1H396
         sfl5cEUBPiVQMlNFyzp/IbQEj1s6UrLWqLbi0S+Bpq9tfqDThSHxmovCl7wHxBy8NcA5
         o6dC97A84ON0lTL6PTzTQNdMgd+WF3WLOysMmct7PFnczP2wBDSnhOKl7UUlvy1OKLZf
         y/6g==
X-Gm-Message-State: AOAM531pAHnQQMuaOC+RPO18DF+D6kEpw4cBoPeCZAml9Z+K+U/wnESB
        iNm6ge2rAw2qcM0W9ofRCh8=
X-Google-Smtp-Source: ABdhPJzwjb3a5SuYFnXIm2M/C54wSpppovcGlUDKCA+/oHrU+JHpmN1eQxv2BMUB5VucaTIsEAW8SA==
X-Received: by 2002:a17:906:5006:b0:6ce:3762:c72e with SMTP id s6-20020a170906500600b006ce3762c72emr12588246ejj.30.1652646680755;
        Sun, 15 May 2022 13:31:20 -0700 (PDT)
Received: from fedora.robimarko.hr (dh207-98-105.xnet.hr. [88.207.98.105])
        by smtp.googlemail.com with ESMTPSA id ze16-20020a170906ef9000b006f3ef214e4esm2944884ejb.180.2022.05.15.13.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 May 2022 13:31:20 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH 1/6] dt-bindings: regulator: qcom,spmi-regulator: Convert to dtschema
Date:   Sun, 15 May 2022 22:31:13 +0200
Message-Id: <20220515203118.474684-1-robimarko@gmail.com>
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
---
 .../regulator/qcom,spmi-regulator.yaml        | 176 ++++++++++++++++++
 1 file changed, 176 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.yaml

diff --git a/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.yaml
new file mode 100644
index 000000000000..f7da310f1845
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
+  - Robert Marko <robert.marko@sartura.hr>
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

