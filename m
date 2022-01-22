Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB471496B33
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 10:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234011AbiAVJSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 04:18:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233964AbiAVJRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 04:17:49 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F34C06173B
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 01:17:49 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id i65so11048666pfc.9
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 01:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OnlH+02wTY784epgQF/8+qaOubssd1JN7rcUpKc5sdg=;
        b=IN2wm2XH3BarhBK3YsxYrTPEpo3GPbOh6u1D+ohCgM6749mJYHEreL50ND4arWhV04
         CIEwcHWKuub+JbVPxjPTOo0cPp9s/VpE+FQyTj2DvvKEkf7YCZedvklNcZE8G3FS3GyR
         WAirdrBE3Mj39mWUQ49UgSlxK6799rlJDLGYo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OnlH+02wTY784epgQF/8+qaOubssd1JN7rcUpKc5sdg=;
        b=GlUNDcHyZCIyiMxrvTfDJseM3+1MtXZ54l2PStX19xH1r6tJ+1R7XT/1+2FsBAikVI
         8UukjfgZcYQQXFdxilErqjZ/98s/9LffodIRww2ZoRwhqSaJEFv3ZNdED26aHYV6u9+k
         BOzb9OBJW5p9Ka7zOIkHwHIXKUjAAswe6tf+XUijdiH/srUvDsyxk4JWKspawKKEQgef
         wsXk0r5r9/C3uwxsSqOsYkcVn7V+osD0jxVIysgcL1N2RrXCIG+/cSWEwFDhUrS5JkhG
         CinZAiEUI8EQw24kslN6JoF51W70wGVMkxRbNTfC2rVRsD8BH7sMN0tn9RP5TaZNiz4c
         kEMg==
X-Gm-Message-State: AOAM530Mb7RPyUsho+Pxrf9uqOaT7McmEhKrU1cxaRF7j3FtCYy22cvu
        i5M1niEQ9p5MCPG0D9he4T3ABA==
X-Google-Smtp-Source: ABdhPJyAxtnRfbFm0yvpJVciPEpqwg/fnanW8fcXzIRvKxhJXOmkYyJMlTkEp9XMiARE7xLdzDj0nQ==
X-Received: by 2002:a65:4685:: with SMTP id h5mr5535715pgr.14.1642843069126;
        Sat, 22 Jan 2022 01:17:49 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:349f:9373:45d9:eb26])
        by smtp.gmail.com with ESMTPSA id s1sm1608100pjn.42.2022.01.22.01.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jan 2022 01:17:48 -0800 (PST)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/31] clk: mediatek: gate: Consolidate gate type clk related code
Date:   Sat, 22 Jan 2022 17:17:02 +0800
Message-Id: <20220122091731.283592-3-wenst@chromium.org>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
In-Reply-To: <20220122091731.283592-1-wenst@chromium.org>
References: <20220122091731.283592-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now some bits of the gate type clk code are in clk-gate.[ch], but
other bits are in clk-mtk.[ch]. This is different from the cpumux and
mux type clks, for which all of the code are found in the same files.

Move the functions that register multiple clks from a given list,
mtk_clk_register_gates_with_dev() and mtk_clk_register_gates(), to
clk-gate.[ch] to consolidate all the code for the gate type clks.

This commit only moves code with minor whitespace fixups to correct
the code style. Further improvements, such as internalizing various
functions and structures will be done in later commits.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/clk/mediatek/clk-gate.c | 53 ++++++++++++++++++++++++++++++++-
 drivers/clk/mediatek/clk-gate.h | 25 ++++++++++++++++
 drivers/clk/mediatek/clk-mtk.c  | 51 -------------------------------
 drivers/clk/mediatek/clk-mtk.h  | 25 ----------------
 4 files changed, 77 insertions(+), 77 deletions(-)

diff --git a/drivers/clk/mediatek/clk-gate.c b/drivers/clk/mediatek/clk-gate.c
index 5d88b428565b..54921768bfba 100644
--- a/drivers/clk/mediatek/clk-gate.c
+++ b/drivers/clk/mediatek/clk-gate.c
@@ -11,9 +11,9 @@
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/clkdev.h>
+#include <linux/mfd/syscon.h>
 #include <linux/module.h>
 
-#include "clk-mtk.h"
 #include "clk-gate.h"
 
 static u32 mtk_get_clockgating(struct clk_hw *hw)
@@ -182,4 +182,55 @@ struct clk *mtk_clk_register_gate(
 }
 EXPORT_SYMBOL_GPL(mtk_clk_register_gate);
 
+int mtk_clk_register_gates_with_dev(struct device_node *node,
+				    const struct mtk_gate *clks, int num,
+				    struct clk_onecell_data *clk_data,
+				    struct device *dev)
+{
+	int i;
+	struct clk *clk;
+	struct regmap *regmap;
+
+	if (!clk_data)
+		return -ENOMEM;
+
+	regmap = device_node_to_regmap(node);
+	if (IS_ERR(regmap)) {
+		pr_err("Cannot find regmap for %pOF: %pe\n", node, regmap);
+		return PTR_ERR(regmap);
+	}
+
+	for (i = 0; i < num; i++) {
+		const struct mtk_gate *gate = &clks[i];
+
+		if (!IS_ERR_OR_NULL(clk_data->clks[gate->id]))
+			continue;
+
+		clk = mtk_clk_register_gate(gate->name, gate->parent_name,
+					    regmap,
+					    gate->regs->set_ofs,
+					    gate->regs->clr_ofs,
+					    gate->regs->sta_ofs,
+					    gate->shift, gate->ops,
+					    gate->flags, dev);
+
+		if (IS_ERR(clk)) {
+			pr_err("Failed to register clk %s: %pe\n", gate->name, clk);
+			continue;
+		}
+
+		clk_data->clks[gate->id] = clk;
+	}
+
+	return 0;
+}
+
+int mtk_clk_register_gates(struct device_node *node,
+			   const struct mtk_gate *clks, int num,
+			   struct clk_onecell_data *clk_data)
+{
+	return mtk_clk_register_gates_with_dev(node, clks, num, clk_data, NULL);
+}
+EXPORT_SYMBOL_GPL(mtk_clk_register_gates);
+
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-gate.h b/drivers/clk/mediatek/clk-gate.h
index 3c3329ec54b7..432b571d23b3 100644
--- a/drivers/clk/mediatek/clk-gate.h
+++ b/drivers/clk/mediatek/clk-gate.h
@@ -43,6 +43,22 @@ struct clk *mtk_clk_register_gate(
 		unsigned long flags,
 		struct device *dev);
 
+struct mtk_gate_regs {
+	u32 sta_ofs;
+	u32 clr_ofs;
+	u32 set_ofs;
+};
+
+struct mtk_gate {
+	int id;
+	const char *name;
+	const char *parent_name;
+	const struct mtk_gate_regs *regs;
+	int shift;
+	const struct clk_ops *ops;
+	unsigned long flags;
+};
+
 #define GATE_MTK_FLAGS(_id, _name, _parent, _regs, _shift,	\
 			_ops, _flags) {				\
 		.id = _id,					\
@@ -57,4 +73,13 @@ struct clk *mtk_clk_register_gate(
 #define GATE_MTK(_id, _name, _parent, _regs, _shift, _ops)		\
 	GATE_MTK_FLAGS(_id, _name, _parent, _regs, _shift, _ops, 0)
 
+int mtk_clk_register_gates(struct device_node *node,
+			   const struct mtk_gate *clks, int num,
+			   struct clk_onecell_data *clk_data);
+
+int mtk_clk_register_gates_with_dev(struct device_node *node,
+				    const struct mtk_gate *clks, int num,
+				    struct clk_onecell_data *clk_data,
+				    struct device *dev);
+
 #endif /* __DRV_CLK_GATE_H */
diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index 519a461cbb6f..0c5db3c71fdd 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -106,57 +106,6 @@ void mtk_clk_register_factors(const struct mtk_fixed_factor *clks,
 }
 EXPORT_SYMBOL_GPL(mtk_clk_register_factors);
 
-int mtk_clk_register_gates_with_dev(struct device_node *node,
-		const struct mtk_gate *clks,
-		int num, struct clk_onecell_data *clk_data,
-		struct device *dev)
-{
-	int i;
-	struct clk *clk;
-	struct regmap *regmap;
-
-	if (!clk_data)
-		return -ENOMEM;
-
-	regmap = device_node_to_regmap(node);
-	if (IS_ERR(regmap)) {
-		pr_err("Cannot find regmap for %pOF: %pe\n", node, regmap);
-		return PTR_ERR(regmap);
-	}
-
-	for (i = 0; i < num; i++) {
-		const struct mtk_gate *gate = &clks[i];
-
-		if (!IS_ERR_OR_NULL(clk_data->clks[gate->id]))
-			continue;
-
-		clk = mtk_clk_register_gate(gate->name, gate->parent_name,
-				regmap,
-				gate->regs->set_ofs,
-				gate->regs->clr_ofs,
-				gate->regs->sta_ofs,
-				gate->shift, gate->ops, gate->flags, dev);
-
-		if (IS_ERR(clk)) {
-			pr_err("Failed to register clk %s: %pe\n", gate->name, clk);
-			continue;
-		}
-
-		clk_data->clks[gate->id] = clk;
-	}
-
-	return 0;
-}
-
-int mtk_clk_register_gates(struct device_node *node,
-		const struct mtk_gate *clks,
-		int num, struct clk_onecell_data *clk_data)
-{
-	return mtk_clk_register_gates_with_dev(node,
-		clks, num, clk_data, NULL);
-}
-EXPORT_SYMBOL_GPL(mtk_clk_register_gates);
-
 struct clk *mtk_clk_register_composite(const struct mtk_composite *mc,
 		void __iomem *base, spinlock_t *lock)
 {
diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index 0ff289d93452..bdec7dc5e07a 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -150,31 +150,6 @@ void mtk_clk_register_composites(const struct mtk_composite *mcs,
 		int num, void __iomem *base, spinlock_t *lock,
 		struct clk_onecell_data *clk_data);
 
-struct mtk_gate_regs {
-	u32 sta_ofs;
-	u32 clr_ofs;
-	u32 set_ofs;
-};
-
-struct mtk_gate {
-	int id;
-	const char *name;
-	const char *parent_name;
-	const struct mtk_gate_regs *regs;
-	int shift;
-	const struct clk_ops *ops;
-	unsigned long flags;
-};
-
-int mtk_clk_register_gates(struct device_node *node,
-			const struct mtk_gate *clks, int num,
-			struct clk_onecell_data *clk_data);
-
-int mtk_clk_register_gates_with_dev(struct device_node *node,
-		const struct mtk_gate *clks,
-		int num, struct clk_onecell_data *clk_data,
-		struct device *dev);
-
 struct mtk_clk_divider {
 	int id;
 	const char *name;
-- 
2.35.0.rc0.227.g00780c9af4-goog

