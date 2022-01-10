Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96BEF488D9F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 01:59:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237685AbiAJA7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 19:59:36 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:51876 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S237650AbiAJA72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 19:59:28 -0500
X-UUID: a63949c2b4814797b6094fb056298afb-20220110
X-UUID: a63949c2b4814797b6094fb056298afb-20220110
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <chun-jie.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 118521613; Mon, 10 Jan 2022 08:59:22 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Mon, 10 Jan 2022 08:59:21 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 10 Jan 2022 08:59:21 +0800
From:   Chun-Jie Chen <chun-jie.chen@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>
Subject: [v2 1/3] clk: mediatek: Add error handle when fail to register clock provider
Date:   Mon, 10 Jan 2022 08:59:00 +0800
Message-ID: <20220110005902.27148-2-chun-jie.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220110005902.27148-1-chun-jie.chen@mediatek.com>
References: <20220110005902.27148-1-chun-jie.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Need to deference registered clocks when fail to
regisiter clock provider.

Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
---
 drivers/clk/mediatek/clk-mt8195-apmixedsys.c |  5 ++++-
 drivers/clk/mediatek/clk-mt8195-apusys_pll.c |  5 +++--
 drivers/clk/mediatek/clk-mt8195-topckgen.c   |  5 ++++-
 drivers/clk/mediatek/clk-mt8195-vdo0.c       |  5 ++++-
 drivers/clk/mediatek/clk-mt8195-vdo1.c       |  5 ++++-
 drivers/clk/mediatek/clk-mtk.c               | 14 +++++++++++++-
 drivers/clk/mediatek/clk-mtk.h               |  1 +
 7 files changed, 33 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8195-apmixedsys.c b/drivers/clk/mediatek/clk-mt8195-apmixedsys.c
index 6156ceeed71e..be0a716e24d2 100644
--- a/drivers/clk/mediatek/clk-mt8195-apmixedsys.c
+++ b/drivers/clk/mediatek/clk-mt8195-apmixedsys.c
@@ -126,10 +126,13 @@ static int clk_mt8195_apmixed_probe(struct platform_device *pdev)
 
 	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
 	if (r)
-		goto free_apmixed_data;
+		goto unregister_clk;
 
 	return r;
 
+unregister_clk:
+	mtk_clk_unregister(clk_data);
+
 free_apmixed_data:
 	mtk_free_clk_data(clk_data);
 	return r;
diff --git a/drivers/clk/mediatek/clk-mt8195-apusys_pll.c b/drivers/clk/mediatek/clk-mt8195-apusys_pll.c
index f1c84186346e..bc5fc84e48dd 100644
--- a/drivers/clk/mediatek/clk-mt8195-apusys_pll.c
+++ b/drivers/clk/mediatek/clk-mt8195-apusys_pll.c
@@ -68,11 +68,12 @@ static int clk_mt8195_apusys_pll_probe(struct platform_device *pdev)
 	mtk_clk_register_plls(node, apusys_plls, ARRAY_SIZE(apusys_plls), clk_data);
 	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
 	if (r)
-		goto free_apusys_pll_data;
+		goto unregister_clk;
 
 	return r;
 
-free_apusys_pll_data:
+unregister_clk:
+	mtk_clk_unregister(clk_data);
 	mtk_free_clk_data(clk_data);
 	return r;
 }
diff --git a/drivers/clk/mediatek/clk-mt8195-topckgen.c b/drivers/clk/mediatek/clk-mt8195-topckgen.c
index 3e2aba9c40bb..02a1801dfe86 100644
--- a/drivers/clk/mediatek/clk-mt8195-topckgen.c
+++ b/drivers/clk/mediatek/clk-mt8195-topckgen.c
@@ -1254,10 +1254,13 @@ static int clk_mt8195_topck_probe(struct platform_device *pdev)
 
 	r = of_clk_add_provider(node, of_clk_src_onecell_get, top_clk_data);
 	if (r)
-		goto free_top_data;
+		goto unregister_clk;
 
 	return r;
 
+unregister_clk:
+	mtk_clk_unregister(top_clk_data);
+
 free_top_data:
 	mtk_free_clk_data(top_clk_data);
 	return r;
diff --git a/drivers/clk/mediatek/clk-mt8195-vdo0.c b/drivers/clk/mediatek/clk-mt8195-vdo0.c
index f7ff7618c714..b7ceb6c7a33f 100644
--- a/drivers/clk/mediatek/clk-mt8195-vdo0.c
+++ b/drivers/clk/mediatek/clk-mt8195-vdo0.c
@@ -105,10 +105,13 @@ static int clk_mt8195_vdo0_probe(struct platform_device *pdev)
 
 	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
 	if (r)
-		goto free_vdo0_data;
+		goto unregister_clk;
 
 	return r;
 
+unregister_clk:
+	mtk_clk_unregister(clk_data);
+
 free_vdo0_data:
 	mtk_free_clk_data(clk_data);
 	return r;
diff --git a/drivers/clk/mediatek/clk-mt8195-vdo1.c b/drivers/clk/mediatek/clk-mt8195-vdo1.c
index 03df8eae8838..cca90c2632a1 100644
--- a/drivers/clk/mediatek/clk-mt8195-vdo1.c
+++ b/drivers/clk/mediatek/clk-mt8195-vdo1.c
@@ -122,10 +122,13 @@ static int clk_mt8195_vdo1_probe(struct platform_device *pdev)
 
 	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
 	if (r)
-		goto free_vdo1_data;
+		goto unregister_clk;
 
 	return r;
 
+unregister_clk:
+	mtk_clk_unregister(clk_data);
+
 free_vdo1_data:
 	mtk_free_clk_data(clk_data);
 	return r;
diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index 8d5791b3f460..ee4de1094458 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -303,6 +303,15 @@ void mtk_clk_register_dividers(const struct mtk_clk_divider *mcds,
 	}
 }
 
+void mtk_clk_unregister(struct clk_onecell_data *clk_data)
+{
+	int i;
+
+	for (i = 0; i < clk_data->clk_num; i++)
+		clk_unregister(clk_data->clks[i]);
+}
+EXPORT_SYMBOL_GPL(mtk_clk_unregister);
+
 int mtk_clk_simple_probe(struct platform_device *pdev)
 {
 	const struct mtk_clk_desc *mcd;
@@ -324,10 +333,13 @@ int mtk_clk_simple_probe(struct platform_device *pdev)
 
 	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
 	if (r)
-		goto free_data;
+		goto unregister_clk;
 
 	return r;
 
+unregister_clk:
+	mtk_clk_unregister(clk_data);
+
 free_data:
 	mtk_free_clk_data(clk_data);
 	return r;
diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index 0ff289d93452..4c0958f66f51 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -200,6 +200,7 @@ struct mtk_clk_divider {
 void mtk_clk_register_dividers(const struct mtk_clk_divider *mcds,
 			int num, void __iomem *base, spinlock_t *lock,
 				struct clk_onecell_data *clk_data);
+void mtk_clk_unregister(struct clk_onecell_data *clk_data);
 
 struct clk_onecell_data *mtk_alloc_clk_data(unsigned int clk_num);
 void mtk_free_clk_data(struct clk_onecell_data *clk_data);
-- 
2.18.0

