Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6C55538F46
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 12:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343598AbiEaKwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 06:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343573AbiEaKwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 06:52:01 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B644DF72
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 03:51:59 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id n28so8139047edb.9
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 03:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p7mIRFKlf7mUQrcHty6Iw1fiOYErDnQJ/9BxNwewsYs=;
        b=TiHu58MJlYhDvueuzEoHjnSpR3Ya+RJjug8dDTTt9WjVthO56N67D8UITUHAQInfyf
         x5nP4VMVucwgsYbu7uoh9+CTyGV3uuTHUUuFKKE/dmrf9iWu1qBG2r3hliuSuqRSdQmG
         YD2OXZ0pvFK3DODLBfIVTW1xBKHdOuOrcsrHBZWdi0gK4eGOHTzQnlWxwGFdOzTrbQ0g
         Sj80Bl4LQgiiIr/TGn5oBSQK+ak7bcQnGqqJMWWFUWHdAvtPUs2yG2KZTcUzw893ouol
         C5UVNlrPYxSoqPmaJ75K0VzyIJ8KwnG/D8kEj8hPrdB3G2HWdCqbDt0iYVBm0tO+ElRA
         +31g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p7mIRFKlf7mUQrcHty6Iw1fiOYErDnQJ/9BxNwewsYs=;
        b=4XYzxHtslBkk1d+JD4Ha1nUJ12yb+/MwdC3IR+9O3qRgl+x2gCKqr6RtTPIe9W8ous
         WZDlCgT4lELy56h/o1jHhB6GoGRfDVU9D8r88RjAouZAuEMV5T6WiRrBWa9zw4II7VZ/
         OkUK/1LBBwkHzFQsgD+awOA6X4LjvYAI0Zd/vn2HxbKmLzdKh09auNcW3fxXodn1QQcq
         dHQ8CoTcgCH1s+gIbesCXTCBBQDs8ZQF3k0AdSa3GKIqtX4HsDMlEtXM4mZ5ArLYaVX+
         mbcccnHO7iXPTHXju9eErVKZpgOsfZsbikVlzlpCwM08zPIwakcJE1H4bMJk6oIsOFj6
         niuw==
X-Gm-Message-State: AOAM531CqcrQ2fBHWHN+9N2N0/VjxAmn/pawDFzY4q2FwJSXVehK/6jW
        mzOWFaqljjVd2ym6pPhEg+gBfw==
X-Google-Smtp-Source: ABdhPJwbV5+sW0Qx8vGQ9DlloXkTdOIz0AFgs5SvDYPE7n9AHH/lMowZnogwo+2y/mLUoHVo2QoiZQ==
X-Received: by 2002:a05:6402:4c1:b0:42b:e03f:d940 with SMTP id n1-20020a05640204c100b0042be03fd940mr25357406edw.235.1653994318019;
        Tue, 31 May 2022 03:51:58 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id q3-20020a50aa83000000b0042dc513ced8sm5117441edc.30.2022.05.31.03.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 03:51:57 -0700 (PDT)
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
Cc:     Rob Herring <robh@kernel.org>
Subject: [PATCH v3 1/4] dt-bindings: interconnect: qcom,sdm845-cpu-bwmon: add BWMON device
Date:   Tue, 31 May 2022 12:51:34 +0200
Message-Id: <20220531105137.110050-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220531105137.110050-1-krzysztof.kozlowski@linaro.org>
References: <20220531105137.110050-1-krzysztof.kozlowski@linaro.org>
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
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Georgi Djakov <djakov@kernel.org>
---
 .../interconnect/qcom,sdm845-cpu-bwmon.yaml   | 97 +++++++++++++++++++
 1 file changed, 97 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sdm845-cpu-bwmon.yaml

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sdm845-cpu-bwmon.yaml b/Documentation/devicetree/bindings/interconnect/qcom,sdm845-cpu-bwmon.yaml
new file mode 100644
index 000000000000..8c82e06ee432
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/qcom,sdm845-cpu-bwmon.yaml
@@ -0,0 +1,97 @@
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
+            };
+            opp-1 {
+                opp-peak-kBps = <1804000 9216000>;
+            };
+            opp-2 {
+                opp-peak-kBps = <2188000 11980800>;
+            };
+            opp-3 {
+                opp-peak-kBps = <3072000 15052800>;
+            };
+            opp-4 {
+                opp-peak-kBps = <4068000 19353600>;
+            };
+            opp-5 {
+                opp-peak-kBps = <5412000 20889600>;
+            };
+            opp-6 {
+                opp-peak-kBps = <6220000 22425600>;
+            };
+            opp-7 {
+                opp-peak-kBps = <7216000 25497600>;
+            };
+        };
+    };
-- 
2.34.1

