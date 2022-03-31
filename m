Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AEA74EE32E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 23:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241722AbiCaVS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 17:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbiCaVSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 17:18:55 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029DB236BB8
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 14:17:07 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id c62so764395edf.5
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 14:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nGcgYb47kFSx74hsKvREuLMWHX29e0A5Arswhl9so/I=;
        b=Qpdl0PbxwpOkOlh910SskE4x/GdaL9SnivqJYn79n/FxmKqv7Qs3m2aJI1WjeytT9W
         IRgg5DNFp/nnzwnHLekDO4NesduELa8+gWKKbQfiMqgNaKmi7daEavGKioqJiPoMV5q4
         TeasXyT+DtVJ2PS3j4Vz2vJcLygBYqnwwWTyHpk5QfeBZIKblQujEim/RHFAXLFSkMQo
         +tlUwGLq1z1WU9o0XncaBWOhDT5jsJldMWUd/9Ts0xzfmRYiaZyAIbll/jov3zWmvH0e
         pW44+ulRxVV1X2mHK4ayByZ7j2ctjB1x/dMyX2wCf5LGU4Nl7EGAwS6wHDGoQ9Ymhvw8
         cWXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nGcgYb47kFSx74hsKvREuLMWHX29e0A5Arswhl9so/I=;
        b=oDJZ4gkn/0N442N81+21B08lECdOxcoBAmyyW7biVROgLMmrfZJElSM3fw6vpSgc9w
         YLat26AtuCJrJ/rGqWOgl0aPHWFEBieONz5VvcgF94CMp5Z+jnlZkwdIjIk9GojhPVXm
         QNoDJaDYSybwhFc1fC+4bmzxx/ckAZC20rft9TMExkmruCdvbV0u8Wxgd1v5K0JZfryu
         fhmaXsYi4mzXCD3dODlBJU7G31zdlR/PKeL4YUmyM5fLYdKcyQQ3NhU8O5wPc2jjP0fp
         I3jEfVraaXU7M5qJ86U12ZN+WnqqNhG+zFPT8Twm0wAvIxkuKjow99BzfnVjgdPF+IUd
         dLmw==
X-Gm-Message-State: AOAM5314LMKZ8Zg3z5rv0qrXfshiftAos+7Uu6K4JNaW/VD8jwL8XHcE
        ZMT68OliPz7Thioia39zpbxe5g==
X-Google-Smtp-Source: ABdhPJxNK4evBG/fjORvTq2QCSAzbQ+XVW5+JJOQVqLpEY5JfONx42J+VjQtSuAlKnwFD9fDJndCYw==
X-Received: by 2002:a05:6402:2747:b0:419:4817:ba22 with SMTP id z7-20020a056402274700b004194817ba22mr17922903edd.253.1648761425514;
        Thu, 31 Mar 2022 14:17:05 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id nc13-20020a1709071c0d00b006dfa376ee55sm202518ejc.131.2022.03.31.14.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 14:17:04 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 1/2] regulator: dt-bindings: maxim,max8997: correct array of voltages
Date:   Thu, 31 Mar 2022 23:16:52 +0200
Message-Id: <20220331211653.175200-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
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

uint32-array with voltages should be within one bracket pair <>, not
each number in its own <>.  Also the number of elements in the array
should be defined within "items:".

This fixes DT schema warnings like:

  maxim,max8997.example.dtb: pmic@66: max8997,pmic-buck1-dvs-voltage:
    [[1350000, 1300000, 1250000, 1200000, 1150000, 1100000, 1000000, 950000]] is too short

Fixes: 1d2104f21618 ("regulator: dt-bindings: maxim,max8997: convert to dtschema")
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Patch is independent of DTS.
---
 .../bindings/regulator/maxim,max8997.yaml     | 55 +++++++++++--------
 1 file changed, 31 insertions(+), 24 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/maxim,max8997.yaml b/Documentation/devicetree/bindings/regulator/maxim,max8997.yaml
index d5a44ca3df04..6305a9abaead 100644
--- a/Documentation/devicetree/bindings/regulator/maxim,max8997.yaml
+++ b/Documentation/devicetree/bindings/regulator/maxim,max8997.yaml
@@ -32,8 +32,9 @@ properties:
 
   max8997,pmic-buck1-dvs-voltage:
     $ref: /schemas/types.yaml#/definitions/uint32-array
-    minItems: 1
-    maxItems: 8
+    items:
+      minItems: 1
+      maxItems: 8
     description: |
       A set of 8 voltage values in micro-volt (uV) units for buck1 when
       changing voltage using GPIO DVS.
@@ -44,8 +45,9 @@ properties:
 
   max8997,pmic-buck2-dvs-voltage:
     $ref: /schemas/types.yaml#/definitions/uint32-array
-    minItems: 1
-    maxItems: 8
+    items:
+      minItems: 1
+      maxItems: 8
     description: |
       A set of 8 voltage values in micro-volt (uV) units for buck2 when
       changing voltage using GPIO DVS.
@@ -56,8 +58,9 @@ properties:
 
   max8997,pmic-buck5-dvs-voltage:
     $ref: /schemas/types.yaml#/definitions/uint32-array
-    minItems: 1
-    maxItems: 8
+    items:
+      minItems: 1
+      maxItems: 8
     description: |
       A set of 8 voltage values in micro-volt (uV) units for buck5 when
       changing voltage using GPIO DVS.
@@ -267,14 +270,17 @@ if:
 then:
   properties:
     max8997,pmic-buck1-dvs-voltage:
-      minItems: 8
-      maxItems: 8
+      items:
+        minItems: 8
+        maxItems: 8
     max8997,pmic-buck2-dvs-voltage:
-      minItems: 8
-      maxItems: 8
+      items:
+        minItems: 8
+        maxItems: 8
     max8997,pmic-buck5-dvs-voltage:
-      minItems: 8
-      maxItems: 8
+      items:
+        minItems: 8
+        maxItems: 8
 
 examples:
   - |
@@ -303,20 +309,21 @@ examples:
                                              <&gpx0 6 GPIO_ACTIVE_HIGH>,
                                              <&gpl0 0 GPIO_ACTIVE_HIGH>;
 
-            max8997,pmic-buck1-dvs-voltage = <1350000>, <1300000>,
-                                             <1250000>, <1200000>,
-                                             <1150000>, <1100000>,
-                                             <1000000>, <950000>;
+            max8997,pmic-buck1-dvs-voltage = <1350000 1300000
+                                              1250000 1200000
+                                              1150000 1100000
+                                              1000000  950000>;
+
+            max8997,pmic-buck2-dvs-voltage = <1100000 1000000
+                                               950000  900000
+                                              1100000 1000000
+                                               950000  900000>;
 
-            max8997,pmic-buck2-dvs-voltage = <1100000>, <1000000>,
-                                             <950000>,  <900000>,
-                                             <1100000>, <1000000>,
-                                             <950000>,  <900000>;
 
-            max8997,pmic-buck5-dvs-voltage = <1200000>, <1200000>,
-                                             <1200000>, <1200000>,
-                                             <1200000>, <1200000>,
-                                             <1200000>, <1200000>;
+            max8997,pmic-buck5-dvs-voltage = <1200000 1200000
+                                              1200000 1200000
+                                              1200000 1200000
+                                              1200000 1200000>;
 
             pinctrl-0 = <&max8997_irq>, <&otg_gp>, <&usb_sel>;
             pinctrl-names = "default";
-- 
2.32.0

