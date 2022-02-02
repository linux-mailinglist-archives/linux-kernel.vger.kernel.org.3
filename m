Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D86EC4A7218
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 14:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344591AbiBBNuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 08:50:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344577AbiBBNuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 08:50:05 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE890C061744
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 05:50:04 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id n32so18826165pfv.11
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 05:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pu1eEdNAtHQ3VmVoh3gnbPNdE4vdn2pwQinjoq/O1Tc=;
        b=XxrvETu43smOM+759hn3mDrz6X0CXmFDosOhmu1IBEX13G+3hWSBYQqrjAggRHGLtO
         pbKKjaE+Gi6g37qLGUg+xcVKcyPTSTT4E8RzY6y2ZOed+7ctgQKaiYHhyAy1QtCQa3VY
         o2IcpfMzV1RUduRMLrflAuqvyPz6MwmFD2MYY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pu1eEdNAtHQ3VmVoh3gnbPNdE4vdn2pwQinjoq/O1Tc=;
        b=d5q6J6syjpLqPyD5yqQwN5IS14/VL2/hQZEqpQDVsqRKKgD7PDvgHvHuU79+UO9pvP
         qDSSh+9xsDn9tb5TQDCsMYkWEflJQIlWrQvryQ4qPRbo7/vOCsVSoz8HLlp1PG8UIpUw
         EiFtXA7cjmHesOgkJKGxsPFN1zKhemVHzJLclHlqJ7nua9QsJ8X668fXziORKG9sEATb
         +KQWZRuXj37YdntkSlzA0qG5wO+ZQaxWk0mnr4UjcHqGCusUfDwRlSQjZzyn9tWofZ71
         tpi5YgCv5XBj23AeHnyz5TneC2b276sFUV22U1m0Z1O9dJNUCsanIrIuRBFvvfXFV5RQ
         lT0Q==
X-Gm-Message-State: AOAM533nu+es8hg5EE/K3hnbuIjXduPZVA9vGkjXkZRX9FBhH9Lwb8IX
        tltrh86ZQzohEtZFQAzHG5kuLQ==
X-Google-Smtp-Source: ABdhPJw18NufROymgGz/nDz0CyPOetP8fX0Kdc2e1irdYQpm7ZsWLGU25ERBQFI7Y9hn/tbWac7ouQ==
X-Received: by 2002:a63:d711:: with SMTP id d17mr24557543pgg.429.1643809804449;
        Wed, 02 Feb 2022 05:50:04 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:78b5:214c:c81:b9aa])
        by smtp.gmail.com with ESMTPSA id w19sm27335684pfu.47.2022.02.02.05.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 05:50:04 -0800 (PST)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 13/31] clk: mediatek: pll: Implement unregister API
Date:   Wed,  2 Feb 2022 21:48:16 +0800
Message-Id: <20220202134834.690675-14-wenst@chromium.org>
X-Mailer: git-send-email 2.35.0.rc2.247.g8bbb082509-goog
In-Reply-To: <20220202134834.690675-1-wenst@chromium.org>
References: <20220202134834.690675-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PLL clk type within the MediaTek clk driver library only has a
register function, and no corresponding unregister function. This
means there is no way for its users to properly implement cleanup
and removal.

Add a matching unregister function for the PLL type clk.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/clk/mediatek/clk-pll.c | 55 ++++++++++++++++++++++++++++++++++
 drivers/clk/mediatek/clk-pll.h |  2 ++
 2 files changed, 57 insertions(+)

diff --git a/drivers/clk/mediatek/clk-pll.c b/drivers/clk/mediatek/clk-pll.c
index 64f59554bc9b..b54e33b75d4e 100644
--- a/drivers/clk/mediatek/clk-pll.c
+++ b/drivers/clk/mediatek/clk-pll.c
@@ -360,6 +360,21 @@ static struct clk *mtk_clk_register_pll(const struct mtk_pll_data *data,
 	return clk;
 }
 
+static void mtk_clk_unregister_pll(struct clk *clk)
+{
+	struct clk_hw *hw;
+	struct mtk_clk_pll *pll;
+
+	hw = __clk_get_hw(clk);
+	if (!hw)
+		return;
+
+	pll = to_mtk_clk_pll(hw);
+
+	clk_unregister(clk);
+	kfree(pll);
+}
+
 void mtk_clk_register_plls(struct device_node *node,
 		const struct mtk_pll_data *plls, int num_plls, struct clk_onecell_data *clk_data)
 {
@@ -388,4 +403,44 @@ void mtk_clk_register_plls(struct device_node *node,
 }
 EXPORT_SYMBOL_GPL(mtk_clk_register_plls);
 
+static __iomem void *mtk_clk_pll_get_base(struct clk *clk,
+					  const struct mtk_pll_data *data)
+{
+	struct clk_hw *hw = __clk_get_hw(clk);
+	struct mtk_clk_pll *pll = to_mtk_clk_pll(hw);
+
+	return pll->base_addr - data->reg;
+}
+
+void mtk_clk_unregister_plls(const struct mtk_pll_data *plls, int num_plls,
+			     struct clk_onecell_data *clk_data)
+{
+	__iomem void *base = NULL;
+	int i;
+
+	if (!clk_data)
+		return;
+
+	for (i = num_plls; i > 0; i--) {
+		const struct mtk_pll_data *pll = &plls[i - 1];
+
+		if (IS_ERR_OR_NULL(clk_data->clks[pll->id]))
+			continue;
+
+		/*
+		 * This is quite ugly but unfortunately the clks don't have
+		 * any device tied to them, so there's no place to store the
+		 * pointer to the I/O region base address. We have to fetch
+		 * it from one of the registered clks.
+		 */
+		base = mtk_clk_pll_get_base(clk_data->clks[pll->id], pll);
+
+		mtk_clk_unregister_pll(clk_data->clks[pll->id]);
+		clk_data->clks[pll->id] = ERR_PTR(-ENOENT);
+	}
+
+	iounmap(base);
+}
+EXPORT_SYMBOL_GPL(mtk_clk_unregister_plls);
+
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-pll.h b/drivers/clk/mediatek/clk-pll.h
index d01b0c38311d..a889b1e472e7 100644
--- a/drivers/clk/mediatek/clk-pll.h
+++ b/drivers/clk/mediatek/clk-pll.h
@@ -51,5 +51,7 @@ struct mtk_pll_data {
 void mtk_clk_register_plls(struct device_node *node,
 			   const struct mtk_pll_data *plls, int num_plls,
 			   struct clk_onecell_data *clk_data);
+void mtk_clk_unregister_plls(const struct mtk_pll_data *plls, int num_plls,
+			     struct clk_onecell_data *clk_data);
 
 #endif /* __DRV_CLK_MTK_PLL_H */
-- 
2.35.0.rc2.247.g8bbb082509-goog

