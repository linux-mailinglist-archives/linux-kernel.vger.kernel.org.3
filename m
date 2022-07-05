Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA9E567900
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 22:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbiGEU5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 16:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232671AbiGEU5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 16:57:33 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6632140AA;
        Tue,  5 Jul 2022 13:57:32 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id fd6so16842789edb.5;
        Tue, 05 Jul 2022 13:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YzeSfz6dKxC0YWd2Gn+465VZcjebb0Kt+/rRxTIo9ME=;
        b=C8Zmcobf7OdZhkR+lwcMLPSDf8wfeuIbsbSl/ayiMXqOzKJvy6t5qCxGW/eR+qSZQN
         z7EwCFgfBgd8pVzU4/PO9BpS9o+IipT1L3jCbGV81GusGpTx3vIsmE7M3XP+GMN8GVCl
         ImlkHPCm6812/XFyDjuvzOdT1mkHgAvYkfKjMditUmIzyWLKMk9L4HDNfv1LjdpM9HPD
         ZzH/wBV4oHCTafi//2rBeWoC/K0qLTNXV4MZfjwpiJ7wCIe6xwx/IHAunvpeAF832ifI
         D85EMHkWPrF0tECCeaT8JLkHQv2eFG4sJknYUzovId9wCItFtdJlNh5OtJIyQESjbNk+
         pyyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YzeSfz6dKxC0YWd2Gn+465VZcjebb0Kt+/rRxTIo9ME=;
        b=QRQfgGUfY19IfXzUP/bbHi6CZg470rTa9rkP8RrbnMkIREObLFYSCIKxumc7oFIgwo
         meRoewBI1UdhOQEgdmTE12V5gbe1y5mCrpFShIYbA02W6Iq1E7WtG+umYb+AA4cI/hRl
         mLE3gKDsp26XuDRWyiKu4GOz3Yt+pSElEbKu+XQqSs1U3TjaIxof6OG4BbScTHiJY5IY
         hN1oCkoM2w7WC0zUx/mu0F0F9iWq61z0MfPHnUaO+ZMtLxTmkJPIpNcI0/leBmDZm8xE
         IVooKwhuK1txTISfdFFDduAz7InI6h2ho8AUhXdaaZn5Dkl6OPavjzrLRtOnki/ueBzS
         Z/KA==
X-Gm-Message-State: AJIora9bU6Z6+yr6xZKW1D7U4QxcHSwLojZmd7JJRf5Zuu9JFt1WpFPL
        0r2DkcGc/q5UIASwkcc+Wcc=
X-Google-Smtp-Source: AGRyM1vPjW9CIqm1k+DoMFEPeeyiYyc+BoO3VRXbbGctsaTtnrI1wvbh8j+f6oMXewkCZE5bcq/nqQ==
X-Received: by 2002:a05:6402:34c8:b0:437:74d5:f8df with SMTP id w8-20020a05640234c800b0043774d5f8dfmr48652572edc.274.1657054651193;
        Tue, 05 Jul 2022 13:57:31 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id s6-20020a1709062ec600b00711d88ae162sm16249037eji.24.2022.07.05.13.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 13:57:30 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH 2/2] clk: qcom: kpss-xcc: convert to parent data API
Date:   Tue,  5 Jul 2022 22:30:33 +0200
Message-Id: <20220705203033.1862-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220705203033.1862-1-ansuelsmth@gmail.com>
References: <20220705203033.1862-1-ansuelsmth@gmail.com>
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

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/clk/qcom/kpss-xcc.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/drivers/clk/qcom/kpss-xcc.c b/drivers/clk/qcom/kpss-xcc.c
index 88d4b33ac0cc..625f02696eff 100644
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
 
 static const u32 aux_parent_map[] = {
@@ -32,8 +32,8 @@ MODULE_DEVICE_TABLE(of, kpss_xcc_match_table);
 static int kpss_xcc_driver_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *id;
-	struct clk *clk;
 	void __iomem *base;
+	struct clk_hw *hw;
 	const char *name;
 
 	id = of_match_device(kpss_xcc_match_table, &pdev->dev);
@@ -55,24 +55,16 @@ static int kpss_xcc_driver_probe(struct platform_device *pdev)
 		base += 0x28;
 	}
 
-	clk = clk_register_mux_table(&pdev->dev, name, aux_parents,
-				     ARRAY_SIZE(aux_parents), 0, base, 0, 0x3,
-				     0, aux_parent_map, NULL);
+	hw = devm_clk_hw_register_mux_parent_data_table(&pdev->dev, name, aux_parents,
+							ARRAY_SIZE(aux_parents), 0,
+							base, 0, 0x3,
+							0, aux_parent_map, NULL);
 
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
2.36.1

