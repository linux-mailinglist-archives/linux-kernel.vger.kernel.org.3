Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9881248C6A7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 16:02:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354399AbiALPBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 10:01:50 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:48586 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1354387AbiALPBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 10:01:49 -0500
X-UUID: da3aa3e0ca114818b1d6d272fd8940d8-20220112
X-UUID: da3aa3e0ca114818b1d6d272fd8940d8-20220112
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1695475155; Wed, 12 Jan 2022 23:01:47 +0800
Received: from MTKMBS34N1.mediatek.inc (172.27.4.172) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 12 Jan 2022 23:01:45 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS34N1.mediatek.inc
 (172.27.4.172) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 12 Jan
 2022 23:01:44 +0800
Received: from mszsdaap41.gcn.mediatek.inc (10.16.6.141) by
 MTKCAS32.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Wed, 12 Jan 2022 23:01:38 +0800
From:   Jitao Shi <jitao.shi@mediatek.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Daniel Vetter" <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC:     <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <ck.hu@mediatek.com>,
        <stonea168@163.com>, <huijuan.xie@mediatek.com>,
        <rex-bc.chen@mediatek.com>, <shuijing.li@mediatek.com>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        Guillaume Ranquet <granquet@baylibre.com>,
        Jitao Shi <jitao.shi@mediatek.com>
Subject: [PATCH] drm/mediatek: DP HPD Detect with debounce
Date:   Wed, 12 Jan 2022 23:01:33 +0800
Message-ID: <20220112150133.11275-1-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.12.5
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DP Spec 1.4a 3.3 requires dp detect the hpd with debounce.

Upstream implementations should implement HPD signal de-bouncing on
an external connection. A period of 100ms should be used for
detecting an HPD connect event (i.e., the event, “HPD high,” is
confirmed only after HPD has been continuously asserted for 100ms).
Care should be taken to not implement de-bouncing on an IRQ_HPD and
on a downstream device-generated pair of HPD disconnect/reconnect
events (typically HPD shall be de-asserted for more than 2ms, but
less than 100ms in this case). To cover these cases, HPD de-bounce
should be implemented only after HPD low has been detected for 100ms.
 Timing requirements in this Standard related to the detection of
HPD high are to be interpreted as applying from the completion of an
implementation-dependent de-bounce period.

Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_dp.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek/mtk_dp.c
index a256d55346a2..05f401a024a4 100644
--- a/drivers/gpu/drm/mediatek/mtk_dp.c
+++ b/drivers/gpu/drm/mediatek/mtk_dp.c
@@ -193,6 +193,8 @@ struct mtk_dp {
 	struct mutex eld_lock;
 	u8 connector_eld[MAX_ELD_BYTES];
 	struct drm_connector *conn;
+	bool need_debounce;
+	struct timer_list debounce_timer;
 };
 
 enum mtk_dp_sdp_type {
@@ -2217,6 +2219,9 @@ static irqreturn_t mtk_dp_hpd_event_thread(int hpd, void *dev)
 	if (event < 0)
 		return IRQ_HANDLED;
 
+	if (mtk_dp->need_debounce && mtk_dp->train_info.cable_plugged_in)
+		msleep(100);
+
 	if (mtk_dp->drm_dev) {
 		dev_info(mtk_dp->dev, "drm_helper_hpd_irq_event\n");
 		drm_helper_hpd_irq_event(mtk_dp->bridge.dev);
@@ -2296,6 +2301,14 @@ static irqreturn_t mtk_dp_hpd_isr_handler(struct mtk_dp *mtk_dp)
 		mtk_dp->train_state = MTK_DP_TRAIN_STATE_STARTUP;
 	}
 	train_info->cable_state_change = true;
+
+	if (train_info->cable_state_change) {
+		if (!train_info->cable_plugged_in) {
+			mod_timer(&mtk_dp->debounce_timer, jiffies + msecs_to_jiffies(100) - 1);
+			mtk_dp->need_debounce = false;
+		}
+	}
+
 	return IRQ_WAKE_THREAD;
 }
 
@@ -2903,6 +2916,13 @@ static int mtk_dp_register_audio_driver(struct device *dev)
 	return 0;
 }
 
+static void mtk_dp_debounce_timer(struct timer_list *t)
+{
+	struct mtk_dp *mtk_dp = from_timer(mtk_dp, t, debounce_timer);
+
+	mtk_dp->need_debounce = true;
+}
+
 static int mtk_dp_probe(struct platform_device *pdev)
 {
 	struct mtk_dp *mtk_dp;
@@ -2990,6 +3010,9 @@ static int mtk_dp_probe(struct platform_device *pdev)
 	else
 		mtk_dp->bridge.type = DRM_MODE_CONNECTOR_DisplayPort;
 
+	mtk_dp->need_debounce = true;
+	timer_setup(&mtk_dp->debounce_timer, mtk_dp_debounce_timer, 0);
+
 	mtk_dp->bridge.ops =
 		DRM_BRIDGE_OP_DETECT | DRM_BRIDGE_OP_EDID | DRM_BRIDGE_OP_HPD;
 	drm_bridge_add(&mtk_dp->bridge);
@@ -3008,6 +3031,7 @@ static int mtk_dp_remove(struct platform_device *pdev)
 
 	mtk_dp_video_mute(mtk_dp, true);
 	mtk_dp_audio_mute(mtk_dp, true);
+	del_timer_sync(&mtk_dp->debounce_timer);
 
 	pm_runtime_disable(&pdev->dev);
 
-- 
2.12.5

