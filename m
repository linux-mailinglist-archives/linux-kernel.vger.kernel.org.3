Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1B914C9964
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 00:35:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238682AbiCAXgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 18:36:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233036AbiCAXgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 18:36:14 -0500
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1432761A34;
        Tue,  1 Mar 2022 15:35:33 -0800 (PST)
Received: by mail-oo1-f53.google.com with SMTP id s203-20020a4a3bd4000000b003191c2dcbe8so41312oos.9;
        Tue, 01 Mar 2022 15:35:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mjAm0YWASTEf57JVUS2I1+2cvaNRD0CHbjx/YiEWgzo=;
        b=7DR6Tz5EH1LbLTVv4a0S9UG9Y2VJytqIVj2CYsWOpqritbdTo7TR3286NemjiIvf3m
         W4lloUQEY0yw12sC+lNnkOZBbxDDbN+W8hUIRqXJzmB4bhKpuUL2HkGere3Z4QvbJJQw
         xn4dDGCV6dNBYq9CG7cubl3UZNqtP9wp1SHGpXUjTftjcE8pvAENaYCZOaNlyo7JvR24
         LXXJxh6j1+MF/iiaBctpLQeT8xofjIOPNLj2Kgh8emNklUwHQC+bjoTfNkr2YHLFaMnF
         IYHgf4McojPcSO0cGmflSU/RspiQNdw1io22J7xSo/j5JkeB2kCnoYfDQ7Go4MhhUC2X
         v2GA==
X-Gm-Message-State: AOAM531wF1qBzFAgYByRZbfP8LOY6bA5s/9NdCbHzDy+sx/RMEngf/5I
        sw5yZN//6UrUmkuuum/NyA==
X-Google-Smtp-Source: ABdhPJzt9hj8uaSjUrfFAo0GVVDli7ueQD5CfQhr+S2QXfU8PSjp5ZmMY3gZvPNE+wzjCn+Xdx2IuA==
X-Received: by 2002:a05:6870:3c18:b0:d7:22ed:20b0 with SMTP id gk24-20020a0568703c1800b000d722ed20b0mr7641309oab.32.1646177732368;
        Tue, 01 Mar 2022 15:35:32 -0800 (PST)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id 36-20020a9d0ba7000000b005ad59f1f783sm7337990oth.3.2022.03.01.15.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 15:35:31 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH] dt-bindings: media: mediatek,vcodec: Fix addressing cell sizes
Date:   Tue,  1 Mar 2022 17:35:00 -0600
Message-Id: <20220301233501.2110047-1-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'dma-ranges' in the example is written for cell sizes of 2 cells, but
the schema and example specify sizes of 1 cell. As the h/w has a bus
address of >32-bits, cell sizes of 2 is correct. Update the schema's
'#address-cells' and '#size-cells' to be 2 and adjust the example
throughout.

There's no error currently because dtc only checks 'dma-ranges' is a
correct multiple number of cells (3) and the schema checking is based on
bracketing of entries.

Signed-off-by: Rob Herring <robh@kernel.org>
---
I noticed the driver is checking 'dma-ranges' itself. That's generally
wrong as the core code should be configuring bus dma masks
automatically.
---
 .../media/mediatek,vcodec-subdev-decoder.yaml | 122 +++++++++---------
 1 file changed, 64 insertions(+), 58 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/mediatek,vcodec-subdev-decoder.yaml b/Documentation/devicetree/bindings/media/mediatek,vcodec-subdev-decoder.yaml
index d587fc3e39fb..7687be0f50aa 100644
--- a/Documentation/devicetree/bindings/media/mediatek,vcodec-subdev-decoder.yaml
+++ b/Documentation/devicetree/bindings/media/mediatek,vcodec-subdev-decoder.yaml
@@ -72,10 +72,10 @@ properties:
       Describes the physical address space of IOMMU maps to memory.
 
   "#address-cells":
-    const: 1
+    const: 2
 
   "#size-cells":
-    const: 1
+    const: 2
 
   ranges: true
 
@@ -205,61 +205,67 @@ examples:
     #include <dt-bindings/clock/mt8192-clk.h>
     #include <dt-bindings/power/mt8192-power.h>
 
-    video-codec@16000000 {
-        compatible = "mediatek,mt8192-vcodec-dec";
-        mediatek,scp = <&scp>;
-        iommus = <&iommu0 M4U_PORT_L4_VDEC_MC_EXT>;
-        dma-ranges = <0x1 0x0 0x0 0x40000000 0x0 0xfff00000>;
-        #address-cells = <1>;
-        #size-cells = <1>;
-        ranges = <0 0x16000000 0x40000>;
-        reg = <0x16000000 0x1000>;		/* VDEC_SYS */
-        vcodec-lat@10000 {
-            compatible = "mediatek,mtk-vcodec-lat";
-            reg = <0x10000 0x800>;
-            interrupts = <GIC_SPI 426 IRQ_TYPE_LEVEL_HIGH 0>;
-            iommus = <&iommu0 M4U_PORT_L5_VDEC_LAT0_VLD_EXT>,
-                <&iommu0 M4U_PORT_L5_VDEC_LAT0_VLD2_EXT>,
-                <&iommu0 M4U_PORT_L5_VDEC_LAT0_AVC_MV_EXT>,
-                <&iommu0 M4U_PORT_L5_VDEC_LAT0_PRED_RD_EXT>,
-                <&iommu0 M4U_PORT_L5_VDEC_LAT0_TILE_EXT>,
-                <&iommu0 M4U_PORT_L5_VDEC_LAT0_WDMA_EXT>,
-                <&iommu0 M4U_PORT_L5_VDEC_LAT0_RG_CTRL_DMA_EXT>,
-                <&iommu0 M4U_PORT_L5_VDEC_UFO_ENC_EXT>;
-            clocks = <&topckgen CLK_TOP_VDEC_SEL>,
-                <&vdecsys_soc CLK_VDEC_SOC_VDEC>,
-                <&vdecsys_soc CLK_VDEC_SOC_LAT>,
-                <&vdecsys_soc CLK_VDEC_SOC_LARB1>,
-                <&topckgen CLK_TOP_MAINPLL_D4>;
-            clock-names = "sel", "soc-vdec", "soc-lat", "vdec", "top";
-            assigned-clocks = <&topckgen CLK_TOP_VDEC_SEL>;
-            assigned-clock-parents = <&topckgen CLK_TOP_MAINPLL_D4>;
-            power-domains = <&spm MT8192_POWER_DOMAIN_VDEC>;
-        };
-
-        vcodec-core@25000 {
-            compatible = "mediatek,mtk-vcodec-core";
-            reg = <0x25000 0x1000>;
-            interrupts = <GIC_SPI 425 IRQ_TYPE_LEVEL_HIGH 0>;
-            iommus = <&iommu0 M4U_PORT_L4_VDEC_MC_EXT>,
-                <&iommu0 M4U_PORT_L4_VDEC_UFO_EXT>,
-                <&iommu0 M4U_PORT_L4_VDEC_PP_EXT>,
-                <&iommu0 M4U_PORT_L4_VDEC_PRED_RD_EXT>,
-                <&iommu0 M4U_PORT_L4_VDEC_PRED_WR_EXT>,
-                <&iommu0 M4U_PORT_L4_VDEC_PPWRAP_EXT>,
-                <&iommu0 M4U_PORT_L4_VDEC_TILE_EXT>,
-                <&iommu0 M4U_PORT_L4_VDEC_VLD_EXT>,
-                <&iommu0 M4U_PORT_L4_VDEC_VLD2_EXT>,
-                <&iommu0 M4U_PORT_L4_VDEC_AVC_MV_EXT>,
-                <&iommu0 M4U_PORT_L4_VDEC_RG_CTRL_DMA_EXT>;
-            clocks = <&topckgen CLK_TOP_VDEC_SEL>,
-                <&vdecsys CLK_VDEC_VDEC>,
-                <&vdecsys CLK_VDEC_LAT>,
-                <&vdecsys CLK_VDEC_LARB1>,
-                <&topckgen CLK_TOP_MAINPLL_D4>;
-            clock-names = "sel", "soc-vdec", "soc-lat", "vdec", "top";
-            assigned-clocks = <&topckgen CLK_TOP_VDEC_SEL>;
-            assigned-clock-parents = <&topckgen CLK_TOP_MAINPLL_D4>;
-            power-domains = <&spm MT8192_POWER_DOMAIN_VDEC2>;
+    bus@16000000 {
+        #address-cells = <2>;
+        #size-cells = <2>;
+        ranges = <0 0x16000000 0x16000000 0 0x40000>;
+
+        video-codec@16000000 {
+            compatible = "mediatek,mt8192-vcodec-dec";
+            mediatek,scp = <&scp>;
+            iommus = <&iommu0 M4U_PORT_L4_VDEC_MC_EXT>;
+            dma-ranges = <0x1 0x0 0x0 0x40000000 0x0 0xfff00000>;
+            #address-cells = <2>;
+            #size-cells = <2>;
+            ranges = <0 0 0 0x16000000 0 0x40000>;
+            reg = <0 0x16000000 0 0x1000>;		/* VDEC_SYS */
+            vcodec-lat@10000 {
+                compatible = "mediatek,mtk-vcodec-lat";
+                reg = <0 0x10000 0 0x800>;
+                interrupts = <GIC_SPI 426 IRQ_TYPE_LEVEL_HIGH 0>;
+                iommus = <&iommu0 M4U_PORT_L5_VDEC_LAT0_VLD_EXT>,
+                    <&iommu0 M4U_PORT_L5_VDEC_LAT0_VLD2_EXT>,
+                    <&iommu0 M4U_PORT_L5_VDEC_LAT0_AVC_MV_EXT>,
+                    <&iommu0 M4U_PORT_L5_VDEC_LAT0_PRED_RD_EXT>,
+                    <&iommu0 M4U_PORT_L5_VDEC_LAT0_TILE_EXT>,
+                    <&iommu0 M4U_PORT_L5_VDEC_LAT0_WDMA_EXT>,
+                    <&iommu0 M4U_PORT_L5_VDEC_LAT0_RG_CTRL_DMA_EXT>,
+                    <&iommu0 M4U_PORT_L5_VDEC_UFO_ENC_EXT>;
+                clocks = <&topckgen CLK_TOP_VDEC_SEL>,
+                    <&vdecsys_soc CLK_VDEC_SOC_VDEC>,
+                    <&vdecsys_soc CLK_VDEC_SOC_LAT>,
+                    <&vdecsys_soc CLK_VDEC_SOC_LARB1>,
+                    <&topckgen CLK_TOP_MAINPLL_D4>;
+                clock-names = "sel", "soc-vdec", "soc-lat", "vdec", "top";
+                assigned-clocks = <&topckgen CLK_TOP_VDEC_SEL>;
+                assigned-clock-parents = <&topckgen CLK_TOP_MAINPLL_D4>;
+                power-domains = <&spm MT8192_POWER_DOMAIN_VDEC>;
+            };
+
+            vcodec-core@25000 {
+                compatible = "mediatek,mtk-vcodec-core";
+                reg = <0 0x25000 0 0x1000>;
+                interrupts = <GIC_SPI 425 IRQ_TYPE_LEVEL_HIGH 0>;
+                iommus = <&iommu0 M4U_PORT_L4_VDEC_MC_EXT>,
+                    <&iommu0 M4U_PORT_L4_VDEC_UFO_EXT>,
+                    <&iommu0 M4U_PORT_L4_VDEC_PP_EXT>,
+                    <&iommu0 M4U_PORT_L4_VDEC_PRED_RD_EXT>,
+                    <&iommu0 M4U_PORT_L4_VDEC_PRED_WR_EXT>,
+                    <&iommu0 M4U_PORT_L4_VDEC_PPWRAP_EXT>,
+                    <&iommu0 M4U_PORT_L4_VDEC_TILE_EXT>,
+                    <&iommu0 M4U_PORT_L4_VDEC_VLD_EXT>,
+                    <&iommu0 M4U_PORT_L4_VDEC_VLD2_EXT>,
+                    <&iommu0 M4U_PORT_L4_VDEC_AVC_MV_EXT>,
+                    <&iommu0 M4U_PORT_L4_VDEC_RG_CTRL_DMA_EXT>;
+                clocks = <&topckgen CLK_TOP_VDEC_SEL>,
+                    <&vdecsys CLK_VDEC_VDEC>,
+                    <&vdecsys CLK_VDEC_LAT>,
+                    <&vdecsys CLK_VDEC_LARB1>,
+                    <&topckgen CLK_TOP_MAINPLL_D4>;
+                clock-names = "sel", "soc-vdec", "soc-lat", "vdec", "top";
+                assigned-clocks = <&topckgen CLK_TOP_VDEC_SEL>;
+                assigned-clock-parents = <&topckgen CLK_TOP_MAINPLL_D4>;
+                power-domains = <&spm MT8192_POWER_DOMAIN_VDEC2>;
+            };
         };
     };
-- 
2.32.0

