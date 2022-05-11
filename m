Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD03952386F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 18:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344517AbiEKQQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 12:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344539AbiEKQQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 12:16:38 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED93C25EA6;
        Wed, 11 May 2022 09:16:36 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id i17so2330748pla.10;
        Wed, 11 May 2022 09:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O0GO+ft+dwHvfJoPa2fsL+9iF5dCZRWn0oUcpqa+NiI=;
        b=hJuXKP0T/GR4yux3rKVcFrAcR7q42Y6juLDK3dZM/v/ZrqbI4jpK7+9MUaHBnFB++s
         cEAwdW91cEyAT21Tf18d/m7Vik86d3zNW1akWQWbQT40s+fdSdIc0CYxU5HpkYScq81o
         dy53mk+pqhcveWb6dcQGmWKLSnz/qN/Idd39yISnE9v8TmzcZe3gACD7UQYOw6OwDhur
         S0op+DpIaRmTyWVO91VekFTbbXa+b9IQuZQ4SjvIfHq7HVqjbKyZYo2S1zNOFCVx+zT9
         Ff/LAp5CB1djypR2VCQY9Ao2JqwRcnoqxOuaI55Jw+yLR5N/GHQJxA53eo2uUFraJt1n
         cfaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O0GO+ft+dwHvfJoPa2fsL+9iF5dCZRWn0oUcpqa+NiI=;
        b=jbuRDD9rXkD9AjczvO3ylMjEBxU/KxngnzJlpVGJWV1Ho4Z1RulmaIkRPTyUhwTVYo
         avJp/VCOjNiq3ASpNl6ufBd5sCLpi/GMR5dAq4n9isjC+ncvJodfNQiRYFNep41ejoEl
         akyTjzaEgfNlH9HX2O23ozGYnXuRLQJXmx2+VFjQPoOcjRZFy9Lj/j4Yg8/q1vSyb1WR
         +WS/zh3VH46jJbY4rSsuSFMev+/17AbCKPFOwV1Bu2ujycvuu9ZJ6JnnyGmvXlLP0WGr
         c6PjH5IAkzXD9OvY4uZCVz+vVvF6CI9XicUBnnXPMD5kMMHUwPw3byF557y0BOltRSQA
         Y4tA==
X-Gm-Message-State: AOAM5330BVWXYgIlLHxXID7aNwxY7teYSvYm+9HXdn9ahbE0gQ8z++oT
        Lq8NH13cjN6jtLzgMSE18Wvv/iJKU1+R/dwG
X-Google-Smtp-Source: ABdhPJxUfrSydVREGklb+OjGERB2cu+ozjNkalIW0YfG1YndSusBz9Fm6eUW7y9coflsK68+bRsgtA==
X-Received: by 2002:a17:90a:4413:b0:1cd:2d00:9d0b with SMTP id s19-20020a17090a441300b001cd2d009d0bmr6116311pjg.81.1652285795995;
        Wed, 11 May 2022 09:16:35 -0700 (PDT)
Received: from skynet-linux.local ([49.204.239.218])
        by smtp.googlemail.com with ESMTPSA id x7-20020a17090a1f8700b001ded49491basm220322pja.2.2022.05.11.09.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 09:16:35 -0700 (PDT)
From:   Sireesh Kodali <sireeshkodali1@gmail.com>
To:     linux-remoteproc@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, phone-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sireesh Kodali <sireeshkodali1@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: [PATCH 4/9] dt-bindings: remoteproc: qcom: wcnss: Convert to YAML
Date:   Wed, 11 May 2022 21:45:57 +0530
Message-Id: <20220511161602.117772-5-sireeshkodali1@gmail.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220511161602.117772-1-sireeshkodali1@gmail.com>
References: <20220511161602.117772-1-sireeshkodali1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the dt-bindings from txt to YAML. This is in preparation for
including the relevant bindings for the MSM8953 platform's wcnss pil.

Signed-off-by: Sireesh Kodali <sireeshkodali1@gmail.com>
---
 .../bindings/remoteproc/qcom,wcnss-pil.txt    | 177 --------------
 .../bindings/remoteproc/qcom,wcnss-pil.yaml   | 228 ++++++++++++++++++
 2 files changed, 228 insertions(+), 177 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.txt
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.txt b/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.txt
deleted file mode 100644
index a83080b8905c..000000000000
--- a/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.txt
+++ /dev/null
@@ -1,177 +0,0 @@
-Qualcomm WCNSS Peripheral Image Loader
-
-This document defines the binding for a component that loads and boots firmware
-on the Qualcomm WCNSS core.
-
-- compatible:
-	Usage: required
-	Value type: <string>
-	Definition: must be one of:
-		    "qcom,riva-pil",
-		    "qcom,pronto-v1-pil",
-		    "qcom,pronto-v2-pil"
-
-- reg:
-	Usage: required
-	Value type: <prop-encoded-array>
-	Definition: must specify the base address and size of the CCU, DXE and
-		    PMU register blocks
-
-- reg-names:
-	Usage: required
-	Value type: <stringlist>
-	Definition: must be "ccu", "dxe", "pmu"
-
-- interrupts-extended:
-	Usage: required
-	Value type: <prop-encoded-array>
-	Definition: must list the watchdog and fatal IRQs and may specify the
-		    ready, handover and stop-ack IRQs
-
-- interrupt-names:
-	Usage: required
-	Value type: <stringlist>
-	Definition: should be "wdog", "fatal", optionally followed by "ready",
-		    "handover", "stop-ack"
-
-- firmware-name:
-	Usage: optional
-	Value type: <string>
-	Definition: must list the relative firmware image path for the
-		    WCNSS core. Defaults to "wcnss.mdt".
-
-- vddmx-supply: (deprecated for qcom,pronto-v1/2-pil)
-- vddcx-supply: (deprecated for qcom,pronto-v1/2-pil)
-- vddpx-supply:
-	Usage: required
-	Value type: <phandle>
-	Definition: reference to the regulators to be held on behalf of the
-		    booting of the WCNSS core
-
-- power-domains:
-	Usage: required (for qcom,pronto-v1/2-pil)
-	Value type: <phandle>
-	Definition: reference to the power domains to be held on behalf of the
-		    booting of the WCNSS core
-
-- power-domain-names:
-	Usage: required (for qcom,pronto-v1/2-pil)
-	Value type: <stringlist>
-	Definition: must be "cx", "mx"
-
-- qcom,smem-states:
-	Usage: optional
-	Value type: <prop-encoded-array>
-	Definition: reference to the SMEM state used to indicate to WCNSS that
-		    it should shut down
-
-- qcom,smem-state-names:
-	Usage: optional
-	Value type: <stringlist>
-	Definition: should be "stop"
-
-- memory-region:
-	Usage: required
-	Value type: <prop-encoded-array>
-	Definition: reference to reserved-memory node for the remote processor
-		    see ../reserved-memory/reserved-memory.txt
-
-= SUBNODES
-A required subnode of the WCNSS PIL is used to describe the attached rf module
-and its resource dependencies. It is described by the following properties:
-
-- compatible:
-	Usage: required
-	Value type: <string>
-	Definition: must be one of:
-		    "qcom,wcn3620",
-		    "qcom,wcn3660",
-		    "qcom,wcn3660b",
-		    "qcom,wcn3680"
-
-- clocks:
-	Usage: required
-	Value type: <prop-encoded-array>
-	Definition: should specify the xo clock and optionally the rf clock
-
-- clock-names:
-	Usage: required
-	Value type: <stringlist>
-	Definition: should be "xo", optionally followed by "rf"
-
-- vddxo-supply:
-- vddrfa-supply:
-- vddpa-supply:
-- vdddig-supply:
-	Usage: required
-	Value type: <phandle>
-	Definition: reference to the regulators to be held on behalf of the
-		    booting of the WCNSS core
-
-
-The wcnss node can also have an subnode named "smd-edge" that describes the SMD
-edge, channels and devices related to the WCNSS.
-See ../soc/qcom/qcom,smd.txt for details on how to describe the SMD edge.
-
-= EXAMPLE
-The following example describes the resources needed to boot control the WCNSS,
-with attached WCN3680, as it is commonly found on MSM8974 boards.
-
-pronto@fb204000 {
-	compatible = "qcom,pronto-v2-pil";
-	reg = <0xfb204000 0x2000>, <0xfb202000 0x1000>, <0xfb21b000 0x3000>;
-	reg-names = "ccu", "dxe", "pmu";
-
-	interrupts-extended = <&intc 0 149 1>,
-			      <&wcnss_smp2p_slave 0 0>,
-			      <&wcnss_smp2p_slave 1 0>,
-			      <&wcnss_smp2p_slave 2 0>,
-			      <&wcnss_smp2p_slave 3 0>;
-	interrupt-names = "wdog", "fatal", "ready", "handover", "stop-ack";
-
-	power-domains = <&rpmpd MSM8974_VDDCX>, <&rpmpd MSM8974_VDDMX>;
-	power-domain-names = "cx", "mx";
-
-	vddpx-supply = <&pm8941_s3>;
-
-	qcom,smem-states = <&wcnss_smp2p_out 0>;
-	qcom,smem-state-names = "stop";
-
-	memory-region = <&wcnss_region>;
-
-	pinctrl-names = "default";
-	pinctrl-0 = <&wcnss_pin_a>;
-
-	iris {
-		compatible = "qcom,wcn3680";
-
-		clocks = <&rpmcc RPM_CXO_CLK_SRC>, <&rpmcc RPM_CXO_A2>;
-		clock-names = "xo", "rf";
-
-		vddxo-supply = <&pm8941_l6>;
-		vddrfa-supply = <&pm8941_l11>;
-		vddpa-supply = <&pm8941_l19>;
-		vdddig-supply = <&pm8941_s3>;
-	};
-
-	smd-edge {
-		interrupts = <0 142 1>;
-
-		qcom,ipc = <&apcs 8 17>;
-		qcom,smd-edge = <6>;
-		qcom,remote-pid = <4>;
-
-		label = "pronto";
-
-		wcnss {
-			compatible = "qcom,wcnss";
-			qcom,smd-channels = "WCNSS_CTRL";
-
-			qcom,mmio = <&pronto>;
-
-			bt {
-				compatible = "qcom,wcnss-bt";
-			};
-		};
-	};
-};
diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml
new file mode 100644
index 000000000000..d19f9f87a3e3
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml
@@ -0,0 +1,228 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/remoteproc/qcom,wcnss-pil.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm WCNSS Peripheral Image Loader
+
+maintainers:
+  - Bjorn Andersson <bjorn.andersson@linaro.org>
+
+description:
+  This document defines the binding for a component that loads and boots
+  firmware on the Qualcomm WCNSS core.
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - qcom,pronto-v2-pil
+          - enum:
+              - qcom,pronto
+      - items:
+          - enum:
+              - qcom,riva-pil
+              - qcom,pronto-v1-pil
+              - qcom,pronto-v2-pil
+
+  reg:
+    description: must specify the base address and size of the CCU, DXE and PMU
+      register blocks
+
+  reg-names:
+    items:
+      - const: ccu
+      - const: dxe
+      - const: pmu
+
+  interrupts-extended:
+    description:
+      Interrupt lines
+    minItems: 2
+    maxItems: 5
+
+  interrupt-names:
+    minItems: 2
+    maxItems: 5
+
+  firmware-name:
+    $ref: /schemas/types.yaml#/definitions/string
+    description: Relative firmware image path for the WCNSS core. Defaults to
+      "wcnss.mdt".
+
+  vddpx-supply:
+    description: Reference to the PX regulator to be held on behalf of the
+      booting of the WCNSS core
+
+  vddmx-supply:
+    description: Reference to the MX regulator to be held on behalf of the
+      booting of the WCNSS core.
+
+  vddcx-supply:
+    description: Reference to the CX regulator to be held on behalf of the
+      booting of the WCNSS core.
+
+  power-domains:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description: References to the power domains that need to be held on
+      behalf of the booting WCNSS core
+
+  power-domain-names:
+    $ref: /schemas/types.yaml#/definitions/string-array
+    description: Names of the power domains
+    items:
+      - const: cx
+      - const: mx
+
+  qcom,smem-states:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description: States used by the AP to signal the WCNSS core that it should
+      shutdown
+    items:
+      - description: Stop the modem
+
+  qcom,smem-state-names:
+    $ref: /schemas/types.yaml#/definitions/string-array
+    description: The names of the state bits used for SMP2P output
+    items:
+      - const: stop
+
+  memory-region:
+    maxItems: 1
+    description: Reference to the reserved-memory for the WCNSS core
+
+  smd-edge:
+    type: object
+    description:
+      Qualcomm Shared Memory subnode which represents communication edge,
+      channels and devices related to the ADSP.
+
+  iris:
+    type: object
+    description:
+      The iris subnode of the WCNSS PIL is used to describe the attached rf module
+      and its resource dependencies.
+
+    properties:
+      compatible:
+        enum:
+          - qcom,wcn3620
+          - qcom,wcn3660
+          - qcom,wcn3660b
+          - qcom,wcn3680
+
+      clocks:
+        description: XO clock
+
+      clock-names:
+        items:
+          - const: xo
+
+    required:
+      - compatible
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - interrupts-extended
+  - interrupt-names
+  - vddpx-supply
+  - memory-region
+  - smd-edge
+  - iris
+
+additionalProperties: false
+
+if:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - qcom,pronto-v1-pil
+          - qcom,pronto-v2-pil
+then:
+  properties:
+    vddmx-supply:
+      deprecated: true
+      description: Deprecated for qcom,pronto-v1/2-pil
+
+    vddcx-supply:
+      deprecated: true
+      description: Deprecated for qcom,pronto-v1/2-pil
+
+  required:
+    - power-domains
+    - power-domain-names
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/qcom,rpmcc.h>
+    #include <dt-bindings/power/qcom-rpmpd.h>
+    pronto@a21b000 {
+        compatible = "qcom,pronto-v2-pil";
+        reg = <0x0a204000 0x2000>, <0x0a202000 0x1000>, <0x0a21b000 0x3000>;
+        reg-names = "ccu", "dxe", "pmu";
+
+        interrupts-extended = <&intc GIC_SPI 149 IRQ_TYPE_EDGE_RISING>,
+                              <&wcnss_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
+                              <&wcnss_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
+                              <&wcnss_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
+                              <&wcnss_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
+        interrupt-names = "wdog", "fatal", "ready", "handover", "stop-ack";
+
+        power-domains = <&rpmpd MSM8916_VDDCX>, <&rpmpd MSM8916_VDDMX>;
+        power-domain-names = "cx", "mx";
+
+        vddpx-supply = <&pm8916_l7>;
+
+        qcom,smem-states = <&wcnss_smp2p_out 0>;
+        qcom,smem-state-names = "stop";
+
+        memory-region = <&wcnss_region>;
+
+        pinctrl-names = "default";
+        pinctrl-0 = <&wcnss_pin_a>;
+
+        iris {
+            compatible = "qcom,wcn3620";
+
+            clocks = <&rpmcc RPM_SMD_RF_CLK2>;
+            clock-names = "xo";
+        };
+
+        smd-edge {
+            interrupts = <GIC_SPI 142 IRQ_TYPE_EDGE_RISING>;
+
+            qcom,ipc = <&apcs 8 17>;
+            qcom,smd-edge = <6>;
+            qcom,remote-pid = <4>;
+
+            label = "pronto";
+
+            wcnss {
+                compatible = "qcom,wcnss";
+                qcom,smd-channels = "WCNSS_CTRL";
+
+                qcom,mmio = <&pronto>;
+
+                bt {
+                    compatible = "qcom,wcnss-bt";
+                };
+
+                wifi {
+                    compatible = "qcom,wcnss-wlan";
+
+                    interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
+                                 <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>;
+                    interrupt-names = "tx", "rx";
+
+                    qcom,smem-states = <&apps_smsm 10>, <&apps_smsm 9>;
+                    qcom,smem-state-names = "tx-enable", "tx-rings-empty";
+                };
+            };
+        };
+    };
-- 
2.36.0

