Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA5A756827F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 11:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbiGFJEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 05:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232422AbiGFJEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 05:04:37 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC43B77
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 02:04:36 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id q9so21050891wrd.8
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 02:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5oq+K0wpCSsh7jUwt6+vmm/hcvr/21v0i001Dyw+Eww=;
        b=k8LlTAqfCG2MWgGVosUzsf/3RmyqtW/i+DpBCpSfQ22u42x1tejqkBDQ6ffKHO3bJ1
         3wzV83iQGKTtCe9UxhxmSsAKVTMOKE/2muz17umcnBAnr29UDj98wi6EEIN4pa22LhXS
         Y6Zk4BNnre57MmSW1zFna8x0+vRrRI8hazfxFw7GgUcPN5igcUqRZLBRkDDKZR9A9yCk
         i9enxCyKUOU70JpxnLdzPyPdZbGrk5UzkcekofjqylR2mSK9Ix/7AU9S0BrQPWx3jKz2
         kmIFnnzwY8/rQzM6Au1RaEn5KUfLhq89YgifALgPUsvVlMDthcCOKseLJzR+8V1yiLW1
         j2LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5oq+K0wpCSsh7jUwt6+vmm/hcvr/21v0i001Dyw+Eww=;
        b=P6PATEDhh26lp15u920//pSkHKGxPWFScPo+R1wtZN5Vfy3Uh05gHUB7PG+oPBiP+K
         v9jUPwmND1uV0MykX0XhypiLrH5eDfWEyGiluDKFImtEKaW/IDgSt3lmEKkrzUld4kgw
         TmKDlERlSG3rM7S6VnaXAEag+1wzibXYgkV+ICLmrD/xnjpyAN2e9QuAT2Y7PyVtXE95
         UbMczgnFDFjH3FyuR3KxEsCl37eEyxOHhQJmzMS8wW3eyILvg6Wh6kwhmGv5wFHiy6h4
         W/i93OWkKSJYLymrK/3uG1IIq8AiU1w4OggVdT6BjspfUIWAM4wRe3DGjUXbq8jFc333
         tgrA==
X-Gm-Message-State: AJIora92kaoVpspBieLXsDMBarJZOooXllSz8qVT8t6U6sn9ROs9Xcb3
        sDFED057ahU7USIYDP8oPuqSgg==
X-Google-Smtp-Source: AGRyM1vW2O1Tjam4DfMdiLa04E+GjcW9Az1x+XRRK+o2g1q0r9++MfwNim2xWPdJ0BepE8gNKN85hQ==
X-Received: by 2002:a05:6000:1243:b0:21d:6123:7a80 with SMTP id j3-20020a056000124300b0021d61237a80mr20480718wrx.354.1657098275124;
        Wed, 06 Jul 2022 02:04:35 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id v11-20020adfe28b000000b0021d6ef34b2asm5230223wri.51.2022.07.06.02.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 02:04:34 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     heiko@sntech.de, herbert@gondor.apana.org.au,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        p.zabel@pengutronix.de, robh+dt@kernel.org, sboyd@kernel.org
Cc:     linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        john@metanate.com, didi.debian@cknow.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v8 02/33] crypto: rockchip: do not use uninitialized variable
Date:   Wed,  6 Jul 2022 09:03:41 +0000
Message-Id: <20220706090412.806101-3-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220706090412.806101-1-clabbe@baylibre.com>
References: <20220706090412.806101-1-clabbe@baylibre.com>
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

Reviewed-by: John Keeping <john@metanate.com>
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

