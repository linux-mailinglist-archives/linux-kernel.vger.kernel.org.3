Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70006502603
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 09:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350895AbiDOHMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 03:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243432AbiDOHME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 03:12:04 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C423731536
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 00:09:35 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id y32so12764849lfa.6
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 00:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=emlid.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RfcZHjamd+442t6E5O8shP98hepY6LEm0ZzcZ6v1xx4=;
        b=It6h8GHGopP4L9JscaI/HEu6X5OhGpLq6PpBClMft2cQKDexG2Os7rPWMzGykCRyVA
         Dcv+wwTarpQan8EMeiyvh+lJX1Wndd9DtKhXaqINz1vQt3POQdX+dvnXLPIRt/ZIgH03
         ZZKKgzb+L2f2XvkZeRrRkkx/XKUCUgtk0Ikaa/PPyUU1hNZWn5tg81Y4sjhIGKl3qTHq
         9d36AwNLyEE93UHqBWXcqFRzz2OU3FCwK/MggwDYEzTMBi/bLzgVrcKnOqOsKUrgAYGY
         m7O8Z2G56YqJ69dDHLAYHi8w73S+HJXo6MhdGeCuJXyGcobw7VkWaMjGk1kuYM322f4c
         X1RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RfcZHjamd+442t6E5O8shP98hepY6LEm0ZzcZ6v1xx4=;
        b=aZyV09zLPTA1bVBT7icnc6ldGX9a2O0ynkQyAeQknvmG3OkJiJvVAF1k5Zet+lg70f
         W74uYYB2yKPdVHz+6gVzve0trAvfgZ7wOMFFxcyHvq18Vp4/pnD149TKnz7Mz4Xgw8r0
         AM6Ig68ztM29bhardWw6LlgSQku9S8bYJCPt2UBngjysyQg8Wu3nrFrTenNRKlPL3QGs
         IHFmVd8hgxbwm/sB+gKzoXnWYciC+e+K8o8gzD6XAY80KOGBew/FGfwTYwsZ4IRcCawl
         LnLQpBUrfCYF8JaDZgovWFBvtL75WTcHNldWdPceNiAO5GZ74EAvlQcJtDln4jXWrVAC
         ySUA==
X-Gm-Message-State: AOAM531cij+PPeobhbM+NldPpwimJm7Cc8cHM1Kxp2MVzqvXPZidcCmL
        IKZVONOyiv4uqYLvxIELJhQ4KQ==
X-Google-Smtp-Source: ABdhPJwBjMdYcDC+nowTdwpV4NZqVut25gjNMA9ODIlYylhpoGGkS5remuvDJREwX0oYpLvjnNM2Yw==
X-Received: by 2002:ac2:4250:0:b0:44a:ff88:3795 with SMTP id m16-20020ac24250000000b0044aff883795mr4344708lfl.384.1650006574056;
        Fri, 15 Apr 2022 00:09:34 -0700 (PDT)
Received: from emlid-ThinkPad-E480.localdomain ([85.143.205.202])
        by smtp.gmail.com with ESMTPSA id g3-20020a2e9e43000000b00244c60deb14sm205121ljk.15.2022.04.15.00.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 00:09:33 -0700 (PDT)
From:   Andrei Lalaev <andrei.lalaev@emlid.com>
To:     linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        andy.shevchenko@gmail.com, Andrei Lalaev <andrei.lalaev@emlid.com>
Subject: [PATCH v2] gpiolib: of: fix bounds check for 'gpio-reserved-ranges'
Date:   Fri, 15 Apr 2022 10:07:11 +0300
Message-Id: <20220415070710.220785-1-andrei.lalaev@emlid.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gpiolib interprets the elements of "gpio-reserved-ranges" as "start,size"
because it clears "size" bits starting from the "start" bit in the according
bitmap. So it has to use "greater" instead of "greater or equal" when performs
bounds check to make sure that GPIOs are in the available range.
Previous implementation skipped ranges that include the last GPIO in
the range.

Fixes: 726cb3ba4969 ("gpiolib: Support 'gpio-reserved-ranges' property")
Signed-off-by: Andrei Lalaev <andrei.lalaev@emlid.com>
---
I wrote the mail to the maintainers
(https://lore.kernel.org/linux-gpio/20220412115554.159435-1-andrei.lalaev@emlid.com/T/#u)
of the questioned DTSes (because I couldn't understand how the maintainers
interpreted this property), but I haven't received a response.
Since the questioned DTSes use "gpio-reserved-ranges = <0 4>"
(i.e., the beginning of the range), this patch doesn't affect these DTSes at all.
TBH this patch doesn't break any existing DTSes because none of them
reserve gpios at the end of range.
---
 drivers/gpio/gpiolib-of.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index ae1ce319cd78..7e5e51d49d09 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -910,7 +910,7 @@ static void of_gpiochip_init_valid_mask(struct gpio_chip *chip)
 					   i, &start);
 		of_property_read_u32_index(np, "gpio-reserved-ranges",
 					   i + 1, &count);
-		if (start >= chip->ngpio || start + count >= chip->ngpio)
+		if (start >= chip->ngpio || start + count > chip->ngpio)
 			continue;
 
 		bitmap_clear(chip->valid_mask, start, count);
-- 
2.25.1

