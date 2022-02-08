Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 110594AD921
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 14:17:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232537AbiBHNQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 08:16:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358105AbiBHMk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 07:40:57 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ADCCC03FECE
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 04:40:56 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id u12so6616418plq.10
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 04:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k5f5ueREUhNKaNea+d6Y8OsMbGygtw5GeTytAmFGzJI=;
        b=oIsehmLAYwVfNbEk+D3rGN2aZ2qvp+2Ti6TckVMasoOcRO3jVB2kNdazDES4vbc0th
         abX/gbG0UE40Zdcrbro4yVKD+SwTxElSrv1NvwmY0z5+OXL5EoRC17Pymnlz6LfYYvoO
         VszG5MkA/u5NfexVYpwOBVgrMTDz0aX8/CKo8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k5f5ueREUhNKaNea+d6Y8OsMbGygtw5GeTytAmFGzJI=;
        b=j0lgpvrwjddB7pdQFos7riAhPUK90TK5olkUjxfg/TKerKFIYzTsQsOjuEikTM9kTE
         Jo0xmohaweBUt6UeOUQKGq5P8Oz7iYc/2VBajBeT+HICM+zrwLoF0/uMdUDaFdXKOHAL
         C4QWW6MZI8EzRbASn828wwMzoEVZa9wCwXbIm6+BrcMrxw3WXgSw6oOXPQS+hOJU9NRD
         Rup+W+kw84bFO2sVpE2Vuh852zZKnQYN6fwa57xzHB0Rj5RTugVn1lg05e2p9hdYPITZ
         g39fL97n7+l3XLuBc2G2S9nJeVn0s/LJVApQsZhPEyRp/GoOFkoKmU5PwIqWkwnmqDKg
         HKRg==
X-Gm-Message-State: AOAM532YoRxZQnUcrGkROWGM8a2sso+/fGqW6hJwIsZa6sJQD730W574
        RDAhm4W8ZEsblAG5QF15SAn5Lg==
X-Google-Smtp-Source: ABdhPJxCyZCBP077kL5suUbOgmN6OSfj50effrOlWrM8Ayk5VmMNxB9fDjdTZsR1KKGIm+0Q4DJ3zQ==
X-Received: by 2002:a17:902:a603:: with SMTP id u3mr4460583plq.113.1644324055679;
        Tue, 08 Feb 2022 04:40:55 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:41b6:813e:c823:609c])
        by smtp.gmail.com with ESMTPSA id h11sm15056939pfe.214.2022.02.08.04.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 04:40:55 -0800 (PST)
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
Subject: [PATCH v3 03/31] clk: mediatek: gate: Internalize clk implementation
Date:   Tue,  8 Feb 2022 20:40:06 +0800
Message-Id: <20220208124034.414635-4-wenst@chromium.org>
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

struct mtk_clk_gate and mtk_clk_register_gate() are not used outside of
the gate clk library. Only the API that handles a list of clks is used
by the individual platform clk drivers.

Internalize the parts that aren't used outside of the implementation.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: Miles Chen <miles.chen@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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
2.35.0.263.gb82422642f-goog

