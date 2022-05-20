Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 874D752E25A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 04:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344670AbiETCAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 22:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232465AbiETCAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 22:00:33 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 592EEEC3CD
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 19:00:27 -0700 (PDT)
X-UUID: 90072aa2a126403da1316885603b0603-20220520
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:f0371811-abbd-47ed-bbd5-f85edc1ea991,OB:10,L
        OB:10,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,RULE:Release_Ham,
        ACTION:release,TS:105
X-CID-INFO: VERSION:1.1.5,REQID:f0371811-abbd-47ed-bbd5-f85edc1ea991,OB:10,LOB
        :10,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,RULE:Spam_GS981B3D,
        ACTION:quarantine,TS:105
X-CID-META: VersionHash:2a19b09,CLOUDID:bc47dee2-edbf-4bd4-8a34-dfc5f7bb086d,C
        OID:24d3e0cdc46f,Recheck:0,SF:28|16|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,QS:0,BEC:nil
X-UUID: 90072aa2a126403da1316885603b0603-20220520
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <xinlei.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1841095910; Fri, 20 May 2022 10:00:13 +0800
Received: from mtkmbs07n1.mediatek.inc (172.21.101.16) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Fri, 20 May 2022 10:00:13 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 20 May 2022 10:00:12 +0800
Received: from mszsdaap41.gcn.mediatek.inc (10.16.6.141) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Fri, 20 May 2022 10:00:12 +0800
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
Subject: [PATCH v7,1/4] drm/mediatek: Modify dsi funcs to atomic operations
Date:   Fri, 20 May 2022 10:00:04 +0800
Message-ID: <1653012007-11854-2-git-send-email-xinlei.lee@mediatek.com>
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1653012007-11854-1-git-send-email-xinlei.lee@mediatek.com>
References: <1653012007-11854-1-git-send-email-xinlei.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
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
Reviewed-by: CK Hu <ck.hu@mediatek.com>
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

