Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D29155ADDE
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 02:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233752AbiFZAoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 20:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233285AbiFZAoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 20:44:20 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 83A3413D23;
        Sat, 25 Jun 2022 17:44:19 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.92,222,1650898800"; 
   d="scan'208";a="125658105"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 26 Jun 2022 09:44:19 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id E580240078B9;
        Sun, 26 Jun 2022 09:44:14 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 1/2] dt-bindings: interrupt-controller: sifive,plic: Document Renesas RZ/Five SoC
Date:   Sun, 26 Jun 2022 01:43:25 +0100
Message-Id: <20220626004326.8548-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220626004326.8548-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220626004326.8548-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document Renesas RZ/Five (R9A07G043) SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v1->v2:
* Fixed binding doc
* Fixed review comments pointed by Krzysztof.

RFC->v1:
* Fixed Review comments pointed by Geert and Rob
---
 .../sifive,plic-1.0.0.yaml                    | 44 +++++++++++++++++--
 1 file changed, 41 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
index 27092c6a86c4..59df367d1e44 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
@@ -28,7 +28,10 @@ description:
 
   While the PLIC supports both edge-triggered and level-triggered interrupts,
   interrupt handlers are oblivious to this distinction and therefore it is not
-  specified in the PLIC device-tree binding.
+  specified in the PLIC device-tree binding for SiFive PLIC (and similar PLIC's),
+  but for the Renesas RZ/Five Soc (AX45MP AndesCore) which has NCEPLIC100 we need
+  to specify the interrupt type as the flow for EDGE interrupts is different
+  compared to LEVEL interrupts.
 
   While the RISC-V ISA doesn't specify a memory layout for the PLIC, the
   "sifive,plic-1.0.0" device is a concrete implementation of the PLIC that
@@ -57,6 +60,7 @@ properties:
           - enum:
               - allwinner,sun20i-d1-plic
           - const: thead,c900-plic
+      - const: renesas,r9a07g043-plic
 
   reg:
     maxItems: 1
@@ -64,8 +68,7 @@ properties:
   '#address-cells':
     const: 0
 
-  '#interrupt-cells':
-    const: 1
+  '#interrupt-cells': true
 
   interrupt-controller: true
 
@@ -82,6 +85,12 @@ properties:
     description:
       Specifies how many external interrupts are supported by this controller.
 
+  clocks: true
+
+  power-domains: true
+
+  resets: true
+
 required:
   - compatible
   - '#address-cells'
@@ -91,6 +100,35 @@ required:
   - interrupts-extended
   - riscv,ndev
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,r9a07g043-plic
+    then:
+      properties:
+        clocks:
+          maxItems: 1
+
+        power-domains:
+          maxItems: 1
+
+        resets:
+          maxItems: 1
+
+        '#interrupt-cells':
+          const: 2
+
+      required:
+        - clocks
+        - resets
+        - power-domains
+    else:
+      properties:
+        '#interrupt-cells':
+          const: 1
+
 additionalProperties: false
 
 examples:
-- 
2.25.1

