Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4505249E5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 12:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352459AbiELKCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 06:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352413AbiELKA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 06:00:26 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C7B22EA6E
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 03:00:25 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id gh6so9227843ejb.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 03:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PrL26VFPR3bSShQRaBht+QhZehTfEgJWGZ9tOVoazls=;
        b=DD8sEFTqDx2Ah5PWZMyR7GwBJhJ0W2mLmFW3dbmCvZRUdPz6iyjrxoJhA7ONXyxucN
         dh0tt7nrz5SqQmtKlURYrq1jz9Jv7/N+g1EepRAuOYjBW8eY2KYsMqk9nIpkgMAvE7S8
         1q45emo7Cig/o6axWfWpqARC8xB3a9eIetuOw+txzG/wA6jheZIvOG+2i7kkdZC6jz5j
         AFHQy0TZyByinrnFWHADr6szamdRpCtuVCTFAnlWBTZUlqiIcu+TmHiV085W0CCShjBQ
         nic01R/tkTKVBbQmcr50EDDrRgTXwRFSJDm/pE/I0Bx427kVIVMzvQDgjz11egz0vEp+
         UDWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PrL26VFPR3bSShQRaBht+QhZehTfEgJWGZ9tOVoazls=;
        b=drc6DAbIaiEs8jcRXqVOKB016RiBDKQAwQjWH7AiAs9CpNx7/IM4liLDNxJ0IQnaH1
         VvZNHaVZ9TEJp16MoN7dzqulMqpS4sgYPcuFRWdQsrhkS5AKsP2CeV21il34iHwh9BvS
         xwWF/1LmGgN7UQLnN61Ev6hCaXJ0v7LSLZB6+MVUZ0LcNqQ0qq9QWNsdEo4b3qdsRRdx
         655tit1ovufqmyv0Pi4Knh69UV7Hh5i5BP1K0tctwkOTpkAwJD9+DRqz8FaunuZKCR5k
         KoZxooxhQnBZ7spjL0TSIcQ8goA+VFBl1Juh2oSWYN43o7m1ncLtbeWpftMi9sprpktR
         5qWQ==
X-Gm-Message-State: AOAM530N/iuReAlghWMQD8gjF9K+URPfhHh2I5hctR09ysbC4s6W9jWA
        Cu59KeH8DJUBIfpFNykFu+GNmg==
X-Google-Smtp-Source: ABdhPJxHMR0bBW/SrPBZURI0In45z9hjlYzniRADDROA40gnmEO3TStOX0rxmeWcPEUGVLbU+QifPw==
X-Received: by 2002:a17:907:7ea9:b0:6f3:de9c:c6fb with SMTP id qb41-20020a1709077ea900b006f3de9cc6fbmr29593860ejc.304.1652349624727;
        Thu, 12 May 2022 03:00:24 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id d17-20020a170906641100b006f3ef214da1sm1970287ejm.7.2022.05.12.03.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 03:00:24 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sireesh Kodali <sireeshkodali1@gmail.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 07/12] dt-bindings: remoteproc: qcom,glink-edge: define re-usable schema for glink-edge
Date:   Thu, 12 May 2022 12:00:01 +0200
Message-Id: <20220512100006.99695-8-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220512100006.99695-1-krzysztof.kozlowski@linaro.org>
References: <20220512100006.99695-1-krzysztof.kozlowski@linaro.org>
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

'glink-edge' property appears in multiple bindings, so split it into one
place which can be re-used.  This reduces code duplication and strict
schema matching for glink-edge nodes (instead of just "type:object").

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/remoteproc/qcom,adsp.yaml        |  2 +-
 .../bindings/remoteproc/qcom,glink-edge.yaml  | 72 +++++++++++++++++++
 .../remoteproc/qcom,sc7280-wpss-pil.yaml      | 18 ++---
 3 files changed, 77 insertions(+), 15 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,glink-edge.yaml

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
index d04de60ae017..4dfbfece1ec7 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
@@ -154,7 +154,7 @@ properties:
       channels and devices related to the ADSP.
 
   glink-edge:
-    type: object
+    $ref: /schemas/remoteproc/qcom,glink-edge.yaml#
     description:
       Qualcomm G-Link subnode which represents communication edge, channels
       and devices related to the ADSP.
diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,glink-edge.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,glink-edge.yaml
new file mode 100644
index 000000000000..fa69f7b21eed
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,glink-edge.yaml
@@ -0,0 +1,72 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/remoteproc/qcom,glink-edge.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm G-Link Edge communication channel nodes
+
+maintainers:
+  - Bjorn Andersson <bjorn.andersson@linaro.org>
+
+description:
+  Qualcomm G-Link subnode represents communication edge, channels and devices
+  related to the remote processor.
+
+properties:
+  $nodename:
+    const: "glink-edge"
+
+  apr:
+    $ref: /schemas/soc/qcom/qcom,apr.yaml#
+    description:
+      Qualcomm APR/GPR (Asynchronous/Generic Packet Router)
+
+  fastrpc:
+    type: object
+    description:
+      See Documentation/devicetree/bindings/misc/qcom,fastrpc.txt
+
+  interrupts:
+    maxItems: 1
+
+  label:
+    description: The names of the state bits used for SMP2P output
+
+  mboxes:
+    maxItems: 1
+
+  qcom,remote-pid:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      ID of the shared memory used by GLINK for communication with remote
+      processor.
+
+required:
+  - interrupts
+  - label
+  - mboxes
+  - qcom,remote-pid
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/mailbox/qcom-ipcc.h>
+
+    remoteproc@8a00000 {
+        reg = <0x08a00000 0x10000>;
+        // ...
+
+        glink-edge {
+            interrupts-extended = <&ipcc IPCC_CLIENT_WPSS
+                                         IPCC_MPROC_SIGNAL_GLINK_QMP
+                                         IRQ_TYPE_EDGE_RISING>;
+            mboxes = <&ipcc IPCC_CLIENT_WPSS
+                            IPCC_MPROC_SIGNAL_GLINK_QMP>;
+
+            label = "wpss";
+            qcom,remote-pid = <13>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-wpss-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-wpss-pil.yaml
index ade932468c38..3f06d66cbe47 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-wpss-pil.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-wpss-pil.yaml
@@ -106,8 +106,8 @@ properties:
     const: stop
 
   glink-edge:
-    type: object
-    description: |
+    $ref: qcom,glink-edge.yaml#
+    description:
       Qualcomm G-Link subnode which represents communication edge, channels
       and devices related to the ADSP.
 
@@ -121,21 +121,11 @@ properties:
           - description: Mailbox for communication between APPS and WPSS
 
       label:
-        description: The names of the state bits used for SMP2P output
         items:
           - const: wpss
 
-      qcom,remote-pid:
-        $ref: /schemas/types.yaml#/definitions/uint32
-        description: ID of the shared memory used by GLINK for communication with WPSS
-
-    required:
-      - interrupts
-      - mboxes
-      - label
-      - qcom,remote-pid
-
-    additionalProperties: false
+      apr: false
+      fastrpc: false
 
 required:
   - compatible
-- 
2.32.0

