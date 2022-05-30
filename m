Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 403C653840E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 17:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242455AbiE3OzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 10:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240373AbiE3On4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 10:43:56 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A492685EF8
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 06:55:44 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id k16so10411546wrg.7
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 06:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xw66Rm/stx5LdYx2rVfwLOupkCkZYlXybZKzqQavPCw=;
        b=tcCeuGat82kxq/tRnolJqUxQecH9kOW5WFXPEM5DGqSbcF+ZnIHNmjfaZY7/UJTtoU
         E+s5JYjoWhMxM7k7Jjip+G26kUqlbZXkZa+XpHn6By8vKcycMQT3nvxt5CeEjyXR59om
         hXBEkp7JCEAJFfytoYtsnxxEv/J32OEIGXqHy/DYTpxaQnEteeVtOU5zIj0Slu2tWTo3
         SZvPX/X5iNoNSoDQVgYCsImovxymg1hBSmTFRfr5g7ZdeIyyun3UEYPuPXuNdiVATbc0
         XybcHs5DB/AW8/zTwWYDDe0KijSDUalJqoq4aM06KqKI3JShKSrG5xTDRmDsLr/QbNVg
         LX3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xw66Rm/stx5LdYx2rVfwLOupkCkZYlXybZKzqQavPCw=;
        b=2WqFhhkqH7em8SjkuGNZ+ljGgVe0mEvhbWa2gVDPVdJq6YyDcRqbDN9PMkcWCx8FvJ
         /6DZEPrpiC4pJtnSMe+wxTRQ38eEh7p2XClgBOs3p2BxxN4jW9XYQc8ExHINnzMvO2In
         9qxb1oJCvA8ab5NeXZ1XQu21rq5OZKtpAEAqGOim8mhMAUmb6AedJRzZJFktPzg8tpG4
         6rJztrU36VZ2WKKE6Qrx7ciohSZZsu6MSITkZCtF4L3I52lemmNiO1Mk0GbMs87zEO3M
         30nKYEczTZUisuFKjL/EuMEd44Baj89QWjRBPetpGqeGVIAcLOL1fm7HUiRVvoSBnctT
         4XvA==
X-Gm-Message-State: AOAM5338aS24m8d8hvgxeETvwABYa4bejYA/kIkMZ7h4QPoSGxkMbIgx
        xUQ2OAKe9Lg1pp0atVlkLiuH3w==
X-Google-Smtp-Source: ABdhPJyZArKkXHwklacwoXIj8QPwSo171Bv6oYmc4UVF5gdv7tBrH85atnkzcmtB3PGbgTH3iciK+w==
X-Received: by 2002:a5d:5743:0:b0:210:dd:98c8 with SMTP id q3-20020a5d5743000000b0021000dd98c8mr20932592wrw.259.1653918943273;
        Mon, 30 May 2022 06:55:43 -0700 (PDT)
Received: from localhost.localdomain ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id w9-20020adfee49000000b0020cfed0bb7fsm9214856wro.53.2022.05.30.06.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 06:55:42 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Fabien Parent <fparent@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] soc: mediatek: pwrap: add support for sys & tmr clocks
Date:   Mon, 30 May 2022 15:55:21 +0200
Message-Id: <20220530135522.762560-2-fparent@baylibre.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220530135522.762560-1-fparent@baylibre.com>
References: <20220530135522.762560-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MT8365 requires an extra 2 clocks to be enabled to behave correctly.
Add support these 2 clocks, they are made optional since they seem to
be present only on MT8365.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 drivers/soc/mediatek/mtk-pmic-wrap.c | 36 ++++++++++++++++++++++++----
 1 file changed, 32 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
index bf39a64f3ecc..8dea5e14d73e 100644
--- a/drivers/soc/mediatek/mtk-pmic-wrap.c
+++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
@@ -1163,6 +1163,8 @@ struct pmic_wrapper {
 	const struct pwrap_slv_type *slave;
 	struct clk *clk_spi;
 	struct clk *clk_wrap;
+	struct clk *clk_sys;
+	struct clk *clk_tmr;
 	struct reset_control *rstc;
 
 	struct reset_control *rstc_bridge;
@@ -2250,6 +2252,20 @@ static int pwrap_probe(struct platform_device *pdev)
 		return PTR_ERR(wrp->clk_wrap);
 	}
 
+	wrp->clk_sys = devm_clk_get_optional(wrp->dev, "sys");
+	if (IS_ERR(wrp->clk_sys)) {
+		return dev_err_probe(wrp->dev, PTR_ERR(wrp->clk_sys),
+				     "failed to get clock: %pe\n",
+				     wrp->clk_sys);
+	}
+
+	wrp->clk_tmr = devm_clk_get_optional(wrp->dev, "tmr");
+	if (IS_ERR(wrp->clk_tmr)) {
+		return dev_err_probe(wrp->dev, PTR_ERR(wrp->clk_tmr),
+				     "failed to get clock: %pe\n",
+				     wrp->clk_tmr);
+	}
+
 	ret = clk_prepare_enable(wrp->clk_spi);
 	if (ret)
 		return ret;
@@ -2258,6 +2274,14 @@ static int pwrap_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_out1;
 
+	ret = clk_prepare_enable(wrp->clk_sys);
+	if (ret)
+		goto err_out2;
+
+	ret = clk_prepare_enable(wrp->clk_tmr);
+	if (ret)
+		goto err_out3;
+
 	/* Enable internal dynamic clock */
 	if (HAS_CAP(wrp->master->caps, PWRAP_CAP_DCM)) {
 		pwrap_writel(wrp, 1, PWRAP_DCM_EN);
@@ -2272,7 +2296,7 @@ static int pwrap_probe(struct platform_device *pdev)
 		ret = pwrap_init(wrp);
 		if (ret) {
 			dev_dbg(wrp->dev, "init failed with %d\n", ret);
-			goto err_out2;
+			goto err_out4;
 		}
 	}
 
@@ -2286,7 +2310,7 @@ static int pwrap_probe(struct platform_device *pdev)
 	if (!(pwrap_readl(wrp, PWRAP_WACS2_RDATA) & mask_done)) {
 		dev_dbg(wrp->dev, "initialization isn't finished\n");
 		ret = -ENODEV;
-		goto err_out2;
+		goto err_out4;
 	}
 
 	/* Initialize watchdog, may not be done by the bootloader */
@@ -2319,7 +2343,7 @@ static int pwrap_probe(struct platform_device *pdev)
 			       IRQF_TRIGGER_HIGH,
 			       "mt-pmic-pwrap", wrp);
 	if (ret)
-		goto err_out2;
+		goto err_out4;
 
 	wrp->regmap = devm_regmap_init(wrp->dev, NULL, wrp, wrp->slave->regmap);
 	if (IS_ERR(wrp->regmap)) {
@@ -2331,11 +2355,15 @@ static int pwrap_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_dbg(wrp->dev, "failed to create child devices at %pOF\n",
 				np);
-		goto err_out2;
+		goto err_out4;
 	}
 
 	return 0;
 
+err_out4:
+	clk_disable_unprepare(wrp->clk_tmr);
+err_out3:
+	clk_disable_unprepare(wrp->clk_sys);
 err_out2:
 	clk_disable_unprepare(wrp->clk_wrap);
 err_out1:
-- 
2.36.1

