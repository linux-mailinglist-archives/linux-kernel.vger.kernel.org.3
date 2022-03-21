Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB75A4E3149
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 21:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353008AbiCUUKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 16:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352985AbiCUUJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 16:09:41 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2ACE108542
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 13:08:01 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id b19so22194804wrh.11
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 13:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+HaTfNod3aEyDePLcyY2jAUHNy+p+ObhCTXVNT/SKZc=;
        b=emOhvDacn9fqoR2jXRzNDjn/fMmRrieuSeznEfikBdGRSkW2QwjxouH81+Fwjh0AFd
         evXQ4E/OjsZlquw1PFRoq0qZ8V1uU2dFw1KW4yypwDaSb1WSt5zeJgWlg5AYy9384SQ3
         EpD6THUKpqH7hPQTQY08PbmuT8BAv4OnTUVoUfDp5LtFeplmVBFPr3+8hTR4tBIHhOeF
         3vG09MypOc4eMpOZxMnmImtm/CgbL7xv9hLR14dx73f+uOss+jTDm/5foL1JamFERmKp
         x1ttW1tsMfncnHvuIpVhHHrNp5HQlCPINjlHk+DHdfCdKbg5tZiKZ5O664jCsB5wZ5Z7
         ikWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+HaTfNod3aEyDePLcyY2jAUHNy+p+ObhCTXVNT/SKZc=;
        b=DW/c0SioIMsS5lV9HMNtHHemy/uPgSCdmQxB5ApSMsdCkoq7AsNV2bTtJAM4jaIJoe
         YpAaJ+Ei4gOZVpHshLecY/qjHCc7e95ctU2GOq3AOpW+zWDooOmm9fsKMTIdXEGdRXih
         QrPXi45lpJgmBn0THJp3xxiadgovhYRf3KTtXus8DO4bqXZ1fxqHSe74OLFIcFLx3MDL
         tdR0eVC2r0AJWICc4C6HD3DENp8w14ar2ZbHcNwQmWakzONc4omHQIfGvzFmC1PMB/v2
         bJ+L6pBygbQoHYO36y2Me8pD8AeWXuhB2IyI3rdSV5NFPNNvsq3psRf3mo87fjKrJ8ba
         /0yw==
X-Gm-Message-State: AOAM531Cqga7vvHLhFtRAs8c/+kaCJdgZq8a/vHHIegDYAlBbCTdNGKS
        cBiltoxjN4jtbwJUWjl8at0O4w==
X-Google-Smtp-Source: ABdhPJwHFqbCE5MwjHAeF2xKY2Y2VcS4CCDMlY5kasTggHm29bdfQnRql04xP+EjlytxwV7aRGHYZg==
X-Received: by 2002:adf:df8c:0:b0:203:e4f3:920 with SMTP id z12-20020adfdf8c000000b00203e4f30920mr19305159wrl.461.1647893280338;
        Mon, 21 Mar 2022 13:08:00 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id i14-20020a0560001ace00b00203da1fa749sm24426988wry.72.2022.03.21.13.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 13:08:00 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     heiko@sntech.de, herbert@gondor.apana.org.au, krzk+dt@kernel.org,
        mturquette@baylibre.com, robh+dt@kernel.org, sboyd@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v3 14/26] crypto: rockchip: handle reset also in PM
Date:   Mon, 21 Mar 2022 20:07:27 +0000
Message-Id: <20220321200739.3572792-15-clabbe@baylibre.com>
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

reset could be handled by PM functions.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/crypto/rockchip/rk3288_crypto.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/crypto/rockchip/rk3288_crypto.c b/drivers/crypto/rockchip/rk3288_crypto.c
index d9258b9e71b3..a11a92e1f3fd 100644
--- a/drivers/crypto/rockchip/rk3288_crypto.c
+++ b/drivers/crypto/rockchip/rk3288_crypto.c
@@ -73,6 +73,8 @@ static int rk_crypto_pm_suspend(struct device *dev)
 {
 	struct rk_crypto_info *rkdev = dev_get_drvdata(dev);
 
+	reset_control_assert(rkdev->rst);
+
 	rk_crypto_disable_clk(rkdev);
 	return 0;
 }
@@ -81,6 +83,8 @@ static int rk_crypto_pm_resume(struct device *dev)
 {
 	struct rk_crypto_info *rkdev = dev_get_drvdata(dev);
 
+	reset_control_deassert(rkdev->rst);
+
 	return rk_crypto_enable_clk(rkdev);
 }
 
@@ -222,13 +226,6 @@ static void rk_crypto_unregister(void)
 	}
 }
 
-static void rk_crypto_action(void *data)
-{
-	struct rk_crypto_info *crypto_info = data;
-
-	reset_control_assert(crypto_info->rst);
-}
-
 static const struct of_device_id crypto_of_id_table[] = {
 	{ .compatible = "rockchip,rk3288-crypto" },
 	{}
@@ -254,14 +251,6 @@ static int rk_crypto_probe(struct platform_device *pdev)
 		goto err_crypto;
 	}
 
-	reset_control_assert(crypto_info->rst);
-	usleep_range(10, 20);
-	reset_control_deassert(crypto_info->rst);
-
-	err = devm_add_action_or_reset(dev, rk_crypto_action, crypto_info);
-	if (err)
-		goto err_crypto;
-
 	crypto_info->reg = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(crypto_info->reg)) {
 		err = PTR_ERR(crypto_info->reg);
-- 
2.34.1

