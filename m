Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8906E4FFEEC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 21:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238066AbiDMTPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 15:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238247AbiDMTMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 15:12:47 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E386771ED4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 12:07:57 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id ay36-20020a05600c1e2400b0038ebc885115so3218963wmb.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 12:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JBfzxCMFwSqtUUAKgLYX1NAdCBaYrQJEwA5Wp5fjHpE=;
        b=yh8B4MA5+IIC0lL6pBWdPhs6d9WmcV3UPM/GHpIaYenQKbu/9Fa70KpToA2XQDr+Yg
         U9oU05mcUhaNNdu2BM7aJfgQCMyRA1nr6H0/T6urpImHNeJ7xa3de/rU2e1NkK5zRwA7
         UlbrPz6GNsAr8UytypSrhTBVM+Xht/FOXWY7m+8tawOZoSgerR3YJhf6SXMsgi//4f5d
         5985xj2AZJYpJHMQlkMrgZCxiC7kbDDqzPpDLMEZ+bhEJX/ELnPhmIGMHPGwkuZAn7Lu
         dsz6g7W0wSoS5gbs8tFrmepfmCMgF+s8d+zhTQ0FBuipmJNZ3OPeXkBc75OOimNYZX84
         Elxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JBfzxCMFwSqtUUAKgLYX1NAdCBaYrQJEwA5Wp5fjHpE=;
        b=QAWel/2Cowk+WGetIsAB8l6uQQ99R3SN2B1oZqgA0k2vXR3GeeUwKE9Wkx/hZ4N5NL
         W7bd0BHjldi6egdhNC2v8a21rDlKR6UyERJhqaM7NB0r2+xRhWNemIzB1iyPCteyIQ65
         2vhRN89dwIxUkLbxSLN5JoUaeX6+a+P4OgT83TBVhtKC1QMxV9idWjUXyqMOZlhb7wsG
         ef87DYxMWPTBWUay/xNNyxwt7HXC66Zekz99vRExg1HHHwlHaxRU17uSwaUSsKxsPDly
         S4+Oduk2Z6asQ/ln34FOVkVFy8lar2khmP+N/5gHsKPf7SNL6tYO2r3Zsi/tXFZNoF6p
         Uf5g==
X-Gm-Message-State: AOAM532YuafpQmyoaWUDOm5b8IkbiLcPI/WrFHnfT5mOkfcOLTmemVTf
        cbBnRLOReAg4suo7UjA9+FKbfw==
X-Google-Smtp-Source: ABdhPJyQ86GCiYzB29RlHiNKRPQcam5duoianBOXT2nFnR89sXRr77+hqM+vPCyb+YE2l+bErpELsw==
X-Received: by 2002:a05:600c:198f:b0:38c:a9e9:754a with SMTP id t15-20020a05600c198f00b0038ca9e9754amr166676wmq.146.1649876876246;
        Wed, 13 Apr 2022 12:07:56 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id o29-20020a05600c511d00b0038e3532b23csm3551852wms.15.2022.04.13.12.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 12:07:55 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     heiko@sntech.de, herbert@gondor.apana.org.au,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v5 32/33] crypto: rockchip: permit to have more than one reset
Date:   Wed, 13 Apr 2022 19:07:12 +0000
Message-Id: <20220413190713.1427956-33-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220413190713.1427956-1-clabbe@baylibre.com>
References: <20220413190713.1427956-1-clabbe@baylibre.com>
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

