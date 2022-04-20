Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 527FF508248
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 09:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359858AbiDTHiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 03:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376277AbiDTHhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 03:37:40 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 707A4FFF;
        Wed, 20 Apr 2022 00:34:53 -0700 (PDT)
X-UUID: c57dc06fb9b848048db847afd4aff9dd-20220420
X-UUID: c57dc06fb9b848048db847afd4aff9dd-20220420
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <irui.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1009755596; Wed, 20 Apr 2022 15:34:44 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Wed, 20 Apr 2022 15:34:43 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 20 Apr 2022 15:34:42 +0800
From:   Irui Wang <irui.wang@mediatek.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Rob Herring <robh+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>
CC:     Maoguang Meng <maoguang.meng@mediatek.com>,
        Longfei Wang <longfei.wang@mediatek.com>,
        Irui Wang <irui.wang@mediatek.com>,
        <allen-kh.cheng@mediatek.com>, <linux-media@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH] dt-bindings: media: mtk-vcodec: Adds encoder power domain property
Date:   Wed, 20 Apr 2022 15:34:39 +0800
Message-ID: <20220420073440.31649-1-irui.wang@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        RDNS_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds encoder power domain property

Signed-off-by: Irui Wang <irui.wang@mediatek.com>
---
 .../devicetree/bindings/media/mediatek,vcodec-encoder.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml b/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml
index deb5b657a2d5..3c069c965992 100644
--- a/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml
+++ b/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml
@@ -41,6 +41,9 @@ properties:
 
   assigned-clock-parents: true
 
+  power-domains:
+    maxItems: 1
+
   iommus:
     minItems: 1
     maxItems: 32
@@ -72,6 +75,7 @@ required:
   - iommus
   - assigned-clocks
   - assigned-clock-parents
+  - power-domains
 
 allOf:
   - if:
@@ -132,6 +136,7 @@ examples:
     #include <dt-bindings/clock/mt8173-clk.h>
     #include <dt-bindings/memory/mt8173-larb-port.h>
     #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/power/mt8173-power.h>
 
     vcodec_enc_avc: vcodec@18002000 {
       compatible = "mediatek,mt8173-vcodec-enc";
@@ -153,6 +158,7 @@ examples:
       clock-names = "venc_sel";
       assigned-clocks = <&topckgen CLK_TOP_VENC_SEL>;
       assigned-clock-parents = <&topckgen CLK_TOP_VCODECPLL>;
+      power-domains = <&scpsys MT8173_POWER_DOMAIN_VENC>;
     };
 
     vcodec_enc_vp8: vcodec@19002000 {
@@ -173,4 +179,5 @@ examples:
       clock-names = "venc_lt_sel";
       assigned-clocks = <&topckgen CLK_TOP_VENC_LT_SEL>;
       assigned-clock-parents = <&topckgen CLK_TOP_VCODECPLL_370P5>;
+      power-domains = <&scpsys MT8173_POWER_DOMAIN_VENC_LT>;
     };
-- 
2.18.0

