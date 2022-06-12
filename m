Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62898547A6B
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 15:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237192AbiFLNyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 09:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237140AbiFLNyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 09:54:31 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD20C56FBA;
        Sun, 12 Jun 2022 06:54:24 -0700 (PDT)
X-UUID: 6a856f5ec905409faa7acdccf8377267-20220612
X-CID-P-RULE: Spam_GS6885AD
X-CID-O-INFO: VERSION:1.1.5,REQID:0db3988f-deaa-4abb-899d-59f59000e4a5,OB:0,LO
        B:0,IP:0,URL:25,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,RULE:Spam_GS6885AD
        ,ACTION:quarantine,TS:125
X-CID-INFO: VERSION:1.1.5,REQID:0db3988f-deaa-4abb-899d-59f59000e4a5,OB:0,LOB:
        0,IP:0,URL:25,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,RULE:Spam_GS981B3D,A
        CTION:quarantine,TS:125
X-CID-META: VersionHash:2a19b09,CLOUDID:c88f96e7-1f03-4449-90ad-e6cb8f3d1399,C
        OID:b1b634de6ec6,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,QS:0,BEC:nil
X-UUID: 6a856f5ec905409faa7acdccf8377267-20220612
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <johnson.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 200731574; Sun, 12 Jun 2022 21:54:17 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Sun, 12 Jun 2022 21:54:16 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Sun, 12 Jun 2022 21:54:16 +0800
From:   Johnson Wang <johnson.wang@mediatek.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        Edward-JW Yang <edward-jw.yang@mediatek.com>
Subject: [RFC PATCH 1/2] dt-bindings: arm: mediatek: Add new bindings of MediaTek frequency hopping
Date:   Sun, 12 Jun 2022 21:54:13 +0800
Message-ID: <20220612135414.3003-2-johnson.wang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220612135414.3003-1-johnson.wang@mediatek.com>
References: <20220612135414.3003-1-johnson.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the new binding documentation for frequency hopping
and spread spectrum clocking control on MT8186.

Signed-off-by: Edward-JW Yang <edward-jw.yang@mediatek.com>
Signed-off-by: Johnson Wang <johnson.wang@mediatek.com>
---
 .../bindings/arm/mediatek/mediatek,fhctl.yaml | 149 ++++++++++++++++++
 1 file changed, 149 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,fhctl.yaml

diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,fhctl.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,fhctl.yaml
new file mode 100644
index 000000000000..9cb04bed9e86
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,fhctl.yaml
@@ -0,0 +1,149 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/mediatek/mediatek,fhctl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek frequency hopping and spread spectrum clocking control
+
+maintainers:
+  - Edward-JW Yang <edward-jw.yang@mediatek.com>
+
+description: |
+  Frequency hopping control (FHCTL) is a piece of hardware that control
+  some PLLs to adopt "hopping" mechanism to adjust their frequency.
+  Spread spectrum clocking (SSC) is another function provided by this hardware.
+
+properties:
+  compatible:
+    const: mediatek,mt8186-fhctl
+
+  reg:
+    maxItems: 2
+
+patternProperties:
+  "^map[0-9]$":
+    type: object
+    description:
+      Represents a group of PLLs controlled by the same domain and method.
+
+    properties:
+      domain:
+        description: The position of this hardware block in the chip.
+        $ref: /schemas/types.yaml#/definitions/string-array
+
+      method:
+        description: Determine which method to control this FHCTL hardware.
+        $ref: /schemas/types.yaml#/definitions/string-array
+
+    patternProperties:
+      "^armpll_(ll|bl)|(cci|main|mm|tvd|m|adsp|mfg|nna|nna2|msdc)pll$":
+        type: object
+        description:
+          A subnode represents one PLL clock. The properties it contains are
+          used to determine whether this PLL enable frequency hopping mechanism           and spread spectrum clocking (SSC) control.
+
+        properties:
+          fh-id:
+            description: The index of the PLL clocks.
+            $ref: /schemas/types.yaml#/definitions/uint32
+
+          perms:
+            description:
+              This is a bit field used to manage the permission of frequency
+              hopping function and spread spectrum clocking control.
+            $ref: /schemas/types.yaml#/definitions/uint32
+
+          ssc-rate:
+            description: The percentage of the spectrum spreading.
+            $ref: /schemas/types.yaml#/definitions/uint32
+            minimum: 0
+            maximum: 8
+
+        required:
+          - fh-id
+          - perms
+
+    required:
+      - domain
+      - method
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/mt8186-clk.h>
+    fhctl: fhctl@1000ce00 {
+        compatible = "mediatek,mt8186-fhctl";
+        reg = <0x1000ce00 0x200>,
+              <0x1000c000 0xe00>;
+        map0 {
+            domain = "top";
+            method = "fhctl-ap";
+
+            armpll_ll {
+                fh-id = <0>;
+                perms = <0x10>;
+            };
+
+            armpll_bl {
+                fh-id = <1>;
+                perms = <0x10>;
+            };
+
+            ccipll {
+                fh-id = <2>;
+                perms = <0x10>;
+            };
+
+            mainpll {
+                fh-id = <3>;
+                perms = <0x1c>;
+            };
+
+            mmpll {
+                fh-id = <4>;
+                perms = <0x1c>;
+            };
+
+            tvdpll {
+                fh-id = <5>;
+                perms = <0x1c>;
+            };
+
+            mpll {
+                fh-id = <6>;
+                perms = <0x10>;
+            };
+
+            adsppll {
+                fh-id = <7>;
+                perms = <0x1c>;
+            };
+
+            mfgpll {
+                fh-id = <8>;
+                perms = <0x1c>;
+            };
+
+            nnapll {
+                fh-id = <9>;
+                perms = <0x1c>;
+            };
+
+            nna2pll {
+                fh-id = <10>;
+                perms = <0x1c>;
+            };
+
+            msdcpll {
+                fh-id = <11>;
+                perms = <0x1c>;
+                ssc-rate = <3>;
+            };
+        };
+    };
-- 
2.18.0

