Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91C71496B35
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 10:18:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234032AbiAVJSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 04:18:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233975AbiAVJRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 04:17:52 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C89A8C06173D
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 01:17:51 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id u11so10872852plh.13
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 01:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IYfVcfmzbfl8NtBT3+EuAhwGblYuELjka3vdiDEtzHI=;
        b=NgsuzFLRMEqkgAhDepLZDiqZooShEmng/mWpvDvDmJ9MqFWRIrG0WYU51aW3acaBSU
         lY5MLa8dYgYmA1aGpn8oY7oB89rll/TlYz5usSbFaARxTgJKDJMq8aVSu7GSr4ax1EKF
         ZlhEMDXNVktStkGp4jg7P8wYoke54GHUoWEwQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IYfVcfmzbfl8NtBT3+EuAhwGblYuELjka3vdiDEtzHI=;
        b=y/IKF8HE9reOYBR1+RPbbFeqYhwDQSX0m4yWx0bXs9t2iJCXpRxwkkXSTex0oBTczR
         u0BSdA5ME3H9DwWOgUEcPdIOFjmY8B3Q9TwdzwAqYecXbvqFzZ5vX6KYb8uCOSpelZsQ
         qqXpxKv0HXAp9nfNP1a1+N+zwmvwz6yMFkIODTYkRaoGaSLmd+tudMobmTmWPokaXj0Z
         OHLPN73v9a5IiyrrcgPdDajGVRX2lCUx4VOfmIlG1J17wfXUJoafT+jwCHUsseclIfkn
         VQzP2qJ2kUvxoPRIsyfNv2vTlHnY5VwCNRm7wlAH90BkGBA6lZLag2Djb0JW6uthzgvZ
         SyyQ==
X-Gm-Message-State: AOAM530temmIUN0+W9YhZBU2k4KQl4nfEK0m79T7Kkn0NF8dWKpp4l6h
        lsUT+qyffodmOCxznRmKZEKJXA==
X-Google-Smtp-Source: ABdhPJyepx5BgVfs2E/KZzdND+69YFZBMR/OAiGeYZ/xGVJtctNBJieEh7MIn+Z/+oV2aVMDwGI7gw==
X-Received: by 2002:a17:902:c613:b0:14a:7280:cfd7 with SMTP id r19-20020a170902c61300b0014a7280cfd7mr6903732plr.128.1642843071353;
        Sat, 22 Jan 2022 01:17:51 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:349f:9373:45d9:eb26])
        by smtp.gmail.com with ESMTPSA id s1sm1608100pjn.42.2022.01.22.01.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jan 2022 01:17:50 -0800 (PST)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/31] clk: mediatek: gate: Internalize clk implementation
Date:   Sat, 22 Jan 2022 17:17:03 +0800
Message-Id: <20220122091731.283592-4-wenst@chromium.org>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
In-Reply-To: <20220122091731.283592-1-wenst@chromium.org>
References: <20220122091731.283592-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct mtk_clk_gate and mtk_clk_register_gate() are not used outside of
the gate clk library. Only the API that handles a list of clks is used
by the individual platform clk drivers.

Internalize the parts that aren't used outside of the implementation.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/clk/mediatek/clk-gate.c | 35 ++++++++++++++++++++++-----------
 drivers/clk/mediatek/clk-gate.h | 31 ++---------------------------
 2 files changed, 25 insertions(+), 41 deletions(-)

diff --git a/drivers/clk/mediatek/clk-gate.c b/drivers/clk/mediatek/clk-gate.c
index 54921768bfba..e51cfd8c653c 100644
--- a/drivers/clk/mediatek/clk-gate.c
+++ b/drivers/clk/mediatek/clk-gate.c
@@ -11,11 +11,28 @@
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/clkdev.h>
+#include <linux/clk-provider.h>
+#include <linux/container_of.h>
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
+#include <linux/regmap.h>
 
 #include "clk-gate.h"
 
+struct mtk_clk_gate {
+	struct clk_hw	hw;
+	struct regmap	*regmap;
+	int		set_ofs;
+	int		clr_ofs;
+	int		sta_ofs;
+	u8		bit;
+};
+
+static inline struct mtk_clk_gate *to_mtk_clk_gate(struct clk_hw *hw)
+{
+	return container_of(hw, struct mtk_clk_gate, hw);
+}
+
 static u32 mtk_get_clockgating(struct clk_hw *hw)
 {
 	struct mtk_clk_gate *cg = to_mtk_clk_gate(hw);
@@ -140,17 +157,12 @@ const struct clk_ops mtk_clk_gate_ops_no_setclr_inv = {
 };
 EXPORT_SYMBOL_GPL(mtk_clk_gate_ops_no_setclr_inv);
 
-struct clk *mtk_clk_register_gate(
-		const char *name,
-		const char *parent_name,
-		struct regmap *regmap,
-		int set_ofs,
-		int clr_ofs,
-		int sta_ofs,
-		u8 bit,
-		const struct clk_ops *ops,
-		unsigned long flags,
-		struct device *dev)
+static struct clk *mtk_clk_register_gate(const char *name,
+					 const char *parent_name,
+					 struct regmap *regmap, int set_ofs,
+					 int clr_ofs, int sta_ofs, u8 bit,
+					 const struct clk_ops *ops,
+					 unsigned long flags, struct device *dev)
 {
 	struct mtk_clk_gate *cg;
 	struct clk *clk;
@@ -180,7 +192,6 @@ struct clk *mtk_clk_register_gate(
 
 	return clk;
 }
-EXPORT_SYMBOL_GPL(mtk_clk_register_gate);
 
 int mtk_clk_register_gates_with_dev(struct device_node *node,
 				    const struct mtk_gate *clks, int num,
diff --git a/drivers/clk/mediatek/clk-gate.h b/drivers/clk/mediatek/clk-gate.h
index 432b571d23b3..3d75521ba20c 100644
--- a/drivers/clk/mediatek/clk-gate.h
+++ b/drivers/clk/mediatek/clk-gate.h
@@ -7,42 +7,15 @@
 #ifndef __DRV_CLK_GATE_H
 #define __DRV_CLK_GATE_H
 
-#include <linux/regmap.h>
 #include <linux/clk-provider.h>
-
-struct clk;
-
-struct mtk_clk_gate {
-	struct clk_hw	hw;
-	struct regmap	*regmap;
-	int		set_ofs;
-	int		clr_ofs;
-	int		sta_ofs;
-	u8		bit;
-};
-
-static inline struct mtk_clk_gate *to_mtk_clk_gate(struct clk_hw *hw)
-{
-	return container_of(hw, struct mtk_clk_gate, hw);
-}
+#include <linux/device.h>
+#include <linux/of.h>
 
 extern const struct clk_ops mtk_clk_gate_ops_setclr;
 extern const struct clk_ops mtk_clk_gate_ops_setclr_inv;
 extern const struct clk_ops mtk_clk_gate_ops_no_setclr;
 extern const struct clk_ops mtk_clk_gate_ops_no_setclr_inv;
 
-struct clk *mtk_clk_register_gate(
-		const char *name,
-		const char *parent_name,
-		struct regmap *regmap,
-		int set_ofs,
-		int clr_ofs,
-		int sta_ofs,
-		u8 bit,
-		const struct clk_ops *ops,
-		unsigned long flags,
-		struct device *dev);
-
 struct mtk_gate_regs {
 	u32 sta_ofs;
 	u32 clr_ofs;
-- 
2.35.0.rc0.227.g00780c9af4-goog

