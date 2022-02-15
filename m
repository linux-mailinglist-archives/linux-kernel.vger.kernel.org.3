Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31E2E4B6D42
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 14:20:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238242AbiBONUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 08:20:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236492AbiBONUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 08:20:33 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C86F406A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 05:20:20 -0800 (PST)
X-UUID: 0cd7c7ee83454b0ca9e02a15fc1d9314-20220215
X-UUID: 0cd7c7ee83454b0ca9e02a15fc1d9314-20220215
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 201544414; Tue, 15 Feb 2022 21:20:16 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 15 Feb 2022 21:20:15 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 15 Feb 2022 21:20:15 +0800
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     <matthias.bgg@gmail.com>
CC:     <chunkuang.hu@kernel.org>, <jitao.shi@mediatek.com>,
        <xinlei.lee@mediatek.com>, <enric.balletbo@collabora.com>,
        <angelogioacchino.delregno@collabora.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>
Subject: [2/2] soc: mediatek: mmsys: add mmsys reset control for MT8186
Date:   Tue, 15 Feb 2022 21:19:52 +0800
Message-ID: <20220215131952.27861-3-rex-bc.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220215131952.27861-1-rex-bc.chen@mediatek.com>
References: <20220215131952.27861-1-rex-bc.chen@mediatek.com>
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

Add mmsys reset control register offset 0x160 for MT8186.

This patch is based on mmsys patch for MT8186 on [1].
[1]: https://patchwork.kernel.org/project/linux-mediatek/patch/20220215075953.3310-4-rex-bc.chen@mediatek.com/

Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
---
 drivers/soc/mediatek/mt8186-mmsys.h | 2 ++
 drivers/soc/mediatek/mtk-mmsys.c    | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/soc/mediatek/mt8186-mmsys.h b/drivers/soc/mediatek/mt8186-mmsys.h
index 7de329f2d729..c72ccf86ea28 100644
--- a/drivers/soc/mediatek/mt8186-mmsys.h
+++ b/drivers/soc/mediatek/mt8186-mmsys.h
@@ -52,6 +52,8 @@
 #define MT8186_DPI0_FROM_DITHER0			1
 #define MT8186_DPI0_FROM_RDMA0				2
 
+#define MT8186_MMSYS_SW0_RST_B				0x160
+
 static const struct mtk_mmsys_routes mmsys_mt8186_routing_table[] = {
 	{
 		DDP_COMPONENT_OVL0, DDP_COMPONENT_RDMA0,
diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-mmsys.c
index cab62c3eac05..4fc4c2c9ea20 100644
--- a/drivers/soc/mediatek/mtk-mmsys.c
+++ b/drivers/soc/mediatek/mtk-mmsys.c
@@ -63,6 +63,7 @@ static const struct mtk_mmsys_driver_data mt8186_mmsys_driver_data = {
 	.clk_driver = "clk-mt8186-mm",
 	.routes = mmsys_mt8186_routing_table,
 	.num_routes = ARRAY_SIZE(mmsys_mt8186_routing_table),
+	.sw0_rst_offset = MT8186_MMSYS_SW0_RST_B,
 };
 
 static const struct mtk_mmsys_driver_data mt8192_mmsys_driver_data = {
-- 
2.18.0

