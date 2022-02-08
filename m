Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF98E4AD9AE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 14:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346108AbiBHNWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 08:22:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359046AbiBHMly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 07:41:54 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444EEC03FECA
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 04:41:54 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id y9so8505462pjf.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 04:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=su8yB3PhAikF3CbTDZ6t9xjvJ0+tVV3Q7sMK1qov3u8=;
        b=dawlL8uPpwEhEdNzpFhriSJEc1UtRFiXuNLnUzi+5qbBM87ysJgWjelVSEpVjER5Jx
         joGv/TplaF0PTc6D/bNC1/u/UXy0U65BtryhYLyNRH9tBW5x3jFSaV3tmczcjqcWZiQL
         b+ndNi9SCeiJkOOce7Rr7EGiWg81mozts7FXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=su8yB3PhAikF3CbTDZ6t9xjvJ0+tVV3Q7sMK1qov3u8=;
        b=wREW5WFi0qJ+gINNMCr2vXFazpdlWCaU4mzbkDkJoqrPcUoLpps8VhRHBxX0+aYKk0
         p/8T8/v++JmyNzOTmA9q8pvE4IyzMQtYOW4BIKjL9sop4qr6HtXYRuJVhKRWbJneiVtm
         YmjoRhzkhcFSA0JZ61JdYtrFZCmoe+V9GpebLQNHFrHzDXD/JxGJiyOVfUD/HVwhH7SC
         920pn6mQSYO1473MgV+g4H/yZLMc6SNPvjot9x4yUz0j/M4/rXrSieAz/EghJNILe09y
         a+Eu3I1/DktKPigC2WCzkTvRQbhasagiIJ7loB9AsUP5nhDwD81JukN3BNjOS4DFlUFi
         2B4g==
X-Gm-Message-State: AOAM532w2UkhGEcryf6OEZOB4OuXWBT9fcJ4XNkgiJddIjsrmV3e32aP
        a9jwDlEYDNEUnHO089QTjyJdFA==
X-Google-Smtp-Source: ABdhPJzfeIV9hW4JatNPV1xSEsdpC0w96N8R32l6fhq4Zd+WxyYTQiY+H/KMNwMzwxkzPNn53nCdVA==
X-Received: by 2002:a17:902:ecc9:: with SMTP id a9mr4084829plh.121.1644324113776;
        Tue, 08 Feb 2022 04:41:53 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:41b6:813e:c823:609c])
        by smtp.gmail.com with ESMTPSA id h11sm15056939pfe.214.2022.02.08.04.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 04:41:53 -0800 (PST)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Miles Chen <miles.chen@mediatek.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 30/31] clk: mediatek: mt8195: Implement remove functions
Date:   Tue,  8 Feb 2022 20:40:33 +0800
Message-Id: <20220208124034.414635-31-wenst@chromium.org>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
In-Reply-To: <20220208124034.414635-1-wenst@chromium.org>
References: <20220208124034.414635-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Until now the mediatek clk driver library did not have any way to
unregister clks, and so none of the drivers implemented remove
functions.

Now that the library does have APIs to unregister clks, use them
to implement remove functions for the mt8195 clk drivers.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: Miles Chen <miles.chen@mediatek.com>
---
 drivers/clk/mediatek/clk-mt8195-apmixedsys.c | 16 ++++++++++++++++
 drivers/clk/mediatek/clk-mt8195-apusys_pll.c | 15 +++++++++++++++
 drivers/clk/mediatek/clk-mt8195-topckgen.c   | 20 ++++++++++++++++++++
 drivers/clk/mediatek/clk-mt8195-vdo0.c       | 16 ++++++++++++++++
 drivers/clk/mediatek/clk-mt8195-vdo1.c       | 16 ++++++++++++++++
 5 files changed, 83 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mt8195-apmixedsys.c b/drivers/clk/mediatek/clk-mt8195-apmixedsys.c
index d0fdb5a4a921..eecc7035a56a 100644
--- a/drivers/clk/mediatek/clk-mt8195-apmixedsys.c
+++ b/drivers/clk/mediatek/clk-mt8195-apmixedsys.c
@@ -132,6 +132,8 @@ static int clk_mt8195_apmixed_probe(struct platform_device *pdev)
 	if (r)
 		goto unregister_gates;
 
+	platform_set_drvdata(pdev, clk_data);
+
 	return r;
 
 unregister_gates:
@@ -143,8 +145,22 @@ static int clk_mt8195_apmixed_probe(struct platform_device *pdev)
 	return r;
 }
 
+static int clk_mt8195_apmixed_remove(struct platform_device *pdev)
+{
+	struct device_node *node = pdev->dev.of_node;
+	struct clk_onecell_data *clk_data = platform_get_drvdata(pdev);
+
+	of_clk_del_provider(node);
+	mtk_clk_unregister_gates(apmixed_clks, ARRAY_SIZE(apmixed_clks), clk_data);
+	mtk_clk_unregister_plls(plls, ARRAY_SIZE(plls), clk_data);
+	mtk_free_clk_data(clk_data);
+
+	return 0;
+}
+
 static struct platform_driver clk_mt8195_apmixed_drv = {
 	.probe = clk_mt8195_apmixed_probe,
+	.remove = clk_mt8195_apmixed_remove,
 	.driver = {
 		.name = "clk-mt8195-apmixed",
 		.of_match_table = of_match_clk_mt8195_apmixed,
diff --git a/drivers/clk/mediatek/clk-mt8195-apusys_pll.c b/drivers/clk/mediatek/clk-mt8195-apusys_pll.c
index f489b57e325e..8cd88dfc3283 100644
--- a/drivers/clk/mediatek/clk-mt8195-apusys_pll.c
+++ b/drivers/clk/mediatek/clk-mt8195-apusys_pll.c
@@ -74,6 +74,8 @@ static int clk_mt8195_apusys_pll_probe(struct platform_device *pdev)
 	if (r)
 		goto unregister_plls;
 
+	platform_set_drvdata(pdev, clk_data);
+
 	return r;
 
 unregister_plls:
@@ -83,6 +85,18 @@ static int clk_mt8195_apusys_pll_probe(struct platform_device *pdev)
 	return r;
 }
 
+static int clk_mt8195_apusys_pll_remove(struct platform_device *pdev)
+{
+	struct clk_onecell_data *clk_data = platform_get_drvdata(pdev);
+	struct device_node *node = pdev->dev.of_node;
+
+	of_clk_del_provider(node);
+	mtk_clk_unregister_plls(apusys_plls, ARRAY_SIZE(apusys_plls), clk_data);
+	mtk_free_clk_data(clk_data);
+
+	return 0;
+}
+
 static const struct of_device_id of_match_clk_mt8195_apusys_pll[] = {
 	{ .compatible = "mediatek,mt8195-apusys_pll", },
 	{}
@@ -90,6 +104,7 @@ static const struct of_device_id of_match_clk_mt8195_apusys_pll[] = {
 
 static struct platform_driver clk_mt8195_apusys_pll_drv = {
 	.probe = clk_mt8195_apusys_pll_probe,
+	.remove = clk_mt8195_apusys_pll_remove,
 	.driver = {
 		.name = "clk-mt8195-apusys_pll",
 		.of_match_table = of_match_clk_mt8195_apusys_pll,
diff --git a/drivers/clk/mediatek/clk-mt8195-topckgen.c b/drivers/clk/mediatek/clk-mt8195-topckgen.c
index 3631f49a5e5a..b602fcd7f1d1 100644
--- a/drivers/clk/mediatek/clk-mt8195-topckgen.c
+++ b/drivers/clk/mediatek/clk-mt8195-topckgen.c
@@ -1271,6 +1271,8 @@ static int clk_mt8195_topck_probe(struct platform_device *pdev)
 	if (r)
 		goto unregister_gates;
 
+	platform_set_drvdata(pdev, top_clk_data);
+
 	return r;
 
 unregister_gates:
@@ -1290,8 +1292,26 @@ static int clk_mt8195_topck_probe(struct platform_device *pdev)
 	return r;
 }
 
+static int clk_mt8195_topck_remove(struct platform_device *pdev)
+{
+	struct clk_onecell_data *top_clk_data = platform_get_drvdata(pdev);
+	struct device_node *node = pdev->dev.of_node;
+
+	of_clk_del_provider(node);
+	mtk_clk_unregister_gates(top_clks, ARRAY_SIZE(top_clks), top_clk_data);
+	mtk_clk_unregister_composites(top_adj_divs, ARRAY_SIZE(top_adj_divs), top_clk_data);
+	mtk_clk_unregister_composites(top_muxes, ARRAY_SIZE(top_muxes), top_clk_data);
+	mtk_clk_unregister_muxes(top_mtk_muxes, ARRAY_SIZE(top_mtk_muxes), top_clk_data);
+	mtk_clk_unregister_factors(top_divs, ARRAY_SIZE(top_divs), top_clk_data);
+	mtk_clk_unregister_fixed_clks(top_fixed_clks, ARRAY_SIZE(top_fixed_clks), top_clk_data);
+	mtk_free_clk_data(top_clk_data);
+
+	return 0;
+}
+
 static struct platform_driver clk_mt8195_topck_drv = {
 	.probe = clk_mt8195_topck_probe,
+	.remove = clk_mt8195_topck_remove,
 	.driver = {
 		.name = "clk-mt8195-topck",
 		.of_match_table = of_match_clk_mt8195_topck,
diff --git a/drivers/clk/mediatek/clk-mt8195-vdo0.c b/drivers/clk/mediatek/clk-mt8195-vdo0.c
index af34eb564b1d..3bc7ed19d550 100644
--- a/drivers/clk/mediatek/clk-mt8195-vdo0.c
+++ b/drivers/clk/mediatek/clk-mt8195-vdo0.c
@@ -107,6 +107,8 @@ static int clk_mt8195_vdo0_probe(struct platform_device *pdev)
 	if (r)
 		goto unregister_gates;
 
+	platform_set_drvdata(pdev, clk_data);
+
 	return r;
 
 unregister_gates:
@@ -116,8 +118,22 @@ static int clk_mt8195_vdo0_probe(struct platform_device *pdev)
 	return r;
 }
 
+static int clk_mt8195_vdo0_remove(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *node = dev->parent->of_node;
+	struct clk_onecell_data *clk_data = platform_get_drvdata(pdev);
+
+	of_clk_del_provider(node);
+	mtk_clk_unregister_gates(vdo0_clks, ARRAY_SIZE(vdo0_clks), clk_data);
+	mtk_free_clk_data(clk_data);
+
+	return 0;
+}
+
 static struct platform_driver clk_mt8195_vdo0_drv = {
 	.probe = clk_mt8195_vdo0_probe,
+	.remove = clk_mt8195_vdo0_remove,
 	.driver = {
 		.name = "clk-mt8195-vdo0",
 	},
diff --git a/drivers/clk/mediatek/clk-mt8195-vdo1.c b/drivers/clk/mediatek/clk-mt8195-vdo1.c
index 6b502bbc730c..90c738a85ff1 100644
--- a/drivers/clk/mediatek/clk-mt8195-vdo1.c
+++ b/drivers/clk/mediatek/clk-mt8195-vdo1.c
@@ -124,6 +124,8 @@ static int clk_mt8195_vdo1_probe(struct platform_device *pdev)
 	if (r)
 		goto unregister_gates;
 
+	platform_set_drvdata(pdev, clk_data);
+
 	return r;
 
 unregister_gates:
@@ -133,8 +135,22 @@ static int clk_mt8195_vdo1_probe(struct platform_device *pdev)
 	return r;
 }
 
+static int clk_mt8195_vdo1_remove(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *node = dev->parent->of_node;
+	struct clk_onecell_data *clk_data = platform_get_drvdata(pdev);
+
+	of_clk_del_provider(node);
+	mtk_clk_unregister_gates(vdo1_clks, ARRAY_SIZE(vdo1_clks), clk_data);
+	mtk_free_clk_data(clk_data);
+
+	return 0;
+}
+
 static struct platform_driver clk_mt8195_vdo1_drv = {
 	.probe = clk_mt8195_vdo1_probe,
+	.remove = clk_mt8195_vdo1_remove,
 	.driver = {
 		.name = "clk-mt8195-vdo1",
 	},
-- 
2.35.0.263.gb82422642f-goog

