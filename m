Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A743A519987
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 10:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346112AbiEDIVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 04:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241377AbiEDIVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 04:21:30 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C811F22B3D
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 01:17:54 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id k23so1434400ejd.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 01:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=1W5zUO25QYJDYm48XI9iv2r7F+nu9wTwCVMIXiaenyo=;
        b=AnH3ACHHLHKCqPb13Hp6YRMchU54LJEvxcWMCoI9vjzz1yCYI4gQfh5S+3oYVxr5re
         SLOfeAdN+jv7XzXYLJg9Os6O4sj/N1RHGF1fKUVhjI3Q9j1fYSomFkW/FEKWSYJAYzIO
         5Nbhhq3H0DiwHu2Zkz+lMdoBWKQqQFtgq8qsG+OEayhZVYnyF3NuXDuYAeJPCNSIK5SJ
         l/MYvB7FUwevjtCogMtgzQ9VlBzv2FXSXUWLfFBUDR8goKacIuVvMIpyW6CKT4WY32at
         a7Zpd87Vmts2rXyUVM2sMl15qxAkECGM8V5BtYPY5fUmLWUP9dI6NdJEKaIVBxmRKqlJ
         GBEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1W5zUO25QYJDYm48XI9iv2r7F+nu9wTwCVMIXiaenyo=;
        b=ZL66CEUDMXSmdNvDBsLnnzMLpNUkA79Zodj8zsQpHNDJ8jShXaaxFwTwWQu6dQgjzo
         fQzQ3f8XusUZLlSG5QjWhddldizX1py5yLJtgSBKcuOggrBfPx8rIgfaraffbpJ8gee3
         jmnHiGcpHXw1qV2LT4kSLb9bR/s8eHFO/H7qQ+tVYaF0Na2EvjAm4X4jJiLy0gcSxPbh
         sKVXQGwqtxW3F2ukxCsk+rtaQFk/ic1q2eD5gZY7GxU2hV6+gbSik8W9Qgj7T8UoISLC
         MJA+h4xsuxy1NdXCJOdwxfymvAoceTPwWVaJ276QSdEh/6Dlg4Bb7kbXyEaiIAZkj4bb
         w5Bg==
X-Gm-Message-State: AOAM530WADeG1nDUfGpBFTRWWGvdQ5+0r7Tey/7fspX1yA73G9S84bpN
        ydSASl3KdjRwkst8qTSDqrBWVw==
X-Google-Smtp-Source: ABdhPJyR1lGPKevDA5qYJ2mBO6xjsfONj9uDdDKmoU2szHLDEMfGWXshn2HSEq1OggSQXcRxGUBZ9Q==
X-Received: by 2002:a17:907:7f8d:b0:6da:b3d6:a427 with SMTP id qk13-20020a1709077f8d00b006dab3d6a427mr18441879ejc.509.1651652273261;
        Wed, 04 May 2022 01:17:53 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id l21-20020a056402345500b0042617ba6393sm8781322edc.29.2022.05.04.01.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 01:17:52 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 1/5] dt-bindings: interconnect: qcom,sdm845-cpu-bwmon: add BWMON device
Date:   Wed,  4 May 2022 10:17:31 +0200
Message-Id: <20220504081735.26906-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220504081735.26906-1-krzysztof.kozlowski@linaro.org>
References: <20220504081735.26906-1-krzysztof.kozlowski@linaro.org>
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
performance data on interconnects.  The bindings describe only BWMON
version 4, e.g. the instance on SDM845 between CPU and Last Level Cache
Controller.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../interconnect/qcom,sdm845-cpu-bwmon.yaml   | 105 ++++++++++++++++++
 1 file changed, 105 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sdm845-cpu-bwmon.yaml

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sdm845-cpu-bwmon.yaml b/Documentation/devicetree/bindings/interconnect/qcom,sdm845-cpu-bwmon.yaml
new file mode 100644
index 000000000000..c9b68ca87548
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/qcom,sdm845-cpu-bwmon.yaml
@@ -0,0 +1,105 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interconnect/qcom,sdm845-cpu-bwmon.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Interconnect Bandwidth Monitor
+
+maintainers:
+  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+
+description:
+  Bandwidth Monitor measures current throughput on buses between various NoC
+  fabrics and provides information when it crosses configured thresholds.
+
+properties:
+  compatible:
+    enum:
+      - qcom,sdm845-cpu-bwmon       # BWMON v4
+
+  interconnects:
+    maxItems: 2
+
+  interconnect-names:
+    items:
+      - const: ddr
+      - const: l3c
+
+  interrupts:
+    maxItems: 1
+
+  operating-points-v2: true
+  opp-table: true
+
+  reg:
+    # Currently described BWMON v4 and v5 use one register address space.
+    # BWMON v2 uses two register spaces - not yet described.
+    maxItems: 1
+
+required:
+  - compatible
+  - interconnects
+  - interconnect-names
+  - interrupts
+  - operating-points-v2
+  - opp-table
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interconnect/qcom,osm-l3.h>
+    #include <dt-bindings/interconnect/qcom,sdm845.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    pmu@1436400 {
+        compatible = "qcom,sdm845-cpu-bwmon";
+        reg = <0x01436400 0x600>;
+
+        interrupts = <GIC_SPI 581 IRQ_TYPE_LEVEL_HIGH>;
+
+        interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc SLAVE_EBI1 3>,
+                        <&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
+        interconnect-names = "ddr", "l3c";
+
+        operating-points-v2 = <&cpu_bwmon_opp_table>;
+
+        cpu_bwmon_opp_table: opp-table {
+            compatible = "operating-points-v2";
+
+            opp-0 {
+                opp-peak-kBps = <800000 4800000>;
+                opp-avg-kBps = <800000 4800000>;
+            };
+            opp-1 {
+                opp-peak-kBps = <1804000 9216000>;
+                opp-avg-kBps = <1804000 9216000>;
+            };
+            opp-2 {
+                opp-peak-kBps = <2188000 11980800>;
+                opp-avg-kBps = <2188000 11980800>;
+            };
+            opp-3 {
+                opp-peak-kBps = <3072000 15052800>;
+                opp-avg-kBps = <3072000 15052800>;
+            };
+            opp-4 {
+                opp-peak-kBps = <4068000 19353600>;
+                opp-avg-kBps = <4068000 19353600>;
+            };
+            opp-5 {
+                opp-peak-kBps = <5412000 20889600>;
+                opp-avg-kBps = <5412000 20889600>;
+            };
+            opp-6 {
+                opp-peak-kBps = <6220000 22425600>;
+                opp-avg-kBps = <6220000 22425600>;
+            };
+            opp-7 {
+                opp-peak-kBps = <7216000 25497600>;
+                opp-avg-kBps = <7216000 25497600>;
+            };
+        };
+    };
-- 
2.32.0

