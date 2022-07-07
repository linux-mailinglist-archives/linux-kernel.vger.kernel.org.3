Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84DAE56AA77
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 20:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236091AbiGGSYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 14:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236078AbiGGSYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 14:24:49 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B8AA2F3BF;
        Thu,  7 Jul 2022 11:24:48 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id s27so19973656pga.13;
        Thu, 07 Jul 2022 11:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6q8+tslNjj42is2Wq3LrKo5qrCaBaAPRJbMXgMdfGjQ=;
        b=DhBVZphbgje4AIE9scnB/AiBcqQMjgFpJ4KQH4530InyLm0RL1ySwkb6VD5YzvCgJW
         aMa81fA7aAvpVKSXu7BdCEJurulD5fEjQ6UOyS4A7j1EBS1FHfaermNEBg94BxKa6WBI
         7AjbgtWR3wQ25ZaG05LRuktC9lmQOsCJBs8jewhAjURF93yVaAGfmBagrspZWdMFTe+k
         8jOPda3rtbpO+tGMwoxZ15L/8AbpRE1/5FQSDRQxFoe0VeFCoCkzSoh1uyA1TdwA0InB
         +WTOPUWAdKvDjJo5nh4M7A6S3kXXfwFokox9XaLwCL0OZXF7oKsqc040aYzu/xtfF5Ud
         Ve6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6q8+tslNjj42is2Wq3LrKo5qrCaBaAPRJbMXgMdfGjQ=;
        b=vzgUvf4kx/Q/rs8pUUtdFyXTHrRRbpxL/MODBGLbPikIr7No2NRRT+SP6pqnA8d0CT
         Isub4TlaqU1qo8lUDNkz+ZzwgiWXtICjsIUWdYifvuuyHphougP8Cd727p9S4T0Cwvs6
         trieuNFHL3oR3i9vfs6PiFk0ZUQ1U22torS9e4ofnykjt+rhFmc/vtkuOalQ9EXAnvAa
         mLmNiKz2+yM8QG80bcAGSR4/krxM0dwt/HXHMwB818a5Kjr29eCz9w0M8Lcc/da6KTAH
         zcPPxc3iyXPS77IpLONXytePk0+NQCM4TLkoZUR/lBNhypbby93hMGe3IRagVKQc9aPP
         kAww==
X-Gm-Message-State: AJIora/5m1qUgmqrvl4HQgT2cHQu1bcJZuph7Cik1/pDph+n5jH6uOif
        TB9kBEJUOlMlK8nafIJJsIg=
X-Google-Smtp-Source: AGRyM1uzxWGGMoYwsGhJojNPdBl+m6Z+wxbtxQsV/MrMoA+8ndxIvifQCIF8K4oucXDUtbumwFneHA==
X-Received: by 2002:a63:1724:0:b0:412:7bee:fdba with SMTP id x36-20020a631724000000b004127beefdbamr12075693pgl.340.1657218287679;
        Thu, 07 Jul 2022 11:24:47 -0700 (PDT)
Received: from prasmi.domain.name ([103.219.60.85])
        by smtp.gmail.com with ESMTPSA id o12-20020a170902d4cc00b0016a3f9e4865sm28589279plg.148.2022.07.07.11.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 11:24:47 -0700 (PDT)
From:   prabhakar.csengg@gmail.com
X-Google-Original-From: prabhakar.mahadev-lad.rj@bp.renesas.com
To:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-gpio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v8 2/6] dt-bindings: interrupt-controller: Add Renesas RZ/G2L Interrupt Controller
Date:   Thu,  7 Jul 2022 19:23:10 +0100
Message-Id: <20220707182314.66610-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220707182314.66610-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220707182314.66610-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Add DT bindings for the Renesas RZ/G2L Interrupt Controller.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 .../renesas,rzg2l-irqc.yaml                   | 133 ++++++++++++++++++
 1 file changed, 133 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml b/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
new file mode 100644
index 000000000000..ffbb4ab4d9a7
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
@@ -0,0 +1,133 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/renesas,rzg2l-irqc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas RZ/G2L (and alike SoC's) Interrupt Controller (IA55)
+
+maintainers:
+  - Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
+  - Geert Uytterhoeven <geert+renesas@glider.be>
+
+description: |
+  IA55 performs various interrupt controls including synchronization for the external
+  interrupts of NMI, IRQ, and GPIOINT and the interrupts of the built-in peripheral
+  interrupts output by each IP. And it notifies the interrupt to the GIC
+    - IRQ sense select for 8 external interrupts, mapped to 8 GIC SPI interrupts
+    - GPIO pins used as external interrupt input pins, mapped to 32 GIC SPI interrupts
+    - NMI edge select (NMI is not treated as NMI exception and supports fall edge and
+      stand-up edge detection interrupts)
+
+allOf:
+  - $ref: /schemas/interrupt-controller.yaml#
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - renesas,r9a07g044-irqc    # RZ/G2L
+      - const: renesas,rzg2l-irqc
+
+  '#interrupt-cells':
+    description: The first cell should contain external interrupt number (IRQ0-7) and the
+                 second cell is used to specify the flag.
+    const: 2
+
+  '#address-cells':
+    const: 0
+
+  interrupt-controller: true
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 41
+
+  clocks:
+    maxItems: 2
+
+  clock-names:
+    items:
+      - const: clk
+      - const: pclk
+
+  power-domains:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+required:
+  - compatible
+  - '#interrupt-cells'
+  - '#address-cells'
+  - interrupt-controller
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - power-domains
+  - resets
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/r9a07g044-cpg.h>
+
+    irqc: interrupt-controller@110a0000 {
+            compatible = "renesas,r9a07g044-irqc", "renesas,rzg2l-irqc";
+            reg = <0x110a0000 0x10000>;
+            #interrupt-cells = <2>;
+            #address-cells = <0>;
+            interrupt-controller;
+            interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 444 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 445 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 446 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 447 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 448 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 449 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 450 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 451 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 452 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 453 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 454 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 455 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 456 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 457 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 458 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 459 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 460 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 461 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 462 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 463 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 464 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 465 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 466 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 467 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 468 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 469 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 470 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 471 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 472 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 473 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 474 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 475 IRQ_TYPE_LEVEL_HIGH>;
+            clocks = <&cpg CPG_MOD R9A07G044_IA55_CLK>,
+                     <&cpg CPG_MOD R9A07G044_IA55_PCLK>;
+            clock-names = "clk", "pclk";
+            power-domains = <&cpg>;
+            resets = <&cpg R9A07G044_IA55_RESETN>;
+    };
-- 
2.25.1

