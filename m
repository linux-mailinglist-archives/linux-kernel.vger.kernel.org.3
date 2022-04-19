Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7531E507026
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 16:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353178AbiDSOWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 10:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353062AbiDSOVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 10:21:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF6C418E1A;
        Tue, 19 Apr 2022 07:19:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C3F5616F5;
        Tue, 19 Apr 2022 14:19:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91D50C385AC;
        Tue, 19 Apr 2022 14:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650377942;
        bh=/Tv8YiZnHlnoLZidVUOvPcgdyia12qeZDRAWgWjsabA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KAu3Pn+xbkLIlxtVtXB0W0q/XCiFwNqjlCUc+F79hxhaG2Wen42McLvhQ5QaGDJNy
         i6OXTBUgUDwfeny6gZDgBHYvcKg003/DnJbdvWXyCkeM/xKRmTb4S+QzXBfaKV+L+F
         oBw8GhiiAuk92RPQdlqSqjPmf83HO1fE2Sg5Qvo5Y4TEIWVW6lRnLjPHOkRaBzlBqR
         st2GSm5Jl6slSUWiuSeGoMSlhXB7/3q301TCNhvc1qO1VGwk59qKzW9jYf/Kwc/Ar4
         9fRxBXR23Fvskp9wKdsBWRIoqoX2raimHy4yQ9VfMrjg8iH1q2fAQopMH65okd/Pn+
         1jy9kuN60UgVA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1ngoh2-005MFS-IJ; Tue, 19 Apr 2022 15:19:00 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Thierry Reding <thierry.reding@gmail.com>,
        Joey Gouly <joey.gouly@arm.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-gpio@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, kernel-team@android.com
Subject: [PATCH v3 07/10] pinctrl: msmgpio: Make the irqchip immutable
Date:   Tue, 19 Apr 2022 15:18:43 +0100
Message-Id: <20220419141846.598305-8-maz@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220419141846.598305-1-maz@kernel.org>
References: <20220419141846.598305-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linus.walleij@linaro.org, brgl@bgdev.pl, thierry.reding@gmail.com, joey.gouly@arm.com, jonathanh@nvidia.com, marcan@marcan.st, sven@svenpeter.dev, alyssa@rosenzweig.io, bjorn.andersson@linaro.org, agross@kernel.org, jeffrey.l.hugo@gmail.com, tglx@linutronix.de, Basavaraj.Natikar@amd.com, Shyam-sundar.S-k@amd.com, andy.shevchenko@gmail.com, linux-gpio@vger.kernel.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prevent gpiolib from messing with the irqchip by advertising
the irq_chip structure as immutable, making it const, and adding
the various calls that gpiolib relies upon.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/pinctrl/qcom/pinctrl-msm.c | 53 +++++++++++++++++++-----------
 1 file changed, 33 insertions(+), 20 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index 966ea6622ff3..a2abfe987ab1 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -42,7 +42,6 @@
  * @chip:           gpiochip handle.
  * @desc:           pin controller descriptor
  * @restart_nb:     restart notifier block.
- * @irq_chip:       irq chip information
  * @irq:            parent irq for the TLMM irq_chip.
  * @intr_target_use_scm: route irq to application cpu using scm calls
  * @lock:           Spinlock to protect register resources as well
@@ -63,7 +62,6 @@ struct msm_pinctrl {
 	struct pinctrl_desc desc;
 	struct notifier_block restart_nb;
 
-	struct irq_chip irq_chip;
 	int irq;
 
 	bool intr_target_use_scm;
@@ -868,6 +866,8 @@ static void msm_gpio_irq_enable(struct irq_data *d)
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 	struct msm_pinctrl *pctrl = gpiochip_get_data(gc);
 
+	gpiochip_enable_irq(gc, d->hwirq);
+
 	if (d->parent_data)
 		irq_chip_enable_parent(d);
 
@@ -885,6 +885,8 @@ static void msm_gpio_irq_disable(struct irq_data *d)
 
 	if (!test_bit(d->hwirq, pctrl->skip_wake_irqs))
 		msm_gpio_irq_mask(d);
+
+	gpiochip_disable_irq(gc, d->hwirq);
 }
 
 /**
@@ -958,6 +960,14 @@ static void msm_gpio_irq_ack(struct irq_data *d)
 	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
 }
 
+static void msm_gpio_irq_eoi(struct irq_data *d)
+{
+	d = d->parent_data;
+
+	if (d)
+		d->chip->irq_eoi(d);
+}
+
 static bool msm_gpio_needs_dual_edge_parent_workaround(struct irq_data *d,
 						       unsigned int type)
 {
@@ -1255,6 +1265,26 @@ static bool msm_gpio_needs_valid_mask(struct msm_pinctrl *pctrl)
 	return device_property_count_u16(pctrl->dev, "gpios") > 0;
 }
 
+static const struct irq_chip msm_gpio_irq_chip = {
+	.name			= "msmgpio",
+	.irq_enable		= msm_gpio_irq_enable,
+	.irq_disable		= msm_gpio_irq_disable,
+	.irq_mask		= msm_gpio_irq_mask,
+	.irq_unmask		= msm_gpio_irq_unmask,
+	.irq_ack		= msm_gpio_irq_ack,
+	.irq_eoi		= msm_gpio_irq_eoi,
+	.irq_set_type		= msm_gpio_irq_set_type,
+	.irq_set_wake		= msm_gpio_irq_set_wake,
+	.irq_request_resources	= msm_gpio_irq_reqres,
+	.irq_release_resources	= msm_gpio_irq_relres,
+	.irq_set_affinity	= msm_gpio_irq_set_affinity,
+	.irq_set_vcpu_affinity	= msm_gpio_irq_set_vcpu_affinity,
+	.flags			= (IRQCHIP_MASK_ON_SUSPEND |
+				   IRQCHIP_SET_TYPE_MASKED |
+				   IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND |
+				   IRQCHIP_IMMUTABLE),
+};
+
 static int msm_gpio_init(struct msm_pinctrl *pctrl)
 {
 	struct gpio_chip *chip;
@@ -1276,22 +1306,6 @@ static int msm_gpio_init(struct msm_pinctrl *pctrl)
 	if (msm_gpio_needs_valid_mask(pctrl))
 		chip->init_valid_mask = msm_gpio_init_valid_mask;
 
-	pctrl->irq_chip.name = "msmgpio";
-	pctrl->irq_chip.irq_enable = msm_gpio_irq_enable;
-	pctrl->irq_chip.irq_disable = msm_gpio_irq_disable;
-	pctrl->irq_chip.irq_mask = msm_gpio_irq_mask;
-	pctrl->irq_chip.irq_unmask = msm_gpio_irq_unmask;
-	pctrl->irq_chip.irq_ack = msm_gpio_irq_ack;
-	pctrl->irq_chip.irq_set_type = msm_gpio_irq_set_type;
-	pctrl->irq_chip.irq_set_wake = msm_gpio_irq_set_wake;
-	pctrl->irq_chip.irq_request_resources = msm_gpio_irq_reqres;
-	pctrl->irq_chip.irq_release_resources = msm_gpio_irq_relres;
-	pctrl->irq_chip.irq_set_affinity = msm_gpio_irq_set_affinity;
-	pctrl->irq_chip.irq_set_vcpu_affinity = msm_gpio_irq_set_vcpu_affinity;
-	pctrl->irq_chip.flags = IRQCHIP_MASK_ON_SUSPEND |
-				IRQCHIP_SET_TYPE_MASKED |
-				IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND;
-
 	np = of_parse_phandle(pctrl->dev->of_node, "wakeup-parent", 0);
 	if (np) {
 		chip->irq.parent_domain = irq_find_matching_host(np,
@@ -1300,7 +1314,6 @@ static int msm_gpio_init(struct msm_pinctrl *pctrl)
 		if (!chip->irq.parent_domain)
 			return -EPROBE_DEFER;
 		chip->irq.child_to_parent_hwirq = msm_gpio_wakeirq;
-		pctrl->irq_chip.irq_eoi = irq_chip_eoi_parent;
 		/*
 		 * Let's skip handling the GPIOs, if the parent irqchip
 		 * is handling the direct connect IRQ of the GPIO.
@@ -1313,7 +1326,7 @@ static int msm_gpio_init(struct msm_pinctrl *pctrl)
 	}
 
 	girq = &chip->irq;
-	girq->chip = &pctrl->irq_chip;
+	gpio_irq_chip_set_chip(girq, &msm_gpio_irq_chip);
 	girq->parent_handler = msm_gpio_irq_handler;
 	girq->fwnode = pctrl->dev->fwnode;
 	girq->num_parents = 1;
-- 
2.34.1

