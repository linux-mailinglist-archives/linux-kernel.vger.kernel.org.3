Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6755B51EF32
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 21:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239311AbiEHTJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 15:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236189AbiEHTEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 15:04:04 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5555ABE2E
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 12:00:07 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id bg25so7278296wmb.4
        for <linux-kernel@vger.kernel.org>; Sun, 08 May 2022 12:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yV669w6ThAcunb2ptGEHL08NqOMgexsX7UsYGNNFxgw=;
        b=Ki84OyQLc7pROgZxF1gnhF3jTMDMdtHA0MKpUpw5o9PWE0XLuWAk+sF8CCULMHACxQ
         lsT0XNnKNIEzzttaeTOE1QHk57B2KRoJepX1h+/Y5IYUkrtJPsEmb6I7ubPeD/bNzeKQ
         NVZk4mYcG4fMJURYZydF+07oax1jglMhdr3uu/QkPVPoEJ1MCFnjevtCeAHPcKuW16o3
         PclhGOU3Ls6QSpH9ouMbWl3pDOGVUAmmzpDyoNEgtShNx/yviW59rKQrr7fnKB0a6hCg
         WgLfueXyIDzsaWmbFvj+cpBFxTTVaLyR++wN9O6rfZzoziQZHR8rKAamJayV18ANqCvF
         moVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yV669w6ThAcunb2ptGEHL08NqOMgexsX7UsYGNNFxgw=;
        b=pIooLxG2M+t+7aeUMiKn51CF/apdX4hobddjMm5fWuBpN97rI3HMvpZE5Ypyriymts
         V3LEd25A03xc6yZ4wzvd8mgwK4o7Hy+8nYikM+WTvlvmvi0Pn7ZNgIrsPqsffZNBt+UY
         h4YjPmm4VqZ06e4C4RqVDYe7hznmeVE3W7bqBEitGBYJQ6+hginUeCzYtjvZrV+MTPVI
         9z43SNi4I13o9wcZRI8KgXxe7JqMAPYl858F7Sb/0Z+FtAFB/1Cao6eIR4eQiBt94sY9
         ObHPS32fbEU1Xfs7sT34f/Do+9LanTdNwgr0YuLFx0zA8heOB8bU5tsrYQbKE3iDH9pv
         FdSA==
X-Gm-Message-State: AOAM532QLP2wayXpxXUyNlV114hcRqnInrYNo1pAYipaQxRlo3IfUI/y
        3Abh5S58fbmMlReWk4sufKXCjQ==
X-Google-Smtp-Source: ABdhPJxroBCDR5YqPv0VuwWLtpz8x0Z9sdjqxoHa4No5XKXjZtWbwMaPh4Aaq+tNaF5XRLLFHvYFHA==
X-Received: by 2002:a05:600c:3c9c:b0:394:8fb8:5589 with SMTP id bg28-20020a05600c3c9c00b003948fb85589mr2048195wmb.13.1652036405904;
        Sun, 08 May 2022 12:00:05 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id n16-20020a05600c3b9000b00394699f803dsm10552348wms.46.2022.05.08.12.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 May 2022 12:00:05 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     heiko@sntech.de, ardb@kernel.org, herbert@gondor.apana.org.au,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v7 02/33] crypto: rockchip: do not use uninitialized variable
Date:   Sun,  8 May 2022 18:59:26 +0000
Message-Id: <20220508185957.3629088-3-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220508185957.3629088-1-clabbe@baylibre.com>
References: <20220508185957.3629088-1-clabbe@baylibre.com>
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

