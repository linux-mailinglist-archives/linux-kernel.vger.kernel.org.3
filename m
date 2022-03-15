Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E87654D9470
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 07:12:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345216AbiCOGNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 02:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345188AbiCOGMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 02:12:53 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D78849FA2;
        Mon, 14 Mar 2022 23:11:41 -0700 (PDT)
X-UUID: d9b996eea0854495aecfde7b79bc38f2-20220315
X-UUID: d9b996eea0854495aecfde7b79bc38f2-20220315
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 753537765; Tue, 15 Mar 2022 14:11:27 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Tue, 15 Mar 2022 14:11:26 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 15 Mar 2022 14:11:25 +0800
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
Subject: [PATCH v13 1/6] soc: mediatek: mutex: add common interface to accommodate multiple modules operationg MUTEX
Date:   Tue, 15 Mar 2022 14:10:26 +0800
Message-ID: <20220315061031.21642-2-moudy.ho@mediatek.com>
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

In order to allow multiple modules to operate MUTEX hardware through
a common interfrace, a flexible index "mtk_mutex_table_index" needs to
be added to replace original component ID so that like DDP and MDP
can add their own MUTEX table settings independently.

In addition, 4 generic interface "mtk_mutex_set_mod", "mtk_mutex_set_sof",
"mtk_mutex_clear_mod" and "mtk_mutex_clear_sof" have been added, which is
expected to replace the "mtk_mutex_add_comp" and "mtk_mutex_remove_comp"
pair originally dedicated to DDP in the future.

Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
---
 drivers/soc/mediatek/mtk-mutex.c       | 122 +++++++++++++++++++++++++
 include/linux/soc/mediatek/mtk-mutex.h |  33 +++++++
 2 files changed, 155 insertions(+)

diff --git a/drivers/soc/mediatek/mtk-mutex.c b/drivers/soc/mediatek/mtk-mutex.c
index aaf8fc1abb43..778b01ce9e8f 100644
--- a/drivers/soc/mediatek/mtk-mutex.c
+++ b/drivers/soc/mediatek/mtk-mutex.c
@@ -156,6 +156,7 @@ struct mtk_mutex_data {
 	const unsigned int *mutex_sof;
 	const unsigned int mutex_mod_reg;
 	const unsigned int mutex_sof_reg;
+	const unsigned long long *mutex_table_mod;
 	const bool no_clk;
 };
 
@@ -445,6 +446,84 @@ void mtk_mutex_add_comp(struct mtk_mutex *mutex,
 }
 EXPORT_SYMBOL_GPL(mtk_mutex_add_comp);
 
+void mtk_mutex_set_mod(struct mtk_mutex *mutex,
+		       enum mtk_mutex_table_index idx)
+{
+	struct mtk_mutex_ctx *mtx = container_of(mutex, struct mtk_mutex_ctx,
+						 mutex[mutex->id]);
+	unsigned int reg;
+	unsigned int offset;
+
+	WARN_ON(&mtx->mutex[mutex->id] != mutex);
+
+	if (idx == MUTEX_TABLE_IDX_NONE ||
+	    idx >= MUTEX_TABLE_IDX_MAX)
+		return;
+
+	if (mtx->data->mutex_table_mod[idx] <= BIT(31)) {
+		offset = DISP_REG_MUTEX_MOD(mtx->data->mutex_mod_reg,
+					    mutex->id);
+		reg = readl_relaxed(mtx->regs + offset);
+		reg |= mtx->data->mutex_table_mod[idx];
+		writel_relaxed(reg, mtx->regs + offset);
+	} else {
+		offset = DISP_REG_MUTEX_MOD2(mutex->id);
+		reg = readl_relaxed(mtx->regs + offset);
+		reg |= (mtx->data->mutex_table_mod[idx] >> 32);
+		writel_relaxed(reg, mtx->regs + offset);
+	}
+}
+EXPORT_SYMBOL_GPL(mtk_mutex_set_mod);
+
+void mtk_mutex_set_sof(struct mtk_mutex *mutex,
+		       enum mtk_mutex_table_index idx)
+{
+	struct mtk_mutex_ctx *mtx = container_of(mutex, struct mtk_mutex_ctx,
+						 mutex[mutex->id]);
+	unsigned int sof_id;
+
+	WARN_ON(&mtx->mutex[mutex->id] != mutex);
+
+	if (idx == MUTEX_TABLE_IDX_NONE ||
+	    idx >= MUTEX_TABLE_IDX_MAX)
+		return;
+
+	switch (idx) {
+	case MUTEX_TABLE_IDX_DDP_DSI0:
+		sof_id = MUTEX_SOF_DSI0;
+		break;
+	case MUTEX_TABLE_IDX_DDP_DSI1:
+		sof_id = MUTEX_SOF_DSI0;
+		break;
+	case MUTEX_TABLE_IDX_DDP_DSI2:
+		sof_id = MUTEX_SOF_DSI2;
+		break;
+	case MUTEX_TABLE_IDX_DDP_DSI3:
+		sof_id = MUTEX_SOF_DSI3;
+		break;
+	case MUTEX_TABLE_IDX_DDP_DPI0:
+		sof_id = MUTEX_SOF_DPI0;
+		break;
+	case MUTEX_TABLE_IDX_DDP_DPI1:
+		sof_id = MUTEX_SOF_DPI1;
+		break;
+	case MUTEX_TABLE_IDX_DDP_DP_INTF0:
+		sof_id = MUTEX_SOF_DP_INTF0;
+		break;
+	case MUTEX_TABLE_IDX_DDP_DP_INTF1:
+		sof_id = MUTEX_SOF_DP_INTF1;
+		break;
+	default:
+		sof_id = MUTEX_SOF_SINGLE_MODE;
+		break;
+	}
+
+	writel_relaxed(mtx->data->mutex_sof[sof_id],
+		       mtx->regs +
+		       DISP_REG_MUTEX_SOF(mtx->data->mutex_sof_reg, mutex->id));
+}
+EXPORT_SYMBOL_GPL(mtk_mutex_set_sof);
+
 void mtk_mutex_remove_comp(struct mtk_mutex *mutex,
 			   enum mtk_ddp_comp_id id)
 {
@@ -485,6 +564,49 @@ void mtk_mutex_remove_comp(struct mtk_mutex *mutex,
 }
 EXPORT_SYMBOL_GPL(mtk_mutex_remove_comp);
 
+void mtk_mutex_clear_mod(struct mtk_mutex *mutex,
+			 enum mtk_mutex_table_index idx)
+{
+	struct mtk_mutex_ctx *mtx = container_of(mutex, struct mtk_mutex_ctx,
+						 mutex[mutex->id]);
+	unsigned int reg;
+	unsigned int offset;
+
+	WARN_ON(&mtx->mutex[mutex->id] != mutex);
+
+	if (idx == MUTEX_TABLE_IDX_NONE ||
+	    idx >= MUTEX_TABLE_IDX_MAX)
+		return;
+
+	if (mtx->data->mutex_table_mod[idx] <= BIT(31)) {
+		offset = DISP_REG_MUTEX_MOD(mtx->data->mutex_mod_reg,
+					    mutex->id);
+		reg = readl_relaxed(mtx->regs + offset);
+		reg &= ~(mtx->data->mutex_table_mod[idx]);
+		writel_relaxed(reg, mtx->regs + offset);
+	} else {
+		offset = DISP_REG_MUTEX_MOD2(mutex->id);
+		reg = readl_relaxed(mtx->regs + offset);
+		reg &= ~(mtx->data->mutex_table_mod[idx] >> 32);
+		writel_relaxed(reg, mtx->regs + offset);
+	}
+}
+EXPORT_SYMBOL_GPL(mtk_mutex_clear_mod);
+
+void mtk_mutex_clear_sof(struct mtk_mutex *mutex)
+{
+	struct mtk_mutex_ctx *mtx = container_of(mutex, struct mtk_mutex_ctx,
+						 mutex[mutex->id]);
+
+	WARN_ON(&mtx->mutex[mutex->id] != mutex);
+
+	writel_relaxed(MUTEX_SOF_SINGLE_MODE,
+		       mtx->regs +
+		       DISP_REG_MUTEX_SOF(mtx->data->mutex_sof_reg,
+					  mutex->id));
+}
+EXPORT_SYMBOL_GPL(mtk_mutex_clear_sof);
+
 void mtk_mutex_enable(struct mtk_mutex *mutex)
 {
 	struct mtk_mutex_ctx *mtx = container_of(mutex, struct mtk_mutex_ctx,
diff --git a/include/linux/soc/mediatek/mtk-mutex.h b/include/linux/soc/mediatek/mtk-mutex.h
index 6fe4ffbde290..c8355bb0e6d6 100644
--- a/include/linux/soc/mediatek/mtk-mutex.h
+++ b/include/linux/soc/mediatek/mtk-mutex.h
@@ -10,14 +10,47 @@ struct regmap;
 struct device;
 struct mtk_mutex;
 
+enum mtk_mutex_table_index {
+	MUTEX_TABLE_IDX_NONE = 0,	/* Invalid engine */
+
+	/* MDP table index */
+	MUTEX_TABLE_IDX_MDP_RDMA0,
+	MUTEX_TABLE_IDX_MDP_RSZ0,
+	MUTEX_TABLE_IDX_MDP_RSZ1,
+	MUTEX_TABLE_IDX_MDP_TDSHP0,
+	MUTEX_TABLE_IDX_MDP_WROT0,
+	MUTEX_TABLE_IDX_MDP_WDMA,
+	MUTEX_TABLE_IDX_MDP_AAL0,
+	MUTEX_TABLE_IDX_MDP_CCORR0,
+
+	/* DDP table index */
+	MUTEX_TABLE_IDX_DDP_DSI0,
+	MUTEX_TABLE_IDX_DDP_DSI1,
+	MUTEX_TABLE_IDX_DDP_DSI2,
+	MUTEX_TABLE_IDX_DDP_DSI3,
+	MUTEX_TABLE_IDX_DDP_DPI0,
+	MUTEX_TABLE_IDX_DDP_DPI1,
+	MUTEX_TABLE_IDX_DDP_DP_INTF0,
+	MUTEX_TABLE_IDX_DDP_DP_INTF1,
+
+	MUTEX_TABLE_IDX_MAX		/* ALWAYS keep at the end */
+};
+
 struct mtk_mutex *mtk_mutex_get(struct device *dev);
 int mtk_mutex_prepare(struct mtk_mutex *mutex);
 void mtk_mutex_add_comp(struct mtk_mutex *mutex,
 			enum mtk_ddp_comp_id id);
+void mtk_mutex_set_mod(struct mtk_mutex *mutex,
+		       enum mtk_mutex_table_index idx);
+void mtk_mutex_set_sof(struct mtk_mutex *mutex,
+		       enum mtk_mutex_table_index idx);
 void mtk_mutex_enable(struct mtk_mutex *mutex);
 void mtk_mutex_disable(struct mtk_mutex *mutex);
 void mtk_mutex_remove_comp(struct mtk_mutex *mutex,
 			   enum mtk_ddp_comp_id id);
+void mtk_mutex_clear_mod(struct mtk_mutex *mutex,
+			 enum mtk_mutex_table_index idx);
+void mtk_mutex_clear_sof(struct mtk_mutex *mutex);
 void mtk_mutex_unprepare(struct mtk_mutex *mutex);
 void mtk_mutex_put(struct mtk_mutex *mutex);
 void mtk_mutex_acquire(struct mtk_mutex *mutex);
-- 
2.18.0

