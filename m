Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6049450485E
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 18:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234427AbiDQQzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 12:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234416AbiDQQzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 12:55:07 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE6C13F64;
        Sun, 17 Apr 2022 09:52:30 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id y85so2785767iof.3;
        Sun, 17 Apr 2022 09:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HDfxEj2AIXBVPrxK8VdAYTkqepHnxXEHBD5DZE+il6M=;
        b=I3bQ32MfT4w2EcoC7Q8CaI9h+g8YTFICZeDfpIOfc1kDdKQoiCdXujVGNjoCQ5axx6
         EihRbv5ZFrEIZnmP7RjX8GlyrL78ylp2HtZCfQrBXkSHDWPJmXQaV25wWMG0eT2QGT0S
         ICMloa5LCOAFdRyq2I4uZu3yTDJzM/ogUUjrxXJumC9C3YUH1zHJ2Al6VzqHf24WpCxD
         OjguheJVO9jLMQZiyqcjPw+zip2EiYZTLS/boHQFANK8p7r9m5T1ydeRfFvxZ7/IgXI8
         6em6UBqhxGsZVZsgF0iS/TyTqbzARLgZVa5SAQaQrefTwynyZvvdGYamVaqfv3yGUDPy
         n0IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HDfxEj2AIXBVPrxK8VdAYTkqepHnxXEHBD5DZE+il6M=;
        b=WelmYscncSjVXA957bVxnE4MXUG3Fwb4oH22woA0blBiaH60Df0ebz7FAO0eUmCa7k
         331HFJxFfexb8GxdB2s53YnYjLC5tiRh5gOgCF35ppSn4Us+pq02dNsSNAOREKeqnxTm
         Gf274nW/v4UkcwSuwnyI6pG45KlOMOISh4h7IoIJo4O21Jb1z6Xhjw+4oCrybbsSqzFy
         p3Zgu9frozDslbwymy6aJ1cCSW0PEIvkZarFxjybu5L7KknUATP+MiMu73xhEnIvLcQ8
         2/s4UGNItQIIJuaxuGh23wHpYPLjHwCm+u5iGRMN6vPJzjUA+VpnMPRt0Qn1hBmjnORf
         ixNw==
X-Gm-Message-State: AOAM532nzyfu9hqL1E4GaGxx47EIuTpP8IJlUH2ZvyYz/vNHx6WiaSrX
        lqpfY1gz11+4Rm3BZeFd6Bw=
X-Google-Smtp-Source: ABdhPJwdMCn7xa04OnLDn/ZbAT53D07vO5lfJ8aVlrta4VUcy8lYjEgoHESNn1gzyvz3q9nksfVEqQ==
X-Received: by 2002:a05:6638:134e:b0:323:65d0:99fe with SMTP id u14-20020a056638134e00b0032365d099femr3427182jad.131.1650214349865;
        Sun, 17 Apr 2022 09:52:29 -0700 (PDT)
Received: from localhost (ec2-13-59-0-164.us-east-2.compute.amazonaws.com. [13.59.0.164])
        by smtp.gmail.com with UTF8SMTPSA id y8-20020a920908000000b002cc18763721sm1869720ilg.74.2022.04.17.09.52.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Apr 2022 09:52:29 -0700 (PDT)
From:   Schspa Shi <schspa@gmail.com>
To:     andy.shevchenko@gmail.com
Cc:     brgl@bgdev.pl, f.fainelli@gmail.com, fancer.lancer@gmail.com,
        hoan@os.amperecomputing.com, linus.walleij@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, opendmb@gmail.com, schspa@gmail.com
Subject: [PATCH v2 01/15] gpio: use raw spinlock for gpio chip shadowed data
Date:   Mon, 18 Apr 2022 00:51:54 +0800
Message-Id: <20220417165208.39754-1-schspa@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <CAHp75Veo30c0BWb4Fykgvd-czSnEXsyA8wyMTeKQdS49=e5-nw@mail.gmail.com>
References: <CAHp75Veo30c0BWb4Fykgvd-czSnEXsyA8wyMTeKQdS49=e5-nw@mail.gmail.com>
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

In case of PREEMPT_RT, there is a raw_spinlock -> spinlock dependency
as the lockdep report shows.

__irq_set_handler
  irq_get_desc_buslock
    __irq_get_desc_lock
      raw_spin_lock_irqsave(&desc->lock, *flags);  // raw spinlock get here
  __irq_do_set_handler
    mask_ack_irq
      dwapb_irq_ack
        spin_lock_irqsave(&gc->bgpio_lock, flags); // sleep able spinlock
  irq_put_desc_busunlock

Replace with a raw lock to avoid BUGs. This lock is only used to access
registers, and It's safe to replace with the raw lock without bad
influence.

[   15.090359][    T1] =============================
[   15.090365][    T1] [ BUG: Invalid wait context ]
[   15.090373][    T1] 5.10.59-rt52-00983-g186a6841c682-dirty #3 Not tainted
[   15.090386][    T1] -----------------------------
[   15.090392][    T1] swapper/0/1 is trying to lock:
[   15.090402][    T1] 70ff00018507c188 (&gc->bgpio_lock){....}-{3:3}, at: _raw_spin_lock_irqsave+0x1c/0x28
[   15.090470][    T1] other info that might help us debug this:
[   15.090477][    T1] context-{5:5}
[   15.090485][    T1] 3 locks held by swapper/0/1:
[   15.090497][    T1]  #0: c2ff0001816de1a0 (&dev->mutex){....}-{4:4}, at: __device_driver_lock+0x98/0x104
[   15.090553][    T1]  #1: ffff90001485b4b8 (irq_domain_mutex){+.+.}-{4:4}, at: irq_domain_associate+0xbc/0x6d4
[   15.090606][    T1]  #2: 4bff000185d7a8e0 (lock_class){....}-{2:2}, at: _raw_spin_lock_irqsave+0x1c/0x28
[   15.090654][    T1] stack backtrace:
[   15.090661][    T1] CPU: 4 PID: 1 Comm: swapper/0 Not tainted 5.10.59-rt52-00983-g186a6841c682-dirty #3
[   15.090682][    T1] Hardware name: Horizon Robotics Journey 5 DVB (DT)
[   15.090692][    T1] Call trace:
......
[   15.090811][    T1]  _raw_spin_lock_irqsave+0x1c/0x28
[   15.090828][    T1]  dwapb_irq_ack+0xb4/0x300
[   15.090846][    T1]  __irq_do_set_handler+0x494/0xb2c
[   15.090864][    T1]  __irq_set_handler+0x74/0x114
[   15.090881][    T1]  irq_set_chip_and_handler_name+0x44/0x58
[   15.090900][    T1]  gpiochip_irq_map+0x210/0x644
......

Changelog:
v1 -> v2:
        - Reduce the useless stacktrace.
        - Split to series of patches

Link: https://lore.kernel.org/all/20220415165505.30383-1-schspa@gmail.com/

Signed-off-by: Schspa Shi <schspa@gmail.com>
---
 drivers/gpio/gpio-mmio.c    | 22 +++++++++++-----------
 include/linux/gpio/driver.h |  2 +-
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/gpio/gpio-mmio.c b/drivers/gpio/gpio-mmio.c
index c335a0309ba3..d9dff3dc92ae 100644
--- a/drivers/gpio/gpio-mmio.c
+++ b/drivers/gpio/gpio-mmio.c
@@ -220,7 +220,7 @@ static void bgpio_set(struct gpio_chip *gc, unsigned int gpio, int val)
 	unsigned long mask = bgpio_line2mask(gc, gpio);
 	unsigned long flags;
 
-	spin_lock_irqsave(&gc->bgpio_lock, flags);
+	raw_spin_lock_irqsave(&gc->bgpio_lock, flags);
 
 	if (val)
 		gc->bgpio_data |= mask;
@@ -229,7 +229,7 @@ static void bgpio_set(struct gpio_chip *gc, unsigned int gpio, int val)
 
 	gc->write_reg(gc->reg_dat, gc->bgpio_data);
 
-	spin_unlock_irqrestore(&gc->bgpio_lock, flags);
+	raw_spin_unlock_irqrestore(&gc->bgpio_lock, flags);
 }
 
 static void bgpio_set_with_clear(struct gpio_chip *gc, unsigned int gpio,
@@ -248,7 +248,7 @@ static void bgpio_set_set(struct gpio_chip *gc, unsigned int gpio, int val)
 	unsigned long mask = bgpio_line2mask(gc, gpio);
 	unsigned long flags;
 
-	spin_lock_irqsave(&gc->bgpio_lock, flags);
+	raw_spin_lock_irqsave(&gc->bgpio_lock, flags);
 
 	if (val)
 		gc->bgpio_data |= mask;
@@ -257,7 +257,7 @@ static void bgpio_set_set(struct gpio_chip *gc, unsigned int gpio, int val)
 
 	gc->write_reg(gc->reg_set, gc->bgpio_data);
 
-	spin_unlock_irqrestore(&gc->bgpio_lock, flags);
+	raw_spin_unlock_irqrestore(&gc->bgpio_lock, flags);
 }
 
 static void bgpio_multiple_get_masks(struct gpio_chip *gc,
@@ -286,7 +286,7 @@ static void bgpio_set_multiple_single_reg(struct gpio_chip *gc,
 	unsigned long flags;
 	unsigned long set_mask, clear_mask;
 
-	spin_lock_irqsave(&gc->bgpio_lock, flags);
+	raw_spin_lock_irqsave(&gc->bgpio_lock, flags);
 
 	bgpio_multiple_get_masks(gc, mask, bits, &set_mask, &clear_mask);
 
@@ -295,7 +295,7 @@ static void bgpio_set_multiple_single_reg(struct gpio_chip *gc,
 
 	gc->write_reg(reg, gc->bgpio_data);
 
-	spin_unlock_irqrestore(&gc->bgpio_lock, flags);
+	raw_spin_unlock_irqrestore(&gc->bgpio_lock, flags);
 }
 
 static void bgpio_set_multiple(struct gpio_chip *gc, unsigned long *mask,
@@ -347,7 +347,7 @@ static int bgpio_dir_in(struct gpio_chip *gc, unsigned int gpio)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&gc->bgpio_lock, flags);
+	raw_spin_lock_irqsave(&gc->bgpio_lock, flags);
 
 	gc->bgpio_dir &= ~bgpio_line2mask(gc, gpio);
 
@@ -356,7 +356,7 @@ static int bgpio_dir_in(struct gpio_chip *gc, unsigned int gpio)
 	if (gc->reg_dir_out)
 		gc->write_reg(gc->reg_dir_out, gc->bgpio_dir);
 
-	spin_unlock_irqrestore(&gc->bgpio_lock, flags);
+	raw_spin_unlock_irqrestore(&gc->bgpio_lock, flags);
 
 	return 0;
 }
@@ -387,7 +387,7 @@ static void bgpio_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&gc->bgpio_lock, flags);
+	raw_spin_lock_irqsave(&gc->bgpio_lock, flags);
 
 	gc->bgpio_dir |= bgpio_line2mask(gc, gpio);
 
@@ -396,7 +396,7 @@ static void bgpio_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
 	if (gc->reg_dir_out)
 		gc->write_reg(gc->reg_dir_out, gc->bgpio_dir);
 
-	spin_unlock_irqrestore(&gc->bgpio_lock, flags);
+	raw_spin_unlock_irqrestore(&gc->bgpio_lock, flags);
 }
 
 static int bgpio_dir_out_dir_first(struct gpio_chip *gc, unsigned int gpio,
@@ -610,7 +610,7 @@ int bgpio_init(struct gpio_chip *gc, struct device *dev,
 	if (gc->bgpio_bits > BITS_PER_LONG)
 		return -EINVAL;
 
-	spin_lock_init(&gc->bgpio_lock);
+	raw_spin_lock_init(&gc->bgpio_lock);
 	gc->parent = dev;
 	gc->label = dev_name(dev);
 	gc->base = -1;
diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index 874aabd270c9..ff8247a19f57 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -445,7 +445,7 @@ struct gpio_chip {
 	void __iomem *reg_dir_in;
 	bool bgpio_dir_unreadable;
 	int bgpio_bits;
-	spinlock_t bgpio_lock;
+	raw_spinlock_t bgpio_lock;
 	unsigned long bgpio_data;
 	unsigned long bgpio_dir;
 #endif /* CONFIG_GPIO_GENERIC */
-- 
2.24.3 (Apple Git-128)

