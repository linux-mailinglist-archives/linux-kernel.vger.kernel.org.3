Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 378B74FBA75
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 13:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244148AbiDKLGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 07:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345873AbiDKLGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 07:06:08 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC26044A32
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 04:03:53 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id bv19so7048541ejb.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 04:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wRhdjOBTano8qfyZ3cVLgmW1uva76p2IaVUz5hUsIw0=;
        b=iyaGpsTO+7YaSJ7q8AxFAZbhRh+dEL4VZrMNIqHwHlye03zxGqF5EYlYkOhF6OIVul
         ws7Vj5YW2U7Ve+16y0WfhHeNuSa894wyPo+na0LECjrZNgRDY83ZMS6WOwsFmeigMZQ6
         IDWwb4Y5gA60NzEsws3v5REYhEgfBjGzWyewdMVbllDBuQfO6rCmqqzNCyxsYBpWOO7x
         Ep0xDE2DXYTjjNbGvyWmhlNhbF0MIZGUN10SeJSFArjor8epSra4/gFybPiqtqg8DFjf
         3SBfVNUMEh6BfmD2drVUYhDCAlegDkTaiezOwZEW7jPzj7qKHD6gd2gELpt2RJkleAnP
         W7LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wRhdjOBTano8qfyZ3cVLgmW1uva76p2IaVUz5hUsIw0=;
        b=3Tgbl4dRSvnR4K6ZoVCuy6eMN/IFLreLKB9N8Rqgh+s8GAL8UrD1aqSPtHRAjBHOZ6
         J04QwCp75mPgbvftY95+8rdOiHrBDF9xodyQ9WvSs6XIqlJAw6XGUJFBm1c42XO1IGjW
         eodVuaYKnKmILgSPLHUJ1M0ksuCtZGjazky/rYkbzKZ0OT8TquBqmljIqQqqxIPZI8EV
         z7l347Dx+O1ay+y1brhwB8goGZu2pN8+8sm7hI0E/JgaOnDfGjMuxgmSOQINWt3mXeQY
         DwgQVjQtLCHm5rukYtN1LDXaFvF9XPpeaUpFG3OeQJ/1slTSjNLeoCZIb5yr/Leg++xR
         k5wQ==
X-Gm-Message-State: AOAM533Yo57+IIcBpIUnu3dufZDs1mTpk/oULkCo1cK2Ej06B9En5cFa
        218XTQxW0/ofvEZhrecq3MxaOQ==
X-Google-Smtp-Source: ABdhPJz6XCxcVwXlCDjK3vWbsXd+sSH1qVgVkuqsasilyIge3sDHOmymYCSiwdgIn+n84DlLI8tg/g==
X-Received: by 2002:a17:906:2bd7:b0:6ce:698b:7531 with SMTP id n23-20020a1709062bd700b006ce698b7531mr28531552ejg.146.1649675032172;
        Mon, 11 Apr 2022 04:03:52 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id j12-20020a50e0cc000000b0041cd813ac01sm11074074edl.28.2022.04.11.04.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 04:03:51 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RFC PATCH 1/2] regulator: dt-bindings: qcom,rpmh: document supplies per variant
Date:   Mon, 11 Apr 2022 13:03:43 +0200
Message-Id: <20220411110344.231903-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220411110344.231903-1-krzysztof.kozlowski@linaro.org>
References: <20220411110344.231903-1-krzysztof.kozlowski@linaro.org>
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

The RPMH regulator binding covers several devices with different
regulator supplies, so it uses patterns matching broad range of these
supplies.  This works fine but is not specific and might miss actual
mistakes when a wrong supply property is used for given variant.

Add separate child schema which describes the supplies depending on the
compatible.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../qcom,rpmh-regulator-supplies.yaml         | 261 ++++++++++++++++++
 .../regulator/qcom,rpmh-regulator.yaml        |  19 +-
 2 files changed, 266 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator-supplies.yaml

diff --git a/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator-supplies.yaml b/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator-supplies.yaml
new file mode 100644
index 000000000000..26baa6f2edc7
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator-supplies.yaml
@@ -0,0 +1,261 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/qcom,rpmh-regulator-supplies.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Technologies, Inc. RPMh Regulators supplies
+
+maintainers:
+  - Bjorn Andersson <bjorn.andersson@linaro.org>
+  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+
+select: false
+
+patternProperties:
+  "^vdd-s[1-3]-supply$":
+    description: Input supply phandle(s) of one or more regulators.
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,pm6150-rpmh-regulators
+    then:
+      properties:
+        vdd-l2-l3-supply: true
+        vdd-l4-l7-l8-supply: true
+        vdd-l5-l16-l17-l18-l19-supply: true
+        vdd-l10-l14-l15-supply: true
+        vdd-l11-l12-l13-supply: true
+      patternProperties:
+        "^vdd-l[169]-supply$": true
+        "^vdd-s[1-5]-supply$": true
+
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,pm6150l-rpmh-regulators
+    then:
+      properties:
+        vdd-bob-supply:
+          description: BOB regulator parent supply phandle.
+        vdd-l1-l8-supply: true
+        vdd-l2-l3-supply: true
+        vdd-l4-l5-l6-supply: true
+        vdd-l7-l11-supply: true
+        vdd-l9-l10-supply: true
+      patternProperties:
+        "^vdd-s[1-3]-supply$": false
+
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,pm7325-rpmh-regulators
+    then:
+      properties:
+        vdd-l1-l4-l12-l15-supply: true
+        vdd-l2-l7-supply: true
+        vdd-l6-l9-l10-supply: true
+        vdd-l11-l17-l18-l19-supply: true
+        vdd-l13-supply: true
+        vdd-l14-l16-supply: true
+      patternProperties:
+        "^vdd-l[358]-supply$": true
+        "^vdd-s[1-8]-supply$": true
+
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,pm8005-rpmh-regulators
+    then:
+      patternProperties:
+        "^vdd-s[1-4]-supply$": true
+
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,pm8009-rpmh-regulators
+            - qcom,pm8009-1-rpmh-regulators
+    then:
+      properties:
+        vdd-l5-l6-supply: true
+      patternProperties:
+        "^vdd-l[1-47]-supply$": true
+        "^vdd-s[1-2]-supply$": true
+
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,pm8150-rpmh-regulators
+            - qcom,pmm8155au-rpmh-regulators
+    then:
+      properties:
+        vdd-l1-l8-l11-supply: true
+        vdd-l2-l10-supply: true
+        vdd-l3-l4-l5-l18-supply: true
+        vdd-l6-l9-supply: true
+        vdd-l7-l12-l14-l15-supply: true
+        vdd-l13-l16-l17-supply: true
+      patternProperties:
+        "^vdd-s([1-9]|10)-supply$": true
+
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,pm8150l-rpmh-regulators
+    then:
+      properties:
+        vdd-bob-supply:
+          description: BOB regulator parent supply phandle.
+        vdd-l1-l8-supply: true
+        vdd-l2-l3-supply: true
+        vdd-l4-l5-l6-supply: true
+        vdd-l7-l11-supply: true
+        vdd-l9-l10-supply: true
+      patternProperties:
+        "^vdd-s[1-8]-supply$": true
+
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,pm8350-rpmh-regulators
+    then:
+      properties:
+        vdd-l1-l4-supply: true
+        vdd-l2-l7-supply: true
+        vdd-l3-l5-supply: true
+        vdd-l6-l9-l10-supply: true
+        vdd-l8-supply: true
+      patternProperties:
+        "^vdd-s([1-9]|1[0-2])-supply$": true
+
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,pm8350c-rpmh-regulators
+    then:
+      properties:
+        vdd-bob-supply:
+          description: BOB regulator parent supply phandle.
+        vdd-l1-l12-supply: true
+        vdd-l2-l8-supply: true
+        vdd-l3-l4-l5-l7-l13-supply: true
+        vdd-l6-l9-l11-supply: true
+        vdd-l10-supply: true
+      patternProperties:
+        "^vdd-s([1-9]|10)-supply$": true
+
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,pm8450-rpmh-regulators
+    then:
+      patternProperties:
+        "^vdd-l[1-4]-supply$": true
+        "^vdd-s[1-6]-supply$": true
+
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,pm8998-rpmh-regulators
+    then:
+      properties:
+        vdd-l1-l27-supply: true
+        vdd-l2-l8-l17-supply: true
+        vdd-l3-l11-supply: true
+        vdd-l4-l5-supply: true
+        vdd-l6-supply: true
+        vdd-l7-l12-l14-l15-supply: true
+        vdd-l9-supply: true
+        vdd-l10-l23-l25-supply: true
+        vdd-l13-l19-l21-supply: true
+        vdd-l16-l28-supply: true
+        vdd-l18-l22-supply: true
+        vdd-l20-l24-supply: true
+        vdd-l26-supply: true
+        vin-lvs-1-2-supply: true
+      patternProperties:
+        "^vdd-s([1-9]|1[0-3])-supply$": true
+
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,pmg1110-rpmh-regulators
+    then:
+      properties:
+        vdd-s1-supply: true
+      patternProperties:
+        "^vdd-s[2-3]-supply$": false
+
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,pmi8998-rpmh-regulators
+    then:
+      properties:
+        vdd-bob-supply:
+          description: BOB regulator parent supply phandle.
+      patternProperties:
+        "^vdd-s[1-3]-supply$": false
+
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,pmr735a-rpmh-regulators
+    then:
+      properties:
+        vdd-l1-l2-supply: true
+        vdd-l3-supply: true
+        vdd-l4-supply: true
+        vdd-l5-l6-supply: true
+
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,pmx55-rpmh-regulators
+    then:
+      properties:
+        vdd-l1-l2-supply: true
+        vdd-l3-l9-supply: true
+        vdd-l4-l12-supply: true
+        vdd-l5-l6-supply: true
+        vdd-l7-l8-supply: true
+        vdd-l10-l11-l13-supply: true
+      patternProperties:
+        "^vdd-l1[4-6]-supply$": true
+        "^vdd-s[1-7]-supply$": true
+
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,pmx65-rpmh-regulators
+    then:
+      properties:
+        vdd-l2-l18-supply: true
+        vdd-l5-l6-l16-supply: true
+        vdd-l8-l9-supply: true
+        vdd-l11-l13-supply: true
+      patternProperties:
+        "^vdd-l[1347]-supply$": true
+        "^vdd-l1[0245789]-supply$": true
+        "^vdd-l2[01]-supply$": true
+        "^vdd-s[1-8]-supply$": true
+
+additionalProperties: true
diff --git a/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
index 842ccef691b8..da6cef434380 100644
--- a/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
@@ -95,35 +95,26 @@ properties:
   vdd-rgb-supply:
     description: Input supply phandle of rgb.
 
-  vin-lvs-1-2-supply:
-    description: Input supply phandle of one or more regulators.
-
-  vdd-bob-supply:
-    description: BOB regulator parent supply phandle.
-
   bob:
     type: object
     $ref: "regulator.yaml#"
     description: BOB regulator node.
 
 patternProperties:
-  "^vdd-s([0-9]+)-supply$":
-    description: Input supply phandle(s) of one or more regulators.
-
-  "^vdd-(l[0-9]+[-]){1,5}supply$":
-    description: Input supply phandle(s) of one or more regulators.
-
   "^(smps|ldo|lvs)[0-9]+$":
     type: object
     $ref: "regulator.yaml#"
     description: smps/ldo regulator nodes(s).
 
-additionalProperties: false
-
 required:
   - compatible
   - qcom,pmic-id
 
+allOf:
+  - $ref: qcom,rpmh-regulator-supplies.yaml#
+
+additionalProperties: false
+
 examples:
   - |
     #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
-- 
2.32.0

