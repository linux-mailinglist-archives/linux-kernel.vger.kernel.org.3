Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DFB94CB0D6
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 22:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245250AbiCBVMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 16:12:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245127AbiCBVMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 16:12:14 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168D9DCE34
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 13:11:26 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id r65so1980693wma.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 13:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5/nH1g76OJr2xP0kEzxoO9d69o0mEYaKTMfwjCEna4k=;
        b=s/I0Z2y4z8YB6ZgpjPwn9fMiOpI90kwAS3l0VUO3xvtkNUJzA9qE3bhuyGk/bXfQyX
         CaLoMUsM5bZeyiAJNnSt1vQiKqvQNMOlvbItUvclxl441XuqepRsZyfpgjMSmtGF0A7P
         3ULeQDYSW5jYhYhSUYI7a4jRSa8K6qHGn6hfgQdyAe+kHzeGqB+o1h8CvJPeuNtMyXlF
         1iDb3yANtGm4wZMsOQf3ULA5P0y4XIkn8TZ3l/zpcuTro47K9g+PBA1L47uSICN0lUJR
         bl/w5MqNWNLcDwJ54KJC2eF3jCXaEWg0ziruH6Z6kIgIjPNUyHy+ESBVMKQPJLHOhaOL
         9B4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5/nH1g76OJr2xP0kEzxoO9d69o0mEYaKTMfwjCEna4k=;
        b=6ZhfRDARKslahrudjTIpKrUOhjLM8zS6dWSN7jplx4XLWo5hLn9m3WnBhXxnEOJxF+
         qB+pe2AahUVhh1n4UyQHTDrM/2kFyHPrmzx98G8Plj+6uUnT88+9G6nVqlfpc/Kh03jF
         h3dlhOdUKWA/myEx+DtGpD5ar+ePQo2LAFMTGXnl2nSiHXMDP56CrznO9vxL9BCLhNoc
         Ty8Fy54LqnHs6iS3h3xApq97zeVH6rx/LkdhDtGyrB5UErS32V5PtOR2h/Xnuev0ffXe
         VaalPMNW5+xDHMcaRHypav6Oqpnm9/KrArehA1bYu8oYqc+wjf28KDu03d20jlrTgytW
         34Cw==
X-Gm-Message-State: AOAM530dHl7ch2Q/L8vLfWL5IUGlpXTw4s4kMFV0wroXAXLzjvRDeDyv
        p7JDazFhoMrZqtpPdmNCYgU4BA==
X-Google-Smtp-Source: ABdhPJwPZwmrufp36YqMiXKGpIU+QwG7owyQ8MQP9+2rxoDOdGiEo9TNglb3MQRuVp+z7hOzJXjONQ==
X-Received: by 2002:a05:600c:1990:b0:381:1806:1d9 with SMTP id t16-20020a05600c199000b00381180601d9mr1365346wmq.93.1646255484689;
        Wed, 02 Mar 2022 13:11:24 -0800 (PST)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id z5-20020a05600c0a0500b0037fa93193a8sm145776wmp.44.2022.03.02.13.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 13:11:24 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     heiko@sntech.de, herbert@gondor.apana.org.au, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, john@metanate.com,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v2 02/18] crypto: rockchip: do not use uninit variable
Date:   Wed,  2 Mar 2022 21:10:57 +0000
Message-Id: <20220302211113.4003816-3-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220302211113.4003816-1-clabbe@baylibre.com>
References: <20220302211113.4003816-1-clabbe@baylibre.com>
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

