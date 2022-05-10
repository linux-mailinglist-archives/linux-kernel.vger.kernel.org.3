Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F93D5212A9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 12:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbiEJKxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 06:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240119AbiEJKwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 06:52:35 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33BBD2AACE0
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 03:48:29 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 7so14300488pga.12
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 03:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rDBlVtlBk3iJvq0izqoPdeZIs7xJarHR6teFfjfA6mc=;
        b=D9l4c3TdRabfwTPFGHwMmev0Jw9ksUbxiEsuFexhX6BfFd1EVTLuyK2S3dHqLvc7h1
         gf+4zItpoCJGo23uNSDsAyCZ69Edifi3NqdsZu+twROcG+j8+he1z6V4CBLt2Evwx4aP
         wm0ofkRzrJbXSAWjXOZoAWrYbj0IJDtkRyPQY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rDBlVtlBk3iJvq0izqoPdeZIs7xJarHR6teFfjfA6mc=;
        b=AMc1J+nGHbRWlTfcYLtvlV50iDFOFQwqJVPy2Bzrc2GWHSvDjk6Vc6kySAsmATdSaS
         xai8/UbKEqn38Q9uZ2ZdfKZacQnAX+7aUPMON9bOpAZju/tNPoSZqYUnz76cEFeRB9jV
         KTyfS4kOzSPmIe6YWba/+WgLRNNEQN3JH0zQL985OLrtxCzdHn7E70aackWKBruptBQQ
         cFHDnrSOJeYalhscKke/UlGsb6HZxeOXx8xW9F+f+Vf4C1u3ZcZJMOpKJXPRQalXLvBr
         GVc5Ni56F+QNRNjmaBnxZ9Y1VpleRlXsZ/56p3UtrmaxfyG0iH8Za6bMbVCVoXBTy5RV
         T7Hw==
X-Gm-Message-State: AOAM530p+4PqWNwCvRLhBeeLtkvExlNFZWWerlutr8W6tRWGeR9bfP9+
        k4tDwLL2+JnjBOl29+u3o+Z7eQ==
X-Google-Smtp-Source: ABdhPJz97jGSqxSJR12QNtqsxZXMLCqkLBRTh7BzaCveNZiJ4MFBG1R4r1Bpm7g7ohq3arud0zwHWA==
X-Received: by 2002:a63:9d8a:0:b0:3ab:6ae4:fc25 with SMTP id i132-20020a639d8a000000b003ab6ae4fc25mr16631934pgd.496.1652179708415;
        Tue, 10 May 2022 03:48:28 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:6dcd:8578:55cf:2b12])
        by smtp.gmail.com with ESMTPSA id q9-20020a170902e30900b0015e8d4eb21esm1659691plc.104.2022.05.10.03.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 03:48:28 -0700 (PDT)
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
Subject: [PATCH v2 07/11] clk: mediatek: mt7xxx: Replace 'struct clk' with 'struct clk_hw'
Date:   Tue, 10 May 2022 18:48:00 +0800
Message-Id: <20220510104804.544597-8-wenst@chromium.org>
X-Mailer: git-send-email 2.36.0.512.ge40c2bad7a-goog
In-Reply-To: <20220510104804.544597-1-wenst@chromium.org>
References: <20220510104804.544597-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
ones. This patch covers MT7xxx.

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
 drivers/clk/mediatek/clk-mt7622-aud.c      |  4 +--
 drivers/clk/mediatek/clk-mt7622-eth.c      |  8 +++---
 drivers/clk/mediatek/clk-mt7622-hif.c      |  8 +++---
 drivers/clk/mediatek/clk-mt7622.c          | 30 +++++++++++-----------
 drivers/clk/mediatek/clk-mt7629-eth.c      |  8 +++---
 drivers/clk/mediatek/clk-mt7629-hif.c      |  8 +++---
 drivers/clk/mediatek/clk-mt7629.c          | 30 +++++++++++-----------
 drivers/clk/mediatek/clk-mt7986-apmixed.c  |  6 ++---
 drivers/clk/mediatek/clk-mt7986-eth.c      | 12 ++++-----
 drivers/clk/mediatek/clk-mt7986-infracfg.c |  4 +--
 drivers/clk/mediatek/clk-mt7986-topckgen.c | 16 ++++++------
 11 files changed, 67 insertions(+), 67 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7622-aud.c b/drivers/clk/mediatek/clk-mt7622-aud.c
index 2bd4295bc36b..9f2e5aa7b5d9 100644
--- a/drivers/clk/mediatek/clk-mt7622-aud.c
+++ b/drivers/clk/mediatek/clk-mt7622-aud.c
@@ -132,7 +132,7 @@ static const struct mtk_gate audio_clks[] = {
 
 static int clk_mt7622_audiosys_init(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	struct device_node *node = pdev->dev.of_node;
 	int r;
 
@@ -141,7 +141,7 @@ static int clk_mt7622_audiosys_init(struct platform_device *pdev)
 	mtk_clk_register_gates(node, audio_clks, ARRAY_SIZE(audio_clks),
 			       clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r) {
 		dev_err(&pdev->dev,
 			"could not register clock provider: %s: %d\n",
diff --git a/drivers/clk/mediatek/clk-mt7622-eth.c b/drivers/clk/mediatek/clk-mt7622-eth.c
index c9947dc7ba5a..b12d48705496 100644
--- a/drivers/clk/mediatek/clk-mt7622-eth.c
+++ b/drivers/clk/mediatek/clk-mt7622-eth.c
@@ -67,7 +67,7 @@ static const struct mtk_gate sgmii_clks[] = {
 
 static int clk_mt7622_ethsys_init(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	struct device_node *node = pdev->dev.of_node;
 	int r;
 
@@ -76,7 +76,7 @@ static int clk_mt7622_ethsys_init(struct platform_device *pdev)
 	mtk_clk_register_gates(node, eth_clks, ARRAY_SIZE(eth_clks),
 			       clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
 		dev_err(&pdev->dev,
 			"could not register clock provider: %s: %d\n",
@@ -89,7 +89,7 @@ static int clk_mt7622_ethsys_init(struct platform_device *pdev)
 
 static int clk_mt7622_sgmiisys_init(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	struct device_node *node = pdev->dev.of_node;
 	int r;
 
@@ -98,7 +98,7 @@ static int clk_mt7622_sgmiisys_init(struct platform_device *pdev)
 	mtk_clk_register_gates(node, sgmii_clks, ARRAY_SIZE(sgmii_clks),
 			       clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
 		dev_err(&pdev->dev,
 			"could not register clock provider: %s: %d\n",
diff --git a/drivers/clk/mediatek/clk-mt7622-hif.c b/drivers/clk/mediatek/clk-mt7622-hif.c
index 628be0c9f888..58728e35e80a 100644
--- a/drivers/clk/mediatek/clk-mt7622-hif.c
+++ b/drivers/clk/mediatek/clk-mt7622-hif.c
@@ -78,7 +78,7 @@ static const struct mtk_gate pcie_clks[] = {
 
 static int clk_mt7622_ssusbsys_init(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	struct device_node *node = pdev->dev.of_node;
 	int r;
 
@@ -87,7 +87,7 @@ static int clk_mt7622_ssusbsys_init(struct platform_device *pdev)
 	mtk_clk_register_gates(node, ssusb_clks, ARRAY_SIZE(ssusb_clks),
 			       clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
 		dev_err(&pdev->dev,
 			"could not register clock provider: %s: %d\n",
@@ -100,7 +100,7 @@ static int clk_mt7622_ssusbsys_init(struct platform_device *pdev)
 
 static int clk_mt7622_pciesys_init(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	struct device_node *node = pdev->dev.of_node;
 	int r;
 
@@ -109,7 +109,7 @@ static int clk_mt7622_pciesys_init(struct platform_device *pdev)
 	mtk_clk_register_gates(node, pcie_clks, ARRAY_SIZE(pcie_clks),
 			       clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
 		dev_err(&pdev->dev,
 			"could not register clock provider: %s: %d\n",
diff --git a/drivers/clk/mediatek/clk-mt7622.c b/drivers/clk/mediatek/clk-mt7622.c
index 0e1fb30a1e98..a110ee2b5ea6 100644
--- a/drivers/clk/mediatek/clk-mt7622.c
+++ b/drivers/clk/mediatek/clk-mt7622.c
@@ -612,7 +612,7 @@ static struct mtk_composite peri_muxes[] = {
 
 static int mtk_topckgen_init(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	void __iomem *base;
 	struct device_node *node = pdev->dev.of_node;
 
@@ -637,17 +637,17 @@ static int mtk_topckgen_init(struct platform_device *pdev)
 	mtk_clk_register_gates(node, top_clks, ARRAY_SIZE(top_clks),
 			       clk_data);
 
-	clk_prepare_enable(clk_data->clks[CLK_TOP_AXI_SEL]);
-	clk_prepare_enable(clk_data->clks[CLK_TOP_MEM_SEL]);
-	clk_prepare_enable(clk_data->clks[CLK_TOP_DDRPHYCFG_SEL]);
+	clk_prepare_enable(clk_data->hws[CLK_TOP_AXI_SEL]->clk);
+	clk_prepare_enable(clk_data->hws[CLK_TOP_MEM_SEL]->clk);
+	clk_prepare_enable(clk_data->hws[CLK_TOP_DDRPHYCFG_SEL]->clk);
 
-	return of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 }
 
 static int mtk_infrasys_init(struct platform_device *pdev)
 {
 	struct device_node *node = pdev->dev.of_node;
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	int r;
 
 	clk_data = mtk_alloc_clk_data(CLK_INFRA_NR_CLK);
@@ -658,8 +658,8 @@ static int mtk_infrasys_init(struct platform_device *pdev)
 	mtk_clk_register_cpumuxes(node, infra_muxes, ARRAY_SIZE(infra_muxes),
 				  clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get,
-				clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get,
+				   clk_data);
 	if (r)
 		return r;
 
@@ -670,7 +670,7 @@ static int mtk_infrasys_init(struct platform_device *pdev)
 
 static int mtk_apmixedsys_init(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	struct device_node *node = pdev->dev.of_node;
 
 	clk_data = mtk_alloc_clk_data(CLK_APMIXED_NR_CLK);
@@ -683,15 +683,15 @@ static int mtk_apmixedsys_init(struct platform_device *pdev)
 	mtk_clk_register_gates(node, apmixed_clks,
 			       ARRAY_SIZE(apmixed_clks), clk_data);
 
-	clk_prepare_enable(clk_data->clks[CLK_APMIXED_ARMPLL]);
-	clk_prepare_enable(clk_data->clks[CLK_APMIXED_MAIN_CORE_EN]);
+	clk_prepare_enable(clk_data->hws[CLK_APMIXED_ARMPLL]->clk);
+	clk_prepare_enable(clk_data->hws[CLK_APMIXED_MAIN_CORE_EN]->clk);
 
-	return of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 }
 
 static int mtk_pericfg_init(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	void __iomem *base;
 	int r;
 	struct device_node *node = pdev->dev.of_node;
@@ -708,11 +708,11 @@ static int mtk_pericfg_init(struct platform_device *pdev)
 	mtk_clk_register_composites(peri_muxes, ARRAY_SIZE(peri_muxes), base,
 				    &mt7622_clk_lock, clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
 		return r;
 
-	clk_prepare_enable(clk_data->clks[CLK_PERI_UART0_PD]);
+	clk_prepare_enable(clk_data->hws[CLK_PERI_UART0_PD]->clk);
 
 	mtk_register_reset_controller(node, 2, 0x0);
 
diff --git a/drivers/clk/mediatek/clk-mt7629-eth.c b/drivers/clk/mediatek/clk-mt7629-eth.c
index 88279d0ea1a7..c49fd732c9b2 100644
--- a/drivers/clk/mediatek/clk-mt7629-eth.c
+++ b/drivers/clk/mediatek/clk-mt7629-eth.c
@@ -78,7 +78,7 @@ static const struct mtk_gate sgmii_clks[2][4] = {
 
 static int clk_mt7629_ethsys_init(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	struct device_node *node = pdev->dev.of_node;
 	int r;
 
@@ -86,7 +86,7 @@ static int clk_mt7629_ethsys_init(struct platform_device *pdev)
 
 	mtk_clk_register_gates(node, eth_clks, CLK_ETH_NR_CLK, clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
 		dev_err(&pdev->dev,
 			"could not register clock provider: %s: %d\n",
@@ -99,7 +99,7 @@ static int clk_mt7629_ethsys_init(struct platform_device *pdev)
 
 static int clk_mt7629_sgmiisys_init(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	struct device_node *node = pdev->dev.of_node;
 	static int id;
 	int r;
@@ -109,7 +109,7 @@ static int clk_mt7629_sgmiisys_init(struct platform_device *pdev)
 	mtk_clk_register_gates(node, sgmii_clks[id++], CLK_SGMII_NR_CLK,
 			       clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
 		dev_err(&pdev->dev,
 			"could not register clock provider: %s: %d\n",
diff --git a/drivers/clk/mediatek/clk-mt7629-hif.c b/drivers/clk/mediatek/clk-mt7629-hif.c
index 5c5b37207afb..acaa97fda331 100644
--- a/drivers/clk/mediatek/clk-mt7629-hif.c
+++ b/drivers/clk/mediatek/clk-mt7629-hif.c
@@ -73,7 +73,7 @@ static const struct mtk_gate pcie_clks[] = {
 
 static int clk_mt7629_ssusbsys_init(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	struct device_node *node = pdev->dev.of_node;
 	int r;
 
@@ -82,7 +82,7 @@ static int clk_mt7629_ssusbsys_init(struct platform_device *pdev)
 	mtk_clk_register_gates(node, ssusb_clks, ARRAY_SIZE(ssusb_clks),
 			       clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
 		dev_err(&pdev->dev,
 			"could not register clock provider: %s: %d\n",
@@ -95,7 +95,7 @@ static int clk_mt7629_ssusbsys_init(struct platform_device *pdev)
 
 static int clk_mt7629_pciesys_init(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	struct device_node *node = pdev->dev.of_node;
 	int r;
 
@@ -104,7 +104,7 @@ static int clk_mt7629_pciesys_init(struct platform_device *pdev)
 	mtk_clk_register_gates(node, pcie_clks, ARRAY_SIZE(pcie_clks),
 			       clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
 		dev_err(&pdev->dev,
 			"could not register clock provider: %s: %d\n",
diff --git a/drivers/clk/mediatek/clk-mt7629.c b/drivers/clk/mediatek/clk-mt7629.c
index c0e023bf31eb..118a5af38dd9 100644
--- a/drivers/clk/mediatek/clk-mt7629.c
+++ b/drivers/clk/mediatek/clk-mt7629.c
@@ -572,7 +572,7 @@ static struct mtk_composite peri_muxes[] = {
 
 static int mtk_topckgen_init(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	void __iomem *base;
 	struct device_node *node = pdev->dev.of_node;
 
@@ -591,17 +591,17 @@ static int mtk_topckgen_init(struct platform_device *pdev)
 	mtk_clk_register_composites(top_muxes, ARRAY_SIZE(top_muxes),
 				    base, &mt7629_clk_lock, clk_data);
 
-	clk_prepare_enable(clk_data->clks[CLK_TOP_AXI_SEL]);
-	clk_prepare_enable(clk_data->clks[CLK_TOP_MEM_SEL]);
-	clk_prepare_enable(clk_data->clks[CLK_TOP_DDRPHYCFG_SEL]);
+	clk_prepare_enable(clk_data->hws[CLK_TOP_AXI_SEL]->clk);
+	clk_prepare_enable(clk_data->hws[CLK_TOP_MEM_SEL]->clk);
+	clk_prepare_enable(clk_data->hws[CLK_TOP_DDRPHYCFG_SEL]->clk);
 
-	return of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 }
 
 static int mtk_infrasys_init(struct platform_device *pdev)
 {
 	struct device_node *node = pdev->dev.of_node;
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 
 	clk_data = mtk_alloc_clk_data(CLK_INFRA_NR_CLK);
 
@@ -611,13 +611,13 @@ static int mtk_infrasys_init(struct platform_device *pdev)
 	mtk_clk_register_cpumuxes(node, infra_muxes, ARRAY_SIZE(infra_muxes),
 				  clk_data);
 
-	return of_clk_add_provider(node, of_clk_src_onecell_get,
-				   clk_data);
+	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get,
+				      clk_data);
 }
 
 static int mtk_pericfg_init(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	void __iomem *base;
 	int r;
 	struct device_node *node = pdev->dev.of_node;
@@ -634,18 +634,18 @@ static int mtk_pericfg_init(struct platform_device *pdev)
 	mtk_clk_register_composites(peri_muxes, ARRAY_SIZE(peri_muxes), base,
 				    &mt7629_clk_lock, clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
 		return r;
 
-	clk_prepare_enable(clk_data->clks[CLK_PERI_UART0_PD]);
+	clk_prepare_enable(clk_data->hws[CLK_PERI_UART0_PD]->clk);
 
 	return 0;
 }
 
 static int mtk_apmixedsys_init(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	struct device_node *node = pdev->dev.of_node;
 
 	clk_data = mtk_alloc_clk_data(CLK_APMIXED_NR_CLK);
@@ -658,10 +658,10 @@ static int mtk_apmixedsys_init(struct platform_device *pdev)
 	mtk_clk_register_gates(node, apmixed_clks,
 			       ARRAY_SIZE(apmixed_clks), clk_data);
 
-	clk_prepare_enable(clk_data->clks[CLK_APMIXED_ARMPLL]);
-	clk_prepare_enable(clk_data->clks[CLK_APMIXED_MAIN_CORE_EN]);
+	clk_prepare_enable(clk_data->hws[CLK_APMIXED_ARMPLL]->clk);
+	clk_prepare_enable(clk_data->hws[CLK_APMIXED_MAIN_CORE_EN]->clk);
 
-	return of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 }
 
 
diff --git a/drivers/clk/mediatek/clk-mt7986-apmixed.c b/drivers/clk/mediatek/clk-mt7986-apmixed.c
index 21d4c82e782a..1f4266841f29 100644
--- a/drivers/clk/mediatek/clk-mt7986-apmixed.c
+++ b/drivers/clk/mediatek/clk-mt7986-apmixed.c
@@ -67,7 +67,7 @@ static const struct of_device_id of_match_clk_mt7986_apmixed[] = {
 
 static int clk_mt7986_apmixed_probe(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	struct device_node *node = pdev->dev.of_node;
 	int r;
 
@@ -77,9 +77,9 @@ static int clk_mt7986_apmixed_probe(struct platform_device *pdev)
 
 	mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls), clk_data);
 
-	clk_prepare_enable(clk_data->clks[CLK_APMIXED_ARMPLL]);
+	clk_prepare_enable(clk_data->hws[CLK_APMIXED_ARMPLL]->clk);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r) {
 		pr_err("%s(): could not register clock provider: %d\n",
 		       __func__, r);
diff --git a/drivers/clk/mediatek/clk-mt7986-eth.c b/drivers/clk/mediatek/clk-mt7986-eth.c
index 495d023ccad7..6aea4d76478a 100644
--- a/drivers/clk/mediatek/clk-mt7986-eth.c
+++ b/drivers/clk/mediatek/clk-mt7986-eth.c
@@ -79,7 +79,7 @@ static const struct mtk_gate eth_clks[] __initconst = {
 
 static void __init mtk_sgmiisys_0_init(struct device_node *node)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	int r;
 
 	clk_data = mtk_alloc_clk_data(ARRAY_SIZE(sgmii0_clks));
@@ -87,7 +87,7 @@ static void __init mtk_sgmiisys_0_init(struct device_node *node)
 	mtk_clk_register_gates(node, sgmii0_clks, ARRAY_SIZE(sgmii0_clks),
 			       clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
 		pr_err("%s(): could not register clock provider: %d\n",
 		       __func__, r);
@@ -97,7 +97,7 @@ CLK_OF_DECLARE(mtk_sgmiisys_0, "mediatek,mt7986-sgmiisys_0",
 
 static void __init mtk_sgmiisys_1_init(struct device_node *node)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	int r;
 
 	clk_data = mtk_alloc_clk_data(ARRAY_SIZE(sgmii1_clks));
@@ -105,7 +105,7 @@ static void __init mtk_sgmiisys_1_init(struct device_node *node)
 	mtk_clk_register_gates(node, sgmii1_clks, ARRAY_SIZE(sgmii1_clks),
 			       clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 
 	if (r)
 		pr_err("%s(): could not register clock provider: %d\n",
@@ -116,14 +116,14 @@ CLK_OF_DECLARE(mtk_sgmiisys_1, "mediatek,mt7986-sgmiisys_1",
 
 static void __init mtk_ethsys_init(struct device_node *node)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	int r;
 
 	clk_data = mtk_alloc_clk_data(ARRAY_SIZE(eth_clks));
 
 	mtk_clk_register_gates(node, eth_clks, ARRAY_SIZE(eth_clks), clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 
 	if (r)
 		pr_err("%s(): could not register clock provider: %d\n",
diff --git a/drivers/clk/mediatek/clk-mt7986-infracfg.c b/drivers/clk/mediatek/clk-mt7986-infracfg.c
index f209c559fbc3..d90727a53283 100644
--- a/drivers/clk/mediatek/clk-mt7986-infracfg.c
+++ b/drivers/clk/mediatek/clk-mt7986-infracfg.c
@@ -171,7 +171,7 @@ static const struct mtk_gate infra_clks[] = {
 
 static int clk_mt7986_infracfg_probe(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	struct device_node *node = pdev->dev.of_node;
 	int r;
 	void __iomem *base;
@@ -195,7 +195,7 @@ static int clk_mt7986_infracfg_probe(struct platform_device *pdev)
 	mtk_clk_register_gates(node, infra_clks, ARRAY_SIZE(infra_clks),
 			       clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r) {
 		pr_err("%s(): could not register clock provider: %d\n",
 		       __func__, r);
diff --git a/drivers/clk/mediatek/clk-mt7986-topckgen.c b/drivers/clk/mediatek/clk-mt7986-topckgen.c
index 8f6f79b6e31e..de5121cf2877 100644
--- a/drivers/clk/mediatek/clk-mt7986-topckgen.c
+++ b/drivers/clk/mediatek/clk-mt7986-topckgen.c
@@ -283,7 +283,7 @@ static const struct mtk_mux top_muxes[] = {
 
 static int clk_mt7986_topckgen_probe(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	struct device_node *node = pdev->dev.of_node;
 	int r;
 	void __iomem *base;
@@ -306,14 +306,14 @@ static int clk_mt7986_topckgen_probe(struct platform_device *pdev)
 	mtk_clk_register_muxes(top_muxes, ARRAY_SIZE(top_muxes), node,
 			       &mt7986_clk_lock, clk_data);
 
-	clk_prepare_enable(clk_data->clks[CLK_TOP_SYSAXI_SEL]);
-	clk_prepare_enable(clk_data->clks[CLK_TOP_SYSAPB_SEL]);
-	clk_prepare_enable(clk_data->clks[CLK_TOP_DRAMC_SEL]);
-	clk_prepare_enable(clk_data->clks[CLK_TOP_DRAMC_MD32_SEL]);
-	clk_prepare_enable(clk_data->clks[CLK_TOP_F26M_SEL]);
-	clk_prepare_enable(clk_data->clks[CLK_TOP_SGM_REG_SEL]);
+	clk_prepare_enable(clk_data->hws[CLK_TOP_SYSAXI_SEL]->clk);
+	clk_prepare_enable(clk_data->hws[CLK_TOP_SYSAPB_SEL]->clk);
+	clk_prepare_enable(clk_data->hws[CLK_TOP_DRAMC_SEL]->clk);
+	clk_prepare_enable(clk_data->hws[CLK_TOP_DRAMC_MD32_SEL]->clk);
+	clk_prepare_enable(clk_data->hws[CLK_TOP_F26M_SEL]->clk);
+	clk_prepare_enable(clk_data->hws[CLK_TOP_SGM_REG_SEL]->clk);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 
 	if (r) {
 		pr_err("%s(): could not register clock provider: %d\n",
-- 
2.36.0.512.ge40c2bad7a-goog

