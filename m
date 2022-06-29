Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05F3C560B56
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 23:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbiF2VA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 17:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbiF2VAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 17:00:52 -0400
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0747B3FBF7;
        Wed, 29 Jun 2022 14:00:40 -0700 (PDT)
Received: by mail-il1-f182.google.com with SMTP id o4so11101114ilm.9;
        Wed, 29 Jun 2022 14:00:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QNDYng6HiaUQ2XzlbhKa6Kje7mjtGzKFFC9Apcml49c=;
        b=H7K91T4mVLIcGnSgVXD5tPLoIgqHq7BcmMEuTbnR/ayN9NZ3lRqZRl9ACrabovvpjq
         AO4LqPB10ZL3cfI0Q+t/TyMeW0zA71x/jUNp50fO+lRtdAbHEoLGgV7u2yI4YuoTED1V
         /FXjo+lNHxucdvZGUAxYsTviv8hNjggyrRsyuokW4aGA0Mf6g9Re389HYBR6AL8d19vh
         YJ+Ga2U22o6GIgmeZ9jgWU7HwtPsG2SPNwcKAsSIfH81LHINh/DNNnBvdGASNjGb4aoV
         OmnEIlNYVP8N8rn/RXJLJdUbA+a26FYt8g8Sj0jTa2wqAJTkqVJgWTyORjn1MgsWLOy+
         AmTg==
X-Gm-Message-State: AJIora+iKDCVoLAUsNUBq0+Ee5Gw2FxazZQEWaVZ/cqNE03bCl0Tg0aW
        VM2MRqBItglqyviU5zZAUg==
X-Google-Smtp-Source: AGRyM1vaLdz2tY8DbktMG5UohpiNPszRj0YNupGJE9+wwsg3tChAw/usAM6+QnPklIlRt9YF5xSJoQ==
X-Received: by 2002:a05:6e02:19cd:b0:2da:d593:d32 with SMTP id r13-20020a056e0219cd00b002dad5930d32mr49391ill.145.1656536439211;
        Wed, 29 Jun 2022 14:00:39 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.253])
        by smtp.googlemail.com with ESMTPSA id u13-20020a5d818d000000b0067513ad66c3sm7061434ion.41.2022.06.29.14.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 14:00:38 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>
Cc:     Jingoo Han <jg1.han@samsung.com>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Revert "drivers/video/backlight/platform_lcd.c: add support for device tree based probe"
Date:   Wed, 29 Jun 2022 15:00:23 -0600
Message-Id: <20220629210024.815761-1-robh@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 52e842432f36d5b15227d0ee0d2aa3d2bc3cc0b2.

The DT support never would have worked because there's no platform_data
providing ops. There's not any documented binding for it either.

Cc: Jingoo Han <jg1.han@samsung.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/video/backlight/platform_lcd.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/video/backlight/platform_lcd.c b/drivers/video/backlight/platform_lcd.c
index b2bfbf070200..dc37494baf42 100644
--- a/drivers/video/backlight/platform_lcd.c
+++ b/drivers/video/backlight/platform_lcd.c
@@ -12,7 +12,6 @@
 #include <linux/fb.h>
 #include <linux/backlight.h>
 #include <linux/lcd.h>
-#include <linux/of.h>
 #include <linux/slab.h>
 
 #include <video/platform_lcd.h>
@@ -133,19 +132,10 @@ static int platform_lcd_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(platform_lcd_pm_ops, platform_lcd_suspend,
 			platform_lcd_resume);
 
-#ifdef CONFIG_OF
-static const struct of_device_id platform_lcd_of_match[] = {
-	{ .compatible = "platform-lcd" },
-	{},
-};
-MODULE_DEVICE_TABLE(of, platform_lcd_of_match);
-#endif
-
 static struct platform_driver platform_lcd_driver = {
 	.driver		= {
 		.name	= "platform-lcd",
 		.pm	= &platform_lcd_pm_ops,
-		.of_match_table = of_match_ptr(platform_lcd_of_match),
 	},
 	.probe		= platform_lcd_probe,
 };
-- 
2.34.1

