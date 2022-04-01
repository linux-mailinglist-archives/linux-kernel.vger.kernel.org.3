Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83F914EFB10
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 22:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351996AbiDAUUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 16:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351903AbiDAUUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 16:20:05 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D56532706F9
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 13:18:12 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id i132-20020a1c3b8a000000b0038ce25c870dso4253284wma.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 13:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6k9bKJA41frCR0pmOk9SA+9AKNxBSbRS1tpgQTa/e4I=;
        b=MX9wcuVuqO02rmKbmTocVYNsYM3xb69qciQ45XhTTpNt6pGYkOf8zNrTlg+3ajHa26
         gx5h4tNyNiQmQtQT/4b4WRcti77DviPc1pElY+TlnEgIuiQEQqCpbi6QgzfAmyuASasy
         osO40L106DDYqfRXO42ZzyxiEXHi70159kTp/HputOkY9ofQboH2qWVAK3SoeIiIjLSn
         qu1Ws+xLQ1SK1oR6tGm/2xkYZ2Q1YkGUYNuihQSOhAxWdrGAnazJqbXmBn+nsW74+hZO
         4oc4Dgy8WuU1yb/aPQwsANCR2umfKlMgMkpqSJEJZ6yes+0mzHKLX/m4/iu3Afw8n8LP
         EGZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6k9bKJA41frCR0pmOk9SA+9AKNxBSbRS1tpgQTa/e4I=;
        b=0FNFJU6/ogEHwTSywv4+Ym5ppz4miBqgw47RXO1Eeo21IYgZ33qR+mLT4ZPO5HAOl4
         vi/J7iEnUFjXGA5XF6lPkR/4ruVB0zJa4iHIbz16gDo+F6nag4yAFIugfsM1wnNpeqXc
         VAq5FsdayiU71Q6Gu6EqJNZgpFys7voOCbsiFoz1QAnDItX+0nv7kzl+GwAkblzPLuN3
         Q52UVgPTcXzGioCqdQ51Vi+WOqDANjyvoBiHJX8PS58Op6+jSPJWXe0FBCgdlG1whrvh
         0TdCHhiBC+iI/TvtmDHK89l3iz+bBFNmdydFwWNIGirQzukn6A60EaZO4ybzmIQ/4iN+
         vH4g==
X-Gm-Message-State: AOAM533WueDLVGRLvBwGHO1HUHQWuYkCv2YLBoINZ1KmSJeQThe+RSw2
        WcYozOWen2sj2n1AvRPjW07RtA==
X-Google-Smtp-Source: ABdhPJzUg0D/clSz/CESNPrJbeUDbMBgKVJNXT5S+m7Pvd1vPyixbkGOe0zyBVtVLMpYwstHS/L51w==
X-Received: by 2002:a05:600c:1d26:b0:38e:2c97:6f19 with SMTP id l38-20020a05600c1d2600b0038e2c976f19mr10107691wms.89.1648844291447;
        Fri, 01 Apr 2022 13:18:11 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id j16-20020a05600c191000b0038ca3500494sm17823838wmq.27.2022.04.01.13.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 13:18:11 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     heiko@sntech.de, herbert@gondor.apana.org.au, krzk+dt@kernel.org,
        robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v4 01/33] crypto: rockchip: use dev_err for error message about interrupt
Date:   Fri,  1 Apr 2022 20:17:32 +0000
Message-Id: <20220401201804.2867154-2-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220401201804.2867154-1-clabbe@baylibre.com>
References: <20220401201804.2867154-1-clabbe@baylibre.com>
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

