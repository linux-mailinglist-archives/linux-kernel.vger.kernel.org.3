Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8885212AA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 12:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240195AbiEJKxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 06:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240057AbiEJKwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 06:52:36 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A57002AACF7
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 03:48:31 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id v10so14301420pgl.11
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 03:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P3Bwo743VM+uDlSC7dkmzElM8Nj+h+9fBftw0ZaeHLM=;
        b=X2b3qfwnSS8oVosgc6SXwO/v0avXSbE9D1evU942raxCY2a4EoeWZxa09+t8zcS9hs
         aDLizQhBW20T8Bmdv5pLpP6Mwa8RXh5KpmrwFB/Ch8EveCWzTXqXPxdzHpKiC7SnKiFI
         nZaUuSimKBDWyAvqbjroEiqpOCgGiikt8iogs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P3Bwo743VM+uDlSC7dkmzElM8Nj+h+9fBftw0ZaeHLM=;
        b=jVmw1/iOa+zLY/qYbRVapd8/bVWGG6WP+TuKlppQyixbjhVQVhGt3BOGKWdM3JbOcz
         murg1QwNoMSUixfKudKqOmf5fA/IYBYmn3lyk8imVz+tZOCMIs4XOMObZlYahSvhIPlk
         wew7D1EF4MVeoC32z43QGyjFFeX/Jiq5IH92FC9vslUBo6EIsvUK5DAPK7vajXXYRAGU
         F/klYIeMIX5KZi59LRj5fTP4be/xGm/rX9DhiTvdJVQyQ+6vhStoPqUH+r+JMUlUA8KD
         3ymdwtrmAQ32FH+9G1YkKJ4AE6krAtCqBYmVKfSz25MVMhGQ5wPja0q+VZifekYn8ccu
         tPPw==
X-Gm-Message-State: AOAM532Xfk+No5lA/pHE0e5o0Kn+h4nSlSqpntGEwGWGlkVU76F3amcS
        HJuigxGynjjGzycSe4FpJZZZiw==
X-Google-Smtp-Source: ABdhPJzhA/eBXS1Ti1ZkJ+DqCyVEfvfInhAozWaw7zcpGZhkZZUk4xXQVxXdC6IE6ChlHcIpzTobCQ==
X-Received: by 2002:a63:7d5:0:b0:3db:33c:4983 with SMTP id 204-20020a6307d5000000b003db033c4983mr786257pgh.199.1652179710915;
        Tue, 10 May 2022 03:48:30 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:6dcd:8578:55cf:2b12])
        by smtp.gmail.com with ESMTPSA id q9-20020a170902e30900b0015e8d4eb21esm1659691plc.104.2022.05.10.03.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 03:48:30 -0700 (PDT)
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
Subject: [PATCH v2 08/11] clk: mediatek: mt8xxx: Replace 'struct clk' with 'struct clk_hw'
Date:   Tue, 10 May 2022 18:48:01 +0800
Message-Id: <20220510104804.544597-9-wenst@chromium.org>
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
ones. This patch covers MT8xxx.

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
 drivers/clk/mediatek/clk-mt8135.c            | 18 +++----
 drivers/clk/mediatek/clk-mt8167-aud.c        |  4 +-
 drivers/clk/mediatek/clk-mt8167-img.c        |  4 +-
 drivers/clk/mediatek/clk-mt8167-mfgcfg.c     |  4 +-
 drivers/clk/mediatek/clk-mt8167-mm.c         |  4 +-
 drivers/clk/mediatek/clk-mt8167-vdec.c       |  4 +-
 drivers/clk/mediatek/clk-mt8167.c            | 12 ++---
 drivers/clk/mediatek/clk-mt8173-mm.c         |  4 +-
 drivers/clk/mediatek/clk-mt8173.c            | 52 ++++++++++----------
 drivers/clk/mediatek/clk-mt8183-audio.c      |  4 +-
 drivers/clk/mediatek/clk-mt8183-cam.c        |  4 +-
 drivers/clk/mediatek/clk-mt8183-img.c        |  4 +-
 drivers/clk/mediatek/clk-mt8183-ipu0.c       |  4 +-
 drivers/clk/mediatek/clk-mt8183-ipu1.c       |  4 +-
 drivers/clk/mediatek/clk-mt8183-ipu_adl.c    |  4 +-
 drivers/clk/mediatek/clk-mt8183-ipu_conn.c   |  4 +-
 drivers/clk/mediatek/clk-mt8183-mfgcfg.c     |  4 +-
 drivers/clk/mediatek/clk-mt8183-mm.c         |  4 +-
 drivers/clk/mediatek/clk-mt8183-vdec.c       |  4 +-
 drivers/clk/mediatek/clk-mt8183-venc.c       |  4 +-
 drivers/clk/mediatek/clk-mt8183.c            | 25 +++++-----
 drivers/clk/mediatek/clk-mt8186-apmixedsys.c |  6 +--
 drivers/clk/mediatek/clk-mt8186-mcu.c        |  6 +--
 drivers/clk/mediatek/clk-mt8186-mm.c         |  6 +--
 drivers/clk/mediatek/clk-mt8186-topckgen.c   |  6 +--
 drivers/clk/mediatek/clk-mt8192-aud.c        |  4 +-
 drivers/clk/mediatek/clk-mt8192-mm.c         |  4 +-
 drivers/clk/mediatek/clk-mt8192.c            | 21 ++++----
 drivers/clk/mediatek/clk-mt8195-apmixedsys.c |  6 +--
 drivers/clk/mediatek/clk-mt8195-apusys_pll.c |  6 +--
 drivers/clk/mediatek/clk-mt8195-topckgen.c   |  6 +--
 drivers/clk/mediatek/clk-mt8195-vdo0.c       |  6 +--
 drivers/clk/mediatek/clk-mt8195-vdo1.c       |  6 +--
 drivers/clk/mediatek/clk-mt8516-aud.c        |  4 +-
 drivers/clk/mediatek/clk-mt8516.c            | 12 ++---
 35 files changed, 138 insertions(+), 136 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8135.c b/drivers/clk/mediatek/clk-mt8135.c
index 09ad272d51f1..19827037b6c0 100644
--- a/drivers/clk/mediatek/clk-mt8135.c
+++ b/drivers/clk/mediatek/clk-mt8135.c
@@ -516,7 +516,7 @@ static const struct mtk_composite peri_clks[] __initconst = {
 
 static void __init mtk_topckgen_init(struct device_node *node)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	void __iomem *base;
 	int r;
 
@@ -533,9 +533,9 @@ static void __init mtk_topckgen_init(struct device_node *node)
 	mtk_clk_register_composites(top_muxes, ARRAY_SIZE(top_muxes), base,
 			&mt8135_clk_lock, clk_data);
 
-	clk_prepare_enable(clk_data->clks[CLK_TOP_CCI_SEL]);
+	clk_prepare_enable(clk_data->hws[CLK_TOP_CCI_SEL]->clk);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
 		pr_err("%s(): could not register clock provider: %d\n",
 			__func__, r);
@@ -544,7 +544,7 @@ CLK_OF_DECLARE(mtk_topckgen, "mediatek,mt8135-topckgen", mtk_topckgen_init);
 
 static void __init mtk_infrasys_init(struct device_node *node)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	int r;
 
 	clk_data = mtk_alloc_clk_data(CLK_INFRA_NR_CLK);
@@ -552,9 +552,9 @@ static void __init mtk_infrasys_init(struct device_node *node)
 	mtk_clk_register_gates(node, infra_clks, ARRAY_SIZE(infra_clks),
 						clk_data);
 
-	clk_prepare_enable(clk_data->clks[CLK_INFRA_M4U]);
+	clk_prepare_enable(clk_data->hws[CLK_INFRA_M4U]->clk);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
 		pr_err("%s(): could not register clock provider: %d\n",
 			__func__, r);
@@ -565,7 +565,7 @@ CLK_OF_DECLARE(mtk_infrasys, "mediatek,mt8135-infracfg", mtk_infrasys_init);
 
 static void __init mtk_pericfg_init(struct device_node *node)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	int r;
 	void __iomem *base;
 
@@ -582,7 +582,7 @@ static void __init mtk_pericfg_init(struct device_node *node)
 	mtk_clk_register_composites(peri_clks, ARRAY_SIZE(peri_clks), base,
 			&mt8135_clk_lock, clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
 		pr_err("%s(): could not register clock provider: %d\n",
 			__func__, r);
@@ -626,7 +626,7 @@ static const struct mtk_pll_data plls[] = {
 
 static void __init mtk_apmixedsys_init(struct device_node *node)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 
 	clk_data = mtk_alloc_clk_data(CLK_APMIXED_NR_CLK);
 	if (!clk_data)
diff --git a/drivers/clk/mediatek/clk-mt8167-aud.c b/drivers/clk/mediatek/clk-mt8167-aud.c
index 3f7bf6485792..ce1ae8d243c3 100644
--- a/drivers/clk/mediatek/clk-mt8167-aud.c
+++ b/drivers/clk/mediatek/clk-mt8167-aud.c
@@ -50,14 +50,14 @@ static const struct mtk_gate aud_clks[] __initconst = {
 
 static void __init mtk_audsys_init(struct device_node *node)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	int r;
 
 	clk_data = mtk_alloc_clk_data(CLK_AUD_NR_CLK);
 
 	mtk_clk_register_gates(node, aud_clks, ARRAY_SIZE(aud_clks), clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
 		pr_err("%s(): could not register clock provider: %d\n",
 			__func__, r);
diff --git a/drivers/clk/mediatek/clk-mt8167-img.c b/drivers/clk/mediatek/clk-mt8167-img.c
index 3b4ec9eae432..e359e563d2b7 100644
--- a/drivers/clk/mediatek/clk-mt8167-img.c
+++ b/drivers/clk/mediatek/clk-mt8167-img.c
@@ -43,14 +43,14 @@ static const struct mtk_gate img_clks[] __initconst = {
 
 static void __init mtk_imgsys_init(struct device_node *node)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	int r;
 
 	clk_data = mtk_alloc_clk_data(CLK_IMG_NR_CLK);
 
 	mtk_clk_register_gates(node, img_clks, ARRAY_SIZE(img_clks), clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 
 	if (r)
 		pr_err("%s(): could not register clock provider: %d\n",
diff --git a/drivers/clk/mediatek/clk-mt8167-mfgcfg.c b/drivers/clk/mediatek/clk-mt8167-mfgcfg.c
index 90b871730f2d..4fd82fe87d6e 100644
--- a/drivers/clk/mediatek/clk-mt8167-mfgcfg.c
+++ b/drivers/clk/mediatek/clk-mt8167-mfgcfg.c
@@ -41,14 +41,14 @@ static const struct mtk_gate mfg_clks[] __initconst = {
 
 static void __init mtk_mfgcfg_init(struct device_node *node)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	int r;
 
 	clk_data = mtk_alloc_clk_data(CLK_MFG_NR_CLK);
 
 	mtk_clk_register_gates(node, mfg_clks, ARRAY_SIZE(mfg_clks), clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 
 	if (r)
 		pr_err("%s(): could not register clock provider: %d\n",
diff --git a/drivers/clk/mediatek/clk-mt8167-mm.c b/drivers/clk/mediatek/clk-mt8167-mm.c
index 963b129aade1..73910060577f 100644
--- a/drivers/clk/mediatek/clk-mt8167-mm.c
+++ b/drivers/clk/mediatek/clk-mt8167-mm.c
@@ -101,7 +101,7 @@ static int clk_mt8167_mm_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *node = dev->parent->of_node;
 	const struct clk_mt8167_mm_driver_data *data;
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	int ret;
 
 	clk_data = mtk_alloc_clk_data(CLK_MM_NR_CLK);
@@ -115,7 +115,7 @@ static int clk_mt8167_mm_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	ret = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (ret)
 		return ret;
 
diff --git a/drivers/clk/mediatek/clk-mt8167-vdec.c b/drivers/clk/mediatek/clk-mt8167-vdec.c
index 910b28355ec0..ee4fffb6859d 100644
--- a/drivers/clk/mediatek/clk-mt8167-vdec.c
+++ b/drivers/clk/mediatek/clk-mt8167-vdec.c
@@ -56,14 +56,14 @@ static const struct mtk_gate vdec_clks[] __initconst = {
 
 static void __init mtk_vdecsys_init(struct device_node *node)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	int r;
 
 	clk_data = mtk_alloc_clk_data(CLK_VDEC_NR_CLK);
 
 	mtk_clk_register_gates(node, vdec_clks, ARRAY_SIZE(vdec_clks), clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 
 	if (r)
 		pr_err("%s(): could not register clock provider: %d\n",
diff --git a/drivers/clk/mediatek/clk-mt8167.c b/drivers/clk/mediatek/clk-mt8167.c
index 812b33a57530..ee83bfb015ba 100644
--- a/drivers/clk/mediatek/clk-mt8167.c
+++ b/drivers/clk/mediatek/clk-mt8167.c
@@ -923,7 +923,7 @@ static const struct mtk_gate top_clks[] __initconst = {
 
 static void __init mtk_topckgen_init(struct device_node *node)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	int r;
 	void __iomem *base;
 
@@ -945,7 +945,7 @@ static void __init mtk_topckgen_init(struct device_node *node)
 	mtk_clk_register_dividers(top_adj_divs, ARRAY_SIZE(top_adj_divs),
 				base, &mt8167_clk_lock, clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
 		pr_err("%s(): could not register clock provider: %d\n",
 			__func__, r);
@@ -954,7 +954,7 @@ CLK_OF_DECLARE(mtk_topckgen, "mediatek,mt8167-topckgen", mtk_topckgen_init);
 
 static void __init mtk_infracfg_init(struct device_node *node)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	int r;
 	void __iomem *base;
 
@@ -969,7 +969,7 @@ static void __init mtk_infracfg_init(struct device_node *node)
 	mtk_clk_register_composites(ifr_muxes, ARRAY_SIZE(ifr_muxes), base,
 		&mt8167_clk_lock, clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
 		pr_err("%s(): could not register clock provider: %d\n",
 			__func__, r);
@@ -1037,7 +1037,7 @@ static const struct mtk_pll_data plls[] = {
 
 static void __init mtk_apmixedsys_init(struct device_node *node)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	void __iomem *base;
 	int r;
 
@@ -1053,7 +1053,7 @@ static void __init mtk_apmixedsys_init(struct device_node *node)
 	mtk_clk_register_dividers(apmixed_adj_divs, ARRAY_SIZE(apmixed_adj_divs),
 		base, &mt8167_clk_lock, clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
 		pr_err("%s(): could not register clock provider: %d\n",
 			__func__, r);
diff --git a/drivers/clk/mediatek/clk-mt8173-mm.c b/drivers/clk/mediatek/clk-mt8173-mm.c
index 36fa20be77b6..8abf42c2030c 100644
--- a/drivers/clk/mediatek/clk-mt8173-mm.c
+++ b/drivers/clk/mediatek/clk-mt8173-mm.c
@@ -115,7 +115,7 @@ static int clk_mt8173_mm_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *node = dev->parent->of_node;
 	const struct clk_mt8173_mm_driver_data *data;
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	int ret;
 
 	clk_data = mtk_alloc_clk_data(CLK_MM_NR_CLK);
@@ -129,7 +129,7 @@ static int clk_mt8173_mm_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	ret = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (ret)
 		return ret;
 
diff --git a/drivers/clk/mediatek/clk-mt8173.c b/drivers/clk/mediatek/clk-mt8173.c
index 46b7655feeaa..511b4da9e727 100644
--- a/drivers/clk/mediatek/clk-mt8173.c
+++ b/drivers/clk/mediatek/clk-mt8173.c
@@ -819,25 +819,25 @@ static const struct mtk_gate venclt_clks[] __initconst = {
 	GATE_VENCLT(CLK_VENCLT_CKE1, "venclt_cke1", "venclt_sel", 4),
 };
 
-static struct clk_onecell_data *mt8173_top_clk_data __initdata;
-static struct clk_onecell_data *mt8173_pll_clk_data __initdata;
+static struct clk_hw_onecell_data *mt8173_top_clk_data __initdata;
+static struct clk_hw_onecell_data *mt8173_pll_clk_data __initdata;
 
 static void __init mtk_clk_enable_critical(void)
 {
 	if (!mt8173_top_clk_data || !mt8173_pll_clk_data)
 		return;
 
-	clk_prepare_enable(mt8173_pll_clk_data->clks[CLK_APMIXED_ARMCA15PLL]);
-	clk_prepare_enable(mt8173_pll_clk_data->clks[CLK_APMIXED_ARMCA7PLL]);
-	clk_prepare_enable(mt8173_top_clk_data->clks[CLK_TOP_MEM_SEL]);
-	clk_prepare_enable(mt8173_top_clk_data->clks[CLK_TOP_DDRPHYCFG_SEL]);
-	clk_prepare_enable(mt8173_top_clk_data->clks[CLK_TOP_CCI400_SEL]);
-	clk_prepare_enable(mt8173_top_clk_data->clks[CLK_TOP_RTC_SEL]);
+	clk_prepare_enable(mt8173_pll_clk_data->hws[CLK_APMIXED_ARMCA15PLL]->clk);
+	clk_prepare_enable(mt8173_pll_clk_data->hws[CLK_APMIXED_ARMCA7PLL]->clk);
+	clk_prepare_enable(mt8173_top_clk_data->hws[CLK_TOP_MEM_SEL]->clk);
+	clk_prepare_enable(mt8173_top_clk_data->hws[CLK_TOP_DDRPHYCFG_SEL]->clk);
+	clk_prepare_enable(mt8173_top_clk_data->hws[CLK_TOP_CCI400_SEL]->clk);
+	clk_prepare_enable(mt8173_top_clk_data->hws[CLK_TOP_RTC_SEL]->clk);
 }
 
 static void __init mtk_topckgen_init(struct device_node *node)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	void __iomem *base;
 	int r;
 
@@ -854,7 +854,7 @@ static void __init mtk_topckgen_init(struct device_node *node)
 	mtk_clk_register_composites(top_muxes, ARRAY_SIZE(top_muxes), base,
 			&mt8173_clk_lock, clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
 		pr_err("%s(): could not register clock provider: %d\n",
 			__func__, r);
@@ -865,7 +865,7 @@ CLK_OF_DECLARE(mtk_topckgen, "mediatek,mt8173-topckgen", mtk_topckgen_init);
 
 static void __init mtk_infrasys_init(struct device_node *node)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	int r;
 
 	clk_data = mtk_alloc_clk_data(CLK_INFRA_NR_CLK);
@@ -877,7 +877,7 @@ static void __init mtk_infrasys_init(struct device_node *node)
 	mtk_clk_register_cpumuxes(node, cpu_muxes, ARRAY_SIZE(cpu_muxes),
 				  clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
 		pr_err("%s(): could not register clock provider: %d\n",
 			__func__, r);
@@ -888,7 +888,7 @@ CLK_OF_DECLARE(mtk_infrasys, "mediatek,mt8173-infracfg", mtk_infrasys_init);
 
 static void __init mtk_pericfg_init(struct device_node *node)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	int r;
 	void __iomem *base;
 
@@ -905,7 +905,7 @@ static void __init mtk_pericfg_init(struct device_node *node)
 	mtk_clk_register_composites(peri_clks, ARRAY_SIZE(peri_clks), base,
 			&mt8173_clk_lock, clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
 		pr_err("%s(): could not register clock provider: %d\n",
 			__func__, r);
@@ -991,7 +991,7 @@ static const struct mtk_pll_data plls[] = {
 
 static void __init mtk_apmixedsys_init(struct device_node *node)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	void __iomem *base;
 	struct clk *clk;
 	int r, i;
@@ -1022,15 +1022,15 @@ static void __init mtk_apmixedsys_init(struct device_node *node)
 			continue;
 		}
 
-		clk_data->clks[cku->id] = clk;
+		clk_data->hws[cku->id] = __clk_get_hw(clk);
 	}
 
 	clk = clk_register_divider(NULL, "hdmi_ref", "tvdpll_594m", 0,
 				   base + 0x40, 16, 3, CLK_DIVIDER_POWER_OF_TWO,
 				   NULL);
-	clk_data->clks[CLK_APMIXED_HDMI_REF] = clk;
+	clk_data->hws[CLK_APMIXED_HDMI_REF] = __clk_get_hw(clk);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
 		pr_err("%s(): could not register clock provider: %d\n",
 			__func__, r);
@@ -1042,7 +1042,7 @@ CLK_OF_DECLARE(mtk_apmixedsys, "mediatek,mt8173-apmixedsys",
 
 static void __init mtk_imgsys_init(struct device_node *node)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	int r;
 
 	clk_data = mtk_alloc_clk_data(CLK_IMG_NR_CLK);
@@ -1050,7 +1050,7 @@ static void __init mtk_imgsys_init(struct device_node *node)
 	mtk_clk_register_gates(node, img_clks, ARRAY_SIZE(img_clks),
 						clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 
 	if (r)
 		pr_err("%s(): could not register clock provider: %d\n",
@@ -1060,7 +1060,7 @@ CLK_OF_DECLARE(mtk_imgsys, "mediatek,mt8173-imgsys", mtk_imgsys_init);
 
 static void __init mtk_vdecsys_init(struct device_node *node)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	int r;
 
 	clk_data = mtk_alloc_clk_data(CLK_VDEC_NR_CLK);
@@ -1068,7 +1068,7 @@ static void __init mtk_vdecsys_init(struct device_node *node)
 	mtk_clk_register_gates(node, vdec_clks, ARRAY_SIZE(vdec_clks),
 						clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
 		pr_err("%s(): could not register clock provider: %d\n",
 			__func__, r);
@@ -1077,7 +1077,7 @@ CLK_OF_DECLARE(mtk_vdecsys, "mediatek,mt8173-vdecsys", mtk_vdecsys_init);
 
 static void __init mtk_vencsys_init(struct device_node *node)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	int r;
 
 	clk_data = mtk_alloc_clk_data(CLK_VENC_NR_CLK);
@@ -1085,7 +1085,7 @@ static void __init mtk_vencsys_init(struct device_node *node)
 	mtk_clk_register_gates(node, venc_clks, ARRAY_SIZE(venc_clks),
 						clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
 		pr_err("%s(): could not register clock provider: %d\n",
 			__func__, r);
@@ -1094,7 +1094,7 @@ CLK_OF_DECLARE(mtk_vencsys, "mediatek,mt8173-vencsys", mtk_vencsys_init);
 
 static void __init mtk_vencltsys_init(struct device_node *node)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	int r;
 
 	clk_data = mtk_alloc_clk_data(CLK_VENCLT_NR_CLK);
@@ -1102,7 +1102,7 @@ static void __init mtk_vencltsys_init(struct device_node *node)
 	mtk_clk_register_gates(node, venclt_clks, ARRAY_SIZE(venclt_clks),
 						clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
 		pr_err("%s(): could not register clock provider: %d\n",
 			__func__, r);
diff --git a/drivers/clk/mediatek/clk-mt8183-audio.c b/drivers/clk/mediatek/clk-mt8183-audio.c
index c87450180b7b..b2d7746eddbe 100644
--- a/drivers/clk/mediatek/clk-mt8183-audio.c
+++ b/drivers/clk/mediatek/clk-mt8183-audio.c
@@ -69,7 +69,7 @@ static const struct mtk_gate audio_clks[] = {
 
 static int clk_mt8183_audio_probe(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	int r;
 	struct device_node *node = pdev->dev.of_node;
 
@@ -78,7 +78,7 @@ static int clk_mt8183_audio_probe(struct platform_device *pdev)
 	mtk_clk_register_gates(node, audio_clks, ARRAY_SIZE(audio_clks),
 			clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
 		return r;
 
diff --git a/drivers/clk/mediatek/clk-mt8183-cam.c b/drivers/clk/mediatek/clk-mt8183-cam.c
index 8643802c4471..fcc598a45165 100644
--- a/drivers/clk/mediatek/clk-mt8183-cam.c
+++ b/drivers/clk/mediatek/clk-mt8183-cam.c
@@ -36,7 +36,7 @@ static const struct mtk_gate cam_clks[] = {
 
 static int clk_mt8183_cam_probe(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	struct device_node *node = pdev->dev.of_node;
 
 	clk_data = mtk_alloc_clk_data(CLK_CAM_NR_CLK);
@@ -44,7 +44,7 @@ static int clk_mt8183_cam_probe(struct platform_device *pdev)
 	mtk_clk_register_gates(node, cam_clks, ARRAY_SIZE(cam_clks),
 			clk_data);
 
-	return of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 }
 
 static const struct of_device_id of_match_clk_mt8183_cam[] = {
diff --git a/drivers/clk/mediatek/clk-mt8183-img.c b/drivers/clk/mediatek/clk-mt8183-img.c
index 470d676a4a10..eb2def2cf0ae 100644
--- a/drivers/clk/mediatek/clk-mt8183-img.c
+++ b/drivers/clk/mediatek/clk-mt8183-img.c
@@ -36,7 +36,7 @@ static const struct mtk_gate img_clks[] = {
 
 static int clk_mt8183_img_probe(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	struct device_node *node = pdev->dev.of_node;
 
 	clk_data = mtk_alloc_clk_data(CLK_IMG_NR_CLK);
@@ -44,7 +44,7 @@ static int clk_mt8183_img_probe(struct platform_device *pdev)
 	mtk_clk_register_gates(node, img_clks, ARRAY_SIZE(img_clks),
 			clk_data);
 
-	return of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 }
 
 static const struct of_device_id of_match_clk_mt8183_img[] = {
diff --git a/drivers/clk/mediatek/clk-mt8183-ipu0.c b/drivers/clk/mediatek/clk-mt8183-ipu0.c
index c5cb76fc9e5e..b30fc9f47518 100644
--- a/drivers/clk/mediatek/clk-mt8183-ipu0.c
+++ b/drivers/clk/mediatek/clk-mt8183-ipu0.c
@@ -29,7 +29,7 @@ static const struct mtk_gate ipu_core0_clks[] = {
 
 static int clk_mt8183_ipu_core0_probe(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	struct device_node *node = pdev->dev.of_node;
 
 	clk_data = mtk_alloc_clk_data(CLK_IPU_CORE0_NR_CLK);
@@ -37,7 +37,7 @@ static int clk_mt8183_ipu_core0_probe(struct platform_device *pdev)
 	mtk_clk_register_gates(node, ipu_core0_clks, ARRAY_SIZE(ipu_core0_clks),
 			clk_data);
 
-	return of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 }
 
 static const struct of_device_id of_match_clk_mt8183_ipu_core0[] = {
diff --git a/drivers/clk/mediatek/clk-mt8183-ipu1.c b/drivers/clk/mediatek/clk-mt8183-ipu1.c
index 8fd5fe002890..b378957e11d0 100644
--- a/drivers/clk/mediatek/clk-mt8183-ipu1.c
+++ b/drivers/clk/mediatek/clk-mt8183-ipu1.c
@@ -29,7 +29,7 @@ static const struct mtk_gate ipu_core1_clks[] = {
 
 static int clk_mt8183_ipu_core1_probe(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	struct device_node *node = pdev->dev.of_node;
 
 	clk_data = mtk_alloc_clk_data(CLK_IPU_CORE1_NR_CLK);
@@ -37,7 +37,7 @@ static int clk_mt8183_ipu_core1_probe(struct platform_device *pdev)
 	mtk_clk_register_gates(node, ipu_core1_clks, ARRAY_SIZE(ipu_core1_clks),
 			clk_data);
 
-	return of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 }
 
 static const struct of_device_id of_match_clk_mt8183_ipu_core1[] = {
diff --git a/drivers/clk/mediatek/clk-mt8183-ipu_adl.c b/drivers/clk/mediatek/clk-mt8183-ipu_adl.c
index 3f37d0ef1df1..941b43ac8bec 100644
--- a/drivers/clk/mediatek/clk-mt8183-ipu_adl.c
+++ b/drivers/clk/mediatek/clk-mt8183-ipu_adl.c
@@ -27,7 +27,7 @@ static const struct mtk_gate ipu_adl_clks[] = {
 
 static int clk_mt8183_ipu_adl_probe(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	struct device_node *node = pdev->dev.of_node;
 
 	clk_data = mtk_alloc_clk_data(CLK_IPU_ADL_NR_CLK);
@@ -35,7 +35,7 @@ static int clk_mt8183_ipu_adl_probe(struct platform_device *pdev)
 	mtk_clk_register_gates(node, ipu_adl_clks, ARRAY_SIZE(ipu_adl_clks),
 			clk_data);
 
-	return of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 }
 
 static const struct of_device_id of_match_clk_mt8183_ipu_adl[] = {
diff --git a/drivers/clk/mediatek/clk-mt8183-ipu_conn.c b/drivers/clk/mediatek/clk-mt8183-ipu_conn.c
index 7e0eef79c461..ae82c2e17110 100644
--- a/drivers/clk/mediatek/clk-mt8183-ipu_conn.c
+++ b/drivers/clk/mediatek/clk-mt8183-ipu_conn.c
@@ -96,7 +96,7 @@ static const struct mtk_gate ipu_conn_clks[] = {
 
 static int clk_mt8183_ipu_conn_probe(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	struct device_node *node = pdev->dev.of_node;
 
 	clk_data = mtk_alloc_clk_data(CLK_IPU_CONN_NR_CLK);
@@ -104,7 +104,7 @@ static int clk_mt8183_ipu_conn_probe(struct platform_device *pdev)
 	mtk_clk_register_gates(node, ipu_conn_clks, ARRAY_SIZE(ipu_conn_clks),
 			clk_data);
 
-	return of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 }
 
 static const struct of_device_id of_match_clk_mt8183_ipu_conn[] = {
diff --git a/drivers/clk/mediatek/clk-mt8183-mfgcfg.c b/drivers/clk/mediatek/clk-mt8183-mfgcfg.c
index 37b4162c5882..d774edaf760b 100644
--- a/drivers/clk/mediatek/clk-mt8183-mfgcfg.c
+++ b/drivers/clk/mediatek/clk-mt8183-mfgcfg.c
@@ -28,7 +28,7 @@ static const struct mtk_gate mfg_clks[] = {
 
 static int clk_mt8183_mfg_probe(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	struct device_node *node = pdev->dev.of_node;
 
 	pm_runtime_enable(&pdev->dev);
@@ -38,7 +38,7 @@ static int clk_mt8183_mfg_probe(struct platform_device *pdev)
 	mtk_clk_register_gates_with_dev(node, mfg_clks, ARRAY_SIZE(mfg_clks),
 			clk_data, &pdev->dev);
 
-	return of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 }
 
 static const struct of_device_id of_match_clk_mt8183_mfg[] = {
diff --git a/drivers/clk/mediatek/clk-mt8183-mm.c b/drivers/clk/mediatek/clk-mt8183-mm.c
index 9d60e09619c1..11ecc6fb0065 100644
--- a/drivers/clk/mediatek/clk-mt8183-mm.c
+++ b/drivers/clk/mediatek/clk-mt8183-mm.c
@@ -86,14 +86,14 @@ static int clk_mt8183_mm_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *node = dev->parent->of_node;
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 
 	clk_data = mtk_alloc_clk_data(CLK_MM_NR_CLK);
 
 	mtk_clk_register_gates(node, mm_clks, ARRAY_SIZE(mm_clks),
 			clk_data);
 
-	return of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 }
 
 static struct platform_driver clk_mt8183_mm_drv = {
diff --git a/drivers/clk/mediatek/clk-mt8183-vdec.c b/drivers/clk/mediatek/clk-mt8183-vdec.c
index 6250fd1e0edc..0548cde159d0 100644
--- a/drivers/clk/mediatek/clk-mt8183-vdec.c
+++ b/drivers/clk/mediatek/clk-mt8183-vdec.c
@@ -40,7 +40,7 @@ static const struct mtk_gate vdec_clks[] = {
 
 static int clk_mt8183_vdec_probe(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	struct device_node *node = pdev->dev.of_node;
 
 	clk_data = mtk_alloc_clk_data(CLK_VDEC_NR_CLK);
@@ -48,7 +48,7 @@ static int clk_mt8183_vdec_probe(struct platform_device *pdev)
 	mtk_clk_register_gates(node, vdec_clks, ARRAY_SIZE(vdec_clks),
 			clk_data);
 
-	return of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 }
 
 static const struct of_device_id of_match_clk_mt8183_vdec[] = {
diff --git a/drivers/clk/mediatek/clk-mt8183-venc.c b/drivers/clk/mediatek/clk-mt8183-venc.c
index 6678ef03fab2..f86ec607d87a 100644
--- a/drivers/clk/mediatek/clk-mt8183-venc.c
+++ b/drivers/clk/mediatek/clk-mt8183-venc.c
@@ -32,7 +32,7 @@ static const struct mtk_gate venc_clks[] = {
 
 static int clk_mt8183_venc_probe(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	struct device_node *node = pdev->dev.of_node;
 
 	clk_data = mtk_alloc_clk_data(CLK_VENC_NR_CLK);
@@ -40,7 +40,7 @@ static int clk_mt8183_venc_probe(struct platform_device *pdev)
 	mtk_clk_register_gates(node, venc_clks, ARRAY_SIZE(venc_clks),
 			clk_data);
 
-	return of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 }
 
 static const struct of_device_id of_match_clk_mt8183_venc[] = {
diff --git a/drivers/clk/mediatek/clk-mt8183.c b/drivers/clk/mediatek/clk-mt8183.c
index 68496554dd3d..8a755fadebb5 100644
--- a/drivers/clk/mediatek/clk-mt8183.c
+++ b/drivers/clk/mediatek/clk-mt8183.c
@@ -1155,7 +1155,7 @@ static const struct mtk_pll_data plls[] = {
 
 static int clk_mt8183_apmixed_probe(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	struct device_node *node = pdev->dev.of_node;
 
 	clk_data = mtk_alloc_clk_data(CLK_APMIXED_NR_CLK);
@@ -1165,10 +1165,10 @@ static int clk_mt8183_apmixed_probe(struct platform_device *pdev)
 	mtk_clk_register_gates(node, apmixed_clks, ARRAY_SIZE(apmixed_clks),
 		clk_data);
 
-	return of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 }
 
-static struct clk_onecell_data *top_clk_data;
+static struct clk_hw_onecell_data *top_clk_data;
 
 static void clk_mt8183_top_init_early(struct device_node *node)
 {
@@ -1177,12 +1177,12 @@ static void clk_mt8183_top_init_early(struct device_node *node)
 	top_clk_data = mtk_alloc_clk_data(CLK_TOP_NR_CLK);
 
 	for (i = 0; i < CLK_TOP_NR_CLK; i++)
-		top_clk_data->clks[i] = ERR_PTR(-EPROBE_DEFER);
+		top_clk_data->hws[i] = ERR_PTR(-EPROBE_DEFER);
 
 	mtk_clk_register_factors(top_early_divs, ARRAY_SIZE(top_early_divs),
 			top_clk_data);
 
-	of_clk_add_provider(node, of_clk_src_onecell_get, top_clk_data);
+	of_clk_add_hw_provider(node, of_clk_hw_onecell_get, top_clk_data);
 }
 
 CLK_OF_DECLARE_DRIVER(mt8183_topckgen, "mediatek,mt8183-topckgen",
@@ -1217,12 +1217,13 @@ static int clk_mt8183_top_probe(struct platform_device *pdev)
 	mtk_clk_register_gates(node, top_clks, ARRAY_SIZE(top_clks),
 		top_clk_data);
 
-	return of_clk_add_provider(node, of_clk_src_onecell_get, top_clk_data);
+	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get,
+				      top_clk_data);
 }
 
 static int clk_mt8183_infra_probe(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	struct device_node *node = pdev->dev.of_node;
 	int r;
 
@@ -1231,7 +1232,7 @@ static int clk_mt8183_infra_probe(struct platform_device *pdev)
 	mtk_clk_register_gates(node, infra_clks, ARRAY_SIZE(infra_clks),
 		clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r) {
 		dev_err(&pdev->dev,
 			"%s(): could not register clock provider: %d\n",
@@ -1246,7 +1247,7 @@ static int clk_mt8183_infra_probe(struct platform_device *pdev)
 
 static int clk_mt8183_peri_probe(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	struct device_node *node = pdev->dev.of_node;
 
 	clk_data = mtk_alloc_clk_data(CLK_PERI_NR_CLK);
@@ -1254,12 +1255,12 @@ static int clk_mt8183_peri_probe(struct platform_device *pdev)
 	mtk_clk_register_gates(node, peri_clks, ARRAY_SIZE(peri_clks),
 			       clk_data);
 
-	return of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 }
 
 static int clk_mt8183_mcu_probe(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	struct device_node *node = pdev->dev.of_node;
 	void __iomem *base;
 
@@ -1272,7 +1273,7 @@ static int clk_mt8183_mcu_probe(struct platform_device *pdev)
 	mtk_clk_register_composites(mcu_muxes, ARRAY_SIZE(mcu_muxes), base,
 			&mt8183_clk_lock, clk_data);
 
-	return of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 }
 
 static const struct of_device_id of_match_clk_mt8183[] = {
diff --git a/drivers/clk/mediatek/clk-mt8186-apmixedsys.c b/drivers/clk/mediatek/clk-mt8186-apmixedsys.c
index ab702c397a26..e692a2a67ce1 100644
--- a/drivers/clk/mediatek/clk-mt8186-apmixedsys.c
+++ b/drivers/clk/mediatek/clk-mt8186-apmixedsys.c
@@ -83,7 +83,7 @@ static const struct of_device_id of_match_clk_mt8186_apmixed[] = {
 
 static int clk_mt8186_apmixed_probe(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	struct device_node *node = pdev->dev.of_node;
 	int r;
 
@@ -95,7 +95,7 @@ static int clk_mt8186_apmixed_probe(struct platform_device *pdev)
 	if (r)
 		goto free_apmixed_data;
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
 		goto unregister_plls;
 
@@ -113,7 +113,7 @@ static int clk_mt8186_apmixed_probe(struct platform_device *pdev)
 static int clk_mt8186_apmixed_remove(struct platform_device *pdev)
 {
 	struct device_node *node = pdev->dev.of_node;
-	struct clk_onecell_data *clk_data = platform_get_drvdata(pdev);
+	struct clk_hw_onecell_data *clk_data = platform_get_drvdata(pdev);
 
 	of_clk_del_provider(node);
 	mtk_clk_unregister_plls(plls, ARRAY_SIZE(plls), clk_data);
diff --git a/drivers/clk/mediatek/clk-mt8186-mcu.c b/drivers/clk/mediatek/clk-mt8186-mcu.c
index 80835960f528..dfc305c1fc5d 100644
--- a/drivers/clk/mediatek/clk-mt8186-mcu.c
+++ b/drivers/clk/mediatek/clk-mt8186-mcu.c
@@ -50,7 +50,7 @@ static const struct of_device_id of_match_clk_mt8186_mcu[] = {
 
 static int clk_mt8186_mcu_probe(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	struct device_node *node = pdev->dev.of_node;
 	int r;
 	void __iomem *base;
@@ -70,7 +70,7 @@ static int clk_mt8186_mcu_probe(struct platform_device *pdev)
 	if (r)
 		goto free_mcu_data;
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
 		goto unregister_composite_muxes;
 
@@ -87,7 +87,7 @@ static int clk_mt8186_mcu_probe(struct platform_device *pdev)
 
 static int clk_mt8186_mcu_remove(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data = platform_get_drvdata(pdev);
+	struct clk_hw_onecell_data *clk_data = platform_get_drvdata(pdev);
 	struct device_node *node = pdev->dev.of_node;
 
 	of_clk_del_provider(node);
diff --git a/drivers/clk/mediatek/clk-mt8186-mm.c b/drivers/clk/mediatek/clk-mt8186-mm.c
index 7c5d0b582f59..1d33be407947 100644
--- a/drivers/clk/mediatek/clk-mt8186-mm.c
+++ b/drivers/clk/mediatek/clk-mt8186-mm.c
@@ -62,7 +62,7 @@ static int clk_mt8186_mm_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *node = dev->parent->of_node;
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	int r;
 
 	clk_data = mtk_alloc_clk_data(CLK_MM_NR_CLK);
@@ -73,7 +73,7 @@ static int clk_mt8186_mm_probe(struct platform_device *pdev)
 	if (r)
 		goto free_mm_data;
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
 		goto unregister_gates;
 
@@ -92,7 +92,7 @@ static int clk_mt8186_mm_remove(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *node = dev->parent->of_node;
-	struct clk_onecell_data *clk_data = platform_get_drvdata(pdev);
+	struct clk_hw_onecell_data *clk_data = platform_get_drvdata(pdev);
 
 	of_clk_del_provider(node);
 	mtk_clk_unregister_gates(mm_clks, ARRAY_SIZE(mm_clks), clk_data);
diff --git a/drivers/clk/mediatek/clk-mt8186-topckgen.c b/drivers/clk/mediatek/clk-mt8186-topckgen.c
index 005d1997f6f4..d7f2c4663c85 100644
--- a/drivers/clk/mediatek/clk-mt8186-topckgen.c
+++ b/drivers/clk/mediatek/clk-mt8186-topckgen.c
@@ -691,7 +691,7 @@ static const struct of_device_id of_match_clk_mt8186_topck[] = {
 
 static int clk_mt8186_topck_probe(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	struct device_node *node = pdev->dev.of_node;
 	int r;
 	void __iomem *base;
@@ -730,7 +730,7 @@ static int clk_mt8186_topck_probe(struct platform_device *pdev)
 	if (r)
 		goto unregister_composite_muxes;
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
 		goto unregister_composite_divs;
 
@@ -755,7 +755,7 @@ static int clk_mt8186_topck_probe(struct platform_device *pdev)
 
 static int clk_mt8186_topck_remove(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data = platform_get_drvdata(pdev);
+	struct clk_hw_onecell_data *clk_data = platform_get_drvdata(pdev);
 	struct device_node *node = pdev->dev.of_node;
 
 	of_clk_del_provider(node);
diff --git a/drivers/clk/mediatek/clk-mt8192-aud.c b/drivers/clk/mediatek/clk-mt8192-aud.c
index f28d56628045..8c989bffd8c7 100644
--- a/drivers/clk/mediatek/clk-mt8192-aud.c
+++ b/drivers/clk/mediatek/clk-mt8192-aud.c
@@ -79,7 +79,7 @@ static const struct mtk_gate aud_clks[] = {
 
 static int clk_mt8192_aud_probe(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	struct device_node *node = pdev->dev.of_node;
 	int r;
 
@@ -91,7 +91,7 @@ static int clk_mt8192_aud_probe(struct platform_device *pdev)
 	if (r)
 		return r;
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
 		return r;
 
diff --git a/drivers/clk/mediatek/clk-mt8192-mm.c b/drivers/clk/mediatek/clk-mt8192-mm.c
index 4a0b4c4bc06a..1be3ff4d407d 100644
--- a/drivers/clk/mediatek/clk-mt8192-mm.c
+++ b/drivers/clk/mediatek/clk-mt8192-mm.c
@@ -84,7 +84,7 @@ static int clk_mt8192_mm_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *node = dev->parent->of_node;
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	int r;
 
 	clk_data = mtk_alloc_clk_data(CLK_MM_NR_CLK);
@@ -95,7 +95,7 @@ static int clk_mt8192_mm_probe(struct platform_device *pdev)
 	if (r)
 		return r;
 
-	return of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 }
 
 static struct platform_driver clk_mt8192_mm_drv = {
diff --git a/drivers/clk/mediatek/clk-mt8192.c b/drivers/clk/mediatek/clk-mt8192.c
index ab27cd66b866..dda211b7a745 100644
--- a/drivers/clk/mediatek/clk-mt8192.c
+++ b/drivers/clk/mediatek/clk-mt8192.c
@@ -1178,7 +1178,7 @@ static const struct mtk_pll_data plls[] = {
 	      0, 0, 32, 0x0330, 24, 0, 0, 0, 0x0334, 0),
 };
 
-static struct clk_onecell_data *top_clk_data;
+static struct clk_hw_onecell_data *top_clk_data;
 
 static void clk_mt8192_top_init_early(struct device_node *node)
 {
@@ -1189,11 +1189,11 @@ static void clk_mt8192_top_init_early(struct device_node *node)
 		return;
 
 	for (i = 0; i < CLK_TOP_NR_CLK; i++)
-		top_clk_data->clks[i] = ERR_PTR(-EPROBE_DEFER);
+		top_clk_data->hws[i] = ERR_PTR(-EPROBE_DEFER);
 
 	mtk_clk_register_factors(top_early_divs, ARRAY_SIZE(top_early_divs), top_clk_data);
 
-	of_clk_add_provider(node, of_clk_src_onecell_get, top_clk_data);
+	of_clk_add_hw_provider(node, of_clk_hw_onecell_get, top_clk_data);
 }
 
 CLK_OF_DECLARE_DRIVER(mt8192_topckgen, "mediatek,mt8192-topckgen",
@@ -1222,12 +1222,13 @@ static int clk_mt8192_top_probe(struct platform_device *pdev)
 	if (r)
 		return r;
 
-	return of_clk_add_provider(node, of_clk_src_onecell_get, top_clk_data);
+	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get,
+				      top_clk_data);
 }
 
 static int clk_mt8192_infra_probe(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	struct device_node *node = pdev->dev.of_node;
 	int r;
 
@@ -1239,7 +1240,7 @@ static int clk_mt8192_infra_probe(struct platform_device *pdev)
 	if (r)
 		goto free_clk_data;
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
 		goto free_clk_data;
 
@@ -1252,7 +1253,7 @@ static int clk_mt8192_infra_probe(struct platform_device *pdev)
 
 static int clk_mt8192_peri_probe(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	struct device_node *node = pdev->dev.of_node;
 	int r;
 
@@ -1264,7 +1265,7 @@ static int clk_mt8192_peri_probe(struct platform_device *pdev)
 	if (r)
 		goto free_clk_data;
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
 		goto free_clk_data;
 
@@ -1277,7 +1278,7 @@ static int clk_mt8192_peri_probe(struct platform_device *pdev)
 
 static int clk_mt8192_apmixed_probe(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	struct device_node *node = pdev->dev.of_node;
 	int r;
 
@@ -1290,7 +1291,7 @@ static int clk_mt8192_apmixed_probe(struct platform_device *pdev)
 	if (r)
 		goto free_clk_data;
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
 		goto free_clk_data;
 
diff --git a/drivers/clk/mediatek/clk-mt8195-apmixedsys.c b/drivers/clk/mediatek/clk-mt8195-apmixedsys.c
index eecc7035a56a..0dfed6ec4d15 100644
--- a/drivers/clk/mediatek/clk-mt8195-apmixedsys.c
+++ b/drivers/clk/mediatek/clk-mt8195-apmixedsys.c
@@ -112,7 +112,7 @@ static const struct of_device_id of_match_clk_mt8195_apmixed[] = {
 
 static int clk_mt8195_apmixed_probe(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	struct device_node *node = pdev->dev.of_node;
 	int r;
 
@@ -128,7 +128,7 @@ static int clk_mt8195_apmixed_probe(struct platform_device *pdev)
 	if (r)
 		goto unregister_plls;
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
 		goto unregister_gates;
 
@@ -148,7 +148,7 @@ static int clk_mt8195_apmixed_probe(struct platform_device *pdev)
 static int clk_mt8195_apmixed_remove(struct platform_device *pdev)
 {
 	struct device_node *node = pdev->dev.of_node;
-	struct clk_onecell_data *clk_data = platform_get_drvdata(pdev);
+	struct clk_hw_onecell_data *clk_data = platform_get_drvdata(pdev);
 
 	of_clk_del_provider(node);
 	mtk_clk_unregister_gates(apmixed_clks, ARRAY_SIZE(apmixed_clks), clk_data);
diff --git a/drivers/clk/mediatek/clk-mt8195-apusys_pll.c b/drivers/clk/mediatek/clk-mt8195-apusys_pll.c
index 8cd88dfc3283..0b52f6a009c4 100644
--- a/drivers/clk/mediatek/clk-mt8195-apusys_pll.c
+++ b/drivers/clk/mediatek/clk-mt8195-apusys_pll.c
@@ -58,7 +58,7 @@ static const struct mtk_pll_data apusys_plls[] = {
 
 static int clk_mt8195_apusys_pll_probe(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	struct device_node *node = pdev->dev.of_node;
 	int r;
 
@@ -70,7 +70,7 @@ static int clk_mt8195_apusys_pll_probe(struct platform_device *pdev)
 	if (r)
 		goto free_apusys_pll_data;
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
 		goto unregister_plls;
 
@@ -87,7 +87,7 @@ static int clk_mt8195_apusys_pll_probe(struct platform_device *pdev)
 
 static int clk_mt8195_apusys_pll_remove(struct platform_device *pdev)
 {
-	struct clk_onecell_data *clk_data = platform_get_drvdata(pdev);
+	struct clk_hw_onecell_data *clk_data = platform_get_drvdata(pdev);
 	struct device_node *node = pdev->dev.of_node;
 
 	of_clk_del_provider(node);
diff --git a/drivers/clk/mediatek/clk-mt8195-topckgen.c b/drivers/clk/mediatek/clk-mt8195-topckgen.c
index b602fcd7f1d1..ec70e1f65eaf 100644
--- a/drivers/clk/mediatek/clk-mt8195-topckgen.c
+++ b/drivers/clk/mediatek/clk-mt8195-topckgen.c
@@ -1224,7 +1224,7 @@ static const struct of_device_id of_match_clk_mt8195_topck[] = {
 
 static int clk_mt8195_topck_probe(struct platform_device *pdev)
 {
-	struct clk_onecell_data *top_clk_data;
+	struct clk_hw_onecell_data *top_clk_data;
 	struct device_node *node = pdev->dev.of_node;
 	int r;
 	void __iomem *base;
@@ -1267,7 +1267,7 @@ static int clk_mt8195_topck_probe(struct platform_device *pdev)
 	if (r)
 		goto unregister_composite_divs;
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, top_clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, top_clk_data);
 	if (r)
 		goto unregister_gates;
 
@@ -1294,7 +1294,7 @@ static int clk_mt8195_topck_probe(struct platform_device *pdev)
 
 static int clk_mt8195_topck_remove(struct platform_device *pdev)
 {
-	struct clk_onecell_data *top_clk_data = platform_get_drvdata(pdev);
+	struct clk_hw_onecell_data *top_clk_data = platform_get_drvdata(pdev);
 	struct device_node *node = pdev->dev.of_node;
 
 	of_clk_del_provider(node);
diff --git a/drivers/clk/mediatek/clk-mt8195-vdo0.c b/drivers/clk/mediatek/clk-mt8195-vdo0.c
index 3bc7ed19d550..261a7f76dd3c 100644
--- a/drivers/clk/mediatek/clk-mt8195-vdo0.c
+++ b/drivers/clk/mediatek/clk-mt8195-vdo0.c
@@ -92,7 +92,7 @@ static int clk_mt8195_vdo0_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *node = dev->parent->of_node;
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	int r;
 
 	clk_data = mtk_alloc_clk_data(CLK_VDO0_NR_CLK);
@@ -103,7 +103,7 @@ static int clk_mt8195_vdo0_probe(struct platform_device *pdev)
 	if (r)
 		goto free_vdo0_data;
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
 		goto unregister_gates;
 
@@ -122,7 +122,7 @@ static int clk_mt8195_vdo0_remove(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *node = dev->parent->of_node;
-	struct clk_onecell_data *clk_data = platform_get_drvdata(pdev);
+	struct clk_hw_onecell_data *clk_data = platform_get_drvdata(pdev);
 
 	of_clk_del_provider(node);
 	mtk_clk_unregister_gates(vdo0_clks, ARRAY_SIZE(vdo0_clks), clk_data);
diff --git a/drivers/clk/mediatek/clk-mt8195-vdo1.c b/drivers/clk/mediatek/clk-mt8195-vdo1.c
index 90c738a85ff1..3378487d2c90 100644
--- a/drivers/clk/mediatek/clk-mt8195-vdo1.c
+++ b/drivers/clk/mediatek/clk-mt8195-vdo1.c
@@ -109,7 +109,7 @@ static int clk_mt8195_vdo1_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *node = dev->parent->of_node;
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	int r;
 
 	clk_data = mtk_alloc_clk_data(CLK_VDO1_NR_CLK);
@@ -120,7 +120,7 @@ static int clk_mt8195_vdo1_probe(struct platform_device *pdev)
 	if (r)
 		goto free_vdo1_data;
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
 		goto unregister_gates;
 
@@ -139,7 +139,7 @@ static int clk_mt8195_vdo1_remove(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *node = dev->parent->of_node;
-	struct clk_onecell_data *clk_data = platform_get_drvdata(pdev);
+	struct clk_hw_onecell_data *clk_data = platform_get_drvdata(pdev);
 
 	of_clk_del_provider(node);
 	mtk_clk_unregister_gates(vdo1_clks, ARRAY_SIZE(vdo1_clks), clk_data);
diff --git a/drivers/clk/mediatek/clk-mt8516-aud.c b/drivers/clk/mediatek/clk-mt8516-aud.c
index 6ab3a06dc9d5..90f48068a8de 100644
--- a/drivers/clk/mediatek/clk-mt8516-aud.c
+++ b/drivers/clk/mediatek/clk-mt8516-aud.c
@@ -49,14 +49,14 @@ static const struct mtk_gate aud_clks[] __initconst = {
 
 static void __init mtk_audsys_init(struct device_node *node)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	int r;
 
 	clk_data = mtk_alloc_clk_data(CLK_AUD_NR_CLK);
 
 	mtk_clk_register_gates(node, aud_clks, ARRAY_SIZE(aud_clks), clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
 		pr_err("%s(): could not register clock provider: %d\n",
 			__func__, r);
diff --git a/drivers/clk/mediatek/clk-mt8516.c b/drivers/clk/mediatek/clk-mt8516.c
index a37143f920ce..2507d18df9ee 100644
--- a/drivers/clk/mediatek/clk-mt8516.c
+++ b/drivers/clk/mediatek/clk-mt8516.c
@@ -677,7 +677,7 @@ static const struct mtk_gate top_clks[] __initconst = {
 
 static void __init mtk_topckgen_init(struct device_node *node)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	int r;
 	void __iomem *base;
 
@@ -699,7 +699,7 @@ static void __init mtk_topckgen_init(struct device_node *node)
 	mtk_clk_register_dividers(top_adj_divs, ARRAY_SIZE(top_adj_divs),
 				base, &mt8516_clk_lock, clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
 		pr_err("%s(): could not register clock provider: %d\n",
 			__func__, r);
@@ -708,7 +708,7 @@ CLK_OF_DECLARE(mtk_topckgen, "mediatek,mt8516-topckgen", mtk_topckgen_init);
 
 static void __init mtk_infracfg_init(struct device_node *node)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	int r;
 	void __iomem *base;
 
@@ -723,7 +723,7 @@ static void __init mtk_infracfg_init(struct device_node *node)
 	mtk_clk_register_composites(ifr_muxes, ARRAY_SIZE(ifr_muxes), base,
 		&mt8516_clk_lock, clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
 		pr_err("%s(): could not register clock provider: %d\n",
 			__func__, r);
@@ -787,7 +787,7 @@ static const struct mtk_pll_data plls[] = {
 
 static void __init mtk_apmixedsys_init(struct device_node *node)
 {
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	void __iomem *base;
 	int r;
 
@@ -801,7 +801,7 @@ static void __init mtk_apmixedsys_init(struct device_node *node)
 
 	mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls), clk_data);
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
 		pr_err("%s(): could not register clock provider: %d\n",
 			__func__, r);
-- 
2.36.0.512.ge40c2bad7a-goog

