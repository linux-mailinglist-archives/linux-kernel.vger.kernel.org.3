Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 149F253727F
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 22:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbiE2U0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 16:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231514AbiE2U0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 16:26:39 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 289DB11C08
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 13:26:37 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id t13so12197284wrg.9
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 13:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v/cDy7Pc+AVHD+wNR+Rz+yhCWOLUKaEFS/4CfLicCP4=;
        b=iskVBz4DTZHQfdCbQ7H+rb7G/9jmwow4Z8+4mbuQMJSNDmMHSZFRNeY1YY/HaKRBlr
         9JlMbP00a9IwjjQsGrIIMpZTGCYPb0ArLMKZCqw9tClelK9/rr/aUpHwZpdyp5v73MvJ
         CTtyR3wV/LJ6Os7xBF7Hyg3nOvbtdJK7fjvFYY5013yw4gBidTydCvx2dhXWTll2OuD5
         3dcadk1UOTkN4J+oc3pIY2f+pwSCwvYJBFmv/8ttPcLWM2XmF0Tkp9AJXLk754KVxdtO
         tyMJUeUvOMENu0lqacf/T3JWxdtuOOly5XZ4stOn6G3wGkrOkTO+lqpfIEZMwrUIAmC/
         TDmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v/cDy7Pc+AVHD+wNR+Rz+yhCWOLUKaEFS/4CfLicCP4=;
        b=pcpvIx0qCO51A8dp1A/p/DrfAlkxpO4kPLF4upjXXbNxkgVKYMyPWiWaqnRGOrZ40g
         P+H3Twwxv7YabQq4D+na0uS9qGkSBUQHeC/JWM6UyPmXDS0NBFwOOElwp+gYosB5n52n
         Jr1vNl47+J3e6xf3AEkDcDazZSvvr1wgwXkrtIKZ9xwXTpdMkrwGOLgroAPCy2arASld
         AnbscA4P0S540VOCfABrB3B+VddhiXnrLCsn9uX0+ZbxN22h9SdCTkPXObZ3Jua+F+y9
         Xvi2jGLNXU1EGeAmFifO4nWeFYWxQKI4v9nJwb/Oc5euQtEkjt5IWukazia0tHWiGtZR
         u54w==
X-Gm-Message-State: AOAM532gyVhbW4JPKqy+Bsc75e2h/KDRfk98tD3XD8fhbIj0WlsaJUwN
        bmISXfwwHge7/zup1ED/ARr3Rw==
X-Google-Smtp-Source: ABdhPJwlGxyui4QRiySaO4KGMAJsjcDp5zrZaBqX6mWcpTm2rgKxK86sbUWZEz1jYAw5laQNvkcUoA==
X-Received: by 2002:adf:f789:0:b0:210:3534:636c with SMTP id q9-20020adff789000000b002103534636cmr1056358wrp.273.1653855995473;
        Sun, 29 May 2022 13:26:35 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id y4-20020a5d6144000000b0020c5253d8f7sm7099310wrt.67.2022.05.29.13.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 May 2022 13:26:34 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Rob Clark <robdclark@gmail.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Kumar Gala <galak@codeaurora.org>
Subject: [PATCH 1/4] dt-bindings: arm: qcom: document qcom,msm-id and qcom,board-id
Date:   Sun, 29 May 2022 22:26:26 +0200
Message-Id: <20220529202629.47588-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220529202629.47588-1-krzysztof.kozlowski@linaro.org>
References: <20220529202629.47588-1-krzysztof.kozlowski@linaro.org>
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
---
 .../devicetree/bindings/arm/qcom.yaml         | 58 +++++++++++++++++++
 include/dt-bindings/arm/qcom,ids.h            | 30 ++++++++++
 2 files changed, 88 insertions(+)
 create mode 100644 include/dt-bindings/arm/qcom,ids.h

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 6c38c1387afd..b7fa85c1e478 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -403,6 +403,64 @@ properties:
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
+            MSM chipset ID - an exact match value consisting of three bitfields::
+             - bits 0-15  - The unique MSM chipset ID
+             - bits 16-31 - Reserved; should be 0
+        - description: |
+            Hardware revision ID - a chipset specific 32-bit ID representing
+            the version of the chipset.  It is best a match value - the
+            bootloader will look for the closest possible match.
+    description:
+      The MSM chipset and hardware revision use by Qualcomm bootloaders.  It
+      can optionally be an array of these to indicate multiple hardware that
+      use the same device tree.  It is expected that the bootloader will use
+      this information at boot-up to decide which device tree to use when given
+      multiple device trees, some of which may not be compatible with the
+      actual hardware.  It is the bootloader's responsibility to pass the
+      correct device tree to the kernel.
+      This is a legacy property - it is not expected on newer boards (starting
+      with SM8350).
+
+  qcom,board-id:
+    $ref: /schemas/types.yaml#/definitions/uint32-matrix
+    minItems: 1
+    maxItems: 8
+    items:
+      items:
+        - description: |
+            Board ID consisting of three bitfields::
+              - bits 31-24 - Unusued
+              - bits 23-16 - Platform Version Major
+              - bits 15-8  - Platform Version Minor
+              - bits 7-0   - Platform Type
+            Platform Type field is an exact match value.  The
+            Platform Major/Minor field is a best match.  The bootloader will
+            look for the closest possible match.
+        - description: |
+            Subtype ID unique to a Platform Type/Chipset ID.  For a given
+            Platform Type, there will typically only be a single board and the
+            subtype_id will be 0.  However in some cases board variants may
+            need to be distinguished by different subtype_id values.
+    description:
+      The board type and revision information.  It can optionally be an array
+      of these to indicate multiple boards that use the same device tree.  It
+      is expected that the bootloader will use this information at boot-up to
+      decide which device tree to use when given multiple device trees, some of
+      which may not be compatible with the actual hardware.  It is the
+      bootloader's responsibility to pass the correct device tree to the
+      kernel
+      This is a legacy property - it is not expected on newer boards (starting
+      with SM8350).
+
 additionalProperties: true
 
 ...
diff --git a/include/dt-bindings/arm/qcom,ids.h b/include/dt-bindings/arm/qcom,ids.h
new file mode 100644
index 000000000000..eaf86c18650f
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
+#define QCOM_ID_MSM8996_3_0			246
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

