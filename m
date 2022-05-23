Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8E5530D96
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 12:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233465AbiEWJfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 05:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233236AbiEWJeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 05:34:06 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA26149F9F;
        Mon, 23 May 2022 02:34:01 -0700 (PDT)
X-UUID: 247e647d7bbd4bb1bb58660c7303cff1-20220523
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:65530a23-9485-4cea-94cc-584727b60e33,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:-5
X-CID-META: VersionHash:2a19b09,CLOUDID:cffd37e3-edbf-4bd4-8a34-dfc5f7bb086d,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:0,BEC:nil
X-UUID: 247e647d7bbd4bb1bb58660c7303cff1-20220523
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1803552878; Mon, 23 May 2022 17:33:50 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Mon, 23 May 2022 17:33:49 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 23 May 2022 17:33:49 +0800
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <matthias.bgg@gmail.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <p.zabel@pengutronix.de>,
        <angelogioacchino.delregno@collabora.com>,
        <nfraprado@collabora.com>, <chun-jie.chen@mediatek.com>,
        <wenst@chromium.org>, <runyang.chen@mediatek.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>
Subject: [RESEND v8 08/19] clk: mediatek: reset: Support inuput argument index mode
Date:   Mon, 23 May 2022 17:33:35 +0800
Message-ID: <20220523093346.28493-9-rex-bc.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220523093346.28493-1-rex-bc.chen@mediatek.com>
References: <20220523093346.28493-1-rex-bc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a large number of mediatek infra reset bits, but we do not use
all of them. In addition, the proper input argement of reset controller
soulde be index.
Therefore, to be compatible with previous drivers and usage, we add
description variables to store the ids which can mapping to index.

To use this mode, we need to put the id in rst_idx_map to map from
index to ids. For example, if we want to input index 1 (this index
is used to set bank 1 bit 14) for svs, we need to declare the reset
controller like this:

In drivers:
static u16 rst_ofs[] = {
        0x120, 0x130, 0x140, 0x150, 0x730,
};

static u16 rst_idx_map[] = {
        0 * 32 + 0,
        1 * 32 + 14,
        ....
};

static const struct mtk_clk_rst_desc clk_rst_desc = {
        .version = MTK_RST_SET_CLR,
        .rst_bank_ofs = rst_ofs,
        .rst_bank_nr = ARRAY_SIZE(rst_ofs),
        .rst_idx_map = rst_idx_map,
        .rst_idx_map_nr = ARRAY_SIZE(rst_idx_map),
};

In dts:
svs: {
        ...
        resets = <&infra 1>;
        ...
};

Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Tested-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 drivers/clk/mediatek/reset.c | 21 ++++++++++++++++++++-
 drivers/clk/mediatek/reset.h |  5 +++++
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/mediatek/reset.c b/drivers/clk/mediatek/reset.c
index 11b2f74f121d..89e617ea6393 100644
--- a/drivers/clk/mediatek/reset.c
+++ b/drivers/clk/mediatek/reset.c
@@ -98,6 +98,18 @@ static const struct reset_control_ops mtk_reset_ops_set_clr = {
 	.reset = mtk_reset_set_clr,
 };
 
+static int reset_xlate(struct reset_controller_dev *rcdev,
+		       const struct of_phandle_args *reset_spec)
+{
+	struct mtk_clk_rst_data *data = to_mtk_clk_rst_data(rcdev);
+
+	if (reset_spec->args[0] >= rcdev->nr_resets ||
+	    reset_spec->args[0] >= data->desc->rst_idx_map_nr)
+		return -EINVAL;
+
+	return data->desc->rst_idx_map[reset_spec->args[0]];
+}
+
 void mtk_register_reset_controller(struct device_node *np,
 				   const struct mtk_clk_rst_desc *desc)
 {
@@ -136,10 +148,17 @@ void mtk_register_reset_controller(struct device_node *np,
 	data->desc = desc;
 	data->regmap = regmap;
 	data->rcdev.owner = THIS_MODULE;
-	data->rcdev.nr_resets = desc->rst_bank_nr * RST_NR_PER_BANK;
 	data->rcdev.ops = rcops;
 	data->rcdev.of_node = np;
 
+	if (data->desc->rst_idx_map_nr > 0) {
+		data->rcdev.of_reset_n_cells = 1;
+		data->rcdev.nr_resets = desc->rst_idx_map_nr;
+		data->rcdev.of_xlate = reset_xlate;
+	} else {
+		data->rcdev.nr_resets = desc->rst_bank_nr * RST_NR_PER_BANK;
+	}
+
 	ret = reset_controller_register(&data->rcdev);
 	if (ret) {
 		pr_err("could not register reset controller: %d\n", ret);
diff --git a/drivers/clk/mediatek/reset.h b/drivers/clk/mediatek/reset.h
index d991510ae2d8..cc847c67a2fc 100644
--- a/drivers/clk/mediatek/reset.h
+++ b/drivers/clk/mediatek/reset.h
@@ -28,11 +28,16 @@ enum mtk_reset_version {
  * @version: Reset version which is defined in enum mtk_reset_version.
  * @rst_bank_ofs: Pointer to an array containing base offsets of the reset register.
  * @rst_bank_nr: Quantity of reset bank.
+ * @rst_idx_map:Pointer to an array containing ids if input argument is index.
+ *		This array is not necessary if our input argument does not mean index.
+ * @rst_idx_map_nr: Quantity of reset index map.
  */
 struct mtk_clk_rst_desc {
 	enum mtk_reset_version version;
 	u16 *rst_bank_ofs;
 	u32 rst_bank_nr;
+	u16 *rst_idx_map;
+	u32 rst_idx_map_nr;
 };
 
 /**
-- 
2.18.0

