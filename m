Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35691519F93
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 14:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349737AbiEDMhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 08:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349678AbiEDMgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 08:36:41 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A38A326E2;
        Wed,  4 May 2022 05:33:05 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id l18so2584950ejc.7;
        Wed, 04 May 2022 05:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c4IPakMiBG8qMu0eZo70xqgp2PUHni7/ktt8LMUY1Go=;
        b=m2F3pyQcK4IPVHZeQQykxgWkJZ1MtrhVtyc+P5bf0ZH9Jgjrd9slbkr6T10zzXsT+O
         SKHQFHHdY5qa4+N6+extiji2ToJUpU1QA7nhtiokTSthTdyYP9uF5yhEBM0crd8gZ+dm
         rT/ivTV8NWMtSG8uX/h7nhs7t5a3n3Ocz+G+nyiJl350Oxj7dTJgCkCqKmvRnn3E2fR8
         tzepYb9AVE4tY1GqMS9N3OXMIeHUJkUVJRwihnqxrpyP9eI4Vw2JoS6zCxZik3rzoOtG
         8X7VyjxXcZxIDjOIiqt69uuL8B3dcep7tExY6hoe+MUvVqvC1Dniu2r8BN23G9TUleMQ
         0mUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c4IPakMiBG8qMu0eZo70xqgp2PUHni7/ktt8LMUY1Go=;
        b=KEcLiFryISsinVwZpclHSXdQDz2utN1SpDpogTWpjUE4KFybeQudC4TMspEO2FvPFK
         ZdiYhFDu6cCnvtUBuRgvE7RSZHXXFkpEIZdBBp8jRZH7iZM/cW/9qa11DiTvJnIjuEGD
         xEB/dl95RLrq+OEVL7pHQQUMpdPpIqQT65czbKqVGYfmFauiuLnowyZ5eHuXzGZrYz7l
         9Dhe280y/ykZlOdS8oJbaS9Ln5s10abvi+NLKDCCOGjMdImi4bUnNj7wzokrLTLPY10J
         LpiImKhZm++3H+0tHcNRytUMRMfjSENa+wnIuVgirdct2NRF+lB3tbU7UHHx1mqPXQT+
         VbgQ==
X-Gm-Message-State: AOAM531ErurJ/TbYGHcUZZhqF3YBxHuqJF+hCVIUGHxDl30V0SNhuud5
        Hxh7V107OHUld7QA6OkAarR5e2uYEjc=
X-Google-Smtp-Source: ABdhPJzjBn9KrdvJXPPoHERPbtQfki+JAaYMq/RQlJZ15Om95MsCxhMPcv/ncYAS2F1IyQC4vW+3dQ==
X-Received: by 2002:a17:906:a2c2:b0:6e7:efc2:17f2 with SMTP id by2-20020a170906a2c200b006e7efc217f2mr19194685ejb.542.1651667583997;
        Wed, 04 May 2022 05:33:03 -0700 (PDT)
Received: from localhost.localdomain (185-177-124-12.hosted-by-worldstream.net. [185.177.124.12])
        by smtp.gmail.com with ESMTPSA id ig1-20020a1709072e0100b006f3ef214e7asm5688693ejc.224.2022.05.04.05.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 05:33:03 -0700 (PDT)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Yassine Oudjana <yassine.oudjana@gmail.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        Ikjoon Jang <ikjn@chromium.org>,
        Miles Chen <miles.chen@mediatek.com>,
        Sam Shih <sam.shih@mediatek.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 10/13] clk: mediatek: reset: Return mtk_reset pointer on register
Date:   Wed,  4 May 2022 16:25:59 +0400
Message-Id: <20220504122601.335495-11-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220504122601.335495-1-y.oudjana@protonmail.com>
References: <20220504122601.335495-1-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yassine Oudjana <y.oudjana@protonmail.com>

Return a struct mtk_reset* when registering a reset controller
in preparation for adding an unregister helper that will take
it as an argument.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 drivers/clk/mediatek/clk-mtk.h |  6 +++---
 drivers/clk/mediatek/reset.c   | 22 ++++++++++++----------
 2 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index bf6565aa7319..317905ec4a36 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -190,10 +190,10 @@ void mtk_free_clk_data(struct clk_onecell_data *clk_data);
 struct clk *mtk_clk_register_ref2usb_tx(const char *name,
 			const char *parent_name, void __iomem *reg);
 
-void mtk_register_reset_controller(struct device_node *np,
-			unsigned int num_regs, int regofs);
+struct mtk_reset *mtk_register_reset_controller(struct device_node *np,
+	unsigned int num_regs, int regofs);
 
-void mtk_register_reset_controller_set_clr(struct device_node *np,
+struct mtk_reset *mtk_register_reset_controller_set_clr(struct device_node *np,
 	unsigned int num_regs, int regofs);
 
 struct mtk_clk_desc {
diff --git a/drivers/clk/mediatek/reset.c b/drivers/clk/mediatek/reset.c
index 6c2effe6afef..f853bc8a7092 100644
--- a/drivers/clk/mediatek/reset.c
+++ b/drivers/clk/mediatek/reset.c
@@ -90,9 +90,9 @@ static const struct reset_control_ops mtk_reset_ops_set_clr = {
 	.reset = mtk_reset_set_clr,
 };
 
-static void mtk_register_reset_controller_common(struct device_node *np,
-			unsigned int num_regs, int regofs,
-			const struct reset_control_ops *reset_ops)
+static struct mtk_reset *mtk_register_reset_controller_common(
+	struct device_node *np,	unsigned int num_regs, int regofs,
+	const struct reset_control_ops *reset_ops)
 {
 	struct mtk_reset *data;
 	int ret;
@@ -101,12 +101,12 @@ static void mtk_register_reset_controller_common(struct device_node *np,
 	regmap = device_node_to_regmap(np);
 	if (IS_ERR(regmap)) {
 		pr_err("Cannot find regmap for %pOF: %pe\n", np, regmap);
-		return;
+		return (struct mtk_reset *)regmap;
 	}
 
 	data = kzalloc(sizeof(*data), GFP_KERNEL);
 	if (!data)
-		return;
+		return ERR_PTR(-ENOMEM);
 
 	data->regmap = regmap;
 	data->regofs = regofs;
@@ -119,22 +119,24 @@ static void mtk_register_reset_controller_common(struct device_node *np,
 	if (ret) {
 		pr_err("could not register reset controller: %d\n", ret);
 		kfree(data);
-		return;
+		return ERR_PTR(ret);
 	}
+
+	return data;
 }
 
-void mtk_register_reset_controller(struct device_node *np,
+struct mtk_reset *mtk_register_reset_controller(struct device_node *np,
 	unsigned int num_regs, int regofs)
 {
-	mtk_register_reset_controller_common(np, num_regs, regofs,
+	return mtk_register_reset_controller_common(np, num_regs, regofs,
 		&mtk_reset_ops);
 }
 EXPORT_SYMBOL_GPL(mtk_register_reset_controller);
 
-void mtk_register_reset_controller_set_clr(struct device_node *np,
+struct mtk_reset *mtk_register_reset_controller_set_clr(struct device_node *np,
 	unsigned int num_regs, int regofs)
 {
-	mtk_register_reset_controller_common(np, num_regs, regofs,
+	return mtk_register_reset_controller_common(np, num_regs, regofs,
 		&mtk_reset_ops_set_clr);
 }
 EXPORT_SYMBOL_GPL(mtk_register_reset_controller_set_clr);
-- 
2.36.0

