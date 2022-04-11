Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7DD4FB3CA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 08:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244966AbiDKGig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 02:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244960AbiDKGib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 02:38:31 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477A921269
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 23:36:17 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id u19so4697602lff.4
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 23:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=emlid.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iRcYxJVdDiiICHxHO2f45y7+4rlasd/ctsihDzRoQKU=;
        b=BpM+uhn+mmt2R1nQH6oS5XFfR4Lj8J1o+xE07ONTJPEvD+TWtrex7qmw+Ws8ZDJKqj
         XhnIrN0znHoacNC9scPWxael80iJfPG4fvtUIDBn+QkTGlSJmcJBjDhD1FUBK/pETfD7
         DPKRYn1l72t67LCTh0bxnOOkIjee8QntF15+86TyhP8kBAa0UDw+BkqyaMcHEWdzjaqG
         9Jw1DmM+jOniZKquWKci5tT7lC4PeAQr+KNMf6OEMSbu8yzaz5yBj4/h1ciJoJ8m0j3M
         EdEmiQut3AE2oDd0S3jJ+HpwfEA8uKrkw8/B8DKxReOH3JNmK2vNLDWtzy97glvHQ8mX
         Am/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iRcYxJVdDiiICHxHO2f45y7+4rlasd/ctsihDzRoQKU=;
        b=Nz4Ua2frWIYviEj7wOkkSjAMvJQPFwPwnxY6q/3Cc6KI9bgfWJSU4VyYlzcFsNKDUZ
         HpvACKjcOgU0dixzFWIioafEOTtO1vOeHAnXel/e8xeOqZ8UPX/B5iSObAc3lmsjprRO
         AVDqbeVE20O66sXdsMfzZN/NNoehPuM5CTpgDSa/T3VVkpyz0YKC0vLgfxm480X3Sn67
         gfKTfz39Fy1i4Np56cELAK1qAvxLcqoOhKy2MEWKb2B+ZWRKBeTiUuCWEyyVcdx1Owft
         U/+bxu+yrMaQeiaCabKNsyn0tLGW3Snomz83lvXVyzcZ4jPSB9DmyGS0lFWKnF0m78dT
         vTrw==
X-Gm-Message-State: AOAM532xvWVq0AFuj/tyaapZCSQISiebIlV7QCWONTmzUgNqihQHX2MW
        w6XeSA3vM8nOBEeIVPxa+XyeDA==
X-Google-Smtp-Source: ABdhPJxjyvTdAHPbrmGoXOI8yTgOwtl7h3M7ZrlEuC8Go1T3gG8NFMg7Im+eaJwh31CJQ6s8ussEHw==
X-Received: by 2002:ac2:514c:0:b0:46b:8997:9ad6 with SMTP id q12-20020ac2514c000000b0046b89979ad6mr9554456lfd.620.1649658975548;
        Sun, 10 Apr 2022 23:36:15 -0700 (PDT)
Received: from emlid-ThinkPad-E480.localdomain ([85.143.205.202])
        by smtp.gmail.com with ESMTPSA id m9-20020ac24249000000b004471fa09a95sm3232177lfl.265.2022.04.10.23.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Apr 2022 23:36:15 -0700 (PDT)
From:   Andrei Lalaev <andrei.lalaev@emlid.com>
To:     linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrei Lalaev <andrei.lalaev@emlid.com>
Subject: [PATCH] gpiolib: of: fix bounds check for valid mask
Date:   Mon, 11 Apr 2022 09:33:25 +0300
Message-Id: <20220411063324.98542-1-andrei.lalaev@emlid.com>
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

Use "greater" instead of "greater or equal" when performs bounds check
to make sure that GPIOS are in available range. Previous implementation
skipped ranges which include last GPIO in range.

Signed-off-by: Andrei Lalaev <andrei.lalaev@emlid.com>
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

