Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC52E4799B1
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 09:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbhLRI2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 03:28:06 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:37488 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229684AbhLRI2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 03:28:05 -0500
X-UUID: 74f7ee4b39ef4a6abacc9c4a35554bfc-20211218
X-UUID: 74f7ee4b39ef4a6abacc9c4a35554bfc-20211218
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1163863723; Sat, 18 Dec 2021 16:28:04 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Sat, 18 Dec 2021 16:28:02 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sat, 18 Dec
 2021 16:28:02 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkcas11.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Sat, 18 Dec 2021 16:28:01 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Eddie Hung <eddie.hung@mediatek.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 1/5] dt-bindings: phy: mediatek: tphy: support software efuse load
Date:   Sat, 18 Dec 2021 16:27:58 +0800
Message-ID: <20211218082802.5256-1-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add optional property nvmem-cells and nvmem-cell-names to support
software efuse load, this helps to fix the efuse bit shift issue
on mt8195 etc.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v2: add acked-by Rob
---
 .../devicetree/bindings/phy/mediatek,tphy.yaml | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml b/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
index 9e6c0f43f1c6..05ee274b4b71 100644
--- a/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
+++ b/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
@@ -160,6 +160,24 @@ patternProperties:
                 - PHY_TYPE_PCIE
                 - PHY_TYPE_SATA
 
+      nvmem-cells:
+        items:
+          - description: internal R efuse for U2 PHY or U3/PCIe PHY
+          - description: rx_imp_sel efuse for U3/PCIe PHY
+          - description: tx_imp_sel efuse for U3/PCIe PHY
+        description: |
+          Phandles to nvmem cell that contains the efuse data;
+          Available only for U2 PHY or U3/PCIe PHY of version 2/3, these
+          three items should be provided at the same time for U3/PCIe PHY,
+          when use software to load efuse;
+          If unspecified, will use hardware auto-load efuse.
+
+      nvmem-cell-names:
+        items:
+          - const: intr
+          - const: rx_imp
+          - const: tx_imp
+
       # The following optional vendor properties are only for debug or HQA test
       mediatek,eye-src:
         description:
-- 
2.18.0

