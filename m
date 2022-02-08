Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 769484AD9A4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 14:22:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377039AbiBHNWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 08:22:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358848AbiBHMlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 07:41:46 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C295BC03FEC0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 04:41:45 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id d187so18625711pfa.10
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 04:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zOlNpEXDepZ4yjtrYbOEiToTrqDlKq5iRLx8moaIIHQ=;
        b=mpvH+3lilXr1A1JO1zFLSNPtwT6aQRcdbO1xuAOunzhTdBkypDvwK6diRK3aANzkFc
         AchHtI8htBGnpofq5uUFgsLi5WF8yY0WgvyT6jVevIRsEOhvMlw4L9guuf1KRxzRyxFb
         hsyLlMDVWBp1rQrE0O/0fvF8n3wjymQkcdRlU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zOlNpEXDepZ4yjtrYbOEiToTrqDlKq5iRLx8moaIIHQ=;
        b=SqLKgz+lMglMEYwwR6gUBUyOYIiiTk3k5lrjPzbrzVRpWjfRNB6wIDqN2iooLkmOUh
         uWqYwCeDVC1oNzRNBiNNr4QAxxg9wBk/Shu2yuJC6Kv+aT/Hz3o4+KyunyiokN1TMVpo
         S07fKNrq5WHoP1Pax5JvK4oufnrUiqzIcHfRf79SxSz9TeNt6v+iSPgYPfSoLpMCZE9u
         PWVh9FpE2qle6urSeWbBr7nynvu91TCftD1mOgghm4gh/vzf03OgHaN/+daqzGh7CEZH
         1RGGxnFBqsoviV/kuuJHvG2AYGycpDebEqO8VbhnhkkjwN217YRADpFKjOHPC8z8hMe2
         HYNQ==
X-Gm-Message-State: AOAM533YfRfg1aULn8rY3YIfJrbL6o1dx33/6GuEqFiJ7HRAL6mCSsqb
        bkjwN9TI4k6j/2O9v6rNOQi3dQ==
X-Google-Smtp-Source: ABdhPJx3bYQ0yptzfAlsZj/t5fo77StxTCrCRo53y3yujaAJF8VjMwm3Z1dpBlyvAbBVyIdcieibPw==
X-Received: by 2002:a05:6a00:1892:: with SMTP id x18mr4206790pfh.20.1644324105289;
        Tue, 08 Feb 2022 04:41:45 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:41b6:813e:c823:609c])
        by smtp.gmail.com with ESMTPSA id h11sm15056939pfe.214.2022.02.08.04.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 04:41:45 -0800 (PST)
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
Subject: [PATCH v3 26/31] clk: mediatek: mtk: Implement error handling in register APIs
Date:   Tue,  8 Feb 2022 20:40:29 +0800
Message-Id: <20220208124034.414635-27-wenst@chromium.org>
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

The remaining clk registration functions do not stop or return errors
if any clk failed to be registered, nor do they implement error
handling paths. This may result in a partially working device if any
step fails.

Make the register functions return proper error codes, and bail out if
errors occur. Proper cleanup, i.e. unregister any clks that were
successfully registered, is done in the new error path.

This also makes the |struct clk_data *| argument mandatory, as it is
used to track the list of clks registered.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: Miles Chen <miles.chen@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/clk/mediatek/clk-mtk.c | 118 ++++++++++++++++++++++++++-------
 drivers/clk/mediatek/clk-mtk.h |  20 +++---
 2 files changed, 103 insertions(+), 35 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index 5618c84e4e08..8f15e9de742e 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -53,16 +53,19 @@ void mtk_free_clk_data(struct clk_onecell_data *clk_data)
 	kfree(clk_data);
 }
 
-void mtk_clk_register_fixed_clks(const struct mtk_fixed_clk *clks,
-		int num, struct clk_onecell_data *clk_data)
+int mtk_clk_register_fixed_clks(const struct mtk_fixed_clk *clks, int num,
+				struct clk_onecell_data *clk_data)
 {
 	int i;
 	struct clk *clk;
 
+	if (!clk_data)
+		return -ENOMEM;
+
 	for (i = 0; i < num; i++) {
 		const struct mtk_fixed_clk *rc = &clks[i];
 
-		if (clk_data && !IS_ERR_OR_NULL(clk_data->clks[rc->id]))
+		if (!IS_ERR_OR_NULL(clk_data->clks[rc->id]))
 			continue;
 
 		clk = clk_register_fixed_rate(NULL, rc->name, rc->parent, 0,
@@ -70,12 +73,26 @@ void mtk_clk_register_fixed_clks(const struct mtk_fixed_clk *clks,
 
 		if (IS_ERR(clk)) {
 			pr_err("Failed to register clk %s: %pe\n", rc->name, clk);
-			continue;
+			goto err;
 		}
 
-		if (clk_data)
-			clk_data->clks[rc->id] = clk;
+		clk_data->clks[rc->id] = clk;
 	}
+
+	return 0;
+
+err:
+	while (--i >= 0) {
+		const struct mtk_fixed_clk *rc = &clks[i];
+
+		if (IS_ERR_OR_NULL(clk_data->clks[rc->id]))
+			continue;
+
+		clk_unregister_fixed_rate(clk_data->clks[rc->id]);
+		clk_data->clks[rc->id] = ERR_PTR(-ENOENT);
+	}
+
+	return PTR_ERR(clk);
 }
 EXPORT_SYMBOL_GPL(mtk_clk_register_fixed_clks);
 
@@ -99,16 +116,19 @@ void mtk_clk_unregister_fixed_clks(const struct mtk_fixed_clk *clks, int num,
 }
 EXPORT_SYMBOL_GPL(mtk_clk_unregister_fixed_clks);
 
-void mtk_clk_register_factors(const struct mtk_fixed_factor *clks,
-		int num, struct clk_onecell_data *clk_data)
+int mtk_clk_register_factors(const struct mtk_fixed_factor *clks, int num,
+			     struct clk_onecell_data *clk_data)
 {
 	int i;
 	struct clk *clk;
 
+	if (!clk_data)
+		return -ENOMEM;
+
 	for (i = 0; i < num; i++) {
 		const struct mtk_fixed_factor *ff = &clks[i];
 
-		if (clk_data && !IS_ERR_OR_NULL(clk_data->clks[ff->id]))
+		if (!IS_ERR_OR_NULL(clk_data->clks[ff->id]))
 			continue;
 
 		clk = clk_register_fixed_factor(NULL, ff->name, ff->parent_name,
@@ -116,12 +136,26 @@ void mtk_clk_register_factors(const struct mtk_fixed_factor *clks,
 
 		if (IS_ERR(clk)) {
 			pr_err("Failed to register clk %s: %pe\n", ff->name, clk);
-			continue;
+			goto err;
 		}
 
-		if (clk_data)
-			clk_data->clks[ff->id] = clk;
+		clk_data->clks[ff->id] = clk;
+	}
+
+	return 0;
+
+err:
+	while (--i >= 0) {
+		const struct mtk_fixed_factor *ff = &clks[i];
+
+		if (IS_ERR_OR_NULL(clk_data->clks[ff->id]))
+			continue;
+
+		clk_unregister_fixed_factor(clk_data->clks[ff->id]);
+		clk_data->clks[ff->id] = ERR_PTR(-ENOENT);
 	}
+
+	return PTR_ERR(clk);
 }
 EXPORT_SYMBOL_GPL(mtk_clk_register_factors);
 
@@ -258,13 +292,16 @@ static void mtk_clk_unregister_composite(struct clk *clk)
 	kfree(mux);
 }
 
-void mtk_clk_register_composites(const struct mtk_composite *mcs,
-		int num, void __iomem *base, spinlock_t *lock,
-		struct clk_onecell_data *clk_data)
+int mtk_clk_register_composites(const struct mtk_composite *mcs, int num,
+				void __iomem *base, spinlock_t *lock,
+				struct clk_onecell_data *clk_data)
 {
 	struct clk *clk;
 	int i;
 
+	if (!clk_data)
+		return -ENOMEM;
+
 	for (i = 0; i < num; i++) {
 		const struct mtk_composite *mc = &mcs[i];
 
@@ -275,12 +312,26 @@ void mtk_clk_register_composites(const struct mtk_composite *mcs,
 
 		if (IS_ERR(clk)) {
 			pr_err("Failed to register clk %s: %pe\n", mc->name, clk);
-			continue;
+			goto err;
 		}
 
-		if (clk_data)
-			clk_data->clks[mc->id] = clk;
+		clk_data->clks[mc->id] = clk;
+	}
+
+	return 0;
+
+err:
+	while (--i >= 0) {
+		const struct mtk_composite *mc = &mcs[i];
+
+		if (IS_ERR_OR_NULL(clk_data->clks[mcs->id]))
+			continue;
+
+		mtk_clk_unregister_composite(clk_data->clks[mc->id]);
+		clk_data->clks[mc->id] = ERR_PTR(-ENOENT);
 	}
+
+	return PTR_ERR(clk);
 }
 EXPORT_SYMBOL_GPL(mtk_clk_register_composites);
 
@@ -304,17 +355,20 @@ void mtk_clk_unregister_composites(const struct mtk_composite *mcs, int num,
 }
 EXPORT_SYMBOL_GPL(mtk_clk_unregister_composites);
 
-void mtk_clk_register_dividers(const struct mtk_clk_divider *mcds,
-			int num, void __iomem *base, spinlock_t *lock,
-				struct clk_onecell_data *clk_data)
+int mtk_clk_register_dividers(const struct mtk_clk_divider *mcds, int num,
+			      void __iomem *base, spinlock_t *lock,
+			      struct clk_onecell_data *clk_data)
 {
 	struct clk *clk;
 	int i;
 
+	if (!clk_data)
+		return -ENOMEM;
+
 	for (i = 0; i <  num; i++) {
 		const struct mtk_clk_divider *mcd = &mcds[i];
 
-		if (clk_data && !IS_ERR_OR_NULL(clk_data->clks[mcd->id]))
+		if (!IS_ERR_OR_NULL(clk_data->clks[mcd->id]))
 			continue;
 
 		clk = clk_register_divider(NULL, mcd->name, mcd->parent_name,
@@ -323,12 +377,26 @@ void mtk_clk_register_dividers(const struct mtk_clk_divider *mcds,
 
 		if (IS_ERR(clk)) {
 			pr_err("Failed to register clk %s: %pe\n", mcd->name, clk);
-			continue;
+			goto err;
 		}
 
-		if (clk_data)
-			clk_data->clks[mcd->id] = clk;
+		clk_data->clks[mcd->id] = clk;
+	}
+
+	return 0;
+
+err:
+	while (--i >= 0) {
+		const struct mtk_clk_divider *mcd = &mcds[i];
+
+		if (IS_ERR_OR_NULL(clk_data->clks[mcd->id]))
+			continue;
+
+		mtk_clk_unregister_composite(clk_data->clks[mcd->id]);
+		clk_data->clks[mcd->id] = ERR_PTR(-ENOENT);
 	}
+
+	return PTR_ERR(clk);
 }
 
 void mtk_clk_unregister_dividers(const struct mtk_clk_divider *mcds, int num,
diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index 7f902581a115..bf6565aa7319 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -34,8 +34,8 @@ struct mtk_fixed_clk {
 		.rate = _rate,				\
 	}
 
-void mtk_clk_register_fixed_clks(const struct mtk_fixed_clk *clks, int num,
-				 struct clk_onecell_data *clk_data);
+int mtk_clk_register_fixed_clks(const struct mtk_fixed_clk *clks, int num,
+				struct clk_onecell_data *clk_data);
 void mtk_clk_unregister_fixed_clks(const struct mtk_fixed_clk *clks, int num,
 				   struct clk_onecell_data *clk_data);
 
@@ -55,8 +55,8 @@ struct mtk_fixed_factor {
 		.div = _div,				\
 	}
 
-void mtk_clk_register_factors(const struct mtk_fixed_factor *clks, int num,
-			      struct clk_onecell_data *clk_data);
+int mtk_clk_register_factors(const struct mtk_fixed_factor *clks, int num,
+			     struct clk_onecell_data *clk_data);
 void mtk_clk_unregister_factors(const struct mtk_fixed_factor *clks, int num,
 				struct clk_onecell_data *clk_data);
 
@@ -150,9 +150,9 @@ struct mtk_composite {
 struct clk *mtk_clk_register_composite(const struct mtk_composite *mc,
 		void __iomem *base, spinlock_t *lock);
 
-void mtk_clk_register_composites(const struct mtk_composite *mcs,
-		int num, void __iomem *base, spinlock_t *lock,
-		struct clk_onecell_data *clk_data);
+int mtk_clk_register_composites(const struct mtk_composite *mcs, int num,
+				void __iomem *base, spinlock_t *lock,
+				struct clk_onecell_data *clk_data);
 void mtk_clk_unregister_composites(const struct mtk_composite *mcs, int num,
 				   struct clk_onecell_data *clk_data);
 
@@ -178,9 +178,9 @@ struct mtk_clk_divider {
 		.div_width = _width,				\
 }
 
-void mtk_clk_register_dividers(const struct mtk_clk_divider *mcds, int num,
-			       void __iomem *base, spinlock_t *lock,
-			       struct clk_onecell_data *clk_data);
+int mtk_clk_register_dividers(const struct mtk_clk_divider *mcds, int num,
+			      void __iomem *base, spinlock_t *lock,
+			      struct clk_onecell_data *clk_data);
 void mtk_clk_unregister_dividers(const struct mtk_clk_divider *mcds, int num,
 				 struct clk_onecell_data *clk_data);
 
-- 
2.35.0.263.gb82422642f-goog

