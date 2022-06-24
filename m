Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FFA055A22D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 21:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbiFXTvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 15:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbiFXTvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 15:51:18 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36CC07FD24;
        Fri, 24 Jun 2022 12:51:16 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id ej4so4873753edb.7;
        Fri, 24 Jun 2022 12:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IlyhdFMImGeb91lejRrs7vQ8r+23EDsm+NrRwbaFfRE=;
        b=enHeReQVjJ/UJTqaKyFAhtCBoqIf4KF5UPWDs6zNR4rPduhPJrYpKY1MwhZV4RXVOK
         vKyBgy8GeEju7Jv6VV67X+bNvMQOxX6V7idVurYMSaGWHnrAgobi1e1XXJWPkqFKirIj
         2gz0IDsUJWHJt2ZNg67fZY+7FRNOM3VtG+42JJj5DAwrqo9fzTwRRpyinlB8N4oTIbNq
         Z9B8tl0htTaROmO6eo2pTduVeOHQy3Sqa/VlIGvLv+HRP2A20pTEFggtwNKXKVZqw7Zb
         AwYpkS74KAXhX2x35AJFPxgD/mFnkmN0TRilXOKqyTjzm3QEUwgB2zSYm+Ai7JUJgFBT
         D19Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IlyhdFMImGeb91lejRrs7vQ8r+23EDsm+NrRwbaFfRE=;
        b=NoXtdAJ+5BISl2RR7r25pCQoHoAaQbvCck0Zo+0cbptduaZb7vawxUArBLrwOcb7Ny
         aNRR7lT6A3hJh1z3MiBjjrwac3yBq8e132fVh+bKbiMScnhr1DU6T0dCNelXTWZLgf1V
         oTrN9jGr/XlJZmLQ2AgD6hB+xS5C0uCQAI2pB8KJ4MJzvlCamIry+aLYWjyu44r9ycgz
         pYAy1lCSTeAUCjF1XrSeqpvThH2sfxlVfeiB7+IDEl47fcww3v+M25r/WFELysLmFw/Z
         WmOYIIrqlOK49NaMVf2q71rBM8/pp4Hqj3pr2kehhkRn1oL5Gl1v53DAtF1BCHTtgyWu
         4WGA==
X-Gm-Message-State: AJIora8i3arYmZXF9HRFA9OqtQxuZIvNMguIk8usJkyALuZEk8L7MiiG
        Xn6pPzPJqOfbZ15jD3lUsfg=
X-Google-Smtp-Source: AGRyM1tqs6Ke+BiFNzHottRZZOBZEqN8+W2JhAZk/a1fKvA9kbXP2z0IsZAy0X5EFEu3cOHTZ2UVvA==
X-Received: by 2002:aa7:dad6:0:b0:435:7a44:7480 with SMTP id x22-20020aa7dad6000000b004357a447480mr981415eds.138.1656100274625;
        Fri, 24 Jun 2022 12:51:14 -0700 (PDT)
Received: from fedora.robimarko.hr (dh207-98-60.xnet.hr. [88.207.98.60])
        by smtp.googlemail.com with ESMTPSA id jz27-20020a17090775fb00b007246492658asm1586316ejc.117.2022.06.24.12.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 12:51:14 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     bjorn.andersson@linaro.org, agross@kernel.org,
        linus.walleij@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH] pinctrl: qcom: spmi-gpio: make the irqchip immutable
Date:   Fri, 24 Jun 2022 21:51:12 +0200
Message-Id: <20220624195112.894916-1-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 6c846d026d49 ("gpio: Don't fiddle with irqchips marked as
immutable") added a warning to indicate if the gpiolib is altering the
internals of irqchips.

Following this change the following warning is now observed for the SPMI
PMIC pinctrl driver:
gpio gpiochip1: (200f000.spmi:pmic@0:gpio@c000): not an immutable chip, please consider fixing it!

Fix this by making the irqchip in the SPMI PMIC pinctrl driver immutable.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
index c3255b0bece4..406ee0933d0b 100644
--- a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
+++ b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
@@ -171,7 +171,6 @@ struct pmic_gpio_state {
 	struct regmap	*map;
 	struct pinctrl_dev *ctrl;
 	struct gpio_chip chip;
-	struct irq_chip irq;
 	u8 usid;
 	u8 pid_base;
 };
@@ -988,6 +987,17 @@ static void *pmic_gpio_populate_parent_fwspec(struct gpio_chip *chip,
 	return fwspec;
 }
 
+static const struct irq_chip spmi_gpio_irq_chip = {
+	.name		= "spmi-gpio",
+	.irq_ack	= irq_chip_ack_parent,
+	.irq_mask	= irq_chip_mask_parent,
+	.irq_unmask	= irq_chip_unmask_parent,
+	.irq_set_type	= irq_chip_set_type_parent,
+	.irq_set_wake	= irq_chip_set_wake_parent,
+	.flags		= IRQCHIP_IMMUTABLE | IRQCHIP_MASK_ON_SUSPEND,
+	GPIOCHIP_IRQ_RESOURCE_HELPERS,
+};
+
 static int pmic_gpio_probe(struct platform_device *pdev)
 {
 	struct irq_domain *parent_domain;
@@ -1081,16 +1091,8 @@ static int pmic_gpio_probe(struct platform_device *pdev)
 	if (!parent_domain)
 		return -ENXIO;
 
-	state->irq.name = "spmi-gpio",
-	state->irq.irq_ack = irq_chip_ack_parent,
-	state->irq.irq_mask = irq_chip_mask_parent,
-	state->irq.irq_unmask = irq_chip_unmask_parent,
-	state->irq.irq_set_type = irq_chip_set_type_parent,
-	state->irq.irq_set_wake = irq_chip_set_wake_parent,
-	state->irq.flags = IRQCHIP_MASK_ON_SUSPEND,
-
 	girq = &state->chip.irq;
-	girq->chip = &state->irq;
+	gpio_irq_chip_set_chip(girq, &spmi_gpio_irq_chip);
 	girq->default_type = IRQ_TYPE_NONE;
 	girq->handler = handle_level_irq;
 	girq->fwnode = of_node_to_fwnode(state->dev->of_node);
-- 
2.36.1

