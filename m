Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E06AB4FD4C2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 12:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376563AbiDLJU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 05:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377796AbiDLHxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 03:53:54 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0696550452
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 00:31:33 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id lc2so14944033ejb.12
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 00:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6uNs3W4tar45ShyEaGyA62nPzsNv7I6Ouvj5AtIv104=;
        b=m+bTbuoU4mbsu6iGtYVtZQ+TX3STbelqxM9BuRfZpNT+/rhCxWQwfrMPbRT4qYSHqP
         UHN+W9tgOjTeAiFq016gB5g9F3XIu3a0NRAdMTV9HzfqjseHkqdK6ag1Q9K95t9YJG9k
         MUe8ndPqiFOJpj7GZHKWFIVpfqYfE5GnxPuW1IbkftBkpeN15nEKbhcrH3dJnt9kyTLV
         wDeQ75QSP9xLz2XIor05Gzup49a08YL6jq5vGn0lacN4KdPFmjZfCgqo3XRyqbFkIQJ3
         S2bOq1C7/Vi/unuhT3uA2X0zNIQ4GxYsldjrVG5rvaxc7rxqoNwVbdpiu5j90sMUsNqb
         7+4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6uNs3W4tar45ShyEaGyA62nPzsNv7I6Ouvj5AtIv104=;
        b=o8SWOq2YTraPIizaCq6Sel75MfgYHnQJhn6OYCLksk0U1vJyXj+cZDu5Gjw0L//TUc
         QZbL16EKtEvpdhOrlDu3k4/W9715uATR0Rnusn9CouPTMrN87nj0Hf/dNojW0DwurW+J
         Rd/CgR2lC6JqFxxShhB1B1m0iALIIIGTU8eKGbG4mC9KwTjUSc7cSTZAyB+sC2mSP018
         T+sjkbqtY7XuFArz+NT0WdRHEnhopGcXqzcTfUUjp5kgMvLP+oqeBNIaJFKlJewzzoXh
         Y9dwlwIwN/RhvodpBbdHKyM13aZ0aSHOQEovdLIfwmMeNn7wUv4cx81l04OhFmlF2i1L
         4xOQ==
X-Gm-Message-State: AOAM531pv/LekIBQWweGUzcDnKeC3+KM7gpENnIxa3IkdkwkNSW4eVuq
        Nb6rh4YHhbIZ2X8BFuQbRrmZWA==
X-Google-Smtp-Source: ABdhPJxd3t1d2lrD24qPxgEhmyQgshOp+/0lwDPKbOKivwOzpJJDUHSbGsmWF0TkiyiEnHh3q9hrjQ==
X-Received: by 2002:a17:906:6bcd:b0:6e8:93e4:b37f with SMTP id t13-20020a1709066bcd00b006e893e4b37fmr7323098ejs.529.1649748692380;
        Tue, 12 Apr 2022 00:31:32 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id j12-20020a50e0cc000000b0041cd813ac01sm12571234edl.28.2022.04.12.00.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 00:31:32 -0700 (PDT)
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
Subject: [PATCH v2 1/2] regulator: dt-bindings: qcom,rpmh: document supplies per variant
Date:   Tue, 12 Apr 2022 09:31:22 +0200
Message-Id: <20220412073123.27229-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220412073123.27229-1-krzysztof.kozlowski@linaro.org>
References: <20220412073123.27229-1-krzysztof.kozlowski@linaro.org>
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

Describe the supplies depending on the compatible, using a defs-allOf
method.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../regulator/qcom,rpmh-regulator.yaml        | 290 +++++++++++++++++-
 1 file changed, 276 insertions(+), 14 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
index 842ccef691b8..773536fe37c7 100644
--- a/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
@@ -95,35 +95,297 @@ properties:
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
+  - $ref: "#/$defs/pm6150"
+  - $ref: "#/$defs/pm6150l"
+  - $ref: "#/$defs/pm7325"
+  - $ref: "#/$defs/pm8005"
+  - $ref: "#/$defs/pm8009"
+  - $ref: "#/$defs/pm8150"
+  - $ref: "#/$defs/pm8150l"
+  - $ref: "#/$defs/pm8350"
+  - $ref: "#/$defs/pm8350c"
+  - $ref: "#/$defs/pm8450"
+  - $ref: "#/$defs/pm8998"
+  - $ref: "#/$defs/pmg1110"
+  - $ref: "#/$defs/pmi8998"
+  - $ref: "#/$defs/pmr735a"
+  - $ref: "#/$defs/pmx55"
+  - $ref: "#/$defs/pmx65"
+
+unevaluatedProperties: false
+
+$defs:
+  pm6150:
+    if:
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
+  pm6150l:
+    if:
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
+        "^vdd-s[1-8]-supply$": true
+
+  pm7325:
+    if:
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
+  pm8005:
+    if:
+      properties:
+        compatible:
+          enum:
+            - qcom,pm8005-rpmh-regulators
+    then:
+      patternProperties:
+        "^vdd-s[1-4]-supply$": true
+
+  pm8009:
+    if:
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
+  pm8150:
+    if:
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
+  pm8150l:
+    if:
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
+  pm8350:
+    if:
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
+  pm8350c:
+    if:
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
+  pm8450:
+    if:
+      properties:
+        compatible:
+          enum:
+            - qcom,pm8450-rpmh-regulators
+    then:
+      patternProperties:
+        "^vdd-l[1-4]-supply$": true
+        "^vdd-s[1-6]-supply$": true
+
+  pm8998:
+    if:
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
+  pmg1110:
+    if:
+      properties:
+        compatible:
+          enum:
+            - qcom,pmg1110-rpmh-regulators
+    then:
+      properties:
+        vdd-s1-supply: true
+
+  pmi8998:
+    if:
+      properties:
+        compatible:
+          enum:
+            - qcom,pmi8998-rpmh-regulators
+    then:
+      properties:
+        vdd-bob-supply:
+          description: BOB regulator parent supply phandle.
+
+  pmr735a:
+    if:
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
+      patternProperties:
+        "^vdd-s[1-3]-supply$": true
+
+  pmx55:
+    if:
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
+  pmx65:
+    if:
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
 examples:
   - |
     #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
-- 
2.32.0

