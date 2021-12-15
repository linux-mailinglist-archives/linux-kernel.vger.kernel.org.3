Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23B6E47533A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 07:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240297AbhLOG6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 01:58:46 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:51074 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S240111AbhLOG6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 01:58:42 -0500
X-UUID: 7e7503e2abb84bf0b980c2bf75e85d88-20211215
X-UUID: 7e7503e2abb84bf0b980c2bf75e85d88-20211215
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 704864354; Wed, 15 Dec 2021 14:58:38 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Wed, 15 Dec 2021 14:58:37 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 15 Dec 2021 14:58:37 +0800
From:   Trevor Wu <trevor.wu@mediatek.com>
To:     <broonie@kernel.org>, <tiwai@suse.com>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>
CC:     <trevor.wu@mediatek.com>, <alsa-devel@alsa-project.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <jiaxin.yu@mediatek.com>, <shumingf@realtek.com>
Subject: [PATCH 2/2] dt-bindings: mediatek: mt8195: add clock property to sound node
Date:   Wed, 15 Dec 2021 14:58:35 +0800
Message-ID: <20211215065835.3074-2-trevor.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20211215065835.3074-1-trevor.wu@mediatek.com>
References: <20211215065835.3074-1-trevor.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clocks and clock-names are added to provide MCLK phandle for sound card.

Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
---
 .../bindings/sound/mt8195-mt6359-rt1011-rt5682.yaml  | 12 ++++++++++++
 .../bindings/sound/mt8195-mt6359-rt1019-rt5682.yaml  | 12 ++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/mt8195-mt6359-rt1011-rt5682.yaml b/Documentation/devicetree/bindings/sound/mt8195-mt6359-rt1011-rt5682.yaml
index cf6ad7933e23..b57c856d0cf3 100644
--- a/Documentation/devicetree/bindings/sound/mt8195-mt6359-rt1011-rt5682.yaml
+++ b/Documentation/devicetree/bindings/sound/mt8195-mt6359-rt1011-rt5682.yaml
@@ -32,11 +32,21 @@ properties:
     $ref: "/schemas/types.yaml#/definitions/phandle"
     description: The phandle of MT8195 HDMI codec node.
 
+  clocks:
+    items:
+      - description: phandle and clock specifier for codec MCLK.
+
+  clock-names:
+    items:
+      - const: i2so1_mclk
+
 additionalProperties: false
 
 required:
   - compatible
   - mediatek,platform
+  - clocks
+  - clock-names
 
 examples:
   - |
@@ -44,6 +54,8 @@ examples:
     sound: mt8195-sound {
         compatible = "mediatek,mt8195_mt6359_rt1011_rt5682";
         mediatek,platform = <&afe>;
+        clocks = <&topckgen 235>; //CLK_TOP_APLL12_DIV2
+        clock-names = "i2so1_mclk";
         pinctrl-names = "default";
         pinctrl-0 = <&aud_pins_default>;
     };
diff --git a/Documentation/devicetree/bindings/sound/mt8195-mt6359-rt1019-rt5682.yaml b/Documentation/devicetree/bindings/sound/mt8195-mt6359-rt1019-rt5682.yaml
index 8f177e02ad35..e4720f76f66b 100644
--- a/Documentation/devicetree/bindings/sound/mt8195-mt6359-rt1019-rt5682.yaml
+++ b/Documentation/devicetree/bindings/sound/mt8195-mt6359-rt1019-rt5682.yaml
@@ -42,11 +42,21 @@ properties:
       A list of the desired dai-links in the sound card. Each entry is a
       name defined in the machine driver.
 
+  clocks:
+    items:
+      - description: phandle and clock specifier for codec MCLK.
+
+  clock-names:
+    items:
+      - const: i2so1_mclk
+
 additionalProperties: false
 
 required:
   - compatible
   - mediatek,platform
+  - clocks
+  - clock-names
 
 examples:
   - |
@@ -54,6 +64,8 @@ examples:
     sound: mt8195-sound {
         compatible = "mediatek,mt8195_mt6359_rt1019_rt5682";
         mediatek,platform = <&afe>;
+        clocks = <&topckgen 235>; //CLK_TOP_APLL12_DIV2
+        clock-names = "i2so1_mclk";
         pinctrl-names = "default";
         pinctrl-0 = <&aud_pins_default>;
     };
-- 
2.18.0

