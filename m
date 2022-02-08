Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98BE74AD977
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 14:19:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344041AbiBHNTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 08:19:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242857AbiBHMl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 07:41:26 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A37C03FECA
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 04:41:26 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id y9so8504310pjf.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 04:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R3JoellM0j3/drkIwePqf6xNXC0okTaVtKIbynTeAOc=;
        b=cDbvFXn+++jD2RBihOfm+4NuHtNk8YlQxYmPjF35O1yrsUbdXxfadniAuG4XR5nFwS
         6AjlYWaCgdXKEQ9wtER+Kay6SUeGumXjw601aAOrw5/VgQcSA14qgibFM3JGqGXyIn/9
         ETByjiRDfguEMxbmnwqFjDAIY6/V0+X2N5eCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R3JoellM0j3/drkIwePqf6xNXC0okTaVtKIbynTeAOc=;
        b=dRdzVIyRAR88s6P7IKyUmRUaQyzK4CE9ZtRXlhPJHke7VqgvUCsT5j+5BswzPtEC1g
         zlo3Mh/KMbznxDnxeyopPcmY6lg6sT5mQdNkwUZVN+ZlHV7WrcaQn1RncEjPthgNqWS0
         UsNKGMdjLX4YUOMUKdRzd6WbJJNFD9Od7lCs1ImEOGesNruB72OSQXXvsDL4jNdbQvZl
         leiv9VZvRX6w7pfK6bE5gBQw58/vQNWgn+Zce5kE9jKiGAN7KiYW0WfbLEkyV+ynrMbH
         H2fEicIG+16zXk4CM1D57Jn8Z+/zjMScQjcgvIe8qjh04icavJksapWtk+z9c4scbUkO
         7FYg==
X-Gm-Message-State: AOAM5334gxBMRIfftTnOWqkQgDYQ3al0uHfe4HhiDu6ms3Ps5B0pxenk
        cQtBnJt7U2Kra5/iICJsQ+ofGQ==
X-Google-Smtp-Source: ABdhPJySG6k3d+lfO+J6p0YF76ehegEmYbi/IhHoJqpoMykEiunvLKUkSg7jAzY0zepF1RSOzn+Q1w==
X-Received: by 2002:a17:90b:3a86:: with SMTP id om6mr1151521pjb.99.1644324085808;
        Tue, 08 Feb 2022 04:41:25 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:41b6:813e:c823:609c])
        by smtp.gmail.com with ESMTPSA id h11sm15056939pfe.214.2022.02.08.04.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 04:41:25 -0800 (PST)
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
Subject: [PATCH v3 17/31] clk: mediatek: Implement mtk_clk_unregister_divider_clks() API
Date:   Tue,  8 Feb 2022 20:40:20 +0800
Message-Id: <20220208124034.414635-18-wenst@chromium.org>
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

mtk_clk_register_divider_clks(), as the name suggests, is used to register
a given list of divider clks. However it is lacking a counterpart
unregister API.

Implement said unregister API so that the various clock platform drivers
can utilize it to do proper unregistration, cleanup and removal.

In the header file, the register function's declaration is also
reformatted to fit code style guidelines.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: Miles Chen <miles.chen@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/clk/mediatek/clk-mtk.c | 19 +++++++++++++++++++
 drivers/clk/mediatek/clk-mtk.h |  8 +++++---
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index b267b2f04b84..3a6dfe445e63 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -286,6 +286,25 @@ void mtk_clk_register_dividers(const struct mtk_clk_divider *mcds,
 	}
 }
 
+void mtk_clk_unregister_dividers(const struct mtk_clk_divider *mcds, int num,
+				 struct clk_onecell_data *clk_data)
+{
+	int i;
+
+	if (!clk_data)
+		return;
+
+	for (i = num; i > 0; i--) {
+		const struct mtk_clk_divider *mcd = &mcds[i - 1];
+
+		if (IS_ERR_OR_NULL(clk_data->clks[mcd->id]))
+			continue;
+
+		clk_unregister_divider(clk_data->clks[mcd->id]);
+		clk_data->clks[mcd->id] = ERR_PTR(-ENOENT);
+	}
+}
+
 int mtk_clk_simple_probe(struct platform_device *pdev)
 {
 	const struct mtk_clk_desc *mcd;
diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index 4db1a97c1250..e3ae22fb0334 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -176,9 +176,11 @@ struct mtk_clk_divider {
 		.div_width = _width,				\
 }
 
-void mtk_clk_register_dividers(const struct mtk_clk_divider *mcds,
-			int num, void __iomem *base, spinlock_t *lock,
-				struct clk_onecell_data *clk_data);
+void mtk_clk_register_dividers(const struct mtk_clk_divider *mcds, int num,
+			       void __iomem *base, spinlock_t *lock,
+			       struct clk_onecell_data *clk_data);
+void mtk_clk_unregister_dividers(const struct mtk_clk_divider *mcds, int num,
+				 struct clk_onecell_data *clk_data);
 
 struct clk_onecell_data *mtk_alloc_clk_data(unsigned int clk_num);
 void mtk_free_clk_data(struct clk_onecell_data *clk_data);
-- 
2.35.0.263.gb82422642f-goog

