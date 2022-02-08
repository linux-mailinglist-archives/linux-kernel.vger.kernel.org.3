Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 924114AD960
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 14:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343842AbiBHNR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 08:17:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358164AbiBHMlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 07:41:09 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3093C03FEC0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 04:41:08 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id z13so1008012pfa.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 04:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6xS+neFrZyvEZNRNB9ZEba3UAvEdbGsDMRKP0HcrjcY=;
        b=S07qFfLfXlPlsPEig0kql0KSa3Jwo8SnBQAniFpfSEt9bWaC7EuaBBykud2oDeT8G6
         bWdAShALpo3BV05Wa4VxHyeKeKxQDfw48INJq9ihtQsnkh9uY8EGClLBviYeRIMV/hcK
         c/Wk9uji3P9bOqNUWYUwA/ukYeig7GR8nG0Fc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6xS+neFrZyvEZNRNB9ZEba3UAvEdbGsDMRKP0HcrjcY=;
        b=BgSIhX8Dp4UVWrr+yabWu9TNc9BQUE5iL3ohxii5JYrrlyHeTPkF+8sfGpApi9keTI
         CkBUXf9XFPqXuog+TtMc0yDAuAs/AxRj/S1iztq9Mz4G2zJPLZpIYIQYuJdVBswMKICB
         VH8BbPbyp/RjFgQSFggjdi4p6ZBTgfD8lv64amKrQzzQx7+QH7nX22lFt1mvlNCiRaZl
         d55BlWGIEpl/p3hAFnGk3H+xNdlN6KSLPPB1HMxRJIy8L8gQ7jvlJ96gIjqEVJDHqyYE
         3UAo21UOSN1QxhwaYs7ZTWoHaJy94shooDVPFmpiSurS691iTST1/m/TGxqvxpqJ7R3A
         nIlg==
X-Gm-Message-State: AOAM53394+Wi09zlmnRhPpr4ugu5rymBUCndhtmP74wXIT08t+JwhC8c
        hZah8QjtwWKXUOXu3lg1UBfxi1+mzQ1wpQ==
X-Google-Smtp-Source: ABdhPJyVSydPTJsnGkAvXxmo8hgAw+u0iFkTHDeyOosu8dCP1EYmO/Ag1a/kFhiD/Fw6iflEFWaCjg==
X-Received: by 2002:a63:5144:: with SMTP id r4mr3338517pgl.382.1644324068384;
        Tue, 08 Feb 2022 04:41:08 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:41b6:813e:c823:609c])
        by smtp.gmail.com with ESMTPSA id h11sm15056939pfe.214.2022.02.08.04.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 04:41:08 -0800 (PST)
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
Subject: [PATCH v3 09/31] clk: mediatek: mux: Implement unregister API
Date:   Tue,  8 Feb 2022 20:40:12 +0800
Message-Id: <20220208124034.414635-10-wenst@chromium.org>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
In-Reply-To: <20220208124034.414635-1-wenst@chromium.org>
References: <20220208124034.414635-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mux clk type within the MediaTek clk driver library only has a
register function, and no corresponding unregister function. This
means there is no way for its users to properly implement cleanup
and removal.

Add a matching unregister function for the mux type clk.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: Miles Chen <miles.chen@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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
2.35.0.263.gb82422642f-goog

