Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E370A490483
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 10:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233508AbiAQJAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 04:00:35 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:59142 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229484AbiAQJAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 04:00:34 -0500
X-UUID: ec0394411d204e49978411e812a1d059-20220117
X-UUID: ec0394411d204e49978411e812a1d059-20220117
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1176267212; Mon, 17 Jan 2022 17:00:32 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 17 Jan 2022 17:00:30 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 17 Jan 2022 17:00:30 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ikjoon Jang <ikjn@chromium.org>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>
CC:     Miles Chen <miles.chen@mediatek.com>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] clk: mediatek: add unregister logic to mtk_clk_simple_probe error path
Date:   Mon, 17 Jan 2022 17:00:29 +0800
Message-ID: <20220117090030.13064-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen pointed out that there is no unregister logic in
mtk_clk_simple_probe() error path [1].
Fix it by adding unregister logic to mtk_clk_simple_probe().

[1] https://lore.kernel.org/linux-mediatek/20220114221930.660B5C36AE9@smtp.kernel.org/

Fixes: c58cd0e40ffa ("clk: mediatek: Add mtk_clk_simple_probe() to simplify clock providers")
Cc: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Miles Chen <miles.chen@mediatek.com>
---
 drivers/clk/mediatek/clk-mtk.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index 8d5791b3f460..edf21975cb4d 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -161,6 +161,22 @@ int mtk_clk_register_gates(struct device_node *node,
 }
 EXPORT_SYMBOL_GPL(mtk_clk_register_gates);
 
+static void mtk_clk_unregister_gates(const struct mtk_gate *clks,
+		int num, struct clk_onecell_data *clk_data)
+{
+	int i;
+	const struct mtk_gate *gate;
+	struct clk *clk;
+
+	for (i = 0; i < num; i++) {
+		gate = &clks[i];
+		clk = clk_data->clks[gate->id];
+
+		if (!IS_ERR_OR_NULL(clk))
+			clk_unregister(clk);
+	}
+}
+
 struct clk *mtk_clk_register_composite(const struct mtk_composite *mc,
 		void __iomem *base, spinlock_t *lock)
 {
@@ -320,15 +336,17 @@ int mtk_clk_simple_probe(struct platform_device *pdev)
 
 	r = mtk_clk_register_gates(node, mcd->clks, mcd->num_clks, clk_data);
 	if (r)
-		goto free_data;
+		goto err_free_data;
 
 	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
 	if (r)
-		goto free_data;
+		goto err_unregister_gates;
 
 	return r;
 
-free_data:
+err_unregister_gates:
+	mtk_clk_unregister_gates(mcd->clks, mcd->num_clks, clk_data);
+err_free_data:
 	mtk_free_clk_data(clk_data);
 	return r;
 }
-- 
2.18.0

