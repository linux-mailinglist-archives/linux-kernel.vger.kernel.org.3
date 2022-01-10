Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 354ED489A89
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 14:48:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234557AbiAJNrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 08:47:43 -0500
Received: from relmlor1.renesas.com ([210.160.252.171]:26568 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234173AbiAJNr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 08:47:27 -0500
X-IronPort-AV: E=Sophos;i="5.88,277,1635174000"; 
   d="scan'208";a="106014821"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 10 Jan 2022 22:47:26 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 2289242E3549;
        Mon, 10 Jan 2022 22:47:23 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 06/12] dt-bindings: pinctrl: renesas: Document RZ/V2L pinctrl
Date:   Mon, 10 Jan 2022 13:46:53 +0000
Message-Id: <20220110134659.30424-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220110134659.30424-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220110134659.30424-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Biju Das <biju.das.jz@bp.renesas.com>

Document Renesas RZ/V2L pinctrl bindings. The RZ/V2L is package- and
pin-compatible with the RZ/G2L. No driver changes are required as RZ/G2L
compatible string "renesas,r9a07g044-pinctrl" will be used as a fallback.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Acked-by: Rob Herring <robh@kernel.org>
---
v1->v2
* Included ACK from ROB
---
 .../bindings/pinctrl/renesas,rzg2l-pinctrl.yaml   | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
index ef68dabcf4dc..189a0800cd1d 100644
--- a/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
@@ -4,14 +4,14 @@
 $id: http://devicetree.org/schemas/pinctrl/renesas,rzg2l-pinctrl.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Renesas RZ/G2L combined Pin and GPIO controller
+title: Renesas RZ/{G2L,V2L} combined Pin and GPIO controller
 
 maintainers:
   - Geert Uytterhoeven <geert+renesas@glider.be>
   - Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
 
 description:
-  The Renesas SoCs of the RZ/G2L series feature a combined Pin and GPIO
+  The Renesas SoCs of the RZ/{G2L,V2L} series feature a combined Pin and GPIO
   controller.
   Pin multiplexing and GPIO configuration is performed on a per-pin basis.
   Each port features up to 8 pins, each of them configurable for GPIO function
@@ -20,8 +20,15 @@ description:
 
 properties:
   compatible:
-    enum:
-      - renesas,r9a07g044-pinctrl # RZ/G2{L,LC}
+    oneOf:
+      - items:
+          - enum:
+              - renesas,r9a07g044-pinctrl # RZ/G2{L,LC}
+
+      - items:
+          - enum:
+              - renesas,r9a07g054-pinctrl     # RZ/V2L
+          - const: renesas,r9a07g044-pinctrl  # RZ/G2{L,LC} fallback for RZ/V2L
 
   reg:
     maxItems: 1
-- 
2.17.1

