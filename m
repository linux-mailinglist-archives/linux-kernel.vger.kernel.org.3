Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5519455A028
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 20:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbiFXSAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 14:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiFXSAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 14:00:47 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF6AF4B411
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 11:00:45 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id pk21so6254464ejb.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 11:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j7f017fT0CbgT6Ci8aw2OuO3UFJyFPbQO/IY6GMSeYA=;
        b=CDCNRMmexWRmukWHBC9OocyqnUq8CgypntmZBVXkXh3gy/W8OKnV29ftiAHwOqV/NB
         5wQyLu4u8UpgPkVcMKDUZMrFr4/LihKFEIyKhJKA11NpuDdCHfQgobiknAl6GnDqQdDW
         vrq+Io9r55EltC0QFr+bzsM2xd5RxwdzAQEiNOoTSywQWNF7YcujSezxnyrrX9W7vWdk
         kgEiOIXsRHl0vGA1bofKEy2m4SCBqrBlYdKw5otz8nQXHHGy7SYWkGFpnQURhppl7Aka
         34fJgycMWefMcFkVSNpIOp+rEZAxJbi05Fbal4PdNlOzqviHqwkGvX08sB6n/mxPKNjH
         v2mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j7f017fT0CbgT6Ci8aw2OuO3UFJyFPbQO/IY6GMSeYA=;
        b=cONPI71tq9tatK6/806fWJAjGPe4CPvQN7O2/HTyTv/VjK2Nfw6Ur6n9ARVW5aIMQo
         XSx9TUoDSiCT8aWYzTQ0/U5e7pt48FvtwuXSe/eneKuXHYX/ziFhPldcX1/lAWKHq+Gt
         qR523IUBFdy2ZdcZnyMD5HPyLnyneBNijaOUPt8NxjDFfRQzaJMt06mrlA038xDxIZg7
         Ep0c8M61a3FtIPTyzkBCMFhalW15iAek9Ab/tWRQTGq5j52/IFg0eSA3XtQIUHMnOrfb
         M3HTviCgguqtbCu21o25ozsUZeSqK5iaVBpooPW1Nmoi4UNrfaYGjWQG0WilZFPnrpSR
         YPzw==
X-Gm-Message-State: AJIora+x85vMikYCrNj639/2KxdAafbTM9GPC0liHs3YQXh/u0Qy2IC5
        i8JS0IksWEL9KLHkGFPXY2ZIfg==
X-Google-Smtp-Source: AGRyM1u5ftl6Ojv4EfR8/RSYy7g7kJQWrdSW0jHz6RB3wzm1OdQVhhQQTz4KntnwNe1nrtwknHyzlg==
X-Received: by 2002:a17:907:72c9:b0:722:d5ef:6dea with SMTP id du9-20020a17090772c900b00722d5ef6deamr175628ejc.551.1656093644353;
        Fri, 24 Jun 2022 11:00:44 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id p22-20020a170906839600b00711d5bc20d5sm1420681ejx.221.2022.06.24.11.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 11:00:41 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Kumar Gala <galak@codeaurora.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v5 1/3] dt-bindings: arm: qcom: document qcom,msm-id and qcom,board-id
Date:   Fri, 24 Jun 2022 20:00:34 +0200
Message-Id: <20220624180036.102510-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220624180036.102510-1-krzysztof.kozlowski@linaro.org>
References: <20220624180036.102510-1-krzysztof.kozlowski@linaro.org>
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

The top level qcom,msm-id and qcom,board-id properties are utilized by
bootloaders on Qualcomm MSM platforms to determine which device tree
should be used and passed to the kernel.

The commit b32e592d3c28 ("devicetree: bindings: Document qcom board
compatible format") from 2015 was a consensus during discussion about
upstreaming qcom,msm-id and qcom,board-id fields.  There are however still
problems with that consensus:
1. It was reached 7 years ago but it turned out its implementation did
   not reach all possible products.

2. Initially additional tool (dtbTool) was needed for parsing these
   fields to create a QCDT image consisting of multiple DTBs, later the
   bootloaders were improved and they use these qcom,msm-id and
   qcom,board-id properties directly.

3. Extracting relevant information from the board compatible requires
   this additional tool (dtbTool), which makes the build process more
   complicated and not easily reproducible (DTBs are modified after the
   kernel build).

4. Some versions of Qualcomm bootloaders expect these properties even
   when booting with a single DTB.  The community is stuck with these
   bootloaders thus they require properties in the DTBs.

Since several upstreamed Qualcomm SoC-based boards require these
properties to properly boot and the properties are reportedly used by
bootloaders, document them.

Link: https://lore.kernel.org/r/a3c932d1-a102-ce18-deea-18cbbd05ecab@linaro.org/
Co-developed-by: Kumar Gala <galak@codeaurora.org>
Signed-off-by: Kumar Gala <galak@codeaurora.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 .../devicetree/bindings/arm/qcom.yaml         | 120 ++++++++++++++
 include/dt-bindings/arm/qcom,ids.h            | 146 ++++++++++++++++++
 2 files changed, 266 insertions(+)
 create mode 100644 include/dt-bindings/arm/qcom,ids.h

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 6c38c1387afd..ea9055d41951 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -403,6 +403,126 @@ properties:
               - qcom,sm8450-qrd
           - const: qcom,sm8450
 
+  # Board compatibles go above
+
+  qcom,msm-id:
+    $ref: /schemas/types.yaml#/definitions/uint32-matrix
+    minItems: 1
+    maxItems: 8
+    items:
+      items:
+        - description: |
+            MSM chipset ID - an exact match value consisting of two bitfields::
+             - bits 0-15  - The unique MSM chipset ID
+             - bits 16-31 - Reserved; should be 0
+        - description: |
+            Hardware revision ID - a chipset specific 32-bit ID representing
+            the version of the chipset.  It is best a match value - the
+            bootloader will look for the closest possible match.
+    deprecated: true
+    description:
+      The MSM chipset and hardware revision use by Qualcomm bootloaders.  It
+      can optionally be an array of these to indicate multiple hardware that
+      use the same device tree.  It is expected that the bootloader will use
+      this information at boot-up to decide which device tree to use when given
+      multiple device trees, some of which may not be compatible with the
+      actual hardware.  It is the bootloader's responsibility to pass the
+      correct device tree to the kernel.
+      The property is deprecated.
+
+  qcom,board-id:
+    $ref: /schemas/types.yaml#/definitions/uint32-matrix
+    minItems: 1
+    maxItems: 8
+    oneOf:
+      - items:
+          - items:
+              - description: |
+                  Board ID consisting of three bitfields::
+                    - bits 31-24 - Unused
+                    - bits 23-16 - Platform Version Major
+                    - bits 15-8  - Platform Version Minor
+                    - bits 7-0   - Platform Type
+                  Platform Type field is an exact match value.  The
+                  Platform Major/Minor field is a best match.  The bootloader will
+                  look for the closest possible match.
+              - description: |
+                  Subtype ID unique to a Platform Type/Chipset ID.  For a given
+                  Platform Type, there will typically only be a single board and the
+                  subtype_id will be 0.  However in some cases board variants may
+                  need to be distinguished by different subtype_id values.
+      - items:
+          # OnePlus uses a variant of board-id with four elements:
+          - items:
+              - const: 8
+              - const: 0
+              - description: OnePlus board ID
+              - description: OnePlus subtype ID
+    deprecated: true
+    description:
+      The board type and revision information.  It can optionally be an array
+      of these to indicate multiple boards that use the same device tree.  It
+      is expected that the bootloader will use this information at boot-up to
+      decide which device tree to use when given multiple device trees, some of
+      which may not be compatible with the actual hardware.  It is the
+      bootloader's responsibility to pass the correct device tree to the
+      kernel
+      The property is deprecated.
+
+allOf:
+  # Explicit allow-list for older SoCs. The legacy properties are not allowed
+  # on newer SoCs.
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,apq8026
+              - qcom,apq8094
+              - qcom,apq8096
+              - qcom,msm8992
+              - qcom,msm8994
+              - qcom,msm8996
+              - qcom,msm8998
+              - qcom,sdm630
+              - qcom,sdm632
+              - qcom,sdm845
+              - qcom,sdx55
+              - qcom,sdx65
+              - qcom,sm6125
+              - qcom,sm6350
+              - qcom,sm7225
+              - qcom,sm8150
+              - qcom,sm8250
+    then:
+      properties:
+        qcom,board-id: true
+        qcom,msm-id: true
+    else:
+      properties:
+        qcom,board-id: false
+        qcom,msm-id: false
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - oneplus,cheeseburger
+              - oneplus,dumpling
+              - oneplus,enchilada
+              - oneplus,fajita
+    then:
+      properties:
+        qcom,board-id:
+          items:
+            minItems: 4
+    else:
+      properties:
+        qcom,board-id:
+          items:
+            maxItems: 2
+
 additionalProperties: true
 
 ...
diff --git a/include/dt-bindings/arm/qcom,ids.h b/include/dt-bindings/arm/qcom,ids.h
new file mode 100644
index 000000000000..635d4ebba3fe
--- /dev/null
+++ b/include/dt-bindings/arm/qcom,ids.h
@@ -0,0 +1,146 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2015, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2022 Linaro Ltd
+ * Author: Krzysztof Kozlowski <krzk@kernel.org> based on previous work of Kumar Gala.
+ */
+#ifndef _DT_BINDINGS_ARM_QCOM_IDS_H
+#define _DT_BINDINGS_ARM_QCOM_IDS_H
+
+/* qcom,msm-id */
+#define QCOM_ID_MSM8960			87
+#define QCOM_ID_APQ8064			109
+#define QCOM_ID_MSM8660A		122
+#define QCOM_ID_MSM8260A		123
+#define QCOM_ID_APQ8060A		124
+#define QCOM_ID_MSM8974			126
+#define QCOM_ID_MPQ8064			130
+#define QCOM_ID_MSM8960AB		138
+#define QCOM_ID_APQ8060AB		139
+#define QCOM_ID_MSM8260AB		140
+#define QCOM_ID_MSM8660AB		141
+#define QCOM_ID_MSM8626			145
+#define QCOM_ID_MSM8610			147
+#define QCOM_ID_APQ8064AB		153
+#define QCOM_ID_MSM8226			158
+#define QCOM_ID_MSM8526			159
+#define QCOM_ID_MSM8110			161
+#define QCOM_ID_MSM8210			162
+#define QCOM_ID_MSM8810			163
+#define QCOM_ID_MSM8212			164
+#define QCOM_ID_MSM8612			165
+#define QCOM_ID_MSM8112			166
+#define QCOM_ID_MSM8225Q		168
+#define QCOM_ID_MSM8625Q		169
+#define QCOM_ID_MSM8125Q		170
+#define QCOM_ID_APQ8064AA		172
+#define QCOM_ID_APQ8084			178
+#define QCOM_ID_APQ8074			184
+#define QCOM_ID_MSM8274			185
+#define QCOM_ID_MSM8674			186
+#define QCOM_ID_MSM8974PRO_AC		194
+#define QCOM_ID_MSM8126			198
+#define QCOM_ID_APQ8026			199
+#define QCOM_ID_MSM8926			200
+#define QCOM_ID_MSM8326			205
+#define QCOM_ID_MSM8916			206
+#define QCOM_ID_MSM8994			207
+#define QCOM_ID_APQ8074PRO_AA		208
+#define QCOM_ID_APQ8074PRO_AB		209
+#define QCOM_ID_APQ8074PRO_AC		210
+#define QCOM_ID_MSM8274PRO_AA		211
+#define QCOM_ID_MSM8274PRO_AB		212
+#define QCOM_ID_MSM8274PRO_AC		213
+#define QCOM_ID_MSM8674PRO_AA		214
+#define QCOM_ID_MSM8674PRO_AB		215
+#define QCOM_ID_MSM8674PRO_AC		216
+#define QCOM_ID_MSM8974PRO_AA		217
+#define QCOM_ID_MSM8974PRO_AB		218
+#define QCOM_ID_APQ8028			219
+#define QCOM_ID_MSM8128			220
+#define QCOM_ID_MSM8228			221
+#define QCOM_ID_MSM8528			222
+#define QCOM_ID_MSM8628			223
+#define QCOM_ID_MSM8928			224
+#define QCOM_ID_MSM8510			225
+#define QCOM_ID_MSM8512			226
+#define QCOM_ID_MSM8936			233
+#define QCOM_ID_MSM8939			239
+#define QCOM_ID_APQ8036			240
+#define QCOM_ID_APQ8039			241
+#define QCOM_ID_MSM8996			246
+#define QCOM_ID_APQ8016			247
+#define QCOM_ID_MSM8216			248
+#define QCOM_ID_MSM8116			249
+#define QCOM_ID_MSM8616			250
+#define QCOM_ID_MSM8992			251
+#define QCOM_ID_APQ8094			253
+#define QCOM_ID_MDM9607			290
+#define QCOM_ID_APQ8096			291
+#define QCOM_ID_MSM8998			292
+#define QCOM_ID_MSM8953			293
+#define QCOM_ID_MDM8207			296
+#define QCOM_ID_MDM9207			297
+#define QCOM_ID_MDM9307			298
+#define QCOM_ID_MDM9628			299
+#define QCOM_ID_APQ8053			304
+#define QCOM_ID_MSM8996SG		305
+#define QCOM_ID_MSM8996AU		310
+#define QCOM_ID_APQ8096AU		311
+#define QCOM_ID_APQ8096SG		312
+#define QCOM_ID_SDM660			317
+#define QCOM_ID_SDM630			318
+#define QCOM_ID_APQ8098			319
+#define QCOM_ID_SDM845			321
+#define QCOM_ID_MDM9206			322
+#define QCOM_ID_IPQ8074			323
+#define QCOM_ID_SDA660			324
+#define QCOM_ID_SDM658			325
+#define QCOM_ID_SDA658			326
+#define QCOM_ID_SDA630			327
+#define QCOM_ID_SDM450			338
+#define QCOM_ID_SDA845			341
+#define QCOM_ID_IPQ8072			342
+#define QCOM_ID_IPQ8076			343
+#define QCOM_ID_IPQ8078			344
+#define QCOM_ID_SDM636			345
+#define QCOM_ID_SDA636			346
+#define QCOM_ID_SDM632			349
+#define QCOM_ID_SDA632			350
+#define QCOM_ID_SDA450			351
+#define QCOM_ID_SM8250			356
+#define QCOM_ID_IPQ8070			375
+#define QCOM_ID_IPQ8071			376
+#define QCOM_ID_IPQ8072A		389
+#define QCOM_ID_IPQ8074A		390
+#define QCOM_ID_IPQ8076A		391
+#define QCOM_ID_IPQ8078A		392
+#define QCOM_ID_SM6125			394
+#define QCOM_ID_IPQ8070A		395
+#define QCOM_ID_IPQ8071A		396
+#define QCOM_ID_IPQ6018			402
+#define QCOM_ID_IPQ6028			403
+#define QCOM_ID_IPQ6000			421
+#define QCOM_ID_IPQ6010			422
+#define QCOM_ID_SC7180			425
+#define QCOM_ID_SM6350			434
+#define QCOM_ID_SM8350			439
+#define QCOM_ID_SC8280XP		449
+#define QCOM_ID_IPQ6005			453
+#define QCOM_ID_QRB5165			455
+#define QCOM_ID_SM8450			457
+#define QCOM_ID_SM7225			459
+#define QCOM_ID_SA8540P			460
+#define QCOM_ID_SM8450_2		480
+#define QCOM_ID_SM8450_3		482
+#define QCOM_ID_SC7280			487
+
+/* qcom,board-id */
+#define QCOM_BOARD_ID(a, major, minor) \
+	(((major & 0xff) << 16) | ((minor & 0xff) << 8) | QCOM_BOARD_ID_##a)
+
+#define QCOM_BOARD_ID_MTP			8
+#define QCOM_BOARD_ID_DRAGONBOARD		10
+#define QCOM_BOARD_ID_SBC			24
+
+#endif /* _DT_BINDINGS_ARM_QCOM_IDS_H */
-- 
2.34.1

