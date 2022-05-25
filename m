Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20ADA534580
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 23:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345193AbiEYVCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 17:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232019AbiEYVB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 17:01:57 -0400
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE96435DC7;
        Wed, 25 May 2022 14:01:55 -0700 (PDT)
Received: by mail-oi1-f177.google.com with SMTP id w130so63142oig.0;
        Wed, 25 May 2022 14:01:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eV5yBS00qx48PlZZxn5CpCblfq4K2A5juZQWoz0DTyQ=;
        b=b009C+VN1TgeqTm+J8R6jdce0SR5YNYrSxEPGW8kSQQCigU57F8upkRebDJ/+QcSyv
         /q4WfXhx05ExazXQIsQ4sG3EYa0B8ujxdCKtG9dieR2kaRkHIUFjdQrggoEegX0FaC5O
         vaPexiJhDmD246s4TOuy2ix9iUyUQ2Zcx4J6dONqY58d5jbpqk8xlaO0Nivo+0iUQ6zq
         +A3japseOp6nmM6ah2gRgPN+mhpYfjJdQEbB05SC9SNxNAaCBPfmob+0hp2Hq8PTDGM5
         PIEch3z5L2HClMmXX148q+zmtKH4/Oo+6a/WHs/vTYOLKjL373HOVfJjzJ2Z6SHz/VxN
         AwxQ==
X-Gm-Message-State: AOAM532eCqsb+1yZJa8F/pOVi9ZvtfCXYhmkZndrNnUkf20aOicZUOs6
        4fgvflEJOiF5Mfvp4wSUydNcGoRx4w==
X-Google-Smtp-Source: ABdhPJw5CRPGykueFSEUBPahgULvafvqctVKF09HWJ0vw1MdPECO0kDWuHEbnvLjKh6QNPWctp7Eqg==
X-Received: by 2002:a05:6808:16a1:b0:2f9:bfea:e5f3 with SMTP id bb33-20020a05680816a100b002f9bfeae5f3mr6603644oib.28.1653512515113;
        Wed, 25 May 2022 14:01:55 -0700 (PDT)
Received: from xps15.. (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.googlemail.com with ESMTPSA id w19-20020a056870431300b000f26a4e2cdfsm3723564oah.18.2022.05.25.14.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 14:01:54 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Paul Cercueil <paul@crapouillou.net>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mtd@lists.infradead.org
Subject: [PATCH] dt-bindings: memory-controllers: ingenic: Split out child node properties
Date:   Wed, 25 May 2022 16:01:40 -0500
Message-Id: <20220525210140.2489866-1-robh@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Binding schemas which define child node properties such as memory
controllers with timing properties need a separate schema which can be
referenced from child device schemas. This is necessary for
unevaluatedProperties checks to work properly.

Move the ingenic,nemc child properties to its own file and reference
from ingenic,nand.yaml which describes a child NAND controller.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../ingenic,nemc-peripherals.yaml             | 46 +++++++++++++++++++
 .../memory-controllers/ingenic,nemc.yaml      | 32 -------------
 .../devicetree/bindings/mtd/ingenic,nand.yaml |  1 +
 3 files changed, 47 insertions(+), 32 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/ingenic,nemc-peripherals.yaml

diff --git a/Documentation/devicetree/bindings/memory-controllers/ingenic,nemc-peripherals.yaml b/Documentation/devicetree/bindings/memory-controllers/ingenic,nemc-peripherals.yaml
new file mode 100644
index 000000000000..b8ed52a44d57
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/ingenic,nemc-peripherals.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/memory-controllers/ingenic,nemc-peripherals.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Ingenic SoCs NAND / External Memory Controller (NEMC) devicetree bindings
+
+maintainers:
+  - Paul Cercueil <paul@crapouillou.net>
+
+properties:
+  reg:
+    minItems: 1
+    maxItems: 255
+
+  ingenic,nemc-bus-width:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [8, 16]
+    description: Specifies the bus width in bits.
+
+  ingenic,nemc-tAS:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Address setup time in nanoseconds.
+
+  ingenic,nemc-tAH:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Address hold time in nanoseconds.
+
+  ingenic,nemc-tBP:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Burst pitch time in nanoseconds.
+
+  ingenic,nemc-tAW:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Address wait time in nanoseconds.
+
+  ingenic,nemc-tSTRV:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Static memory recovery time in nanoseconds.
+
+required:
+  - reg
+
+additionalProperties: true
+...
diff --git a/Documentation/devicetree/bindings/memory-controllers/ingenic,nemc.yaml b/Documentation/devicetree/bindings/memory-controllers/ingenic,nemc.yaml
index 24f9e1982028..dd13a5106d6c 100644
--- a/Documentation/devicetree/bindings/memory-controllers/ingenic,nemc.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/ingenic,nemc.yaml
@@ -39,38 +39,6 @@ properties:
 patternProperties:
   ".*@[0-9]+$":
     type: object
-    properties:
-      reg:
-        minItems: 1
-        maxItems: 255
-
-      ingenic,nemc-bus-width:
-        $ref: /schemas/types.yaml#/definitions/uint32
-        enum: [8, 16]
-        description: Specifies the bus width in bits.
-
-      ingenic,nemc-tAS:
-        $ref: /schemas/types.yaml#/definitions/uint32
-        description: Address setup time in nanoseconds.
-
-      ingenic,nemc-tAH:
-        $ref: /schemas/types.yaml#/definitions/uint32
-        description: Address hold time in nanoseconds.
-
-      ingenic,nemc-tBP:
-        $ref: /schemas/types.yaml#/definitions/uint32
-        description: Burst pitch time in nanoseconds.
-
-      ingenic,nemc-tAW:
-        $ref: /schemas/types.yaml#/definitions/uint32
-        description: Address wait time in nanoseconds.
-
-      ingenic,nemc-tSTRV:
-        $ref: /schemas/types.yaml#/definitions/uint32
-        description: Static memory recovery time in nanoseconds.
-
-    required:
-      - reg
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/mtd/ingenic,nand.yaml b/Documentation/devicetree/bindings/mtd/ingenic,nand.yaml
index 9de8ef6e59ca..8c272c842bfd 100644
--- a/Documentation/devicetree/bindings/mtd/ingenic,nand.yaml
+++ b/Documentation/devicetree/bindings/mtd/ingenic,nand.yaml
@@ -11,6 +11,7 @@ maintainers:
 
 allOf:
   - $ref: nand-controller.yaml#
+  - $ref: /schemas/memory-controllers/ingenic,nemc-peripherals.yaml#
 
 properties:
   compatible:
-- 
2.34.1

