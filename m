Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A977E530BB7
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 11:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232409AbiEWJAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 05:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232420AbiEWI7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 04:59:50 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8671240928
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 01:59:49 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id ob14-20020a17090b390e00b001dff2a43f8cso5742447pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 01:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RQjXK1tyA9xOYFhndd4nNr3xd4VXsIavQtRl5jsGh4c=;
        b=meNdqL84O1gmdVv6NUiIDJn815273OPePWQVlLCtG6TSyOYKE4v2G4PfxBLToFL8pO
         nUY0VM4BReYj05yWLnF2LyruQWkhcyhZ+XwNXzJeHEKBIZLPeU59T/CuMl7NZixuFi09
         KXxlHmNQ/PJrF206symEyu+7Zq97H8GYXkS+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RQjXK1tyA9xOYFhndd4nNr3xd4VXsIavQtRl5jsGh4c=;
        b=j7ntdWs8z7C6xuRn6Yif1TmUjESiCBdpu2aQGww3bqf/eG1mSyAfnY8SGX2JWuIyLD
         O7AT1w3alZitSdXMQz+rA43aQZ7QE4oqNKad3idjpALhx/m8QKT0+mhC2gwXIE1/RLY0
         OicaQT1o/TFMFXcA8AmN7iY4zHtwO6u0UbXb285R4wlKezBUqfPGJKtT/79zarNPxrPk
         /S6c1J3CK25TpEQfrYZAqRd2CDnX/BBUQaxze3DVNwVvYzz682e2xENcG33o4yshDyix
         INTyXzhd6iiJd/eILs9Q6YLu7VjJ4zedTAjtd+C6WA4fu+0cmYTtB1bOWKSfzUd2S042
         qXsQ==
X-Gm-Message-State: AOAM530igXwUky7+ZvMrejN+xItgshTjnQAJaohjN45D2akvMQ92RggQ
        hHZsM6qKN2Iko18t+PMqGU3xPA==
X-Google-Smtp-Source: ABdhPJw7GzZaO7+1ExzM7fCYO6HG981ADv0zp7IOz83yeRMp6UwL1C+HSBrvI/3v7TVTfgTNPEgxRw==
X-Received: by 2002:a17:90b:4a90:b0:1df:e3af:c6ad with SMTP id lp16-20020a17090b4a9000b001dfe3afc6admr21190655pjb.41.1653296388958;
        Mon, 23 May 2022 01:59:48 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:1b8:7eae:9793:ff95])
        by smtp.gmail.com with ESMTPSA id e11-20020a170902cf4b00b0015e8d4eb22csm4524719plg.118.2022.05.23.01.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 01:59:48 -0700 (PDT)
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
Subject: [PATCH v2 4/4] clk: mediatek: mt8183: Add clk mux notifier for MFG mux
Date:   Mon, 23 May 2022 16:59:23 +0800
Message-Id: <20220523085923.1430470-5-wenst@chromium.org>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
In-Reply-To: <20220523085923.1430470-1-wenst@chromium.org>
References: <20220523085923.1430470-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the MFG PLL clock, which is upstream of the MFG clock, is changed,
the downstream clock and consumers need to be switched away from the PLL
over to a stable clock to avoid glitches.

This is done through the use of the newly added clk mux notifier. The
notifier is set on the mux itself instead of the upstream PLL, but in
practice this works, as the rate change notifitcations are propogated
throughout the sub-tree hanging off the PLL. Just before rate changes,
the MFG mux is temporarily and transparently switched to the 26 MHz
main crystal. After the rate change, the mux is switched back.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v1;
- Moved clk notifier registration into separate function
- Fixed comment style

 drivers/clk/mediatek/clk-mt8183.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mt8183.c b/drivers/clk/mediatek/clk-mt8183.c
index b5c17988c337..d66acf2e5e19 100644
--- a/drivers/clk/mediatek/clk-mt8183.c
+++ b/drivers/clk/mediatek/clk-mt8183.c
@@ -1188,10 +1188,33 @@ static void clk_mt8183_top_init_early(struct device_node *node)
 CLK_OF_DECLARE_DRIVER(mt8183_topckgen, "mediatek,mt8183-topckgen",
 			clk_mt8183_top_init_early);
 
+/* Register mux notifier for MFG mux */
+static int clk_mt8183_reg_mfg_mux_notifier(struct device *dev, struct clk *clk)
+{
+	struct mtk_mux_nb *mfg_mux_nb;
+	int i;
+
+	mfg_mux_nb = devm_kzalloc(dev, sizeof(*mfg_mux_nb), GFP_KERNEL);
+	if (!mfg_mux_nb)
+		return -ENOMEM;
+
+	for (i = 0; i < ARRAY_SIZE(top_muxes); i++)
+		if (top_muxes[i].id == CLK_TOP_MUX_MFG)
+			break;
+	if (i == ARRAY_SIZE(top_muxes))
+		return -EINVAL;
+
+	mfg_mux_nb->mux = &top_muxes[i];
+	mfg_mux_nb->bypass_index = 0; /* Bypass to 26M crystal */
+
+	return devm_mtk_clk_mux_notifier_register(dev, clk, mfg_mux_nb);
+}
+
 static int clk_mt8183_top_probe(struct platform_device *pdev)
 {
 	void __iomem *base;
 	struct device_node *node = pdev->dev.of_node;
+	int ret;
 
 	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
@@ -1217,6 +1240,11 @@ static int clk_mt8183_top_probe(struct platform_device *pdev)
 	mtk_clk_register_gates(node, top_clks, ARRAY_SIZE(top_clks),
 		top_clk_data);
 
+	ret = clk_mt8183_reg_mfg_mux_notifier(&pdev->dev,
+					      top_clk_data->hws[CLK_TOP_MUX_MFG]->clk);
+	if (ret)
+		return ret;
+
 	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get,
 				      top_clk_data);
 }
-- 
2.36.1.124.g0e6072fb45-goog

