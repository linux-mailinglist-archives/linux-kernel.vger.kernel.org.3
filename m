Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0281496B3F
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 10:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234157AbiAVJSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 04:18:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234067AbiAVJSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 04:18:06 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF57EC06173D
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 01:18:05 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id p125so10271981pga.2
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 01:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3QDkw6hKuh9A5bW2X56div0eoUC0aWY4eb0X4EhRe1w=;
        b=UUTVvh9xTtBDXrtDwIiLvMdkg+B8Tbj/3HJzIjqASRfr6Rbi1x7UfyjSAiJJf/GKxJ
         nextzHuxXDZCB5RNB3kw6NBl27kC1oIqB6QwWHjnnw+PBXKcNaC8qWcx6FrpfUxDYR4U
         Zed+yxwix8JIPX7rU2yILjRCGyE8BJiokJXkQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3QDkw6hKuh9A5bW2X56div0eoUC0aWY4eb0X4EhRe1w=;
        b=FrLx9pM1pt14Tz6l9hv5sHHF3hOx+JoGA2rczvRPAC7IC7gRpX2vRvXt8+XMEzpkwk
         xq934iSlSVz42Hivp49PF/UMrLVhzyVz9I9u/b6L6tqyAS46a08LIsL7/4A3pZGWTjhj
         RmzQwQgFgBg8B2AdB122pfaRyAYnYWl5IdnhDreNG4YaxWNTlmetamNp7jd6Cqcztevk
         2SexppBShtG8gG1gOBzUlwRNiD50naRNEkY9NjFDiBfDTLcFJYZXu+3d/aeE8EVinMTm
         f3y28MsCBvoQHnUmkQ8xWEi9YFcp2xprhoegGusmlmpTUWFvLomQ+AyKd1PfqBIQL7ix
         9Q1Q==
X-Gm-Message-State: AOAM5321KvaL9M4OgYGAKyPeQ4xsROYcizCfRb4shw8K0QmhJLIAVfZD
        MZPj4ojXLEKFbiiJVstpHlGagw==
X-Google-Smtp-Source: ABdhPJxEsfTKz2/apvu31D0HBDJq0EjZ3iVczEuZeKOKltbSUG6IuziGeOgA3YqrYKwP877YBCdRoA==
X-Received: by 2002:a63:5607:: with SMTP id k7mr5583895pgb.190.1642843084589;
        Sat, 22 Jan 2022 01:18:04 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:349f:9373:45d9:eb26])
        by smtp.gmail.com with ESMTPSA id s1sm1608100pjn.42.2022.01.22.01.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jan 2022 01:18:04 -0800 (PST)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/31] clk: mediatek: mux: Implement unregister API
Date:   Sat, 22 Jan 2022 17:17:09 +0800
Message-Id: <20220122091731.283592-10-wenst@chromium.org>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
In-Reply-To: <20220122091731.283592-1-wenst@chromium.org>
References: <20220122091731.283592-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mux clk type within the MediaTek clk driver library only has a
register function, and no corresponding unregister function. This
means there is no way for its users to properly implement cleanup
and removal.

Add a matching unregister function for the mux type clk.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/clk/mediatek/clk-mux.c | 35 ++++++++++++++++++++++++++++++++++
 drivers/clk/mediatek/clk-mux.h |  3 +++
 2 files changed, 38 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mux.c b/drivers/clk/mediatek/clk-mux.c
index 89f23e111d91..6f0c22a699c3 100644
--- a/drivers/clk/mediatek/clk-mux.c
+++ b/drivers/clk/mediatek/clk-mux.c
@@ -164,6 +164,21 @@ static struct clk *mtk_clk_register_mux(const struct mtk_mux *mux,
 	return clk;
 }
 
+static void mtk_clk_unregister_mux(struct clk *clk)
+{
+	struct mtk_clk_mux *mux;
+	struct clk_hw *hw;
+
+	hw = __clk_get_hw(clk);
+	if (!hw)
+		return;
+
+	mux = to_mtk_clk_mux(hw);
+
+	clk_unregister(clk);
+	kfree(mux);
+}
+
 int mtk_clk_register_muxes(const struct mtk_mux *muxes,
 			   int num, struct device_node *node,
 			   spinlock_t *lock,
@@ -198,4 +213,24 @@ int mtk_clk_register_muxes(const struct mtk_mux *muxes,
 }
 EXPORT_SYMBOL_GPL(mtk_clk_register_muxes);
 
+void mtk_clk_unregister_muxes(const struct mtk_mux *muxes, int num,
+			      struct clk_onecell_data *clk_data)
+{
+	int i;
+
+	if (!clk_data)
+		return;
+
+	for (i = num; i > 0; i--) {
+		const struct mtk_mux *mux = &muxes[i - 1];
+
+		if (IS_ERR_OR_NULL(clk_data->clks[mux->id]))
+			continue;
+
+		mtk_clk_unregister_mux(clk_data->clks[mux->id]);
+		clk_data->clks[mux->id] = ERR_PTR(-ENOENT);
+	}
+}
+EXPORT_SYMBOL_GPL(mtk_clk_unregister_muxes);
+
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mux.h b/drivers/clk/mediatek/clk-mux.h
index 27841d649118..cb2ac4f04c58 100644
--- a/drivers/clk/mediatek/clk-mux.h
+++ b/drivers/clk/mediatek/clk-mux.h
@@ -88,4 +88,7 @@ int mtk_clk_register_muxes(const struct mtk_mux *muxes,
 			   spinlock_t *lock,
 			   struct clk_onecell_data *clk_data);
 
+void mtk_clk_unregister_muxes(const struct mtk_mux *muxes, int num,
+			      struct clk_onecell_data *clk_data);
+
 #endif /* __DRV_CLK_MTK_MUX_H */
-- 
2.35.0.rc0.227.g00780c9af4-goog

