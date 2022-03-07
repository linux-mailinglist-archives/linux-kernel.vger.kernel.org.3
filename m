Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 829BF4CF22A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 07:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235519AbiCGGqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 01:46:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234325AbiCGGqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 01:46:42 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9221560049
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 22:45:48 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id e13so12928896plh.3
        for <linux-kernel@vger.kernel.org>; Sun, 06 Mar 2022 22:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rciQvAdJAp0wrAJqlzPMAqWlc/W/aINkrwMy8JhMIqo=;
        b=v9zmeOjOXqd6A+THRKPCA5156dw0B/TgfqvxUnreRlNEEpvCLldrX90bCAXEEx17C7
         3c8BfsQVMExrdiNmewW20zwqs3i1ZlP0kN34k7lcOcyp6jwUcZpgoRljCybxyyo5ztte
         ElSSwSCSI/gfUopxe84JfxeckpNijlFoAx7rRXwxbspMdh0iIET/5yv2vbgbZ/7DnmC6
         czH+yIu2o5ejTcWuL7C/GI0KiDCJTv0lpzzfiBw821f01VZMh825k8IE81EiYszlDgQG
         9bgYgm+46piTfec1udyGAPhdOGQ1y1zSo2kfcz4njBDatOJpqME30zC6JQj3W3B0vjds
         /qkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rciQvAdJAp0wrAJqlzPMAqWlc/W/aINkrwMy8JhMIqo=;
        b=5eSTnUmjYvGNaccpLRU+i0zupCG7tXhFGkYc7aDIlXVCCY1dCs1vuVO9xPz6JHzdNG
         D9Zl5vrkRDVU7dNx9JiTVqxbtYXTMTLg5XMpLzktjdpeiqE3m36/JHVQRwPXjlJU8/Oc
         S0+61Jascqe9t65jGXvG5MMuMg/xwrkhWjMUs6ZVE0ih7RDQs3yq/pxl1FgnZOS+v1up
         zp3jH6hoCQeH+yTgL3k7DImEWmx1bNm3r4Eq1qTIimutZlkQqcZBo/kCABZSBvtpWGPD
         CoduPFYpY1YDj0iq/c8qegO8esChP3ScgZFlzSIoNtMiuqWog+pNLu6Lqqp+obmHzPxX
         3IdQ==
X-Gm-Message-State: AOAM5325BpTkIAORvdn5VSOeLFYOzu6MSyWYK6AbcxnpSo4Esiy5wYx3
        saQjzAKCDftsmyE9FzQJUTU3
X-Google-Smtp-Source: ABdhPJxilUwLasF6c4NRwnyi8wdmFSt+i8aQBYX5gMYzf2RBhd6yIJabVZTugkZ1Y+a9XYWfSOmiMA==
X-Received: by 2002:a17:902:b189:b0:14d:6f87:7c25 with SMTP id s9-20020a170902b18900b0014d6f877c25mr10896202plr.31.1646635547979;
        Sun, 06 Mar 2022 22:45:47 -0800 (PST)
Received: from localhost.localdomain ([117.207.25.157])
        by smtp.gmail.com with ESMTPSA id s7-20020a056a00178700b004e1a15e7928sm15841940pfg.145.2022.03.06.22.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Mar 2022 22:45:47 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     rafael@kernel.org, viresh.kumar@linaro.org, robh+dt@kernel.org
Cc:     bjorn.andersson@linaro.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        angelogioacchino.delregno@somainline.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH 1/2] dt-bindings: cpufreq: cpufreq-qcom-hw: Convert to YAML bindings
Date:   Mon,  7 Mar 2022 12:15:30 +0530
Message-Id: <20220307064531.47678-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220307064531.47678-1-manivannan.sadhasivam@linaro.org>
References: <20220307064531.47678-1-manivannan.sadhasivam@linaro.org>
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

