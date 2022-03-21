Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13D984E2BCE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 16:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350035AbiCUPTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 11:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349907AbiCUPTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 11:19:17 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B57F111DF9;
        Mon, 21 Mar 2022 08:17:52 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id a1so19788809wrh.10;
        Mon, 21 Mar 2022 08:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=KJy+bVD9Yq3kRrz9Gx7NWpfnxrb/beBV0JaHxbyWaTA=;
        b=MjtQAPTGqq16xDSgcCRIsMh4HXuzyMvVlEOEy//RsK4Aveijz9EHXKEDl7K7jmTW2h
         oiH4FEZ8Kieum491jlrMvjrLEElqVh5cixSr4PHhoWtLFJcEcmMhrFTAMB3ic4ppHkxl
         OTk7b7AtzwueT6FxWZ5RfRGtNJJwl00h+qS07cI/HBaJS3sbYNVRA3U3zE7Oc7xqpuih
         8+uxLDadPlc1Fuo/0YTN6i5QvsJx9cSNOL8MSuFvtw6CSpj85JsD5QjQ6xD0IMICPysg
         aOpb0NlAqcVELzG/giEBslIVjweH9ihYdlSOTCfCDZGZOvCoVgV0hKoxNtWAY+OHDd+X
         Af5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KJy+bVD9Yq3kRrz9Gx7NWpfnxrb/beBV0JaHxbyWaTA=;
        b=uQtn6BgJcu9uCZlDF4lOJQahcyUJbVuGeziFwMsXA8GyYkHdcbSaLOfYAC8TOYxfbV
         mfx6e/GA0eUr/R441xmJ1Ua2yO+F3EmykbvAZ0wbfcUldptX8y9uVr7RH0RqPNseCLqj
         njeM3JIiXN8xmQZRVtXhY7/qWTFWI8v7uAOLoZDcG1QXihHpX0vY6uncAzXvQ7Ld7nfK
         DWaj2I8f/ssf1lakeMcjRwGpMBzMua9ojgf6YXxAtJ74wsddftODGAz2t4EWP7uboppz
         MsMTgLK1GQJrpR6kbG5Cu80Nl66yuJ0OAkTvKGEVnWF083m8yblIgXS2GTF7+vpRkxC0
         5qrw==
X-Gm-Message-State: AOAM533jYFX8xhADboQnyQ59qs3q0SIP16QUFRc2Tcy62lx+VedYDRmy
        0Ua1yhQfTuWTYzIEK/emDX8=
X-Google-Smtp-Source: ABdhPJxKvFg85nJAodJVi4K6pIOciC75yYvZK4SfuktnHR362uHPUwJAA76+yI7cSZqGB1L18ZCe+A==
X-Received: by 2002:a05:6000:1a89:b0:204:1fc8:ea61 with SMTP id f9-20020a0560001a8900b002041fc8ea61mr346959wry.171.1647875870819;
        Mon, 21 Mar 2022 08:17:50 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-69-170.ip85.fastwebnet.it. [93.42.69.170])
        by smtp.googlemail.com with ESMTPSA id 10-20020a5d47aa000000b00204012e4373sm7239729wrb.101.2022.03.21.08.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 08:17:50 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v4 05/18] clk: qcom: kpss-xcc: convert to parent data API
Date:   Mon, 21 Mar 2022 15:48:12 +0100
Message-Id: <20220321144825.11736-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220321144825.11736-1-ansuelsmth@gmail.com>
References: <20220321144825.11736-1-ansuelsmth@gmail.com>
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

