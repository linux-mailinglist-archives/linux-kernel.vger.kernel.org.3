Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E99B59E993
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 19:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233068AbiHWRYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 13:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243784AbiHWRVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 13:21:46 -0400
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C97CFAC257;
        Tue, 23 Aug 2022 07:57:41 -0700 (PDT)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-11c59785966so17071944fac.11;
        Tue, 23 Aug 2022 07:57:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=fZf+b2xrhMOCBDJvsl7BpbOyN0rxEBVJyk9d9rZqcQs=;
        b=7qDhszQE3j2rcUn6pfe1jMNqCFSW1BEaSoA79HHY1NKtfGBo+AySV+1mfGa3S9ujCj
         WMVmqEOo58ahN6scNqId9Wc7OdzSDBBOQr14fM5U1vZr6pv8bNxms/vZNPYDRZJyP2od
         ZEO2dQOPtdki+Q5UFhoCtICno0CHRVxnEW3efxKweGQqDsX6y8knmaVJQpmHNE7hCPFx
         5FMX+ppvDHWvB2JGxrTT0IHNTqOexXgXgMsPuxRT99DvM8NLx+4afXg3U7lDT/rwqN4d
         rX1tMN+CXh8DIjIIgSaWXNsnCUUZSSUJg0aQYGElhHO5DnLZKfsvoizJfPo7gts6Wxlu
         BD8A==
X-Gm-Message-State: ACgBeo0FjIRCOGd5aoMSTAhpcjTx6SC9fExGAnnbl1T6vu3FzJ6hYuNi
        pmL58QVskTUlU6nwnSacww==
X-Google-Smtp-Source: AA6agR5fcTOzMDeice78EIAxrozirEPJ4lnpIAKHlZmcNDbeGXu+oAcumcKKQMpwyZMTxpii9silyg==
X-Received: by 2002:a05:6870:b52c:b0:10e:e9e2:81b2 with SMTP id v44-20020a056870b52c00b0010ee9e281b2mr1585639oap.75.1661266661060;
        Tue, 23 Aug 2022 07:57:41 -0700 (PDT)
Received: from xps15.. (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.googlemail.com with ESMTPSA id t1-20020a056870600100b0011c65559b04sm3840637oaa.34.2022.08.23.07.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 07:57:40 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] dt-bindings: power: Add missing (unevaluated|additional)Properties on child nodes
Date:   Tue, 23 Aug 2022 09:56:46 -0500
Message-Id: <20220823145649.3118479-15-robh@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to ensure only documented properties are present, node schemas
must have unevaluatedProperties or additionalProperties set to false
(typically).

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../bindings/power/domain-idle-state.yaml          | 10 ++++++++++
 .../devicetree/bindings/power/fsl,imx-gpc.yaml     | 14 ++++++++++++++
 .../devicetree/bindings/power/fsl,imx-gpcv2.yaml   | 14 ++++++++++++++
 3 files changed, 38 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/domain-idle-state.yaml b/Documentation/devicetree/bindings/power/domain-idle-state.yaml
index 6a12efdf436a..4ee920a1de69 100644
--- a/Documentation/devicetree/bindings/power/domain-idle-state.yaml
+++ b/Documentation/devicetree/bindings/power/domain-idle-state.yaml
@@ -20,6 +20,7 @@ properties:
 patternProperties:
   "^(cpu|cluster|domain)-":
     type: object
+    additionalProperties: false
     description:
       Each state node represents a domain idle state description.
 
@@ -44,6 +45,15 @@ patternProperties:
           state will yield power benefits, after overcoming the overhead while
           entering the idle state.
 
+      arm,psci-suspend-param:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: |
+          power_state parameter to pass to the ARM PSCI suspend call.
+
+          Device tree nodes that require usage of PSCI CPU_SUSPEND function
+          (i.e. idle states node with entry-method property is set to "psci")
+          must specify this property.
+
     required:
       - compatible
       - entry-latency-us
diff --git a/Documentation/devicetree/bindings/power/fsl,imx-gpc.yaml b/Documentation/devicetree/bindings/power/fsl,imx-gpc.yaml
index a055b3e819d8..777e1d852ddd 100644
--- a/Documentation/devicetree/bindings/power/fsl,imx-gpc.yaml
+++ b/Documentation/devicetree/bindings/power/fsl,imx-gpc.yaml
@@ -43,11 +43,21 @@ properties:
 
   pgc:
     type: object
+    additionalProperties: false
     description: list of power domains provided by this controller.
 
+    properties:
+      '#address-cells':
+        const: 1
+
+      '#size-cells':
+        const: 0
+
     patternProperties:
       "power-domain@[0-9]$":
         type: object
+        additionalProperties: false
+
         properties:
 
           '#power-domain-cells':
@@ -78,6 +88,10 @@ properties:
           - '#power-domain-cells'
           - reg
 
+    required:
+      - '#address-cells'
+      - '#size-cells'
+
 required:
   - compatible
   - reg
diff --git a/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.yaml b/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.yaml
index 747622bdc57b..3b161e01f920 100644
--- a/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.yaml
+++ b/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.yaml
@@ -42,11 +42,21 @@ properties:
 
   pgc:
     type: object
+    additionalProperties: false
     description: list of power domains provided by this controller.
 
+    properties:
+      '#address-cells':
+        const: 1
+
+      '#size-cells':
+        const: 0
+
     patternProperties:
       "power-domain@[0-9]$":
         type: object
+        additionalProperties: false
+
         properties:
 
           '#power-domain-cells':
@@ -85,6 +95,10 @@ properties:
           - '#power-domain-cells'
           - reg
 
+    required:
+      - '#address-cells'
+      - '#size-cells'
+
 required:
   - compatible
   - reg
-- 
2.34.1

