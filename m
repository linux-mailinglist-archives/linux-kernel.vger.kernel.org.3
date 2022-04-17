Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 545DB504878
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 18:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234508AbiDQQ5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 12:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234547AbiDQQ4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 12:56:49 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3584636B50;
        Sun, 17 Apr 2022 09:54:13 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id r17so1386444iln.9;
        Sun, 17 Apr 2022 09:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WpafZOKGy8uw4nGe6/GVYe+oBX78YZzxyaLoPSujzfU=;
        b=egMfLQdOLO8GIGFwSxiNlknQU9OQprDKwJuzaZCkUJsN+I2Z32yd4zQHbWDu/PmvMn
         vz4uh3chuZUOVGEjIxrK+GGMQYsw4Y9zv6jvFUIRxHBpSfkBKJrfWWzKmw9raaqJ+JWM
         K1NrAtoj2Ersr815tCIh7bpVPB14aUw23T3IV5slSA1Gu8/+tOsdxElP+Wb1XKawNLCI
         khTPBzemsqLcDy3uvML++snSlTkxpCnuZ8YyPMusgd79yd5pxrsG+zbV7rM+fhrLNUJU
         0X59h8BYJOi6gicT0MWDLLK2lY93/Ylf30nvWVKgvmfYA7AutbEQEPZB5HMe8r1dKfj9
         /6bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WpafZOKGy8uw4nGe6/GVYe+oBX78YZzxyaLoPSujzfU=;
        b=ykQLXZlHsjk/b11OtUDzTWSdJjEUZ9k+eA1wGWNWQ8BAXf2P/6d//aJCN8klt+v0so
         o7BnKnp2WCZqoa3UTRWc5S8XQiSx3QfYT3Dt2+YKykdQT40FENepxfcCjT0GlKhfR+0V
         mRdLg3lHn8qj5Wn6hHz/cvarTs91cNKUHUNorNtvp8XofD7nDH94TbhybhRM04ux888w
         RSaKf1J+5kBw6wzDEW8kaEOFTx67WakmFYnqRWNb5NFtHwWOax45VHjPs5lXZdxJSFd4
         HDnDx06FsYvShEMlkZ3Ujr7ojQyHEzlvvHhh/uEK2wRtpJ6uFLkYG3W/4PvQlFv75B7b
         lOcQ==
X-Gm-Message-State: AOAM531P71uBK6uXOJN/hctD6sNKEiWBxGdLTtc/DJtOP/syPN7Qp5q7
        enYcAjVwceL6vCJ7jofWnT4=
X-Google-Smtp-Source: ABdhPJxIMxTNkVpwSRXdJeqHX05+ohsoFzcH3flCB34EEJXR1f2wEuLKcSSiKfzo26XiccOezvEglQ==
X-Received: by 2002:a92:9405:0:b0:2bf:6a01:6ad1 with SMTP id c5-20020a929405000000b002bf6a016ad1mr3246596ili.197.1650214452620;
        Sun, 17 Apr 2022 09:54:12 -0700 (PDT)
Received: from localhost (ec2-13-59-0-164.us-east-2.compute.amazonaws.com. [13.59.0.164])
        by smtp.gmail.com with UTF8SMTPSA id t18-20020a056e02011200b002cbe6ce18e5sm5697326ilm.40.2022.04.17.09.54.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Apr 2022 09:54:12 -0700 (PDT)
From:   Schspa Shi <schspa@gmail.com>
To:     andy.shevchenko@gmail.com
Cc:     brgl@bgdev.pl, f.fainelli@gmail.com, fancer.lancer@gmail.com,
        hoan@os.amperecomputing.com, linus.walleij@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, opendmb@gmail.com, schspa@gmail.com
Subject: [PATCH v2 13/15] gpio: cadence: use raw lock for bgpio_lock
Date:   Mon, 18 Apr 2022 00:52:06 +0800
Message-Id: <20220417165208.39754-13-schspa@gmail.com>
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
 drivers/gpio/gpio-cadence.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/gpio-cadence.c b/drivers/gpio/gpio-cadence.c
index 562f8f7e7d1f..137aea49ba02 100644
--- a/drivers/gpio/gpio-cadence.c
+++ b/drivers/gpio/gpio-cadence.c
@@ -41,12 +41,12 @@ static int cdns_gpio_request(struct gpio_chip *chip, unsigned int offset)
 	struct cdns_gpio_chip *cgpio = gpiochip_get_data(chip);
 	unsigned long flags;
 
-	spin_lock_irqsave(&chip->bgpio_lock, flags);
+	raw_spin_lock_irqsave(&chip->bgpio_lock, flags);
 
 	iowrite32(ioread32(cgpio->regs + CDNS_GPIO_BYPASS_MODE) & ~BIT(offset),
 		  cgpio->regs + CDNS_GPIO_BYPASS_MODE);
 
-	spin_unlock_irqrestore(&chip->bgpio_lock, flags);
+	raw_spin_unlock_irqrestore(&chip->bgpio_lock, flags);
 	return 0;
 }
 
@@ -55,13 +55,13 @@ static void cdns_gpio_free(struct gpio_chip *chip, unsigned int offset)
 	struct cdns_gpio_chip *cgpio = gpiochip_get_data(chip);
 	unsigned long flags;
 
-	spin_lock_irqsave(&chip->bgpio_lock, flags);
+	raw_spin_lock_irqsave(&chip->bgpio_lock, flags);
 
 	iowrite32(ioread32(cgpio->regs + CDNS_GPIO_BYPASS_MODE) |
 		  (BIT(offset) & cgpio->bypass_orig),
 		  cgpio->regs + CDNS_GPIO_BYPASS_MODE);
 
-	spin_unlock_irqrestore(&chip->bgpio_lock, flags);
+	raw_spin_unlock_irqrestore(&chip->bgpio_lock, flags);
 }
 
 static void cdns_gpio_irq_mask(struct irq_data *d)
@@ -90,7 +90,7 @@ static int cdns_gpio_irq_set_type(struct irq_data *d, unsigned int type)
 	u32 mask = BIT(d->hwirq);
 	int ret = 0;
 
-	spin_lock_irqsave(&chip->bgpio_lock, flags);
+	raw_spin_lock_irqsave(&chip->bgpio_lock, flags);
 
 	int_value = ioread32(cgpio->regs + CDNS_GPIO_IRQ_VALUE) & ~mask;
 	int_type = ioread32(cgpio->regs + CDNS_GPIO_IRQ_TYPE) & ~mask;
@@ -115,7 +115,7 @@ static int cdns_gpio_irq_set_type(struct irq_data *d, unsigned int type)
 	iowrite32(int_type, cgpio->regs + CDNS_GPIO_IRQ_TYPE);
 
 err_irq_type:
-	spin_unlock_irqrestore(&chip->bgpio_lock, flags);
+	raw_spin_unlock_irqrestore(&chip->bgpio_lock, flags);
 	return ret;
 }
 
-- 
2.24.3 (Apple Git-128)

