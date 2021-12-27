Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC2F8480367
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 19:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231859AbhL0SdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 13:33:21 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:59670
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231822AbhL0SdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 13:33:12 -0500
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com [209.85.208.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 551033FFD5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 18:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1640629991;
        bh=SIUiGPqn4sHTI4wrPpQmcuGfM1myPDztAmFG+NtIpFs=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=ltWGx+39NRJjv8q8PAno7ysq5fZsET9kKXH7ApyAx9bxnykJHUh8i5yKPAS7H3eA+
         oTWeFxc9GOdINGrp12hS23BObJH7uqYQgJb7n5NLfB1oWbq1jYG8MJsnRsFMnFD5Ht
         KIj3MAr6LJkwU4bDjcG3Ih8v3+UpSZU2nRFukKM4xNnVA8Dck14hrI4KsEIRHyNhal
         2avgQMkmFJgwCgWDZHIseQiFLp8M02AORejamftKw+Fqvb4qXhK43eJlak5DKYcPXD
         KIcWDUgnmBPMTyCiAyzpJD7jGTtbiO/7hyX9DlBbvv1h4Z1jYV6mo38uLjZMVe5tW6
         a5cf7D55vpi3Q==
Received: by mail-lj1-f198.google.com with SMTP id k20-20020a2e9214000000b0022d6b13bc8aso5258853ljg.13
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 10:33:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SIUiGPqn4sHTI4wrPpQmcuGfM1myPDztAmFG+NtIpFs=;
        b=PHTzD8nvQjRK5LTEcpmNztMQ5Lo03P58usr5dvGGdBDsah2xHLXFSdzA8rWMcaA2tQ
         ZO6p7eJCVCsh+TxqWNPz+nPrAp0XtoI2rPaXYb16/W9aSxsMhzJyOE2vjPRR0OOm9bCN
         daN9krf0LQcUPQ/BAhw5r88jCGi1M5lZE7CK7JgXMLJRPs+muP4ixDjUxRVGxBIEVTPw
         4PYirncjqbXhlu37f0FIhyj0ErVkeINeoEQNWo5oeSRlqDVo17dCpSF4Dma6CxdIeDps
         Xv7ZrK/vfHdTIDHSCnNLlu3rwz1fLj6Rg7Jq4MlDdBjW0GeOm6WbB5oXOIWMv25n9JyM
         g+Uw==
X-Gm-Message-State: AOAM532Xd2OBvPhHgYQp1Z+/GzredxK8YuqE/OFhJ7PcPWOB/BcWShxH
        KTIHWbpdXGqSO3Q2bNvnl6b69SK43WtzppeHjQbgatsyARTodszRWWXnI/+vFQcKkhlGC11hmLD
        sopVZIORWYD2yWCaRCLLMkbjrdIN5I1H3gDCNH3jBjA==
X-Received: by 2002:a05:651c:1686:: with SMTP id bd6mr6422215ljb.144.1640629987086;
        Mon, 27 Dec 2021 10:33:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyiwYxvtGi5aBexdLaJuo+p/mJzCN8N3cW4pSt0ALzD1mYO4Fc/mOyRPmGVLkcxEc1Zn1IoqQ==
X-Received: by 2002:a05:651c:1686:: with SMTP id bd6mr6422189ljb.144.1640629986863;
        Mon, 27 Dec 2021 10:33:06 -0800 (PST)
Received: from krzk-bin.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id o12sm1299622ljc.5.2021.12.27.10.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Dec 2021 10:33:06 -0800 (PST)
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
Subject: [PATCH 8/8] dt-bindings: rng: timeriomem_rng: convert TimerIO RNG to dtschema
Date:   Mon, 27 Dec 2021 19:32:51 +0100
Message-Id: <20211227183251.132525-8-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211227183251.132525-1-krzysztof.kozlowski@canonical.com>
References: <20211227183251.132525-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the TimerIO RNG bindings to DT schema.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../bindings/rng/timeriomem_rng.txt           | 25 ----------
 .../bindings/rng/timeriomem_rng.yaml          | 48 +++++++++++++++++++
 2 files changed, 48 insertions(+), 25 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/rng/timeriomem_rng.txt
 create mode 100644 Documentation/devicetree/bindings/rng/timeriomem_rng.yaml

diff --git a/Documentation/devicetree/bindings/rng/timeriomem_rng.txt b/Documentation/devicetree/bindings/rng/timeriomem_rng.txt
deleted file mode 100644
index fb4846160047..000000000000
--- a/Documentation/devicetree/bindings/rng/timeriomem_rng.txt
+++ /dev/null
@@ -1,25 +0,0 @@
-HWRNG support for the timeriomem_rng driver
-
-Required properties:
-- compatible : "timeriomem_rng"
-- reg : base address to sample from
-- period : wait time in microseconds to use between samples
-
-Optional properties:
-- quality : estimated number of bits of true entropy per 1024 bits read from the
-            rng.  Defaults to zero which causes the kernel's default quality to
-            be used instead.  Note that the default quality is usually zero
-            which disables using this rng to automatically fill the kernel's
-            entropy pool.
-
-N.B. currently 'reg' must be at least four bytes wide and 32-bit aligned
-
-Example:
-
-hwrng@44 {
-	#address-cells = <1>;
-	#size-cells = <1>;
-	compatible = "timeriomem_rng";
-	reg = <0x44 0x04>;
-	period = <1000000>;
-};
diff --git a/Documentation/devicetree/bindings/rng/timeriomem_rng.yaml b/Documentation/devicetree/bindings/rng/timeriomem_rng.yaml
new file mode 100644
index 000000000000..84bf518a5549
--- /dev/null
+++ b/Documentation/devicetree/bindings/rng/timeriomem_rng.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rng/timeriomem_rng.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TimerIO Random Number Generator
+
+maintainers:
+  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
+
+properties:
+  compatible:
+    const: timeriomem_rng
+
+  period:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: wait time in microseconds to use between samples
+
+  quality:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 0
+    description:
+      Estimated number of bits of true entropy per 1024 bits read from the rng.
+      Defaults to zero which causes the kernel's default quality to be used
+      instead.  Note that the default quality is usually zero which disables
+      using this rng to automatically fill the kernel's entropy pool.
+
+  reg:
+    maxItems: 1
+    description:
+      Base address to sample from. Currently 'reg' must be at least four bytes
+      wide and 32-bit aligned.
+
+required:
+  - compatible
+  - period
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    rng@44 {
+        compatible = "timeriomem_rng";
+        reg = <0x44 0x04>;
+        period = <1000000>;
+    };
-- 
2.32.0

