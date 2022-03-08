Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6B044D10E8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 08:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344589AbiCHHZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 02:25:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235781AbiCHHZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 02:25:48 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9E43DA4C;
        Mon,  7 Mar 2022 23:24:48 -0800 (PST)
X-UUID: 75a2ed2172be4bac9292d31a23072b10-20220308
X-UUID: 75a2ed2172be4bac9292d31a23072b10-20220308
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 635396971; Tue, 08 Mar 2022 15:24:42 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 8 Mar 2022 15:24:41 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 8 Mar 2022 15:24:41 +0800
From:   Trevor Wu <trevor.wu@mediatek.com>
To:     <broonie@kernel.org>, <tiwai@suse.com>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>
CC:     <trevor.wu@mediatek.com>, <alsa-devel@alsa-project.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <aaronyu@google.com>, <yc.hung@mediatek.com>
Subject: [PATCH 2/5] dt-bindings: mediatek: mt8195: add reset property
Date:   Tue, 8 Mar 2022 15:24:32 +0800
Message-ID: <20220308072435.22460-3-trevor.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220308072435.22460-1-trevor.wu@mediatek.com>
References: <20220308072435.22460-1-trevor.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add required properties "resets" and "reset_names", which are used to
specify audiosys hw reset for mt8195 afe driver.

Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
---
 .../devicetree/bindings/sound/mt8195-afe-pcm.yaml      | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/mt8195-afe-pcm.yaml b/Documentation/devicetree/bindings/sound/mt8195-afe-pcm.yaml
index 6d0975b33d15..4452a4070eff 100644
--- a/Documentation/devicetree/bindings/sound/mt8195-afe-pcm.yaml
+++ b/Documentation/devicetree/bindings/sound/mt8195-afe-pcm.yaml
@@ -19,6 +19,12 @@ properties:
   interrupts:
     maxItems: 1
 
+  resets:
+    maxItems: 1
+
+  reset-names:
+    const: audiosys
+
   memory-region:
     maxItems: 1
     description: |
@@ -127,6 +133,8 @@ required:
   - compatible
   - reg
   - interrupts
+  - resets
+  - reset-names
   - mediatek,topckgen
   - power-domains
   - clocks
@@ -144,6 +152,8 @@ examples:
         compatible = "mediatek,mt8195-audio";
         reg = <0x10890000 0x10000>;
         interrupts = <GIC_SPI 822 IRQ_TYPE_LEVEL_HIGH 0>;
+        resets = <&watchdog 14>;
+        reset-names = "audiosys";
         mediatek,topckgen = <&topckgen>;
         power-domains = <&spm 7>; //MT8195_POWER_DOMAIN_AUDIO
         memory-region = <&snd_dma_mem_reserved>;
-- 
2.18.0

