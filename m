Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6062551EF29
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 21:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383456AbiEHTL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 15:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238083AbiEHTEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 15:04:43 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B7DDF86
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 12:00:40 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id e24so16710592wrc.9
        for <linux-kernel@vger.kernel.org>; Sun, 08 May 2022 12:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JBfzxCMFwSqtUUAKgLYX1NAdCBaYrQJEwA5Wp5fjHpE=;
        b=X49Rs6jVUOJqsKLd9jCnOcyVt8anEgCOlsz0UpHKBZyITY/VIqK5RzWuqqpOR7ud/R
         36j9fkZwvcmYiYS0Zza4NW9ELQ/m0CMALIYo7TuUduPJtbV2e/3S4WRYiH9tZeHxPcOU
         ce4I0mHJlDdMRdb4g8L9DmIsb3pXWaL5cYIyroTictucbxTR7bk5+jp6zZgujAKg8dxo
         cRnspmco7/r682hMxNP6cA2SWdZVgH8F7pQHZqxMcxmEWlmOGpq1CRd5ypd1RlFhNVpE
         9+ZTm4JaP0aN+xRfnK29crWT9l/6tP+1r72mSDzpnar1HbAJqPEuaBZg7/3O1MDXHXkc
         VLVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JBfzxCMFwSqtUUAKgLYX1NAdCBaYrQJEwA5Wp5fjHpE=;
        b=dSSy4zCsamz+DpGg7e4UlCXGUMt8YFPBnghx+9Fcrv6Zq6meGMaJ9DRmpyku81FYeK
         co8kiUAX6t6s6DSnLOZ3Rp+el3nVniz/pmJoD6PXQty5hdgUCycRIm9+wSSJ94Amxb6t
         yNeu01MTy7FLT5wMtJIly5mvRRAOijDwoONQRpTiurYTf94uEIhe1Lst5cUQxv7cf8J0
         vEVmJ7V1fRu8MRbO4/Ka5g6IbMwVtlqCzH9OF/9+RZvcTc+tar66ZhGL+WtJJLbm2rP+
         anGeYU2WaT4s0Lb6toq3+THI+HT9wmsUJ//W5bUR/NLUGVBMX3NBXfGD4IAEE4HtV/PI
         P/Eg==
X-Gm-Message-State: AOAM531o0vfw1ssJRupg1rRuglfOlhfALwnF1fswau0XOaQLcpUG0ADC
        x65qJLDHr5L7cVzUqJsnyLJWYQ==
X-Google-Smtp-Source: ABdhPJzncxhGn7VRrhx5Bk1UNUpsBAsFpyNOBZ0pRTwwqnTzrOzKrSuLmPcV6khsNUhAKov1Q6ZN/A==
X-Received: by 2002:a5d:47cc:0:b0:20c:6b7c:8a19 with SMTP id o12-20020a5d47cc000000b0020c6b7c8a19mr10648752wrc.608.1652036438918;
        Sun, 08 May 2022 12:00:38 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id n16-20020a05600c3b9000b00394699f803dsm10552348wms.46.2022.05.08.12.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 May 2022 12:00:38 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     heiko@sntech.de, ardb@kernel.org, herbert@gondor.apana.org.au,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v7 32/33] crypto: rockchip: permit to have more than one reset
Date:   Sun,  8 May 2022 18:59:56 +0000
Message-Id: <20220508185957.3629088-33-clabbe@baylibre.com>
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

The RK3399 has 3 resets, so the driver to handle multiple resets.
This is done by using devm_reset_control_array_get_exclusive().

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/crypto/rockchip/rk3288_crypto.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/rockchip/rk3288_crypto.c b/drivers/crypto/rockchip/rk3288_crypto.c
index d6d78b8af57c..9ba9b9e433c4 100644
--- a/drivers/crypto/rockchip/rk3288_crypto.c
+++ b/drivers/crypto/rockchip/rk3288_crypto.c
@@ -276,7 +276,7 @@ static int rk_crypto_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	crypto_info->rst = devm_reset_control_get(dev, "crypto-rst");
+	crypto_info->rst = devm_reset_control_array_get_exclusive(dev);
 	if (IS_ERR(crypto_info->rst)) {
 		err = PTR_ERR(crypto_info->rst);
 		goto err_crypto;
-- 
2.35.1

