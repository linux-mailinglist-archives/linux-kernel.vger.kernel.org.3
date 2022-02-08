Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 265CA4AD973
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 14:18:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237748AbiBHNSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 08:18:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358144AbiBHMlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 07:41:02 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD6BC03FECA
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 04:41:02 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id on2so7738707pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 04:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yu5wC4iGlAJptCPwbvLdBvXWnUX/vMCoe837u17t2vE=;
        b=WYmMFm75NEaKiAQgXHcNywEYl4EfNKMdlnHmbH+Y/S70IQ6WZ9BTZFIM6qXllePpzx
         VqxfGa3WakmxF3TFYcuEqxxCXNGBaGXzpSF7WpnjK4acriB5IPWJHkzpCdKwAC2iXA2q
         MpfJH/5jIsHVddh1YI+t3DBLCwl7un6kbnAxA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yu5wC4iGlAJptCPwbvLdBvXWnUX/vMCoe837u17t2vE=;
        b=iE3AAfV4h7oyBipp3BVgsunnN0Anpqv5z0RQVhUW3p1OElWoek34DcX6F74AfLbgqD
         ZII0iA/2QycbM0gw9QAvetzZPuhDX+pFCwFcyfQLq3v6wOKa8m/GWNZ3F9ubKl/HNWP5
         n0KdruDr4l/EfUtZIUM2OvwoudCukd4vzKjBd7ryWG+tha2fevsCLN/o+QvV2NqSBBj4
         r6s7COniHZ+B1BNkrjAhO0S29EPTHaN09WttA+ciGbCyGMZT7V7rdH4CQAcBT5mXjH1f
         KuKEjiHImbUPOCmBRI45noWjx6aFrh6QkKjzkK/4zUw1siJ19G0fR9XcOcymuub5GraP
         M1og==
X-Gm-Message-State: AOAM533K03assPLpPRI4mdZ/hsRSxrc3JkIL3N1aQTbOvY5Xp8Cb9CHJ
        89XCt9/7Hc1uYU7ZOP4rR1HQhA==
X-Google-Smtp-Source: ABdhPJzUeRlYjgcD/Tizn2yiqNMWwskxr1QbMAtRHQShttT8ptqsm5WTOeTXEuEiu4TrR1RbEMFh/Q==
X-Received: by 2002:a17:902:6b8c:: with SMTP id p12mr4434188plk.51.1644324062033;
        Tue, 08 Feb 2022 04:41:02 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:41b6:813e:c823:609c])
        by smtp.gmail.com with ESMTPSA id h11sm15056939pfe.214.2022.02.08.04.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 04:41:01 -0800 (PST)
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
Subject: [PATCH v3 06/31] clk: mediatek: cpumux: Implement unregister API
Date:   Tue,  8 Feb 2022 20:40:09 +0800
Message-Id: <20220208124034.414635-7-wenst@chromium.org>
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

The cpumux clk type within the MediaTek clk driver library only has
a register function, and no corresponding unregister function. This
means there is no way for its users to properly implement cleanup
and removal.

Add a matching unregister function for the cpumux type clk.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: Miles Chen <miles.chen@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/clk/mediatek/clk-cpumux.c | 31 +++++++++++++++++++++++++++++++
 drivers/clk/mediatek/clk-cpumux.h |  3 +++
 2 files changed, 34 insertions(+)

diff --git a/drivers/clk/mediatek/clk-cpumux.c b/drivers/clk/mediatek/clk-cpumux.c
index cab5095416b6..99a819e3673f 100644
--- a/drivers/clk/mediatek/clk-cpumux.c
+++ b/drivers/clk/mediatek/clk-cpumux.c
@@ -77,6 +77,21 @@ mtk_clk_register_cpumux(const struct mtk_composite *mux,
 	return clk;
 }
 
+static void mtk_clk_unregister_cpumux(struct clk *clk)
+{
+	struct mtk_clk_cpumux *cpumux;
+	struct clk_hw *hw;
+
+	hw = __clk_get_hw(clk);
+	if (!hw)
+		return;
+
+	cpumux = to_mtk_clk_cpumux(hw);
+
+	clk_unregister(clk);
+	kfree(cpumux);
+}
+
 int mtk_clk_register_cpumuxes(struct device_node *node,
 			      const struct mtk_composite *clks, int num,
 			      struct clk_onecell_data *clk_data)
@@ -106,4 +121,20 @@ int mtk_clk_register_cpumuxes(struct device_node *node,
 	return 0;
 }
 
+void mtk_clk_unregister_cpumuxes(const struct mtk_composite *clks, int num,
+				 struct clk_onecell_data *clk_data)
+{
+	int i;
+
+	for (i = num; i > 0; i--) {
+		const struct mtk_composite *mux = &clks[i - 1];
+
+		if (IS_ERR_OR_NULL(clk_data->clks[mux->id]))
+			continue;
+
+		mtk_clk_unregister_cpumux(clk_data->clks[mux->id]);
+		clk_data->clks[mux->id] = ERR_PTR(-ENOENT);
+	}
+}
+
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-cpumux.h b/drivers/clk/mediatek/clk-cpumux.h
index 2aaf1afd4e5f..fda7770fd803 100644
--- a/drivers/clk/mediatek/clk-cpumux.h
+++ b/drivers/clk/mediatek/clk-cpumux.h
@@ -19,4 +19,7 @@ int mtk_clk_register_cpumuxes(struct device_node *node,
 			      const struct mtk_composite *clks, int num,
 			      struct clk_onecell_data *clk_data);
 
+void mtk_clk_unregister_cpumuxes(const struct mtk_composite *clks, int num,
+				 struct clk_onecell_data *clk_data);
+
 #endif /* __DRV_CLK_CPUMUX_H */
-- 
2.35.0.263.gb82422642f-goog

