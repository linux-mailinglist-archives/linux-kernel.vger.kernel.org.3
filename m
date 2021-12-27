Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 339D3480368
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 19:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231967AbhL0SdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 13:33:22 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:45460
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231795AbhL0SdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 13:33:10 -0500
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com [209.85.208.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 38D2E3F32C
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 18:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1640629989;
        bh=NkhG/x29/01OwnwUW7nLUUqEe+ov12qsWpqmInTRQ8g=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=UJHTEBoCWoug0ENAmvc179K2pVK2Hh8IXybBLymFmrzFCweTnM0cQOKZmp5eF4zYk
         5shilPOE33s1D6h/qpFPfZIfQowLekNmPQJ2frZ1B10enlu4IVEDjHKO6OJuUgVMmz
         t8erSaQcC6Fh6ZpGzrMXNB9ib84hRvgFHdSAvOIgc7nI9oARa9lVW+n5lkA0YuxYqB
         fm6q6006An4ws9nutRlxLWi6Ti8q5htXrJpFJzkhI4Bh8wxh481+koscQWqSMeiQhp
         x5xnNkoHZKVIadKwU70AaGHr5BxR2QcPvWpwpq6/dQoFX6bF1OIm9TMYshzjL4PiVB
         JFM11X5jdHbcw==
Received: by mail-lj1-f198.google.com with SMTP id d12-20020a05651c088c00b0022d989d91caso4330534ljq.20
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 10:33:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NkhG/x29/01OwnwUW7nLUUqEe+ov12qsWpqmInTRQ8g=;
        b=YzOWo7wUi7/9y80jw9Gt3VnGKMwquMyYEg3y4YRtM2hexyBNuY2JUClvNHhkfDUKD3
         /V519K7qdQukA4/E59u4KAKyQTzUGJM9Y7ZOKcp1zeTabPbMMBLD12tsU+o/dJI3ToxA
         XySUrqtCiEqkiOxIE+ZRhxWFNcefDt0t4mSJC1gnnUU4dE+v2hru+KQTxGZyky/4SJ5s
         3rP7JQXMmIGCvwlaBJy+/o/G77xQRyTAhJSKwk5OFHNzh0OY/AVixAlZHn9whlwdG1HU
         GGk+PmKIzrzDZs3o6hUPtIL9+tifHjVYGjXIs5xqHgiaf2Em4H8/Hn4AdcbhEP+jed0Z
         Pmxg==
X-Gm-Message-State: AOAM531pPB9seeGe+GhjJZlws0YlvI7vyR/5mccJcT3dzIG/pjG1BxLL
        v1X/HRes5tQt+3n2THLYxvqCdXPAizVG0ZlQ03KgzARMRfN8SfYAsZLYP5e8N2ZWUugSHE85pCz
        9l8nHVaX7D3+UTxhS2c0ozuKTtlYufyV90LPf7n3Rwg==
X-Received: by 2002:a05:651c:1788:: with SMTP id bn8mr15237840ljb.521.1640629983723;
        Mon, 27 Dec 2021 10:33:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwPduPoQbsa0sy+uH2eNHIhEtE/sohO5iVYWenQxdkMncrOkJ+IgNQ7Hd0WQR7JT8kWLRV0CA==
X-Received: by 2002:a05:651c:1788:: with SMTP id bn8mr15237828ljb.521.1640629983480;
        Mon, 27 Dec 2021 10:33:03 -0800 (PST)
Received: from krzk-bin.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id o12sm1299622ljc.5.2021.12.27.10.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Dec 2021 10:33:03 -0800 (PST)
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
Subject: [PATCH 6/8] dt-bindings: rng: ti,omap-rom-rng: convert OMAP ROM RNG to dtschema
Date:   Mon, 27 Dec 2021 19:32:49 +0100
Message-Id: <20211227183251.132525-6-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211227183251.132525-1-krzysztof.kozlowski@canonical.com>
References: <20211227183251.132525-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the OMAP ROM RNG bindings to DT schema.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../devicetree/bindings/rng/omap3_rom_rng.txt | 27 ------------
 .../bindings/rng/ti,omap-rom-rng.yaml         | 41 +++++++++++++++++++
 2 files changed, 41 insertions(+), 27 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/rng/omap3_rom_rng.txt
 create mode 100644 Documentation/devicetree/bindings/rng/ti,omap-rom-rng.yaml

diff --git a/Documentation/devicetree/bindings/rng/omap3_rom_rng.txt b/Documentation/devicetree/bindings/rng/omap3_rom_rng.txt
deleted file mode 100644
index f315c9723bd2..000000000000
--- a/Documentation/devicetree/bindings/rng/omap3_rom_rng.txt
+++ /dev/null
@@ -1,27 +0,0 @@
-OMAP ROM RNG driver binding
-
-Secure SoCs may provide RNG via secure ROM calls like Nokia N900 does. The
-implementation can depend on the SoC secure ROM used.
-
-- compatible:
-	Usage: required
-	Value type: <string>
-	Definition: must be "nokia,n900-rom-rng"
-
-- clocks:
-	Usage: required
-	Value type: <prop-encoded-array>
-	Definition: reference to the the RNG interface clock
-
-- clock-names:
-	Usage: required
-	Value type: <stringlist>
-	Definition: must be "ick"
-
-Example:
-
-	rom_rng: rng {
-		compatible = "nokia,n900-rom-rng";
-		clocks = <&rng_ick>;
-		clock-names = "ick";
-	};
diff --git a/Documentation/devicetree/bindings/rng/ti,omap-rom-rng.yaml b/Documentation/devicetree/bindings/rng/ti,omap-rom-rng.yaml
new file mode 100644
index 000000000000..9a58440b1ab1
--- /dev/null
+++ b/Documentation/devicetree/bindings/rng/ti,omap-rom-rng.yaml
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rng/ti,omap-rom-rng.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: OMAP ROM Random Number Generator
+
+maintainers:
+  - Pali Rohár <pali@kernel.org>
+  - Tony Lindgren <tony@atomide.com>
+
+description:
+  Secure SoCs may provide RNG via secure ROM calls like Nokia N900 does.
+  The implementation can depend on the SoC secure ROM used.
+
+properties:
+  compatible:
+    const: nokia,n900-rom-rng
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: ick
+
+required:
+  - compatible
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    rng {
+        compatible = "nokia,n900-rom-rng";
+        clocks = <&rng_ick>;
+        clock-names = "ick";
+    };
-- 
2.32.0

