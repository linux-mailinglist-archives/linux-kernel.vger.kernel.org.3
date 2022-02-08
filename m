Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4534D4AD932
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 14:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240292AbiBHNQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 08:16:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358539AbiBHMlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 07:41:31 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1706C03FEC0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 04:41:30 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id n32so18630872pfv.11
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 04:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eHwaFCxTmQBqke38QY+U5TZZstQq9O/KJJL77r3W7Ws=;
        b=nvJ9cLw2nqPy00A1rg0QyEIyTWd8T9dpFDluSxKOq9Tn01B1Y1MbhjQSTCkrI27lra
         TPGEARXZUBxH7ykfmmOa39dR6Oy6acq0JeHZz8WIgow8M1VrhGsVwV07krTMrsDqoSNI
         XG0NVawmgtjcczlzwoL1Zq8zDR39B0P7nUe1s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eHwaFCxTmQBqke38QY+U5TZZstQq9O/KJJL77r3W7Ws=;
        b=PfmP1Jpi7ywoVD0Ml8NACDivdLCs7q7+47je0yrNhVfeccTZdvVC7fbwI19emXBJn6
         OplTFc5hIGodCtv6oWrsmuO8R6WWct4pHlf/8bMIhScErT+qUVIIVzwJLVtuRItD1imm
         gPQKR+qdX817HL5zmf5UpaCQo5dlh0zfftXacUZiiZDAPA62tqdfy4hVllfuoDnSFvzK
         3x581HrRMO3XBk6FvtbYlPzKQOk3bGeDuQtlheBqG8WcE16GCjbMFfOBCZcj2jdqkDwv
         bzIyswEdqEVqmNeqI5POeTYmGdU/1xRyLUeuIC9jGiAptFiiaQ8X4oA2O+6sDbco815N
         EiOg==
X-Gm-Message-State: AOAM530rs+b2hxdrAKinlMQRekfXwniRV7UEur0bZ4equVqPvuRcaKaT
        eJ+M8X9kO/5CCPjWKYXSLMMJdg==
X-Google-Smtp-Source: ABdhPJyYdWVRlyhjrE40StYyFinJI1sYaLoiAb4EohqiUabCdb/YfzS2WfyZVC3UGTCq7xluaPc2Xw==
X-Received: by 2002:a63:8142:: with SMTP id t63mr3362355pgd.256.1644324090238;
        Tue, 08 Feb 2022 04:41:30 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:41b6:813e:c823:609c])
        by smtp.gmail.com with ESMTPSA id h11sm15056939pfe.214.2022.02.08.04.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 04:41:30 -0800 (PST)
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
Subject: [PATCH v3 19/31] clk: mediatek: Add mtk_clk_simple_remove()
Date:   Tue,  8 Feb 2022 20:40:22 +0800
Message-Id: <20220208124034.414635-20-wenst@chromium.org>
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

In commit c58cd0e40ffa ("clk: mediatek: Add mtk_clk_simple_probe() to
simplify clock providers"), a generic probe function was added to
simplify clk drivers that only needed to support clk gates. However due
to the lack of unregister APIs, a corresponding remove function was not
added.

Now that the unregister APIs have been implemented, add aforementioned
remove function to make it complete.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: Miles Chen <miles.chen@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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
2.35.0.263.gb82422642f-goog

