Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC9935088C6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 15:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378793AbiDTNIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 09:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378768AbiDTNIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 09:08:23 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9206565;
        Wed, 20 Apr 2022 06:05:36 -0700 (PDT)
X-UUID: 60bf66f04d894c8aad5d62b60bd90a51-20220420
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:9284b2f5-242d-4a42-a004-4c587fbf2626,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-20,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:-20
X-CID-META: VersionHash:faefae9,CLOUDID:2ce65cf0-da02-41b4-b6df-58f4ccd36682,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: 60bf66f04d894c8aad5d62b60bd90a51-20220420
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1813227716; Wed, 20 Apr 2022 21:05:30 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 20 Apr 2022 21:05:29 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 20 Apr 2022 21:05:29 +0800
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>
CC:     <matthias.bgg@gmail.com>, <p.zabel@pengutronix.de>,
        <angelogioacchino.delregno@collabora.com>,
        <chun-jie.chen@mediatek.com>, <wenst@chromium.org>,
        <runyang.chen@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <allen-kh.cheng@mediatek.com>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>
Subject: [PATCH V2 05/12] clk: mediatek: reset: Add reset.h
Date:   Wed, 20 Apr 2022 21:05:20 +0800
Message-ID: <20220420130527.23200-6-rex-bc.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220420130527.23200-1-rex-bc.chen@mediatek.com>
References: <20220420130527.23200-1-rex-bc.chen@mediatek.com>
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

Add a new file "reset.h" to place some definitions for clock reset.

Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
---
 drivers/clk/mediatek/clk-mtk.h | 11 ++---------
 drivers/clk/mediatek/reset.h   | 20 ++++++++++++++++++++
 2 files changed, 22 insertions(+), 9 deletions(-)
 create mode 100644 drivers/clk/mediatek/reset.h

diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index 399f1b2dc7d0..a6d0f24c62fa 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -13,6 +13,8 @@
 #include <linux/spinlock.h>
 #include <linux/types.h>
 
+#include "reset.h"
+
 #define MAX_MUX_GATE_BIT	31
 #define INVALID_MUX_GATE_BIT	(MAX_MUX_GATE_BIT + 1)
 
@@ -178,12 +180,6 @@ struct mtk_clk_divider {
 		.div_width = _width,				\
 }
 
-enum mtk_reset_version {
-	MTK_RST_SIMPLE = 0,
-	MTK_RST_SET_CLR,
-	MTK_RST_MAX,
-};
-
 int mtk_clk_register_dividers(const struct mtk_clk_divider *mcds, int num,
 			      void __iomem *base, spinlock_t *lock,
 			      struct clk_onecell_data *clk_data);
@@ -196,9 +192,6 @@ void mtk_free_clk_data(struct clk_onecell_data *clk_data);
 struct clk *mtk_clk_register_ref2usb_tx(const char *name,
 			const char *parent_name, void __iomem *reg);
 
-void mtk_clk_register_rst_ctrl(struct device_node *np,
-			       u32 reg_num, u16 reg_ofs, u8 version);
-
 struct mtk_clk_desc {
 	const struct mtk_gate *clks;
 	size_t num_clks;
diff --git a/drivers/clk/mediatek/reset.h b/drivers/clk/mediatek/reset.h
new file mode 100644
index 000000000000..e4081c7217e3
--- /dev/null
+++ b/drivers/clk/mediatek/reset.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2022 MediaTek Inc.
+ */
+
+#ifndef __DRV_CLK_MTK_RESET_H
+#define __DRV_CLK_MTK_RESET_H
+
+#include <linux/types.h>
+
+enum mtk_reset_version {
+	MTK_RST_SIMPLE = 0,
+	MTK_RST_SET_CLR,
+	MTK_RST_MAX,
+};
+
+void mtk_clk_register_rst_ctrl(struct device_node *np,
+			       u32 reg_num, u16 reg_ofs, u8 version);
+
+#endif /* __DRV_CLK_MTK_RESET_H */
-- 
2.18.0

