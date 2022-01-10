Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA91489E0B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 18:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237958AbiAJRKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 12:10:16 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:53550 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S237936AbiAJRKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 12:10:14 -0500
X-UUID: ffa494a963c2498db3a5bf276c215679-20220111
X-UUID: ffa494a963c2498db3a5bf276c215679-20220111
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2021758607; Tue, 11 Jan 2022 01:10:09 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Tue, 11 Jan 2022 01:10:08 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 11 Jan 2022 01:10:08 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Miles Chen <miles.chen@mediatek.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Chen-Yu Tsai <wenst@chromium.org>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] clk: mediatek: clk-mt8192: drop CLK_OF_DECLARE_DRIVER
Date:   Tue, 11 Jan 2022 01:09:58 +0800
Message-ID: <20220110171000.24316-3-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220110171000.24316-1-miles.chen@mediatek.com>
References: <20220110171000.24316-1-miles.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clk-mt8192.c uses CLK_OF_DECLARE_DRIVER and it does not work for
kernel modules.

To support clk-mt8192 moudle build, move the
clk_mt8192_top_init_early() logic to clk_mt8192_top_probe()
and drop clk_mt8192_top_init_early() and CLK_OF_DECLARE_DRIVER.

Cc: Chun-Jie Chen <chun-jie.chen@mediatek.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>
Signed-off-by: Miles Chen <miles.chen@mediatek.com>
---
 drivers/clk/mediatek/clk-mt8192.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8192.c b/drivers/clk/mediatek/clk-mt8192.c
index cbc7c6dbe0f4..552fae4f0fd5 100644
--- a/drivers/clk/mediatek/clk-mt8192.c
+++ b/drivers/clk/mediatek/clk-mt8192.c
@@ -1179,31 +1179,20 @@ static const struct mtk_pll_data plls[] = {
 
 static struct clk_onecell_data *top_clk_data;
 
-static void clk_mt8192_top_init_early(struct device_node *node)
+static int clk_mt8192_top_probe(struct platform_device *pdev)
 {
+	struct device_node *node = pdev->dev.of_node;
+	int r;
+	void __iomem *base;
 	int i;
 
 	top_clk_data = mtk_alloc_clk_data(CLK_TOP_NR_CLK);
 	if (!top_clk_data)
-		return;
+		return -ENOMEM;
 
 	for (i = 0; i < CLK_TOP_NR_CLK; i++)
 		top_clk_data->clks[i] = ERR_PTR(-EPROBE_DEFER);
 
-	mtk_clk_register_factors(top_early_divs, ARRAY_SIZE(top_early_divs), top_clk_data);
-
-	of_clk_add_provider(node, of_clk_src_onecell_get, top_clk_data);
-}
-
-CLK_OF_DECLARE_DRIVER(mt8192_topckgen, "mediatek,mt8192-topckgen",
-		      clk_mt8192_top_init_early);
-
-static int clk_mt8192_top_probe(struct platform_device *pdev)
-{
-	struct device_node *node = pdev->dev.of_node;
-	int r;
-	void __iomem *base;
-
 	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
-- 
2.18.0

