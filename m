Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8102E57D6AE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 00:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbiGUWNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 18:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234217AbiGUWNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 18:13:07 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0DE4095B32;
        Thu, 21 Jul 2022 15:12:26 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.93,183,1654527600"; 
   d="scan'208";a="126944326"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 22 Jul 2022 07:12:25 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 0ACA64011407;
        Fri, 22 Jul 2022 07:12:22 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 1/2] dt-bindings: soc: renesas: renesas,rzg2l-sysc: Document RZ/Five SoC
Date:   Thu, 21 Jul 2022 23:12:11 +0100
Message-Id: <20220721221212.18491-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220721221212.18491-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220721221212.18491-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document RZ/Five (R9A07G043) SYSC bindings. SYSC block found on the
RZ/Five SoC is almost identical to one found on the RZ/G2L (and alike)
SoC's. To differentiate RZ/G2UL from RZ/Five, "-rzfive" is included in
the compatible string for the RZ/Five SoC as there are no interrupts
from the SYSC block to the core.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../soc/renesas/renesas,rzg2l-sysc.yaml       | 56 +++++++++++++------
 1 file changed, 39 insertions(+), 17 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/renesas/renesas,rzg2l-sysc.yaml b/Documentation/devicetree/bindings/soc/renesas/renesas,rzg2l-sysc.yaml
index ce2875c89329..bdaf05f8b29b 100644
--- a/Documentation/devicetree/bindings/soc/renesas/renesas,rzg2l-sysc.yaml
+++ b/Documentation/devicetree/bindings/soc/renesas/renesas,rzg2l-sysc.yaml
@@ -20,35 +20,57 @@ description:
 properties:
   compatible:
     enum:
-      - renesas,r9a07g043-sysc # RZ/G2UL
-      - renesas,r9a07g044-sysc # RZ/G2{L,LC}
-      - renesas,r9a07g054-sysc # RZ/V2L
+      - renesas,r9a07g043-rzfive-sysc # RZ/Five
+      - renesas,r9a07g043-sysc        # RZ/G2UL
+      - renesas,r9a07g044-sysc        # RZ/G2{L,LC}
+      - renesas,r9a07g054-sysc        # RZ/V2L
 
   reg:
     maxItems: 1
 
-  interrupts:
-    items:
-      - description: CA55/CM33 Sleep/Software Standby Mode request interrupt
-      - description: CA55 Software Standby Mode release request interrupt
-      - description: CM33 Software Standby Mode release request interrupt
-      - description: CA55 ACE Asynchronous Bridge Master/Slave interface deny request interrupt
+  interrupts: true
 
-  interrupt-names:
-    items:
-      - const: lpm_int
-      - const: ca55stbydone_int
-      - const: cm33stbyr_int
-      - const: ca55_deny
+  interrupt-names: true
 
 required:
   - compatible
   - reg
-  - interrupts
-  - interrupt-names
 
 additionalProperties: false
 
+allOf:
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              enum:
+                - renesas,r9a07g043-rzfive-sysc
+    then:
+      properties:
+        interrupts:
+          items:
+            - description: CA55/CM33 Sleep/Software Standby Mode request interrupt
+            - description: CA55 Software Standby Mode release request interrupt
+            - description: CM33 Software Standby Mode release request interrupt
+            - description: CA55 ACE Asynchronous Bridge Master/Slave interface deny request interrupt
+
+        interrupt-names:
+          items:
+            - const: lpm_int
+            - const: ca55stbydone_int
+            - const: cm33stbyr_int
+            - const: ca55_deny
+
+      required:
+        - interrupts
+        - interrupt-names
+
+    else:
+      properties:
+        interrupts: false
+        interrupt-names: false
+
 examples:
   - |
     #include <dt-bindings/interrupt-controller/arm-gic.h>
-- 
2.25.1

