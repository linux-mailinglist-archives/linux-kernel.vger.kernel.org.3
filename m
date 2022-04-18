Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18F19505A0A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 16:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344946AbiDRObc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 10:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245689AbiDRO1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 10:27:31 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F3052E71;
        Mon, 18 Apr 2022 06:22:30 -0700 (PDT)
X-UUID: 59057909ce474155a8537829dd3a3f4c-20220418
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:87980c2e-94ff-46bd-9dff-f25f7df1f570,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-20,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:-20
X-CID-META: VersionHash:faefae9,CLOUDID:919c41ef-06b0-4305-bfbf-554bfc9d151a,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: 59057909ce474155a8537829dd3a3f4c-20220418
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1229306514; Mon, 18 Apr 2022 21:22:26 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Mon, 18 Apr 2022 21:22:24 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 18 Apr 2022 21:22:24 +0800
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>
CC:     <matthias.bgg@gmail.com>, <p.zabel@pengutronix.de>,
        <angelogioacchino.delregno@collabora.com>,
        <chun-jie.chen@mediatek.com>, <wenst@chromium.org>,
        <yong.liang@mediatek.com>, <runyang.chen@mediatek.com>,
        <linux-kernel@vger.kernel.org>, <allen-kh.cheng@mediatek.com>,
        <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>
Subject: [PATCH 7/7] clk: mediatek: reset: Add reset support for simple probe/remove
Date:   Mon, 18 Apr 2022 21:21:54 +0800
Message-ID: <20220418132154.7401-8-rex-bc.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220418132154.7401-1-rex-bc.chen@mediatek.com>
References: <20220418132154.7401-1-rex-bc.chen@mediatek.com>
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

- Add a pointer of "mtk_clk_rst_data" to "mtk_clk_desc".
- Add register reset function in mtk_clk_simple_probe().
- Add unregister reset function in mtk_clk_simple_remove().

Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
---
 drivers/clk/mediatek/clk-mtk.c | 6 ++++++
 drivers/clk/mediatek/clk-mtk.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index b4063261cf56..4ecdf0be26d5 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -453,6 +453,9 @@ int mtk_clk_simple_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, clk_data);
 
+	if (mcd->rst && mcd->rst->supported)
+		r = mtk_clk_register_rst_ctrl(node, mcd->rst);
+
 	return r;
 
 unregister_clks:
@@ -468,6 +471,9 @@ int mtk_clk_simple_remove(struct platform_device *pdev)
 	struct clk_onecell_data *clk_data = platform_get_drvdata(pdev);
 	struct device_node *node = pdev->dev.of_node;
 
+	if (mcd->rst && mcd->rst->supported)
+		mtk_clk_unregister_rst_ctrl(mcd->rst);
+
 	of_clk_del_provider(node);
 	mtk_clk_unregister_gates(mcd->clks, mcd->num_clks, clk_data);
 	mtk_free_clk_data(clk_data);
diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index dfb0549ceb6c..453d12cb57ac 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -194,6 +194,7 @@ struct clk *mtk_clk_register_ref2usb_tx(const char *name,
 struct mtk_clk_desc {
 	const struct mtk_gate *clks;
 	size_t num_clks;
+	struct mtk_clk_rst_data *rst;
 };
 
 int mtk_clk_simple_probe(struct platform_device *pdev);
-- 
2.18.0

