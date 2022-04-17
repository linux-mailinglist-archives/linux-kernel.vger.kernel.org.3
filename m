Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2949504872
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 18:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234516AbiDQQ4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 12:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234496AbiDQQ4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 12:56:20 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F886366B0;
        Sun, 17 Apr 2022 09:53:44 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id y16so7382852ilc.7;
        Sun, 17 Apr 2022 09:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5D6NILl4YmkLrfTcck1sdO4j+0L2jByfOgqbLzhtKKs=;
        b=MRfPX3YWO6/EVPIIjuT9QNczt4JNJRn1DCUSP9gkJxeSjJjDOnfy1WI1TyGpEocNOV
         kTOiCfWxWxOVgalneexJWV3BmEoZQ5ErLoY2Idlq+RYsEARdWqsyBvNagrqpF2vzHCEx
         eByDKIDe8Kdq25hPkgeW2DZW+tPA5EG8rJpwvEi45Cd11hVbSdChz+8mC7WLdEHS+Fah
         QF4ebpxZ7yKzdbZXRbueIrPFetBOwcYYeBNvJDTaEcAtDrSVazpzhFMqC2N70owf9PeH
         Wwlo/3iwkLcY0tbfnf40cgOJgIZZlur1xzf1NnG6BwKPR1+OHdmnb6QV0+uk2My237/b
         7j9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5D6NILl4YmkLrfTcck1sdO4j+0L2jByfOgqbLzhtKKs=;
        b=6cyglQtCNomBl4DTFdeShUGOdomMGM5DQkbBfnB6QXFmb5NvvKr53gHgdnojrv5c1k
         kYA36tQtxMizvSzdSzR6lnn1AEAL0wXHoLUFp7nOaOQdv3N9E1U3wVs8EX7vSLbR0x5q
         do9+Gaq4ojF3MpkJGMgDHce+vESIMLDdE0iNT71LTtmQJyAYh7ByGZRsITH0bKVWrCYx
         7LyOjysQA89Sy6KFIEo34fX4/pMKzd+UwwxCews9o7ezE1pDyFJyLfMIreVzbm3lrKSm
         t00g7xaagjNIjzTfP7b4TOGClsYViX4Wbg5zpCDzgY5h7nS9SN1Ha+v77zTVbLyxSfeE
         uHcg==
X-Gm-Message-State: AOAM5331jpuxUA+hq1CRuAXWgIEAGZMoSjgWToEAw8pDpPbWGwHN8d+d
        H0Ze8PySYxyn2SVzprYY4iA=
X-Google-Smtp-Source: ABdhPJz0ED/K/UtRpNtOaJ5RJE0VJ7lvo1q9Y5Dcon6uJJYxW1/n6PpYER/B2hz8hfu1QUSYNwFVUA==
X-Received: by 2002:a92:cd83:0:b0:2cc:1a66:6435 with SMTP id r3-20020a92cd83000000b002cc1a666435mr1595008ilb.252.1650214423774;
        Sun, 17 Apr 2022 09:53:43 -0700 (PDT)
Received: from localhost (ec2-13-59-0-164.us-east-2.compute.amazonaws.com. [13.59.0.164])
        by smtp.gmail.com with UTF8SMTPSA id f10-20020a05660215ca00b0064d25228248sm6999500iow.11.2022.04.17.09.53.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Apr 2022 09:53:43 -0700 (PDT)
From:   Schspa Shi <schspa@gmail.com>
To:     andy.shevchenko@gmail.com
Cc:     brgl@bgdev.pl, f.fainelli@gmail.com, fancer.lancer@gmail.com,
        hoan@os.amperecomputing.com, linus.walleij@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, opendmb@gmail.com, schspa@gmail.com
Subject: [PATCH v2 09/15] gpio: idt3243x: use raw lock for bgpio_lock
Date:   Mon, 18 Apr 2022 00:52:02 +0800
Message-Id: <20220417165208.39754-9-schspa@gmail.com>
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
 drivers/gpio/gpio-idt3243x.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/gpio-idt3243x.c b/drivers/gpio/gpio-idt3243x.c
index 52b8b72ded77..1cafdf46f875 100644
--- a/drivers/gpio/gpio-idt3243x.c
+++ b/drivers/gpio/gpio-idt3243x.c
@@ -57,7 +57,7 @@ static int idt_gpio_irq_set_type(struct irq_data *d, unsigned int flow_type)
 	if (sense == IRQ_TYPE_NONE || (sense & IRQ_TYPE_EDGE_BOTH))
 		return -EINVAL;
 
-	spin_lock_irqsave(&gc->bgpio_lock, flags);
+	raw_spin_lock_irqsave(&gc->bgpio_lock, flags);
 
 	ilevel = readl(ctrl->gpio + IDT_GPIO_ILEVEL);
 	if (sense & IRQ_TYPE_LEVEL_HIGH)
@@ -68,7 +68,7 @@ static int idt_gpio_irq_set_type(struct irq_data *d, unsigned int flow_type)
 	writel(ilevel, ctrl->gpio + IDT_GPIO_ILEVEL);
 	irq_set_handler_locked(d, handle_level_irq);
 
-	spin_unlock_irqrestore(&gc->bgpio_lock, flags);
+	raw_spin_unlock_irqrestore(&gc->bgpio_lock, flags);
 	return 0;
 }
 
@@ -86,12 +86,12 @@ static void idt_gpio_mask(struct irq_data *d)
 	struct idt_gpio_ctrl *ctrl = gpiochip_get_data(gc);
 	unsigned long flags;
 
-	spin_lock_irqsave(&gc->bgpio_lock, flags);
+	raw_spin_lock_irqsave(&gc->bgpio_lock, flags);
 
 	ctrl->mask_cache |= BIT(d->hwirq);
 	writel(ctrl->mask_cache, ctrl->pic + IDT_PIC_IRQ_MASK);
 
-	spin_unlock_irqrestore(&gc->bgpio_lock, flags);
+	raw_spin_unlock_irqrestore(&gc->bgpio_lock, flags);
 }
 
 static void idt_gpio_unmask(struct irq_data *d)
@@ -100,12 +100,12 @@ static void idt_gpio_unmask(struct irq_data *d)
 	struct idt_gpio_ctrl *ctrl = gpiochip_get_data(gc);
 	unsigned long flags;
 
-	spin_lock_irqsave(&gc->bgpio_lock, flags);
+	raw_spin_lock_irqsave(&gc->bgpio_lock, flags);
 
 	ctrl->mask_cache &= ~BIT(d->hwirq);
 	writel(ctrl->mask_cache, ctrl->pic + IDT_PIC_IRQ_MASK);
 
-	spin_unlock_irqrestore(&gc->bgpio_lock, flags);
+	raw_spin_unlock_irqrestore(&gc->bgpio_lock, flags);
 }
 
 static int idt_gpio_irq_init_hw(struct gpio_chip *gc)
-- 
2.24.3 (Apple Git-128)

