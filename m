Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF3C05B1063
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 01:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbiIGX3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 19:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbiIGX33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 19:29:29 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C07CD65AF
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 16:29:21 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id t65so4094416pgt.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 16:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=nAzRb5IG40N9kD80lZ5f/eFJ3lUDj53vPPmtb3g2dNA=;
        b=ehzYxHgobx7obM5HHdDeMRSpB773IBQaabyUfdYTjMa+y945g0J9mPBOGR+LNF8RON
         kfz0/JBcMnTaDtjoQVaFkl6ad1O8zOSnIA/wAJBRDV7JHiLBCz11ms9/gK0LKThoSkw2
         1/Jk05Bgn/su1PLyKkPwnjsyEAswVGF5HejoQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=nAzRb5IG40N9kD80lZ5f/eFJ3lUDj53vPPmtb3g2dNA=;
        b=P76M5aWH98kId4NBWeW635OHKzF5WDgkjyLUNWLqIa6/u2HWrZXy+Zh5BbR/LPw9zE
         2FULQ2zE+vECIW6NbWxdWkDhSgJlWvGxO+/jRtitimm+8fBahMa+UpNOTKlxJHuc7rPM
         tnJqET3i23sliiXaMT6OYBDZqZLrk2+n9AO6a6BW5vsbmhvZ+Y1z0Sw8ETeboySjuOvN
         3vcR1tNgC4uSn6yyyBaJkO7rat+rhbKAuVrbTEisJFOKdK9W6TKC90K25yxnlJucvzCG
         0xSGEPTTkb6JafnATndKrTN9ZA+AoEl4DDRzrPF9/Muqi8NwgYQDbV+QIBApy/7qHsMG
         rQNw==
X-Gm-Message-State: ACgBeo1B4v4gpZLQWUqlj8FEHH/wtVWdmlbt1AjS0BsI79Ueg3v1Wvgy
        LyTm6cpSACBxkyQowZTPhe0rQQ==
X-Google-Smtp-Source: AA6agR4hRE71BSSsnmKj9liCm/uZXU6+UW0r4qW60BKhrPdWz9/EkOJlUWuePemEvBGQ+ixkNBPUAw==
X-Received: by 2002:a05:6a00:1d1a:b0:537:d750:65b5 with SMTP id a26-20020a056a001d1a00b00537d75065b5mr6318852pfx.85.1662593361201;
        Wed, 07 Sep 2022 16:29:21 -0700 (PDT)
Received: from jwerner-p920.mtv.corp.google.com ([2620:15c:202:201:1cee:f8f:cc9f:568f])
        by smtp.gmail.com with ESMTPSA id g6-20020a17090a708600b002000dabc356sm201521pjk.45.2022.09.07.16.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 16:29:20 -0700 (PDT)
From:   Julius Werner <jwerner@chromium.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Doug Anderson <dianders@chromium.org>,
        Jian-Jia Su <jjsu@google.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Julius Werner <jwerner@chromium.org>
Subject: [PATCH 1/4 v2] dt-bindings: memory: Factor out common properties of LPDDR bindings
Date:   Wed,  7 Sep 2022 16:29:11 -0700
Message-Id: <20220907232914.243502-1-jwerner@chromium.org>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bindings for different LPDDR versions mostly use the same kinds of
properties, so in order to reduce duplication when we're adding support
for more versions, this patch creates a new lpddr-props subschema that
can be referenced by the others to define these common parts. (This will
consider a few smaller I/O width and density numbers "legal" for LPDDR3
that are usually not used there, but this should be harmless.)

Signed-off-by: Julius Werner <jwerner@chromium.org>
---
 .../ddr/jedec,lpddr-props.yaml                | 52 +++++++++++++++++++
 .../memory-controllers/ddr/jedec,lpddr2.yaml  | 40 ++------------
 .../memory-controllers/ddr/jedec,lpddr3.yaml  | 32 ++----------
 3 files changed, 60 insertions(+), 64 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr-props.yaml

Changelog:

- v2:
  - removed minItems
  - reordered io-width enum from lowest to highest
  - moved `$ref` below `mainainers`
  - removed part about undeprecating manufacturer-id

diff --git a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr-props.yaml b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr-props.yaml
new file mode 100644
index 00000000000000..02700ac3c387ec
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr-props.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/memory-controllers/ddr/jedec,lpddr-props.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Common properties for LPDDR types
+
+description:
+  Different LPDDR types generally use the same properties and only differ in the
+  range of legal values for each. This file defines the common parts that can be
+  reused for each type.
+
+maintainers:
+  - Krzysztof Kozlowski <krzk@kernel.org>
+
+properties:
+  revision-id:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description:
+      Revision IDs read from Mode Register 6 and 7. One byte per uint32 cell (i.e. <MR6 MR7>).
+    maxItems: 2
+    items:
+      minimum: 0
+      maximum: 255
+
+  density:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Density in megabits of SDRAM chip. Decoded from Mode Register 8.
+    enum:
+      - 64
+      - 128
+      - 256
+      - 512
+      - 1024
+      - 2048
+      - 4096
+      - 8192
+      - 16384
+      - 32768
+
+  io-width:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      IO bus width in bits of SDRAM chip. Decoded from Mode Register 8.
+    enum:
+      - 8
+      - 16
+      - 32
+
+additionalProperties: true
diff --git a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr2.yaml b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr2.yaml
index 9d78f140609b6c..65f4926d39c254 100644
--- a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr2.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr2.yaml
@@ -9,6 +9,9 @@ title: LPDDR2 SDRAM compliant to JEDEC JESD209-2
 maintainers:
   - Krzysztof Kozlowski <krzk@kernel.org>
 
+allOf:
+  - $ref: "jedec,lpddr-props.yaml#"
+
 properties:
   compatible:
     oneOf:
@@ -41,41 +44,6 @@ properties:
       Property is deprecated, use revision-id instead.
     deprecated: true
 
-  revision-id:
-    $ref: /schemas/types.yaml#/definitions/uint32-array
-    description: |
-      Revision IDs read from Mode Register 6 and 7. One byte per uint32 cell (i.e. <MR6 MR7>).
-    minItems: 2
-    maxItems: 2
-    items:
-      minimum: 0
-      maximum: 255
-
-  density:
-    $ref: /schemas/types.yaml#/definitions/uint32
-    description: |
-      Density in megabits of SDRAM chip. Obtained from device datasheet.
-    enum:
-      - 64
-      - 128
-      - 256
-      - 512
-      - 1024
-      - 2048
-      - 4096
-      - 8192
-      - 16384
-      - 32768
-
-  io-width:
-    $ref: /schemas/types.yaml#/definitions/uint32
-    description: |
-      IO bus width in bits of SDRAM chip. Obtained from device datasheet.
-    enum:
-      - 32
-      - 16
-      - 8
-
   tRRD-min-tck:
     $ref: /schemas/types.yaml#/definitions/uint32
     maximum: 16
@@ -168,7 +136,7 @@ required:
   - density
   - io-width
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr3.yaml b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr3.yaml
index 48908a19473c3f..91b64943062472 100644
--- a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr3.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr3.yaml
@@ -9,6 +9,9 @@ title: LPDDR3 SDRAM compliant to JEDEC JESD209-3
 maintainers:
   - Krzysztof Kozlowski <krzk@kernel.org>
 
+allOf:
+  - $ref: "jedec,lpddr-props.yaml#"
+
 properties:
   compatible:
     items:
@@ -20,24 +23,6 @@ properties:
     const: 1
     deprecated: true
 
-  density:
-    $ref: /schemas/types.yaml#/definitions/uint32
-    description: |
-      Density in megabits of SDRAM chip.
-    enum:
-      - 4096
-      - 8192
-      - 16384
-      - 32768
-
-  io-width:
-    $ref: /schemas/types.yaml#/definitions/uint32
-    description: |
-      IO bus width in bits of SDRAM chip.
-    enum:
-      - 32
-      - 16
-
   manufacturer-id:
     $ref: /schemas/types.yaml#/definitions/uint32
     description: |
@@ -45,15 +30,6 @@ properties:
       deprecated, manufacturer should be derived from the compatible.
     deprecated: true
 
-  revision-id:
-    $ref: /schemas/types.yaml#/definitions/uint32-array
-    minItems: 2
-    maxItems: 2
-    items:
-      maximum: 255
-    description: |
-      Revision value of SDRAM chip read from Mode Registers 6 and 7.
-
   '#size-cells':
     const: 0
     deprecated: true
@@ -206,7 +182,7 @@ required:
   - density
   - io-width
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.31.0

