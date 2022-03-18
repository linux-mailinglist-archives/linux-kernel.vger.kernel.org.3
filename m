Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06DF74DDDE4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 17:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238597AbiCRQKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 12:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238452AbiCRQJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 12:09:54 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8B34FC46;
        Fri, 18 Mar 2022 09:08:35 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id ja24so12523704ejc.11;
        Fri, 18 Mar 2022 09:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=KJy+bVD9Yq3kRrz9Gx7NWpfnxrb/beBV0JaHxbyWaTA=;
        b=nFRf8ahYGpA1x0VacaTigxdCKWLvbB58VsYm2jh0AtNZyxcuI/Vdwu8jNvyk6YGTxW
         3WaBMCWYBw2rW0BZ4e25aaMEjD/BNhRIS6WnId8S0sTK0LNt6Yuno4VcrobyKTrcmvHf
         xbeX1Xn90+y2gsgzfGke4tdifbrCFfaG+MCP92Sj987N2Tio5cZnsASrWwQGGYA+tmni
         qpkLIVfNgWgm/F84j93LccOBhtUvIMKFa2OIDNSEFDJmVCxpWGY0Aargg4R2aGU0Bs8U
         3LdO5MO+NY49KWe9welKxidfZX7TDQD8pDn2s1gsaiIN3qWrf7sHgSwDuzUdzOIIwvTC
         yCZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KJy+bVD9Yq3kRrz9Gx7NWpfnxrb/beBV0JaHxbyWaTA=;
        b=4FeLuV1FzXwjUM/T1Aozd5wnTSJxEWx7WOiR4m/WkJi3MKsW4i0CCdgmDxkMvy4BXG
         KQSXDvaSHr6gQLSPo+r3crUlhXakZqeU0QnK6EFnAAGQqsuGwPyhY+KLjMcO2G6fbdNS
         +OL+pAA0PZRbTPd+1EGeQOsGj6YGmr36jhaYwRBS6VjU33e9SlNtJzxdc99vSZaNU0fs
         PoK3rHgJnz2r+yQg2Po5L4CCSwBWLM+FVSGoP5RfrSeEt6k2x4ajZc4oO8Lp/vhk8KOV
         6uSEQ5yVkpGMWV+qdrGPqYnq/cp7s7mqLr0u5u2m6z/HLQt0h9x7AH+1cikGW6KOnpw3
         ukyg==
X-Gm-Message-State: AOAM533msziJARA/j8rw4XkfoH0pF8RCj9HuyfEvYD7dVYxHS578wkQL
        xe8mlXPCQyvMobDO8j9kvcM=
X-Google-Smtp-Source: ABdhPJy9nmoIz+paAY/jLeL0eZrAk6Bhll0kYEG6X+zp+M2E84b/Q8etgY/8YkQoKm+D4ze0bGg0CA==
X-Received: by 2002:a17:906:6547:b0:6bd:e2ad:8c82 with SMTP id u7-20020a170906654700b006bde2ad8c82mr9186558ejn.693.1647619714335;
        Fri, 18 Mar 2022 09:08:34 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-69-170.ip85.fastwebnet.it. [93.42.69.170])
        by smtp.googlemail.com with ESMTPSA id e9-20020a170906c00900b006d4a45869basm3754118ejz.199.2022.03.18.09.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 09:08:34 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v2 05/16] clk: qcom: kpss-xcc: convert to parent data API
Date:   Fri, 18 Mar 2022 17:08:16 +0100
Message-Id: <20220318160827.8860-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220318160827.8860-1-ansuelsmth@gmail.com>
References: <20220318160827.8860-1-ansuelsmth@gmail.com>
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

