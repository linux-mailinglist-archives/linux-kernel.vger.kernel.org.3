Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83C0D5682C7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 11:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbiGFJEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 05:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231964AbiGFJEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 05:04:36 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE651CB08
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 02:04:35 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id a5so6364314wrx.12
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 02:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2nwWkT4441Zvq5igIAOKA8C0HAjPPXDmTRADPlAyhok=;
        b=Pr3IXa8ExRhTFh+SPH7MrhQizXMmrRN4KOZzHqdYpWENJ96Ms04oBik0WfZbJ27egJ
         ldxRn/lKH+72j5pIK0nS2nYnViD4t7mh4Zb1sOqM2u2kO5jOs6YQUThf4H4eI2Km2Ujk
         DwddZ86xRnFapyFfMRqcT6ohi+6e0uc4u1C7mMTTJA/fIR7ogqFH26AfqYtb+NPy09S6
         Lqsl7Gej6g7TLBDiNG7TJFSX2PL0SMt1IdS4uGkcq1ucTSIZUoDqeFV0sk0icX109eD0
         +evOAKZrJ8Fcpr+vITTRyd9o5yoYy0tl+3ssElJnyQ3+12HdNMnyGRJT/M/jsAeeXFrC
         2s1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2nwWkT4441Zvq5igIAOKA8C0HAjPPXDmTRADPlAyhok=;
        b=bbhBWPJBxv5ciabiqi+1cs9rMt9MZsJJsZ1kATxSqE74w+2IaeSLxiVv6ejXiPTKAx
         TP89lvvaLs1C99tT7S8GPk5ySPbknEy8Pww1osn3QkM2D7gBQnnnGyus+KggoAWlLvN+
         WC0+aIzd7vLf+VvGp1GXThK2ax7gEWIf/dI+tT229xHZloz8ADma4em6/gVL8ScicoWg
         0Fe/mDDTmIJZ4aGOy1iifcCuE0FmDNOe7qWoHVgbjB4PsVP8b/U9Je2lyDJX4/oEGXb1
         uNk5mmWMNTooBE8lI9MNzGlO52iRwpd1WKt3pitFSkY2cvCVoGiUrHYP/cPbKUZ+Ipgw
         qxYg==
X-Gm-Message-State: AJIora+cpc3ct2Ojx98gyd3kxB4f1VUd5D9itqj1umZOqJ6cELvj3o2T
        NH7c2GC4/3VYjqaiZkQ0wm35mw==
X-Google-Smtp-Source: AGRyM1uEESfBM2/+cx8O6PDi67ahL3H9B52KIeo6hugjBlO2PZU9E0Dg3m/zc4Jx7ArSkzmwQCEl3w==
X-Received: by 2002:a5d:6d0c:0:b0:21b:ccda:fc67 with SMTP id e12-20020a5d6d0c000000b0021bccdafc67mr37250833wrq.246.1657098274092;
        Wed, 06 Jul 2022 02:04:34 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id v11-20020adfe28b000000b0021d6ef34b2asm5230223wri.51.2022.07.06.02.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 02:04:33 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     heiko@sntech.de, herbert@gondor.apana.org.au,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        p.zabel@pengutronix.de, robh+dt@kernel.org, sboyd@kernel.org
Cc:     linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        john@metanate.com, didi.debian@cknow.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v8 01/33] crypto: rockchip: use dev_err for error message about interrupt
Date:   Wed,  6 Jul 2022 09:03:40 +0000
Message-Id: <20220706090412.806101-2-clabbe@baylibre.com>
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

Interrupt is mandatory so the message should be printed as error.

Reviewed-by: John Keeping <john@metanate.com>
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
2.35.1

