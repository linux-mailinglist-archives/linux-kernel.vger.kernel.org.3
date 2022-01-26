Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D543449D105
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 18:40:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243939AbiAZRkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 12:40:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243866AbiAZRk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 12:40:28 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6790C06161C;
        Wed, 26 Jan 2022 09:40:27 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id h21so313704wrb.8;
        Wed, 26 Jan 2022 09:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xv2b2upMAcR7nSQETF1v56wdlWnH1nAzIzdRtUFQ2Q0=;
        b=oaiVVtd0jXBEnibcQJNTjQPcSi168VUHbuUyejwZOlXZ4RfMGcj6cK9fONkmXmhx/d
         dw/23BaXyUm03VpDj/IpA5J1uHkiMAetTP/3HZDCCsWR+SPiXH87WiCjt9qjfcgZ5qy+
         209SfXUF3GpZK8gg4+Uw/homdEiCaI187xHyyjjP+JOxdseE4zccU2EyTjNbngY2gHqO
         oWKHlruXwFtJYjfSa0ybaG6uIFHhnk4heChTUI4wG8Z0ouzd36XFy20FoXUWHX8Sl9Ep
         hC3ZNIDh6eczc80Ifg6stDxuFDj2ONjmsBFgRhqM2nEI+hzrTth3Fw6JZUFrtYo1OUv2
         e2Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=xv2b2upMAcR7nSQETF1v56wdlWnH1nAzIzdRtUFQ2Q0=;
        b=6Jo/GRslM1gguJvzkjPKBxTiEN5pDKSeu8MrangHru+T4AhEwP4+SRtDgjT1IRTIuA
         jOTEJlogmY/1OT06HVfvecIMr9SfxmFFFuRRz48z0AjAdZSRL8OVoBXzlTL2ACSvh4H4
         3yCOA7P+GQoki50/wZHCGJyZlmtKdMhhG1J8bGmqvBRB1ilzoMfqbD19SmH0MLI8E82S
         RP63Uxzc46bekviu6X3CQgdTdeEhXGqj0SlCBowDOUr7Gn6VOFjJea554FJIZF/7PBrP
         6dJvBt52l5F8GAiOsORP+vbSO02ca8LYsQQ3itvmpXVSvORB3Ax9LV18ZTVczopx2aBx
         lTag==
X-Gm-Message-State: AOAM533CdKEyQ0Y10KK3z+8ltnzGJpW1HNlcPnVXoMgHLmOzexCvqRLW
        0wJLMf5zBvYQMrFexsomDywAoKRiUWw=
X-Google-Smtp-Source: ABdhPJxzL3yr9aftK53GrFMmGmt37ZMyq5qu/NkND/JthJtbNDbOYB6Tpu0vm63m2W3H++ubjw78rg==
X-Received: by 2002:a05:6000:15ca:: with SMTP id y10mr2141434wry.531.1643218826533;
        Wed, 26 Jan 2022 09:40:26 -0800 (PST)
Received: from stitch.. (80.71.140.73.ipv4.parknet.dk. [80.71.140.73])
        by smtp.gmail.com with ESMTPSA id y2sm3498451wmj.13.2022.01.26.09.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 09:40:25 -0800 (PST)
Sender: Emil Renner Berthing <emil.renner.berthing@gmail.com>
From:   Emil Renner Berthing <kernel@esmil.dk>
To:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Emil Renner Berthing <kernel@esmil.dk>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Zhu <michael.zhu@starfivetech.com>,
        Fu Wei <tekkamanninja@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v1 4/7] dt-bindings: clock: Add starfive,jh7100-audclk bindings
Date:   Wed, 26 Jan 2022 18:39:50 +0100
Message-Id: <20220126173953.1016706-5-kernel@esmil.dk>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20220126173953.1016706-1-kernel@esmil.dk>
References: <20220126173953.1016706-1-kernel@esmil.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for the audio clocks on the StarFive JH7100 RISC-V SoC.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
---
 .../clock/starfive,jh7100-audclk.yaml         | 57 +++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jh7100-audclk.yaml

diff --git a/Documentation/devicetree/bindings/clock/starfive,jh7100-audclk.yaml b/Documentation/devicetree/bindings/clock/starfive,jh7100-audclk.yaml
new file mode 100644
index 000000000000..8f49a1ae03f1
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/starfive,jh7100-audclk.yaml
@@ -0,0 +1,57 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/starfive,jh7100-audclk.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: StarFive JH7100 Audio Clock Generator
+
+maintainers:
+  - Emil Renner Berthing <kernel@esmil.dk>
+
+properties:
+  compatible:
+    const: starfive,jh7100-audclk
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Audio source clock
+      - description: External 12.288MHz clock
+      - description: Domain 7 AHB bus clock
+
+  clock-names:
+    items:
+      - const: audio_src
+      - const: audio_12288
+      - const: dom7ahb_bus
+
+  '#clock-cells':
+    const: 1
+    description:
+      See <dt-bindings/clock/starfive-jh7100-audio.h> for valid indices.
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - '#clock-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/starfive-jh7100.h>
+
+    clock-controller@10480000 {
+            compatible = "starfive,jh7100-audclk";
+            reg = <0x10480000 0x10000>;
+            clocks = <&clkgen JH7100_CLK_AUDIO_SRC>,
+                     <&clkgen JH7100_CLK_AUDIO_12288>,
+                     <&clkgen JH7100_CLK_DOM7AHB_BUS>;
+            clock-names = "audio_src", "audio_12288", "dom7ahb_bus";
+            #clock-cells = <1>;
+    };
-- 
2.34.1

