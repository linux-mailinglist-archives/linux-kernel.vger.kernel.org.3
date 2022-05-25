Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3362533F7C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 16:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244063AbiEYOou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 10:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244820AbiEYOoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 10:44:39 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2974DAE244
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 07:44:36 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id m20so42132949ejj.10
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 07:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KhlEBIuQ03eusWOfEIpb3AWYeF5p0BIH1Ax8ZKxHaIU=;
        b=HYwjZB3aWboUwzWq0BJxI7E1IepJCdru5AAGgubDmK5VK4WSXa5SYhu3K75AJZ+sXK
         OCLsgqoa4mrbqc0XJcnHoF/I/8Aodo/8R/xogaVAP/ISmEFbbnY62t2vvJ3Du/oSxo/6
         SMJUmkSM3CsyJS0xlBFiU5h+5oPuFLapnbpPBECTxOyXOR1oUEeNSE9PGzvLysz7NpF0
         fRkMFCeuBaqV3obwXXtq4UzmU7Dh8d7Npq5r5bA8IrQDXzfL57W7BDQsEdpFxnVHRLjB
         zLbFgASHZhQbx+Ss/y7PbfQugFD/A7KHcbjb/CaCaaJxeNfNgWbVbJhDiSiyEkNj1t48
         YRqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KhlEBIuQ03eusWOfEIpb3AWYeF5p0BIH1Ax8ZKxHaIU=;
        b=QjZ1lcejWthq366cStGOteqyrOdCHVsKXJwlsSpspJHzDe4VcfdaaOLcfAGmKpvXrw
         kOPwL1C4c8d/G9bu7xQShb0jp3vHzE381X+4JIzGPp3bTBhHiDStR05qpO6O5rdROWRl
         RX5pGaEBYUDFqauUJInJHdQF5vUzM6mynq9Lr7oV3brd6PUH1H4X1+IghvkILHPgtY9K
         U4yx+7mFWr4IZz+DbN8DyD0216hYx0YHi1P8Pa7N4guiXKrC3CQtwRgkQEtcJHRi/nzz
         YbM0AE0yQaPYQN5HjI/3sXxY7Dsctq+7oFLbz8UHlOiVja/nOd30W7aha1kjXop8paYi
         +bUg==
X-Gm-Message-State: AOAM532lBh/ZBSBjhhYU11GgNKbULPPHiTlIIPI3mECiLfqhL+jxAIkE
        tyBunJ5b6qxLYZo+UYF3onBhLA==
X-Google-Smtp-Source: ABdhPJzPsltsdGsrAfLJ/TR+I0VNaXB93M/IcJcIEkH/OFtUEvKEHUFNs+QtI4kfrbkgqzuJjUw7Fg==
X-Received: by 2002:a17:907:6d10:b0:6fe:c744:43be with SMTP id sa16-20020a1709076d1000b006fec74443bemr17045582ejc.470.1653489874615;
        Wed, 25 May 2022 07:44:34 -0700 (PDT)
Received: from otso.. (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id r2-20020a170906550200b006f3ef214de1sm8159596ejp.71.2022.05.25.07.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 07:44:34 -0700 (PDT)
From:   Luca Weiss <luca.weiss@fairphone.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca.weiss@fairphone.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/5] dt-bindings: interconnect: qcom: Split out rpmh-common bindings
Date:   Wed, 25 May 2022 16:43:58 +0200
Message-Id: <20220525144404.200390-3-luca.weiss@fairphone.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220525144404.200390-1-luca.weiss@fairphone.com>
References: <20220525144404.200390-1-luca.weiss@fairphone.com>
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

In preparation for the platforms, split out common definitions used in
rpmh-based interconnects.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Changes since v2:
* Reorganize patches so order is more logical
* Replace bouncing maintainer email with Bjorn
* maxItems: 2 for qcom,bcm-voters and qcom,bcm-voter-names
* Remove | from some descriptions

 .../interconnect/qcom,rpmh-common.yaml        | 43 +++++++++++++++++++
 .../bindings/interconnect/qcom,rpmh.yaml      | 22 +++-------
 2 files changed, 48 insertions(+), 17 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,rpmh-common.yaml

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,rpmh-common.yaml b/Documentation/devicetree/bindings/interconnect/qcom,rpmh-common.yaml
new file mode 100644
index 000000000000..e962e8dc9a61
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/qcom,rpmh-common.yaml
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interconnect/qcom,rpmh-common.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm RPMh Network-On-Chip Interconnect
+
+maintainers:
+  - Georgi Djakov <georgi.djakov@linaro.org>
+  - Bjorn Andersson <bjorn.andersson@linaro.org>
+
+description:
+  RPMh interconnect providers support system bandwidth requirements through
+  RPMh hardware accelerators known as Bus Clock Manager (BCM). The provider is
+  able to communicate with the BCM through the Resource State Coordinator (RSC)
+  associated with each execution environment. Provider nodes must point to at
+  least one RPMh device child node pertaining to their RSC and each provider
+  can map to multiple RPMh resources.
+
+properties:
+  '#interconnect-cells':
+    enum: [ 1, 2 ]
+
+  qcom,bcm-voters:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      maxItems: 1
+    maxItems: 2
+    description:
+      List of phandles to qcom,bcm-voter nodes that are required by
+      this interconnect to send RPMh commands.
+
+  qcom,bcm-voter-names:
+    description:
+      Names for each of the qcom,bcm-voters specified.
+    maxItems: 2
+
+required:
+  - '#interconnect-cells'
+  - qcom,bcm-voters
+
+additionalProperties: true
diff --git a/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
index fae3363fed02..e822dc099339 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
@@ -18,6 +18,9 @@ description: |
    least one RPMh device child node pertaining to their RSC and each provider
    can map to multiple RPMh resources.
 
+allOf:
+  - $ref: qcom,rpmh-common.yaml#
+
 properties:
   reg:
     maxItems: 1
@@ -131,28 +134,13 @@ properties:
       - qcom,sm8450-pcie-anoc
       - qcom,sm8450-system-noc
 
-  '#interconnect-cells':
-    enum: [ 1, 2 ]
-
-  qcom,bcm-voters:
-    $ref: /schemas/types.yaml#/definitions/phandle-array
-    items:
-      maxItems: 1
-    description: |
-      List of phandles to qcom,bcm-voter nodes that are required by
-      this interconnect to send RPMh commands.
-
-  qcom,bcm-voter-names:
-    description: |
-      Names for each of the qcom,bcm-voters specified.
+  '#interconnect-cells': true
 
 required:
   - compatible
   - reg
-  - '#interconnect-cells'
-  - qcom,bcm-voters
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.36.1

