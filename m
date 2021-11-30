Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48F85462FA1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 10:29:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234712AbhK3JcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 04:32:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240225AbhK3JcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 04:32:11 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0749C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 01:28:52 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 133so16883136wme.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 01:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ydMPP+rzHmOMEEgYyVDZvKAwWBch53F19D/eQXwTEQw=;
        b=hH+7XrW33GqrJ6WPl28jU6Dv0stolWydSfKUAZPT3Qe7FEOW3J1AFwjpckhZc7jfeg
         wz+uoMTCwjEgTtnyYzUJSEaG/jnBh5fDspQ2VWG+25i5l2+Sh7GzyfPEyJgq4sdmoTjQ
         G42+qBQVEPlkz7ICud/LABQ8E25xu24VI0aC5yml8ALuOAUmBe7tIs4Mkb1NyWDvF7gw
         czXRLsqtxmXQIEJv/UOvxp6IRi2FFTQMFbCsIgSgk4Ikg9XNBxf/eJ2BdbNJcE5+8ypF
         Yo4m0mhQbV1RnffSwcy1+z1TC6H51I6AHzw9zU9mN6TawcsbDBfPFzfe4JNWpmeswf73
         2wMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ydMPP+rzHmOMEEgYyVDZvKAwWBch53F19D/eQXwTEQw=;
        b=xa02A41MO4D8xs7YopL/e+ihmqktA221ta1oCDN7jXjftQ70DwKBNI0T31wlOsU3ar
         QrnALlYuImJfD34MoQRt7yzj6eNd8bD3zdaCRKOAy/OtN5XBwNn+HpV6itae5GqhEdc1
         kK1j75J5+0YGxVZ7SLsAEoHMdp6Dye8l5WfjQ6FZRb4MRIzxsjEI/dnR8J3sIE05Yfzw
         1sDHF8Ht63c/8ORsW+07kfW8gPneBRVQd3qylM6lWeKfxV6eDEhrXt8sONPxpfDrCg+0
         CNZlXuZJm1/3FpfvEy5l0kGiXKxl3JeHf8Sh7O27aAj49t8pSLITwkRuYo1Ls8nBGyCh
         hu4Q==
X-Gm-Message-State: AOAM530MtlvFd40UzkaCuxPnuhuedR9L8BipLQHUBulrsLztIeoOcxMV
        QKO8oRr4KZ7WidKb1i7Gz1EZPg==
X-Google-Smtp-Source: ABdhPJyQ/yNF4X7GSZ8DNdpsH5VZJr1rb42VyysX8gWQiLTy6z1ptZiHHKXbe49IC+/6Wa7Z3y7UYw==
X-Received: by 2002:a05:600c:214f:: with SMTP id v15mr3519928wml.194.1638264531321;
        Tue, 30 Nov 2021 01:28:51 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id t4sm1733246wmi.48.2021.11.30.01.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 01:28:50 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     robh+dt@kernel.org, gregkh@linuxfoundation.org
Cc:     devicetree@vger.kernel.org, ekangupt@qti.qualcomm.com,
        jeyr@codeaurora.org, bkumar@qti.qualcomm.com,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3] dt-bindings: misc: fastrpc convert bindings to yaml
Date:   Tue, 30 Nov 2021 09:28:46 +0000
Message-Id: <20211130092846.18804-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert Qualcomm FastRPC bindings to yaml format, so that we could validate
dt-entries correctly and any future additions can go into yaml format.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---

Changes since v2:
 fixed typo in pil compatible string 
 added required properties for pil example node

 .../devicetree/bindings/misc/qcom,fastrpc.txt |  78 -------------
 .../bindings/misc/qcom,fastrpc.yaml           | 104 ++++++++++++++++++
 2 files changed, 104 insertions(+), 78 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/misc/qcom,fastrpc.txt
 create mode 100644 Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml

diff --git a/Documentation/devicetree/bindings/misc/qcom,fastrpc.txt b/Documentation/devicetree/bindings/misc/qcom,fastrpc.txt
deleted file mode 100644
index 2a1827ab50d2..000000000000
--- a/Documentation/devicetree/bindings/misc/qcom,fastrpc.txt
+++ /dev/null
@@ -1,78 +0,0 @@
-Qualcomm Technologies, Inc. FastRPC Driver
-
-The FastRPC implements an IPC (Inter-Processor Communication)
-mechanism that allows for clients to transparently make remote method
-invocations across DSP and APPS boundaries. This enables developers
-to offload tasks to the DSP and free up the application processor for
-other tasks.
-
-- compatible:
-	Usage: required
-	Value type: <stringlist>
-	Definition: must be "qcom,fastrpc"
-
-- label
-	Usage: required
-	Value type: <string>
-	Definition: should specify the dsp domain name this fastrpc
-	corresponds to. must be one of this: "adsp", "mdsp", "sdsp", "cdsp"
-
-- #address-cells
-	Usage: required
-	Value type: <u32>
-	Definition: Must be 1
-
-- #size-cells
-	Usage: required
-	Value type: <u32>
-	Definition: Must be 0
-
-= COMPUTE BANKS
-Each subnode of the Fastrpc represents compute context banks available
-on the dsp.
-- All Compute context banks MUST contain the following properties:
-
-- compatible:
-	Usage: required
-	Value type: <stringlist>
-	Definition: must be "qcom,fastrpc-compute-cb"
-
-- reg
-	Usage: required
-	Value type: <u32>
-	Definition: Context Bank ID.
-
-- qcom,nsessions:
-	Usage: Optional
-	Value type: <u32>
-	Defination: A value indicating how many sessions can share this
-		    context bank. Defaults to 1 when this property
-		    is not specified.
-
-Example:
-
-adsp-pil {
-	compatible = "qcom,msm8996-adsp-pil";
-	...
-	smd-edge {
-		label = "lpass";
-		fastrpc {
-			compatible = "qcom,fastrpc";
-			qcom,smd-channels = "fastrpcsmd-apps-dsp";
-			label = "adsp";
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			cb@1 {
-				compatible = "qcom,fastrpc-compute-cb";
-				reg = <1>;
-			};
-
-			cb@2 {
-				compatible = "qcom,fastrpc-compute-cb";
-				reg = <2>;
-			};
-			...
-		};
-	};
-};
diff --git a/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
new file mode 100644
index 000000000000..1840db08500c
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
@@ -0,0 +1,104 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/misc/qcom,fastrpc.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Qualcomm Technologies, Inc. FastRPC Driver
+
+maintainers:
+  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
+
+description: |
+  This binding describes Qualcomm FastRPC an IPC (Inter-Processor Communication)
+  mechanism that allows for clients to transparently make remote method
+  invocations across DSP and APPS boundaries. This enables developers
+  to offload tasks to the DSP and free up the application processor for
+  other tasks.
+
+properties:
+  compatible:
+    const: qcom,fastrpc
+
+  label:
+    enum:
+      - adsp
+      - mdsp
+      - sdsp
+      - cdsp
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+patternProperties:
+  "^cb@[0-9a-f]$":
+    type: object
+    description: |
+      Compute context bank
+
+    properties:
+      compatible:
+        const: qcom,fastrpc-compute-cb
+
+      reg:
+        maxItems: 1
+        description: Context Bank ID
+
+      qcom,nsessions:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: How many sessions can share this context bank.
+                     Defaults to 1 when this property is not specified.
+
+    required:
+      - compatible
+      - reg
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - label
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    adsp {
+        compatible = "qcom,msm8996-adsp-pil";
+        interrupts-extended = <&intc 0 162 IRQ_TYPE_EDGE_RISING>,
+                              <&smp2p_adsp_in 0 IRQ_TYPE_EDGE_RISING>,
+                              <&smp2p_adsp_in 1 IRQ_TYPE_EDGE_RISING>,
+                              <&smp2p_adsp_in 2 IRQ_TYPE_EDGE_RISING>,
+                              <&smp2p_adsp_in 3 IRQ_TYPE_EDGE_RISING>;
+        interrupt-names = "wdog", "fatal", "ready", "handover", "stop-ack";
+        clocks = <&xo_board>;
+        clock-names = "xo";
+        memory-region = <&adsp_region>;
+        qcom,smem-states = <&smp2p_adsp_out 0>;
+        qcom,smem-state-names = "stop";
+
+        smd-edge {
+            label = "lpass";
+
+            fastrpc {
+                compatible = "qcom,fastrpc";
+                label = "adsp";
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                cb@1 {
+                    compatible = "qcom,fastrpc-compute-cb";
+                    reg = <1>;
+                };
+
+                cb@2 {
+                    compatible = "qcom,fastrpc-compute-cb";
+                    reg = <2>;
+                };
+            };
+        };
+    };
-- 
2.21.0

