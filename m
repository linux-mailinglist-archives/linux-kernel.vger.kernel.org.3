Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9D25212A4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 12:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240202AbiEJKxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 06:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240094AbiEJKwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 06:52:35 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E7528F1F2
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 03:48:24 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id x52so14606078pfu.11
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 03:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+5XKEvxIH5Rf6dpekQJyA0xx06Xy2uoIhx3MBRmX5uk=;
        b=SAc6vA/8o/53fkwzOW4l4tdnnHfitFCuGChirxWnhZSf07el4jWu8w8uHB2/CoPVIF
         paRot2mZa3Vwk3r86tlcgYEoP7NbyLsZ1ZZKDCtcbhwnAdhXoGLYC0EyS25bk/WTSpgW
         mtxRFb2gkcgY1nCQbv15F43VthKlFcNWWBObo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+5XKEvxIH5Rf6dpekQJyA0xx06Xy2uoIhx3MBRmX5uk=;
        b=Vl2vpVHyybo2NjvouptnfMl8Qa9jMlQmDUPaL/wKZAte8IwNyReULHtL5/4Tt7FYhD
         +SVNtcTjbaZks3Hxob2KlTdgT7BPsGUHdJIANugvKQisOTSMLupY7eJr5wwdQRkk7/p3
         O4oUS+W0Hc7EeXgp+Qmv8zSTi9s8VqFJP0ha7ZjNmSz6rfuHtU0X8aC29baOkdQLQqcv
         XEToibfJ/2xdDWXM+1UFych7bOSZGsozFGD23ktaMZyH0Ayf1fDa7pE7hgxGFyivycFB
         PwrKdKUDBScsMzf50qqoT1xxNghm1FxiV2XOZFJ0N8jsQv1ZsBqMKiJBHhZcorBsYa49
         iO4Q==
X-Gm-Message-State: AOAM5303QDKig/eESGnsQZrxY2uWgsFRBoQuNqh6nz4GlQp8bnNNZf5Q
        /EiiGHNFK1v88ngn/4rM+zyN8RCcnaoxRA==
X-Google-Smtp-Source: ABdhPJzvuDmu3YmJBOyrSsHbr0NlUgD1e8EPf/JapZhacUWHrQbo2XdnIB9iih+Vo2vwuQgCvporTA==
X-Received: by 2002:aa7:8892:0:b0:50e:1463:3cd1 with SMTP id z18-20020aa78892000000b0050e14633cd1mr19504513pfe.13.1652179703766;
        Tue, 10 May 2022 03:48:23 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:6dcd:8578:55cf:2b12])
        by smtp.gmail.com with ESMTPSA id q9-20020a170902e30900b0015e8d4eb21esm1659691plc.104.2022.05.10.03.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 03:48:23 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-clk@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/11] clk: mediatek: mt27xx: Replace 'struct clk' with 'struct clk_hw'
Date:   Tue, 10 May 2022 18:47:58 +0800
Message-Id: <20220510104804.544597-6-wenst@chromium.org>
X-Mailer: git-send-email 2.36.0.512.ge40c2bad7a-goog
In-Reply-To: <20220510104804.544597-1-wenst@chromium.org>
References: <20220510104804.544597-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As part of the effort to improve the MediaTek clk drivers, the next step
is to switch from the old 'struct clk' clk prodivder APIs to the new
'struct clk_hw' ones.

Instead of adding new APIs to the MediaTek clk driver library mirroring
the existing ones, moving all drivers to the new APIs, and then removing
the old ones, just migrate everything at the same time. This involves
replacing 'struct clk' with 'struct clk_hw', and 'struct clk_onecell_data'
with 'struct clk_hw_onecell_data', and fixing up all usages.

This is done with the following coccinelle script.

To avoid a really large patch, the changes have been split into multiple
ones. This patch covers MT27xx.

    // Replace type
    @@
    @@
    - struct clk_onecell_data
    + struct clk_hw_onecell_data

    // Replace of_clk_add_provider() & of_clk_src_simple_get()
    @@
    expression NP, DATA;
    symbol of_clk_src_onecell_get;
    @@
    - of_clk_add_provider(
    + of_clk_add_hw_provider(
	    NP,
    -	of_clk_src_onecell_get,
    +	of_clk_hw_onecell_get,
	    DATA
      )

    // Fix register/unregister
    @@
    identifier CD;
    expression E;
    identifier fn =~ "unregister";
    @@
      fn(...,
    -    CD->clks[E]
    +    CD->hws[E]->clk
	 ,...
	);

    // Fix calls to clk_prepare_enable()
    @@
    identifier CD;
    expression E;
    @@
      clk_prepare_enable(
    - 		     CD->clks[E]
    + 		     CD->hws[E]->clk
      );

    // Fix pointer assignment
    @@
    identifier CD;
    identifier CLK;
    expression E;
    @@
    - CD->clks[E]
    + CD->hws[E]
      =
    (
    - CLK
    + __clk_get_hw(CLK)
    |
      ERR_PTR(...)
    )
      ;

    // Fix pointer usage
    @@
    identifier CD;
    expression E;
    @@
    - CD->clks[E]
    + CD->hws[E]

    // Fix mtk_clk_pll_get_base()
    @@
    symbol clk, hw, data;
    @@
      mtk_clk_pll_get_base(
    - 		       struct clk *clk,
    + 		       struct clk_hw *hw,
			   const struct mtk_pll_data *data
      ) {
    - struct clk_hw *hw = __clk_get_hw(clk);
      ...
      }

    // Fix mtk_clk_pll_get_base() usage
    @@
    identifier CD;
    expression E;
    @@
      mtk_clk_pll_get_base(
    -    CD->clks[E]
    +    CD->hws[E]->clk
	 ,...
      );

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/clk/mediatek/clk-mt2701-aud.c    |  4 ++--
 drivers/clk/mediatek/clk-mt2701-bdp.c    |  4 ++--
 drivers/clk/mediatek/clk-mt2701-eth.c    |  4 ++--
 drivers/clk/mediatek/clk-mt2701-g3d.c    |  4 ++--
 drivers/clk/mediatek/clk-mt2701-hif.c    |  4 ++--
 drivers/clk/mediatek/clk-mt2701-img.c    |  4 ++--
 drivers/clk/mediatek/clk-mt2701-mm.c     |  4 ++--
 drivers/clk/mediatek/clk-mt2701-vdec.c   |  4 ++--
 drivers/clk/mediatek/clk-mt2701.c        | 26 ++++++++++++----------
 drivers/clk/mediatek/clk-mt2712-bdp.c    |  4 ++--
 drivers/clk/mediatek/clk-mt2712-img.c    |  4 ++--
 drivers/clk/mediatek/clk-mt2712-jpgdec.c |  4 ++--
 drivers/clk/mediatek/clk-mt2712-mfg.c    |  4 ++--
 drivers/clk/mediatek/clk-mt2712-mm.c     |  4 ++--
 drivers/clk/mediatek/clk-mt2712-vdec.c   |  4 ++--
 drivers/clk/mediatek/clk-mt2712-venc.c   |  4 ++--
 drivers/clk/mediatek/clk-mt2712.c        | 28 ++++++++++++------------
 17 files changed, 58 insertions(+), 56 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt2701-aud.c b/drivers/clk/mediatek/clk-mt2701-aud.c
index e66896a44fad..6ba398eb7df9 100644
--- a/drivers/clk/mediatek/clk-mt2701-aud.c
+++ b/drivers/clk/mediatek/clk-mt2701-aud.c
@@ -145,7 +145,7 @@ static const struct of_device_id of_match_clk_mt2701_aud[] = {
 
 static int clk_mt2701_aud_probe(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	struct device_node *node = pdev->dev.of_node;
 	int r;
 
@@ -154,7 +154,7 @@ static int clk_mt2701_aud_probe(struct platform_device *pdev)
 	mtk_clk_register_gates(node, audio_clks, ARRAY_SIZE(audio_clks),
 			       clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r) {
 		dev_err(&pdev->dev,
 			"could not register clock provider: %s: %d\n",
diff --git a/drivers/clk/mediatek/clk-mt2701-bdp.c b/drivers/clk/mediatek/clk-mt2701-bdp.c
index ffa09cfbfd51..662a8ab3fbb1 100644
--- a/drivers/clk/mediatek/clk-mt2701-bdp.c
+++ b/drivers/clk/mediatek/clk-mt2701-bdp.c
@@ -101,7 +101,7 @@ static const struct of_device_id of_match_clk_mt2701_bdp[] = {
 
 static int clk_mt2701_bdp_probe(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	int r;
 	struct device_node *node = pdev->dev.of_node;
 
@@ -110,7 +110,7 @@ static int clk_mt2701_bdp_probe(struct platform_device *pdev)
 	mtk_clk_register_gates(node, bdp_clks, ARRAY_SIZE(bdp_clks),
 						clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
 		dev_err(&pdev->dev,
 			"could not register clock provider: %s: %d\n",
diff --git a/drivers/clk/mediatek/clk-mt2701-eth.c b/drivers/clk/mediatek/clk-mt2701-eth.c
index 100ff6ca609e..47c2289f3d1d 100644
--- a/drivers/clk/mediatek/clk-mt2701-eth.c
+++ b/drivers/clk/mediatek/clk-mt2701-eth.c
@@ -43,7 +43,7 @@ static const struct of_device_id of_match_clk_mt2701_eth[] = {
 
 static int clk_mt2701_eth_probe(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	int r;
 	struct device_node *node = pdev->dev.of_node;
 
@@ -52,7 +52,7 @@ static int clk_mt2701_eth_probe(struct platform_device *pdev)
 	mtk_clk_register_gates(node, eth_clks, ARRAY_SIZE(eth_clks),
 						clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
 		dev_err(&pdev->dev,
 			"could not register clock provider: %s: %d\n",
diff --git a/drivers/clk/mediatek/clk-mt2701-g3d.c b/drivers/clk/mediatek/clk-mt2701-g3d.c
index 1328c112a38f..79929ed37f83 100644
--- a/drivers/clk/mediatek/clk-mt2701-g3d.c
+++ b/drivers/clk/mediatek/clk-mt2701-g3d.c
@@ -37,7 +37,7 @@ static const struct mtk_gate g3d_clks[] = {
 
 static int clk_mt2701_g3dsys_init(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	struct device_node *node = pdev->dev.of_node;
 	int r;
 
@@ -46,7 +46,7 @@ static int clk_mt2701_g3dsys_init(struct platform_device *pdev)
 	mtk_clk_register_gates(node, g3d_clks, ARRAY_SIZE(g3d_clks),
 			       clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
 		dev_err(&pdev->dev,
 			"could not register clock provider: %s: %d\n",
diff --git a/drivers/clk/mediatek/clk-mt2701-hif.c b/drivers/clk/mediatek/clk-mt2701-hif.c
index 61444881c539..1aa36cb93ad0 100644
--- a/drivers/clk/mediatek/clk-mt2701-hif.c
+++ b/drivers/clk/mediatek/clk-mt2701-hif.c
@@ -40,7 +40,7 @@ static const struct of_device_id of_match_clk_mt2701_hif[] = {
 
 static int clk_mt2701_hif_probe(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	int r;
 	struct device_node *node = pdev->dev.of_node;
 
@@ -49,7 +49,7 @@ static int clk_mt2701_hif_probe(struct platform_device *pdev)
 	mtk_clk_register_gates(node, hif_clks, ARRAY_SIZE(hif_clks),
 						clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r) {
 		dev_err(&pdev->dev,
 			"could not register clock provider: %s: %d\n",
diff --git a/drivers/clk/mediatek/clk-mt2701-img.c b/drivers/clk/mediatek/clk-mt2701-img.c
index 631e80f0fc7d..c4f3cd26df60 100644
--- a/drivers/clk/mediatek/clk-mt2701-img.c
+++ b/drivers/clk/mediatek/clk-mt2701-img.c
@@ -43,7 +43,7 @@ static const struct of_device_id of_match_clk_mt2701_img[] = {
 
 static int clk_mt2701_img_probe(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	int r;
 	struct device_node *node = pdev->dev.of_node;
 
@@ -52,7 +52,7 @@ static int clk_mt2701_img_probe(struct platform_device *pdev)
 	mtk_clk_register_gates(node, img_clks, ARRAY_SIZE(img_clks),
 						clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
 		dev_err(&pdev->dev,
 			"could not register clock provider: %s: %d\n",
diff --git a/drivers/clk/mediatek/clk-mt2701-mm.c b/drivers/clk/mediatek/clk-mt2701-mm.c
index cb18e1849492..9ea7abad99d2 100644
--- a/drivers/clk/mediatek/clk-mt2701-mm.c
+++ b/drivers/clk/mediatek/clk-mt2701-mm.c
@@ -83,7 +83,7 @@ static int clk_mt2701_mm_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *node = dev->parent->of_node;
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	int r;
 
 	clk_data = mtk_alloc_clk_data(CLK_MM_NR);
@@ -91,7 +91,7 @@ static int clk_mt2701_mm_probe(struct platform_device *pdev)
 	mtk_clk_register_gates(node, mm_clks, ARRAY_SIZE(mm_clks),
 						clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
 		dev_err(&pdev->dev,
 			"could not register clock provider: %s: %d\n",
diff --git a/drivers/clk/mediatek/clk-mt2701-vdec.c b/drivers/clk/mediatek/clk-mt2701-vdec.c
index c9def728ad1e..a2f18117f27a 100644
--- a/drivers/clk/mediatek/clk-mt2701-vdec.c
+++ b/drivers/clk/mediatek/clk-mt2701-vdec.c
@@ -54,7 +54,7 @@ static const struct of_device_id of_match_clk_mt2701_vdec[] = {
 
 static int clk_mt2701_vdec_probe(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	int r;
 	struct device_node *node = pdev->dev.of_node;
 
@@ -63,7 +63,7 @@ static int clk_mt2701_vdec_probe(struct platform_device *pdev)
 	mtk_clk_register_gates(node, vdec_clks, ARRAY_SIZE(vdec_clks),
 						clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
 		dev_err(&pdev->dev,
 			"could not register clock provider: %s: %d\n",
diff --git a/drivers/clk/mediatek/clk-mt2701.c b/drivers/clk/mediatek/clk-mt2701.c
index 1eb3e4563c3f..7a4331057adc 100644
--- a/drivers/clk/mediatek/clk-mt2701.c
+++ b/drivers/clk/mediatek/clk-mt2701.c
@@ -666,7 +666,7 @@ static const struct mtk_gate top_clks[] = {
 
 static int mtk_topckgen_init(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	void __iomem *base;
 	struct device_node *node = pdev->dev.of_node;
 	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -692,7 +692,7 @@ static int mtk_topckgen_init(struct platform_device *pdev)
 	mtk_clk_register_gates(node, top_clks, ARRAY_SIZE(top_clks),
 						clk_data);
 
-	return of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 }
 
 static const struct mtk_gate_regs infra_cg_regs = {
@@ -735,7 +735,7 @@ static const struct mtk_fixed_factor infra_fixed_divs[] = {
 	FACTOR(CLK_INFRA_CLK_13M, "clk13m", "clk26m", 1, 2),
 };
 
-static struct clk_onecell_data *infra_clk_data;
+static struct clk_hw_onecell_data *infra_clk_data;
 
 static void __init mtk_infrasys_init_early(struct device_node *node)
 {
@@ -745,7 +745,7 @@ static void __init mtk_infrasys_init_early(struct device_node *node)
 		infra_clk_data = mtk_alloc_clk_data(CLK_INFRA_NR);
 
 		for (i = 0; i < CLK_INFRA_NR; i++)
-			infra_clk_data->clks[i] = ERR_PTR(-EPROBE_DEFER);
+			infra_clk_data->hws[i] = ERR_PTR(-EPROBE_DEFER);
 	}
 
 	mtk_clk_register_factors(infra_fixed_divs, ARRAY_SIZE(infra_fixed_divs),
@@ -754,7 +754,8 @@ static void __init mtk_infrasys_init_early(struct device_node *node)
 	mtk_clk_register_cpumuxes(node, cpu_muxes, ARRAY_SIZE(cpu_muxes),
 				  infra_clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, infra_clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get,
+				   infra_clk_data);
 	if (r)
 		pr_err("%s(): could not register clock provider: %d\n",
 			__func__, r);
@@ -771,8 +772,8 @@ static int mtk_infrasys_init(struct platform_device *pdev)
 		infra_clk_data = mtk_alloc_clk_data(CLK_INFRA_NR);
 	} else {
 		for (i = 0; i < CLK_INFRA_NR; i++) {
-			if (infra_clk_data->clks[i] == ERR_PTR(-EPROBE_DEFER))
-				infra_clk_data->clks[i] = ERR_PTR(-ENOENT);
+			if (infra_clk_data->hws[i] == ERR_PTR(-EPROBE_DEFER))
+				infra_clk_data->hws[i] = ERR_PTR(-ENOENT);
 		}
 	}
 
@@ -781,7 +782,8 @@ static int mtk_infrasys_init(struct platform_device *pdev)
 	mtk_clk_register_factors(infra_fixed_divs, ARRAY_SIZE(infra_fixed_divs),
 						infra_clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, infra_clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get,
+				   infra_clk_data);
 	if (r)
 		return r;
 
@@ -886,7 +888,7 @@ static const struct mtk_composite peri_muxs[] = {
 
 static int mtk_pericfg_init(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	void __iomem *base;
 	int r;
 	struct device_node *node = pdev->dev.of_node;
@@ -904,7 +906,7 @@ static int mtk_pericfg_init(struct platform_device *pdev)
 	mtk_clk_register_composites(peri_muxs, ARRAY_SIZE(peri_muxs), base,
 			&mt2701_clk_lock, clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
 		return r;
 
@@ -969,7 +971,7 @@ static const struct mtk_fixed_factor apmixed_fixed_divs[] = {
 
 static int mtk_apmixedsys_init(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	struct device_node *node = pdev->dev.of_node;
 
 	clk_data = mtk_alloc_clk_data(CLK_APMIXED_NR);
@@ -981,7 +983,7 @@ static int mtk_apmixedsys_init(struct platform_device *pdev)
 	mtk_clk_register_factors(apmixed_fixed_divs, ARRAY_SIZE(apmixed_fixed_divs),
 								clk_data);
 
-	return of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 }
 
 static const struct of_device_id of_match_clk_mt2701[] = {
diff --git a/drivers/clk/mediatek/clk-mt2712-bdp.c b/drivers/clk/mediatek/clk-mt2712-bdp.c
index a200714001d8..9acab4357133 100644
--- a/drivers/clk/mediatek/clk-mt2712-bdp.c
+++ b/drivers/clk/mediatek/clk-mt2712-bdp.c
@@ -60,7 +60,7 @@ static const struct mtk_gate bdp_clks[] = {
 
 static int clk_mt2712_bdp_probe(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	int r;
 	struct device_node *node = pdev->dev.of_node;
 
@@ -69,7 +69,7 @@ static int clk_mt2712_bdp_probe(struct platform_device *pdev)
 	mtk_clk_register_gates(node, bdp_clks, ARRAY_SIZE(bdp_clks),
 			clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 
 	if (r != 0)
 		pr_err("%s(): could not register clock provider: %d\n",
diff --git a/drivers/clk/mediatek/clk-mt2712-img.c b/drivers/clk/mediatek/clk-mt2712-img.c
index 89b2a7197b02..5cc143e65e42 100644
--- a/drivers/clk/mediatek/clk-mt2712-img.c
+++ b/drivers/clk/mediatek/clk-mt2712-img.c
@@ -38,7 +38,7 @@ static const struct mtk_gate img_clks[] = {
 
 static int clk_mt2712_img_probe(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	int r;
 	struct device_node *node = pdev->dev.of_node;
 
@@ -47,7 +47,7 @@ static int clk_mt2712_img_probe(struct platform_device *pdev)
 	mtk_clk_register_gates(node, img_clks, ARRAY_SIZE(img_clks),
 			clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 
 	if (r != 0)
 		pr_err("%s(): could not register clock provider: %d\n",
diff --git a/drivers/clk/mediatek/clk-mt2712-jpgdec.c b/drivers/clk/mediatek/clk-mt2712-jpgdec.c
index 58813c38ab4d..31fc30370d98 100644
--- a/drivers/clk/mediatek/clk-mt2712-jpgdec.c
+++ b/drivers/clk/mediatek/clk-mt2712-jpgdec.c
@@ -34,7 +34,7 @@ static const struct mtk_gate jpgdec_clks[] = {
 
 static int clk_mt2712_jpgdec_probe(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	int r;
 	struct device_node *node = pdev->dev.of_node;
 
@@ -43,7 +43,7 @@ static int clk_mt2712_jpgdec_probe(struct platform_device *pdev)
 	mtk_clk_register_gates(node, jpgdec_clks, ARRAY_SIZE(jpgdec_clks),
 			clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 
 	if (r != 0)
 		pr_err("%s(): could not register clock provider: %d\n",
diff --git a/drivers/clk/mediatek/clk-mt2712-mfg.c b/drivers/clk/mediatek/clk-mt2712-mfg.c
index a6b827db17bc..a4d09675bf18 100644
--- a/drivers/clk/mediatek/clk-mt2712-mfg.c
+++ b/drivers/clk/mediatek/clk-mt2712-mfg.c
@@ -33,7 +33,7 @@ static const struct mtk_gate mfg_clks[] = {
 
 static int clk_mt2712_mfg_probe(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	int r;
 	struct device_node *node = pdev->dev.of_node;
 
@@ -42,7 +42,7 @@ static int clk_mt2712_mfg_probe(struct platform_device *pdev)
 	mtk_clk_register_gates(node, mfg_clks, ARRAY_SIZE(mfg_clks),
 			clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 
 	if (r != 0)
 		pr_err("%s(): could not register clock provider: %d\n",
diff --git a/drivers/clk/mediatek/clk-mt2712-mm.c b/drivers/clk/mediatek/clk-mt2712-mm.c
index 5519c3d68c1f..7d44b09b8a0a 100644
--- a/drivers/clk/mediatek/clk-mt2712-mm.c
+++ b/drivers/clk/mediatek/clk-mt2712-mm.c
@@ -130,7 +130,7 @@ static int clk_mt2712_mm_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *node = dev->parent->of_node;
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	int r;
 
 	clk_data = mtk_alloc_clk_data(CLK_MM_NR_CLK);
@@ -138,7 +138,7 @@ static int clk_mt2712_mm_probe(struct platform_device *pdev)
 	mtk_clk_register_gates(node, mm_clks, ARRAY_SIZE(mm_clks),
 			clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 
 	if (r != 0)
 		pr_err("%s(): could not register clock provider: %d\n",
diff --git a/drivers/clk/mediatek/clk-mt2712-vdec.c b/drivers/clk/mediatek/clk-mt2712-vdec.c
index 4987ad9d3b11..af13f43dd831 100644
--- a/drivers/clk/mediatek/clk-mt2712-vdec.c
+++ b/drivers/clk/mediatek/clk-mt2712-vdec.c
@@ -52,7 +52,7 @@ static const struct mtk_gate vdec_clks[] = {
 
 static int clk_mt2712_vdec_probe(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	int r;
 	struct device_node *node = pdev->dev.of_node;
 
@@ -61,7 +61,7 @@ static int clk_mt2712_vdec_probe(struct platform_device *pdev)
 	mtk_clk_register_gates(node, vdec_clks, ARRAY_SIZE(vdec_clks),
 			clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 
 	if (r != 0)
 		pr_err("%s(): could not register clock provider: %d\n",
diff --git a/drivers/clk/mediatek/clk-mt2712-venc.c b/drivers/clk/mediatek/clk-mt2712-venc.c
index 07c29daa1ad6..abc08a029753 100644
--- a/drivers/clk/mediatek/clk-mt2712-venc.c
+++ b/drivers/clk/mediatek/clk-mt2712-venc.c
@@ -35,7 +35,7 @@ static const struct mtk_gate venc_clks[] = {
 
 static int clk_mt2712_venc_probe(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	int r;
 	struct device_node *node = pdev->dev.of_node;
 
@@ -44,7 +44,7 @@ static int clk_mt2712_venc_probe(struct platform_device *pdev)
 	mtk_clk_register_gates(node, venc_clks, ARRAY_SIZE(venc_clks),
 			clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 
 	if (r != 0)
 		pr_err("%s(): could not register clock provider: %d\n",
diff --git a/drivers/clk/mediatek/clk-mt2712.c b/drivers/clk/mediatek/clk-mt2712.c
index ff72b9ab945b..1dd90d9a70ac 100644
--- a/drivers/clk/mediatek/clk-mt2712.c
+++ b/drivers/clk/mediatek/clk-mt2712.c
@@ -1260,7 +1260,7 @@ static const struct mtk_pll_data plls[] = {
 
 static int clk_mt2712_apmixed_probe(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	int r;
 	struct device_node *node = pdev->dev.of_node;
 
@@ -1268,7 +1268,7 @@ static int clk_mt2712_apmixed_probe(struct platform_device *pdev)
 
 	mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls), clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 
 	if (r != 0)
 		pr_err("%s(): could not register clock provider: %d\n",
@@ -1277,7 +1277,7 @@ static int clk_mt2712_apmixed_probe(struct platform_device *pdev)
 	return r;
 }
 
-static struct clk_onecell_data *top_clk_data;
+static struct clk_hw_onecell_data *top_clk_data;
 
 static void clk_mt2712_top_init_early(struct device_node *node)
 {
@@ -1287,13 +1287,13 @@ static void clk_mt2712_top_init_early(struct device_node *node)
 		top_clk_data = mtk_alloc_clk_data(CLK_TOP_NR_CLK);
 
 		for (i = 0; i < CLK_TOP_NR_CLK; i++)
-			top_clk_data->clks[i] = ERR_PTR(-EPROBE_DEFER);
+			top_clk_data->hws[i] = ERR_PTR(-EPROBE_DEFER);
 	}
 
 	mtk_clk_register_factors(top_early_divs, ARRAY_SIZE(top_early_divs),
 			top_clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, top_clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, top_clk_data);
 	if (r)
 		pr_err("%s(): could not register clock provider: %d\n",
 			__func__, r);
@@ -1318,8 +1318,8 @@ static int clk_mt2712_top_probe(struct platform_device *pdev)
 		top_clk_data = mtk_alloc_clk_data(CLK_TOP_NR_CLK);
 	} else {
 		for (i = 0; i < CLK_TOP_NR_CLK; i++) {
-			if (top_clk_data->clks[i] == ERR_PTR(-EPROBE_DEFER))
-				top_clk_data->clks[i] = ERR_PTR(-ENOENT);
+			if (top_clk_data->hws[i] == ERR_PTR(-EPROBE_DEFER))
+				top_clk_data->hws[i] = ERR_PTR(-ENOENT);
 		}
 	}
 
@@ -1335,7 +1335,7 @@ static int clk_mt2712_top_probe(struct platform_device *pdev)
 	mtk_clk_register_gates(node, top_clks, ARRAY_SIZE(top_clks),
 			top_clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, top_clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, top_clk_data);
 
 	if (r != 0)
 		pr_err("%s(): could not register clock provider: %d\n",
@@ -1346,7 +1346,7 @@ static int clk_mt2712_top_probe(struct platform_device *pdev)
 
 static int clk_mt2712_infra_probe(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	int r;
 	struct device_node *node = pdev->dev.of_node;
 
@@ -1355,7 +1355,7 @@ static int clk_mt2712_infra_probe(struct platform_device *pdev)
 	mtk_clk_register_gates(node, infra_clks, ARRAY_SIZE(infra_clks),
 			clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 
 	if (r != 0)
 		pr_err("%s(): could not register clock provider: %d\n",
@@ -1368,7 +1368,7 @@ static int clk_mt2712_infra_probe(struct platform_device *pdev)
 
 static int clk_mt2712_peri_probe(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	int r;
 	struct device_node *node = pdev->dev.of_node;
 
@@ -1377,7 +1377,7 @@ static int clk_mt2712_peri_probe(struct platform_device *pdev)
 	mtk_clk_register_gates(node, peri_clks, ARRAY_SIZE(peri_clks),
 			clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 
 	if (r != 0)
 		pr_err("%s(): could not register clock provider: %d\n",
@@ -1390,7 +1390,7 @@ static int clk_mt2712_peri_probe(struct platform_device *pdev)
 
 static int clk_mt2712_mcu_probe(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	int r;
 	struct device_node *node = pdev->dev.of_node;
 	void __iomem *base;
@@ -1406,7 +1406,7 @@ static int clk_mt2712_mcu_probe(struct platform_device *pdev)
 	mtk_clk_register_composites(mcu_muxes, ARRAY_SIZE(mcu_muxes), base,
 			&mt2712_clk_lock, clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 
 	if (r != 0)
 		pr_err("%s(): could not register clock provider: %d\n",
-- 
2.36.0.512.ge40c2bad7a-goog

