Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45844568E31
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 17:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234756AbiGFPto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 11:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234529AbiGFPtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 11:49:13 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B232A73C
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 08:43:44 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id k30so11677410edk.8
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 08:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Uxcyk87f5UukRnGhPk90Dqu4hjQ+0bEvswpHFBAxUyM=;
        b=PimJ1/KHl5MLrAPrzixyE9r8n0unRBFfelzL2lD0FhXq3vwRkuI6P3g/eqWOdw8+yJ
         tfFPQik4KkRtNe6RSsVBH16ROxtUdCjabFnpv+Ax38RVeUnLRJBlWMQhCo0+T3nvMGeY
         hNFj4A26fhBu08Nv381NIxA0k9tjZsd/GQUiTR3shb7ofshgRDb7m9M18X3te4IgdHiN
         vCXxFBzNxlOzYOgGutMD3oHATM+WAUDeWEcDgzb5yg2yVKVGeAGD0gWSOhR25AB9a6El
         zsMTLt+YDEUHto+tfMCfY8Khvr3cNo0JX1Z/pThYeoSxILDj1eFN9pK4cskQUtPjAdPQ
         XupA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Uxcyk87f5UukRnGhPk90Dqu4hjQ+0bEvswpHFBAxUyM=;
        b=bb4Pf3j4EXP69phRh8OVLHjF/KDXXmDunV1nTbxOLXVTNmi3z6QZd8ihFbV1PGRBLi
         m9DfBN97Tc3DQoIqMlD07udUKXxl5FBykTL1lWCsZQOC3fvxy99Iy2qtBnaMRbsc143i
         x0UvMhqaYerPLOKyPoAWYoFZMNjNPKaog8LNMoTJ17JL4dRyZ4NdRjxl4BIWE3gwcHrU
         iu+UVNHO8A3yLRMHD4fZqbYpGMC1PQnFp0oUw0UmlZyH0rMroIy+UnDuuompN4pNVlW6
         xBVg/IYnjJxftQoMxplyNW2C/QEIhKbwGCsMErUdqcqzb7hqm99egmnXoQw626x57thL
         cKxg==
X-Gm-Message-State: AJIora/3GuWhSRpwvppEqhA+3/HM0Prv5/PpGN7cVouTelM1u5d02VT6
        Y5xEPKWghkFESAyXT7XVf/IRTg==
X-Google-Smtp-Source: AGRyM1v2UuXUA2/omMAXTpdjuxNxw6TRvJJnL2Dx6VWDfZ+CH1bQtJAIN4CvJ/YpEX7YD2CX0Hdudg==
X-Received: by 2002:a05:6402:50d0:b0:436:d04:ebb8 with SMTP id h16-20020a05640250d000b004360d04ebb8mr55840482edb.255.1657122223017;
        Wed, 06 Jul 2022 08:43:43 -0700 (PDT)
Received: from prec5560.. (freifunk-gw.bsa1-cpe1.syseleven.net. [176.74.57.43])
        by smtp.gmail.com with ESMTPSA id fi18-20020a056402551200b0043a43fcde13sm7711033edb.13.2022.07.06.08.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 08:43:42 -0700 (PDT)
From:   Robert Foss <robert.foss@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jonathan@marek.ca,
        robert.foss@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Dmitry Baryshkov <dmityr.baryshkov@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v8 1/5] dt-bindings: clock: Add Qcom SM8350 GPUCC bindings
Date:   Wed,  6 Jul 2022 17:43:33 +0200
Message-Id: <20220706154337.2026269-2-robert.foss@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220706154337.2026269-1-robert.foss@linaro.org>
References: <20220706154337.2026269-1-robert.foss@linaro.org>
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

Add device tree bindings for graphics clock controller for
Qualcomm Technology Inc's SM8350 SoCs.

Signed-off-by: Robert Foss <robert.foss@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmityr.baryshkov@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---

Changes since v3
 - Separate from qcom,gpucc
 - Remove clock-names
 - Make example sm8350 based
 - Changed author to me due to size of changes

Changes since v5
 - Add Ack - Rob

Changes since v5
 - Reverted split from dispcc-sm8250
 - Re-added tags from v3



 .../bindings/clock/qcom,gpucc-sm8350.yaml     | 72 +++++++++++++++++++
 include/dt-bindings/clock/qcom,gpucc-sm8350.h | 52 ++++++++++++++
 2 files changed, 124 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,gpucc-sm8350.yaml
 create mode 100644 include/dt-bindings/clock/qcom,gpucc-sm8350.h

diff --git a/Documentation/devicetree/bindings/clock/qcom,gpucc-sm8350.yaml b/Documentation/devicetree/bindings/clock/qcom,gpucc-sm8350.yaml
new file mode 100644
index 000000000000..0a0546c079a9
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,gpucc-sm8350.yaml
@@ -0,0 +1,72 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/qcom,gpucc-sm8350.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Graphics Clock & Reset Controller Binding
+
+maintainers:
+  - Robert Foss <robert.foss@linaro.org>
+
+description: |
+  Qualcomm graphics clock control module which supports the clocks, resets and
+  power domains on Qualcomm SoCs.
+
+  See also:
+    dt-bindings/clock/qcom,gpucc-sm8350.h
+
+properties:
+  compatible:
+    enum:
+      - qcom,sm8350-gpucc
+
+  clocks:
+    items:
+      - description: Board XO source
+      - description: GPLL0 main branch source
+      - description: GPLL0 div branch source
+
+  '#clock-cells':
+    const: 1
+
+  '#reset-cells':
+    const: 1
+
+  '#power-domain-cells':
+    const: 1
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - '#clock-cells'
+  - '#reset-cells'
+  - '#power-domain-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,gcc-sm8350.h>
+    #include <dt-bindings/clock/qcom,rpmh.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        clock-controller@3d90000 {
+            compatible = "qcom,sm8350-gpucc";
+            reg = <0 0x03d90000 0 0x9000>;
+            clocks = <&rpmhcc RPMH_CXO_CLK>,
+                     <&gcc GCC_GPU_GPLL0_CLK_SRC>,
+                     <&gcc GCC_GPU_GPLL0_DIV_CLK_SRC>;
+            #clock-cells = <1>;
+            #reset-cells = <1>;
+            #power-domain-cells = <1>;
+        };
+    };
+...
diff --git a/include/dt-bindings/clock/qcom,gpucc-sm8350.h b/include/dt-bindings/clock/qcom,gpucc-sm8350.h
new file mode 100644
index 000000000000..2ca857f5bfd2
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,gpucc-sm8350.h
@@ -0,0 +1,52 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2022, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_CLK_QCOM_GPU_CC_SM8350_H
+#define _DT_BINDINGS_CLK_QCOM_GPU_CC_SM8350_H
+
+/* GPU_CC clocks */
+#define GPU_CC_AHB_CLK			0
+#define GPU_CC_CB_CLK			1
+#define GPU_CC_CRC_AHB_CLK		2
+#define GPU_CC_CX_APB_CLK		3
+#define GPU_CC_CX_GMU_CLK		4
+#define GPU_CC_CX_QDSS_AT_CLK		5
+#define GPU_CC_CX_QDSS_TRIG_CLK		6
+#define GPU_CC_CX_QDSS_TSCTR_CLK	7
+#define GPU_CC_CX_SNOC_DVM_CLK		8
+#define GPU_CC_CXO_AON_CLK		9
+#define GPU_CC_CXO_CLK			10
+#define GPU_CC_FREQ_MEASURE_CLK		11
+#define GPU_CC_GMU_CLK_SRC		12
+#define GPU_CC_GX_GMU_CLK		13
+#define GPU_CC_GX_QDSS_TSCTR_CLK	14
+#define GPU_CC_GX_VSENSE_CLK		15
+#define GPU_CC_HLOS1_VOTE_GPU_SMMU_CLK	16
+#define GPU_CC_HUB_AHB_DIV_CLK_SRC	17
+#define GPU_CC_HUB_AON_CLK		18
+#define GPU_CC_HUB_CLK_SRC		19
+#define GPU_CC_HUB_CX_INT_CLK		20
+#define GPU_CC_HUB_CX_INT_DIV_CLK_SRC	21
+#define GPU_CC_MND1X_0_GFX3D_CLK	22
+#define GPU_CC_MND1X_1_GFX3D_CLK	23
+#define GPU_CC_PLL0			24
+#define GPU_CC_PLL1			25
+#define GPU_CC_SLEEP_CLK		26
+
+/* GPU_CC resets */
+#define GPUCC_GPU_CC_ACD_BCR		0
+#define GPUCC_GPU_CC_CB_BCR		1
+#define GPUCC_GPU_CC_CX_BCR		2
+#define GPUCC_GPU_CC_FAST_HUB_BCR	3
+#define GPUCC_GPU_CC_GFX3D_AON_BCR	4
+#define GPUCC_GPU_CC_GMU_BCR		5
+#define GPUCC_GPU_CC_GX_BCR		6
+#define GPUCC_GPU_CC_XO_BCR		7
+
+/* GPU_CC GDSCRs */
+#define GPU_CX_GDSC			0
+#define GPU_GX_GDSC			1
+
+#endif
-- 
2.34.1

