Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 426C85A7361
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 03:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbiHaBeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 21:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbiHaBeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 21:34:08 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14FBAF0E5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 18:34:07 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id j5so8904039plj.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 18:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=CHQeXnfRhV+Rl/DeGa69lUaZqdL0Qy5Wbepw7R/N8is=;
        b=JFl8XnRbLljUJynLreUl04vCtzctmfXmKsx6wlwtcEd5cdNQF8pPpjd0d8t8c3UYNc
         6bJzNv6YeHMOutmI/UCsemxB8wZYi7kMiCd5zw8Ctse1yNBJk6WLCIFAWGBHLpFHLWAx
         QWZKzBmIpaLFVB42DEZwsyOo/dyW9goHB5QDY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=CHQeXnfRhV+Rl/DeGa69lUaZqdL0Qy5Wbepw7R/N8is=;
        b=wPx8nuvTsOWY0l5BOx3jyri6TaQxOuUDBbLihcaUpqCDqkygif/e5ZB1F2BN7O7ZVL
         mFUzIRoFJHih2NTINpHz9yjjEfNox4szVNS3u96AfPBBLgsuO8FihRM9wWjnztP1rCKz
         fMOoAth1zAoLHRjo6qXGDy++nIcH2KoI0XVvESbH2HYV66iQs5bYx397i/Iv4MUNWCQp
         jVo2tEvOVe+muZIRpZBUDJgqkLgaZ7owlhEfZLhsSFmMzfKNHALQW1z9ttOSavw9OTOs
         5AGod12OVQHjKBUiLMwsf+ehS98thckg7ekS1XZPJRXdNFJY40CCsxpQi8CbyvC8sWtm
         qwGQ==
X-Gm-Message-State: ACgBeo1NGZF0zHZPre405ZcRnsixlVxKZrxJHdLSBW9H62e5niJEAUhg
        zqLf+CrSIQW5N2G/E2awRnoJog==
X-Google-Smtp-Source: AA6agR5taYArk1YOKro99OTHpX33r4AG9UeMtVVV+fib3gIKgXtUyF6plgJVOC6YsJ2fc3Ydlt3aAQ==
X-Received: by 2002:a17:902:cec1:b0:172:e677:553b with SMTP id d1-20020a170902cec100b00172e677553bmr23672198plg.99.1661909647189;
        Tue, 30 Aug 2022 18:34:07 -0700 (PDT)
Received: from jwerner-p920.mtv.corp.google.com ([2620:15c:202:201:2e75:b9a4:fb1:b1b8])
        by smtp.gmail.com with ESMTPSA id t10-20020a170902e84a00b00174f4316c24sm4261382plg.245.2022.08.30.18.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 18:34:06 -0700 (PDT)
From:   Julius Werner <jwerner@chromium.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Doug Anderson <dianders@chromium.org>,
        Jian-Jia Su <jjsu@google.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Julius Werner <jwerner@chromium.org>
Subject: [PATCH 1/4] dt-bindings: memory: Factor out common properties of LPDDR bindings
Date:   Tue, 30 Aug 2022 18:33:56 -0700
Message-Id: <20220831013359.1807905-2-jwerner@chromium.org>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
In-Reply-To: <20220831013359.1807905-1-jwerner@chromium.org>
References: <20220831013359.1807905-1-jwerner@chromium.org>
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

This also un-deprecates the manufacturer ID property for LPDDR3 (and
introduces it to LPDDR2), since it was found that having this
information available in a separate property can be useful in some
cases.

Signed-off-by: Julius Werner <jwerner@chromium.org>
---
 .../ddr/jedec,lpddr-props.yaml                | 60 +++++++++++++++++++
 .../memory-controllers/ddr/jedec,lpddr2.yaml  | 40 ++-----------
 .../memory-controllers/ddr/jedec,lpddr3.yaml  | 39 ++----------
 3 files changed, 68 insertions(+), 71 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr-props.yaml

diff --git a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr-props.yaml b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr-props.yaml
new file mode 100644
index 00000000000000..8b31c60ea2435b
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr-props.yaml
@@ -0,0 +1,60 @@
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
+  manufacturer-id:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Manufacturer ID read from Mode Register 5.
+    minimum: 0
+    maximum: 255
+
+  revision-id:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description:
+      Revision IDs read from Mode Register 6 and 7. One byte per uint32 cell (i.e. <MR6 MR7>).
+    minItems: 2
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
+      - 32
+      - 16
+      - 8
+
+additionalProperties: true
diff --git a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr2.yaml b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr2.yaml
index 9d78f140609b6c..63c47235cb9896 100644
--- a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr2.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr2.yaml
@@ -6,6 +6,9 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: LPDDR2 SDRAM compliant to JEDEC JESD209-2
 
+allOf:
+  - $ref: "jedec,lpddr-props.yaml#"
+
 maintainers:
   - Krzysztof Kozlowski <krzk@kernel.org>
 
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
index 48908a19473c3f..5969166cdc9e0f 100644
--- a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr3.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr3.yaml
@@ -6,6 +6,9 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: LPDDR3 SDRAM compliant to JEDEC JESD209-3
 
+allOf:
+  - $ref: "jedec,lpddr-props.yaml#"
+
 maintainers:
   - Krzysztof Kozlowski <krzk@kernel.org>
 
@@ -20,40 +23,6 @@ properties:
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
-  manufacturer-id:
-    $ref: /schemas/types.yaml#/definitions/uint32
-    description: |
-      Manufacturer ID value read from Mode Register 5.  The property is
-      deprecated, manufacturer should be derived from the compatible.
-    deprecated: true
-
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
@@ -206,7 +175,7 @@ required:
   - density
   - io-width
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.31.0

