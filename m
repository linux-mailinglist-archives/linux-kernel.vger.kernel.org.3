Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 206D54E317A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 21:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353192AbiCUULa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 16:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353077AbiCUUKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 16:10:08 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FFD3183800
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 13:08:09 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id h23so21608691wrb.8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 13:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y7w+zqe3BXjvjhchXa/pBa1pkRP5bMMQhUOTBznLw9o=;
        b=Ar1L+2wA/o0Q1EkoN38a9f7c73jKiqze4tO2slfF6d+t30zZ8dQqDCYQRkjeBh8Dsk
         hMqHjcCm501iWNMalE6VUn1bq4XXKr2jB6GfraCpwiy7Pqngk/r5jlkrzyKaYS3CJTPa
         /6KwzzhqH6cBSkf957di2qKLlZQ8uk0wLnwHw4WLAb2Df5e2DoRI0DH6F6msPQXwRlzH
         7Q5fLQXJV+jWxt05rCTdWUN912h2wBHsZ1wQZ6fN6sFNMOdVpwQCOTdaU4/gaGaHVwcb
         VARjhoj3Ln1MuUSNWL4eh1CE7CG5zxjF9+DVJ1X41IRPGjC87rthU+Dg4dTOeZnPh3IE
         HhcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y7w+zqe3BXjvjhchXa/pBa1pkRP5bMMQhUOTBznLw9o=;
        b=SnkE8V8lfrJZI2oJaplLvOl2fztx1fkzbyA93kr6c8apItEo5HZnvjvGnxxC5R5Oxj
         oGqOo4Utz6RXGdRZSGyC/9viQATbMPlYFFxXMCBbFHNGcz7Un+PGClHCRaH+dDI2P2vf
         fGcXdAJtPW4afOCafBucpmN+b9FkuAFKRWnRkHmtJ8K9tXnvHGOvWI45h05F3nnZyBDP
         6rbikEtF6b/SysPJHQX3dzLC/4+gPnAqU6TIn3X0o0CGmvop8IfKqReF4/vgQAD50jt1
         mqB2J/HRKibaGSdQwHEUQnHXtQBV7Ir8IoFOdPUBGrj6CpdAB/lwrPflbCUBlb3V7s57
         /RlQ==
X-Gm-Message-State: AOAM530uF4gNAUg3GgSHwmVUTf7xIKJEo6uEm+j8s4DVC+3oRwff1/81
        d78lF3bUBSPeg1K1yRu+sbw02Q==
X-Google-Smtp-Source: ABdhPJwsy1g21VlpFB3wtwTflfz/CG4Cqj1CkSmAuDpWHDVVKi6WMOpu+elSjE5RWqjHtlshh+yWHw==
X-Received: by 2002:adf:f20f:0:b0:203:fc73:a9a0 with SMTP id p15-20020adff20f000000b00203fc73a9a0mr12135240wro.418.1647893287604;
        Mon, 21 Mar 2022 13:08:07 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id i14-20020a0560001ace00b00203da1fa749sm24426988wry.72.2022.03.21.13.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 13:08:07 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     heiko@sntech.de, herbert@gondor.apana.org.au, krzk+dt@kernel.org,
        mturquette@baylibre.com, robh+dt@kernel.org, sboyd@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v3 23/26] crypto: rockchip: Check for maximum frequency of clocks
Date:   Mon, 21 Mar 2022 20:07:36 +0000
Message-Id: <20220321200739.3572792-24-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220321200739.3572792-1-clabbe@baylibre.com>
References: <20220321200739.3572792-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rockchip's datasheet give maximum frequencies for some clocks, so add
checks for verifying they are within limits.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/crypto/rockchip/rk3288_crypto.c | 57 +++++++++++++++++++++----
 drivers/crypto/rockchip/rk3288_crypto.h |  9 ++++
 2 files changed, 57 insertions(+), 9 deletions(-)

diff --git a/drivers/crypto/rockchip/rk3288_crypto.c b/drivers/crypto/rockchip/rk3288_crypto.c
index bb1adbe947f9..ededae9f2671 100644
--- a/drivers/crypto/rockchip/rk3288_crypto.c
+++ b/drivers/crypto/rockchip/rk3288_crypto.c
@@ -21,16 +21,58 @@
 
 static const struct rk_variant rk3328_variant = {
 	.num_instance = 1,
+	.num_clks = 3,
 };
 
 static const struct rk_variant rk3288_variant = {
-	.num_instance = 1
+	.num_instance = 1,
+	.num_clks = 3,
+	.rkclks = {
+		{ "sclk", 150000000},
+	}
 };
 
 static const struct rk_variant rk3399_variant = {
-	.num_instance = 2
+	.num_instance = 2,
+	.num_clks = 6,
 };
 
+static int rk_crypto_get_clks(struct rk_crypto_info *dev)
+{
+	int i, j, err;
+	unsigned long cr;
+
+	dev->num_clks = devm_clk_bulk_get_all(dev->dev, &dev->clks);
+	if (dev->num_clks < dev->variant->num_clks) {
+		dev_err(dev->dev, "Missing clocks, got %d instead of %d\n",
+			dev->num_clks, dev->variant->num_clks);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < dev->num_clks; i++) {
+		cr = clk_get_rate(dev->clks[i].clk);
+		for (j = 0; j < ARRAY_SIZE(dev->variant->rkclks); j++) {
+			if (dev->variant->rkclks[j].max == 0)
+				continue;
+			if (strcmp(dev->variant->rkclks[j].name, dev->clks[i].id))
+				continue;
+			if (cr > dev->variant->rkclks[j].max) {
+				err = clk_set_rate(dev->clks[i].clk,
+						   dev->variant->rkclks[j].max);
+				if (err)
+					dev_err(dev->dev, "Fail downclocking %s from %lu to %lu\n",
+						dev->variant->rkclks[j].name, cr,
+						dev->variant->rkclks[j].max);
+				else
+					dev_info(dev->dev, "Downclocking %s from %lu to %lu\n",
+						 dev->variant->rkclks[j].name, cr,
+						 dev->variant->rkclks[j].max);
+			}
+		}
+	}
+	return 0;
+}
+
 static int rk_crypto_enable_clk(struct rk_crypto_info *dev)
 {
 	int err;
@@ -281,16 +323,13 @@ static int rk_crypto_probe(struct platform_device *pdev)
 		goto err_crypto;
 	}
 
-	crypto_info->num_clks = devm_clk_bulk_get_all(&pdev->dev,
-			&crypto_info->clks);
-	if (crypto_info->num_clks < 3) {
-		err = -EINVAL;
-		goto err_crypto;
-	}
-
 	crypto_info->dev = &pdev->dev;
 	platform_set_drvdata(pdev, crypto_info);
 
+	err = rk_crypto_get_clks(crypto_info);
+	if (err)
+		goto err_crypto;
+
 	err = rk_crypto_pm_init(crypto_info);
 	if (err)
 		goto err_pm;
diff --git a/drivers/crypto/rockchip/rk3288_crypto.h b/drivers/crypto/rockchip/rk3288_crypto.h
index e1dac351bc64..8fd46cda5189 100644
--- a/drivers/crypto/rockchip/rk3288_crypto.h
+++ b/drivers/crypto/rockchip/rk3288_crypto.h
@@ -183,8 +183,17 @@
 #define RK_CRYPTO_HASH_DOUT_6		0x01a4
 #define RK_CRYPTO_HASH_DOUT_7		0x01a8
 
+#define RK_MAX_CLKS 6
+
+struct rk_clks {
+	const char *name;
+	unsigned long max;
+};
+
 struct rk_variant {
 	int num_instance;
+	int num_clks;
+	struct rk_clks rkclks[RK_MAX_CLKS];
 };
 
 struct rk_instance {
-- 
2.34.1

