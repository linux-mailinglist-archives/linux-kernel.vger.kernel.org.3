Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28F384CED76
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 20:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234120AbiCFTfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 14:35:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiCFTfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 14:35:15 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544A4522EB
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 11:34:23 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id k29-20020a05600c1c9d00b003817fdc0f00so8101381wms.4
        for <linux-kernel@vger.kernel.org>; Sun, 06 Mar 2022 11:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kctIPCfRqdsb2edXEMQLEguqkionRTxKrybGQBlVoI4=;
        b=fIlg/8QfUGxURZ7B9+jekhRDFK3u6LNTfY8NaQz0C7YqV/ucX9WbpsmJDUolpFKUYO
         tWpMWWQvJ2WixKW+0QsE01UzgwjA/34CS8kV9+HcRRuTaJjr9siRGcWmxHvRe13a2d/t
         WQ3NFu7roLHzJDa06xFsCEwT4YXaxrIOQkmVik8J5KNkYp8veqjntCtjEqieJSYcVcyy
         KrVZrQP8QSRcspKweB5YMAQUELqWFIM6JPF/WnjPfVwXrA5mCKR6odGWbqR2xTiCeDAI
         qIpRypCu0VvK1fXWH8Gla5lmbtcG5Jf6ofpi//EMDU0DilyFISc9lWQ1a1M30YWSNHtW
         0ynQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kctIPCfRqdsb2edXEMQLEguqkionRTxKrybGQBlVoI4=;
        b=597y7vVdEceMmetZDv2LbSJ2zqxYv6WDWKJ69joVPWdmi7N0m9iMlSrVloiik3W7Pa
         FJvF53fsknez+roU6ussT4+XOK5cDfRyxKgpDxUY3dgmIT+KJN0iAluX+OMwpVsbjztR
         IRE6CYU3ZXIomI1xbdQCWs+NkHn2evql6V1suADtAI/+mYhXWoQZJfwoefbJ3Mslh3xY
         Cfv8Npbh9918fXYT91WZUZvBk9tvYx5/4JTD8HI/P3/GGSsEaviQNa21PIgS3c+0mRXS
         ql4KDbj6A1S+88ck32I+yBJdhFQ15yKZF4ZJxZFaY7LkKZlKgaGqn6TJMYfQ1iznv9+i
         dfYA==
X-Gm-Message-State: AOAM530u8GWuCze/ri67Rr2YKhRZBIfLKODAdrSU9IBDKRNLX7RSA4pV
        kEymDwa7eeAp3spDiCF1TyU0Qg==
X-Google-Smtp-Source: ABdhPJy3ZWPvyAj8ZYSTVCDD15NxOKE+sXDJ4pyIYkcssnE4ZGnK5qe8IP83nkxbGr0rD/iMi8la6Q==
X-Received: by 2002:a05:600c:4f8f:b0:383:d0b:3706 with SMTP id n15-20020a05600c4f8f00b003830d0b3706mr6598328wmq.117.1646595261854;
        Sun, 06 Mar 2022 11:34:21 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:334:ac00:7d50:ff5:f5c1:e225])
        by smtp.gmail.com with ESMTPSA id l11-20020a5d674b000000b001f047c49e99sm9651621wrw.2.2022.03.06.11.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Mar 2022 11:34:21 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH] gpiolib: check for overflow when reading the 'ngpios' property
Date:   Sun,  6 Mar 2022 20:34:20 +0100
Message-Id: <20220306193420.99714-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ngpio fields both in struct gpio_device as well as gpio_chip are
16-bit unsigned integers. Let's not risk an overflow and check if the
property value represented as a 32-bit unsigned integer is not greater
than U16_MAX.

Fixes: 9dbd1ab20509 ("gpiolib: check the 'ngpios' property in core gpiolib code")
Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
 drivers/gpio/gpiolib.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index a3d14277f17c..3c4f47b9ab57 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -677,6 +677,11 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 		else if (ret)
 			goto err_free_descs;
 
+		if (ngpios > U16_MAX) {
+			ret = EINVAL;
+			goto err_free_descs;
+		}
+
 		gc->ngpio = ngpios;
 	}
 
-- 
2.30.1

