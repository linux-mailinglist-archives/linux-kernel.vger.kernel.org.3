Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07B334A5B88
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 12:48:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237554AbiBALsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 06:48:50 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:38478
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237509AbiBALsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 06:48:40 -0500
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 648803F1C6
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 11:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643716118;
        bh=WADk9zGuYiMHMUgeqEWKXcx1LnePmBdOwPQaJwQS8DQ=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=L6TweE14jq+4LG8xxAjQmSY49CN412ofo/iohcghivY68jl3LuIupCp/RC/OCXxJQ
         tHGN9PNziWN8R7as9lkP4zjGqi1FqZnlIuxfwWsmmyQKHoKAbxQyiydbss51I0wH2u
         NkFIRpT+XFZsDNxnFe6q7wpSZP7v0H/gHL9IeDKAlpLR7n0n/5/qdHLXtjCfx8EcQB
         RxEXjuHWQp5XktMdA0Uq5ZwxgF1B+ZIEa0e4TVnsRilVqkNzcFrh63tTPY2ko5yvBV
         t2FHDT417pMcz0IItsKNeR4DsY5RzqJXH0TdudF4FJvGl2/QrKHTfURsxFM4M3fjdk
         U/o8Oim0aL0Yw==
Received: by mail-ed1-f72.google.com with SMTP id j1-20020aa7c341000000b0040417b84efeso8543523edr.21
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 03:48:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WADk9zGuYiMHMUgeqEWKXcx1LnePmBdOwPQaJwQS8DQ=;
        b=LLYD0o3/Ty4430uwPK/b3i5KNvczcuq7LvNhbup55+9AAM7gCILMVigPNKrjzwX/hT
         WGYZiGlivf0QOx/75tCdBJVaOB5kKtNqG3+ih7bLuvfDI7oyFIypLXGmnBpQfiawX/7q
         7wW7Qls1+Fo/wWOCxO53f6tlnavcgUd27cdGRELF4DXXqQqr9rOB57gB9eJ4MpIrgNw/
         +27mp+7ad0vs2PHefWPzwmKyMLyK4w/Ml/6sqQ91Eov6bSWnRBAPDQzNdM1uCWH7hmKp
         Zqr223YJy73zbxcgLgUOnpAGt7Cn8He1D1MTH8/zkQXu+K0YzpZoWhpPOqN7fbEEJ64m
         zlkw==
X-Gm-Message-State: AOAM532whE+iL59SmXUW76EtD6cOUb1VQkIlpGldiWC62N4OTTTsZPDw
        B0tp42V+BxjXv4YhqxBHeJa+/sfjkuA1C8LTQP/oTdt7GBppqiFWqQ7NRJivlE0oJ9KagbKQGGY
        0uxHI2/aWAt7WS6pHKjEjzyEMmtRMsUI7fSwPPZouYA==
X-Received: by 2002:a17:906:31cc:: with SMTP id f12mr20180715ejf.115.1643716113278;
        Tue, 01 Feb 2022 03:48:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzritvK1s6ruWejqqATTfAiWNIFOFiUVuabJlDk6yiD80KSJT2X8p45M7wsQIgsuFwujL1ONQ==
X-Received: by 2002:a17:906:31cc:: with SMTP id f12mr20180702ejf.115.1643716113054;
        Tue, 01 Feb 2022 03:48:33 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id bo19sm17954484edb.56.2022.02.01.03.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 03:48:32 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH 5/6] dt-bindings: memory: lpddr3-timings: convert to dtschema
Date:   Tue,  1 Feb 2022 12:47:48 +0100
Message-Id: <20220201114749.88500-5-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220201114749.88500-1-krzysztof.kozlowski@canonical.com>
References: <20220201114749.88500-1-krzysztof.kozlowski@canonical.com>
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

