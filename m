Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F20194E1CC4
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 17:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245556AbiCTQaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 12:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245479AbiCTQ3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 12:29:42 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3243C344DC;
        Sun, 20 Mar 2022 09:28:18 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id u16so16850496wru.4;
        Sun, 20 Mar 2022 09:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=KJy+bVD9Yq3kRrz9Gx7NWpfnxrb/beBV0JaHxbyWaTA=;
        b=cEoglGD+MtPj1LCuCCZuLMiLqdVULATaMu0uGt9BgJy8BBxAqnLp+KqyEDvgNd1Lq/
         t2U9TbqbI1R9d+Gwm/fc1tEMl9/n+KanIP//vi/Il+HoJloMDxOxf0aJ/ffCY5zY0jVp
         DZz3MhFSdyuHrPj4p6XnfYpUVAjeQb7quikiu/AEZrsp2rHIJ6QIboUvdjw4lSCCdEzm
         c+N2PGnnfo5N6xqS6sxRDOaNR8CItuup4tKai+7el0Ty1rurZ5FEUpcNzwiYwufq62Wt
         F7YuNz6TH7FcqJ5oxvU2mBIzYG5P13yRhf00mtat3legkY7d7pV2pMIwwAkI+dFqlTKJ
         2XZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KJy+bVD9Yq3kRrz9Gx7NWpfnxrb/beBV0JaHxbyWaTA=;
        b=zYLtqLq3tpz3hERA9le0mWSPsYKfJm5wPXKFfo82ve8TzPVRJFeQ/KbacGGXIuIY5A
         M394n+ujwRJ0ISO9RJaXZUu1+LYP2gl8Tkyi5ub4WUDTMrKSCgybSKNCu2Iaz8XAouNJ
         LtSOYTeNnqiwwBfStRsP5HN3OeMV/0WZKqiE3UMiyZeohVkBNA5CLOdGT6uL6jMca04V
         iaerhT7NzQZueSh0tJ7jHZmnniJ8RNGBNHuZK2ldNpoertCa5VsSL4I9F9TDJ58lC04K
         VeekpooRk/s/NjpGhsr0OEm7UjDW41KopUBbsfAMCY7XD6ea/Pcys0cvXRl/ObIRs0ZX
         YwHQ==
X-Gm-Message-State: AOAM5320ubd+JFGws/V7e2AERjbHH7ziO75cQZje0/ifP6Df5GZd/NPh
        4iQcxK0Pn/3LY/mUS8LP5IzD1MYzLxM=
X-Google-Smtp-Source: ABdhPJw2JIU7ooviqse14YqNA/qhNtEj6Knv7qKcUYq0tPlvtH8e24pjHNNqEE7r0N8gpygJxg96kA==
X-Received: by 2002:a5d:584a:0:b0:203:97f6:5975 with SMTP id i10-20020a5d584a000000b0020397f65975mr15150068wrf.612.1647793696495;
        Sun, 20 Mar 2022 09:28:16 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-69-170.ip85.fastwebnet.it. [93.42.69.170])
        by smtp.googlemail.com with ESMTPSA id y6-20020a05600015c600b00203fa70b4ebsm6760085wry.53.2022.03.20.09.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Mar 2022 09:28:16 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v3 05/18] clk: qcom: kpss-xcc: convert to parent data API
Date:   Sun, 20 Mar 2022 12:34:17 +0100
Message-Id: <20220320113430.26076-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220320113430.26076-1-ansuelsmth@gmail.com>
References: <20220320113430.26076-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the driver to parent data API. From the Documentation pll8_vote
and pxo should be declared in the DTS so fw_name can be used instead of
parent_names. Name is still used to save regression on old definition.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/clk/qcom/kpss-xcc.c | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/drivers/clk/qcom/kpss-xcc.c b/drivers/clk/qcom/kpss-xcc.c
index 4fec1f9142b8..347f70e9f5fe 100644
--- a/drivers/clk/qcom/kpss-xcc.c
+++ b/drivers/clk/qcom/kpss-xcc.c
@@ -12,9 +12,9 @@
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
 
-static const char *aux_parents[] = {
-	"pll8_vote",
-	"pxo",
+static const struct clk_parent_data aux_parents[] = {
+	{ .name = "pll8_vote", .fw_name = "pll8_vote" },
+	{ .name = "pxo", .fw_name = "pxo" },
 };
 
 static unsigned int aux_parent_map[] = {
@@ -32,8 +32,8 @@ MODULE_DEVICE_TABLE(of, kpss_xcc_match_table);
 static int kpss_xcc_driver_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *id;
-	struct clk *clk;
 	void __iomem *base;
+	struct clk_hw *hw;
 	const char *name;
 
 	id = of_match_device(kpss_xcc_match_table, &pdev->dev);
@@ -55,24 +55,15 @@ static int kpss_xcc_driver_probe(struct platform_device *pdev)
 		base += 0x28;
 	}
 
-	clk = clk_register_mux_table(&pdev->dev, name, aux_parents,
-				     ARRAY_SIZE(aux_parents), 0, base, 0, 0x3,
-				     0, aux_parent_map, NULL);
+	hw = __devm_clk_hw_register_mux(&pdev->dev, NULL, name, ARRAY_SIZE(aux_parents),
+					NULL, NULL, aux_parents, 0, base, 0, 0x3,
+					0, aux_parent_map, NULL);
 
-	platform_set_drvdata(pdev, clk);
-
-	return PTR_ERR_OR_ZERO(clk);
-}
-
-static int kpss_xcc_driver_remove(struct platform_device *pdev)
-{
-	clk_unregister_mux(platform_get_drvdata(pdev));
-	return 0;
+	return PTR_ERR_OR_ZERO(hw);
 }
 
 static struct platform_driver kpss_xcc_driver = {
 	.probe = kpss_xcc_driver_probe,
-	.remove = kpss_xcc_driver_remove,
 	.driver = {
 		.name = "kpss-xcc",
 		.of_match_table = kpss_xcc_match_table,
-- 
2.34.1

