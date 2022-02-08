Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 557C74AD93B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 14:17:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350335AbiBHNQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 08:16:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358082AbiBHMkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 07:40:52 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A6FC03FECA
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 04:40:51 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id g15-20020a17090a67cf00b001b7d5b6bedaso2594269pjm.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 04:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AG7JP3PmNd1EdvNHfZQCnHdtS8h0RT7R6zED7dijliQ=;
        b=GkXiVgi6P5XFN318B4BLQ2z310OMACd/EFqC0tE2le1ZztIwJf+SnhUObQ+MJ6zT7V
         OLbpf4T0ja8OkynRbZKfQaCGIDjxoJBrMhsMzolUyb3NOaW04IwjA6WtrnoUWyM4wiKR
         v0xJbLOT7/3dz/zdmYDLa22LLdOh01xQgk+T0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AG7JP3PmNd1EdvNHfZQCnHdtS8h0RT7R6zED7dijliQ=;
        b=nh3bcBKHeRJH/WWw2YfCGnmUxJA+g6WvsuX4tfEm+wRkH2q4Rr3W6HX4ZAIFq3KGdy
         6svy1qF7uE70k44FCd+0zUyOQot6euR1Oh7gp9Z/rJfIn6UzBhLv7jMvCwrI9OrpPA77
         zjfpnSJ5i+6kLST2lODOMVBw1/Fsk0zLsBPEmf5B8sF84wwZy6ED/Th08ceKNZ88ESiU
         CL6JrAwGkZ2h4vKyUT+yjNZa2Rh0cJL0A6Ar9Iq1b9SFz53hNxgLW6MrEWIMLeXlMCCp
         iFEVx3OEHhw6yyAQ8OJY5++xlI88aKwnpnoopkAi07j1+aRtsBT5u+fyDf1J0wU+Klrw
         6pXw==
X-Gm-Message-State: AOAM533ZxDuh5LYhD3nn11Suk8LmNxX0LpVwPKzeqqCzoKigG/wgBtMQ
        xID7b5OkDV1RsPeV23ADAVDYzA==
X-Google-Smtp-Source: ABdhPJwuFITGMv7hSWZiicKfreHbP0qxbpac0MmUj3+5Sa/OT+2vcrS0hRAdQj2Rs2AtUEpwXQ9cxw==
X-Received: by 2002:a17:902:ce8b:: with SMTP id f11mr4348415plg.40.1644324051390;
        Tue, 08 Feb 2022 04:40:51 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:41b6:813e:c823:609c])
        by smtp.gmail.com with ESMTPSA id h11sm15056939pfe.214.2022.02.08.04.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 04:40:51 -0800 (PST)
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
Subject: [PATCH v3 01/31] clk: mediatek: Use %pe to print errors
Date:   Tue,  8 Feb 2022 20:40:04 +0800
Message-Id: <20220208124034.414635-2-wenst@chromium.org>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
In-Reply-To: <20220208124034.414635-1-wenst@chromium.org>
References: <20220208124034.414635-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If %pe is used to print errors, a string representation of the error
would be printed instead of a number as with %ld. Also, all the sites
printing errors are deriving the error code from a pointer. Using %pe
is more straightforward.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: Miles Chen <miles.chen@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/clk/mediatek/clk-apmixed.c |  2 +-
 drivers/clk/mediatek/clk-cpumux.c  |  6 ++----
 drivers/clk/mediatek/clk-mtk.c     | 18 ++++++------------
 drivers/clk/mediatek/clk-mux.c     |  6 ++----
 drivers/clk/mediatek/clk-pll.c     |  3 +--
 drivers/clk/mediatek/reset.c       |  3 +--
 6 files changed, 13 insertions(+), 25 deletions(-)

diff --git a/drivers/clk/mediatek/clk-apmixed.c b/drivers/clk/mediatek/clk-apmixed.c
index caa9119413f1..a29339cc26c4 100644
--- a/drivers/clk/mediatek/clk-apmixed.c
+++ b/drivers/clk/mediatek/clk-apmixed.c
@@ -92,7 +92,7 @@ struct clk * __init mtk_clk_register_ref2usb_tx(const char *name,
 	clk = clk_register(NULL, &tx->hw);
 
 	if (IS_ERR(clk)) {
-		pr_err("Failed to register clk %s: %ld\n", name, PTR_ERR(clk));
+		pr_err("Failed to register clk %s: %pe\n", name, clk);
 		kfree(tx);
 	}
 
diff --git a/drivers/clk/mediatek/clk-cpumux.c b/drivers/clk/mediatek/clk-cpumux.c
index e188018bc906..cab5095416b6 100644
--- a/drivers/clk/mediatek/clk-cpumux.c
+++ b/drivers/clk/mediatek/clk-cpumux.c
@@ -87,8 +87,7 @@ int mtk_clk_register_cpumuxes(struct device_node *node,
 
 	regmap = device_node_to_regmap(node);
 	if (IS_ERR(regmap)) {
-		pr_err("Cannot find regmap for %pOF: %ld\n", node,
-		       PTR_ERR(regmap));
+		pr_err("Cannot find regmap for %pOF: %pe\n", node, regmap);
 		return PTR_ERR(regmap);
 	}
 
@@ -97,8 +96,7 @@ int mtk_clk_register_cpumuxes(struct device_node *node,
 
 		clk = mtk_clk_register_cpumux(mux, regmap);
 		if (IS_ERR(clk)) {
-			pr_err("Failed to register clk %s: %ld\n",
-			       mux->name, PTR_ERR(clk));
+			pr_err("Failed to register clk %s: %pe\n", mux->name, clk);
 			continue;
 		}
 
diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index 8d5791b3f460..519a461cbb6f 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -70,8 +70,7 @@ void mtk_clk_register_fixed_clks(const struct mtk_fixed_clk *clks,
 					      rc->rate);
 
 		if (IS_ERR(clk)) {
-			pr_err("Failed to register clk %s: %ld\n",
-					rc->name, PTR_ERR(clk));
+			pr_err("Failed to register clk %s: %pe\n", rc->name, clk);
 			continue;
 		}
 
@@ -97,8 +96,7 @@ void mtk_clk_register_factors(const struct mtk_fixed_factor *clks,
 				CLK_SET_RATE_PARENT, ff->mult, ff->div);
 
 		if (IS_ERR(clk)) {
-			pr_err("Failed to register clk %s: %ld\n",
-					ff->name, PTR_ERR(clk));
+			pr_err("Failed to register clk %s: %pe\n", ff->name, clk);
 			continue;
 		}
 
@@ -122,8 +120,7 @@ int mtk_clk_register_gates_with_dev(struct device_node *node,
 
 	regmap = device_node_to_regmap(node);
 	if (IS_ERR(regmap)) {
-		pr_err("Cannot find regmap for %pOF: %ld\n", node,
-				PTR_ERR(regmap));
+		pr_err("Cannot find regmap for %pOF: %pe\n", node, regmap);
 		return PTR_ERR(regmap);
 	}
 
@@ -141,8 +138,7 @@ int mtk_clk_register_gates_with_dev(struct device_node *node,
 				gate->shift, gate->ops, gate->flags, dev);
 
 		if (IS_ERR(clk)) {
-			pr_err("Failed to register clk %s: %ld\n",
-					gate->name, PTR_ERR(clk));
+			pr_err("Failed to register clk %s: %pe\n", gate->name, clk);
 			continue;
 		}
 
@@ -264,8 +260,7 @@ void mtk_clk_register_composites(const struct mtk_composite *mcs,
 		clk = mtk_clk_register_composite(mc, base, lock);
 
 		if (IS_ERR(clk)) {
-			pr_err("Failed to register clk %s: %ld\n",
-					mc->name, PTR_ERR(clk));
+			pr_err("Failed to register clk %s: %pe\n", mc->name, clk);
 			continue;
 		}
 
@@ -293,8 +288,7 @@ void mtk_clk_register_dividers(const struct mtk_clk_divider *mcds,
 			mcd->div_width, mcd->clk_divider_flags, lock);
 
 		if (IS_ERR(clk)) {
-			pr_err("Failed to register clk %s: %ld\n",
-				mcd->name, PTR_ERR(clk));
+			pr_err("Failed to register clk %s: %pe\n", mcd->name, clk);
 			continue;
 		}
 
diff --git a/drivers/clk/mediatek/clk-mux.c b/drivers/clk/mediatek/clk-mux.c
index 6d3a50eb7d6f..89f23e111d91 100644
--- a/drivers/clk/mediatek/clk-mux.c
+++ b/drivers/clk/mediatek/clk-mux.c
@@ -175,8 +175,7 @@ int mtk_clk_register_muxes(const struct mtk_mux *muxes,
 
 	regmap = device_node_to_regmap(node);
 	if (IS_ERR(regmap)) {
-		pr_err("Cannot find regmap for %pOF: %ld\n", node,
-		       PTR_ERR(regmap));
+		pr_err("Cannot find regmap for %pOF: %pe\n", node, regmap);
 		return PTR_ERR(regmap);
 	}
 
@@ -187,8 +186,7 @@ int mtk_clk_register_muxes(const struct mtk_mux *muxes,
 			clk = mtk_clk_register_mux(mux, regmap, lock);
 
 			if (IS_ERR(clk)) {
-				pr_err("Failed to register clk %s: %ld\n",
-				       mux->name, PTR_ERR(clk));
+				pr_err("Failed to register clk %s: %pe\n", mux->name, clk);
 				continue;
 			}
 
diff --git a/drivers/clk/mediatek/clk-pll.c b/drivers/clk/mediatek/clk-pll.c
index 60d7ffa0b924..f04f724e12e5 100644
--- a/drivers/clk/mediatek/clk-pll.c
+++ b/drivers/clk/mediatek/clk-pll.c
@@ -378,8 +378,7 @@ void mtk_clk_register_plls(struct device_node *node,
 		clk = mtk_clk_register_pll(pll, base);
 
 		if (IS_ERR(clk)) {
-			pr_err("Failed to register clk %s: %ld\n",
-					pll->name, PTR_ERR(clk));
+			pr_err("Failed to register clk %s: %pe\n", pll->name, clk);
 			continue;
 		}
 
diff --git a/drivers/clk/mediatek/reset.c b/drivers/clk/mediatek/reset.c
index ffe464ce7ff8..bcec4b89f449 100644
--- a/drivers/clk/mediatek/reset.c
+++ b/drivers/clk/mediatek/reset.c
@@ -100,8 +100,7 @@ static void mtk_register_reset_controller_common(struct device_node *np,
 
 	regmap = device_node_to_regmap(np);
 	if (IS_ERR(regmap)) {
-		pr_err("Cannot find regmap for %pOF: %ld\n", np,
-				PTR_ERR(regmap));
+		pr_err("Cannot find regmap for %pOF: %pe\n", np, regmap);
 		return;
 	}
 
-- 
2.35.0.263.gb82422642f-goog

