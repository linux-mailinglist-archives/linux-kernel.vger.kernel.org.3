Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48705496B63
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 10:20:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233350AbiAVJUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 04:20:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234220AbiAVJTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 04:19:17 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BB8C06177E
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 01:18:42 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id c5so10237212pgk.12
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 01:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cbPbA9/DLWUYTIxrdST0gBpfgjb/5RZYFjIh1hKBGaw=;
        b=fXfvPqZw/4dYCNRcYbxy3FQcxMrUAI7ndyklT4lYjdDuwYyCkAxRarz7aw+CAQh6/w
         AsexIaSXdv4RskQreEXbs88+kzid2zRVKf9Hn/PSZbjMAQIGnyic/sR/2Un/j3NIZzmI
         2F/MqS+afK/Z10bWZ0jJTAf5yQjVpk0Z+rE7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cbPbA9/DLWUYTIxrdST0gBpfgjb/5RZYFjIh1hKBGaw=;
        b=dYqXDSiNexViZVQBinXNJkJuS0LoIcctaka1TUNbI1ZpCBZwR+h90rwZt4a4Yhhcm/
         ro6G0WWT/FLmldql5a3wKmBU4mCmBc7a5CeWaczesznxEpUhl6doN15DEn8Gz+wFFAOU
         Arfv8t3b7eEeV5P/L6CcsToax5PgfsWM/KArca6c5Beay5tJ8qe6NW7qOPPj43+KzxQG
         Pcwd9vv2ML7WoJU/Y3lWfe6QeE0JRCu2gJVQ8nbFBgcYpJjkyJPfHDKkzpRQwm9KF/E5
         F2uzBOtvwa8Rti6OSFxL37fXioRbbIhAW9ZRWOjX6aCWMVARYvIuz38jm6FJN6iCrHG1
         ilww==
X-Gm-Message-State: AOAM531xuqY6Eq0T8t1Nqg7JNtStrbDFkxY5uAZE0ixOmKXYNY/co7Rn
        k1Pe7l27RS17i+JYcp40Jsw9cA==
X-Google-Smtp-Source: ABdhPJypl8e8g8WdxvcCTgGDoGSeur3n9oEkuxyTV4uLfQphxOLzks9aTqV8OjUgoQuQSOhx+TnoJg==
X-Received: by 2002:a63:2ac2:: with SMTP id q185mr5565195pgq.370.1642843122383;
        Sat, 22 Jan 2022 01:18:42 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:349f:9373:45d9:eb26])
        by smtp.gmail.com with ESMTPSA id s1sm1608100pjn.42.2022.01.22.01.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jan 2022 01:18:41 -0800 (PST)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 26/31] clk: mediatek: mtk: Implement error handling in register APIs
Date:   Sat, 22 Jan 2022 17:17:26 +0800
Message-Id: <20220122091731.283592-27-wenst@chromium.org>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
In-Reply-To: <20220122091731.283592-1-wenst@chromium.org>
References: <20220122091731.283592-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
---
 drivers/clk/mediatek/clk-mtk.c | 118 ++++++++++++++++++++++++++-------
 drivers/clk/mediatek/clk-mtk.h |  20 +++---
 2 files changed, 103 insertions(+), 35 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index d2c50186cceb..e1977c8e130a 100644
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
 
@@ -253,13 +287,16 @@ static void mtk_clk_unregister_composite(struct clk *clk)
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
 
@@ -270,12 +307,26 @@ void mtk_clk_register_composites(const struct mtk_composite *mcs,
 
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
 
@@ -299,17 +350,20 @@ void mtk_clk_unregister_composites(const struct mtk_composite *mcs, int num,
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
@@ -318,12 +372,26 @@ void mtk_clk_register_dividers(const struct mtk_clk_divider *mcds,
 
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
2.35.0.rc0.227.g00780c9af4-goog

