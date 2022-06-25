Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE2D555AC5E
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 22:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233491AbiFYUHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 16:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233480AbiFYUG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 16:06:59 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8C361140E0;
        Sat, 25 Jun 2022 13:06:57 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.92,222,1650898800"; 
   d="scan'208";a="125645682"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 26 Jun 2022 05:06:57 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id A83F9400DB75;
        Sun, 26 Jun 2022 05:06:52 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-gpio@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v6 4/5] dt-bindings: pinctrl: renesas,rzg2l-pinctrl: Document the properties to handle GPIO IRQ
Date:   Sat, 25 Jun 2022 21:05:59 +0100
Message-Id: <20220625200600.7582-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220625200600.7582-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220625200600.7582-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the required properties to handle GPIO IRQ.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/pinctrl/renesas,rzg2l-pinctrl.yaml   | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
index 52df1b146174..997b74639112 100644
--- a/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
@@ -47,6 +47,17 @@ properties:
   gpio-ranges:
     maxItems: 1
 
+  interrupt-controller: true
+
+  '#interrupt-cells':
+    const: 2
+    description:
+      The first cell contains the global GPIO port index, constructed using the
+      RZG2L_GPIO() helper macro in <dt-bindings/pinctrl/rzg2l-pinctrl.h> and the
+      second cell is used to specify the flag.
+      E.g. "interrupts = <RZG2L_GPIO(43, 0) IRQ_TYPE_EDGE_FALLING>;" if P43_0 is
+      being used as an interrupt.
+
   clocks:
     maxItems: 1
 
@@ -110,6 +121,8 @@ required:
   - gpio-controller
   - '#gpio-cells'
   - gpio-ranges
+  - interrupt-controller
+  - '#interrupt-cells'
   - clocks
   - power-domains
   - resets
@@ -126,6 +139,8 @@ examples:
             gpio-controller;
             #gpio-cells = <2>;
             gpio-ranges = <&pinctrl 0 0 392>;
+            interrupt-controller;
+            #interrupt-cells = <2>;
             clocks = <&cpg CPG_MOD R9A07G044_GPIO_HCLK>;
             resets = <&cpg R9A07G044_GPIO_RSTN>,
                      <&cpg R9A07G044_GPIO_PORT_RESETN>,
-- 
2.25.1

