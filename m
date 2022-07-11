Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9415701F8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 14:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbiGKMZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 08:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbiGKMZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 08:25:11 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7777E45F5D;
        Mon, 11 Jul 2022 05:25:10 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id ADF4366019FE;
        Mon, 11 Jul 2022 13:25:08 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657542309;
        bh=WNj+Fngrs3bQ3s4zywv4THTLiM1Sc7weFg7rQrZYyA4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ceyCqKo7TRKXqpMJLLjVVVxkeX7NFgcmBVwiHVgHiBdWcrBW4wXbasuam2Zv3o1Gq
         Etiy5WNb/pI0J2BHtC9mAvQo/cSHGBdpmV3t6zR4UELoDyyo5Bn4GKVzCHcAD2u+V0
         6w2dBWmD8VEM6WdDolQBqFiGgmxPIgUNiNPoTA6VkkCdI6TZbi5JviazImVZ7JCX7G
         IeOY9F692AZPeAhqbSGzEuzgeP185qP1hdaDmgaegDAN8MZ5M8j5MiwA/++YH6jDVy
         UxEj155zUjI9vKvxhe4Hw37V5WBTOUIr/ZzPvNsNkibx5JYwHb3EjpzZnIgW7HOkXU
         e5Fgt1Cg8qqQg==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        chun-jie.chen@mediatek.com, weiyi.lu@mediatek.com,
        mbrugger@suse.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com,
        nfraprado@collabora.com
Subject: [PATCH 2/3] dt-bindings: power: mediatek: Update example to use phandle to syscon
Date:   Mon, 11 Jul 2022 14:25:02 +0200
Message-Id: <20220711122503.286743-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220711122503.286743-1-angelogioacchino.delregno@collabora.com>
References: <20220711122503.286743-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The preferred way of declaring this node is by using a phandle to
syscon: update the example to reflect that.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../power/mediatek,power-controller.yaml      | 125 +++++++++---------
 1 file changed, 63 insertions(+), 62 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
index 848fdff7c9d8..bed059e4401d 100644
--- a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
+++ b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
@@ -237,76 +237,77 @@ examples:
         scpsys: syscon@10006000 {
             compatible = "syscon", "simple-mfd";
             reg = <0 0x10006000 0 0x1000>;
+        };
+    };
 
-            spm: power-controller {
-                compatible = "mediatek,mt8173-power-controller";
+    spm: power-controller {
+        compatible = "mediatek,mt8173-power-controller";
+        #address-cells = <1>;
+        #size-cells = <0>;
+        #power-domain-cells = <1>;
+        syscon = <&scpsys>;
+
+        /* power domains of the SoC */
+        power-domain@MT8173_POWER_DOMAIN_VDEC {
+            reg = <MT8173_POWER_DOMAIN_VDEC>;
+            clocks = <&topckgen CLK_TOP_MM_SEL>;
+            clock-names = "mm";
+            #power-domain-cells = <0>;
+        };
+        power-domain@MT8173_POWER_DOMAIN_VENC {
+            reg = <MT8173_POWER_DOMAIN_VENC>;
+            clocks = <&topckgen CLK_TOP_MM_SEL>,
+                     <&topckgen CLK_TOP_VENC_SEL>;
+            clock-names = "mm", "venc";
+            #power-domain-cells = <0>;
+        };
+        power-domain@MT8173_POWER_DOMAIN_ISP {
+            reg = <MT8173_POWER_DOMAIN_ISP>;
+            clocks = <&topckgen CLK_TOP_MM_SEL>;
+            clock-names = "mm";
+            #power-domain-cells = <0>;
+        };
+        power-domain@MT8173_POWER_DOMAIN_MM {
+            reg = <MT8173_POWER_DOMAIN_MM>;
+            clocks = <&topckgen CLK_TOP_MM_SEL>;
+            clock-names = "mm";
+            #power-domain-cells = <0>;
+            mediatek,infracfg = <&infracfg>;
+        };
+        power-domain@MT8173_POWER_DOMAIN_VENC_LT {
+            reg = <MT8173_POWER_DOMAIN_VENC_LT>;
+            clocks = <&topckgen CLK_TOP_MM_SEL>,
+                     <&topckgen CLK_TOP_VENC_LT_SEL>;
+            clock-names = "mm", "venclt";
+            #power-domain-cells = <0>;
+        };
+        power-domain@MT8173_POWER_DOMAIN_AUDIO {
+            reg = <MT8173_POWER_DOMAIN_AUDIO>;
+            #power-domain-cells = <0>;
+        };
+        power-domain@MT8173_POWER_DOMAIN_USB {
+            reg = <MT8173_POWER_DOMAIN_USB>;
+            #power-domain-cells = <0>;
+        };
+        power-domain@MT8173_POWER_DOMAIN_MFG_ASYNC {
+            reg = <MT8173_POWER_DOMAIN_MFG_ASYNC>;
+            clocks = <&clk26m>;
+            clock-names = "mfg";
+            #address-cells = <1>;
+            #size-cells = <0>;
+            #power-domain-cells = <1>;
+
+            power-domain@MT8173_POWER_DOMAIN_MFG_2D {
+                reg = <MT8173_POWER_DOMAIN_MFG_2D>;
                 #address-cells = <1>;
                 #size-cells = <0>;
                 #power-domain-cells = <1>;
 
-                /* power domains of the SoC */
-                power-domain@MT8173_POWER_DOMAIN_VDEC {
-                    reg = <MT8173_POWER_DOMAIN_VDEC>;
-                    clocks = <&topckgen CLK_TOP_MM_SEL>;
-                    clock-names = "mm";
-                    #power-domain-cells = <0>;
-                };
-                power-domain@MT8173_POWER_DOMAIN_VENC {
-                    reg = <MT8173_POWER_DOMAIN_VENC>;
-                    clocks = <&topckgen CLK_TOP_MM_SEL>,
-                             <&topckgen CLK_TOP_VENC_SEL>;
-                    clock-names = "mm", "venc";
-                    #power-domain-cells = <0>;
-                };
-                power-domain@MT8173_POWER_DOMAIN_ISP {
-                    reg = <MT8173_POWER_DOMAIN_ISP>;
-                    clocks = <&topckgen CLK_TOP_MM_SEL>;
-                    clock-names = "mm";
-                    #power-domain-cells = <0>;
-                };
-                power-domain@MT8173_POWER_DOMAIN_MM {
-                    reg = <MT8173_POWER_DOMAIN_MM>;
-                    clocks = <&topckgen CLK_TOP_MM_SEL>;
-                    clock-names = "mm";
+                power-domain@MT8173_POWER_DOMAIN_MFG {
+                    reg = <MT8173_POWER_DOMAIN_MFG>;
                     #power-domain-cells = <0>;
                     mediatek,infracfg = <&infracfg>;
                 };
-                power-domain@MT8173_POWER_DOMAIN_VENC_LT {
-                    reg = <MT8173_POWER_DOMAIN_VENC_LT>;
-                    clocks = <&topckgen CLK_TOP_MM_SEL>,
-                             <&topckgen CLK_TOP_VENC_LT_SEL>;
-                    clock-names = "mm", "venclt";
-                    #power-domain-cells = <0>;
-                };
-                power-domain@MT8173_POWER_DOMAIN_AUDIO {
-                    reg = <MT8173_POWER_DOMAIN_AUDIO>;
-                    #power-domain-cells = <0>;
-                };
-                power-domain@MT8173_POWER_DOMAIN_USB {
-                    reg = <MT8173_POWER_DOMAIN_USB>;
-                    #power-domain-cells = <0>;
-                };
-                power-domain@MT8173_POWER_DOMAIN_MFG_ASYNC {
-                    reg = <MT8173_POWER_DOMAIN_MFG_ASYNC>;
-                    clocks = <&clk26m>;
-                    clock-names = "mfg";
-                    #address-cells = <1>;
-                    #size-cells = <0>;
-                    #power-domain-cells = <1>;
-
-                    power-domain@MT8173_POWER_DOMAIN_MFG_2D {
-                        reg = <MT8173_POWER_DOMAIN_MFG_2D>;
-                        #address-cells = <1>;
-                        #size-cells = <0>;
-                        #power-domain-cells = <1>;
-
-                        power-domain@MT8173_POWER_DOMAIN_MFG {
-                            reg = <MT8173_POWER_DOMAIN_MFG>;
-                            #power-domain-cells = <0>;
-                            mediatek,infracfg = <&infracfg>;
-                        };
-                    };
-                };
             };
         };
     };
-- 
2.35.1

