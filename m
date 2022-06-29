Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFE21560209
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 16:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233225AbiF2ODP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 10:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233081AbiF2ODM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 10:03:12 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5942C640A
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 07:03:09 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id u12so32757672eja.8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 07:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WoV4pas84c7AMle4/cOCqX9GxEkhRyeiQnd4AgtTb4M=;
        b=nBxPgnptDg1TDKkHwk9owzFTTn+EAgl050PaJcrBtU2U2LZyXX9+wqNTfjhhHY83vk
         O67kySTQ/Yrh7un5++SeFAKWkT9UOb4Lu81dC/TFDBocO9nww4QhAzPj4AmYxoKQZdwu
         q7BABzVKeH/yYhkhD7ecjRPfddU3qVgI4zSvvC30I+Si1p9S17kzj7Uc+p0NX06wTIhu
         E2PR2QHYKIkCBJ3m769D65wbmf4i+2GTd/CqA/cxHIRirMBufIq2fVMoF+Rxw4NA1lOh
         +iOqHqYT2aoBKOyYLZoKXAmMh1qn2V9vy9yODYM+tXswFoOQGdieUwOSo4sbBfGlTIkI
         c7hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WoV4pas84c7AMle4/cOCqX9GxEkhRyeiQnd4AgtTb4M=;
        b=RnA3A1YXRIMtM/WgzYSIJtlAsathK6cnK52LEZsvYt7inxaYAXFf7rXQsbA2nzkcNN
         +KX9m6bb1vihdV7QtGS6G33jsxWro97I52YrwUka1ntvDOoGvgJk+LhfcHDdvD8b44Zq
         YSUVXmXOcyEOBsvecSrwpai4lYEPtTqNlIOnJT9dhnJIzSLkQHmmkf/kq3RKVaI97vW+
         zClwI6t3sEfSzwhRrRmDNXakPSUhDNj0peVOimTvW1Cs0KTah7d+dbgClT24qLb0ZYFF
         aMYbdPPoilCtHuhSI7a+90bsxv8nm9a8rIGKHQleBWm4fBJ8GRIttxwrR32LpisBLTe/
         +5Ag==
X-Gm-Message-State: AJIora/UAZodrhuLD7x8+GDsO1MoQS6fUg+/Re0KNYtJvi+e2t9GrM5L
        0HU/3q03SGnJgRSXDWfI+27c2A==
X-Google-Smtp-Source: AGRyM1uvkOOqFbqUM+RY5yAkCvI7aTyYIjvcaD/nQFO+hMzkTRB08YDr0vO9O9sQVR8XaZTy9l5zVQ==
X-Received: by 2002:a17:907:75f9:b0:72a:38f3:f0b5 with SMTP id jz25-20020a17090775f900b0072a38f3f0b5mr2321627ejc.549.1656511387925;
        Wed, 29 Jun 2022 07:03:07 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id f9-20020a17090660c900b007262a5e2204sm7739260ejk.153.2022.06.29.07.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 07:03:07 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Rajendra Nayak <quic_rjendra@quicinc.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v6 1/4] dt-bindings: interconnect: qcom,msm8998-cpu-bwmon: add BWMON device
Date:   Wed, 29 Jun 2022 16:02:59 +0200
Message-Id: <20220629140302.236715-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220629140302.236715-1-krzysztof.kozlowski@linaro.org>
References: <20220629140302.236715-1-krzysztof.kozlowski@linaro.org>
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

Add bindings for the Qualcomm Bandwidth Monitor device providing
performance data on interconnects.  The bindings describe only BWMON CPU
(version 4), e.g. the instance which appeared for the first on Qualcomm
MSM8998 SoC and is also used on SDM845.  This BWMON device sits between
CPU and Last Level Cache Controller.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Georgi Djakov <djakov@kernel.org>
---
 .../interconnect/qcom,msm8998-llcc-bwmon.yaml | 85 +++++++++++++++++++
 1 file changed, 85 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,msm8998-llcc-bwmon.yaml

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-llcc-bwmon.yaml b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-llcc-bwmon.yaml
new file mode 100644
index 000000000000..76e09658d615
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-llcc-bwmon.yaml
@@ -0,0 +1,85 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interconnect/qcom,msm8998-llcc-bwmon.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Interconnect Bandwidth Monitor
+
+maintainers:
+  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+
+description: |
+  Bandwidth Monitor measures current throughput on buses between various NoC
+  fabrics and provides information when it crosses configured thresholds.
+
+  Certain SoCs might have more than one Bandwidth Monitors, for example on SDM845::
+   - Measuring the bandwidth between CPUs and Last Level Cache Controller -
+     called LLCC BWMON,
+   - Measuring the bandwidth between Last Level Cache Controller and memory (DDR).
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - qcom,sdm845-llcc-bwmon
+          - const: qcom,msm8998-llcc-bwmon
+      - const: qcom,msm8998-llcc-bwmon       # BWMON v4
+
+  interconnects:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  operating-points-v2: true
+  opp-table: true
+
+  reg:
+    # BWMON v4 (currently described) and BWMON v5 use one register address
+    # space.  BWMON v2 uses two register spaces - not yet described.
+    maxItems: 1
+
+required:
+  - compatible
+  - interconnects
+  - interrupts
+  - operating-points-v2
+  - opp-table
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interconnect/qcom,sdm845.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    pmu@1436400 {
+        compatible = "qcom,sdm845-llcc-bwmon", "qcom,msm8998-llcc-bwmon";
+        reg = <0x01436400 0x600>;
+        interrupts = <GIC_SPI 581 IRQ_TYPE_LEVEL_HIGH>;
+        interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc SLAVE_LLCC 3>;
+
+        operating-points-v2 = <&llcc_bwmon_opp_table>;
+
+        llcc_bwmon_opp_table: opp-table {
+            compatible = "operating-points-v2";
+            opp-0 {
+                opp-peak-kBps = <4800000>;
+            };
+            opp-1 {
+                opp-peak-kBps = <9216000>;
+            };
+            opp-2 {
+                opp-peak-kBps = <15052800>;
+            };
+            opp-3 {
+                opp-peak-kBps = <20889600>;
+            };
+            opp-4 {
+                opp-peak-kBps = <25497600>;
+            };
+        };
+    };
-- 
2.34.1

