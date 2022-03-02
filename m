Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 440F74CB0DE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 22:13:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245207AbiCBVMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 16:12:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245118AbiCBVMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 16:12:13 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB86D205D
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 13:11:25 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id x15so4706857wru.13
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 13:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B4Tf8ps8Giknxs7LQki4ZGeia2acPTQFjucag6hcCiQ=;
        b=qWH4UXD2/XPcCp9fm8xXwAshYS4tc/CUXtc2uubCPvniyywLyxaml90tAQR59l/P1A
         2aKv7bUtzWzYQ3S7xmrY2xqtX988cCK/uvEMfW0q9bXXg8PbpFv94D42gZ1JuYP2wjnK
         JIV8mHOETs5IBnfEthCUHruqxplzo7ZHA47duBbY5g4wAHhFs+xiiiNwH3Olu36pF2qD
         U7CN/Cr+6GorNkBuDNDJiYvYLPw8gKqgW1WbYMwChBzuCpt5tvCHd+yzkgWJHCXMRxM9
         +CeNBc5nBdulz/HRokTD1cOJXVdV/Zn11OGYjS+dehHGnwlVn0AUphRIuHh5myy/B48Q
         n4/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B4Tf8ps8Giknxs7LQki4ZGeia2acPTQFjucag6hcCiQ=;
        b=7usKVhSzxyV6ke5OymlEc4zJ4ZXH05oZfdvxftMihcV8lwkeuArRFKqjoVIGJ0wYdo
         cQr90ctzhsxqqf6MXN6qzDupsDb0qdJOr63Rl55dGOnVXr0e6vsEBRzWEq0a2ex9oRNn
         VwRcqFVOqAb/GSZAeX8cjlayzfiyC1FubuzfIjVfgUy4YcBezioPRXdhA8hi2VwImyW5
         SOhhLBRQo5UDyTbFkv1yv4XEcyZNGgzO1m00oOUFik+m9ZPhynu/vPW0Kqhd1rxO/bZr
         dSPky8SY6n5aC04TpcEtxVi7wzUeOWzBJjBDcfBnKOpp+WEhPKLveN42drCXBJmsHqCQ
         WLGg==
X-Gm-Message-State: AOAM531di5WWYz7bi6ULgF1cYr9CLUY612UzTCJA4WlBrAzF7WdGwrr/
        GdRnkl8JScxC50Ehh8hoZDxLNw==
X-Google-Smtp-Source: ABdhPJy8UJKYTq/gnyeSX8atQZtgLFqkKuFQj+B+6mjLkl5a4vVgucpywjrYJ37k4zl8awGraqZMgw==
X-Received: by 2002:a5d:6103:0:b0:1ed:9e65:b090 with SMTP id v3-20020a5d6103000000b001ed9e65b090mr23743120wrt.332.1646255483922;
        Wed, 02 Mar 2022 13:11:23 -0800 (PST)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id z5-20020a05600c0a0500b0037fa93193a8sm145776wmp.44.2022.03.02.13.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 13:11:23 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     heiko@sntech.de, herbert@gondor.apana.org.au, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, john@metanate.com,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v2 01/18] crypto: rockchip: use dev_err for error message about interrupt
Date:   Wed,  2 Mar 2022 21:10:56 +0000
Message-Id: <20220302211113.4003816-2-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220302211113.4003816-1-clabbe@baylibre.com>
References: <20220302211113.4003816-1-clabbe@baylibre.com>
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

Interrupt is mandatory so the message should be printed as error.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/crypto/rockchip/rk3288_crypto.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/crypto/rockchip/rk3288_crypto.c b/drivers/crypto/rockchip/rk3288_crypto.c
index 35d73061d156..45cc5f766788 100644
--- a/drivers/crypto/rockchip/rk3288_crypto.c
+++ b/drivers/crypto/rockchip/rk3288_crypto.c
@@ -371,8 +371,7 @@ static int rk_crypto_probe(struct platform_device *pdev)
 
 	crypto_info->irq = platform_get_irq(pdev, 0);
 	if (crypto_info->irq < 0) {
-		dev_warn(crypto_info->dev,
-			 "control Interrupt is not available.\n");
+		dev_err(&pdev->dev, "control Interrupt is not available.\n");
 		err = crypto_info->irq;
 		goto err_crypto;
 	}
-- 
2.34.1

