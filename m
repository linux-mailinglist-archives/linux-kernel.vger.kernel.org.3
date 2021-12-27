Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A267480358
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 19:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbhL0SdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 13:33:05 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:59440
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231704AbhL0SdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 13:33:03 -0500
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com [209.85.208.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 059B2402DE
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 18:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1640629977;
        bh=i54sREsIiziNBvMfagruvxn2qixoZveyXs+MJUzMCDQ=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=gBAGx34FitmlyBt0oy/fmNfty199IsOby3v1G5vKTKlBiWN+6aIKS7Da1jvhZHXXx
         hnLJYs3O0lravlinA53/YZ6yWdL44og2+4AuSGnRMj69ic6FvyWHfCiRUrX/d7vZcQ
         ldwkzivnzVE0GimvWJ2dsDihLv1RquCIBegxr0x0oBJhPtajFNsOnulvP5nDrd9w1N
         A+ZaXq+dTbApTFTF7sWxWQMglKCWYM75L35J8lEaxI7ofOPMtjqS8p6dPtj04fQM67
         6W35JplYS+JnZ45XCrG6MAcVS+42EM1Mzd44D5w6lRMUU94y4UbiTPeqas4bKMXyST
         Ev38VMn8xudmg==
Received: by mail-lj1-f200.google.com with SMTP id r20-20020a2eb894000000b0021a4e932846so5289728ljp.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 10:32:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i54sREsIiziNBvMfagruvxn2qixoZveyXs+MJUzMCDQ=;
        b=WAQ771PU8INzeCTk8Lj6rU7JIFkoUPdL3yrro6Jl2yArdoJ9Q7Yxe99Td6G3PUeH1K
         MK5GPkkmUuPiFpWpWL/vaw4uCeIhFge6FPU/dDETh06L7v6dK45Pq1h9cB90FY4xqQy4
         Q1HB9qppeNOF7OSkvFWn1f0DGYEsUitqtci2V3rLy8gF/J8Alth6rtkjcpMWMCgwgUEx
         l0Z9hrsLibt0GtxU6fM5wv8SqFd5f/cnPn5FvcPoheyf7z+nv2ujRKoA3ZsbKcYSrqx4
         W2VRRiOCl9dzZ0Dabu8U9g+q+e4RKY1NT8wLbM/wEwaubUZEl12jO60nV36o3SkLW0R6
         iZCg==
X-Gm-Message-State: AOAM531TbjptAwsx8WOkDjxDyp2kvFP3Lyx4/eaijBYI6TiSKSVFb39H
        4BI4g6N5cQyHwCSKmP06+RUua5tcXcr0I4zcDkEv6st7j/Ohx5o9grMvdgMk9tHdW5IuTY00bRP
        fkX7NAv5CTQYrT0wx3XlyWdUEMUubb1AC1A+nbCz5Qg==
X-Received: by 2002:a05:6512:139e:: with SMTP id p30mr16310383lfa.492.1640629976307;
        Mon, 27 Dec 2021 10:32:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxAZ3WEqusbAy4q7yWvfndZFSCKKy0G3HTKCX5F7Y7Ex31eIeYUwjTgsdfidX3vvAEfthquPg==
X-Received: by 2002:a05:6512:139e:: with SMTP id p30mr16310362lfa.492.1640629976089;
        Mon, 27 Dec 2021 10:32:56 -0800 (PST)
Received: from krzk-bin.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id o12sm1299622ljc.5.2021.12.27.10.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Dec 2021 10:32:55 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Khuong Dinh <khuong@os.amperecomputing.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Tony Lindgren <tony@atomide.com>, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, openbmc@lists.ozlabs.org
Subject: [PATCH 1/8] dt-bindings: rng: apm,x-gene-rng: convert APM RNG to dtschema
Date:   Mon, 27 Dec 2021 19:32:44 +0100
Message-Id: <20211227183251.132525-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the APM X-Gene RNG bindings to DT schema.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../devicetree/bindings/rng/apm,rng.txt       | 17 -------
 .../bindings/rng/apm,x-gene-rng.yaml          | 47 +++++++++++++++++++
 2 files changed, 47 insertions(+), 17 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/rng/apm,rng.txt
 create mode 100644 Documentation/devicetree/bindings/rng/apm,x-gene-rng.yaml

diff --git a/Documentation/devicetree/bindings/rng/apm,rng.txt b/Documentation/devicetree/bindings/rng/apm,rng.txt
deleted file mode 100644
index 4dde4b06cdd9..000000000000
--- a/Documentation/devicetree/bindings/rng/apm,rng.txt
+++ /dev/null
@@ -1,17 +0,0 @@
-APM X-Gene SoC random number generator.
-
-Required properties:
-
-- compatible  : should be "apm,xgene-rng"
-- reg         : specifies base physical address and size of the registers map
-- clocks      : phandle to clock-controller plus clock-specifier pair
-- interrupts  : specify the fault interrupt for the RNG device
-
-Example:
-
-	rng: rng@10520000 {
-		compatible = "apm,xgene-rng";
-		reg = <0x0 0x10520000 0x0 0x100>;
-		interrupts =   <0x0 0x41 0x4>;
-		clocks = <&rngpkaclk 0>;
-	};
diff --git a/Documentation/devicetree/bindings/rng/apm,x-gene-rng.yaml b/Documentation/devicetree/bindings/rng/apm,x-gene-rng.yaml
new file mode 100644
index 000000000000..02be143cc829
--- /dev/null
+++ b/Documentation/devicetree/bindings/rng/apm,x-gene-rng.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rng/apm,x-gene-rng.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: APM X-Gene SoC Random Number Generator
+
+maintainers:
+  - Khuong Dinh <khuong@os.amperecomputing.com>
+
+properties:
+  compatible:
+    const: apm,xgene-rng
+
+  clocks:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - clocks
+  - interrupts
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        rng@10520000 {
+            compatible = "apm,xgene-rng";
+            reg = <0x0 0x10520000 0x0 0x100>;
+            interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
+            clocks = <&rngpkaclk 0>;
+        };
+    };
-- 
2.32.0

