Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC405A882C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 23:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232386AbiHaVgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 17:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232372AbiHaVgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 17:36:02 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 66DBF71BC3;
        Wed, 31 Aug 2022 14:36:00 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.93,279,1654527600"; 
   d="scan'208";a="133267138"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 01 Sep 2022 06:35:58 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 45BF940FF977;
        Thu,  1 Sep 2022 06:35:53 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2] dt-bindings: display: bridge: renesas,dw-hdmi: Add resets property
Date:   Wed, 31 Aug 2022 22:35:36 +0100
Message-Id: <20220831213536.7602-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DWC HDMI blocks on R-Car and RZ/G2 SoC's use resets, so to complete
the bindings include resets property.

This also fixes the below warning when running dtbs_check:
arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n-rev2-ex-idk-1110wr.dtb: hdmi@fead0000: Unevaluated properties are not allowed ('resets' was unexpected)
	From schema: Documentation/devicetree/bindings/display/bridge/renesas,dw-hdmi.yaml

While at it mark resets property as required as all the DT sources
in the kernel specify resets and update the example node.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
v1->v2
* Updated commit message
* Marked resets as required property
* Updated the example node
* Included RB tag from Laurent

v1: https://lore.kernel.org/lkml/20220829215816.6206-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
---
 .../devicetree/bindings/display/bridge/renesas,dw-hdmi.yaml  | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/bridge/renesas,dw-hdmi.yaml b/Documentation/devicetree/bindings/display/bridge/renesas,dw-hdmi.yaml
index 0c9785c8db51..e3ec697f89e7 100644
--- a/Documentation/devicetree/bindings/display/bridge/renesas,dw-hdmi.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/renesas,dw-hdmi.yaml
@@ -38,6 +38,9 @@ properties:
   clock-names:
     maxItems: 2
 
+  resets:
+    maxItems: 1
+
   ports:
     $ref: /schemas/graph.yaml#/properties/ports
 
@@ -67,6 +70,7 @@ required:
   - reg
   - clocks
   - clock-names
+  - resets
   - interrupts
   - ports
 
@@ -85,6 +89,7 @@ examples:
         clocks = <&cpg CPG_CORE R8A7795_CLK_S0D4>, <&cpg CPG_MOD 729>;
         clock-names = "iahb", "isfr";
         power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+        resets = <&cpg 729>;
 
         ports {
             #address-cells = <1>;
-- 
2.25.1

