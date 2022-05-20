Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4402052E256
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 04:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344705AbiETCAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 22:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344658AbiETCAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 22:00:34 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29AA0EC3ED
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 19:00:29 -0700 (PDT)
X-UUID: 96a0ea2889df44b0a53e6d679e768fe6-20220520
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:4e20b46f-e882-43f3-a0a8-34fb53e148b0,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:100
X-CID-INFO: VERSION:1.1.5,REQID:4e20b46f-e882-43f3-a0a8-34fb53e148b0,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,RULE:Spam_GS981B3D,AC
        TION:quarantine,TS:100
X-CID-META: VersionHash:2a19b09,CLOUDID:5d48dee2-edbf-4bd4-8a34-dfc5f7bb086d,C
        OID:b3a8ea352d8a,Recheck:0,SF:28|16|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,QS:0,BEC:nil
X-UUID: 96a0ea2889df44b0a53e6d679e768fe6-20220520
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <xinlei.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 773746285; Fri, 20 May 2022 10:00:17 +0800
Received: from mtkmbs07n1.mediatek.inc (172.21.101.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Fri, 20 May 2022 10:00:15 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 20 May 2022 10:00:15 +0800
Received: from mszsdaap41.gcn.mediatek.inc (10.16.6.141) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Fri, 20 May 2022 10:00:14 +0800
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
Subject: [PATCH v7,2/4] drm/mediatek: Separate poweron/poweroff from enable/disable and define new funcs
Date:   Fri, 20 May 2022 10:00:05 +0800
Message-ID: <1653012007-11854-3-git-send-email-xinlei.lee@mediatek.com>
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

From: Jitao Shi <jitao.shi@mediatek.com>

In order to match the changes of "Use the drm_panel_bridge API",
the poweron/poweroff of dsi is extracted from enable/disable and
defined as new funcs (atomic_pre_enable/atomic_post_disable).

Since dsi_poweron is moved from dsi_enable to pre_enable function, in
order to avoid poweron failure, the operation of dsi register fails to
cause bus hang. Therefore, the protection mechanism is added to the
dsi_enable function.

Fixes: 2dd8075d2185 ("drm/mediatek: mtk_dsi: Use the drm_panel_bridge API")

Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
Signed-off-by: Xinlei Lee <xinlei.lee@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_dsi.c | 53 +++++++++++++++++++-----------
 1 file changed, 34 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index f880136cec09..d9a6b928dba8 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -691,16 +691,6 @@ static void mtk_dsi_poweroff(struct mtk_dsi *dsi)
 	if (--dsi->refcount != 0)
 		return;
 
-	/*
-	 * mtk_dsi_stop() and mtk_dsi_start() is asymmetric, since
-	 * mtk_dsi_stop() should be called after mtk_drm_crtc_atomic_disable(),
-	 * which needs irq for vblank, and mtk_dsi_stop() will disable irq.
-	 * mtk_dsi_start() needs to be called in mtk_output_dsi_enable(),
-	 * after dsi is fully set.
-	 */
-	mtk_dsi_stop(dsi);
-
-	mtk_dsi_switch_to_cmd_mode(dsi, VM_DONE_INT_FLAG, 500);
 	mtk_dsi_reset_engine(dsi);
 	mtk_dsi_lane0_ulp_mode_enter(dsi);
 	mtk_dsi_clk_ulp_mode_enter(dsi);
@@ -715,17 +705,9 @@ static void mtk_dsi_poweroff(struct mtk_dsi *dsi)
 
 static void mtk_output_dsi_enable(struct mtk_dsi *dsi)
 {
-	int ret;
-
 	if (dsi->enabled)
 		return;
 
-	ret = mtk_dsi_poweron(dsi);
-	if (ret < 0) {
-		DRM_ERROR("failed to power on dsi\n");
-		return;
-	}
-
 	mtk_dsi_set_mode(dsi);
 	mtk_dsi_clk_hs_mode(dsi, 1);
 
@@ -739,7 +721,16 @@ static void mtk_output_dsi_disable(struct mtk_dsi *dsi)
 	if (!dsi->enabled)
 		return;
 
-	mtk_dsi_poweroff(dsi);
+	/*
+	 * mtk_dsi_stop() and mtk_dsi_start() is asymmetric, since
+	 * mtk_dsi_stop() should be called after mtk_drm_crtc_atomic_disable(),
+	 * which needs irq for vblank, and mtk_dsi_stop() will disable irq.
+	 * mtk_dsi_start() needs to be called in mtk_output_dsi_enable(),
+	 * after dsi is fully set.
+	 */
+	mtk_dsi_stop(dsi);
+
+	mtk_dsi_switch_to_cmd_mode(dsi, VM_DONE_INT_FLAG, 500);
 
 	dsi->enabled = false;
 }
@@ -776,13 +767,37 @@ static void mtk_dsi_bridge_atomic_enable(struct drm_bridge *bridge,
 {
 	struct mtk_dsi *dsi = bridge_to_dsi(bridge);
 
+	if (dsi->refcount == 0)
+		return;
+
 	mtk_output_dsi_enable(dsi);
 }
 
+static void mtk_dsi_bridge_atomic_pre_enable(struct drm_bridge *bridge,
+					     struct drm_bridge_state *old_bridge_state)
+{
+	struct mtk_dsi *dsi = bridge_to_dsi(bridge);
+	int ret;
+
+	ret = mtk_dsi_poweron(dsi);
+	if (ret < 0)
+		DRM_ERROR("failed to power on dsi\n");
+}
+
+static void mtk_dsi_bridge_atomic_post_disable(struct drm_bridge *bridge,
+					       struct drm_bridge_state *old_bridge_state)
+{
+	struct mtk_dsi *dsi = bridge_to_dsi(bridge);
+
+	mtk_dsi_poweroff(dsi);
+}
+
 static const struct drm_bridge_funcs mtk_dsi_bridge_funcs = {
 	.attach = mtk_dsi_bridge_attach,
 	.atomic_disable = mtk_dsi_bridge_atomic_disable,
 	.atomic_enable = mtk_dsi_bridge_atomic_enable,
+	.atomic_pre_enable = mtk_dsi_bridge_atomic_pre_enable,
+	.atomic_post_disable = mtk_dsi_bridge_atomic_post_disable,
 	.mode_set = mtk_dsi_bridge_mode_set,
 };
 
-- 
2.18.0

