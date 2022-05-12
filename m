Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9741A5245CC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 08:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350359AbiELGab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 02:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237393AbiELGa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 02:30:28 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A4822689A
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 23:30:26 -0700 (PDT)
X-UUID: 4ca2078e438340e0a1f72ea30ea28a3c-20220512
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:ef75eb94-b7f3-43be-8898-7aec5654375b,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:100
X-CID-INFO: VERSION:1.1.4,REQID:ef75eb94-b7f3-43be-8898-7aec5654375b,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,RULE:Spam_GS981B3D,AC
        TION:quarantine,TS:100
X-CID-META: VersionHash:faefae9,CLOUDID:22e804a7-eab7-4b74-a74d-5359964535a9,C
        OID:19aea8bde451,Recheck:0,SF:28|16|19|48,TC:nil,Content:0,EDM:-3,File:nil
        ,QS:0,BEC:nil
X-UUID: 4ca2078e438340e0a1f72ea30ea28a3c-20220512
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <xinlei.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2126187251; Thu, 12 May 2022 14:30:20 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 12 May 2022 14:30:18 +0800
Received: from mszsdaap41.gcn.mediatek.inc (10.16.6.141) by
 mtkcas11.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Thu, 12 May 2022 14:30:16 +0800
From:   <xinlei.lee@mediatek.com>
To:     <chunkuang.hu@kernel.org>, <p.zabel@pengutronix.de>,
        <airlied@linux.ie>, <daniel@ffwll.ch>, <matthias.bgg@gmail.com>
CC:     <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <rex-bc.chen@mediatek.com>, <jitao.shi@mediatek.com>,
        Xinlei Lee <xinlei.lee@mediatek.com>
Subject: [PATCH v6,1/4] drm/mediatek: Modify dsi funcs to atomic operations
Date:   Thu, 12 May 2022 14:30:09 +0800
Message-ID: <1652337012-9053-2-git-send-email-xinlei.lee@mediatek.com>
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1652337012-9053-1-git-send-email-xinlei.lee@mediatek.com>
References: <1652337012-9053-1-git-send-email-xinlei.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xinlei Lee <xinlei.lee@mediatek.com>

Because .enable & .disable are deprecated.
Use .atomic_enable & .atomic_disable instead.

Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
Signed-off-by: Xinlei Lee <xinlei.lee@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_dsi.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index bd3f5b485085..f880136cec09 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -763,14 +763,16 @@ static void mtk_dsi_bridge_mode_set(struct drm_bridge *bridge,
 	drm_display_mode_to_videomode(adjusted, &dsi->vm);
 }
 
-static void mtk_dsi_bridge_disable(struct drm_bridge *bridge)
+static void mtk_dsi_bridge_atomic_disable(struct drm_bridge *bridge,
+					  struct drm_bridge_state *old_bridge_state)
 {
 	struct mtk_dsi *dsi = bridge_to_dsi(bridge);
 
 	mtk_output_dsi_disable(dsi);
 }
 
-static void mtk_dsi_bridge_enable(struct drm_bridge *bridge)
+static void mtk_dsi_bridge_atomic_enable(struct drm_bridge *bridge,
+					 struct drm_bridge_state *old_bridge_state)
 {
 	struct mtk_dsi *dsi = bridge_to_dsi(bridge);
 
@@ -779,8 +781,8 @@ static void mtk_dsi_bridge_enable(struct drm_bridge *bridge)
 
 static const struct drm_bridge_funcs mtk_dsi_bridge_funcs = {
 	.attach = mtk_dsi_bridge_attach,
-	.disable = mtk_dsi_bridge_disable,
-	.enable = mtk_dsi_bridge_enable,
+	.atomic_disable = mtk_dsi_bridge_atomic_disable,
+	.atomic_enable = mtk_dsi_bridge_atomic_enable,
 	.mode_set = mtk_dsi_bridge_mode_set,
 };
 
-- 
2.18.0

