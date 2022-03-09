Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1FFA4D298B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 08:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbiCIHiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 02:38:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbiCIHhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 02:37:54 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EEBD162026
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 23:36:47 -0800 (PST)
X-UUID: 183624e734294d828ba24d606b61f31b-20220309
X-UUID: 183624e734294d828ba24d606b61f31b-20220309
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 363363584; Wed, 09 Mar 2022 15:36:40 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 9 Mar 2022 15:36:39 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 9 Mar 2022 15:36:39 +0800
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     <daniel@ffwll.ch>, <airlied@linux.ie>,
        <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
        <tzimmermann@suse.de>, <chunkuang.hu@kernel.org>,
        <p.zabel@pengutronix.de>, <matthias.bgg@gmail.com>,
        <robert.foss@linaro.org>, <andrzej.hajda@intel.com>,
        <narmstrong@baylibre.com>
CC:     <xji@analogixsemi.com>, <jitao.shi@mediatek.com>,
        <xinlei.lee@mediatek.com>, <khilman@baylibre.com>,
        <angelogioacchino.delregno@collabora.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>
Subject: [RESEND V11 1/3] drm/dsi: transfer DSI HS packets ending at the same time
Date:   Wed, 9 Mar 2022 15:36:35 +0800
Message-ID: <20220309073637.3591-2-rex-bc.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220309073637.3591-1-rex-bc.chen@mediatek.com>
References: <20220309073637.3591-1-rex-bc.chen@mediatek.com>
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
Reviewed-by: Andrzej Hajda <andrzej.hajda@intel.com>
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

