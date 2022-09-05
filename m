Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62A6E5AD044
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 12:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236197AbiIEKhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 06:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235254AbiIEKh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 06:37:26 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A782E6AD
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 03:37:24 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id k9so10800753wri.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 03:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=YXCCApCsqG4lX5w+P2Zmd4wA9hkF2ptf8XDZNujWCnY=;
        b=ZSunK+utSxB0hE0Vn0ucZ92Pheev7Qw4fLCiGrPbspkjA9o5Ga6yW6wKR/QGWdK2F5
         QZ2zbt1UxjNgHuAbMf5tpfKDyypX/7UK625nEtqgRIN+9QRBJ1TSJfJNhiXhrbYBKCac
         3XBaOBeKzoOB9T2eYMZy6zHQOj7e3sDFAaFkdM8kzQ9IMNwXPimTXaAAyhVSXBcTQVWK
         Cn2u2dp6ZG0WTsdnD7I8fXAJz3GYNqEyrA0vkXE38lmji1Kp4ZK72/GbAPTIqGLzyJiJ
         o5vDt5OGYbPeeVjv0at7aSX+y6ZLltQEPUnfmH9TozwKIwdoYKBRpkweSpeVKL289r9L
         h7tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=YXCCApCsqG4lX5w+P2Zmd4wA9hkF2ptf8XDZNujWCnY=;
        b=A4kBZm40Ceje9jDnETSRbnGe18rudHNz2irkPB7aqyDWXH275iF9pbbcAvl+n8tZmz
         CMnHSvie5uWZt7cmkmNedLL2hLnBu2eqiuH40aeM12sfk5B5rx2jgxKKaoAGkfjg+svT
         VN0SScZtMUPRdifxvhrrQK8UyAHJ2UdJoBCTckAfw4/PfVFjBbF3biNJphJjXH3NUexd
         aKzchRYxnRp01ABQ7ZZEiHHu4uEb/wGRAItvIo5aeLE5TvmCAxnmxiM3iZ9WAGHS5Og0
         MdoVLgn/bsKwnz4i96eu4hcsrYjvbg1R0fZW0kh6l8PYYcDfQyPTMInWvrI3ILumhGBr
         jxMw==
X-Gm-Message-State: ACgBeo2LvgropurbqvNEKGo4lbS8SsaRQI/331iiT0KV7ZinNjMSJsF+
        NzKbvYqVHJwcXOEisM+WdOoVpg==
X-Google-Smtp-Source: AA6agR6nD8jmBM0LAbPnaKPn6t6X1WZemQxM1G3S8VnIwic1E2xeCcdtgSvpyOamc2W4N9bSLoMkMQ==
X-Received: by 2002:a5d:544a:0:b0:228:64cd:243b with SMTP id w10-20020a5d544a000000b0022864cd243bmr3558111wrv.238.1662374243153;
        Mon, 05 Sep 2022 03:37:23 -0700 (PDT)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id z7-20020a05600c0a0700b003a5c1e916c8sm31765894wmp.1.2022.09.05.03.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 03:37:22 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Heidelberg <david@ixit.cz>
Subject: [PATCH v6 1/2] dt-bindings: misc: fastrpc convert bindings to yaml
Date:   Mon,  5 Sep 2022 13:37:14 +0300
Message-Id: <20220905103715.955786-1-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Convert Qualcomm FastRPC bindings to yaml format, so that we could validate
dt-entries correctly and any future additions can go into yaml format.

Use compute-cb@ subnodes instead of just cb@.

Also add qcom,non-secure-domain, qcom,glink-channels and
qcom,smd-channels missing properties to make sure dtbs_check doesn't
fail right off the bat.

Co-developed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Co-developed-by: David Heidelberg <david@ixit.cz>
Signed-off-by: David Heidelberg <david@ixit.cz>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---

Changes since v5:
 * Removed the txt file

 .../devicetree/bindings/misc/qcom,fastrpc.txt |  88 --------------
 .../bindings/misc/qcom,fastrpc.yaml           | 108 ++++++++++++++++++
 2 files changed, 108 insertions(+), 88 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/misc/qcom,fastrpc.txt
 create mode 100644 Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml

diff --git a/Documentation/devicetree/bindings/misc/qcom,fastrpc.txt b/Documentation/devicetree/bindings/misc/qcom,fastrpc.txt
deleted file mode 100644
index 5ec124b138a6..000000000000
--- a/Documentation/devicetree/bindings/misc/qcom,fastrpc.txt
+++ /dev/null
@@ -1,88 +0,0 @@
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
-- qcom,non-secure-domain:
-	Usage: required
-	Value type: <boolean>
-	Definition: Property to specify that dsp domain is non-secure.
-
-- qcom,vmids:
-	Usage: optional
-	Value type: <u32 array>
-	Definition: Virtual machine IDs for remote processor.
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
index 000000000000..3c11a3741994
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
@@ -0,0 +1,108 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/misc/qcom,fastrpc.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Qualcomm FastRPC Driver
+
+maintainers:
+  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
+
+description: |
+  The FastRPC implements an IPC (Inter-Processor Communication)
+  mechanism that allows for clients to transparently make remote method
+  invocations across DSP and APPS boundaries. This enables developers
+  to offload tasks to the DSP and free up the application processor for
+  other tasks.
+
+properties:
+  compatible:
+    items:
+      - const: qcom,fastrpc
+
+  label:
+    items:
+      enum:
+        - adsp
+        - mdsp
+        - sdsp
+        - cdsp
+
+  qcom,glink-channels:
+    description:
+      A list of channels tied to this function, used for matching
+      the function to a set of virtual channels.
+    $ref: "/schemas/types.yaml#/definitions/string-array"
+
+  qcom,non-secure-domain:
+    description:
+      Used to mark the current domain as non-secure.
+    type: boolean
+
+  qcom,smd-channels:
+    description:
+      Channel name used for the RPM communication
+    $ref: "/schemas/types.yaml#/definitions/string-array"
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+patternProperties:
+  "(compute-)?cb@[0-9]*$":
+    type: object
+
+    description: >
+      Each subnode of the Fastrpc represents compute context banks available on the dsp.
+
+    properties:
+      compatible:
+        items:
+          - const: qcom,fastrpc-compute-cb
+
+      reg:
+        maxItems: 1
+
+      qcom,nsession:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        default: 1
+        description: >
+          A value indicating how many sessions can share this context bank.
+
+    required:
+      - compatible
+      - reg
+
+required:
+  - compatible
+  - label
+  - '#address-cells'
+  - '#size-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    smd-edge {
+        label = "lpass";
+        fastrpc {
+            compatible = "qcom,fastrpc";
+            label = "adsp";
+            qcom,smd-channels = "fastrpcsmd-apps-dsp";
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            compute-cb@1 {
+                compatible = "qcom,fastrpc-compute-cb";
+                reg = <1>;
+            };
+
+            compute-cb@2 {
+                compatible = "qcom,fastrpc-compute-cb";
+                reg = <2>;
+            };
+        };
+    };
-- 
2.34.1

