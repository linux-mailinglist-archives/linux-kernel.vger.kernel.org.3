Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B20AB4A723A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 14:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbiBBNwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 08:52:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344587AbiBBNuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 08:50:24 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 271E7C061751
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 05:50:17 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id z14-20020a17090ab10e00b001b6175d4040so6959141pjq.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 05:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TnJY4R7pNFq+r1c9Hai8pZCAxCplMW9W4uneml+9vI4=;
        b=oWAUpCfdpiugCygrTgIA9X8C/lV3LzbqgqOMRZO7X7MfSgx4XOx/FBGQjiEP1bNdkV
         P2XpD8hAcBq+sHWNb0+VbeAN7xU9Cuc9a+imNhgeUIjXLwNyKzYfeDgonqpaKz5oGpI2
         UFpiuHKEjD3JbhenDiu1XBlBW/6fU2qYI2Fko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TnJY4R7pNFq+r1c9Hai8pZCAxCplMW9W4uneml+9vI4=;
        b=AF4v6cE4epJEHGSpnKhPSRFwIC1Z4GTUNq/4/RQTR0OlOXOoJUPJnQilaM8PHO2qWW
         L3b7badIt6U9HqjRes5fP0zNLYAChSDwQYKICLYAX0OYTwPQVyp+dzWRmHI04xfPlXDL
         ifNovDJE+Va98gojnGxP4XPFhjjCsIqzuZZ7/VaSW9Z3Fgr6gyY3HeAXRQ5AHw4y1kGP
         n5xyqAKTkkRDlPLlc4KsL71e9REkEBv9bmDxhpI9GqeJq1lSRJl3rmJBLiLE6v+XDEIU
         rnlfn/FfZdR5a8lLPCcOktTMbk8RNuhkXF3rYZFrlY35DcKLZ7uOZvRlw0JA0balUdQF
         z7Sg==
X-Gm-Message-State: AOAM531+mRS4YSf/THwy6LKczmiXEeAk+xLJcbQFgj9OI/vOoNuHY/lE
        hCqq5R2lef4MtLCiHQnBpMBp4Q==
X-Google-Smtp-Source: ABdhPJzr0WbMa8H3fmltc1g6gtQpUKUFkIR/O0axG2tZ5a2Jx5HPYVY+Zgn++LYql9+AsJykPkGzBA==
X-Received: by 2002:a17:90a:601:: with SMTP id j1mr8278507pjj.192.1643809816732;
        Wed, 02 Feb 2022 05:50:16 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:78b5:214c:c81:b9aa])
        by smtp.gmail.com with ESMTPSA id w19sm27335684pfu.47.2022.02.02.05.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 05:50:16 -0800 (PST)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 19/31] clk: mediatek: Add mtk_clk_simple_remove()
Date:   Wed,  2 Feb 2022 21:48:22 +0800
Message-Id: <20220202134834.690675-20-wenst@chromium.org>
X-Mailer: git-send-email 2.35.0.rc2.247.g8bbb082509-goog
In-Reply-To: <20220202134834.690675-1-wenst@chromium.org>
References: <20220202134834.690675-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit c58cd0e40ffa ("clk: mediatek: Add mtk_clk_simple_probe() to
simplify clock providers"), a generic probe function was added to
simplify clk drivers that only needed to support clk gates. However due
to the lack of unregister APIs, a corresponding remove function was not
added.

Now that the unregister APIs have been implemented, add aforementioned
remove function to make it complete.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: Miles Chen <miles.chen@mediatek.com>
---
 drivers/clk/mediatek/clk-mtk.c | 15 +++++++++++++++
 drivers/clk/mediatek/clk-mtk.h |  1 +
 2 files changed, 16 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index 869e6ae55c82..f108786caeda 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -374,6 +374,8 @@ int mtk_clk_simple_probe(struct platform_device *pdev)
 	if (r)
 		goto free_data;
 
+	platform_set_drvdata(pdev, clk_data);
+
 	return r;
 
 free_data:
@@ -381,4 +383,17 @@ int mtk_clk_simple_probe(struct platform_device *pdev)
 	return r;
 }
 
+int mtk_clk_simple_remove(struct platform_device *pdev)
+{
+	const struct mtk_clk_desc *mcd = of_device_get_match_data(&pdev->dev);
+	struct clk_onecell_data *clk_data = platform_get_drvdata(pdev);
+	struct device_node *node = pdev->dev.of_node;
+
+	of_clk_del_provider(node);
+	mtk_clk_unregister_gates(mcd->clks, mcd->num_clks, clk_data);
+	mtk_free_clk_data(clk_data);
+
+	return 0;
+}
+
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index 3c3a934f53cd..4fa658f5d934 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -202,5 +202,6 @@ struct mtk_clk_desc {
 };
 
 int mtk_clk_simple_probe(struct platform_device *pdev);
+int mtk_clk_simple_remove(struct platform_device *pdev);
 
 #endif /* __DRV_CLK_MTK_H */
-- 
2.35.0.rc2.247.g8bbb082509-goog

