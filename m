Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC39352E93E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 11:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235921AbiETJoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 05:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347911AbiETJoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 05:44:13 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ABA814ACB7
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 02:44:04 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id v11so7323167pff.6
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 02:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AvNGESyxRhAV7gvo9X+ZKpVxV8kV0aTUV2T2AAUUwSE=;
        b=BkRPFP15NL4IDnXh3hlvK+h4PzJxWcyRSC5t3p3BGGZMBbn5p2tRT10c7yXnEjZ7qv
         TjwumJSNJCbWyz+S7Oq4+ikTRxyYmgHbP6LlHqFnYLRs4Wtl7jh81BBsLNinRfjORf5Q
         QReafMfp7lU1rHeO82t6+rUtgUpjsM6xenPjE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AvNGESyxRhAV7gvo9X+ZKpVxV8kV0aTUV2T2AAUUwSE=;
        b=2H6NsHt9RmRxXvOUFJtk8lJe8uO0TzAwjR7hTKQ0AEAUzRO79V2WkjvUXAORjd4WpX
         NjuZ21V46cBvDpMiZcBFVmYKQ9y2df6mq3q9b5ZgbiKex0rV5y90Twdvz1VBVUFiJxEC
         i0iw8e/X66Qd6cu4RvvXFmLCKJ+sDudSC5i0sdIFtxYXD+PodKSoJsxbtMTa0quU8OyY
         FYAwI+Su2wg2JA8hBmrwG13/8o1xLBVgJKNWnltywnu8cNRrMUhHtmNYwdHcApWCvcts
         E1Pf3tp32EJhlSChyyhKL5B9Nn2ppcvhPC/D3wkSTH5wUy4KoI7Dg5N0jxrTRA55G3e2
         GOwQ==
X-Gm-Message-State: AOAM531fmfWqInquLtRZcJTTQez/GeKWtn3Nb7N+2bgKR6l2cQ6Cgjfi
        r3zVxRudXU4SNOavaAW5F3JrRg==
X-Google-Smtp-Source: ABdhPJzv5s6fjmTY7cGc4/IdOJw7m4BY9pIbTwRNzDnU08TqxlxAF8ZR6ZdjHyvyfxHFlJwT2Cytnw==
X-Received: by 2002:a63:6802:0:b0:3f6:7295:7c3e with SMTP id d2-20020a636802000000b003f672957c3emr2804558pgc.308.1653039843763;
        Fri, 20 May 2022 02:44:03 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:ec49:9912:894:222d])
        by smtp.gmail.com with ESMTPSA id 23-20020aa79217000000b0050dc76281bfsm1290597pfo.153.2022.05.20.02.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 02:44:03 -0700 (PDT)
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
Subject: [PATCH 4/4] clk: mediatek: mt8183: Add clk mux notifier for MFG mux
Date:   Fri, 20 May 2022 17:43:23 +0800
Message-Id: <20220520094323.754971-5-wenst@chromium.org>
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
 drivers/clk/mediatek/clk-mt8183.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mt8183.c b/drivers/clk/mediatek/clk-mt8183.c
index 8a755fadebb5..afef3738396e 100644
--- a/drivers/clk/mediatek/clk-mt8183.c
+++ b/drivers/clk/mediatek/clk-mt8183.c
@@ -1192,6 +1192,8 @@ static int clk_mt8183_top_probe(struct platform_device *pdev)
 {
 	void __iomem *base;
 	struct device_node *node = pdev->dev.of_node;
+	struct mtk_mux_nb *mfg_mux_nb;
+	int i, ret;
 
 	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
@@ -1217,6 +1219,25 @@ static int clk_mt8183_top_probe(struct platform_device *pdev)
 	mtk_clk_register_gates(node, top_clks, ARRAY_SIZE(top_clks),
 		top_clk_data);
 
+	/* Register mux notifier for MFG mux */
+	mfg_mux_nb = devm_kzalloc(&pdev->dev, sizeof(*mfg_mux_nb), GFP_KERNEL);
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
+	mfg_mux_nb->bypass_index = 0; // Bypass to 26M crystal
+	ret = devm_mtk_clk_mux_notifier_register(&pdev->dev,
+						 top_clk_data->hws[CLK_TOP_MUX_MFG]->clk,
+						 mfg_mux_nb);
+	if (ret)
+		return ret;
+
 	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get,
 				      top_clk_data);
 }
-- 
2.36.1.124.g0e6072fb45-goog

