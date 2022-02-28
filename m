Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A97C84C78F1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 20:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiB1TrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 14:47:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiB1TrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 14:47:17 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7D11FE010
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 11:45:39 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id b5so17153213wrr.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 11:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B4Tf8ps8Giknxs7LQki4ZGeia2acPTQFjucag6hcCiQ=;
        b=pQfYzu5gQGvtExS8j6V0wQbX2h22JXAb4mWQmJesNVD6fgWAPw1kFTsYkVzLiIlPjR
         f64bL1c3Gx57wujouE3pi/q6ZFyeIfh9mZaDu5taM5uqrE+/hrhnYPjtUMTg6sS3KWk7
         zQlWSwvAKT0x9YyxhP74uQJnwI2tcuPC4OO3zI1W0eeHqO/JAjPZPkIVzEfVo2ewffjS
         YotD0QLOikj/Tv9v9RtkR3bS10GHMmzOaER/9W7st5PdjApjSLnKA4BFWB+o1AogRxmJ
         EmGM/V/K/4dbOlP2lq4lqt4FtBhH7c2hLG4VNVqia9cfSWk7ivxc+dRc+HYlqZhMoQrt
         t67A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B4Tf8ps8Giknxs7LQki4ZGeia2acPTQFjucag6hcCiQ=;
        b=iSddi60AWwF3qIujwOw2Nn94i8zX7BAF9XW0T0+MI3jtEzDzKPEAedLdLHs57L46z1
         tULIcmGdoEXxTV+c0c4/zVN5+k5IVf2c2hTezCdGz6oTutE8Yk2CIWwUllSySObVB265
         7shPCEY7Iz/Q8fBGeruZFS7xHRo7Pibvk4sals99qKwh76rLaT+WIOLRyixQVvqFkFCK
         26QOY0gbgju2bwFytnvZqiWe9/PMbi6DpQIRECW/j0MSkA/Ww4qzSFCdMCfTImWpCC4X
         XIl07ltznJrGc9wLZDZlrMQf7OHiIQEBHkGk+DEfZx6udbJ1q96ckgkWu8eaVwD8T0C4
         BwOg==
X-Gm-Message-State: AOAM531VyeglkIkMDuaz0sNClVF9cFPY9DQ5G+gRhXvF+4NUjAfiF68P
        Mcqqn7r4kndUYae++e0QSQRCGA==
X-Google-Smtp-Source: ABdhPJyCQQtSseZ8J+9GAAAPOG5gkjAhg6vVntdlKc/MqESku4jC3awvJmxxKGnA8cIqcferj+ON6Q==
X-Received: by 2002:adf:fc8c:0:b0:1ed:f5af:f7c6 with SMTP id g12-20020adffc8c000000b001edf5aff7c6mr16818211wrr.386.1646077244429;
        Mon, 28 Feb 2022 11:40:44 -0800 (PST)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id v25-20020a05600c215900b0038117f41728sm274143wml.43.2022.02.28.11.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 11:40:44 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     heiko@sntech.de, herbert@gondor.apana.org.au,
        krzysztof.kozlowski@canonical.com, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 01/16] crypto: rockchip: use dev_err for error message about interrupt
Date:   Mon, 28 Feb 2022 19:40:22 +0000
Message-Id: <20220228194037.1600509-2-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220228194037.1600509-1-clabbe@baylibre.com>
References: <20220228194037.1600509-1-clabbe@baylibre.com>
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

