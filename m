Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4D4248C753
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 16:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245667AbiALPhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 10:37:52 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:34334 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1354653AbiALPhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 10:37:43 -0500
X-UUID: c0010ea03e1d4bc8b1fd8867459ae98d-20220112
X-UUID: c0010ea03e1d4bc8b1fd8867459ae98d-20220112
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1417043481; Wed, 12 Jan 2022 23:37:39 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 12 Jan 2022 23:37:38 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 12 Jan 2022 23:37:38 +0800
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     <chunkuang.hu@kernel.org>, <matthias.bgg@gmail.com>,
        <narmstrong@baylibre.com>, <robert.foss@linaro.org>,
        <andrzej.hajda@intel.com>, <daniel@ffwll.ch>, <airlied@linux.ie>,
        <p.zabel@pengutronix.de>
CC:     <xji@analogixsemi.com>, <jitao.shi@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>
Subject: [v8, PATCH 3/3] drm/bridge: anx7625: config hs packets end aligned to avoid screen shift
Date:   Wed, 12 Jan 2022 23:36:39 +0800
Message-ID: <20220112153639.12343-4-rex-bc.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220112153639.12343-1-rex-bc.chen@mediatek.com>
References: <20220112153639.12343-1-rex-bc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This device requires the packets on lanes aligned at the end to fix
screen shift or scroll.

Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
Reviewed-by: Xin Ji <xji@analogixsemi.com>
Acked-by: Robert Foss <robert.foss@linaro.org>
---
 drivers/gpu/drm/bridge/analogix/anx7625.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
index 2346dbcc505f..672705a68dae 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.c
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
@@ -1674,6 +1674,7 @@ static int anx7625_attach_dsi(struct anx7625_data *ctx)
 	dsi->mode_flags = MIPI_DSI_MODE_VIDEO	|
 		MIPI_DSI_MODE_VIDEO_SYNC_PULSE	|
 		MIPI_DSI_MODE_VIDEO_HSE;
+	dsi->hs_packet_end_aligned = true;
 
 	ret = devm_mipi_dsi_attach(dev, dsi);
 	if (ret) {
-- 
2.18.0

