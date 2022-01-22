Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3908496B62
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 10:20:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234331AbiAVJUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 04:20:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234136AbiAVJTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 04:19:13 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DBDEC061749
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 01:18:40 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id 192so7616092pfz.3
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 01:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eaTeWNEgjqwSs85dnefGHTIT7+UhSwDVAnPu0tdvvQE=;
        b=PRKpymQV7xWUkT5i0Ifjesb20aljfmowZM4+SjVfERsyMOTucgZNAUD9YO7ar8zJfr
         d1WarJMewlgGgzEyuoKB/jwrxIOHkjlYILVfH25V+Psn2PnnJ4re0cugZPIspYaWN82h
         YROLc5AQFk+7TBATAuWCjd8/uH4WAnKtYdXk4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eaTeWNEgjqwSs85dnefGHTIT7+UhSwDVAnPu0tdvvQE=;
        b=cucDIKM7g+GojlpGn2iRkENdAiNhG9aVrVbjs2u8ALU1x0pOKSgEZqJiNN3Ro/B4G1
         OLHkj/4UxF2zhKCSQer6naKiATkreGWsT4B0POPUlcmAYqvkundmItZfRCkr3NMNCKii
         v+dgT+JwjBYE6KQBu0MyQ62eJDgW3Z/JWhgLplhfZhWQbqj5omqE99TEMH/j4hUyb8Ed
         pfXAzs6npCWVaG57evvKdYb+VJAWFpnKh7r1ZtTrKd9DFg0lTQSPCuRmNrPopr8muuHu
         x7sS7cfeBpruGt/LG7UHIfL+iGLxC+4rzWtYxOPnLAPvZZOm/wU6xvqyelHQ8Klb7rXl
         JEKg==
X-Gm-Message-State: AOAM532iP1YmWJ4pbXZDyZW7jbW8w+1evRMRmISe2CkxazNESFWC5q4E
        hof68EzdZKxjhLBsWLAHhNgzSg==
X-Google-Smtp-Source: ABdhPJwRjgaufhTqOLp2a5KJoAsvUWYZrG3/EkFjCr5zSjeJlit/D9oY598PALMqVYEQeylLybPljA==
X-Received: by 2002:a65:610b:: with SMTP id z11mr5646889pgu.205.1642843120168;
        Sat, 22 Jan 2022 01:18:40 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:349f:9373:45d9:eb26])
        by smtp.gmail.com with ESMTPSA id s1sm1608100pjn.42.2022.01.22.01.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jan 2022 01:18:39 -0800 (PST)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 25/31] clk: mediatek: pll: Implement error handling in register API
Date:   Sat, 22 Jan 2022 17:17:25 +0800
Message-Id: <20220122091731.283592-26-wenst@chromium.org>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
In-Reply-To: <20220122091731.283592-1-wenst@chromium.org>
References: <20220122091731.283592-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pll clk type registration function does not stop or return errors
if any clk failed to be registered, nor does it implement an error
handling path. This may result in a partially working device if any
step failed.

Make the register function return proper error codes, and bail out if
errors occur. Proper cleanup, i.e. unregister any clks that were
successfully registered, and unmap the I/O space, is done in the new
error path.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/clk/mediatek/clk-pll.c | 23 +++++++++++++++++++----
 drivers/clk/mediatek/clk-pll.h |  6 +++---
 2 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/mediatek/clk-pll.c b/drivers/clk/mediatek/clk-pll.c
index 9698d1c97cd6..1dd15f560659 100644
--- a/drivers/clk/mediatek/clk-pll.c
+++ b/drivers/clk/mediatek/clk-pll.c
@@ -369,8 +369,9 @@ static void mtk_clk_unregister_pll(struct clk *clk)
 	kfree(pll);
 }
 
-void mtk_clk_register_plls(struct device_node *node,
-		const struct mtk_pll_data *plls, int num_plls, struct clk_onecell_data *clk_data)
+int mtk_clk_register_plls(struct device_node *node,
+			  const struct mtk_pll_data *plls, int num_plls,
+			  struct clk_onecell_data *clk_data)
 {
 	void __iomem *base;
 	int i;
@@ -379,7 +380,7 @@ void mtk_clk_register_plls(struct device_node *node,
 	base = of_iomap(node, 0);
 	if (!base) {
 		pr_err("%s(): ioremap failed\n", __func__);
-		return;
+		return -EINVAL;
 	}
 
 	for (i = 0; i < num_plls; i++) {
@@ -389,11 +390,25 @@ void mtk_clk_register_plls(struct device_node *node,
 
 		if (IS_ERR(clk)) {
 			pr_err("Failed to register clk %s: %pe\n", pll->name, clk);
-			continue;
+			goto err;
 		}
 
 		clk_data->clks[pll->id] = clk;
 	}
+
+	return 0;
+
+err:
+	while (--i >= 0) {
+		const struct mtk_pll_data *pll = &plls[i];
+
+		mtk_clk_unregister_pll(clk_data->clks[pll->id]);
+		clk_data->clks[pll->id] = ERR_PTR(-ENOENT);
+	};
+
+	iounmap(base);
+
+	return PTR_ERR(clk);
 }
 EXPORT_SYMBOL_GPL(mtk_clk_register_plls);
 
diff --git a/drivers/clk/mediatek/clk-pll.h b/drivers/clk/mediatek/clk-pll.h
index a889b1e472e7..bf06e44caef9 100644
--- a/drivers/clk/mediatek/clk-pll.h
+++ b/drivers/clk/mediatek/clk-pll.h
@@ -48,9 +48,9 @@ struct mtk_pll_data {
 	u8 pll_en_bit; /* Assume 0, indicates BIT(0) by default */
 };
 
-void mtk_clk_register_plls(struct device_node *node,
-			   const struct mtk_pll_data *plls, int num_plls,
-			   struct clk_onecell_data *clk_data);
+int mtk_clk_register_plls(struct device_node *node,
+			  const struct mtk_pll_data *plls, int num_plls,
+			  struct clk_onecell_data *clk_data);
 void mtk_clk_unregister_plls(const struct mtk_pll_data *plls, int num_plls,
 			     struct clk_onecell_data *clk_data);
 
-- 
2.35.0.rc0.227.g00780c9af4-goog

