Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9A054AA884
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 13:01:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236287AbiBEMBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 07:01:09 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:44404
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1379748AbiBEMA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 07:00:58 -0500
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 191B840039
        for <linux-kernel@vger.kernel.org>; Sat,  5 Feb 2022 12:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644062457;
        bh=WADk9zGuYiMHMUgeqEWKXcx1LnePmBdOwPQaJwQS8DQ=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=ZxfxFSmt/TEuN2/C/oy//dCrtaBjiBmzGCb8QQylhStcOwHGV6Oa8/AtJFQDORFJT
         3hg3EwAnLa2+TL9EnEJxy6WMWHvJtZOY/L0zZdD4Dlona1z52LlVaXWspJhfMTsDhC
         WLsg33C5Ij3d7RFnSuQEO7sqEa/JNWQA6+o21IU8uDova2ZFWOp1BRYJHcENtDtue+
         oJu/+H4qy4/arv1aOwzcEteufaf0OG20qDVN+opl9ROuEvplGZGJLx/GY2IIJgBXvQ
         Q6Wk+GDNmAUenfFOfkYioR3HwUCsgeHs7ou0N3KNYpJZmJnpxrxy/l+Ew9VhorANYF
         UVit+dONuW1Mg==
Received: by mail-ed1-f72.google.com with SMTP id l16-20020aa7c3d0000000b004070ea10e7fso4540144edr.3
        for <linux-kernel@vger.kernel.org>; Sat, 05 Feb 2022 04:00:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WADk9zGuYiMHMUgeqEWKXcx1LnePmBdOwPQaJwQS8DQ=;
        b=wvEyhkvg2Y4wV2u8DUHpVHt+/Mckel5S5WRh9DKNRZKrD1m/vn6l+Y25yqMrxmk+6B
         kEr6BJOLdCrqY1vyJbz2zx1Z1/YkvIzdmGc7/LLR2nZcpMNjCj1gN9Jrb1uE3HWkhQk7
         e3qVBHIiIdChIjOk0c13z//NXf83SWXx+FJ6eznY/E4Mqpb3ReYlOWviLUbFZ3TrTUR6
         yl3OjrhPO4rFqsfpAA3HSt/5Zg/ykoNaBMMa5lG4oaTCmwgCiotAQvee/MDe6XbCjxo8
         WU2HCBcuqjX668QOIgIySLstMgN/LqMdO9zwyUWNe9h9t916wsDDWB7K1NxW2T5fP+a/
         phuA==
X-Gm-Message-State: AOAM533E1agNuCfnXjkcp8ufIcSqArgj1FBNd/yc1pB1oiNY4PzG58Kv
        trIDTWaJARWWUwDE5C2FCsom8q+E1NFsQt7PRcMO72PGTO5G0RSSJkWalDdVqv7975fRByJnhzL
        E9DS/xu1Ar7EfA2xLtlKaTBEBpn2iPyGyoTIqovptWg==
X-Received: by 2002:a17:907:1115:: with SMTP id qu21mr500660ejb.192.1644062456582;
        Sat, 05 Feb 2022 04:00:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwdDb/Oy63JfThb6RHO+fcj4vWXFUEzdGR2GMzdot79rG2sem5U9YQ+tSHyyR37SQhyj/6jfw==
X-Received: by 2002:a17:907:1115:: with SMTP id qu21mr500639ejb.192.1644062456285;
        Sat, 05 Feb 2022 04:00:56 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id m12sm1534185ejr.218.2022.02.05.04.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Feb 2022 04:00:55 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2 4/5] dt-bindings: memory: lpddr3-timings: convert to dtschema
Date:   Sat,  5 Feb 2022 13:00:42 +0100
Message-Id: <20220205120043.8337-5-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220205120043.8337-1-krzysztof.kozlowski@canonical.com>
References: <20220205120043.8337-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the LPDDR3 memory timings bindings to DT schema format.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../ddr/jedec,lpddr3-timings.yaml             | 153 ++++++++++++++++++
 .../memory-controllers/ddr/jedec,lpddr3.yaml  |   5 +-
 .../memory-controllers/ddr/lpddr3-timings.txt |  58 -------
 3 files changed, 155 insertions(+), 61 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr3-timings.yaml
 delete mode 100644 Documentation/devicetree/bindings/memory-controllers/ddr/lpddr3-timings.txt

diff --git a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr3-timings.yaml b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr3-timings.yaml
new file mode 100644
index 000000000000..98bc219e8a25
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr3-timings.yaml
@@ -0,0 +1,153 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/memory-controllers/ddr/jedec,lpddr3-timings.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: LPDDR3 SDRAM AC timing parameters for a given speed-bin
+
+maintainers:
+  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
+
+properties:
+  compatible:
+    const: jedec,lpddr3-timings
+
+  reg:
+    maxItems: 1
+    description: |
+      Maximum DDR clock frequency for the speed-bin, in Hz.
+
+  min-freq:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Minimum DDR clock frequency for the speed-bin, in Hz.
+
+  tCKE:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      CKE minimum pulse width (HIGH and LOW pulse width) in pico seconds.
+
+  tCKESR:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      CKE minimum pulse width during SELF REFRESH (low pulse width during
+      SELF REFRESH) in pico seconds.
+
+  tFAW:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Four-bank activate window in pico seconds.
+
+  tMRD:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Mode register set command delay in pico seconds.
+
+  tR2R-C2C:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Additional READ-to-READ delay in chip-to-chip cases in pico seconds.
+
+  tRAS:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Row active time in pico seconds.
+
+  tRC:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      ACTIVATE-to-ACTIVATE command period in pico seconds.
+
+  tRCD:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      RAS-to-CAS delay in pico seconds.
+
+  tRFC:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Refresh Cycle time in pico seconds.
+
+  tRPab:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Row precharge time (all banks) in pico seconds.
+
+  tRPpb:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Row precharge time (single banks) in pico seconds.
+
+  tRRD:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Active bank A to active bank B in pico seconds.
+
+  tRTP:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Internal READ to PRECHARGE command delay in pico seconds.
+
+  tW2W-C2C:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Additional WRITE-to-WRITE delay in chip-to-chip cases in pico seconds.
+
+  tWR:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      WRITE recovery time in pico seconds.
+
+  tWTR:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Internal WRITE-to-READ command delay in pico seconds.
+
+  tXP:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Exit power-down to next valid command delay in pico seconds.
+
+  tXSR:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      SELF REFRESH exit to next valid command delay in pico seconds.
+
+required:
+  - compatible
+  - min-freq
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    lpddr3 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        timings@800000000 {
+            compatible = "jedec,lpddr3-timings";
+            reg = <800000000>;
+            min-freq = <100000000>;
+            tCKE = <3750>;
+            tCKESR = <3750>;
+            tFAW = <25000>;
+            tMRD = <7000>;
+            tR2R-C2C = <0>;
+            tRAS = <23000>;
+            tRC = <33750>;
+            tRCD = <10000>;
+            tRFC = <65000>;
+            tRPab = <12000>;
+            tRPpb = <12000>;
+            tRRD = <6000>;
+            tRTP = <3750>;
+            tW2W-C2C = <0>;
+            tWR = <7500>;
+            tWTR = <3750>;
+            tXP = <3750>;
+            tXSR = <70000>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr3.yaml b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr3.yaml
index 138c57d8a375..3bcba15098ea 100644
--- a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr3.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr3.yaml
@@ -192,13 +192,12 @@ properties:
 
 patternProperties:
   "^timings@[0-9a-f]+$":
-    type: object
+    $ref: jedec,lpddr3-timings.yaml
     description: |
       The lpddr3 node may have one or more child nodes with timings.
       Each timing node provides AC timing parameters of the device for a given
       speed-bin. The user may provide the timings for as many speed-bins as is
-      required. For more information please see::
-      Documentation/devicetree/bindings/memory-controllers/ddr/lpddr3-timings.txt
+      required.
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/memory-controllers/ddr/lpddr3-timings.txt b/Documentation/devicetree/bindings/memory-controllers/ddr/lpddr3-timings.txt
deleted file mode 100644
index 84705e50a3fd..000000000000
--- a/Documentation/devicetree/bindings/memory-controllers/ddr/lpddr3-timings.txt
+++ /dev/null
@@ -1,58 +0,0 @@
-* AC timing parameters of LPDDR3 memories for a given speed-bin.
-
-The structures are based on LPDDR2 and extended where needed.
-
-Required properties:
-- compatible : Should be "jedec,lpddr3-timings"
-- min-freq : minimum DDR clock frequency for the speed-bin. Type is <u32>
-- reg : maximum DDR clock frequency for the speed-bin. Type is <u32>
-
-Optional properties:
-
-The following properties represent AC timing parameters from the memory
-data-sheet of the device for a given speed-bin. All these properties are
-of type <u32> and the default unit is ps (pico seconds).
-- tRFC
-- tRRD
-- tRPab
-- tRPpb
-- tRCD
-- tRC
-- tRAS
-- tWTR
-- tWR
-- tRTP
-- tW2W-C2C
-- tR2R-C2C
-- tFAW
-- tXSR
-- tXP
-- tCKE
-- tCKESR
-- tMRD
-
-Example:
-
-timings_samsung_K3QF2F20DB_800mhz: lpddr3-timings@800000000 {
-	compatible	= "jedec,lpddr3-timings";
-	reg		= <800000000>; /* workaround: it shows max-freq */
-	min-freq	= <100000000>;
-	tRFC		= <65000>;
-	tRRD		= <6000>;
-	tRPab		= <12000>;
-	tRPpb		= <12000>;
-	tRCD		= <10000>;
-	tRC		= <33750>;
-	tRAS		= <23000>;
-	tWTR		= <3750>;
-	tWR		= <7500>;
-	tRTP		= <3750>;
-	tW2W-C2C	= <0>;
-	tR2R-C2C	= <0>;
-	tFAW		= <25000>;
-	tXSR		= <70000>;
-	tXP		= <3750>;
-	tCKE		= <3750>;
-	tCKESR		= <3750>;
-	tMRD		= <7000>;
-};
-- 
2.32.0

