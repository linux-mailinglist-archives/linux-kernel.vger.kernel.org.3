Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03D01532F8D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 19:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239930AbiEXRWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 13:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239933AbiEXRWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 13:22:44 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C79517C17D;
        Tue, 24 May 2022 10:22:42 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.91,248,1647270000"; 
   d="scan'208";a="120749712"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 25 May 2022 02:22:42 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 2D5E3400A8AA;
        Wed, 25 May 2022 02:22:36 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH RFC 1/2] dt-bindings: interrupt-controller: sifive,plic: Document Renesas RZ/Five SoC
Date:   Tue, 24 May 2022 18:22:13 +0100
Message-Id: <20220524172214.5104-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220524172214.5104-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220524172214.5104-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
 .../sifive,plic-1.0.0.yaml                    | 38 +++++++++++++++++--
 1 file changed, 35 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
index 27092c6a86c4..78ff31cb63e5 100644
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
+      - const: renesas-r9a07g043-plic
 
   reg:
     maxItems: 1
@@ -64,8 +68,7 @@ properties:
   '#address-cells':
     const: 0
 
-  '#interrupt-cells':
-    const: 1
+  '#interrupt-cells': true
 
   interrupt-controller: true
 
@@ -91,6 +94,35 @@ required:
   - interrupts-extended
   - riscv,ndev
 
+if:
+  properties:
+    compatible:
+      contains:
+        const: renesas-r9a07g043-plic
+then:
+  properties:
+    clocks:
+      maxItems: 1
+
+    resets:
+      maxItems: 1
+
+    power-domains:
+      maxItems: 1
+
+    '#interrupt-cells':
+      const: 2
+
+  required:
+    - clocks
+    - resets
+    - power-domains
+
+else:
+  properties:
+    '#interrupt-cells':
+      const: 1
+
 additionalProperties: false
 
 examples:
-- 
2.25.1

