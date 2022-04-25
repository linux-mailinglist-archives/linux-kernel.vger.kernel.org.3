Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0DA950EA1A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 22:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245250AbiDYUYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 16:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245198AbiDYUYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 16:24:36 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59178124D86
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 13:21:31 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id u17-20020a05600c211100b0038eaf4cdaaeso251992wml.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 13:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yV669w6ThAcunb2ptGEHL08NqOMgexsX7UsYGNNFxgw=;
        b=dI5RMWQEfNwOiJWNjQByihhh2EF9r/7KiCccoj1Z85lHvuo2cKvBRm0C8hgIwI+UWQ
         ibGR/ObFkwHqTvrcVk9Z9zqn3MYPWvbjdOsZGzmHN30Hv5qKaMIw6pgYNWVi7mYoUQOp
         ggRUfIIO5YkvMWpRFwK3pD/riKDox7f9X00q6tsJnwhES1xCKTqRRr2V5QeznTCzGXKm
         30dLwbBr4gw9Sa5bGallbQTciVH2C4KbAq+OlDBuuVL1HqsH96f6X4HIC5Swce9imECd
         7v+Wx3FtNnjyWU95xp+wDeSeBZwJzpLFP7+LnXTE6/537Xl4nCzbSIjGMJNSB1F2bfDy
         B0Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yV669w6ThAcunb2ptGEHL08NqOMgexsX7UsYGNNFxgw=;
        b=poHr9rdw9sx33lJZGv851OdJu4yLysj6WIMUREzOfGjpaU6y0Cu1kIGeD/1OZl+8gp
         wc2c6w7KrfcZIoewlc78ihbX89plbyqD2rEzh7YQfzB51a3jCa4CYdjYx9VswgaprV/2
         eodnSmRkJVO/7iG8jau4BTGUQoIYeR4Qu2rngrqLripHZxXPmBDRxiBfwcu34wIL6Flf
         WhXnguxUFx83zqnGxxahJhefwr0sd+nL7Yl2TfPL9td+SE+8qeYgRG+f9BRhhXyGYJjb
         hYIRfiUiK92BUNj8JzeWv5YeZewEcDXQwO2+2R+BmWelIWx6SPeid2NSzzUP+8YjCxbW
         //pA==
X-Gm-Message-State: AOAM530JxzZg4w5s0R9NRAwSlJcXzbkrx/u/CKsYj80NRoRe8g/xJt51
        m7PgPsxHU/jJOkZ23GtXePCsOPMtciPzuA==
X-Google-Smtp-Source: ABdhPJzf+IWyaPzP6ab2c63O2WXiPtIH/R7xsVInXnktPeeMpfP6sz3SI8RQ7FqDcmI0Jt60tCRbDQ==
X-Received: by 2002:a7b:c403:0:b0:38e:7c57:9af7 with SMTP id k3-20020a7bc403000000b0038e7c579af7mr17528292wmi.144.1650918089738;
        Mon, 25 Apr 2022 13:21:29 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id p3-20020a5d59a3000000b0020a9132d1fbsm11101003wrr.37.2022.04.25.13.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 13:21:29 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     heiko@sntech.de, herbert@gondor.apana.org.au,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org
Cc:     linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v6 02/33] crypto: rockchip: do not use uninitialized variable
Date:   Mon, 25 Apr 2022 20:20:48 +0000
Message-Id: <20220425202119.3566743-3-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220425202119.3566743-1-clabbe@baylibre.com>
References: <20220425202119.3566743-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

crypto_info->dev is not yet set, so use pdev->dev instead.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/crypto/rockchip/rk3288_crypto.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/rockchip/rk3288_crypto.c b/drivers/crypto/rockchip/rk3288_crypto.c
index 45cc5f766788..21d3f1458584 100644
--- a/drivers/crypto/rockchip/rk3288_crypto.c
+++ b/drivers/crypto/rockchip/rk3288_crypto.c
@@ -381,7 +381,7 @@ static int rk_crypto_probe(struct platform_device *pdev)
 			       "rk-crypto", pdev);
 
 	if (err) {
-		dev_err(crypto_info->dev, "irq request failed.\n");
+		dev_err(&pdev->dev, "irq request failed.\n");
 		goto err_crypto;
 	}
 
-- 
2.35.1

