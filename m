Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C51FB4AAFC1
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 14:59:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241790AbiBFN7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 08:59:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241292AbiBFN62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 08:58:28 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846B8C0401CE
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 05:58:22 -0800 (PST)
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 14E3640329
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 13:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644155896;
        bh=rFw9l+85dJtOxzK1IePAzxypjCG9mduHp5NIQ70SgQY=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=k9IVOEpp+QjShU0hv9yfDtjs+2u4p6QaepxjLZS6Ej7BzDPrcYGY+HXlVQer3F03E
         eIk0vloihPLNmw4TjHUl9qS6D2rPGOZD69riGEFmzqwvsFMX0tUPTPYKkx7q6uIQ6t
         93jixoe0+HYHRi//q4bZyh3dAnFRLH598611zVh4tVx0F3h7dzy0e0ogV+oqaXQUL2
         jIha36EXZUIM+XVWS9XMnD1JrrtX2RGrUP7mGxwKh4QV9uR28s7a1EyCmSTAYl+WWl
         QnwiKd7TssWT/84ynyJeeC2uN4kpXoQ1yFvLvxuqFOtSnCFDiz2tewhjp72Yaiuz/o
         5oaD1s+7ZHw5w==
Received: by mail-wm1-f72.google.com with SMTP id h82-20020a1c2155000000b003552c13626cso6186259wmh.3
        for <linux-kernel@vger.kernel.org>; Sun, 06 Feb 2022 05:58:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rFw9l+85dJtOxzK1IePAzxypjCG9mduHp5NIQ70SgQY=;
        b=5Rep0ac7JzIHh2P+RWqhno/7QM+SFOi7hVdc1HfcZ4eab8Ci88+Kb5dnKwOh6v9JyJ
         Eqk5OIL2u/IECwCN627R+RkNo2EE2xqMvpp14UPpr/QMHGf10DiiAa9Te+FwHbLlhbHn
         A+Oh2U0Qcc9sdrN8tio5h9cSnnpF9fFDAmgiBai9QGxD7tq7Bep+LSXvLokq6FvoXU5/
         WuNDWfAL7g/KhTJjIuxUaSY6jRgpEaMpT/VP4gTudeyP311Xh7LKHHoy0vxiT0GXghA4
         GcVB7AwHTrUTcRd5ToMBhY1IhHorpDBB4HX/nAKzHSwFW9hr6SxXAg4UBU6Nv2rflObt
         7jqQ==
X-Gm-Message-State: AOAM533uTzvvKT6vpUeqD0AFvcfmWvb8H482v0pFPQW6mGtDprwKar6j
        w0SixdAzE2/SKW6MK9E9fQnc3NNYvQXXnAVvicK5/FRDtfCQmVk5ARXh67WT3HggMgq7YzwtBFL
        pBzkIZaw6BCCS9lIKH2NijNDeHJjFRQC6xZKj8HW1gw==
X-Received: by 2002:a05:600c:491:: with SMTP id d17mr10092576wme.130.1644155895566;
        Sun, 06 Feb 2022 05:58:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw1IZBDNXRWJ0qWdLWUtZri4Y1fEcK37M2Hc8URD6XUC5A9Ckq9s/y+aIikyLKZ0ScCl082xw==
X-Received: by 2002:a05:600c:491:: with SMTP id d17mr10092552wme.130.1644155895343;
        Sun, 06 Feb 2022 05:58:15 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id e9sm8296888wrg.60.2022.02.06.05.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Feb 2022 05:58:14 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 3/8] dt-bindings: memory: lpddr3: convert to dtschema
Date:   Sun,  6 Feb 2022 14:58:02 +0100
Message-Id: <20220206135807.211767-4-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220206135807.211767-1-krzysztof.kozlowski@canonical.com>
References: <20220206135807.211767-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the LPDDR3 memory bindings to DT schema format.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../memory-controllers/ddr/jedec,lpddr3.yaml  | 265 ++++++++++++++++++
 .../memory-controllers/ddr/lpddr3.txt         | 107 -------
 .../samsung,exynos5422-dmc.yaml               |   3 +-
 3 files changed, 266 insertions(+), 109 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr3.yaml
 delete mode 100644 Documentation/devicetree/bindings/memory-controllers/ddr/lpddr3.txt

diff --git a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr3.yaml b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr3.yaml
new file mode 100644
index 000000000000..e36f3607e25a
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr3.yaml
@@ -0,0 +1,265 @@
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
+    $ref: jedec,lpddr3-timings.yaml
+    description: |
+      The lpddr3 node may have one or more child nodes with timings.
+      Each timing node provides AC timing parameters of the device for a given
+      speed-bin. The user may provide the timings for as many speed-bins as is
+      required.
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
diff --git a/Documentation/devicetree/bindings/memory-controllers/samsung,exynos5422-dmc.yaml b/Documentation/devicetree/bindings/memory-controllers/samsung,exynos5422-dmc.yaml
index 895c3b5c9aaa..f152243f6b18 100644
--- a/Documentation/devicetree/bindings/memory-controllers/samsung,exynos5422-dmc.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/samsung,exynos5422-dmc.yaml
@@ -53,8 +53,7 @@ properties:
     $ref: '/schemas/types.yaml#/definitions/phandle'
     description: |
       phandle of the connected DRAM memory device. For more information please
-      refer to documentation file:
-      Documentation/devicetree/bindings/memory-controllers/ddr/lpddr3.txt
+      refer to jedec,lpddr3.yaml.
 
   operating-points-v2: true
 
-- 
2.32.0

