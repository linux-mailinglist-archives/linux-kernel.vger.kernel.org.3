Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58ED65682D3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 11:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233109AbiGFJIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 05:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232989AbiGFJGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 05:06:52 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B1325296
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 02:05:06 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id f2so15688100wrr.6
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 02:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z10vTtQ4qHSJZ9nRrmQY5lLp9Bvyc0G2kDbemdDveLc=;
        b=E5GE9YCmCMIhMO2D/gpbHRe1l3D7xDBrlxRw1T0NpHDSuJX2I0zJ01SA77X+Ypb95F
         IxH9341vzS6f9HRvGDZW1Pvfah1Ajs+GYMuuix6+XAER3HwBkC8VVVKn8re/11zSOLUY
         /PpGB+RRuIYMS+tnnb7gKAgXTpXUqslS3pUYbx55O7iqFoFMR5yXFZX4/XHD1KneRk27
         SbYZG0c2XxXOMsPSLg0CkQOe2LamirBkkH4ropL6mvCgJ/uXVy57YtoLlOl2NbUTROU7
         xs6SXcvpWeY8HlpE/xnWr7NDJiJTiGnStnPsoRqaj2Qc0zZ5J+/gJORvYosCb/3sgoWn
         UDWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z10vTtQ4qHSJZ9nRrmQY5lLp9Bvyc0G2kDbemdDveLc=;
        b=6kzpcCnrlvoLLjjzUrNLN51Us6Ez54FOMdU9uOnIfiW00Pc/4cikSOsBd3b5X3vJi5
         hH6VlMYbtDL3b4SZgoAzKZv4yw2WvaRNa1c3jMd+pZXOoYajh+TOM3Ae2PwjExmhlDDE
         stQBlLAxNYuNIeSZdhD8b6YvfN8Hd6GJxl62VF9abvOsGUGratEiaEhs8RXZ99VMKfql
         iOIxFNJCZWESBkBhVvNH1c7TNC91WvMlCOI3cJHf6mVfpYsEuGnSTdCp125t/3FK7EBa
         AwsX4DWQseSq88Z9R4Zjhg2c8UaYlTJ10bWT13tNcTRlVgdkLxecRqL4m7hZR/8jyPiU
         PwQw==
X-Gm-Message-State: AJIora+ZhkX7/tjg/q5udR0LqW2thiXMuZd+RiUtSdgyqtODLPDD3fUh
        MxJNIcqaMzHIo+g7rDIXuHvKKA==
X-Google-Smtp-Source: AGRyM1ulg96UJaCG6169ehYplV1+a5sXk+kbCnPbNNkmvYpCCQnDU08EeOTBhit7iFXQIkTZCwV3Gg==
X-Received: by 2002:a05:6000:1243:b0:21d:6123:7a80 with SMTP id j3-20020a056000124300b0021d61237a80mr20483339wrx.354.1657098305981;
        Wed, 06 Jul 2022 02:05:05 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id v11-20020adfe28b000000b0021d6ef34b2asm5230223wri.51.2022.07.06.02.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 02:05:05 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     heiko@sntech.de, herbert@gondor.apana.org.au,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        p.zabel@pengutronix.de, robh+dt@kernel.org, sboyd@kernel.org
Cc:     linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        john@metanate.com, didi.debian@cknow.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v8 32/33] crypto: rockchip: permit to have more than one reset
Date:   Wed,  6 Jul 2022 09:04:11 +0000
Message-Id: <20220706090412.806101-33-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220706090412.806101-1-clabbe@baylibre.com>
References: <20220706090412.806101-1-clabbe@baylibre.com>
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

The RK3399 has 3 resets, so the driver to handle multiple resets.
This is done by using devm_reset_control_array_get_exclusive().

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/crypto/rockchip/rk3288_crypto.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/rockchip/rk3288_crypto.c b/drivers/crypto/rockchip/rk3288_crypto.c
index 232dc625d6e5..d96f375423d5 100644
--- a/drivers/crypto/rockchip/rk3288_crypto.c
+++ b/drivers/crypto/rockchip/rk3288_crypto.c
@@ -281,7 +281,7 @@ static int rk_crypto_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	crypto_info->rst = devm_reset_control_get(dev, "crypto-rst");
+	crypto_info->rst = devm_reset_control_array_get_exclusive(dev);
 	if (IS_ERR(crypto_info->rst)) {
 		err = PTR_ERR(crypto_info->rst);
 		goto err_crypto;
-- 
2.35.1

