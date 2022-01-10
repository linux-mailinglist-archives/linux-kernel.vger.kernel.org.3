Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57B4B489A3F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 14:44:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233136AbiAJNoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 08:44:37 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:38836 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S233147AbiAJNob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 08:44:31 -0500
X-UUID: 9961e190b73642d28ed330c02a5a7d50-20220110
X-UUID: 9961e190b73642d28ed330c02a5a7d50-20220110
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <chun-jie.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 286354737; Mon, 10 Jan 2022 21:44:26 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Mon, 10 Jan 2022 21:44:25 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 10 Jan 2022 21:44:25 +0800
From:   Chun-Jie Chen <chun-jie.chen@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>
Subject: [v1 01/16] dt-bindings: ARM: Mediatek: Add new document bindings of MT8186 clock
Date:   Mon, 10 Jan 2022 21:44:01 +0800
Message-ID: <20220110134416.5191-2-chun-jie.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220110134416.5191-1-chun-jie.chen@mediatek.com>
References: <20220110134416.5191-1-chun-jie.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the new binding documentation for system clock
and functional clock on Mediatek MT8186.

Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
---
 .../arm/mediatek/mediatek,mt8186-clock.yaml   | 133 ++++++++++++++++++
 .../mediatek/mediatek,mt8186-sys-clock.yaml   |  74 ++++++++++
 2 files changed, 207 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8186-clock.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8186-sys-clock.yaml

diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8186-clock.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8186-clock.yaml
new file mode 100644
index 000000000000..fc39101bc9b0
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8186-clock.yaml
@@ -0,0 +1,133 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/arm/mediatek/mediatek,mt8186-clock.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Mediatek Functional Clock Controller for MT8186
+
+maintainers:
+  - Chun-Jie Chen <chun-jie.chen@mediatek.com>
+
+description:
+  The clock architecture in Mediatek like below
+  PLLs -->
+          dividers -->
+                      muxes
+                           -->
+                              clock gate
+
+  The devices provide clock gate control in different IP blocks.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - mediatek,mt8186-imp_iic_wrap
+          - mediatek,mt8186-mfgsys
+          - mediatek,mt8186-wpesys
+          - mediatek,mt8186-imgsys1
+          - mediatek,mt8186-imgsys2
+          - mediatek,mt8186-vdecsys
+          - mediatek,mt8186-vencsys
+          - mediatek,mt8186-camsys
+          - mediatek,mt8186-camsys_rawa
+          - mediatek,mt8186-camsys_rawb
+          - mediatek,mt8186-mdpsys
+          - mediatek,mt8186-ipesys
+  reg:
+    maxItems: 1
+
+  '#clock-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    imp_iic_wrap: clock-controller@11017000 {
+        compatible = "mediatek,mt8186-imp_iic_wrap";
+        reg = <0x11017000 0x1000>;
+        #clock-cells = <1>;
+    };
+
+  - |
+    mfgsys: clock-controller@13000000 {
+        compatible = "mediatek,mt8186-mfgsys";
+        reg = <0x13000000 0x1000>;
+        #clock-cells = <1>;
+    };
+
+  - |
+    wpesys: clock-controller@14020000 {
+        compatible = "mediatek,mt8186-wpesys";
+        reg = <0x14020000 0x1000>;
+        #clock-cells = <1>;
+    };
+
+  - |
+    imgsys1: clock-controller@15020000 {
+        compatible = "mediatek,mt8186-imgsys1";
+        reg = <0x15020000 0x1000>;
+        #clock-cells = <1>;
+    };
+
+  - |
+    imgsys2: clock-controller@15820000 {
+        compatible = "mediatek,mt8186-imgsys2";
+        reg = <0x15820000 0x1000>;
+        #clock-cells = <1>;
+    };
+
+  - |
+    vdecsys: clock-controller@1602f000 {
+        compatible = "mediatek,mt8186-vdecsys";
+        reg = <0x1602f000 0x1000>;
+        #clock-cells = <1>;
+    };
+
+  - |
+    vencsys: clock-controller@17000000 {
+        compatible = "mediatek,mt8186-vencsys";
+        reg = <0x17000000 0x1000>;
+        #clock-cells = <1>;
+    };
+
+  - |
+    camsys: clock-controller@1a000000 {
+        compatible = "mediatek,mt8186-camsys";
+        reg = <0x1a000000 0x1000>;
+        #clock-cells = <1>;
+    };
+
+  - |
+    camsys_rawa: clock-controller@1a04f000 {
+        compatible = "mediatek,mt8186-camsys_rawa";
+        reg = <0x1a04f000 0x1000>;
+        #clock-cells = <1>;
+    };
+
+  - |
+    camsys_rawb: clock-controller@1a06f000 {
+        compatible = "mediatek,mt8186-camsys_rawb";
+        reg = <0x1a06f000 0x1000>;
+        #clock-cells = <1>;
+    };
+
+  - |
+    mdpsys: clock-controller@1b000000 {
+        compatible = "mediatek,mt8186-mdpsys";
+        reg = <0x1b000000 0x1000>;
+        #clock-cells = <1>;
+    };
+
+  - |
+    ipesys: clock-controller@1c000000 {
+        compatible = "mediatek,mt8186-ipesys";
+        reg = <0x1c000000 0x1000>;
+        #clock-cells = <1>;
+    };
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8186-sys-clock.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8186-sys-clock.yaml
new file mode 100644
index 000000000000..11473971a165
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8186-sys-clock.yaml
@@ -0,0 +1,74 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/arm/mediatek/mediatek,mt8186-sys-clock.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Mediatek System Clock Controller for MT8186
+
+maintainers:
+  - Chun-Jie Chen <chun-jie.chen@mediatek.com>
+
+description:
+  The clock architecture in Mediatek like below
+  PLLs -->
+          dividers -->
+                      muxes
+                           -->
+                              clock gate
+
+  The apmixedsys provides most of PLLs which generated from SoC 26m.
+  The topckgen provides dividers and muxes which provide the clock source to other IP blocks.
+  The infracfg_ao provides clock gate in peripheral and infrastructure IP blocks.
+  The mcusys provides mux control to select the clock source in AP MCU.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - mediatek,mt8186-mcusys
+          - mediatek,mt8186-topckgen
+          - mediatek,mt8186-infracfg_ao
+          - mediatek,mt8186-apmixedsys
+      - const: syscon
+
+  reg:
+    maxItems: 1
+
+  '#clock-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    mcusys: syscon@c53a000 {
+        compatible = "mediatek,mt8186-mcusys", "syscon";
+        reg = <0xc53a000 0x1000>;
+        #clock-cells = <1>;
+    };
+
+  - |
+    topckgen: syscon@10000000 {
+        compatible = "mediatek,mt8186-topckgen", "syscon";
+        reg = <0x10000000 0x1000>;
+        #clock-cells = <1>;
+    };
+
+  - |
+    infracfg_ao: syscon@10001000 {
+        compatible = "mediatek,mt8186-infracfg_ao", "syscon";
+        reg = <0x10001000 0x1000>;
+        #clock-cells = <1>;
+    };
+
+  - |
+    apmixedsys: syscon@1000c000 {
+        compatible = "mediatek,mt8186-apmixedsys", "syscon";
+        reg = <0x1000c000 0x1000>;
+        #clock-cells = <1>;
+    };
-- 
2.18.0

