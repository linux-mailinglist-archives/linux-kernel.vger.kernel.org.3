Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E747496B55
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 10:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234155AbiAVJTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 04:19:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234147AbiAVJSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 04:18:40 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E138C061760
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 01:18:27 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id n16-20020a17090a091000b001b46196d572so11244578pjn.5
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 01:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4dLgzVu3UPZmPwEvYWiLff/Jy1kChuWKg74HILKInho=;
        b=gvpLT+OdMi/dn6Dv46g2q0G1XapqMDfLybAIlxoP4Ayr5j4S/KvK9rv/+vCyBlQ1iy
         2oTd9OqTJ9lEf2gY7L2QkJr1k9eKXK4uIBF6TCpPlZw5eqpxT+obPum79TTyWO4vY00k
         /uoM9jLUdRSy39Sb3qF+pNjr3o77BCBo2yzxk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4dLgzVu3UPZmPwEvYWiLff/Jy1kChuWKg74HILKInho=;
        b=bGKOqTHA4DeNvfkOeXfU6DN9P6v/n3oxKwxJzEsw+kaZmquViQ7XjWoB5HkSDXCW9t
         +wwzNfOU+4mqHUqmUyph+nONSFHlAiZCBmVovOuoZ+AFA6yaMGchYyd2a72wnsM9Qiwg
         JydeCs1SSHDGZMEtvvbjySYSCdW1YO6JAfyeq/f4zfrXhsvlvi64zT6NhbNnwkGbllE7
         eEMMzZU6eicgsznwHvxsL0XlplutVyu+ndxlOMUPQjPaEQxcaxbmQ9tSqr5Ukz8o7hIl
         FRJIcBiAEkrksv8/us/u6R9Ysc5ak4apDvwzu6zbK2TjWB1KnRkApKJg57Xhn9mk1nY5
         h4VQ==
X-Gm-Message-State: AOAM533D8HsbLxD6cvSGKyPQQTxc+ZK806tUI/67/fVVuLRNj2ENhsTQ
        U5aUo5rrjYDqB0mXOC8XfLbSag==
X-Google-Smtp-Source: ABdhPJwrAq/6QES+b7lFgZS4hCPr/6p1PUXBrtNXH0twTGUh/4YxyTn0GKRlHBgLrCyy4BiumuQBmw==
X-Received: by 2002:a17:902:d2c6:b0:14a:6e28:591c with SMTP id n6-20020a170902d2c600b0014a6e28591cmr6956198plc.85.1642843106909;
        Sat, 22 Jan 2022 01:18:26 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:349f:9373:45d9:eb26])
        by smtp.gmail.com with ESMTPSA id s1sm1608100pjn.42.2022.01.22.01.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jan 2022 01:18:26 -0800 (PST)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 19/31] clk: mediatek: Add mtk_clk_simple_remove()
Date:   Sat, 22 Jan 2022 17:17:19 +0800
Message-Id: <20220122091731.283592-20-wenst@chromium.org>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
In-Reply-To: <20220122091731.283592-1-wenst@chromium.org>
References: <20220122091731.283592-1-wenst@chromium.org>
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
---
 drivers/clk/mediatek/clk-mtk.c | 15 +++++++++++++++
 drivers/clk/mediatek/clk-mtk.h |  1 +
 2 files changed, 16 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index 2150ed8678e0..cd76e1d80242 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -369,6 +369,8 @@ int mtk_clk_simple_probe(struct platform_device *pdev)
 	if (r)
 		goto free_data;
 
+	platform_set_drvdata(pdev, clk_data);
+
 	return r;
 
 free_data:
@@ -376,4 +378,17 @@ int mtk_clk_simple_probe(struct platform_device *pdev)
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
2.35.0.rc0.227.g00780c9af4-goog

