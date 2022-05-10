Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF05E52129B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 12:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240180AbiEJKwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 06:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240088AbiEJKwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 06:52:34 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E7A28F1E6
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 03:48:21 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d17so16427523plg.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 03:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CPAM6En0Eaiq4lV6Q1C1gdN8iEMQNDwZldNRCQ3f+2I=;
        b=KNdqBZ8Exfa3ad4ifcszZUH8HxWc3Z4MyQtdPcYm9MSfN/kEmM+dCl9o8DmHXWIglA
         cgqLPfkUoGuho/QuGnhmBt6Zg6CQLkw2InRnPuXFHB8RZdnfmkkgm6YIHMr30a/NSSjO
         7PR1e+VxL5+NPplse3hBJfxqxeCinvvtCFL44=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CPAM6En0Eaiq4lV6Q1C1gdN8iEMQNDwZldNRCQ3f+2I=;
        b=7V1/poZ3m/Tvq5sWAwMEVT2ReCOg30yUUCSGDPgQLDphvVoHidZa3JD8kJtTx4taK2
         z7q0BeYa2SFw1/+Tx4ygCkrGBnLA0rQ3tao7zDNh5b15FinaOxNuBV06mMysDLKbyfGe
         XusCMcfMY3b57F3JoV27T6IjDeQ2ULUSYiWe/MkaXNY9mbVwVYnfFHwk48VKfWUbC8Dw
         dAJ3nswZg8CA4/JMxVdTWBDWIIhtYpxOK0GaLur8CziCt+BlJm/K2Crvx4ngG4cZbTuG
         7DJHdldKiMipefcspqTxbOufJOvilBwBWe52rozg+xV/1GEUy9aVtz341G04Np+gi//0
         gGWA==
X-Gm-Message-State: AOAM533IrOAsL/rVye2u3i6sFdIXQ66lYMjQG8YveIkG/ozkwyKoyNPu
        uC0Y53+xa+NsH/rJylbcAJ6n/w==
X-Google-Smtp-Source: ABdhPJyx1g1jCU9X2twrQERQwOv3K53NGt1PZedj5eW0CW1FX+FrWmJpOm0308cA2bWqxWgaKGQaUA==
X-Received: by 2002:a17:902:ef46:b0:153:81f7:7fc2 with SMTP id e6-20020a170902ef4600b0015381f77fc2mr20256507plx.26.1652179701312;
        Tue, 10 May 2022 03:48:21 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:6dcd:8578:55cf:2b12])
        by smtp.gmail.com with ESMTPSA id q9-20020a170902e30900b0015e8d4eb21esm1659691plc.104.2022.05.10.03.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 03:48:21 -0700 (PDT)
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
Subject: [PATCH v2 04/11] clk: mediatek: Replace 'struct clk' with 'struct clk_hw'
Date:   Tue, 10 May 2022 18:47:57 +0800
Message-Id: <20220510104804.544597-5-wenst@chromium.org>
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
ones. This patch covers the common MediaTek clk library.

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
 drivers/clk/mediatek/clk-cpumux.c | 20 +++----
 drivers/clk/mediatek/clk-cpumux.h |  6 +--
 drivers/clk/mediatek/clk-gate.c   | 22 ++++----
 drivers/clk/mediatek/clk-gate.h   |  8 +--
 drivers/clk/mediatek/clk-mtk.c    | 88 +++++++++++++++----------------
 drivers/clk/mediatek/clk-mtk.h    | 16 +++---
 drivers/clk/mediatek/clk-mux.c    | 20 +++----
 drivers/clk/mediatek/clk-mux.h    |  6 +--
 drivers/clk/mediatek/clk-pll.c    | 23 ++++----
 drivers/clk/mediatek/clk-pll.h    |  6 +--
 10 files changed, 107 insertions(+), 108 deletions(-)

diff --git a/drivers/clk/mediatek/clk-cpumux.c b/drivers/clk/mediatek/clk-cpumux.c
index c11b3fae622e..8e80df43e356 100644
--- a/drivers/clk/mediatek/clk-cpumux.c
+++ b/drivers/clk/mediatek/clk-cpumux.c
@@ -105,7 +105,7 @@ static void mtk_clk_unregister_cpumux(struct clk *clk)
 
 int mtk_clk_register_cpumuxes(struct device_node *node,
 			      const struct mtk_composite *clks, int num,
-			      struct clk_onecell_data *clk_data)
+			      struct clk_hw_onecell_data *clk_data)
 {
 	int i;
 	struct clk *clk;
@@ -120,7 +120,7 @@ int mtk_clk_register_cpumuxes(struct device_node *node,
 	for (i = 0; i < num; i++) {
 		const struct mtk_composite *mux = &clks[i];
 
-		if (!IS_ERR_OR_NULL(clk_data->clks[mux->id])) {
+		if (!IS_ERR_OR_NULL(clk_data->hws[mux->id])) {
 			pr_warn("%pOF: Trying to register duplicate clock ID: %d\n",
 				node, mux->id);
 			continue;
@@ -132,7 +132,7 @@ int mtk_clk_register_cpumuxes(struct device_node *node,
 			goto err;
 		}
 
-		clk_data->clks[mux->id] = clk;
+		clk_data->hws[mux->id] = __clk_get_hw(clk);
 	}
 
 	return 0;
@@ -141,29 +141,29 @@ int mtk_clk_register_cpumuxes(struct device_node *node,
 	while (--i >= 0) {
 		const struct mtk_composite *mux = &clks[i];
 
-		if (IS_ERR_OR_NULL(clk_data->clks[mux->id]))
+		if (IS_ERR_OR_NULL(clk_data->hws[mux->id]))
 			continue;
 
-		mtk_clk_unregister_cpumux(clk_data->clks[mux->id]);
-		clk_data->clks[mux->id] = ERR_PTR(-ENOENT);
+		mtk_clk_unregister_cpumux(clk_data->hws[mux->id]->clk);
+		clk_data->hws[mux->id] = ERR_PTR(-ENOENT);
 	}
 
 	return PTR_ERR(clk);
 }
 
 void mtk_clk_unregister_cpumuxes(const struct mtk_composite *clks, int num,
-				 struct clk_onecell_data *clk_data)
+				 struct clk_hw_onecell_data *clk_data)
 {
 	int i;
 
 	for (i = num; i > 0; i--) {
 		const struct mtk_composite *mux = &clks[i - 1];
 
-		if (IS_ERR_OR_NULL(clk_data->clks[mux->id]))
+		if (IS_ERR_OR_NULL(clk_data->hws[mux->id]))
 			continue;
 
-		mtk_clk_unregister_cpumux(clk_data->clks[mux->id]);
-		clk_data->clks[mux->id] = ERR_PTR(-ENOENT);
+		mtk_clk_unregister_cpumux(clk_data->hws[mux->id]->clk);
+		clk_data->hws[mux->id] = ERR_PTR(-ENOENT);
 	}
 }
 
diff --git a/drivers/clk/mediatek/clk-cpumux.h b/drivers/clk/mediatek/clk-cpumux.h
index b07e89f7c283..325adbef25d1 100644
--- a/drivers/clk/mediatek/clk-cpumux.h
+++ b/drivers/clk/mediatek/clk-cpumux.h
@@ -7,15 +7,15 @@
 #ifndef __DRV_CLK_CPUMUX_H
 #define __DRV_CLK_CPUMUX_H
 
-struct clk_onecell_data;
+struct clk_hw_onecell_data;
 struct device_node;
 struct mtk_composite;
 
 int mtk_clk_register_cpumuxes(struct device_node *node,
 			      const struct mtk_composite *clks, int num,
-			      struct clk_onecell_data *clk_data);
+			      struct clk_hw_onecell_data *clk_data);
 
 void mtk_clk_unregister_cpumuxes(const struct mtk_composite *clks, int num,
-				 struct clk_onecell_data *clk_data);
+				 struct clk_hw_onecell_data *clk_data);
 
 #endif /* __DRV_CLK_CPUMUX_H */
diff --git a/drivers/clk/mediatek/clk-gate.c b/drivers/clk/mediatek/clk-gate.c
index da52023f8455..0955cace5b1b 100644
--- a/drivers/clk/mediatek/clk-gate.c
+++ b/drivers/clk/mediatek/clk-gate.c
@@ -205,7 +205,7 @@ static void mtk_clk_unregister_gate(struct clk *clk)
 
 int mtk_clk_register_gates_with_dev(struct device_node *node,
 				    const struct mtk_gate *clks, int num,
-				    struct clk_onecell_data *clk_data,
+				    struct clk_hw_onecell_data *clk_data,
 				    struct device *dev)
 {
 	int i;
@@ -224,7 +224,7 @@ int mtk_clk_register_gates_with_dev(struct device_node *node,
 	for (i = 0; i < num; i++) {
 		const struct mtk_gate *gate = &clks[i];
 
-		if (!IS_ERR_OR_NULL(clk_data->clks[gate->id])) {
+		if (!IS_ERR_OR_NULL(clk_data->hws[gate->id])) {
 			pr_warn("%pOF: Trying to register duplicate clock ID: %d\n",
 				node, gate->id);
 			continue;
@@ -243,7 +243,7 @@ int mtk_clk_register_gates_with_dev(struct device_node *node,
 			goto err;
 		}
 
-		clk_data->clks[gate->id] = clk;
+		clk_data->hws[gate->id] = __clk_get_hw(clk);
 	}
 
 	return 0;
@@ -252,11 +252,11 @@ int mtk_clk_register_gates_with_dev(struct device_node *node,
 	while (--i >= 0) {
 		const struct mtk_gate *gate = &clks[i];
 
-		if (IS_ERR_OR_NULL(clk_data->clks[gate->id]))
+		if (IS_ERR_OR_NULL(clk_data->hws[gate->id]))
 			continue;
 
-		mtk_clk_unregister_gate(clk_data->clks[gate->id]);
-		clk_data->clks[gate->id] = ERR_PTR(-ENOENT);
+		mtk_clk_unregister_gate(clk_data->hws[gate->id]->clk);
+		clk_data->hws[gate->id] = ERR_PTR(-ENOENT);
 	}
 
 	return PTR_ERR(clk);
@@ -264,14 +264,14 @@ int mtk_clk_register_gates_with_dev(struct device_node *node,
 
 int mtk_clk_register_gates(struct device_node *node,
 			   const struct mtk_gate *clks, int num,
-			   struct clk_onecell_data *clk_data)
+			   struct clk_hw_onecell_data *clk_data)
 {
 	return mtk_clk_register_gates_with_dev(node, clks, num, clk_data, NULL);
 }
 EXPORT_SYMBOL_GPL(mtk_clk_register_gates);
 
 void mtk_clk_unregister_gates(const struct mtk_gate *clks, int num,
-			      struct clk_onecell_data *clk_data)
+			      struct clk_hw_onecell_data *clk_data)
 {
 	int i;
 
@@ -281,11 +281,11 @@ void mtk_clk_unregister_gates(const struct mtk_gate *clks, int num,
 	for (i = num; i > 0; i--) {
 		const struct mtk_gate *gate = &clks[i - 1];
 
-		if (IS_ERR_OR_NULL(clk_data->clks[gate->id]))
+		if (IS_ERR_OR_NULL(clk_data->hws[gate->id]))
 			continue;
 
-		mtk_clk_unregister_gate(clk_data->clks[gate->id]);
-		clk_data->clks[gate->id] = ERR_PTR(-ENOENT);
+		mtk_clk_unregister_gate(clk_data->hws[gate->id]->clk);
+		clk_data->hws[gate->id] = ERR_PTR(-ENOENT);
 	}
 }
 EXPORT_SYMBOL_GPL(mtk_clk_unregister_gates);
diff --git a/drivers/clk/mediatek/clk-gate.h b/drivers/clk/mediatek/clk-gate.h
index 6b5738826a22..d9897ef53528 100644
--- a/drivers/clk/mediatek/clk-gate.h
+++ b/drivers/clk/mediatek/clk-gate.h
@@ -10,7 +10,7 @@
 #include <linux/types.h>
 
 struct clk;
-struct clk_onecell_data;
+struct clk_hw_onecell_data;
 struct clk_ops;
 struct device;
 struct device_node;
@@ -52,14 +52,14 @@ struct mtk_gate {
 
 int mtk_clk_register_gates(struct device_node *node,
 			   const struct mtk_gate *clks, int num,
-			   struct clk_onecell_data *clk_data);
+			   struct clk_hw_onecell_data *clk_data);
 
 int mtk_clk_register_gates_with_dev(struct device_node *node,
 				    const struct mtk_gate *clks, int num,
-				    struct clk_onecell_data *clk_data,
+				    struct clk_hw_onecell_data *clk_data,
 				    struct device *dev);
 
 void mtk_clk_unregister_gates(const struct mtk_gate *clks, int num,
-			      struct clk_onecell_data *clk_data);
+			      struct clk_hw_onecell_data *clk_data);
 
 #endif /* __DRV_CLK_GATE_H */
diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index 554c6a128460..cfcf740e4e68 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -21,7 +21,7 @@
 struct clk_hw_onecell_data *mtk_alloc_clk_data(unsigned int clk_num)
 {
 	int i;
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 
 	clk_data = kzalloc(struct_size(clk_data, hws, clk_num), GFP_KERNEL);
 	if (!clk_data)
@@ -43,7 +43,7 @@ void mtk_free_clk_data(struct clk_hw_onecell_data *clk_data)
 EXPORT_SYMBOL_GPL(mtk_free_clk_data);
 
 int mtk_clk_register_fixed_clks(const struct mtk_fixed_clk *clks, int num,
-				struct clk_onecell_data *clk_data)
+				struct clk_hw_onecell_data *clk_data)
 {
 	int i;
 	struct clk *clk;
@@ -54,7 +54,7 @@ int mtk_clk_register_fixed_clks(const struct mtk_fixed_clk *clks, int num,
 	for (i = 0; i < num; i++) {
 		const struct mtk_fixed_clk *rc = &clks[i];
 
-		if (!IS_ERR_OR_NULL(clk_data->clks[rc->id])) {
+		if (!IS_ERR_OR_NULL(clk_data->hws[rc->id])) {
 			pr_warn("Trying to register duplicate clock ID: %d\n", rc->id);
 			continue;
 		}
@@ -67,7 +67,7 @@ int mtk_clk_register_fixed_clks(const struct mtk_fixed_clk *clks, int num,
 			goto err;
 		}
 
-		clk_data->clks[rc->id] = clk;
+		clk_data->hws[rc->id] = __clk_get_hw(clk);
 	}
 
 	return 0;
@@ -76,11 +76,11 @@ int mtk_clk_register_fixed_clks(const struct mtk_fixed_clk *clks, int num,
 	while (--i >= 0) {
 		const struct mtk_fixed_clk *rc = &clks[i];
 
-		if (IS_ERR_OR_NULL(clk_data->clks[rc->id]))
+		if (IS_ERR_OR_NULL(clk_data->hws[rc->id]))
 			continue;
 
-		clk_unregister_fixed_rate(clk_data->clks[rc->id]);
-		clk_data->clks[rc->id] = ERR_PTR(-ENOENT);
+		clk_unregister_fixed_rate(clk_data->hws[rc->id]->clk);
+		clk_data->hws[rc->id] = ERR_PTR(-ENOENT);
 	}
 
 	return PTR_ERR(clk);
@@ -88,7 +88,7 @@ int mtk_clk_register_fixed_clks(const struct mtk_fixed_clk *clks, int num,
 EXPORT_SYMBOL_GPL(mtk_clk_register_fixed_clks);
 
 void mtk_clk_unregister_fixed_clks(const struct mtk_fixed_clk *clks, int num,
-				   struct clk_onecell_data *clk_data)
+				   struct clk_hw_onecell_data *clk_data)
 {
 	int i;
 
@@ -98,17 +98,17 @@ void mtk_clk_unregister_fixed_clks(const struct mtk_fixed_clk *clks, int num,
 	for (i = num; i > 0; i--) {
 		const struct mtk_fixed_clk *rc = &clks[i - 1];
 
-		if (IS_ERR_OR_NULL(clk_data->clks[rc->id]))
+		if (IS_ERR_OR_NULL(clk_data->hws[rc->id]))
 			continue;
 
-		clk_unregister_fixed_rate(clk_data->clks[rc->id]);
-		clk_data->clks[rc->id] = ERR_PTR(-ENOENT);
+		clk_unregister_fixed_rate(clk_data->hws[rc->id]->clk);
+		clk_data->hws[rc->id] = ERR_PTR(-ENOENT);
 	}
 }
 EXPORT_SYMBOL_GPL(mtk_clk_unregister_fixed_clks);
 
 int mtk_clk_register_factors(const struct mtk_fixed_factor *clks, int num,
-			     struct clk_onecell_data *clk_data)
+			     struct clk_hw_onecell_data *clk_data)
 {
 	int i;
 	struct clk *clk;
@@ -119,7 +119,7 @@ int mtk_clk_register_factors(const struct mtk_fixed_factor *clks, int num,
 	for (i = 0; i < num; i++) {
 		const struct mtk_fixed_factor *ff = &clks[i];
 
-		if (!IS_ERR_OR_NULL(clk_data->clks[ff->id])) {
+		if (!IS_ERR_OR_NULL(clk_data->hws[ff->id])) {
 			pr_warn("Trying to register duplicate clock ID: %d\n", ff->id);
 			continue;
 		}
@@ -132,7 +132,7 @@ int mtk_clk_register_factors(const struct mtk_fixed_factor *clks, int num,
 			goto err;
 		}
 
-		clk_data->clks[ff->id] = clk;
+		clk_data->hws[ff->id] = __clk_get_hw(clk);
 	}
 
 	return 0;
@@ -141,11 +141,11 @@ int mtk_clk_register_factors(const struct mtk_fixed_factor *clks, int num,
 	while (--i >= 0) {
 		const struct mtk_fixed_factor *ff = &clks[i];
 
-		if (IS_ERR_OR_NULL(clk_data->clks[ff->id]))
+		if (IS_ERR_OR_NULL(clk_data->hws[ff->id]))
 			continue;
 
-		clk_unregister_fixed_factor(clk_data->clks[ff->id]);
-		clk_data->clks[ff->id] = ERR_PTR(-ENOENT);
+		clk_unregister_fixed_factor(clk_data->hws[ff->id]->clk);
+		clk_data->hws[ff->id] = ERR_PTR(-ENOENT);
 	}
 
 	return PTR_ERR(clk);
@@ -153,7 +153,7 @@ int mtk_clk_register_factors(const struct mtk_fixed_factor *clks, int num,
 EXPORT_SYMBOL_GPL(mtk_clk_register_factors);
 
 void mtk_clk_unregister_factors(const struct mtk_fixed_factor *clks, int num,
-				struct clk_onecell_data *clk_data)
+				struct clk_hw_onecell_data *clk_data)
 {
 	int i;
 
@@ -163,11 +163,11 @@ void mtk_clk_unregister_factors(const struct mtk_fixed_factor *clks, int num,
 	for (i = num; i > 0; i--) {
 		const struct mtk_fixed_factor *ff = &clks[i - 1];
 
-		if (IS_ERR_OR_NULL(clk_data->clks[ff->id]))
+		if (IS_ERR_OR_NULL(clk_data->hws[ff->id]))
 			continue;
 
-		clk_unregister_fixed_factor(clk_data->clks[ff->id]);
-		clk_data->clks[ff->id] = ERR_PTR(-ENOENT);
+		clk_unregister_fixed_factor(clk_data->hws[ff->id]->clk);
+		clk_data->hws[ff->id] = ERR_PTR(-ENOENT);
 	}
 }
 EXPORT_SYMBOL_GPL(mtk_clk_unregister_factors);
@@ -287,7 +287,7 @@ static void mtk_clk_unregister_composite(struct clk *clk)
 
 int mtk_clk_register_composites(const struct mtk_composite *mcs, int num,
 				void __iomem *base, spinlock_t *lock,
-				struct clk_onecell_data *clk_data)
+				struct clk_hw_onecell_data *clk_data)
 {
 	struct clk *clk;
 	int i;
@@ -298,7 +298,7 @@ int mtk_clk_register_composites(const struct mtk_composite *mcs, int num,
 	for (i = 0; i < num; i++) {
 		const struct mtk_composite *mc = &mcs[i];
 
-		if (!IS_ERR_OR_NULL(clk_data->clks[mc->id])) {
+		if (!IS_ERR_OR_NULL(clk_data->hws[mc->id])) {
 			pr_warn("Trying to register duplicate clock ID: %d\n",
 				mc->id);
 			continue;
@@ -311,7 +311,7 @@ int mtk_clk_register_composites(const struct mtk_composite *mcs, int num,
 			goto err;
 		}
 
-		clk_data->clks[mc->id] = clk;
+		clk_data->hws[mc->id] = __clk_get_hw(clk);
 	}
 
 	return 0;
@@ -320,11 +320,11 @@ int mtk_clk_register_composites(const struct mtk_composite *mcs, int num,
 	while (--i >= 0) {
 		const struct mtk_composite *mc = &mcs[i];
 
-		if (IS_ERR_OR_NULL(clk_data->clks[mcs->id]))
+		if (IS_ERR_OR_NULL(clk_data->hws[mcs->id]))
 			continue;
 
-		mtk_clk_unregister_composite(clk_data->clks[mc->id]);
-		clk_data->clks[mc->id] = ERR_PTR(-ENOENT);
+		mtk_clk_unregister_composite(clk_data->hws[mc->id]->clk);
+		clk_data->hws[mc->id] = ERR_PTR(-ENOENT);
 	}
 
 	return PTR_ERR(clk);
@@ -332,7 +332,7 @@ int mtk_clk_register_composites(const struct mtk_composite *mcs, int num,
 EXPORT_SYMBOL_GPL(mtk_clk_register_composites);
 
 void mtk_clk_unregister_composites(const struct mtk_composite *mcs, int num,
-				   struct clk_onecell_data *clk_data)
+				   struct clk_hw_onecell_data *clk_data)
 {
 	int i;
 
@@ -342,18 +342,18 @@ void mtk_clk_unregister_composites(const struct mtk_composite *mcs, int num,
 	for (i = num; i > 0; i--) {
 		const struct mtk_composite *mc = &mcs[i - 1];
 
-		if (IS_ERR_OR_NULL(clk_data->clks[mc->id]))
+		if (IS_ERR_OR_NULL(clk_data->hws[mc->id]))
 			continue;
 
-		mtk_clk_unregister_composite(clk_data->clks[mc->id]);
-		clk_data->clks[mc->id] = ERR_PTR(-ENOENT);
+		mtk_clk_unregister_composite(clk_data->hws[mc->id]->clk);
+		clk_data->hws[mc->id] = ERR_PTR(-ENOENT);
 	}
 }
 EXPORT_SYMBOL_GPL(mtk_clk_unregister_composites);
 
 int mtk_clk_register_dividers(const struct mtk_clk_divider *mcds, int num,
 			      void __iomem *base, spinlock_t *lock,
-			      struct clk_onecell_data *clk_data)
+			      struct clk_hw_onecell_data *clk_data)
 {
 	struct clk *clk;
 	int i;
@@ -364,7 +364,7 @@ int mtk_clk_register_dividers(const struct mtk_clk_divider *mcds, int num,
 	for (i = 0; i <  num; i++) {
 		const struct mtk_clk_divider *mcd = &mcds[i];
 
-		if (!IS_ERR_OR_NULL(clk_data->clks[mcd->id])) {
+		if (!IS_ERR_OR_NULL(clk_data->hws[mcd->id])) {
 			pr_warn("Trying to register duplicate clock ID: %d\n",
 				mcd->id);
 			continue;
@@ -379,7 +379,7 @@ int mtk_clk_register_dividers(const struct mtk_clk_divider *mcds, int num,
 			goto err;
 		}
 
-		clk_data->clks[mcd->id] = clk;
+		clk_data->hws[mcd->id] = __clk_get_hw(clk);
 	}
 
 	return 0;
@@ -388,18 +388,18 @@ int mtk_clk_register_dividers(const struct mtk_clk_divider *mcds, int num,
 	while (--i >= 0) {
 		const struct mtk_clk_divider *mcd = &mcds[i];
 
-		if (IS_ERR_OR_NULL(clk_data->clks[mcd->id]))
+		if (IS_ERR_OR_NULL(clk_data->hws[mcd->id]))
 			continue;
 
-		mtk_clk_unregister_composite(clk_data->clks[mcd->id]);
-		clk_data->clks[mcd->id] = ERR_PTR(-ENOENT);
+		mtk_clk_unregister_composite(clk_data->hws[mcd->id]->clk);
+		clk_data->hws[mcd->id] = ERR_PTR(-ENOENT);
 	}
 
 	return PTR_ERR(clk);
 }
 
 void mtk_clk_unregister_dividers(const struct mtk_clk_divider *mcds, int num,
-				 struct clk_onecell_data *clk_data)
+				 struct clk_hw_onecell_data *clk_data)
 {
 	int i;
 
@@ -409,18 +409,18 @@ void mtk_clk_unregister_dividers(const struct mtk_clk_divider *mcds, int num,
 	for (i = num; i > 0; i--) {
 		const struct mtk_clk_divider *mcd = &mcds[i - 1];
 
-		if (IS_ERR_OR_NULL(clk_data->clks[mcd->id]))
+		if (IS_ERR_OR_NULL(clk_data->hws[mcd->id]))
 			continue;
 
-		clk_unregister_divider(clk_data->clks[mcd->id]);
-		clk_data->clks[mcd->id] = ERR_PTR(-ENOENT);
+		clk_unregister_divider(clk_data->hws[mcd->id]->clk);
+		clk_data->hws[mcd->id] = ERR_PTR(-ENOENT);
 	}
 }
 
 int mtk_clk_simple_probe(struct platform_device *pdev)
 {
 	const struct mtk_clk_desc *mcd;
-	struct clk_onecell_data *clk_data;
+	struct clk_hw_onecell_data *clk_data;
 	struct device_node *node = pdev->dev.of_node;
 	int r;
 
@@ -436,7 +436,7 @@ int mtk_clk_simple_probe(struct platform_device *pdev)
 	if (r)
 		goto free_data;
 
-	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
 		goto unregister_clks;
 
@@ -454,7 +454,7 @@ int mtk_clk_simple_probe(struct platform_device *pdev)
 int mtk_clk_simple_remove(struct platform_device *pdev)
 {
 	const struct mtk_clk_desc *mcd = of_device_get_match_data(&pdev->dev);
-	struct clk_onecell_data *clk_data = platform_get_drvdata(pdev);
+	struct clk_hw_onecell_data *clk_data = platform_get_drvdata(pdev);
 	struct device_node *node = pdev->dev.of_node;
 
 	of_clk_del_provider(node);
diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index 787fdeb1bd93..e736420170a2 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -35,9 +35,9 @@ struct mtk_fixed_clk {
 	}
 
 int mtk_clk_register_fixed_clks(const struct mtk_fixed_clk *clks, int num,
-				struct clk_onecell_data *clk_data);
+				struct clk_hw_onecell_data *clk_data);
 void mtk_clk_unregister_fixed_clks(const struct mtk_fixed_clk *clks, int num,
-				   struct clk_onecell_data *clk_data);
+				   struct clk_hw_onecell_data *clk_data);
 
 struct mtk_fixed_factor {
 	int id;
@@ -56,9 +56,9 @@ struct mtk_fixed_factor {
 	}
 
 int mtk_clk_register_factors(const struct mtk_fixed_factor *clks, int num,
-			     struct clk_onecell_data *clk_data);
+			     struct clk_hw_onecell_data *clk_data);
 void mtk_clk_unregister_factors(const struct mtk_fixed_factor *clks, int num,
-				struct clk_onecell_data *clk_data);
+				struct clk_hw_onecell_data *clk_data);
 
 struct mtk_composite {
 	int id;
@@ -149,9 +149,9 @@ struct mtk_composite {
 
 int mtk_clk_register_composites(const struct mtk_composite *mcs, int num,
 				void __iomem *base, spinlock_t *lock,
-				struct clk_onecell_data *clk_data);
+				struct clk_hw_onecell_data *clk_data);
 void mtk_clk_unregister_composites(const struct mtk_composite *mcs, int num,
-				   struct clk_onecell_data *clk_data);
+				   struct clk_hw_onecell_data *clk_data);
 
 struct mtk_clk_divider {
 	int id;
@@ -177,9 +177,9 @@ struct mtk_clk_divider {
 
 int mtk_clk_register_dividers(const struct mtk_clk_divider *mcds, int num,
 			      void __iomem *base, spinlock_t *lock,
-			      struct clk_onecell_data *clk_data);
+			      struct clk_hw_onecell_data *clk_data);
 void mtk_clk_unregister_dividers(const struct mtk_clk_divider *mcds, int num,
-				 struct clk_onecell_data *clk_data);
+				 struct clk_hw_onecell_data *clk_data);
 
 struct clk_hw_onecell_data *mtk_alloc_clk_data(unsigned int clk_num);
 void mtk_free_clk_data(struct clk_hw_onecell_data *clk_data);
diff --git a/drivers/clk/mediatek/clk-mux.c b/drivers/clk/mediatek/clk-mux.c
index 21ad5a4afd65..2f47e59cc528 100644
--- a/drivers/clk/mediatek/clk-mux.c
+++ b/drivers/clk/mediatek/clk-mux.c
@@ -193,7 +193,7 @@ static void mtk_clk_unregister_mux(struct clk *clk)
 int mtk_clk_register_muxes(const struct mtk_mux *muxes,
 			   int num, struct device_node *node,
 			   spinlock_t *lock,
-			   struct clk_onecell_data *clk_data)
+			   struct clk_hw_onecell_data *clk_data)
 {
 	struct regmap *regmap;
 	struct clk *clk;
@@ -208,7 +208,7 @@ int mtk_clk_register_muxes(const struct mtk_mux *muxes,
 	for (i = 0; i < num; i++) {
 		const struct mtk_mux *mux = &muxes[i];
 
-		if (!IS_ERR_OR_NULL(clk_data->clks[mux->id])) {
+		if (!IS_ERR_OR_NULL(clk_data->hws[mux->id])) {
 			pr_warn("%pOF: Trying to register duplicate clock ID: %d\n",
 				node, mux->id);
 			continue;
@@ -221,7 +221,7 @@ int mtk_clk_register_muxes(const struct mtk_mux *muxes,
 			goto err;
 		}
 
-		clk_data->clks[mux->id] = clk;
+		clk_data->hws[mux->id] = __clk_get_hw(clk);
 	}
 
 	return 0;
@@ -230,11 +230,11 @@ int mtk_clk_register_muxes(const struct mtk_mux *muxes,
 	while (--i >= 0) {
 		const struct mtk_mux *mux = &muxes[i];
 
-		if (IS_ERR_OR_NULL(clk_data->clks[mux->id]))
+		if (IS_ERR_OR_NULL(clk_data->hws[mux->id]))
 			continue;
 
-		mtk_clk_unregister_mux(clk_data->clks[mux->id]);
-		clk_data->clks[mux->id] = ERR_PTR(-ENOENT);
+		mtk_clk_unregister_mux(clk_data->hws[mux->id]->clk);
+		clk_data->hws[mux->id] = ERR_PTR(-ENOENT);
 	}
 
 	return PTR_ERR(clk);
@@ -242,7 +242,7 @@ int mtk_clk_register_muxes(const struct mtk_mux *muxes,
 EXPORT_SYMBOL_GPL(mtk_clk_register_muxes);
 
 void mtk_clk_unregister_muxes(const struct mtk_mux *muxes, int num,
-			      struct clk_onecell_data *clk_data)
+			      struct clk_hw_onecell_data *clk_data)
 {
 	int i;
 
@@ -252,11 +252,11 @@ void mtk_clk_unregister_muxes(const struct mtk_mux *muxes, int num,
 	for (i = num; i > 0; i--) {
 		const struct mtk_mux *mux = &muxes[i - 1];
 
-		if (IS_ERR_OR_NULL(clk_data->clks[mux->id]))
+		if (IS_ERR_OR_NULL(clk_data->hws[mux->id]))
 			continue;
 
-		mtk_clk_unregister_mux(clk_data->clks[mux->id]);
-		clk_data->clks[mux->id] = ERR_PTR(-ENOENT);
+		mtk_clk_unregister_mux(clk_data->hws[mux->id]->clk);
+		clk_data->hws[mux->id] = ERR_PTR(-ENOENT);
 	}
 }
 EXPORT_SYMBOL_GPL(mtk_clk_unregister_muxes);
diff --git a/drivers/clk/mediatek/clk-mux.h b/drivers/clk/mediatek/clk-mux.h
index 903a3c937959..6539c58f5d7d 100644
--- a/drivers/clk/mediatek/clk-mux.h
+++ b/drivers/clk/mediatek/clk-mux.h
@@ -11,7 +11,7 @@
 #include <linux/types.h>
 
 struct clk;
-struct clk_onecell_data;
+struct clk_hw_onecell_data;
 struct clk_ops;
 struct device_node;
 
@@ -84,9 +84,9 @@ extern const struct clk_ops mtk_mux_gate_clr_set_upd_ops;
 int mtk_clk_register_muxes(const struct mtk_mux *muxes,
 			   int num, struct device_node *node,
 			   spinlock_t *lock,
-			   struct clk_onecell_data *clk_data);
+			   struct clk_hw_onecell_data *clk_data);
 
 void mtk_clk_unregister_muxes(const struct mtk_mux *muxes, int num,
-			      struct clk_onecell_data *clk_data);
+			      struct clk_hw_onecell_data *clk_data);
 
 #endif /* __DRV_CLK_MTK_MUX_H */
diff --git a/drivers/clk/mediatek/clk-pll.c b/drivers/clk/mediatek/clk-pll.c
index ccaa2085ab4d..89350a1a158c 100644
--- a/drivers/clk/mediatek/clk-pll.c
+++ b/drivers/clk/mediatek/clk-pll.c
@@ -379,7 +379,7 @@ static void mtk_clk_unregister_pll(struct clk *clk)
 
 int mtk_clk_register_plls(struct device_node *node,
 			  const struct mtk_pll_data *plls, int num_plls,
-			  struct clk_onecell_data *clk_data)
+			  struct clk_hw_onecell_data *clk_data)
 {
 	void __iomem *base;
 	int i;
@@ -394,7 +394,7 @@ int mtk_clk_register_plls(struct device_node *node,
 	for (i = 0; i < num_plls; i++) {
 		const struct mtk_pll_data *pll = &plls[i];
 
-		if (!IS_ERR_OR_NULL(clk_data->clks[pll->id])) {
+		if (!IS_ERR_OR_NULL(clk_data->hws[pll->id])) {
 			pr_warn("%pOF: Trying to register duplicate clock ID: %d\n",
 				node, pll->id);
 			continue;
@@ -407,7 +407,7 @@ int mtk_clk_register_plls(struct device_node *node,
 			goto err;
 		}
 
-		clk_data->clks[pll->id] = clk;
+		clk_data->hws[pll->id] = __clk_get_hw(clk);
 	}
 
 	return 0;
@@ -416,8 +416,8 @@ int mtk_clk_register_plls(struct device_node *node,
 	while (--i >= 0) {
 		const struct mtk_pll_data *pll = &plls[i];
 
-		mtk_clk_unregister_pll(clk_data->clks[pll->id]);
-		clk_data->clks[pll->id] = ERR_PTR(-ENOENT);
+		mtk_clk_unregister_pll(clk_data->hws[pll->id]->clk);
+		clk_data->hws[pll->id] = ERR_PTR(-ENOENT);
 	}
 
 	iounmap(base);
@@ -426,17 +426,16 @@ int mtk_clk_register_plls(struct device_node *node,
 }
 EXPORT_SYMBOL_GPL(mtk_clk_register_plls);
 
-static __iomem void *mtk_clk_pll_get_base(struct clk *clk,
+static __iomem void *mtk_clk_pll_get_base(struct clk_hw *hw,
 					  const struct mtk_pll_data *data)
 {
-	struct clk_hw *hw = __clk_get_hw(clk);
 	struct mtk_clk_pll *pll = to_mtk_clk_pll(hw);
 
 	return pll->base_addr - data->reg;
 }
 
 void mtk_clk_unregister_plls(const struct mtk_pll_data *plls, int num_plls,
-			     struct clk_onecell_data *clk_data)
+			     struct clk_hw_onecell_data *clk_data)
 {
 	__iomem void *base = NULL;
 	int i;
@@ -447,7 +446,7 @@ void mtk_clk_unregister_plls(const struct mtk_pll_data *plls, int num_plls,
 	for (i = num_plls; i > 0; i--) {
 		const struct mtk_pll_data *pll = &plls[i - 1];
 
-		if (IS_ERR_OR_NULL(clk_data->clks[pll->id]))
+		if (IS_ERR_OR_NULL(clk_data->hws[pll->id]))
 			continue;
 
 		/*
@@ -456,10 +455,10 @@ void mtk_clk_unregister_plls(const struct mtk_pll_data *plls, int num_plls,
 		 * pointer to the I/O region base address. We have to fetch
 		 * it from one of the registered clks.
 		 */
-		base = mtk_clk_pll_get_base(clk_data->clks[pll->id], pll);
+		base = mtk_clk_pll_get_base(clk_data->hws[pll->id], pll);
 
-		mtk_clk_unregister_pll(clk_data->clks[pll->id]);
-		clk_data->clks[pll->id] = ERR_PTR(-ENOENT);
+		mtk_clk_unregister_pll(clk_data->hws[pll->id]->clk);
+		clk_data->hws[pll->id] = ERR_PTR(-ENOENT);
 	}
 
 	iounmap(base);
diff --git a/drivers/clk/mediatek/clk-pll.h b/drivers/clk/mediatek/clk-pll.h
index bf06e44caef9..fe3199715688 100644
--- a/drivers/clk/mediatek/clk-pll.h
+++ b/drivers/clk/mediatek/clk-pll.h
@@ -10,7 +10,7 @@
 #include <linux/types.h>
 
 struct clk_ops;
-struct clk_onecell_data;
+struct clk_hw_onecell_data;
 struct device_node;
 
 struct mtk_pll_div_table {
@@ -50,8 +50,8 @@ struct mtk_pll_data {
 
 int mtk_clk_register_plls(struct device_node *node,
 			  const struct mtk_pll_data *plls, int num_plls,
-			  struct clk_onecell_data *clk_data);
+			  struct clk_hw_onecell_data *clk_data);
 void mtk_clk_unregister_plls(const struct mtk_pll_data *plls, int num_plls,
-			     struct clk_onecell_data *clk_data);
+			     struct clk_hw_onecell_data *clk_data);
 
 #endif /* __DRV_CLK_MTK_PLL_H */
-- 
2.36.0.512.ge40c2bad7a-goog

