Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7A4505A08
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 16:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344915AbiDRObW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 10:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344457AbiDRO12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 10:27:28 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D56F52E6F;
        Mon, 18 Apr 2022 06:22:30 -0700 (PDT)
X-UUID: cfa7f1ef9b9a4032a7df3caa0e7916f8-20220418
X-UUID: cfa7f1ef9b9a4032a7df3caa0e7916f8-20220418
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2105984630; Mon, 18 Apr 2022 21:22:26 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 18 Apr 2022 21:22:25 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 18 Apr
 2022 21:22:24 +0800
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
Subject: [PATCH 6/7] clk: mediatek: reset: Add support for unregister reset controller
Date:   Mon, 18 Apr 2022 21:21:53 +0800
Message-ID: <20220418132154.7401-7-rex-bc.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220418132154.7401-1-rex-bc.chen@mediatek.com>
References: <20220418132154.7401-1-rex-bc.chen@mediatek.com>
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

Add a function to unregister reset controller.

Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
---
 drivers/clk/mediatek/reset.c | 10 ++++++++++
 drivers/clk/mediatek/reset.h |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/drivers/clk/mediatek/reset.c b/drivers/clk/mediatek/reset.c
index 709ae54efc18..19f7ac0f8145 100644
--- a/drivers/clk/mediatek/reset.c
+++ b/drivers/clk/mediatek/reset.c
@@ -138,4 +138,14 @@ int mtk_clk_register_rst_ctrl(struct device_node *np,
 	return 0;
 }
 
+int mtk_clk_unregister_rst_ctrl(struct mtk_clk_rst_data *clk_rst)
+{
+	if (!clk_rst)
+		return -EINVAL;
+
+	reset_controller_unregister(&clk_rst->rcdev);
+
+	return 0;
+}
+
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/reset.h b/drivers/clk/mediatek/reset.h
index 851a29c92440..86a785630bb6 100644
--- a/drivers/clk/mediatek/reset.h
+++ b/drivers/clk/mediatek/reset.h
@@ -27,4 +27,6 @@ struct mtk_clk_rst_data {
 int mtk_clk_register_rst_ctrl(struct device_node *np,
 			      struct mtk_clk_rst_data *clk_rst);
 
+int mtk_clk_unregister_rst_ctrl(struct mtk_clk_rst_data *clk_rst);
+
 #endif /* __DRV_CLK_MTK_RESET_H */
-- 
2.18.0

