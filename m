Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4864932EA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 03:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350974AbiASC0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 21:26:05 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:35142 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1350960AbiASC0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 21:26:04 -0500
X-UUID: 848e9bbd8a4843009ffc17201ab05ef0-20220119
X-UUID: 848e9bbd8a4843009ffc17201ab05ef0-20220119
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 336013434; Wed, 19 Jan 2022 10:26:03 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 19 Jan 2022 10:26:01 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 19 Jan 2022 10:26:01 +0800
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     <chunkuang.hu@kernel.org>, <matthias.bgg@gmail.com>,
        <narmstrong@baylibre.com>, <robert.foss@linaro.org>,
        <andrzej.hajda@intel.com>, <daniel@ffwll.ch>, <airlied@linux.ie>,
        <p.zabel@pengutronix.de>
CC:     <xji@analogixsemi.com>, <jitao.shi@mediatek.com>,
        <xinlei.lee@mediatek.com>,
        <angelogioacchino.delregno@collabora.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>
Subject: [v10,1/3] drm/dsi: transfer DSI HS packets ending at the same time
Date:   Wed, 19 Jan 2022 10:25:41 +0800
Message-ID: <20220119022543.26093-2-rex-bc.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220119022543.26093-1-rex-bc.chen@mediatek.com>
References: <20220119022543.26093-1-rex-bc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since a HS transmission is composed of an arbitrary number
of bytes that may not be an integer multiple of lanes, some
lanes may run out of data before others.
(Defined in 6.1.3 of mipi_DSI_specification_v.01-02-00)

However, for some DSI RX devices (for example, anx7625),
there is a limitation that packet number should be the same
on all DSI lanes. In other words, they need to end a HS at
the same time.

Because this limitation is for some specific DSI RX devices,
it is more reasonable to put the enable control in these
DSI RX drivers. If DSI TX driver knows the information,
they can adjust the setting for this situation.

Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
Acked-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 include/drm/drm_mipi_dsi.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
index 147e51b6d241..51e09a1a106a 100644
--- a/include/drm/drm_mipi_dsi.h
+++ b/include/drm/drm_mipi_dsi.h
@@ -137,6 +137,8 @@ struct mipi_dsi_host *of_find_mipi_dsi_host_by_node(struct device_node *node);
 #define MIPI_DSI_CLOCK_NON_CONTINUOUS	BIT(10)
 /* transmit data in low power */
 #define MIPI_DSI_MODE_LPM		BIT(11)
+/* transmit data ending at the same time for all lanes within one hsync */
+#define MIPI_DSI_HS_PKT_END_ALIGNED	BIT(12)
 
 enum mipi_dsi_pixel_format {
 	MIPI_DSI_FMT_RGB888,
-- 
2.18.0

