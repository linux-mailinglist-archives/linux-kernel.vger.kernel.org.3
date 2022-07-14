Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3ED8574E5D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 14:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239135AbiGNMvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 08:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238087AbiGNMu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 08:50:57 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC9C62BF7;
        Thu, 14 Jul 2022 05:50:55 -0700 (PDT)
X-UUID: 90dfe66138b34436bf4e9f742a0fc03f-20220714
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:1758a53d-1a74-4cf4-bbf1-f85bd2330fbe,OB:0,LO
        B:0,IP:0,URL:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:25
X-CID-META: VersionHash:0f94e32,CLOUDID:26a54d64-0b3f-4b2c-b3a6-ed5c044366a0,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: 90dfe66138b34436bf4e9f742a0fc03f-20220714
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1713410609; Thu, 14 Jul 2022 20:50:48 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 14 Jul 2022 20:50:47 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Thu, 14 Jul 2022 20:50:47 +0800
From:   Allen-KH Cheng <allen-kh.cheng@mediatek.com>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, <nfraprado@collabora.com>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        "Chen-Yu Tsai" <wenst@chromium.org>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Subject: [PATCH v2 1/4] dt-bindings: watchdog: mediatek: Convert binding to YAML
Date:   Thu, 14 Jul 2022 20:50:41 +0800
Message-ID: <20220714125044.20403-2-allen-kh.cheng@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220714125044.20403-1-allen-kh.cheng@mediatek.com>
References: <20220714125044.20403-1-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert Mediatek watchdog devicetree binding to YAML.

Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
---
 .../bindings/watchdog/mediatek,wdt.yaml       | 64 +++++++++++++++++++
 .../devicetree/bindings/watchdog/mtk-wdt.txt  | 42 ------------
 2 files changed, 64 insertions(+), 42 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/watchdog/mediatek,wdt.yaml
 delete mode 100644 Documentation/devicetree/bindings/watchdog/mtk-wdt.txt

diff --git a/Documentation/devicetree/bindings/watchdog/mediatek,wdt.yaml b/Documentation/devicetree/bindings/watchdog/mediatek,wdt.yaml
new file mode 100644
index 000000000000..cb90d89b9f5d
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/mediatek,wdt.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/watchdog/mediatek,wdt.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediatTek SoCs Watchdog timer
+
+maintainers:
+  - Runyang Chen <runyang.chen@mediatek.com>
+
+allOf:
+  - $ref: "watchdog.yaml#"
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - mediatek,mt2712-wdt
+          - mediatek,mt6589-wdt
+          - mediatek,mt7986-wdt
+          - mediatek,mt8183-wdt
+          - mediatek,mt8186-wdt
+          - mediatek,mt8192-wdt
+          - mediatek,mt8195-wdt
+      - items:
+          - enum:
+              - mediatek,mt2701-wdt
+              - mediatek,mt6797-wdt
+              - mediatek,mt7622-wdt
+              - mediatek,mt8516-wdt
+              - mediatek,mt8173-wdt
+          - const: mediatek,mt6589-wdt
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  '#reset-cells':
+    const: 1
+
+  mediatek,disable-extrst:
+    type: boolean
+    description: disable send output reset signal
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+
+    watchdog@10007000 {
+        compatible = "mediatek,mt8186-wdt";
+        reg = <0x10007000 0x100>;
+        mediatek,disable-extrst;
+        #reset-cells = <1>;
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt b/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
deleted file mode 100644
index 762c62e428ef..000000000000
--- a/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
+++ /dev/null
@@ -1,42 +0,0 @@
-Mediatek SoCs Watchdog timer
-
-The watchdog supports a pre-timeout interrupt that fires timeout-sec/2
-before the expiry.
-
-Required properties:
-
-- compatible should contain:
-	"mediatek,mt2701-wdt", "mediatek,mt6589-wdt": for MT2701
-	"mediatek,mt2712-wdt": for MT2712
-	"mediatek,mt6582-wdt", "mediatek,mt6589-wdt": for MT6582
-	"mediatek,mt6589-wdt": for MT6589
-	"mediatek,mt6797-wdt", "mediatek,mt6589-wdt": for MT6797
-	"mediatek,mt7622-wdt", "mediatek,mt6589-wdt": for MT7622
-	"mediatek,mt7623-wdt", "mediatek,mt6589-wdt": for MT7623
-	"mediatek,mt7629-wdt", "mediatek,mt6589-wdt": for MT7629
-	"mediatek,mt7986-wdt", "mediatek,mt6589-wdt": for MT7986
-	"mediatek,mt8183-wdt": for MT8183
-	"mediatek,mt8186-wdt", "mediatek,mt6589-wdt": for MT8186
-	"mediatek,mt8516-wdt", "mediatek,mt6589-wdt": for MT8516
-	"mediatek,mt8192-wdt": for MT8192
-	"mediatek,mt8195-wdt", "mediatek,mt6589-wdt": for MT8195
-
-- reg : Specifies base physical address and size of the registers.
-
-Optional properties:
-- mediatek,disable-extrst: disable send output reset signal
-- interrupts: Watchdog pre-timeout (bark) interrupt.
-- timeout-sec: contains the watchdog timeout in seconds.
-- #reset-cells: Should be 1.
-
-Example:
-
-watchdog: watchdog@10007000 {
-	compatible = "mediatek,mt8183-wdt",
-		     "mediatek,mt6589-wdt";
-	mediatek,disable-extrst;
-	reg = <0 0x10007000 0 0x100>;
-	interrupts = <GIC_SPI 139 IRQ_TYPE_NONE>;
-	timeout-sec = <10>;
-	#reset-cells = <1>;
-};
-- 
2.18.0

