Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A14E4D298A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 08:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbiCIHiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 02:38:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbiCIHhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 02:37:54 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F363162028
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 23:36:48 -0800 (PST)
X-UUID: ec819c46e933487ebe6b07e538a45ff3-20220309
X-UUID: ec819c46e933487ebe6b07e538a45ff3-20220309
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1081879596; Wed, 09 Mar 2022 15:36:40 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 9 Mar 2022 15:36:39 +0800
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
Subject: [RESEND V11 2/3] drm/mediatek: implement the DSI HS packets aligned
Date:   Wed, 9 Mar 2022 15:36:36 +0800
Message-ID: <20220309073637.3591-3-rex-bc.chen@mediatek.com>
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

Some DSI RX devices (for example, anx7625) require last alignment of
packets on all lanes after each row of data is sent.
Otherwise, there will be some issues of shift or scroll for screen.

Take horizontal_sync_active_byte for a example,
we roundup the HSA packet data to lane number, and the subtraction of 2
is the packet data value added by the roundup operation, making the
long packets are integer multiples of lane number.
This value (2) varies with the lane number, and that is the reason we
do this operation when the lane number is 4.

In the previous operation of function "mtk_dsi_config_vdo_timing",
the length of HSA and HFP data packets has been adjusted to an
integration multiple of lane number.
Since the number of RGB data packets cannot be guaranteed to be an
integer multiple of lane number, we modify the data packet length of
HBP so that the number of HBP + RGB is equal to the lane number.
So after sending a line of data (HSA + HBP + RGB + HFP), the data
lanes are aligned.

Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
Signed-off-by: Xinlei Lee <xinlei.lee@mediatek.com>
Reviewed-by: Andrzej Hajda <andrzej.hajda@intel.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Acked-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
---
 drivers/gpu/drm/mediatek/mtk_dsi.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index bced4c7d668e..208463dbf326 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -500,6 +500,18 @@ static void mtk_dsi_config_vdo_timing(struct mtk_dsi *dsi)
 		DRM_WARN("HFP + HBP less than d-phy, FPS will under 60Hz\n");
 	}
 
+	if ((dsi->mode_flags & MIPI_DSI_HS_PKT_END_ALIGNED) &&
+	    (dsi->lanes == 4)) {
+		horizontal_sync_active_byte =
+			roundup(horizontal_sync_active_byte, dsi->lanes) - 2;
+		horizontal_frontporch_byte =
+			roundup(horizontal_frontporch_byte, dsi->lanes) - 2;
+		horizontal_backporch_byte =
+			roundup(horizontal_backporch_byte, dsi->lanes) - 2;
+		horizontal_backporch_byte -=
+			(vm->hactive * dsi_tmp_buf_bpp + 2) % dsi->lanes;
+	}
+
 	writel(horizontal_sync_active_byte, dsi->regs + DSI_HSA_WC);
 	writel(horizontal_backporch_byte, dsi->regs + DSI_HBP_WC);
 	writel(horizontal_frontporch_byte, dsi->regs + DSI_HFP_WC);
-- 
2.18.0

