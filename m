Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 448B24D3193
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 16:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233796AbiCIPRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 10:17:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233788AbiCIPQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 10:16:59 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B1717C40E
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 07:16:00 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id mg21-20020a17090b371500b001bef9e4657cso5623106pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 07:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rciQvAdJAp0wrAJqlzPMAqWlc/W/aINkrwMy8JhMIqo=;
        b=ED+yNXi4oeOjs7ITHh0+g9CPgBp+OpGArvGcEHd6GbINOEFionCdePxKU9THhrgTqH
         LlanP3qKRrAz8r9QruI+H4VPES49KaFSnE4GzeWv2r4ox7MGgWYIJJ2ZjxmI6T4CfKW+
         C612Rw1SycX292Uky0GOL5lTZiM12O3hTh1xnLCjgyT6vo4b2X+JLMqKko3qFGnNq6jr
         Pwf2YFvBJPZsxjmFsHewjEKFooz0mtuzA8kC5uvp0TdlOiJ/L2OfLQFiW66sh+fANAsU
         5o+Fv8i0Z59byJ4kMpxjptUWA9pS/HLgspIygW4Kl+aM9IegnaVUxxCPrFQ5u2sFGZth
         EA8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rciQvAdJAp0wrAJqlzPMAqWlc/W/aINkrwMy8JhMIqo=;
        b=YHRJVusTOZc2+kPmJXWGLIGYLSj/4wpTLlTZ4arwWe3HQrg5wY/6liDgoNdX8K2xKi
         zPFPeD+xFzi/TKnAYRsFqeIKfaAWf/mxrBZFqMRjYAI5VwhNwnZiT1kcTyp8yHxudWc4
         stI1ypPuSmF1OcVAzM/fweiayMowsExSyy9/0a7bwMn0UQT5cjJmGSL8bTMvkRyfZ4ZZ
         chDrOx3A4B8qgF4vqo5x7JyjGb2gYUM/W54P4fmB7FSZo2e8m4bDyxy5FLGzCBfWdtwv
         Y6IDVCGIdL5tCkC9CzdqaXofZwUn+VYzdj3dFeWQsQUixY7nsj3BMJuU/58sK6j8hlC4
         7vqQ==
X-Gm-Message-State: AOAM532hLcEvEpQjte37Qq2j+ByGAFejpNOVlfLrILKKr6j4T5nN7v1O
        RUdc2A3xdpK26hPMqQ8itJRg
X-Google-Smtp-Source: ABdhPJyQJsUKyOGW1OljUtM5c4vqK4LQd/rsyVO8jcuiIy4W2GPXfIlCVpAnW8+kaK7e7cUOI3ri6A==
X-Received: by 2002:a17:902:ed82:b0:151:d081:3832 with SMTP id e2-20020a170902ed8200b00151d0813832mr22574663plj.165.1646838959468;
        Wed, 09 Mar 2022 07:15:59 -0800 (PST)
Received: from localhost.localdomain ([117.193.208.22])
        by smtp.gmail.com with ESMTPSA id p25-20020a637419000000b0037fa57520adsm2727425pgc.27.2022.03.09.07.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 07:15:59 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     rafael@kernel.org, viresh.kumar@linaro.org, robh+dt@kernel.org,
        krzk+dt@kernel.org
Cc:     bjorn.andersson@linaro.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        angelogioacchino.delregno@somainline.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 2/2] dt-bindings: cpufreq: cpufreq-qcom-hw: Convert to YAML bindings
Date:   Wed,  9 Mar 2022 20:45:41 +0530
Message-Id: <20220309151541.139511-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220309151541.139511-1-manivannan.sadhasivam@linaro.org>
References: <20220309151541.139511-1-manivannan.sadhasivam@linaro.org>
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

Convert Qualcomm cpufreq devicetree binding to YAML.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../bindings/cpufreq/cpufreq-qcom-hw.txt      | 172 ---------------
 .../bindings/cpufreq/cpufreq-qcom-hw.yaml     | 201 ++++++++++++++++++
 2 files changed, 201 insertions(+), 172 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
 create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml

diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
deleted file mode 100644
index 9299028ee712..000000000000
--- a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
+++ /dev/null
@@ -1,172 +0,0 @@
-Qualcomm Technologies, Inc. CPUFREQ Bindings
-
-CPUFREQ HW is a hardware engine used by some Qualcomm Technologies, Inc. (QTI)
-SoCs to manage frequency in hardware. It is capable of controlling frequency
-for multiple clusters.
-
-Properties:
-- compatible
-	Usage:		required
-	Value type:	<string>
-	Definition:	must be "qcom,cpufreq-hw" or "qcom,cpufreq-epss".
-
-- clocks
-	Usage:		required
-	Value type:	<phandle> From common clock binding.
-	Definition:	clock handle for XO clock and GPLL0 clock.
-
-- clock-names
-	Usage:		required
-	Value type:	<string> From common clock binding.
-	Definition:	must be "xo", "alternate".
-
-- reg
-	Usage:		required
-	Value type:	<prop-encoded-array>
-	Definition:	Addresses and sizes for the memory of the HW bases in
-			each frequency domain.
-- reg-names
-	Usage:		Optional
-	Value type:	<string>
-	Definition:	Frequency domain name i.e.
-			"freq-domain0", "freq-domain1".
-
-- #freq-domain-cells:
-	Usage:		required.
-	Definition:	Number of cells in a freqency domain specifier.
-
-* Property qcom,freq-domain
-Devices supporting freq-domain must set their "qcom,freq-domain" property with
-phandle to a cpufreq_hw followed by the Domain ID(0/1) in the CPU DT node.
-
-
-Example:
-
-Example 1: Dual-cluster, Quad-core per cluster. CPUs within a cluster switch
-DCVS state together.
-
-/ {
-	cpus {
-		#address-cells = <2>;
-		#size-cells = <0>;
-
-		CPU0: cpu@0 {
-			device_type = "cpu";
-			compatible = "qcom,kryo385";
-			reg = <0x0 0x0>;
-			enable-method = "psci";
-			next-level-cache = <&L2_0>;
-			qcom,freq-domain = <&cpufreq_hw 0>;
-			L2_0: l2-cache {
-				compatible = "cache";
-				next-level-cache = <&L3_0>;
-				L3_0: l3-cache {
-				      compatible = "cache";
-				};
-			};
-		};
-
-		CPU1: cpu@100 {
-			device_type = "cpu";
-			compatible = "qcom,kryo385";
-			reg = <0x0 0x100>;
-			enable-method = "psci";
-			next-level-cache = <&L2_100>;
-			qcom,freq-domain = <&cpufreq_hw 0>;
-			L2_100: l2-cache {
-				compatible = "cache";
-				next-level-cache = <&L3_0>;
-			};
-		};
-
-		CPU2: cpu@200 {
-			device_type = "cpu";
-			compatible = "qcom,kryo385";
-			reg = <0x0 0x200>;
-			enable-method = "psci";
-			next-level-cache = <&L2_200>;
-			qcom,freq-domain = <&cpufreq_hw 0>;
-			L2_200: l2-cache {
-				compatible = "cache";
-				next-level-cache = <&L3_0>;
-			};
-		};
-
-		CPU3: cpu@300 {
-			device_type = "cpu";
-			compatible = "qcom,kryo385";
-			reg = <0x0 0x300>;
-			enable-method = "psci";
-			next-level-cache = <&L2_300>;
-			qcom,freq-domain = <&cpufreq_hw 0>;
-			L2_300: l2-cache {
-				compatible = "cache";
-				next-level-cache = <&L3_0>;
-			};
-		};
-
-		CPU4: cpu@400 {
-			device_type = "cpu";
-			compatible = "qcom,kryo385";
-			reg = <0x0 0x400>;
-			enable-method = "psci";
-			next-level-cache = <&L2_400>;
-			qcom,freq-domain = <&cpufreq_hw 1>;
-			L2_400: l2-cache {
-				compatible = "cache";
-				next-level-cache = <&L3_0>;
-			};
-		};
-
-		CPU5: cpu@500 {
-			device_type = "cpu";
-			compatible = "qcom,kryo385";
-			reg = <0x0 0x500>;
-			enable-method = "psci";
-			next-level-cache = <&L2_500>;
-			qcom,freq-domain = <&cpufreq_hw 1>;
-			L2_500: l2-cache {
-				compatible = "cache";
-				next-level-cache = <&L3_0>;
-			};
-		};
-
-		CPU6: cpu@600 {
-			device_type = "cpu";
-			compatible = "qcom,kryo385";
-			reg = <0x0 0x600>;
-			enable-method = "psci";
-			next-level-cache = <&L2_600>;
-			qcom,freq-domain = <&cpufreq_hw 1>;
-			L2_600: l2-cache {
-				compatible = "cache";
-				next-level-cache = <&L3_0>;
-			};
-		};
-
-		CPU7: cpu@700 {
-			device_type = "cpu";
-			compatible = "qcom,kryo385";
-			reg = <0x0 0x700>;
-			enable-method = "psci";
-			next-level-cache = <&L2_700>;
-			qcom,freq-domain = <&cpufreq_hw 1>;
-			L2_700: l2-cache {
-				compatible = "cache";
-				next-level-cache = <&L3_0>;
-			};
-		};
-	};
-
- soc {
-	cpufreq_hw: cpufreq@17d43000 {
-		compatible = "qcom,cpufreq-hw";
-		reg = <0x17d43000 0x1400>, <0x17d45800 0x1400>;
-		reg-names = "freq-domain0", "freq-domain1";
-
-		clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
-		clock-names = "xo", "alternate";
-
-		#freq-domain-cells = <1>;
-	};
-}
diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
new file mode 100644
index 000000000000..2f1b8b6852a0
--- /dev/null
+++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
@@ -0,0 +1,201 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/cpufreq/cpufreq-qcom-hw.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Technologies, Inc. CPUFREQ
+
+maintainers:
+  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+
+description: |
+
+  CPUFREQ HW is a hardware engine used by some Qualcomm Technologies, Inc. (QTI)
+  SoCs to manage frequency in hardware. It is capable of controlling frequency
+  for multiple clusters.
+
+properties:
+  compatible:
+    oneOf:
+      - description: v1 of CPUFREQ HW
+        items:
+          - const: qcom,cpufreq-hw
+
+      - description: v2 of CPUFREQ HW (EPSS)
+        items:
+          - enum:
+              - qcom,sm8250-cpufreq-epss
+          - const: qcom,cpufreq-epss
+
+  reg:
+    minItems: 2
+    items:
+      - description: Frequency domain 0 register region
+      - description: Frequency domain 1 register region
+      - description: Frequency domain 2 register region
+
+  reg-names:
+    minItems: 2
+    items:
+      - const: freq-domain0
+      - const: freq-domain1
+      - const: freq-domain2
+
+  clocks:
+    items:
+      - description: XO Clock
+      - description: GPLL0 Clock
+
+  clock-names:
+    items:
+      - const: xo
+      - const: alternate
+
+  '#freq-domain-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - '#freq-domain-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,gcc-sdm845.h>
+    #include <dt-bindings/clock/qcom,rpmh.h>
+
+    // Example 1: Dual-cluster, Quad-core per cluster. CPUs within a cluster
+    // switch DCVS state together.
+    cpus {
+      #address-cells = <2>;
+      #size-cells = <0>;
+
+      CPU0: cpu@0 {
+        device_type = "cpu";
+        compatible = "qcom,kryo385";
+        reg = <0x0 0x0>;
+        enable-method = "psci";
+        next-level-cache = <&L2_0>;
+        qcom,freq-domain = <&cpufreq_hw 0>;
+        L2_0: l2-cache {
+          compatible = "cache";
+          next-level-cache = <&L3_0>;
+          L3_0: l3-cache {
+            compatible = "cache";
+          };
+        };
+      };
+
+      CPU1: cpu@100 {
+        device_type = "cpu";
+        compatible = "qcom,kryo385";
+        reg = <0x0 0x100>;
+        enable-method = "psci";
+        next-level-cache = <&L2_100>;
+        qcom,freq-domain = <&cpufreq_hw 0>;
+        L2_100: l2-cache {
+          compatible = "cache";
+          next-level-cache = <&L3_0>;
+        };
+      };
+
+      CPU2: cpu@200 {
+        device_type = "cpu";
+        compatible = "qcom,kryo385";
+        reg = <0x0 0x200>;
+        enable-method = "psci";
+        next-level-cache = <&L2_200>;
+        qcom,freq-domain = <&cpufreq_hw 0>;
+        L2_200: l2-cache {
+          compatible = "cache";
+          next-level-cache = <&L3_0>;
+        };
+      };
+
+      CPU3: cpu@300 {
+        device_type = "cpu";
+        compatible = "qcom,kryo385";
+        reg = <0x0 0x300>;
+        enable-method = "psci";
+        next-level-cache = <&L2_300>;
+        qcom,freq-domain = <&cpufreq_hw 0>;
+        L2_300: l2-cache {
+          compatible = "cache";
+          next-level-cache = <&L3_0>;
+        };
+      };
+
+      CPU4: cpu@400 {
+        device_type = "cpu";
+        compatible = "qcom,kryo385";
+        reg = <0x0 0x400>;
+        enable-method = "psci";
+        next-level-cache = <&L2_400>;
+        qcom,freq-domain = <&cpufreq_hw 1>;
+        L2_400: l2-cache {
+          compatible = "cache";
+          next-level-cache = <&L3_0>;
+        };
+      };
+
+      CPU5: cpu@500 {
+        device_type = "cpu";
+        compatible = "qcom,kryo385";
+        reg = <0x0 0x500>;
+        enable-method = "psci";
+        next-level-cache = <&L2_500>;
+        qcom,freq-domain = <&cpufreq_hw 1>;
+        L2_500: l2-cache {
+          compatible = "cache";
+          next-level-cache = <&L3_0>;
+        };
+      };
+
+      CPU6: cpu@600 {
+        device_type = "cpu";
+        compatible = "qcom,kryo385";
+        reg = <0x0 0x600>;
+        enable-method = "psci";
+        next-level-cache = <&L2_600>;
+        qcom,freq-domain = <&cpufreq_hw 1>;
+        L2_600: l2-cache {
+          compatible = "cache";
+          next-level-cache = <&L3_0>;
+        };
+      };
+
+      CPU7: cpu@700 {
+        device_type = "cpu";
+        compatible = "qcom,kryo385";
+        reg = <0x0 0x700>;
+        enable-method = "psci";
+        next-level-cache = <&L2_700>;
+        qcom,freq-domain = <&cpufreq_hw 1>;
+        L2_700: l2-cache {
+          compatible = "cache";
+          next-level-cache = <&L3_0>;
+        };
+      };
+    };
+
+    soc {
+      #address-cells = <1>;
+      #size-cells = <1>;
+
+      cpufreq@17d43000 {
+        compatible = "qcom,cpufreq-hw";
+        reg = <0x17d43000 0x1400>, <0x17d45800 0x1400>;
+        reg-names = "freq-domain0", "freq-domain1";
+
+        clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
+        clock-names = "xo", "alternate";
+
+        #freq-domain-cells = <1>;
+      };
+    };
+...
-- 
2.25.1

