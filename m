Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1475B4DA07F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 17:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350275AbiCOQx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 12:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349732AbiCOQxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 12:53:54 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68CCA57B20
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 09:52:41 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id qt6so42757677ejb.11
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 09:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b0aM6sl3949MchX9Yv6VE189C4y3nLxjnRhOtDMW61Y=;
        b=03TlvfMezDfHN5wS4PTTVt1TAQJJy0/fVvcordTJ/PWCn6rsNVFK0xY9FQGuv2tHJv
         LlCVl/YNcODDUFDhxu/5SOZowpjHuwwGIW5wlfHPiHnwB175XSpXCuuc74jUQOe03SsS
         v6K6ZILJ6BvV8MogrNCxeTGsBYKvvcMhwDxEoImAwIAMgellDune48LdpHMtfdL1kEyl
         u7OSMo2R0J5b3dp3FZidMK1jRrOqMqVJxuK0lEHHB3mHUVdJPyOUHF8YLR8YYjqJCqrz
         fnSbdMtVvFZlYh1v7N3XnyhZKdiwZlzlzyqiDOMMG00tfAg7scS57+usDhOi2wpv6rEI
         q2jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b0aM6sl3949MchX9Yv6VE189C4y3nLxjnRhOtDMW61Y=;
        b=OsO/sI8KAOjvG6fX+zbHVNqJHeyOpj0qw6uKARYph9OJ5uk1CqYOUt8azvmQYdix9E
         4jBIKZ3+gcCK9CeW38+PlYq3Pvl4ghtLoSGo2HUxgVrEAZIf7k18SR6V1rZQ1i/kBOVQ
         sCYN3Jw/EgdwE2f6tfOJlnnsJhJRt63SebcqsoNMm/ayjtw7k/1/NpjPmiBlRVlKwcK3
         XiGFtiw3olGejk/5yKQRawJDREvyGh8yJItubX1sCBtBM2q2VqBx9QM3kWTPFyeHTz6N
         fMCFH9AHiSyO3VylxZrww+p0I4No5OLiNjM964uIUGsiaIqj4uSY7Q2RJ2FytUOLR1MF
         o4lQ==
X-Gm-Message-State: AOAM5315IbWSA4xWb3WEhUb3qo7Vxg2fINt2dLVZFutgvplEACxaoY3o
        qlJO1p4zqRpuaBlznC8vlW45qg==
X-Google-Smtp-Source: ABdhPJyBERVWp7y/+2aM+hyL9hcsGBfVWaKAFWiAGotauhnQNVMjsEwt46YXwMjYS3+QabYtJQDu2A==
X-Received: by 2002:a17:906:f41:b0:6d5:c6bc:fbc7 with SMTP id h1-20020a1709060f4100b006d5c6bcfbc7mr22738941ejj.541.1647363159864;
        Tue, 15 Mar 2022 09:52:39 -0700 (PDT)
Received: from localhost.localdomain (46.205.192.191.nat.umts.dynamic.t-mobile.pl. [46.205.192.191])
        by smtp.gmail.com with ESMTPSA id qa44-20020a17090786ac00b006dbcd7c9656sm3795955ejc.172.2022.03.15.09.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 09:52:39 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marcelo Roberto Jimenez <marcelo.jimenez@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Thierry Reding <treding@nvidia.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH] Revert "gpio: Revert regression in sysfs-gpio (gpiolib.c)"
Date:   Tue, 15 Mar 2022 17:52:05 +0100
Message-Id: <20220315165205.1502325-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit fc328a7d1fcce263db0b046917a66f3aa6e68719.

This commit - while attempting to fix a regression - has caused a number
of other problems. As the fallout from it is more significant than the
initial problem itself, revert it for now before we find a correct
solution.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
 drivers/gpio/gpiolib.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index defb7c464b87..6630d92e30ad 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1701,6 +1701,11 @@ static inline void gpiochip_irqchip_free_valid_mask(struct gpio_chip *gc)
  */
 int gpiochip_generic_request(struct gpio_chip *gc, unsigned int offset)
 {
+#ifdef CONFIG_PINCTRL
+	if (list_empty(&gc->gpiodev->pin_ranges))
+		return 0;
+#endif
+
 	return pinctrl_gpio_request(gc->gpiodev->base + offset);
 }
 EXPORT_SYMBOL_GPL(gpiochip_generic_request);
@@ -1712,6 +1717,11 @@ EXPORT_SYMBOL_GPL(gpiochip_generic_request);
  */
 void gpiochip_generic_free(struct gpio_chip *gc, unsigned int offset)
 {
+#ifdef CONFIG_PINCTRL
+	if (list_empty(&gc->gpiodev->pin_ranges))
+		return;
+#endif
+
 	pinctrl_gpio_free(gc->gpiodev->base + offset);
 }
 EXPORT_SYMBOL_GPL(gpiochip_generic_free);
-- 
2.30.1

