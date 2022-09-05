Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41ABA5ACF49
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 11:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236676AbiIEJzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 05:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237257AbiIEJzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 05:55:00 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A227713F13
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 02:54:57 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id b5so10610725wrr.5
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 02:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=bZF5w9xzj7lZChgIF/6nwP7MFLkNSnuZx9RimSg71+g=;
        b=AQFLNfl32NJkoDdTUY88Aj4+OfBskPvgs6DBhZpYwtbZzxtGps5VBHRFE0aqlvWGpC
         ULBALyuiRMYvHqckLayRvg3YHOY93nUwmgKodEVOYiqHWin5y2MtXMHwJ4W9AQavKkRe
         S0L7dQTtoKdfeuxQ/KLUGH6gWvoayCSPC95gMfiemr3ngYR6rpNMafyY8udIjUjOw7GL
         BRWJuE9P2wglcyTiUEpVWMo1xx2PzBADyb1PpGey+Fi4S62wFzOAoarngqQ9I4vVMjyr
         8lLrqeU8dLnx9YhKUhfJiyUosJpqL53B93ji1n5X8xZh7GGI2ySPyXb1hPmsPHolAiZv
         XA+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=bZF5w9xzj7lZChgIF/6nwP7MFLkNSnuZx9RimSg71+g=;
        b=KDcGdiBKaw8KY7hRe0dVPKUPFbmw3/x002J8wKoG87sUCbTLJ9/zMvfC9lpZLL7+cW
         rYnV0yPR4AXEV1qd6oPYdhT1+u+8gRlCOMoyLe4c3d0v/Zqb4I7a35rZn1HCxM8iK33y
         2p34MWvVDjCK6MGnDwCl/VnArvlYCCXJpCcRk6NJHrPjyQWQg6W/5lQPf4hRABN/dXlx
         sgCaWYQvMyjwh37TJtLiR1TJxY9fRtxHszJ2Iq3ywTtZ3jBIxyVnXuhhi+Ab52vX0ftW
         N96ngx4dI/NvEOpxtE8jiuuf/Tv6mvYb8OGp2huQm3f2QbOwCWixR+OVle/N2ExZW5xy
         0uGg==
X-Gm-Message-State: ACgBeo3PZA27QAtEL649gLkdxBVuJOMt08WkqCLIfN4myWUPREdX7n/s
        z9EYo7p4U7CHbYg4A0g6i2n6wQ==
X-Google-Smtp-Source: AA6agR7WFBghrrcaK4xA5ytl2V7YKojFB7RtZCmYECOr5Na51jVyTsGvzpxHXQk2aO0NtOi7BfuQnQ==
X-Received: by 2002:a05:6000:178d:b0:226:ffe8:72df with SMTP id e13-20020a056000178d00b00226ffe872dfmr8890594wrg.496.1662371696141;
        Mon, 05 Sep 2022 02:54:56 -0700 (PDT)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id t8-20020adfe108000000b00225213fd4a9sm8497264wrz.33.2022.09.05.02.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 02:54:55 -0700 (PDT)
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
Subject: [PATCH v5 1/2] dt-bindings: misc: fastrpc convert bindings to yaml
Date:   Mon,  5 Sep 2022 12:53:39 +0300
Message-Id: <20220905095340.902390-1-abel.vesa@linaro.org>
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

Changes since v4:
 * set global additionalProperties to false and removed the one for
 patternProperties
 * fixed compute-cb property to allow more than 9 nodes.
 * added missing qcom,glink-channels, qcom,non-secure-domain and
 qcom,smd-channels, without which the dtbs_check would fail

 .../bindings/misc/qcom,fastrpc.yaml           | 108 ++++++++++++++++++
 1 file changed, 108 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml

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

