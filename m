Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 364614D77AF
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 20:05:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235377AbiCMTGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 15:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235333AbiCMTGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 15:06:20 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 860764D26E;
        Sun, 13 Mar 2022 12:05:08 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id qt6so29527006ejb.11;
        Sun, 13 Mar 2022 12:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=KJy+bVD9Yq3kRrz9Gx7NWpfnxrb/beBV0JaHxbyWaTA=;
        b=RhjoKg2TAtw2kRjJHA3327WIjt7HBO2PZad5agpL27SQmL0gIx9ul6/DCku/ZDrRLw
         wqTUHvktBYFAyXbwzV7T9U+jx4EpMuaZnwc+RhFzE8eEMJB1uTfeO84+w9jTQAQT18Wm
         SzMzYR4KtBhlrkiXR+08o7nyuZGvS5DEJaYGaV8HrTsTBuAwwnZwE/yvunhq/LMIyxdZ
         lAG65bhgQP40a1UwWoxzx8Tyg2d+t24+s5DMY2XyFyTiL0EYWRB31GBZuo0FyF2QhJkQ
         HxSSQIipexM27lemK6XwI7iP6oO+0Ln9r8TAgcjnZplnJD8N0anFqPlHf5uuIpr1Fie0
         L4Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KJy+bVD9Yq3kRrz9Gx7NWpfnxrb/beBV0JaHxbyWaTA=;
        b=MdjhCPUYJ/sx68W+8q8/LjNxOjSa3HNWX2+OtFLMgzI+q0DtZBm0ClZ6L2/XmvD2Jn
         XC9y7bSPN5YZlB73MO4yL5ex0a1rbwgqvBcC1ROQY26B8iksOVMiY0UTC3sBeXmljavi
         J7Q9UUc1ev0tOsOdkBH/eeelAkaa8OARiDi87HELQDR8D6lZ5M9XwQ0t94niBQMc0xSc
         wPcBf8QPWQZUx8ItqJm5ke3oe2ZqSulInf78aaU5zRiWZW+Kz8UQ3l7cfygHlZbQIT2m
         Wuw3fJ5mUBHESp6Y/XpladAJbrq6wV8NhG1Se8jtQ1hv749D+xEQ+yDnEquhuefuLdtC
         BAFw==
X-Gm-Message-State: AOAM530EcCUW6Jk2HxSFAmRolKU6zAEreQ/AWceTJyja0bNPeIqu+pe2
        CNwKJzCtW04vnG4gyVIWImEjTxLPN9g=
X-Google-Smtp-Source: ABdhPJyQJEvHRc6MxKB+uK8bAiCI+Qm3tlTDPdqbpqUaQE99wDwsEotW2XQ4RapLeZS4mZKIRpuiXQ==
X-Received: by 2002:a17:907:7685:b0:6db:67:7218 with SMTP id jv5-20020a170907768500b006db00677218mr16323326ejc.461.1647198306882;
        Sun, 13 Mar 2022 12:05:06 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id n13-20020a170906724d00b006cedd6d7e24sm5856697ejk.119.2022.03.13.12.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Mar 2022 12:05:06 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH 05/16] clk: qcom: kpss-xcc: convert to parent data API
Date:   Sun, 13 Mar 2022 20:04:08 +0100
Message-Id: <20220313190419.2207-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220313190419.2207-1-ansuelsmth@gmail.com>
References: <20220313190419.2207-1-ansuelsmth@gmail.com>
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

