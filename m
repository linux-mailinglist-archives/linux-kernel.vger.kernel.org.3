Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D18252D531
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 15:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236258AbiESNye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 09:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239342AbiESNvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 09:51:00 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 959B1DE32C;
        Thu, 19 May 2022 06:50:28 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id 135so2214234qkm.4;
        Thu, 19 May 2022 06:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qy/P0mZ00noEySeWC/Vtvod18+b1z4lRDAbgjrxSrfI=;
        b=a5OHjJtkOOGvIu6jZg5QA09ruZ+iHD24h5fVYngt/TjqtTTtS84PiyZlRz3xbOX+eD
         WYaR6T3dx8+SI+vY3m21XylsDLqE1I0gH8Pcmu8+tg/Y2HcWzlCGZIBFV+Pnv2R1G7Yg
         TzcmYw8ckLZEgzeEibAId7f8tdQP3TlAXUV1/8OU629u7HDhspdgFjBfpSxfgcXzgMl7
         WnJ+CrTotBnBDsyW/Ne5SAeFkzmMaSfZiFcE8tigc83LAWw25lST6C/ZblpyJ8en1x10
         Teb65uwJy1pCJlj+0W6WLZDLdTK6DKkwyg0eOWo6dxTwAIOf6NmdTaBw3QcZGJOsIcky
         O9WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qy/P0mZ00noEySeWC/Vtvod18+b1z4lRDAbgjrxSrfI=;
        b=oXqsZU+JjiOVtR4/TSEg8LdFLK28eFj9b36Tns6O0NRtHjW7L4kiYVEPCS9bYAIK9O
         Li5Bihm141DR3fedXmQjnC1skQLZJ8X964rMTPAFKOd+ZGdJHL1Jz67222HFmPghroBa
         nUNsOO80IiNRw4fKdwyZqP3JmzE6BK+03sA8HsHQVlsMtjzGHTy29HXeTHgD4A5VFD5b
         OCRDIjKWTTcim8Gct1Of3mUONhlFueBLmpel/dKYNpVK1fETJs6VL7aayd8IzHoBFbWk
         kKhZGSprcGGfupTfkN6IWwNMd0ji+bbakiZGdWcJf+RBPQlaDX0y7XOz3A70/SjioZlc
         +Q5g==
X-Gm-Message-State: AOAM530gwi0vTLBdJVqOtWXnwAiLrguK+nV2ViLINSUhV0IRpheYbNbY
        1t2CvUhsIhAzpOE3JoLWXjA=
X-Google-Smtp-Source: ABdhPJwtEj+JJRio5QYmwvU2cAJtTQu5mDAibXeOd2Nt2uRks/gnWgo29yFyhbRaE2j2y8DH8STX7w==
X-Received: by 2002:a05:620a:29ce:b0:6a0:2338:2fbe with SMTP id s14-20020a05620a29ce00b006a023382fbemr3115971qkp.315.1652968201971;
        Thu, 19 May 2022 06:50:01 -0700 (PDT)
Received: from localhost.localdomain ([217.138.206.82])
        by smtp.gmail.com with ESMTPSA id i186-20020a3754c3000000b0069fc13ce23dsm1315024qkb.110.2022.05.19.06.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 06:50:01 -0700 (PDT)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Miles Chen <miles.chen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>,
        Yassine Oudjana <yassine.oudjana@gmail.com>,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: [PATCH 6/6] clk: mediatek: Add support for other clock types in simple probe/remove
Date:   Thu, 19 May 2022 17:47:28 +0400
Message-Id: <20220519134728.456643-7-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220519134728.456643-1-y.oudjana@protonmail.com>
References: <20220519134728.456643-1-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yassine Oudjana <y.oudjana@protonmail.com>

Simple probe/remove functions currently support gates only. Add
PLLs, fixed clocks, fixed factors and muxes to support most
clock controllers. struct mtk_clk_desc now takes descriptions
for all of these clocks, and only the ones set will be registered.
Most clock controllers will only use a subset of the types
supported.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
Dependencies:
- clk: mediatek: Move to struct clk_hw provider APIs (series)
  https://patchwork.kernel.org/project/linux-mediatek/cover/20220510104804.544597-1-wenst@chromium.org/ 
- Cleanup MediaTek clk reset drivers and support MT8192/MT8195 (series)
  https://patchwork.kernel.org/project/linux-mediatek/cover/20220503093856.22250-1-rex-bc.chen@mediatek.com/
- Export required symbols to compile clk drivers as module (single patch)
  https://patchwork.kernel.org/project/linux-mediatek/patch/20220518111652.223727-7-angelogioacchino.delregno@collabora.com/

 drivers/clk/mediatek/clk-mtk.c | 88 +++++++++++++++++++++++++++++-----
 drivers/clk/mediatek/clk-mtk.h | 17 ++++++-
 2 files changed, 92 insertions(+), 13 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index 3382802663f4..df1209d5b6fb 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -15,8 +15,10 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
-#include "clk-mtk.h"
 #include "clk-gate.h"
+#include "clk-mtk.h"
+#include "clk-mux.h"
+#include "clk-pll.h"
 
 struct clk_hw_onecell_data *mtk_alloc_clk_data(unsigned int clk_num)
 {
@@ -434,20 +436,55 @@ int mtk_clk_simple_probe(struct platform_device *pdev)
 	if (!clk_ctrl)
 		return -ENOMEM;
 
-	clk_ctrl->clk_data = mtk_alloc_clk_data(mcd->num_clks);
+	clk_ctrl->clk_data = mtk_alloc_clk_data(mcd->num_plls
+					      + mcd->num_fixed_clks
+					      + mcd->num_factors
+					      + mcd->num_muxes
+					      + mcd->num_gates);
 	if (!clk_ctrl->clk_data) {
 		r = -ENOMEM;
 		goto free_clk_ctrl;
 	}
 
-	r = mtk_clk_register_gates_with_dev(node, mcd->clks, mcd->num_clks,
-					    clk_ctrl->clk_data, &pdev->dev);
-	if (r)
-		goto free_clk_data;
+	if (mcd->plls) {
+		r = mtk_clk_register_plls(node, mcd->plls, mcd->num_plls,
+					  clk_ctrl->clk_data);
+		if (r)
+			goto free_clk_data;
+	}
+
+	if (mcd->fixed_clks) {
+		r = mtk_clk_register_fixed_clks(mcd->fixed_clks, mcd->num_fixed_clks,
+						clk_ctrl->clk_data);
+		if (r)
+			goto unregister_plls;
+	}
+
+	if (mcd->factors) {
+		r = mtk_clk_register_factors(mcd->factors, mcd->num_factors,
+					     clk_ctrl->clk_data);
+		if (r)
+			goto unregister_fixed_clks;
+	}
+
+	if (mcd->muxes) {
+		spin_lock_init(&clk_ctrl->mux_lock);
+		r = mtk_clk_register_muxes(mcd->muxes, mcd->num_muxes, node,
+					   &clk_ctrl->mux_lock, clk_ctrl->clk_data);
+		if (r)
+			goto unregister_factors;
+	}
+
+	if (mcd->gates) {
+		r = mtk_clk_register_gates_with_dev(node, mcd->gates, mcd->num_gates,
+						    clk_ctrl->clk_data, &pdev->dev);
+		if (r)
+			goto unregister_muxes;
+	}
 
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_ctrl->clk_data);
 	if (r)
-		goto unregister_clks;
+		goto unregister_gates;
 
 	platform_set_drvdata(pdev, clk_ctrl);
 
@@ -457,14 +494,30 @@ int mtk_clk_simple_probe(struct platform_device *pdev)
 							       mcd->rst_desc);
 		if (IS_ERR(clk_ctrl->rst_data)) {
 			r = PTR_ERR(clk_ctrl->rst_data);
-			goto unregister_clks;
+			goto unregister_clk_provider;
 		}
 	}
 
 	return r;
 
-unregister_clks:
-	mtk_clk_unregister_gates(mcd->clks, mcd->num_clks, clk_ctrl->clk_data);
+unregister_clk_provider:
+	of_clk_del_provider(node);
+unregister_gates:
+	if (mcd->gates)
+		mtk_clk_unregister_gates(mcd->gates, mcd->num_gates, clk_ctrl->clk_data);
+unregister_muxes:
+	if (mcd->muxes)
+		mtk_clk_unregister_muxes(mcd->muxes, mcd->num_muxes, clk_ctrl->clk_data);
+unregister_factors:
+	if (mcd->factors)
+		mtk_clk_unregister_factors(mcd->factors, mcd->num_factors, clk_ctrl->clk_data);
+unregister_fixed_clks:
+	if (mcd->fixed_clks)
+		mtk_clk_unregister_fixed_clks(mcd->fixed_clks, mcd->num_fixed_clks,
+					      clk_ctrl->clk_data);
+unregister_plls:
+	if (mcd->plls)
+		mtk_clk_unregister_plls(mcd->plls, mcd->num_plls, clk_ctrl->clk_data);
 free_clk_data:
 	mtk_free_clk_data(clk_ctrl->clk_data);
 free_clk_ctrl:
@@ -480,9 +533,22 @@ int mtk_clk_simple_remove(struct platform_device *pdev)
 	struct device_node *node = pdev->dev.of_node;
 
 	of_clk_del_provider(node);
+
 	if (clk_ctrl->rst_data)
 		mtk_unregister_reset_controller(clk_ctrl->rst_data);
-	mtk_clk_unregister_gates(mcd->clks, mcd->num_clks, clk_ctrl->clk_data);
+
+	if (mcd->gates)
+		mtk_clk_unregister_gates(mcd->gates, mcd->num_gates, clk_ctrl->clk_data);
+	if (mcd->muxes)
+		mtk_clk_unregister_muxes(mcd->muxes, mcd->num_muxes, clk_ctrl->clk_data);
+	if (mcd->factors)
+		mtk_clk_unregister_factors(mcd->factors, mcd->num_factors, clk_ctrl->clk_data);
+	if (mcd->fixed_clks)
+		mtk_clk_unregister_fixed_clks(mcd->fixed_clks, mcd->num_fixed_clks,
+					      clk_ctrl->clk_data);
+	if (mcd->plls)
+		mtk_clk_unregister_plls(mcd->plls, mcd->num_plls, clk_ctrl->clk_data);
+
 	mtk_free_clk_data(clk_ctrl->clk_data);
 	kfree(clk_ctrl);
 
diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index fa092bca97c8..23bce98bca20 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -13,6 +13,9 @@
 #include <linux/spinlock.h>
 #include <linux/types.h>
 
+#include "clk-gate.h"
+#include "clk-mux.h"
+#include "clk-pll.h"
 #include "reset.h"
 
 #define MAX_MUX_GATE_BIT	31
@@ -191,12 +194,22 @@ struct clk_hw *mtk_clk_register_ref2usb_tx(const char *name,
 
 struct mtk_simple_clk_controller {
 	struct clk_hw_onecell_data *clk_data;
+	spinlock_t mux_lock;
 	struct mtk_clk_rst_data *rst_data;
 };
 
 struct mtk_clk_desc {
-	const struct mtk_gate *clks;
-	size_t num_clks;
+	const struct mtk_pll_data *plls;
+	size_t num_plls;
+	const struct mtk_fixed_clk *fixed_clks;
+	size_t num_fixed_clks;
+	const struct mtk_fixed_factor *factors;
+	size_t num_factors;
+	const struct mtk_mux *muxes;
+	size_t num_muxes;
+	const struct mtk_gate *gates;
+	size_t num_gates;
+
 	const struct mtk_clk_rst_desc *rst_desc;
 };
 
-- 
2.36.1

