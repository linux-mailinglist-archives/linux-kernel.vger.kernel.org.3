Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2212504868
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 18:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234447AbiDQQzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 12:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234429AbiDQQzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 12:55:49 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA613669D;
        Sun, 17 Apr 2022 09:53:05 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id r12so6599960iod.6;
        Sun, 17 Apr 2022 09:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qt+lIiaoXj1DlgMlhg3MjeYK/cjNRe8GsFy1n6MmALQ=;
        b=FGEfP0j+HjHjlmD5uStx+e3iLnengOE0cWLF3SOWJ4NqIK0hZ7w+0y8vz/asw6VW9J
         bnGMr+qSXHHGxlI+BmCfJaqMp6B6i9dCZlpwsRVye/2OX+N+vRnN5eufd1ieJCfJqYjz
         j6n7wn40NcYPxXHIAYKON7YnckDJCwnt3X8Ah/CLPSRWe7+MBQi9Wu5NQHvXrJmPHBu0
         QiJFMGWNEczJQKrBAhkxrjQHN9J/xo1gSnO3wMmI91DB+gEeDStyVPXBDIjbNNiHiwuB
         tAPoXqsPrQuKLi0R3PU7TzReR327Yjmqj7kMTk0lcHXFXRX8wdY/ope1hmqatcDMmkTq
         kkKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qt+lIiaoXj1DlgMlhg3MjeYK/cjNRe8GsFy1n6MmALQ=;
        b=G9SQ5nPOZcpz5yRehxj0E0KUj/dXIek6/aRDQ5TZd4ykVUKTo5GTCZl5u2Yql+7buT
         sKoNM+vc/E2phdufcruqFIHRNzWJwh/Xgw2vm3XaE5CodfBGb/41T8T/mEw5Ha3fm2Ee
         6UCbFjXHGTJO1U9kiSBT0Qdmt6V/oZN28meezaslAKhqKoKeTGse1SZv5wskK+NrldMQ
         X1soj0M4wbMHGCZcoWlCho2dMq6+RVi7p62jGX7nkGG7OyLiJ1oK6WOZ6ygJSb7w3jg4
         suF/H4JVG2S8VUoBYVk8ODw+vcgn++R5unYOz/zlt6WflOSIo8xPBs+24BSTuUbIUfGO
         VSYA==
X-Gm-Message-State: AOAM532jIBZROgHtbmVU8HYj+1XEWJZUZienXQRMGtHL9YebNJ2tH0Fr
        I+I6RJrHYp+GNs24gJB4F9E=
X-Google-Smtp-Source: ABdhPJwMBNqO1HFmGHhprp9/rHf6X4VsprTSDjCpeb7oPWF4mrHQKZKV9/OjXk+upw3nNlFjA+6E1w==
X-Received: by 2002:a02:a98f:0:b0:315:19db:27a3 with SMTP id q15-20020a02a98f000000b0031519db27a3mr3202308jam.184.1650214384621;
        Sun, 17 Apr 2022 09:53:04 -0700 (PDT)
Received: from localhost (ec2-13-59-0-164.us-east-2.compute.amazonaws.com. [13.59.0.164])
        by smtp.gmail.com with UTF8SMTPSA id c4-20020a6b4e04000000b00653e74540f0sm3130481iob.7.2022.04.17.09.53.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Apr 2022 09:53:04 -0700 (PDT)
From:   Schspa Shi <schspa@gmail.com>
To:     andy.shevchenko@gmail.com
Cc:     brgl@bgdev.pl, f.fainelli@gmail.com, fancer.lancer@gmail.com,
        hoan@os.amperecomputing.com, linus.walleij@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, opendmb@gmail.com, schspa@gmail.com
Subject: [PATCH v2 04/15] gpio: sifive: use raw lock for bgpio_lock
Date:   Mon, 18 Apr 2022 00:51:57 +0800
Message-Id: <20220417165208.39754-4-schspa@gmail.com>
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
 drivers/gpio/gpio-sifive.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/gpio-sifive.c b/drivers/gpio/gpio-sifive.c
index 7d82388b4ab7..03b8c4de2e91 100644
--- a/drivers/gpio/gpio-sifive.c
+++ b/drivers/gpio/gpio-sifive.c
@@ -44,7 +44,7 @@ static void sifive_gpio_set_ie(struct sifive_gpio *chip, unsigned int offset)
 	unsigned long flags;
 	unsigned int trigger;
 
-	spin_lock_irqsave(&chip->gc.bgpio_lock, flags);
+	raw_spin_lock_irqsave(&chip->gc.bgpio_lock, flags);
 	trigger = (chip->irq_state & BIT(offset)) ? chip->trigger[offset] : 0;
 	regmap_update_bits(chip->regs, SIFIVE_GPIO_RISE_IE, BIT(offset),
 			   (trigger & IRQ_TYPE_EDGE_RISING) ? BIT(offset) : 0);
@@ -54,7 +54,7 @@ static void sifive_gpio_set_ie(struct sifive_gpio *chip, unsigned int offset)
 			   (trigger & IRQ_TYPE_LEVEL_HIGH) ? BIT(offset) : 0);
 	regmap_update_bits(chip->regs, SIFIVE_GPIO_LOW_IE, BIT(offset),
 			   (trigger & IRQ_TYPE_LEVEL_LOW) ? BIT(offset) : 0);
-	spin_unlock_irqrestore(&chip->gc.bgpio_lock, flags);
+	raw_spin_unlock_irqrestore(&chip->gc.bgpio_lock, flags);
 }
 
 static int sifive_gpio_irq_set_type(struct irq_data *d, unsigned int trigger)
@@ -84,13 +84,13 @@ static void sifive_gpio_irq_enable(struct irq_data *d)
 	/* Switch to input */
 	gc->direction_input(gc, offset);
 
-	spin_lock_irqsave(&gc->bgpio_lock, flags);
+	raw_spin_lock_irqsave(&gc->bgpio_lock, flags);
 	/* Clear any sticky pending interrupts */
 	regmap_write(chip->regs, SIFIVE_GPIO_RISE_IP, bit);
 	regmap_write(chip->regs, SIFIVE_GPIO_FALL_IP, bit);
 	regmap_write(chip->regs, SIFIVE_GPIO_HIGH_IP, bit);
 	regmap_write(chip->regs, SIFIVE_GPIO_LOW_IP, bit);
-	spin_unlock_irqrestore(&gc->bgpio_lock, flags);
+	raw_spin_unlock_irqrestore(&gc->bgpio_lock, flags);
 
 	/* Enable interrupts */
 	assign_bit(offset, &chip->irq_state, 1);
@@ -116,13 +116,13 @@ static void sifive_gpio_irq_eoi(struct irq_data *d)
 	u32 bit = BIT(offset);
 	unsigned long flags;
 
-	spin_lock_irqsave(&gc->bgpio_lock, flags);
+	raw_spin_lock_irqsave(&gc->bgpio_lock, flags);
 	/* Clear all pending interrupts */
 	regmap_write(chip->regs, SIFIVE_GPIO_RISE_IP, bit);
 	regmap_write(chip->regs, SIFIVE_GPIO_FALL_IP, bit);
 	regmap_write(chip->regs, SIFIVE_GPIO_HIGH_IP, bit);
 	regmap_write(chip->regs, SIFIVE_GPIO_LOW_IP, bit);
-	spin_unlock_irqrestore(&gc->bgpio_lock, flags);
+	raw_spin_unlock_irqrestore(&gc->bgpio_lock, flags);
 
 	irq_chip_eoi_parent(d);
 }
-- 
2.24.3 (Apple Git-128)

