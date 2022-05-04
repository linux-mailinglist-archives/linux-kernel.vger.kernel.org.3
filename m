Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF7E519EA5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 13:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349151AbiEDL7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 07:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349141AbiEDL6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 07:58:53 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 895C62D1D2;
        Wed,  4 May 2022 04:55:11 -0700 (PDT)
X-UUID: d6cdd6385c8e4adbbd0471a4c83c866a-20220504
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:fe384f87-ce7e-4aa1-8859-42cc89756b6d,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:faefae9,CLOUDID:383a2b16-2e53-443e-b81a-655c13977218,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: d6cdd6385c8e4adbbd0471a4c83c866a-20220504
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 19661362; Wed, 04 May 2022 19:55:04 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Wed, 4 May 2022 19:55:03 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Wed, 4 May 2022 19:55:03 +0800
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <matthias.bgg@gmail.com>
CC:     <runyang.chen@mediatek.com>, <linux-mediatek@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>
Subject: [PATCH v2 2/3] soc: mediatek: devapc: Separate register offsets from mtk_devapc_data
Date:   Wed, 4 May 2022 19:55:00 +0800
Message-ID: <20220504115501.3490-3-rex-bc.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220504115501.3490-1-rex-bc.chen@mediatek.com>
References: <20220504115501.3490-1-rex-bc.chen@mediatek.com>
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

The register offsets is the same between MT6779 and MT8186. To reuse the
register offsets, we move these register offsets to another structure
"mtk_devapc_regs_ofs".

Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
---
 drivers/soc/mediatek/mtk-devapc.c | 37 ++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-devapc.c b/drivers/soc/mediatek/mtk-devapc.c
index 7c65ad3d1f8a..f27e22cbb770 100644
--- a/drivers/soc/mediatek/mtk-devapc.c
+++ b/drivers/soc/mediatek/mtk-devapc.c
@@ -31,10 +31,7 @@ struct mtk_devapc_vio_dbgs {
 	u32 vio_dbg1;
 };
 
-struct mtk_devapc_data {
-	/* numbers of violation index */
-	u32 vio_idx_num;
-
+struct mtk_devapc_regs_ofs {
 	/* reg offset */
 	u32 vio_mask_offset;
 	u32 vio_sta_offset;
@@ -46,6 +43,12 @@ struct mtk_devapc_data {
 	u32 vio_shift_con_offset;
 };
 
+struct mtk_devapc_data {
+	/* numbers of violation index */
+	u32 vio_idx_num;
+	const struct mtk_devapc_regs_ofs *regs_ofs;
+};
+
 struct mtk_devapc_context {
 	struct device *dev;
 	void __iomem *infra_base;
@@ -58,7 +61,7 @@ static void clear_vio_status(struct mtk_devapc_context *ctx)
 	void __iomem *reg;
 	int i;
 
-	reg = ctx->infra_base + ctx->data->vio_sta_offset;
+	reg = ctx->infra_base + ctx->data->regs_ofs->vio_sta_offset;
 
 	for (i = 0; i < VIO_MOD_TO_REG_IND(ctx->data->vio_idx_num) - 1; i++)
 		writel(GENMASK(31, 0), reg + 4 * i);
@@ -73,7 +76,7 @@ static void mask_module_irq(struct mtk_devapc_context *ctx, bool mask)
 	u32 val;
 	int i;
 
-	reg = ctx->infra_base + ctx->data->vio_mask_offset;
+	reg = ctx->infra_base + ctx->data->regs_ofs->vio_mask_offset;
 
 	if (mask)
 		val = GENMASK(31, 0);
@@ -116,11 +119,11 @@ static int devapc_sync_vio_dbg(struct mtk_devapc_context *ctx)
 	u32 val;
 
 	pd_vio_shift_sta_reg = ctx->infra_base +
-			       ctx->data->vio_shift_sta_offset;
+			       ctx->data->regs_ofs->vio_shift_sta_offset;
 	pd_vio_shift_sel_reg = ctx->infra_base +
-			       ctx->data->vio_shift_sel_offset;
+			       ctx->data->regs_ofs->vio_shift_sel_offset;
 	pd_vio_shift_con_reg = ctx->infra_base +
-			       ctx->data->vio_shift_con_offset;
+			       ctx->data->regs_ofs->vio_shift_con_offset;
 
 	/* Find the minimum shift group which has violation */
 	val = readl(pd_vio_shift_sta_reg);
@@ -161,8 +164,8 @@ static void devapc_extract_vio_dbg(struct mtk_devapc_context *ctx)
 	void __iomem *vio_dbg0_reg;
 	void __iomem *vio_dbg1_reg;
 
-	vio_dbg0_reg = ctx->infra_base + ctx->data->vio_dbg0_offset;
-	vio_dbg1_reg = ctx->infra_base + ctx->data->vio_dbg1_offset;
+	vio_dbg0_reg = ctx->infra_base + ctx->data->regs_ofs->vio_dbg0_offset;
+	vio_dbg1_reg = ctx->infra_base + ctx->data->regs_ofs->vio_dbg1_offset;
 
 	vio_dbgs.vio_dbg0 = readl(vio_dbg0_reg);
 	vio_dbgs.vio_dbg1 = readl(vio_dbg1_reg);
@@ -200,7 +203,7 @@ static irqreturn_t devapc_violation_irq(int irq_number, void *data)
  */
 static void start_devapc(struct mtk_devapc_context *ctx)
 {
-	writel(BIT(31), ctx->infra_base + ctx->data->apc_con_offset);
+	writel(BIT(31), ctx->infra_base + ctx->data->regs_ofs->apc_con_offset);
 
 	mask_module_irq(ctx, false);
 }
@@ -212,11 +215,10 @@ static void stop_devapc(struct mtk_devapc_context *ctx)
 {
 	mask_module_irq(ctx, true);
 
-	writel(BIT(2), ctx->infra_base + ctx->data->apc_con_offset);
+	writel(BIT(2), ctx->infra_base + ctx->data->regs_ofs->apc_con_offset);
 }
 
-static const struct mtk_devapc_data devapc_mt6779 = {
-	.vio_idx_num = 511,
+static const struct mtk_devapc_regs_ofs devapc_regs_ofs_mt6779 = {
 	.vio_mask_offset = 0x0,
 	.vio_sta_offset = 0x400,
 	.vio_dbg0_offset = 0x900,
@@ -227,6 +229,11 @@ static const struct mtk_devapc_data devapc_mt6779 = {
 	.vio_shift_con_offset = 0xF20,
 };
 
+static const struct mtk_devapc_data devapc_mt6779 = {
+	.vio_idx_num = 511,
+	.regs_ofs = &devapc_regs_ofs_mt6779,
+};
+
 static const struct of_device_id mtk_devapc_dt_match[] = {
 	{
 		.compatible = "mediatek,mt6779-devapc",
-- 
2.18.0

