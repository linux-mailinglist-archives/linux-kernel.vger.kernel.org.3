Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A741054F782
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 14:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382342AbiFQM2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 08:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382197AbiFQM2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 08:28:05 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989B219C2D;
        Fri, 17 Jun 2022 05:28:01 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id eo8so6031104edb.0;
        Fri, 17 Jun 2022 05:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6n/2pFzaPVH0G41YfmWwCvM9JbKPxBYICuNwYJcUzhA=;
        b=fxhyTLXRaQmjffcKebPAhrCz0/mBiSKvbvixB62cf8rYpxCrrWB3sLGzva5Uv3T0Jn
         U+g+S70QYfa0DqM10QWK/LtOF3nfKUn7tiL9lwwRH4OQ1g/nxTDz99ZpzglVnVIWQiIf
         WdkddcrkB/IhonbMcSBAJBgV00Txr5jwJud3+/mrxN/oCrohWHrSMC3YakheI5IVvyFs
         t9beg4gcrrsWJjPK7YnbBOXpbv+lPn/0iyoOuKSbnQ60FOkulzdnMafdFnp0fV3TcVTN
         T1bblB/Hs+jV8rL8vC/814vWkNNPTzQazsEjHWlRxudbDBl+kRlup6gUshlgf3iqgmz1
         azwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6n/2pFzaPVH0G41YfmWwCvM9JbKPxBYICuNwYJcUzhA=;
        b=tAMqP1oDPKNuR9Bb0jZf5bOFTWKWzA666Dqff0d2NDEGP0d2xZZo3XSkM66/JePK/+
         FgaAsxVxJC8VBk4t/apATQyl/d59XkYPbmyZzCqN7kbH3W4clPo/vVq5wernmRUwfvKR
         L47/3M3c4GBCWObCUhzk5HpQw9WLywFB7X4FFJ7nEoH5P9mYJ6/MzUs4DaPlpGcWQinz
         6KAsQ08ouyXxQ4GQFpq8VDHrw+wcuKJSreaa2bsyvmOlM7EyP/Y99BjpSet3u0OQ1Ide
         eCQBcQqzErvLzNDJuirXGZ6bsy3/mvnXTHm7/FWf6+7rn3abNVMmXp1wSKppQ36vPN/r
         VPrw==
X-Gm-Message-State: AJIora/u8WMEs/PDj2WQPyIJB7pTh7ubkb9aCistAshb+UaPAqEmhSJ/
        caGpSWm58TlbKh/6/qDryDQ=
X-Google-Smtp-Source: AGRyM1vqbq5YK6BFxrltot0aDVi3HLTVaJltTlM/iLoLlIzIMjxdHKy2O657RN12iRQ7fUpbzwnuIw==
X-Received: by 2002:a05:6402:3482:b0:42d:e063:7c1d with SMTP id v2-20020a056402348200b0042de0637c1dmr12337169edc.40.1655468880253;
        Fri, 17 Jun 2022 05:28:00 -0700 (PDT)
Received: from localhost (92.40.168.194.threembb.co.uk. [92.40.168.194])
        by smtp.gmail.com with ESMTPSA id e7-20020a50ec87000000b0043561e0c9adsm1032499edr.52.2022.06.17.05.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 05:27:59 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     linus.walleij@linaro.org, paul@crapouillou.net
Cc:     maz@kernel.org, andy.shevchenko@gmail.com,
        linux-mips@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] pinctrl: ingenic: Convert to immutable irq chip
Date:   Fri, 17 Jun 2022 13:28:55 +0100
Message-Id: <20220617122855.739190-3-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220617122855.739190-1-aidanmacdonald.0x0@gmail.com>
References: <20220617122855.739190-1-aidanmacdonald.0x0@gmail.com>
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

Preserve per-chip labels by adding an irq_print_chip callback.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/pinctrl/pinctrl-ingenic.c | 41 ++++++++++++++++++++-----------
 1 file changed, 27 insertions(+), 14 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-ingenic.c b/drivers/pinctrl/pinctrl-ingenic.c
index 69e0d88665d3..787a8daa400e 100644
--- a/drivers/pinctrl/pinctrl-ingenic.c
+++ b/drivers/pinctrl/pinctrl-ingenic.c
@@ -22,6 +22,7 @@
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
+#include <linux/seq_file.h>
 
 #include "core.h"
 #include "pinconf.h"
@@ -135,7 +136,6 @@ struct ingenic_pinctrl {
 struct ingenic_gpio_chip {
 	struct ingenic_pinctrl *jzpc;
 	struct gpio_chip gc;
-	struct irq_chip irq_chip;
 	unsigned int irq, reg_base;
 };
 
@@ -3419,6 +3419,8 @@ static void ingenic_gpio_irq_enable(struct irq_data *irqd)
 	struct ingenic_gpio_chip *jzgc = gpiochip_get_data(gc);
 	irq_hw_number_t irq = irqd_to_hwirq(irqd);
 
+	gpiochip_enable_irq(gc, irq);
+
 	if (is_soc_or_above(jzgc->jzpc, ID_JZ4770))
 		ingenic_gpio_set_bit(jzgc, JZ4770_GPIO_INT, irq, true);
 	else if (is_soc_or_above(jzgc->jzpc, ID_JZ4740))
@@ -3443,6 +3445,8 @@ static void ingenic_gpio_irq_disable(struct irq_data *irqd)
 		ingenic_gpio_set_bit(jzgc, JZ4740_GPIO_SELECT, irq, false);
 	else
 		ingenic_gpio_set_bit(jzgc, JZ4730_GPIO_GPIER, irq, false);
+
+	gpiochip_disable_irq(gc, irq);
 }
 
 static void ingenic_gpio_irq_ack(struct irq_data *irqd)
@@ -3687,6 +3691,27 @@ static void ingenic_gpio_irq_release(struct irq_data *data)
 	return gpiochip_relres_irq(gpio_chip, irq);
 }
 
+static void ingenic_gpio_irq_print_chip(struct irq_data *data, struct seq_file *p)
+{
+	struct gpio_chip *gpio_chip = irq_data_get_irq_chip_data(data);
+
+	seq_printf(p, "%s", gpio_chip->label);
+}
+
+static const struct irq_chip ingenic_gpio_irqchip = {
+	.irq_enable		= ingenic_gpio_irq_enable,
+	.irq_disable		= ingenic_gpio_irq_disable,
+	.irq_unmask		= ingenic_gpio_irq_unmask,
+	.irq_mask		= ingenic_gpio_irq_mask,
+	.irq_ack		= ingenic_gpio_irq_ack,
+	.irq_set_type		= ingenic_gpio_irq_set_type,
+	.irq_set_wake		= ingenic_gpio_irq_set_wake,
+	.irq_request_resources	= ingenic_gpio_irq_request,
+	.irq_release_resources	= ingenic_gpio_irq_release,
+	.irq_print_chip		= ingenic_gpio_irq_print_chip,
+	.flags			= IRQCHIP_MASK_ON_SUSPEND | IRQCHIP_IMMUTABLE,
+};
+
 static int ingenic_pinmux_set_pin_fn(struct ingenic_pinctrl *jzpc,
 		int pin, int func)
 {
@@ -4175,20 +4200,8 @@ static int __init ingenic_gpio_probe(struct ingenic_pinctrl *jzpc,
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

