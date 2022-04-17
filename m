Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9BC50486E
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 18:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234475AbiDQQ4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 12:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234463AbiDQQzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 12:55:54 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6481636692;
        Sun, 17 Apr 2022 09:53:18 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id r11so7401446ila.1;
        Sun, 17 Apr 2022 09:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4iJFzazvB5OE5uDCqrIdiik65/U6jCZuduJdScIPpgU=;
        b=knw2LHR/3xqjb24LGF7oUL4/bcXk2a3GmM5qY86t/Wm+/e0m1+c85fGtgXVC87uRqN
         TCJCGHmQCR0mrcPUuxfe1PqQ5IrQLjmtJndO91+QiBHVZ+WrCdJgV+xc/FL9qaycmigX
         RA7qsOkNyYoWKbj0Hfnt8lkZw093ww3RivTVeB88C5leXH1YysCsMCIFJ0GS8RQrTGUc
         0oRICUN9Qqm3sgecCn4QFUZsUHGQLZBF2axHqAX4pnW4z4M2tbPSxd4To8Vn0Q/CxaCZ
         6dkjxklJsDqIxBl1TjE3F5S8EHcIjdX4X2g8STyZ/gIs+HRGIom7qecndkPgJNqR8NMY
         vQVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4iJFzazvB5OE5uDCqrIdiik65/U6jCZuduJdScIPpgU=;
        b=uEvmEiOJpeUnfJHqi/Yd0F8h9XTIoMoOz/kqTkuscaReRBd+Rkilx2WLEJtyvu0F4K
         nuKkX0JyEani+S5vNd/D0sSHDbaqFfSaRUcXTLzDQu4G/EjjbNkujbcB3FQK4v606Txr
         S2wwEfuKd9/T2RCpGZnyCJLNz4J0KnwXXtLFGVRy1UO+lsZs/1LshrsSyUburK0lEjI9
         NRHH0xFzMSmvt5MHR9SAaJlJPc/TFA6hqIjlkgLbPTSjG1+5xpxOHBmyV39x1E2d+qrP
         1ed/or8UNEvoFjs5MgCfDJcl9RrUJe+ptyyokN/sQSIEyY4bFDk7ARH7RmznCvdVfOk3
         ey5A==
X-Gm-Message-State: AOAM533p7sxwx9LuLzBwM9N5KseDjGQn/TqAOqWeuV3apkxVmYatBT9d
        KbqGCdR9p2ug3okOu5tV0bM=
X-Google-Smtp-Source: ABdhPJwkk7/8kIzA/aiHehD3c6S+1kopGTbTKdVCbcCrUENES3UFHAgCH+elhrljtnwYtEzJwvvaCQ==
X-Received: by 2002:a05:6e02:1b81:b0:2ca:c4b1:9687 with SMTP id h1-20020a056e021b8100b002cac4b19687mr3101436ili.293.1650214397860;
        Sun, 17 Apr 2022 09:53:17 -0700 (PDT)
Received: from localhost (ec2-13-59-0-164.us-east-2.compute.amazonaws.com. [13.59.0.164])
        by smtp.gmail.com with UTF8SMTPSA id a22-20020a5d9816000000b006496d8651cfsm6459048iol.1.2022.04.17.09.53.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Apr 2022 09:53:17 -0700 (PDT)
From:   Schspa Shi <schspa@gmail.com>
To:     andy.shevchenko@gmail.com
Cc:     brgl@bgdev.pl, f.fainelli@gmail.com, fancer.lancer@gmail.com,
        hoan@os.amperecomputing.com, linus.walleij@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, opendmb@gmail.com, schspa@gmail.com
Subject: [PATCH v2 06/15] gpio: menz127: use raw lock for bgpio_lock
Date:   Mon, 18 Apr 2022 00:51:59 +0800
Message-Id: <20220417165208.39754-6-schspa@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20220417165208.39754-1-schspa@gmail.com>
References: <CAHp75Veo30c0BWb4Fykgvd-czSnEXsyA8wyMTeKQdS49=e5-nw@mail.gmail.com>
 <20220417165208.39754-1-schspa@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bgpio_lock is changed to raw lock, fellow the header change

Signed-off-by: Schspa Shi <schspa@gmail.com>
---
 drivers/gpio/gpio-menz127.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-menz127.c b/drivers/gpio/gpio-menz127.c
index 1e21c661d79d..a035a9bcb57c 100644
--- a/drivers/gpio/gpio-menz127.c
+++ b/drivers/gpio/gpio-menz127.c
@@ -64,7 +64,7 @@ static int men_z127_debounce(struct gpio_chip *gc, unsigned gpio,
 		debounce /= 50;
 	}
 
-	spin_lock(&gc->bgpio_lock);
+	raw_spin_lock(&gc->bgpio_lock);
 
 	db_en = readl(priv->reg_base + MEN_Z127_DBER);
 
@@ -79,7 +79,7 @@ static int men_z127_debounce(struct gpio_chip *gc, unsigned gpio,
 	writel(db_en, priv->reg_base + MEN_Z127_DBER);
 	writel(db_cnt, priv->reg_base + GPIO_TO_DBCNT_REG(gpio));
 
-	spin_unlock(&gc->bgpio_lock);
+	raw_spin_unlock(&gc->bgpio_lock);
 
 	return 0;
 }
@@ -91,7 +91,7 @@ static int men_z127_set_single_ended(struct gpio_chip *gc,
 	struct men_z127_gpio *priv = gpiochip_get_data(gc);
 	u32 od_en;
 
-	spin_lock(&gc->bgpio_lock);
+	raw_spin_lock(&gc->bgpio_lock);
 	od_en = readl(priv->reg_base + MEN_Z127_ODER);
 
 	if (param == PIN_CONFIG_DRIVE_OPEN_DRAIN)
@@ -101,7 +101,7 @@ static int men_z127_set_single_ended(struct gpio_chip *gc,
 		od_en &= ~BIT(offset);
 
 	writel(od_en, priv->reg_base + MEN_Z127_ODER);
-	spin_unlock(&gc->bgpio_lock);
+	raw_spin_unlock(&gc->bgpio_lock);
 
 	return 0;
 }
-- 
2.24.3 (Apple Git-128)

