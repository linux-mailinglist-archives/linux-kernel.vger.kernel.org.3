Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A791A55483C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357958AbiFVLtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 07:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357813AbiFVLtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 07:49:09 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59CEB3CFCC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 04:49:06 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id j24so2320773wrb.11
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 04:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IQf6SVthuwgN2u5Dxg74+naLmP1gH8v2iUZRKb3k+tg=;
        b=dagDuCjOFLnOng0E69frX23Ut9+tmyGxSMg/atRA26qrUNm8XoOORoJPaSuvitQeD2
         DlccIfxx6TI7c//Vq81XlFNVWRNRn96uVcQZ/IaDWf0mHoQGJVpc/JeNsanUb/mXqTk6
         WM9LRTSNSbK+Ak3ULN2294m+HEulOV0V251WnjOGgi9dFBtUXbQLHr+63Md3/VDxwbku
         j+MR43VpSyKqIVx/QsVvn9EDFcWgfN2m02R/mvZH50DWDzLhkeGRg+x662V+NwZVjGsc
         j7vVDqMkV4pY69rKQqJ0A+j2BdPJ6F2bo8c6eG6YC6TlhwBVu+N06fs6GVzSclij3ZVv
         6wNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IQf6SVthuwgN2u5Dxg74+naLmP1gH8v2iUZRKb3k+tg=;
        b=paWZIP6PcoDXk2BMSOsTvrMkTLoBCGLtjoHCI1dzqSloNHwmUJ1Dt7DBHctq0WVKZs
         Wec271fe/vNwVAdbduR9IY35fHNpNE75ok2SeWMdpr83Vb96kHkVpPBQocZqPmju0NY+
         Y2oiJyeagglcWS0Crwai1CsEXYmNRTP9WGndw216vUezfK8tn9epEq3OG3VYiCLE6XuW
         0vPbhRt/g4uy0/H7HOwR3m5CHF578qu+qESW4n2YM/ca8jrYtw8AcTq9yEtfd+FS0mYw
         37etV2t6X9vViEYLNWeVUFiRgdX23Orxif5Ry8YYI4/a23hszwe/WKEqXI6FNMkr2zBy
         XV3A==
X-Gm-Message-State: AJIora+U4UFsttredLz37XzQ0K2KV2+uos/HX5FmELMQrjCvB3nM233l
        Ee4xVOSuH1TwL5SLOj8HL6Uv7w==
X-Google-Smtp-Source: AGRyM1tZeNB530yO0BVcIVKeSRhG7OVW1eiOhJ5OVRQnLq8rHuaTCgmqBk1PCoY+L0DkdaHlhJznjQ==
X-Received: by 2002:adf:d0ce:0:b0:21b:89c1:d49e with SMTP id z14-20020adfd0ce000000b0021b89c1d49emr2930600wrh.256.1655898544528;
        Wed, 22 Jun 2022 04:49:04 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id p19-20020a05600c359300b0039c54bb28f2sm22448760wmq.36.2022.06.22.04.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 04:49:04 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Rob Clark <robdclark@gmail.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Stephen Boyd <sboyd@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Kumar Gala <galak@codeaurora.org>
Subject: [PATCH v3 1/2] dt-bindings: arm: qcom: document qcom,msm-id and qcom,board-id
Date:   Wed, 22 Jun 2022 13:48:55 +0200
Message-Id: <20220622114856.6243-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220622114856.6243-1-krzysztof.kozlowski@linaro.org>
References: <20220622114856.6243-1-krzysztof.kozlowski@linaro.org>
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
 .../devicetree/bindings/arm/qcom.yaml         | 121 ++++++++++++++++++
 include/dt-bindings/arm/qcom,ids.h            |  30 +++++
 2 files changed, 151 insertions(+)
 create mode 100644 include/dt-bindings/arm/qcom,ids.h

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 6c38c1387afd..431e3ff31d75 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -403,6 +403,127 @@ properties:
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
+    items:
+      oneOf:
+        - maxItems: 2
+          items:
+            - description: |
+                Board ID consisting of three bitfields::
+                  - bits 31-24 - Unused
+                  - bits 23-16 - Platform Version Major
+                  - bits 15-8  - Platform Version Minor
+                  - bits 7-0   - Platform Type
+                Platform Type field is an exact match value.  The
+                Platform Major/Minor field is a best match.  The bootloader will
+                look for the closest possible match.
+            - description: |
+                Subtype ID unique to a Platform Type/Chipset ID.  For a given
+                Platform Type, there will typically only be a single board and the
+                subtype_id will be 0.  However in some cases board variants may
+                need to be distinguished by different subtype_id values.
+        # OnePlus uses a variant of board-id with four elements:
+        - minItems: 4
+          items:
+            - const: 8
+            - const: 0
+            - description: OnePlus board ID
+            - description: OnePlus subtype ID
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
index 000000000000..df4a07b898cc
--- /dev/null
+++ b/include/dt-bindings/arm/qcom,ids.h
@@ -0,0 +1,30 @@
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
+#define QCOM_ID_APQ8026				199
+#define QCOM_ID_MSM8916				206
+#define QCOM_ID_MSM8994				207
+#define QCOM_ID_MSM8996				246
+#define QCOM_ID_APQ8016				247
+#define QCOM_ID_MSM8216				248
+#define QCOM_ID_MSM8116				249
+#define QCOM_ID_MSM8616				250
+#define QCOM_ID_MSM8998				292
+#define QCOM_ID_SDM845				321
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

