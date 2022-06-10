Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 180A1545C51
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 08:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346501AbiFJGey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 02:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346168AbiFJGei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 02:34:38 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B0F18BD0C;
        Thu,  9 Jun 2022 23:34:32 -0700 (PDT)
X-UUID: 0bde1f89e9f342fa9575413c25953223-20220610
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:5af3aa35-334f-49df-bf28-7d88fd3c54ab,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:2a19b09,CLOUDID:874f5de5-2ba2-4dc1-b6c5-11feb6c769e0,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:0,BEC:nil
X-UUID: 0bde1f89e9f342fa9575413c25953223-20220610
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 529859433; Fri, 10 Jun 2022 14:34:26 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 10 Jun 2022 14:34:25 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Fri, 10 Jun 2022 14:34:25 +0800
From:   Moudy Ho <moudy.ho@mediatek.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
CC:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Rob Landley <rob@landley.net>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        <tfiga@chromium.org>, <drinkcat@chromium.org>,
        <pihsun@chromium.org>, <hsinyi@google.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        daoyuan huang <daoyuan.huang@mediatek.com>,
        Ping-Hsun Wu <ping-hsun.wu@mediatek.com>,
        <allen-kh.cheng@mediatek.com>, <xiandong.wang@mediatek.com>,
        <randy.wu@mediatek.com>, <moudy.ho@mediatek.com>,
        <jason-jh.lin@mediatek.com>, <roy-cw.yeh@mediatek.com>,
        <river.cheng@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <cellopoint.kai@gmail.com>
Subject: [PATCH v20 1/6] soc: mediatek: mutex: add common interface for modules setting
Date:   Fri, 10 Jun 2022 14:34:18 +0800
Message-ID: <20220610063424.7800-2-moudy.ho@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220610063424.7800-1-moudy.ho@mediatek.com>
References: <20220610063424.7800-1-moudy.ho@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to allow multiple modules to operate MUTEX hardware through
a common interfrace, two flexible indexes "mtk_mutex_mod_index" and
"mtk_mutex_sof_index" need to be added to replace original component
ID so that like DDP and MDP can add their own MOD table or SOF
settings independently.

In addition, 2 generic interface "mtk_mutex_write_mod" and
"mtk_mutex_write_sof" have been added, which is expected to replace
the "mtk_mutex_add_comp" and "mtk_mutex_remove_comp" pair originally
dedicated to DDP in the future.

Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
---
 drivers/soc/mediatek/mtk-mutex.c       | 53 ++++++++++++++++++++++++++
 include/linux/soc/mediatek/mtk-mutex.h | 25 ++++++++++++
 2 files changed, 78 insertions(+)

diff --git a/drivers/soc/mediatek/mtk-mutex.c b/drivers/soc/mediatek/mtk-mutex.c
index 981d56967e7a..1d2c4df18b5c 100644
--- a/drivers/soc/mediatek/mtk-mutex.c
+++ b/drivers/soc/mediatek/mtk-mutex.c
@@ -185,6 +185,7 @@ struct mtk_mutex_data {
 	const unsigned int *mutex_sof;
 	const unsigned int mutex_mod_reg;
 	const unsigned int mutex_sof_reg;
+	const unsigned int *mutex_table_mod;
 	const bool no_clk;
 };
 
@@ -606,6 +607,58 @@ void mtk_mutex_release(struct mtk_mutex *mutex)
 }
 EXPORT_SYMBOL_GPL(mtk_mutex_release);
 
+int mtk_mutex_write_mod(struct mtk_mutex *mutex,
+			enum mtk_mutex_mod_index idx, bool clear)
+{
+	struct mtk_mutex_ctx *mtx = container_of(mutex, struct mtk_mutex_ctx,
+						 mutex[mutex->id]);
+	unsigned int reg;
+	unsigned int offset;
+
+	WARN_ON(&mtx->mutex[mutex->id] != mutex);
+
+	if (idx < MUTEX_MOD_IDX_MDP_RDMA0 ||
+	    idx >= MUTEX_MOD_IDX_MAX) {
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
+EXPORT_SYMBOL_GPL(mtk_mutex_write_mod);
+
+int mtk_mutex_write_sof(struct mtk_mutex *mutex,
+			enum mtk_mutex_sof_index idx)
+{
+	struct mtk_mutex_ctx *mtx = container_of(mutex, struct mtk_mutex_ctx,
+						 mutex[mutex->id]);
+
+	WARN_ON(&mtx->mutex[mutex->id] != mutex);
+
+	if (idx < MUTEX_SOF_IDX_SINGLE_MODE ||
+	    idx >= MUTEX_SOF_IDX_MAX) {
+		dev_err(mtx->dev, "Not supported SOF index : %d", idx);
+		return -EINVAL;
+	}
+
+	writel_relaxed(idx, mtx->regs +
+		       DISP_REG_MUTEX_SOF(mtx->data->mutex_sof_reg, mutex->id));
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mtk_mutex_write_sof);
+
 static int mtk_mutex_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
diff --git a/include/linux/soc/mediatek/mtk-mutex.h b/include/linux/soc/mediatek/mtk-mutex.h
index 6fe4ffbde290..2ddab9d2b85d 100644
--- a/include/linux/soc/mediatek/mtk-mutex.h
+++ b/include/linux/soc/mediatek/mtk-mutex.h
@@ -10,6 +10,26 @@ struct regmap;
 struct device;
 struct mtk_mutex;
 
+enum mtk_mutex_mod_index {
+	/* MDP table index */
+	MUTEX_MOD_IDX_MDP_RDMA0,
+	MUTEX_MOD_IDX_MDP_RSZ0,
+	MUTEX_MOD_IDX_MDP_RSZ1,
+	MUTEX_MOD_IDX_MDP_TDSHP0,
+	MUTEX_MOD_IDX_MDP_WROT0,
+	MUTEX_MOD_IDX_MDP_WDMA,
+	MUTEX_MOD_IDX_MDP_AAL0,
+	MUTEX_MOD_IDX_MDP_CCORR0,
+
+	MUTEX_MOD_IDX_MAX		/* ALWAYS keep at the end */
+};
+
+enum mtk_mutex_sof_index {
+	MUTEX_SOF_IDX_SINGLE_MODE,
+
+	MUTEX_SOF_IDX_MAX		/* ALWAYS keep at the end */
+};
+
 struct mtk_mutex *mtk_mutex_get(struct device *dev);
 int mtk_mutex_prepare(struct mtk_mutex *mutex);
 void mtk_mutex_add_comp(struct mtk_mutex *mutex,
@@ -22,5 +42,10 @@ void mtk_mutex_unprepare(struct mtk_mutex *mutex);
 void mtk_mutex_put(struct mtk_mutex *mutex);
 void mtk_mutex_acquire(struct mtk_mutex *mutex);
 void mtk_mutex_release(struct mtk_mutex *mutex);
+int mtk_mutex_write_mod(struct mtk_mutex *mutex,
+			enum mtk_mutex_mod_index idx,
+			bool clear);
+int mtk_mutex_write_sof(struct mtk_mutex *mutex,
+			enum mtk_mutex_sof_index idx);
 
 #endif /* MTK_MUTEX_H */
-- 
2.18.0

