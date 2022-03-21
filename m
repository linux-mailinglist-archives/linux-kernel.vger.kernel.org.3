Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 989224E2D5A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 17:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350766AbiCUQKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 12:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350680AbiCUQJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 12:09:48 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C96F26AFD;
        Mon, 21 Mar 2022 09:08:22 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id l1-20020a05600c4f0100b00389645443d2so8666761wmq.2;
        Mon, 21 Mar 2022 09:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=KJy+bVD9Yq3kRrz9Gx7NWpfnxrb/beBV0JaHxbyWaTA=;
        b=qtxn9wGOGQrzvmBXl6/3MZDDb0difxVX7vVZ1tfjO1Xvx9+DiIQw+uSwfNncvh7mmt
         X3dgcEICqi2t91JsYM4J8PcxZbgKckgH8cUv+IxkPl4KP7N9AxvfA0AjwtevXioiK40Z
         VVB9hNUoH/6VhyW1Oo5xlrx5zZGSUrHazhdwYdEOEALO0R+GFBwArY45UYIuF6IB9/H6
         2j3zyd3MtshgasETkPDP9NepbRQoVvjnivRnyMCcvvHH+LH1xSutOvhzJ4Fy/YlooBs7
         2AxsW4NB4xctChB7W58cohStzLUzGyJpA83tX3ajivfvn8yBFhQ06LX48kbiG0o8vUCd
         3vLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KJy+bVD9Yq3kRrz9Gx7NWpfnxrb/beBV0JaHxbyWaTA=;
        b=MAjr8lFnyQod2h/inbE+VFP3yxmvL/yA6pRKl0tKYn0/ktzlqViGUZpPbBjXXP6Drx
         4ATj4z4HGTA1WpcEaFbP217MowJVh1zMDo43ILP4Hl0jY10EefKRRuGHVivgGllNwXLs
         fZxV8YCatgNPpTXoXez8n/NkfBAxD1hQDkeQFrBaes3wosoqvuo+r/ySNFWt845A7cuO
         owNifhdnu/+Y+yfHQIDFeIixuu/J3wjzh67vbr66odzJDJPRmTdUcRrYtr26jFohLyeH
         TmrmveH+A3/gId2KLrSL2lG9a613gacwkr9b35sD4scUmAnZVcaBu+DRaKyYjrzeldAV
         F9uw==
X-Gm-Message-State: AOAM532SD6hFm+bUp39RDJOVxk6fuNpvyPqCwkxZcu3BfLDwAB9Z60Zq
        ZDLY+3JDJl6uowO2WKBHqh4=
X-Google-Smtp-Source: ABdhPJwMdwK+Xc3LVIdaevR72KFlksW5UfZWSO57kyHVMquIlBBbrK6LFXKqJTnZAPedDVWtjmkiNA==
X-Received: by 2002:a05:600c:4e53:b0:38c:987e:cdc with SMTP id e19-20020a05600c4e5300b0038c987e0cdcmr9845192wmq.154.1647878900699;
        Mon, 21 Mar 2022 09:08:20 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-69-170.ip85.fastwebnet.it. [93.42.69.170])
        by smtp.googlemail.com with ESMTPSA id az19-20020a05600c601300b0038cadf3aa69sm2603864wmb.36.2022.03.21.09.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 09:08:20 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v5 05/18] clk: qcom: kpss-xcc: convert to parent data API
Date:   Mon, 21 Mar 2022 16:38:42 +0100
Message-Id: <20220321153855.12082-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220321153855.12082-1-ansuelsmth@gmail.com>
References: <20220321153855.12082-1-ansuelsmth@gmail.com>
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

