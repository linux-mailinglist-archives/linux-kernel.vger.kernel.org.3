Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51DF5504DE3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 10:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237293AbiDRIdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 04:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231446AbiDRIdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 04:33:09 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C070167E5;
        Mon, 18 Apr 2022 01:30:29 -0700 (PDT)
X-UUID: afc43279435d48dc93fc12faf48a4350-20220418
X-UUID: afc43279435d48dc93fc12faf48a4350-20220418
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 907026667; Mon, 18 Apr 2022 16:30:21 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Mon, 18 Apr 2022 16:30:20 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 18 Apr 2022 16:30:19 +0800
From:   Moudy Ho <moudy.ho@mediatek.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
CC:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Rob Landley <rob@landley.net>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        <tfiga@chromium.org>, <drinkcat@chromium.org>,
        <pihsun@chromium.org>, <hsinyi@google.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "daoyuan huang" <daoyuan.huang@mediatek.com>,
        Ping-Hsun Wu <ping-hsun.wu@mediatek.com>,
        <allen-kh.cheng@mediatek.com>, <xiandong.wang@mediatek.com>,
        <randy.wu@mediatek.com>, <moudy.ho@mediatek.com>,
        <jason-jh.lin@mediatek.com>, <roy-cw.yeh@mediatek.com>,
        <river.cheng@mediatek.com>, <srv_heupstream@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v16 1/6] soc: mediatek: mutex: add common interface for modules setting
Date:   Mon, 18 Apr 2022 16:30:13 +0800
Message-ID: <20220418083018.1907-2-moudy.ho@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220418083018.1907-1-moudy.ho@mediatek.com>
References: <20220418083018.1907-1-moudy.ho@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/soc/mediatek/mtk-mutex.c       | 88 ++++++++++++++++++++++++++
 include/linux/soc/mediatek/mtk-mutex.h | 22 +++++++
 2 files changed, 110 insertions(+)

diff --git a/drivers/soc/mediatek/mtk-mutex.c b/drivers/soc/mediatek/mtk-mutex.c
index aaf8fc1abb43..a62ac1811419 100644
--- a/drivers/soc/mediatek/mtk-mutex.c
+++ b/drivers/soc/mediatek/mtk-mutex.c
@@ -156,6 +156,8 @@ struct mtk_mutex_data {
 	const unsigned int *mutex_sof;
 	const unsigned int mutex_mod_reg;
 	const unsigned int mutex_sof_reg;
+	const unsigned int *mutex_table_mod;
+	const unsigned int *mutex_table_sof;
 	const bool no_clk;
 };
 
@@ -530,6 +532,92 @@ void mtk_mutex_release(struct mtk_mutex *mutex)
 }
 EXPORT_SYMBOL_GPL(mtk_mutex_release);
 
+static int mtk_mutex_write_mod(struct mtk_mutex *mutex,
+			       enum mtk_mutex_table_index idx, bool clear)
+{
+	struct mtk_mutex_ctx *mtx = container_of(mutex, struct mtk_mutex_ctx,
+						 mutex[mutex->id]);
+	unsigned int reg;
+	unsigned int offset;
+
+	WARN_ON(&mtx->mutex[mutex->id] != mutex);
+
+	if (idx < MUTEX_TABLE_IDX_MDP_RDMA0 ||
+	    idx >= MUTEX_TABLE_IDX_MAX) {
+		dev_err(mtx->dev, "Not supported MOD table index : %d", idx);
+		return -EINVAL;
+	}
+
+	offset = DISP_REG_MUTEX_MOD(mtx->data->mutex_mod_reg,
+				    mutex->id);
+	reg = readl_relaxed(mtx->regs + offset);
+
+	if (clear)
+		reg &= ~BIT(mtx->data->mutex_table_mod[idx]);
+	else
+		reg |= BIT(mtx->data->mutex_table_mod[idx]);
+
+	writel_relaxed(reg, mtx->regs + offset);
+
+	return 0;
+}
+
+int mtk_mutex_set_mod(struct mtk_mutex *mutex,
+		      enum mtk_mutex_table_index idx)
+{
+	return mtk_mutex_write_mod(mutex, idx, false);
+}
+EXPORT_SYMBOL_GPL(mtk_mutex_set_mod);
+
+int mtk_mutex_clear_mod(struct mtk_mutex *mutex,
+			enum mtk_mutex_table_index idx)
+{
+	return mtk_mutex_write_mod(mutex, idx, true);
+}
+EXPORT_SYMBOL_GPL(mtk_mutex_clear_mod);
+
+int mtk_mutex_write_sof(struct mtk_mutex *mutex,
+			enum mtk_mutex_table_index idx, bool clear)
+{
+	struct mtk_mutex_ctx *mtx = container_of(mutex, struct mtk_mutex_ctx,
+						 mutex[mutex->id]);
+	unsigned int sof_id, val;
+
+	WARN_ON(&mtx->mutex[mutex->id] != mutex);
+
+	if (idx < MUTEX_TABLE_IDX_MDP_RDMA0 ||
+	    idx >= MUTEX_TABLE_IDX_MAX) {
+		dev_err(mtx->dev, "Not supported SOF table index : %d", idx);
+		return -EINVAL;
+	}
+
+	sof_id = mtx->data->mutex_table_sof[idx];
+
+	if (clear)
+		val = MUTEX_SOF_SINGLE_MODE;
+	else
+		val = mtx->data->mutex_sof[sof_id];
+
+	writel_relaxed(val, mtx->regs +
+		       DISP_REG_MUTEX_SOF(mtx->data->mutex_sof_reg, mutex->id));
+
+	return 0;
+}
+
+int mtk_mutex_set_sof(struct mtk_mutex *mutex,
+		      enum mtk_mutex_table_index idx)
+{
+	return mtk_mutex_write_sof(mutex, idx, false);
+}
+EXPORT_SYMBOL_GPL(mtk_mutex_set_sof);
+
+int mtk_mutex_clear_sof(struct mtk_mutex *mutex,
+			enum mtk_mutex_table_index idx)
+{
+	return mtk_mutex_write_sof(mutex, idx, true);
+}
+EXPORT_SYMBOL_GPL(mtk_mutex_clear_sof);
+
 static int mtk_mutex_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
diff --git a/include/linux/soc/mediatek/mtk-mutex.h b/include/linux/soc/mediatek/mtk-mutex.h
index 6fe4ffbde290..f174452212d6 100644
--- a/include/linux/soc/mediatek/mtk-mutex.h
+++ b/include/linux/soc/mediatek/mtk-mutex.h
@@ -10,6 +10,20 @@ struct regmap;
 struct device;
 struct mtk_mutex;
 
+enum mtk_mutex_table_index {
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
+	MUTEX_TABLE_IDX_MAX		/* ALWAYS keep at the end */
+};
+
 struct mtk_mutex *mtk_mutex_get(struct device *dev);
 int mtk_mutex_prepare(struct mtk_mutex *mutex);
 void mtk_mutex_add_comp(struct mtk_mutex *mutex,
@@ -22,5 +36,13 @@ void mtk_mutex_unprepare(struct mtk_mutex *mutex);
 void mtk_mutex_put(struct mtk_mutex *mutex);
 void mtk_mutex_acquire(struct mtk_mutex *mutex);
 void mtk_mutex_release(struct mtk_mutex *mutex);
+int mtk_mutex_set_mod(struct mtk_mutex *mutex,
+		      enum mtk_mutex_table_index idx);
+int mtk_mutex_clear_mod(struct mtk_mutex *mutex,
+			enum mtk_mutex_table_index idx);
+int mtk_mutex_set_sof(struct mtk_mutex *mutex,
+		      enum mtk_mutex_table_index idx);
+int mtk_mutex_clear_sof(struct mtk_mutex *mutex,
+			enum mtk_mutex_table_index idx);
 
 #endif /* MTK_MUTEX_H */
-- 
2.18.0

