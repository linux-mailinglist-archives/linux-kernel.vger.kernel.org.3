Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA58480369
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 19:33:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbhL0Sd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 13:33:27 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:45530
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231872AbhL0SdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 13:33:16 -0500
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id EF83C3FFD7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 18:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1640629994;
        bh=Ha91ZDV5aCOHeV4K+0XvZy0cP8PcDx+1Y/WeQ3R169I=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=nYBl5+ih4gcGMvC+bZqiKvOAXz47NxusnXvl/eWuW05+mhfpZcKs5ehFXV0iPXTPj
         DWnIRAD/zHVfZBDqPK8IqDRGy2IM9yiuCs22yW9wNl+U1ulzRJXXwAyvGG25pDbam6
         5Hn3ttelqIakAVDkOAr5etqJeSbk+n/08OOsXePi4ZiJsTAfmE+PKLubHtspyUeYk8
         OfnSagI4pXBTvQMYIakQLQ+opdWH5h5r1ivjTQY+3AjwS3fP81wubYlF94BJySjvTo
         pkdKYynDMoK4rYUdMMtdHSSmFxRiGKAaqr5wYqo4SILSL/BJg0Fqih9XDZyaSro9XW
         C9INCZts/lehg==
Received: by mail-ed1-f72.google.com with SMTP id ch27-20020a0564021bdb00b003f8389236f8so11395549edb.19
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 10:33:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ha91ZDV5aCOHeV4K+0XvZy0cP8PcDx+1Y/WeQ3R169I=;
        b=k27ZaGyXMmv9L8TdbF5axm/Zx24c9HjgRUSeO6i/ecDw7EgqcxEq6WAy0aIxH7qiMd
         dZJnNajxVpF51MBBRh77Ep/C7RPCOf+GTjCwu5Q/zs/p2RhPccP+PQp7vznoK/hUy5DV
         yrANp3RJm4SQa3A6ECcS6RZJIXgPBDyPY2q8XJZPKatyVGPEx/PaootZ1jGvRlI7/fSr
         8u95Rx2vgijm1kFu1Zc7becR+r4Ob2WyEazd/nQwuGOMGoPc3YP5pAPr4COXV1EYoBdO
         0qXc3aqez3bHsPo3YdF/ZCUoUR3BA2QzUeYewi8bGN6srTQevI8NfHKRHZKLoGy/EV0f
         Iz/w==
X-Gm-Message-State: AOAM532f+eJ9iBJz9q+3wIp/M6mOvtOhE3HgltAigrhAMqn+QZrmRuHZ
        YpWvhOiH7gD/clucVsmXPJqSdavkFE4vCXHARa2odNuLGkbGRy/y55BAMRlA5PBn35mAMxSskcP
        H5DJMaAx3lyK3CvypDfrjmSXTRijHnNGjbs5r0b66+g==
X-Received: by 2002:ac2:4d34:: with SMTP id h20mr16342039lfk.617.1640629977840;
        Mon, 27 Dec 2021 10:32:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxw2ascN7H6LYQsbejqKJs7k+yaXgGe30MRDmj5xMYPmLPKoxgkmpwR4T2jbxwJKJSp1I0tQg==
X-Received: by 2002:ac2:4d34:: with SMTP id h20mr16342015lfk.617.1640629977677;
        Mon, 27 Dec 2021 10:32:57 -0800 (PST)
Received: from krzk-bin.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id o12sm1299622ljc.5.2021.12.27.10.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Dec 2021 10:32:57 -0800 (PST)
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
Subject: [PATCH 2/8] dt-bindings: rng: atmel,at91-trng: convert Atmel TRNG to dtschema
Date:   Mon, 27 Dec 2021 19:32:45 +0100
Message-Id: <20211227183251.132525-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211227183251.132525-1-krzysztof.kozlowski@canonical.com>
References: <20211227183251.132525-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Atmel TRNG bindings to DT schema.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../bindings/rng/atmel,at91-trng.yaml         | 46 +++++++++++++++++++
 .../devicetree/bindings/rng/atmel-trng.txt    | 16 -------
 2 files changed, 46 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/rng/atmel,at91-trng.yaml
 delete mode 100644 Documentation/devicetree/bindings/rng/atmel-trng.txt

diff --git a/Documentation/devicetree/bindings/rng/atmel,at91-trng.yaml b/Documentation/devicetree/bindings/rng/atmel,at91-trng.yaml
new file mode 100644
index 000000000000..0324e863dab8
--- /dev/null
+++ b/Documentation/devicetree/bindings/rng/atmel,at91-trng.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rng/atmel,at91-trng.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Atmel AT91 True Random Number Generator
+
+maintainers:
+  - Nicolas Ferre <nicolas.ferre@microchip.com>
+  - Alexandre Belloni <alexandre.belloni@bootlin.com>
+  - Ludovic Desroches <ludovic.desroches@microchip.com>
+
+properties:
+  compatible:
+    enum:
+      - atmel,at91sam9g45-trng
+      - microchip,sam9x60-trng
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
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    rng@fffcc000 {
+        compatible = "atmel,at91sam9g45-trng";
+        reg = <0xfffcc000 0x4000>;
+        interrupts = <6 IRQ_TYPE_LEVEL_HIGH 0>;
+        clocks = <&trng_clk>;
+    };
diff --git a/Documentation/devicetree/bindings/rng/atmel-trng.txt b/Documentation/devicetree/bindings/rng/atmel-trng.txt
deleted file mode 100644
index 3900ee4f3532..000000000000
--- a/Documentation/devicetree/bindings/rng/atmel-trng.txt
+++ /dev/null
@@ -1,16 +0,0 @@
-Atmel TRNG (True Random Number Generator) block
-
-Required properties:
-- compatible : Should be "atmel,at91sam9g45-trng" or "microchip,sam9x60-trng"
-- reg : Offset and length of the register set of this block
-- interrupts : the interrupt number for the TRNG block
-- clocks: should contain the TRNG clk source
-
-Example:
-
-trng@fffcc000 {
-	compatible = "atmel,at91sam9g45-trng";
-	reg = <0xfffcc000 0x4000>;
-	interrupts = <6 IRQ_TYPE_LEVEL_HIGH 0>;
-	clocks = <&trng_clk>;
-};
-- 
2.32.0

