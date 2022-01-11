Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6D448A7D0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 07:39:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348241AbiAKGjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 01:39:45 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:43420 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1348225AbiAKGjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 01:39:43 -0500
X-UUID: ae999e3116a54e20b0e663c46cfef506-20220111
X-UUID: ae999e3116a54e20b0e663c46cfef506-20220111
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 255145699; Tue, 11 Jan 2022 14:39:41 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Tue, 11 Jan 2022 14:39:39 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 11 Jan 2022 14:39:38 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Krzysztof Kozlowski <krzk@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Tomasz Figa" <tfiga@chromium.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <yong.wu@mediatek.com>,
        <youlin.pei@mediatek.com>, <anan.sun@mediatek.com>,
        <lc.kan@mediatek.com>, <yi.kuo@mediatek.com>,
        <anthony.huang@mediatek.com>,
        "AngeloGioacchino Del Regno" 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v2 2/6] dt-bindings: memory: mtk-smi: Fix the larb clock/clock-names dtbs warning
Date:   Tue, 11 Jan 2022 14:39:00 +0800
Message-ID: <20220111063904.7583-3-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220111063904.7583-1-yong.wu@mediatek.com>
References: <20220111063904.7583-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mute the warning from "make dtbs_check":

larb@14017000: clock-names: ['apb', 'smi'] is too short
	arch/arm64/boot/dts/mediatek/mt8183-evb.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-burnet.dt.yaml
	...

larb@16010000: clock-names: ['apb', 'smi'] is too short
	arch/arm64/boot/dts/mediatek/mt8183-evb.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-burnet.dt.yaml

larb@17010000: clock-names: ['apb', 'smi'] is too short
	arch/arm64/boot/dts/mediatek/mt8183-evb.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-burnet.dt.yaml

If a platform's larb supports gals, there will be some larbs have one
more "gals" clock while the others still only need "apb"/"smi" clocks,
then the minItems for clock and clock-names are 2.

Fixes: 27bb0e42855a ("dt-bindings: memory: mediatek: Convert SMI to DT schema")
Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 .../bindings/memory-controllers/mediatek,smi-larb.yaml      | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
index 80907e357892..884c0c74e5e4 100644
--- a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
@@ -80,10 +80,10 @@ allOf:
     then:
       properties:
         clock:
-          items:
-            minItems: 3
-            maxItems: 3
+          minItems: 2
+          maxItems: 3
         clock-names:
+          minItems: 2
           items:
             - const: apb
             - const: smi
-- 
2.18.0

