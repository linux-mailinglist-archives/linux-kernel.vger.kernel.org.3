Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBEDD4A5B7A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 12:48:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237485AbiBALsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 06:48:37 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:56528
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237434AbiBALse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 06:48:34 -0500
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id CA1123F1FD
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 11:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643716109;
        bh=wQ7LXiPof6IMw8aL2q+JYN7M9eGDaZpG8RUm/afPGLI=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=PAXFdCcHg9D9MGnw7sK08ib7bwp7VgerCAGBFYVufaHvPC3wTFsqIHkOCKWku2qno
         OiAs9WYmx1XUa0pH79vohzYjyjx3t4aWuPFfDMZX0+DMa8gJJK3j5Z6K2i1AIqwcDq
         I+6Bw8O3ahjsr5pqwKyOtj/y091lDie11oqC7aysGS/UuK7UVtahaV+lubpRtWoaSs
         F7S5FyVmD70wUfxjZKwHCr4o8rVQvpm7B+6W9zjOq/PQXrSaTWvIU1qj4OPVa+j6WJ
         s9z/6QSnMEriq00IOFul1NkCTnSqr9UdtDaHgmHcQMKVYDDQDcVOXdaVC+ubKF0AHK
         bkNmiwEy64NzA==
Received: by mail-ej1-f71.google.com with SMTP id 9-20020a170906218900b0065e2a9110b9so6428287eju.11
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 03:48:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wQ7LXiPof6IMw8aL2q+JYN7M9eGDaZpG8RUm/afPGLI=;
        b=WSl+HwduxEzuATUx/rd6KiBCKLagDl1IsanEcxe/qAg+Gl8wiBFUgGhEqziQq90O4r
         OTXaQByXJEw9N7SDigKFxNDv3Cj4xeTa2119aLEjDsFaHqb3GcLQXg1WZ/qmUO0eNWbC
         tYMS+3V2Cl/gpH0dqtQvYOSGRDJxnUeSdB1uqfvEAfVpTm92xC+Qm9rB8nVmtNq3knXD
         6cCErLPZYPKi4y2WE+QSeBS0w85uRhGVyJppJS6kQcmgNg4lz/BAfYOBN2tgRSgqBzBv
         rkCpUyIlwUxgSE7onbbjTE3FxqPi0FuR6oUWjpx4so0jAWvFijiQEQCIZPt6g5NIrEn6
         7b+g==
X-Gm-Message-State: AOAM5339NHq1Dj/VzAcou0PWaSh3qgBmeNZEgSTanVNi2990fcqLayHa
        gSBoaPQ/BOyW05dYOExxO6lioqmNUJH90oNFzH6Hs+jf2x3dYuidsFHFuh+AfBsVAy8ZVikSl/a
        hVYUMLPL+TwJxKShBk5fhGGqNCDiLz/1JxtxC7RlydA==
X-Received: by 2002:aa7:d1d4:: with SMTP id g20mr24934232edp.296.1643716108524;
        Tue, 01 Feb 2022 03:48:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz3KvejSRP8XZF4mm33Vo+og/yd0Iu/L/N3KWBXvK3ZpTdVbOdRwR97tU2Yb/X7gw3TbKUbHw==
X-Received: by 2002:aa7:d1d4:: with SMTP id g20mr24934210edp.296.1643716108233;
        Tue, 01 Feb 2022 03:48:28 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id bo19sm17954484edb.56.2022.02.01.03.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 03:48:27 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH 2/6] dt-bindings: memory: lpddr3: convert to dtschema
Date:   Tue,  1 Feb 2022 12:47:45 +0100
Message-Id: <20220201114749.88500-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220201114749.88500-1-krzysztof.kozlowski@canonical.com>
References: <20220201114749.88500-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the LPDDR3 memory bindings to DT schema format.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../memory-controllers/ddr/jedec,lpddr3.yaml  | 266 ++++++++++++++++++
 .../memory-controllers/ddr/lpddr3.txt         | 107 -------
 2 files changed, 266 insertions(+), 107 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr3.yaml
 delete mode 100644 Documentation/devicetree/bindings/memory-controllers/ddr/lpddr3.txt

diff --git a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr3.yaml b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr3.yaml
new file mode 100644
index 000000000000..c8577186324a
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr3.yaml
@@ -0,0 +1,266 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/memory-controllers/ddr/jedec,lpddr3.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: LPDDR3 SDRAM compliant to JEDEC JESD209-3
+
+maintainers:
+  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - samsung,K3QF2F20DB
+      - const: jedec,lpddr3
+
+  '#address-cells':
+    const: 1
+
+  density:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Density in megabits of SDRAM chip.
+    enum:
+      - 4096
+      - 8192
+      - 16384
+      - 32768
+
+  io-width:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      IO bus width in bits of SDRAM chip.
+    enum:
+      - 64
+      - 32
+      - 16
+      - 8
+
+  manufacturer-id:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Manufacturer ID value read from Mode Register 5.
+
+  revision-id:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 2
+    maxItems: 2
+    items:
+      maximum: 255
+    description: |
+      Revision value of SDRAM chip read from Mode Registers 6 and 7.
+
+  '#size-cells':
+    const: 0
+
+  tCKE-min-tck:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    maximum: 15
+    description: |
+      CKE minimum pulse width (HIGH and LOW pulse width) in terms of number
+      of clock cycles.
+
+  tCKESR-min-tck:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    maximum: 15
+    description: |
+      CKE minimum pulse width during SELF REFRESH (low pulse width during
+      SELF REFRESH) in terms of number of clock cycles.
+
+  tDQSCK-min-tck:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    maximum: 15
+    description: |
+      DQS output data access time from CK_t/CK_c in terms of number of clock
+      cycles.
+
+  tFAW-min-tck:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    maximum: 63
+    description: |
+      Four-bank activate window in terms of number of clock cycles.
+
+  tMRD-min-tck:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    maximum: 15
+    description: |
+      Mode register set command delay in terms of number of clock cycles.
+
+  tR2R-C2C-min-tck:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1]
+    description: |
+      Additional READ-to-READ delay in chip-to-chip cases in terms of number
+      of clock cycles.
+
+  tRAS-min-tck:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    maximum: 63
+    description: |
+      Row active time in terms of number of clock cycles.
+
+  tRC-min-tck:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    maximum: 63
+    description: |
+      ACTIVATE-to-ACTIVATE command period in terms of number of clock cycles.
+
+  tRCD-min-tck:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    maximum: 15
+    description: |
+      RAS-to-CAS delay in terms of number of clock cycles.
+
+  tRFC-min-tck:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    maximum: 255
+    description: |
+      Refresh Cycle time in terms of number of clock cycles.
+
+  tRL-min-tck:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    maximum: 15
+    description: |
+     READ data latency in terms of number of clock cycles.
+
+  tRPab-min-tck:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    maximum: 15
+    description: |
+      Row precharge time (all banks) in terms of number of clock cycles.
+
+  tRPpb-min-tck:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    maximum: 15
+    description: |
+      Row precharge time (single banks) in terms of number of clock cycles.
+
+  tRRD-min-tck:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    maximum: 15
+    description: |
+      Active bank A to active bank B in terms of number of clock cycles.
+
+  tRTP-min-tck:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    maximum: 15
+    description: |
+      Internal READ to PRECHARGE command delay in terms of number of clock
+      cycles.
+
+  tW2W-C2C-min-tck:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1]
+    description: |
+      Additional WRITE-to-WRITE delay in chip-to-chip cases in terms of number
+      of clock cycles.
+
+  tWL-min-tck:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    maximum: 15
+    description: |
+      WRITE data latency in terms of number of clock cycles.
+
+  tWR-min-tck:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    maximum: 15
+    description: |
+      WRITE recovery time in terms of number of clock cycles.
+
+  tWTR-min-tck:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    maximum: 15
+    description: |
+      Internal WRITE-to-READ command delay in terms of number of clock cycles.
+
+  tXP-min-tck:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    maximum: 255
+    description: |
+      Exit power-down to next valid command delay in terms of number of clock
+      cycles.
+
+  tXSR-min-tck:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    maximum: 1023
+    description: |
+      SELF REFRESH exit to next valid command delay in terms of number of clock
+      cycles.
+
+patternProperties:
+  "^timings@[0-9a-f]+$":
+    type: object
+    description: |
+      The lpddr3 node may have one or more child nodes with timings.
+      Each timing node provides AC timing parameters of the device for a given
+      speed-bin. The user may provide the timings for as many speed-bins as is
+      required. For more information please see::
+      Documentation/devicetree/bindings/memory-controllers/ddr/lpddr3-timings.txt
+
+required:
+  - compatible
+  - '#address-cells'
+  - density
+  - io-width
+  - '#size-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    lpddr3 {
+        compatible = "samsung,K3QF2F20DB", "jedec,lpddr3";
+        density = <16384>;
+        io-width = <32>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        tCKE-min-tck = <2>;
+        tCKESR-min-tck = <2>;
+        tDQSCK-min-tck = <5>;
+        tFAW-min-tck = <5>;
+        tMRD-min-tck = <5>;
+        tR2R-C2C-min-tck = <0>;
+        tRAS-min-tck = <5>;
+        tRC-min-tck = <6>;
+        tRCD-min-tck = <3>;
+        tRFC-min-tck = <17>;
+        tRL-min-tck = <14>;
+        tRPab-min-tck = <2>;
+        tRPpb-min-tck = <2>;
+        tRRD-min-tck = <2>;
+        tRTP-min-tck = <2>;
+        tW2W-C2C-min-tck = <0>;
+        tWL-min-tck = <8>;
+        tWR-min-tck = <7>;
+        tWTR-min-tck = <2>;
+        tXP-min-tck = <2>;
+        tXSR-min-tck = <12>;
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
diff --git a/Documentation/devicetree/bindings/memory-controllers/ddr/lpddr3.txt b/Documentation/devicetree/bindings/memory-controllers/ddr/lpddr3.txt
deleted file mode 100644
index 031af5fb0379..000000000000
--- a/Documentation/devicetree/bindings/memory-controllers/ddr/lpddr3.txt
+++ /dev/null
@@ -1,107 +0,0 @@
-* LPDDR3 SDRAM memories compliant to JEDEC JESD209-3C
-
-Required properties:
-- compatible : Should be "<vendor>,<type>", and generic value "jedec,lpddr3".
-  Example "<vendor>,<type>" values:
-    "samsung,K3QF2F20DB"
-
-- density  : <u32> representing density in Mb (Mega bits)
-- io-width : <u32> representing bus width. Possible values are 8, 16, 32, 64
-- #address-cells: Must be set to 1
-- #size-cells: Must be set to 0
-
-Optional properties:
-
-- manufacturer-id : <u32>     Manufacturer ID value read from Mode Register 5
-- revision-id     : <u32 u32> Revision IDs read from Mode Registers 6 and 7
-
-The following optional properties represent the minimum value of some AC
-timing parameters of the DDR device in terms of number of clock cycles.
-These values shall be obtained from the device data-sheet.
-- tRFC-min-tck
-- tRRD-min-tck
-- tRPab-min-tck
-- tRPpb-min-tck
-- tRCD-min-tck
-- tRC-min-tck
-- tRAS-min-tck
-- tWTR-min-tck
-- tWR-min-tck
-- tRTP-min-tck
-- tW2W-C2C-min-tck
-- tR2R-C2C-min-tck
-- tWL-min-tck
-- tDQSCK-min-tck
-- tRL-min-tck
-- tFAW-min-tck
-- tXSR-min-tck
-- tXP-min-tck
-- tCKE-min-tck
-- tCKESR-min-tck
-- tMRD-min-tck
-
-Child nodes:
-- The lpddr3 node may have one or more child nodes of type "lpddr3-timings".
-  "lpddr3-timings" provides AC timing parameters of the device for
-  a given speed-bin. Please see
-  Documentation/devicetree/bindings/memory-controllers/ddr/lpddr3-timings.txt
-  for more information on "lpddr3-timings"
-
-Example:
-
-samsung_K3QF2F20DB: lpddr3 {
-	compatible	= "samsung,K3QF2F20DB", "jedec,lpddr3";
-	density		= <16384>;
-	io-width	= <32>;
-	manufacturer-id = <1>;
-	revision-id     = <123 234>;
-	#address-cells	= <1>;
-	#size-cells	= <0>;
-
-	tRFC-min-tck		= <17>;
-	tRRD-min-tck		= <2>;
-	tRPab-min-tck		= <2>;
-	tRPpb-min-tck		= <2>;
-	tRCD-min-tck		= <3>;
-	tRC-min-tck		= <6>;
-	tRAS-min-tck		= <5>;
-	tWTR-min-tck		= <2>;
-	tWR-min-tck		= <7>;
-	tRTP-min-tck		= <2>;
-	tW2W-C2C-min-tck	= <0>;
-	tR2R-C2C-min-tck	= <0>;
-	tWL-min-tck		= <8>;
-	tDQSCK-min-tck		= <5>;
-	tRL-min-tck		= <14>;
-	tFAW-min-tck		= <5>;
-	tXSR-min-tck		= <12>;
-	tXP-min-tck		= <2>;
-	tCKE-min-tck		= <2>;
-	tCKESR-min-tck		= <2>;
-	tMRD-min-tck		= <5>;
-
-	timings_samsung_K3QF2F20DB_800mhz: lpddr3-timings@800000000 {
-		compatible	= "jedec,lpddr3-timings";
-		/* workaround: 'reg' shows max-freq */
-		reg		= <800000000>;
-		min-freq	= <100000000>;
-		tRFC		= <65000>;
-		tRRD		= <6000>;
-		tRPab		= <12000>;
-		tRPpb		= <12000>;
-		tRCD		= <10000>;
-		tRC		= <33750>;
-		tRAS		= <23000>;
-		tWTR		= <3750>;
-		tWR		= <7500>;
-		tRTP		= <3750>;
-		tW2W-C2C	= <0>;
-		tR2R-C2C	= <0>;
-		tFAW		= <25000>;
-		tXSR		= <70000>;
-		tXP		= <3750>;
-		tCKE		= <3750>;
-		tCKESR		= <3750>;
-		tMRD		= <7000>;
-	};
-}
-- 
2.32.0

