Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9651652E93A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 11:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347915AbiETJoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 05:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347771AbiETJoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 05:44:03 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 838C914ACBA
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 02:44:01 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id bo5so7333317pfb.4
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 02:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wYj0gPoFTJBwWJLt1P9KNSn0ODKjU0wkvs8hBSjSO3U=;
        b=ld8ZB0W0CyuE942AiXu7m9Pc6o1IzPm43tHOkNtsI9ja3+ZXuaz5Fsly3T/TPHc0qC
         yK669VzcVQuMW9FLnv0lGgD5gHPf1ru3oq88/XJN0uNcvMK8LxHYFhB6djP6naTFGtHJ
         JGWj6AJghQtC93LhJLnbHADNmKxzqBYvpUn18=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wYj0gPoFTJBwWJLt1P9KNSn0ODKjU0wkvs8hBSjSO3U=;
        b=o0JlTW80Ipq6IUHXlkW2khFk6EtTgyTOgOnQ9zvG1BuD8kYyjAh/1n81t+rPR6YG9D
         udhIjxkLNRURZma4m4ZFMjzSEVkXdnWJi4pRDmAfGxMTx/RqS+abeu0OKG1OPEo+JtAq
         6cf5dr+O6sqKQo0DltYKvNDwfeP+91LZQjgCvcrwzcrJHZRas13rW5d3QTvwK+PKMNI6
         GlmE24fwEHRBihYZuWHAY31xvsK8rdj1VtcZy3PuObOir3RhUv1gO3SAY4UMjLFNmpqU
         Tybp0lowM5+ATBD4ULwMg57kqDhYrtk+bfsII+K15tCWEQ8vBNHLpUos9zxioj/sYi9G
         o1rg==
X-Gm-Message-State: AOAM532mhZE5RoRgYqg98HSfIa7v5FMikST8X/nIrUMuTJGZtoEXlp6Y
        923hcdQeReCnyiLB7zOYm1kNGw==
X-Google-Smtp-Source: ABdhPJziucUgkorNxj9E4BMmeKGpBafnohBlJChKVMYUEKtYijrw73Ok7dlvQG3idGaek2YoMaMHYw==
X-Received: by 2002:a63:e655:0:b0:3c2:84a2:2ea0 with SMTP id p21-20020a63e655000000b003c284a22ea0mr7837735pgj.86.1653039841013;
        Fri, 20 May 2022 02:44:01 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:ec49:9912:894:222d])
        by smtp.gmail.com with ESMTPSA id 23-20020aa79217000000b0050dc76281bfsm1290597pfo.153.2022.05.20.02.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 02:44:00 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] clk: mediatek: mux: add clk notifier functions
Date:   Fri, 20 May 2022 17:43:22 +0800
Message-Id: <20220520094323.754971-4-wenst@chromium.org>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
In-Reply-To: <20220520094323.754971-1-wenst@chromium.org>
References: <20220520094323.754971-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With device frequency scaling, the mux clock that (indirectly) feeds the
device selects between a dedicated PLL, and some other stable clocks.

When a clk rate change is requested, the (normally) upstream PLL is
reconfigured. It's possible for the clock output of the PLL to become
unstable during this process.

To avoid causing the device to glitch, the mux should temporarily be
switched over to another "stable" clock during the PLL rate change.
This is done with clk notifiers.

This patch adds common functions for notifiers to temporarily and
transparently reparent mux clocks.

This was loosely based on commit 8adfb08605a9 ("clk: sunxi-ng: mux: Add
clk notifier functions").

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/clk/mediatek/clk-mux.c | 42 ++++++++++++++++++++++++++++++++++
 drivers/clk/mediatek/clk-mux.h | 15 ++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mux.c b/drivers/clk/mediatek/clk-mux.c
index cd5f9fd8cb98..f84a5a753c09 100644
--- a/drivers/clk/mediatek/clk-mux.c
+++ b/drivers/clk/mediatek/clk-mux.c
@@ -4,6 +4,7 @@
  * Author: Owen Chen <owen.chen@mediatek.com>
  */
 
+#include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/compiler_types.h>
 #include <linux/container_of.h>
@@ -259,4 +260,45 @@ void mtk_clk_unregister_muxes(const struct mtk_mux *muxes, int num,
 }
 EXPORT_SYMBOL_GPL(mtk_clk_unregister_muxes);
 
+/*
+ * This clock notifier is called when the frequency of the of the parent
+ * PLL clock is to be changed. The idea is to switch the parent to a
+ * stable clock, such as the main oscillator, while the PLL frequency
+ * stabilizes.
+ */
+static int mtk_clk_mux_notifier_cb(struct notifier_block *nb,
+				   unsigned long event, void *_data)
+{
+	struct clk_notifier_data *data = _data;
+	struct mtk_mux_nb *mux_nb = to_mtk_mux_nb(nb);
+	const struct mtk_mux *mux = mux_nb->mux;
+	struct clk_hw *hw;
+	int ret = 0;
+
+	hw = __clk_get_hw(data->clk);
+
+	switch (event) {
+	case PRE_RATE_CHANGE:
+		mux_nb->original_index = mux->ops->get_parent(hw);
+		ret = mux->ops->set_parent(hw, mux_nb->bypass_index);
+		break;
+
+	case POST_RATE_CHANGE:
+	case ABORT_RATE_CHANGE:
+		ret = mux->ops->set_parent(hw, mux_nb->original_index);
+		break;
+	}
+
+	return notifier_from_errno(ret);
+}
+
+int devm_mtk_clk_mux_notifier_register(struct device *dev, struct clk *clk,
+				       struct mtk_mux_nb *mux_nb)
+{
+	mux_nb->nb.notifier_call = mtk_clk_mux_notifier_cb;
+
+	return devm_clk_notifier_register(dev, clk, &mux_nb->nb);
+}
+EXPORT_SYMBOL_GPL(devm_mtk_clk_mux_notifier_register);
+
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mux.h b/drivers/clk/mediatek/clk-mux.h
index 6539c58f5d7d..506e91125a3d 100644
--- a/drivers/clk/mediatek/clk-mux.h
+++ b/drivers/clk/mediatek/clk-mux.h
@@ -7,12 +7,14 @@
 #ifndef __DRV_CLK_MTK_MUX_H
 #define __DRV_CLK_MTK_MUX_H
 
+#include <linux/notifier.h>
 #include <linux/spinlock.h>
 #include <linux/types.h>
 
 struct clk;
 struct clk_hw_onecell_data;
 struct clk_ops;
+struct device;
 struct device_node;
 
 struct mtk_mux {
@@ -89,4 +91,17 @@ int mtk_clk_register_muxes(const struct mtk_mux *muxes,
 void mtk_clk_unregister_muxes(const struct mtk_mux *muxes, int num,
 			      struct clk_hw_onecell_data *clk_data);
 
+struct mtk_mux_nb {
+	struct notifier_block	nb;
+	const struct mtk_mux	*mux;
+
+	u8	bypass_index;	/* Which parent to temporarily use */
+	u8	original_index;	/* Set by notifier callback */
+};
+
+#define to_mtk_mux_nb(_nb)	container_of(_nb, struct mtk_mux_nb, nb)
+
+int devm_mtk_clk_mux_notifier_register(struct device *dev, struct clk *clk,
+				       struct mtk_mux_nb *mux_nb);
+
 #endif /* __DRV_CLK_MTK_MUX_H */
-- 
2.36.1.124.g0e6072fb45-goog

