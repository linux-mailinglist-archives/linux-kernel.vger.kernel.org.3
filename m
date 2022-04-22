Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E762350B009
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 08:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442640AbiDVGFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 02:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353757AbiDVGEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 02:04:54 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C6F4F9F3;
        Thu, 21 Apr 2022 23:02:01 -0700 (PDT)
X-UUID: 44514549b90c435ea18792e3f10929d3-20220422
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:3758eada-732a-4b54-9899-21cfbb19d0a5,OB:0,LO
        B:30,IP:0,URL:8,TC:0,Content:-20,EDM:0,RT:0,SF:95,FILE:0,RULE:Release_Ham,
        ACTION:release,TS:83
X-CID-INFO: VERSION:1.1.4,REQID:3758eada-732a-4b54-9899-21cfbb19d0a5,OB:0,LOB:
        30,IP:0,URL:8,TC:0,Content:-20,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS981B3D,
        ACTION:quarantine,TS:83
X-CID-META: VersionHash:faefae9,CLOUDID:7121bdef-06b0-4305-bfbf-554bfc9d151a,C
        OID:9c90337cb41b,Recheck:0,SF:13|15|28|17|19|48,TC:nil,Content:0,EDM:-3,Fi
        le:nil,QS:0,BEC:nil
X-UUID: 44514549b90c435ea18792e3f10929d3-20220422
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1674056120; Fri, 22 Apr 2022 14:02:00 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 22 Apr 2022 14:01:58 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 22 Apr 2022 14:01:58 +0800
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <matthias.bgg@gmail.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <p.zabel@pengutronix.de>,
        <angelogioacchino.delregno@collabora.com>,
        <chun-jie.chen@mediatek.com>, <wenst@chromium.org>,
        <runyang.chen@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>
Subject: [PATCH V3 09/17] clk: mediatek: reset: Add support for input offset and bit from DT
Date:   Fri, 22 Apr 2022 14:01:44 +0800
Message-ID: <20220422060152.13534-10-rex-bc.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220422060152.13534-1-rex-bc.chen@mediatek.com>
References: <20220422060152.13534-1-rex-bc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To use the clock reset function easier, we implement the of_xlate.
The calculation of return value is different from each reset version.

There is no impact for original use. If the argument number is not
larger than 1, it will return original id.

With this implementation if we want to set offset 0x120 and bit 16,
we can just write "resets = <&infra_rst 0x120 16>;" in the module node.

Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
---
 drivers/clk/mediatek/reset.c | 31 +++++++++++++++++++++++++++++++
 drivers/clk/mediatek/reset.h |  1 +
 2 files changed, 32 insertions(+)

diff --git a/drivers/clk/mediatek/reset.c b/drivers/clk/mediatek/reset.c
index fe917b2eeab4..2a2f3dede77f 100644
--- a/drivers/clk/mediatek/reset.c
+++ b/drivers/clk/mediatek/reset.c
@@ -97,6 +97,33 @@ static const struct reset_control_ops mtk_reset_ops_set_clr = {
 	.reset = mtk_reset_set_clr,
 };
 
+static int reset_xlate(struct reset_controller_dev *rcdev,
+		       const struct of_phandle_args *reset_spec)
+{
+	struct mtk_clk_rst_data *data = to_mtk_clk_rst_data(rcdev);
+	unsigned int offset, bit, shift;
+
+	if (reset_spec->args_count <= 1)
+		return reset_spec->args[0];
+
+	switch (data->desc->version) {
+	case MTK_RST_SIMPLE:
+		shift = 2;
+		break;
+	case MTK_RST_SET_CLR:
+		shift = 4;
+		break;
+	default:
+		pr_err("Unknown reset version %d\n", data->desc->version);
+		return -EINVAL;
+	}
+
+	offset = reset_spec->args[0];
+	bit = reset_spec->args[1];
+
+	return (offset >> shift) * 32 + bit;
+}
+
 int mtk_register_reset_controller(struct device_node *np,
 				  const struct mtk_clk_rst_desc *desc)
 {
@@ -138,6 +165,8 @@ int mtk_register_reset_controller(struct device_node *np,
 	data->rcdev.nr_resets = desc->rst_set_nr * 32;
 	data->rcdev.ops = rcops;
 	data->rcdev.of_node = np;
+	data->rcdev.of_reset_n_cells = max(desc->reset_n_cells, 1);
+	data->rcdev.of_xlate = reset_xlate;
 
 	ret = reset_controller_register(&data->rcdev);
 	if (ret) {
@@ -192,6 +221,8 @@ int mtk_register_reset_controller_with_dev(struct device *dev,
 	data->rcdev.ops = rcops;
 	data->rcdev.of_node = np;
 	data->rcdev.dev = dev;
+	data->rcdev.of_reset_n_cells = max(desc->reset_n_cells, 1);
+	data->rcdev.of_xlate = reset_xlate;
 
 	ret = devm_reset_controller_register(dev, &data->rcdev);
 	if (ret) {
diff --git a/drivers/clk/mediatek/reset.h b/drivers/clk/mediatek/reset.h
index 79efbea37c9b..6838a644eaef 100644
--- a/drivers/clk/mediatek/reset.h
+++ b/drivers/clk/mediatek/reset.h
@@ -19,6 +19,7 @@ struct mtk_clk_rst_desc {
 	u8 version;
 	u32 rst_set_nr;
 	u16 reg_ofs;
+	int reset_n_cells;
 };
 
 struct mtk_clk_rst_data {
-- 
2.18.0

