Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1A09504877
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 18:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234532AbiDQQ4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 12:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234529AbiDQQ4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 12:56:42 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39358366A3;
        Sun, 17 Apr 2022 09:54:06 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id g21so12384482iom.13;
        Sun, 17 Apr 2022 09:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZeoPF/5s/8FefeZEMvEU3kXPz31OKiUJe25SyiRvD6Q=;
        b=T6skccgysjxKrWbkjDXiulPTulgnjRiPioFAu8/vJ7QZ2Z5IaaKQB/RZ4O+k7Wln8f
         /wSMzF1ekNINHn1weakHHyA6+TONEJlwnwPRvRq+o8HfCruG/6PELBHD6lEvLasbzxS2
         pAxqvBZ5rdOcjgGbi4lWfjIJ5BYNVH2Bj3KdNGsYZi1mrZckI95uOPtxzTMwLff2CjjV
         aEtT6UTPNOcfppcfUVqioEe36Y1PR47WANj0udnVE5UHuVRmiqmzatQzhlWpzzb27yKd
         myXZxhtzKAsicPbhKenTYKG8yNBGmZdoMo+06vuYK9deyd9jXrmwbIWX0BcUQWMKLkwM
         iIMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZeoPF/5s/8FefeZEMvEU3kXPz31OKiUJe25SyiRvD6Q=;
        b=4DV1e0uh8F8/YOFDCxCrN+mDHSMzaohAK9uRMcbIUaGNmnpzYmqPrMnSNG1AEP6hmg
         ISiZzbNd2VP6uU/D+pLTKZp6q4VQLkXYeMIa9ge+iZDUzz7PVOLAx4Fdma2w0kb0qpT6
         HtZZS8CIr0jOGWg4TVW9Y6tcSbRBSU2tQ/WKc7OYaNtfwtbcSK+32FPneEocV3cPn9T3
         ljGVUanjYwjtT7jiUUOKeBzrgbHdllWAu3R1yb4aqcPicCMRWWEfCvwDkpHbK9G+xTpj
         CsdJelZiDvHdGObG5AvsKJmksJ9t73fJfMhyNlfNyaME+TXXX6P8Y7ZqUvUSWqZZLZM+
         AONw==
X-Gm-Message-State: AOAM531uEvHgB7/M0Z6nl6qvS/STB4JKB8UdgjAqQpfPyP3c4d3Kq5GD
        +Af2in1cilNmZGAiA2hFsDw=
X-Google-Smtp-Source: ABdhPJyR8KhzPCxF4rkMPJPQnV2k6aCKS9RbpGHxF/VNtsR5BydtgXayWDVRtFWaRIp/DveMws7m/A==
X-Received: by 2002:a02:9429:0:b0:326:6774:5ba0 with SMTP id a38-20020a029429000000b0032667745ba0mr3272012jai.213.1650214445540;
        Sun, 17 Apr 2022 09:54:05 -0700 (PDT)
Received: from localhost (ec2-13-59-0-164.us-east-2.compute.amazonaws.com. [13.59.0.164])
        by smtp.gmail.com with UTF8SMTPSA id p15-20020a92da4f000000b002caa4481d07sm5965239ilq.23.2022.04.17.09.54.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Apr 2022 09:54:05 -0700 (PDT)
From:   Schspa Shi <schspa@gmail.com>
To:     andy.shevchenko@gmail.com
Cc:     brgl@bgdev.pl, f.fainelli@gmail.com, fancer.lancer@gmail.com,
        hoan@os.amperecomputing.com, linus.walleij@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, opendmb@gmail.com, schspa@gmail.com
Subject: [PATCH v2 12/15] gpio: dwapb: use raw lock for bgpio_lock
Date:   Mon, 18 Apr 2022 00:52:05 +0800
Message-Id: <20220417165208.39754-12-schspa@gmail.com>
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
 drivers/gpio/gpio-dwapb.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/gpio/gpio-dwapb.c b/drivers/gpio/gpio-dwapb.c
index b0f3aca61974..7130195da48d 100644
--- a/drivers/gpio/gpio-dwapb.c
+++ b/drivers/gpio/gpio-dwapb.c
@@ -243,9 +243,9 @@ static void dwapb_irq_ack(struct irq_data *d)
 	u32 val = BIT(irqd_to_hwirq(d));
 	unsigned long flags;
 
-	spin_lock_irqsave(&gc->bgpio_lock, flags);
+	raw_spin_lock_irqsave(&gc->bgpio_lock, flags);
 	dwapb_write(gpio, GPIO_PORTA_EOI, val);
-	spin_unlock_irqrestore(&gc->bgpio_lock, flags);
+	raw_spin_unlock_irqrestore(&gc->bgpio_lock, flags);
 }
 
 static void dwapb_irq_mask(struct irq_data *d)
@@ -255,10 +255,10 @@ static void dwapb_irq_mask(struct irq_data *d)
 	unsigned long flags;
 	u32 val;
 
-	spin_lock_irqsave(&gc->bgpio_lock, flags);
+	raw_spin_lock_irqsave(&gc->bgpio_lock, flags);
 	val = dwapb_read(gpio, GPIO_INTMASK) | BIT(irqd_to_hwirq(d));
 	dwapb_write(gpio, GPIO_INTMASK, val);
-	spin_unlock_irqrestore(&gc->bgpio_lock, flags);
+	raw_spin_unlock_irqrestore(&gc->bgpio_lock, flags);
 }
 
 static void dwapb_irq_unmask(struct irq_data *d)
@@ -268,10 +268,10 @@ static void dwapb_irq_unmask(struct irq_data *d)
 	unsigned long flags;
 	u32 val;
 
-	spin_lock_irqsave(&gc->bgpio_lock, flags);
+	raw_spin_lock_irqsave(&gc->bgpio_lock, flags);
 	val = dwapb_read(gpio, GPIO_INTMASK) & ~BIT(irqd_to_hwirq(d));
 	dwapb_write(gpio, GPIO_INTMASK, val);
-	spin_unlock_irqrestore(&gc->bgpio_lock, flags);
+	raw_spin_unlock_irqrestore(&gc->bgpio_lock, flags);
 }
 
 static void dwapb_irq_enable(struct irq_data *d)
@@ -281,11 +281,11 @@ static void dwapb_irq_enable(struct irq_data *d)
 	unsigned long flags;
 	u32 val;
 
-	spin_lock_irqsave(&gc->bgpio_lock, flags);
+	raw_spin_lock_irqsave(&gc->bgpio_lock, flags);
 	val = dwapb_read(gpio, GPIO_INTEN);
 	val |= BIT(irqd_to_hwirq(d));
 	dwapb_write(gpio, GPIO_INTEN, val);
-	spin_unlock_irqrestore(&gc->bgpio_lock, flags);
+	raw_spin_unlock_irqrestore(&gc->bgpio_lock, flags);
 }
 
 static void dwapb_irq_disable(struct irq_data *d)
@@ -295,11 +295,11 @@ static void dwapb_irq_disable(struct irq_data *d)
 	unsigned long flags;
 	u32 val;
 
-	spin_lock_irqsave(&gc->bgpio_lock, flags);
+	raw_spin_lock_irqsave(&gc->bgpio_lock, flags);
 	val = dwapb_read(gpio, GPIO_INTEN);
 	val &= ~BIT(irqd_to_hwirq(d));
 	dwapb_write(gpio, GPIO_INTEN, val);
-	spin_unlock_irqrestore(&gc->bgpio_lock, flags);
+	raw_spin_unlock_irqrestore(&gc->bgpio_lock, flags);
 }
 
 static int dwapb_irq_set_type(struct irq_data *d, u32 type)
@@ -309,7 +309,7 @@ static int dwapb_irq_set_type(struct irq_data *d, u32 type)
 	irq_hw_number_t bit = irqd_to_hwirq(d);
 	unsigned long level, polarity, flags;
 
-	spin_lock_irqsave(&gc->bgpio_lock, flags);
+	raw_spin_lock_irqsave(&gc->bgpio_lock, flags);
 	level = dwapb_read(gpio, GPIO_INTTYPE_LEVEL);
 	polarity = dwapb_read(gpio, GPIO_INT_POLARITY);
 
@@ -344,7 +344,7 @@ static int dwapb_irq_set_type(struct irq_data *d, u32 type)
 	dwapb_write(gpio, GPIO_INTTYPE_LEVEL, level);
 	if (type != IRQ_TYPE_EDGE_BOTH)
 		dwapb_write(gpio, GPIO_INT_POLARITY, polarity);
-	spin_unlock_irqrestore(&gc->bgpio_lock, flags);
+	raw_spin_unlock_irqrestore(&gc->bgpio_lock, flags);
 
 	return 0;
 }
@@ -374,7 +374,7 @@ static int dwapb_gpio_set_debounce(struct gpio_chip *gc,
 	unsigned long flags, val_deb;
 	unsigned long mask = BIT(offset);
 
-	spin_lock_irqsave(&gc->bgpio_lock, flags);
+	raw_spin_lock_irqsave(&gc->bgpio_lock, flags);
 
 	val_deb = dwapb_read(gpio, GPIO_PORTA_DEBOUNCE);
 	if (debounce)
@@ -383,7 +383,7 @@ static int dwapb_gpio_set_debounce(struct gpio_chip *gc,
 		val_deb &= ~mask;
 	dwapb_write(gpio, GPIO_PORTA_DEBOUNCE, val_deb);
 
-	spin_unlock_irqrestore(&gc->bgpio_lock, flags);
+	raw_spin_unlock_irqrestore(&gc->bgpio_lock, flags);
 
 	return 0;
 }
@@ -738,7 +738,7 @@ static int dwapb_gpio_suspend(struct device *dev)
 	unsigned long flags;
 	int i;
 
-	spin_lock_irqsave(&gc->bgpio_lock, flags);
+	raw_spin_lock_irqsave(&gc->bgpio_lock, flags);
 	for (i = 0; i < gpio->nr_ports; i++) {
 		unsigned int offset;
 		unsigned int idx = gpio->ports[i].idx;
@@ -765,7 +765,7 @@ static int dwapb_gpio_suspend(struct device *dev)
 			dwapb_write(gpio, GPIO_INTMASK, ~ctx->wake_en);
 		}
 	}
-	spin_unlock_irqrestore(&gc->bgpio_lock, flags);
+	raw_spin_unlock_irqrestore(&gc->bgpio_lock, flags);
 
 	clk_bulk_disable_unprepare(DWAPB_NR_CLOCKS, gpio->clks);
 
@@ -785,7 +785,7 @@ static int dwapb_gpio_resume(struct device *dev)
 		return err;
 	}
 
-	spin_lock_irqsave(&gc->bgpio_lock, flags);
+	raw_spin_lock_irqsave(&gc->bgpio_lock, flags);
 	for (i = 0; i < gpio->nr_ports; i++) {
 		unsigned int offset;
 		unsigned int idx = gpio->ports[i].idx;
@@ -812,7 +812,7 @@ static int dwapb_gpio_resume(struct device *dev)
 			dwapb_write(gpio, GPIO_PORTA_EOI, 0xffffffff);
 		}
 	}
-	spin_unlock_irqrestore(&gc->bgpio_lock, flags);
+	raw_spin_unlock_irqrestore(&gc->bgpio_lock, flags);
 
 	return 0;
 }
-- 
2.24.3 (Apple Git-128)

