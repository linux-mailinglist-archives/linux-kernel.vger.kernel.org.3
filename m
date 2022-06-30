Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50D34561AEF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 15:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234774AbiF3NFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 09:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232771AbiF3NFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 09:05:48 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C583722BCE
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 06:05:47 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id pk21so38941429ejb.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 06:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WoV4pas84c7AMle4/cOCqX9GxEkhRyeiQnd4AgtTb4M=;
        b=xfy9bScGM/9QWE4qEN0iUghHvcSTcJH3KQ6R3wGdz0K19qKA6E7M6z5XIocaWQfxju
         hvXxmgp1GLjOQP5JJl+B97AsjcV67+jrb33vqtGDglrnO2kg3kBdYSEKBIiwHUCbwgNQ
         s4zuHt/q8J0Gh6VZyQ9kGusouz62vzhHDqrhKh49eJ+AZ8IsKPUSU+XUqQ5cXJ/joDbr
         C1dUC8+S6V7ktlyFP5kvac3Fg2jFJAPNTXnZntimA1Rj9GYBnhAgFsr61eoly0jEjUQR
         VS5hs1mo6MqFnSmIkm5Vd8eZZjOCAwf4TaH7n4imtBx6t7c6xBd18E8XBeapb1vX4ei/
         zwDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WoV4pas84c7AMle4/cOCqX9GxEkhRyeiQnd4AgtTb4M=;
        b=v7+5I3pXAWNhOv4k8oHu7muZaPZ5c5edd0cNbHmQupd8yZ+5jhLI2WvJG3OYKW4v21
         CkjRTaL28c10dC/qesRpsTwmLzxcDWJV+5deR1HHbLjqABDirtm35R5dY31cbMeqp3jf
         34G1MiimA+dNksXcwGfONYc+AgS2WSXyETtPH7yVk5osogCtV5fwdH3xdJS31tiR86Tz
         oC2Nwn1qCUELHR+9YHWpULbT6cSOp/rXCXfIFsaYry0uJfQpRJ5dCyRcHPzPEzy9YYV/
         E/ypma6C7NpL9IGZuAbovXG6yVGCfP5Hypxbgb+L5AHOH9SIDWCW/WkzxNb/aGSrcRIb
         fVmQ==
X-Gm-Message-State: AJIora9BUGuyFhM0Fedy7SpG5Bzz4OV5BSQcW0in+oLaqxtttFILlRDM
        cWycPq+h/ID+EiOpw5Tp5ypxBA==
X-Google-Smtp-Source: AGRyM1tyzoD4broviwi8cseUJcMss44EJFmHnXdv76S5xGNYbukNcjB8q6FsDxih9LAnfiSSugsDkw==
X-Received: by 2002:a17:907:3da2:b0:718:c108:663c with SMTP id he34-20020a1709073da200b00718c108663cmr8826494ejc.252.1656594346338;
        Thu, 30 Jun 2022 06:05:46 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id f15-20020a1709062c4f00b007081282cbd8sm9124967ejh.76.2022.06.30.06.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 06:05:45 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Rajendra Nayak <quic_rjendra@quicinc.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v7 1/4] dt-bindings: interconnect: qcom,msm8998-cpu-bwmon: add BWMON device
Date:   Thu, 30 Jun 2022 15:05:38 +0200
Message-Id: <20220630130541.563001-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220630130541.563001-1-krzysztof.kozlowski@linaro.org>
References: <20220630130541.563001-1-krzysztof.kozlowski@linaro.org>
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

