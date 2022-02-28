Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DBE74C78E2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 20:49:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbiB1Tq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 14:46:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiB1Tqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 14:46:55 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC5691FE56F
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 11:45:40 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id r10so6317586wma.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 11:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5/nH1g76OJr2xP0kEzxoO9d69o0mEYaKTMfwjCEna4k=;
        b=lt29u8pA79bzdXmxogX9j0y1J3zKgZTrImKzycoIIB4zcvWL7KntFgwCPueGEvs9Bp
         9E65irN8rtJH1t3f0r1ZVlV0RBu0tw0dEs3x3HqZsQowRPjvExKePG2UBpGTT/WnIAaG
         iVCLgavxjr89XfmgbY/htd1noYLNS6evA6wc8LN6aL2fVpN9EMgtbf/7MBwvrwNaoy3H
         ksHGwHdfZxTdTDO+dQo7I/DQy0cAstQraeiJRo10sgGA2ahFqb5USsFjm4WAq6yGgB5T
         HAZ9bLQEAExlKuSBB78+Ek6eqpF2YgH2JywRAvhxFmZjiZNIH4IhDrmvklCLuSHeb27N
         M89A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5/nH1g76OJr2xP0kEzxoO9d69o0mEYaKTMfwjCEna4k=;
        b=FFzDPUyhqZKz/VZs57x/tK22azwvQe4hCNUv135J5fcvcqaARbeiIAIKpqbxYT28d3
         fxtu5jKcBdimFeYnQi6daExSXYAoO5cVQlDRvuuC4Jh5CYlxu7dC37xCV5w4unYSKwr2
         SivCrUxqHOuwqYYRx7SJY4q/jmQTXRM0QjwiZinMR9mLQm2sU0AB48x5K1O6f/Nv9yZH
         1gp/Ol+uJ6zx4N4o7s1iTvgnD8XFaV35MsEcJ6FDohe78ZjHdhiIiewgsAYrmPgJHmIS
         UljOCtzUTubzF5GrUA1pduo/VL/cFxyzWBcmb9SmBDQItY5WZv+7yNfy/7oon4XoBkAE
         5Kmw==
X-Gm-Message-State: AOAM532z02XcnNCcsFucYdJYgBDHiXJZU2aaOCQQWHFUW7SvVAJMF6NA
        IF2QNMu9kbRnuDCultlczaY4xQ==
X-Google-Smtp-Source: ABdhPJwMhluv9tSJB0/NwPrF0eIHTbzYvQsVlCyHUE3sYp/hLMc7v1GhFAU7XtKYLdVdTEfjOryeQw==
X-Received: by 2002:a05:600c:1da9:b0:381:7fdc:ef7 with SMTP id p41-20020a05600c1da900b003817fdc0ef7mr2669444wms.128.1646077245165;
        Mon, 28 Feb 2022 11:40:45 -0800 (PST)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id v25-20020a05600c215900b0038117f41728sm274143wml.43.2022.02.28.11.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 11:40:44 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     heiko@sntech.de, herbert@gondor.apana.org.au,
        krzysztof.kozlowski@canonical.com, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 02/16] crypto: rockchip: do not use uninit variable
Date:   Mon, 28 Feb 2022 19:40:23 +0000
Message-Id: <20220228194037.1600509-3-clabbe@baylibre.com>
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

crypto_info->dev is not yet set, so use pdev-dev instead.

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
2.34.1

