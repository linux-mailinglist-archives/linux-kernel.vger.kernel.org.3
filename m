Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6915D5A5F49
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 11:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbiH3JXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 05:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231818AbiH3JXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 05:23:15 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC2C64D4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 02:22:44 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id j5so6642816plj.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 02:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=+U60seGTOydiyz6oR/jREabSqhPquiKvw8g0tMTrRtQ=;
        b=zIxXa2VH8ANmX3KY1/XhZRyRzuHTetN5tp0wgh8FcMfB9/B5snNt+j861IJKnJbBEA
         eCFdx+aljfu0y4Y4yNucOfsPFYbSpn69PqjFuNsqYjOFY7CP1aRH8mLhPwdeC8ygX0LY
         YsZqlIWu4ScClRyQ+TssKCAejiJGqiMh1x+o3zx/2X02cLisN3jP5UBk3BzfPw/1JiZr
         LQOSQsVkc7dHSFHOBMfK/i4CoRTJuVyAUrumx/P9WrwDfNx33nPpDKNqYAzV5j6vtsI4
         FpIFQ0o0YGrRvHJ3TIgwnBpBOjEH2b58hPMVHCbc21rXft153Xh0VDiisPr4Ssn3RVWb
         pEMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=+U60seGTOydiyz6oR/jREabSqhPquiKvw8g0tMTrRtQ=;
        b=QYaYRpUpvf02sMy8doz/2+Szv66lLtlX+Kacf2DrM2Y6NdgxIv2+lwFkx1dKALHplZ
         kEdwBzyBzPDHHQufyOxtEt7i4sxTRgQKgiBxr137IlzdDibddWtR/9RfFlgchTzn69Yg
         /0TI9plWFgJjRfS7SHGOgSgTItaTNTQcp/XjGUWav6xOPbFf2Itu9rKiChbtliVHVOQn
         ZgnzHOhGZ/ObMaSNlxPmV4ZL/ThRCx/2npguBpkGZ/iOAMcBFNjW/jOIIGy1jGbWPFz7
         shy3hNbvibHnts3wiFD9YE8yeQ72BNoU3Lfs2SQ24M3DS55qF5gx7bEHQzhMqCyRBMyk
         qNEQ==
X-Gm-Message-State: ACgBeo30vBHlZM4mbWCY6aW4uxUqOOAUAMh2wOQ+y7I3MezVt2+yfklp
        jt1t5IWuHWCPipoTAglXMQfN
X-Google-Smtp-Source: AA6agR5DWSeVAOgb/ctNGxABzCisuwfrKRzfZSHb7Bh07cx8KRIQ+4N8eJrXcWPL1CD/wBhawBtejA==
X-Received: by 2002:a17:903:41c6:b0:174:3acf:8294 with SMTP id u6-20020a17090341c600b001743acf8294mr19851863ple.118.1661851364086;
        Tue, 30 Aug 2022 02:22:44 -0700 (PDT)
Received: from localhost.localdomain ([117.193.209.245])
        by smtp.gmail.com with ESMTPSA id f17-20020a170902ab9100b0016dc78d0153sm9094488plr.296.2022.08.30.02.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 02:22:43 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     linus.walleij@linaro.org, bjorn.andersson@linaro.org
Cc:     robimarko@gmail.com, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        maz@kernel.org, johan+linaro@kernel.org, steev@kali.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3] pinctrl: qcom: spmi-gpio: Make irqchip immutable
Date:   Tue, 30 Aug 2022 14:52:32 +0530
Message-Id: <20220830092232.168561-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The irqchip implementation used inside the gpiochips are not supposed to
be changed during runtime. So let's make the one inside the spmi-gpio
gpiochip immutable.

This fixes the below warning during boot:
gpio gpiochip0: (c440000.spmi:pmic@0:gpio@c000): not an immutable chip, please consider fixing it!

Acked-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---

Changes in v3:

* Added Ack from Marc
* Removed the text that was mimicking the documentation

Changes in v2:

* Added new callbacks for irq_{mask/unmask} for masking/unmasking the parent
  IRQ that was missing in v1. (Thanks to Marc)
* Modified the commit message accordingly.

 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c | 38 +++++++++++++++++-------
 1 file changed, 28 insertions(+), 10 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
index ccaf40a9c0e6..d40e3b2d38cc 100644
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
@@ -985,6 +984,33 @@ static int pmic_gpio_populate_parent_fwspec(struct gpio_chip *chip,
 	return 0;
 }
 
+static void pmic_gpio_irq_mask(struct irq_data *data)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(data);
+
+	irq_chip_mask_parent(data);
+	gpiochip_disable_irq(gc, data->hwirq);
+}
+
+static void pmic_gpio_irq_unmask(struct irq_data *data)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(data);
+
+	irq_chip_unmask_parent(data);
+	gpiochip_enable_irq(gc, data->hwirq);
+}
+
+static const struct irq_chip spmi_gpio_irq_chip = {
+	.name		= "spmi-gpio",
+	.irq_ack	= irq_chip_ack_parent,
+	.irq_mask	= pmic_gpio_irq_mask,
+	.irq_unmask	= pmic_gpio_irq_unmask,
+	.irq_set_type	= irq_chip_set_type_parent,
+	.irq_set_wake	= irq_chip_set_wake_parent,
+	.flags		= IRQCHIP_IMMUTABLE | IRQCHIP_MASK_ON_SUSPEND,
+	GPIOCHIP_IRQ_RESOURCE_HELPERS,
+};
+
 static int pmic_gpio_probe(struct platform_device *pdev)
 {
 	struct irq_domain *parent_domain;
@@ -1078,16 +1104,8 @@ static int pmic_gpio_probe(struct platform_device *pdev)
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
2.25.1

