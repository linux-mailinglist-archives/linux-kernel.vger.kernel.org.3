Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0A94C2EF0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 16:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235778AbiBXPEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 10:04:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235692AbiBXPD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 10:03:58 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87DF4141FD5;
        Thu, 24 Feb 2022 07:03:27 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id r10so96587wrp.3;
        Thu, 24 Feb 2022 07:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=08kWMu8EWgkGMNZO7oAp0aMUwUz5/Yejkwq/Vcz2uh0=;
        b=gTHMAiinkyBPE+VQqjN7qQEaLUqMvBPDz569RmrRaBcRGhzfuC4E62j3ENRvr9mCOC
         O2MeHYJGRZS1U+ry9PvNBBeg0nN0Qc3QVohtiCIA3fuHDXisivv8qDiLKcXhUviq4qq/
         8zu/2ru/QQvVas9YGVJ1j4c8CfYOXS2kderdXulmOQR6hGjQL2zyfjcirAd3qyrUHmE8
         zCyyrmx8A/BpnPpdukQ67gcVxthWmbLjEK5ydiXUGN0iqNt0Z2SqIGslrhzPDISY0w3/
         NLbNoVgt56xAe2XD5UqPG7HsNTnM+vSiQ9R7L7jD0NRgPR0+eqB0XTj6KuRjK2DRCWes
         8YmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=08kWMu8EWgkGMNZO7oAp0aMUwUz5/Yejkwq/Vcz2uh0=;
        b=5CqJZWK8TNDEbHsci0laxQuTVvqLvcMTCAwD0vfX6m+Z/MpGXI5JMijhWCgPaXgA3C
         kXyfkK3lWU6B+b0k6jESA5LDkcw+qs5I94598YpWuzwdDRjpcMN3duBo2cBvmroMaoTE
         joBr/7jCs4o9mJixNtJRQxErsBAgubB3wMOhd6wjW6ysX1LRshCcL0WZ+FyMn6N+ws5k
         cTFb2YZDIMAxVBQ+GWX6YeQq3J/D6DaT9J9c4aVQ0ROjjA9hB1m03Jae1L91vANE1WdH
         J5cxwsJr1l/Ey4un0rqj2AzLhdddVFl+1klk9/JfFwuourHR+/F0Xw9u4TVp/p39mRwS
         h4Ow==
X-Gm-Message-State: AOAM5316J/U7YESHzUog6pDfLd9t/cxzPwJRws37D0oiWYwxJtWI3eiD
        4qV/dLrMikcNd8GxgfCFNNQ=
X-Google-Smtp-Source: ABdhPJxtGuHxidUOxzvC+NL9qNBASYdVy+OU8CEHL0/hLOX3ZZRNXnfkO39PVZuIEPbAGiqK0KHvMg==
X-Received: by 2002:adf:f049:0:b0:1ee:7523:ed53 with SMTP id t9-20020adff049000000b001ee7523ed53mr1477081wro.586.1645715006148;
        Thu, 24 Feb 2022 07:03:26 -0800 (PST)
Received: from localhost (92.40.203.111.threembb.co.uk. [92.40.203.111])
        by smtp.gmail.com with ESMTPSA id w13sm3088645wrv.21.2022.02.24.07.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 07:03:25 -0800 (PST)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     paul@crapouillou.net, robh+dt@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org
Cc:     linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] clk: ingenic-tcu: Fix missing TCU clock for X1000 SoC
Date:   Thu, 24 Feb 2022 15:03:27 +0000
Message-Id: <20220224150326.525707-3-aidanmacdonald.0x0@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220224150326.525707-1-aidanmacdonald.0x0@gmail.com>
References: <20220224150326.525707-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The X1000 and X1830 have a TCU clock gate, so pass it to the driver.
Without this the TCU can be gated automatically, which prevents timers
from running.

Add a workaround to allow the driver to probe even if the TCU clock
is missing on the affected SoCs; in this case the TCU clock is ignored,
as it was before. With workarounds like "clk_ignore_unused" on the
kernel command line, this allows users who upgrade the kernel but use
the old device tree to boot successfully. They will now get a warning
encouraging them to update the device tree.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/clk/ingenic/tcu.c | 37 +++++++++++++++++++++++++++----------
 1 file changed, 27 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/ingenic/tcu.c b/drivers/clk/ingenic/tcu.c
index 77acfbeb4830..03e9553bcac4 100644
--- a/drivers/clk/ingenic/tcu.c
+++ b/drivers/clk/ingenic/tcu.c
@@ -31,6 +31,7 @@ struct ingenic_soc_info {
 	unsigned int num_channels;
 	bool has_ost;
 	bool has_tcu_clk;
+	bool allow_missing_tcu_clk;
 };
 
 struct ingenic_tcu_clk_info {
@@ -320,7 +321,8 @@ static const struct ingenic_soc_info jz4770_soc_info = {
 static const struct ingenic_soc_info x1000_soc_info = {
 	.num_channels = 8,
 	.has_ost = false, /* X1000 has OST, but it not belong TCU */
-	.has_tcu_clk = false,
+	.has_tcu_clk = true,
+	.allow_missing_tcu_clk = true,
 };
 
 static const struct of_device_id __maybe_unused ingenic_tcu_of_match[] __initconst = {
@@ -355,14 +357,29 @@ static int __init ingenic_tcu_probe(struct device_node *np)
 		tcu->clk = of_clk_get_by_name(np, "tcu");
 		if (IS_ERR(tcu->clk)) {
 			ret = PTR_ERR(tcu->clk);
-			pr_crit("Cannot get TCU clock\n");
-			goto err_free_tcu;
-		}
 
-		ret = clk_prepare_enable(tcu->clk);
-		if (ret) {
-			pr_crit("Unable to enable TCU clock\n");
-			goto err_put_clk;
+			/*
+			 * Old versions of this driver incorrectly specified
+			 * some SoCs as not having a TCU clock, so old device
+			 * trees didn't define one. We try to allow the kernel
+			 * to boot with an old device tree by just continuing
+			 * on without the clock and hoping it won't get turned
+			 * off (eg. with "clk_ignore_unused" kernel argument).
+			 */
+			if (ret == -EINVAL &&
+			    tcu->soc_info->allow_missing_tcu_clk) {
+				pr_warn("TCU clock missing from device tree, please update your device tree\n");
+				tcu->clk = NULL;
+			} else {
+				pr_crit("Cannot get TCU clock\n");
+				goto err_free_tcu;
+			}
+		} else {
+			ret = clk_prepare_enable(tcu->clk);
+			if (ret) {
+				pr_crit("Unable to enable TCU clock\n");
+				goto err_put_clk;
+			}
 		}
 	}
 
@@ -432,10 +449,10 @@ static int __init ingenic_tcu_probe(struct device_node *np)
 			clk_hw_unregister(tcu->clocks->hws[i]);
 	kfree(tcu->clocks);
 err_clk_disable:
-	if (tcu->soc_info->has_tcu_clk)
+	if (tcu->clk)
 		clk_disable_unprepare(tcu->clk);
 err_put_clk:
-	if (tcu->soc_info->has_tcu_clk)
+	if (tcu->clk)
 		clk_put(tcu->clk);
 err_free_tcu:
 	kfree(tcu);
-- 
2.34.1

