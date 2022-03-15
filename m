Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7FA4D9469
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 07:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345164AbiCOGM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 02:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345154AbiCOGMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 02:12:47 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8279749FA2;
        Mon, 14 Mar 2022 23:11:35 -0700 (PDT)
X-UUID: 6b258d2215b341d7a07080197e73bbce-20220315
X-UUID: 6b258d2215b341d7a07080197e73bbce-20220315
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 517029489; Tue, 15 Mar 2022 14:11:28 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 15 Mar 2022 14:11:26 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 15 Mar 2022 14:11:26 +0800
From:   Moudy Ho <moudy.ho@mediatek.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jernej Skrabec <jernej.skrabec@siol.net>
CC:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Landley <rob@landley.net>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        <tfiga@chromium.org>, <drinkcat@chromium.org>,
        <pihsun@chromium.org>, <hsinyi@google.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Maoguang Meng <maoguang.meng@mediatek.com>,
        daoyuan huang <daoyuan.huang@mediatek.com>,
        Ping-Hsun Wu <ping-hsun.wu@mediatek.com>,
        <menghui.lin@mediatek.com>, <sj.huang@mediatek.com>,
        <allen-kh.cheng@mediatek.com>, <randy.wu@mediatek.com>,
        <moudy.ho@mediatek.com>, <jason-jh.lin@mediatek.com>,
        <roy-cw.yeh@mediatek.com>, <river.cheng@mediatek.com>,
        <srv_heupstream@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v13 2/6] soc: mediatek: mutex: add 8183 MUTEX MOD settings for MDP
Date:   Tue, 15 Mar 2022 14:10:27 +0800
Message-ID: <20220315061031.21642-3-moudy.ho@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220315061031.21642-1-moudy.ho@mediatek.com>
References: <20220315061031.21642-1-moudy.ho@mediatek.com>
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

For the purpose of module independence, related settings should be moved
from MDP to the corresponding driver.
This patch adds 8183 MUTEX MOD settings for MDP.

Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
---
 drivers/soc/mediatek/mtk-mutex.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/soc/mediatek/mtk-mutex.c b/drivers/soc/mediatek/mtk-mutex.c
index 778b01ce9e8f..88fb4fc8f216 100644
--- a/drivers/soc/mediatek/mtk-mutex.c
+++ b/drivers/soc/mediatek/mtk-mutex.c
@@ -80,6 +80,15 @@
 #define MT8183_MUTEX_MOD_DISP_GAMMA0		16
 #define MT8183_MUTEX_MOD_DISP_DITHER0		17
 
+#define MT8183_MUTEX_MOD_MDP_RDMA0		BIT(2)
+#define MT8183_MUTEX_MOD_MDP_RSZ0		BIT(4)
+#define MT8183_MUTEX_MOD_MDP_RSZ1		BIT(5)
+#define MT8183_MUTEX_MOD_MDP_TDSHP0		BIT(6)
+#define MT8183_MUTEX_MOD_MDP_WROT0		BIT(7)
+#define MT8183_MUTEX_MOD_MDP_WDMA		BIT(8)
+#define MT8183_MUTEX_MOD_MDP_AAL0		BIT(23)
+#define MT8183_MUTEX_MOD_MDP_CCORR0		BIT(24)
+
 #define MT8173_MUTEX_MOD_DISP_OVL0		11
 #define MT8173_MUTEX_MOD_DISP_OVL1		12
 #define MT8173_MUTEX_MOD_DISP_RDMA0		13
@@ -244,6 +253,17 @@ static const unsigned int mt8183_mutex_mod[DDP_COMPONENT_ID_MAX] = {
 	[DDP_COMPONENT_WDMA0] = MT8183_MUTEX_MOD_DISP_WDMA0,
 };
 
+static const unsigned long long mt8183_mutex_table_mod[MUTEX_TABLE_IDX_MAX] = {
+	[MUTEX_TABLE_IDX_MDP_RDMA0] = MT8183_MUTEX_MOD_MDP_RDMA0,
+	[MUTEX_TABLE_IDX_MDP_RSZ0] = MT8183_MUTEX_MOD_MDP_RSZ0,
+	[MUTEX_TABLE_IDX_MDP_RSZ1] = MT8183_MUTEX_MOD_MDP_RSZ1,
+	[MUTEX_TABLE_IDX_MDP_TDSHP0] = MT8183_MUTEX_MOD_MDP_TDSHP0,
+	[MUTEX_TABLE_IDX_MDP_WROT0] = MT8183_MUTEX_MOD_MDP_WROT0,
+	[MUTEX_TABLE_IDX_MDP_WDMA] = MT8183_MUTEX_MOD_MDP_WDMA,
+	[MUTEX_TABLE_IDX_MDP_AAL0] = MT8183_MUTEX_MOD_MDP_AAL0,
+	[MUTEX_TABLE_IDX_MDP_CCORR0] = MT8183_MUTEX_MOD_MDP_CCORR0,
+};
+
 static const unsigned int mt8186_mutex_mod[DDP_COMPONENT_ID_MAX] = {
 	[DDP_COMPONENT_AAL0] = MT8186_MUTEX_MOD_DISP_AAL0,
 	[DDP_COMPONENT_CCORR] = MT8186_MUTEX_MOD_DISP_CCORR0,
@@ -335,6 +355,7 @@ static const struct mtk_mutex_data mt8183_mutex_driver_data = {
 	.mutex_sof = mt8183_mutex_sof,
 	.mutex_mod_reg = MT8183_MUTEX0_MOD0,
 	.mutex_sof_reg = MT8183_MUTEX0_SOF0,
+	.mutex_table_mod = mt8183_mutex_table_mod,
 	.no_clk = true,
 };
 
-- 
2.18.0

