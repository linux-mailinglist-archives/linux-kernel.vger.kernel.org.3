Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 951A44AA880
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 13:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379812AbiBEMBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 07:01:16 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:51924
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1379765AbiBEMA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 07:00:59 -0500
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A19073FFD5
        for <linux-kernel@vger.kernel.org>; Sat,  5 Feb 2022 12:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644062458;
        bh=g79GJtLoFuJ8U8Z2lTNpbcsjEt2E+NY0Ue5nQV27Nic=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=tABg2deBDOrojsLWYyxJt4k0cRiRdRF8f8Yq8DyhZT9PFYKdoRbFSf9DYrwaQ0wSb
         N9CVkIAsms0Z/CmNZf1kRlE6aak/spqC5T/JSK3SFAzLLWajBwpmnMU851e1Q1+Zto
         DZmMG0wKcWLVo121sYl91C3TFpK5fYOfnglqG9CRm9bzSBy5CdMYM84jCUbhVqmYCE
         vJv2Ys5oCcB8QLcKDnw4ohiTufTR0nLPncikjtwSez4jIGDkCHbNqlr+NA97no3yBU
         wPaSVT7FueL1RBIQILqgDTDvFE8sLFNWIBH6lKdif5TLP/Qim+ub4zQFyVrkn/O91+
         sFUKIQ+k/DRFw==
Received: by mail-ed1-f71.google.com with SMTP id l16-20020aa7c3d0000000b004070ea10e7fso4540187edr.3
        for <linux-kernel@vger.kernel.org>; Sat, 05 Feb 2022 04:00:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g79GJtLoFuJ8U8Z2lTNpbcsjEt2E+NY0Ue5nQV27Nic=;
        b=urHLIizA62jvzO0Zcwu4FM+B67MJ3ernRFAw2KPPDj+6nuYILRewtQMRJeSjnwY89r
         /bN+7uiMNiobOhVGmL+EJuhmOuWRHl7NLoad6m6R0anljqzJBeeBB7TUWJaogzfX8JQD
         9b8ngGGPuCMkP44Mr6ubrtS1gWGWoHxDj8eQmLDg0w3MlY6ERGSwG/nMaF4HlZF0tvKB
         4mmXOt/K62MqJxEYkJjvyewSywzFiXweiVer+51HbJyhmXEJVxKphsmHsXpWLx3uHKBW
         6YZWbckNZyh6HO48avOm0owoU/dDGCUV0jxFyZMq03pjnRjPONAw3lPYzMkkqe59RPCT
         Frcw==
X-Gm-Message-State: AOAM531M3ITjv6MNYV1rc0Ipal/Vc3Xv6rNqUHsLV/8XpcR9UOu71Tcf
        a77D16f+QHhwQ3n4/S8HAK2kX4lHjNn/+xJbSXMoro8Yz3nxA275Mcc44QbeNiWMyukok7v5vTp
        1hX1qffjGZmBC+EOBr9CCLFefrz6E6C7DVyufRPL6hQ==
X-Received: by 2002:a17:907:8a0b:: with SMTP id sc11mr2782012ejc.310.1644062458119;
        Sat, 05 Feb 2022 04:00:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwI6v3KzvqmMl2uZY105l1wUXzopbwZdOW3CekXIXGfOpnK+CNN19iiDFIAfjEEs6/DTmgfdA==
X-Received: by 2002:a17:907:8a0b:: with SMTP id sc11mr2781997ejc.310.1644062457861;
        Sat, 05 Feb 2022 04:00:57 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id m12sm1534185ejr.218.2022.02.05.04.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Feb 2022 04:00:56 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2 5/5] dt-bindings: memory: lpddr2-timings: convert to dtschema
Date:   Sat,  5 Feb 2022 13:00:43 +0100
Message-Id: <20220205120043.8337-6-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220205120043.8337-1-krzysztof.kozlowski@canonical.com>
References: <20220205120043.8337-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the LPDDR2 memory timings bindings to DT schema format.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../ddr/jedec,lpddr2-timings.yaml             | 135 ++++++++++++++++++
 .../memory-controllers/ddr/jedec,lpddr2.yaml  |   6 +-
 .../memory-controllers/ddr/lpddr2-timings.txt |  52 -------
 3 files changed, 137 insertions(+), 56 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr2-timings.yaml
 delete mode 100644 Documentation/devicetree/bindings/memory-controllers/ddr/lpddr2-timings.txt

diff --git a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr2-timings.yaml b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr2-timings.yaml
new file mode 100644
index 000000000000..f3e62ee07126
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr2-timings.yaml
@@ -0,0 +1,135 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/memory-controllers/ddr/jedec,lpddr2-timings.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: LPDDR2 SDRAM AC timing parameters for a given speed-bin
+
+maintainers:
+  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
+
+properties:
+  compatible:
+    const: jedec,lpddr2-timings
+
+  max-freq:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Maximum DDR clock frequency for the speed-bin, in Hz.
+
+  min-freq:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Minimum DDR clock frequency for the speed-bin, in Hz.
+
+  tCKESR:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      CKE minimum pulse width during SELF REFRESH (low pulse width during
+      SELF REFRESH) in pico seconds.
+
+  tDQSCK-max:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      DQS output data access time from CK_t/CK_c in pico seconds.
+
+  tDQSCK-max-derated:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      DQS output data access time from CK_t/CK_c, temperature de-rated, in pico
+      seconds.
+
+  tFAW:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Four-bank activate window in pico seconds.
+
+  tRAS-max-ns:
+    description: |
+      Row active time in nano seconds.
+
+  tRAS-min:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Row active time in pico seconds.
+
+  tRCD:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      RAS-to-CAS delay in pico seconds.
+
+  tRPab:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Row precharge time (all banks) in pico seconds.
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
+  tZQCL:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Long calibration time in pico seconds.
+
+  tZQCS:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Short calibration time in pico seconds.
+
+  tZQinit:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Initialization calibration time in pico seconds.
+
+required:
+  - compatible
+  - min-freq
+  - max-freq
+
+additionalProperties: false
+
+examples:
+  - |
+    timings {
+        compatible = "jedec,lpddr2-timings";
+        min-freq = <10000000>;
+        max-freq = <400000000>;
+        tCKESR = <15000>;
+        tDQSCK-max = <5500>;
+        tFAW = <50000>;
+        tRAS-max-ns = <70000>;
+        tRAS-min = <42000>;
+        tRPab = <21000>;
+        tRCD = <18000>;
+        tRRD = <10000>;
+        tRTP = <7500>;
+        tWR = <15000>;
+        tWTR = <7500>;
+        tXP = <7500>;
+        tZQCL = <360000>;
+        tZQCS = <90000>;
+        tZQinit = <1000000>;
+    };
diff --git a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr2.yaml b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr2.yaml
index 25ed0266f6dd..2d8a701e2a05 100644
--- a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr2.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr2.yaml
@@ -142,14 +142,12 @@ properties:
 
 patternProperties:
   "^lpddr2-timings":
-    type: object
+    $ref: jedec,lpddr2-timings.yaml
     description: |
       The lpddr2 node may have one or more child nodes of type "lpddr2-timings".
       "lpddr2-timings" provides AC timing parameters of the device for
       a given speed-bin. The user may provide the timings for as many
-      speed-bins as is required. Please see Documentation/devicetree/
-      bindings/memory-controllers/ddr/lpddr2-timings.txt for more information
-      on "lpddr2-timings".
+      speed-bins as is required.
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/memory-controllers/ddr/lpddr2-timings.txt b/Documentation/devicetree/bindings/memory-controllers/ddr/lpddr2-timings.txt
deleted file mode 100644
index 9ceb19e0c7fd..000000000000
--- a/Documentation/devicetree/bindings/memory-controllers/ddr/lpddr2-timings.txt
+++ /dev/null
@@ -1,52 +0,0 @@
-* AC timing parameters of LPDDR2(JESD209-2) memories for a given speed-bin
-
-Required properties:
-- compatible : Should be "jedec,lpddr2-timings"
-- min-freq : minimum DDR clock frequency for the speed-bin. Type is <u32>
-- max-freq : maximum DDR clock frequency for the speed-bin. Type is <u32>
-
-Optional properties:
-
-The following properties represent AC timing parameters from the memory
-data-sheet of the device for a given speed-bin. All these properties are
-of type <u32> and the default unit is ps (pico seconds). Parameters with
-a different unit have a suffix indicating the unit such as 'tRAS-max-ns'
-- tRCD
-- tWR
-- tRAS-min
-- tRRD
-- tWTR
-- tXP
-- tRTP
-- tDQSCK-max
-- tFAW
-- tZQCS
-- tZQinit
-- tRPab
-- tZQCL
-- tCKESR
-- tRAS-max-ns
-- tDQSCK-max-derated
-
-Example:
-
-timings_elpida_ECB240ABACN_400mhz: lpddr2-timings@0 {
-	compatible	= "jedec,lpddr2-timings";
-	min-freq	= <10000000>;
-	max-freq	= <400000000>;
-	tRPab		= <21000>;
-	tRCD		= <18000>;
-	tWR		= <15000>;
-	tRAS-min	= <42000>;
-	tRRD		= <10000>;
-	tWTR		= <7500>;
-	tXP		= <7500>;
-	tRTP		= <7500>;
-	tCKESR		= <15000>;
-	tDQSCK-max	= <5500>;
-	tFAW		= <50000>;
-	tZQCS		= <90000>;
-	tZQCL		= <360000>;
-	tZQinit		= <1000000>;
-	tRAS-max-ns	= <70000>;
-};
-- 
2.32.0

