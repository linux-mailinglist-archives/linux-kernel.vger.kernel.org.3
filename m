Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90DCB4707B7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 18:52:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244799AbhLJR4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 12:56:19 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:50148 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S244793AbhLJR4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 12:56:12 -0500
X-UUID: 1c019f4130a5403398ab93a1e9e240df-20211211
X-UUID: 1c019f4130a5403398ab93a1e9e240df-20211211
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <flora.fu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1481951548; Sat, 11 Dec 2021 01:52:34 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Sat, 11 Dec 2021 01:52:33 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 11 Dec 2021 01:52:33 +0800
From:   Flora Fu <flora.fu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Pi-Cheng Chen <pi-cheng.chen@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Flora Fu <flora.fu@mediatek.com>,
        "JB Tsai" <jb.tsai@mediatek.com>
Subject: [PATCH 03/12] dt-bindings: soc: mediatek: apu: Add MT8195 APU power bindings
Date:   Sat, 11 Dec 2021 01:52:14 +0800
Message-ID: <20211210175223.31131-4-flora.fu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20211210175223.31131-1-flora.fu@mediatek.com>
References: <20211210175223.31131-1-flora.fu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MT8195 APU power bindings.

Signed-off-by: Flora Fu <flora.fu@mediatek.com>

---
 .../soc/mediatek/mediatek,apu-pwr.yaml        | 23 ++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/soc/mediatek/mediatek,apu-pwr.yaml b/Documentation/devicetree/bindings/soc/mediatek/mediatek,apu-pwr.yaml
index 00f67dddb162..93afb9919f1f 100644
--- a/Documentation/devicetree/bindings/soc/mediatek/mediatek,apu-pwr.yaml
+++ b/Documentation/devicetree/bindings/soc/mediatek/mediatek,apu-pwr.yaml
@@ -19,6 +19,7 @@ properties:
     items:
       - enum:
           - mediatek,mt8192-apu-power
+          - mediatek,mt8195-apu-power
   reg:
     minItems: 1
 
@@ -47,7 +48,27 @@ required:
   - vvpu-supply
   - vmdla-supply
 
-additionalProperties: false
+additionalProperties:
+  if:
+    properties:
+      compatible:
+        enum:
+          - mediatek,mt8195-apu-power
+  then:
+    type: object
+    description:
+      Represent node that will trigger early probing to all iommu device.
+      The APU device all iommu device to be probed before boot remote tinysys.
+    properties:
+      compatible:
+        enum:
+          - mediatek,apu_combo_iommu0
+          - mediatek,apu_combo_iommu1
+      iommus:
+        maxItems: 1
+    required:
+      - compatible
+      - iommus
 
 examples:
   - |
-- 
2.18.0

