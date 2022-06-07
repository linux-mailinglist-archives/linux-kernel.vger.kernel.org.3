Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28B5F53FCEC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 13:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242507AbiFGLI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 07:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242531AbiFGLI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 07:08:27 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B7C10EA4C;
        Tue,  7 Jun 2022 04:04:32 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id v1so23748007ejg.13;
        Tue, 07 Jun 2022 04:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dE3IfDBto2P1Lw1uX63OsonLCvmTMY25nDr0mUDzn+Q=;
        b=L3il+xydJWAarPyPUgZutiMe46kqGVZ4BfF4kMo68FgtCnXbiHU6vikypBkE5LvRhl
         FL7QnepGJil4FpKHDOZE9wbRTJpBHgrCcV5XkK2U459iNIu219cAZNVOCNB9xlpS0jCE
         5w6HqD8YN1XwLSbkiW+0wMMJ+F/gqx169QTy0GSd1Lu/gwYydPSo/A2BjLxsqrOUKk1X
         At2BGene276+74Ezm8McnBoDjrruqc1afTRGD5O+02dM2D1v2zibsCnGHAvDYsytUS2s
         5pLWqOt0nTUClno+zB8d1ealys8sy64/CKp9itA7l/5Okoiuapjq3ExRoxSje1zVvmW/
         07fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dE3IfDBto2P1Lw1uX63OsonLCvmTMY25nDr0mUDzn+Q=;
        b=EVzSCR4Gk+KCZAOb+ViN35LAGkOoxN/mQrG9zbjaRgeGBsywAyWFSpGnYl8Kj5e8Od
         sH9ZrCl5noV7c3GflqmlzYuLr5SE0iOjjuZo7D/P694eo07QcLydjjTEHTKk2fuavZQt
         uH3H/Zfjk6sdV5Skk2nUjGTwKVB9Rj6DjEEcefI2wcoetnSvwpo7XDVoq5+oVruSmysX
         xQW9iVJQxljcVB3bk6MlJnMHa2xberkn+nFStsbKFdZJCSIgxbnMDnGzNGrY19q84Yw6
         XOWRv/WPOxsrJP2qTvVjgZ0qxzibRjT80MFKejIIGO3l/da4E01zJzuPhxbZksmRS1od
         78fQ==
X-Gm-Message-State: AOAM531wLPspeL6ouim0O0m1t13T2TDhzWzL4+lnOHiXu8bjfZXt3W+G
        OfgNu+fLhrkyp65Pbf/k5bYwaD1YHXE=
X-Google-Smtp-Source: ABdhPJz32oazMNe3wlp0q6FpQDwb2PX5Xb5qk9yNIcHcCeuIKNwpHmlSOP9joOOtUDAgBRo1uET8/g==
X-Received: by 2002:a17:907:3fa4:b0:6fe:b83b:d667 with SMTP id hr36-20020a1709073fa400b006feb83bd667mr25618262ejc.481.1654599871163;
        Tue, 07 Jun 2022 04:04:31 -0700 (PDT)
Received: from localhost (92.40.203.141.threembb.co.uk. [92.40.203.141])
        by smtp.gmail.com with ESMTPSA id ft29-20020a170907801d00b0071145c2f494sm3726424ejc.27.2022.06.07.04.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 04:04:30 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     paul@crapouillou.net, linus.walleij@linaro.org
Cc:     linux-mips@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] pinctrl: ingenic: Convert to immutable irq chip
Date:   Tue,  7 Jun 2022 12:05:25 +0100
Message-Id: <20220607110525.36922-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the driver to use an immutable IRQ chip to fix this warning:

    "not an immutable chip, please consider fixing it!"

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/pinctrl/pinctrl-ingenic.c | 33 ++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-ingenic.c b/drivers/pinctrl/pinctrl-ingenic.c
index 1ca11616db74..37258fb05be3 100644
--- a/drivers/pinctrl/pinctrl-ingenic.c
+++ b/drivers/pinctrl/pinctrl-ingenic.c
@@ -135,7 +135,6 @@ struct ingenic_pinctrl {
 struct ingenic_gpio_chip {
 	struct ingenic_pinctrl *jzpc;
 	struct gpio_chip gc;
-	struct irq_chip irq_chip;
 	unsigned int irq, reg_base;
 };
 
@@ -3419,6 +3418,8 @@ static void ingenic_gpio_irq_enable(struct irq_data *irqd)
 	struct ingenic_gpio_chip *jzgc = gpiochip_get_data(gc);
 	int irq = irqd->hwirq;
 
+	gpiochip_enable_irq(gc, irq);
+
 	if (is_soc_or_above(jzgc->jzpc, ID_JZ4770))
 		ingenic_gpio_set_bit(jzgc, JZ4770_GPIO_INT, irq, true);
 	else if (is_soc_or_above(jzgc->jzpc, ID_JZ4740))
@@ -3443,6 +3444,8 @@ static void ingenic_gpio_irq_disable(struct irq_data *irqd)
 		ingenic_gpio_set_bit(jzgc, JZ4740_GPIO_SELECT, irq, false);
 	else
 		ingenic_gpio_set_bit(jzgc, JZ4730_GPIO_GPIER, irq, false);
+
+	gpiochip_disable_irq(gc, irq);
 }
 
 static void ingenic_gpio_irq_ack(struct irq_data *irqd)
@@ -3684,6 +3687,20 @@ static void ingenic_gpio_irq_release(struct irq_data *data)
 	return gpiochip_relres_irq(gpio_chip, data->hwirq);
 }
 
+static const struct irq_chip ingenic_gpio_irqchip = {
+	.name			= "gpio",
+	.irq_enable		= ingenic_gpio_irq_enable,
+	.irq_disable		= ingenic_gpio_irq_disable,
+	.irq_unmask		= ingenic_gpio_irq_unmask,
+	.irq_mask		= ingenic_gpio_irq_mask,
+	.irq_ack		= ingenic_gpio_irq_ack,
+	.irq_set_type		= ingenic_gpio_irq_set_type,
+	.irq_set_wake		= ingenic_gpio_irq_set_wake,
+	.irq_request_resources	= ingenic_gpio_irq_request,
+	.irq_release_resources	= ingenic_gpio_irq_release,
+	.flags			= IRQCHIP_MASK_ON_SUSPEND | IRQCHIP_IMMUTABLE,
+};
+
 static int ingenic_pinmux_set_pin_fn(struct ingenic_pinctrl *jzpc,
 		int pin, int func)
 {
@@ -4172,20 +4189,8 @@ static int __init ingenic_gpio_probe(struct ingenic_pinctrl *jzpc,
 	if (!jzgc->irq)
 		return -EINVAL;
 
-	jzgc->irq_chip.name = jzgc->gc.label;
-	jzgc->irq_chip.irq_enable = ingenic_gpio_irq_enable;
-	jzgc->irq_chip.irq_disable = ingenic_gpio_irq_disable;
-	jzgc->irq_chip.irq_unmask = ingenic_gpio_irq_unmask;
-	jzgc->irq_chip.irq_mask = ingenic_gpio_irq_mask;
-	jzgc->irq_chip.irq_ack = ingenic_gpio_irq_ack;
-	jzgc->irq_chip.irq_set_type = ingenic_gpio_irq_set_type;
-	jzgc->irq_chip.irq_set_wake = ingenic_gpio_irq_set_wake;
-	jzgc->irq_chip.irq_request_resources = ingenic_gpio_irq_request;
-	jzgc->irq_chip.irq_release_resources = ingenic_gpio_irq_release;
-	jzgc->irq_chip.flags = IRQCHIP_MASK_ON_SUSPEND;
-
 	girq = &jzgc->gc.irq;
-	girq->chip = &jzgc->irq_chip;
+	gpio_irq_chip_set_chip(girq, &ingenic_gpio_irqchip);
 	girq->parent_handler = ingenic_gpio_irq_handler;
 	girq->num_parents = 1;
 	girq->parents = devm_kcalloc(dev, 1, sizeof(*girq->parents),
-- 
2.35.1

