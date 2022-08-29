Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE9465A5695
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 23:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbiH2V6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 17:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiH2V6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 17:58:37 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4D1618C44F;
        Mon, 29 Aug 2022 14:58:36 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.93,273,1654527600"; 
   d="scan'208";a="130995722"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 30 Aug 2022 06:58:35 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 39F7140029B1;
        Tue, 30 Aug 2022 06:58:29 +0900 (JST)
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
Subject: [PATCH] dt-bindings: display: bridge: renesas,dw-hdmi: Fix 'unevaluatedProperties' warnings
Date:   Mon, 29 Aug 2022 22:58:16 +0100
Message-Id: <20220829215816.6206-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With 'unevaluatedProperties' support implemented, there's a number of
warnings when running dtbs_check:

arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n-rev2-ex-idk-1110wr.dtb: hdmi@fead0000: Unevaluated properties are not allowed ('resets' was unexpected)
	From schema: Documentation/devicetree/bindings/display/bridge/renesas,dw-hdmi.yaml

The main problem is that SoC DTSI's are including resets property, whereas
the renesas,dw-hdmi.yaml has 'unevaluatedProperties: false'. So just add
optional resets property to the binding.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../devicetree/bindings/display/bridge/renesas,dw-hdmi.yaml    | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/bridge/renesas,dw-hdmi.yaml b/Documentation/devicetree/bindings/display/bridge/renesas,dw-hdmi.yaml
index 0c9785c8db51..a7e44e249dd3 100644
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
 
-- 
2.25.1

