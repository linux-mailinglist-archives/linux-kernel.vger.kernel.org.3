Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77BF255538E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 20:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377225AbiFVSt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 14:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376918AbiFVStR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 14:49:17 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60BC31917;
        Wed, 22 Jun 2022 11:49:15 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id o8so24706309wro.3;
        Wed, 22 Jun 2022 11:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DqFQG0CU8wtdroHFAZ6bAEVb5kwNC8YHs7EBfsOyGTE=;
        b=dkGTYPc1bdYnSwGmeGjAEVF250w9M54Jr41s7xjjWmr1xoijLuaMIuTcb2t/eM35w6
         HtlesbcBnA1t7vg6OptOG9oQ9X4j0pt5K+2k9/tDM5usGv1h4s3ErM+um0RuMdRY/Spm
         R6IP2blAreFB1gSVp8T9iNdzucCIhcCY7C06RtESae+iE3xAAKiEDn9DNF1nUXxv9QHK
         8RX2/hID9p695bZgAWgCTKegqssjF0dgGyQ8ycnC4CLFoQ2mSWFidn3Zcj+Zs4Bwu0Hu
         e/ZSr50H183t5LPZ4SeCbHj5A4vOYppCgx4tiqrCfrin06OtWwV8tP9aOCojjtkoFx3O
         w9Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DqFQG0CU8wtdroHFAZ6bAEVb5kwNC8YHs7EBfsOyGTE=;
        b=FXZ1IbxE6DOPrywf0GNR7jnil8mSg/wnkq4zq6L+2WTgnMvJrOij4Fog7pPDEqBIfM
         iVMPhjwmT0dkvO5IDabl+hdInZECbYcsqWuzcj8BEOg/n2T4OtBfA0/SmpjFjXYG5E/B
         4dJB23WgVnMXvIrZ4Nj/MLmxav9ryRymqJ00BZxXLydJbCOR7mSLFvZ6kZQbHUsn6BKd
         HSpz91yj1N4qL3LMNPYUhATNmWSQH9uLwHzhsM+s8LDrREg8hFXNE8HUuDDAGLdiQBCx
         EjdnNLhGWuo1C8xXRZuJEmLrWAVRpL7Ub2pqOVkebBst4sJq/hhn2+mow+37Sexu1qWN
         kHBg==
X-Gm-Message-State: AJIora+hfNx3nXc8abSxnV/6jejxFv2mUJQ+MqCrchCv72xwCNjfjw4O
        l6TosR9vHe2mQy69FArYyok=
X-Google-Smtp-Source: AGRyM1vkB15KESXtruheH66NvVNQPfrMR+Ebv7PozqjW0fgpTFmRvOOMoCed61LAjw+FsF1ZtIW/XA==
X-Received: by 2002:a5d:4e83:0:b0:21b:9dee:d109 with SMTP id e3-20020a5d4e83000000b0021b9deed109mr4859661wru.430.1655923754540;
        Wed, 22 Jun 2022 11:49:14 -0700 (PDT)
Received: from localhost (92.40.170.233.threembb.co.uk. [92.40.170.233])
        by smtp.gmail.com with ESMTPSA id 1-20020a05600c248100b0039c5ab7167dsm177431wms.48.2022.06.22.11.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 11:49:13 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     linus.walleij@linaro.org
Cc:     paul@crapouillou.net, maz@kernel.org, andy.shevchenko@gmail.com,
        linux-mips@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] pinctrl: ingenic: Convert to immutable irq chip
Date:   Wed, 22 Jun 2022 19:50:10 +0100
Message-Id: <20220622185010.2022515-3-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220622185010.2022515-1-aidanmacdonald.0x0@gmail.com>
References: <20220622185010.2022515-1-aidanmacdonald.0x0@gmail.com>
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

Preserve per-chip labels by adding an ->irq_print_chip() callback.

Acked-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Paul Cercueil <paul@crapouillou.net>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/pinctrl/pinctrl-ingenic.c | 41 ++++++++++++++++++++-----------
 1 file changed, 27 insertions(+), 14 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-ingenic.c b/drivers/pinctrl/pinctrl-ingenic.c
index 69e0d88665d3..3a9ee9c8af11 100644
--- a/drivers/pinctrl/pinctrl-ingenic.c
+++ b/drivers/pinctrl/pinctrl-ingenic.c
@@ -21,6 +21,7 @@
 #include <linux/pinctrl/pinconf-generic.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
+#include <linux/seq_file.h>
 #include <linux/slab.h>
 
 #include "core.h"
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

